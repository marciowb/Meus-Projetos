{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppDBPipe;

interface

{$I ppIfDef.pas}

uses
  {$IFDEF Delphi10} WideStrings,{$ENDIF}
  {$IFDEF Delphi6}Variants,{$ENDIF}
  Windows,
  Classes,
  SysUtils,
  Graphics,
  DB,
  DBCtrls,

  ppTypes,
  ppCharacter,
  ppDB,
  ppComm,
  ppRTTI,
  ppUtils,
  ppCollectionBase;


type

  TppDBPipeline = class;

  {@TppDBDataLink }
  TppDBDataLink = class(TDataLink)
    private
      FOnActiveChanged: TNotifyEvent;
      FOnDataSetChanged: TNotifyEvent;
      FOnLayoutChanged: TNotifyEvent;

    protected
      procedure ActiveChanged; override;
      procedure CheckBrowseMode; override;
      procedure DataSetChanged; override;
      procedure LayoutChanged; override;

    public
      constructor Create;

      property OnActiveChanged: TNotifyEvent read FOnActiveChanged write FOnActiveChanged;

      property OnDataSetChanged: TNotifyEvent read FOnDataSetChanged write FOnDataSetChanged;
      property OnLayoutChanged: TNotifyEvent read FOnLayoutChanged write FOnLayoutChanged;

  end; {class, TppDBDataLink}

{$IFDEF Delphi12}

  {TppBookmarkItem}
  TppBookmarkItem = class
  private
    FBookmark: TBookmark;
    FKey: Integer;
  public
    constructor Create(aBookmark: TBookmark);
    destructor Destroy; override;


    property Bookmark: TBookmark read FBookmark;
    property Key: Integer read FKey;
  end;

  {TppBookmarkList}
  TppBookmarkList = class(TppCollectionBase)
  protected

    function GetItemForKey(aKey: Integer): TBookmark;
    function IndexOfKey(aKey: Integer): Integer;

  public
    function Add(aBookmark: TBookmark): Integer;
    function Remove(aBookmark: TBookmark): Integer; overload;
    function Remove(aKey: Integer): Integer; overload;

    constructor Create; override;

    property Items[Key: Integer]: TBookmark read GetItemForKey; default;


  end;

{$ENDIF}


  TppDataSetHook = procedure(aDBPipeline: TppDBPipeline; aDataSet: TDataSet) of object;

  {@TppDBPipeline

    Provides data access to Delphi TDataSet descendants. Assign a TppDBPipeline
    component to the DataPipeline property of any data-aware report component.
    Use the DataPipeline's DataSource property to specify the dataset from
    which data is to be retrieved.

    When the DataPipeline is assigned to a Report or ChildReport, several
    additional properties can be used to describe how the data should be
    traversed. The RangeBegin property describes the record on which traversal
    should start. The RangeEnd property describes the record on which traversal
    should stop.  The AddBookmark method can be used to traverse a list of
    records.

    The DataPipeline opens the DataSource when the report starts, and closes the
    DataSource when the report is freed. Use the OpenDataSource and
    CloseDataSource properties to override these behaviors.}

  {@TppDBPipeline.CloseDataSource

    If this property is set to True, the DataSource will be closed when the
    DataPipeline is destroyed.}

  {@TppDBPipeline.DataSource

    The DataSource property indicates the standard Delphi DataSource from
    which the DataPipeline will retrieve data.}

  {@TppDBPipeline.OpenDataSource

    When OpenDataSource is set to True, the DataSource is opened before the
    report begins traversing data.}

  {@TppDBPipeline.RefreshAfterPost

    Defaults to False.  Determines whether the TDataSet.Refresh method will 
    be called after a call has been made to the data pipeline Post method.

    Note: When a database is using triggers to populate field values, a
    call to refresh is sometimes needed in order to update the current
    record buffer with the field values for the newly created record.  In
    this case, a call to Refresh is in order.  However, most databases do
    not require the call to refresh and in some cases the BDE returns
    errors when Refresh is called after a post.  For this reason
    RefreshAfterPost defaults to False and is currently required only when
    using InterBase in the end-user reporting solution (report explorer)
    tables.}

  {@TppDBPipeline.SQL

    Provides access to the SQL object associated with a DBPipeline created via
    the Data workspace of the Report Designer. A type cast is required to use the
    SQL object.

    example:

      uses
        daSQL;

      begin
        lSQL := TdaSQL(myDBPipeline.SQL);

      end;}

  TppDBPipeline = class(TppCustomDataPipeline)
    private
      FDataLink: TppDBDataLink;
      FDataSource: TDataSource;
      FDataSet: TDataSet;
      FFieldDataLink: TFieldDataLink;
      FOpenDataSource: Boolean;
      FBookmarksExist: Boolean;
{$IFDEF Delphi12}
      FBookmarkCache: TppBookmarkList;
{$ENDIF}
      FCloseDataSource: Boolean;
      FRefreshAfterPost: Boolean;

      procedure ActiveChangedEvent(Sender: TObject);
      procedure DataSetChangedEvent(Sender: TObject);
      function  GetDataSource: TDataSource;
      function GetMasterDataSource: TDataSource;
      procedure SetDataSource(aDataSource: TDataSource);
      function  SetCurrentField(aFieldName: String): Boolean;
      procedure SetMasterDataSource(const Value: TDataSource);

    protected
      procedure BuildDetailPipelineList(aPipelines: TList); override;
      procedure CloseDataSet; override;
      function  GetActive: Boolean; override;
      function  CheckBOF: Boolean; override;
      function  CheckEOF: Boolean; override;
      procedure GotoFirstRecord; override;
      procedure GotoLastRecord; override;
      function IsValidBookmark(aBookmark: Integer): Boolean; virtual;
      procedure OpenDataSet; override;
      function TraverseBy(aIncrement: Integer): Integer; override;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      class procedure RegisterDataSetUpdateHook(aDataSetHook: TppDataSetHook);
      class procedure SetStringTrim(aValue: Boolean);

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;
      procedure Notification(aComponent: TComponent; Operation: TOperation); override;

      procedure FreeBookmark(aBookmark: Longint); override;
      function  GetBookmark: Longint; override;
      function  GetDataSetName: String; override;
      function  GetFieldNames(aFieldNameList: TStrings): Boolean; override;
      function  GetFieldAlignment(aFieldName: String): TAlignment; override;
      function  GetFieldAsDouble(aFieldName: String): Double; override;
      function  GetFieldAsGuid(aFieldName: String): TGUID; override;
      function  GetFieldAsPicture(aFieldName: String): TPicture; override;
      procedure GetFieldAsStream(aFieldName: String; aStream: TStream); override;
      function  GetFieldAsString(aFieldName: String): String; override;
      function  GetFieldDataType(aFieldName: String): TppDataType; override;
      function  GetFieldDisplayWidth(aFieldName: String): Integer; override;
      function  GetFieldIsCalculated(aFieldName: String): Boolean; override;
      function  GetFieldIsNull(aFieldName: String): Boolean; override;
      function  GetFieldSize(aFieldName: string): Integer; override;
      function  GetFieldValue(aFieldName: string): Variant; override;

      procedure GotoBookmark(aBookmark: Longint); override;
      function CompareBookmarks(aBookmark1, aBookmark2: Integer): Integer; override;

    {optional section

     These search/edit/insert routines are required if you want to load and
     save Report templates to database blob fields as in the End-User demo}

      procedure Delete; override;
      procedure Edit;  override;
      procedure Insert; override;
      function  Locate(const aFieldName: string; aKeyValue: Variant; aOptions: TppLocateOptions): Boolean; override;
      procedure Post; override;
      procedure SetFieldFromStream(aFieldName: String; aStream: TStream); override;
      procedure SetFieldValue(aFieldName: String; aValue: Variant); override;

    {end of optional section}


      property MasterDataSource: TDataSource read GetMasterDataSource write SetMasterDataSource;
      property SQL; // redeclared for docomatic

    published
      property DataSource: TDataSource read GetDataSource  write SetDataSource;
      property CloseDataSource: Boolean read FCloseDataSource write FCloseDataSource default False;
      property OpenDataSource: Boolean read FOpenDataSource write FOpenDataSource default True;
      property RefreshAfterPost: Boolean read FRefreshAfterPost write FRefreshAfterPost default False;

      {TppDataPipeline properties}
      property AutoCreateFields;
      property MasterDataPipeline;
      property MasterFieldLinks;
      property MoveBy;
      property RangeEnd;
      property RangeEndCount;
      property RangeBegin;
      property SkipWhenNoRecords;
      property UserName;
      property Visible;

      {TppDataPipeline events}
      property AfterClose;
      property AfterOpen;
      property BeforeClose;
      property BeforeOpen;
      property OnDataChange;
      property OnFirst;
      property OnGotoBookmark;
      property OnLast;
      property OnMasterRecordPositionChange;
      property OnNext;
      property OnPrior;
      property OnRecordPositionChange;
      property OnTraversal;

  end; {class, TppDBPipeline}


 {@TppChildDBPipeline }
  TppChildDBPipeline = class(TppDBPipeline)
    protected
      function GetChildOwner: TComponent; override;

    public
      function HasParent: Boolean; override;

    published
      property DataSource stored False;

    end; {class, TppChildDBPipeline}


  {@TppChildDataSource }
  TppChildDataSource = class(TDataSource)
    public
      function HasParent: Boolean; override;
    end; {class, TppChildDataSource}

{******************************************************************************
 *
 ** R T T I
 *
{******************************************************************************}

  {@TraTppDBPipelineRTTI }
  TraTppDBPipelineRTTI = class(TraTppDataPipelineRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppDBPipelineRTTI}

  function ppConvertFieldType(aFieldType: TFieldType): TppDataType;

implementation

var
  FDataSetHook: TppDataSetHook;
  FStringTrim: Boolean;

{******************************************************************************
 *
 ** C H I L D   D B  P I P E L I N E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppChildDBPipeline.GetChildOwner }

function TppChildDBPipeline.GetChildOwner: TComponent;
begin
  Result := Self;
end; {function, GetChildOwner}

{------------------------------------------------------------------------------}
{ TppChildDBPipeline.HasParent }

function TppChildDBPipeline.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}


{******************************************************************************
 *
 ** C H I L D   D A T A S O U R C E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppChildDataSource.HasParent }

function TppChildDataSource.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}



