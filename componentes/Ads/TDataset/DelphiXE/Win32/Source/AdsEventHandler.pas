// Copyright (c) 2002-2006 Extended Systems, Inc.
// Portions Copyright (c) 2005-2010, iAnywhere Solutions, Inc.
// All rights reserved. All unpublished rights reserved.
//
// This source code can be used, modified, or copied by the licensee as long as
// the modifications (or the new binary resulting from a copy or modification of
// this source code) are used with Extended Systems' products. The source code
// is not redistributable as source code, but is redistributable as compiled
// and linked binary code. If the source code is used, modified, or copied by
// the licensee, Extended Systems Inc. reserves the right to receive from the
// licensee, upon request, at no cost to Extended Systems Inc., the modifications.
//
// Extended Systems Inc. does not warrant that the operation of this software
// will meet your requirements or that the operation of the software will be
// uninterrupted, be error free, or that defects in software will be corrected.
// This software is provided "AS IS" without warranty of any kind. The entire
// risk as to the quality and performance of this software is with the purchaser.
// If this software proves defective or inadequate, purchaser assumes the entire
// cost of servicing or repair. No oral or written information or advice given
// by an Extended Systems Inc. representative shall create a warranty or in any
// way increase the scope of this warranty.
{*******************************************************************************
* Source File : AdsEventhandler.pas
* Date Created: 02/16/10
* Description : This is the TAdsEvent and TAdsEventReceiveThread component source
* Notes       :
*******************************************************************************}
unit AdsEventHandler;

{$IFDEF FPC}
   {$MODE DELPHI}{$H+}
{$ENDIF}

{* Override any compiler directives we don't want, but that that user might have
 * defined in their project. *}
{$T-}   // turns off typed @ operator
{$B-}   // use short-circuit boolean expressions
{$V-}   // no var-string checking

{$INCLUDE versions.inc}

{$IFDEF ADSDELPHI7_OR_NEWER}
   {$WARN UNSAFE_TYPE OFF}
   {$WARN UNSAFE_CODE OFF}
   {$WARN UNSAFE_CAST OFF}
{$ENDIF}

{$IFDEF ADSDELPHI2006_OR_NEWER}
   {$WARN SYMBOL_DEPRECATED OFF}
{$ENDIF}

{ Range checking ( + is on and - is off ) }
{$R+}

interface

uses
  SysUtils, Classes, adscnnct, adstable, adsdata;

type

  TAdsNotifyEvent = procedure (Sender:TObject; event:string; count:integer; eventdata:string) of object;
  TAdsLogEvent = procedure(Sender:TObject; log:string) of object;

  TAdsEventReceiveThread = class(TThread)
  private
    FOnReceive: TAdsNotifyEvent;
    AdsCn: TAdsConnection;
    AdsQu: TAdsQuery;
    FOnLog: TAdsLogEvent;
    FEvents: TStrings;
    FEvent:string;
    FCount:integer;
    FLog:string;
    FEventData:string;
    FEventTimeout: integer;
    FPollInterval : integer;
    FCancelThread : boolean;
  protected
    procedure Execute; override;
    procedure DoReceive(event:string; count:integer; eventdata:string);
    procedure DoReceiveSync();
    procedure DoLog(s:string);
    procedure DoLogSync();
  public
    constructor Create(cn:TAdsConnection; Events:TStrings);
    destructor Destroy(); override;
    property CancelThread : boolean read FCancelThread write FCancelThread;
    property OnReceive:TAdsNotifyEvent read FOnReceive write FOnReceive;
    property OnLog:TAdsLogEvent read FOnLog write FOnLog;
    property EventTimeout: integer read FEventTimeout write FEventTimeout;
    property PollInterval: integer read FPollInterval write FPollInterval;
  end;

  TAdsEvent = class(TComponent)
  private
    rcThread:TAdsEventReceiveThread;
    FOnNotification: TAdsNotifyEvent;
    FOnLog: TAdsLogEvent;
    FAdsConnection: TAdsConnection;
    FActive: boolean;
    FEvents: TStrings;
    FEventTimeout: Integer;
    FPollInterval : Integer;
    procedure SetActive(const Value: boolean);
    procedure SetEvents(const Value: TStrings);
  protected
    procedure DoNotification(event:string; count:integer; eventdata:string);
    procedure rcNotification(Sender:TObject; event:string; count:integer; eventdata:string);
    procedure DoLog(s:string);
    procedure rcLog(Sender:TObject; log:string);
    procedure ResetThread;
    procedure Loaded; override;
    procedure CancelThread;
  public
    { Public declarations }
    constructor Create(Owner:TComponent); override;
    destructor Destroy(); override;
  published
    property Active:boolean read FActive write SetActive default False;
    property Events: TStrings read FEvents write SetEvents;
    property OnNotification:TAdsNotifyEvent read FOnNotification write FOnNotification;
    property OnLog:TAdsLogEvent read FOnLog write FOnLog;
    property AdsConnection:TAdsConnection read FAdsConnection write FAdsConnection;
    property EventTimeout: Integer read FEventTimeout write FEventTimeout default -1;
    property PollInterval: Integer read FPollInterval write FPollInterval default 300;
  end;

  function ThreadCallback( usPercent: word; ulCallbackID: Integer): longint; stdcall;

