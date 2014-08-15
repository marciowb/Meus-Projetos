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

{$I cxVer.inc}

interface

uses
{$IFDEF DELPHI6}
  Variants,
{$ENDIF}
  Windows, Messages, Classes, Graphics, Controls, Forms, StdCtrls,
  cxClasses, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStorage, cxPC, cxFilterControl, cxNavigator, cxListBox, cxEdit,
  cxDataStorage, cxCustomData, cxData, cxFilter, cxDataUtils, cxContainer,
  cxCheckBox, cxCheckListBox, cxStyles, cxGridCommon, cxGridCustomView;

const
  cxGridFilterDefaultItemMRUItemsListCount = 5;
  cxGridFilterDefaultItemPopupMaxDropDownItemCount = 15;
  cxGridFilterDefaultMRUItemsListCount = 10;
  cxGridItemDefaultMinWidth = 20;
  cxGridNavigatorDefaultOffset = 50;

  htCustomGridTableBase = 100;
  htFilter = htCustomGridTableBase + 1;
  htFilterActivateButton = htCustomGridTableBase + 2;
  htFilterCloseButton = htCustomGridTableBase + 3;
  htFilterDropDownButton = htCustomGridTableBase + 4;
  htFilterCustomizeButton = htCustomGridTableBase + 5;
  htRecord = htCustomGridTableBase + 6;
  htCell = htCustomGridTableBase + 7;
  htExpandButton = htCustomGridTableBase + 8;

  // record kind
  rkNone = -1;
  rkNormal = 0;
  rkNewItem = 1;

  isCustomItemFirst = 0;
  isContent = isCustomItemFirst;
  isCustomItemLast = isContent;

  bbCustomTableFirst = bbCustomLast + 1;
  bbContent = bbCustomTableFirst;
  bbFilterBox = bbCustomTableFirst + 1;
  bbCustomTableLast = bbFilterBox;

  vsCustomTableFirst = vsCustomLast + 1;
  vsContent = vsCustomTableFirst;
  vsContentEven = vsCustomTableFirst + 1;
  vsContentOdd = vsCustomTableFirst + 2;
  vsFilterBox = vsCustomTableFirst + 3;
  vsInactive = vsCustomTableFirst + 4;
  vsIncSearch = vsCustomTableFirst + 5;
  vsSelection = vsCustomTableFirst + 6;
  vsCustomTableLast = vsSelection;

type
  TcxGridItemDataBindingClass = class of TcxGridItemDataBinding;
  TcxCustomGridTableItemsListBox = class;
  TcxCustomGridTableCustomizationForm = class;
  TcxGridFilterPopup = class;
  TcxCustomGridTableController = class;
  TcxCustomGridRecord = class;
  TcxCustomGridTableViewData = class;
  TcxCustomGridFilterButtonViewInfo = class;
  TcxGridFilterActivateButtonViewInfo = class;
  TcxGridFilterButtonsViewInfo = class;
  TcxGridFilterViewInfo = class;
  TcxGridTableDataCellViewInfo = class;
  TcxCustomGridRecordViewInfoClass = class of TcxCustomGridRecordViewInfo;
  TcxCustomGridRecordViewInfo = class;
  TcxCustomGridRecordsViewInfo = class;
  TcxCustomGridTableViewInfo = class;
  TcxCustomGridTableViewInfoCacheItem = class;
  TcxCustomGridTableItem = class;
  TcxCustomGridTableFiltering = class;
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
    function CanExecuteWhenLocked: Boolean; override;
    procedure Execute; override;
    property FocusedRecordIndex: Integer read FFocusedRecordIndex;
    property NewItemRecordFocusingChanged: Boolean read FNewItemRecordFocusingChanged;
    property PrevFocusedRecordIndex: Integer read FPrevFocusedRecordIndex;
  end;

  { hit tests }

  TcxGridFilterHitTest = class(TcxCustomGridViewHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  TcxGridFilterCloseButtonHitTest = class(TcxCustomGridViewHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  TcxGridFilterActivateButtonHitTest = class(TcxCustomGridViewHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  TcxGridFilterDropDownButtonHitTest = class(TcxCustomGridViewHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  TcxGridFilterCustomizeButtonHitTest = class(TcxCustomGridViewHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  TcxGridRecordHitTest = class(TcxCustomGridViewHitTest)
  private
    FGridRecordIndex: Integer;
    FGridRecordKind: Integer;
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
    //function GetFilterPropertyValue(const AName: string; var AValue: Variant): Boolean;
    function GetScrollBarPos: Integer;
    function GetScrollBarRecordCount: Integer;
    //function SetFilterPropertyValue(const AName: string; const AValue: Variant): Boolean;
    function SetScrollBarPos(Value: Integer): Boolean;
  end;

  TcxGridDataController = class(TcxDataController,
    IcxCustomGridDataController, IcxGridDataController)
  private
    FLoadedData: TMemoryStream;
    function GetGridViewValue: TcxCustomGridTableView;
    procedure ReadData(Stream: TStream);
    procedure WriteData(Stream: TStream);
  protected
    { IcxCustomGridDataController }
    procedure AssignData(ADataController: TcxCustomDataController);
    procedure CreateAllItems;
    procedure DeleteAllItems;
    procedure GetFakeComponentLinks(AList: TList);
    function GetGridView: TcxCustomGridView;
    function IsDataChangeable: Boolean;
    function IsDataLinked: Boolean;
    function SupportsCreateAllItems: Boolean;
    { IcxGridDataController }
    procedure CheckGridModeBufferCount;
    function DoScroll(AForward: Boolean): Boolean;
    function DoScrollPage(AForward: Boolean): Boolean;
    //function GetFilterPropertyValue(const AName: string; var AValue: Variant): Boolean;
    function GetItemDataBindingClass: TcxGridItemDataBindingClass;
    function GetItemDefaultValuesProviderClass: TcxCustomEditDefaultValuesProviderClass;
    function GetNavigatorIsBof: Boolean;
    function GetNavigatorIsEof: Boolean;
    function GetScrollBarPos: Integer;
    function GetScrollBarRecordCount: Integer;
    //function SetFilterPropertyValue(const AName: string; const AValue: Variant): Boolean;
    function SetScrollBarPos(Value: Integer): Boolean;

    function CanSelectRow(ARowIndex: Integer): Boolean; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure DoValueTypeClassChanged(AItemIndex: Integer); override;
    procedure FilterChanged; override;
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
    procedure Loaded; override;
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
    property OnAfterCancel;
    property OnAfterDelete;
    property OnAfterInsert;
    property OnAfterPost;
    property OnBeforeCancel;
    property OnBeforeDelete;
    property OnBeforeInsert;
    property OnBeforePost;
    property OnNewRecord;
    property OnCompare;
    property OnDataChanged;
    property OnDetailCollapsing;
    property OnDetailCollapsed;
    property OnDetailExpanding;
    property OnDetailExpanded;
    property OnFilterRecord;
    property OnGroupingChanged;
    property OnRecordChanged;
    property OnSortingChanged;
  end;

  TcxGridFilterMRUValueItem = class(TcxMRUItem)
  public
    Value: Variant;
    DisplayText: string;
    constructor Create(const AValue: Variant; const ADisplayText: string);
    function Equals(AItem: TcxMRUItem): Boolean; override;
  end;

  TcxGridFilterMRUValueItemsClass = class of TcxGridFilterMRUValueItems;

  TcxGridFilterMRUValueItems = class(TcxMRUItems)
  private
    function GetItem(Index: Integer): TcxGridFilterMRUValueItem;
  public
    procedure Add(const AValue: Variant; const ADisplayText: string);
    procedure AddItemsTo(AValueList: TcxDataFilterValueList);
    property Items[Index: Integer]: TcxGridFilterMRUValueItem read GetItem; default;
  end;

  TcxGridItemDataBinding = class(TPersistent)
  private
    FData: TObject;
    FDefaultValuesProvider: TcxCustomEditDefaultValuesProvider;
    FItem: TcxCustomGridTableItem;
    FFilterMRUValueItems: TcxGridFilterMRUValueItems;
    function GetDataController: TcxCustomDataController;
    function GetFilter: TcxDataFilterCriteria;
    function GetFilterCriteriaItem: TcxFilterCriteriaItem;
    function GetFiltered: Boolean;
    function GetGridView: TcxCustomGridTableView;
    function GetValueType: string;
    function GetValueTypeClass: TcxValueTypeClass;
    procedure SetData(Value: TObject);
    procedure SetFiltered(Value: Boolean);
    procedure SetValueType(const Value: string);
    procedure SetValueTypeClass(Value: TcxValueTypeClass);
  protected
    function GetDefaultValuesProviderClass: TcxCustomEditDefaultValuesProviderClass;
    function GetDefaultValueTypeClass: TcxValueTypeClass; virtual;
    function GetFilterFieldName: string; virtual;
    function GetFilterMRUValueItemsClass: TcxGridFilterMRUValueItemsClass; virtual;
    procedure Init; virtual;
    function IsValueTypeStored: Boolean; virtual;
    property DefaultValuesProvider: TcxCustomEditDefaultValuesProvider read FDefaultValuesProvider;
  public
    constructor Create(AItem: TcxCustomGridTableItem); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    function DefaultCaption: string; virtual;
    function DefaultRepositoryItem: TcxEditRepositoryItem; virtual;
    function DefaultWidth(ATakeHeaderIntoAccount: Boolean = True): Integer; virtual;
    function GetDefaultValuesProvider(AProperties: TcxCustomEditProperties = nil): IcxEditDefaultValuesProvider;
    function IsDisplayFormatDefined(AIsCurrencyValueAccepted: Boolean): Boolean;

    function AddToFilter(AParent: TcxFilterCriteriaItemList; AOperatorKind: TcxFilterOperatorKind;
      const AValue: Variant; const ADisplayText: string = '';
      AReplaceExistent: Boolean = True): TcxFilterCriteriaItem; virtual;
    procedure GetFilterDisplayText(const AValue: Variant; var ADisplayText: string);
    procedure GetFilterStrings(AStrings: TStrings; AValueList: TcxDataFilterValueList);
    procedure GetFilterValues(AValueList: TcxDataFilterValueList; AValuesOnly: Boolean = True;
      AInitSortByDisplayText: Boolean = False);

    property Data: TObject read FData write SetData;
    property DataController: TcxCustomDataController read GetDataController;
    property Filter: TcxDataFilterCriteria read GetFilter;
    property FilterCriteriaItem: TcxFilterCriteriaItem read GetFilterCriteriaItem;
    property Filtered: Boolean read GetFiltered write SetFiltered;
    property FilterFieldName: string read GetFilterFieldName;
    property FilterMRUValueItems: TcxGridFilterMRUValueItems read FFilterMRUValueItems;
    property GridView: TcxCustomGridTableView read GetGridView;
    property Item: TcxCustomGridTableItem read FItem;
    property ValueTypeClass: TcxValueTypeClass read GetValueTypeClass write SetValueTypeClass;
  published
    property ValueType: string read GetValueType write SetValueType stored IsValueTypeStored;
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
    function GetLastParentRecordCount: Integer;
    function GetLevel: Integer;
    function GetPartVisible: Boolean;
    function GetRecordIndex: Integer;
    procedure SetExpanded(Value: Boolean);
    procedure SetFocused(Value: Boolean);
  protected
    procedure RefreshRecordInfo; virtual;

    procedure DoCollapse(ARecurse: Boolean); virtual;
    procedure DoExpand(ARecurse: Boolean); virtual; 
    //function GetDestroyingOnExpanding: Boolean; virtual;
    function GetExpandable: Boolean; virtual;
    function GetExpanded: Boolean; virtual;

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
    procedure SetDisplayText(Index: Integer; const Value: string); virtual;
    procedure SetValue(Index: Integer; const Value: Variant); virtual;

    function GetViewInfoCacheItemClass: TcxCustomGridViewInfoCacheItemClass; virtual; abstract;
    function GetViewInfoClass: TcxCustomGridRecordViewInfoClass; virtual; abstract;

    property EatKeyPress: Boolean read FEatKeyPress write FEatKeyPress;
    property IsParent: Boolean read GetIsParent;
    property RecordInfo: TcxRowInfo read FRecordInfo;

    property Controller: TcxCustomGridTableController read GetController;
    property DataController: TcxCustomDataController read GetDataController;
    //property DestroyingOnExpanding: Boolean read GetDestroyingOnExpanding;
  public
    constructor Create(AViewData: TcxCustomGridTableViewData; AIndex: Integer;
      const ARecordInfo: TcxRowInfo); virtual;
    destructor Destroy; override;
    function CanFocus: Boolean; virtual;
    function CanFocusCells: Boolean; virtual;
    procedure Collapse(ARecurse: Boolean);
    procedure DoKeyPress(var Key: Char);
    procedure Expand(ARecurse: Boolean);
    function GetFirstFocusableChild: TcxCustomGridRecord; virtual;
    function GetLastFocusableChild(ARecursive: Boolean): TcxCustomGridRecord; virtual;
    procedure Invalidate(AItem: TcxCustomGridTableItem = nil); virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); virtual;
    procedure KeyPress(var Key: Char); virtual;
    procedure MakeVisible;

    //property Data: Pointer read FData write FData;
    property DragHighlighted: Boolean read GetDragHighlighted;
    property DisplayTexts[Index: Integer]: string read GetDisplayText write SetDisplayText;
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
    property LastParentRecordCount: Integer read GetLastParentRecordCount;
    property Level: Integer read GetLevel;
    property ParentRecord: TcxCustomGridRecord read GetParentRecord;
    property PartVisible: Boolean read GetPartVisible;
    property RecordIndex: Integer read GetRecordIndex;
    property Selected: Boolean read GetSelected write SetSelected;
    property ValueCount: Integer read GetValueCount;
    property Values[Index: Integer]: Variant read GetValue write SetValue;
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
    function GetRecordByKind(AKind, AIndex: Integer): TcxCustomGridRecord; virtual;
    function GetRecordClass(ARecordInfo: TcxRowInfo): TcxCustomGridRecordClass; virtual; abstract;
    function GetRecordKind(ARecord: TcxCustomGridRecord): Integer; virtual;

    procedure AssignEditingRecord;

    procedure CreateNewItemRecord;
    procedure DestroyNewItemRecord;
    function GetNewItemRecordClass: TcxCustomGridRecordClass; virtual;
    procedure RecreateNewItemRecord;

    property Controller: TcxCustomGridTableController read GetController;
    property InternalRecords[Index: Integer]: TcxCustomGridRecord read GetInternalRecord;
    property ViewInfo: TcxCustomGridTableViewInfo read GetViewInfo;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    destructor Destroy; override;
    procedure Collapse(ARecurse: Boolean); virtual;
    procedure DestroyRecords;
    procedure Expand(ARecurse: Boolean); virtual;
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

  { controller }

  // drag&drop objects

  TcxCustomGridTableMovingObject = class(TcxCustomGridMovingObject)
  private
    function GetController: TcxCustomGridTableController;
    function GetCustomizationForm: TcxCustomGridTableCustomizationForm;
  protected
    procedure DragAndDrop(const P: TPoint; var Accepted: Boolean); override;
    property Controller: TcxCustomGridTableController read GetController;
    property CustomizationForm: TcxCustomGridTableCustomizationForm read GetCustomizationForm;
  end;

  TcxGridItemContainerKind = Integer;

  TcxGridItemContainerZone = class
  public
    ItemIndex: Integer;
    constructor Create(AItemIndex: Integer);
    function IsEqual(Value: TcxGridItemContainerZone): Boolean; virtual;
  end;

  TcxCustomGridTableItemMovingObject = class(TcxCustomGridTableMovingObject)
  private
    FDestItemContainerKind: TcxGridItemContainerKind;
    FDestZone: TcxGridItemContainerZone;
    FOriginalDestItemContainerKind: TcxGridItemContainerKind;
    FSourceItemContainerKind: TcxGridItemContainerKind;

    procedure SetDestItemContainerKind(Value: TcxGridItemContainerKind);
    procedure SetDestZone(Value: TcxGridItemContainerZone);
  protected
    procedure CalculateDestParams(AHitTest: TcxCustomGridHitTest;
      out AContainerKind: TcxGridItemContainerKind; out AZone: TcxGridItemContainerZone); virtual;
    procedure CheckDestParams; virtual;
    function GetCustomizationFormListBox: TcxCustomGridItemsListBox; override;
    function IsSourceCustomizationForm: Boolean; override;

    procedure BeginDragAndDrop; override;
    procedure DragAndDrop(const P: TPoint; var Accepted: Boolean); override;
    procedure EndDragAndDrop(Accepted: Boolean); override;

    property DestItemContainerKind: TcxGridItemContainerKind read FDestItemContainerKind
      write SetDestItemContainerKind;
    property DestZone: TcxGridItemContainerZone read FDestZone write SetDestZone;
    property OriginalDestItemContainerKind: TcxGridItemContainerKind
      read FOriginalDestItemContainerKind write FOriginalDestItemContainerKind;
    property SourceItemContainerKind: TcxGridItemContainerKind read FSourceItemContainerKind
      write FSourceItemContainerKind;
  public
    constructor Create(AControl: TcxControl); override;
    destructor Destroy; override;
  end;

  // customization form

  TcxCustomGridTableItemsListBoxClass = class of TcxCustomGridTableItemsListBox;

  TcxCustomGridTableItemsListBox = class(TcxCustomGridItemsListBox)
  private
    function GetGridView: TcxCustomGridTableView;
  protected
    procedure RefreshItemsAsTableItems;
    property GridView: TcxCustomGridTableView read GetGridView;
  end;

  TcxCustomGridTableCustomizationForm = class(TcxCustomGridCustomizationForm)
  private
    FItemsListBox: TcxCustomGridTableItemsListBox;
    FItemsPage: TcxTabSheet;
  protected
    procedure CreateControls; override;
    function GetItemsListBoxClass: TcxCustomGridTableItemsListBoxClass; virtual;
    function GetItemsPageCaption: string; virtual; abstract;
    function GetItemsPageVisible: Boolean; virtual;
    procedure InitPageControl; override;

    property ItemsListBox: TcxCustomGridTableItemsListBox read FItemsListBox;
  public
    procedure RefreshData; override;
    property ItemsPage: TcxTabSheet read FItemsPage;
  end;

  // popups

  IcxGridFilterPopupOwner = interface(IcxCustomGridPopupOwner)
    ['{1FC070B2-36E5-4388-B22D-1FF5D240E95F}']
    function GetItem: TcxCustomGridTableItem;
  end;

  TcxGridFilterPopupListBox = class(TcxGridPopupListBox)
  private
    function GetPopup: TcxGridFilterPopup;
  protected
    procedure DrawItemContent(ACanvas: TcxCanvas; AIndex: Integer; ARect: TRect;
      AState: TOwnerDrawState); override;
  public
    property Popup: TcxGridFilterPopup read GetPopup;
  end;

  TcxGridFilterPopupClass = class of TcxGridFilterPopup;

  TcxGridFilterPopup = class(TcxCustomGridPopup)
  private
    FItem: TcxCustomGridTableItem;
    FListBox: TcxGridFilterPopupListBox;
    FListBoxItems: TStringList;
    FValueList: TcxDataFilterValueList;
    function GetFilter: TcxDataFilterCriteria;
    function GetGridView: TcxCustomGridTableView;
    //function GetOwnerValue: IcxGridFilterPopupOwner;
    //procedure SetOwnerValue(Value: IcxGridFilterPopupOwner);
    procedure ListBoxAction(Sender: TcxGridPopupListBox; AItemIndex: Integer);
  protected
    procedure AddListBoxItems; virtual;
    procedure AdjustListBoxSize; virtual;
    procedure ApplyFilter(AItemIndex: Integer); virtual;
    function GetSelectedItemIndex: Integer; virtual;
    procedure InitPopup; override;
    function IsMRUItemsListSeparatorItem(AIndex: Integer): Boolean;

    property Filter: TcxDataFilterCriteria read GetFilter;
    property ListBox: TcxGridFilterPopupListBox read FListBox;
    property ListBoxItems: TStringList read FListBoxItems;
    property SelectedItemIndex: Integer read GetSelectedItemIndex;
    property ValueList: TcxDataFilterValueList read FValueList;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    destructor Destroy; override;
    procedure CloseUp; override;
    property GridView: TcxCustomGridTableView read GetGridView;
    property Item: TcxCustomGridTableItem read FItem;
//    property Owner: IcxGridFilterPopupOwner read GetOwnerValue write SetOwnerValue;
  end;

  TcxGridFilterMRUItemsPopupClass = class of TcxGridFilterMRUItemsPopup;

  TcxGridFilterMRUItemsPopup = class(TcxCustomGridPopup)
  private
    FListBox: TcxGridPopupListBox;
    function GetFiltering: TcxCustomGridTableFiltering;
    function GetGridView: TcxCustomGridTableView;
    procedure ListBoxAction(Sender: TcxGridPopupListBox; AItemIndex: Integer);
  protected
    procedure AddFilterMRUItems(AStrings: TStrings); virtual;
    procedure ApplyFilterMRUItem(AItemIndex: Integer); virtual;
    function GetTextOffsetHorz: Integer; virtual;
    procedure InitPopup; override;

    property Filtering: TcxCustomGridTableFiltering read GetFiltering;
    property ListBox: TcxGridPopupListBox read FListBox;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    property GridView: TcxCustomGridTableView read GetGridView;
    property TextOffsetHorz: Integer read GetTextOffsetHorz;
  end;

  TcxCustomGridCustomizationPopup = class(TcxCustomGridPopup)
  private
    FCheckListBox: TcxCheckListBox;
    function GetGridView: TcxCustomGridTableView;
    procedure CheckListBoxCheckClick(Sender: TObject; AIndex: Integer;
      APrevState, ANewState: TcxCheckBoxState);
    procedure CheckListBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  protected
    procedure AddCheckListBoxItems; virtual; abstract;
    procedure AdjustCheckListBoxSize; virtual;
    procedure CheckClicked(AIndex: Integer; AChecked: Boolean); virtual;
    procedure CreateCheckListBox; virtual;
    function GetDropDownCount: Integer; virtual; abstract;
    procedure InitPopup; override;
    procedure ItemClicked(AItem: TObject; AChecked: Boolean); virtual; abstract;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    procedure CloseUp; override;
    property CheckListBox: TcxCheckListBox read FCheckListBox;
    property GridView: TcxCustomGridTableView read GetGridView;
  end;

  TcxCustomGridItemsCustomizationPopupClass = class of TcxCustomGridItemsCustomizationPopup;

  TcxCustomGridItemsCustomizationPopup = class(TcxCustomGridCustomizationPopup)
  protected
    procedure AddCheckListBoxItems; override;
    function GetDropDownCount: Integer; override;
    procedure ItemClicked(AItem: TObject; AChecked: Boolean); override;
  end;

  // controllers

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
    FEditShowingTimer: TcxTimer;
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
    function CanInitEditing: Boolean; virtual;
    function CanRemoveEditFocus: Boolean; virtual;
    function CanUpdateEditValue: Boolean; virtual;
    procedure CheckEdit;
    procedure CheckEditUpdatePost;
    procedure DoEditChanged; virtual;
    procedure DoEditKeyDown(var Key: Word; Shift: TShiftState); virtual;
    procedure DoUpdateEdit;
    function GetHideEditOnExit: Boolean; virtual;
    function GetHideEditOnFocusedRecordChange: Boolean; virtual;
    procedure InitEdit; virtual;
    procedure UninitEdit; virtual;
    procedure PostEditingData; virtual;
    procedure PostEditUpdate;
    function PrepareEdit(AItem: TcxCustomGridTableItem; AOnMouseEvent: Boolean): Boolean; virtual;
    procedure UpdateEditValue;
    procedure UpdateValue;

    procedure AssignEditEvents; virtual;
    procedure UnassignEditEvents; virtual;
    procedure EditAfterKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    procedure EditChanged(Sender: TObject); virtual;
    procedure EditEditing(Sender: TObject; var CanEdit: Boolean); virtual;
    procedure EditExit(Sender: TObject); virtual;
    procedure EditFocusChanged(Sender: TObject); virtual;
    procedure EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    procedure EditKeyPress(Sender: TObject; var Key: Char); virtual;
    procedure EditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    procedure EditPostEditValue(Sender: TObject); virtual;
    procedure EditValueChanged(Sender: TObject); virtual;

    property EditHiding: Boolean read FEditHiding;
    property EditingProperties: TcxCustomEditProperties read GetEditingProperties;
    property EditList: TcxInplaceEditList read FEditList;
    property EditPreparing: Boolean read FEditPreparing;
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
    AItemIndex: Integer; AData: TObject): Boolean;

  TcxCustomGridTableController = class(TcxCustomGridController)
  private
    FAllowCheckEdit: Boolean;
    FBlockRecordKeyboardHandling: Boolean;
    FCheckEditNeeded: Boolean;
    FCheckingCoordinate: Boolean;
    FClickedCellViewInfo: TcxGridTableDataCellViewInfo;
    FDragDropText: string;
    FDragScrollDirection: TcxDirection;
    FDragScrollTimer: TcxTimer;
    FDragHighlightedRecord: TcxCustomGridRecord;
    FEatKeyPress: Boolean;
    FEditingController: TcxGridEditingController;
    FFilterMRUItemsPopup: TcxGridFilterMRUItemsPopup;
    FFilterPopup: TcxGridFilterPopup;
    FFocusedItem: TcxCustomGridTableItem;
    FFocusOnRecordFocusing: Boolean;
    FForcingWidthItem: TcxCustomGridTableItem;
    FGridModeBufferCountUpdateNeeded: Boolean;
    FGridModeBufferCountUpdateTimer: TcxTimer;
    FIsPullFocusing: Boolean;
    FIsReadyForImmediateEditing: Boolean;
    FIsRecordUnselecting: Boolean;
    FItemsCustomizationPopup: TcxCustomGridItemsCustomizationPopup;
    FMovingItem: TcxCustomGridTableItem;
    FPullFocusingItem: TcxCustomGridTableItem;
    FPullFocusingMousePos: TPoint;
    FPullFocusingOriginHitTest: TcxCustomGridHitTest;
    FPullFocusingRecordId: Variant;
    FPullFocusingScrollingDirection: TcxDirection;
    FPullFocusingScrollingTimer: TcxTimer;
    FScrollDirection: TcxDirection;
    FScrollTimer: TcxTimer;
    FTopRecordIndex: Integer;
    FUnselectingRecordIndex: Integer;

    function GetEditingItem: TcxCustomGridTableItem;
    function GetFilterMRUItemsPopup: TcxGridFilterMRUItemsPopup;
    function GetFilterPopup: TcxGridFilterPopup;
    function GetFocusedItemIndex: Integer;
    function GetFocusedRecordIndex: Integer;
    function GetGridView: TcxCustomGridTableView;
    function GetIncSearchingItem: TcxCustomGridTableItem;
    function GetIncSearchingText: string;
    function GetIsEditing: Boolean;
    function GetIsIncSearching: Boolean;
    function GetIsItemMoving: Boolean;
    function GetItemsCustomizationPopup: TcxCustomGridItemsCustomizationPopup;
    function GetMasterController: TcxCustomGridTableController;
    function GetMultiSelect: Boolean;
    function GetNewItemRecordFocused: Boolean;
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
    procedure SetNewItemRecordFocused(Value: Boolean);
    procedure SetScrollDirection(Value: TcxDirection);
    procedure SetTopRecordIndex(Value: Integer);

    procedure DragScrollTimerHandler(Sender: TObject);
    procedure GridModeBufferCountUpdateTimerHandler(Sender: TObject);
    procedure PullFocusingScrollingTimerHandler(Sender: TObject);

    procedure CreateScrollTimer;
    procedure DestroyScrollTimer;
    procedure ScrollTimerHandler(Sender: TObject);
  protected
    procedure AfterPaint; override;
    procedure BeforePaint; override;
    function CanFocusOnClick(X, Y: Integer): Boolean; override;
    procedure DetailFocused(ADetail: TcxCustomGridView); override;
    procedure DoEnter; override;
    procedure DoExit; override;
    function MayFocus: Boolean; override;
    procedure RemoveFocus; override;
    procedure SetFocus(ANotifyMaster: Boolean); override;

    procedure AfterOffset; virtual;
    procedure BeforeKillFocus; override;
    procedure BeforeOffset; virtual;
    function CanAppend(ACheckOptions: Boolean): Boolean; virtual;
    procedure CancelCheckEditPost;
    function CanDelete(ACheckOptions: Boolean): Boolean; virtual;
    function CanEdit: Boolean; virtual;
    procedure CheckCoordinates; override;
    function CanHScrollBarHide: Boolean; virtual;
    function CanInsert(ACheckOptions: Boolean): Boolean; virtual;
    procedure CheckEdit; virtual;
    procedure CheckTopRecordIndex(var Value: Integer); virtual;
    function FindNextCustomItem(AFocusedItemIndex, AItemCount: Integer;
      AGoForward, AGoOnCycle: Boolean; ACanFocus: TcxCustomGridTableCanItemFocus;
      AData: TObject; var AItemIndex: Integer; out ACycleChanged: Boolean): Boolean;
    procedure FocusedItemChanged(APrevFocusedItem: TcxCustomGridTableItem); virtual;
    procedure FocusedRecordChanged(APrevFocusedRecordIndex, AFocusedRecordIndex: Integer;
      ANewItemRecordFocusingChanged: Boolean); virtual;
    function GetCancelEditingOnExit: Boolean; virtual;
    function GetFilterMRUItemsPopupClass: TcxGridFilterMRUItemsPopupClass; virtual;
    function GetFilterPopupClass: TcxGridFilterPopupClass; virtual;
    function GetFocusedRecord: TcxCustomGridRecord; virtual;
    function GetIsRecordsScrollHorizontal: Boolean; virtual; abstract;
    function GetItemsCustomizationPopupClass: TcxCustomGridItemsCustomizationPopupClass; virtual;
    function GetMaxTopRecordIndexValue: Integer; virtual;
    function GetPatternObject(AObject: TPersistent): TPersistent; override;
    function GetScrollBarOffsetBegin: Integer; virtual;
    function GetScrollBarOffsetEnd: Integer; virtual;
    function GetScrollBarPos: Integer; virtual;
    function GetScrollBarRecordCount: Integer; virtual;
    function GetVisibleRecordCount(AFirstRecordIndex: Integer;
      ACalculateDown: Boolean = True): Integer; virtual;
    procedure PostCheckEdit;
    procedure ProcessCheckEditPost;
    procedure ScrollData(ADirection: TcxDirection); virtual;
    procedure SetFocusedRecord(Value: TcxCustomGridRecord); virtual;
    procedure SetScrollBarPos(Value: Integer); virtual;

    procedure CancelGridModeBufferCountUpdate;
    procedure CheckGridModeBufferCountUpdatePost;
    procedure PostGridModeBufferCountUpdate;
    property GridModeBufferCountUpdateNeeded: Boolean read FGridModeBufferCountUpdateNeeded;

    // internal draganddrop data scrolling
    function CanScrollData(ADirection: TcxDirection): Boolean; virtual;
    function GetScrollDataTimeInterval(ADirection: TcxDirection): Integer; virtual;
    property ScrollDirection: TcxDirection read FScrollDirection write SetScrollDirection;

    // selection
    function CanPostponeRecordSelection: Boolean; virtual;
    function CanProcessMultiSelect(AIsKeyboard: Boolean): Boolean; overload; virtual;
    function CanProcessMultiSelect(AHitTest: TcxCustomGridHitTest;
      AShift: TShiftState): Boolean; overload; virtual;
    function CanProcessMultiSelect(AKey: Word; AShift: TShiftState;
      AFocusedRecordChanged: Boolean): Boolean; overload; virtual;
    procedure ChangeRecordSelection(ARecord: TcxCustomGridRecord; Value: Boolean);
    procedure CheckFocusedRecordSelectionWhenExit(ARecord: TcxCustomGridRecord);
    procedure DoMouseNormalSelection(AHitTest: TcxCustomGridHitTest); virtual;
    procedure DoMouseRangeSelection(AClearSelection: Boolean = True; AData: TObject = nil); virtual;
    procedure DoNormalSelection; virtual;
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
    function SupportsAdditiveSelection: Boolean; virtual;
    function SupportsRecordSelectionToggling: Boolean; virtual;

    // navigation
    function CanFocusNextItem(AFocusedItemIndex, ANextItemIndex: Integer;
      AGoForward, AGoOnCycle, AGoToNextRecordOnCycle: Boolean): Boolean; virtual;
    function FocusedRecordHasCells(ACheckCellSelectionAbility: Boolean): Boolean;
    procedure FocusNextPage(ASyncSelection: Boolean); virtual;
    procedure FocusPrevPage(ASyncSelection: Boolean); virtual;
    function IsKeyForController(AKey: Word; AShift: TShiftState): Boolean; virtual;
    procedure ScrollPage(AForward: Boolean); virtual;
    procedure ScrollRecords(AForward: Boolean; ACount: Integer); virtual;
    procedure ShowNextPage; virtual;
    procedure ShowPrevPage; virtual;

    // pull focusing
    procedure DoPullFocusing(AHitTest: TcxGridRecordHitTest); virtual;
    procedure DoPullFocusingScrolling(ADirection: TcxDirection); virtual;
    function GetPullFocusingScrollingDirection(X, Y: Integer; out ADirection: TcxDirection): Boolean; virtual;
    function IsPullFocusingPosChanged: Boolean;
    procedure SavePullFocusingPos;
    procedure StartPullFocusing(AHitTest: TcxCustomGridHitTest); virtual;
    procedure StopPullFocusing;
    procedure StartPullFocusingScrolling(ADirection: TcxDirection);
    procedure StopPullFocusingScrolling;
    function SupportsPullFocusing: Boolean; virtual;
    property PullFocusingOriginHitTest: TcxCustomGridHitTest read FPullFocusingOriginHitTest;

    // delphi drag and drop
    function GetDragScrollDirection(X, Y: Integer): TcxDirection; virtual;
    function GetDragScrollInterval: Integer; virtual;
    function IsFirstRecordForDragScroll(ARecord: TcxCustomGridRecord): Boolean; virtual;
    function IsLastRecordForDragScroll(ARecord: TcxCustomGridRecord): Boolean; virtual;
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

    // incsearching
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
    property IsReadyForImmediateEditing: Boolean read FIsReadyForImmediateEditing
      write FIsReadyForImmediateEditing;
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
      AGoForward, AGoOnCycle: Boolean; out ACycleChanged: Boolean;
      ARecord: TcxCustomGridRecord): Integer; virtual;
    function FindNextRecord(AFocusedRecordIndex: Integer;
      AGoForward, AGoOnCycle: Boolean; out ACycleChanged: Boolean): Integer;
    function HasFilterMRUItemsPopup: Boolean;
    function HasFilterPopup: Boolean;
    function HasFocusedControls: Boolean; override;
    function HasItemsCustomizationPopup: Boolean;
    function IsClickableRecordHitTest(AHitTest: TcxCustomGridHitTest): Boolean;
    function IsDataFullyVisible(AIsCallFromMaster: Boolean = False): Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    function ProcessDetailDialogChar(ADetail: TcxCustomGridView; ACharCode: Word): Boolean; override;
    function ProcessDialogChar(ACharCode: Word): Boolean; override;
    function SupportsTabAccelerators(AGridRecord: TcxCustomGridRecord): Boolean; virtual;
    procedure WndProc(var Message: TMessage); override;

    procedure BeforeStartDrag; override;
    function CanDrag(X, Y: Integer): Boolean; override;
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean); override;
    procedure DrawDragImage(ACanvas: TcxCanvas; R: TRect); override;
    procedure EndDrag(Target: TObject; X, Y: Integer); override;
    function GetDragDropText(ADragObject: TDragObject): string; virtual;
    procedure GetDragDropTextViewParams(out AParams: TcxViewParams); virtual;
    function GetDragImagesSize: TPoint; override;
    function HasDragImages: Boolean; override;
    procedure StartDrag(var DragObject: TDragObject); override;
    property DragDropText: string read FDragDropText;

    procedure CancelIncSearching;
    function CheckEditing(var AFocusedRecordIndex: Integer; AGoForward: Boolean): Boolean;
    procedure CheckScrolling(const P: TPoint); virtual;
    procedure ClearSelection; virtual;
    procedure CreateNewRecord(AtEnd: Boolean); virtual;
    procedure DeleteSelection; virtual;
    function FocusFirstAvailableItem: Boolean;
    function FocusNextCell(AGoForward: Boolean; AProcessCellsOnly: Boolean = True;
      AAllowCellsCycle: Boolean = True): Boolean;
    function FocusNextItem(AFocusedItemIndex: Integer;
      AGoForward, AGoOnCycle, AGoToNextRecordOnCycle: Boolean): Boolean;
    function FocusNextRecord(AFocusedRecordIndex: Integer;
      AGoForward, AGoOnCycle, AGoIntoDetail, AGoOutOfDetail: Boolean): Boolean;
    function FocusNextRecordWithSelection(AFocusedRecordIndex: Integer;
      AGoForward, AGoOnCycle, AGoIntoDetail: Boolean; ASyncSelection: Boolean = True): Boolean;
    function FocusRecord(AFocusedRecordIndex: Integer; ASyncSelection: Boolean): Boolean;
    procedure MakeFocusedItemVisible;
    procedure MakeFocusedRecordVisible;
    procedure MakeItemVisible(AItem: TcxCustomGridTableItem); virtual; abstract;
    procedure MakeRecordVisible(ARecord: TcxCustomGridRecord); virtual;
    procedure SelectAll; virtual;
    procedure SelectAllRecords;

    function GoToFirst: Boolean;
    function GoToLast(AGoIntoDetail: Boolean): Boolean;
    function GoToNext(AGoIntoDetail: Boolean; ASyncSelection: Boolean = True): Boolean;
    function GoToPrev(AGoIntoDetail: Boolean; ASyncSelection: Boolean = True): Boolean;
    function IsFinish: Boolean;
    function IsStart: Boolean;

    property ClickedCellViewInfo: TcxGridTableDataCellViewInfo read FClickedCellViewInfo write FClickedCellViewInfo;
    property EditingController: TcxGridEditingController read FEditingController;
    property EditingItem: TcxCustomGridTableItem read GetEditingItem write SetEditingItem;
    property FilterMRUItemsPopup: TcxGridFilterMRUItemsPopup read GetFilterMRUItemsPopup;
    property FilterPopup: TcxGridFilterPopup read GetFilterPopup;
    property FocusedItem: TcxCustomGridTableItem read FFocusedItem write SetFocusedItem;
    property FocusedItemIndex: Integer read GetFocusedItemIndex write SetFocusedItemIndex;
    property FocusedRecord: TcxCustomGridRecord read GetFocusedRecord write SetFocusedRecord;
    property FocusedRecordIndex: Integer read GetFocusedRecordIndex write SetFocusedRecordIndex;
    property GridView: TcxCustomGridTableView read GetGridView;
    property IncSearchingItem: TcxCustomGridTableItem read GetIncSearchingItem;
    property IncSearchingText: string read GetIncSearchingText write SetIncSearchingText;
    property IsPullFocusing: Boolean read FIsPullFocusing;
    property IsEditing: Boolean read GetIsEditing;
    property IsIncSearching: Boolean read GetIsIncSearching;
    property IsItemMoving: Boolean read GetIsItemMoving;
    property ItemsCustomizationPopup: TcxCustomGridItemsCustomizationPopup read GetItemsCustomizationPopup;
    property MasterController: TcxCustomGridTableController read GetMasterController;
    property MovingItem: TcxCustomGridTableItem read FMovingItem;
    property NewItemRecordFocused: Boolean read GetNewItemRecordFocused write SetNewItemRecordFocused; 
    property SelectedRecordCount: Integer read GetSelectedRecordCount;
    property SelectedRecords[Index: Integer]: TcxCustomGridRecord read GetSelectedRecord;
    property TopRecordIndex: Integer read FTopRecordIndex write SetTopRecordIndex;
  end;

  { painters }

  TcxCustomGridPartPainter = class(TcxCustomGridCellPainter);

  // filter

  TcxCustomGridFilterButtonPainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxCustomGridFilterButtonViewInfo;
  protected
    function ExcludeFromClipRect: Boolean; override;
    property ViewInfo: TcxCustomGridFilterButtonViewInfo read GetViewInfo;
  end;

  TcxGridFilterCloseButtonPainter = class(TcxCustomGridFilterButtonPainter)
  protected
    procedure DrawContent; override;
  end;

  TcxGridFilterActivateButtonPainter = class(TcxCustomGridFilterButtonPainter)
  private
    function GetViewInfo: TcxGridFilterActivateButtonViewInfo;
  protected
    procedure DrawContent; override;
    property ViewInfo: TcxGridFilterActivateButtonViewInfo read GetViewInfo;
  end;

  TcxGridFilterDropDownButtonPainter = class(TcxCustomGridFilterButtonPainter)
  protected
    procedure DrawContent; override;
  end;

  TcxGridFilterCustomizeButtonPainter = class(TcxCustomGridFilterButtonPainter)
  protected
    procedure Paint; override;
  end;

  TcxGridFilterPainterClass = class of TcxGridFilterPainter;

  TcxGridFilterPainter = class(TcxCustomGridPartPainter)
  private
    FTextWasUnderlined: Boolean;
    function GetViewInfo: TcxGridFilterViewInfo;
  protected
    procedure DrawButtons; virtual;
    function ExcludeFromClipRect: Boolean; override;
    procedure Paint; override;
    procedure PrepareCanvasForDrawText; override;
    procedure UnprepareCanvasForDrawText; override;
    property ViewInfo: TcxGridFilterViewInfo read GetViewInfo;
  end;

  // records

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
    function DrawExpandButtonBeforePaint: Boolean; virtual;
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

  // view

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
    procedure DrawBackground; override;
    procedure DrawFilterBar; virtual;
    procedure DrawInfoText; virtual;
    procedure DrawNavigator; virtual;
    procedure DrawRecords; virtual;
    procedure Offset(AItemsOffset: Integer); overload; virtual;
    procedure Offset(DX, DY: Integer); overload; virtual;
    procedure PaintBefore; override;
    procedure PaintContent; override;
  public
    procedure DoOffset(AItemsOffset, DX, DY: Integer);
    procedure DrawFocusRect(const R: TRect; AHideFocusRect: Boolean); override;
    property Controller: TcxCustomGridTableController read GetController;
    property ViewInfo: TcxCustomGridTableViewInfo read GetViewInfo;
  end;

  { view infos }

  // part

  TcxGridPartAlignment = (gpaTop, gpaBottom);

  TcxCustomGridPartViewInfo = class(TcxCustomGridViewCellViewInfo)
  private
    FHeight: Integer;
    function GetGridView: TcxCustomGridTableView;
    function GetGridViewInfo: TcxCustomGridTableViewInfo;
    function GetIndex: Integer;
    procedure SetIndex(Value: Integer);
  protected
    function CalculateBounds: TRect; virtual;
    procedure CalculateInvisible; virtual;
    procedure CalculateVisible; virtual;
    function CustomDrawBackground(ACanvas: TcxCanvas): Boolean; override;
    function GetAlignment: TcxGridPartAlignment; virtual; abstract;
    //function GetHeight: Integer; override;
    function GetIsAutoWidth: Boolean; virtual; abstract;
    function GetIsPart: Boolean; virtual;
    function GetIsScrollable: Boolean; virtual; abstract;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function HasCustomDrawBackground: Boolean; override;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); override;

    property Height: Integer read FHeight write FHeight;
    property IsPart: Boolean read GetIsPart;
  public
    constructor Create(AGridViewInfo: TcxCustomGridTableViewInfo); reintroduce; virtual; 
    destructor Destroy; override;
    procedure MainCalculate;
    property Alignment: TcxGridPartAlignment read GetAlignment;
    property GridView: TcxCustomGridTableView read GetGridView;
    property GridViewInfo: TcxCustomGridTableViewInfo read GetGridViewInfo;
    property Index: Integer read GetIndex write SetIndex;
    property IsAutoWidth: Boolean read GetIsAutoWidth;
    property IsScrollable: Boolean read GetIsScrollable;
  end;

  // filter

  TcxGridFilterButtonAlignment = (fbaLeft, fbaRight);

  TcxCustomGridFilterButtonViewInfoClass = class of TcxCustomGridFilterButtonViewInfo;

  TcxCustomGridFilterButtonViewInfo = class(TcxCustomGridViewCellViewInfo)
  private
    FContainer: TcxGridFilterButtonsViewInfo;
    function GetFilter: TcxDataFilterCriteria;
    function GetGridView: TcxCustomGridTableView;
  protected
    function CaptureMouseOnPress: Boolean; override;
    function GetAlignment: TcxGridFilterButtonAlignment; virtual;
    function GetCanvas: TcxCanvas; override;
    function GetHotTrack: Boolean; override;
    function GetVisible: Boolean; override;

    property Container: TcxGridFilterButtonsViewInfo read FContainer;
    property Filter: TcxDataFilterCriteria read GetFilter;
  public
    constructor Create(AContainer: TcxGridFilterButtonsViewInfo); reintroduce; virtual;
    property Alignment: TcxGridFilterButtonAlignment read GetAlignment;
    property GridView: TcxCustomGridTableView read GetGridView;
  end;

  TcxGridFilterCloseButtonViewInfo = class(TcxCustomGridFilterButtonViewInfo)
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    procedure Click; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
  end;

  TcxGridFilterActivateButtonViewInfo = class(TcxCustomGridFilterButtonViewInfo)
  private
    function GetChecked: Boolean;
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    procedure Click; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
  public
    property Checked: Boolean read GetChecked;
  end;

  TcxGridFilterDropDownButtonViewInfo = class(TcxCustomGridFilterButtonViewInfo)
  private
    function GetDropDownWindowValue: TcxGridFilterMRUItemsPopup;
  protected
    procedure BeforeStateChange; override;
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function CaptureMouseOnPress: Boolean; override;
    function GetAlignment: TcxGridFilterButtonAlignment; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetVisible: Boolean; override;

    function DropDownWindowExists: Boolean; override;
    function GetDropDownWindow: TcxCustomGridPopup; override;
    function GetDropDownWindowOwnerBounds: TRect; override;
    property DropDownWindow: TcxGridFilterMRUItemsPopup read GetDropDownWindowValue;
  public
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); override;
  end;

  TcxGridFilterCustomizeButtonViewInfo = class(TcxCustomGridFilterButtonViewInfo)
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    procedure Click; override;
    function GetAlignment: TcxGridFilterButtonAlignment; override;
    function GetAlignmentHorz: TAlignment; override;
    function GetAlignmentVert: TcxAlignmentVert; override;
    function GetBorders: TcxBorders; override;
    function GetBorderWidth(AIndex: TcxBorder): Integer; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetText: string; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function GetVisible: Boolean; override;
  end;

  TcxGridFilterButtonsViewInfoClass = class of TcxGridFilterButtonsViewInfo;

  TcxGridFilterButtonsViewInfo = class
  private
    FFilterViewInfo: TcxGridFilterViewInfo;
    FItems: TList;
    function GetCount: Integer;
    function GetGridView: TcxCustomGridTableView;
    function GetHeight: Integer;
    function GetItem(Index: Integer): TcxCustomGridFilterButtonViewInfo;
    function GetWidth(AAlignment: TcxGridFilterButtonAlignment): Integer;
    function GetWidthLeftPart: Integer;
    function GetWidthRightPart: Integer;
  protected
    FDropDownButtonViewInfo: TcxGridFilterDropDownButtonViewInfo;
    procedure AddItems; virtual;
    procedure DestroyItems; virtual;
    property FilterViewInfo: TcxGridFilterViewInfo read FFilterViewInfo;
    property GridView: TcxCustomGridTableView read GetGridView;
  public
    constructor Create(AFilterViewInfo: TcxGridFilterViewInfo); virtual;
    destructor Destroy; override;
    function AddItem(AItemClass: TcxCustomGridFilterButtonViewInfoClass): TcxCustomGridFilterButtonViewInfo;
    procedure Calculate(const ABounds: TRect); virtual;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; virtual;

    property Count: Integer read GetCount;
    property DropDownButtonViewInfo: TcxGridFilterDropDownButtonViewInfo read FDropDownButtonViewInfo;
    property Height: Integer read GetHeight;
    property Items[Index: Integer]: TcxCustomGridFilterButtonViewInfo read GetItem; default;
    property WidthLeftPart: Integer read GetWidthLeftPart;
    property WidthRightPart: Integer read GetWidthRightPart;
  end;

  TcxGridFilterViewInfoClass = class of TcxGridFilterViewInfo;

  TcxGridFilterViewInfo = class(TcxCustomGridPartViewInfo)
  private
    FButtonsViewInfo: TcxGridFilterButtonsViewInfo;
    function GetFilter: TcxDataFilterCriteria;
    function GetFiltering: TcxCustomGridTableFiltering;
    procedure CreateButtonsViewInfo;
    procedure DestroyButtonsViewInfo;
  protected
    function CalculateButtonsViewInfoBounds: TRect; virtual;
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function GetAlignment: TcxGridPartAlignment; override;
    function GetAlignmentVert: TcxAlignmentVert; override;
    function GetBackgroundBitmap: TBitmap; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetHotTrack: Boolean; override;
    function GetIsAutoWidth: Boolean; override;
    function GetIsCheck: Boolean; override;
    function GetIsScrollable: Boolean; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetText: string; override;
    function GetTextAreaBounds: TRect; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function GetVisible: Boolean; override;
    function HasMouse(AHitTest: TcxCustomGridHitTest): Boolean; override;
    function InvalidateOnStateChange: Boolean; override;
    procedure StateChanged; override;

    function GetButtonsViewInfoClass: TcxGridFilterButtonsViewInfoClass; virtual;

    property Filter: TcxDataFilterCriteria read GetFilter;
    property Filtering: TcxCustomGridTableFiltering read GetFiltering;
  public
    constructor Create(AGridViewInfo: TcxCustomGridTableViewInfo); override;
    destructor Destroy; override;
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); override;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
    property ButtonsViewInfo: TcxGridFilterButtonsViewInfo read FButtonsViewInfo;
  end;

  // cells

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
  public
    constructor Create(ARecordViewInfo: TcxCustomGridRecordViewInfo); reintroduce; virtual;
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); override;
    function CanDrawSelected: Boolean; virtual;
    function MouseDown(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; override;
    property GridRecord: TcxCustomGridRecord read GetGridRecord;
    property GridView: TcxCustomGridTableView read GetGridView;
    property GridViewInfo: TcxCustomGridTableViewInfo read GetGridViewInfo;
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
    function CanActivateEditOnMouseDown(AButton: TMouseButton): Boolean; virtual;
    function CanShowEdit: Boolean; virtual;
    function CanShowHint: Boolean; override;
    procedure CheckEditHotTrack(const AMousePos: TPoint);
    function CustomDraw(ACanvas: TcxCanvas): Boolean; override;
    procedure DoCalculateParams; override;
    procedure EditHotTrackChanged;
    function GetAreaBounds: TRect; override;
    function GetAutoHeight: Boolean; virtual;
    function GetCellBoundsForHint: TRect; override;
    function GetDisplayValue: TcxEditValue; virtual;
    function GetEditBounds: TRect; virtual;
    function GetEditViewDataBounds: TRect; virtual;
    procedure GetEditViewDataContentOffsets(var R: TRect); virtual;
    function GetFocused: Boolean; virtual;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetHotTrack: Boolean; override;
    function GetMaxLineCount: Integer; virtual;
    function GetMultiLine: Boolean; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetShowEndEllipsis: Boolean; override;
    function GetText: string; override;
    function GetValue: Variant; virtual;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function HasCustomDraw: Boolean; override;
    function HasFocusRect: Boolean; virtual;
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
    function SupportsZeroHeight: Boolean; virtual;
    function UseStandardNeedShowHint: Boolean; virtual;

    procedure InitStyle; virtual;

    function CreateEditViewInfo: TcxCustomEditViewInfo;

    procedure CreateEditViewData;
    procedure DestroyEditViewData;
    property EditViewData: TcxCustomEditViewData read FEditViewData;

    procedure UpdateEdit;

    property AutoHeight: Boolean read GetAutoHeight;
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
    function GetInplaceEditPosition: TcxInplaceEditPosition;
    procedure Invalidate(ARecalculate: Boolean); reintroduce; virtual;
    function MouseDown(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; override;
    function MouseMove(AHitTest: TcxCustomGridHitTest; AShift: TShiftState): Boolean; override;
    function MouseUp(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; override;

    property DisplayValue: TcxEditValue read GetDisplayValue;
    //property Edit: TcxCustomEdit read GetEdit;
    property EditBounds: TRect read GetEditBounds;
    property Editing: Boolean read GetEditing;
    property EditViewInfo: TcxCustomEditViewInfo read FEditViewInfo;
    property Focused: Boolean read GetFocused;
    property Item: TcxCustomGridTableItem read FItem;
    property Properties: TcxCustomEditProperties read GetProperties;
    property Style: TcxEditStyle read FStyle;
    property Value: Variant read GetValue;
  end;

  // records

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
    procedure SetExpanded(Value: Boolean);
  protected
    FRecord: TcxCustomGridRecord;
    procedure CalculateExpandButtonBounds(var ABounds: TRect); virtual; abstract;
    function CalculateSelected: Boolean; virtual;
    function CanGenerateExpandButtonHitTest: Boolean; virtual;
    procedure ControlFocusChanged; virtual;
    function GetAutoHeight: Boolean; virtual;
    function GetBackgroundBitmap: TBitmap; override;
    function GetBackgroundBitmapBounds: TRect; virtual;
    function GetCanvas: TcxCanvas; override;
    function GetCellTransparent(ACell: TcxGridTableCellViewInfo): Boolean; virtual;
    function GetContentBounds: TRect; virtual;
    function GetExpandButtonAreaBounds: TRect; virtual;
    function GetFocusRectBounds: TRect; virtual;
    function GetHeight: Integer; override;
    function GetHideFocusRectOnExit: Boolean; virtual;
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
    property Expanded: Boolean read GetExpanded write SetExpanded;
  public
    constructor Create(ARecordsViewInfo: TcxCustomGridRecordsViewInfo;
      ARecord: TcxCustomGridRecord); reintroduce; virtual;
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
    function ProcessDialogChar(ACharCode: Word): Boolean; virtual;
    procedure Recalculate;

    property ContentBounds: TRect read GetContentBounds;
    property ExpandButtonBounds: TRect read FExpandButtonBounds;
    property Focused: Boolean read GetFocused;
    property FocusRectBounds: TRect read GetFocusRectBounds;
    property GridView: TcxCustomGridTableView read GetGridView;
    property GridRecord: TcxCustomGridRecord read FRecord;
    property GridViewInfo: TcxCustomGridTableViewInfo read GetGridViewInfo;
    property Index: Integer read GetIndex;
    property HideFocusRectOnExit: Boolean read GetHideFocusRectOnExit;
    property RecordsViewInfo: TcxCustomGridRecordsViewInfo read FRecordsViewInfo;
    property Selected: Boolean read GetSelected;
  end;

  TcxCustomGridRecordsViewInfoClass = class of TcxCustomGridRecordsViewInfo;

  TcxCustomGridRecordsViewInfo = class
  private
    FBackgroundBitmap: TBitmap;
    FBounds: TRect;
    FContentBounds: TRect;
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
    procedure AfterOffset; virtual;
    procedure BeforeOffset; virtual;
    procedure Calculate; virtual;
    function CalculateBounds: TRect; virtual;
    function CalculateContentBounds: TRect; virtual;
    function CalculateIncSearchingCellViewInfo: TcxGridTableDataCellViewInfo; virtual;
    procedure CalculateVisibleCount; virtual;
    procedure CreateEditViewDatas;
    procedure DestroyEditViewDatas;
    function GetAreaBoundsForCell(ACellViewInfo: TcxGridTableDataCellViewInfo): TRect; virtual;
    function GetAutoDataRecordHeight: Boolean; virtual;
    function GetAutoRecordHeight: Boolean; virtual;
    function GetBackgroundBitmap: TBitmap; virtual;
    function GetItemLeftBound(AIndex: Integer): Integer; virtual; abstract;
    function GetItemsOffset(AItemCountDelta: Integer): Integer; virtual; abstract;
    function GetItemTopBound(AIndex: Integer): Integer; virtual; abstract;
    function GetRecordIndex(AViewInfoIndex: Integer): Integer;
    function GetViewInfoIndex(ARecordIndex: Integer): Integer;
    function IsEmpty: Boolean; virtual;
    procedure OffsetItem(AIndex, AOffset: Integer); virtual; abstract;

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
    function GetRealItem(ARecord: TcxCustomGridRecord): TcxCustomGridRecordViewInfo; virtual;
    procedure MainCalculate; virtual;
    procedure Offset(AItemCountDelta: Integer); overload; virtual;
    procedure Offset(DX, DY: Integer); overload; virtual;
    procedure Paint;

    property AutoDataRecordHeight: Boolean read GetAutoDataRecordHeight;
    property AutoRecordHeight: Boolean read GetAutoRecordHeight;
    property BackgroundBitmap: TBitmap read FBackgroundBitmap write FBackgroundBitmap;
    property Bounds: TRect read FBounds;
    property ContentBounds: TRect read FContentBounds;
    property Count: Integer read GetCount;
    property GridView: TcxCustomGridTableView read GetGridView;
    property Items[Index: Integer]: TcxCustomGridRecordViewInfo read GetItem; default;
    property ItemsOffset: Integer read FItemsOffset;
    property VisibleCount: Integer read FVisibleCount;
  end;

  // view

  TcxNavigatorSiteViewInfoClass = class of TcxNavigatorSiteViewInfo;

  TcxNavigatorSiteViewInfo = class(TcxCustomGridViewCellViewInfo)
  private
    function GetGridViewInfo: TcxCustomGridTableViewInfo;
    function GetNavigatorViewInfo: TcxNavigatorViewInfo;
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetHotTrack: Boolean; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetVisible: Boolean; override;
    procedure MouseLeave; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function GetWidth: Integer; override;
  public
    destructor Destroy; override;
    function MouseDown(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; override;
    function MouseMove(AHitTest: TcxCustomGridHitTest; AShift: TShiftState): Boolean; override;
    function MouseUp(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; override;
    property GridViewInfo: TcxCustomGridTableViewInfo read GetGridViewInfo;
    property NavigatorViewInfo: TcxNavigatorViewInfo read GetNavigatorViewInfo;
  end;

  TcxCustomGridTableViewInfo = class(TcxCustomGridViewInfo, IcxNavigatorOwner)
  private
    FCalculateDown: Boolean;
    FFilterViewInfo: TcxGridFilterViewInfo;
    FFirstRecordIndex: Integer;
    FNavigatorSize: TPoint;
    FNavigatorSiteViewInfo: TcxNavigatorSiteViewInfo;
    FNavigatorViewInfo: TcxNavigatorViewInfo;
    FParts: TList;
    FRecordsViewInfo: TcxCustomGridRecordsViewInfo;

    function GetController: TcxCustomGridTableController;
    function GetExpandButtonSize: Integer;
    function GetFirstRecordIndex: Integer;
    function GetGridView: TcxCustomGridTableView;
    function GetPart(Index: Integer): TcxCustomGridPartViewInfo;
    function GetPartCount: Integer;
    function GetPartsBottomHeight: Integer;
    function GetPartsCustomHeight(AAlignment: TcxGridPartAlignment): Integer;
    function GetPartsTopHeight: Integer;
    function GetScrollableAreaWidth: Integer;
    function GetViewData: TcxCustomGridTableViewData;
    function GetVisibleRecordCount: Integer;

    procedure AddPart(AItem: TcxCustomGridPartViewInfo);
    procedure RemovePart(AItem: TcxCustomGridPartViewInfo);
  protected
    // IcxNavigatorOwner
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
    procedure NavigatorChanged(AChangeType: TcxNavigatorChangeType);
    procedure RefreshNavigator;

    procedure CreateViewInfos; override;
    procedure DestroyViewInfos(AIsRecreating: Boolean); override;

    procedure AfterCalculating; override;
    procedure AfterOffset; virtual;
    procedure BeforeOffset; virtual;
    procedure Calculate; override;
    function CalculateClientBounds: TRect; override;
    function CalculatePartBounds(APart: TcxCustomGridPartViewInfo): TRect; virtual;
    function CalculateVisibleEqualHeightRecordCount: Integer; virtual;
    procedure ControlFocusChanged; override;
    function DoGetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
    function GetDefaultGridModeBufferCount: Integer; virtual;
    procedure GetHScrollBarBounds(var ABounds: TRect); override;
    function GetFilterViewInfoClass: TcxGridFilterViewInfoClass; virtual;
    function GetIsInternalUse: Boolean; override;
    function GetNavigatorOffset: Integer; virtual;
    function GetNavigatorSiteBounds: TRect; virtual;
    function GetNavigatorSiteViewInfoClass: TcxNavigatorSiteViewInfoClass; virtual;
    function GetNavigatorViewInfoClass: TcxNavigatorViewInfoClass; virtual;
    function GetNoDataInfoTextAreaBounds: TRect; virtual;
    procedure GetNoDataInfoTextParams(out AParams: TcxViewParams); virtual;
    function GetNoDataInfoTextAreaVisible: Boolean; virtual;
    function GetNonRecordsAreaHeight(ACheckScrollBar: Boolean): Integer; virtual;
    function GetRecordsViewInfoClass: TcxCustomGridRecordsViewInfoClass; virtual; abstract;
    function GetScrollableAreaBounds: TRect; virtual;
    function GetScrollableAreaBoundsForEdit: TRect; virtual;
    function GetScrollableAreaBoundsHorz: TRect; virtual;
    function GetScrollableAreaBoundsVert: TRect; virtual;
    function FirstRecordIndexAssigned: Boolean;
    procedure Offset(ARecordCountDelta: Integer); overload; virtual;
    procedure Offset(DX, DY: Integer); overload; virtual;
    procedure VisibilityChanged(AVisible: Boolean); override;

    property Controller: TcxCustomGridTableController read GetController;
    property PartCount: Integer read GetPartCount;
    property Parts[Index: Integer]: TcxCustomGridPartViewInfo read GetPart;
    property ViewData: TcxCustomGridTableViewData read GetViewData;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    destructor Destroy; override;
    function CanOffset(ARecordCountDelta, DX, DY: Integer): Boolean; virtual;
    function CanOffsetView(ARecordCountDelta: Integer): Boolean; virtual;
    procedure DoOffset(ARecordCountDelta, DX, DY: Integer); virtual;

    // for extended lookup edit
    function GetNearestPopupHeight(AHeight: Integer; AAdditionalRecord: Boolean = False): Integer; virtual;
    function GetPopupHeight(ADropDownRecordCount: Integer): Integer; virtual;

    property CalculateDown: Boolean read FCalculateDown write FCalculateDown;
    property ExpandButtonSize: Integer read GetExpandButtonSize;
    property FilterViewInfo: TcxGridFilterViewInfo read FFilterViewInfo;
    property FirstRecordIndex: Integer read GetFirstRecordIndex write FFirstRecordIndex;
    property GridView: TcxCustomGridTableView read GetGridView;
    property NavigatorBounds: TRect read GetNavigatorBounds;
    property NavigatorOffset: Integer read GetNavigatorOffset;
    property NavigatorSize: TPoint read FNavigatorSize;
    property NavigatorSiteViewInfo: TcxNavigatorSiteViewInfo read FNavigatorSiteViewInfo;
    property NavigatorViewInfo: TcxNavigatorViewInfo read FNavigatorViewInfo;
    property NoDataInfoTextAreaBounds: TRect read GetNoDataInfoTextAreaBounds;
    property NoDataInfoTextAreaVisible: Boolean read GetNoDataInfoTextAreaVisible;
    property PartsBottomHeight: Integer read GetPartsBottomHeight;
    property PartsTopHeight: Integer read GetPartsTopHeight;
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
    function GetItemClass(Index: Integer): TcxCustomGridViewInfoCacheItemClass; override;
    property ViewData: TcxCustomGridTableViewData read GetViewData;
  end;

  { view }

  // custom item

  TcxGridTableItemChange = (ticProperty, ticLayout, ticSize);

  TcxCustomGridTableItemCustomOptions = class(TPersistent)
  private
    FItem: TcxCustomGridTableItem;
    function GetGridView: TcxCustomGridTableView;
  protected
    procedure Changed(AChange: TcxGridTableItemChange = ticLayout); virtual;
  public
    constructor Create(AItem: TcxCustomGridTableItem); virtual;
    procedure Assign(Source: TPersistent); override;
    property GridView: TcxCustomGridTableView read GetGridView;
    property Item: TcxCustomGridTableItem read FItem;
  end;

  TcxGridItemShowEditButtons = (isebDefault, isebNever, isebAlways);
  TcxGridItemSortByDisplayText = (isbtDefault, isbtOn, isbtOff);

  TcxCustomGridTableItemOptionsClass = class of TcxCustomGridTableItemOptions;

  TcxCustomGridTableItemOptions = class(TcxCustomGridTableItemCustomOptions)
  private
    FEditing: Boolean;
    FFiltering: Boolean;
    FFilteringMRUItemsList: Boolean;
    FFocusing: Boolean;
    FGrouping: Boolean;
    FIncSearch: Boolean;
    FMoving: Boolean;
    FShowEditButtons: TcxGridItemShowEditButtons;
    FSortByDisplayText: TcxGridItemSortByDisplayText;
    FSorting: Boolean;
    procedure SetEditing(Value: Boolean);
    procedure SetFiltering(Value: Boolean);
    procedure SetFilteringMRUItemsList(Value: Boolean);
    procedure SetFocusing(Value: Boolean);
    procedure SetGrouping(Value: Boolean);
    procedure SetIncSearch(Value: Boolean);
    procedure SetMoving(Value: Boolean);
    procedure SetShowEditButtons(Value: TcxGridItemShowEditButtons);
    procedure SetSortByDisplayText(Value: TcxGridItemSortByDisplayText);
    procedure SetSorting(Value: Boolean);
  protected
    property Grouping: Boolean read FGrouping write SetGrouping default True;
    property Moving: Boolean read FMoving write SetMoving default True;
    property SortByDisplayText: TcxGridItemSortByDisplayText read FSortByDisplayText
      write SetSortByDisplayText default isbtDefault;
    property Sorting: Boolean read FSorting write SetSorting default True;
  public
    constructor Create(AItem: TcxCustomGridTableItem); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Editing: Boolean read FEditing write SetEditing default True;
    property Filtering: Boolean read FFiltering write SetFiltering default True;
    property FilteringMRUItemsList: Boolean read FFilteringMRUItemsList
      write SetFilteringMRUItemsList default True;
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
    procedure SetOnGetContentStyle(Value: TcxGridGetCellStyleEvent);
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
    property OnGetContentStyle: TcxGridGetCellStyleEvent read FOnGetContentStyle write SetOnGetContentStyle;
  end;

  TcxGridSortOrder = TcxDataSortOrder;

  TcxGridTableDataCellCustomDrawEvent = procedure(Sender: TcxCustomGridTableView;
    ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean) of object;

  TcxGridGetDataTextEvent = procedure(Sender: TcxCustomGridTableItem;
    ARecordIndex: Integer; var AText: string) of object;
  TcxGridGetDisplayTextEvent = procedure(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string) of object;
  TcxGridGetFilterDisplayTextEvent = procedure(Sender: TcxCustomGridTableItem;
    const AValue: Variant; var ADisplayText: string) of object;
  TcxGridGetFilterValuesEvent = procedure(Sender: TcxCustomGridTableItem;
    AValueList: TcxDataFilterValueList) of object;
  TcxGridGetPropertiesEvent = procedure(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties) of object;
  TcxGridTableItemGetStoredPropertiesEvent = procedure(Sender: TcxCustomGridTableItem;
    AProperties: TStrings) of object;
  TcxGridTableItemGetStoredPropertyValueEvent = procedure(Sender: TcxCustomGridTableItem;
    const AName: string; var AValue: Variant) of object;
  TcxGridTableItemSetStoredPropertyValueEvent = procedure(Sender: TcxCustomGridTableItem;
    const AName: string; const AValue: Variant) of object;
  TcxGridUserFilteringEvent = procedure(Sender: TcxCustomGridTableItem;
    const AValue: Variant; const ADisplayText: string) of object;

  TcxCustomGridTableItemClass = class of TcxCustomGridTableItem;

  TcxCustomGridTableItem = class(TcxComponent, IcxEditRepositoryItemListener, IcxStoredObject)
  private
    FBestFitMaxWidth: Integer;
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
    FHidden: Boolean;
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
    FOnGetDataText: TcxGridGetDataTextEvent;
    FOnGetDisplayText: TcxGridGetDisplayTextEvent;
    FOnGetFilterDisplayText: TcxGridGetFilterDisplayTextEvent;
    FOnGetFilterValues: TcxGridGetFilterValuesEvent;
    FOnGetProperties: TcxGridGetPropertiesEvent;
    FOnGetPropertiesForEdit: TcxGridGetPropertiesEvent;
    FOnGetStoredProperties: TcxGridTableItemGetStoredPropertiesEvent;
    FOnGetStoredPropertyValue: TcxGridTableItemGetStoredPropertyValueEvent;
    FOnSetStoredPropertyValue: TcxGridTableItemSetStoredPropertyValueEvent;
    FOnUserFiltering: TcxGridUserFilteringEvent;
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
    function GetIsLoading: Boolean;
    function GetIncSearching: Boolean;
    function GetIsDestroying: Boolean;
    function GetIsFirst: Boolean;
    function GetIsLast: Boolean;
    function GetIsReading: Boolean;
    function GetIsUpdating: Boolean;
    function GetMinWidth: Integer;
    function GetPropertiesClassName: string;
    function GetSortIndex: Integer;
    function GetSortOrder: TcxGridSortOrder;
    function GetTag: TcxTag;
    function GetViewData: TcxCustomGridTableViewData;
    function GetWidth: Integer;
    procedure SetBestFitMaxWidth(Value: Integer);
    procedure SetCaption(const Value: string);
    procedure SetDataBinding(Value: TcxGridItemDataBinding);
    procedure SetEditing(Value: Boolean);
    procedure SetFiltered(Value: Boolean);
    procedure SetFocused(Value: Boolean);
    procedure SetGroupIndex(Value: Integer);
    procedure SetHeaderAlignmentHorz(Value: TAlignment);
    procedure SetHeaderAlignmentVert(Value: TcxAlignmentVert);
    procedure SetHidden(Value: Boolean);
    procedure SetIndex(Value: Integer);
    procedure SetMinWidth(Value: Integer);
    procedure SetOnCustomDrawCell(Value: TcxGridTableDataCellCustomDrawEvent);
    procedure SetOnGetDataText(Value: TcxGridGetDataTextEvent);
    procedure SetOnGetDisplayText(Value: TcxGridGetDisplayTextEvent);
    procedure SetOnGetFilterDisplayText(Value: TcxGridGetFilterDisplayTextEvent);
    procedure SetOnGetFilterValues(Value: TcxGridGetFilterValuesEvent);
    procedure SetOnGetProperties(Value: TcxGridGetPropertiesEvent);
    procedure SetOnGetPropertiesForEdit(Value: TcxGridGetPropertiesEvent);
    procedure SetOnGetStoredProperties(Value: TcxGridTableItemGetStoredPropertiesEvent);
    procedure SetOnGetStoredPropertyValue(Value: TcxGridTableItemGetStoredPropertyValueEvent);
    procedure SetOnSetStoredPropertyValue(Value: TcxGridTableItemSetStoredPropertyValueEvent);
    procedure SetOnUserFiltering(Value: TcxGridUserFilteringEvent);
    procedure SetOptions(Value: TcxCustomGridTableItemOptions);
    procedure SetProperties(Value: TcxCustomEditProperties);
    procedure SetPropertiesClass(Value: TcxCustomEditPropertiesClass);
    procedure SetPropertiesClassName(const Value: string);
    procedure SetRepositoryItem(Value: TcxEditRepositoryItem);
    procedure SetSortIndex(Value: Integer);
    procedure SetSortOrder(Value: TcxGridSortOrder);
    procedure SetStyles(Value: TcxCustomGridTableItemStyles);
    procedure SetTag(Value: TcxTag);
    procedure SetVisible(Value: Boolean);
    procedure SetWidth(Value: Integer);

    procedure ReadIsCaptionAssigned(Reader: TReader);
    procedure WriteIsCaptionAssigned(Writer: TWriter);

    function IsCaptionStored: Boolean;
    function IsSortOrderStored: Boolean;
    function IsTagStored: Boolean;
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
    procedure IcxEditRepositoryItemListener.PropertiesChanged = RepositoryItemPropertiesChanged;
    procedure RepositoryItemPropertiesChanged(Sender: TcxEditRepositoryItem);
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

    procedure BestFitApplied(AFireEvents: Boolean); virtual;
    function CalculateBestFitWidth: Integer; virtual;
    function CanAutoHeight: Boolean; virtual;
    function CanEdit: Boolean; virtual;
    function CanFilter(ACheckGridViewOptions: Boolean): Boolean; virtual;
    function CanFilterMRUValueItems: Boolean; virtual;
    function CanFocus(ARecord: TcxCustomGridRecord): Boolean; virtual;
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
    procedure ChangeGroupIndex(Value: Integer);
    procedure ChangeSortIndex(Value: Integer);
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
    function GetHidden: Boolean; virtual;
    function GetMultiLine: Boolean; virtual;
    function GetPropertiesForEdit: TcxCustomEditProperties; virtual;
    function GetPropertiesValue: TcxCustomEditProperties;
    function GetVisible: Boolean; virtual;
    function GetVisibleCaption: string; virtual;
    function GetVisibleIndex: Integer;
    function GetVisibleInQuickCustomizationPopup: Boolean; virtual;
    function HasCustomDrawCell: Boolean;
    function HasFixedWidth: Boolean; virtual;
    procedure HiddenChanged; virtual;
    procedure InitProperties(AProperties: TcxCustomEditProperties); virtual;
    function IsHiddenStored: Boolean; virtual;
    function IsSortingByDisplayText(ASortByDisplayText: Boolean): Boolean;
    function IsVisibleStored: Boolean; virtual;
    procedure PropertiesChanged;
    procedure PropertiesChangedHandler(Sender: TObject);
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
    procedure InitStyle(AStyle: TcxCustomEditStyle; const AParams: TcxViewParams;
      AFocused: Boolean); virtual;
    procedure ReleaseCellStyle;

    procedure AddCell(ACell: TcxGridTableDataCellViewInfo);
    procedure RemoveCell(ACell: TcxGridTableDataCellViewInfo);
    property CellCount: Integer read GetCellCount;
    property Cells[Index: Integer]: TcxGridTableDataCellViewInfo read GetCell;

    function CreateEditViewData(AProperties: TcxCustomEditProperties): TcxCustomEditViewData;
    procedure DestroyEditViewData(var AEditViewData: TcxCustomEditViewData);
    procedure DoCreateEditViewData;
    procedure DoDestroyEditViewData;
    procedure EditViewDataGetDisplayTextHandler(Sender: TcxCustomEditViewData; var AText: string);
    function GetEditViewData(AProperties: TcxCustomEditProperties;
      out AIsLocalCopy: Boolean): TcxCustomEditViewData;
    procedure ReleaseEditViewData(var AEditViewData: TcxCustomEditViewData; AIsLocalCopy: Boolean);
    property EditViewData: TcxCustomEditViewData read FEditViewData;

    procedure DoCustomDrawCell(ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean); virtual;
    procedure DoGetDataText(ARecordIndex: Integer; var AText: string); virtual;
    procedure DoGetDisplayText(ARecord: TcxCustomGridRecord; var AText: string); virtual;
    procedure DoGetFilterValues(AValueList: TcxDataFilterValueList); virtual;
    function DoGetProperties(ARecord: TcxCustomGridRecord): TcxCustomEditProperties; virtual;
    procedure DoGetPropertiesForEdit(ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties); virtual;
    procedure DoUserFiltering(const AValue: Variant; const ADisplayText: string); virtual;
    function HasDataTextHandler: Boolean;
    function HasCustomPropertiesForEditHandler: Boolean;
    function HasCustomPropertiesHandler: Boolean;

    property IsDestroying: Boolean read GetIsDestroying;
    property IsLoading: Boolean read GetIsLoading;
    property IsReading: Boolean read GetIsReading;
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
    property Hidden: Boolean read GetHidden write SetHidden stored IsHiddenStored;
    property IgnoreLoadingStatus: Boolean read FIgnoreLoadingStatus write FIgnoreLoadingStatus;
    property InternalVisible: Boolean read FVisible;
    property MinWidth: Integer read GetMinWidth write SetMinWidth
      default cxGridItemDefaultMinWidth;
    property MultiLine: Boolean read GetMultiLine;
    property ViewData: TcxCustomGridTableViewData read GetViewData;
    property VisibleInQuickCustomizationPopup: Boolean read GetVisibleInQuickCustomizationPopup;
    property WasVisibleBeforeGrouping: Boolean read FWasVisibleBeforeGrouping;
    property Width: Integer read GetWidth write SetWidth stored IsWidthStored;

    property OnGetFilterDisplayText: TcxGridGetFilterDisplayTextEvent read FOnGetFilterDisplayText
      write SetOnGetFilterDisplayText;
    property OnGetFilterValues: TcxGridGetFilterValuesEvent read FOnGetFilterValues write SetOnGetFilterValues;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;

    procedure ApplyBestFit(ACheckSizingAbility: Boolean = False; AFireEvents: Boolean = False); virtual;
    function CalculateDefaultCellHeight(ACanvas: TcxCanvas; AFont: TFont): Integer; virtual;
    function CreateEditStyle: TcxEditStyle; virtual;
    procedure FocusWithSelection; virtual;
    function GetDefaultValuesProvider(AProperties: TcxCustomEditProperties = nil): IcxEditDefaultValuesProvider;
    function GetProperties: TcxCustomEditProperties; overload;
    function GetProperties(ARecord: TcxCustomGridRecord): TcxCustomEditProperties; overload;
    function GetRepositoryItem: TcxEditRepositoryItem;
    procedure RestoreDefaults; virtual;

    property ActuallyVisible: Boolean read GetActuallyVisible;
    property BestFitMaxWidth: Integer read FBestFitMaxWidth write SetBestFitMaxWidth default 0;
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
    property SortIndex: Integer read GetSortIndex write SetSortIndex default -1;
    property SortOrder: TcxGridSortOrder read GetSortOrder write SetSortOrder stored IsSortOrderStored;
    property Styles: TcxCustomGridTableItemStyles read FStyles write SetStyles;
    property VisibleCaption: string read GetVisibleCaption;
    property VisibleIndex: Integer read FVisibleIndex;
  published
    property Caption: string read GetCaption write SetCaption stored IsCaptionStored;
    property DataBinding: TcxGridItemDataBinding read FDataBinding write SetDataBinding;
    property PropertiesClassName: string read GetPropertiesClassName write SetPropertiesClassName;
    property Properties: TcxCustomEditProperties read FProperties write SetProperties;
    property RepositoryItem: TcxEditRepositoryItem read FRepositoryItem write SetRepositoryItem;
    property Visible: Boolean read GetVisible write SetVisible stored IsVisibleStored default True;
    property PropertiesEvents: TNotifyEvent read FSubClassEvents write FSubClassEvents;
    property StylesEvents: TNotifyEvent read FSubClassEvents write FSubClassEvents;
    property Tag: TcxTag read GetTag write SetTag stored IsTagStored;
    property OnCustomDrawCell: TcxGridTableDataCellCustomDrawEvent read FOnCustomDrawCell write SetOnCustomDrawCell;
    property OnGetDataText: TcxGridGetDataTextEvent read FOnGetDataText write SetOnGetDataText;
    property OnGetDisplayText: TcxGridGetDisplayTextEvent read FOnGetDisplayText write SetOnGetDisplayText;
    property OnGetProperties: TcxGridGetPropertiesEvent read FOnGetProperties write SetOnGetProperties;
    property OnGetPropertiesForEdit: TcxGridGetPropertiesEvent read FOnGetPropertiesForEdit write SetOnGetPropertiesForEdit;
    property OnGetStoredProperties: TcxGridTableItemGetStoredPropertiesEvent
      read FOnGetStoredProperties write SetOnGetStoredProperties;
    property OnGetStoredPropertyValue: TcxGridTableItemGetStoredPropertyValueEvent
      read FOnGetStoredPropertyValue write SetOnGetStoredPropertyValue;
    property OnSetStoredPropertyValue: TcxGridTableItemSetStoredPropertyValueEvent
      read FOnSetStoredPropertyValue write SetOnSetStoredPropertyValue;
    property OnUserFiltering: TcxGridUserFilteringEvent read FOnUserFiltering write SetOnUserFiltering;
  end;

  // grid view options

  TcxCustomGridTableBackgroundBitmaps = class(TcxCustomGridBackgroundBitmaps)
  protected
    function GetBitmapStyleIndex(Index: Integer): Integer; override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Content: TBitmap index bbContent read GetValue write SetValue;
    property FilterBox: TBitmap index bbFilterBox read GetValue write SetValue;
  end;

  TcxGridFilterMRUItem = class(TcxMRUItem)
  private
    function GetCaption: string;
  protected
    function StreamEquals(AStream: TMemoryStream): Boolean;
  public
    Filter: TcxDataFilterCriteria;
    constructor Create(AFilter: TcxDataFilterCriteria);
    destructor Destroy; override;
    procedure AssignTo(AFilter: TcxDataFilterCriteria);
    function Equals(AItem: TcxMRUItem): Boolean; override;
    function FilterEquals(AFilter: TcxDataFilterCriteria): Boolean;
    function GetStream: TMemoryStream;
    property Caption: string read GetCaption;
  end;

  TcxGridFilterMRUItemsClass = class of TcxGridFilterMRUItems;

  TcxGridFilterMRUItems = class(TcxMRUItems)
  private
    FFiltering: TcxCustomGridTableFiltering;
    FVisibleItems: TList;
    function GetItem(Index: Integer): TcxGridFilterMRUItem;
    function GetVisibleCount: Integer;
    function GetVisibleItem(Index: Integer): TcxGridFilterMRUItem;
  protected
    procedure DeleteEmptyItems;
    procedure FilterChanged;
    procedure RefreshVisibleItemsList;
  public
    constructor Create(AFiltering: TcxCustomGridTableFiltering); reintroduce; virtual;
    destructor Destroy; override;
    procedure Add(AFilter: TcxDataFilterCriteria);
    property Filtering: TcxCustomGridTableFiltering read FFiltering;
    property Items[Index: Integer]: TcxGridFilterMRUItem read GetItem; default;
    property VisibleCount: Integer read GetVisibleCount;
    property VisibleItems[Index: Integer]: TcxGridFilterMRUItem read GetVisibleItem;
  end;

  TcxGridFilterPosition = (fpTop, fpBottom);
  TcxGridFilterVisible = (fvNever, fvNonEmpty, fvAlways);

  TcxGridFilterBoxClass = class of TcxGridFilterBox;

  TcxGridFilterBox = class(TcxCustomGridOptions)
  private
    FCustomizeDialog: Boolean;
    FMRUItemsListDropDownCount: Integer;
    FPosition: TcxGridFilterPosition;
    FVisible: TcxGridFilterVisible;
    procedure SetCustomizeDialog(Value: Boolean);
    procedure SetMRUItemsListDropDownCount(Value: Integer);
    procedure SetPosition(Value: TcxGridFilterPosition);
    procedure SetVisible(Value: TcxGridFilterVisible);
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    procedure Assign(Source: TPersistent); override;
  published
    property CustomizeDialog: Boolean read FCustomizeDialog write SetCustomizeDialog default True;
    property MRUItemsListDropDownCount: Integer read FMRUItemsListDropDownCount
      write SetMRUItemsListDropDownCount default 0;
    property Position: TcxGridFilterPosition read FPosition write SetPosition default fpBottom;
    property Visible: TcxGridFilterVisible read FVisible write SetVisible default fvNonEmpty;
  end;

  TcxCustomGridTableFilteringClass = class of TcxCustomGridTableFiltering;

  TcxCustomGridTableFiltering = class(TcxCustomGridOptions)
  private
    FItemMRUItemsList: Boolean;
    FItemMRUItemsListCount: Integer;
    FItemPopupDropDownWidth: Integer;
    FItemPopupMaxDropDownItemCount: Integer;
    FMRUItems: TcxGridFilterMRUItems;
    FMRUItemsList: Boolean;
    FMRUItemsListCount: Integer;
    function GetCustomizeDialog: Boolean;
    function GetGridView: TcxCustomGridTableView;
    function GetMRUItemsListDropDownCount: Integer;
    function GetPosition: TcxGridFilterPosition;
    function GetVisible: TcxGridFilterVisible;
    procedure SetCustomizeDialog(Value: Boolean);
    procedure SetItemMRUItemsList(Value: Boolean);
    procedure SetItemMRUItemsListCount(Value: Integer);
    procedure SetItemPopupDropDownWidth(Value: Integer);
    procedure SetItemPopupMaxDropDownItemCount(Value: Integer);
    procedure SetMRUItemsList(Value: Boolean);
    procedure SetMRUItemsListCount(Value: Integer);
    procedure SetMRUItemsListDropDownCount(Value: Integer);
    procedure SetPosition(Value: TcxGridFilterPosition);
    procedure SetVisible(Value: TcxGridFilterVisible);
    procedure FilterControlDialogApply(Sender: TObject);
    procedure ReadCustomizeDialog(Reader: TReader);
    procedure ReadDropDownWidth(Reader: TReader);
    procedure ReadMaxDropDownCount(Reader: TReader);
    procedure ReadMRUItemsListDropDownCount(Reader: TReader);
    procedure ReadPosition(Reader: TReader);
    procedure ReadVisible(Reader: TReader);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure FilterChanged; virtual;
    function GetMRUItemsClass: TcxGridFilterMRUItemsClass; virtual;
    function IsMRUItemsListAvailable: Boolean; virtual;
    procedure MRUItemsVisibleCountChanged(AOldCount, ANewCount: Integer); virtual;

    property ItemMRUItemsList: Boolean read FItemMRUItemsList write SetItemMRUItemsList default True;
    property ItemMRUItemsListCount: Integer read FItemMRUItemsListCount write SetItemMRUItemsListCount
      default cxGridFilterDefaultItemMRUItemsListCount;
    property ItemPopupDropDownWidth: Integer read FItemPopupDropDownWidth
      write SetItemPopupDropDownWidth default 0;
    property ItemPopupMaxDropDownItemCount: Integer read FItemPopupMaxDropDownItemCount
      write SetItemPopupMaxDropDownItemCount default cxGridFilterDefaultItemPopupMaxDropDownItemCount;

    // obsolete - use ItemPopupDropDownWidth
    property DropDownWidth: Integer read FItemPopupDropDownWidth write SetItemPopupDropDownWidth;
    // obsolete - use ItemPopupMaxDropDownItemCount
    property MaxDropDownCount: Integer read FItemPopupMaxDropDownItemCount write SetItemPopupMaxDropDownItemCount;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    destructor Destroy; override;
    procedure AddFilterToMRUItems(AFilter: TcxDataFilterCriteria = nil);
    procedure Assign(Source: TPersistent); override;
    procedure RunCustomizeDialog(AItem: TcxCustomGridTableItem = nil);

    property GridView: TcxCustomGridTableView read GetGridView;
    property MRUItems: TcxGridFilterMRUItems read FMRUItems;
    // obsolete - use GridView.FilterBox
    property CustomizeDialog: Boolean read GetCustomizeDialog write SetCustomizeDialog;
    property MRUItemsListDropDownCount: Integer read GetMRUItemsListDropDownCount write SetMRUItemsListDropDownCount;
    property Position: TcxGridFilterPosition read GetPosition write SetPosition;
    property Visible: TcxGridFilterVisible read GetVisible write SetVisible;
  published
    property MRUItemsList: Boolean read FMRUItemsList write SetMRUItemsList default True;
    property MRUItemsListCount: Integer read FMRUItemsListCount write SetMRUItemsListCount
      default cxGridFilterDefaultMRUItemsListCount;
  end;

  TcxGridDragFocusing = (dfNone, dfDragOver, dfDragDrop);

  TcxCustomGridTableOptionsBehavior = class(TcxCustomGridOptionsBehavior)
  private
    FAlwaysShowEditor: Boolean;
    FBestFitMaxRecordCount: Integer;
    FCellHints: Boolean;
    FCopyCaptionsToClipboard: Boolean;
    FDragDropText: Boolean;
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
    procedure SetAlwaysShowEditor(Value: Boolean);
    procedure SetBestFitMaxRecordCount(Value: Integer);
    procedure SetCellHints(Value: Boolean);
    procedure SetCopyCaptionsToClipboard(Value: Boolean);
    procedure SetDragDropText(Value: Boolean);
    procedure SetDragFocusing(Value: TcxGridDragFocusing);
    procedure SetDragHighlighting(Value: Boolean);
    procedure SetDragOpening(Value: Boolean);
    procedure SetDragScrolling(Value: Boolean);
    procedure SetFocusCellOnCycle(Value: Boolean);
    procedure SetFocusCellOnTab(Value: Boolean);
    procedure SetFocusFirstCellOnNewRecord(Value: Boolean);
    procedure SetGoToNextCellOnEnter(Value: Boolean);
    procedure SetImmediateEditor(Value: Boolean);
    procedure SetIncSearch(Value: Boolean);
    procedure SetIncSearchItem(Value: TcxCustomGridTableItem);
    procedure SetNavigatorHints(Value: Boolean);
    procedure SetPullFocusing(Value: Boolean);
  protected
    property FocusCellOnCycle: Boolean read FFocusCellOnCycle write SetFocusCellOnCycle default False;
    property PullFocusing: Boolean read FPullFocusing write SetPullFocusing default False;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    procedure Assign(Source: TPersistent); override;
    property BestFitMaxRecordCount: Integer read FBestFitMaxRecordCount write SetBestFitMaxRecordCount default 0;
    property GridView: TcxCustomGridTableView read GetGridView;
  published
    property AlwaysShowEditor: Boolean read FAlwaysShowEditor write SetAlwaysShowEditor default False;
    property CellHints: Boolean read FCellHints write SetCellHints default False;
    property CopyCaptionsToClipboard: Boolean read FCopyCaptionsToClipboard write SetCopyCaptionsToClipboard default True;
    property DragDropText: Boolean read FDragDropText write SetDragDropText default False;
    property DragFocusing: TcxGridDragFocusing read FDragFocusing write SetDragFocusing default dfNone;
    property DragHighlighting: Boolean read FDragHighlighting write SetDragHighlighting default True;
    property DragOpening: Boolean read FDragOpening write SetDragOpening default True;
    property DragScrolling: Boolean read FDragScrolling write SetDragScrolling default True;
    property FocusCellOnTab: Boolean read FFocusCellOnTab write SetFocusCellOnTab default False;
    property FocusFirstCellOnNewRecord: Boolean read FFocusFirstCellOnNewRecord
      write SetFocusFirstCellOnNewRecord default False;
    property GoToNextCellOnEnter: Boolean read FGoToNextCellOnEnter write SetGoToNextCellOnEnter default False;
    property ImmediateEditor: Boolean read FImmediateEditor write SetImmediateEditor default True;
    property IncSearch: Boolean read FIncSearch write SetIncSearch default False;
    property IncSearchItem: TcxCustomGridTableItem read FIncSearchItem write SetIncSearchItem;
    property NavigatorHints: Boolean read FNavigatorHints write SetNavigatorHints default False;
  end;

  TcxCustomGridTableOptionsCustomizeClass = class of TcxCustomGridTableOptionsCustomize;

  TcxCustomGridTableOptionsCustomize = class(TcxCustomGridOptions)
  private
    FItemFiltering: Boolean;
    FItemGrouping: Boolean;
    FItemHiding: Boolean;
    FItemMoving: Boolean;
    FItemSorting: Boolean;
    FItemsQuickCustomization: Boolean;
    FItemsQuickCustomizationMaxDropDownCount: Integer;
    procedure SetItemFiltering(Value: Boolean);
    procedure SetItemGrouping(Value: Boolean);
    procedure SetItemHiding(Value: Boolean);
    procedure SetItemMoving(Value: Boolean);
    procedure SetItemSorting(Value: Boolean);
    procedure SetItemsQuickCustomization(Value: Boolean);
    procedure SetItemsQuickCustomizationMaxDropDownCount(Value: Integer);
  protected
    property ItemFiltering: Boolean read FItemFiltering write SetItemFiltering default True;
    property ItemGrouping: Boolean read FItemGrouping write SetItemGrouping default True;
    property ItemHiding: Boolean read FItemHiding write SetItemHiding default False;  {2m}
    property ItemMoving: Boolean read FItemMoving write SetItemMoving default True;
    property ItemSorting: Boolean read FItemSorting write SetItemSorting default True;
    property ItemsQuickCustomization: Boolean read FItemsQuickCustomization
      write SetItemsQuickCustomization default False;  {3}
    property ItemsQuickCustomizationMaxDropDownCount: Integer read FItemsQuickCustomizationMaxDropDownCount
      write SetItemsQuickCustomizationMaxDropDownCount default 0;  {3}
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    procedure Assign(Source: TPersistent); override;
  end;

  TcxCustomGridTableOptionsData = class(TcxCustomGridOptionsData)
  private
    FAppending: Boolean;
    FCancelOnExit: Boolean;
    FDeleting: Boolean;
    FDeletingConfirmation: Boolean;
    FEditing: Boolean;
    FInserting: Boolean;
    function GetGridView: TcxCustomGridTableView;
    procedure SetAppending(Value: Boolean);
    procedure SetCancelOnExit(Value: Boolean);
    procedure SetDeleting(Value: Boolean);
    procedure SetDeletingConfirmation(Value: Boolean);
    procedure SetEditing(Value: Boolean);
    procedure SetInserting(Value: Boolean);
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    procedure Assign(Source: TPersistent); override;
    property GridView: TcxCustomGridTableView read GetGridView;
  published
    property Appending: Boolean read FAppending write SetAppending default False;
    property CancelOnExit: Boolean read FCancelOnExit write SetCancelOnExit default True;
    property Deleting: Boolean read FDeleting write SetDeleting default True;
    property DeletingConfirmation: Boolean read FDeletingConfirmation
      write SetDeletingConfirmation default True;
    property Editing: Boolean read FEditing write SetEditing default True;
    property Inserting: Boolean read FInserting write SetInserting default True;
  end;

  TcxCustomGridTableOptionsSelection = class(TcxCustomGridOptionsSelection)
  private
    FCellSelect: Boolean;
    FHideFocusRectOnExit: Boolean;
    FHideSelection: Boolean;
    FInvertSelect: Boolean;
    FUnselectFocusedRecordOnExit: Boolean;
    function GetGridView: TcxCustomGridTableView;
    function GetMultiSelect: Boolean;
    procedure SetHideFocusRectOnExit(Value: Boolean);
    procedure SetHideSelection(Value: Boolean);
    procedure SetUnselectFocusedRecordOnExit(Value: Boolean);
  protected
    function IsInvertSelectStored: Boolean; virtual;
    function IsMultiSelectStored: Boolean; virtual;
    procedure SetCellSelect(Value: Boolean); virtual;
    procedure SetInvertSelect(Value: Boolean); virtual;
    procedure SetMultiSelect(Value: Boolean); virtual;
    property GridView: TcxCustomGridTableView read GetGridView;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    procedure Assign(Source: TPersistent); override;
  published
    property CellSelect: Boolean read FCellSelect write SetCellSelect default True;
    property HideFocusRect: Boolean read FHideFocusRectOnExit write SetHideFocusRectOnExit stored False;  // for compatibility
    property HideFocusRectOnExit: Boolean read FHideFocusRectOnExit write SetHideFocusRectOnExit default True;
    property HideSelection: Boolean read FHideSelection write SetHideSelection default False;
    property InvertSelect: Boolean read FInvertSelect write SetInvertSelect stored IsInvertSelectStored;
    property MultiSelect: Boolean read GetMultiSelect write SetMultiSelect stored IsMultiSelectStored;
    property UnselectFocusedRecordOnExit: Boolean read FUnselectFocusedRecordOnExit
      write SetUnselectFocusedRecordOnExit default True;
  end;

  TcxGridShowEditButtons = (gsebNever, gsebForFocusedRecord, gsebAlways);

  TcxCustomGridTableOptionsView = class(TcxCustomGridOptionsView)
  private
    FCellAutoHeight: Boolean;
    FCellEndEllipsis: Boolean;
    FCellTextMaxLineCount: Integer;
    FFocusRect: Boolean;
    FItemCaptionAutoHeight: Boolean;
    FItemCaptionEndEllipsis: Boolean;
    FNavigator: Boolean;
    FNavigatorOffset: Integer;
    FShowEditButtons: TcxGridShowEditButtons;
    function GetGridView: TcxCustomGridTableView;
    procedure SetCellAutoHeight(Value: Boolean);
    procedure SetCellEndEllipsis(Value: Boolean);
    procedure SetCellTextMaxLineCount(Value: Integer);
    procedure SetFocusRect(Value: Boolean);
    procedure SetItemCaptionAutoHeight(Value: Boolean);
    procedure SetItemCaptionEndEllipsis(Value: Boolean);
    procedure SetNavigator(Value: Boolean);
    procedure SetNavigatorOffset(Value: Integer);
    procedure SetShowEditButtons(Value: TcxGridShowEditButtons);
  protected
    procedure ItemCaptionAutoHeightChanged; dynamic;

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
    property FocusRect: Boolean read FFocusRect write SetFocusRect default True;
    property Navigator: Boolean read FNavigator write SetNavigator default False;
    property NavigatorOffset: Integer read FNavigatorOffset write SetNavigatorOffset default cxGridNavigatorDefaultOffset;
    property ScrollBars;
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
    procedure SetOnGetContentStyle(Value: TcxGridGetCellStyleEvent);
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
    property FilterBox: TcxStyle index vsFilterBox read GetValue write SetValue;
    property Inactive: TcxStyle index vsInactive read GetValue write SetValue;
    property IncSearch: TcxStyle index vsIncSearch read GetValue write SetValue;
    property Selection: TcxStyle index vsSelection read GetValue write SetValue;
    property OnGetContentStyle: TcxGridGetCellStyleEvent read FOnGetContentStyle write SetOnGetContentStyle;
  end;

  // grid view

  TcxGridOpenTableItemList = class(TcxOpenList)
  private
    function GetItem(Index: Integer): TcxCustomGridTableItem;
    procedure SetItem(Index: Integer; Value: TcxCustomGridTableItem);
  public
    property Items[Index: Integer]: TcxCustomGridTableItem read GetItem write SetItem; default;
  end;

  TcxGridTableCellCustomDrawEvent = procedure(Sender: TcxCustomGridTableView;
    ACanvas: TcxCanvas; AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean) of object;

  TcxGridAllowRecordOperationEvent = procedure(Sender: TcxCustomGridTableView;
    ARecord: TcxCustomGridRecord; var AAllow: Boolean) of object;
  TcxGridCellClickEvent = procedure(Sender: TcxCustomGridTableView;
    ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
    AShift: TShiftState; var AHandled: Boolean) of object;
  TcxGridCustomTableViewEvent = procedure(Sender: TcxCustomGridTableView) of object;
  TcxGridEditingEvent = procedure(Sender: TcxCustomGridTableView;
    AItem: TcxCustomGridTableItem; var AAllow: Boolean) of object;
  TcxGridEditKeyEvent = procedure(Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
    AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState) of object;
  TcxGridEditKeyPressEvent = procedure(Sender: TcxCustomGridTableView;
    AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char) of object;
  TcxGridCustomTableItemEvent = procedure(Sender: TcxCustomGridTableView;
    AItem: TcxCustomGridTableItem) of object;
  TcxGridFilterCustomizationEvent = procedure(Sender: TcxCustomGridTableView;
    var ADone: Boolean) of object;
  TcxGridFilterDialogShowEvent = procedure(Sender: TcxCustomGridTableView;
    AItem: TcxCustomGridTableItem; var ADone: Boolean) of object;
  TcxGridFocusedItemChangedEvent = procedure(Sender: TcxCustomGridTableView;
    APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem) of object;
  TcxGridFocusedRecordChangedEvent = procedure(Sender: TcxCustomGridTableView;
    APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean) of object;
  TcxGridGetCellHeightEvent = procedure(Sender: TcxCustomGridTableView;
    ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
    ACellViewInfo: TcxGridTableDataCellViewInfo; var AHeight: Integer) of object;
  TcxGridGetDragDropTextEvent = procedure(Sender: TcxCustomGridTableView;
    ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AText: string) of object;
  TcxGridInitEditEvent = procedure(Sender: TcxCustomGridTableView;
    AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit) of object;
  TcxGridPartCustomDrawBackgroundEvent = procedure(Sender: TcxCustomGridTableView;
    ACanvas: TcxCanvas; AViewInfo: TcxCustomGridCellViewInfo; var ADone: Boolean) of object;
  TcxGridRecordEvent = procedure(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord) of object;

  TcxGridDataControllerChange = (dccItemAdded, dccItemRemoved, dccIndexesChanged);

  TcxCustomGridTableView = class(TcxCustomGridView, IcxFilterControl, IcxNavigator)
  private
    FAssigningGroupedItems: TcxGridOpenTableItemList;
    FAssigningSortedItems: TcxGridOpenTableItemList;
    FCopyToClipboardItems: TList;
    FCopyToClipboardStr: string;
    FDontMakeMasterRecordVisible: Boolean;
    FFilterableItems: TList;
    FFilterBox: TcxGridFilterBox;
    FFiltering: TcxCustomGridTableFiltering;
    FIgnorePropertiesChanges: Boolean;
    FIsAfterAssigningItems: Boolean;
    FIsAssigningItems: Boolean;
    FItems: TList;
    FNavigatorButtons: TcxNavigatorControlButtons;
    FNavigatorNotifier: TcxNavigatorControlNotifier;
    FNextID: Integer;
    FOptionsCustomize: TcxCustomGridTableOptionsCustomize;
    FRestoringItems: TcxGridOpenTableItemList;
    FVisibleItems: TList;
    FOnCanFocusRecord: TcxGridAllowRecordOperationEvent;
    FOnCanSelectRecord: TcxGridAllowRecordOperationEvent;
    FOnCellClick: TcxGridCellClickEvent;
    FOnCellDblClick: TcxGridCellClickEvent;
    FOnCustomDrawCell: TcxGridTableDataCellCustomDrawEvent;
    FOnCustomDrawPartBackground: TcxGridPartCustomDrawBackgroundEvent;
    FOnEditing: TcxGridEditingEvent;
    FOnEditChanged: TcxGridCustomTableItemEvent;
    FOnEditKeyDown: TcxGridEditKeyEvent;
    FOnEditKeyPress: TcxGridEditKeyPressEvent;
    FOnEditKeyUp: TcxGridEditKeyEvent;
    FOnEditValueChanged: TcxGridCustomTableItemEvent;
    FOnFilterControlDialogShow: TNotifyEvent;
    FOnFilterCustomization: TcxGridFilterCustomizationEvent;
    FOnFilterDialogShow: TcxGridFilterDialogShowEvent;
    FOnFocusedItemChanged: TcxGridFocusedItemChangedEvent;
    FOnFocusedRecordChanged: TcxGridFocusedRecordChangedEvent;
    FOnGetCellHeight: TcxGridGetCellHeightEvent;
    FOnGetDragDropText: TcxGridGetDragDropTextEvent;
    FOnInitEdit: TcxGridInitEditEvent;
    //FOnRecordCreated: TcxGridRecordEvent;
    //FOnRecordDestroying: TcxGridRecordEvent;
    FOnSelectionChanged: TcxGridCustomTableViewEvent;
    FOnTopRecordIndexChanged: TNotifyEvent;

    function GetBackgroundBitmaps: TcxCustomGridTableBackgroundBitmaps;
    function GetController: TcxCustomGridTableController;
    function GetFilterableItem(Index: Integer): TcxCustomGridTableItem;
    function GetFilterableItemCount: Integer;
    function GetGroupedItem(Index: Integer): TcxCustomGridTableItem;
    function GetGroupedItemCount: Integer;
    function GetItem(Index: Integer): TcxCustomGridTableItem;
    function GetItemCount: Integer;
    function GetMasterGridRecord: TcxCustomGridRecord;
    function GetOptionsBehavior: TcxCustomGridTableOptionsBehavior;
    function GetOptionsData: TcxCustomGridTableOptionsData;
    function GetOptionsSelection: TcxCustomGridTableOptionsSelection;
    function GetOptionsView: TcxCustomGridTableOptionsView;
    function GetPainter: TcxCustomGridTablePainter;
    function GetPatternGridView: TcxCustomGridTableView;
    function GetNavigatorButtonsControl: IcxNavigator;
    function GetSortedItem(Index: Integer): TcxCustomGridTableItem;
    function GetSortedItemCount: Integer;
    function GetStyles: TcxCustomGridTableViewStyles;
    function GetViewData: TcxCustomGridTableViewData;
    function GetViewInfo: TcxCustomGridTableViewInfo;
    function GetVisibleItem(Index: Integer): TcxCustomGridTableItem;
    function GetVisibleItemCount: Integer;
    procedure SetBackgroundBitmaps(Value: TcxCustomGridTableBackgroundBitmaps);
    procedure SetFilterBox(Value: TcxGridFilterBox);
    procedure SetFiltering(Value: TcxCustomGridTableFiltering);
    procedure SetItem(Index: Integer; Value: TcxCustomGridTableItem);
    procedure SetNavigatorButtons(Value: TcxNavigatorControlButtons);
    procedure SetOnCanFocusRecord(Value: TcxGridAllowRecordOperationEvent);
    procedure SetOnCanSelectRecord(Value: TcxGridAllowRecordOperationEvent);
    procedure SetOnCellClick(Value: TcxGridCellClickEvent);
    procedure SetOnCellDblClick(Value: TcxGridCellClickEvent);
    procedure SetOnCustomDrawCell(Value: TcxGridTableDataCellCustomDrawEvent);
    procedure SetOnCustomDrawPartBackground(Value: TcxGridPartCustomDrawBackgroundEvent);
    procedure SetOnEditChanged(Value: TcxGridCustomTableItemEvent);
    procedure SetOnEditing(Value: TcxGridEditingEvent);
    procedure SetOnEditKeyDown(Value: TcxGridEditKeyEvent);
    procedure SetOnEditKeyPress(Value: TcxGridEditKeyPressEvent);
    procedure SetOnEditKeyUp(Value: TcxGridEditKeyEvent);
    procedure SetOnEditValueChanged(Value: TcxGridCustomTableItemEvent);
    procedure SetOnFilterControlDialogShow(Value: TNotifyEvent);
    procedure SetOnFilterCustomization(Value: TcxGridFilterCustomizationEvent);
    procedure SetOnFilterDialogShow(Value: TcxGridFilterDialogShowEvent);
    procedure SetOnFocusedItemChanged(Value: TcxGridFocusedItemChangedEvent);
    procedure SetOnFocusedRecordChanged(Value: TcxGridFocusedRecordChangedEvent);
    procedure SetOnGetCellHeight(Value: TcxGridGetCellHeightEvent);
    procedure SetOnGetDragDropText(Value: TcxGridGetDragDropTextEvent);
    procedure SetOnInitEdit(Value: TcxGridInitEditEvent);
    procedure SetOnSelectionChanged(Value: TcxGridCustomTableViewEvent);
    procedure SetOnTopRecordIndexChanged(Value: TNotifyEvent);
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
    function GetFilterValueType(Index: Integer): cxDataStorage.TcxValueTypeClass;
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
    function CreateStoredObject(const AObjectName, AClassName: string): TObject; override;
    procedure GetStoredChildren(AChildren: TStringList); override;
    // IcxGridViewLayoutEditorSupport - for design-time layout editor
    procedure AssignLayout(ALayoutView: TcxCustomGridView); override;
    procedure BeforeEditLayout(ALayoutView: TcxCustomGridView); override;
    function HasLayoutCustomizationForm: Boolean; override;

    procedure BeforeRestoring; override;
    procedure AfterRestoring; override;
    procedure ReadState(Reader: TReader); override;
    property RestoringItems: TcxGridOpenTableItemList read FRestoringItems;

    procedure BeginAssignItems;
    procedure DoBeforeAssignItems; virtual;
    procedure DoItemsAssigned; virtual;
    procedure EndAssignItems;
    property AssigningGroupedItems: TcxGridOpenTableItemList read FAssigningGroupedItems;
    property AssigningSortedItems: TcxGridOpenTableItemList read FAssigningSortedItems;
    property IsAssigningItems: Boolean read FIsAssigningItems;
    property IsAfterAssigningItems: Boolean read FIsAfterAssigningItems;

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
    procedure GetItemsListForClipboard(AItems: TList; ACopyAll: Boolean); virtual;
    function GetItemSortByDisplayText(AItemIndex: Integer; ASortByDisplayText: Boolean): Boolean;
    function GetItemValueSource(AItemIndex: Integer): TcxDataEditValueSource;
    procedure GetVisibleItemsList(AItems: TList); virtual;
    function HasCustomDrawCell: Boolean;
    function HasCustomDrawPartBackground: Boolean;
    procedure Init; override;
    function IsDetailVisible(AGridView: TcxCustomGridView): Boolean; override;
    function IsEqualHeightRecords: Boolean; virtual;
    function IsRecordHeightDependsOnData: Boolean; virtual;
    function IsRecordHeightDependsOnFocus: Boolean; virtual;
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
    function DoCellDblClick(ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState): Boolean; virtual;
    function DoEditing(AItem: TcxCustomGridTableItem): Boolean; virtual;
    procedure DoTopRecordIndexChanged; virtual;
    procedure FilterChanged; virtual;
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

    function CalculateDataCellSelected(ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; AUseViewInfo: Boolean;
      ACellViewInfo: TcxGridTableCellViewInfo): Boolean; virtual;
    function DrawDataCellSelected(ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      AUseViewInfo: Boolean = False; ACellViewInfo: TcxGridTableCellViewInfo = nil): Boolean; virtual;
    function DrawRecordActive(ARecord: TcxCustomGridRecord): Boolean; virtual;
    function DrawRecordFocused(ARecord: TcxCustomGridRecord): Boolean; virtual;
    function DrawRecordSelected(ARecord: TcxCustomGridRecord): Boolean; virtual;

    function DoCanFocusRecord(ARecord: TcxCustomGridRecord): Boolean; virtual;
    procedure DoCustomDrawCell(ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean); virtual;
    procedure DoCustomDrawPartBackground(ACanvas: TcxCanvas; AViewInfo: TcxCustomGridCellViewInfo;
      var ADone: Boolean); virtual;
    procedure DoEditChanged(AItem: TcxCustomGridTableItem); virtual;
    procedure DoEditKeyDown(AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit;
      var Key: Word; Shift: TShiftState); virtual;
    procedure DoEditKeyPress(AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit;
      var Key: Char); virtual;
    procedure DoEditKeyUp(AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit;
      var Key: Word; Shift: TShiftState); virtual;
    procedure DoEditValueChanged(AItem: TcxCustomGridTableItem); virtual;
    function DoFilterCustomization: Boolean; virtual;
    function DoFilterDialogShow(AItem: TcxCustomGridTableItem): Boolean; virtual;
    procedure DoFocusedRecordChanged(APrevFocusedRecordIndex, AFocusedRecordIndex: Integer;
      ANewItemRecordFocusingChanged: Boolean); virtual;
    procedure DoGetCellHeight(ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      ACellViewInfo: TcxGridTableDataCellViewInfo; var AHeight: Integer); virtual;
    function DoGetDragDropText(ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem): string; virtual;
    procedure DoInitEdit(AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit); virtual;
    //procedure DoRecordCreated(ARecord: TcxCustomGridRecord); virtual;
    //procedure DoRecordDestroying(ARecord: TcxCustomGridRecord); virtual;
    procedure DoSelectionChanged; virtual;
    function HasCustomProperties: Boolean;
    function IsGetCellHeightAssigned: Boolean;

    function GetControllerClass: TcxCustomGridControllerClass; override;
    function GetPainterClass: TcxCustomGridPainterClass; override;
    function GetViewDataClass: TcxCustomGridViewDataClass; override;
    function GetViewInfoCacheClass: TcxCustomGridViewInfoCacheClass; override;
    function GetViewInfoClass: TcxCustomGridViewInfoClass; override;

    function GetBackgroundBitmapsClass: TcxCustomGridBackgroundBitmapsClass; override;
    function GetFilterBoxClass: TcxGridFilterBoxClass; virtual;
    function GetFilteringClass: TcxCustomGridTableFilteringClass; virtual;
    function GetNavigatorButtonsClass: TcxNavigatorControlButtonsClass; virtual;
    function GetOptionsBehaviorClass: TcxCustomGridOptionsBehaviorClass; override;
    function GetOptionsCustomizeClass: TcxCustomGridTableOptionsCustomizeClass; virtual;
    function GetOptionsDataClass: TcxCustomGridOptionsDataClass; override;
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
    property IgnorePropertiesChanges: Boolean read FIgnorePropertiesChanges write FIgnorePropertiesChanges; 
    property NavigatorNotifier: TcxNavigatorControlNotifier read FNavigatorNotifier;
    property NextID: Integer read FNextID;
    property VisibleItemsList: TList read FVisibleItems;

    property OnFilterControlDialogShow: TNotifyEvent read FOnFilterControlDialogShow
      write SetOnFilterControlDialogShow;
    property OnFilterCustomization: TcxGridFilterCustomizationEvent read FOnFilterCustomization
      write SetOnFilterCustomization;
    property OnFilterDialogShow: TcxGridFilterDialogShowEvent read FOnFilterDialogShow
      write SetOnFilterDialogShow;
  public
    destructor Destroy; override;

    procedure ApplyBestFit(AItem: TcxCustomGridTableItem = nil; ACheckSizingAbility: Boolean = False;
      AFireEvents: Boolean = False); virtual;
    procedure ClearItems;
    procedure CopyToClipboard(ACopyAll: Boolean);
    function CreateItem: TcxCustomGridTableItem;
    function FindItemByID(AID: Integer): TcxCustomGridTableItem;
    function FindItemByName(const AName: string): TcxCustomGridTableItem;
    function FindItemByTag(ATag: TcxTag): TcxCustomGridTableItem;
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
    property OptionsBehavior: TcxCustomGridTableOptionsBehavior read GetOptionsBehavior
      write SetOptionsBehavior;
    property OptionsCustomize: TcxCustomGridTableOptionsCustomize read FOptionsCustomize
      write SetOptionsCustomize;
    property OptionsData: TcxCustomGridTableOptionsData read GetOptionsData write SetOptionsData;
    property OptionsSelection: TcxCustomGridTableOptionsSelection read GetOptionsSelection
      write SetOptionsSelection;
    property OptionsView: TcxCustomGridTableOptionsView read GetOptionsView write SetOptionsView;
    property Painter: TcxCustomGridTablePainter read GetPainter;
    property PatternGridView: TcxCustomGridTableView read GetPatternGridView;
    property SortedItemCount: Integer read GetSortedItemCount;
    property SortedItems[Index: Integer]: TcxCustomGridTableItem read GetSortedItem;
    property Styles: TcxCustomGridTableViewStyles read GetStyles write SetStyles;
    property ViewData: TcxCustomGridTableViewData read GetViewData;
    property ViewInfo: TcxCustomGridTableViewInfo read GetViewInfo;
    property VisibleItemCount: Integer read GetVisibleItemCount;
    property VisibleItems[Index: Integer]: TcxCustomGridTableItem read GetVisibleItem;
  published
    property NavigatorButtons: TcxNavigatorControlButtons read FNavigatorButtons write SetNavigatorButtons;
    property FilterBox: TcxGridFilterBox read FFilterBox write SetFilterBox;

    property NavigatorButtonsEvents: TNotifyEvent read FSubClassEvents write FSubClassEvents;
    property OnCanFocusRecord: TcxGridAllowRecordOperationEvent read FOnCanFocusRecord write SetOnCanFocusRecord;
    property OnCanSelectRecord: TcxGridAllowRecordOperationEvent read FOnCanSelectRecord write SetOnCanSelectRecord;
    property OnCellClick: TcxGridCellClickEvent read FOnCellClick write SetOnCellClick;
    property OnCellDblClick: TcxGridCellClickEvent read FOnCellDblClick write SetOnCellDblClick;
    property OnCustomDrawCell: TcxGridTableDataCellCustomDrawEvent read FOnCustomDrawCell write SetOnCustomDrawCell;
    property OnCustomDrawPartBackground: TcxGridPartCustomDrawBackgroundEvent
      read FOnCustomDrawPartBackground write SetOnCustomDrawPartBackground;
    property OnEditing: TcxGridEditingEvent read FOnEditing write SetOnEditing;
    property OnEditChanged: TcxGridCustomTableItemEvent read FOnEditChanged write SetOnEditChanged;
    property OnEditKeyDown: TcxGridEditKeyEvent read FOnEditKeyDown write SetOnEditKeyDown;
    property OnEditKeyPress: TcxGridEditKeyPressEvent read FOnEditKeyPress write SetOnEditKeyPress;
    property OnEditKeyUp: TcxGridEditKeyEvent read FOnEditKeyUp write SetOnEditKeyUp;
    property OnEditValueChanged: TcxGridCustomTableItemEvent read FOnEditValueChanged write SetOnEditValueChanged;
    property OnFocusedItemChanged: TcxGridFocusedItemChangedEvent read FOnFocusedItemChanged
      write SetOnFocusedItemChanged;
    property OnFocusedRecordChanged: TcxGridFocusedRecordChangedEvent read FOnFocusedRecordChanged
      write SetOnFocusedRecordChanged;
    property OnGetCellHeight: TcxGridGetCellHeightEvent read FOnGetCellHeight write SetOnGetCellHeight;
    property OnGetDragDropText: TcxGridGetDragDropTextEvent read FOnGetDragDropText write SetOnGetDragDropText;
    property OnInitEdit: TcxGridInitEditEvent read FOnInitEdit write SetOnInitEdit;
    property OnInitStoredObject;
    //property OnRecordCreated: TcxGridRecordEvent read FOnRecordCreated write FOnRecordCreated;
    //property OnRecordDestroying: TcxGridRecordEvent read FOnRecordDestroying write FOnRecordDestroying;
    property OnSelectionChanged: TcxGridCustomTableViewEvent read FOnSelectionChanged write SetOnSelectionChanged;
    property OnTopRecordIndexChanged: TNotifyEvent read FOnTopRecordIndexChanged write SetOnTopRecordIndexChanged;
  end;

  { TcxCustomGridTableControllerAccess }

  TcxCustomGridTableControllerAccess = class
  public
    class procedure FocusNextPage(AInstance: TcxCustomGridTableController;
      ASyncSelection: Boolean);
    class procedure FocusPrevPage(AInstance: TcxCustomGridTableController;
      ASyncSelection: Boolean);
  end;

  { TcxCustomGridTableItemAccess }

  TcxCustomGridTableItemAccess = class
  public
    class function CanGroup(AInstance: TcxCustomGridTableItem): Boolean;
    class function CanHide(AInstance: TcxCustomGridTableItem): Boolean;
    class function CanHorzSize(AInstance: TcxCustomGridTableItem): Boolean;
    class function CanSort(AInstance: TcxCustomGridTableItem): Boolean;
    class procedure CheckWidthValue(AInstance: TcxCustomGridTableItem;
      var Value: Integer);
    class procedure DoGetDataText(AInstance: TcxCustomGridTableItem;
      ARecordIndex: Integer; var AText: string);
    class procedure DoGetDisplayText(AInstance: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    class function GetGroupIndex(AInstance: TcxCustomGridTableItem): Integer;

    class function GetFilterCaption(AInstance: TcxCustomGridTableItem): string;
  end;

  { TcxCustomGridTableOptionsBehaviorAccess }

  TcxCustomGridTableOptionsBehaviorAccess = class
  public
    class function GetPullFocusing(
      AInstance: TcxCustomGridTableOptionsBehavior): Boolean;
    class procedure SetPullFocusing(
      AInstance: TcxCustomGridTableOptionsBehavior; Value: Boolean);
  end;

  { TcxCustomGridTableOptionsViewAccess }

  TcxCustomGridTableOptionsViewAccess = class
  public
    class function GetCellAutoHeight(AInstance: TcxCustomGridTableOptionsView): Boolean;
  end;

  { TcxCustomGridTableViewAccess }

  TcxCustomGridTableViewAccess = class
  public
    class function CanSelectRecord(AInstance: TcxCustomGridTableView;
      ARecordIndex: Integer): Boolean;
    class procedure FilterChanged(AInstance: TcxCustomGridTableView);
    class procedure FocusEdit(AInstance: TcxCustomGridTableView;
      AItemIndex: Integer; var ADone: Boolean);
    class function GetDefaultActiveDetailIndex(
      AInstance: TcxCustomGridTableView): Integer;
    class function GetDisplayText(AInstance: TcxCustomGridTableView;
      ARecordIndex, AItemIndex: Integer; out AText: string): Boolean;
    class function GetItemSortByDisplayText(AInstance: TcxCustomGridTableView;
      AItemIndex: Integer; ASortByDisplayText: Boolean): Boolean;
    class function GetItemValueSource(AInstance: TcxCustomGridTableView;
      AItemIndex: Integer): TcxDataEditValueSource;
    class function GetSummaryGroupItemLinkClass(
      AInstance: TcxCustomGridTableView): TcxDataSummaryGroupItemLinkClass;
    class function GetSummaryItemClass(
      AInstance: TcxCustomGridTableView): TcxDataSummaryItemClass;
    class function IsEqualHeightRecords(
      AInstance: TcxCustomGridTableView): Boolean;
    class function IsGetCellHeightAssigned(
      AInstance: TcxCustomGridTableView): Boolean;
    class procedure ItemValueTypeClassChanged(AInstance: TcxCustomGridTableView;
      AItemIndex: Integer);
    class procedure RefreshNavigators(AInstance: TcxCustomGridTableView);
    class procedure UpdateRecord(AInstance: TcxCustomGridTableView);
  end;

  { TcxCustomGridTableViewInfoAccess }

  TcxCustomGridTableViewInfoAccess = class
  public
    class function GetDefaultGridModeBufferCount(
      AInstance: TcxCustomGridTableViewInfo): Integer;
  end;

implementation

uses
  Math, SysUtils, TypInfo, Clipbrd, cxScrollBar, cxVariants, cxLibraryConsts,
  cxTextEdit, cxEditUtils, cxFilterDialog, cxFilterControlDialog,
  cxEditDataRegisteredRepositoryItems, cxFilterConsts,
  cxGrid, cxGridStrs, cxGridLevel, cxGridDetailsSite, dxCore;

const
  RecordIndexNone = -1;
  EditStartChars = [#8, ^V, ^X, #32..#255];
  IncSearchStartChars = [#8, #32..#255];
  PullFocusingScrollingTimeInterval = 50;
  // Copy to text format
  EndOfLine = #13#10;
  ColumnSeparator = #9;

  FilterButtonsFirstOffset = 4;
  FilterButtonsOffset = 4;
  FilterTextOffset = 3;

  DragDropTextAreaOffset = 25;
  DragDropTextBorderSize = 3;
  DragDropTextIndent = DragDropTextBorderSize + cxGridCellTextOffset;

  ScrollTimeInterval = 35;

  FilterMRUItemBaseName = 'FilterMRUItem';

type
  TControlAccess = class(TControl);
  TcxControlAccess = class(TcxControl);
  TcxCustomGridAccess = class(TcxCustomGrid);
  TcxCustomGridViewAccess = class(TcxCustomGridView);
  TcxGridLevelAccess = class(TcxGridLevel);

function cxCustomGridTableControllerCanFocusItem(AOwner: TcxCustomGridTableView;
  AItemIndex: Integer; AData: TObject): Boolean;
begin
  Result := AOwner.VisibleItems[AItemIndex].CanFocus(TcxCustomGridRecord(AData));
end;

function cxCustomGridTableControllerCanFocusRecord(
  AOwner: TcxCustomGridTableView; AItemIndex: Integer;
  AData: TObject): Boolean;
begin
  Result := AOwner.ViewData.Records[AItemIndex].CanFocus;
end;

function cxCustomGridTableViewGetItem(ACaller: TComponent;
  Index: Integer): TComponent;
begin
  Result := TcxCustomGridTableView(ACaller).Items[Index];
end;

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
  Result := GridView.ViewInfo.RecordsViewInfo.GetRealItem(FRecord);
end;

procedure TcxGridRecordChange.Execute;
begin
  if (RecordViewInfo = nil) or (FItem <> nil) and not IsItemVisible or
    not GridView.Changeable then Exit;
  RecordViewInfo.Recalculate;
  GridView.ViewChanged(RecordViewInfo.GetBoundsForInvalidate(FItem));
end;

function TcxGridRecordChange.IsCompatibleWith(AChange: TcxCustomGridChange): Boolean;
begin
  Result := inherited IsCompatibleWith(AChange) or
    ((AChange is TcxGridLayoutChange) or (AChange is TcxGridSizeChange) or (AChange is TcxGridDataChange)) and
    (TcxCustomGridViewChange(AChange).GridView <> nil) and (TcxCustomGridViewChange(AChange).GridView = GridView);
end;

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

function TcxGridFocusedRecordChange.CanExecuteWhenLocked: Boolean;
begin
  Result := False;
end;

procedure TcxGridFocusedRecordChange.Execute;
begin
  with GridView as TcxCustomGridTableView do
    //if Changeable then - should work with Visible = False (to show details)
    begin
      if DataController.IsGridMode then Controller.UpdateScrollBars;
      if (FFocusedRecordIndex <> FPrevFocusedRecordIndex) or FNewItemRecordFocusingChanged then
        Controller.MakeFocusedRecordVisible;
      if IsRecordHeightDependsOnFocus then
        SizeChanged
      else
        with ViewData do
        begin
          if IsRecordIndexValid(FPrevFocusedRecordIndex) then
            Records[FPrevFocusedRecordIndex].Invalidate;
          if IsRecordIndexValid(FFocusedRecordIndex) then
            Records[FFocusedRecordIndex].Invalidate;
          if FNewItemRecordFocusingChanged and HasNewItemRecord then
            NewItemRecord.Invalidate;
        end;
      Controller.CheckEdit;
      Controller.EditingController.UpdateEditValue;
      DoFocusedRecordChanged(FPrevFocusedRecordIndex, FFocusedRecordIndex,
        FNewItemRecordFocusingChanged);  // see 23172
    end;
end;

{ TcxGridFilterHitTest }

class function TcxGridFilterHitTest.GetHitTestCode: Integer;
begin
  Result := htFilter;
end;

{ TcxGridFilterCloseButtonHitTest }

class function TcxGridFilterCloseButtonHitTest.GetHitTestCode: Integer;
begin
  Result := htFilterCloseButton;
end;

{ TcxGridFilterActivateButtonHitTest }

class function TcxGridFilterActivateButtonHitTest.GetHitTestCode: Integer;
begin
  Result := htFilterActivateButton;
end;

{ TcxGridFilterDropDownButtonHitTest }

class function TcxGridFilterDropDownButtonHitTest.GetHitTestCode: Integer;
begin
  Result := htFilterDropDownButton;
end;

{ TcxGridFilterCustomizeButtonHitTest }

class function TcxGridFilterCustomizeButtonHitTest.GetHitTestCode: Integer;
begin
  Result := htFilterCustomizeButton;
end;

{ TcxGridRecordHitTest }

function TcxGridRecordHitTest.GetGridRecord: TcxCustomGridRecord;
begin
  if FViewData = nil then
    Result := nil
  else
    Result := FViewData.GetRecordByKind(FGridRecordKind, FGridRecordIndex);
end;

procedure TcxGridRecordHitTest.SetGridRecord(Value: TcxCustomGridRecord);
begin
  if Value <> nil then
  begin
    FViewData := Value.ViewData;
    FGridRecordIndex := Value.Index;
    FGridRecordKind := FViewData.GetRecordKind(Value);
  end
  else
  begin
    FViewData := nil;
    FGridRecordIndex := -1;
    FGridRecordKind := rkNone;
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

{ TcxGridDefaultValuesProvider }

function TcxGridDefaultValuesProvider.IsDisplayFormatDefined(AIsCurrencyValueAccepted: Boolean): Boolean;
begin
  Result := TcxGridItemDataBinding(Owner).IsDisplayFormatDefined(AIsCurrencyValueAccepted);
end;

{ TcxGridDataController }

function TcxGridDataController.GetGridViewValue: TcxCustomGridTableView;
begin
  Result := TcxCustomGridTableView(GetGridView);
end;

procedure TcxGridDataController.ReadData(Stream: TStream);
var
  ASize: Integer;
begin
  Stream.Read(ASize, SizeOf(ASize));
  FLoadedData := TMemoryStream.Create;
  FLoadedData.CopyFrom(Stream, ASize);
  FLoadedData.Position := 0;
end;

procedure TcxGridDataController.WriteData(Stream: TStream);
var
  AStream: TMemoryStream;
  ASize: Integer;
begin
  AStream := TMemoryStream.Create;
  try
    SaveToStream(AStream);
    ASize := AStream.Size;
    Stream.Write(ASize, SizeOf(ASize));
    AStream.SaveToStream(Stream);
  finally
    AStream.Free;
  end;
end;

procedure TcxGridDataController.AssignData(ADataController: TcxCustomDataController);
var
  AStream: TMemoryStream;
begin
  AStream := TMemoryStream.Create;
  try
    ADataController.SaveToStream(AStream);
    AStream.Position := 0;
    LoadFromStream(AStream);
  finally
    AStream.Free;
  end;
end;

procedure TcxGridDataController.CreateAllItems;
begin
end;

procedure TcxGridDataController.DeleteAllItems;
begin
end;

procedure TcxGridDataController.GetFakeComponentLinks(AList: TList);
begin
end;

function TcxGridDataController.GetGridView: TcxCustomGridView;
begin
  Result := TcxCustomGridView(GetOwner);
end;

function TcxGridDataController.IsDataChangeable: Boolean;
begin
  Result := True;
end;

function TcxGridDataController.IsDataLinked: Boolean;
begin
  Result := True;
end;

function TcxGridDataController.SupportsCreateAllItems: Boolean;
begin
  Result := False;
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

{function TcxGridDataController.GetFilterPropertyValue(const AName: string;
  var AValue: Variant): Boolean;
begin
  Result := False;
end;}

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

{function TcxGridDataController.SetFilterPropertyValue(const AName: string;
  const AValue: Variant): Boolean;
begin
  Result := False;
end;}

function TcxGridDataController.SetScrollBarPos(Value: Integer): Boolean;
begin
  Result := False;
end;

function TcxGridDataController.CanSelectRow(ARowIndex: Integer): Boolean;
begin
  Result := GridView.CanSelectRecord(ARowIndex);
end;

procedure TcxGridDataController.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineBinaryProperty('Data', ReadData, WriteData, RecordCount <> 0);
end;

procedure TcxGridDataController.DoValueTypeClassChanged(AItemIndex: Integer);
begin
  inherited;
  GridView.ItemValueTypeClassChanged(AItemIndex);
end;

procedure TcxGridDataController.FilterChanged;
begin
  inherited;
  GridView.FilterChanged;
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
  GridView.Items[AItemIndex].DoGetDataText(ARecordIndex, Result);
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
  Result := GridView.GetItemSortByDisplayText(AItemIndex, ASortByDisplayText);
end;

function TcxGridDataController.GetItemValueSource(AItemIndex: Integer): TcxDataEditValueSource;
begin
  Result := GridView.GetItemValueSource(AItemIndex);
end;

procedure TcxGridDataController.Loaded;
begin
  inherited;
  if FLoadedData <> nil then
    try
      LoadFromStream(FLoadedData);
    finally
      FLoadedData.Free;
    end;
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

{ TcxGridFilterMRUValueItem }

constructor TcxGridFilterMRUValueItem.Create(const AValue: Variant; const ADisplayText: string);
begin
  inherited Create;
  Value := AValue;
  DisplayText := ADisplayText;
end;

function TcxGridFilterMRUValueItem.Equals(AItem: TcxMRUItem): Boolean;
begin
  Result := VarCompare(Value, TcxGridFilterMRUValueItem(AItem).Value) = 0;
end;

{ TcxGridFilterMRUValueItems }

function TcxGridFilterMRUValueItems.GetItem(Index: Integer): TcxGridFilterMRUValueItem;
begin
  Result := TcxGridFilterMRUValueItem(inherited Items[Index]);
end;

procedure TcxGridFilterMRUValueItems.Add(const AValue: Variant; const ADisplayText: string);
begin
  inherited Add(TcxGridFilterMRUValueItem.Create(AValue, ADisplayText));
end;

procedure TcxGridFilterMRUValueItems.AddItemsTo(AValueList: TcxDataFilterValueList);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    with Items[I] do
      AValueList.Add(fviMRU, Value, DisplayText, True);
end;

{ TcxGridItemDataBinding  }

constructor TcxGridItemDataBinding.Create(AItem: TcxCustomGridTableItem);
begin
  inherited Create;
  FItem := AItem;
  FDefaultValuesProvider := GetDefaultValuesProviderClass.Create(Self);
  FFilterMRUValueItems := GetFilterMRUValueItemsClass.Create;
  FFilterMRUValueItems.MaxCount := GridView.Filtering.ItemMRUItemsListCount;
end;

destructor TcxGridItemDataBinding.Destroy;
begin
  FFilterMRUValueItems.Free;
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

function TcxGridItemDataBinding.GetValueType: string;
begin
  if ValueTypeClass = nil then
    Result := ''
  else
    Result := ValueTypeClass.Caption;
end;

function TcxGridItemDataBinding.GetValueTypeClass: TcxValueTypeClass;
begin
  Result := DataController.GetItemValueTypeClass(FItem.Index);
end;

procedure TcxGridItemDataBinding.SetData(Value: TObject);
begin
  if FData <> Value then
  begin
    FData := Value;
    FItem.Changed(ticProperty);
  end;
end;

procedure TcxGridItemDataBinding.SetFiltered(Value: Boolean);
begin
  if Filtered <> Value then
    if not Value then
      Filter.RemoveItemByItemLink(FItem);
end;

procedure TcxGridItemDataBinding.SetValueType(const Value: string);
begin
  if ValueType <> Value then
    ValueTypeClass := cxValueTypeClassList.ItemByCaption(Value);
end;

procedure TcxGridItemDataBinding.SetValueTypeClass(Value: TcxValueTypeClass);
begin
  DataController.ChangeValueTypeClass(FItem.Index, Value);
end;

function TcxGridItemDataBinding.GetDefaultValuesProviderClass: TcxCustomEditDefaultValuesProviderClass;
var
  AIcxGridDataController: IcxGridDataController;
begin
  if Supports(TObject(DataController), IcxGridDataController, AIcxGridDataController) then
    Result := AIcxGridDataController.GetItemDefaultValuesProviderClass
  else
    Result := nil;
end;

function TcxGridItemDataBinding.GetDefaultValueTypeClass: TcxValueTypeClass;
begin
  Result := TcxStringValueType;
end;

function TcxGridItemDataBinding.GetFilterFieldName: string;
begin
  Result := '';
end;

function TcxGridItemDataBinding.GetFilterMRUValueItemsClass: TcxGridFilterMRUValueItemsClass;
begin
  Result := TcxGridFilterMRUValueItems;
end;

procedure TcxGridItemDataBinding.Init;
begin
end;

function TcxGridItemDataBinding.IsValueTypeStored: Boolean;
begin
  Result := ValueTypeClass <> GetDefaultValueTypeClass;
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

function TcxGridItemDataBinding.IsDisplayFormatDefined(AIsCurrencyValueAccepted: Boolean): Boolean;
begin
  Result :=
    DataController.IsDisplayFormatDefined(FItem.Index, not AIsCurrencyValueAccepted) or
    FItem.HasDataTextHandler;
end;

function TcxGridItemDataBinding.AddToFilter(AParent: TcxFilterCriteriaItemList;
  AOperatorKind: TcxFilterOperatorKind; const AValue: Variant; const ADisplayText: string;
  AReplaceExistent: Boolean): TcxFilterCriteriaItem;
begin
  Result := TcxGridDataController(GridView.DataController).AddItemToFilter(
    AParent, FItem, AOperatorKind, AValue, ADisplayText, AReplaceExistent);
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
  GetFilterValues(AValueList, False, True);
  AStrings.BeginUpdate;
  try
    AStrings.Clear;
    for I := 0 to AValueList.Count - 1 do
    begin
      S := AValueList[I].DisplayText;
      GetFilterDisplayText(AValueList[I].Value, S);
      AStrings.AddObject(S, TObject(AValueList[I]));
    end;
  finally
    AStrings.EndUpdate;
  end;
end;

procedure TcxGridItemDataBinding.GetFilterValues(AValueList: TcxDataFilterValueList;
  AValuesOnly: Boolean = True; AInitSortByDisplayText: Boolean = False);
var
  I: Integer;
begin
  AValueList.Load(FItem.Index, AInitSortByDisplayText);
  FItem.DoGetFilterValues(AValueList);
  if AValuesOnly then
    for I := AValueList.Count - 1 downto 0 do
      if AValueList[I].Kind <> fviValue then
        AValueList.Delete(I)
      else
  else
    if FItem.CanFilterMRUValueItems then
      FFilterMRUValueItems.AddItemsTo(AValueList);
end;

{ TcxCustomGridRecord }

constructor TcxCustomGridRecord.Create(AViewData: TcxCustomGridTableViewData;
  AIndex: Integer; const ARecordInfo: TcxRowInfo);
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

function TcxCustomGridRecord.GetLastParentRecordCount: Integer;
begin
  if Level = 0 then
    Result := 0
  else
    for Result := 0 to Level - 1 do
      if not IsParentRecordLast[Result] then Break;
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
    if Focused then
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

procedure TcxCustomGridRecord.DoCollapse(ARecurse: Boolean);
begin
end;

procedure TcxCustomGridRecord.DoExpand(ARecurse: Boolean);
begin
end;

{function TcxCustomGridRecord.GetDestroyingOnExpanding: Boolean;
begin
  Result := False;
end;}

function TcxCustomGridRecord.GetExpandable: Boolean;
begin
  Result := False;
end;

function TcxCustomGridRecord.GetExpanded: Boolean;
begin
  Result := False;
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
    Result := Controller.NewItemRecordFocused
  else
    Result := Controller.IsRecordSelected(Self);
end;

function TcxCustomGridRecord.GetVisible: Boolean;
begin
  Result := IsNewItemRecord or PartVisible and
    FViewData.ViewInfo.RecordsViewInfo.GetRealItem(Self).Visible;
end;

procedure TcxCustomGridRecord.SetSelected(Value: Boolean);
begin
  if IsNewItemRecord then
    Controller.NewItemRecordFocused := Value
  else
    Controller.ChangeRecordSelection(Self, Value);
end;

function TcxCustomGridRecord.GetDisplayText(Index: Integer): string;
begin  
  Result := DataController.GetRowDisplayText(RecordInfo, Index);
end;

function TcxCustomGridRecord.GetValueCount: Integer;
begin
  Result := DataController.GetItemCount;
end;

function TcxCustomGridRecord.GetValue(Index: Integer): Variant;
begin
  Result := DataController.GetRowValue(RecordInfo, Index);
end;

procedure TcxCustomGridRecord.SetDisplayText(Index: Integer; const Value: string);
begin
  DataController.SetDisplayText(RecordIndex, Index, Value);
end;

procedure TcxCustomGridRecord.SetValue(Index: Integer; const Value: Variant);
begin
  DataController.SetValue(RecordIndex, Index, Value);
end;

function TcxCustomGridRecord.CanFocus: Boolean;
begin
  Result := GridView.DoCanFocusRecord(Self); //!!!
end;

function TcxCustomGridRecord.CanFocusCells: Boolean;
begin
  Result := GridView.OptionsSelection.CellSelect;
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
  if PartVisible then
    GridView.Changed(TcxGridRecordChange.Create(GridView, Self, Index, AItem));
end;

procedure TcxCustomGridRecord.KeyDown(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ADD:
      if Expandable then
      begin
        EatKeyPress := True;
        Expanded := True;
        Key := 0;
      end;
    VK_SUBTRACT:
      if Expandable then
      begin
        EatKeyPress := True;
        Expanded := False;
        Key := 0;
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
  if ((Key) in EditStartChars) and
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

function TcxCustomGridTableViewData.GetRecordByKind(AKind, AIndex: Integer): TcxCustomGridRecord;
begin
  case AKind of
    rkNormal:
      if (0 <= AIndex) and (AIndex < RecordCount) then
        Result := Records[AIndex]
      else  
        Result := nil;
    rkNewItem:
      Result := NewItemRecord;
  else
    Result := nil;
  end;
end;

function TcxCustomGridTableViewData.GetRecordKind(ARecord: TcxCustomGridRecord): Integer;
begin
  if ARecord.IsNewItemRecord then
    Result := rkNewItem
  else
    Result := rkNormal;
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

function TcxCustomGridTableViewData.GetNewItemRecordClass: TcxCustomGridRecordClass;
begin
  Result := nil;
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
  BeginUpdate;
  try
    for I := RecordCount - 1 downto 0 do
      Records[I].Collapse(ARecurse);
  finally
    EndUpdate;
  end;
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
  BeginUpdate;
  try
    for I := 0 to RecordCount - 1 do
      Records[I].Expand(ARecurse);
  finally
    EndUpdate;
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
var
  I: Integer;
begin
  if HasNewItemRecord and (ARecordIndex = DataController.NewItemRecordIndex) then
    Result := FNewItemRecord
  else
    if (0 <= ARecordIndex) and (ARecordIndex < DataController.RecordCount) then
    begin
      // following loop was created because during sorting
      // row order in data controller is new already, but it is old in view data
      // (used in TcxCustomGridTableView.GetDisplayText)
      if GridView.IsUpdateLocked or not DataController.IsRowInfoValid then
        for I := 0 to RecordCount - 1 do
        begin
          Result := InternalRecords[I];
          if (Result <> nil) and Result.IsData and (Result.RecordIndex = ARecordIndex) then
            Exit;
        end;
      Result := GetRecordByIndex(DataController.GetRowIndexByRecordIndex(ARecordIndex, False));
    end
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

{ TcxCustomGridTableMovingObject }

function TcxCustomGridTableMovingObject.GetController: TcxCustomGridTableController;
begin
  Result := TcxCustomGridTableController(inherited Controller);
end;

function TcxCustomGridTableMovingObject.GetCustomizationForm: TcxCustomGridTableCustomizationForm;
begin
  Result := TcxCustomGridTableCustomizationForm(inherited CustomizationForm);
end;

procedure TcxCustomGridTableMovingObject.DragAndDrop(const P: TPoint; var Accepted: Boolean);
begin
  inherited;
  Controller.CheckScrolling(P);
end;

{ TcxGridItemContainerZone }

constructor TcxGridItemContainerZone.Create(AItemIndex: Integer);
begin
  inherited Create;
  ItemIndex := AItemIndex;
end;

function TcxGridItemContainerZone.IsEqual(Value: TcxGridItemContainerZone): Boolean;
begin
  Result := (Value <> nil) and (ItemIndex = Value.ItemIndex);
end;

{ TcxCustomGridTableItemMovingObject }

constructor TcxCustomGridTableItemMovingObject.Create(AControl: TcxControl);
begin
  inherited;
  FDestItemContainerKind := ckNone;
end;

destructor TcxCustomGridTableItemMovingObject.Destroy;
begin
  DestZone := nil;
  inherited;
end;

procedure TcxCustomGridTableItemMovingObject.SetDestItemContainerKind(Value: TcxGridItemContainerKind);
begin
  if FDestItemContainerKind <> Value then
  begin
    Dirty := True;
    FDestItemContainerKind := Value;
  end;
end;

procedure TcxCustomGridTableItemMovingObject.SetDestZone(Value: TcxGridItemContainerZone);
begin
  if (FDestZone <> Value) and
    ((FDestZone = nil) or not FDestZone.IsEqual(Value) or
     (Value = nil) or not Value.IsEqual(FDestZone)) then
  begin
    Dirty := True;
    FDestZone.Free;
    FDestZone := Value;
  end
  else
    Value.Free;
end;

procedure TcxCustomGridTableItemMovingObject.CalculateDestParams(AHitTest: TcxCustomGridHitTest;
  out AContainerKind: TcxGridItemContainerKind; out AZone: TcxGridItemContainerZone);
begin
  if AHitTest.HitTestCode = htCustomizationForm then
    AContainerKind := ckCustomizationForm
  else
    AContainerKind := ckNone;
  AZone := nil;
end;

procedure TcxCustomGridTableItemMovingObject.CheckDestParams;
begin
  if (SourceItemContainerKind <> ckCustomizationForm) and
    (DestItemContainerKind = ckCustomizationForm) and not CanRemove then
    DestItemContainerKind := ckNone;
end;

function TcxCustomGridTableItemMovingObject.GetCustomizationFormListBox: TcxCustomGridItemsListBox;
begin
  Result := CustomizationForm.ItemsListBox;
end;

function TcxCustomGridTableItemMovingObject.IsSourceCustomizationForm: Boolean;
begin
  Result := FSourceItemContainerKind = ckCustomizationForm;
end;

procedure TcxCustomGridTableItemMovingObject.BeginDragAndDrop;
begin
  if CustomizationForm <> nil then
    with CustomizationForm do
      ActivatePage(ItemsPage);
  Controller.FMovingItem := SourceItem as TcxCustomGridTableItem;
  inherited;
end;

procedure TcxCustomGridTableItemMovingObject.DragAndDrop(const P: TPoint; var Accepted: Boolean);
var
  AHitTest: TcxCustomGridHitTest;
  ADestContainerKind: TcxGridItemContainerKind;
  ADestZone: TcxGridItemContainerZone;
begin
  AHitTest := ViewInfo.GetHitTest(P);
  CalculateDestParams(AHitTest, ADestContainerKind, ADestZone);
  DestItemContainerKind := ADestContainerKind;
  DestZone := ADestZone;
  FOriginalDestItemContainerKind := FDestItemContainerKind;
  CheckDestParams;
  Accepted := FDestItemContainerKind <> ckNone;
  inherited;
end;

procedure TcxCustomGridTableItemMovingObject.EndDragAndDrop(Accepted: Boolean);
begin
  inherited;
  Controller.FMovingItem := nil;
end;

{ TcxCustomGridTableItemsListBox }

function TcxCustomGridTableItemsListBox.GetGridView: TcxCustomGridTableView;
begin
  Result := TcxCustomGridTableView(inherited GridView);
end;

procedure TcxCustomGridTableItemsListBox.RefreshItemsAsTableItems;
var
  I: Integer;
  AItem: TcxCustomGridTableItem;
begin
  inherited;
  with Items do
  begin
    BeginUpdate;
    try
      Clear;
      for I := 0 to GridView.ItemCount - 1 do
      begin
        AItem := GridView.Items[I];
        if AItem.CanMove and not AItem.Hidden and not AItem.Visible then
          AddObject(AItem.VisibleCaption, AItem);
      end;
    finally
      EndUpdate;
    end;
  end;
end;

{ TcxCustomGridTableCustomizationForm }

procedure TcxCustomGridTableCustomizationForm.CreateControls;
begin
  inherited;
  FItemsListBox := GetItemsListBoxClass.Create(Self);
  with FItemsListBox do
  begin
    Align := alClient;
    Parent := FItemsPage;
    RefreshItems;
  end;
end;

function TcxCustomGridTableCustomizationForm.GetItemsListBoxClass: TcxCustomGridTableItemsListBoxClass;
begin
  Result := TcxCustomGridTableItemsListBox;
end;

function TcxCustomGridTableCustomizationForm.GetItemsPageVisible: Boolean;
begin
  Result := TcxCustomGridTableView(GridView).OptionsCustomize.ItemMoving;
end;

procedure TcxCustomGridTableCustomizationForm.InitPageControl;
begin
  inherited;
  FItemsPage := CreatePage(GetItemsPageCaption, GetItemsPageVisible);
end;

procedure TcxCustomGridTableCustomizationForm.RefreshData;
begin
  inherited;
  FItemsListBox.RefreshItems;
end;

{ TcxGridFilterPopupListBox }

function TcxGridFilterPopupListBox.GetPopup: TcxGridFilterPopup;
begin
  Result := TcxGridFilterPopup(inherited Popup);
end;

procedure TcxGridFilterPopupListBox.DrawItemContent(ACanvas: TcxCanvas;
  AIndex: Integer; ARect: TRect; AState: TOwnerDrawState);

  procedure DrawMRUItemsListSeparator;
  var
    Y: Integer;
  begin
    with ACanvas do
    begin
      Pen.Color := clBtnShadow;
      with ARect do
      begin
        Y := (Top + Bottom - 3) div 2;
        MoveTo(Left, Y);
        LineTo(Right, Y);
        MoveTo(Left, Y + 2);
        LineTo(Right, Y + 2);
      end;
    end;
  end;

begin
  if Popup.IsMRUItemsListSeparatorItem(AIndex) then
    DrawMRUItemsListSeparator
  else
    inherited;
end;

{ TcxGridFilterPopup }

constructor TcxGridFilterPopup.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  AlignHorz := pahRight;
  FListBoxItems := TStringList.Create;
  FValueList := Filter.CreateValueList;
  FListBox := TcxGridFilterPopupListBox.Create(Self);
  FListBox.OnAction := ListBoxAction;
end;

destructor TcxGridFilterPopup.Destroy;
begin
  FValueList.Free;
  FListBoxItems.Free;
  inherited;
end;

function TcxGridFilterPopup.GetFilter: TcxDataFilterCriteria;
begin
  Result := GridView.DataController.Filter;
end;

function TcxGridFilterPopup.GetGridView: TcxCustomGridTableView;
begin
  Result := TcxCustomGridTableView(inherited GridView);
end;

{function TcxGridFilterPopup.GetOwnerValue: IcxGridFilterPopupOwner;
begin
  Result := IcxGridFilterPopupOwner(inherited Owner);
end;

procedure TcxGridFilterPopup.SetOwnerValue(Value: IcxGridFilterPopupOwner);
begin
  inherited Owner := Value;
end;}

procedure TcxGridFilterPopup.ListBoxAction(Sender: TcxGridPopupListBox; AItemIndex: Integer);
begin
  ApplyFilter(AItemIndex);
end;

procedure TcxGridFilterPopup.AddListBoxItems;
begin
  Item.DataBinding.GetFilterStrings(FListBoxItems, FValueList);
end;

procedure TcxGridFilterPopup.AdjustListBoxSize;
begin
  FListBox.VisibleItemCount := GridView.Filtering.ItemPopupMaxDropDownItemCount;
  FListBox.VisibleWidth := GridView.Filtering.ItemPopupDropDownWidth;
  FListBox.AdjustBounds(FListBoxItems);
end;

procedure TcxGridFilterPopup.ApplyFilter(AItemIndex: Integer);
begin
  if AItemIndex <> -1 then
  begin
    Filter.BeginUpdate;
    try
      with FValueList[AItemIndex]^ do
      begin
        if not (Kind in [fviAll, fviCustom]) then
          Filter.Active := True;
        case Kind of
          fviAll:
            Item.Filtered := False;
          fviCustom:
            GridView.Filtering.RunCustomizeDialog(Item);
          fviBlanks:
            Item.DataBinding.AddToFilter(nil, foEqual, Value,
              cxGetResourceString(@cxSFilterBlankCaption));
          fviNonBlanks:
            Item.DataBinding.AddToFilter(nil, foNotEqual, Value,
              cxGetResourceString(@cxSFilterBlankCaption));
          fviUser:
            Item.DoUserFiltering(Value, DisplayText);
          fviValue, fviMRU:
            begin
              Item.DataBinding.AddToFilter(nil, foEqual, Value, DisplayText);
              Item.DataBinding.FilterMRUValueItems.Add(Value, DisplayText);
            end;
        end;
      end;
    finally
      Filter.EndUpdate;
    end;
  end;
  if not (FValueList[AItemIndex].Kind in [fviCustom, fviUser]) then
    GridView.Filtering.AddFilterToMRUItems;
end;

function TcxGridFilterPopup.GetSelectedItemIndex: Integer;
begin
  Result := FValueList.GetIndexByCriteriaItem(Item.DataBinding.FilterCriteriaItem);
end;

procedure TcxGridFilterPopup.InitPopup;
begin
  FItem := (Owner as IcxGridFilterPopupOwner).GetItem;
  ShowHourglassCursor;
  try
    inherited;
    AddListBoxItems;
    AdjustListBoxSize;
    FListBox.Items := FListBoxItems;
    FListBox.ItemIndex := SelectedItemIndex;
  finally
    HideHourglassCursor;
  end;
end;

function TcxGridFilterPopup.IsMRUItemsListSeparatorItem(AIndex: Integer): Boolean;
begin
  Result := FValueList[AIndex].Kind = fviMRUSeparator;
end;

procedure TcxGridFilterPopup.CloseUp;
begin
  inherited;
  FListBox.Clear;
end;

{ TcxGridFilterMRUItemsPopup }

constructor TcxGridFilterMRUItemsPopup.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FListBox := TcxGridPopupListBox.Create(Self);
  FListBox.OnAction := ListBoxAction;
end;

function TcxGridFilterMRUItemsPopup.GetFiltering: TcxCustomGridTableFiltering;
begin
  Result := GridView.Filtering;
end;

function TcxGridFilterMRUItemsPopup.GetGridView: TcxCustomGridTableView;
begin
  Result := TcxCustomGridTableView(inherited GridView);
end;

procedure TcxGridFilterMRUItemsPopup.ListBoxAction(Sender: TcxGridPopupListBox;
  AItemIndex: Integer);
begin
  ApplyFilterMRUItem(AItemIndex);
end;

procedure TcxGridFilterMRUItemsPopup.AddFilterMRUItems(AStrings: TStrings);
var
  I: Integer;
  AItem: TcxGridFilterMRUItem;
begin
  AStrings.BeginUpdate;
  try
    AStrings.Clear;
    for I := 0 to Filtering.MRUItems.VisibleCount - 1 do
    begin
      AItem := Filtering.MRUItems.VisibleItems[I];
      AStrings.AddObject(AItem.Caption, AItem);
    end;
  finally
    AStrings.EndUpdate;
  end;
end;

procedure TcxGridFilterMRUItemsPopup.ApplyFilterMRUItem(AItemIndex: Integer);
begin
  TcxGridFilterMRUItem(FListBox.Items.Objects[AItemIndex]).AssignTo(GridView.DataController.Filter);
  Filtering.AddFilterToMRUItems;
end;

function TcxGridFilterMRUItemsPopup.GetTextOffsetHorz: Integer;
begin
  Result := FListBox.ItemTextOffsetLeft;
end;

procedure TcxGridFilterMRUItemsPopup.InitPopup;
begin
  inherited;
  FListBox.ItemTextOffsetVert := 2;
  FListBox.VisibleItemCount := GridView.FilterBox.MRUItemsListDropDownCount;
  AddFilterMRUItems(FListBox.Items);
  FListBox.AdjustBounds;
end;

{ TcxCustomGridCustomizationPopup }

constructor TcxCustomGridCustomizationPopup.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  CreateCheckListBox;
end;

function TcxCustomGridCustomizationPopup.GetGridView: TcxCustomGridTableView;
begin
  Result := TcxCustomGridTableView(inherited GridView);
end;

procedure TcxCustomGridCustomizationPopup.CheckListBoxCheckClick(Sender: TObject;
  AIndex: Integer; APrevState, ANewState: TcxCheckBoxState);
begin
  CheckClicked(AIndex, ANewState = cbsChecked);
end;

procedure TcxCustomGridCustomizationPopup.CheckListBoxKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE:
      CloseUp;
  end;
end;

procedure TcxCustomGridCustomizationPopup.AdjustCheckListBoxSize;
var
  ADropDownCount: Integer;

  function CalculateClientWidth: Integer;
  begin
    Result := FCheckListBox.GetBestFitWidth;
    if FCheckListBox.Items.Count > ADropDownCount then
      Inc(Result, GetScrollBarSize.cx);
  end;

  function CalculateClientHeight: Integer;
  begin
    Result := FCheckListBox.GetHeight(ADropDownCount);
  end;

begin
  with FCheckListBox do
  begin
    ADropDownCount := GetDropDownCount;
    if (ADropDownCount = 0) or (Items.Count < ADropDownCount) then
      ADropDownCount := Items.Count;
    ClientWidth := CalculateClientWidth;
    ClientHeight := CalculateClientHeight;
  end;
end;

procedure TcxCustomGridCustomizationPopup.CheckClicked(AIndex: Integer; AChecked: Boolean);
begin
  ItemClicked(CheckListBox.Items[AIndex].ItemObject, AChecked);
end;

procedure TcxCustomGridCustomizationPopup.CreateCheckListBox;
begin
  FCheckListBox := TcxCheckListBox.Create(Self);
  with FCheckListBox do
  begin
    EditValueFormat := cvfIndices;
    with Style do
    begin
      LookAndFeel.MasterLookAndFeel := GridView.LookAndFeel;
      BorderStyle := cbsNone;
      HotTrack := False;
      TransparentBorder := False;
    end;
    StyleFocused.BorderStyle := cbsNone;
    StyleHot.BorderStyle := cbsNone;
    ParentFont := True;
    Parent := Self;
    OnClickCheck := CheckListBoxCheckClick;
    OnKeyDown := CheckListBoxKeyDown;
  end;
end;

procedure TcxCustomGridCustomizationPopup.InitPopup;
begin
  inherited;
  with FCheckListBox do
    Canvas.Font := Font;
  AddCheckListBoxItems;
  AdjustCheckListBoxSize;
end;

procedure TcxCustomGridCustomizationPopup.CloseUp;
begin
  inherited;
  FCheckListBox.Clear;
end;

{ TcxCustomGridItemsCustomizationPopup }

procedure TcxCustomGridItemsCustomizationPopup.AddCheckListBoxItems;
var
  I: Integer;
  AItem: TcxCustomGridTableItem;
begin
  with CheckListBox.Items do
  begin
    BeginUpdate;
    try
      for I := 0 to GridView.ItemCount - 1 do
      begin
        AItem := GridView.Items[I];
        if AItem.VisibleInQuickCustomizationPopup then
          with Add do
          begin
            Checked := AItem.Visible;
            ItemObject := AItem;
            Text := AItem.Caption;
          end;
      end;
    finally
      EndUpdate;
    end;
  end;
end;

function TcxCustomGridItemsCustomizationPopup.GetDropDownCount: Integer;
begin
  Result := GridView.OptionsCustomize.ItemsQuickCustomizationMaxDropDownCount;
end;

procedure TcxCustomGridItemsCustomizationPopup.ItemClicked(AItem: TObject; AChecked: Boolean);
begin
  TcxCustomGridTableItem(AItem).Visible := AChecked;
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
    Result := FEditingItem.GetPropertiesForEdit;
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
        Value.FocusWithSelection;
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

function TcxGridEditingController.CanInitEditing: Boolean;
begin
  Result := EditingItem.CanInitEditing;
end;

function TcxGridEditingController.CanRemoveEditFocus: Boolean;
begin
  Result := not (IsEditing and FEdit.IsFocused and not FEditHiding);
end;

function TcxGridEditingController.CanUpdateEditValue: Boolean;
begin
  Result := not GridView.IsPattern and
    IsEditing and not FEditHiding and not FInitiatingEditing and not FEdit.IsPosting;
end;

procedure TcxGridEditingController.CheckEdit;
begin
  if IsEditing and (FEditingItem.FocusedCellViewInfo = nil) then
    HideEdit(False)
  else
    ShowEdit;
end;

procedure TcxGridEditingController.CheckEditUpdatePost;
begin
  if FEditUpdateNeeded then DoUpdateEdit;
end;

procedure TcxGridEditingController.DoEditChanged;
begin
end;

procedure TcxGridEditingController.DoEditKeyDown(var Key: Word; Shift: TShiftState);
var
  AModified: Boolean;
begin
  GridView.DoEditKeyDown(FEditingItem, FEdit, Key, Shift);
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
        AModified := FEdit.EditModified;
        HideEdit(False);
        Controller.CheckEdit;
        if AModified then Key := 0;
      end;
    VK_DELETE:
      if Shift = [ssCtrl] then
        Controller.DoKeyDown(Key, Shift);
  end;
end;

procedure TcxGridEditingController.DoUpdateEdit;
begin
  CancelEditUpdatePost;
  if (FEditingItem <> nil) and (FEditingItem.FocusedCellViewInfo <> nil) and
    not FEditingItem.EditPartVisible then
  begin
    with FEditingItem.FocusedCellViewInfo do
    begin
      if IsRectEmpty(Bounds) then Exit;
      FEdit.BoundsRect := EditBounds;
      InitStyle;
      FEdit.Style := Style;
    end;
    GridView.DoInitEdit(FEditingItem, FEdit);
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
      (FEditingItem.HasCustomPropertiesHandler or FEditingItem.HasCustomPropertiesForEditHandler or
       FEditingItem.ShowButtons(False) or
       (esoAlwaysHotTrack in FEditingItem.GetProperties.GetSupportedOperations)) or
    Assigned(GridView.OnEditing) or Assigned(GridView.OnInitEdit);
end;

procedure TcxGridEditingController.InitEdit;
begin
  with FEdit.InternalProperties do
  begin
    FPrevEditOnChange := OnChange;
    FPrevEditOnEditValueChanged := OnEditValueChanged;
    OnChange := nil;
    OnEditValueChanged := nil;
  end;
  FEdit.InplaceParams.Position := FEditingItem.FocusedCellViewInfo.GetInplaceEditPosition;
  FEdit.Parent := FController.Site;
  UpdateEdit;
  UpdateEditValue;
  AssignEditEvents;
  //GridView.DoInitEdit(FEditingItem, FEdit);
end;

procedure TcxGridEditingController.UninitEdit;
begin
  UnassignEditEvents;
end;

procedure TcxGridEditingController.PostEditingData;
begin
  GridView.DataController.PostEditingData;
end;

procedure TcxGridEditingController.PostEditUpdate;
begin
  FEditUpdateNeeded := True;
end;

function TcxGridEditingController.PrepareEdit(AItem: TcxCustomGridTableItem;
  AOnMouseEvent: Boolean): Boolean;
var
  AProperties: TcxCustomEditProperties;
  AAssignRepositoryItem: Boolean;
begin
  Result := False;
  try
    FController.CancelCheckEditPost;
    if FEditPreparing or FEditHiding or
      (AItem = nil) or (Controller.FocusedRecord = nil) then Exit;
    FEditPreparing := True;
    try
      if AItem.Editing and not FEditingItemSetting then
      begin
        Result := (FEdit <> nil) and
          (FController.Site.Focused and not FEdit.IsFocused or AOnMouseEvent);
        if Result then
          FEditingItem.FocusedCellViewInfo.Invalidate(True);
        Exit;
      end;
      Result := FController.Site.Focused;
      if not Result then Exit;

      AItem.Editing := True;
      Result := AItem.Editing;
      if not Result then Exit;

      Result := not AItem.EditPartVisible;
      if not Result then
      begin
        AItem.Editing := False;
        Exit;
      end;

      try
        AProperties := EditingProperties;
        if (AItem.Properties <> nil) and (AItem.RepositoryItem <> nil) and
          (AProperties = AItem.RepositoryItem.Properties) then
        begin
          AProperties := AItem.Properties;
          AAssignRepositoryItem := True;
        end
        else
          AAssignRepositoryItem := False;

        GridView.PatternGridView.IgnorePropertiesChanges := True;
        try
          FEdit := FEditList.GetEdit(AProperties);
          if AAssignRepositoryItem then
            FEdit.RepositoryItem := AItem.RepositoryItem;
        finally
          GridView.PatternGridView.IgnorePropertiesChanges := False;
        end;
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
  if CanUpdateEditValue then
  begin
    FEdit.LockChangeEvents(True);
    try
      FEdit.EditValue := EditingItem.EditValue;
    finally
      FEdit.LockChangeEvents(False, False);
    end;
    FEdit.SelectAll;
  end;
end;

procedure TcxGridEditingController.UpdateValue;
begin
  if IsEditing and FEdit.EditModified then
  begin
    FEdit.ValidateEdit(True);
    FEditingItem.EditValue := FEdit.EditValue;
    if FEdit <> nil then
      FEdit.ModifiedAfterEnter := False;
  end;
end;

procedure TcxGridEditingController.AssignEditEvents;
begin
  with FEdit do
  begin
    OnAfterKeyDown := EditAfterKeyDown;
    OnEditing := EditEditing;
    OnPostEditValue := EditPostEditValue;
    OnExit := EditExit;
    OnFocusChanged := EditFocusChanged;
    OnKeyDown := EditKeyDown;
    OnKeyPress := EditKeyPress;
    OnKeyUp := EditKeyUp;
    InternalProperties.OnChange := EditChanged;
    InternalProperties.OnEditValueChanged := EditValueChanged;
  end;
end;

procedure TcxGridEditingController.UnassignEditEvents;
begin
  with FEdit do
  begin
    OnAfterKeyDown := nil;
    OnEditing := nil;
    OnPostEditValue := nil;
    OnExit := nil;
    OnFocusChanged := nil;
    OnKeyDown := nil;
    OnKeyPress := nil;
    OnKeyUp := nil;
    InternalProperties.OnChange := FPrevEditOnChange;
    InternalProperties.OnEditValueChanged := FPrevEditOnEditValueChanged;
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
  DoEditChanged;
  if Assigned(FPrevEditOnChange) then FPrevEditOnChange(Sender);
  GridView.DoEditChanged(FEditingItem);
end;

procedure TcxGridEditingController.EditEditing(Sender: TObject; var CanEdit: Boolean);
begin
  FInitiatingEditing := True;
  try
    CanEdit := CanInitEditing;
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
  TcxControlAccess(FController.Site).FocusChanged;
end;

procedure TcxGridEditingController.EditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not (Key in [VK_CONTROL, VK_SHIFT, VK_MENU]) then
    FController.MakeFocusedItemVisible;
  DoEditKeyDown(Key, Shift);
end;

procedure TcxGridEditingController.EditKeyPress(Sender: TObject; var Key: Char);
begin
  GridView.DoEditKeyPress(FEditingItem, FEdit, Key);
end;

procedure TcxGridEditingController.EditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  GridView.DoEditKeyUp(FEditingItem, FEdit, Key, Shift);
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
var
  APrevAllowCheckEdit: Boolean;
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
      PostEditingData;
      FEdit.ActiveProperties.Update(FEditingItem.GetProperties(Controller.FocusedRecord));
    end;
    EditingItem := nil;
    if GridView.Focused then GridView.TabStop := True;
    if FEdit <> nil then
    begin
      UninitEdit;
      if FEdit.Focused and GridView.Focused then
      begin
        FEdit.EditModified := False;
        if not GridView.IsDestroying then
        begin
          APrevAllowCheckEdit := FController.AllowCheckEdit;
          FController.AllowCheckEdit := False;
          try
            FController.DoSetFocus(False);
          finally
            FController.AllowCheckEdit := APrevAllowCheckEdit;
          end;
        end;
      end
      else
        Controller.InvalidateFocusedRecord;
      FEdit.Parent := nil;
      FEdit.RepositoryItem := nil;
      FEdit := nil;
    end;
    FIsErrorOnEditExit := False;
  finally
    FEditHiding := False;
  end;
end;

procedure TcxGridEditingController.RemoveEdit(AProperties: TcxCustomEditProperties);
begin
  //if EditingProperties = AProperties then
  if IsEditing and (Edit = FEditList.FindEdit(AProperties)) then
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
  FEditShowingTimer := TcxTimer.Create(nil);
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
  FFilterPopup.Free;
  FFilterMRUItemsPopup.Free;
  FItemsCustomizationPopup.Free;
  CancelGridModeBufferCountUpdate;
  FreeAndNil(FEditingController);
  inherited;
end;

function TcxCustomGridTableController.GetEditingItem: TcxCustomGridTableItem;
begin
  Result := FEditingController.EditingItem;
end;

function TcxCustomGridTableController.GetFilterMRUItemsPopup: TcxGridFilterMRUItemsPopup;
begin
  if FFilterMRUItemsPopup = nil then
    FFilterMRUItemsPopup := GetFilterMRUItemsPopupClass.Create(GridView);
  Result := FFilterMRUItemsPopup;
end;

function TcxCustomGridTableController.GetFilterPopup: TcxGridFilterPopup;
begin
  if FFilterPopup = nil then
    FFilterPopup := GetFilterPopupClass.Create(GridView);
  Result := FFilterPopup;
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

function TcxCustomGridTableController.GetIsItemMoving: Boolean;
begin
  Result := FMovingItem <> nil;
end;

function TcxCustomGridTableController.GetItemsCustomizationPopup: TcxCustomGridItemsCustomizationPopup;
begin
  if FItemsCustomizationPopup = nil then
    FItemsCustomizationPopup := GetItemsCustomizationPopupClass.Create(GridView);
  Result := FItemsCustomizationPopup;
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

function TcxCustomGridTableController.GetNewItemRecordFocused: Boolean;
begin
  Result := DataController.NewItemRowFocused;
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
  if (Value <> nil) and not Value.CanFocus(FocusedRecord) then Exit;
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

    ARecordCountDelta := Value - FTopRecordIndex;
    FTopRecordIndex := Value;
    ViewInfo.AllowCheckCoordinates := False;
    try
      if Value <> -1 then
        if GridView.CanOffset(ARecordCountDelta) then
          GridView.Offset(ARecordCountDelta, 0, 0)
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

procedure TcxCustomGridTableController.SetNewItemRecordFocused(Value: Boolean);
begin
  DataController.NewItemRowFocused := Value;
end;

procedure TcxCustomGridTableController.SetScrollDirection(Value: TcxDirection);
begin
  if FScrollDirection <> Value then
  begin
    DestroyScrollTimer;
    FScrollDirection := Value;
    if FScrollDirection <> dirNone then
      CreateScrollTimer;
  end;
end;

procedure TcxCustomGridTableController.SetTopRecordIndex(Value: Integer);
begin
  CheckTopRecordIndex(Value);
  InternalTopRecordIndex := Value;
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

procedure TcxCustomGridTableController.PullFocusingScrollingTimerHandler(Sender: TObject);
begin
  DoPullFocusingScrolling(FPullFocusingScrollingDirection);
  Site.Update;
  SavePullFocusingPos;
end;

procedure TcxCustomGridTableController.CreateScrollTimer;
begin
  FScrollTimer := TcxTimer.Create(nil);
  with FScrollTimer do
  begin
    Interval := GetScrollDataTimeInterval(FScrollDirection);
    OnTimer := ScrollTimerHandler;
  end;
end;

procedure TcxCustomGridTableController.DestroyScrollTimer;
begin
  FreeAndNil(FScrollTimer);
end;

procedure TcxCustomGridTableController.ScrollTimerHandler(Sender: TObject);
var
  AAccepted: Boolean;
begin
  if CanScrollData(FScrollDirection) then
  begin
    if DragAndDropObject <> nil then
      DragAndDropObject.BeforeScrolling;
    ScrollData(FScrollDirection);
    if DragAndDropObject <> nil then
    begin
      Site.Update;
      DragAndDropObject.AfterScrolling;
      TcxControlAccess(Site).DragAndDrop(
        Site.ScreenToClient(Mouse.CursorPos), AAccepted);
    end;
  end;
end;

procedure TcxCustomGridTableController.DoEnter;
begin
  inherited;
  PostCheckEdit;
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

function TcxCustomGridTableController.CanFocusOnClick(X, Y: Integer): Boolean;
begin
  Result := inherited CanFocusOnClick(X, Y);
  if Result and Site.IsFocused and IsEditing and
    (ViewInfo.GetHitTest(X, Y).HitTestCode = htNavigator) then
    Result := False;
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

procedure TcxCustomGridTableController.SetFocus(ANotifyMaster: Boolean);
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
  begin
    GridView.DontMakeMasterRecordVisible := True;
    try
      DataController.CheckBrowseMode;
      //DataController.Post;
    finally
      GridView.DontMakeMasterRecordVisible := False;
    end;
  end;
  inherited;
end;

procedure TcxCustomGridTableController.BeforeOffset;
begin
  FEditingController.BeforeViewInfoCalculate;
end;

function TcxCustomGridTableController.CanAppend(ACheckOptions: Boolean): Boolean;
begin
  Result := (dceoAppend in DataController.EditOperations) and not FIsPullFocusing and
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
    if (GridView.Control <> nil) and TcxCustomGrid(GridView.Control).UpdateLocked then
      PostCheckEdit
    else
      FEditingController.CheckEdit;
end;

procedure TcxCustomGridTableController.CheckCoordinates;
begin
  inherited;
  TopRecordIndex := TopRecordIndex;
end;

procedure TcxCustomGridTableController.CheckTopRecordIndex(var Value: Integer);

  function IsGridModeAndScrollable: Boolean;
  begin
    Result := DataController.IsGridMode and not (dceInsert in DataController.EditState) and
      not IsCheckingCoordinates;
  end;

var
  APrevAllowHideSite: Boolean;
  AMaxValue: Integer;
begin
  if FCheckingCoordinate then Exit;
  FCheckingCoordinate := True;
  APrevAllowHideSite := ViewInfo.AllowHideSite;
  ViewInfo.AllowHideSite := False;
  try
    if Value < 0 then
    begin
      if IsGridModeAndScrollable and not DataController.IsBOF then
        DataController.Scroll(Value);
      Value := 0;
    end;
    if Value > ViewData.RecordCount - 1 then
    begin
      if DataController.IsGridMode and not DataController.IsEOF then
        DataController.Scroll(Value - (ViewData.RecordCount - 1));
      Value := ViewData.RecordCount - 1;
    end;
    if (Value <= 0) or not DataController.IsGridMode and (Value = TopRecordIndex) and
      (ViewInfo.VisibleRecordCount < ViewData.RecordCount - Value) then Exit;
    AMaxValue := GetMaxTopRecordIndexValue;
    if Value > AMaxValue then
    begin
      if IsGridModeAndScrollable and not DataController.IsEOF then
      begin
        DataController.Scroll(Value - AMaxValue);
        AMaxValue := GetMaxTopRecordIndexValue;
      end;     
      Value := AMaxValue;
    end;  
  finally
    ViewInfo.AllowHideSite := APrevAllowHideSite;
    FCheckingCoordinate := False;
  end;
end;

function TcxCustomGridTableController.FindNextCustomItem(AFocusedItemIndex, AItemCount: Integer;
  AGoForward, AGoOnCycle: Boolean; ACanFocus: TcxCustomGridTableCanItemFocus;
  AData: TObject; var AItemIndex: Integer; out ACycleChanged: Boolean): Boolean;
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
    if Result or
      ACycleChanged and ((AItemIndex = AFocusedItemIndex) or (AFocusedItemIndex = -1)) then Exit;
    GetNextIndex(AItemIndex);
  until (AItemIndex = AFromIndex) or (AItemIndex = -1) and (AFocusedItemIndex = -1);
end;

procedure TcxCustomGridTableController.FocusedItemChanged(APrevFocusedItem: TcxCustomGridTableItem);
begin
  if GridView.IsLoading or GridView.IsDestroying then Exit;
  IsReadyForImmediateEditing := False;
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

procedure TcxCustomGridTableController.FocusedRecordChanged(APrevFocusedRecordIndex,
  AFocusedRecordIndex: Integer; ANewItemRecordFocusingChanged: Boolean);
begin
  IsReadyForImmediateEditing := False;
  with EditingController do
    if HideEditOnFocusedRecordChange then HideEdit(True);
  if not DataController.IsSelectionAnchorExist then
    SetSelectionAnchor(AFocusedRecordIndex);
  GridView.FocusedRecordChanged(APrevFocusedRecordIndex, AFocusedRecordIndex, ANewItemRecordFocusingChanged);
end;

function TcxCustomGridTableController.GetCancelEditingOnExit: Boolean;
begin
  Result :=
    GridView.OptionsData.CancelOnExit and
    (DataController.EditState * [dceInsert, dceChanging, dceModified] = [dceInsert]);
end;

function TcxCustomGridTableController.GetFilterMRUItemsPopupClass: TcxGridFilterMRUItemsPopupClass;
begin
  Result := TcxGridFilterMRUItemsPopup;
end;

function TcxCustomGridTableController.GetFilterPopupClass: TcxGridFilterPopupClass;
begin
  Result := TcxGridFilterPopup;
end;

function TcxCustomGridTableController.GetFocusedRecord: TcxCustomGridRecord;
begin
  if (0 <= FocusedRecordIndex) and (FocusedRecordIndex < ViewData.RecordCount) then
    Result := ViewData.Records[FocusedRecordIndex]
  else
    Result := nil;
end;

function TcxCustomGridTableController.GetItemsCustomizationPopupClass: TcxCustomGridItemsCustomizationPopupClass;
begin
  Result := TcxCustomGridItemsCustomizationPopup;
end;

function TcxCustomGridTableController.GetMaxTopRecordIndexValue: Integer;
begin
  Result := ViewData.RecordCount -
    GetVisibleRecordCount(ViewData.RecordCount - 1, False);
end;

function TcxCustomGridTableController.GetPatternObject(AObject: TPersistent): TPersistent;
begin
  if AObject is TcxCustomGridTableItem then
    Result := TcxCustomGridTableView(GridView.PatternGridView).FindItemByID(TcxCustomGridTableItem(AObject).ID)
  else
    Result := inherited GetPatternObject(AObject);
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
  if Supports(TObject(DataController), IcxGridDataController, AIcxGridDataController) then
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
  if Supports(TObject(DataController), IcxGridDataController, AIcxGridDataController) then
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
    begin  // -2-4 ms
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
      ViewInfo.CalculateDown := ACalculateDown;
      AViewInfo := TcxCustomGridTableViewInfo(GridView.CreateViewInfo);
      try
        AViewInfo.CalculateDown := ACalculateDown;
        AViewInfo.FirstRecordIndex := AFirstRecordIndex;
        AViewInfo.MainCalculate(ViewInfo.Bounds);
        Result := AViewInfo.VisibleRecordCount;
      finally
        AViewInfo.Free;
        ViewInfo.CalculateDown := True;
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

procedure TcxCustomGridTableController.ScrollData(ADirection: TcxDirection);
begin
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
  if not Supports(TObject(DataController), IcxGridDataController, AIcxGridDataController) or
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
    FGridModeBufferCountUpdateTimer := TcxTimer.Create(nil);
    with FGridModeBufferCountUpdateTimer do
    begin
      Interval := 1;
      OnTimer := GridModeBufferCountUpdateTimerHandler;
    end;
  end;
end;

function TcxCustomGridTableController.CanScrollData(ADirection: TcxDirection): Boolean;
begin
  Result := False;
end;

function TcxCustomGridTableController.GetScrollDataTimeInterval(ADirection: TcxDirection): Integer;
begin
  Result := ScrollTimeInterval;
end;

function TcxCustomGridTableController.CanPostponeRecordSelection: Boolean;
begin
  Result := not IsEditing;
end;

function TcxCustomGridTableController.CanProcessMultiSelect(AIsKeyboard: Boolean): Boolean;
begin
  Result := MultiSelect and (not AIsKeyboard or GridView.Focused);
end;

function TcxCustomGridTableController.CanProcessMultiSelect(AHitTest: TcxCustomGridHitTest;
  AShift: TShiftState): Boolean;
begin
  Result := //not (ssDouble in AShift) and
    CanProcessMultiSelect(False) and IsClickableRecordHitTest(AHitTest) and
    (TcxGridRecordHitTest(AHitTest).GridRecord <> nil) and
    TcxGridRecordHitTest(AHitTest).GridRecord.Focused;
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

procedure TcxCustomGridTableController.DoMouseNormalSelection(AHitTest: TcxCustomGridHitTest);
begin
  DoNormalSelection;
end;

procedure TcxCustomGridTableController.DoMouseRangeSelection(AClearSelection: Boolean = True;
  AData: TObject = nil);
begin
  DoRangeSelection(AClearSelection);
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
begin                            //!!!
  if (FocusedRecordIndex <> -1) {and not (dceInsert in DataController.EditState) }then
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
    AFocusedRecordChanged and not (((AKey = VK_INSERT) or (AKey = Ord('C'))) and (AShift = [ssCtrl])); // for grid mode
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
    Result := CanPostponeRecordSelection and
      APressedRecord.Selected and not (ssDouble in AShift);
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
      DoMouseNormalSelection(AHitTest);
  end;

begin
  APressedRecord := TcxGridRecordHitTest(AHitTest).GridRecord;
  ASelectionShift := AShift - [ssLeft, ssRight, ssMiddle, ssDouble];
  AssignSelectionAnchor;
  if (ASelectionShift = [ssCtrl]) and SupportsRecordSelectionToggling then
    ProcessRecordSelectionToggling
  else
    if (ASelectionShift = [ssShift]) or (ASelectionShift = [ssCtrl, ssShift]) then
      DoMouseRangeSelection(not (ssCtrl in AShift) or not SupportsAdditiveSelection, AHitTest)
    else
      ProcessNormalSelection;
end;

procedure TcxCustomGridTableController.MultiSelectMouseUp(AHitTest: TcxCustomGridHitTest;
  AShift: TShiftState);
var
  ASelectionShift: TShiftState;
begin
  if FIsRecordUnselecting and (FUnselectingRecordIndex <> -1) and
    (FUnselectingRecordIndex = TcxGridRecordHitTest(AHitTest).GridRecord.Index) then
  begin
    ASelectionShift := AShift - [ssLeft, ssRight, ssMiddle, ssDouble];
    if (ASelectionShift = [ssCtrl]) and SupportsRecordSelectionToggling then
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

function TcxCustomGridTableController.SupportsAdditiveSelection: Boolean;
begin
  Result := True;
end;

function TcxCustomGridTableController.SupportsRecordSelectionToggling: Boolean;
begin
  Result := True;
end;

function TcxCustomGridTableController.CanFocusNextItem(AFocusedItemIndex, ANextItemIndex: Integer;
  AGoForward, AGoOnCycle, AGoToNextRecordOnCycle: Boolean): Boolean;
begin
  Result := ANextItemIndex <> -1;
end;

function TcxCustomGridTableController.FocusedRecordHasCells(ACheckCellSelectionAbility: Boolean): Boolean;
begin
  Result := (FocusedRecord <> nil) and FocusedRecord.HasCells and
    (not ACheckCellSelectionAbility or FocusedRecord.CanFocusCells);
end;

procedure TcxCustomGridTableController.FocusNextPage(ASyncSelection: Boolean);
begin
  MakeFocusedRecordVisible;
  if FocusedRecordIndex = TopRecordIndex + ViewInfo.VisibleRecordCount - 1 then
    ShowNextPage;
  FocusRecord(TopRecordIndex + ViewInfo.VisibleRecordCount - 1, ASyncSelection);
  Site.Update;
end;

procedure TcxCustomGridTableController.FocusPrevPage(ASyncSelection: Boolean);
begin
  MakeFocusedRecordVisible;
  if FocusedRecordIndex = TopRecordIndex then
    ShowPrevPage;
  FocusRecord(TopRecordIndex, ASyncSelection);
  Site.Update;
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
  if not Supports(TObject(DataController), IcxGridDataController, AIcxGridDataController) or
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
  if not Supports(TObject(DataController), IcxGridDataController, AIcxGridDataController) or
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

procedure TcxCustomGridTableController.DoPullFocusing(AHitTest: TcxGridRecordHitTest);
begin
  AHitTest.GridRecord.Focused := True;
  if AHitTest is TcxGridRecordCellHitTest then
    TcxGridRecordCellHitTest(AHitTest).Item.Focused := True;
  if MultiSelect and IsPullFocusingPosChanged then
    DoMouseRangeSelection(True, FPullFocusingOriginHitTest);
end;

procedure TcxCustomGridTableController.DoPullFocusingScrolling(ADirection: TcxDirection);
begin
  if ADirection in [dirUp, dirDown] then
  begin
    case ADirection of
      dirUp:
        FocusedRecordIndex := TopRecordIndex;
      dirDown:
        FocusedRecordIndex := TopRecordIndex + ViewInfo.VisibleRecordCount - 1;
    end;
    FocusNextRecord(FocusedRecordIndex, ADirection = dirDown, False, False, False);
  end;
  if MultiSelect and IsPullFocusingPosChanged then
    DoMouseRangeSelection(True, FPullFocusingOriginHitTest);
end;

function TcxCustomGridTableController.GetPullFocusingScrollingDirection(X, Y: Integer;
  out ADirection: TcxDirection): Boolean;
var
  R: TRect;
begin
  Result := False;
  R := ViewInfo.RecordsViewInfo.Bounds;
  if IsRecordsScrollHorizontal and (X < R.Left) or
    not IsRecordsScrollHorizontal and (Y < R.Top) then
  begin
    ADirection := dirUp;
    Result := True;
  end;
  if IsRecordsScrollHorizontal and (X >= R.Right) or
    not IsRecordsScrollHorizontal and (Y >= R.Bottom) then
  begin
    ADirection := dirDown;
    Result := True;
  end;
end;

function TcxCustomGridTableController.IsPullFocusingPosChanged: Boolean;
begin
  Result := (FPullFocusingRecordId <> DataController.GetRowId(FocusedRecordIndex)) or
    (FPullFocusingItem <> FocusedItem);
end;

procedure TcxCustomGridTableController.SavePullFocusingPos;
begin
  FPullFocusingRecordId := DataController.GetRowId(FocusedRecordIndex);
  FPullFocusingItem := FocusedItem;
end;

procedure TcxCustomGridTableController.StartPullFocusing(AHitTest: TcxCustomGridHitTest);
begin
  FIsPullFocusing := True;
  FPullFocusingMousePos := ViewInfo.MousePos;// Point(-1, -1);
  FPullFocusingOriginHitTest := AHitTest;
  FPullFocusingRecordId := Null;
end;

procedure TcxCustomGridTableController.StopPullFocusing;
begin
  StopPullFocusingScrolling;
  FPullFocusingRecordId := Null;
  FPullFocusingItem := nil;
  FIsPullFocusing := False;
end;

procedure TcxCustomGridTableController.StartPullFocusingScrolling(ADirection: TcxDirection);
begin
  FPullFocusingScrollingDirection := ADirection;
  if FPullFocusingScrollingTimer <> nil then Exit;
  FPullFocusingScrollingTimer := TcxTimer.Create(nil);
  with FPullFocusingScrollingTimer do
  begin
    Interval := PullFocusingScrollingTimeInterval;
    OnTimer := PullFocusingScrollingTimerHandler;
  end;
end;

procedure TcxCustomGridTableController.StopPullFocusingScrolling;
begin
  FreeAndNil(FPullFocusingScrollingTimer);
end;

function TcxCustomGridTableController.SupportsPullFocusing: Boolean;
begin
  Result := GridView.OptionsBehavior.PullFocusing;
end;

function TcxCustomGridTableController.GetDragScrollDirection(X, Y: Integer): TcxDirection;
const
  ADirections: array[Boolean, Boolean] of TcxDirection = ((dirUp, dirDown), (dirLeft, dirRight));
var
  AHitTest: TcxCustomGridHitTest;
  ARecord: TcxCustomGridRecord;
begin
  Result := dirNone;
  AHitTest := ViewInfo.GetHitTest(X, Y);
  if AHitTest is TcxGridRecordHitTest then
  begin
    ARecord := TcxGridRecordHitTest(AHitTest).GridRecord;
    if IsFirstRecordForDragScroll(ARecord) then
      Result := ADirections[IsRecordsScrollHorizontal, False]
    else
      if IsLastRecordForDragScroll(ARecord) then
        Result := ADirections[IsRecordsScrollHorizontal, True];
  end;
end;

function TcxCustomGridTableController.GetDragScrollInterval: Integer;
begin
  Result := 20;
end;

function TcxCustomGridTableController.IsFirstRecordForDragScroll(ARecord: TcxCustomGridRecord): Boolean;
begin
  Result := ARecord.Index = TopRecordIndex;
end;

function TcxCustomGridTableController.IsLastRecordForDragScroll(ARecord: TcxCustomGridRecord): Boolean;
begin
  Result := ARecord.ViewInfo.Index >= ViewInfo.RecordsViewInfo.VisibleCount - 1;
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
  FDragScrollTimer := TcxTimer.Create(nil);
  with FDragScrollTimer do
  begin
    Interval := GetDragScrollInterval;
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
  ClickedCellViewInfo := nil;
  StopPullFocusing;
  FinishSelection;
end;

procedure TcxCustomGridTableController.DoKeyDown(var Key: Word; Shift: TShiftState);
var
  APrevTopRecordIndex, APrevFocusedRecordIndex: Integer;
  AGridViewLink: TcxGridListenerLink;
begin
  APrevTopRecordIndex := TopRecordIndex;
  AGridViewLink := GridView.AddListenerLink;
  try
    try
      if IsIncSearching then
      begin
        IncSearchKeyDown(Key, Shift);
        if AGridViewLink.GridView = nil then Exit;
      end;
      APrevFocusedRecordIndex := FocusedRecordIndex;
      inherited;
      if AGridViewLink.GridView <> nil then
        if CanProcessMultiSelect(Key, Shift, FocusedRecordIndex <> APrevFocusedRecordIndex) then
          MultiSelectKeyDown(Key, Shift);
    finally
      if AGridViewLink.GridView <> nil then
      begin
        if TopRecordIndex <> APrevTopRecordIndex then
          Site.Update;
      end
      else
        Key := 0;
    end;
  finally
    AGridViewLink.Free;
  end;
end;

procedure TcxCustomGridTableController.EndDragAndDrop(Accepted: Boolean);
begin
  ScrollDirection := dirNone;
  inherited;
  CheckEdit;
end;

function TcxCustomGridTableController.FindNextItem(AFocusedItemIndex: Integer;
  AGoForward, AGoOnCycle: Boolean; out ACycleChanged: Boolean;
  ARecord: TcxCustomGridRecord): Integer;
begin
  if not FindNextCustomItem(AFocusedItemIndex, GridView.VisibleItemCount,
    AGoForward, AGoOnCycle, @cxCustomGridTableControllerCanFocusItem, ARecord, Result, ACycleChanged) then
    Result := -1;
end;

function TcxCustomGridTableController.FindNextRecord(AFocusedRecordIndex: Integer;
  AGoForward, AGoOnCycle: Boolean; out ACycleChanged: Boolean): Integer;
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
    AGoOnCycle, @cxCustomGridTableControllerCanFocusRecord, nil, Result, ACycleChanged) then
    Result := -1;
end;

function TcxCustomGridTableController.HasFilterMRUItemsPopup: Boolean;
begin
  Result := FFilterMRUItemsPopup <> nil;
end;

function TcxCustomGridTableController.HasFilterPopup: Boolean;
begin
  Result := FFilterPopup <> nil;
end;

function TcxCustomGridTableController.HasFocusedControls: Boolean;
begin
  Result := inherited HasFocusedControls or
    {IsEditing}(FEditingController.Edit <> nil) and FEditingController.Edit.IsFocused;
end;

function TcxCustomGridTableController.HasItemsCustomizationPopup: Boolean;
begin
  Result := FItemsCustomizationPopup <> nil;
end;

function TcxCustomGridTableController.IsClickableRecordHitTest(AHitTest: TcxCustomGridHitTest): Boolean;
begin
  Result := (AHitTest is TcxGridRecordHitTest) and TcxGridRecordHitTest(AHitTest).CanClick;
end;

function TcxCustomGridTableController.IsDataFullyVisible(AIsCallFromMaster: Boolean = False): Boolean;
begin
  Result := ViewInfo.VisibleRecordCount = ViewData.RecordCount;
end;

procedure TcxCustomGridTableController.KeyDown(var Key: Word; Shift: TShiftState);
var
  ARemoveFocus: Boolean;
begin
  inherited;
  if not FBlockRecordKeyboardHandling and (FocusedRecord <> nil) then
    FocusedRecord.KeyDown(Key, Shift);
  case Key of
    VK_INSERT:
      if (Shift = []) and CanInsert(True) then
        CreateNewRecord(False)
      else
        if (Shift = [ssCtrl]) and not IsEditing then
          GridView.CopyToClipboard(False);
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
      if (Key = VK_RETURN) and GridView.OptionsBehavior.GoToNextCellOnEnter or
        (Key = VK_TAB) and GridView.OptionsBehavior.FocusCellOnTab then
      begin
        ARemoveFocus := False;
        if Shift + [ssShift] = [ssShift] then
          if FocusNextCell(Shift = [], False) or (Key = VK_RETURN) then
            Key := 0
          else
            ARemoveFocus := not EditingController.IsEditing
        else
          ARemoveFocus := (Key = VK_TAB) and (Shift + [ssShift, ssCtrl] = [ssShift, ssCtrl]);
        if ARemoveFocus then
          TcxCustomGrid(GridView.Control).RemoveFocus(not (ssShift in Shift));
      end;
    VK_PRIOR:
      FocusPrevPage(False);
    VK_NEXT:
      FocusNextPage(False);
    Ord('A'):
      if Shift = [ssCtrl] then SelectAll;
    Ord('C'):
      if (Shift = [ssCtrl]) and not IsEditing then
        GridView.CopyToClipboard(False);
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
  if ((Key) in IncSearchStartChars) and
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
  AGridViewLink: TcxGridListenerLink;
begin
  FEditingController.StopEditShowingTimer;
  AHitTest := ViewInfo.GetHitTest(X, Y);
  AGridViewLink := GridView.AddListenerLink;
  try
    try
      inherited;
    finally
      //AHitTest := ViewInfo.GetHitTest(X, Y);
      if AGridViewLink.GridView <> nil then
      begin
        if not (AHitTest is TcxCustomGridViewHitTest) or
          (TcxCustomGridViewHitTest(AHitTest).GridView = AGridViewLink.GridView) then
        begin
          if CanProcessMultiSelect(AHitTest, Shift) then
            MultiSelectMouseDown(AHitTest, Shift);
          if (Shift = [ssLeft]) and IsClickableRecordHitTest(AHitTest) and
            SupportsPullFocusing and Site.MouseCapture and (GridView.DragMode = dmManual) then
            StartPullFocusing(AHitTest);
        end;
      end;
    end;
  finally
    AGridViewLink.Free;
  end;
end;

procedure TcxCustomGridTableController.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  AHitTest: TcxCustomGridHitTest;
  ADirection: TcxDirection;
begin
  inherited;
  if FIsPullFocusing then
  begin
    AHitTest := ViewInfo.GetHitTest(X, Y);
    if (AHitTest is TcxGridRecordHitTest) and CanHandleHitTest(AHitTest) then
      if (FPullFocusingMousePos.X <> X) or (FPullFocusingMousePos.Y <> Y) then
      begin
        StopPullFocusingScrolling;
        DoPullFocusing(TcxGridRecordHitTest(AHitTest));
        SavePullFocusingPos;
        Site.Update;
      end
      else
    else
      if GetPullFocusingScrollingDirection(X, Y, ADirection) then
        StartPullFocusingScrolling(ADirection);
    FPullFocusingMousePos := Point(X, Y);
  end;
end;

procedure TcxCustomGridTableController.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  AHitTest: TcxCustomGridHitTest;
begin
  inherited;
  ClickedCellViewInfo := nil;
  StopPullFocusing;
  AHitTest := ViewInfo.GetHitTest(X, Y);
  if (Button = mbLeft) and CanProcessMultiSelect(AHitTest, Shift) then
    MultiSelectMouseUp(AHitTest, Shift);
  FinishSelection;
end;

function TcxCustomGridTableController.ProcessDetailDialogChar(ADetail: TcxCustomGridView;
  ACharCode: Word): Boolean;
var
  ARecord: TcxCustomGridRecord;
begin
  Result := inherited ProcessDetailDialogChar(ADetail, ACharCode);
  if not Result then
  begin
    ARecord := ViewData.GetRecordByIndex(ADetail.MasterGridRecordIndex);
    Result := (ARecord <> nil) and (ARecord.ViewInfo <> nil) and
      ARecord.ViewInfo.ProcessDialogChar(ACharCode);
  end;
end;

function TcxCustomGridTableController.ProcessDialogChar(ACharCode: Word): Boolean;
begin
  Result :=
    (FocusedRecord <> nil) and (FocusedRecord.ViewInfo <> nil) and
    FocusedRecord.ViewInfo.ProcessDialogChar(ACharCode) or
    inherited ProcessDialogChar(ACharCode);
end;

function TcxCustomGridTableController.SupportsTabAccelerators(AGridRecord: TcxCustomGridRecord): Boolean;
begin
  Result := AGridRecord.Focused;
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
var
  AHitTest: TcxCustomGridHitTest;
begin
  Result := inherited CanDrag(X, Y);
  if Result then
  begin
    AHitTest := ViewInfo.GetHitTest(X, Y);
    Result := IsClickableRecordHitTest(AHitTest);
  end;  
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

procedure TcxCustomGridTableController.DrawDragImage(ACanvas: TcxCanvas; R: TRect);
var
  AParams: TcxViewParams;

  procedure DrawBorder(R: TRect);
  var
    I: Integer;
  begin
    for I := 1 to DragDropTextBorderSize do
    begin
      ACanvas.DrawFocusRect(R);
      InflateRect(R, -1, -1);
    end;
  end;

  procedure DrawText(const R: TRect);
  begin
    with ACanvas do
    begin
      Font := AParams.Font;
      Font.Color := AParams.TextColor;
      Brush.Style := bsClear;
      DrawText(FDragDropText, R, 0);
      Brush.Style := bsSolid;
    end;
  end;

begin
  if FDragDropText = '' then Exit;
  GetDragDropTextViewParams(AParams);
  with ACanvas do
  begin
    Brush.Color := AParams.Color;
    FillRect(R);
  end;
  Inc(R.Left, DragDropTextAreaOffset);
  DrawBorder(R);
  InflateRect(R, -DragDropTextIndent, -DragDropTextIndent);
  DrawText(R);
end;

procedure TcxCustomGridTableController.EndDrag(Target: TObject; X, Y: Integer);
begin
  DragHighlightedRecord := nil;
  TcxCustomGrid(Control).Controller.StopDragOpen;
  StopDragScroll;
  inherited;
end;

function TcxCustomGridTableController.GetDragDropText(ADragObject: TDragObject): string;
begin
  if GridView.OptionsBehavior.DragDropText then
    Result := GridView.DoGetDragDropText(FocusedRecord, FocusedItem)
  else
    Result := '';
end;

procedure TcxCustomGridTableController.GetDragDropTextViewParams(out AParams: TcxViewParams);
begin
  GridView.Styles.GetContentParams(nil, nil, AParams);
end;

function TcxCustomGridTableController.GetDragImagesSize: TPoint;
var
  AParams: TcxViewParams;
  ACanvas: TcxCanvas;
begin
  if FDragDropText = '' then
    Result := Point(0, 0)
  else
  begin
    GetDragDropTextViewParams(AParams);
    ACanvas := ViewInfo.Canvas;
    ACanvas.Font := AParams.Font;
    Result := Point(
      DragDropTextAreaOffset + DragDropTextIndent + ACanvas.TextWidth(FDragDropText) + DragDropTextIndent,
      DragDropTextIndent + ACanvas.TextHeight(FDragDropText) + DragDropTextIndent);
  end;  
end;

function TcxCustomGridTableController.HasDragImages: Boolean;
begin
  Result := True;
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
  TControlAccess(Site).DragCursor := GetCursor;
  FDragDropText := GetDragDropText(DragObject);
end;

procedure TcxCustomGridTableController.CancelIncSearching;
begin
  DataController.Search.Cancel;
end;

function TcxCustomGridTableController.CheckEditing(var AFocusedRecordIndex: Integer;
  AGoForward: Boolean): Boolean;
var
  AGridViewLink: TcxGridListenerLink;
begin
  Result := False;
  //AGridView.BeginUpdate;   - commented because of dialog calling in OnBeforePost
  AGridViewLink := GridView.AddListenerLink;
  try
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
        if AGridViewLink.GridView = nil then Exit;
        if AFocusedRecordIndex <> -1 then
          AFocusedRecordIndex := FocusedRecordIndex;
      end;
    finally
      if AGridViewLink.GridView = nil then
        Result := True
      else
      begin
        //AGridView.EndUpdate;
      end;
    end;
  finally
    AGridViewLink.Free;
  end;
end;

procedure TcxCustomGridTableController.CheckScrolling(const P: TPoint);
begin
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

function TcxCustomGridTableController.FocusFirstAvailableItem: Boolean;
begin
  Result := FocusNextItem(-1, True, False, False);
end;

function TcxCustomGridTableController.FocusNextCell(AGoForward: Boolean;
  AProcessCellsOnly: Boolean = True; AAllowCellsCycle: Boolean = True): Boolean;
begin
  if FocusedRecordHasCells(True) then
    Result := FocusNextItem(FocusedItemIndex, AGoForward, False,
      AAllowCellsCycle and GridView.OptionsBehavior.FocusCellOnCycle)
  else
    if AProcessCellsOnly or not GridView.OptionsBehavior.FocusCellOnCycle then
      Result := False
    else
    begin
      Result := FocusNextRecord(FocusedRecordIndex, AGoForward, False, False, False);
      if FocusedRecordHasCells(True) then
        FocusNextItem(-1, AGoForward, True, False);
    end;
end;

function TcxCustomGridTableController.FocusNextItem(AFocusedItemIndex: Integer;
  AGoForward, AGoOnCycle, AGoToNextRecordOnCycle: Boolean): Boolean;
var
  ANextItemIndex: Integer;
  ACycleChanged: Boolean;
begin
  ANextItemIndex := FindNextItem(AFocusedItemIndex, AGoForward,
    AGoOnCycle or AGoToNextRecordOnCycle, ACycleChanged, FocusedRecord);
  Result := CanFocusNextItem(AFocusedItemIndex, ANextItemIndex, AGoForward,
    AGoOnCycle, AGoToNextRecordOnCycle);
  if Result then
  begin
    if ACycleChanged and AGoToNextRecordOnCycle then
      if FocusedRecord.IsNewItemRecord then
      begin
        DataController.Post;
        if ViewData.NewItemRecord <> nil then
          ViewData.NewItemRecord.Focused := True;
        Result := True;
      end
      else
        Result := FocusNextRecord(FocusedRecordIndex, AGoForward, False, False, False) and
          FocusedRecordHasCells(True)
    else
      Result := True;
    if Result then
      GridView.VisibleItems[ANextItemIndex].Focused := True;
  end;
end;

function TcxCustomGridTableController.FocusNextRecord(AFocusedRecordIndex: Integer;
  AGoForward, AGoOnCycle, AGoIntoDetail, AGoOutOfDetail: Boolean): Boolean;
var
  AGridViewLink: TcxGridListenerLink;
  APrevFocused, ACycleChanged: Boolean;
  APrevFocusedRecord, ANextRecord, AChildRecord: TcxCustomGridRecord;
  ANextRecordIndex: Integer;

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
  Result := CheckEditing(AFocusedRecordIndex, AGoForward);
  if Result then Exit;
  AGridViewLink := GridView.AddListenerLink;
  try
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
          if AGoForward and CanAppend(True) and (DataController.EditState <> [dceInsert]) then
          begin
            CreateNewRecord(True);
            Result := True;
            Exit;
          end
          else
            if GridView.IsDetail and AGoOutOfDetail then
              if not AGoForward and GridView.MasterGridRecord.CanFocus then
                ANextRecord := GridView.MasterGridRecord
              else
              begin
                Result := not DataController.IsGridMode and
                  MasterController.FocusNextRecord(GridView.MasterGridRecordIndex,
                    AGoForward, AGoOnCycle, not AGoForward, True);
                Exit;
              end;
      end;
      Result := ANextRecord <> nil;
      if Result then
        ANextRecord.Focused := True;
    finally
      if (AGridViewLink.GridView <> nil) and Result then
      begin
        ProcessMultiSelect;
        //Site.Update;
      end;
    end;
  finally
    AGridViewLink.Free;
  end;
end;

function TcxCustomGridTableController.FocusNextRecordWithSelection(AFocusedRecordIndex: Integer;
  AGoForward, AGoOnCycle, AGoIntoDetail: Boolean; ASyncSelection: Boolean = True): Boolean;
begin
  Result := FocusNextRecord(AFocusedRecordIndex, AGoForward, AGoOnCycle,
    AGoIntoDetail, AGoIntoDetail);
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
  if not IsFocusing then
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
  if AIndex <> -1 then
  begin
    if AIndex < TopRecordIndex then InternalTopRecordIndex := AIndex;
    if ViewInfo.VisibleRecordCount = 0 then
      if AIndex > TopRecordIndex then
        InternalTopRecordIndex := AIndex
      else
    else
    begin
      Site.LockScrollBars;
      try
        while AIndex >= TopRecordIndex + ViewInfo.VisibleRecordCount do
        begin
          APrevTopRecordIndex := TopRecordIndex;
          InternalTopRecordIndex := AIndex - GetVisibleRecordCount(AIndex, False) + 1;
          if TopRecordIndex = APrevTopRecordIndex then Break;
        end;
      finally
        Site.UnlockScrollBars;
      end;
    end;
  end;
  GridView.MakeMasterGridRecordVisible;
end;

procedure TcxCustomGridTableController.SelectAll;
begin
  SelectAllRecords;
end;

procedure TcxCustomGridTableController.SelectAllRecords;
begin
  DataController.SelectAll;
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
  if DataController.IsGridMode then
    Result := DataController.IsEOF
  else
    Result := FindNextRecord(FocusedRecordIndex, True, False, ACycleChanged) = -1;
end;

function TcxCustomGridTableController.IsStart: Boolean;
var
  ACycleChanged: Boolean;
begin
  if DataController.IsGridMode then
    Result := DataController.IsBOF
  else
    Result := FindNextRecord(FocusedRecordIndex, False, False, ACycleChanged) = -1;
end;

{ TcxCustomGridFilterButtonPainter }

function TcxCustomGridFilterButtonPainter.GetViewInfo: TcxCustomGridFilterButtonViewInfo;
begin
  Result := TcxCustomGridFilterButtonViewInfo(inherited ViewInfo);
end;

function TcxCustomGridFilterButtonPainter.ExcludeFromClipRect: Boolean;
begin
  Result := True;
end;

{  TcxGridFilterCloseButtonPainter }

procedure TcxGridFilterCloseButtonPainter.DrawContent;
begin
  ViewInfo.LookAndFeelPainter.DrawFilterCloseButton(Canvas, ViewInfo.Bounds,
    ViewInfo.ButtonState);
end;

{ TcxGridFilterActivateButtonPainter }

function TcxGridFilterActivateButtonPainter.GetViewInfo: TcxGridFilterActivateButtonViewInfo;
begin
  Result := TcxGridFilterActivateButtonViewInfo(inherited ViewInfo);
end;

procedure TcxGridFilterActivateButtonPainter.DrawContent;
begin
  ViewInfo.LookAndFeelPainter.DrawFilterActivateButton(Canvas, ViewInfo.Bounds,
    ViewInfo.ButtonState, ViewInfo.Checked);
end;

{ TcxGridFilterDropDownButtonPainter }

procedure TcxGridFilterDropDownButtonPainter.DrawContent;
begin
  ViewInfo.LookAndFeelPainter.DrawFilterDropDownButton(Canvas, ViewInfo.Bounds,
    ViewInfo.ButtonState, False);
end;

{ TcxGridFilterCustomizeButtonPainter }

procedure TcxGridFilterCustomizeButtonPainter.Paint;
begin
  Canvas.Font := ViewInfo.Params.Font;
  ViewInfo.LookAndFeelPainter.DrawButton(Canvas, ViewInfo.Bounds, ViewInfo.Text,
    ViewInfo.ButtonState);
end;

{ TcxGridFilterPainter }

function TcxGridFilterPainter.GetViewInfo: TcxGridFilterViewInfo;
begin
  Result := TcxGridFilterViewInfo(inherited ViewInfo);
end;

procedure TcxGridFilterPainter.DrawButtons;
var
  I: Integer;
begin
  with ViewInfo.ButtonsViewInfo do
    for I := 0 to Count - 1 do
      Items[I].Paint;
end;

function TcxGridFilterPainter.ExcludeFromClipRect: Boolean;
begin
  Result := True;
end;

procedure TcxGridFilterPainter.Paint;
begin
//  DrawButtons;  - commented because of XP
  inherited;
  DrawButtons;
end;

procedure TcxGridFilterPainter.PrepareCanvasForDrawText;
begin
  inherited;
  FTextWasUnderlined := False;
  if ViewInfo.State in [gcsSelected, gcsPressed] then
    with Canvas.Font do
      if not (fsUnderline in Style) then
      begin
        Style := Style + [fsUnderline];
        FTextWasUnderlined := True;
      end;
end;

procedure TcxGridFilterPainter.UnprepareCanvasForDrawText;
begin
  if FTextWasUnderlined then
    with Canvas.Font do
      Style := Style - [fsUnderline];
  inherited;
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
    if Focused and HasFocusRect then
      GridViewInfo.Painter.DrawFocusRect(ContentBounds, GridView.OptionsSelection.HideFocusRectOnExit);
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
  if ViewInfo.GridRecord.Expandable and not DrawExpandButtonBeforePaint then
    DrawExpandButton;
  ViewInfo.GridViewInfo.Painter.ExcludeFromBackground(ViewInfo.Bounds);
  inherited;
end;

procedure TcxCustomGridRecordPainter.BeforePaint;
begin
  inherited;
  if ViewInfo.GridRecord.Expandable and DrawExpandButtonBeforePaint then
    DrawExpandButton;
  DrawBackground;
end;

procedure TcxCustomGridRecordPainter.DrawBackground;
begin
  if ViewInfo.Transparent then
    DrawBackground(ViewInfo.BackgroundBitmapBounds);
end;

procedure TcxCustomGridRecordPainter.DrawExpandButton;
var
  AClipRegion: TcxRegion;
begin
  AClipRegion := Canvas.GetClipRegion;
  try
    ViewInfo.GridViewInfo.LookAndFeelPainter.DrawExpandButton(Canvas,
      ViewInfo.ExpandButtonBounds, ViewInfo.Expanded);
  finally
    Canvas.SetClipRegion(AClipRegion, roSet);  // for speed
  end;
end;

function TcxCustomGridRecordPainter.DrawExpandButtonBeforePaint: Boolean;
begin
  Result := False;  // ViewInfo.GridViewInfo.LookAndFeelPainter.DrawExpandButtonFirst; - for speed
end;

procedure TcxCustomGridRecordPainter.DrawFocusRect;
begin
  with ViewInfo do
    if Focused and HasFocusRect then
      GridViewInfo.Painter.DrawFocusRect(FocusRectBounds, HideFocusRectOnExit);
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
begin
  Result := (ViewInfo.BackgroundBitmap = nil) and
    (ViewInfo.RecordsViewInfo.BackgroundBitmap = nil) and
    not ViewInfo.NoDataInfoTextAreaVisible;
end;

procedure TcxCustomGridTablePainter.DrawBackground;
begin
  inherited;
  if ViewInfo.NoDataInfoTextAreaVisible then
    DrawInfoText;
end;

procedure TcxCustomGridTablePainter.DrawFilterBar;
begin
  ViewInfo.FilterViewInfo.Paint;
end;

procedure TcxCustomGridTablePainter.DrawInfoText;
var
  AParams: TcxViewParams;
begin
  ViewInfo.GetNoDataInfoTextParams(AParams);
  with Canvas do
  begin
    SetParams(AParams);
    Brush.Style := bsClear;
    DrawText(cxGetResourceString(@scxGridNoDataInfoText), ViewInfo.NoDataInfoTextAreaBounds,
      cxAlignCenter or cxWordBreak, True);
    Brush.Style := bsSolid;
  end;
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
  begin
    Controller.BeforePaint;
    try
      if AItemsOffset = 0 then
        Offset(DX, DY)
      else
        Offset(AItemsOffset);
    finally
      Controller.AfterPaint;
    end;
  end
  else
    GridView.ViewChanged;
end;

procedure TcxCustomGridTablePainter.DrawFocusRect(const R: TRect; AHideFocusRect: Boolean);
begin
  if ViewInfo.GridView.OptionsView.FocusRect then inherited;
end;

{ TcxCustomGridPartViewInfo }

constructor TcxCustomGridPartViewInfo.Create(AGridViewInfo: TcxCustomGridTableViewInfo);
begin
  inherited Create(AGridViewInfo);
  if IsPart then
    GridViewInfo.AddPart(Self);
end;

destructor TcxCustomGridPartViewInfo.Destroy;
begin
  if IsPart then
    GridViewInfo.RemovePart(Self);
  inherited;
end;

function TcxCustomGridPartViewInfo.GetGridView: TcxCustomGridTableView;
begin
  Result := TcxCustomGridTableView(inherited GridView);
end;

function TcxCustomGridPartViewInfo.GetGridViewInfo: TcxCustomGridTableViewInfo;
begin
  Result := TcxCustomGridTableViewInfo(inherited GridViewInfo);
end;

function TcxCustomGridPartViewInfo.GetIndex: Integer;
begin
  Result := GridViewInfo.FParts.IndexOf(Self);
end;

procedure TcxCustomGridPartViewInfo.SetIndex(Value: Integer);
begin
  if Index <> Value then
    GridViewInfo.FParts.Move(Index, Value);
end;

function TcxCustomGridPartViewInfo.CalculateBounds: TRect;
begin
  Result := GridViewInfo.CalculatePartBounds(Self);
end;

procedure TcxCustomGridPartViewInfo.CalculateInvisible;
begin
  FHeight := 0;
  inherited Calculate(0, 0, 0, 0);
end;

procedure TcxCustomGridPartViewInfo.CalculateVisible;
begin
  FHeight := CalculateHeight;
  with CalculateBounds do
    Calculate(Left, Top, Right - Left, Bottom - Top);
end;

function TcxCustomGridPartViewInfo.CustomDrawBackground(ACanvas: TcxCanvas): Boolean;
begin
  Result := inherited CustomDrawBackground(ACanvas);
  if not Result then
    GridView.DoCustomDrawPartBackground(ACanvas, Self, Result);
end;

{function TcxCustomGridPartViewInfo.GetHeight: Integer;
begin
  Result := inherited GetHeight;
  if Result = 0 then Result := FHeight;
end;}

function TcxCustomGridPartViewInfo.GetIsPart: Boolean;
begin
  Result := True;
end;

function TcxCustomGridPartViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxCustomGridPartPainter;
end;

function TcxCustomGridPartViewInfo.HasCustomDrawBackground: Boolean;
begin
  Result := GridView.HasCustomDrawPartBackground;
end;

procedure TcxCustomGridPartViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  inherited;
  GridViewInfo.InitHitTest(AHitTest);
end;

procedure TcxCustomGridPartViewInfo.MainCalculate;
begin
  if Visible then
    CalculateVisible
  else
    CalculateInvisible;
end;

{ TcxCustomGridFilterButtonViewInfo }

constructor TcxCustomGridFilterButtonViewInfo.Create(AContainer: TcxGridFilterButtonsViewInfo);
begin
  inherited Create(AContainer.FilterViewInfo.GridViewInfo);
  FContainer := AContainer;
end;

function TcxCustomGridFilterButtonViewInfo.GetFilter: TcxDataFilterCriteria;
begin
  Result := FContainer.FilterViewInfo.Filter;
end;

function TcxCustomGridFilterButtonViewInfo.GetGridView: TcxCustomGridTableView;
begin
  Result := TcxCustomGridTableView(inherited GridView);
end;

function TcxCustomGridFilterButtonViewInfo.CaptureMouseOnPress: Boolean;
begin
  Result := True;
end;

function TcxCustomGridFilterButtonViewInfo.GetAlignment: TcxGridFilterButtonAlignment;
begin
  Result := fbaLeft;
end;

function TcxCustomGridFilterButtonViewInfo.GetCanvas: TcxCanvas;
begin
  Result := FContainer.FilterViewInfo.Canvas;
end;

function TcxCustomGridFilterButtonViewInfo.GetHotTrack: Boolean;
begin
  Result := True;
end;

function TcxCustomGridFilterButtonViewInfo.GetVisible: Boolean;
begin
  Result := not Filter.IsEmpty;
end;

{ TcxGridFilterCloseButtonViewInfo }

function TcxGridFilterCloseButtonViewInfo.CalculateHeight: Integer;
begin
  Result := LookAndFeelPainter.FilterCloseButtonSize.Y;
end;

function TcxGridFilterCloseButtonViewInfo.CalculateWidth: Integer;
begin
  Result := LookAndFeelPainter.FilterCloseButtonSize.X;
end;

procedure TcxGridFilterCloseButtonViewInfo.Click;
begin
  inherited;
  Filter.Clear;
end;

function TcxGridFilterCloseButtonViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridFilterCloseButtonHitTest;
end;

function TcxGridFilterCloseButtonViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridFilterCloseButtonPainter;
end;

{ TcxGridFilterActivateButtonViewInfo }

function TcxGridFilterActivateButtonViewInfo.GetChecked: Boolean;
begin
  Result := Filter.Active;
end;

function TcxGridFilterActivateButtonViewInfo.CalculateHeight: Integer;
begin
  Result := LookAndFeelPainter.FilterActivateButtonSize.Y;
end;

function TcxGridFilterActivateButtonViewInfo.CalculateWidth: Integer;
begin
  Result := LookAndFeelPainter.FilterActivateButtonSize.X;
end;

procedure TcxGridFilterActivateButtonViewInfo.Click;
begin
  inherited;
  with Filter do
    Active := not Active;
end;

function TcxGridFilterActivateButtonViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridFilterActivateButtonHitTest;
end;

function TcxGridFilterActivateButtonViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridFilterActivateButtonPainter;
end;

{ TcxGridFilterDropDownButtonViewInfo }

function TcxGridFilterDropDownButtonViewInfo.GetDropDownWindowValue: TcxGridFilterMRUItemsPopup;
begin
  Result := TcxGridFilterMRUItemsPopup(inherited DropDownWindow);
end;

procedure TcxGridFilterDropDownButtonViewInfo.BeforeStateChange;
begin
  inherited;
  if State = gcsPressed then
    Container.FilterViewInfo.State := gcsNone;
end;

function TcxGridFilterDropDownButtonViewInfo.CalculateHeight: Integer;
begin
  Result := LookAndFeelPainter.FilterCloseButtonSize.Y;
end;

function TcxGridFilterDropDownButtonViewInfo.CalculateWidth: Integer;
begin
  Result := LookAndFeelPainter.FilterCloseButtonSize.X;
end;

function TcxGridFilterDropDownButtonViewInfo.CaptureMouseOnPress: Boolean;
begin
  Result := False;
end;

function TcxGridFilterDropDownButtonViewInfo.GetAlignment: TcxGridFilterButtonAlignment;
begin
  Result := fbaRight;
end;

function TcxGridFilterDropDownButtonViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridFilterDropDownButtonHitTest;
end;

function TcxGridFilterDropDownButtonViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridFilterDropDownButtonPainter;
end;

function TcxGridFilterDropDownButtonViewInfo.GetVisible: Boolean;
begin
  Result := GridView.Filtering.IsMRUItemsListAvailable;
end;

function TcxGridFilterDropDownButtonViewInfo.DropDownWindowExists: Boolean;
begin
  Result := GridView.Controller.HasFilterMRUItemsPopup;
end;

function TcxGridFilterDropDownButtonViewInfo.GetDropDownWindow: TcxCustomGridPopup;
begin
  Result := GridView.Controller.FilterMRUItemsPopup;
end;

function TcxGridFilterDropDownButtonViewInfo.GetDropDownWindowOwnerBounds: TRect;
begin
  Result := Bounds;
  Result.Left := Container.FilterViewInfo.TextAreaBounds.Left -
    (DropDownWindow.BorderWidths[bLeft] + DropDownWindow.TextOffsetHorz);
end;

procedure TcxGridFilterDropDownButtonViewInfo.Calculate(ALeftBound, ATopBound: Integer;
  AWidth: Integer = -1; AHeight: Integer = -1);
begin
  ALeftBound := Min(ALeftBound, Container.FilterViewInfo.TextBounds.Right +
    cxGridCellTextOffset + FilterTextOffset + FilterButtonsOffset);
  inherited;
end;

{ TcxGridFilterCustomizeButtonViewInfo }

function TcxGridFilterCustomizeButtonViewInfo.CalculateHeight: Integer;
begin
  Result := BorderWidth[bTop] + BorderWidth[bBottom] + TextHeightWithOffset +
    2 * LookAndFeelPainter.ButtonTextOffset;
end;

function TcxGridFilterCustomizeButtonViewInfo.CalculateWidth: Integer;
begin
  Result := BorderWidth[bLeft] + BorderWidth[bRight] + TextWidthWithOffset +
    2 * LookAndFeelPainter.ButtonTextOffset;
end;

procedure TcxGridFilterCustomizeButtonViewInfo.Click;
begin
  inherited;
  GridView.Filtering.RunCustomizeDialog;
end;

function TcxGridFilterCustomizeButtonViewInfo.GetAlignment: TcxGridFilterButtonAlignment;
begin
  Result := fbaRight;
end;

function TcxGridFilterCustomizeButtonViewInfo.GetAlignmentHorz: TAlignment;
begin
  Result := taCenter;
end;

function TcxGridFilterCustomizeButtonViewInfo.GetAlignmentVert: TcxAlignmentVert;
begin
  Result := vaCenter;
end;

function TcxGridFilterCustomizeButtonViewInfo.GetBorders: TcxBorders;
begin
  Result := [bLeft, bTop, bRight, bBottom];
end;

function TcxGridFilterCustomizeButtonViewInfo.GetBorderWidth(AIndex: TcxBorder): Integer;
begin
  Result := LookAndFeelPainter.ButtonBorderSize;
end;

function TcxGridFilterCustomizeButtonViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridFilterCustomizeButtonHitTest;
end;

function TcxGridFilterCustomizeButtonViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridFilterCustomizeButtonPainter;
end;

function TcxGridFilterCustomizeButtonViewInfo.GetText: string;
begin
  Result := cxGetResourceString(@scxGridFilterCustomizeButtonCaption);
end;

procedure TcxGridFilterCustomizeButtonViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  AParams.Font := Container.FilterViewInfo.Params.Font;
end;

function TcxGridFilterCustomizeButtonViewInfo.GetVisible: Boolean;
begin
  Result := GridView.FilterBox.CustomizeDialog;
end;

{ TcxGridFilterButtonsViewInfo }

constructor TcxGridFilterButtonsViewInfo.Create(AFilterViewInfo: TcxGridFilterViewInfo);
begin
  inherited Create;
  FFilterViewInfo := AFilterViewInfo;
  FItems := TList.Create;
  AddItems;
end;

destructor TcxGridFilterButtonsViewInfo.Destroy;
begin
  DestroyItems;
  FItems.Free;
  inherited;
end;

function TcxGridFilterButtonsViewInfo.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxGridFilterButtonsViewInfo.GetGridView: TcxCustomGridTableView;
begin
  Result := TcxCustomGridTableView(FFilterViewInfo.GridView);
end;

function TcxGridFilterButtonsViewInfo.GetHeight: Integer;
var
  I, AItemHeight: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    if Items[I].Visible then
    begin
      AItemHeight := Items[I].CalculateHeight;
      if Result < AItemHeight then Result := AItemHeight;
    end;
  if Result <> 0 then Inc(Result, 2 * FilterButtonsFirstOffset);
end;

function TcxGridFilterButtonsViewInfo.GetItem(Index: Integer): TcxCustomGridFilterButtonViewInfo;
begin
  Result := TcxCustomGridFilterButtonViewInfo(FItems[Index]);
end;

function TcxGridFilterButtonsViewInfo.GetWidth(AAlignment: TcxGridFilterButtonAlignment): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    with Items[I] do
      if Visible and (Alignment = AAlignment) then
        Inc(Result, CalculateWidth + FilterButtonsOffset);
  if Result <> 0 then
    Inc(Result, 2 * FilterButtonsFirstOffset - FilterButtonsOffset);
end;

function TcxGridFilterButtonsViewInfo.GetWidthLeftPart: Integer;
begin
  Result := GetWidth(fbaLeft);
end;

function TcxGridFilterButtonsViewInfo.GetWidthRightPart: Integer;
begin
  Result := GetWidth(fbaRight);
end;

procedure TcxGridFilterButtonsViewInfo.AddItems;
begin
  AddItem(TcxGridFilterCloseButtonViewInfo);
  AddItem(TcxGridFilterActivateButtonViewInfo);
  AddItem(TcxGridFilterCustomizeButtonViewInfo);
  FDropDownButtonViewInfo := AddItem(TcxGridFilterDropDownButtonViewInfo) as TcxGridFilterDropDownButtonViewInfo;
end;

procedure TcxGridFilterButtonsViewInfo.DestroyItems;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do Items[I].Free;
  FItems.Clear;
  FDropDownButtonViewInfo := nil;
end;

function TcxGridFilterButtonsViewInfo.AddItem(AItemClass: TcxCustomGridFilterButtonViewInfoClass): TcxCustomGridFilterButtonViewInfo;
begin
  Result := AItemClass.Create(Self);
  FItems.Add(Result);
end;

procedure TcxGridFilterButtonsViewInfo.Calculate(const ABounds: TRect);
var
  ALeftMargin, ARightMargin, ALeft, I: Integer;
begin
  ALeftMargin := ABounds.Left + FilterButtonsFirstOffset;
  ARightMargin := ABounds.Right - FilterButtonsFirstOffset;
  for I := 0 to Count - 1 do
    with Items[I], ABounds do
      if Visible then
      begin
        if Alignment = fbaLeft then
          ALeft := ALeftMargin
        else
          ALeft := ARightMargin - CalculateWidth;
        Calculate(ALeft, MulDiv(Top + Bottom - CalculateHeight, 1, 2));
        if Alignment = fbaLeft then
          ALeftMargin := Items[I].Bounds.Right + FilterButtonsOffset
        else
          ARightMargin := Items[I].Bounds.Left - FilterButtonsOffset;
      end;
end;

function TcxGridFilterButtonsViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
  begin
    Result := Items[I].GetHitTest(P);
    if Result <> nil then Break;
  end;
end;

{ TcxGridFilterViewInfo }

constructor TcxGridFilterViewInfo.Create(AGridViewInfo: TcxCustomGridTableViewInfo);
begin
  inherited;
  CreateButtonsViewInfo;
end;

destructor TcxGridFilterViewInfo.Destroy;
begin
  DestroyButtonsViewInfo;
  inherited;
end;

function TcxGridFilterViewInfo.GetFilter: TcxDataFilterCriteria;
begin
  Result := GridView.DataController.Filter;
end;

function TcxGridFilterViewInfo.GetFiltering: TcxCustomGridTableFiltering;
begin
  Result := TcxCustomGridTableView(GridView).Filtering;
end;

procedure TcxGridFilterViewInfo.CreateButtonsViewInfo;
begin
  FButtonsViewInfo := GetButtonsViewInfoClass.Create(Self);
end;

procedure TcxGridFilterViewInfo.DestroyButtonsViewInfo;
begin
  FreeAndNil(FButtonsViewInfo);
end;

function TcxGridFilterViewInfo.CalculateButtonsViewInfoBounds: TRect;
begin
  Result := Bounds;
end;

function TcxGridFilterViewInfo.CalculateHeight: Integer;
var
  AButtonsHeight: Integer;
begin
  Result := FilterTextOffset + TextHeightWithOffset + FilterTextOffset;
  AButtonsHeight := FButtonsViewInfo.Height;
  if Result < AButtonsHeight then Result := AButtonsHeight;
end;

function TcxGridFilterViewInfo.CalculateWidth: Integer;
begin
  Result := GridViewInfo.ClientWidth;
end;

function TcxGridFilterViewInfo.GetAlignment: TcxGridPartAlignment;
begin
  Result := TcxGridPartAlignment(GridView.FilterBox.Position);
end;

function TcxGridFilterViewInfo.GetAlignmentVert: TcxAlignmentVert;
begin
  Result := vaCenter;
end;

function TcxGridFilterViewInfo.GetBackgroundBitmap: TBitmap;
begin
  Result := GridView.BackgroundBitmaps.GetBitmap(bbFilterBox);
end;

function TcxGridFilterViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridFilterHitTest;
end;

function TcxGridFilterViewInfo.GetHotTrack: Boolean;
begin
  Result := Filtering.IsMRUItemsListAvailable;
end;

function TcxGridFilterViewInfo.GetIsAutoWidth: Boolean;
begin
  Result := True;
end;

function TcxGridFilterViewInfo.GetIsCheck: Boolean;
begin
  Result := True;
end;

function TcxGridFilterViewInfo.GetIsScrollable: Boolean;
begin
  Result := False;
end;

function TcxGridFilterViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridFilterPainter;
end;

function TcxGridFilterViewInfo.GetText: string;
begin
  Result := Filter.FilterCaption;
  if Result = '' then
    Result := cxGetResourceString(@scxGridFilterIsEmpty);
end;

function TcxGridFilterViewInfo.GetTextAreaBounds: TRect;
begin
  Result := inherited GetTextAreaBounds;
  Inc(Result.Left, FButtonsViewInfo.WidthLeftPart);
  Dec(Result.Right, FButtonsViewInfo.WidthRightPart);
  InflateRect(Result, -FilterTextOffset, 0);
end;

procedure TcxGridFilterViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  GridView.Styles.GetViewParams(vsFilterBox, nil, nil, AParams);
end;

function TcxGridFilterViewInfo.GetVisible: Boolean;
begin
  Result := (GridView.FilterBox.Visible = fvAlways) or
    (GridView.FilterBox.Visible = fvNonEmpty) and not Filter.IsEmpty;
end;

function TcxGridFilterViewInfo.HasMouse(AHitTest: TcxCustomGridHitTest): Boolean;
begin
  Result := inherited HasMouse(AHitTest) and PtInRect(TextBounds, AHitTest.Pos);
end;

function TcxGridFilterViewInfo.InvalidateOnStateChange: Boolean;
begin
  Result := False;
end;

procedure TcxGridFilterViewInfo.StateChanged;
begin
  if not IsDestroying then
    GridView.ViewChanged(TextBounds);
  inherited;
  if State = gcsPressed then
    FButtonsViewInfo.DropDownButtonViewInfo.State := gcsPressed;
end;

function TcxGridFilterViewInfo.GetButtonsViewInfoClass: TcxGridFilterButtonsViewInfoClass;
begin
  Result := TcxGridFilterButtonsViewInfo;
end;

procedure TcxGridFilterViewInfo.Calculate(ALeftBound, ATopBound: Integer;
  AWidth: Integer = -1; AHeight: Integer = -1);
begin
  inherited;
  FButtonsViewInfo.Calculate(CalculateButtonsViewInfoBounds);
end;

function TcxGridFilterViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
begin
  Result := FButtonsViewInfo.GetHitTest(P);
  if Result = nil then
    Result := inherited GetHitTest(P);
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
  Result := TcxCustomGridTableController(inherited Controller);
end;

function TcxGridTableCellViewInfo.GetGridView: TcxCustomGridTableView;
begin
  Result := TcxCustomGridTableView(inherited GridView);
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
  AGridViewLink: TcxGridListenerLink;
begin
  AGridViewLink := GridView.AddListenerLink;
  try
    GridViewInfo.AddActiveViewInfo(Self);
    try
      Result := FRecordViewInfo.MouseDown(AHitTest, AButton, AShift);
      if Result and TcxCustomGridTableView(AGridViewLink.GridView).ViewInfo.IsViewInfoActive(Self) then
        inherited MouseDown(AHitTest, AButton, AShift);
    finally
      if AGridViewLink.GridView <> nil then
        TcxCustomGridTableView(AGridViewLink.GridView).ViewInfo.RemoveActiveViewInfo(Self)
      else
        Result := False;
    end;
  finally
    AGridViewLink.Free;
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
  FEditViewInfo := CreateEditViewInfo;
  FStyle := FItem.GetCellStyle;
end;

destructor TcxGridTableDataCellViewInfo.Destroy;
begin
  if FItem <> nil then
  begin
    if FItem.Controller.ClickedCellViewInfo = Self then
      FItem.Controller.ClickedCellViewInfo := nil;
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
begin                            
  FEditViewInfo.BackgroundColor := ACanvas.Brush.Color;
  if FEditViewInfo is TcxCustomTextEditViewInfo then
    with TcxCustomTextEditViewInfo(FEditViewInfo) do
    begin
      Font := ACanvas.Font;
      TextColor := ACanvas.Font.Color;
    end;
end;
                               
procedure TcxGridTableDataCellViewInfo.BeforeCustomDraw(ACanvas: TcxCanvas);
begin                            
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
    FEditViewData.PaintOptions := [];
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
    FEditViewData.InplaceEditParams.Position := GetInplaceEditPosition;
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
      if AEditSizeProperties.Width > 0 then
      begin
        FEditViewData.InplaceEditParams.Position := GetInplaceEditPosition;
        Result := FEditViewData.GetEditSize(Canvas, DisplayValue, AEditSizeProperties).cy;
      end
      else
        Result := 0;
      if Result <> 0 then
        Inc(Result, 2 * cxGridEditOffset)
      else
        if not SupportsZeroHeight then
          Result := FItem.CalculateDefaultCellHeight(Canvas, Params.Font);
    finally
      DestroyEditViewData;
    end;
  end
  else
    Result := FItem.CalculateDefaultCellHeight(Canvas, Params.Font);
  GridView.DoGetCellHeight(GridRecord, FItem, Self, Result);
end;

function TcxGridTableDataCellViewInfo.CalculateSelected: Boolean;
begin
  Result := GridView.DrawDataCellSelected(GridRecord, FItem, True, Self);
end;

function TcxGridTableDataCellViewInfo.CanActivateEditOnMouseDown(AButton: TMouseButton): Boolean;
begin
  Result := CanShowEdit and
    ((AButton = mbLeft) and HotTrack or GridView.OptionsBehavior.AlwaysShowEditor);
end;

function TcxGridTableDataCellViewInfo.CanShowEdit: Boolean;
begin
  Result := True;
end;

function TcxGridTableDataCellViewInfo.CanShowHint: Boolean;
begin
  Result := GridView.OptionsBehavior.CellHints;
end;

procedure TcxGridTableDataCellViewInfo.CheckEditHotTrack(const AMousePos: TPoint);
var
  AEditViewInfo: TcxCustomEditViewInfo;
begin
  if not GridView.Visible then Exit;
  AEditViewInfo := CreateEditViewInfo;
  try
    CalculateEditViewInfo(AEditViewInfo, AMousePos);
    if FEditViewInfo.Repaint(Control, AEditViewInfo) then
      EditHotTrackChanged;
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

function TcxGridTableDataCellViewInfo.GetAreaBounds: TRect;
begin
  Result := RecordViewInfo.RecordsViewInfo.GetAreaBoundsForCell(Self);
end;

function TcxGridTableDataCellViewInfo.GetAutoHeight: Boolean;
begin
  Result := RecordViewInfo.AutoHeight;
end;

function TcxGridTableDataCellViewInfo.GetCellBoundsForHint: TRect;
begin
  Result := ContentBounds;
end;

function TcxGridTableDataCellViewInfo.GetDisplayValue: TcxEditValue;
begin
  if Properties.GetEditValueSource(False) = evsValue then
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

function TcxGridTableDataCellViewInfo.GetFocused: Boolean;
begin
  Result := FItem.Focused and RecordViewInfo.Focused and (FItem.FocusedCellViewInfo = Self);
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

function TcxGridTableDataCellViewInfo.GetMultiLine: Boolean;
begin
  Result := FItem.MultiLine;
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
begin                                            
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
  GridView.Styles.GetDataCellParams(GridRecord, FItem, Params, True, Self);
end;

function TcxGridTableDataCellViewInfo.HasCustomDraw: Boolean;
begin
  Result := FItem.HasCustomDrawCell or GridView.HasCustomDrawCell;
end;

function TcxGridTableDataCellViewInfo.HasFocusRect: Boolean;
begin
  Result := not GridView.OptionsSelection.InvertSelect and not Editing;
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
begin
  if UseStandardNeedShowHint then
    Result := inherited NeedShowHint(AMousePos, AHintText, AIsHintMultiLine, ATextRect)
  else
    Result := FEditViewInfo.NeedShowHint(Canvas, AMousePos, GetAreaBoundsForHint,
      AHintText, AIsHintMultiLine, ATextRect);
end;

procedure TcxGridTableDataCellViewInfo.Offset(DX, DY: Integer);
begin  
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

function TcxGridTableDataCellViewInfo.SupportsZeroHeight: Boolean;
begin
  Result := False;
end;

function TcxGridTableDataCellViewInfo.UseStandardNeedShowHint: Boolean;
begin
  Result := False;
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
  FEditViewData.Data := GridRecord;
end;

procedure TcxGridTableDataCellViewInfo.DestroyEditViewData;
begin
  FItem.ReleaseEditViewData(FEditViewData, FIsLocalCopyOfEditViewData);
end;

procedure TcxGridTableDataCellViewInfo.UpdateEdit;
begin
  if not Controller.EditingController.EditPreparing then
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
  CalculateEditViewInfo(FEditViewInfo, MousePos);
  Text := GetText;
  if not GridViewInfo.IsInternalUse and Editing then UpdateEdit;
end;

function TcxGridTableDataCellViewInfo.CanDrawSelected: Boolean;
begin
  Result := True;
end;

function TcxGridTableDataCellViewInfo.GetInplaceEditPosition: TcxInplaceEditPosition;
begin
  Result.Item := FItem;
  Result.RecordIndex := RecordViewInfo.GridRecord.RecordIndex;
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
  AGridViewLink: TcxGridListenerLink;
  AItem: TcxCustomGridTableItem;
  AActivateEdit, APostCheckEdit: Boolean;
begin
  FWasFocusedBeforeClick := Focused;
  AGridViewLink := GridView.AddListenerLink;
  try
    AItem := FItem;
    AActivateEdit := CanActivateEditOnMouseDown(AButton);

    APostCheckEdit := False;
    Controller.AllowCheckEdit := False;
    GridView.DontMakeMasterRecordVisible := True;
    GridView.ViewInfo.AddActiveViewInfo(Self);
    try
      if ssDouble in AShift then
      begin
        Result := GridView.DoCellDblClick(Self, AButton, AShift);
        if Result or not AItem.GridView.ViewInfo.IsViewInfoActive(Self) then Exit;
      end;
      Result := inherited MouseDown(AHitTest, AButton, AShift);
      if Result and not AItem.Controller.EditingController.IsErrorOnEditExit then
      begin
        AItem.Focused := True;
        if AItem.Focused then
          if (AButton <> mbMiddle) and (AShift * [ssCtrl, ssShift] = []) and AActivateEdit then
            AItem.Controller.EditingController.ShowEdit(AItem, AShift, AHitTest.Pos.X, AHitTest.Pos.Y)
          else
            AItem.Controller.IsReadyForImmediateEditing := True
        else
          APostCheckEdit := True;
        if AItem.GridView.ViewInfo.IsViewInfoActive(Self) and
          (AItem.Controller.EditingItem <> AItem) then
          AItem.Controller.ClickedCellViewInfo := Self;
      end;
    finally
      if AGridViewLink.GridView <> nil then
      begin
        AItem.GridView.ViewInfo.RemoveActiveViewInfo(Self);
        AItem.GridView.DontMakeMasterRecordVisible := False;
        AItem.Controller.AllowCheckEdit := True;
        if APostCheckEdit then
          AItem.Controller.PostCheckEdit;
      end;
    end;
  finally
    AGridViewLink.Free;
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
  if FItem.Controller.ClickedCellViewInfo = Self then
  begin
    FItem.Controller.ClickedCellViewInfo := nil;
    Result := GridView.DoCellClick(Self, AButton, AShift);
    if Result then Exit;
  end
  else
    Result := False;
  if (AButton = mbLeft) and (AShift * [ssCtrl, ssShift] = []) and
    Focused and CanShowEdit then
  begin
    if not Editing then
      if GridView.OptionsBehavior.ImmediateEditor then
        if Controller.IsReadyForImmediateEditing then
          ShowEdit
        else
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
  if FRecord = nil then
    Result := nil
  else
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

procedure TcxCustomGridRecordViewInfo.SetExpanded(Value: Boolean);
begin
  FRecord.Expanded := Value;
end;

function TcxCustomGridRecordViewInfo.CalculateSelected: Boolean;
begin
  Result := GridView.DrawRecordSelected(GridRecord);
end;

function TcxCustomGridRecordViewInfo.CanGenerateExpandButtonHitTest: Boolean;
begin
  Result := True;
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

function TcxCustomGridRecordViewInfo.GetExpandButtonAreaBounds: TRect;
begin
  Result := cxEmptyRect;
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

function TcxCustomGridRecordViewInfo.GetHideFocusRectOnExit: Boolean;
begin
  Result := GridView.OptionsSelection.HideFocusRectOnExit;
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
  Result := not GridRecord.CanFocusCells or GridView.OptionsSelection.InvertSelect;
end;

procedure TcxCustomGridRecordViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  inherited;
  (AHitTest as TcxGridRecordHitTest).GridRecord := GridRecord;
end;

function TcxCustomGridRecordViewInfo.IsClickHitTest(AHitTest: TcxCustomGridHitTest): Boolean;
begin
  Result := TcxCustomGridTableController(Controller).IsClickableRecordHitTest(AHitTest);
end;

function TcxCustomGridRecordViewInfo.IsDetailVisible(ADetail: TcxCustomGridView): Boolean;
begin
  Result := False;
end;

procedure TcxCustomGridRecordViewInfo.Offset(DX, DY: Integer);
begin 
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
  AGridViewLink: TcxGridListenerLink;
begin
  Result := ssDouble in AShift;
  if not Result then
  begin
    AGridViewLink := GridView.AddListenerLink;
    try
      GridViewInfo.Controller.FocusedRecord := GridRecord;
    finally
      Result := AGridViewLink.GridView <> nil;  {!!!}
      AGridViewLink.Free;
    end;
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
  if CanGenerateExpandButtonHitTest and
    GridRecord.Expandable and PtInRect(ExpandButtonAreaBounds, P) then
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
            Expanded := not Expanded;
            Result := True;
          end;
      end;
  if not Result and (AButton <> mbMiddle) and IsClickHitTest(AHitTest) and
    GridView.Site.IsFocused then
    Result := Click(AHitTest, AButton, AShift);
end;

function TcxCustomGridRecordViewInfo.ProcessDialogChar(ACharCode: Word): Boolean;
begin
  Result := False;
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
    Result := TcxCustomGridRecordViewInfo(FItems[Index]);
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
  if FGridViewInfo.Visible then
    Controller.EditingController.AfterViewInfoCalculate;
end;

procedure TcxCustomGridRecordsViewInfo.BeforeCalculate;
begin
  FBackgroundBitmap := GetBackgroundBitmap;
  if FGridViewInfo.Visible then
    Controller.EditingController.BeforeViewInfoCalculate;
  CreateEditViewDatas;
end;

procedure TcxCustomGridRecordsViewInfo.BeforeItemRecalculation;
begin
  GridViewInfo.UpdateMousePos;
  FIsIncSearchingCellViewInfoCalculated := False;
end;

procedure TcxCustomGridRecordsViewInfo.AfterOffset;
begin
end;

procedure TcxCustomGridRecordsViewInfo.BeforeOffset;
begin
  FIsIncSearchingCellViewInfoCalculated := False;
end;

procedure TcxCustomGridRecordsViewInfo.Calculate;
begin
  FBounds := CalculateBounds;
  FContentBounds := CalculateContentBounds;
end;

function TcxCustomGridRecordsViewInfo.CalculateBounds: TRect;
begin
  Result := FGridViewInfo.ClientBounds;
end;

function TcxCustomGridRecordsViewInfo.CalculateContentBounds: TRect;
begin
  Result := Bounds;
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
begin  
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

function TcxCustomGridRecordsViewInfo.GetAreaBoundsForCell(ACellViewInfo: TcxGridTableDataCellViewInfo): TRect;
begin
  Result := GridViewInfo.ScrollableAreaBounds;
end;

function TcxCustomGridRecordsViewInfo.GetAutoDataRecordHeight: Boolean;
begin
  Result := AutoRecordHeight;
end;

function TcxCustomGridRecordsViewInfo.GetAutoRecordHeight: Boolean;
begin
  Result := GridView.OptionsView.CellAutoHeight or
    GridView.IsGetCellHeightAssigned;
end;

function TcxCustomGridRecordsViewInfo.GetBackgroundBitmap: TBitmap;
begin
  Result := GridView.BackgroundBitmaps.GetBitmap(bbContent);
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

function TcxCustomGridRecordsViewInfo.IsEmpty: Boolean;
begin
  Result := Count = 0;
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
begin  
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

function TcxCustomGridRecordsViewInfo.GetRealItem(ARecord: TcxCustomGridRecord): TcxCustomGridRecordViewInfo;
var
  AIndex: Integer;
begin
  AIndex := GetViewInfoIndex(ARecord.Index);
  if AIndex = -1 then
    Result := nil
  else
    Result := Items[AIndex];
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
    if Count > MaxCount then
        FItems.Count := MaxCount;
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

begin  
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
begin
  OffsetRect(FBounds, DX, DY);
  OffsetRect(FContentBounds, DX, DY);
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

destructor TcxNavigatorSiteViewInfo.Destroy;
begin
  if State <> gcsNone then
    MouseLeave;
  inherited;
end;

function TcxNavigatorSiteViewInfo.GetGridViewInfo: TcxCustomGridTableViewInfo;
begin
  Result := TcxCustomGridTableViewInfo(inherited GridViewInfo);
end;

function TcxNavigatorSiteViewInfo.GetNavigatorViewInfo: TcxNavigatorViewInfo;
begin
  Result := GridViewInfo.NavigatorViewInfo;
end;

function TcxNavigatorSiteViewInfo.CalculateHeight: Integer;
begin
  Result := 0;
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
  FParts := TList.Create;
  inherited;
  FCalculateDown := True;
  FFirstRecordIndex := RecordIndexNone;
end;

destructor TcxCustomGridTableViewInfo.Destroy;
begin
  FreeAndNil(FParts);//.Free;
  inherited;
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

function TcxCustomGridTableViewInfo.GetPart(Index: Integer): TcxCustomGridPartViewInfo;
begin
  Result := TcxCustomGridPartViewInfo(FParts[Index]);
end;

function TcxCustomGridTableViewInfo.GetPartCount: Integer;
begin
  Result := FParts.Count;
end;

function TcxCustomGridTableViewInfo.GetPartsBottomHeight: Integer;
begin
  Result := GetPartsCustomHeight(gpaBottom);
end;

function TcxCustomGridTableViewInfo.GetPartsCustomHeight(AAlignment: TcxGridPartAlignment): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to PartCount - 1 do
    with Parts[I] do
      if Alignment = AAlignment then Inc(Result, Height);
end;

function TcxCustomGridTableViewInfo.GetPartsTopHeight: Integer;
begin
  Result := GetPartsCustomHeight(gpaTop);
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

procedure TcxCustomGridTableViewInfo.AddPart(AItem: TcxCustomGridPartViewInfo);
begin
  FParts.Add(AItem);
end;

procedure TcxCustomGridTableViewInfo.RemovePart(AItem: TcxCustomGridPartViewInfo);
begin
  FParts.Remove(AItem);
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
  Result := GridView.LookAndFeel;
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

procedure TcxCustomGridTableViewInfo.NavigatorChanged(AChangeType: TcxNavigatorChangeType);
const
  ChangeKinds: array[TcxNavigatorChangeType] of TcxGridViewChangeKind = (vcProperty, vcLayout, vcLayout);
begin
  GridView.Changed(ChangeKinds[AChangeType]);
end;

procedure TcxCustomGridTableViewInfo.RefreshNavigator;
var
  AHeight, AWidth: Integer;
begin
  if GridView.IsPattern or (GridView.Control = nil) then Exit;
  FNavigatorViewInfo.MakeIsDirty;
  AWidth := FNavigatorSize.X;
  AHeight := FNavigatorSize.Y;
  FNavigatorViewInfo.CheckSize(AWidth, AHeight);
  if (FNavigatorSize.X <> AWidth) or (FNavigatorSize.Y <> AHeight) then
    GridView.LayoutChanged
  else
    GridView.ViewChanged;
end;

procedure TcxCustomGridTableViewInfo.CreateViewInfos;
begin
  FFilterViewInfo := GetFilterViewInfoClass.Create(Self);
  inherited;
  FNavigatorSiteViewInfo := GetNavigatorSiteViewInfoClass.Create(Self);
  if FNavigatorViewInfo = nil then
    FNavigatorViewInfo := GetNavigatorViewInfoClass.Create(Self);
  FRecordsViewInfo := GetRecordsViewInfoClass.Create(Self);
end;

procedure TcxCustomGridTableViewInfo.DestroyViewInfos(AIsRecreating: Boolean);
begin
  FreeAndNil(FRecordsViewInfo);
  FNavigatorSiteViewInfo.Free;
  FNavigatorSiteViewInfo := nil;
  if not AIsRecreating then
    FreeAndNil(FNavigatorViewInfo);
  inherited;
  FreeAndNil(FFilterViewInfo);
end;

procedure TcxCustomGridTableViewInfo.AfterCalculating;
begin
  inherited;
  if Visible then Controller.PostCheckEdit;
end;

procedure TcxCustomGridTableViewInfo.AfterOffset;
begin
  FRecordsViewInfo.AfterOffset;
end;

procedure TcxCustomGridTableViewInfo.BeforeOffset;
begin
  FRecordsViewInfo.BeforeOffset;
end;

procedure TcxCustomGridTableViewInfo.Calculate;
var
  ANavigatorHeight, ANavigatorWidth: Integer;
begin
  FRecordsViewInfo.MainCalculate;
  inherited;
  if FNavigatorSiteViewInfo.Visible then
  begin
    ANavigatorWidth := 0;
    with GetNavigatorSiteBounds do
      ANavigatorHeight := Bottom - Top;
    FNavigatorViewInfo.CheckSize(ANavigatorWidth, ANavigatorHeight);
    FNavigatorSize := Point(ANavigatorWidth, ANavigatorHeight);
    FNavigatorSiteViewInfo.Calculate(GetNavigatorSiteBounds);
    FNavigatorViewInfo.Calculate;
  end;
end;

function TcxCustomGridTableViewInfo.CalculateClientBounds: TRect;
begin
  Result := inherited CalculateClientBounds;
  Inc(Result.Top, PartsTopHeight);
  Dec(Result.Bottom, PartsBottomHeight);
end;

function TcxCustomGridTableViewInfo.CalculatePartBounds(APart: TcxCustomGridPartViewInfo): TRect;
var
  I: Integer;
begin
  Result := ClientBounds;
  if APart.IsAutoWidth then
  begin
    Result.Left := Bounds.Left;
    Result.Right := Bounds.Right;
  end
  else
    Result.Right := Result.Left + APart.CalculateWidth;
    
  for I := PartCount - 1 downto APart.Index do
    case Parts[I].Alignment of
      gpaTop:
        Dec(Result.Top, Parts[I].Height);
      gpaBottom:
        Inc(Result.Bottom, Parts[I].Height);
    end;
  case APart.Alignment of
    gpaTop:
      Result.Bottom := Result.Top + APart.Height;
    gpaBottom:
      Result.Top := Result.Bottom - APart.Height;
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

function TcxCustomGridTableViewInfo.DoGetHitTest(const P: TPoint): TcxCustomGridHitTest;
var
  I: Integer;
begin
  if PtInRect(Site.ClientBounds, P) then
  begin
    for I := 0 to PartCount - 1 do
      if Parts[I].Visible then
      begin
        Result := Parts[I].GetHitTest(P);
        if Result <> nil then Exit;
      end;
    Result := RecordsViewInfo.GetHitTest(P);
  end
  else
    Result := FNavigatorSiteViewInfo.GetHitTest(P);
  if Result = nil then
    Result := inherited DoGetHitTest(P);
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

function TcxCustomGridTableViewInfo.GetFilterViewInfoClass: TcxGridFilterViewInfoClass;
begin
  Result := TcxGridFilterViewInfo;
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

function TcxCustomGridTableViewInfo.GetNoDataInfoTextAreaBounds: TRect;
begin
  if IsRectEmpty(RecordsViewInfo.ContentBounds) then
    Result := ClientBounds
  else
    IntersectRect(Result, ClientBounds, RecordsViewInfo.ContentBounds);
end;

procedure TcxCustomGridTableViewInfo.GetNoDataInfoTextParams(out AParams: TcxViewParams);
begin
  GridView.Styles.GetViewParams(vsBackground, nil, nil, AParams);
end;

function TcxCustomGridTableViewInfo.GetNoDataInfoTextAreaVisible: Boolean;
begin
  Result := RecordsViewInfo.IsEmpty;
end;

function TcxCustomGridTableViewInfo.GetNonRecordsAreaHeight(ACheckScrollBar: Boolean): Integer;
begin
  Result := PartsTopHeight + PartsBottomHeight;
  if ACheckScrollBar then AddScrollBarHeight(Result);
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
begin  
  RecordsViewInfo.Offset(ARecordCountDelta);
end;

procedure TcxCustomGridTableViewInfo.Offset(DX, DY: Integer);
begin    
  RecordsViewInfo.Offset(DX, DY);
end;

procedure TcxCustomGridTableViewInfo.VisibilityChanged(AVisible: Boolean);
begin
  RecordsViewInfo.VisibilityChanged(AVisible);
  inherited;  // should be here for correct hiding (focus)
end;

function TcxCustomGridTableViewInfo.CanOffset(ARecordCountDelta, DX, DY: Integer): Boolean;
begin
  Result := True;
end;

function TcxCustomGridTableViewInfo.CanOffsetView(ARecordCountDelta: Integer): Boolean;
begin
  Result := RecordsViewInfo.CanOffset(ARecordCountDelta);
end;

procedure TcxCustomGridTableViewInfo.DoOffset(ARecordCountDelta, DX, DY: Integer);
begin  
  if CanOffset(ARecordCountDelta, DX, DY) then
  begin
    Controller.BeforeOffset;
    BeforeOffset;
    if ARecordCountDelta <> 0 then
      Offset(ARecordCountDelta)
    else
      Offset(DX, DY);
    AfterOffset;
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
  FIsHeightAssigned := True;
end;

procedure TcxCustomGridTableViewInfoCacheItem.UnassignValues(AKeepMaster: Boolean);
begin
  inherited;
  FIsHeightAssigned := False;
end;

{ TcxCustomGridTableViewInfoCache }

function TcxCustomGridTableViewInfoCache.GetViewData: TcxCustomGridTableViewData;
begin
  Result := TcxCustomGridTableViewData(inherited ViewData);
end;

function TcxCustomGridTableViewInfoCache.GetItemClass(Index: Integer): TcxCustomGridViewInfoCacheItemClass;
begin
  Result := ViewData.Records[Index].GetViewInfoCacheItemClass;
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

procedure TcxCustomGridTableItemCustomOptions.Changed(AChange: TcxGridTableItemChange = ticLayout);
begin
  FItem.Changed(AChange);
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
  FFilteringMRUItemsList := True;
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
    Changed(ticProperty);
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

procedure TcxCustomGridTableItemOptions.SetFilteringMRUItemsList(Value: Boolean);
begin
  if FFilteringMRUItemsList <> Value then
  begin
    FFilteringMRUItemsList := Value;
    Changed(ticProperty);
  end;
end;

procedure TcxCustomGridTableItemOptions.SetFocusing(Value: Boolean);
begin
  if FFocusing <> Value then
  begin
    FFocusing := Value;
    if not FFocusing then Item.Focused := False;
    Changed(ticProperty);
  end;
end;

procedure TcxCustomGridTableItemOptions.SetGrouping(Value: Boolean);
begin
  if FGrouping <> Value then
  begin
    FGrouping := Value;
    Changed(ticProperty);
  end;
end;

procedure TcxCustomGridTableItemOptions.SetIncSearch(Value: Boolean);
begin
  if FIncSearch <> Value then
  begin
    if not Value and Item.IncSearching then
      GridView.Controller.CancelIncSearching;
    FIncSearch := Value;
    Changed(ticProperty);
  end;
end;

procedure TcxCustomGridTableItemOptions.SetMoving(Value: Boolean);
begin
  if FMoving <> Value then
  begin
    FMoving := Value;
    Changed(ticProperty);
  end;
end;

procedure TcxCustomGridTableItemOptions.SetShowEditButtons(Value: TcxGridItemShowEditButtons);
begin
  if FShowEditButtons <> Value then
  begin
    FShowEditButtons := Value;
    Changed(ticSize);
  end;
end;

procedure TcxCustomGridTableItemOptions.SetSortByDisplayText(Value: TcxGridItemSortByDisplayText);
begin
  if FSortByDisplayText <> Value then
  begin
    FSortByDisplayText := Value;
    GridView.DataController.SortByDisplayTextChanged;
  end;
end;

procedure TcxCustomGridTableItemOptions.SetSorting(Value: Boolean);
begin
  if FSorting <> Value then
  begin
    FSorting := Value;
    Changed(ticProperty);
  end;
end;

procedure TcxCustomGridTableItemOptions.Assign(Source: TPersistent);
begin
  if Source is TcxCustomGridTableItemOptions then
    with TcxCustomGridTableItemOptions(Source) do
    begin
      Self.Editing := Editing;
      Self.Filtering := Filtering;
      Self.FilteringMRUItemsList := FilteringMRUItemsList;
      Self.Focusing := Focusing;
      Self.Grouping := Grouping;
      Self.IncSearch := IncSearch;
      Self.Moving := Moving;
      Self.ShowEditButtons := ShowEditButtons;
      Self.SortByDisplayText := SortByDisplayText;
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

procedure TcxCustomGridTableItemStyles.SetOnGetContentStyle(Value: TcxGridGetCellStyleEvent);
begin
  if @FOnGetContentStyle <> @Value then
  begin
    FOnGetContentStyle := Value;
    Item.Changed(ticProperty);
  end;
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
  if not GridView.IsDestroying and GridView.IsDesigning then
    Controller.DesignController.UnselectObject(Self);
  RepositoryItem := nil;
  FGridView.RemoveItem(Self);
  {if FLastUsedDefaultRepositoryItem <> nil then
    ItemRemoved(FLastUsedDefaultRepositoryItem);}
  DestroySubClasses;
  FreeAndNil(FEditData);
  FreeAndNil(FCellStyle);
  for I := 0 to CellCount - 1 do Cells[I].FItem := nil;
  FCells.Free;
  inherited;
end;

function TcxCustomGridTableItem.GetActualMinWidth: Integer;
begin
  if HasFixedWidth then
    Result := 0
  else
    Result := FMinWidth;
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
  Result := TcxGridTableDataCellViewInfo(FCells[Index]);
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
    Result := Controller.EditingController.Edit.ActiveProperties
  else
    Result := GetPropertiesForEdit;
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

function TcxCustomGridTableItem.GetIsReading: Boolean;
begin
  Result := csReading in ComponentState;
end;

function TcxCustomGridTableItem.GetIsUpdating: Boolean;
begin
  Result := csUpdating in ComponentState;
end;

function TcxCustomGridTableItem.GetMinWidth: Integer;
begin
  if HasFixedWidth then
    Result := Width
  else
    Result := FMinWidth;
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

function TcxCustomGridTableItem.GetTag: TcxTag;
begin
  Result := inherited Tag;
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

procedure TcxCustomGridTableItem.SetBestFitMaxWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FBestFitMaxWidth <> Value then
  begin
    FBestFitMaxWidth := Value;
    Changed(ticProperty);
  end;
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
  if FGridView.IsAssigningItems and (Value <> -1) then
    FGridView.AssigningGroupedItems[Value] := Self
  else
    ChangeGroupIndex(Value);
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

procedure TcxCustomGridTableItem.SetHidden(Value: Boolean);
begin
  if Hidden <> Value then
  begin
    FHidden := Value;
    HiddenChanged;
  end;
end;

procedure TcxCustomGridTableItem.SetIndex(Value: Integer);
begin
  if FGridView.IsRestoring then
    FGridView.RestoringItems[Value] := Self
  else
    FGridView.ChangeItemIndex(Self, Value);
end;

procedure TcxCustomGridTableItem.SetMinWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FMinWidth <> Value then
  begin
    FMinWidth := Value;
    if IsLoading then Exit;
    if Width < FMinWidth then
      Width := FMinWidth
    else
      Changed(ticSize);
  end;
end;

procedure TcxCustomGridTableItem.SetOnCustomDrawCell(Value: TcxGridTableDataCellCustomDrawEvent);
begin
  if @FOnCustomDrawCell <> @Value then
  begin
    FOnCustomDrawCell := Value;
    Changed(ticProperty);
  end;
end;

procedure TcxCustomGridTableItem.SetOnGetDataText(Value: TcxGridGetDataTextEvent);
begin
  if @FOnGetDataText <> @Value then
  begin
    FOnGetDataText := Value;
    Changed(ticProperty);
  end;
end;

procedure TcxCustomGridTableItem.SetOnGetDisplayText(Value: TcxGridGetDisplayTextEvent);
begin
  if @FOnGetDisplayText <> @Value then
  begin
    FOnGetDisplayText := Value;
    Changed(ticProperty);
  end;
end;

procedure TcxCustomGridTableItem.SetOnGetFilterDisplayText(Value: TcxGridGetFilterDisplayTextEvent);
begin
  if @FOnGetFilterDisplayText <> @Value then
  begin
    FOnGetFilterDisplayText := Value;
    Changed(ticProperty);
  end;
end;

procedure TcxCustomGridTableItem.SetOnGetFilterValues(Value: TcxGridGetFilterValuesEvent);
begin
  if @FOnGetFilterValues <> @Value then
  begin
    FOnGetFilterValues := Value;
    Changed(ticProperty);
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

procedure TcxCustomGridTableItem.SetOnGetPropertiesForEdit(Value: TcxGridGetPropertiesEvent);
begin
  if @FOnGetPropertiesForEdit <> @Value then
  begin
    FOnGetPropertiesForEdit := Value;
    Changed(ticProperty);
  end;
end;

procedure TcxCustomGridTableItem.SetOnGetStoredProperties(Value: TcxGridTableItemGetStoredPropertiesEvent);
begin
  if @FOnGetStoredProperties <> @Value then
  begin
    FOnGetStoredProperties := Value;
    Changed(ticProperty);
  end;
end;

procedure TcxCustomGridTableItem.SetOnGetStoredPropertyValue(Value: TcxGridTableItemGetStoredPropertyValueEvent);
begin
  if @FOnGetStoredPropertyValue <> @Value then
  begin
    FOnGetStoredPropertyValue := Value;
    Changed(ticProperty);
  end;
end;

procedure TcxCustomGridTableItem.SetOnSetStoredPropertyValue(Value: TcxGridTableItemSetStoredPropertyValueEvent);
begin
  if @FOnSetStoredPropertyValue <> @Value then
  begin
    FOnSetStoredPropertyValue := Value;
    Changed(ticProperty);
  end;
end;

procedure TcxCustomGridTableItem.SetOnUserFiltering(Value: TcxGridUserFilteringEvent);
begin
  if @FOnUserFiltering <> @Value then
  begin
    FOnUserFiltering := Value;
    Changed(ticProperty);
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
  if FGridView.IsAssigningItems and (Value <> -1) then
    FGridView.AssigningSortedItems[Value] := Self
  else
    ChangeSortIndex(Value);
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

procedure TcxCustomGridTableItem.SetTag(Value: TcxTag);
begin
  if Tag <> Value then
  begin
    inherited Tag := Value;
    Changed(ticProperty);
  end;
end;

procedure TcxCustomGridTableItem.SetVisible(Value: Boolean);
begin
  if Visible <> Value then
  begin
    FVisible := Value;
    GridView.ItemVisibilityChanged(Self, Value);
  end;
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

function TcxCustomGridTableItem.IsSortOrderStored: Boolean;
begin
  Result := (SortOrder <> soNone) and (SortIndex <> -1);
end;

function TcxCustomGridTableItem.IsTagStored: Boolean;
begin
  Result := Tag <> 0;
end;

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
    FProperties.OnPropertiesChanged := PropertiesChangedHandler;
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

procedure TcxCustomGridTableItem.RepositoryItemPropertiesChanged(Sender: TcxEditRepositoryItem);
begin
  if not GridView.IsPattern then PropertiesChanged;
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
    Add('SortOrder');
    Add('SortIndex');
    Add('WasVisibleBeforeGrouping');
  end;
  if Assigned(FOnGetStoredProperties) then
    FOnGetStoredProperties(Self, AProperties);
  Result := True;
end;

procedure TcxCustomGridTableItem.GetPropertyValue(const AName: string; var AValue: Variant);
begin
  if AName = 'AlignmentHorz' then
    AValue := Variant(GetProperties.Alignment.Horz)
  else
    if AName = 'Index' then
      AValue := Index
    else
      if AName = 'Visible' then
        AValue := Visible
      else
        if AName = 'SortOrder' then
          AValue := Variant(SortOrder)
        else
          if AName = 'SortIndex' then
            AValue := SortIndex
          else
            if AName = 'WasVisibleBeforeGrouping' then
              AValue := WasVisibleBeforeGrouping
            else
              if Assigned(FOnGetStoredPropertyValue) then
                FOnGetStoredPropertyValue(Self, AName, AValue);
end;

procedure TcxCustomGridTableItem.SetPropertyValue(const AName: string; const AValue: Variant);
begin
  if AName = 'AlignmentHorz' then
    if GetProperties.Alignment.Horz <> TAlignment((AValue)) then
    begin
      if (FRepositoryItem = nil) and (FProperties = nil) then
        PropertiesClass := TcxCustomEditPropertiesClass(GetProperties.ClassType);
      GetProperties.Alignment.Horz := TAlignment((AValue));
    end
    else
  else
    if AName = 'Index' then
      Index := AValue
    else
      if AName = 'Visible' then
        Visible := AValue
      else
        if AName = 'SortOrder' then
          SortOrder := TcxDataSortOrder((AValue))
        else
          if AName = 'SortIndex' then
            SortIndex := AValue
          else
            if AName = 'WasVisibleBeforeGrouping' then
              FWasVisibleBeforeGrouping := AValue
            else
              if Assigned(FOnSetStoredPropertyValue) then
                FOnSetStoredPropertyValue(Self, AName, AValue);
end;

procedure TcxCustomGridTableItem.CreateDataBinding;
begin
  FDataBinding := GetDataBindingClass.Create(Self);
  with FDataBinding do
    ValueTypeClass := GetDefaultValueTypeClass;
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

procedure TcxCustomGridTableItem.BestFitApplied(AFireEvents: Boolean);
begin
  Controller.DesignerModified;
end;

function TcxCustomGridTableItem.CalculateBestFitWidth: Integer;
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
    AEditViewData.InplaceEditParams.Position.Item := Self;

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
        AEditViewData.InplaceEditParams.Position.RecordIndex := ARecord.RecordIndex;
        AEditViewData.Data := ARecord;
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

function TcxCustomGridTableItem.CanAutoHeight: Boolean;
begin
  Result := esoAutoHeight in GetProperties.GetSupportedOperations;
end;

function TcxCustomGridTableItem.CanEdit: Boolean;
begin
  Result := CanFocus(Controller.FocusedRecord) and GridView.OptionsData.Editing and
    FOptions.Editing and (FocusedCellViewInfo <> nil) and
    (dceoShowEdit in DataController.EditOperations);
end;

function TcxCustomGridTableItem.CanFilter(ACheckGridViewOptions: Boolean): Boolean;
begin
  Result :=
    (esoFiltering in GetProperties.GetSupportedOperations) and FOptions.Filtering and
    (not ACheckGridViewOptions or GridView.OptionsCustomize.ItemFiltering);
end;

function TcxCustomGridTableItem.CanFilterMRUValueItems: Boolean;
begin
  Result := GridView.Filtering.ItemMRUItemsList and FOptions.FilteringMRUItemsList;
end;

function TcxCustomGridTableItem.CanFocus(ARecord: TcxCustomGridRecord): Boolean;
begin
  Result := ActuallyVisible and FOptions.Focusing and
    ((ARecord = nil) and GridView.OptionsSelection.CellSelect or
     (ARecord <> nil) and ARecord.CanFocusCells);
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
  Result := not HasFixedWidth;
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
  if ActuallyVisible or (GroupIndex <> -1) then
    Changed(ticLayout)
  else
    Changed(ticProperty);
  GridView.RefreshCustomizationForm;
end;

procedure TcxCustomGridTableItem.Changed(AChange: TcxGridTableItemChange);
begin
  if GridView <> nil then
    GridView.Changed(TcxGridViewChangeKind(AChange));
end;

procedure TcxCustomGridTableItem.ChangeGroupIndex(Value: Integer);
begin
  if GroupIndex <> Value then
  begin
    ShowHourglassCursor;
    try
      if (GroupIndex = -1) and not GridView.IsAfterAssigningItems then
        FWasVisibleBeforeGrouping := Visible;
      DataController.Groups.ChangeGrouping(Index, Value);
    finally
      HideHourglassCursor;
    end;
  end;
end;

procedure TcxCustomGridTableItem.ChangeSortIndex(Value: Integer);
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
begin
  Result := CalculateBestFitWidth;
  if (FBestFitMaxWidth <> 0) and (Result > FBestFitMaxWidth) then
    Result := FBestFitMaxWidth;
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
  Result := CanFilter(False){ and not Hidden};
end;

procedure TcxCustomGridTableItem.GetFilterDisplayText(const AValue: Variant;
  var ADisplayText: string);
begin
  if Assigned(FOnGetFilterDisplayText) then
    FOnGetFilterDisplayText(Self, AValue, ADisplayText);
end;

function TcxCustomGridTableItem.GetFixed: Boolean;
begin
  Result := (Controller.ForcingWidthItem = Self) or HasFixedWidth;
end;

function TcxCustomGridTableItem.GetFocusedCellViewInfo: TcxGridTableDataCellViewInfo;
begin
  with Controller do
    if FocusedRecordHasCells(False) and (FocusedRecord.ViewInfo <> nil) then
      Result := FocusedRecord.ViewInfo.GetCellViewInfoByItem(Self)
    else
      Result := nil;
end;

function TcxCustomGridTableItem.GetHidden: Boolean;
begin
  Result := FHidden;
end;

function TcxCustomGridTableItem.GetMultiLine: Boolean;
begin
  Result := False;
end;

function TcxCustomGridTableItem.GetPropertiesForEdit: TcxCustomEditProperties;
begin
  Result := GetProperties(Controller.FocusedRecord);
  DoGetPropertiesForEdit(Controller.FocusedRecord, Result);
  InitProperties(Result);
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

function TcxCustomGridTableItem.GetVisibleCaption: string;
begin
  Result := Caption;
end;

function TcxCustomGridTableItem.GetVisibleIndex: Integer;
begin
  Result := FGridView.FVisibleItems.IndexOf(Self);
end;

function TcxCustomGridTableItem.GetVisibleInQuickCustomizationPopup: Boolean;
begin
  Result := not Hidden;
end;

function TcxCustomGridTableItem.HasCustomDrawCell: Boolean;
begin
  Result := Assigned(FOnCustomDrawCell);
end;

function TcxCustomGridTableItem.HasFixedWidth: Boolean;
begin
  Result := False;
end;

procedure TcxCustomGridTableItem.HiddenChanged;
begin
  with FGridView do
  begin
    //RefreshFilterableItemsList;
    RefreshCustomizationForm;
  end;
  Changed(ticProperty);
end;

procedure TcxCustomGridTableItem.InitProperties(AProperties: TcxCustomEditProperties);
begin
  if AProperties <> nil then
    with AProperties do
    begin
      LockUpdate(True);
      IDefaultValuesProvider := GetDefaultValuesProvider(AProperties);
      LockUpdate(False);
    end;
end;

function TcxCustomGridTableItem.IsHiddenStored: Boolean;
begin
  Result := Hidden;
end;

function TcxCustomGridTableItem.IsSortingByDisplayText(ASortByDisplayText: Boolean): Boolean;
begin
  if FOptions.SortByDisplayText = isbtDefault then
    Result := HasDataTextHandler or ASortByDisplayText and
      (esoSortingByDisplayText in GetProperties.GetSupportedOperations)
  else
    Result := FOptions.SortByDisplayText = isbtOn;
end;
    
function TcxCustomGridTableItem.IsVisibleStored: Boolean;
begin
  Result := True;
end;

procedure TcxCustomGridTableItem.PropertiesChanged;
begin
  if GridView.PatternGridView.IgnorePropertiesChanges then Exit;
  if not IsDestroying then
    GridView.RefreshFilterableItemsList;
  if FEditData <> nil then FEditData.Clear;
  if not IsDestroying and not DataController.ItemPropertiesChanged(Index) then
    Changed(ticSize);
end;

procedure TcxCustomGridTableItem.PropertiesChangedHandler(Sender: TObject);
begin
  if not GridView.IsPattern then PropertiesChanged;
end;

procedure TcxCustomGridTableItem.PropertiesValueChanged;
begin
  FPropertiesValue := GetPropertiesValue;
  if not IsDestroying and (FPropertiesValue <> nil) then
    DataController.SortByDisplayTextChanged;  // for Options.SortByDisplayText = isbtDefault
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
  FDataBinding.FilterMRUValueItems.ClearItems;
  PropertiesValueChanged;
  if FProperties <> nil then
    FProperties.Changed;
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
  const AParams: TcxViewParams; AFocused: Boolean);
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
  begin
    Result := AProperties.CreateViewData(GetCellStyle, True);
    Result.OnGetDisplayText := EditViewDataGetDisplayTextHandler;
  end
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

procedure TcxCustomGridTableItem.EditViewDataGetDisplayTextHandler(Sender: TcxCustomEditViewData;
  var AText: string);
var
  AGridRecord: TcxCustomGridRecord;
begin
  if Sender.Data is TcxCustomGridRecord then
    AGridRecord := TcxCustomGridRecord(Sender.Data)
  else
    AGridRecord := nil;
  DoGetDisplayText(AGridRecord, AText);
end;

function TcxCustomGridTableItem.GetEditViewData(AProperties: TcxCustomEditProperties;
  out AIsLocalCopy: Boolean): TcxCustomEditViewData;
begin
  AIsLocalCopy := HasCustomPropertiesHandler or (FEditViewData = nil);
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

procedure TcxCustomGridTableItem.DoGetDataText(ARecordIndex: Integer;
  var AText: string);
begin
  if HasDataTextHandler then FOnGetDataText(Self, ARecordIndex, AText);
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
  if HasCustomPropertiesHandler then FOnGetProperties(Self, ARecord, Result);
end;

procedure TcxCustomGridTableItem.DoGetPropertiesForEdit(ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  if HasCustomPropertiesForEditHandler then
    FOnGetPropertiesForEdit(Self, ARecord, AProperties);
end;

procedure TcxCustomGridTableItem.DoUserFiltering(const AValue: Variant; const ADisplayText: string);
begin
  if Assigned(FOnUserFiltering) then FOnUserFiltering(Self, AValue, ADisplayText);
end;

function TcxCustomGridTableItem.HasDataTextHandler: Boolean;
begin
  Result := Assigned(FOnGetDataText);
end;

function TcxCustomGridTableItem.HasCustomPropertiesForEditHandler: Boolean;
begin
  Result := Assigned(FOnGetPropertiesForEdit);
end;

function TcxCustomGridTableItem.HasCustomPropertiesHandler: Boolean;
begin
  Result := Assigned(FOnGetProperties);
end;

procedure TcxCustomGridTableItem.Assign(Source: TPersistent);
begin                         
  if Source is TcxCustomGridTableItem then
    with TcxCustomGridTableItem(Source) do
    begin
      Self.BestFitMaxWidth := BestFitMaxWidth;
      Self.DataBinding := DataBinding;
      Self.FIsCaptionAssigned := FIsCaptionAssigned;
      Self.Caption := Caption;
      Self.GroupIndex := GroupIndex;
      Self.FIsHeaderAlignmentHorzAssigned := FIsHeaderAlignmentHorzAssigned;
      Self.HeaderAlignmentHorz := HeaderAlignmentHorz;
      Self.FIsHeaderAlignmentVertAssigned := FIsHeaderAlignmentVertAssigned;
      Self.HeaderAlignmentVert := HeaderAlignmentVert;
      Self.Hidden := Hidden;
      Self.MinWidth := MinWidth;
      Self.Options := Options;
      Self.PropertiesClass := PropertiesClass;
      Self.Properties := Properties;
      Self.RepositoryItem := RepositoryItem;
      Self.SortOrder := SortOrder;
      Self.SortIndex := SortIndex;
      Self.Styles := Styles;
      Self.Tag := Tag;
      Self.Visible := Visible;
      Self.FIsWidthAssigned := FIsWidthAssigned;
      Self.Width := Width;
      Self.OnCustomDrawCell := OnCustomDrawCell;
      Self.OnGetDataText := OnGetDataText;
      Self.OnGetDisplayText := OnGetDisplayText;
      Self.OnGetFilterDisplayText := OnGetFilterDisplayText;
      Self.OnGetFilterValues := OnGetFilterValues;
      Self.OnGetProperties := OnGetProperties;
      Self.OnGetPropertiesForEdit := OnGetPropertiesForEdit;
      Self.OnGetStoredProperties := OnGetStoredProperties;
      Self.OnGetStoredPropertyValue := OnGetStoredPropertyValue;
      Self.OnSetStoredPropertyValue := OnSetStoredPropertyValue;
      Self.OnUserFiltering := OnUserFiltering;
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

procedure TcxCustomGridTableItem.ApplyBestFit(ACheckSizingAbility: Boolean = False;
  AFireEvents: Boolean = False);
begin
  if GridView.IsPattern or ACheckSizingAbility and not CanHorzSize then Exit;
  ShowHourglassCursor;
  try
    ForceWidth(GetBestFitWidth);
    Changed(ticSize);
  finally
    HideHourglassCursor;
    BestFitApplied(AFireEvents);
  end;
end;

function TcxCustomGridTableItem.CalculateDefaultCellHeight(ACanvas: TcxCanvas;
  AFont: TFont): Integer;
var
  AEditStyle: TcxEditStyle;
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
    Result.LookAndFeel.MasterLookAndFeel := GridView.LookAndFeel;
end;

procedure TcxCustomGridTableItem.FocusWithSelection;
begin
  Focused := True;
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
  FIsHeaderAlignmentHorzAssigned := False;
  FIsHeaderAlignmentVertAssigned := False;
  FIsWidthAssigned := False;
  Changed(ticSize);
end;

{ TcxCustomGridTableBackgroundBitmaps }

function TcxCustomGridTableBackgroundBitmaps.GetBitmapStyleIndex(Index: Integer): Integer;
begin
  case Index of
    bbContent:
      Result := vsContent;
    bbFilterBox:
      Result := vsFilterBox;
  else
    Result := inherited GetBitmapStyleIndex(Index);
  end;  
end;

procedure TcxCustomGridTableBackgroundBitmaps.Assign(Source: TPersistent);
begin
  if Source is TcxCustomGridTableBackgroundBitmaps then
    with TcxCustomGridTableBackgroundBitmaps(Source) do
    begin
      Self.Content := Content;
      Self.FilterBox := FilterBox;
    end;
  inherited;
end;

{ TcxGridFilterMRUItem }

function GetFilterStream(AFilter: TcxDataFilterCriteria): TMemoryStream;
begin
  Result := TMemoryStream.Create;
  AFilter.WriteData(Result);
end;

constructor TcxGridFilterMRUItem.Create(AFilter: TcxDataFilterCriteria);
begin
  inherited Create;
  Filter := AFilter.DataController.CreateFilter;
  Filter.Assign(AFilter);
end;

destructor TcxGridFilterMRUItem.Destroy;
begin
  Filter.Free;
  inherited;
end;

function TcxGridFilterMRUItem.GetCaption: string;
begin
  Result := Filter.FilterCaption;
end;

function TcxGridFilterMRUItem.StreamEquals(AStream: TMemoryStream): Boolean;
var
  AOwnStream: TMemoryStream;
begin
  AOwnStream := GetStream;
  try
    Result := StreamsEqual(AOwnStream, AStream);
  finally
    AStream.Free;
    AOwnStream.Free;
  end;
end;

procedure TcxGridFilterMRUItem.AssignTo(AFilter: TcxDataFilterCriteria);
begin
  AFilter.AssignItems(Filter);
end;

function TcxGridFilterMRUItem.Equals(AItem: TcxMRUItem): Boolean;
begin
  Result := StreamEquals(TcxGridFilterMRUItem(AItem).GetStream);
end;

function TcxGridFilterMRUItem.FilterEquals(AFilter: TcxDataFilterCriteria): Boolean;
begin
  Result := StreamEquals(GetFilterStream(AFilter));
end;

function TcxGridFilterMRUItem.GetStream: TMemoryStream;
begin
  Result := GetFilterStream(Filter);
end;

{ TcxGridFilterMRUItems }

constructor TcxGridFilterMRUItems.Create(AFiltering: TcxCustomGridTableFiltering);
begin
  inherited Create;
  FFiltering := AFiltering;
  FVisibleItems := TList.Create;
end;

destructor TcxGridFilterMRUItems.Destroy;
begin
  FVisibleItems.Free;
  inherited;
end;

function TcxGridFilterMRUItems.GetItem(Index: Integer): TcxGridFilterMRUItem;
begin
  Result := TcxGridFilterMRUItem(inherited Items[Index]);
end;

function TcxGridFilterMRUItems.GetVisibleCount: Integer;
begin
  Result := FVisibleItems.Count;
end;

function TcxGridFilterMRUItems.GetVisibleItem(Index: Integer): TcxGridFilterMRUItem;
begin
  Result := TcxGridFilterMRUItem(FVisibleItems[Index]);
end;

procedure TcxGridFilterMRUItems.DeleteEmptyItems;
var
  APrevCount, I: Integer;
begin
  APrevCount := Count;
  for I := Count - 1 downto 0 do
    if Items[I].Filter.IsEmpty then
      Delete(I);
  if Count <> APrevCount then
    RefreshVisibleItemsList;
end;

procedure TcxGridFilterMRUItems.FilterChanged;
begin
  RefreshVisibleItemsList;
end;

procedure TcxGridFilterMRUItems.RefreshVisibleItemsList;
var
  APrevVisibleCount: Integer;
  AFilter: TcxDataFilterCriteria;
  I: Integer;
  AItem: TcxGridFilterMRUItem;
begin
  APrevVisibleCount := VisibleCount;
  AFilter := FFiltering.GridView.DataController.Filter;
  FVisibleItems.Clear;
  for I := 0 to Count - 1 do
  begin
    AItem := Items[I];
    if not AItem.FilterEquals(AFilter) then FVisibleItems.Add(AItem);
  end;
  if VisibleCount <> APrevVisibleCount then
    FFiltering.MRUItemsVisibleCountChanged(APrevVisibleCount, VisibleCount);
end;

procedure TcxGridFilterMRUItems.Add(AFilter: TcxDataFilterCriteria);
begin
  if not AFilter.IsEmpty then
  begin
    inherited Add(TcxGridFilterMRUItem.Create(AFilter));
    RefreshVisibleItemsList;
  end;
end;

{ TcxGridFilterBox }

constructor TcxGridFilterBox.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FCustomizeDialog := True;
  FPosition := fpBottom;
  FVisible := fvNonEmpty;
end;

procedure TcxGridFilterBox.SetCustomizeDialog(Value: Boolean);
begin
  if FCustomizeDialog <> Value then
  begin
    FCustomizeDialog := Value;
    Changed(vcLayout);
  end;
end;

procedure TcxGridFilterBox.SetMRUItemsListDropDownCount(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FMRUItemsListDropDownCount <> Value then
  begin
    FMRUItemsListDropDownCount := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxGridFilterBox.SetPosition(Value: TcxGridFilterPosition);
begin
  if FPosition <> Value then
  begin
    FPosition := Value;
    Changed(vcLayout);
  end;
end;

procedure TcxGridFilterBox.SetVisible(Value: TcxGridFilterVisible);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridFilterBox.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TcxGridFilterBox then
    with TcxGridFilterBox(Source) do
    begin
      Self.CustomizeDialog := CustomizeDialog;
      Self.MRUItemsListDropDownCount := MRUItemsListDropDownCount;
      Self.Position := Position;
      Self.Visible := Visible;
    end;
end;

{ TcxCustomGridTableFiltering }

constructor TcxCustomGridTableFiltering.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FItemMRUItemsList := True;
  FItemMRUItemsListCount := cxGridFilterDefaultItemMRUItemsListCount;
  FItemPopupMaxDropDownItemCount := cxGridFilterDefaultItemPopupMaxDropDownItemCount;
  FMRUItems := GetMRUItemsClass.Create(Self);
  FMRUItemsList := True;
  FMRUItemsListCount := cxGridFilterDefaultMRUItemsListCount;
end;

destructor TcxCustomGridTableFiltering.Destroy;
begin
  FMRUItems.Free;
  inherited;
end;

function TcxCustomGridTableFiltering.GetCustomizeDialog: Boolean;
begin
  Result := GridView.FilterBox.CustomizeDialog;
end;

function TcxCustomGridTableFiltering.GetGridView: TcxCustomGridTableView;
begin
  Result := TcxCustomGridTableView(inherited GridView);
end;

function TcxCustomGridTableFiltering.GetMRUItemsListDropDownCount: Integer;
begin
  Result := GridView.FilterBox.MRUItemsListDropDownCount;
end;

function TcxCustomGridTableFiltering.GetPosition: TcxGridFilterPosition;
begin
  Result := GridView.FilterBox.Position;
end;

function TcxCustomGridTableFiltering.GetVisible: TcxGridFilterVisible;
begin
  Result := GridView.FilterBox.Visible;
end;

procedure TcxCustomGridTableFiltering.SetCustomizeDialog(Value: Boolean);
begin
  GridView.FilterBox.CustomizeDialog := Value;
end;

procedure TcxCustomGridTableFiltering.SetItemMRUItemsList(Value: Boolean);
begin
  if FItemMRUItemsList <> Value then
  begin
    FItemMRUItemsList := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableFiltering.SetItemMRUItemsListCount(Value: Integer);
var
  I: Integer;
begin
  if Value < 0 then Value := 0;
  if FItemMRUItemsListCount <> Value then
  begin
    FItemMRUItemsListCount := Value;
    for I := 0 to GridView.ItemCount - 1 do
      GridView.Items[I].DataBinding.FilterMRUValueItems.MaxCount := FItemMRUItemsListCount;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableFiltering.SetItemPopupDropDownWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FItemPopupDropDownWidth <> Value then
  begin
    FItemPopupDropDownWidth := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableFiltering.SetItemPopupMaxDropDownItemCount(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FItemPopupMaxDropDownItemCount <> Value then
  begin
    FItemPopupMaxDropDownItemCount := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableFiltering.SetMRUItemsList(Value: Boolean);
begin
  if FMRUItemsList <> Value then
  begin
    FMRUItemsList := Value;
    Changed(vcSize);
  end;
end;

procedure TcxCustomGridTableFiltering.SetMRUItemsListCount(Value: Integer);

  function GetMRUItemsMaxCount: Integer;
  begin
    Result := FMRUItemsListCount;
    if Result <> 0 then Inc(Result);  // for current filter
  end;

begin
  if Value < 0 then Value := 0;
  if FMRUItemsListCount <> Value then
  begin
    FMRUItemsListCount := Value;
    FMRUItems.MaxCount := GetMRUItemsMaxCount;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableFiltering.SetMRUItemsListDropDownCount(Value: Integer);
begin
  GridView.FilterBox.MRUItemsListDropDownCount := Value;
end;

procedure TcxCustomGridTableFiltering.SetPosition(Value: TcxGridFilterPosition);
begin
  GridView.FilterBox.Position := Value;
end;

procedure TcxCustomGridTableFiltering.SetVisible(Value: TcxGridFilterVisible);
begin
  GridView.FilterBox.Visible := Value;
end;

procedure TcxCustomGridTableFiltering.FilterControlDialogApply(Sender: TObject);
begin
  GridView.DataController.Filter.Active := True;
  AddFilterToMRUItems;
end;

procedure TcxCustomGridTableFiltering.ReadCustomizeDialog(Reader: TReader);
begin
  CustomizeDialog := Reader.ReadBoolean;
end;

procedure TcxCustomGridTableFiltering.ReadDropDownWidth(Reader: TReader);
begin
  DropDownWidth := Reader.ReadInteger;
end;

procedure TcxCustomGridTableFiltering.ReadMaxDropDownCount(Reader: TReader);
begin
  MaxDropDownCount := Reader.ReadInteger;
end;

procedure TcxCustomGridTableFiltering.ReadMRUItemsListDropDownCount(Reader: TReader);
begin
  MRUItemsListDropDownCount := Reader.ReadInteger;
end;

procedure TcxCustomGridTableFiltering.ReadPosition(Reader: TReader);
begin
  Position := TcxGridFilterPosition(GetEnumValue(TypeInfo(TcxGridFilterPosition), Reader.ReadIdent));
end;

procedure TcxCustomGridTableFiltering.ReadVisible(Reader: TReader);
begin
  Visible := TcxGridFilterVisible(GetEnumValue(TypeInfo(TcxGridFilterVisible), Reader.ReadIdent));
end;

procedure TcxCustomGridTableFiltering.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('CustomizeDialog', ReadCustomizeDialog, nil, True);
  Filer.DefineProperty('DropDownWidth', ReadDropDownWidth, nil, True);
  Filer.DefineProperty('MaxDropDownCount', ReadMaxDropDownCount, nil, True);
  Filer.DefineProperty('MRUItemsListDropDownCount', ReadMRUItemsListDropDownCount, nil, True);
  Filer.DefineProperty('Position', ReadPosition, nil, True);
  Filer.DefineProperty('Visible', ReadVisible, nil, True);
end;

procedure TcxCustomGridTableFiltering.FilterChanged;
begin
  FMRUItems.FilterChanged;
end;

function TcxCustomGridTableFiltering.GetMRUItemsClass: TcxGridFilterMRUItemsClass;
begin
  Result := TcxGridFilterMRUItems;
end;

function TcxCustomGridTableFiltering.IsMRUItemsListAvailable: Boolean;
begin
  Result := FMRUItemsList and (FMRUItems.VisibleCount <> 0);
end;

procedure TcxCustomGridTableFiltering.MRUItemsVisibleCountChanged(AOldCount, ANewCount: Integer);
begin
  if FMRUItemsList and ((AOldCount = 0) or (ANewCount = 0)) then
    Changed(vcSize);
end;

procedure TcxCustomGridTableFiltering.AddFilterToMRUItems(AFilter: TcxDataFilterCriteria = nil);
begin
  if AFilter = nil then
    AFilter := GridView.DataController.Filter;
  FMRUItems.Add(AFilter);
end;

procedure TcxCustomGridTableFiltering.Assign(Source: TPersistent);
begin
  if Source is TcxCustomGridTableFiltering then
    with TcxCustomGridTableFiltering(Source) do
    begin
      Self.ItemMRUItemsList := ItemMRUItemsList;
      Self.ItemMRUItemsListCount := ItemMRUItemsListCount;
      Self.ItemPopupDropDownWidth := ItemPopupDropDownWidth;
      Self.ItemPopupMaxDropDownItemCount := ItemPopupMaxDropDownItemCount;
      Self.MRUItemsList := MRUItemsList;
      Self.MRUItemsListCount := MRUItemsListCount;
    end
  else
    inherited;
end;

procedure TcxCustomGridTableFiltering.RunCustomizeDialog(AItem: TcxCustomGridTableItem);
begin
  if GridView.DoFilterDialogShow(AItem) then Exit;
  if (AItem = nil) or IsFilterControlDialogNeeded(GridView.DataController.Filter) then
    if not GridView.DoFilterCustomization then
      ExecuteFilterControlDialog(GridView, GridView.LookAndFeel,
        FilterControlDialogApply, GridView.OnFilterControlDialogShow, clDefault,
        '', TcxCustomGrid(GridView.Control).Font)
    else
  else
    if ShowFilterDialog(GridView.DataController.Filter, AItem,
      AItem.GetProperties, AItem.FilterCaption, AItem.DataBinding.ValueTypeClass,
      GridView.LookAndFeel, TcxCustomGrid(GridView.Control).Font) then
    begin
      GridView.DataController.Filter.Active := True;
      AddFilterToMRUItems;
    end;
end;

{ TcxCustomGridTableOptionsBehavior }

constructor TcxCustomGridTableOptionsBehavior.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FCopyCaptionsToClipboard := True;
  FDragHighlighting := True;
  FDragOpening := True;
  FDragScrolling := True;
  FImmediateEditor := True;
end;

function TcxCustomGridTableOptionsBehavior.GetGridView: TcxCustomGridTableView;
begin
  Result := TcxCustomGridTableView(inherited GridView);
end;

procedure TcxCustomGridTableOptionsBehavior.SetAlwaysShowEditor(Value: Boolean);
begin
  if FAlwaysShowEditor <> Value then
  begin
    FAlwaysShowEditor := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableOptionsBehavior.SetBestFitMaxRecordCount(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FBestFitMaxRecordCount <> Value then
  begin
    FBestFitMaxRecordCount := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableOptionsBehavior.SetCellHints(Value: Boolean);
begin
  if FCellHints <> Value then
  begin
    FCellHints := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableOptionsBehavior.SetCopyCaptionsToClipboard(Value: Boolean);
begin
  if FCopyCaptionsToClipboard <> Value then
  begin
    FCopyCaptionsToClipboard := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableOptionsBehavior.SetDragDropText(Value: Boolean);
begin
  if FDragDropText <> Value then
  begin
    FDragDropText := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableOptionsBehavior.SetDragFocusing(Value: TcxGridDragFocusing);
begin
  if FDragFocusing <> Value then
  begin
    FDragFocusing := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableOptionsBehavior.SetDragHighlighting(Value: Boolean);
begin
  if FDragHighlighting <> Value then
  begin
    FDragHighlighting := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableOptionsBehavior.SetDragOpening(Value: Boolean);
begin
  if FDragOpening <> Value then
  begin
    FDragOpening := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableOptionsBehavior.SetDragScrolling(Value: Boolean);
begin
  if FDragScrolling <> Value then
  begin
    FDragScrolling := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableOptionsBehavior.SetFocusCellOnCycle(Value: Boolean);
begin
  if FFocusCellOnCycle <> Value then
  begin
    FFocusCellOnCycle := Value;
    Changed(vcProperty);
  end;
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
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableOptionsBehavior.SetFocusFirstCellOnNewRecord(Value: Boolean);
begin
  if FFocusFirstCellOnNewRecord <> Value then
  begin
    FFocusFirstCellOnNewRecord := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableOptionsBehavior.SetGoToNextCellOnEnter(Value: Boolean);
begin
  if FGoToNextCellOnEnter <> Value then
  begin
    FGoToNextCellOnEnter := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableOptionsBehavior.SetImmediateEditor(Value: Boolean);
begin
  if FImmediateEditor <> Value then
  begin
    FImmediateEditor := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableOptionsBehavior.SetIncSearch(Value: Boolean);
begin
  if FIncSearch <> Value then
  begin
    if not Value then
      GridView.Controller.CancelIncSearching;
    FIncSearch := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableOptionsBehavior.SetIncSearchItem(Value: TcxCustomGridTableItem);
begin
  if FIncSearchItem <> Value then
  begin
    FIncSearchItem := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableOptionsBehavior.SetNavigatorHints(Value: Boolean);
begin
  if FNavigatorHints <> Value then
  begin
    FNavigatorHints := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableOptionsBehavior.SetPullFocusing(Value: Boolean);
begin
  if FPullFocusing <> Value then
  begin
    FPullFocusing := Value;
    Changed(vcProperty);
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
      Self.CopyCaptionsToClipboard := CopyCaptionsToClipboard;
      Self.DragDropText := DragDropText;
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
  FItemFiltering := True;
  FItemGrouping := True;
  FItemMoving := True;
  FItemSorting := True;
end;

procedure TcxCustomGridTableOptionsCustomize.SetItemFiltering(Value: Boolean);
begin
  if FItemFiltering <> Value then
  begin
    FItemFiltering := Value;
    Changed(vcSize);
  end;
end;

procedure TcxCustomGridTableOptionsCustomize.SetItemGrouping(Value: Boolean);
begin
  if FItemGrouping <> Value then
  begin
    FItemGrouping := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableOptionsCustomize.SetItemHiding(Value: Boolean);
begin
  if FItemHiding <> Value then
  begin
    FItemHiding := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableOptionsCustomize.SetItemMoving(Value: Boolean);
begin
  if FItemMoving <> Value then
  begin
    FItemMoving := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableOptionsCustomize.SetItemSorting(Value: Boolean);
begin
  if FItemSorting <> Value then
  begin
    FItemSorting := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableOptionsCustomize.SetItemsQuickCustomization(Value: Boolean);
begin
  if FItemsQuickCustomization <> Value then
  begin
    FItemsQuickCustomization := Value;
    Changed(vcSize);
  end;
end;

procedure TcxCustomGridTableOptionsCustomize.SetItemsQuickCustomizationMaxDropDownCount(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FItemsQuickCustomizationMaxDropDownCount <> Value then
  begin
    FItemsQuickCustomizationMaxDropDownCount := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableOptionsCustomize.Assign(Source: TPersistent);
begin
  if Source is TcxCustomGridTableOptionsCustomize then
    with TcxCustomGridTableOptionsCustomize(Source) do
    begin
      Self.ItemFiltering := ItemFiltering;
      Self.ItemGrouping := ItemGrouping;
      Self.ItemHiding := ItemHiding;
      Self.ItemMoving := ItemMoving;
      Self.ItemSorting := ItemSorting;
      Self.ItemsQuickCustomization := ItemsQuickCustomization;
      Self.ItemsQuickCustomizationMaxDropDownCount := ItemsQuickCustomizationMaxDropDownCount;
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

procedure TcxCustomGridTableOptionsData.SetAppending(Value: Boolean);
begin
  if FAppending <> Value then
  begin
    FAppending := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableOptionsData.SetCancelOnExit(Value: Boolean);
begin
  if FCancelOnExit <> Value then
  begin
    FCancelOnExit := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableOptionsData.SetDeleting(Value: Boolean);
begin
  if FDeleting <> Value then
  begin
    FDeleting := Value;
    GridView.RefreshNavigators;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableOptionsData.SetDeletingConfirmation(Value: Boolean);
begin
  if FDeletingConfirmation <> Value then
  begin
    FDeletingConfirmation := Value;
    Changed(vcProperty);
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
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableOptionsData.SetInserting(Value: Boolean);
begin
  if FInserting <> Value then
  begin
    FInserting := Value;
    GridView.RefreshNavigators;
    Changed(vcProperty);
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
  FHideFocusRectOnExit := True;
  FInvertSelect := True;
  FUnselectFocusedRecordOnExit := True;
end;

function TcxCustomGridTableOptionsSelection.GetGridView: TcxCustomGridTableView;
begin
  Result := TcxCustomGridTableView(inherited GridView);
end;

function TcxCustomGridTableOptionsSelection.GetMultiSelect: Boolean;
begin
  Result := GridView.DataController.MultiSelect;
end;

procedure TcxCustomGridTableOptionsSelection.SetHideFocusRectOnExit(Value: Boolean);
begin
  if FHideFocusRectOnExit <> Value then
  begin
    FHideFocusRectOnExit := Value;
    Changed(vcLayout);
  end;
end;

procedure TcxCustomGridTableOptionsSelection.SetHideSelection(Value: Boolean);
begin
  if FHideSelection <> Value then
  begin
    FHideSelection := Value;
    Changed(vcLayout);
  end;
end;

procedure TcxCustomGridTableOptionsSelection.SetUnselectFocusedRecordOnExit(Value: Boolean);
begin
  if FUnselectFocusedRecordOnExit <> Value then
  begin
    FUnselectFocusedRecordOnExit := Value;
    Changed(vcProperty);
  end;
end;

function TcxCustomGridTableOptionsSelection.IsInvertSelectStored: Boolean;
begin
  Result := not FInvertSelect;
end;

function TcxCustomGridTableOptionsSelection.IsMultiSelectStored: Boolean;
begin
  Result := MultiSelect;
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
    Changed(vcProperty);  
  end;
end;

procedure TcxCustomGridTableOptionsSelection.SetInvertSelect(Value: Boolean);
begin
  if FInvertSelect <> Value then
  begin
    FInvertSelect := Value;
    Changed(vcLayout);
  end;
end;

procedure TcxCustomGridTableOptionsSelection.SetMultiSelect(Value: Boolean);
begin
  if MultiSelect <> Value then
  begin
    GridView.DataController.MultiSelect := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableOptionsSelection.Assign(Source: TPersistent);
begin
  if Source is TcxCustomGridTableOptionsSelection then
    with TcxCustomGridTableOptionsSelection(Source) do
    begin
      Self.CellSelect := CellSelect;
      Self.HideFocusRectOnExit := HideFocusRectOnExit;
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
  FFocusRect := True;
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
    Changed(vcSize);
  end;
end;

procedure TcxCustomGridTableOptionsView.SetCellEndEllipsis(Value: Boolean);
begin
  if FCellEndEllipsis <> Value then
  begin
    FCellEndEllipsis := Value;
    Changed(vcLayout);
  end;
end;

procedure TcxCustomGridTableOptionsView.SetCellTextMaxLineCount(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FCellTextMaxLineCount <> Value then
  begin
    FCellTextMaxLineCount := Value;
    Changed(vcSize);
  end;
end;

procedure TcxCustomGridTableOptionsView.SetFocusRect(Value: Boolean);
begin
  if FFocusRect <> Value then
  begin
    FFocusRect := Value;
    Changed(vcLayout);
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
    Changed(vcLayout);
  end;
end;

procedure TcxCustomGridTableOptionsView.SetNavigator(Value: Boolean);
begin
  if FNavigator <> Value then
  begin
    FNavigator := Value;
    Changed(vcSize);
  end;
end;

procedure TcxCustomGridTableOptionsView.SetNavigatorOffset(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FNavigatorOffset <> Value then
  begin
    FNavigatorOffset := Value;
    Changed(vcSize);
  end;
end;

procedure TcxCustomGridTableOptionsView.SetShowEditButtons(Value: TcxGridShowEditButtons);
begin
  if FShowEditButtons <> Value then
  begin
    FShowEditButtons := Value;
    Changed(vcSize);
  end;
end;

procedure TcxCustomGridTableOptionsView.ItemCaptionAutoHeightChanged;
begin
  Changed(vcSize);
end;

procedure TcxCustomGridTableOptionsView.Assign(Source: TPersistent);
begin
  if Source is TcxCustomGridTableOptionsView then
    with TcxCustomGridTableOptionsView(Source) do
    begin
      Self.CellAutoHeight := CellAutoHeight;
      Self.CellEndEllipsis := CellEndEllipsis;
      Self.CellTextMaxLineCount := CellTextMaxLineCount;
      Self.FocusRect := FocusRect;
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

procedure TcxCustomGridTableViewStyles.SetOnGetContentStyle(Value: TcxGridGetCellStyleEvent);
begin
  if @FOnGetContentStyle <> @Value then
  begin
    FOnGetContentStyle := Value;
    GridView.Changed(vcProperty);
  end;
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
      vsFilterBox:
        begin
          Color := DefaultFilterBoxColor;
          TextColor := DefaultFilterBoxTextColor;
        end;
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
      Self.FilterBox := FilterBox;
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

{ TcxGridOpenTableItemList }

function TcxGridOpenTableItemList.GetItem(Index: Integer): TcxCustomGridTableItem;
begin
  Result := TcxCustomGridTableItem(inherited Items[Index]);
end;

procedure TcxGridOpenTableItemList.SetItem(Index: Integer; Value: TcxCustomGridTableItem);
begin
  inherited Items[Index] := Value;
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

function TcxCustomGridTableView.GetFilterableItem(Index: Integer): TcxCustomGridTableItem;
begin
  Result := TcxCustomGridTableItem(FFilterableItems[Index]);
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
  Result := TcxCustomGridTableItem(FItems[Index]);
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
    if (MasterGridView as TcxCustomGridTableView).ViewData.IsRecordIndexValid(MasterGridRecordIndex) then
      Result := TcxCustomGridTableView(MasterGridView).ViewData.Records[MasterGridRecordIndex]
    else
      Result := nil;
end;

function TcxCustomGridTableView.GetOptionsBehavior: TcxCustomGridTableOptionsBehavior;
begin
  Result := TcxCustomGridTableOptionsBehavior(inherited OptionsBehavior);
end;

function TcxCustomGridTableView.GetOptionsData: TcxCustomGridTableOptionsData;
begin
  Result := TcxCustomGridTableOptionsData(inherited OptionsData);
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

function TcxCustomGridTableView.GetPatternGridView: TcxCustomGridTableView;
begin
  Result := TcxCustomGridTableView(inherited PatternGridView);
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
  Result := TcxCustomGridTableItem(FVisibleItems[Index]);
end;

function TcxCustomGridTableView.GetVisibleItemCount: Integer;
begin
  Result := FVisibleItems.Count;
end;

procedure TcxCustomGridTableView.SetBackgroundBitmaps(Value: TcxCustomGridTableBackgroundBitmaps);
begin
  inherited BackgroundBitmaps := Value;
end;

procedure TcxCustomGridTableView.SetFilterBox(Value: TcxGridFilterBox);
begin
  FFilterBox.Assign(Value);
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

procedure TcxCustomGridTableView.SetOnCanFocusRecord(Value: TcxGridAllowRecordOperationEvent);
begin
  if @FOnCanFocusRecord <> @Value then
  begin
    FOnCanFocusRecord := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableView.SetOnCanSelectRecord(Value: TcxGridAllowRecordOperationEvent);
begin
  if @FOnCanSelectRecord <> @Value then
  begin
    FOnCanSelectRecord := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableView.SetOnCellClick(Value: TcxGridCellClickEvent);
begin
  if @FOnCellClick <> @Value then
  begin
    FOnCellClick := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableView.SetOnCellDblClick(Value: TcxGridCellClickEvent);
begin
  if @FOnCellDblClick <> @Value then
  begin
    FOnCellDblClick := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableView.SetOnCustomDrawCell(Value: TcxGridTableDataCellCustomDrawEvent);
begin
  if @FOnCustomDrawCell <> @Value then
  begin
    FOnCustomDrawCell := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableView.SetOnCustomDrawPartBackground(Value: TcxGridPartCustomDrawBackgroundEvent);
begin
  if @FOnCustomDrawPartBackground <> @Value then
  begin
    FOnCustomDrawPartBackground := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableView.SetOnEditChanged(Value: TcxGridCustomTableItemEvent);
begin
  if @FOnEditChanged <> @Value then
  begin
    FOnEditChanged := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableView.SetOnEditing(Value: TcxGridEditingEvent);
begin
  if @FOnEditing <> @Value then
  begin
    FOnEditing := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableView.SetOnEditKeyDown(Value: TcxGridEditKeyEvent);
begin
  if @FOnEditKeyDown <> @Value then
  begin
    FOnEditKeyDown := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableView.SetOnEditKeyPress(Value: TcxGridEditKeyPressEvent);
begin
  if @FOnEditKeyPress <> @Value then
  begin
    FOnEditKeyPress := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableView.SetOnEditKeyUp(Value: TcxGridEditKeyEvent);
begin
  if @FOnEditKeyUp <> @Value then
  begin
    FOnEditKeyUp := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableView.SetOnEditValueChanged(Value: TcxGridCustomTableItemEvent);
begin
  if @FOnEditValueChanged <> @Value then
  begin
    FOnEditValueChanged := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableView.SetOnFilterControlDialogShow(Value: TNotifyEvent);
begin
  if @FOnFilterControlDialogShow <> @Value then
  begin
    FOnFilterControlDialogShow := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableView.SetOnFilterCustomization(Value: TcxGridFilterCustomizationEvent);
begin
  if @FOnFilterCustomization <> @Value then
  begin
    FOnFilterCustomization := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableView.SetOnFilterDialogShow(Value: TcxGridFilterDialogShowEvent);
begin
  if @FOnFilterDialogShow <> @Value then
  begin
    FOnFilterDialogShow := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableView.SetOnFocusedItemChanged(Value: TcxGridFocusedItemChangedEvent);
begin
  if @FOnFocusedItemChanged <> @Value then
  begin
    FOnFocusedItemChanged := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableView.SetOnFocusedRecordChanged(Value: TcxGridFocusedRecordChangedEvent);
begin
  if @FOnFocusedRecordChanged <> @Value then
  begin
    FOnFocusedRecordChanged := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableView.SetOnGetCellHeight(Value: TcxGridGetCellHeightEvent);
begin
  if @FOnGetCellHeight <> @Value then
  begin
    FOnGetCellHeight := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableView.SetOnGetDragDropText(Value: TcxGridGetDragDropTextEvent);
begin
  if @FOnGetDragDropText <> @Value then
  begin
    FOnGetDragDropText := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableView.SetOnInitEdit(Value: TcxGridInitEditEvent);
begin
  if @FOnInitEdit <> @Value then
  begin
    FOnInitEdit := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableView.SetOnSelectionChanged(Value: TcxGridCustomTableViewEvent);
begin
  if @FOnSelectionChanged <> @Value then
  begin
    FOnSelectionChanged := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableView.SetOnTopRecordIndexChanged(Value: TNotifyEvent);
begin
  if @FOnTopRecordIndexChanged <> @Value then
  begin
    FOnTopRecordIndexChanged := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxCustomGridTableView.SetOptionsBehavior(Value: TcxCustomGridTableOptionsBehavior);
begin
  inherited OptionsBehavior := Value;
end;

procedure TcxCustomGridTableView.SetOptionsCustomize(Value: TcxCustomGridTableOptionsCustomize);
begin
  FOptionsCustomize.Assign(Value);
end;

procedure TcxCustomGridTableView.SetOptionsData(Value: TcxCustomGridTableOptionsData);
begin
  inherited OptionsData := Value;
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
  I, AIndex: Integer;
begin
  if (Length(FCopyToClipboardStr) >= Length(EndOfLine)) and
    (Copy(FCopyToClipboardStr, Length(FCopyToClipboardStr) - Length(EndOfLine) + 1, Length(EndOfLine)) <> EndOfLine) then
    FCopyToClipboardStr := FCopyToClipboardStr + EndOfLine;

  for I := 0 to FCopyToClipboardItems.Count - 1 do
  begin
    AIndex := TcxCustomGridTableItem(FCopyToClipboardItems[I]).Index;
    FCopyToClipboardStr := FCopyToClipboardStr +
      DataController.GetRowDisplayText(ARowInfo, AIndex) + ColumnSeparator;
    if ARowInfo.Level < DataController.Groups.GroupingItemCount then  // it's a group row
      Break;
  end;
  if FCopyToClipboardItems.Count <> 0 then
    FCopyToClipboardStr := Copy(FCopyToClipboardStr, 1,
      Length(FCopyToClipboardStr) - Length(ColumnSeparator));
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
  Result := FilterableItems[Index].DataBinding.FilterFieldName;
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

function TcxCustomGridTableView.GetFilterValueType(Index: Integer): cxDataStorage.TcxValueTypeClass;
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
  if Supports(TObject(DataController), IcxGridDataController, AIcxGridDataController) then
    Result := AIcxGridDataController.GetNavigatorIsBof
  else
    Result := False;
end;

function TcxCustomGridTableView.NavigatorIsEof: Boolean;
var
  AIcxGridDataController: IcxGridDataController;
begin
  if Supports(TObject(DataController), IcxGridDataController, AIcxGridDataController) then
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
        DataController.Post(True);
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
  var
    I: Integer;
  begin
    with AProperties do
    begin
      Add('FilterActive');
      Add('Filter');
      if Filtering.MRUItemsList then
        for I := Filtering.MRUItems.Count - 1 downto 0 do
          Add(FilterMRUItemBaseName + IntToStr(I));
    end;
  end;

begin
  if gsoUseFilter in StorageOptions then
    AddFilter;
  Result := inherited GetProperties(AProperties);
end;

procedure TcxCustomGridTableView.GetPropertyValue(const AName: string;
  var AValue: Variant);

  function GetFilter: Boolean;
  var
    AStream: TMemoryStream;
    AIndex: Integer;
  begin
    Result := True;
    if AName = 'FilterActive' then
      AValue := DataController.Filter.Active
    else
      if AName = 'Filter' then
      begin
        AStream := TMemoryStream.Create;
        try
          DataController.Filter.WriteData(AStream);
          AValue := StreamToString(AStream);
        finally
          AStream.Free;
        end;
      end
      else
        if Pos(FilterMRUItemBaseName, AName) = 1 then
        begin
          AIndex := StrToInt(Copy(AName, Length(FilterMRUItemBaseName) + 1, MaxInt));
          AStream := Filtering.MRUItems[AIndex].GetStream;
          try
            AValue := StreamToString(AStream);
          finally
            AStream.Free;
          end;
        end
        else
          Result := False;
  end;

begin
  if (gsoUseFilter in StorageOptions) and GetFilter then Exit;
  inherited;
end;

procedure TcxCustomGridTableView.SetPropertyValue(const AName: string;
  const AValue: Variant);

  function SetFilter: Boolean;
  var
    AStream: TMemoryStream;
    AFilter: TcxDataFilterCriteria;
  begin
    Result := True;
    if AName = 'FilterActive' then
      DataController.Filter.Active := StringToBoolean(AValue)
    else
      if AName = 'Filter' then
      begin
        AStream := TMemoryStream.Create;
        try
          StringToStream(dxVariantToAnsiString(AValue), AStream);
          AStream.Position := 0;
          DataController.Filter.ReadData(AStream);
        finally
          AStream.Free;
        end;
      end
      else
        if Pos(FilterMRUItemBaseName, AName) = 1 then
        begin
          AFilter := DataController.CreateFilter;
          try
            AStream := TMemoryStream.Create;
            try
              StringToStream(dxVariantToAnsiString(AValue), AStream);
              AStream.Position := 0;
              AFilter.ReadData(AStream);
              Filtering.MRUItems.Add(AFilter);
            finally
              AStream.Free;
            end;
          finally
            AFilter.Free;
          end;
        end
        else
          Result := False;
  end;

begin
  if (gsoUseFilter in StorageOptions) and SetFilter then Exit;
  inherited;
end;

function TcxCustomGridTableView.CreateStoredObject(const AObjectName, AClassName: string): TObject;

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

begin
  Result := nil;
  if AClassName = GetItemClass.ClassName then
    Result := CreateItem
  else
    if gsoUseSummary in StorageOptions then
      Result := CreateSummary;
  if Result = nil then
    Result := inherited CreateStoredObject(AObjectName, AClassName);
end;

procedure TcxCustomGridTableView.GetStoredChildren(AChildren: TStringList);
var
  I: Integer;
  
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

begin
  for I := 0 to ItemCount - 1 do
    AChildren.AddObject('', Items[I]);
  if gsoUseSummary in StorageOptions then
    AddSummary;
end;

procedure TcxCustomGridTableView.AssignLayout(ALayoutView: TcxCustomGridView);
var
  I, ATag: Integer;
  ALayoutItem, AItem: TcxCustomGridTableItem;
begin
  inherited;
  with ALayoutView as TcxCustomGridTableView do
  begin
    Self.BeginAssignItems;
    try
      for I := 0 to ItemCount - 1 do
      begin
        ALayoutItem := Items[I];
        AItem := TcxCustomGridTableItem(ALayoutItem.DataBinding.Data);
        ATag := AItem.Tag;
        AItem.Assign(ALayoutItem);
        AItem.Tag := ATag;
        AItem.Index := ALayoutItem.Index;
      end;
    finally
      Self.EndAssignItems;
    end;
{
    Self.DataController.Filter.AssignItems(DataController.Filter);
    Self.DataController.Filter.Active := DataController.Filter.Active;}
  end;
end;

procedure TcxCustomGridTableView.BeforeEditLayout(ALayoutView: TcxCustomGridView);
var
  I: Integer;
begin
  inherited;
  with ALayoutView as TcxCustomGridTableView do
  begin
    with OptionsData do
    begin
      Appending := True;
      Deleting := True;
      Editing := True;
      Inserting := True;
    end;
    OptionsSelection.CellSelect := True;
    OptionsView.Navigator := True;
    
    for I := 0 to ItemCount - 1 do
      Items[I].DataBinding.Data := Self.Items[I];
  end;
end;

function TcxCustomGridTableView.HasLayoutCustomizationForm: Boolean;
begin
  Result := True;
end;

procedure TcxCustomGridTableView.BeforeRestoring;
begin
  inherited;
  BeginAssignItems;
  FRestoringItems := TcxGridOpenTableItemList.Create;
end;

procedure TcxCustomGridTableView.AfterRestoring;
var
  I: Integer;
begin
  try
    for I := 0 to FRestoringItems.Count - 1 do
      if FRestoringItems[I] <> nil then
        FRestoringItems[I].Index := I;
    EndAssignItems;
  finally
    FRestoringItems.Free;
    inherited;
  end;
end;

procedure TcxCustomGridTableView.ReadState(Reader: TReader);
begin
  BeginAssignItems;
  try
    inherited;
  finally
    EndAssignItems;
  end;
end;

procedure TcxCustomGridTableView.BeginAssignItems;
begin
  DoBeforeAssignItems;
  FIsAssigningItems := True;
end;

procedure TcxCustomGridTableView.DoBeforeAssignItems;
begin
  FAssigningGroupedItems := TcxGridOpenTableItemList.Create;
  FAssigningSortedItems := TcxGridOpenTableItemList.Create;
end;

procedure TcxCustomGridTableView.DoItemsAssigned;
var
  I: Integer;
begin
  try
    for I := 0 to FAssigningGroupedItems.Count - 1 do
      if FAssigningGroupedItems[I] <> nil then  // because of inherited forms
        FAssigningGroupedItems[I].GroupIndex := I;
    for I := 0 to FAssigningSortedItems.Count - 1 do
      if FAssigningSortedItems[I] <> nil then  // because of inherited forms
        FAssigningSortedItems[I].SortIndex := I;
  finally
    FAssigningSortedItems.Free;
    FAssigningGroupedItems.Free;
  end;
end;

procedure TcxCustomGridTableView.EndAssignItems;
begin
  FIsAssigningItems := False;
  FIsAfterAssigningItems := True;
  try
    DoItemsAssigned;
  finally
    FIsAfterAssigningItems := False;
  end;
end;

function TcxCustomGridTableView.CanOffset(ARecordCountDelta: Integer): Boolean;
begin
  Result := not TcxCustomGrid(Control).UpdateLocked and Visible and
    ViewInfo.CanOffsetView(ARecordCountDelta);
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
    BeginUpdate;  //!!! is it needed?
    try
      with TcxCustomGridTableView(ASource) do
      begin
        Self.BeginAssignItems;
        try
          for I := 0 to ItemCount - 1 do
          begin
            AItem := Self.FindItemByID(Items[I].ID);
            if AItem = nil then
            begin
              AItem := Self.CreateItem;
              AItem.FID := Items[I].ID;
            end;
            AItem.Index := I;
            AItem.Assign(Items[I]);
          end;
          for I := Self.ItemCount - 1 downto ItemCount do
            Self.Items[I].Free;
        finally
          Self.EndAssignItems;
        end;
        Self.FNextID := FNextID;

        Self.FilterBox := FilterBox;
        Self.Filtering := Filtering;
        Self.NavigatorButtons := NavigatorButtons;
        Self.OptionsCustomize := OptionsCustomize;

        Self.OnCanFocusRecord := OnCanFocusRecord;
        Self.OnCanSelectRecord := OnCanSelectRecord;
        Self.OnCellClick := OnCellClick;
        Self.OnCellDblClick := OnCellDblClick;
        Self.OnCustomDrawCell := OnCustomDrawCell;
        Self.OnCustomDrawPartBackground := OnCustomDrawPartBackground;
        Self.OnEditing := OnEditing;
        Self.OnEditChanged := OnEditChanged;
        Self.OnEditKeyDown := OnEditKeyDown;
        Self.OnEditKeyPress := OnEditKeyPress;
        Self.OnEditKeyUp := OnEditKeyUp;
        Self.OnEditValueChanged := OnEditValueChanged;
        Self.OnFilterControlDialogShow := OnFilterControlDialogShow;
        Self.OnFilterCustomization := OnFilterCustomization;
        Self.OnFilterDialogShow := OnFilterDialogShow;
        Self.OnFocusedItemChanged := OnFocusedItemChanged;
        Self.OnFocusedRecordChanged := OnFocusedRecordChanged;
        Self.OnGetCellHeight := OnGetCellHeight;
        Self.OnGetDragDropText := OnGetDragDropText;
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
    if AObjectName = '' then
      Result := nil
    else
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
  ARecord: TcxCustomGridRecord;
  AProperties: TcxCustomEditProperties;
begin
  AItem := Items[AItemIndex];
  if AItem.HasCustomPropertiesHandler then
  begin
    ARecord := ViewData.GetRecordByRecordIndex(ARecordIndex);
    if ARecord = nil then
      AProperties := AItem.GetProperties
    else
      AProperties := AItem.GetProperties(ARecord);
  end
  else
    AProperties := AItem.GetProperties;
  Result := AProperties.GetEditValueSource(False) = evsValue;
  if Result then
    AText := AProperties.GetDisplayText(DataController.Values[ARecordIndex, AItemIndex], True);
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
    Controller.EditingController.IsEditing and Controller.EditingController.Edit.IsFocused or
    Controller.HasFilterMRUItemsPopup and Controller.FilterMRUItemsPopup.Visible or
    Controller.HasFilterPopup and Controller.FilterPopup.Visible or
    Controller.HasItemsCustomizationPopup and Controller.ItemsCustomizationPopup.Visible;
end;

procedure TcxCustomGridTableView.GetItemsListForClipboard(AItems: TList; ACopyAll: Boolean);
begin
  GetVisibleItemsList(AItems);
end;

function TcxCustomGridTableView.GetItemSortByDisplayText(AItemIndex: Integer;
  ASortByDisplayText: Boolean): Boolean;
begin
  Result := Items[AItemIndex].IsSortingByDisplayText(ASortByDisplayText);
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

procedure TcxCustomGridTableView.GetVisibleItemsList(AItems: TList);
{$IFNDEF DELPHI6}
var
  I: Integer;
{$ENDIF}
begin
{$IFDEF DELPHI6}
  AItems.Assign(VisibleItemsList, laCopy);
{$ELSE}
  with AItems do
  begin
    Clear;
    Capacity := VisibleItemsList.Capacity;
    for I := 0 to VisibleItemsList.Count - 1 do
      Add(VisibleItemsList[I]);
  end;    
{$ENDIF}
end;

function TcxCustomGridTableView.HasCustomDrawCell: Boolean;
begin
  Result := Assigned(FOnCustomDrawCell);
end;

function TcxCustomGridTableView.HasCustomDrawPartBackground: Boolean;
begin
  Result := Assigned(FOnCustomDrawPartBackground);
end;

procedure TcxCustomGridTableView.Init;
begin
  inherited;
  if Controller.FocusedItem = nil then
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
    Result := ViewData.IsRecordIndexValid(AGridView.MasterGridRecordIndex);
    if Result then
    begin
      AViewInfo := ViewData.Records[AGridView.MasterGridRecordIndex].ViewInfo;
      Result := (AViewInfo <> nil) and AViewInfo.IsDetailVisible(AGridView);
    end;
  end;
end;

function TcxCustomGridTableView.IsEqualHeightRecords: Boolean;
begin
  Result := not ViewInfo.RecordsViewInfo.AutoDataRecordHeight;
end;

function TcxCustomGridTableView.IsRecordHeightDependsOnData: Boolean;
begin
  Result := ViewInfo.RecordsViewInfo.AutoRecordHeight or
    ViewInfo.RecordsViewInfo.AutoDataRecordHeight or HasCustomProperties;
end;

function TcxCustomGridTableView.IsRecordHeightDependsOnFocus: Boolean;
begin
  Result := ViewInfo.RecordsViewInfo.AutoDataRecordHeight and
    (OptionsView.ShowEditButtons = gsebForFocusedRecord);
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
begin                                  
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
begin
  AOldName := Name;
  inherited;
  if Name <> AOldName then
    RenameComponents(Self, Owner, Name, AOldName, ItemCount,
      @cxCustomGridTableViewGetItem);
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
          Controller.FocusedRecordChanged(PrevFocusedRowIndex, FocusedRowIndex, NewItemRowFocusingChanged)
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
  inherited;
end;

procedure TcxCustomGridTableView.UpdateDataController(AChange: TcxGridDataControllerChange;
  AItem: TcxCustomGridTableItem);
begin
  if {not IsDestroying and }(DataController <> nil) then
    with DataController do
      case AChange of
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
  FFilterBox := GetFilterBoxClass.Create(Self);
  FFiltering := GetFilteringClass.Create(Self);
  FOptionsCustomize := GetOptionsCustomizeClass.Create(Self);
end;

procedure TcxCustomGridTableView.DestroyOptions;
begin
  FreeAndNil(FOptionsCustomize);
  FreeAndNil(FFiltering);
  FreeAndNil(FFilterBox);
  inherited;
end;

procedure TcxCustomGridTableView.AddItem(AItem: TcxCustomGridTableItem);
begin
{$IFDEF DELPHI6}
  if csTransient in ComponentStyle then
    AItem.FComponentStyle := AItem.FComponentStyle + [csTransient];
{$ENDIF}
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
  FFiltering.MRUItems.DeleteEmptyItems;
  ReleaseID(AItem.ID);
  RefreshFilterableItemsList;
  RefreshCustomizationForm;
  Synchronize;
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
    AItem.Changed(ticSize);
    if Controller.FocusedItem = nil then
      AItem.Focused := True;
  end
  else
  begin
    if AItem.IncSearching then Controller.CancelIncSearching;
    //AItem.Focused := False;
    RefreshVisibleItemsList;
    AItem.Changed(ticSize);
    AItem.Focused := False;
  end;
  RefreshCustomizationForm;
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
  if Supports(TObject(DataController), IcxGridDataController, AIGridDataController) then
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
  Synchronize;
end;

procedure TcxCustomGridTableView.DataLayoutChanged;
begin
  ViewData.RefreshRecords;
  SizeChanged;
  Controller.EditingController.UpdateEditValue;
  Synchronize;
end;

function TcxCustomGridTableView.DoCellClick(ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState): Boolean;
begin
  Result := False;
  if Assigned(FOnCellClick) then
    FOnCellClick(Self, ACellViewInfo, AButton, AShift, Result);
end;

function TcxCustomGridTableView.DoCellDblClick(ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState): Boolean;
begin
  Result := False;
  if Assigned(FOnCellDblClick) then
    FOnCellDblClick(Self, ACellViewInfo, AButton, AShift, Result);
end;

function TcxCustomGridTableView.DoEditing(AItem: TcxCustomGridTableItem): Boolean;
begin
  Result := True;
  if Assigned(FOnEditing) then FOnEditing(Self, AItem, Result);
end;

procedure TcxCustomGridTableView.DoTopRecordIndexChanged;
begin
  if Assigned(FOnTopRecordIndexChanged) then FOnTopRecordIndexChanged(Self);
end;

procedure TcxCustomGridTableView.FilterChanged;
begin
  FFiltering.FilterChanged;
end;

procedure TcxCustomGridTableView.FocusedItemChanged(APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
begin
  if Assigned(OnFocusedItemChanged) then
    FOnFocusedItemChanged(Self, APrevFocusedItem, AFocusedItem);
end;

procedure TcxCustomGridTableView.FocusedRecordChanged(APrevFocusedRecordIndex,
  AFocusedRecordIndex: Integer; ANewItemRecordFocusingChanged: Boolean);
begin
  Changed(TcxGridFocusedRecordChange.Create(Self, APrevFocusedRecordIndex,
    AFocusedRecordIndex, ANewItemRecordFocusingChanged));
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
  if IsRecordHeightDependsOnData then
    SizeChanged
  else
  begin
    ARecord := ViewData.GetRecordByRecordIndex(ARecordIndex);
    if ARecord = nil then
      LayoutChanged
    else
      ARecord.Invalidate;
  end;
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
  if not IsLoading then DoSelectionChanged;
end;

function TcxCustomGridTableView.CalculateDataCellSelected(ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; AUseViewInfo: Boolean; ACellViewInfo: TcxGridTableCellViewInfo): Boolean;

  function GetRecordFocused: Boolean;
  begin
    if AUseViewInfo then
      Result := ARecord.ViewInfo.Focused
    else
      Result := DrawRecordFocused(ARecord);
  end;

begin
  if not ARecord.CanFocusCells then
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

function TcxCustomGridTableView.DrawDataCellSelected(ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; AUseViewInfo: Boolean = False;
  ACellViewInfo: TcxGridTableCellViewInfo = nil): Boolean;

  function GetRecordSelected: Boolean;
  begin
    if AUseViewInfo then
      Result := ARecord.ViewInfo.Selected
    else
      Result := DrawRecordSelected(ARecord);
  end;

  function GetCellSelected: Boolean;
  begin
    if (ACellViewInfo <> nil) and ACellViewInfo.AlwaysSelected then
      Result := True
    else
      Result := CalculateDataCellSelected(ARecord, AItem, AUseViewInfo, ACellViewInfo);
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

function TcxCustomGridTableView.DoCanFocusRecord(ARecord: TcxCustomGridRecord): Boolean;
begin
  Result := True;
  if Assigned(FOnCanFocusRecord) then FOnCanFocusRecord(Self, ARecord, Result);
end;

procedure TcxCustomGridTableView.DoCustomDrawCell(ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if HasCustomDrawCell then
    FOnCustomDrawCell(Self, ACanvas, AViewInfo, ADone);
end;

procedure TcxCustomGridTableView.DoCustomDrawPartBackground(ACanvas: TcxCanvas;
  AViewInfo: TcxCustomGridCellViewInfo; var ADone: Boolean);
begin
  if HasCustomDrawPartBackground then
    FOnCustomDrawPartBackground(Self, ACanvas, AViewInfo, ADone);
end;

procedure TcxCustomGridTableView.DoEditChanged(AItem: TcxCustomGridTableItem);
begin
  if Assigned(FOnEditChanged) then FOnEditChanged(Self, AItem);
end;

procedure TcxCustomGridTableView.DoEditKeyDown(AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  if Assigned(FOnEditKeyDown) then FOnEditKeyDown(Self, AItem, AEdit, Key, Shift);
end;

procedure TcxCustomGridTableView.DoEditKeyPress(AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
begin
  if Assigned(FOnEditKeyPress) then FOnEditKeyPress(Self, AItem, AEdit, Key);
end;

procedure TcxCustomGridTableView.DoEditKeyUp(AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  if Assigned(FOnEditKeyUp) then FOnEditKeyUp(Self, AItem, AEdit, Key, Shift);
end;

procedure TcxCustomGridTableView.DoEditValueChanged(AItem: TcxCustomGridTableItem);
begin
  if Assigned(FOnEditValueChanged) then FOnEditValueChanged(Self, AItem);
end;

function TcxCustomGridTableView.DoFilterCustomization: Boolean;
begin
  Result := False;
  if Assigned(FOnFilterCustomization) then FOnFilterCustomization(Self, Result);
end;

function TcxCustomGridTableView.DoFilterDialogShow(AItem: TcxCustomGridTableItem): Boolean;
begin
  Result := False;
  if Assigned(FOnFilterDialogShow) then FOnFilterDialogShow(Self, AItem, Result);
end;

procedure TcxCustomGridTableView.DoFocusedRecordChanged(APrevFocusedRecordIndex,
  AFocusedRecordIndex: Integer; ANewItemRecordFocusingChanged: Boolean);
begin
  if Control <> nil then
    TcxCustomGrid(Control).SendNotifications(gnkFocusedRecordChanged);
  if Assigned(FOnFocusedRecordChanged) then
    FOnFocusedRecordChanged(Self, ViewData.GetRecordByIndex(APrevFocusedRecordIndex),
      ViewData.GetRecordByIndex(AFocusedRecordIndex), ANewItemRecordFocusingChanged);
end;

procedure TcxCustomGridTableView.DoGetCellHeight(ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; ACellViewInfo: TcxGridTableDataCellViewInfo;
  var AHeight: Integer);
begin
  if IsGetCellHeightAssigned then
    FOnGetCellHeight(Self, ARecord, AItem, ACellViewInfo, AHeight);
end;

function TcxCustomGridTableView.DoGetDragDropText(ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem): string;
begin
  if (ARecord <> nil) and (AItem <> nil) then
    Result := ARecord.DisplayTexts[AItem.Index]
  else
    Result := '';
  if Assigned(FOnGetDragDropText) then
    FOnGetDragDropText(Self, ARecord, AItem, Result);  // for vic
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

procedure TcxCustomGridTableView.DoSelectionChanged;
begin
  if Assigned(FOnSelectionChanged) then FOnSelectionChanged(Self);
end;

function TcxCustomGridTableView.HasCustomProperties: Boolean;
var
  I: Integer;
begin
  for I := 0 to ItemCount - 1 do
  begin
    Result := Items[I].HasCustomPropertiesHandler;
    if Result then Exit;
  end;
  Result := False;
end;

function TcxCustomGridTableView.IsGetCellHeightAssigned: Boolean;
begin
  Result := Assigned(FOnGetCellHeight);
end;

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

function TcxCustomGridTableView.GetFilterBoxClass: TcxGridFilterBoxClass;
begin
  Result := TcxGridFilterBox;
end;

function TcxCustomGridTableView.GetFilteringClass: TcxCustomGridTableFilteringClass;
begin
  Result := TcxCustomGridTableFiltering;
end;

function TcxCustomGridTableView.GetNavigatorButtonsClass: TcxNavigatorControlButtonsClass;
begin
  Result := TcxNavigatorControlButtons;
end;

function TcxCustomGridTableView.GetOptionsBehaviorClass: TcxCustomGridOptionsBehaviorClass;
begin
  Result := TcxCustomGridTableOptionsBehavior;
end;

function TcxCustomGridTableView.GetOptionsCustomizeClass: TcxCustomGridTableOptionsCustomizeClass;
begin
  Result := TcxCustomGridTableOptionsCustomize;
end;

function TcxCustomGridTableView.GetOptionsDataClass: TcxCustomGridOptionsDataClass;
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

procedure TcxCustomGridTableView.ApplyBestFit(AItem: TcxCustomGridTableItem = nil;
  ACheckSizingAbility: Boolean = False; AFireEvents: Boolean = False);
var
  I: Integer;
begin
  if AItem = nil then
    for I := 0 to VisibleItemCount - 1 do
      VisibleItems[I].ApplyBestFit(ACheckSizingAbility, AFireEvents)
  else
    AItem.ApplyBestFit(ACheckSizingAbility, AFireEvents);
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
    I: Integer;
  begin
    for I := 0 to FCopyToClipboardItems.Count - 1 do
      FCopyToClipboardStr := FCopyToClipboardStr +
        TcxCustomGridTableItem(FCopyToClipboardItems[I]).Caption + ColumnSeparator;
    if FCopyToClipboardItems.Count <> 0 then
      FCopyToClipboardStr := Copy(FCopyToClipboardStr, 1,
        Length(FCopyToClipboardStr) - Length(ColumnSeparator));
    FCopyToClipboardStr := FCopyToClipboardStr + EndOfLine;
  end;

begin
  FCopyToClipboardItems := TList.Create;
  try
    GetItemsListForClipboard(FCopyToClipboardItems, ACopyAll);
    FCopyToClipboardStr := '';
    if OptionsBehavior.CopyCaptionsToClipboard then
      AddHeaders;
    DataController.ForEachRow(not ACopyAll, CopyForEachRowProc);
    Clipboard.AsText := FCopyToClipboardStr;
  finally
    FCopyToClipboardItems.Free;
  end;  
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

function TcxCustomGridTableView.FindItemByTag(ATag: TcxTag): TcxCustomGridTableItem;
var
  I: Integer;
begin
  for I := 0 to ItemCount - 1 do
  begin
    Result := Items[I];
    if Result.Tag = ATag then Exit;
  end;
  Result := nil;
end;

function TcxCustomGridTableView.IndexOfItem(AItem: TcxCustomGridTableItem): Integer;
begin
  Result := FItems.IndexOf(AItem);
end;

procedure TcxCustomGridTableView.MakeMasterGridRecordVisible;
begin
  if IsDetail and (MasterGridRecord <> nil) and not DontMakeMasterRecordVisible and
    not MasterGridView.DataController.IsDetailExpanding then
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

function TcxCustomGridTableView.GetSummaryGroupItemLinkClass: TcxDataSummaryGroupItemLinkClass;
begin
  Result := nil;
end;

function TcxCustomGridTableView.GetSummaryItemClass: TcxDataSummaryItemClass;
begin
  Result := nil;
end;

{ TcxCustomGridTableControllerAccess }

class procedure TcxCustomGridTableControllerAccess.FocusNextPage(
  AInstance: TcxCustomGridTableController; ASyncSelection: Boolean);
begin
  AInstance.FocusNextPage(ASyncSelection);
end;

class procedure TcxCustomGridTableControllerAccess.FocusPrevPage(
  AInstance: TcxCustomGridTableController; ASyncSelection: Boolean);
begin
  AInstance.FocusPrevPage(ASyncSelection);
end;

{ TcxCustomGridTableItemAccess }

class function TcxCustomGridTableItemAccess.CanGroup(AInstance: TcxCustomGridTableItem): Boolean;
begin
  Result := AInstance.CanGroup;
end;

class function TcxCustomGridTableItemAccess.CanHide(AInstance: TcxCustomGridTableItem): Boolean;
begin
  Result := AInstance.CanHide;
end;

class function TcxCustomGridTableItemAccess.CanHorzSize(AInstance: TcxCustomGridTableItem): Boolean;
begin
  Result := AInstance.CanHorzSize;
end;

class function TcxCustomGridTableItemAccess.CanSort(AInstance: TcxCustomGridTableItem): Boolean;
begin
  Result := AInstance.CanSort;
end;

class procedure TcxCustomGridTableItemAccess.CheckWidthValue(
  AInstance: TcxCustomGridTableItem; var Value: Integer);
begin
  AInstance.CheckWidthValue(Value);
end;

class procedure TcxCustomGridTableItemAccess.DoGetDataText(
  AInstance: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
begin
  AInstance.DoGetDataText(ARecordIndex, AText);
end;

class procedure TcxCustomGridTableItemAccess.DoGetDisplayText(
  AInstance: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  AInstance.DoGetDisplayText(ARecord, AText);
end;

class function TcxCustomGridTableItemAccess.GetGroupIndex(
  AInstance: TcxCustomGridTableItem): Integer;
begin
  Result := AInstance.GroupIndex;
end;

class function TcxCustomGridTableItemAccess.GetFilterCaption(
  AInstance: TcxCustomGridTableItem): string;
begin
  Result := AInstance.FilterCaption;
end;

{ TcxCustomGridTableOptionsBehaviorAccess }

class function TcxCustomGridTableOptionsBehaviorAccess.GetPullFocusing(
  AInstance: TcxCustomGridTableOptionsBehavior): Boolean;
begin
  Result := AInstance.PullFocusing;
end;

class procedure TcxCustomGridTableOptionsBehaviorAccess.SetPullFocusing(
  AInstance: TcxCustomGridTableOptionsBehavior; Value: Boolean);
begin
  AInstance.PullFocusing := Value;
end;

{ TcxCustomGridTableOptionsViewAccess }

class function TcxCustomGridTableOptionsViewAccess.GetCellAutoHeight(
  AInstance: TcxCustomGridTableOptionsView): Boolean;
begin
  Result := AInstance.CellAutoHeight;
end;

{ TcxCustomGridTableViewAccess }

class function TcxCustomGridTableViewAccess.CanSelectRecord(
  AInstance: TcxCustomGridTableView; ARecordIndex: Integer): Boolean;
begin
  Result := AInstance.CanSelectRecord(ARecordIndex);
end;

class procedure TcxCustomGridTableViewAccess.FilterChanged(
  AInstance: TcxCustomGridTableView);
begin
  AInstance.FilterChanged;
end;

class procedure TcxCustomGridTableViewAccess.FocusEdit(
  AInstance: TcxCustomGridTableView; AItemIndex: Integer; var ADone: Boolean);
begin
  AInstance.FocusEdit(AItemIndex, ADone);
end;

class function TcxCustomGridTableViewAccess.GetDefaultActiveDetailIndex(
  AInstance: TcxCustomGridTableView): Integer;
begin
  Result := AInstance.GetDefaultActiveDetailIndex;
end;

class function TcxCustomGridTableViewAccess.GetDisplayText(
  AInstance: TcxCustomGridTableView; ARecordIndex, AItemIndex: Integer;
  out AText: string): Boolean;
begin
  Result := AInstance.GetDisplayText(ARecordIndex, AItemIndex, AText);
end;

class function TcxCustomGridTableViewAccess.GetItemSortByDisplayText(
  AInstance: TcxCustomGridTableView; AItemIndex: Integer;
  ASortByDisplayText: Boolean): Boolean;
begin
  Result := AInstance.GetItemSortByDisplayText(AItemIndex, ASortByDisplayText);
end;

class function TcxCustomGridTableViewAccess.GetItemValueSource(
  AInstance: TcxCustomGridTableView; AItemIndex: Integer): TcxDataEditValueSource;
begin
  Result := AInstance.GetItemValueSource(AItemIndex);
end;

class function TcxCustomGridTableViewAccess.GetSummaryGroupItemLinkClass(
  AInstance: TcxCustomGridTableView): TcxDataSummaryGroupItemLinkClass;
begin
  Result := AInstance.GetSummaryGroupItemLinkClass;
end;

class function TcxCustomGridTableViewAccess.GetSummaryItemClass(
  AInstance: TcxCustomGridTableView): TcxDataSummaryItemClass;
begin
  Result := AInstance.GetSummaryItemClass;
end;

class function TcxCustomGridTableViewAccess.IsEqualHeightRecords(
  AInstance: TcxCustomGridTableView): Boolean;
begin
  Result := AInstance.IsEqualHeightRecords;
end;

class function TcxCustomGridTableViewAccess.IsGetCellHeightAssigned(
  AInstance: TcxCustomGridTableView): Boolean;
begin
  Result := AInstance.IsGetCellHeightAssigned;
end;

class procedure TcxCustomGridTableViewAccess.ItemValueTypeClassChanged(
  AInstance: TcxCustomGridTableView; AItemIndex: Integer);
begin
  AInstance.ItemValueTypeClassChanged(AItemIndex);
end;

class procedure TcxCustomGridTableViewAccess.RefreshNavigators(
  AInstance: TcxCustomGridTableView);
begin
  AInstance.RefreshNavigators;
end;

class procedure TcxCustomGridTableViewAccess.UpdateRecord(
  AInstance: TcxCustomGridTableView);
begin
  AInstance.UpdateRecord;
end;

{ TcxCustomGridTableViewInfoAccess }

class function TcxCustomGridTableViewInfoAccess.GetDefaultGridModeBufferCount(
  AInstance: TcxCustomGridTableViewInfo): Integer;
begin
  Result := AInstance.GetDefaultGridModeBufferCount;
end;

initialization
  RegisterClasses([TcxGridItemDataBinding]);

end.
