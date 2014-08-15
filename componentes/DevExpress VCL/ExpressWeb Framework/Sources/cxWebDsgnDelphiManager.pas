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

unit cxWebDsgnDelphiManager;

interface

{$I cxVer.inc}

uses
  Classes, SysUtils,
  {$IFDEF VCL}
  Controls, Forms;
  {$ELSE}
  QControls, QForms;
  {$ENDIF}

type
  TcxWebDelphiEditorManagerListener = class
  private
    FOnEditorFormActivated: TNotifyEvent;
  protected
    procedure EditorFormActivated;
  public
    constructor Create;
    destructor Destroy; override;
    property OnEditorFormActivated: TNotifyEvent read FOnEditorFormActivated
        write FOnEditorFormActivated;
  end;

  TcxWebDelphiEditorManager = class
  private
    FListeners: TList;
    FOldonActiveFormChanged: TNotifyEvent;

    procedure DoActiveFormChanged(Sender: TObject);

    procedure ActiveCustomFormChanged(ACustomForm: TCustomForm);
    procedure EditorFormActivated;
  protected
    constructor CreateInstance(ADummy: Boolean = True);
    class function AccessInstance(Request: Integer): TcxWebDelphiEditorManager;

    procedure RegisterListener(AListener: TcxWebDelphiEditorManagerListener);
    procedure UnregisterListener(AListener: TcxWebDelphiEditorManagerListener);
  public
    constructor Create;
    destructor Destroy; override;
    class function Instance: TcxWebDelphiEditorManager;
    class procedure ReleaseInstance;
  end;

function WebDelphiEditorManager: TcxWebDelphiEditorManager;

implementation

function WebDelphiEditorManager: TcxWebDelphiEditorManager;
begin
  Result := TcxWebDelphiEditorManager.Instance;
end;

{ TcxWebDelphiEditorManager }
constructor TcxWebDelphiEditorManager.Create;
begin
  raise Exception.CreateFmt('Access class %s through Instance only', [ClassName]);
end;

destructor TcxWebDelphiEditorManager.Destroy;
begin
  if Assigned(FOldonActiveFormChanged) then
  begin
    if not Application.Terminated and
      not (csDestroying in Screen.ComponentState) then
      Screen.OnActiveFormChange := FOldonActiveFormChanged
    else Screen.OnActiveFormChange := nil;
  end else
    if Screen <> nil then
      Screen.OnActiveFormChange := nil;
  FListeners.Free;
  inherited Destroy;
end;

var
  FInstance: TcxWebDelphiEditorManager = nil;

class function TcxWebDelphiEditorManager.AccessInstance(
  Request: Integer): TcxWebDelphiEditorManager;
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

constructor TcxWebDelphiEditorManager.CreateInstance(ADummy: Boolean = True);
begin
  FListeners := TList.Create;
  if Application.Terminated or (csDestroying in Screen.ComponentState) then exit;
  FOldonActiveFormChanged := Screen.OnActiveFormChange;
  Screen.OnActiveFormChange := DoActiveFormChanged;
end;

class function TcxWebDelphiEditorManager.Instance: TcxWebDelphiEditorManager;
begin
  Result := AccessInstance(1);
end;

class procedure TcxWebDelphiEditorManager.ReleaseInstance;
begin
  AccessInstance(0).Free;
end;

procedure TcxWebDelphiEditorManager.RegisterListener(AListener: TcxWebDelphiEditorManagerListener);
begin
  if FListeners.IndexOf(AListener) < 0 then
    FListeners.Add(AListener);
end;

procedure TcxWebDelphiEditorManager.UnregisterListener(AListener: TcxWebDelphiEditorManagerListener);
begin
  FListeners.Remove(AListener);
end;

procedure TcxWebDelphiEditorManager.DoActiveFormChanged(Sender: TObject);
begin
  if Assigned(FOldonActiveFormChanged) then
    FOldonActiveFormChanged(Sender);
  if not Application.Terminated and
    not (csDestroying in Screen.ComponentState) and
    (Screen.ActiveCustomForm <> nil) then
    ActiveCustomFormChanged(Screen.ActiveCustomForm);
end;

procedure TcxWebDelphiEditorManager.ActiveCustomFormChanged(ACustomForm: TCustomForm);
begin
  if (CompareText(ACustomForm.ClassName, 'TEditWindow') = 0) then
    EditorFormActivated;
end;

procedure TcxWebDelphiEditorManager.EditorFormActivated;
var
  I: Integer;
begin
  for I := 0 to FListeners.Count - 1 do
    TcxWebDelphiEditorManagerListener(FListeners[I]).EditorFormActivated;
end;

{ TcxWebDelphiEditorManagerListener }

constructor TcxWebDelphiEditorManagerListener.Create;
begin
  WebDelphiEditorManager.RegisterListener(self);
end;

destructor TcxWebDelphiEditorManagerListener.Destroy;
begin
  WebDelphiEditorManager.UnregisterListener(self);
  inherited Destroy;
end;

procedure TcxWebDelphiEditorManagerListener.EditorFormActivated;
begin
  if Assigned(FOnEditorFormActivated) then
    FOnEditorFormActivated(self);
end;

initialization

finalization
  TcxWebDelphiEditorManager.ReleaseInstance;
  
end.
