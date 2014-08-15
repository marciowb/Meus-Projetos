{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppDBJIT;

interface

{$I ppIfDef.pas}

uses
  {$IFDEF Delphi6}Variants,{$ENDIF}
  Classes, SysUtils, Graphics,
  ppTypes, ppDB, ppUtils;

type

  {event types}
  TppBooleanEvent = function: Boolean of object;
  TppFreeBookmarkEvent = procedure (aBookmark: Longint) of object;
  TppGetBookmarkEvent = function: Longint of object;
  TppGetDataSetNameEvent = function: String of object;
  TppGetFieldAsDoubleEvent = function (aFieldName: String): Double of object;
  TppGetFieldAsGuidEvent = function (aFieldName: String): TGuid of object;
{$IFDEF CBuilder}
  TppGetFieldAsPictureEvent = procedure (aFieldName: String; var aPicture: TPicture) of object; //BCB Work around for: E2370 Simple type name expected
{$ELSE}
  TppGetFieldAsPictureEvent = function (aFieldName: String): TPicture of object;
{$ENDIF}
  TppGetFieldAsStreamEvent = procedure(aFieldName: String; aStream: TStream) of object;
  TppGetFieldAsStringEvent = function (aFieldName: String): String of object;
  TppGetFieldValueEvent = function (aFieldName: String): Variant of object;

  TppGotoBookmarkEvent = procedure (aBookmark: Longint) of object;
  TppTraverseByEvent = procedure (aIncrement: Longint) of object;



  {@TppJITPipeline

    Assign a TppJITPipeline component to the DataPipeline property of any
    data-aware report component in order for that component to access data from
    Delphi objects. Assign the event handlers of the JITPipeline in order to
    specify how field values should be resolved and how the data should be
    traversed as the report prints.

    When the DataPipeline is assigned to a Report or to a DetailBand, several
    additional properties can be used to describe how the data should be
    traversed. The RangeBegin property describes the record on which traversal
    should start. The RangeEnd property describes the record on which traversal
    should stop. The AddBookmark method can be used to traverse a list of
    records.

    Note: See the demos in the 'no database reports' section such as dm0136 for
    an example of how to use a JITPipeline.}

  {@TppJITPipeline.InitialIndex

    Used to indicate the starting 'record no'.  This value is assigned to the
    RecordIndex when the JITPipeline is 'opened' by the report engine.}

  {@TppJITPipeline.OnCheckBOF

    This method is called when the report engine is checking to see if it is at
    the beginning of the data.}

  {@TppJITPipeline.OnCheckEOF

    This method is called when the report engine is checking to see if it is at
    the end of the data.}

  {@TppJITPipeline.OnCloseDataSet

    This event fires when the DataPipeline.Close method is called.  The close
    method is called when the pipeline is being freed.}

  {@TppJITPipeline.OnFreeBookmark

    This event fires when a saved position in the data is no longer needed.}

  {@TppJITPipeline.OnGetActive

    This event fires when the engine is checking to see if the data is
    accessible.  The default return value is True.}

  {@TppJITPipeline.OnGetBookmark

    This event fires when the engine wishes to record the current position in
    the data.}

  {@TppJITPipeline.OnGetDataSetName

    This event fires when the report designer is attempting to display the field
    names in the group dialog or in the drop-down field list box for
    master/detail fields.  This name will be used to preface all fields names,
    as in 'Customer.Name', where Customer is the dataset name.}

  {@TppJITPipeline.OnGetFieldAsDouble

    This event fires when the value of a field is needed as a double.  This
    routine is called by the DBCalc component.}

 {@TppJITPipeline.OnGetFieldAsDouble

    This event fires when the value of a field is needed as a GUID.}

  {@TppJITPipeline.OnGetFieldAsPicture

    This event fires when a field is needed as a picture.  This event is called
    by the DBImage component.}

  {@TppJITPipeline.OnGetFieldAsString

    This event fires when the field value is needed as a string.  This event is
    a called by the DBText component.}

  {@TppJITPipeline.OnGetFieldAsStream

    This event fires when the field value is needed as a stream.  This event is
    a called by the DBImage component.

    Note: if your images are stored in files, then define string field type rather
          than a blob and return the file name. DBImage will then automatically
          load the image from file.}

  {@TppJITPipeline.OnGetFieldValue

    This event fires when the field value is needed. Any of the data-aware
    components may cause this event to be triggered.}

  {@TppJITPipeline.OnGotoBookmark

    This event is called when the report engine needs to advance to a particular
    location in the data.}

  {@TppJITPipeline.OnGotoFirstRecord

    This event is triggered when the report needs to go to the beginning of the
    data.}

  {@TppJITPipeline.OnGotoLastRecord

    This event is triggered when the report needs to go to the end of the data.}

  {@TppJITPipeline.OnOpenDataSet

    This event is triggered when the report engine first begins the print
    process.}

  {@TppJITPipeline.OnTraverseBy

    This event is triggered when the report engine needs to move forward in the
    data by a certain number of 'record' positions.}

  {@TppJITPipeline.RecordCount

    Used to indicate the number of 'records' the JITPipeline will traverse.
    Each time the Next method of the pipeline is called by the report engine,
    the RecordIndex is incremented. When the RecordIndex is equal to the
    RecordCount, the JITPipeline returns an EOF condition, indicating that all
    of the data has been traversed.}

  {@TppJITPipeline.RecordIndex

    Indicates the current record position.  The RecordIndex is set to the value
    of the InitialIndex when the pipeline is opened by the report engine. Each
    time the report engin calls the Next method of the pipeline, the RecordIndex
    is incremented. When the RecordIndex is equal to the RecordCount, the
    JITPipeline returns an EOF condition to the engine, indicating that all data
    has been traversed.}

  TppJITPipeline = class(TppCustomDataPipeline)
    private
      FOnCloseDataSet: TNotifyEvent;
      FOnCheckBOF: TppBooleanEvent;
      FOnCheckEOF: TppBooleanEvent;
      FOnFreeBookmark: TppFreeBookmarkEvent;
      FOnGetActive: TppBooleanEvent;
      FOnGetBookmark: TppGetBookmarkEvent;
      FOnGetDataSetName: TppGetDataSetNameEvent;
      FOnGetFieldAsDouble: TppGetFieldAsDoubleEvent;
      FOnGetFieldAsGuid: TppGetFieldAsGuidEvent;
      FOnGetFieldAsPicture: TppGetFieldAsPictureEvent;
      FOnGetFieldAsStream: TppGetFieldAsStreamEvent;
      FOnGetFieldAsString: TppGetFieldAsStringEvent;
      FOnGetFieldValue: TppGetFieldValueEvent;
      FOnGotoBookmark: TppGotoBookmarkEvent;
      FOnGotoFirstRecord: TNotifyEvent;
      FOnGotoLastRecord: TNotifyEvent;
      FOnOpenDataSet: TNotifyEvent;
      FOnTraverseBy: TppTraverseByEvent;
      FInitialIndex: Integer;
      FRecordCount: Integer;
      FRecordIndex: Integer;
      FActive: Boolean;
      FBOF: Boolean;
      FEOF: Boolean;
      procedure SetInitialIndex(const Value: Integer);
      procedure SetRecordCount(const Value: Integer);

    protected
      {overriden from TppDataPipeline}
      procedure CloseDataSet; override;
      function  GetActive: Boolean; override;
      function  CheckBOF: Boolean; override;
      function  CheckEOF: Boolean; override;
      procedure GotoFirstRecord; override;
      procedure GotoLastRecord; override;
      procedure OpenDataSet; override;
      function TraverseBy(aIncrement: Integer): Integer; override;

      procedure SetRecordIndex(aValue: Integer);

      {field support}
      property AutoCreateFields default False;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      {overriden from TppDataPipeline}
      procedure FreeBookmark(aBookmark: Longint); override;
      function  GetBookmark: Longint; override;
      function  GetDataSetName: String; override;
      function  GetFieldAsDouble(aFieldName: String): Double; override;
      function  GetFieldAsGuid(aFieldName: String): TGuid; override;
      function  GetFieldAsPicture(aFieldName: String): TPicture; override;
      procedure GetFieldAsStream(aFieldName: String; aStream: TStream); override;
      function  GetFieldAsString(aFieldName: String): String; override;
      function  GetFieldIsCalculated(aFieldName: String): Boolean; override;
      function  GetFieldIsNull(aFieldName: String): Boolean; override;
      function  GetFieldValue(aFieldName: string): Variant; override;

      procedure GotoBookmark(aBookmark: Longint); override;

      function GetLastRecordIndex: Integer;

      property RecordIndex: Integer read FRecordIndex write FRecordIndex;

    published
      property InitialIndex: Integer read FInitialIndex write SetInitialIndex;
      property RecordCount: Integer read FRecordCount write SetRecordCount;

      { TppDataPipeline properties}
      property MasterDataPipeline;
      property MoveBy;
      property RangeEnd;
      property RangeEndCount;
      property RangeBegin;
      property SkipWhenNoRecords;
      property UserName;
      property Visible;
  
      property OnCloseDataSet: TNotifyEvent read FOnCloseDataSet write FOnCloseDataSet;
      property OnCheckBOF: TppBooleanEvent read FOnCheckBOF write FOnCheckBOF;
      property OnCheckEOF: TppBooleanEvent read FOnCheckEOF write FOnCheckEOF;
      property OnFreeBookmark: TppFreeBookmarkEvent read FOnFreeBookmark write FOnFreeBookmark;
      property OnGetActive: TppBooleanEvent read FOnGetActive write FOnGetActive;
      property OnGetBookmark: TppGetBookmarkEvent read FOnGetBookmark write FOnGetBookmark;
      property OnGetDataSetName: TppGetDataSetNameEvent read FOnGetDataSetName write FOnGetDataSetName;
      property OnGetFieldAsDouble: TppGetFieldAsDoubleEvent read FOnGetFieldAsDouble write FOnGetFieldAsDouble;
      property OnGetFieldAsGuid: TppGetFieldAsGuidEvent read FOnGetFieldAsGuid write FOnGetFieldAsGuid;
      property OnGetFieldAsPicture: TppGetFieldAsPictureEvent read FOnGetFieldAsPicture write FOnGetFieldAsPicture;
      property OnGetFieldAsString: TppGetFieldAsStringEvent read FOnGetFieldAsString write FOnGetFieldAsString;
      property OnGetFieldValue: TppGetFieldValueEvent read FOnGetFieldValue write FOnGetFieldValue;

      property OnGotoBookmark: TppGotoBookmarkEvent read FOnGotoBookmark write FOnGotoBookmark;
      property OnGotoFirstRecord: TNotifyEvent read FOnGotoFirstRecord write FOnGotoFirstRecord;
      property OnGotoLastRecord: TNotifyEvent read FOnGotoLastRecord write FOnGotoLastRecord;
      property OnMasterRecordPositionChange;
      property OnOpenDataSet: TNotifyEvent read FOnOpenDataSet write FOnOpenDataSet;
      property OnRecordPositionChange;
      property OnGetFieldAsStream: TppGetFieldAsStreamEvent read FOnGetFieldAsStream write FOnGetFieldAsStream;
      property OnTraverseBy: TppTraverseByEvent read FOnTraverseBy write FOnTraverseBy;

  end; {class, TppJITPipeline}


  {@TppChildJITPipeline }
  TppChildJITPipeline = class(TppJITPipeline)
    protected
      function GetChildOwner: TComponent; override;

    public
      function HasParent: Boolean; override;

    end; {class, TppChildJITPipeline}



implementation

{******************************************************************************
 *
 ** C H I L D   J I T  P I P E L I N E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppChildJITPipeline.GetChildOwner }

function TppChildJITPipeline.GetChildOwner: TComponent;
begin
  Result := Self;
end; {function, GetChildOwner}

{------------------------------------------------------------------------------}
{ TppChildJITPipeline.HasParent }

function TppChildJITPipeline.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}


