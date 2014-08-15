/// A unit containing a light memory table.

unit UFlxMemTable;
{$IFDEF LINUX}{$INCLUDE ../FLXCOMPILER.INC}{$ELSE}{$INCLUDE ..\FLXCOMPILER.INC}{$ENDIF}

interface
uses
  {$IFNDEF FLX_FPC} Windows,{$ENDIF}

  {$IFDEF FLX_NEEDSVARIANTS} variants, {$ENDIF}
  SysUtils, Classes, UXlsDB, UFlxMessages, Contnrs;

type
  TFlxMemTable=class;
  /// <summary>
  /// Event associated with <see cref="TFlxMemTable.OnGetData" text="TFlxMemTable.OnGetData " />in a memory
  /// dataset.<para></para>
  /// 
  /// </summary>                                                                                           
  TFlxMemTableOnGetDataEvent=procedure (Sender: TObject; const FieldName: WideString; const RecordPos: integer; var Value: variant) of object;
  /// <summary>
  /// Event associated with <see cref="TFlxMemTable.OnVirtualRecordCount" />.
  /// </summary>                                                             
  TOnVirtualRecordCountEvent=procedure (Sender: TObject; var RecordCount: integer) of object;

  /// <summary>
  /// Contains the field information for a TFlxMemTable.
  /// </summary>
  /// <remarks>
  /// This behaves like a normal TField class, but it is not derived from TField in order not to use the DB
  /// usnit and allow &quot;Db-less&quot; reports.
  /// </remarks>
  TFlxMemTableField=class(TInterfacedObject, IXlsField)
  private
    FMemTable: TFlxMemTable;
    FieldIndex: integer;
  public
    constructor Create(const aMemTable: TFlxMemTable; const aFieldIndex: integer);
    /// <summary>
    /// Value of the field.
    /// </summary>         
    function Value: variant;

    /// <summary>
    /// \Returns the IXlsDataset that contains this field.
    /// </summary>
    function DataSet: IXlsDataSet;

    /// <summary>
    /// \Returns true if the field is a DateTime field.
    /// </summary>
    /// <remarks>
    /// TFlexCelReport needs this property to know if to enter a date or a string into the cells.
    /// </remarks>                                                                               
    function IsTDateTimeField: boolean;

    /// <summary>
    /// \Returns true if the value is a memo field.
    /// </summary>
    /// <remarks>
    /// In the TFlxMemTable implementation this property returns always false, as you can't tell the type of
    /// a column when creating the column definitions.<para></para>
    /// TFlexCelReport uses this value to know if ti has to word-wrap the cells.
    /// </remarks>                                                                                          
    function IsTMemoField: boolean;

    /// <summary>
    /// Gets the field value as a float.
    /// </summary>
    function AsFloat: extended;

    /// <summary>
    /// \Returns true if the field is visible, false otherwise.
    /// </summary>
    /// <remarks>
    /// The TFlxMemTable implementation of this property always returns true, since you can't define hidden
    /// columns in a TFlxMemTable.<para></para>
    /// TFlexCelReport uses this property when <see cref="TCustomFlexCelReport.UseHiddenFields" /> is false.
    /// </remarks>                                                                                          
    function Visible: boolean;

    /// <summary>
    /// Display name for the field. Similar to DisplayName in TField.
    /// </summary>
    /// <remarks>
    /// In the TFlxMemTable implementation this property returns the same as the Name property.
    /// TFlexCelReport will call this property when <see cref="TCustomFlexCelReport.UseDisplayNames" /> is
    /// true.
    /// </remarks>                                                                                        
    function DisplayName: string;
  end;

  /// <summary>
  /// A column definition for a TFlxMemTable component.
  /// </summary>
  /// <remarks>
  /// You will normally create this columns at design time by double clicking the TFlxMemTable component
  /// and adding the columns in the field editor.
  /// </remarks>                                                                                        
  TFlxDbMemColumn = class (TCollectionItem)
  private
    FName: string;
  protected
    function GetDisplayName: string; override;
    procedure SetDisplayName(const Value: string); override;
  published
    /// <summary>
    /// Name of the database field.
    /// </summary>
    /// <remarks>
    /// This name is normally set at design time by double clicking the TFlxMemTable component that holds the
    /// fields. Use this property to dynamically create fields or to learn the name of a column in an
    /// existing TFlxMemTable.
    /// </remarks>                                                                                           
    property Name: string read FName write SetDisplayName;
  end;

  /// <summary>
  /// A collection of TFlxDbMemColumn objects.
  /// </summary>
  /// <remarks>
  /// This class is used internally by TFlxMemTable to hold its column definitions.<para></para>
  /// 
  /// </remarks>                                                                                
  TFlxDbMemColumnList = class (TOwnedCollection)   //Items are TFlxDbMem
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    function Find(const Name: string; out Index: integer): boolean;
  end;

  TFlxRecordList=class;

  TFlxRecord=class
  public
    Value: ArrayOfVariant;
    ParentList: TFlxMemTable;
    constructor Create(const aParentList: TFlxMemTable; const aValue: Array of Variant);
  end;

  TFlxRecordList=class(TObjectList) //Items are TFlxRecord
  {$INCLUDE TFlxRecordListHdr.inc}
  private
    MemTable: TFlxMemTable;
    FListName: UTF16String;
    FPosition: integer;
    function GetValue(FieldIndex: integer): variant;
  public
    constructor Create(const aMemTable: TFlxMemTable; const aListName: UTF16String);

    property Position: integer read FPosition;
    procedure Clear; override;
    property Value[FieldIndex: integer]: variant read GetValue;  //Don't allow modify...;

    property ListName:UTF16String read FListName;
  end;

  /// <summary>
  /// This class if for internal use.<para></para>
  /// 
  /// </summary>                                  
  TFlxMasterList=class(TObjectList)
  private
    MemTable: TFlxMemTable;

    function GetPosition(MasterCat: UTF16String): integer;
    function GetValue(MasterCat: UTF16String; FieldIndex: integer): variant;
    procedure SetPosition(MasterCat: UTF16String; const Value: integer);
    function GetRecordCount(MasterCat: UTF16String): integer; //Records are TFlxRecordList
  {$INCLUDE TFlxMasterListHdr.inc}
  public
    constructor Create(const aMemTable: TFlxMemTable);
    procedure AddRecord(const MasterCat: UTF16String; const Rec: TFlxRecord);
    procedure SortData;
    property Position[MasterCat:UTF16String]: integer read GetPosition write SetPosition;
    property Value[MasterCat: UTF16String;FieldIndex: integer]: variant read GetValue;  //Don't allow modify...;
    property RecordCount[MasterCat: UTF16String]: integer read GetRecordCount;
  end;

  /// <summary>
  /// An In-Memory table you can use as a source to TFlexCelReport.
  /// </summary>
  /// <remarks>
  /// Use FlxMemTable to pass memory data to a TFlexCelReport component. If you are not using Databases, or
  /// if you need to pass to Excel some special memory data that is not stored into the database, you can
  /// use this component as a proxy between your classes and FlexCelReport.<para></para>
  /// <para></para>
  /// FlxMemTable behaves as a normal dataset in FlexCel, but it doesn't include any DB overhead. You can
  /// use it the same way you would use a normal dataset, including using it as a PagesDataSet.<para></para>
  /// <para></para>
  /// This component can work in two ways: <b>Normal</b> mode and <b>Virtual</b> mode.<para></para>
  /// In normal mode you fill the database manually, by calling the AddRecord method. This method is best
  /// for small datasets since it is simpler to setup and also easier to use in Master.Detail. But if you
  /// have much data that you don't want to duplicate, you should use Virtual mode.<para></para>
  /// <para></para>
  /// In virtual mode, you set the values on the OnVirtualRecordCount and OnGetData events, so you don't
  /// need two copies of your data. No extra data is stored. Whenever you set any of those two events, the
  /// TFlxMemTable goes automatically to Virtual mode. So if you want to bring back a table to normal mode,
  /// make sure you delete those events.<para></para>
  /// <para></para>
  /// <b>NOTE: </b>If you are using any other memory table in your application (like a TClientDataSet) you
  /// might find easier to use those tables instead of a TFlxMemoryTable in normal mode. But you will still
  /// need TFlxMemTable in virtual to send non-dataset data (like a TList) to a report without filling a
  /// temporary memory table.
  /// </remarks>                                                                                            
  TFlxMemTable = class(TComponent, IUnknown, IXlsDataSet)
  private
    FOnLast: TNotifyEvent;
    FOnNext: TNotifyEvent;
    FOnFirst: TNotifyEvent;
    FColumns: TFlxDbMemColumnList;
    FData: TFlxMasterList;

    FActive: boolean;
    FMasterTable: TFlxMemTable;
    FMasterField: string;
    FVirtualPos: integer;


    FOnGetData: TFlxMemTableOnGetDataEvent;
    FOnVirtualRecordCount: TOnVirtualRecordCountEvent;
    FIndexFieldNames: string;
    FDuplicates: TDuplicates;
    FCaseInsensitive: boolean;
    function MastValue: variant;
    procedure SetMasterField(const Value: string);
    procedure SetMasterTable(const Value: TFlxMemTable);
    function GetVirtualRecordCount: integer;
    procedure SetDuplicates(const Value: TDuplicates);
    procedure SetIndexFieldNames(const Value: string);

  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

  public
    constructor Create(AOwner: TComponent);override;
    destructor Destroy; override;

    /// <summary>
    /// Deletes all data stored in the table.
    /// </summary>
    /// <remarks>
    /// This method only makes sense in normal mode.<para></para>
    /// 
    /// </remarks>                                               
    procedure Clear;

    /// <summary>
    /// This method adds a new record to the table.
    /// </summary>
    /// <remarks>
    /// This method only has effect when you are in <b>normal</b> mode (that is, OnVirtualRecordCount is not
    /// set)
    /// </remarks>
    /// <param name="aValues">Array of values for the new record. Length(aValues) should be the same as the
    ///                       number of fields in the memory table.</param>
    /// 
    /// <example>
    /// This example will create a<b> normal</b> FlxMemTable containing 2 columns and 5 records. Note that in
    /// normal mode, values will be kept into memory. If you don't want this, use virtual mode.<para></para>
    /// <para></para>
    /// Column 1 will be named &quot;Number&quot; and will have the values 0;1;2;3;4<para></para>
    /// Column 2 will be named &quot;Value&quot; and will have the values 0;3;6;9;12<para></para>
    /// <para></para>
    /// We need to drop a TFlxMemTable on a form, double-click it, and define the columns &quot;Number&quot;
    /// and &quot;Value&quot; .<para></para>
    /// Then drop a button, and define it's onclick event:
    /// 
    /// <code lang="delphi">
    /// procedure TForm1.Button1Click(Sender: TObject);
    /// begin
    ///   FlxMemTable1.AddRecord([0,0]);
    ///   FlxMemTable1.AddRecord([1,3]);
    ///   FlxMemTable1.AddRecord([2,6]);
    ///   FlxMemTable1.AddRecord([3,9]);
    ///   FlxMemTable1.AddRecord([4,12]);
    /// end;
    /// </code>
    /// </example>                                                                                           
    procedure AddRecord(const aValues: Array of Variant);

    /// <summary>
    /// \Returns the position of the index field in the list of fields for the table. (0 based)
    /// </summary>                                                                             
    function IndexFieldPos: integer;

    /// <summary>
    /// Finds a record given its primary key.
    /// </summary>
    /// <remarks>
    /// This value is similar to TClientDataSet.FindKey but it only accepts a single value for the key, that
    /// will be matched against the MasterField. It is used internally by TFlxMemTable in master-detail
    /// relationships.
    /// </remarks>
    /// <param name="KeyValues">Even when it is an array to keep the definition compatible with
    ///                         TClientDataSet, it must have one and only one value. This value will be
    ///                         matched against the MasterField column and if a record is found, the dataset
    ///                         will be located at that record.</param>
    /// <returns>
    /// True if the key was found in the MasterField column, false otherwise. 
    /// </returns>                                                                                          
    function FindKey(const KeyValues: array of variant): Boolean; virtual;

    { Public declarations }
  published
    /// <summary>
    /// A collection with the field definitions for the table.
    /// </summary>
    /// <remarks>
    /// Normally the easiest way to change the field definitions is just double-clicking the TFxMemTable and
    /// useing the field editor. But you can also use this property directly to create, delete or modify
    /// fields at runtime.
    /// </remarks>                                                                                          
    property Columns: TFlxDbMemColumnList read FColumns write FColumns;

    /// <summary>
    /// Master Table when using Master-Detail.
    /// </summary>
    /// <remarks>
    /// Use this together with the MasterField property to create a Master-Detail relationship with another
    /// FlxMemTable. This only makes sense in <b>normal</b> mode. In <b>virtual</b> mode you need to define
    /// master detail relationships yourself, by returning the correct record count and record values for the
    /// detail dataset depending on the position of the master.<para></para>
    ///
    /// </remarks>

    property MasterTable: TFlxMemTable read FMasterTable write SetMasterTable;
    /// <summary>
    /// Master Field for linking with a MasterTable
    /// </summary>
    /// <remarks>
    /// This is the name of the common field used to link two FlxMemTables. The field name must exist on both
    /// tables, and should be equally capitalized.<para></para>
    /// <para></para>
    /// <b>Warning</b>: When you change this property, all the data on the FlxMemTable will be deleted
    /// </remarks>
    property MasterField: string read FMasterField write SetMasterField;

    /// <summary>
    /// Specifies a column to sort the table.
    /// </summary>
    /// <remarks>
    /// While the name of this property is in plural, to keep the syntax the same as in other VCL datasets,
    /// TFlxMemTable only accepts <b>one</b> column as an index. The syntax &quot;field1;field2&quot; is not
    /// supported.
    /// </remarks>
    /// <example>
    /// To sort the dataset by the column &quot;CustomerName&quot;, you can set:
    ///
    /// <code lang="delphi">
    /// MemTable.IndexFieldNames := 'CustomerName';
    /// </code>
    ///
    /// </example>
    property IndexFieldNames: string read FIndexFieldNames write SetIndexFieldNames;

    /// <summary>
    /// Determines how new records are inserted into the table, depending on the value of the field specified
    /// in the IndexFieldNames property.
    /// </summary>
    /// <remarks>
    /// There are three possible values for this property:
    /// <xtable columnwidths="21c%">
    /// Value       \Description
    /// ----------  --------------------------------------------------------------------------------------------
    /// dupIgnore   If a record with the same value in the index field already exists, the new record will not
    ///              be inserted.
    /// dupAccept   This is the normal mode. You can insert as many records as you want with the same value for
    ///              the index.
    /// dupError    An exception will be raised if you try to insert a duplicated record.
    /// </xtable>
    ///
    /// </remarks>
    property Duplicates: TDuplicates read FDuplicates write SetDuplicates default DupAccept;

    /// <summary>
    /// This property is not implemented.
    /// </summary>
    property CaseInsensitive: boolean read FCaseInsensitive write FCaseInsensitive default true;

    //Events
    /// <summary>
    /// Occurs when the FlxMemTable component needs to know how many records it has.
    /// </summary>
    /// <remarks>
    /// If you assign this event and the OnGetData one, you enter <b>Virtual</b> mode.<para></para>
    /// In virtual mode, you need to tell the dataset the number of records your virtual table has with this
    /// event.<para></para>
    /// <para></para>
    /// Look at the example in OnGetData.<para></para>
    /// <para></para>
    /// <b>Note:</b> This event might be called more than once, so if counting records is a slow operation
    /// (for example if your data structure is a linked list), it is advisable to cache this result. 
    /// </remarks>                                                                                          
    property OnVirtualRecordCount: TOnVirtualRecordCountEvent read FOnVirtualRecordCount write FOnVirtualRecordCount;

    /// <summary>
    /// Occurs when FlxMemTable.First is called.
    /// </summary>                              
    property OnFirst: TNotifyEvent read FOnFirst write FOnFirst;

    /// <summary>
    /// Occurs when FlxMemTable.Next is called.
    /// </summary>                             
    property OnNext: TNotifyEvent read FOnNext write FOnNext;

    /// <summary>
    /// Occurs when FlxMemTable.Last is called.
    /// </summary>                             
    property OnLast: TNotifyEvent read FOnLast write FOnLast;

    /// <summary>
    /// Occurs each time the dataset needs a value in virtual mode.
    /// </summary>
    /// <remarks>
    /// In <b>Virtual</b> mode, FlxMemTable will call this event every time it needs a value, as it will not
    /// keep any value in memory.<para></para>
    /// Assign this event along with OnVirtualRecordCount to enter virtual mode.
    /// </remarks>
    /// <example>
    /// This example will create a <b>virtual</b> FlxMemTable containing 2 columns and 5 records.<para></para>
    /// Column 1 will be named &quot;Number&quot; and will have the values 0;1;2;3;4<para></para>
    /// Column 2 will be named &quot;Value&quot; and will have the values 0;3;6;9;12<para></para>
    /// <para></para>
    /// We need to drop a TFlxMemTable on a form, double-click it, define the columns &quot;Number&quot; and
    /// &quot;Value&quot; and set the events:
    /// 
    /// <code lang="delphi">
    /// procedure TForm1.FlxMemTable1VirtualRecordCount(Sender: TObject;
    /// var RecordCount: Integer);
    /// begin
    ///   RecordCount:=5;
    /// end;
    /// 
    /// procedure TForm1.FlxMemTable1GetData(Sender: TObject;
    /// const FieldName: String; const RecordPos: Integer; var Value: Variant);
    /// begin
    ///   if FieldName='Number' then Value:=RecordPos else
    ///   if FieldName='Value' then Value:=RecordPos*3;
    /// end;
    /// </code>
    /// </example>                                                                                            
    property OnGetData: TFlxMemTableOnGetDataEvent read FOnGetData write FOnGetData;

  //IXlsDataSet
  public
    /// <summary>
    /// \Returns a field definition for position index.
    /// </summary>
    /// <remarks>
    /// This method return a reference counted interface, so there is no need to dispose it.
    /// </remarks>
    /// <param name="index">Index of the field in the list (1 based).</param>
    function GetFields(index: integer): IXlsField;

    /// <summary>
    /// This method returns the same value as the Active property.
    /// </summary>                                                
    function GetActive: boolean;

    /// <summary>
    /// Opens the dataset.
    /// </summary>
    /// <remarks>
    /// This is equivalent to Setting the Active property to true.
    /// </remarks>                                                
    procedure Open;

    /// <summary>
    /// Call Close to set the Active property of a dataset to false. When Active is false, the dataset is
    /// closed; it cannot read or write data.
    /// </summary>
    /// <remarks>
    /// \Note that closing the dataset does not clear the data. You can close it and then open it, and the
    /// data will still be there.<para></para>
    /// If you want to clear the data, call Clear before closing.<para></para>
    ///
    /// </remarks>
    procedure Close;

    /// <summary>
    /// Specifies whether or not a dataset is open.
    /// </summary>
    /// <remarks>
    /// \Note that closing the dataset does not clear the data. You can close it and then open it, and the
    /// data will still be there.<para></para>
    /// If you want to clear the data, call Clear before closing.<para></para>
    /// <para></para>
    /// 
    /// </remarks>                                                                                        
    property Active: boolean read GetActive;

    /// <summary>
    /// \Returns the number of records on the dataset.
    /// </summary>
    /// <remarks>
    /// In normal mode, it will return the count of records in memory. In virtual mode, it returns the value
    /// of the OnVirtualRecordCount event. 
    /// </remarks>                                                                                          
    function RecordCount: integer;

    /// <summary>
    /// Moves to the first record in the dataset.
    /// </summary>
    /// <remarks>
    /// Each time this method is called, an OnFirst event will be fired.
    /// </remarks>
    procedure First;

    /// <summary>
    /// Moves to the next record in the dataset.
    /// </summary>
    /// <remarks>
    /// Each time this method is called, an OnNext event will be fired.
    /// </remarks>
    procedure Next;

    /// <summary>
    /// Moves to the last record in the dataset.
    /// </summary>
    /// <remarks>
    /// Each time this method is called, an OnLast event will be fired.
    /// </remarks>
    procedure Last;

    /// <summary>
    /// Indicates whether a dataset is positioned at the last record.
    /// </summary>
    /// <remarks>
    /// Test Eof (end-of-file) to determine if the active record in a dataset is the last record. If Eof is
    /// true, the current record is unequivocally the last row in the dataset. Eof is true when an
    /// application:<para></para>
    /// <para></para>
    /// Opens an empty dataset.<para></para>
    /// Calls a dataset's Last method. (Unless it is a unidirectional dataset)<para></para>
    /// Call a dataset's Next method, and the method fails because the current record is already the last row
    /// in the dataset.<para></para>
    /// <para></para>
    /// Eof is false in all other cases.
    /// </remarks>
    function Eof: boolean;

    /// <summary>
    /// \Returns the name of the dataset.
    /// </summary>
    /// <remarks>
    /// This function returns the same as the Name property.
    /// </remarks>
    function DsName: string;

    /// <summary>
    /// Finds a field based on its name.
    /// </summary>
    /// <remarks>
    /// Call FieldByName to retrieve field information for a field given its name. FieldByName returns the
    /// TField component that represents the specified field. If the specified field does not exist,
    /// FieldByName raises an exception.
    /// </remarks>
    /// <param name="Name">Name of an existing field for which we want to get information.</param>
    function FieldByName(const Name: string): IXlsField;

    /// <summary>
    /// Indicates the number of columns of the dataset.
    /// </summary>
    function FieldCount: integer;

    /// <summary>
    /// Indicates the number of visible columns in the dataset.
    /// </summary>
    /// <remarks>
    /// As TFlxMemTable does not support hidden fields, the value returned by this property is the same as
    /// FieldCount.
    /// </remarks>
    function FieldVisibleCount: integer;
  end;