{******************************************************************************
 *
 ** D B  D A T A L I N K
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDBDataLink.Create }

constructor TppDBDataLink.Create;
begin
  inherited Create;

  FOnActiveChanged := nil;
  FOnDataSetChanged := nil;
  FOnLayoutChanged := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDBDataLink.ActiveChanged }

procedure TppDBDataLink.ActiveChanged;
begin
  if Assigned(FOnActiveChanged) then FOnActiveChanged(Self);
end; {procedure, ActiveChanged}

{------------------------------------------------------------------------------}
{ TppDBDataLink.LayoutChanged }

procedure TppDBDataLink.LayoutChanged;
begin
  if Assigned(FOnLayoutChanged) then FOnLayoutChanged(Self);
end; {procedure, LayoutChanged}

{------------------------------------------------------------------------------}
{ TppDBDataLink.DataSetChanged }

procedure TppDBDataLink.DataSetChanged;
begin
  if Assigned(FOnDataSetChanged) then FOnDataSetChanged(Self);
end; {procedure, DataSetChanged}

{------------------------------------------------------------------------------}
{ TppDBDataLink.CheckBrowseMode }

procedure TppDBDataLink.CheckBrowseMode;
begin
  if Assigned(FOnDataSetChanged) then FOnDataSetChanged(Self);
end; {procedure, CheckBrowseMode}

