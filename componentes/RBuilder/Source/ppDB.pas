{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppDB;

interface

{$I ppIfDef.pas}

uses
  {$IFDEF Delphi6}Variants,{$ENDIF}
  Windows,
  SysUtils,
  TypInfo,
  Classes,
  Graphics,
//  Dialogs,
  Forms,
  ppTypes,
  ppRTTI,
  ppDsIntf,
  ppComm,
  ppCache,
  ppRelatv,
  ppMultiCast,
  ppCollectionBase;

type

  TppMasterFieldLink = class;
  TppDataPipelineList = class;
  TppLinkRangeIndex = class;
  TppLinkRange = class;
  TppField = class;
  TppFieldCollection = class;


  TppLinkedDataInfoRec = record
    FMasterRecordNo: Longint;
    FDetailRecordNo: Longint;
    FCompareLinkedData: Integer;
    FDetailDataBuf: Variant;
    FMasterDataBuf: Variant;
  end;


  {@TppDataPipeline

    Ancestor from which all data pipelines descend. The standard data
    pipelines provided with ReportBuilder are:

            - TppBDEPipeline
            - TppCustomDataPipeline

    The TppDataPipeline class defines the data-access API for
    ReportBuilder.  TppBDEPipeline is a pass-thru to standard Delphi data-
    access functionality.  Currently the Report, DetailBand and all data-
    aware components use the TppDataPipeline class.  In order for these
    components to access data, a descendant of TppDataPipeline is assigned
    to their DataPipeline property.  The TppBDEPipeline, TppTextPipeline 
    and TppJITPipeline are currently the only registered components for
    this purpose. In the future we expect to create an ODBC pass-thru 
    DataPipeline which will allow ReportBuilder to access myriad sources of
    data without the BDE.  We've provided TppDataPipeline as an ancestor
    from which you can create native access for proprietary data formats.

    Formerly, data-aware ReportBuilder components used the TFieldDataLink
    class to implement the DataField property.  The interface to this
    object has been incorporated into TppDataPipeline. This approach was
    taken because the report engine operates on a demand-pull basis rather
    than the two-way model found in Delphi. Also, our goal was not to copy
    Delphi's data access implementation but to create an API class which
    developers could use to quickly and easily implement access to non-BDE
    databases.  Collecting all of the data-access requirements of
    ReportBuilder into one component was an attempt to reduce the effort
    required to accomplish this task.

    Because the TppDataPipeline is designed for use with the ReportBuilder
    report engine, it has properties which describe how records should be
    traversed when the engine calls the First, Next, Prior or Last methods.
    The most important of these properties are RangeBegin and RangeEnd.  
    These are enumerated types which describe the starting and ending
    record positions for the report. By specifying combinations of
    RangeBegin and RangeEnd you can traverse the data in many different
    ways.  If both settings are the same (i.e. RangeBegin is FirstRecord
    and RangeEnd is FirstRecord, one record is traversed.)  You can even 
    use the properties to accomplish unorthodox traversals such as last
    record to first record. (Note: Because the starting and ending records
    can be anything, the traversal direction can not always be predicted.  
    The MoveBy property expresses traversal number and direction and
    defaults to 1.  If you specify RangeBegin as rbLastRecord and RangeEnd 
    as reFirstRecord, then MoveBy will be set to -1.  In some cases you may 
    need to set the MoveBy value.  For example, let's say you wanted to
    traverse backwards ten records from the current record position and 
    then stop.  Set RangeBegin to reCurrentRecord, set RangeEnd to reCount,
    set TraversalCount to ten and set MoveBy to -1.)

    If this isn't enough, the ultimate in traversal flexibility is provided 
    by the run-time method AddBookmark.  You can create a list of bookmarks
    by calling this method and the report will traverse each record in the
    list.  This is sometimes helpful when you've given the user a multi-
    pick list and want to print only the records they have selected.

    All of these properties are implemented in the TppDataPipeline class. 
    The report engine simply calls the Open method when the report starts,
    then calls First, then calls Next until a EOF state is detected.
    Finally, when the report is destroyed, the Close method is called.
    Regardless of the actual traversal that is taking place, the engine
    makes a normal traversal. It's the data pipeline that selects the
    actual records which are traversed.

    In order to see what is required to create a fully functional
    descendant, check out the ppDB, ppDBBDE, ppDBJIT and ppTxPipe units.}

  {@TppDataPipeline.AutoCreateFields

    Defaults to True. Determines whether the TppField objects created by the
    DataPipeline will be saved.  The Field objects function much the same way
    as their TField counterparts in Delphi.  When fields are created at Delphi
    design-time (by double-clicking on the data pipeline component) then they
    can be saved by setting this property to False.  If this property is False,
    then the fields will be saved with the Form.  This method can be used to
    restrict the fields visible in the Report Designer.}

  {@TppDataPipeline.AfterClose

    This event fires when the Close method of DataPipeline is called. The timing
    of the event is after the data source has been closed.)

  {@TppDataPipeline.AfterOpen

    This event fires when the Open method of DataPipeline is called. The timing
    of the event is after the data source has been opened.)

  {@TppDataPipeline.BeforeClose

    This event fires when the Close method of the data pipeline is called. The
    timing of the event is prior to the data source being closed.}

  {@TppDataPipeline.BeforeOpen

    This event fires when the Open method of DataPipeline is called. The timing
    of the event is prior to the data source being opened.}

  {@TppDataPipeline.CurrentField

    Returns the field object last used when a call to GetFieldValue,
    GetFieldAsString, etc. has been made.}

  {@TppDataPipeline.FieldCount

    This property contains the number of fields defined for the data
    pipeline.}

  {@TppDataPipeline.Fields

    Run-time and read only.  The Fields property returns a specific field
    in the data pipeline.  Specify the field using the Index parameter,
    with the first field in the report having an Index of 0. If no object
    exists at the Index position, nil is returned.

    To determine the Index for a specific field use the IndexOfField or
    IndexOfFieldName methods.}

  {@TppDataPipeline.MasterDataPipeline

   Used to indicate when one data pipeline is subordinate to another, as in a
   master-detail relationship.  Setting this property causes the data pipeline
   to be represented within the Data Tree of the Report Designer as nested
   within the data pipeline specified in master data pipeline.

   For the DBPipeline and BDEPipeline classes this property is informational
   only and does not trigger any automatic record filtering logic

   For the JITPipeline and TextPipeline classes this property is used in
   conjunction with the MasterFieldLinks property of to trigger record
   filtering events.}

  {@TppDataPipeline.MasterFieldLinks

    When utilizing JIT or Text data pipelines in a master/detail relation,
    this component holds the field relations used to connect the pipelines.
    It is used in conjunction with the MasterDataPipeline property.

    Used when manually linking datasets or text pipelines. MasterFieldLinks is
    sometimes faster than linking standard Delphi TQuery objects. When accessing
    TQuery objects, all detail queries must include all ORDER BY fields from
    the master.}

  {@TppDataPipeline.MoveBy

    MoveBy enables you to specify the number of record positions which should
    be jumped when the report traverses data. Positive integers indicate a
    forward move and negative integers indicate a backward move.}

  {@TppDataPipeline.OnDataChange

    Fires any time the status of the dataset changes.}

  {@TppDataPipeline.OnFirst

    This event fires when the First method of DataPipeline is called.}

  {@TppDataPipeline.OnGotoBookmark

    This event is called when the report engine needs to advance to a particular location in the data.}

  {@TppDataPipeline.OnLast

    This event fires when the Last method of the data pipeline is called.}

  {@TppDataPipeline.OnMasterRecordPositionChange

    When the TextPipeline or JITPipeline is involved in a master detail
    relationship, the master data pipeline fires this event whenever its record
    position changes.

    This event is not fired for the DBPipeline or BDEPipeline.}

  {@TppDataPipeline.OnNext

    This event fires when the Next method of the data pipeline is called.}

  {@TppDataPipeline.OnPrior

    This event fires when the Prior method of DataPipeline is called.}

  {@TppDataPipeline.OnRecordPositionChange

    Fires whenever the record position changes.}

  {@TppDataPipeline.OnTraversal

    This event fires when a traversal has occured. A traversal is defined as
    the first movement to a valid record position.  Subsequent movements to the
    same record position (which are usually caused by group breaks) do not
    cause the OnTraversal event to fire again. This means that OnTraversal will
    fire ten times if ten records are traversed.}

  {@TppDataPipeline.RangeBegin

    The value of the RangeBegin property determines the record position from
    which report begins traversing data. These are the possible values:

    <Table>
    Value	                Meaning
    ----------------      ---------
    rbCurrentRecord       The report starts traversing data from the current record position.
    rbFirstRecord	        The report starts traversing data from the first record position.
    rbLastRecord	        The report starts traversing data from the last record position.
    </Table>

    Note: When RangeBegin is set rbLastRecord, MoveBy defaults to -1.}

  {@TppDataPipeline.RangeEnd

    The value of the RangeEnd property determines the record position upon
    which the report stops traversing data. These are the possible values:

    <Table>
    Value            Meaning
    ------------------------
    reCurrentRecord  The report stops traversing data at the current record position.
    reFirstRecord    The report stops traversing data at the first record position.
    reLastRecord     The report stops traversing data at the last record position.
    reCount          The report stops after traversing Count number of records.
    </Table>

    If both RangeEnd and RangeBegin have the same setting, then only one record
    is traversed.  MoveBy defaults to -1 when RangeEnd is set to a value which
    precedes RangeBegin (i.e. RangeEnd is set to reFirstRecord and RangeBegin
    is set to reLastRecord).}

  {@TppDataPipeline.RangeEndCount

    The value of the RangeEndCount property determines the number of records
    which will be traversed when RangeEnd is set to reCount.}

  {@TppDataPipeline.SkipWhenNoRecords

    This property applies only to the detail DataPipeline of a master/detail
    relationship. It indicates that the report engine should skip to the next
    record of the master DataPipeline when no records are found in the detail
    DataPipeline. The default value is True

    Setting this property to false will force the DetailBand to print once for
    the empty dataset.  All data-aware controls attached to the detail
    DataPipeline will return nulls in this case.}

  {@TppDataPipeline.Visible

    Defaults to True. Determines whether the DataPipeline can be selected
    within the Report Designer.  If you have DataPipelines which are supporting
    behind the scenes implementations but should not be visible to the user,
    then set this property to false.}

  TppDataPipeline = class(TppRelative)
    private
      FBookmarks: TList;
      FCurrentBookmark: Longint;
      FDataTraversed: Boolean;
      FDataView: TComponent;
      FDetailPipelines: TList;
      FDetailSkip: Boolean;
      FMasterFieldLinksPlaceHolder: String;
      FMasterDataPipeline: TppDataPipeline;
      FMasterDataPipelineName: String;
      FMoveBy: Integer;
      FRangeEnd: TppRangeEndType;
      FRangeEndCount: Longint;
      FRangeBegin: TppRangeBeginType;
      FSkipWhenNoRecords: Boolean;
      FState: TppDataPipelineStates;
      FTraversalCount: Longint;
      FVisible: Boolean;
      FNoLinkedData: Boolean;
      FLinkingEnabled: Boolean;
      FRecordNo: Longint;
      FRecordCount: Longint;
      FLinkedDataInfo: TppLinkedDataInfoRec;
      FLinkRangeIndex: TppLinkRangeIndex;
      FInternalTraversing: Boolean;
      FStreamedUserName: String;

      FAfterClose: TNotifyEvent;
      FAfterOpen: TNotifyEvent;
      FBeforeClose: TNotifyEvent;
      FBeforeOpen: TNotifyEvent;
      FmcFreeNotify: TppMultiCastEvent;

      FOnDataChange: TNotifyEvent;
      FOnFirst: TNotifyEvent;
      FOnGotoBookmark: TNotifyEvent;
      FOnLast: TNotifyEvent;
      FOnMasterRecordPositionChange: TNotifyEvent;
      FOnNext: TNotifyEvent;
      FOnPrior: TNotifyEvent;
      FOnRecordPositionChange: TNotifyEvent;
      FOnTraversal: TNotifyEvent;

      function  CheckDetailData: Boolean;
      procedure DetailSkipBackward;
      procedure DetailSkipForward;
      function  GetBOF: Boolean;
      function  GetDataView: TComponent;
      function  GetEOF: Boolean;
      function  GetFieldObjectForAlias(aFieldAlias: String): TppField;
      function  GetFieldValueForAlias(aFieldAlias: String): Variant;
      function  InChain(aDataPipeline: TppDataPipeline): Boolean;
      procedure InternalTraverseBy(aIncrement: Integer);
      procedure SetDataView(aDataView: TComponent);
      procedure SetMasterDataPipeline(aDataPipeline: TppDataPipeline);
      procedure SetMoveBy(aValue: Integer);
      procedure SetRangeBegin(aValue: TppRangeBeginType);
      procedure SetRangeEnd(aValue: TppRangeEndType);
      procedure SetRangeEndCount(aValue: Longint);
      procedure SetRecordNo(aRecordNo: Integer);
      procedure SetSkipWhenNoRecords(aValue: Boolean);
      procedure UpdateMoveBy;
      function  CheckLinkedBOF: Boolean;
      function  CheckLinkedEOF: Boolean;
      function GetmcFreeNotify: TppMultiCastEvent;

      {read/write private properties}
      procedure ReadMasterDataPipelineName(Reader: TReader);
      procedure WriteMasterDataPipelineName(Writer: TWriter);
      {convert old properties}
      procedure ReadOnClose(Reader: TReader);
      procedure ReadOnOpen(Reader: TReader);

    protected
      class function AppearsOnDelphiPalette: Boolean; override;

      procedure DefineProperties(Filer: TFiler); override;
      procedure ReadState(Reader: TReader); override;
      procedure SetUserName(const aUserName: TComponentName); override;

      procedure BuildDetailPipelineList(aPipelines: TList); virtual;
      function  CheckBOF: Boolean; virtual; abstract;
      function  CheckEOF: Boolean; virtual; abstract;
      procedure CloseDataSet; virtual; abstract;
      function  GetActive: Boolean; virtual; abstract;
      function GetSQL: TObject; virtual;
      procedure DoAfterClose; virtual;
      procedure DoAfterOpen; virtual;
      procedure DoBeforeClose; virtual;
      procedure DoBeforeOpen; virtual;
      procedure DoOnActiveChange;
      procedure DoOnDataChange;
      procedure DoOnGotoBookmark;
      procedure GotoFirstRecord; virtual;
      procedure GotoLastRecord; virtual;
      procedure OpenDataSet; virtual; abstract;
      function TraverseBy(aIncrement: Integer): Integer; virtual; abstract;

      {field support}
      function  GetAutoCreateFields: Boolean; virtual; abstract;
      procedure SetAutoCreateFields(aValue: Boolean); virtual; abstract;
      function  GetCurrentField: TppField; virtual; abstract;
      function  GetCreatingDefaultFields: Boolean; virtual; abstract;
      function  GetFieldCount: Integer; virtual; abstract;
      function  GetFieldForIndex(aIndex: Integer): TppField; virtual; abstract;

      {link support}
      procedure ClearLinkedDataCache;
      function  GetLinkCount: Integer; virtual; abstract;
      function  GetLinkForIndex(aIndex: Integer): TppMasterFieldLink; virtual; abstract;
      procedure InitializeLinkedDataCache;

      {detail support}
      property DetailSkip: Boolean read FDetailSkip write FDetailSkip;
      property DetailPipelines: TList read FDetailPipelines;

      {field support}
      property AutoCreateFields: Boolean read GetAutoCreateFields write SetAutoCreateFields default True;
      property CreatingDefaultFields: Boolean read GetCreatingDefaultFields;

      property MoveBy: Integer read FMoveBy write SetMoveBy default 1;
      property RangeEnd: TppRangeEndType read FRangeEnd write SetRangeEnd default reLastRecord;
      property RangeEndCount: Longint read FRangeEndCount write SetRangeEndCount default 0;
      property RangeBegin: TppRangeBeginType read FRangeBegin write SetRangeBegin default rbFirstRecord;

      {events}
      property BeforeOpen: TNotifyEvent read FBeforeOpen write FBeforeOpen;
      property AfterOpen: TNotifyEvent read FAfterOpen write FAfterOpen;
      property BeforeClose: TNotifyEvent read FBeforeClose write FBeforeClose;
      property AfterClose: TNotifyEvent read FAfterClose write FAfterClose;

      property OnDataChange: TNotifyEvent read FOnDataChange write FOnDataChange;
      property OnFirst: TNotifyEvent read FOnFirst write FOnFirst;
      property OnGotoBookmark: TNotifyEvent read FOnGotoBookmark write FOnGotoBookmark;
      property OnLast: TNotifyEvent read FOnLast write FOnLast;
      property OnMasterRecordPositionChange: TNotifyEvent read FOnMasterRecordPositionChange write FOnMasterRecordPositionChange;
      property OnNext: TNotifyEvent read FOnNext write FOnNext;
      property OnPrior: TNotifyEvent read FOnPrior write FOnPrior;
      property OnRecordPositionChange: TNotifyEvent read FOnRecordPositionChange write FOnRecordPositionChange;
      property OnTraversal: TNotifyEvent read FOnTraversal write FOnTraversal;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;
      procedure EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList); override;

      function HasParent: Boolean; override;
      procedure ResolvePipelineReferences(aPipelineList: TppDataPipelineList);

      procedure ExcludeState(aStateSet: TppDataPipelineStates);
      procedure IncludeState(aStateSet: TppDataPipelineStates);

      procedure AddBookmark(aBookmark: Longint);
      procedure ClearBookmarkList;
      procedure Close;
      procedure DoOnTraversal;
      procedure First;
      procedure FreeBookmarks;
      function FindField(aFieldName: String): Integer; virtual; abstract;
      procedure GetQualifiedFieldNames(aFieldNameList: TStrings);
      procedure Last;
      procedure Next;
      procedure Open;
      procedure Prior;
      procedure RemoveBookmark(aBookmark: Longint);
      procedure SetBookmark;
      procedure Skip;
      procedure SkipBack;
      procedure UpdateState;

      {new for 5.0}
      function  GetFieldIsNull(aFieldName: String): Boolean; virtual; abstract;

      {new for 4.0}                                                             
      procedure RecordPositionChanged; virtual;
      procedure MasterRecordPositionChanged; virtual;
      procedure StartOfMainReport(aPipelines: TList); virtual;
      procedure EndOfMainReport(aPipelines: TList); virtual;

      {3.0}
      procedure FreeBookmark(aBookmark: Longint); virtual; abstract;
      function  GetBookmark: Longint; virtual; abstract;
      function  GetDataSetName: String; virtual; abstract;
      function  GetFieldNames(aFieldNameList: TStrings): Boolean; overload; virtual; abstract;
      function  GetFieldNames(aFieldNameList: TStrings; aVisibleFieldsOnly: Boolean): Boolean; overload; virtual; abstract;
      function  GetFieldAlignment(aFieldName: String): TAlignment; virtual; abstract;
      function  GetFieldAsDouble(aFieldName: String): Double; virtual; abstract;
      function  GetFieldAsGuid(aFieldName: String): TGUID; virtual; abstract;
      function  GetFieldAsPicture(aFieldName: String): TPicture; virtual; abstract;
      function  GetFieldAsString(aFieldName: String): String; virtual; abstract;
      function  GetFieldDataType(aFieldName: String): TppDataType; virtual; abstract;
      function  GetFieldDisplayWidth(aFieldName: String): Integer; virtual; abstract;
      function  GetFieldIsCalculated(aFieldName: String): Boolean; virtual; abstract;
      function  GetFieldSize(aFieldName: String): Integer; virtual; abstract;
      function  GetFieldValue(aFieldName: String): Variant; virtual; abstract;


      procedure GotoBookmark(aBookmark: Longint); virtual;
      function CompareBookmarks(aBookmark1, aBookmark2: Integer): Integer; virtual;

      {optional section

       These search/edit/insert routines are required if you want to load and
       save Report templates to database blob fields as in the End-User demo}

      procedure Edit;  virtual;
      procedure GetFieldAsStream(aFieldName: String; aStream: TStream); virtual;
      procedure Insert; virtual;
      procedure Delete; virtual;
      function  Locate(const aFieldName: String; aKeyValue: Variant; aOptions: TppLocateOptions): Boolean; virtual;

      procedure Post; virtual;
      procedure SetFieldFromStream(aFieldName: String; aStream: TStream); virtual;
      procedure SetFieldValue(aFieldName: String; aValue: Variant); virtual;

      {end of optional section}

      {field support}
      procedure AddField(aField: TppField); virtual; abstract;
      procedure CreateDefaultFields; virtual; abstract;
      function  DefineField(aFieldName: String; aDataType: TppDataType; aFieldLength: Integer): Integer; virtual; abstract;
      procedure FreeFields; virtual; abstract;
      function  RemoveField(aField: TppField): Integer; virtual; abstract;
      function  FieldAliasForFieldName(const aFieldName: String): String; virtual; abstract;
      function  FieldNameForFieldAlias(const aFieldAlias: String): String; virtual; abstract;
      function  GetFieldAliases(aFieldAliasList: TStrings): Boolean; overload; virtual; abstract;
      function  GetFieldAliases(aFieldNameList: TStrings; aVisibleFieldsOnly: Boolean): Boolean; overload; virtual; abstract;
      function  GetFieldForAlias(const aFieldAlias: String): TppField; virtual; abstract;
      function  GetFieldForName(const aFieldName: String): TppField; virtual; abstract;
      function  IndexOfFieldName(const aFieldName: String): Integer; virtual; abstract;
      function  IndexOfField(aField: TppField): Integer; virtual; abstract;
      function  IsValidDataType(aDataType: TppDataType): Boolean; virtual; abstract;
      procedure InsertField(aPosition: Integer; aField: TppField); virtual; abstract;

      function AddLink(aMasterPipeline: TppDataPipeline; aMasterFieldAlias: String; aDetailFieldAlias: String): TppMasterFieldLink; virtual; abstract;
      function  IsLinked: Boolean; virtual; abstract;
      procedure FreeLinks; virtual; abstract;
      function  CheckLinkedData: Integer; virtual; abstract;
      function IsLastRecord: Boolean;
      procedure LocateLinkedDataFirst; virtual; abstract;
      procedure LocateLinkedDataLast; virtual; abstract;
      procedure TraverseLinkedData(aIncrement: Integer); virtual; abstract;

      property LinkRangeList: TppLinkRangeIndex read FLinkRangeIndex;

      property Active: Boolean read GetActive;
      property CurrentBookmark: Longint read FCurrentBookmark write FCurrentBookmark;
      property BOF: Boolean read GetBOF;
      property DataTraversed: Boolean read FDataTraversed write FDataTraversed;
      property DataView: TComponent read GetDataView write SetDataView;
      property EOF: Boolean read GetEOF;
      property RecordNo: Longint read FRecordNo write SetRecordNo;
      property State: TppDataPipelineStates read FState write FState;
      property SkipWhenNoRecords: Boolean read FSkipWhenNoRecords write SetSkipWhenNoRecords default True;
      property SQL: TObject read GetSQL;
      property StreamedUserName: String read FStreamedUserName;
      property TraversalCount: Longint read FTraversalCount write FTraversalCount;
      property Visible: Boolean read FVisible write FVisible default True;

      {note: this enables you to code DataPipeline['myFieldAlias'] to get a value }
      property FieldValues[Index: String]: Variant read GetFieldValueForAlias; default;
      property FieldObjects[Index: String]: TppField read GetFieldObjectForAlias;

      {field related}
      property CurrentField: TppField read GetCurrentField;
      property Fields[Index: Integer]: TppField read GetFieldForIndex;
      property FieldCount: Integer read GetFieldCount;
      property MasterDataPipeline: TppDataPipeline read FMasterDataPipeline write SetMasterDataPipeline stored False;
      property LinkCount: Integer read GetLinkCount;
      property Links[Index: Integer]: TppMasterFieldLink read GetLinkForIndex;
      property MasterFieldLinks: String read FMasterFieldLinksPlaceHolder write FMasterFieldLinksPlaceHolder;
      property mcFreeNotify: TppMultiCastEvent read GetmcFreeNotify;

  end; {class, TppDataPipeline}


  {@TppCustomDataPipeline
  
    Ancestor from which all data pipelines which can contain fields
    descend. The standard data pipelines provided with ReportBuilder are:

            - TppJITPipeline
            - TppTextPipeline}

  {@TppCustomDataPipeline.FreeFields

    Frees all of the field objects contained within the text pipeline.}

  TppCustomDataPipeline = class(TppDataPipeline)
    private
      FAbsolutePageCount: Longint;
      FAutoCreateFields: Boolean;
      FBookmarksExist: Boolean;
      FCreatingDefaultFields: Boolean;
      FCurrentField: TppField;
      FFieldsOutOfSync: Boolean;
      FLinks: TList;
      FFields: TppFieldCollection;

    protected
      function CompareLinkedData: Integer; virtual;
      procedure FieldAdded(aField: TppField); virtual;
      procedure FieldInserted(aPosition: Integer; aField: TppField); virtual;
      procedure FieldRemoved(aField: TppField); virtual;
      procedure FieldNameChanged(aField: TppField); virtual;
      procedure FieldAliasChanged(aField: TppField); virtual;

      {overriden from TppRelative}
      procedure SaveComponents(Proc: TGetChildProc); override;

      {field support}
      function  GetAutoCreateFields: Boolean; override;
      function  GetCurrentField: TppField; override;
      function  GetCreatingDefaultFields: Boolean; override;
      function  GetFieldCount: Integer; override;
      function  GetFieldForIndex(aIndex: Integer): TppField; override;
      procedure SetAutoCreateFields(aValue: Boolean); override;
      function  SetFieldName(aFieldName: String): Boolean; virtual;
      procedure SyncFields;

      {field support}
      function  GetLinkCount: Integer; override;
      function  GetLinkForIndex(aIndex: Integer): TppMasterFieldLink; override;
      property FieldsOutOfSync: Boolean read FFieldsOutOfSync;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      function  GetValidName(aComponent: TComponent): String;  override;
      procedure Loaded; override;

      {overriden from TppCommunicator}
      procedure PropertyChange; override;

      {overriden from TppRelative}
      procedure AddChild(aChild: TppRelative); override;
      procedure InsertChild(aPosition: Integer; aChild: TppRelative); override;
      function  IndexOfChild(aChild: TppRelative): Integer; override;
      function  RemoveChild(aChild: TppRelative): Integer; override;

      {overriden from TppDataPipeline}
      function GetFieldNames(aFieldNameList: TStrings): Boolean; overload; override;
      function GetFieldNames(aFieldNameList: TStrings; aVisibleFieldsOnly: Boolean): Boolean; overload; override;
      function  GetFieldAlignment(aFieldName: String): TAlignment; override;
      function  GetFieldDataType(aFieldName: String): TppDataType; override;
      function  GetFieldDisplayWidth(aFieldName: String): Integer; override;
      function  GetFieldSize(aFieldName: String): Integer; override;

      {field support}
      procedure AddField(aField: TppField); override;
      procedure CreateDefaultFields; override;
      function  DefineField(aFieldName: String; aDataType: TppDataType; aFieldLength: Integer): Integer; override;
      function  RemoveField(aField: TppField): Integer; override;
      function  FieldAliasForFieldName(const aFieldName: String): String; override;
      function  FieldNameForFieldAlias(const aFieldAlias: String): String; override;
      procedure FreeFields; override;
      function GetFieldAliases(aFieldAliasList: TStrings): Boolean; overload; override;
      function GetFieldAliases(aFieldAliasList: TStrings; aVisibleFieldsOnly: Boolean): Boolean; overload; override;
      function  GetFieldForAlias(const aFieldAlias: String): TppField; override;
      function  GetFieldForName(const aFieldName: String): TppField; override;
      function  IndexOfFieldName(const aFieldName: String): Integer; override;
      function  IndexOfField(aField: TppField): Integer; override;
      function  IsValidDataType(aDataType: TppDataType): Boolean; override;
      procedure InsertField(aPosition: Integer; aField: TppField); override;

      {link support}
      function AddLink(aMasterPipeline: TppDataPipeline; aMasterFieldAlias: String; aDetailFieldAlias: String): TppMasterFieldLink; override;
      function  IsLinked: Boolean; override;
      function  CheckLinkedData: Integer; override;
      function FindField(aFieldName: String): Integer; override;
      procedure FreeLinks; override;

      {overriden from TppDataPipeline}
      procedure MasterRecordPositionChanged; override;
      procedure LocateLinkedDataFirst; override;
      procedure LocateLinkedDataLast; override;
      procedure TraverseLinkedData(aIncrement: Integer); override;

    published
      property MasterFieldLinks stored False;
  end; {class, TppCustomDataPipeline}


  {@TppField

    Field objects are used to describe a given set of data for a data pipeline.
    They are used to describe the data to which the data pipeline is assigned.
    The FieldName property of these components can assigned to the various
    data-aware report components in order for the field's data to be supplied to
    the component. For example, if the Company FieldName is assigned to a DBText
    component, then the Company name will appear in that component when the
    report prints.}

  {@TppField.Alignment

    The Alignment property specifies how text is aligned when the field is used
    in a report. These are the possible values:

    <Table>
    Value	            Meaning
    --------------    --------
    taLeftJustify	    Align text to the left side of the control
    taCenter	        Center text horizontally in the control
    taRightJustify	  Align text to the right side of the control
    </Table>}

  {@TppField.AutoSearch

    Indicates whether or not this is an AutoSearch field. This property is used
    to indicate AutoSearch fields to DADE when the data dictionary retrieves the
    field entries.}

  {@TppField.DataPipeline

    The data pipeline to which the field object belongs.  The Field objects are
    stored in a list inside the data pipeline, and can be accessed via the
    Fields property.}

  {@TppField.DataType

    The type of data which the field represents.
    These are the possible values:

    <Table>
    Value	        Meaning
    -----------   ---------
    dtBoolean	    Data is a boolean value.
    dtDate	      Data is in date format
    dtDateTime	  Data is in datetime format
    dtInteger	    Data is an integer
    dtLongint	    Data is a long integer
    dtDouble	    Data is a double
    dtString	    Data is a string
    dtBLOB	      Data is in binary format
    dtUnknown	    Data is in unknown format
    dtMemo	      Data is in text format
    dtGraphic	    Data is in image format
    </Table>



    Note: The text pipeline supports only the following data types: dtString,
    dtInteger, dtLongint, dtDouble, dtBoolean.}

  {@TppField.DisplayWidth

    Width to be used when sizing TppDBText component created based on the
    field.}

  {@TppField.DisplayFormat

    Assign the DisplayFormat when manually creating the AutoSearch fields and
    creating a criteria with a data type of dtDate or dtDateTime.

    The DisplayFormat should indicate the format required for date search
    criteria which is appropriate for the database product you are using.
    For example, Sybase requires a date format of YYYY/MM/DD.  If you were
    trying to build a 'WHERE' clause for Sybase, you assign 'YYYY/MM/DD' as the
    DisplayFormat.}

  {@TppField.FieldAlias

    The name of the field.

    Note: This name will be displayed in the Report Designer drop-down list box,
    when a data-aware control is selected.}

  {@TppField.FieldLength

    The maximum length of the field as it exists in the text file.}

  {@TppField.FieldName

    The name of the field as defined in the database table.}


  {@TppField.FirstField

    Whether or not this is the first field which appears in the
    AutoSearchDialog.  The property is used to build a description of the
    AutoSearchField. If FirstField is True, the description starts with
    'Show all data where the...'.  If FirstField is False then the description
    begins with 'and the...'..}
    
  {@TppField.Mandatory

    Indicates whether or not this is a mandatory AutoSearch field. This property
    is used to indicate mandatory AutoSearch fields to DADE when the data
    dictionary retrieves the field entries.  Mandatory AutoSearch fields require
    the user to enter criteria for the field when the AutoSearch dialog is
    displayed.

    You can also use this property when manually creating the AutoSearch fields
    in order to require entry of the search criteria.}

  {@TppField.Position

    Position of the field in relation to the other fields in the
    DataPipeline.Fields list.}

  {@TppField.Searchable

    Whether or not the field should be displayed as a choice on the Search
    Criteria page of the Query Wizard.}

  {@TppField.SearchExpression

    Contains the search criteria value or values as entered by the user.
    If the SearchOperator is Between or InList, then this property contains
    a comma-delimited list of the values.  In order to retrieve the search
    values in a useable format, try the FilterString, SQLString or Value
    functions.}

  {@TppField.Selectable

    Whether or not the field should be displayed on the Select Fields page of
    the Query Wizard.}

  {@TppField.Sortable

    Whether or not the field should be displayed as a choice on the Sort Order
    page of the Query Wizard.}

  TppField = class(TppRelative)
    private
      FAlignment: TAlignment;
      FAutoSearch: Boolean;
      FColumnWidth: Integer;
      FDataType: TppDataType;
      FDisplayFormat: String;
      FDisplayWidth: Integer;
      FFieldAlias: String;
      FFieldLength: Integer;
      FFieldName: String;
      FFirstField: Boolean;
      FGroupOrder: Integer;
      FIsDetail: Boolean;
      FLinkable: Boolean;
      FMandatory: Boolean;
      FReportComponent: TppCommunicator;
      FReportLabel: TppCommunicator;
      FSelectable: Boolean;
      FSelectOrder: Integer;
      FSearchable: Boolean;
      FSearch: Boolean;
      FSearchExpression: String;
      FSearchOrder: Integer;
      FSelectedIndex: Integer;
      FShowAllValues: Boolean;
      FSortable: Boolean;
      FSortOrder: Integer;
      FSortOrderType: TppSortOrderType;
      FSort: Boolean;
      FSortExpression: String;
      FSortType: TppSortOrderType;
      FTableAlias: String;
      FTableName: String;
      FVisible: Boolean;

      function  GetDataPipeline: TppDataPipeline;
      function GetFieldAlias: String;
      procedure SetDataPipeline(aDataPipeline: TppDataPipeline);
      procedure SetDataType(aDataType: TppDataType);

      function  GetFieldAsDouble: Double;
      function  GetFieldAsGuid: TGUID;
      function  GetFieldAsPicture: TPicture;
      function  GetFieldAsString: String;
      function  GetFieldIsNull: Boolean;
      function  GetFieldValue: Variant;
      procedure SetFieldAlias(const Value: String);

    protected
      procedure SetFieldName(const aFieldName: String); virtual;
      procedure SetMandatory(aValue: Boolean); virtual;
      procedure SetSearchExpression(const aExpression: String); virtual;
      procedure SetShowAllValues(aValue: Boolean); virtual;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Assign(aSource: TPersistent); override;
      function  HasParent: Boolean; override;
      function EqualTo(aSource: TppField): Boolean; virtual;

      property AsDouble: Double read GetFieldAsDouble;
      property AsPicture: TPicture read GetFieldAsPicture;
      property AsString: String read GetFieldAsString;
      property AsGuid: TGUID read GetFieldAsGuid;
      property IsNull: Boolean read GetFieldIsNull;
      property DataPipeline: TppDataPipeline read GetDataPipeline write SetDataPipeline;
      property Value: Variant read GetFieldValue;

      {these properties used by the report wizard only}
      property AutoSearch: Boolean read FAutoSearch write FAutoSearch default False;
      property ColumnWidth: Integer read FColumnWidth write FColumnWidth;
      property FirstField: Boolean read FFirstField write FFirstField default False;
      property ReportComponent: TppCommunicator read FReportComponent write FReportComponent;
      property ReportLabel: TppCommunicator read FReportLabel write FReportLabel;

      {this property used by the FieldListBuilder}
      property SelectedIndex: Integer read FSelectedIndex write FSelectedIndex;

    published
      property Alignment: TAlignment read FAlignment write FAlignment default taLeftJustify;
      property FieldAlias: String read GetFieldAlias write SetFieldAlias;
      property FieldName: String read FFieldName write SetFieldName;
      property FieldLength: Integer read FFieldLength write FFieldLength;
      property IsDetail: Boolean read FIsDetail write FIsDetail default False;
      property Linkable: Boolean read FLinkable write FLinkable default True;
      property GroupOrder: Integer read FGroupOrder write FGroupOrder default -1;
      property DataType: TppDataType read FDataType write SetDataType default dtString;
      property DisplayFormat: String read FDisplayFormat write FDisplayFormat;
      property DisplayWidth: Integer read FDisplayWidth write FDisplayWidth;
      property Mandatory: Boolean read FMandatory write SetMandatory default False;
      property Position;
      property Selectable: Boolean read FSelectable write FSelectable default True;
      property SelectOrder: Integer read FSelectOrder write FSelectOrder default -1;
      property Searchable: Boolean read FSearchable write FSearchable default True;
      property Search: Boolean read FSearch write FSearch default False;
      property SearchExpression: String read FSearchExpression write SetSearchExpression;
      property SearchOrder: Integer read FSearchOrder write FSearchOrder default -1;
      property ShowAllValues: Boolean read FShowAllValues write SetShowAllValues default False;
      property Sortable: Boolean read FSortable write FSortable default True;
      property Sort: Boolean read FSort write FSort default False;
      property SortOrder: Integer read FSortOrder write FSortOrder default -1;
      property SortType: TppSortOrderType read FSortType write FSortType default soAscending;
      property SortExpression: String read FSortExpression write FSortExpression;
      property TableAlias: String read FTableAlias write FTableAlias;
      property TableName: String read FTableName write FTableName;
      property Visible: Boolean read FVisible write FVisible default True;

  end; {class, TppField}


  {TppFieldCollection}
  TppFieldCollection = class(TppIndexedCollectionBase)
  private
    FFieldAliasIndex: TppHashTable;

    function GetFieldAliasIndex: TppHashTable;
    function GetItemByFieldAlias(FieldAlias: String): TppField;
    function GetItemByFieldName(FieldName: String): TppField;
    function GetItems(Index: Integer): TppField;

  protected
    function GetKey(aObject: TObject): String; override;
    procedure RebuildIndex; override;
    property FieldAliasIndex: TppHashTable read GetFieldAliasIndex;
    
  public
    constructor Create; override;
    destructor Destroy; override;

    function Add(aField: TppField): Integer;
    function IndexOfFieldName(aFieldName: String): Integer;
    procedure Insert(aPosition: Integer; aField: TppField);
    procedure NameChanged(aField: TppField);
    procedure AliasChanged(aField: TppField);
    function Remove(aField: TppField): Integer;
    
    property ItemByFieldAlias[FieldAlias: String]: TppField read GetItemByFieldAlias;
    property ItemByFieldName[FieldName: String]: TppField read GetItemByFieldName;
    property Items[Index: Integer]: TppField read GetItems; default;

  end;


  {@TppMasterFieldLink }
  TppMasterFieldLink = class(TppRelative)
    private
      FMasterFieldName: String;
      FDetailFieldName: String;
      FDetailSortOrder: TppSortOrderType;
      FIsCaseSensitive: Boolean;
      FCollationType: TppCollationType;
      FGuidCollationType: TppGuidCollationType;
      FNullCollationType: TppNullCollationType;
    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      function  HasParent: Boolean; override;

      function GetMasterDataPipeline: TppDataPipeline;
      function GetMasterField: TppField;
      function GetDetailDataPipeline: TppDataPipeline;
      function GetDetailField: TppField;

    published
      property MasterFieldName: String read FMasterFieldName write FMasterFieldName;
      property CollationType: TppCollationType read FCollationType write FCollationType default ctANSI;
      property GuidCollationType: TppGuidCollationType read FGuidCollationType write FGuidCollationType;
      property DetailFieldName: String read FDetailFieldName write FDetailFieldName;
      property DetailSortOrder: TppSortOrderType read FDetailSortOrder write FDetailSortOrder;
      property IsCaseSensitive: Boolean read FIsCaseSensitive write FIsCaseSensitive default False;
      property NullCollationType: TppNullCollationType read FNullCollationType write FNullCollationType default ncNullsFirst;

  end; {class, TppMasterFieldLink}


 {@TppLinkRange}

  TppLinkRange = class
    private
      FBeginRecordNo: Integer;
      FEndRecordNo: Integer;

    public
      property BeginRecordNo: Integer read FBeginRecordNo write FBeginRecordNo;
      property EndRecordNo: Integer read FEndRecordNo write FEndRecordNo;

  end; {class, TppLinkRange}


  {@TppLinkRangeIndex}

  TppLinkRangeIndex = class(TList)
    private
      FMasterRecNoList: TList;

      function GetLinkRangeValue(aMasterRecNo: Integer): TppLinkRange;
      function SafeGetRangeValue(aMasterRecNo: Integer): TppLinkRange;

    public
      constructor Create; virtual;
      destructor Destroy; override;

      function AddLinkRange(aMasterRecNo: Integer): TppLinkRange;
      procedure ClearValues;

      function GetBeginRecordNo(aMasterRecNo: Integer; var aRecordNo: Integer): Boolean;
      function GetEndRecordNo(aMasterRecNo: Integer; var aRecordNo: Integer): Boolean;
      function GetPosition(aMasterRecNo: Integer): Integer;
      function CheckNoLinkedData(aMasterRecNo: Integer): Boolean;
      procedure SetBeginRecordNo(aMasterRecNo, aRecordNo: Integer);
      procedure SetEndRecordNo(aMasterRecNo, aRecordNo: Integer);
      procedure SetNoLinkedData(aMasterRecNo: Integer);

      property Values[Index: Integer]: TppLinkRange read GetLinkRangeValue;

  end; {class, TppLinkRangeIndex}


  {@TppDataPipelineList }
  TppDataPipelineList = class(TStringList)
    private
      FReport: TComponent;
      FFormDesigner: TppFormDesigner;


      procedure BuildList;

      procedure BuildListDesignTime(aDesigner: TppFormDesigner);
      procedure BuildListRunTime(aOwner: TComponent);
      procedure BuildListFromOwner(aOwner: TComponent);
      procedure BuildListFromRBDataModule;

      procedure GetDataItemsCallback(const S: String);

      function  GetPipelineForName(aName: String): TppDataPipeline;
      function GetFormDesigner: TppFormDesigner;

      procedure SetReport(aReport: TComponent);

    public
      constructor Create(aReport: TComponent); virtual;

      destructor Destroy; override;

      procedure AddDataPipeline(aDataPipeline: TComponent);
      function  GetPipeline(aIndex: Integer): TppDataPipeline;
      function  GetPipelineForComponentName(aName: String): TppDataPipeline;
      procedure Refresh;

      property Report: TComponent read FReport write SetReport;

      property Pipelines[aUserName: String]: TppDataPipeline read GetPipelineForName;

    end; {class, TppDataPipelineList}


