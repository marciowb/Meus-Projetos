{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{                   ExpressScheduler                                 }
{                                                                    }
{       Copyright (c) 2003-2010 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSSCHEDULER AND ALL ACCOMPANYING }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.              }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit cxSchedulerStorage;

{$I cxVer.inc}

interface

uses
  Classes, SysUtils,
  Windows, Forms,
{$IFDEF DELPHI6}
  Variants,
{$ENDIF}
  Math, Graphics, {$IFDEF DELPHI6} DateUtils, {$ENDIF} cxClasses, cxCustomData, cxDataStorage,
  cxDateUtils, cxDataUtils, cxSchedulerUtils, cxVariants, cxStorage;

type
  TcxCustomSchedulerStorage = class;

  TcxSchedulerStorage = class;
  TcxSchedulerEvent = class;
  TcxSchedulerEventRecurrenceInfo = class;
  TcxSchedulerControlEvent = class;
  TcxSchedulerCachedEventList = class;
  TcxSchedulerOccurrenceCalculator = class;
  TcxSchedulerEventList = class;
  TcxSchedulerFilteredEventList = class;
  TcxSchedulerStorageResources = class;
  TcxSchedulerStorageResourceItem = class;

  TcxCustomSchedulerStorageClass = class of TcxCustomSchedulerStorage;
  TcxSchedulerCachedEventListClass = class of TcxSchedulerCachedEventList;
  TcxSchedulerStorageResourcesClass = class of TcxSchedulerStorageResources;
  TcxSchedulerStorageResourceItemClass = class of TcxSchedulerStorageResourceItem;

  TcxEventType = (etNone, etPattern, etOccurrence, etException, etCustom);

  TcxRecurrence = (cxreDaily, cxreWeekly, cxreMonthly, cxreYearly);

  TcxRecurrenceValidStatus = (rvsValid, rvsReplaceOccurrenceDate, rvsInvalidPattern,
    rvsInvalidDuration);

  TcxDayType = (cxdtDay, cxdtEveryDay, cxdtWeekDay, cxdtWeekEndDay, cxdtSunday,
    cxdtMonday, cxdtTuesday, cxdtWednesday, cxdtThursday, cxdtFriday, cxdtSaturday);

  TcxCompareEventsProc = function(AEvent1, AEvent2: TcxSchedulerEvent): Integer;
  TcxGetRecurrenceDescriptionStringProc = function(
    ARecurrenceInfo: TcxSchedulerEventRecurrenceInfo): string;

  { IcxSchedulerStorageListener }

  IcxSchedulerStorageListener = interface
  ['{87E0EBF3-F68A-4A51-8EA3-850D3819FBAB}']
    procedure StorageChanged(Sender: TObject);
    procedure StorageRemoved(Sender: TObject);
  end;

  { IcxSchedulerSelectionAdapter }

  IcxSchedulerSelectionAdapter = interface
  ['{68B007E5-1057-40DE-BDA4-0D72F3780CC7}']
    procedure Add(AEvent: TcxSchedulerControlEvent; Shift: TShiftState);
    procedure Clear;
    function IsSelected(AEvent: TcxSchedulerControlEvent): Boolean;
    procedure Update;
  end;

  { TcxSchedulerStorageDataController }

  TcxSchedulerStorageDataController = class(TcxCustomDataController)
  private
    function GetStorage: TcxCustomSchedulerStorage;
  protected
    procedure UpdateControl(AInfo: TcxUpdateControlInfo); override;
    function UseRecordID: Boolean; override;
    property Storage: TcxCustomSchedulerStorage read GetStorage;
  public
    function GetItem(Index: Integer): TObject; override;
    function GetItemValueSource(AItemIndex: Integer): TcxDataEditValueSource; override;
    function GetItemID(AItem: TObject): Integer; override;
    procedure UpdateData; override;
    procedure UpdateItemIndexes; override;
  end;

  TcxSchedulerStorageDataControllerClass = class of TcxCustomDataController;

  { TcxCustomSchedulerStorageField }

  TcxCustomSchedulerStorageField = class(TCollectionItem)
  private
    FIndex: Integer;
    FName: string;
    function IsValueTypeStored: Boolean;
    function GetDataController: TcxCustomDataController;
    function GetStorage: TcxCustomSchedulerStorage;
    function GetValue(AIndex: Integer): Variant;
    function GetValueCount: Integer;
    function GetValueType: string;
    function GetValueTypeClass: TcxValueTypeClass;
    procedure SetName(const AValue: string);
    procedure SetValue(AIndex: Integer; const AValue: Variant);
    procedure SetValueType(const AValue: string);
    procedure SetValueTypeClass(AValue: TcxValueTypeClass); virtual;
  protected
    function GetDisplayName: string; override;
    property DataController: TcxCustomDataController read GetDataController;
    property Name: string read FName write SetName;
    property Storage: TcxCustomSchedulerStorage read GetStorage;
    property ValueCount: Integer read GetValueCount;
    property Values[ARecordIndex: Integer]: Variant read GetValue write SetValue;
    property ValueType: string read GetValueType write SetValueType stored IsValueTypeStored;
    property ValueTypeClass: TcxValueTypeClass read GetValueTypeClass write SetValueTypeClass;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property Index: Integer read FIndex;
  end;

  TcxSchedulerStorageFieldClass = class of TcxCustomSchedulerStorageField;

  { TcxSchedulerStorageField }

  TcxSchedulerStorageField = class(TcxCustomSchedulerStorageField)
  public
    property ValueCount;
    property Values;
    property ValueTypeClass;
  published
    property Index;
    property Name;
    property ValueType;
  end;

  { TcxCustomSchedulerStorageFields }

  TcxCustomSchedulerStorageFields = class(TCollection)
  private
    FOwner: TPersistent;
    function GetStorage: TcxCustomSchedulerStorage;
  protected
    function FindFieldByName(const AName: string): TcxCustomSchedulerStorageField; virtual;
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    property Storage: TcxCustomSchedulerStorage read GetStorage;
  end;

  TcxSchedulerStorageFieldsClass = class of TcxCustomSchedulerStorageFields;

  { TcxSchedulerStorageFields }

  TcxSchedulerStorageFields = class(TcxCustomSchedulerStorageFields)
  private
    function GetItem(AIndex: Integer): TcxSchedulerStorageField;
    procedure SetItem(AIndex: Integer; AValue: TcxSchedulerStorageField);
  public
    function Add: TcxSchedulerStorageField;
    function ItemByName(const AName: string): TcxSchedulerStorageField;

    property Items[Index: Integer]: TcxSchedulerStorageField read GetItem write SetItem;
    property Storage;
  end;

  { TcxSchedulerEventRecurrenceInfo }

  TcxSchedulerEventRecurrenceInfoData = packed record
    Count: Integer;
    DayNumber: Integer;
    DayType: TcxDayType;
    Finish: TDateTime;
    OccurDays: TDays;
    Periodicity: Integer;
    Recurrence: TcxRecurrence;
    Start: TDateTime;
    YearPeriodicity: Integer;
    Reserved1: Byte;
    Reserved2: Integer;
  end;

  TcxSchedulerEventRecurrenceInfo = class(TPersistent)
  private
    FOwner: TcxSchedulerEvent;
    function GetCount: Integer;
    function GetDayNumber: Integer;
    function GetDayType: TcxDayType;
    function GetFinish: TDateTime;
    function GetOccurDays: TDays;
    function GetPeriodicity: Integer;
    function GetRecurrence: TcxRecurrence;
    function GetStart: TDateTime;
    function GetStorage: TcxCustomSchedulerStorage;
    function GetYearPeriodicity: Integer;
    procedure SetCount(const AValue: Integer);
    procedure SetDayNumber(const AValue: Integer);
    procedure SetDayType(const AValue: TcxDayType);
    procedure SetFinish(AValue: TDateTime);
    procedure SetOccurDays(const AValue: TDays);
    procedure SetPeriodicity(const AValue: Integer);
    procedure SetRecurrence(const AValue: TcxRecurrence);
    procedure SetStart(const AValue: TDateTime);
    procedure SetYearPeriodicity(const AValue: Integer);
  protected
    procedure AssignDefaultValues; virtual;
    function GetData: TcxSchedulerEventRecurrenceInfoData;
    function GetOwner: TPersistent; override;
    function GetValue(var AValue: string): Boolean;
    procedure SetDataItem(AOffset: Pointer; ASize: Integer; const AValue);
    procedure SetValue(const AValue: string);
    // validate
    function GetDailyPatternStatus: TcxRecurrenceValidStatus;
    function GetMonthlyPatternStatus: TcxRecurrenceValidStatus;
    function GetWeeklyPatternStatus: TcxRecurrenceValidStatus;
    function GetYearlyPatternStatus: TcxRecurrenceValidStatus;

    property Storage: TcxCustomSchedulerStorage read GetStorage;
  public
    constructor Create(AOwner: TcxSchedulerEvent); virtual;
    procedure Assign(Source: TPersistent); override;
    function GetValidStatus: TcxRecurrenceValidStatus;
    procedure Validate;

    property Count: Integer read GetCount write SetCount;
    property DayNumber: Integer read GetDayNumber write SetDayNumber;
    property DayType: TcxDayType read GetDayType write SetDayType;
    property Event: TcxSchedulerEvent read FOwner;
    property Finish: TDateTime read GetFinish write SetFinish;
    property OccurDays: TDays read GetOccurDays write SetOccurDays;
    property Periodicity: Integer read GetPeriodicity write SetPeriodicity;
    property Recurrence: TcxRecurrence read GetRecurrence write SetRecurrence;
    property Start: TDateTime read GetStart write SetStart;
    property YearPeriodicity: Integer read GetYearPeriodicity write SetYearPeriodicity;
  end;

  TcxSchedulerEventRecurrenceInfoClass = class of TcxSchedulerEventRecurrenceInfo;

  { TcxSchedulerEvent }

  TcxSchedulerEvent = class(TPersistent)
  private
    FIsModified: Boolean;
    FLink: TcxSchedulerEvent;
    FStorage: TcxCustomSchedulerStorage;
    FRecurrenceInfo: TcxSchedulerEventRecurrenceInfo;
    function GetAllDayEvent: Boolean;
    function GetCaption: string;
    function GetDuration: TDateTime;
    function GetEditValue(AIndex: Integer): Variant;
    function GetEnabled: Boolean;
    function GetEventType: TcxEventType;
    function GetFinish: TDateTime;
    function GetID: Variant;
    function GetIsEditing: Boolean;
    function GetIsNewEvent: Boolean;
    function GetLabelColor: Integer;
    function GetLocation: string;
    function Getmessage: string; {GetMessage conflicts with C++ macro}
    function GetOptionsFlag: Integer;
    function GetParentID: Variant;
    function GetReadOnly: Boolean;
    function GetRecurrenceIndex: Integer;
    function GetReminder: Boolean;
    function GetReminderTime: Integer;
    function GetResourceID: Variant;
    function GetStart: TDateTime;
    function GetState: Integer;
    function GetValueCount: Integer;
    procedure SetAllDayEvent(const AValue: Boolean);
    procedure SetCaption(const AValue: string);
    procedure SetDuration(const AValue: TDateTime);
    procedure SetEditValue(AIndex: Integer; const AValue: Variant);
    procedure SetEnabled(const AValue: Boolean);
    procedure SetEventType(AValue: TcxEventType);
    procedure SetFinish(const AValue: TDateTime);
    procedure SetLabelColor(const AValue: Integer);
    procedure SetLocation(const AValue: string);
    procedure SetMessage(const AValue: string);
    function SetOptionsFlag(const AMask: Integer; AValue: Boolean): Boolean;
    procedure SetParentID(const AValue: Variant);
    procedure SetRecurrenceIndex(const AValue: Integer);
    procedure SetRecurrenceInfo(AValue: TcxSchedulerEventRecurrenceInfo);
    procedure SetReminder(const AValue: Boolean);
    procedure SetReminderTime(const AValue: Integer);
    procedure SetResourceID(const AValue: Variant);
    procedure SetStart(const AValue: TDateTime);
    procedure SetState(const AValue: Integer);
  protected
    FEditCount: Integer;
    FEditValues: array of Variant;
    FPattern: TcxSchedulerEvent;
    FRecordIndex: Integer;
    FIsDataValid: Boolean;
    FFinish, FStart: Double;
    FOptions: Integer;
    FSavedID: Variant;
    FSkipModified: Boolean; 
    procedure AssignDefaultValues; virtual;
    procedure CheckRecurrenceLink(AEvent: TcxSchedulerEvent);
    function CreateRecurrenceInfo: TcxSchedulerEventRecurrenceInfo; virtual;
    function GetOccurrenceByIndex(AIndex: Integer; var AOccurrence: TcxSchedulerEvent): Boolean;
    function GetOwner: TPersistent; override;
    function GetRecurrenceInfoValue(var AValue: string): Boolean; virtual;
    function GetValueByIndex(AIndex: Integer): Variant; virtual;
    function GetValueDef(AField: TcxCustomSchedulerStorageField; const ADefValue: Variant): Variant;
    procedure Modified;
    procedure PostEditingData;
    procedure SetRecordIndex(const AIndex: Integer);
    procedure SetRecurrenceInfoValue(const AValue: string); virtual;
    procedure SetValue(AField: TcxCustomSchedulerStorageField; const AValue: Variant);
    procedure SetValueByIndex(AIndex: Integer; const AValue: Variant); virtual;
    function TimeBias: Double; virtual;
    procedure UpdateTemporaryData;
    property IsNewEvent: Boolean read GetIsNewEvent;
    property IsModified: Boolean read FIsModified write FIsModified;
    property Link: TcxSchedulerEvent read FLink;
    property Reminder: Boolean read GetReminder write SetReminder;
    property ReminderTime: Integer read GetReminderTime write SetReminderTime;
  public
    constructor Create(AStorage: TcxCustomSchedulerStorage); overload; virtual;
    constructor Create(AStorage: TcxCustomSchedulerStorage; ARecordIndex: Integer); overload; virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure BeginEditing; virtual;
    procedure Cancel;
    procedure EndEditing; virtual;
    procedure Delete; virtual;
    procedure DeleteExceptions;
    function HasExceptions: Boolean;
    //custom fields routines
    function GetCustomFieldValueByIndex(AIndex: Integer): Variant;
    function GetCustomFieldValueByName(const AName: String): Variant;
    function GetCustomFieldValue(ACustomField: TcxCustomSchedulerStorageField): Variant;
    procedure SetCustomFieldValueByIndex(AIndex: Integer; const AValue: Variant);
    procedure SetCustomFieldValueByName(const AName: string; const AValue: Variant);
    procedure SetCustomFieldValue(ACustomField: TcxCustomSchedulerStorageField; const AValue: Variant);
    //
    function GetResourceItem: TcxSchedulerStorageResourceItem;
    function GetRecurrenceChain: TcxSchedulerEventList;
    function IsDayEvent(ADate: TDateTime): Boolean;
    function IsRecurring: Boolean;
    function IsResourceEvent(AResource: TcxSchedulerStorageResourceItem;
      AllowUnassigned: Boolean): Boolean;
    procedure MoveTo(const AStartTime: TDateTime);
    procedure Post;
    property AllDayEvent: Boolean read GetAllDayEvent write SetAllDayEvent;
    property Caption: string read GetCaption write SetCaption;
    property Duration: TDateTime read GetDuration write SetDuration;
    property EditValues[Index: Integer]: Variant read GetEditValue write SetEditValue;
    property Enabled: Boolean read GetEnabled write SetEnabled;
    property EventType: TcxEventType read GetEventType write SetEventType;
    property Finish: TDateTime read GetFinish write SetFinish;
    property ID: Variant read GetID;
    property IsEditing: Boolean read GetIsEditing;
    property LabelColor: Integer read GetLabelColor write SetLabelColor;
    property Location: string read GetLocation write SetLocation;
    property Message: string read Getmessage write SetMessage;
    property ParentID: Variant read GetParentID write SetParentID;
    property Pattern: TcxSchedulerEvent read FPattern;
    property ReadOnly: Boolean read GetReadOnly;
    property RecordIndex: Integer read FRecordIndex;
    property RecurrenceIndex: Integer read GetRecurrenceIndex write SetRecurrenceIndex;
    property RecurrenceInfo: TcxSchedulerEventRecurrenceInfo read FRecurrenceInfo write SetRecurrenceInfo;
    property ResourceID: Variant read GetResourceID write SetResourceID;
    property Start: TDateTime read GetStart write SetStart;
    property State: Integer read GetState write SetState;
    property Storage: TcxCustomSchedulerStorage read FStorage;
    property ValueCount: Integer read GetValueCount;
    property Values[Index: Integer]: Variant read GetValueByIndex write SetValueByIndex;
  end;

  { TcxSchedulerControlEvent }

  TcxSchedulerControlEvent = class(TcxSchedulerEvent)
  private
    FIsClone: Boolean;
    FIsSource: Boolean;
    FSelectionAdapter: IcxSchedulerSelectionAdapter;
    FSource: TcxSchedulerEvent;
    FTimeBias: Double;
    FValues: array of Variant;
    function GetSelected: Boolean;
    procedure SetSelected(AValue: Boolean);
  protected
    procedure ClearValues;
    function GetValueByIndex(AIndex: Integer): Variant; override;
    procedure SetValueByIndex(AIndex: Integer; const AValue: Variant); override;
    function TimeBias: Double; override;
    property SelectionAdapter: IcxSchedulerSelectionAdapter read FSelectionAdapter write FSelectionAdapter;
  public
    constructor Create(AStorage: TcxCustomSchedulerStorage); overload; override;
    constructor Create(ASource: TcxSchedulerEvent); reintroduce; overload;
    constructor Create(ASource: TcxSchedulerEvent; const AStart, AFinish: TDateTime); reintroduce; overload;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure BeginEditing; override;
    procedure Delete; override;
    procedure EndEditing; override;
    property Selected: Boolean read GetSelected write SetSelected;
    property Source: TcxSchedulerEvent read FSource;
    property IsClone: Boolean read FIsClone;
    property IsSource: Boolean read FIsSource;
  end;

  TcxSchedulerEventClass = class of TcxSchedulerEvent;

  TcxSchedulerGetResourceNameEvent = procedure(Sender: TObject;
    AResource: TcxSchedulerStorageResourceItem; var AResourceName: string) of object;

  { TcxSchedulerStorageResourceItems }

  TcxSchedulerStorageResourceItems = class(TCollection)
  private
    FOwner: TcxSchedulerStorageResources;
    function GetItem(AIndex: Integer): TcxSchedulerStorageResourceItem;
    function GetStorage: TcxCustomSchedulerStorage;
    procedure SetItem(AIndex: Integer; AValue: TcxSchedulerStorageResourceItem);
    function GetVisibleResource(AIndex: Integer): TcxSchedulerStorageResourceItem;
    function GetVisibleResourceCount: Integer;
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
    property Resources: TcxSchedulerStorageResources read FOwner;
    property Storage: TcxCustomSchedulerStorage read GetStorage;
  public
    constructor Create(AOwner: TcxSchedulerStorageResources; AItemClass: TcxSchedulerStorageResourceItemClass); virtual;
    function Add: TcxSchedulerStorageResourceItem;
    property Items[Index: Integer]: TcxSchedulerStorageResourceItem read GetItem write SetItem; default;
    property VisibleResourceCount: Integer read GetVisibleResourceCount;
    property VisibleResources[Index: Integer]: TcxSchedulerStorageResourceItem read GetVisibleResource;
  end;

  { TcxSchedulerStorageResourceItem }

  TcxSchedulerStorageResourceItem = class(TCollectionItem)
  private
    FColor: TColor;
    FName: string;
    FReadOnly: Boolean;
    FResourceID: Variant;
    FVisible: Boolean;
    function GetResources: TcxSchedulerStorageResources;
  protected
    // methods            TList.Sort
    function GetDisplayName: string; override;
    procedure SetColor(const AValue: TColor); virtual;
    procedure SetName(const AValue: string); virtual;
    procedure SetResourceID(const AValue: Variant); virtual;
    procedure SetVisible(const AValue: Boolean); virtual;
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
    property Resources: TcxSchedulerStorageResources read GetResources;
  published
    property Name: string read FName write SetName;
    property Color: TColor read FColor write SetColor default clDefault;
    property ResourceID: Variant read FResourceID write SetResourceID;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property Visible: Boolean read FVisible write SetVisible default True;
  end;

  { TcxSchedulerStorageResources }

  TcxSchedulerStorageResources = class(TcxInterfacedPersistent, IcxStoredObject)
  private
    FItems: TcxSchedulerStorageResourceItems;
    FOwner: TcxCustomSchedulerStorage;
    FOnGetResourceName: TcxSchedulerGetResourceNameEvent;
    procedure SetItems(AValue: TcxSchedulerStorageResourceItems);
  protected
    // IcxStoredObject
    function GetObjectName: string;
    function GetProperties(AProperties: TStrings): Boolean;
    procedure GetPropertyValue(const AName: string; var AValue: Variant);
    procedure SetPropertyValue(const AName: string; const AValue: Variant);
    // methods
    procedure Changed; virtual;
    function CreateItems: TcxSchedulerStorageResourceItems; virtual;
    function DoGetResourceName(AItem: TcxSchedulerStorageResourceItem): string; virtual;
    function GetOwner: TPersistent; override;
    function GetResourceItems: TcxSchedulerStorageResourceItems; virtual;
    property Storage: TcxCustomSchedulerStorage read FOwner;
  public
    constructor Create(AOwner: TcxCustomSchedulerStorage); reintroduce; virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetResourceName(AResource: TcxSchedulerStorageResourceItem): string;
    property ResourceItems: TcxSchedulerStorageResourceItems read GetResourceItems;
  published
    property Items: TcxSchedulerStorageResourceItems read FItems write SetItems;
    property OnGetResourceName: TcxSchedulerGetResourceNameEvent read FOnGetResourceName write FOnGetResourceName;
  end;

  TcxSchedulerNotificationEvent = procedure(Sender: TObject;
    AEvent: TcxSchedulerEvent; var AHandled: Boolean) of object;

  { TcxCustomSchedulerStorage }

  TcxCustomSchedulerStorage = class(TComponent)
  private
    FDataController: TcxCustomDataController;
    FEditor: TForm;
    FInternalFields: TcxCustomSchedulerStorageFields;
    FIsLoading: Boolean;
    FIsModified: Boolean;
    FIsDeletion: Boolean;
    FListeners: TInterfaceList;
    FResources: TcxSchedulerStorageResources;
    FResourcesEvents: TNotifyEvent;
    FStoreUsingGlobalTime: Boolean;
    FStoringName: string;
    FUserFields: TcxCustomSchedulerStorageFields;
    FOnEventDeleted: TcxSchedulerNotificationEvent;
    FOnEventInserted: TcxSchedulerNotificationEvent;
    FOnEventModified: TcxSchedulerNotificationEvent;
    function GetEvent(AIndex: Integer): TcxSchedulerEvent;
    function GetEventCount: Integer;
    function GetFieldCount: Integer;
    function GetIsDestroying: Boolean;
    function GetIsLoading: Boolean;
    function GetIsLocked: Boolean;
    function GetIsUpdatingMode: Boolean;
    function GetResourceCount: Integer;
    function GetResourceID(AIndex: Integer): Variant;
    function GetResourceName(AIndex: Integer): string;
    procedure SetEvent(AIndex: Integer; AValue: TcxSchedulerEvent);
    procedure SetResources(AValue: TcxSchedulerStorageResources);
    procedure SetStoreUsingGlobalTime(AValue: Boolean);
  protected
    EventsIndex: TList;
    FFields: TList;
    FNewEvents: TcxSchedulerEventList;
    FEventsList: TcxSchedulerEventList;
    FDeletedRecords: TList;
    // internal fields
    FCaptionField: TcxCustomSchedulerStorageField;
    FEventTypeField: TcxCustomSchedulerStorageField;
    FFinishField: TcxCustomSchedulerStorageField;
    FLabelColorField: TcxCustomSchedulerStorageField;
    FLocationField: TcxCustomSchedulerStorageField;
    FMessageField: TcxCustomSchedulerStorageField;
    FOptionsField: TcxCustomSchedulerStorageField;
    FParentIDField: TcxCustomSchedulerStorageField;
    FRecurrenceIndexField: TcxCustomSchedulerStorageField;
    FRecurrenceInfoField: TcxCustomSchedulerStorageField;
    FReminderTimeField: TcxCustomSchedulerStorageField;
    FResourceIDField: TcxCustomSchedulerStorageField;
    FStartField: TcxCustomSchedulerStorageField;
    FStateField: TcxCustomSchedulerStorageField;
    TimeBias: Double;
    procedure AddInternalField(var AField: TcxCustomSchedulerStorageField;
      AValueType: TcxValueTypeClass);
    procedure AddRecord; virtual;
    procedure CancelEvent(AEvent: TcxSchedulerEvent); virtual;
    function CanGetValueFromPattern(AIndex: Integer): Boolean; virtual;
    procedure Changed; virtual;
    procedure CreateDefaultFields; virtual;
    function CreateFields: TcxCustomSchedulerStorageFields; virtual;
    function CreateResources: TcxSchedulerStorageResources; virtual;
    procedure CreateSubClasses; virtual;
    procedure DestroySubClasses; virtual;
    procedure DoDeleteEvent(const ARecordIndex: Integer); virtual;
    procedure DoDestroyEvent(AEvent: TcxSchedulerEvent); virtual;
    function DoEventDeleted(AEvent: TcxSchedulerEvent): Boolean; virtual;
    function DoEventInserted(AEvent: TcxSchedulerEvent): Boolean; virtual;
    function DoEventModified(AEvent: TcxSchedulerEvent): Boolean; virtual;
    procedure DoRefresh; virtual;
    function GetDataControllerClass: TcxCustomDataControllerClass; virtual;
    function GetEventClass: TcxSchedulerEventClass; virtual;
    function GetEventStoredID(AEvent: TcxSchedulerEvent): Variant;
    function GetFieldValueBeforePost(ARecordIndex, AFieldIndex: Integer): Variant; virtual;
    function GetFocusedRecordID(ARecordIndex: Integer): Variant; virtual;
    function GetParentForm: TForm;
    function GetRecordID(const ARecordIndex: Integer): Variant; virtual;
    function GetValue(ARecordIndex, AItemIndex: Integer): Variant; virtual;
    procedure ItemAdded(AItem: TcxCustomSchedulerStorageField);
    procedure ItemRemoved(AItem: TcxCustomSchedulerStorageField);
    function IsDataSettingsValid: Boolean; virtual;
    procedure LayoutChanged; virtual;
    procedure Loaded; override;
    procedure PostEvent(AEvent: TcxSchedulerEvent); virtual;
    procedure PostEditingData(AEvent: TcxSchedulerEvent); virtual;
    procedure SendNotification(
      AIsRemoved: Boolean = False); virtual;
    procedure SetEventRecordInfo(AEvent: TcxSchedulerEvent; ARecordIndex: Integer; const AEventID: Variant); virtual;
    procedure SetFieldValueBeforePost(ARecordIndex, AFieldIndex: Integer; const AValue: Variant); virtual;
    procedure SetPostFieldValue(AEvent: TcxSchedulerEvent; AFieldIndex: Integer); virtual;
    procedure SetValue(ARecordIndex, AItemIndex: Integer; const AValue: Variant); virtual;
    procedure UpdateControl(AInfo: TcxUpdateControlInfo); virtual;
    procedure UpdateData; virtual;
    procedure UpdateItemIndexes;
    function IsReminderAvailable: Boolean; virtual;

    procedure AfterUpdate; virtual;
    procedure BeforeUpdate; virtual;

    property DataController: TcxCustomDataController read FDataController;
    property Editor: TForm read FEditor write FEditor;
    property Fields: TcxCustomSchedulerStorageFields read FUserFields;
    property InternalFields: TcxCustomSchedulerStorageFields read FInternalFields;
    property IsDeletion: Boolean read FIsDeletion write FIsDeletion;
    property IsDestroying: Boolean read GetIsDestroying;
    property IsLoading: Boolean read GetIsLoading;
    property IsLocked: Boolean read GetIsLocked;
    property IsModified: Boolean read FIsModified;
    property IsUpdatingMode: Boolean read GetIsUpdatingMode;
    property Listeners: TInterfaceList read FListeners;
    property OnEventDeleted: TcxSchedulerNotificationEvent read FOnEventDeleted write FOnEventDeleted;
    property OnEventInserted: TcxSchedulerNotificationEvent read FOnEventInserted write FOnEventInserted;
    property OnEventModified: TcxSchedulerNotificationEvent read FOnEventModified write FOnEventModified;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure AddListener(AListener: IcxSchedulerStorageListener);
    procedure BeginUpdate;
    function CheckRequiredFields: Boolean; virtual;
    function createEvent: TcxSchedulerEvent; {CreateEvent conflicts with C++ macro}
    function CreateOccurrence(APattern: TcxSchedulerEvent; const ADate: TDateTime;
      AType: TcxEventType): TcxSchedulerEvent;
    procedure Clear; virtual;
    procedure EndUpdate;
    procedure FullRefresh;
    function GetEventByID(const AID: Variant): TcxSchedulerEvent;
    function GetEvents(AList: TcxSchedulerFilteredEventList;
      const AStart, AFinish: TDateTime): Boolean; overload;
    function GetEvents(AList: TcxSchedulerFilteredEventList;
      const AStart, AFinish: TDateTime; const AResourceID: Variant): Boolean; overload;
    function IsActive: Boolean; virtual;
    function IsCaptionAvailable: Boolean; virtual;
    function IsLabelColorAvailable: Boolean; virtual;
    function IsLocationAvailable: Boolean; virtual;
    function IsMessageAvailable: Boolean; virtual;
    function IsRecurrenceAvailable: Boolean; virtual;
    function IsStateAvailable: Boolean; virtual;
    procedure PostEvents;
    procedure RemoveListener(AListener: IcxSchedulerStorageListener);
    property EventCount: Integer read GetEventCount;
    property Events[Index: Integer]: TcxSchedulerEvent read GetEvent write SetEvent;
    property FieldCount: Integer read GetFieldCount;
    property ResourceCount: Integer read GetResourceCount;
    property ResourceIDs[Index: Integer]: Variant read GetResourceID;
    property ResourceNames[Index: Integer]: string read GetResourceName;
    property Resources: TcxSchedulerStorageResources read FResources write SetResources;
    property StoringName: string read FStoringName write FStoringName;
    property Values[ARecordIndex, AFieldIndex: Integer]: Variant read GetValue write SetValue;
  published
    property StoreUsingGlobalTime: Boolean read FStoreUsingGlobalTime write SetStoreUsingGlobalTime default False;
    property ResourcesEvents: TNotifyEvent read FResourcesEvents write FResourcesEvents;
  end;

  { TcxSchedulerStorage }

  TcxSchedulerStorage = class(TcxCustomSchedulerStorage)
  private
    function GetFields: TcxSchedulerStorageFields;
    procedure SetFields(const AValue: TcxSchedulerStorageFields);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure SaveToFile(const AFileName: string);
    procedure SaveToStream(AStream: TStream); virtual;
    procedure LoadFromFile(const AFileName: string);
    procedure LoadFromStream(AStream: TStream); virtual;
  published
    property CustomFields: TcxSchedulerStorageFields read GetFields write SetFields;
    property Resources; 
    property OnEventDeleted;
    property OnEventInserted;
    property OnEventModified;
  end;

  { TcxSchedulerEventSelection }

  TcxSelectedItemData = class
  public
    ID, ParentID: Variant;
    RecurrenceIndex: Integer;
    constructor Create(AEvent: TcxSchedulerEvent);
  end;

  TcxEventSelectionChangedEvent = procedure (AEvent: TcxSchedulerControlEvent) of object;

  TcxSchedulerEventSelection = class(TcxIUnknownObject, IcxSchedulerSelectionAdapter)
  private
    FOnEventSelectionChanged: TcxEventSelectionChangedEvent;
    function GetCount: Integer;
    function GetItem(AIndex: Integer): TcxSchedulerControlEvent;
    function GetKey(AIndex: Integer): TcxSelectedItemData;
    function GetKeyCount: Integer;
  protected
    FKeys: TList;
    FEvents: TList;
    FSourceEvents: TcxSchedulerEventList;
    procedure ClearKeys;
    function CreateItem(AEvent: TcxSchedulerControlEvent): TcxSelectedItemData;
    procedure DoEventSelectionChanged(AEvent: TcxSchedulerControlEvent);
    function KeyIndexOf(AEvent: TcxSchedulerControlEvent): Integer;
    function IndexOf(AEvent: TcxSchedulerControlEvent): Integer;
    procedure InternalClear;
    procedure ReplaceSelection;

    property KeyCount: Integer read GetKeyCount;
    property Keys[Index: Integer]: TcxSelectedItemData read GetKey;
  public
    constructor Create(ASourceEvents: TcxSchedulerEventList); virtual;
    destructor Destroy; override;
    procedure Add(AEvent: TcxSchedulerControlEvent; AShift: TShiftState);
    procedure Clear;
    function IsSelected(AEvent: TcxSchedulerControlEvent): Boolean;
    procedure Update;

    property Count: Integer read GetCount;
    property Items[Index: Integer]: TcxSchedulerControlEvent read GetItem; default;
    property OnEventSelectionChanged: TcxEventSelectionChangedEvent
      read FOnEventSelectionChanged write FOnEventSelectionChanged;
  end;

  { TcxSchedulerEventList }

  TcxSchedulerEventList = class
  private
    FItems: TList;                         
    function GetCount: Integer;
    function GetFirst: TcxSchedulerEvent;
    function GetEvent(AIndex: Integer): TcxSchedulerEvent;
    function GetLast: TcxSchedulerEvent;
  protected
    procedure EventAdded(AEvent: TcxSchedulerEvent); virtual;
    procedure DoClear(AFreeItems: Boolean); virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Assign(ASource: TcxSchedulerEventList{$IFDEF DELPHI6};
       AOperator: TListAssignOp = laCopy {$ENDIF}); virtual;
    function Add(AEvent: TcxSchedulerEvent): Integer; virtual;
    procedure Clear;
    procedure Delete(AIndex: Integer);
    procedure DestroyItems;
    function Remove(AEvent: TcxSchedulerEvent): Integer;
    function IndexOf(AEvent: TcxSchedulerEvent): Integer;
    procedure Sort(ACompare: TcxCompareEventsProc); virtual;
    property Count: Integer read GetCount;
    property First: TcxSchedulerEvent read GetFirst;
    property Items[Index: Integer]: TcxSchedulerEvent read GetEvent; default;
    property Last: TcxSchedulerEvent read GetLast;
  end;

  { TcxSchedulerFilteredEventList }

  TcxSchedulerFilteredEventList = class(TcxSchedulerEventList)
  private
    FFinish: TDateTime;
    FStart: TDateTime;
    FStorage: TcxCustomSchedulerStorage;
    function GetEvent(AIndex: Integer): TcxSchedulerControlEvent;
  protected
    function AddEvent(AEvent: TcxSchedulerEvent): TcxSchedulerControlEvent;
    function AddOccurrence(ACalculator: TcxSchedulerOccurrenceCalculator): TcxSchedulerControlEvent;
    procedure Changed; virtual;
    procedure CheckEvent(AEvent: TcxSchedulerEvent; const AResourceID: Variant); virtual;
    procedure CheckRecurrenceEvent(AEvent: TcxSchedulerEvent; const AResourceID: Variant);
    procedure CheckSimpleEvent(AEvent: TcxSchedulerEvent; const AResourceID: Variant);
    function CreateControlEvent(AEvent: TcxSchedulerEvent): TcxSchedulerControlEvent; virtual;
    procedure Init(const AStart, AFinish: TDateTime; AStorage: TcxCustomSchedulerStorage); virtual;
  public
    destructor Destroy; override;
    property Finish: TDateTime read FFinish;
    property Start: TDateTime read FStart;
    property Storage: TcxCustomSchedulerStorage read FStorage;
    property Items[AIndex: Integer]: TcxSchedulerControlEvent read GetEvent; default;
    property Count;
  end;

  { TcxSchedulerCachedEventList }

  TcxSchedulerCachedEventList = class(TcxSchedulerFilteredEventList, IUnknown, IcxSchedulerSelectionAdapter)
  private
    FAbsoluteItems: TList;
    FAlwaysShowSelectedEvent: Boolean;
    FClones: TcxSchedulerFilteredEventList;
    FSelStart: TDateTime;
    FShowEventsWithoutResource: Boolean;
    FSelFinish: TDateTime;
    FSelection: TcxSchedulerEventSelection;
    FTimeBias: Double;
    FTimeZone: Integer;
    function GetAbsoluteCount: Integer;
    function GetAbsoluteItem(AIndex: Integer): TcxSchedulerControlEvent;
    function GetAbsoluteCountInternal: Integer;
    function GetAbsoluteItemInternal(AIndex: Integer): TcxSchedulerControlEvent;
    function GetItem(AIndex: Integer): TcxSchedulerControlEvent;
    // IcxSchedulerSelectionAdapter
    procedure IcxSchedulerSelectionAdapter.Add = SelectionAdd;
    procedure IcxSchedulerSelectionAdapter.Clear = SelectionClear;
    procedure IcxSchedulerSelectionAdapter.Update = SelectionUpdate;
  protected
    procedure Changed; override;
    procedure CheckEvent(AEvent: TcxSchedulerEvent; const AResourceID: Variant); override;
    function CheckEventVisibility(AEvent: TcxSchedulerEvent; AIncludeUnassigned: Boolean): Boolean;
    function CreateControlEvent(AEvent: TcxSchedulerEvent): TcxSchedulerControlEvent; override;
    function CreateCloneList: TcxSchedulerFilteredEventList; virtual;
    function CreateSelection: TcxSchedulerEventSelection; virtual;
    procedure DoClear(AFreeItems: Boolean); override;
    procedure EventAdded(AEvent: TcxSchedulerEvent); override;
    procedure Init(const AStart, AFinish: TDateTime; AStorage: TcxCustomSchedulerStorage); override;
    procedure InternalPost(AEvent: TcxSchedulerControlEvent; ACopy: Boolean);
    function IsDayNoneEmpty(ADay: Integer): Boolean;
    function IsSelected(AEvent: TcxSchedulerControlEvent): Boolean; virtual;
    procedure PostCloneForRecurrenceEvent(AEvent: TcxSchedulerControlEvent; ACopy: Boolean); virtual;
    procedure PostCloneForSimpleEvent(AEvent: TcxSchedulerControlEvent;
      ACopy: Boolean; AType: TcxEventType); virtual;
    procedure SelectionAdd(AEvent: TcxSchedulerControlEvent; Shift: TShiftState); virtual;
    procedure SelectionClear; virtual;
    procedure SelectionUpdate; virtual;
    // IUnknown
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;
 public
    constructor Create; override;
    destructor Destroy; override;
    procedure CancelClones;
    function CreateClones: TcxSchedulerEventList;
    procedure ExtractEvents(const ADate: TDateTime; AList: TcxSchedulerEventList);
    procedure ExtractUsedDays(AList: TcxSchedulerDateList);
    procedure PostClones(ACopy: Boolean);
    procedure PostEvent(AEvent: TcxSchedulerControlEvent);
    procedure Sort(ACompare: TcxCompareEventsProc); override;
    property AbsoluteCount: Integer read GetAbsoluteCount;
    property AbsoluteItems[Index: Integer]: TcxSchedulerControlEvent read GetAbsoluteItem;
    property AlwaysShowSelectedEvent: Boolean read FAlwaysShowSelectedEvent write FAlwaysShowSelectedEvent;
    property TimeZone: Integer read FTimeZone write FTimeZone;
    property Clones: TcxSchedulerFilteredEventList read FClones;
    property ShowEventsWithoutResource: Boolean read FShowEventsWithoutResource write FShowEventsWithoutResource;
    property SelStart: TDateTime read FSelStart write FSelStart;
    property SelFinish: TDateTime read FSelFinish write FSelFinish;
    property Selection: TcxSchedulerEventSelection read FSelection;
    property Items[Index: Integer]: TcxSchedulerControlEvent read GetItem; default;
  end;

  { TcxSchedulerOccuranceCalculator }

  TcxSchedulerOccurrenceCalculator = class
  protected
    FDate: Integer;
    FDay: Word;
    FDayNumber: Integer;
    FDayType: TcxDayType;
    FEvent: TcxSchedulerEvent;
    FFinishDate: TDateTime;
    FIndex: Integer;
    FMonth: Word;
    FOccurDays: TDays;
    FOccurrenceFinish: TDateTime;
    FOccurrenceStart: TDateTime;
    FPeriodicity: Integer;
    FRecurCount: Integer;
    FRecurrence: TcxRecurrence;
    FStartOfWeek: Integer;
    FVisibleFinish: TDateTime;
    FVisibleStart: TDateTime;
    FWeekStart: Integer;
    FWorkDays: TDays;
    FYear: Word;
    FYearPeriodicity: Integer;
    procedure CalcFirstDate;
    procedure CalcNextDate;
    function GetCertainDay(const ADate, ANumber: Integer; ADayType: TcxDayType): Integer;
    function GetDayForMonth: Integer; virtual;
    function GetDayFromOccurDays(const APrevDate, APeriodicity: Integer): Integer;
    function GetSomeDay(const ADate, ANumber: Integer; AWeekEnd: Boolean): Integer;
    function IsValidOccurrence: Boolean;
  public
    constructor Create(AEvent: TcxSchedulerEvent; const AStart, AFinish: TDateTime);
    procedure CalcOccurrence(AIndex: Integer);
    function GetNextOccurrence: Boolean; virtual;
    function GetOccurrenceCount(AEndDate: TDateTime): Integer;
    property Event: TcxSchedulerEvent read FEvent;
    property Index: Integer read FIndex;
    property OccurrenceFinish: TDateTime read FOccurrenceFinish;
    property OccurrenceStart: TDateTime read FOccurrenceStart;
    property StartOfWeek: Integer read FStartOfWeek;
    property VisibleFinish: TDateTime read FVisibleFinish;
    property VisibleStart: TDateTime read FVisibleStart;
    property WorkDays: TDays read FWorkDays write FWorkDays;
  end;