{******************************************************************************
 *
 ** D B   P I P E L I N E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDBPipeline.Create }

constructor TppDBPipeline.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FBookmarksExist := False;
  FOpenDataSource := True;
  FCloseDataSource := False;
  FRefreshAfterPost := False;

  FDataSource := nil;
  FDataSet := nil;

  FDataLink := TppDBDataLink.Create;

  FDataLink.OnActiveChanged := ActiveChangedEvent;
  FDataLink.OnDataSetChanged := DataSetChangedEvent;

  FFieldDataLink := TFieldDataLink.Create;

{$IFDEF Delphi12}
  FBookmarkCache := TppBookmarklist.Create;
{$ENDIF}

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDBPipeline.Destroy }

destructor TppDBPipeline.Destroy;
begin
  Destroying;
  
  Close;

  FDataLink.Free;
  FDataLink := nil;
  FFieldDataLink.Free;
{$IFDEF Delphi12}
  FBookmarkCache.Clear;
  FBookmarkCache.Free;
{$ENDIF}

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppDBPipeline.RegisterDataSetUpdateHook }

class procedure TppDBPipeline.RegisterDataSetUpdateHook(aDataSetHook: TppDataSetHook);
begin
  FDataSetHook := aDataSetHook;

end;  {class procedure, RegisterDataSetUpdateHook}

{------------------------------------------------------------------------------}
{ TppDBPipeline.SetStringTrim }

class procedure TppDBPipeline.SetStringTrim(aValue: Boolean);
begin
  FStringTrim := aValue;
end;  {class procedure, SetStringTrim}

{------------------------------------------------------------------------------}
{ TppDBPipeline.Notify }

procedure TppDBPipeline.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (aCommunicator = Self) and (aOperation = ppopDataChange) and FieldsOutOfSync then
     CreateDefaultFields;

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TppDBPipeline.Notification }

procedure TppDBPipeline.Notification(aComponent: TComponent; Operation: TOperation);
begin

  inherited Notification(aComponent, Operation);

  if (Operation = opRemove) then
    begin

      if (aComponent = FDataSource) then
        begin
          Close;

          FDataSource := nil;
          FDataSet := nil;
        end

      else if (aComponent = FDataSet) then
        begin
          Close;

          FDataSet := nil;
        end;

    end;

end; {procedure, Notification}

{------------------------------------------------------------------------------}
{ TppDBPipeline.BuildDetailPipelineList}

procedure TppDBPipeline.BuildDetailPipelineList(aPipelines: TList);
var
  liIndex: Integer;
  lPipeline: TppDataPipeline;

begin

  inherited BuildDetailPipelineList(aPipelines);

  for liIndex := 0 to aPipelines.Count-1 do
    begin
      lPipeline := TppDataPipeline(aPipelines[liIndex]);

      {check whether pipeline is already in the list}
      if (lPipeline <> Self) and (DetailPipelines.IndexOf(lPipeline) < 0) then
        if (lPipeline.InheritsFrom(TppDBPipeline)) and
           (GetDataSource = TppDBPipeline(lPipeline).MasterDataSource) then
            begin
              lPipeline.MasterDataPipeline := Self;
              lPipeline.AddNotify(Self);

              DetailPipelines.Add(lPipeline);
            end;

    end;

end; {procedure, BuildDetailPipelineList}

{------------------------------------------------------------------------------}
{ TppDBPipeline.GetDataSource }

function TppDBPipeline.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end; {procedure, GetDataSource}

{------------------------------------------------------------------------------}
{ TppDBPipeline.GetMasterDataSource }

function TppDBPipeline.GetMasterDataSource: TDataSource;
begin

  Result := nil;

  if FDataLink.DataSet = nil then Exit;

  {check for the DataSource property - may be DataSource or MasterSource,
   depending on whether a table or query}

  if ppCheckPropInfo(FDataLink.DataSet, 'DataSource') then
    Result :=  TDataSource(ppGetOrdPropValue(FDataLink.DataSet, 'DataSource'))

  else if ppCheckPropInfo(FDataLink.DataSet, 'MasterSource') then
    Result :=  TDataSource(ppGetOrdPropValue(FDataLink.DataSet, 'MasterSource'))

end; {function, GetMasterDataSource}

{------------------------------------------------------------------------------}
{ TppDBPipeline.SetDataSource }

procedure TppDBPipeline.SetDataSource(aDataSource: TDataSource);
begin

  FDataSource := aDataSource;
  FDataLink.DataSource := aDataSource;

  FDataSet := FDataLink.DataSet;


  if (FDataSource <> nil) then
    FDataSource.FreeNotification(Self);

  SyncFields;

end; {procedure, SetDataSource}

{------------------------------------------------------------------------------}
{ TppDBPipeline.ActiveChangedEvent }

procedure TppDBPipeline.ActiveChangedEvent(Sender: TObject);
begin

  {free bookmarks, if DataSource or DataSet is being destroyed}
   if (FDataSource <> nil) and (csDestroying in FDataSource.ComponentState) then
     Close

   else if (FDataSet <> nil) and (csDestroying in FDataSet.ComponentState) then
     Close

   {free bookmarks, if DataSet is being closed}
   else if not (csDestroying in ComponentState) and
           (FDataSet <> nil) and not (FDataSet.Active) then
     Close
   else
     DoOnDataChange;


  if (csDestroying in ComponentState) then Exit;


  {clear any residual field setting}
  FFieldDataLink.FieldName := '';


  if AutoCreateFields then
    if Active then
      SyncFields
    else
      FreeFields;


  DoOnActiveChange;


end; {procedure, ActiveChangedEvent}

{------------------------------------------------------------------------------}
{ TppDBPipeline.DataSetChangedEvent }

procedure TppDBPipeline.DataSetChangedEvent(Sender: TObject);
begin
  DoOnDataChange;
end; {procedure, DataSetChangedEvent}

{------------------------------------------------------------------------------}
{ TppDBPipeline.GetActive }