{******************************************************************************
 *
 ** R T T I
 *
{******************************************************************************}

  {@TraTppDataPipelineRTTI }
  TraTppDataPipelineRTTI = class(TraTppRelativeRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetParams(const aMethodName: String): TraParamList; override;
      class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppDataPipelineRTTI}

  {@TraTppFieldRTTI }
  TraTppFieldRTTI = class(TraTppRelativeRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
  end; {class, TraTppFieldRTTI}


implementation

uses
  ppASField, ppClass, ppUtils;


{******************************************************************************
 *
 ** D A T A   P I P E L I N E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDataPipeline.Create }

constructor TppDataPipeline.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  EventNotifies := [ciPipelineRecordPositionChange];

  FBookmarks := nil;
  FCurrentBookmark := 0;
  FDetailPipelines := nil;
  FDetailSkip := False;
  FDataView := nil;
  FDataTraversed := False;
  FMasterFieldLinksPlaceHolder := '';
  FMoveBy := 1;
  FRangeBegin := rbFirstRecord;
  FRangeEnd := reLastRecord;
  FRangeEndCount := 0;
  FSkipWhenNoRecords := True;
  FState := [];
  FTraversalCount := 0;
  FVisible := True;
  FLinkingEnabled := False;
  FLinkedDataInfo.FDetailRecordNo := -1;
  FLinkedDataInfo.FMasterREcordNo := -1;
  FLinkedDataInfo.FDetailDataBuf := NULL;
  FLinkedDataInfo.FMasterDataBuf := NULL;
  FLinkRangeIndex := nil;
  FInternalTraversing := False;
  FStreamedUserName := '';


  FOnFirst := nil;
  FOnGotoBookmark := nil;
  FOnLast := nil;
  FOnNext := nil;
  FOnPrior := nil;
  FOnTraversal := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDataPipeline.Destroy }

destructor TppDataPipeline.Destroy;
begin

  if (FmcFreeNotify <> nil) then
    FmcFreeNotify.Notify(Self, nil);
    
  FmcFreeNotify.Free;
  FmcFreeNotify := nil;

  SetDataView(nil);
  FBookmarks.Free;
  
  FDetailPipelines.Free;
  FLinkRangeIndex.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppDataPipeline.Notify }