procedure cxCheckDaysList(AList: TList; var AStartDay, AFinishDay: Integer);
function cxGetRecurrenceDescriptionString(ARecurrenceInfo: TcxSchedulerEventRecurrenceInfo): string;
function cxRecurrenceInfoDataToString(const AData: TcxSchedulerEventRecurrenceInfoData): string;
function cxStringToRecurrenceInfoData(const S: string): TcxSchedulerEventRecurrenceInfoData;

const
  // Options flag masks
  omAllDayEvent = $0001;
  omEnabled     = $0002;
  omReminder    = $0004;

  // Time line state
  tlsFree        = 0;
  tlsTentative   = 1;
  tlsBusy        = 2;
  tlsOutOfOffice = 3;

  cxDefaultEventDuration: TDateTime = 0.0034722222222;
  cxMaxDate = 767010; //Dec 31 3999
  cxGetRecurrenceDescriptionStringProc: TcxGetRecurrenceDescriptionStringProc =
    cxGetRecurrenceDescriptionString;

implementation

uses
  cxSchedulerStrs;

const
  cxInvalidRecordIndex = -MaxInt;

  DefInfoData: TcxSchedulerEventRecurrenceInfoData =
    (Count: 10; DayNumber: 1; DayType: cxdtDay;  Finish: -1;
     OccurDays: []; Periodicity: 1; Recurrence: cxreDaily;
     Start: 0; YearPeriodicity: 1);

  PatternValidStatus: array[Boolean] of TcxRecurrenceValidStatus =
    (rvsInvalidPattern, rvsValid);