implementation
{$INCLUDE TFlxRecordListImp.inc}
{$INCLUDE TFlxMasterListImp.inc}

{ TFlxDbMemColumnList }


function TFlxDbMemColumnList.Find(const Name: string;
  out Index: integer): boolean;
var
  i: integer;
begin
  Index := -1;
  for i := 0 to Count - 1 do
    if AnsiCompareText(TFlxDbMemColumn(Items[i]).Name, Name) = 0 then
    begin
      Result:=true;
      Index:=i;
      exit;
    end;
  Result:=false;
end;

procedure TFlxDbMemColumnList.Update(Item: TCollectionItem);
begin
  inherited;
  (GetOwner as TFlxMemTable).Clear;
end;

{ TFlxDbMemColumn }

function TFlxDbMemColumn.GetDisplayName: string;
begin
  Result:=FName;
end;

procedure TFlxDbMemColumn.SetDisplayName(const Value: string);
var
  i: integer;
begin
  if (Collection as TFlxDbMemColumnList).Find(Value, i) and (i<>Index) then
    raise Exception.CreateFmt(ErrDupField, [Value]);
  FName:=Value;
end;

{ TFlxMemTable }

procedure TFlxMemTable.AddRecord(const aValues: Array of Variant);
var
  Index: integer;
  Mv: variant;