{******************************************************************************
 *
 ** J I T   P I P E L I N E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppJITPipeline.Create }

constructor TppJITPipeline.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  AutoCreateFields := False;

  FOnCloseDataSet := nil;
  FOnCheckBOF := nil;
  FOnCheckEOF := nil;
  FOnFreeBookmark := nil;
  FOnGetActive := nil;
  FOnGetBookmark := nil;
  FOnGetDataSetName := nil;
  FOnGetFieldAsDouble := nil;
  FOnGetFieldAsGuid := nil;
  FOnGetFieldAsPicture := nil;
  FOnGetFieldAsString := nil;
  FOnGetFieldValue := nil;
  FOnGotoBookmark := nil;
  FOnGotoFirstRecord := nil;
  FOnGotoLastRecord := nil;
  FOnOpenDataSet := nil;
  FOnTraverseBy := nil;

  FActive       := False;
  FInitialIndex := 0;
  FRecordCount  := 99999999;
  FRecordIndex  := -1;
  FEOF := True;
  FBOF := True;


end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppJITPipeline.Destroy }

destructor TppJITPipeline.Destroy;
begin

  Close;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppJITPipeline.GetActive }

function TppJITPipeline.GetActive: Boolean;
begin

  Result := FActive;

  if Assigned(FOnGetActive) then Result := FOnGetActive;