function TppDBPipeline.GetActive: Boolean;
begin
  Result := FDataLink.Active

end; {procedure, GetActive}

{------------------------------------------------------------------------------}
{ TppDBPipeline.GetFieldNames }

function TppDBPipeline.GetFieldNames(aFieldNameList: TStrings): Boolean;
var
  liFieldCount: Integer;
{$IFDEF Delphi10}
  lWideStrings: TWideStringList;
{$ENDIF}
begin

  Result := True;

  liFieldCount := inherited GetFieldCount;

  if (liFieldCount = 0) then
    begin

      if (FDataLink.DataSet <> nil) then
        try

{$IFDEF Delphi10}
          lWideStrings := TWideStringList.Create;

          try
            FDataLink.DataSet.GetFieldNames(lWideStrings);

            aFieldNameList.Assign(lWideStrings);
          finally
            lWideStrings.Free;
          end;

{$ELSE}
          FDataLink.DataSet.GetFieldNames(aFieldNameList);
{$ENDIF}

        except on EDatabaseError do
          begin
            aFieldNameList.Clear;
            Result := False;
          end

        end {try, except}

      else
        begin
          aFieldNameList.Clear;
          Result := False;
        end;

    end; {if, FieldCount = 0}

  {pull list from saved field objects}
  if not(CreatingDefaultFields) then
    Result := inherited GetFieldNames(aFieldNameList);

end; {function, GetFieldNames}

{------------------------------------------------------------------------------}
{ TppDBPipeline.GetDataSetName }

function TppDBPipeline.GetDataSetName: String;
begin

  if FDataLink.DataSet <> nil then
    Result := FDataLink.DataSet.Name
  else
    Result := '';

end; {function, GetDataSetName}


{------------------------------------------------------------------------------}
{ TppDBPipeline.GetFieldAsDouble }

function TppDBPipeline.GetFieldAsDouble(aFieldName: String): Double;
begin
  Result := 0;

  if not SetCurrentField(aFieldName) or (ppdaNoRecords in State) then Exit;

  Result := FFieldDataLink.Field.AsFloat

end; {function, GetFieldAsDouble}

{------------------------------------------------------------------------------}
{ TppDBPipeline.GetFieldAsGuid}

function TppDBPipeline.GetFieldAsGuid(aFieldName: String): TGUID;
begin
  Result := cNullGuid;

  if not SetCurrentField(aFieldName) or (ppdaNoRecords in State) then Exit;

  if FFieldDataLink.Field is TGuidField then
    Result := TGuidField(FFieldDataLink.Field).AsGuid
  else
    Result := StringToGUID(GetFieldAsString(aFieldName));

end; {function, GetFieldAsGuid}

{------------------------------------------------------------------------------}
{ TppDBPipeline.GetFieldAsPicture }

function TppDBPipeline.GetFieldAsPicture(aFieldName: String): TPicture;
begin

  Result := nil;

  if not SetCurrentField(aFieldName) or (ppdaNoRecords in State) then Exit;

  if FFieldDataLink.Field is TBlobField then
    Result := TPicture(FFieldDataLink.Field);

end; {function, GetFieldAsPicture}

{------------------------------------------------------------------------------}
{ TppDBPipeline.GetFieldAsString }

function TppDBPipeline.GetFieldAsString(aFieldName: String): String;
begin
  Result := '';

  if not SetCurrentField(aFieldName) or (ppdaNoRecords in State) then Exit;

  Result := FFieldDataLink.Field.AsString;

end; {function, GetFieldAsString}

{------------------------------------------------------------------------------}
{ TppDBPipeline.GetFieldAlignment }

function TppDBPipeline.GetFieldAlignment(aFieldName: String): TAlignment;
begin

  {try to use TField info}
  if SetCurrentField(aFieldName) then
    Result := FFieldDataLink.Field.Alignment
  else
    Result := inherited GetFieldAlignment(aFieldName);

end; {function, GetFieldAlignment}

{------------------------------------------------------------------------------}
{ TppDBPipeline.GetFieldDataType }

function TppDBPipeline.GetFieldDataType(aFieldName: String): TppDataType;
begin

  Result := dtNotKnown;

  // optimization, use TppField if possible
  if SetFieldName(aFieldName) then
    Result := CurrentField.DataType;

  if (Result = dtNotKnown) then
    begin

      {try using TppField info, if not auto create fields}
      if not AutoCreateFields then
        Result := inherited GetFieldDataType(aFieldName)
      else
        Result := dtNotKnown;

      if (Result <> dtNotKnown) then Exit;

      {try to use TField info}
      if not(Active) then
        try
          Open;
        except

        end;

      if SetCurrentField(aFieldName) then
        Result := ppConvertFieldType(FFieldDataLink.Field.DataType);

    end;

end; {function, GetFieldDataType}

{------------------------------------------------------------------------------}
{ TppDBPipeline.GetFieldDisplayWidth }

function TppDBPipeline.GetFieldDisplayWidth(aFieldName: String): Integer;
begin

  {try using TppField info, if not auto create fields}
  if not AutoCreateFields then
    Result := inherited GetFieldDisplayWidth(aFieldName)
  else
    Result := 0;

  if (Result <> 0) then Exit;

  {try to use TField info, if auto create fields true}
  if SetCurrentField(aFieldName) then
    Result := FFieldDataLink.Field.DisplayWidth;

end; {function, GetFieldDisplayWidth}

{------------------------------------------------------------------------------}
{ TppDBPipeline.GetFieldIsNull }

function TppDBPipeline.GetFieldIsNull(aFieldName: String): Boolean;
begin
  Result := True;

  if not SetCurrentField(aFieldName) or (ppdaNoRecords in State) then Exit;

  Result := FFieldDataLink.Field.IsNull

end; {function, GetFieldIsNull}

{------------------------------------------------------------------------------}
{ TppDBPipeline.GetFieldIsCalculated }

