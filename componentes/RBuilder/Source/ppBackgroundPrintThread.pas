{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2003                    BBBBB   }

unit ppBackgroundPrintThread;

interface

{$I ppIfDef.pas}

{x$Define CodeSite}

uses
  {$IFDEF CodeSite} rsCodeSite, {$ENDIF}
  Classes, SysUtils, ppBackgroundThreadSync,
  ppBackgroundPrintRequest, ppBackgroundReportGenerator;

type

  {@TppBackgroundPrintThread

    Use this thread class to print a report while the main application continues
    interacting with the user. Create a TppBackgroundPrintRequest object and
    pass it to the Print method of this class to start the background
    printing process.}

  TppBackgroundPrintThread = class(TThread)
    private
      FExceptionRaised: Boolean;
      FExceptionMessage: String;
      FGeneratorSignalReceived: Boolean;
      FInitialized: Boolean;
      FGenerator: TppBackgroundReportGenerator;
      FRequest: TppBackgroundPrintRequest;
      FPrinting: Boolean;
      FThreadSync: TppThreadSync;

      procedure GeneratorInitializedHandler(Sender: TObject);
      function GetID: Integer;
      procedure WaitUntilNotified;
      procedure GenerateReport;
      procedure ProcessMessages;
      procedure RaiseException(const aMessage: String);

    protected
      procedure Execute; override;

    public
      constructor Create; virtual;
      destructor Destroy; override;

      procedure ProcessRequest(aRequest: TppBackgroundPrintRequest);
      procedure Cancel;

      property ID: Integer read GetID;
      property Terminated;
      property ExceptionRaised: Boolean read FExceptionRaised;
      property ExceptionMessage: String read FExceptionMessage;

  end;


implementation

uses
  ActiveX, SyncObjs, Forms, Dialogs,
  ppTypes, ppUtils;

{@TppBackgroundPrintThread.Create }

constructor TppBackgroundPrintThread.Create;
begin

  inherited Create(True); {suspended}

  FExceptionRaised := False;
  FExceptionMessage := '';
  FGeneratorSignalReceived := False;
  FInitialized := False;
  FPrinting := False;
  FRequest := nil;
  FGenerator := nil;
  FThreadSync := TppThreadSync.Create;

end;

{@TppBackgroundPrintThread.Destroy }

destructor TppBackgroundPrintThread.Destroy;
begin

  FThreadSync.Free;
  FGenerator.Free;

  inherited Destroy;

end;

{@TppBackgroundPrintThread.ProcessRequest }

procedure TppBackgroundPrintThread.ProcessRequest(aRequest: TppBackgroundPrintRequest);
var
  lsMessage: String;
begin

{$IFDEF CodeSite}
  gCodeSite.EnterMethod('TppBackgroundPrintThread.Print');
{$ENDIF}

  FInitialized := False;

  FRequest := aRequest;

  {start thread execution}
{$IFDEF Delphi14}
  Start;
{$ELSE}
  Resume;
{$ENDIF}

  try
    WaitUntilNotified;

  except
    on E: EBackgroundPrintTimeoutError do
      begin
        Cancel;

        lsMessage := E.Message + #13#10 + 'Container class: ' + FRequest.OwnerClass.ClassName + #13#10;

        RaiseException(lsMessage);
      end
  end;

{$IFDEF CodeSite}
  gCodeSite.SendString('TppBackgroundPrintThread.Print',  'WaitUntilNotified complete.');
{$ENDIF}

end;

{@TppBackgroundPrintThread.WaitUntilNotified

  Wait up to 10 seconds in the main thread for spawned thread to create the
  container before continuing in the main thread.}

procedure TppBackgroundPrintThread.WaitUntilNotified;
var
  liIntervalsPerSecond: Integer;
  liMSInterval: Integer;
  liSeconds: Integer;
  liIndex: Integer;
  lWaitResult: TWaitResult;
begin

  if (FThreadSync <> nil) then
    begin

      FInitialized := False;

      liIndex := 0;
      liSeconds := 10;
      liMSInterval := 250;
      liIntervalsPerSecond := 1000 div liMSInterval;
      lWaitResult := wrTimeout;

      {when a form that is autocreated and is visible, and is not the main form,
      then the creation takes longer and need to attempt to wait until it is
      finished by calling Application.ProcessMessages in order to workaround
      a hangup on the persistence setting of the visible property when the form
      is streamed up.}
      while (liIndex < (liSeconds * liIntervalsPerSecond)) and (lWaitResult <> wrSignaled) and not(FInitialized) do
        begin
          lWaitResult := FThreadSync.WaitFor(liMSInterval);

          if (lWaitResult <> wrSignaled) and not(FInitialized) then
            ProcessMessages;

          Inc(liIndex);
        end;

      if (lWaitResult <> wrSignaled) and not(FInitialized) then
        begin
          FThreadSync.ResetEvent;

          RaiseException('TppBackgroundPrintThread.PrintInBackground: ' + IntToStr(liSeconds) + ' second timeout exceeded for background printing thread to create report container');
        end;

    end;

end;

{@TppBackgroundPrintThread.ProcessMessages  }

procedure TppBackgroundPrintThread.ProcessMessages;
begin
  Application.ProcessMessages;
end;

{@TppBackgroundPrintThread.Execute  }

procedure TppBackgroundPrintThread.Execute;
begin

{$IFDEF CodeSite}
  gCodeSite.EnterMethod('TppBackgroundPrintThread.Execute');
{$ENDIF}

  CoInitialize(nil);

  try

    try
      GenerateReport;

    except
      on E: Exception do
        Terminate;
    end;

  finally
    CoUnInitialize;

  end;

end;
    
{@TppBackgroundPrintThread.GenerateReport }

procedure TppBackgroundPrintThread.GenerateReport;
begin

  if Terminated then Exit;

  FGenerator := TppBackgroundReportGenerator.Create(nil);
  FGenerator.OnInitialized := GeneratorInitializedHandler;

  try
    FPrinting := True;

    ppBeginBackgroundPrinting;

    try
      if not(Terminated) then
        FGenerator.ProcessRequest(FRequest);

    finally
      if (FGenerator.ExceptionRaised) then
        RaiseException(FGenerator.ExceptionMessage);

      ppEndBackgroundPrinting;
    end;

    FPrinting := False;

  finally
    if (FGenerator <> nil) then
      begin
        FGenerator.Free;
        FGenerator := nil;
      end;

  end;

{$IFDEF CodeSite}
  gCodeSite.ExitMethod('TppBackgroundPrintThread.Execute');
{$ENDIF}

end;


{@TppBackgroundPrintThread.GetID }

function TppBackgroundPrintThread.GetID: Integer;
begin
  Result := ThreadID;
end;

{@TppBackgroundPrintThread.GeneratorInitializedHandler }

procedure TppBackgroundPrintThread.GeneratorInitializedHandler(Sender: TObject);
begin

{$IFDEF CodeSite}
  gCodeSite.SendString('TppBackgroundPrintThread.FinishedWithRequestEvent',  'The main thread can continue.');
{$ENDIF}

  FInitialized := True;

  if (FThreadSync <> nil) then
    FThreadSync.SetEvent;

end;

{@TppBackgroundPrintThread.Cancel }

procedure TppBackgroundPrintThread.Cancel;
begin

  if not(Terminated) and not(Suspended) and (FGenerator <> nil) then
    FGenerator.Cancel;

end;
  
{@TppBackgroundPrintThread.RaiseException }

procedure TppBackgroundPrintThread.RaiseException(const aMessage: String);
begin
  FExceptionRaised := True;
  FExceptionMessage := aMessage;
end;

end.
