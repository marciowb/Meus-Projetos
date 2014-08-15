{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2003                    BBBBB   }

unit ppBackGroundPrintRequest;

interface

uses
  Classes,
  ppComm, ppProd, ppASField, ppPrintr, ppDevice;

type

{@TppBackgroundPrintRequest

  Create a request object to pass to the TppProducerThread object in order
  to tell the thread what to print. Pass the producer object in the call to
  AssignProducer. Then read the properties of this request to extract the
  information about this producer.

  Read the ReportStream property for the report that should be printed in
  the background thread. Read any autosearch fields from the report using
  the AutosearchGroups property. Find out the OwnerClass for the producer,
  which can be either a TForm or TDatamodule class.}

  TppBackgroundPrintRequest = class
    private
      FDeviceType: String;
      FArchiveFileName: String;
      FTextFileName: String;
      FPrinterSetup: TppPrinterSetup;
      FOwnerClass: TComponentClass;
      FProducerName: String;
      FAutosearchGroups: TppAutoSearchGroups;
      FPageRequest: TppPageRequest;
      FReportStream: TMemoryStream;

      procedure AutosearchFieldsToRequest(aProducer: TppProducer);

    public
      constructor Create(aProducer: TObject; aPageRequest: TppPageRequest; const aDeviceType, aArchiveFileName, aTextFileName: String); virtual;
      destructor Destroy; override;

      procedure Clone(aRequest: TppBackgroundPrintRequest);

      property AutosearchGroups: TppAutoSearchGroups read FAutosearchGroups;
      property DeviceType: String read FDeviceType;
      property ArchiveFileName: String read FArchiveFileName;
      property TextFileName: String read FTextFileName;
      property OwnerClass: TComponentClass read FOwnerClass;
      property PageRequest: TppPageRequest read FPageRequest;
      property PrinterSetup: TppPrinterSetup read FPrinterSetup;
      property ProducerName: String read FProducerName;
      property ReportStream: TMemoryStream read FReportStream;

    end;

implementation

uses
  ppTypes, ppClass, ppAutoSearchRTTI, ppReportTemplateRTTI, ppViewr;

{@TppBackgroundPrintRequest.Create }

constructor TppBackgroundPrintRequest.Create(aProducer: TObject; aPageRequest: TppPageRequest; const aDeviceType, aArchiveFileName, aTextFileName: String);
var
  lProducer: TppProducer;
begin

  inherited Create;

  if (aProducer = nil) then
    raise EBackgroundPrintError.Create('TppBackgroundPrintRequest.Create: Producer cannot be nil for background printing.');

  if not(aProducer is TppProducer) then
    raise EBackgroundPrintError.Create('TppBackgroundPrintRequest.Create: Object passed as producer is not a TppProducer but rather a ' + aProducer.ClassName);

  lProducer := TppProducer(aProducer);

  if (lProducer.Owner = nil) then
    raise EBackgroundPrintError.Create('TppBackgroundPrintRequest.Create: Owner of producer cannot be nil for background printing.');

  FProducerName := lProducer.Name;

  FDeviceType := aDeviceType;

  if (FDeviceType = dtScreen) then
    raise EBackgroundPrintError.Create('TppBackgroundPrintRequest.Create: The producer''s device cannot be a screen device for background printing.');

  FOwnerClass := TComponentClass(lProducer.Owner.ClassType);

  FPageRequest := TppPageRequest.Create;
  FPageRequest.Assign(aPageRequest);

  FPrinterSetup := TppPrinterSetup.Create(nil);
  FPrinterSetup.Assign(lProducer.PrinterSetup);

  FArchiveFileName := aArchiveFileName;
  FTextFileName := aTextFileName;

  FReportStream := TMemoryStream.Create;
  FAutosearchGroups := TppAutoSearchGroups.Create(nil);
  TppReportTemplateRTTI.SaveToReportStream(lProducer, FReportStream);

  AutosearchFieldsToRequest(lProducer);

end;

{@TppBackgroundPrintRequest.Destroy }

destructor TppBackgroundPrintRequest.Destroy;
begin

  FPageRequest.Free;
  FReportStream.Free;
  FPrinterSetup.Free;
  FAutosearchGroups.Free;

  inherited Destroy;

end;

{@TppBackgroundPrintRequest.Clone }

procedure TppBackgroundPrintRequest.Clone(aRequest: TppBackgroundPrintRequest);
begin

  if (aRequest is TppBackgroundPrintRequest) then
    begin
      FAutosearchGroups.Assign(aRequest.FAutosearchGroups);
      FArchiveFileName := aRequest.FArchiveFileName;
      FTextFileName := aRequest.FTextFileName;
      FOwnerClass := aRequest.FOwnerClass;
      FPageRequest.Assign(aRequest.FPageRequest);
      FProducerName := aRequest.FProducerName;
      FPrinterSetup.Assign(aRequest.FPrinterSetup);

      FReportStream.Position := 0;
      aRequest.ReportStream.Position := 0;

      FReportStream.Size := aRequest.ReportStream.Size;
      FReportStream.CopyFrom(aRequest.ReportStream, aRequest.ReportStream.Size);
    end;

end;

{@TppBackgroundPrintRequest.AutosearchFieldsToRequest }

procedure TppBackgroundPrintRequest.AutosearchFieldsToRequest(aProducer: TppProducer);
begin

  if TppAutoSearchRTTI.GetHasAutoSearchFields(aProducer) then
    TppAutoSearchRTTI.SetAutoSearchGroups(aProducer, FAutosearchGroups)
  else
    FAutosearchGroups.Clear;

end;


end.