begin
  if Length(aValues)<>Columns.Count then raise Exception.Create(ErrInvalidColumnCount);

  if not FColumns.Find(FMasterField, Index) then Mv:=unassigned else
    Mv:=aValues[Index];

  FData.AddRecord(Mv, TFlxRecord.Create(Self, aValues));
end;

procedure TFlxMemTable.Clear;
begin
  FData.Clear;
  FVirtualPos:=0;
end;

procedure TFlxMemTable.Close;
begin
  FActive:=false;
end;

constructor TFlxMemTable.Create(AOwner: TComponent);
begin
  inherited;
  FColumns:= TFlxDbMemColumnList.Create(Self, TFlxDbMemColumn);
  FData:=TFlxMasterList.Create(Self);
  FActive:=true;
  FVirtualPos:=0;
  FDuplicates:=dupAccept;
  FCaseInsensitive:=true;
end;

destructor TFlxMemTable.Destroy;
begin
  FreeAndNil(FData);
  FreeAndNil(FColumns);
  inherited;
end;

function TFlxMemTable.DsName: string;
begin
  Result:=Name;
end;

function TFlxMemTable.Eof: boolean;
begin
  if Assigned(FOnGetData) then Result:=FVirtualPos>=GetVirtualRecordCount else
    Result:=FData.Position[MastValue]>=FData.RecordCount[MastValue];