procedure TppDataPipeline.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (aOperation = ppopRemove) then
    begin

      if (aCommunicator = FMasterDataPipeline)  then
        begin
          FMasterDataPipeline := nil;
          FreeLinks;
        end

      else if (FDetailPipelines <> nil) and (FDetailPipelines.IndexOf(aCommunicator) >= 0) then
        FDetailPipelines.Remove(aCommunicator);       

    end;

end; {procedure, Notify}


{------------------------------------------------------------------------------}
{ TppDataPipeline.DefineProperties}

procedure TppDataPipeline.DefineProperties(Filer: TFiler);
var
  lAncestor: TppDataPipeline;

begin

  inherited DefineProperties(Filer);

  if (Filer.Ancestor is TppDataPipeline) then
    lAncestor := TppDataPipeline(Filer.Ancestor)
  else
    lAncestor := nil;

  if (lAncestor <> nil) then
    Filer.DefineProperty('MasterDataPipelineName', ReadMasterDataPipelineName, WriteMasterDataPipelineName, FMasterDataPipelineName <> lAncestor.FMasterDataPipelineName)
  else
    Filer.DefineProperty('MasterDataPipelineName', ReadMasterDataPipelineName, WriteMasterDataPipelineName, FMasterDataPipeline <> nil);

  {conversion for RB 9}
  Filer.DefineProperty('OnClose', ReadOnClose, nil, False);
  Filer.DefineProperty('OnOpen', ReadOnOpen, nil, False);

end; {procedure, DefineProperties}

{------------------------------------------------------------------------------}
{ TppDataPipeline.ReadOnClose }

procedure TppDataPipeline.ReadOnClose(Reader: TReader);
var
  lsMethodName: String;
  lMethod: TMethod;
  lPropInfo: PPropInfo;
  lbError: Boolean;
begin
  {convert version 7.0 OnClose event handlers to use AfterClose event}
  lsMethodName := Reader.ReadIdent;

  if (Reader.Root = nil) then Exit;

  lMethod.Data := Reader.Root;
  lMethod.Code := Reader.Root.MethodAddress(lsMethodName);

  if (lMethod.Code = nil) and Assigned(Reader.OnFindMethod) then
    Reader.OnFindMethod(Reader, lsMethodName, lMethod.Code, lbError);

  if (lMethod.Code <> nil) then
    begin
      lPropInfo := GetPropInfo(ClassInfo, 'AfterClose');
      SetMethodProp(Self, lPropInfo, lMethod);
    end;

end; {procedure, ReadOnClose}


{------------------------------------------------------------------------------}
{ TppDataPipeline.ReadOnOpen }

procedure TppDataPipeline.ReadOnOpen(Reader: TReader);
var
  lsMethodName: String;
  lMethod: TMethod;
  lPropInfo: PPropInfo;
  lbError: Boolean;
begin
  {convert version 7.0 OnOpen event handlers to use AfterOpen event}
  lsMethodName := Reader.ReadIdent;

  if (Reader.Root = nil) then Exit;

  lMethod.Data := Reader.Root;
  lMethod.Code := Reader.Root.MethodAddress(lsMethodName);

  if (lMethod.Code = nil) and Assigned(Reader.OnFindMethod) then
    Reader.OnFindMethod(Reader, lsMethodName, lMethod.Code, lbError);

  if (lMethod.Code <> nil) then
    begin
      lPropInfo := GetPropInfo(ClassInfo, 'AfterOpen');
      SetMethodProp(Self, lPropInfo, lMethod);
    end;

end; {procedure, ReadOnOpen}

{------------------------------------------------------------------------------}
{ TppDataPipeline.ReadMasterDataPipelineName }

procedure TppDataPipeline.ReadMasterDataPipelineName(Reader: TReader);
begin
  FMasterDataPipelineName := Reader.ReadString;

end; {procedure, ReadMasterDataPipelineName}

{------------------------------------------------------------------------------}
{ TppDataPipeline.WriteMasterDataPipelineName }

procedure TppDataPipeline.WriteMasterDataPipelineName(Writer: TWriter);
begin
  Writer.WriteString(FMasterDataPipeline.Name);

end; {procedure, WriteMasterDataPipelineName}

{------------------------------------------------------------------------------}
{ TppDataPipeline.AppearsOnDelphiPalette}

class function TppDataPipeline.AppearsOnDelphiPalette: Boolean;
begin

  {this class function enables TppRelative descendants to decide whether to use
   the TComponent fake Left, Top  properties required for non-visual components
   installed onto the Delphi component palette}
  Result := True;

end; {class function, AppearsOnDelphiPalette}

{------------------------------------------------------------------------------}
{ TppDataPipeline.ResolvePipelineReferences }

procedure TppDataPipeline.ResolvePipelineReferences(aPipelineList: TppDataPipelineList);
var
  lMasterPipeline: TppDataPipeline;
begin
  {resolve master datapipeline reference}
  if (FMasterDataPipeline = nil) and (FMasterDataPipelineName <> '') then
    begin
      lMasterPipeline := aPipelineList.GetPipelineForComponentName(FMasterDataPipelineName);
      SetMasterDataPipeline(lMasterPipeline);
    end;

end; {procedure, ResolvePipelineReferences}

{------------------------------------------------------------------------------}
{ TppDataPipeline.HasParent }

function TppDataPipeline.HasParent: Boolean;
begin
  Result := False;
end; {function, HasParent}

{------------------------------------------------------------------------------}
{ TppDataPipeline.SetUserName }

procedure TppDataPipeline.SetUserName(const aUserName: TComponentName);
begin
  inherited SetUserName(aUserName);

  if (csReading in ComponentState) or (csLoading in ComponentState) then
    begin
      if (aUserName <> UserName) then
        FStreamedUserName := aUserName;
    end;

end; {procedure, SetUserName}

{------------------------------------------------------------------------------}
{ TppDataPipeline.CheckLinkedBOF }

function TppDataPipeline.CheckLinkedBOF: Boolean;
var
  liBeginRecordNo: Integer;
begin

  if (ppdaNoRecords in FMasterDataPipeline.State) then
    Result := True
  else if (FLinkRangeIndex <> nil) and FLinkRangeIndex.GetBeginRecordNo(FMasterDataPipeline.RecordNo, liBeginRecordNo) then
    Result := CheckBOF or FNoLinkedData or (FRecordNo < liBeginRecordNo)
  else
    Result := CheckBOF or FNoLinkedData or (CheckLinkedData < 0);

end;  {function, CheckLinkedBOF}

{------------------------------------------------------------------------------}
{ TppDataPipeline.CheckLinkedEOF }

function TppDataPipeline.CheckLinkedEOF: Boolean;
var
  liEndRecordNo: Integer;
begin

  if (ppdaNoRecords in FMasterDataPipeline.State) then
    Result := True
  else if (FLinkRangeIndex <> nil) and FLinkRangeIndex.GetEndRecordNo(FMasterDataPipeline.RecordNo, liEndRecordNo) then
    Result := CheckEOF or FNoLinkedData or (FRecordNo > liEndRecordNo)
  else
    Result := CheckEOF or FNoLinkedData or (CheckLinkedData > 0)

end;  {function, CheckLinkedEOF}

{------------------------------------------------------------------------------}
{ TppDataPipeline.RecordPositionChanged }

procedure TppDataPipeline.RecordPositionChanged;
begin
  if IsLinked and not(FLinkingEnabled) then Exit;

  if Assigned(FOnRecordPositionChange) then FOnRecordPositionChange(Self);

  SendEventNotify(Self, ciPipelineRecordPositionChange, nil);

end; {procedure, RecordPositionChanged}

{------------------------------------------------------------------------------}
{ TppDataPipeline.MasterRecordPositionChanged }

procedure TppDataPipeline.MasterRecordPositionChanged;
begin

  if Assigned(FOnMasterRecordPositionChange) then FOnMasterRecordPositionChange(Self);

  SendEventNotify(Self, ciPipelineMasterRecordPositionChange, nil);

end; {procedure, MasterRecordPositionChanged}

{------------------------------------------------------------------------------}
{ TppDataPipeline.StartOfMainReport }

procedure TppDataPipeline.StartOfMainReport(aPipelines: TList);
var
  liIndex: Integer;
  lbIncludeAllRecords: Boolean;
  lPipeline: TppDataPipeline;

begin
  InitializeLinkedDataCache;

  FDataTraversed := False;
  FRecordCount := -1;

  {initialize info used for skip when no records}
  FDetailSkip := False;

  if (FDetailPipelines = nil) then
    FDetailPipelines := TList.Create
  else
    FDetailPipelines.Clear;

  BuildDetailPipelineList(aPipelines);


  lbIncludeAllRecords := False;

  for liIndex := 0 to FDetailPipelines.Count - 1 do
    begin
      lPipeline := FDetailPipelines[liIndex];

      {check whether pipelines have SkipWhenNoRecords set to True}
      if not (lPipeline.SkipWhenNoRecords) then
        lbIncludeAllRecords := True;

    end;

  {if any detail pipelines have SkipWhenNoRecords set to False, then
   clear detail pipeline list}
  if lbIncludeAllRecords then
    FDetailPipelines.Clear;

  if (FDetailPipelines.Count > 0) then
    {set flag used to indicate whether pipeline traversal should check detail pipelines}
    FDetailSkip := True
  else
    begin
      FDetailPipelines.Free;

      FDetailPipelines := nil;
    end;

end; {procedure, StartOfMainReport}

{------------------------------------------------------------------------------}
{ TppDataPipeline.BuildDetailPipelineList}

procedure TppDataPipeline.BuildDetailPipelineList(aPipelines: TList);
var
  liIndex: Integer;
  lPipeline: TppDataPipeline;

begin

  FDetailPipelines.Clear;

  for liIndex := 0 to aPipelines.Count - 1 do
    begin
      lPipeline := TppDataPipeline(aPipelines[liIndex]);

      {check for detail pipelines}
      if (lPipeline <> Self) and (lPipeline.MasterDataPipeline = Self) then
        begin
          lPipeline.AddNotify(Self);
          FDetailPipelines.Add(lPipeline);
        end;
    end;

end; {procedure, BuildDetailPipelineList}

{------------------------------------------------------------------------------}
{ TppDataPipeline.InitializeLinkedDataCache }

procedure TppDataPipeline.InitializeLinkedDataCache;
begin

  FLinkingEnabled := False;

  {initialize info used for pipeline linking}
  if IsLinked then
    begin
      {for linked detail pipes need to explicitly set the record position to the
       first record in the dataset}
      if Active then
        GotoFirstRecord;
        
      FRecordNo := 0;

      FNoLinkedData := False;
      FLinkedDataInfo.FDetailRecordNo := -1;
      FLinkedDataInfo.FMasterRecordNo := -1;
      FLinkedDataInfo.FDetailDataBuf := VarArrayCreate([0, LinkCount - 1], varVariant);
      FLinkedDataInfo.FMasterDataBuf := VarArrayCreate([0, LinkCount - 1], varVariant);
      if (FLinkRangeIndex = nil) then
        FLinkRangeIndex := TppLinkRangeIndex.Create
      else
        FLinkRangeIndex.ClearValues;

    end;

  FLinkingEnabled := True;

end;  {procedure, InitializeLinkedDataCache}

{------------------------------------------------------------------------------}
{ TppDataPipeline.ClearLinkedDataCache }

procedure TppDataPipeline.ClearLinkedDataCache;
begin

  {initialize info used for pipeline linking}
  FRecordNo := -1;
  FLinkingEnabled := False;

  if IsLinked then
    begin
      FNoLinkedData := False;
      FLinkedDataInfo.FDetailRecordNo := -1;
      FLinkedDataInfo.FMasterRecordNo := -1;
      FLinkedDataInfo.FDetailDataBuf := Null;
      FLinkedDataInfo.FMasterDataBuf := Null;
      FLinkRangeIndex.Free;
      FLinkRangeIndex := nil;
    end;

end;  {procedure, ClearLinkedDataCache}



{------------------------------------------------------------------------------}
{ TppDataPipeline.EndOfMainReport }

procedure TppDataPipeline.EndOfMainReport(aPipelines: TList);
begin


end; {procedure, EndOfMainReport}

{------------------------------------------------------------------------------}
{ TppDataPipeline.InChain }

function TppDataPipeline.InChain(aDataPipeline: TppDataPipeline): Boolean;
begin
  if (FMasterDataPipeline <> nil) then
    begin
      if (FMasterDataPipeline = aDataPipeline) then
        Result := True
      else
        Result := FMasterDataPipeline.InChain(aDataPipeline);
    end
  else
    Result := False;
end; {function, InChain}


{------------------------------------------------------------------------------}
{ TppDataPipeline.SetMasterDataPipeline }

procedure TppDataPipeline.SetMasterDataPipeline(aDataPipeline: TppDataPipeline);
begin

  if (aDataPipeline = Self) then Exit;

  if (aDataPipeline <> nil) and aDataPipeline.InChain(Self) then Exit;

  if (FMasterDataPipeline <> nil) and (FMasterDataPipeline <> aDataPipeline) then
    FMasterDataPipeline.FreeLinks;

  if (FMasterDataPipeline <> nil) then
    FMasterDataPipeline.RemoveEventNotify(Self);

  FMasterDataPipeline := aDataPipeline;

  if (FMasterDataPipeline <> nil) then
    FMasterDataPipeline.AddEventNotify(Self);

end; {procedure, SetMasterDataPipeline}

{------------------------------------------------------------------------------}
{ TppDataPipeline.EventNotify }

procedure TppDataPipeline.EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
begin

  inherited EventNotify(aCommunicator, aEventID, aParams);

  if (aCommunicator = FMasterDataPipeline) and (aEventID = ciPipelineRecordPositionChange) then
    MasterRecordPositionChanged;

end; {procedure, EventNotify}

{------------------------------------------------------------------------------}
{ TppDataPipeline.DoOnTraversal }

procedure TppDataPipeline.DoOnTraversal;
begin
  if Assigned(FOnTraversal) then FOnTraversal(Self);

  SendEventNotify(Self, ciPipelineTraversal, nil);
end; {procedure, DoOnTraversal}

{@TppDataPipeline.AddBookmark
 Adds a bookmark to the list of bookmarks which will be traversed when the
 report is printed.

 Note: when using bookmarks to traverse data, make sure to free the bookmarks by
 calling the FreeBookmarks method after the report has completed printing. If
 the report is being previewed non-modally, you will need to place the call to
 FreeBookmarks in the OnPreviewFormClose event of the report.  If the report is
 being printed non-modally, place the FreeBookmarks call in the AfterPrint event
 of the report. If the report is non-modal and the FreeBookmarks call is placed
 directly after the call to the Print method, the bookmarks will be freed before
 the report has completed traversing the data.}


procedure TppDataPipeline.AddBookmark(aBookmark: Longint);
begin
  if (FBookmarks = nil) then
    FBookmarks := TList.Create;

  FBookmarks.Add(TObject(aBookmark));

end; {procedure, AddBookmark}


{@TppDataPipeline.SetBookmark
 Adds a bookmark for the current record position to the list of bookmarks which
 will be traversed when the report is printed.}

procedure TppDataPipeline.SetBookmark;
begin
  AddBookmark(GetBookmark);
end; {procedure, SetBookmark}


{@TppDataPipeline.RemoveBookmark
 Removes a bookmark from the list of bookmarks which will be traversed when the
 report is printed.}

procedure TppDataPipeline.RemoveBookmark(aBookmark: Longint);
var
  liIndex: Integer;
begin
  if (FBookmarks = nil) then Exit;

  liIndex := FBookmarks.IndexOf(TObject(aBookmark));

  if (liIndex <> -1) then
    FBookmarks.Delete(liIndex);

  if (FBookmarks.Count = 0) then
    begin
      FBookmarks.Free;

      FBookmarks := nil;
    end;

