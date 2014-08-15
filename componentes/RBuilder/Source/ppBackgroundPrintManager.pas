{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2003                    BBBBB   }

unit ppBackgroundPrintManager;

interface

uses
  Classes, SyncObjs, SysUtils, Forms,
  ppBackgroundPrintThread, ppBackgroundThreadSync, ppDevice, ppBackgroundPrintQueue;

type

  {@TppBackgroundPrintManager

    Use the BackgroundPrintManager to handle the background printing process. Call
    the manager's Print method passing a TppProducer descendent and a
    properly confired TppPageRequest object. This starts the background print
    process.

    Before closing an application, which is generating reports in a background
    thread, check the gBackgroundPrintManager global object in the
    ppBackgroundPrintManager unit. Evaluate the value of
    gBackgroundPrintManager.QueueSize if it is non-zero in
    order to create a message to notify the user that there are still reports
    which are being generated in a background thread.

    Use the OnThreadTerminated event to listen when a report has finished
    printing in the background thread. Check the QueueSize
    property to determine if no more background thread request are left to be
    executed in a background thread.

    When a report should be printed in the background, pass the report object to
    the print method of the gBackgroundPrintManager global object in this unit.
    The print method also should receive the current PageRequest from the print
    dialog.}

  {@TppBackgroundPrintManager.OnAllThreadsTerminated

    Use this event to be notified that there are no more background print jobs
    to be processed. All the threads have Terminatedd execution.}

  {@TppBackgroundPrintManager.OnException

    If an exception is raised in the background print thread during creation
    of the container, this event will fire when the thread is terminating.
    The default behavior is that a message box is displayed showing the
    exception class of the exception which was handled and the message of
    that exception. If this event is assigned, then the message box will
    not be displayed. Most likely, the container form or datamodule is not
    threadsafe and needs to be made thread safe before printing the report
    in a background thread. An exception is passed in the event which
    includes the message information of the original exception.}

  {@TppBackgroundPrintManager.OnThreadTerminated

    Use this event in order to be notified when the each indivisual background
    print job has been processed and sent to the selected device. Use this
    event to get feedback about the progress when multiple reports are being
    generated in the background.}

  {@TppBackgroundPrintManager.QueueSize

    Read this property in order to determine how many background print requests
    remain in the queue to be processed, generated and ultimately sent to the
    device. The background printing queue is FIFO.}

  {@TppBackgroundPrintManager.ThreadPriority

    Set this property at runtime in order to increase the priority that background
    print threads use. The lowest setting is recommended in order to have the best
    performance from the main application while the background thread is
    executing.

    This is a pass through to the thread's Priority property when the background
    thread is instantiated.}

  TppBackgroundPrintManager = class
    private
      FQueue: TppBackgroundPrintQueue;
      FLock: TCriticalSection;
      FOnAllThreadsTerminated: TNotifyEvent;
      FOnException: TExceptionEvent;
      FOnThreadTerminated: TNotifyEvent;
      FThreadPriority: TThreadPriority;

      procedure DoOnAllThreadsTerminated;
      procedure DoOnThreadTerminated;
      procedure DoOnException;
      function GetQueueSize: Integer;
      procedure ThreadTerminatedEvent(Sender: TObject);
      procedure SetThreadPriority(aThreadPriority: TThreadPriority);

    public
      constructor Create; virtual;
      destructor Destroy; override;

      procedure Cancel;
      procedure Print(aProducer: TObject; aPageRequest: TppPageRequest; const aDeviceType, aArchiveFileName, aTextFileName: String);

      property OnAllThreadsTerminated: TNotifyEvent read FOnAllThreadsTerminated write FOnAllThreadsTerminated;
      property OnException: TExceptionEvent read FOnException write FOnException;
      property OnThreadTerminated: TNotifyEvent read FOnThreadTerminated write FOnThreadTerminated;
      property QueueSize: Integer read GetQueueSize;
      property ThreadPriority: TThreadPriority read FThreadPriority write SetThreadPriority;

    end;

var
  gBackgroundPrintManager: TppBackgroundPrintManager = nil;

implementation

uses
  Dialogs,
  ppClass, ppArchiv,
  ppBackgroundPrintRequest, ppTypes;

{@TppBackgroundPrintManager.Create }

