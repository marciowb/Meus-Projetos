{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumGrid                                           }
{                                                                    }
{       Copyright (c) 1998-2010 Developer Express Inc.               }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMGRID AND ALL            }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
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

unit cxGridCustomTableView;

{$I cxGridVer.inc}

interface

uses
  Windows, Messages,
  Classes, Graphics, Controls, ExtCtrls,
  cxClasses, cxGraphics, cxControls, cxLookAndFeels, cxStorage, cxFilterControl, cxNavigator,
  cxDataStorage, cxCustomData, cxData, cxFilter, cxDataUtils,
  cxContainer, cxEdit, cxStyles,
  cxGridCommon, cxGridCustomView;

const
  cxGridFilterDefaultMaxDropDownCount = 15;
  cxGridItemDefaultMinWidth = 20;
  cxGridNavigatorDefaultOffset = 50;

  htCustomGridTableBase = 100;
  htRecord = htCustomGridTableBase + 1;
  htCell = htCustomGridTableBase + 2;
  htExpandButton = htCustomGridTableBase + 3;
  htNavigator = htCustomGridTableBase + 4;

  isCustomItemFirst = 0;
  isContent = isCustomItemFirst;
  isCustomItemLast = isContent;

  bbCustomTableFirst = bbCustomLast + 1;
  bbContent = bbCustomTableFirst;
  bbCustomTableLast = bbContent;

  vsCustomTableFirst = vsCustomLast + 1;
  vsContent = vsCustomTableFirst;
  vsContentEven = vsCustomTableFirst + 1;
  vsContentOdd = vsCustomTableFirst + 2;
  vsInactive = vsCustomTableFirst + 3;
  vsIncSearch = vsCustomTableFirst + 4;
  vsSelection = vsCustomTableFirst + 5;
  vsCustomTableLast = vsSelection;

type
  TcxGridItemDataBindingClass = class of TcxGridItemDataBinding;
  TcxCustomGridTableController = class;
  TcxCustomGridRecord = class;
  TcxCustomGridTableViewData = class;
  TcxGridTableDataCellViewInfo = class;
  TcxCustomGridRecordViewInfoClass = class of TcxCustomGridRecordViewInfo;
  TcxCustomGridRecordViewInfo = class;
  TcxCustomGridRecordsViewInfo = class;
  TcxCustomGridTableViewInfo = class;
  TcxCustomGridTableViewInfoCacheItem = class;
  TcxCustomGridTableItem = class;
  TcxCustomGridTableView = class;

  { changes }

  TcxGridDataChange = class(TcxCustomGridViewChange)
  public
    procedure Execute; override;
    function IsLockable: Boolean; override;
  end;

  TcxGridRecordChange = class(TcxCustomGridViewChange)
  private
    FItem: TcxCustomGridTableItem;
    FRecord: TcxCustomGridRecord;
    FRecordIndex: Integer;
    function GetGridView: TcxCustomGridTableView;
    function GetRecordViewInfo: TcxCustomGridRecordViewInfo;
  public
    constructor Create(AGridView: TcxCustomGridView; ARecord: TcxCustomGridRecord;
      ARecordIndex: Integer; AItem: TcxCustomGridTableItem = nil); reintroduce; virtual;
    procedure Execute; override;
    function IsCompatibleWith(AChange: TcxCustomGridChange): Boolean; override;
    //function IsCumulative: Boolean; override;  {1}
    function IsEqual(AChange: TcxCustomGridChange): Boolean; override;
    function IsItemVisible: Boolean;
    property GridRecord: TcxCustomGridRecord read FRecord;
    property GridView: TcxCustomGridTableView read GetGridView;
    property Item: TcxCustomGridTableItem read FItem;
    property RecordIndex: Integer read FRecordIndex;
    property RecordViewInfo: TcxCustomGridRecordViewInfo read GetRecordViewInfo;
  end;

  TcxGridFocusedRecordChange = class(TcxCustomGridViewChange)
  private
    FFocusedRecordIndex: Integer;
    FNewItemRecordFocusingChanged: Boolean;
    FPrevFocusedRecordIndex: Integer;
  public
    constructor Create(AGridView: TcxCustomGridView;
      APrevFocusedRecordIndex, AFocusedRecordIndex: Integer;
      ANewItemRecordFocusingChanged: Boolean); reintroduce; virtual;
    procedure Execute; override;
    property FocusedRecordIndex: Integer read FFocusedRecordIndex;
    property NewItemRecordFocusingChanged: Boolean read FNewItemRecordFocusingChanged;
    property PrevFocusedRecordIndex: Integer read FPrevFocusedRecordIndex;
  end;

  { hit tests }

  TcxGridRecordHitTestClass = class of TcxGridRecordHitTest;

  TcxGridRecordHitTest = class(TcxCustomGridViewHitTest)
  private
    FGridRecordIndex: Integer;
    FIsNewItemRecord: Boolean;
    FViewData: TcxCustomGridTableViewData;
    function GetGridRecord: TcxCustomGridRecord;
    procedure SetGridRecord(Value: TcxCustomGridRecord);
  protected
    class function GetHitTestCode: Integer; override;
  public
    class function CanClick: Boolean; virtual;
    property GridRecord: TcxCustomGridRecord read GetGridRecord write SetGridRecord;
  end;

  TcxGridRecordCellHitTest = class(TcxGridRecordHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  public
    Item: TcxCustomGridTableItem;
  end;

  TcxGridExpandButtonHitTest = class(TcxGridRecordHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  public
    class function CanClick: Boolean; override;
  end;

  TcxGridNavigatorHitTest = class(TcxCustomGridViewHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  { data definitions }

  TcxGridDefaultValuesProvider = class(TcxCustomEditDefaultValuesProvider)
  public
    function IsDisplayFormatDefined(AIsCurrencyValueAccepted: Boolean): Boolean; override;
  end;

  IcxGridDataController = interface
  ['{FEEE7E69-BD54-4B5D-BA0B-B6116B69C0CC}']
    procedure CheckGridModeBufferCount;
    function DoScroll(AForward: Boolean): Boolean;
    function DoScrollPage(AForward: Boolean): Boolean;
    function GetItemDataBindingClass: TcxGridItemDataBindingClass;
    function GetItemDefaultValuesProviderClass: TcxCustomEditDefaultValuesProviderClass;
    function GetNavigatorIsBof: Boolean;
    function GetNavigatorIsEof: Boolean;
    function GetFilterPropertyValue(const AName: string; var AValue: Variant): Boolean;
    function GetScrollBarPos: Integer;
    function GetScrollBarRecordCount: Integer;
    function SetFilterPropertyValue(const AName: string; const AValue: Variant): Boolean;
    function SetScrollBarPos(Value: Integer): Boolean;
  end;

  TcxGridDataController = class(TcxDataController,
    IcxCustomGridDataController, IcxGridDataController)
  private
    function GetGridViewValue: TcxCustomGridTableView;
  protected
    { IcxCustomGridDataController }
    procedure GetFakeComponentLinks(AList: TList);
    function GetGridView: TcxCustomGridView;
    { IcxGridDataController }
    procedure CheckGridModeBufferCount;
    function DoScroll(AForward: Boolean): Boolean;
    function DoScrollPage(AForward: Boolean): Boolean;
    function GetFilterPropertyValue(const AName: string; var AValue: Variant): Boolean;
    function GetItemDataBindingClass: TcxGridItemDataBindingClass;
    function GetItemDefaultValuesProviderClass: TcxCustomEditDefaultValuesProviderClass;
    function GetNavigatorIsBof: Boolean;
    function GetNavigatorIsEof: Boolean;
    function GetScrollBarPos: Integer;
    function GetScrollBarRecordCount: Integer;
    function SetFilterPropertyValue(const AName: string; const AValue: Variant): Boolean;
    function SetScrollBarPos(Value: Integer): Boolean;

    function CanSelectRow(ARowIndex: Integer): Boolean; override;
    procedure DoValueTypeClassChanged(AItemIndex: Integer); override;
    function GetDefaultActiveRelationIndex: Integer; override;
    //function GetIncrementalSearchText(ARecordIndex, AItemIndex: Integer): string; override;
    function GetItemID(AItem: TObject): Integer; override;
    function GetSummaryGroupItemLinkClass: TcxDataSummaryGroupItemLinkClass; override;
    function GetSummaryItemClass: TcxDataSummaryItemClass; override;
  public
    procedure BeginFullUpdate; override;
    procedure EndFullUpdate; override;
    function CreateDetailLinkObject(ARelation: TcxCustomDataRelation;
      ARecordIndex: Integer): TObject; override;
    procedure FocusControl(AItemIndex: Integer; var Done: Boolean); override;
    function GetDetailDataControllerByLinkObject(ALinkObject: TObject): TcxCustomDataController; override;
    function GetDisplayText(ARecordIndex, AItemIndex: Integer): string; override;
    function GetFilterItemFieldCaption(AItem: TObject): string; override;
    function GetItem(Index: Integer): TObject; override;
    function GetItemSortByDisplayText(AItemIndex: Integer; ASortByDisplayText: Boolean): Boolean; override;
    function GetItemValueSource(AItemIndex: Integer): TcxDataEditValueSource; override;
    procedure UpdateData; override;

    //!!! maybe remove? check events
    function AddItemToFilter(AParent: TcxFilterCriteriaItemList; AItem: TcxCustomGridTableItem;
      AOperatorKind: TcxFilterOperatorKind; const AValue: Variant; ADisplayText: string = '';
      AReplaceExistent: Boolean = True): TcxFilterCriteriaItem;

    property GridView: TcxCustomGridTableView read GetGridViewValue;
  published
    property Filter;
    property Options;
    property Summary;
    property OnCompare;
    property OnDataChanged;
    property OnGroupingChanged;
    property OnRecordChanged;
    property OnSortingChanged;
  end;

  TcxGridItemDataBinding = class(TPersistent)
  private
    FData: Pointer;
    FDefaultValuesProvider: TcxCustomEditDefaultValuesProvider;
    FItem: TcxCustomGridTableItem;
    function GetDataController: TcxCustomDataController;
    function GetFilter: TcxDataFilterCriteria;
    function GetFilterCriteriaItem: TcxFilterCriteriaItem;
    function GetFiltered: Boolean;
    function GetGridView: TcxCustomGridTableView;
    function GetValueTypeClass: TcxValueTypeClass;
    procedure SetFiltered(Value: Boolean);
    procedure SetValueTypeClass(Value: TcxValueTypeClass);
  protected
    function GetDefaultValuesProviderClass: TcxCustomEditDefaultValuesProviderClass;
    procedure Init; virtual;
    property DefaultValuesProvider: TcxCustomEditDefaultValuesProvider read FDefaultValuesProvider;
  public
    constructor Create(AItem: TcxCustomGridTableItem); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    function DefaultCaption: string; virtual;
    function DefaultRepositoryItem: TcxEditRepositoryItem; virtual;
    function DefaultWidth(ATakeHeaderIntoAccount: Boolean = True): Integer; virtual;
    function GetDefaultValuesProvider(AProperties: TcxCustomEditProperties = nil): IcxEditDefaultValuesProvider;
    function IsDisplayFormatDefined: Boolean;

    function AddToFilter(AParent: TcxFilterCriteriaItemList; AOperatorKind: TcxFilterOperatorKind;
      const AValue: Variant; const ADisplayText: string = '';
      AReplaceExistent: Boolean = True): TcxFilterCriteriaItem;
    procedure GetFilterDisplayText(const AValue: Variant; var ADisplayText: string);
    procedure GetFilterStrings(AStrings: TStrings; AValueList: TcxDataFilterValueList);

    property Data: Pointer read FData write FData;
    property DataController: TcxCustomDataController read GetDataController;
    property Filter: TcxDataFilterCriteria read GetFilter;
    property FilterCriteriaItem: TcxFilterCriteriaItem read GetFilterCriteriaItem;
    property Filtered: Boolean read GetFiltered write SetFiltered;
    property GridView: TcxCustomGridTableView read GetGridView;
    property Item: TcxCustomGridTableItem read FItem;
    property ValueTypeClass: TcxValueTypeClass read GetValueTypeClass write SetValueTypeClass;
  end;

  { controller }

  TcxCustomGridTableDragAndDropObject = class(TcxCustomGridDragAndDropObject)
  private
    function GetController: TcxCustomGridTableController;
    function GetGridView: TcxCustomGridTableView;
    function GetViewInfo: TcxCustomGridTableViewInfo;
  protected
    property Controller: TcxCustomGridTableController read GetController;
    property GridView: TcxCustomGridTableView read GetGridView;
    property ViewInfo: TcxCustomGridTableViewInfo read GetViewInfo;
  end;

  TcxGridEditingControllerClass = class of TcxGridEditingController;

  TcxGridEditingController = class
  private
    FController: TcxCustomGridTableController;
    FEdit: TcxCustomEdit;
    FEditHiding: Boolean;
    FEditingItem: TcxCustomGridTableItem;
    FEditingItemSetting: Boolean;
    FEditList: TcxInplaceEditList;
    FEditPreparing: Boolean;
    FEditShowingTimer: TTimer;
    FEditShowingTimerItem: TcxCustomGridTableItem;
    FEditUpdateNeeded: Boolean;
    FInitiatingEditing: Boolean;
    FIsEditPlaced: Boolean;
    FIsErrorOnEditExit: Boolean;
    FPrevEditOnChange: TNotifyEvent;
    FPrevEditOnEditValueChanged: TNotifyEvent;
    function GetEditingProperties: TcxCustomEditProperties;
    function GetGridView: TcxCustomGridTableView;
    function GetIsEditing: Boolean;
    procedure SetEditingItem(Value: TcxCustomGridTableItem);
    procedure EditShowingTimerHandler(Sender: TObject);
  protected
    procedure AfterViewInfoCalculate; virtual;
    procedure BeforeViewInfoCalculate; virtual;
    procedure CancelEditUpdatePost;
    function CanRemoveEditFocus: Boolean; virtual;
    procedure CheckEditUpdatePost;
    procedure DoUpdateEdit;
    function GetHideEditOnExit: Boolean; virtual;
    function GetHideEditOnFocusedRecordChange: Boolean; virtual;
    procedure InitEdit; virtual;
    procedure PostEditUpdate;
    function PrepareEdit(AItem: TcxCustomGridTableItem; AOnMouseEvent: Boolean): Boolean; virtual;
    procedure UpdateEditValue;
    procedure UpdateValue;

    procedure EditAfterKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    procedure EditChanged(Sender: TObject); virtual;
    procedure EditEditing(Sender: TObject; var CanEdit: Boolean); virtual;
    procedure EditExit(Sender: TObject); virtual;
    procedure EditFocusChanged(Sender: TObject); virtual;
    procedure EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    procedure EditPostEditValue(Sender: TObject); virtual;
    procedure EditValueChanged(Sender: TObject); virtual;

    property EditHiding: Boolean read FEditHiding;
    property EditingProperties: TcxCustomEditProperties read GetEditingProperties;
    property EditList: TcxInplaceEditList read FEditList;
    property EditUpdateNeeded: Boolean read FEditUpdateNeeded;
    property HideEditOnExit: Boolean read GetHideEditOnExit;
    property HideEditOnFocusedRecordChange: Boolean read GetHideEditOnFocusedRecordChange;
    property InitiatingEditing: Boolean read FInitiatingEditing;
    property IsEditPlaced: Boolean read FIsEditPlaced;
    property IsErrorOnEditExit: Boolean read FIsErrorOnEditExit;
  public
    constructor Create(AController: TcxCustomGridTableController); virtual;
    destructor Destroy; override;

    procedure HideEdit(Accept: Boolean); virtual;
    procedure RemoveEdit(AProperties: TcxCustomEditProperties); virtual;
    procedure ShowEdit(AItem: TcxCustomGridTableItem = nil); overload;
    procedure ShowEdit(AItem: TcxCustomGridTableItem; Key: Char); overload;
    procedure ShowEdit(AItem: TcxCustomGridTableItem; Shift: TShiftState; X, Y: Integer); overload;
    procedure UpdateEdit;

    procedure StartEditShowingTimer(AItem: TcxCustomGridTableItem);
    procedure StopEditShowingTimer;

    property Controller: TcxCustomGridTableController read FController;
    property Edit: TcxCustomEdit read FEdit;
    property EditingItem: TcxCustomGridTableItem read FEditingItem write SetEditingItem;
    property GridView: TcxCustomGridTableView read GetGridView;
    property IsEditing: Boolean read GetIsEditing;
  end;

  TcxGridDragOpenInfoExpand = class(TcxCustomGridDragOpenInfo)
  public
    GridRecord: TcxCustomGridRecord;
    constructor Create(AGridRecord: TcxCustomGridRecord); virtual;
    function Equals(AInfo: TcxCustomGridDragOpenInfo): Boolean; override;
    procedure Run; override;
  end;

  TcxCustomGridTableCanItemFocus = function(AOwner: TcxCustomGridTableView;
    AItemIndex: Integer; AData: Pointer): Boolean;

  TcxCustomGridTableController = class(TcxCustomGridController)
  private
    FAllowCheckEdit: Boolean;
    FBlockRecordKeyboardHandling: Boolean;
    FCheckEditNeeded: Boolean;
    FCheckingCoordinate: Boolean;
    FDragFocusingMousePos: TPoint;
    FDragScrollDirection: TcxDirection;
    FDragScrollTimer: TTimer;
    FDragFocusingScrollTimer: TTimer;
    FDragHighlightedRecord: TcxCustomGridRecord;
    FEatKeyPress: Boolean;
    FEditingController: TcxGridEditingController;
    FFocusedItem: TcxCustomGridTableItem;
    FFocusOnRecordFocusing: Boolean;
    FForcingWidthItem: TcxCustomGridTableItem;
    FGridModeBufferCountUpdateNeeded: Boolean;
    FGridModeBufferCountUpdateTimer: TTimer;
    FIsCheckingCoordinates: Boolean;
    FIsDragFocusing: Boolean;
    FIsDragFocusingScrollForward: Boolean;
    FIsRecordUnselecting: Boolean;
    FTopRecordIndex: Integer;
    FUnselectingRecordIndex: Integer;

    function GetEditingItem: TcxCustomGridTableItem;
    function GetFocusedItemIndex: Integer;
    function GetFocusedRecordIndex: Integer;
    function GetGridView: TcxCustomGridTableView;
    function GetIncSearchingItem: TcxCustomGridTableItem;
    function GetIncSearchingText: string;
    function GetIsEditing: Boolean;
    function GetIsIncSearching: Boolean;
    function GetMasterController: TcxCustomGridTableController;
    function GetMultiSelect: Boolean;
    function GetSelectedRecord(Index: Integer): TcxCustomGridRecord;
    function GetSelectedRecordCount: Integer;
    function GetViewData: TcxCustomGridTableViewData;
    function GetViewInfo: TcxCustomGridTableViewInfo;
    procedure SetDragHighlightedRecord(Value: TcxCustomGridRecord);
    procedure SetEditingItem(Value: TcxCustomGridTableItem);
    procedure SetFocusedItem(Value: TcxCustomGridTableItem);
    procedure SetFocusedItemIndex(Value: Integer);
    procedure SetFocusedRecordIndex(Value: Integer);
    procedure SetIncSearchingText(const Value: string);
    procedure SetInternalTopRecordIndex(Value: Integer);
    procedure SetTopRecordIndex(Value: Integer);

    procedure DragFocusingScrollTimerHandler(Sender: TObject);
    procedure DragScrollTimerHandler(Sender: TObject);
    procedure GridModeBufferCountUpdateTimerHandler(Sender: TObject);
  protected
    procedure AfterPaint; override;
    procedure BeforePaint; override;
    procedure DetailFocused(ADetail: TcxCustomGridView); override;
    procedure DoEnter; override;
    procedure DoExit; override;
    function MayFocus: Boolean; override;
    procedure RemoveFocus; override;
    procedure SetFocus; override;

    procedure AfterOffset; virtual;
    procedure BeforeKillFocus; override;
    procedure BeforeOffset; virtual;
    function CanAppend(ACheckOptions: Boolean): Boolean; virtual;
    procedure CancelCheckEditPost;
    function CanDelete(ACheckOptions: Boolean): Boolean; virtual;
    function CanEdit: Boolean; virtual;
    function CanHScrollBarHide: Boolean; virtual;
    function CanInsert(ACheckOptions: Boolean): Boolean; virtual;
    procedure CheckEdit; virtual;
    procedure CheckCoordinates; virtual;
    procedure CheckTopRecordIndex(var Value: Integer); virtual;
    function FindNextCustomItem(AFocusedItemIndex, AItemCount: Integer;
      AGoForward, AGoOnCycle: Boolean; ACanFocus: TcxCustomGridTableCanItemFocus;
      AData: Pointer; var AItemIndex: Integer; out ACycleChanged: Boolean): Boolean;
    procedure FocusedItemChanged(APrevFocusedItem: TcxCustomGridTableItem); virtual;
    function GetCancelEditingOnExit: Boolean; virtual;
    function GetFocusedRecord: TcxCustomGridRecord; virtual;
    function GetIsRecordsScrollHorizontal: Boolean; virtual; abstract;
    function GetMaxTopRecordIndexValue: Integer; virtual;
    function GetScrollBarOffsetBegin: Integer; virtual;
    function GetScrollBarOffsetEnd: Integer; virtual;
    function GetScrollBarPos: Integer; virtual;
    function GetScrollBarRecordCount: Integer; virtual;
    function GetVisibleRecordCount(AFirstRecordIndex: Integer;
      ACalculateDown: Boolean = True): Integer; virtual;
    procedure PostCheckEdit;
    procedure ProcessCheckEditPost;
    procedure SetFocusedRecord(Value: TcxCustomGridRecord); virtual;
    procedure SetScrollBarPos(Value: Integer); virtual;

    procedure CancelGridModeBufferCountUpdate;
    procedure CheckGridModeBufferCountUpdatePost;
    procedure PostGridModeBufferCountUpdate;
    property GridModeBufferCountUpdateNeeded: Boolean read FGridModeBufferCountUpdateNeeded;

    // selection
    function CanProcessMultiSelect(AIsKeyboard: Boolean): Boolean; overload; virtual;
    function CanProcessMultiSelect(AHitTest: TcxCustomGridHitTest): Boolean; overload; virtual;
    function CanProcessMultiSelect(AKey: Word; AShift: TShiftState;
      AFocusedRecordChanged: Boolean): Boolean; overload; virtual;
    procedure ChangeRecordSelection(ARecord: TcxCustomGridRecord; Value: Boolean);
    procedure CheckFocusedRecordSelectionWhenExit(ARecord: TcxCustomGridRecord);
    procedure DoNormalSelection;
    procedure DoNormalSelectionWithAnchor(ASelect: Boolean = True);
    procedure DoRangeSelection(AClearSelection: Boolean = True);
    procedure DoToggleRecordSelection;
    procedure FinishSelection; virtual;
    procedure InvalidateFocusedRecord; virtual;
    procedure InvalidateSelection; virtual;
    function IsKeyForMultiSelect(AKey: Word; AShift: TShiftState;
      AFocusedRecordChanged: Boolean): Boolean; virtual;
    function IsRecordSelected(ARecord: TcxCustomGridRecord): Boolean;
    procedure MultiSelectKeyDown(var Key: Word; Shift: TShiftState); virtual;
    procedure MultiSelectMouseDown(AHitTest: TcxCustomGridHitTest; AShift: TShiftState); virtual;
    procedure MultiSelectMouseUp(AHitTest: TcxCustomGridHitTest; AShift: TShiftState); virtual;
    procedure SetSelectionAnchor(AGridRecordIndex: Integer);

    // navigation
    function FocusedRecordHasCells(ACheckCellSelect: Boolean): Boolean;
    procedure FocusNextPage(ASyncSelection: Boolean); virtual;
    procedure FocusPrevPage(ASyncSelection: Boolean); virtual;
    function IsKeyForController(AKey: Word; AShift: TShiftState): Boolean; virtual;
    procedure ScrollPage(AForward: Boolean); virtual;
    procedure ScrollRecords(AForward: Boolean; ACount: Integer); virtual;
    procedure ShowNextPage; virtual;
    procedure ShowPrevPage; virtual;

    // drag select
    function GetDragFocusingScrollDirection(X, Y: Integer;
      out AMoveForward: Boolean): Boolean; virtual;
    procedure StartDragFocusing;
    procedure StopDragFocusing;
    procedure StartDragFocusingScroll(AMoveForward: Boolean);
    procedure StopDragFocusingScroll;

    // delphi drag and drop
    function GetDragScrollDirection(X, Y: Integer): TcxDirection; virtual;
    procedure ProcessDragFocusing(X, Y: Integer);
    procedure StartDragScroll(ADirection: TcxDirection);
    procedure StopDragScroll;
    function IsDragScroll: Boolean;
    //---
    function GetDragOpenInfo(AHitTest: TcxCustomGridHitTest): TcxCustomGridDragOpenInfo; virtual;
    function IsDragOpenHitTest(AHitTest: TcxCustomGridHitTest;
      out ADragOpenInfo: TcxCustomGridDragOpenInfo): Boolean;
    //---
    property DragHighlightedRecord: TcxCustomGridRecord read FDragHighlightedRecord write SetDragHighlightedRecord;

    function GetItemForIncSearching: TcxCustomGridTableItem; virtual;
    procedure IncSearchKeyDown(var Key: Word; Shift: TShiftState); virtual;
    property ItemForIncSearching: TcxCustomGridTableItem read GetItemForIncSearching;

    function GetEditingControllerClass: TcxGridEditingControllerClass; virtual;

    property AllowCheckEdit: Boolean read FAllowCheckEdit write FAllowCheckEdit;
    property BlockRecordKeyboardHandling: Boolean read FBlockRecordKeyboardHandling
      write FBlockRecordKeyboardHandling;
    property CancelEditingOnExit: Boolean read GetCancelEditingOnExit;
    property EatKeyPress: Boolean read FEatKeyPress write FEatKeyPress;
    property FocusOnRecordFocusing: Boolean read FFocusOnRecordFocusing write FFocusOnRecordFocusing;
    property ForcingWidthItem: TcxCustomGridTableItem read FForcingWidthItem write FForcingWidthItem;
    property InternalTopRecordIndex: Integer read FTopRecordIndex write SetInternalTopRecordIndex;
    property IsCheckingCoordinates: Boolean read FIsCheckingCoordinates;
    property IsRecordsScrollHorizontal: Boolean read GetIsRecordsScrollHorizontal;
    property MultiSelect: Boolean read GetMultiSelect;
    property ScrollBarOffsetBegin: Integer read GetScrollBarOffsetBegin;
    property ScrollBarOffsetEnd: Integer read GetScrollBarOffsetEnd;
    property ScrollBarRecordCount: Integer read GetScrollBarRecordCount;
    property ScrollBarPos: Integer read GetScrollBarPos write SetScrollBarPos;
    property ViewData: TcxCustomGridTableViewData read GetViewData;
    property ViewInfo: TcxCustomGridTableViewInfo read GetViewInfo;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    destructor Destroy; override;
    procedure BeginDragAndDrop; override;
    procedure ControlFocusChanged; override;
    procedure DoCancelMode; override;
    procedure DoKeyDown(var Key: Word; Shift: TShiftState); override;
    procedure EndDragAndDrop(Accepted: Boolean); override;
    function FindNextItem(AFocusedItemIndex: Integer;
      AGoForward, AGoOnCycle: Boolean; out ACycleChanged: Boolean): Integer; virtual;
    function FindNextRecord(AFocusedRecordIndex: Integer;
      AGoForward, AGoOnCycle: Boolean; out ACycleChanged: Boolean): Integer;
    function HasFocusedControls: Boolean; override;
    function IsDataFullyVisible(AIsCallFromMaster: Boolean = False): Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure WndProc(var Message: TMessage); override;

    procedure BeforeStartDrag; override;
    function CanDrag(X, Y: Integer): Boolean; override;
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean); override;
    procedure EndDrag(Target: TObject; X, Y: Integer); override;
    procedure StartDrag(var DragObject: TDragObject); override;

    procedure CancelIncSearching;
    procedure ClearSelection;
    procedure CreateNewRecord(AtEnd: Boolean); virtual;
    procedure DeleteSelection; virtual;
    procedure DoCheckCoordinates;
    function FocusFirstAvailableItem: Boolean;
    function FocusNextCell(AGoForward: Boolean; AProcessCellsOnly: Boolean = True): Boolean;
    function FocusNextItem(AFocusedItemIndex: Integer;
      AGoForward, AGoOnCycle, AGoToNextRecordOnCycle: Boolean): Boolean;
    function FocusNextRecord(AFocusedRecordIndex: Integer;
      AGoForward, AGoOnCycle, AGoIntoDetail: Boolean): Boolean;
    function FocusNextRecordWithSelection(AFocusedRecordIndex: Integer;
      AGoForward, AGoOnCycle, AGoIntoDetail: Boolean; ASyncSelection: Boolean = True): Boolean;
    function FocusRecord(AFocusedRecordIndex: Integer; ASyncSelection: Boolean): Boolean;
    procedure MakeFocusedItemVisible;
    procedure MakeFocusedRecordVisible;
    procedure MakeItemVisible(AItem: TcxCustomGridTableItem); virtual; abstract;
    procedure MakeRecordVisible(ARecord: TcxCustomGridRecord); virtual;

    function GoToFirst: Boolean;
    function GoToLast(AGoIntoDetail: Boolean): Boolean;
    function GoToNext(AGoIntoDetail: Boolean; ASyncSelection: Boolean = True): Boolean;
    function GoToPrev(AGoIntoDetail: Boolean; ASyncSelection: Boolean = True): Boolean;
    function IsFinish: Boolean;
    function IsStart: Boolean;

    property EditingController: TcxGridEditingController read FEditingController;
    property EditingItem: TcxCustomGridTableItem read GetEditingItem write SetEditingItem;
    property FocusedItem: TcxCustomGridTableItem read FFocusedItem write SetFocusedItem;
    property FocusedItemIndex: Integer read GetFocusedItemIndex write SetFocusedItemIndex;
    property FocusedRecord: TcxCustomGridRecord read GetFocusedRecord write SetFocusedRecord;
    property FocusedRecordIndex: Integer read GetFocusedRecordIndex write SetFocusedRecordIndex;
    property GridView: TcxCustomGridTableView read GetGridView;
    property IncSearchingItem: TcxCustomGridTableItem read GetIncSearchingItem;
    property IncSearchingText: string read GetIncSearchingText write SetIncSearchingText;
    property IsDragFocusing: Boolean read FIsDragFocusing;
    property IsEditing: Boolean read GetIsEditing;
    property IsIncSearching: Boolean read GetIsIncSearching;
    property MasterController: TcxCustomGridTableController read GetMasterController;
    property SelectedRecordCount: Integer read GetSelectedRecordCount;
    property SelectedRecords[Index: Integer]: TcxCustomGridRecord read GetSelectedRecord;
    property TopRecordIndex: Integer read FTopRecordIndex write SetTopRecordIndex;
  end;

  { painters }

  TcxGridTableDataCellPainterClass = class of TcxGridTableDataCellPainter;

  TcxGridTableDataCellPainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxGridTableDataCellViewInfo;
  protected
    procedure DrawContent; override;
    procedure DrawFocusRect; virtual;
    procedure Paint; override;
    property ViewInfo: TcxGridTableDataCellViewInfo read GetViewInfo;
  end;

  TcxCustomGridRecordPainterClass = class of TcxCustomGridRecordPainter;

  TcxCustomGridRecordPainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxCustomGridRecordViewInfo;
  protected
    procedure AfterPaint; override;
    procedure BeforePaint; override;
    procedure DrawBackground; override;
    procedure DrawExpandButton; virtual;
    procedure DrawFocusRect; virtual;
    procedure Paint; override;
    property ViewInfo: TcxCustomGridRecordViewInfo read GetViewInfo;
  end;

  TcxCustomGridRecordsPainterClass = class of TcxCustomGridRecordsPainter;

  TcxCustomGridRecordsPainter = class
  private
    FCanvas: TcxCanvas;
    FViewInfo: TcxCustomGridRecordsViewInfo;
  protected
    //procedure BeforePaint; virtual;
    procedure Paint; virtual;
    property Canvas: TcxCanvas read FCanvas;
    property ViewInfo: TcxCustomGridRecordsViewInfo read FViewInfo;
  public
    constructor Create(ACanvas: TcxCanvas; AViewInfo: TcxCustomGridRecordsViewInfo); virtual;
    procedure MainPaint;
  end;

  TcxNavigatorSitePainter = class(TcxCustomGridCellPainter)
  protected
    function ExcludeFromClipRect: Boolean; override;
  end;

  TcxCustomGridTablePainter = class(TcxCustomGridPainter)
  private
    function GetController: TcxCustomGridTableController;
    function GetViewInfo: TcxCustomGridTableViewInfo;
  protected
    function CanOffset(AItemsOffset, DX, DY: Integer): Boolean; virtual;
    procedure DrawNavigator; virtual;
    procedure DrawRecords; virtual;
    procedure Offset(AItemsOffset: Integer); overload; virtual;
    procedure Offset(DX, DY: Integer); overload; virtual;
    procedure PaintBefore; override;
    procedure PaintContent; override;
  public
    procedure DoOffset(AItemsOffset, DX, DY: Integer);
    property Controller: TcxCustomGridTableController read GetController;
    property ViewInfo: TcxCustomGridTableViewInfo read GetViewInfo;
  end;

  { view data }

  TcxCustomGridRecordClass = class of TcxCustomGridRecord;

  TcxCustomGridRecord = class
  private
    //FData: Pointer;
    FEatKeyPress: Boolean;
    FIndex: Integer;
    FRecordInfo: TcxRowInfo;
    FViewData: TcxCustomGridTableViewData;
    FViewInfo: TcxCustomGridRecordViewInfo;
    function GetController: TcxCustomGridTableController;
    function GetDataController: TcxCustomDataController;
    function GetDragHighlighted: Boolean;
    function GetFocused: Boolean;
    function GetGridView: TcxCustomGridTableView;
    function GetIsEditing: Boolean;
    function GetIsNewItemRecord: Boolean;
    function GetIsValid: Boolean;
    function GetLevel: Integer;
    function GetPartVisible: Boolean;
    function GetRecordIndex: Integer;
    procedure SetExpanded(Value: Boolean);
    procedure SetFocused(Value: Boolean);
  protected
    procedure RefreshRecordInfo;

    procedure DoCollapse(ARecurse: Boolean); virtual; abstract;
    procedure DoExpand(ARecurse: Boolean); virtual; abstract;
    function GetDestroyingOnExpanding: Boolean; virtual;
    function GetExpandable: Boolean; virtual;
    function GetExpanded: Boolean; virtual;

    function GetDrawFocused: Boolean; virtual;
    function GetDrawSelected: Boolean; virtual;
    function GetHasCells: Boolean; virtual;
    function GetIsData: Boolean; virtual;
    function GetIsFirst: Boolean; virtual;
    function GetIsLast: Boolean; virtual;
    function GetIsParent: Boolean; virtual;
    function GetIsParentRecordLast(AIndex: Integer): Boolean;
    function GetParentRecord: TcxCustomGridRecord; virtual;
    function GetSelected: Boolean; virtual;
    function GetVisible: Boolean; virtual;
    procedure SetSelected(Value: Boolean); virtual;

    function GetDisplayText(Index: Integer): string; virtual;
    function GetValueCount: Integer; virtual;
    function GetValue(Index: Integer): Variant; virtual;

    function GetViewInfoClass: TcxCustomGridRecordViewInfoClass; virtual; abstract;

    property EatKeyPress: Boolean read FEatKeyPress write FEatKeyPress;
    property IsParent: Boolean read GetIsParent;
    property RecordInfo: TcxRowInfo read FRecordInfo;

    property Controller: TcxCustomGridTableController read GetController;
    property DataController: TcxCustomDataController read GetDataController;
    property DestroyingOnExpanding: Boolean read GetDestroyingOnExpanding;
  public
    constructor Create(AViewData: TcxCustomGridTableViewData; AIndex: Integer;
      ARecordInfo: TcxRowInfo); virtual;
    destructor Destroy; override;
    function CanFocus: Boolean; virtual;
    procedure Collapse(ARecurse: Boolean);
    procedure DoKeyPress(var Key: Char);
    procedure Expand(ARecurse: Boolean);
    function GetFirstFocusableChild: TcxCustomGridRecord; virtual;
    function GetLastFocusableChild(ARecursive: Boolean): TcxCustomGridRecord; virtual;
    procedure Invalidate(AItem: TcxCustomGridTableItem = nil); virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); dynamic;
    procedure KeyPress(var Key: Char); dynamic;
    procedure MakeVisible;

    //property Data: Pointer read FData write FData;
    property DragHighlighted: Boolean read GetDragHighlighted;
    property DrawFocused: Boolean read GetDrawFocused;
    property DrawSelected: Boolean read GetDrawSelected;
    property DisplayTexts[Index: Integer]: string read GetDisplayText;
    property Expandable: Boolean read GetExpandable;
    property Expanded: Boolean read GetExpanded write SetExpanded;
    property Focused: Boolean read GetFocused write SetFocused;
    property GridView: TcxCustomGridTableView read GetGridView;
    property HasCells: Boolean read GetHasCells;
    property Index: Integer read FIndex;
    property IsData: Boolean read GetIsData;
    property IsEditing: Boolean read GetIsEditing;
    property IsFirst: Boolean read GetIsFirst;
    property IsLast: Boolean read GetIsLast;
    property IsNewItemRecord: Boolean read GetIsNewItemRecord;
    property IsParentRecordLast[AIndex: Integer]: Boolean read GetIsParentRecordLast;
    property IsValid: Boolean read GetIsValid;
    property Level: Integer read GetLevel;
    property ParentRecord: TcxCustomGridRecord read GetParentRecord;
    property PartVisible: Boolean read GetPartVisible;
    property RecordIndex: Integer read GetRecordIndex;
    property Selected: Boolean read GetSelected write SetSelected;
    property ValueCount: Integer read GetValueCount;
    property Values[Index: Integer]: Variant read GetValue;
    property ViewData: TcxCustomGridTableViewData read FViewData;
    property ViewInfo: TcxCustomGridRecordViewInfo read FViewInfo;
    property Visible: Boolean read GetVisible;
  end;

  TcxCustomGridTableViewData = class(TcxCustomGridViewData)
  private
    FEditingRecord: TcxCustomGridRecord;
    FNewItemRecord: TcxCustomGridRecord;
    FRecords: TList;
    function GetController: TcxCustomGridTableController;
    function GetEditingRecord: TcxCustomGridRecord;
    function GetGridView: TcxCustomGridTableView;
    function GetInternalRecord(Index: Integer): TcxCustomGridRecord;
    function GetRecord(Index: Integer): TcxCustomGridRecord;
    function GetRecordCount: Integer;
    function GetViewInfo: TcxCustomGridTableViewInfo;
    function CreateRecord(AIndex: Integer): TcxCustomGridRecord;
  protected
    function GetRecordClass(ARecordInfo: TcxRowInfo): TcxCustomGridRecordClass; virtual; abstract;

    procedure AssignEditingRecord;

    procedure CreateNewItemRecord;
    procedure DestroyNewItemRecord;
    function GetNewItemRecordClass: TcxCustomGridRecordClass; virtual; abstract;
    procedure RecreateNewItemRecord;

    property Controller: TcxCustomGridTableController read GetController;
    property InternalRecords[Index: Integer]: TcxCustomGridRecord read GetInternalRecord;
    property ViewInfo: TcxCustomGridTableViewInfo read GetViewInfo;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    destructor Destroy; override;
    procedure Collapse(ARecurse: Boolean);
    procedure DestroyRecords;
    procedure Expand(ARecurse: Boolean);
    function GetRecordByIndex(AIndex: Integer): TcxCustomGridRecord;
    function GetRecordByRecordIndex(ARecordIndex: Integer): TcxCustomGridRecord;
    function GetRecordIndexByRecord(ARecord: TcxCustomGridRecord): Integer;
    function IsRecordIndexValid(AIndex: Integer): Boolean;
    procedure Refresh(ARecordCount: Integer); virtual;
    procedure RefreshRecords;

    procedure CheckNewItemRecord;
    function HasNewItemRecord: Boolean; virtual;

    property EditingRecord: TcxCustomGridRecord read FEditingRecord;
    property GridView: TcxCustomGridTableView read GetGridView;
    property NewItemRecord: TcxCustomGridRecord read FNewItemRecord;
    property RecordCount: Integer read GetRecordCount;
    property Records[Index: Integer]: TcxCustomGridRecord read GetRecord;
  end;

  { view infos }

  TcxGridTableCellViewInfo = class(TcxCustomGridViewCellViewInfo)
  private
    FRecordViewInfo: TcxCustomGridRecordViewInfo;
    FSelected: Boolean;
    FSelectedCalculated: Boolean;
    function GetCacheItem: TcxCustomGridTableViewInfoCacheItem;
    function GetController: TcxCustomGridTableController;
    function GetGridView: TcxCustomGridTableView;
    function GetGridRecord: TcxCustomGridRecord;
    function GetSelected: Boolean;
  protected
    function CalculateSelected: Boolean; virtual;
    function GetAlwaysSelected: Boolean; virtual;
    function GetCanvas: TcxCanvas; override;
    function GetGridViewInfo: TcxCustomGridTableViewInfo;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetTransparent: Boolean; override;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); override;

    property AlwaysSelected: Boolean read GetAlwaysSelected;
    property CacheItem: TcxCustomGridTableViewInfoCacheItem read GetCacheItem;
    property Controller: TcxCustomGridTableController read GetController;
    property GridView: TcxCustomGridTableView read GetGridView;
    property GridViewInfo: TcxCustomGridTableViewInfo read GetGridViewInfo;
  public
    constructor Create(ARecordViewInfo: TcxCustomGridRecordViewInfo); virtual;
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); override;
    function CanDrawSelected: Boolean; virtual;
    function MouseDown(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; override;
    property GridRecord: TcxCustomGridRecord read GetGridRecord;
    property RecordViewInfo: TcxCustomGridRecordViewInfo read FRecordViewInfo;
    property Selected: Boolean read GetSelected;
  end;

  TcxGridTableDataCellViewInfo = class(TcxGridTableCellViewInfo)
  private
    FEditViewData: TcxCustomEditViewData;
    FEditViewInfo: TcxCustomEditViewInfo;
    FIsLocalCopyOfEditViewData: Boolean;
    FItem: TcxCustomGridTableItem;
    FProperties: TcxCustomEditProperties;
    FStyle: TcxEditStyle;
    FWasFocusedBeforeClick: Boolean;
    function GetEditing: Boolean;
    function GetFocused: Boolean;
    function GetMousePos: TPoint;
    function GetProperties: TcxCustomEditProperties;
    function GetShowButtons: Boolean;
  protected
    procedure AfterCustomDraw(ACanvas: TcxCanvas); override;
    procedure BeforeCustomDraw(ACanvas: TcxCanvas); override;
    procedure CalculateEditViewInfo(AEditViewInfo: TcxCustomEditViewInfo;
      const AMousePos: TPoint); virtual;
    function CalculateHeight: Integer; override;
    function CalculateSelected: Boolean; override;
    function CanShowHint: Boolean; override;
    procedure CheckEditHotTrack(const AMousePos: TPoint);
    function CustomDraw(ACanvas: TcxCanvas): Boolean; override;
    procedure DoCalculateParams; override;
    procedure EditHotTrackChanged;
    function GetActivateEditOnMouseDown: Boolean; virtual;
    function GetAutoHeight: Boolean; virtual;
    function GetBoundsForHint: TRect; override;
    function GetDisplayValue: TcxEditValue; virtual;
    function GetEditBounds: TRect; virtual;
    function GetEditViewDataBounds: TRect; virtual;
    procedure GetEditViewDataContentOffsets(var R: TRect); virtual;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetHotTrack: Boolean; override;
    function GetMaxLineCount: Integer; virtual;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetShowEndEllipsis: Boolean; override;
    function GetText: string; override;
    function GetValue: Variant; virtual;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function HasCustomDraw: Boolean; override;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); override;
    procedure InitTextSelection; virtual;
    function InvalidateOnStateChange: Boolean; override;
    function IsTextSelected: Boolean; virtual;
    procedure MouseLeave; override;
    function NeedShowHint(const AMousePos: TPoint; out AHintText: TCaption;
      out AIsHintMultiLine: Boolean; out ATextRect: TRect): Boolean; override;
    procedure Offset(DX, DY: Integer); override;
    procedure RestoreParams(const AParams: TcxViewParams); override;
    procedure SaveParams(out AParams: TcxViewParams); override;
    procedure StateChanged; override;

    procedure InitStyle; virtual;

    function CreateEditViewInfo: TcxCustomEditViewInfo;

    procedure CreateEditViewData;
    procedure DestroyEditViewData;
    property EditViewData: TcxCustomEditViewData read FEditViewData;

    procedure UpdateEdit;

    property ActivateEditOnMouseDown: Boolean read GetActivateEditOnMouseDown;
    property AutoHeight: Boolean read GetAutoHeight;
    property EditBounds: TRect read GetEditBounds;
    property EditViewDataBounds: TRect read GetEditViewDataBounds;
    property MaxLineCount: Integer read GetMaxLineCount;
    property MousePos: TPoint read GetMousePos;
    property ShowButtons: Boolean read GetShowButtons;
    property WasFocusedBeforeClick: Boolean read FWasFocusedBeforeClick;
  public
    constructor Create(ARecordViewInfo: TcxCustomGridRecordViewInfo;
      AItem: TcxCustomGridTableItem); reintroduce; virtual;
    destructor Destroy; override;
    procedure BeforeRecalculation; override;
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); override;
    function CanDrawSelected: Boolean; override;
    procedure Invalidate(ARecalculate: Boolean); reintroduce; virtual;
    function MouseDown(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; override;
    function MouseMove(AHitTest: TcxCustomGridHitTest; AShift: TShiftState): Boolean; override;
    function MouseUp(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; override;

    property DisplayValue: TcxEditValue read GetDisplayValue;
    //property Edit: TcxCustomEdit read GetEdit;
    property Editing: Boolean read GetEditing;
    property EditViewInfo: TcxCustomEditViewInfo read FEditViewInfo;
    property Focused: Boolean read GetFocused;
    property Item: TcxCustomGridTableItem read FItem;
    property Properties: TcxCustomEditProperties read GetProperties;
    property Style: TcxEditStyle read FStyle;
    property Value: Variant read GetValue;
  end;

  TcxCustomGridRecordViewInfo = class(TcxCustomGridViewCellViewInfo)
  private
    FExpandButtonBounds: TRect;
    FExpanded: Boolean;
    FExpandedCalculated: Boolean;
    FIsRecordViewInfoAssigned: Boolean;
    FRecordsViewInfo: TcxCustomGridRecordsViewInfo;
    FSelected: Boolean;
    FSelectedCalculated: Boolean;
    function GetCacheItem: TcxCustomGridTableViewInfoCacheItem;
    function GetExpanded: Boolean;
    function GetFocused: Boolean;
    function GetGridView: TcxCustomGridTableView;
    function GetGridViewInfo: TcxCustomGridTableViewInfo;
    function GetIndex: Integer;
    function GetSelected: Boolean;
  protected
    FRecord: TcxCustomGridRecord;
    procedure CalculateExpandButtonBounds(var ABounds: TRect); virtual;
    function CalculateSelected: Boolean; virtual;
    procedure ControlFocusChanged; virtual;
    function GetAutoHeight: Boolean; virtual;
    function GetBackgroundBitmap: TBitmap; override;
    function GetBackgroundBitmapBounds: TRect; virtual;
    function GetCanvas: TcxCanvas; override;
    function GetCellTransparent(ACell: TcxGridTableCellViewInfo): Boolean; virtual;
    function GetContentBounds: TRect; virtual;
    function GetExpandButtonAreaBounds: TRect; virtual; abstract;
    function GetFocusRectBounds: TRect; virtual;
    function GetHeight: Integer; override;
    function GetHideFocusRect: Boolean; virtual;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetVisible: Boolean; override;
    function HasFocusRect: Boolean; virtual;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); override;
    function IsClickHitTest(AHitTest: TcxCustomGridHitTest): Boolean; virtual;
    function IsDetailVisible(ADetail: TcxCustomGridView): Boolean; virtual;
    procedure Offset(DX, DY: Integer); override;
    procedure VisibilityChanged(AVisible: Boolean); virtual;

    property AutoHeight: Boolean read GetAutoHeight;
    property BackgroundBitmapBounds: TRect read GetBackgroundBitmapBounds;
    property CacheItem: TcxCustomGridTableViewInfoCacheItem read GetCacheItem;
    property ExpandButtonAreaBounds: TRect read GetExpandButtonAreaBounds;
    property Expanded: Boolean read GetExpanded;
  public
    constructor Create(ARecordsViewInfo: TcxCustomGridRecordsViewInfo;
      ARecord: TcxCustomGridRecord); virtual;
    destructor Destroy; override;
    procedure BeforeRecalculation; override;
    function Click(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; reintroduce; virtual;
    function GetBoundsForInvalidate(AItem: TcxCustomGridTableItem): TRect; virtual;
    function GetBoundsForItem(AItem: TcxCustomGridTableItem): TRect; virtual;
    function GetCellViewInfoByItem(AItem: TcxCustomGridTableItem): TcxGridTableDataCellViewInfo; virtual;
    {procedure GetDataCellViewParams(AItem: TcxCustomGridTableItem;
      ACellViewInfo: TcxGridTableCellViewInfo; var AParams: TcxViewParams); virtual;}
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
    procedure MainCalculate(ALeftBound, ATopBound: Integer); virtual;
    function MouseDown(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; override;
    procedure Recalculate;

    property ContentBounds: TRect read GetContentBounds;
    property ExpandButtonBounds: TRect read FExpandButtonBounds;
    property Focused: Boolean read GetFocused;
    property FocusRectBounds: TRect read GetFocusRectBounds;
    property GridView: TcxCustomGridTableView read GetGridView;
    property GridRecord: TcxCustomGridRecord read FRecord;
    property GridViewInfo: TcxCustomGridTableViewInfo read GetGridViewInfo;
    property Index: Integer read GetIndex;
    property HideFocusRect: Boolean read GetHideFocusRect;
    property RecordsViewInfo: TcxCustomGridRecordsViewInfo read FRecordsViewInfo;
    property Selected: Boolean read GetSelected;
  end;

  TcxCustomGridRecordsViewInfoClass = class of TcxCustomGridRecordsViewInfo;

  TcxCustomGridRecordsViewInfo = class
  private
    FBackgroundBitmap: TBitmap;
    FBounds: TRect;
    FGridViewInfo: TcxCustomGridTableViewInfo;
    FIncSearchingCellViewInfo: TcxGridTableDataCellViewInfo;
    FIsIncSearchingCellViewInfoCalculated: Boolean;
    FItems: TList;
    FItemsOffset: Integer;

    function GetCanvas: TcxCanvas;
    function GetController: TcxCustomGridTableController;
    function GetCount: Integer;
    function GetFirstRecordIndex: Integer;
    function GetGridView: TcxCustomGridTableView;
    function GetIncSearchingCellViewInfo: TcxGridTableDataCellViewInfo;
    function GetItem(Index: Integer): TcxCustomGridRecordViewInfo;
    function GetMaxCount: Integer;
    function GetTopRecordIndex: Integer;
    function GetViewData: TcxCustomGridTableViewData;

    procedure CreateItems;
    procedure DestroyItems;
    function CreateRecordViewInfo(AIndex: Integer): TcxCustomGridRecordViewInfo;
  protected
    FVisibleCount: Integer;
    procedure AfterCalculate; virtual;
    procedure BeforeCalculate; virtual;
    procedure BeforeItemRecalculation; virtual;
    procedure BeforeOffset; virtual;
    procedure Calculate; virtual;
    function CalculateBounds: TRect; virtual;
    function CalculateIncSearchingCellViewInfo: TcxGridTableDataCellViewInfo; virtual;
    procedure CalculateVisibleCount; virtual;
    procedure CreateEditViewDatas;
    procedure DestroyEditViewDatas;
    function GetAutoDataRecordHeight: Boolean; virtual;
    function GetAutoRecordHeight: Boolean; virtual;
    function GetBackgroundBitmap: TBitmap; virtual;
    function GetItemLeftBound(AIndex: Integer): Integer; virtual; abstract;  {2}
    function GetItemsOffset(AItemCountDelta: Integer): Integer; virtual; abstract;  {2}
    function GetItemTopBound(AIndex: Integer): Integer; virtual; abstract;   {2}
    function GetRecordIndex(AViewInfoIndex: Integer): Integer;
    function GetViewInfoIndex(ARecordIndex: Integer): Integer;
    procedure OffsetItem(AIndex, AOffset: Integer); virtual; abstract;  {2}

    procedure ControlFocusChanged; virtual;
    procedure VisibilityChanged(AVisible: Boolean); virtual;

    function GetPainterClass: TcxCustomGridRecordsPainterClass; virtual;

    property Canvas: TcxCanvas read GetCanvas;
    property Controller: TcxCustomGridTableController read GetController;
    property FirstRecordIndex: Integer read GetFirstRecordIndex;
    property GridViewInfo: TcxCustomGridTableViewInfo read FGridViewInfo;
    property IncSearchingCellViewInfo: TcxGridTableDataCellViewInfo read GetIncSearchingCellViewInfo;
    property MaxCount: Integer read GetMaxCount;
    property TopRecordIndex: Integer read GetTopRecordIndex;
    property ViewData: TcxCustomGridTableViewData read GetViewData;
  public
    constructor Create(AGridViewInfo: TcxCustomGridTableViewInfo); virtual;
    destructor Destroy; override;
    function CanOffset(AItemCountDelta: Integer): Boolean; virtual;
    function GetCellHeight(ACellContentHeight: Integer): Integer; virtual;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; virtual;
    function GetRealItem(ARecord: TcxCustomGridRecord; ARecordIndex: Integer): TcxCustomGridRecordViewInfo; virtual;
    procedure MainCalculate; virtual;
    procedure Offset(AItemCountDelta: Integer); overload; virtual;
    procedure Offset(DX, DY: Integer); overload; virtual;
    procedure Paint;

    property AutoDataRecordHeight: Boolean read GetAutoDataRecordHeight;
    property AutoRecordHeight: Boolean read GetAutoRecordHeight;
    property BackgroundBitmap: TBitmap read FBackgroundBitmap write FBackgroundBitmap;
    property Bounds: TRect read FBounds;
    property Count: Integer read GetCount;
    property GridView: TcxCustomGridTableView read GetGridView;
    property Items[Index: Integer]: TcxCustomGridRecordViewInfo read GetItem; default;
    property ItemsOffset: Integer read FItemsOffset;
    property VisibleCount: Integer read FVisibleCount;
  end;

  TcxNavigatorSiteViewInfoClass = class of TcxNavigatorSiteViewInfo;

  TcxNavigatorSiteViewInfo = class(TcxCustomGridViewCellViewInfo)
  private
    function GetGridViewInfo: TcxCustomGridTableViewInfo;
    function GetNavigatorViewInfo: TcxNavigatorViewInfo;
  protected
    function CalculateWidth: Integer; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetHotTrack: Boolean; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetVisible: Boolean; override;
    procedure MouseLeave; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function GetWidth: Integer; override;
  public
    function MouseDown(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; override;
    function MouseMove(AHitTest: TcxCustomGridHitTest; AShift: TShiftState): Boolean; override;
    function MouseUp(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; override;
    property GridViewInfo: TcxCustomGridTableViewInfo read GetGridViewInfo;
    property NavigatorViewInfo: TcxNavigatorViewInfo read GetNavigatorViewInfo;
  end;

  TcxCustomGridTableViewInfo = class(TcxCustomGridViewInfo, IcxNavigatorOwner)
  protected
    FAllowCheckCoordinates: Boolean;
    FCalculateDown: Boolean;
    FExpandButtonIndent: Integer;
    FFirstRecordIndex: Integer;
    FLevelIndent: Integer;
    FNavigatorSize: TPoint;
    FNavigatorSiteViewInfo: TcxNavigatorSiteViewInfo;
    FNavigatorViewInfo: TcxNavigatorViewInfo;
    FRecordsViewInfo: TcxCustomGridRecordsViewInfo;

    function GetController: TcxCustomGridTableController;
    function GetExpandButtonSize: Integer;
    function GetFirstRecordIndex: Integer;
    function GetGridView: TcxCustomGridTableView;
    function GetScrollableAreaWidth: Integer;
    function GetViewData: TcxCustomGridTableViewData;
    function GetVisibleRecordCount: Integer;
  protected
    // IcxNavigatorOwner
    procedure NavigatorChanged(AChangeType: TcxNavigatorChangeType);
    function GetNavigatorBounds: TRect; virtual;
    function GetNavigatorButtons: TcxCustomNavigatorButtons;
    function GetNavigatorCanvas: TCanvas;
    function GetNavigatorControl: TWinControl;
    function GetNavigatorFocused: Boolean;
    function GetNavigatorLookAndFeel: TcxLookAndFeel;
    function GetNavigatorOwner: TComponent;
    function GetNavigatorShowHint: Boolean;
    function GetNavigatorTabStop: Boolean;
    procedure NavigatorStateChanged;
    procedure RefreshNavigator;

    procedure CreateViewInfos; override;
    procedure DestroyViewInfos(AIsRecreating: Boolean); override;

    procedure AfterCalculating; override;
    procedure BeforeCalculating; override;
    procedure BeforeOffset; virtual;
    procedure Calculate; override;
    function CalculateVisibleEqualHeightRecordCount: Integer; virtual;
    procedure ControlFocusChanged; override;
    function GetDefaultGridModeBufferCount: Integer; virtual;
    procedure GetHScrollBarBounds(var ABounds: TRect); override;
    function GetIsInternalUse: Boolean; override;
    function GetNavigatorOffset: Integer; virtual;
    function GetNavigatorSiteBounds: TRect; virtual;
    function GetNavigatorSiteViewInfoClass: TcxNavigatorSiteViewInfoClass; virtual;
    function GetNavigatorViewInfoClass: TcxNavigatorViewInfoClass; virtual;
    function GetRecordsViewInfoClass: TcxCustomGridRecordsViewInfoClass; virtual; abstract;
    function GetScrollableAreaBounds: TRect; virtual;
    function GetScrollableAreaBoundsForEdit: TRect; virtual;
    function GetScrollableAreaBoundsHorz: TRect; virtual;
    function GetScrollableAreaBoundsVert: TRect; virtual;
    function FirstRecordIndexAssigned: Boolean;
    procedure Offset(ARecordCountDelta: Integer); overload; virtual;
    procedure Offset(DX, DY: Integer); overload; virtual;
    procedure VisibilityChanged(AVisible: Boolean); override;

    procedure CalculateExpandButtonParams; virtual;
    function CanCheckCoordinates: Boolean; virtual;
    property AllowCheckCoordinates: Boolean read FAllowCheckCoordinates
      write FAllowCheckCoordinates;

    property Controller: TcxCustomGridTableController read GetController;
    property ViewData: TcxCustomGridTableViewData read GetViewData;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    function CanOffset(ARecordCountDelta, DX, DY: Integer): Boolean; virtual;
    function CanOffsetView(ARecordCountDelta: Integer): Boolean; virtual;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
    procedure DoOffset(ARecordCountDelta, DX, DY: Integer); virtual;

    // for extended lookup edit
    function GetNearestPopupHeight(AHeight: Integer; AAdditionalRecord: Boolean = False): Integer; virtual;
    function GetPopupHeight(ADropDownRecordCount: Integer): Integer; virtual;

    property CalculateDown: Boolean read FCalculateDown write FCalculateDown;
    property ExpandButtonIndent: Integer read FExpandButtonIndent write FExpandButtonIndent;
    property ExpandButtonSize: Integer read GetExpandButtonSize;
    property FirstRecordIndex: Integer read GetFirstRecordIndex write FFirstRecordIndex;
    property GridView: TcxCustomGridTableView read GetGridView;
    property LevelIndent: Integer read FLevelIndent write FLevelIndent;
    property NavigatorBounds: TRect read GetNavigatorBounds;
    property NavigatorOffset: Integer read GetNavigatorOffset;
    property NavigatorSize: TPoint read FNavigatorSize;
    property NavigatorSiteViewInfo: TcxNavigatorSiteViewInfo read FNavigatorSiteViewInfo;
    property NavigatorViewInfo: TcxNavigatorViewInfo read FNavigatorViewInfo;
    property RecordsViewInfo: TcxCustomGridRecordsViewInfo read FRecordsViewInfo;
    property ScrollableAreaBounds: TRect read GetScrollableAreaBounds;
    property ScrollableAreaBoundsForEdit: TRect read GetScrollableAreaBoundsForEdit;
    property ScrollableAreaBoundsHorz: TRect read GetScrollableAreaBoundsHorz;
    property ScrollableAreaBoundsVert: TRect read GetScrollableAreaBoundsVert;
    property ScrollableAreaWidth: Integer read GetScrollableAreaWidth;
    property VisibleRecordCount: Integer read GetVisibleRecordCount;
  end;

  // cache

  TcxCustomGridTableViewInfoCacheItem = class(TcxCustomGridViewInfoCacheItem)
  private
    FHeight: Integer;
    FIsHeightAssigned: Boolean;
    function GetGridRecord: TcxCustomGridRecord;
    procedure SetHeight(Value: Integer);
  protected
    property GridRecord: TcxCustomGridRecord read GetGridRecord;
  public
    procedure UnassignValues(AKeepMaster: Boolean); override;
    property Height: Integer read FHeight write SetHeight;
    property IsHeightAssigned: Boolean read FIsHeightAssigned write FIsHeightAssigned;
  end;

  TcxCustomGridTableViewInfoCache = class(TcxCustomGridViewInfoCache)
  private
    function GetViewData: TcxCustomGridTableViewData;
  protected
    function GetItemClass: TcxCustomGridViewInfoCacheItemClass; override;
    property ViewData: TcxCustomGridTableViewData read GetViewData;
  end;

  { view }

  // custom item

  TcxCustomGridTableItemCustomOptions = class(TPersistent)
  private
    FItem: TcxCustomGridTableItem;
    function GetGridView: TcxCustomGridTableView;
  protected
    procedure Changed; virtual;
    property GridView: TcxCustomGridTableView read GetGridView;
    property Item: TcxCustomGridTableItem read FItem;
  public
    constructor Create(AItem: TcxCustomGridTableItem); virtual;
    procedure Assign(Source: TPersistent); override;
  end;

  TcxGridItemShowEditButtons = (isebDefault, isebNever, isebAlways);

  TcxCustomGridTableItemOptionsClass = class of TcxCustomGridTableItemOptions;

  TcxCustomGridTableItemOptions = class(TcxCustomGridTableItemCustomOptions)
  private
    FEditing: Boolean;
    FFiltering: Boolean;
    FFocusing: Boolean;
    FGrouping: Boolean;
    FIncSearch: Boolean;
    FMoving: Boolean;
    FShowEditButtons: TcxGridItemShowEditButtons;
    FSorting: Boolean;
    procedure SetEditing(Value: Boolean);
    procedure SetFiltering(Value: Boolean);
    procedure SetFocusing(Value: Boolean);
    procedure SetIncSearch(Value: Boolean);
    procedure SetShowEditButtons(Value: TcxGridItemShowEditButtons);
  protected
    property Grouping: Boolean read FGrouping write FGrouping default True;
    property Moving: Boolean read FMoving write FMoving default True;
    property Sorting: Boolean read FSorting write FSorting default True;
  public
    constructor Create(AItem: TcxCustomGridTableItem); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Editing: Boolean read FEditing write SetEditing default True;
    property Filtering: Boolean read FFiltering write SetFiltering default True;
    property Focusing: Boolean read FFocusing write SetFocusing default True;
    property IncSearch: Boolean read FIncSearch write SetIncSearch default True;
    property ShowEditButtons: TcxGridItemShowEditButtons read FShowEditButtons
      write SetShowEditButtons default isebDefault;
  end;

  TcxGridGetCellStyleEvent = procedure(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
    AItem: TcxCustomGridTableItem; {$IFDEF BCB}var{$ELSE}out{$ENDIF} AStyle: TcxStyle) of object;

  TcxGridGetRecordStyleEvent = procedure(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
    {$IFDEF BCB}var{$ELSE}out{$ENDIF} AStyle: TcxStyle) of object;

  TcxCustomGridTableItemStylesClass = class of TcxCustomGridTableItemStyles;

  TcxCustomGridTableItemStyles = class(TcxCustomGridStyles)
  private
    FOnGetContentStyle: TcxGridGetCellStyleEvent;
    function GetGridViewValue: TcxCustomGridTableView;
    function GetItem: TcxCustomGridTableItem;
  protected
    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;
    function GetGridView: TcxCustomGridView; override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure GetContentParams(ARecord: TcxCustomGridRecord; out AParams: TcxViewParams); virtual;
    property GridView: TcxCustomGridTableView read GetGridViewValue;
    property Item: TcxCustomGridTableItem read GetItem;
  published
    property Content: TcxStyle index isContent read GetValue write SetValue;
    property OnGetContentStyle: TcxGridGetCellStyleEvent read FOnGetContentStyle write FOnGetContentStyle;
  end;

  TcxGridSortOrder = TcxDataSortOrder;
  TcxGridTableItemChange = (ticLayout, ticSize);

  TcxGridTableDataCellCustomDrawEvent = procedure(Sender: TcxCustomGridTableView;
    ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean) of object;

  TcxGridGetFilterDisplayTextEvent = procedure(Sender: TcxCustomGridTableItem;
    const AValue: Variant; var ADisplayText: string) of object;
  TcxGridGetFilterValuesEvent = procedure(Sender: TcxCustomGridTableItem;
    AValueList: TcxDataFilterValueList) of object;
  TcxGridGetDisplayTextEvent = procedure(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string) of object;
  TcxGridGetPropertiesEvent = procedure(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties) of object;

  TcxCustomGridTableItemClass = class of TcxCustomGridTableItem;

  TcxCustomGridTableItem = class(TcxComponent, IcxEditRepositoryItemListener, IcxStoredObject)
  private
    FCaption: string;
    FCells: TList;
    FCellStyle: TcxEditStyle;
    FCellStyleUseCounter: Integer;
    FDataBinding: TcxGridItemDataBinding;
    FEditData: TcxCustomEditData;
    FEditViewData: TcxCustomEditViewData;
    FGridView: TcxCustomGridTableView;
    FHeaderAlignmentHorz: TAlignment;
    FHeaderAlignmentVert: TcxAlignmentVert;
    //FHidden: Boolean;
    FID: Integer;
    FIgnoreLoadingStatus: Boolean;
    FIndex: Integer;
    FIsCaptionAssigned: Boolean;
    FIsHeaderAlignmentHorzAssigned: Boolean;
    FIsHeaderAlignmentVertAssigned: Boolean;
    FIsWidthAssigned: Boolean;
    FLastUsedDefaultRepositoryItem: TcxEditRepositoryItem;
    FMinWidth: Integer;
    FOptions: TcxCustomGridTableItemOptions;
    FProperties: TcxCustomEditProperties;
    FPropertiesClass: TcxCustomEditPropertiesClass;
    FPropertiesValue: TcxCustomEditProperties;
    FRepositoryItem: TcxEditRepositoryItem;
    FStyles: TcxCustomGridTableItemStyles;
    FVisible: Boolean;
    FVisibleIndex: Integer;
    FWasVisibleBeforeGrouping: Boolean;
    FWidth: Integer;

    FOnCustomDrawCell: TcxGridTableDataCellCustomDrawEvent;
    FOnGetDisplayText: TcxGridGetDisplayTextEvent;
    FOnGetFilterDisplayText: TcxGridGetFilterDisplayTextEvent;
    FOnGetFilterValues: TcxGridGetFilterValuesEvent;
    FOnGetProperties: TcxGridGetPropertiesEvent;
    FSubClassEvents: TNotifyEvent;

    function GetActualMinWidth: Integer;
    function GetCaption: string;
    function GetCell(Index: Integer): TcxGridTableDataCellViewInfo;
    function GetCellCount: Integer;
    function GetController: TcxCustomGridTableController;
    function GetDataController: TcxCustomDataController;
    function GetEditing: Boolean;
    function GetEditingProperties: TcxCustomEditProperties;
    function GetFilterCaption: string;
    function GetFiltered: Boolean;
    function GetFocused: Boolean;
    function GetGroupIndex: Integer;
    function GetHeaderAlignmentHorz: TAlignment;
    function GetHeaderAlignmentVert: TcxAlignmentVert;
    //function GetHidden: Boolean;
    function GetIsLoading: Boolean;
    function GetIncSearching: Boolean;
    function GetIsDestroying: Boolean;
    function GetIsFirst: Boolean;
    function GetIsLast: Boolean;
    function GetIsUpdating: Boolean;
    function GetMinWidth: Integer;
    function GetPropertiesClassName: string;
    function GetSortIndex: Integer;
    function GetSortOrder: TcxGridSortOrder;
    function GetViewData: TcxCustomGridTableViewData;
    function GetWidth: Integer;
    procedure SetCaption(const Value: string);
    procedure SetDataBinding(Value: TcxGridItemDataBinding);
    procedure SetEditing(Value: Boolean);
    procedure SetFiltered(Value: Boolean);
    procedure SetFocused(Value: Boolean);
    procedure SetGroupIndex(Value: Integer);
    procedure SetHeaderAlignmentHorz(Value: TAlignment);
    procedure SetHeaderAlignmentVert(Value: TcxAlignmentVert);
    //procedure SetHidden(Value: Boolean);
    procedure SetIndex(Value: Integer);
    procedure SetMinWidth(Value: Integer);
    procedure SetOnGetProperties(Value: TcxGridGetPropertiesEvent);
    procedure SetOptions(Value: TcxCustomGridTableItemOptions);
    procedure SetProperties(Value: TcxCustomEditProperties);
    procedure SetPropertiesClass(Value: TcxCustomEditPropertiesClass);
    procedure SetPropertiesClassName(const Value: string);
    procedure SetRepositoryItem(Value: TcxEditRepositoryItem);
    procedure SetSortIndex(Value: Integer);
    procedure SetSortOrder(Value: TcxGridSortOrder);
    procedure SetStyles(Value: TcxCustomGridTableItemStyles);
    procedure SetVisible(Value: Boolean);
    procedure SetVisibleIndex(Value: Integer);
    procedure SetWidth(Value: Integer);

    procedure ReadIsCaptionAssigned(Reader: TReader);
    procedure WriteIsCaptionAssigned(Writer: TWriter);

    function IsCaptionStored: Boolean;
    //function IsHiddenStored: Boolean;
    function IsWidthStored: Boolean;

    function GetDataBindingClass: TcxGridItemDataBindingClass;

    procedure CreateProperties;
    procedure DestroyProperties;
    procedure RecreateProperties;
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure SetParentComponent(AParent: TComponent); override;

    // IcxEditRepositoryItemListener
    procedure ItemRemoved(Sender: TcxEditRepositoryItem);
    procedure PropertiesChanged(Sender: TcxEditRepositoryItem); overload; virtual;
    // IcxStoredObject
    function GetObjectName: string; virtual;
    function IcxStoredObject.GetProperties = GetStoredProperties;
    function GetStoredProperties(AProperties: TStrings): Boolean; virtual;
    procedure GetPropertyValue(const AName: string; var AValue: Variant); virtual;
    procedure SetPropertyValue(const AName: string; const AValue: Variant); virtual;

    procedure CreateDataBinding; virtual;
    procedure DestroyDataBinding; virtual;

    procedure CreateSubClasses; virtual;
    procedure DestroySubClasses; virtual;

    function IsHeaderAlignmentHorzStored: Boolean;
    function IsHeaderAlignmentVertStored: Boolean;

    function CanAutoHeight: Boolean; virtual;
    function CanEdit: Boolean; virtual;
    function CanFilter(ACheckGridViewOptions: Boolean): Boolean; virtual;
    function CanFocus: Boolean; virtual;
    function CanGroup: Boolean; virtual;
    function CanHide: Boolean; virtual;
    function CanHorzSize: Boolean; virtual;
    function CanIncSearch: Boolean; virtual;
    function CanInitEditing: Boolean; virtual;
    function CanMove: Boolean; virtual;
    function CanScroll: Boolean; virtual;
    function CanSort: Boolean; virtual;
    procedure CaptionChanged; virtual;
    procedure Changed(AChange: TcxGridTableItemChange); virtual;
    procedure CheckWidthValue(var Value: Integer);
    procedure DataChanged; virtual;
    procedure ForceWidth(Value: Integer); virtual;
    function GetActuallyVisible: Boolean; virtual;
    function GetBestFitWidth: Integer; virtual;
    function GetEditPartVisible: Boolean; virtual;
    function GetEditValue: Variant; virtual;
    function GetFilterable: Boolean; virtual;
    procedure GetFilterDisplayText(const AValue: Variant; var ADisplayText: string); virtual;
    function GetFixed: Boolean; virtual;
    function GetFocusedCellViewInfo: TcxGridTableDataCellViewInfo; virtual;
    function GetPropertiesValue: TcxCustomEditProperties;
    function GetVisible: Boolean; virtual;
    function GetVisibleIndex: Integer;
    function HasCustomDrawCell: Boolean;
    //procedure HiddenChanged; dynamic;
    procedure InitProperties(AProperties: TcxCustomEditProperties); virtual;
    function IsVisibleStored: Boolean; virtual;
    procedure PropertiesChanged; overload; virtual;
    procedure PropertiesChanged(Sender: TObject); overload; virtual;
    procedure PropertiesValueChanged;
    procedure RecalculateDefaultWidth;
    procedure SetEditValue(const Value: Variant); virtual;
    procedure SetGridView(Value: TcxCustomGridTableView); virtual;
    function ShowButtons(AFocused: Boolean): Boolean; virtual;
    function ShowOnUngrouping: Boolean; virtual;
    function UseOwnProperties: Boolean;
    procedure ValueTypeClassChanged; virtual;

    function GetOptionsClass: TcxCustomGridTableItemOptionsClass; virtual;
    function GetStylesClass: TcxCustomGridTableItemStylesClass; virtual;

    function DefaultCaption: string; virtual;
    function DefaultHeaderAlignmentHorz: TAlignment;
    function DefaultHeaderAlignmentVert: TcxAlignmentVert;
    function DefaultRepositoryItem: TcxEditRepositoryItem;
    function DefaultWidth: Integer; virtual;

    function GetCellStyle: TcxEditStyle;
    procedure InitStyle(AStyle: TcxCustomEditStyle; AParams: TcxViewParams; AFocused: Boolean); virtual;
    procedure ReleaseCellStyle;

    procedure AddCell(ACell: TcxGridTableDataCellViewInfo);
    procedure RemoveCell(ACell: TcxGridTableDataCellViewInfo);
    property CellCount: Integer read GetCellCount;
    property Cells[Index: Integer]: TcxGridTableDataCellViewInfo read GetCell;

    function CreateEditViewData(AProperties: TcxCustomEditProperties): TcxCustomEditViewData;
    procedure DestroyEditViewData(var AEditViewData: TcxCustomEditViewData);
    procedure DoCreateEditViewData;
    procedure DoDestroyEditViewData;
    function GetEditViewData(AProperties: TcxCustomEditProperties;
      out AIsLocalCopy: Boolean): TcxCustomEditViewData;
    procedure ReleaseEditViewData(var AEditViewData: TcxCustomEditViewData; AIsLocalCopy: Boolean);
    property EditViewData: TcxCustomEditViewData read FEditViewData;

    procedure DoCustomDrawCell(ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean); virtual;
    procedure DoGetDisplayText(ARecord: TcxCustomGridRecord; var AText: string); virtual;
    procedure DoGetFilterValues(AValueList: TcxDataFilterValueList); virtual;
    function DoGetProperties(ARecord: TcxCustomGridRecord): TcxCustomEditProperties; virtual;

    property IsDestroying: Boolean read GetIsDestroying;
    property IsLoading: Boolean read GetIsLoading;
    property IsUpdating: Boolean read GetIsUpdating;

    property ActualMinWidth: Integer read GetActualMinWidth;
    property Controller: TcxCustomGridTableController read GetController;
    property DataController: TcxCustomDataController read GetDataController;
    property EditingProperties: TcxCustomEditProperties read GetEditingProperties;
    property EditPartVisible: Boolean read GetEditPartVisible;
    property Filterable: Boolean read GetFilterable;
    property FilterCaption: string read GetFilterCaption;
    property Filtered: Boolean read GetFiltered write SetFiltered;
    property Fixed: Boolean read GetFixed;
    property GroupIndex: Integer read GetGroupIndex write SetGroupIndex default -1;
    property HeaderAlignmentHorz: TAlignment read GetHeaderAlignmentHorz write SetHeaderAlignmentHorz
      stored IsHeaderAlignmentHorzStored;
    property HeaderAlignmentVert: TcxAlignmentVert read GetHeaderAlignmentVert
      write SetHeaderAlignmentVert stored IsHeaderAlignmentVertStored;
    //property Hidden: Boolean read GetHidden write SetHidden stored IsHiddenStored;
    property IgnoreLoadingStatus: Boolean read FIgnoreLoadingStatus write FIgnoreLoadingStatus;
    property InternalVisible: Boolean read FVisible;
    property MinWidth: Integer read GetMinWidth write SetMinWidth
      default cxGridItemDefaultMinWidth;
    property ViewData: TcxCustomGridTableViewData read GetViewData;
    property WasVisibleBeforeGrouping: Boolean read FWasVisibleBeforeGrouping;
    property Width: Integer read GetWidth write SetWidth stored IsWidthStored;

    property OnGetFilterDisplayText: TcxGridGetFilterDisplayTextEvent read FOnGetFilterDisplayText
      write FOnGetFilterDisplayText;
    property OnGetFilterValues: TcxGridGetFilterValuesEvent read FOnGetFilterValues write FOnGetFilterValues;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;

    procedure ApplyBestFit; virtual;
    function CalculateDefaultCellHeight(ACanvas: TcxCanvas; AFont: TFont): Integer; virtual;
    function CreateEditStyle: TcxEditStyle; virtual;
    function GetDefaultValuesProvider(AProperties: TcxCustomEditProperties = nil): IcxEditDefaultValuesProvider;
    function GetProperties: TcxCustomEditProperties; overload;
    function GetProperties(ARecord: TcxCustomGridRecord): TcxCustomEditProperties; overload;
    function GetRepositoryItem: TcxEditRepositoryItem;
    procedure RestoreDefaults; virtual;

    property ActuallyVisible: Boolean read GetActuallyVisible;
    property DataBinding: TcxGridItemDataBinding read FDataBinding write SetDataBinding;
    property Editing: Boolean read GetEditing write SetEditing;
    property EditValue: Variant read GetEditValue write SetEditValue;
    property Focused: Boolean read GetFocused write SetFocused;
    property FocusedCellViewInfo: TcxGridTableDataCellViewInfo read GetFocusedCellViewInfo;
    property GridView: TcxCustomGridTableView read FGridView;
    property Hideable: Boolean read CanHide;
    property ID: Integer read FID;
    property IncSearching: Boolean read GetIncSearching;
    property Index: Integer read FIndex write SetIndex;
    property IsFirst: Boolean read GetIsFirst;
    property IsLast: Boolean read GetIsLast;
    property Options: TcxCustomGridTableItemOptions read FOptions write SetOptions;
    property PropertiesClass: TcxCustomEditPropertiesClass read FPropertiesClass write SetPropertiesClass;
    property SortIndex: Integer read GetSortIndex write SetSortIndex;
    property SortOrder: TcxGridSortOrder read GetSortOrder write SetSortOrder default soNone;
    property Styles: TcxCustomGridTableItemStyles read FStyles write SetStyles;
    property VisibleIndex: Integer read FVisibleIndex write SetVisibleIndex;
  published
    property Caption: string read GetCaption write SetCaption stored IsCaptionStored;
    property PropertiesClassName: string read GetPropertiesClassName write SetPropertiesClassName;
    property Properties: TcxCustomEditProperties read FProperties write SetProperties;
    property RepositoryItem: TcxEditRepositoryItem read FRepositoryItem write SetRepositoryItem;
    property Visible: Boolean read GetVisible write SetVisible stored IsVisibleStored;
    property PropertiesEvents: TNotifyEvent read FSubClassEvents write FSubClassEvents;
    property StylesEvents: TNotifyEvent read FSubClassEvents write FSubClassEvents;
    property OnCustomDrawCell: TcxGridTableDataCellCustomDrawEvent read FOnCustomDrawCell write FOnCustomDrawCell;
    property OnGetDisplayText: TcxGridGetDisplayTextEvent read FOnGetDisplayText write FOnGetDisplayText;
    property OnGetProperties: TcxGridGetPropertiesEvent read FOnGetProperties write SetOnGetProperties;
  end;

  // grid view options

  {4}
  TcxCustomGridTableBackgroundBitmaps = class(TcxCustomGridBackgroundBitmaps)
  protected
    function GetBitmapStyleIndex(Index: Integer): Integer; override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Content: TBitmap index bbContent read GetValue write SetValue;
  end;

  TcxGridTableFilterVisible = (fvNever, fvNonEmpty, fvAlways);

  TcxCustomGridTableFilteringClass = class of TcxCustomGridTableFiltering;

  TcxCustomGridTableFiltering = class(TcxCustomGridOptions)
  private
    FCustomizeDialog: Boolean;
    FDropDownWidth: Integer;
    FMaxDropDownCount: Integer;
    FVisible: TcxGridTableFilterVisible;
    function GetGridView: TcxCustomGridTableView;
    procedure SetCustomizeDialog(Value: Boolean);
    procedure SetDropDownWidth(Value: Integer);
    procedure SetMaxDropDownCount(Value: Integer);
    procedure SetVisible(Value: TcxGridTableFilterVisible);
    procedure FilterControlDialogApply(Sender: TObject);
  protected
    property CustomizeDialog: Boolean read FCustomizeDialog write SetCustomizeDialog default True;
    property DropDownWidth: Integer read FDropDownWidth write SetDropDownWidth default 0;
    property MaxDropDownCount: Integer read FMaxDropDownCount write SetMaxDropDownCount
      default cxGridFilterDefaultMaxDropDownCount;
    property Visible: TcxGridTableFilterVisible read FVisible write SetVisible default fvNonEmpty;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    procedure Assign(Source: TPersistent); override;
    function GetDropDownCount(AItemCount: Integer): Integer;
    procedure RunCustomizeDialog(AItem: TcxCustomGridTableItem = nil);
    property GridView: TcxCustomGridTableView read GetGridView;
  end;

  TcxGridDragFocusing = (dfNone, dfDragOver, dfDragDrop);

  TcxCustomGridTableOptionsBehaviorClass = class of TcxCustomGridTableOptionsBehavior;

  TcxCustomGridTableOptionsBehavior = class(TcxCustomGridOptions)
  private
    FAlwaysShowEditor: Boolean;
    FBestFitMaxRecordCount: Integer;
    FCellHints: Boolean;
    FDragFocusing: TcxGridDragFocusing;
    FDragHighlighting: Boolean;
    FDragOpening: Boolean;
    FDragScrolling: Boolean;
    FFocusCellOnCycle: Boolean;
    FFocusCellOnTab: Boolean;
    FFocusFirstCellOnNewRecord: Boolean;
    FGoToNextCellOnEnter: Boolean;
    FImmediateEditor: Boolean;
    FIncSearch: Boolean;
    FIncSearchItem: TcxCustomGridTableItem;
    FNavigatorHints: Boolean;
    FPullFocusing: Boolean;
    function GetGridView: TcxCustomGridTableView;
    procedure SetBestFitMaxRecordCount(Value: Integer);
    procedure SetFocusCellOnTab(Value: Boolean);
    procedure SetIncSearch(Value: Boolean);
  protected
    property FocusCellOnCycle: Boolean read FFocusCellOnCycle write FFocusCellOnCycle default False;
    property PullFocusing: Boolean read FPullFocusing write FPullFocusing default False;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    procedure Assign(Source: TPersistent); override;
    property BestFitMaxRecordCount: Integer read FBestFitMaxRecordCount write SetBestFitMaxRecordCount default 0;
    property GridView: TcxCustomGridTableView read GetGridView;
  published
    property AlwaysShowEditor: Boolean read FAlwaysShowEditor write FAlwaysShowEditor default False;
    property CellHints: Boolean read FCellHints write FCellHints default False;  {9}
    property DragFocusing: TcxGridDragFocusing read FDragFocusing write FDragFocusing default dfNone;
    property DragHighlighting: Boolean read FDragHighlighting write FDragHighlighting default True;
    property DragOpening: Boolean read FDragOpening write FDragOpening default True;
    property DragScrolling: Boolean read FDragScrolling write FDragScrolling default True;
    property FocusCellOnTab: Boolean read FFocusCellOnTab write SetFocusCellOnTab default False;
    property FocusFirstCellOnNewRecord: Boolean read FFocusFirstCellOnNewRecord
      write FFocusFirstCellOnNewRecord default False;
    property GoToNextCellOnEnter: Boolean read FGoToNextCellOnEnter write FGoToNextCellOnEnter default False;
    property ImmediateEditor: Boolean read FImmediateEditor write FImmediateEditor default True;
    property IncSearch: Boolean read FIncSearch write SetIncSearch default False;
    property IncSearchItem: TcxCustomGridTableItem read FIncSearchItem write FIncSearchItem;
    property NavigatorHints: Boolean read FNavigatorHints write FNavigatorHints default False;
  end;

  TcxCustomGridTableOptionsCustomizeClass = class of TcxCustomGridTableOptionsCustomize;

  TcxCustomGridTableOptionsCustomize = class(TcxCustomGridOptions)
  private
    FItemGrouping: Boolean;
    FItemMoving: Boolean;
    FItemSorting: Boolean;
  protected
    property ItemGrouping: Boolean read FItemGrouping write FItemGrouping default True;
    property ItemMoving: Boolean read FItemMoving write FItemMoving default True;
    property ItemSorting: Boolean read FItemSorting write FItemSorting default True;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    procedure Assign(Source: TPersistent); override;
  end;

  TcxCustomGridTableOptionsDataClass = class of TcxCustomGridTableOptionsData;

  TcxCustomGridTableOptionsData = class(TcxCustomGridOptions)
  private
    FAppending: Boolean;
    FCancelOnExit: Boolean;
    FDeleting: Boolean;
    FDeletingConfirmation: Boolean;
    FEditing: Boolean;
    FInserting: Boolean;
    function GetGridView: TcxCustomGridTableView;
    procedure SetDeleting(Value: Boolean);
    procedure SetEditing(Value: Boolean);
    procedure SetInserting(Value: Boolean);
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    procedure Assign(Source: TPersistent); override;
    property GridView: TcxCustomGridTableView read GetGridView;
  published
    property Appending: Boolean read FAppending write FAppending default False;
    property CancelOnExit: Boolean read FCancelOnExit write FCancelOnExit default True;
    property Deleting: Boolean read FDeleting write SetDeleting default True;
    property DeletingConfirmation: Boolean read FDeletingConfirmation
      write FDeletingConfirmation default True;
    property Editing: Boolean read FEditing write SetEditing default True;
    property Inserting: Boolean read FInserting write SetInserting default True;
  end;

  TcxCustomGridTableOptionsSelection = class(TcxCustomGridOptionsSelection)
  private
    FCellSelect: Boolean;
    FHideFocusRect: Boolean;
    FHideSelection: Boolean;
    FInvertSelect: Boolean;
    FUnselectFocusedRecordOnExit: Boolean;
    function GetMultiSelect: Boolean;
    procedure SetCellSelect(Value: Boolean);
    procedure SetHideFocusRect(Value: Boolean);
    procedure SetHideSelection(Value: Boolean);
    procedure SetInvertSelect(Value: Boolean);
    procedure SetMultiSelect(Value: Boolean);
  protected
    function GridView: TcxCustomGridTableView; reintroduce;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    procedure Assign(Source: TPersistent); override;
  published
    property CellSelect: Boolean read FCellSelect write SetCellSelect default True;
    property HideFocusRect: Boolean read FHideFocusRect write SetHideFocusRect default True;
    property HideSelection: Boolean read FHideSelection write SetHideSelection default False;
    property InvertSelect: Boolean read FInvertSelect write SetInvertSelect default True;
    property MultiSelect: Boolean read GetMultiSelect write SetMultiSelect default False;
    property UnselectFocusedRecordOnExit: Boolean read FUnselectFocusedRecordOnExit
      write FUnselectFocusedRecordOnExit default True;
  end;

  TcxGridShowEditButtons = (gsebNever, gsebForFocusedRecord, gsebAlways);

  TcxCustomGridTableOptionsView = class(TcxCustomGridOptionsView)
  private
    FCellAutoHeight: Boolean;
    FCellEndEllipsis: Boolean;
    FCellTextMaxLineCount: Integer;
    FItemCaptionAutoHeight: Boolean;
    FItemCaptionEndEllipsis: Boolean;
    FNavigator: Boolean;
    FNavigatorOffset: Integer;
    FShowEditButtons: TcxGridShowEditButtons;
    function GetGridView: TcxCustomGridTableView;
    procedure SetCellAutoHeight(Value: Boolean);
    procedure SetCellEndEllipsis(Value: Boolean);
    procedure SetCellTextMaxLineCount(Value: Integer);
    procedure SetItemCaptionAutoHeight(Value: Boolean);
    procedure SetItemCaptionEndEllipsis(Value: Boolean);
    procedure SetNavigator(Value: Boolean);
    procedure SetNavigatorOffset(Value: Integer);
    procedure SetShowEditButtons(Value: TcxGridShowEditButtons);
  protected
    procedure ItemCaptionAutoHeightChanged; dynamic;
    procedure SizeChanged;

    property CellAutoHeight: Boolean read FCellAutoHeight write SetCellAutoHeight default False;
    property CellTextMaxLineCount: Integer read FCellTextMaxLineCount write SetCellTextMaxLineCount default 0;
    property ItemCaptionAutoHeight: Boolean read FItemCaptionAutoHeight
      write SetItemCaptionAutoHeight default False;
    property ItemCaptionEndEllipsis: Boolean read FItemCaptionEndEllipsis
      write SetItemCaptionEndEllipsis default False;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    procedure Assign(Source: TPersistent); override;
    property GridView: TcxCustomGridTableView read GetGridView;
  published
    property CellEndEllipsis: Boolean read FCellEndEllipsis write SetCellEndEllipsis
      default False;
    property Navigator: Boolean read FNavigator write SetNavigator default False;
    property NavigatorOffset: Integer read FNavigatorOffset write SetNavigatorOffset default cxGridNavigatorDefaultOffset;
    property ShowEditButtons: TcxGridShowEditButtons read FShowEditButtons
      write SetShowEditButtons default gsebNever;
  end;

  TcxGridDataCellPos = class
    GridRecord: TcxCustomGridRecord;
    Item: TcxCustomGridTableItem;
  end;

  TcxCustomGridTableViewStyles = class(TcxCustomGridViewStyles)
  private
    FOnGetContentStyle: TcxGridGetCellStyleEvent;
    function GetGridViewValue: TcxCustomGridTableView;
  protected
    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure GetContentParams(ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      out AParams: TcxViewParams); virtual;
    procedure GetDataCellContentParams(ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      out AParams: TcxViewParams); virtual;
    procedure GetDataCellParams(ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      out AParams: TcxViewParams; AUseViewInfo: Boolean = False; ACellViewInfo: TcxGridTableCellViewInfo = nil); virtual;
    procedure GetRecordContentParams(ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      out AParams: TcxViewParams); virtual;
    property GridView: TcxCustomGridTableView read GetGridViewValue;
  published
    property Content: TcxStyle index vsContent read GetValue write SetValue;
    property ContentEven: TcxStyle index vsContentEven read GetValue write SetValue;
    property ContentOdd: TcxStyle index vsContentOdd read GetValue write SetValue;
    property Inactive: TcxStyle index vsInactive read GetValue write SetValue;
    property IncSearch: TcxStyle index vsIncSearch read GetValue write SetValue;
    property Selection: TcxStyle index vsSelection read GetValue write SetValue;
    property OnGetContentStyle: TcxGridGetCellStyleEvent read FOnGetContentStyle write FOnGetContentStyle;
  end;

  // grid view

  TcxGridTableCellCustomDrawEvent = procedure(Sender: TcxCustomGridTableView;
    ACanvas: TcxCanvas; AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean) of object;

  TcxGridCanSelectRecordEvent = procedure(Sender: TcxCustomGridTableView;
    ARecord: TcxCustomGridRecord; var AAllow: Boolean) of object;
  TcxGridCellClickEvent = procedure(Sender: TcxCustomGridTableView;
    ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
    AShift: TShiftState; var AHandled: Boolean)of object;
  TcxGridCustomTableViewEvent = procedure(Sender: TcxCustomGridTableView) of object;
  TcxGridEditingEvent = procedure(Sender: TcxCustomGridTableView;
    AItem: TcxCustomGridTableItem; var AAllow: Boolean) of object;
  TcxGridCustomTableItemEvent = procedure(Sender: TcxCustomGridTableView;
    AItem: TcxCustomGridTableItem) of object;
  TcxGridFocusedItemChangedEvent = procedure(Sender: TcxCustomGridTableView;
    APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem) of object;
  TcxGridFocusedRecordChangedEvent = procedure(Sender: TcxCustomGridTableView;
    APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean) of object;
  TcxGridInitEditEvent = procedure(Sender: TcxCustomGridTableView;
    AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit) of object;
  TcxGridRecordEvent = procedure(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord) of object;

  TcxGridDataControllerChange = (dccGlobal, dccItemAdded, dccItemRemoved, dccIndexesChanged);

  TcxCustomGridTableView = class(TcxCustomGridView, IcxFilterControl, IcxNavigator)
  private
    FCopyToClipboardStr: string;
    FDontMakeMasterRecordVisible: Boolean;
    FFilterableItems: TList;
    FFiltering: TcxCustomGridTableFiltering;
    FItems: TList;
    FNavigatorButtons: TcxNavigatorControlButtons;
    FNavigatorNotifier: TcxNavigatorControlNotifier;
    FNextID: Integer;
    FOptionsBehavior: TcxCustomGridTableOptionsBehavior;
    FOptionsCustomize: TcxCustomGridTableOptionsCustomize;
    FOptionsData: TcxCustomGridTableOptionsData;
    FVisibleItems: TList;
    FOnCanSelectRecord: TcxGridCanSelectRecordEvent;
    FOnCellClick: TcxGridCellClickEvent;
    FOnCustomDrawCell: TcxGridTableDataCellCustomDrawEvent;
    FOnEditing: TcxGridEditingEvent;
    FOnEditChanged: TcxGridCustomTableItemEvent;
    FOnEditValueChanged: TcxGridCustomTableItemEvent;
    FOnFilterControlDialogShow: TNotifyEvent;
    FOnFocusedItemChanged: TcxGridFocusedItemChangedEvent;
    FOnFocusedRecordChanged: TcxGridFocusedRecordChangedEvent;
    FOnInitEdit: TcxGridInitEditEvent;
    //FOnRecordCreated: TcxGridRecordEvent;
    //FOnRecordDestroying: TcxGridRecordEvent;
    FOnSelectionChanged: TcxGridCustomTableViewEvent;
    FOnTopRecordIndexChanged: TNotifyEvent;

    function GetBackgroundBitmaps: TcxCustomGridTableBackgroundBitmaps;
    function GetController: TcxCustomGridTableController;
    function GetDataController: TcxGridDataController;
    function GetFilterableItem(Index: Integer): TcxCustomGridTableItem;
    function GetFilterableItemCount: Integer;
    function GetGroupedItem(Index: Integer): TcxCustomGridTableItem;
    function GetGroupedItemCount: Integer;
    function GetItem(Index: Integer): TcxCustomGridTableItem;
    function GetItemCount: Integer;
    function GetMasterGridRecord: TcxCustomGridRecord;
    function GetOptionsSelection: TcxCustomGridTableOptionsSelection;
    function GetOptionsView: TcxCustomGridTableOptionsView;
    function GetPainter: TcxCustomGridTablePainter;
    function GetNavigatorButtonsControl: IcxNavigator;
    function GetSortedItem(Index: Integer): TcxCustomGridTableItem;
    function GetSortedItemCount: Integer;
    function GetStyles: TcxCustomGridTableViewStyles;
    function GetViewData: TcxCustomGridTableViewData;
    function GetViewInfo: TcxCustomGridTableViewInfo;
    function GetVisibleItem(Index: Integer): TcxCustomGridTableItem;
    function GetVisibleItemCount: Integer;
    procedure SetBackgroundBitmaps(Value: TcxCustomGridTableBackgroundBitmaps);
    procedure SetDataController(Value: TcxGridDataController);
    procedure SetFiltering(Value: TcxCustomGridTableFiltering);
    procedure SetItem(Index: Integer; Value: TcxCustomGridTableItem);
    procedure SetNavigatorButtons(Value: TcxNavigatorControlButtons);
    procedure SetOptionsBehavior(Value: TcxCustomGridTableOptionsBehavior);
    procedure SetOptionsCustomize(Value: TcxCustomGridTableOptionsCustomize);
    procedure SetOptionsData(Value: TcxCustomGridTableOptionsData);
    procedure SetOptionsSelection(Value: TcxCustomGridTableOptionsSelection);
    procedure SetOptionsView(Value: TcxCustomGridTableOptionsView);
    procedure SetStyles(Value: TcxCustomGridTableViewStyles);

    procedure CopyForEachRowProc(ARowIndex: Integer; ARowInfo: TcxRowInfo);
    procedure RefreshItemIndexes;
  protected
    // IcxFilterControl
    function IcxFilterControl.GetCaption = GetFilterCaption;
    function IcxFilterControl.GetCount = GetFilterCount;
    function IcxFilterControl.GetCriteria = GetFilterCriteria;
    function IcxFilterControl.GetFieldName = GetFilterFieldName;
    function IcxFilterControl.GetItemLink = GetFilterItemLink;
    function IcxFilterControl.GetItemLinkID = GetFilterItemLinkID;
    function IcxFilterControl.GetItemLinkName = GetFilterItemLinkName;
    function IcxFilterControl.GetProperties = GetFilterProperties;
    function IcxFilterControl.GetValueType = GetFilterValueType;
    function GetFilterCaption(Index: Integer): string;
    function GetFilterCount: Integer;
    function GetFilterCriteria: TcxFilterCriteria;
    function GetFilterFieldName(Index: Integer): string;
    function GetFilterItemLink(Index: Integer): TObject;
    function GetFilterItemLinkID(Index: Integer): Integer;
    function GetFilterItemLinkName(Index: Integer): string;
    function GetFilterProperties(Index: Integer): TcxCustomEditProperties;
    function GetFilterValueType(Index: Integer): TcxValueTypeClass;
    // IcxNavigator
    function IcxNavigator.IsActive = NavigatorIsActive;
    function IcxNavigator.IsBof = NavigatorIsBof;
    function IcxNavigator.IsEof = NavigatorIsEof;
    function IcxNavigator.CanAppend = NavigatorCanAppend;
    function IcxNavigator.CanEdit = NavigatorCanEdit;
    function IcxNavigator.CanDelete = NavigatorCanDelete;
    function IcxNavigator.CanInsert = NavigatorCanInsert;
    function IcxNavigator.IsEditing = NavigatorIsEditing;
    procedure IcxNavigator.ClearBookmark = NavigatorClearBookmark;
    function IcxNavigator.IsBookmarkAvailable = NavigatorIsBookmarkAvailable;
    procedure IcxNavigator.DoAction = NavigatorDoAction;
    function IcxNavigator.GetNotifier = NavigatorGetNotifier;
    function IcxNavigator.IsActionSupported = NavigatorIsActionSupported;
    function NavigatorIsActive: Boolean;
    function NavigatorIsBof: Boolean;
    function NavigatorIsEof: Boolean;
    function NavigatorCanAppend: Boolean;
    function NavigatorCanEdit: Boolean;
    function NavigatorCanDelete: Boolean;
    function NavigatorCanInsert: Boolean;
    function NavigatorIsEditing: Boolean;
    procedure NavigatorClearBookmark;
    function NavigatorIsBookmarkAvailable: Boolean;
    procedure NavigatorDoAction(AButtonIndex: Integer);
    function NavigatorGetNotifier: TcxNavigatorControlNotifier;
    function NavigatorIsActionSupported(AButtonIndex: Integer): Boolean;
    // IcxStoredObject
    function GetProperties(AProperties: TStrings): Boolean; override;
    procedure GetPropertyValue(const AName: string; var AValue: Variant); override;
    procedure SetPropertyValue(const AName: string; const AValue: Variant); override;
    // IcxStoredParent
    function CreateChild(const AObjectName, AClassName: string): TObject; override;
    procedure GetStoredChildren(AChildren: TStringList); override;

    function CanOffset(ARecordCountDelta: Integer): Boolean; virtual;
    function CanSelectRecord(ARecordIndex: Integer): Boolean; virtual;
    function CanTabStop: Boolean; override;
    procedure DetailVisibleChanged(ADetailLevel: TComponent;
      APrevVisibleDetailCount, AVisibleDetailCount: Integer); override;
    procedure DoAssign(ASource: TcxCustomGridView); override;
    function FindItemByObjectName(const AObjectName: string): TcxCustomGridTableItem;
    procedure FocusEdit(AItemIndex: Integer; var ADone: Boolean); virtual;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    function GetDefaultActiveDetailIndex: Integer; virtual;
    function GetDisplayText(ARecordIndex, AItemIndex: Integer; out AText: string): Boolean;
    procedure GetFakeComponentLinks(AList: TList); override;
    function GetIsControlFocused: Boolean; override;
    function GetItemSortByDisplayText(AItemIndex: Integer): Boolean;
    function GetItemValueSource(AItemIndex: Integer): TcxDataEditValueSource;
    function HasCustomDrawCell: Boolean;
    procedure Init; override;
    function IsDetailVisible(AGridView: TcxCustomGridView): Boolean; override;
    function IsEqualHeightRecords: Boolean; virtual;
    procedure LoadingComplete; override;
    procedure Offset(ARecordCountDelta, DX, DY: Integer); virtual;
    procedure SetChildOrder(Child: TComponent; Order: Integer); override;
    procedure SetName(const NewName: TComponentName); override;
    procedure UpdateControl(AInfo: TcxUpdateControlInfo); override;
    procedure UpdateDataController(AChange: TcxGridDataControllerChange;
      AItem: TcxCustomGridTableItem = nil);
    procedure UpdateRecord; virtual;

    procedure CreateHandlers; override;
    procedure DestroyHandlers; override;
    procedure CreateOptions; override;
    procedure DestroyOptions; override;

    procedure AddItem(AItem: TcxCustomGridTableItem); virtual;
    procedure RemoveItem(AItem: TcxCustomGridTableItem); virtual;
    procedure AssignVisibleItemsIndexes;
    procedure ChangeItemIndex(AItem: TcxCustomGridTableItem; Value: Integer); virtual;
    procedure ItemVisibilityChanged(AItem: TcxCustomGridTableItem; Value: Boolean); virtual;
    procedure RefreshVisibleItemsList; virtual;

    function GetItemClass: TcxCustomGridTableItemClass; virtual; abstract;
    function GetItemDataBindingClass: TcxGridItemDataBindingClass; virtual;
    function GetNextID: Integer;
    procedure ReleaseID(AID: Integer);

    procedure DataChanged; virtual;
    procedure DataLayoutChanged; virtual;
    function DoCellClick(ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState): Boolean; virtual;
    function DoEditing(AItem: TcxCustomGridTableItem): Boolean; virtual;
    procedure DoGetDisplayText(ARecord: TcxCustomGridRecord; AItemIndex: Integer; var AText: string); virtual;
    procedure DoTopRecordIndexChanged; virtual;
    procedure FocusedItemChanged(APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem); virtual;
    procedure FocusedRecordChanged(APrevFocusedRecordIndex, AFocusedRecordIndex: Integer;
      ANewItemRecordFocusingChanged: Boolean); virtual;
    procedure ItemValueTypeClassChanged(AItemIndex: Integer); virtual;
    procedure RecalculateDefaultWidths;
    procedure RecordChanged(ARecordIndex: Integer); virtual;
    procedure RecordCountChanged; virtual;
    procedure RefreshFilterableItemsList;
    procedure RefreshNavigators;
    procedure SearchChanged; virtual;
    procedure SelectionChanged(AInfo: TcxSelectionChangedInfo); virtual;

    function DrawDataCellSelected(ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      AUseViewInfo: Boolean = False; ACellViewInfo: TcxGridTableCellViewInfo = nil): Boolean; virtual;
    function DrawRecordActive(ARecord: TcxCustomGridRecord): Boolean; virtual;
    function DrawRecordFocused(ARecord: TcxCustomGridRecord): Boolean; virtual;
    function DrawRecordSelected(ARecord: TcxCustomGridRecord): Boolean; virtual;

    procedure DoCustomDrawCell(ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean); virtual;
    procedure DoEditChanged(AItem: TcxCustomGridTableItem); virtual;
    procedure DoEditValueChanged(AItem: TcxCustomGridTableItem); virtual;
    procedure DoInitEdit(AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit); virtual;
    //procedure DoRecordCreated(ARecord: TcxCustomGridRecord); virtual;
    //procedure DoRecordDestroying(ARecord: TcxCustomGridRecord); virtual;

    function GetControllerClass: TcxCustomGridControllerClass; override;
    function GetPainterClass: TcxCustomGridPainterClass; override;
    function GetViewDataClass: TcxCustomGridViewDataClass; override;
    function GetViewInfoCacheClass: TcxCustomGridViewInfoCacheClass; override;
    function GetViewInfoClass: TcxCustomGridViewInfoClass; override;

    function GetBackgroundBitmapsClass: TcxCustomGridBackgroundBitmapsClass; override;
    function GetFilteringClass: TcxCustomGridTableFilteringClass; virtual;
    function GetNavigatorButtonsClass: TcxNavigatorControlButtonsClass; virtual;
    function GetOptionsBehaviorClass: TcxCustomGridTableOptionsBehaviorClass; virtual;
    function GetOptionsCustomizeClass: TcxCustomGridTableOptionsCustomizeClass; virtual;
    function GetOptionsDataClass: TcxCustomGridTableOptionsDataClass; virtual;
    function GetOptionsSelectionClass: TcxCustomGridOptionsSelectionClass; override;
    function GetOptionsViewClass: TcxCustomGridOptionsViewClass; override;
    function GetStylesClass: TcxCustomGridViewStylesClass; override;

    function GetSummaryGroupItemLinkClass: TcxDataSummaryGroupItemLinkClass; virtual;
    function GetSummaryItemClass: TcxDataSummaryItemClass; virtual;

    property BackgroundBitmaps: TcxCustomGridTableBackgroundBitmaps read GetBackgroundBitmaps
      write SetBackgroundBitmaps;
    property DontMakeMasterRecordVisible: Boolean read FDontMakeMasterRecordVisible
      write FDontMakeMasterRecordVisible;
    property FilterableItemCount: Integer read GetFilterableItemCount;
    property FilterableItems[Index: Integer]: TcxCustomGridTableItem read GetFilterableItem;
    property NavigatorNotifier: TcxNavigatorControlNotifier read FNavigatorNotifier;
    property NextID: Integer read FNextID;
    property VisibleItemsList: TList read FVisibleItems;
    property OnFilterControlDialogShow: TNotifyEvent read FOnFilterControlDialogShow write FOnFilterControlDialogShow;
  public
    destructor Destroy; override;

    procedure ApplyBestFit(AItem: TcxCustomGridTableItem = nil);
    procedure ClearItems;
    procedure CopyToClipboard(ACopyAll: Boolean);
    function CreateItem: TcxCustomGridTableItem;
    function FindItemByID(AID: Integer): TcxCustomGridTableItem;
    function FindItemByName(const AName: string): TcxCustomGridTableItem;
    function IndexOfItem(AItem: TcxCustomGridTableItem): Integer;
    procedure MakeMasterGridRecordVisible;
    procedure RestoreDefaults; override;

    // for extended lookup edit
    class function CanBeLookupList: Boolean; virtual;

    property Controller: TcxCustomGridTableController read GetController;
    property Filtering: TcxCustomGridTableFiltering read FFiltering write SetFiltering;
    property GroupedItemCount: Integer read GetGroupedItemCount;
    property GroupedItems[Index: Integer]: TcxCustomGridTableItem read GetGroupedItem;
    property ItemCount: Integer read GetItemCount;
    property Items[Index: Integer]: TcxCustomGridTableItem read GetItem write SetItem;
    property MasterGridRecord: TcxCustomGridRecord read GetMasterGridRecord;
    property OptionsBehavior: TcxCustomGridTableOptionsBehavior read FOptionsBehavior
      write SetOptionsBehavior;
    property OptionsCustomize: TcxCustomGridTableOptionsCustomize read FOptionsCustomize
      write SetOptionsCustomize;
    property OptionsData: TcxCustomGridTableOptionsData read FOptionsData write SetOptionsData;
    property OptionsSelection: TcxCustomGridTableOptionsSelection read GetOptionsSelection
      write SetOptionsSelection;
    property OptionsView: TcxCustomGridTableOptionsView read GetOptionsView write SetOptionsView;
    property Painter: TcxCustomGridTablePainter read GetPainter;
    property SortedItemCount: Integer read GetSortedItemCount;
    property SortedItems[Index: Integer]: TcxCustomGridTableItem read GetSortedItem;
    property Styles: TcxCustomGridTableViewStyles read GetStyles write SetStyles;
    property ViewData: TcxCustomGridTableViewData read GetViewData;
    property ViewInfo: TcxCustomGridTableViewInfo read GetViewInfo;
    property VisibleItemCount: Integer read GetVisibleItemCount;
    property VisibleItems[Index: Integer]: TcxCustomGridTableItem read GetVisibleItem;
  published
    property DataController: TcxGridDataController read GetDataController write SetDataController;
    property NavigatorButtons: TcxNavigatorControlButtons read FNavigatorButtons write SetNavigatorButtons;

    property OnCanSelectRecord: TcxGridCanSelectRecordEvent read FOnCanSelectRecord write FOnCanSelectRecord;
    property OnCellClick: TcxGridCellClickEvent read FOnCellClick write FOnCellClick;
    property OnCustomDrawCell: TcxGridTableDataCellCustomDrawEvent read FOnCustomDrawCell write FOnCustomDrawCell;
    property OnEditing: TcxGridEditingEvent read FOnEditing write FOnEditing;
    property OnEditChanged: TcxGridCustomTableItemEvent read FOnEditChanged write FOnEditChanged;
    property OnEditValueChanged: TcxGridCustomTableItemEvent read FOnEditValueChanged write FOnEditValueChanged;
    property OnFocusedItemChanged: TcxGridFocusedItemChangedEvent read FOnFocusedItemChanged
      write FOnFocusedItemChanged;
    property OnFocusedRecordChanged: TcxGridFocusedRecordChangedEvent read FOnFocusedRecordChanged
      write FOnFocusedRecordChanged;
    property OnInitEdit: TcxGridInitEditEvent read FOnInitEdit write FOnInitEdit;
    //property OnRecordCreated: TcxGridRecordEvent read FOnRecordCreated write FOnRecordCreated;
    //property OnRecordDestroying: TcxGridRecordEvent read FOnRecordDestroying write FOnRecordDestroying;
    property OnSelectionChanged: TcxGridCustomTableViewEvent read FOnSelectionChanged write FOnSelectionChanged;
    property OnTopRecordIndexChanged: TNotifyEvent read FOnTopRecordIndexChanged write FOnTopRecordIndexChanged;
  end;

implementation

uses
  Math, SysUtils,
{$IFDEF DELPHI6}
  Variants,
{$ENDIF}
  Forms, Clipbrd, cxTextEdit, cxEditUtils, cxFilterDialog, cxFilterControlDialog,
  cxEditDataRegisteredRepositoryItems, cxLibraryConsts,
  cxGrid, cxGridStrs, cxGridLevel, cxGridDetailsSite;

const
  RecordIndexNone = -1;
  EditStartChars = [#8, ^V, ^X, #32..#255];
  IncSearchStartChars = [#8, #32..#255];
  DragScrollTimeInterval = 20;
  DragFocusingScrollTimeInterval = 10;
  // Copy to text format
  EndOfLine = #13#10;
  ColumnSeparator = #9;

type
  TcxControlAccess = class(TcxControl);
  TcxCustomGridAccess = class(TcxCustomGrid);
  TcxGridSiteAccess = class(TcxGridSite);
  TcxCustomGridViewAccess = class(TcxCustomGridView);
  TcxGridLevelAccess = class(TcxGridLevel);
  TcxCustomDataControllerAccess = class(TcxCustomDataController);
  TcxFilterCriteriaAccess = class(TcxFilterCriteria);
  TcxCustomEditAccess = class(TcxCustomEdit);
  TcxCustomEditPropertiesAccess = class(TcxCustomEditProperties);
  TcxCustomEditStyleAccess = class(TcxCustomEditStyle);

{ TcxGridDataChange }

procedure TcxGridDataChange.Execute;
begin
  with GridView as TcxCustomGridTableView do
  begin
    RecordCountChanged;
    //Controller.MakeFocusedRecordVisible;   removed because of group nodes expanding
  end;
end;

function TcxGridDataChange.IsLockable: Boolean;
begin
  Result := False;
end;

{ TcxGridRecordChange }

constructor TcxGridRecordChange.Create(AGridView: TcxCustomGridView;
  ARecord: TcxCustomGridRecord; ARecordIndex: Integer; AItem: TcxCustomGridTableItem = nil);
begin
  inherited Create(AGridView);
  FRecord := ARecord;
  FRecordIndex := ARecordIndex;
  FItem := AItem;
end;

function TcxGridRecordChange.GetGridView: TcxCustomGridTableView;
begin
  Result := TcxCustomGridTableView(inherited GridView);
end;

function TcxGridRecordChange.GetRecordViewInfo: TcxCustomGridRecordViewInfo;
begin
  Result := GridView.ViewInfo.RecordsViewInfo.GetRealItem(FRecord, FRecordIndex);
end;

procedure TcxGridRecordChange.Execute;
begin
  if (RecordViewInfo = nil) or (FItem <> nil) and not IsItemVisible or
    not GridView.Changeable then Exit;
  RecordViewInfo.Recalculate;
  GridView.ViewChanged(RecordViewInfo.GetBoundsForInvalidate(FItem));
end;

function TcxGridRecordChange.IsCompatibleWith(AChange: TcxCustomGridChange): Boolean; {1}
begin
  Result := inherited IsCompatibleWith(AChange) or
    ((AChange is TcxGridLayoutChange) or (AChange is TcxGridSizeChange) or (AChange is TcxGridDataChange)) and
    (TcxCustomGridViewChange(AChange).GridView <> nil) and (TcxCustomGridViewChange(AChange).GridView = GridView);
end;

{function TcxGridRecordChange.IsCumulative: Boolean;
begin
  Result := False;
end;}

function TcxGridRecordChange.IsEqual(AChange: TcxCustomGridChange): Boolean;
begin
  Result := inherited IsEqual(AChange) and
    (GridRecord = TcxGridRecordChange(AChange).GridRecord) and
    (RecordIndex = TcxGridRecordChange(AChange).RecordIndex) and
    (Item = TcxGridRecordChange(AChange).Item);
end;

function TcxGridRecordChange.IsItemVisible: Boolean;
begin
  Result := (GridView.IndexOfItem(FItem) <> -1) and FItem.ActuallyVisible;
end;

{ TcxGridFocusedRecordChange }

constructor TcxGridFocusedRecordChange.Create(AGridView: TcxCustomGridView;
  APrevFocusedRecordIndex, AFocusedRecordIndex: Integer; ANewItemRecordFocusingChanged: Boolean);
begin
  inherited Create(AGridView);
  FPrevFocusedRecordIndex := APrevFocusedRecordIndex;
  FFocusedRecordIndex := AFocusedRecordIndex;
  FNewItemRecordFocusingChanged := ANewItemRecordFocusingChanged;
end;

procedure TcxGridFocusedRecordChange.Execute;
begin
  with GridView as TcxCustomGridTableView do
    if Changeable then
    begin
      Controller.MakeFocusedRecordVisible;
      if ViewData.IsRecordIndexValid(FPrevFocusedRecordIndex) then
        ViewData.Records[FPrevFocusedRecordIndex].Invalidate;
      if ViewData.IsRecordIndexValid(FFocusedRecordIndex) then
        ViewData.Records[FFocusedRecordIndex].Invalidate;
      if FNewItemRecordFocusingChanged and ViewData.HasNewItemRecord then
        ViewData.NewItemRecord.Invalidate;
    end;
end;

{ TcxGridRecordHitTest }

function TcxGridRecordHitTest.GetGridRecord: TcxCustomGridRecord;
begin
  if FIsNewItemRecord then
    Result := FViewData.NewItemRecord
  else
    if (0 <= FGridRecordIndex) and (FGridRecordIndex < FViewData.RecordCount) then
      Result := FViewData.Records[FGridRecordIndex]
    else
      Result := nil;
end;

procedure TcxGridRecordHitTest.SetGridRecord(Value: TcxCustomGridRecord);
begin
  if Value <> nil then
  begin
    FViewData := Value.ViewData;
    FGridRecordIndex := Value.Index;
    FIsNewItemRecord := Value.IsNewItemRecord;
  end
  else
  begin
    FViewData := nil;
    FGridRecordIndex := -1;
    FIsNewItemRecord := False;
  end;
end;

class function TcxGridRecordHitTest.GetHitTestCode: Integer;
begin
  Result := htRecord;
end;

class function TcxGridRecordHitTest.CanClick: Boolean;
begin
  Result := True;
end;

{ TcxGridRecordCellHitTest }

class function TcxGridRecordCellHitTest.GetHitTestCode: Integer;
begin
  Result := htCell;
end;

{ TcxGridExpandButtonHitTest }

class function TcxGridExpandButtonHitTest.GetHitTestCode: Integer;
begin
  Result := htExpandButton;
end;

class function TcxGridExpandButtonHitTest.CanClick: Boolean;
begin
  Result := False;
end;

{ TcxGridNavigatorHitTest }

class function TcxGridNavigatorHitTest.GetHitTestCode: Integer;
begin
  Result := htNavigator;
end;

{ TcxGridDefaultValuesProvider }

function TcxGridDefaultValuesProvider.IsDisplayFormatDefined(AIsCurrencyValueAccepted: Boolean): Boolean;
begin
  Result := TcxGridItemDataBinding(Owner).IsDisplayFormatDefined;
end;

{ TcxGridDataController }

function TcxGridDataController.GetGridViewValue: TcxCustomGridTableView;
begin
  Result := TcxCustomGridTableView(GetGridView);
end;

procedure TcxGridDataController.GetFakeComponentLinks(AList: TList);
begin
end;

function TcxGridDataController.GetGridView: TcxCustomGridView;
begin
  Result := TcxCustomGridView(GetOwner);
end;

procedure TcxGridDataController.CheckGridModeBufferCount;
begin
end;

function TcxGridDataController.DoScroll(AForward: Boolean): Boolean;
begin
  Result := False;
end;

function TcxGridDataController.DoScrollPage(AForward: Boolean): Boolean;
begin
  Result := False;
end;

function TcxGridDataController.GetFilterPropertyValue(const AName: string;
  var AValue: Variant): Boolean;
begin
  Result := False;
end;

function TcxGridDataController.GetItemDataBindingClass: TcxGridItemDataBindingClass;
begin
  Result := TcxGridItemDataBinding;
end;

function TcxGridDataController.GetItemDefaultValuesProviderClass: TcxCustomEditDefaultValuesProviderClass;
begin
  Result := TcxGridDefaultValuesProvider;
end;

function TcxGridDataController.GetNavigatorIsBof: Boolean;
begin
  Result := GridView.Controller.IsStart;
end;

function TcxGridDataController.GetNavigatorIsEof: Boolean;
begin
  Result := GridView.Controller.IsFinish;
end;

function TcxGridDataController.GetScrollBarPos: Integer;
begin
  Result := -1;
end;

function TcxGridDataController.GetScrollBarRecordCount: Integer;
begin
  Result := -1;
end;

function TcxGridDataController.SetFilterPropertyValue(const AName: string;
  const AValue: Variant): Boolean;
begin
  Result := False;
end;

function TcxGridDataController.SetScrollBarPos(Value: Integer): Boolean;
begin
  Result := False;
end;

function TcxGridDataController.CanSelectRow(ARowIndex: Integer): Boolean;
begin
  Result := GridView.CanSelectRecord(ARowIndex);
end;

procedure TcxGridDataController.DoValueTypeClassChanged(AItemIndex: Integer);
begin
  inherited;
  GridView.ItemValueTypeClassChanged(AItemIndex);
end;

function TcxGridDataController.GetDefaultActiveRelationIndex: Integer;
begin
  Result := GridView.GetDefaultActiveDetailIndex;
end;

{function TcxGridDataController.GetIncrementalSearchText(ARecordIndex, AItemIndex: Integer): string;
begin
  if not GridView.GetDisplayText(ARecordIndex, AItemIndex, Result) then
    Result := inherited GetIncrementalSearchText(ARecordIndex, AItemIndex);
end;}

function TcxGridDataController.GetItemID(AItem: TObject): Integer;
begin
  if AItem is TcxCustomGridTableItem then
    Result := TcxCustomGridTableItem(AItem).ID
  else
    Result := -1;
end;

function TcxGridDataController.GetSummaryGroupItemLinkClass: TcxDataSummaryGroupItemLinkClass;
begin
  Result := GridView.GetSummaryGroupItemLinkClass;
  if Result = nil then
    Result := inherited GetSummaryGroupItemLinkClass;
end;

function TcxGridDataController.GetSummaryItemClass: TcxDataSummaryItemClass;
begin
  Result := GridView.GetSummaryItemClass;
  if Result = nil then
    Result := inherited GetSummaryItemClass;
end;

procedure TcxGridDataController.BeginFullUpdate;
begin
  GridView.BeginUpdate;
  inherited;
end;

procedure TcxGridDataController.EndFullUpdate;
begin
  inherited;
  GridView.EndUpdate;
end;

function TcxGridDataController.CreateDetailLinkObject(ARelation: TcxCustomDataRelation;
  ARecordIndex: Integer): TObject;
begin
  Result := TcxGridLevelAccess(ARelation.Item).CreateLinkObject(ARelation, ARecordIndex);
end;

procedure TcxGridDataController.FocusControl(AItemIndex: Integer; var Done: Boolean);
begin
  inherited;
  GridView.FocusEdit(AItemIndex, Done);
end;

function TcxGridDataController.GetDetailDataControllerByLinkObject(ALinkObject: TObject): TcxCustomDataController;
begin
  Result := TcxCustomGridView(ALinkObject).DataController;
end;

function TcxGridDataController.GetDisplayText(ARecordIndex, AItemIndex: Integer): string;
begin
  if not GridView.GetDisplayText(ARecordIndex, AItemIndex, Result) then
    Result := inherited GetDisplayText(ARecordIndex, AItemIndex);
{  with GridView do
    DoGetDisplayText(ViewData.GetRecordByRecordIndex(ARecordIndex), AItemIndex, Result);}
end;

function TcxGridDataController.GetFilterItemFieldCaption(AItem: TObject): string;
begin
  Result := TcxCustomGridTableItem(AItem).FilterCaption;
end;

function TcxGridDataController.GetItem(Index: Integer): TObject;
begin
  Result := GridView.Items[Index];
end;

function TcxGridDataController.GetItemSortByDisplayText(AItemIndex: Integer;
  ASortByDisplayText: Boolean): Boolean;
begin
  Result := GridView.GetItemSortByDisplayText(AItemIndex);
end;

function TcxGridDataController.GetItemValueSource(AItemIndex: Integer): TcxDataEditValueSource;
begin
  Result := GridView.GetItemValueSource(AItemIndex);
end;

procedure TcxGridDataController.UpdateData;
begin
  inherited;
  GridView.UpdateRecord;
end;

function TcxGridDataController.AddItemToFilter(AParent: TcxFilterCriteriaItemList;
  AItem: TcxCustomGridTableItem; AOperatorKind: TcxFilterOperatorKind;
  const AValue: Variant; ADisplayText: string; AReplaceExistent: Boolean): TcxFilterCriteriaItem;
begin
  if ADisplayText = '' then
    if VarIsNull(AValue) then
      ADisplayText := ''
    else
      ADisplayText := AValue;
  AItem.DataBinding.GetFilterDisplayText(AValue, ADisplayText);
  if AReplaceExistent then
    Filter.RemoveItemByItemLink(AItem);
  Result := Filter.AddItem(AParent, AItem, AOperatorKind, AValue, ADisplayText);
end;

{ TcxGridItemDataBinding  }

constructor TcxGridItemDataBinding.Create(AItem: TcxCustomGridTableItem);
begin
  inherited Create;
  FItem := AItem;
  FDefaultValuesProvider := GetDefaultValuesProviderClass.Create(Self);
end;

destructor TcxGridItemDataBinding.Destroy;
begin
  FDefaultValuesProvider.Free;
  inherited;
end;

function TcxGridItemDataBinding.GetDataController: TcxCustomDataController;
begin
  Result := GridView.DataController;
end;

function TcxGridItemDataBinding.GetFilter: TcxDataFilterCriteria;
begin
  Result := DataController.Filter;
end;

function TcxGridItemDataBinding.GetFilterCriteriaItem: TcxFilterCriteriaItem;
begin
  Result := Filter.FindItemByItemLink(FItem);
end;

function TcxGridItemDataBinding.GetFiltered: Boolean;
begin
  Result := FilterCriteriaItem <> nil;
end;

function TcxGridItemDataBinding.GetGridView: TcxCustomGridTableView;
begin
  Result := FItem.GridView;
end;

function TcxGridItemDataBinding.GetValueTypeClass: TcxValueTypeClass;
begin
  Result := DataController.GetItemValueTypeClass(FItem.Index);
end;

procedure TcxGridItemDataBinding.SetFiltered(Value: Boolean);
begin
  if Filtered <> Value then
    if not Value then
      Filter.RemoveItemByItemLink(FItem);
end;

procedure TcxGridItemDataBinding.SetValueTypeClass(Value: TcxValueTypeClass);
begin
  DataController.ChangeValueTypeClass(FItem.Index, Value);
end;

function TcxGridItemDataBinding.GetDefaultValuesProviderClass: TcxCustomEditDefaultValuesProviderClass;
var
  AIcxGridDataController: IcxGridDataController;
begin
  if DataController.GetInterface(IcxGridDataController, AIcxGridDataController) then
    Result := AIcxGridDataController.GetItemDefaultValuesProviderClass
  else
    Result := nil;
end;

procedure TcxGridItemDataBinding.Init;
begin
end;

procedure TcxGridItemDataBinding.Assign(Source: TPersistent);
begin
  if Source is TcxGridItemDataBinding then
    with TcxGridItemDataBinding(Source) do
    begin
      Self.Data := Data;
      Self.ValueTypeClass := ValueTypeClass;
    end
  else
    inherited;
end;

function TcxGridItemDataBinding.DefaultCaption: string;
begin
  Result := ''{Item.Name};
end;

function TcxGridItemDataBinding.DefaultRepositoryItem: TcxEditRepositoryItem;
begin
  Result := GetDefaultEditDataRepositoryItems.GetItem(ValueTypeClass);
end;

function TcxGridItemDataBinding.DefaultWidth(ATakeHeaderIntoAccount: Boolean = True): Integer;
begin
  Result := 64;
end;

function TcxGridItemDataBinding.GetDefaultValuesProvider(AProperties: TcxCustomEditProperties = nil): IcxEditDefaultValuesProvider;
begin
  Result := FDefaultValuesProvider;
end;

function TcxGridItemDataBinding.IsDisplayFormatDefined: Boolean;
begin
  Result := DataController.GetItemTextStored(FItem.Index) or Assigned(FItem.OnGetDisplayText);
end;

function TcxGridItemDataBinding.AddToFilter(AParent: TcxFilterCriteriaItemList;
  AOperatorKind: TcxFilterOperatorKind; const AValue: Variant; const ADisplayText: string;
  AReplaceExistent: Boolean): TcxFilterCriteriaItem;
begin
  Result := GridView.DataController.AddItemToFilter(AParent, FItem,
    AOperatorKind, AValue, ADisplayText, AReplaceExistent);
end;

procedure TcxGridItemDataBinding.GetFilterDisplayText(const AValue: Variant;
  var ADisplayText: string);
begin
  FItem.GetFilterDisplayText(AValue, ADisplayText);
end;

procedure TcxGridItemDataBinding.GetFilterStrings(AStrings: TStrings;
  AValueList: TcxDataFilterValueList);
var
  I: Integer;
  S: string;
begin
  AValueList.Load(FItem.Index);
  FItem.DoGetFilterValues(AValueList);
  AStrings.BeginUpdate;
  try
    AStrings.Clear;
    for I := 0 to AValueList.Count - 1 do
    begin
      S := AValueList[I]^.DisplayText;
      GetFilterDisplayText(AValueList[I]^.Value, S);
      AStrings.AddObject(S, TObject(AValueList[I]));
    end;
  finally
    AStrings.EndUpdate;
  end;
end;

{ TcxCustomGridTableDragAndDropObject }

function TcxCustomGridTableDragAndDropObject.GetController: TcxCustomGridTableController;
begin
  Result := TcxCustomGridTableController(inherited Controller);
end;

function TcxCustomGridTableDragAndDropObject.GetGridView: TcxCustomGridTableView;
begin
  Result := TcxCustomGridTableView(inherited GridView);
end;

function TcxCustomGridTableDragAndDropObject.GetViewInfo: TcxCustomGridTableViewInfo;
begin
  Result := TcxCustomGridTableViewInfo(inherited ViewInfo);
end;

{ TcxGridEditingController }

constructor TcxGridEditingController.Create(AController: TcxCustomGridTableController);
begin
  inherited Create;
  FController := AController;
  FEditList := TcxInplaceEditList.Create(Controller.GridView);
end;

destructor TcxGridEditingController.Destroy;
begin
  StopEditShowingTimer;
  FEditList.Free;
  inherited;
end;

function TcxGridEditingController.GetEditingProperties: TcxCustomEditProperties;
begin
  if FEditingItem = nil then
    Result := nil
  else
    Result := FEditingItem.GetProperties(Controller.FocusedRecord);
end;

function TcxGridEditingController.GetGridView: TcxCustomGridTableView;
begin
  Result := FController.GridView;
end;

function TcxGridEditingController.GetIsEditing: Boolean;
begin
  Result := FEditingItem <> nil;
end;

procedure TcxGridEditingController.SetEditingItem(Value: TcxCustomGridTableItem);
begin
  if FEditingItem <> Value then
  begin
    if FEditingItemSetting then Exit;
    FEditingItemSetting := True;
    try
      if Value <> nil then
      begin
        if not Value.CanEdit or not GridView.DoEditing(Value) then Exit;
        Value.Focused := True;
      end;
      HideEdit(False);
      FEditingItem := Value;
      if IsEditing then
        try
          ShowEdit(Value);
          if not FEditPreparing and (FEdit = nil) then
            FEditingItem := nil;
        except
          FEditingItem := nil;
          raise;
        end;
    finally
      FEditingItemSetting := False;
    end;
  end;
end;

procedure TcxGridEditingController.EditShowingTimerHandler(Sender: TObject);
begin
  StopEditShowingTimer;
  FEditShowingTimerItem.Editing := True;
end;

procedure TcxGridEditingController.AfterViewInfoCalculate;
begin
  if IsEditing and (not FIsEditPlaced or FEditingItem.EditPartVisible) then
  begin
    CancelEditUpdatePost;
    if not FEditPreparing then
      FEdit.Left := cxGridInvisibleCoordinate;
  end;
end;

procedure TcxGridEditingController.BeforeViewInfoCalculate;
begin
  FIsEditPlaced := False;
end;

procedure TcxGridEditingController.CancelEditUpdatePost;
begin
  FEditUpdateNeeded := False;
end;

function TcxGridEditingController.CanRemoveEditFocus: Boolean;
begin
  Result := not (IsEditing and FEdit.IsFocused and not FEditHiding);
end;

procedure TcxGridEditingController.CheckEditUpdatePost;
begin
  if FEditUpdateNeeded then DoUpdateEdit;
end;

procedure TcxGridEditingController.DoUpdateEdit;
begin
  CancelEditUpdatePost;
  if (FEditingItem <> nil) and (FEditingItem.FocusedCellViewInfo <> nil) and
    not FEditingItem.EditPartVisible then
    with FEditingItem.FocusedCellViewInfo do
    begin
      if IsRectEmpty(Bounds) then Exit;
      FEdit.BoundsRect := EditBounds;
      InitStyle;
      FEdit.Style := Style;
    end;
end;

function TcxGridEditingController.GetHideEditOnExit: Boolean;
begin
  Result := True{
    not GridView.OptionsBehavior.AlwaysShowEditor or
    GridView.Control.IsFocused};
end;

function TcxGridEditingController.GetHideEditOnFocusedRecordChange: Boolean;
begin
  Result := not GridView.OptionsBehavior.AlwaysShowEditor or
    (FEditingItem <> nil) and
      (Assigned(FEditingItem.OnGetProperties) or FEditingItem.ShowButtons(False) or
       (esoAlwaysHotTrack in FEditingItem.GetProperties.GetSupportedOperations)) or
    Assigned(GridView.OnEditing) or Assigned(GridView.OnInitEdit);
end;

procedure TcxGridEditingController.InitEdit;
begin
  with TcxCustomEditPropertiesAccess(TcxCustomEditAccess(FEdit).Properties) do
  begin
    FPrevEditOnChange := OnChange;
    FPrevEditOnEditValueChanged := OnEditValueChanged;
    OnChange := nil;
    OnEditValueChanged := nil;
  end;  
  FEdit.Parent := FController.Site;
  UpdateEdit;
  UpdateEditValue;
  with TcxCustomEditAccess(FEdit) do
  begin
    OnAfterKeyDown := EditAfterKeyDown;
    OnEditing := EditEditing;
    OnPostEditValue := EditPostEditValue;
    TcxCustomEditPropertiesAccess(Properties).OnChange := EditChanged;
    TcxCustomEditPropertiesAccess(Properties).OnEditValueChanged := EditValueChanged;
    OnExit := EditExit;
    OnFocusChanged := EditFocusChanged;
    OnKeyDown := EditKeyDown;
  end;
  GridView.DoInitEdit(FEditingItem, FEdit);
end;

procedure TcxGridEditingController.PostEditUpdate;
begin
  FEditUpdateNeeded := True;
end;

function TcxGridEditingController.PrepareEdit(AItem: TcxCustomGridTableItem;
  AOnMouseEvent: Boolean): Boolean;
begin
  Result := False;
  try
    FController.CancelCheckEditPost;
    if FEditPreparing or FEditHiding or (AItem = nil) then Exit;
    if AItem.Editing and not FEditingItemSetting then
    begin
      Result := (FEdit <> nil) and
        (FController.Site.Focused and not FEdit.IsFocused or AOnMouseEvent);
      Exit;
    end;
    FEditPreparing := True;
    try
      Result := FController.Site.Focused;
      if not Result then Exit;
      AItem.Editing := True;
      Result := AItem.Editing;
      if not Result then Exit;
      try
        FEdit := FEditList.GetEdit(EditingProperties);
      except
        AItem.Editing := False;
        Result := False;
        raise;
      end;
      FEditingItem.FocusedCellViewInfo.Invalidate(True);
      InitEdit;
    finally
      FEditPreparing := False;
    end;
  finally
    if Result then GridView.TabStop := False;
  end;
end;

procedure TcxGridEditingController.UpdateEditValue;
begin
  if IsEditing and not FEditHiding and not FInitiatingEditing and
    not FEdit.IsPosting then
  begin
    FEdit.EditValue := EditingItem.EditValue;
    FEdit.SelectAll;
  end;
end;

procedure TcxGridEditingController.UpdateValue;
begin
  if IsEditing and TcxCustomEditAccess(FEdit).EditModified then
  begin
    FEdit.ValidateEdit(True);
    FEditingItem.EditValue := FEdit.EditValue;
    if FEdit <> nil then
      FEdit.ModifiedAfterEnter := False;
  end;
end;

procedure TcxGridEditingController.EditAfterKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if FController.IsKeyForController(Key, Shift) then
    FController.DoKeyDown(Key, Shift);
end;

procedure TcxGridEditingController.EditChanged(Sender: TObject);
begin
  if Assigned(FPrevEditOnChange) then FPrevEditOnChange(Sender);
  GridView.DoEditChanged(FEditingItem);
end;

procedure TcxGridEditingController.EditEditing(Sender: TObject; var CanEdit: Boolean);
begin
  FInitiatingEditing := True;
  try
    CanEdit := EditingItem.CanInitEditing;
  finally
    FInitiatingEditing := False;
  end;
end;

procedure TcxGridEditingController.EditExit(Sender: TObject);
begin
  if HideEditOnExit then
    try
      HideEdit(not FController.CancelEditingOnExit);
    except
      if IsEditing then
      begin
        FEdit.SetFocus;
        FIsErrorOnEditExit := True;
      end;
      raise;
    end;
end;

procedure TcxGridEditingController.EditFocusChanged(Sender: TObject);
begin
  TcxGridSiteAccess(FController.Site).FocusChanged;
end;

procedure TcxGridEditingController.EditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  AModified: Boolean;
begin
  FController.MakeFocusedItemVisible;
  case Key of
    VK_RETURN:
      begin
        HideEdit(True);
        if GridView.OptionsBehavior.GoToNextCellOnEnter then
        begin
          FController.BlockRecordKeyboardHandling := True;
          try
            FController.DoKeyDown(Key, Shift);
          finally
            FController.BlockRecordKeyboardHandling := False;
          end;
          ShowEdit;
        end
        else
          Controller.CheckEdit;
        Key := 0;
      end;
    VK_ESCAPE:
      begin
        AModified := TcxCustomEditAccess(FEdit).EditModified;
        HideEdit(False);
        Controller.CheckEdit;
        if AModified then Key := 0;
      end;
    VK_DELETE:
      if Shift = [ssCtrl] then
        Controller.DoKeyDown(Key, Shift);
  end;
end;

procedure TcxGridEditingController.EditPostEditValue(Sender: TObject);
begin
  UpdateValue;
end;

procedure TcxGridEditingController.EditValueChanged(Sender: TObject);
begin
  if Assigned(FPrevEditOnEditValueChanged) then FPrevEditOnEditValueChanged(Sender);
  GridView.DoEditValueChanged(FEditingItem);
end;

procedure TcxGridEditingController.HideEdit(Accept: Boolean);
begin
  FController.CancelCheckEditPost;
  CancelEditUpdatePost;
  StopEditShowingTimer;
  if FEditHiding or not IsEditing then Exit;
  FEditHiding := True;
  try
    if Accept then
    begin
      if not FEdit.Deactivate then raise EAbort.Create('');
      GridView.DataController.PostEditingData;
      TcxCustomEditAccess(FEdit).Properties.Update(FEditingItem.GetProperties(Controller.FocusedRecord));
    end;
    EditingItem := nil;
    if GridView.Focused then GridView.TabStop := True;
    if FEdit <> nil then
    begin
      if FEdit.Focused and GridView.Focused then
      begin
        FEdit.EditModified := False;
        FEdit.OnFocusChanged := nil;
        FController.AllowCheckEdit := False;
        try
          FController.SetFocus;
        finally
          FController.AllowCheckEdit := True;
        end;
      end
      else
        Controller.InvalidateFocusedRecord;
      FEdit.Parent := nil;
      FEdit := nil;
    end;
    FIsErrorOnEditExit := False;
  finally
    FEditHiding := False;
  end;
end;

procedure TcxGridEditingController.RemoveEdit(AProperties: TcxCustomEditProperties);
begin
  if EditingProperties = AProperties then
    EditingItem := nil;
  FEditList.RemoveItem(AProperties);
end;

procedure TcxGridEditingController.ShowEdit(AItem: TcxCustomGridTableItem = nil);
begin
  if AItem = nil then AItem := FController.FocusedItem;
  if PrepareEdit(AItem, False) then FEdit.Activate(AItem.FEditData);
end;

procedure TcxGridEditingController.ShowEdit(AItem: TcxCustomGridTableItem; Key: Char);
begin
  if PrepareEdit(AItem, False) then FEdit.ActivateByKey(Key, AItem.FEditData);
end;

procedure TcxGridEditingController.ShowEdit(AItem: TcxCustomGridTableItem;
  Shift: TShiftState; X, Y: Integer);
begin
  if PrepareEdit(AItem, True) then FEdit.ActivateByMouse(Shift, X, Y, AItem.FEditData);
end;

procedure TcxGridEditingController.UpdateEdit;
var
  ACellViewInfo: TcxGridTableDataCellViewInfo;
begin
  if FEdit = nil then Exit;
  ACellViewInfo := FEditingItem.FocusedCellViewInfo;
  if ACellViewInfo = nil then Exit;
  with ACellViewInfo do
  begin
    if IsRectEmpty(Bounds) then Exit;
    if not FInitiatingEditing then
      if FEditPreparing then
        DoUpdateEdit
      else
        PostEditUpdate;
  end;
  FIsEditPlaced := True;
end;

procedure TcxGridEditingController.StartEditShowingTimer(AItem: TcxCustomGridTableItem);
begin
  StopEditShowingTimer;
  FEditShowingTimerItem := AItem;
  FEditShowingTimer := TTimer.Create(nil);
  with FEditShowingTimer do
  begin
    Interval := GetDblClickInterval;
    OnTimer := EditShowingTimerHandler;
  end;
end;

procedure TcxGridEditingController.StopEditShowingTimer;
begin
  FreeAndNil(FEditShowingTimer);
end;

(*{ TcxCustomGridDragOpenInfo }

function TcxCustomGridDragOpenInfo.Equals(AInfo: TcxCustomGridDragOpenInfo): Boolean;
begin
  Result := ClassType = AInfo.ClassType;
end;
*)
{ TcxGridDragOpenInfoExpand }

constructor TcxGridDragOpenInfoExpand.Create(AGridRecord: TcxCustomGridRecord);
begin
  inherited Create;
  GridRecord := AGridRecord;
end;

function TcxGridDragOpenInfoExpand.Equals(AInfo: TcxCustomGridDragOpenInfo): Boolean;
begin
  Result := inherited Equals(AInfo) and
    (GridRecord = TcxGridDragOpenInfoExpand(AInfo).GridRecord);
end;

procedure TcxGridDragOpenInfoExpand.Run;
begin
  GridRecord.Expand(False);
end;

{ TcxCustomGridTableController }

constructor TcxCustomGridTableController.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FAllowCheckEdit := True;
  FEditingController := GetEditingControllerClass.Create(Self);
  FFocusOnRecordFocusing := True;
end;

destructor TcxCustomGridTableController.Destroy;
begin
  CancelGridModeBufferCountUpdate;
  FreeAndNil(FEditingController);
  inherited;
end;

function TcxCustomGridTableController.GetEditingItem: TcxCustomGridTableItem;
begin
  Result := FEditingController.EditingItem;
end;

function TcxCustomGridTableController.GetFocusedItemIndex: Integer;
begin
  if FFocusedItem = nil then
    Result := -1
  else
    Result := FFocusedItem.VisibleIndex;
end;

function TcxCustomGridTableController.GetFocusedRecordIndex: Integer;
begin
  Result := DataController.GetFocusedRowIndex;
end;

function TcxCustomGridTableController.GetGridView: TcxCustomGridTableView;
begin
  Result := TcxCustomGridTableView(inherited GridView);
end;

function TcxCustomGridTableController.GetIncSearchingItem: TcxCustomGridTableItem;
begin
  if IsIncSearching then
    Result := GridView.Items[DataController.Search.ItemIndex]
  else
    Result := nil;
end;

function TcxCustomGridTableController.GetIncSearchingText: string;
begin
  Result := DataController.Search.SearchText;
end;

function TcxCustomGridTableController.GetIsEditing: Boolean;
begin
  Result := FEditingController.IsEditing;
end;

function TcxCustomGridTableController.GetIsIncSearching: Boolean;
begin
  Result := DataController.Search.Searching;
end;

function TcxCustomGridTableController.GetMasterController: TcxCustomGridTableController;
begin
  if GridView.IsDetail then
    Result := GridView.MasterGridView.Controller as TcxCustomGridTableController
  else
    Result := nil;
end;

function TcxCustomGridTableController.GetMultiSelect: Boolean;
begin
  Result := GridView.OptionsSelection.MultiSelect;
end;

function TcxCustomGridTableController.GetSelectedRecord(Index: Integer): TcxCustomGridRecord;
begin
  Index := DataController.GetSelectedRowIndex(Index);
  if Index = -1 then
    Result := nil
  else
    Result := ViewData.Records[Index];
end;

function TcxCustomGridTableController.GetSelectedRecordCount: Integer;
begin
  Result := DataController.GetSelectedCount;
end;

function TcxCustomGridTableController.GetViewData: TcxCustomGridTableViewData;
begin
  Result := TcxCustomGridTableViewData(inherited ViewData);
end;

function TcxCustomGridTableController.GetViewInfo: TcxCustomGridTableViewInfo;
begin
  Result := TcxCustomGridTableViewInfo(inherited ViewInfo);
end;

procedure TcxCustomGridTableController.SetDragHighlightedRecord(Value: TcxCustomGridRecord);
var
  APrevDragHighlightedRecord: TcxCustomGridRecord;
begin
  if FDragHighlightedRecord <> Value then
  begin
    APrevDragHighlightedRecord := FDragHighlightedRecord;
    FDragHighlightedRecord := Value;
    if APrevDragHighlightedRecord <> nil then
      APrevDragHighlightedRecord.Invalidate;
    if FDragHighlightedRecord <> nil then
      FDragHighlightedRecord.Invalidate;
  end;
end;

procedure TcxCustomGridTableController.SetEditingItem(Value: TcxCustomGridTableItem);
begin
  FEditingController.EditingItem := Value;
end;

procedure TcxCustomGridTableController.SetFocusedItem(Value: TcxCustomGridTableItem);
var
  APrevFocusedItem: TcxCustomGridTableItem;
begin
  if (Value <> nil) and not Value.CanFocus then Exit;
  if FFocusedItem <> Value then
  begin
    APrevFocusedItem := FFocusedItem;
    if (FFocusedItem <> nil) and not FEditingController.FEditingItemSetting then
      FEditingController.HideEdit(True);
    FFocusedItem := Value;
    FocusedItemChanged(APrevFocusedItem);
    CheckEdit;
  end
  else
    MakeFocusedItemVisible;
end;

procedure TcxCustomGridTableController.SetFocusedItemIndex(Value: Integer);
begin
  if (Value < -1) or (Value >= GridView.VisibleItemCount) then Exit;
  if Value = -1 then
    FocusedItem := nil
  else
    FocusedItem := GridView.VisibleItems[Value];
end;

procedure TcxCustomGridTableController.SetFocusedRecordIndex(Value: Integer);
var
  AIndexesAreEqual: Boolean;
begin
  if (0 <= Value) and (Value < ViewData.RecordCount) and
    not ViewData.Records[Value].CanFocus then Exit;
  AIndexesAreEqual := FocusedRecordIndex = Value;
  if not DataController.ChangeFocusedRowIndex(Value) then Exit;
  if FFocusOnRecordFocusing then
  begin
    if AIndexesAreEqual then MakeFocusedRecordVisible;
    if FocusedRecord <> nil then GridView.Focused := True;
  end;    
end;

procedure TcxCustomGridTableController.SetIncSearchingText(const Value: string);

  function GetItemIndex: Integer;
  begin
    if IsIncSearching then
      Result := IncSearchingItem.Index
    else
      if ItemForIncSearching = nil then
        Result := -1
      else
        Result := ItemForIncSearching.Index;
  end;

begin
  if (IncSearchingText <> Value) and (GetItemIndex <> -1) then
    if Value = '' then
      CancelIncSearching
    else
      DataController.Search.Locate(GetItemIndex, Value)
end;

procedure TcxCustomGridTableController.SetInternalTopRecordIndex(Value: Integer);
var
  ARecordCountDelta: Integer;

  //ft,lt: integer;

begin
  if FTopRecordIndex <> Value then
  begin

  //ft:=gettickcount;

    ARecordCountDelta := Value - FTopRecordIndex;  {2}
    FTopRecordIndex := Value;
    ViewInfo.AllowCheckCoordinates := False;
    try
      if Value <> -1 then
        if GridView.CanOffset(ARecordCountDelta) then
          GridView.Offset(ARecordCountDelta, 0, 0)  {2}
        else
          if GridView.IsMaster then
            GridView.SizeChanged(not GridView.IsDetail)
          {begin
            GridView.SizeChanged(True);
            if GridView.IsDetail and (GridView.MasterGridRecord <> nil) and
              (GridView.MasterGridRecord.ViewInfo <> nil) then
              GridView.MasterGridRecord.ViewInfo.Recalculate;
          end}
          else
            GridView.LayoutChanged;
    finally
      ViewInfo.AllowCheckCoordinates := True;
    end;
    GridView.DoTopRecordIndexChanged;

  {site.Update;
  lt:=gettickcount;
  application.MainForm.Caption := inttostr(lt-ft);}

  end;
end;  

procedure TcxCustomGridTableController.SetTopRecordIndex(Value: Integer);
begin
  CheckTopRecordIndex(Value);
  InternalTopRecordIndex := Value;
end;

procedure TcxCustomGridTableController.DragFocusingScrollTimerHandler(Sender: TObject);
begin
  FocusNextRecord(FocusedRecordIndex, FIsDragFocusingScrollForward, False, False);
  Site.Update;
end;

procedure TcxCustomGridTableController.DragScrollTimerHandler(Sender: TObject);
begin
  Site.ScrollContent(FDragScrollDirection);
  Site.Update;
end;

procedure TcxCustomGridTableController.GridModeBufferCountUpdateTimerHandler(Sender: TObject);
begin
  CheckGridModeBufferCountUpdatePost;
end;

procedure TcxCustomGridTableController.DoEnter;
begin
  inherited;
  CheckEdit;
end;

procedure TcxCustomGridTableController.DoExit;
begin
  if CancelEditingOnExit then
    DataController.Cancel
  else
    DataController.PostEditingData;
  inherited;
end;

procedure TcxCustomGridTableController.AfterPaint;
begin
  inherited;
  ProcessCheckEditPost;
end;

procedure TcxCustomGridTableController.BeforePaint;
begin
  inherited;
  FEditingController.CheckEditUpdatePost;
end;

procedure TcxCustomGridTableController.DetailFocused(ADetail: TcxCustomGridView);
var
  APrevFocusOnRecordFocusing: Boolean;
begin
  APrevFocusOnRecordFocusing := FFocusOnRecordFocusing;
  FFocusOnRecordFocusing := False;
  try
    inherited;
    FocusedRecordIndex := ADetail.MasterGridRecordIndex;
  finally
    FFocusOnRecordFocusing := APrevFocusOnRecordFocusing;
  end;
end;

function TcxCustomGridTableController.MayFocus: Boolean;
begin
  Result := inherited MayFocus and
    ((Site <> nil) and not Site.IsFocused or not IsEditing or
     not GridView.OptionsBehavior.AlwaysShowEditor and FEditingController.Edit.ValidateEdit(True));
end;

procedure TcxCustomGridTableController.RemoveFocus;
begin
  inherited;
  CheckFocusedRecordSelectionWhenExit(FocusedRecord);
  InvalidateFocusedRecord;
end;

procedure TcxCustomGridTableController.SetFocus;
begin
  if not FEditingController.CanRemoveEditFocus then Exit;
  inherited;
  InvalidateFocusedRecord;
  PostCheckEdit;
end;

procedure TcxCustomGridTableController.AfterOffset;
begin
  Site.PostMouseMove;
  FEditingController.UpdateEdit;
  FEditingController.AfterViewInfoCalculate;
  UpdateScrollBars;
end;

procedure TcxCustomGridTableController.BeforeKillFocus;
begin
  FEditingController.HideEdit(not GridView.IsDestroying);
  if not GridView.IsDestroying and DataController.IsEditing then
    DataController.Post;
  inherited;
end;

procedure TcxCustomGridTableController.BeforeOffset;
begin
  FEditingController.BeforeViewInfoCalculate;
end;

function TcxCustomGridTableController.CanAppend(ACheckOptions: Boolean): Boolean;
begin
  Result := (dceoAppend in DataController.EditOperations) and
    not (dceInsert in DataController.EditState) and
    (not ACheckOptions or GridView.OptionsData.Appending);
end;

procedure TcxCustomGridTableController.CancelCheckEditPost;
begin
  FCheckEditNeeded := False;
end;

function TcxCustomGridTableController.CanDelete(ACheckOptions: Boolean): Boolean;
begin
  Result := (dceoDelete in DataController.EditOperations) and
    (not ACheckOptions or GridView.OptionsData.Deleting);
end;

function TcxCustomGridTableController.CanEdit: Boolean;
begin
  Result := (FocusedItem <> nil) and GridView.OptionsData.Editing and
    ([dceoEdit, dceoShowEdit] * DataController.EditOperations = [dceoEdit, dceoShowEdit]);
end;

function TcxCustomGridTableController.CanHScrollBarHide: Boolean;
begin       
  Result := not ViewInfo.NavigatorSiteViewInfo.Visible;
end;

function TcxCustomGridTableController.CanInsert(ACheckOptions: Boolean): Boolean;
begin
  Result := (dceoInsert in DataController.EditOperations) and
    (not ACheckOptions or GridView.OptionsData.Inserting);
end;

procedure TcxCustomGridTableController.CheckEdit;
begin
  CancelCheckEditPost;
  if FAllowCheckEdit and GridView.OptionsBehavior.AlwaysShowEditor then
    if FEditingController.IsEditing and
      (FEditingController.EditingItem.FocusedCellViewInfo = nil) then
      FEditingController.HideEdit(False)
    else
      FEditingController.ShowEdit;
end;

procedure TcxCustomGridTableController.CheckCoordinates;
begin
  TopRecordIndex := TopRecordIndex;
end;

procedure TcxCustomGridTableController.CheckTopRecordIndex(var Value: Integer);
var
  AIsGridMode: Boolean;
  AMaxValue: Integer;
begin
  if FCheckingCoordinate then Exit;
  FCheckingCoordinate := True;
  try
    AIsGridMode := DataController.IsGridMode;
    if Value < 0 then
    begin
      if AIsGridMode and not DataController.IsBOF and
        not (dceInsert in DataController.EditState) then
        DataController.Scroll(Value);
      Value := 0;
    end;
    if Value > ViewData.RecordCount - 1 then
    begin
      if AIsGridMode and not DataController.IsEOF then
        DataController.Scroll(Value - (ViewData.RecordCount - 1));
      Value := ViewData.RecordCount - 1;
    end;
    if (Value <= 0) or not AIsGridMode and (Value = TopRecordIndex) and
      (ViewInfo.VisibleRecordCount < ViewData.RecordCount - Value) then Exit;
    AMaxValue := GetMaxTopRecordIndexValue;
    if Value > AMaxValue then
    begin
      if AIsGridMode and not FIsCheckingCoordinates and
        not DataController.IsEOF and not (dceInsert in DataController.EditState) then
      begin
        DataController.Scroll(Value - AMaxValue);
        AMaxValue := GetMaxTopRecordIndexValue;
      end;
      Value := AMaxValue;
    end;
  finally
    FCheckingCoordinate := False;
  end;
end;

function TcxCustomGridTableController.FindNextCustomItem(AFocusedItemIndex, AItemCount: Integer;
  AGoForward, AGoOnCycle: Boolean; ACanFocus: TcxCustomGridTableCanItemFocus;
  AData: Pointer; var AItemIndex: Integer; out ACycleChanged: Boolean): Boolean;
var
  AFromIndex: Integer;

  function GetFromIndex: Integer;
  begin
    if AFocusedItemIndex = -1 then
      if AGoForward then
        Result := 0
      else
        if AGoOnCycle then
          Result := AItemCount - 1
        else
          Result := -1
    else
      if AGoForward then
        Result := AFocusedItemIndex + 1
      else
        Result := AFocusedItemIndex - 1;
  end;

  function CheckIndex(var AIndex: Integer): Boolean;
  begin
    Result := True;
    if AGoForward then
      if AIndex > AItemCount - 1 then
        if AGoOnCycle then
        begin
          AIndex := 0;
          ACycleChanged := True;
        end
        else
          Result := False
      else
    else
      if AIndex < 0 then
        if AGoOnCycle then
        begin
          AIndex := AItemCount - 1;
          ACycleChanged := True;
        end
        else
          Result := False;
  end;

  procedure GetNextIndex(var AIndex: Integer);
  begin
    if AGoForward then
      Inc(AIndex)
    else
      Dec(AIndex);
  end;

begin
  Result := False;
  ACycleChanged := False;
  if AItemCount = 0 then Exit;
  AFromIndex := GetFromIndex;
  AItemIndex := AFromIndex;
  repeat
    if not CheckIndex(AItemIndex) then Exit;
    if (AItemIndex = AFocusedItemIndex) and not ACycleChanged then Exit;
    Result := ACanFocus(GridView, AItemIndex, AData);
    if Result or (AItemIndex = AFocusedItemIndex) and ACycleChanged then Exit;
    GetNextIndex(AItemIndex);
  until (AItemIndex = AFromIndex) or (AItemIndex = -1) and (AFocusedItemIndex = -1);
end;

procedure TcxCustomGridTableController.FocusedItemChanged(APrevFocusedItem: TcxCustomGridTableItem);
begin
  if GridView.IsLoading or GridView.IsDestroying then Exit;
  CancelIncSearching;
  MakeFocusedItemVisible;
  if FocusedRecord <> nil then
  begin
    FocusedRecord.Invalidate(APrevFocusedItem);
    FocusedRecord.Invalidate(FocusedItem);
  end;
  if (APrevFocusedItem = nil) or (FocusedItem = nil) then
    GridView.RefreshNavigators;
  GridView.FocusedItemChanged(APrevFocusedItem, FFocusedItem);
end;

function TcxCustomGridTableController.GetCancelEditingOnExit: Boolean;
begin
  Result :=
    GridView.OptionsData.CancelOnExit and
    (DataController.EditState * [dceInsert, dceChanging, dceModified] = [dceInsert]);
end;

function TcxCustomGridTableController.GetFocusedRecord: TcxCustomGridRecord;
begin
  if (0 <= FocusedRecordIndex) and (FocusedRecordIndex < ViewData.RecordCount) then
    Result := ViewData.Records[FocusedRecordIndex]
  else
    Result := nil;
end;

function TcxCustomGridTableController.GetMaxTopRecordIndexValue: Integer;
begin
  Result := ViewData.RecordCount -
    GetVisibleRecordCount(ViewData.RecordCount - 1, False);
end;

function TcxCustomGridTableController.GetScrollBarOffsetBegin: Integer;
begin
  if DataController.IsGridMode then
    Result := Ord(not DataController.IsBOF)
  else
    Result := 0;
end;

function TcxCustomGridTableController.GetScrollBarOffsetEnd: Integer;
begin
  if DataController.IsGridMode then
    Result := Ord(not DataController.IsEOF)
  else
    Result := 0;
end;

function TcxCustomGridTableController.GetScrollBarPos: Integer;
var
  AIcxGridDataController: IcxGridDataController;
begin
  if DataController.GetInterface(IcxGridDataController, AIcxGridDataController) then
    Result := AIcxGridDataController.GetScrollBarPos
  else
    Result := -1;
  if Result = -1 then
    Result := ScrollBarOffsetBegin + TopRecordIndex;
end;

function TcxCustomGridTableController.GetScrollBarRecordCount: Integer;
var
  AIcxGridDataController: IcxGridDataController;
begin
  if DataController.GetInterface(IcxGridDataController, AIcxGridDataController) then
    Result := AIcxGridDataController.GetScrollBarRecordCount
  else
    Result := -1;
  if Result = -1 then
    Result := ViewData.RecordCount + ScrollBarOffsetBegin + ScrollBarOffsetEnd;
end;

function TcxCustomGridTableController.GetVisibleRecordCount(AFirstRecordIndex: Integer;
  ACalculateDown: Boolean = True): Integer;
var
  AVisibleEqualHeightRecordCount: Integer;
  AViewInfo: TcxCustomGridTableViewInfo;

  function CanCalculateVisibleEqualHeightRecordCount: Boolean;
  begin
    AVisibleEqualHeightRecordCount := ViewInfo.CalculateVisibleEqualHeightRecordCount;
    Result := AVisibleEqualHeightRecordCount <> -1;
  end;

begin
  if IsRectEmpty(ViewInfo.Bounds) then
    Result := 0
  else
    if GridView.IsEqualHeightRecords and CanCalculateVisibleEqualHeightRecordCount then
    begin  {3} // -2-4 ms
      Result := AVisibleEqualHeightRecordCount;
      if ACalculateDown then
        if AFirstRecordIndex + Result > ViewData.RecordCount then
          Result := ViewData.RecordCount - AFirstRecordIndex
        else
      else
        if AFirstRecordIndex - Result + 1 < 0 then
          Result := AFirstRecordIndex + 1;
    end
    else
    begin
      AViewInfo :=
        TcxCustomGridTableViewInfo(GridView.GetViewInfoClass.Create(GridView));
      try
        AViewInfo.CalculateDown := ACalculateDown;
        AViewInfo.FirstRecordIndex := AFirstRecordIndex;
        AViewInfo.MainCalculate(ViewInfo.Bounds);
        Result := AViewInfo.VisibleRecordCount;
      finally
        AViewInfo.Free;
      end;
    end;
end;

procedure TcxCustomGridTableController.PostCheckEdit;
begin
  if FAllowCheckEdit then FCheckEditNeeded := True;
end;

procedure TcxCustomGridTableController.ProcessCheckEditPost;
begin
  if FCheckEditNeeded then CheckEdit;
end;

procedure TcxCustomGridTableController.SetFocusedRecord(Value: TcxCustomGridRecord);
begin
  if Value = nil then
    FocusedRecordIndex := -1
  else
    FocusedRecordIndex := Value.Index;
end;

procedure TcxCustomGridTableController.SetScrollBarPos(Value: Integer);
var
  AIcxGridDataController: IcxGridDataController;
begin
  if not DataController.GetInterface(IcxGridDataController, AIcxGridDataController) or
    not AIcxGridDataController.SetScrollBarPos(Value) then
    if DataController.IsGridMode then
      TopRecordIndex := Value - ScrollBarOffsetBegin
    else
      InternalTopRecordIndex := Value;
end;

procedure TcxCustomGridTableController.CancelGridModeBufferCountUpdate;
begin
  FGridModeBufferCountUpdateNeeded := False;
  FreeAndNil(FGridModeBufferCountUpdateTimer);
end;

procedure TcxCustomGridTableController.CheckGridModeBufferCountUpdatePost;
begin
  if FGridModeBufferCountUpdateNeeded and ViewInfo.Calculated then
  begin
    CancelGridModeBufferCountUpdate;
    (DataController as IcxGridDataController).CheckGridModeBufferCount;
  end;
end;

procedure TcxCustomGridTableController.PostGridModeBufferCountUpdate;
begin
  if DataController.IsGridMode and not FGridModeBufferCountUpdateNeeded then
  begin
    FGridModeBufferCountUpdateNeeded := True;
    FGridModeBufferCountUpdateTimer := TTimer.Create(nil);
    with FGridModeBufferCountUpdateTimer do
    begin
      Interval := 1;
      OnTimer := GridModeBufferCountUpdateTimerHandler;
    end;
  end;
end;

function TcxCustomGridTableController.CanProcessMultiSelect(AIsKeyboard: Boolean): Boolean;
begin
  Result := MultiSelect and (not AIsKeyboard or GridView.Focused);
end;

function TcxCustomGridTableController.CanProcessMultiSelect(AHitTest: TcxCustomGridHitTest): Boolean;
begin
  Result := CanProcessMultiSelect(False) and (AHitTest is TcxGridRecordHitTest) and
    (TcxGridRecordHitTest(AHitTest).GridRecord <> nil) and
    TcxGridRecordHitTest(AHitTest).GridRecord.Focused and
    TcxGridRecordHitTest(AHitTest).CanClick;
end;

function TcxCustomGridTableController.CanProcessMultiSelect(AKey: Word;
  AShift: TShiftState; AFocusedRecordChanged: Boolean): Boolean;
begin
  Result := CanProcessMultiSelect(True) and
    IsKeyForMultiSelect(AKey, AShift, AFocusedRecordChanged);
end;

procedure TcxCustomGridTableController.ChangeRecordSelection(ARecord: TcxCustomGridRecord;
  Value: Boolean);
begin
  if MultiSelect then
    DataController.ChangeRowSelection(ARecord.Index, Value);
end;

procedure TcxCustomGridTableController.CheckFocusedRecordSelectionWhenExit(ARecord: TcxCustomGridRecord);
begin
  if GridView.OptionsSelection.UnselectFocusedRecordOnExit and
    MultiSelect and (ARecord <> nil) and (SelectedRecordCount = 1) and ARecord.Selected then
    ARecord.Selected := False;
end;

procedure TcxCustomGridTableController.DoNormalSelection;
begin
  if (SelectedRecordCount = 1) and (SelectedRecords[0] = FocusedRecord) then
    Exit;
  BeginUpdate;
  try
    ClearSelection;
    if FocusedRecord <> nil then
      FocusedRecord.Selected := True;
  finally
    EndUpdate;
  end;
end;

procedure TcxCustomGridTableController.DoNormalSelectionWithAnchor(ASelect: Boolean = True);
begin
  SetSelectionAnchor(FocusedRecordIndex);
  if ASelect then DoNormalSelection;
end;

procedure TcxCustomGridTableController.DoRangeSelection(AClearSelection: Boolean = True);
begin
  if (FocusedRecordIndex <> -1) and not (dceInsert in DataController.EditState) then
    DataController.SelectFromAnchor(FocusedRecordIndex, not AClearSelection);
end;

procedure TcxCustomGridTableController.DoToggleRecordSelection;
begin
  if FocusedRecord <> nil then
    with FocusedRecord do
      Selected := not Selected;
end;

procedure TcxCustomGridTableController.FinishSelection;
begin
  FIsRecordUnselecting := False;
end;

procedure TcxCustomGridTableController.InvalidateFocusedRecord;
begin
  if FocusedRecord <> nil then FocusedRecord.Invalidate;
end;

procedure TcxCustomGridTableController.InvalidateSelection;
var
  I: Integer;
  ARecord: TcxCustomGridRecord;
begin
  for I := 0 to SelectedRecordCount - 1 do
  begin
    ARecord := SelectedRecords[I];
    if ARecord <> nil then ARecord.Invalidate;
  end;    
  InvalidateFocusedRecord;
end;

function TcxCustomGridTableController.IsKeyForMultiSelect(AKey: Word;
  AShift: TShiftState; AFocusedRecordChanged: Boolean): Boolean;
begin
  Result := (AKey = VK_SPACE) or (AKey = VK_PRIOR) or (AKey = VK_NEXT) or
    AFocusedRecordChanged;
end;

function TcxCustomGridTableController.IsRecordSelected(ARecord: TcxCustomGridRecord): Boolean;
begin
  Result := DataController.IsRowSelected(ARecord.Index);
end;

procedure TcxCustomGridTableController.MultiSelectKeyDown(var Key: Word; Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Key = VK_SPACE) then
  begin
    DoToggleRecordSelection;
    FEatKeyPress := True;
  end
  else
    if (ssShift in Shift) and (Key <> 0) then
      DoRangeSelection
    else
      DoNormalSelectionWithAnchor(Shift <> [ssCtrl]);
end;

procedure TcxCustomGridTableController.MultiSelectMouseDown(AHitTest: TcxCustomGridHitTest;
  AShift: TShiftState);
var
  APressedRecord: TcxCustomGridRecord;
  ASelectionShift: TShiftState;

  procedure AssignSelectionAnchor;
  begin
    if (ASelectionShift = []) or (ASelectionShift = [ssCtrl]) then
      SetSelectionAnchor(APressedRecord.Index);
  end;

  function MustPostponeDoing: Boolean;
  begin
    Result := APressedRecord.Selected and not (ssDouble in AShift);
  end;

  procedure PostponeDoing;
  begin
    FIsRecordUnselecting := True;
    FUnselectingRecordIndex := APressedRecord.Index;
  end;

  procedure ProcessRecordSelectionToggling;
  begin
    if MustPostponeDoing then
      PostponeDoing
    else
      DoToggleRecordSelection;
  end;

  procedure ProcessNormalSelection;
  begin
    if MustPostponeDoing then
      PostponeDoing
    else
      DoNormalSelection;
  end;

begin
  APressedRecord := TcxGridRecordHitTest(AHitTest).GridRecord;
  ASelectionShift := AShift - [ssLeft, ssRight, ssMiddle, ssDouble];
  AssignSelectionAnchor;
  if ASelectionShift = [ssCtrl] then
    ProcessRecordSelectionToggling
  else
    if (ASelectionShift = [ssShift]) or (ASelectionShift = [ssCtrl, ssShift]) then
      DoRangeSelection(not (ssCtrl in AShift))
    else
      ProcessNormalSelection;
end;

procedure TcxCustomGridTableController.MultiSelectMouseUp(AHitTest: TcxCustomGridHitTest;
  AShift: TShiftState);
var
  ASelectionShift: TShiftState;
begin
  if FIsRecordUnselecting and
    (FUnselectingRecordIndex = TcxGridRecordHitTest(AHitTest).GridRecord.Index) then
  begin
    ASelectionShift := AShift - [ssLeft, ssRight, ssMiddle, ssDouble];
    if ASelectionShift = [ssCtrl] then
      DoToggleRecordSelection
    else
      DoNormalSelection;
  end;
end;

procedure TcxCustomGridTableController.SetSelectionAnchor(AGridRecordIndex: Integer);
begin
  if AGridRecordIndex <> -1 then
    DataController.SetSelectionAnchor(AGridRecordIndex);
end;

function TcxCustomGridTableController.FocusedRecordHasCells(ACheckCellSelect: Boolean): Boolean;
begin
  Result := (FocusedRecord <> nil) and FocusedRecord.HasCells and
    (not ACheckCellSelect or GridView.OptionsSelection.CellSelect);
end;

procedure TcxCustomGridTableController.FocusNextPage(ASyncSelection: Boolean);
begin
  MakeFocusedRecordVisible;
  if FocusedRecordIndex = TopRecordIndex + ViewInfo.VisibleRecordCount - 1 then
    ShowNextPage;
  FocusRecord(TopRecordIndex + ViewInfo.VisibleRecordCount - 1, ASyncSelection);
end;

procedure TcxCustomGridTableController.FocusPrevPage(ASyncSelection: Boolean);
begin
  MakeFocusedRecordVisible;
  if FocusedRecordIndex = TopRecordIndex then
    ShowPrevPage;
  FocusRecord(TopRecordIndex, ASyncSelection);
end;

function TcxCustomGridTableController.IsKeyForController(AKey: Word; AShift: TShiftState): Boolean;
begin
  Result :=
    (AKey = VK_TAB) or (AKey = VK_UP) or (AKey = VK_DOWN) or (AKey = VK_PRIOR) or
    (AKey = VK_NEXT) or (AKey = VK_INSERT) or (AKey = VK_ESCAPE);
  if not Result and GridView.OptionsBehavior.AlwaysShowEditor then
    Result := (AKey = VK_LEFT) or (AKey = VK_RIGHT);
end;

procedure TcxCustomGridTableController.ScrollPage(AForward: Boolean);
var
  AIcxGridDataController: IcxGridDataController;
begin
  if not DataController.GetInterface(IcxGridDataController, AIcxGridDataController) or
    not AIcxGridDataController.DoScrollPage(AForward) then
    if AForward then
      ShowNextPage
    else
      ShowPrevPage;
end;

procedure TcxCustomGridTableController.ScrollRecords(AForward: Boolean; ACount: Integer);
var
  AIcxGridDataController: IcxGridDataController;
begin
  if not DataController.GetInterface(IcxGridDataController, AIcxGridDataController) or
    not AIcxGridDataController.DoScroll(AForward) then
    if AForward then
      TopRecordIndex := TopRecordIndex + ACount
    else
      TopRecordIndex := TopRecordIndex - ACount;
end;

procedure TcxCustomGridTableController.ShowNextPage;
begin
  TopRecordIndex := TopRecordIndex + ViewInfo.VisibleRecordCount;
end;

procedure TcxCustomGridTableController.ShowPrevPage;
begin
  TopRecordIndex := TopRecordIndex - ViewInfo.VisibleRecordCount;
end;

function TcxCustomGridTableController.GetDragFocusingScrollDirection(X, Y: Integer;
  out AMoveForward: Boolean): Boolean;
var
  R: TRect;
begin
  Result := False;
  R := ViewInfo.RecordsViewInfo.Bounds;
  if IsRecordsScrollHorizontal and (X < R.Left) or
    not IsRecordsScrollHorizontal and (Y < R.Top) then
  begin
    AMoveForward := False;
    Result := True;
  end;
  if IsRecordsScrollHorizontal and (X >= R.Right) or
    not IsRecordsScrollHorizontal and (Y >= R.Bottom) then
  begin
    AMoveForward := True;
    Result := True;
  end;
end;

procedure TcxCustomGridTableController.StartDragFocusing;
begin
  FIsDragFocusing := True;
  FDragFocusingMousePos := ViewInfo.MousePos;// Point(-1, -1);
end;

procedure TcxCustomGridTableController.StopDragFocusing;
begin
  StopDragFocusingScroll;
  FIsDragFocusing := False;
end;

procedure TcxCustomGridTableController.StartDragFocusingScroll(AMoveForward: Boolean);
begin
  FIsDragFocusingScrollForward := AMoveForward;
  if FDragFocusingScrollTimer <> nil then Exit;
  FDragFocusingScrollTimer := TTimer.Create(nil);
  with FDragFocusingScrollTimer do
  begin
    Interval := DragFocusingScrollTimeInterval;
    OnTimer := DragFocusingScrollTimerHandler;
  end;
end;

procedure TcxCustomGridTableController.StopDragFocusingScroll;
begin
  FreeAndNil(FDragFocusingScrollTimer);
end;

function TcxCustomGridTableController.GetDragScrollDirection(X, Y: Integer): TcxDirection;
const
  ADirections: array[Boolean, Boolean] of TcxDirection = ((dirUp, dirDown), (dirLeft, dirRight));
var
  AHitTest: TcxCustomGridHitTest;
begin
  Result := dirNone;
  AHitTest := ViewInfo.GetHitTest(X, Y);
  if AHitTest is TcxGridRecordHitTest then
    with TcxGridRecordHitTest(AHitTest).GridRecord do
      if Index = TopRecordIndex then
        Result := ADirections[IsRecordsScrollHorizontal, False]
      else
        if ViewInfo.Index >= Self.ViewInfo.RecordsViewInfo.VisibleCount - 1 then
          Result := ADirections[IsRecordsScrollHorizontal, True];
end;

procedure TcxCustomGridTableController.ProcessDragFocusing(X, Y: Integer);
var
  AHitTest: TcxCustomGridHitTest;
begin
  AHitTest := ViewInfo.GetHitTest(X, Y);
  if AHitTest is TcxGridRecordHitTest then
    TcxGridRecordHitTest(AHitTest).GridRecord.Focused := True
  else
    if AHitTest is TcxCustomGridViewHitTest then
      TcxCustomGridViewHitTest(AHitTest).GridView.Focused := True;
end;

procedure TcxCustomGridTableController.StartDragScroll(ADirection: TcxDirection);
begin
  FDragScrollDirection := ADirection;
  if FDragScrollTimer <> nil then Exit;
  FDragScrollTimer := TTimer.Create(nil);
  with FDragScrollTimer do
  begin
    Interval := DragScrollTimeInterval;
    OnTimer := DragScrollTimerHandler;
  end;
end;

procedure TcxCustomGridTableController.StopDragScroll;
begin
  FreeAndNil(FDragScrollTimer);
end;

function TcxCustomGridTableController.IsDragScroll: Boolean;
begin
  Result := FDragScrollTimer <> nil;
end;

function TcxCustomGridTableController.GetDragOpenInfo(AHitTest: TcxCustomGridHitTest): TcxCustomGridDragOpenInfo;
begin
  if AHitTest.HitTestCode = htExpandButton then
    Result := TcxGridDragOpenInfoExpand.Create(TcxGridExpandButtonHitTest(AHitTest).GridRecord)
  else
    Result := nil;
end;

function TcxCustomGridTableController.IsDragOpenHitTest(AHitTest: TcxCustomGridHitTest;
  out ADragOpenInfo: TcxCustomGridDragOpenInfo): Boolean;
begin
  ADragOpenInfo := GetDragOpenInfo(AHitTest);
  Result := ADragOpenInfo <> nil;
end;

function TcxCustomGridTableController.GetItemForIncSearching: TcxCustomGridTableItem;
begin
  if GridView.OptionsSelection.CellSelect then
    Result := FocusedItem
  else
  begin
    Result := GridView.OptionsBehavior.IncSearchItem;
    if (Result = nil) and (GridView.VisibleItemCount <> 0) then
      Result := GridView.VisibleItems[0];
  end;
end;

procedure TcxCustomGridTableController.IncSearchKeyDown(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE:
      begin
        CancelIncSearching;
        Key := 0;
      end;
    VK_BACK:
      begin
        IncSearchingText := Copy(IncSearchingText, 1, Length(IncSearchingText) - 1);
        Key := 0;
      end;
    VK_UP, VK_DOWN:
      if Shift = [ssCtrl] then
      begin
        DataController.Search.LocateNext(Key = VK_DOWN);
        Key := 0;
      end;
  end;
end;

function TcxCustomGridTableController.GetEditingControllerClass: TcxGridEditingControllerClass;
begin
  Result := TcxGridEditingController;
end;

procedure TcxCustomGridTableController.BeginDragAndDrop;
begin
  FEditingController.HideEdit(True);
  inherited;
end;

procedure TcxCustomGridTableController.ControlFocusChanged;
begin
  inherited;
  InvalidateSelection;
end;

procedure TcxCustomGridTableController.DoCancelMode;
begin
  inherited;
  StopDragFocusing;
  FinishSelection;
end;

procedure TcxCustomGridTableController.DoKeyDown(var Key: Word; Shift: TShiftState);
var
  AGridView: TcxCustomGridTableView;
  APrevTopRecordIndex, APrevFocusedRecordIndex: Integer;
begin
  APrevTopRecordIndex := TopRecordIndex;
  AGridView := GridView;
  AGridView.AddListenerLink(@AGridView);
  try
    if IsIncSearching then
    begin
      IncSearchKeyDown(Key, Shift);
      if AGridView = nil then Exit;
    end;
    APrevFocusedRecordIndex := FocusedRecordIndex;
    inherited;
    if AGridView <> nil then
      if CanProcessMultiSelect(Key, Shift, FocusedRecordIndex <> APrevFocusedRecordIndex) then
        MultiSelectKeyDown(Key, Shift);
  finally
    if AGridView <> nil then
    begin
      AGridView.RemoveListenerLink(@AGridView);
      if TopRecordIndex <> APrevTopRecordIndex then
        Site.Update;
    end
    else
      Key := 0;
  end;
end;

procedure TcxCustomGridTableController.EndDragAndDrop(Accepted: Boolean);
begin
  inherited;
  CheckEdit;
end;

function TcxCustomGridTableController.FindNextItem(AFocusedItemIndex: Integer;
  AGoForward, AGoOnCycle: Boolean; out ACycleChanged: Boolean): Integer;

  function CanFocusItem(AOwner: TcxCustomGridTableView; AItemIndex: Integer;
    AData: Pointer): Boolean;
  begin
    Result := AOwner.VisibleItems[AItemIndex].CanFocus;
  end;

begin
  if not FindNextCustomItem(AFocusedItemIndex, GridView.VisibleItemCount,
    AGoForward, AGoOnCycle, @CanFocusItem, nil, Result, ACycleChanged) then
    Result := -1;
end;

function TcxCustomGridTableController.FindNextRecord(AFocusedRecordIndex: Integer;
  AGoForward, AGoOnCycle: Boolean; out ACycleChanged: Boolean): Integer;

  function CanFocusRecord(AOwner: TcxCustomGridTableView; AItemIndex: Integer;
    AData: Pointer): Boolean;
  begin
    Result := AOwner.ViewData.Records[AItemIndex].CanFocus;
  end;

begin
  if DataController.IsGridMode then
    if AGoForward then
      if not DataController.IsEOF and (AFocusedRecordIndex = ViewData.RecordCount - 1) then
      begin
        DataController.Scroll(1);
        if not DataController.IsEOF then
          Dec(AFocusedRecordIndex);
      end
      else
    else
      if (AFocusedRecordIndex = 0) and not DataController.IsBOF then
      begin
        DataController.Scroll(-1);
        if not DataController.IsBOF then
          Inc(AFocusedRecordIndex);
      end;
  if not FindNextCustomItem(AFocusedRecordIndex, ViewData.RecordCount, AGoForward,
    AGoOnCycle, @CanFocusRecord, nil, Result, ACycleChanged) then
    Result := -1;
end;

function TcxCustomGridTableController.HasFocusedControls: Boolean;
begin
  Result := inherited HasFocusedControls or
    {IsEditing}(FEditingController.Edit <> nil) and FEditingController.Edit.IsFocused;
end;

function TcxCustomGridTableController.IsDataFullyVisible(AIsCallFromMaster: Boolean = False): Boolean;
begin
  Result := ViewInfo.VisibleRecordCount = ViewData.RecordCount;
end;

procedure TcxCustomGridTableController.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if not FBlockRecordKeyboardHandling and (FocusedRecord <> nil) then
    FocusedRecord.KeyDown(Key, Shift);
  case Key of
    VK_INSERT:
      if (Shift = []) and CanInsert(True) then
        CreateNewRecord(False);
    VK_DELETE:
      if ((Shift = []) or (Shift = [ssCtrl])) and CanDelete(True) then
      begin
        DeleteSelection;
        Key := 0;
      end;
    VK_ESCAPE:
      if DataController.IsEditing then
      begin
        DataController.Cancel;
        if not DataController.IsEditing and MultiSelect and (FocusedRecord <> nil) then
          FocusedRecord.Selected := True;
      end;
    VK_RETURN, VK_TAB:
      if ((Key = VK_RETURN) and GridView.OptionsBehavior.GoToNextCellOnEnter or
        (Key = VK_TAB) and GridView.OptionsBehavior.FocusCellOnTab) and
        (Shift + [ssShift] = [ssShift]) then
      begin
        FocusNextCell(Shift = [], False);
        Key := 0;
      end;
    VK_PRIOR:
      FocusPrevPage(False);
    VK_NEXT:
      FocusNextPage(False);
    Ord('A'):
      if Shift = [ssCtrl] then
        DataController.SelectAll;
  end;
end;

procedure TcxCustomGridTableController.KeyPress(var Key: Char);
begin
  inherited;
  if FEatKeyPress then
  begin
    FEatKeyPress := False;
    Exit;
  end;
  if (Key in IncSearchStartChars) and
    (ItemForIncSearching <> nil) and ItemForIncSearching.CanIncSearch and
    not DataController.IsEditing then
  begin
    if Key <> #8 then
      IncSearchingText := IncSearchingText + Key;
    Key := #0;
  end;
  if FocusedRecord <> nil then
    FocusedRecord.DoKeyPress(Key);
end;

procedure TcxCustomGridTableController.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  AHitTest: TcxCustomGridHitTest;
  AGridView: TcxCustomGridTableView;
begin
  FEditingController.StopEditShowingTimer;
  AHitTest := ViewInfo.GetHitTest(X, Y);
  AGridView := GridView;
  AGridView.AddListenerLink(@AGridView);
  try
    inherited;
  finally
   //AHitTest := ViewInfo.GetHitTest(X, Y);
    if AGridView <> nil then
    begin
      AGridView.RemoveListenerLink(@AGridView);
      if CanProcessMultiSelect(AHitTest) then
        MultiSelectMouseDown(AHitTest, Shift);
      if (AHitTest is TcxGridRecordHitTest) and GridView.OptionsBehavior.PullFocusing and
        Site.MouseCapture then
        StartDragFocusing;
    end;
  end;  
end;

procedure TcxCustomGridTableController.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  AViewInfo: TcxCustomGridHitTest;
  AMoveForward: Boolean;
begin
  inherited;
  if FIsDragFocusing then
  begin
    AViewInfo := ViewInfo.GetHitTest(X, Y);
    if AViewInfo is TcxGridRecordHitTest then
      if (FDragFocusingMousePos.X <> X) or (FDragFocusingMousePos.Y <> Y) then
      begin
        StopDragFocusingScroll;
        TcxGridRecordHitTest(AViewInfo).GridRecord.Focused := True;
        Site.Update;
      end
      else
    else
      if GetDragFocusingScrollDirection(X, Y, AMoveForward) then
        StartDragFocusingScroll(AMoveForward);
    FDragFocusingMousePos := Point(X, Y);
  end;
end;

procedure TcxCustomGridTableController.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  AHitTest: TcxCustomGridHitTest;
begin
  inherited;
  StopDragFocusing;
  AHitTest := ViewInfo.GetHitTest(X, Y);
  if (Button = mbLeft) and CanProcessMultiSelect(AHitTest) then
    MultiSelectMouseUp(AHitTest, Shift);
  FinishSelection;
end;

procedure TcxCustomGridTableController.WndProc(var Message: TMessage);
begin
  inherited;
  {case Message.Msg of
    WM_IME_STARTCOMPOSITION:
      FEditingController.ShowEdit;
  end;}
end;

procedure TcxCustomGridTableController.BeforeStartDrag;
begin
  inherited;
  if DataController.IsEditing then
    if dceModified in DataController.EditState then
      DataController.Post
    else
      DataController.Cancel;
end;

function TcxCustomGridTableController.CanDrag(X, Y: Integer): Boolean;
begin
  Result := inherited CanDrag(X, Y) and
    (ViewInfo.GetHitTest(X, Y) is TcxGridRecordHitTest);
end;

procedure TcxCustomGridTableController.DragDrop(Source: TObject; X, Y: Integer);
begin
  if GridView.OptionsBehavior.DragFocusing = dfDragDrop then
    ProcessDragFocusing(X, Y);
  inherited;
end;

procedure TcxCustomGridTableController.DragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);

  procedure ProcessScrolling;
  var
    ADirection: TcxDirection;
  begin
    ADirection := GetDragScrollDirection(X, Y);
    if (ADirection = dirNone) or (State = dsDragLeave) then
      StopDragScroll
    else
      StartDragScroll(ADirection);
  end;

  procedure ProcessOpening;
  var
    AHitTest: TcxCustomGridHitTest;
    ADragOpenInfo: TcxCustomGridDragOpenInfo;
  begin
    AHitTest := ViewInfo.GetHitTest(X, Y);
    if (State <> dsDragLeave) and IsDragOpenHitTest(AHitTest, ADragOpenInfo) then
      TcxCustomGrid(Control).Controller.StartDragOpen(ADragOpenInfo)
    else
      TcxCustomGrid(Control).Controller.StopDragOpen;
  end;

  procedure ProcessDragHighlighting;
  var
    AHitTest: TcxCustomGridHitTest;
  begin
    AHitTest := ViewInfo.GetHitTest(X, Y);
    if (State <> dsDragLeave) and (AHitTest is TcxGridRecordHitTest) then
      DragHighlightedRecord := TcxGridRecordHitTest(AHitTest).GridRecord
    else
      DragHighlightedRecord := nil;
  end;

begin
  inherited;
  if GridView.OptionsBehavior.DragScrolling then
    ProcessScrolling;
  if GridView.OptionsBehavior.DragOpening then
    ProcessOpening;
  if GridView.OptionsBehavior.DragHighlighting then
    ProcessDragHighlighting;
  if (State <> dsDragLeave) and (GridView.OptionsBehavior.DragFocusing = dfDragOver) then
    ProcessDragFocusing(X, Y);
end;

procedure TcxCustomGridTableController.EndDrag(Target: TObject; X, Y: Integer);
begin
  DragHighlightedRecord := nil;
  TcxCustomGrid(Control).Controller.StopDragOpen;
  StopDragScroll;
  inherited;
end;

procedure TcxCustomGridTableController.StartDrag(var DragObject: TDragObject);

  function GetCursor: TCursor;
  begin
    if SelectedRecordCount > 1 then
      Result := crcxGridMultiDrag
    else
      Result := crcxGridDrag;
  end;

begin
  inherited;
  TcxGridSiteAccess(Site).DragCursor := GetCursor;
end;

procedure TcxCustomGridTableController.CancelIncSearching;
begin
  DataController.Search.Cancel;
end;

procedure TcxCustomGridTableController.ClearSelection;
begin
  DataController.ClearSelection;
end;

procedure TcxCustomGridTableController.CreateNewRecord(AtEnd: Boolean);
var
  AIsEditing: Boolean;
begin
  AIsEditing := IsEditing;
  if AtEnd then
    if CanAppend(False) then
      DataController.Append
    else  
  else
    if CanInsert(False) then
    begin
      DataController.Insert;
      if MultiSelect and (ViewData.EditingRecord <> nil) then
        ViewData.EditingRecord.Selected := True;
    end;
  if (dceInsert in DataController.EditState) and
    GridView.OptionsBehavior.FocusFirstCellOnNewRecord then
  begin
    FocusFirstAvailableItem;
    if AIsEditing then
      FEditingController.ShowEdit;
  end;
end;

procedure TcxCustomGridTableController.DeleteSelection;
var
  AMultiSelect: Boolean;

  function GetConfirmationText: string;
  begin
    if AMultiSelect then
      Result := cxGetResourceString(@scxGridDeletingSelectedConfirmationText)
    else
      Result := cxGetResourceString(@scxGridDeletingFocusedConfirmationText);
  end;

begin
  if not CanDelete(False) then Exit;
  AMultiSelect := MultiSelect and (SelectedRecordCount <> 0) and
    ((SelectedRecordCount > 1) or (SelectedRecords[0] = nil) or
     (FocusedRecordIndex <> SelectedRecords[0].Index));
  if not GridView.OptionsData.DeletingConfirmation or
    (Application.MessageBox(PChar(GetConfirmationText),
      PChar(cxGetResourceString(@scxGridDeletingConfirmationCaption)),
      MB_ICONQUESTION or MB_OKCANCEL) = ID_OK) then
    if AMultiSelect then
      DataController.DeleteSelection
    else
      DataController.DeleteFocused;
end;

procedure TcxCustomGridTableController.DoCheckCoordinates;
var
  APrevIsCheckingCoordinates: Boolean;
begin
  APrevIsCheckingCoordinates := FIsCheckingCoordinates;
  FIsCheckingCoordinates := True;
  try
    CheckCoordinates;
  finally
    FIsCheckingCoordinates := APrevIsCheckingCoordinates;
  end;
end;

function TcxCustomGridTableController.FocusFirstAvailableItem: Boolean;
begin
  Result := FocusNextItem(-1, True, False, False);
end;

function TcxCustomGridTableController.FocusNextCell(AGoForward: Boolean;
  AProcessCellsOnly: Boolean = True): Boolean;
begin
  if FocusedRecordHasCells(True) then
    Result := FocusNextItem(FocusedItemIndex, AGoForward, False,
      GridView.OptionsBehavior.FocusCellOnCycle)
  else
    if AProcessCellsOnly or not GridView.OptionsBehavior.FocusCellOnCycle then
      Result := False
    else
    begin
      Result := FocusNextRecord(FocusedRecordIndex, AGoForward, False, False);
      if FocusedRecordHasCells(True) then
        FocusNextItem(-1, AGoForward, True, False);
    end;
end;

function TcxCustomGridTableController.FocusNextItem(AFocusedItemIndex: Integer;
  AGoForward, AGoOnCycle, AGoToNextRecordOnCycle: Boolean): Boolean;
var
  ANextItemIndex: Integer;
  ACycleChanged, ANeedFocusItem: Boolean;
begin
  ANextItemIndex := FindNextItem(AFocusedItemIndex, AGoForward,
    AGoOnCycle or AGoToNextRecordOnCycle, ACycleChanged);
  Result := ANextItemIndex <> -1;
  if Result then
  begin
    if ACycleChanged and AGoToNextRecordOnCycle then
      if FocusedRecord.IsNewItemRecord then
      begin
        DataController.Post;
        ViewData.NewItemRecord.Focused := True;
        ANeedFocusItem := True;
      end
      else
        ANeedFocusItem := FocusNextRecord(FocusedRecordIndex, AGoForward, False, False) and
          FocusedRecordHasCells(True)
    else
      ANeedFocusItem := True;
    if ANeedFocusItem then
      GridView.VisibleItems[ANextItemIndex].Focused := True;
  end;
end;

function TcxCustomGridTableController.FocusNextRecord(AFocusedRecordIndex: Integer;
  AGoForward, AGoOnCycle, AGoIntoDetail: Boolean): Boolean;
var
  AGridView: TcxCustomGridTableView;
  APrevFocused, ACycleChanged: Boolean;
  APrevFocusedRecord, ANextRecord, AChildRecord: TcxCustomGridRecord;
  ANextRecordIndex: Integer;

  procedure CheckEditing;
  var
    AGridView: TcxCustomGridTableView;
  begin
    AGridView := GridView;
    //AGridView.BeginUpdate;   - commented because of dialog calling in OnBeforePost
    AGridView.AddListenerLink(@AGridView);
    try
      if DataController.IsEditing then
      begin
        EditingController.UpdateValue;
        if not (dceModified in DataController.EditState) then
        begin
          if DataController.EditState = [dceInsert] then
          begin
            Result := AGoForward xor DataController.IsEOF;
            if Result then DataController.Cancel;
          end;
          Exit;
        end;
        DataController.Post;
        if AGridView = nil then Exit;
        if AFocusedRecordIndex <> -1 then
          AFocusedRecordIndex := FocusedRecordIndex;
      end;
    finally
      if AGridView = nil then
        Result := True
      else
      begin
        AGridView.RemoveListenerLink(@AGridView);
        //AGridView.EndUpdate;
      end;
    end;
  end;

  procedure CheckGridMode;
  begin
    if DataController.IsGridMode and (AFocusedRecordIndex = -1) then
      if AGoForward then
        DataController.GotoFirst
      else
        if AGoOnCycle then
          DataController.GotoLast;
  end;

  procedure ProcessMultiSelect;
  var
    AFocusedView: TcxCustomGridView;
  begin
    if GridView.Focused = APrevFocused then Exit;
    CheckFocusedRecordSelectionWhenExit(APrevFocusedRecord);
    AFocusedView := TcxCustomGrid(Control).FocusedView;
    if AFocusedView is TcxCustomGridTableView then
      with TcxCustomGridTableView(AFocusedView).Controller do
        if CanProcessMultiSelect(True) then
          DoNormalSelectionWithAnchor;
  end;

begin
  Result := False;
  CheckEditing;
  if Result then Exit;
  AGridView := GridView;
  AGridView.AddListenerLink(@AGridView);
  CheckGridMode;
  APrevFocused := GridView.Focused;
  APrevFocusedRecord := FocusedRecord;
  try
    if AGoForward and AGoIntoDetail and GridView.IsMaster and
      (AFocusedRecordIndex <> -1) then
      ANextRecord := ViewData.Records[AFocusedRecordIndex].GetFirstFocusableChild
    else
      ANextRecord := nil;
    if ANextRecord = nil then
    begin
      ANextRecordIndex := FindNextRecord(AFocusedRecordIndex, AGoForward,
        AGoOnCycle, ACycleChanged);
      if ANextRecordIndex <> -1 then
      begin
        ANextRecord := ViewData.Records[ANextRecordIndex];
        if not AGoForward and AGoIntoDetail and GridView.IsMaster then
        begin
          AChildRecord := ANextRecord.GetLastFocusableChild(True);
          if AChildRecord <> nil then
            ANextRecord := AChildRecord;
        end;
      end
      else
        if AGoForward and CanAppend(True) then
        begin
          CreateNewRecord(True);
          Exit;
        end
        else
          if GridView.IsDetail then
            if not AGoForward and GridView.MasterGridRecord.CanFocus then
              ANextRecord := GridView.MasterGridRecord
            else
            begin
              Result := not DataController.IsGridMode and
                MasterController.FocusNextRecord(GridView.MasterGridRecordIndex,
                  AGoForward, AGoOnCycle, not AGoForward);
              Exit;
            end;
    end;
    Result := ANextRecord <> nil;
    if Result then
      ANextRecord.Focused := True;
  finally
    if AGridView <> nil then
    begin
      AGridView.RemoveListenerLink(@AGridView);
      if Result then ProcessMultiSelect;
    end;
  end;
end;

function TcxCustomGridTableController.FocusNextRecordWithSelection(AFocusedRecordIndex: Integer;
  AGoForward, AGoOnCycle, AGoIntoDetail: Boolean; ASyncSelection: Boolean = True): Boolean;
begin
  Result := FocusNextRecord(AFocusedRecordIndex, AGoForward, AGoOnCycle, AGoIntoDetail);
  if Result and ASyncSelection and CanProcessMultiSelect(True) then
    DoNormalSelectionWithAnchor;
end;

function TcxCustomGridTableController.FocusRecord(AFocusedRecordIndex: Integer;
  ASyncSelection: Boolean): Boolean;
begin
  FocusedRecordIndex := AFocusedRecordIndex;
  Result := FocusedRecordIndex = AFocusedRecordIndex;
  if Result and ASyncSelection and CanProcessMultiSelect(True) then
    DoNormalSelectionWithAnchor;
end;

procedure TcxCustomGridTableController.MakeFocusedItemVisible;
begin
  MakeItemVisible(FocusedItem);
end;

procedure TcxCustomGridTableController.MakeFocusedRecordVisible;
begin
  MakeRecordVisible(FocusedRecord);
end;

procedure TcxCustomGridTableController.MakeRecordVisible(ARecord: TcxCustomGridRecord);
var
  AFocusedView: TcxCustomGridView;
  AIndex, APrevTopRecordIndex: Integer;
begin
  if (ARecord = nil) or (GridView.Control = nil) then Exit;
  AFocusedView := TcxCustomGrid(GridView.Control).FocusedView;
  if (AFocusedView is TcxCustomGridTableView) and
    not GridView.Focused and AFocusedView.HasAsMaster(GridView) and
    TcxCustomGridTableView(AFocusedView).DontMakeMasterRecordVisible then Exit;
  AIndex := ARecord.Index;
  if AIndex < TopRecordIndex then InternalTopRecordIndex := AIndex;
  if ViewInfo.VisibleRecordCount = 0 then
    if AIndex > TopRecordIndex then
      InternalTopRecordIndex := AIndex
    else
  else
    while AIndex >= TopRecordIndex + ViewInfo.VisibleRecordCount do
    begin
      APrevTopRecordIndex := TopRecordIndex;
      InternalTopRecordIndex := AIndex - GetVisibleRecordCount(AIndex, False) + 1;
      if TopRecordIndex = APrevTopRecordIndex then Break;
    end;
  GridView.MakeMasterGridRecordVisible;
end;

function TcxCustomGridTableController.GoToFirst: Boolean;
begin
  Result := FocusNextRecordWithSelection(-1, True, False, False);
end;

function TcxCustomGridTableController.GoToLast(AGoIntoDetail: Boolean): Boolean;
begin
  Result := FocusNextRecordWithSelection(-1, False, True, AGoIntoDetail);
end;

function TcxCustomGridTableController.GoToNext(AGoIntoDetail: Boolean;
  ASyncSelection: Boolean = True): Boolean;
begin
  Result := FocusNextRecordWithSelection(FocusedRecordIndex, True, False,
    AGoIntoDetail, ASyncSelection);
end;

function TcxCustomGridTableController.GoToPrev(AGoIntoDetail: Boolean;
  ASyncSelection: Boolean = True): Boolean;
begin
  Result := FocusNextRecordWithSelection(FocusedRecordIndex, False, False,
    AGoIntoDetail, ASyncSelection);
end;

function TcxCustomGridTableController.IsFinish: Boolean;
var
  ACycleChanged: Boolean;
begin
  Result := FindNextRecord(FocusedRecordIndex, True, False, ACycleChanged) = -1;
end;

function TcxCustomGridTableController.IsStart: Boolean;
var
  ACycleChanged: Boolean;
begin
  Result := FindNextRecord(FocusedRecordIndex, False, False, ACycleChanged) = -1;
end;

{ TcxGridTableDataCellPainter }

function TcxGridTableDataCellPainter.GetViewInfo: TcxGridTableDataCellViewInfo;
begin
  Result := TcxGridTableDataCellViewInfo(inherited ViewInfo);
end;

procedure TcxGridTableDataCellPainter.DrawContent;
begin
  if ViewInfo.Transparent and (ViewInfo.BackgroundBitmap <> nil) then
    DrawBackground;
  ViewInfo.EditViewInfo.Paint(Canvas);
end;

procedure TcxGridTableDataCellPainter.DrawFocusRect;
begin
  with ViewInfo do
    if Focused and not GridView.OptionsSelection.InvertSelect and not Editing then
      GridViewInfo.Painter.DrawFocusRect(ContentBounds, GridView.OptionsSelection.HideFocusRect);
end;

procedure TcxGridTableDataCellPainter.Paint;
begin
  inherited;
  DrawFocusRect;
end;

{ TcxCustomGridRecordPainter }

function TcxCustomGridRecordPainter.GetViewInfo: TcxCustomGridRecordViewInfo;
begin
  Result := TcxCustomGridRecordViewInfo(inherited ViewInfo);
end;

procedure TcxCustomGridRecordPainter.AfterPaint;
begin
  DrawFocusRect;
  if ViewInfo.GridRecord.Expandable then
    DrawExpandButton;
  ViewInfo.GridViewInfo.Painter.ExcludeFromBackground(ViewInfo.Bounds);
  inherited;
end;

procedure TcxCustomGridRecordPainter.BeforePaint;
begin
  inherited;
  {if ViewInfo.GridRecord.Expandable then
    DrawExpandButton;}
  DrawBackground;  
end;

procedure TcxCustomGridRecordPainter.DrawBackground;
begin
  with ViewInfo do
    if Transparent then
      Self.Canvas.FillRect(BackgroundBitmapBounds, BackgroundBitmap);
end;

procedure TcxCustomGridRecordPainter.DrawExpandButton;
begin
  ViewInfo.GridViewInfo.LookAndFeelPainter.DrawExpandButton(Canvas,
    ViewInfo.ExpandButtonBounds, ViewInfo.GridRecord.Expanded);
end;

procedure TcxCustomGridRecordPainter.DrawFocusRect;
begin
  with ViewInfo do
    if Focused and HasFocusRect then
      GridViewInfo.Painter.DrawFocusRect(FocusRectBounds, HideFocusRect);
end;

procedure TcxCustomGridRecordPainter.Paint;
begin
end;

{ TcxCustomGridRecordsPainter }

constructor TcxCustomGridRecordsPainter.Create(ACanvas: TcxCanvas;
  AViewInfo: TcxCustomGridRecordsViewInfo);
begin
  inherited Create;
  FCanvas := ACanvas;
  FViewInfo := AViewInfo;
end;

(*procedure TcxCustomGridRecordsPainter.BeforePaint;
begin  {4}
  with ViewInfo do   //!!! cache bitmaps!
    BackgroundBitmap := GetBackgroundBitmap;
end;*)

procedure TcxCustomGridRecordsPainter.Paint;
var
  I: Integer;
begin
  with FViewInfo do
    for I := 0 to Count - 1 do
      with Items[I] do
        if Calculated then Paint;
end;

procedure TcxCustomGridRecordsPainter.MainPaint;
begin
  //BeforePaint;
  Paint;
end;

{ TcxNavigatorSitePainter }

function TcxNavigatorSitePainter.ExcludeFromClipRect: Boolean;
begin
  Result := True;
end;

{ TcxCustomGridTablePainter }

function TcxCustomGridTablePainter.GetController: TcxCustomGridTableController;
begin
  Result := TcxCustomGridTableController(inherited Controller);
end;

function TcxCustomGridTablePainter.GetViewInfo: TcxCustomGridTableViewInfo;
begin
  Result := TcxCustomGridTableViewInfo(inherited ViewInfo);
end;

function TcxCustomGridTablePainter.CanOffset(AItemsOffset, DX, DY: Integer): Boolean;
begin  {2}{4}
  Result := (ViewInfo.BackgroundBitmap = nil) and
    (ViewInfo.RecordsViewInfo.BackgroundBitmap = nil);
end;

procedure TcxCustomGridTablePainter.DrawNavigator;
begin
  with ViewInfo do
    if NavigatorSiteViewInfo.Visible then
    begin
      NavigatorViewInfo.Paint;
      NavigatorSiteViewInfo.Paint;
    end;
end;

procedure TcxCustomGridTablePainter.DrawRecords;
begin
  ViewInfo.RecordsViewInfo.Paint;
end;

procedure TcxCustomGridTablePainter.Offset(AItemsOffset: Integer);
begin
  GridView.ViewChanged;
end;

procedure TcxCustomGridTablePainter.Offset(DX, DY: Integer);
begin
  GridView.ViewChanged;
end;

procedure TcxCustomGridTablePainter.PaintBefore;
begin
  inherited;
  DrawNavigator;
end;

procedure TcxCustomGridTablePainter.PaintContent;
begin
  inherited;
  DrawRecords;
end;

procedure TcxCustomGridTablePainter.DoOffset(AItemsOffset, DX, DY: Integer);
begin
  if not Site.HandleAllocated then Exit;
  if CanOffset(AItemsOffset, DX, DY) then
    if AItemsOffset = 0 then
      Offset(DX, DY)
    else
      Offset(AItemsOffset)
  else
    GridView.ViewChanged;
end;

{ TcxCustomGridRecord }

constructor TcxCustomGridRecord.Create(AViewData: TcxCustomGridTableViewData;
  AIndex: Integer; ARecordInfo: TcxRowInfo);
begin
  inherited Create;
  FViewData := AViewData;
  FIndex := AIndex;
  FRecordInfo := ARecordInfo;
end;

destructor TcxCustomGridRecord.Destroy;
begin
  //GridView.DoRecordDestroying(Self);
  if FViewInfo <> nil then
    FViewInfo.FRecord := nil;
  inherited;
end;

function TcxCustomGridRecord.GetController: TcxCustomGridTableController;
begin
  Result := GridView.Controller;
end;

function TcxCustomGridRecord.GetDataController: TcxCustomDataController;
begin
  Result := FViewData.DataController;
end;

function TcxCustomGridRecord.GetDragHighlighted: Boolean;
begin
  Result := FViewData.Controller.DragHighlightedRecord = Self;
end;

function TcxCustomGridRecord.GetFocused: Boolean;
begin
  Result := FViewData.Controller.FocusedRecord = Self;
end;

function TcxCustomGridRecord.GetGridView: TcxCustomGridTableView;
begin
  Result := FViewData.GridView;
end;

function TcxCustomGridRecord.GetIsEditing: Boolean;
begin
  Result := FViewData.EditingRecord = Self;
end;

function TcxCustomGridRecord.GetIsNewItemRecord: Boolean;
begin
  Result := FViewData.NewItemRecord = Self;
end;

function TcxCustomGridRecord.GetIsValid: Boolean;
begin
  Result := (0 <= RecordIndex) and (RecordIndex < ViewData.DataController.RecordCount);
end;

function TcxCustomGridRecord.GetLevel: Integer;
begin
  Result := RecordInfo.Level;
end;

function TcxCustomGridRecord.GetPartVisible: Boolean;
begin
  Result := FViewInfo <> nil;
end;

function TcxCustomGridRecord.GetRecordIndex: Integer;
begin
  Result := FRecordInfo.RecordIndex;
end;

procedure TcxCustomGridRecord.SetExpanded(Value: Boolean);
begin
  if Expanded <> Value then
    if Value then
      Expand(False)
    else
      Collapse(False);
end;

procedure TcxCustomGridRecord.SetFocused(Value: Boolean);
begin
  if Value then
    FViewData.Controller.FocusedRecord := Self
  else
    FViewData.Controller.FocusedRecord := nil;
end;

procedure TcxCustomGridRecord.RefreshRecordInfo;
begin
  if IsNewItemRecord then
    with FRecordInfo do
    begin
      Expanded := False;
      Level := 0;
      RecordIndex := DataController.NewItemRecordIndex;
    end
  else
    FRecordInfo := DataController.GetRowInfo(FIndex);
end;

function TcxCustomGridRecord.GetDestroyingOnExpanding: Boolean;
begin
  Result := False;
end;

function TcxCustomGridRecord.GetExpandable: Boolean;
begin
  Result := False;
end;

function TcxCustomGridRecord.GetExpanded: Boolean;
begin
  Result := False;
end;

function TcxCustomGridRecord.GetDrawFocused: Boolean;
begin
  Result := GridView.DrawRecordFocused(Self);
end;

function TcxCustomGridRecord.GetDrawSelected: Boolean;
begin
  Result := GridView.DrawRecordSelected(Self);
end;

function TcxCustomGridRecord.GetHasCells: Boolean;
begin
  Result := False;
end;

function TcxCustomGridRecord.GetIsData: Boolean;
begin
  Result := True;
end;

function TcxCustomGridRecord.GetIsFirst: Boolean;
begin
  Result := Index = 0;
end;

function TcxCustomGridRecord.GetIsLast: Boolean;
begin
  Result := Index = FViewData.RecordCount - 1;
end;

function TcxCustomGridRecord.GetIsParent: Boolean;
begin
  Result := False;
end;

function TcxCustomGridRecord.GetIsParentRecordLast(AIndex: Integer): Boolean;
begin
  Result := IsLast or (ViewData.Records[Index + 1].Level < Level - AIndex);
end;

function TcxCustomGridRecord.GetParentRecord: TcxCustomGridRecord;
begin
  if Level <> 0 then
  begin
    Result := Self;
    repeat
      Result := ViewData.Records[Result.Index - 1];
    until Result.Level < Level;
  end
  else
    if GridView.IsDetail then
      Result := GridView.MasterGridRecord
    else
      Result := nil;
end;

function TcxCustomGridRecord.GetSelected: Boolean;
begin
  if IsNewItemRecord then
    Result := DataController.NewItemRowFocused
  else
    Result := FViewData.Controller.IsRecordSelected(Self);
end;

function TcxCustomGridRecord.GetVisible: Boolean;
begin
  Result := IsNewItemRecord or PartVisible and
    FViewData.ViewInfo.RecordsViewInfo.GetRealItem(Self, Index).Visible;
end;

procedure TcxCustomGridRecord.SetSelected(Value: Boolean);
begin
  if not IsNewItemRecord then
    FViewData.Controller.ChangeRecordSelection(Self, Value)
  else
    if Selected <> Value then
      DataController.NewItemRowFocused := Value;
end;

function TcxCustomGridRecord.GetDisplayText(Index: Integer): string;
begin  
  Result := DataController.GetRowDisplayText(RecordInfo, Index);
  GridView.DoGetDisplayText(Self, Index, Result);
end;

function TcxCustomGridRecord.GetValueCount: Integer;
begin
  Result := DataController.GetItemCount;
end;

function TcxCustomGridRecord.GetValue(Index: Integer): Variant;
begin
  Result := DataController.GetRowValue(RecordInfo, Index);
end;

function TcxCustomGridRecord.CanFocus: Boolean;
begin
  Result := True; //!!!
end;

procedure TcxCustomGridRecord.Collapse(ARecurse: Boolean);
begin
  if Expandable then DoCollapse(ARecurse);
end;

procedure TcxCustomGridRecord.DoKeyPress(var Key: Char);
begin
  if FEatKeyPress then
    FEatKeyPress := False
  else
    KeyPress(Key);
end;

procedure TcxCustomGridRecord.Expand(ARecurse: Boolean);
begin
  if Expandable then DoExpand(ARecurse);
end;

function TcxCustomGridRecord.GetFirstFocusableChild: TcxCustomGridRecord;
begin
  Result := nil;
end;

function TcxCustomGridRecord.GetLastFocusableChild(ARecursive: Boolean): TcxCustomGridRecord;
begin
  Result := nil;
end;

procedure TcxCustomGridRecord.Invalidate(AItem: TcxCustomGridTableItem = nil);
begin
  GridView.Changed(TcxGridRecordChange.Create(GridView, Self, Index, AItem));
end;

procedure TcxCustomGridRecord.KeyDown(var Key: Word; Shift: TShiftState);
var
  ADestroyingOnExpanding: Boolean;
begin
  ADestroyingOnExpanding := DestroyingOnExpanding;
  case Key of
    VK_LEFT:
      if Expandable and Expanded then
      begin
        Expanded := False;
        Key := 0;
      end;
    VK_RIGHT:
      if Expandable and not Expanded then
      begin
        Expanded := True;
        Key := 0;
      end;
    VK_ADD:
      if Expandable then
      begin
        Expanded := True;
        Key := 0;
        if not ADestroyingOnExpanding then
          FEatKeyPress := True;
      end;
    VK_SUBTRACT:
      if Expandable then
      begin
        Expanded := False;
        Key := 0;
        if not ADestroyingOnExpanding then
          FEatKeyPress := True;
      end;
    VK_MULTIPLY:
      if Expandable then
      begin
        Expand(True);
        Key := 0;
        if not ADestroyingOnExpanding then
          FEatKeyPress := True;
      end;
    VK_RETURN, VK_F2, VK_PROCESSKEY:
      if HasCells and (Controller.FocusedItem <> nil) and
        ((Shift = []) or (Key = VK_RETURN) and (Shift = [ssShift])) then
      begin
        Controller.FocusedItem.Editing := True;
        if Controller.FocusedItem.Editing and (Key <> VK_PROCESSKEY) then
          Key := 0;
      end;
  end;
end;

procedure TcxCustomGridRecord.KeyPress(var Key: Char);
begin
  if (Key in EditStartChars) and
    HasCells and (Controller.FocusedItem <> nil) then
  begin
    Controller.EditingController.ShowEdit(Controller.FocusedItem, Key);
    Key := #0;
  end;
end;

procedure TcxCustomGridRecord.MakeVisible;
begin
  Controller.MakeRecordVisible(Self);
end;

{ TcxCustomGridTableViewData }

constructor TcxCustomGridTableViewData.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FRecords := TList.Create;
end;

destructor TcxCustomGridTableViewData.Destroy;
begin
  DestroyNewItemRecord;
  DestroyRecords;
  FRecords.Free;
  inherited;
end;

function TcxCustomGridTableViewData.GetController: TcxCustomGridTableController;
begin
  Result := TcxCustomGridTableController(inherited Controller);
end;

function TcxCustomGridTableViewData.GetEditingRecord: TcxCustomGridRecord;
begin
  if DataController.IsEditing then
    Result := GetRecordByRecordIndex(DataController.EditingRecordIndex)
  else
    Result := nil;
end;

function TcxCustomGridTableViewData.GetGridView: TcxCustomGridTableView;
begin
  Result := TcxCustomGridTableView(inherited GridView);
end;

function TcxCustomGridTableViewData.GetInternalRecord(Index: Integer): TcxCustomGridRecord;
begin
  Result := TcxCustomGridRecord(FRecords[Index]);
end;

function TcxCustomGridTableViewData.GetRecord(Index: Integer): TcxCustomGridRecord;
begin
  Result := InternalRecords[Index];
  if Result = nil then
  begin
    Result := CreateRecord(Index);
    FRecords[Index] := Result;
    //GridView.DoRecordCreated(Result);
  end;
end;

function TcxCustomGridTableViewData.GetRecordCount: Integer;
begin
  Result := FRecords.Count;
end;

function TcxCustomGridTableViewData.GetViewInfo: TcxCustomGridTableViewInfo;
begin
  Result := TcxCustomGridTableViewInfo(inherited ViewInfo);
end;

function TcxCustomGridTableViewData.CreateRecord(AIndex: Integer): TcxCustomGridRecord;
var
  ARecordInfo: TcxRowInfo;
begin
  ARecordInfo := DataController.GetRowInfo(AIndex);
  Result := GetRecordClass(ARecordInfo).Create(Self, AIndex, ARecordInfo);
end;

procedure TcxCustomGridTableViewData.AssignEditingRecord;
begin
  FEditingRecord := GetEditingRecord;
end;

procedure TcxCustomGridTableViewData.CreateNewItemRecord;
var
  ARowInfo: TcxRowInfo;
begin
  FNewItemRecord := GetNewItemRecordClass.Create(Self, -1, ARowInfo);
  FNewItemRecord.RefreshRecordInfo;
  //GridView.DoRecordCreated(FNewItemRecord);
end;  

procedure TcxCustomGridTableViewData.DestroyNewItemRecord;
begin
  FreeAndNil(FNewItemRecord);
end;

procedure TcxCustomGridTableViewData.RecreateNewItemRecord;
begin
  if HasNewItemRecord then
  begin
    DestroyNewItemRecord;
    CreateNewItemRecord;
  end;
end;

procedure TcxCustomGridTableViewData.Collapse(ARecurse: Boolean);
var
  I: Integer;
begin
  for I := RecordCount - 1 downto 0 do
    Records[I].Collapse(ARecurse);
end;

procedure TcxCustomGridTableViewData.DestroyRecords;
var
  I: Integer;
  ARecord: TcxCustomGridRecord;
begin
  for I := 0 to RecordCount - 1 do
  begin
    ARecord := InternalRecords[I];
    if ARecord <> nil then
    begin
      ARecord.Free;
      FRecords[I] := nil;
    end;
  end;
end;

procedure TcxCustomGridTableViewData.Expand(ARecurse: Boolean);
var
  I: Integer;
begin
  I := 0;
  while I < RecordCount do
  begin
    Records[I].Expand(ARecurse);
    Inc(I);
  end;
end;

function TcxCustomGridTableViewData.GetRecordByIndex(AIndex: Integer): TcxCustomGridRecord;
begin
  if (0 <= AIndex) and (AIndex < RecordCount) then
    Result := Records[AIndex]
  else
    Result := nil;
end;

function TcxCustomGridTableViewData.GetRecordByRecordIndex(ARecordIndex: Integer): TcxCustomGridRecord;
begin
  if HasNewItemRecord and (ARecordIndex = DataController.NewItemRecordIndex) then
    Result := FNewItemRecord
  else
    if (0 <= ARecordIndex) and (ARecordIndex < DataController.RecordCount) then
      Result := GetRecordByIndex(DataController.GetRowIndexByRecordIndex(ARecordIndex, False))
    else
      Result := nil;
end;

function TcxCustomGridTableViewData.GetRecordIndexByRecord(ARecord: TcxCustomGridRecord): Integer;
begin
  if ARecord = nil then
    Result := -1  //!!! can be internal record index
  else
    Result := ARecord.RecordIndex;
end;

function TcxCustomGridTableViewData.IsRecordIndexValid(AIndex: Integer): Boolean;
begin
  Result := (0 <= AIndex) and (AIndex < RecordCount);
end;

procedure TcxCustomGridTableViewData.Refresh(ARecordCount: Integer);
begin
  RecreateNewItemRecord;
  DestroyRecords;
  FRecords.Clear;
  FRecords.Count := ARecordCount;
  AssignEditingRecord;
  GridView.SizeChanged(GridView.IsPattern);
end;

procedure TcxCustomGridTableViewData.RefreshRecords;
var
  I: Integer;
  ARecord: TcxCustomGridRecord;
begin
  if HasNewItemRecord then FNewItemRecord.RefreshRecordInfo;
  for I := 0 to RecordCount - 1 do
  begin
    ARecord := InternalRecords[I];
    if ARecord <> nil then ARecord.RefreshRecordInfo;
  end;
  AssignEditingRecord;
end;

procedure TcxCustomGridTableViewData.CheckNewItemRecord;
begin
  if HasNewItemRecord then
    CreateNewItemRecord
  else
    DestroyNewItemRecord;
end;

function TcxCustomGridTableViewData.HasNewItemRecord: Boolean;
begin
  Result := False;
end;

{ TcxGridTableCellViewInfo }

constructor TcxGridTableCellViewInfo.Create(ARecordViewInfo: TcxCustomGridRecordViewInfo);
begin
  inherited Create(ARecordViewInfo.GridViewInfo);
  FRecordViewInfo := ARecordViewInfo;
end;

function TcxGridTableCellViewInfo.GetCacheItem: TcxCustomGridTableViewInfoCacheItem;
begin
  Result := FRecordViewInfo.CacheItem;
end;

function TcxGridTableCellViewInfo.GetController: TcxCustomGridTableController;
begin
  Result := GridView.Controller;
end;

function TcxGridTableCellViewInfo.GetGridView: TcxCustomGridTableView;
begin
  Result := FRecordViewInfo.GridView;
end;

function TcxGridTableCellViewInfo.GetGridRecord: TcxCustomGridRecord;
begin
  Result := FRecordViewInfo.GridRecord;
end;

function TcxGridTableCellViewInfo.GetSelected: Boolean;
begin
  if not FSelectedCalculated then
  begin
    FSelected := CalculateSelected;
    FSelectedCalculated := True;
  end;
  Result := FSelected;
end;

function TcxGridTableCellViewInfo.GetGridViewInfo: TcxCustomGridTableViewInfo;
begin
  Result := FRecordViewInfo.GridViewInfo;
end;

function TcxGridTableCellViewInfo.CalculateSelected: Boolean;
begin
  Result := GridView.DrawDataCellSelected(GridRecord, nil, True, Self);
end;

function TcxGridTableCellViewInfo.GetAlwaysSelected: Boolean;
begin
  Result := False;
end;

function TcxGridTableCellViewInfo.GetCanvas: TcxCanvas;
begin
  Result := GridViewInfo.Canvas;
end;

function TcxGridTableCellViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridRecordHitTest;
end;

function TcxGridTableCellViewInfo.GetTransparent: Boolean;
begin                                {4}
  Result := FRecordViewInfo.GetCellTransparent(Self);
end;

procedure TcxGridTableCellViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  inherited;
  TcxGridRecordHitTest(AHitTest).GridRecord := GridRecord;
end;

procedure TcxGridTableCellViewInfo.Calculate(ALeftBound, ATopBound: Integer;
  AWidth: Integer = -1; AHeight: Integer = -1);
begin
  FSelectedCalculated := False;
  inherited;
end;

function TcxGridTableCellViewInfo.CanDrawSelected: Boolean;
begin
  Result := False;
end;

function TcxGridTableCellViewInfo.MouseDown(AHitTest: TcxCustomGridHitTest;
  AButton: TMouseButton; AShift: TShiftState): Boolean;
var
  AGridView: TcxCustomGridTableView;
begin
  AGridView := GridView;
  AGridView.AddListenerLink(@AGridView);
  GridViewInfo.AddActiveViewInfo(Self);
  try
    Result := FRecordViewInfo.MouseDown(AHitTest, AButton, AShift);
    if Result and AGridView.ViewInfo.IsViewInfoActive(Self) then
      inherited MouseDown(AHitTest, AButton, AShift);
  finally
    if AGridView <> nil then
    begin
      AGridView.RemoveListenerLink(@AGridView);
      AGridView.ViewInfo.RemoveActiveViewInfo(Self);
    end
    else
      Result := False;
  end;
end;

{ TcxGridTableDataCellViewInfo }

constructor TcxGridTableDataCellViewInfo.Create(ARecordViewInfo: TcxCustomGridRecordViewInfo;
  AItem: TcxCustomGridTableItem);
begin
  inherited Create(ARecordViewInfo);
  FItem := AItem;
  FItem.AddCell(Self);
  FProperties := FItem.GetProperties(GridRecord);
  FEditViewInfo := CreateEditViewInfo;   {3}
  FStyle := FItem.GetCellStyle;  
end;

destructor TcxGridTableDataCellViewInfo.Destroy;
begin
  if FItem <> nil then
  begin
    if not GridView.IsDestroying then  
      FItem.ReleaseCellStyle;
    FItem.RemoveCell(Self);
  end;
  FEditViewInfo.Free;
  inherited;
end;

function TcxGridTableDataCellViewInfo.GetEditing: Boolean;
begin
  Result := FItem.Editing and Focused;
end;

function TcxGridTableDataCellViewInfo.GetFocused: Boolean;
begin
  Result := FItem.Focused and RecordViewInfo.Focused and (FItem.FocusedCellViewInfo = Self);
end;

function TcxGridTableDataCellViewInfo.GetMousePos: TPoint;
begin
  Result := GridViewInfo.MousePos;
end;

function TcxGridTableDataCellViewInfo.GetProperties: TcxCustomEditProperties;
begin
  Result := FProperties;
  FItem.InitProperties(Result);
end;

function TcxGridTableDataCellViewInfo.GetShowButtons: Boolean;
begin
  Result := FItem.ShowButtons(RecordViewInfo.Focused);
end;

procedure TcxGridTableDataCellViewInfo.AfterCustomDraw(ACanvas: TcxCanvas);
begin                             //inherited;exit;
  FEditViewInfo.BackgroundColor := ACanvas.Brush.Color;
  if FEditViewInfo is TcxCustomTextEditViewInfo then
    with TcxCustomTextEditViewInfo(FEditViewInfo) do
    begin
      Font := ACanvas.Font;
      TextColor := ACanvas.Font.Color;
    end;
end;
                               {3}
procedure TcxGridTableDataCellViewInfo.BeforeCustomDraw(ACanvas: TcxCanvas);
begin                             //inherited;exit;
  ACanvas.Brush.Color := FEditViewInfo.BackgroundColor;
  if FEditViewInfo is TcxCustomTextEditViewInfo then
    with TcxCustomTextEditViewInfo(FEditViewInfo) do
    begin
      ACanvas.Font := Font;
      ACanvas.Font.Color := TextColor;
    end;
end;

procedure TcxGridTableDataCellViewInfo.CalculateEditViewInfo(AEditViewInfo: TcxCustomEditViewInfo;
  const AMousePos: TPoint);
begin
  InitStyle;
  CreateEditViewData;
  try
    GetEditViewDataContentOffsets(FEditViewData.ContentOffset);
    if AutoHeight or MultiLine then
    begin
      Include(FEditViewData.PaintOptions, epoAutoHeight);
      FEditViewData.MaxLineCount := MaxLineCount;
    end;
    if ShowEndEllipsis then
      Include(FEditViewData.PaintOptions, epoShowEndEllipsis);
    FEditViewData.IsSelected := Selected;
    AEditViewInfo.Transparent := Transparent;  {4}
    InitTextSelection;
    FEditViewData.EditValueToDrawValue(Canvas, DisplayValue, AEditViewInfo);
    FEditViewData.Calculate(Canvas, EditViewDataBounds, AMousePos, cxmbNone, [], AEditViewInfo, True);
  finally
    DestroyEditViewData;
  end;
end;

function TcxGridTableDataCellViewInfo.CalculateHeight: Integer;
var
  AEditSizeProperties: TcxEditSizeProperties;
begin
  CalculateParams;
  if FItem.CanAutoHeight then
  begin
    CreateEditViewData;
    try
      SetRectEmpty(FEditViewData.ContentOffset);
      Include(FEditViewData.PaintOptions, epoAllowZeroHeight);
      with AEditSizeProperties do
      begin
        Height := -1;
        MaxLineCount := Self.MaxLineCount;
        with TextAreaBounds do
          Width := Right - Left;
        Inc(Width, 2 * (cxGridCellTextOffset - cxGridEditOffset));
      end;
      Result := FEditViewData.GetEditSize(Canvas, DisplayValue, AEditSizeProperties).cy;
      if Result <> 0 then
        Inc(Result, 2 * cxGridEditOffset);
    finally
      DestroyEditViewData;
    end;
  end
  else
    Result := FItem.CalculateDefaultCellHeight(Canvas, Params.Font);
end;

function TcxGridTableDataCellViewInfo.CalculateSelected: Boolean;
begin
  Result := GridView.DrawDataCellSelected(GridRecord, FItem, True, Self);
end;

function TcxGridTableDataCellViewInfo.CanShowHint: Boolean;
begin                          {9}
  Result := GridView.OptionsBehavior.CellHints;
end;

procedure TcxGridTableDataCellViewInfo.CheckEditHotTrack(const AMousePos: TPoint);
var
  AEditViewInfo: TcxCustomEditViewInfo;
  ARegion: TcxRegion;
begin                               
  AEditViewInfo := CreateEditViewInfo;
  try
    CalculateEditViewInfo(AEditViewInfo, AMousePos);
    ARegion := FEditViewInfo.GetUpdateRegion(AEditViewInfo);
    if not ARegion.IsEmpty then EditHotTrackChanged;
    ARegion.Free;
  finally
    AEditViewInfo.Free;
  end;
end;

function TcxGridTableDataCellViewInfo.CustomDraw(ACanvas: TcxCanvas): Boolean;
begin
  Result := inherited CustomDraw(ACanvas);
  if not Result then
  begin
    FItem.DoCustomDrawCell(ACanvas, Self, Result);
    if not Result then
      GridView.DoCustomDrawCell(ACanvas, Self, Result);
  end;    
end;

procedure TcxGridTableDataCellViewInfo.DoCalculateParams;
begin
  inherited;
  InitStyle;
end;

procedure TcxGridTableDataCellViewInfo.EditHotTrackChanged;
var
  AEditUpdateNeeded: Boolean;
begin
  AEditUpdateNeeded := GridView.Controller.EditingController.EditUpdateNeeded;
  Invalidate(True);
  if not AEditUpdateNeeded then
    GridView.Controller.EditingController.CancelEditUpdatePost;
end;

function TcxGridTableDataCellViewInfo.GetActivateEditOnMouseDown: Boolean;
begin
  Result := HotTrack;
  {Result := ShowButtons or (esoAlwaysHotTrack in Properties.GetSupportedOperations) and
    (GridView.OptionsBehavior.ImmediateEditor or Focused);}
end;

function TcxGridTableDataCellViewInfo.GetAutoHeight: Boolean;
begin
  Result := RecordViewInfo.AutoHeight;
end;

function TcxGridTableDataCellViewInfo.GetBoundsForHint: TRect;
begin
  Result := inherited GetBoundsForHint;
  IntersectRect(Result, Result, RecordViewInfo.RecordsViewInfo.Bounds);
end;

function TcxGridTableDataCellViewInfo.GetDisplayValue: TcxEditValue;
begin
  if {FEditViewData.IsValueSource}Properties.GetEditValueSource(False) = evsValue then
    Result := GridRecord.Values[FItem.Index]
  else
    Result := GridRecord.DisplayTexts[FItem.Index];
end;

function TcxGridTableDataCellViewInfo.GetEditBounds: TRect;
begin
  Result := EditViewDataBounds;
  InflateRect(Result, -cxGridEditOffset, -cxGridEditOffset);
  if FItem.CanScroll then
    with GridViewInfo.ScrollableAreaBoundsForEdit do
    begin
      //if Result.Left < Left then Result.Left := Left;
      if Result.Right > Right then Result.Right := Right;
      if Result.Bottom > Bottom then Result.Bottom := Bottom;
    end;
end;

function TcxGridTableDataCellViewInfo.GetEditViewDataBounds: TRect;
begin
  Result := ContentBounds;
end;

procedure TcxGridTableDataCellViewInfo.GetEditViewDataContentOffsets(var R: TRect);
begin
  with R do
  begin
    Left := cxGridEditOffset;
    Top := cxGridEditOffset;
    Right := cxGridEditOffset;
    Bottom := cxGridEditOffset;
  end;
end;

function TcxGridTableDataCellViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridRecordCellHitTest;
end;

function TcxGridTableDataCellViewInfo.GetHotTrack: Boolean;
begin
  Result := ShowButtons or (esoAlwaysHotTrack in Properties.GetSupportedOperations) and
    (GridView.OptionsBehavior.ImmediateEditor or Focused);
  //Result := ShowButtons or (esoAlwaysHotTrack in Properties.GetSupportedOperations);
end;

function TcxGridTableDataCellViewInfo.GetMaxLineCount: Integer;
begin
  Result := GridView.OptionsView.CellTextMaxLineCount;
end;

function TcxGridTableDataCellViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridTableDataCellPainter;
end;

function TcxGridTableDataCellViewInfo.GetShowEndEllipsis: Boolean;
begin
  Result := GridView.OptionsView.CellEndEllipsis;
end;

function TcxGridTableDataCellViewInfo.GetText: string;
begin                                            {3}
  //Result := ''//}GridRecord.DisplayTexts[FItem.Index];
  if FEditViewInfo is TcxCustomTextEditViewInfo then
    Result := TcxCustomTextEditViewInfo(FEditViewInfo).Text
  else
    Result := '';
end;

function TcxGridTableDataCellViewInfo.GetValue: Variant;
begin
  Result := GridRecord.Values[FItem.Index];
end;

procedure TcxGridTableDataCellViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  {3}
  {with AParams do
  begin
    Color := clWindow;
    TextColor := clWindowText;
    Font := TcxCustomGrid(GridView.Control).Font;
  end;}
  GridView.Styles.GetDataCellParams(GridRecord, FItem, Params, True, Self);
end;

function TcxGridTableDataCellViewInfo.HasCustomDraw: Boolean;
begin
  Result := FItem.HasCustomDrawCell or GridView.HasCustomDrawCell;
end;

procedure TcxGridTableDataCellViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  inherited;
  TcxGridRecordCellHitTest(AHitTest).Item := Item;
end;

procedure TcxGridTableDataCellViewInfo.InitTextSelection;
var
  AIncSearchParams: TcxViewParams;
begin
  with FEditViewData do
    if IsTextSelected then
    begin
      SelStart := 0;
      SelLength := Length(Controller.IncSearchingText);
      GridView.Styles.GetViewParams(vsIncSearch, nil, nil, AIncSearchParams);
      SelBackgroundColor := AIncSearchParams.Color;
      SelTextColor := AIncSearchParams.TextColor;
    end
    else
      SelLength := 0;
end;

function TcxGridTableDataCellViewInfo.InvalidateOnStateChange: Boolean;
begin
  Result := False;
end;

function TcxGridTableDataCellViewInfo.IsTextSelected: Boolean;
begin
  Result := RecordViewInfo.RecordsViewInfo.IncSearchingCellViewInfo = Self;
end;

procedure TcxGridTableDataCellViewInfo.MouseLeave;
begin
  inherited;
  if HotTrack then
    CheckEditHotTrack(Bounds.BottomRight);
end;

function TcxGridTableDataCellViewInfo.NeedShowHint(const AMousePos: TPoint;
  out AHintText: TCaption; out AIsHintMultiLine: Boolean; out ATextRect: TRect): Boolean;
var
  AForm: TCustomForm;
begin
  AForm := GetParentForm(GridView.Site);
  Result := ((AForm = nil) or AForm.Active) and
    FEditViewInfo.NeedShowHint(Canvas, AMousePos, GridViewInfo.ScrollableAreaBoundsForEdit,
      AHintText, AIsHintMultiLine, ATextRect);
end;

procedure TcxGridTableDataCellViewInfo.Offset(DX, DY: Integer);
begin   {2}
  inherited;
  FEditViewInfo.Offset(DX, DY);
end;

procedure TcxGridTableDataCellViewInfo.RestoreParams(const AParams: TcxViewParams);
begin
  FEditViewInfo.BackgroundColor := AParams.Color;
  if FEditViewInfo is TcxCustomTextEditViewInfo then
    with TcxCustomTextEditViewInfo(FEditViewInfo) do
    begin
      Font := AParams.Font;
      TextColor := AParams.TextColor;
    end;
end;
                                 
procedure TcxGridTableDataCellViewInfo.SaveParams(out AParams: TcxViewParams);
begin
  AParams.Color := FEditViewInfo.BackgroundColor;
  if FEditViewInfo is TcxCustomTextEditViewInfo then
    with TcxCustomTextEditViewInfo(FEditViewInfo) do
    begin
      AParams.Font := Font;        
      AParams.TextColor := TextColor;
    end;
end;

procedure TcxGridTableDataCellViewInfo.StateChanged;
begin
  inherited;
  if State = gcsNone then EditHotTrackChanged;
end;

procedure TcxGridTableDataCellViewInfo.InitStyle;
begin
  FItem.InitStyle(FStyle, Params, RecordViewInfo.Focused);
end;

function TcxGridTableDataCellViewInfo.CreateEditViewInfo: TcxCustomEditViewInfo;
begin
  Result := Properties.GetViewInfoClass.Create as TcxCustomEditViewInfo;
end;

procedure TcxGridTableDataCellViewInfo.CreateEditViewData;
begin
  FEditViewData := FItem.GetEditViewData(GetProperties, FIsLocalCopyOfEditViewData);
end;

procedure TcxGridTableDataCellViewInfo.DestroyEditViewData;
begin
  FItem.ReleaseEditViewData(FEditViewData, FIsLocalCopyOfEditViewData);
end;

procedure TcxGridTableDataCellViewInfo.UpdateEdit;
begin
  Controller.EditingController.UpdateEdit;
end;

procedure TcxGridTableDataCellViewInfo.BeforeRecalculation;
begin
  GridViewInfo.UpdateMousePos;
  inherited;
end;

procedure TcxGridTableDataCellViewInfo.Calculate(ALeftBound, ATopBound: Integer;
  AWidth: Integer = -1; AHeight: Integer = -1);
begin
  inherited;
  CalculateEditViewInfo(FEditViewInfo, MousePos);  {3}
  Text := GetText;
  if not GridViewInfo.IsInternalUse and Editing then UpdateEdit;
end;

function TcxGridTableDataCellViewInfo.CanDrawSelected: Boolean;
begin
  Result := True;
end;

procedure TcxGridTableDataCellViewInfo.Invalidate(ARecalculate: Boolean);
begin
  if IsDestroying then Exit;
  if ARecalculate then Recalculate;
  inherited Invalidate;
  {if ARecalculate then
    GridRecord.Invalidate(FItem)
  else
    inherited Invalidate;}
end;

function TcxGridTableDataCellViewInfo.MouseDown(AHitTest: TcxCustomGridHitTest;
  AButton: TMouseButton; AShift: TShiftState): Boolean;
var
  AGridView: TcxCustomGridTableView;
  AItem: TcxCustomGridTableItem;
  AActivateEdit: Boolean;
begin
  FWasFocusedBeforeClick := Focused;
  AGridView := GridView;
  AGridView.AddListenerLink(@AGridView);
  AItem := FItem;
  AActivateEdit := ActivateEditOnMouseDown;
  Controller.AllowCheckEdit := False;
  GridView.DontMakeMasterRecordVisible := True;
  try
    Result := inherited MouseDown(AHitTest, AButton, AShift);
    if Result and not AItem.Controller.EditingController.IsErrorOnEditExit then
    begin
      AItem.Focused := True;
      if (AButton = mbLeft) and (AShift * [ssCtrl, ssShift] = []) and AActivateEdit then
        AItem.Controller.EditingController.ShowEdit(AItem, AShift, AHitTest.Pos.X, AHitTest.Pos.Y);
    end;
  finally
    if AGridView <> nil then
    begin
      AGridView.RemoveListenerLink(@AGridView);
      AItem.GridView.DontMakeMasterRecordVisible := False;
      AItem.Controller.AllowCheckEdit := True;
    end;  
  end;
end;

function TcxGridTableDataCellViewInfo.MouseMove(AHitTest: TcxCustomGridHitTest;
  AShift: TShiftState): Boolean;
begin
  Result := inherited MouseMove(AHitTest, AShift);
  if HotTrack then
    CheckEditHotTrack(AHitTest.Pos);
end;

function TcxGridTableDataCellViewInfo.MouseUp(AHitTest: TcxCustomGridHitTest;
  AButton: TMouseButton; AShift: TShiftState): Boolean;

  procedure ShowEdit;
  var
    AGridView: TcxCustomGridTableView;
  begin
    AGridView := GridView;
    AGridView.DontMakeMasterRecordVisible := True;
    try
      Controller.EditingController.ShowEdit(FItem, AShift, AHitTest.Pos.X, AHitTest.Pos.Y);
    finally
      AGridView.DontMakeMasterRecordVisible := False;
    end;
  end;

begin
  inherited MouseUp(AHitTest, AButton, AShift);
  Result := GridView.DoCellClick(Self, AButton, AShift);
  if Result then Exit;
  if (AButton = mbLeft) and (AShift * [ssCtrl, ssShift] = []) and Focused then
  begin
    if not Editing then
      if GridView.OptionsBehavior.ImmediateEditor then
        ShowEdit
      else
        if FWasFocusedBeforeClick and not Controller.IsDblClick then
          Controller.EditingController.StartEditShowingTimer(FItem);
    Result := True;
  end;
end;

{ TcxCustomGridRecordViewInfo }

constructor TcxCustomGridRecordViewInfo.Create(ARecordsViewInfo: TcxCustomGridRecordsViewInfo;
  ARecord: TcxCustomGridRecord);
begin
  inherited Create(ARecordsViewInfo.GridViewInfo);
  FRecordsViewInfo := ARecordsViewInfo;
  FRecord := ARecord;
  if FRecord <> nil then
  begin
    FIsRecordViewInfoAssigned := FRecord.ViewInfo <> nil;
    if not FIsRecordViewInfoAssigned then
      FRecord.FViewInfo := Self;
  end;    
end;

destructor TcxCustomGridRecordViewInfo.Destroy;
begin
  if not FIsRecordViewInfoAssigned and (FRecord <> nil) then
    FRecord.FViewInfo := nil;
  inherited;
end;

function TcxCustomGridRecordViewInfo.GetCacheItem: TcxCustomGridTableViewInfoCacheItem;
begin
  Result := TcxCustomGridTableViewInfoCacheItem(GridView.ViewInfoCache[FRecord.Index]);
end;

function TcxCustomGridRecordViewInfo.GetExpanded: Boolean;
begin
  if not FExpandedCalculated then
  begin
    FExpanded := (FRecord <> nil) and FRecord.Expanded;
    FExpandedCalculated := True;
  end;
  Result := FExpanded;  
  //Result := (FRecord <> nil) and FRecord.Expanded;
end;

function TcxCustomGridRecordViewInfo.GetFocused: Boolean;
begin
  Result := GridView.DrawRecordFocused(GridRecord);
end;

function TcxCustomGridRecordViewInfo.GetGridView: TcxCustomGridTableView;
begin
  Result := GridViewInfo.GridView;
end;

function TcxCustomGridRecordViewInfo.GetGridViewInfo: TcxCustomGridTableViewInfo;
begin
  Result := FRecordsViewInfo.GridViewInfo;
end;

function TcxCustomGridRecordViewInfo.GetIndex: Integer;
begin
  Result := FRecordsViewInfo.FItems.IndexOf(Self);
end;

function TcxCustomGridRecordViewInfo.GetSelected: Boolean;
begin
  if not FSelectedCalculated then
  begin
    FSelected := CalculateSelected;
    FSelectedCalculated := True;
  end;
  Result := FSelected;
end;

procedure TcxCustomGridRecordViewInfo.CalculateExpandButtonBounds(var ABounds: TRect);
begin
  if IsRectEmpty(Bounds) then
    ABounds := Rect(0, 0, 0, 0)
  else
    with ABounds do
    begin
      Inc(Left, GridViewInfo.ExpandButtonIndent);
      Right := Left + GridViewInfo.ExpandButtonSize;
      Top := (Top + Bottom - GridViewInfo.ExpandButtonSize) div 2;
      Bottom := Top + GridViewInfo.ExpandButtonSize;
    end;
end;

function TcxCustomGridRecordViewInfo.CalculateSelected: Boolean;
begin
  Result := GridView.DrawRecordSelected(GridRecord);
end;

procedure TcxCustomGridRecordViewInfo.ControlFocusChanged;
begin
end;

function TcxCustomGridRecordViewInfo.GetAutoHeight: Boolean;
begin
  Result := False;
end;

function TcxCustomGridRecordViewInfo.GetBackgroundBitmap: TBitmap;
begin
  Result := FRecordsViewInfo.BackgroundBitmap;
end;

function TcxCustomGridRecordViewInfo.GetBackgroundBitmapBounds: TRect;
begin    
  Result := ContentBounds;
end;

function TcxCustomGridRecordViewInfo.GetCanvas: TcxCanvas;
begin
  Result := FRecordsViewInfo.Canvas;
end;

function TcxCustomGridRecordViewInfo.GetCellTransparent(ACell: TcxGridTableCellViewInfo): Boolean;
begin
  Result := Transparent;
end;

function TcxCustomGridRecordViewInfo.GetContentBounds: TRect;
begin
  Result := Bounds;
end;

function TcxCustomGridRecordViewInfo.GetFocusRectBounds: TRect;
begin
  Result := Bounds;
end;

function TcxCustomGridRecordViewInfo.GetHeight: Integer;
begin
  if CacheItem.IsHeightAssigned then
    Result := CacheItem.Height
  else
  begin
    Result := CalculateHeight;
    CacheItem.Height := Result;
  end;
end;

function TcxCustomGridRecordViewInfo.GetHideFocusRect: Boolean;
begin
  Result := GridView.OptionsSelection.HideFocusRect;
end;

function TcxCustomGridRecordViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridRecordHitTest;
end;

function TcxCustomGridRecordViewInfo.GetVisible: Boolean;
begin
  Result := Index < FRecordsViewInfo.VisibleCount;
end;

function TcxCustomGridRecordViewInfo.HasFocusRect: Boolean;
begin
  Result := GridView.OptionsSelection.InvertSelect;
end;

procedure TcxCustomGridRecordViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  inherited;
  (AHitTest as TcxGridRecordHitTest).GridRecord := GridRecord;
end;

function TcxCustomGridRecordViewInfo.IsClickHitTest(AHitTest: TcxCustomGridHitTest): Boolean;
begin
  Result := (AHitTest as TcxGridRecordHitTest).CanClick;
end;

function TcxCustomGridRecordViewInfo.IsDetailVisible(ADetail: TcxCustomGridView): Boolean;
begin
  Result := False;
end;

procedure TcxCustomGridRecordViewInfo.Offset(DX, DY: Integer);
begin  {2}
  inherited;
  OffsetRect(FExpandButtonBounds, DX, DY);
end;

procedure TcxCustomGridRecordViewInfo.VisibilityChanged(AVisible: Boolean);
begin
end;

procedure TcxCustomGridRecordViewInfo.BeforeRecalculation;
begin
  inherited;
  FRecordsViewInfo.BeforeItemRecalculation;
end;

function TcxCustomGridRecordViewInfo.Click(AHitTest: TcxCustomGridHitTest;
  AButton: TMouseButton; AShift: TShiftState): Boolean;
var
  AGridView: TcxCustomGridTableView;
begin
  AGridView := GridView;
  AGridView.AddListenerLink(@AGridView);
  try
    GridViewInfo.Controller.FocusedRecord := GridRecord;
  finally
    if AGridView <> nil then
      AGridView.RemoveListenerLink(@AGridView);
    Result := AGridView <> nil;  {!!!}
  end;  
end;

function TcxCustomGridRecordViewInfo.GetBoundsForInvalidate(AItem: TcxCustomGridTableItem): TRect;
begin
  if AItem = nil then
    Result := Bounds
  else
    Result := GetBoundsForItem(AItem);
end;

function TcxCustomGridRecordViewInfo.GetBoundsForItem(AItem: TcxCustomGridTableItem): TRect;
begin
  Result := Rect(0, 0, 0, 0);
end;

function TcxCustomGridRecordViewInfo.GetCellViewInfoByItem(AItem: TcxCustomGridTableItem): TcxGridTableDataCellViewInfo;
begin
  Result := nil;
end;

{procedure TcxCustomGridRecordViewInfo.GetDataCellViewParams(AItem: TcxCustomGridTableItem;
  ACellViewInfo: TcxGridTableCellViewInfo; var AParams: TcxViewParams);
begin
  RecordsViewInfo.GetDataCellViewParams(GridRecord, AItem, ACellViewInfo, AParams);
end;}

function TcxCustomGridRecordViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
begin
  if GridRecord.Expandable and PtInRect(ExpandButtonAreaBounds, P) then
  begin
    Result := TcxGridExpandButtonHitTest.Instance(P);
    InitHitTest(Result);
  end
  else
    Result := inherited GetHitTest(P);
end;

procedure TcxCustomGridRecordViewInfo.MainCalculate(ALeftBound, ATopBound: Integer);
begin
  FSelectedCalculated := False;
  Calculate(ALeftBound, ATopBound, Width, Height);
  if GridRecord.Expandable then
    CalculateExpandButtonBounds(FExpandButtonBounds);
end;

function TcxCustomGridRecordViewInfo.MouseDown(AHitTest: TcxCustomGridHitTest;
  AButton: TMouseButton; AShift: TShiftState): Boolean;
begin
  Result := inherited MouseDown(AHitTest, AButton, AShift);
  if not Result then
    if AButton = mbLeft then
      case AHitTest.HitTestCode of
        htExpandButton:
          begin
            with GridRecord do
              Expanded := not Expanded;
            Result := True;
          end;
      end;
  if not Result and (AButton <> mbMiddle) and IsClickHitTest(AHitTest) and
    GridView.Site.IsFocused then
    Result := Click(AHitTest, AButton, AShift);
end;

procedure TcxCustomGridRecordViewInfo.Recalculate;
begin
  BeforeRecalculation;
  MainCalculate(Bounds.Left, Bounds.Top);
  AfterRecalculation;
end;

{ TcxCustomGridRecordsViewInfo }

constructor TcxCustomGridRecordsViewInfo.Create(AGridViewInfo: TcxCustomGridTableViewInfo);
begin
  inherited Create;
  FGridViewInfo := AGridViewInfo;
  CreateItems;
end;

destructor TcxCustomGridRecordsViewInfo.Destroy;
begin
  DestroyItems;
  inherited;
end;

function TcxCustomGridRecordsViewInfo.GetCanvas: TcxCanvas;
begin
  Result := FGridViewInfo.Canvas;
end;

function TcxCustomGridRecordsViewInfo.GetController: TcxCustomGridTableController;
begin
  Result := FGridViewInfo.Controller;
end;

function TcxCustomGridRecordsViewInfo.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxCustomGridRecordsViewInfo.GetFirstRecordIndex: Integer;
begin
  Result := FGridViewInfo.FirstRecordIndex;
end;

function TcxCustomGridRecordsViewInfo.GetGridView: TcxCustomGridTableView;
begin
  Result := FGridViewInfo.GridView;
end;

function TcxCustomGridRecordsViewInfo.GetIncSearchingCellViewInfo: TcxGridTableDataCellViewInfo;
begin
  if not FIsIncSearchingCellViewInfoCalculated then
    FIncSearchingCellViewInfo := CalculateIncSearchingCellViewInfo;
  Result := FIncSearchingCellViewInfo;
end;

function TcxCustomGridRecordsViewInfo.GetItem(Index: Integer): TcxCustomGridRecordViewInfo;
begin
  if Index < Count then
  begin
    Result := FItems[Index];
    if Result.GridRecord = nil then
      Result := nil;
  end
  else
  begin
    Result := CreateRecordViewInfo(Index);
    FItems.Add(Result);
  end;
end;

function TcxCustomGridRecordsViewInfo.GetMaxCount: Integer;
begin
  if (FirstRecordIndex = -1) or (ViewData.RecordCount = 0) then
    Result := 0
  else
    if GridViewInfo.CalculateDown then
      Result := ViewData.RecordCount - FirstRecordIndex
    else
      Result := FirstRecordIndex + 1;
  if Result < 0 then Result := 0;    
end;

function TcxCustomGridRecordsViewInfo.GetTopRecordIndex: Integer;
begin
  Result := GridViewInfo.Controller.TopRecordIndex;
end;

function TcxCustomGridRecordsViewInfo.GetViewData: TcxCustomGridTableViewData;
begin
  Result := FGridViewInfo.ViewData;
end;

procedure TcxCustomGridRecordsViewInfo.CreateItems;
begin
  FItems := TList.Create;
end;

procedure TcxCustomGridRecordsViewInfo.DestroyItems;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    TObject(FItems[I]).Free;
  FItems.Free;
end;

function TcxCustomGridRecordsViewInfo.CreateRecordViewInfo(AIndex: Integer): TcxCustomGridRecordViewInfo;
var
  ARecord: TcxCustomGridRecord;
begin
  ARecord := ViewData.Records[GetRecordIndex(AIndex)];
  Result := ARecord.GetViewInfoClass.Create(Self, ARecord);
end;

procedure TcxCustomGridRecordsViewInfo.AfterCalculate;
begin
  DestroyEditViewDatas;
  if not FGridViewInfo.IsInternalUse and not FGridViewInfo.SizeCalculating then
    Controller.EditingController.AfterViewInfoCalculate;
end;

procedure TcxCustomGridRecordsViewInfo.BeforeCalculate;
begin
  FBackgroundBitmap := GetBackgroundBitmap;
  if not FGridViewInfo.IsInternalUse and not FGridViewInfo.SizeCalculating then
    Controller.EditingController.BeforeViewInfoCalculate;
  CreateEditViewDatas;
end;

procedure TcxCustomGridRecordsViewInfo.BeforeItemRecalculation;
begin
  GridViewInfo.UpdateMousePos;
  FIsIncSearchingCellViewInfoCalculated := False;
end;

procedure TcxCustomGridRecordsViewInfo.BeforeOffset;
begin
  FIsIncSearchingCellViewInfoCalculated := False;
end;

procedure TcxCustomGridRecordsViewInfo.Calculate;
begin
  FBounds := CalculateBounds;
end;

function TcxCustomGridRecordsViewInfo.CalculateBounds: TRect;
begin
  Result := FGridViewInfo.ClientBounds;
end;

function TcxCustomGridRecordsViewInfo.CalculateIncSearchingCellViewInfo: TcxGridTableDataCellViewInfo;
begin                                
  if Controller.IsIncSearching then
  begin
    Result := Controller.IncSearchingItem.FocusedCellViewInfo;
    FIsIncSearchingCellViewInfoCalculated := Result <> nil;
  end
  else
  begin
    Result := nil;
    FIsIncSearchingCellViewInfoCalculated := True;
  end;
end;

procedure TcxCustomGridRecordsViewInfo.CalculateVisibleCount;
begin  {2}
  FVisibleCount := 0;
end;

procedure TcxCustomGridRecordsViewInfo.CreateEditViewDatas;
var
  I: Integer;
begin
  with GridView do
    for I := 0 to ItemCount - 1 do  
      Items[I].DoCreateEditViewData;
end;

procedure TcxCustomGridRecordsViewInfo.DestroyEditViewDatas;
var
  I: Integer;
begin
  with GridView do
    for I := 0 to ItemCount - 1 do 
      Items[I].DoDestroyEditViewData;
end;

function TcxCustomGridRecordsViewInfo.GetAutoRecordHeight: Boolean;
begin
  Result := GridView.OptionsView.CellAutoHeight;
end;

function TcxCustomGridRecordsViewInfo.GetBackgroundBitmap: TBitmap;
begin {4}
  Result := GridView.BackgroundBitmaps.GetBitmap(bbContent);
end;

function TcxCustomGridRecordsViewInfo.GetAutoDataRecordHeight: Boolean;
begin
  Result := AutoRecordHeight;
end;

function TcxCustomGridRecordsViewInfo.GetRecordIndex(AViewInfoIndex: Integer): Integer;
begin
  if FGridViewInfo.CalculateDown then
    Result := FGridViewInfo.FirstRecordIndex + AViewInfoIndex
  else
    Result := FGridViewInfo.FirstRecordIndex - AViewInfoIndex;
end;

function TcxCustomGridRecordsViewInfo.GetViewInfoIndex(ARecordIndex: Integer): Integer;
begin
  if FGridViewInfo.CalculateDown then
    Result := ARecordIndex - FGridViewInfo.FirstRecordIndex
  else
    Result := FGridViewInfo.FirstRecordIndex - ARecordIndex;
  if (Result < -1) or (Result >= Count) then Result := -1
end;

procedure TcxCustomGridRecordsViewInfo.ControlFocusChanged;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    if Items[I] <> nil then
      Items[I].ControlFocusChanged;
end;

procedure TcxCustomGridRecordsViewInfo.VisibilityChanged(AVisible: Boolean);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    if Items[I] <> nil then
      Items[I].VisibilityChanged(AVisible);
end;

function TcxCustomGridRecordsViewInfo.GetPainterClass: TcxCustomGridRecordsPainterClass;
begin
  Result := TcxCustomGridRecordsPainter;
end;

function TcxCustomGridRecordsViewInfo.CanOffset(AItemCountDelta: Integer): Boolean;
begin  {2}
  Result := (Count <> 0) and (Abs(AItemCountDelta) < Count);
end;

function TcxCustomGridRecordsViewInfo.GetCellHeight(ACellContentHeight: Integer): Integer;
begin
  Result := ACellContentHeight;
end;

function TcxCustomGridRecordsViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := Items[I].GetHitTest(P);
    if Result <> nil then Exit;
  end;
  Result := nil;
end;

function TcxCustomGridRecordsViewInfo.GetRealItem(ARecord: TcxCustomGridRecord;
  ARecordIndex: Integer): TcxCustomGridRecordViewInfo;
begin
  ARecordIndex := GetViewInfoIndex(ARecordIndex);
  if ARecordIndex = -1 then
    Result := nil
  else
    Result := Items[ARecordIndex];
end;

procedure TcxCustomGridRecordsViewInfo.MainCalculate;
begin
  BeforeCalculate;
  Calculate;
  AfterCalculate;
end;

procedure TcxCustomGridRecordsViewInfo.Offset(AItemCountDelta: Integer);
var
  AMoveCount: Integer;

  procedure DeleteItems;
  var
    I: Integer;
  begin
    if AItemCountDelta < 0 then
      I := Count + AItemCountDelta
    else
      I := 0;
    for I := I to I + Abs(AItemCountDelta) - 1 do
      Items[I].Free;
  end;

  procedure OffsetItemsList;
  var
    AIndexFrom: Integer;
  begin
    if AItemCountDelta < 0 then
      AIndexFrom := 0
    else
      AIndexFrom := AItemCountDelta;
    with FItems do
      System.Move(List[AIndexFrom], List[AIndexFrom - AItemCountDelta], SizeOf(Pointer) * AMoveCount);
  end;

  procedure OffsetItems;
  var
    AIndexFrom, I: Integer;
  begin
    if AItemCountDelta < 0 then
      AIndexFrom := Abs(AItemCountDelta)
    else
      AIndexFrom := 0;
    for I := AIndexFrom to AIndexFrom + AMoveCount - 1 do
      OffsetItem(I, FItemsOffset);
  end;

  procedure CreateItems;
  var
    I: Integer;
  begin
    if AItemCountDelta < 0 then
      I := 0
    else
      I := Count - AItemCountDelta;
    if Count > MaxCount then FItems.Count := MaxCount;
    for I := I to I + Abs(AItemCountDelta) - 1 do
      if I < Count then
      begin
        FItems[I] := CreateRecordViewInfo(I);
        Items[I].MainCalculate(GetItemLeftBound(I), GetItemTopBound(I));
      end;
  end;

  procedure CheckForAppearedItems;
  var
    I: Integer;
  begin
    for I := 0 to Count - 1 do
      if not Items[I].Calculated then
        Items[I].MainCalculate(GetItemLeftBound(I), GetItemTopBound(I));
  end;

begin  {2}
  FItemsOffset := 0;
  if AItemCountDelta = 0 then Exit;
  AMoveCount := Count - Abs(AItemCountDelta);
  if AItemCountDelta > 0 then
    FItemsOffset := GetItemsOffset(AItemCountDelta);
  DeleteItems;
  OffsetItemsList;
  if AItemCountDelta > 0 then OffsetItems;
  CreateItems;
  if AItemCountDelta < 0 then
  begin
    FItemsOffset := GetItemsOffset(AItemCountDelta);
    OffsetItems;
  end;
  CalculateVisibleCount;
  CheckForAppearedItems;
end;

procedure TcxCustomGridRecordsViewInfo.Offset(DX, DY: Integer);
begin  {2}
  OffsetRect(FBounds, DX, DY);
end;

procedure TcxCustomGridRecordsViewInfo.Paint;
begin
  with GetPainterClass.Create(Canvas, Self) do
    try
      MainPaint;
    finally
      Free;
    end;
end;

{ TcxNavigatorSiteViewInfo }

function TcxNavigatorSiteViewInfo.GetGridViewInfo: TcxCustomGridTableViewInfo;
begin
  Result := TcxCustomGridTableViewInfo(inherited GridViewInfo);
end;

function TcxNavigatorSiteViewInfo.GetNavigatorViewInfo: TcxNavigatorViewInfo;
begin
  Result := GridViewInfo.NavigatorViewInfo;
end;

function TcxNavigatorSiteViewInfo.CalculateWidth: Integer;
begin
  with GridViewInfo do
    Result := NavigatorSize.X + NavigatorOffset;
end;

function TcxNavigatorSiteViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridNavigatorHitTest;
end;

function TcxNavigatorSiteViewInfo.GetHotTrack: Boolean;
begin
  Result := True;
end;

function TcxNavigatorSiteViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxNavigatorSitePainter;
end;

function TcxNavigatorSiteViewInfo.GetVisible: Boolean;
begin
  Result := GridViewInfo.GridView.OptionsView.Navigator;
end;

procedure TcxNavigatorSiteViewInfo.MouseLeave;
begin
  inherited;
  NavigatorViewInfo.MouseMove(-1, -1);
end;

procedure TcxNavigatorSiteViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  AParams.Color := clBtnFace;
end;

function TcxNavigatorSiteViewInfo.GetWidth: Integer;
begin
  Result := CalculateWidth;
end;

function TcxNavigatorSiteViewInfo.MouseDown(AHitTest: TcxCustomGridHitTest;
  AButton: TMouseButton; AShift: TShiftState): Boolean;
begin
  with AHitTest.Pos do
    NavigatorViewInfo.MouseDown(X, Y);
  Result := True;  
end;

function TcxNavigatorSiteViewInfo.MouseMove(AHitTest: TcxCustomGridHitTest;
  AShift: TShiftState): Boolean;
begin
  inherited MouseMove(AHitTest, AShift);
  with AHitTest.Pos do
    NavigatorViewInfo.MouseMove(X, Y);
  Result := True;  
end;

function TcxNavigatorSiteViewInfo.MouseUp(AHitTest: TcxCustomGridHitTest;
  AButton: TMouseButton; AShift: TShiftState): Boolean;
begin
  with AHitTest.Pos do
    NavigatorViewInfo.MouseUp(X, Y);
  Result := True;  
end;
  
{ TcxCustomGridTableViewInfo }

constructor TcxCustomGridTableViewInfo.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FAllowCheckCoordinates := True;
  FCalculateDown := True;
  FFirstRecordIndex := RecordIndexNone;
end;

function TcxCustomGridTableViewInfo.GetController: TcxCustomGridTableController;
begin
  Result := TcxCustomGridTableController(inherited Controller);
end;

function TcxCustomGridTableViewInfo.GetExpandButtonSize: Integer;
begin
  Result := LookAndFeelPainter.ExpandButtonSize;
end;

function TcxCustomGridTableViewInfo.GetFirstRecordIndex: Integer;
begin
  if FirstRecordIndexAssigned then
    Result := FFirstRecordIndex
  else
    Result := Controller.TopRecordIndex;
end;

function TcxCustomGridTableViewInfo.GetGridView: TcxCustomGridTableView;
begin
  Result := TcxCustomGridTableView(inherited GridView);
end;

function TcxCustomGridTableViewInfo.GetScrollableAreaWidth: Integer;
begin
  with ScrollableAreaBoundsHorz do
    Result := Right - Left;
end;

function TcxCustomGridTableViewInfo.GetViewData: TcxCustomGridTableViewData;
begin
  Result := TcxCustomGridTableViewData(inherited ViewData);
end;

function TcxCustomGridTableViewInfo.GetVisibleRecordCount: Integer;
begin
  Result := FRecordsViewInfo.VisibleCount;
end;

procedure TcxCustomGridTableViewInfo.NavigatorChanged(AChangeType: TcxNavigatorChangeType);
begin
  case AChangeType of
    nctSize:
      GridView.SizeChanged;
    nctLayout:
      GridView.LayoutChanged;
  end;
end;

function TcxCustomGridTableViewInfo.GetNavigatorBounds: TRect;
begin 
  Result := GetNavigatorSiteBounds;
  Dec(Result.Right, NavigatorOffset);
end;

function TcxCustomGridTableViewInfo.GetNavigatorButtons: TcxCustomNavigatorButtons;
begin
  Result := GridView.NavigatorButtons;
end;

function TcxCustomGridTableViewInfo.GetNavigatorCanvas: TCanvas;
begin
  Result := Canvas.Canvas;
end;

function TcxCustomGridTableViewInfo.GetNavigatorControl: TWinControl;
begin
  Result := Site;
end;

function TcxCustomGridTableViewInfo.GetNavigatorFocused: Boolean;
begin
  Result := False;
end;

function TcxCustomGridTableViewInfo.GetNavigatorLookAndFeel: TcxLookAndFeel;
begin
  if GridView.Control = nil then
    Result := nil
  else
    Result := TcxCustomGrid(GridView.Control).LookAndFeel;
end;

function TcxCustomGridTableViewInfo.GetNavigatorOwner: TComponent;
begin
  Result := GridView;
end;

function TcxCustomGridTableViewInfo.GetNavigatorShowHint: Boolean;
begin  
  Result := GridView.OptionsBehavior.NavigatorHints;
end;

function TcxCustomGridTableViewInfo.GetNavigatorTabStop: Boolean;
begin
  Result := False;
end;

procedure TcxCustomGridTableViewInfo.NavigatorStateChanged;
begin
  FNavigatorViewInfo.UpdateButtonsEnabled;
end;

procedure TcxCustomGridTableViewInfo.RefreshNavigator;
var
  ASize: TPoint;
begin
  if GridView.IsPattern then Exit;
  FNavigatorViewInfo.MakeIsDirty;
  ASize := FNavigatorSize;
  FNavigatorViewInfo.CheckSize(ASize.X, ASize.Y);
  if (FNavigatorSize.X <> ASize.X) or (FNavigatorSize.Y <> ASize.Y) then
    GridView.LayoutChanged
  else
    GridView.ViewChanged;
end;

procedure TcxCustomGridTableViewInfo.CreateViewInfos;
begin
  inherited;
  FNavigatorSiteViewInfo := GetNavigatorSiteViewInfoClass.Create(Self);
  if FNavigatorViewInfo = nil then
    FNavigatorViewInfo := GetNavigatorViewInfoClass.Create(Self);
  FRecordsViewInfo := GetRecordsViewInfoClass.Create(Self);
end;

procedure TcxCustomGridTableViewInfo.DestroyViewInfos(AIsRecreating: Boolean);
begin
  FreeAndNil(FRecordsViewInfo);
  if not AIsRecreating then
    FreeAndNil(FNavigatorViewInfo);
  FreeAndNil(FNavigatorSiteViewInfo);
  inherited;
end;

procedure TcxCustomGridTableViewInfo.AfterCalculating;
begin
  //if CanCheckCoordinates then Controller.CheckCoordinates;
  inherited;
  if CanCheckCoordinates then Controller.DoCheckCoordinates;
  if not IsInternalUse and not SizeCalculating then
    Controller.PostCheckEdit;
end;

procedure TcxCustomGridTableViewInfo.BeforeCalculating;
begin
  inherited;
  CalculateExpandButtonParams;
end;

procedure TcxCustomGridTableViewInfo.BeforeOffset;
begin
  FRecordsViewInfo.BeforeOffset;
end;

procedure TcxCustomGridTableViewInfo.Calculate;
begin
  FRecordsViewInfo.MainCalculate;
  inherited;
  if FNavigatorSiteViewInfo.Visible then
  begin
    with FNavigatorSize do
    begin
      X := 0;
      with GetNavigatorSiteBounds do
        Y := Bottom - Top;
      FNavigatorViewInfo.CheckSize(X, Y);
    end;
    FNavigatorSiteViewInfo.Calculate(GetNavigatorSiteBounds);
    FNavigatorViewInfo.Calculate;
  end;
end;

function TcxCustomGridTableViewInfo.CalculateVisibleEqualHeightRecordCount: Integer;
begin
  Result := -1;
end;

procedure TcxCustomGridTableViewInfo.ControlFocusChanged;
begin
  inherited;
  RecordsViewInfo.ControlFocusChanged;
end;

function TcxCustomGridTableViewInfo.GetDefaultGridModeBufferCount: Integer;
begin
  Result := 0;
end;

procedure TcxCustomGridTableViewInfo.GetHScrollBarBounds(var ABounds: TRect);
begin    
  inherited;
  if FNavigatorSiteViewInfo.Visible then
    Inc(ABounds.Left, FNavigatorSiteViewInfo.Width);
end;

function TcxCustomGridTableViewInfo.GetIsInternalUse: Boolean;
begin
  Result := inherited GetIsInternalUse or FirstRecordIndexAssigned;
end;

function TcxCustomGridTableViewInfo.GetNavigatorOffset: Integer;
begin
  Result := GridView.OptionsView.NavigatorOffset;
end;

function TcxCustomGridTableViewInfo.GetNavigatorSiteBounds: TRect;
begin
  Result := TcxControlAccess(Site).GetHScrollBarBounds;
  with Result do
  begin
    Right := Left;
    Left := Right - FNavigatorSiteViewInfo.Width;
  end;
end;

function TcxCustomGridTableViewInfo.GetNavigatorSiteViewInfoClass: TcxNavigatorSiteViewInfoClass;
begin
  Result := TcxNavigatorSiteViewInfo;
end;

function TcxCustomGridTableViewInfo.GetNavigatorViewInfoClass: TcxNavigatorViewInfoClass;
begin
  Result := TcxNavigatorViewInfo;
end;

function TcxCustomGridTableViewInfo.GetScrollableAreaBounds: TRect;
begin
  Result := ClientBounds;
end;

function TcxCustomGridTableViewInfo.GetScrollableAreaBoundsForEdit: TRect;
begin
  Result := ScrollableAreaBounds;
end;

function TcxCustomGridTableViewInfo.GetScrollableAreaBoundsHorz: TRect;
begin
  Result := ScrollableAreaBounds;
end;

function TcxCustomGridTableViewInfo.GetScrollableAreaBoundsVert: TRect;
begin
  Result := ScrollableAreaBounds;
end;

function TcxCustomGridTableViewInfo.FirstRecordIndexAssigned: Boolean;
begin
  Result := FFirstRecordIndex <> RecordIndexNone;
end;

procedure TcxCustomGridTableViewInfo.Offset(ARecordCountDelta: Integer);
begin  {2}
  RecordsViewInfo.Offset(ARecordCountDelta);
end;

procedure TcxCustomGridTableViewInfo.Offset(DX, DY: Integer);
begin     {2}
  RecordsViewInfo.Offset(DX, DY);
end;

procedure TcxCustomGridTableViewInfo.VisibilityChanged(AVisible: Boolean);
begin
  RecordsViewInfo.VisibilityChanged(AVisible);
  inherited;  // should be here for correct hiding (focus)
end;

procedure TcxCustomGridTableViewInfo.CalculateExpandButtonParams;
begin
  FExpandButtonIndent := 3;
  FLevelIndent := FExpandButtonIndent + ExpandButtonSize + FExpandButtonIndent;
end;

function TcxCustomGridTableViewInfo.CanCheckCoordinates: Boolean;
begin
  Result := not IsInternalUse and FAllowCheckCoordinates;
end;

function TcxCustomGridTableViewInfo.CanOffset(ARecordCountDelta, DX, DY: Integer): Boolean;
begin
  Result := True;
end;

function TcxCustomGridTableViewInfo.CanOffsetView(ARecordCountDelta: Integer): Boolean;
begin            {2}
  Result := RecordsViewInfo.CanOffset(ARecordCountDelta);
end;

function TcxCustomGridTableViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
begin
  if PtInRect(Site.ClientBounds, P) then
    Result := RecordsViewInfo.GetHitTest(P)
  else
    Result := FNavigatorSiteViewInfo.GetHitTest(P);
  if Result = nil then
    Result := inherited GetHitTest(P);
end;

procedure TcxCustomGridTableViewInfo.DoOffset(ARecordCountDelta, DX, DY: Integer);
begin  {2}
  if CanOffset(ARecordCountDelta, DX, DY) then
  begin
    Controller.BeforeOffset;
    BeforeOffset;
    if ARecordCountDelta <> 0 then
      Offset(ARecordCountDelta)
    else
      Offset(DX, DY);
    Controller.AfterOffset;
  end
  else
    Recalculate;
end;

function TcxCustomGridTableViewInfo.GetNearestPopupHeight(AHeight: Integer;
  AAdditionalRecord: Boolean = False): Integer;
begin
  Result := AHeight;
end;

function TcxCustomGridTableViewInfo.GetPopupHeight(ADropDownRecordCount: Integer): Integer;
begin
  Result := 0;
end;

{ TcxCustomGridTableViewInfoCacheItem }

function TcxCustomGridTableViewInfoCacheItem.GetGridRecord: TcxCustomGridRecord;
begin
  Result := TcxCustomGridTableViewInfoCache(Owner).ViewData.Records[Index];
end;

procedure TcxCustomGridTableViewInfoCacheItem.SetHeight(Value: Integer);
begin
  FHeight := Value;
  IsHeightAssigned := True;
end;

procedure TcxCustomGridTableViewInfoCacheItem.UnassignValues(AKeepMaster: Boolean);
begin
  inherited;
  IsHeightAssigned := False;
end;

{ TcxCustomGridTableViewInfoCache }

function TcxCustomGridTableViewInfoCache.GetViewData: TcxCustomGridTableViewData;
begin
  Result := TcxCustomGridTableViewData(inherited ViewData);
end;

function TcxCustomGridTableViewInfoCache.GetItemClass: TcxCustomGridViewInfoCacheItemClass;
begin
  Result := TcxCustomGridTableViewInfoCacheItem;
end;

{ TcxCustomGridTableItemCustomOptions }

constructor TcxCustomGridTableItemCustomOptions.Create(AItem: TcxCustomGridTableItem);
begin
  inherited Create;
  FItem := AItem;
end;

function TcxCustomGridTableItemCustomOptions.GetGridView: TcxCustomGridTableView;
begin
  Result := FItem.GridView;
end;

procedure TcxCustomGridTableItemCustomOptions.Changed;
begin
  FItem.Changed(ticLayout);
end;

procedure TcxCustomGridTableItemCustomOptions.Assign(Source: TPersistent);
begin
  if not (Source is TcxCustomGridTableItemCustomOptions) then
    inherited;
end;

{ TcxCustomGridTableItemOptions }

constructor TcxCustomGridTableItemOptions.Create(AItem: TcxCustomGridTableItem);
begin
  inherited;
  FEditing := True;
  FFiltering := True;
  FFocusing := True;
  FGrouping := True;
  FIncSearch := True;
  FMoving := True;
  FSorting := True;
end;

procedure TcxCustomGridTableItemOptions.SetEditing(Value: Boolean);
begin
  if FEditing <> Value then
  begin
    FEditing := Value;
    if not FEditing then FItem.Editing := False;
  end;
end;

procedure TcxCustomGridTableItemOptions.SetFiltering(Value: Boolean);
begin
  if FFiltering <> Value then
  begin
    FFiltering := Value;
    GridView.RefreshFilterableItemsList;
    Changed;
  end;
end;

procedure TcxCustomGridTableItemOptions.SetFocusing(Value: Boolean);
begin
  if FFocusing <> Value then
  begin
    FFocusing := Value;
    if not FFocusing then Item.Focused := False;
  end;
end;

procedure TcxCustomGridTableItemOptions.SetIncSearch(Value: Boolean);
begin
  if FIncSearch <> Value then
  begin
    if not Value and Item.IncSearching then
      GridView.Controller.CancelIncSearching;
    FIncSearch := Value;
  end;
end;

procedure TcxCustomGridTableItemOptions.SetShowEditButtons(Value: TcxGridItemShowEditButtons);
begin
  if FShowEditButtons <> Value then
  begin
    FShowEditButtons := Value;
    Changed;
  end;
end;

procedure TcxCustomGridTableItemOptions.Assign(Source: TPersistent);
begin
  if Source is TcxCustomGridTableItemOptions then
    with TcxCustomGridTableItemOptions(Source) do
    begin
      Self.Editing := Editing;
      Self.Filtering := Filtering;
      Self.Focusing := Focusing;
      Self.Grouping := Grouping;
      Self.IncSearch := IncSearch;
      Self.Moving := Moving;
      Self.ShowEditButtons := ShowEditButtons;
      Self.Sorting := Sorting;
    end;
  inherited;
end;

{ TcxCustomGridTableItemStyles }

function TcxCustomGridTableItemStyles.GetGridViewValue: TcxCustomGridTableView;
begin
  Result := TcxCustomGridTableView(inherited GridView);
end;

function TcxCustomGridTableItemStyles.GetItem: TcxCustomGridTableItem;
begin
  Result := TcxCustomGridTableItem(GetOwner);
end;

procedure TcxCustomGridTableItemStyles.GetDefaultViewParams(Index: Integer; AData: TObject;
  out AParams: TcxViewParams);
begin
  case Index of
    isContent:
      GridView.Styles.GetRecordContentParams(TcxCustomGridRecord(AData), Item, AParams);
  else
    inherited;
  end;
end;

function TcxCustomGridTableItemStyles.GetGridView: TcxCustomGridView;
begin
  Result := Item.GridView;
end;

procedure TcxCustomGridTableItemStyles.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TcxCustomGridTableItemStyles then
    with TcxCustomGridTableItemStyles(Source) do
    begin
      Self.Content := Content;
      Self.OnGetContentStyle := OnGetContentStyle;
    end;
end;

procedure TcxCustomGridTableItemStyles.GetContentParams(ARecord: TcxCustomGridRecord;
  out AParams: TcxViewParams);
var
  AStyle: TcxStyle;
begin
  AStyle := nil;
  if (ARecord <> nil) and Assigned(FOnGetContentStyle) then
    FOnGetContentStyle(GridView, ARecord, Item, AStyle);
  GetViewParams(isContent, ARecord, AStyle, AParams);
end;

{ TcxCustomGridTableItem }

constructor TcxCustomGridTableItem.Create(AOwner: TComponent);
begin
  inherited;
  FCells := TList.Create;
  FIndex := -1;
  FMinWidth := cxGridItemDefaultMinWidth;
  FVisibleIndex := -1;
  CreateSubClasses;
end;

destructor TcxCustomGridTableItem.Destroy;
var
  I: Integer;
begin
  RepositoryItem := nil;
  FGridView.RemoveItem(Self);
  if FLastUsedDefaultRepositoryItem <> nil then
    ItemRemoved(FLastUsedDefaultRepositoryItem);
  DestroySubClasses;
  FreeAndNil(FEditData);
  FreeAndNil(FCellStyle);
  for I := 0 to CellCount - 1 do Cells[I].FItem := nil;
  FCells.Free;
  inherited;
end;

function TcxCustomGridTableItem.GetActualMinWidth: Integer;
begin
  if CanHorzSize then
    Result := FMinWidth
  else
    Result := 0;
end;

function TcxCustomGridTableItem.GetCaption: string;
begin
  if FIsCaptionAssigned then
    Result := FCaption
  else
    Result := DefaultCaption;
end;

function TcxCustomGridTableItem.GetCell(Index: Integer): TcxGridTableDataCellViewInfo;
begin
  Result := FCells[Index];
end;

function TcxCustomGridTableItem.GetCellCount: Integer;
begin
  Result := FCells.Count;
end;

function TcxCustomGridTableItem.GetController: TcxCustomGridTableController;
begin
  Result := FGridView.Controller;
end;

function TcxCustomGridTableItem.GetDataController: TcxCustomDataController;
begin
  Result := FGridView.DataController;
end;

function TcxCustomGridTableItem.GetEditing: Boolean;
begin
  Result := Controller.EditingItem = Self;
end;

function TcxCustomGridTableItem.GetEditingProperties: TcxCustomEditProperties;
begin
  if Controller.EditingController.IsEditing then
    Result := TcxCustomEditAccess(Controller.EditingController.Edit).Properties
  else
    Result := GetProperties(Controller.FocusedRecord);
end;

function TcxCustomGridTableItem.GetFilterCaption: string;
begin
  Result := Caption;  //!!!
end;

function TcxCustomGridTableItem.GetFiltered: Boolean;
begin
  Result := FDataBinding.Filtered;
end;

function TcxCustomGridTableItem.GetFocused: Boolean;
begin
  Result := Controller.FocusedItem = Self;
end;

function TcxCustomGridTableItem.GetGroupIndex: Integer;
begin
  Result := DataController.Groups.ItemGroupIndex[Index];
end;

function TcxCustomGridTableItem.GetHeaderAlignmentHorz: TAlignment;
begin
  if FIsHeaderAlignmentHorzAssigned then
    Result := FHeaderAlignmentHorz
  else
    Result := DefaultHeaderAlignmentHorz;
end;

function TcxCustomGridTableItem.GetHeaderAlignmentVert: TcxAlignmentVert;
begin
  if FIsHeaderAlignmentVertAssigned then
    Result := FHeaderAlignmentVert
  else
    Result := DefaultHeaderAlignmentVert;
end;

{function TcxCustomGridTableItem.GetHidden: Boolean;
begin
  Result := FHidden or IsPreview;
end;}

function TcxCustomGridTableItem.GetIsLoading: Boolean;
begin
  Result := not FIgnoreLoadingStatus and
    ((csLoading in ComponentState) or FGridView.IsLoading);
end;

function TcxCustomGridTableItem.GetIncSearching: Boolean;
begin
  Result := Controller.IncSearchingItem = Self;
end;

function TcxCustomGridTableItem.GetIsDestroying: Boolean;
begin
  Result := csDestroying in ComponentState;
end;

function TcxCustomGridTableItem.GetIsFirst: Boolean;
begin
  Result := VisibleIndex = 0;
end;

function TcxCustomGridTableItem.GetIsLast: Boolean;
begin
  Result := VisibleIndex = FGridView.VisibleItemCount - 1;
end;

function TcxCustomGridTableItem.GetIsUpdating: Boolean;
begin
  Result := csUpdating in ComponentState;
end;

function TcxCustomGridTableItem.GetMinWidth: Integer;
begin
  if CanHorzSize then
    Result := FMinWidth
  else
    Result := Width;
end;

function TcxCustomGridTableItem.GetPropertiesClassName: string;
begin
  if FProperties = nil then
    Result := ''
  else
    Result := FProperties.ClassName;
end;

function TcxCustomGridTableItem.GetSortIndex: Integer;
begin
  Result := DataController.GetItemSortingIndex(Index);
end;

function TcxCustomGridTableItem.GetSortOrder: TcxGridSortOrder;
begin
  Result := DataController.GetItemSortOrder(Index);
end;

function TcxCustomGridTableItem.GetViewData: TcxCustomGridTableViewData;
begin
  Result := FGridView.ViewData;
end;

function TcxCustomGridTableItem.GetWidth: Integer;
begin
  if FIsWidthAssigned then
    Result := FWidth
  else
    Result := DefaultWidth;
end;

procedure TcxCustomGridTableItem.SetCaption(const Value: string);
begin
  if Caption <> Value then
  begin
    FCaption := Value;
    FIsCaptionAssigned := True;
    CaptionChanged;
  end;
end;

procedure TcxCustomGridTableItem.SetDataBinding(Value: TcxGridItemDataBinding);
begin
  FDataBinding.Assign(Value);
end;

procedure TcxCustomGridTableItem.SetEditing(Value: Boolean);
begin
  if Value then
    Controller.EditingItem := Self
  else
    if Editing then
      Controller.EditingItem := nil;
end;

procedure TcxCustomGridTableItem.SetFiltered(Value: Boolean);
begin
  FDataBinding.Filtered := Value;
end;

procedure TcxCustomGridTableItem.SetFocused(Value: Boolean);
begin
  if Value then
    Controller.FocusedItem := Self
  else
    if Focused then
      if not Controller.FocusNextItem(VisibleIndex, True, True, False) then
        Controller.FocusedItem := nil;
end;

procedure TcxCustomGridTableItem.SetGroupIndex(Value: Integer);
begin
  if GroupIndex <> Value then
  begin
    ShowHourglassCursor;
    try
      if GroupIndex = -1 then
        FWasVisibleBeforeGrouping := Visible;
      DataController.Groups.ChangeGrouping(Index, Value);
    finally
      HideHourglassCursor;
    end;
  end;  
end;

procedure TcxCustomGridTableItem.SetHeaderAlignmentHorz(Value: TAlignment);
begin
  if HeaderAlignmentHorz <> Value then
  begin
    FHeaderAlignmentHorz := Value;
    FIsHeaderAlignmentHorzAssigned := True;
    Changed(ticLayout);
  end;
end;

procedure TcxCustomGridTableItem.SetHeaderAlignmentVert(Value: TcxAlignmentVert);
begin
  if HeaderAlignmentVert <> Value then
  begin
    FHeaderAlignmentVert := Value;
    FIsHeaderAlignmentVertAssigned := True;
    Changed(ticLayout);
  end;
end;

{procedure TcxCustomGridTableItem.SetHidden(Value: Boolean);
begin
  if Hidden <> Value then
  begin
    FHidden := Value;
    HiddenChanged;
  end;
end;}

procedure TcxCustomGridTableItem.SetIndex(Value: Integer);
begin
  FGridView.ChangeItemIndex(Self, Value);
end;

procedure TcxCustomGridTableItem.SetMinWidth(Value: Integer);
var
  AWidthChanging: Boolean;
begin
  if Value < 0 then Value := 0;
  if FMinWidth <> Value then
  begin
    AWidthChanging := Width < Value;
    FMinWidth := Value;
    if IsLoading then Exit;
    if Width < FMinWidth then
      Width := FMinWidth
    else
      if AWidthChanging then Changed(ticSize);
  end;
end;

procedure TcxCustomGridTableItem.SetOnGetProperties(Value: TcxGridGetPropertiesEvent);
begin
  if @FOnGetProperties <> @Value then
  begin
    FOnGetProperties := Value;
    Changed(ticLayout);
  end;
end;

procedure TcxCustomGridTableItem.SetOptions(Value: TcxCustomGridTableItemOptions);
begin
  FOptions.Assign(Value);
end;

procedure TcxCustomGridTableItem.SetProperties(Value: TcxCustomEditProperties);
begin
  if (FProperties <> nil) and (Value <> nil) then FProperties.Assign(Value);
end;

procedure TcxCustomGridTableItem.SetPropertiesClass(Value: TcxCustomEditPropertiesClass);
begin
  if FPropertiesClass <> Value then
  begin
    if FProperties <> nil then
      Controller.EditingController.RemoveEdit(FProperties);
    FPropertiesClass := Value;
    RecreateProperties;
    PropertiesValueChanged;
    PropertiesChanged;
  end;
end;

procedure TcxCustomGridTableItem.SetPropertiesClassName(const Value: string);
begin
  PropertiesClass := TcxCustomEditPropertiesClass(GetRegisteredEditProperties.FindByClassName(Value));
end;

procedure TcxCustomGridTableItem.SetRepositoryItem(Value: TcxEditRepositoryItem);
begin
  if FRepositoryItem <> Value then
  begin
    if FRepositoryItem <> nil then
    begin
      FRepositoryItem.RemoveListener(Self);
      Controller.EditingController.RemoveEdit(FRepositoryItem.Properties);
    end;
    FRepositoryItem := Value;
    if FRepositoryItem <> nil then
      FRepositoryItem.AddListener(Self);
    PropertiesValueChanged;
    PropertiesChanged;
  end;
end;

procedure TcxCustomGridTableItem.SetSortIndex(Value: Integer);
begin
  if SortIndex <> Value then
  begin
    ShowHourglassCursor;
    try
      DataController.ChangeItemSortingIndex(Index, Value);
    finally
      HideHourglassCursor;
    end;
  end;
end;

procedure TcxCustomGridTableItem.SetSortOrder(Value: TcxGridSortOrder);
begin
  if SortOrder <> Value then
  begin
    ShowHourglassCursor;
    try
      DataController.ChangeSorting(Index, Value);
    finally
      HideHourglassCursor;
    end;
  end;
end;

procedure TcxCustomGridTableItem.SetStyles(Value: TcxCustomGridTableItemStyles);
begin
  FStyles.Assign(Value);
end;

procedure TcxCustomGridTableItem.SetVisible(Value: Boolean);
begin
  if Visible <> Value then
  begin
    FVisible := Value;
    GridView.ItemVisibilityChanged(Self, Value);
  end;
end;

procedure TcxCustomGridTableItem.SetVisibleIndex(Value: Integer);
var
  AVisibleIndex: Integer;
begin
  AVisibleIndex := GetVisibleIndex;
  if (AVisibleIndex <> -1) and (AVisibleIndex <> Value) then
    if Value = -1 then
    begin
      FGridView.FVisibleItems.Delete(AVisibleIndex);
      FVisibleIndex := -1;
    end
    else
      FGridView.FVisibleItems.Move(AVisibleIndex, Value);
end;

procedure TcxCustomGridTableItem.SetWidth(Value: Integer);
begin
  CheckWidthValue(Value);
  if IsLoading or (Width <> Value) then
  begin
    FWidth := Value;
    FIsWidthAssigned := True;
    Changed(ticSize);
  end;
end;

procedure TcxCustomGridTableItem.ReadIsCaptionAssigned(Reader: TReader);
begin
  FIsCaptionAssigned := Reader.ReadBoolean;
end;

procedure TcxCustomGridTableItem.WriteIsCaptionAssigned(Writer: TWriter);
begin
  Writer.WriteBoolean(FIsCaptionAssigned);
end;

function TcxCustomGridTableItem.IsCaptionStored: Boolean;
begin
  Result := FIsCaptionAssigned and (FCaption <> DefaultCaption);
end;

{function TcxCustomGridTableItem.IsHiddenStored: Boolean;
begin
  Result := Hidden and not IsPreview;
end;}

function TcxCustomGridTableItem.IsWidthStored: Boolean;
begin
  Result := FIsWidthAssigned //and (FWidth <> DefaultWidth);
end;

function TcxCustomGridTableItem.GetDataBindingClass: TcxGridItemDataBindingClass;
begin
  Result := FGridView.GetItemDataBindingClass;
end;

procedure TcxCustomGridTableItem.CreateProperties;
begin
  if FPropertiesClass <> nil then
  begin
    FProperties := FPropertiesClass.Create(Self);
    TcxCustomEditPropertiesAccess(FProperties).OnPropertiesChanged := PropertiesChanged;
  end;
end;

procedure TcxCustomGridTableItem.DestroyProperties;
begin
  FreeAndNil(FProperties);
end;

procedure TcxCustomGridTableItem.RecreateProperties;
begin
  DestroyProperties;
  CreateProperties;
end;

procedure TcxCustomGridTableItem.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('IsCaptionAssigned', ReadIsCaptionAssigned, WriteIsCaptionAssigned,
    FIsCaptionAssigned and (Caption = ''));
end;

procedure TcxCustomGridTableItem.SetParentComponent(AParent: TComponent);
begin
  if AParent is TcxCustomGridTableView then
    TcxCustomGridTableView(AParent).AddItem(Self);
end;

procedure TcxCustomGridTableItem.ItemRemoved(Sender: TcxEditRepositoryItem);
begin
  if Sender = FLastUsedDefaultRepositoryItem then
    PropertiesValueChanged
  else
    RepositoryItem := nil;
end;

procedure TcxCustomGridTableItem.PropertiesChanged(Sender: TcxEditRepositoryItem);
begin
  PropertiesChanged;
end;

function TcxCustomGridTableItem.GetObjectName: string;
begin
  if GridView.IsStoringNameMode then
    Result := IntToStr(ID)
  else
    Result := Name;
end;

function TcxCustomGridTableItem.GetStoredProperties(AProperties: TStrings): Boolean;
begin
  with AProperties do
  begin
    Add('AlignmentHorz');
    Add('Index');
    Add('Visible');
    //Add('Caption');
    Add('SortOrder');
    Add('SortIndex');
  end;
  Result := True;
end;

procedure TcxCustomGridTableItem.GetPropertyValue(const AName: string; var AValue: Variant);
begin
  if AName = 'AlignmentHorz' then
    AValue := Integer(TcxCustomEditPropertiesAccess(GetProperties).Alignment.Horz)
  else
    if AName = 'Index' then
      AValue := Index
    else
      if AName = 'Visible' then
        AValue := Visible
      else
        {if AName = 'Caption' then
          AValue := Caption
        else}
          if AName = 'SortOrder' then
            AValue := SortOrder
          else
            if AName = 'SortIndex' then
              AValue := SortIndex
            else
              AValue := Null;
end;

procedure TcxCustomGridTableItem.SetPropertyValue(const AName: string; const AValue: Variant);
begin
  if AName = 'AlignmentHorz' then
    if TcxCustomEditPropertiesAccess(GetProperties).Alignment.Horz <> AValue then
    begin
      if (FRepositoryItem = nil) and (FProperties = nil) then
        PropertiesClass := TcxCustomEditPropertiesClass(GetProperties.ClassType);
      TcxCustomEditPropertiesAccess(GetProperties).Alignment.Horz := AValue;
    end
    else
  else
    if AName = 'Index' then
      Index := AValue
    else
      if AName = 'Visible' then
        Visible := AValue
      else
        {if AName = 'Caption' then
          Caption := AValue
        else}
          if AName = 'SortOrder' then
            SortOrder := AValue
          else
            if AName = 'SortIndex' then
              SortIndex := AValue;
end;

procedure TcxCustomGridTableItem.CreateDataBinding;
begin
  FDataBinding := GetDataBindingClass.Create(Self);
  with FDataBinding do
    FDataBinding.ValueTypeClass := TcxStringValueType;
end;

procedure TcxCustomGridTableItem.DestroyDataBinding;
begin
  FreeAndNil(FDataBinding);
end;

procedure TcxCustomGridTableItem.CreateSubClasses;
begin
  FOptions := GetOptionsClass.Create(Self);
  FStyles := GetStylesClass.Create(Self);
end;

procedure TcxCustomGridTableItem.DestroySubClasses;
begin
  DestroyProperties;
  FreeAndNil(FStyles);
  FreeAndNil(FOptions);
end;

function TcxCustomGridTableItem.IsHeaderAlignmentHorzStored: Boolean;
begin
  Result := FIsHeaderAlignmentHorzAssigned and
    (FHeaderAlignmentHorz <> DefaultHeaderAlignmentHorz);
end;

function TcxCustomGridTableItem.IsHeaderAlignmentVertStored: Boolean;
begin
  Result := FIsHeaderAlignmentVertAssigned and
    (FHeaderAlignmentVert <> DefaultHeaderAlignmentVert);
end;

function TcxCustomGridTableItem.CanAutoHeight: Boolean;
begin
  Result := esoAutoHeight in GetProperties.GetSupportedOperations;
end;

function TcxCustomGridTableItem.CanEdit: Boolean;
begin
  Result := CanFocus and GridView.OptionsData.Editing and
    FOptions.Editing and (FocusedCellViewInfo <> nil) and
    (dceoShowEdit in DataController.EditOperations);
end;

function TcxCustomGridTableItem.CanFilter(ACheckGridViewOptions: Boolean): Boolean;
begin
  Result := (esoFiltering in GetProperties.GetSupportedOperations) and Options.Filtering;
end;

function TcxCustomGridTableItem.CanFocus: Boolean;
begin
  Result := ActuallyVisible and GridView.OptionsSelection.CellSelect and
    FOptions.Focusing;
end;

function TcxCustomGridTableItem.CanGroup: Boolean;
begin
  Result := (esoSorting in GetProperties.GetSupportedOperations) and
    GridView.OptionsCustomize.ItemGrouping and FOptions.Grouping;
end;

function TcxCustomGridTableItem.CanHide: Boolean;
begin
  Result := not (IsFirst and IsLast) and CanMove;
end;

function TcxCustomGridTableItem.CanHorzSize: Boolean;
begin
  Result := True;
end;

function TcxCustomGridTableItem.CanIncSearch: Boolean;
begin
  Result := (esoIncSearch in GetProperties.GetSupportedOperations) and
    GridView.OptionsBehavior.IncSearch and FOptions.IncSearch;
end;

function TcxCustomGridTableItem.CanInitEditing: Boolean;
begin
  Result := DataController.CanInitEditing(Index);
end;

function TcxCustomGridTableItem.CanMove: Boolean;
begin
  Result := GridView.OptionsCustomize.ItemMoving and Options.Moving;
end;

function TcxCustomGridTableItem.CanScroll: Boolean;
begin
  Result := True;
end;

function TcxCustomGridTableItem.CanSort: Boolean;
begin
  Result := (esoSorting in GetProperties.GetSupportedOperations) and
    GridView.OptionsCustomize.ItemSorting and Options.Sorting;
end;

procedure TcxCustomGridTableItem.CaptionChanged;
begin
  if ActuallyVisible or (GroupIndex <> -1) then Changed(ticLayout);
end;

procedure TcxCustomGridTableItem.Changed(AChange: TcxGridTableItemChange);
begin
  if GridView <> nil then
    case AChange of
      ticLayout:
        GridView.LayoutChanged;
      ticSize:
        GridView.SizeChanged;
    end;
end;

procedure TcxCustomGridTableItem.CheckWidthValue(var Value: Integer);
begin
  if Value < ActualMinWidth then Value := ActualMinWidth;
end;

procedure TcxCustomGridTableItem.DataChanged;
begin
  FDataBinding.Init;
end;

procedure TcxCustomGridTableItem.ForceWidth(Value: Integer);
begin
  Controller.ForcingWidthItem := Self;
  try
    Width := Value;
  finally
    Controller.ForcingWidthItem := nil;
  end;
end;

function TcxCustomGridTableItem.GetActuallyVisible: Boolean;
begin
  Result := Visible;
end;

function TcxCustomGridTableItem.GetBestFitWidth: Integer;
var
  ACanvas: TcxCanvas;
  AIsCalcByValue: Boolean;
  AEditSizeProperties: TcxEditSizeProperties;
  AParams: TcxViewParams;
  AEditViewData: TcxCustomEditViewData;
  I, AWidth: Integer;
  ARecord: TcxCustomGridRecord;
  AValue: Variant;
  AEditMinContentSize: TSize;

  function GetFirstRecordIndex: Integer;
  begin
    Result := GridView.OptionsBehavior.BestFitMaxRecordCount;
    if Result <> 0 then
    begin
      Result := Controller.TopRecordIndex;
      if Result < 0 then Result := 0;
    end;  
  end;

  function GetLastRecordIndex: Integer;
  begin
    Result := GridView.OptionsBehavior.BestFitMaxRecordCount;
    if Result = 0 then
      Result := ViewData.RecordCount
    else
    begin
      Result := GetFirstRecordIndex + Result;
      if Result > ViewData.RecordCount then
        Result := ViewData.RecordCount;
    end;
    Dec(Result);
  end;

begin
  Result := 0;
  ACanvas := FGridView.Painter.Canvas;
  AIsCalcByValue := GetProperties.GetEditValueSource(False) = evsValue;
  with AEditSizeProperties do
  begin
    Height := -1;
    MaxLineCount := 0;
    Width := -1;
  end;
  AEditViewData := CreateEditViewData(GetProperties);
  try
    for I := GetFirstRecordIndex to GetLastRecordIndex do
    begin
      ARecord := ViewData.Records[I];
      if ARecord.HasCells then
      begin
        FStyles.GetContentParams(ARecord, AParams);
        InitStyle(AEditViewData.Style, AParams, True);
        if AIsCalcByValue then
          AValue := ARecord.Values[FIndex]
        else
          AValue := ARecord.DisplayTexts[FIndex];
        AWidth := AEditViewData.GetEditContentSize(ACanvas, AValue, AEditSizeProperties).cx;
        if AWidth > Result then Result := AWidth;
      end;
    end;

    FStyles.GetContentParams(nil, AParams);
    InitStyle(AEditViewData.Style, AParams, True);
    AWidth := AEditViewData.GetEditConstantPartSize(ACanvas, AEditSizeProperties,
      AEditMinContentSize).cx;
    if Result < AEditMinContentSize.cx then
      Result := AEditMinContentSize.cx;
    Inc(Result, AWidth);
  finally
    DestroyEditViewData(AEditViewData);
  end;
  if Result <> 0 then
    Inc(Result, 2 * cxGridEditOffset);
end;

function TcxCustomGridTableItem.GetEditPartVisible: Boolean;
var
  R: TRect;
begin
  if CanScroll then
  begin
    R := GridView.ViewInfo.ScrollableAreaBoundsForEdit;
    with FocusedCellViewInfo.EditBounds do
      Result :=
        (Left < R.Left) or (Right > R.Right) or
        (Top < R.Top) or (Bottom > R.Bottom);
  end
  else
    Result := False;
end;

function TcxCustomGridTableItem.GetEditValue: Variant;
begin
  if Controller.FocusedRecord <> nil then
    Result := DataController.GetEditValue(Index, EditingProperties.GetEditValueSource(True))
  else
    Result := Unassigned;
end;

function TcxCustomGridTableItem.GetFilterable: Boolean;
begin
  Result := CanFilter(False);
end;

procedure TcxCustomGridTableItem.GetFilterDisplayText(const AValue: Variant;
  var ADisplayText: string);
begin
  if Assigned(FOnGetFilterDisplayText) then
    FOnGetFilterDisplayText(Self, AValue, ADisplayText);
end;

function TcxCustomGridTableItem.GetFixed: Boolean;
begin
  Result := GridView.Controller.ForcingWidthItem = Self;
end;

function TcxCustomGridTableItem.GetFocusedCellViewInfo: TcxGridTableDataCellViewInfo;
begin
  with Controller do
    if FocusedRecordHasCells(False) and (FocusedRecord.ViewInfo <> nil) then
      Result := FocusedRecord.ViewInfo.GetCellViewInfoByItem(Self)
    else
      Result := nil;
end;

function TcxCustomGridTableItem.GetPropertiesValue: TcxCustomEditProperties;
begin
  if FLastUsedDefaultRepositoryItem <> nil then
  begin
    FLastUsedDefaultRepositoryItem.RemoveListener(Self);
    FLastUsedDefaultRepositoryItem := nil;
  end;
  if FGridView = nil then  // because of EditViewData - it needs Style which needs GridView
    Result := nil
  else
    if UseOwnProperties then
      Result := FProperties
    else
      if GetRepositoryItem = nil then
        Result := nil
      else
        Result := GetRepositoryItem.Properties;
end;

function TcxCustomGridTableItem.GetVisible: Boolean;
begin
  Result := FVisible;
end;

function TcxCustomGridTableItem.GetVisibleIndex: Integer;
begin
  Result := FGridView.FVisibleItems.IndexOf(Self);
end;

function TcxCustomGridTableItem.HasCustomDrawCell: Boolean;
begin
  Result := Assigned(FOnCustomDrawCell);
end;

{procedure TcxCustomGridTableItem.HiddenChanged;
begin
  FGridView.RefreshCustomizationForm;
end;}

procedure TcxCustomGridTableItem.InitProperties(AProperties: TcxCustomEditProperties);
begin
  if AProperties <> nil then
    with TcxCustomEditPropertiesAccess(AProperties) do
    begin
      LockUpdate(True);
      IDefaultValuesProvider := GetDefaultValuesProvider(AProperties);
      LockUpdate(False);
    end;
end;

function TcxCustomGridTableItem.IsVisibleStored: Boolean;
begin
  Result := not Visible;
end;

procedure TcxCustomGridTableItem.PropertiesChanged;
begin
  if not IsDestroying then
    GridView.RefreshFilterableItemsList;
  if FEditData <> nil then FEditData.Clear;
  if not IsDestroying then Changed(ticSize);
end;

procedure TcxCustomGridTableItem.PropertiesChanged(Sender: TObject);
begin
  PropertiesChanged;
end;

procedure TcxCustomGridTableItem.PropertiesValueChanged;
begin
  FPropertiesValue := GetPropertiesValue;
end;

procedure TcxCustomGridTableItem.RecalculateDefaultWidth;
begin
  if not FIsWidthAssigned then
    FWidth := DefaultWidth;
end;

procedure TcxCustomGridTableItem.SetEditValue(const Value: Variant);
begin
  DataController.SetEditValue(Index, Value, EditingProperties.GetEditValueSource(True));
end;

procedure TcxCustomGridTableItem.SetGridView(Value: TcxCustomGridTableView);
begin
  FGridView := Value;
  if Value <> nil then
    CreateDataBinding
  else
    DestroyDataBinding;
  PropertiesValueChanged;
end;

function TcxCustomGridTableItem.ShowButtons(AFocused: Boolean): Boolean;
var
  AGridShowEditButtons: TcxGridShowEditButtons;
begin
  AGridShowEditButtons := FGridView.OptionsView.ShowEditButtons;
  Result :=
    (FOptions.ShowEditButtons = isebAlways) or
    (FOptions.ShowEditButtons = isebDefault) and
    ((AGridShowEditButtons = gsebAlways) or
     (AGridShowEditButtons = gsebForFocusedRecord) and AFocused);
end;

function TcxCustomGridTableItem.ShowOnUngrouping: Boolean;
begin
  Result := True; //!!!
end;

function TcxCustomGridTableItem.GetOptionsClass: TcxCustomGridTableItemOptionsClass;
begin
  Result := TcxCustomGridTableItemOptions;
end;

function TcxCustomGridTableItem.GetStylesClass: TcxCustomGridTableItemStylesClass;
begin
  Result := TcxCustomGridTableItemStyles;
end;

function TcxCustomGridTableItem.UseOwnProperties: Boolean;
begin
  Result := (FRepositoryItem = nil) and (FProperties <> nil);
end;

procedure TcxCustomGridTableItem.ValueTypeClassChanged;
begin
  PropertiesValueChanged;
  if FProperties <> nil then
    TcxCustomEditPropertiesAccess(FProperties).Changed;
end;

{procedure TcxCustomGridTableItem.VisibleChanged;
begin
  //FGridView.RefreshVisibleColumnsList;
  //FGridView.RefreshCustomizationForm;
end;}

function TcxCustomGridTableItem.DefaultCaption: string;
begin
  Result := FDataBinding.DefaultCaption;
end;

function TcxCustomGridTableItem.DefaultHeaderAlignmentHorz: TAlignment;
begin
  Result := taLeftJustify;
end;

function TcxCustomGridTableItem.DefaultHeaderAlignmentVert: TcxAlignmentVert;
begin
  Result := vaTop;
end;

function TcxCustomGridTableItem.DefaultRepositoryItem: TcxEditRepositoryItem;
begin
  if FDataBinding = nil then
    Result := nil
  else
    Result := FDataBinding.DefaultRepositoryItem;
end;

function TcxCustomGridTableItem.DefaultWidth: Integer;
begin
  Result := FDataBinding.DefaultWidth;
end;

function TcxCustomGridTableItem.GetCellStyle: TcxEditStyle;
begin
  if FCellStyle = nil then
    FCellStyle := CreateEditStyle;
  Result := FCellStyle;
  Inc(FCellStyleUseCounter);
end;

procedure TcxCustomGridTableItem.InitStyle(AStyle: TcxCustomEditStyle;
  AParams: TcxViewParams; AFocused: Boolean);
begin
  with AParams do
  begin
    AStyle.Color := Color;
    AStyle.Font := Font;
    AStyle.StyleData.FontColor := TextColor;
  end;
  with AStyle do
  begin
    if Self.ShowButtons(AFocused) then
      ButtonTransparency := ebtNone
    else
      ButtonTransparency := ebtHideInactive;
    HotTrack := True;
  end;
end;

procedure TcxCustomGridTableItem.ReleaseCellStyle;
begin
  Dec(FCellStyleUseCounter);
  if FCellStyleUseCounter = 0 then FreeAndNil(FCellStyle);
end;

procedure TcxCustomGridTableItem.AddCell(ACell: TcxGridTableDataCellViewInfo);
begin
  FCells.Add(ACell);
end;

procedure TcxCustomGridTableItem.RemoveCell(ACell: TcxGridTableDataCellViewInfo);
begin
  FCells.Remove(ACell);
end;

function TcxCustomGridTableItem.CreateEditViewData(AProperties: TcxCustomEditProperties): TcxCustomEditViewData;
begin
  if AProperties <> nil then
    Result := AProperties.CreateViewData(GetCellStyle, True)
  else
    Result := nil;
end;

procedure TcxCustomGridTableItem.DestroyEditViewData(var AEditViewData: TcxCustomEditViewData);
begin
  if AEditViewData <> nil then
  begin
    FreeAndNil(AEditViewData);
    ReleaseCellStyle;
  end;
end;

procedure TcxCustomGridTableItem.DoCreateEditViewData;
begin
  FEditViewData := CreateEditViewData(GetProperties);
end;

procedure TcxCustomGridTableItem.DoDestroyEditViewData;
begin
  DestroyEditViewData(FEditViewData);
end;

function TcxCustomGridTableItem.GetEditViewData(AProperties: TcxCustomEditProperties;
  out AIsLocalCopy: Boolean): TcxCustomEditViewData;
begin
  AIsLocalCopy := Assigned(FOnGetProperties) or (FEditViewData = nil);
  if AIsLocalCopy then
    Result := CreateEditViewData(AProperties)
  else
    Result := FEditViewData;
end;

procedure TcxCustomGridTableItem.ReleaseEditViewData(var AEditViewData: TcxCustomEditViewData;
  AIsLocalCopy: Boolean);
begin
  if AIsLocalCopy then
    DestroyEditViewData(AEditViewData)
  else
    AEditViewData := nil;
end;

procedure TcxCustomGridTableItem.DoCustomDrawCell(ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if HasCustomDrawCell then
    FOnCustomDrawCell(GridView, ACanvas, AViewInfo, ADone);
end;

procedure TcxCustomGridTableItem.DoGetDisplayText(ARecord: TcxCustomGridRecord;
  var AText: string);
begin                                              
  if Assigned(FOnGetDisplayText) then FOnGetDisplayText(Self, ARecord, AText);
end;

procedure TcxCustomGridTableItem.DoGetFilterValues(AValueList: TcxDataFilterValueList);
begin
  if Assigned(FOnGetFilterValues) then FOnGetFilterValues(Self, AValueList);
end;

function TcxCustomGridTableItem.DoGetProperties(ARecord: TcxCustomGridRecord): TcxCustomEditProperties;
begin
  Result := FPropertiesValue;
  if Assigned(FOnGetProperties) then FOnGetProperties(Self, ARecord, Result);
end;

procedure TcxCustomGridTableItem.Assign(Source: TPersistent);
begin                         
  if Source is TcxCustomGridTableItem then
    with TcxCustomGridTableItem(Source) do
    begin
      Self.DataBinding := DataBinding;
      Self.FIsCaptionAssigned := FIsCaptionAssigned;
      Self.Caption := Caption;
      Self.GroupIndex := GroupIndex;
      Self.FIsHeaderAlignmentHorzAssigned := FIsHeaderAlignmentHorzAssigned;
      Self.HeaderAlignmentHorz := HeaderAlignmentHorz;
      Self.FIsHeaderAlignmentVertAssigned := FIsHeaderAlignmentVertAssigned;
      Self.HeaderAlignmentVert := HeaderAlignmentVert;
      Self.MinWidth := MinWidth;
      Self.Options := Options;
      Self.PropertiesClass := PropertiesClass;
      Self.Properties := Properties;
      Self.RepositoryItem := RepositoryItem;
      Self.SortOrder := SortOrder;
      Self.Styles := Styles;
      Self.Tag := Tag;
      Self.Visible := Visible;
      Self.FIsWidthAssigned := FIsWidthAssigned;
      Self.Width := Width;
      Self.OnCustomDrawCell := OnCustomDrawCell;
      Self.OnGetDisplayText := OnGetDisplayText;
      Self.OnGetFilterDisplayText := OnGetFilterDisplayText;
      Self.OnGetFilterValues := OnGetFilterValues;
      Self.OnGetProperties := OnGetProperties;
    end
  else
    inherited;
end;

function TcxCustomGridTableItem.GetParentComponent: TComponent;
begin
  Result := FGridView;
end;

function TcxCustomGridTableItem.HasParent: Boolean;
begin
  Result := FGridView <> nil;
end;

procedure TcxCustomGridTableItem.ApplyBestFit;
begin
  if GridView.IsPattern then Exit;
  ShowHourglassCursor;
  try
    ForceWidth(GetBestFitWidth);
    Changed(ticSize);
  finally
    HideHourglassCursor;
  end;
end;

function TcxCustomGridTableItem.CalculateDefaultCellHeight(ACanvas: TcxCanvas;
  AFont: TFont): Integer;
var
  AEditStyle: TcxCustomEditStyle;
  AEditSizeProperties: TcxEditSizeProperties;
begin
  AEditStyle := GetCellStyle;
  try
    AEditStyle.Font := AFont;
    with AEditSizeProperties do
    begin
      Height := -1;
      MaxLineCount := 0;
      Width := -1;
    end;
    Result := GetProperties.GetEditSize(ACanvas, AEditStyle, True, Null, AEditSizeProperties).cy;
    if Result <> 0 then
      Inc(Result, 2 * cxGridEditOffset);
  finally
    ReleaseCellStyle;
  end;
end;

function TcxCustomGridTableItem.CreateEditStyle: TcxEditStyle;
begin
  Result := GetProperties.GetStyleClass.Create(nil, True) as TcxEditStyle;
  if GridView.Control <> nil then
    Result.LookAndFeel.MasterLookAndFeel := TcxCustomGrid(GridView.Control).LookAndFeel;
end;

function TcxCustomGridTableItem.GetDefaultValuesProvider(AProperties: TcxCustomEditProperties = nil): IcxEditDefaultValuesProvider;
begin
  if FDataBinding = nil then
    Result := nil
  else
    Result := FDataBinding.GetDefaultValuesProvider(AProperties);
end;

function TcxCustomGridTableItem.GetProperties: TcxCustomEditProperties;
begin
  Result := FPropertiesValue;
  InitProperties(Result);
end;

function TcxCustomGridTableItem.GetProperties(ARecord: TcxCustomGridRecord): TcxCustomEditProperties;
begin
  Result := DoGetProperties(ARecord);
  InitProperties(Result);
end;

function TcxCustomGridTableItem.GetRepositoryItem: TcxEditRepositoryItem;
begin
  Result := FRepositoryItem;
  if (Result = nil) and not IsDestroying then
  begin
    Result := DefaultRepositoryItem;
    if Result <> nil then
    begin
      Result.AddListener(Self);
      FLastUsedDefaultRepositoryItem := Result;
    end;
  end;
end;

procedure TcxCustomGridTableItem.RestoreDefaults;
begin
  FIsCaptionAssigned := False;
  FIsWidthAssigned := False;
  Changed(ticSize);
end;

{ TcxCustomGridTableBackgroundBitmaps }

function TcxCustomGridTableBackgroundBitmaps.GetBitmapStyleIndex(Index: Integer): Integer;
begin
  if Index = bbContent then
    Result := vsContent
  else
    Result := inherited GetBitmapStyleIndex(Index);
end;

procedure TcxCustomGridTableBackgroundBitmaps.Assign(Source: TPersistent);
begin
  if Source is TcxCustomGridTableBackgroundBitmaps then
    with TcxCustomGridTableBackgroundBitmaps(Source) do
      Self.Content := Content;
  inherited;
end;

{ TcxCustomGridTableFiltering }

constructor TcxCustomGridTableFiltering.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FCustomizeDialog := True;
  FMaxDropDownCount := cxGridFilterDefaultMaxDropDownCount;
  FVisible := fvNonEmpty;
end;

function TcxCustomGridTableFiltering.GetGridView: TcxCustomGridTableView;
begin
  Result := TcxCustomGridTableView(inherited GridView);
end;

procedure TcxCustomGridTableFiltering.SetCustomizeDialog(Value: Boolean);
begin
  if FCustomizeDialog <> Value then
  begin
    FCustomizeDialog := Value;
    LayoutChanged;
  end;
end;

procedure TcxCustomGridTableFiltering.SetDropDownWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  FDropDownWidth := Value;
end;

procedure TcxCustomGridTableFiltering.SetMaxDropDownCount(Value: Integer);
begin
  if Value < 0 then Value := 0;
  FMaxDropDownCount := Value;
end;

procedure TcxCustomGridTableFiltering.SetVisible(Value: TcxGridTableFilterVisible);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    LayoutChanged;
  end;
end;

procedure TcxCustomGridTableFiltering.FilterControlDialogApply(Sender: TObject);
begin
  GridView.DataController.Filter.Active := True;
end;

procedure TcxCustomGridTableFiltering.Assign(Source: TPersistent);
begin
  if Source is TcxCustomGridTableFiltering then
    with TcxCustomGridTableFiltering(Source) do
    begin
      Self.CustomizeDialog := CustomizeDialog;
      Self.DropDownWidth := DropDownWidth;
      Self.MaxDropDownCount := MaxDropDownCount;
      Self.Visible := Visible;
    end
  else
    inherited;
end;

function TcxCustomGridTableFiltering.GetDropDownCount(AItemCount: Integer): Integer;
begin
  Result := FMaxDropDownCount;
  if (Result = 0) or (AItemCount < Result) then
    Result := AItemCount;
end;

procedure TcxCustomGridTableFiltering.RunCustomizeDialog(AItem: TcxCustomGridTableItem);
begin
  if (AItem = nil) or IsFilterControlDialogNeeded(GridView.DataController.Filter) then
    ExecuteFilterControlDialog(GridView, TcxControlAccess(GridView.Control).LookAndFeel,
      FilterControlDialogApply, GridView.OnFilterControlDialogShow)
  else
    if ShowFilterDialog(GridView.DataController.Filter, AItem,
      AItem.GetProperties, AItem.FilterCaption, AItem.DataBinding.ValueTypeClass,
      TcxCustomGrid(GridView.Control).LookAndFeel) then
      GridView.DataController.Filter.Active := True;
end;

{ TcxCustomGridTableOptionsBehavior }

constructor TcxCustomGridTableOptionsBehavior.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FDragHighlighting := True;
  FDragOpening := True;
  FDragScrolling := True;
  FImmediateEditor := True;
end;

function TcxCustomGridTableOptionsBehavior.GetGridView: TcxCustomGridTableView;
begin
  Result := TcxCustomGridTableView(inherited GridView);
end;

procedure TcxCustomGridTableOptionsBehavior.SetBestFitMaxRecordCount(Value: Integer);
begin
  if Value < 0 then Value := 0;
  FBestFitMaxRecordCount := Value;
end;

procedure TcxCustomGridTableOptionsBehavior.SetFocusCellOnTab(Value: Boolean);
begin
  if FFocusCellOnTab <> Value then
  begin
    FFocusCellOnTab := Value;
    with GridView.Site do
      if FFocusCellOnTab then
        Keys := Keys + [kTab]
      else
        Keys := Keys - [kTab];
  end;
end;

procedure TcxCustomGridTableOptionsBehavior.SetIncSearch(Value: Boolean);
begin
  if FIncSearch <> Value then
  begin
    if not Value then
      GridView.Controller.CancelIncSearching;
    FIncSearch := Value;
  end;
end;

procedure TcxCustomGridTableOptionsBehavior.Assign(Source: TPersistent);
begin
  if Source is TcxCustomGridTableOptionsBehavior then
    with TcxCustomGridTableOptionsBehavior(Source) do
    begin
      Self.AlwaysShowEditor := AlwaysShowEditor;
      Self.BestFitMaxRecordCount := BestFitMaxRecordCount;
      Self.CellHints := CellHints;
      Self.DragFocusing := DragFocusing;
      Self.DragHighlighting := DragHighlighting;
      Self.DragOpening := DragOpening;
      Self.DragScrolling := DragScrolling;
      Self.FocusCellOnCycle := FocusCellOnCycle;
      Self.FocusCellOnTab := FocusCellOnTab;
      Self.FocusFirstCellOnNewRecord := FocusFirstCellOnNewRecord;
      Self.GoToNextCellOnEnter := GoToNextCellOnEnter;
      Self.ImmediateEditor := ImmediateEditor;
      Self.IncSearch := IncSearch;
      Self.IncSearchItem := IncSearchItem;
      Self.NavigatorHints := NavigatorHints;
      Self.PullFocusing := PullFocusing;
    end;
  inherited;
end;

{ TcxCustomGridTableOptionsCustomize }

constructor TcxCustomGridTableOptionsCustomize.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FItemGrouping := True;
  FItemMoving := True;
  FItemSorting := True;
end;

procedure TcxCustomGridTableOptionsCustomize.Assign(Source: TPersistent);
begin
  if Source is TcxCustomGridTableOptionsCustomize then
    with TcxCustomGridTableOptionsCustomize(Source) do
    begin
      Self.ItemGrouping := ItemGrouping;
      Self.ItemMoving := ItemMoving;
      Self.ItemSorting := ItemSorting;
    end;
  inherited;
end;

{ TcxCustomGridTableOptionsData }

constructor TcxCustomGridTableOptionsData.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FCancelOnExit := True;
  FDeleting := True;
  FDeletingConfirmation := True;
  FEditing := True;
  FInserting := True;
end;

function TcxCustomGridTableOptionsData.GetGridView: TcxCustomGridTableView;
begin
  Result := TcxCustomGridTableView(inherited GridView);
end;

procedure TcxCustomGridTableOptionsData.SetDeleting(Value: Boolean);
begin
  if FDeleting <> Value then
  begin
    FDeleting := Value;
    GridView.RefreshNavigators;
  end;
end;

procedure TcxCustomGridTableOptionsData.SetEditing(Value: Boolean);
begin
  if FEditing <> Value then
  begin
    FEditing := Value;
    if not FEditing then
      GridView.Controller.EditingItem := nil;
    GridView.RefreshNavigators;
  end;
end;

procedure TcxCustomGridTableOptionsData.SetInserting(Value: Boolean);
begin
  if FInserting <> Value then
  begin
    FInserting := Value;
    GridView.RefreshNavigators;
  end;
end;

procedure TcxCustomGridTableOptionsData.Assign(Source: TPersistent);
begin
  if Source is TcxCustomGridTableOptionsData then
    with TcxCustomGridTableOptionsData(Source) do
    begin
      Self.Appending := Appending;
      Self.CancelOnExit := CancelOnExit;
      Self.Deleting := Deleting;
      Self.DeletingConfirmation := DeletingConfirmation;
      Self.Editing := Editing;
      Self.Inserting := Inserting;
    end;
  inherited;
end;

{ TcxCustomGridTableOptionsSelection }

constructor TcxCustomGridTableOptionsSelection.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FCellSelect := True;
  FHideFocusRect := True;
  FInvertSelect := True;
  FUnselectFocusedRecordOnExit := True;
end;

function TcxCustomGridTableOptionsSelection.GetMultiSelect: Boolean;
begin
  Result := GridView.DataController.MultiSelect;
end;

procedure TcxCustomGridTableOptionsSelection.SetCellSelect(Value: Boolean);
begin
  if FCellSelect <> Value then
  begin
    FCellSelect := Value;
    if FCellSelect then
      GridView.Controller.FocusFirstAvailableItem
    else
      GridView.Controller.FocusedItem := nil;
  end;
end;

procedure TcxCustomGridTableOptionsSelection.SetHideFocusRect(Value: Boolean);
begin
  if FHideFocusRect <> Value then
  begin
    FHideFocusRect := Value;
    LayoutChanged;
  end;
end;

procedure TcxCustomGridTableOptionsSelection.SetHideSelection(Value: Boolean);
begin
  if FHideSelection <> Value then
  begin
    FHideSelection := Value;
    LayoutChanged;
  end;
end;

procedure TcxCustomGridTableOptionsSelection.SetInvertSelect(Value: Boolean);
begin
  if FInvertSelect <> Value then
  begin
    FInvertSelect := Value;
    LayoutChanged;
  end;
end;

procedure TcxCustomGridTableOptionsSelection.SetMultiSelect(Value: Boolean);
begin
  GridView.DataController.MultiSelect := Value;
end;

function TcxCustomGridTableOptionsSelection.GridView: TcxCustomGridTableView;
begin
  Result := TcxCustomGridTableView(inherited GridView);
end;

procedure TcxCustomGridTableOptionsSelection.Assign(Source: TPersistent);
begin
  if Source is TcxCustomGridTableOptionsSelection then
    with TcxCustomGridTableOptionsSelection(Source) do
    begin
      Self.CellSelect := CellSelect;
      Self.HideFocusRect := HideFocusRect;
      Self.HideSelection := HideSelection;
      Self.InvertSelect := InvertSelect;
      Self.MultiSelect := MultiSelect;
      Self.UnselectFocusedRecordOnExit := UnselectFocusedRecordOnExit;
    end;
  inherited;
end;

{ TcxCustomGridTableOptionsView }

constructor TcxCustomGridTableOptionsView.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FNavigatorOffset := cxGridNavigatorDefaultOffset;
end;

function TcxCustomGridTableOptionsView.GetGridView: TcxCustomGridTableView;
begin
  Result := TcxCustomGridTableView(inherited GridView);
end;

procedure TcxCustomGridTableOptionsView.SetCellAutoHeight(Value: Boolean);
begin
  if FCellAutoHeight <> Value then
  begin
    FCellAutoHeight := Value;
    SizeChanged;
  end;
end;

procedure TcxCustomGridTableOptionsView.SetCellEndEllipsis(Value: Boolean);
begin
  if FCellEndEllipsis <> Value then
  begin
    FCellEndEllipsis := Value;
    LayoutChanged;
  end;
end;

procedure TcxCustomGridTableOptionsView.SetCellTextMaxLineCount(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FCellTextMaxLineCount <> Value then
  begin
    FCellTextMaxLineCount := Value;
    SizeChanged;
  end;
end;

procedure TcxCustomGridTableOptionsView.SetItemCaptionAutoHeight(Value: Boolean);
begin
  if FItemCaptionAutoHeight <> Value then
  begin
    FItemCaptionAutoHeight := Value;
    ItemCaptionAutoHeightChanged;
  end;
end;

procedure TcxCustomGridTableOptionsView.SetItemCaptionEndEllipsis(Value: Boolean);
begin
  if FItemCaptionEndEllipsis <> Value then
  begin
    FItemCaptionEndEllipsis := Value;
    LayoutChanged;
  end;
end;

procedure TcxCustomGridTableOptionsView.SetNavigator(Value: Boolean);
begin
  if FNavigator <> Value then
  begin
    FNavigator := Value;
    SizeChanged;
  end;
end;

procedure TcxCustomGridTableOptionsView.SetNavigatorOffset(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FNavigatorOffset <> Value then
  begin
    FNavigatorOffset := Value;
    SizeChanged;
  end;
end;

procedure TcxCustomGridTableOptionsView.SetShowEditButtons(Value: TcxGridShowEditButtons);
begin
  if FShowEditButtons <> Value then
  begin
    FShowEditButtons := Value;
    LayoutChanged;
  end;
end;

procedure TcxCustomGridTableOptionsView.ItemCaptionAutoHeightChanged;
begin
  SizeChanged;
end;

procedure TcxCustomGridTableOptionsView.SizeChanged;
begin
  GridView.SizeChanged;
end;

procedure TcxCustomGridTableOptionsView.Assign(Source: TPersistent);
begin
  if Source is TcxCustomGridTableOptionsView then
    with TcxCustomGridTableOptionsView(Source) do
    begin
      Self.CellAutoHeight := CellAutoHeight;
      Self.CellEndEllipsis := CellEndEllipsis;
      Self.CellTextMaxLineCount := CellTextMaxLineCount;
      Self.ItemCaptionAutoHeight := ItemCaptionAutoHeight;
      Self.ItemCaptionEndEllipsis := ItemCaptionEndEllipsis;
      Self.Navigator := Navigator;
      Self.NavigatorOffset := NavigatorOffset;
      Self.ShowEditButtons := ShowEditButtons;
    end;
  inherited;
end;

{ TcxCustomGridTableViewStyles }

function TcxCustomGridTableViewStyles.GetGridViewValue: TcxCustomGridTableView;
begin
  Result := TcxCustomGridTableView(inherited GetGridView);
end;

procedure TcxCustomGridTableViewStyles.GetDefaultViewParams(Index: Integer; AData: TObject;
  out AParams: TcxViewParams);
begin
  inherited;
  with AParams, LookAndFeelPainter do
    case Index of
      vsContent:
        begin
          Color := DefaultContentColor;
          TextColor := DefaultContentTextColor;
        end;
      vsContentEven, vsContentOdd:
        GetViewParams(vsContent, nil, nil, AParams);
      vsInactive:
        begin
          if AData <> nil then
            with TcxGridDataCellPos(AData) do
              GetDataCellContentParams(GridRecord, Item, AParams);
          Color := DefaultInactiveColor;
          TextColor := DefaultInactiveTextColor;
        end;
      vsIncSearch:
        begin
          Color := clDefault;
          TextColor := clDefault;
        end;
      vsSelection:
        begin
          if AData <> nil then
            with TcxGridDataCellPos(AData) do
              GetDataCellContentParams(GridRecord, Item, AParams);
          Color := DefaultSelectionColor;
          TextColor := DefaultSelectionTextColor;
        end;
    end;
end;

procedure TcxCustomGridTableViewStyles.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TcxCustomGridTableViewStyles then
    with TcxCustomGridTableViewStyles(Source) do
    begin
      Self.Content := Content;
      Self.ContentEven := ContentEven;
      Self.ContentOdd := ContentOdd;
      Self.Inactive := Inactive;
      Self.IncSearch := IncSearch;
      Self.Selection := Selection;
      Self.OnGetContentStyle := OnGetContentStyle;
    end;
end;

procedure TcxCustomGridTableViewStyles.GetContentParams(ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AParams: TcxViewParams);
const
  StyleIndexes: array[Boolean] of Integer = (vsContentEven, vsContentOdd);
var
  AStyle: TcxStyle;
  ADataCellPos: TcxGridDataCellPos;
begin             
  AStyle := nil;
  if (ARecord <> nil) and Assigned(FOnGetContentStyle) then
    FOnGetContentStyle(GridView, ARecord, AItem, AStyle);
  if (ARecord <> nil) and (GetValue(StyleIndexes[Odd(ARecord.Index)]) <> nil) then
  begin
    ADataCellPos := TcxGridDataCellPos.Create;
    try
      with ADataCellPos do
      begin
        GridRecord := ARecord;
        Item := AItem;
      end;
      GetViewParams(StyleIndexes[Odd(ARecord.Index)], ADataCellPos, AStyle, AParams);
    finally
      ADataCellPos.Free;
    end;
  end
  else
    GetViewParams(vsContent, ARecord, AStyle, AParams);
end;

procedure TcxCustomGridTableViewStyles.GetDataCellContentParams(ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AParams: TcxViewParams);
begin
  if AItem = nil then
    GetRecordContentParams(ARecord, AItem, AParams)
  else
    AItem.Styles.GetContentParams(ARecord, AParams);
end;

procedure TcxCustomGridTableViewStyles.GetDataCellParams(ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AParams: TcxViewParams;
  AUseViewInfo: Boolean = False; ACellViewInfo: TcxGridTableCellViewInfo = nil);
var
  ADataCellPos: TcxGridDataCellPos;
begin
  if AUseViewInfo and ACellViewInfo.Selected or
    not AUseViewInfo and GridView.DrawDataCellSelected(ARecord, AItem, False, nil) then
  begin
    ADataCellPos := TcxGridDataCellPos.Create;
    try
      with ADataCellPos do
      begin
        GridRecord := ARecord;
        Item := AItem;
      end;
      if GridView.DrawRecordActive(ARecord) then
        GetViewParams(vsSelection, ADataCellPos, nil, AParams)
      else
        GetViewParams(vsInactive, ADataCellPos, nil, AParams);
    finally
      ADataCellPos.Free;
    end;
  end
  else
    GetDataCellContentParams(ARecord, AItem, AParams);
end;

procedure TcxCustomGridTableViewStyles.GetRecordContentParams(ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AParams: TcxViewParams);
begin
  GetContentParams(ARecord, AItem, AParams);
end;

{ TcxCustomGridTableView }

destructor TcxCustomGridTableView.Destroy;
begin
  Controller.EditingController.EditingItem := nil;
  inherited;
end;

function TcxCustomGridTableView.GetBackgroundBitmaps: TcxCustomGridTableBackgroundBitmaps;
begin
  Result := TcxCustomGridTableBackgroundBitmaps(inherited BackgroundBitmaps);
end;

function TcxCustomGridTableView.GetController: TcxCustomGridTableController;
begin
  Result := TcxCustomGridTableController(inherited Controller);
end;

function TcxCustomGridTableView.GetDataController: TcxGridDataController;
begin
  Result := TcxGridDataController(inherited DataController);
end;

function TcxCustomGridTableView.GetFilterableItem(Index: Integer): TcxCustomGridTableItem;
begin
  Result := FFilterableItems[Index];
end;

function TcxCustomGridTableView.GetFilterableItemCount: Integer;
begin
  Result := FFilterableItems.Count;
end;

function TcxCustomGridTableView.GetGroupedItem(Index: Integer): TcxCustomGridTableItem;
begin
  Result := Items[DataController.Groups.GroupingItemIndex[Index]];
end;

function TcxCustomGridTableView.GetGroupedItemCount: Integer;
begin
  Result := DataController.Groups.GroupingItemCount;
end;

function TcxCustomGridTableView.GetItem(Index: Integer): TcxCustomGridTableItem;
begin
  Result := FItems[Index];
end;

function TcxCustomGridTableView.GetItemCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxCustomGridTableView.GetMasterGridRecord: TcxCustomGridRecord;
begin
  if MasterGridRecordIndex = -1 then
    Result := nil
  else
    Result := (MasterGridView as TcxCustomGridTableView).ViewData.Records[MasterGridRecordIndex];
end;

function TcxCustomGridTableView.GetOptionsSelection: TcxCustomGridTableOptionsSelection;
begin
  Result := TcxCustomGridTableOptionsSelection(inherited OptionsSelection);
end;

function TcxCustomGridTableView.GetOptionsView: TcxCustomGridTableOptionsView;
begin
  Result := TcxCustomGridTableOptionsView(inherited OptionsView);
end;

function TcxCustomGridTableView.GetPainter: TcxCustomGridTablePainter;
begin
  Result := TcxCustomGridTablePainter(inherited Painter);
end;

function TcxCustomGridTableView.GetNavigatorButtonsControl: IcxNavigator;
begin
  Result := Self;
end;

function TcxCustomGridTableView.GetSortedItem(Index: Integer): TcxCustomGridTableItem;
begin
  Result := Items[DataController.GetSortingItemIndex(Index)];
end;

function TcxCustomGridTableView.GetSortedItemCount: Integer;
begin
  Result := DataController.GetSortingItemCount;
end;

function TcxCustomGridTableView.GetStyles: TcxCustomGridTableViewStyles;
begin
  Result := TcxCustomGridTableViewStyles(inherited Styles);
end;

function TcxCustomGridTableView.GetViewData: TcxCustomGridTableViewData;
begin
  Result := TcxCustomGridTableViewData(inherited ViewData);
end;

function TcxCustomGridTableView.GetViewInfo: TcxCustomGridTableViewInfo;
begin
  Result := TcxCustomGridTableViewInfo(inherited ViewInfo);
end;

function TcxCustomGridTableView.GetVisibleItem(Index: Integer): TcxCustomGridTableItem;
begin
  Result := FVisibleItems[Index];
end;

function TcxCustomGridTableView.GetVisibleItemCount: Integer;
begin
  Result := FVisibleItems.Count;
end;

procedure TcxCustomGridTableView.SetBackgroundBitmaps(Value: TcxCustomGridTableBackgroundBitmaps);
begin
  inherited BackgroundBitmaps := Value;
end;

procedure TcxCustomGridTableView.SetDataController(Value: TcxGridDataController);
begin
  DataController.Assign(Value);
end;

procedure TcxCustomGridTableView.SetFiltering(Value: TcxCustomGridTableFiltering);
begin
  FFiltering.Assign(Value);
end;

procedure TcxCustomGridTableView.SetItem(Index: Integer; Value: TcxCustomGridTableItem);
begin
  Items[Index].Assign(Value);
end;

procedure TcxCustomGridTableView.SetNavigatorButtons(Value: TcxNavigatorControlButtons);
begin
  FNavigatorButtons.Assign(Value);
end;

procedure TcxCustomGridTableView.SetOptionsBehavior(Value: TcxCustomGridTableOptionsBehavior);
begin
  FOptionsBehavior.Assign(Value);
end;

procedure TcxCustomGridTableView.SetOptionsCustomize(Value: TcxCustomGridTableOptionsCustomize);
begin
  FOptionsCustomize.Assign(Value);
end;

procedure TcxCustomGridTableView.SetOptionsData(Value: TcxCustomGridTableOptionsData);
begin
  FOptionsData.Assign(Value);
end;

procedure TcxCustomGridTableView.SetOptionsSelection(Value: TcxCustomGridTableOptionsSelection);
begin
  inherited OptionsSelection := Value;
end;

procedure TcxCustomGridTableView.SetOptionsView(Value: TcxCustomGridTableOptionsView);
begin
  inherited OptionsView := Value;
end;

procedure TcxCustomGridTableView.SetStyles(Value: TcxCustomGridTableViewStyles);
begin
  inherited Styles := Value;
end;

procedure TcxCustomGridTableView.CopyForEachRowProc(ARowIndex: Integer; ARowInfo: TcxRowInfo);
var
  I, C, AIndex: Integer;
begin
  C := VisibleItemCount - 1;
  for I := 0 to C do
  begin
    AIndex := VisibleItems[I].Index;
    FCopyToClipboardStr := FCopyToClipboardStr + DataController.GetRowDisplayText(ARowInfo, AIndex);
    if ARowInfo.Level < DataController.Groups.GroupingItemCount then // it's group
      Break;
    if I <> C then
      FCopyToClipboardStr := FCopyToClipboardStr + ColumnSeparator;
  end;
  FCopyToClipboardStr := FCopyToClipboardStr + EndOfLine;
end;

procedure TcxCustomGridTableView.RefreshItemIndexes;
var
  I: Integer;
begin
  for I := 0 to ItemCount - 1 do
    Items[I].FIndex := I;
end;

function TcxCustomGridTableView.GetFilterCaption(Index: Integer): string;
begin
  Result := FilterableItems[Index].Caption;
end;

function TcxCustomGridTableView.GetFilterCount: Integer;
begin
  Result := FilterableItemCount;
end;

function TcxCustomGridTableView.GetFilterCriteria: TcxFilterCriteria;
begin
  Result := DataController.Filter;
end;

function TcxCustomGridTableView.GetFilterFieldName(Index: Integer): string;
begin
  Result := '';
end;

function TcxCustomGridTableView.GetFilterItemLink(Index: Integer): TObject;
begin
  Result := FilterableItems[Index];
end;

function TcxCustomGridTableView.GetFilterItemLinkID(Index: Integer): Integer;
begin
  Result := FilterableItems[Index].ID;
end;

function TcxCustomGridTableView.GetFilterItemLinkName(Index: Integer): string;
begin
  Result := FilterableItems[Index].Name;
end;

function TcxCustomGridTableView.GetFilterProperties(Index: Integer): TcxCustomEditProperties;
begin
  Result := FilterableItems[Index].GetProperties;
end;

function TcxCustomGridTableView.GetFilterValueType(Index: Integer): TcxValueTypeClass;
begin
  Result := FilterableItems[Index].DataBinding.ValueTypeClass;
end;

function TcxCustomGridTableView.NavigatorIsActive: Boolean;
begin
  Result := DataController.Active;
end;

function TcxCustomGridTableView.NavigatorIsBof: Boolean;
var
  AIcxGridDataController: IcxGridDataController;
begin
  if DataController.GetInterface(IcxGridDataController, AIcxGridDataController) then
    Result := AIcxGridDataController.GetNavigatorIsBof
  else
    Result := False;
end;

function TcxCustomGridTableView.NavigatorIsEof: Boolean;
var
  AIcxGridDataController: IcxGridDataController;
begin
  if DataController.GetInterface(IcxGridDataController, AIcxGridDataController) then
    Result := AIcxGridDataController.GetNavigatorIsEof
  else
    Result := False;
end;

function TcxCustomGridTableView.NavigatorCanAppend: Boolean;
begin
  Result := Controller.CanAppend(True);
end;

function TcxCustomGridTableView.NavigatorCanEdit: Boolean;
begin
  Result := Controller.CanEdit;
end;

function TcxCustomGridTableView.NavigatorCanDelete: Boolean;
begin
  Result := Controller.CanDelete(True);
end;

function TcxCustomGridTableView.NavigatorCanInsert: Boolean;
begin
  Result := Controller.CanInsert(True);
end;

function TcxCustomGridTableView.NavigatorIsEditing: Boolean;
begin
  Result := DataController.IsEditing;
end;

procedure TcxCustomGridTableView.NavigatorClearBookmark;
begin
  DataController.ClearBookmark;
end;

function TcxCustomGridTableView.NavigatorIsBookmarkAvailable: Boolean;
begin
  Result := DataController.IsBookmarkAvailable;
end;

procedure TcxCustomGridTableView.NavigatorDoAction(AButtonIndex: Integer);
begin
  case AButtonIndex of
    NBDI_FIRST:
      Controller.GoToFirst;
    NBDI_PRIORPAGE:
      Controller.FocusPrevPage(True);
    NBDI_PRIOR:
      Controller.GoToPrev(False);
    NBDI_NEXT:
      Controller.GoToNext(False);
    NBDI_NEXTPAGE:
      Controller.FocusNextPage(True);
    NBDI_LAST:
      Controller.GoToLast(False);
    NBDI_INSERT, NBDI_APPEND:
      Controller.CreateNewRecord(AButtonIndex = NBDI_APPEND);
    NBDI_DELETE:
      Controller.DeleteSelection;
    NBDI_EDIT:
      begin
        DataController.Edit;
        Controller.FocusedItem.Editing := True;
      end;
    NBDI_POST:
      begin
        Controller.EditingController.UpdateValue;
        DataController.Post;
      end;
    NBDI_CANCEL:
      DataController.Cancel;
    NBDI_REFRESH:
      DataController.RefreshExternalData;
    NBDI_SAVEBOOKMARK:
      DataController.SaveBookmark;
    NBDI_GOTOBOOKMARK:
      DataController.GotoBookmark;
    NBDI_FILTER:
      FFiltering.RunCustomizeDialog;
  end;
end;

function TcxCustomGridTableView.NavigatorGetNotifier: TcxNavigatorControlNotifier;
begin
  Result := FNavigatorNotifier;
end;

function TcxCustomGridTableView.NavigatorIsActionSupported(AButtonIndex: Integer): Boolean;
begin
  Result := True;
end;

function TcxCustomGridTableView.GetProperties(AProperties: TStrings): Boolean;

  procedure AddFilter;
  begin
    with AProperties do
    begin
      Add('FilterActive');
      Add('FilterAutoDataSetFilter');
      Add('FilterDateTimeFormat');
      Add('FilterMaxValueListCount');
      Add('FilterOptions');
      Add('FilterPercentWildcard');
      Add('FilterUnderscoreWildcard');
      Add('Filter');
    end;
  end;

  procedure AddSummary;
  begin
    with AProperties do
      Add('SummaryOptions');
  end;
  
begin
  if gsoUseFilter in StorageOptions then
    AddFilter;
  if gsoUseSummary in StorageOptions then
    AddSummary;
  Result := inherited GetProperties(AProperties);
end;

procedure TcxCustomGridTableView.GetPropertyValue(const AName: string;
  var AValue: Variant);

  function GetFilter: Boolean;
  var
    AString: string;
    AStream: TMemoryStream;
    AFilterCriteriaOptions: TcxFilterCriteriaOptions;
  begin
    Result := True;
    if AName = 'FilterActive' then
      AValue := DataController.Filter.Active
    else
      if AName = 'FilterDateTimeFormat' then
        AValue := DataController.Filter.DateTimeFormat
      else
        if AName = 'FilterMaxValueListCount' then
          AValue := DataController.Filter.MaxValueListCount
        else
          if AName = 'FilterOptions' then
          begin
            AFilterCriteriaOptions := DataController.Filter.Options;
            AValue := SetToString(AFilterCriteriaOptions, SizeOf(AFilterCriteriaOptions),
              ['fcoCaseInsensitive', 'fcoShowOperatorDescription', 'fcoSoftNull', 'fcoSoftCompare']);
          end
          else
            if AName = 'FilterPercentWildcard' then
              AValue := DataController.Filter.PercentWildcard
            else
              if AName = 'FilterUnderscoreWildcard' then
                AValue := DataController.Filter.UnderscoreWildcard
              else
                if AName = 'Filter' then
                begin
                  AStream := TMemoryStream.Create;
                  try
                    TcxFilterCriteriaAccess(DataController.Filter).WriteData(AStream);
                    AStream.Position := 0;
                    SetLength(AString, AStream.Size);
                    AStream.ReadBuffer(AString[1], AStream.Size);
                    AValue := 'Hex:' + StringToHexString(AString);
                  finally
                    AStream.Free;
                  end;
                end
                else
                  Result := (DataController as IcxGridDataController).GetFilterPropertyValue(AName, AValue);
  end;

  function GetSummary: Boolean;
  var
    ASummaryOptions: TcxSummaryOptions;
  begin
    Result := True;
    if AName = 'SummaryOptions' then
    begin
      ASummaryOptions := DataController.Summary.Options;
      AValue := SetToString(ASummaryOptions, SizeOf(ASummaryOptions),
        ['soNullIgnore', 'soSelectedRecords']);
    end
    else
      Result := False;
  end;

begin
  AValue := Null;
  if (gsoUseFilter in StorageOptions) and GetFilter then Exit;
  if (gsoUseSummary in StorageOptions) and GetSummary then Exit;
  inherited;
end;

procedure TcxCustomGridTableView.SetPropertyValue(const AName: string;
  const AValue: Variant);

  function SetFilter: Boolean;
  var
    AString: string;
    AStream: TMemoryStream;
    AFilterCriteriaOptions: TcxFilterCriteriaOptions;
  begin
    Result := True;
    if AName = 'FilterActive' then
      DataController.Filter.Active := StringToBoolean(AValue)
    else
      if AName = 'FilterDateTimeFormat' then
        DataController.Filter.DateTimeFormat := AValue
      else
        if AName = 'FilterMaxValueListCount' then
          DataController.Filter.MaxValueListCount := AValue
        else
          if AName = 'FilterOptions' then
          begin
            StringToSet(AValue, AFilterCriteriaOptions, SizeOf(AFilterCriteriaOptions),
              ['fcoCaseInsensitive', 'fcoShowOperatorDescription', 'fcoSoftNull', 'fcoSoftCompare']);
            DataController.Filter.Options := AFilterCriteriaOptions;
          end
          else
            if AName = 'FilterPercentWildcard' then
            begin
              AString := AValue;
              if AString = '' then AString := #0;
              DataController.Filter.PercentWildcard := AString[1];
            end
            else
              if AName = 'FilterUnderscoreWildcard' then
              begin
                AString := AValue;
                if AString = '' then AString := #0;
                DataController.Filter.UnderscoreWildcard := AString[1];
              end
              else
                if AName = 'Filter' then
                begin
                  AStream := TMemoryStream.Create;
                  try
                    AString := AValue;
                    Delete(AString, 1, 4);
                    AString := HexStringToString(AString);
                    AStream.WriteBuffer(AString[1], Length(AString));
                    AStream.Position := 0;
                    TcxFilterCriteriaAccess(DataController.Filter).ReadData(AStream);
                  finally
                    AStream.Free;
                  end;
                end
                else
                  Result := (DataController as IcxGridDataController).SetFilterPropertyValue(AName, AValue);
  end;

  function SetSummary: Boolean;
  var
    ASummaryOptions: TcxSummaryOptions;
  begin
    Result := True;
    if AName = 'SummaryOptions' then
    begin
      StringToSet(AValue, ASummaryOptions, SizeOf(ASummaryOptions),
        ['soNullIgnore', 'soSelectedRecords']);
      DataController.Summary.Options := ASummaryOptions;
    end
    else
      Result := False;
  end;

begin
  if (gsoUseFilter in StorageOptions) and SetFilter then Exit;
  if (gsoUseSummary in StorageOptions) and SetSummary then Exit;
  inherited;
end;

function TcxCustomGridTableView.CreateChild(const AObjectName, AClassName: string): TObject;

  function GetSummaryGroupIndex: Integer;
  var
    I: Integer;
    AIndex: string;
  begin
    AIndex := '';
    I := Length('SummaryGroup') + 1;
    while AObjectName[I] <> '_' do
    begin
      AIndex := AIndex + AObjectName[I];
      if I = Length(AObjectName) then
        Break;
      Inc(I);
    end;
  {$IFDEF DELPHI6}
    if not TryStrToInt(AIndex, Result) then
      Result := -1;
  {$ELSE}
    try
      Result := StrToInt(AIndex);
    except
      on EConvertError do
        Result := -1;
    end;
  {$ENDIF}
  end;

  function CreateSummary: TObject;
  var
    ASummaryGroupIndex: Integer;
  begin
    Result := nil;
    if Pos('FooterSummaryItem', AObjectName) = 1 then
      Result := DataController.Summary.FooterSummaryItems.Add
    else
      if Pos('DefaultGroupSummaryItem', AObjectName) = 1 then
        Result := DataController.Summary.DefaultGroupSummaryItems.Add
      else
        if Pos('SummaryGroup', AObjectName) = 1 then
        begin
          ASummaryGroupIndex := GetSummaryGroupIndex;
          if ASummaryGroupIndex >= 0 then
            if Pos('Item', AObjectName) <> 0 then
            begin
              if ASummaryGroupIndex < DataController.Summary.SummaryGroups.Count then
                Result := DataController.Summary.SummaryGroups[ASummaryGroupIndex].SummaryItems.Add;
            end
            else
              if Pos('Link', AObjectName) <> 0 then
              begin
                if ASummaryGroupIndex < DataController.Summary.SummaryGroups.Count then
                  Result := DataController.Summary.SummaryGroups[ASummaryGroupIndex].Links.Add;
              end
              else
                Result := DataController.Summary.SummaryGroups.Add;
        end;
  end;

var
  AItem: TcxCustomGridTableItem;
begin
  Result := nil;
  if AClassName = GetItemClass.ClassName then
  begin
    AItem := CreateItem;
    if not IsStoringNameMode then
      AItem.Name := AObjectName;
    Result := AItem;
  end
  else
    if gsoUseSummary in StorageOptions then
      Result := CreateSummary;
end;

procedure TcxCustomGridTableView.GetStoredChildren(AChildren: TStringList);

  procedure AddSummary;
  var
    I, J: Integer;
  begin
    with DataController.Summary.FooterSummaryItems do
      for I := 0 to Count - 1 do
        AChildren.AddObject('FooterSummaryItem' + IntToStr(I), Items[I]);
    with DataController.Summary.DefaultGroupSummaryItems do
      for I := 0 to Count - 1 do
        AChildren.AddObject('DefaultGroupSummaryItem' + IntToStr(I), Items[I]);
    with DataController.Summary.SummaryGroups do
      for I := 0 to Count - 1 do
      begin
        AChildren.AddObject('SummaryGroup' + IntToStr(I), Items[I]);
        with Items[I].SummaryItems do
          for J := 0 to Count - 1 do
            AChildren.AddObject('SummaryGroup' + IntToStr(I) + '_Item' + IntToStr(J), Items[J]);
        with Items[I].Links do
          for J := 0 to Count - 1 do
            AChildren.AddObject('SummaryGroup' + IntToStr(I) + '_Link' + IntToStr(J), Items[J]);
      end;
  end;
  
var
  I: Integer;
begin
  for I := 0 to ItemCount - 1 do
    AChildren.AddObject('', Items[I]);
  if gsoUseSummary in StorageOptions then
    AddSummary;
end;

function TcxCustomGridTableView.CanOffset(ARecordCountDelta: Integer): Boolean;
begin  {2}
  Result := not TcxCustomGrid(Control).UpdateLocked and ViewInfo.CanOffsetView(ARecordCountDelta);
end;

function TcxCustomGridTableView.CanSelectRecord(ARecordIndex: Integer): Boolean;
begin
  Result := True;
  if Assigned(FOnCanSelectRecord) then
    FOnCanSelectRecord(Self, ViewData.GetRecordByIndex(ARecordIndex), Result);
end;

function TcxCustomGridTableView.CanTabStop: Boolean;
begin
  Result := inherited CanTabStop and not Controller.IsEditing;
end;

procedure TcxCustomGridTableView.DetailVisibleChanged(ADetailLevel: TComponent;
  APrevVisibleDetailCount, AVisibleDetailCount: Integer);
var
  I: Integer;
begin
  inherited;
  if IsPattern then
  begin
    BeginUpdate;
    try
      for I := 0 to CloneCount - 1 do
        TcxCustomGridViewAccess(Clones[I]).DetailVisibleChanged(ADetailLevel,
          APrevVisibleDetailCount, AVisibleDetailCount);
    finally
      EndUpdate;
    end;
  end        
  else
    if (APrevVisibleDetailCount = 0) or (AVisibleDetailCount = 0) then
      DataChanged;
end;

procedure TcxCustomGridTableView.DoAssign(ASource: TcxCustomGridView);
var
  I: Integer;
  AItem: TcxCustomGridTableItem;
begin
  if ASource is TcxCustomGridTableView then
  begin
    BeginUpdate;
    try
      ClearItems;
      with TcxCustomGridTableView(ASource) do
      begin
        for I := 0 to ItemCount - 1 do
        begin
          AItem := Self.CreateItem;
          AItem.FID := Items[I].ID;
          AItem.Assign(Items[I]);
        end;
        Self.FNextID := FNextID;

        Self.Filtering := Filtering;
        Self.NavigatorButtons := NavigatorButtons;
        Self.OptionsBehavior := OptionsBehavior;
        Self.OptionsCustomize := OptionsCustomize;
        Self.OptionsData := OptionsData;

        Self.OnCanSelectRecord := OnCanSelectRecord;
        Self.OnCellClick := OnCellClick;
        Self.OnCustomDrawCell := OnCustomDrawCell;
        Self.OnEditing := OnEditing;
        Self.OnEditChanged := OnEditChanged;
        Self.OnEditValueChanged := OnEditValueChanged;
        Self.OnFilterControlDialogShow := OnFilterControlDialogShow;
        Self.OnFocusedItemChanged := OnFocusedItemChanged;
        Self.OnFocusedRecordChanged := OnFocusedRecordChanged;
        Self.OnInitEdit := OnInitEdit;
        //Self.OnRecordCreated := OnRecordCreated;
        //Self.OnRecordDestroying := OnRecordDestroying;
        Self.OnSelectionChanged := OnSelectionChanged;
        Self.OnTopRecordIndexChanged := OnTopRecordIndexChanged;
      end;
    finally
      EndUpdate;
    end;
  end;
  inherited;
end;

function TcxCustomGridTableView.FindItemByObjectName(const AObjectName: string): TcxCustomGridTableItem;
begin
  if IsStoringNameMode then
    Result := FindItemByID(StrToInt(AObjectName))
  else
    Result := FindItemByName(AObjectName);
end;

procedure TcxCustomGridTableView.FocusEdit(AItemIndex: Integer; var ADone: Boolean);
begin
  Items[AItemIndex].Editing := True;
  ADone := Items[AItemIndex].Editing;
end;

procedure TcxCustomGridTableView.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
begin
  inherited;
  for I := 0 to ItemCount - 1 do
    if Items[I].Owner = Root then Proc(Items[I]);
end;

function TcxCustomGridTableView.GetDefaultActiveDetailIndex: Integer;
var
  AAvailableLevel: TcxGridLevel;
begin
  AAvailableLevel := TcxGridLevel(Level).GetAvailableItem;
  if AAvailableLevel = nil then
    Result := -1
  else
    Result := AAvailableLevel.Index;
end;

function TcxCustomGridTableView.GetDisplayText(ARecordIndex, AItemIndex: Integer;
  out AText: string): Boolean;
var
  AItem: TcxCustomGridTableItem;
begin
  AItem := Items[AItemIndex];
  Result := AItem.GetProperties.GetEditValueSource(False) = evsValue;
  if Result then
    AText := AItem.GetProperties.GetDisplayText(DataController.Values[ARecordIndex, AItemIndex]);
end;

procedure TcxCustomGridTableView.GetFakeComponentLinks(AList: TList);
var
  I: Integer;
begin
  inherited;
  for I := 0 to ItemCount - 1 do
    Items[I].Styles.GetFakeComponentLinks(AList);
end;

function TcxCustomGridTableView.GetIsControlFocused: Boolean;
begin
  Result := inherited GetIsControlFocused or
    Controller.EditingController.IsEditing and Controller.EditingController.Edit.IsFocused;
end;

function TcxCustomGridTableView.GetItemSortByDisplayText(AItemIndex: Integer): Boolean;
begin
  Result := (esoSortingByDisplayText in Items[AItemIndex].GetProperties.GetSupportedOperations) or
    Assigned(Items[AItemIndex].OnGetDisplayText);
end;

function TcxCustomGridTableView.GetItemValueSource(AItemIndex: Integer): TcxDataEditValueSource;
var
  AProperties: TcxCustomEditProperties;
begin
  AProperties := Items[AItemIndex].GetProperties;
  if AProperties = nil then
    Result := evsText  //!!!
  else
    Result := AProperties.GetEditValueSource(True);
end;

function TcxCustomGridTableView.HasCustomDrawCell: Boolean;
begin
  Result := Assigned(FOnCustomDrawCell);
end;

procedure TcxCustomGridTableView.Init;
begin
  inherited;
  Controller.FocusFirstAvailableItem;
end;

function TcxCustomGridTableView.IsDetailVisible(AGridView: TcxCustomGridView): Boolean;
var
  AViewInfo: TcxCustomGridRecordViewInfo;
begin
  if AGridView.MasterGridRecordIndex = -1 then
    Result := False
  else
  begin
    AViewInfo := ViewData.Records[AGridView.MasterGridRecordIndex].ViewInfo;
    Result := (AViewInfo <> nil) and AViewInfo.IsDetailVisible(AGridView);
  end;
end;

function TcxCustomGridTableView.IsEqualHeightRecords: Boolean;
begin
  Result := not ViewInfo.RecordsViewInfo.AutoDataRecordHeight;
end;

procedure TcxCustomGridTableView.LoadingComplete;
begin
  BeginUpdate;
  try
    inherited;
    DataChanged;
  finally
    EndUpdate;
  end;
end;

procedure TcxCustomGridTableView.Offset(ARecordCountDelta, DX, DY: Integer);
begin                                  {2}
  ViewInfo.DoOffset(ARecordCountDelta, DX, DY);
  if ARecordCountDelta <> 0 then
    Painter.DoOffset(ViewInfo.RecordsViewInfo.ItemsOffset, 0, 0)
  else
    Painter.DoOffset(0, DX, DY);
end;

procedure TcxCustomGridTableView.SetChildOrder(Child: TComponent; Order: Integer);
begin
  inherited;
  if Child is TcxCustomGridTableItem then
    TcxCustomGridTableItem(Child).Index := Order;
end;

procedure TcxCustomGridTableView.SetName(const NewName: TComponentName);
var
  AOldName: TComponentName;

  function GetItem(ACaller: TComponent; Index: Integer): TComponent;
  begin
    Result := TcxCustomGridTableView(ACaller).Items[Index];
  end;

begin
  AOldName := Name;
  inherited;
  if Name <> AOldName then
    RenameComponents(Self, Owner, Name, AOldName, ItemCount, @GetItem);
end;

procedure TcxCustomGridTableView.UpdateControl(AInfo: TcxUpdateControlInfo);
begin
  if IsDestroying then Exit;
  if AInfo is TcxDataChangedInfo then
    DataChanged
  else
    if AInfo is TcxLayoutChangedInfo then
      DataLayoutChanged
    else
      if AInfo is TcxFocusedRecordChangedInfo then
        with TcxFocusedRecordChangedInfo(AInfo) do
          FocusedRecordChanged(PrevFocusedRowIndex, FocusedRowIndex, NewItemRowFocusingChanged)
      else
        if AInfo is TcxSelectionChangedInfo then
          SelectionChanged(TcxSelectionChangedInfo(AInfo))
        else
          if AInfo is TcxSearchChangedInfo then
            SearchChanged
          else
            if AInfo is TcxUpdateRecordInfo then
              RecordChanged(TcxUpdateRecordInfo(AInfo).RecordIndex);
  RefreshNavigators;
end;

procedure TcxCustomGridTableView.UpdateDataController(AChange: TcxGridDataControllerChange;
  AItem: TcxCustomGridTableItem);
begin
  if {not IsDestroying and }(DataController <> nil) then
    with DataController do
      case AChange of
        (*dccGlobal:
          UpdateItems(True{!!!});*)
        dccItemAdded:
          AddItem(AItem);
        dccItemRemoved:
          RemoveItem(AItem);
        dccIndexesChanged:
          UpdateItemIndexes;
      end;
end;

procedure TcxCustomGridTableView.UpdateRecord;
begin
  Controller.EditingController.UpdateValue;
end;

procedure TcxCustomGridTableView.CreateHandlers;
begin
  FItems := TList.Create;
  FVisibleItems := TList.Create;
  FFilterableItems := TList.Create;
  FNavigatorNotifier := TcxNavigatorControlNotifier.Create;
  inherited;
  FNavigatorButtons := GetNavigatorButtonsClass.Create(ViewInfo);
  FNavigatorButtons.OnGetControl := GetNavigatorButtonsControl;
  FNavigatorButtons.ConfirmDelete := False;
end;

procedure TcxCustomGridTableView.DestroyHandlers;
begin
  ClearItems;
  FreeAndNil(FNavigatorButtons);
  inherited;
  FreeAndNil(FNavigatorNotifier);
  FreeAndNil(FFilterableItems);
  FreeAndNil(FVisibleItems);
  FreeAndNil(FItems);
end;

procedure TcxCustomGridTableView.CreateOptions;
begin
  inherited;
  FFiltering := GetFilteringClass.Create(Self);
  FOptionsBehavior := GetOptionsBehaviorClass.Create(Self);
  FOptionsCustomize := GetOptionsCustomizeClass.Create(Self);
  FOptionsData := GetOptionsDataClass.Create(Self);
end;

procedure TcxCustomGridTableView.DestroyOptions;
begin
  FreeAndNil(FOptionsData);
  FreeAndNil(FOptionsCustomize);
  FreeAndNil(FOptionsBehavior);
  FreeAndNil(FFiltering);
  inherited;
end;

procedure TcxCustomGridTableView.AddItem(AItem: TcxCustomGridTableItem);
begin
  FItems.Add(AItem);
  RefreshItemIndexes;
  AItem.FID := GetNextID;
  UpdateDataController(dccItemAdded, AItem);
  AItem.SetGridView(Self);  // needs Field
  AItem.Visible := True;
  RefreshFilterableItemsList;
end;

procedure TcxCustomGridTableView.RemoveItem(AItem: TcxCustomGridTableItem);
begin
  BeginUpdate;
  try
    if AItem = OptionsBehavior.IncSearchItem then
      OptionsBehavior.IncSearchItem := nil;
    AItem.Visible := False;
    FItems.Remove(AItem);
    AItem.FIndex := -1;
    RefreshItemIndexes;
    UpdateDataController(dccItemRemoved, AItem);
  finally
    EndUpdate;
  end;
  AItem.SetGridView(nil);
  //UpdateDataController(dccItemRemoved, AItem);
  ReleaseID(AItem.ID);
  RefreshFilterableItemsList;
end;

procedure TcxCustomGridTableView.AssignVisibleItemsIndexes;
var
  I: Integer;
begin
  for I := 0 to VisibleItemCount - 1 do
    with VisibleItems[I] do
      FVisibleIndex := GetVisibleIndex;
end;

procedure TcxCustomGridTableView.ChangeItemIndex(AItem: TcxCustomGridTableItem;
  Value: Integer);
begin
  if Value < 0 then Value := 0;
  if Value >= ItemCount then Value := ItemCount - 1;
  if AItem.Index <> Value then
  begin
    FItems.Move(AItem.Index, Value);
    RefreshItemIndexes;
    if AItem.Visible then RefreshVisibleItemsList;
    UpdateDataController(dccIndexesChanged, AItem);
  end;
end;

procedure TcxCustomGridTableView.ItemVisibilityChanged(AItem: TcxCustomGridTableItem;
  Value: Boolean);
begin
  if Value then
  begin
    RefreshVisibleItemsList;
    SizeChanged;
    if Controller.FocusedItem = nil then
      AItem.Focused := True;
  end
  else
  begin
    if AItem.IncSearching then Controller.CancelIncSearching;
    AItem.Focused := False;
    RefreshVisibleItemsList;
    SizeChanged;
  end;
end;

procedure TcxCustomGridTableView.RefreshVisibleItemsList;
var
  I: Integer;
begin
  FVisibleItems.Clear;
  for I := 0 to ItemCount - 1 do
    if Items[I].ActuallyVisible then
      Items[I].FVisibleIndex := FVisibleItems.Add(Items[I])
    else
      Items[I].FVisibleIndex := -1;
end;

function TcxCustomGridTableView.GetItemDataBindingClass: TcxGridItemDataBindingClass;
var
  AIGridDataController: IcxGridDataController;
begin
  if DataController.GetInterface(IcxGridDataController, AIGridDataController) then
    Result := AIGridDataController.GetItemDataBindingClass
  else
    Result := nil;
end;

function TcxCustomGridTableView.GetNextID: Integer;
begin
  Result := FNextID;
  Inc(FNextID);
end;

procedure TcxCustomGridTableView.ReleaseID(AID: Integer);
begin
  if AID = FNextID - 1 then Dec(FNextID);
end;

procedure TcxCustomGridTableView.DataChanged;
var
  I: Integer;
begin
  Controller.DragHighlightedRecord := nil;
  for I := 0 to ItemCount - 1 do
    Items[I].DataChanged;
  Changed(TcxGridDataChange.Create(Self));
  Controller.EditingController.UpdateEditValue;
  //Controller.MakeFocusedRecordVisible; - because of expanding, but this code is needed for insert  !!!
end;

procedure TcxCustomGridTableView.DataLayoutChanged;
begin
  ViewData.RefreshRecords;
  SizeChanged;
  Controller.EditingController.UpdateEditValue;
end;

function TcxCustomGridTableView.DoCellClick(ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState): Boolean;
begin
  Result := False;
  if Assigned(FOnCellClick) then
    FOnCellClick(Self, ACellViewInfo, AButton, AShift, Result);
end;

function TcxCustomGridTableView.DoEditing(AItem: TcxCustomGridTableItem): Boolean;
begin
  Result := True;
  if Assigned(FOnEditing) then FOnEditing(Self, AItem, Result);
end;

procedure TcxCustomGridTableView.DoGetDisplayText(ARecord: TcxCustomGridRecord;
  AItemIndex: Integer; var AText: string);
begin                                              
  Items[AItemIndex].DoGetDisplayText(ARecord, AText);
end;

procedure TcxCustomGridTableView.DoTopRecordIndexChanged;
begin
  if Assigned(FOnTopRecordIndexChanged) then FOnTopRecordIndexChanged(Self);
end;

procedure TcxCustomGridTableView.FocusedItemChanged(APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
begin
  if Assigned(OnFocusedItemChanged) then
    FOnFocusedItemChanged(Self, APrevFocusedItem, AFocusedItem);
end;

procedure TcxCustomGridTableView.FocusedRecordChanged(APrevFocusedRecordIndex,
  AFocusedRecordIndex: Integer; ANewItemRecordFocusingChanged: Boolean);
begin
  with Controller.EditingController do
    if HideEditOnFocusedRecordChange then HideEdit(True);
  //Controller.CheckEdit;
  //Controller.EditingController.UpdateEditValue;
  if not DataController.IsSelectionAnchorExist then
    Controller.SetSelectionAnchor(AFocusedRecordIndex);
  Changed(TcxGridFocusedRecordChange.Create(Self, APrevFocusedRecordIndex,
    AFocusedRecordIndex, ANewItemRecordFocusingChanged));
  if DataController.IsGridMode then Controller.UpdateScrollBars;
  Controller.CheckEdit;
  Controller.EditingController.UpdateEditValue;
  if Control <> nil then
    TcxCustomGrid(Control).SendNotifications(gnkFocusedRecordChanged);
  if Assigned(FOnFocusedRecordChanged) then
    FOnFocusedRecordChanged(Self, ViewData.GetRecordByIndex(APrevFocusedRecordIndex),
      ViewData.GetRecordByIndex(AFocusedRecordIndex), ANewItemRecordFocusingChanged);
end;

procedure TcxCustomGridTableView.ItemValueTypeClassChanged(AItemIndex: Integer);
begin
  Items[AItemIndex].ValueTypeClassChanged;
end;

procedure TcxCustomGridTableView.RecalculateDefaultWidths;
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to ItemCount - 1 do
      Items[I].RecalculateDefaultWidth;
  finally
    EndUpdate;
  end;
end;

procedure TcxCustomGridTableView.RecordChanged(ARecordIndex: Integer);
var
  ARecord: TcxCustomGridRecord;
begin
  ViewData.AssignEditingRecord;
  ARecord := ViewData.GetRecordByRecordIndex(ARecordIndex);
  if ARecord = nil then
    LayoutChanged
  else
    ARecord.Invalidate;
  Controller.EditingController.UpdateEditValue;  
end;

procedure TcxCustomGridTableView.RecordCountChanged;
begin
  ViewInfoCache.Count := DataController.GetRowCount;
  ViewData.Refresh(DataController.GetRowCount);
  if Control <> nil then  {7}
    TcxCustomGrid(Control).SendNotifications(gnkRecordCountChanged);
end;

procedure TcxCustomGridTableView.RefreshFilterableItemsList;
var
  I: Integer;
begin
  if IsDestroying then Exit;
  FFilterableItems.Clear;
  for I := 0 to ItemCount - 1 do
    if Items[I].Filterable then
      FFilterableItems.Add(Items[I]);
end;

procedure TcxCustomGridTableView.RefreshNavigators;
begin
  if ViewInfo.NavigatorSiteViewInfo.Visible then
    ViewInfo.NavigatorStateChanged;
  FNavigatorNotifier.RefreshNavigatorButtons;
  if Focused then
    TcxCustomGridAccess(Control).RefreshNavigators;
end;

procedure TcxCustomGridTableView.SearchChanged;
begin
  if Controller.FocusedRecord <> nil then
    Controller.FocusedRecord.Invalidate(Controller.IncSearchingItem);
end;

procedure TcxCustomGridTableView.SelectionChanged(AInfo: TcxSelectionChangedInfo);
var
  I: Integer;
  ARecord: TcxCustomGridRecord;
begin
  if AInfo.Count = 0 then
    LayoutChanged
  else
    for I := 0 to AInfo.Count - 1 do
    begin
      ARecord := ViewData.GetRecordByIndex(AInfo.RowIndexes[I]);
      if ARecord <> nil then ARecord.Invalidate;
    end;
  if Assigned(FOnSelectionChanged) then FOnSelectionChanged(Self);
end;

function TcxCustomGridTableView.DrawDataCellSelected(ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; AUseViewInfo: Boolean = False;
  ACellViewInfo: TcxGridTableCellViewInfo = nil): Boolean;

  function GetRecordSelected: Boolean;
  begin
    if AUseViewInfo then
      Result := ARecord.ViewInfo.Selected
    else
      Result := ARecord.DrawSelected;
  end;

  function GetRecordFocused: Boolean;
  begin
    if AUseViewInfo then
      Result := ARecord.ViewInfo.Focused
    else
      Result := ARecord.DrawFocused;
  end;

  function GetCellSelected: Boolean;
  begin
    if (ACellViewInfo <> nil) and ACellViewInfo.AlwaysSelected then
      Result := True
    else
      if OptionsSelection.InvertSelect then
        Result := (AItem = nil) or not AItem.Focused or not GetRecordFocused
      else
        Result := (OptionsSelection.MultiSelect or
          (AItem <> nil) and AItem.Focused and GetRecordFocused) and
          (not (ACellViewInfo is TcxGridTableDataCellViewInfo) or
           not TcxGridTableDataCellViewInfo(ACellViewInfo).Editing);
  end;

begin
  Result :=
    ((ACellViewInfo = nil) or ACellViewInfo.CanDrawSelected) and
    (ARecord <> nil) and GetRecordSelected and GetCellSelected and
    (IsControlFocused or not OptionsSelection.HideSelection);
end;

function TcxCustomGridTableView.DrawRecordActive(ARecord: TcxCustomGridRecord): Boolean;
begin
  Result := IsControlFocused or ARecord.DragHighlighted;
end;

function TcxCustomGridTableView.DrawRecordFocused(ARecord: TcxCustomGridRecord): Boolean;
begin
  Result := ARecord.Focused and Focused;
end;

function TcxCustomGridTableView.DrawRecordSelected(ARecord: TcxCustomGridRecord): Boolean;
begin
  Result :=
    ARecord.Selected and (Focused or OptionsSelection.MultiSelect) or
    ARecord.DragHighlighted;
end;

procedure TcxCustomGridTableView.DoCustomDrawCell(ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if HasCustomDrawCell then
    FOnCustomDrawCell(Self, ACanvas, AViewInfo, ADone);
end;

procedure TcxCustomGridTableView.DoEditChanged(AItem: TcxCustomGridTableItem);
begin
  if Assigned(FOnEditChanged) then FOnEditChanged(Self, AItem);
end;

procedure TcxCustomGridTableView.DoEditValueChanged(AItem: TcxCustomGridTableItem);
begin
  if Assigned(FOnEditValueChanged) then FOnEditValueChanged(Self, AItem);
end;

procedure TcxCustomGridTableView.DoInitEdit(AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit);
begin
  if Assigned(FOnInitEdit) then FOnInitEdit(Self, AItem, AEdit);
end;

{procedure TcxCustomGridTableView.DoRecordCreated(ARecord: TcxCustomGridRecord);
begin
  if Assigned(FOnRecordCreated) then FOnRecordCreated(Self, ARecord);
end;

procedure TcxCustomGridTableView.DoRecordDestroying(ARecord: TcxCustomGridRecord);
begin
  if Assigned(FOnRecordDestroying) then FOnRecordDestroying(Self, ARecord);
end;}

function TcxCustomGridTableView.GetControllerClass: TcxCustomGridControllerClass;
begin
  Result := TcxCustomGridTableController;
end;

function TcxCustomGridTableView.GetPainterClass: TcxCustomGridPainterClass;
begin
  Result := TcxCustomGridTablePainter;
end;

function TcxCustomGridTableView.GetViewDataClass: TcxCustomGridViewDataClass;
begin
  Result := TcxCustomGridTableViewData;
end;

function TcxCustomGridTableView.GetViewInfoCacheClass: TcxCustomGridViewInfoCacheClass;
begin
  Result := TcxCustomGridTableViewInfoCache;
end;

function TcxCustomGridTableView.GetViewInfoClass: TcxCustomGridViewInfoClass;
begin
  Result := TcxCustomGridTableViewInfo;
end;

function TcxCustomGridTableView.GetBackgroundBitmapsClass: TcxCustomGridBackgroundBitmapsClass;
begin
  Result := TcxCustomGridTableBackgroundBitmaps;
end;

function TcxCustomGridTableView.GetFilteringClass: TcxCustomGridTableFilteringClass;
begin
  Result := TcxCustomGridTableFiltering;
end;

function TcxCustomGridTableView.GetNavigatorButtonsClass: TcxNavigatorControlButtonsClass;
begin
  Result := TcxNavigatorControlButtons;
end;

function TcxCustomGridTableView.GetOptionsBehaviorClass: TcxCustomGridTableOptionsBehaviorClass;
begin
  Result := TcxCustomGridTableOptionsBehavior;
end;

function TcxCustomGridTableView.GetOptionsCustomizeClass: TcxCustomGridTableOptionsCustomizeClass;
begin
  Result := TcxCustomGridTableOptionsCustomize;
end;

function TcxCustomGridTableView.GetOptionsDataClass: TcxCustomGridTableOptionsDataClass;
begin
  Result := TcxCustomGridTableOptionsData;
end;

function TcxCustomGridTableView.GetOptionsSelectionClass: TcxCustomGridOptionsSelectionClass;
begin
  Result := TcxCustomGridTableOptionsSelection;
end;

function TcxCustomGridTableView.GetOptionsViewClass: TcxCustomGridOptionsViewClass;
begin
  Result := TcxCustomGridTableOptionsView;
end;

function TcxCustomGridTableView.GetStylesClass: TcxCustomGridViewStylesClass;
begin
  Result := TcxCustomGridTableViewStyles;
end;

function TcxCustomGridTableView.GetSummaryGroupItemLinkClass: TcxDataSummaryGroupItemLinkClass;
begin
  Result := nil;
end;

function TcxCustomGridTableView.GetSummaryItemClass: TcxDataSummaryItemClass;
begin
  Result := nil;
end;

procedure TcxCustomGridTableView.ApplyBestFit(AItem: TcxCustomGridTableItem = nil);
var
  I: Integer;
begin
  if AItem = nil then
    for I := 0 to VisibleItemCount - 1 do
      VisibleItems[I].ApplyBestFit
  else
    AItem.ApplyBestFit;
end;

procedure TcxCustomGridTableView.ClearItems;
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := ItemCount - 1 downto 0 do Items[I].Free;
    FNextID := 0;
  finally
    EndUpdate;
  end;
end;

procedure TcxCustomGridTableView.CopyToClipboard(ACopyAll: Boolean);

  procedure AddHeaders;
  var
    I, C: Integer;
  begin
    C := VisibleItemCount - 1;
    for I := 0 to C do
    begin
      FCopyToClipboardStr := FCopyToClipboardStr + VisibleItems[I].Caption;
      if I <> C then
        FCopyToClipboardStr := FCopyToClipboardStr + ColumnSeparator;
    end;
    FCopyToClipboardStr := FCopyToClipboardStr + EndOfLine{ + EndOfLine};
  end;

begin
  FCopyToClipboardStr := '';
  AddHeaders;
  DataController.ForEachRow(not ACopyAll, CopyForEachRowProc);
  Clipboard.AsText := FCopyToClipboardStr;
end;

function TcxCustomGridTableView.CreateItem: TcxCustomGridTableItem;
begin
  Result := GetItemClass.Create(Owner);
  AddItem(Result);
end;

function TcxCustomGridTableView.FindItemByID(AID: Integer): TcxCustomGridTableItem;
var
  I: Integer;
begin
  for I := 0 to ItemCount - 1 do
  begin
    Result := Items[I];
    if Result.ID = AID then Exit;
  end;
  Result := nil;
end;

function TcxCustomGridTableView.FindItemByName(const AName: string): TcxCustomGridTableItem;
var
  I: Integer;
begin
  for I := 0 to ItemCount - 1 do
  begin
    Result := Items[I];
    if Result.Name = AName then Exit;
  end;
  Result := nil;
end;

function TcxCustomGridTableView.IndexOfItem(AItem: TcxCustomGridTableItem): Integer;
begin
  Result := FItems.IndexOf(AItem);
end;

procedure TcxCustomGridTableView.MakeMasterGridRecordVisible;
begin                                                                         
  if IsDetail and (MasterGridRecord <> nil) and not DontMakeMasterRecordVisible then
    MasterGridRecord.MakeVisible;
end;

procedure TcxCustomGridTableView.RestoreDefaults;
var
  I: Integer;
begin
  inherited;
  BeginUpdate;
  try
    for I := 0 to ItemCount - 1 do
      Items[I].RestoreDefaults;
  finally
    EndUpdate;
  end;
end;

class function TcxCustomGridTableView.CanBeLookupList: Boolean;
begin
  Result := False;
end;

initialization
  RegisterClasses([TcxGridItemDataBinding]);

end.