end; {procedure, RemoveBookmark}

{------------------------------------------------------------------------------}
{ TppDataPipeline.GotoBookmark }

procedure TppDataPipeline.GotoBookmark(aBookmark: Longint);
begin
  DoOnGotoBookmark;
  
end; {procedure, GotoBookmark}

{------------------------------------------------------------------------------}
{ TppDataPipeline.CompareBookmarks }

function TppDataPipeline.CompareBookmarks(aBookmark1, aBookmark2: Integer): Integer;
begin

  if aBookmark1 = aBookmark2 then
    Result := 0
  else if aBookmark1 < aBookmark2 then
    Result := -1
  else 
    Result := 1;

end; {procedure, CompareBookmarks}

{------------------------------------------------------------------------------}
{ TppDataPipeline.DoOnGotoBookmark }

procedure TppDataPipeline.DoOnGotoBookmark;
begin
  if Assigned(FOnGotoBookmark) then FOnGotoBookmark(Self);

  SendEventNotify(Self, ciPipelineGotoBookmark, nil);

  RecordPositionChanged;

end; {procedure, DoOnGotoBookmark}


{@TppDataPipeline.FreeBookmarks
 Frees all bookmarks in the list of bookmarks which are traversed when the
 report is printed.}

procedure TppDataPipeline.FreeBookmarks;
var
  liBookmark: Integer;
  liBookmarks: Integer;
begin

  if (FBookmarks = nil) then Exit;

  {free the list of bookmarks}
  liBookmarks := FBookmarks.Count;

  for liBookmark := 0 to liBookmarks - 1 do
    FreeBookmark(Longint(FBookmarks[liBookmark]));

  ClearBookmarkList;

end; {procedure, FreeBookmarks}


{@TppDataPipeline.ClearBookmarkList
 Clears the current list of bookmarks, but does not free the bookmarks.}

procedure TppDataPipeline.ClearBookmarkList;
begin

  if (FBookmarks <> nil) then
    begin
      FBookmarks.Free;

      FBookmarks := nil;
    end;

end; {procedure, ClearBookmarkList}


{------------------------------------------------------------------------------}
{ TppDataPipeline.SetMoveBy }

procedure TppDataPipeline.SetMoveBy(aValue: Integer);
begin
  FMoveBy := aValue;
  DoOnDataChange;

end; {procedure, SetMoveBy}

{------------------------------------------------------------------------------}
{ TppDataPipeline.SetSkipWhenNoRecords }

procedure TppDataPipeline.SetSkipWhenNoRecords(aValue: Boolean);
begin
  FSkipWhenNoRecords := aValue;
  DoOnDataChange;

end; {procedure, SetSkipWhenNoRecords}

{------------------------------------------------------------------------------}
{ TppDataPipeline.SetRangeBegin }

procedure TppDataPipeline.SetRangeBegin(aValue: TppRangeBeginType);
begin

  FRangeBegin := aValue;

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  UpdateMoveBy;


end; {procedure, SetRangeBegin}

{------------------------------------------------------------------------------}
{ TppDataPipeline.SetRangeEnd }

procedure TppDataPipeline.SetRangeEnd(aValue: TppRangeEndType);
begin

  FRangeEnd := aValue;

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  UpdateMoveBy;

end; {procedure, SetRangeEnd}

{------------------------------------------------------------------------------}
{ TppDataPipeline.SetRangeEndCount }

procedure TppDataPipeline.SetRangeEndCount(aValue: Longint);
begin
  FRangeEndCount:= aValue;
  DoOnDataChange;

end; {procedure, SetRangeEndCount}

{------------------------------------------------------------------------------}
{ TppDataPipeline.SetRecordNo }

procedure TppDataPipeline.SetRecordNo(aRecordNo: Integer);
begin
  {for linked detail pipes on the last record, do nothing
     - this fixes a traversal bug when datapipeline state is restored by the engine}
  if (IsLinked) and (ppdaLastRecord in FState) then
    {nothing}
  else
    FRecordNo := aRecordNo;
end; {procedure, SetRecordNo}

{------------------------------------------------------------------------------}
{ TppDataPipeline.UpdateMoveBy }

procedure TppDataPipeline.UpdateMoveBy;
begin
  {if RangeEnd is FirstRecord, must move backward to encounter BOF, which is used
   for the ending condition}
  if (FRangeEnd = reFirstRecord) then
    FMoveBy := -1

  else if (FRangeBegin = rbLastRecord) and (FRangeEnd <> reLastRecord) then
    FMoveBy := -1

  else
    FMoveBy := 1;

  DoOnDataChange;

end; {procedure, UpdateMoveBy}

{------------------------------------------------------------------------------}
{ TppDataPipeline.IncludeState }

procedure TppDataPipeline.IncludeState(aStateSet: TppDataPipelineStates);
begin
  FState := FState + aStateSet;
end; {procedure, IncludeState}

{------------------------------------------------------------------------------}
{ TppDataPipeline.ExcludeState }

procedure TppDataPipeline.ExcludeState(aStateSet: TppDataPipelineStates);
begin
  FState := FState - aStateSet;
end; {procedure, ExcludeState}

{------------------------------------------------------------------------------}
{ TppDataPipeline.DoOnActiveChange }

procedure TppDataPipeline.DoOnActiveChange;
begin

  if (csReading in ComponentState) or (csLoading in ComponentState) or (csDestroying in ComponentState) then Exit;

  if (FreeingChildren) or (CreatingDefaultFields) then Exit;

  SendNotify(Self, ppopActiveChange);

  SendEventNotify(Self, ciPipelineActiveChange, nil);

end; {procedure, DoOnActiveChange}

{------------------------------------------------------------------------------}
{ TppDataPipeline.DoOnDataChange }

procedure TppDataPipeline.DoOnDataChange;
begin

  if (csReading in ComponentState) or (csLoading in ComponentState) or (csDestroying in ComponentState) then Exit;
  
  if (FreeingChildren) or (CreatingDefaultFields) then Exit;

  if FInternalTraversing then Exit;         

  UpdateState;

  SendNotify(Self, ppopDataChange);

  SendEventNotify(Self, ciPipelineDataChange, nil);

  if Assigned(FOnDataChange) then FOnDataChange(Self);

end; {procedure, DoOnDataChange}

{@TppDataPipeline.Open
 This method is called before the report engine begins traversing the data.}

procedure TppDataPipeline.Open;
begin

  DoBeforeOpen;

  OpenDataSet;

  UpdateState;

  DoAfterOpen;

end; {procedure, Open}

{@TppDataPipeline.DoBeforeOpen}

procedure TppDataPipeline.DoBeforeOpen;
begin

  if Assigned(FBeforeOpen) then FBeforeOpen(Self);

  SendEventNotify(Self, ciPipelineBeforeOpen, nil);

end;

{@TppDataPipeline.DoAfterOpen}

procedure TppDataPipeline.DoAfterOpen;
begin
  if Assigned(FAfterOpen) then FAfterOpen(Self);

   SendEventNotify(Self, ciPipelineAfterOpen, nil);

end;



{@TppDataPipeline.Close
 This method is called when the report engine is freed}

procedure TppDataPipeline.Close;
begin

  DoBeforeClose;

  CloseDataSet;

  FState := [];

  DoOnDataChange;

  DoAfterClose;

end; {procedure, Close}

{@TppDataPipeline.DoBeforeClose}

procedure TppDataPipeline.DoBeforeClose;
begin
  if Assigned(FBeforeClose) then FBeforeClose(Self);

  SendEventNotify(Self, ciPipelineBeforeClose, nil);
  SendEventNotify(Self, ciDataSetClose, nil);

end;

{@TppDataPipeline.DoAfterClose}

procedure TppDataPipeline.DoAfterClose;
begin
  if Assigned(FAfterClose) then FAfterClose(Self);

  SendEventNotify(Self, ciPipelineAfterClose, nil);

end;

{------------------------------------------------------------------------------}
{ TppDataPipeline.GotoFirstRecord }

procedure TppDataPipeline.GotoFirstRecord;
begin

  RecordPositionChanged;

end; {procedure, GotoFirstRecord}

{------------------------------------------------------------------------------}
{ TppDataPipeline.GotoLastRecord }

procedure TppDataPipeline.GotoLastRecord;
begin
  
  RecordPositionChanged;

end; {procedure, GotoLastRecord}

{------------------------------------------------------------------------------}
{ TppDataPipeline.InternalTraverseBy }

procedure TppDataPipeline.InternalTraverseBy(aIncrement: Integer);
var
  liMoveBy: Integer;

begin

  {optimize by setting state of InternalTraversing - do not want DoOnDataChange firing}
  FInternalTraversing := True;

  try
  
    {the following line of code is required for linked datapipelines, calling
     goto first record here will put the dataset into a BOF true, EOF false state}
    if (aIncrement = 0) and (FRecordNo = 0) then
      GotoFirstRecord;

    liMoveBy := TraverseBy(aIncrement);

    if FMoveBy >= 0 then
      begin
        {increase the RecordNo when moving forward}
        if aIncrement > 0 then
          FRecordNo := FRecordNo + Abs(liMoveBy)
        else
          FRecordNo := FRecordNo - Abs(liMoveBy);
      end
    else
      begin
        {increase the RecordNo when moving backward}
        if aIncrement > 0 then
          FRecordNo := FRecordNo - Abs(liMoveBy)
        else
          FRecordNo := FRecordNo + Abs(liMoveBy);
      end;

  finally
    FInternalTraversing := False;

    {finally, call data change}
    DoOnDataChange;

    RecordPositionChanged;

  end;

end; {procedure, InternalTraverseBy}



{@TppDataPipeline.Skip
 Moves to the next record without incrementing the TraversalCount.  The report
 engine calls skip when a data pipeline has SkipWhenNoRecord set to True and the
 detail pipeline contains no records.}

procedure TppDataPipeline.Skip;
begin

  {goto next record without incrementing traversal count}
  if (FBookmarks <> nil) and (FBookmarks.Count > 0) then
    begin
      if (FTraversalCount < FBookmarks.Count) then
        GotoBookmark(Longint(FBookmarks[FTraversalCount + 1]));
    end

  else
    begin
      if (FRangeBegin = rbCurrentRecord) and (FRangeEnd = reCurrentRecord) then
        {do nothing}
      else if IsLinked then
        TraverseLinkedData(FMoveBy)
      else
        InternalTraverseBy(FMoveBy);
    end; {if, not using bookmarklist}

  UpdateState;

end; {procedure, Skip}


{@TppDataPipeline.SkipBack
 Moves to the prior record without decrementing the TraversalCount. The report
 engine calls skipback when a data pipeline has SkipWhenNoRecord set to True,
 the detail pipeline contains no records and a group break has been encountered.
 This allows the group footer bands to print while the data is positioned on the
 proper record.}

procedure TppDataPipeline.SkipBack;
begin

  {goto next record without incrementing traversal count}
  if (FBookmarks <> nil) and (FBookmarks.Count > 0) then
    begin
      if (FTraversalCount > 0) then
        GotoBookmark(Longint(FBookmarks[FTraversalCount - 1]));
    end

  else
    begin
      if (FRangeBegin = rbCurrentRecord) and (FRangeEnd = reCurrentRecord) then
        {do nothing}
      else if IsLinked then
        TraverseLinkedData(FMoveBy * -1)
      else
        InternalTraverseBy(FMoveBy * -1);
    end; {if, not using bookmarklist}

  UpdateState;

end; {procedure, SkipBack}

{------------------------------------------------------------------------------}
{ TppDataPipeline.CheckDetailData }

function TppDataPipeline.CheckDetailData: Boolean;
var
  liIndex: Integer;
  lDataPipeline: TppDataPipeline;
begin

  if (FDetailPipelines = nil) or not(FDetailSkip) then
    Result := True
  else
    begin
      Result := False;

      {check all details, to see if any have data}
      liIndex := 0;

      while not(Result) and (liIndex < FDetailPipelines.Count) do
        begin
          lDataPipeline := TppDataPipeline(FDetailPipelines[liIndex]);

          if (ppdaNoRecords in lDataPipeline.State) or
             (lDataPipeline.IsLinked and (lDataPipeline.CheckLinkedData <> 0)) then
            Inc(liIndex)
          else
            Result := True;

        end;

    end;

end; {function, CheckDetailData}

{------------------------------------------------------------------------------}
{ TppDataPipeline.DetailSkipForward }

procedure TppDataPipeline.DetailSkipForward;
var
  lbValidDetail: Boolean;
begin

  lbValidDetail := CheckDetailData;

  while not lbValidDetail and not(EOF) do
    begin
      Skip;
      FDataTraversed := True;

      lbValidDetail := CheckDetailData;
    end;


end; {procedure, DetailSkipForward}

{------------------------------------------------------------------------------}
{ TppDataPipeline.DetailSkipBackward }

procedure TppDataPipeline.DetailSkipBackward;
var
  lbValidDetail: Boolean;
begin

  lbValidDetail := CheckDetailData;

  while not lbValidDetail and not(BOF) do
    begin
      SkipBack;
      FDataTraversed := True;

      lbValidDetail := CheckDetailData;
    end;


end; {procedure, DetailSkipBackward}


{@TppDataPipeline.First
 This method is called when the report engine begins traversing the data.}

procedure TppDataPipeline.First;
begin

  FDataTraversed := False;
  FTraversalCount := 0;

  if not IsLinked then
    FRecordNo := 0;

  if (ppdaNoRecords in FState) then Exit;

  if (FBookmarks <> nil) and (FBookmarks.Count > 0) then
    GotoBookmark(Longint(FBookmarks[0]))

  else
    case FRangeBegin of
      rbFirstRecord:
        begin
          if IsLinked then
            LocateLinkedDataFirst
          else
            GotoFirstRecord;

          DetailSkipForward;
        end;

      rbLastRecord:
        begin
          if IsLinked then
             LocateLinkedDataLast
           else
             GotoLastRecord;

           DetailSkipBackward;
        end;

      rbCurrentRecord:
        if (FCurrentBookmark > 0) then
          GotoBookmark(FCurrentBookmark);

    end; {case, RangeBegin}

  if IsLinked then
    begin

      if (ppdaNoRecords in State) then
        {nothing}
      else if not(CheckDetailData) then {there are no detail records}
        IncludeState([ppdaNoRecords])
      else
        IncludeState([ppdaFirstRecord]);

    end
  else if GetEOF then
    IncludeState([ppdaNoRecords])
  else
    begin

      UpdateState;

      if not(ppdaFirstRecord in State) then
        IncludeState([ppdaFirstRecord]);
    end;

  if Assigned(FOnFirst) then FOnFirst(Self);

  SendEventNotify(Self, ciPipelineFirst, nil);

 { RecordPositionChanged;}

end; {procedure, First}


{@TppDataPipeline.Last
 When the report engine detects and EOF condition in the DataPipeline, this
 method is called.  This allows the data-aware components of any subsequent
 bands (group footers, summary etc) to access data as the report is completing.}

procedure TppDataPipeline.Last;
begin

  if not(IsLinked) and (FRecordCount > 0) then
    FRecordNo := FRecordCount;

  if (ppdaNoRecords in FState) then Exit;

  if (FBookmarks <> nil) and (FBookmarks.Count > 0) then
    GotoBookmark(Longint(FBookmarks[FBookmarks.Count - 1]))

  else
    case FRangeEnd of
      reFirstRecord:
        begin
          if IsLinked then
            LocateLinkedDataFirst
          else
            GotoFirstRecord;

          DetailSkipForward;
        end;

      reLastRecord:
        begin
          if IsLinked then
            LocateLinkedDataLast
          else
            GotoLastRecord;

          DetailSkipBackward;
        end;

      reCurrentRecord:
        if (FCurrentBookmark > 0) then
          GotoBookmark(FCurrentBookmark);

      reCount:
        begin
          First;

          while (FTraversalCount < RangeEndCount) do
            Next;

        end;

    end; {case, RangeEnd}

  UpdateState;

  if not(ppdaLastRecord in State) then
    IncludeState([ppdaLastRecord]);

  if Assigned(FOnLast) then FOnLast(Self);

  SendEventNotify(Self, ciPipelineLast, nil);

  {RecordPositionChanged;}


end; {procedure, Last}


{@TppDataPipeline.Next
 When the detail band and any appropriate group footer bands have completed
 printing for the current record the report engine calls this method in order to
 advance to the next record.}

procedure TppDataPipeline.Next;
begin

  {goto next record}
  if (FBookmarks <> nil) and (FBookmarks.Count > 0) then
    begin
      Inc(FTraversalCount);
      Inc(FRecordNo);

      if (FTraversalCount < FBookmarks.Count) then
        GotoBookmark(Longint(FBookmarks[FTraversalCount]));
    end

  else
    begin
      if GetEOF then
       {do nothing}
      else if (FRangeBegin = rbCurrentRecord) and (FRangeEnd = reCurrentRecord) then
        {do nothing}
      else if IsLinked then
        TraverseLinkedData(FMoveBy)
      else
        InternalTraverseBy(FMoveBy);

      FDataTraversed := True;
      Inc(FTraversalCount);
    end; {if, not using bookmarklist}

  DetailSkipForward;

  UpdateState;

  if Assigned(FOnNext) then FOnNext(Self);

  SendEventNotify(Self, ciPipelineNext, nil);

  {RecordPositionChanged;}

end; {procedure, Next}


{@TppDataPipeline.Prior
 This method is called when the report engine has detected a group break.  The
 report momentarily returns to the prior record so that the data-aware
 components of the group footer band can access the appropriate data.}

procedure TppDataPipeline.Prior;
begin

  if (FBookmarks <> nil) and (FBookmarks.Count > 0) then
    begin
      if (FTraversalCount > 0) then
        begin
          {decrement the recordno used for linking - do this prior to GotoBookmark}
          Dec(FRecordNo);

          GotoBookmark(Longint(FBookmarks[FTraversalCount - 1]));

          Dec(FTraversalCount);
        end;

    end

  else
    begin
      if GetBOF then
        {do nothing}
      else if (FRangeBegin = rbCurrentRecord) and (FRangeEnd = reCurrentRecord) then
        {do nothing}
      else if IsLinked then
        TraverseLinkedData(FMoveBy * -1)
      else
        InternalTraverseBy(FMoveBy * -1);

      Dec(FTraversalCount);
    end; {if, not using bookmarklist}

  DetailSkipBackward;

  UpdateState;

  if Assigned(FOnPrior) then FOnPrior(Self);

  SendEventNotify(Self, ciPipelinePrior, nil);                  

  {RecordPositionChanged;}

end; {procedure, Prior}


{------------------------------------------------------------------------------}
{ TppDataPipeline.GetBOF }

function TppDataPipeline.GetBOF: Boolean;
var
  lBookmark: Longint;
  lbCurrent: Boolean;

begin
  Result := False;

  if (FBookmarks <> nil) then
    Result := (FBookmarks.Count = 0) or (FTraversalCount = 0)

  else if not(IsLinked) then

    case FRangeBegin of
      rbLastRecord:    Result := CheckEOF;

      rbFirstRecord:   Result := CheckBOF;

      rbCurrentRecord:
        begin
          Result := not(FDataTraversed);

          if not(FDataTraversed) and (FRangeEnd <> reCurrentRecord) and not CheckBOF then
            begin
              lBookmark := GetBookmark;

              if (FMoveBy > 0) then
                lbCurrent := CompareBookmarks(lBookmark, FCurrentBookmark) <= 0
              else
                lbCurrent := CompareBookmarks(lBookmark, FCurrentBookmark) >= 0;

              FreeBookmark(lBookmark);

              Result := lbCurrent;


            end;
        end;

    end

  else if FNoLInkedData then
    Result := True

  else
    case FRangeBegin of
      rbLastRecord:    Result := CheckLinkedEOF;

      rbFirstRecord:   Result := CheckLinkedBOF;

      rbCurrentRecord: Result := not(FDataTraversed);
    end;


end; {function, GetBOF}

{------------------------------------------------------------------------------}
{ TppDataPipeline.GetEOF }

function  TppDataPipeline.GetEOF: Boolean;
var
  lBookmark: Longint;
  lbCurrent: Boolean;
