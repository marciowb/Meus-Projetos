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
{$IFDEF DELPHI6}
  Variants, DateUtils,
{$ENDIF}
  Classes, SysUtils, Windows, Forms, Math, Graphics, cxClasses, cxCustomData,
  cxDataStorage, cxDateUtils, cxDataUtils, cxSchedulerUtils, cxVariants,
  cxStorage, ExtCtrls, cxLookAndFeels, Controls, ImgList, cxFormats;

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

  cxInvalidRecordIndex = -MaxInt;
  ReminderRefreshInterval: Double = MinuteToTime / 2;

type
  TcxSchedulerControlEventID = class; 
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

  //reminders
  TcxSchedulerReminders = class;
  TcxSchedulerReminder = class;
  TcxSchedulerReminderClass = class of TcxSchedulerReminder;
  TcxSchedulerEventConflictsInfo = class; 

  TcxEventType = (etNone, etPattern, etOccurrence, etException, etCustom);
  TcxRecurrence = (cxreDaily, cxreWeekly, cxreMonthly, cxreYearly);
  TcxRecurrenceValidStatus = (rvsValid, rvsReplaceOccurrenceDate, rvsInvalidPattern,
    rvsInvalidDuration);

  TcxDayType = (cxdtDay, cxdtEveryDay, cxdtWeekDay, cxdtWeekEndDay, cxdtSunday,
    cxdtMonday, cxdtTuesday, cxdtWednesday, cxdtThursday, cxdtFriday, cxdtSaturday);

  TcxCompareEventsProc = function(AEvent1, AEvent2: TcxSchedulerEvent): Integer;
  TcxGetRecurrenceDescriptionStringProc = function(
    ARecurrenceInfo: TcxSchedulerEventRecurrenceInfo;
    AFullDescription: Boolean = False): string;

  TcxSchedulerReminderDueTimeElement = (dteMinute, dteHour, dteDay, dteWeek);

  TcxSchedulerReminderDueTimeKind = (dtkNow, dtkOverdue, dtkActual);

  TcxSchedulerReminderDueTimeInfo = record
    DueKind: TcxSchedulerReminderDueTimeKind;
    Element: TcxSchedulerReminderDueTimeElement;
    ElementValue: Integer;
    Minutes: Integer;
  end;

  TcxDueTimeInfoToTextProc = function (
    const AInfo: TcxSchedulerReminderDueTimeInfo): string;

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
    DismissDate: Integer;
  end;

  TcxSchedulerEventRecurrenceInfo = class(TPersistent)
  private
    FOwner: TcxSchedulerEvent;
    function GetCount: Integer;
    function GetDayNumber: Integer;
    function GetDayType: TcxDayType;
    function GetDismissDate: TDateTime;
    function GetFinish: TDateTime;
    function GetIsInfinity: Boolean;
    function GetOccurDays: TDays;
    function GetPeriodicity: Integer;
    function GetRecurrence: TcxRecurrence;
    function GetStart: TDateTime;
    function GetStorage: TcxCustomSchedulerStorage;
    function GetYearPeriodicity: Integer;
    procedure SetCount(const AValue: Integer);
    procedure SetDayNumber(const AValue: Integer);
    procedure SetDayType(const AValue: TcxDayType);
    procedure SetDismissDate(const AValue: TDateTime);
    procedure SetFinish(AValue: TDateTime);
    procedure SetOccurDays(const AValue: TDays);
    procedure SetPeriodicity(const AValue: Integer);
    procedure SetRecurrence(const AValue: TcxRecurrence);
    procedure SetStart(const AValue: TDateTime);
    procedure SetYearPeriodicity(const AValue: Integer);
  protected
    procedure AssignDefaultValues; virtual;
    function GetData: TcxSchedulerEventRecurrenceInfoData;
    function GetOccurrences(AList: TcxSchedulerFilteredEventList; const AStart, AFinish: TDateTime): Boolean;
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
    function GetEndDate: TDateTime;
    function GetValidStatus: TcxRecurrenceValidStatus;
    procedure Validate;

    property Count: Integer read GetCount write SetCount;
    property DayNumber: Integer read GetDayNumber write SetDayNumber;
    property DayType: TcxDayType read GetDayType write SetDayType;
    property DismissDate: TDateTime read GetDismissDate write SetDismissDate;
    property Event: TcxSchedulerEvent read FOwner;
    property Finish: TDateTime read GetFinish write SetFinish;
    property IsInfinity: Boolean read GetIsInfinity; 
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
    FSkipExceptions: Boolean;
    FStorage: TcxCustomSchedulerStorage;
    FRecurrenceInfo: TcxSchedulerEventRecurrenceInfo;
    function GetActualFinish: Integer;
    function GetActualStart: Integer;
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
    function GetReadOnly: Boolean;
    function GetRecurrenceIndex: Integer;
    function GetReminder: Boolean;
    function GetReminderDate: TDateTime;
    function GetReminderMinutesBeforeStart: Integer;
    function GetResourceID: Variant;
    function GetShared: Boolean;
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
    procedure SetReminderDate(AValue: TDateTime);
    procedure SetReminderMinutesBeforeStart(const AValue: Integer);
    procedure SetResourceID(const AValue: Variant);
    procedure SetStart(const AValue: TDateTime);
    procedure SetState(const AValue: Integer);
  protected
    FEditCount: Integer;
    FEditValues: array of Variant;
    FPattern: TcxSchedulerEvent;
    FRecordIndex: Integer;
    FIndex: Integer;
    FIsDataValid: Boolean;
    FIsDeletion: Boolean;
    FFinish, FStart: Double;
    FStartDate: Integer;
    FOptions: Integer;
    FSavedID: Variant;
//    FSkipModified: Boolean;
    procedure AssignDefaultValues; virtual;
    procedure CalculateActualTimeRange;
    procedure CalculateActualTimeRangePost;
    procedure CheckRecurrenceLink(AEvent: TcxSchedulerEvent);
    procedure CheckRecurrenceLinkEx(AEvent: TcxSchedulerEvent);
    function CheckTimeRange(const AStartDate, AFinishDate: Integer): Boolean;
    function CreateRecurrenceInfo: TcxSchedulerEventRecurrenceInfo; virtual;
    function GetIsFreeState: Boolean; virtual;
    function GetOccurrenceByIndex(AIndex: Integer; var AOccurrence: TcxSchedulerEvent): Boolean;
    function GetOwner: TPersistent; override;
    function GetParentID: Variant; virtual; 
    function GetRecurrenceInfoValue(var AValue: string): Boolean; virtual;
    procedure GetStartFinishTime(var AStart, AFinish: TDateTime);
    function GetValueByIndex(AIndex: Integer): Variant; virtual;
    function GetValueDef(AField: TcxCustomSchedulerStorageField; const ADefValue: Variant): Variant;
    procedure Modified;
    procedure PostEditingData;
    procedure SetActualTimeRange(const ActualStart, ActualFinish: TDateTime);
    procedure SetRecordIndex(const AIndex: Integer);
    procedure SetRecurrenceInfoValue(const AValue: string); virtual;
    procedure SetValue(AField: TcxCustomSchedulerStorageField; const AValue: Variant);
    procedure SetValueByIndex(AIndex: Integer; const AValue: Variant); virtual;
    function TimeBias: Double; virtual;
    procedure UpdateTemporaryData;

    property IsFreeState: Boolean read GetIsFreeState;
    property IsModified: Boolean read FIsModified write FIsModified;
    property IsNewEvent: Boolean read GetIsNewEvent;
    property Link: TcxSchedulerEvent read FLink;
  public
    constructor Create(AStorage: TcxCustomSchedulerStorage); overload; virtual;
    constructor Create(AStorage: TcxCustomSchedulerStorage; ARecordIndex: Integer); overload; virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure AssignAttributes(ASource: TcxSchedulerEvent; AUseSourceTime: Boolean = True); virtual;
    procedure BeginEditing; virtual;
    procedure Cancel;
    procedure EndEditing; virtual;
    procedure Delete; virtual;
    procedure DeleteExceptions;
    function HasExceptions: Boolean;
    function Conflicts(AExceptEventsWithoutResources: Boolean): Boolean;
    function CreateConflictsInfo(AExceptEventsWithoutResources: Boolean): TcxSchedulerEventConflictsInfo;
    // resource sharing
    procedure ShareWithResource(AResourceItem: TcxSchedulerStorageResourceItem); overload;
    procedure ShareWithResource(AResourceID: Variant); overload;
    function IsSharedWithResource(AResourceItem: TcxSchedulerStorageResourceItem): Boolean; overload;
    function IsSharedWithResource(AResourceID: Variant): Boolean; overload;
    procedure UnshareWithResource(AResourceItem: TcxSchedulerStorageResourceItem); overload;
    procedure UnshareWithResource(AResourceID: Variant); overload;
    procedure ReplaceResourceID(AResourceID: Variant);

    //custom fields routines
    function GetCustomFieldValueByIndex(AIndex: Integer): Variant;
    function GetCustomFieldValueByName(const AName: String): Variant;
    function GetCustomFieldValue(ACustomField: TcxCustomSchedulerStorageField): Variant;
    procedure SetCustomFieldValueByIndex(AIndex: Integer; const AValue: Variant);
    procedure SetCustomFieldValueByName(const AName: string; const AValue: Variant);
    procedure SetCustomFieldValue(ACustomField: TcxCustomSchedulerStorageField; const AValue: Variant);
    //
    function GetOccurrence(ADate: TDateTime): TcxSchedulerEvent;
    function GetOriginalDate: TDateTime;
    function GetResourceItem: TcxSchedulerStorageResourceItem;
    function GetRecurrenceChain: TcxSchedulerEventList;
    function IsDayEvent(ADate: Integer): Boolean; overload;
    function IsDayEvent(const ADate: TDateTime): Boolean; overload;
    function IsRecurring: Boolean;
    function IsResourceEvent(AResource: TcxSchedulerStorageResourceItem;
      AllowUnassigned: Boolean): Boolean;
    procedure MoveTo(const AStartTime: TDateTime);
    procedure Post;
    procedure RemoveRecurrence; virtual;

    property ActualStart: Integer read GetActualStart;
    property ActualFinish: Integer read GetActualFinish;
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
    property Reminder: Boolean read GetReminder write SetReminder;
    property ReminderDate: TDateTime read GetReminderDate write SetReminderDate;
    property ReminderMinutesBeforeStart: Integer read GetReminderMinutesBeforeStart write SetReminderMinutesBeforeStart;
    property ResourceID: Variant read GetResourceID write SetResourceID;
    property Shared: Boolean read GetShared;
    property SkipExceptions: Boolean read FSkipExceptions write FSkipExceptions; 
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
    FIsEditing: Boolean;
    FIsSource: Boolean;
    FSelectionAdapter: IcxSchedulerSelectionAdapter;
    FSource: TcxSchedulerEvent;
    FTimeBias: Double;
    FValues: array of Variant;
    function GetSelected: Boolean;
    procedure SetSelected(AValue: Boolean);
  protected
    procedure ClearValues;