function TppDBPipeline.GetFieldIsCalculated(aFieldName: String): Boolean;
begin
  if SetCurrentField(aFieldName) then
    Result := FFieldDataLink.Field.Calculated
  else
    Result := False;

end; {function, GetFieldIsCalculated}

{------------------------------------------------------------------------------}
{ TppDBPipeline.GetFieldSize }

function TppDBPipeline.GetFieldSize(aFieldName: string): Integer;
begin

  {try using TppField info, if not auto create fields}
  if not AutoCreateFields then
    Result := inherited GetFieldSize(aFieldName)
  else
    Result := 0;

  if (Result <> 0) then Exit;

  {try to use TField info, if AutoCreateFields true}
  if SetCurrentField(aFieldName) then
    Result := FFieldDataLink.Field.Size;

end; {function, GetFieldSize}

{------------------------------------------------------------------------------}
{ TppDBPipeline.GetFieldValue }

function TppDBPipeline.GetFieldValue(aFieldName: string): Variant;
var
  lField: TField;
begin

  Result := Null;

  if (FDataLink.DataSet <> nil) then
    lField := FDataLink.DataSet.FindField(aFieldName)
  else
    lField := nil;

  if (lField = nil) or (ppdaNoRecords in State) then Exit;

  if (lField.IsNull) then Exit;

  case GetFieldDataType(aFieldName) of
    dtString, dtChar, dtMemo:
      begin
        Result := lField.AsString;
        if FStringTrim then
          Result := TrimRight(Result);
      end;

    dtDouble, dtSingle, dtExtended:
      Result := lField.AsFloat;

    dtInteger, dtLongInt:
      Result := lField.AsInteger;

    dtLargeInt:
{$IFDEF Delphi6}
      Result := TLargeintField(lField).AsLargeInt;
{$ELSE}
      {Delphi 5 variants do not support Int64}
      Result := TLargeintField(lField).AsInteger;
{$ENDIF}

    dtCurrency:
      Result := lField.AsCurrency;

    dtDate, dtTime, dtDateTime:
      Result := lField.AsDateTime;

    dtBoolean:
      if (lField is TBooleanField) and
         (TBooleanField(lField).DisplayValues <> '') then
        Result := lField.AsString
      else
        Result := lField.AsBoolean;

    dtGUID:
      Result := lField.AsString;
      
  end;

end; {function, GetFieldValue}

{------------------------------------------------------------------------------}
{ TppDBPipeline.SetCurrentField }

function TppDBPipeline.SetCurrentField(aFieldName: String): Boolean;
begin

  try
    if (FFieldDataLink.DataSource <> FDataLink.DataSource) then
      FFieldDataLink.DataSource := FDataLink.DataSource;

    if (CompareText(FFieldDataLink.FieldName, aFieldName) <> 0) then
      FFieldDataLink.FieldName := aFieldName;

    if (FFieldDataLink.Field <> nil) then
      Result := True
    else
      Result := False;

  except on EDatabaseError do
    begin
     Result := False;
     FFieldDataLink.FieldName := '';
    end;

  end;

end; {function, SetCurrentField}

{------------------------------------------------------------------------------}
{ TppDBPipeline.FreeBookmark }

{$IFDEF Delphi12}
procedure TppDBPipeline.FreeBookmark(aBookmark: Longint);
begin

  // remove bookmark from cache
  FBookmarkCache.Remove(aBookmark);

end;

{$ELSE}

procedure TppDBPipeline.FreeBookmark(aBookmark: Longint);
var
  lBookmark: TBookmark;
begin

  lBookmark := TBookmark(aBookmark);

  {note: use FDataSet here because FDataLink.DataSet returns nil
         when the TDataSource or TDataSet objects are csDestroying}
  if (FDataSet <> nil) then
    FDataSet.FreeBookmark(lBookmark)

  else if (FDataLink <> nil) and (FDataLink.DataSet <> nil) then
    FDataLink.DataSet.FreeBookmark(lBookmark);


end; {procedure, FreeBookmark}

{$ENDIF}

{------------------------------------------------------------------------------}
{ TppDBPipeline.GetBookmark }

function  TppDBPipeline.GetBookmark: Longint;
var
  lBookmark: TBookmark;

begin
  Result := 0;

  if (FDataLink = nil) or (FDataLink.DataSet = nil) then Exit;

  lBookmark := FDataLink.DataSet.GetBookmark;

  if (lBookmark <> nil) then
    begin
{$IFDEF Delphi12}
      FBookmarkCache.Add(lBookmark);
{$ENDIF}
      Result := Longint(lBookmark);

    end;

end; {procedure, GetBookmark}

{------------------------------------------------------------------------------}
{ TppDBPipeline.GotoBookmark }

procedure TppDBPipeline.GotoBookmark(aBookmark: Longint);
var
  liIndex: Integer;
  lBookmark: TBookmark;
begin

  if (FDataLink.DataSet = nil) then Exit;

  lBookmark := TBookmark(aBookmark);

  if (lBookmark <> nil) and IsValidBookmark(aBookmark) then
    FDataLink.DataSet.GotoBookmark(lBookmark)

  else
    begin
      {goto last record in detail dataset, handles SQL Server 7 BDE bug}
      if (TraversalCount <> 0) then
        begin
          FDataLink.DataSet.First;

          for liIndex := 0 to TraversalCount - 1 do
            FDataLink.DataSet.Next;
        end;
    end;

  inherited GotoBookmark(aBookmark);


end; {procedure, GotoBookmark}

{------------------------------------------------------------------------------}
{ TppDBPipeline.IsValidBookmark }

function TppDBPipeline.IsValidBookmark(aBookmark: Integer): Boolean;
var
  lClass: TClass;
begin

  Result := FDataLink.DataSet.BookmarkValid(TBookmark(aBookmark));

  if not Result and (TBookmark(aBookmark) <> nil) then
    begin
      {IBExpress does not implement the BookmarkValid function}
      lClass := GetClass('TIBCustomDataSet');

      if FDataLink.DataSet.InheritsFrom(lClass) then
        Result := True;

    end;


