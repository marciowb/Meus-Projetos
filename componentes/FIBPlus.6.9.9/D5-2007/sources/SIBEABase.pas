unit SIBEABase;

// SuperIB
// Copyright © 1999 David S. Becker
// dhbecker@jps.net
// www.jps.net/dhbecker/superib

// Revision History:
// 1.54     8/5/1999      Fixed a bug which would cause access violations or
//                        external exceptions on certain machines due to an
//                        internal race condition in which threads were getting
//                        freed before they were fully created.  Also finally
//                        got to the bottom of a problem which would cause
//                        the component to lock up for some people.  Basically
//                        calls to Synchronize() would sometimes fail to execute
//                        the intended code, effectively hanging the thread.  As
//                        it turns out, this is a problem in the classes unit of
//                        the VCL.  The RemoveThread function is calling
//                        PostMessage when it really should be calling SendMessage.
//                        Modifying the VCL is not a practical solution, so I've
//                        managed to work around the issue.
//
// 1.53     7/14/1999     Fixed access violation in SIBEventBlock by finding
//                        a new way to call the InterBase API function
//                        isc_event_block which did not involve assembly.  Also
//                        fixed a problem which would cause events not to be
//                        registered if you unregistered then re-registered events.
//
// 1.52     7/12/1999     Fixed a bug which would cause an access violation if
//                        the TSIBbdeEventAlerter gets destroyed before the
//                        TDatabase does.  Also made a change to try and fix a
//                        reported a random access violation which would occur
//                        in the SIBEventBlock procedure if compiled in the $O+
//                        state.  Thanks again to David Hildingsson!
//
// 1.51     7/10/1999     Fixed a bug in TSIBbdeEventAlerter which would
//                        cause an access violation when assigning the
//                        Database property at run time.  Thanks to David
//                        Hildingsson for finding this one.
//
// 1.50     7/8/1999      Major rearchitecture of the SuperIBEventAlerter
//                        class structure and naming conventions.  Created
//                        TSIBbdeEventAlerter, TSIBfibEventAlerter,
//                        TSIBiboEventAlerter. See the readme file for more info.
//
// 1.02     4/13/1999     If your TDatabase is not connected at design time,
//                        it is possible to assign a non-InterBase database.
//                        This would cause multiple cryptic exceptions to be
//                        raised when RegisterEvents was called.  Now checks
//                        for a valid InterBase connection earlier in the
//                        process and cleanly exits out of RegisterEvents
//                        with a single exception.
//
// 1.01     3/29/1999     Wait loop would eat up all available CPU cycles if
//                        nothing else was running.  Special thanks go to
//                        Chris Heberle for pointing this out and fixing it.
//
// 1.00     3/26/1999     Initial Release

{$I FIBPlus.inc}
{$T-}
interface

uses
  {$IFDEF WINDOWS}
   Windows, Messages,
  {$ENDIF}
  {$IFDEF LINUX}
   Libc,Types,
  {$ENDIF}
  SysUtils, Classes,SyncObjs, SIBGlobals, SIBAPI,ibase,IB_Intf,IB_Externals;