//    function GetParentID: Variant; override;
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

    property Pattern: TcxSchedulerEvent read FPattern write FPattern;
    property Selected: Boolean read GetSelected write SetSelected;
    property Source: TcxSchedulerEvent read FSource;
    property IsClone: Boolean read FIsClone;
    property IsDataValid: Boolean read FIsDataValid write FIsDataValid;
    property IsSource: Boolean read FIsSource;
    property IsEditing: Boolean read FIsEditing;
  end;

  TcxSchedulerEventClass = class of TcxSchedulerEvent;

  TcxSchedulerGetResourceNameEvent = procedure(Sender: TObject;
    AResource: TcxSchedulerStorageResourceItem; var AResourceName: string) of object;

  TcxSchedulerGetResourceImageIndexEvent = procedure(Sender: TObject;
    AResource: TcxSchedulerStorageResourceItem; var AImageIndex: TImageIndex) of object;

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
    FImageIndex: TImageIndex;
    FName: string;
    FReadOnly: Boolean;
    FResourceID: Variant;
    FVisible: Boolean;
    function GetActualImageIndex: TImageIndex;
    function GetResources: TcxSchedulerStorageResources;
  protected
    // methods            TList.Sort
    function GetDisplayName: string; override;
    procedure SetColor(const AValue: TColor); virtual;
    procedure SetImageIndex(const AValue: TImageIndex); virtual;
    procedure SetName(const AValue: string); virtual;
    procedure SetResourceID(const AValue: Variant); virtual;
    procedure SetVisible(const AValue: Boolean); virtual;
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;

    property ActualImageIndex: TImageIndex read GetActualImageIndex;
    property Resources: TcxSchedulerStorageResources read GetResources;
  published
    property Name: string read FName write SetName;
    property Color: TColor read FColor write SetColor default clDefault;
    property ImageIndex: TImageIndex read FImageIndex write SetImageIndex default -1;
    property ResourceID: Variant read FResourceID write SetResourceID;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property Visible: Boolean read FVisible write SetVisible default True;
  end;

  { TcxSchedulerStorageResources }

  TcxSchedulerStorageResources = class(TcxInterfacedPersistent, IcxStoredObject)
  private
    FImages: TCustomImageList;
    FItems: TcxSchedulerStorageResourceItems;
    FOwner: TcxCustomSchedulerStorage;
    FRestoringItems: TList;
    FOnGetResourceImageIndex: TcxSchedulerGetResourceImageIndexEvent;
    FOnGetResourceName: TcxSchedulerGetResourceNameEvent;
    function GetAreImagesUsed: Boolean;
    procedure SetImages(AValue: TCustomImageList);
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
    procedure DoneRestore;
    function DoGetResourceImageIndex(AItem: TcxSchedulerStorageResourceItem): TImageIndex; virtual;
    function DoGetResourceName(AItem: TcxSchedulerStorageResourceItem): string; virtual;
    function GetOwner: TPersistent; override;
    function GetResourceItems: TcxSchedulerStorageResourceItems; virtual;
    procedure InitRestore;

    property Storage: TcxCustomSchedulerStorage read FOwner;
  public
    constructor Create(AOwner: TcxCustomSchedulerStorage); reintroduce; virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetResourceName(AResource: TcxSchedulerStorageResourceItem): string;

    property AreImagesUsed: Boolean read GetAreImagesUsed;
    property ResourceItems: TcxSchedulerStorageResourceItems read GetResourceItems;
  published
    property Images: TCustomImageList read FImages write SetImages; 
    property Items: TcxSchedulerStorageResourceItems read FItems write SetItems;
    property OnGetResourceImageIndex: TcxSchedulerGetResourceImageIndexEvent read FOnGetResourceImageIndex write FOnGetResourceImageIndex;
    property OnGetResourceName: TcxSchedulerGetResourceNameEvent read FOnGetResourceName write FOnGetResourceName;
  end;

  TcxSchedulerNotificationEvent = procedure(Sender: TObject;
    AEvent: TcxSchedulerEvent; var AHandled: Boolean) of object;

  TcxSchedulerFilterEventEvent = procedure (Sender: TcxCustomSchedulerStorage;
    AEvent: TcxSchedulerEvent; var Accept: Boolean) of object;

  { TcxSchedulerEventConflictsInfo }

  TcxSchedulerEventConflictsInfo = class
  private
    FExceptEventsWithoutResources: Boolean;
    FConflictEvents: TcxSchedulerFilteredEventList;
    FExcludedEvent: TcxSchedulerEvent; 
    FEvent: TcxSchedulerEvent;
    FStorage: TcxCustomSchedulerStorage;
    FTimeRanges: TcxSchedulerTimeRanges;
    function GetHasConflicts: Boolean;
    function GetHasFreeTime: Boolean;
  protected
    ExcludedEventID: TcxSchedulerControlEventID;
    EventID: TcxSchedulerControlEventID;
    Start, Finish: TDateTime;
    ResourceID: Variant;
    procedure AddRange(AStart, AFinish: TDateTime);
    procedure CheckFreeTimeRanges;
    procedure CheckIntersectionWithEvents;
    procedure CheckSomeIntersection;
    function ExcludeFromCalculate(AEvent: TcxSchedulerEvent): Boolean;
    procedure ExpandRange(AEvent: TcxSchedulerEvent; var AIndex: Integer; var ALastPosition: TDateTime);
    procedure Init(AStorage: TcxCustomSchedulerStorage; AExceptEventsWithoutResources: Boolean; AResourceID: Variant;
      const AStart, AFinish: TDateTime);
    function IntersectEvents(ACheckedEvent: TcxSchedulerEvent): Boolean; overload;
    function IntersectEvents(AEvent1, AEvent2: TcxSchedulerEvent): Boolean; overload;
    function IntersectTime(const AStart, AFinish: TDateTime): Boolean; overload;
    function IntersectTime(const AStart, AFinish, AStart1, AFinish1: TDateTime): Boolean; overload;
    function IsSameEvent(ACheckedEvent: TcxSchedulerEvent): Boolean;
    function IsSameSeries(AEvent1, AEvent2: TcxSchedulerEvent): Boolean;
  public
    constructor Create(AEvent: TcxSchedulerEvent; AExceptEventsWithoutResources: Boolean); overload; virtual;
    constructor Create(AEvent: TcxSchedulerEvent; AExceptEventsWithoutResources: Boolean;
      const AStart, AFinish: TDateTime); overload; virtual;
    constructor Create(AStorage: TcxCustomSchedulerStorage; AExceptEventsWithoutResources: Boolean; const AStart, AFinish: TDateTime;
      AResourceID: Variant; AExcludedEvent: TcxSchedulerEvent = nil); overload; virtual;
    destructor Destroy; override;
    procedure Calculate(ACalculateFreeTime: Boolean = True); virtual;

    property ConflictEvents: TcxSchedulerFilteredEventList read FConflictEvents;
    property ExceptEventsWithoutResources: Boolean read FExceptEventsWithoutResources;
    property Event: TcxSchedulerEvent read FEvent;
    property HasConflicts: Boolean read GetHasConflicts;
    property HasFreeTime: Boolean read GetHasFreeTime;
    property Storage: TcxCustomSchedulerStorage read FStorage;
    property TimeRanges: TcxSchedulerTimeRanges read FTimeRanges;
  end;

  TcxSchedulerEventConflictsInfoClass = class of TcxSchedulerEventConflictsInfo;

  { TcxCustomSchedulerStorage }

  TcxCustomSchedulerStorage = class(TComponent)
  private
    FDataController: TcxCustomDataController;
    FEditor: TForm;
    FInternalFields: TcxCustomSchedulerStorageFields;
    FIsChanged: Boolean;
    FIsDeletion: Boolean;
    FIsLoading: Boolean;
    FIsModified: Boolean;
    FInternalUpdate: Boolean;
    FListeners: TInterfaceList;
    FReminders: TcxSchedulerReminders;
    FResources: TcxSchedulerStorageResources;
    FRemindersEvents: TNotifyEvent;
    FResourcesEvents: TNotifyEvent;
    FStoreUsingGlobalTime: Boolean;
    FStoringName: string;
    FUpdateRemindersTimer: TTimer;
    FUseActualTimeRange: Boolean;
    FUserFields: TcxCustomSchedulerStorageFields;
    FOnEventDeleted: TcxSchedulerNotificationEvent;
    FOnEventInserted: TcxSchedulerNotificationEvent;
    FOnEventModified: TcxSchedulerNotificationEvent;
    FOnFilterEvent: TcxSchedulerFilterEventEvent;
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
    procedure SetOnFilterEvent(AValue: TcxSchedulerFilterEventEvent);
    procedure SetReminders(AValue: TcxSchedulerReminders);
    procedure SetResources(AValue: TcxSchedulerStorageResources);
    procedure SetStoreUsingGlobalTime(AValue: Boolean);
    procedure StartUpdateRemindersTimer;
    procedure StopUpdateRemindersTimer;
    procedure UpdateRemindersTimerEvent(Sender: TObject);
  protected
    EventsIndex: TList;
    FDeletedRecords: TList;
    FEventsList: TcxSchedulerEventList;
    FFields: TList;
    FLastEditedEvent: TcxSchedulerEvent;
    FNewEvents: TcxSchedulerEventList;
    LockCount: Integer;
    TimeBias: Double;
    // internal fields
    FActualFinishField: TcxCustomSchedulerStorageField;
    FActualStartField: TcxCustomSchedulerStorageField;
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
    FReminderDateField: TcxCustomSchedulerStorageField;
    FReminderMinutesBeforeStartField: TcxCustomSchedulerStorageField;
    FResourceIDField: TcxCustomSchedulerStorageField;
    FStartField: TcxCustomSchedulerStorageField;
    FStateField: TcxCustomSchedulerStorageField;
    function ActualTimeRangeAvailable: Boolean; virtual;
    procedure AddInternalField(var AField: TcxCustomSchedulerStorageField;
      AValueType: TcxValueTypeClass);
    procedure AddRecord; virtual;
    procedure CancelEvent(AEvent: TcxSchedulerEvent); virtual;
    function CanGetValueFromPattern(AIndex: Integer): Boolean; virtual;
    procedure Changed; virtual;
    procedure CreateDefaultFields; virtual;
    function CreateFields: TcxCustomSchedulerStorageFields; virtual;
    function CreateReminders: TcxSchedulerReminders; virtual;
    function CreateResources: TcxSchedulerStorageResources; virtual;
    procedure CreateSubClasses; virtual;
    procedure DestroySubClasses; virtual;
    procedure DoDeleteEvent(const ARecordIndex: Integer); virtual;
    procedure DoDestroyEvent(AEvent: TcxSchedulerEvent); virtual;
    function DoEventDeleted(AEvent: TcxSchedulerEvent): Boolean; virtual;
    function DoEventInserted(AEvent: TcxSchedulerEvent): Boolean; virtual;
    function DoEventModified(AEvent: TcxSchedulerEvent): Boolean; virtual;
    function DoFilterEvent(AEvent: TcxSchedulerEvent): Boolean; virtual; 
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
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
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

    procedure BeginUpdateDataController; virtual;
    procedure EndUpdateDataController; virtual;

    property DataController: TcxCustomDataController read FDataController;
    property Editor: TForm read FEditor write FEditor;
    property Fields: TcxCustomSchedulerStorageFields read FUserFields;
    property InternalFields: TcxCustomSchedulerStorageFields read FInternalFields;
    property IsChanged: Boolean read FIsChanged write FIsChanged;
    property IsDeletion: Boolean read FIsDeletion write FIsDeletion;
    property IsDestroying: Boolean read GetIsDestroying;
    property IsLoading: Boolean read GetIsLoading;
    property IsLocked: Boolean read GetIsLocked;
    property IsModified: Boolean read FIsModified;
    property IsUpdatingMode: Boolean read GetIsUpdatingMode;
    property LastEditedEvent: TcxSchedulerEvent read FLastEditedEvent;
    property Listeners: TInterfaceList read FListeners;
    property OnEventDeleted: TcxSchedulerNotificationEvent read FOnEventDeleted write FOnEventDeleted;
    property OnEventInserted: TcxSchedulerNotificationEvent read FOnEventInserted write FOnEventInserted;
    property OnEventModified: TcxSchedulerNotificationEvent read FOnEventModified write FOnEventModified;
    property OnFilterEvent: TcxSchedulerFilterEventEvent read FOnFilterEvent write SetOnFilterEvent;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure AddListener(AListener: IcxSchedulerStorageListener);
    procedure BeginUpdate;
    procedure CalculateEventActualTimeRanges;
    function CheckRequiredFields: Boolean; virtual;
    function createEvent: TcxSchedulerEvent; {CreateEvent conflicts with C++ macro}
    function CreateOccurrence(APattern: TcxSchedulerEvent; const ADate: TDateTime;
      AType: TcxEventType): TcxSchedulerEvent;
    procedure Clear; virtual;
    procedure DoneRestore;
    procedure EndUpdate;
    function FindAvailableAllDay(var AStart, AFinish: TDateTime;
      AResourceID: Variant; AExceptEventsWithoutResources: Boolean; ADuration: TDateTime = 0): Boolean;
    function FindAvailableTime(var AStart, AFinish: TDateTime; AllDay: Boolean; AResourceID: Variant;
      AExceptEventsWithoutResources: Boolean; ADuration: TDateTime = 0; AExcludedEvent: TcxSchedulerEvent = nil): Boolean; overload;
    function FindAvailableTime(AEvent: TcxSchedulerEvent;
      AExceptEventsWithoutResources: Boolean; var AStart, AFinish: TDateTime): Boolean; overload;
    procedure FullRefresh;
    function GetEventByID(const AID: Variant): TcxSchedulerEvent;
    function GetEvents(AList: TcxSchedulerFilteredEventList;
      const AStart, AFinish: TDateTime): Boolean; overload;
    function GetEvents(AList: TcxSchedulerFilteredEventList;
      const AStart, AFinish: TDateTime; const AResourceID: Variant): Boolean; overload;
    function GetFieldByName(const AName: string): TcxCustomSchedulerStorageField;
    function GetReminderEvents(ADateTime: TDateTime;
      AList: TcxSchedulerFilteredEventList): Boolean;
    procedure InitRestore;
    function IsActive: Boolean; virtual;
    function IsCaptionAvailable: Boolean; virtual;
    function IsLabelColorAvailable: Boolean; virtual;
    function IsLocationAvailable: Boolean; virtual;
    function IsMessageAvailable: Boolean; virtual;
    function IsRecurrenceAvailable: Boolean; virtual;
    function IsReminderAvailable: Boolean; virtual;
    function IsStateAvailable: Boolean; virtual;
    procedure PostEvents; virtual;
    procedure RemoveListener(AListener: IcxSchedulerStorageListener);

    property EventCount: Integer read GetEventCount;
    property Events[Index: Integer]: TcxSchedulerEvent read GetEvent write SetEvent;
    property FieldCount: Integer read GetFieldCount;
    property InternalUpdate: Boolean read FInternalUpdate;
    property Reminders: TcxSchedulerReminders read FReminders write SetReminders;
    property ResourceCount: Integer read GetResourceCount;
    property ResourceIDs[Index: Integer]: Variant read GetResourceID;
    property ResourceNames[Index: Integer]: string read GetResourceName;
    property Resources: TcxSchedulerStorageResources read FResources write SetResources;
    property StoringName: string read FStoringName write FStoringName;
    property Values[ARecordIndex, AFieldIndex: Integer]: Variant read GetValue write SetValue;
  published
    property UseActualTimeRange: Boolean read FUseActualTimeRange write FUseActualTimeRange default False; 
    property StoreUsingGlobalTime: Boolean read FStoreUsingGlobalTime write SetStoreUsingGlobalTime default False;
    property RemindersEvents: TNotifyEvent read FRemindersEvents write FRemindersEvents;
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
    property Reminders;
    property Resources;
    property OnEventDeleted;
    property OnEventInserted;
    property OnEventModified;
    property OnFilterEvent;
  end;

  { TcxSchedulerControlEventID }

  TcxSchedulerControlEventID = class
  public
    ID, ParentID: Variant;
    RecurrenceIndex: Integer;
    constructor Create(AEvent: TcxSchedulerEvent);
    function SameEvent(AEvent: TcxSchedulerEvent): Boolean;
    function Equals(AValue: TcxSchedulerControlEventID): Boolean;
  end;

  { TcxSchedulerReminderEventID }

  TcxSchedulerReminderEventID = class(TcxSchedulerControlEventID)
  public
    ReminderDate: TDateTime;
    constructor Create(AEvent: TcxSchedulerControlEvent);
    function SameEvent(AEvent: TcxSchedulerControlEvent): Boolean;
  end;

  { TcxSchedulerEventSelection }

  TcxEventSelectionChangedEvent = procedure (AEvent: TcxSchedulerControlEvent) of object;

  TcxSchedulerEventSelection = class(TcxIUnknownObject, IcxSchedulerSelectionAdapter)
  private
    FOnEventSelectionChanged: TcxEventSelectionChangedEvent;
    function GetCount: Integer;
    function GetItem(AIndex: Integer): TcxSchedulerControlEvent;
    function GetKey(AIndex: Integer): TcxSchedulerControlEventID;
    function GetKeyCount: Integer;
  protected
    FKeys: TList;
    FEvents: TList;
    FSourceEvents: TcxSchedulerEventList;
    procedure ClearKeys;
    function CreateItem(AEvent: TcxSchedulerControlEvent): TcxSchedulerControlEventID;
    procedure DoEventSelectionChanged(AEvent: TcxSchedulerControlEvent);
    function KeyIndexOf(AEvent: TcxSchedulerControlEvent): Integer;
    function IndexOf(AEvent: TcxSchedulerControlEvent): Integer;
    procedure InternalClear;
    procedure ReplaceSelection;

    property KeyCount: Integer read GetKeyCount;
    property Keys[Index: Integer]: TcxSchedulerControlEventID read GetKey;
  public
    constructor Create(ASourceEvents: TcxSchedulerEventList); virtual;
    destructor Destroy; override;
    procedure Add(AEvent: TcxSchedulerControlEvent; AShift: TShiftState);
    procedure Clear;
    function IsSelected(AEvent: TcxSchedulerControlEvent): Boolean;
    procedure Select(AEvent: TcxSchedulerEvent);
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
    FNow: TDateTime;
    FReminderEventsOnly: Boolean;
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
    function NeedAddOccurenceForReminder(AReminderStart: TDateTime; AEvent: TcxSchedulerEvent): Boolean;

    property Now: TDateTime read FNow;
  public
    destructor Destroy; override;
    property Finish: TDateTime read FFinish;
    property ReminderEventsOnly: Boolean read FReminderEventsOnly;
    property Start: TDateTime read FStart;
    property Storage: TcxCustomSchedulerStorage read FStorage;
    property Items[AIndex: Integer]: TcxSchedulerControlEvent read GetEvent; default;
    property Count;
  end;

  { TcxSchedulerCachedEventList }

  TcxSchedulerCachedEventList = class(TcxSchedulerFilteredEventList, IUnknown,
    IcxSchedulerSelectionAdapter)
  private
    FAbsoluteItems: TList;
    FAlwaysShowSelectedEvent: Boolean;
    FClones: TcxSchedulerFilteredEventList;
    FNewEvent: TcxSchedulerEvent;
    FSelStart: TDateTime;
    FSelFinish: TDateTime;
    FSelection: TcxSchedulerEventSelection;
    FShowEventsWithoutResource: Boolean;
    FTimeBias: Double;
    FTimeZone: Integer;
    function GetAbsoluteCount: Integer;
    function GetAbsoluteItem(AIndex: Integer): TcxSchedulerControlEvent;
    function GetAbsoluteCountInternal: Integer;
    function GetAbsoluteItemInternal(AIndex: Integer): TcxSchedulerControlEvent;
    function GetItem(AIndex: Integer): TcxSchedulerControlEvent;
    procedure SetSelFinish(const AValue: TDateTime);
    procedure SetSelStart(const AValue: TDateTime);
    // IcxSchedulerSelectionAdapter
    procedure IcxSchedulerSelectionAdapter.Add = SelectionAdd;
    procedure IcxSchedulerSelectionAdapter.Clear = SelectionClear;
    procedure IcxSchedulerSelectionAdapter.Update = SelectionUpdate;
  protected
    FBeforePostCount: Integer;
    FChangeRef: Integer;
    FExpandedTimeRange: Boolean;
    FHasClones: Boolean;
    FSavedIndex: Integer;
    FSavedPatternID, FSavedSourceID: Variant;
    FMinNecessaryDate: TDateTime;
    FMaxNecessaryDate: TDateTime;
    // IUnknown
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    //
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
    function IsIntersect(AEvent1, AEvent2: TcxSchedulerEvent): Boolean;
    function IsSelected(AEvent: TcxSchedulerControlEvent): Boolean; virtual;
    procedure PopulateAbsoluteItems;
    procedure PostCloneForRecurrenceEvent(AEvent: TcxSchedulerControlEvent; ACopy: Boolean); virtual;
    procedure PostCloneForSimpleEvent(AEvent: TcxSchedulerControlEvent;
      ACopy: Boolean; AType: TcxEventType); virtual;
    procedure PostNewEvent(AEvent: TcxSchedulerControlEvent);
    procedure SelectionAdd(AEvent: TcxSchedulerControlEvent; Shift: TShiftState); virtual;
    procedure SelectionClear; virtual;
    procedure SelectionUpdate; virtual;
 public
    constructor Create; override;
    destructor Destroy; override;
    procedure BeforeEditing(AEvent: TcxSchedulerControlEvent; AIsInplace: Boolean);
    procedure BeforeUpdate;
    procedure DeleteEvent(AEvent: TcxSchedulerControlEvent);
    procedure CalculateClonesRange(var AMinDate, AMaxDate: TDateTime);
    function CalculateNecessaryDate(var AMinDate, AMaxDate: TDateTime): Boolean;
    procedure CalculateSelectionRange(var AMinDate, AMaxDate: TDateTime);
    procedure CancelClones;
    function CreateEvent: TcxSchedulerControlEvent;
    function CreateClones: TcxSchedulerEventList;
    procedure ExtractEvents(const ADate: TDateTime; AList: TcxSchedulerEventList);
    procedure ExtractUsedDays(AList: TcxSchedulerDateList);
    function HasConflict(IsDragCopy: Boolean; AStartDrag: Boolean): Boolean;
    function HasIntersection(AEvent: TcxSchedulerControlEvent): Boolean; overload;
    function HasIntersection(AList: TList): Boolean; overload;
    function HasIntersection(AList1, AList2: TcxSchedulerEventList; AExcludeEquals: Boolean): Boolean; overload;
    function LastEditedEvent: TcxSchedulerControlEvent;
    procedure PostClones(ACopy: Boolean);
    procedure PostEvent(AEvent: TcxSchedulerControlEvent);
    procedure Sort(ACompare: TcxCompareEventsProc); override;
    //
    property AbsoluteCount: Integer read GetAbsoluteCount;
    property AbsoluteItems[Index: Integer]: TcxSchedulerControlEvent read GetAbsoluteItem;
    property AlwaysShowSelectedEvent: Boolean read FAlwaysShowSelectedEvent write FAlwaysShowSelectedEvent;
    property TimeZone: Integer read FTimeZone write FTimeZone;
    property Clones: TcxSchedulerFilteredEventList read FClones;
    property ShowEventsWithoutResource: Boolean read FShowEventsWithoutResource write FShowEventsWithoutResource;
    property SelStart: TDateTime read FSelStart write SetSelStart;
    property SelFinish: TDateTime read FSelFinish write SetSelFinish;
    property Selection: TcxSchedulerEventSelection read FSelection;
    property Items[Index: Integer]: TcxSchedulerControlEvent read GetItem; default;
  end;

  { TcxSchedulerOccuranceCalculator }

  TcxSchedulerOccurrenceCalculator = class
  protected
    FActualStart: TDateTime;
    FCalcForReminders: Boolean;
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
    //
    FOccurence: TcxSchedulerControlEvent;
    FOccurencePos: Integer;
    procedure CalcFirstDate;
    procedure CalcNextDate;
    function GetCertainDay(const ADate, ANumber: Integer; ADayType: TcxDayType): Integer;
    function GetDayForMonth: Integer; virtual;
    function GetDayFromOccurDays(const APrevDate, APeriodicity: Integer): Integer;
    function GetSomeDay(const ADate, ANumber: Integer; AWeekEnd: Boolean): Integer;
    procedure InitTimes;
    function IsValidOccurrence: Boolean;
  public
    constructor Create(AEvent: TcxSchedulerEvent; const AStart, AFinish: TDateTime;
      ACalcForReminders: Boolean = False);
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

  { TcxSchedulerCustomReminderForm }

  TcxSchedulerCustomReminderForm = class(TForm)
  private
    FReminders: TcxSchedulerReminders;
  protected
    procedure CheckFormPosition;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DoClose(var Action: TCloseAction); override;
    procedure DoShow; override;
    procedure FlashCaption;
    function GetFormColor: TColor; virtual;
    function IsLocked: Boolean; virtual;
    procedure OpenEvent(AEvent: TcxSchedulerControlEvent); virtual;
    function OpenEventSupported: Boolean; virtual;
    procedure RestoreSelection; virtual;
    procedure SaveSelection; virtual;
    procedure ShowInactive;
    procedure UpdateReminderList; virtual;
    procedure UpdateSelectionCaptions; virtual;

    property Reminders: TcxSchedulerReminders read FReminders;
  public
    constructor Create(AReminders: TcxSchedulerReminders); reintroduce; virtual;
    destructor Destroy; override;
  end;

  TcxSchedulerReminderFormClass = class of TcxSchedulerCustomReminderForm;

  { TcxSchedulerReminder }

  TcxSchedulerReminder = class
  private
    FEvent: TcxSchedulerControlEvent;
    FEventID: TcxSchedulerReminderEventID;
    FOwner: TcxSchedulerReminders;
    FValid: Boolean;
  protected
    procedure DismissEvent; virtual;
    procedure DoDismiss; virtual;
    procedure DoSnooze(var ASnoozeTime: TDateTime); virtual;
    function GetRecurrenceDismissDate: TDateTime; virtual;
    procedure SnoozeEvent(const ASnoozeTime: TDateTime); virtual;
    procedure Validate(AEvent: TcxSchedulerControlEvent);

    property Valid: Boolean read FValid;
  public
    constructor Create(AOwner: TcxSchedulerReminders;
      AEvent: TcxSchedulerControlEvent); virtual;
    destructor Destroy; override;
    procedure Dismiss;
    procedure Snooze(ASnoozeTime: TDateTime);
    property Event: TcxSchedulerControlEvent read FEvent;
    property EventID: TcxSchedulerReminderEventID read FEventID;
    property Owner: TcxSchedulerReminders read FOwner;
  end;

  { TcxSchedulerReminderList }

  TcxSchedulerReminderList = class(TList)
  private
    FClearing: Boolean;
    function GetItem(Index: Integer): TcxSchedulerReminder;
  public
    procedure Clear; override;
    function IndexOfEvent(AEvent: TcxSchedulerControlEvent): Integer;
    procedure Invalidate;

    property Clearing: Boolean read FClearing;
    property Items[Index: Integer]: TcxSchedulerReminder read GetItem; default;
  end;

  { TcxSchedulerReminders }

  TcxSchedulerReminderEvent = procedure (Sender: TcxSchedulerReminders;
    AReminder: TcxSchedulerReminder; var AHandled: Boolean) of object;
  TcxSchedulerRemindersEvent = procedure (Sender: TcxSchedulerReminders) of object;
  TcxSchedulerGetEventDueTimeTextEvent = procedure (
    Sender: TcxSchedulerReminders; AReminder: TcxSchedulerReminder;
    const ADueTimeInfo: TcxSchedulerReminderDueTimeInfo; var AText: string) of object;
  TcxSchedulerGetReminderWindowCaption = procedure (Sender: TcxSchedulerReminders;
    var ACaption: string) of object;
  TcxSchedulerSnoozeReminderEvent = procedure (Sender: TcxSchedulerReminders;
    AReminder: TcxSchedulerReminder; var ASnoozeTime: TDateTime; var AHandled: Boolean) of object;
  TcxSchedulerReminderOpenEvent = procedure (Sender: TcxSchedulerReminders;
    AEvent: TcxSchedulerControlEvent) of object;

  TcxSchedulerReminders = class(TcxInterfacedPersistent,
    IcxFormatControllerListener,
    IcxFormatControllerListener2,
    IdxSkinSupport)
  private
    FActive: Boolean;
    FDefaultMinutesBeforeStart: Integer;
    FDefaultReminder: Boolean;
    FEvents: TcxSchedulerFilteredEventList;
    FItems: TcxSchedulerReminderList;
    FReminderWindowLookAndFeel: TcxLookAndFeel;
    FNeedCloseWindow: Boolean;
    FNeedRestoreSelection: Boolean;
    FNeedShowWindow: Boolean;
    FReminderWindow: TcxSchedulerCustomReminderForm;
    FStorage: TcxCustomSchedulerStorage;
    FUpdateEventsTimer: TTimer;
    FUpdateRemindersTimer: TTimer;
    FUpdatingReminderList: Boolean;
    FUseReminderWindow: Boolean;
    FOnAlertReminder: TcxSchedulerReminderEvent;
    FOnDismissReminder: TcxSchedulerReminderEvent;
    FOnGetEventDueTimeText: TcxSchedulerGetEventDueTimeTextEvent;
    FOnOpenEvent: TcxSchedulerReminderOpenEvent;
    FOnSnoozeReminder: TcxSchedulerSnoozeReminderEvent;
    //reminder window events
    FOnGetReminderWindowCaption: TcxSchedulerGetReminderWindowCaption;
    FOnHideReminderWindow: TcxSchedulerRemindersEvent;
    FOnShowReminderWindow: TcxSchedulerRemindersEvent;
    procedure CreateTimers;
    function GetCount: Integer;
    function GetItem(Index: Integer): TcxSchedulerReminder;
    procedure SetActive(AValue: Boolean);
    procedure SetDefaultMinutesBeforeStart(AValue: Integer);
    procedure SetReminderWindowLookAndFeel(AValue: TcxLookAndFeel);
    procedure StartReminder;
    procedure StopReminder;
    procedure OnUpdateEventsTimer(Sender: TObject);
    procedure OnUpdateRemindersTimer(Sender: TObject);
  protected
    //IcxFormatControllerListener
    procedure FormatChanged;
    //IcxFormatControllerListener2
    procedure TimeChanged;

    procedure AddReminder(AEvent: TcxSchedulerControlEvent);
    procedure CheckAddReminder(AEvent: TcxSchedulerControlEvent);
    procedure CheckReminderForEvent(AEvent: TcxSchedulerControlEvent);
    procedure CheckReminderForRecurringEvent(
      AEvent: TcxSchedulerControlEvent; var AIndex: Integer);
    function CreateReminderWindow: TcxSchedulerCustomReminderForm; virtual;
    function DoAlertReminder(AReminder: TcxSchedulerReminder): Boolean; virtual;
    function DoDismissReminder(AReminder: TcxSchedulerReminder): Boolean; virtual;
    procedure DoGetEventDueTimeText(AReminder: TcxSchedulerReminder;
      const ADueTimeInfo: TcxSchedulerReminderDueTimeInfo; var AText: string);
    procedure DoGetReminderWindowCaption(var ACaption: string); virtual;
    procedure DoOpenEvent(AEvent: TcxSchedulerControlEvent); virtual;
    function DoSnoozeReminder(AReminder: TcxSchedulerReminder; var ASnoozeTime: TDateTime): Boolean; virtual;
    procedure DoHideReminderWindow; virtual;
    procedure DoShowReminderWindow; virtual;

    function GetNextPopulateEventsCacheTime(ANow: TDateTime; AIsLocked: Boolean): TDateTime; virtual;
    function GetNextRefreshRemindersTime(ANow: TDateTime; AIsLocked: Boolean): TDateTime; virtual;
    function GetNow: TDateTime; virtual;
    function GetReminderClass: TcxSchedulerReminderClass; virtual;
    function GetReminderWindowCaption: string;
    function IsNeedAddToReminders(AEvent: TcxSchedulerControlEvent): Boolean; virtual;
    function PopulateEventsCache: Boolean; virtual;
    procedure RefreshReminders; virtual;

    procedure RemoveGarbage;
    procedure StopTimers; virtual;
    procedure UpdateReminderList; virtual;
    procedure UpdateTimer(ATimer: TTimer; AInterval: TDateTime);
    procedure ValidateReminderList;

    property Events: TcxSchedulerFilteredEventList read FEvents;
    property NeedCloseWindow: Boolean read FNeedCloseWindow;
    property NeedRestoreSelection: Boolean read FNeedRestoreSelection write FNeedRestoreSelection;
    property NeedShowWindow: Boolean read FNeedShowWindow;
    property UpdateEventsTimer: TTimer read FUpdateEventsTimer;
    property UpdateRemindersTimer: TTimer read FUpdateRemindersTimer;
    property UpdatingReminderList: Boolean read FUpdatingReminderList;
  public
    constructor Create(AStorage: TcxCustomSchedulerStorage); reintroduce; virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    procedure DismissAll;
    procedure SnoozeAll(ASnoozeTime: TDateTime);

    function GetEventDueTimeText(AReminder: TcxSchedulerReminder;
      ATime: TDateTime): string;
    function HasReminders: Boolean;
    procedure HideReminderWindow;
    function IsLocked: Boolean; virtual;
    function IsReminderWindowShown: Boolean;
    procedure Refresh;
    procedure ShowReminderWindow;

    property Count: Integer read GetCount;
    property Items[Index: Integer]: TcxSchedulerReminder read GetItem; default;
    property ReminderWindow: TcxSchedulerCustomReminderForm read FReminderWindow;
    property Storage: TcxCustomSchedulerStorage read FStorage;
  published
    property Active: Boolean read FActive write SetActive default True;
    property DefaultMinutesBeforeStart: Integer
      read FDefaultMinutesBeforeStart write SetDefaultMinutesBeforeStart default 15;
    property DefaultReminder: Boolean read FDefaultReminder write FDefaultReminder default False;
    property ReminderWindowLookAndFeel: TcxLookAndFeel read FReminderWindowLookAndFeel write SetReminderWindowLookAndFeel;
    property UseReminderWindow: Boolean read FUseReminderWindow write FUseReminderWindow default True;
    // events
    property OnAlertReminder: TcxSchedulerReminderEvent
      read FOnAlertReminder write FOnAlertReminder;
    property OnDismissReminder: TcxSchedulerReminderEvent
      read FOnDismissReminder write FOnDismissReminder;
    property OnOpenEvent: TcxSchedulerReminderOpenEvent
      read FOnOpenEvent write FOnOpenEvent;
    property OnSnoozeReminder: TcxSchedulerSnoozeReminderEvent
      read FOnSnoozeReminder write FOnSnoozeReminder;

    property OnHideReminderWindow: TcxSchedulerRemindersEvent
      read FOnHideReminderWindow write FOnHideReminderWindow;
    property OnShowReminderWindow: TcxSchedulerRemindersEvent
      read FOnShowReminderWindow write FOnShowReminderWindow;

    property OnGetEventDueTimeText: TcxSchedulerGetEventDueTimeTextEvent
      read FOnGetEventDueTimeText write FOnGetEventDueTimeText;
    property OnGetReminderWindowCaption: TcxSchedulerGetReminderWindowCaption
      read FOnGetReminderWindowCaption write FOnGetReminderWindowCaption;
  end;