end; {function, IsValidBookmark }


{------------------------------------------------------------------------------}
{ TppDBPipeline.CompareBookmarks }

function TppDBPipeline.CompareBookmarks(aBookmark1, aBookmark2: Integer): Integer;
begin

 if FDataLink.DataSet <> nil then
   Result := FDataLink.DataSet.CompareBookmarks(TBookmark(aBookmark1), TBookmark(aBookmark2))
 else
   Result :=  inherited CompareBookmarks(aBookmark1, aBookmark2);

end; {procedure, CompareBookmarks}


{------------------------------------------------------------------------------}
{ TppDBPipeline.Edit }

procedure TppDBPipeline.Edit;
begin
  if (FDataLink.DataSet <> nil) then
    FDataLink.DataSet.Edit;
end; {procedure, Edit}
 
{------------------------------------------------------------------------------}
{ TppDBPipeline.Insert }

procedure TppDBPipeline.Insert;
begin
  if (FDataLink.DataSet <> nil) then
    FDataLink.DataSet.Insert;
end; {procedure, Insert}

{------------------------------------------------------------------------------}
{ TppDBPipeline.Delete }

procedure TppDBPipeline.Delete;
begin
  if (FDataLink.DataSet <> nil) then
    begin
      FDataLink.DataSet.Delete;
      if Assigned(FDataSetHook) then
        FDataSetHook(Self, FDataLink.DataSet);
    end;

end; {procedure, Delete}

{------------------------------------------------------------------------------}
{ TppDBPipeline.Post }

procedure TppDBPipeline.Post;
begin
  if (FDataLink.DataSet <> nil) then
    begin
      FDataLink.DataSet.Post;

      if Assigned(FDataSetHook) then
        FDataSetHook(Self, FDataLink.DataSet);

      if RefreshAfterPost then
        FDataLink.DataSet.Refresh;

    end;
end; {procedure, Post}

{------------------------------------------------------------------------------}
{ TppDBPipeline.GetFieldAsStream }

procedure TppDBPipeline.GetFieldAsStream(aFieldName: String; aStream: TStream);
var
  lsValue: String;
  lbGetAsString: Boolean;
begin

  if not(SetCurrentField(aFieldName)) then Exit;

{$IFDEF Delphi10}
  lbGetAsString := (FFieldDataLink.Field is TWideMemoField) or
                   (FFieldDataLink.Field is TMemoField) or
                    not(FFieldDataLink.Field is TBlobField);
{$ELSE}
  lbGetAsString := not(FFieldDataLink.Field is TBlobField);
{$ENDIF}

  if (lbGetAsString) then
    begin
      // use GetFieldAsString, the TField will internally do any needed string conversion
      lsValue := GetFieldAsString(aFieldname);
      aStream.WriteBuffer(lsValue[1], ppByteLength(lsValue));
    end
  else
    TBlobField(FFieldDataLink.Field).SaveToStream(aStream);

end; {procedure, GetFieldAsStream}

{------------------------------------------------------------------------------}
{ TppDBPipeline.SetFieldFromStream}

procedure TppDBPipeline.SetFieldFromStream(aFieldName: String; aStream: TStream);
var
  lsValue: String;
  lbSetAsString: Boolean;
begin

  if not(SetCurrentField(aFieldName)) then Exit;

{$IFDEF Delphi10}
  lbSetAsString := (FFieldDataLink.Field is TWideMemoField) or
                   (FFieldDataLink.Field is TMemoField) or
                    not(FFieldDataLink.Field is TBlobField);
{$ELSE}
  lbSetAsString := not(FFieldDataLink.Field is TBlobField);
{$ENDIF}

  if (lbSetAsString) then
    begin
      // read string into lsValue
      SetLength(lsValue, ppCharLength(aStream.Size));
      aStream.ReadBuffer(lsValue[1], aStream.Size);

      // set Field.AsString, the TField will internally do any needed string conversion
      FFieldDataLink.Field.AsString := lsValue;
    end
  else
    TBlobField(FFieldDataLink.Field).LoadFromStream(aStream);

end; {procedure, SetFieldFromStream}



{------------------------------------------------------------------------------}
{ TppDBPipeline.SetFieldValue }

procedure TppDBPipeline.SetFieldValue(aFieldName: String; aValue: Variant);
begin

  if SetCurrentField(aFieldName) then
    FFieldDataLink.Field.Value := aValue;

end; {procedure, SetFieldValue}


{------------------------------------------------------------------------------}
{ TppDBPipeline.Locate }

function TppDBPipeline.Locate(const aFieldName: string; aKeyValue: Variant; aOptions: TppLocateOptions): Boolean;
var
  lLocateOptions: TLocateOptions;
  lField: TField;

begin

  Result := False;

  if (FDataLink.DataSet = nil) then Exit;

  {make sure dataset is open}
  if not FDataLink.DataSet.Active then
    FDataLink.DataSet.Open;

  if ppVariantIsString(aKeyValue) then
    begin
      if not SetCurrentField(aFieldName) then Exit;

      lField := FFieldDataLink.Field;

      {truncate KeyValue if too long - otherwise get BDE error }
       if ppVariantIsString(aKeyValue) then
        if (Length(aKeyValue) > lField.Size) and (lField.Size > 0) then
          aKeyValue := Copy(aKeyValue, 1, lField.Size)
        else
          aKeyValue := aKeyValue;

    end;

  lLocateOptions := [];

  if pploCaseInsensitive in aOptions then
    Include(lLocateOptions, loCaseInsensitive);

  if pploPartialKey in aOptions then
    Include(lLocateOptions,  loPartialKey);

  {go to beginning of data set}
  FDataLink.DataSet.First;

  Result := FDataLink.DataSet.Locate(aFieldName, aKeyValue, lLocateOptions);