type
  TSIBEventThread = class;
  TSIBAlertEvent = procedure(Sender: TObject; EventName: string; EventCount: Longint) of object;

  { TSIBEventAlerter }

  TSIBEventAlerter = class(TComponent)
  protected
    { Private declarations }
    FClientLibrary:IIBClientLibrary;
    FOnEventAlert: TSIBAlertEvent;
    FEvents: TStrings;
    FThreads: TList;
    FNativeHandle: SIB_DBHandle;
    ThreadException: Boolean;
    procedure SetEvents(Value: TStrings);
    function GetRegistered: Boolean;
    procedure SetRegistered(const Value: Boolean);
  protected
    { Protected declarations }
    procedure SetNativeHandle(const Value: SIB_DBHandle); virtual;
    function GetNativeHandle: SIB_DBHandle; virtual;
    procedure EventChange(Sender: TObject); virtual;
    procedure ThreadEnded(Sender: TObject); virtual;
  public
    { Public declarations }
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    procedure RegisterEvents; virtual;
    procedure UnRegisterEvents; virtual;
    property NativeHandle: SIB_DBHandle read GetNativeHandle write SetNativeHandle;
    property Registered: Boolean read GetRegistered write SetRegistered;
  published
    { Published declarations }
    property Events: TStrings read FEvents write SetEvents;
    property OnEventAlert: TSIBAlertEvent read FOnEventAlert write FOnEventAlert;
  end;

  { TSIBEventThread }

  TSIBEventThread = class(TThread)
  private
    { Private declarations }
    // IB API call parameters
    FClientLibrary:IIBClientLibrary;
    WhichEvent: Integer;
    ErrorBuffer: PChar;
    ErrorVector: SIB_PStatusVector;
    StatusVector: SIB_StatusVector;
    ResultStatus: SIB_Status;
    EventID: SIB_Long;
    DB: SIB_DBHandle;
    EventBuffer: PChar;
    EventBufferLen: SIB_Long;
    ResultBuffer: PChar;
    // Local use variables
    Signal: TSimpleEvent;
    EventsReceived,
    FirstTime: Boolean;
    EventGroup,
    EventCount: Integer;
    Parent: TSIBEventAlerter;
    FExceptObject: TObject;
    FExceptAddr: Pointer;
  protected
    procedure Execute; override;
    procedure SignalEvent; virtual;
    procedure SignalTerminate; virtual;
    procedure RegisterEvents; virtual;
    procedure UnRegisterEvents; virtual;
    procedure QueueEvents; virtual;
    procedure ProcessEvents; virtual;
    function GetIBErrorString: String; virtual;
    procedure SIBQueEvents; virtual;
    procedure SIBInterpretError; virtual;
    procedure SIBEventCounts; virtual;
    procedure SIBFree; virtual;
    procedure SIBCancelEvents; virtual;
    procedure SIBEventBlock; virtual;
    procedure DoEvent; virtual;
    procedure DoHandleException; virtual;
    function HandleException: Boolean; virtual;
    procedure UpdateResultBuffer(Length: SIB_UShort; Updated: PChar); virtual;
  public
    constructor Create(ClientLibrary:IIBClientLibrary;Owner: TSIBEventAlerter; DBHandle: SIB_DBHandle; EventGrp: Integer; TermEvent: TNotifyEvent); virtual;
    destructor Destroy; override;
  end;

// You normally wouldn't register the TSIBEventAlerter base class directly,
// but if you aren't using BDE, FIB, or IBO, then you can uncomment this
// to use the component by accessing the raw InterBase handle.
// procedure Register;

implementation




// You normally wouldn't register the TSIBEventAlerter base class directly,
// but if you aren't using BDE, FIB, or IBO, then you can uncomment this
// to use the component by accessing the raw InterBase handle.
// procedure Register;
// begin
//   RegisterComponents('SuperIB', [TSIBEventAlerter]);
// end;

// This is the callback generated by IB when an event occurs.  It passes
// a pointer of our choosing (in this case, a pointer to the event thread
// which registered the callback) as well as an updated resultbuffer
// this callback occurs in a separate thread created by IB, and therefore
// we can't do anything that interacts with the VCL so we simply copy
// the resultbuffer and set a flag to notify the event thread that
// an event was received.  By doing this we effectively bring this separate
// thread back into our event thread, which then uses Synchronize() to
// call the event handler in the main thread -- making it totally VCL safe!
procedure EventCallback(P: Pointer; Length: SIB_UShort; Updated: PChar); cdecl;
begin
  if (Assigned(P) and Assigned(Updated)) then
  begin
    TSIBEventThread(P).UpdateResultBuffer(Length, Updated);
    TSIBEventThread(P).SignalEvent;
  end;
end;

{ TSIBEventThread }

// stub for synchronizing with main thread
procedure TSIBEventThread.SIBQueEvents;
begin
  ResultStatus :=
   SIB_QueEvents(FClientLibrary,@StatusVector, @DB, @EventID, EventBufferLen, EventBuffer, EventCallback, Self);
end;

// stub for synchronizing with main thread
procedure TSIBEventThread.SIBInterpretError;
begin
  ResultStatus :=FClientLibrary.isc_interprete( ErrorBuffer, PPISC_STATUS( @ErrorVector ) );
  Set8087CW(Default8087CW);
end;

        // stub for synchronizing with main thread
procedure TSIBEventThread.SIBEventCounts;
begin
  SIB_EventCounts(FClientLibrary,@StatusVector, EventBufferLen, EventBuffer, ResultBuffer);