procedure cxCheckDaysList(AList: TList; var AStartDay, AFinishDay: Integer);
function cxGetRecurrenceDescriptionString(ARecurrenceInfo: TcxSchedulerEventRecurrenceInfo;
  AFullDescription: Boolean = False): string;
function cxRecurrenceInfoDataToString(const AData: TcxSchedulerEventRecurrenceInfoData): string;
function cxStringToRecurrenceInfoData(const S: string): TcxSchedulerEventRecurrenceInfoData;
function cxMinutesToDueTimeInfo(AMinutes: Integer): TcxSchedulerReminderDueTimeInfo;
function cxDueTimeInfoToText(const AInfo: TcxSchedulerReminderDueTimeInfo): string;

function cxCompareSchedulerControlEvents(
  AEvent1, AEvent2: TcxSchedulerControlEvent): Integer;

function cxFieldValueToVariant(const AValue: Variant): Variant;
function cxVariantToFieldValue(const AValue: Variant): Variant;

const
  cxGetRecurrenceDescriptionStringProc: TcxGetRecurrenceDescriptionStringProc =
    cxGetRecurrenceDescriptionString;
  cxDueTimeInfoToTextProc: TcxDueTimeInfoToTextProc = cxDueTimeInfoToText;
  cxSchedulerEventConflictsInfoClass: TcxSchedulerEventConflictsInfoClass =
    TcxSchedulerEventConflictsInfo;

  cxMaxCheckedDuration: Integer = 30;// div 2; todo:
  cxOriginalEventStates: array[Boolean] of Byte = (tlsBusy, tlsFree);

implementation

uses
  cxSchedulerStrs, cxSchedulerDialogs, cxSchedulerReminderWindow, Messages;

type
  TFlashWindowExProc = function (var pfwi: FLASHWINFO): BOOL; stdcall;
  PRestoringItem = ^TRestoringItem;
  TRestoringItem = record
    Item: TcxSchedulerStorageResourceItem;
    Index: Integer;
    Visible: Boolean;
  end;

const
  DefInfoData: TcxSchedulerEventRecurrenceInfoData =
    (Count: 10; DayNumber: 1; DayType: cxdtDay;  Finish: -1;
     OccurDays: []; Periodicity: 1; Recurrence: cxreDaily;
     Start: 0; YearPeriodicity: 1);

  PatternValidStatus: array[Boolean] of TcxRecurrenceValidStatus =
    (rvsInvalidPattern, rvsValid);

  FlashWindowExProc: TFlashWindowExProc = nil;

function VarEqualsSoftEx(const V1, V2: Variant): Boolean;
begin
  Result := not VarIsEmpty(V1) and not VarIsEmpty(V2) and
    (VarEquals(V1, V2){ or VarIsNull(V1) or VarIsNull(V2)});
end;

function VarIsEmptyEx(const V: Variant): Boolean;
begin
  Result := VarIsEmpty(V) or VarIsNull(V) or (VarIsStr(V) and (V = ''))
end;

function cxCompareEventsByID(AEvent1, AEvent2: TcxSchedulerEvent): Integer;
begin
  Result := VarCompare(AEvent1.FSavedID, AEvent2.FSavedID);
end;

function cxIntSortProc(P1, P2: Pointer): Integer;
begin
  Result := Integer(P1) - Integer(P2);
end;

function cxCompareSelectionKeys(AItem1, AItem2: TcxSchedulerControlEventID): Integer;
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

function cxGetRecurrenceDescriptionString(
  ARecurrenceInfo: TcxSchedulerEventRecurrenceInfo;
  AFullDescription: Boolean = False): string;
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

  function GetTimeBounds(APattern: TcxSchedulerEvent): string;
  begin
    if APattern.AllDayEvent and (APattern.Duration = 1) then Exit;
    Result := ' from ' + FormatDateTime('t', APattern.Start);
    if APattern.Duration < 1 then
      Result := Result + ' to ' + FormatDateTime('t', APattern.Finish)
    else
      Result := Result + ' for ' + cxMinutesToTextProc(Round(APattern.Duration / MinuteToTime));
  end;

  function GetDateBounds(APattern: TcxSchedulerEvent): string;
  begin
    Result := ' effective ' + FormatDateTime('ddddd', ARecurrenceInfo.Start);
    if ARecurrenceInfo.Count >= 0 then
      Result := Result + ' until ' + FormatDateTime('ddddd', ARecurrenceInfo.GetEndDate);
  end;

var
  ADayStr, AWeekStr, AMonthStr: string;
  APattern: TcxSchedulerEvent;
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
    if Event.EventType = etPattern then
      APattern := Event
    else
    begin
      APattern := Event.Pattern;
      if APattern = nil then
        APattern := Event;
    end;    
    if AFullDescription then
      Result := 'Occurs ' + Result + GetDateBounds(APattern) + GetTimeBounds(APattern) + '.'
    else
      Result := Result + GetTimeBounds(APattern);
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

function cxMinutesToDueTimeInfo(AMinutes: Integer): TcxSchedulerReminderDueTimeInfo;
const
  MinsPerWeek = MinsPerDay * DaysPerWeek;
begin
  with Result do
  begin
    if AMinutes = 0 then
    begin
      DueKind := dtkNow;
      Minutes := 0;
      Element := dteMinute;
      ElementValue := 0;
      Exit;
    end;
    if AMinutes < 0 then
      DueKind := dtkOverdue
    else
      DueKind := dtkActual;
    AMinutes := Abs(AMinutes);
    Minutes := AMinutes;
    case AMinutes of
      1..MinsPerHour - 1:
        begin
          Element := dteMinute;
          ElementValue := AMinutes;
        end;
      MinsPerHour..MinsPerDay - 1:
        begin
          Element := dteHour;
          ElementValue := AMinutes div MinsPerHour;
        end;
      MinsPerDay..MinsPerWeek - 1:
        begin
          Element := dteDay;
          ElementValue := AMinutes div MinsPerDay;
        end
      else
      begin
        Element := dteWeek;
        ElementValue := AMinutes div MinsPerWeek;
      end
    end;
  end;
end;

function cxDueTimeInfoToText(const AInfo: TcxSchedulerReminderDueTimeInfo): string;
const
  PluralPostfix: array[Boolean] of string = ('', 's');
  ElementNames: array[TcxSchedulerReminderDueTimeElement] of string  =
    ('minute', 'hour', 'day', 'week');
  DueInFormatTexts: array[Boolean] of string = ('%d %s%s', '%d %s%s overdue');
begin
  with AInfo do
  begin
    if DueKind = dtkNow then
      Result := 'Now'
    else
      Result := Format(DueInFormatTexts[DueKind = dtkOverdue],
        [ElementValue, ElementNames[Element], PluralPostfix[ElementValue > 1]]);
  end;
end;

function cxCompareSchedulerControlEvents(
  AEvent1, AEvent2: TcxSchedulerControlEvent): Integer;
var
  AAllDay1, AAllDay2: Boolean;
begin
  AAllDay1 := AEvent1.AllDayEvent or (AEvent1.Duration >= 1);
  AAllDay2 := AEvent2.AllDayEvent or (AEvent2.Duration >= 1);
  Result := Byte(AAllDay2) - Byte(AAllDay1);
  if Result <> 0 then Exit; 
  if AEvent1.Start < AEvent2.Start then
    Result := -1
  else
    if AEvent1.Start > AEvent2.Start then
      Result := 1
    else
      if AEvent1.Finish > AEvent2.Finish then
        Result := -1
      else
        if AEvent1.Finish < AEvent2.Finish then
          Result := 1
        else
          if AEvent1.RecordIndex < AEvent2.RecordIndex then
            Result := -1
          else
            if AEvent1.RecordIndex > AEvent2.RecordIndex then
              Result := 1
            else
              Result := 0;
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
    if TcxSchedulerEventRecurrenceInfo(Source).GetValue(S) then
      SetValue(S)
    else
      SetValue('');
  end
  else
    inherited Assign(Source);
end;

function TcxSchedulerEventRecurrenceInfo.GetEndDate: TDateTime;
begin
  if Count > 0 then
    with TcxSchedulerOccurrenceCalculator.Create(FOwner, 0, cxMaxDate) do
    try
      CalcOccurrence(Self.Count);
      Result := DateOf(OccurrenceStart);
    finally
      Free;
    end
  else
    if Count = 0 then
      Result := Finish
    else
      Result := NullDate;
end;

function TcxSchedulerEventRecurrenceInfo.GetValidStatus: TcxRecurrenceValidStatus;

  function IntersectOccurrences(APrevFinish, AStart: TDateTime): Boolean;
  begin
    if FOwner.AllDayEvent then
      Result := DateOf(AStart) < DateOf(APrevFinish)
    else
      Result := AStart < APrevFinish;
  end;

var
  AEdge, AFinish: TDateTime;
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
      if FOwner.RecurrenceInfo.Count = 1 then Exit;
      AFinish := OccurrenceFinish;
      AEdge := OccurrenceStart + 14; //two weeks
      repeat
        if not GetNextOccurrence then Exit;
        if IntersectOccurrences(AFinish, OccurrenceStart) then
        begin
          Result := rvsInvalidDuration;
          Exit;
        end;
        AFinish := OccurrenceFinish;
      until not (Recurrence in [cxreDaily, cxreWeekly]) or (OccurrenceStart > AEdge);
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

function TcxSchedulerEventRecurrenceInfo.GetOccurrences(
  AList: TcxSchedulerFilteredEventList; const AStart, AFinish: TDateTime): Boolean;
var
  ActualStart: TDateTime;
begin
  ActualStart := AStart;
  if not (FOwner.EventType in [etPattern, etNone]) and (FOwner.Pattern <> nil) then
    ActualStart := FOwner.Pattern.Start;
  AList.Init(Trunc(ActualStart), AFinish, Storage);
  if (FOwner.EventType = etPattern) or FOwner.SkipExceptions then
  begin
    AList.FReminderEventsOnly := False;
    AList.CheckEvent(FOwner, Null);
    AList.Changed;
  end; 
  Result := AList.Count > 0;
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

function TcxSchedulerEventRecurrenceInfo.GetDismissDate: TDateTime;
begin
  Result := GetData.DismissDate;
end;

function TcxSchedulerEventRecurrenceInfo.GetFinish: TDateTime;
begin
  Result := GetData.Finish - FOwner.TimeBias;
end;
                                                      
function TcxSchedulerEventRecurrenceInfo.GetIsInfinity: Boolean;
begin
  with GetData do 
    Result := (Count = 0) and (Finish = -1);
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

procedure TcxSchedulerEventRecurrenceInfo.SetDismissDate(
  const AValue: TDateTime);
var
  ADate: Integer; 
begin
  ADate := Trunc(AValue);
  SetDataItem(@DefInfoData.DismissDate, SizeOf(Integer), ADate);
end;

procedure TcxSchedulerEventRecurrenceInfo.SetFinish(
  AValue: TDateTime);
begin
  AValue := DateTimeHelper.RoundTime(AValue) + FOwner.TimeBias;
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
//    FSkipModified := True;
    try
      for I := 0 to ValueCount - 1 do
        SetValueByIndex(I, TcxSchedulerEvent(Source).GetValueByIndex(I));
      Start := TcxSchedulerEvent(Source).Start;
      Finish := TcxSchedulerEvent(Source).Finish;
    finally
      FIsDataValid := False;
      EndEditing;
  //    FSkipModified := False;
    end;
  end;