end;

function TFlxMemTable.FieldByName(const Name: string): IXlsField;
var
  Index: integer;
begin
  if not FColumns.Find(Name, Index) then raise Exception.CreateFmt(ErrFieldNotFound, [Name]);
  Result:=TFlxMemTableField.Create(Self, Index);
end;

function TFlxMemTable.FieldCount: integer;
begin
  Result:=FColumns.Count;
end;

function TFlxMemTable.FieldVisibleCount: integer;
begin
  Result:=FColumns.Count;
end;

function TFlxMemTable.FindKey(const KeyValues: array of variant): Boolean;
var
  Index, Index2: integer;
begin
  Result:=False;
  if Length(KeyValues)<>1 then raise Exception.Create(ErrInvalidColumnCount); //only 1-filed key are supported. We use an array for notation compatibility with ClientDataSet
  if FData.Find(MastValue, Index) then
    if FData.Items[Index].Find(KeyValues[0], Index2) then
    begin
      FData.Items[Index].FPosition:=Index2;
      Result:=true;
    end;
end;

procedure TFlxMemTable.First;
begin
  FVirtualPos:=0;
  FData.Position[MastValue]:=0;
  if Assigned(FOnFirst) then FOnFirst(Self);
end;

function TFlxMemTable.GetActive: boolean;
begin
  Result:=FActive;
