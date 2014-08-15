{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2003                    BBBBB   }

unit ppBackgroundContainerAdapter;

interface

{x$Define CodeSite}

uses
  {$IFDEF CodeSite} rsCodeSite,{$ENDIF}
  Classes, ppTypes, ppPrintr, ppDevice, ppRTTI, SysUtils,
  ppComm, ppProd, ppBackgroundPrintRequest, ppASField;

type

{@TppBackgroundContainerAdapter

  Use this adapter to create the form or datamodule that the background
  print thread will use to print the report. This enables the report to
  utilize the event handlers and data access components which the
  report needs in order to print in a separate instance than the report in
  the main thread.

  Use the constructor to pass a BackgroundPrintRequest so that the adapter can
  create the container and report.

  Read the producer property to access the report which will be executed in
  the background thread. }

  TppBackgroundContainerAdapter = class
    private
      FPageRequest: TppPageRequest;
      FPrinterSetup: TppPrinterSetup;
      FContainer: TComponent;
      FProducer: TppProducer;
      FWalkieTalkie: TppCommunicator;
      FExceptionRaised: Boolean;
      FExceptionMessage: String;

      procedure ApplicationExceptionHandler(Sender: TObject; E: Exception);
      function CreateContainer(aRequest: TppBackgroundPrintRequest): TComponent;
      function CreateOwner(aOwnerClass: TComponentClass): TComponent;
      procedure ProcessRequest(aRequest: TppBackgroundPrintRequest);
      procedure RaiseException(const aMessage: String);
      procedure WalkieTalkieEventNotifyHandler(Sender: TObject; aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);

    public
      constructor Create(aRequest: TppBackgroundPrintRequest); virtual;
      destructor Destroy; override;

      property Producer: TppProducer read FProducer;
      property ExceptionRaised: Boolean read FExceptionRaised;
      property ExceptionMessage: String read FExceptionMessage;

    end;

implementation

uses
  Forms, Controls, 
  ppAutoSearchRTTI, ppReportTemplateRTTI, ppUtils, ppArchiv;

{@TppBackgroundContainerAdapter.Create }

constructor TppBackgroundContainerAdapter.Create(aRequest: TppBackgroundPrintRequest);
begin

  inherited Create;

  FExceptionRaised := False;
  FExceptionMessage := '';

  FProducer := nil;
  FContainer := nil;

  FPrinterSetup := TppPrinterSetup.Create(nil);
  FPageRequest := TppPageRequest.Create;

  FWalkieTalkie := TppCommunicator.Create(nil);
  FWalkieTalkie.EventNotifies := FWalkieTalkie.EventNotifies + [ciProducerBeforePrint, ciInitializePrinterSetup];
  FWalkieTalkie.OnEventNotify := WalkieTalkieEventNotifyHandler;

  ProcessRequest(aRequest);

end;

{@TppBackgroundContainerAdapter.Destroy }

destructor TppBackgroundContainerAdapter.Destroy;
begin

  GlobalNameSpace.BeginWrite;

  try
    FPageRequest.Free;
    FPrinterSetup.Free;
    FContainer.Free;
    FWalkieTalkie.Free;

  finally
    GlobalNameSpace.EndWrite;
  end;

  inherited Destroy;

end;

{@TppBackgroundContainerAdapter.ProcessRequest }

procedure TppBackgroundContainerAdapter.ProcessRequest(aRequest: TppBackgroundPrintRequest);
begin

  GlobalNameSpace.BeginWrite;

  try
    try
      FContainer := CreateContainer(aRequest);

    except
      on E: EBackgroundPrintError do
        begin
          FContainer.Free;
          FContainer := nil;

          raise;
        end;
    end;

  finally
    GlobalNameSpace.EndWrite;
  end;

  if (FContainer <> nil) then
    begin
      TppReportTemplateRTTI.LoadFromReportStream(FProducer, aRequest.ReportStream);
      TppAutosearchRTTI.GetAutosearchGroups(FProducer, aRequest.AutosearchGroups);

      FPageRequest.Assign(aRequest.PageRequest);
      FPrinterSetup.Assign(aRequest.PrinterSetup);

      FProducer.AddEventNotify(FWalkieTalkie);
      FProducer.ArchiveFileName := aRequest.ArchiveFileName;
      FProducer.DeviceType := aRequest.DeviceType;
      FProducer.EnableProcessMessages := False;
      FProducer.PrinterSetup := FPrinterSetup;
      FProducer.ShowAutoSearchDialog := False;
      FProducer.ShowCancelDialog := False;
      FProducer.ShowPrintDialog := False;
      FProducer.TextFileName := aRequest.TextFileName;
    end;