function cxCompareEventsByID(AEvent1, AEvent2: TcxSchedulerEvent): Integer;
begin
  Result := VarCompare(AEvent1.FSavedID, AEvent2.FSavedID);
end;

function cxIntSortProc(P1, P2: Pointer): Integer;
begin
  Result := Integer(P1) - Integer(P2);
end;

function cxCompareSelectionKeys(AItem1, AItem2: TcxSelectedItemData): Integer;
begin
  Result := VarCompare(AItem1.ID, AItem2.ID);
  if Result = 0 then
    Result := VarCompare(AItem1.ParentID, AItem2.ParentID);
  if Result = 0 then
    Result := AItem1.RecurrenceIndex - AItem2.RecurrenceIndex;
end;

procedure cxCheckDaysList(AList: TList; var AStartDay, AFinishDay: Integer);
begin
  AList.Sort(cxIntSortProc);
  AStartDay := Integer(AList[0]);
  AFinishDay := Integer(AList[AList.Count - 1]);
end;

function cxGetRecurrenceDescriptionString(ARecurrenceInfo: TcxSchedulerEventRecurrenceInfo): string;
const
  Weeks: array[1..5] of string = ('first', 'second', 'third', 'fourth', 'last');
  Days: array[cxdtEveryDay..cxdtWeekEndDay] of string = ('day', 'weekday', 'weekend day');
  EveryDays: array[Boolean] of string = ('every %d days', 'every day');
  EveryMonths1: array[Boolean] of string = ('day %d of every %d months', 'day %d of every month');
  EveryMonths2: array[Boolean] of string = ('the %s %s of every %d months', 'the %s %s of every month');

  procedure GetDateParts(out ADayStr, AWeekStr: string);
  begin
    with ARecurrenceInfo do
    begin
      if DayNumber in [1..5] then AWeekStr := Weeks[DayNumber] else AWeekStr := '';
      if DayType in [cxdtEveryDay..cxdtWeekEndDay] then
        ADayStr := Days[DayType]
      else
        ADayStr := LongDayNames[Ord(DayType) - Ord(cxdtSunday) + 1];
    end;
  end;

  function OccurDaysToString: string;
  var
    ADay: TDay;
    ACount, ASaveCount: Integer;
  begin
    Result := '';
    ACount := 0;
    for ADay := Low(TDay) to High(TDay) do
      if ADay in ARecurrenceInfo.OccurDays then Inc(ACount);
    ASaveCount := ACount;
    for ADay := Low(TDay) to High(TDay) do
      if ADay in ARecurrenceInfo.OccurDays then
        if ASaveCount = 1 then
        begin
          Result := LongDayNames[Ord(ADay) + 1];
          Exit;
        end
        else
        begin
          Dec(ACount);
          if ACount > 1 then
            Result := Result + LongDayNames[Ord(ADay) + 1] + ', '
          else if ACount = 1 then
            Result := Result + LongDayNames[Ord(ADay) + 1] + ' '
          else
            Result := Result + 'and ' + LongDayNames[Ord(ADay) + 1];
        end;
  end;

var
  ADayStr, AWeekStr, AMonthStr: string;
begin
  Result := '';
  if not Assigned(ARecurrenceInfo) or not ARecurrenceInfo.Event.IsRecurring then Exit;
  with ARecurrenceInfo do
  begin
    case Recurrence of
      cxreDaily:
        if DayType = cxdtWeekDay then
          Result := 'every weekday'
        else
          Result := Format(EveryDays[Periodicity = 1], [Periodicity]);
      cxreWeekly:
        if Periodicity = 1 then
          Result := 'every ' + OccurDaysToString
        else
          Result := Format('every %d weeks on %s', [Periodicity, OccurDaysToString]);
      cxreMonthly:
        if DayType = cxdtDay then
          Result := Format(EveryMonths1[Periodicity = 1], [DayNumber, Periodicity])
        else
        begin
          GetDateParts(ADayStr, AWeekStr);
          Result := Format(EveryMonths2[Periodicity = 1], [AWeekStr, ADayStr, Periodicity]);
        end;
      cxreYearly:
        begin
          if Periodicity in [1..12] then
            AMonthStr := LongMonthNames[Periodicity]
          else
            AMonthStr := '';
          if DayType = cxdtDay then
            Result := Format('every %s %d', [AMonthStr, DayNumber])
          else
          begin
            GetDateParts(ADayStr, AWeekStr);
            Result := Format('the %s %s of %s', [AWeekStr, ADayStr, AMonthStr]);
          end;
        end;
    end;
    Result := Result + ' from ' + FormatDateTime('t', Event.Pattern.Start) +
      ' to ' + FormatDateTime('t', Event.Pattern.Finish);
  end;
end;

function cxRecurrenceInfoDataToString(const AData: TcxSchedulerEventRecurrenceInfoData): string;
begin
  SetLength(Result, SizeOf(AData));
  Move(AData, Result[1], SizeOf(AData));
end;

function cxStringToRecurrenceInfoData(const S: string): TcxSchedulerEventRecurrenceInfoData;
begin
  if Length(S) = SizeOf(TcxSchedulerEventRecurrenceInfoData) then
    Move(S[1], Result, SizeOf(TcxSchedulerEventRecurrenceInfoData))
  else
    Result := DefInfoData;
end;

function cxFindEvent(AList: TList; const ID: Variant; var AEvent: TcxSchedulerEvent): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  L := 0;
  H := AList.Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    AEvent := TcxSchedulerEvent(AList.List^[I]);
    C := VarCompare(AEvent.FSavedID, ID);
    if C < 0 then
      L := I + 1
    else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        AList.Delete(I);
        Break;
      end;
    end;
  end;
end;

{ TcxSchedulerStorageDataController }

function TcxSchedulerStorageDataController.GetItem(Index: Integer): TObject;
begin
  Result := Storage.FFields.List^[Index];
end;

function TcxSchedulerStorageDataController.GetItemValueSource(
  AItemIndex: Integer): TcxDataEditValueSource;
begin
  Result := evsValue;
end;

function TcxSchedulerStorageDataController.GetItemID(AItem: TObject): Integer;
begin
  if AItem is TcxCustomSchedulerStorageField then
    Result := TcxCustomSchedulerStorageField(AItem).FIndex
  else
    Result := -1;
end;

procedure TcxSchedulerStorageDataController.UpdateData;
begin
  Storage.UpdateData;
end;

procedure TcxSchedulerStorageDataController.UpdateItemIndexes;
begin
  Storage.UpdateItemIndexes;
  inherited UpdateItemIndexes;
end;

procedure TcxSchedulerStorageDataController.UpdateControl(
  AInfo: TcxUpdateControlInfo);
begin
  Storage.UpdateControl(AInfo);
end;

function TcxSchedulerStorageDataController.UseRecordID: Boolean;
begin
  Result := True;
end;

function TcxSchedulerStorageDataController.GetStorage: TcxCustomSchedulerStorage;
begin
  Result := TcxCustomSchedulerStorage(GetOwner)
end;

{ TcxCustomSchedulerStorageField }

constructor TcxCustomSchedulerStorageField.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  Storage.ItemAdded(Self);
  ValueTypeClass := TcxStringValueType;
end;

destructor TcxCustomSchedulerStorageField.Destroy;
var
  AStorage: TcxCustomSchedulerStorage;
begin
  AStorage := Storage;
  Collection := nil;
  AStorage.ItemRemoved(Self);
  inherited Destroy;
end;

procedure TcxCustomSchedulerStorageField.Assign(Source: TPersistent);
begin
  if Source is TcxCustomSchedulerStorageField then
    ValueTypeClass := TcxCustomSchedulerStorageField(Source).ValueTypeClass
  else
    inherited Assign(Source);
end;

function TcxCustomSchedulerStorageField.GetDisplayName: string;
begin
  Result := FName;
  if Result = '' then
    Result := inherited GetDisplayName; 
end;

function TcxCustomSchedulerStorageField.IsValueTypeStored: Boolean;
begin
  Result := ValueTypeClass <> TcxStringValueType;
end;

function TcxCustomSchedulerStorageField.GetDataController: TcxCustomDataController;
begin
  Result := Storage.DataController;
end;

function TcxCustomSchedulerStorageField.GetStorage: TcxCustomSchedulerStorage;
begin
  Result := TcxCustomSchedulerStorageFields(Collection).Storage;
end;

function TcxCustomSchedulerStorageField.GetValue(
  AIndex: Integer): Variant;
begin
  Result := Storage.Values[AIndex, FIndex];
end;

function TcxCustomSchedulerStorageField.GetValueCount: Integer;
begin
  Result := Storage.EventCount;
end;

function TcxCustomSchedulerStorageField.GetValueType: string;
begin
  if ValueTypeClass = nil then
    Result := ''
  else
    Result := ValueTypeClass.Caption;
end;

function TcxCustomSchedulerStorageField.GetValueTypeClass: TcxValueTypeClass;
begin
  Result := Storage.DataController.GetItemValueTypeClass(Index);
end;

procedure TcxCustomSchedulerStorageField.SetName(
  const AValue: string);
begin
  if FName <> AValue then
  begin
    FName := AValue;
    Changed(True);
  end;
end;

procedure TcxCustomSchedulerStorageField.SetValue(
  AIndex: Integer; const AValue: Variant);
begin
  Storage.Values[AIndex, FIndex] := AValue;
end;

procedure TcxCustomSchedulerStorageField.SetValueType(
  const AValue: string);
begin
  if ValueType <> AValue then
    ValueTypeClass := cxValueTypeClassList.ItemByCaption(AValue);
end;

procedure TcxCustomSchedulerStorageField.SetValueTypeClass(
  AValue: TcxValueTypeClass);
begin
  Storage.DataController.ChangeValueTypeClass(Index, AValue);
end;

{ TcxCustomSchedulerStorageFields }

function TcxCustomSchedulerStorageFields.FindFieldByName(const AName: string): TcxCustomSchedulerStorageField;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := TcxCustomSchedulerStorageField(inherited Items[I]);
    if AnsiSameText(AName, Result.Name) then Exit;
  end;
  Result := nil;
end;

function TcxCustomSchedulerStorageFields.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TcxCustomSchedulerStorageFields.Update(Item: TCollectionItem);
begin
  inherited Update(Item);
  Storage.Changed;
end;

function TcxCustomSchedulerStorageFields.GetStorage: TcxCustomSchedulerStorage;
begin
  Result := TcxCustomSchedulerStorage(GetOwner);
end;

{ TcxSchedulerStorageFields }

function TcxSchedulerStorageFields.Add: TcxSchedulerStorageField;
begin
  Result := TcxSchedulerStorageField(inherited Add);
end;

function TcxSchedulerStorageFields.ItemByName(
  const AName: string): TcxSchedulerStorageField;
begin
  Result := TcxSchedulerStorageField(FindFieldByName(AName));
end;

function TcxSchedulerStorageFields.GetItem(
  AIndex: Integer): TcxSchedulerStorageField;
begin
  Result := TcxSchedulerStorageField(inherited Items[AIndex]);
end;

procedure TcxSchedulerStorageFields.SetItem(
  AIndex: Integer; AValue: TcxSchedulerStorageField);
begin
  inherited Items[AIndex].Assign(AValue);
end;

{ TcxSchedulerEventRecurrenceInfo }

constructor TcxSchedulerEventRecurrenceInfo.Create(
  AOwner: TcxSchedulerEvent);
begin
  FOwner := AOwner;
end;

procedure TcxSchedulerEventRecurrenceInfo.Assign(Source: TPersistent);
var
  S: string;
begin
  if Source is TcxSchedulerEventRecurrenceInfo then
  begin
    if GetValue(S) then
      SetValue(S)
    else
      SetValue('');
  end
  else
    inherited Assign(Source);
end;