begin
  Result := False;

  if (FBookmarks <> nil) then
    Result := (FBookmarks.Count = 0) or (FTraversalCount = FBookmarks.Count)

  else if not(IsLinked) then
    case FRangeEnd of

      reLastRecord: Result := CheckEOF;

      reFirstRecord: Result := CheckBOF;

      reCurrentRecord:
        begin
          if (CheckEOF and CheckBOF) then
            Result := True
          else
            Result := FDataTraversed;

          if FDataTraversed and (FRangeBegin <> rbCurrentRecord) and not CheckEOF then
            begin
              lBookmark := GetBookmark;

              if (FMoveBy > 0) then
                lbCurrent := CompareBookmarks(lBookmark, FCurrentBookmark) > 0
              else
                lbCurrent := CompareBookmarks(lBookmark, FCurrentBookmark) < 0;

              FreeBookmark(lBookmark);

              Result := lbCurrent;


            end;
        end;

      reCount:         Result := (FTraversalCount >= FRangeEndCount) or
                                 (  ((FMoveBy > 0) and CheckEOF) or
                                    ((FMoveBy < 0) and CheckBOF) );

    end

  else if FNoLinkedData then
    Result := True

  else

    case FRangeEnd of

      reLastRecord:    Result := CheckLinkedEOF;

      reFirstRecord:   Result := CheckLinkedBOF;

      reCurrentRecord: Result := (FTraversalCount = 1);

      reCount:         Result := (FTraversalCount >= FRangeEndCount) or
                                 (  ((FMoveBy > 0) and CheckLinkedEOF) or
                                    ((FMoveBy < 0) and CheckLinkedBOF) );

    end;


  if Result and not IsLinked then
    if (FRecordCount < 0) then
      FRecordCount := FRecordNo

end; {function, GetEOF}

{------------------------------------------------------------------------------}
{ TppDataPipeline.UpdateState }

procedure TppDataPipeline.UpdateState;
var
  lbBOF: Boolean;
  lbEOF: Boolean;

begin

  FState := [];

  if (csDestroying in ComponentState) or not Active then Exit;

  lbBOF := GetBOF;
  lbEOF := GetEOF;

  if (lbBOF and lbEOF) then
    FState := [ppdaNoRecords]

  else if lbBOF then
    FState := [ppdaFirstRecord]

  else if lbEOF then
    FState := [ppdaLastRecord];

end; {procedure, UpdateState}


{------------------------------------------------------------------------------}
{ TppDataPipeline.Edit }

procedure TppDataPipeline.Edit;
begin

end; {procedure, Edit}

{------------------------------------------------------------------------------}
{ TppDataPipeline.GetFieldAsStream }

procedure TppDataPipeline.GetFieldAsStream(aFieldName: String; aStream: TStream);
begin

end;

{------------------------------------------------------------------------------}
{ TppDataPipeline.GetFieldObjectForAlias}


function TppDataPipeline.GetFieldObjectForAlias(aFieldAlias: String): TppField;
begin
  {this method required, because GetFieldForName declares a 'const' parameter,
   which is unacceptable for supporting the FieldObjects array property}
  Result := GetFieldForAlias(aFieldAlias);

  // if field not found, assume the fieldname was passed
  if (Result = nil) then
    Result := GetFieldForName(aFieldAlias);

end; {function, GetFieldObjectForAlias}

{------------------------------------------------------------------------------}
{ TppDataPipeline.GetFieldValueForAlias}

function TppDataPipeline.GetFieldValueForAlias(aFieldAlias: string): Variant;
var
  lsFieldName: String;
begin

  lsFieldName := FieldNameForFieldAlias(aFieldAlias);

  // if cannot find the field for the alias, assume the fieldname was passed
  if (lsFieldName = '') then
    lsFieldName := aFieldAlias;

  Result := GetFieldValue(lsFieldName);

  if (VarType(Result) in [varNull, varEmpty]) then
    begin
      case GetFieldDataType(lsFieldName) of
        dtString, dtChar, dtMemo:
          Result := '';

        dtDouble, dtSingle, dtExtended, dtInteger, dtLongint, dtCurrency, dtDate, dtTime, dtDateTime:
          Result := 0;

        dtBoolean:
          Result := False;
      end;
    end;

end; {function, GetFieldValueForAlias}

{------------------------------------------------------------------------------}
{ TppDataPipeline.Insert }

procedure TppDataPipeline.Insert;
begin

end;

{------------------------------------------------------------------------------}
{ TppDataPipeline.Delete }

procedure TppDataPipeline.Delete;
begin

end;

{------------------------------------------------------------------------------}
{ TppDataPipeline.Locate }

function  TppDataPipeline.Locate(const aFieldName: String; aKeyValue: Variant; aOptions: TppLocateOptions): Boolean;
begin
  Result := False;
end;

{------------------------------------------------------------------------------}
{ TppDataPipeline.Post }

procedure TppDataPipeline.Post;
begin

end;

{------------------------------------------------------------------------------}
{ TppDataPipeline.SetFieldFromStream }

procedure TppDataPipeline.SetFieldFromStream(aFieldName: String; aStream: TStream);
begin

end;

{------------------------------------------------------------------------------}
{ TppDataPipeline.SetFieldValue }

procedure TppDataPipeline.SetFieldValue(aFieldName: String; aValue: Variant);
begin

end;

{------------------------------------------------------------------------------}
{ TppDataPipeline.GetQualifiedFieldNames }

procedure TppDataPipeline.GetQualifiedFieldNames(aFieldNameList: TStrings);
var
  lList: TStringList;
  liIndex: Integer;
  lsDataSetName: String;
begin

  lList := TStringList.Create;

  lsDataSetName := GetDataSetName;

  GetFieldNames(lList);


  if (lsDataSetName <> '') then
    for liIndex := 0 to lList.Count - 1 do
      lList[liIndex] := lsDataSetName + '.' + lList[liIndex];

  aFieldNameList.AddStrings(lList);

  lList.Free;

end; {procedure, GetQualifiedFieldNames}

{------------------------------------------------------------------------------}
{ TppDataPipeline.ReadState }

procedure TppDataPipeline.ReadState(Reader: TReader);
begin

  {this is necessary to convert reports prior to 5.6}
  FMasterDataPipelineName := TppHReaderUtils.ExtractIdentPropValue(Reader, 'MasterDataPipeline');

  if (Reader.Parent is TdaDataView) then
    SetDataView(Reader.Parent);

  inherited ReadState(Reader);



end; {procedure, ReadState}

{------------------------------------------------------------------------------}
{ TppDataPipeline.GetDataView }

function TppDataPipeline.GetDataView: TComponent;
begin
  if Parent is TdaDataView then
    Result := Parent
  else
    Result := nil;
end; {function, GetDataView}

function TppDataPipeline.GetmcFreeNotify: TppMultiCastEvent;
begin
  if (FmcFreeNotify = nil) then
    FmcFreeNotify := TppMultiCastEvent.Create;
  Result := FmcFreeNotify;
end;

{------------------------------------------------------------------------------}
{ TppDataPipeline.GetSQL }

function TppDataPipeline.GetSQL: TObject;
var
  lSQL: TObject;
begin
  Result := nil;

  if (DataView <> nil) and {TraRTTI.IsValidPropName(DataView, 'SQL') and }
                           TraRTTI.GetPropValue(DataView, 'SQL', lSQL) then
    Result := lSQL;

end;

{------------------------------------------------------------------------------}
{@TppDataPipeline.IsLastRecord

  Returns True when the current record position of is the last record.}

function TppDataPipeline.IsLastRecord: Boolean;
begin

  if not(Eof) then
    Skip;

  Result := Eof;

  if not(Eof) then
    SkipBack;

end;

{------------------------------------------------------------------------------}
{ TppDataPipeline.SetDataView }

procedure TppDataPipeline.SetDataView(aDataView: TComponent);
begin
  if aDataView is TdaDataView then
    SetParent(TppRelative(aDataView));
end; {procedure, SetDataView}



{******************************************************************************
 *
 ** C U S T O M   D A T A   P I P E L I N E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.Create }

constructor TppCustomDataPipeline.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  OrderedChildren := True;

  FAbsolutePageCount := 0;
  FAutoCreateFields := True;
  FBookmarksExist := False;
  FCurrentField := nil;
  FCreatingDefaultFields := False;
  FFieldsOutOfSync := True;
  FLinks := TList.Create;
  FFields := TppFieldCollection.Create;


end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.Destroy }

destructor TppCustomDataPipeline.Destroy;
begin

  Destroying;

  FreeLinks;

  FLinks.Free;

  inherited Destroy;

  FFields.Free;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.Loaded }

procedure TppCustomDataPipeline.Loaded;
begin

  inherited Loaded;


end; {procedure, Loaded}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.PropertyChange }

procedure TppCustomDataPipeline.PropertyChange;
begin
  if (ComponentDesigner <> nil) then
    ComponentDesigner.ComponentChanged;
end; {procedure, PropertyChange}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.SaveComponents }

procedure TppCustomDataPipeline.SaveComponents(Proc: TGetChildProc);
var
  liIndex: Integer;
begin

  {write fields}
  inherited SaveComponents(Proc);

  {write master field link items}
  for liIndex := 0 to LinkCount - 1  do
    Proc(Links[liIndex]);

end; {procedure, SaveComponents}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.AddChild }

procedure TppCustomDataPipeline.AddChild(aChild: TppRelative);
var
  lChildOwner: TComponent;
begin

  {for DADE the pipeline owns the fields}
  lChildOwner := GetChildOwner;

  if (lChildOwner = nil) then
    lChildOwner := Owner;

  if (aChild.Owner <> lChildOwner) and (lChildOwner <> nil) then
    begin
      if (aChild.Owner <> nil) then
        aChild.Owner.RemoveComponent(aChild);

      aChild.ChangeOwner(lChildOwner);
    end;

  if (aChild is TppMasterFieldLink) then
    begin
      FLinks.Add(aChild);
      ClearLinkedDataCache;
    end
  else
    inherited AddChild(aChild);

  // add to internal list
  if aChild is TppField then
    FieldAdded(TppField(aChild));

  DoOnDataChange;

end; {procedure, AddChild}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.InsertChild }

procedure TppCustomDataPipeline.InsertChild(aPosition: Integer; aChild: TppRelative);
var
  lChildOwner: TComponent;
begin

  {for DADE the pipeline owns the fields}
  lChildOwner := GetChildOwner;

  if (lChildOwner = nil) then
    lChildOwner := Owner;

  if (aChild.Owner <> lChildOwner) and (lChildOwner <> nil) then
    begin
      if (aChild.Owner <> nil) then
        aChild.Owner.RemoveComponent(aChild);

      aChild.ChangeOwner(lChildOwner);
    end;

  if (aChild is TppMasterFieldLink) then
    begin
      FLinks.Insert(aPosition, aChild);
      ClearLinkedDataCache;
    end
  else
    inherited InsertChild(aPosition, aChild);

  // add to internal list
  if aChild is TppField then
    FieldInserted(aPosition, TppField(aChild));


  DoOnDataChange;

end; {procedure, InsertChild}
{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.IndexOfChild }

function TppCustomDataPipeline.IndexOfChild(aChild: TppRelative): Integer;
begin

  if (aChild is TppMasterFieldLink) then
    Result := FLinks.IndexOf(aChild)
  else
    Result := inherited IndexOfChild(aChild);

end; {procedure, IndexOfChild}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.RemoveChild }

function TppCustomDataPipeline.RemoveChild(aChild: TppRelative): Integer;
var
  liIndex: Integer;
begin

  liIndex := IndexOfChild(aChild);

  Result := liIndex;

  if (liIndex = -1) then Exit;

  if (aChild is TppMasterFieldLink) then
    begin
      FLinks.Delete(liIndex);
      ClearLinkedDataCache;
    end
  else
    Result := inherited RemoveChild(aChild);

  if (aChild is TppField) then
    FieldRemoved(TppField(aChild));

  DoOnDataChange;

end; {procedure, RemoveChild}


{@TppCustomDataPipeline.DefineField
 Creates a field object with the attributes specified in the parameters and
 returns the new object position.}

function TppCustomDataPipeline.DefineField(aFieldName: String; aDataType: TppDataType; aFieldLength: Integer): Integer;
var
  lField: TppField;
begin

  {allow descendant pipeline to determine which DataTypes are supported}
  if not IsValidDataType(aDataType) then
    raise EInvalidPropertyError.Create('DataType not supported by ' + ClassName);

  lField := TppField.Create(GetChildOwner);

  {add field to pipeline}
  lField.DataPipeline := Self;

  lField.Name := GetValidName(lField);

  {assign props}
  lField.FieldName    := aFieldName;
  lField.DataType     := aDataType;
  lField.FieldLength  := aFieldLength;
  lField.DisplayWidth := aFieldLength;

  if lField.DataType in [dtInteger, dtLongint, dtDouble] then
    lField.Alignment := taRightJustify
  else
    lField.Alignment := taLeftJustify;

  Result := IndexOfField(lField);

end; {function, DefineField}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.GetAutoCreateFields }

function TppCustomDataPipeline.GetAutoCreateFields: Boolean;
begin
  Result := FAutoCreateFields;
end; {function, GetAutoCreateFields}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.SetAutoCreateFields }

procedure TppCustomDataPipeline.SetAutoCreateFields(aValue: Boolean);
begin

  if (aValue <> FAutoCreateFields) then
    begin
      FAutoCreateFields := aValue;

      SyncFields;

      if (FAutoCreateFields) then
        CreateDefaultFields;
    end;

end; {function, SetAutoCreateFields}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.GetCreatingDefaultFields }

function TppCustomDataPipeline.GetCreatingDefaultFields: Boolean;
begin
  Result := FCreatingDefaultFields;
end; {function, GetCreatingDefaultFields}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.FreeFields }

procedure TppCustomDataPipeline.FreeFields;
begin
  FFields.Clear;
  FreeChildren;

  SyncFields;
end; {function, FreeFields}


{@TppCustomDataPipeline.AddField
 Adds the field object specified in aField to the text pipeline.}

procedure TppCustomDataPipeline.AddField(aField: TppField);
begin
  AddChild(aField);
end; {procedure, AddField}


{@TppCustomDataPipeline.InsertField
 Inserts the field object in aField at the position specified in aPosition into
 the pipeline field list. If aPosition is less than zero, the field is inserted
 at the beginning of the list. If aPosition is greater than the number of fields
 in the list, the field is inserted at the end of the list.}

procedure TppCustomDataPipeline.InsertField(aPosition: Integer; aField: TppField);
begin
  InsertChild(aPosition, aField);
end; {procedure, InsertField}


{@TppCustomDataPipeline.RemoveField
 Removes the field object specified in aField from the pipeline. Returns the
 position in the pipeline the field occupied before it was removed.}

function TppCustomDataPipeline.RemoveField(aField: TppField): Integer;
begin
  Result := RemoveChild(aField);
end; {function, RemoveField}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.GetFieldCount }

function TppCustomDataPipeline.GetFieldCount: Integer;
begin
  if FFieldsOutOfSync then
    CreateDefaultFields;

  Result := ChildCount;

end; {function, GetFieldCount}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.GetFieldForIndex }

function TppCustomDataPipeline.GetFieldForIndex(aIndex: Integer): TppField;
begin

  if FFieldsOutOfSync then
    CreateDefaultFields;

  Result := TppField(Children[aIndex]);

end; {function, GetFieldForIndex}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.GetFieldNames }

function TppCustomDataPipeline.GetFieldNames(aFieldNameList: TStrings): Boolean;
begin

  Result := GetFieldNames(aFieldNameList, False {visible fields only = false});

end; {function, GetFieldNames}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.GetFieldNames }

function TppCustomDataPipeline.GetFieldNames(aFieldNameList: TStrings; aVisibleFieldsOnly: Boolean): Boolean;
var
  liField: Integer;
  lField: TppField;
  lbValid: Boolean;
begin

  if FFieldsOutOfSync then
    CreateDefaultFields;

  aFieldNameList.Clear;

  for liField := 0 to FieldCount - 1 do
    begin
      lField := Fields[liField];

      if aVisibleFieldsOnly then
        lbValid := lField.Visible
      else
        lbValid := True;

      if lbValid then
        aFieldNameList.AddObject(lField.FieldName, lField);

    end;

  Result := (aFieldNameList.Count > 0);

end; {function, GetFieldNames}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.GetFieldAliases }

function TppCustomDataPipeline.GetFieldAliases(aFieldAliasList: TStrings): Boolean;
begin

  Result := GetFieldAliases(aFieldAliasList, False {visible fields only = false});

end; {function, GetFieldAliases}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.GetFieldAliases }

function TppCustomDataPipeline.GetFieldAliases(aFieldAliasList: TStrings; aVisibleFieldsOnly: Boolean): Boolean;
var
  liField: Integer;
  lField: TppField;
  lbValid: Boolean;
begin

  if FFieldsOutOfSync then
    CreateDefaultFields;

  aFieldAliasList.Clear;

  for liField := 0 to FieldCount - 1 do
    begin
      lField := Fields[liField];

      if aVisibleFieldsOnly then
        lbValid := lField.Visible
      else
        lbValid := True;

      if lbValid then
        aFieldAliasList.AddObject(lField.FieldAlias, lField);

    end;

  Result := (aFieldAliasList.Count > 0);
end; {function, GetFieldAliases}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.FieldAliasForFieldName }

function  TppCustomDataPipeline.FieldAliasForFieldName(const aFieldName: String): String;
var
  lField: TppField;
begin

  {do not call CreateDefaultFields here, it is already called by GetFieldForName}

  Result := aFieldName;

  if not(Active) and GetAutoCreateFields then Exit;

  lField := GetFieldForName(aFieldName);

  if (lField <> nil) then
    Result := lField.FieldAlias;

end; {function, FieldAliasForFieldName}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.FieldNameForFieldAlias }

function  TppCustomDataPipeline.FieldNameForFieldAlias(const aFieldAlias: String): String;
var
  lField: TppField;
begin

  {do not call CreateDefaultFields here, it is already called by GetFieldForAlias}

  lField := GetFieldForAlias(aFieldAlias);

  if (lField <> nil) then
    Result := lField.FieldName
  else
    Result := '';

end; {function, FieldNameForFieldAlias}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.GetCurrentField }

function TppCustomDataPipeline.GetCurrentField: TppField;
begin
  Result := FCurrentField;
end; {function, GetCurrentField}


{@TppCustomDataPipeline.GetFieldForName
 Returns the field object whose FieldName property matches the value of the
 aFieldName property. If no field object is found, nil is returned.}

function TppCustomDataPipeline.GetFieldForName(const aFieldName: String): TppField;
begin

  if FFieldsOutOfSync then
    CreateDefaultFields;

  Result  := FFields.ItemByFieldName[aFieldName];

end; {function, GetFieldForName}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.GetFieldForAlias }

function TppCustomDataPipeline.GetFieldForAlias(const aFieldAlias: String): TppField;
begin

  if FFieldsOutOfSync then
    CreateDefaultFields;

  Result  := FFields.ItemByFieldAlias[aFieldAlias];

end; {function, GetFieldForAlias}

{@TppCustomDataPipeline.IndexOfField

 Returns the position of the field object in the Fields array property of the
 text pipeline.  If the object is not found, -1 is returned.}

function TppCustomDataPipeline.IndexOfField(aField: TppField): Integer;
begin
  if FFieldsOutOfSync then
    CreateDefaultFields;

  Result := IndexOfChild(aField);

end; {procedure, IndexOfField}

{@TppCustomDataPipeline.IndexOfFieldName

 Returns the position of the field object in the Fields array property whose
 FieldName property matches the value of the aFieldName parameter. If no
 matching field object is found, -1 is returned.}

function TppCustomDataPipeline.IndexOfFieldName(const aFieldName: String): Integer;
begin

  if FFieldsOutOfSync then
    CreateDefaultFields;

  Result := FFields.IndexOfFieldName(aFieldName);

end; {function, IndexOfFieldName}


{@TppCustomDataPipeline.IsValidDataType

 Determines if the given data type is valid for the pipeline.  This is used to
 limit the data types of the TppField objects to those which the pipeline can
 handle.}

