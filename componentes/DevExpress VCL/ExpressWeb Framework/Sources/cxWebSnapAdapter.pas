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
unit cxWebSnapAdapter;

{$I cxVer.inc}

{$IFDEF DELPHI7}
  {$DEFINE USESCRIPTENGINE}
{$ELSE}
  {$IFNDEF VCL}
    {$DEFINE USESCRIPTENGINE}
  {$ENDIF}
{$ENDIF}

interface

uses Classes, SysUtils, WebForm, WebComp, MidItems,
  cxWebClasses, cxWebControls, cxWebRender, cxWebIntf;

type
  TcxWebSnapControlAdapter = class;

  TcxWebSnapControlRenderer = class(TcxWebRenderer)
  private
    FControlRequirements: TAbstractControlRequirements;

    function GetAdapter: TcxWebSnapControlAdapter;
    function GetWebSnapControl: TComponent;
    function GetControlRequirements: TAbstractControlRequirements;
    function GetVariables: TStrings;
    function GetGeneratedFunctions: TGeneratedFunctions;
    procedure GetRequirements(AComponent: TComponent);
    function PerformWebSnapServerScripts(ASource: string): string;
    function InternalScriptsRender: string; 
  protected
    property ControlRequirements: TAbstractControlRequirements read GetControlRequirements;
    property GeneratedFunctions: TGeneratedFunctions read GetGeneratedFunctions;
    property Variables: TStrings read GetVariables;
  public
    destructor Destroy; override;
    procedure WriteHTML; override;

    property WebSnapControl: TComponent read GetWebSnapControl;
    property Adapter: TcxWebSnapControlAdapter read GetAdapter;
  end;

  TcxWebSnapControlForm = class(TWebContainedContainerComponent, IHTMLForm)
  private
    FControl: TcxWebSnapControlAdapter;
  public
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
    function GetHTMLFormName: string;
    function GetHTMLFormVarName: string;
  end;

  TcxWebSnapControlAdapter = class(TcxWebControl, IcxDesignCodeProvider)
  private
    FWebSnapControl: TComponent;
    FWebSnapForm: TcxWebSnapControlForm;

    procedure SetWebSnapControl(Value: TComponent);
  protected
    procedure RegisterRenderers; override;
    procedure ScriptsSubscription; override;
    {IcxDesignCodeProvider}
    procedure WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
    function GetRendererClass: TcxWebRendererClass;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    class function IsWebSnapControlSupported(AComponent: TComponent): Boolean;

    property WebSnapForm: TcxWebSnapControlForm read FWebSnapForm;
  published
    property WebSnapControl: TComponent read FWebSnapControl write SetWebSnapControl;
    property Height;
    property Width;
  end;

implementation

uses SiteComp, AdaptReq, WebScript, HTTPApp, HTTPProd,
  cxWebScriptFactory;

type
TcxWebSnapAdapterSupportControlRequirements = class(TAbstractControlRequirements)
private
  FGeneratedFunctions: TGeneratedFunctions;
  FNeedMultipartForm: Boolean;
  FVariables: TStrings;
public
  procedure RequiresMultipartForm; override;
  function IsFunctionDefined(const AName: string): Boolean; override;
  procedure DefineFunction(const AName, ABody: string); override;
  procedure DefineVariable(const AName, AValue: string; AAdapter: Boolean); override;
  function IsVariableDefined(const AName: string): Boolean; override;
  constructor Create;
  destructor Destroy; override;
  property NeedMultipartForm: Boolean read FNeedMultipartForm;
end;

constructor TcxWebSnapAdapterSupportControlRequirements.Create;
begin
  FGeneratedFunctions := TGeneratedFunctions.Create;
  FVariables := TStringList.Create;
end;

destructor TcxWebSnapAdapterSupportControlRequirements.Destroy;
begin
  FGeneratedFunctions.Free;
  FVariables.Free;
  inherited Destroy;
end;

procedure TcxWebSnapAdapterSupportControlRequirements.DefineVariable(const AName, AValue: string; AAdapter: Boolean);
var
  S: string;
begin
  if FVariables.IndexOf(AName) = -1 then
  begin
    S := Format('%s=%s', [AName, AValue]);
    if AAdapter then
      FVariables.Insert(0, S)
    else
      FVariables.Add(S);
  end;
end;

function TcxWebSnapAdapterSupportControlRequirements.IsVariableDefined(const AName: string): Boolean;
begin
  Result := FVariables.IndexOfName(AName) <> -1;
end;

procedure TcxWebSnapAdapterSupportControlRequirements.DefineFunction(const AName, ABody: string);
begin
  FGeneratedFunctions.Add(AName, ABody);
end;

function TcxWebSnapAdapterSupportControlRequirements.IsFunctionDefined(
  const AName: string): Boolean;
begin
  Result := FGeneratedFunctions.Exists(AName);
end;