end;

// stub for synchronizing with main thread
procedure TSIBEventThread.SIBFree;
begin
  SIB_Free(FClientLibrary,EventBuffer);
  EventBuffer := nil;
  SIB_Free(FClientLibrary,ResultBuffer);
  ResultBuffer := nil;
end;

// stub for synchronizing with main thread
procedure TSIBEventThread.SIBCancelEvents;
begin
  ResultStatus := SIB_CancelEvents(FClientLibrary,@StatusVector, @DB, @EventID);
  SIBFree
end;


// stub for synchronizing with main thread

procedure TSIBEventThread.SIBEventBlock;
var
  EBPArray : Array[1..SIB_MAX_EVENT_BLOCK] of PChar;
  i:integer;

  function EBP(Index: Integer): PChar;
  begin
    Inc(Index, (EventGroup * SIB_MAX_EVENT_BLOCK));
    if (Index > Parent.FEvents.Count) then
      Result := nil
    else
      Result := PChar(Parent.FEvents[Index - 1]);
  end;
begin
  EventCount := (Parent.FEvents.Count - (EventGroup * SIB_MAX_EVENT_BLOCK));
  if (EventCount > SIB_MAX_EVENT_BLOCK) then
    EventCount := SIB_MAX_EVENT_BLOCK;
  for i:=1 to  SIB_MAX_EVENT_BLOCK do
   EBPArray[i]:=EBP(i);

  EventBufferLen :=
   FClientLibrary.isc_event_block(@EventBuffer, @ResultBuffer, EventCount,
    EBPArray
   );
 Set8087CW(Default8087CW);
end;

// stub for synchronizing with main thread
procedure TSIBEventThread.DoEvent;

begin
  Parent.FOnEventAlert(Parent, Parent.FEvents[((EventGroup * SIB_MAX_EVENT_BLOCK) + WhichEvent)], StatusVector[WhichEvent])
end;

// called by the IB event callback to copy an update resultbuffer
// into our own storage space
procedure TSIBEventThread.UpdateResultBuffer(Length: SIB_UShort; Updated: PChar);
begin
  Move(Updated[0], ResultBuffer[0], Length);
end;

function TSIBEventThread.GetIBErrorString: String;
var
  Buffer: array[0..255] of Char;
  lastMsg: string;
  errCode: SIB_Status;
begin
  Result := EmptyStr;
  if Terminated then
    Exit;
  ErrorBuffer := @Buffer;
  ErrorVector := @StatusVector;
  repeat
    Synchronize(SIBInterpretError);      
    errCode := ResultStatus;
    if (lastMsg <> String(Buffer)) then
    begin
      lastMsg := String(Buffer);
      if (Length(Result) <> 0) then
        Result := Result + #13#10;
      Result := Result + lastMsg;
    end;
  until (errCode = 0);
end;

// tell IB to queue up the events and begin reporting them
// first time this is called generates a bogus notification
// to initialize the result buffer
procedure TSIBEventThread.QueueEvents;
begin
  EventsReceived := False;
  if not Terminated then
  begin
   Signal.ResetEvent;
   Synchronize(SIBQueEvents);
   if (ResultStatus <> 0) then
    raise ESIBError.Create(GetIBErrorString);
  end;
end;

// call the event handler for any events received
procedure TSIBEventThread.ProcessEvents;
var
  i: Integer;
begin
  // find out how many and which events occured
  if Terminated then
   Exit;
  Synchronize(SIBEventCounts);

  // the first time we come in here is a bogus initialization call, so don't
  // actually do anything
  if (Assigned(Parent.FOnEventAlert) and (not FirstTime)) then
  begin
    for i := 0 to (EventCount - 1) do
    begin
        // if this particular event occured, call the event handler
        if (StatusVector[i] <> 0) then
        begin
          WhichEvent := i;
          Synchronize(DoEvent);
        end;
    end;
  end;
  FirstTime := False;
end;

// tell IB to cancel the event notification and
// release the various event buffers
procedure TSIBEventThread.UnRegisterEvents;
begin
  {$IFNDEF D6+}
    Synchronize(SIBCancelEvents);
  {$ELSE}
    SIBCancelEvents;
  {$ENDIF}

  if (ResultStatus <> 0) then
    raise ESIBError.Create(GetIBErrorString);
end;