function  TppCustomDataPipeline.IsValidDataType(aDataType: TppDataType): Boolean;
begin
  {descendants can add code here to determine which DataType's to support}
  Result := True;
end; {function, IsValidDataType}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.SetFieldName }

function TppCustomDataPipeline.SetFieldName(aFieldName: String): Boolean;
begin
  if FCreatingDefaultFields then
    Result := False
  else
    begin
      FCurrentField := GetFieldForName(aFieldName);

      Result := (FCurrentField <> nil);
    end;
end; {function, SetFieldName}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.GetFieldAlignment }

function TppCustomDataPipeline.GetFieldAlignment(aFieldName: String): TAlignment;
begin

  Result := taLeftJustify;

  if SetFieldName(aFieldName) then
    Result := FCurrentField.Alignment;

end; {function, GetFieldAlignment}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.GetFieldDataType }

function TppCustomDataPipeline.GetFieldDataType(aFieldName: String): TppDataType;
begin

  Result := dtNotKnown;

  if SetFieldName(aFieldName) then
    Result := FCurrentField.DataType;

end; {function, GetFieldDataType}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.GetFieldDisplayWidth }

function  TppCustomDataPipeline.GetFieldDisplayWidth(aFieldName: String): Integer;
begin

  Result := 0;

  if SetFieldName(aFieldName) then
    Result := FCurrentField.DisplayWidth;

end; {function, GetFieldDisplayWidth}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.GetFieldAlignment }

function  TppCustomDataPipeline.GetFieldSize(aFieldName: String): Integer;
begin

  Result := 0;

  if SetFieldName(aFieldName) then
    Result := FCurrentField.FieldLength;

end; {function, GetFieldSize}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.SyncFields }

procedure TppCustomDataPipeline.SyncFields;
begin

  if (csReading in ComponentState) or (csLoading in ComponentState) or (csDestroying in ComponentState) then Exit;

  FFieldsOutOfSync := True;
  FCurrentField := nil;

end; {function, SyncFields}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.GetValidName }

function TppCustomDataPipeline.GetValidName(aComponent: TComponent): String;
var
  lsNamingPrefix: String;
begin

  lsNamingPrefix := Name + ppGetStdNamingPrefix(aComponent);

  if (Owner <> nil) then
   Result := ppGetUniqueName(Owner, lsNamingPrefix, aComponent)

  else  {run-time designing }
    Result := ppGetUniqueName(Self, lsNamingPrefix, aComponent);

end; {function, GetValidName}


{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.CreateDefaultFields }

procedure TppCustomDataPipeline.CreateDefaultFields;
var
  liField: Integer;
  liFields: Integer;
  lsFieldName: String;
  lFields: TStrings;
  lField: TppField;
  
begin

  if (FCreatingDefaultFields) then Exit;

  if not(FAutoCreateFields) then Exit;

  if not(FFieldsOutOfSync) then Exit;

  if (csReading in ComponentState) or (csLoading in ComponentState) or (csDestroying in ComponentState) then Exit;


  FCreatingDefaultFields := True;

  FreeFields;

  lFields := TStringList.Create;

  if not(GetFieldNames(lFields)) then
    begin
      FCreatingDefaultFields := False;

      lFields.Free;

      Exit;
    end;

  FFields.BeginUpdate;
  liFields := lFields.Count;

  for liField := 0 to liFields - 1 do
    begin
      lField := TppField.Create(GetChildOwner);

      lsFieldName := lFields[liField];

      {assign props}
      if (lField.Owner <> Self) then
        lField.Name := GetValidName(lField)
      else
        lField.Name := lField.GetValidName(lField);

      lField.FieldName    := lsFieldName;
      lField.FieldLength  := GetFieldSize(lsFieldName);
      lField.DisplayWidth := GetFieldDisplayWidth(lsFieldName);
      lField.DataType     := GetFieldDataType(lsFieldName);
      lField.Position     := liField;
      
      if lField.DataType in [dtInteger, dtLongint, dtDouble] then
        lField.Alignment := taRightJustify;

      {allow descendant pipeline to determine which data types are supported}
      if not(IsValidDataType(lField.DataType)) then
        raise EInvalidPropertyError.Create('DataType not supported by ' + ClassName);

      {add field to pipeline}
      lField.DataPipeline := Self;

      lField.FieldAlias   := lsFieldName;
      lField.Searchable   := not(lField.DataType in [dtNotKnown, dtMemo, dtBLOB, dtGraphic]);
      lField.Sortable     := not(lField.DataType in [dtNotKnown, dtMemo, dtBLOB, dtGraphic]);

    end;

  lFields.Free;

  FFieldsOutOfSync := False;

  FCreatingDefaultFields := False;

  FFields.EndUpdate;

  DoOnDataChange;

end; {procedure, CreateDefaultFields}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.GetLinkCount }

function TppCustomDataPipeline.GetLinkCount: Integer;
begin
  Result := FLinks.Count;
end; {function, GetLinkCount}

{------------------------------------------------------------------------------}
{@TppCustomDataPipeline.AddLink
  Adds a new MasterFieldLink to the Links[] array.}

function TppCustomDataPipeline.AddLink(aMasterPipeline: TppDataPipeline; aMasterFieldAlias, aDetailFieldAlias: String): TppMasterFieldLink;
var
  lLink: TppMasterFieldLink;
begin

  if (aMasterPipeline = nil) then
    raise EDataError.Create('TppCustomDataPipeline.AddLink: Unable to create link, MasterDataPipeline is nil');

  MasterDataPipeline := aMasterPipeline;

  if (MasterDataPipeline = nil) then
    raise EDataError.Create('TppCustomDataPipeline.AddLink: Unable to create link, MasterDataPipeline is nil');

  {create a new field link }
  lLink := TppMasterFieldLink.Create(nil);
  lLink.Name := GetValidName(lLink);
  lLink.Parent := Self;

  {assign the detail field name}
  lLink.DetailFieldName := FieldNameForFieldAlias(aDetailFieldAlias);

  {assign the master field name}
  lLink.MasterFieldName := MasterDataPipeline.FieldNameForFieldAlias(aMasterFieldAlias);

  Result := lLink;

end;

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.IsLinked }

function TppCustomDataPipeline.IsLinked: Boolean;
begin
  Result := (MasterDataPipeline <> nil) and (FLinks.Count > 0);
end; {function, IsLinked}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.GetLinkForIndex }

function TppCustomDataPipeline.GetLinkForIndex(aIndex: Integer): TppMasterFieldLink;
begin
  Result := TppMasterFieldLink(FLinks[aIndex]);
end; {function, GetLinkForIndex}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.CheckLinkedData }

function TppCustomDataPipeline.CheckLinkedData: Integer;
var
  liIndex: Integer;
  lbNewData: Boolean;
  lSaveState: TppDataPipelineStates;
begin

  Result := 0;

  if not Active or not MasterDataPipeline.Active then Exit;

  if VarIsNull(FLinkedDataInfo.FDetailDataBuf) then Exit;

  if (MasterDataPipeline.RecordNo = -1) then Exit;

  lbNewData := False;

  {get field link data values for detail}
  if (FLinkedDataInfo.FDetailRecordNo <> FRecordNo) or (FRecordNo = 0) then
    begin
      lbNewData := True;
      FLinkedDataInfo.FDetailRecordNo := FRecordNo;

      {temporarily clear the state because if ppdaNoRecords, GetFieldValue returns NULL}
      lSaveState := FState;
      FState := [];

      for liIndex := 0 to LinkCount-1 do
        FLinkedDataInfo.FDetailDataBuf[liIndex] := GetFieldValue(Links[liIndex].DetailFieldName);

    end;

  {get field link data values for master}
  {note: do not optimize for RecordNo 0, this causes a problem when master is
         being traversed last to first}
  if (FLinkedDataInfo.FMasterRecordNo <> MasterDataPipeline.RecordNo) or
      (MasterDataPipeline.RecordNo = 0) then
    begin
      lbNewData := True;
      FLinkedDataInfo.FMasterRecordNo := MasterDataPipeline.RecordNo;

      {temporarily clear the state because if ppdaNoRecords, GetFieldValue returns NULL}
      lSaveState := MasterDataPipeline.State;
      MasterDataPipeline.State := [];

      for liIndex := 0 to FLinks.Count - 1 do
        FLinkedDataInfo.FMasterDataBuf[liIndex] := MasterDataPipeline.GetFieldValue(Links[liIndex].MasterFieldName);

      MasterDataPipeline.State := lSaveState;
    end;

  if lbNewData then
    FLinkedDataInfo.FCompareLinkedData := CompareLinkedData;


  Result := FLinkedDataInfo.FCompareLinkedData;

end; {procedure, CheckLinkedData}


{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.CompareLinkedData }

function TppCustomDataPipeline.CompareLinkedData: Integer;
var
  lMasterFieldValue: Variant;
  lDetailFieldValue: Variant;
  liIndex: Integer;
  lFieldLink: TppMasterFieldLink;
  lbMasterNull: Boolean;
  lbDetailNull: Boolean;
  lDetailGuid: TGUID;
  lMasterGuid: TGUID;
begin

  Result := 0;

  if not Active or not MasterDataPipeline.Active then Exit;

  liIndex := 0;


  while (Result = 0) and (liIndex < FLinks.Count) do
    begin

      lMasterFieldValue := FLinkedDataInfo.FMasterDataBuf[liIndex];
      lDetailFieldValue := FLinkedDataInfo.FDetailDataBuf[liIndex];
      lFieldLink := GetLinkForIndex(liIndex);
      
      lbDetailNull := VarIsNull(lDetailFieldValue);
      lbMasterNull := VarIsNull(lMasterFieldValue);

      if lbMasterNull or lbDetailNull then
        begin
          if lbMasterNull and lbDetailNull then
            Result := 0

          else if not(lbMasterNull) and lbDetailNull then
            Result := -1

          else if lbMasterNull and not(lbDetailNull) then
            Result := 1;

          // adjust for collation type of NullsLast
          if lFieldLink.NullCollationType = ncNullsLast then
            Result := Result * -1;
          
        end

      else if (GetFieldDataType(Links[liIndex].DetailFieldName) = dtGUID) and (Links[liIndex].GuidCollationType in [gcMSSQLServer, gcGuid]) then
        begin
          lDetailGuid := StringToGUID(lDetailFieldValue);
          lMasterGuid := StringToGUID(lMasterFieldValue);

          if (Links[liIndex].GuidCollationType = gcMSSQLServer) then
            Result := ppCompareGuidMSSQLServer(lDetailGuid, lMasterGuid)
          else // GuidCollationType = gcGuid
            Result := ppCompareGuid(lDetailGuid, lMasterGuid);

        end
      else if (ppVariantIsString(lMasterFieldValue)) and (ppVariantIsString(lDetailFieldValue)) then
        begin
          if lFieldLink.IsCaseSensitive then
            begin
              if (lFieldLink.CollationType = ctANSI) then
                begin
                  if (VarType(lMasterFieldValue) = varOleStr) then
                    Result := WideCompareStr(WideString(lDetailFieldValue), WideString(lMasterFieldValue))
                  else
                    Result := AnsiCompareStr(String(lDetailFieldValue), String(lMasterFieldValue))
                end
              else if (lFieldLink.CollationType = ctASCII) then
                Result := CompareStr(String(lDetailFieldValue), String(lMasterFieldValue))

              else if (lFieldLink.CollationType = ctBinary) then
                Result := ppBinaryCompareString(AnsiString(lDetailFieldValue), AnsiString(lMasterFieldValue), True)

              else // CollationType = ctVariant
                Result := ppCompareVariant(lDetailFieldValue, lMasterFieldValue);
            end
          else
            begin
              if (lFieldLink.CollationType = ctANSI) then
                begin
                  if (VarType(lMasterFieldValue) = varOleStr) then
                    Result := WideCompareText(WideString(lDetailFieldValue), WideString(lMasterFieldValue))
                  else
                    Result := AnsiCompareText(String(lDetailFieldValue), String(lMasterFieldValue))
                end
              else if (lFieldLink.CollationType = ctASCII) then
                Result := CompareText(String(lDetailFieldValue), String(lMasterFieldValue))
              else if (lFieldLink.CollationType = ctBinary) then
                Result := ppBinaryCompareString(AnsiString(lDetailFieldValue), AnsiString(lMasterFieldValue), False)
              else // CollationType = ctVariant
                Result := ppCompareVariant(lDetailFieldValue, lMasterFieldValue);
            end;
        end
      else
        begin

          if (lDetailFieldValue <> lMasterFieldValue) then
            begin
              if (lDetailFieldValue > lMasterFieldValue) then
                Result := 1
              else
                Result := -1;

            end;

        end;

      if Result = 0 then
        Inc(liIndex)

      else if lFieldLink.DetailSortOrder = soDescending then
        Result := Result * -1;

    end;

end; {procedure, CompareLinkedData}

procedure TppCustomDataPipeline.FieldAdded(aField: TppField);
begin
  FFields.Add(aField);
end;

procedure TppCustomDataPipeline.FieldInserted(aPosition: Integer; aField: TppField);
begin
  FFields.Insert(aPosition, aField);
end;

procedure TppCustomDataPipeline.FieldRemoved(aField: TppField);
begin
  if csDestroying in ComponentState then Exit;
  
  FFields.Remove(aField);
end;

procedure TppCustomDataPipeline.FieldNameChanged(aField: TppField);
begin
  FFields.NameChanged(aField);
end;

procedure TppCustomDataPipeline.FieldAliasChanged(aField: TppField);
begin
  FFields.AliasChanged(aField);
end;

{------------------------------------------------------------------------------}
{ TppDataPipeline.FindField }

function TppCustomDataPipeline.FindField(aFieldName: String): Integer;
begin
  Result := IndexOfFieldName(aFieldName);

end; {function, FindField}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.MasterRecordPositionChanged }

procedure TppCustomDataPipeline.MasterRecordPositionChanged;
begin

  inherited MasterRecordPositionChanged;

  if IsLinked and Active then
    begin
      FState := [];
      FNoLinkedData := False;
      First;
    end
  else if (FMasterDataPipeline <> nil) and Active then
    UpdateState;

end; {procedure, MasterRecordPositionChanged}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.TraverseLinkedData  }

procedure TppCustomDataPipeline.TraverseLinkedData(aIncrement: Integer);
var
  liMove: Integer;

begin

  for liMove := 1 to Abs(aIncrement) do
    begin

      if (aIncrement > 0) and not GetEOF then
        begin
          InternalTraverseBy(1);
          if (FLinkRangeIndex <> nil) and GetEOF then
            if CheckEOF then
              FLinkRangeIndex.SetEndRecordNo(FMasterDataPipeline.RecordNo, FRecordNo)
            else
              FLinkRangeIndex.SetEndRecordNo(FMasterDataPipeline.RecordNo, FRecordNo-1);

        end
      else if (aIncrement < 0) and not GetBOF then
        begin
          InternalTraverseBy(-1);
          if (FLinkRangeIndex <> nil) and GetBOF then
            if CheckBOF then
              FLinkRangeIndex.SetBeginRecordNo(FMasterDataPipeline.RecordNo, FRecordNo)
            else
              FLinkRangeIndex.SetBeginRecordNo(FMasterDataPipeline.RecordNo, FRecordNo+1);
        end;

    end;

end; {function, TraverseLinkedData}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.LocateLinkedDataFirst }

procedure TppCustomDataPipeline.LocateLinkedDataFirst;
var
  liBeginRecordNo: Integer;

begin
  if not FLinkingEnabled then Exit;

  FLinkingEnabled := False;

  if (ppdaNoRecords in FMasterDataPipeline.State) then
    {do nothing}
  else if (FLinkRangeIndex <> nil) and FLinkRangeIndex.GetBeginRecordNo(FMasterDataPipeline.RecordNo, liBeginRecordNo) then
    InternalTraverseBy(liBeginRecordNo - RecordNo)

  else if (FLinkRangeIndex <> nil) and FLinkRangeIndex.CheckNoLinkedData(FMasterDataPipeline.RecordNo) then
    {do nothing}

  else
    begin

      {find first detail record related to the master}
      if CheckLinkedData < 0 then

        while not CheckEOF and (CheckLinkedData < 0) do
          InternalTraverseBy(1)

      else
        begin
          while not CheckBOF and (CheckLinkedData >= 0) do
            InternalTraverseBy(-1);

          if CheckLinkedData < 0 then
            InternalTraverseBy(1);

          {if not on a matching record, then go back to prev record}
          if (CheckLinkedData > 0) then
            InternalTraverseBy(-1);
        end;

      {update the range index}
      if (FLinkRangeIndex <> nil) then
        if (CheckLinkedData = 0) then
          FLinkRangeIndex.SetBeginRecordNo(FMasterDataPipeline.RecordNo, FRecordNo)
        else
          FLinkRangeIndex.SetNoLinkedData(FMasterDataPipeline.RecordNo);

    end;

  {update flag to indicate whether any linked records exists for the current master}
  FNoLinkedData := (CheckLinkedData <> 0) or (ppdaNoRecords in FMasterDataPipeline.State);

  {call UpdateState to set ppdaNoRecords}
  if FNoLinkedData then
    UpdateState;

  FLinkingEnabled := True;

  {this will notify detail pipelines that the master record position has changed}
  RecordPositionChanged;

end; {procedure, LocateLinkedDataFirst}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.LocateLinkedDataLast }

procedure TppCustomDataPipeline.LocateLinkedDataLast;
var
  liEndRecordNo: Integer;
begin

  FLinkingEnabled := False;

  if (ppdaNoRecords in FMasterDataPipeline.State) then
    {do nothing}

  else if (FLinkRangeIndex <> nil) and FLinkRangeIndex.GetEndRecordNo(FMasterDataPipeline.RecordNo, liEndRecordNo) then
    InternalTraverseBy(liEndRecordNo - RecordNo)

  else if (FLinkRangeIndex <> nil) and FLinkRangeIndex.CheckNoLinkedData(FMasterDataPipeline.RecordNo) then
    {do nothing}

  else
    begin

      {find last detail record related to the master}
      if (CheckLinkedData <= 0) then
        begin
          while not CheckEOF and (CheckLinkedData <= 0) do
            InternalTraverseBy(1);

          if (CheckLinkedData > 0) then
            InternalTraverseBy(-1);

          {if not on a matching record, then go back to prev record}
          if (CheckLinkedData < 0) then
            InternalTraverseBy(1);

        end
      else
        while not CheckBOF and (CheckLinkedData > 0) do
          InternalTraverseBy(-1);

      {update the range index}
      if (FLinkRangeIndex <> nil) then
        if (CheckLinkedData = 0) then
          FLinkRangeIndex.SetEndRecordNo(FMasterDataPipeline.RecordNo, FRecordNo)
        else
          FLinkRangeIndex.SetNoLinkedData(FMasterDataPipeline.RecordNo);

    end;

  {update flag to indicate whether any linked records exists for the current master}
  FNoLinkedData := (CheckLinkedData <> 0) or (ppdaNoRecords in FMasterDataPipeline.State);

  {call UpdateState to set ppdaNoRecords}
  if FNoLinkedData then
    UpdateState;

  FLinkingEnabled := True;

  {this will notify detail pipelines that the master record position has changed}
  if not FNoLinkedData then
    RecordPositionChanged;

end; {procedure, LocateLinkedDataLast}

{------------------------------------------------------------------------------}
{ TppCustomDataPipeline.FreeLinks }

procedure TppCustomDataPipeline.FreeLinks;
var
  liIndex: Integer;
begin

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  for liIndex := (FLinks.Count - 1) downto 0 do
    TObject(FLinks[liIndex]).Free;

  FLinks.Clear;

  ClearLinkedDataCache;

end; {procedure, FreeMasterFieldLinks}





{******************************************************************************
 *
 ** F I E L D
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppField.Create }

constructor TppField.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FAlignment        := taLeftJustify;
  FAutoSearch       := False;
  FColumnWidth      := 0;
  FDataType         := dtString;
  FDisplayFormat    := '';
  FDisplayWidth     := 10;
  FFieldAlias       := '';
  FFieldName        := '';
  FFieldLength      := 10;
  FGroupOrder       := -1;
  FLinkable         := True;
  FMandatory        := False;
  FReportComponent  := nil;
  FReportLabel      := nil;
  FSelectable       := True;
  FSelectOrder      := -1;
  FSearchable       := True;
  FSearch           := False;
  FSearchOrder      := -1;
  FSearchExpression := '';
  FSelectedIndex    := -1;
  FShowAllValues    := False;
  FSortable         := True;
  FSort             := False;
  FSortExpression   := '';
  FSortOrder        := -1;
  FSortOrderType    := soAscending;
  FTableAlias       := '';
  FTableName        := '';
  FVisible          := True;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppField.Destroy }