end;

procedure TcxSchedulerEvent.AssignAttributes(
  ASource: TcxSchedulerEvent; AUseSourceTime: Boolean = True);
begin
  BeginEditing;
  try
    if AUseSourceTime then
    begin
      Start := ASource.Start;
      Finish := ASource.Finish;
    end;
    Caption := ASource.Caption;
    Message := ASource.Message;
    State := ASource.State;
    LabelColor := ASource.LabelColor;
    ResourceID := ASource.ResourceID;
    Reminder := ASource.Reminder;
    ReminderMinutesBeforeStart := ASource.ReminderMinutesBeforeStart;
  finally
    EndEditing;
  end;
end;

procedure TcxSchedulerEvent.ShareWithResource(
  AResourceItem: TcxSchedulerStorageResourceItem);
begin
  if (AResourceItem = nil) then Exit;
  ShareWithResource(AResourceItem.ResourceID);
end;

procedure TcxSchedulerEvent.ShareWithResource(AResourceID: Variant);
var
  ASharedResources: Variant;
begin
  if IsSharedWithResource(AResourceID) or  VarIsNull(AResourceID) or
    VarIsEmpty(AResourceID) then Exit;
  ASharedResources := ResourceID;
  if not VarIsArray(ASharedResources) then
    ASharedResources := VarListArrayCreate(ASharedResources);
  if VarIsNull(ASharedResources[0]) then
    ASharedResources[0] := AResourceID
  else
    VarListArrayAddValue(ASharedResources, AResourceID);
  ResourceID := ASharedResources;
end;

function TcxSchedulerEvent.IsSharedWithResource(
  AResourceItem: TcxSchedulerStorageResourceItem): Boolean;
begin
  Result := False;
  if VarIsNull(ResourceID) or (AResourceItem = nil) then Exit;
  Result := IsSharedWithResource(AResourceItem.ResourceID);
end;

function TcxSchedulerEvent.IsSharedWithResource(AResourceID: Variant): Boolean;
var
  I: Integer;
  AResources: Variant;

  function CheckSimpleID(AResID: Variant): Boolean;
  var
    I: Integer;
  begin
    if not VarIsArray(AResourceID) then
      Result := VarEqualsSoftEx(AResID, AResourceID)
    else
    begin
      Result := False;
      for I := VarArrayLowBound(AResourceID, 1) to VarArrayHighBound(AResourceID, 1) do
        if VarEqualsSoftEx(AResID, AResourceID[I]) then
        begin
          Result := True;
          Break;
        end;
    end;
  end;

begin
  Result := False;
  AResources := ResourceID;
  if not VarIsArray(AResources) then
    Result := CheckSimpleID(AResources)
  else
    for I := VarArrayLowBound(AResources, 1) to VarArrayHighBound(AResources, 1) do
    begin
      Result := CheckSimpleID(AResources[I]);
      if Result then Break;
    end;
end;

procedure TcxSchedulerEvent.UnshareWithResource(
  AResourceItem: TcxSchedulerStorageResourceItem);
begin
  if not IsSharedWithResource(AResourceItem) then Exit;
  UnshareWithResource(AResourceItem.ResourceID);
end;

procedure TcxSchedulerEvent.UnshareWithResource(AResourceID: Variant);
var
  I, C: Integer;
  ASharedResources: Variant;
  ANewSharedResources: Variant;
begin
  if not VarIsArray(ResourceID) and VarEquals(ResourceID, AResourceID) then
  begin
    ResourceID := Null;
    Exit;
  end
  else
  begin
    ASharedResources := ResourceID;
    C := VarArrayHighBound(ResourceID, 1) - VarArrayLowBound(ResourceID, 1);
    if C = 0 then
      ANewSharedResources := Null
    else
    begin
      ANewSharedResources := VarArrayCreate([0, C - 1], varVariant);
      C := 0;
      for I := VarArrayLowBound(ResourceID, 1) to VarArrayHighBound(ResourceID, 1) do
        if not VarEquals(AResourceID, ASharedResources[I]) then
        begin
          ANewSharedResources[C] := ASharedResources[I];
          Inc(C);
        end;
    end;
    ResourceID := ANewSharedResources;
  end;
end;

procedure TcxSchedulerEvent.ReplaceResourceID(AResourceID: Variant);
begin
  if Shared then
    ShareWithResource(AResourceID)
  else
    ResourceID := AResourceID;
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
    Storage.DoDeleteEvent(FIndex);
  end;
end;

procedure TcxSchedulerEvent.DeleteExceptions;
begin
  if not HasExceptions then Exit;
  Storage.BeginUpdate;
  try
    while FLink <> nil do
    begin
      Storage.DoDeleteEvent(FLink.FIndex);
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

function TcxSchedulerEvent.Conflicts(AExceptEventsWithoutResources: Boolean): Boolean;
var
  AFinish: TDateTime;
begin
  Result := False;
  if IsFreeState then Exit;
  AFinish := Finish;
  if (EventType = etPattern) or SkipExceptions then
    AFinish := Finish + cxMaxCheckedDuration;
  with cxSchedulerEventConflictsInfoClass.Create(Self, AExceptEventsWithoutResources, Start, AFinish) do 
  try
    Result := HasConflicts;
  finally
    Free;
  end;
end;

function TcxSchedulerEvent.CreateConflictsInfo(
  AExceptEventsWithoutResources: Boolean): TcxSchedulerEventConflictsInfo;
begin
  Result := cxSchedulerEventConflictsInfoClass.Create(Self, AExceptEventsWithoutResources);
end;

function TcxSchedulerEvent.GetCustomFieldValueByIndex(AIndex: Integer): Variant;
begin
  Result := GetValueDef(TcxCustomSchedulerStorageField(Storage.Fields.Items[AIndex]), Null);
end;

function TcxSchedulerEvent.GetCustomFieldValueByName(
  const AName: String): Variant;
var
  AField: TcxCustomSchedulerStorageField;
begin
  AField := Storage.Fields.FindFieldByName(AName);
  if AField <> nil then
    Result := GetValueDef(AField, Null)
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

function TcxSchedulerEvent.GetOccurrence(ADate: TDateTime): TcxSchedulerEvent;
var
  ACalculator: TcxSchedulerOccurrenceCalculator;
  ALink: TcxSchedulerEvent;
  AOriginalDate: TDateTime;
begin
  Result := nil;
  if EventType <> etPattern then Exit;
  ADate := DateOf(ADate);
  ALink := FLink;
  while ALink <> nil do
  begin
    AOriginalDate := DateOf(ALink.GetOriginalDate);
    if AOriginalDate = ADate then
    begin
      Result := ALink;
      Exit;
    end
    else
      if AOriginalDate > ADate then
        break
      else
        ALink := ALink.FLink;
  end;
  ACalculator := TcxSchedulerOccurrenceCalculator.Create(Self, Start, ADate + 1);
  try
    while ACalculator.GetNextOccurrence do
    begin
      AOriginalDate := DateOf(ACalculator.OccurrenceStart);
      if AOriginalDate > ADate then
        break
      else
        if AOriginalDate = ADate then
        begin
          Result := Storage.createEvent;
          Result.Assign(Self);
          Result.Start := ACalculator.OccurrenceStart;
          Result.Finish := ACalculator.OccurrenceFinish;
          Result.RecurrenceIndex := ACalculator.Index;
          Result.EventType := etOccurrence;
          Result.ParentID := ID;
          Result.FPattern := Self;
          break;
        end;
    end;
  finally
    ACalculator.Free;
  end;
end;

function TcxSchedulerEvent.GetOriginalDate: TDateTime;
begin
  if EventType in [etCustom, etException] then
  begin
    with TcxSchedulerOccurrenceCalculator.Create(Pattern, 0, cxMaxDate) do
    try
      CalcOccurrence(Self.RecurrenceIndex + 1);
      Result := OccurrenceStart;
    finally
      Free;
    end;
  end
  else
    Result := Start;
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

function TcxSchedulerEvent.IsDayEvent(ADate: Integer): Boolean;
begin
  Result := False;
  if not FIsDataValid then
    UpdateTemporaryData;
  if FFinish > ADate then
    Result := (FStartDate <= ADate)
  else
    if FFinish = ADate then
      Result := FStartDate = ADate;
end;

function TcxSchedulerEvent.IsDayEvent(const ADate: TDateTime): Boolean;
begin
  Result := IsDayEvent(Integer(Trunc(ADate)));
end;

function TcxSchedulerEvent.IsRecurring: Boolean;
begin
  Result := EventType in [etPattern..etCustom];
end;

function TcxSchedulerEvent.IsResourceEvent(
  AResource: TcxSchedulerStorageResourceItem; AllowUnassigned: Boolean): Boolean;
begin
  Result := (AResource = nil) or (AllowUnassigned and VarIsNull(ResourceID)) or
    IsSharedWithResource(AResource.ResourceID);
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

procedure TcxSchedulerEvent.RemoveRecurrence;
begin
  if EventType = etPattern then
  begin
    DeleteExceptions;
    EventType := etNone;
  end; 
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

  Reminder := Storage.Reminders.DefaultReminder;
  ReminderMinutesBeforeStart := Storage.Reminders.DefaultMinutesBeforeStart;

  Start := Now;
  Finish := Start + cxDefaultEventDuration;
  State := tlsBusy;
  RecurrenceInfo.AssignDefaultValues;
end;

procedure TcxSchedulerEvent.CalculateActualTimeRange;
var
  AStart, AFinish: TDateTime;
  ALink: TcxSchedulerEvent;
begin
  if not Storage.ActualTimeRangeAvailable then Exit;
  if EventType = etPattern then
  begin
    AStart := RecurrenceInfo.Start;
    AFinish := RecurrenceInfo.Finish;
    with TcxSchedulerOccurrenceCalculator.Create(Self, RecurrenceInfo.Start, cxMaxDate) do
    try
      if not RecurrenceInfo.IsInfinity then
        while GetNextOccurrence do
        begin
          AStart := Min(AStart, OccurrenceStart);
          AFinish := Max(AFinish, OccurrenceFinish);
        end
      else
        AFinish := cxMaxDate;
    finally
      Free;
    end;
    ALink := Link;
    while ALink <> nil do
    begin
      AStart := Min(AStart, ALink.Start);
      AFinish := Max(AFinish, ALink.Finish);
      ALink := ALink.Link;
    end;
  end
  else
  begin
    AStart := Start;
    AFinish := Finish;
    if Pattern <> nil then
    begin
      AStart := Min(AStart, Pattern.Start);
      AFinish := Max(AFinish, Pattern.Finish);
    end;
  end;
  SetActualTimeRange(AStart, AFinish);
end;

procedure TcxSchedulerEvent.CalculateActualTimeRangePost;
begin
  if not Storage.ActualTimeRangeAvailable then Exit;
  if (EventType in [etCustom, etException]) and (Pattern <> nil) then
  begin
    Pattern.CheckRecurrenceLinkEx(Self);
    Pattern.CalculateActualTimeRange;
  end;
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

procedure TcxSchedulerEvent.CheckRecurrenceLinkEx(AEvent: TcxSchedulerEvent);
var
  ALink: TcxSchedulerEvent;
begin
  if AEvent.Link <> nil then Exit;
  ALink := FLink;
  while (ALink <> nil) and (ALink <> AEvent) do
    ALink := ALink.Link;
  if ALink = nil then
  begin
    AEvent.FLink := Link;
    FLink := AEvent;
  end; 
end;

function TcxSchedulerEvent.CheckTimeRange(
  const AStartDate, AFinishDate: Integer): Boolean;
begin
  Result := (ActualStart <= AFinishDate) and (ActualFinish >= AStartDate);
end;

function TcxSchedulerEvent.CreateRecurrenceInfo: TcxSchedulerEventRecurrenceInfo;
begin
  Result := TcxSchedulerEventRecurrenceInfo.Create(Self);
end;

function TcxSchedulerEvent.GetIsFreeState: Boolean;
begin
  Result := State = tlsFree;
end;

function TcxSchedulerEvent.GetOccurrenceByIndex(
  AIndex: Integer; var AOccurrence: TcxSchedulerEvent): Boolean;
begin
  Result := False;
  if (FLink = nil) or SkipExceptions then Exit;
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

procedure TcxSchedulerEvent.GetStartFinishTime(var AStart, AFinish: TDateTime);
begin
  AStart := Start;
  AFinish := Finish;
end;

function TcxSchedulerEvent.GetValueByIndex(AIndex: Integer): Variant;
begin
  Result := FStorage.GetValue(RecordIndex, AIndex);
  if (AIndex > Storage.FActualFinishField.Index) and (Pattern <> nil) and
    Storage.CanGetValueFromPattern(AIndex) and VarIsNull(Result) then
     Result := Pattern.GetValueByIndex(AIndex);
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
  if IsModified then
  begin
    ACount := Storage.DataController.RecordCount;
    Storage.FLastEditedEvent := Self;
    Storage.BeginUpdate;
    try
      CalculateActualTimeRange;
      if FRecordIndex <> cxInvalidRecordIndex then
        FStorage.PostEditingData(Self);
    finally
      if Storage.DataController.RecordCount < ACount then
        FRecordIndex := cxInvalidRecordIndex;
      CalculateActualTimeRangePost;
      Storage.EndUpdate;
    end;
  end;
end;

procedure TcxSchedulerEvent.SetActualTimeRange(
  const ActualStart, ActualFinish: TDateTime);
begin
  SetValue(FStorage.FActualStartField, Integer(Trunc(ActualStart + TimeBias)));
  SetValue(FStorage.FActualFinishField, Integer(Trunc(ActualFinish + TimeBias)));
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
var
  ACount: Integer;
  APrevValue: Variant; 
begin
  if IsEditing then
    APrevValue := FEditValues[AIndex]
  else
    APrevValue := GetValueByIndex(AIndex);
  if (VarType(APrevValue) = VarType(AValue)) and VarEquals(AValue, APrevValue) then Exit;
  Modified;
  ACount := Storage.DataController.RecordCount;
  BeginEditing;
  try
    FEditValues[AIndex] := AValue
  finally
    EndEditing;
  end;
  if Storage.DataController.RecordCount <> ACount then
    FRecordIndex := cxInvalidRecordIndex;
end;

function TcxSchedulerEvent.TimeBias: Double;
begin
  Result := Storage.TimeBias;
end;

procedure TcxSchedulerEvent.UpdateTemporaryData;
begin
  FStart := DateTimeHelper.RoundTime(TDateTime(GetValueDef(FStorage.FStartField, 0)) - TimeBias);
  FFinish := DateTimeHelper.RoundTime(TDateTime(GetValueDef(FStorage.FFinishField, 0)) - TimeBias);
  if (FPattern <> nil) and (EventType <> etPattern) then
    FOptions := GetValueDef(FStorage.FOptionsField, FPattern.GetOptionsFlag)
  else
    FOptions := GetValueDef(FStorage.FOptionsField, 0);
  FStartDate := Trunc(FStart);
  FIsDataValid := True;
end;

function TcxSchedulerEvent.GetActualFinish: Integer;
begin
  Result := Integer(GetValueDef(FStorage.FActualFinishField, 0));
end;

function TcxSchedulerEvent.GetActualStart: Integer;
begin
  Result := Integer(GetValueDef(FStorage.FActualStartField, 0));
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
  Result := DateTimeHelper.RoundTime(Finish - Start);
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

function TcxSchedulerEvent.GetReminderDate: TDateTime;
var
  AValue: Variant;
begin
  if not IsEditing then
    AValue := GetValueByIndex(FStorage.FReminderDateField.Index)
  else
    AValue := FEditValues[FStorage.FReminderDateField.Index];
  if VarType(AValue) in [varNull, varEmpty] then
    Result := Start
  else
    Result := TDateTime(AValue) - TimeBias;
end;

function TcxSchedulerEvent.GetReminderMinutesBeforeStart: Integer;
begin
  Result := GetValueDef(FStorage.FReminderMinutesBeforeStartField, Integer(-2));
end;

function TcxSchedulerEvent.GetResourceID: Variant;
begin
  Result := GetValueDef(FStorage.FResourceIDField, Null);
  if VarType(Result) = varString then
    Result := cxFieldValueToVariant(Result);
end;

function TcxSchedulerEvent.GetShared: Boolean;
begin
  Result := VarIsArray(ResourceID) and ((VarArrayHighBound(ResourceID, 1) -
    VarArrayLowBound(ResourceID, 1)) > 0);
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
  Finish := Start + DateTimeHelper.RoundTime(AValue);
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
  FFinish := DateTimeHelper.RoundTime(AValue);
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

procedure TcxSchedulerEvent.SetReminderDate(AValue: TDateTime);
begin
  SetValue(FStorage.FReminderDateField, AValue + TimeBias);
end;

procedure TcxSchedulerEvent.SetReminderMinutesBeforeStart(const AValue: Integer);
begin
  if ReminderMinutesBeforeStart <> AValue then
    ReminderDate := FStart - MinuteToTime * AValue;
  SetValue(FStorage.FReminderMinutesBeforeStartField, AValue);
end;

procedure TcxSchedulerEvent.SetResourceID(const AValue: Variant);
begin
  SetValue(FStorage.FResourceIDField, cxVariantToFieldValue(AValue));
end;

procedure TcxSchedulerEvent.SetStart(const AValue: TDateTime);
begin
  FStart := DateTimeHelper.RoundTime(AValue);
  FStartDate := Trunc(FStart);
  SetValue(FStorage.FStartField, FStart + TimeBias);
  ReminderDate := FStart - MinuteToTime * ReminderMinutesBeforeStart;
  RecurrenceInfo.DismissDate := DateOf(ReminderDate) - 1;
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
  FLink := ASource.FLink;
  FIsClone := ASource is TcxSchedulerControlEvent;
  SetRecordIndex(ASource.RecordIndex);
  FSource := ASource;
  FLink := ASource.FLink;
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
  SetLength(FValues, 0);
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
  if EventType = etOccurrence then
    inherited Delete
  else
    if Source <> nil then
      Source.Delete;
end;

procedure TcxSchedulerControlEvent.EndEditing;
begin
end;

{function TcxSchedulerControlEvent.GetParentID: Variant;
begin
  if EventType = etOccurrence then
    Result := Integer(-3)
  else
    Result := inherited GetParentID
end;}

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
  begin
    if Source = nil then
      Result := True
    else
      Result := FIsClone;
  end; 
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
  FImageIndex := -1;
  FVisible := True;
  FReadOnly := False;
  inherited Create(Collection);
end;

procedure TcxSchedulerStorageResourceItem.Assign(Source: TPersistent);
begin
  if Source is TcxSchedulerStorageResourceItem then
  begin
    FColor := TcxSchedulerStorageResourceItem(Source).FColor;
    FImageIndex := TcxSchedulerStorageResourceItem(Source).FImageIndex;
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

procedure TcxSchedulerStorageResourceItem.SetImageIndex(
  const AValue: TImageIndex);
begin
  FImageIndex := AValue;
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