procedure TcxWebSnapAdapterSupportControlRequirements.RequiresMultipartForm;
begin
  FNeedMultipartForm := True;
end;

{ TcxWebSnapControlRenderer }
destructor TcxWebSnapControlRenderer.Destroy;
begin
  FreeAndNil(FControlRequirements);
  inherited Destroy;
end;

function TcxWebSnapControlRenderer.GetWebSnapControl: TComponent;
begin
  Result := Adapter.WebSnapControl;
end;

function TcxWebSnapControlRenderer.GetAdapter: TcxWebSnapControlAdapter;
begin
  Result := Component as TcxWebSnapControlAdapter;
end;

function TcxWebSnapControlRenderer.GetControlRequirements: TAbstractControlRequirements;
begin
  if FControlRequirements = nil then
    FControlRequirements := TcxWebSnapAdapterSupportControlRequirements.Create;
  Result := FControlRequirements;
end;

function TcxWebSnapControlRenderer.GetVariables: TStrings;
begin
  Result := TcxWebSnapAdapterSupportControlRequirements(ControlRequirements).FVariables;
end;

function TcxWebSnapControlRenderer.GetGeneratedFunctions: TGeneratedFunctions;
begin
  Result := TcxWebSnapAdapterSupportControlRequirements(ControlRequirements).FGeneratedFunctions;
end;

procedure TcxWebSnapControlRenderer.GetRequirements(AComponent: TComponent);
var
  GetIntf: IGetControlRequirements;
  WebDataFields: IWebDataFields;
  WebActionsList: IWebActionsList;
  GetWebComponentList: IGetWebComponentList;
  Container: IWebComponentContainer;

  procedure GetComponentListRequirements(AWebComponentList: IWebComponentContainer);
  var
    i: Integer;
  begin
    for i := 0 to AWebComponentList.ComponentCount - 1 do
      GetRequirements(AWebComponentList.Components[i]);
  end;

begin
  if Supports(AComponent, IGetControlRequirements, GetIntf) then
    GetIntf.GetControlRequirements(ControlRequirements);
  if Supports(AComponent, IWebDataFields, WebDataFields) then
    GetComponentListRequirements(WebDataFields.GetVisibleFields)
  else
    if Supports(AComponent, IWebActionsList, WebActionsList) then
      GetComponentListRequirements(WebActionsList.GetVisibleActions);
  if Supports(AComponent, IGetWebComponentList, GetWebComponentList) then
  begin
    Supports(GetWebComponentList.GetComponentList, IWebComponentContainer,
      Container);
    GetComponentListRequirements(Container);
  end;
end;

function TcxWebSnapControlRenderer.PerformWebSnapServerScripts(ASource: string): string;
var
  {$IFNDEF USESCRIPTENGINE}
  ASaveScriptProducerClass: TScriptProducerClass;
  {$ENDIF}
  AGetProducerComponent: IGetProducerComponent;
  AProduceContentFrom: IProduceContentFrom;
begin
  if (WebSnapControl.Owner = nil) or
    not Supports(WebSnapControl.Owner, IGetProducerComponent, AGetProducerComponent)
    or (AGetProducerComponent.GetProducerComponent = nil)
    or not Supports(AGetProducerComponent.GetProducerComponent, IProduceContentFrom, AProduceContentFrom) then exit;
  {$IFDEF USESCRIPTENGINE}
    Result := AProduceContentFrom.ProduceContentFromString(ASource);
  {$ELSE}
  ASaveScriptProducerClass := HTTPProd.ScriptProducerClass;
  try
    HTTPProd.ScriptProducerClass := TScriptProducer;
    Result := AProduceContentFrom.ProduceContentFromString(ASource);
  finally
    HTTPProd.ScriptProducerClass := ASaveScriptProducerClass;
  end;
  {$ENDIF}
end;

function TcxWebSnapControlRenderer.InternalScriptsRender: string;
var
  i: Integer;
  AParentComponent: TComponent;
  AWebComponent: IWebComponent;
begin
  Result := '';
  if WebSnapControl = nil then exit;
  AParentComponent := WebSnapControl;
  while AParentComponent <> nil do
  begin
    if Supports(AParentComponent, IWebComponent, AWebComponent) and
      (AWebComponent.Container <> nil) then
    begin
      if (AWebComponent.Container is TComponent) then
        AParentComponent := TComponent(AWebComponent.Container)
      else
        if (AWebComponent.Container is TWebComponentList) then
          AParentComponent := TWebComponentList(AWebComponent.Container).ParentComponent
        else break;
    end  else break;

  end;
  if AParentComponent <> nil then
    GetRequirements(AParentComponent)
  else GetRequirements(WebSnapControl);

  for i := 0 to Variables.Count - 1 do
    Result := Result + Variables[i] + #13#10;
  if Result <> '' then
    Result := '<%'#13#10 + Result + '%>'#13#10;

  for i := 0 to GeneratedFunctions.ItemCount - 1 do
    Result := Result + GeneratedFunctions.Script[i] + #13#10;
