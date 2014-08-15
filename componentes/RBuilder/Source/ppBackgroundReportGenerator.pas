{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2003                    BBBBB   }

unit ppBackgroundReportGenerator;

interface

{x$Define CodeSite}

uses
  {$IFDEF CodeSite} rsCodeSite, {$ENDIF}
  Classes,
  ppComm, ppBackgroundContainerAdapter, ppBackgroundPrintRequest,
  ppProd, ppDevice;

type

{@TppBackgroundReportGenerator

  The thread uses the generator as a helper in order to fulfill the request
  to print the report in a background thread.

  The generator creates an adapter in order to create the container for which
  the report will reside. The thread needs a new instance of the form or
  datamodule in order to run in a separate thread to avoid conflicts with
  the multiple threads running the same report.}

  TppBackgroundReportGenerator = class(TppCommunicator)
    private
      FContainer: TppBackgroundContainerAdapter;
      FOnInitialized: TNotifyEvent;
      FExceptionRaised: Boolean;
      FExceptionMessage: String;

      procedure DoOnInitialized;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure ProcessRequest(aRequest: TppBackgroundPrintRequest);
      procedure Cancel;

      property OnInitialized: TNotifyEvent read FOnInitialized write FOnInitialized;
      property ExceptionRaised: Boolean read FExceptionRaised;
      property ExceptionMessage: String read FExceptionMessage;

    end;

implementation

uses
  SysUtils, Dialogs,
  ppTypes, ppUtils, ppViewr, ppFilDev, ppPrnDev;

{@TppBackgroundReportGenerator.Create }

constructor TppBackgroundReportGenerator.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FContainer := nil;
  FExceptionRaised := False;
  FExceptionMessage := '';
end;

{@TppBackgroundReportGenerator.Destroy }

destructor TppBackgroundReportGenerator.Destroy;
begin
  Cancel;

  FContainer.Free;

  inherited Destroy;
end;

{@TppBackgroundReportGenerator.ProcessRequest }

procedure TppBackgroundReportGenerator.ProcessRequest(aRequest: TppBackgroundPrintRequest);
var
  lProducer: TppProducer;
begin

{$IFDEF CodeSite}
  gCodeSite.EnterMethod('TppBackgroundReportGenerator.ProcessRequest');
{$ENDIF}

  lProducer := nil;

  try
    if (FContainer = nil) then
      begin
        try
          FContainer := TppBackgroundContainerAdapter.Create(aRequest);

          if (FContainer.ExceptionRaised) then
            begin
              FExceptionRaised := True;
              FExceptionMessage := FContainer.ExceptionMessage;

              FContainer.Free;
              FContainer := nil;
            end;
            
        except
          on E: EBackgroundPrintError do
            begin
              FContainer.Free;
              FContainer := nil;

              raise;
            end;
        end;
      end;
      
    if (FContainer <> nil) then
      lProducer := FContainer.Producer;

  finally
    DoOnInitialized;
  end;

  if (lProducer <> nil) then
    begin
      lProducer.BackgroundPrintSettings.Enabled := False;
      lProducer.BackgroundPrintSettings.Active := False;

      try
        lProducer.Print;

      except
        on E: Exception do
          begin
            FExceptionRaised := True;
            FExceptionMessage := 'TppBackgroundReportGenerator.ProcessRequest: Cannot Generate Report' + #13#10 + E.Message;
          end;

      end;

    end;

{$IFDEF CodeSite}
  gCodeSite.ExitMethod('TppBackgroundReportGenerator.ProcessRequest');
{$ENDIF}

end;

{@TppBackgroundReportGenerator.Cancel }

procedure TppBackgroundReportGenerator.Cancel;
begin
  if (FContainer <> nil) and (FContainer.Producer <> nil) then
    FContainer.Producer.Cancel;
end;

{@TppBackgroundReportGenerator.DoOnInitialized }

procedure TppBackgroundReportGenerator.DoOnInitialized;
begin
  if Assigned(FOnInitialized) then FOnInitialized(Self);
end;
     
end.