function TcxSchedulerStorageResourceItem.GetActualImageIndex: TImageIndex;
begin
  Result := Resources.DoGetResourceImageIndex(Self);
  if (Resources.Images = nil) or (Resources.Images.Count <= Result) then
    Result := -1;
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
  begin
    FItems.Assign(TcxSchedulerStorageResources(Source).Items);
    FImages := TcxSchedulerStorageResources(Source).Images;
  end
  else
    inherited; 
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
  P: PRestoringItem;
begin
  if ResourceItems.Count = 0 then Exit;
  if Pos('Resource', AName) = 1 then
  begin
    AID := StrToIntDef('$' + Copy(AName, 9, 8), -1);
    AItem := TcxSchedulerStorageResourceItem(ResourceItems.FindItemID(AID));
    if AItem <> nil then
    begin
      AIndex := (AValue shr 1) and $FFFFFFF;
      New(P);
      P.Item := AItem;
      P.Index := AIndex;
      P.Visible := Boolean(AValue and 1);
      FRestoringItems.Add(P);
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

function CompareRestoringItems(Item1, Item2: Pointer): Integer;
begin
  Result := PRestoringItem(Item1).Index - PRestoringItem(Item2).Index;
end;

procedure TcxSchedulerStorageResources.DoneRestore;
var
  I: Integer;
  P: PRestoringItem;
begin
  FRestoringItems.Sort(CompareRestoringItems);
  Storage.BeginUpdate;
  try
    for I := 0 to FRestoringItems.Count - 1 do
    begin
      P := FRestoringItems[I];
      P.Item.Index := P.Index;
      P.Item.Visible := P.Visible;
      Dispose(P);
    end;
  finally
    Storage.EndUpdate;
    FreeAndNil(FRestoringItems);
  end;
end;

function TcxSchedulerStorageResources.DoGetResourceImageIndex(
  AItem: TcxSchedulerStorageResourceItem): TImageIndex;
begin
  Result := AItem.ImageIndex;
  if Assigned(FOnGetResourceImageIndex) then
    FOnGetResourceImageIndex(Storage, AItem, Result);
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

procedure TcxSchedulerStorageResources.InitRestore;
begin
  FRestoringItems := TList.Create;
end;

function TcxSchedulerStorageResources.GetAreImagesUsed: Boolean;
var
  I: Integer;
begin
  Result := (Images <> nil);
  if Result then
  begin
    Result := False;
    for I := 0 to ResourceItems.Count - 1 do
    begin
      Result := Result or (ResourceItems[I].ActualImageIndex >= 0);
      if Result then Break;
    end;
  end;
end;

procedure TcxSchedulerStorageResources.SetImages(AValue: TCustomImageList);
begin
  if AValue <> FImages then
  begin
    if FImages <> nil then
      FImages.RemoveFreeNotification(Storage);
    FImages := AValue;
    if FImages <> nil then
      FImages.FreeNotification(Storage);
    Changed;
  end;
end;

procedure TcxSchedulerStorageResources.SetItems(
  AValue: TcxSchedulerStorageResourceItems);
begin
  FItems.Assign(AValue);
end;
                          
function cxCompareConflictEvents(AEvent1, AEvent2: TcxSchedulerEvent): Integer;
begin
  if AEvent1.Start = AEvent2.Start then
    Result := 0
  else
    if AEvent1.Start < AEvent2.Start then
      Result := -1
    else
      Result := 1;
end;

function cxCompareConflictEventsEx(AEvent1, AEvent2: TcxSchedulerEvent): Integer;
begin
  if AEvent1 = AEvent2 then
    Result := 0
  else
    if AEvent1.Finish <= AEvent2.Start then
      Result := -1
    else
      if AEvent1.Start = AEvent2.Start then
        Result := 0
      else
        Result := 1;
end;

{ TcxSchedulerEventConflictsInfo }

constructor TcxSchedulerEventConflictsInfo.Create(
  AEvent: TcxSchedulerEvent; AExceptEventsWithoutResources: Boolean);
begin
  FEvent := AEvent;
  Init(AEvent.Storage, AExceptEventsWithoutResources, AEvent.ResourceID, NullDate, NullDate);
  Calculate;
end;

constructor TcxSchedulerEventConflictsInfo.Create(AEvent: TcxSchedulerEvent;
  AExceptEventsWithoutResources: Boolean; const AStart, AFinish: TDateTime);
begin
  FEvent := AEvent;
  Init(AEvent.Storage, AExceptEventsWithoutResources, AEvent.ResourceID, AStart, AFinish);
  Calculate(False);
end;

constructor TcxSchedulerEventConflictsInfo.Create(
  AStorage: TcxCustomSchedulerStorage; AExceptEventsWithoutResources: Boolean;
  const AStart, AFinish: TDateTime; AResourceID: Variant; AExcludedEvent: TcxSchedulerEvent = nil);
begin
  Init(AStorage, AExceptEventsWithoutResources, AResourceID, AStart, AFinish);
  FExcludedEvent := AExcludedEvent;
  if AExcludedEvent <> nil then
    ExcludedEventID := TcxSchedulerControlEventID.Create(AExcludedEvent);
  Calculate;
end;

destructor TcxSchedulerEventConflictsInfo.Destroy;
begin
  ExcludedEventID.Free;
  FConflictEvents.Free;
  FTimeRanges.Free;
  inherited Destroy;
end;

procedure TcxSchedulerEventConflictsInfo.Init(
  AStorage: TcxCustomSchedulerStorage; AExceptEventsWithoutResources: Boolean;
  AResourceID: Variant; const AStart, AFinish: TDateTime);
begin
  Start := AStart;
  Finish := AFinish;
  FStorage := AStorage;
  FExceptEventsWithoutResources := AExceptEventsWithoutResources;
  FConflictEvents := TcxSchedulerFilteredEventList.Create;
  FTimeRanges := TcxSchedulerTimeRanges.CreateEx(Self);
  ResourceID := AResourceID; 
end;

procedure TcxSchedulerEventConflictsInfo.AddRange(AStart, AFinish: TDateTime);
begin
  AStart := Min(Finish, Max(AStart, Start));
  AFinish := Max(Start, Min(AFinish, Finish));
  with DateTimeHelper do
  begin
    if (RoundTime(AStart) <> RoundTime(AFinish)) and (AFinish > AStart) then
      FTimeRanges.Add(AStart, AFinish);
  end; 
end;

procedure TcxSchedulerEventConflictsInfo.Calculate(
  ACalculateFreeTime: Boolean = True);
begin
  FConflictEvents.DestroyItems;
  FTimeRanges.Clear;
  if (FEvent <> nil) and ACalculateFreeTime then
  begin
    Start := FEvent.Start;
    Finish := FEvent.Finish;
    EventID := TcxSchedulerControlEventID.Create(FEvent);
  end;
  try
    if (FEvent = nil) or not FEvent.IsFreeState then
    begin
      Storage.GetEvents(FConflictEvents, Start - 1, Finish + 1, ResourceID);
      if ACalculateFreeTime then
      begin
        FConflictEvents.Sort(cxCompareConflictEvents);
        CheckIntersectionWithEvents
      end
      else
      begin
        FConflictEvents.Sort(cxCompareConflictEventsEx);
        CheckSomeIntersection;
      end;
    end;
    if ACalculateFreeTime then
      CheckFreeTimeRanges;
  finally
    EventID.Free;
  end;
end;

procedure TcxSchedulerEventConflictsInfo.CheckFreeTimeRanges;
var
  I: Integer;
  AStart, AFinish: TDateTime;
begin
  if not HasConflicts then
    AddRange(Start, Finish)
  else
  begin
    I := 0;
    AStart := Start;
    AFinish := Finish;
    while I < ConflictEvents.Count do
    begin
      AFinish := ConflictEvents[I].Start;
      AddRange(AStart, AFinish);
      ExpandRange(ConflictEvents[I], I, AFinish);
      AStart := AFinish;
    end;
    AddRange(AStart, Finish);
  end;
end;

procedure TcxSchedulerEventConflictsInfo.CheckIntersectionWithEvents;
var
  I: Integer;
begin
  for I := FConflictEvents.Count - 1 downto 0 do
  begin
    if ExcludeFromCalculate(FConflictEvents[I]) then
    begin
      FConflictEvents[I].Free;
      FConflictEvents.Delete(I);
    end;
  end;
end;

procedure TcxSchedulerEventConflictsInfo.CheckSomeIntersection;
var
  I, J: Integer;
  AEvent, ACheckedEvent: TcxSchedulerEvent;
  AList: TcxSchedulerFilteredEventList;
  HasIntersection: Boolean;
begin
  AList :=  TcxSchedulerFilteredEventList.Create;
  try
    if Event.SkipExceptions or (Event.EventType = etPattern) then
      Event.RecurrenceInfo.GetOccurrences(AList, Start, Finish)
    else
      AList.Add(TcxSchedulerControlEvent.Create(Event));
    // delete equals
    for I := FConflictEvents.Count - 1 downto 0 do
    begin
      AEvent := FConflictEvents[I];
      if AEvent.IsFreeState or IsSameEvent(AEvent) or IsSameSeries(FEvent, AEvent) then
      begin
        AEvent.Free;
        FConflictEvents.Delete(I);
      end;
    end;
    //
    HasIntersection := False;
    for I := 0 to AList.Count - 1 do
    begin
      if HasIntersection then Break;
      AEvent := AList[I];
      for J := 0 to FConflictEvents.Count - 1 do
      begin
        ACheckedEvent := FConflictEvents[J];
        HasIntersection := IntersectEvents(AEvent, ACheckedEvent);
        if HasIntersection and not ExceptEventsWithoutResources then
          HasIntersection := not VarIsNull(ACheckedEvent.ResourceID);
        if ExceptEventsWithoutResources and HasIntersection then
          HasIntersection := VarIsEmptyEx(ACheckedEvent.ResourceID) or VarIsEmptyEx(AEvent.ResourceID) or
            (ACheckedEvent.IsSharedWithResource(AEvent.ResourceID) or
              AEvent.IsSharedWithResource(ACheckedEvent.ResourceID))
        else
          HasIntersection := HasIntersection and (ACheckedEvent.IsSharedWithResource(AEvent.ResourceID) or
            AEvent.IsSharedWithResource(ACheckedEvent.ResourceID));
        if HasIntersection then Break;
      end;
    end;
    if not HasIntersection then
      FConflictEvents.DoClear(True);
  finally
    AList.Free; 
  end;
end;

function TcxSchedulerEventConflictsInfo.ExcludeFromCalculate(AEvent: TcxSchedulerEvent): Boolean;
begin
  Result := AEvent.IsFreeState or not IntersectEvents(AEvent);
  if not Result and (ExcludedEventID <> nil) then
    Result := ExcludedEventID.SameEvent(AEvent);
end;

procedure TcxSchedulerEventConflictsInfo.ExpandRange(AEvent: TcxSchedulerEvent;
  var AIndex: Integer; var ALastPosition: TDateTime);
var
  ACheckedEvent: TcxSchedulerEvent;
  ARangeStart, ARangeFinish: TDateTime;
begin
  ARangeStart := AEvent.Start;
  ARangeFinish := AEvent.Finish;
  while AIndex < ConflictEvents.Count do
  begin
     ACheckedEvent := ConflictEvents[AIndex];
     if IntersectTime(ARangeStart, ARangeFinish,
       ACheckedEvent.Start, ACheckedEvent.Finish) then
     begin
       ARangeStart := Min(ARangeStart, ACheckedEvent.Start);
       ARangeFinish := Max(ARangeFinish, ACheckedEvent.Finish);
     end
     else
       Break;
     Inc(AIndex);
  end;
  ALastPosition := ARangeFinish;
end;

function TcxSchedulerEventConflictsInfo.IntersectEvents(
  ACheckedEvent: TcxSchedulerEvent): Boolean;
begin
  Result := IntersectTime(ACheckedEvent.Start, ACheckedEvent.Finish);
  if Result and not ExceptEventsWithoutResources then
    Result := not VarIsNull(ACheckedEvent.ResourceID);
  if Result and (FEvent <> nil) then
    Result := ACheckedEvent.IsSharedWithResource(ResourceID) and not IsSameEvent(ACheckedEvent);
  if Result and (FEvent <> nil) then
    Result := not IsSameSeries(ACheckedEvent, FEvent);
  if Result and (FExcludedEvent <> nil) then
    Result := not IsSameSeries(ACheckedEvent, FExcludedEvent);
end;

function TcxSchedulerEventConflictsInfo.IntersectEvents(
  AEvent1, AEvent2: TcxSchedulerEvent): Boolean;
begin
  Result := IntersectTime(AEvent1.Start, AEvent1.Finish,
    AEvent2.Start, AEvent2.Finish);
end;

function TcxSchedulerEventConflictsInfo.IntersectTime(
  const AStart, AFinish: TDateTime): Boolean;
begin
  Result := IntersectTime(AStart, AFinish, Start, Finish);
end;

function TcxSchedulerEventConflictsInfo.IntersectTime(
  const AStart, AFinish, AStart1, AFinish1: TDateTime): Boolean;
begin
  Result := (AStart < AFinish1) and (AStart1 < AFinish);
end;

function TcxSchedulerEventConflictsInfo.IsSameEvent(
  ACheckedEvent: TcxSchedulerEvent): Boolean;
begin
  Result := (EventID <> nil) and EventID.SameEvent(ACheckedEvent);
end;

function TcxSchedulerEventConflictsInfo.IsSameSeries(
  AEvent1, AEvent2: TcxSchedulerEvent): Boolean;
begin
  Result := AEvent1.RecordIndex = AEvent2.RecordIndex;
  if (AEvent1.RecordIndex < 0) or (AEvent2.RecordIndex < 0) then Exit;
  if not Result then
    Result := VarEquals(AEvent1.ID, AEvent2.ID);
  if not Result and (AEvent1.EventType <> etNone) then
    Result := VarEquals(AEvent1.ParentID, AEvent2.ID);
  if not Result and (AEvent2.EventType <> etNone) then
    Result := VarEquals(AEvent1.ID, AEvent2.ParentID);
  if not Result and (AEvent1.EventType <> etNone) and (AEvent2.EventType <> etNone) then
    Result := VarEquals(AEvent1.ParentID, AEvent2.ParentID);
end;

function TcxSchedulerEventConflictsInfo.GetHasConflicts: Boolean;
begin
  Result := FConflictEvents.Count > 0;
end;

function TcxSchedulerEventConflictsInfo.GetHasFreeTime: Boolean;
begin
  Result := FTimeRanges.Count > 0;
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
  StopUpdateRemindersTimer;
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
  BeginUpdateDataController;
end;

procedure TcxCustomSchedulerStorage.Clear;
begin
  BeginUpdate;
  try
    while EventCount > 0 do
      Events[0].Delete;
  finally
    EndUpdate;
  end;
end;

procedure TcxCustomSchedulerStorage.DoneRestore;
begin
  if ResourceCount > 0 then
    Resources.DoneRestore
end;

procedure TcxCustomSchedulerStorage.CalculateEventActualTimeRanges;
var
  I: Integer;
begin
  if not ActualTimeRangeAvailable then Exit;
  BeginUpdate;
  try
    for I := 0 to EventCount - 1 do
      Events[I].CalculateActualTimeRange;
  finally
    EndUpdate;
  end;
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
  FInternalUpdate := True;
  try
    try
      if LockCount = 1 then
      begin
        PostEvents;
        if FDeletedRecords.Count > 0 then
          TcxSchedulerStorageDataController(DataController).DeleteRecords(FDeletedRecords);
        FDeletedRecords.Count := 0;
      end;
    finally
      EndUpdateDataController;
    end;
    if FIsChanged then
      Changed;
  finally
    FInternalUpdate := False;
  end;
end;

function TcxCustomSchedulerStorage.FindAvailableAllDay(
  var AStart, AFinish: TDateTime; AResourceID: Variant;
  AExceptEventsWithoutResources: Boolean; ADuration: TDateTime = 0): Boolean;
var
  I, J: Integer;
  AList: TcxSchedulerFilteredEventList;
  AStartDay: TDateTime;
begin
  Result := False;
  AStartDay := EncodeTime(0, 0, 1, 0);
  if ADuration = 0 then
    ADuration := Max(1, Trunc(AFinish) - Trunc(AStart));
  AList := TcxSchedulerFilteredEventList.Create;
  try
    for I := Trunc(AStart) to Trunc(AStart) + cxMaxCheckedDuration do
    begin
      Result := not GetEvents(AList, I + AStartDay, I + ADuration - AStartDay, AResourceID);
      if not Result then
      begin
        Result := True;
        for J := 0 to AList.Count - 1 do
          Result := Result and AList[J].IsFreeState;
      end; 
      if Result then
      begin
        AStart := I;
        AFinish := AStart +  ADuration;
        Break;
      end;
    end;
  finally
    AList.Free;
  end;
end;

function TcxCustomSchedulerStorage.FindAvailableTime(
  var AStart, AFinish: TDateTime; AllDay: Boolean;
  AResourceID: Variant; AExceptEventsWithoutResources: Boolean; ADuration: TDateTime = 0;
  AExcludedEvent: TcxSchedulerEvent = nil): Boolean;
var
  I: Integer;
  AInfo: TcxSchedulerEventConflictsInfo;
begin
  if ADuration = 0 then
    ADuration := AFinish - AStart;
  if AllDay then
    Result := FindAvailableAllDay(AStart, AFinish, AResourceID, AExceptEventsWithoutResources, ADuration)
  else
  begin
    AInfo := TcxSchedulerEventConflictsInfo.Create(Self, AExceptEventsWithoutResources, Trunc(AStart),
          Trunc(AFinish) + cxMaxCheckedDuration, AResourceID, AExcludedEvent);
    try
      Result := AInfo.HasFreeTime;
      for I := 0 to AInfo.TimeRanges.Count - 1 do
        if (AInfo.TimeRanges[I].Duration >= ADuration) and
          (DateTimeHelper.RoundTime(AInfo.TimeRanges[I].Finish - ADuration) >= AStart) then
        begin
          if AInfo.TimeRanges[I].Start > AStart then
            AStart := AInfo.TimeRanges[I].Start;
          AFinish := AStart + ADuration;
          Result := True;
          Break;
        end;
    finally
      AInfo.Free;
    end;
  end;
end;

function TcxCustomSchedulerStorage.FindAvailableTime(AEvent: TcxSchedulerEvent;
  AExceptEventsWithoutResources: Boolean; var AStart, AFinish: TDateTime): Boolean;
var
  I: Integer;
  S: TDateTime;
  AInfo: TcxSchedulerEventConflictsInfo;
begin
  Result := AEvent.Conflicts(AExceptEventsWithoutResources);
  S := AEvent.Start;
  AEvent.GetStartFinishTime(AStart, AFinish);
  if Result then
  begin
    if AEvent.EventType <> etPattern then
    begin
      AFinish := AFinish + cxMaxCheckedDuration;
      Result := FindAvailableTime(AStart, AFinish, AEvent.AllDayEvent,
        AEvent.ResourceID, AExceptEventsWithoutResources, AEvent.Duration, AEvent);
    end
    else
    begin
      AEvent.BeginEditing;
      try
        AInfo := cxSchedulerEventConflictsInfoClass.Create(Self, AExceptEventsWithoutResources,
          Trunc(AEvent.Start), Trunc(AEvent.Finish) + 1, AEvent.ResourceID);
        try
          Result := False;
          for I := 1 to 24 * 6 do
          begin
            AEvent.MoveTo(AStart + I * 10 * MinuteToTime);
            if not AEvent.Conflicts(AExceptEventsWithoutResources) then
            begin
              AEvent.GetStartFinishTime(AStart, AFinish);
              Result := True;
              Break;
            end;
          end;
        finally
          AInfo.Free;
        end;
      finally
        AEvent.MoveTo(S);
        AEvent.Cancel;
      end;
    end;
  end
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
  I, J, C: Integer;
  AEvent: TcxSchedulerEvent;
  AStartDate, AFinishDate: Integer;