implementation

uses ace;

// Callback used to cancel the background thread
{$IFDEF FPC}{$HINTS OFF}{$ENDIF}
function ThreadCallback( usPercent: word;
                         ulCallbackID: Integer): longint; stdcall;
begin
   if TAdsEventReceiveThread( Pointer(ulCallbackID) ).CancelThread then
     result := 1
   else
     result := 0;
end;
{$IFDEF FPC}{$HINTS ON}{$ENDIF}


{ TAdsEventReceiveThread }

{*******************************************************************************
*  Module: TAdsEventReceiveThread.Create
*******************************************************************************}
constructor TAdsEventReceiveThread.Create(cn: TAdsConnection; Events:TStrings);
begin
  AdsCn:=nil;
  AdsQu:=nil;
  inherited Create(true);
  FEvents:=TStringList.Create;
  FEvents.Assign(Events);
  AdsCn:=TAdsConnection.Create(nil);
  //clone the connection
  AdsCn.AdsServerTypes:=cn.AdsServerTypes;
  if length(cn.AliasName)>0
    then AdsCn.AliasName:=cn.AliasName
    else AdsCn.ConnectPath:=cn.ConnectPath;
  AdsCn.CommunicationType:=cn.CommunicationType;
  AdsCn.Compression:=cn.Compression;
  AdsCn.LoginPrompt:=false;
  AdsCn.Password:=cn.Password;
  AdsCn.Username:=cn.Username;
  //create a query and connect it to the AdsConnection for later usage
  AdsQu:=TAdsQuery.Create(nil);
  AdsQu.AdsConnection:=AdsCn;
  CancelThread := false;
end;


{*******************************************************************************
*  Module: TAdsEventReceiveThread.Destroy
*******************************************************************************}
destructor TAdsEventReceiveThread.Destroy;
begin
  FreeAndNil(AdsQu);
  FreeAndNil(AdsCn);
end;


{*******************************************************************************
*  Module: TAdsEventReceiveThread.DoLog
*******************************************************************************}
procedure TAdsEventReceiveThread.DoLog(s: string);
begin
  FLog:=s;
  Synchronize(DoLogSync);
end;


{*******************************************************************************
*  Module: TAdsEventReceiveThread.DoLogSync
*******************************************************************************}
procedure TAdsEventReceiveThread.DoLogSync;
begin
  if assigned(FOnLog)
    then FOnLog(self,FLog);
end;


{*******************************************************************************
*  Module: TAdsEventReceiveThread.DoReceive
*******************************************************************************}
procedure TAdsEventReceiveThread.DoReceive(event:string; count:integer; eventdata:string);
begin
  FEvent:=event;
  FCount:=count;
  fEventData:=eventdata;
  Synchronize(DoReceiveSync);
end;


{*******************************************************************************
*  Module: TAdsEventReceiveThread.DoReceiveSync
*******************************************************************************}
procedure TAdsEventReceiveThread.DoReceiveSync;
begin
  if assigned(FOnReceive)
    then FOnReceive(self,FEvent,FCount,FEventData);
end;


{*******************************************************************************
*  Module: TAdsEventReceiveThread.Execute
*******************************************************************************}
procedure TAdsEventReceiveThread.Execute;
var
  I: Integer;
begin
  try
    {* register the callback function *}
    AdsQu.AdsRegisterCallbackFunction( @ThreadCallback, integer( self ) );
    try
      AdsCn.Connect;
      for I := 0 to FEvents.Count - 1 do
      begin
        AdsQu.SQL.Text:='execute procedure sp_createevent('+QuotedStr(FEvents[i])+',2);'; //with data
        try AdsQu.ExecSQL; except end;
      end;
      AdsQu.SQL.Text:='execute procedure sp_waitforanyevent(:timeout,:pollinterval,0);';
      AdsQu.ParamByName( 'timeout' ).AsInteger := FEventTimeout;
      AdsQu.ParamByName( 'pollinterval' ).AsInteger := FPollInterval;
      while ( not Suspended ) and ( not CancelThread ) do
      begin
        AdsQu.Open;
        AdsQu.First;
        while not AdsQu.Eof do
          begin
            if AdsQu.FieldByName('EventCount').AsInteger>0
              then if FEvents.IndexOf(AdsQu.FieldByName('EventName').AsString)>=0
                then DoReceive(AdsQu.FieldByName('EventName').AsString,AdsQu.FieldByName('EventCount').AsInteger,AdsQu.FieldByName('StringData').AsString);
            AdsQu.Next;
          end;
        AdsQu.Close;
      end;

      if CancelThread then
        self.Terminate;

      except
      on E:Exception do
        // Ignore query cancelled (7209) exception
        if ( pos( '7209', e.Message) = 0 ) then
          DoLog(e.Message)
        else
          self.Terminate;
      end;
  finally
    AdsQu.AdsClearProgressCallback();
  end;