// setup the various event buffers with IB
procedure TSIBEventThread.RegisterEvents;
begin
  if Terminated then
   Exit; 
  EventBuffer := nil;
  ResultBuffer := nil;
  EventBufferLen := 0;
  FirstTime := True;

  // figure out how many events are in the group we've been assigned
  EventCount := (Parent.FEvents.Count - (EventGroup * SIB_MAX_EVENT_BLOCK));
  if (EventCount > SIB_MAX_EVENT_BLOCK) then
    EventCount := SIB_MAX_EVENT_BLOCK;
  Synchronize(SIBEventBlock);
end;

// indicate than an event was received, and stop waiting
procedure TSIBEventThread.SignalEvent;
begin
   EventsReceived := True;
   Signal.SetEvent;
end;

// indicate termination desired, and stop waiting
procedure TSIBEventThread.SignalTerminate;
begin
   if not Terminated then
   begin
     Terminate;
     Signal.SetEvent;
   end;
end;

procedure TSIBEventThread.DoHandleException;
begin
  SysUtils.ShowException(FExceptObject, FExceptAddr);
end;

function TSIBEventThread.HandleException: Boolean;
begin
  // if a thread exception has already occurred, then
  // don't show another one
  if not Parent.ThreadException then
  begin
    Result := True;
    Parent.ThreadException := True;
    FExceptObject := ExceptObject;
    FExceptAddr := ExceptAddr;
    try
      if not (FExceptObject is EAbort) then
        Synchronize(DoHandleException);
    finally
      FExceptObject := nil;
      FExceptAddr := nil;
    end;
  end
  else
    Result := False;
end;

{$IFDEF LINUX}
 const
  INFINITE=$FFFFFFFF;
{$ENDIF}
// set everything up with IB and sit in a loop
// waiting for events to be received
procedure TSIBEventThread.Execute;
begin
  RegisterEvents;
  QueueEvents;

  try
    repeat
      // wait for an event to be signaled
      Signal.WaitFor(INFINITE);
      if EventsReceived then
      begin
        // handle any events that were received
        ProcessEvents;
        // queue the events
        QueueEvents;
      end;
    until Terminated;
    // thread completed OK
    ReturnValue := 0;
  except
    // thread had a problem, if we're the first
    // thread to report handle the problem, return
    // with an error code, otherwise return OK
    if HandleException then
      ReturnValue := 1
    else
      ReturnValue := 0;
  end;
end;

constructor TSIBEventThread.Create(ClientLibrary:IIBClientLibrary;Owner: TSIBEventAlerter; DBHandle: SIB_DBHandle; EventGrp: Integer; TermEvent: TNotifyEvent);
begin
  inherited Create(True);
  FClientLibrary:=ClientLibrary;
  Signal := TSimpleEvent.Create;
  Parent := Owner;
  DB := DBHandle;
  EventGroup := EventGrp;
  OnTerminate := TermEvent;
  FreeOnTerminate := False;
  Resume;
end;

destructor TSIBEventThread.Destroy;
begin
  try
     UnRegisterEvents;
  except
    // thread had a problem, if we're the first
    // thread to report handle the problem, return
    // with an error code, otherwise return OK
   try
    if HandleException then
      ReturnValue := 1
    else
      ReturnValue := 0;
   except
   end;
  end;
  Signal.Free;
  FClientLibrary:=nil;
  inherited Destroy;
end;

{ TSIBEventAlerter }

// are there any event threads running
function TSIBEventAlerter.GetRegistered: Boolean;
begin
  Result := (FThreads.Count > 0);
end;

// loop through all the running event threads and kill them
procedure TSIBEventAlerter.UnRegisterEvents;
var
  i: Integer;
  Temp: TSIBEventThread;
begin
  if (FThreads.Count > 0) then
  begin
    for i := (FThreads.Count - 1) downto 0 do
    begin
      Temp := TSIBEventThread(FThreads[i]);
      FThreads.Delete(i);
      Temp.SignalTerminate;
      Temp.WaitFor;
      Temp.Free;
    end;
  end
  else
    raise ESIBError.Create(SIB_RS_NOT_REGISTERED);
end;

// calculate how many event threads we need to hold the events
// and create them
procedure TSIBEventAlerter.RegisterEvents;
var
  i: Integer;
  DBH: SIB_DBHandle;