function TcxSchedulerEventRecurrenceInfo.GetValidStatus: TcxRecurrenceValidStatus;

  function IntersectOccurrences(APrevFinish, AStart: TDateTime): Boolean;
  begin
    if FOwner.AllDayEvent then
      Result := DateOf(AStart) < DateOf(APrevFinish)
    else
      Result := DateOf(AStart) <= DateOf(APrevFinish);
  end;

var
  AFinish: TDateTime;
begin
  if not FOwner.IsRecurring then
  begin
    Result := rvsValid;
    Exit;
  end;
  case Recurrence of
    cxreDaily: Result := GetDailyPatternStatus;
    cxreWeekly: Result := GetWeeklyPatternStatus;
    cxreMonthly: Result := GetMonthlyPatternStatus;
    else Result := GetYearlyPatternStatus;
  end;
  if Result = rvsInvalidPattern then Exit;
  with TcxSchedulerOccurrenceCalculator.Create(FOwner,
    FOwner.RecurrenceInfo.Start, cxMaxDate) do
  try
    // find a first occurrence
    if GetNextOccurrence then
    begin
      AFinish := OccurrenceFinish;
      if not (FOwner.RecurrenceInfo.Count in [0, 1]) then
      begin
        if not GetNextOccurrence then
        begin
          Result := rvsInvalidDuration;
          Exit;
        end;
      end;
      if (Index > 0) and IntersectOccurrences(AFinish, OccurrenceStart) then
        Result := rvsInvalidDuration;
    end
    else
      Result := rvsInvalidDuration;
  finally
    Free;
  end;
end;

procedure TcxSchedulerEventRecurrenceInfo.Validate;
begin
  with TcxSchedulerOccurrenceCalculator.Create(FOwner,
    FOwner.RecurrenceInfo.Start, cxMaxDate) do
  try
    if GetNextOccurrence then
      FOwner.MoveTo(OccurrenceStart)
    else
      cxSchedulerError(cxGetResourceString(@scxWrongPattern));
  finally
    Free;
  end;
end;

procedure TcxSchedulerEventRecurrenceInfo.AssignDefaultValues;
begin
  Count := -1;
  DayNumber := 1;
  DayType := cxdtDay;
  Finish := -1;
  OccurDays := [TDay(DayOfWeek(Event.Start) - 1)];
  Periodicity := 1;
  Recurrence := cxreWeekly;
  YearPeriodicity := 1;
end;

function TcxSchedulerEventRecurrenceInfo.GetData: TcxSchedulerEventRecurrenceInfoData;
var
  S: string;
begin
  if GetValue(S) then
    Result := cxStringToRecurrenceInfoData(S)
  else
    Result := DefInfoData;
end;

function TcxSchedulerEventRecurrenceInfo.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TcxSchedulerEventRecurrenceInfo.GetValue(
  var AValue: string): Boolean;
begin
  Result := FOwner.GetRecurrenceInfoValue(AValue);
end;

procedure TcxSchedulerEventRecurrenceInfo.SetDataItem(
  AOffset: Pointer; ASize: Integer; const AValue);
var
  S: string;
begin
  Dec(Integer(AOffset), Integer(@DefInfoData));
  if not GetValue(S) then
    S := cxRecurrenceInfoDataToString(DefInfoData);
  Move(AValue, S[1 + Integer(AOffset)], ASize);
  SetValue(S);
end;

procedure TcxSchedulerEventRecurrenceInfo.SetValue(
  const AValue: string);
begin
  FOwner.SetRecurrenceInfoValue(AValue);
end;

function TcxSchedulerEventRecurrenceInfo.GetDailyPatternStatus: TcxRecurrenceValidStatus;
begin
  if DayType = cxdtEveryDay then
    Result := PatternValidStatus[Periodicity > 0]
  else
    Result := PatternValidStatus[(DayType = cxdtWeekDay) and (Periodicity = 1)]
end;

function TcxSchedulerEventRecurrenceInfo.GetMonthlyPatternStatus: TcxRecurrenceValidStatus;
begin
  if DayType = cxdtDay then
  begin
    Result := PatternValidStatus[(Periodicity > 0) and (DayNumber in [1..31])];
    if (Result = rvsValid) and (DayNumber in [29..31]) then
      Result := rvsReplaceOccurrenceDate;
  end
  else
    Result := PatternValidStatus[Periodicity > 0];
end;

function TcxSchedulerEventRecurrenceInfo.GetWeeklyPatternStatus: TcxRecurrenceValidStatus;
begin
  Result := PatternValidStatus[(Periodicity > 0) and (OccurDays <> [])]
end;

function TcxSchedulerEventRecurrenceInfo.GetYearlyPatternStatus: TcxRecurrenceValidStatus;
begin
  if DayType = cxdtDay then
    Result := PatternValidStatus[(Periodicity in [1..12]) and
      (DayNumber >=1) and (DayNumber <= DaysPerMonth(2000, Periodicity))]
  else
    Result := PatternValidStatus[(Periodicity in [1..12])];
end;

function TcxSchedulerEventRecurrenceInfo.GetCount: Integer;
begin
  Result := GetData.Count;
end;

function TcxSchedulerEventRecurrenceInfo.GetDayNumber: Integer;
begin
  Result := GetData.DayNumber;
end;

function TcxSchedulerEventRecurrenceInfo.GetDayType: TcxDayType;
begin
  Result := GetData.DayType;
end;

function TcxSchedulerEventRecurrenceInfo.GetFinish: TDateTime;
begin
  Result := GetData.Finish - FOwner.TimeBias;
end;

function TcxSchedulerEventRecurrenceInfo.GetOccurDays: TDays;
begin
  Result := GetData.OccurDays;
end;

function TcxSchedulerEventRecurrenceInfo.GetPeriodicity: Integer;
begin
  Result := GetData.Periodicity;
end;

function TcxSchedulerEventRecurrenceInfo.GetRecurrence: TcxRecurrence;
begin
  Result := GetData.Recurrence;
end;

function TcxSchedulerEventRecurrenceInfo.GetStart: TDateTime;
begin
  Result := DateOf(FOwner.Start);
end;

function TcxSchedulerEventRecurrenceInfo.GetStorage: TcxCustomSchedulerStorage;
begin
  Result := FOwner.Storage; 
end;

function TcxSchedulerEventRecurrenceInfo.GetYearPeriodicity: Integer;
begin
  Result := GetData.YearPeriodicity;
end;

procedure TcxSchedulerEventRecurrenceInfo.SetCount(
  const AValue: Integer);
begin
  SetDataItem(@DefInfoData.Count, SizeOf(Integer), AValue);;
end;

procedure TcxSchedulerEventRecurrenceInfo.SetDayNumber(
  const AValue: Integer);
begin
  SetDataItem(@DefInfoData.DayNumber, SizeOf(Integer), AValue);;
end;

procedure TcxSchedulerEventRecurrenceInfo.SetDayType(
  const AValue: TcxDayType);
begin
  SetDataItem(@DefInfoData.DayType, SizeOf(TcxDayType), AValue);;
end;

procedure TcxSchedulerEventRecurrenceInfo.SetFinish(
  AValue: TDateTime);
begin
  AValue := TcxSchedulerDateTimeHelper.RoundTime(AValue) + FOwner.TimeBias;
  SetDataItem(@DefInfoData.Finish, SizeOf(AValue), AValue);
end;

procedure TcxSchedulerEventRecurrenceInfo.SetOccurDays(
  const AValue: TDays);
begin
  SetDataItem(@DefInfoData.OccurDays, SizeOf(TDays), AValue);;
end;

procedure TcxSchedulerEventRecurrenceInfo.SetPeriodicity(
  const AValue: Integer);
begin
  SetDataItem(@DefInfoData.Periodicity, SizeOf(Integer), AValue);
end;

procedure TcxSchedulerEventRecurrenceInfo.SetRecurrence(
  const AValue: TcxRecurrence);
begin
  SetDataItem(@DefInfoData.Recurrence, SizeOf(TcxRecurrence), AValue);
end;

procedure TcxSchedulerEventRecurrenceInfo.SetStart(
  const AValue: TDateTime);
begin
  FOwner.MoveTo(AValue);
end;

procedure TcxSchedulerEventRecurrenceInfo.SetYearPeriodicity(
  const AValue: Integer);
begin
  SetDataItem(@DefInfoData.YearPeriodicity, SizeOf(Integer), AValue);
end;

{ TcxSchedulerEvent }

constructor TcxSchedulerEvent.Create(
  AStorage: TcxCustomSchedulerStorage);
begin
  Create(AStorage, -1);
  BeginEditing;
  AssignDefaultValues;
end;

constructor TcxSchedulerEvent.Create(
  AStorage: TcxCustomSchedulerStorage; ARecordIndex: Integer);
begin
  FStorage := AStorage;
  FRecordIndex := ARecordIndex;
  FRecurrenceInfo := CreateRecurrenceInfo;
  FRecurrenceInfo.FOwner := Self;
end;

destructor TcxSchedulerEvent.Destroy;
begin
  FStorage.DoDestroyEvent(Self);
  FRecurrenceInfo.Free;
  inherited Destroy;
end;

procedure TcxSchedulerEvent.Assign(Source: TPersistent);
var
  I: Integer;
begin
  if Source is TcxSchedulerEvent then
  begin
    BeginEditing;
    FSkipModified := True;
    try
      for I := 0 to ValueCount - 1 do
        SetValueByIndex(I, TcxSchedulerEvent(Source).GetValueByIndex(I));
      Start := TcxSchedulerEvent(Source).Start;
      Finish := TcxSchedulerEvent(Source).Finish;
    finally
      FIsDataValid := False;
      EndEditing;
      FSkipModified := False;
    end;
  end;
end;

procedure TcxSchedulerEvent.BeginEditing;
var
  I: Integer;
begin
  if not IsEditing then
  begin
    SetLength(FEditValues, ValueCount);
    for I := 0 to ValueCount - 1 do
      FEditValues[I] := GetValueByIndex(I);
  end;
  Inc(FEditCount);
end;

procedure TcxSchedulerEvent.Cancel;
begin
  IsModified := False;
  if FEditCount = 1 then
  begin
    Dec(FEditCount);
    if FEditCount = 0 then
      SetLength(FEditValues, 0);
    Storage.CancelEvent(Self);
  end;
end;

procedure TcxSchedulerEvent.EndEditing;
begin
  if FEditCount = 0 then Exit;
  try
    if (FEditCount = 1) and not IsNewEvent then
      PostEditingData;
  finally
    Dec(FEditCount);
    if FEditCount = 0 then
      SetLength(FEditValues, 0);
  end;
end;

procedure TcxSchedulerEvent.Delete;
begin
  if Self = nil then Exit;
  case EventType of
    etCustom:
      EventType := etException;
    etOccurrence:
      begin
        Storage.BeginUpdate;
        try
          with Storage.CreateEvent do
          begin
            Assign(Self);
            ParentID := Self.ID;
            EventType := etException;
          end;
        finally
          Storage.EndUpdate;
        end;
      end;
  else
    Storage.DoDeleteEvent(RecordIndex);
  end;
end;

procedure TcxSchedulerEvent.DeleteExceptions;
begin
  if not HasExceptions then Exit;
  Storage.BeginUpdate;
  try
    while FLink <> nil do
    begin
      Storage.DoDeleteEvent(FLink.RecordIndex);
      FLink := FLink.FLink
    end;
  finally
    Storage.EndUpdate;
  end;
end;

function TcxSchedulerEvent.HasExceptions: Boolean;
begin
  Result := (EventType = etPattern) and (Link <> nil);
end;

function TcxSchedulerEvent.GetCustomFieldValueByIndex(AIndex: Integer): Variant;
begin
  Result := GetValueByIndex(TcxCustomSchedulerStorageField(Storage.Fields.Items[AIndex]).Index);
end;

function TcxSchedulerEvent.GetCustomFieldValueByName(
  const AName: String): Variant;
var
  AField: TcxCustomSchedulerStorageField;
begin
  AField := Storage.Fields.FindFieldByName(AName);
  if AField <> nil then
    Result := GetValueByIndex(AField.Index)
  else
    cxSchedulerError(scxInvalidFieldName);
end;

function TcxSchedulerEvent.GetCustomFieldValue(
  ACustomField: TcxCustomSchedulerStorageField): Variant;
begin
  if (ACustomField <> nil) and (ACustomField.Storage = Storage) then
    Result := GetValueByIndex(ACustomField.Index)
  else
    cxSchedulerError(scxInvalidCustomField);
end;

procedure TcxSchedulerEvent.SetCustomFieldValueByIndex(AIndex: Integer;
  const AValue: Variant);
begin
  SetValueByIndex(TcxCustomSchedulerStorageField(Storage.Fields.Items[AIndex]).Index, AValue);
end;

procedure TcxSchedulerEvent.SetCustomFieldValueByName(const AName: string;
  const AValue: Variant);
var
  AField: TcxCustomSchedulerStorageField;
begin
  AField := Storage.Fields.FindFieldByName(AName);
  if AField <> nil then
    SetValueByIndex(AField.Index, AValue)
  else
    cxSchedulerError(scxInvalidFieldName);
end;

procedure TcxSchedulerEvent.SetCustomFieldValue(
  ACustomField: TcxCustomSchedulerStorageField; const AValue: Variant);
begin
  if (ACustomField <> nil) and (ACustomField.Storage = Storage) then
    SetValueByIndex(ACustomField.Index, AValue)
  else
    cxSchedulerError(scxInvalidCustomField);
end;

function TcxSchedulerEvent.GetResourceItem: TcxSchedulerStorageResourceItem;
var
  I: Integer;
begin
  for I := 0 to Storage.ResourceCount - 1 do
  begin
    Result := Storage.Resources.ResourceItems[I];
    if IsResourceEvent(Result, False) then
      Exit;
  end;
  Result := nil;
end;

function TcxSchedulerEvent.GetRecurrenceChain: TcxSchedulerEventList;
var
  ALink: TcxSchedulerEvent;
begin
  Result := TcxSchedulerEventList.Create;
  if EventType = etPattern then
  begin
    ALink := Link;
    while ALink <> nil do
    begin
      Result.Add(ALink);
      ALink := ALink.Link;
    end;
  end;
end;

function TcxSchedulerEvent.IsDayEvent(ADate: TDateTime): Boolean;
begin
  Result := False;
  if not FIsDataValid then
    UpdateTemporaryData;
  ADate := DateOf(ADate);
  if FFinish > ADate then
    Result := (DateOf(FStart) <= ADate)
  else
    if FFinish = ADate then
      Result := DateOf(FStart) = ADate;
end;

function TcxSchedulerEvent.IsRecurring: Boolean;
begin
  Result := EventType in [etPattern..etCustom];
end;

function TcxSchedulerEvent.IsResourceEvent(
  AResource: TcxSchedulerStorageResourceItem; AllowUnassigned: Boolean): Boolean;
begin
  Result := (AResource = nil) or (AllowUnassigned and VarIsNull(ResourceID)) or
    (VarCompare(AResource.ResourceID, ResourceID) = 0);
end;

procedure TcxSchedulerEvent.MoveTo(const AStartTime: TDateTime);
var
  ADuration: Double;
begin
  BeginEditing;
  try
    ADuration := Duration;
    Start := AStartTime;
    Duration := ADuration;  
  finally
    EndEditing;
  end;
end;

procedure TcxSchedulerEvent.Post;
begin
  if (FEditCount = 1) and IsNewEvent then
    FStorage.PostEvent(Self);
end;

procedure TcxSchedulerEvent.AssignDefaultValues;
begin
  AllDayEvent := False;
  Caption := '';
  Enabled := True;
  EventType := etNone;
  LabelColor := clDefault;
  Location := '';
  Message := '';
  RecurrenceIndex := -1;
  Reminder := False;  //not implemented yet
  ReminderTime := 15; //not implemented yet
  Start := Now;
  Finish := Start + cxDefaultEventDuration;
  State := tlsBusy;
  RecurrenceInfo.AssignDefaultValues;
end;

procedure TcxSchedulerEvent.CheckRecurrenceLink(AEvent: TcxSchedulerEvent);
begin
  if (AEvent.EventType in [etCustom, etException]) and VarEquals(ID, AEvent.ParentID) then
  begin
    AEvent.FPattern := Self;
    AEvent.FLink := FLink;
    FLink := AEvent;
  end;
end;

function TcxSchedulerEvent.CreateRecurrenceInfo: TcxSchedulerEventRecurrenceInfo;
begin
  Result := TcxSchedulerEventRecurrenceInfo.Create(Self);
end;

function TcxSchedulerEvent.GetOccurrenceByIndex(
  AIndex: Integer; var AOccurrence: TcxSchedulerEvent): Boolean;
begin
  Result := False;
  if FLink = nil then Exit;
  AOccurrence := FLink;
  while (AOccurrence <> nil) and (AOccurrence.RecurrenceIndex <> AIndex) do
    AOccurrence := AOccurrence.FLink;
  Result := (AOccurrence <> nil) and (AOccurrence.RecurrenceIndex = AIndex);
end;

function TcxSchedulerEvent.GetOwner: TPersistent;
begin
  Result := FStorage;
end;

function TcxSchedulerEvent.GetRecurrenceInfoValue(
  var AValue: string): Boolean;
begin
  AValue := GetValueDef(FStorage.FRecurrenceInfoField, '');
  Result := AValue <> '';
end;

function TcxSchedulerEvent.GetValueByIndex(AIndex: Integer): Variant;
begin
  if FRecordIndex = cxInvalidRecordIndex then
    Result := Null
  else
    Result := FStorage.GetValue(RecordIndex, AIndex);
end;

function TcxSchedulerEvent.GetValueDef(
  AField: TcxCustomSchedulerStorageField; const ADefValue: Variant): Variant;
begin
  if not IsEditing then
    Result := GetValueByIndex(AField.Index)
  else
    Result := FEditValues[AField.Index];
  if VarType(Result) in [varNull, varEmpty] then
    Result := ADefValue;
end;

procedure TcxSchedulerEvent.Modified;
begin
  FIsModified := True;
end;

procedure TcxSchedulerEvent.PostEditingData;
var
  ACount: Integer; 
begin
  ACount := Storage.DataController.RecordCount;
  if IsModified then
  begin
    Storage.BeginUpdate;
    try
      FStorage.PostEditingData(Self);
    finally
      Storage.EndUpdate;
    end;
  end;
  if Storage.DataController.RecordCount < ACount then
    FRecordIndex := cxInvalidRecordIndex;  
end;

procedure TcxSchedulerEvent.SetRecordIndex(
  const AIndex: Integer);