destructor TppField.Destroy;
begin

  Destroying;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppField.Assign }

procedure TppField.Assign(aSource: TPersistent);
var
  lSource: TppField;
begin

  if (aSource is TppField) then
    begin
      lSource := TppField(aSource);
      FAlignment := lSource.Alignment;
      FFieldAlias := lSource.FieldAlias;
      FFieldName := lSource.FieldName;
      FFieldLength := lSource.FieldLength;
      FIsDetail := lSource.IsDetail;
      FLinkable := lSource.Linkable;
      FGroupOrder := lSource.GroupOrder;
      FDataType := lSource.DataType;
      FDisplayFormat := lSource.DisplayFormat;
      FDisplayWidth := lSource.DisplayWidth;
      FMandatory := lSource.Mandatory;
      Position  := lSource.Position;
      FSelectable := lSource.Selectable;
      FSelectOrder := lSource.SelectOrder;
      FSearchable := lSource.Searchable;
      FSearch := lSource.Search;
      FSearchExpression := lSource.SearchExpression;
      FSearchOrder := lSource.SearchOrder;
      FShowAllValues := lSource.ShowAllValues;
      FSortable := lSource.Sortable;
      FSort := lSource.Sort;
      FSortOrder := lSource.SortOrder;
      FSortType := lSource.SortType;
      FSortExpression := lSource.SortExpression;
      FTableAlias := lSource.TableAlias;
      FTableName := lSource.TableName;
      FVisible := lSource.Visible;
    end
  else
    inherited Assign(aSource);

end; {procedure, Assign}

{------------------------------------------------------------------------------}
{ TppField.EqualTo }

function TppField.EqualTo(aSource: TppField): Boolean;

begin

  Result := (FAlignment = aSource.Alignment) and
            (FFieldAlias = aSource.FieldAlias) and
            (FFieldName = aSource.FieldName) and
            (FFieldLength = aSource.FieldLength) and
            (FIsDetail = aSource.IsDetail) and
            (FLinkable = aSource.Linkable) and
            (FGroupOrder = aSource.GroupOrder) and
            (FDataType = aSource.DataType) and
            (FDisplayFormat = aSource.DisplayFormat) and
            (FDisplayWidth = aSource.DisplayWidth) and
            (FMandatory = aSource.Mandatory) and
            (Position  = aSource.Position) and
            (FSelectable = aSource.Selectable) and
            (FSelectOrder = aSource.SelectOrder) and
            (FSearchable = aSource.Searchable) and
            (FSearch = aSource.Search) and
            (FSearchExpression = aSource.SearchExpression) and
            (FSearchOrder = aSource.SearchOrder) and
            (FShowAllValues = aSource.ShowAllValues) and
            (FSortable = aSource.Sortable) and
            (FSort = aSource.Sort) and
            (FSortOrder = aSource.SortOrder) and
            (FSortType = aSource.SortType) and
            (FSortExpression = aSource.SortExpression) and
            (FTableAlias = aSource.TableAlias) and
            (FTableName = aSource.TableName) and
            (FVisible = aSource.Visible);

end; {procedure, EqualTo}

{------------------------------------------------------------------------------}
{ TppField.HasParent }

function TppField.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}

{------------------------------------------------------------------------------}
{ TppField.GetDataPipeline }

function TppField.GetDataPipeline: TppDataPipeline;
begin
  if (Parent is TppDataPipeline) then
    Result := TppDataPipeline(Parent)
  else
    Result := nil;
end; {procedure, SetDataPipeline}

{------------------------------------------------------------------------------}
{ TppField.GetFieldAlias }

function TppField.GetFieldAlias: String;
begin
  if FFieldAlias = '' then
    SetFieldAlias(FFieldName);

  Result := FFieldAlias;

end;

{------------------------------------------------------------------------------}
{ TppField.SetDataPipeline }

procedure TppField.SetDataPipeline(aDataPipeline: TppDataPipeline);
begin
  SetParent(aDataPipeline);
end; {procedure, SetDataPipeline}

{------------------------------------------------------------------------------}
{ TppField.SetMandatory }

procedure TppField.SetMandatory(aValue: Boolean);
begin

  FMandatory := aValue;

  if (FMandatory) then
    FShowAllValues := False;

end; {procedure, SetMandatory}

{------------------------------------------------------------------------------}
{ TppField.SetShowAllValues }

procedure TppField.SetShowAllValues(aValue: Boolean);
begin

  FShowAllValues := aValue;

  if (FShowAllValues) then
    FMandatory := False;

end; {procedure, SetShowAllValues}

{------------------------------------------------------------------------------}
{ TppField.SetDataType }

procedure TppField.SetDataType(aDataType: TppDataType);
begin

  if (DataPipeline <> nil) and not DataPipeline.IsValidDataType(aDataType) then
    raise EInvalidPropertyError.Create('DataType not supported by ' + DataPipeline.ClassName);

  FDataType := aDataType;

end; {procedure, SetDataType}

{------------------------------------------------------------------------------}
{ TppField.SetFieldName }

procedure TppField.SetFieldName(const aFieldName: String);
var
  lsOldName: String;
begin

  if FFieldName = aFieldName then Exit;

  lsOldName := FFieldName;

  FFieldName:= aFieldName;

  {also set FieldAlias, if needed}
  if (lsOldName = FFieldAlias) then
    FieldAlias := aFieldName;

  if (DataPipeline <> nil) and (DataPipeline is TppCustomDataPipeline) then
    TppCustomDataPipeline(DataPipeline).FieldNameChanged(Self);

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  PropertyChange;

end; {procedure, SetFieldName}

{------------------------------------------------------------------------------}
{ TppField.SetSearchExpression }

procedure TppField.SetSearchExpression(const aExpression: String);
begin

  FSearchExpression:= aExpression;

  PropertyChange;

end; {procedure, SetSearchExpression}

{------------------------------------------------------------------------------}
{ TppField.GetFieldAsDouble }

function  TppField.GetFieldAsDouble: Double;
begin

  if DataPipeline = nil then
    Result := 0
  else
    Result := DataPipeline.GetFieldAsDouble(FFieldName);

end; {procedure, GetFieldAsDouble}

{------------------------------------------------------------------------------}
{ TppField.GetFieldAsPicture }

function TppField.GetFieldAsGuid: TGUID;
begin

  if (DataPipeline = nil) then
    Result := cNullGuid
  else
    Result := DataPipeline.GetFieldAsGuid(FFieldName);

end;

{------------------------------------------------------------------------------}
{ TppField.GetFieldAsPicture }

function  TppField.GetFieldAsPicture: TPicture;
begin

  if DataPipeline = nil then
    Result := nil
  else
    Result := DataPipeline.GetFieldAsPicture(FFieldName);

end; {procedure, GetFieldAsPicture}


{------------------------------------------------------------------------------}
{ TppField.GetFieldAsString }

function  TppField.GetFieldAsString: String;
begin

  if DataPipeline = nil then
    Result := ''
  else
    Result := DataPipeline.GetFieldAsString(FFieldName);

end; {procedure, GetFieldAsString}

{------------------------------------------------------------------------------}
{ TppField.GetFieldIsNull }

function  TppField.GetFieldIsNull: Boolean;
begin

  if DataPipeline = nil then
    Result := True
  else
    Result := DataPipeline.GetFieldIsNull(FFieldName);

end; {procedure, GetFieldIsNull}

{------------------------------------------------------------------------------}
{ TppField.GetFieldValue }

function TppField.GetFieldValue: Variant;
begin

  if DataPipeline = nil then
    Result := null
  else
    Result := DataPipeline.GetFieldValue(FFieldName);

end; {procedure, GetFieldValue}

{------------------------------------------------------------------------------}
{ TppField.SetFieldAlias }

procedure TppField.SetFieldAlias(const Value: String);
begin

  if (FFieldAlias =  Value) then Exit;

  FFieldAlias := Value;

//  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  if (DataPipeline <> nil) then
    TppCustomDataPipeline(DataPipeline).FieldAliasChanged(Self);

end;

{******************************************************************************
 *
 ** F I E L D  L I N K
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppMasterFieldLink.Create }

constructor TppMasterFieldLink.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FMasterFieldName := '';
  FDetailFieldName := '';
  FDetailSortOrder := soAscending;
  FIsCaseSensitive := False;
  FCollationType   := ctANSI;
  FGuidCollationType := gcString;
  FNullCollationType := ncNullsFirst;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppMasterFieldLink.Destroy }

destructor TppMasterFieldLink.Destroy;
begin

  {TMO - this is already handled by Relative and with a SetParent(nil) call which
   in turn calls RemoveChild.}

  {if FDetailDataPipeline <> nil then
    FDetailDataPipeline.RemoveMasterFieldLink(Self);}

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppMasterFieldLink.HasParent }

function TppMasterFieldLink.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}

{------------------------------------------------------------------------------}
{ TppMasterFieldLink.GetMasterDataPipeline }

function TppMasterFieldLink.GetMasterDataPipeline: TppDataPipeline;
begin

  if (Parent <> nil) then
    Result := TppDataPipeline(Parent).MasterDataPipeline
  else
    Result := nil;

end; {function, GetMasterDataPipeline}

{------------------------------------------------------------------------------}
{ TppMasterFieldLink.GetMasterField }

function TppMasterFieldLink.GetMasterField: TppField;
var
  lMasterDataPipeline: TppDataPipeline;
begin

  lMasterDataPipeline := GetMasterDataPipeline;

  if (lMasterDataPipeline <> nil) then
    Result := lMasterDataPipeline.GetFieldForName(FMasterFieldName)
  else
    Result := nil;

end; {function, GetMasterField}

{------------------------------------------------------------------------------}
{ TppMasterFieldLink.GetDetailDataPipeline }

function TppMasterFieldLink.GetDetailDataPipeline: TppDataPipeline;
begin

  if (Parent <> nil) then
    Result := TppDataPipeline(Parent)
  else
    Result := nil;

end; {function, GetDetailDataPipeline}

{------------------------------------------------------------------------------}
{ TppMasterFieldLink.GetDetailField }

function TppMasterFieldLink.GetDetailField: TppField;
var
  lDetailDataPipeline: TppDataPipeline;
begin

  lDetailDataPipeline := GetDetailDataPipeline;

  if (lDetailDataPipeline <> nil) then
    Result := lDetailDataPipeline.GetFieldForName(FDetailFieldName)
  else
    Result := nil;

end; {function, GetDetailField}

{******************************************************************************
 *
 ** L I N K   R A N G E   I N D E X
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppLinkRangeIndex.Create }

constructor TppLinkRangeIndex.Create;
begin
  inherited Create;

  {MasterRecNoList is used to store the MasterRecNo's and index into the RangeList}
  FMasterRecNoList := TList.Create;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppLinkRangeIndex.Destroy }

destructor TppLinkRangeIndex.Destroy;
begin

  {call ClearValues to free all object in the list}
  ClearValues;

  FMasterRecNoList.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppLinkRangeIndex.ClearValues }

procedure TppLinkRangeIndex.ClearValues;
var
  liIndex: Integer;
begin

  {free each object in the list}
  for liIndex := 0 to Count-1 do
    TObject(Items[liIndex]).Free;

  Clear;

  FMasterRecNoList.Clear;
  
end; {function, Clear}

{------------------------------------------------------------------------------}
{ TppLinkRangeIndex.GetPosition}

function TppLinkRangeIndex.GetPosition(aMasterRecNo: Integer): Integer;
begin
  {search the MasterRecNoList and use the index to retrieve the link range item}
  Result := FMasterRecNoList.IndexOf(Pointer(aMasterRecNo));

end; {function, GetPosition}

{------------------------------------------------------------------------------}
{ TppLinkRangeIndex.AddLinkRange }

function TppLinkRangeIndex.AddLinkRange(aMasterRecNo: Integer): TppLinkRange;
var
  lLinkRange: TppLinkRange;
begin

  {create a new LinkRange object}
  lLinkRange := TppLinkRange.Create;
  lLinkRange.BeginRecordNo  := -1;
  lLinkRange.EndRecordNo    := -1;

  {add Object to the list}
  Add(Pointer(lLinkRange));

  {add MasterRecNo to the MasterRecNoList that is used as an index}
  FMasterRecNoList.Add(Pointer(aMasterRecNo));

  Result := lLinkRange;

end; {function, AddLinkRange}

{------------------------------------------------------------------------------}
{ TppLinkRangeIndex.SafeGetRangeValue }

function TppLinkRangeIndex.SafeGetRangeValue(aMasterRecNo: Integer): TppLinkRange;
var
  liListIndex: Integer;
begin

  {search the MasterRecNoList and use the index to retrieve the link range item}
  liListIndex := GetPosition(aMasterRecNo);

  {return a link range item, add a new item, if needed}
  if liListIndex >= 0 then
    Result := TppLinkRange(Items[liListIndex])
  else
    Result := AddLinkRange(aMasterRecNo);

end; {function, SafeGetRangeValue}


{------------------------------------------------------------------------------}
{ TppLinkRangeIndex.GetLinkRangeValue }

function TppLinkRangeIndex.GetLinkRangeValue(aMasterRecNo: Integer): TppLinkRange;
var
  liListIndex: Integer;
begin

  {search the MasterRecNoList and use the index to retrieve the link range item}
  liListIndex := GetPosition(aMasterRecNo);

  if liListIndex >= 0 then
    Result := TppLinkRange(Items[liListIndex])
  else
    Result := nil;

end; {function, GetLinkRangeValue}

{------------------------------------------------------------------------------}
{ TppLinkRangeIndex.GetBeginRecordNo }

function TppLinkRangeIndex.GetBeginRecordNo(aMasterRecNo: Integer; var aRecordNo: Integer): Boolean;
var
  lLinkeRange: TppLinkRange;

begin

  lLinkeRange := GetLinkRangeValue(aMasterRecNo);

  {check whether there is a valid entry}
  Result := (lLinkeRange <> nil) and  (lLinkeRange.BeginRecordNo >= 0);

  if Result then
    aRecordNo := lLinkeRange.BeginRecordNo;

end; {function, GetBeginRecordNo}

{------------------------------------------------------------------------------}
{ TppLinkRangeIndex.GetEndRecordNo }

function TppLinkRangeIndex.GetEndRecordNo(aMasterRecNo: Integer; var aRecordNo: Integer): Boolean;
var
  lLinkeRange: TppLinkRange;

begin

  lLinkeRange := GetLinkRangeValue(aMasterRecNo);

  {check whether there is a valid entry}
  Result := (lLinkeRange <> nil) and (lLinkeRange.EndRecordNo >= 0);

  if Result then
    aRecordNo := lLinkeRange.EndRecordNo;

end; {function, GetEndRecordNo}

{------------------------------------------------------------------------------}
{ TppLinkRangeIndex.SetBeginRecordNo }

procedure TppLinkRangeIndex.SetBeginRecordNo(aMasterRecNo, aRecordNo: Integer);
var
  lLinkeRange: TppLinkRange;

begin
  {call SafeGetRangeValue which can allocate a new entry if needed}
  lLinkeRange := SafeGetRangeValue(aMasterRecNo);

  if (lLinkeRange <> nil) and (aMasterRecNo >= 0) then
    lLinkeRange.BeginRecordNo := aRecordNo;

end; {procedure, SetBeginRecordNo}

{------------------------------------------------------------------------------}
{ TppLinkRangeIndex.SetEndRecordNo }

procedure TppLinkRangeIndex.SetEndRecordNo(aMasterRecNo, aRecordNo: Integer);
var
  lLinkeRange: TppLinkRange;

begin
  {call SafeGetRangeValue which can allocate a new entry if needed}
  lLinkeRange := SafeGetRangeValue(aMasterRecNo);

  if (lLinkeRange <> nil) and (aMasterRecNo >= 0) then
    lLinkeRange.EndRecordNo := aRecordNo;

end; {procedure, SetEndRecordNo}

{------------------------------------------------------------------------------}
{ TppLinkRangeIndex.SetNoLinkedData }

procedure TppLinkRangeIndex.SetNoLinkedData(aMasterRecNo: Integer);
var
  lLinkeRange: TppLinkRange;

begin
  {call SafeGetRangeValue which can allocate a new entry if needed}
  lLinkeRange := SafeGetRangeValue(aMasterRecNo);

  if (lLinkeRange <> nil) and (aMasterRecNo >= 0) then
    begin
      lLinkeRange.BeginRecordNo := -99;
      lLinkeRange.EndRecordNo   := -99;
    end;

end; {procedure, SetNoLinkedData}

{------------------------------------------------------------------------------}
{ TppLinkRangeIndex.CheckNoLinkedData }

function TppLinkRangeIndex.CheckNoLinkedData(aMasterRecNo: Integer): Boolean;
var
  lLinkeRange: TppLinkRange;

begin
  lLinkeRange := GetLinkRangeValue(aMasterRecNo);

  Result := (lLinkeRange <> nil) and (lLinkeRange.BeginRecordNo = -99) and
                                     (lLinkeRange.EndRecordNo   = -99);
                                     
end; {procedure, CheckNoLinkedData}


{******************************************************************************
*
*  D A T A   P I P E L I N E   L I S T
*
******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDataPipelineList.Create }

constructor TppDataPipelineList.Create(aReport: TComponent);
begin

  inherited  Create;

  SetReport(aReport);

end;  {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDataPipelineList.Destroy }


destructor TppDataPipelineList.Destroy;
begin

  inherited Destroy;

end; {constructor, Destroy}

{------------------------------------------------------------------------------}
{ TppDataPipelineList.AddDataPipeline }