end;

function TFlxMemTable.GetFields(index: integer): IXlsField;
begin
  Result:=TFlxMemTableField.Create(Self, Index);
end;

function TFlxMemTable.GetVirtualRecordCount: integer;
begin
  Result:=0;
  if Assigned(FOnVirtualRecordCount) then FOnVirtualRecordCount(Self, Result);
end;

function TFlxMemTable.IndexFieldPos: integer;
begin
  if not FColumns.Find(IndexFieldNames, Result) then raise Exception.CreateFmt(ErrFieldNotFound, [IndexFieldNames]);
end;

procedure TFlxMemTable.Last;
begin
  if FData.RecordCount[MastValue]>0 then FData.Position[MastValue]:=FData.RecordCount[MastValue]-1 else
  FData.Position[MastValue]:=0;

  if GetVirtualRecordCount>0 then FVirtualPos:=GetVirtualRecordCount-1 else FVirtualPos:=0;

  if Assigned(FOnLast) then FOnLast(Self);
end;

function TFlxMemTable.MastValue: variant;
begin
  if FMasterTable=nil then Result:=unassigned else
    Result:=FMasterTable.FieldByName(FMasterField).Value;
end;

procedure TFlxMemTable.Next;
begin
  FData.Position[MastValue]:=FData.Position[MastValue]+1;
  inc(FVirtualPos);
  if Assigned(FOnNext) then FOnNext(Self);