begin
  if (FThreads.Count = 0) then
  begin
    DBH := NativeHandle;
    if (FEvents.Count > 0) then
    begin
      for i := 0 to ((FEvents.Count - 1) div SIB_MAX_EVENT_BLOCK) do
        FThreads.Add(TSIBEventThread.Create(FClientLibrary,Self, DBH, i, ThreadEnded));
    end;
  end
  else
    raise ESIBError.Create(SIB_RS_ALREADY_REGISTERED);
end;

// validates the event names being assigned
procedure TSIBEventAlerter.EventChange(Sender: TObject);
var
  i: Integer;
  TooLong,
  AnyEmpty,
  WasRegistered: Boolean;
  ErrorStr: String;
begin
  ErrorStr := EmptyStr;
  WasRegistered := Registered;
  try
    if WasRegistered then
      UnRegisterEvents;

    TStringList(FEvents).OnChange := nil;
    try
      TooLong := False;
      AnyEmpty := False;
      // loop through all the string being assigned looking for errors
      for i := (FEvents.Count - 1) downto 0 do
      begin
        if (FEvents[i] = EmptyStr) then
        begin
          // can't have empty strings as events
          AnyEmpty := True;
          FEvents.Delete(i);
        end
        else
        if (Length(FEvents[i]) > (SIB_MAX_EVENT_LENGTH - 1)) then
        begin
          // can't have strings longer than EVENT_LENGTH
          TooLong := True;
//          FEvents[i] := Copy(FEvents[i], 1, (SIB_MAX_EVENT_LENGTH - 1));
        end;
      end;
      // build the error message
      if AnyEmpty then
        ErrorStr := ErrorStr + SIB_RS_EMPTY_STRINGS;
      if TooLong then
        ErrorStr := ErrorStr + Format(SIB_RS_TOO_LONG, [(SIB_MAX_EVENT_LENGTH - 1)]);

      // and return it
      if (ErrorStr <> EmptyStr) then
        raise ESIBError.Create(ErrorStr);
    finally
      TStringList(FEvents).OnChange := EventChange;
    end;
  finally
    if WasRegistered then
      RegisterEvents;
  end;
end;

procedure TSIBEventAlerter.SetEvents(Value: TStrings);
begin
  FEvents.Assign(Value);
end;

constructor TSIBEventAlerter.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  ThreadException := False;

  FOnEventAlert := nil;
  FNativeHandle := nil;

  FEvents := TStringList.Create;
  with TStringList(FEvents) do
  begin
    OnChange   := EventChange;  // assign the routine which validates the event lenghts
    Duplicates := dupIgnore;  // don't allow duplicate events
    Sorted     := True;
  end;

  FThreads := TList.Create;

end;

destructor TSIBEventAlerter.Destroy;
begin
 try
  if Registered then
    UnRegisterEvents;
 except
 end;
  FThreads.Free;
  FEvents.Free;
  FClientLibrary:=nil;
  inherited Destroy;
end;

procedure TSIBEventAlerter.SetNativeHandle(const Value: SIB_DBHandle);
var
  WasRegistered: Boolean;
begin
  if (FNativeHandle <> Value) then
  begin
    WasRegistered := Registered;
    if WasRegistered then
      UnRegisterEvents;
    try
      FNativeHandle := Value;
    finally
      if WasRegistered then
        RegisterEvents;
    end;
  end;
end;

procedure TSIBEventAlerter.SetRegistered(const Value: Boolean);
begin
  if Value then
    RegisterEvents
  else
  try
    UnRegisterEvents;
  except
  end  
end;

procedure TSIBEventAlerter.ThreadEnded(Sender: TObject);
var
  ThreadIdx: Integer;
begin
  if (Sender is TSIBEventThread) then
  begin
    // Remove terminating thread from thread list
    ThreadIdx := FThreads.IndexOf(Sender);
    if (ThreadIdx > -1) then
      FThreads.Delete(ThreadIdx);

    // if any thread had an exception, then unregister everything
    if (TSIBEventThread(Sender).ReturnValue = 1) then
    begin
      if Registered then
        UnRegisterEvents;

      // Clear the thread exception
      ThreadException := False;
    end
  end;
end;

function TSIBEventAlerter.GetNativeHandle: SIB_DBHandle;
begin
  Result := FNativeHandle;
end;




end.