end;

{@TppBackgroundContainerAdapter.CreateContainer }

function TppBackgroundContainerAdapter.CreateContainer(aRequest: TppBackgroundPrintRequest): TComponent;
var
  lComponent: TComponent;
begin

  if (aRequest = nil) then
    RaiseException('TppBackgroundContainerAdapter.CreateContainer: Request cannot be nil.');

  if (aRequest.OwnerClass = nil) then
    RaiseException('TppBackgroundContainerAdapter.CreateContainer: Request.OwnerClass cannot be nil.');

  Result := CreateOwner(aRequest.OwnerClass);

  {ExceptionRaised is only true when owner can't be instantiated}
  if FExceptionRaised then
    begin
      {don't need to call GlobalNameSpace here because we are already inside of
       a set of GlobalNameSpace calls from the calling ProcessRequest method.}
      Result.Free;
      Result := nil;
    end

  else
    begin

      if (Result = nil) then
        RaiseException('TppBackgroundContainerAdapter.CreateContainer: Cannot create container: ' + aRequest.OwnerClass.ClassName)
      else
        begin
          lComponent := Result.FindComponent(aRequest.ProducerName);

          if (lComponent = nil) then
            RaiseException('TppBackgroundContainerAdapter.CreateContainer: Cannot find producer in owner: ' + aRequest.ProducerName);

          if not(lComponent is TppProducer) then
            RaiseException('TppBackgroundContainerAdapter.CreateContainer: Component found for ' + aRequest.ProducerName + ' is not a TppProducer: ' + lComponent.Classname);

          {need to make the form invisible}
          if (Result is TControl) and TControl(Result).Visible then
            TControl(Result).Visible := False;

          FProducer := TppProducer(lComponent);
        end;
    end;

end;
    
{@TppBackgroundContainerAdapter.CreateOwner }

function TppBackgroundContainerAdapter.CreateOwner(aOwnerClass: TComponentClass): TComponent;
var
  lMethod: TMethod;
begin
    
  {temporarily assign the application OnException event handler from the user's app}
  if Assigned(Application.OnException) then
    lMethod := TMethod(Application.OnException)
  else
    lMethod.Data := nil;

  {Delphi eats the EDBEngineError when a BDE session isn't used to make the
   form/datamodule threadsafe, so we need to listen using this event.}
  Application.OnException := ApplicationExceptionHandler;

  try
    Result := aOwnerClass.Create(nil);

  finally
    {reassing the user's displaced event handler if one existed}
    if (lMethod.Data = nil) then
      Application.OnException := nil
    else
      Application.OnException := TExceptionEvent(lMethod);
  end;

end;

{@TppBackgroundContainerAdapter.ApplicationExceptionHandler }

procedure TppBackgroundContainerAdapter.ApplicationExceptionHandler(Sender: TObject; E: Exception);
begin

  if not(FExceptionRaised) then
    begin
      RaiseException(E.ClassName + ': ' + E.Message);

      Application.HandleException(Self);
      Application.OnException := nil;
    end;

end;

{@TppBackgroundContainerAdapter.RaiseException }

procedure TppBackgroundContainerAdapter.RaiseException(const aMessage: String);
begin
  FExceptionRaised := True;
  FExceptionMessage := aMessage;
end;

{@TppBackgroundContainerAdapter.WalkieTalkieEventNotifyHandler }

procedure TppBackgroundContainerAdapter.WalkieTalkieEventNotifyHandler(Sender: Tobject; aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
var
  liIndex: Integer;
  lArchiveReader: TppCustomArchiveReader;
begin

  if (aEventID = ciProducerBeforePrint) then
    begin

      if (aCommunicator = FProducer) then
        begin
          for liIndex := 0 to FProducer.Publisher.DeviceCount - 1 do
            FProducer.Publisher.Devices[liIndex].PageRequest := FPageRequest;
        end;

    end

  else if (aEventID = ciInitializePrinterSetup) then
    begin

      {assign printer setup to archive reader}
      if (aCommunicator = FProducer) and (FProducer is TppCustomArchiveReader) then
        begin
          lArchiveReader := TppCustomArchiveReader(FProducer);

          lArchiveReader.PrinterSetup := FPrinterSetup;

          {archive reader doesn't fire the before print eventID so we need to
           assign the main thread's print dialog's page request}
          for liIndex := 0 to FProducer.Publisher.DeviceCount - 1 do
            FProducer.Publisher.Devices[liIndex].PageRequest := FPageRequest;
        end;

    end;

end;

end.