end;

procedure TFlxMemTable.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = FMasterTable then FMasterTable:= nil;
  end;
end;

procedure TFlxMemTable.Open;
begin
  FActive:=True;
  FVirtualPos:=0;
end;

function TFlxMemTable.RecordCount: integer;
begin
  if Assigned(FOnGetData) then Result:=GetVirtualRecordCount else
    Result:=FData.RecordCount[MastValue];
end;

procedure TFlxMemTable.SetDuplicates(const Value: TDuplicates);
begin
  FDuplicates := Value;
end;

procedure TFlxMemTable.SetIndexFieldNames(const Value: string);
begin
  if Value<>FIndexFieldNames then
  begin
    FIndexFieldNames := Value;
    FData.SortData;
  end;
end;

procedure TFlxMemTable.SetMasterField(const Value: string);
var
  Index: integer;
begin
  if Value<>'' then if not FColumns.Find(Value, Index) then raise Exception.CreateFmt(ErrFieldNotFound, [Value]);
  if FMasterField<>Value then Clear;
  FMasterField := Value;
end;

procedure TFlxMemTable.SetMasterTable(const Value: TFlxMemTable);
var
  IDs: IXlsDataSet;
  IValue:IUnknown;
begin
  if Value<>nil then
  begin
    IValue:=Value;
    if not Supports(IValue, IXlsDataSet, IDs) then raise Exception.CreateFmt(ErrComponentIsNotXlsDataSet, [Value.Name]);
  end;
  FMasterTable := Value;
