{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppDBStorageSettings;

interface

uses
  Classes, SysUtils,
  ppDB;

type

  {@TppDBStorageSettings

    Use DBStorageSettings to describe the structure of the database table in
    which report archives or report layouts should be saved.

    The storage settings assume a simple table definition, where the stream is
    saved in a BLOBField and the name associated with the stream is saved in a
    character field (NameField.) When reading or writing a stream to a database
    record, the  record is first located by comparing the value in the Name
    property to the value in the NameField of each record. Once a match is
    found, the stream is either read from or written to the BLOBField. Both the
    NameField and the BLOBField must appear in the DataPipeline, which is simply
    a pass-through to the data access components that handle the actual database
    operations.}

  {@TppDBStorageSettings.Name

    The name associated with the report layout or archive. The value of the
    Name property is used to search the database table for the corresponding
    record. The layout or archive can then be read from or written to the
    BLOBField.}

  {@TppDBStorageSettings.DataPipeline

    A pass-through to the data access components which perform the database
    operations necessary to read or write the BLOBField and the NameField to
    the database.  This property is usually assigned to TppDBPipeline, since
    this component supports the standard TDataSource object.}

  {@TppDBStorageSettings.BLOBField

    The field which will contain the report layout or report archive stream.
    Before reading from or writing to the BLOBField, the value of Name property
    is used to search the NameField values in the underlying table or query.
    Once the matching Name is found, the BLOBField is accessed.}

  {@TppDBStorageSettings.NameField

    The name of the database field which contains values used to differentiate
    between the report layouts or report archives stored in the database table.
    Before reading or writing to a database record, the record is first found
    by comparing the value of the Name property with the value of the NameField
    in each record. Once a match is found, the layout or archive is either read
    from or written to the BLOBField.}

  TppDBStorageSettings = class(TPersistent)
    private
      FName: String;
      FDataPipeline: TppDataPipeline;
      FNameField: String;
      FBLOBField: String;
      FOnNameChange: TNotifyEvent;
      FOnDataPipelineChange: TNotifyEvent;
      FOnBLOBFieldChange: TNotifyEvent;
      FOnNameFieldChange: TNotifyEvent;

      procedure SetName(const aName: String);
      procedure SetBLOBField(const aBLOBField: String);
      procedure SetDataPipeline(aDataPipeline: TppDataPipeline);
      procedure SetNameField(const aNameField: String);

    public
      constructor Create;
      destructor Destroy; override;

      procedure Assign(aObject: TPersistent); override;

      property OnNameChange: TNotifyEvent read FOnNameChange write FOnNameChange;
      property OnDataPipelineChange: TNotifyEvent read FOnDataPipelineChange write FOnDataPipelineChange;
      property OnBLOBFieldChange: TNotifyEvent read FOnBLOBFieldChange write FOnBLOBFieldChange;
      property OnNameFieldChange: TNotifyEvent read FOnNameFieldChange write FOnNameFieldChange;

    published
      property Name: String read FName write SetName;
      property DataPipeline: TppDataPipeline read FDataPipeline write SetDataPipeline;
      property NameField: String read FNameField write SetNameField;
      property BLOBField: String read FBLOBField write SetBLOBField;

    end;


implementation

uses
  ppTypes;
 
{******************************************************************************
 *
 **   R E P O R T   S T O R A G E  D B   S E T T I N G S
 *
{******************************************************************************}

{@TppDBStorageSettings.Create }

constructor TppDBStorageSettings.Create;
begin

  FName := '';
  FNameField := '';
  FBLOBField := '';
  FDataPipeline := nil;

end;

{@TppDBStorageSettings.Destroy }

destructor TppDBStorageSettings.Destroy;
begin

  inherited Destroy;

end;
  
{@TppDBStorageSettings.Assign }

procedure TppDBStorageSettings.Assign(aObject: TPersistent);
var
  lDatabaseSettings: TppDBStorageSettings;
begin

  if not(Self.ClassType.InheritsFrom(aObject.ClassType)) then
    raise EReportBuilderError.Create('function TppReportStorageDatabaseSettings.Assign: Cannot assign ' + aObject.ClassName + ' to ' + Self.ClassName);

  lDatabaseSettings := TppDBStorageSettings(aObject);

  FName := lDatabaseSettings.FName;
  FNameField := lDatabaseSettings.FNameField;
  FBLOBField := lDatabaseSettings.FBLOBField;
  FDataPipeline := lDatabaseSettings.FDataPipeline;

end;

{@TppDBStorageSettings.SetName }

procedure TppDBStorageSettings.SetName(const aName: String);
begin

  FName := aName;

  if Assigned(FOnNameChange) then FOnNameChange(Self);

end;

{@TppDBStorageSettings.SetDataPipeline }

procedure TppDBStorageSettings.SetDataPipeline(aDataPipeline: TppDataPipeline);
begin

  {fire this event first and pass the new datapipeline}
  if Assigned(FOnDataPipelineChange) then FOnDataPipelineChange(aDataPipeline);

  FDataPipeline := aDataPipeline;

end;

{@TppDBStorageSettings.SetBLOBField }

procedure TppDBStorageSettings.SetBLOBField(const aBLOBField: String);
begin

  FBLOBField := aBLOBField;

  if Assigned(FOnBLOBFieldChange) then FOnBLOBFieldChange(Self);

end;

{@TppDBStorageSettings.SetNameField }

procedure TppDBStorageSettings.SetNameField(const aNameField: String);
begin

  FNameField := aNameField;

  if Assigned(FOnNameFieldChange) then FOnNameFieldChange(Self);

end;

end.