begin
  if AIndex <> -1 then
    FSavedID := FStorage.DataController.GetRecordID(AIndex)
  else
    FSavedID := Null;
  FIsDataValid := False;
  FRecordIndex := AIndex;
  FLink := nil;
end;

procedure TcxSchedulerEvent.SetRecurrenceInfoValue(
  const AValue: string);
begin
  SetValue(FStorage.FRecurrenceInfoField, AValue);
end;

procedure TcxSchedulerEvent.SetValue(
  AField: TcxCustomSchedulerStorageField; const AValue: Variant);
begin
  SetValueByIndex(AField.Index, AValue);
end;

procedure TcxSchedulerEvent.SetValueByIndex(
  AIndex: Integer; const AValue: Variant);
begin
  if (FRecordIndex = cxInvalidRecordIndex) or
    (IsEditing and VarEquals(FEditValues[AIndex], AValue)) or
     VarEquals(GetValueByIndex(AIndex), AValue) then Exit;
  Modified;
  BeginEditing;
  try
    FEditValues[AIndex] := AValue
  finally
    EndEditing;
  end;
end;

function TcxSchedulerEvent.TimeBias: Double;
begin
  Result := Storage.TimeBias;
end;

procedure TcxSchedulerEvent.UpdateTemporaryData;
begin
  FStart := TDateTime(GetValueDef(FStorage.FStartField, 0)) - TimeBias;
  FFinish := TDateTime(GetValueDef(FStorage.FFinishField, 0)) - TimeBias;
  FOptions := GetValueDef(FStorage.FOptionsField, 0);
  FIsDataValid := True;
end;

function TcxSchedulerEvent.GetAllDayEvent: Boolean;
begin
  Result := (GetOptionsFlag and omAllDayEvent) <> 0;
end;

function TcxSchedulerEvent.GetCaption: string;
begin
  Result := GetValueDef(FStorage.FCaptionField, '');
end;

function TcxSchedulerEvent.GetDuration: TDateTime;
begin
  Result := TcxSchedulerDateTimeHelper.RoundTime(Finish - Start);
end;

function TcxSchedulerEvent.GetEditValue(AIndex: Integer): Variant;
begin
  if IsEditing then
    Result := FEditValues[AIndex]
  else
    Result := Null;
end;

function TcxSchedulerEvent.GetEnabled: Boolean;
begin
  Result := (GetOptionsFlag and omEnabled) <> 0;
end;

function TcxSchedulerEvent.GetEventType: TcxEventType;
begin
  Result := GetValueDef(FStorage.FEventTypeField, etNone);
end;

function TcxSchedulerEvent.GetFinish: TDateTime;
begin
  if not FIsDataValid then
    UpdateTemporaryData;
  Result := FFinish;
end;

function TcxSchedulerEvent.GetID: Variant;
begin
  Result := FStorage.GetRecordId(RecordIndex);
end;

function TcxSchedulerEvent.GetIsNewEvent: Boolean;
begin
  Result := (FRecordIndex = -1) and
    (FStorage.FNewEvents.IndexOf(Self) <> - 1);
end;

function TcxSchedulerEvent.GetIsEditing: Boolean;
begin
  Result := FEditCount > 0;
end;

function TcxSchedulerEvent.GetLabelColor: Integer;
begin
  Result := GetValueDef(FStorage.FLabelColorField, clDefault);
end;

function TcxSchedulerEvent.GetLocation: string;
begin
  Result := GetValueDef(FStorage.FLocationField, '');
end;

function TcxSchedulerEvent.Getmessage: string;
begin
  Result := GetValueDef(FStorage.FMessageField, '');
end;

function TcxSchedulerEvent.GetOptionsFlag: Integer;
begin
  if not FIsDataValid then
    UpdateTemporaryData;
  Result := FOptions;
end;

function TcxSchedulerEvent.GetParentID: Variant;
begin
  Result := GetValueDef(FStorage.FParentIDField, Integer(-2));
end;

function TcxSchedulerEvent.GetReadOnly: Boolean;
begin
  Result := (GetResourceItem <> nil) and GetResourceItem.ReadOnly;  
end;

function TcxSchedulerEvent.GetRecurrenceIndex: Integer;
begin
  Result := GetValueDef(FStorage.FRecurrenceIndexField, 0)
end;

function TcxSchedulerEvent.GetReminder: Boolean;
begin
  Result := (GetOptionsFlag and omReminder) <> 0;
end;

function TcxSchedulerEvent.GetReminderTime: Integer;
begin
  Result := GetValueDef(FStorage.FReminderTimeField, Integer(-2));
end;

function TcxSchedulerEvent.GetResourceID: Variant;
begin
  Result := GetValueDef(FStorage.FResourceIDField, Null);
end;

function TcxSchedulerEvent.GetStart: TDateTime;
begin
  if not FIsDataValid then
    UpdateTemporaryData;
  Result := FStart;
end;

function TcxSchedulerEvent.GetState: Integer;
begin
  Result := GetValueDef(FStorage.FStateField, 0);
end;

function TcxSchedulerEvent.GetValueCount: Integer;
begin
  Result := FStorage.FieldCount;
end;

procedure TcxSchedulerEvent.SetAllDayEvent(const AValue: Boolean);
begin
  if SetOptionsFlag(omAllDayEvent, AValue) then
  begin
    if AValue then
    begin
      Start := DateOf(Start);
      if DateOf(Finish) <= Start then
        Finish := Start + 1
      else
        Finish := DateOf(Finish)
    end
    else
    begin
      Start := DateOf(Start) + cxTime8AM;
      Finish := DateOf(Finish) + cxTime8AM + cxHalfHour;
    end;
  end;
end;

procedure TcxSchedulerEvent.SetCaption(const AValue: string);
begin
  SetValue(FStorage.FCaptionField, AValue);
end;

procedure TcxSchedulerEvent.SetDuration(const AValue: TDateTime);
begin
  Finish := Start + TcxSchedulerDateTimeHelper.RoundTime(AValue);
end;

procedure TcxSchedulerEvent.SetEditValue(AIndex: Integer;
  const AValue: Variant);
begin
  if not IsEditing then Exit;
  FEditValues[AIndex] := AValue;
end;

procedure TcxSchedulerEvent.SetEnabled(const AValue: Boolean);
begin
  SetOptionsFlag(omEnabled, AValue);
end;

procedure TcxSchedulerEvent.SetEventType(AValue: TcxEventType);
var
  AResetRecurrence: Boolean;
begin
  AResetRecurrence := FStorage.IsRecurrenceAvailable;
  if not AResetRecurrence then
    AValue := etNone;
  AResetRecurrence := AResetRecurrence and (AValue = etNone) and
    (AValue <> EventType);
  SetValue(FStorage.FEventTypeField, AValue);
  if AResetRecurrence then
    RecurrenceInfo.AssignDefaultValues;
end;

procedure TcxSchedulerEvent.SetFinish(const AValue: TDateTime);
begin
  FFinish := TcxSchedulerDateTimeHelper.RoundTime(AValue);
  SetValue(FStorage.FFinishField, FFinish + TimeBias);
end;

procedure TcxSchedulerEvent.SetLabelColor(const AValue: Integer);
begin
  SetValue(FStorage.FLabelColorField, AValue);
end;

procedure TcxSchedulerEvent.SetLocation(const AValue: string);
begin
  SetValue(FStorage.FLocationField, AValue);
end;

procedure TcxSchedulerEvent.SetMessage(const AValue: string);
begin
  SetValue(FStorage.FMessageField, AValue);
end;

function TcxSchedulerEvent.SetOptionsFlag(const AMask: Integer;
  AValue: Boolean): Boolean;
begin
  if not FIsDataValid then
    UpdateTemporaryData;
  Result := (FOptions and AMask = AMask) <> AValue;
  if AValue then
    FOptions := FOptions or AMask
  else
    FOptions := FOptions and not AMask;
  SetValue(FStorage.FOptionsField, FOptions);
end;

procedure TcxSchedulerEvent.SetParentID(const AValue: Variant);
begin
  SetValue(FStorage.FParentIDField, AValue);
end;

procedure TcxSchedulerEvent.SetRecurrenceIndex(const AValue: Integer);
begin
  SetValue(FStorage.FRecurrenceIndexField, AValue);
end;

procedure TcxSchedulerEvent.SetRecurrenceInfo(
  AValue: TcxSchedulerEventRecurrenceInfo);
begin
  FRecurrenceInfo.Assign(AValue);
end;

procedure TcxSchedulerEvent.SetReminder(const AValue: Boolean);
begin
  SetOptionsFlag(omReminder, AValue);
end;

procedure TcxSchedulerEvent.SetReminderTime(const AValue: Integer);
begin
  SetValue(FStorage.FReminderTimeField, AValue);
end;

procedure TcxSchedulerEvent.SetResourceID(const AValue: Variant);
begin
  SetValue(FStorage.FResourceIDField, AValue);
end;

procedure TcxSchedulerEvent.SetStart(const AValue: TDateTime);
begin
  FStart := TcxSchedulerDateTimeHelper.RoundTime(AValue);
  SetValue(FStorage.FStartField, FStart + TimeBias);
end;

procedure TcxSchedulerEvent.SetState(const AValue: Integer);
begin
  SetValue(FStorage.FStateField, AValue);
end;

{ TcxSchedulerControlEvent }

constructor TcxSchedulerControlEvent.Create(
  AStorage: TcxCustomSchedulerStorage);
begin
  FStorage := AStorage;
  SetLength(FValues, AStorage.FieldCount);
  ClearValues;
  SetRecordIndex(-1);
  FRecurrenceInfo := CreateRecurrenceInfo;
  FRecurrenceInfo.FOwner := Self;
  AssignDefaultValues;
end;

constructor TcxSchedulerControlEvent.Create(ASource: TcxSchedulerEvent);
begin
  SetLength(FValues, ASource.ValueCount);
  ClearValues;
  inherited Create(ASource.FStorage);
  FIsClone := ASource is TcxSchedulerControlEvent;
  SetRecordIndex(ASource.RecordIndex);
  FSource := ASource;
  Assign(ASource);
end;

constructor TcxSchedulerControlEvent.Create(
  ASource: TcxSchedulerEvent; const AStart, AFinish: TDateTime);
begin
  Create(ASource);
  Start := AStart;
  Finish := AFinish;
end;

destructor TcxSchedulerControlEvent.Destroy;
begin
  if FIsClone and (Source is TcxSchedulerControlEvent) then
    TcxSchedulerControlEvent(Source).FIsSource := False;
  inherited Destroy;
end;

procedure TcxSchedulerControlEvent.Assign(Source: TPersistent);

  function GetPattern: TcxSchedulerEvent;
  begin
    if IsClone then
      Result := TcxSchedulerEvent(Source).FPattern
    else
      if TcxSchedulerEvent(Source).EventType = etPattern then
        Result := TcxSchedulerEvent(Source)
      else
        Result := nil;
  end;

var
  I: Integer;
begin
  if Source is TcxSchedulerEvent then
  begin
    for I := 0 to ValueCount - 1 do
      FValues[I] := TcxSchedulerEvent(Source).GetValueByIndex(I);
    FIsDataValid := False;
    FPattern := GetPattern;
  end;
end;

procedure TcxSchedulerControlEvent.BeginEditing;
begin
  // do nothing for
end;

procedure TcxSchedulerControlEvent.Delete;
begin
  Selected := False;
  if EventType = etOccurrence then
    inherited Delete
  else
    Source.Delete;
end;

procedure TcxSchedulerControlEvent.EndEditing;
begin
end;

function TcxSchedulerControlEvent.GetValueByIndex(
  AIndex: Integer): Variant;
begin
  Result := FValues[AIndex];
  if (Pattern <> nil) and VarIsNull(Result) and Storage.CanGetValueFromPattern(AIndex) then
    Result := Pattern.GetValueByIndex(AIndex);
end;

procedure TcxSchedulerControlEvent.ClearValues;
var
  I: Integer;
begin
  for I := 0 to Length(FValues) - 1 do
    FValues[I] := Null;
end;

procedure TcxSchedulerControlEvent.SetValueByIndex(
  AIndex: Integer; const AValue: Variant);
begin
  Modified;
  FValues[AIndex] := AValue;
end;

function TcxSchedulerControlEvent.TimeBias: Double;
begin
  Result := FTimeBias;
end;

function TcxSchedulerControlEvent.GetSelected: Boolean;
begin
  if SelectionAdapter <> nil then
    Result := SelectionAdapter.IsSelected(Self)
  else
    Result := FIsClone;
end;

procedure TcxSchedulerControlEvent.SetSelected(AValue: Boolean);
begin
  if (AValue <> GetSelected) and (SelectionAdapter <> nil) then
    SelectionAdapter.Add(Self, [ssCtrl]);
end;

{ TcxSchedulerStorageResourceItems }

constructor TcxSchedulerStorageResourceItems.Create(
  AOwner: TcxSchedulerStorageResources;
  AItemClass: TcxSchedulerStorageResourceItemClass);
begin
  FOwner := AOwner;
  inherited Create(AItemClass);
end;

function TcxSchedulerStorageResourceItems.Add: TcxSchedulerStorageResourceItem;
begin
  Result := TcxSchedulerStorageResourceItem(inherited Add);
end;

function TcxSchedulerStorageResourceItems.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TcxSchedulerStorageResourceItems.Update(Item: TCollectionItem);
begin
  inherited Update(Item);
  Storage.Changed;
end;

function TcxSchedulerStorageResourceItems.GetItem(
  AIndex: Integer): TcxSchedulerStorageResourceItem;
begin
  Result := TcxSchedulerStorageResourceItem(inherited Items[AIndex]);
end;

function TcxSchedulerStorageResourceItems.GetStorage: TcxCustomSchedulerStorage;
begin
  Result := FOwner.Storage;
end;

procedure TcxSchedulerStorageResourceItems.SetItem(
  AIndex: Integer; AValue: TcxSchedulerStorageResourceItem);
begin
  Items[AIndex].Assign(AValue);
end;

function TcxSchedulerStorageResourceItems.GetVisibleResource(
  AIndex: Integer): TcxSchedulerStorageResourceItem;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if GetItem(I).Visible then
    begin
      if AIndex = 0 then
      begin
        Result := GetItem(I);
        Break;
      end;
      Dec(AIndex);
    end;
end;

function TcxSchedulerStorageResourceItems.GetVisibleResourceCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    if GetItem(I).Visible then Inc(Result);
end;

{ TcxSchedulerStorageResourceItem }

constructor TcxSchedulerStorageResourceItem.Create(Collection: TCollection);
begin
  FColor := clDefault;
  FVisible := True;
  FReadOnly := False;
  inherited Create(Collection);
end;

procedure TcxSchedulerStorageResourceItem.Assign(Source: TPersistent);
begin
  if Source is TcxSchedulerStorageResourceItem then
  begin
    FColor := TcxSchedulerStorageResourceItem(Source).FColor;
    FName := TcxSchedulerStorageResourceItem(Source).FName;
    FReadOnly := TcxSchedulerStorageResourceItem(Source).FReadOnly;
    FResourceID := TcxSchedulerStorageResourceItem(Source).FResourceID;
    FVisible := TcxSchedulerStorageResourceItem(Source).FVisible;
  end
  else
    inherited Assign(Source);
end;

function TcxSchedulerStorageResourceItem.GetDisplayName: string;
begin
  Result := TcxSchedulerStorageResourceItems(Collection).
    Resources.DoGetResourceName(Self);
end;

procedure TcxSchedulerStorageResourceItem.SetName(
  const AValue: string);
begin
  if AValue = FName then Exit;
  FName := AValue;
  Changed(True);
end;

procedure TcxSchedulerStorageResourceItem.SetColor(
  const AValue: TColor);
begin
  FColor := AValue;
  Changed(True);
end;

procedure TcxSchedulerStorageResourceItem.SetResourceID(
  const AValue: Variant);
begin
  FResourceID := AValue;
  Changed(True);
end;

procedure TcxSchedulerStorageResourceItem.SetVisible(const AValue: Boolean);
begin
  FVisible := AValue;
  Changed(True);
end;

function TcxSchedulerStorageResourceItem.GetResources: TcxSchedulerStorageResources;
begin
  Result := TcxSchedulerStorageResourceItems(Collection).Resources;
end;

{ TcxSchedulerStorageResources }

constructor TcxSchedulerStorageResources.Create(
  AOwner: TcxCustomSchedulerStorage);
begin
  FOwner := AOwner;
  inherited Create(AOwner);
  FItems := CreateItems;
end;

destructor TcxSchedulerStorageResources.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

procedure TcxSchedulerStorageResources.Assign(
  Source: TPersistent);
begin
  if Source is TcxSchedulerStorageResources then
    FItems.Assign(TcxSchedulerStorageResources(Source).Items);
end;

function TcxSchedulerStorageResources.GetResourceName(
  AResource: TcxSchedulerStorageResourceItem): string;
begin
  Result := DoGetResourceName(AResource);
end;

function TcxSchedulerStorageResources.GetObjectName: string;
begin
  if Storage.StoringName <> '' then
    Result := Storage.StoringName
  else
    Result := Storage.Name;
end;

function TcxSchedulerStorageResources.GetProperties(
  AProperties: TStrings): Boolean;
var
  I: Integer;
begin
  Result := ResourceItems.Count > 0;
  for I := 0 to ResourceItems.Count - 1 do
    with ResourceItems[I] do
      AProperties.Add('Resource' + IntToHex(I, 8));
end;

procedure TcxSchedulerStorageResources.GetPropertyValue(const AName: string;
  var AValue: Variant);
var
  AID: Integer;
  AItem: TcxSchedulerStorageResourceItem;
begin
  if ResourceItems.Count = 0 then Exit;
  if Pos('Resource', AName) = 1 then
  begin
    AID := StrToIntDef('$' + Copy(AName, 9, 8), -1);
    AItem := TcxSchedulerStorageResourceItem(ResourceItems.FindItemID(AID));
    if AItem <> nil then
      AValue := ((AItem.Index and $FFFF) shl 1) or Ord(AItem.Visible);
  end;
end;

procedure TcxSchedulerStorageResources.SetPropertyValue(const AName: string;
  const AValue: Variant);
var
  AID, AIndex: Integer;
  AItem: TcxSchedulerStorageResourceItem;
begin
  if ResourceItems.Count = 0 then Exit;
  if Pos('Resource', AName) = 1 then
  begin
    AID := StrToIntDef('$' + Copy(AName, 9, 8), -1);
    AItem := TcxSchedulerStorageResourceItem(ResourceItems.FindItemID(AID));
    if AItem <> nil then
    begin
      AIndex := (AValue shr 1) and $FFFFFFF;
      if (AIndex >= 0) and (AIndex < ResourceItems.Count) then
      begin
        AItem.Index := AIndex;
        AItem.Visible := Boolean(AValue and 1);
      end;
    end;
  end;