end;

procedure TcxWebSnapControlRenderer.WriteHTML;
var
  Result: string;
  AOptions: TWebContentOptions;
  AWebComponent: IWebComponent;
  AOldWebContainer: TWebComponentContainer;
begin
  if WebSnapControl <> nil then
  begin
    Result := InternalScriptsRender;
    AOldWebContainer := nil;
    if Supports(WebSnapControl, IWebComponent, AWebComponent) then
    begin
      AOldWebContainer := AWebComponent.Container;
      AWebComponent.Container := Adapter.WebSnapForm.GetWebComponents;
    end;

    AOptions := TWebContentOptions.Create([]);
    Result := Result + (WebSnapControl as IWebContent).Content(AOptions, nil);
    AOptions.Free;
    if AOldWebContainer <> nil then
      AWebComponent.Container := AOldWebContainer;
    HTMLTextBuilder.WriteText(PerformWebSnapServerScripts(Result));
  end;
end;


{TcxWebSnapControlForm}
function TcxWebSnapControlForm.GetParentComponent: TComponent;
begin
  Result := nil;
end;

function TcxWebSnapControlForm.HasParent: Boolean;
begin
  Result := False;
end;

function TcxWebSnapControlForm.GetHTMLFormName: string;
begin
  if (FControl <> nil) and (FControl.Owner <> nil) then
    Result := FControl.Owner.Name
  else Result := '';
end;

function TcxWebSnapControlForm.GetHTMLFormVarName: string;
begin
  Result := GetHTMLFormName;
end;

type
  TcxWebWebSnapAdapterSupportScript = class(TcxWebScript)
  public
    class procedure WriteHiddenFormElements(HTMLTextBuilder: TcxHTMLTextBuilder;
        const Argument: TcxWebScriptRenderArgument); override;
  end;

class procedure TcxWebWebSnapAdapterSupportScript.WriteHiddenFormElements(HTMLTextBuilder: TcxHTMLTextBuilder;
    const Argument: TcxWebScriptRenderArgument);
begin
  WriteHiddenField(HTMLTextBuilder, sActionRequest, '');
end;

{ TcxWebSnapControlAdapter }
constructor TcxWebSnapControlAdapter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FWebSnapForm := TcxWebSnapControlForm.Create(nil);
  FWebSnapForm.FControl := self;
  Width := 200;
  Height := 100;
end;

destructor TcxWebSnapControlAdapter.Destroy;
begin
  WebSnapControl := nil;
  FWebSnapForm.Free;
  inherited Destroy;
end;

procedure TcxWebSnapControlAdapter.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = WebSnapControl then
      WebSnapControl := nil;
  end;
end;

procedure TcxWebSnapControlAdapter.RegisterRenderers; 
begin
  WebRenderHelper.RegisterRenderer(TcxWebSnapControlRenderer);
end;

procedure TcxWebSnapControlAdapter.ScriptsSubscription;
begin
  inherited ScriptsSubscription;
  WebScriptsHelper.ScriptSubscription(TcxWebWebSnapAdapterSupportScript);
end;

procedure TcxWebSnapControlAdapter.WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  if WebSnapControl <> nil then
  begin
    HTMLTextBuilder.WriteText(WebSnapControl.Name);
  end;
end;

function TcxWebSnapControlAdapter.GetRendererClass: TcxWebRendererClass;
begin
  Result := nil;
end;

class function TcxWebSnapControlAdapter.IsWebSnapControlSupported(AComponent: TComponent): Boolean;
begin
  Result :=  (AComponent <> nil) and Supports(AComponent, IWebContent) and
    not Supports(AComponent, IHTMLForm) and not Supports(AComponent, ILayoutWebContent) and
    not Supports(AComponent, IProduceContent);
end;


procedure TcxWebSnapControlAdapter.SetWebSnapControl(Value: TComponent);
begin
  if (Value <> nil) and not Supports(Value, IWebContent)  then
    raise Exception.Create('Component should support IWebContent interface'); //TODO
  if (Value <> nil) and Supports(Value, IHTMLForm) then
    raise Exception.Create('Component should not support IHTMLForm interface'); //TODO
  if (Value <> nil) and Supports(Value, ILayoutWebContent)  then
    raise Exception.Create('Component should not support ILayoutWebContent interface'); //TODO
  if (Value <> nil) and Supports(Value, IProduceContent)  then
    raise Exception.Create('Component should not support IProduceContent interface'); //TODO


  if FWebSnapControl <> Value then
  begin
    if (FWebSnapControl <> nil) and not (csDestroying in FWebSnapControl.ComponentState) then
      FWebSnapControl.RemoveFreeNotification(self);
    FWebSnapControl := Value;
    if FWebSnapControl <> nil then
      FWebSnapControl.FreeNotification(self);
    if not (csDestroying in ComponentState) then
      UpdateDesignerContext;
  end;
end;


end.
