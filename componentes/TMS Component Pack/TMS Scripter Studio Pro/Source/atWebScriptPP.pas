{***************************************************************************}
{ Scripter Studio components                                                }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of TMS software.                                    }
{***************************************************************************}
unit atWebScriptPP;

interface

{$I ASCRIPT.INC}


uses
  SysUtils, Classes, {$IFDEF DELPHI6_LVL}HTTPProd, {$ELSE} HTTPApp, {$ENDIF}
  atWebScripter, atScript, atPascal, atBasic, atHTMLParse;

type
  TatPageProducer = class(TCustomPageProducer)
  private
    FWebScripter: TatWebScripter;

    function GetAfterPreCompile: TAfterPreCompileEvent;
    function GetLanguage: TatLanguage;
    function GetOnCompileError: TScriptErrorEvent;
    function GetOnDebugHook: TNotifyEvent;
    function GetOnDirective: TDirectiveEvent;
    function GetOnExecuteEvent: TExecuteEventProc;
    function GetOnInitScripter: TScripterNotifyEvent;
    function GetOnSetEvent: TSetEventProc;
    function GetOnSettingEvent: TSettingEventProc;
    function GetOnUnsettingEvent: TUnsetEventProc;
    procedure SetAfterPreCompile(const Value: TAfterPreCompileEvent);
    procedure SetLanguage(const Value: TatLanguage);
    procedure SetOnCompileError(const Value: TScriptErrorEvent);
    procedure SetOnDebugHook(const Value: TNotifyEvent);
    procedure SetOnDirective(const Value: TDirectiveEvent);
    procedure SetOnExecuteEvent(const Value: TExecuteEventProc);
    procedure SetOnInitScripter(const Value: TScripterNotifyEvent);
    procedure SetOnSetEvent(const Value: TSetEventProc);
    procedure SetOnSettingEvent(const Value: TSettingEventProc);
    procedure SetOnUnsettingEvent(const Value: TUnsetEventProc);
    function GetAfterCompile: TScripterNotifyEvent;
    procedure SetAfterCompile(const Value: TScripterNotifyEvent);
    function GetAfterExecute: TScripterNotifyEvent;
    function GetBeforeExecute: TScripterNotifyEvent;
    procedure SetAfterExecute(const Value: TScripterNotifyEvent);
    procedure SetBeforeExecute(const Value: TScripterNotifyEvent);
  protected

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function ContentFromStream(Stream: TStream): string; override;

    property WebScripter: TAtWebScripter read FWebScripter;
  published
    property HTMLDoc;
    property HTMLFile;

    property Language: TatLanguage read GetLanguage write SetLanguage;

    property AfterPreCompile: TAfterPreCompileEvent read GetAfterPreCompile write SetAfterPreCompile;
    property AfterCompile: TScripterNotifyEvent read GetAfterCompile write SetAfterCompile;
    property AfterExecute: TScripterNotifyEvent read GetAfterExecute write SetAfterExecute;
    property BeforeExecute: TScripterNotifyEvent read GetBeforeExecute write SetBeforeExecute;
    property OnCompileError: TScriptErrorEvent read GetOnCompileError write SetOnCompileError;
    property OnDebugHook: TNotifyEvent read GetOnDebugHook write SetOnDebugHook;
    property OnDirective: TDirectiveEvent read GetOnDirective write SetOnDirective;
    property OnExecuteEvent: TExecuteEventProc read GetOnExecuteEvent write SetOnExecuteEvent;
    property OnInitScripter: TScripterNotifyEvent read GetOnInitScripter write SetOnInitScripter;
    property OnSetEvent: TSetEventProc read GetOnSetEvent write SetOnSetEvent;
    property OnSettingEvent: TSettingEventProc read GetOnSettingEvent write SetOnSettingEvent;
    property OnUnsettingEvent: TUnsetEventProc read GetOnUnsettingEvent write SetOnUnsettingEvent;
  end;

implementation


{ TatPageProducer }

constructor TatPageProducer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FWebScripter := TatWebScripter.Create(Self);
end;

