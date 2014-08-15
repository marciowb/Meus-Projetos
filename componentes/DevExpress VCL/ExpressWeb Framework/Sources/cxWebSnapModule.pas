{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Web Snap Support                                            }
{                                                                   }
{       Copyright (c) 2000-2010 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSWEB FRAMEWORK AND ALL         }
{   ACCOMPANYING VCL CLASSES AS PART OF AN EXECUTABLE WEB           }
{   APPLICATION ONLY.                                               }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}
unit cxWebSnapModule;

{$I cxVer.inc}

{$IFDEF DELPHI7}
  {$DEFINE USESCRIPTENGINE}
{$ELSE}
  {$IFNDEF VCL}
    {$DEFINE USESCRIPTENGINE}
  {$ENDIF}
{$ENDIF}

interface

uses
  SysUtils, Classes, HTTPApp, HTTPProd, SiteComp, WebComp,
  cxWebModule, cxWebIntf;

type
  TcxWebSnapProducer = class(TComponent, IProduceContentFrom)
  private
    FModule: TComponent;
  protected
    {IProduceContentFrom}
    function ProduceContentFromStream(AStream: TStream): string;
    function ProduceContentFromString(const S: string): string;
  end;


  TcxWebSnapPageModule = class(TcxWebPageModule, IPageResult, INotifyWebActivate,
        IGetProducerComponent,{$IFNDEF USESCRIPTENGINE}IGetScriptObject,{$ENDIF} IDispatch,
        IWebVariableName, IWebVariablesContainer)
  private
    FProducer: TcxWebSnapProducer;

    function InternalFindVariable(const AName: string): TComponent;
  protected
    function IsInheritedModule: Boolean; override;
    { IPageResult }
    function DispatchPage(const APageName: string; AWebResponse: TWebResponse): Boolean;
    function IncludePage(const APageName: string; var AOwned: Boolean): TStream;
    function RedirectToPage(const APageName: string; AParams: TStrings; AWebResponse: TWebResponse): Boolean;
    { INotifyWebActivate }
    procedure NotifyActivate;
    procedure NotifyDeactivate;
    { IGetProducerComponent }
    function GetProducerComponent: TComponent;
    { IWebVariableName }
    function GetVariableName: string;
    { IWebVariablesContainer }
    function FindVariable(const AName: string): TComponent;
    function FindVariableContainer(const AName: string): TComponent;
    function GetVariableCount: Integer;
    function GetVariable(AIndex: Integer): TComponent;
    {$IFNDEF USESCRIPTENGINE}
    { IGetScriptObject }
    function GetScriptObject: IDispatch;
    {$ENDIF}
    {$IFDEF VCL}
    { IDispatch }
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
    {$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;


implementation

uses WebScript,
   {$IFDEF VCL}
   ActiveX, Windows,
   {$ENDIF}
   cxWebScript;

{ TcxWebSnapProducer }
function TcxWebSnapProducer.ProduceContentFromStream(AStream: TStream): string;
var
  {$IFDEF USESCRIPTENGINE}
  AOldScriptEnginesList: TAbstractScriptEnginesList;
  {$ELSE}
  AOldScriptProducerClass: TScriptProducerClass;
  {$ENDIF}
begin
  {$IFDEF USESCRIPTENGINE}
  if cxGetSaveScriptEnginesList <> nil then
  begin
    AOldScriptEnginesList := ScriptEnginesList;
    ScriptEnginesList := cxGetSaveScriptEnginesList;
  end else AOldScriptEnginesList := nil;
  {$ELSE}
  if cxGetSaveScriptProducerClass <> nil then
  begin
    AOldScriptProducerClass := ScriptProducerClass;
    ScriptProducerClass := cxGetSaveScriptProducerClass;
  end else AOldScriptProducerClass := nil;
  {$ENDIF}
  try
    Result := HttpProd.ContentFromScriptStream(AStream, FModule, True, nil, nil, 'JScript', nil);
  finally
    {$IFDEF USESCRIPTENGINE}
    if AOldScriptEnginesList <> nil then
      ScriptEnginesList := AOldScriptEnginesList;
    {$ELSE}
    if AOldScriptProducerClass <> nil then
      ScriptProducerClass := AOldScriptProducerClass;
    {$ENDIF}
  end;
end;

function TcxWebSnapProducer.ProduceContentFromString(const S: string): string;
var
  AStream: TStringStream;
begin
  AStream := TStringStream.Create(S);
  try
    Result := ProduceContentFromStream(AStream);
  finally
    AStream.Free;
  end;
end;

{ TcxWebSnapPageModule }
constructor TcxWebSnapPageModule.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FProducer := TcxWebSnapProducer.Create(nil);
  FProducer.FModule := self;
end;

destructor TcxWebSnapPageModule.Destroy;
begin
  FProducer.Free;
  inherited Destroy;
end;

function TcxWebSnapPageModule.IsInheritedModule: Boolean;
begin
  Result := (ClassType <> TcxWebSnapPageModule);
end;

function TcxWebSnapPageModule.DispatchPage(const APageName: string;
  AWebResponse: TWebResponse): Boolean;
var
  APage: IcxWebPage;
begin
  if Supports(self, IcxWebPage, APage) then
    Result := APage.DispatchPage(APageName, AWebResponse)
  else Result := False;
end;

function TcxWebSnapPageModule.IncludePage(const APageName: string;
  var AOwned: Boolean): TStream;
var
  APage: IcxWebPage;
begin
  if Supports(self, IcxWebPage, APage) then
    Result := APage.IncludePage(APageName, AOwned)
  else Result := nil;
end;

procedure TcxWebSnapPageModule.NotifyActivate;
var
  Intf: IcxWebModule;
begin
  if Supports(self, IcxWebModule, Intf) then
    Intf.Activate;
end;

procedure TcxWebSnapPageModule.NotifyDeactivate;
var
  Intf: IcxWebModule;
begin
  if Supports(self, IcxWebModule, Intf) then
    Intf.Deactivate;
end;

function TcxWebSnapPageModule.GetProducerComponent: TComponent;
begin
  Result := FProducer;
end;

function TcxWebSnapPageModule.InternalFindVariable(const AName: string): TComponent;
var
  I: Integer;
  AWebVariableName: IWebVariableName;
begin
  Result := nil;
  for I := 0 to ComponentCount - 1 do
    if Supports(Components[I], IWebVariableName, AWebVariableName) and
      (CompareText(AWebVariableName.VariableName, AName) = 0) then
    begin
      Result := Components[I];
      break;
    end;
  if (Result = nil) and SameText(Name, AName) then
    Result := self;
end;

function TcxWebSnapPageModule.GetVariableName: string;
begin
  Result := Name;
end;

function TcxWebSnapPageModule.FindVariable(const AName: string): TComponent;
begin
  Result := InternalFindVariable(AName);
end;

function TcxWebSnapPageModule.FindVariableContainer(const AName: string): TComponent;
begin
  Result := InternalFindVariable(AName);
  if (Result <> nil) and not Supports(Result, IWebVariablesContainer) then
    Result := nil;
end;

function TcxWebSnapPageModule.GetVariableCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to ComponentCount - 1 do
    if Supports(Components[I], IWebVariableName) then
      Inc(Result);
end;

function TcxWebSnapPageModule.GetVariable(AIndex: Integer): TComponent;
var
  I, J: Integer;
begin
  Result := nil;
  J := -1;
  for I := 0 to ComponentCount - 1 do
  begin
    if Supports(Components[I], IWebVariableName) then
      Inc(J);
    if J = AIndex then
    begin
      Result := Components[I];
      break;
    end;
  end;
end;

{$IFNDEF USESCRIPTENGINE}
function TcxWebSnapPageModule.GetScriptObject: IDispatch;
begin
  Result := self;
end;
{$ENDIF}

{$IFDEF VCL}
function TcxWebSnapPageModule.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK;
end;

function TcxWebSnapPageModule.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult;
begin
  Result := E_NOTIMPL;
end;

function TcxWebSnapPageModule.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
var
  I: Integer;
  AComponent: TComponent;
begin
  Result := S_OK;
  for I := 0 to NameCount - 1 do
  begin
    AComponent := FindVariable(POleStrList(Names)^[I]);
    if (AComponent = nil) and SameText(Name, POleStrList(Names)^[I]) then
      AComponent := self;
    if AComponent <> nil then
      PDispIDList(DispIDs)^[I] := Integer(AComponent)
    else
    begin
      Result := DISP_E_UNKNOWNNAME;
      break;
    end;
  end;
end;

function TcxWebSnapPageModule.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
  Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
var
  AGetScriptObject: IGetScriptObject;
begin
  if VarResult <> nil then
    VariantClear((POleVariant(VarResult))^);
  if (DispID <> 0) and Supports(TComponent(DispID), IGetScriptObject, AGetScriptObject) then
    POleVariant(VarResult)^ := AGetScriptObject.GetScriptObject;
  Result := S_OK;
end;
{$ENDIF}

function TcxWebSnapPageModule.RedirectToPage(const APageName: string;
  AParams: TStrings; AWebResponse: TWebResponse): Boolean;
var
  APage: IcxWebPage;
begin
  if Supports(self, IcxWebPage, APage) then
    Result := APage.RedirectToPage(APageName, AParams.Text, AWebResponse)
  else Result := False;
end;

end.