procedure TppDataPipelineList.AddDataPipeline(aDataPipeline: TComponent);
begin

  {do not allow duplicates}
  if (IndexOfObject(aDataPipeline) <> -1) then Exit;

  {only add to list, if pipeline's Visible property set to true}
  if TppDataPipeline(aDataPipeline).Visible then
    AddObject(TppDataPipeline(aDataPipeline).UserName, aDataPipeline);

end; {procedure, AddDataPipeline}

{------------------------------------------------------------------------------}
{ TppDataPipelineList.BuildList }

procedure TppDataPipelineList.BuildList;
begin

  Clear;

  if (FReport = nil) then Exit;

  BuildListFromRBDataModule;

  FFormDesigner := GetFormDesigner;

  {build list of data pipeline names}
  if (FFormDesigner = nil) then
    BuildListRunTime(FReport.Owner)
  else
    BuildListDesignTime(FFormDesigner);


end; {procedure, BuildList}

{------------------------------------------------------------------------------}
{ TppDataPipelineList.Refresh }

procedure TppDataPipelineList.Refresh;
begin

  BuildList;

end; {procedure, Refresh}

{------------------------------------------------------------------------------}
{ TppDataPipelineList.GetFormDesigner }

function TppDataPipelineList.GetFormDesigner: TppFormDesigner;
begin

  {get the form designer}
  if FReport <> nil then
    Result := TppCustomReport(FReport).FormDesigner
  else
    Result := nil;

end; {function, GetFormDesigner}

{------------------------------------------------------------------------------}
{ TppDataPipelineList.SetReport }

procedure TppDataPipelineList.SetReport(aReport: TComponent);
begin

  FReport := aReport;

  BuildList;

end; {procedure, SetReport}

{------------------------------------------------------------------------------}
{ TppDataPipelineList.BuildListDesignTime }

procedure TppDataPipelineList.BuildListDesignTime(aDesigner: TppFormDesigner);
begin
  aDesigner.GetComponentNames(GetTypeData(TppDataPipeline.ClassInfo), GetDataItemsCallback);
end; {procedure, BuildListDesignTime}

{------------------------------------------------------------------------------}
{ TppDataPipelineList.GetDataItemsCallback }

procedure TppDataPipelineList.GetDataItemsCallback(const S: string);
begin
  AddDataPipeline(TppDataPipeline(FFormDesigner.GetComponent(S)));

end; {procedure, GetDataItemsCallback}

{------------------------------------------------------------------------------}
{ TppDataPipelineList.BuildListRunTime }

procedure TppDataPipelineList.BuildListRunTime(aOwner: TComponent);
var
  liIndex: Integer;
begin

  if (aOwner <> nil) then
    BuildListFromOwner(aOwner);

  {add data pipelines residing in data modules and forms }
  if not(ppInMainThread) then
    {do nothing}
    {if this is a multi-threaded app then we really don't want it pulling
     in other datamodules, because those are usually associated with individual
     threads in a multi-threaded app. }
   else
    begin
      for liIndex := 0 to Screen.DataModuleCount - 1 do
        if (aOwner <> Screen.DataModules[liIndex]) then
          BuildListFromOwner(Screen.DataModules[liIndex]);

      for liIndex := 0 to Screen.FormCount - 1 do
        if (aOwner <> Screen.Forms[liIndex]) then
          BuildListFromOwner(Screen.Forms[liIndex]);
    end;

end; {procedure, BuildListRunTime}

{------------------------------------------------------------------------------}
{ TppDataPipelineList.BuildListFromOwner }

procedure TppDataPipelineList.BuildListFromOwner(aOwner: TComponent);
var
  liIndex: Integer;

begin

  for liIndex := 0 to aOwner.ComponentCount-1 do
    if (aOwner.Components[liIndex] is TppDataPipeline) then
      AddDataPipeline(TppDataPipeline(aOwner.Components[liIndex]));

end; {procedure, BuildListFromOwner}

{------------------------------------------------------------------------------}
{ TppDataPipelineList.BuildListFromRBDataModule }

procedure TppDataPipelineList.BuildListFromRBDataModule;
var
  lList: TList;
  liIndex: Integer;
begin

  if (FReport = nil) then Exit;

  lList := TList.Create;

  try
    {get available datapipelines from the report's data module}
    TppCustomReport(FReport).GetRBDataModulePipelines(lList);

    for liIndex := 0 to lList.Count-1 do
      AddDataPipeline(TppDataPipeline(lList[liIndex]));

  finally
    lList.Free;
  end;


end; {procedure, BuildListFromRBDataModule}

{------------------------------------------------------------------------------}
{ TppDataPipelineList.GetPipelineForComponentName }

function TppDataPipelineList.GetPipelineForComponentName(aName: String): TppDataPipeline;
var
  liIndex: Integer;
  lDataPipeline: TppDataPipeline;
begin

  Result := nil;
  liIndex := 0;

  while (Result = nil) and (liIndex < Count) do
    begin
      lDataPipeline := TppDataPipeline(Objects[liIndex]);

      if ppEqual(lDataPipeline.Name, aName) then
        Result := lDataPipeline
      else
        Inc(liIndex);
    end;

end; {procedure, GetPipelineForComponentName}

{------------------------------------------------------------------------------}
{ TppDataPipelineList.GetPipelineForName }

function TppDataPipelineList.GetPipelineForName(aName: String): TppDataPipeline;
var
  liPipeline: Integer;

begin
  liPipeline := IndexOf(aName);

  if liPipeline < 0 then
    Result := nil
  else
    Result := TppDataPipeline(Objects[liPipeline]);

end; {procedure, GetPipelineForName}

{------------------------------------------------------------------------------}
{ TppDataPipelineList.GetPipeline }

function TppDataPipelineList.GetPipeline(aIndex: Integer): TppDataPipeline;
begin
  Result := TppDataPipeline(Objects[aIndex]);

end; {procedure, GetPipeline}

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
 ** D A T A   P I P E L I N E   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppDataPipelineRTTI.RefClass }

class function TraTppDataPipelineRTTI.RefClass: TClass;
begin
  Result := TppDataPipeline;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppDataPipelineRTTI.GetPropList }

class procedure TraTppDataPipelineRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  aPropList.AddProp('FieldObjects');
  aPropList.AddProp('FieldValues');
  aPropList.AddProp('GetFieldValue');

  {add 'faux' props}
  aPropList.AddProp('FirstRecord');
  aPropList.AddProp('LastRecord');
  aPropList.AddProp('NoRecords');

  {add methods}
  aPropList.AddMethod('IsLinked');
  aPropList.AddMethod('AddLink');
  aPropList.AddMethod('FreeLinks ');


end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppDataPipelineRTTI.GetPropRec }

class function TraTppDataPipelineRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  {events}
  if CompareText(aPropName, 'AfterClose') = 0 then
    EventToRec(aPropName, ciPipelineAfterClose, False, aPropRec)

  else if CompareText(aPropName, 'AfterOpen') = 0 then
    EventToRec(aPropName, ciPipelineAfterOpen, False, aPropRec)

  else if CompareText(aPropName, 'BeforeClose') = 0 then
    EventToRec(aPropName, ciPipelineBeforeClose, False, aPropRec)

  else if CompareText(aPropName, 'BeforeOpen') = 0 then
    EventToRec(aPropName, ciPipelineBeforeOpen, False, aPropRec)

  else if CompareText(aPropName, 'OnRecordPositionChange') = 0 then
    EventToRec(aPropName, ciPipelineRecordPositionChange, False, aPropRec)

  else if CompareText(aPropName, 'OnMasterRecordPositionChange') = 0 then
    EventToRec(aPropName, ciPipelineMasterRecordPositionChange, False, aPropRec)

  else if CompareText(aPropName, 'OnTraversal') = 0 then
    EventToRec(aPropName, ciPipelineTraversal, False, aPropRec)

  else if CompareText(aPropName, 'OnGotoBookmark') = 0 then
    EventToRec(aPropName, ciPipelineGotoBookmark, False, aPropRec)

  else if CompareText(aPropName, 'OnDataChange') = 0 then
    EventToRec(aPropName, ciPipelineDataChange, False, aPropRec)

  else if CompareText(aPropName, 'OnFirst') = 0 then
    EventToRec(aPropName, ciPipelineFirst, False, aPropRec)

  else if CompareText(aPropName, 'OnNext') = 0 then
    EventToRec(aPropName, ciPipelineNext, False, aPropRec)

  else if CompareText(aPropName, 'OnPrior') = 0 then
    EventToRec(aPropName, ciPipelinePrior, False, aPropRec)

  else if CompareText(aPropName, 'OnLast') = 0 then
    EventToRec(aPropName, ciPipelineLast, False, aPropRec)

  {properties & methods}
  else if ppEqual(aPropName, '')  or ppEqual(aPropName, 'FieldValues') then
    AccessSpecifierToRec(aPropName, aPropRec)

  else if ppEqual(aPropName, 'AddLink') then
    MethodToRec(aPropName, True, aPropRec)

  else if ppEqual(aPropName, 'IsLinked') then
    MethodToRec(aPropName, True, aPropRec)

  else if ppEqual(aPropName, 'FreeLinks') then
    MethodToRec(aPropName, False, aPropRec)

  else if ppEqual(aPropName, 'FieldObjects') then
    AccessSpecifierToRec(aPropName, aPropRec)

  else if ppEqual(aPropName, 'GetFieldValue') then
    MethodToRec(aPropName, True, aPropRec)

  else if ppEqual(aPropName, 'Fields')  then
    AccessSpecifierToRec(aPropName, aPropRec)

  else if ppEqual(aPropName, 'Links') then
    AccessSpecifierToRec(aPropName, aPropRec)

  else if ppEqual(aPropName, 'Active') then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if ppEqual(aPropName, 'BOF') then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if ppEqual(aPropName, 'DataTraversed') then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if ppEqual(aPropName, 'DataView') then
    ClassPropToRec(aPropName, TComponent, True, aPropRec)

  else if ppEqual(aPropName, 'EOF') then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if ppEqual(aPropName, 'SkipWhenNoRecords') then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if ppEqual(aPropName, 'TraversalCount') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'Visible') then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if ppEqual(aPropName, 'CurrentField') then
    ClassPropToRec(aPropName, TppField, True, aPropRec)

  else if ppEqual(aPropName, 'FieldCount') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'MasterDataPipeline') then
    ClassPropToRec(aPropName, TppDataPipeline, False, aPropRec)

  else if ppEqual(aPropName, 'LinkCount') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'FirstRecord') then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if ppEqual(aPropName, 'LastRecord') then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if ppEqual(aPropName, 'NoRecords') then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppDataPipelineRTTI.GetParams }

class function TraTppDataPipelineRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  if ppEqual(aMethodName, '') or ppEqual(aMethodName, 'FieldValues') then
    begin
      Result := TraParamList.Create;

      Result.AddParam('FieldName', daString, nil, '', False, False);
      Result.AddParam('Result', daVariant, nil, '', False, False);
    end

  else if ppEqual(aMethodName, 'AddLink') then
    begin
      Result := TraParamList.Create;

      Result.AddParam('MasterPipeline', daClass, TppDataPipeline, '', False, False);
      Result.AddParam('MasterFieldAlias', daString, nil, '', False, False);
      Result.AddParam('DetailFieldAlias', daString, nil, '', False, False);
      Result.AddParam('Result', daClass, TppMasterFieldLink, '', False, False);
    end
  else if ppEqual(aMethodName, 'IsLinked') then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Result', daBoolean, nil, '', False, False);
    end

  else if ppEqual(aMethodName, 'FieldObjects') then
    begin
      Result := TraParamList.Create;

      Result.AddParam('FieldName', daString, nil, '', False, False);
      Result.AddParam('Result', daClass, TppField, '', False, False);
    end

  else if ppEqual(aMethodName, 'GetFieldValue') then
    begin
      Result := TraParamList.Create;

      Result.AddParam('FieldName', daString, nil, '', False, False);
      Result.AddParam('Result', daVariant, nil, '', False, False);
    end

  else if ppEqual(aMethodName, 'Fields') then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Index', daInteger, nil, '', False, False);
      Result.AddParam('Result', daClass, TppField, '', False, False);
    end

  else if ppEqual(aMethodName, 'Links') then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Index', daInteger, nil, '', False, False);
      Result.AddParam('Result', daClass, TppMasterFieldLink, '', False, False);
    end

  else
    Result := inherited GetParams(aMethodName);

end; {class function, GetParams}

{------------------------------------------------------------------------------}
{ TraTppDataPipelineRTTI.CallMethod }

class function TraTppDataPipelineRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
var
  lPipeline: TppDataPipeline;
  liIndex: Integer;
  lsField: String;
  lvValue: Variant;
  lField: TppField;
  lLink: TppMasterFieldLink;
  lsMasterFieldAlias: String;
  lsDetailFieldAlias: String;
  lbResult: Boolean;
  lMasterPipeline: TppDataPipeline;
begin

  Result := True;
  
  lPipeline := TppDataPipeline(aObject);

  if ppEqual(aMethodName, '') or ppEqual(aMethodName, 'FieldValues') then
    begin
      aParams.GetParamValue(0, lsField);

      lvValue := lPipeline.FieldValues[lsField];

      aParams.SetParamValue(1, lvValue);
    end

 else if ppEqual(aMethodName, 'AddLink') then
    begin
      aParams.GetParamValue(0, lMasterPipeline);
      aParams.GetParamValue(1, lsMasterFieldAlias);
      aParams.GetParamValue(2, lsDetailFieldAlias);

      lLink := lPipeline.AddLink(lMasterPipeline, lsMasterFieldAlias, lsDetailFieldAlias);

      aParams.SetParamValue(3, Integer(lLink));
    end
 else if ppEqual(aMethodName, 'IsLinked') then
    begin
      lbResult := lPipeline.IsLinked;

      aParams.SetParamValue(0, lbResult);
    end
 else if ppEqual(aMethodName, 'FreeLinks') then
    begin
      lPipeline.FreeLinks;
    end

  else if ppEqual(aMethodName, 'FieldObjects') then
    begin
      aParams.GetParamValue(0, lsField);

      lField := lPipeline.FieldObjects[lsField];

      aParams.SetParamValue(1, Integer(lField));
    end

  else if ppEqual(aMethodName, 'Fields') then
    begin
      aParams.GetParamValue(0, liIndex);

      lField := lPipeline.Fields[liIndex];

      aParams.SetParamValue(1, Integer(lField));
    end

  else if ppEqual(aMethodName, 'GetFieldValue') then
    begin
      aParams.GetParamValue(0, lsField);

      lvValue := lPipeline.GetFieldValue(lsField);

      aParams.SetParamValue(1, lvValue);
    end

  else if ppEqual(aMethodName, 'Links') then
    begin
      aParams.GetParamValue(0, liIndex);

      lLink := lPipeline.Links[liIndex];

      aParams.SetParamValue(1, Integer(lLink));
    end

  else
    Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);

end; {class function, CallMethod}

{------------------------------------------------------------------------------}
{ TraTppDataPipelineRTTI.GetPropValue }

class function TraTppDataPipelineRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'Active') then
    Boolean(aValue) := TppDataPipeline(aObject).Active

  else if ppEqual(aPropName, 'BOF') then
    Boolean(aValue) := TppDataPipeline(aObject).BOF

  else if ppEqual(aPropName, 'DataTraversed') then
    Boolean(aValue) := TppDataPipeline(aObject).DataTraversed

  else if ppEqual(aPropName, 'DataView') then
     Integer(aValue) := Integer(TppDataPipeline(aObject).DataView)

  else if ppEqual(aPropName, 'EOF') then
    Boolean(aValue) := TppDataPipeline(aObject).EOF

  else if ppEqual(aPropName, 'SkipWhenNoRecords') then
    Boolean(aValue) := TppDataPipeline(aObject).SkipWhenNoRecords

  else if ppEqual(aPropName, 'TraversalCount') then
    Integer(aValue) := TppDataPipeline(aObject).TraversalCount

  else if ppEqual(aPropName, 'Visible') then
    Boolean(aValue) := TppDataPipeline(aObject).Visible

  else if ppEqual(aPropName, 'CurrentField') then
     Integer(aValue) := Integer(TppDataPipeline(aObject).CurrentField)

  else if ppEqual(aPropName, 'FieldCount') then
    Integer(aValue) := TppDataPipeline(aObject).FieldCount

  else if ppEqual(aPropName, 'MasterDataPipeline') then
     Integer(aValue) := Integer(TppDataPipeline(aObject).MasterDataPipeline)

  else if ppEqual(aPropName, 'LinkCount') then
    Integer(aValue) := TppDataPipeline(aObject).LinkCount

  else if ppEqual(aPropName, 'FirstRecord') then
    Boolean(aValue) := (ppdaFirstRecord in TppDataPipeline(aObject).State)

  else if ppEqual(aPropName, 'LastRecord') then
    Boolean(aValue) := (ppdaLastRecord in TppDataPipeline(aObject).State)

  else if ppEqual(aPropName, 'NoRecords') then
    Boolean(aValue) := (ppdaNoRecords in TppDataPipeline(aObject).State)

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppDataPipelineRTTI.SetPropValue }

class function TraTppDataPipelineRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'SkipWhenNoRecords') then
    TppDataPipeline(aObject).SkipWhenNoRecords := Boolean(aValue)

  else if ppEqual(aPropName, 'Visible') then
    TppDataPipeline(aObject).Visible := Boolean(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}

{******************************************************************************
 *
 ** F I E L D   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppFieldRTTI.RefClass }

class function TraTppFieldRTTI.RefClass: TClass;
begin
  Result := TppField;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppFieldRTTI.GetPropList }

class procedure TraTppFieldRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  {add public props}
  aPropList.AddProp('AsDouble');
  aPropList.AddProp('AsPicture');
  aPropList.AddProp('AsString');
  aPropList.AddProp('IsNull');
  aPropList.AddProp('DataPipeline');
  aPropList.AddProp('Value');

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppFieldRTTI.GetPropRec }

class function TraTppFieldRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  {properties}
  if ppEqual(aPropName, 'AsDouble') then
    PropToRec(aPropName, daDouble, True, aPropRec)

  else if ppEqual(aPropName, 'AsPicture') then
    ClassPropToRec(aPropName, TPicture, True, aPropRec)

  else if ppEqual(aPropName, 'AsString') then
    PropToRec(aPropName, daString, True, aPropRec)

  else if ppEqual(aPropName, 'IsNull') then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if ppEqual(aPropName, 'DataPipeline') then
    ClassPropToRec(aPropName, TppDataPipeline, True, aPropRec)

  else if ppEqual(aPropName, 'Value') then
    PropToRec(aPropName, daVariant, True, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppFieldRTTI.GetPropValue }

class function TraTppFieldRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'AsDouble') then
    Double(aValue) := TppField(aObject).AsDouble

  else if ppEqual(aPropName, 'AsPicture') then
    Integer(aValue) := Integer(TppField(aObject).AsPicture)

  else if ppEqual(aPropName, 'AsString') then
    String(aValue) := TppField(aObject).AsString

  else if ppEqual(aPropName, 'IsNull') then
    Boolean(aValue) := TppField(aObject).IsNull

  else if ppEqual(aPropName, 'DataPipeline') then
    Integer(aValue) := Integer(TppField(aObject).DataPipeline)

  else if ppEqual(aPropName, 'Value') then
    Variant(aValue) := TppField(aObject).Value

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}



{******************************************************************************
 *
 ** F I E L D   C O L L E C T I O N
 *
{******************************************************************************}

constructor TppFieldCollection.Create;
begin
  inherited;
  FFieldAliasIndex := TppHashTable.Create;

end;

destructor TppFieldCollection.Destroy;
begin
  inherited;
  FFieldAliasIndex.Free;
  FFieldAliasIndex := nil;
end;

function TppFieldCollection.Add(aField: TppField): Integer;
begin

  Result := InternalAdd(aField);

end;

function TppFieldCollection.GetFieldAliasIndex: TppHashTable;
begin
  if not(IndexValid) then
    RebuildIndex();
  Result := FFieldAliasIndex;
end;

function TppFieldCollection.GetItemByFieldAlias(FieldAlias: String): TppField;
var
  liIndex: Integer;
begin
  liIndex := GetFieldAliasIndex.ValueOf(AnsiUpperCase(FieldAlias));

  if (liIndex >= 0) then
    Result := TppField(InnerList[liIndex])
  else
    Result := nil;

end;

function TppFieldCollection.GetItemByFieldName(FieldName: String): TppField;
begin
  Result := TppField(GetItemForKey(AnsiUpperCase(FieldName)));
end;

function TppFieldCollection.GetItems(Index: Integer): TppField;
begin
  Result := TppField(InnerList[Index]);
end;

function TppFieldCollection.GetKey(aObject: TObject): String;
begin
  Result := AnsiUpperCase(TppField(aObject).FieldName);
end;

function TppFieldCollection.IndexOfFieldName(aFieldName: String): Integer;
begin
  Result := IndexOfKey(AnsiUpperCase(aFieldName));

end;

procedure TppFieldCollection.Insert(aPosition: Integer; aField: TppField);
begin

  InternalInsert(aPosition, aField);

end;

procedure TppFieldCollection.NameChanged(aField: TppField);
begin
  IndexValid := False;
end;

procedure TppFieldCollection.AliasChanged(aField: TppField);
begin
  IndexValid := False;
end;

procedure TppFieldCollection.RebuildIndex;
var
  liIndex: Integer;
  lField: TppField;
begin

  inherited;

  FFieldAliasIndex.Free;
  FFieldAliasIndex := nil;

  if (InnerList.Count = 0) then
    FFieldAliasIndex := TppHashTable.Create
  else
    FFieldAliasIndex := TppHashTable.Create(InnerList.Count);

  for liIndex := 0 to InnerList.Count - 1 do
    begin
      lField := TppField(InnerList[liIndex]);
      FFieldAliasIndex.Add(AnsiUpperCase(lField.FieldAlias), liIndex);
    end;

end;

function TppFieldCollection.Remove(aField: TppField): Integer;
begin

  Result := InternalRemove(aField);

end;


{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  RegisterClasses([TppField, TppMasterFieldLink]);

  raRegisterRTTI(TraTppDataPipelineRTTI);
  raRegisterRTTI(TraTppFieldRTTI);

finalization

  UnRegisterClasses([TppField, TppMasterFieldLink]);

  raUnRegisterRTTI(TraTppDataPipelineRTTI);
  raUnRegisterRTTI(TraTppFieldRTTI);

end.
