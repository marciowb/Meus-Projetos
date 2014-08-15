{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2003                    BBBBB   }

unit ppBackgroundPrintQueue;

interface

uses
  Classes, SyncObjs,
  ppBackgroundPrintRequest, ppBackgroundPrintThread;

type

  {@TppBackgroundPrintQueue

    This class is a FIFO queue that stores the requests so that they can be
    processed in the order they are received.

    Call Add passing a configured TppBackgroundPrintRequest object. Always
    configure the request before calling this method.

    Use Flush to clear the queue of requests and to cancel the currently
    executing background thread.}

  {@TppBackgroundPrintQueue.OnThreadTerminated

    Use this event to determine when a background print thread has finsihed
    printing. In the event handler, check the Size property to determine if
    this was the last background thread which will print. Use this combination
    to determine if the application can close, or if there are background print
    requests which need to be fulfilled before the application can shutdown.}

  {@TppBackgroundPrintQueue.Size

    Returns the number of background print requests in the queue.}

  {@TppBackgroundPrintManager.ThreadPriority

    Set this property at runtime in order to increase the priority that background
    print threads use. The lowest setting is recommended in order to have the best
    performance from the main application while the background thread is executing.

    This is a pass through to the TThread.Priority property when the background
    thread gets created.}

  TppBackgroundPrintQueue = class
    private
      FExceptionRaised: Boolean;
      FExceptionMessage: String;
      FFlushing: Boolean;
      FLock: TCriticalSection;
      FRequests: TList;
      FThread: TppBackgroundPrintThread;
      FOnThreadTerminated: TNotifyEvent;
      FThreadPriority: TThreadPriority;

      procedure DoOnThreadTerminated;
      procedure PrintingThreadTerminateEvent(Sender: TObject);
      procedure PrintNextRequest;
      function GetSize: Integer;
      procedure RaiseException(const aMessage: String);
      procedure SetThreadPriority(aThreadPriority: TThreadPriority);

    public
      constructor Create; virtual;
      destructor Destroy; override;

      procedure Add(aRequest: TppBackgroundPrintRequest);
      procedure Flush;

      property ExceptionRaised: Boolean read FExceptionRaised;
      property ExceptionMessage: String read FExceptionMessage;
      property Size: Integer read GetSize;
      property ThreadPriority: TThreadPriority read FThreadPriority write SetThreadPriority;
      property OnThreadTerminated: TNotifyEvent read FOnThreadTerminated write FOnThreadTerminated;

    end;

implementation

uses
  ppTypes, Forms;

{@TppBackgroundPrintQueue.Create }

constructor TppBackgroundPrintQueue.Create;
begin

  inherited Create;

  FExceptionRaised := False;
  FExceptionMessage := '';
  FLock := TCriticalSection.Create;
  FFlushing := False;
  FOnThreadTerminated := nil;
  FRequests := TList.Create;
  FThread := nil;
  FThreadPriority := tpLowest;
end;

{@TppBackgroundPrintQueue.Destroy }

destructor TppBackgroundPrintQueue.Destroy;
var
  liIndex: Integer;
begin

  FLock.Free;

  for liIndex := FRequests.Count - 1 downto 0 do
    TObject(FRequests[0]).Free;

  FRequests.Free;

  inherited Destroy;

end;

{@TppBackgroundPrintQueue.Add

  Use this method to add a background print request to be processed. Pass
  a TppBackgroundPrintRequest object. Configure the request before calling
  this method. The queue reads the requests off in a FIFO manner.}

procedure TppBackgroundPrintQueue.Add(aRequest: TppBackgroundPrintRequest);
begin

  FLock.Acquire;
                                   
  try
    if (aRequest = nil) then
      RaiseException('TppBackgroundPrintQueue.Add: The background print request may not be nil.');

    FRequests.Add(aRequest);

    if (FRequests.Count = 1) then
      PrintNextRequest;

  finally
    FLock.Release;
  end;

end;

{@TppBackgroundPrintQueue.Flush

  Use Flush to clear the queue of requests and to cancel the currently executing
  background thread.}

procedure TppBackgroundPrintQueue.Flush;
var
  liIndex: Integer;
begin

  FLock.Acquire;

  try
    FFlushing := True;

    if (FThread <> nil) and not(FThread.Terminated) then
      FThread.Cancel;

    for liIndex := FRequests.Count - 1 downto 0 do
      begin
        TObject(FRequests[0]).Free;
        FRequests.Delete(0);
      end;

  finally
    FFlushing := False;
    FLock.Release;
  end;

end;

{@TppBackgroundPrintQueue.PrintNextRequest }

procedure TppBackgroundPrintQueue.PrintNextRequest;
var
  lRequest: TppBackgroundPrintRequest;
begin

  if (FRequests.Count > 0) then
    begin
      lRequest := TppBackgroundPrintRequest(FRequests[0]);

      FFlushing := False;

      FThread := TppBackgroundPrintThread.Create;
      FThread.Priority := FThreadPriority;
      FThread.FreeOnTerminate := True;
      FThread.OnTerminate := PrintingThreadTerminateEvent;

      FThread.ProcessRequest(lRequest);
    end
  else
    FThread := nil;

end;

{@TppBackgroundPrintQueue.PrintingThreadTerminateEvent }

procedure TppBackgroundPrintQueue.PrintingThreadTerminateEvent(Sender: TObject);
begin

  if not(Sender is TppBackgroundPrintThread) then
    RaiseException('TppBackgroundPrintManager.PrintingThreadTerminateEvent: Sender of thread OnTerminate is not a TppBackgroundPrintThread');

  if not(FFlushing) and (FRequests.Count > 0) then
    begin
      TObject(FRequests[0]).Free;
      FRequests.Delete(0);

      if (FThread.ExceptionRaised) then
        RaiseException(FThread.ExceptionMessage);

      PrintNextRequest;
    end;

  DoOnThreadTerminated;

end;

{@TppBackgroundPrintQueue.GetSize }

function TppBackgroundPrintQueue.GetSize: Integer;
begin

  FLock.Acquire;

  try
    Result := FRequests.Count;
    
 finally
    FLock.Release;
  end;

end;
  
{@TppBackgroundPrintQueue.RaiseException }

procedure TppBackgroundPrintQueue.RaiseException(const aMessage: String);
begin
  FExceptionRaised := True;
  FExceptionMessage := aMessage;
end;

{@TppBackgroundPrintQueue.DoOnThreadTerminated }

procedure TppBackgroundPrintQueue.DoOnThreadTerminated;
begin
  if Assigned(FOnThreadTerminated) then FOnThreadTerminated(Self);
end;
 
{@TppBackgroundPrintQueue.SetThreadPriority }

procedure TppBackgroundPrintQueue.SetThreadPriority(aThreadPriority: TThreadPriority);
begin
  FThreadPriority := aThreadPriority;
end;

end.