end; {procedure, Locate}

{------------------------------------------------------------------------------}
{ TppDBPipeline.CheckBOF }

function TppDBPipeline.CheckBOF: Boolean;
begin
  if FDataLink.DataSet = nil then
    Result := True
  else
    Result := FDataLink.DataSet.BOF;
end; {procedure, CheckBOF}

{------------------------------------------------------------------------------}
{ TppDBPipeline.CheckEOF }

function TppDBPipeline.CheckEOF: Boolean;
begin
  if FDataLink.DataSet = nil then
    Result := True
  else
    Result := FDataLink.DataSet.EOF;
end; {procedure, CheckEOF}

{------------------------------------------------------------------------------}
{ TppDBPipeline.OpenDataSet }

procedure TppDBPipeline.OpenDataSet;
begin

  if (FDataSet <> nil) and (csDestroying in FDataSet.ComponentState) then Exit;

  FDataSet := FDataLink.DataSet;

  if (FDataSet <> nil) then
    FDataSet.FreeNotification(Self);

  if FOpenDataSource and (FDataLink.DataSet <> nil) and not(FDataLink.DataSet.Active) then
    try
      FDataLink.DataSet.Open;
    except on E: Exception do
      raise EDataError.Create(E.Message);
    end;

end; {procedure, OpenTheDataPipeline}

{------------------------------------------------------------------------------}
{ TppDBPipeline.CloseDataSet }

procedure TppDBPipeline.CloseDataSet;
begin

  if FCloseDataSource and (FDataLink.DataSet <> nil) then
    FDataLink.DataSet.Close;

end; {procedure, CloseDataSet}

{------------------------------------------------------------------------------}
{ TppDBPipeline.GotoFirstRecord }

procedure TppDBPipeline.GotoFirstRecord;
begin
  if (FDataLink.DataSet <> nil) then
    FDataLink.DataSet.First;

  inherited GotoFirstRecord;

end; {procedure, GotoFirstRecord}

{------------------------------------------------------------------------------}
{ TppDBPipeline.TraverseBy }

function TppDBPipeline.TraverseBy(aIncrement: Integer): Integer;
begin
  if (FDataLink.DataSet <> nil) then
    Result := FDataLink.DataSet.MoveBy(aIncrement)
  else
    Result := 0;
end; {procedure, TraverseBy}

{------------------------------------------------------------------------------}
{ TppDBPipeline.GotoLastRecord }

procedure TppDBPipeline.GotoLastRecord;
begin
  if (FDataLink.DataSet <> nil) then
    FDataLink.DataSet.Last;

  inherited GotoLastRecord;
  
end; {procedure, GotoLastRecord}

procedure TppDBPipeline.SetMasterDataSource(const Value: TDataSource);
begin

  if FDataLink.DataSet = nil then Exit;

  {check for the DataSource property - may be DataSource or MasterSource,
   depending on whether a table or query}

  if ppCheckPropInfo(FDataLink.DataSet, 'DataSource') then
     ppSetOrdPropValue(FDataLink.DataSet, 'DataSource', Integer(Value))

  else if ppCheckPropInfo(FDataLink.DataSet, 'MasterSource') then
     ppSetOrdPropValue(FDataLink.DataSet, 'MasterSource', Integer(Value)) ;

end;

{------------------------------------------------------------------------------}
{ ppConvertFieldType }

function ppConvertFieldType(aFieldType: TFieldType): TppDataType;
begin

  case aFieldType of

        ftString:       Result := dtString;
        ftDate:         Result := dtDate;
        ftTime:         Result := dtTime;
        
{$IFDEF Delphi6}
        ftTimeStamp,
{$ENDIF}
        ftDateTime:     Result := dtDateTime;

        ftInteger,
        ftSmallInt:     Result := dtInteger;

        ftLargeInt:     Result := dtLargeInt;

        ftCurrency:     Result := dtCurrency;

        ftFloat,
{$IFDEF Delphi6}
        ftFMTBcd,
{$ENDIF}
        ftBCD:          Result := dtDouble;

        ftWord:         Result := dtLongint;
        ftBoolean:      Result := dtBoolean;

{$IFDEF Delphi10}
        ftWideMemo,
{$ENDIF}
        ftOraCLOB,
        ftMemo:         Result := dtMemo;
        ftGraphic:      Result := dtGraphic;
        ftBLOB,
        ftOraBLOB,
        ftBytes,
        ftVarBytes:     Result := dtBLOB;

        ftFmtMemo,
        ftParadoxOle,
        ftDBaseOle,
        ftTypedBinary:  Result := dtBLOB;

        ftAutoInc:      Result := dtLongint;

        ftGUID:         Result := dtGUID;

        else
          Result := dtString;

      end; {case, datatype}

end; {function, ConvertFieldType}