end;

{ TFlxRecordList }

procedure TFlxRecordList.Clear;
begin
  inherited;
  FPosition:=0;
end;

constructor TFlxRecordList.Create(const aMemTable: TFlxMemTable; const aListName: UTF16String);
begin
  inherited Create;
  FListName:=aListName;
  MemTable:=aMemTable;
end;

function TFlxRecordList.GetValue(FieldIndex: integer): variant;
begin
  if (Position<0)or (Position>=Count) then Result:=Unassigned else
    Result:=Items[Position].Value[FieldIndex];
end;

{ TFlxMemTableField }

function TFlxMemTableField.AsFloat: extended;
begin
  Result:=Value;
end;

constructor TFlxMemTableField.Create(const aMemTable: TFlxMemTable; const aFieldIndex: integer);
begin
  inherited Create;
  FMemTable:=aMemTable;
  FieldIndex:=aFieldIndex;
end;

function TFlxMemTableField.DataSet: IXlsDataSet;
begin
  Result:=FMemTable;
end;

function TFlxMemTableField.DisplayName: string;
begin
  Result:=(FMemTable.Columns.Items[FieldIndex] as TFlxDbMemColumn).Name;
end;

function TFlxMemTableField.IsTDateTimeField: boolean;
begin
  Result:=VarType(Value) = VarDate;