end; {procedure, GetActive}

{------------------------------------------------------------------------------}
{ TppJITPipeline.GetDataSetName }

function TppJITPipeline.GetDataSetName: String;
begin

  Result := Name;

  if Assigned(FOnGetDataSetName) then Result := FOnGetDataSetName;

end; {function, GetDataSetName}


{------------------------------------------------------------------------------}
{ TppJITPipeline.GetFieldAsGuid }

function TppJITPipeline.GetFieldAsGuid(aFieldName: String): TGuid;
begin

  Result := cNullGuid;

  if Assigned(FOnGetFieldAsGuid) then Result := FOnGetFieldAsGuid(aFieldName);

end; {function, GetFieldAsGuid}

{------------------------------------------------------------------------------}
{ TppJITPipeline.GetFieldAsDouble }

function TppJITPipeline.GetFieldAsDouble(aFieldName: String): Double;
begin

  Result := 0;

  if Assigned(FOnGetFieldAsDouble) then Result := FOnGetFieldAsDouble(aFieldName);

end; {function, GetFieldAsDouble}

{------------------------------------------------------------------------------}
{ TppJITPipeline.GetFieldAsPicture }

function TppJITPipeline.GetFieldAsPicture(aFieldName: String): TPicture;
begin

  Result := nil;