begin
  AList.Init(AStart, AFinish, Self);
  AList.FReminderEventsOnly := False;
  AStartDate := Trunc(AStart);
  AFinishDate := Trunc(AFinish) + 1;
  for I := 0 to EventCount - 1 do
  begin
    AEvent := Events[I];
    if not ActualTimeRangeAvailable or AEvent.CheckTimeRange(AStartDate, AFinishDate) then
    begin
      if not VarIsArray(AResourceID) then
        AList.CheckEvent(AEvent, AResourceID)
      else
      begin
        C := AList.Count;
        for J := VarArrayLowBound(AResourceID, 1) to VarArrayHighBound(AResourceID, 1) do
        begin
          AList.CheckEvent(AEvent, AResourceID[J]);
          if AList.Count <> C then Break;
        end;
      end;
    end;
  end;
  AList.Changed;
  Result := AList.Count > 0;
end;

function TcxCustomSchedulerStorage.GetFieldByName(
  const AName: string): TcxCustomSchedulerStorageField;
begin
  Result := Fields.FindFieldByName(AName);
end;

function TcxCustomSchedulerStorage.GetReminderEvents(
  ADateTime: TDateTime; AList: TcxSchedulerFilteredEventList): Boolean;
var
  I: Integer;
begin
  AList.Init(NullDate, ADateTime + 14, Self); //calculate for two weeks (= max AdvanceTime)
  AList.FReminderEventsOnly := True;
  AList.FNow := Reminders.GetNow;
  for I := 0 to EventCount - 1 do
    AList.CheckEvent(Events[I], Null);
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

procedure TcxCustomSchedulerStorage.InitRestore;
begin
  if ResourceCount > 0 then
    Resources.InitRestore;
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

function TcxCustomSchedulerStorage.IsReminderAvailable: Boolean;
begin
  Result := True;
end;

function TcxCustomSchedulerStorage.IsStateAvailable: Boolean;
begin
  Result := True;
end;

procedure TcxCustomSchedulerStorage.BeginUpdateDataController;
begin
  Inc(LockCount);
  DataController.BeginUpdate;
end;

procedure TcxCustomSchedulerStorage.EndUpdateDataController;
begin
  Dec(LockCount);
  DataController.EndUpdate;
end;

procedure TcxCustomSchedulerStorage.RemoveListener(
  AListener: IcxSchedulerStorageListener);
begin
  FListeners.Remove(AListener);
end;

function TcxCustomSchedulerStorage.ActualTimeRangeAvailable: Boolean;
begin
  Result := UseActualTimeRange;
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
    FReminderMinutesBeforeStartField.Index,
    FStateField.Index,
    FReminderDateField.Index
  ];
  Result := Result or (AIndex > FStateField.Index);
  Result := Result and not (AIndex in [FActualFinishField.Index, FActualStartField.Index]);
end;

procedure TcxCustomSchedulerStorage.Changed;
begin
  IsChanged := IsLocked;
  if not IsLocked then
    SendNotification;
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
  AddInternalField(FReminderDateField, TcxDateTimeValueType);
  AddInternalField(FReminderMinutesBeforeStartField, TcxIntegerValueType);
  AddInternalField(FResourceIDField, TcxVariantValueType);
  AddInternalField(FStartField, TcxDateTimeValueType);
  AddInternalField(FStateField, TcxIntegerValueType);
  AddInternalField(FActualFinishField, TcxIntegerValueType);
  AddInternalField(FActualStartField, TcxIntegerValueType);
end;

function TcxCustomSchedulerStorage.CreateFields: TcxCustomSchedulerStorageFields;
begin
  Result := TcxSchedulerStorageFields.Create(TcxSchedulerStorageField);
end;

function TcxCustomSchedulerStorage.CreateReminders: TcxSchedulerReminders;
begin
  Result := TcxSchedulerReminders.Create(Self);
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
  FReminders := CreateReminders;
  CreateDefaultFields;
end;

procedure TcxCustomSchedulerStorage.DestroySubClasses;
begin
  FReminders.Free;
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
  if AParentEvent = LastEditedEvent then
    FLastEditedEvent := nil; 
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
      AEventsChain.Free;
    end;
  finally
    for I := ARecordIndex to FEventsList.Count - 1 do
      TcxSchedulerEvent(FEventsList.FItems.List^[I]).FIndex := I;
    IsDeletion := False;
    EndUpdate;
  end;
end;

procedure TcxCustomSchedulerStorage.DoDestroyEvent(
  AEvent: TcxSchedulerEvent);
begin
  if not AEvent.FIsDeletion then
  begin
    FEventsList.Remove(AEvent);
    FNewEvents.Remove(AEvent);
  end; 
end;

function TcxCustomSchedulerStorage.DoEventDeleted(
  AEvent: TcxSchedulerEvent): Boolean;
begin
  Result := False;
  if AEvent = LastEditedEvent then
    FLastEditedEvent := nil;
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
    if {not FSkipModified and }IsModified and Assigned(FOnEventModified) then
      FOnEventModified(Self, AEvent, Result);
  end;
end;

function TcxCustomSchedulerStorage.DoFilterEvent(AEvent: TcxSchedulerEvent): Boolean;
begin
  Result := True;
  if Assigned(FOnFilterEvent) then
    FOnFilterEvent(Self, AEvent, Result);
end;

procedure TcxCustomSchedulerStorage.DoRefresh;
var
  ID: Variant;
  AEvent: TcxSchedulerEvent;
  IndexList, DestList: TList;
  I, J, ACount: Integer;
begin
  Reminders.StopTimers;
  if LockCount > 0 then Exit;
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
    begin
      if FLastEditedEvent = IndexList.List^[I] then
        FLastEditedEvent := nil;
      TObject(IndexList.List^[I]).Free;
    end;
  finally
    IndexList.Free;
  end;
  for I := 0 to ACount - 1 do
  begin
    AEvent := Events[I];
    AEvent.FIndex := I;
    if AEvent.EventType = etPattern then
    begin
      for J := 0 to ACount - 1 do
        if J <> I then
          AEvent.CheckRecurrenceLink(Events[J]);
    end;
  end;
  if Reminders.Active then
    StartUpdateRemindersTimer;
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
  if ARecordIndex >= DataController.RecordCount then
    Result := Null
  else
    Result := DataController.GetRecordID(ARecordIndex);
end;

function TcxCustomSchedulerStorage.GetValue(
  ARecordIndex, AItemIndex: Integer): Variant;
begin
  if ARecordIndex = cxInvalidRecordIndex then
    Result := Null
  else
  begin
    if DataController.IsEditing and (ARecordIndex = DataController.EditingRecordIndex) then
      Result := DataController.GetEditValue(AItemIndex, evsValue)
    else
      Result := DataController.Values[ARecordIndex, AItemIndex];
  end;
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

procedure TcxCustomSchedulerStorage.Notification(
  AComponent: TComponent; Operation: TOperation);
begin
  if (Resources <> Nil) and (Operation = opRemove)and (AComponent = Resources.Images) then
    Resources.Images := nil;
  inherited Notification(AComponent, Operation);
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
  BeginUpdateDataController;
  try
    for AFieldIndex := 0 to AEvent.ValueCount - 1 do
      SetPostFieldValue(AEvent, AFieldIndex);
  finally
    EndUpdateDataController;
  end;
end;

procedure TcxCustomSchedulerStorage.SendNotification(
  AIsRemoved: Boolean = False);
var
  I: Integer;
  AIntf: IcxSchedulerStorageListener;
begin
  if LockCount <> 0 then Exit;
  for I := Listeners.Count - 1 downto 0 do
    if Supports(Listeners[I], IcxSchedulerStorageListener, AIntf) then
    begin
      if AIsRemoved then
        AIntf.StorageRemoved(Self)
      else
        if not IsUpdatingMode then
        begin
          FIsChanged := False;
          AIntf.StorageChanged(Self);
        end;
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
  if ARecordIndex <> cxInvalidRecordIndex then
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

procedure TcxCustomSchedulerStorage.SetOnFilterEvent(
  AValue: TcxSchedulerFilterEventEvent);
begin
  if @FOnFilterEvent <> @AValue then
  begin
    FOnFilterEvent := AValue;
    SendNotification;
  end;
end;

procedure TcxCustomSchedulerStorage.SetReminders(
  AValue: TcxSchedulerReminders);
begin
  FReminders.Assign(AValue);
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
      with DateTimeHelper do
        TimeBias := TimeZoneBias(CurrentTimeZone)
    end
    else
      TimeBias := 0;
    Changed;
  end;
end;

procedure TcxCustomSchedulerStorage.StartUpdateRemindersTimer;
begin
  if (FUpdateRemindersTimer <> nil) or
    (not Reminders.Active or (csDesigning in ComponentState)) then Exit;
  FUpdateRemindersTimer := TTimer.Create(nil);
  FUpdateRemindersTimer.Interval := 100;
  FUpdateRemindersTimer.OnTimer := UpdateRemindersTimerEvent;
end;

procedure TcxCustomSchedulerStorage.StopUpdateRemindersTimer;
begin
  FreeAndNil(FUpdateRemindersTimer);
end;

procedure TcxCustomSchedulerStorage.UpdateRemindersTimerEvent(
  Sender: TObject);
begin
  StopUpdateRemindersTimer;
  with Reminders do if Active then Refresh;
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
      DataController.RecordCount := 0;
      DataController.Post;
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

{ TcxSchedulerControlEventID }

constructor TcxSchedulerControlEventID.Create(AEvent: TcxSchedulerEvent);
begin
  if AEvent.RecordIndex <> -1 then
  begin
    ID := AEvent.ID;
    ParentID := AEvent.ParentID;
    RecurrenceIndex := AEvent.RecurrenceIndex
  end
  else
  begin
    ID := Null;
    ParentID := Null;
    RecurrenceIndex := -1;
  end;
end;

function TcxSchedulerControlEventID.SameEvent(AEvent: TcxSchedulerEvent): Boolean;
begin
  Result := VarEquals(AEvent.ID, ID) and VarEquals(AEvent.ParentID, ParentID) and
    (AEvent.RecurrenceIndex = RecurrenceIndex);
end;

function TcxSchedulerControlEventID.Equals(AValue: TcxSchedulerControlEventID): Boolean;
begin
  Result := (AValue = Self) or VarEquals(AValue.ID, ID) and
    VarEquals(AValue.ParentID, ParentID) and (AValue.RecurrenceIndex = RecurrenceIndex);
end;

{ TcxSchedulerReminderEventID }

constructor TcxSchedulerReminderEventID.Create(AEvent: TcxSchedulerControlEvent);
begin
  ID := AEvent.FSavedID;
  ParentID := AEvent.ParentID;
  RecurrenceIndex := AEvent.RecurrenceIndex;
  ReminderDate := AEvent.ReminderDate;
end;

function TcxSchedulerReminderEventID.SameEvent(
  AEvent: TcxSchedulerControlEvent): Boolean;
begin
  Result := inherited SameEvent(AEvent);
  if Result then
    Result := ReminderDate = AEvent.ReminderDate;
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

procedure TcxSchedulerEventSelection.Select(AEvent: TcxSchedulerEvent);
begin
  InternalClear;
  FKeys.Add(TcxSchedulerControlEventID.Create(AEvent));
  DoEventSelectionChanged(nil);
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
  AEvent: TcxSchedulerControlEvent): TcxSchedulerControlEventID;
begin
  Result := TcxSchedulerControlEventID.Create(AEvent);
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
  AItemForSearch: TcxSchedulerControlEventID;
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
  AIndex: Integer): TcxSchedulerControlEventID;
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
    for I := FItems.Count - 1 downto 0 do
      with Items[I] do
      begin
        FIsDeletion := True;
        Free;
      end;
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
var
  AReminderStart: TDateTime;
begin
  Result := nil;
  if ReminderEventsOnly and not ACalculator.Event.Reminder then Exit;
  begin
    if ReminderEventsOnly then
    begin
      AReminderStart := ACalculator.OccurrenceStart -
        ACalculator.Event.ReminderMinutesBeforeStart * MinuteToTime;
      if NeedAddOccurenceForReminder(AReminderStart, ACalculator.Event) then
      begin
        if (ACalculator.FOccurence <> nil) and (DateOf(AReminderStart) < DateOf(FNow)) then
        begin
          FreeAndNil(ACalculator.FOccurence);
          Delete(ACalculator.FOccurencePos);
        end;
        ACalculator.FOccurencePos := Count;
        Result := AddEvent(ACalculator.Event);
        ACalculator.FOccurence := Result;
      end;
    end
    else
      if (ACalculator.OccurrenceStart <= Finish) and (ACalculator.OccurrenceFinish >= Start) then
        Result := AddEvent(ACalculator.Event);
    if Result = nil then Exit;
    if ACalculator.Event.RecordIndex >= 0 then
      Result.ParentID := ACalculator.Event.ID;
    Result.Start := ACalculator.OccurrenceStart - Result.TimeBias + Storage.TimeBias;
    Result.Finish := ACalculator.OccurrenceFinish - Result.TimeBias + Storage.TimeBias;
    Result.RecurrenceIndex := ACalculator.Index;
    Result.EventType := etOccurrence;
    Result.FPattern := ACalculator.Event;
    Result.FOptions := ACalculator.Event.FOptions;
    Result.ReminderDate := ACalculator.Event.ReminderDate;
  end;
  if (Result <> nil) and not Storage.DoFilterEvent(Result) then
  begin
    if ACalculator.FOccurence = Result then
      ACalculator.FOccurence := nil;
    FreeAndNil(Result);
    Delete(Count - 1);
  end;
end;

procedure TcxSchedulerFilteredEventList.Changed;
begin
end;

procedure TcxSchedulerFilteredEventList.CheckEvent(
  AEvent: TcxSchedulerEvent; const AResourceID: Variant);
begin
  if AEvent.EventType in [etNone, etCustom] then
    CheckSimpleEvent(AEvent, AResourceID)
  else
    if (AEvent.EventType = etPattern) or AEvent.SkipExceptions then
      CheckRecurrenceEvent(AEvent, AResourceID);
end;

procedure TcxSchedulerFilteredEventList.CheckRecurrenceEvent(
  AEvent: TcxSchedulerEvent; const AResourceID: Variant);
var
  AOccurrence: TcxSchedulerEvent;
  ACalculator: TcxSchedulerOccurrenceCalculator;
begin
  ACalculator := TcxSchedulerOccurrenceCalculator.Create(AEvent, FStart, FFinish,
    ReminderEventsOnly);
  try
    while ACalculator.GetNextOccurrence do
    begin
      if not AEvent.GetOccurrenceByIndex(ACalculator.Index, AOccurrence) then
        if VarIsNull(AResourceID) or AEvent.IsSharedWithResource(AResourceID) then
          AddOccurrence(ACalculator);
    end;
  finally
    ACalculator.Free;
  end;
end;

procedure TcxSchedulerFilteredEventList.CheckSimpleEvent(
  AEvent: TcxSchedulerEvent; const AResourceID: Variant);
begin
  if not Storage.DoFilterEvent(AEvent) then Exit;
  if VarIsNull(AResourceID) or AEvent.IsSharedWithResource(AResourceID) then
  begin
    if FReminderEventsOnly then
    begin
      if AEvent.Reminder and (AEvent.ReminderDate <= Finish) then
        AddEvent(AEvent).FPattern := AEvent.FPattern;
    end
    else
      if (AEvent.Start <= Finish) and (AEvent.Finish >= Start) then
        AddEvent(AEvent).FPattern := AEvent.FPattern;
  end;
end;

function TcxSchedulerFilteredEventList.CreateControlEvent(
  AEvent: TcxSchedulerEvent): TcxSchedulerControlEvent;
begin
  Result := TcxSchedulerControlEvent.Create(AEvent);
  Result.FTimeBias := AEvent.TimeBias;
  Result.FLink := AEvent.FLink;
end;

procedure TcxSchedulerFilteredEventList.Init(
  const AStart, AFinish: TDateTime; AStorage: TcxCustomSchedulerStorage);
begin
  DestroyItems;
  FStart := AStart;
  FFinish := AFinish;
  FStorage := AStorage;
end;

function TcxSchedulerFilteredEventList.NeedAddOccurenceForReminder(
  AReminderStart: TDateTime; AEvent: TcxSchedulerEvent): Boolean;
begin
  Result := (AEvent.RecurrenceInfo.DismissDate < DateOf(Now)) and
    (AReminderStart > AEvent.RecurrenceInfo.DismissDate) and
    (AReminderStart < Finish);
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

procedure TcxSchedulerCachedEventList.BeforeEditing(
  AEvent: TcxSchedulerControlEvent; AIsInplace: Boolean);

  function GetEventID(AEvent: TcxSchedulerEvent): Variant;
  begin
    Result := Null;
    if AEvent <> nil then
      Result := AEvent.ID;
  end;

begin
  AEvent.FIsEditing := AIsInplace;
  FSavedPatternID := GetEventID(AEvent.Pattern);
  FSavedSourceID := GetEventID(AEvent.Source);
  FSavedIndex := AEvent.RecurrenceIndex;
end;

procedure TcxSchedulerCachedEventList.BeforeUpdate;
begin
  FExpandedTimeRange := CalculateNecessaryDate(
    FMinNecessaryDate, FMaxNecessaryDate);
end;

procedure TcxSchedulerCachedEventList.DeleteEvent(
  AEvent: TcxSchedulerControlEvent);
begin
  if (AEvent.Source <> nil) or (AEvent.EventType = etOccurrence) then
    AEvent.Delete
  else
  begin
    FItems.Remove(AEvent);
    FAbsoluteItems.Remove(AEvent);
    AEvent.Free;
  end;
end;

procedure TcxSchedulerCachedEventList.CalculateClonesRange(
  var AMinDate, AMaxDate: TDateTime);
var
  I: Integer;
begin
  if Clones.Count = 0 then Exit;
  AMinDate := Clones[0].Start;
  AMaxDate := Clones[0].Finish;
  for I := 1 to Clones.Count - 1 do
  begin
    AMinDate := Min(AMinDate, Clones[I].Start);
    AMaxDate := Max(AMaxDate, Clones[I].Finish);
  end;
end;

function TcxSchedulerCachedEventList.CalculateNecessaryDate(
  var AMinDate, AMaxDate: TDateTime): Boolean;
var
  AMin, AMax: TDateTime;
begin
  Result := (Clones.Count > 0) or (Selection.Count > 0);
  if not Result then Exit;
  if Clones.Count > 0 then
    CalculateClonesRange(AMinDate, AMaxDate);
  if Selection.Count > 0 then
    CalculateSelectionRange(AMin, AMax)
  else
    Exit;
  if Clones.Count > 0 then
  begin
    AMinDate := Min(AMinDate, AMin);
    AMaxDate := Max(AMaxDate, AMax);
  end
  else
  begin
    AMinDate := AMin;
    AMaxDate := AMax;
  end;
