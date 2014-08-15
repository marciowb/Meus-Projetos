{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2007                    BBBBB   }

unit ppDBArchiv;

interface

uses
  Classes,
  ppArchiv, ppDB, ppComm, ppTypes, ppDBStorageSettings;

type

  {@TppDBArchiveReader

    When report archives are stored in a database table, they can be
    opened, previewed and printed using this component. Use the DatabaseSettings
    property to connect the archive reader to the archive data store.
    DatabaseSettings contains the following subproperties

    <Table>
      Property       Description
      ------------   -----------------
      Datapipeline   datapipeline connected to an archive dataset
      NameField      the field where the name of each archive is stored
      BlobField      the field wehere the archive is stored
      Name           use to specify which archive to load when Print is called
    </Table>}

  {@TppDBArchiveReader.DatabaseSettings

    Used to specify the DataPipeline, NameField and BLOBField from which the
    archives can be read.}

  TppDBArchiveReader = class(TppArchiveReader)
    private
      FDatabaseSettings: TppDBStorageSettings;

      procedure NameChangeEvent(aSender: TObject);
      procedure BLOBFieldChangeEvent(aSender: TObject);
      procedure DataPipelineChangeEvent(aSender: TObject);
      procedure DataPipelineChange(aDataPipeline: TObject);
      procedure NameFieldChangeEvent(aSender: TObject);
      procedure SetDatabaseSettings(aDatabaseSettings: TppDBStorageSettings);

    protected
      procedure CreateStream(var aStream: TStream); override;
      procedure FreeStream(aStream: TStream); override;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

    published
      property AfterPrint;
      property AllowPrintToFile;
      property BeforePrint;
      property DatabaseSettings: TppDBStorageSettings read FDatabaseSettings write SetDatabaseSettings;
      property DeviceType;
      property BackgroundPrintSettings;
      property Icon;
      property Language;
      property ModalCancelDialog;
      property ModalPreview;
      property OnCancel;
      property OnCancelDialogClose;
      property OnCancelDialogCreate;
      property OnPreviewFormClose;
      property OnPreviewFormCreate;
      property OnPrintDialogClose;
      property OnPrintDialogCreate;
      property OnDrawCommandClick;
      property OnInitializePrinterSetup;
      property OutlineExists stored False;
      property PreviewFormSettings;
      property SavePrinterSetup;
      property ShowCancelDialog;
      property ShowPrintDialog;
      property SuppressOutline;
      property TextFileName;
      property TextFileType;
    end;

implementation

uses
  SysUtils, Dialogs;

{******************************************************************************
 *
 ** D B   A R C H I V E    R E A D E R
 *
{******************************************************************************}

{@TppDBArchiveReader.Create }

constructor TppDBArchiveReader.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FDatabaseSettings := TppDBStorageSettings.Create;
  FDatabaseSettings.OnNameChange := NameChangeEvent;
  FDatabaseSettings.OnBLOBFieldChange := BLOBFieldChangeEvent;
  FDatabaseSettings.OnNameFieldChange := NameFieldChangeEvent;
  FDatabaseSettings.OnDataPipelineChange := DataPipelineChangeEvent;

end;
    
{@TppDBArchiveReader.Destroy }

destructor TppDBArchiveReader.Destroy;
begin

  FDatabaseSettings.Free;

  inherited Destroy;

end;

{@TppDBArchiveReader.CreateStream }

procedure TppDBArchiveReader.CreateStream(var aStream: TStream);
var
  lDataPipeline: TppDataPipeline;
begin

  lDataPipeline := FDatabaseSettings.DataPipeline;

  if (lDataPipeline = nil) then
    raise EDataError.Create('TppDBArchiveReader.CreateStream: DatabaseSettings.DataPipeline is nil');

  if lDataPipeline.Locate(FDatabaseSettings.NameField, FDatabaseSettings.Name, [pploCaseInsensitive]) then
    begin
      aStream := TMemoryStream.Create;
      lDataPipeline.GetFieldAsStream(FDatabaseSettings.BLOBField, aStream)
    end
  else
    raise EDataError.Create('TppDBArchiveReader.CreateStream: Cannot locate archive field');


end;

{@TppDBArchiveReader.FreeStream }

procedure TppDBArchiveReader.FreeStream(aStream: TStream);
begin
  aStream.Free;
end;

{@TppDBArchiveReader.Notify }

procedure TppDBArchiveReader.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (aCommunicator = FDatabaseSettings.DataPipeline) and (aOperation = ppopRemove) then
    FDatabaseSettings.DataPipeline := nil;

end;
      
{@TppDBArchiveReader.SetDatabaseSettings }

procedure TppDBArchiveReader.SetDatabaseSettings(aDatabaseSettings: TppDBStorageSettings);
begin
  FDatabaseSettings.Assign(aDatabaseSettings);
end;

{@TppDBArchiveReader.NameChangeEvent }

procedure TppDBArchiveReader.NameChangeEvent(aSender: TObject);
begin
  Reset;
end;

{@TppDBArchiveReader.BLOBFieldChangeEvent }

procedure TppDBArchiveReader.BLOBFieldChangeEvent(aSender: TObject);
begin
  Reset;
end;

{@TppDBArchiveReader.NameFieldChangeEvent }

procedure TppDBArchiveReader.NameFieldChangeEvent(aSender: TObject);
begin
  Reset;
end;

{@TppDBArchiveReader.DataPipelineChangeEvent }

procedure TppDBArchiveReader.DataPipelineChangeEvent(aSender: TObject);
begin
  DataPipelineChange(aSender);
end;

{@TppDBArchiveReader.DataPipelineChange }

procedure TppDBArchiveReader.DataPipelineChange(aDataPipeline: TObject);
var
  lDataPipeline: TppDataPipeline;
begin

  lDataPipeline := DatabaseSettings.DataPipeline;

  {remove reader from notify list}
  if (lDataPipeline <> nil) then
    lDataPipeline.RemoveNotify(Self);

  lDataPipeline := TppDataPipeline(aDataPipeline);

  {add reader to notify list}
  if lDataPipeline <> nil then
    lDataPipeline.AddNotify(Self);

  Reset;

end;

end.