{$IFDEF CBuilder}
  if Assigned(FOnGetFieldAsPicture) then FOnGetFieldAsPicture(aFieldName,Result); //BCB Work around for: E2370 Simple type name expected
{$ELSE}
  if Assigned(FOnGetFieldAsPicture) then Result := FOnGetFieldAsPicture(aFieldName);

{$ENDIF}

end; {function, GetFieldAsPicture}

{------------------------------------------------------------------------------}
{ TppJITPipeline.GetFieldAsString }

function TppJITPipeline.GetFieldAsString(aFieldName: String): String;
var
  lField: TppField;
  lValue: Variant;
  
begin

  Result := '';

  if Assigned(FOnGetFieldAsString) then
    Result := FOnGetFieldAsString(aFieldName)
  else
    begin
      lValue := GetFieldValue(aFieldName);

      if ppVariantIsString(lValue) then
        Result := lValue
      else
        begin
          lField := GetFieldForName(aFieldName);

          if lField <> nil then
            Result := ppFormat('', lField.DataType , lValue);
        end;
    end;

end; {function, GetFieldAsString}

{------------------------------------------------------------------------------}
{ TppJITPipeline.GetFieldIsNull }

function TppJITPipeline.GetFieldIsNull(aFieldName: String): Boolean;
begin
  Result := (GetFieldAsString(aFieldName) = '');
end; {function, GetFieldIsNull}

{------------------------------------------------------------------------------}
{ TppJITPipeline.GetFieldIsCalculated }

function TppJITPipeline.GetFieldIsCalculated(aFieldName: String): Boolean;
begin
  Result := True;
end; {function, GetFieldIsCalculated}

{------------------------------------------------------------------------------}
{ TppJITPipeline.GetFieldValue }

function TppJITPipeline.GetFieldValue(aFieldName: String): Variant;
begin
  if not Active then
    Open;

  Result := Null;

 if (ppdaNoRecords in State) then Exit;

  if Assigned(FOnGetFieldValue) then Result := FOnGetFieldValue(aFieldName);

end; {function, GetFieldValue}

{------------------------------------------------------------------------------}
{ TppJITPipeline.FreeBookmark }

procedure TppJITPipeline.FreeBookmark(aBookmark: Longint);
begin

  if Assigned(FOnFreeBookmark) then FOnFreeBookmark(aBookmark);

end; {procedure, FreeBookmark}

{------------------------------------------------------------------------------}
{ TppJITPipeline.GetBookmark }

function  TppJITPipeline.GetBookmark: Longint;
begin

  Result := FRecordIndex;

  if Assigned(FOnGetBookmark) then Result := FOnGetBookmark;

end; {procedure, GetBookmark}

{------------------------------------------------------------------------------}
{ TppJITPipeline.GotoBookmark }

procedure TppJITPipeline.GotoBookmark(aBookmark: Longint);
begin

  SetRecordIndex(aBookmark);

  if Assigned(FOnGotoBookmark) then FOnGotoBookmark(aBookmark);

  inherited GotoBookmark(aBookmark);

end; {procedure, GotoBookmark}

{------------------------------------------------------------------------------}
{ TppJITPipeline.CheckBOF }

function TppJITPipeline.CheckBOF: Boolean;
begin

  Result := (FRecordCount = 0) or FBOF;

  if Assigned(FOnCheckBOF) then Result := FOnCheckBOF;