end;

procedure TcxSchedulerStorageResources.Changed;
begin
  Storage.Changed;
end;

function TcxSchedulerStorageResources.CreateItems: TcxSchedulerStorageResourceItems;
begin
  Result := TcxSchedulerStorageResourceItems.Create(
    Self, TcxSchedulerStorageResourceItem);
end;

function TcxSchedulerStorageResources.DoGetResourceName(
  AItem: TcxSchedulerStorageResourceItem): string;
begin
  Result := '';
  if AItem <> nil then
    Result := AItem.Name;
  if Assigned(FOnGetResourceName) then
    FOnGetResourceName(Storage, AItem, Result);
end;

function TcxSchedulerStorageResources.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TcxSchedulerStorageResources.GetResourceItems: TcxSchedulerStorageResourceItems;
begin
  Result := Items; 
end;

procedure TcxSchedulerStorageResources.SetItems(
  AValue: TcxSchedulerStorageResourceItems);
begin
  FItems.Assign(AValue);
end;

{ TcxCustomSchedulerStorage }

constructor TcxCustomSchedulerStorage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  EventsIndex := TList.Create;
  FIsLoading := True;
  CreateSubClasses;
  FIsLoading := False;
end;

destructor TcxCustomSchedulerStorage.Destroy;
begin
  EventsIndex.Free;
  SendNotification(True);
  DestroySubClasses;
  inherited Destroy;
end;

procedure TcxCustomSchedulerStorage.Assign(
  Source: TPersistent);
begin
  if Source is TcxCustomSchedulerStorage then
  begin
    Resources := TcxCustomSchedulerStorage(Source).Resources;
    Fields.Assign(TcxCustomSchedulerStorage(Source).Fields);
    InternalFields.Assign(TcxCustomSchedulerStorage(Source).InternalFields);
  end;
end;

procedure TcxCustomSchedulerStorage.AddListener(
  AListener: IcxSchedulerStorageListener);
begin
  if FListeners.IndexOf(AListener) = -1 then
    FListeners.Add(AListener);
end;

procedure TcxCustomSchedulerStorage.BeginUpdate;
begin
  DataController.BeginUpdate;
end;

procedure TcxCustomSchedulerStorage.Clear;
begin
  DataController.RecordCount := 0;
  DataController.Post;
end;

function TcxCustomSchedulerStorage.CheckRequiredFields: Boolean;
begin
  Result := True; 
end;

function TcxCustomSchedulerStorage.CreateEvent: TcxSchedulerEvent;
begin
  Result := GetEventClass.Create(Self);
  FNewEvents.Add(Result);
end;

function TcxCustomSchedulerStorage.CreateOccurrence(APattern: TcxSchedulerEvent;
  const ADate: TDateTime; AType: TcxEventType): TcxSchedulerEvent;
var
  ACalculator: TcxSchedulerOccurrenceCalculator;
  AOccurrence: TcxSchedulerEvent;
begin
  Result := nil;
  if not (AType in [etCustom, etException]) or (APattern.EventType <> etPattern) then Exit;
  ACalculator := TcxSchedulerOccurrenceCalculator.Create(APattern, APattern.Start, ADate + 7);
  try
    while ACalculator.GetNextOccurrence do
    begin
      if APattern.GetOccurrenceByIndex(ACalculator.Index, AOccurrence) then
        Continue
      else
        if DateOf(ACalculator.OccurrenceStart) > DateOf(ADate) then
          Break
        else
          if DateOf(ACalculator.OccurrenceStart) = DateOf(ADate) then
          begin
            Result := CreateEvent;
            Result.Assign(APattern);
            Result.Start := ACalculator.OccurrenceStart;
            Result.Finish := ACalculator.OccurrenceFinish;
            Result.RecurrenceIndex := ACalculator.Index;
            Result.EventType := AType;
            Result.ParentID := APattern.ID;
            Result.FPattern := APattern;
            Break;
          end;
    end;
  finally
    ACalculator.Free;
  end;
end;

procedure TcxCustomSchedulerStorage.EndUpdate;
begin
  if DataController.LockCount = 1 then
  begin
    BeforeUpdate;
    try
      PostEvents;
      if FDeletedRecords.Count > 0 then
        TcxSchedulerStorageDataController(DataController).DeleteRecords(FDeletedRecords);
      FDeletedRecords.Count := 0;
    finally
      AfterUpdate;
    end;
  end;
  DataController.EndUpdate;
end;

procedure TcxCustomSchedulerStorage.FullRefresh;
begin
  if IsUpdatingMode then Exit;
  FIsLoading := True;
  try
    DoRefresh;
  finally
    FIsLoading := False;
    SendNotification;
  end;
end;

function TcxCustomSchedulerStorage.GetEventByID(const AID: Variant): TcxSchedulerEvent;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to EventCount - 1 do
    if VarEquals(AID, Events[I].ID) then
    begin
      Result := Events[I];
      break;
    end;
end;

function TcxCustomSchedulerStorage.GetEvents(
  AList: TcxSchedulerFilteredEventList;
  const AStart, AFinish: TDateTime): Boolean;
begin
  Result := GetEvents(AList, AStart, AFinish, Null);
end;

function TcxCustomSchedulerStorage.GetEvents(
  AList: TcxSchedulerFilteredEventList; const AStart, AFinish: TDateTime;
  const AResourceID: Variant): Boolean;
var
  I: Integer;
begin
  AList.Init(AStart, AFinish, Self);
  for I := 0 to EventCount - 1 do
    AList.CheckEvent(Events[I], AResourceID);
  AList.Changed;
  Result := AList.Count > 0;
end;

procedure TcxCustomSchedulerStorage.PostEvents;
begin
  if not IsActive or (FNewEvents.Count = 0) then Exit;
  BeginUpdate;
  try
    while FNewEvents.Count <> 0 do FNewEvents.Last.Post;
  finally
    EndUpdate;
  end;
end;

function TcxCustomSchedulerStorage.IsActive: Boolean;
begin
  Result := True;
end;

function TcxCustomSchedulerStorage.IsCaptionAvailable: Boolean;
begin
  Result := True;
end;

function TcxCustomSchedulerStorage.IsLabelColorAvailable: Boolean;
begin
  Result := True;
end;

function TcxCustomSchedulerStorage.IsLocationAvailable: Boolean;
begin
  Result := True;
end;

function TcxCustomSchedulerStorage.IsMessageAvailable: Boolean;
begin
  Result := True;
end;

function TcxCustomSchedulerStorage.IsRecurrenceAvailable: Boolean;
begin
  Result := True;
end;

function TcxCustomSchedulerStorage.IsStateAvailable: Boolean;
begin
  Result := True;
end;

function TcxCustomSchedulerStorage.IsReminderAvailable: Boolean;
begin
  Result := True;
end;

procedure TcxCustomSchedulerStorage.AfterUpdate;
begin
end;

procedure TcxCustomSchedulerStorage.BeforeUpdate;
begin
end;

procedure TcxCustomSchedulerStorage.RemoveListener(
  AListener: IcxSchedulerStorageListener);
begin
  FListeners.Remove(AListener);
end;

procedure TcxCustomSchedulerStorage.AddInternalField(
  var AField: TcxCustomSchedulerStorageField; AValueType: TcxValueTypeClass);
begin
  AField := TcxCustomSchedulerStorageField(InternalFields.Add);
  AField.ValueTypeClass := AValueType;
end;

procedure TcxCustomSchedulerStorage.AddRecord;
begin
  DataController.AppendRecord;
end;

procedure TcxCustomSchedulerStorage.CancelEvent(AEvent: TcxSchedulerEvent);
begin
  Dec(AEvent.FEditCount);
  if AEvent.FEditCount = 0 then
    AEvent.Free;
  Changed;
end;

function TcxCustomSchedulerStorage.CanGetValueFromPattern(
  AIndex: Integer): Boolean;
begin
  Result := AIndex in [
    FCaptionField.Index,
    FLabelColorField.Index,
    FLocationField.Index,
    FMessageField.Index,
    FOptionsField.Index,
    FReminderTimeField.Index,
    FStateField.Index
  ];
  Result := Result or (AIndex > FStateField.Index);
end;

procedure TcxCustomSchedulerStorage.Changed;
begin
  if not IsLocked then SendNotification;
end;

procedure TcxCustomSchedulerStorage.CreateDefaultFields;
begin
  AddInternalField(FCaptionField, TcxStringValueType);
  AddInternalField(FEventTypeField, TcxIntegerValueType);
  AddInternalField(FFinishField, TcxDateTimeValueType);
  AddInternalField(FLabelColorField, TcxIntegerValueType);
  AddInternalField(FLocationField, TcxStringValueType);
  AddInternalField(FMessageField, TcxStringValueType);
  AddInternalField(FOptionsField, TcxIntegerValueType);
  AddInternalField(FParentIDField, TcxIntegerValueType);
  AddInternalField(FRecurrenceIndexField, TcxIntegerValueType);
  AddInternalField(FRecurrenceInfoField, TcxVariantValueType);
  AddInternalField(FReminderTimeField, TcxIntegerValueType);
  AddInternalField(FResourceIDField, TcxVariantValueType);
  AddInternalField(FStartField, TcxDateTimeValueType);
  AddInternalField(FStateField, TcxIntegerValueType);
end;

function TcxCustomSchedulerStorage.CreateFields: TcxCustomSchedulerStorageFields;
begin
  Result := TcxSchedulerStorageFields.Create(TcxSchedulerStorageField);
end;

function TcxCustomSchedulerStorage.CreateResources: TcxSchedulerStorageResources;
begin
  Result := TcxSchedulerStorageResources.Create(Self);
end;

procedure TcxCustomSchedulerStorage.CreateSubClasses;
begin
  FDeletedRecords := TList.Create;
  FResources := CreateResources;
  FInternalFields := CreateFields;
  FInternalFields.FOwner := Self;
  FUserFields := CreateFields;
  FUserFields.FOwner := Self;
  FFields := TList.Create;
  FNewEvents := TcxSchedulerEventList.Create;
  FEventsList := TcxSchedulerEventList.Create;
  FListeners := TInterfaceList.Create();
  FDataController := GetDataControllerClass.Create(Self);
  CreateDefaultFields;
end;

procedure TcxCustomSchedulerStorage.DestroySubClasses;
begin
  try
    FUserFields.Clear;
    FInternalFields.Clear;
    FEventsList.DestroyItems;
    FNewEvents.DestroyItems;
    FDeletedRecords.Free;
  finally
    FDataController.Free;
    FNewEvents.Free;
    FEventsList.Free;
    FUserFields.Free;
    FInternalFields.Free;
    FFields.Free;
    FResources.Free;
    FreeAndNil(FEditor);
    FListeners.Free;
  end;
end;

procedure TcxCustomSchedulerStorage.DoDeleteEvent(
  const ARecordIndex: Integer);
var
  I: Integer;
  AParentEvent, AChildEvent: TcxSchedulerEvent;
  AEventsChain: TcxSchedulerEventList;
begin
  AParentEvent := FEventsList[ARecordIndex];
  if IsUpdatingMode or IsDeletion or DoEventDeleted(AParentEvent) then Exit;
  IsDeletion := True;
  BeginUpdate;
  FDeletedRecords.Add(Pointer(AParentEvent.RecordIndex));
  try
    AEventsChain := AParentEvent.GetRecurrenceChain;
    try
      for I := 0 to AEventsChain.Count - 1 do
      begin
        AChildEvent := AEventsChain[I];
        DoEventDeleted(AChildEvent); //ignore Allow parameter for the database integrity
        FDeletedRecords.Add(Pointer(AChildEvent.RecordIndex));
        AChildEvent.Free;
      end;
      AParentEvent.Free;
    finally
      AEventsChain.Destroy;
    end;
  finally
    IsDeletion := False;
    EndUpdate;
  end;
end;

procedure TcxCustomSchedulerStorage.DoDestroyEvent(
  AEvent: TcxSchedulerEvent);
begin
  FEventsList.Remove(AEvent);
  FNewEvents.Remove(AEvent);
end;

function TcxCustomSchedulerStorage.DoEventDeleted(
  AEvent: TcxSchedulerEvent): Boolean;
begin
  Result := False;
  if Assigned(FOnEventDeleted) then
    FOnEventDeleted(Self, AEvent, Result);
end;

function TcxCustomSchedulerStorage.DoEventInserted(
  AEvent: TcxSchedulerEvent): Boolean;
begin
  Result := False;
  if Assigned(FOnEventInserted) then
    FOnEventInserted(Self, AEvent, Result);
end;

function TcxCustomSchedulerStorage.DoEventModified(
  AEvent: TcxSchedulerEvent): Boolean;
begin
  Result := False;
  with AEvent do
  begin
    if not FSkipModified and IsModified and Assigned(FOnEventModified) then
      FOnEventModified(Self, AEvent, Result);
  end;
end;

procedure TcxCustomSchedulerStorage.DoRefresh;
var
  ID: Variant;
  AEvent: TcxSchedulerEvent;
  IndexList, DestList: TList;
  I, J, ACount: Integer;
begin
  ACount := DataController.RecordCount;
  if not IsDataSettingsValid then
    ACount := 0;
  IndexList := FEventsList.FItems;
  IndexList.Sort(TListSortCompare(@cxCompareEventsByID));
  DestList := TList.Create;
  try
    FEventsList.FItems := DestList;
    DestList.Count := ACount;
    for I := 0 to ACount - 1 do
    begin
      ID := DataController.GetRecordID(I);
      if not cxFindEvent(IndexList, ID, AEvent) then
        AEvent := GetEventClass.Create(Self, I);
      AEvent.SetRecordIndex(I);
      AEvent.FPattern := nil;
      DestList[I] := AEvent;
    end;
    for I := 0 to IndexList.Count - 1 do
      TObject(IndexList.List^[I]).Free;
  finally
    IndexList.Free;
  end;
  for I := 0 to ACount - 1 do
    if Events[I].EventType = etPattern then
    begin
      for J := 0 to ACount - 1 do
        if J <> I then
          Events[I].CheckRecurrenceLink(Events[J]);
    end; 
end;

function TcxCustomSchedulerStorage.GetDataControllerClass: TcxCustomDataControllerClass;
begin
  Result := TcxSchedulerStorageDataController;
end;

function TcxCustomSchedulerStorage.GetEventStoredID(AEvent: TcxSchedulerEvent): Variant;
begin
  Result := AEvent.FSavedID;
end;

function TcxCustomSchedulerStorage.GetFieldValueBeforePost(
  ARecordIndex, AFieldIndex: Integer): Variant;
begin
  Result := Values[ARecordIndex, AFieldIndex];
end;

function TcxCustomSchedulerStorage.GetFocusedRecordID(ARecordIndex: Integer): Variant;
begin
  Result := DataController.GetRecordId(ARecordIndex);
end;

function TcxCustomSchedulerStorage.GetEventClass: TcxSchedulerEventClass;
begin
  Result := TcxSchedulerEvent;
end;

function TcxCustomSchedulerStorage.GetParentForm: TForm;
var
  AOwner: TComponent;
begin
  AOwner := Owner;
  while not (AOwner is TForm) and (AOwner <> nil) do
    AOwner := AOwner.Owner;
  Result := TForm(AOwner);
end;

function TcxCustomSchedulerStorage.GetRecordID(
  const ARecordIndex: Integer): Variant;
begin
  Result := DataController.GetRecordID(ARecordIndex);
end;

function TcxCustomSchedulerStorage.GetValue(
  ARecordIndex, AItemIndex: Integer): Variant;
begin
  if DataController.IsEditing and (ARecordIndex = DataController.EditingRecordIndex) then
    Result := DataController.GetEditValue(AItemIndex, evsValue)
  else
    Result := DataController.Values[ARecordIndex, AItemIndex];
end;

procedure TcxCustomSchedulerStorage.ItemAdded(
  AItem: TcxCustomSchedulerStorageField);
begin
  if FFields.IndexOf(AItem) = -1 then
  try
    AItem.FIndex := FFields.Add(AItem);
    DataController.AddItem(AItem);
  finally
    DataController.UpdateItemIndexes;
    LayoutChanged;
  end;
end;

procedure TcxCustomSchedulerStorage.ItemRemoved(
  AItem: TcxCustomSchedulerStorageField);
begin
  if FFields.Remove(AItem) <> -1 then
  try
    DataController.RemoveItem(AItem);
  finally
    UpdateItemIndexes;
    LayoutChanged;
  end;
end;

function TcxCustomSchedulerStorage.IsDataSettingsValid: Boolean;
begin
  Result := True;
end;

procedure TcxCustomSchedulerStorage.LayoutChanged;
begin
  SendNotification;
end;

procedure TcxCustomSchedulerStorage.Loaded;
begin
  inherited Loaded;
  DataController.Loaded;
  FullRefresh;
end;

procedure TcxCustomSchedulerStorage.PostEvent(
  AEvent: TcxSchedulerEvent);
var
  ARecordIndex: Integer;
begin
  BeginUpdate;
  try
    if AEvent.IsNewEvent then
    begin
      FNewEvents.Remove(AEvent);
      FEventsList.Add(AEvent);
      if DoEventInserted(AEvent) then Exit;
      if CheckRequiredFields then
      begin
        ARecordIndex := DataController.RecordCount;
        AddRecord;
        if ARecordIndex < DataController.RecordCount then
        begin
          AEvent.SetRecordIndex(ARecordIndex);
          AEvent.EndEditing;
          AEvent.FSavedID := GetFocusedRecordID(ARecordIndex);
        end;
      end
      else
        AEvent.Free;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TcxCustomSchedulerStorage.PostEditingData(
  AEvent: TcxSchedulerEvent);
var
  AFieldIndex: Integer;
begin
  if DoEventModified(AEvent) then Exit;
  DataController.BeginUpdate;
  try
    for AFieldIndex := 0 to AEvent.ValueCount - 1 do
      SetPostFieldValue(AEvent, AFieldIndex);
  finally
    DataController.EndUpdate;
  end;
end;

procedure TcxCustomSchedulerStorage.SendNotification(
  AIsRemoved: Boolean = False);
var
  I: Integer;
  AIntf: IcxSchedulerStorageListener;
begin
  for I := Listeners.Count - 1 downto 0 do
    if Supports(Listeners[I], IcxSchedulerStorageListener, AIntf) then
    begin
      if AIsRemoved then
        AIntf.StorageRemoved(Self)
      else
        if not IsUpdatingMode then
          AIntf.StorageChanged(Self);
    end;