end;


{ TAdsEvent }

{*******************************************************************************
*  Module: TAdsEvent.Create
*******************************************************************************}
constructor TAdsEvent.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  FActive := false;
  FAdsConnection := nil;
  FOnNotification := nil;
  FOnLog := nil;
  rcThread := nil;
  FEventTimeout := -1;
  FPollInterval := 300;
  FEvents := TStringList.Create;
end;


{*******************************************************************************
*  Module: TAdsEvent.Destroy
*******************************************************************************}
destructor TAdsEvent.Destroy;
begin
  CancelThread;
  inherited;
end;


{*******************************************************************************
*  Module: TAdsEvent.DoLog
*******************************************************************************}
procedure TAdsEvent.DoLog(s: string);
begin
  if assigned(FOnLog)
    then FOnLog(self,s);
end;


{*******************************************************************************
*  Module: TAdsEvent.DoNotification
*******************************************************************************}
procedure TAdsEvent.DoNotification(event: string; count: integer; eventdata:string);
begin
  if assigned(FOnNotification)
    then FOnNotification(self,event,count,eventdata);
end;


{*******************************************************************************
*  Module: TAdsEvent.Loaded
*******************************************************************************}
procedure TAdsEvent.Loaded;
begin
  inherited;
  // Now that we are loaded from the form, call ResetThread which will
  // start the thread if necessary now that we have all of our properties set.
  ResetThread;
end;


{*******************************************************************************
*  Module: TAdsEvent.rcLog
*******************************************************************************}
procedure TAdsEvent.rcLog(Sender: TObject; log: string);
begin
  DoLog(log);
end;


{*******************************************************************************
*  Module: TAdsEvent.rcNotification
*******************************************************************************}
procedure TAdsEvent.rcNotification(Sender: TObject; event: string;
  count: integer; eventdata:string);
begin
  DoNotification(event,count,eventdata);
end;


{*******************************************************************************
*  Module: TAdsEvent.CancelThread
*******************************************************************************}
procedure TAdsEvent.CancelThread;
begin
  if Assigned( rcThread ) then
  begin
    rcThread.CancelThread := true;
    rcThread.WaitFor;
    rcThread := nil;
    self.Active := false;
  end;
end;


{*******************************************************************************
*  Module: TAdsEvent.ResetThread
*******************************************************************************}
procedure TAdsEvent.ResetThread;
begin
  {* Don't start threads inside the Delphi IDE, only at runtime *}
  if ( csDesigning in ComponentState ) or ( csLoading in ComponentState ) then
    exit;

  if FActive and not Assigned( AdsConnection ) then
      raise EADSDatabaseError.create( nil, AE_TADSDATASET_GENERAL, self.name + ': AdsConnection property must have a value.' );

  if assigned(rcThread)
  then begin
    self.CancelThread;
  end;
  if assigned(FAdsConnection) and FActive and assigned(FEvents)
  then begin
    rcThread := TAdsEventReceiveThread.Create(FAdsConnection,FEvents);
    rcThread.OnReceive := rcNotification;
    rcThread.OnLog := rcLog;
    rcThread.PollInterval := FPollInterval;
    rcThread.EventTimeout := FEventTimeout;
    rcThread.FreeOnTerminate := true;
    {$IFDEF ADSDELPHI2010_OR_NEWER}
      rcThread.Start;
    {$ELSE}
      rcThread.Resume;
    {$ENDIF}
  end;
end;


{*******************************************************************************
*  Module: TAdsEvent.SetActive
*******************************************************************************}
procedure TAdsEvent.SetActive(const Value: boolean);
begin
  FActive := Value;
  ResetThread;
end;


{*******************************************************************************
*  Module: TAdsEvent.SetEvents
*******************************************************************************}
procedure TAdsEvent.SetEvents(const Value: TStrings);
begin
  FEvents.assign(Value);
end;

end.
