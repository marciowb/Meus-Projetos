{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Web Controls Library                                        }
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
unit cxWebExtCtrls;

{$I cxVer.inc}

interface

uses
  Classes, TypInfo,
  cxWebIntf, cxWebClasses, cxWebRender;

type

  TcxWebTimerEvent = (teOnTimer);

  TcxWebTimerEventsHelper = class(TcxWebScriptEventsHelper)
  protected
    function EventName(const AEvent: Integer): string; override;
    function EventProcParams(const AEvent: Integer): string; override;
    function ScriptObject: string; override;    
  public
    function EventTypeInfo: PTypeInfo; override;
  end;

  TcxWebTimer = class(TcxWebComponent)
  private
    FInterval: Integer;
    FOnTimer: TNotifyEvent;
    FEnabled: Boolean;
    procedure WebTimer(const AParameters: TcxActionParameters);
  protected
    procedure ValidateContainer(AComponent: TComponent); override;
    { Actions }
    procedure RegisterActions; override;
    { events }
    function GetWebEventsHelper: TcxWebTimerEventsHelper;
    class function GetWebEventsHelperClass: TcxWebEventsHelperClass; override;
    property WebEventsHelper: TcxWebTimerEventsHelper read GetWebEventsHelper;
    { Rendering }
    procedure RegisterRenderers; override;
    { Scripts }
    procedure ScriptsSubscription; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Enabled: Boolean read FEnabled write FEnabled default True;
    property Interval: Integer read FInterval write FInterval default 1000;
    property OnTimer: TNotifyEvent read FOnTimer write FOnTimer;
  end;

  TcxWebTimerRenderer = class(TcxWebComponentRenderer)
  private
    function GetWebTimer: TcxWebTimer;
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
    property WebTimer: TcxWebTimer read GetWebTimer;
  end;

implementation

uses
  SysUtils,
  cxWebConsts, cxWebUtils, cxWebScriptFactory;

{ TcxWebTimerEventsHelper }

function TcxWebTimerEventsHelper.EventTypeInfo: PTypeInfo;
begin
  Result := TypeInfo(TcxWebTimerEvent);
end;

function TcxWebTimerEventsHelper.EventName(const AEvent: Integer): string;
const
  cxHTMLEvent: array[TcxWebTimerEvent] of string = ('OnTimer');
begin
  Result := cxHTMLEvent[TcxWebTimerEvent(AEvent)];
end;

function TcxWebTimerEventsHelper.EventProcParams(const AEvent: Integer): string;
const
  cxHTMLEventProcParams: array[TcxWebTimerEvent] of string = ('(Sender)');
begin
  Result := cxHTMLEventProcParams[TcxWebTimerEvent(AEvent)];
end;

function TcxWebTimerEventsHelper.ScriptObject: string;
begin
  Result := '_Timer';
end;

{ TcxWebTimer }

constructor TcxWebTimer.Create(AOwner: TComponent);
begin
  inherited;
  Enabled := True;
  Interval := 1000;
end;

destructor TcxWebTimer.Destroy;
begin
  inherited;
end;

procedure TcxWebTimer.WebTimer(const AParameters: TcxActionParameters);
begin
  if Assigned(FOnTimer) then
    FOnTimer(Self);
end;

procedure TcxWebTimer.ValidateContainer(AComponent: TComponent);
begin
  inherited ValidateContainer(AComponent);
  if not Supports(AComponent, IcxWebPageModule) then
    raise Exception.Create('Unable insert this WebComponent on this module');
end;

procedure TcxWebTimer.RegisterActions;
begin
  WebActionsHelper.RegisterAction('TIMER', WebTimer);
end;

function TcxWebTimer.GetWebEventsHelper: TcxWebTimerEventsHelper;
begin
  Result := TcxWebTimerEventsHelper(inherited GetWebEventsHelper);
end;

class function TcxWebTimer.GetWebEventsHelperClass: TcxWebEventsHelperClass;
begin
  Result := TcxWebTimerEventsHelper;
end;

procedure TcxWebTimer.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxWebTimerRenderer);
end;

procedure TcxWebTimer.ScriptsSubscription;
begin
  WebScriptsHelper.ScriptSubscription(TcxWebPostBackScript);
end;

{ TcxWebTimerRenderer }

class procedure TcxWebTimerRenderer.GetScriptFiles(AList: TStrings);
begin
  AList.Add(scxCommonScriptName);
  AList.Add(scxTimerScriptName);
end;

function TcxWebTimerRenderer.GetWebTimer: TcxWebTimer;
begin
  Result := WebComponent as TcxWebTimer;
end;

procedure TcxWebTimerRenderer.WriteScripts;
begin
  inherited;
  if WebTimer.Enabled and (WebTimer.Interval > 0) then
  begin
    HTMLTextBuilder.WriteText('_Timer = CreateTimer();');
    HTMLTextBuilder.WriteText(Format('  _Timer.Name = "%s";', [WebTimer.Name]));
    HTMLTextBuilder.WriteText(Format('  _Timer.Interval = %d;', [WebTimer.Interval]));
    if Assigned(WebTimer.OnTimer) then
      HTMLTextBuilder.WriteText('  _Timer.AssignOnTimer = true;');
    WriteEvents;
  end;
end;

initialization
  RegisterClasses([TcxWebTimer]);

end.