destructor TatPageProducer.Destroy;
begin
  FWebScripter.Free;

  inherited Destroy;
end;

function TatPageProducer.GetAfterPreCompile: TAfterPreCompileEvent;
begin
  Result := FWebScripter.AfterPreCompile;
end;

function TatPageProducer.GetAfterCompile: TScripterNotifyEvent;
begin
  Result := FWebScripter.AfterCompile;
end;

function TatPageProducer.GetLanguage: TatLanguage;
begin
  Result := FWebScripter.Language;
end;

function TatPageProducer.GetOnCompileError: TScriptErrorEvent;
begin
  Result := FWebScripter.OnCompileError;
end;

function TatPageProducer.GetOnDebugHook: TNotifyEvent;
begin
  Result := FWebScripter.OnDebugHook;
end;

function TatPageProducer.GetOnDirective: TDirectiveEvent;
begin
  Result := FWebScripter.OnDirective;
end;

function TatPageProducer.GetOnExecuteEvent: TExecuteEventProc;
begin
  Result := FWebScripter.OnExecuteEvent;
end;

function TatPageProducer.GetOnInitScripter: TScripterNotifyEvent;
begin
  Result := FWebScripter.OnInitScripter;
end;

function TatPageProducer.GetOnSetEvent: TSetEventProc;
begin
  Result := FWebScripter.OnSetEvent;
end;

function TatPageProducer.GetOnSettingEvent: TSettingEventProc;
begin
  Result := FWebScripter.OnSettingEvent;
end;

function TatPageProducer.GetOnUnsettingEvent: TUnsetEventProc;
begin
  Result := FWebScripter.OnUnsettingEvent;
end;

procedure TatPageProducer.SetAfterPreCompile(const Value: TAfterPreCompileEvent);
begin
  FWebScripter.AfterPreCompile := Value;
end;

procedure TatPageProducer.SetAfterCompile(const Value: TScripterNotifyEvent);
begin
  FWebScripter.AfterCompile := Value;
end;

procedure TatPageProducer.SetLanguage(const Value: TatLanguage);
begin
  FWebScripter.Language := Value;
end;

procedure TatPageProducer.SetOnCompileError(const Value: TScriptErrorEvent);
begin
  FWebScripter.OnCompileError := Value;
end;

procedure TatPageProducer.SetOnDebugHook(const Value: TNotifyEvent);
begin
  FWebScripter.OnDebugHook := Value;
end;

procedure TatPageProducer.SetOnDirective(const Value: TDirectiveEvent);
begin
  FWebScripter.OnDirective := Value;
end;

procedure TatPageProducer.SetOnExecuteEvent(const Value: TExecuteEventProc);
begin
  FWebScripter.OnExecuteEvent := Value;
end;

procedure TatPageProducer.SetOnInitScripter(const Value: TScripterNotifyEvent);
begin
  FWebScripter.OnInitScripter := Value;
end;

procedure TatPageProducer.SetOnSetEvent(const Value: TSetEventProc);
begin
  FWebScripter.OnSetEvent := Value;
end;

procedure TatPageProducer.SetOnSettingEvent(const Value: TSettingEventProc);
begin
  FWebScripter.OnSettingEvent := Value;
end;

procedure TatPageProducer.SetOnUnsettingEvent(const Value: TUnsetEventProc);
begin
  FWebScripter.OnUnsettingEvent := Value;
end;

function TatPageProducer.ContentFromStream(Stream: TStream): string;
begin
  Result := FWebScripter.ContentFromStream(Stream);
end;




function TatPageProducer.GetAfterExecute: TScripterNotifyEvent;
begin
  Result := FWebScripter.AfterExecute;
end;

function TatPageProducer.GetBeforeExecute: TScripterNotifyEvent;
begin
  Result := FWebScripter.BeforeExecute;
end;

procedure TatPageProducer.SetAfterExecute(const Value: TScripterNotifyEvent);
begin
  FWebScripter.AfterExecute := Value;
end;

procedure TatPageProducer.SetBeforeExecute(const Value: TScripterNotifyEvent);
begin
  FWebScripter.BeforeExecute := Value;
end;

end.