end;

procedure TcxSchedulerCachedEventList.CalculateSelectionRange(
  var AMinDate, AMaxDate: TDateTime);
var
  I: Integer;
begin
  if Selection.Count = 0 then Exit;
  AMinDate := Selection.Items[0].Start;
  AMaxDate := Selection.Items[0].Finish;
  for I := 1 to Selection.Count - 1 do
  begin
    AMinDate := Min(AMinDate, Selection.Items[I].Start);
    AMaxDate := Max(AMaxDate, Selection.Items[I].Finish);
  end;
end;

procedure TcxSchedulerCachedEventList.CancelClones;
begin
  FHasClones := False; 
  FClones.DestroyItems;
  Changed;
end;

function TcxSchedulerCachedEventList.CreateEvent: TcxSchedulerControlEvent;
begin
  Storage.FLastEditedEvent := nil;
  Result := TcxSchedulerControlEvent.Create(Storage);
  Result.FIsSource := True;
  FItems.Add(Result);
  FAbsoluteItems.Add(Result);
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
  FHasClones := FClones.Count > 0;
  FExpandedTimeRange := CalculateNecessaryDate(FMinNecessaryDate, FMaxNecessaryDate);
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
    if IsDayNoneEmpty(I) then
       AList.AddEx(I);
  if AList.Count > 1 then 
     AList.Sort(@cxCompareDates);
end;

function TcxSchedulerCachedEventList.HasConflict(
  IsDragCopy: Boolean; AStartDrag: Boolean): Boolean;
begin
  if AStartDrag then
    Result := (Selection.Count > 1) and HasIntersection(Selection.FEvents)
  else
    if (Selection.Count = 1) and (Clones.Count  = 0) then
      Result := HasIntersection(Selection[0])
    else
      Result := HasIntersection(Self, Clones, not IsDragCopy);
end;

function TcxSchedulerCachedEventList.HasIntersection(AEvent: TcxSchedulerControlEvent): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to FItems.Count - 1 do
  begin
    if FItems[I] = AEvent then Continue;
    Result := IsIntersect(TcxSchedulerControlEvent(FItems[I]), AEvent);
    if Result then Exit; 
  end;
end;

function TcxSchedulerCachedEventList.HasIntersection(AList: TList): Boolean;
var
  I, J: Integer;
begin
  Result := False;
  for I := 0 to AList.Count - 1 do
    for J := 0 to AList.Count - 1 do
    begin
      Result := (I <> J) and IsIntersect(
        TcxSchedulerEvent(AList[I]), TcxSchedulerEvent(AList[J]));
      if Result then Exit;
    end;
end;

function TcxSchedulerCachedEventList.HasIntersection(
  AList1, AList2: TcxSchedulerEventList; AExcludeEquals: Boolean): Boolean;
var
  I, J: Integer;
begin
  Result := False;
  for I := 0 to AList1.Count - 1 do
    for J := 0 to AList2.Count - 1 do
    begin
      if AExcludeEquals and (AList1[I] = TcxSchedulerControlEvent(AList2[J]).Source) then Continue;
      Result := IsIntersect(AList1[I], AList2[J]);
      if Result then Exit;
    end;
end;

function TcxSchedulerCachedEventList.LastEditedEvent: TcxSchedulerControlEvent;

  function FindByEvent(ASource: TcxSchedulerEvent): TcxSchedulerControlEvent;
  var
    I: Integer;
  begin
    Result := nil;
    for I := 0 to AbsoluteCount - 1 do
      if AbsoluteItems[I].Source = ASource then
      begin
        Result := AbsoluteItems[I];
        if Result.RecurrenceIndex = FSavedIndex then Exit;
      end;
  end;

  function FindByID(AID: Variant; ActualValue: TcxSchedulerControlEvent): TcxSchedulerControlEvent;
  var
    I: Integer;
  begin
    Result := ActualValue;
    if (ActualValue <> nil) or VarIsNull(AID) then Exit;
    for I := 0 to AbsoluteCount - 1 do
      if VarEqualsSoft(AbsoluteItems[I].ID, AID) then
      begin
        Result := AbsoluteItems[I];
        if Result.RecurrenceIndex = FSavedIndex then Exit;
      end;
  end;

var
  ASource: TcxSchedulerEvent;
begin
  ASource := nil;
  if VarIsNull(FSavedPatternID) and VarIsNull(FSavedSourceID) or
    ((Storage.LastEditedEvent <> nil) and (Storage.LastEditedEvent.EventType <> etNone)) then
    ASource := Storage.LastEditedEvent;
  Result := FindByID(FSavedPatternID,
    FindByID(FSavedSourceID, FindByEvent(ASource)));
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
    Selection.Clear;
    CancelClones;
    Storage.EndUpdate;
  end;
end;

procedure TcxSchedulerCachedEventList.PostEvent(
  AEvent: TcxSchedulerControlEvent);
begin
  FBeforePostCount := Count; 
  try
    AEvent.FIsEditing := False;
    if AEvent.Source = nil then
      PostNewEvent(AEvent)
    else
      if AEvent.EventType in [etNone, etCustom] then
        PostCloneForSimpleEvent(AEvent, False, AEvent.EventType)
      else
        if AEvent.EventType = etOccurrence then
          PostCloneForSimpleEvent(AEvent, True, etCustom)
  except
    FNewEvent := nil;
    Storage.SendNotification(False);
    raise;
  end;
end;

procedure TcxSchedulerCachedEventList.Sort(ACompare: TcxCompareEventsProc);
begin
  inherited Sort(ACompare);
  FAbsoluteItems.Sort(TListSortCompare(@ACompare));
end;

procedure TcxSchedulerCachedEventList.Changed;
begin
  if FChangeRef <> 0 then Exit;
  Inc(FChangeRef);
  PopulateAbsoluteItems;
  if (Count > FBeforePostCount) and (FNewEvent <> nil) then
  begin
    Selection.ClearKeys;
    Selection.Select(FNewEvent);
  end;
  FNewEvent := nil;
  Selection.Update;
  if FHasClones then
  begin
    CreateClones;
    PopulateAbsoluteItems;
  end;
  inherited Changed;
  Dec(FChangeRef);
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
  FHasClones := (FClones <> nil) and (FClones.Count > 0);
  if FExpandedTimeRange then
    inherited Init(Min(AStart, FMinNecessaryDate), Max(AFinish, FMaxNecessaryDate), AStorage)
  else
    inherited Init(AStart, AFinish, AStorage);
  with DateTimeHelper do
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

function TcxSchedulerCachedEventList.IsIntersect(
  AEvent1, AEvent2: TcxSchedulerEvent): Boolean;
begin
  Result := not (AEvent1.IsFreeState or AEvent2.IsFreeState);
  if Result then
    Result := (((AEvent1.Start < AEvent2.Finish) and (AEvent2.Start < AEvent1.Finish)) or
      ((AEvent2.Start < AEvent1.Finish) and (AEvent1.Start < AEvent2.Finish)));
  if Result then
    Result := (VarIsNull(AEvent2.ResourceID) or AEvent1.IsSharedWithResource(AEvent2.ResourceID)) or
      (VarIsNull(AEvent1.ResourceID) or AEvent2.IsSharedWithResource(AEvent1.ResourceID));
end;

function TcxSchedulerCachedEventList.IsSelected(
  AEvent: TcxSchedulerControlEvent): Boolean;
begin
  Result := AEvent.IsClone or (Selection.IsSelected(AEvent) and
    (AlwaysShowSelectedEvent or (FClones.Count = 0)));
end;

procedure TcxSchedulerCachedEventList.PopulateAbsoluteItems;
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
end;

procedure TcxSchedulerCachedEventList.PostNewEvent(
  AEvent: TcxSchedulerControlEvent);
begin
  AEvent.FTimeBias := -FTimeBias;
  FBeforePostCount := Count - 1; 
  FNewEvent := Storage.CreateEvent;
  try
    FNewEvent.Assign(AEvent);
    FNewEvent.Post;
  except
    FNewEvent := nil;
    raise;
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

procedure TcxSchedulerCachedEventList.SetSelFinish(const AValue: TDateTime);
begin
  FSelFinish := AValue;
  if FExpandedTimeRange then
    FSelFinish := Max(FSelFinish, FMaxNecessaryDate);
end;

procedure TcxSchedulerCachedEventList.SetSelStart(const AValue: TDateTime);
begin
  FSelStart := AValue;
  if FExpandedTimeRange then
    FSelStart := Min(FSelStart, FMinNecessaryDate);
end;

{ TcxSchedulerOccurrenceCalculator }

constructor TcxSchedulerOccurrenceCalculator.Create(
  AEvent: TcxSchedulerEvent; const AStart, AFinish: TDateTime;
  ACalcForReminders: Boolean = False);
begin
  FCalcForReminders := ACalcForReminders;
  FWorkDays := DateTimeHelper.WorkDays;
  FStartOfWeek := DateTimeHelper.StartOfWeek;
  FEvent := AEvent;
  FVisibleStart := AStart;
  FVisibleFinish := AFinish;
  FRecurCount := FEvent.RecurrenceInfo.Count;
  InitTimes;
  FDayNumber := FEvent.RecurrenceInfo.DayNumber;
  FDayType := FEvent.RecurrenceInfo.DayType;
  FOccurDays := FEvent.RecurrenceInfo.OccurDays;
  FPeriodicity := FEvent.RecurrenceInfo.Periodicity;
  FRecurrence := Event.RecurrenceInfo.Recurrence;
  FYearPeriodicity := Event.RecurrenceInfo.YearPeriodicity;
end;

procedure TcxSchedulerOccurrenceCalculator.CalcOccurrence(AIndex: Integer);
begin
  InitTimes;
  FFinishDate := cxMaxDate;
  FRecurCount := -1;
  while (AIndex > 0) and GetNextOccurrence do
    Dec(AIndex);
end;

function TcxSchedulerOccurrenceCalculator.GetNextOccurrence: Boolean;
begin
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
  repeat
    //DELPHI8! check Trunc()
    if (FIndex = - 1) then
      CalcFirstDate
    else
      CalcNextDate;
    FOccurrenceFinish := FDate + (FOccurrenceFinish - DateOf(FOccurrenceStart));
    FOccurrenceStart := FDate + TimeOf(FOccurrenceStart);
    Inc(FIndex);
  until (not FCalcForReminders and (DateOf(FOccurrenceStart) >= DateOf(FVisibleStart))) or
    (FCalcForReminders and (DateOf(FOccurrenceStart) >= DateOf(FActualStart)));
  Result := IsValidOccurrence;
end;

function TcxSchedulerOccurrenceCalculator.GetOccurrenceCount(
  AEndDate: TDateTime): Integer;
begin
  Result := 0;
  InitTimes;
  while GetNextOccurrence and (DateOf(FOccurrenceStart) <= DateOf(AEndDate)) do
    Inc(Result);
end;

procedure TcxSchedulerOccurrenceCalculator.CalcFirstDate;
begin
  //DELPHI8! check Trunc()
  FDate := Trunc(FActualStart);
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

procedure TcxSchedulerOccurrenceCalculator.InitTimes;
begin
  if FRecurCount = 0 then
    FFinishDate := FEvent.RecurrenceInfo.Finish
  else
  begin
    if FCalcForReminders and (FRecurCount > 0) then
      FFinishDate := FEvent.RecurrenceInfo.GetEndDate
    else
      FFinishDate := VisibleFinish;
  end;
  FOccurrenceStart := FEvent.Start;
  FOccurrenceFinish := FOccurrenceStart + FEvent.Duration;
  if (FEvent.EventType <> etPattern) and (FEvent.Pattern <> nil) then
  begin
    FOccurrenceStart := FEvent.Pattern.Start;
    FOccurrenceFinish := FOccurrenceStart + FEvent.Pattern.Duration;
  end;
  FActualStart := FOccurrenceStart;
  FIndex := -1;
end;

function TcxSchedulerOccurrenceCalculator.IsValidOccurrence: Boolean;
begin
   Result := (DateOf(FOccurrenceStart) <= FVisibleFinish) and
    (((FRecurCount > 0) and (FIndex < FRecurCount)) or
    ((FRecurCount <= 0) and ((DateOf(FOccurrenceStart) <= FFinishDate) or
    (FCalcForReminders and (DateOf(FOccurrenceStart) <= FFinishDate)))));
end;

{ TcxSchedulerCustomReminderForm }

constructor TcxSchedulerCustomReminderForm.Create(
  AReminders: TcxSchedulerReminders);
begin
  inherited Create(nil);
  FReminders := AReminders;
end;

destructor TcxSchedulerCustomReminderForm.Destroy;
begin
  Reminders.FReminderWindow := nil;
  inherited Destroy;
end;

procedure TcxSchedulerCustomReminderForm.CheckFormPosition;
var
  X, Y: Integer;
  ACenterForm: TCustomForm;
begin
  if Position in [poMainFormCenter, poOwnerFormCenter] then
  begin
    ACenterForm := Application.MainForm;
    if (Position = poOwnerFormCenter) and (Owner is TCustomForm) then
      ACenterForm := TCustomForm(Owner);
    if Assigned(ACenterForm) then
    begin
      X := ((ACenterForm.Width - Width) div 2) + ACenterForm.Left;
      Y := ((ACenterForm.Height - Height) div 2) + ACenterForm.Top;
    end
    else
    begin
      X := (Screen.Width - Width) div 2;
      Y := (Screen.Height - Height) div 2;
    end;
    if X < 0 then X := 0;
    if Y < 0 then Y := 0;
    SetBounds(X, Y, Width, Height);
  end;
end;

procedure TcxSchedulerCustomReminderForm.CreateParams(
  var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

procedure TcxSchedulerCustomReminderForm.DoClose(var Action: TCloseAction);
begin
  inherited DoClose(Action);
  if Action = caHide then Action := caFree;
  Reminders.DoHideReminderWindow;
  cxDialogsMetricsStore.StoreMetrics(Self);
end;

procedure TcxSchedulerCustomReminderForm.DoShow;
begin
  SetControlLookAndFeel(Self, Reminders.ReminderWindowLookAndFeel);
  if UseSchedulerColorInDialogs then
    Color := GetFormColor;
  UpdateReminderList;
  inherited DoShow;
  Reminders.DoShowReminderWindow;
end;

procedure TcxSchedulerCustomReminderForm.FlashCaption;
var
  AFlashInfo: TFlashWInfo;
begin
  if Assigned(FlashWindowExProc) then
  begin
    AFlashInfo.cbSize := SizeOf(TFlashWInfo);
    AFlashInfo.hwnd := Handle;
    AFlashInfo.uCount := 1;
    AFlashInfo.dwFlags := FLASHW_ALL;
    AFlashInfo.dwTimeout := 1000;
    FlashWindowExProc(AFlashInfo);
  end
  else
    FlashWindow(Handle, True);
end;

function TcxSchedulerCustomReminderForm.GetFormColor: TColor;
begin
  Result := Reminders.ReminderWindowLookAndFeel.Painter.DefaultSchedulerControlColor;
end;

function TcxSchedulerCustomReminderForm.IsLocked: Boolean;
begin
  Result := (csDestroying in ComponentState) or
    (Reminders.Storage.ComponentState * [csLoading, csDestroying] <> [])
    or Reminders.NeedRestoreSelection or Reminders.IsLocked;
end;

procedure TcxSchedulerCustomReminderForm.OpenEvent(
  AEvent: TcxSchedulerControlEvent);
begin
  Reminders.DoOpenEvent(AEvent);
end;

function TcxSchedulerCustomReminderForm.OpenEventSupported: Boolean;
begin
  Result := Assigned(Reminders.FOnOpenEvent);
end;

procedure TcxSchedulerCustomReminderForm.RestoreSelection;
begin
end;

procedure TcxSchedulerCustomReminderForm.SaveSelection;
begin
end;

procedure TcxSchedulerCustomReminderForm.ShowInactive;
begin
  if not Visible then
  begin
    CheckFormPosition;
    if Application.Active then
    begin
      ShowWindow(Handle, SW_SHOWNA);
      Visible := True;
    end
    else
      Show;
  end
  else
    ShowWindow(Handle, SW_SHOWNA);
  FlashCaption;
end;

procedure TcxSchedulerCustomReminderForm.UpdateReminderList;
begin
end;

procedure TcxSchedulerCustomReminderForm.UpdateSelectionCaptions;
begin
  Caption := Reminders.GetReminderWindowCaption;
end;

{ TcxSchedulerReminder }

constructor TcxSchedulerReminder.Create(
  AOwner: TcxSchedulerReminders;
  AEvent: TcxSchedulerControlEvent);
begin
  inherited Create;
  FOwner := AOwner;
  FEvent := AEvent;
  FEventID := TcxSchedulerReminderEventID.Create(AEvent);
  FValid := True;
end;

destructor TcxSchedulerReminder.Destroy;
begin
  with Owner.FItems do if not Clearing then Remove(Self);
  FEventID.Free;
  inherited Destroy;
end;

procedure TcxSchedulerReminder.Dismiss;
begin
  DoDismiss;
end;

procedure TcxSchedulerReminder.Snooze(ASnoozeTime: TDateTime);
begin
  DoSnooze(ASnoozeTime);
end;

procedure TcxSchedulerReminder.DismissEvent;
begin
  if Event.EventType in [etCustom, etNone] then
    Event.Source.Reminder := False
  else
    Event.Pattern.RecurrenceInfo.DismissDate := GetRecurrenceDismissDate;
  Event.Reminder := False;
end;

procedure TcxSchedulerReminder.DoDismiss;
begin
  if not Owner.DoDismissReminder(Self) then
    DismissEvent;
end;

procedure TcxSchedulerReminder.DoSnooze(var ASnoozeTime: TDateTime);
begin
  if not Owner.DoSnoozeReminder(Self, ASnoozeTime) then
    SnoozeEvent(ASnoozeTime);
end;

function TcxSchedulerReminder.GetRecurrenceDismissDate: TDateTime;
begin
  Result := DateOf(Now);
end;

procedure TcxSchedulerReminder.SnoozeEvent(const ASnoozeTime: TDateTime);
var
  ATime: TDateTime;
begin
  ATime := DateTimeHelper.RoundTime(Owner.GetNow + Max(ASnoozeTime, MinuteToTime));
  if Event.EventType in [etCustom, etNone] then
    Event.Source.ReminderDate := ATime
  else
  begin
    Event.Pattern.BeginEditing;
    Event.Pattern.ReminderDate := ATime;
    Event.Pattern.RecurrenceInfo.DismissDate := DateOf(ATime) - MinuteToTime;
    Event.Pattern.EndEditing;
    Event.Pattern.Post;
  end;
  Event.ReminderDate := ATime;
end;

procedure TcxSchedulerReminder.Validate(AEvent: TcxSchedulerControlEvent);
begin
  FValid := True;
  FEvent := AEvent;
end;

{ TcxSchedulerReminderList }

procedure TcxSchedulerReminderList.Clear;
var
  I: Integer;
begin
  FClearing := True;
  try
    for I := 0 to Count - 1 do Items[I].Free;
    inherited Clear;
  finally
    FClearing := False;
  end;
end;

function TcxSchedulerReminderList.GetItem(
  Index: Integer): TcxSchedulerReminder;
begin
  Result := inherited Items[Index];
end;

function TcxSchedulerReminderList.IndexOfEvent(
  AEvent: TcxSchedulerControlEvent): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
    if Items[I].EventID.SameEvent(AEvent) then
    begin
      Result := I;
      break;
    end;
end;

procedure TcxSchedulerReminderList.Invalidate;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].FValid := False;
end;

