{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Designer Module                                             }
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
unit cxWebCtrlsFactory;

{$I cxVer.inc}

interface

uses Classes, SysUtils,
  {$IFDEF VCL}
  Controls,
  {$ELSE}
  QControls,
  {$ENDIF}
  cxWebDsgnCtrls, cxWebIntf, cxWebDsgnIntf;

type
  TcxWebDesignControlsFactory = class
  private
    FList: TList;
    function GetDesignControlClass(const WebControlClass: TComponentClass): TComponentClass;
    function GetCount: Integer;
    procedure Clear;
    procedure Delete(Index: Integer);
    function IndexOf(AControlClass: TComponentClass; ADesignControlClass: TComponentClass): Integer;
  protected
    constructor CreateInstance(ADummy: Boolean = True);
    class function AccessInstance(Request: Integer): TcxWebDesignControlsFactory;
  public
    constructor Create;
    destructor Destroy; override;
    class function Instance: TcxWebDesignControlsFactory;
    class procedure ReleaseInstance;

    function CreateDesignControl(AWebControl: IcxWebControl;
      ADesignerSurface: TWinControl): IcxWebDesignerControl;
    procedure RegisterDesignControl(AControlClass: TComponentClass;
      ADesignControlClass: TComponentClass);
    procedure UnregisterDesignControl(ADesignControlClass: TComponentClass);

    property DesignControlClasses[const WebControlClass: TComponentClass]: TComponentClass
      read GetDesignControlClass; default;
    property Count: Integer read GetCount;
  end;

function WebDesignControlsFactory: TcxWebDesignControlsFactory;

implementation

uses
  cxWebUtils;

type
  PcxWebDesignControlRegItem = ^TcxWebControlRegItem;
  TcxWebControlRegItem = record
    ControlClass: TComponentClass;
    DesignControlClass: TComponentClass;
  end;

function WebDesignControlsFactory: TcxWebDesignControlsFactory;
begin
  Result := TcxWebDesignControlsFactory.Instance;
end;

{TcxWebDesignControlsFactory}
constructor TcxWebDesignControlsFactory.Create;
begin
  inherited Create;
  raise Exception.CreateFmt('Access class %s through Instance only', [ClassName]);
end;

destructor TcxWebDesignControlsFactory.Destroy;
begin
  Clear;
  FList.Free;
  inherited Destroy;
end;

constructor TcxWebDesignControlsFactory.CreateInstance(ADummy: Boolean = True);
begin
  FList := TList.Create;
end;

var
  FInstance: TcxWebDesignControlsFactory = nil;

class function TcxWebDesignControlsFactory.AccessInstance(Request: Integer): TcxWebDesignControlsFactory;
begin
  case Request of
    0 : ;
    1 : if not Assigned(FInstance) then FInstance := CreateInstance;
    2 : FInstance := nil;
  else
    raise Exception.CreateFmt('Illegal request %d in AccessInstance',
      [Request]);
  end;
  Result := FInstance;
end;

class function TcxWebDesignControlsFactory.Instance: TcxWebDesignControlsFactory;
begin
  Result := AccessInstance(1);
end;

class procedure TcxWebDesignControlsFactory.ReleaseInstance;
begin
  AccessInstance(0).Free;
  FInstance := nil;
end;

function TcxWebDesignControlsFactory.CreateDesignControl(AWebControl: IcxWebControl;
  ADesignerSurface: TWinControl): IcxWebDesignerControl;
var
  AControlClass: TComponentClass;
  AWebComponent: TComponent;
begin
  Result := nil;
  AWebComponent := GetComponentByInterface(AWebControl);
  if AWebComponent <> nil then
    AControlClass := DesignControlClasses[TComponentClass(AWebComponent.ClassType)]
  else AControlClass := nil;
  
  if (AControlClass <> nil) and Supports(AControlClass, IcxWebDesignerControl) then
  begin
    AWebComponent := AControlClass.Create(nil);
    if Supports(AWebComponent, IcxWebDesignerControl, Result) then
    begin
      Result.WebControl := AWebControl;
      Result.DesignerSurface := ADesignerSurface;
    end;
  end;  
end;

procedure TcxWebDesignControlsFactory.RegisterDesignControl(
  AControlClass: TComponentClass; ADesignControlClass: TComponentClass);
var
  RegItem: PcxWebDesignControlRegItem;
begin
  if IndexOf(AControlClass, ADesignControlClass) <> -1 then 
    Exit;
  New(RegItem);
  RegItem^.ControlClass := AControlClass;
  RegItem^.DesignControlClass := ADesignControlClass;
  FList.Add(RegItem);
end;

procedure TcxWebDesignControlsFactory.UnregisterDesignControl(
  ADesignControlClass: TComponentClass);
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do
    if PcxWebDesignControlRegItem(FList[I]).DesignControlClass = ADesignControlClass then
      Delete(I);
end;

function TcxWebDesignControlsFactory.GetDesignControlClass(
  const WebControlClass: TComponentClass): TComponentClass;
var
  Candidate: TComponentClass;
  I, CandidateIndex: Integer;
  RegItem: PcxWebDesignControlRegItem;
  ControlClass: TComponentClass;
begin
  Candidate := nil;
  CandidateIndex := 0;
  for I := 0 to Count - 1 do
  begin
    RegItem := PcxWebDesignControlRegItem(FList[I]);
    ControlClass := RegItem^.ControlClass;

    if WebControlClass.InheritsFrom(ControlClass) then
      if (Candidate = nil) or not Candidate.InheritsFrom(ControlClass) then
      begin
        Candidate := ControlClass;
        CandidateIndex := I;
      end;

    if Candidate = WebControlClass then
    begin
      Result := RegItem^.DesignControlClass;
      Exit;
    end;
  end;

  if Candidate <> nil then
    Result := PcxWebDesignControlRegItem(FList[CandidateIndex])^.DesignControlClass
  else
    Result := nil;
end;

function TcxWebDesignControlsFactory.GetCount: Integer;
begin
  Result := FList.Count;
end;

procedure TcxWebDesignControlsFactory.Clear;
begin
  while Count > 0 do
    Delete(Count - 1);
end;

procedure TcxWebDesignControlsFactory.Delete(Index: Integer);
begin
  Dispose(PcxWebDesignControlRegItem(FList[Index]));
  FList.Delete(Index);
end;

function TcxWebDesignControlsFactory.IndexOf(AControlClass: TComponentClass;
  ADesignControlClass: TComponentClass): Integer;
var
  RegItem: PcxWebDesignControlRegItem;
begin
  for Result := 0 to Count - 1 do
  begin
    RegItem := PcxWebDesignControlRegItem(FList[Result]);
    if (RegItem^.ControlClass = AControlClass) and
      (RegItem^.DesignControlClass = ADesignControlClass) then
      Exit;
  end;
  Result := -1;
end;


initialization

finalization
   TcxWebDesignControlsFactory.ReleaseInstance;


end.