end;

procedure TcxCustomSchedulerStorage.SetEventRecordInfo(AEvent: TcxSchedulerEvent;
  ARecordIndex: Integer; const AEventID: Variant);
begin
  AEvent.SetRecordIndex(ARecordIndex);
  AEvent.FSavedID := AEventID;
end;

procedure TcxCustomSchedulerStorage.SetFieldValueBeforePost(
  ARecordIndex, AFieldIndex: Integer; const AValue: Variant);
begin
  Values[ARecordIndex, AFieldIndex] := AValue;
end; 

procedure TcxCustomSchedulerStorage.SetPostFieldValue(AEvent: TcxSchedulerEvent;
  AFieldIndex: Integer);
var
  AEventValue, APatternValue, AStoredValue: Variant;
begin
  AEventValue := AEvent.FEditValues[AFieldIndex];
  if (AEvent.Pattern <> nil) and (AEvent.EventType = etCustom) and CanGetValueFromPattern(AFieldIndex) then
  begin
    APatternValue := Values[AEvent.Pattern.RecordIndex, AFieldIndex];
    AStoredValue := GetFieldValueBeforePost(AEvent.RecordIndex, AFieldIndex);
    if not VarEquals(AEventValue, APatternValue) or
      (not VarEquals(AEventValue, AStoredValue) and not VarIsNull(AStoredValue)) then
        SetFieldValueBeforePost(AEvent.RecordIndex, AFieldIndex, AEventValue);
  end
  else
    SetFieldValueBeforePost(AEvent.RecordIndex, AFieldIndex, AEventValue);
end;

procedure TcxCustomSchedulerStorage.SetValue(
  ARecordIndex, AItemIndex: Integer;
  const AValue: Variant);
begin
  DataController.Values[ARecordIndex, AItemIndex] := AValue;
end;

procedure TcxCustomSchedulerStorage.UpdateControl(
  AInfo: TcxUpdateControlInfo);
begin
  if (AInfo is TcxDataChangedInfo) or (AInfo is TcxUpdateRecordInfo) then
    FullRefresh;
end;

procedure TcxCustomSchedulerStorage.UpdateData;
begin
end;

procedure TcxCustomSchedulerStorage.UpdateItemIndexes;
var
  I: Integer;
begin
  for I := 0 to FieldCount - 1 do
    TcxCustomSchedulerStorageField(FFields[I]).FIndex := I;
  SendNotification;
end;

function TcxCustomSchedulerStorage.GetEvent(
  AIndex: Integer): TcxSchedulerEvent;
begin
  Result := FEventsList[AIndex];
end;

function TcxCustomSchedulerStorage.GetEventCount: Integer;
begin
  Result := FEventsList.Count;
end;

function TcxCustomSchedulerStorage.GetFieldCount: Integer;
begin
  Result := FFields.Count
end;

function TcxCustomSchedulerStorage.GetIsDestroying: Boolean;
begin
  Result := csDestroying in ComponentState;
end;

function TcxCustomSchedulerStorage.GetIsLoading: Boolean;
begin
  Result := csLoading in ComponentState;
end;

function TcxCustomSchedulerStorage.GetIsLocked: Boolean;
begin
  Result := DataController.LockCount > 0
end;

function TcxCustomSchedulerStorage.GetIsUpdatingMode: Boolean;
begin
  Result := FIsLoading or IsLoading or IsDestroying;
end;

function TcxCustomSchedulerStorage.GetResourceCount: Integer;
begin
  Result := Resources.ResourceItems.Count;
end;

function TcxCustomSchedulerStorage.GetResourceID(AIndex: Integer): Variant;
begin
  Result := Resources.ResourceItems[AIndex].ResourceID;
end;

function TcxCustomSchedulerStorage.GetResourceName(AIndex: Integer): string;
begin
  Result := Resources.ResourceItems[AIndex].DisplayName;
end;

procedure TcxCustomSchedulerStorage.SetEvent(
  AIndex: Integer; AValue: TcxSchedulerEvent);
begin
  Events[AIndex].Assign(AValue);
end;

procedure TcxCustomSchedulerStorage.SetResources(
  AValue: TcxSchedulerStorageResources);
begin
  FResources.Assign(AValue);
end;

procedure TcxCustomSchedulerStorage.SetStoreUsingGlobalTime(AValue: Boolean);
begin
  if StoreUsingGlobalTime <> AValue then
  begin
    FStoreUsingGlobalTime := AValue;
    if AValue then
    begin
      with TcxSchedulerDateTimeHelper do
        TimeBias := TimeZoneBias(CurrentTimeZone)
    end
    else
      TimeBias := 0;
    Changed;
  end;
end;

{ TcxSchedulerStorage }

procedure TcxSchedulerStorage.Assign(Source: TPersistent);
var
  AMemStream: TMemoryStream;
begin
  if Source is TcxSchedulerStorage then
  begin
    AMemStream := TMemoryStream.Create;
    try
      TcxSchedulerStorage(Source).SaveToStream(AMemStream);
      AMemStream.Position := 0;
      LoadFromStream(AMemStream);
    finally
      AMemStream.Free;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TcxSchedulerStorage.SaveToFile(
  const AFileName: string);
var
  AStream: TFileStream;
begin
  AStream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveToStream(AStream);
  finally
    AStream.Free;
  end;
end;

procedure TcxSchedulerStorage.SaveToStream(AStream: TStream);
begin
  DataController.SaveToStream(AStream);
end;

procedure TcxSchedulerStorage.LoadFromFile(const AFileName: string);
var
  AStream: TFileStream;
begin
  AStream := TFileStream.Create(AFileName, fmOpenRead);
  try
    LoadFromStream(AStream);
  finally
    AStream.Free;
  end;
end;

procedure TcxSchedulerStorage.LoadFromStream(
  AStream: TStream);
var
  AMemStream: TMemoryStream;
begin
  AMemStream := TMemoryStream.Create;
  BeginUpdate;
  try
    SaveToStream(AMemStream);
    try
      Clear;
      DataController.LoadFromStream(AStream);
    except
      Clear;
      DataController.LoadFromStream(AMemStream);
      raise;
    end;
  finally
    AMemStream.Free;
    if IsUpdatingMode then
      DoRefresh;
    EndUpdate;
  end;
end;