{ TcxSchedulerReminders }

constructor TcxSchedulerReminders.Create(AStorage: TcxCustomSchedulerStorage);
begin
  inherited Create(AStorage);
  FStorage := AStorage;
  FDefaultMinutesBeforeStart := 15;
  FUseReminderWindow := True;
  FReminderWindowLookAndFeel := TcxLookAndFeel.Create(nil);
  FEvents := TcxSchedulerFilteredEventList.Create;
  FItems := TcxSchedulerReminderList.Create;
  CreateTimers;
  Active := True;
  cxFormatController.AddListener(Self);
end;

destructor TcxSchedulerReminders.Destroy;
begin
  cxFormatController.RemoveListener(Self);
  FUpdateEventsTimer.Free;
  FUpdateRemindersTimer.Free;
  FreeAndNil(FReminderWindow);
  FReminderWindowLookAndFeel.Free;
  FItems.Free;
  FEvents.Free;
  inherited Destroy;
end;

procedure TcxSchedulerReminders.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TcxSchedulerReminders then
    with TcxSchedulerReminders(Source) do
    begin
      Self.Active := Active;
      Self.DefaultReminder := DefaultReminder;
      Self.DefaultMinutesBeforeStart := DefaultMinutesBeforeStart;
      Self.ReminderWindowLookAndFeel := ReminderWindowLookAndFeel;
      Self.UseReminderWindow := UseReminderWindow;
    end;
end;

procedure TcxSchedulerReminders.DismissAll;
var
  I: Integer;
begin
  if not HasReminders then Exit;
  Storage.BeginUpdate;
  try
    for I := 0 to Count - 1 do
      Items[I].Dismiss;
  finally
    Storage.EndUpdate;
  end;
  UpdateReminderList;
  if not HasReminders then HideReminderWindow;
end;

procedure TcxSchedulerReminders.SnoozeAll(ASnoozeTime: TDateTime);
var
  I: Integer;
begin
  if not HasReminders then Exit;
  Storage.BeginUpdate;
  try
    for I := 0 to Count - 1 do
      Items[I].Snooze(ASnoozeTime);
  finally
    Storage.EndUpdate;
  end;
  UpdateReminderList;
  if not HasReminders then HideReminderWindow;
end;

function TcxSchedulerReminders.GetEventDueTimeText(
  AReminder: TcxSchedulerReminder; ATime: TDateTime): string;
var
  ADueTimeInfo: TcxSchedulerReminderDueTimeInfo;
  AMinutes: Integer;
begin
  AMinutes := Trunc((AReminder.Event.Start - ATime) * MinsPerDay);
  ADueTimeInfo := cxMinutesToDueTimeInfo(AMinutes);
  if Assigned(cxDueTimeInfoToTextProc) then
    Result := cxDueTimeInfoToTextProc(ADueTimeInfo)
  else
    Result := cxDueTimeInfoToText(ADueTimeInfo);
  DoGetEventDueTimeText(AReminder, ADueTimeInfo, Result);
end;

function TcxSchedulerReminders.HasReminders: Boolean;
begin
  Result := FItems.Count > 0;
end;

procedure TcxSchedulerReminders.HideReminderWindow;
begin
  if IsReminderWindowShown then
    ReminderWindow.Close;
end;

function TcxSchedulerReminders.IsLocked: Boolean;
begin
  with Storage do
    Result := FIsLoading or (ComponentState * [csDesigning, csDestroying, csLoading] <> []) or IsLocked;
end;

function TcxSchedulerReminders.IsReminderWindowShown: Boolean;
begin
  Result := (ReminderWindow <> nil) and
    not (csDestroying in ReminderWindow.ComponentState) and ReminderWindow.Showing;
end;

procedure TcxSchedulerReminders.Refresh;
begin
  if PopulateEventsCache then
    RefreshReminders;
end;

procedure TcxSchedulerReminders.FormatChanged;
begin
end;

procedure TcxSchedulerReminders.TimeChanged;
begin
  Refresh;
end;

procedure TcxSchedulerReminders.AddReminder(
  AEvent: TcxSchedulerControlEvent);
var
  AReminder: TcxSchedulerReminder;
begin
  AReminder := GetReminderClass.Create(Self, AEvent);
  if not DoAlertReminder(AReminder) then
  begin
    FItems.Add(AReminder);
    FNeedShowWindow := UseReminderWindow;
  end
  else
    AReminder.Free;
end;

procedure TcxSchedulerReminders.CheckAddReminder(
  AEvent: TcxSchedulerControlEvent);
begin
  if IsNeedAddToReminders(AEvent) then
    AddReminder(AEvent);
end;

function TcxSchedulerReminders.CreateReminderWindow: TcxSchedulerCustomReminderForm;
begin
  if Assigned(cxReminderFormClass) then
    Result := cxReminderFormClass.Create(Self)
  else
    Result := TcxSchedulerReminderForm.Create(Self);
end;

function TcxSchedulerReminders.DoAlertReminder(
  AReminder: TcxSchedulerReminder): Boolean;
begin
  Result := False;
  if Assigned(FOnAlertReminder) then
    FOnAlertReminder(Self, AReminder, Result);
end;

function TcxSchedulerReminders.DoDismissReminder(
  AReminder: TcxSchedulerReminder): Boolean;
begin
  Result := False;
  if Assigned(FOnDismissReminder) then
    FOnDismissReminder(Self, AReminder, Result);
end;

procedure TcxSchedulerReminders.DoGetEventDueTimeText(AReminder: TcxSchedulerReminder;
  const ADueTimeInfo: TcxSchedulerReminderDueTimeInfo; var AText: string);
begin
  if Assigned(FOnGetEventDueTimeText) then
    FOnGetEventDueTimeText(Self, AReminder, ADueTimeInfo, AText);
end;

procedure TcxSchedulerReminders.DoGetReminderWindowCaption(
  var ACaption: string);
begin
  if Assigned(FOnGetReminderWindowCaption) then
    FOnGetReminderWindowCaption(Self, ACaption);
end;

procedure TcxSchedulerReminders.DoOpenEvent(
  AEvent: TcxSchedulerControlEvent);
begin
  if Assigned(FOnOpenEvent) then
    FOnOpenEvent(Self, AEvent);
end;

function TcxSchedulerReminders.DoSnoozeReminder(
  AReminder: TcxSchedulerReminder; var ASnoozeTime: TDateTime): Boolean;
begin
  Result := False;
  if Assigned(FOnSnoozeReminder) then
    FOnSnoozeReminder(Self, AReminder, ASnoozeTime, Result);
end;

procedure TcxSchedulerReminders.DoHideReminderWindow;
begin
  if Assigned(FOnHideReminderWindow) then
    FOnHideReminderWindow(Self);
end;

procedure TcxSchedulerReminders.DoShowReminderWindow;
begin
  if Assigned(FOnShowReminderWindow) then
    FOnShowReminderWindow(Self);
end;

function TcxSchedulerReminders.GetNextPopulateEventsCacheTime(
  ANow: TDateTime; AIsLocked: Boolean): TDateTime;
begin
  if not AIsLocked then
    Result := DateOf(ANow) + 1 {one day lookaround}
  else
    Result := ANow + SecondToTime; {repeat in one second}
end;

function TcxSchedulerReminders.GetNextRefreshRemindersTime(
  ANow: TDateTime; AIsLocked: Boolean): TDateTime;
var
  I: Integer;
  AReminderDate: TDateTime;
begin
  Result := ANow;
  if not AIsLocked then
  begin
    Result := Result + ReminderRefreshInterval;
    for I := 0 to Events.Count - 1 do
    begin
      AReminderDate := Events[I].Source.ReminderDate;
      if AReminderDate > ANow then
        Result := Min(AReminderDate, Result);
    end;
  end;
  Result := Max(Result, ANow + SecondToTime);
end;

function TcxSchedulerReminders.GetNow: TDateTime;
begin
  Result := Now;
end;

function TcxSchedulerReminders.GetReminderClass: TcxSchedulerReminderClass;
begin
  Result := TcxSchedulerReminder;
end;

function TcxSchedulerReminders.GetReminderWindowCaption: string;
begin
  if Count = 1 then
    Result := cxGetResourceString(@scxrCaptionReminder)
  else
    Result := Format(cxGetResourceString(@scxrCaptionReminders), [Count]);
  DoGetReminderWindowCaption(Result);
end;

function TcxSchedulerReminders.IsNeedAddToReminders(
  AEvent: TcxSchedulerControlEvent): Boolean;
var
  AEventStart, ANow: TDateTime;
begin
  ANow := GetNow;
  Result := AEvent.ReminderDate <= ANow;
  if Result and (AEvent.EventType = etOccurrence) then
  begin
    AEventStart := AEvent.Start;
    Result := not ((DateOf(ANow) = DateOf(AEventStart)) and
      (AEventStart - AEvent.ReminderMinutesBeforeStart * MinuteToTime > ANow));
  end;
end;

function TcxSchedulerReminders.PopulateEventsCache: Boolean;
var
  ANow, ANextTime: TDateTime;
begin
  Result := not IsLocked;
  ANow := GetNow;
  ANextTime := GetNextPopulateEventsCacheTime(ANow, not Result);
  if Result then
  begin
    if IsReminderWindowShown then
    begin
      ReminderWindow.SaveSelection;
      NeedRestoreSelection := True;
    end;
    Storage.GetReminderEvents(DateOf(ANextTime), Events);
  end;
  UpdateTimer(UpdateEventsTimer, ANextTime - ANow);
end;

procedure TcxSchedulerReminders.RefreshReminders;
var
  ANow, ANextTime: TDateTime;
  AIsLocked: Boolean;
begin
  ANow := GetNow;
  AIsLocked := IsLocked;
  ANextTime := GetNextRefreshRemindersTime(ANow, AIsLocked);
  if not AIsLocked then
    UpdateReminderList;
  UpdateTimer(UpdateRemindersTimer, ANextTime - ANow);
end;

procedure TcxSchedulerReminders.RemoveGarbage;
var
  I: Integer;
  AReminder: TcxSchedulerReminder;
begin
  for I := FItems.Count - 1 downto 0 do
  begin
    AReminder := FItems[I];
    if not AReminder.Valid then
    begin
      FItems.Remove(AReminder);
      AReminder.Free;
    end;
  end;
end;

procedure TcxSchedulerReminders.StopTimers;
begin
  FUpdateEventsTimer.Enabled := False;
  FUpdateRemindersTimer.Enabled := False;
end;

procedure TcxSchedulerReminders.CheckReminderForEvent(AEvent: TcxSchedulerControlEvent);
var
  AIndex: Integer;
begin
  if AEvent = nil then
    Exit;
  AIndex := FItems.IndexOfEvent(AEvent);
  if AIndex < 0 then
    CheckAddReminder(AEvent)
  else
    if IsNeedAddToReminders(AEvent) then
      FItems[AIndex].Validate(AEvent);
end;

procedure TcxSchedulerReminders.CheckReminderForRecurringEvent(
  AEvent: TcxSchedulerControlEvent; var AIndex: Integer);
var
  AOccurrenceEvent: TcxSchedulerControlEvent;
  ACurrentPattern: TcxSchedulerEvent;
  ANow: TDateTime;
  AFound: Boolean;
  AEventStart: TDateTime;
begin
  ANow := GetNow;
  //find a right occurrence for a current pattern
  AOccurrenceEvent := nil;
  ACurrentPattern := AEvent.Pattern;
  AFound := False;
  while AIndex >= 0 do
  begin
    AEvent := Events[AIndex];
    if not AEvent.IsRecurring or (ACurrentPattern <> AEvent.Pattern) then
    begin
      Inc(AIndex); //correct index for an outer loop
      Break;
    end;
    //check a prev occurrence for a current pattern
    if (AEvent.EventType <> etException) and (AEvent.ReminderDate < ANow) then
    begin
      if AEvent.EventType <> etOccurrence then
        CheckReminderForEvent(AEvent)
      else
        if not AFound then
        begin
          AEventStart := AEvent.Start;
          if DateOf(AEventStart) > DateOf(ANow) then
          begin
            if AEventStart - AEvent.ReminderMinutesBeforeStart * MinuteToTime < ANow then
              AOccurrenceEvent := AEvent;
          end
          else
          begin
            if DateOf(AEventStart) = DateOf(ANow) then
              AOccurrenceEvent := AEvent
            else
              if AOccurrenceEvent = nil then
                AOccurrenceEvent := AEvent;
            AFound := True;
          end;
        end;
    end;
    Dec(AIndex);
  end;
  CheckReminderForEvent(AOccurrenceEvent);
end;

procedure TcxSchedulerReminders.ValidateReminderList;
var
  AIndex: Integer;
  AEvent: TcxSchedulerControlEvent;
begin
  FNeedShowWindow := False;
  FNeedCloseWindow := FItems.Count > 0;
  FItems.Invalidate;
  //need the countdown loop to ensure that the next occurrences (if exist)
  //from the current chain are already in the list (FItems)
  AIndex := Events.Count - 1;
  while AIndex >= 0 do
  begin
    AEvent := Events[AIndex];
    if AEvent.EventType = etOccurrence then
      CheckReminderForRecurringEvent(AEvent, AIndex)
    else
      CheckReminderForEvent(AEvent);
    Dec(AIndex);
  end;
  RemoveGarbage;
  FNeedCloseWindow := FNeedCloseWindow and (FItems.Count = 0);
end;

procedure TcxSchedulerReminders.UpdateReminderList;
var
  ARestoreSelection: Boolean;
begin
  if IsLocked or UpdatingReminderList then Exit;
  FUpdatingReminderList := True;
  try
    ValidateReminderList;
    ARestoreSelection := NeedRestoreSelection;
    NeedRestoreSelection := False;
    if IsReminderWindowShown then
    begin
      if NeedCloseWindow then
        HideReminderWindow
      else
      begin
        if NeedShowWindow and not ARestoreSelection then
        begin
          ReminderWindow.SaveSelection;
          ARestoreSelection := True;
        end;
        if ARestoreSelection then
          ReminderWindow.RestoreSelection;
      end;
      if NeedShowWindow then
        ReminderWindow.FlashCaption;
    end
    else
      if NeedShowWindow then ShowReminderWindow;
  finally
    FUpdatingReminderList := False;
  end;
end;

procedure TcxSchedulerReminders.UpdateTimer(ATimer: TTimer;
  AInterval: TDateTime);
begin
  if Active then
  begin
    ATimer.Enabled := False;
    ATimer.Interval := Trunc(AInterval * MSecsPerDay);
    ATimer.Enabled := True;
  end;
end;

procedure TcxSchedulerReminders.CreateTimers;
begin
  FUpdateEventsTimer := TTimer.Create(nil);
  FUpdateEventsTimer.Enabled := False;
  FUpdateEventsTimer.OnTimer := OnUpdateEventsTimer;
  FUpdateRemindersTimer := TTimer.Create(nil);
  FUpdateRemindersTimer.Enabled := False;
  FUpdateRemindersTimer.OnTimer := OnUpdateRemindersTimer;
end;

function TcxSchedulerReminders.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxSchedulerReminders.GetItem(
  Index: Integer): TcxSchedulerReminder;
begin
  if (Index >= 0) and (Index < Count) then Result := FItems[Index] else Result := nil;
end;

procedure TcxSchedulerReminders.SetActive(AValue: Boolean);
begin
  if FActive <> AValue then
  begin
    FActive := AValue;
    if AValue then
      StartReminder
    else
      StopReminder;
    Storage.SendNotification;
  end;
end;

procedure TcxSchedulerReminders.SetDefaultMinutesBeforeStart(AValue: Integer);
begin
  FDefaultMinutesBeforeStart := Max(0, AValue);
end;

procedure TcxSchedulerReminders.SetReminderWindowLookAndFeel(
  AValue: TcxLookAndFeel);
begin
  FReminderWindowLookAndFeel.Assign(AValue);
end;

procedure TcxSchedulerReminders.ShowReminderWindow;
begin
  if ReminderWindow = nil then
  begin
    FReminderWindow := CreateReminderWindow;
    cxDialogsMetricsStore.InitDialog(ReminderWindow);
  end;
  UpdateReminderList;
  ReminderWindow.ShowInactive;
end;

procedure TcxSchedulerReminders.StartReminder;
begin
  if (csDesigning in Storage.ComponentState) then Exit;
  FUpdateEventsTimer.Enabled := True;
  FUpdateRemindersTimer.Enabled := True;
  Refresh;
end;

procedure TcxSchedulerReminders.StopReminder;
begin
  StopTimers;
  HideReminderWindow;
  FItems.Clear;
  FEvents.Clear;
end;

procedure TcxSchedulerReminders.OnUpdateEventsTimer(Sender: TObject);
begin
  Refresh;
end;

procedure TcxSchedulerReminders.OnUpdateRemindersTimer(Sender: TObject);
begin
  RefreshReminders;
end;

var
  User32Lib: HMODULE;
  TempStream: TMemoryStream;
  TempWriter: TcxWriter;
  TempReader: TcxReader;

function cxVariantToFieldValue(const AValue: Variant): Variant;
var
  S: string;
begin
  if VarIsArray(AValue) and (VarArrayHighBound(AValue, 1) > 0) then
  begin
    TempStream.Clear;
    TempWriter.WriteInteger(varArray or varVariant);
    TempWriter.WriteInteger(0);
    TempWriter.WriteVariant(AValue);
    TempStream.Position := SizeOf(Integer);
    TempWriter.WriteInteger(TempStream.Size);
    SetLength(S, TempStream.Size);
    if TempStream.Size > 0 then
      Move(TempStream.Memory^, S[1], TempStream.Size);
    Result := S;
  end
  else
    if VarIsArray(AValue) then
      Result := AValue[0]
    else
      Result := AValue;
end;

function cxFieldValueToVariant(const AValue: Variant): Variant;
var
  S: string;
begin
  if VarType(AValue) = varString then
  begin
    S := VarToStr(AValue);
    if Length(S) > SizeOf(Integer) * 2 then
    begin
      TempStream.Clear;
      TempStream.Size := Length(S);
      if TempStream.Size > 0 then
        Move(S[1], TempStream.Memory^, TempStream.Size);
      if (TempReader.ReadInteger = (varArray or varVariant)) and (TempReader.ReadInteger = TempStream.Size) then
      begin
        Result := TempReader.ReadVariant;
        Exit;
      end;
    end
  end;
  Result := AValue;
end;

initialization
  TempStream := TMemoryStream.Create;
  TempWriter := TcxWriter.Create(TempStream);
  TempReader := TcxReader.Create(TempStream);
  //
  User32Lib := LoadLibrary(user32);
  FlashWindowExProc := GetProcAddress(User32Lib, 'FlashWindowEx');

finalization
  TempStream.Free;
  TempWriter.Free;
  TempReader.Free;
  //
  FreeLibrary(User32Lib);

end.