end;

function TFlxMemTableField.IsTMemoField: boolean;
begin
  Result:=false;
end;

function TFlxMemTableField.Value: variant;
var
  aValue: variant;
begin
  if Assigned(FMemTable.FOnGetData) then
  begin
    aValue:=unassigned;
    FMemTable.FOnGetData(FMemTable, DisplayName, FMemTable.FVirtualPos, aValue);
    Result:=aValue;
  end else
    Result:=FMemTable.FData.Value[FMemTable.MastValue, FieldIndex];
end;

function TFlxMemTableField.Visible: boolean;
begin
  Result:=true;
end;

{ TFlxRecord }

constructor TFlxRecord.Create(const aParentList: TFlxMemTable; const aValue: Array of Variant);
var
  i: integer;
begin
  inherited Create;
  ParentList:=aParentList;
  SetLength(Value, Length(aValue));
  for i:=0 to Length(aValue)-1 do Value[i]:=aValue[i];
end;

{ TFlxMasterList }

procedure TFlxMasterList.AddRecord(const MasterCat: UTF16String;
  const Rec: TFlxRecord);
var
  Index, Index2: integer;
begin
  if not Find(MasterCat, Index) then Insert(Index, TFlxRecordList.Create(MemTable, MasterCat));
  if MemTable.IndexFieldNames='' then
    Items[Index].Add(Rec)
  else
    if not (Items[Index].Find(Rec.Value[MemTable.IndexFieldPos], Index2)) or (MemTable.Duplicates=DupAccept) then
      Items[Index].Insert(Index2, Rec)
    else
    begin
      Rec.Free;
      if MemTable.Duplicates=DupError then raise Exception.Create(ErrDupField); //Lacking a better message...
      //DupIgnore does nothing... but we have to free the record
    end;
end;

constructor TFlxMasterList.Create(const aMemTable: TFlxMemTable);
begin
  inherited Create;
  MemTable:=aMemTable;
end;

function TFlxMasterList.GetPosition(MasterCat: UTF16String): integer;
var
  Index: integer;
begin
  if not Find(MasterCat, Index) then Result:=0 else Result:= Items[Index].Position;
end;

function TFlxMasterList.GetRecordCount(MasterCat: UTF16String): integer;
var
  Index: integer;
begin
  if not Find(MasterCat, Index) then Result:=0 else Result:= Items[Index].Count;
end;

function TFlxMasterList.GetValue(MasterCat: UTF16String;
  FieldIndex: integer): variant;
var
  Index: integer;
begin
  if not Find(MasterCat, Index) then Result:=unassigned else Result:= Items[Index].Value[FieldIndex];
end;

procedure TFlxMasterList.SetPosition(MasterCat: UTF16String;
  const Value: integer);
var
  Index: integer;
begin
  if Find(MasterCat, Index) then Items[Index].FPosition:=Value;
end;

procedure TFlxMasterList.SortData;
var
  i: integer;
begin
  for i:=0 to Count-1 do Items[i].Sort;
end;

end.