end; {procedure, CheckBOF}

{------------------------------------------------------------------------------}
{ TppJITPipeline.CheckEOF }

function TppJITPipeline.CheckEOF: Boolean;
begin

  Result := (FRecordCount = 0) or FEOF;

  if Assigned(FOnCheckEOF) then Result := FOnCheckEOF;

end; {procedure, CheckEOF}

{------------------------------------------------------------------------------}
{ TppJITPipeline.OpenDataSet }

procedure TppJITPipeline.OpenDataSet;
begin
  if FActive then Exit;

  if Assigned(FOnOpenDataSet) then FOnOpenDataSet(Self);

  FActive := True;
  FEOF    := False;

  GotoFirstRecord;

end; {procedure, OpenDataSet}

{------------------------------------------------------------------------------}
{ TppJITPipeline.CloseDataSet }

procedure TppJITPipeline.CloseDataSet;
begin

  if not FActive then Exit;
  
  if Assigned(FOnCloseDataSet) then FOnCloseDataSet(Self);

  SetRecordIndex(FInitialIndex);

  FActive := False;
  FBOF := True;
  FEOF := True;

end; {procedure, CloseDataSet}

{------------------------------------------------------------------------------}
{ TppJITPipeline.GetFieldAsStream }

procedure TppJITPipeline.GetFieldAsStream(aFieldName: String; aStream: TStream);
begin
  if Assigned(FOnGetFieldAsStream) then FOnGetFieldAsStream(aFieldName, aStream);

end;

{------------------------------------------------------------------------------}
{ TppJITPipeline.GotoFirstRecord }

procedure TppJITPipeline.GotoFirstRecord;
begin

  SetRecordIndex(FInitialIndex);

  {force BOF to true when first record called}
  FBOF := True;

  if Assigned(FOnGotoFirstRecord) then FOnGotoFirstRecord(Self);

  inherited GotoFirstRecord;

end; {procedure, GotoFirstRecord}

{------------------------------------------------------------------------------}
{ TppJITPipeline.GotoLastRecord }

procedure TppJITPipeline.GotoLastRecord;
begin

  SetRecordIndex(GetLastRecordIndex);

  {force EOF to true when last record called}
  FEOF := True;

  if Assigned(FOnGotoLastRecord) then FOnGotoLastRecord(Self);

  inherited GotoLastRecord;

end; {procedure, GotoLastRecord}

{------------------------------------------------------------------------------}
{ TppJITPipeline.TraverseBy }

function TppJITPipeline.TraverseBy(aIncrement: Integer): Integer;
var
  liSaveIndex: Integer;
begin

  liSaveIndex := FRecordIndex;
  
  SetRecordIndex(FRecordIndex + aIncrement);

  if Assigned(FOnTraverseBy) then FOnTraverseBy(aIncrement);

  Result := FRecordIndex - liSaveIndex;

end; {procedure, TraverseBy}

{------------------------------------------------------------------------------}
{ TppJITPipeline.SetRecordIndex }

procedure TppJITPipeline.SetRecordIndex(aValue: Integer);
begin

  FRecordIndex := aValue;

  FEOF := FRecordIndex > GetLastRecordIndex;

  if FEOF then
    FRecordIndex := GetLastRecordIndex;

  FBOF := FRecordIndex < FInitialIndex;

  if FBOF then
    FRecordIndex := FInitialIndex;

end; {procedure, SetRecordIndex}

{------------------------------------------------------------------------------}
{ TppJITPipeline.GetLastRecordIndex }

function TppJITPipeline.GetLastRecordIndex: Integer;
begin

  Result := FRecordCount + (FInitialIndex - 1);

end; {procedure, GetLastRecordIndex}

{------------------------------------------------------------------------------}
{ TppJITPipeline.SetInitialIndex }

procedure TppJITPipeline.SetInitialIndex(const Value: Integer);
begin
  if (FInitialIndex = Value) then Exit;

  FInitialIndex := Value;
  DoOnDataChange;

end;

{------------------------------------------------------------------------------}
{ TppJITPipeline.SetRecordCount }

procedure TppJITPipeline.SetRecordCount(const Value: Integer);
begin

  if (FRecordCount = Value) then Exit;

  FRecordCount := Value;
  DoOnDataChange;

end;

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  RegisterClasses([TppJITPipeline, TppChildJITPipeline]);

finalization

  UnRegisterClasses([TppJITPipeline, TppChildJITPipeline]);

end.