constructor TppBackgroundPrintManager.Create;
begin

  inherited Create;

  FQueue := TppBackgroundPrintQueue.Create;
  FQueue.OnThreadTerminated := ThreadTerminatedEvent;

  FThreadPriority := tpLowest;

  FQueue.ThreadPriority := FThreadPriority;

  FLock := TCriticalSection.Create;

  FOnAllThreadsTerminated := nil;
  FOnException := nil;
  FOnThreadTerminated := nil;

end;

{@TppBackgroundPrintManager.Destroy }

destructor TppBackgroundPrintManager.Destroy;
begin

  FLock.Acquire;

  try
    Cancel;

  finally
    FQueue.Free;

    FLock.Release;

    FLock.Free;
  end;

  inherited Destroy;

end;

{@TppBackgroundPrintManager.Print

  Print the report in the background. Calling this routine does not mean that
  the report will generate immediately in a background thread. For optimization,
  the background printing is handled via a FIFO queue.}

procedure TppBackgroundPrintManager.Print(aProducer: TObject; aPageRequest: TppPageRequest; const aDeviceType, aArchiveFileName, aTextFileName: String);
var
  lRequest: TppBackgroundPrintRequest;
begin

  FLock.Acquire;

  try

    if not((aProducer is TppCustomReport) or (aProducer is TppCustomArchiveReader)) then
      raise EBackgroundPrintError.Create('TppBackgroundPrintManager.Print: Background printing not supported for ' + aProducer.ClassName);

    try
      lRequest := TppBackgroundPrintRequest.Create(aProducer, aPageRequest, aDeviceType, aArchiveFileName, aTextFileName);

      FQueue.Add(lRequest);

    except
      on E: EBackgroundPrintError do
        FQueue.Flush;
    end;

  finally
    FLock.Release;
  end;

end;
  
{@TppBackgroundPrintManager.Cancel

  Cancels the currently generating report thread and cancels all remaining
  queued background print requests.}

procedure TppBackgroundPrintManager.Cancel;
begin

  FLock.Acquire;

  try
    FQueue.Flush;

  finally
    FLock.Release;
  end;

end;

{@TppBackgroundPrintManager.GetQueueSize }

function TppBackgroundPrintManager.GetQueueSize: Integer;
begin

  FLock.Acquire;

  try
    Result := FQueue.Size;

  finally
    FLock.Release;
  end;

end;

{@TppBackgroundPrintManager.ThreadTerminatedEvent }

procedure TppBackgroundPrintManager.ThreadTerminatedEvent(Sender: TObject);
begin

  DoOnException;

  DoOnThreadTerminated;

  if (GetQueueSize = 0) then
    DoOnAllThreadsTerminated;

end;
     
{@TppBackgroundPrintManager.DoOnException }

procedure TppBackgroundPrintManager.DoOnException;
begin

  if FQueue.ExceptionRaised then
    begin
      if Assigned(FOnException) then
        begin
          FOnException(Self, Exception.Create(FQueue.ExceptionMessage))
        end
      else
        MessageDlg(FQueue.ExceptionMessage, mtWarning, [mbOK], 0);
    end;

end;

{@TppBackgroundPrintManager.DoOnAllThreadsTerminated }

procedure TppBackgroundPrintManager.DoOnAllThreadsTerminated;
begin
  if Assigned(FOnAllThreadsTerminated) then FOnAllThreadsTerminated(Self);
end;

{@TppBackgroundPrintManager.DoOnThreadTerminated }

procedure TppBackgroundPrintManager.DoOnThreadTerminated;
begin
  if Assigned(FOnThreadTerminated) then FOnThreadTerminated(Self);
end;

{@TppBackgroundPrintManager.SetThreadPriority }

procedure TppBackgroundPrintManager.SetThreadPriority(aThreadPriority: TThreadPriority);
begin

  FLock.Acquire;

  try
    FThreadPriority := aThreadPriority;

    FQueue.ThreadPriority := FThreadPriority;

  finally
    FLock.Release;
  end;
  
end;

initialization
  gBackgroundPrintManager := TppBackgroundPrintManager.Create;

finalization
  if (gBackgroundPrintManager <> nil) then
    gBackgroundPrintManager.Cancel;

  gBackgroundPrintManager.Free;
  gBackgroundPrintManager := nil;
  
end.