procedure TcxSchedulerStorage.DefineProperties(
  Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('BinaryData', LoadFromStream,
    SaveToStream, DataController.RecordCount > 0);
end;

function TcxSchedulerStorage.GetFields: TcxSchedulerStorageFields;
begin
  Result := TcxSchedulerStorageFields(inherited Fields)
end;

procedure TcxSchedulerStorage.SetFields(
  const AValue: TcxSchedulerStorageFields);
begin
  Fields.Assign(AValue);
end;

{ TcxSelectedItemData }

constructor TcxSelectedItemData.Create(AEvent: TcxSchedulerEvent);
begin
  ID := AEvent.ID;
  ParentID := AEvent.ParentID;
  RecurrenceIndex := AEvent.RecurrenceIndex
end;

{ TcxSchedulerEventSelection }

constructor TcxSchedulerEventSelection.Create(
  ASourceEvents: TcxSchedulerEventList);
begin
  FKeys := TList.Create;
  FEvents := TList.Create;
  FSourceEvents := ASourceEvents;
end;

destructor TcxSchedulerEventSelection.Destroy;
begin
  InternalClear;
  FEvents.Free;
  FKeys.Free;
  inherited Destroy;
end;

procedure TcxSchedulerEventSelection.Add(
  AEvent: TcxSchedulerControlEvent; AShift: TShiftState);
var
  AIndex: Integer;
  ASelected: Boolean;
begin
  ASelected := (AEvent <> nil) and AEvent.Selected;
  if (AEvent = nil) or ([ssShift, ssCtrl] * AShift = []) then
    InternalClear;
  if AEvent <> nil then
  try
    AIndex := KeyIndexOf(AEvent);
    if (ssCtrl in AShift) and (AIndex >= 0) then
    begin
      Keys[AIndex].Free;
      FKeys.Delete(AIndex);
    end
    else
      if AIndex < 0 then
        FKeys.Add(CreateItem(AEvent));
  finally
    Update;
    if ASelected <> AEvent.Selected then
      DoEventSelectionChanged(AEvent);
  end;
end;

procedure TcxSchedulerEventSelection.Clear;
begin
  if Count = 0 then Exit;
  InternalClear;
  DoEventSelectionChanged(nil);
end;

function TcxSchedulerEventSelection.IsSelected(
  AEvent: TcxSchedulerControlEvent): Boolean;
begin
  Result := KeyIndexOf(AEvent) >= 0;
end;

procedure TcxSchedulerEventSelection.Update;
begin
  FKeys.Sort(TListSortCompare(@cxCompareSelectionKeys));
  ReplaceSelection;
end;

procedure TcxSchedulerEventSelection.ClearKeys;
var
  I: Integer;
begin
  for I := FKeys.Count - 1 downto 0 do
    TObject(FKeys.List^[I]).Free;
  FKeys.Clear;
end;

function TcxSchedulerEventSelection.CreateItem(
  AEvent: TcxSchedulerControlEvent): TcxSelectedItemData;
begin
  Result := TcxSelectedItemData.Create(AEvent);
  Result.ID := AEvent.ID;
  Result.ParentID := AEvent.ParentID;
  Result.RecurrenceIndex := AEvent.RecurrenceIndex;
end;

procedure TcxSchedulerEventSelection.DoEventSelectionChanged(
  AEvent: TcxSchedulerControlEvent);
begin
  if Assigned(FOnEventSelectionChanged) then
    FOnEventSelectionChanged(AEvent);
end;

function TcxSchedulerEventSelection.KeyIndexOf(
  AEvent: TcxSchedulerControlEvent): Integer;
var
  I, L, R, C: Integer;
  AItemForSearch: TcxSelectedItemData;
begin
  Result := -1;
  L := 0;
  R := KeyCount - 1;
  if R < L then Exit;
  AItemForSearch := CreateItem(AEvent);
  try
    while L <= R do
    begin
      I := (L + R) shr 1;
      C := cxCompareSelectionKeys(Keys[I], AItemForSearch);
      if C < 0 then
        L := I + 1
      else
      begin
        R := I - 1;
        if C = 0 then
        begin
          Result := I;
          Break;
        end;
      end;
    end;
  finally
    AItemForSearch.Free;
  end;
end;

function TcxSchedulerEventSelection.IndexOf(
  AEvent: TcxSchedulerControlEvent): Integer;
begin
  Result := FEvents.IndexOf(AEvent);
end;

procedure TcxSchedulerEventSelection.InternalClear;
begin
  ClearKeys;
  FEvents.Clear;
end;

procedure TcxSchedulerEventSelection.ReplaceSelection;
var
  AIndex, I: Integer;
begin
  FEvents.Clear;
  for I := 0 to FSourceEvents.Count - 1 do
  begin
    AIndex := KeyIndexOf(TcxSchedulerControlEvent(FSourceEvents[I]));
    if AIndex <> -1 then FEvents.Add(FSourceEvents[I]);
  end;
  ClearKeys;
  for I := 0 to FEvents.Count - 1 do
    FKeys.Add(CreateItem(TcxSchedulerControlEvent(FEvents[I])));
  FKeys.Sort(TListSortCompare(@cxCompareSelectionKeys));
end;

function TcxSchedulerEventSelection.GetCount: Integer;
begin
  Result := FEvents.Count;
end;

function TcxSchedulerEventSelection.GetItem(
  AIndex: Integer): TcxSchedulerControlEvent;
begin
  Result := TcxSchedulerControlEvent(FEvents.List^[AIndex])
end;

function TcxSchedulerEventSelection.GetKey(
  AIndex: Integer): TcxSelectedItemData;
begin
  Result := FKeys.List^[AIndex];
end;

function TcxSchedulerEventSelection.GetKeyCount: Integer;
begin
  Result := FKeys.Count;
end;

{ TcxSchedulerEventList }

constructor TcxSchedulerEventList.Create;
begin
  FItems := TList.Create;
end;

destructor TcxSchedulerEventList.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

procedure TcxSchedulerEventList.Assign(ASource: TcxSchedulerEventList{$IFDEF DELPHI6};
  AOperator: TListAssignOp = laCopy {$ENDIF});
{$IFNDEF DELPHI6}
var
  I: Integer;
{$ENDIF}
begin
  if ASource = nil then Exit;
{$IFDEF DELPHI6}
  FItems.Assign(ASource.FItems, AOperator, nil);
{$ELSE}
  FItems.Clear; 
  FItems.Capacity := ASource.FItems.Capacity;
  for I := 0 to ASource.FItems.Count - 1 do
    FItems.Add(ASource.FItems.List^[I]);
{$ENDIF}
end;

function TcxSchedulerEventList.Add(
  AEvent: TcxSchedulerEvent): Integer;
begin
  Result := FItems.Add(AEvent);
  EventAdded(AEvent);
end;

procedure TcxSchedulerEventList.Clear;
begin
  DoClear(False);
end;

procedure TcxSchedulerEventList.Delete(AIndex: Integer);
begin
  FItems.Delete(AIndex);
end;

procedure TcxSchedulerEventList.DestroyItems;
begin
  DoClear(True);
end;

function TcxSchedulerEventList.Remove(
  AEvent: TcxSchedulerEvent): Integer;
begin
  Result := FItems.Remove(AEvent);
end;

function TcxSchedulerEventList.IndexOf(
  AEvent: TcxSchedulerEvent): Integer;
begin
  Result := FItems.IndexOf(AEvent);
end;

procedure TcxSchedulerEventList.Sort(
  ACompare: TcxCompareEventsProc);
begin
  FItems.Sort(@ACompare);
end;

procedure TcxSchedulerEventList.EventAdded(
  AEvent: TcxSchedulerEvent); 
begin
end;

procedure TcxSchedulerEventList.DoClear(AFreeItems: Boolean); 
var
  I: Integer;
begin
  if AFreeItems then
    for I := FItems.Count - 1 downto 0 do Items[I].Free;
  FItems.Clear;
end;

function TcxSchedulerEventList.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxSchedulerEventList.GetFirst: TcxSchedulerEvent;
begin
  Result := TcxSchedulerEvent(FItems.First);
end;

function TcxSchedulerEventList.GetEvent(
  AIndex: Integer): TcxSchedulerEvent;
begin
  Result := TcxSchedulerEvent(FItems.List^[AIndex]);
end;

function TcxSchedulerEventList.GetLast: TcxSchedulerEvent;
begin
  Result := TcxSchedulerEvent(FItems.Last);
end;

{ TcxSchedulerFilteredEventList }

destructor TcxSchedulerFilteredEventList.Destroy;
begin
  DestroyItems;
  inherited Destroy;
end;

function TcxSchedulerFilteredEventList.AddEvent(
  AEvent: TcxSchedulerEvent): TcxSchedulerControlEvent;
begin
  Result := CreateControlEvent(AEvent);
  Add(Result);
end;

function TcxSchedulerFilteredEventList.AddOccurrence(
  ACalculator: TcxSchedulerOccurrenceCalculator): TcxSchedulerControlEvent;
begin
  Result := nil;
  with ACalculator do
  begin                                         
    if (DateOf(OccurrenceStart) <= Finish) and (DateOf(OccurrenceFinish) >= Start) then
      Result := AddEvent(Event)
    else
      Exit;
    Result.Start := OccurrenceStart - Result.TimeBias + Storage.TimeBias;
    Result.Finish := OccurrenceFinish - Result.TimeBias + Storage.TimeBias;
    Result.RecurrenceIndex := Index;
    Result.EventType := etOccurrence;
    Result.FPattern := Event;
    Result.FOptions := Event.FOptions;
  end;
end;

procedure TcxSchedulerFilteredEventList.Changed;
begin
end;

procedure TcxSchedulerFilteredEventList.CheckEvent(
  AEvent: TcxSchedulerEvent; const AResourceID: Variant);
begin
  if AEvent.EventType = etNone then
    CheckSimpleEvent(AEvent, AResourceID)
  else
    if AEvent.EventType = etPattern then
      CheckRecurrenceEvent(AEvent, AResourceID);
end;

procedure TcxSchedulerFilteredEventList.CheckRecurrenceEvent(
  AEvent: TcxSchedulerEvent; const AResourceID: Variant);
var
  AOccurrence: TcxSchedulerEvent;
  ACalculator: TcxSchedulerOccurrenceCalculator;
begin
  ACalculator := TcxSchedulerOccurrenceCalculator.Create(AEvent, FStart, FFinish);
  try
    while ACalculator.GetNextOccurrence do
    begin
      if AEvent.GetOccurrenceByIndex(ACalculator.Index, AOccurrence) then
      begin
        if AOccurrence.EventType = etCustom then
          CheckSimpleEvent(AOccurrence, AResourceID)
      end
      else
        if VarIsNull(AResourceID) or VarEquals(AEvent.ResourceID, AResourceID) then
          AddOccurrence(ACalculator);
    end;
  finally
    ACalculator.Free;
  end;
end;

procedure TcxSchedulerFilteredEventList.CheckSimpleEvent(
  AEvent: TcxSchedulerEvent; const AResourceID: Variant);
begin
  if (VarIsNull(AResourceID) or VarEquals(AResourceID, AEvent.ResourceID)) and
    ((AEvent.Start <= Finish) and (AEvent.Finish >= Start)) then
    AddEvent(AEvent).FPattern := AEvent.FPattern;
end;

function TcxSchedulerFilteredEventList.CreateControlEvent(
  AEvent: TcxSchedulerEvent): TcxSchedulerControlEvent;
begin
  Result := TcxSchedulerControlEvent.Create(AEvent);
  Result.FTimeBias := AEvent.TimeBias; 
end;

procedure TcxSchedulerFilteredEventList.Init(
  const AStart, AFinish: TDateTime; AStorage: TcxCustomSchedulerStorage);
begin
  DestroyItems;
  FStart := AStart;
  FFinish := AFinish;
  FStorage := AStorage;
end;

function TcxSchedulerFilteredEventList.GetEvent(
  AIndex: Integer): TcxSchedulerControlEvent;
begin
  Result := TcxSchedulerControlEvent(FItems.List^[AIndex])
end;

{ TcxSchedulerCachedEventList }

constructor TcxSchedulerCachedEventList.Create;
begin
  inherited Create;
  FAbsoluteItems := TList.Create;
  FSelection := CreateSelection;
  FClones := CreateCloneList;
  FShowEventsWithoutResource := True;
  FTimeZone := -1;
end;

destructor TcxSchedulerCachedEventList.Destroy;
begin
  FreeAndNil(FClones);
  FreeAndNil(FSelection);
  FreeAndNil(FAbsoluteItems);
  inherited Destroy;
end;

procedure TcxSchedulerCachedEventList.CancelClones;
begin
  FClones.DestroyItems;
  Changed;
end;

function TcxSchedulerCachedEventList.CreateClones: TcxSchedulerEventList;
var
  I: Integer;
  AEvent: TcxSchedulerControlEvent;
begin
  FClones.DestroyItems;
  for I := 0 to Selection.Count - 1 do
  begin
    AEvent := CreateControlEvent(Selection.Items[I]);
    Selection.Items[I].FIsSource := True;
    AEvent.FIsClone := True;
    AEvent.FPattern := AEvent.Source.FPattern;
    FClones.Add(AEvent);
  end;
  Result := FClones;
  Changed;
end;

procedure TcxSchedulerCachedEventList.ExtractEvents(
  const ADate: TDateTime; AList: TcxSchedulerEventList);
var
  I: Integer;
  AEvent: TcxSchedulerEvent;
begin
  AList.Clear;
  for I := 0 to AbsoluteCount - 1 do
  begin
    AEvent := AbsoluteItems[I];
    if AEvent.IsDayEvent(ADate) and (AList.IndexOf(AEvent) = -1) then
      AList.Add(AEvent);
  end;
end;

procedure TcxSchedulerCachedEventList.ExtractUsedDays(AList: TcxSchedulerDateList);
var
  I: Integer;
begin
  AList.Count := 0;
  //DELPHI8! check Trunc()
  for I := Trunc(FStart) to Trunc(FFinish) do
    if IsDayNoneEmpty(I) then AList.Add(I);
end;

procedure TcxSchedulerCachedEventList.PostClones(ACopy: Boolean);
var
  I: Integer;
begin
  Storage.BeginUpdate;
  try
    for I := 0 to FClones.Count - 1 do
      InternalPost(TcxSchedulerControlEvent(FClones[I]), ACopy);
  finally
    Storage.EndUpdate;
  end;
  Selection.Clear;
  CancelClones;
end;

procedure TcxSchedulerCachedEventList.PostEvent(
  AEvent: TcxSchedulerControlEvent);
begin
  if AEvent.EventType in [etNone, etCustom] then
    PostCloneForSimpleEvent(AEvent, False, AEvent.EventType)
  else
    if AEvent.EventType = etOccurrence then
      PostCloneForSimpleEvent(AEvent, True, etCustom)
end;

procedure TcxSchedulerCachedEventList.Sort(ACompare: TcxCompareEventsProc);
begin
  inherited Sort(ACompare);
  FAbsoluteItems.Sort(TListSortCompare(@ACompare));
end;

procedure TcxSchedulerCachedEventList.Changed;
var
  I: Integer;
  AEvent: TcxSchedulerEvent;
begin
  FAbsoluteItems.Count := 0;
  FAbsoluteItems.Capacity := GetAbsoluteCountInternal;
  for I := 0 to GetAbsoluteCountInternal - 1 do
  begin
    AEvent := GetAbsoluteItemInternal(I);
    if (AEvent.Start <= SelFinish) and (SelStart <= AEvent.Finish) then
      FAbsoluteItems.Add(GetAbsoluteItemInternal(I));
  end;
  Selection.Update;
  inherited Changed;
end;

procedure TcxSchedulerCachedEventList.CheckEvent(
  AEvent: TcxSchedulerEvent; const AResourceID: Variant); 
begin
  if CheckEventVisibility(AEvent, ShowEventsWithoutResource) then
    inherited CheckEvent(AEvent, AResourceID);
end;

function TcxSchedulerCachedEventList.CheckEventVisibility(
  AEvent: TcxSchedulerEvent; AIncludeUnassigned: Boolean): Boolean;
var
  I: Integer;
  AItems: TcxSchedulerStorageResourceItems;
begin
  Result := VarIsNull(AEvent.ResourceID);
  if Result and AIncludeUnassigned then
    Exit
  else
  begin
    AItems := Storage.Resources.ResourceItems;
    Result := AItems.Count = 0;
    for I := 0 to AItems.Count - 1 do
      if AItems[I].Visible and AEvent.IsResourceEvent(AItems[I], False) then
      begin
        Result := True;
        Exit;
      end;
  end;
end;

function TcxSchedulerCachedEventList.CreateControlEvent(
  AEvent: TcxSchedulerEvent): TcxSchedulerControlEvent;
begin
  Result := inherited CreateControlEvent(AEvent);
  Result.FTimeBias := FTimeBias;
end;

function TcxSchedulerCachedEventList.CreateCloneList: TcxSchedulerFilteredEventList;
begin
  Result := TcxSchedulerFilteredEventList.Create;
end;

function TcxSchedulerCachedEventList.CreateSelection: TcxSchedulerEventSelection;
begin
  Result := TcxSchedulerEventSelection.Create(Self);
end;

procedure TcxSchedulerCachedEventList.DoClear(AFreeItems: Boolean);
begin
  if FClones <> nil then
    FClones.DestroyItems;
  inherited DoClear(True);
end;

procedure TcxSchedulerCachedEventList.EventAdded(
  AEvent: TcxSchedulerEvent);
begin
  TcxSchedulerControlEvent(AEvent).SelectionAdapter := Self;
  inherited EventAdded(AEvent);
end;

procedure TcxSchedulerCachedEventList.Init(
  const AStart, AFinish: TDateTime; AStorage: TcxCustomSchedulerStorage);
begin
  inherited Init(AStart, AFinish, AStorage);
  with TcxSchedulerDateTimeHelper do
  begin 
    if Storage.StoreUsingGlobalTime then
      FTimeBias := TimeZoneBias(FTimeZone)
    else
      FTimeBias := TimeZoneBias(FTimeZone) - TimeZoneBias(CurrentTimeZone);
  end;
end;

procedure TcxSchedulerCachedEventList.InternalPost(
  AEvent: TcxSchedulerControlEvent; ACopy: Boolean);
begin
  if AEvent.EventType = etNone then
    PostCloneForSimpleEvent(AEvent, ACopy, etNone)
  else
    PostCloneForRecurrenceEvent(AEvent, ACopy);
end;

function TcxSchedulerCachedEventList.IsDayNoneEmpty(ADay: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Count - 1 do
  begin
    Result := Items[I].IsDayEvent(ADay);
    if Result then Break;
  end;
end;

function TcxSchedulerCachedEventList.IsSelected(
  AEvent: TcxSchedulerControlEvent): Boolean;
begin
  Result := AEvent.IsClone or (Selection.IsSelected(AEvent) and
    (AlwaysShowSelectedEvent or (FClones.Count = 0)));
end;

procedure TcxSchedulerCachedEventList.PostCloneForRecurrenceEvent(
  AEvent: TcxSchedulerControlEvent; ACopy: Boolean);
const
  ANewType: array[Boolean] of TcxEventType = (etCustom, etNone);
begin
  if not ACopy and (AEvent.EventType = etOccurrence) then
    PostCloneForSimpleEvent(AEvent, True, etCustom)
  else
    PostCloneForSimpleEvent(AEvent, ACopy, ANewType[ACopy]);
end;

procedure TcxSchedulerCachedEventList.PostCloneForSimpleEvent(
  AEvent: TcxSchedulerControlEvent; ACopy: Boolean; AType: TcxEventType);
var
  AStorageEvent: TcxSchedulerEvent;
begin
  AEvent.Storage.BeginUpdate;
  try
    AEvent.EventType := AType;
    if ACopy then
    begin
      if AEvent.IsClone then
        TcxSchedulerControlEvent(AEvent.Source).FSource := Storage.CreateEvent
      else
        AEvent.FSource := Storage.CreateEvent;
    end;
    if AEvent.IsClone then
      AStorageEvent := TcxSchedulerControlEvent(AEvent.Source).Source
    else
      AStorageEvent := AEvent.Source;
    AStorageEvent.FPattern := AEvent.FPattern;
    AStorageEvent.BeginEditing;
    try
      AStorageEvent.Assign(AEvent);
      AStorageEvent.MoveTo(AEvent.Start + AEvent.TimeBias - Storage.TimeBias);
      if AType <> etNone then
        AStorageEvent.ParentID := AEvent.Pattern.ID;
    finally
      AStorageEvent.EndEditing;
      AStorageEvent.Post;
    end;
  finally
    AEvent.Storage.EndUpdate;
  end;
end;

procedure TcxSchedulerCachedEventList.SelectionAdd(
  AEvent: TcxSchedulerControlEvent; Shift: TShiftState);
begin
  Selection.Add(AEvent, Shift);
end;

procedure TcxSchedulerCachedEventList.SelectionClear;
begin
  Selection.Clear;
end;

procedure TcxSchedulerCachedEventList.SelectionUpdate;
begin
  Selection.Update;
end;

function TcxSchedulerCachedEventList._AddRef: Integer;
begin
  Result := -1;
end;

function TcxSchedulerCachedEventList._Release: Integer;
begin
  Result := -1;
end;

function TcxSchedulerCachedEventList.QueryInterface(
  const IID: TGUID; out Obj): HResult;
const
  E_NOINTERFACE = HResult($80004002);
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TcxSchedulerCachedEventList.GetAbsoluteCount: Integer;
begin
  Result := FAbsoluteItems.Count;
end;

function TcxSchedulerCachedEventList.GetAbsoluteItem(
  AIndex: Integer): TcxSchedulerControlEvent;
begin
  Result := TcxSchedulerControlEvent(FAbsoluteItems.List^[AIndex])
end;

function TcxSchedulerCachedEventList.GetAbsoluteCountInternal: Integer;
begin
  Result := Count + FClones.Count;
end;

function TcxSchedulerCachedEventList.GetAbsoluteItemInternal(
  AIndex: Integer): TcxSchedulerControlEvent;
begin
  if AIndex >= Count then
    Result := TcxSchedulerControlEvent(FClones.Items[AIndex - Count])
  else
    Result := Items[AIndex];
end;

function TcxSchedulerCachedEventList.GetItem(
  AIndex: Integer): TcxSchedulerControlEvent;
begin
  Result := TcxSchedulerControlEvent(FItems.List^[AIndex])
end;

{ TcxSchedulerOccurrenceCalculator }

constructor TcxSchedulerOccurrenceCalculator.Create(
  AEvent: TcxSchedulerEvent; const AStart, AFinish: TDateTime);
begin
  FWorkDays := TcxSchedulerDateTimeHelper.WorkDays;
  FStartOfWeek := TcxSchedulerDateTimeHelper.StartOfWeek;
  FEvent := AEvent;
  FIndex := -1;
  FVisibleStart := AStart;
  FVisibleFinish := AFinish;
  FRecurCount := FEvent.RecurrenceInfo.Count;
  if FRecurCount = 0 then
    FFinishDate := FEvent.RecurrenceInfo.Finish
  else
    FFinishDate := VisibleFinish;
  FOccurrenceStart := FEvent.Start;
  FOccurrenceFinish := FEvent.Finish;
  FDayNumber := FEvent.RecurrenceInfo.DayNumber;
  FDayType := FEvent.RecurrenceInfo.DayType;
  FOccurDays := FEvent.RecurrenceInfo.OccurDays;
  FPeriodicity := FEvent.RecurrenceInfo.Periodicity;
  FRecurrence := Event.RecurrenceInfo.Recurrence;
  FYearPeriodicity := Event.RecurrenceInfo.YearPeriodicity;
  Dec(FRecurCount);
end;

procedure TcxSchedulerOccurrenceCalculator.CalcOccurrence(AIndex: Integer);
begin
  FIndex := -1;
  FFinishDate := cxMaxDate;
  FRecurCount := -1;
  while (AIndex > 0) and GetNextOccurrence do
    Dec(AIndex);
end;

function TcxSchedulerOccurrenceCalculator.GetNextOccurrence: Boolean;
var
  AOccurrenceStartBeforeEventStart: Boolean;
begin
  Result := False;
  AOccurrenceStartBeforeEventStart := False;
  if not IsValidOccurrence then Exit;
  repeat
    //DELPHI8! check Trunc()
    FDate := Trunc(FOccurrenceStart);
    case FRecurrence of
      cxreWeekly:
      begin
        FWeekStart := FDate - (DayOfWeek(FDate) - 1) + StartOfWeek;
        if FWeekStart > FDate then Dec(FWeekStart, 7);
      end;
      cxreMonthly:
        DecodeDate(FDate, FYear, FMonth, FDay);
      cxreYearly:
      begin
        DecodeDate(FDate, FYear, FMonth, FDay);
        FMonth := FPeriodicity;
      end;
    end;
    if (FIndex = - 1) and not AOccurrenceStartBeforeEventStart then
      CalcFirstDate
    else
      CalcNextDate;
    AOccurrenceStartBeforeEventStart := True;
    FOccurrenceFinish := FDate + (FOccurrenceFinish - DateOf(FOccurrenceStart));
    FOccurrenceStart := FDate + TimeOf(FOccurrenceStart);
  until DateOf(FOccurrenceStart) >= DateOf(FEvent.Start);
  Result := IsValidOccurrence;
  Inc(FIndex);
end;

function TcxSchedulerOccurrenceCalculator.GetOccurrenceCount(
  AEndDate: TDateTime): Integer;
begin
  Result := 0;
  FFinishDate := AEndDate;
  FIndex := -1;
  FRecurCount := -1;
  while GetNextOccurrence do
    Inc(Result);
end;

procedure TcxSchedulerOccurrenceCalculator.CalcFirstDate;
begin
  //DELPHI8! check Trunc()
  FDate := Trunc(FOccurrenceStart);
  case FRecurrence of
    cxreDaily:
      if FDayType in [cxdtWeekDay, cxdtWeekEndDay] then
        FDate := GetSomeDay(FDate, 1, FDayType = cxdtWeekEndDay);
    cxreWeekly:
    begin
      FWeekStart := FDate - (DayOfWeek(FDate) - 1) + StartOfWeek;
      if FWeekStart > FDate then Dec(FWeekStart, 7);
      FDate := GetDayFromOccurDays(FDate - 1, 1);
    end;
    cxreMonthly:
    begin
      DecodeDate(FDate, FYear, FMonth, FDay);
      FDate := GetDayForMonth;
    end;
    cxreYearly:
    begin
      DecodeDate(FDate, FYear, FMonth, FDay);
      FMonth := FPeriodicity;
      FDate := GetDayForMonth;
      if FDate < DateOf(FOccurrenceStart) then
      begin
        Inc(FYear);
        FDate := GetDayForMonth;
      end;
    end;
  end;
end;

procedure TcxSchedulerOccurrenceCalculator.CalcNextDate;
var
  ADay: Word;
begin
  case FRecurrence of
    cxreDaily:
      if FDayType = cxdtEveryDay then
        Inc(FDate, FPeriodicity)
      else
        FDate := GetSomeDay(FDate + 1, 1, FDayType = cxdtWeekEndDay);
    cxreWeekly:
      FDate := GetDayFromOccurDays(FDate, FPeriodicity);
    cxreMonthly:
    begin
      IncAMonth(FYear, FMonth, ADay, FPeriodicity);
      FDate := GetDayForMonth;
    end;
    cxreYearly:
    begin
      Inc(FYear, FYearPeriodicity);
      FDate := GetDayForMonth;
    end;
  end;
end;

function TcxSchedulerOccurrenceCalculator.GetCertainDay(
  const ADate, ANumber: Integer; ADayType: TcxDayType): Integer;
var
  AYear, AMonth, ADay: Word;
  AOffset: Integer;
begin
  DecodeDate(ADate, AYear, AMonth, ADay);
  AOffset := Ord(ADayType) - Ord(cxdtSunDay) - (DayOfWeek(ADate - ADay + 1) - 1);
  if AOffset < 0 then Inc(AOffset, 7);
  Inc(AOffset, (ANumber - 1) * 7);
  if AOffset > DaysInAMonth(AYear, AMonth) - 1 then Dec(AOffset, 7);
  Result := ADate - ADay + 1 + AOffset;
end;

function TcxSchedulerOccurrenceCalculator.GetDayForMonth: Integer;

  function GetADay(const ADate: Integer; ACondition: Boolean): Integer;
  begin
    if ACondition then
      Result := ADate + DaysInAMonth(FYear, FMonth)
    else
      Result := ADate + FDayNumber;
  end;

begin
  Result := Trunc(EncodeDate(FYear, FMonth, 1)) - 1;
  case FDayType of
    cxdtDay:
      Result := GetADay(Result, FDayNumber > DaysInAMonth(FYear, FMonth));
    cxdtEveryDay:
      Result := GetADay(Result, FDayNumber = 5);
    cxdtWeekDay, cxdtWeekEndDay:
      Result := GetSomeDay(Result + 1, FDayNumber, FDayType = cxdtWeekEndDay);
    cxdtSunday..cxdtSaturday:
      Result := GetCertainDay(Result + 1, FDayNumber, FDayType);
  end;
end;

function TcxSchedulerOccurrenceCalculator.GetDayFromOccurDays(
  const APrevDate, APeriodicity: Integer): Integer;
var
  ADelta: Integer;
  ADay: TDay;
begin
  repeat
    for ADelta := 0 to 6 do
    begin
      ADay := TDay(StartOfWeek + ADelta - 7 * Byte(StartOfWeek + ADelta > 6));
      if ADay in FOccurDays then
      begin
        Result := FWeekStart + ADelta;
        if Result > APrevDate then Exit;
      end;
    end;
    Inc(FWeekStart, 7 * APeriodicity);
  until False;
end;

function TcxSchedulerOccurrenceCalculator.GetSomeDay(
  const ADate, ANumber: Integer; AWeekEnd: Boolean): Integer;
var
  AYear, AMonth, ADay: Word;
  I: Integer;
begin
  if ANumber = 5 then
  begin
    DecodeDate(ADate, AYear, AMonth, ADay);
    Result := ADate - ADay + DaysInAMonth(AYear, AMonth);
    while not (AWeekEnd xor (TDay(DayOfWeek(Result) - 1) in WorkDays)) do
      Dec(Result);
  end
  else
  begin
    Result := ADate;
    I := 1;
    repeat
      while not (AWeekEnd xor (TDay(DayOfWeek(Result) - 1) in WorkDays)) do
        Inc(Result);
      if ANumber = I then Break;
      Inc(Result);
      Inc(I);
    until False;
  end;
end;

function TcxSchedulerOccurrenceCalculator.IsValidOccurrence: Boolean;
begin
  Result := ((FRecurCount >= 0) and (FIndex < FRecurCount)) or
    ((FRecurCount < 0) and (DateOf(FOccurrenceStart) <= FFinishDate));
end;

end.