{******************************************************************************
 *
 ** B O O K  M A R K  L I S T
 *
{******************************************************************************}

{$IFDEF Delphi12}

{ TppBookmarkItem }

constructor TppBookmarkItem.Create(aBookmark: TBookmark);
begin
  inherited Create;

  FBookmark := aBookmark;
  FKey := Integer(FBookmark);

end;

destructor TppBookmarkItem.Destroy;
begin

  FBookmark := nil;
  inherited;
end;

{ TppBookmarkList }

function TppBookmarkList.Add(aBookmark: TBookmark): Integer;
var
  lItem: TppBookmarkItem;
begin

  Result := -1;

  if IndexOfKey(Integer(aBookmark)) >= 0 then Exit;

  lItem := TppBookmarkItem.Create(aBookmark);
  Result := InnerList.Add(lItem);

end;

constructor TppBookmarkList.Create;
begin
  inherited;

  InnerList.OwnsObjects := True;

end;

function TppBookmarkList.IndexOfKey(aKey: Integer): Integer;
var
  liIndex: Integer;
begin

  for liIndex := 0 to Count - 1 do
    begin
      if TppBookmarkItem(InnerList[liIndex]).Key = aKey then
        begin
          Result := liIndex;
          Exit;
        end;

    end;

  Result := -1;

end;

function TppBookmarkList.GetItemForKey(aKey: Integer): TBookmark;
var
  liIndex: Integer;
begin

  liIndex := IndexOfKey(aKey);

  if (liIndex > 0) then
    Result := TppBookmarkItem(InnerList[liIndex]).Bookmark
  else
    Result := nil;

end;

function TppBookmarkList.Remove(aKey: Integer): Integer;
var
  liIndex: Integer;
begin
  liIndex := IndexOfKey(aKey);

  if (liIndex > 0) then
    InnerList.Delete(liIndex);

  Result := liIndex;

end;

function TppBookmarkList.Remove(aBookmark: TBookmark): Integer;
begin

  Result := Remove(Integer(aBookmark));

end;

{$ENDIF}


{******************************************************************************
 *
 *
 *
 ** R T T I
 *
 *
 *
{******************************************************************************}

{******************************************************************************
 *
 ** D B   P I P E L I N E  R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppDBPipelineRTTI.RefClass }

class function TraTppDBPipelineRTTI.RefClass: TClass;
begin
  Result := TppDBPipeline;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppDBPipelineRTTI.GetPropList }

class procedure TraTppDBPipelineRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  aPropList.AddProp('SQL');

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppDBPipelineRTTI.GetPropRec }

class function TraTppDBPipelineRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if(CompareText(aPropRec.Name, 'AutoCreateFields') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'MoveBy') = 0) then
    PropToRec(aPropName, daInteger, False, aPropRec)

  else if (CompareText(aPropName, 'RangeEnd') = 0) then
    EnumPropToRec(aPropName, 'TppRangeEndType', False, aPropRec)

  else if (CompareText(aPropName, 'RangeEndCount') = 0) then
    PropToRec(aPropName, daInteger, False, aPropRec)

  else if (CompareText(aPropName, 'RangeBegin') = 0) then
    EnumPropToRec(aPropName, 'TppRangeBeginType', False, aPropRec)

  else if (CompareText(aPropName, 'DataSource') = 0) then
    ClassPropToRec(aPropName, TDataSource, False, aPropRec)

  else if (CompareText(aPropName, 'CloseDataSource') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'OpenDataSource') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'RefreshAfterPost') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'SQL') = 0) then
    ClassPropToRec(aPropName, TObject, True, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppDBPipelineRTTI.GetPropValue }

class function TraTppDBPipelineRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if(CompareText(aPropName, 'AutoCreateFields') = 0) then
    Boolean(aValue) := TppDBPipeline(aObject).AutoCreateFields

  else if (CompareText(aPropName, 'MoveBy') = 0) then
    Integer(aValue) := TppDBPipeline(aObject).MoveBy

  else if (CompareText(aPropName, 'RangeBegin') = 0) then
    Integer(aValue) := Ord(TppDBPipeline(aObject).RangeBegin)

  else if (CompareText(aPropName, 'RangeEndCount') = 0) then
    Integer(aValue) := TppDBPipeline(aObject).RangeEndCount

  else if (CompareText(aPropName, 'RangeEnd') = 0) then
    Integer(aValue) := Ord(TppDBPipeline(aObject).RangeEnd)

  else if (CompareText(aPropName, 'DataSource') = 0) then
    Integer(aValue) := Integer(TppDBPipeline(aObject).DataSource)

  else if (CompareText(aPropName, 'CloseDataSource') = 0) then
    Boolean(aValue) := TppDBPipeline(aObject).CloseDataSource

  else if (CompareText(aPropName, 'OpenDataSource') = 0) then
    Boolean(aValue) := TppDBPipeline(aObject).OpenDataSource

  else if (CompareText(aPropName, 'RefreshAfterPost') = 0) then
    Boolean(aValue) := TppDBPipeline(aObject).RefreshAfterPost

  else if (CompareText(aPropName, 'SQL') = 0) then
    Integer(aValue) := Integer(TppDBPipeline(aObject).SQL)

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppDBPipelineRTTI.SetPropValue }

class function TraTppDBPipelineRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if(CompareText(aPropName, 'AutoCreateFields') = 0) then
    TppDBPipeline(aObject).AutoCreateFields := Boolean(aValue)

  else if (CompareText(aPropName, 'MoveBy') = 0) then
    TppDBPipeline(aObject).MoveBy := Integer(aValue)

  else if (CompareText(aPropName, 'RangeBegin') = 0) then
    TppDBPipeline(aObject).RangeBegin := TppRangeBeginType(aValue)

  else if (CompareText(aPropName, 'RangeEndCount') = 0) then
    TppDBPipeline(aObject).RangeEndCount := Integer(aValue)

  else if (CompareText(aPropName, 'RangeEnd') = 0) then
    TppDBPipeline(aObject).RangeEnd := TppRangeEndType(aValue)

  else if (CompareText(aPropName, 'DataSource') = 0) then
    TppDBPipeline(aObject).DataSource := TDataSource(aValue)

  else if (CompareText(aPropName, 'CloseDataSource') = 0) then
    TppDBPipeline(aObject).CloseDataSource := Boolean(aValue)

  else if (CompareText(aPropName, 'OpenDataSource') = 0) then
    TppDBPipeline(aObject).OpenDataSource := Boolean(aValue)

  else if (CompareText(aPropName, 'RefreshAfterPost') = 0) then
    TppDBPipeline(aObject).RefreshAfterPost := Boolean(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}


{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}


initialization

  RegisterClasses([TppDBPipeline, TppChildDBPipeline, TppChildDataSource]);

  raRegisterRTTI(TraTppDBPipelineRTTI);

  FDataSetHook := nil;

finalization

  UnRegisterClasses([TppDBPipeline, TppChildDBPipeline, TppChildDataSource]);

  raUnRegisterRTTI(TraTppDBPipelineRTTI);

end.
