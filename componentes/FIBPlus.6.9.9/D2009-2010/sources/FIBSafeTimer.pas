{***************************************************************}
{ FIBPlus - component library for direct access to Firebird and }
{ InterBase databases                                           }
{                                                               }
{    FIBPlus is based in part on the product                    }
{    Free IB Components, written by Gregory H. Deatz for        }
{    Hoagland, Longo, Moran, Dunst & Doukas Company.            }
{    mailto:gdeatz@hlmdd.com                                    }
{                                                               }
{    Copyright (c) 1998-2009 Devrace Ltd.                       }
{    Written by Serge Buzadzhy (buzz@devrace.com)               }
{                                                               }
{ ------------------------------------------------------------- }
{    FIBPlus home page: http://www.fibplus.com/                 }
{    FIBPlus support  : http://www.devrace.com/support/         }
{ ------------------------------------------------------------- }
{                                                               }
{  Please see the file License.txt for full license information }
{***************************************************************}

unit FIBSafeTimer;

interface

uses
  Windows, SysUtils, Classes;

type
{$I FIBPlus.inc}
  { TFIBCustomTimer }

  TFIBCustomTimer = class(TComponent)
  private
    FActive: Boolean;
    FHandle: Integer;
    FInterval: Integer;
    FOnTimer: TNotifyEvent;
    procedure SetActive(const Value: Boolean);
    procedure SetInterval(const Value: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
{    procedure Start;
    procedure Stop;}
    property  Enabled: Boolean read FActive write SetActive;
    property  Interval: Integer read FInterval write SetInterval;
    property  OnTimer: TNotifyEvent read FOnTimer write FOnTimer;
  end;

implementation

var
  TimerList: TThreadList;

type
  TSyncThread=class(TThread)
  protected
    FTimer:TFIBCustomTimer;
    procedure Execute; override;
    procedure DoOnTimer;
  end;
  
procedure TimerProc(HWND, uMsg, idEvent, dwTime : Integer); stdcall;
var
  I: Integer;
  Timer: TFIBCustomTimer;
  List:TList;
  st:TSyncThread;
begin
  I := 0;
  List:=TimerList.LockList;
  try
    while I < List.Count do
    begin
      Timer := List.Items[I];
      if (Timer <> nil) and (idEvent = Timer.FHandle) and
         (Assigned(Timer.FOnTimer))
      then
      begin
        if GetCurrentThreadID = MainThreadID then
          Timer.FOnTimer(Timer)
        else
        begin
          st:=TSyncThread.Create(True);
          try
           st.FTimer:=Timer;
           st.Synchronize(st.DoOnTimer);
          finally
           st.Free
          end;
        end ;
        Exit; {выполняем и уходим}
      end;
      Inc(I);
    end;
   finally
    TimerList.UnlockList
   end
end;

{ TFIBCustomTimer }

constructor TFIBCustomTimer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FActive := False;
  FInterval := 1000; {}
  FOnTimer := nil;
  TimerList.Add(Self); {расширяем список таймеров}
end;

destructor TFIBCustomTimer.Destroy;
begin
  Enabled := False;
  TimerList.Remove(Self); {удаляем таймер из списка}
  inherited;
end;

procedure TFIBCustomTimer.SetActive(const Value: Boolean);
begin
  if FActive = Value then Exit;
  if FActive then
  begin
    KillTimer(0, FHandle);
    FHandle := 0;
  end;
  if Value then 
     FHandle := SetTimer(0, 0, FInterval, @TimerProc);
  FActive := Value;
end;

procedure TFIBCustomTimer.SetInterval(const Value: Integer);
var
  OldEnabled: Boolean;
begin
  OldEnabled := Enabled;
  Enabled := False;
  FInterval := Value;
  Enabled := OldEnabled;
end;

{ TSyncThread }

procedure TSyncThread.DoOnTimer;
begin
  FTimer.OnTimer(FTimer)
end;

procedure TSyncThread.Execute;
begin
end;

initialization
  TimerList := TThreadList.Create;
finalization
  TimerList.Free;
end.

