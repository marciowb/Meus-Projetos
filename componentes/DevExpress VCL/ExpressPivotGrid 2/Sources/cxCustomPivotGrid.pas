{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{                   ExpressPivotGrid                                 }
{                                                                    }
{       Copyright (c) 2005-2010 Developer Express Inc.               }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSPIVOTGRID AND ALL ACCOMPANYING }
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

unit cxCustomPivotGrid;

{$I cxVer.inc}

interface

uses
  Classes, SysUtils, Windows, Messages, Forms, StdCtrls, Graphics, Controls, cxContainer, Types,
  DateUtils, Math, Menus, Clipbrd, ExtCtrls, ImgList,
  {$IFNDEF NONDB}
     FMTBcd, SqlTimSt,
  {$ENDIF}
  dxCore, dxMessages, cxClasses, cxControls, cxGraphics, cxCustomData, cxDataStorage, cxDataUtils,
  cxEdit, cxStyles, cxLookAndFeels, cxLookAndFeelPainters, cxGeometry, cxDrawTextUtils,
  cxVariants, cxDropDownEdit, cxButtons, cxCheckListBox, cxCheckBox, cxFormats, cxStorage, Variants,
  cxDateUtils, dxOffice11, cxFilterControl, cxFilter,
  cxFilterControlDialog, cxNavigator;

const
  // styles constants
  gs_Background         = 0;
  gs_ColumnHeader       = 1;
  gs_ColumnHeaderArea   = 2;
  gs_Content            = 3;
  gs_DataHeaderArea     = 4;
  gs_FieldHeader        = 5;
  gs_FilterHeaderArea   = 6;
  gs_FilterSeparator    = 7;
  gs_HeaderBackground   = 8;
  gs_Inactive           = 9;
  gs_RowHeader          = 10;
  gs_RowHeaderArea      = 11;
  gs_Selected           = 12;
  gs_Total              = 13;
  gs_Prefilter          = 14;
  gs_ColumnMaximumValue = 15;
  gs_ColumnMinimumValue = 16;
  gs_MaximumValue       = 17;
  gs_MinimumValue       = 18;
  gs_RowMaximumValue    = 19;
  gs_RowMinimumValue    = 20;

  gs_MaxStyleIndex    = gs_RowMinimumValue;

  // hit test constants
  htcButton                       = 1;
  htcDataCell                     = 2;
  htcDataHeader                   = 3;
  htcFieldHeader                  = 4;
  htcHeaderArea                   = 5;
  htcFilter                       = 6;
  htcGroupHeader                  = 7;
  htcHorzSizingEdge               = 8;
  htcVertSizingEdge               = 9;
  htcPrefilter                    = 10;
  htcPrefilterCloseButton         = 11;
  htcPrefilterActivateButton      = 12;
  htcPrefilterCustomizationButton = 13;
  htcPrefilterDropDownButton      = 14;
  htcPrefilterCaption             = 15;

  // popup menu commands

  // Field commands
  pgcmHide              = 0;
  pgcmMoveToBeginning   = 1;
  pgcmMoveToEnd         = 2;
  pgcmMoveToLeft        = 3;
  pgcmMoveToRight       = 4;
  //
  pgcmExpand      = 5;
  pgcmCollapse    = 6;
  pgcmExpandAll   = 7;
  pgcmCollapseAll = 8;

  // Misc. commands
  pgcmShowCustomization = 9;
  pgcmHideCustomization = 10;
  // Prefilter commands
  pgcmShowPrefilterDialog = 11;

  cxPivotGridFilterSeparatorHeight: Integer = 1;

  cxPivotGridDefaultFieldWidth    = 105;
  cxPivotGridDefaultFieldMinWidth = 20;

  cxPivotGridFilterPopupMinWidth  = 150;
  cxPivotGridFilterPopupMinHeight = 15;
  cxPivotGridFilterPopupDefaultWidth  =  150;
  cxPivotGridFilterPopupDefaultHeight = 150;
  cxPivotGridFilterMinSysPanelHeight = 26;

  cxPivotGridDropDownWidth = 0;
  cxPivotGridDropDownMaxItemCount = 15;

  cxPivotGridSpace       = 5;
  cxPivotGridHorzSpace   = 3;
  cxPivotGridHalfSpace   = cxPivotGridHorzSpace div 2;
  cxPivotGridDoubleSpace = cxTextOffset * 2;

  cxPivotGridSizeAreaDelta = 3;
  cxPivotGridSizeMarkWidth = 2;

  cxPivotGridOthersRecordIndex = -2;
  cxPivotGridInvalidIndex      = -1;

  cxPivotGridDefaultFieldFloatFormat: string = '0.00';
  cxPivotGridDefaultFieldIntFormat: string = '0';
  cxPivotGridDefaultFieldPercentFormat: string = '0.00%';

  cxPivotGridDefaultGroupIntervalRange = 10;
  cxPivotPatternChar: Char = '#';

  //
  cxPivotGridDropArrowColor = $00FF00;

  cxPivotGridAutoScrollInterval: Integer = 50;
  cxPivotGridAutoScrollAreaWidth: Integer = 10;

  // customiaztion form

  cxPivotGridControlsIndent = 8;
  cxPivotGridCustomizationMinWidth  = 180;
  cxPivotGridCustomizationMinHeight = 180;
  cxPivotGridCustomizationDefaultHeight = 200;
  cxPivotGridCustomizationDefaultWidth  = 200;

type
  EcxPivotGrid = class(EdxException);

  TcxCustomPivotGrid = class;
  TcxPivotGridViewData = class;

  TcxPivotGridFilterMRUItem = class;
  TcxPivotGridPopupMenus = class;

  TcxPivotGridDataController = class;
  TcxPivotGridStyles = class;
  IcxPivotGridBaseStyles = interface;
  TcxPivotGridOptionsView = class;

  TcxPivotGridFieldGroup = class;
  TcxPivotGridFieldGroupCollection = class;
  TcxPivotGridCustomTotal = class;
  TcxPivotGridCustomTotalCollection = class;

  TcxPivotGridGroupItem = class;
  TcxPivotGridGroupItemClass = class of TcxPivotGridGroupItem;

  TcxPivotGridDataBuilder = class;
  TcxPivotGridCrossCell = class;
  TcxPivotGridCrossCellClass = class of TcxPivotGridCrossCell;
  TcxPivotGridCrossCellSummary = class;

  TcxPivotGridField = class;
  TcxPivotGridFieldClass = class of TcxPivotGridField;
  TcxPivotGridFieldFilter = class;
  TcxPivotGridHitTest = class;
  TcxPivotGridController = class;

  TcxPivotGridChange = (gcLayout, gcData, gcView, gcSelection);
  TcxPivotGridChanges = set of TcxPivotGridChange;

  TcxPivotGridCustomCellViewInfo = class;
  TcxPivotGridHeaderBackgroundCellViewInfo = class;
  TcxPivotGridHeaderCellViewInfo = class;
  TcxPivotGridFieldHeaderCellViewInfo = class;
  TcxPivotGridDragDropAreaInfo = class;
  TcxPivotGridPrefilterViewInfo = class;
  TcxPivotGridOptionsSelection = class;
  TcxPivotGridCustomOLAPDataSource = class;

  TcxPivotGridFieldArea = (faColumn, faRow, faFilter, faData);
  TcxPivotGridFieldAreas = set of TcxPivotGridFieldArea;

  TcxPivotGridDataFieldArea = (dfaNone, dfaColumn, dfaRow);
  TcxPivotGridDataFieldAreas = set of TcxPivotGridDataFieldArea;

  TcxPivotGridGroupInterval = (giDefault, giDate, giDateDay, giDateDayOfWeek,
    giDateDayOfYear, giDateWeekOfMonth, giDateWeekOfYear, giDateMonth, giDateQuarter,
    giDateYear, giYearAge, giMonthAge, giWeekAge, giDayAge, giAlphabetical, giNumeric, giCustom);

  TcxPivotGridTotalsLocation = (tlFar, tlNear, tlCustom);

	TcxPivotGridSummaryType = (stCount, stSum, stMin, stMax, stAverage,
    stStdDev, stStdDevP, stVariance, stVarianceP, stCustom);

  TcxPivotGridTotalsVisibility = (tvAutomatic, tvCustom, tvNone);

  TcxPivotGridCalculationBaseType = (cbRawData, cbVisibleData);

  { IcxPivotGridListener }

  IcxPivotGridListener = interface
  ['{34D8F0E7-C4E2-4F82-A85E-6EE378E7E8FA}']
    procedure DataChanged(Sender: TcxCustomPivotGrid);
    procedure LayoutChanged(Sender: TcxCustomPivotGrid);
    procedure PivotRemoved(Sender: TcxCustomPivotGrid);
    procedure SelectionChanged(Sender: TcxCustomPivotGrid);
  end;

{$IFNDEF DELPHI6}
  TListAssignOp = (laCopy, laAnd, laOr, laXor, laSrcUnique, laDestUnique);
{$ENDIF}

  TcxList = class(TList)
  private
  public
    procedure Assign(AListA: TList; AOperator: TListAssignOp = laCopy; AListB: TList = nil);
  end;

  { TcxPivotGridVariantList }

  TcxPivotGridVariantValue = class
  protected
    FValue: Variant;
    FUnUsed: Boolean;
  public
    constructor Create(const AValue: Variant);
    function IsEqual(AValue: TcxPivotGridVariantValue): Boolean;
    function Compare(const AValue: Variant): Integer;

    property Value: Variant read FValue;
  end;

  TcxPivotGridVariantList = class
  private
    FLockCount: Integer;
    FModified: Boolean;
    FOnChange: TNotifyEvent;
    function GetCount: Integer;
    function GetItem(AIndex: Integer): TcxPivotGridVariantValue;
    function GetValue(AIndex: Integer): Variant;
    procedure SetValue(AIndex: Integer; AValue: Variant);
  protected
    FItems: TcxObjectList;
    Sorted: Boolean;
    procedure Changed;
    procedure MakeSorted;

    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Add(const AValue: Variant): Integer;
    function AddUnique(const AValue: Variant): Integer;
    procedure Clear;
    procedure Delete(AIndex: Integer);
    function IndexOf(const AValue: Variant): Integer;
    procedure MakeUnique;
    function Remove(const AValue: Variant): Integer;

    procedure BeginUpdate;
    procedure EndUpdate(AForceUpdate: Boolean = True);

    property Count: Integer read GetCount;
    property Items[Index: Integer]: TcxPivotGridVariantValue read GetItem;
    property Values[Index: Integer]: Variant read GetValue write SetValue; default;
  end;

  { TcxPivotGridRecords }

  TcxPivotGridRecords = class(TcxList)
  private
    FSorted: Boolean;
    function GetItem(AIndex: Integer): Integer;
    procedure SetItem(AIndex, AValue: Integer);
  protected
    procedure CreateIntersection(AListA, AListB: TcxPivotGridRecords);

    property Sorted: Boolean read FSorted write FSorted;
  public
    procedure Add(ARecordIndex: Integer);
    procedure MakeSorted;
    procedure MakeUnique;

    property Items[Index: Integer]: Integer read GetItem write SetItem; default;
  end;

  { TcxPivotGridFields }

  TcxPivotGridFields = class(TcxList)
  private
    function GetField(Index: Integer): TcxPivotGridField;
    function GetFirstField: TcxPivotGridField;
  public
    procedure ArrangeFields;

    property Fields[Index: Integer]: TcxPivotGridField read GetField; default;
  end;

  { TcxPivotGridCells }

  TcxPivotGridCustomDrawEvent = procedure(ACanvas: TcxCanvas;
    ACell: TcxPivotGridCustomCellViewInfo; var ADone: Boolean) of object;

  TcxPivotGridCells = class(TcxObjectList)
  private
    function GetItem(AIndex: Integer): TcxPivotGridCustomCellViewInfo;
  protected
    procedure CorrectBoundsForPrinting(ABounds: TRect);
  public
    procedure BeforePaint;
    function CalculateHitTest(AHitTest: TcxPivotGridHitTest): Boolean;
    procedure DeleteAll;
    procedure ExcludeFromClipping(ACanvas: TcxCanvas);
    procedure Paint(ACanvas: TcxCanvas; AHandler: TcxPivotGridCustomDrawEvent); virtual;

    property Items[Index: Integer]: TcxPivotGridCustomCellViewInfo read GetItem; default;
  end;

  TcxPivotGridPrefilterPosition = (pfpTop, pfpBottom);

  TcxPivotGridPrefilter = class(TcxPivotGridCells)
  private
    FPivotGrid: TcxCustomPivotGrid;
    function GetCanMRUPopupShow: Boolean;
    function GetCustomizeButtonVisible: Boolean;
    function GetFilter: TcxDataFilterCriteria;
    function GetPosition: TcxPivotGridPrefilterPosition;
    function GetViewInfo: TcxPivotGridPrefilterViewInfo;
    function GetVisible: Boolean;
  protected
    procedure Calculate(var AClientBounds: TRect);
  public
    constructor Create(APivotGrid: TcxCustomPivotGrid);
    procedure ShowPrefilterDialog;

    property CanMRUPopupShow: Boolean read GetCanMRUPopupShow;
    property CustomizeButtonVisible: Boolean read GetCustomizeButtonVisible;
    property Filter: TcxDataFilterCriteria read GetFilter;
    property Position: TcxPivotGridPrefilterPosition read GetPosition;
    property ViewInfo: TcxPivotGridPrefilterViewInfo read GetViewInfo;
    property Visible: Boolean read GetVisible;
  end;

// PivotGrid DataBuilder

  { TcxPivotGridGroupItem }

  TcxPivotGridGroupItem = class
  private
    FDataController: TcxCustomDataController;
    FDisplayText: string;
    FExpanded: Boolean;
    FField: TcxPivotGridField;
    FHasChildren: Boolean;
    FItems: TcxObjectList;
    FIndex: Integer;
    FMemberIndex: Integer;
    FParent: TcxPivotGridGroupItem;
    FRecordIndex: Integer;
    FRecords: TcxPivotGridRecords;
    FUniqueName: WideString;
    function GetDisplayText: string;
    function GetDisplayValue: Variant;
    function GetExpanded: Boolean;
    function GetHasChildren: Boolean;
    function getNextSibling: TcxPivotGridGroupItem;
    function GetIsHierarchy: Boolean;
    function GetItem(AIndex: Integer): TcxPivotGridGroupItem;
    function GetItemCount: Integer;
    function GetLevel: Integer;
    function GetPivotGrid: TcxCustomPivotGrid;
    function getPrevSibling: TcxPivotGridGroupItem; // for Builder
    procedure SetExpanded(AValue: Boolean);
    procedure SetHasChildren(AValue: Boolean);
  protected
    FInternalValue: Variant;
    FIsValueAsssigned: Boolean;
    FSortingValid: Boolean;
    FSummaryValue: Variant;
    function GetCrossCellClass: TcxPivotGridCrossCellClass; virtual;
    function GetIsCollapsed: Boolean;
    function GetIsRow: Boolean; virtual;
    function GetItemAlwaysExpanded: Boolean; virtual;
    function GetSize: Integer; virtual;
    function GetSingleItemSize: Integer; virtual;
    function GetTotalsCount: Integer; virtual;
    function GetUniqueValue: string;
    function GetValue: Variant; virtual;
    procedure CheckExpanding;
    function ChildItemsClass: TcxPivotGridGroupItemClass; virtual;
    procedure CollapseField(AField: TcxPivotGridField);
    procedure ExpandField(AField: TcxPivotGridField);
    function FieldProcessTopValues: Boolean;
    function FieldSortedBySummary: Boolean;
    procedure InitSummaryValue(ACrossTotal: TcxPivotGridGroupItem); virtual;
    procedure PostProcessGroup(ACrossTotal: TcxPivotGridGroupItem); virtual;
    procedure ProcessSortBySummary(ACrossTotal: TcxPivotGridGroupItem); virtual;
    procedure ProcessTopValues(ACrossTotal: TcxPivotGridGroupItem); virtual;
    procedure ReIndexChildren(AFullReindex: Boolean = False);
    procedure SetFieldExpanding(AField: TcxPivotGridField; AExpandState: Boolean);
    procedure SetSummaryInfoDirty(ACrossTotal: TcxPivotGridGroupItem); virtual;

    property DisplayValue: Variant read GetDisplayValue;
    property IsRow: Boolean read GetIsRow;
    property ItemList: TcxObjectList read FItems;
    property SummaryValue: Variant read FSummaryValue;
  public
    constructor Create(AParent: TcxPivotGridGroupItem; ADataController: TcxCustomDataController;
      ARecordIndex: Integer;  AField: TcxPivotGridField); virtual;
    destructor Destroy; override;
    function AddChild(AClass: TcxPivotGridGroupItemClass): TcxPivotGridGroupItem; overload;
    function AddChild(AIndex, ARecordIndex: Integer; AField: TcxPivotGridField): TcxPivotGridGroupItem; overload;
    function ChildrenNeeded: Boolean;
    function Compare(const AValue: Variant): Integer;
    function CreateSummaryRecords: TcxPivotGridRecords; virtual;
    procedure DeleteChildren; virtual;
    function GetCellByCrossItem(AItem: TcxPivotGridGroupItem): TcxPivotGridCrossCell; virtual;
    function GetPrev: TcxPivotGridGroupItem;
    procedure InitializeValue(const ADisplayText: string; const AnUniqueName: WideString);
    procedure MarkDeleted;
    procedure RemoveChildrenFrom(AItem: TcxPivotGridGroupItem);

    property DataController: TcxCustomDataController read FDataController;
    property DisplayText: string read GetDisplayText;
    property Expanded: Boolean read GetExpanded write SetExpanded;
    property Index: Integer read FIndex;
    property Field: TcxPivotGridField read FField;
    property HasChildren: Boolean read GetHasChildren write SetHasChildren;
    property ItemCount: Integer read GetItemCount;
    property Items[Index: Integer]: TcxPivotGridGroupItem read GetItem;
    property IsCollapsed: Boolean read GetIsCollapsed;
    property IsHierarchy: Boolean read GetIsHierarchy;
    property Level: Integer read GetLevel;
    property MemberIndex: Integer read FMemberIndex write FMemberIndex;
    property NextSibling: TcxPivotGridGroupItem read getNextSibling;
    property Parent: TcxPivotGridGroupItem read FParent;
    property PivotGrid: TcxCustomPivotGrid read GetPivotGrid;
    property PrevSibling: TcxPivotGridGroupItem read getPrevSibling;
    property RecordIndex: Integer read FRecordIndex;
    property Records: TcxPivotGridRecords read FRecords;
    property Size: Integer read GetSize;
    property TotalsCount: Integer read GetTotalsCount;
    property UniqueName: WideString read FUniqueName;
    property Value: Variant read GetValue;
  end;

  { TcxPivotGridRowItem }

  TcxPivotGridRowItem = class(TcxPivotGridGroupItem)
  protected
    FCachedCrossCell: TcxPivotGridCrossCell;
    FCrossCells: TcxObjectList;
    procedure ClearCache;
    function GetIsRow: Boolean; override;
    function GetItemAlwaysExpanded: Boolean; override;
    function GetSingleItemSize: Integer; override;
    procedure SetSummaryInfoDirty(ACrossTotal: TcxPivotGridGroupItem); override;
  public
    constructor Create(AParent: TcxPivotGridGroupItem; ADataController: TcxCustomDataController;
      ARecordIndex: Integer;  AField: TcxPivotGridField); override;
    destructor Destroy; override;
    procedure DeleteChildren; override;
    function GetCellByCrossItem(AItem: TcxPivotGridGroupItem): TcxPivotGridCrossCell; override;
  end;

  { TcxPivotGridColumnItem }

  TcxPivotGridColumnItem = class(TcxPivotGridGroupItem)
  protected
    function GetItemAlwaysExpanded: Boolean; override;
    function GetSingleItemSize: Integer; override;
    procedure SetSummaryInfoDirty(ACrossTotal: TcxPivotGridGroupItem); override;
  public
    function GetCellByCrossItem(AItem: TcxPivotGridGroupItem): TcxPivotGridCrossCell; override;
  end;

  { TcxPivotGridDataItem }

  TcxPivotGridDataItem = class(TcxPivotGridGroupItem)
  protected
    function GetSingleItemSize: Integer; override;
    function GetValue: Variant; override;
  end;

  { TcxPivotGridCrossCellDataSource }

  TcxPivotGridCrossCellDataSource = class(TcxCustomDataSource)
  protected
    PivotGrid: TcxCustomPivotGrid;
    Records: TcxPivotGridRecords;

    function HasData: Boolean;

    function GetFieldCount: Integer; virtual;
    function GetPivotGridField(AIndex: Integer): TcxPivotGridField; virtual;
    function GetRecordCount: Integer; override;
    function GetValue(ARecordHandle: TcxDataRecordHandle;
      AItemHandle: TcxDataItemHandle): Variant; override;
  public
    constructor Create(ACell: TcxPivotGridCrossCell); virtual;
    constructor CreateEx(ACrossCells: TList); virtual;
    destructor Destroy; override;

    property FieldCount: Integer read GetFieldCount;
    property PivotGridFields[AIndex: Integer]: TcxPivotGridField read GetPivotGridField;
    property RecordCount: Integer read GetRecordCount;
    property Values[ARecordHandle: TcxDataRecordHandle; AItemHandle: TcxDataItemHandle]: Variant read GetValue;
  end;

  { TcxPivotGridCrossCell }

  TcxPivotGridCrossCell = class
  private
    FCalculated: Boolean;
    FColumn: TcxPivotGridGroupItem;
    FPrevCrossCell: TcxPivotGridCrossCell;
    FRecords: TcxPivotGridRecords;
    FRow: TcxPivotGridGroupItem;
    FSummaryCells: TcxObjectList;
    function GetDataController: TcxCustomDataController;
    function GetPivotGrid: TcxCustomPivotGrid;
    function GetSummaryCell(AIndex: Integer): TcxPivotGridCrossCellSummary;
    function GetSummaryCellCount: Integer;
    function GetUseRawData: Boolean;
  protected
    function AddSummaryCell(AField: TcxPivotGridField;
      ARecords: TcxPivotGridRecords): TcxPivotGridCrossCellSummary; virtual;
    procedure CalculateVisibleSummary; virtual;
    function CreateCrossRecords: TcxPivotGridRecords;
    function CreateCrossCellsList: TList;
    procedure DoCalculateSummary; virtual;
    function IsCalculationAvailable: Boolean; virtual;
    procedure GetDataTypes(ADataField: TcxPivotGridField; var ASourceType, AFloatType: Integer); virtual;
    function GetIsEmpty: Boolean; virtual;
    function GetPrevCrossCellInRow: TcxPivotGridCrossCell; virtual;
    function GetPrevCrossCellInColumn: TcxPivotGridCrossCell; virtual;

    property Calculated: Boolean read FCalculated write FCalculated;
    property PrevCrossCell: TcxPivotGridCrossCell read FPrevCrossCell write FPrevCrossCell;
    property UseRawData: Boolean read GetUseRawData;
  public
    constructor Create(ARow, AColumn: TcxPivotGridGroupItem); virtual;
    destructor Destroy; override;
    procedure CalculateSummaries;
    function CreateDrillDownDataSource: TcxCustomDataSource; virtual;
    function GetSummaryByField(AField: TcxPivotGridField; ASummaryType: TcxPivotGridSummaryType): Variant; virtual;
    function GetSummaryValue(ASummary: TcxPivotGridCrossCellSummary; AType: TcxPivotGridSummaryType): Variant; virtual;

    property Column: TcxPivotGridGroupItem read FColumn;
    property DataController: TcxCustomDataController read GetDataController;
    property IsEmpty: Boolean read GetIsEmpty;
    property PivotGrid: TcxCustomPivotGrid read GetPivotGrid;
    property Records: TcxPivotGridRecords read FRecords;
    property Row: TcxPivotGridGroupItem read FRow;
    property SummaryCellCount: Integer read GetSummaryCellCount;
    property SummaryCells[AIndex: Integer]: TcxPivotGridCrossCellSummary read GetSummaryCell; default;
  end;

  { TcxPivotGridOLAPCrossCell }

  TcxPivotGridOLAPCrossCell = class(TcxPivotGridCrossCell)
  private
    FIsEmpty: Boolean;
    FNativeValues: Variant;
  protected
    procedure GetDataTypes(ADataField: TcxPivotGridField; var ASourceType, AFloatType: Integer); override;
    function GetIsEmpty: Boolean; override;
    function IsCalculationAvailable: Boolean; override;
  public
    function GetSummaryByField(AField: TcxPivotGridField; ASummaryType: TcxPivotGridSummaryType): Variant; override;
    function GetSummaryValue(ASummary: TcxPivotGridCrossCellSummary; AType: TcxPivotGridSummaryType): Variant; override;

    property NativeValues: Variant read FNativeValues write FNativeValues;
  end;

  { TcxPivotGridCrossCellSummary }

  TcxPivotGridGetRecordValueProc = function(const ARecord: Pointer; AIsGroupValue: Boolean): Variant of object;

  TcxPivotGridCrossCellSummary = class
  private
    FDataField: TcxPivotGridField;
    FOwner: TcxPivotGridCrossCell;
    FSummaries: array[TcxPivotGridSummaryType] of Variant;
    FSummaryVariation: Variant;
    function GetDataController: TcxCustomDataController;
    function GetSummaryByIndex(AIndex: Integer): Variant;
    function GetSummaryNullIgnore: Boolean;
    function GetRecords: TcxPivotGridRecords;
    function GetVariationNullIgnore: Boolean;
  protected
    procedure CalculateCustomSummary; virtual;
    procedure CalculateSummaryVariation; virtual;
    procedure CheckValue(var AValue: Variant); virtual;
    procedure DoCalculateSummary(ARecords: TList; AGetValueProc: TcxPivotGridGetRecordValueProc = nil); virtual;
    function GetIntermadiateValue(const ACell: Pointer; AIsGroupValue: Boolean): Variant;
    function GetRecordValue(const ARecord: Pointer; AIsGroupValue: Boolean): Variant;
    procedure SetSummaryByIndex(AIndex: Integer; AValue: Variant);
    procedure SetSummaryByType(AType: TcxPivotGridSummaryType;
      const AValue: Extended; AVarType: Integer);

    property DataController: TcxCustomDataController read GetDataController;
    property SummaryNullIgnore: Boolean read GetSummaryNullIgnore;
    property VariationNullIgnore: Boolean read GetVariationNullIgnore;
  public
    constructor Create(AOwner: TcxPivotGridCrossCell; ADataField: TcxPivotGridField); virtual;
    procedure Clear; virtual;
    function GetPrevCell(APrevCell: TcxPivotGridCrossCellSummary): TcxPivotGridCrossCellSummary;
    function GetValue(ARecordIndex: Integer): Variant; virtual;
    function GetSummaryByType(AType: TcxPivotGridSummaryType): Variant;
    function GetSummaryValue(AType: TcxPivotGridSummaryType): Variant;

    property Average: Variant index 4 read GetSummaryByIndex;
    property Count: Variant index 0 read GetSummaryByIndex;
    property Custom: Variant index 9 read GetSummaryByIndex write SetSummaryByIndex;
    property DataField: TcxPivotGridField read FDataField;
    property Max: Variant index 3 read GetSummaryByIndex;
    property Min: Variant index 2 read GetSummaryByIndex;
    property Owner: TcxPivotGridCrossCell read FOwner;
    property Records: TcxPivotGridRecords read GetRecords;
    property StdDev: Variant index 5 read GetSummaryByIndex;
    property StdDevP: Variant index 6 read GetSummaryByIndex;
    property Sum: Variant index 1 read GetSummaryByIndex;
    property SummaryVariation: Variant read FSummaryVariation write FSummaryVariation;
    property Variance: Variant index 7 read GetSummaryByIndex;
    property VarianceP: Variant index 8 read GetSummaryByIndex;
  end;

  TcxPivotGridCrossCellSummaryClass = class of TcxPivotGridCrossCellSummary;

  { TcxPivotGridDataBuilder }

  TcxPivotGridDataBuilder = class
  private
    FColumnFields: TcxPivotGridFields;
    FColumns: TcxPivotGridGroupItem;
    FData: TcxPivotGridGroupItem;
    FDataController: TcxCustomDataController;
    FDataFields: TcxPivotGridFields;
    FExpandingItems: TList;
    FExpandingLockCount: Integer;
    FFields: TcxPivotGridFields;
    FFilteredFields: TcxPivotGridFields;
    FFilteredIndexes: TcxPivotGridRecords;
    FFilterFields: TcxPivotGridFields;
    FOLAPDataSource: TcxPivotGridCustomOLAPDataSource;
    FPivotGrid: TcxCustomPivotGrid;
    FRowFields: TcxPivotGridFields;
    FRows: TcxPivotGridGroupItem;
    function GetCrossCell(ARow, AColumn: TcxPivotGridGroupItem): TcxPivotGridCrossCell;
    function GetSummaryFields: TcxPivotGridFields;
  protected
    procedure AddSummaryField(AField: TcxPivotGridField);
    procedure AfterDataChanged;
    procedure ApplyFilter; virtual;
    function CanGroupByColumns: Boolean;
    function CanGroupByRows: Boolean;
    procedure Clear; virtual;
    procedure CorrectTotals;
    procedure CreateDataCells;
    procedure GroupBy(AFields: TcxPivotGridFields;
      ARoot: TcxPivotGridGroupItem); virtual;
    procedure GroupByColumns; virtual;
    procedure GroupByRows; virtual;
    procedure GroupExpandingChanged(AItem: TcxPivotGridGroupItem);
    procedure LockExpanding;
    procedure PopulateRecordsList;
    procedure SplitFieldsByGroups;
    procedure UnlockExpanding;
  public
    constructor Create(AOwner: TcxCustomPivotGrid);
    destructor Destroy; override;
    function CanGroup: Boolean;
    procedure DataChanged; virtual;

    property ColumnFields: TcxPivotGridFields read FColumnFields;
    property Columns: TcxPivotGridGroupItem read FColumns;
    property CrossCells[ARow, AColumn: TcxPivotGridGroupItem]: TcxPivotGridCrossCell read GetCrossCell;
    property Data: TcxPivotGridGroupItem read FData;
    property DataController: TcxCustomDataController read FDataController;
    property DataFields: TcxPivotGridFields read FDataFields;
    property Fields: TcxPivotGridFields read FFields;
    property FilteredFields: TcxPivotGridFields read FFilteredFields;
    property FilteredIndexes: TcxPivotGridRecords read FFilteredIndexes;
    property FilterFields: TcxPivotGridFields read FFilterFields;
    property OLAPDataSource: TcxPivotGridCustomOLAPDataSource read FOLAPDataSource;
    property PivotGrid: TcxCustomPivotGrid read FPivotGrid;
    property RowFields: TcxPivotGridFields read FRowFields;
    property Rows: TcxPivotGridGroupItem read FRows;
    property SummaryFields: TcxPivotGridFields read GetSummaryFields;
  end;

//  Pivot ViewData

  { TcxPivotGridViewDataItem }

  TcxPivotGridViewDataLimitValue = class
  protected
    Field: TcxPivotGridField;
    MaxValue: Variant;
    MinValue: Variant;
  public
    constructor Create(AField: TcxPivotGridField);
    procedure Calculate(V: Variant);
  end;

  TcxPivotGridViewDataLimitValues = class(TcxObjectList)
  private
    function GetItem(Index: Integer): TcxPivotGridViewDataLimitValue;
  public
    function Add(AField: TcxPivotGridField): TcxPivotGridViewDataLimitValue; overload;
    procedure Calculate(AField: TcxPivotGridField; V: Variant);
    function FindByField(AField: TcxPivotGridField): TcxPivotGridViewDataLimitValue;
    function GetMaximumValue(AField: TcxPivotGridField): Variant;
    function GetMinimumValue(AField: TcxPivotGridField): Variant;
    property Items[Index: Integer]: TcxPivotGridViewDataLimitValue read GetItem; default;
  end;

  TcxPivotGridViewDataItem = class
  private
    FIndex: Integer;
    FIsDataField: Boolean;
    FItems: TcxObjectList;
    FGroupItem: TcxPivotGridGroupItem;
    FLimitValues: TcxPivotGridViewDataLimitValues;
    FParent: TcxPivotGridViewDataItem;
    FTag: Integer;
    FVisibleIndex: Integer;
    function GetExpanded: Boolean;
    function GetFirst: TcxPivotGridViewDataItem;
    function GetHasButton: Boolean;
    function GetHasChildren: Boolean;
    function GetItem(AIndex: Integer): TcxPivotGridViewDataItem;
    function GetItemCount: Integer;
    function GetIsGrandTotal: Boolean;
    function GetIsTotalItem: Boolean;
    function GetLast: TcxPivotGridViewDataItem;
    function GetLevel: Integer;
    function GetNextVisible: TcxPivotGridViewDataItem;
    function GetPrevVisible: TcxPivotGridViewDataItem;
    function GetPivotGrid: TcxCustomPivotGrid;
  protected
    function GetChildLeftVisibleIndex: Integer; virtual;
    function GetChildRightVisibleIndex: Integer; virtual;
    function GetField: TcxPivotGridField; virtual;
    function GetIsTotal: Boolean; virtual;
    function GetSize: Integer; virtual;
    function GetValue: string; virtual;

    property LimitValues: TcxPivotGridViewDataLimitValues read FLimitValues;
    property PivotGrid: TcxCustomPivotGrid read GetPivotGrid;
  public
    constructor Create(AParent: TcxPivotGridViewDataItem; AGroupItem: TcxPivotGridGroupItem); virtual;
    destructor Destroy; override;
    function Add(AData: TcxPivotGridGroupItem): TcxPivotGridViewDataItem;
    function AddTotal(AData: TcxPivotGridGroupItem; AIndex: Integer): TcxPivotGridViewDataItem;
    procedure ClearCache;
    procedure DeleteChildren;
    function GetDisplayText: string;
    function GetGroupItem(var ADataField: TcxPivotGridField): TcxPivotGridGroupItem;
    function GetGroupItemByField(ADataField: TcxPivotGridField): TcxPivotGridGroupItem;
    function GetSummaryType(var ASummaryType: TcxPivotGridSummaryType;
      var ATotal: TcxPivotGridCustomTotal): Boolean; virtual;
    function MeasureWidth(AField: TPersistent; AIncludeTotals: Boolean): Integer;

    property Expanded: Boolean read GetExpanded;
    property Field: TcxPivotGridField read GetField;
    property First: TcxPivotGridViewDataItem read GetFirst;
    property HasButton: Boolean read GetHasButton;
    property HasChildren: Boolean read GetHasChildren;

    property GroupItem: TcxPivotGridGroupItem read FGroupItem;

    property Index: Integer read FIndex;
    property ItemCount: Integer read GetItemCount;
    property Items[Index: Integer]: TcxPivotGridViewDataItem read GetItem;
    property IsDataField: Boolean read FIsDataField;
    property IsGrandTotal: Boolean read GetIsGrandTotal;
    property IsTotal: Boolean read GetIsTotal;
    property IsTotalItem: Boolean read GetIsTotalItem;
    property Last: TcxPivotGridViewDataItem read GetLast;
    property Level: Integer read GetLevel;
    property NextVisible: TcxPivotGridViewDataItem read GetNextVisible;
    property Parent: TcxPivotGridViewDataItem read FParent;
    property PrevVisible: TcxPivotGridViewDataItem read GetPrevVisible;
    property Size: Integer read GetSize;
    property Tag: Integer read FTag write FTag; //todo: Internal use only!!! Need for optimization chart connection !!!
    property Value: string read GetValue;
    property VisibleIndex: Integer read FVisibleIndex;
  end;

  { TcxPivotGridViewDataTotalItem }

  TcxPivotGridViewDataTotalItem = class(TcxPivotGridViewDataItem)
  private
    FTotal: TcxPivotGridCustomTotal;
  protected
    function GetDescription: string;
    function GetIsTotal: Boolean; override;
    function GetValue: string; override;
    procedure SetTotal(AIndex: Integer);
  public
    function GetSummaryType(var ASummaryType: TcxPivotGridSummaryType;
      var ATotal: TcxPivotGridCustomTotal): Boolean; override;
    property Total: TcxPivotGridCustomTotal read FTotal;
  end;

  { TcxPivotGridViewDataSelections }

  TcxPivotGridViewDataSelection = class(TPersistent)
  private
    FAnchorCells: TRect;
    FFocusedCell: TPoint;
    FHasTemporarySelection: Boolean;
    FRegions: array of TRect;
    FLockCount: Integer;
    FViewData: TcxPivotGridViewData;
    function GetCount: Integer;
    function GetRegion(AIndex: Integer): TRect;
    function GetMultiSelect: Boolean;
    function GetTemporarySelection: TRect;
    function IsTemporarySelected: Boolean;
    procedure SetFocusedCell(const APoint: TPoint);
    procedure SetTemporarySelection(const AValue: TRect);
  protected
    procedure ApplyTemporarySelection(AIsSet: Boolean); virtual;
    procedure ChangeSelection(const R: TRect; AShift: TShiftState); virtual;
    procedure DoChanged; virtual;
    procedure InnerClear; virtual;
    procedure InnerSetFocusedCell(const APoint: TPoint); virtual;
    function IsSelected: Boolean;
    procedure ValidateFocusedCell;
    procedure ValidateSelections;

    property AnchorCells: TRect read FAnchorCells write FAnchorCells;
    property LockCount: Integer read FLockCount;
    property MultiSelect: Boolean read GetMultiSelect;
    property TemporarySelection: TRect read GetTemporarySelection write SetTemporarySelection;
    property ViewData: TcxPivotGridViewData read FViewData;
  public
    constructor Create(AViewData: TcxPivotGridViewData); virtual;
    destructor Destroy; override;

    procedure Add(const ARegion: TRect); virtual;
    procedure BeginUpdate;
    procedure Clear; virtual;
    procedure Delete(AIndex: Integer);
    procedure EndUpdate(ASendNotification: Boolean = True);
    function GetCombinedSelectionBounds: TRect; virtual;
    function IsCellSelected(AColumn, ARow: Integer): Boolean; virtual;
    procedure MakeNew(const ARegion: TRect); virtual;

    property Count: Integer read GetCount;
    property FocusedCell: TPoint read FFocusedCell write SetFocusedCell;
    property Regions[AIndex: Integer]: TRect read GetRegion; default;
  end;

  { TcxPivotGridViewData }

  TcxPivotGridViewData = class
  private
    FBookMarkRow: Integer;
    FCalculatedLimitValues: Boolean;
    FColumnIndex: Integer;
    FColumns: TcxPivotGridViewDataItem;
    FColumnsList: TList;
    FColumnsPerPage: Integer;
    FExpandColumns: Boolean;
    FExpandRows: Boolean;
    FLimitValues: TcxPivotGridViewDataLimitValues;
    FOwner: TcxCustomPivotGrid;
    FRowIndex: Integer;
    FRows: TcxPivotGridViewDataItem;
    FRowsList: TList;
    FRowsPerPage: Integer;
    FSelection: TcxPivotGridViewDataSelection;
    function GetAnchorCells: TRect;
    function GetCell(ARow, AColumn: Integer): TcxPivotGridCrossCellSummary;
    function GetCellAsText(ARow, AColumn: Integer): string;
    function GetColumn(AIndex: Integer): TcxPivotGridViewDataItem;
    function GetColumnCount: Integer;
    function GetDataBuilder: TcxPivotGridDataBuilder;
    function GetFocusedCell: TPoint;
    function GetOptionsSelection: TcxPivotGridOptionsSelection;
    function GetOptionsView: TcxPivotGridOptionsView;
    function GetRow(AIndex: Integer): TcxPivotGridViewDataItem;
    function GetRowCount: Integer;
    function NeedCalculateLimitValues: Boolean;
    procedure SetAnchorCells(const AValue: TRect);
    procedure SetColumnIndex(AIndex: Integer);
    procedure SetFocusedCell(const APoint: TPoint);
    procedure SetRowIndex(AIndex: Integer);
  protected
    procedure AdjustCellIndexes(var ARow, AColumn: Integer; AByMouse: Boolean = False);
    function AdjustCellIndexesPoint(const P: TPoint; AByMouse: Boolean = False): TPoint;
    procedure Calculate;
    function CalculateDataWidth(AField: TcxPivotGridField): Integer;
    procedure CalculateDataFieldInfo(var AFieldIndex: Integer;
      var AFields: TcxPivotGridGroupItem; AcceptedArea: TcxPivotGridDataFieldArea);
    procedure CalculateLimitValues;
    procedure Clear;
    function CanCellSelect(ARow, AColumn: Integer): Boolean; virtual;
    procedure DoNextPage(AGoForward: Boolean);
    procedure HeaderCellSelect(ADataItem: TcxPivotGridViewDataItem; AShift: TShiftState); virtual;
    function IsGroupItemEquals(AItem1, AItem2: TcxPivotGridViewDataItem): Boolean;
    procedure PopulateSelectedCells(ACells: TList);
    procedure ProduceColumns;
    procedure ProduceRows;
    procedure Scroll(AScrollCode: TScrollCode; AItem: TcxPivotGridViewDataItem;
      APage, AMax, ASize, AScrollPos: Integer; var APos: Integer); virtual;
    function ScrollColumns(AScrollCode: TScrollCode; var AScrollPos: Integer): Boolean;
    function ScrollRows(AScrollCode: TScrollCode; var AScrollPos: Integer): Boolean;
    procedure ValidateIndexes;
    procedure ValidateSelection(var ASelection: TRect);

    property AnchorCells: TRect read GetAnchorCells write SetAnchorCells;
    property CalculatedLimitValues: Boolean read FCalculatedLimitValues;
    property ExpandColumns: Boolean read FExpandColumns write FExpandColumns;
    property ExpandRows: Boolean read FExpandRows write FExpandRows;
    property LimitValues: TcxPivotGridViewDataLimitValues read FLimitValues;
    property OptionsSelection: TcxPivotGridOptionsSelection read GetOptionsSelection;
  public
    constructor Create(AOwner: TcxCustomPivotGrid); virtual;
    destructor Destroy; override;

    function IsCellSelected(ARow, AColumn: Integer): Boolean;
    function MakeSelectionVisible: Boolean;

    property Cells[Row, Column: Integer]: TcxPivotGridCrossCellSummary read GetCell;
    property CellsAsText[Row, Column: Integer]: string read GetCellAsText;
    property ColumnCount: Integer read GetColumnCount;
    property ColumnIndex: Integer read FColumnIndex write SetColumnIndex;
    property Columns[AIndex: Integer]: TcxPivotGridViewDataItem read GetColumn;
    property ColumnsPerPage: Integer read FColumnsPerPage write FColumnsPerPage;
    property ColumnsList: TList read FColumnsList;
    property DataBuilder: TcxPivotGridDataBuilder read GetDataBuilder;
    property FocusedCell: TPoint read GetFocusedCell write SetFocusedCell;
    property OptionsView: TcxPivotGridOptionsView read GetOptionsView;
    property PivotGrid: TcxCustomPivotGrid read FOwner;
    property RowCount: Integer read GetRowCount;
    property RowIndex: Integer read FRowIndex write SetRowIndex;
    property Rows[AIndex: Integer]: TcxPivotGridViewDataItem read GetRow;
    property RowsList: TList read FRowsList;
    property RowsPerPage: Integer read FRowsPerPage write FRowsPerPage;
    property Selection: TcxPivotGridViewDataSelection read FSelection;
  end;

  { IcxPivotGridSizableObject }

  IcxPivotGridSizableObject = interface
  ['{CFCAC754-EC31-4A72-8BED-1D9D2715E062}']
    procedure ApplyBestFit;
    function CanResize: Boolean;
    function GetActualWidth: Integer;
    function GetMinWidth: Integer;
    procedure SetWidth(AValue: Integer);
  end;

  { IcxPivotGridField }

  IcxPivotGridField = interface(IcxPivotGridSizableObject)
  ['{61CC4884-4510-4C28-86DC-EC0B984E56DA}']
    function CanDrag: Boolean;
    function CanDrop(AArea: TcxPivotGridFieldArea): Boolean;
    function CanRemove: Boolean;
    procedure ChangeExpanding;
    procedure ChangeSorting;
    procedure DragDrop(AArea: TcxPivotGridFieldArea; AIndex: Integer);
    function GetVisible: Boolean;
    function GetViewInfo: TcxPivotGridFieldHeaderCellViewInfo;
    procedure SetState(AState: TcxButtonState);
    procedure SetVisible(AValue: Boolean);
  end;

  { TcxPivotGridCustomOptions }

  TcxPivotGridCustomOptions = class(TPersistent)
  private
    FPivotGrid: TcxCustomPivotGrid;
  protected
    function GetOwner: TPersistent; override;
    procedure Changed; virtual;
    procedure SetBoolValue(var AFieldValue: Boolean; AValue: Boolean);
  public
    constructor Create(AOwner: TcxCustomPivotGrid); virtual;
    procedure Assign(Source: TPersistent); override;

    property PivotGrid: TcxCustomPivotGrid read FPivotGrid;
  end;

  { TcxPivotGridOptionsBehavior }

  TcxPivotGridOptionsBehavior = class(TcxPivotGridCustomOptions)
  private
    FCellHints: Boolean;
    FFieldHeaderHints: Boolean;
    FFocusCellOnCycle: Boolean;
    FFocusCellOnTab: Boolean;
    FGroupHeaderHints: Boolean;
  public
    constructor Create(AOwner: TcxCustomPivotGrid); override;
    procedure Assign(Source: TPersistent); override;
  published
    property CellHints: Boolean read FCellHints write FCellHints default False;
    property FieldHeaderHints: Boolean read FFieldHeaderHints write FFieldHeaderHints default True;
    property FocusCellOnCycle: Boolean read FFocusCellOnCycle write FFocusCellOnCycle default False;
    property FocusCellOnTab: Boolean read FFocusCellOnTab write FFocusCellOnTab default False;
    property GroupHeaderHints: Boolean read FGroupHeaderHints write FGroupHeaderHints default True;
  end;

  { TcxPivotGridOptionsCustomize }

  TcxPivotGridOptionsCustomize = class(TcxPivotGridCustomOptions)
  private
    FFiltering: Boolean;
    FFilterResizable: Boolean;
    FHiding: Boolean;
    FMoving: Boolean;
    FQuickCustomization: Boolean;
    FQuickPrefiltering: Boolean;
    FSizing: Boolean;
    FSorting: Boolean;
    procedure SetFiltering(AValue: Boolean);
    procedure SetValue(AIndex: Integer; AValue: Boolean);
  public
    constructor Create(AOwner: TcxCustomPivotGrid); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Filtering: Boolean index 0 read FFiltering write SetValue default True;
    property FilterResizable: Boolean index 6 read FFilterResizable write SetValue default True;
    property Hiding: Boolean index 1 read FHiding write SetValue default True;
    property Moving: Boolean index 2 read FMoving write SetValue default True;
    property QuickCustomization: Boolean index 3 read FQuickCustomization write SetValue default True;
    property QuickPrefiltering: Boolean index 7 read FQuickPrefiltering write SetValue default True;
    property Sizing: Boolean index 4 read FSizing write SetValue default True;
    property Sorting: Boolean index 5 read FSorting write SetValue default True;
  end;

  { TcxPivotGridOptionsView }

  TcxPivotGridLines = (pglNone, pglHorz, pglVert, pglBoth);

  TcxPivotGridOptionsView = class(TcxPivotGridCustomOptions, IUnknown, IcxPivotGridSizableObject)
  private
    FColumnFields: Boolean;
    FColumnGrandTotals: Boolean;
    FColumnGrandTotalText: string;
    FColumnTotals: Boolean;
    FColumnTotalsLocation: TcxPivotGridTotalsLocation;
    FDataFields: Boolean;
    FDropArrowColor: TColor;
    FFilterDropDownMaxItemCount: Integer;
    FFilterDropDownWidth: Integer;
    FFilterFields: Boolean;
    FFilterSeparator: Boolean;
    FGrandTotalsForSingleValues: Boolean;
    FGrandTotalWidth: Integer;
    FGridLineColor: TColor;
    FGridLines: TcxPivotGridLines;
    FMarkNarrowCells: Boolean;
    FRowFields: Boolean;
    FRowGrandTotals: Boolean;
    FRowGrandTotalText: string;
    FRowTotals: Boolean;
    FRowTotalsLocation: TcxPivotGridTotalsLocation;
    FTotalsForSingleValues: Boolean;
    function GetScrollBars: TScrollStyle;
    function GetTotalsLocation: TcxPivotGridTotalsLocation;
    procedure SetColumnFields(AValue: Boolean);
    procedure SetColumnGrandTotals(AValue: Boolean);
    procedure SetColumnGrandTotalText(const AValue: string);
    procedure SetColumnTotals(AValue: Boolean);
    procedure SetColumnTotalsLocation(AValue: TcxPivotGridTotalsLocation);
    procedure SetDataFields(AValue: Boolean);
    procedure SetFilterDropDownMaxItemCount(AValue: Integer);
    procedure SetFilterDropDownWidth(AValue: Integer);
    procedure SetFilterFields(AValue: Boolean);
    procedure SetFilterSeparator(AValue: Boolean);
    procedure SetGrandTotalWidth(AValue: Integer);
    procedure SetGrandTotalsForSingleValues(AValue: Boolean);
    procedure SetGridLineColor(AValue: TColor);
    procedure SetGridLines(AValue: TcxPivotGridLines);
    procedure SetMarkNarrowCells(AValue: Boolean);
    procedure SetRowFields(AValue: Boolean);
    procedure SetRowGrandTotals(AValue: Boolean);
    procedure SetRowGrandTotalText(const AValue: string);
    procedure SetRowTotals(AValue: Boolean);
    procedure SetRowTotalsLocation(AValue: TcxPivotGridTotalsLocation);
    procedure SetScrollBars(AValue: TScrollStyle);
    procedure SetTotalsForSingleValues(AValue: Boolean);
    procedure SetTotalsLocation(const AValue: TcxPivotGridTotalsLocation);
  protected
    procedure Changed; override;
    //IUnknown
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    // IcxPivotGridSizableObject
    procedure ApplyBestFit;
    function CanResize: Boolean;
    function GetActualWidth: Integer;
    function GetMinWidth: Integer;
    procedure SetWidth(AValue: Integer);
  public
    constructor Create(AOwner: TcxCustomPivotGrid); override;
    procedure Assign(Source: TPersistent); override;
  published
    property ColumnFields: Boolean read FColumnFields write SetColumnFields default True;
    property ColumnGrandTotals: Boolean read FColumnGrandTotals write SetColumnGrandTotals default True;
    property ColumnGrandTotalText: string read FColumnGrandTotalText write SetColumnGrandTotalText;
    property ColumnTotals: Boolean read FColumnTotals write SetColumnTotals default True;
    property ColumnTotalsLocation: TcxPivotGridTotalsLocation read FColumnTotalsLocation write SetColumnTotalsLocation default tlFar;
    property DataFields: Boolean read FDataFields write SetDataFields default True;
    property DropArrowColor: TColor read FDropArrowColor write FDropArrowColor default cxPivotGridDropArrowColor;
    property FilterDropDownMaxItemCount: Integer read FFilterDropDownMaxItemCount write SetFilterDropDownMaxItemCount default cxPivotGridDropDownMaxItemCount;
    property FilterDropDownWidth: Integer read FFilterDropDownWidth write SetFilterDropDownWidth default cxPivotGridDropDownWidth;
    property FilterFields: Boolean read FFilterFields write SetFilterFields default True;
    property FilterSeparator: Boolean read FFilterSeparator write SetFilterSeparator default True;
    property GrandTotalWidth: Integer read FGrandTotalWidth write SetGrandTotalWidth default 0;
    property GrandTotalsForSingleValues: Boolean read FGrandTotalsForSingleValues write SetGrandTotalsForSingleValues default False;
    property GridLineColor: TColor read FGridLineColor write SetGridLineColor default clDefault;
    property GridLines: TcxPivotGridLines read FGridLines write SetGridLines default pglBoth;
    property MarkNarrowCells: Boolean read FMarkNarrowCells write SetMarkNarrowCells default False;
    property RowFields: Boolean read FRowFields write SetRowFields default True;
    property RowGrandTotals: Boolean read FRowGrandTotals write SetRowGrandTotals default True;
    property RowGrandTotalText: string read FRowGrandTotalText write SetRowGrandTotalText;
    property RowTotals: Boolean read FRowTotals write SetRowTotals default True;
    property RowTotalsLocation: TcxPivotGridTotalsLocation read FRowTotalsLocation write SetRowTotalsLocation default tlFar;
    property ScrollBars: TScrollStyle read GetScrollBars write SetScrollBars default ssBoth;
    property TotalsForSingleValues: Boolean read FTotalsForSingleValues write SetTotalsForSingleValues default False;
    property TotalsLocation: TcxPivotGridTotalsLocation read GetTotalsLocation write SetTotalsLocation stored False;
  end;

  { TcxPivotGridOptionsData }

  TcxPivotGridOptionsData = class(TcxPivotGridCustomOptions)
  private
    FAnsiSort: Boolean;
    FCalculationBase: TcxPivotGridCalculationBaseType;
    FSaveExpanding: Boolean;
    FSummaryNullIgnore: Boolean;
    FVariationNullIgnore: Boolean;
    procedure SetAnsiSort(AValue: Boolean);
    procedure SetCalculationBase(AValue: TcxPivotGridCalculationBaseType);
    procedure SetSummaryNullIgnore(AValue: Boolean);
    procedure SetVariationNullIgnore(AValue: Boolean);
  protected
    procedure Changed; override;
    function CompareAsString(const V1, V2: Variant): Integer;
  public
    constructor Create(AOwner: TcxCustomPivotGrid); override;
    procedure Assign(Source: TPersistent); override;
  published
    property AnsiSort: Boolean read FAnsiSort write SetAnsiSort default False;
    property CalculationBase: TcxPivotGridCalculationBaseType read FCalculationBase write SetCalculationBase default cbRawData;
    property SaveExpanding: Boolean read FSaveExpanding write FSaveExpanding default True;
    property SummaryNullIgnore: Boolean read FSummaryNullIgnore write SetSummaryNullIgnore default False;
    property VariationNullIgnore: Boolean read FVariationNullIgnore write SetVariationNullIgnore default True;
  end;

  { TcxPivotGridOptionsPrefilter }

  TcxPivotGridPrefilterVisible = (pfvNever, pfvNonEmpty, pfvAlways);

  TcxPivotGridOptionsPrefilter = class(TcxPivotGridCustomOptions)
  private
    FCustomizeButton: Boolean;
    FMRUItemsList: Boolean;
    FMRUItemsListCount: Integer;
    FMRUItemsListDropDownCount: Integer;
    FPosition: TcxPivotGridPrefilterPosition;
    FVisible: TcxPivotGridPrefilterVisible;
    procedure SetCustomizeButton(AValue: Boolean);
    procedure SetMRUItemsList(AValue: Boolean);
    procedure SetMRUItemsListCount(AValue: Integer);
    procedure SetMRUItemsListDropDownCount(AValue: Integer);
    procedure SetPosition(AValue: TcxPivotGridPrefilterPosition);
    procedure SetVisible(AValue: TcxPivotGridPrefilterVisible);
  public
    constructor Create(AOwner: TcxCustomPivotGrid); override;
    procedure Assign(Source: TPersistent); override;
  published
    property CustomizeButton: Boolean read FCustomizeButton write SetCustomizeButton default True;
    property MRUItemsList: Boolean read FMRUItemsList write SetMRUItemsList default True;
    property MRUItemsListCount: Integer read FMRUItemsListCount write SetMRUItemsListCount default 10;
    property MRUItemsListDropDownCount: Integer read FMRUItemsListDropDownCount write SetMRUItemsListDropDownCount default 0;
    property Position: TcxPivotGridPrefilterPosition read FPosition write SetPosition default pfpBottom;
    property Visible: TcxPivotGridPrefilterVisible read FVisible write SetVisible default pfvNonEmpty;
  end;

  { TcxPivotGridOptionsSelection }

  TcxPivotGridOptionsSelectionInclude = (osiCrossCells, osiGrandTotalCells, osiTotalCells);
  TcxPivotGridOptionsSelectionIncludes = set of TcxPivotGridOptionsSelectionInclude;

  TcxPivotGridOptionsSelection = class(TcxPivotGridCustomOptions)
  private
    FHideFocusRect: Boolean;
    FHideSelection: Boolean;
    FIncludeCells: TcxPivotGridOptionsSelectionIncludes;
    FMultiSelect: Boolean;
    procedure SetHideFocusRect(AValue: Boolean);
    procedure SetHideSelection(AValue: Boolean);
    procedure SetIncludeCells(const AValue: TcxPivotGridOptionsSelectionIncludes);
    procedure SetMultiSelect(AValue: Boolean);
  public
    constructor Create(AOwner: TcxCustomPivotGrid); override;
    procedure Assign(Source: TPersistent); override;
  published
    property HideFocusRect: Boolean read FHideFocusRect write SetHideFocusRect default False;
    property HideSelection: Boolean read FHideSelection write SetHideSelection default False;
    property IncludeCells: TcxPivotGridOptionsSelectionIncludes read FIncludeCells write SetIncludeCells default [osiCrossCells, osiGrandTotalCells, osiTotalCells];
    property MultiSelect: Boolean read FMultiSelect write SetMultiSelect default False;
  end;

  { TcxPivotGridCustomCustomizationForm }

  TcxPivotGridCustomCustomizationForm = class(TForm)
  private
    FHookTimer: TcxTimer;
    FPivotGrid: TcxCustomPivotGrid;
    function GetIsLocked: Boolean;
    function GetLookAndFeel: TcxLookAndFeel;
    function GetPainter: TcxCustomLookAndFeelPainterClass;
    procedure HookTimerHandler(Sender: TObject);
  protected
    FontHeight: Integer;
    procedure CreateControls; virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DoClose(var Action: TCloseAction); override;
    procedure DoCustomDrawFieldHeader(ACanvas: TcxCanvas;
      ACell: TcxPivotGridCustomCellViewInfo; var ADone: Boolean); virtual;
    procedure DoShow; override;
    function GetDragAndDropObjectClass(
      AField: TcxPivotGridField): TcxDragAndDropObjectClass; virtual;
    procedure Init; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RefreshList; virtual;

    property IsLocked: Boolean read GetIsLocked;
    property LookAndFeel: TcxLookAndFeel read GetLookAndFeel;
    property Painter: TcxCustomLookAndFeelPainterClass read GetPainter;
    property PivotGrid: TcxCustomPivotGrid read FPivotGrid;
  end;

  TcxPivotGridCustomizationFormClass = class of TcxPivotGridCustomCustomizationForm;

  { TcxPivotGridCustomization }

  TcxPivotGridCustomization = class(TcxPivotGridCustomOptions)
  private
    FForm: TcxPivotGridCustomCustomizationForm;
    FFormBounds: TRect;
    function Getform: TcxPivotGridCustomCustomizationForm; // CBuilder bug! conflict with macro
    function GetFormBounds: TRect;
    function GetVisible: Boolean;
    procedure SetFormBounds(const AValue: TRect);
    procedure SetVisible(AValue: Boolean);
  protected
    procedure CustomizationFormNeeded;
    procedure CustomizationVisibleChanged; virtual;
    procedure OnShowCustomization(Sender: TObject);
    procedure OnHideCustomization(Sender: TObject);
    procedure Refresh; virtual;
  public
    destructor Destroy; override;
    property Form: TcxPivotGridCustomCustomizationForm read Getform;
    property FormBounds: TRect read GetFormBounds write SetFormBounds;
    property Visible: Boolean read GetVisible write SetVisible;
  end;

  { TcxPivotGridOptionsDataField }

  TcxPivotGridOptionsDataField = class(TcxPivotGridCustomOptions, IUnknown, IcxPivotGridSizableObject, IcxPivotGridField)
  private
    FArea: TcxPivotGridDataFieldArea;
    FAreaIndex: Integer;
    FCaption: string;
    FIsCaptionAssigned: Boolean;
    FMoving: Boolean;
    FViewInfo: TcxPivotGridFieldHeaderCellViewInfo;
    FMinWidth: Integer;
    FWidth: Integer;
    function GetActualWidth: Integer;
    function GetCaption: string;
    function GetDataBuilder: TcxPivotGridDataBuilder;
    function GetHeaderWidth: Integer;
    procedure SetArea(AValue: TcxPivotGridDataFieldArea);
    procedure SetAreaIndex(AValue: Integer);
    procedure SetCaption(const AValue: string);
    procedure SetWidth(AValue: Integer);
    // IcxPivotGridField
    procedure ChangeExpanding;
    procedure ChangeSorting;
    function GetMinWidth: Integer;
    function GetViewInfo: TcxPivotGridFieldHeaderCellViewInfo;
    function GetVisible: Boolean;
    procedure SetMinWidth(AValue: Integer);
    procedure SetState(AState: TcxButtonState);
    procedure SetVisible(AValue: Boolean);
  protected
    function CanDrag: Boolean; virtual;
    function CanDrop(Area: TcxPivotGridFieldArea): Boolean; virtual;
    function CanRemove: Boolean; virtual;
    function CanResize: Boolean;
    function CheckIndex(AIndex: Integer; AFields: TcxPivotGridFields; AArea: TcxPivotGridFieldArea): Integer;
    procedure DragDrop(AArea: TcxPivotGridFieldArea; AIndex: Integer); virtual;
    function GetActualAreaIndex(AInHeaderArea: Boolean = True): Integer;
    function IsSameArea(AArea: TcxPivotGridFieldArea): Boolean;
    //IUnknown
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;

    property ActualWidth: Integer read GetActualWidth;
    property DataBuilder: TcxPivotGridDataBuilder read GetDataBuilder;
    property HeaderWidth: Integer read GetHeaderWidth;
    property ViewInfo: TcxPivotGridFieldHeaderCellViewInfo read FViewInfo;
  public
    constructor Create(AOwner: TcxCustomPivotGrid); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure ApplyBestFit;
  published
    property Area: TcxPivotGridDataFieldArea read FArea write SetArea default dfaNone;
    property AreaIndex: Integer read FAreaIndex write SetAreaIndex default -1;
    property IsCaptionAssigned: Boolean read FIsCaptionAssigned write FIsCaptionAssigned default False;
    property Caption: string read GetCaption write SetCaption stored FIsCaptionAssigned;
    property Moving: Boolean read FMoving write FMoving default True;
    property MinWidth: Integer read GetMinWidth write SetMinWidth default cxPivotGridDefaultFieldMinWidth;
    property Width: Integer read FWidth write SetWidth default cxPivotGridDefaultFieldWidth;
  end;

// ViewInfo

  { TcxPivotGridCustomCellViewInfo }

  TcxPivotGridCustomCellViewInfo = class
  private
    function GetBitmap: TBitmap;
    function GetColor: TColor;
    function GetFont: TFont;
    function GetTextColor: TColor;
    procedure SetBitmap(AValue: TBitmap);
    procedure SetColor(AValue: TColor);
    procedure SetTextColor(AValue: TColor);
  protected
    FBorders: TcxBorders;
    FBounds: TRect;
    FCanvas: TcxCanvas;
    FClipRect: TRect;
    FDisplayText: string;
    FHasClipping: Boolean;
    FIsHotTrack: Boolean;
    FPainter: TcxCustomLookAndFeelPainterClass;
    FTransparent: Boolean;
    FViewParams: TcxViewParams;
    FVisible: Boolean;
    FVisibleInfoCalculated: Boolean;
    procedure AfterCustomDraw(ACanvas: TcxCanvas); virtual;
    procedure BeforeCustomDraw(ACanvas: TcxCanvas); virtual;
    procedure CalculateCellBounds(const ABounds, AVisibleRect: TRect);
    procedure CalculateVisibleInfo; virtual;
    function CheckClipping(ANeedClip: Boolean): Boolean;
    procedure CorrectBoundsForPrinting(ABounds: TRect); virtual;
    procedure DoDraw; virtual;
    function ExcludeBorders(const ABounds: TRect; ABorders: TcxBorders): TRect;
    function ExcludeFromPaint(ACanvas: TcxCanvas): Boolean; virtual;
    function GetHintText: string; virtual;
    function GetHitTest(AHitTest: TcxPivotGridHitTest): Boolean; virtual;
    function GetDisplayText: string; virtual;
    function NeedShowHint(const APoint: TPoint): Boolean; virtual;
    function SetHotTrack(AHitTest: TcxPivotGridHitTest): Boolean; virtual;

    property Borders: TcxBorders read FBorders write FBorders;
    property DisplayText: string read GetDisplayText write FDisplayText;
    property HintText: string read GetHintText;
  public
    constructor Create(APainter: TcxCustomLookAndFeelPainterClass;
      const ABounds, AVisibleRect: TRect; const AViewParams: TcxViewParams); virtual;
    procedure CheckVisibleInfo;
    procedure Draw(ACanvas: TcxCanvas); virtual;

    property Bitmap: TBitmap read GetBitmap write SetBitmap;
    property Bounds: TRect read FBounds;
    property Canvas: TcxCanvas read FCanvas;
    property ClipRect: TRect read FClipRect;
    property Color: TColor read GetColor write SetColor;
    property Font: TFont read GetFont;
    property HasClipping: Boolean read FHasClipping;
    property Painter: TcxCustomLookAndFeelPainterClass read FPainter;
    property TextColor: TColor read GetTextColor write SetTextColor;
    property Transparent: Boolean read FTransparent write FTransparent;
    property ViewParams: TcxViewParams read FViewParams write FViewParams;
    property Visible: Boolean read FVisible;
  end;

  { TcxPivotGridEditContainerViewInfo }

  TcxPivotGridEditContainerViewInfo = class(TcxPivotGridCustomCellViewInfo)
  private
    FUseLocalViewData: Boolean;
    FUseLocalEditStyle: Boolean;
  protected
    FAlignment: TAlignment;
    FCalculated: Boolean;
    FEditViewData: TcxCustomEditViewData;
    FEditViewInfo: TcxCustomEditViewInfo;
    FDataField: TcxPivotGridField;
    FEditStyle: TcxEditStyle;
    FMultiLine: Boolean;
    FProperties: TcxCustomEditProperties;
    FShowEndEllipsis: Boolean;
    FTextBounds: TRect;
    FValue: Variant;
    FAlignVert: TcxAlignmentVert;
    procedure InitEditStyle;
    procedure CalculateEditViewInfo(AEditViewInfo: TcxCustomEditViewInfo;
      const AMousePos: TPoint);
    procedure CalculateVisibleInfo; override;
    function CreateEditViewInfo: TcxCustomEditViewInfo;
    procedure CreateEditViewData;
    procedure DestroyEditViewData;
    procedure DrawUsingEditProperties; virtual;
    function GetDisplayText: string; override;
    procedure InitializeProperties;
    function OnGetDisplayTextSupported: Boolean; virtual;
    procedure ReleaseEditStyle;
    function UseEditProperties: Boolean; virtual;
  public
    destructor Destroy; override;

    property Properties: TcxCustomEditProperties read FProperties;
    property Value: Variant read FValue;
  end;

  { TcxPivotGridHeaderCellViewInfo }

  TcxPivotGridHeaderCellViewInfo = class(TcxPivotGridEditContainerViewInfo)
  private
    procedure SetData(AValue: TObject);
  protected
    FBackground: TcxPivotGridHeaderBackgroundCellViewInfo;
    FButtonRect: TRect;
    FData: TObject;
    FExpanded: Boolean;
    FField: TPersistent;
    FHasButton: Boolean;
    FImages: TCustomImageList;
    FImageAlignHorz: TAlignment;
    FImageAlignVert: TcxAlignmentVert;
    FImageIndex: Integer;
    FImageRect: TRect;
    FNeighbors: TcxNeighbors;
    FSizeField: TPersistent;
    FSortMarkBounds: TRect;
    FSortOrder: TcxDataSortOrder;
    FState: TcxButtonState;
    procedure CalculateImageInfo; virtual;
    procedure CalculateSortingInfo; virtual;
    procedure CalculateVisibleInfo; override;
    function CanDrawBackgroundFirst: Boolean; virtual;
    procedure CheckSizingArea(AHitTest: TcxPivotGridHitTest); virtual;
    function DrawBackgroundProc(ACanvas: TcxCanvas; const ABounds: TRect): Boolean; virtual;
    procedure DoDraw; override;
    procedure DrawHeaderText;
    function GetHitTest(AHitTest: TcxPivotGridHitTest): Boolean; override;
    function GetIsLast: Boolean; virtual;
    function IsSingle: Boolean; virtual;
    function NeedShowHint(const APoint: TPoint): Boolean; override;
    function UseEditProperties: Boolean; override;
  protected
    function GetDisplayText: string; override;
    property Data: TObject read FData write SetData;
  public
    constructor Create(APainter: TcxCustomLookAndFeelPainterClass; const ABounds,
      AVisibleRect: TRect; const AViewParams: TcxViewParams; const ADisplayText: string); reintroduce; overload;

    property AlignHorz: TAlignment read FAlignment write FAlignment;
    property AlignVert: TcxAlignmentVert read FAlignVert write FAlignVert;
    property Background: TcxPivotGridHeaderBackgroundCellViewInfo read FBackground;
    property Borders;
    property ButtonRect: TRect read FButtonRect;
    property DisplayText;
    property Expanded: Boolean read FExpanded write FExpanded;
    property Field: TPersistent read FField;
    property HasButton: Boolean read FHasButton;
    property ImageAlignHorz: TAlignment read FImageAlignHorz;
    property ImageAlignVert: TcxAlignmentVert read FImageAlignVert;
    property ImageIndex: Integer read FImageIndex;
    property ImageRect: TRect read FImageRect;
    property Images: TCustomImageList read FImages;
    property MultiLine: Boolean read FMultiLine write FMultiLine;
    property Neighbors: TcxNeighbors read FNeighbors write FNeighbors;
    property ShowEndEllipsis: Boolean read FShowEndEllipsis write FShowEndEllipsis;
    property SortMarkBounds: TRect read FSortMarkBounds;
    property SortOrder: TcxDataSortOrder read FSortOrder write FSortOrder;
    property State: TcxButtonState read FState write FState;
    property TextBounds: TRect read FTextBounds;
  end;

  { TcxPivotGridFieldHeaderCellViewInfo }

  TcxPivotGridFieldHeaderCellViewInfo = class(TcxPivotGridHeaderCellViewInfo)
  private
    function GetFocused: Boolean;
  protected
    FArea: TcxPivotGridFieldArea;
    FAreaIndex: Integer;
    FFilterActive: Boolean;
    FFilterBounds: TRect;
    FFilterState: TcxButtonState;
    FFocused: Boolean;
    FGroup: TcxPivotGridFieldGroup;
    procedure CalculateFilterInfo;
    procedure CalculateSortingInfo; override;
    function CanDrawBackgroundFirst: Boolean; override;
    procedure DoDraw; override;
    function ExcludeFromPaint(ACanvas: TcxCanvas): Boolean; override;
    function GetHitTest(AHitTest: TcxPivotGridHitTest): Boolean; override;
    function GetIsLast: Boolean; override;
    function IsSingle: Boolean; override;
    function NeedShowHint(const APoint: TPoint): Boolean; override;
    function SetHotTrack(AHitTest: TcxPivotGridHitTest): Boolean; override;
    function SingleOrLeftMostInGroup: Boolean;
    function SingleOrRightMostInGroup: Boolean;
    function UseEditProperties: Boolean; override;
  public
    constructor CreateEx(AOwner: TPersistent); virtual;
    procedure Initialize(ACanvas: TcxCanvas;
      APainter: TcxCustomLookAndFeelPainterClass; const AViewParams: TcxViewParams);
    function MeasureHeight: Integer;
    function MeasureWidth: Integer;
    procedure SetBounds(const ABounds, AClipRect: TRect);
    procedure PaintTo(ACanvas: TcxCanvas; const ABounds: TRect; AState: TcxButtonState;
      AHandler: TcxPivotGridCustomDrawEvent);

    property Area: TcxPivotGridFieldArea read FArea;
    property AreaIndex: Integer read FAreaIndex;
    property FilterActive: Boolean read FFilterActive;
    property FilterBounds: TRect read FFilterBounds;
    property FilterState: TcxButtonState read FFilterState write FFilterState;
    property Focused: Boolean read FFocused;
    property Group: TcxPivotGridFieldGroup read FGroup;
  end;

  { TcxPivotGridDataCellViewInfo }

  TcxPivotGridFocusRectStyle = (frsNone, frsDot, frsLine);

  TcxPivotGridDataCellLimitValueType = (lvtColumnMaximum, lvtColumnMinimum,
    lvtRowMaximum, lvtRowMinimum, lvtMaximum, lvtMinimum);
  TcxPivotGridDataCellLimitValueTypes = set of TcxPivotGridDataCellLimitValueType;

  TcxPivotGridDataCellViewInfo = class(TcxPivotGridEditContainerViewInfo)
  private
    function GetColumnIndex: Integer;
    function GetDisplayFormat: string;
    function GetIsGrandTotal: Boolean;
    function GetIsTotal: Boolean;
    function GetLimitValueTypes: TcxPivotGridDataCellLimitValueTypes;
    function GetRowIndex: Integer;
  protected
    FBorderColor: Integer;
    FCellSummary: TcxPivotGridCrossCellSummary;
    FColumn: TcxPivotGridViewDataItem;
    FCrossCell: TcxPivotGridCrossCell;
    FFocusRectStyle: TcxPivotGridFocusRectStyle;
    FIsTotal: Boolean;
    FIsTotalAssigned: Boolean;
    FMarkNarrowCells: Boolean;
    FRow: TcxPivotGridViewDataItem;
    FSelected: Boolean;
    FSummaryType: TcxPivotGridSummaryType;
    FTotal: TcxPivotGridCustomTotal;
    procedure CalculateVisibleInfo; override;
    procedure DoDraw; override;
    procedure DrawText;
    procedure FormatDisplayValue;
    function GetHintText: string; override;
    function GetHitTest(AHitTest: TcxPivotGridHitTest): Boolean; override;
    function NeedShowHint(const APoint: TPoint): Boolean; override;
    function OnGetDisplayTextSupported: Boolean; override;
    function ReplaceDigitsByPattern(const ADisplayText: string): string;

    property DisplayFormat: string read GetDisplayFormat;
  public
    procedure Initialize(ARow, AColumn: TcxPivotGridViewDataItem; ADataField: TcxPivotGridField);
    function MeasureWidth: Integer;

    property Align: TAlignment read FAlignment write FAlignment;
    property BorderColor: Integer read FBorderColor write FBorderColor;
    property Borders;
    property CellSummary: TcxPivotGridCrossCellSummary read FCellSummary;
    property Column: TcxPivotGridViewDataItem read FColumn;
    property ColumnIndex: Integer read GetColumnIndex;
    property CrossCell: TcxPivotGridCrossCell read FCrossCell;
    property DataField: TcxPivotGridField read FDataField;
    property DisplayText;
    property FocusRectStyle: TcxPivotGridFocusRectStyle read FFocusRectStyle write FFocusRectStyle;
    property IsGrandTotal: Boolean read GetIsGrandTotal;
    property IsTotal: Boolean read GetIsTotal;
    property LimitValueTypes: TcxPivotGridDataCellLimitValueTypes read GetLimitValueTypes;
    property MarkNarrowCells: Boolean read FMarkNarrowCells write FMarkNarrowCells;
    property Row: TcxPivotGridViewDataItem read FRow;
    property RowIndex: Integer read GetRowIndex;
    property Selected: Boolean read FSelected;
    property SummaryType: TcxPivotGridSummaryType read FSummaryType;
    property TextBounds: TRect read FTextBounds;
    property Total: TcxPivotGridCustomTotal read FTotal;
  end;

  { TcxPivotGridHeaderBackgroundCellViewInfo }

  TcxPivotGridHeaderBackgroundCellViewInfo = class(TcxPivotGridCustomCellViewInfo)
  protected
    FArea: TcxPivotGridFieldArea;
    FFieldHeadersBounds: TcxRect;
    FHasFields: Boolean;
    procedure CorrectBoundsForPrinting(ABounds: TRect); override;
    procedure DoDraw; override;
    function GetHitTest(AHitTest: TcxPivotGridHitTest): Boolean; override;
  public
    property Area: TcxPivotGridFieldArea read FArea;
    property DisplayText;
    property FieldHeadersBounds: TcxRect read FFieldHeadersBounds;
    property HasFields: Boolean read FHasFields;
  end;

  TcxPivotGridPrefilterButtonAlignment = (pfbaLeft, pfbaRight);
  TcxPivotGridPrefilterPartsViewInfo = class;

  TcxPivotGridPrefilterPartViewInfo = class
  private
    FBounds: TRect;
    FDroppedDown: Boolean;
    FPartsViewInfo: TcxPivotGridPrefilterPartsViewInfo;
    FPainter: TcxCustomLookAndFeelPainterClass;
    FPrefilter: TcxPivotGridPrefilter;
    FState: TcxButtonState;
  protected
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); virtual;
    function CalculateHeight: Integer; virtual; abstract;
    function CalculateWidth: Integer; virtual; abstract;
    procedure Click; virtual;
    procedure DoDraw(ACanvas: TcxCanvas); virtual; abstract;
    function GetAlignment: TcxPivotGridPrefilterButtonAlignment; virtual;
    function GetPartIndex: Integer; virtual; abstract;
    function GetHitTest(AHitTest: TcxPivotGridHitTest): Boolean; virtual;
    function GetState: TcxButtonState; virtual;
    function GetVisible: Boolean; virtual;
    procedure SetDroppedDown(AHitTest: TcxPivotGridHitTest; ADroppedDown: Boolean); virtual;
    function SetHotTrack(AHitTest: TcxPivotGridHitTest): Boolean; virtual;
    function SetPressed(AHitTest: TcxPivotGridHitTest; AMouseDown: Boolean): Boolean; virtual;

    property Alignment: TcxPivotGridPrefilterButtonAlignment read GetAlignment;
    property Bounds: TRect read FBounds;
    property State: TcxButtonState read GetState;
    property Visible: Boolean read GetVisible;
  public
    constructor Create(APartsViewInfo: TcxPivotGridPrefilterPartsViewInfo); virtual;
    procedure Draw(ACanvas: TcxCanvas);
  end;
  TcxPivotGridPrefilterPartViewInfoClass = class of TcxPivotGridPrefilterPartViewInfo;

  TcxPivotGridPrefilterCloseButtonViewInfo = class(TcxPivotGridPrefilterPartViewInfo)
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    procedure Click; override;
    procedure DoDraw(ACanvas: TcxCanvas); override;
    function GetPartIndex: Integer; override;
  end;

  TcxPivotGridPrefilterActivateButtonViewInfo = class(TcxPivotGridPrefilterPartViewInfo)
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    procedure Click; override;
    procedure DoDraw(ACanvas: TcxCanvas); override;
    function GetPartIndex: Integer; override;
    function GetChecked: Boolean;
  end;

  TcxPivotGridPrefilterCustomizeButtonViewInfo = class(TcxPivotGridPrefilterPartViewInfo)
  private
    function GetFont: TFont;
    function GetText: string;
    function GetTextOffset: Integer;
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    procedure Click; override;
    function GetAlignment: TcxPivotGridPrefilterButtonAlignment; override;
    function GetBorderWidth(AIndex: TcxBorder): Integer;
    function GetVisible: Boolean; override;
    procedure DoDraw(ACanvas: TcxCanvas); override;
    function GetPartIndex: Integer; override;
  end;

  TcxPivotGridPrefilterDropDownButtonViewInfo = class(TcxPivotGridPrefilterPartViewInfo)
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    procedure DoDraw(ACanvas: TcxCanvas); override;
    function GetAlignment: TcxPivotGridPrefilterButtonAlignment; override;
    function GetPartIndex: Integer; override;
    function GetVisible: Boolean; override;
  end;

  TcxPivotGridPrefilterCaptionViewInfo = class(TcxPivotGridPrefilterPartViewInfo)
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    procedure DoDraw(ACanvas: TcxCanvas); override;
    function GetAlignment: TcxPivotGridPrefilterButtonAlignment; override;
    function GetPartIndex: Integer; override;
    function GetState: TcxButtonState; override;
    function GetVisible: Boolean; override;
    procedure SetDroppedDown(AHitTest: TcxPivotGridHitTest; ADroppedDown: Boolean); override;
  end;

  TcxPivotGridPrefilterPartsViewInfo = class
  private
    FCaptionViewInfo: TcxPivotGridPrefilterCaptionViewInfo;
    FDropDownButtonViewInfo: TcxPivotGridPrefilterDropDownButtonViewInfo;
    FPrefilterViewInfo: TcxPivotGridPrefilterViewInfo;
    FItems: TcxObjectList;
    function GetCount: Integer;
    function GetHeight: Integer;
    function GetItem(Index: Integer): TcxPivotGridPrefilterPartViewInfo;
  protected
    procedure AddItems; virtual;
    procedure DestroyItems; virtual;
    function GetDropDownPartBounds: TRect;
    procedure SetDroppedDown(AHitTest: TcxPivotGridHitTest; ADroppedDown: Boolean);
    function SetHotTrack(AHitTest: TcxPivotGridHitTest): Boolean;
    function SetPressed(AHitTest: TcxPivotGridHitTest; AMouseDown: Boolean): Boolean;
    property PrefilterViewInfo: TcxPivotGridPrefilterViewInfo read FPrefilterViewInfo;
  public
    constructor Create(APreFilterViewInfo: TcxPivotGridPrefilterViewInfo); virtual;
    destructor Destroy; override;
    function AddItem(AItemClass: TcxPivotGridPrefilterPartViewInfoClass): TcxPivotGridPrefilterPartViewInfo;
    procedure Calculate(const ABounds: TRect); virtual;
    procedure DrawParts;
    function GetHitTest(AHitTest: TcxPivotGridHitTest): Boolean; virtual;

    property Count: Integer read GetCount;
    property Height: Integer read GetHeight;
    property Items[Index: Integer]: TcxPivotGridPrefilterPartViewInfo read GetItem; default;
  end;

  { TcxPivotGridPrefilterViewInfo }

  TcxPivotGridPrefilterViewInfo = class(TcxPivotGridCustomCellViewInfo)
  private
    FPartsViewInfo: TcxPivotGridPrefilterPartsViewInfo;
    FPrefilter: TcxPivotGridPrefilter;
    procedure DrawBackground;
  protected
    procedure CalculateVisibleInfo; override;
    procedure CorrectBoundsForPrinting(ABounds: TRect); override;
    procedure DoDraw; override;
    function GetHeight: Integer;
    function GetHitTest(AHitTest: TcxPivotGridHitTest): Boolean; override;
    function GetTextWidth: Integer;
    function GetDropDownWindowOwnerBounds: TRect;
    procedure SetDroppedDown(AHitTest: TcxPivotGridHitTest; ADroppedDown: Boolean);
    function SetHotTrack(AHitTest: TcxPivotGridHitTest): Boolean; override;
    function SetPressed(AHitTest: TcxPivotGridHitTest; AMouseDown: Boolean): Boolean;
  public
    constructor Create(APrefilter: TcxPivotGridPrefilter; APainter: TcxCustomLookAndFeelPainterClass;
      const ABounds, AVisibleRect: TRect; const AViewParams: TcxViewParams); reintroduce; overload;
    destructor Destroy; override;
    property DisplayText;
    property Prefilter: TcxPivotGridPrefilter read FPrefilter;
  end;

  { TcxPivotGridFilterSeparatorCellViewInfo }

  TcxPivotGridFilterSeparatorCellViewInfo = class(TcxPivotGridCustomCellViewInfo)
  private
    FIndentSize: Integer;
  protected
    procedure DoDraw; override;
  public
    constructor Create(APainter: TcxCustomLookAndFeelPainterClass;
      const ABounds, AVisibleRect: TRect; const AViewParams: TcxViewParams); override;

    property IndentSize: Integer read FIndentSize write FIndentSize;
  end;

  { TcxPivotGridViewInfo }

  TcxPivotGridViewInfo = class
  private
    FBounds: TRect;
    FCanvas: TcxCanvas;
    FColumnHeaders: TcxPivotGridCells;
    FCommonCells: TcxPivotGridCells;
    FDataCells: TcxPivotGridCells;
    FFieldHeaders: TcxPivotGridCells;
    FPainter: TcxCustomLookAndFeelPainterClass;
    FPivotGrid: TcxCustomPivotGrid;
    FPrefilter: TcxPivotGridPrefilter;
    FRowHeaders: TcxPivotGridCells;
    function GetColumnFieldsCount: Integer;
    function GetDataBuilder: TcxPivotGridDataBuilder;
    function GetFocusedCell: TPoint;
    function GetIconsSize: TSize;
    function GetOptionsDataField: TcxPivotGridOptionsDataField;
    function GetOptionsView: TcxPivotGridOptionsView;
    function GetRowFieldsCount: Integer;
    function GetStyles: TcxPivotGridStyles;
    function GetViewData: TcxPivotGridViewData;
  protected
    FBaseStyles: IcxPivotGridBaseStyles;
    FCellsBounds: TRect;
    FColStart: TcxPivotGridViewDataItem;
    FColumnBounds: TRect;
    FColumnHeadersHeight: Integer;
    FColumnItems: TcxList;
    FColumnRowCount: Integer;
    FDataCellsBounds: TRect;
    FDataFieldsWidth: Integer;
    FDragDropAreas: TcxObjectList;
    FDrawBorders: Boolean;
    FDrawExpandButtons: Boolean;
    FFieldHeaderHeight: Integer;
    FFieldHeadersBounds: TcxRect;
    FFilterHeight: Integer;
    FHeaderHeight: Integer;
    FIsPrinting: Boolean;
    FNeedCorrectHeaders: Boolean;
    FRowColumnPos: TcxList;
    FRowHeadersHeight: Integer;
    FRowHeadersWidth: Integer;
    FRowItems: TcxList;
    FRowsBounds: TRect;
    FViewParams: TcxViewParams;
    function AddDragDropAreaInfo(APos: Integer; const ABounds, ADisplayBounds: TRect;
      AArea: TcxPivotGridFieldArea; AAreaIndex: Integer; AField: TPersistent): TcxPivotGridDragDropAreaInfo;
    function AddFieldHeader(const ABounds: TRect; AField: TcxPivotGridField;
      AArea: TcxPivotGridFieldArea; AAreaIndex: Integer): TcxPivotGridFieldHeaderCellViewInfo;

    function AddFieldsBackground(const ABounds: TRect; const ADescription: string;
      AHasDescription: Boolean; AArea: TcxPivotGridFieldArea): TcxPivotGridHeaderBackgroundCellViewInfo;
    function AddFilterSeparator(const ATop: Integer): TcxPivotGridFilterSeparatorCellViewInfo;

    procedure AfterPaint; virtual;
    procedure BeforePaint; virtual;

    function GetDataFieldFromViewData(AItem: TcxPivotGridViewDataItem): TcxPivotGridField;
    function GetFont(AStyleIndex: Integer): TFont;
    function GetRowColumnPos(ALevel: Integer; var ALevelField: TPersistent): Integer;
    function GetRowField(AIndex: Integer): TcxPivotGridField;
    function GetStartColumnIndex: Integer; virtual;
    function GetStartRowIndex: Integer; virtual;
    function GroupHeaderOutOfBounds(AField: TcxPivotGridField; ARight: Integer): Boolean;

    procedure CalculateCells;
    procedure CalculateFieldsLayout;
    procedure CalculateFilterLayout;
    procedure CheckCellSelection(ACell: TcxPivotGridDataCellViewInfo); virtual;
    procedure CorrectBackground;
    procedure DoCalculate; virtual;
    function GetHeaderDisplayText(ACell: TcxPivotGridHeaderCellViewInfo; AItem: TcxPivotGridViewDataItem): string; virtual;

    function AddPartBackground(ABounds: TRect): TcxPivotGridCustomCellViewInfo;
    function AddColumnItem(ABounds: TRect; AItem: TcxPivotGridViewDataItem): TcxPivotGridHeaderCellViewInfo;
    function AddDataCell(ARow, AColumn: TcxPivotGridViewDataItem; ALeft, ATop: Integer): TcxPivotGridDataCellViewInfo;
    function AddRowItem(ABounds: TRect; AItem: TcxPivotGridViewDataItem;
      ASizeField: TPersistent): TcxPivotGridHeaderCellViewInfo;

    procedure InitCellViewParams(ACell: TcxPivotGridDataCellViewInfo);
    procedure InitializeFields; virtual;

    procedure InitHeaderCell(ACell: TcxPivotGridHeaderCellViewInfo; AItem: TcxPivotGridViewDataItem);
    function IsDataFieldVisible(AArea: TcxPivotGridDataFieldAreas = []): Boolean;
    procedure CalculateRows;
    procedure CreateRows(ARows: TcxList);

    procedure CreateColumns(AColumns: TcxList);

    procedure CalculateColumns;
    procedure CalculateColumnsFields;
    procedure CalculateDataItemsFields;
    procedure CalculateRowsFields;

    procedure CreateDragDropAreaInfo(const AAreaBounds: TRect;
      AStartIndex: Integer; AArea: TcxPivotGridFieldArea); virtual;

    function IsGroupItemExist(AList: TList; AItem: TcxPivotGridViewDataItem): Boolean;
    function PrepareViewDataItems(var AList: TcxList; AStartItem: TcxPivotGridViewDataItem;
      AAvailableSize: Integer; var AStartIndex: Integer): Integer;
    function SpaceBetween(AItem1, AItem2: TcxPivotGridViewDataItem): Integer;
  public
    constructor Create(AOwner: TcxCustomPivotGrid); virtual;
    destructor Destroy; override;
    procedure Calculate; virtual;
    procedure CalculateHitTest(AHitTest: TcxPivotGridHitTest); virtual;
    procedure Clear;
    procedure InvalidateRect(const ARect: TRect);
    procedure SelectionChanged;

    property Bounds: TRect read FBounds;
    property BaseStyles: IcxPivotGridBaseStyles read FBaseStyles;
    property Canvas: TcxCanvas read FCanvas;
    property CommonCells: TcxPivotGridCells read FCommonCells;
    property ColumnFieldsCount: Integer read GetColumnFieldsCount;
    property ColumnsBounds: TRect read FColumnBounds;
    property ColumnHeaders: TcxPivotGridCells read FColumnHeaders;
    property ColumnHeadersHeight: Integer read FColumnHeadersHeight;
    property DataBuilder: TcxPivotGridDataBuilder read GetDataBuilder;
    property DataCells: TcxPivotGridCells read FDataCells;
    property DataCellsBounds: TRect read FDataCellsBounds;
    property DrawBorders: Boolean read FDrawBorders write FDrawBorders;
    property DrawExpandButtons: Boolean read FDrawExpandButtons write FDrawExpandButtons;
    property FieldHeaderHeight: Integer read FFieldHeaderHeight;
    property FieldHeaders: TcxPivotGridCells read FFieldHeaders;
    property FilterHeight: Integer read FFilterHeight;
    property FocusedCell: TPoint read GetFocusedCell;
    property HeaderHeight: Integer read FHeaderHeight;
    property IsPrinting: Boolean read FIsPrinting;
    property OptionsDataField: TcxPivotGridOptionsDataField read GetOptionsDataField;
    property OptionsView: TcxPivotGridOptionsView read GetOptionsView;
    property Painter: TcxCustomLookAndFeelPainterClass read FPainter;
    property PivotGrid: TcxCustomPivotGrid read FPivotGrid;
    property Prefilter: TcxPivotGridPrefilter read FPrefilter;
    property RowFieldsCount: Integer read GetRowFieldsCount;
    property RowHeaders: TcxPivotGridCells read FRowHeaders;
    property RowHeadersWidth: Integer read FRowHeadersWidth;
    property RowsBounds: TRect read FRowsBounds;
    property StartColumnIndex: Integer read GetStartColumnIndex;
    property StartRowIndex: Integer read GetStartRowIndex;
    property Styles: TcxPivotGridStyles read GetStyles;
    property ViewData: TcxPivotGridViewData read GetViewData;
  end;

  { TcxPivotGridPainter }

  TcxPivotGridPainter = class
  private
    FCanvas: TcxCanvas;
    FPivotGrid: TcxCustomPivotGrid;
    FViewInfo: TcxPivotGridViewInfo;
  protected
    procedure DoPaint; virtual;
    procedure DoCustomDrawFieldHeader(ACanvas: TcxCanvas;
      ACell: TcxPivotGridCustomCellViewInfo; var ADone: Boolean);
    procedure DoCustomDrawColumnHeader(ACanvas: TcxCanvas;
      ACell: TcxPivotGridCustomCellViewInfo; var ADone: Boolean);
    procedure DoCustomDrawPart(ACanvas: TcxCanvas;
      ACell: TcxPivotGridCustomCellViewInfo; var ADone: Boolean);
    procedure DoCustomDrawRowHeader(ACanvas: TcxCanvas;
      ACell: TcxPivotGridCustomCellViewInfo; var ADone: Boolean);
    procedure DoCustomDrawDataCell(ACanvas: TcxCanvas;
      ACell: TcxPivotGridCustomCellViewInfo; var ADone: Boolean);
  public
    constructor Create(AOwner: TcxCustomPivotGrid); virtual;
    procedure Paint(ACanvas: TcxCanvas);

    property Canvas: TcxCanvas read FCanvas;
    property PivotGrid: TcxCustomPivotGrid read FPivotGrid;
    property ViewInfo: TcxPivotGridViewInfo read FViewInfo;
  end;

  { IcxPivotGridBaseStyles }

  IcxPivotGridBaseStyles = interface
  ['{60482E74-4425-4CF0-86A3-818C486E895F}']
    function GetColumnHeaderParams(AColumn: TcxPivotGridViewDataItem): TcxViewParams;
    function GetContentParams(ACell: TcxPivotGridDataCellViewInfo): TcxViewParams;
    function GetFieldHeaderParams(AField: TcxPivotGridField): TcxViewParams;
    function GetHeaderBackgroundParams(AArea: TcxPivotGridFieldArea): TcxViewParams;
    function GetPrefilterParams: TcxViewParams;
    function GetRowHeaderParams(ARow: TcxPivotGridViewDataItem): TcxViewParams;
  end;

  { TcxCustomPivotGridStyles }

  TcxPivotGridGetContentStyleEvent = procedure(Sender: TcxCustomPivotGrid;
    ACell: TcxPivotGridDataCellViewInfo; var AStyle: TcxStyle) of object;
  TcxPivotGridGetHeaderItemStyleEvent = procedure(Sender: TcxCustomPivotGrid;
    AItem: TcxPivotGridViewDataItem; var AStyle: TcxStyle) of object;
  TcxPivotGridGetFieldHeaderStyleEvent = procedure(Sender: TcxCustomPivotGrid;
    AField: TcxPivotGridField; var AStyle: TcxStyle) of object;

  TcxPivotGridCustomStyles = class(TcxStyles, IcxPivotGridBaseStyles)
  private
    FSuppressContentColoration: Boolean;
    FSuppressBackgroundBitmaps: Boolean;
    FOnGetColumnHeaderStyle: TcxPivotGridGetHeaderItemStyleEvent;
    FOnGetContentStyle: TcxPivotGridGetContentStyleEvent;
    FOnGetFieldHeaderStyle: TcxPivotGridGetFieldHeaderStyleEvent;
    FOnGetRowHeaderStyle: TcxPivotGridGetHeaderItemStyleEvent;
  protected
    procedure Changed(AIndex: Integer); override;
    procedure CheckViewParams(var AParams: TcxViewParams);
    function GetContentStyleIndexByCell(ACell: TcxPivotGridDataCellViewInfo): Integer; virtual;
    procedure GetDefaultHeadersAreaViewParams(out AParams: TcxViewParams); virtual;
    procedure GetDefaultViewParams(Index: Integer;
      AData: TObject; out AParams: TcxViewParams); override;
    function GetPivotGrid: TcxCustomPivotGrid; virtual;

    property SuppressContentColoration: Boolean read FSuppressContentColoration write FSuppressContentColoration;
    property SuppressBackgroundBitmaps: Boolean read FSuppressBackgroundBitmaps write FSuppressBackgroundBitmaps;

    property Background: TcxStyle index gs_Background read GetValue write SetValue;
    property ColumnHeader: TcxStyle index gs_ColumnHeader read GetValue write SetValue;
    property ColumnHeaderArea: TcxStyle index gs_ColumnHeaderArea read GetValue write SetValue;
    property ColumnMaximumValue: TcxStyle index gs_ColumnMaximumValue read GetValue write SetValue;
    property ColumnMinimumValue: TcxStyle index gs_ColumnMinimumValue read GetValue write SetValue;
    property Content: TcxStyle index gs_Content read GetValue write SetValue;
    property DataHeaderArea: TcxStyle index gs_DataHeaderArea read GetValue write SetValue;
    property FieldHeader: TcxStyle index gs_FieldHeader read GetValue write SetValue;
    property FilterHeaderArea: TcxStyle index gs_FilterHeaderArea read GetValue write SetValue;
    property FilterSeparator: TcxStyle index gs_FilterSeparator read GetValue write SetValue;
    property HeaderBackground: TcxStyle index gs_HeaderBackground read GetValue write SetValue;
    property Inactive: TcxStyle index gs_Inactive read GetValue write SetValue;
    property MaximumValue: TcxStyle index gs_MaximumValue read GetValue write SetValue;
    property MinimumValue: TcxStyle index gs_MinimumValue read GetValue write SetValue;
    property Prefilter: TcxStyle index gs_Prefilter read GetValue write SetValue;
    property RowHeader: TcxStyle index gs_RowHeader read GetValue write SetValue;
    property RowHeaderArea: TcxStyle index gs_RowHeaderArea read GetValue write SetValue;
    property RowMaximumValue: TcxStyle index gs_RowMaximumValue read GetValue write SetValue;
    property RowMinimumValue: TcxStyle index gs_RowMinimumValue read GetValue write SetValue;
    property Selected: TcxStyle index gs_Selected read GetValue write SetValue;
    property Total: TcxStyle index gs_Total read GetValue write SetValue;
    property OnGetColumnHeaderStyle: TcxPivotGridGetHeaderItemStyleEvent read FOnGetColumnHeaderStyle write FOnGetColumnHeaderStyle;
    property OnGetContentStyle: TcxPivotGridGetContentStyleEvent read FOnGetContentStyle write FOnGetContentStyle;
    property OnGetFieldHeaderStyle: TcxPivotGridGetFieldHeaderStyleEvent read FOnGetFieldHeaderStyle write FOnGetFieldHeaderStyle;
    property OnGetRowHeaderStyle: TcxPivotGridGetHeaderItemStyleEvent read FOnGetRowHeaderStyle write FOnGetRowHeaderStyle;
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
    function GetBackgroundParams: TcxViewParams; virtual;
    function GetColumnHeaderParams(AColumn: TcxPivotGridViewDataItem): TcxViewParams; virtual;
    function GetColumnMaximumValueParams: TcxViewParams; virtual;
    function GetColumnMinimumValueParams: TcxViewParams; virtual;
    function GetContentParams(ACell: TcxPivotGridDataCellViewInfo): TcxViewParams; virtual;
    function GetFieldHeaderParams(AField: TcxPivotGridField): TcxViewParams; virtual;
    function GetFilterSeparatorParams: TcxViewParams; virtual;
    function GetHeaderBackgroundParams(AArea: TcxPivotGridFieldArea): TcxViewParams; virtual;
    function GetMaximumValueParams: TcxViewParams; virtual;
    function GetMinimumValueParams: TcxViewParams; virtual;
    function GetPrefilterParams: TcxViewParams; virtual;
    function GetRowHeaderParams(ARow: TcxPivotGridViewDataItem): TcxViewParams; virtual;
    function GetRowMaximumValueParams: TcxViewParams; virtual;
    function GetRowMinimumValueParams: TcxViewParams; virtual;
    function GetSelectionParams: TcxViewParams; virtual;

    property PivotGrid: TcxCustomPivotGrid read GetPivotGrid;
  end;

  { TcxPivotGridStyles }

  TcxPivotGridStyles = class(TcxPivotGridCustomStyles)
  public
    function GetColumnHeaderParams(AColumn: TcxPivotGridViewDataItem): TcxViewParams; override;
    function GetContentParams(ACell: TcxPivotGridDataCellViewInfo): TcxViewParams; override;
    function GetRowHeaderParams(ARow: TcxPivotGridViewDataItem): TcxViewParams; override;
  published
    property Background;
    property ColumnHeader;
    property ColumnHeaderArea;
    property ColumnMaximumValue;
    property ColumnMinimumValue;
    property Content;
    property DataHeaderArea;
    property FieldHeader;
    property FilterHeaderArea;
    property FilterSeparator;
    property HeaderBackground;
    property Inactive;
    property MaximumValue;
    property MinimumValue;
    property Prefilter;
    property RowHeader;
    property RowHeaderArea;
    property RowMaximumValue;
    property RowMinimumValue;
    property Selected;
    property StyleSheet;
    property Total;
    property OnGetColumnHeaderStyle;
    property OnGetContentStyle;
    property OnGetFieldHeaderStyle;
    property OnGetRowHeaderStyle;
  end;

  { TcxPivotGridFieldStyles }

  TcxPivotGridFieldStyles = class(TcxPivotGridCustomStyles)
  protected
    procedure GetDefaultViewParams(Index: Integer;
      AData: TObject; out AParams: TcxViewParams); override;
    function GetPivotGrid: TcxCustomPivotGrid; override;
  published
    property ColumnHeader;
    property ColumnMaximumValue;
    property ColumnMinimumValue;
    property Content;
    property MaximumValue;
    property MinimumValue;
    property RowHeader;
    property RowMaximumValue;
    property RowMinimumValue;
    property Total;
    property OnGetColumnHeaderStyle;
    property OnGetContentStyle;
    property OnGetRowHeaderStyle;
  end;

  { TcxPivotGridStyleSheet }

  TcxPivotGridStyleSheet = class(TcxCustomStyleSheet)
  private
    function GetStylesValue: TcxPivotGridStyles;
    procedure SetStylesValue(AValue: TcxPivotGridStyles);
  public
    class function GetStylesClass: TcxCustomStylesClass; override;
  published
    property Styles: TcxPivotGridStyles read GetStylesValue write SetStylesValue;
  end;

// PivotGrid Base Classes

  { TcxPivotGridDataController }

  TcxPivotGridDataController = class(TcxCustomDataController)
  private
    function GetPivotGrid: TcxCustomPivotGrid;
  protected
    procedure FilterChanged; override;
    procedure UpdateControl(AInfo: TcxUpdateControlInfo); override;

    property PivotGrid: TcxCustomPivotGrid read GetPivotGrid;
  public
    function GetFilterItemFieldCaption(AItem: TObject): string; override;
    function GetItem(Index: Integer): TObject; override;
    function GetItemValueSource(AItemIndex: Integer): TcxDataEditValueSource; override;
    function GetItemID(AItem: TObject): Integer; override;
    procedure UpdateData; override;
    procedure UpdateItemIndexes; override;
  end;

  { TcxPivotGridOLAPField }

  TcxPivotGridOLAPField = class
  private
    class function IsFilteredOLAP(AField: TcxPivotGridField): Boolean;
  public
    Caption: WideString;
    Dimension: IUnknown;
    DimensionName: WideString;
    DimensionUniqueName: WideString;
    GroupIndex: Integer;
    GroupName: string;
    Hierarchy: IUnknown;
    HierarchyName: WideString;
    HierarchyUniqueName: WideString;
    IsMeasure: Boolean;
    Level: IUnknown;
    UniqueName: WideString;
    destructor Destroy; override;
    class function FilteredValueCount(AField: TcxPivotGridField;
      IsExpanding: Boolean = False): Integer;
    class function IsFiltered(AField: TcxPivotGridField): Boolean;
    class function PopulateFilteredValues(AField: TcxPivotGridField;
      IsExpanding: Boolean = False): TInterfaceList;
  end;

  TcxPivotGridInitializeFieldEvent = procedure(Sender: TcxPivotGridCustomOLAPDataSource; AField: TcxPivotGridField) of object;

  { TcxPivotGridCustomOLAPDataSource }

  TcxPivotGridCustomOLAPDataSource = class(TComponent)
  private
    FActive: Boolean;
    FListeners: TList;
    FOnInitializeField: TcxPivotGridInitializeFieldEvent;
    function GetField(AIndex: Integer): TcxPivotGridOLAPField;
    function GetFieldCount: Integer;
    function GetListenerCount: Integer;
    function GetListener(AIndex: Integer): TcxCustomPivotGrid;
    function GetMeasure(AIndex: Integer): TcxPivotGridOLAPField;
    function GetMeasureCount: Integer;
    procedure SetActive(AValue: Boolean);
  protected
    FFields: TcxObjectList;
    FMeasures: TcxObjectList;
    procedure AddListener(AListener: TcxCustomPivotGrid);
    procedure Changed; virtual;
    procedure Clear; virtual;
    function CreateDrillDownDataSource(ACell: TcxPivotGridCrossCell; FieldList: TcxObjectList): TcxPivotGridCrossCellDataSource; overload; virtual;
    function CreateDrillDownDataSource(ACells: TList; FieldList: TcxObjectList): TcxPivotGridCrossCellDataSource; overload; virtual;
    function CreateField(APivotGrid: TcxCustomPivotGrid; AOLAPField: TcxPivotGridOLAPField): TcxPivotGridField; virtual;
    procedure CreateFieldsFromFieldsList(APivotGrid: TcxCustomPivotGrid; AOLAPFields: TcxObjectList);
    procedure CreateMembers(AField: TcxPivotGridField; AParents: TList; AHasChildren: Boolean); virtual;
    function CreateMembersFromGroup(AItem: TcxPivotGridGroupItem;
      AIncludeParent: Boolean = True; ACheckExpanding: Boolean = False): TList;
    procedure CreateRootLayout(APivotGrid: TcxCustomPivotGrid); virtual;
    procedure DoInitializeField(AField: TcxPivotGridField); virtual;
    procedure ExpandMember(AField: TcxPivotGridField; AMember: TcxPivotGridGroupItem;
      AExpandChildren: Boolean);
    function GetHasData: Boolean; virtual;
    function GetIsActive: Boolean; virtual;
    function GetIsTerminated: Boolean; virtual;
    function GetLinkByUniqueName(const AName: WideString): TcxPivotGridOLAPField;
    procedure Initialize; virtual;
    procedure InitializeCrossCells(ARowsGroup, AColumnsGroup: TcxPivotGridGroupItem;
      ADataFields: TcxPivotGridFields); virtual;
    procedure InitializeCrossCellsForExpanding(ADataBuilder: TcxPivotGridDataBuilder;
      AnExpandingItem, ACrossGroup: TcxPivotGridGroupItem;
      ADataFields: TcxPivotGridFields); virtual;
    procedure InitializeCrossCellValues(ACell: TcxPivotGridCrossCell;
      const AFormattedValues, ANativeValues: Variant);
    procedure InitializeCrossCellValue(ACell: TcxPivotGridCrossCell;
      const AFormattedValue, ANativeValue, ANativeValues: Variant; AValueIndex: Integer);
    procedure InitializeLayout(ARowFields, AColumnFields, ADataFields,
      AFilterFields: TcxPivotGridFields); virtual;
    procedure InitializeMembersAndTotalsForExpanding(
      ADataBuilder: TcxPivotGridDataBuilder; AField: TcxPivotGridField;
      AMember: TcxPivotGridGroupItem; ADataFields: TcxPivotGridFields); virtual;
    procedure InitializeMembers(AField: TcxPivotGridOLAPField;
      AMembers: TcxPivotGridVariantList); virtual;
    procedure InitializeTotals(ADimensionFields, ADataFields,
      AFilterFields: TcxPivotGridFields); virtual;
    procedure PopulateFilteredUniqueNames(AField: TcxPivotGridOLAPField;
      AFilter: TcxPivotGridFieldFilter; var AUniqueValues: TStringList); virtual;
    procedure PopulateFilteredValues(AField: TcxPivotGridOLAPField;
      AFilter: TcxPivotGridFieldFilter; AValues: TInterfaceList;
      AUniqueValues: TStringList); virtual;
    procedure ProcessMembersForExpanding(AField: TcxPivotGridField;
      AMember: TcxPivotGridGroupItem; AExpandChildren: Boolean);
    procedure RemoveListener(AListener: TcxCustomPivotGrid);
    procedure ReplaceTotals(ADataBuilder: TcxPivotGridDataBuilder;
      AMember: TcxPivotGridGroupItem; ADataFields: TcxPivotGridFields); virtual;
    procedure ZeroCrossCellValues(ACell: TcxPivotGridCrossCell);


    property Active: Boolean read FActive write SetActive default False;
    property FieldCount: Integer read GetFieldCount;
    property Fields[Index: Integer]: TcxPivotGridOLAPField read GetField;
    property HasData: Boolean read GetHasData;
    property IsActive: Boolean read GetIsActive;
    property IsTerminated: Boolean read GetIsTerminated;
    property ListenerCount: Integer read GetListenerCount;
    property Listeners[Index: Integer]: TcxCustomPivotGrid read GetListener;
    property MeasureCount: Integer read GetMeasureCount;
    property Measures[Index: Integer]: TcxPivotGridOLAPField read GetMeasure;
    property OnInitializeField: TcxPivotGridInitializeFieldEvent read FOnInitializeField write FOnInitializeField;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RetrieveFields(APivotGrid: TcxCustomPivotGrid);
  end;

  { TcxPivotGridHitTest }

  TcxPivotGridHitTest = class
  private
    FField: TPersistent;
    FHitObject: TcxPivotGridCustomCellViewInfo;
    FHitPoint: TPoint;
    FOwner: TcxCustomPivotGrid;
    FResizeField: IcxPivotGridSizableObject;
    FResizeFieldStartPos: Integer;
    FShiftState: TShiftState;
    function GetBitState(AIndex: Integer): Boolean;
    function GetGroupItem: TcxPivotGridGroupItem;
    function GetPosValue(AIndex: Integer): Integer;
    function GetViewInfo: TcxPivotGridViewInfo;
    procedure SetBitState(AIndex: Integer; AValue: Boolean);
    procedure SetPosValue(AIndex, AValue: Integer);
    procedure SetHitPoint(const AValue: TPoint);
  protected
    Flags: Int64;
    property BitState[AIndex: Integer]: Boolean read GetBitState write SetBitState;
    property ResizeField: IcxPivotGridSizableObject read FResizeField;
    property ResizeFieldStartPos: Integer read FResizeFieldStartPos;
    property ViewInfo: TcxPivotGridViewInfo read GetViewInfo;
  public
    constructor Create(AOwner: TcxCustomPivotGrid); virtual;
    destructor Destroy; override;
    procedure Clear;
    procedure Recalculate;

    property Field: TPersistent read FField;
    property GroupItem: TcxPivotGridGroupItem read GetGroupItem;
    property HitAtButton: Boolean index htcButton read GetBitState;
    property HitAtDataCell: Boolean index htcDataCell read GetBitState;
    property HitAtDataField: Boolean index htcDataHeader read GetBitState;
    property HitAtField: Boolean index htcFieldHeader read GetBitState;
    property HitAtFilter: Boolean index htcFilter read GetBitState;
    property HitAtGroupHeader: Boolean index htcGroupHeader read GetBitState;
    property HitAtHeaderArea: Boolean index htcHeaderArea read GetBitState;
    property HitAtHorzSizingEdge: Boolean index htcHorzSizingEdge read GetBitState;
    property HitAtPrefilter: Boolean index htcPrefilter read GetBitState;
    property HitAtPrefilterCloseButton: Boolean index htcPrefilterCloseButton read GetBitState;
    property HitAtPrefilterActivateButton: Boolean index htcPrefilterActivateButton read GetBitState;
    property HitAtPrefilterCaption: Boolean index htcPrefilterCaption read GetBitState;
    property HitAtPrefilterCustomizationButton: Boolean index htcPrefilterCustomizationButton read GetBitState;
    property HitAtPrefilterDropDownButton: Boolean index htcPrefilterDropDownButton read GetBitState;
    property HitObject: TcxPivotGridCustomCellViewInfo read FHitObject;
    property HitPoint: TPoint read FHitPoint write SetHitPoint;
    property HitX: Integer index 0 read GetPosValue write SetPosValue;
    property HitY: Integer index 1 read GetPosValue write SetPosValue;
    property PivotGrid: TcxCustomPivotGrid read FOwner;
    property ShiftState: TShiftState read FShiftState write FShiftState;
  end;

  { TcxPivotGridHotTrackController }

  TcxPivotGridHotTrackController = class
  private
    FCell: TcxPivotGridCustomCellViewInfo;
    FOwner: TcxPivotGridController;
    function GetHitTest: TcxPivotGridHitTest;
    function GetPivotGrid: TcxCustomPivotGrid;
  protected
    procedure UpdateState(AObject: TcxPivotGridCustomCellViewInfo);
  public
    constructor Create(AOwner: TcxPivotGridController); virtual;
    procedure Clear; virtual;
    procedure Update(AObject: TcxPivotGridCustomCellViewInfo); virtual;

    property Cell: TcxPivotGridCustomCellViewInfo read FCell;
    property HitTest: TcxPivotGridHitTest read GetHitTest;
    property Owner: TcxPivotGridController read FOwner;
    property PivotGrid: TcxCustomPivotGrid read GetPivotGrid;
  end;

  { TcxPivotGridMRUPrefilterPopup }

  TcxPivotGridMRUPrefilterPopup = class(TcxCustomComboBox)
  private
    function GetPivotGrid: TcxCustomPivotGrid;
    function GetPrefilter: TcxPivotGridPrefilter;
    function SelectedMRUItem: TcxPivotGridFilterMRUItem;
  protected
    procedure BeforePopup;
    procedure DoCloseUp; override;
    procedure InitValues;
    procedure UpdateWindowRegion; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Popup;

    property PivotGrid: TcxCustomPivotGrid read GetPivotGrid;
    property Prefilter: TcxPivotGridPrefilter read GetPrefilter;
  end;

  { TcxPivotGridFilterPopup }

  TcxPivotGridFilterPopup = class(TcxPopupEdit)
  private
    FField: TcxPivotGridField;
    function GetPivotGrid: TcxCustomPivotGrid;
    function GetFilter: TcxPivotGridFieldFilter;
    procedure SetField(AField: TcxPivotGridField);
    procedure SetShowAllState(AValue: TcxCheckBoxState);
    function CreateButton(ATag: Integer): TcxButton;
    procedure UpdateButtonCaptions;
  protected
    FCancelButton: TcxButton;
    FFilterModified: Boolean;
    FLocked: Boolean;
    FPrevFilterState: TcxButtonState;
    FOkButton: TcxButton;
    FShowAllState: TcxCheckBoxState;
    FValues: TcxCheckListBox;
    function AddValue(const AValue: TcxPivotGridVariantValue): TcxCheckListBoxItem;
    procedure BeforePopup; virtual;
    procedure ButtonClickHandler(ASender: TObject); virtual;
    procedure CheckButtonsEnabled;
    procedure CreateControls; virtual;
    procedure DoCloseUp; override;
    function GetCheckedCount: Integer;
    function GetFieldValueByValueIndex(AIndex: Integer): Variant;
    function GetHeight(AItemCount: Integer): Integer;
    function GetStateByCount(ACount: Integer): TcxCheckBoxState;
    procedure InitValues; virtual;
    procedure SetPopupSize(const AWidth, AHeight: Integer);
    procedure SetupPopupWindow; override;
    procedure UpdateWindowRegion; override;
    procedure ValuesChanges(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    procedure Popup;
    procedure SaveChanges; virtual;
    // IdxLocalizerListener
    procedure TranslationChanged; override;

    property CancelButton: TcxButton read FCancelButton;
    property Field: TcxPivotGridField read FField write SetField;
    property Filter: TcxPivotGridFieldFilter read GetFilter;
    property FilterModified: Boolean read FFilterModified;
    property OkButton: TcxButton read FOkButton;
    property PivotGrid: TcxCustomPivotGrid read GetPivotGrid;
    property ShowAllState: TcxCheckBoxState read FShowAllState write SetShowAllState;
    property Values: TcxCheckListBox read FValues;
  end;

  { TcxPivotGridCustomDragDropObject }

  TcxPivotGridCustomDragDropObject = class(TcxDragAndDropObject)
  private
    function GetHitTest: TcxPivotGridHitTest;
    function GetOptionsView: TcxPivotGridOptionsView;
    function GetPainter: TcxCustomLookAndFeelPainterClass;
    function GetViewInfo: TcxPivotGridViewInfo;
  protected
    function GetPivotGrid: TcxCustomPivotGrid; virtual;
    //
  public
    property HitTest: TcxPivotGridHitTest read GetHitTest;
    property OptionsView: TcxPivotGridOptionsView read GetOptionsView;
    property Painter: TcxCustomLookAndFeelPainterClass read GetPainter;
    property PivotGrid: TcxCustomPivotGrid read GetPivotGrid;
    property ViewInfo: TcxPivotGridViewInfo read GetViewInfo;
  end;

  { TcxPivotGridResizingObject }

  TcxPivotGridResizingObject = class(TcxPivotGridCustomDragDropObject)
  private
    FSizeCursorPos: Integer;
    function GetSizeDelta: Integer;
    function GetSizeMarkBounds: TRect;
    procedure SetSizeCursorPos(AValue: Integer);
  protected
    StartPos, StartPosDelta: Integer;
    SizingBounds: TRect;
    SizableObject: IcxPivotGridSizableObject;
    procedure BeginDragAndDrop; override;
    procedure DirtyChanged; override;
    procedure DragAndDrop(const P: TPoint; var Accepted: Boolean); override;
    function GetDragAndDropCursor(Accepted: Boolean): TCursor; override;
    function GetImmediateStart: Boolean; override;
    procedure EndDragAndDrop(Accepted: Boolean); override;
    procedure SetSizeDelta(ADelta: Integer);
  public
    property SizeCursorPos: Integer read FSizeCursorPos write SetSizeCursorPos;
    property SizeDelta: Integer read GetSizeDelta;
    property SizeMarkBounds: TRect read GetSizeMarkBounds;
  end;

  { TcxPivotGridDragAndDropObject }

  TcxPivotGridDragDropAreaInfo = class
  public
    Area: TcxPivotGridFieldArea;
    AreaIndex: Integer;
    Bounds: TRect;
    DisplayBounds: TRect;
    Field: TPersistent;
  end;

  TcxPivotGridDragAndDropObject = class(TcxPivotGridCustomDragDropObject)
  private
    FDragField: IcxPivotGridField;
    function GetDragDropAreaCount: Integer;
    function GetDragDropArea(AIndex: Integer): TcxPivotGridDragDropAreaInfo;
    function GetDragDropArrowColor: TColor;
    function GetDragImageBounds: TRect;
    function GetFieldViewInfo: TcxPivotGridFieldHeaderCellViewInfo;
  protected
    AAccepted: Boolean;
    ArrowsLine: TRect;
    ArrowsSaveBitmap, DragImage, SaveImage, TempImage: TBitmap;
    DragDropInfo: TcxPivotGridDragDropAreaInfo;
    DragImageVisible: Boolean;
    ImageSize: TSize;
    ImageSizeCalculated: Boolean;
    TransparentMask: TList;
    HotSpot: TPoint;
    // drag drop main
    function AboveCustomization: Boolean;
    procedure BeginDragAndDrop; override;
    function CanRemove: Boolean; virtual;
    function CheckArea(const P: TPoint; var AInfo: TcxPivotGridDragDropAreaInfo): Boolean; virtual;
    function CreateDragImage: TBitmap; virtual;
    procedure DragAndDrop(const P: TPoint; var Accepted: Boolean); override;
    procedure DragDropField(AArea: TcxPivotGridFieldArea; AAreaIndex: Integer); virtual;
    procedure EndDragAndDrop(Accepted: Boolean); override;
    function GetDragAndDropCursor(Accepted: Boolean): TCursor; override;
    function GetDragImageSize: TSize; virtual;
    function IsSameDropPlace: Boolean; virtual;
    function IsPixelTransparent(ALine, APos: Integer): Boolean;
    procedure TransparentMixDragImage;
    // drag image helpers
    procedure ChangeArrowPos(AllowHide: Boolean);
    procedure CopyIntersectedImage(const ARect, AOldRect, ANewRect: TRect);
    procedure CopyImage(const AOldRect, ANewRect: TRect);
    function CreateBitmap(const ASize: TSize): TBitmap;
    function CreateScreenCanvas: TcxCanvas;
    procedure DrawArrows;
    procedure DrawImage(const APos: TPoint);
    procedure GetArrowRects(out R1, R2: TRect);
    function GetImageBounds(const APos: TPoint): TRect;
    procedure GetScreenImage(const APos: TPoint);
    procedure HideDragImage;
    procedure RestoreArrows;
    procedure RestoreScreen(const APos: TPoint);
    procedure ShowDragImage;
  public
    property DragField: IcxPivotGridField read FDragField;
    property DragDropAreaCount: Integer read GetDragDropAreaCount;
    property DragDropAreas[Index: Integer]: TcxPivotGridDragDropAreaInfo read GetDragDropArea;
    property DragDropArrowColor: TColor read GetDragDropArrowColor;
    property DragImageBounds: TRect read GetDragImageBounds;
    property DragImageSize: TSize read GetDragImageSize;
    property FieldViewInfo: TcxPivotGridFieldHeaderCellViewInfo read GetFieldViewInfo;
  end;

  { TcxPivotGridHintController }

  TcxPivotGridHintController = class(TcxIUnknownObject, IcxMouseTrackingCaller)
  private
    FHintAreaBounds: TRect;
    FHintCheckerTimer: TTimer;
    FHintObject: TObject;
    FHintText: string;
    FHintVisible: Boolean;
    FHintWindow: THintWindow;
    FOwner: TcxPivotGridController;
    function GetHitTest: TcxPivotGridHitTest;
    function GetPivotGrid: TcxCustomPivotGrid;
  protected
    function CanShowHint: Boolean;
    function GetHintInfo(var ABounds, AWindowBounds: TRect): Boolean; virtual;
    procedure HintCheckerTimerHandler(Sender: TObject);
    procedure HintWindowNeeded; virtual;
    function NeedShowHint: Boolean; virtual;
    procedure MouseLeave;
    procedure StartHintCheckerTimer;
    procedure StopHintCheckerTimer;

    property HintCheckerTimer: TTimer read FHintCheckerTimer write FHintCheckerTimer;
    property HintObject: TObject read FHintObject write FHintObject;
    property HintWindow: THintWindow read FHintWindow;
  public
    constructor Create(AOwner: TcxPivotGridController); virtual;
    destructor Destroy; override;
    procedure HideHint; virtual;
    procedure ShowHint; virtual;
    procedure Update;

    property HintAreaBounds: TRect read FHintAreaBounds write FHintAreaBounds;
    property HintText: string read FHintText write FHintText;
    property HintVisible: Boolean read FHintVisible;
    property HitTest: TcxPivotGridHitTest read GetHitTest;
    property Owner: TcxPivotGridController read FOwner;
    property PivotGrid: TcxCustomPivotGrid read GetPivotGrid;
  end;

  { TcxPivotGridController }

  TcxPivotGridController = class
  private
    FIgnoreSelection: Boolean;
    FFilterPopup: TcxPivotGridFilterPopup;
    FHintController: TcxPivotGridHintController;
    FHotTrackController: TcxPivotGridHotTrackController;
    FOwner: TcxCustomPivotGrid;
    FPrefilterPopup: TcxPivotGridMRUPrefilterPopup;
    FSelectionTimer: TTimer;
    procedure CalculateIgnoreSelection;
    function GetFocused: Boolean;
    function GetFocusedCell: TPoint;
    function GetHitTest: TcxPivotGridHitTest;
    function GetIsDesigning: Boolean;
    function GetOptionsCustomize: TcxPivotGridOptionsCustomize;
    function GetOptionsSelection: TcxPivotGridOptionsSelection;
    function GetOptionsView: TcxPivotGridOptionsView;
    function GetViewData: TcxPivotGridViewData;
    function GetViewInfo: TcxPivotGridViewInfo;
  protected
    DownField: IcxPivotGridField;
    FilterOpenedBeforeClick: Boolean;
    PrefilterOpenedBeforeClick: Boolean;
    SuspendSelectionTimer: Boolean;
    procedure CalculateAnchor(AShift: TShiftState);
    function CalculateFilterDropDownSize(AFilter: TcxPivotGridFieldFilter): TSize;
    procedure CheckSelectionTimer(const X, Y: Integer);
    function CreateFilterPopup: TcxPivotGridFilterPopup; virtual;
    function CreateHintController: TcxPivotGridHintController; virtual;
    function CreateHotTrackController: TcxPivotGridHotTrackController; virtual;
    procedure DoFieldHeaderClick(AField: TPersistent; AShift: TShiftState);
    function GetCursor(const X, Y: Integer): TCursor;
    function GetDragAndDropObjectClass: TcxDragAndDropObjectClass; virtual;
    function IsButtonDown: Boolean; virtual;
    function IsCellSelected(ACell: TcxPivotGridDataCellViewInfo): Boolean;
    procedure MakeSelected(AShift: TShiftState; AMouseMove: Boolean = False); virtual;
    function ProcessNavigationByStep(AGoBackward: Boolean; AShiftState: TShiftState): Boolean;
    procedure ProcessTabKeyDown(AGoBackward: Boolean);
    procedure SelectionTimerHandler(Sender: TObject);
    procedure SetSelection(ACol, ARow: Integer; AShift: TShiftState);
    procedure SetSelectionInc(const DX, DY: Integer; AShift: TShiftState; AByTimer: Boolean = False);
    function StartDragAndDrop(const P: TPoint): Boolean; virtual;
  public
    constructor Create(AOwner: TcxCustomPivotGrid); virtual;
    destructor Destroy; override;
    procedure Clear; virtual;
    procedure BeforeMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure DblClick; virtual;
    procedure KeyDown(var AKey: Word; AShift: TShiftState); virtual;
    procedure KeyPress(var AKey: Char); virtual;
    procedure MakeCellFocused(ACell: TcxPivotGridDataCellViewInfo; AShift: TShiftState);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure MouseLeave; virtual;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); virtual;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure StartSelectionTimer;
    procedure StopSelectionTimer;
    procedure Update; virtual;

    property FilterPopup: TcxPivotGridFilterPopup read FFilterPopup;
    property Focused: Boolean read GetFocused;
    property FocusedCell: TPoint read GetFocusedCell;
    property HitTest: TcxPivotGridHitTest read GetHitTest;
    property HintController: TcxPivotGridHintController read FHintController;
    property HotTrackController: TcxPivotGridHotTrackController read FHotTrackController;
    property IsDesigning: Boolean read GetIsDesigning;
    property OptionsCustomize: TcxPivotGridOptionsCustomize read GetOptionsCustomize;
    property OptionsSelection: TcxPivotGridOptionsSelection read GetOptionsSelection;
    property OptionsView: TcxPivotGridOptionsView read GetOptionsView;
    property PivotGrid: TcxCustomPivotGrid read FOwner;
    property PrefilterPopup: TcxPivotGridMRUPrefilterPopup read FPrefilterPopup;
    property SelectionTimer: TTimer read FSelectionTimer;
    property ViewData: TcxPivotGridViewData read GetViewData;
    property ViewInfo: TcxPivotGridViewInfo read GetViewInfo;
  end;

  { TcxPivotGridFilterValues }

  TcxPivotGridFilterType = (ftExcluded, ftIncluded);

  TcxPivotGridFieldFilter = class(TPersistent)
  private
    FField: TcxPivotGridField;
    FFilterType: TcxPivotGridFilterType;
    FLockCount: Integer;
    FModified: Boolean;
    FValues: TcxPivotGridVariantList;
    FWindowSize: TSize;
    FOnChange: TNotifyEvent;
    function GetHasFilter: Boolean;
    function GetPivotGrid: TcxCustomPivotGrid;
    procedure SetFilterType(AFilterType: TcxPivotGridFilterType);
  protected
    procedure Changed; virtual;
    function GetOwner: TPersistent; override;
    procedure ValuesChanged(ASender: TObject); virtual;

    procedure BeginUpdate;
    procedure EndUpdate(AForceUpdate: Boolean = True);

    procedure ReadData(AStream: TStream);
    procedure WriteData(AStream: TStream);

    property WindowSize: TSize read FWindowSize write FWindowSize;
  public
    constructor Create(AOwner: TcxPivotGridField); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear; virtual;
    function Contains(const AValue: Variant): Boolean;

    property Field: TcxPivotGridField read FField;
    property FilterType: TcxPivotGridFilterType read FFilterType write SetFilterType;
    property HasFilter: Boolean read GetHasFilter;
    property PivotGrid: TcxCustomPivotGrid read GetPivotGrid;
    property Values: TcxPivotGridVariantList read FValues;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  { TcxPivotGridFieldOptions }

  TcxPivotGridFieldOptions = class(TPersistent)
  private
    FField: TcxPivotGridField;
    FFiltering: Boolean;
    FMoving: Boolean;
    FSizing: Boolean;
    FSorting: Boolean;
    procedure SetFiltering(AValue: Boolean);
    procedure SetMoving(AValue: Boolean);
    procedure SetSizing(AValue: Boolean);
    procedure SetSorting(AValue: Boolean);
  protected
    function CanFiltering: Boolean;
    function CanSorting: Boolean;
    procedure Changed; virtual;
    function GetOwner: TPersistent; override;
    procedure SetOption(var AOption: Boolean; ANewValue: Boolean);
  public
    constructor Create(AOwner: TcxPivotGridField); virtual;
    procedure Assign(Source: TPersistent); override;

    property Field: TcxPivotGridField read FField;
  published
    property Filtering: Boolean read FFiltering write SetFiltering default True;
    property Moving: Boolean read FMoving write SetMoving default True;
    property Sizing: Boolean read FSizing write SetSizing default True;
    property Sorting: Boolean read FSorting write SetSorting default True;
  end;

  { TcxPivotGridCustomTotal }

  TcxPivotGridCustomTotal = class(TCollectionItem)
  private
    FDisplayFormat: string;
    FSummaryType: TcxPivotGridSummaryType;
    function GetField: TcxPivotGridField;
    function GetPivotGrid: TcxCustomPivotGrid;
    procedure SetDisplayFormat(const AValue: string);
    procedure SetSummaryType(AValue: TcxPivotGridSummaryType);
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;

    property Field: TcxPivotGridField read GetField;
    property PivotGrid: TcxCustomPivotGrid read GetPivotGrid;
  published
    property SummaryType: TcxPivotGridSummaryType read FSummaryType write SetSummaryType default stSum;
    property DisplayFormat: string read FDisplayFormat write SetDisplayFormat;
  end;

  { TcxPivotGridCustomTotalCollection }

  TcxPivotGridCustomTotalCollection = class(TCollection)
  private
    FOwner: TcxPivotGridField;
    function GetItem(AIndex: Integer): TcxPivotGridCustomTotal;
    function GetPivotGrid: TcxCustomPivotGrid;
    procedure SetItem(AIndex: Integer; AValue: TcxPivotGridCustomTotal);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AOwner: TcxPivotGridField); overload; virtual;
    function Add(ASummaryType: TcxPivotGridSummaryType): TcxPivotGridCustomTotal;

    property Field: TcxPivotGridField read FOwner;
    property PivotGrid: TcxCustomPivotGrid read GetPivotGrid;
    property Items[Index: Integer]: TcxPivotGridCustomTotal read GetItem write SetItem; default;
  end;

  { TcxPivotGridSortBySummaryInfo }

  TcxPivotGridSortBySummaryInfo = class(TPersistent)
  private
    FField: TcxPivotGridField;
    FOwner: TcxPivotGridField;
    FSummaryType: TcxPivotGridSummaryType;
    function GetPivotGrid: TcxCustomPivotGrid;
    procedure SetField(AValue: TcxPivotGridField);
    procedure SetSummaryType(AValue: TcxPivotGridSummaryType);
  protected
    procedure Changed; virtual;
    function GetOwner: TPersistent; override;
    function ValidateProperties: Boolean; virtual;
  public
    constructor Create(AOwner: TcxPivotGridField); virtual;
    procedure Assign(Source: TPersistent); override;

    property Owner: TcxPivotGridField read FOwner;
    property PivotGrid: TcxCustomPivotGrid read GetPivotGrid;
  published
    property Field: TcxPivotGridField read FField write SetField;
    property SummaryType: TcxPivotGridSummaryType read FSummaryType write SetSummaryType default stSum;
  end;

  { TcxPivotGridDefaultValuesProvider }

  TcxPivotGridDefaultValuesProvider = class(TcxCustomEditDefaultValuesProvider)
  public
    function IsDisplayFormatDefined(AIsCurrencyValueAccepted: Boolean): Boolean; override;
  end;


  { TcxPivotGridFieldDataBinding }

  TcxPivotGridFieldDataBinding = class(TPersistent)
  private
    FField: TcxPivotGridField;
    FValueTypeAssigned: Boolean;
    function GetPivotGrid: TcxCustomPivotGrid;
    function GetValueType: string;
    function GetValueTypeClass: TcxValueTypeClass;
    procedure SetValueType(AValue: string);
    procedure SetValueTypeClass(AValue: TcxValueTypeClass);
    function IsValueTypeStored: Boolean;
  protected
    FDefaultValuesProvider: TcxCustomEditDefaultValuesProvider;
    function GetDefaultValuesProvider: IcxEditDefaultValuesProvider; virtual;
    function GetDefaultValuesProviderClass: TcxCustomEditDefaultValuesProviderClass; virtual;
    function GetFilterFieldName: string; virtual;
    function GetOwner: TPersistent; override;
    procedure Init; virtual;
  public
    constructor Create(AOwner: TcxPivotGridField); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    property Field: TcxPivotGridField read FField;
    property PivotGrid: TcxCustomPivotGrid read GetPivotGrid;
    property ValueTypeAssigned: Boolean read FValueTypeAssigned write FValueTypeAssigned;
    property ValueTypeClass: TcxValueTypeClass read GetValueTypeClass write SetValueTypeClass;
  published
    property ValueType: string read GetValueType write SetValueType stored IsValueTypeStored;
  end;

  { TcxPivotGridField }

  TcxPivotGridSummaryVariation = (svNone, svAbsolute, svPercent, svPercentOfColumn, svPercentOfRow);
  TcxPivotGridFieldDataVisibility = (dvAllCells, dvCrossAndTotalCells, dvGrandTotalCells);

  TcxPivotGridCalculateCustomSummaryEvent = procedure(Sender: TcxPivotGridField;
    ASummary: TcxPivotGridCrossCellSummary) of object;

  TcxPivotGridGetDisplayTextEvent = procedure(Sender: TcxPivotGridField;
    ACell: TcxPivotGridDataCellViewInfo; var AText: string) of object;

  TcxPivotGridGetGroupValueDisplayTextEvent = procedure(Sender: TcxPivotGridField;
    const AGroupValue: Variant; var AText: string) of object;

  TcxPivotGridGetGroupValueEvent = procedure(Sender: TcxPivotGridField;
    ARecordIndex: Integer; var AValue: Variant) of object;

  TcxPivotGridGetTotalDisplayTextEvent = procedure(Sender: TcxPivotGridField;
    AGroupItem: TcxPivotGridGroupItem; var AText: string) of object;

  TcxPivotGridGetPropertiesEvent = procedure(Sender: TcxPivotGridField;
    ACell: TcxPivotGridCustomCellViewInfo; var AProperties: TcxCustomEditProperties) of object;

  TcxPivotGridFieldGetGroupImageIndex = procedure(Sender: TcxPivotGridField;
    const AItem: TcxPivotGridViewDataItem; var AImageIndex: Integer;
    var AImageAlignHorz: TAlignment; var AImageAlignVert: TcxAlignmentVert) of object;

  TcxPivotGridField = class(TComponent, IUnknown, IcxPivotGridSizableObject, IcxPivotGridField,
    IcxStoredObject, IcxEditRepositoryItemListener)
  private
    FAllowedAreas: TcxPivotGridFieldAreas;
    FArea: TcxPivotGridFieldArea;
    FAreaIndex: Integer;
    FCaption: string;
    FCustomTotals: TcxPivotGridCustomTotalCollection;
    FCurrency: Boolean;
    FDataBinding: TcxPivotGridFieldDataBinding;
    FDataVisibility: TcxPivotGridFieldDataVisibility;
    FDisplayFormat: string;
    FEditStyle: TcxEditStyle;
    FEditViewData: TcxCustomEditViewData;
    FExpandingInfo: TcxPivotGridVariantList;
    FFilter: TcxPivotGridFieldFilter;
    FFloat: Boolean;
    FGroup: TcxPivotGridFieldGroup;
    FGroupExpanded: Boolean;
    FGroupValueList: TcxPivotGridVariantList;
    FGroupValuesValid: Boolean;
    FGroupInterval: TcxPivotGridGroupInterval;
    FGroupIntervalRange: Integer;
    FHidden: Boolean;
    FImageAlign: TAlignment;
    FImageIndex: TImageIndex;
    FIsCaptionAssigned: Boolean;
    FLastUsedDefaultRepositoryItem: TcxEditRepositoryItem;
    FLink: TcxPivotGridOLAPField;
    FMinWidth: Integer;
    FOptions: TcxPivotGridFieldOptions;
    FPivotGrid: TcxCustomPivotGrid;
    FProperties: TcxCustomEditProperties;
    FPropertiesClass: TcxCustomEditPropertiesClass;
    FPropertiesValue: TcxCustomEditProperties;
    FRepositoryItem: TcxEditRepositoryItem;
    FSortOrder: TcxDataSortOrder;
    FSortBySummaryInfo: TcxPivotGridSortBySummaryInfo;
    FStyles: TcxPivotGridFieldStyles;
    FSubClassEvents: TNotifyEvent;
    FSummaryIndex: Integer;
    FSummaryType: TcxPivotGridSummaryType;
    FSummaryVariation: TcxPivotGridSummaryVariation;
    FTotalsVisibility: TcxPivotGridTotalsVisibility;
    FTopValueCount: Integer;
    FTopValueShowOthers: Boolean;
    FUniqueName: string;
    FVisible: Boolean;
    FVisibleIndex: Integer;
    FViewInfo: TcxPivotGridFieldHeaderCellViewInfo;
    FWidth: Integer;
    FOnCalculateCustomSummary: TcxPivotGridCalculateCustomSummaryEvent;
    FOnGetDisplayText: TcxPivotGridGetDisplayTextEvent;
    FOnGetGroupImageIndex: TcxPivotGridFieldGetGroupImageIndex;
    FOnGetGroupValue: TcxPivotGridGetGroupValueEvent;
    FOnGetGroupValueDisplayText: TcxPivotGridGetGroupValueDisplayTextEvent;
    FOnGetProperties: TcxPivotGridGetPropertiesEvent;
    FOnGetTotalDisplayText: TcxPivotGridGetTotalDisplayTextEvent;
    // IcxStoredObject events
    FOnGetStoredProperties: TcxGetStoredPropertiesEvent;
    FOnGetStoredPropertyValue: TcxGetStoredPropertyValueEvent;
    FOnSetStoredPropertyValue: TcxSetStoredPropertyValueEvent;
    function GetAllowedAreas: TcxPivotGridFieldAreas;
    function GetActualWidth: Integer;
    function GetController: TcxPivotGridController;
    function GetDataBuilder: TcxPivotGridDataBuilder;
    function GetGroupExpanded: Boolean;
    function GetGroupIndex: Integer;
    function GetGroupValueList: TcxPivotGridVariantList;
    function GetHeaderWidth: Integer;
    function GetHidden: Boolean;
    function GetIndex: Integer;
    function GetIsDestroying: Boolean;
    function GetIsHierarchy: Boolean;
    function GetMinWidth: Integer;
    function GetPropertiesClassName: string;
    function GetRecordCount: Integer;
    function GetSortedBySummary: Boolean;
    function GetUniqueName: WideString;
    function GetValueByRecordIndex(ARecordIndex: Integer): Variant;
    function GetVisible: Boolean;
    function GetVisibleInGroup: Boolean;
    function IsFirstFieldInGroup: Boolean;
    procedure SetArea(AValue: TcxPivotGridFieldArea);
    procedure SetAreaIndex(AValue: Integer);
    procedure SetCaption(const AValue: string);
    procedure SetCustomTotals(AValue: TcxPivotGridCustomTotalCollection);
    procedure SetDataBinding(AValue: TcxPivotGridFieldDataBinding);
    procedure SetDataVisibility(AValue: TcxPivotGridFieldDataVisibility);
    procedure SetDisplayFormat(const AValue: string);
    procedure SetGroup(AValue: TcxPivotGridFieldGroup);
    procedure SetGroupExpanded(AValue: Boolean);
    procedure SetGroupIndex(AValue: Integer);
    procedure SetGroupInterval(AValue: TcxPivotGridGroupInterval);
    procedure SetGroupIntervalRange(AValue: Integer);
    procedure SetHidden(AValue: Boolean);
    procedure SetImageAlign(AValue: TAlignment);
    procedure SetImageIndex(AValue: TImageIndex);
    procedure SetIndex(AValue: Integer);
    procedure SetMinWidth(Avalue: Integer);
    procedure SetOnGetProperties(AValue: TcxPivotGridGetPropertiesEvent);
    procedure SetOptions(AValue: TcxPivotGridFieldOptions);
    procedure SetProperties(Value: TcxCustomEditProperties);
    procedure SetPropertiesClass(Value: TcxCustomEditPropertiesClass);
    procedure SetPropertiesClassName(const Value: string);
    procedure SetRepositoryItem(Value: TcxEditRepositoryItem);
    procedure SetSortOrder(AValue: TcxDataSortOrder);
    procedure SetSortBySummaryInfo(AValue: TcxPivotGridSortBySummaryInfo);
    procedure SetStyles(AValue: TcxPivotGridFieldStyles);
    procedure SetSummaryType(AValue: TcxPivotGridSummaryType);
    procedure SetSummaryVariation(AValue: TcxPivotGridSummaryVariation);
    procedure SetTotalsVisibility(AValue: TcxPivotGridTotalsVisibility);
    procedure SetTopValueCount(AValue: Integer);
    procedure SetTopValueShowOthers(AValue: Boolean);
    procedure SetUniqueName(const AValue: WideString);
    procedure SetValueByRecordIndex(ARecordIndex: Integer; const AValue: Variant);
    procedure SetVisible(AValue: Boolean);
    procedure SetWidth(AValue: Integer);

    // Event Handlers
    procedure FilterChanged(Sender: TObject);
    procedure InternalDoGetDisplayText(ACell: TcxPivotGridDataCellViewInfo; var AText: string);
    //
    function IsAllowedAreasStored: Boolean;
    function IsCustomTotalStored: Boolean;
    // IcxPivotGridField
    procedure ChangeExpanding;
    procedure ChangeSorting;
    function GetViewInfo: TcxPivotGridFieldHeaderCellViewInfo;
    procedure SetState(AState: TcxButtonState);

    procedure CreateProperties;
    procedure DestroyProperties;
    procedure RecreateProperties;
  protected
    function CanDrag: Boolean; virtual;
    function CanDrop(AArea: TcxPivotGridFieldArea): Boolean; virtual;
    function CanModifyArea: Boolean;
    function CanRemove: Boolean; virtual;
    function CanResize: Boolean;
    procedure Changed(AIsViewChanged: Boolean = False); virtual;
    function CreateEditStyle(AProperties: TcxCustomEditProperties): TcxEditStyle;
    procedure CreateEditViewData;
    procedure DataChanged; virtual;
    function DefaultRepositoryItem: TcxEditRepositoryItem; virtual;
    procedure DestroyEditViewData;
    procedure DragDrop(AArea: TcxPivotGridFieldArea; AAreaIndex: Integer); virtual;
    function GetEditViewData: TcxCustomEditViewData;
    procedure InitGroupValues;
    procedure InitProperties(AProperties: TcxCustomEditProperties);

    //Embedded virtual methods
    procedure DoCalculateCustomSummary(ACell: TcxPivotGridCrossCellSummary); virtual;
    procedure DoGetDisplayText(ACell: TcxPivotGridDataCellViewInfo); virtual;
    function DoGetGroupImageIndex(AItem: TcxPivotGridViewDataItem;
      var AAlignHorz: TAlignment; var AAlignVert: TcxAlignmentVert): Integer; virtual;
    function DoGetGroupValue(const AValue: Variant; ARecordIndex: Integer): Variant; virtual;
    function DoGetGroupValueDisplayText(const AValue: Variant): string; virtual;
    procedure DoFilterChanged; virtual;
    function DoGetProperties(ACell: TcxPivotGridCustomCellViewInfo): TcxCustomEditProperties;
    procedure DoGetTotalDisplayText(AGroupItem: TcxPivotGridGroupItem; var AText: string); virtual;

    //Conditions
    function IsCurrency(AType: TcxValueTypeClass): Boolean; virtual;
    function IsItemExpanded(AGroup: TcxPivotGridGroupItem): Boolean;
    function HasSummaryVariation: Boolean;

    //Getters
    function GetActualDisplayFormat: string; virtual;
    function GetEditProperties: TcxCustomEditProperties;
    function GetEditStyle(AProperties: TcxCustomEditProperties; ALocal: Boolean): TcxEditStyle;
    function GetUserEditProperties: TcxCustomEditProperties;
    function GetPropertiesValue: TcxCustomEditProperties;
    function GetRepositoryItem: TcxEditRepositoryItem;

    //EditProperties
    procedure EditViewDataGetDisplayTextHandler(Sender: TcxCustomEditViewData; var AText: string);
    procedure PropertiesChanged;
    procedure PropertiesChangedHandler(Sender: TObject);
    procedure PropertiesValueChanged;
    function UseEditProperties: Boolean;
    // grouping
    function CreateCustomTotals: TcxPivotGridCustomTotalCollection; virtual;
    function CreateDataBinding: TcxPivotGridFieldDataBinding; virtual;
    function CreateFilter: TcxPivotGridFieldFilter; virtual;
    function CreateOptions: TcxPivotGridFieldOptions; virtual;
    function CreateSortBySummaryInfo: TcxPivotGridSortBySummaryInfo; virtual;
    function CreateStyles: TcxPivotGridFieldStyles; virtual;
    procedure CreateSubClasses; virtual;
    procedure DestroySubClasses; virtual;
    procedure GroupCheckExpanding(AGroup: TcxPivotGridGroupItem);
    procedure GroupExpandingChanged(ASender: TcxPivotGridGroupItem); virtual;
    //
    function GetCaption: string; virtual;
    function GetDataType: TVarType;
    function GetDisplayTextAssigned: Boolean;
    function IsRecordVisible(ARecordIndex: Integer): Boolean;
    procedure SetAreaIndexInternal(AArea: TcxPivotGridFieldArea; AAreaIndex: Integer);
    procedure SetExpanding(AValue: Boolean);
    procedure SetParentComponent(Value: TComponent); override;
    procedure SetPivotGrid(AValue: TcxCustomPivotGrid);
    procedure SynchronizeUniqueName;
    // IcxEditRepositoryItemListener
    procedure ItemRemoved(Sender: TcxEditRepositoryItem);
    procedure IcxEditRepositoryItemListener.PropertiesChanged = RepositoryItemPropertiesChanged;
    procedure RepositoryItemPropertiesChanged(Sender: TcxEditRepositoryItem);
    // IcxStoredObject
    function GetObjectName: string;
    function GetProperties(AProperties: TStrings): Boolean; overload; virtual;
    procedure GetPropertyValue(const AName: string; var AValue: Variant); virtual;
    procedure SetPropertyValue(const AName: string; const AValue: Variant); virtual;

    property Controller: TcxPivotGridController read GetController;
    property Currency: Boolean read FCurrency write FCurrency;
    property DataBuilder: TcxPivotGridDataBuilder read GetDataBuilder;
    property ExpandingInfo: TcxPivotGridVariantList read FExpandingInfo;
    property Float: Boolean read FFloat write FFloat;
    property GroupValuesValid: Boolean read FGroupValuesValid write FGroupValuesValid;
    property HeaderWidth: Integer read GetHeaderWidth;
    property ViewInfo: TcxPivotGridFieldHeaderCellViewInfo read FViewInfo;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure ApplyBestFit;
    procedure CollapseAll;
    procedure ExpandAll;
    function GetGroupValue(ARecordIndex: Integer): Variant;
    function GetGroupValueDisplayText(const AGroupValue: Variant): string;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
    procedure SetAreaPosition(AArea: TcxPivotGridFieldArea; AAreaIndex:  Integer);

    property ActualWidth: Integer read GetActualWidth;
    property Filter: TcxPivotGridFieldFilter read FFilter;
    property Group: TcxPivotGridFieldGroup read FGroup write SetGroup;
    property GroupValueList: TcxPivotGridVariantList read GetGroupValueList;
    property Index: Integer read GetIndex write SetIndex;
    property Link: TcxPivotGridOLAPField read FLink;
    property IsHierarchy: Boolean read GetIsHierarchy;
    property PivotGrid: TcxCustomPivotGrid read FPivotGrid write SetPivotGrid;
    property PropertiesClass: TcxCustomEditPropertiesClass read FPropertiesClass write SetPropertiesClass;
    property RecordCount: Integer read GetRecordCount;
    property SortedBySummary: Boolean read GetSortedBySummary;
    property SummaryIndex: Integer read FSummaryIndex;
    property Values[ARecordIndex: Integer]: Variant read GetValueByRecordIndex write SetValueByRecordIndex;
    property VisibleInGroup: Boolean read GetVisibleInGroup;
    property VisibleIndex: Integer read FVisibleIndex;
  published
    property Area: TcxPivotGridFieldArea read FArea write SetArea default faFilter;
    property AreaIndex: Integer read FAreaIndex write SetAreaIndex default cxPivotGridInvalidIndex;
    property AllowedAreas: TcxPivotGridFieldAreas read GetAllowedAreas write FAllowedAreas stored IsAllowedAreasStored;
    property IsCaptionAssigned: Boolean read FIsCaptionAssigned write FIsCaptionAssigned default False;
    property Caption: string read GetCaption write SetCaption stored FIsCaptionAssigned;
    property CustomTotals: TcxPivotGridCustomTotalCollection read FCustomTotals write SetCustomTotals stored IsCustomTotalStored;
    property DataBinding: TcxPivotGridFieldDataBinding read FDataBinding write SetDataBinding;
    property DataVisibility: TcxPivotGridFieldDataVisibility read FDataVisibility write SetDataVisibility default dvAllCells;
    property DisplayFormat: string read FDisplayFormat write SetDisplayFormat;
    property Options: TcxPivotGridFieldOptions read FOptions write SetOptions;
    property PropertiesClassName: string read GetPropertiesClassName write SetPropertiesClassName;
    property Properties: TcxCustomEditProperties read FProperties write SetProperties;
    property RepositoryItem: TcxEditRepositoryItem read FRepositoryItem write SetRepositoryItem;
    property ImageAlign: TAlignment read FImageAlign write SetImageAlign default taLeftJustify;
    property ImageIndex: TImageIndex read FImageIndex write SetImageIndex default -1;
    property GroupIndex: Integer read GetGroupIndex write SetGroupIndex default -1;
    property GroupExpanded: Boolean read GetGroupExpanded write SetGroupExpanded default True;
    property GroupInterval: TcxPivotGridGroupInterval read FGroupInterval write SetGroupInterval default giDefault;
    property GroupIntervalRange: Integer read FGroupIntervalRange write SetGroupIntervalRange default cxPivotGridDefaultGroupIntervalRange;
    property Hidden: Boolean read GetHidden write SetHidden default False;
    property MinWidth: Integer read GetMinWidth write SetMinWidth default cxPivotGridDefaultFieldMinWidth;
    property SummaryType: TcxPivotGridSummaryType read FSummaryType write SetSummaryType default stSum;
    property SortBySummaryInfo: TcxPivotGridSortBySummaryInfo read FSortBySummaryInfo write SetSortBySummaryInfo;
    property SortOrder: TcxDataSortOrder read FSortOrder write SetSortOrder default soNone;
    property Styles: TcxPivotGridFieldStyles read FStyles write SetStyles;
    property SummaryVariation: TcxPivotGridSummaryVariation read FSummaryVariation write SetSummaryVariation default svNone;
    property TotalsVisibility: TcxPivotGridTotalsVisibility read FTotalsVisibility write SetTotalsVisibility default tvAutomatic;
    property TopValueCount: Integer read FTopValueCount write SetTopValueCount default 0;
    property TopValueShowOthers: Boolean read FTopValueShowOthers write SetTopValueShowOthers default False;
    property UniqueName: WideString read GetUniqueName write SetUniqueName;
    property Visible: Boolean read GetVisible write SetVisible default False;
    property Width: Integer read FWidth write SetWidth default 0;
    //
    property PropertiesEvents: TNotifyEvent read FSubClassEvents write FSubClassEvents;
    property OnCalculateCustomSummary: TcxPivotGridCalculateCustomSummaryEvent read FOnCalculateCustomSummary write FOnCalculateCustomSummary;
    property OnGetDisplayText: TcxPivotGridGetDisplayTextEvent read FOnGetDisplayText write FOnGetDisplayText;
    property OnGetGroupImageIndex: TcxPivotGridFieldGetGroupImageIndex read FOnGetGroupImageIndex write FOnGetGroupImageIndex;
    property OnGetGroupValue: TcxPivotGridGetGroupValueEvent read FOnGetGroupValue write FOnGetGroupValue;
    property OnGetGroupValueDisplayText: TcxPivotGridGetGroupValueDisplayTextEvent read FOnGetGroupValueDisplayText write FOnGetGroupValueDisplayText;
    property OnGetProperties: TcxPivotGridGetPropertiesEvent read FOnGetProperties write SetOnGetProperties;
    property OnGetTotalDisplayText: TcxPivotGridGetTotalDisplayTextEvent read FOnGetTotalDisplayText write FOnGetTotalDisplayText;
    // IcxStoredObject events
    property OnGetStoredProperties: TcxGetStoredPropertiesEvent read FOnGetStoredProperties write FOnGetStoredProperties;
    property OnGetStoredPropertyValue: TcxGetStoredPropertyValueEvent read FOnGetStoredPropertyValue write FOnGetStoredPropertyValue;
    property OnSetStoredPropertyValue: TcxSetStoredPropertyValueEvent read FOnSetStoredPropertyValue write FOnSetStoredPropertyValue;
  end;

  { TcxPivotGridFieldGroup }

  TcxPivotGridFieldGroup = class(TCollectionItem)
  private
    FCaption: string;
    FIsCaptionAssigned: Boolean;
    function GetArea: TcxPivotGridFieldArea;
    function GetAreaIndex: Integer;
    function GetCaption: string;
    function GetField(AIndex: Integer): TcxPivotGridField;
    function GetFieldCount: Integer;
    function GetGroups: TcxPivotGridFieldGroupCollection;
    function GetIsDestroying: Boolean;
    function GetPivotGrid: TcxCustomPivotGrid;
    function GetVisible: Boolean;
    function GetVisibleCount: Integer;
    procedure SetArea(AValue: TcxPivotGridFieldArea);
    procedure SetAreaIndex(AValue: Integer);
    procedure SetCaption(const AValue: string);
    procedure SetVisible(AValue: Boolean);
  protected
    FieldList: TList;
    function CanDropTo(AArea: TcxPivotGridFieldArea; AIndex: Integer): Boolean; virtual;
    function GetLatestIndex: Integer;
    function GetNextField(AField: TcxPivotGridField): TcxPivotGridField;
    procedure GroupChanged; virtual;
    procedure InternalSetArea(AArea: TcxPivotGridFieldArea);
    function IsSameDropPlace(AIndex: Integer): Boolean;
    procedure ResetIndexes(var ANewIndex: Integer);
    procedure SetExpanded(AExpanded: Boolean);

    property IsDestroying: boolean read GetIsDestroying;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    procedure Add(AField: TcxPivotGridField);
    procedure AddFields(AFields: array of TcxPivotGridField);
    procedure Clear;
    procedure FullCollapse;
    procedure FullExpand;
    function IndexOf(AField: TcxPivotGridField): Integer;
    procedure Insert(AIndex: Integer; AField: TcxPivotGridField);
    function IsFieldVisible(AField: TcxPivotGridField): Boolean;
    function IsLastVisibleField(AField: TcxPivotGridField): Boolean;
    procedure Remove(AField: TcxPivotGridField);

    property FieldCount: Integer read GetFieldCount;
    property Fields[AIndex: Integer]: TcxPivotGridField read GetField; default;
    property Groups: TcxPivotGridFieldGroupCollection read GetGroups;
    property PivotGrid: TcxCustomPivotGrid read GetPivotGrid;
    property VisibleCount: Integer read GetVisibleCount;
  published
    property Area: TcxPivotGridFieldArea read GetArea write SetArea stored False;
    property AreaIndex: Integer read GetAreaIndex write SetAreaIndex stored False;
    property IsCaptionAssigned: Boolean read FIsCaptionAssigned write FIsCaptionAssigned;
    property Caption: string read GetCaption write SetCaption stored FIsCaptionAssigned;
    property Visible: Boolean read GetVisible write SetVisible stored False;
  end;

  { TcxPivotGridFieldGroupCollection }

  TcxPivotGridFieldGroupCollection = class(TCollection)
  private
    FOwner: TcxCustomPivotGrid;
    function GetItem(AIndex: Integer): TcxPivotGridFieldGroup;
    procedure SetItem(AIndex: Integer; AValue: TcxPivotGridFieldGroup);
  protected
    function CanDropTo(AArea: TcxPivotGridFieldArea; AIndex: Integer): Boolean; virtual;
    function GetOwner: TPersistent; override;
    procedure Loaded; virtual;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AOwner: TcxCustomPivotGrid); overload; virtual;
    function Add: TcxPivotGridFieldGroup;

    property PivotGrid: TcxCustomPivotGrid read FOwner;
    property Items[Index: Integer]: TcxPivotGridFieldGroup read GetItem write SetItem; default;
  end;

  { TcxPivotGridPopupMenus }

  TcxPivotGridCustomPopupMenu = class(TPersistent)
  private
    FBuiltInMenu: TPopupMenu;
    FOwner: TcxPivotGridPopupMenus;
    FPopupMenu: TComponent;
    FUseBuiltInMenu: Boolean;
    function GetPivotGrid: TcxCustomPivotGrid;
    function GetRoot: TMenuItem;
    procedure SetPopupMenu(AValue: TComponent);
  protected
    procedure AssignValues(ASource: TcxPivotGridCustomPopupMenu); virtual;
    procedure CreateInternalMenu;
    procedure CreateItems; virtual;
    function CreateSeparator(AOwner: TMenuItem): TMenuItem;
    function CreateSubItem(AOwner: TMenuItem; const ACaption: string;
      ACommand: Integer; AEnabled: Boolean = True): TMenuItem;
    procedure DoExecute(ACommand: Integer); virtual;
    procedure ExecuteItem(AItem: TMenuItem);
    function GetItemByCommand(ACommand: Integer): TMenuItem;
    function GetOwner: TPersistent; override;
    procedure MenuItemClickHandler(Sender: TObject); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); virtual;

    property Root: TMenuItem read GetRoot;
  public
    constructor Create(AOwner: TcxPivotGridPopupMenus); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure ExecuteCommand(ACommand: Integer);
    function Popup(X, Y: Integer): Boolean; virtual;

    property BuiltInMenu: TPopupMenu read FBuiltInMenu;
    property Owner: TcxPivotGridPopupMenus read FOwner;
    property PivotGrid: TcxCustomPivotGrid read GetPivotGrid;
  published
    property PopupMenu: TComponent read FPopupMenu write SetPopupMenu;
    property UseBuiltInMenu: Boolean read FUseBuiltInMenu write FUseBuiltInMenu default True;
  end;

  { TcxPivotGridFieldHeaderMenu }

  TcxPivotGridFieldHeaderPopupMenuItem = (fpmiHide, fpmiOrder, fpmiFieldList);
  TcxPivotGridFieldHeaderPopupMenuItems = set of TcxPivotGridFieldHeaderPopupMenuItem;

  TcxPivotGridFieldHeaderMenu = class(TcxPivotGridCustomPopupMenu)
  private
    FField: TcxPivotGridField;
    FItems: TcxPivotGridFieldHeaderPopupMenuItems;
    function GetFieldHeaders: TcxPivotGridCells;
    function GetFieldViewInfo: TcxPivotGridFieldHeaderCellViewInfo;
    function GetOptionsDataField: TcxPivotGridOptionsDataField;
    function IsItemsStored: Boolean;
  protected
    procedure AssignValues(ASource: TcxPivotGridCustomPopupMenu); override;
    procedure CreateItems; override;
    procedure DoExecute(ACommand: Integer); override;
    procedure GetIndexes(var AStart, APrev, ANext, AFinish: Integer);
    property FieldHeaders: TcxPivotGridCells read GetFieldHeaders;
    property FieldViewInfo: TcxPivotGridFieldHeaderCellViewInfo read GetFieldViewInfo;
  public
    constructor Create(AOwner: TcxPivotGridPopupMenus); override;
    property Field: TcxPivotGridField read FField;
    property OptionsDataField: TcxPivotGridOptionsDataField read GetOptionsDataField;
  published
    property Items: TcxPivotGridFieldHeaderPopupMenuItems read FItems write FItems stored IsItemsStored;
  end;

  { TcxPivotGridGroupValueMenu }

  TcxPivotGridGroupValuePopupMenuItem = (vpmiExpandCollapse, vpmiExpandAll, vpmiCollapseAll);
  TcxPivotGridGroupValuePopupMenuItems = set of TcxPivotGridGroupValuePopupMenuItem;

  TcxPivotGridGroupValueMenu = class(TcxPivotGridCustomPopupMenu)
  private
    FGroupItem: TcxPivotGridGroupItem;
    FItems: TcxPivotGridGroupValuePopupMenuItems;
    function IsItemsStored: Boolean;
  protected
    procedure AssignValues(ASource: TcxPivotGridCustomPopupMenu); override;
    procedure CreateItems; override;
    procedure DoExecute(ACommand: Integer); override;
  public
    constructor Create(AOwner: TcxPivotGridPopupMenus); override;

    property GroupItem: TcxPivotGridGroupItem read FGroupItem;
  published
    property Items: TcxPivotGridGroupValuePopupMenuItems read FItems write FItems stored IsItemsStored;
  end;

  { TcxPivotGridHeaderAreaMenu }

  TcxPivotGridHeaderAreaMenu = class(TcxPivotGridCustomPopupMenu)
  protected
    procedure CreateItems; override;
    procedure DoExecute(ACommand: Integer); override;
  end;

  TcxPivotGridPopupMenuClickEvent = procedure(Sender: TcxCustomPivotGrid;
    AItem: TMenuItem; var AHandled: Boolean) of object;

  TcxPivotGridPopupMenuPopupEvent = procedure(Sender: TcxCustomPivotGrid;
    ABuiltInMenu: TcxPivotGridCustomPopupMenu; var AHandled: Boolean) of object;

  TcxPivotGridPopupMenus = class(TcxPivotGridCustomOptions)
  private
    FFieldHeaderMenu: TcxPivotGridFieldHeaderMenu;
    FGroupValueMenu: TcxPivotGridGroupValueMenu;
    FHeaderAreaMenu: TcxPivotGridHeaderAreaMenu;
    FOnClick: TcxPivotGridPopupMenuClickEvent;
    FOnPopup: TcxPivotGridPopupMenuPopupEvent;
    function GetHitTest: TcxPivotGridHitTest;
    procedure SetFieldHeaderMenu(AValue: TcxPivotGridFieldHeaderMenu);
    procedure SetGroupValueMenu(AValue: TcxPivotGridGroupValueMenu);
    procedure SetHeaderAreaMenu(AValue: TcxPivotGridHeaderAreaMenu);
  protected
    function CreateFieldHeaderMenu: TcxPivotGridFieldHeaderMenu; virtual;
    function CreateGroupValueMenu: TcxPivotGridGroupValueMenu; virtual;
    function CreateHeaderAreaMenu: TcxPivotGridHeaderAreaMenu; virtual;
    procedure CreateMenus; virtual;
    procedure DestroyMenus; virtual;
    procedure DoOnClick(AItem: TMenuItem; var AHandled: Boolean); virtual;
    procedure DoOnPopup(ASender: TcxPivotGridCustomPopupMenu; var AHandled: Boolean); virtual;
    function DoShowPopupMenu(const P: TPoint): Boolean; virtual;
    procedure MenuItemClickHandler(Sender: TObject); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); virtual;

    property HitTest: TcxPivotGridHitTest read GetHitTest;
  public
    constructor Create(AOwner: TcxCustomPivotGrid); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property FieldHeaderMenu: TcxPivotGridFieldHeaderMenu read FFieldHeaderMenu write SetFieldHeaderMenu;
    property GroupValueMenu: TcxPivotGridGroupValueMenu read FGroupValueMenu write SetGroupValueMenu;
    property HeaderAreaMenu: TcxPivotGridHeaderAreaMenu read FHeaderAreaMenu write SetHeaderAreaMenu;
    property OnClick: TcxPivotGridPopupMenuClickEvent read FOnClick write FOnClick;
    property OnPopup: TcxPivotGridPopupMenuPopupEvent read FOnPopup write FOnPopup;
  end;

  { IcxPivotGridDesignerIntf }

  IcxPivotGridDesignerIntf = interface
  ['{DA451370-2F02-43D0-9F31-C25D7632E004}']
    function CanRetrieveFields(var AIsActive: Boolean): Boolean;
    function CreateField: TcxPivotGridField;
    procedure DoCreateAllFields;
  end;

  { TcxPivotGridExportController }

  TcxPivotGridExportController = class
  private
    FPivotGrid: TcxCustomPivotGrid;
    function GetExpandColumns: Boolean;
    function GetExpandRows: Boolean;
    function GetOptionsView: TcxPivotGridOptionsView;
    function GetStyles: TcxPivotGridStyles;
    function GetViewInfo: TcxPivotGridViewInfo;
    procedure SetExpandColumns(AValue: Boolean);
    procedure SetExpandRows(AValue: Boolean);
  protected
    FSavedBorders: Boolean;
    FSavedExpandButtons: Boolean;
    FSavedOptionsView: TcxPivotGridOptionsView;
    FSavedPrefilterOptions: TcxPivotGridOptionsPrefilter;
    FSavedStyles: TcxPivotGridStyles;
    procedure Finalize; virtual;
    procedure Initialize; virtual;
  public
    constructor Create(APivotGrid: TcxCustomPivotGrid); virtual;
    destructor Destroy; override;
    function CalculateViewInfo: TcxPivotGridViewInfo;
    procedure ReplaceStyles(AStyles: IcxPivotGridBaseStyles);

    property ExpandRows: Boolean read GetExpandRows write SetExpandRows;
    property ExpandColumns: Boolean read GetExpandColumns write SetExpandColumns;
    property OptionsView: TcxPivotGridOptionsView read GetOptionsView;
    property PivotGrid: TcxCustomPivotGrid read FPivotGrid;
    property Styles: TcxPivotGridStyles read GetStyles;
    property ViewInfo: TcxPivotGridViewInfo read GetViewInfo;
  end;

  { TcxPivotGridFilterMRUItem }

  TcxPivotGridFilterMRUItem = class(TcxMRUItem)
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

  { TcxPivotGridFilterMRUItems }

  TcxPivotGridFilterMRUItems = class(TcxMRUItems)
  private
    FPivotGrid: TcxCustomPivotGrid;
    FVisibleItems: TList;
    function GetItem(Index: Integer): TcxPivotGridFilterMRUItem;
    function GetVisibleCount: Integer;
    function GetVisibleItem(Index: Integer): TcxPivotGridFilterMRUItem;
    procedure SetVisibleCount(AValue: Integer);
  protected
    procedure RefreshVisibleItemsList;
  public
    constructor Create(APivotGrid: TcxCustomPivotGrid); reintroduce; virtual;
    destructor Destroy; override;
    procedure Add(AFilter: TcxDataFilterCriteria);
    function IsEmpty: Boolean;
    property PivotGrid: TcxCustomPivotGrid read FPivotGrid;
    property Items[Index: Integer]: TcxPivotGridFilterMRUItem read GetItem; default;
    property VisibleCount: Integer read GetVisibleCount write SetVisibleCount;
    property VisibleItems[Index: Integer]: TcxPivotGridFilterMRUItem read GetVisibleItem;
  end;

  { TcxCustomPivotGrid }

  TcxPivotGridCompareEvent = procedure(Sender: TcxCustomPivotGrid;
    AField: TcxPivotGridField; const AValue1, AValue2: Variant; var Compare: Integer) of object;
  TcxPivotGridCustomDrawFieldHeaderEvent = procedure(Sender: TcxCustomPivotGrid;
    ACanvas: TcxCanvas; AViewInfo: TcxPivotGridFieldHeaderCellViewInfo; var ADone: Boolean) of object;
  TcxPivotGridCustomDrawGroupHeaderEvent = procedure(Sender: TcxCustomPivotGrid;
    ACanvas: TcxCanvas; AViewInfo: TcxPivotGridHeaderCellViewInfo; var ADone: Boolean) of object;
  TcxPivotGridCustomDrawCellEvent = procedure(Sender: TcxCustomPivotGrid;
    ACanvas: TcxCanvas; AViewInfo: TcxPivotGridDataCellViewInfo; var ADone: Boolean) of object;
  TcxPivotGridCustomDrawPartEvent = procedure(Sender: TcxCustomPivotGrid;
    ACanvas: TcxCanvas; AViewInfo: TcxPivotGridCustomCellViewInfo; var ADone: Boolean) of object;
  TcxPivotGridFieldChangedEvent = procedure(Sender: TcxCustomPivotGrid; AField: TcxPivotGridField) of object;

  TcxCustomPivotGrid = class(TcxControl, IUnknown, IcxStoredParent, IcxFilterControl, IcxNavigator,
                             IcxStoredObject, IcxPivotGridDesignerIntf, IdxSkinSupport)
  private
    FChanges: TcxPivotGridChanges;
    FController: TcxPivotGridController;
    FCustomization: TcxPivotGridCustomization;
    FCustomSortAssigned: Boolean;
    FDataBuilder: TcxPivotGridDataBuilder;
    FDataController: TcxCustomDataController;
    FFieldHeaderImages: TCustomImageList;
    FFields: TcxObjectList;
    FFilterableFields: TcxPivotGridFields;
    FGroupHeaderImages: TCustomImageList;
    FGroups: TcxPivotGridFieldGroupCollection;
    FHasSummaryVariation: Boolean;
    FHitTest: TcxPivotGridHitTest;
    FHourglassCursorRefCount: Integer;
    FImagesListener: TChangeLink;
    FIsRestoring: Boolean;
    FListeners: TInterfaceList;
    FLockCount: Integer;
    FNavigatorNotifier: TcxNavigatorControlNotifier;
    FOLAPDataSource: TcxPivotGridCustomOLAPDataSource;
    FOptionsBehavior: TcxPivotGridOptionsBehavior;
    FOptionsCustomize: TcxPivotGridOptionsCustomize;
    FOptionsData: TcxPivotGridOptionsData;
    FOptionsDataField: TcxPivotGridOptionsDataField;
    FOptionsPrefilter: TcxPivotGridOptionsPrefilter;
    FOptionsSelection: TcxPivotGridOptionsSelection;
    FOptionsView: TcxPivotGridOptionsView;
    FPainter: TcxPivotGridPainter;
    FPopupMenus: TcxPivotGridPopupMenus;
    FPrefilterMRUItems: TcxPivotGridFilterMRUItems;
    FSummaryFields: TcxPivotGridFields;
    FStyles: TcxPivotGridStyles;
    FViewData: TcxPivotGridViewData;
    FViewInfo: TcxPivotGridViewInfo;
    //
    FPopupMenusEvents: TNotifyEvent;
    FStylesEvents: TNotifyEvent;
    //
    FOnCompare: TcxPivotGridCompareEvent;
    FOnCustomDrawFieldHeader: TcxPivotGridCustomDrawFieldHeaderEvent;
    FOnCustomDrawColumnHeader: TcxPivotGridCustomDrawGroupHeaderEvent;
    FOnCustomDrawRowHeader: TcxPivotGridCustomDrawGroupHeaderEvent;
    FOnCustomDrawCell: TcxPivotGridCustomDrawCellEvent;
    FOnCustomDrawPart: TcxPivotGridCustomDrawPartEvent;
    FOnCustomization: TNotifyEvent;
    FOnFieldPosChanged: TcxPivotGridFieldChangedEvent;
    FOnFieldSizeChanged: TcxPivotGridFieldChangedEvent;
    FOnFilterChanged: TNotifyEvent;
    FOnLayoutChanged: TNotifyEvent;
    FOnSelectionChanged: TNotifyEvent;
    // IcxStoredObject events
    FOnGetStoredProperties: TcxGetStoredPropertiesEvent;
    FOnGetStoredPropertyValue: TcxGetStoredPropertyValueEvent;
    FOnInitStoredObject: TcxInitStoredObjectEvent;
    FOnSetStoredPropertyValue: TcxSetStoredPropertyValueEvent;

    function GetFieldCount: Integer;
    function GetField(AIndex: Integer): TcxPivotGridField;
    function GetIsLocked: Boolean;
    function GetRecordCount: Integer;
    procedure SetField(AIndex: Integer; AValue: TcxPivotGridField);
    procedure SetFieldHeaderImages(AValue: TCustomImageList);
    procedure SetGroupHeaderImages(AValue: TCustomImageList);
    procedure SetGroups(AValue: TcxPivotGridFieldGroupCollection);
    procedure SetImages(var AField: TCustomImageList; ANewValue: TCustomImageList);
    procedure SetOLAPDataSource(AValue: TcxPivotGridCustomOLAPDataSource);
    procedure SetOptionsBehavior(AValue: TcxPivotGridOptionsBehavior);
    procedure SetOptionsCustomize(AValue: TcxPivotGridOptionsCustomize);
    procedure SetOptionsData(AValue: TcxPivotGridOptionsData);
    procedure SetOptionsDataField(AValue: TcxPivotGridOptionsDataField);
    procedure SetOptionsPrefilter(AValue: TcxPivotGridOptionsPrefilter);
    procedure SetOptionsSelection(AValue: TcxPivotGridOptionsSelection);
    procedure SetOptionsView(AValue: TcxPivotGridOptionsView);
    procedure SetPopupMenus(AValue: TcxPivotGridPopupMenus);
    procedure SetStyles(AValue: TcxPivotGridStyles);
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMRefreshCustomization(var Message: TMessage); message DXM_REFRESHCUSTOMIZATION;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
    // IcxStoredObject redirect
    function IcxStoredObject.GetObjectName = StoredObject_GetObjectName;
    function IcxStoredObject.GetProperties = StoredObject_GetProperties;
    procedure IcxStoredObject.GetPropertyValue = StoredObject_GetPropertyValue;
    procedure IcxStoredObject.SetPropertyValue = StoredObject_SetPropertyValue;
    // IcxStoredParent redirect
    function IcxStoredParent.CreateChild = StoredParent_CreateChild;
    procedure IcxStoredParent.DeleteChild = StoredParent_DeleteChild;
    procedure IcxStoredParent.GetChildren = StoredParent_GetChildren;

    procedure RestoreFrom(AStorageType: TcxStorageType;
      const AStorageName: string; AStorageStream: TStream; ACreateChildren, ADeleteChildren: Boolean);
    procedure StoreTo(AStorageType: TcxStorageType;
      const AStorageName: string; AStorageStream: TStream; AReCreate: Boolean = True);
  protected
    NeedUpdateScrollBarsPost: Boolean;
    RefreshDate: TDateTime;
    procedure AddField(AField: TcxPivotGridField);
    procedure RemoveField(AField: TcxPivotGridField);
    //
    procedure BeforeMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure BoundsChanged; override;

    procedure CheckChanges;
    procedure CheckUpdateScrollBars;
    procedure ClearCacheInformation; virtual;
    procedure CreateSubClasses; virtual;
    procedure DestroyEditViewDatas;
    procedure DestroySubClasses; virtual;
    procedure DataChanged; virtual;
    procedure DataSourceChanged; virtual;
    function DoShowPopupMenu(AMenu: TComponent; X, Y: Integer): Boolean; override;
    procedure FilterControlDialogApply(Sender: TObject);
    procedure HideHourglassCursor;
    procedure ImagesChangeHandler(Sender: TObject);
    function IsDestroying: Boolean;
    function IsLoading: Boolean;
    function IsOLAPActive: Boolean;
    function IsPrefilterEnabled: Boolean;
    function IsRestoring: Boolean;
    procedure InitScrollBarsParameters; override;
    procedure RefreshFilterableFieldsList;
    procedure ShowHourglassCursor;
    procedure SynchronizeUniqueName(AField: TcxPivotGridField);
    procedure UpdateMRUItems;

    function GetCursor(X, Y: Integer): TCursor; override;
  {$IFNDEF DELPHI12}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  {$ENDIF}
    function GetDesignHitTest(X, Y: Integer; Shift: TShiftState): Boolean; override;
    function GetDragAndDropObjectClass: TcxDragAndDropObjectClass; override;
    function GetFieldClass: TcxPivotGridFieldClass; virtual;
    procedure Loaded; override;

    function CreateController: TcxPivotGridController; virtual;
    function CreateCustomization: TcxPivotGridCustomization; virtual;
    function CreateDataBuilder: TcxPivotGridDataBuilder; virtual;
    function CreateDataController: TcxCustomDataController; virtual;
    function CreateGroups: TcxPivotGridFieldGroupCollection; virtual;
    function CreateHitTest: TcxPivotGridHitTest; virtual;

    function CreateOptionsBehavior: TcxPivotGridOptionsBehavior; virtual;
    function CreateOptionsCustomize: TcxPivotGridOptionsCustomize; virtual;
    function CreateOptionsData: TcxPivotGridOptionsData; virtual;
    function CreateOptionsDataField: TcxPivotGridOptionsDataField; virtual;
    function CreateOptionsPrefilter: TcxPivotGridOptionsPrefilter; virtual;
    function CreateOptionsSelection: TcxPivotGridOptionsSelection; virtual;
    function CreateOptionsView: TcxPivotGridOptionsView; virtual;
    function CreatePainter: TcxPivotGridPainter; virtual;
    function CreatePopupMenus: TcxPivotGridPopupMenus; virtual;
    function CreateStyles: TcxPivotGridStyles; virtual;
    function CreateViewData: TcxPivotGridViewData; virtual;
    function CreateViewInfo: TcxPivotGridViewInfo; virtual;

    procedure DblClick; override;
    procedure DoCompare(AField: TcxPivotGridField;
      const AValue1, AValue2: Variant; var Compare: Integer); virtual;
    procedure DoCustomDrawFieldHeader(ACanvas: TcxCanvas;
      ACell: TcxPivotGridFieldHeaderCellViewInfo; var ADone: Boolean); virtual;
    procedure DoCustomDrawColumnHeader(ACanvas: TcxCanvas;
      ACell: TcxPivotGridHeaderCellViewInfo; var ADone: Boolean); virtual;
    procedure DoCustomDrawPart(ACanvas: TcxCanvas;
      ACell: TcxPivotGridCustomCellViewInfo; var ADone: Boolean); virtual;
    procedure DoCustomDrawRowHeader(ACanvas: TcxCanvas;
      ACell: TcxPivotGridHeaderCellViewInfo; var ADone: Boolean); virtual;
    procedure DoCustomDrawCell(ACanvas: TcxCanvas;
      ACell: TcxPivotGridDataCellViewInfo; var ADone: Boolean); virtual;
    procedure DoCustomization; virtual;
    procedure DoFieldPosChanged(AField: TcxPivotGridField); virtual;
    procedure DoFieldSizeChanged(AField: TcxPivotGridField); virtual;
    procedure DoFilterChanged;
    procedure DoLayoutChanged; virtual;
    procedure DoPrefilterChanged;
    procedure DoSelectionChanged; virtual;
    procedure FocusChanged; override;
    procedure FontChanged; override;
    function GetIsFocused: Boolean; override;
    function IsDesignerAvailable: Boolean;

    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure LookAndFeelChanged(Sender: TcxLookAndFeel;
      AChangedValues: TcxLookAndFeelValues); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseLeave(AControl: TControl); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure RecreatePainter;
    procedure RecreateViewInfo;
    procedure Scroll(AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode;
      var AScrollPos: Integer); override;
    procedure SelectionChanged;
    procedure SendNotification(AChanges: TcxPivotGridChanges); virtual;
    function SetFieldAreaIndex(AField: TPersistent; AArea: TcxPivotGridFieldArea; var AIndex: Integer): Boolean;
    function StartDragAndDrop(const P: TPoint): Boolean; override;
    procedure ViewChanged;

    // data controller notifications
    function GetItem(Index: Integer): TObject;
    function GetItemID(AItem: TObject): Integer;
    function GetItemValueSource(AItemIndex: Integer): TcxDataEditValueSource; virtual;
    procedure UpdateControl(AInfo: TcxUpdateControlInfo); virtual;
    procedure UpdateData; virtual;
    procedure UpdateItemIndexes; virtual;
    // IcxPivotGridDesigner
    function CanRetrieveFields(var AIsActive: Boolean): Boolean; virtual;
    procedure DoCreateAllFields; virtual;
    // IcxFilterControl
    function GetCaption(Index: Integer): string; virtual;
    function GetCount: Integer;
    function GetCriteria: TcxFilterCriteria;
    function GetItemLink(Index: Integer): TObject;
    function GetItemLinkID(Index: Integer): Integer;
    function GetItemLinkName(Index: Integer): string;
    function GetFieldName(Index: Integer): string;
    function GetProperties(Index: Integer): TcxCustomEditProperties; overload;
    function GetValueType(Index: Integer): TcxValueTypeClass;
    // IcxNavigator
    function CanAppend: Boolean;
    function CanDelete: Boolean;
    function CanEdit: Boolean;
    function CanInsert: Boolean;
    function IsActive: Boolean;
    function IsBof: Boolean;
    function IsBookmarkAvailable: Boolean;
    function IsEditing: Boolean;
    function IsEof: Boolean;
    procedure ClearBookmark;
    procedure DoAction(AButtonIndex: Integer);
    function GetNotifier: TcxNavigatorControlNotifier;
    function IsActionSupported(AButtonIndex: Integer): Boolean;
    // IcxStoredObject
    function StoredObject_GetObjectName: string;
    function StoredObject_GetProperties(AProperties: TStrings): Boolean; overload; virtual;
    procedure StoredObject_GetPropertyValue(const AName: string; var AValue: Variant); virtual;
    procedure StoredObject_SetPropertyValue(const AName: string; const AValue: Variant); virtual;
    // IcxStoredParent
    function StoredParent_CreateChild(const AObjectName, AClassName: string): TObject; virtual;
    procedure StoredParent_DeleteChild(const AObjectName: string; AObject: TObject); virtual;
    procedure StoredParent_GetChildren(AChildren: TStringList); virtual;

    property OLAPDataSource: TcxPivotGridCustomOLAPDataSource read FOLAPDataSource write SetOLAPDataSource;
    property BorderStyle default cxcbsDefault;
    property Changes: TcxPivotGridChanges read FChanges write FChanges;
    property Controller: TcxPivotGridController read FController;
    property CustomSortAssigned: Boolean read FCustomSortAssigned;
    property DataBuilder: TcxPivotGridDataBuilder read FDataBuilder;
    property FieldList: TcxObjectList read FFields;
    property HasSummaryVariation: Boolean read FHasSummaryVariation write FHasSummaryVariation;
    property ImagesListener: TChangeLink read FImagesListener;
    property IsLocked: Boolean read GetIsLocked;
    property LockCount: Integer read FLockCount write FLockCount;
    property Painter: TcxPivotGridPainter read FPainter;
    property PrefilterMRUItems: TcxPivotGridFilterMRUItems read FPrefilterMRUItems;
    property RecordCount: Integer read GetRecordCount;
    property ViewInfo: TcxPivotGridViewInfo read FViewInfo;

    property OnCompare: TcxPivotGridCompareEvent read FOnCompare write FOnCompare;
    property OnCustomDrawFieldHeader: TcxPivotGridCustomDrawFieldHeaderEvent
      read FOnCustomDrawFieldHeader write FOnCustomDrawFieldHeader;
    property OnCustomDrawColumnHeader: TcxPivotGridCustomDrawGroupHeaderEvent
      read FOnCustomDrawColumnHeader write FOnCustomDrawColumnHeader;
    property OnCustomDrawRowHeader: TcxPivotGridCustomDrawGroupHeaderEvent
      read FOnCustomDrawRowHeader write FOnCustomDrawRowHeader;
    property OnCustomDrawCell: TcxPivotGridCustomDrawCellEvent
      read FOnCustomDrawCell write FOnCustomDrawCell;
    property OnCustomDrawPart: TcxPivotGridCustomDrawPartEvent
      read FOnCustomDrawPart write FOnCustomDrawPart;
    property OnCustomization: TNotifyEvent read FOnCustomization write FOnCustomization;
    property OnFieldPosChanged: TcxPivotGridFieldChangedEvent read FOnFieldPosChanged write FOnFieldPosChanged;
    property OnFieldSizeChanged: TcxPivotGridFieldChangedEvent read FOnFieldSizeChanged write FOnFieldSizeChanged;
    property OnFilterChanged: TNotifyEvent read FOnFilterChanged write FOnFilterChanged;
    property OnLayoutChanged: TNotifyEvent read FOnLayoutChanged write FOnLayoutChanged;
    property OnSelectionChanged: TNotifyEvent read FOnSelectionChanged write FOnSelectionChanged;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddListener(AListener: IcxPivotGridListener);
    procedure ApplyBestFit;
    procedure BeginUpdate;
    procedure CopyToClipboard(ACopyAll: Boolean = False); virtual;
    function CreateDrillDownDataSource: TcxCustomDataSource; virtual;
    function CreateField: TcxPivotGridField; virtual;
    procedure DeleteAllFields;
    procedure EndUpdate;
  {$IFDEF DELPHI12}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  {$ENDIF}
    procedure ShowPrefilterDialog;

    procedure FullRefresh;
    function GetFieldByName(const AName: string): TcxPivotGridField;
    procedure LayoutChanged;
    procedure RemoveListener(AListener: IcxPivotGridListener);

    // Store/Restore
    procedure RestoreFromIniFile(const AStorageName: string; ACreateChildren: Boolean = False; ADeleteChildren: Boolean = False);
    procedure RestoreFromRegistry(const AStorageName: string; ACreateChildren: Boolean = False; ADeleteChildren: Boolean = False);
    procedure RestoreFromStream(AStream: TStream; ACreateChildren: Boolean = False; ADeleteChildren: Boolean = False);
    procedure StoreToIniFile(const AStorageName: string; AReCreate: Boolean = True);
    procedure StoreToRegistry(const AStorageName: string; AReCreate: Boolean = True);
    procedure StoreToStream(AStream: TStream);

    //IdxLocalizerListener
    procedure TranslationChanged; override;

    property Customization: TcxPivotGridCustomization read FCustomization;
    property DataController: TcxCustomDataController read FDataController;
    property FieldCount: Integer read GetFieldCount;
    property FieldHeaderImages: TCustomImageList read FFieldHeaderImages write SetFieldHeaderImages;
    property Fields[Index: Integer]: TcxPivotGridField read GetField write SetField;
    property Font;
    property GroupHeaderImages: TCustomImageList read FGroupHeaderImages write SetGroupHeaderImages;
    property Groups: TcxPivotGridFieldGroupCollection read FGroups write SetGroups;
    property HitTest: TcxPivotGridHitTest read FHitTest;
    property LookAndFeel;
    property LookAndFeelPainter;
    property OptionsBehavior: TcxPivotGridOptionsBehavior read FOptionsBehavior write SetOptionsBehavior;
    property OptionsCustomize: TcxPivotGridOptionsCustomize read FOptionsCustomize write SetOptionsCustomize;
    property OptionsData: TcxPivotGridOptionsData read FOptionsData write SetOptionsData;
    property OptionsDataField: TcxPivotGridOptionsDataField read FOptionsDataField write SetOptionsDataField;
    property OptionsPrefilter: TcxPivotGridOptionsPrefilter read FOptionsPrefilter write SetOptionsPrefilter;
    property OptionsSelection: TcxPivotGridOptionsSelection read FOptionsSelection write SetOptionsSelection;
    property OptionsView: TcxPivotGridOptionsView read FOptionsView write SetOptionsView;
    property PopupMenus: TcxPivotGridPopupMenus read FPopupMenus write SetPopupMenus;
    property Styles: TcxPivotGridStyles read FStyles write SetStyles;
    property SummaryFields: TcxPivotGridFields read FSummaryFields;
    property ViewData: TcxPivotGridViewData read FViewData;
  published
    property PopupMenusEvents: TNotifyEvent read FPopupMenusEvents write FPopupMenusEvents;
    property StylesEvents: TNotifyEvent read FStylesEvents write FStylesEvents;
    // IcxStoredObject events
    property OnGetStoredProperties: TcxGetStoredPropertiesEvent read FOnGetStoredProperties write FOnGetStoredProperties;
    property OnGetStoredPropertyValue: TcxGetStoredPropertyValueEvent read FOnGetStoredPropertyValue write FOnGetStoredPropertyValue;
    property OnInitStoredObject: TcxInitStoredObjectEvent read FOnInitStoredObject write FOnInitStoredObject;
    property OnSetStoredPropertyValue: TcxSetStoredPropertyValueEvent read FOnSetStoredPropertyValue write FOnSetStoredPropertyValue;
  end;

  { IcxPivotGridDesignerHelper }

  IcxPivotGridDesignerHelper = interface
  ['{88DE8BF4-DCA9-4E8A-B5FA-B860CD01299C}']
    procedure AddListener(APivotGrid: TcxCustomPivotGrid);
    procedure RemoveListener(APivotGrid: TcxCustomPivotGrid);
    procedure Select(AObject: TPersistent; AShift: TShiftState);
    function IsObjectSelected(AObject: TPersistent): Boolean;
  end;

  TcxPivotGridCustomDesignHelper = class(TObject)
  protected
    procedure RefreshListener(APivotGrid: TcxCustomPivotGrid);
  end;

const
  DesignerHelper: IcxPivotGridDesignerHelper = nil;
  cxPivotGridCustomizationFormClass: TcxPivotGridCustomizationFormClass = TcxPivotGridCustomCustomizationForm;
  PivotGridCrossCellSummaryClass: TcxPivotGridCrossCellSummaryClass = TcxPivotGridCrossCellSummary;
  cxPivotGridPopupMenuImages: TCustomImageList = nil;

  procedure PivotGridError(ACondition: Boolean; const AMessage: string);
  function cxPivotGridHierarchyImages: TImageList;
  function IsNotLastVisibleOLAPHierarchyItem(AnItem: TcxPivotGridGroupItem): Boolean;
  function GetCountInArea(AFields: TcxPivotGridFields; AArea: TcxPivotGridFieldArea): Integer;

implementation

{$R *.res}

uses
  cxTextEdit, cxPivotGridCustomization, cxPivotGridStrs, cxLibraryConsts,
  cxEditDataRegisteredRepositoryItems;

const
  cxInvisiblePos = 30000;

  OrdinalTypeSet: set of Byte =
   [varSmallInt, varInteger, varBoolean, varByte
    {$IFDEF DELPHI6}, varWord, varShortInt, varLongWord, varInt64 {$ENDIF}];

  E_NOINTERFACE = HResult($80004002);

  CustomizationCommand: array[Boolean] of Integer =
    (pgcmShowCustomization, pgcmHideCustomization);

  DataAreaToFieldArea: array[TcxPivotGridDataFieldArea] of TcxPivotGridFieldArea =
    (faFilter, faColumn, faRow);

  DimensionAllowedAreas: array[Boolean] of TcxPivotGridFieldAreas =
    ([faColumn, faRow, faFilter], [faData]);

  PivotGridDefaultStoredProperties: array[0..1] of string  = ('Prefilter', 'PrefilterActive');
  FieldDefaultStoredProperties: array[0..6] of string  =
    ('SortOrder', 'GroupExpanded', 'Visible', 'Width', 'Area', 'AreaIndex', 'Filter');

  FHierarchyImages: TImageList = nil;

  // prefilter
  PrefilterButtonsFirstOffset = 4;
  PrefilterButtonsOffset = 4;
  PrefilterTextOffset = 3;


function IsNotLastVisibleOLAPHierarchyItem(AnItem: TcxPivotGridGroupItem): boolean;

  function IsOLAPHierarchy: Boolean;
  begin
    Result := AnItem.Field.IsHierarchy and (AnItem.Field.Link.GroupIndex >= 0);
  end;

begin
  Result := (AnItem <> nil) and (AnItem.Field <> nil) and IsOLAPHierarchy and
    (AnItem.Field.Group.IndexOf(AnItem.Field) < AnItem.Field.Group.VisibleCount - 1);
end;

function GetCountInArea(AFields: TcxPivotGridFields; AArea: TcxPivotGridFieldArea): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to AFields.Count - 1 do
    if AFields[I].Area = AArea then
      Inc(Result);
end;

function GetPropertyIndex(const AName: string; ANamesMap: array of string): Integer;
var
  I: Integer;
begin
  for I := Low(ANamesMap) to High(ANamesMap) do
    if SameText(ANamesMap[I], AName) then
    begin
      Result := I;
      Exit;
    end;
  Result := -1;
end;

type
  TcxEditStyleAccess = class(TcxEditStyle);

  TcxPivotGridFieldPosition = class
  protected
    FAreaIndex: Integer;
    FField: TPersistent;
    FIndex: Integer;
    FVisible: Boolean;
    FGroup: TcxPivotGridFieldGroup;
  public
    constructor Create(AField: TPersistent);
    procedure SetAreaIndex(var AAreaIndex: Integer);
    function IsSameGroup(AField: TcxPivotGridField): Boolean;

    property AreaIndex: Integer read FAreaIndex;
    property Field: TPersistent read FField;
    property Group: TcxPivotGridFieldGroup read FGroup;
    property Index: Integer read FIndex;
    property Visible: Boolean read FVisible;
  end;

{ TcxPivotGridFieldPosition }

constructor TcxPivotGridFieldPosition.Create(AField: TPersistent);
begin
  FField := AField;
  FIndex := MaxInt;
  FVisible := True;
  if AField is TcxPivotGridField then
  begin
    FAreaIndex := (AField as TcxPivotGridField).AreaIndex;
    FIndex := (AField as TcxPivotGridField).Index;
    FVisible := (AField as TcxPivotGridField).Visible;
    FGroup := (AField as TcxPivotGridField).Group;
  end
  else
  begin
    FAreaIndex := (AField as TcxPivotGridOptionsDataField).AreaIndex;
    if FAreaIndex = -1 then
      FAreaIndex := MaxInt;
  end;
end;

procedure TcxPivotGridFieldPosition.SetAreaIndex(var AAreaIndex: Integer);
begin
  if Field is TcxPivotGridField then
  begin
    (Field as TcxPivotGridField).FAreaIndex := AAreaIndex;
    if FGroup <> nil then
      FGroup.ResetIndexes(AAreaIndex);
  end
  else
     (Field as TcxPivotGridOptionsDataField).FAreaIndex := AAreaIndex;
end;

function TcxPivotGridFieldPosition.IsSameGroup(AField: TcxPivotGridField): Boolean;
begin
  Result := (AField = FField) or ((AField.Group <> nil) and (AField.Group = FGroup));
end;

procedure PivotGridError(ACondition: Boolean; const AMessage: string);
begin
  if not ACondition then
    raise EcxPivotGrid.Create(AMessage);
end;

function CompareFieldsOrder(AField1, AField2: TcxPivotGridField): Integer;
begin
  Result := Byte(AField1.Area) - Byte(AField2.Area);
  if Result = 0 then
    Result := AField1.AreaIndex - AField2.AreaIndex;
  if (AField1.AreaIndex = -1) and (AField2.AreaIndex >= 0) then
    Result := 1;
  if Result = 0 then
    Result := AField1.Index - AField2.Index;
end;

function CompareFieldsOnLoading(AField1, AField2: TcxPivotGridField): Integer;
begin
  Result := AField1.AreaIndex - AField2.AreaIndex;
end;

function CompareFieldsPosition(AInfo1, AInfo2: TcxPivotGridFieldPosition): Integer;
begin
  Result := AInfo1.AreaIndex - AInfo2.AreaIndex;
  if (AInfo1.Index = -1) and (AInfo2.Index >= 0) then
    Result := 1;
  if Result = 0 then
    Result := AInfo1.Index - AInfo2.Index;

end;

function CompareGroupItemsBySummary(AItem1, AItem2: TcxPivotGridGroupItem): Integer;
begin
  if (AItem1 <> AItem2) and (AItem1.RecordIndex = cxPivotGridOthersRecordIndex) then
  begin
    // "Others" must be always at down
    Result := 1;
    Exit;
  end;
  Result := VarCompare(AItem1.SummaryValue, AItem2.SummaryValue);
  if AItem1.Field.SortOrder = soDescending then
    Result := -Result;
end;

function CompareFilterValues(AItem1, AItem2: TcxPivotGridVariantValue): Integer;
begin
  Result := VarCompare(AItem1.Value, AItem2.Value);
end;

function CompareRecordIndexes(ARecNo1, ARecNo2: Integer): Integer;
begin
  Result := ARecNo1 - ARecNo2;
end;

function CompareFilterObjects(AItem1, AItem2: TcxPivotGridVariantValue): Integer;
begin
  if (AItem1 = nil) and (AItem2 = nil) then
    Result := 0
  else
    if AItem1 = nil then
      Result := 1
    else
      if AItem2 = nil then
        Result := -1
      else
        Result := CompareFilterValues(AItem1, AItem2);
end;

function FindItem(AList: TList; const AValue: Variant; var AIndex: Integer;
  ASortOrder: TcxDataSortOrder): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  L := 0;
  H := AList.Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := TcxPivotGridGroupItem(AList.List^[I]).Compare(AValue);
    if ASortOrder  = soDescending then
      C := -C;
    if C < 0 then
      L := I + 1
    else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        L := I;
      end;
    end;
  end;
  AIndex := L;
end;

function GetItemNeighbors(AIsTop, AIsLeft, AIsBottom, AIsRight: Boolean): TcxNeighbors;
begin
  Result := [];
  if not AIsTop then Include(Result, nTop);
  if not AIsBottom then Include(Result, nBottom);
  if not AIsLeft then Include(Result, nLeft);
  if not AIsRight then Include(Result, nRight);
end;

procedure SwapImages(var AImage1, AImage2: TBitmap);
var
  ATemp: TBitmap;
begin
  ATemp := AImage1;
  AImage1 := AImage2;
  AImage2 := ATemp;
end;

function VarTypeIsCurrency(VType: Integer): Boolean;
begin
  Result := (VType = varCurrency) {$IFDEF DELPHI6} or (VType = varFMTBCD){$ENDIF}
end;

function FormatDisplayValue(const AValue: Variant;
  const ADisplayFormat: string; AIsPercent: Boolean): string;
var
  AFormatStr: string;
begin
  AFormatStr := ADisplayFormat;
  if AFormatStr = '' then
  begin
    if AIsPercent then
      AFormatStr := cxPivotGridDefaultFieldPercentFormat
    else
      if VarTypeIsCurrency(VarType(AValue)) then
        AFormatStr := cxFormatController.CurrencyFormat
      else
        if VarIsFloat(AValue) then
          AFormatStr :=  cxPivotGridDefaultFieldFloatFormat
        else
          if VarIsOrdinal(AValue) then
            AFormatStr := cxPivotGridDefaultFieldIntFormat;
  end;
  if VarIsNumericEx(AValue) then
    Result := FormatFloat(AFormatStr, AValue)
  else
    Result := VarToStr(AValue);
end;

{ TcxList }

procedure TcxList.Assign(
  AListA: TList; AOperator: TListAssignOp = laCopy; AListB: TList = nil);
var
  I: Integer;
  AItem: Pointer;
begin
  if AOperator = laCopy then
  begin
    Count := AListA.Count;
    System.Move(AListA.List^, List^, Count * SizeOf(Integer));
  end
  else
    if AOperator = laAnd then
    begin
      for I := 0 to AListA.Count - 1 do
      begin
        AItem := AListA.Items[I];
        if AListB.IndexOf(AItem) <> -1 then
          Add(AItem);
      end;
    end
    else
      if AOperator = laOr then
      begin
        if AListA.Count > 0 then
        begin
          Count := Count + AListA.Count;
          System.Move(AListA.List^, Pointer(@List^[Count - AListA.Count])^,
            AListA.Count * SizeOf(Pointer));
        end;
      end
      else
     {$IFNDEF DELPHI6}
        PivotGridError(False, scxNotImplemented);
     {$ELSE}
        inherited Assign(AListA, AOperator, AListB);
     {$ENDIF}
end;

{ TcxPivotGridVariantValue }

constructor TcxPivotGridVariantValue.Create(const AValue: Variant);
begin
  FValue := AValue;
end;

function TcxPivotGridVariantValue.Compare(const AValue: Variant): Integer;
begin
  Result := VarCompare(FValue, AValue);
end;

function TcxPivotGridVariantValue.IsEqual(AValue: TcxPivotGridVariantValue): Boolean;
begin
  Result := (AValue <> nil) and ((AValue = Self) or VarEquals(AValue.Value, Value));
end;

{ TcxPivotGridVariantList }

constructor TcxPivotGridVariantList.Create;
begin
  FItems := TcxObjectList.Create;
end;

destructor TcxPivotGridVariantList.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

function TcxPivotGridVariantList.Add(const AValue: Variant): Integer;
begin
  Sorted := False;
  Result := FItems.Add(TcxPivotGridVariantValue.Create(AValue));
  Changed;
end;

function TcxPivotGridVariantList.AddUnique(const AValue: Variant): Integer;
begin
  Result := IndexOf(AValue);
  if Result < 0 then
    Result := Add(AValue);
end;

procedure TcxPivotGridVariantList.Clear;
begin
  FItems.Clear;
  Changed;
end;

procedure TcxPivotGridVariantList.Delete(AIndex: Integer);
begin
  FItems.Items[AIndex].Free;
  FItems.Delete(AIndex);
  Changed;
end;

function TcxPivotGridVariantList.IndexOf(const AValue: Variant): Integer;
var
  L, H, I, C: Integer;
begin
  Result := -1;
  MakeSorted;
  // binary search
  L := 0;
  H := Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := Items[I].Compare(AValue);
    if C < 0 then
      L := I + 1
    else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := I;
        Break;
      end;
    end;
  end;
end;

procedure TcxPivotGridVariantList.MakeUnique;
var
  I, C: Integer;
  AItem: TcxPivotGridVariantValue;
begin
  I := 0;
  C := 0;
  AItem := nil;
  MakeSorted;
  while I < Count do
  begin
    if (I > 0) and AItem.IsEqual(Items[I]) then
    begin
      AItem.FUnUsed := AItem.FUnUsed and Items[I].FUnUsed;
      FreeAndNil(TObject(FItems.List^[I]));
      Inc(C);
    end
    else
      AItem := Items[I];
    Inc(I);
  end;
  FItems.Sort(@CompareFilterObjects);
  FItems.Count := FItems.Count - C;
end;

function TcxPivotGridVariantList.Remove(const AValue: Variant): Integer;
begin
  Result := IndexOf(AValue);
  if Result <> cxPivotGridInvalidIndex then
    Delete(Result);
end;

procedure TcxPivotGridVariantList.BeginUpdate;
begin
  Inc(FLockCount);
end;

procedure TcxPivotGridVariantList.EndUpdate(AForceUpdate: Boolean = True);
begin
  if FLockCount > 0 then
  begin
    Dec(FLockCount);
    if AForceUpdate or FModified then
      Changed;
  end;
end;

procedure TcxPivotGridVariantList.Changed;
begin
  if FLockCount = 0 then
  begin
    CallNotify(OnChange, Self);
    FModified := False;
  end
  else
    FModified := True;
end;

procedure TcxPivotGridVariantList.MakeSorted;
begin
  if not Sorted then
  begin
    FItems.Sort(@CompareFilterValues);
    Sorted := True;
  end;
end;

function TcxPivotGridVariantList.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxPivotGridVariantList.GetItem(
  AIndex: Integer): TcxPivotGridVariantValue;
begin
  Result := TcxPivotGridVariantValue(FItems[AIndex]);
end;

function TcxPivotGridVariantList.GetValue(AIndex: Integer): Variant;
begin
  Result := Items[AIndex].Value;
end;

procedure TcxPivotGridVariantList.SetValue(AIndex: Integer; AValue: Variant);
begin
  Sorted := False;
  Items[AIndex].FValue := AValue;
end;

{ TcxPivotGridRecords }

procedure TcxPivotGridRecords.Add(ARecordIndex: Integer);
begin
  inherited Add(Pointer(ARecordIndex));
  Sorted := False;
end;

procedure TcxPivotGridRecords.MakeSorted;
begin
  if not Sorted then
  begin
    Sort(@CompareRecordIndexes);
    Sorted := True;
  end;
end;

procedure TcxPivotGridRecords.MakeUnique;
var
  I, J, K: Integer;
begin
  MakeSorted;
  I := 0;
  K := 0;
  while I < Count do
  begin
    J := I + 1;
    while (J < Count) and (Integer(List^[I]) = Integer(List^[J])) do
    begin
      Integer(List^[J]) := MaxInt;
      Inc(J);
      Inc(K);
    end;
    I := J;
  end;
  if K > 0 then
  begin
    FSorted := False;
    MakeSorted;
    Count := Count - K;
  end;
end;

procedure TcxPivotGridRecords.CreateIntersection(AListA, AListB: TcxPivotGridRecords);
type
  TIntArray = array[0..MaxInt div SizeOf(Integer) - 1] of Integer;
  PIntArray = ^TIntArray;
var
  I: Integer;
  ASourceList: PIntArray;
begin
  Capacity := Max(AListA.Count, AListB.Count);
  AListA.Assign(AListB, laOr);
  AListA.MakeSorted;
  I := 0;
  ASourceList := Pointer(AListA.List);
  while I < AListA.Count - 1 do
  begin
    Inc(I);
    if ASourceList^[I - 1] = ASourceList^[I] then
    begin
      Add(ASourceList^[I]);
      Inc(I);
    end
  end;
  FreeAndNil(AListA);
  FreeAndNil(AListB);
  Capacity := Count;
end;

function TcxPivotGridRecords.GetItem(AIndex: Integer): Integer;
begin
  Result := Integer(inherited Items[AIndex]);
end;

procedure TcxPivotGridRecords.SetItem(AIndex, AValue: Integer);
begin
  inherited Items[AIndex] := Pointer(AValue);
end;

{ TcxPivotGridFields }

function TcxPivotGridFields.GetField(Index: Integer): TcxPivotGridField;
begin
  Result := TcxPivotGridField(inherited Items[Index]);
end;

function TcxPivotGridFields.GetFirstField: TcxPivotGridField;
begin
  if Count > 0 then
    Result := TcxPivotGridField(List^[0])
  else
    Result := nil;
end;

procedure TcxPivotGridFields.ArrangeFields;
begin
  Sort(@CompareFieldsOrder);
end;

{ TcxPivotGridCells }

procedure TcxPivotGridCells.BeforePaint;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].CheckVisibleInfo;
end;

function TcxPivotGridCells.CalculateHitTest(AHitTest: TcxPivotGridHitTest): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Count - 1 do
  begin
    Result := Items[I].GetHitTest(AHitTest);
    if Result then Exit;
  end;
end;

procedure TcxPivotGridCells.DeleteAll;
begin
  SetCount(0);
end;

procedure TcxPivotGridCells.ExcludeFromClipping(ACanvas: TcxCanvas);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].ExcludeFromPaint(ACanvas);
end;

procedure TcxPivotGridCells.Paint(
  ACanvas: TcxCanvas; AHandler: TcxPivotGridCustomDrawEvent);

  procedure DoDrawItem(AItem: TcxPivotGridCustomCellViewInfo);
  var
    ADone: Boolean;
  begin
    AItem.BeforeCustomDraw(ACanvas);
    AHandler(ACanvas, AItem, ADone);
    AItem.AfterCustomDraw(ACanvas);
    if not ADone then
      AItem.Draw(ACanvas);
  end;

var
  I: Integer;
  AClipRgn: TcxRegion;
  AItem: TcxPivotGridCustomCellViewInfo;
begin
  for I := 0 to Count - 1 do
  begin
    AItem := Items[I];
    if (AItem.Visible and RectVisible(ACanvas.Handle, AItem.FClipRect)) then
      if AItem.HasClipping then
      begin
        AClipRgn := ACanvas.GetClipRegion;
        ACanvas.IntersectClipRect(AItem.ClipRect);
        DoDrawItem(AItem);
        ACanvas.SetClipRegion(AClipRgn, roSet);
      end
      else
        DoDrawItem(AItem);
  end;
end;

procedure TcxPivotGridCells.CorrectBoundsForPrinting(ABounds: TRect);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].CorrectBoundsForPrinting(ABounds);
end;

function TcxPivotGridCells.GetItem(AIndex: Integer): TcxPivotGridCustomCellViewInfo;
begin
  Result := TcxPivotGridCustomCellViewInfo(List^[AIndex]);
end;

{ TcxPivotGridPrefilter }

constructor TcxPivotGridPrefilter.Create(APivotGrid: TcxCustomPivotGrid);
begin
  inherited Create;
  FPivotGrid := APivotGrid;
end;

procedure TcxPivotGridPrefilter.ShowPrefilterDialog;
begin
  FPivotGrid.ShowPrefilterDialog;
end;

procedure TcxPivotGridPrefilter.Calculate(var AClientBounds: TRect);
var
  AHeight: Integer;
  ABounds: TRect;
  APivotGridViewInfo: TcxPivotGridViewInfo;
begin
  if Visible then
  begin
    APivotGridViewInfo := FPivotGrid.ViewInfo;
    Add(TcxPivotGridPrefilterViewInfo.Create(Self, APivotGridViewInfo.Painter,
      AClientBounds, AClientBounds, APivotGridViewInfo.BaseStyles.GetPrefilterParams));
    AHeight := ViewInfo.GetHeight;
    if Position = pfpBottom then
    begin
      ABounds := cxRectSetBottom(AClientBounds, AClientBounds.Bottom, AHeight);
      Dec(AClientBounds.Bottom, AHeight);
    end
    else
    begin
      ABounds := cxRectSetHeight(AClientBounds, AHeight);
      Inc(AClientBounds.Top, AHeight);
    end;
    ViewInfo.CalculateCellBounds(ABounds, ABounds);
  end;
end;

function TcxPivotGridPrefilter.GetCanMRUPopupShow: Boolean;
begin
  Result := FPivotGrid.OptionsPrefilter.MRUItemsList and
    not FPivotGrid.PrefilterMRUItems.IsEmpty;
end;

function TcxPivotGridPrefilter.GetCustomizeButtonVisible: Boolean;
begin
  Result := FPivotGrid.OptionsPrefilter.CustomizeButton;
end;

function TcxPivotGridPrefilter.GetFilter: TcxDataFilterCriteria;
begin
  Result := FPivotGrid.DataController.Filter;
end;

function TcxPivotGridPrefilter.GetPosition: TcxPivotGridPrefilterPosition;
begin
  Result := FPivotGrid.OptionsPrefilter.Position;
end;

function TcxPivotGridPrefilter.GetViewInfo: TcxPivotGridPrefilterViewInfo;
begin
  if Count > 0 then
    Result := TcxPivotGridPrefilterViewInfo(Items[0])
  else
    Result := nil;
end;

function TcxPivotGridPrefilter.GetVisible: Boolean;
var
  AVisible: TcxPivotGridPrefilterVisible;
begin
  AVisible := FPivotGrid.OptionsPrefilter.Visible;
  Result := (AVisible = pfvAlways) or ((AVisible = pfvNonEmpty) and not Filter.IsEmpty);
end;

{ TcxPivotGridGroupItem }

constructor TcxPivotGridGroupItem.Create(AParent: TcxPivotGridGroupItem;
  ADataController: TcxCustomDataController; ARecordIndex: Integer; AField: TcxPivotGridField);
begin
  FParent := AParent;
  FDataController := ADataController;
  FRecordIndex := ARecordIndex;
  FField := AField;
  FItems := TcxObjectList.Create;
  FRecords := TcxPivotGridRecords.Create;
  FExpanded := True;
end;

destructor TcxPivotGridGroupItem.Destroy;
begin
  FreeAndNil(FItems);
  FreeAndNil(FRecords);
  inherited Destroy;
end;

function TcxPivotGridGroupItem.AddChild(
  AClass: TcxPivotGridGroupItemClass): TcxPivotGridGroupItem;
begin
  Result := AClass.Create(Self, DataController, -1, nil);
  ItemList.Add(Result);
end;

function TcxPivotGridGroupItem.AddChild(AIndex, ARecordIndex: Integer;
  AField: TcxPivotGridField): TcxPivotGridGroupItem;
begin
  Result := ChildItemsClass.Create(Self, DataController, ARecordIndex, AField);
  ItemList.Insert(AIndex, Result);
end;

function TcxPivotGridGroupItem.ChildrenNeeded: Boolean;
begin
  Result := not Expanded and HasChildren and (ItemCount = 0);
end;

function TcxPivotGridGroupItem.Compare(const AValue: Variant): Integer;
begin
  if VarIsStr(Value) and VarIsStr(AValue) then
    Result := PivotGrid.OptionsData.CompareAsString(Value, AValue)
  else
    Result := VarCompare(Value, AValue);
  if PivotGrid.CustomSortAssigned then
    PivotGrid.DoCompare(Field, Value, AValue, Result);
end;

function TcxPivotGridGroupItem.CreateSummaryRecords: TcxPivotGridRecords;

  procedure ProcessItem(AItem: TcxPivotGridGroupItem);
  var
    I, ARecord: Integer;
  begin
    if AItem.ItemCount > 0 then
      for I := 0 to AItem.ItemCount - 1 do
        ProcessItem(AItem.Items[I])
    else
      for I := 0 to AItem.Records.Count - 1 do
      begin
        ARecord := AItem.Records[I];
        if PivotGrid.DataBuilder.FilteredIndexes[ARecord] > -1 then
           Result.Add(ARecord);
      end;
  end;

var
  I: Integer;
begin
  Result := TcxPivotGridRecords.Create;
  if Parent = nil then
  begin
    Result.Capacity := PivotGrid.RecordCount;
    for I := 0 to PivotGrid.RecordCount - 1 do
      if PivotGrid.DataBuilder.FilteredIndexes[I] > -1 then
        Result.Add(I);
  end
  else //todo: Need non recursive
    ProcessItem(Self);
end;

procedure TcxPivotGridGroupItem.DeleteChildren;
begin
  FItems.Clear;
end;

function TcxPivotGridGroupItem.GetCellByCrossItem(
  AItem: TcxPivotGridGroupItem): TcxPivotGridCrossCell;
begin
  Result := nil;
end;

function TcxPivotGridGroupItem.GetPrev: TcxPivotGridGroupItem;
var
  AItem: TcxPivotGridGroupItem;
begin
  Result := nil;
  AItem := Self;
  while (AItem.Index = 0) and (AItem.Level > 0) do
    AItem := AItem.Parent;
  if AItem.Index = 0 then Exit;
  AItem := AItem.getPrevSibling;
  while (AItem.Level > Level) and (AItem.ItemCount > 0) do
    AItem := AItem.Items[AItem.ItemCount - 1];
  if (AItem <> nil) and (AItem.Level = Level) then
    Result := AItem;
end;

procedure TcxPivotGridGroupItem.InitializeValue(
  const ADisplayText: string; const AnUniqueName: WideString);
begin
  FDisplayText := ADisplayText;
  FUniqueName := AnUniqueName;
  FInternalValue := FUniqueName;
  FIsValueAsssigned := True;
end;

procedure TcxPivotGridGroupItem.MarkDeleted;
var
  I: Integer;
  AFilteredRecords: TcxPivotGridRecords;
begin
  AFilteredRecords := PivotGrid.DataBuilder.FilteredIndexes;
  for I := 0 to ItemCount - 1 do
    Items[I].MarkDeleted;
  if Records <> nil then
  begin
    for I := 0 to Records.Count - 1 do
      AFilteredRecords[Records[I]] := cxPivotGridInvalidIndex;
  end;
  AFilteredRecords[RecordIndex] := cxPivotGridInvalidIndex;
end;

procedure TcxPivotGridGroupItem.RemoveChildrenFrom(AItem: TcxPivotGridGroupItem);
var
  AIndex, I: Integer;
  ASubItem: TcxPivotGridGroupItem;
begin
  for I := 0 to AItem.ItemCount - 1 do
  begin
    ASubItem := AItem.Items[I];
    if not FindItem(ItemList, ASubItem.Value, AIndex, ASubItem.Field.SortOrder) then
    begin
      ASubItem.FParent := Self;
      ItemList.Insert(AIndex, ASubItem)
    end
    else
    begin
      Items[AIndex].RemoveChildrenFrom(ASubItem);
//      Items[AIndex].Records.Assign(AItem.Records, laOr);
      ASubItem.Free;
    end;
  end;
  AItem.ItemList.Count := 0;
  Records.Assign(AItem.Records, laOr);
end;

procedure TcxPivotGridGroupItem.CheckExpanding;
begin
 FExpanded := FExpanded or (Field <> nil) and Field.IsItemExpanded(Self);
end;

function TcxPivotGridGroupItem.ChildItemsClass: TcxPivotGridGroupItemClass;
begin
  Result := TcxPivotGridGroupItemClass(Self.ClassType);
end;

function TcxPivotGridGroupItem.GetCrossCellClass: TcxPivotGridCrossCellClass;
begin
  Result := TcxPivotGridCrossCell;
  if (PivotGrid <> nil) and PivotGrid.IsOLAPActive then
    Result := TcxPivotGridOLAPCrossCell;
end;

function TcxPivotGridGroupItem.GetIsCollapsed: Boolean;
begin
  Result := not Expanded and HasChildren;
end;

function TcxPivotGridGroupItem.GetIsRow: Boolean;
begin
  Result := False;
end;

function TcxPivotGridGroupItem.GetItemAlwaysExpanded: Boolean;
begin
  Result := False;
end;

function TcxPivotGridGroupItem.GetSize: Integer;
var
  I: Integer;
begin
  Result := 0;
  if Expanded then
  begin
    for I := 0 to ItemCount - 1 do
      Inc(Result, Items[I].Size)
  end
  else
    Result := GetSingleItemSize;
end;

function TcxPivotGridGroupItem.GetSingleItemSize: Integer;
begin
  if Field <> nil then
    Result := Field.ActualWidth
  else
    Result := PivotGrid.OptionsView.GetActualWidth;
end;

function TcxPivotGridGroupItem.GetTotalsCount: Integer;
begin
  Result := 1;
  if Field <> nil then
  begin
    case Field.TotalsVisibility of
      tvNone:
        Result := 0;
      tvCustom:
        Result := Field.CustomTotals.Count;
    end;
  end;
end;

function TcxPivotGridGroupItem.GetUniqueValue: string;
begin
  Result := DisplayText;
  if Parent <> nil then
    Result := Parent.DisplayText + '.' + Result;
end;

function TcxPivotGridGroupItem.GetValue: Variant;
begin
  if not FIsValueAsssigned then
  begin
    if Field <> nil then
    begin
      if RecordIndex >= 0 then
      begin
        FInternalValue := Field.GetGroupValue(RecordIndex);
        FDisplayText := Field.GetGroupValueDisplayText(FInternalValue);
      end
      else
      begin
        if RecordIndex = cxPivotGridOthersRecordIndex then
          FDisplayText := cxGetResourceString(@scxOthers)
        else
          FDisplayText := Field.Caption;
        FInternalValue := FDisplayText;
      end;
    end
    else
      FInternalValue := Null;
    FIsValueAsssigned := True;
  end;
  Result := FInternalValue;
end;

procedure TcxPivotGridGroupItem.InitSummaryValue(
  ACrossTotal: TcxPivotGridGroupItem);
var
  ACrossCell: TcxPivotGridCrossCell;
begin
  ACrossCell := GetCellByCrossItem(ACrossTotal);
  PivotGridError(ACrossCell <> nil, scxInvalidLayout);
  FSummaryValue := ACrossCell.GetSummaryByField(
    Field.SortBySummaryInfo.Field, Field.SortBySummaryInfo.SummaryType);
end;

procedure TcxPivotGridGroupItem.PostProcessGroup(
  ACrossTotal: TcxPivotGridGroupItem);
var
  I: Integer;
begin
  ProcessSortBySummary(ACrossTotal);
  ProcessTopValues(ACrossTotal);
  for I := 0 to ItemCount - 1 do
    Items[I].PostProcessGroup(ACrossTotal);
  if not FSortingValid then
  begin
    if Parent <> nil then
      Parent.FSortingValid := False;
    SetSummaryInfoDirty(ACrossTotal);
    ProcessSortBySummary(ACrossTotal);
  end;
end;

procedure TcxPivotGridGroupItem.ProcessSortBySummary(
  ACrossTotal: TcxPivotGridGroupItem);
var
  I: Integer;
begin
  FSortingValid := True;
  if (ItemCount > 0) and Items[0].FieldSortedBySummary then
  begin
    for I := 0 to ItemCount - 1 do
      Items[I].InitSummaryValue(ACrossTotal);
    ItemList.Sort(@CompareGroupItemsBySummary);
    for I := 0 to ItemCount - 1 do
      Items[I].FIndex := I;
  end;
end;

procedure TcxPivotGridGroupItem.ProcessTopValues(
  ACrossTotal: TcxPivotGridGroupItem);
var
  I, ACount: Integer;
  AOthers: TcxPivotGridGroupItem;
begin
  AOthers := nil;
  FSortingValid := True;
  if (ItemCount > 0) and Items[0].FieldProcessTopValues then
  begin
    ACount := Items[0].Field.TopValueCount;
    if Items[0].Field.TopValueShowOthers then
    begin
       AOthers := ChildItemsClass.Create(Self, DataController,
         cxPivotGridOthersRecordIndex, Items[0].Field);
    end
    else
      FSortingValid := False;
    for I := ItemCount - 1 downto ACount do
    begin
      if AOthers <> nil then
        AOthers.RemoveChildrenFrom(Items[I])
      else
        Items[I].MarkDeleted;
      Items[I].Free;
    end;
    ItemList.Count := ACount;
    if AOthers <> nil then
    begin
      AOthers.FIndex := ItemList.Add(AOthers);
      AOthers.ReIndexChildren;
    end;
  end;
end;

procedure TcxPivotGridGroupItem.CollapseField(AField: TcxPivotGridField);
begin
  SetFieldExpanding(AField, False);
end;

procedure TcxPivotGridGroupItem.ExpandField(AField: TcxPivotGridField);
begin
  SetFieldExpanding(AField, True);
end;

function TcxPivotGridGroupItem.FieldProcessTopValues: Boolean;
begin
  Result := (Field.TopValueCount <> 0) and
    (Field.TopValueCount < Parent.ItemCount);
end;

function TcxPivotGridGroupItem.FieldSortedBySummary: Boolean;
begin
  Result := (Field <> nil) and Field.SortedBySummary;
end;

procedure TcxPivotGridGroupItem.ReIndexChildren(AFullReindex: Boolean = False);
var
  I: Integer;
begin
  for I := 0 to ItemCount - 1 do
  begin
    Items[I].FIndex := I;
    if AFullReindex then
      Items[I].ReIndexChildren(AFullReindex);
  end;
end;

procedure TcxPivotGridGroupItem.SetFieldExpanding(
  AField: TcxPivotGridField; AExpandState: Boolean);
var
  I: Integer;
begin
  PivotGrid.BeginUpdate;
  try
    PivotGrid.DataBuilder.LockExpanding;
    PivotGrid.ShowHourglassCursor;
    if (Field = AField) and ((ItemCount > 0) or HasChildren) then
    begin
      Expanded := AExpandState;
      if (Field <> nil) then
        Field.GroupExpandingChanged(Self);
    end
    else
    begin
      for I := 0 to ItemCount - 1 do
        Items[I].SetFieldExpanding(AField, AExpandState);
    end;
    PivotGrid.DataBuilder.UnLockExpanding;
  finally
    PivotGrid.EndUpdate;
    PivotGrid.HideHourglassCursor;
  end;
end;

procedure TcxPivotGridGroupItem.SetSummaryInfoDirty(
  ACrossTotal: TcxPivotGridGroupItem);
begin
end;

function TcxPivotGridGroupItem.GetDisplayText: string;
begin
  if not FIsValueAsssigned then GetValue;
  Result := FDisplayText;
end;

function TcxPivotGridGroupItem.GetDisplayValue: Variant;
begin
  if PivotGrid.IsOLAPActive then
    Result := DisplayText
  else
    Result := Value;
end;

function TcxPivotGridGroupItem.GetExpanded: Boolean;
begin
  Result := (ItemCount > 0) and (FExpanded or GetItemAlwaysExpanded);
end;

function TcxPivotGridGroupItem.GetHasChildren: Boolean;
begin
  Result := FHasChildren or (ItemCount <> 0);
end;

function TcxPivotGridGroupItem.getNextSibling: TcxPivotGridGroupItem;
begin
  if Index < (Parent.ItemCount - 1) then
    Result := Parent.Items[Index + 1]
  else
    Result := nil;
end;

function TcxPivotGridGroupItem.GetIsHierarchy: Boolean;
begin
  Result := (Field <> nil) and (Field.Group <> nil) and
    (Field.Group.VisibleCount > 1);
end;

function TcxPivotGridGroupItem.GetItem(AIndex: Integer): TcxPivotGridGroupItem;
begin
  Result := TcxPivotGridGroupItem(FItems.List^[AIndex]);
end;

function TcxPivotGridGroupItem.GetItemCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxPivotGridGroupItem.GetLevel: Integer;
var
  AParent: TcxPivotGridGroupItem;
begin
  Result := 0;
  AParent := Parent;
  while AParent <> nil do
  begin
    AParent := AParent.Parent;
    Inc(Result);
  end;
  Dec(Result);
end;

function TcxPivotGridGroupItem.GetPivotGrid: TcxCustomPivotGrid;
begin
  Result := TcxCustomPivotGrid(DataController.GetOwner);
end;

function TcxPivotGridGroupItem.getPrevSibling: TcxPivotGridGroupItem;
begin
  if Index = 0 then
    Result := nil
  else
    Result := Parent.Items[Index - 1];
end;

procedure TcxPivotGridGroupItem.SetExpanded(AValue: Boolean);
begin
  if FExpanded <> AValue then
  begin
    PivotGrid.ShowHourglassCursor;
    try
      FExpanded := AValue;
      if Field <> nil then
      begin
        Field.GroupExpandingChanged(Self);
        PivotGrid.Changes := PivotGrid.Changes + [gcLayout];
        if PivotGrid.OptionsData.CalculationBase = cbVisibleData then
          PivotGrid.Changes := PivotGrid.Changes + [gcData];
        PivotGrid.Invalidate;
      end;
    finally
      PivotGrid.HideHourglassCursor;
    end;
  end;
end;

procedure TcxPivotGridGroupItem.SetHasChildren(AValue: Boolean);
begin
  if AValue = FHasChildren then Exit;
  FHasChildren := AValue;
  FExpanded := FExpanded and not FHasChildren;
end;

{ TcxPivotGridRowItem }

constructor TcxPivotGridRowItem.Create(
  AParent: TcxPivotGridGroupItem; ADataController: TcxCustomDataController;
  ARecordIndex: Integer;  AField: TcxPivotGridField);
begin
  inherited Create(AParent, ADataController, ARecordIndex, AField);
  FCrossCells := TcxObjectList.Create;
end;

destructor TcxPivotGridRowItem.Destroy;
begin
  FreeAndNil(FCrossCells);
  inherited Destroy;
end;

procedure TcxPivotGridRowItem.DeleteChildren;
begin
  inherited DeleteChildren;
  ClearCache;
end;

function TcxPivotGridRowItem.GetCellByCrossItem(
  AItem: TcxPivotGridGroupItem): TcxPivotGridCrossCell;
var
  I: Integer;
  ACellFound: Boolean;
begin
  ACellFound := False;
  Result := FCachedCrossCell;
  if (FCachedCrossCell = nil) or (FCachedCrossCell.Column <> AItem) then
  begin
    for I := 0 to FCrossCells.Count - 1 do
    begin
      Result := TcxPivotGridCrossCell(FCrossCells[I]);
      if Result.Column = AItem then
      begin
        ACellFound := True;
        Break;
      end;
    end;
    if not ACellFound then
    begin
      Result := GetCrossCellClass.Create(Self, AItem);
      FCrossCells.Add(Result);
    end;
    FCachedCrossCell := Result;
  end;
  Result.CalculateSummaries;
end;

procedure TcxPivotGridRowItem.ClearCache;
begin
  FCachedCrossCell := nil;
  FCrossCells.Clear;
end;

function TcxPivotGridRowItem.GetIsRow: Boolean;
begin
  Result := True;
end;

function TcxPivotGridRowItem.GetItemAlwaysExpanded: Boolean;
begin
  Result := PivotGrid.ViewData.ExpandRows;
end;

function TcxPivotGridRowItem.GetSingleItemSize: Integer;
begin
  Result := PivotGrid.ViewInfo.HeaderHeight;
end;

procedure TcxPivotGridRowItem.SetSummaryInfoDirty(
  ACrossTotal: TcxPivotGridGroupItem);
var
  I: Integer;
begin
  for I := 0 to FCrossCells.Count - 1 do
    TcxPivotGridCrossCell(FCrossCells.Items[I]).Calculated := False;
end;

{ TcxPivotGridColumnItem }

function TcxPivotGridColumnItem.GetItemAlwaysExpanded: Boolean;
begin
  Result := PivotGrid.ViewData.ExpandColumns;
end;

function TcxPivotGridColumnItem.GetSingleItemSize: Integer;
begin
  Result := inherited GetSingleItemSize;
end;

procedure TcxPivotGridColumnItem.SetSummaryInfoDirty(
  ACrossTotal: TcxPivotGridGroupItem);
begin
  ACrossTotal.SetSummaryInfoDirty(Self);
end;

function TcxPivotGridColumnItem.GetCellByCrossItem(
  AItem: TcxPivotGridGroupItem): TcxPivotGridCrossCell;
begin
  Result := AItem.GetCellByCrossItem(Self);
end;

{ TcxPivotGridDataItem }

function TcxPivotGridDataItem.GetSingleItemSize: Integer;
begin
  if PivotGrid.OptionsDataField.Area = dfaRow then
    Result := PivotGrid.ViewInfo.HeaderHeight
  else
    Result := inherited GetSingleItemSize;
end;

function TcxPivotGridDataItem.GetValue: Variant;
begin
  FDisplayText := Field.Caption;
  Result := FDisplayText;
end;

{ TcxPivotGridCrossCellDataSource }

constructor TcxPivotGridCrossCellDataSource.Create(ACell: TcxPivotGridCrossCell);
begin
  PivotGrid := ACell.PivotGrid;
  Records := ACell.CreateCrossRecords;
end;

constructor TcxPivotGridCrossCellDataSource.CreateEx(ACrossCells: TList);
var
  I: Integer;
  ACrossRecords: TcxPivotGridRecords;
  ACell: TcxPivotGridCrossCell;
begin
  for I := 0 to ACrossCells.Count - 1 do
  begin
    ACell := TcxPivotGridCrossCell(ACrossCells[I]);
    if I = 0 then
      Create(ACell)
    else
    begin
      ACrossRecords := ACell.CreateCrossRecords;
      try
        Records.Assign(ACrossRecords, laOr);
      finally
        ACrossRecords.Free;
      end;
    end;
  end;
  if HasData then
    Records.MakeUnique
  else
    Records := TcxPivotGridRecords.Create;
end;

destructor TcxPivotGridCrossCellDataSource.Destroy;
begin
  FreeAndNil(Records);
  inherited Destroy;
end;

function TcxPivotGridCrossCellDataSource.HasData: Boolean;
begin
  Result := (PivotGrid <> nil) and (Records <> nil);
end;

function TcxPivotGridCrossCellDataSource.GetFieldCount: Integer;
begin
  Result := PivotGrid.FieldCount;
end;

function TcxPivotGridCrossCellDataSource.GetPivotGridField(AIndex: Integer): TcxPivotGridField;
begin
  Result := PivotGrid.Fields[AIndex];
end;

function TcxPivotGridCrossCellDataSource.GetRecordCount: Integer;
begin
  if HasData then
    Result := Records.Count
  else
    Result := 0;
end;

function TcxPivotGridCrossCellDataSource.GetValue(
  ARecordHandle: TcxDataRecordHandle; AItemHandle: TcxDataItemHandle): Variant;
var
  ARecordIndex: Integer;
  AField: TcxPivotGridField;
begin
  if HasData then
  begin
    if Provider <> nil then
      AField := PivotGridFields[TcxPivotGridDataController(
        DataController).GetItemID(DataController.GetItem(Integer(AItemHandle)))]
    else
      with TcxPivotGridDataController(PivotGrid.DataController) do
        AField := PivotGrid.Fields[GetItemID(GetItem(Integer(AItemHandle)))];
    ARecordIndex := Records[Integer(ARecordHandle)];
    if AField.GroupInterval = giDefault then
      Result := AField.Values[ARecordIndex]
    else
      Result := AField.GetGroupValue(ARecordIndex);
  end
  else
    Result := Null;
end;

{ TcxPivotGridCrossCell }

constructor TcxPivotGridCrossCell.Create(ARow, AColumn: TcxPivotGridGroupItem);
begin
  FColumn := AColumn;
  FRow := ARow;
  FSummaryCells := TcxObjectList.Create()
end;

destructor TcxPivotGridCrossCell.Destroy;
begin
  FRecords.Free;
  FSummaryCells.Free;
  inherited Destroy;
end;

procedure TcxPivotGridCrossCell.CalculateSummaries;
begin
  if Calculated then Exit;
  Calculated := True;
  FSummaryCells.Clear;
  DoCalculateSummary;
end;

function TcxPivotGridCrossCell.CreateDrillDownDataSource: TcxCustomDataSource;
begin
  if PivotGrid.IsOLAPActive then
    Result := PivotGrid.OLAPDataSource.CreateDrillDownDataSource(Self, PivotGrid.FieldList)
  else
    Result := TcxPivotGridCrossCellDataSource.Create(Self);
end;

function TcxPivotGridCrossCell.GetSummaryByField(
  AField: TcxPivotGridField; ASummaryType: TcxPivotGridSummaryType): Variant;
begin
  PivotGridError(AField.SummaryIndex <> cxPivotGridInvalidIndex,
    cxGetResourceString(@scxFieldNotADataField));
  Result := SummaryCells[AField.SummaryIndex].GetSummaryByType(ASummaryType);
end;

function TcxPivotGridCrossCell.GetSummaryValue(
  ASummary: TcxPivotGridCrossCellSummary; AType: TcxPivotGridSummaryType): Variant;
begin
  Result := ASummary.GetSummaryByType(AType);
end;

function TcxPivotGridCrossCell.AddSummaryCell(AField: TcxPivotGridField;
  ARecords: TcxPivotGridRecords): TcxPivotGridCrossCellSummary;
begin
  Result := PivotGridCrossCellSummaryClass.Create(Self, AField);
  FSummaryCells.Add(Result);
  if PivotGrid.IsOLAPActive then Exit;
  if UseRawData or AField.HasSummaryVariation then
    Result.DoCalculateSummary(ARecords);
end;

procedure TcxPivotGridCrossCell.CalculateVisibleSummary;
var
  I: Integer;
  ACells: TList;
begin
  ACells := CreateCrossCellsList;
  try
    for I := 0 to SummaryCellCount - 1 do
      with SummaryCells[I] do
      begin
        if not DataField.HasSummaryVariation then
          DoCalculateSummary(ACells, GetIntermadiateValue);
      end;
  finally
    ACells.Free;
  end;
end;

function TcxPivotGridCrossCell.CreateCrossRecords: TcxPivotGridRecords;
begin
  if Column.Parent = nil then
    Result := Row.CreateSummaryRecords
  else
    if Row.Parent = nil then
      Result := Column.CreateSummaryRecords
    else
    begin
       Result := TcxPivotGridRecords.Create;
       Result.CreateIntersection(Row.CreateSummaryRecords, Column.CreateSummaryRecords);
    end;
end;

function TcxPivotGridCrossCell.CreateCrossCellsList: TList;

  function GetSubItem(AItem: TcxPivotGridGroupItem; AIndex: Integer): TcxPivotGridGroupItem;
  begin
    Result := AItem;
    if AItem.Expanded and (AItem.ItemCount > 0) then
      Result := AItem.Items[AIndex];
  end;

  function GetItemCount(AItem: TcxPivotGridGroupItem): Integer;
  begin
    Result := 1;
    if AItem.Expanded and (AItem.ItemCount > 0) then
      Result := AItem.ItemCount;
  end;

var
  I, J: Integer;
  ARow: TcxPivotGridGroupItem;
begin
  Result := TList.Create;
  for I := 0 to GetItemCount(Row) - 1  do
  begin
    ARow := GetSubItem(Row, I);
    for J := 0 to GetItemCount(Column) - 1  do
       Result.Add(ARow.GetCellByCrossItem(GetSubItem(Column, J)));
  end;
end;

procedure TcxPivotGridCrossCell.DoCalculateSummary;
var
  I: Integer;
begin
  if PivotGrid.HasSummaryVariation then
  begin
    if PivotGrid.OptionsDataField.Area = dfaRow then
      PrevCrossCell := GetPrevCrossCellInColumn
    else
      PrevCrossCell := GetPrevCrossCellInRow;
  end;
  FRecords.Free;
  FRecords := CreateCrossRecords;
  for I := 0 to PivotGrid.SummaryFields.Count - 1 do
    AddSummaryCell(PivotGrid.SummaryFields[I], FRecords);

  if not UseRawData or PivotGrid.IsOLAPActive then
    CalculateVisibleSummary;

  for I := 0 to SummaryCellCount - 1 do
    with SummaryCells[I] do
    begin
      CalculateSummaryVariation;
      CalculateCustomSummary;
    end;
end;

function TcxPivotGridCrossCell.IsCalculationAvailable: Boolean;
begin
  Result := True;
end;

procedure TcxPivotGridCrossCell.GetDataTypes(
  ADataField: TcxPivotGridField; var ASourceType, AFloatType: Integer);
var
  AType: TcxValueTypeClass;
begin
  ASourceType := varCurrency;
  AFloatType := varCurrency;
  if ADataField <> nil then
  begin
    AType := DataController.GetItemValueTypeClass(ADataField.Index);
    if (AType <> nil) and not ADataField.IsCurrency(AType) then
    begin
      if AType.GetVarType in OrdinalTypeSet then
        ASourceType := varInteger
      else
        ASourceType := varDouble;
      AFloatType := varDouble;
    end;
  end;
end;

function TcxPivotGridCrossCell.GetIsEmpty: Boolean;
begin
  Result := Records.Count = 0;
end;

function TcxPivotGridCrossCell.GetPrevCrossCellInRow: TcxPivotGridCrossCell;
var
  APrev: TcxPivotGridGroupItem;
begin
  APrev := Column.GetPrev;
  if APrev = nil then
    Result := nil
  else
    Result := Row.GetCellByCrossItem(APrev);
end;

function TcxPivotGridCrossCell.GetPrevCrossCellInColumn: TcxPivotGridCrossCell;
var
  APrev: TcxPivotGridGroupItem;
begin
  APrev := Row.GetPrev;
  if APrev = nil then
    Result := nil
  else
    Result := APrev.GetCellByCrossItem(Column);
end;

function TcxPivotGridCrossCell.GetDataController: TcxCustomDataController;
begin
  Result := PivotGrid.DataController;
end;

function TcxPivotGridCrossCell.GetPivotGrid: TcxCustomPivotGrid;
begin
  Result := Column.PivotGrid;
end;

function TcxPivotGridCrossCell.GetSummaryCellCount: Integer;
begin
  Result := FSummaryCells.Count;
end;

function TcxPivotGridCrossCell.GetUseRawData: Boolean;
begin
  Result := not PivotGrid.IsOLAPActive and
    (PivotGrid.OptionsData.CalculationBase = cbRawData);
  if not Result then
    Result := ((Row.ItemCount + Column.ItemCount) = 0) or (not Row.Expanded and  not Column.Expanded);
end;

function TcxPivotGridCrossCell.GetSummaryCell(AIndex: Integer): TcxPivotGridCrossCellSummary;
begin
  Result := TcxPivotGridCrossCellSummary(FSummaryCells.List^[AIndex]);
end;

{ TcxPivotGridOLAPCrossCell }

function TcxPivotGridOLAPCrossCell.GetSummaryByField(
  AField: TcxPivotGridField; ASummaryType: TcxPivotGridSummaryType): Variant;
begin
  Result := Null;
  PivotGridError(AField.SummaryIndex <> cxPivotGridInvalidIndex,
    cxGetResourceString(@scxFieldNotADataField));
  if IsCalculationAvailable then
    Result := FNativeValues[AField.SummaryIndex]
end;

function TcxPivotGridOLAPCrossCell.GetSummaryValue(
  ASummary: TcxPivotGridCrossCellSummary; AType: TcxPivotGridSummaryType): Variant;
begin
  if IsCalculationAvailable then
    Result := FNativeValues[ASummary.DataField.SummaryIndex]
  else
    Result := inherited GetSummaryValue(ASummary, AType);
end;

procedure TcxPivotGridOLAPCrossCell.GetDataTypes(
  ADataField: TcxPivotGridField; var ASourceType, AFloatType: Integer);
begin
  inherited GetDataTypes(ADataField, ASourceType, AFloatType);
  if not IsCalculationAvailable then Exit;
  ASourceType := VarType(NativeValues[ADataField.SummaryIndex]);
  AFloatType := ASourceType;
  if not VarTypeIsCurrency(ASourceType) then
  begin
    if ASourceType in OrdinalTypeSet then
      ASourceType := varInteger;
    AFloatType := varDouble;
  end;
end;

function TcxPivotGridOLAPCrossCell.GetIsEmpty: Boolean;
begin
  Result := FIsEmpty;
end;

function TcxPivotGridOLAPCrossCell.IsCalculationAvailable: Boolean;
begin
  Result := VarIsArray(FNativeValues);
end;

{ TcxPivotGridCrossCellSummary }

constructor TcxPivotGridCrossCellSummary.Create(
  AOwner: TcxPivotGridCrossCell; ADataField: TcxPivotGridField);
begin
  FOwner := AOwner;
  FDataField := ADataField;
end;

procedure TcxPivotGridCrossCellSummary.Clear;
var
  I: TcxPivotGridSummaryType;
begin
  for I := Low(TcxPivotGridSummaryType) to High(TcxPivotGridSummaryType) do
    FSummaries[I] := Null;
  FSummaryVariation := Null;
end;

function TcxPivotGridCrossCellSummary.GetSummaryByType(
  AType: TcxPivotGridSummaryType): Variant;
begin
  Result := FSummaries[AType];
end;

function TcxPivotGridCrossCellSummary.GetSummaryValue(
  AType: TcxPivotGridSummaryType): Variant;
begin
  Result := Owner.GetSummaryValue(Self, AType);
end;

function TcxPivotGridCrossCellSummary.GetValue(ARecordIndex: Integer): Variant;
begin
  Result := DataField.Values[ARecordIndex];
end;

procedure TcxPivotGridCrossCellSummary.CalculateCustomSummary;
begin
  DataField.DoCalculateCustomSummary(Self);
end;

procedure TcxPivotGridCrossCellSummary.CalculateSummaryVariation;

  procedure CalculateVariation;
  var
    APrevCell: TcxPivotGridCrossCellSummary;
    APrevValue, APrevValueEx, AValue: Variant;
  begin
    if Owner.PrevCrossCell <> nil then
      APrevCell := Owner.PrevCrossCell.SummaryCells[DataField.SummaryIndex]
    else
      APrevCell := nil;

    if APrevCell <> nil then
    begin
      // skip null values
      repeat
        APrevValue := APrevCell.GetSummaryByType(DataField.SummaryType);
        APrevValueEx := APrevValue;
        if not VariationNullIgnore or VarIsNumericEx(APrevValue) then
        begin
          if not VarIsNumericEx(APrevValue) then
            APrevValue := 0;
          Break;
        end
        else
          APrevCell := GetPrevCell(APrevCell);
      until APrevCell = nil;
      if APrevCell = nil then
        APrevValueEx := Null;
      AValue := GetSummaryByType(DataField.SummaryType);
      if VarIsNull(AValue) and VarIsNull(APrevValueEx) then
        Exit;
      if not VarIsNumericEx(AValue) and not VariationNullIgnore then
        AValue := 0;
      try
        case DataField.SummaryVariation of
          svAbsolute:
            FSummaryVariation := AValue - APrevValue;
          svPercent:
            begin
              if VarIsNull(APrevValue) or (VarIsNumericEx(APrevValue) and (APrevValue = 0)) then
                FSummaryVariation := Null
              else
              begin
                FSummaryVariation := (AValue - APrevValue) * 100 / Abs(APrevValue);
                if not VarIsNull(FSummaryVariation) then
                  VarCast(FSummaryVariation, FSummaryVariation, varDouble);
              end;
            end;
        end;
      except
        on EMathError do FSummaryVariation := Null;
        on EDivByZero do FSummaryVariation := Null;
        on EVariantError do FSummaryVariation := Null;
      else
        raise;
      end;
    end;
  end;

  procedure CalculateRelation;
  var
    AValue, AOwnerValue: Variant;
  begin
    AValue := GetSummaryByType(DataField.SummaryType);
    try
      case DataField.SummaryVariation of
        svPercentOfColumn:
          if Owner.Row.Parent <> nil then
            AOwnerValue := Owner.Row.Parent.GetCellByCrossItem(Owner.Column).GetSummaryByField(DataField, DataField.SummaryType)
          else
            AOwnerValue := AValue;
        svPercentOfRow:
          if Owner.Column.Parent <> nil then
            AOwnerValue := Owner.Column.Parent.GetCellByCrossItem(Owner.Row).GetSummaryByField(DataField, DataField.SummaryType)
          else
            AOwnerValue := AValue;
      end;
      FSummaryVariation := AValue / AOwnerValue *  100;
    except
      on EMathError do FSummaryVariation := Null;
      on EDivByZero do FSummaryVariation := Null;
      on EVariantError do FSummaryVariation := Null;
    else
      raise;
    end;
  end;

begin
  if not DataField.HasSummaryVariation then Exit;

  if DataField.SummaryVariation in [svAbsolute, svPercent] then
    CalculateVariation
  else
    CalculateRelation;
end;

procedure TcxPivotGridCrossCellSummary.CheckValue(var AValue: Variant);
{$IFDEF DELPHI6}
  {$IFNDEF NONDB}
var
  ACurr: Currency;
  {$ENDIF}
{$ENDIF}
begin
{$IFDEF DELPHI6}
  {$IFNDEF NONDB}
    if TVarData(AValue).VType = VarSQLTimeStamp then
      AValue := TDateTime(AValue)
    else
      if TVarData(AValue).VType = VarFMTBcd then
      begin
        if BcdToCurr(VarToBcd(AValue), ACurr) then
          AValue := Currency(ACurr)
        else
          AValue := Double(BcdToDouble(VarToBcd(AValue)));
      end;
  {$ENDIF}
{$ENDIF}
end;

procedure TcxPivotGridCrossCellSummary.DoCalculateSummary(
  ARecords: TList; AGetValueProc: TcxPivotGridGetRecordValueProc = nil);
var
  ACount, ANotNumericCount, ASourceType, AFloatType: Integer;
  AMinV, AMaxV, ASourceValue: Variant;
  AMin, AMax, ASum, ASumSquares, AValue: Extended;
  AVarianceP, ATotalVariance, AVariance: Extended;

  procedure InitializeValues;
  begin
    ASum := 0;
    ACount := 0;
    ANotNumericCount := 0;
    AMinV := Null;
    AMaxV := Null;
    AMax := MinExtended;
    AMin := MaxExtended;
    ASumSquares := 0;
    Owner.GetDataTypes(DataField, ASourceType, AFloatType);
  end;

  procedure BaseCalculation;
  var
    I: Integer;
  begin
    for I := 0 to ARecords.Count - 1 do
    begin
      if DataField.GroupInterval <> giDefault then
      begin
        ASourceValue := AGetValueProc(ARecords[I], True);
        if ACount = 0 then
        begin
          AMinV := ASourceValue;
          AMaxV := ASourceValue;
        end
        else
        begin
          if VarCompare(AMinV, ASourceValue) > 0 then
            AMinV := ASourceValue;
          if VarCompare(AMaxV, ASourceValue) < 0 then
            AMaxV := ASourceValue;
        end;
        if not VarIsNumericEx(ASourceValue) then
          ASourceValue := 0;
      end
      else
      begin
        ASourceValue := AGetValueProc(ARecords[I], False);
        if not VarIsNumericEx(ASourceValue) then
        begin
          Inc(ANotNumericCount);
          if not SummaryNullIgnore or not VarIsNull(ASourceValue) then
            Inc(ACount);
          Continue;
        end;
      end;
      CheckValue(ASourceValue);
      AValue := ASourceValue;
      Inc(ACount);
      AMax := Math.Max(AValue, AMax);
      AMin := Math.Min(AValue, AMin);
      ASum := ASum + AValue;
      ASumSquares := ASumSquares + Sqr(AValue);
    end;
  end;

  procedure PostCalculation;
  begin
    ATotalVariance := ASumSquares - Sqr(ASum)/ACount;
    AVarianceP := ATotalVariance / ACount;
  end;

  procedure AssignCalculatedValues;
  begin
    SetSummaryByType(stCount, ACount, varInteger);
    if ANotNumericCount = ARecords.Count then Exit;
    SetSummaryByType(stSum, ASum, ASourceType);

    if DataField.GroupInterval = giDefault then
    begin
      SetSummaryByType(stMax, AMax, ASourceType);
      SetSummaryByType(stMin, AMin, ASourceType);
    end
    else
    begin
      FSummaries[stMax] := AMaxV;
      FSummaries[stMin] := AMinV;
    end;
    SetSummaryByType(stAverage, ASum / ACount, AFloatType);
    SetSummaryByType(stVarianceP, AVarianceP, AFloatType);
    SetSummaryByType(stStdDevP, Sqrt(Math.Max(0, AVarianceP)), AFloatType);
    if Count > 1 then
    begin
      AVariance := ATotalVariance / (ACount - 1);
      SetSummaryByType(stVariance, AVariance, AFloatType);
      SetSummaryByType(stStdDev, Sqrt(Math.Max(0, AVariance)), AFloatType);
    end;
  end;

begin
  if not Assigned(AGetValueProc) then
    AGetValueProc := GetRecordValue;
  Clear;
  if not Owner.IsCalculationAvailable then Exit;
  InitializeValues;
  BaseCalculation;
  if ACount <> 0 then
  begin
    PostCalculation;
    AssignCalculatedValues;
  end;
end;

function TcxPivotGridCrossCellSummary.GetIntermadiateValue(
  const ACell: Pointer; AIsGroupValue: Boolean): Variant;
begin
  Result := TcxPivotGridCrossCell(ACell).GetSummaryByField(
    FDataField, FDataField.SummaryType);
end;

function TcxPivotGridCrossCellSummary.GetRecordValue(
  const ARecord: Pointer; AIsGroupValue: Boolean): Variant;
begin
  if AIsGroupValue then
    Result := DataField.GetGroupValue(Integer(ARecord))
  else
    Result := GetValue(Integer(ARecord));
end;

function TcxPivotGridCrossCellSummary.GetPrevCell(
  APrevCell: TcxPivotGridCrossCellSummary): TcxPivotGridCrossCellSummary;
begin
  if (APrevCell = nil) or (APrevCell.Owner.PrevCrossCell = nil) then
    Result := nil
  else
    Result := APrevCell.Owner.PrevCrossCell.SummaryCells[DataField.SummaryIndex];
end;

procedure TcxPivotGridCrossCellSummary.SetSummaryByIndex(
  AIndex: Integer; AValue: Variant);
begin
  FSummaries[TcxPivotGridSummaryType(AIndex)] := AValue;
end;

procedure TcxPivotGridCrossCellSummary.SetSummaryByType(
  AType: TcxPivotGridSummaryType; const AValue: Extended; AVarType: Integer);
begin
  // todo: need check floating point overflow then conversion Extended to Currency
  if not VarIsNull(AValue) then
  try
    if (AVarType = varInteger) and (AValue > MaxInt) then
      FSummaries[AType] := AValue
    else
      VarCast(FSummaries[AType], AValue, AVarType)
  except
    on EVariantError do
      if AVarType = varDouble then
        VarCast(FSummaries[AType], AValue, varCurrency);
  end
  else
    FSummaries[AType] := AValue;
end;

function TcxPivotGridCrossCellSummary.GetDataController: TcxCustomDataController;
begin
  Result := Owner.DataController;
end;

function TcxPivotGridCrossCellSummary.GetSummaryByIndex(
  AIndex: Integer): Variant;
begin
  Result := GetSummaryByType(TcxPivotGridSummaryType(AIndex));
end;

function TcxPivotGridCrossCellSummary.GetSummaryNullIgnore: Boolean;
begin
  Result := Owner.PivotGrid.OptionsData.SummaryNullIgnore;
end;

function TcxPivotGridCrossCellSummary.GetRecords: TcxPivotGridRecords;
begin
  Result := Owner.Records;
end;

function TcxPivotGridCrossCellSummary.GetVariationNullIgnore: Boolean;
begin
  Result := Owner.PivotGrid.OptionsData.VariationNullIgnore;
end;

{ TcxPivotGridDataBuilder }

constructor TcxPivotGridDataBuilder.Create(AOwner: TcxCustomPivotGrid);
begin
  FPivotGrid := AOwner;
  FFields := TcxPivotGridFields.Create;
  FFilteredFields := TcxPivotGridFields.Create;
  FDataController := FPivotGrid.DataController;
  FRowFields := TcxPivotGridFields.Create;
  FColumnFields := TcxPivotGridFields.Create;
  FFilterFields := TcxPivotGridFields.Create;
  FDataFields := TcxPivotGridFields.Create;
  FData := TcxPivotGridGroupItem.Create(nil, DataController, -1, nil);
  FColumns := TcxPivotGridColumnItem.Create(nil, DataController, -1, nil);
  FRows := TcxPivotGridRowItem.Create(nil, DataController, -1, nil);
  FFilteredIndexes := TcxPivotGridRecords.Create;
end;

destructor TcxPivotGridDataBuilder.Destroy;
begin
  FreeAndNil(FFilteredFields);
  FreeAndNil(FFields);
  FreeAndNil(FData);
  FreeAndNil(FFilterFields);
  FreeAndNil(FDataFields);
  FreeAndNil(FColumns);
  FreeAndNil(FColumnFields);
  FreeAndNil(FRows);
  FreeAndNil(FRowFields);
  FreeAndNil(FFilteredIndexes);
  inherited Destroy;
end;

function TcxPivotGridDataBuilder.CanGroup: Boolean;
begin
  Result := ((PivotGrid.RecordCount > 0) or (OLAPDataSource <> nil))
     and (DataFields.Count > 0);
end;

procedure TcxPivotGridDataBuilder.DataChanged;
begin
  PivotGrid.ShowHourglassCursor;
  try
    Clear;
    FOLAPDataSource := PivotGrid.OLAPDataSource;
    PivotGrid.RefreshDate := Date;
    PopulateRecordsList;
    SplitFieldsByGroups;
    ApplyFilter;
    if (FOLAPDataSource <> nil) and FOLAPDataSource.IsActive then
    begin
      if not FOLAPDataSource.IsTerminated then
      begin
        FOLAPDataSource.InitializeLayout(RowFields, ColumnFields, SummaryFields, FilteredFields);
        FOLAPDataSource.CreateRootLayout(PivotGrid);

        if GetCountInArea(FilteredFields, faFilter) > 0 then
          CorrectTotals;
      end;
    end
    else
    begin
      GroupByRows;
      GroupByColumns;
    end;
    CreateDataCells;
    AfterDataChanged;
  finally
    PivotGrid.HideHourglassCursor;
  end;
end;

procedure TcxPivotGridDataBuilder.AddSummaryField(
  AField: TcxPivotGridField);
begin
  if PivotGrid.IsOLAPActive and (AField.Link = nil) then Exit;
  AField.FSummaryIndex := PivotGrid.SummaryFields.IndexOf(AField);
  if AField.SummaryIndex = cxPivotGridInvalidIndex then
    AField.FSummaryIndex := PivotGrid.SummaryFields.Add(AField);
  with PivotGrid do
    HasSummaryVariation := HasSummaryVariation or AField.HasSummaryVariation;
end;

procedure TcxPivotGridDataBuilder.AfterDataChanged;

  procedure PostProcessGroups(AFields: TcxPivotGridFields;
      ARoot, ACrossTotal: TcxPivotGridGroupItem);
  var
    ProcessFieldsCount, I: Integer;
  begin
    ARoot.ReIndexChildren(True);
    ProcessFieldsCount := 0;
    for I := 0 to AFields.Count - 1 do
      if AFields[I].SortedBySummary or (AFields[I].TopValueCount > 0) then
        Inc(ProcessFieldsCount);
    if ProcessFieldsCount = 0 then Exit;
    ARoot.PostProcessGroup(ACrossTotal);
  end;

begin
  PostProcessGroups(RowFields, Rows, Columns);
  PostProcessGroups(ColumnFields, Columns, Rows);
end;

procedure TcxPivotGridDataBuilder.ApplyFilter;
var
  ARecordIndex, I, AFilteredFieldCount: Integer;
  AFilteredList: TcxPivotGridFields;
begin
  AFilteredList := TcxPivotGridFields.Create;
  try
    AFilteredList.Assign(Fields);
    for I := AFilteredList.Count - 1 downto 0 do
    begin
      if not AFilteredList[I].Filter.HasFilter then
        AFilteredList.Delete(I);
    end;
    if AFilteredList.Count > 0 then
      for ARecordIndex := 0 to PivotGrid.RecordCount - 1 do
      begin
        AFilteredFieldCount := 0;
        for I := 0 to AFilteredList.Count - 1 do
          if not AFilteredList[I].IsRecordVisible(ARecordIndex) then
            Inc(AFilteredFieldCount);
        if AFilteredFieldCount > 0 then
          FilteredIndexes[ARecordIndex] := -AFilteredFieldCount;
      end;
  finally
    AFilteredList.Free;
  end;
end;

function TcxPivotGridDataBuilder.CanGroupByColumns: Boolean;
begin
  Result := CanGroup and (ColumnFields.Count > 0);
end;

function TcxPivotGridDataBuilder.CanGroupByRows: Boolean;
begin
  Result := CanGroup and (RowFields.Count > 0);
end;

procedure TcxPivotGridDataBuilder.Clear;
begin
  Fields.Clear;
  FilteredFields.Clear;
  FilteredIndexes.Clear;
  Columns.DeleteChildren;
  Rows.DeleteChildren;
  ColumnFields.Clear;
  RowFields.Clear;
  FilterFields.Clear;
  Data.DeleteChildren;
  DataFields.Clear;
  SummaryFields.Clear;
end;

procedure TcxPivotGridDataBuilder.CorrectTotals;
begin
  if (Columns.ItemCount > 0) and (Rows.ItemCount > 0) then
  begin
    FOLAPDataSource.InitializeTotals(ColumnFields, SummaryFields, FilteredFields);
    FOLAPDataSource.ReplaceTotals(Self, Columns, SummaryFields);

    FOLAPDataSource.InitializeTotals(RowFields, SummaryFields, FilteredFields);
    FOLAPDataSource.ReplaceTotals(Self, Rows, SummaryFields);
  end;

  FOLAPDataSource.InitializeTotals(nil, SummaryFields, FilteredFields);
  FOLAPDataSource.ReplaceTotals(Self, nil, SummaryFields);
end;

procedure TcxPivotGridDataBuilder.CreateDataCells;
var
  I: Integer;
begin
  for I := 0 to DataFields.Count - 1 do
    FData.ItemList.Add(TcxPivotGridDataItem.Create(FData, DataController, -1, DataFields[I]));
end;

procedure TcxPivotGridDataBuilder.GroupBy(AFields: TcxPivotGridFields;
  ARoot: TcxPivotGridGroupItem);
var
  AValue: Variant;
  AParent: TcxPivotGridGroupItem;
  I, J, AIndex, AFieldIndex: Integer;
begin
  for I := 0 to PivotGrid.RecordCount - 1 do
  begin
    AIndex := 0;
    AParent := TcxPivotGridGroupItem(ARoot);
    AFieldIndex := 0;
    if FilteredIndexes[I] <= -1 then Continue;
    while AFieldIndex < AFields.Count do
    begin
      AValue := AFields[AFieldIndex].GetGroupValue(I);
      if FindItem(AParent.FItems, AValue, AIndex, AFields[AFieldIndex].SortOrder) then
      begin
        AParent := TcxPivotGridGroupItem(AParent.ItemList.List^[AIndex]);
        Inc(AFieldIndex);
        AIndex := 0;
        Continue;
      end
      else
        Break;
    end;
    for J := AFieldIndex to AFields.Count - 1 do
    begin
      AParent := AParent.AddChild(AIndex, I, AFields[J]);
      AFields[J].GroupCheckExpanding(AParent);
      AIndex := 0;
    end;
    AParent.Records.Add(I);
  end;
end;

procedure TcxPivotGridDataBuilder.GroupByColumns;
begin
  if CanGroupByColumns then
    GroupBy(ColumnFields, Columns);
end;

procedure TcxPivotGridDataBuilder.GroupByRows;
begin
  if CanGroupByRows then
    GroupBy(RowFields, Rows);
end;

procedure TcxPivotGridDataBuilder.GroupExpandingChanged(
  AItem: TcxPivotGridGroupItem);
begin
  if FExpandingLockCount > 0 then
    FExpandingItems.Add(AItem); //todo: need for cumulative expanding
  OLAPDataSource.ExpandMember(AItem.Field, AItem, False);
end;

procedure TcxPivotGridDataBuilder.LockExpanding;
begin
  if FExpandingLockCount = 0 then
    FExpandingItems := TList.Create;
  Inc(FExpandingLockCount);
end;

procedure TcxPivotGridDataBuilder.PopulateRecordsList;
var
  I: Integer;
begin
  FilteredIndexes.Count := PivotGrid.RecordCount;
  for I := 0 to PivotGrid.RecordCount - 1 do
    FilteredIndexes.List^[I] := Pointer(I);
end;

procedure TcxPivotGridDataBuilder.SplitFieldsByGroups;
var
  I, AIndex: Integer;
  AField: TcxPivotGridField;
  AFields: TcxPivotGridFields;
  AFieldCount: array[TcxPivotGridFieldArea] of Integer;
begin
  Fields.Assign(PivotGrid.FieldList);
  Fields.ArrangeFields;
  FillChar(AFieldCount, SizeOf(AFieldCount), 0);
  for I := 0 to Fields.Count - 1 do
  begin
    AField := Fields[I];
    if PivotGrid.IsOLAPActive and (AField.Link = nil) then Continue;
    if AField.Filter.HasFilter or PivotGrid.IsOLAPActive and TcxPivotGridOLAPField.IsFiltered(AField) then
      FFilteredFields.Add(AField);
    AFields := ColumnFields;
    case AField.Area of
      faRow:
        AFields := RowFields;
      faFilter:
        AFields := FilterFields;
      faData:
        AFields := DataFields;
    end;
    // for optimization summary calculation
    AField.FSummaryIndex := -1;
    if AField.Area = faData then
      AddSummaryField(AField);
    if AField.SortBySummaryInfo.Field <> nil then
      AddSummaryField(AField.SortBySummaryInfo.Field);
    AField.FAreaIndex := AFieldCount[AField.Area];
    Inc(AFieldCount[AField.Area]);
    if AField.VisibleInGroup and (AField.FVisibleIndex <> AFields.Add(AField)) then
    begin
      AField.FVisibleIndex := AFields.Count - 1;
      AField.ExpandingInfo.Clear;
    end;
  end;
  // todo: move data field bug fix
  AIndex := PivotGrid.OptionsDataField.AreaIndex;
  if PivotGrid.ViewInfo.IsDataFieldVisible([dfaRow, dfaColumn]) and (AIndex >= 0) then
  begin
    for I := 0 to Fields.Count - 1 do
    begin
      if (Fields[I].Area = DataAreaToFieldArea[PivotGrid.OptionsDataField.Area]) and
        (Fields[I].AreaIndex >= AIndex) then Inc(Fields[I].FAreaIndex);
    end;
  end;
end;

procedure TcxPivotGridDataBuilder.UnlockExpanding;
{var
  AItem: TcxPivotGridGroupItem;}
begin
  Dec(FExpandingLockCount);
  if (FExpandingLockCount = 0) then
  try
    if (FExpandingItems.Count > 0) then ;
   // todo: cumulative expanding optimization
 {
    AItem := TcxPivotGridGroupItem(FExpandingItems[0]);
    if AItem.Area = faRow then
    begin
      AFields := ADataBuilder.RowFields;
      ACrossGroup := ADataBuilder.Columns;
    end;
    if AField.VisibleIndex + 1 < AFields.Count then
      AField := AFields[AField.VisibleIndex + 1];
    AMembersList := CreateMembersFromGroup(ACrossGroup, False);
    if AItem.Field.Area = faRow then
      OLAPDataSource.InitializeMemberExpanding(Self, AItem.Field, AMembersList, AList);
    OLAPDataSource.InitializeCrossCells(ACrossGroup, AMember, ADataBuilder.SummaryFields);}
  finally
    FExpandingItems.Free;
  end;
end;

function TcxPivotGridDataBuilder.GetCrossCell(
  ARow, AColumn: TcxPivotGridGroupItem): TcxPivotGridCrossCell;
begin
  Result := ARow.GetCellByCrossItem(AColumn);
end;

function TcxPivotGridDataBuilder.GetSummaryFields: TcxPivotGridFields;
begin
  Result := PivotGrid.SummaryFields;
end;

{ TcxPivotGridDataController }

function TcxPivotGridDataController.GetFilterItemFieldCaption(AItem: TObject): string;
begin
  if AItem is TcxPivotGridField then
    Result := TcxPivotGridField(AItem).Caption
  else
    Result := inherited GetFilterItemFieldCaption(AItem);
end;

function TcxPivotGridDataController.GetItem(Index: Integer): TObject;
begin
  Result := PivotGrid.GetItem(Index);
end;

function TcxPivotGridDataController.GetItemID(AItem: TObject): Integer;
begin
  Result := PivotGrid.GetItemID(AItem);
end;

function TcxPivotGridDataController.GetItemValueSource(
  AItemIndex: Integer): TcxDataEditValueSource;
begin
  Result := PivotGrid.GetItemValueSource(AItemIndex);
end;

procedure TcxPivotGridDataController.UpdateData;
begin
  PivotGrid.UpdateData;
end;

procedure TcxPivotGridDataController.UpdateItemIndexes;
begin
  PivotGrid.UpdateItemIndexes;
  inherited UpdateItemIndexes;
end;

procedure TcxPivotGridDataController.FilterChanged;
begin
  inherited;
  PivotGrid.DoPrefilterChanged;
end;

procedure TcxPivotGridDataController.UpdateControl(AInfo: TcxUpdateControlInfo);
begin
  PivotGrid.UpdateControl(AInfo);
end;

function TcxPivotGridDataController.GetPivotGrid: TcxCustomPivotGrid;
begin
  Result := TcxCustomPivotGrid(GetOwner);
end;

{ TcxPivotGridOLAPField }

destructor TcxPivotGridOLAPField.Destroy;
begin
  Dimension := nil;
  Hierarchy := nil;
  inherited Destroy;
end;

class function TcxPivotGridOLAPField.FilteredValueCount(AField: TcxPivotGridField;
  IsExpanding: Boolean = False): Integer;

  function GetFilterValuesCount(AField: TcxPivotGridField): Integer;
  begin
    Result := AField.Filter.Values.Count;
  end;

var
  I: Integer;
begin
  Result := 0;
  if not IsFilteredOLAP(AField) then
    Exit;
  if not IsExpanding or not AField.IsHierarchy then
  begin
    if AField.IsHierarchy then
      for I := AField.Group.FieldCount - 1 downto AField.Group.IndexOf(AField) + 1 do
        Result := Result + GetFilterValuesCount(AField.Group.Fields[I]);
    Result := Result + GetFilterValuesCount(AField);
  end
  else
    if AField.IsHierarchy then
      for I := 0 to AField.Group.IndexOf(AField) do
        Result := Result + GetFilterValuesCount(AField.Group.Fields[I]);
end;

class function TcxPivotGridOLAPField.IsFiltered(AField: TcxPivotGridField): Boolean;
var
  I: Integer;
begin
  Result := AField.Filter.HasFilter;
  if not Result and AField.IsHierarchy then
  begin
    for I := AField.Group.IndexOf(AField) + 1 to AField.Group.FieldCount - 1 do
    begin
      Result := AField.Group.Fields[I].Filter.HasFilter;
      if Result then Break;
    end;
  end;
end;

class function TcxPivotGridOLAPField.PopulateFilteredValues(
  AField: TcxPivotGridField; IsExpanding: Boolean = False): TInterfaceList;
var
  I: Integer;
  AChildField: TcxPivotGridField;
  AUniqueValues: TStringList;
begin
  Result := TInterfaceList.Create;
  if not IsFilteredOLAP(AField) then
    Exit;
  AUniqueValues := nil;
  try
    if not IsExpanding or not AField.IsHierarchy then
    begin
      if AField.IsHierarchy then
      begin
        for I := AField.Group.FieldCount - 1 downto AField.Group.IndexOf(AField) + 1 do
        begin
          AChildField := AField.Group.Fields[I];
          AField.PivotGrid.OLAPDataSource.PopulateFilteredUniqueNames(
            AChildField.Link, AChildField.Filter, AUniqueValues);
        end;
      end;
      AField.PivotGrid.OLAPDataSource.PopulateFilteredValues(
        AField.Link, AField.Filter, Result, AUniqueValues);
    end
    else
      if AField.IsHierarchy then
        for I := 0 to AField.Group.IndexOf(AField) do
        begin
          AChildField := AField.Group.Fields[I];
          if AChildField.Filter.HasFilter then
            AField.PivotGrid.OLAPDataSource.PopulateFilteredValues(
              AChildField.Link, AChildField.Filter, Result, nil);
        end;
  finally
    FreeAndNil(AUniqueValues);
  end;
end;

class function TcxPivotGridOLAPField.IsFilteredOLAP(AField: TcxPivotGridField): Boolean;
begin
  Result := (AField <> nil) and IsFiltered(AField) and AField.PivotGrid.IsOLAPActive;
end;

{ TcxPivotGridCustomOLAPDataSource }

constructor TcxPivotGridCustomOLAPDataSource.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFields := TcxObjectList.Create;
  FMeasures := TcxObjectList.Create;
  FListeners := TList.Create;
end;

destructor TcxPivotGridCustomOLAPDataSource.Destroy;
begin
  FreeAndNil(FListeners);
  FreeAndNil(FFields);
  FreeAndNil(FMeasures);
  inherited Destroy;
end;

procedure TcxPivotGridCustomOLAPDataSource.RetrieveFields(
  APivotGrid: TcxCustomPivotGrid);
begin
  APivotGrid.BeginUpdate;
  try
    CreateFieldsFromFieldsList(APivotGrid, FFields);
    CreateFieldsFromFieldsList(APivotGrid, FMeasures);
    APivotGrid.DataSourceChanged;
  finally
    APivotGrid.EndUpdate;
  end;
end;

procedure TcxPivotGridCustomOLAPDataSource.AddListener(
  AListener: TcxCustomPivotGrid);
begin
  if FListeners.IndexOf(AListener) = -1 then
    FListeners.Add(AListener);
end;

procedure TcxPivotGridCustomOLAPDataSource.Changed;
var
  I: Integer;
begin
  Clear;
  if Active then Initialize;
  for I := 0 to ListenerCount - 1 do
    Listeners[I].DataSourceChanged;
end;

procedure TcxPivotGridCustomOLAPDataSource.Clear;
begin
  FFields.Clear;
  FMeasures.Clear;
end;

function TcxPivotGridCustomOLAPDataSource.CreateDrillDownDataSource(
  ACell: TcxPivotGridCrossCell; FieldList: TcxObjectList): TcxPivotGridCrossCellDataSource;
var
  AList: TList;
begin
  AList := TList.Create;
  try
    AList.Add(ACell);
    Result := CreateDrillDownDataSource(AList, FieldList);
  finally
    AList.Free;
  end;
end;

function TcxPivotGridCustomOLAPDataSource.CreateDrillDownDataSource(
  ACells: TList; FieldList: TcxObjectList): TcxPivotGridCrossCellDataSource;
begin
  Result := nil;
end;

function TcxPivotGridCustomOLAPDataSource.CreateField(
  APivotGrid: TcxCustomPivotGrid; AOLAPField: TcxPivotGridOLAPField): TcxPivotGridField;

  function GetUniqueFieldName(S: string; AIndex: Integer = 0): string;
  var
    I: Integer;
    AName: string;
  begin
    Result := '';
    AName := S;
    if AIndex <> 0 then
      AName := AName + IntToStr(AIndex);
    for I := 0 to APivotGrid.FieldCount - 1 do
      if APivotGrid.Fields[I].Name = AName then //when owner of PivotGrid is Frame
      begin
        Inc(AIndex);
        Result := GetUniqueFieldName(S, AIndex);
        Break;
      end;
    if Result = '' then
      Result := AName;
  end;

begin
  Result := APivotGrid.CreateField;
  if GetParentForm(APivotGrid) <> nil then
    Result.Name := GetUniqueFieldName(CreateUniqueName(GetParentForm(APivotGrid),
      APivotGrid, Result, 'TcxPivotGrid', AOLAPField.Caption));
  Result.FLink := AOLAPField;
  Result.FUniqueName := AOLAPField.UniqueName;
  Result.Caption := AOLAPField.Caption;
  Result.FAllowedAreas := DimensionAllowedAreas[AOlapField.IsMeasure];
  Result.Visible := False;
  if AOlapField.IsMeasure then
  begin
    Result.Area := faData;
    Result.Options.Filtering := False;
  end;
end;

procedure TcxPivotGridCustomOLAPDataSource.CreateFieldsFromFieldsList(
  APivotGrid: TcxCustomPivotGrid; AOLAPFields: TcxObjectList);
var
  I: Integer;
  AField: TcxPivotGridField;
  AGroup: TcxPivotGridFieldGroup;
  AOLAPField: TcxPivotGridOLAPField;
begin
  AGroup := nil;
  for I := 0 to AOLAPFields.Count - 1 do
  begin
    AOLAPField := TcxPivotGridOLAPField(AOLAPFields[I]);
    AField := CreateField(APivotGrid, AOLAPField);
    if AOLAPField.GroupIndex >= 0 then
    begin
      if AOLAPField.GroupIndex = 0 then
      begin
        AGroup := APivotGrid.Groups.Add;
        AGroup.Caption := '';
      end;
      AGroup.Add(AField);
      AField.GroupExpanded := False;
    end;
    DoInitializeField(AField);
  end;
end;

procedure TcxPivotGridCustomOLAPDataSource.CreateMembers(
  AField: TcxPivotGridField; AParents: TList; AHasChildren: Boolean);
begin
end;

function TcxPivotGridCustomOLAPDataSource.CreateMembersFromGroup(
  AItem: TcxPivotGridGroupItem; AIncludeParent: Boolean = True; ACheckExpanding: Boolean = False): TList;

  procedure ProcessItems(AItem: TcxPivotGridGroupItem; AIncludeSelf: Boolean);
  var
    I: Integer;
  begin
    AItem.CheckExpanding;
    AItem.MemberIndex := -1;
    if AIncludeSelf then
      Result.Add(AItem)
    else
      if ACheckExpanding and AItem.FExpanded and (AItem.ItemCount = 0) and (AItem.Parent <> nil) then
        Result.Add(AItem);
    if not AItem.Expanded then Exit;
    for I := 0 to AItem.ItemCount - 1 do
      ProcessItems(AItem.Items[I], not ACheckExpanding);
  end;

begin
  Result := TList.Create;
  Result.Capacity := 1024;
  ProcessItems(AItem, AIncludeParent);
end;

procedure TcxPivotGridCustomOLAPDataSource.CreateRootLayout(
  APivotGrid: TcxCustomPivotGrid);
var
  AList: TList;
  ADataBuilder: TcxPivotGridDataBuilder;
begin
  if csDesigning in ComponentState then Exit;
  ADataBuilder := APivotGrid.DataBuilder;
  AList := TList.Create;
  try
    AList.Add(ADataBuilder.FRows);
    CreateMembers(ADataBuilder.RowFields.GetFirstField,
      AList, ADataBuilder.RowFields.Count > 1);
    AList[0] := ADataBuilder.FColumns;
    CreateMembers(ADataBuilder.ColumnFields.GetFirstField,
      AList, ADataBuilder.ColumnFields.Count > 1);
  finally
    AList.Free;
  end;
  with ADataBuilder do
  begin
    InitializeCrossCells(Rows, Columns, SummaryFields);
    ProcessMembersForExpanding(ColumnFields.GetFirstField, Columns, True);
    ProcessMembersForExpanding(RowFields.GetFirstField, Rows, True);
  end;
end;

procedure TcxPivotGridCustomOLAPDataSource.DoInitializeField(
  AField: TcxPivotGridField);
begin
  if Assigned(FOnInitializeField) then
    FOnInitializeField(Self, AField);
end;

procedure TcxPivotGridCustomOLAPDataSource.ExpandMember(
  AField: TcxPivotGridField; AMember: TcxPivotGridGroupItem; AExpandChildren: Boolean);
var
  AFields: TcxPivotGridFields;
  AList, AMembersList: TList;
  ADataBuilder: TcxPivotGridDataBuilder;
  ACrossGroup: TcxPivotGridGroupItem;
begin
  if (AField = nil) or (AExpandChildren and (AField.ExpandingInfo.Count = 0)) then Exit;
  ADataBuilder := AField.DataBuilder;
  AMembersList := nil;
  AFields := ADataBuilder.ColumnFields;
  ACrossGroup := ADataBuilder.Rows;
  if AField.Area = faRow then
  begin
    AFields := ADataBuilder.RowFields;
    ACrossGroup := ADataBuilder.Columns;
  end;
  if AField.VisibleIndex + 1 < AFields.Count then
    AField := AFields[AField.VisibleIndex + 1]
  else
    Exit;

  AList := CreateMembersFromGroup(AMember, not AExpandChildren, AExpandChildren);
  try
    if AList.Count = 0 then Exit;
    AMembersList := CreateMembersFromGroup(ACrossGroup, False);
    try
      InitializeMembersAndTotalsForExpanding(ADataBuilder, AField, AMember,
        ADataBuilder.SummaryFields);
      InitializeCrossCellsForExpanding(ADataBuilder, AMember, ACrossGroup,
        ADataBuilder.SummaryFields);
      if AField.VisibleIndex < AFields.Count then
        ProcessMembersForExpanding(AFields[AField.VisibleIndex], AMember, True);
    finally
      FreeAndNil(AMembersList);
    end;
  finally
    AList.Free;
  end;
end;

function TcxPivotGridCustomOLAPDataSource.GetHasData: Boolean;
begin
  Result := (FieldCount <> 0) and (MeasureCount <> 0);
end;

function TcxPivotGridCustomOLAPDataSource.GetIsActive: Boolean;
begin
  Result := FActive;
end;

function TcxPivotGridCustomOLAPDataSource.GetIsTerminated: Boolean;
begin
  Result := False;
end;

function TcxPivotGridCustomOLAPDataSource.GetLinkByUniqueName(
  const AName: WideString): TcxPivotGridOLAPField;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FFields.Count - 1 do
    if SameText(Fields[I].UniqueName, AName) then
    begin
      Result := Fields[I];
      Exit;
    end;
  for I := 0 to FMeasures.Count - 1 do
    if SameText(Measures[I].UniqueName, AName) then
    begin
      Result := Measures[I];
      Exit;
    end;
end;

procedure TcxPivotGridCustomOLAPDataSource.Initialize;
begin
end;

procedure TcxPivotGridCustomOLAPDataSource.InitializeCrossCells(
  ARowsGroup, AColumnsGroup: TcxPivotGridGroupItem; ADataFields: TcxPivotGridFields);
begin
end;

procedure TcxPivotGridCustomOLAPDataSource.InitializeCrossCellsForExpanding(
  ADataBuilder: TcxPivotGridDataBuilder; AnExpandingItem, ACrossGroup: TcxPivotGridGroupItem; ADataFields: TcxPivotGridFields);
begin
end;

procedure TcxPivotGridCustomOLAPDataSource.InitializeCrossCellValues(
  ACell: TcxPivotGridCrossCell; const AFormattedValues, ANativeValues: Variant);
var
  I, J: Integer;
  IsNull: Boolean;
begin
  if VarIsArray(ANativeValues) then
    IsNull := VarIsNull(ANativeValues[0])
  else
    IsNull := VarIsNull(ANativeValues);
  TcxPivotGridOLAPCrossCell(ACell).FIsEmpty := IsNull;
  if not IsNull then
  begin
    for I := 0 to ACell.SummaryCellCount - 1 do
      for J := 0 to Integer(High(TcxPivotGridSummaryType)) do
        ACell.SummaryCells[I].SetSummaryByIndex(J, AFormattedValues[I]);
    TcxPivotGridOLAPCrossCell(ACell).NativeValues := ANativeValues;
  end;
end;

procedure TcxPivotGridCustomOLAPDataSource.InitializeCrossCellValue(
  ACell: TcxPivotGridCrossCell; const AFormattedValue, ANativeValue, ANativeValues: Variant;
  AValueIndex: Integer);
var
  I: Integer;
  AValues: Variant;
begin
  if AValueIndex = 0 then
  begin
    TcxPivotGridOLAPCrossCell(ACell).FIsEmpty := True;
    TcxPivotGridOLAPCrossCell(ACell).NativeValues := ANativeValues;
  end;

  if not VarIsNull(ANativeValues) then
    TcxPivotGridOLAPCrossCell(ACell).FIsEmpty := False;
  for I := 0 to Integer(High(TcxPivotGridSummaryType)) do
    ACell.SummaryCells[AValueIndex].SetSummaryByIndex(I, AFormattedValue);

  AValues := TcxPivotGridOLAPCrossCell(ACell).NativeValues;
  if VarIsArray(ANativeValues) then
  begin
    AValues[AValueIndex] := ANativeValue;
    TcxPivotGridOLAPCrossCell(ACell).NativeValues := AValues;
  end;
  AValues := Null;
end;

procedure TcxPivotGridCustomOLAPDataSource.InitializeLayout(
  ARowFields, AColumnFields, ADataFields, AFilterFields: TcxPivotGridFields);
begin
end;

procedure TcxPivotGridCustomOLAPDataSource.InitializeMembersAndTotalsForExpanding(
  ADataBuilder: TcxPivotGridDataBuilder; AField: TcxPivotGridField;
  AMember: TcxPivotGridGroupItem; ADataFields: TcxPivotGridFields);
begin
end;

procedure TcxPivotGridCustomOLAPDataSource.InitializeMembers(
  AField: TcxPivotGridOLAPField; AMembers: TcxPivotGridVariantList);
begin
end;

procedure TcxPivotGridCustomOLAPDataSource.InitializeTotals(ADimensionFields,
  ADataFields, AFilterFields: TcxPivotGridFields); 
begin
end;

procedure TcxPivotGridCustomOLAPDataSource.PopulateFilteredUniqueNames(
  AField: TcxPivotGridOLAPField; AFilter: TcxPivotGridFieldFilter; var AUniqueValues: TStringList);
begin
end;

procedure TcxPivotGridCustomOLAPDataSource.PopulateFilteredValues(
  AField: TcxPivotGridOLAPField; AFilter: TcxPivotGridFieldFilter;
  AValues: TInterfaceList; AUniqueValues: TStringList);
begin
end;

procedure TcxPivotGridCustomOLAPDataSource.ProcessMembersForExpanding(
  AField: TcxPivotGridField; AMember: TcxPivotGridGroupItem; AExpandChildren: Boolean);
var
  I: Integer;
begin
  for I := 0 to AMember.ItemCount - 1 do
    ExpandMember(AField, AMember.Items[I], True);
end;

procedure TcxPivotGridCustomOLAPDataSource.RemoveListener(
  AListener: TcxCustomPivotGrid);
begin
  if FListeners <> nil then
    FListeners.Remove(AListener);
end;

procedure TcxPivotGridCustomOLAPDataSource.ReplaceTotals(ADataBuilder: TcxPivotGridDataBuilder;
  AMember: TcxPivotGridGroupItem; ADataFields: TcxPivotGridFields);
begin
end;

procedure TcxPivotGridCustomOLAPDataSource.ZeroCrossCellValues(ACell: TcxPivotGridCrossCell);
var
  I, J: Integer;
begin
  TcxPivotGridOLAPCrossCell(ACell).FIsEmpty := True;
  for I := 0 to ACell.SummaryCellCount - 1 do
    for J := 0 to Integer(High(TcxPivotGridSummaryType)) do
      ACell.SummaryCells[I].SetSummaryByIndex(J, 0);
  TcxPivotGridOLAPCrossCell(ACell).NativeValues := 0;
end;

function TcxPivotGridCustomOLAPDataSource.GetField(
  AIndex: Integer): TcxPivotGridOLAPField;
begin
  Result := FFields[AIndex] as TcxPivotGridOLAPField;
end;

function TcxPivotGridCustomOLAPDataSource.GetFieldCount: Integer;
begin
  Result := FFields.Count
end;

function TcxPivotGridCustomOLAPDataSource.GetListenerCount: Integer;
begin
  Result := FListeners.Count;
end;

function TcxPivotGridCustomOLAPDataSource.GetListener(
  AIndex: Integer): TcxCustomPivotGrid;
begin
  Result := TcxCustomPivotGrid(FListeners[AIndex]);
end;

function TcxPivotGridCustomOLAPDataSource.GetMeasure(
  AIndex: Integer): TcxPivotGridOLAPField;
begin
  Result := FMeasures[AIndex] as TcxPivotGridOLAPField;
end;

function TcxPivotGridCustomOLAPDataSource.GetMeasureCount: Integer;
begin
  Result := FMeasures.Count;
end;

procedure TcxPivotGridCustomOLAPDataSource.SetActive(AValue: Boolean);
begin
  if FActive <> AValue then
  begin
    FActive := AValue;
    Changed;
  end;
end;

{ TcxPivotGridViewDataLimitValue }

constructor TcxPivotGridViewDataLimitValue.Create(AField: TcxPivotGridField);
begin
  Field := AField;
  MaxValue := -MaxInt;
  MinValue := MaxInt;
end;

procedure TcxPivotGridViewDataLimitValue.Calculate(V: Variant);
begin
  MaxValue := Math.MaxValue([Double(MaxValue), Double(V)]);
  MinValue := Math.MinValue([Double(MaxValue), Double(V)]);
end;

{ TcxPivotGridViewDataLimitValues }

function TcxPivotGridViewDataLimitValues.Add(AField: TcxPivotGridField): TcxPivotGridViewDataLimitValue;
begin
  Result := Items[Add(TcxPivotGridViewDataLimitValue.Create(AField))];
end;

procedure TcxPivotGridViewDataLimitValues.Calculate(AField: TcxPivotGridField; V: Variant);
var
  AItem: TcxPivotGridViewDataLimitValue;
begin
  AItem := FindByField(AField);
  if AItem = nil then
    AItem := Add(AField);
  AItem.Calculate(V);
end;

function TcxPivotGridViewDataLimitValues.FindByField(AField: TcxPivotGridField): TcxPivotGridViewDataLimitValue;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if Items[I].Field = AField then
    begin
      Result := Items[I];
      Break;
    end;
end;

function TcxPivotGridViewDataLimitValues.GetMaximumValue(AField: TcxPivotGridField): Variant;
var
  AItem: TcxPivotGridViewDataLimitValue;
begin
  AItem := FindByField(AField);
  if AItem <> nil then
    Result := AItem.MaxValue
  else
    Result := -MaxInt;
end;

function TcxPivotGridViewDataLimitValues.GetMinimumValue(AField: TcxPivotGridField): Variant;
var
  AItem: TcxPivotGridViewDataLimitValue;
begin
  AItem := FindByField(AField);
  if AItem <> nil then
    Result := AItem.MinValue
  else
    Result := MaxInt;
end;

function TcxPivotGridViewDataLimitValues.GetItem(
  Index: Integer): TcxPivotGridViewDataLimitValue;
begin
  Result := TcxPivotGridViewDataLimitValue(inherited Items[Index]);
end;

{ TcxPivotGridViewDataItem }

constructor TcxPivotGridViewDataItem.Create(
  AParent: TcxPivotGridViewDataItem; AGroupItem: TcxPivotGridGroupItem);
begin
  FGroupItem := AGroupItem;
  FParent := AParent;
  FItems := TcxObjectList.Create;
  FVisibleIndex := -1;
  FLimitValues := TcxPivotGridViewDataLimitValues.Create;
end;

destructor TcxPivotGridViewDataItem.Destroy;
begin
  FItems.Free;
  FLimitValues.Free;
  inherited Destroy;
end;

function TcxPivotGridViewDataItem.Add(
  AData: TcxPivotGridGroupItem): TcxPivotGridViewDataItem;
begin
  Result := TcxPivotGridViewDataItem.Create(Self, AData);
  Result.FIndex := FItems.Add(Result);
end;

function TcxPivotGridViewDataItem.AddTotal(
  AData: TcxPivotGridGroupItem; AIndex: Integer): TcxPivotGridViewDataItem;
begin
  Result := TcxPivotGridViewDataTotalItem.Create(Self, AData);
  Result.FIndex := FItems.Add(Result);
  TcxPivotGridViewDataTotalItem(Result).SetTotal(AIndex);
end;

procedure TcxPivotGridViewDataItem.ClearCache;
var
  ADataField: TcxPivotGridField;
  AGroupItem: TcxPivotGridGroupItem;
begin
  AGroupItem := GetGroupItem(ADataField);
  if AGroupItem is TcxPivotGridRowItem then
    TcxPivotGridRowItem(AGroupItem).ClearCache;
end;

procedure TcxPivotGridViewDataItem.DeleteChildren;
begin
  FItems.Clear;
end;

function TcxPivotGridViewDataItem.GetDisplayText: string;
var
  AFakeCell: TcxPivotGridHeaderCellViewInfo;
begin
  AFakeCell := TcxPivotGridHeaderCellViewInfo.Create(PivotGrid.LookAndFeelPainter,
    cxSimpleRect, cxSimpleRect, PivotGrid.ViewInfo.FViewParams);
  try
    AFakeCell.Data := Self;
    PivotGrid.ViewInfo.InitHeaderCell(AFakeCell, Self);
    Result := AFakeCell.DisplayText;
  finally
    AFakeCell.Free;
  end;
end;

function TcxPivotGridViewDataItem.GetGroupItem(
  var ADataField: TcxPivotGridField): TcxPivotGridGroupItem;
var
  AViewData: TcxPivotGridViewDataItem;
begin
  AViewData := Self;
  while AViewData.IsDataField do
  begin
    ADataField := AViewData.Field;
    AViewData := AViewData.Parent;
  end;
  Result := AViewData.GroupItem;
  AViewData := Self;
  while (ADataField = nil) and (AViewData <> nil) do
  begin
    if AViewData.IsDataField then
      ADataField := AViewData.Field;
    AViewData := AViewData.Parent;
  end;
end;

function TcxPivotGridViewDataItem.GetGroupItemByField(
  ADataField: TcxPivotGridField): TcxPivotGridGroupItem;
begin
  Result := nil;
  if Field = ADataField then
    Result := GroupItem
  else
    if Parent <> nil then
      Result := Parent.GetGroupItemByField(ADataField);
end;

function TcxPivotGridViewDataItem.GetSummaryType(
  var ASummaryType: TcxPivotGridSummaryType; var ATotal: TcxPivotGridCustomTotal): Boolean;
begin
  if Parent <> nil then
    Result := Parent.GetSummaryType(ASummaryType, ATotal)
  else
    Result := False;
end;

function TcxPivotGridViewDataItem.MeasureWidth(
  AField: TPersistent; AIncludeTotals: Boolean): Integer;
var
  AParams: TcxViewParams;
  AAlignHorz: TAlignment;
  AAlignVert: TcxAlignmentVert;
  I, AImageIndex: Integer;
begin
  Result := 0;
  if (Field = AField) and (PivotGrid <> nil) and (not IsTotal or AIncludeTotals) then
    with PivotGrid do
    begin
      AImageIndex := Field.DoGetGroupImageIndex(Self, AAlignHorz, AAlignVert);
      if AImageIndex > 0 then
        Inc(Result, GroupHeaderImages.Width + cxPivotGridDoubleSpace);
      if (ItemCount > 0) or ((GroupItem <> nil) and (GroupItem.ItemCount > 0)) then
        Inc(Result, LookAndFeelPainter.ExpandButtonSize + cxPivotGridDoubleSpace);
      AParams := Styles.GetRowHeaderParams(Self);
      Inc(Result, cxTextWidth(AParams.Font, Value) + cxPivotGridDoubleSpace);
      Exit;
    end;
  for I := 0 to ItemCount - 1 do
    Result := Max(Result, Items[I].MeasureWidth(AField, AIncludeTotals));
end;

function TcxPivotGridViewDataItem.GetFirst: TcxPivotGridViewDataItem;
begin
  if ItemCount > 0 then
    Result := Items[0]
  else
    Result := nil;
end;

function TcxPivotGridViewDataItem.GetHasButton: Boolean;
begin
  Result := not IsTotal and ((GroupItem.ItemCount > 0) or GroupItem.HasChildren);
end;

function TcxPivotGridViewDataItem.GetHasChildren: Boolean;
begin
  Result := (ItemCount > 0) or GroupItem.HasChildren;
end;

function TcxPivotGridViewDataItem.GetExpanded: Boolean;
begin
  Result := HasButton and GroupItem.Expanded;
end;

function TcxPivotGridViewDataItem.GetChildLeftVisibleIndex: Integer;
var
  I: Integer;
begin
  Result := MaxInt;
  if ItemCount > 0 then
  begin
    for I := 0 to ItemCount - 1 do
      Result := Min(Result, Items[I].GetChildLeftVisibleIndex);
  end
  else
    Result := VisibleIndex;
end;

function TcxPivotGridViewDataItem.GetChildRightVisibleIndex: Integer;
var
  I: Integer;
begin
  Result := 0;
  if ItemCount > 0 then
  begin
    for I := 0 to ItemCount - 1 do
      Result := Max(Result, Items[I].GetChildRightVisibleIndex);
  end
  else
    Result := VisibleIndex;
end;

function TcxPivotGridViewDataItem.GetField: TcxPivotGridField;
begin
  Result := GroupItem.Field;
end;

function TcxPivotGridViewDataItem.GetIsTotal: Boolean;
begin
  Result := False;
end;

function TcxPivotGridViewDataItem.GetItem(
  AIndex: Integer): TcxPivotGridViewDataItem;
begin
  Result := TcxPivotGridViewDataItem(FItems[AIndex]);
end;

function TcxPivotGridViewDataItem.GetItemCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxPivotGridViewDataItem.GetIsGrandTotal: Boolean;
begin
  Result := IsTotalItem and ((GroupItem.Parent = nil) or ((Parent <> nil) and (Parent.IsGrandTotal)));
end;

function TcxPivotGridViewDataItem.GetIsTotalItem: Boolean;
var
  AItem: TcxPivotGridViewDataItem;
begin
  AItem := Self;
  repeat
    Result := AItem.IsTotal;
    AItem := AItem.Parent;
  until Result or (AItem = nil);
end;

function TcxPivotGridViewDataItem.GetLevel: Integer;
var
  AParent: TcxPivotGridViewDataItem;
begin
  Result := -1;
  AParent := FParent;
  while AParent <> nil do
  begin
    AParent := AParent.FParent;
    Inc(Result);
  end;
end;

function TcxPivotGridViewDataItem.GetLast: TcxPivotGridViewDataItem;
begin
  if ItemCount > 0 then
    Result := Items[ItemCount - 1]
  else
    Result := nil
end;

function TcxPivotGridViewDataItem.GetNextVisible: TcxPivotGridViewDataItem;
begin
  Result := Self;
  while (Result <> nil) and (Result = Result.Parent.Last) do
  begin
    Result := Result.Parent;
    if Result.Parent = nil then
      Result := nil;
  end;
  if Result <> nil then
  begin
    Result := Result.Parent.Items[Result.Index + 1];
    while Result.ItemCount > 0 do Result := Result.First;
  end;
end;

function TcxPivotGridViewDataItem.GetPrevVisible: TcxPivotGridViewDataItem;
begin
  Result := Self;
  while (Result <> nil) and (Result.Index = 0) do
    Result := Result.Parent;
  if Result <> nil then
  begin
    Result := Result.Parent.Items[Result.Index - 1];
    while Result.ItemCount > 0 do Result := Result.Last;
  end;
end;

function TcxPivotGridViewDataItem.GetPivotGrid: TcxCustomPivotGrid;
begin
  if GroupItem = nil then
    Result := nil
  else
    Result := GroupItem.PivotGrid;
end;

function TcxPivotGridViewDataItem.GetSize: Integer;
var
  I: Integer;
begin
  Result := 0;
  if ItemCount > 0 then
  begin
    for I := 0 to ItemCount - 1 do
      Inc(Result, Items[I].Size)
  end
  else
    Result := GroupItem.GetSingleItemSize;
end;

function TcxPivotGridViewDataItem.GetValue: string;
begin
  Result := GroupItem.DisplayText;
end;

{ TcxPivotGridViewDataTotalItem }

function TcxPivotGridViewDataTotalItem.GetSummaryType(var ASummaryType: TcxPivotGridSummaryType;
   var ATotal: TcxPivotGridCustomTotal): Boolean;
begin
  if Total <> nil then
  begin
    Result := True;
    ATotal := Total;
    ASummaryType := ATotal.SummaryType;
  end
  else
    Result := inherited GetSummaryType(ASummaryType, ATotal);
end;

function TcxPivotGridViewDataTotalItem.GetDescription: string;
begin
  if Total = nil then
    Result := cxGetResourceString(@scxGroupTotal)
  else
    Result := cxGetResourceString(TotalDescriptions[Total.SummaryType]);
end;

function TcxPivotGridViewDataTotalItem.GetIsTotal: Boolean;
begin
  Result := True;
end;

function TcxPivotGridViewDataTotalItem.GetValue: string;
begin
  if IsGrandTotal then
    Result := cxGetResourceString(@scxGrandTotal)
  else
    Result := Format(GetDescription, [inherited GetValue])
end;

procedure TcxPivotGridViewDataTotalItem.SetTotal(AIndex: Integer);
begin
  if not IsGrandTotal and (Field.TotalsVisibility = tvCustom) then
    FTotal := Field.CustomTotals[AIndex];
end;

{ TcxPivotGridViewDataSelection }

constructor TcxPivotGridViewDataSelection.Create(AViewData: TcxPivotGridViewData);
begin
  FViewData := AViewData;
  SetLength(FRegions, 0);
  FLockCount := 0;
  FAnchorCells := cxNullRect;
  FFocusedCell := cxInvalidPoint;
  FHasTemporarySelection := False;
end;

destructor TcxPivotGridViewDataSelection.Destroy;
begin
  SetLength(FRegions, 0);
  inherited Destroy;
end;

procedure TcxPivotGridViewDataSelection.Add(const ARegion: TRect);
var
  I: Integer;
  AFindRegion: Boolean;
begin
  if (Count > 0) and not MultiSelect then
    Exit;
  AFindRegion := False;
  I := 0;
  while not AFindRegion and (I < Count) do
  begin
    AFindRegion := EqualRect(Regions[I], ARegion);
    Inc(I);
  end;
  if not AFindRegion then
  begin
    SetLength(FRegions, Count + 1);
    FRegions[Count - 1] := ARegion;
  end
  else
  begin
    FRegions[I - 1] := FRegions[Count - 1];
    FRegions[Count - 1] := ARegion;
  end;
  ApplyTemporarySelection(False);
  DoChanged;
end;

procedure TcxPivotGridViewDataSelection.BeginUpdate;
begin
  Inc(FLockCount);
end;

procedure TcxPivotGridViewDataSelection.Clear;
begin
  BeginUpdate;
  try
    InnerClear;
    InnerSetFocusedCell(cxInvalidPoint);
    FAnchorCells := Rect(0, 0, 0, 0);
  finally
    EndUpdate;
  end;
end;

procedure TcxPivotGridViewDataSelection.Delete(AIndex: Integer);
var
  I: Integer;
begin
  BeginUpdate;
  try
    if (AIndex < 0) or (AIndex >= Count) then
      Exit;
    for I := AIndex + 1 to Count - 1 do
      FRegions[I - 1] := FRegions[I];
    SetLength(FRegions, Count - 1);
  finally
    EndUpdate;
  end;
end;

procedure TcxPivotGridViewDataSelection.EndUpdate(ASendNotification: Boolean = True);
begin
  Dec(FLockCount);
  if ASendNotification then
    DoChanged;
end;

function TcxPivotGridViewDataSelection.GetCombinedSelectionBounds: TRect;
var
  I: Integer;
begin
  Result := Rect(MaxInt, MaxInt, 0, 0);
  for I := 0 to Count - 1 do
  begin
    if EqualRect(Regions[I], cxInvalidRect) then Continue;
    with Result do
    begin
      Left := Min(Left, Regions[I].Left);
      Top := Min(Top, Regions[I].Top);
      Right := Max(Right, Regions[I].Right);
      Bottom := Max(Bottom, Regions[I].Bottom);
    end;
  end;
end;

function TcxPivotGridViewDataSelection.IsCellSelected(AColumn, ARow: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Count - 1 do
  begin
    if EqualRect(Regions[I], cxInvalidRect) then Continue;
    Result := (Regions[I].Left <= AColumn) and (Regions[I].Right >= AColumn) and
      (Regions[I].Top <= ARow) and (Regions[I].Bottom >= ARow);
    if Result then
      Break;
  end;
end;

procedure TcxPivotGridViewDataSelection.MakeNew(const ARegion: TRect);
begin
  if EqualRect(ARegion, cxInvalidRect) or ((Count = 1) and EqualRect(ARegion, Regions[0])) then
    Exit;
  BeginUpdate;
  try
    InnerClear;
    Add(ARegion);
  finally
    EndUpdate;
  end;
end;

procedure TcxPivotGridViewDataSelection.ApplyTemporarySelection(AIsSet: Boolean);
begin
  FHasTemporarySelection := False;
end;

procedure TcxPivotGridViewDataSelection.ChangeSelection(const R: TRect; AShift: TShiftState);
begin
  if MultiSelect and not ([ssShift, ssCtrl] * AShift = [ssShift, ssCtrl]) then
  begin
    if not EqualRect(TemporarySelection, R) then
    begin
      BeginUpdate;
      try
        if not IsTemporarySelected and (not (ssCtrl in AShift) or (ssRight in AShift)) then
          InnerClear;
        TemporarySelection := R;
      finally
        EndUpdate;
      end;
    end;
  end
  else
    MakeNew(R);
end;

procedure TcxPivotGridViewDataSelection.DoChanged;
begin
  if (LockCount = 0) and (ViewData <> nil) then
    ViewData.PivotGrid.SelectionChanged;
end;

procedure TcxPivotGridViewDataSelection.InnerClear;
begin
  SetLength(FRegions, 0);
end;

procedure TcxPivotGridViewDataSelection.InnerSetFocusedCell(const APoint: TPoint);
begin
  FFocusedCell := APoint;
end;

function TcxPivotGridViewDataSelection.IsSelected: Boolean;
begin
  Result := Count > 0;
end;

procedure TcxPivotGridViewDataSelection.ValidateFocusedCell;
var
  R: TRect;
  ABestRow, ABestColumn: Integer;
  AOldFocusedCell: TPoint;
  AMaxIteration: Integer;
  I: Integer;

  function FindValidateCell(ADelta: Integer; var ARow, AColumn: Integer): Boolean;

    function CheckFindValidateCell(Y, X: Integer): Boolean;
    begin
      Result := ViewData.CanCellSelect(Y, X);
      if Result then
      begin
        ARow := Y;
        AColumn := X;
      end;
    end;

  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to ADelta do
    begin
      Result := True;
      if CheckFindValidateCell(FocusedCell.Y + ADelta, FocusedCell.X + I) then
        Exit;
      if CheckFindValidateCell(FocusedCell.Y + ADelta, FocusedCell.X - I) then
        Exit;
      if CheckFindValidateCell(FocusedCell.Y - ADelta, FocusedCell.X + I) then
        Exit;
      if CheckFindValidateCell(FocusedCell.Y - ADelta, FocusedCell.X - I) then
        Exit;

      if CheckFindValidateCell(FocusedCell.Y + I, FocusedCell.X + ADelta) then
        Exit;
      if CheckFindValidateCell(FocusedCell.Y + I, FocusedCell.X - ADelta) then
        Exit;
      if CheckFindValidateCell(FocusedCell.Y - I, FocusedCell.X + ADelta) then
        Exit;
      if CheckFindValidateCell(FocusedCell.Y - I, FocusedCell.X - ADelta) then
        Exit;
      Result := False;
    end;
  end;

begin
  R := Classes.Rect(FocusedCell, FocusedCell);
  ViewData.ValidateSelection(R);
  FFocusedCell := R.TopLeft;
  AOldFocusedCell := FFocusedCell;
  if not MultiSelect then
  begin
    Clear;
    FFocusedCell := AOldFocusedCell;
  end;
  if not ViewData.CanCellSelect(AOldFocusedCell.Y, AOldFocusedCell.X) then
  begin
    ABestRow := AOldFocusedCell.Y;
    ABestColumn := AOldFocusedCell.X;
    AMaxIteration := Max(Max(ViewData.RowCount - 1 - AOldFocusedCell.Y, AOldFocusedCell.Y),
      Max(ViewData.ColumnCount - 1 - AOldFocusedCell.X, AOldFocusedCell.X));
    for I := 1 to AMaxIteration do
    begin
      if FindValidateCell(I, ABestRow, ABestColumn) then
        Break;
    end;
    FFocusedCell.Y := ABestRow;
    FFocusedCell.X := ABestColumn;
  end;
  if not IsCellSelected(FFocusedCell.X, FFocusedCell.Y) then
    if not MultiSelect or ((Count = 1) and EqualRect(Classes.Rect(AOldFocusedCell, AOldFocusedCell), Regions[0])) then
      MakeNew(Classes.Rect(FFocusedCell, FFocusedCell))
    else
      Add(Classes.Rect(FFocusedCell, FFocusedCell));
end;

procedure TcxPivotGridViewDataSelection.ValidateSelections;
var
  I: Integer;
  R: TRect;
begin
  BeginUpdate;
  try
    for I := Count - 1 downto 0 do
    begin
      R := FRegions[I];
      ViewData.ValidateSelection(R);
      if not EqualRect(R, FRegions[I]) then
      begin
        if cxRectContain(FRegions[I], R) then
          FRegions[I] := R
        else
          Delete(I);
      end;
    end;
    ValidateFocusedCell;
    AnchorCells := Classes.Rect(FocusedCell, FocusedCell);
  finally
    EndUpdate(False);
  end;
end;

function TcxPivotGridViewDataSelection.GetCount: Integer;
begin
  Result := Length(FRegions);
end;

function TcxPivotGridViewDataSelection.GetRegion(AIndex: Integer): TRect;
begin
  Result := FRegions[AIndex];
end;

function TcxPivotGridViewDataSelection.GetMultiSelect: Boolean;
begin
  Result := ViewData.OptionsSelection.MultiSelect;
end;

function TcxPivotGridViewDataSelection.GetTemporarySelection: TRect;
begin
  if FHasTemporarySelection and (Count > 0) then
    Result := Regions[Count - 1]
  else
    Result := cxInvalidRect;
end;

function TcxPivotGridViewDataSelection.IsTemporarySelected: Boolean;
begin
  Result := FHasTemporarySelection and not EqualRect(TemporarySelection, cxInvalidRect);
end;

procedure TcxPivotGridViewDataSelection.SetFocusedCell(const APoint: TPoint);
begin
  if not cxPointIsEqual(APoint, FFocusedCell) then
  begin
    InnerSetFocusedCell(APoint);
    ChangeSelection(Classes.Rect(APoint, APoint), []);
  end;
end;

procedure TcxPivotGridViewDataSelection.SetTemporarySelection(const AValue: TRect);
begin
  if not EqualRect(TemporarySelection, AValue) then
  begin
    if FHasTemporarySelection and (Count > 0) then
      FRegions[Count - 1] := AValue
    else
      Add(AValue);
    FHasTemporarySelection := FHasTemporarySelection or not EqualRect(AValue, cxInvalidRect);
    DoChanged;
  end;
end;

{ TcxPivotGridViewData }

constructor TcxPivotGridViewData.Create(AOwner: TcxCustomPivotGrid);
begin
  FOwner := AOwner;
  FRows := TcxPivotGridViewDataItem.Create(nil, DataBuilder.Rows);
  FColumns := TcxPivotGridViewDataItem.Create(nil, DataBuilder.Columns);
  FBookMarkRow := -1;
  FSelection := TcxPivotGridViewDataSelection.Create(Self);
  FLimitValues := TcxPivotGridViewDataLimitValues.Create;
  FColumnsList := TList.Create;
  FRowsList := TList.Create;
end;

destructor TcxPivotGridViewData.Destroy;
begin
  FColumnsList.Free;
  FRowsList.Free;
  FRows.Free;
  FColumns.Free;
  FLimitValues.Free;
  FreeAndNil(FSelection);
  inherited Destroy;
end;

function TcxPivotGridViewData.IsCellSelected(ARow, AColumn: Integer): Boolean;
begin
  Result := (PivotGrid.IsDesigning and (ARow = 0) and (AColumn = 0)) or
    (not PivotGrid.IsDesigning and FSelection.IsCellSelected(AColumn, ARow) and CanCellSelect(ARow, AColumn));
end;

function TcxPivotGridViewData.MakeSelectionVisible: Boolean;

  function GetPosValue(AValue, AIndex, APage: Integer): Integer;
  begin
    Result := AIndex;
    if AValue < AIndex then
      Result := AValue
    else
      while AValue - Result >= APage do Inc(Result);
  end;

var
  ARowIndex, AColIndex: Integer;
begin
  with FocusedCell do
  begin
    ARowIndex := GetPosValue(Y, RowIndex, RowsPerPage);
    AColIndex := GetPosValue(X, ColumnIndex, ColumnsPerPage);
  end;
  Result := (ARowIndex <> RowIndex) or (AColIndex <> ColumnIndex);
  if Result then
  begin
    FRowIndex := ARowIndex;
    FColumnIndex := AColIndex;
    PivotGrid.ViewChanged;
  end;
end;

procedure TcxPivotGridViewData.AdjustCellIndexes(var ARow, AColumn: Integer; AByMouse: Boolean = False);

  function ValueInRange(AValue, X1, X2: Integer): Boolean;
  begin
    Result := (AValue >= Min(X1, X2)) and (AValue <= Max(X1, X2));
  end;

  procedure InnerCalculateDelta(APrevRow, APrevColumn: Integer; var DY, DX: Integer);
  begin
    APrevColumn := Min(Max(0, APrevColumn), ColumnCount - 1);
    DX := AColumn - APrevColumn;
    if DX > 0 then DX := 1
    else
      if DX < 0 then DX := -1;
    APrevRow := Min(Max(0, APrevRow), RowCount - 1);
    DY := ARow - APrevRow;
    if DY > 0 then DY := 1
    else
      if DY < 0 then DY := -1;
  end;

  procedure InnerAdjustCellIndexes(APrevRow, APrevColumn, DY, DX: Integer);
  var
    I, J: Integer;
  begin
    I := AColumn;
    J := ARow;
    while ValueInRange(J, ARow, APrevRow) and not CanCellSelect(J, I) do
    begin
      while ValueInRange(I, AColumn, APrevColumn) and not CanCellSelect(J, I) do
      begin
        if DX = 0 then Break;
          Dec(I, DX);
      end;
      if not ValueInRange(I, AColumn, APrevColumn) then
        I := AColumn;
      if DY = 0 then Break;
      if not CanCellSelect(J, I) then
        Dec(J, DY);
    end;
    if not ValueInRange(J, ARow, APrevRow) then
      J := ARow;
    if CanCellSelect(J, I) then
    begin
      ARow := J;
      AColumn := I;
    end;
  end;

var
  DY, DX: Integer;
  P: TPoint;
begin
  AColumn := Min(Max(0, AColumn), ColumnCount - 1);
  ARow := Min(Max(0, ARow), RowCount - 1);
  P := FocusedCell;
  if not CanCellSelect(ARow, AColumn) then
  begin
    InnerCalculateDelta(P.Y, P.X, DY, DX);
    if ((DX = 0) or (DY = 0)) and not AByMouse then
    begin
      if (DX > 0) then
        InnerAdjustCellIndexes(ARow, ColumnCount - 1, 0, -DX)
      else
        if (DX < 0) then
          InnerAdjustCellIndexes(ARow, 0, 0, -DX)
        else
          if (DY > 0) then
            InnerAdjustCellIndexes(RowCount - 1, AColumn, -DY, 0)
          else
            if (DY < 0) then
              InnerAdjustCellIndexes(0, AColumn, -DY, 0);
    end;
    if not CanCellSelect(ARow, AColumn) then
      InnerAdjustCellIndexes(P.Y, P.X, DY, DX);
  end;
end;

function TcxPivotGridViewData.AdjustCellIndexesPoint(const P: TPoint; AByMouse: Boolean = False): TPoint;
var
  AColumn, ARow: Integer;
begin
  AColumn := P.X;
  ARow := P.Y;
  AdjustCellIndexes(ARow, AColumn, AByMouse);
  Result := Point(AColumn, ARow);
end;

procedure TcxPivotGridViewData.Calculate;
begin
  Clear;
  ProduceColumns;
  ProduceRows;
  ValidateIndexes;
  FCalculatedLimitValues := False;
end;

function TcxPivotGridViewData.CalculateDataWidth(AField: TcxPivotGridField): Integer;
var
  APrevRow, ARow, AColumn: TcxPivotGridViewDataItem;
  APrevCell: TcxPivotGridCrossCellSummary;
  AFakeCell: TcxPivotGridDataCellViewInfo;
begin
  Result := 0;
  if not AField.Visible then Exit;
  AFakeCell := TcxPivotGridDataCellViewInfo.Create(PivotGrid.LookAndFeelPainter,
    cxSimpleRect, cxSimpleRect, PivotGrid.ViewInfo.FViewParams);
  try
    ARow := Rows[0];
    while ARow <> nil do
    begin
      APrevCell := nil;
      AColumn := Columns[0];
      while AColumn <> nil do
      begin
        AFakeCell.Initialize(ARow, AColumn, AField);
        AFakeCell.CalculateVisibleInfo;
        if AFakeCell.CellSummary <> APrevCell then
        begin
          APrevCell := AFakeCell.CellSummary;
          if APrevCell.DataField = AField then
          begin
            AFakeCell.FViewParams := PivotGrid.Styles.GetContentParams(AFakeCell);
            Result := Max(Result, AFakeCell.MeasureWidth);
          end;
        end;
        AColumn := AColumn.GetNextVisible;
      end;
     APrevRow := ARow;
     ARow := ARow.GetNextVisible;
     if PivotGrid.OLAPDataSource = nil then
     begin
       if not IsGroupItemEquals(APrevRow, ARow) and (PivotGrid.OptionsDataField.Area <> dfaRow) and
         not (APrevRow.IsTotal or APrevRow.IsGrandTotal) then
         APrevRow.ClearCache;
       AFakeCell.FCrossCell := nil;
     end;
    end;
  finally
    AFakeCell.Free;
  end;
  PivotGrid.DataChanged;
end;

procedure TcxPivotGridViewData.CalculateDataFieldInfo(
  var AFieldIndex: Integer; var AFields: TcxPivotGridGroupItem;
  AcceptedArea: TcxPivotGridDataFieldArea);
begin
  AFieldIndex := MaxInt;
  AFields := nil;
  with PivotGrid.OptionsDataField do
  begin
    if DataBuilder.DataFields.Count <= 1 then Exit;
    if (Area = AcceptedArea) or ((Area = dfaNone) and (AcceptedArea = dfaColumn)) then
    begin
      if (Area <> dfaNone) and (AreaIndex >= 0) then
        AFieldIndex := PivotGrid.OptionsDataField.AreaIndex;
      AFields := PivotGrid.DataBuilder.Data;
      if AcceptedArea = dfaColumn then
        AFieldIndex := Min(AFieldIndex, DataBuilder.ColumnFields.Count)
      else
        AFieldIndex := Min(AFieldIndex, DataBuilder.RowFields.Count);
    end;
  end;
end;

procedure TcxPivotGridViewData.CalculateLimitValues;

  function GetRootParent(AItem: TcxPivotGridViewDataItem): TcxPivotGridViewDataItem;
  begin
    if AItem.Parent <> nil then
      Result := GetRootParent(AItem.Parent)
    else
      Result := AItem;
  end;

  procedure InnerCalculateForItem(AItem, ARootCrossItem: TcxPivotGridViewDataItem);
  var
    I: Integer;
    V: Variant;
    ACrossCell: TcxPivotGridCrossCell;
    ADataField: TcxPivotGridField;
  begin
    if ARootCrossItem.IsTotal or ARootCrossItem.IsGrandTotal then
      Exit;
    for I := 0 to ARootCrossItem.ItemCount - 1 do
    begin
      if ARootCrossItem.Items[I].IsTotal or ARootCrossItem.Items[I].IsGrandTotal then Continue;
      if ARootCrossItem.Items[I].ItemCount > 0 then
        InnerCalculateForItem(AItem, ARootCrossItem.Items[I])
      else
      begin
        V := Null;
        ADataField := nil;
        if AItem.IsDataField then
          ACrossCell := ARootCrossItem.Items[I].GroupItem.GetCellByCrossItem(AItem.GetGroupItem(ADataField))
        else
          if ARootCrossItem.Items[I].IsDataField then
            ACrossCell := AItem.GroupItem.GetCellByCrossItem(ARootCrossItem.Items[I].GetGroupItem(ADataField))
          else
            ACrossCell := AItem.GetGroupItem(ADataField).GetCellByCrossItem(ARootCrossItem.Items[I].GroupItem);
        if ACrossCell <> nil then
        begin
          if (ADataField = nil) and (DataBuilder.DataFields.Count = 1) then
            ADataField := DataBuilder.DataFields[0];
          if ADataField <> nil then
          V := ACrossCell.GetSummaryByField(ADataField, ADataField.SummaryType);
        end;
        if VarIsNumericEx(V) then
          AItem.LimitValues.Calculate(ADataField, V);
      end;
    end;
  end;

  procedure InnerCalculateLimitValues(AItem, ARootCrossItem: TcxPivotGridViewDataItem);
  var
    I: Integer;
  begin
    if AItem.ItemCount = 0 then
      InnerCalculateForItem(AItem, ARootCrossItem)
    else
      for I := 0 to AItem.ItemCount - 1 do
      begin
        if AItem.Items[I].IsTotal or AItem.Items[I].IsGrandTotal then Continue;
        AItem.LimitValues.Clear;
        InnerCalculateLimitValues(AItem.Items[I], ARootCrossItem);
      end;
  end;

var
  I, J: Integer;
begin
  if not NeedCalculateLimitValues then
    Exit;
  InnerCalculateLimitValues(GetRootParent(Columns[0]), GetRootParent(Rows[0]));
  InnerCalculateLimitValues(GetRootParent(Rows[0]), GetRootParent(Columns[0]));
  LimitValues.Clear;
  for I := 0 to ColumnCount - 1 do
    for J := 0 to Columns[I].LimitValues.Count - 1 do
      with Columns[I].LimitValues[J] do
      begin
        LimitValues.Calculate(Field, MaxValue);
        LimitValues.Calculate(Field, MinValue);
      end;
  FCalculatedLimitValues := True;
end;

procedure TcxPivotGridViewData.Clear;
begin
  FRows.DeleteChildren;
  FColumns.DeleteChildren;
end;

function TcxPivotGridViewData.CanCellSelect(ARow, AColumn: Integer): Boolean;
var
  AIsTotal: Boolean;
  AIsGrandTotal: Boolean;
  AIsCell: Boolean;
begin
  Result := (ARow >= 0) and (ARow < RowCount) and (AColumn >= 0) and (AColumn < ColumnCount);
  if not Result then Exit;
  AIsGrandTotal := Columns[AColumn].IsGrandTotal or
    Rows[ARow].IsGrandTotal;
  AIsTotal := not AIsGrandTotal and ((Columns[AColumn].IsTotalItem and not Columns[AColumn].IsGrandTotal) or
    (Rows[ARow].IsTotalItem and not Rows[ARow].IsGrandTotal));
  AIsCell := not AIsTotal and not AIsGrandTotal;
  Result := (AIsTotal and (osiTotalCells in OptionsSelection.IncludeCells)) or
    (AIsGrandTotal and (osiGrandTotalCells in OptionsSelection.IncludeCells)) or
    (AIsCell and (osiCrossCells in OptionsSelection.IncludeCells));
end;

procedure TcxPivotGridViewData.DoNextPage(AGoForward: Boolean);
begin
  if AGoForward then
    RowIndex := RowIndex + RowsPerPage
  else
    RowIndex := RowIndex - RowsPerPage;
end;

procedure TcxPivotGridViewData.HeaderCellSelect(ADataItem: TcxPivotGridViewDataItem; AShift: TShiftState);
var
  R: TRect;
  ALeft, ARight: Integer;
begin
  ALeft := ADataItem.GetChildLeftVisibleIndex;
  ARight := ADataItem.GetChildRightVisibleIndex;
  R := AnchorCells;
  if (ADataItem.IsDataField and (ADataItem.Parent.GroupItem is TcxPivotGridColumnItem)) or (ADataItem.GroupItem is TcxPivotGridColumnItem) then
  begin
    if Selection.MultiSelect then
      R.Top := 0
    else
      R.Top := FocusedCell.Y;
    if AnchorCells.Left > ALeft then
      R.Left := ALeft;
    if AnchorCells.Right < ARight then
      R.Right := ARight;
    Selection.InnerSetFocusedCell(Point(ALeft, R.Top));
  end
  else
  begin
    if Selection.MultiSelect then
      R.Left := 0
    else
      R.Left := FocusedCell.X;
    if AnchorCells.Top > ALeft then
      R.Top := ALeft;
    if AnchorCells.Bottom < ARight then
      R.Bottom := ARight;
    Selection.InnerSetFocusedCell(Point(R.Left, ALeft));
  end;
  if AnchorCells.Top = -1 then
    R.Bottom := RowCount - 1;
  if AnchorCells.Left = -1 then
    R.Right := ColumnCount - 1;
  ValidateSelection(R);
  Selection.ChangeSelection(R, AShift);
end;

function TcxPivotGridViewData.IsGroupItemEquals(
  AItem1, AItem2: TcxPivotGridViewDataItem): Boolean;

  function GetGroupItem(AItem: TcxPivotGridViewDataItem): TcxPivotGridGroupItem;
  begin
    Result := nil;
    if AItem <> nil then
      Result := AItem.GroupItem;
    if Result is TcxPivotGridDataItem then
      Result := Result.Parent;
  end;

begin
  Result := GetGroupItem(AItem1) = GetGroupItem(AItem2);
end;

type
  TcxPivotGridItemsProducer = class
  protected
    DataLevel: Integer;
    DataFields: TcxPivotGridGroupItem;
    Dest: TcxPivotGridViewDataItem;
    DestList: TList;
    Source: TcxPivotGridGroupItem;
    GrandTotals: Boolean;
    GrandTotalsForSingleValues: Boolean;
    Totals: Boolean;
    TotalsLocation: TcxPivotGridTotalsLocation;
    TotalsForSingleValues: Boolean;
    VariationFieldsOnly: Boolean;

    procedure AddChildren(AItem: TcxPivotGridGroupItem;
      ALevel: Integer; AParent: TcxPivotGridViewDataItem); virtual;
    function AddData(AItem: TcxPivotGridGroupItem;
      ALevel: Integer; AParent: TcxPivotGridViewDataItem): Boolean; virtual;
    procedure AddTotals(AItem: TcxPivotGridGroupItem;
      ALevel: Integer; AParent: TcxPivotGridViewDataItem); virtual;
    procedure DeleteEmptyItems;
    function IsVariationFieldsOnly: Boolean;
    procedure InitVisibleItem(AItem: TcxPivotGridViewDataItem);
    procedure ProcessItem(AItem: TcxPivotGridGroupItem;
      ALevel: Integer; AParent: TcxPivotGridViewDataItem); virtual;
    procedure Produce; virtual;
    function SkipFieldProcessing(AParent: TcxPivotGridViewDataItem; AField: TcxPivotGridField): Boolean;
    function TotalNeeded(AVisible, ASingleVisible: Boolean; AItem: TcxPivotGridGroupItem): Boolean;
  public
    constructor Create(ASource: TcxPivotGridGroupItem; ADest: TcxPivotGridViewDataItem;
      ADestList: TList; ALocation: TcxPivotGridTotalsLocation;
      ATotals, ASingleTotals, AGrandTotals, ASingleGrandTotals: Boolean);
  end;

constructor TcxPivotGridItemsProducer.Create(ASource: TcxPivotGridGroupItem;
  ADest: TcxPivotGridViewDataItem; ADestList: TList;
  ALocation: TcxPivotGridTotalsLocation;
  ATotals, ASingleTotals, AGrandTotals, ASingleGrandTotals: Boolean);
begin
  Dest := ADest;
  DestList := ADestList;
  DestList.Clear;
  Source := ASource;
  TotalsLocation := ALocation;
  Totals := ATotals;
  TotalsForSingleValues := ASingleTotals;
  GrandTotals :=  AGrandTotals;
  GrandTotalsForSingleValues := ASingleGrandTotals;
  DataLevel := MaxInt;
end;

procedure TcxPivotGridItemsProducer.AddChildren(AItem: TcxPivotGridGroupItem;
  ALevel: Integer; AParent: TcxPivotGridViewDataItem);
var
  I: Integer;
begin
  if (ALevel < 0) and (AItem.ItemCount = 0) and not AItem.HasChildren then Exit;
  if ALevel >= 0 then
    AParent := AParent.Add(AItem);
  if AItem.Expanded and (AItem.ItemCount > 0) then
  begin
    if not AddData(AItem, ALevel + 1, AParent) then
    begin
      for I := 0 to AItem.ItemCount - 1 do
        ProcessItem(AItem.Items[I], ALevel + 1, AParent)
    end
  end
  else
  begin
    if not AddData(AItem, ALevel + 1, AParent) then
      InitVisibleItem(AParent);
  end;
end;

function TcxPivotGridItemsProducer.AddData(AItem: TcxPivotGridGroupItem;
  ALevel: Integer; AParent: TcxPivotGridViewDataItem): Boolean;
var
  I, J: Integer;
  ADataItem: TcxPivotGridViewDataItem;
  V: Variant;
begin
  Result := (ALevel = DataLevel) or (AItem.IsCollapsed and (DataLevel <> MaxInt) and (DataLevel > ALevel));
  if Result then
  begin
    for I := 0 to DataFields.ItemCount - 1 do
    begin
      if SkipFieldProcessing(AParent, DataFields.Items[I].Field) then Continue;
      ADataItem := AParent.Add(DataFields.Items[I]);
      ADataItem.FIsDataField := True;
      V := ADataItem.Value;
      if AItem.Expanded and not AParent.IsTotal then
        for J := 0 to AItem.ItemCount - 1 do
          ProcessItem(AItem.Items[J], ALevel + 1, ADataItem)
      else
        InitVisibleItem(ADataItem);
    end;
  end;
end;

procedure TcxPivotGridItemsProducer.AddTotals(AItem: TcxPivotGridGroupItem;
  ALevel: Integer; AParent: TcxPivotGridViewDataItem);
var
  I: Integer;
  ATotal: TcxPivotGridViewDataItem;
begin
  if ((ALevel = -1) and TotalNeeded(GrandTotals, GrandTotalsForSingleValues, AItem)) or
    ((ALevel >= 0) and TotalNeeded(Totals, TotalsForSingleValues, AItem)) then
  begin
    for I := 0 to AItem.TotalsCount - 1 do
    begin
      ATotal := AParent.AddTotal(AItem, I);
      if (DataLevel <> MaxInt) and (ALevel < DataLevel) then
        AddData(AItem, DataLevel, ATotal)
      else
        InitVisibleItem(ATotal);
    end;
  end;
end;

procedure TcxPivotGridItemsProducer.DeleteEmptyItems;

  procedure ProcessItems(AItem: TcxPivotGridViewDataItem);
  var
    I: Integer;
  begin
    if (AItem.ItemCount = 0) and (AItem.VisibleIndex < 0) then
    begin
      if AItem.Parent <> nil then
        AItem.Parent.FItems.Remove(AItem);
      AItem.Free;
    end
    else
    begin
      for I := AItem.ItemCount - 1 downto 0 do
        ProcessItems(AItem.Items[I]);
      for I := 0 to AItem.ItemCount - 1 do
        AItem.Items[I].FIndex := I;
    end;
  end;

begin
  ProcessItems(Dest);
end;

function TcxPivotGridItemsProducer.IsVariationFieldsOnly;
var
  I: Integer;
begin
  Result := DataFields <> nil;
  if Result then
    for I := 0 to DataFields.ItemCount - 1 do
      Result := Result and DataFields.Items[I].Field.HasSummaryVariation;
end;

procedure TcxPivotGridItemsProducer.InitVisibleItem(
  AItem: TcxPivotGridViewDataItem);
begin
  AItem.FVisibleIndex := DestList.Count;
  DestList.Add(AItem);
end;

procedure TcxPivotGridItemsProducer.ProcessItem(AItem: TcxPivotGridGroupItem;
  ALevel: Integer; AParent: TcxPivotGridViewDataItem);
begin
  if TotalsLocation = tlNear then
  begin
    AddTotals(AItem, ALevel, AParent);
    AddChildren(AItem, ALevel, AParent);
  end
  else
  begin
    AddChildren(AItem, ALevel, AParent);
    AddTotals(AItem, ALevel, AParent);
  end;
end;

procedure TcxPivotGridItemsProducer.Produce;
begin
  Dest.DeleteChildren;
  VariationFieldsOnly := IsVariationFieldsOnly;
  ProcessItem(Source, -1, Dest);
  DeleteEmptyItems;
end;

function TcxPivotGridItemsProducer.SkipFieldProcessing(
  AParent: TcxPivotGridViewDataItem; AField: TcxPivotGridField): Boolean;
begin
  Result := (AField.SummaryVariation in [svAbsolute, svPercent]) and
    (AParent.IsGrandTotal or (AParent.Index = 0) or ((AParent.Index = 1) and AParent.IsTotal));
  if Result and AParent.IsGrandTotal then
    Result := (Source.ItemCount > 0) or not VariationFieldsOnly;
  Result := Result or (not AParent.IsGrandTotal and (AField.DataVisibility = dvGrandTotalCells)) or
    (AParent.IsGrandTotal and (AField.DataVisibility = dvCrossAndTotalCells));
end;

function TcxPivotGridItemsProducer.TotalNeeded(
  AVisible, ASingleVisible: Boolean; AItem: TcxPivotGridGroupItem): Boolean;
begin
  Result := AVisible and AItem.Expanded and (AItem.ItemCount > 0) and
    (ASingleVisible or (AItem.ItemCount > 1));
  if not Result then
    Result := (AItem.Level = -1) and (AItem.ItemCount = 0);
end;

procedure TcxPivotGridViewData.PopulateSelectedCells(ACells: TList);
var
  ACol, ARow: Integer;
begin
  for ACol := 0 to ColumnCount - 1 do
    for ARow := 0 to RowCount - 1 do
      if IsCellSelected(ARow, ACol) then
        ACells.Add(Cells[ARow, ACol].Owner);
end;

procedure TcxPivotGridViewData.ProduceColumns;
var
  AProducer: TcxPivotGridItemsProducer;
begin
  with OptionsView do
  begin
    AProducer := TcxPivotGridItemsProducer.Create(DataBuilder.Columns, FColumns, FColumnsList,
      ColumnTotalsLocation, ColumnTotals, TotalsForSingleValues,
      ColumnGrandTotals, GrandTotalsForSingleValues);
  end;
  try
    CalculateDataFieldInfo(AProducer.DataLevel, AProducer.DataFields, dfaColumn);
    AProducer.Produce;
  finally
    AProducer.Free;
  end;
end;

procedure TcxPivotGridViewData.ProduceRows;
var
  AProducer: TcxPivotGridItemsProducer;
begin
  with OptionsView do
  begin
    AProducer := TcxPivotGridItemsProducer.Create(DataBuilder.Rows, FRows, FRowsList,
      RowTotalsLocation, RowTotals, TotalsForSingleValues,
      RowGrandTotals, GrandTotalsForSingleValues);
  end;
  try
    CalculateDataFieldInfo(AProducer.DataLevel, AProducer.DataFields, dfaRow);
    AProducer.Produce;
  finally
    AProducer.Free;
  end;
end;

procedure TcxPivotGridViewData.Scroll(
  AScrollCode: TScrollCode; AItem: TcxPivotGridViewDataItem;
  APage, AMax, ASize, AScrollPos: Integer; var APos: Integer);
begin
  case AScrollCode of
    scLineUp, scLineDown:
      Inc(APos, Byte(AScrollCode) * 2 - 1);
    scPageUp:
      while ASize > 0 do
      begin
        AItem := AItem.GetPrevVisible;
        if AItem = nil then Break;
        Dec(ASize, AItem.Size);
        if ASize >= 0 then
          Dec(APos);
      end;
    scPosition:
      APos := AScrollPos;
    scPageDown:
      Inc(APos, APage);
    scTop:
      APos := 0;
    scBottom:
      APos := AMax;
  end;
  APos := Max(0, Min(APos, AMax));
end;

function TcxPivotGridViewData.ScrollColumns(
  AScrollCode: TScrollCode; var AScrollPos: Integer): Boolean;
var
  APos: Integer;
begin
  APos := FColumnIndex;
  Scroll(AScrollCode, Columns[ColumnIndex], ColumnsPerPage, ColumnCount - 1,
    cxRectWidth(PivotGrid.ViewInfo.DataCellsBounds), AScrollPos, FColumnIndex);
  PivotGrid.ViewInfo.Calculate;
  AScrollPos := FColumnIndex;
  Result := FColumnIndex <> APos;
end;

function TcxPivotGridViewData.ScrollRows(
  AScrollCode: TScrollCode; var AScrollPos: Integer): Boolean;
var
  APos: Integer;
begin
  APos := FRowIndex;
  Scroll(AScrollCode, Rows[RowIndex], RowsPerPage, RowCount - 1,
    cxRectHeight(PivotGrid.ViewInfo.DataCellsBounds), AScrollPos, FRowIndex);
  PivotGrid.ViewInfo.Calculate;
  AScrollPos := FRowIndex;
  Result := FRowIndex <> APos;
end;

procedure TcxPivotGridViewData.ValidateIndexes;
begin
  if FColumnIndex >= ColumnCount then
    FColumnIndex := ColumnCount - 1;
  if FRowIndex >= RowCount then
    FRowIndex := RowCount - 1;
end;

procedure TcxPivotGridViewData.ValidateSelection(var ASelection: TRect);
begin
  cxRectAdjust(ASelection);
  ASelection.Left := Min(Max(0, ASelection.Left), ColumnCount - 1);
  ASelection.Top := Min(Max(0, ASelection.Top), RowCount - 1);
  if OptionsSelection.MultiSelect then
  begin
    ASelection.Right := Min(Max(0, ASelection.Right), ColumnCount - 1);
    ASelection.Bottom := Min(Max(0, ASelection.Bottom), RowCount - 1);
  end
  else
    ASelection.BottomRight := ASelection.TopLeft;
end;

function TcxPivotGridViewData.GetAnchorCells: TRect;
begin
  Result := Selection.AnchorCells;
end;

function TcxPivotGridViewData.GetCell(
  ARow, AColumn: Integer): TcxPivotGridCrossCellSummary;
var
  ADataField: TcxPivotGridField;
  ACrossCell: TcxPivotGridCrossCell;
  ARowGroup, AColGroup: TcxPivotGridGroupItem;
begin
  ADataField := nil;
  ARowGroup := Rows[ARow].GetGroupItem(ADataField);
  AColGroup := Columns[AColumn].GetGroupItem(ADataField);
  if DataBuilder.DataFields.Count = 1 then
    ADataField := DataBuilder.DataFields[0];
  if (ADataField = nil) and (DataBuilder.DataFields.Count > 0)  then
    ADataField := DataBuilder.DataFields[0];
  ACrossCell := ARowGroup.GetCellByCrossItem(AColGroup);
  if ADataField = nil then
    Result := nil
  else
    Result := ACrossCell.SummaryCells[ADataField.SummaryIndex];
end;

function TcxPivotGridViewData.GetCellAsText(ARow, AColumn: Integer): string;
var
  AField: TcxPivotGridField;
  AFakeCell: TcxPivotGridDataCellViewInfo;
  ARowItem, AColumnItem: TcxPivotGridViewDataItem;
begin
  Result := '';
  ARowItem := Rows[ARow];
  AColumnItem := Columns[AColumn];
  if PivotGrid.OptionsDataField.Area = dfaRow then
    AField := PivotGrid.ViewInfo.GetDataFieldFromViewData(ARowItem)
  else
    AField := PivotGrid.ViewInfo.GetDataFieldFromViewData(AColumnItem);
  AFakeCell := TcxPivotGridDataCellViewInfo.Create(PivotGrid.LookAndFeelPainter,
    cxSimpleRect, cxSimpleRect, PivotGrid.ViewInfo.FViewParams);
  try
    AFakeCell.Initialize(ARowItem, AColumnItem, AField);
    AFakeCell.CalculateVisibleInfo;
    Result := AFakeCell.DisplayText;
  finally
    AFakeCell.Free;
  end;
end;

function TcxPivotGridViewData.GetColumn(
  AIndex: Integer): TcxPivotGridViewDataItem;
begin
  if not PivotGrid.ViewInfo.IsPrinting then
    PivotGrid.CheckChanges;
  Result := FColumnsList[AIndex];
end;

function TcxPivotGridViewData.GetColumnCount: Integer;
begin
  Result := FColumnsList.Count;
end;

function TcxPivotGridViewData.GetDataBuilder: TcxPivotGridDataBuilder;
begin
  Result := PivotGrid.DataBuilder;
end;

function TcxPivotGridViewData.GetFocusedCell: TPoint;
begin
  Result := Selection.FFocusedCell;
end;

function TcxPivotGridViewData.GetOptionsSelection: TcxPivotGridOptionsSelection;
begin
  Result := PivotGrid.OptionsSelection;
end;

function TcxPivotGridViewData.GetOptionsView: TcxPivotGridOptionsView;
begin
  Result := PivotGrid.OptionsView;
end;

function TcxPivotGridViewData.GetRow(
  AIndex: Integer): TcxPivotGridViewDataItem;
begin
  if not PivotGrid.ViewInfo.IsPrinting then
    PivotGrid.CheckChanges;
  Result := FRowsList[AIndex];
end;

function TcxPivotGridViewData.GetRowCount: Integer;
begin
  Result := FRowsList.Count;
end;

function TcxPivotGridViewData.NeedCalculateLimitValues: Boolean;

  function NeedCalculateLimitValuesForStyles(AStyles: TcxPivotGridCustomStyles): Boolean;
  begin
    with AStyles do
      Result := Assigned(OnGetContentStyle) or (ColumnMaximumValue <> nil) or
        (ColumnMinimumValue <> nil) or (RowMaximumValue <> nil) or (RowMinimumValue <> nil) or
        (MaximumValue <> nil) or (MinimumValue <> nil);
  end;

var
  I: Integer;
begin
  Result := not FCalculatedLimitValues and (ColumnCount > 0) and (RowCount > 0) and (DataBuilder.DataFields.Count > 0);
  if Result then
  begin
    Result := NeedCalculateLimitValuesForStyles(PivotGrid.Styles) or Assigned(PivotGrid.OnCustomDrawCell);
    if not Result then
      for I := 0 to DataBuilder.DataFields.Count - 1 do
      begin
        Result := NeedCalculateLimitValuesForStyles(DataBuilder.DataFields[I].Styles);
        if Result then
          Break;
      end;
  end;
end;

procedure TcxPivotGridViewData.SetAnchorCells(const AValue: TRect);
begin
  Selection.AnchorCells := AValue;
end;

procedure TcxPivotGridViewData.SetColumnIndex(AIndex: Integer);
begin
  AIndex := Min(ColumnCount - 1, Max(0, AIndex));
  if AIndex <>  FColumnIndex then
  begin
    FColumnIndex := AIndex;
    PivotGrid.ViewChanged;
  end;
end;

procedure TcxPivotGridViewData.SetFocusedCell(const APoint: TPoint);
begin
  Selection.FocusedCell := AdjustCellIndexesPoint(APoint);
end;

procedure TcxPivotGridViewData.SetRowIndex(AIndex: Integer);
begin
  AIndex := Min(RowCount - 1, Max(0, AIndex));
  if AIndex <>  FRowIndex then
  begin
    FRowIndex := AIndex;
    PivotGrid.ViewChanged;
  end;
end;

{ TcxPivotGridCustomCellViewInfo }

constructor TcxPivotGridCustomCellViewInfo.Create(APainter: TcxCustomLookAndFeelPainterClass;
  const ABounds, AVisibleRect: TRect; const AViewParams: TcxViewParams);
begin
  CalculateCellBounds(ABounds, AVisibleRect);
  FPainter := APainter;
  FViewParams := AViewParams;
end;

procedure TcxPivotGridCustomCellViewInfo.CheckVisibleInfo;
begin
  if Visible and not FVisibleInfoCalculated then
  begin
    CalculateVisibleInfo;
    FVisibleInfoCalculated := True;
  end;
end;

procedure TcxPivotGridCustomCellViewInfo.Draw(ACanvas: TcxCanvas);
var
  FPrevCanvas: TcxCanvas;
begin
  FPrevCanvas := FCanvas;
  try
    FCanvas := ACanvas;
    CheckVisibleInfo;
    DoDraw;
  finally
    FCanvas := FPrevCanvas;
  end;
end;

procedure TcxPivotGridCustomCellViewInfo.AfterCustomDraw(ACanvas: TcxCanvas);
begin
  Color := ACanvas.Brush.Color;
  TextColor := ACanvas.Font.Color;
end;

procedure TcxPivotGridCustomCellViewInfo.BeforeCustomDraw(ACanvas: TcxCanvas);
begin
  ACanvas.SetParams(FViewParams);
end;

procedure TcxPivotGridCustomCellViewInfo.CalculateCellBounds(
  const ABounds, AVisibleRect: TRect);
begin
  FBounds := ABounds;
  FVisible := cxRectIntersect(FClipRect, ABounds, AVisibleRect);
  FHasClipping := FVisible and not cxRectIsEqual(FClipRect, ABounds);
end;

procedure TcxPivotGridCustomCellViewInfo.CalculateVisibleInfo;
begin
end;

function TcxPivotGridCustomCellViewInfo.CheckClipping(
  ANeedClip: Boolean): Boolean;
begin
  Result := ANeedClip;
  FHasClipping := FHasClipping or ANeedClip;
end;

procedure TcxPivotGridCustomCellViewInfo.CorrectBoundsForPrinting(ABounds: TRect);
begin
//do nothing
end;

procedure TcxPivotGridCustomCellViewInfo.DoDraw;
begin
  if not Transparent then
    Canvas.FillRect(ClipRect, FViewParams);
end;

function TcxPivotGridCustomCellViewInfo.ExcludeBorders(
  const ABounds: TRect; ABorders: TcxBorders): TRect;
begin
  Result := ABounds;
  if bLeft in ABorders then Inc(Result.Left);
  if bTop in ABorders then Inc(Result.Top);
  if bRight in ABorders then Dec(Result.Right);
  if bBottom in ABorders then Dec(Result.Bottom);
end;

function TcxPivotGridCustomCellViewInfo.ExcludeFromPaint(
  ACanvas: TcxCanvas): Boolean;
begin
  Result := Visible;
  if Result then
    ACanvas.ExcludeClipRect(ClipRect);
end;

function TcxPivotGridCustomCellViewInfo.GetHintText: string;
begin
  Result := DisplayText;
end;

function TcxPivotGridCustomCellViewInfo.GetHitTest(
  AHitTest: TcxPivotGridHitTest): Boolean;
begin
  CheckVisibleInfo;
  Result := Visible and PtInRect(ClipRect, AHitTest.HitPoint);
  if Result then
    AHitTest.FHitObject := Self;
end;

function TcxPivotGridCustomCellViewInfo.GetDisplayText: string;
begin
  Result := FDisplayText;
end;

function TcxPivotGridCustomCellViewInfo.NeedShowHint(const APoint: TPoint): Boolean;
begin
  Result := False;
end;

function TcxPivotGridCustomCellViewInfo.SetHotTrack(AHitTest: TcxPivotGridHitTest): Boolean;
begin
  Result := False;
end;

function TcxPivotGridCustomCellViewInfo.GetBitmap: TBitmap;
begin
  Result := FViewParams.Bitmap;
end;

function TcxPivotGridCustomCellViewInfo.GetColor: TColor;
begin
  Result := FViewParams.Color;
end;

function TcxPivotGridCustomCellViewInfo.GetFont: TFont;
begin
  Result := FViewParams.Font;
end;

function TcxPivotGridCustomCellViewInfo.GetTextColor: TColor;
begin
  Result := FViewParams.TextColor;
end;

procedure TcxPivotGridCustomCellViewInfo.SetBitmap(AValue: TBitmap);
begin
  FViewParams.Bitmap := AValue;
end;

procedure TcxPivotGridCustomCellViewInfo.SetColor(AValue: TColor);
begin
  FViewParams.Color := AValue;
end;

procedure TcxPivotGridCustomCellViewInfo.SetTextColor(AValue: TColor);
begin
  FViewParams.TextColor := AValue;
end;

{ TcxPivotGridEditContainerViewInfo }

destructor TcxPivotGridEditContainerViewInfo.Destroy;
begin
  FProperties := nil;
  FreeAndNil(FEditViewInfo);
  ReleaseEditStyle;
  inherited;
end;

procedure TcxPivotGridEditContainerViewInfo.InitEditStyle;
begin
  if FEditStyle = nil then
    FEditStyle := FDataField.GetEditStyle(FProperties, FUseLocalEditStyle);
  FEditStyle.Color := Color;
  FEditStyle.Font := Font;
  FEditStyle.StyleData.FontColor := TextColor;
  FEditStyle.ButtonTransparency := ebtHideInactive;
end;

procedure TcxPivotGridEditContainerViewInfo.CalculateEditViewInfo(AEditViewInfo: TcxCustomEditViewInfo;
  const AMousePos: TPoint);
begin
  if FCalculated then
    Exit;
  InitEditStyle;
  CreateEditViewData;
  try
    FEditViewData.Data := Self;
    if OnGetDisplayTextSupported then
      FEditViewData.OnGetDisplayText := FDataField.EditViewDataGetDisplayTextHandler;
    FEditViewData.PaintOptions := [];
    if FShowEndEllipsis then
      Include(FEditViewData.PaintOptions, epoShowEndEllipsis);
    if FMultiline then
      Include(FEditViewData.PaintOptions, epoAutoHeight);
    AEditViewInfo.Transparent := True;
    FEditViewData.EditValueToDrawValue(Canvas, FValue, AEditViewInfo);
    FEditViewData.ContentOffset := cxRect(1, 1, 1, 1);
    FEditViewData.Calculate(Canvas, cxRectInflate(FTextBounds, cxTextOffset, cxTextOffset), AMousePos, cxmbNone, [], AEditViewInfo, True);
    FEditViewData.OnGetDisplayText := nil;
    FEditViewData.Data := nil;
  finally
    DestroyEditViewData;
  end;
  FCalculated := True;
end;

procedure TcxPivotGridEditContainerViewInfo.CalculateVisibleInfo;
begin
  FTextBounds := cxTextRect(ExcludeBorders(Bounds, Borders));
end;

function TcxPivotGridEditContainerViewInfo.CreateEditViewInfo: TcxCustomEditViewInfo;
begin
  Result := FProperties.GetViewInfoClass.Create as TcxCustomEditViewInfo;
end;

procedure TcxPivotGridEditContainerViewInfo.CreateEditViewData;
begin
  if FUseLocalViewData then
    FEditViewData := FProperties.CreateViewData(FEditStyle, True)
  else
    FEditViewData := FDataField.GetEditViewData;
end;

procedure TcxPivotGridEditContainerViewInfo.DestroyEditViewData;
begin
  if FUseLocalViewData then
    FEditViewData.Free;
  FEditViewData := nil;
end;

procedure TcxPivotGridEditContainerViewInfo.DrawUsingEditProperties;
begin
  CalculateEditViewInfo(FEditViewInfo, cxNullPoint);
  FEditViewInfo.Paint(Canvas);
end;

function TcxPivotGridEditContainerViewInfo.GetDisplayText: string;
begin
  if FProperties <> nil then
    Result := FProperties.GetDisplayText(FValue)
  else
    Result := inherited GetDisplayText;
end;

procedure TcxPivotGridEditContainerViewInfo.InitializeProperties;
begin
  if UseEditProperties then
    FProperties := FDataField.DoGetProperties(Self);
  if FProperties <> nil then
  begin
    FUseLocalViewData := FProperties <> FDataField.GetUserEditProperties;
    FUseLocalEditStyle := not FDataField.UseEditProperties or
      (FProperties.GetStyleClass <> FDataField.GetEditStyle(FProperties, False).ClassType);
    if FEditViewInfo = nil then
      FEditViewInfo := CreateEditViewInfo;
  end;
end;

function TcxPivotGridEditContainerViewInfo.OnGetDisplayTextSupported: Boolean;
begin
  Result := False;
end;

procedure TcxPivotGridEditContainerViewInfo.ReleaseEditStyle;
begin
  if FUseLocalEditStyle then
    FEditStyle.Free;
  FEditStyle := nil;
end;

function TcxPivotGridEditContainerViewInfo.UseEditProperties: Boolean;
begin
  Result := (FDataField <> nil);
end;

{ TcxPivotGridHeaderCellViewInfo }

constructor TcxPivotGridHeaderCellViewInfo.Create(
  APainter: TcxCustomLookAndFeelPainterClass; const ABounds, AVisibleRect: TRect;
  const AViewParams: TcxViewParams; const ADisplayText: string);
begin
  inherited Create(APainter, ABounds, AVisibleRect, AViewParams);
  FDisplayText := ADisplayText;
  FBorders := cxBordersAll;
  FAlignVert := vaCenter;
  FShowEndEllipsis := True;
end;

function TcxPivotGridHeaderCellViewInfo.GetDisplayText: string;
begin
  Result := inherited GetDisplayText;
  if (FProperties <> nil) and (Data is TcxPivotGridViewDataTotalItem) then
    Result := Format(TcxPivotGridViewDataTotalItem(Data).GetDescription, [Result])
end;

procedure TcxPivotGridHeaderCellViewInfo.CalculateImageInfo;
var
  R: TRect;
begin
  if (ImageIndex = -1) or (Images = nil) or (ImageIndex >= Images.Count) then Exit;
  FImageRect := cxRectCenter(FTextBounds, Images.Width, Images.Height);
  FImageRect := cxRectSetTop(FImageRect, Bounds.Top + cxTextOffset);
  case ImageAlignHorz of
    taLeftJustify:
    begin
      FImageRect := cxRectSetLeft(FImageRect, TextBounds.Left);
      FTextBounds.Left := FImageRect.Right + cxTextOffset + 1;
    end;
    taRightJustify:
    begin
      FImageRect := cxRectSetRight(FImageRect, TextBounds.Right);
      FTextBounds.Right := FImageRect.Left - cxTextOffset + 1;
    end;
  end;
  case ImageAlignVert of
    vaBottom:
      FImageRect := cxRectSetBottom(FImageRect, Bounds.Bottom - cxTextOffset);
    vaCenter:
      FImageRect := cxRectSetTop(FImageRect, (Bounds.Top + Bounds.Bottom - Images.Height) div 2);
  end;
  IntersectRect(R, FImageRect, Bounds);
  CheckClipping(not EqualRect(R, FImageRect));
end;

procedure TcxPivotGridHeaderCellViewInfo.CalculateSortingInfo;
var
  ASize: TPoint;
begin
  if FSortOrder = soNone then Exit;
  ASize := Painter.SortingMarkAreaSize;
  with FSortMarkBounds do
  begin
    Right := FTextBounds.Right;
    Top := (FTextBounds.Bottom + FTextBounds.Top - ASize.Y) div 2;
    Left := Right - ASize.X;
    Bottom := Top + ASize.Y;
    CheckClipping(Left < Bounds.Left);
  end;
  FTextBounds.Right := FSortMarkBounds.Left;
end;

procedure TcxPivotGridHeaderCellViewInfo.CalculateVisibleInfo;
begin
  FBorders := Painter.HeaderBorders(Neighbors);
  inherited CalculateVisibleInfo;
  if HasButton then
  begin
    with Painter do
    begin
      FButtonRect := cxRectSetSize(FTextBounds, ExpandButtonSize, ExpandButtonSize);
      OffsetRect(FButtonRect, 1, 1);
    end;
    CheckClipping(Bounds.Right - FButtonRect.Right <  cxPivotGridDoubleSpace);
    FTextBounds.Left := FButtonRect.Right + cxTextOffset;
  end;
  CalculateSortingInfo;
  CalculateImageInfo;
  // for top/left border scrolled group item
  FBounds.TopLeft := ClipRect.TopLeft;
end;

function TcxPivotGridHeaderCellViewInfo.CanDrawBackgroundFirst: Boolean;
begin
  Result := False;
end;

procedure TcxPivotGridHeaderCellViewInfo.CheckSizingArea(
  AHitTest: TcxPivotGridHitTest);
var
  R: TRect;
begin
  with ClipRect do
  begin
    R := Rect(Right - cxPivotGridSizeAreaDelta, Top,
      Right + cxPivotGridSizeAreaDelta, Bottom);
  end;
  if (FSizeField <> nil) and Visible and PtInRect(R, AHitTest.HitPoint) then
  begin
    AHitTest.SetBitState(htcHorzSizingEdge, Supports(FSizeField,
      IcxPivotGridSizableObject, AHitTest.FResizeField));
    if (AHitTest.FResizeField <> nil) and not AHitTest.FResizeField.CanResize then
    begin
      AHitTest.FResizeField := nil;
      AHitTest.SetBitState(htcHorzSizingEdge, False);
    end;
    AHitTest.FResizeFieldStartPos := Bounds.Right;
  end
end;

function TcxPivotGridHeaderCellViewInfo.DrawBackgroundProc(
  ACanvas: TcxCanvas; const ABounds: TRect): Boolean;
begin
  Result := (Bitmap <> nil) and not Bitmap.Empty;
  if Result and not Transparent then
    ACanvas.FillRect(ABounds, Bitmap)
  else
    Result := Transparent;
end;

procedure TcxPivotGridHeaderCellViewInfo.DoDraw;
var
  R: TRect;
  AClipRgn: TcxRegion;
begin
  if not Painter.HeaderDrawCellsFirst and CanDrawBackgroundFirst then
  begin
    R := ClipRect;
    if Background = nil then
      Painter.DrawGroupByBox(Canvas, R, Transparent, clDefault, nil)
    else
    begin
      AClipRgn := Canvas.GetClipRegion();
      Canvas.IntersectClipRect(R);
      Background.Draw(Canvas);
      Canvas.SetClipRegion(AClipRgn, roSet);
    end;
  end;

  Painter.DrawHeader(Canvas, Bounds, TextBounds, Neighbors, Borders, State,
    AlignHorz, AlignVert, MultiLine, ShowEndEllipsis, '', Canvas.Font,
    TextColor, Color, DrawBackgroundProc, GetIsLast, IsSingle);

  DrawHeaderText;
  if HasButton then
    Painter.DrawExpandButton(Canvas, ButtonRect, Expanded);
  if SortOrder <> soNone then
    Painter.DrawSortingMark(Canvas, SortMarkBounds, SortOrder = soAscending);
  if (Images <> nil) and (ImageIndex <> -1) then
    Canvas.DrawImage(Images, ImageRect.Left, ImageRect.Top, ImageIndex);
end;

procedure TcxPivotGridHeaderCellViewInfo.DrawHeaderText;

  procedure InternalDrawHeaderText;
  const
    MultiLines: array[Boolean] of Integer = (cxSingleLine, cxWordBreak);
    ShowEndEllipsises: array[Boolean] of Integer = (0, cxShowEndEllipsis);
  begin
    if DisplayText <> '' then
    begin
      Canvas.Brush.Style := bsClear;
      Canvas.Font := Font;
      Canvas.Font.Color := TextColor;
      Canvas.DrawText(DisplayText, TextBounds, cxAlignmentsHorz[AlignHorz] or
        cxAlignmentsVert[AlignVert] or MultiLines[MultiLine] or ShowEndEllipsises[ShowEndEllipsis]);
      Canvas.Brush.Style := bsSolid;
    end;
  end;

begin
  if (FProperties = nil) or (Data is TcxPivotGridViewDataTotalItem ) then
    InternalDrawHeaderText
  else
    DrawUsingEditProperties;
end;

function TcxPivotGridHeaderCellViewInfo.GetHitTest(
  AHitTest: TcxPivotGridHitTest): Boolean;
begin
  Result := inherited GetHitTest(AHitTest);
  CheckSizingArea(AHitTest);
  if Result then
  begin
    AHitTest.SetBitState(htcGroupHeader, True);
    if HasButton and PtInRect(ButtonRect, AHitTest.HitPoint) then
      AHitTest.SetBitState(htcButton, True);
    if Data is TcxPivotGridViewDataItem then
      AHitTest.FField := TcxPivotGridViewDataItem(Data).Field;
  end;
end;

function TcxPivotGridHeaderCellViewInfo.GetIsLast: Boolean;
begin
  Result := False; //not (nRight in Neighbors);
end;

function TcxPivotGridHeaderCellViewInfo.IsSingle: Boolean;
begin
  Result := False;
end;

function TcxPivotGridHeaderCellViewInfo.NeedShowHint(const APoint: TPoint): Boolean;
begin
  Result := (not HasButton or (APoint.X > ButtonRect.Right)) and
    (cxTextWidth(Font, HintText) > cxRectWidth(TextBounds));
end;

function TcxPivotGridHeaderCellViewInfo.UseEditProperties: Boolean;
begin
  Result := inherited UseEditProperties and
    (FDataField.GroupInterval = giDefault) and
    (FDataField.FArea <> faData);
end;

procedure TcxPivotGridHeaderCellViewInfo.SetData(AValue: TObject);
begin
  FData := AValue;
  if FData is TcxPivotGridViewDataItem then
  begin
    FDataField := TcxPivotGridViewDataItem(FData).Field;
    FValue := TcxPivotGridViewDataItem(FData).GroupItem.Value;
    InitializeProperties;
  end;
end;

{ TcxPivotGridFieldHeaderCellViewInfo }

constructor TcxPivotGridFieldHeaderCellViewInfo.CreateEx(AOwner: TPersistent);
begin
  FField := AOwner;
  FGroup := nil;
end;

procedure TcxPivotGridFieldHeaderCellViewInfo.Initialize(
  ACanvas: TcxCanvas; APainter: TcxCustomLookAndFeelPainterClass;
  const AViewParams: TcxViewParams);

  procedure AssignFieldProperties(AField: TcxPivotGridField);
  const
    ASortOrders: array[TcxDataSortOrder] of TcxDataSortOrder =
      (soAscending, soAscending, soDescending);
  begin
    FField := AField;
    FViewParams := AViewParams;
    FExpanded := AField.GroupExpanded;
    FImageAlignHorz := AField.ImageAlign;
    FImageIndex := AField.ImageIndex;
    FImages := AField.PivotGrid.FieldHeaderImages;
    FFocused := GetFocused;
    FGroup := AField.Group;
    FHasButton := (FGroup <> nil) and not FGroup.IsLastVisibleField(AField);
    FExpanded := HasButton and AField.GroupExpanded;
    if not AField.Visible and (Group <> nil) then
      FDisplayText := Group.Caption
    else
      FDisplayText := AField.Caption;
    if AField.Options.CanFiltering  then
    begin
      FFilterState := cxbsNormal;
      FFilterActive := AField.Filter.HasFilter;
    end;
    if AField.Options.CanSorting then
      FSortOrder := ASortOrders[AField.SortOrder];
  end;

begin
  FImages := nil;
  FImageAlignHorz := taLeftJustify;
  FImageIndex := -1;
  FCanvas := ACanvas;
  FVisible := False;
  FPainter := APainter;
  FViewParams := AViewParams;
  FSortOrder := soNone;
  FState := cxbsNormal;
  FFilterActive := False;
  FFilterState := cxbsDisabled;
  FAreaIndex := -1;
  FFocused := False;
  if FField is TcxPivotGridField then
    AssignFieldProperties(Field as TcxPivotGridField)
  else
    FDisplayText := TcxPivotGridOptionsDataField(Field).Caption;
  Transparent := False;
end;

function TcxPivotGridFieldHeaderCellViewInfo.MeasureHeight: Integer;
begin
  Result := Painter.HeaderHeight(cxTextHeight(FViewParams.Font));
  if SortOrder <> soNone then
    Result := Max(Result, Painter.SortingMarkAreaSize.X);
  if FFilterState = cxbsNormal then
    Result := Max(Result, Painter.FilterDropDownButtonSize.Y + cxPivotGridDoubleSpace);
end;

function TcxPivotGridFieldHeaderCellViewInfo.MeasureWidth: Integer;
begin
  Result := cxTextWidth(Font, DisplayText);
  if Result > 0 then
     Inc(Result, cxPivotGridDoubleSpace);
  if SortOrder <> soNone then
    Inc(Result, Painter.SortingMarkAreaSize.X);
  if FFilterState = cxbsNormal then
    Inc(Result, Painter.FilterDropDownButtonSize.X + cxTextOffset);
  if HasButton then
    Inc(Result, Painter.ExpandButtonSize + cxPivotGridDoubleSpace);
  if (Images <> nil) and (ImageIndex >= 0) and (ImageIndex < Images.Count) then
    if ImageAlignHorz <> taCenter then Inc(Result, Images.Width + cxPivotGridDoubleSpace);
  Inc(Result, cxPivotGridHorzSpace * 2);
end;

procedure TcxPivotGridFieldHeaderCellViewInfo.SetBounds(
  const ABounds, AClipRect: TRect);
begin
  FVisibleInfoCalculated := False;
  CalculateCellBounds(ABounds,  AClipRect);
end;

procedure TcxPivotGridFieldHeaderCellViewInfo.PaintTo(
  ACanvas: TcxCanvas; const ABounds: TRect; AState: TcxButtonState;
  AHandler: TcxPivotGridCustomDrawEvent);
var
  ADone: Boolean;
  APrevState: TcxButtonState;
  APrevClipRect, APrevBounds: TRect;
begin
  APrevBounds := Bounds;
  APrevState := State;
  FVisibleInfoCalculated := False;
  APrevClipRect := ClipRect;
  try
    FBounds := ABounds;
    FClipRect := ABounds;
    FState := AState;
    BeforeCustomDraw(ACanvas);
    AHandler(ACanvas, Self, ADone);
    AfterCustomDraw(ACanvas);
    if not ADone then
      Draw(ACanvas);
  finally
    FState := APrevState;
    FClipRect := APrevClipRect;
    FBounds := APrevBounds;
    Transparent := False;
    FVisibleInfoCalculated := False;
  end;
end;

procedure TcxPivotGridFieldHeaderCellViewInfo.CalculateFilterInfo;
var
  ASize: TPoint;
begin
  if FFilterState = cxbsDisabled then Exit;
  ASize := Painter.FilterDropDownButtonSize;
  FFilterBounds := FTextBounds;
  with FFilterBounds do
    Left := Right - ASize.X;
  FTextBounds.Right := FFilterBounds.Left - cxTextOffset;
  CheckClipping(FFilterBounds.Left < Bounds.Left);
end;

procedure TcxPivotGridFieldHeaderCellViewInfo.CalculateSortingInfo;
begin
  CalculateFilterInfo;
  inherited CalculateSortingInfo;
end;

function TcxPivotGridFieldHeaderCellViewInfo.CanDrawBackgroundFirst: Boolean;
begin
  Result := True;
end;

procedure TcxPivotGridFieldHeaderCellViewInfo.DoDraw;
var
  R: TRect;
begin
  inherited DoDraw;
  if FilterState <> cxbsDisabled then
    Painter.DrawFilterDropDownButton(Canvas, FilterBounds, FilterState, FFilterActive);
  if HasButton and Expanded then
  begin
    Canvas.Brush.Color := clBtnText;
    with Bounds do
      Canvas.FillRect(Rect(Right, (Top + Bottom) div 2,
        Right + cxPivotGridHorzSpace, (Top + Bottom) div 2 + 1), nil);
  end;
  if State = cxbsPressed then
    Painter.DrawHeaderPressed(Canvas, Bounds)
  else
    if Focused then
    begin
      R := ExcludeBorders(Bounds, Borders);
      Canvas.DrawFocusRect(R);
      Canvas.DrawFocusRect(cxRectInflate(R, -1, -1));
    end;
end;

function TcxPivotGridFieldHeaderCellViewInfo.ExcludeFromPaint(
  ACanvas: TcxCanvas): Boolean;
begin
  Result := inherited ExcludeFromPaint(ACanvas);
  if Result and Expanded then
    with Bounds do
    begin
      ACanvas.ExcludeClipRect(Rect(Right, (Top + Bottom) div 2,
        Right + cxPivotGridHorzSpace, (Top + Bottom) div 2 + 1));
    end;
end;

function TcxPivotGridFieldHeaderCellViewInfo.GetHitTest(
  AHitTest: TcxPivotGridHitTest): Boolean;
begin
  Result := inherited GetHitTest(AHitTest);
  if Result then
  begin
    AHitTest.FField := FField;
    AHitTest.SetBitState(htcGroupHeader, False);
    if Field <> nil then
      AHitTest.SetBitState(htcFieldHeader, True)
    else
      AHitTest.SetBitState(htcDataHeader, True);
    if (FilterState <> cxbsDisabled) and PtInRect(FilterBounds, AHitTest.HitPoint) then
      AHitTest.SetBitState(htcFilter, True);
  end;
end;

function TcxPivotGridFieldHeaderCellViewInfo.GetIsLast: Boolean;
begin
  Result := True;
end;

function TcxPivotGridFieldHeaderCellViewInfo.IsSingle: Boolean;
begin
  Result := True;
end;

function TcxPivotGridFieldHeaderCellViewInfo.NeedShowHint(
  const APoint: TPoint): Boolean;
begin
  Result := ((FilterState = cxbsDisabled) or (APoint.X < FilterBounds.Left)) and
    inherited NeedShowHint(APoint);
end;

function TcxPivotGridFieldHeaderCellViewInfo.SetHotTrack(
  AHitTest: TcxPivotGridHitTest): Boolean;

  procedure ChangeState(var AState: TcxButtonState; ANewState: TcxButtonState);
  begin
    if (AState <> cxbsDisabled) and (AState <> cxbsPressed)  then
      AState := ANewState;
  end;

var
  APrevState, APrevFilterState: TcxButtonState;
begin
  APrevState := FState;
  APrevFilterState := FFilterState;
  if not PtInRect(ClipRect, AHitTest.HitPoint) then
  begin
    ChangeState(FFilterState, cxbsNormal);
    ChangeState(FState, cxbsNormal);
  end
  else
  begin
    ChangeState(FState, cxbsHot);
    if PtInRect(FFilterBounds, AHitTest.HitPoint) then
      ChangeState(FFilterState, cxbsHot)
    else
      ChangeState(FFilterState, cxbsNormal);
  end;
  Result := (APrevState <> State) or (APrevFilterState <> FFilterState);
end;

function TcxPivotGridFieldHeaderCellViewInfo.SingleOrLeftMostInGroup: Boolean;
begin
  Result := (Group = nil) or (Group.Fields[0] = Field);
end;

function TcxPivotGridFieldHeaderCellViewInfo.SingleOrRightMostInGroup: Boolean;
begin
  Result := (Group = nil) or Group.IsLastVisibleField(TcxPivotGridField(Field));
end;

function TcxPivotGridFieldHeaderCellViewInfo.UseEditProperties: Boolean;
begin
  Result := False;
end;

function TcxPivotGridFieldHeaderCellViewInfo.GetFocused: Boolean;
begin
  Result := (Field <> nil) and (DesignerHelper <> nil) and
    DesignerHelper.IsObjectSelected(Field);
end;

{ TcxPivotGridDataCellViewInfo }

procedure TcxPivotGridDataCellViewInfo.Initialize(
  ARow, AColumn: TcxPivotGridViewDataItem; ADataField: TcxPivotGridField);
begin
  FRow := ARow;
  FColumn := AColumn;
  FDataField := ADataField;
  FValue := Null;
  InitializeProperties;
end;

function TcxPivotGridDataCellViewInfo.MeasureWidth: Integer;
begin
  Result := cxTextWidth(Font, FDisplayText) + cxPivotGridDoubleSpace;
end;

procedure TcxPivotGridDataCellViewInfo.CalculateVisibleInfo;
var
  ACol, ARow: TcxPivotGridGroupItem;
begin
  inherited CalculateVisibleInfo;
  ARow := Row.GetGroupItem(FDataField);
  ACol := Column.GetGroupItem(FDataField);
  if (DataField = nil) or (ARow = nil) or (ACol = nil) then
  begin
    FDisplayText := cxGetResourceString(@scxNoDataToDisplay);
    Exit;
  end;

  FCrossCell := ARow.GetCellByCrossItem(ACol);
  FSummaryType := DataField.SummaryType;
  if not Row.GetSummaryType(FSummaryType, FTotal) then
    Column.GetSummaryType(FSummaryType, FTotal);
  FCellSummary := CrossCell.SummaryCells[DataField.SummaryIndex];
  if (Total = nil) and DataField.HasSummaryVariation then
    FValue := CellSummary.SummaryVariation
  else
    FValue := CellSummary.GetSummaryByType(SummaryType);
  FIsTotal := GetIsTotal;
  FAlignment := taRightJustify;
  FAlignVert := vaCenter;
  FormatDisplayValue;
end;

procedure TcxPivotGridDataCellViewInfo.DoDraw;
begin
  if not Transparent then
    Canvas.FillRect(Bounds, FViewParams, Borders, BorderColor);
  DrawText;
  if FocusRectStyle = frsLine then
    Canvas.InvertFrame(ExcludeBorders(Bounds, Borders), 1)
  else
    if FocusRectStyle = frsDot then
    begin
      Canvas.Brush.Style := bsSolid;
      Canvas.DrawFocusRect(ExcludeBorders(Bounds, Borders));
    end;
end;

procedure TcxPivotGridDataCellViewInfo.DrawText;
var
  AFlags: Integer;
begin
  if FProperties <> nil then
    DrawUsingEditProperties
  else
    if DisplayText <> '' then
    begin
      Canvas.Brush.Style := bsClear;
      AFlags := cxAlignmentsHorz[Align] or cxAlignmentsVert[FAlignVert];
      if MarkNarrowCells and (cxTextWidth(Font, DisplayText) > cxRectWidth(TextBounds)) then
        Canvas.DrawTexT(ReplaceDigitsByPattern(DisplayText), TextBounds, AFlags)
      else
        Canvas.DrawTexT(DisplayText, TextBounds, AFlags);
    end;
end;

procedure TcxPivotGridDataCellViewInfo.FormatDisplayValue;
begin
  DataField.DoGetDisplayText(Self);
end;

function TcxPivotGridDataCellViewInfo.GetHintText: string;
begin
  Result := FDisplayText;
end;

function TcxPivotGridDataCellViewInfo.GetHitTest(
  AHitTest: TcxPivotGridHitTest): Boolean;
begin
  Result := inherited GetHitTest(AHitTest);
  if Result then
  begin
    AHitTest.SetBitState(htcDataCell, True);
    AHitTest.FHitObject := Self;
  end;
end;

function TcxPivotGridDataCellViewInfo.NeedShowHint(const APoint: TPoint): Boolean;
begin
  Result := cxTextWidth(Font, HintText) > cxRectWidth(TextBounds);
end;

function TcxPivotGridDataCellViewInfo.OnGetDisplayTextSupported: Boolean;
begin
  Result := True;
end;

function TcxPivotGridDataCellViewInfo.ReplaceDigitsByPattern(const ADisplayText: string): string;
begin
  SetLength(Result, Length(ADisplayText));
  dxFillChar(Result[1], Length(ADisplayText), cxPivotPatternChar);
end;

function TcxPivotGridDataCellViewInfo.GetColumnIndex: Integer;
begin
  Result := Column.VisibleIndex;
end;

function TcxPivotGridDataCellViewInfo.GetDisplayFormat: string;
begin
  Result := '';
  if Total <> nil then
    Result := Total.DisplayFormat
  else
    if DataField <> nil then
      Result := DataField.GetActualDisplayFormat;
end;

function TcxPivotGridDataCellViewInfo.GetIsGrandTotal: Boolean;

  function IsGrandTotal(AItem: TcxPivotGridViewDataItem): Boolean;
  begin
    Result := AItem.IsGrandTotal;
    while not Result and (AItem.Parent <> nil) do
    begin
      AItem := AItem.Parent;
      Result := AItem.IsGrandTotal;
    end;
  end;

begin
  Result := IsGrandTotal(Column) or IsGrandTotal(Row);
end;

function TcxPivotGridDataCellViewInfo.GetIsTotal: Boolean;
begin
  if FIsTotalAssigned then
    Result := FIsTotal
  else
    Result := Column.IsTotalItem or Row.IsTotalItem;
end;

function TcxPivotGridDataCellViewInfo.GetLimitValueTypes: TcxPivotGridDataCellLimitValueTypes;
var
  AViewData: TcxPivotGridViewData;
  V: Variant;
begin
  Result := [];
  if Column.IsTotal or Row.IsTotal then
    Exit;
  if CrossCell = nil then
    CalculateVisibleInfo;
  if CrossCell = nil then
    Exit;
  V := CrossCell.GetSummaryByField(DataField, DataField.SummaryType);
  if not VarIsNumericEx(V) then
    Exit;
  Column.PivotGrid.ViewData.CalculateLimitValues;
  AViewData := nil;
  if Column <> nil then
  begin
    if VarEquals(V, Column.LimitValues.GetMaximumValue(DataField)) then
      Result := Result + [lvtColumnMaximum];
    if VarEquals(V, Column.LimitValues.GetMinimumValue(DataField)) then
      Result := Result + [lvtColumnMinimum];
    AViewData := Column.PivotGrid.ViewData;
  end;
  if Row <> nil then
  begin
    if VarEquals(V, Row.LimitValues.GetMaximumValue(DataField)) then
      Result := Result + [lvtRowMaximum];
    if VarEquals(V, Row.LimitValues.GetMinimumValue(DataField)) then
      Result := Result + [lvtRowMinimum];
    AViewData := Row.PivotGrid.ViewData;
  end;
  if AViewData <> nil then
  begin
    if VarEquals(V, AViewData.LimitValues.GetMaximumValue(DataField)) then
      Result := Result + [lvtMaximum];
    if VarEquals(V, AViewData.LimitValues.GetMinimumValue(DataField)) then
      Result := Result + [lvtMinimum];
  end;
end;

function TcxPivotGridDataCellViewInfo.GetRowIndex: Integer;
begin
  Result := Row.VisibleIndex;
end;

{ TcxPivotGridHeaderBackgroundCellViewInfo }

procedure TcxPivotGridHeaderBackgroundCellViewInfo.CorrectBoundsForPrinting(ABounds: TRect);
var
  ACorrectedBounds: TRect;
begin
  if Area in [faColumn, faFilter] then
  begin
    ACorrectedBounds := Bounds;
    ACorrectedBounds.Right := ABounds.Right;
    CalculateCellBounds(ACorrectedBounds, ACorrectedBounds);
  end;
end;

procedure TcxPivotGridHeaderBackgroundCellViewInfo.DoDraw;
var
  R: TRect;
  ARgn: TcxRegion;
  ATextFormat: Integer;
begin
  if not Transparent then
  begin
    ARgn := FCanvas.GetClipRegion();
    FCanvas.IntersectClipRect(Bounds);
    FPainter.DrawGroupByBox(FCanvas, FieldHeadersBounds.Rect, Bitmap <> nil, Color,
      Bitmap);
    FCanvas.SetClipRegion(ARgn, roSet);
  end;
  if not HasFields then
  begin
    ATextFormat := cxMakeFormat(taLeft, taCenterY) or CXTO_WORDBREAK or CXTO_PREVENT_TOP_EXCEED;
    R := Bounds;
    cxTextOut(Canvas.Handle, FDisplayText, R, ATextFormat, nil, 0, cxTextOffset, cxTextOffset);
  end;
end;

function TcxPivotGridHeaderBackgroundCellViewInfo.GetHitTest(
  AHitTest: TcxPivotGridHitTest): Boolean;
begin
  Result := inherited GetHitTest(AHitTest);
  if Result then
    AHitTest.SetBitState(htcHeaderArea, True);
end;

{ TcxPivotGridPrefilterPartViewInfo }

procedure TcxPivotGridPrefilterPartViewInfo.Calculate(ALeftBound,
  ATopBound, AWidth, AHeight: Integer);
begin
  if AWidth = -1 then AWidth := CalculateWidth;
  if AHeight = -1 then AHeight := CalculateHeight;
  with FBounds do
  begin
    Left := ALeftBound;
    Top := ATopBound;
    Right := Left + AWidth;
    Bottom := Top + AHeight;
  end;
end;

procedure TcxPivotGridPrefilterPartViewInfo.Click;
begin
//do nothing
end;

constructor TcxPivotGridPrefilterPartViewInfo.Create(APartsViewInfo: TcxPivotGridPrefilterPartsViewInfo);
begin
  inherited Create;
  FPartsViewInfo := APartsViewInfo;
  FPainter := FPartsViewInfo.PrefilterViewInfo.Painter;
  FPrefilter := FPartsViewInfo.PrefilterViewInfo.FPrefilter;
  FState := cxbsNormal;
end;

procedure TcxPivotGridPrefilterPartViewInfo.Draw(ACanvas: TcxCanvas);
begin
  DoDraw(ACanvas);
end;

function TcxPivotGridPrefilterPartViewInfo.GetAlignment: TcxPivotGridPrefilterButtonAlignment;
begin
  Result := pfbaLeft;
end;

function TcxPivotGridPrefilterPartViewInfo.GetHitTest(AHitTest: TcxPivotGridHitTest): Boolean;
begin
  Result := Visible and PtInRect(FBounds, AHitTest.HitPoint);
  if Result then
    AHitTest.SetBitState(GetPartIndex, True);
end;

function TcxPivotGridPrefilterPartViewInfo.GetState: TcxButtonState;
begin
  if FDroppedDown then
    Result := cxbsPressed
  else
    Result := FState;
end;

function TcxPivotGridPrefilterPartViewInfo.GetVisible: Boolean;
begin
  Result := not FPrefilter.Filter.IsEmpty;
end;

procedure TcxPivotGridPrefilterPartViewInfo.SetDroppedDown(AHitTest: TcxPivotGridHitTest; ADroppedDown: Boolean);
begin
  FDroppedDown := ADroppedDown;
end;

function TcxPivotGridPrefilterPartViewInfo.SetHotTrack(
  AHitTest: TcxPivotGridHitTest): Boolean;
var
  APrevState: TcxButtonState;
begin
  APrevState := FState;
  if APrevState <> cxbsDisabled then
    if cxRectPtIn(FBounds, AHitTest.HitPoint) then
    begin
      if not (ssLeft in AHitTest.ShiftState) then
        FState := cxbsHot
      else
        if FState = cxbsHot then
          FState := cxbsPressed;
    end
    else
      if not (ssLeft in AHitTest.ShiftState) then
        FState := cxbsNormal
      else
        if FState = cxbsPressed then
          FState := cxbsHot;
  Result := APrevState <> FState;
end;

function TcxPivotGridPrefilterPartViewInfo.SetPressed(AHitTest: TcxPivotGridHitTest; AMouseDown: Boolean): Boolean;
begin
  Result := False;
  if FState <> cxbsDisabled then
    if AHitTest.BitState[GetPartIndex] then
    begin
      Result := True;
      if AMouseDown then
        FState := cxbsPressed
      else
        if FState = cxbsPressed then
        begin
          FState := cxbsNormal;
          Click;
        end;
    end
    else
      FState := cxbsNormal;
end;

{ TcxPivotGridPrefilterCloseButtonViewInfo }

function TcxPivotGridPrefilterCloseButtonViewInfo.CalculateHeight: Integer;
begin
  Result := FPainter.FilterCloseButtonSize.Y;
end;

function TcxPivotGridPrefilterCloseButtonViewInfo.CalculateWidth: Integer;
begin
  Result := FPainter.FilterCloseButtonSize.X;
end;

procedure TcxPivotGridPrefilterCloseButtonViewInfo.Click;
begin
  inherited;
  FPrefilter.Filter.Clear;
end;

procedure TcxPivotGridPrefilterCloseButtonViewInfo.DoDraw(
  ACanvas: TcxCanvas);
begin
  inherited;
  FPainter.DrawFilterCloseButton(ACanvas, FBounds,
    FState);
end;

function TcxPivotGridPrefilterCloseButtonViewInfo.GetPartIndex: Integer;
begin
  Result := htcPrefilterCloseButton;
end;

{ TcxPivotGridPrefilterActivateButtonViewInfo }

function TcxPivotGridPrefilterActivateButtonViewInfo.CalculateHeight: Integer;
begin
  Result := FPainter.FilterActivateButtonSize.Y;
end;

function TcxPivotGridPrefilterActivateButtonViewInfo.CalculateWidth: Integer;
begin
  Result := FPainter.FilterActivateButtonSize.X;
end;

procedure TcxPivotGridPrefilterActivateButtonViewInfo.Click;
begin
  inherited;
  FPrefilter.Filter.Active := not FPrefilter.Filter.Active;
end;

procedure TcxPivotGridPrefilterActivateButtonViewInfo.DoDraw(
  ACanvas: TcxCanvas);
begin
  inherited;
  FPainter.DrawFilterActivateButton(ACanvas, Bounds,
    FState, GetChecked);
end;

function TcxPivotGridPrefilterActivateButtonViewInfo.GetPartIndex: Integer;
begin
  Result := htcPrefilterActivateButton;
end;

function TcxPivotGridPrefilterActivateButtonViewInfo.GetChecked: Boolean;
begin
  Result := FPrefilter.Filter.Active and not FPrefilter.Filter.IsEmpty;
end;

{ TcxPivotGridPrefilterCustomizeButtonViewInfo }

function TcxPivotGridPrefilterCustomizeButtonViewInfo.CalculateHeight: Integer;
begin
  Result := GetBorderWidth(bTop) + GetBorderWidth(bBottom) + cxTextHeight(GetFont) +
    + GetTextOffset;
end;

function TcxPivotGridPrefilterCustomizeButtonViewInfo.CalculateWidth: Integer;
begin
  Result := GetBorderWidth(bLeft) + GetBorderWidth(bRight) + cxTextWidth(GetFont, GetText) +
    + GetTextOffset;
end;

procedure TcxPivotGridPrefilterCustomizeButtonViewInfo.Click;
begin
  inherited;
  FPrefilter.ShowPrefilterDialog;
end;

procedure TcxPivotGridPrefilterCustomizeButtonViewInfo.DoDraw(
  ACanvas: TcxCanvas);
begin
  inherited;
  FPainter.DrawButton(ACanvas, FBounds, GetText, FState);
end;

function TcxPivotGridPrefilterCustomizeButtonViewInfo.GetAlignment: TcxPivotGridPrefilterButtonAlignment;
begin
  Result := pfbaRight;
end;

function TcxPivotGridPrefilterCustomizeButtonViewInfo.GetBorderWidth(AIndex: TcxBorder): Integer;
begin
  Result := FPainter.ButtonBorderSize;
end;

function TcxPivotGridPrefilterCustomizeButtonViewInfo.GetVisible: Boolean;
begin
  Result := FPrefilter.CustomizeButtonVisible;
end;

function TcxPivotGridPrefilterCustomizeButtonViewInfo.GetPartIndex: Integer;
begin
  Result := htcPrefilterCustomizationButton;
end;

function TcxPivotGridPrefilterCustomizeButtonViewInfo.GetFont: TFont;
begin
  Result := FPartsViewInfo.FPrefilterViewInfo.Font;
end;

function TcxPivotGridPrefilterCustomizeButtonViewInfo.GetText: string;
begin
  Result := cxGetResourceString(@scxPrefilterCustomizeButtonCaption);
end;

function TcxPivotGridPrefilterCustomizeButtonViewInfo.GetTextOffset: Integer;
begin
  Result := 2 * (cxTextOffset + FPainter.ButtonTextOffset);
end;

{ TcxPivotGridPrefilterDropDownButtonViewInfo }

function TcxPivotGridPrefilterDropDownButtonViewInfo.CalculateHeight: Integer;
begin
  Result := FPainter.FilterCloseButtonSize.Y;
end;

function TcxPivotGridPrefilterDropDownButtonViewInfo.CalculateWidth: Integer;
begin
  Result := FPainter.FilterCloseButtonSize.X;
end;

procedure TcxPivotGridPrefilterDropDownButtonViewInfo.DoDraw(ACanvas: TcxCanvas);
begin
  FPainter.DrawFilterDropDownButton(ACanvas, Bounds, State, False);
end;

function TcxPivotGridPrefilterDropDownButtonViewInfo.GetAlignment: TcxPivotGridPrefilterButtonAlignment;
begin
  Result := pfbaLeft;
end;

function TcxPivotGridPrefilterDropDownButtonViewInfo.GetPartIndex: Integer;
begin
  Result := htcPrefilterDropDownButton;
end;

function TcxPivotGridPrefilterDropDownButtonViewInfo.GetVisible: Boolean;
begin
  Result := FPrefilter.CanMRUPopupShow;
end;

{ TcxPivotGridPrefilterCaptionViewInfo }

function TcxPivotGridPrefilterCaptionViewInfo.CalculateHeight: Integer;
begin
  Result := cxTextHeight(FPrefilter.ViewInfo.Font) + 2 * (PrefilterTextOffset + cxTextOffset);
end;

function TcxPivotGridPrefilterCaptionViewInfo.CalculateWidth: Integer;
begin
  Result := cxTextWidth(FPrefilter.ViewInfo.Font, FPrefilter.ViewInfo.DisplayText);
end;

procedure TcxPivotGridPrefilterCaptionViewInfo.DoDraw(ACanvas: TcxCanvas);
begin
  ACanvas.Brush.Style := bsClear;
  with FPrefilter.ViewInfo do
  begin
    ACanvas.Font := Font;
    ACanvas.Font.Color := TextColor;
    if State in [cxbsHot, cxbsPressed] then
      ACanvas.Font.Style := ACanvas.Font.Style + [fsUnderline];
    ACanvas.DrawTexT(DisplayText, Self.Bounds,
      cxAlignLeft or cxAlignVCenter);
  end;
  ACanvas.Brush.Style := bsSolid;
end;

function TcxPivotGridPrefilterCaptionViewInfo.GetAlignment: TcxPivotGridPrefilterButtonAlignment;
begin
  Result := pfbaLeft;
end;

function TcxPivotGridPrefilterCaptionViewInfo.GetPartIndex: Integer;
begin
  Result := htcPrefilterCaption;
end;

function TcxPivotGridPrefilterCaptionViewInfo.GetState: TcxButtonState;
begin
  if FPrefilter.CanMRUPopupShow then
    Result := inherited GetState
  else
    Result := cxbsNormal;
end;

function TcxPivotGridPrefilterCaptionViewInfo.GetVisible: Boolean;
begin
  Result := True;
end;

procedure TcxPivotGridPrefilterCaptionViewInfo.SetDroppedDown(AHitTest: TcxPivotGridHitTest; ADroppedDown: Boolean);
begin
  if not ADroppedDown or AHitTest.GetBitState(GetPartIndex) then
    inherited;
end;

{ TcxPivotGridPrefilterPartsViewInfo }

constructor TcxPivotGridPrefilterPartsViewInfo.Create(APrefilterViewInfo: TcxPivotGridPrefilterViewInfo);
begin
  inherited Create;
  FPrefilterViewInfo := APrefilterViewInfo;
  FItems := TcxObjectList.Create;
  AddItems;
end;

destructor TcxPivotGridPrefilterPartsViewInfo.Destroy;
begin
  DestroyItems;
  FItems.Free;
  FCaptionViewInfo := nil;
  FDropDownButtonViewInfo := nil;
  inherited;
end;

function TcxPivotGridPrefilterPartsViewInfo.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxPivotGridPrefilterPartsViewInfo.GetHeight: Integer;
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
  if Result <> 0 then Inc(Result, 2 * PrefilterButtonsFirstOffset);
end;

function TcxPivotGridPrefilterPartsViewInfo.GetItem(Index: Integer): TcxPivotGridPrefilterPartViewInfo;
begin
  Result := TcxPivotGridPrefilterPartViewInfo(FItems[Index]);
end;

procedure TcxPivotGridPrefilterPartsViewInfo.AddItems;
begin
  AddItem(TcxPivotGridPrefilterCloseButtonViewInfo);
  AddItem(TcxPivotGridPrefilterActivateButtonViewInfo);
  AddItem(TcxPivotGridPrefilterCustomizeButtonViewInfo);
  FCaptionViewInfo := TcxPivotGridPrefilterCaptionViewInfo(
    AddItem(TcxPivotGridPrefilterCaptionViewInfo));
  FDropDownButtonViewInfo := TcxPivotGridPrefilterDropDownButtonViewInfo(
    AddItem(TcxPivotGridPrefilterDropDownButtonViewInfo));
end;

procedure TcxPivotGridPrefilterPartsViewInfo.DestroyItems;
begin
  FItems.Clear;
end;

function TcxPivotGridPrefilterPartsViewInfo.GetDropDownPartBounds: TRect;
begin
  Result := FDropDownButtonViewInfo.Bounds;
  Result.Left := FCaptionViewInfo.Bounds.Left;
end;

procedure TcxPivotGridPrefilterPartsViewInfo.SetDroppedDown(AHitTest: TcxPivotGridHitTest; ADroppedDown: Boolean);
begin
  FDropDownButtonViewInfo.SetDroppedDown(AHitTest, ADroppedDown);
  FCaptionViewInfo.SetDroppedDown(AHitTest, ADroppedDown);
end;

function TcxPivotGridPrefilterPartsViewInfo.SetHotTrack(AHitTest: TcxPivotGridHitTest): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Count - 1 do
    Result := Result or Items[I].SetHotTrack(AHitTest);
end;

function TcxPivotGridPrefilterPartsViewInfo.SetPressed(AHitTest: TcxPivotGridHitTest; AMouseDown: Boolean): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Count - 1 do
  begin
    Result := Items[I].SetPressed(AHitTest, AMouseDown);
    if Result then
      Exit;
  end;
end;

function TcxPivotGridPrefilterPartsViewInfo.AddItem(AItemClass: TcxPivotGridPrefilterPartViewInfoClass): TcxPivotGridPrefilterPartViewInfo;
begin
  Result := AItemClass.Create(Self);
  FItems.Add(Result);
end;

procedure TcxPivotGridPrefilterPartsViewInfo.Calculate(const ABounds: TRect);
var
  ALeftMargin, ARightMargin, ALeft, I: Integer;
  ARestWidth: Integer;
begin
  ALeftMargin := ABounds.Left + PrefilterButtonsFirstOffset;
  ARightMargin := ABounds.Right - PrefilterButtonsFirstOffset;
  for I := 0 to Count - 1 do
    with Items[I], ABounds do
      if Visible then
      begin
        if Alignment = pfbaLeft then
          ALeft := ALeftMargin
        else
          ALeft := ARightMargin - CalculateWidth;
        Calculate(ALeft, MulDiv(Top + Bottom - CalculateHeight, 1, 2));
        if Alignment = pfbaLeft then
          ALeftMargin := Items[I].Bounds.Right + PrefilterButtonsOffset
        else
          ARightMargin := Items[I].Bounds.Left - PrefilterButtonsOffset;
      end;
  ARestWidth := ARightMargin - ALeftMargin + PrefilterButtonsOffset;
  if ARestWidth < 0 then
  begin
    ARestWidth := Min(cxRectWidth(FCaptionViewInfo.Bounds), -ARestWidth);
    FCaptionViewInfo.FBounds.Right := FCaptionViewInfo.FBounds.Right - ARestWidth;
    if FDropDownButtonViewInfo.Visible then
      OffsetRect(FDropDownButtonViewInfo.FBounds, -ARestWidth, 0);
  end;
end;

procedure TcxPivotGridPrefilterPartsViewInfo.DrawParts;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    if Items[I].Visible then
      Items[I].Draw(FPrefilterViewInfo.Canvas);
end;

function TcxPivotGridPrefilterPartsViewInfo.GetHitTest(AHitTest: TcxPivotGridHitTest): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Count - 1 do
  begin
    Result := Items[I].GetHitTest(AHitTest);
    if Result then Break;
  end;
end;

{ TcxPivotGridPrefilterViewInfo }

constructor TcxPivotGridPrefilterViewInfo.Create(APrefilter: TcxPivotGridPrefilter;
  APainter: TcxCustomLookAndFeelPainterClass; const ABounds,
  AVisibleRect: TRect; const AViewParams: TcxViewParams);
begin
  inherited Create(APainter, ABounds, AVisibleRect, AViewParams);
  FPrefilter := APrefilter;
  FPartsViewInfo := TcxPivotGridPrefilterPartsViewInfo.Create(Self);
  FDisplayText := FPrefilter.Filter.FilterCaption;
  if FDisplayText = '' then
    FDisplayText := cxGetResourceString(@scxPrefilterIsEmpty);
end;

destructor TcxPivotGridPrefilterViewInfo.Destroy;
begin
  FPartsViewInfo.Free;
  inherited;
end;

procedure TcxPivotGridPrefilterViewInfo.CalculateVisibleInfo;
begin
  FPartsViewInfo.Calculate(Bounds);
end;

procedure TcxPivotGridPrefilterViewInfo.CorrectBoundsForPrinting(ABounds: TRect);
var
  ACorrectedBounds: TRect;
begin
  ACorrectedBounds := Bounds;
  ACorrectedBounds.Right := ABounds.Right;
  if Prefilter.Position = pfpBottom then
    ACorrectedBounds := cxRectSetTop(ACorrectedBounds, ABounds.Bottom);
  CalculateCellBounds(ACorrectedBounds, ACorrectedBounds);
end;

procedure TcxPivotGridPrefilterViewInfo.DoDraw;
begin
  if not Transparent then
    DrawBackground;
  FPartsViewInfo.DrawParts;
end;

function TcxPivotGridPrefilterViewInfo.GetHeight: Integer;
begin
  Result := FPartsViewInfo.Height;
end;

function TcxPivotGridPrefilterViewInfo.GetHitTest(AHitTest: TcxPivotGridHitTest): Boolean;
begin
  Result := inherited GetHitTest(AHitTest);
  if Result then
  begin
    AHitTest.SetBitState(htcPrefilter, True);
    FPartsViewInfo.GetHitTest(AHitTest);
  end;
end;

function TcxPivotGridPrefilterViewInfo.GetTextWidth: Integer;
begin
  Result := cxTextWidth(Font, DisplayText);
end;

function TcxPivotGridPrefilterViewInfo.GetDropDownWindowOwnerBounds: TRect;
begin
  Result := FPartsViewInfo.GetDropDownPartBounds;
end;

procedure TcxPivotGridPrefilterViewInfo.SetDroppedDown(AHitTest: TcxPivotGridHitTest; ADroppedDown: Boolean);
begin
  FPartsViewInfo.SetDroppedDown(AHitTest, ADroppedDown);
end;

function TcxPivotGridPrefilterViewInfo.SetHotTrack(AHitTest: TcxPivotGridHitTest): Boolean;
begin
  Result := FPartsViewInfo.SetHotTrack(AHitTest);
end;

function TcxPivotGridPrefilterViewInfo.SetPressed(AHitTest: TcxPivotGridHitTest; AMouseDown: Boolean): Boolean;
begin
  Result := FPartsViewInfo.SetPressed(AHitTest, AMouseDown);
end;

procedure TcxPivotGridPrefilterViewInfo.DrawBackground;
begin
  Painter.DrawFilterPanel(Canvas, Bounds, Bitmap <> nil, Color, Bitmap);
end;

{ TcxPivotGridCustomCellViewInfo }

constructor TcxPivotGridFilterSeparatorCellViewInfo.Create(
  APainter: TcxCustomLookAndFeelPainterClass;
  const ABounds, AVisibleRect: TRect; const AViewParams: TcxViewParams);
begin
  inherited Create(APainter, ABounds, AVisibleRect, AViewParams);
  FIndentSize := cxTextOffset;
end;

procedure TcxPivotGridFilterSeparatorCellViewInfo.DoDraw;
begin
  Painter.DrawHeaderSeparator(Canvas, Bounds, IndentSize, TextColor,
    ViewParams);
end;

{ TcxPivotGridViewInfo }

constructor TcxPivotGridViewInfo.Create(AOwner: TcxCustomPivotGrid);
begin
  FPivotGrid := AOwner;
  FDrawBorders := True;
  FDrawExpandButtons := True;
  FColumnHeaders := TcxPivotGridCells.Create;
  FFieldHeaders := TcxPivotGridCells.Create;
  FRowHeaders := TcxPivotGridCells.Create;
  FCommonCells := TcxPivotGridCells.Create;
  FDataCells := TcxPivotGridCells.Create;
  FDragDropAreas := TcxObjectList.Create;
  FColumnItems := TcxList.Create;
  FRowColumnPos := TcxList.Create;
  FRowItems := TcxList.Create;
  FFieldHeadersBounds := TcxRect.Create(nil);
  FPrefilter := TcxPivotGridPrefilter.Create(AOwner);
end;

destructor TcxPivotGridViewInfo.Destroy;
begin
  Clear;
  FreeAndNil(FPrefilter);
  FreeAndNil(FFieldHeadersBounds);
  FreeAndNil(FRowItems);
  FreeAndNil(FColumnItems);
  FreeAndNil(FDataCells);
  FreeAndNil(FColumnHeaders);
  FreeAndNil(FDragDropAreas);
  FreeAndNil(FCommonCells);
  FreeAndNil(FFieldHeaders);
  FreeAndNil(FRowHeaders);
  FreeAndNil(FRowColumnPos);
  inherited Destroy;
end;

procedure TcxPivotGridViewInfo.Calculate;
begin
  if FBaseStyles = nil then
    FBaseStyles := PivotGrid.Styles;
  FCanvas := PivotGrid.Canvas;
  FPainter := PivotGrid.LookAndFeelPainter;
  FBounds := PivotGrid.ClientBounds;
  if IsPrinting then
  begin
    FBounds.Right := MaxInt;
    FBounds.Bottom := MaxInt;
  end;
  Clear;
  DoCalculate;
end;

procedure TcxPivotGridViewInfo.Clear;
begin
  FRowItems.Clear;
  FRowColumnPos.Clear;
  FColumnItems.Clear;
  FColumnHeaders.Clear;
  FCommonCells.Clear;
  FFieldHeaders.DeleteAll;
  FRowHeaders.Clear;
  FDataCells.Clear;
  FDragDropAreas.Clear;
  FPrefilter.Clear;
end;

procedure TcxPivotGridViewInfo.InvalidateRect(const ARect: TRect);
begin
  PivotGrid.InvalidateRect(ARect, False);
end;

procedure TcxPivotGridViewInfo.SelectionChanged;
var
  I: Integer;
begin
  for I := 0 to DataCells.Count - 1 do
    CheckCellSelection(TcxPivotGridDataCellViewInfo(DataCells[I]));
end;

function TcxPivotGridViewInfo.AddDragDropAreaInfo(APos: Integer;
  const ABounds, ADisplayBounds: TRect; AArea: TcxPivotGridFieldArea;
  AAreaIndex: Integer; AField: TPersistent): TcxPivotGridDragDropAreaInfo;
begin
  Result := TcxPivotGridDragDropAreaInfo.Create();
  Result.Area := AArea;
  Result.AreaIndex := AAreaIndex;
  Result.Bounds := cxRectSetXPos(ABounds, ADisplayBounds.Left, ADisplayBounds.Right);
  Result.DisplayBounds := cxRectSetLeft(ADisplayBounds, APos, 1);
  Result.Field := AField;
  FDragDropAreas.Add(Result);
end;

function TcxPivotGridViewInfo.AddFieldHeader(
  const ABounds: TRect; AField: TcxPivotGridField; AArea: TcxPivotGridFieldArea;
  AAreaIndex: Integer): TcxPivotGridFieldHeaderCellViewInfo;
begin
  if AField <> nil then
    Result := AField.ViewInfo
  else
    Result := OptionsDataField.ViewInfo;
  Result.FArea := AArea;
  Result.FAreaIndex := AAreaIndex;
  Result.SetBounds(ABounds, FCellsBounds);
  FieldHeaders.Add(Result);
end;

function TcxPivotGridViewInfo.AddFieldsBackground(
  const ABounds: TRect; const ADescription: string; AHasDescription: Boolean;
  AArea: TcxPivotGridFieldArea): TcxPivotGridHeaderBackgroundCellViewInfo;
var
  AParams: TcxViewParams;
begin
  AParams := BaseStyles.GetHeaderBackgroundParams(AArea);
  Result := TcxPivotGridHeaderBackgroundCellViewInfo.Create(
    Painter, ABounds, FCellsBounds, AParams);
  Result.FHasFields := not AHasDescription;
  Result.FArea := AArea;
  Result.DisplayText := ADescription;
  Result.FFieldHeadersBounds := FFieldHeadersBounds;
  CommonCells.Add(Result);
end;

function TcxPivotGridViewInfo.AddFilterSeparator(
  const ATop: Integer): TcxPivotGridFilterSeparatorCellViewInfo;
var
  ABounds: TRect;
begin
  ABounds := cxRectSetTop(FCellsBounds, ATop, cxPivotGridFilterSeparatorHeight);
  if PivotGrid.VScrollBarVisible then
    Inc(ABounds.Right, cxTextOffset);
  Result := TcxPivotGridFilterSeparatorCellViewInfo.Create(Painter,
    ABounds, ABounds, Styles.GetFilterSeparatorParams);
  CommonCells.Add(Result);
end;

procedure TcxPivotGridViewInfo.AfterPaint;
begin
end;

procedure TcxPivotGridViewInfo.BeforePaint;
begin
  FColumnHeaders.BeforePaint;
  FCommonCells.BeforePaint;
  FFieldHeaders.BeforePaint;
  FRowHeaders.BeforePaint;
  FDataCells.BeforePaint;
end;

function TcxPivotGridViewInfo.GetDataFieldFromViewData(
  AItem: TcxPivotGridViewDataItem): TcxPivotGridField;
var
  I: Integer;
begin
  Result := nil;
  if DataBuilder.DataFields.Count = 0 then Exit;
  if DataBuilder.DataFields.Count = 1 then
    Result := DataBuilder.DataFields[0]
  else
  begin
    while (AItem <> nil) and not AItem.IsDataField do
      AItem := AItem.Parent;
    if not ((AItem <> nil) and AItem.IsDataField) then
    begin
      for I := 0 to DataBuilder.DataFields.Count - 1 do
        if not DataBuilder.DataFields[I].HasSummaryVariation then
          Result := DataBuilder.DataFields[I]
    end
    else
      Result := AItem.Field;
//    PivotGridError(Result <> nil, scxInvalidLayout);
  end;
end;

function TcxPivotGridViewInfo.GetFont(AStyleIndex: Integer): TFont;
var
  AStyle: TcxStyle;
begin
  case AStyleIndex of
    gs_ColumnHeader:
      Result := BaseStyles.GetColumnHeaderParams(nil).Font;
    gs_Content:
      Result := BaseStyles.GetContentParams(nil).Font;
    gs_FieldHeader:
      Result := BaseStyles.GetFieldHeaderParams(nil).Font;
    gs_RowHeader:
      Result := BaseStyles.GetRowHeaderParams(nil).Font;
    gs_Prefilter:
      Result := BaseStyles.GetPrefilterParams.Font;
  else
    AStyle := Styles.GetValue(AStyleIndex);
    if (AStyle = nil) or not (svFont in AStyle.AssignedValues) then
      Result := PivotGrid.Font
    else
      Result := AStyle.Font;
  end;
end;

function TcxPivotGridViewInfo.GetRowColumnPos(
  ALevel: Integer; var ALevelField: TPersistent): Integer;
begin
  if (ALevel >= 0) and (FRowColumnPos.Count > 0) then
  begin
    if ALevel >= FRowColumnPos.Count then
    begin
      Result := Bounds.Left + OptionsView.GetActualWidth;
      if (FRowColumnPos.Count = 1) and (ALevel = 1) and (OptionsDataField.Area = dfaRow) then
        ALevelField := OptionsDataField;
    end
    else
    begin
      Result := Integer(FRowColumnPos.List^[ALevel]);
      ALevelField := GetRowField(ALevel);
      if ALevelField = nil then
        ALevelField := OptionsDataField;
    end;
  end
  else
    Result := Bounds.Left;
end;

function TcxPivotGridViewInfo.GetRowField(AIndex: Integer): TcxPivotGridField;
begin
  if IsDataFieldVisible([dfaRow]) then
  begin
    if AIndex = OptionsDataField.GetActualAreaIndex(False) then
    begin
      Result := nil;
      Exit;
    end
    else
      if AIndex >= OptionsDataField.GetActualAreaIndex(False) then
        Dec(AIndex);
  end;
  Result := DataBuilder.RowFields[AIndex];
end;

function TcxPivotGridViewInfo.GetStartColumnIndex: Integer;
begin
  Result := ViewData.ColumnIndex;
  if IsPrinting then
    Result := 0;
end;

function TcxPivotGridViewInfo.GetStartRowIndex: Integer;
begin
  Result := ViewData.RowIndex;
  if IsPrinting then
    Result := 0;
end;

function TcxPivotGridViewInfo.GroupHeaderOutOfBounds(
  AField: TcxPivotGridField; ARight: Integer): Boolean;
var
  I, AWidth: Integer;
begin
  Result := (AField.Group <> nil) and (AField.Group.Fields[0] = AField);
  if Result then
  begin
    AWidth := 0;
    for I := 1 to AField.Group.FieldCount - 1 do
      if not AField.Group[I].VisibleInGroup then
        Break
      else
        Inc(AWidth, AField.Group[I].HeaderWidth + cxPivotGridSpace);
    Result := ARight + AWidth > Bounds.Right;
  end
  else
    Result := (AField.Group = nil) and (ARight > Bounds.Right);
end;

function TcxPivotGridViewInfo.AddPartBackground(
  ABounds: TRect): TcxPivotGridCustomCellViewInfo;
begin
  Result := nil;
  if IntersectRect(ABounds, ABounds, FCellsBounds) and not IsPrinting then
  begin
    Result := TcxPivotGridCustomCellViewInfo.Create(Painter, ABounds, FCellsBounds, FViewParams);
    CommonCells.Add(Result);
  end;
end;

function TcxPivotGridViewInfo.AddColumnItem(
  ABounds: TRect; AItem: TcxPivotGridViewDataItem): TcxPivotGridHeaderCellViewInfo;
begin
  Result := TcxPivotGridHeaderCellViewInfo.Create(
    Painter, ABounds, ColumnsBounds, BaseStyles.GetColumnHeaderParams(AItem));
  Result.Data := AItem;
  with AItem do
  begin
    Result.Neighbors := GetItemNeighbors(AItem.Level = 0, ABounds.Left <= ColumnsBounds.Left,
      not AItem.HasChildren, AItem.GetNextVisible = nil);
    if not AItem.Expanded and (not AItem.HasChildren or (AItem.ItemCount <= 1)) then
    begin
      Result.FSizeField := AItem.Field;
      if AItem.IsGrandTotal and (AItem.Field = nil) then
        Result.FSizeField := OptionsView;
    end;
  end;
  InitHeaderCell(Result, AItem);
  ColumnHeaders.Add(Result);
end;

function TcxPivotGridViewInfo.AddDataCell(ARow, AColumn: TcxPivotGridViewDataItem;
  ALeft, ATop: Integer): TcxPivotGridDataCellViewInfo;
var
  ABounds: TRect;
  AField: TcxPivotGridField;
const
  ABorders: array[TcxPivotGridLines] of TcxBorders =
    ([], [bBottom], [bRight], [bRight, bBottom]);
begin
  ABounds := cxRect(ALeft, ATop, ALeft + AColumn.Size, ATop + ARow.Size);
  if FNeedCorrectHeaders and (ALeft <= DataCellsBounds.Left) then
    Inc(ABounds.Left);

  Result := TcxPivotGridDataCellViewInfo.Create(Painter, ABounds, DataCellsBounds, FViewParams);
  Result.FBorders := ABorders[OptionsView.GridLines];
  if PivotGrid.OptionsView.GridLineColor <> clDefault then
    Result.FBorderColor := PivotGrid.OptionsView.GridLineColor
  else
    Result.FBorderColor := Painter.DefaultGridLineColor;
  if OptionsDataField.Area = dfaRow then
    AField := GetDataFieldFromViewData(ARow)
  else
    AField := GetDataFieldFromViewData(AColumn);
  Result.Initialize(ARow, AColumn, AField);
  Result.MarkNarrowCells := OptionsView.MarkNarrowCells;
  if IsPrinting and DrawBorders then
  begin
    if ARow.VisibleIndex = ViewData.RowCount - 1 then
      Include(Result.FBorders, bBottom);
    if AColumn.VisibleIndex = ViewData.ColumnCount - 1 then
      Include(Result.FBorders, bRight);
  end;
  InitCellViewParams(Result);
  DataCells.Add(Result);
end;

function TcxPivotGridViewInfo.AddRowItem(ABounds: TRect;
  AItem: TcxPivotGridViewDataItem; ASizeField: TPersistent): TcxPivotGridHeaderCellViewInfo;
begin
  if FNeedCorrectHeaders and (RowsBounds.Top - ABounds.Top >= -1) then
    Dec(ABounds.Top);
  Result := TcxPivotGridHeaderCellViewInfo.Create(
    Painter, ABounds, RowsBounds, BaseStyles.GetRowHeaderParams(AItem));
  Result.Data := AItem;
  with AItem do
  begin
    Result.Neighbors := GetItemNeighbors(ABounds.Top <= RowsBounds.Top, AItem.Level = 0,
      AItem.GetNextVisible = nil, not AItem.HasChildren);
    Result.FSizeField := ASizeField;
    if AItem.IsGrandTotal and (ViewData.RowCount = 1) then
      Result.FSizeField := OptionsView;
  end;
  InitHeaderCell(Result, AItem);
  RowHeaders.Add(Result);
end;

procedure TcxPivotGridViewInfo.InitCellViewParams(
  ACell: TcxPivotGridDataCellViewInfo);
var
  AStyle: TcxPivotGridFocusRectStyle;
begin
  ACell.FSelected := not IsPrinting and not PivotGrid.IsDesigning and ViewData.IsCellSelected(ACell.RowIndex, ACell.ColumnIndex);
  with FocusedCell do
    AStyle := TcxPivotGridFocusRectStyle((ACell.RowIndex = Y) and (ACell.ColumnIndex = X) and ACell.FSelected);
  if (AStyle = frsDot) and not PivotGrid.Controller.Focused then
  begin
    if PivotGrid.OptionsSelection.HideFocusRect then
      AStyle := frsNone
    else
      AStyle := frsLine;
  end;
  ACell.FFocusRectStyle := AStyle;
  ACell.FSelected := ACell.FSelected and (PivotGrid.Controller.Focused or
    not PivotGrid.OptionsSelection.HideSelection);
  ACell.FViewParams := BaseStyles.GetContentParams(ACell);
end;

procedure TcxPivotGridViewInfo.InitializeFields;
var
  AField: TcxPivotGridField;
  I: Integer;
begin
  FFilterHeight := 0;
  FDataFieldsWidth := 0;
  FFieldHeaderHeight := Max(Painter.HeaderHeight(
    cxTextHeight(GetFont(gs_FieldHeader))), GetIconsSize.cx + cxPivotGridDoubleSpace);
  for I := 0 to PivotGrid.FieldCount - 1 do
  begin
    AField := PivotGrid.Fields[I];
    AField.ViewInfo.Initialize(Canvas, Painter, BaseStyles.GetFieldHeaderParams(AField));
    if (AField.Area = faData) and AField.VisibleInGroup then
      Inc(FDataFieldsWidth, AField.HeaderWidth);
    Max(FFieldHeaderHeight, AField.ViewInfo.MeasureHeight);
  end;
  OptionsDataField.ViewInfo.Initialize(Canvas, Painter, BaseStyles.GetFieldHeaderParams(nil));
  if OptionsDataField.GetActualAreaIndex >= 0 then
    Max(FFieldHeaderHeight, OptionsDataField.ViewInfo.MeasureHeight);
end;

procedure TcxPivotGridViewInfo.InitHeaderCell(
  ACell: TcxPivotGridHeaderCellViewInfo; AItem: TcxPivotGridViewDataItem);
begin
  ACell.DisplayText := GetHeaderDisplayText(ACell, AItem);
  ACell.FImages := PivotGrid.GroupHeaderImages;
  ACell.FImageIndex := -1;
  if (ACell.Images <> nil) and (AItem.Field <> nil) then
  begin
    ACell.FImageIndex := AItem.Field.DoGetGroupImageIndex(AItem,
      ACell.FImageAlignHorz, ACell.FImageAlignVert);
  end;
  ACell.FHasButton := AItem.HasButton and DrawExpandButtons;
  ACell.FExpanded := AItem.Expanded;
end;

function TcxPivotGridViewInfo.IsDataFieldVisible(
  AArea: TcxPivotGridDataFieldAreas = []): Boolean;
begin
  Result := (DataBuilder.DataFields.Count > 1);
  if Result and (AArea <> []) then
    Result := OptionsDataField.Area in AArea;
end;

procedure TcxPivotGridViewInfo.CreateRows(ARows: TcxList);

  function CreateRow(AItem: TcxPivotGridViewDataItem;
    ATop, ARight: Integer): Integer;
  var
    AField: TPersistent;
    ABounds: TRect;
    ALevel: Integer;
    AStartItem: TcxPivotGridViewDataItem;
  begin
    Result := AItem.Size;
    AField := nil;
    AStartItem := AItem;
    if AItem.IsDataField then
      ALevel := FRowColumnPos.Count - 1
    else
      ALevel := AItem.Level;
    while AItem.Level >= 0 do
    begin
      if IsGroupItemExist(RowHeaders, AItem) then Break;
      ABounds.Top := ATop - SpaceBetween(AItem, AStartItem);
      ABounds.Bottom := ABounds.Top + AItem.Size;
      if AItem.IsDataField then
        ABounds.Left := GetRowColumnPos(Max(ALevel, AItem.Level), AField)
      else
        ABounds.Left := GetRowColumnPos(AItem.Level, AField);
      ABounds.Right := ARight;
      AddRowItem(ABounds, AItem, AField);
      Dec(ALevel);
      ARight := ABounds.Left;
      AItem := AItem.Parent;
    end;
  end;

var
  I: Integer;
  ATop: Integer;
begin
  ATop := RowsBounds.Top;
  if FNeedCorrectHeaders then
  begin
    Dec(FRowsBounds.Top);
    Inc(FRowsBounds.Right);
  end;
  for I := 0 to ARows.Count - 1 do
  begin
    Inc(ATop, CreateRow(TcxPivotGridViewDataItem(
      ARows.List^[I]), ATop, RowsBounds.Right));
  end;
end;

procedure TcxPivotGridViewInfo.CreateColumns(AColumns: TcxList);

  function CreateColumn(AItem: TcxPivotGridViewDataItem;
    ABottom, ALeft: Integer): Integer;
  var
    ABounds: TRect;
    AStartItem: TcxPivotGridViewDataItem;
  begin
    Result := AItem.Size;
    AStartItem := AItem;
    while AItem.Level >= 0 do
    begin
      if IsGroupItemExist(ColumnHeaders, AItem) then Break;
      ABounds.Left := ALeft - SpaceBetween(AItem, AStartItem);
      ABounds.Right := ABounds.Left + AItem.Size;
      ABounds.Bottom := ABottom;
      if AItem.IsDataField then
        ABounds.Top := ABottom - HeaderHeight
      else
        ABounds.Top := ColumnsBounds.Top + AItem.Level * HeaderHeight;
      AddColumnItem(ABounds, AItem);
      ABottom := ABounds.Top;
      AItem := AItem.Parent;
    end;
  end;

var
  I: Integer;
  ALeft: Integer;
begin
  ALeft := ColumnsBounds.Left;
  for I := 0 to AColumns.Count - 1 do
  begin
    Inc(ALeft, CreateColumn(TcxPivotGridViewDataItem(
      AColumns.List^[I]), ColumnsBounds.Bottom, ALeft));
  end;
end;

procedure TcxPivotGridViewInfo.CalculateRows;
begin
  with FDataCellsBounds do
  begin
    Bottom := Top + PrepareViewDataItems(FRowItems, ViewData.Rows[StartRowIndex],
      cxRectHeight(DataCellsBounds), ViewData.FRowIndex);
    ViewData.RowsPerPage := FRowItems.Count;
    if Bottom > FCellsBounds.Bottom then
    begin
      Bottom := FCellsBounds.Bottom;
      ViewData.RowsPerPage := Max(1, ViewData.RowsPerPage - 1);
    end
    else
      AddPartBackground(cxRectSetTop(FCellsBounds, FDataCellsBounds.Bottom));
  end;
  FRowsBounds := cxRectSetLeft(FDataCellsBounds, FCellsBounds.Left, RowHeadersWidth);
  CreateRows(FRowItems);
end;

procedure TcxPivotGridViewInfo.CalculateHitTest(AHitTest: TcxPivotGridHitTest);
begin
  if not FieldHeaders.CalculateHitTest(AHitTest) then
    if not ColumnHeaders.CalculateHitTest(AHitTest) then
      if not RowHeaders.CalculateHitTest(AHitTest) then
        if not CommonCells.CalculateHitTest(AHitTest) then
          if not DataCells.CalculateHitTest(AHitTest) then
            Prefilter.CalculateHitTest(AHitTest);
end;

procedure TcxPivotGridViewInfo.CalculateCells;
var
  I, J, ALeft, ATop: Integer;
  AColumn, ARow: TcxPivotGridViewDataItem;
  ACell: TcxPivotGridHeaderBackgroundCellViewInfo;
begin
  ATop := DataCellsBounds.Top;
  for I := 0 to FRowItems.Count - 1 do
  begin
    ARow := TcxPivotGridViewDataItem(FRowItems.List^[I]);
    ALeft := DataCellsBounds.Left;
    for J := 0 to FColumnItems.Count - 1 do
    begin
      AColumn := TcxPivotGridViewDataItem(FColumnItems.List^[J]);
        AddDataCell(ARow, AColumn, ALeft, ATop);
      Inc(ALeft, AColumn.Size);
    end;
    Inc(ATop, ARow.Size);
  end;
  if DataCells.Count = 0 then
  begin
    ACell := AddFieldsBackground(DataCellsBounds, cxGetResourceString(@scxDropDataItems),
      (DataBuilder.DataFields.Count = 0) and OptionsView.ColumnFields, faData);
    ACell.FViewParams := FViewParams;
  end;
end;

procedure TcxPivotGridViewInfo.CalculateFieldsLayout;
var
  I: Integer;
begin
  InitializeFields;
//  FFieldHeaderHeight := FFieldHeaderHeight + ;
  FHeaderHeight := FFieldHeaderHeight;
  CalculateFilterLayout;
  FDataCellsBounds := FCellsBounds;
  // row headers
  FRowHeadersWidth := 0;
  for I := 0 to DataBuilder.RowFields.Count - 1 do
    Inc(FRowHeadersWidth, DataBuilder.RowFields[I].GetActualWidth);
  if FRowHeadersWidth = 0 then
    FRowHeadersWidth := OptionsView.GetActualWidth;
  if IsDataFieldVisible([dfaRow]) then
    Inc(FRowHeadersWidth, OptionsDataField.GetActualWidth);
  // cells bounds
  FDataCellsBounds := cxRect(Point(FCellsBounds.Left + RowHeadersWidth,
    FCellsBounds.Top + FilterHeight), FCellsBounds.BottomRight);
  // column rows
  FColumnRowCount := Max(1, DataBuilder.ColumnFields.Count);
  if IsDataFieldVisible([dfaNone, dfaColumn]) then
    Inc(FColumnRowCount);
  FColumnRowCount := Max(1, FColumnRowCount);
  FColumnHeadersHeight := FHeaderHeight * FColumnRowCount;
  // cells bounds
  with OptionsView do
  begin
    Inc(FDataCellsBounds.Top, Max(
     (Byte(DataFields) + Byte(RowFields)) * (FFieldHeaderHeight + cxPivotGridSpace * 2),
      Byte(ColumnFields) * (FFieldHeaderHeight + cxPivotGridSpace * 2) + ColumnHeadersHeight));
  end;
  CalculateDataItemsFields;
  CalculateColumnsFields;
  CalculateRowsFields;
end;

procedure TcxPivotGridViewInfo.CalculateFilterLayout;
var
  AField: TcxPivotGridField;
  AFilterBounds, AFieldBounds: TRect;
  I, ARowFieldCount, AFirstIndex: Integer;
begin
  if not OptionsView.FilterFields then Exit;
  FFilterHeight := FFieldHeaderHeight + cxPivotGridSpace * 2;
  AFieldBounds := cxRectSetTop(FCellsBounds, FCellsBounds.Top + cxPivotGridSpace, FFieldHeaderHeight);
  Inc(AFieldBounds.Left, cxPivotGridHorzSpace);
  ARowFieldCount := 0;
  AFirstIndex := FieldHeaders.Count;
  for I := 0 to DataBuilder.FilterFields.Count - 1 do
  begin
    AField := DataBuilder.FilterFields[I];
    AFieldBounds.Right := AFieldBounds.Left + AField.HeaderWidth;
    if (ARowFieldCount > 0) and GroupHeaderOutOfBounds(AField, AFieldBounds.Right) then
    begin
      with AFieldBounds do
      begin
        Left := FCellsBounds.Left + cxPivotGridHorzSpace;
        Right := Left + AField.HeaderWidth;
        Top := Bottom + cxPivotGridSpace;
        Bottom := Top + FFieldHeaderHeight;
      end;
      Inc(FFilterHeight, FFieldHeaderHeight + cxPivotGridSpace);
      ARowFieldCount := 1;
    end
    else
      Inc(ARowFieldCount);
    AFilterBounds := cxRectSetBottom(FCellsBounds, FCellsBounds.Top + FFilterHeight, FFieldHeaderHeight);
    AddFieldHeader(AFieldBounds, AField, faFilter, I);
    AFieldBounds.Left := AFieldBounds.Right + cxPivotGridHorzSpace;
  end;
  AFilterBounds := cxRectSetHeight(FCellsBounds, FFilterHeight);
  // filter separator cell
  if OptionsView.FilterSeparator then
  begin
    Inc(FFilterHeight, cxPivotGridDoubleSpace + cxPivotGridFilterSeparatorHeight);
    AFilterBounds.Bottom := FCellsBounds.Top + FFilterHeight;
  end;
  // background cell for filter area fields
  AddFieldsBackground(AFilterBounds, cxGetResourceString(@scxDropFilterFields),
    DataBuilder.FilterFields.Count = 0, faFilter);
  if OptionsView.FilterSeparator then
    AddFilterSeparator(AFilterBounds.Bottom - cxTextOffset - cxPivotGridFilterSeparatorHeight);
  CreateDragDropAreaInfo(AFilterBounds, AFirstIndex, faFilter);
end;

procedure TcxPivotGridViewInfo.CalculateColumns;
begin
  with FDataCellsBounds  do
  begin
    Right := Left + PrepareViewDataItems(FColumnItems, ViewData.Columns[StartColumnIndex],
      {GetColumnWidth,} cxRectWidth(DataCellsBounds), ViewData.FColumnIndex);
    ViewData.ColumnsPerPage := FColumnItems.Count;
    if Right > Bounds.Right then
    begin
      Right := Bounds.Right;
      ViewData.ColumnsPerPage := Max(1, ViewData.ColumnsPerPage - 1);
    end
    else
      AddPartBackground(Rect(Right, Top - FColumnHeadersHeight, Self.Bounds.Right, Bottom));
  end;
  FColumnBounds := cxRectSetBottom(FDataCellsBounds, FDataCellsBounds.Top, FColumnHeadersHeight);
  CreateColumns(FColumnItems);
end;

procedure TcxPivotGridViewInfo.CheckCellSelection(
  ACell: TcxPivotGridDataCellViewInfo);
var
  AIsSelected: Boolean;
begin
  AIsSelected := ACell.Selected;
  InitCellViewParams(ACell);
  if (ACell.Selected or AIsSelected) and ACell.Visible then
  begin
    ACell.FCalculated := False;
    InvalidateRect(ACell.ClipRect);
  end;
end;

procedure TcxPivotGridViewInfo.CorrectBackground;
var
  ACellIndex, I: Integer;
  ACell: TcxPivotGridHeaderBackgroundCellViewInfo;
  AFieldHeader: TcxPivotGridFieldHeaderCellViewInfo;
begin
  for I := 0 to FieldHeaders.Count - 1 do
  begin
    AFieldHeader := TcxPivotGridFieldHeaderCellViewInfo(FieldHeaders[I]);
    for ACellIndex := 0 to CommonCells.Count - 1 do
    begin
      if not (CommonCells[ACellIndex] is TcxPivotGridHeaderBackgroundCellViewInfo) then Continue;
      ACell := TcxPivotGridHeaderBackgroundCellViewInfo(CommonCells[ACellIndex]);
      if cxRectIntersect(AFieldHeader.Bounds, ACell.Bounds) then
      begin
        AFieldHeader.FBackground := ACell;
        Break;
      end;
    end;
  end;
end;

procedure TcxPivotGridViewInfo.DoCalculate;
begin
  PivotGrid.Controller.Clear;
  try
    FViewParams := Styles.GetBackgroundParams;
    FNeedCorrectHeaders := not IsPrinting and
      (Painter.HeaderBorders([nLeft..nBottom]) <> cxBordersAll);
    FCellsBounds := Bounds;
    Prefilter.Calculate(FCellsBounds);
    FDataCellsBounds := FCellsBounds;
    FFieldHeadersBounds.Rect := FCellsBounds;
    CalculateFieldsLayout;
    CalculateColumns;
    CalculateRows;
    FFieldHeadersBounds.Bottom := DataCellsBounds.Top;
    CalculateCells;
    CorrectBackground;
    FCellsBounds := Bounds;
    FCellsBounds.Bottom := DataCellsBounds.Bottom;
    FCellsBounds.Right := DataCells[DataCells.Count - 1].Bounds.Right;
    if IsPrinting then
    begin
      Prefilter.CorrectBoundsForPrinting(FCellsBounds);
      CommonCells.CorrectBoundsForPrinting(FCellsBounds);
    end;
    PivotGrid.NeedUpdateScrollBarsPost := True;
  finally
    PivotGrid.Controller.Update;
  end;
end;

function TcxPivotGridViewInfo.GetHeaderDisplayText(ACell: TcxPivotGridHeaderCellViewInfo; AItem: TcxPivotGridViewDataItem): string;

  function InnerGetCustomizingGrandTotalText: string;
  begin
    if AItem.GroupItem is TcxPivotGridColumnItem then
      Result := PivotGrid.OptionsView.ColumnGrandTotalText
    else
      if AItem.GroupItem is TcxPivotGridRowItem then
        Result := PivotGrid.OptionsView.RowGrandTotalText
      else
        Result := '';
  end;

var
  S: string;
begin
  Result := VarToStr(AItem.Value);
  if AItem is TcxPivotGridViewDataTotalItem then
  begin
    if not AItem.IsGrandTotal then
      with TcxPivotGridViewDataTotalItem(AItem) do
        Field.DoGetTotalDisplayText(GroupItem, Result)
    else
    begin
      S := InnerGetCustomizingGrandTotalText;
      if Length(S) > 0 then
        Result := S;
    end
  end
  else
    Result := AItem.GroupItem.DisplayText;
end;

procedure TcxPivotGridViewInfo.CalculateColumnsFields;

  function GetColumnField(AIndex: Integer): TcxPivotGridField;
  begin
    if IsDataFieldVisible([dfaColumn]) then
    begin
      if AIndex = OptionsDataField.GetActualAreaIndex then
      begin
        Result := nil;
        Exit;
      end
      else
        if AIndex >= OptionsDataField.GetActualAreaIndex then
          Dec(AIndex);
    end;
    Result := DataBuilder.ColumnFields[AIndex];
  end;

var
  I, AFirstIndex: Integer;
  AField: TcxPivotGridField;
  AAreaBounds, ABounds: TRect;
begin
  ABounds := cxRectSetTop(FCellsBounds, FCellsBounds.Top + FilterHeight);
  ABounds.Bottom := DataCellsBounds.Top - ColumnHeadersHeight;
  ABounds.Left := Bounds.Left + RowHeadersWidth;
  AddFieldsBackground(ABounds, cxGetResourceString(@scxDropColumnFields),
    (ColumnFieldsCount = 0) and OptionsView.ColumnFields, faColumn);
  if not OptionsView.ColumnFields then Exit;
  AAreaBounds := ABounds;
  AFirstIndex := FieldHeaders.Count;
  InflateRect(ABounds, 0, -cxPivotGridSpace);
  ABounds.Bottom := ABounds.Top + FFieldHeaderHeight;
  for I := 0 to ColumnFieldsCount - 1 do
  begin
    AField := GetColumnField(I);
    if AField = nil then
      ABounds.Right := ABounds.Left + OptionsDataField.HeaderWidth
    else
      ABounds.Right := ABounds.Left + AField.HeaderWidth;
    AddFieldHeader(ABounds, AField, faColumn, I);
    ABounds.Left := ABounds.Right + cxPivotGridHorzSpace;
  end;
  CreateDragDropAreaInfo(AAreaBounds, AFirstIndex, faColumn);
end;

procedure TcxPivotGridViewInfo.CalculateDataItemsFields;
var
  AField: TcxPivotGridField;
  ABounds, AAreaBounds: TRect;
  I, ACount, AFirstIndex: Integer;
begin
  ACount := DataBuilder.DataFields.Count;
  ABounds := cxRectSetTop(FCellsBounds, FCellsBounds.Top + FilterHeight,
    FFieldHeaderHeight + cxPivotGridSpace * 2);
  if not OptionsView.RowFields then
    ABounds.Bottom := DataCellsBounds.Top;
  ABounds.Right := ABounds.Left + RowHeadersWidth;
  AddFieldsBackground(ABounds, cxGetResourceString(@scxDropDataItems),
    (DataBuilder.DataFields.Count = 0) and OptionsView.DataFields, faData);
  if not OptionsView.DataFields then Exit;
  AAreaBounds := ABounds;
  AFirstIndex := FieldHeaders.Count;
  Inc(ABounds.Top, cxPivotGridSpace);
  Inc(ABounds.Left, cxPivotGridHorzSpace);
  ABounds.Bottom := ABounds.Top + FFieldHeaderHeight;
  for I := 0 to ACount - 1 do
  begin
    AField := DataBuilder.DataFields[I];
    if FDataFieldsWidth > (Bounds.Left + RowHeadersWidth) - cxPivotGridHorzSpace then
    begin
      ABounds.Right := ABounds.Left + MulDiv(AField.HeaderWidth,
        RowHeadersWidth - cxPivotGridHorzSpace, FDataFieldsWidth);
      ABounds.Right := Min(ABounds.Right, Bounds.Left + RowHeadersWidth);
    end
    else
      ABounds.Right := ABounds.Left + AField.HeaderWidth;
    Dec(ABounds.Right, cxPivotGridHorzSpace);
    if ABounds.Right > ABounds.Left then
      AddFieldHeader(ABounds, AField, faData, I);
    ABounds.Left := ABounds.Right + cxPivotGridHorzSpace;
  end;
  CreateDragDropAreaInfo(AAreaBounds, AFirstIndex, faData);
end;

procedure TcxPivotGridViewInfo.CalculateRowsFields;
var
  AField: TcxPivotGridField;
  I, AWidth, ALeft, AFirstIndex: Integer;
  AreaBounds, ABounds: TRect;
begin
  ABounds := cxRectSetTop(FCellsBounds, FCellsBounds.Top + FilterHeight);
  ABounds.Bottom := DataCellsBounds.Top;
  if OptionsView.DataFields then
    Inc(ABounds.Top, FieldHeaderHeight + cxPivotGridSpace * 2);
  ABounds.Right := Bounds.Left + RowHeadersWidth;
  AreaBounds := ABounds;
  InflateRect(ABounds, 0, -cxPivotGridSpace);
  ABounds.Top := ABounds.Bottom - FieldHeaderHeight;
  ABounds.Left := Bounds.Left + cxPivotGridHorzSpace;
  ALeft := Bounds.Left;
  AFirstIndex := FieldHeaders.Count;
  for I := 0 to RowFieldsCount - 1 do
  begin
    FRowColumnPos.Add(Pointer(ALeft));
    AField := GetRowField(I);
    if AField = nil then
      AWidth := OptionsDataField.ActualWidth
    else
      AWidth := AField.ActualWidth;
    Inc(ALeft, AWidth);
    ABounds.Right := ABounds.Left + AWidth - cxPivotGridHorzSpace;
    if I = 0 then Dec(ABounds.Right, cxPivotGridHorzSpace);
    if OptionsView.RowFields then
      AddFieldHeader(ABounds, AField, faRow, I);
    ABounds.Left := ABounds.Right + cxPivotGridHorzSpace;
  end;
  if OptionsView.RowFields then
  begin
    AddFieldsBackground(AreaBounds, cxGetResourceString(@scxDropRowFields),
      OptionsView.RowFields and (RowFieldsCount = 0), faRow);
    CreateDragDropAreaInfo(AreaBounds, AFirstIndex, faRow);
  end;
end;

procedure TcxPivotGridViewInfo.CreateDragDropAreaInfo(const AAreaBounds: TRect;
  AStartIndex: Integer; AArea: TcxPivotGridFieldArea);
var
  ABounds, R, R1: TRect;
  AIsLast: Boolean;
  I, AIndex, APos, ARowCount, ARow: Integer;
  ACell: TcxPivotGridFieldHeaderCellViewInfo;
begin
  ARowCount := 1;
  for I := AStartIndex to FieldHeaders.Count - 2 do
    if FieldHeaders[I].Bounds.Top <> FieldHeaders[I + 1].Bounds.Top then Inc(ARowCount);
  ARow := 0;
  ABounds := AAreaBounds;
  AIndex := 0;
  I := AStartIndex;
  while I < FieldHeaders.Count do
  begin
    ACell := TcxPivotGridFieldHeaderCellViewInfo(FieldHeaders[I]);
    ABounds := ACell.Bounds;
    while (ACell.Group <> nil) and ACell.Expanded do
    begin
      Inc(I);
      Inc(AIndex);
      ACell := TcxPivotGridFieldHeaderCellViewInfo(FieldHeaders[I]);
      ABounds.Right := ACell.Bounds.Right;
    end;
    cxRectSplitHorz(ABounds, R, R1);
    R.Left := Max(R.Left - cxPivotGridHalfSpace - 1, AAreaBounds.Left);
    R1.Right := Min(R1.Right + cxPivotGridHalfSpace, AAreaBounds.Right);
    APos := R1.Right;
    AIsLast := (I = FieldHeaders.Count - 1) or
      (ACell.Bounds.Top <> FieldHeaders[I + 1].Bounds.Top);
    ABounds.Top := MulDiv(cxRectHeight(AAreaBounds), ARow, ARowCount);
    ABounds.Bottom := MulDiv(cxRectHeight(AAreaBounds), ARow + 1, ARowCount);
    OffsetRect(ABounds, 0, AAreaBounds.Top);
    AddDragDropAreaInfo(R.Left, ABounds, R, AArea, AIndex, ACell.Field);
    if AIsLast then
    begin
      R1.Right := AAreaBounds.Right;
      Inc(ARow);
    end;
    AddDragDropAreaInfo(APos, ABounds, R1, AArea, AIndex + 1, ACell.Field);
    Inc(AIndex);
    Inc(I);
  end;
  if AStartIndex = FieldHeaders.Count then
  begin
    R := cxRectInflate(AAreaBounds, -cxPivotGridHorzSpace, -cxPivotGridHorzSpace * 2);
    AddDragDropAreaInfo(R.Left, AAreaBounds, R, AArea, 0, nil);
  end;
end;

function TcxPivotGridViewInfo.IsGroupItemExist(
  AList: TList; AItem: TcxPivotGridViewDataItem): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to AList.Count - 1 do
  begin
    Result := TcxPivotGridHeaderCellViewInfo(AList.List^[I]).Data = AItem;
    if Result then Break;
  end;
end;

function TcxPivotGridViewInfo.PrepareViewDataItems(
  var AList: TcxList; AStartItem: TcxPivotGridViewDataItem;
  AAvailableSize: Integer; var AStartIndex: Integer): Integer;
var
  AItem: TcxPivotGridViewDataItem;
begin
  AItem := AStartItem;
  Result := 0;
  repeat
    Dec(AAvailableSize, AItem.Size);
    Inc(Result, AItem.Size);
    AList.Add(AItem);
    AItem := AItem.NextVisible;
  until (AItem = nil) or (AAvailableSize <= 0);
  AItem := AStartItem.PrevVisible;
  while (AAvailableSize > 0) and (AItem <> nil) do
  begin
    Dec(AAvailableSize, AItem.Size);
    if AAvailableSize > 0 then
    begin
      AList.Insert(0, AItem);
      Inc(Result, AItem.Size);
      if not IsPrinting then
        Dec(AStartIndex);
    end;
    AItem := AItem.PrevVisible;
  end;
end;

function TcxPivotGridViewInfo.SpaceBetween(
  AItem1, AItem2: TcxPivotGridViewDataItem): Integer;
begin
  Result := 0;
  while AItem1.ItemCount > 0 do
    AItem1 := AItem1.First;
  while AItem1 <> AItem2 do
  begin
    Inc(Result, AItem1.Size);
    AItem1 := AItem1.GetNextVisible;
  {$IFDEF TESTING}
    Assert(AItem1 <> nil, 'Invalid item');
  {$ENDIF}
  end;
end;

function TcxPivotGridViewInfo.GetDataBuilder: TcxPivotGridDataBuilder;
begin
  Result := PivotGrid.DataBuilder;
end;

function TcxPivotGridViewInfo.GetColumnFieldsCount: Integer;
begin
  Result := DataBuilder.ColumnFields.Count;
  if IsDataFieldVisible([dfaColumn]) then
     Inc(Result);
end;

function TcxPivotGridViewInfo.GetFocusedCell: TPoint;
begin
  Result := ViewData.FocusedCell;
end;

function TcxPivotGridViewInfo.GetIconsSize: TSize;
begin
  with PivotGrid do
  begin
    if GroupHeaderImages <> nil then
      Result := Size(GroupHeaderImages.Width, GroupHeaderImages.Height)
    else
      Result := Size(0, 0);
    if FieldHeaderImages <> nil then
    begin
      Result.cx := Max(Result.cx, FieldHeaderImages.Width);
      Result.cy := Max(Result.cy, FieldHeaderImages.Height);
    end;
  end;
end;

function TcxPivotGridViewInfo.GetOptionsDataField: TcxPivotGridOptionsDataField;
begin
  Result := PivotGrid.OptionsDataField;
end;

function TcxPivotGridViewInfo.GetOptionsView: TcxPivotGridOptionsView;
begin
  Result := PivotGrid.OptionsView;
end;

function TcxPivotGridViewInfo.GetRowFieldsCount: Integer;
begin
  Result := DataBuilder.RowFields.Count;
  if IsDataFieldVisible([dfaRow]) then
    Inc(Result);
end;

function TcxPivotGridViewInfo.GetStyles: TcxPivotGridStyles;
begin
  Result := PivotGrid.Styles;
end;

function TcxPivotGridViewInfo.GetViewData: TcxPivotGridViewData;
begin
  Result := PivotGrid.ViewData;
end;

{ TcxPivotGridPainter }

constructor TcxPivotGridPainter.Create(AOwner: TcxCustomPivotGrid);
begin
  FPivotGrid := AOwner;
end;

procedure TcxPivotGridPainter.Paint(ACanvas: TcxCanvas);
begin
  FCanvas := ACanvas;
  FViewInfo := PivotGrid.ViewInfo;
  FViewInfo.BeforePaint;
  DoPaint;
  FViewInfo.AfterPaint;
end;

procedure TcxPivotGridPainter.DoPaint;
begin
  with ViewInfo do
  begin
    Canvas.SaveState;
    try
      FieldHeaders.Paint(Canvas, DoCustomDrawFieldHeader);
      FieldHeaders.ExcludeFromClipping(Canvas);
      ColumnHeaders.Paint(Canvas, DoCustomDrawColumnHeader);
      CommonCells.Paint(Canvas, DoCustomDrawPart);
      RowHeaders.Paint(Canvas, DoCustomDrawRowHeader);
      DataCells.Paint(Canvas, DoCustomDrawDataCell);
      Prefilter.Paint(Canvas, DoCustomDrawPart);
    finally
      Canvas.RestoreState;
    end;
  end;
end;

procedure TcxPivotGridPainter.DoCustomDrawFieldHeader(ACanvas: TcxCanvas;
  ACell: TcxPivotGridCustomCellViewInfo; var ADone: Boolean);
begin
  PivotGrid.DoCustomDrawFieldHeader(ACanvas,
    TcxPivotGridFieldHeaderCellViewInfo(ACell), ADone);
end;

procedure TcxPivotGridPainter.DoCustomDrawColumnHeader(ACanvas: TcxCanvas;
  ACell: TcxPivotGridCustomCellViewInfo; var ADone: Boolean);
begin
  PivotGrid.DoCustomDrawColumnHeader(ACanvas,
    TcxPivotGridHeaderCellViewInfo(ACell), ADone);
end;

procedure TcxPivotGridPainter.DoCustomDrawPart(ACanvas: TcxCanvas;
  ACell: TcxPivotGridCustomCellViewInfo; var ADone: Boolean);
begin
  PivotGrid.DoCustomDrawPart(ACanvas, ACell, ADone);
end;

procedure TcxPivotGridPainter.DoCustomDrawRowHeader(ACanvas: TcxCanvas;
  ACell: TcxPivotGridCustomCellViewInfo; var ADone: Boolean);
begin
  PivotGrid.DoCustomDrawRowHeader(ACanvas,
    TcxPivotGridHeaderCellViewInfo(ACell), ADone);
end;

procedure TcxPivotGridPainter.DoCustomDrawDataCell(ACanvas: TcxCanvas;
  ACell: TcxPivotGridCustomCellViewInfo; var ADone: Boolean);
begin
  PivotGrid.DoCustomDrawCell(ACanvas,
    TcxPivotGridDataCellViewInfo(ACell), ADone);
end;

{ TcxPivotGridCustomStyles }

constructor TcxPivotGridCustomStyles.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  BitmapInViewParams := True;
end;

procedure TcxPivotGridCustomStyles.Assign(Source: TPersistent);
var
  I: Integer;
begin
  if Source is TcxPivotGridStyles then
  begin
    for I := 0 to gs_MaxStyleIndex do
      SetValue(I, TcxPivotGridStyles(Source).GetValue(I));
  end;
  inherited Assign(Source);
end;

function TcxPivotGridCustomStyles.GetBackgroundParams: TcxViewParams;
begin
  GetViewParams(gs_Background, nil, nil, Result);
  CheckViewParams(Result);
end;

function TcxPivotGridCustomStyles.GetColumnHeaderParams(
  AColumn: TcxPivotGridViewDataItem): TcxViewParams;
var
  AStyle: TcxStyle;
begin
  AStyle := nil;
  if Assigned(FOnGetColumnHeaderStyle) then
    FOnGetColumnHeaderStyle(PivotGrid, AColumn, AStyle);
  if AStyle = nil then
    //todo: optimize get style for fastest working with styles
    GetViewParams(gs_ColumnHeader, nil, nil, Result)
  else
    GetViewParams(gs_ColumnHeader, nil, AStyle, Result);
  CheckViewParams(Result);
end;

function TcxPivotGridCustomStyles.GetColumnMaximumValueParams: TcxViewParams;
begin
  GetViewParams(gs_ColumnMaximumValue, nil, nil, Result);
  CheckViewParams(Result);
end;

function TcxPivotGridCustomStyles.GetColumnMinimumValueParams: TcxViewParams;
begin
  GetViewParams(gs_ColumnMinimumValue, nil, nil, Result);
  CheckViewParams(Result);
end;

function TcxPivotGridCustomStyles.GetContentParams(
  ACell: TcxPivotGridDataCellViewInfo): TcxViewParams;
var
  AStyle: TcxStyle;
  ASelParams: TcxViewParams;
  AStyleIndex: Integer;
begin
  AStyle := nil;
  if Assigned(FOnGetContentStyle) then
  begin
    ACell.CheckVisibleInfo;
    FOnGetContentStyle(PivotGrid, ACell, AStyle);
  end;
  AStyleIndex := GetContentStyleIndexByCell(ACell);
  GetViewParams(AStyleIndex, ACell, AStyle, Result);
  if ACell.Selected then
  begin
    ASelParams := GetSelectionParams;
    Result.Bitmap := nil;
    Result.Color := ASelParams.Color;
    Result.TextColor := ASelParams.TextColor;
  end;
  CheckViewParams(Result);
end;

function TcxPivotGridCustomStyles.GetFieldHeaderParams(
  AField: TcxPivotGridField): TcxViewParams;
var
  AStyle: TcxStyle;
begin
  AStyle := nil;
  if Assigned(FOnGetFieldHeaderStyle) then
    FOnGetFieldHeaderStyle(PivotGrid, AField, AStyle);
  GetViewParams(gs_FieldHeader, AField, AStyle, Result);
  CheckViewParams(Result);
end;

function TcxPivotGridCustomStyles.GetFilterSeparatorParams: TcxViewParams;
begin
  GetViewParams(gs_FilterSeparator, nil, nil, Result);
  CheckViewParams(Result);
end;

function TcxPivotGridCustomStyles.GetHeaderBackgroundParams(
  AArea: TcxPivotGridFieldArea): TcxViewParams;
const
  AStyleID: array[TcxPivotGridFieldArea] of Integer =
    (gs_ColumnHeaderArea, gs_RowHeaderArea, gs_FilterHeaderArea, gs_DataHeaderArea);
begin
  GetViewParams(AStyleID[AArea], nil, nil, Result);
  CheckViewParams(Result);
end;

function TcxPivotGridCustomStyles.GetMaximumValueParams: TcxViewParams;
begin
  GetViewParams(gs_MaximumValue, nil, nil, Result);
  CheckViewParams(Result);
end;

function TcxPivotGridCustomStyles.GetMinimumValueParams: TcxViewParams;
begin
  GetViewParams(gs_MaximumValue, nil, nil, Result);
  CheckViewParams(Result);
end;

function TcxPivotGridCustomStyles.GetPrefilterParams: TcxViewParams;
begin
  GetViewParams(gs_Prefilter, nil, nil, Result);
  CheckViewParams(Result);
end;

function TcxPivotGridCustomStyles.GetRowHeaderParams(
  ARow: TcxPivotGridViewDataItem): TcxViewParams;
var
  AStyle: TcxStyle;
begin
  AStyle := nil;
  if Assigned(FOnGetRowHeaderStyle) then
    FOnGetRowHeaderStyle(PivotGrid, ARow, AStyle);
  if AStyle = nil then
    //todo: optimize get style for fastest working with styles
    GetViewParams(gs_RowHeader, nil, nil, Result)
  else
    GetViewParams(gs_RowHeader, nil, AStyle, Result);
  CheckViewParams(Result);
end;

function TcxPivotGridCustomStyles.GetRowMaximumValueParams: TcxViewParams;
begin
  GetViewParams(gs_RowMaximumValue, nil, nil, Result);
  CheckViewParams(Result);
end;

function TcxPivotGridCustomStyles.GetRowMinimumValueParams: TcxViewParams;
begin
  GetViewParams(gs_RowMinimumValue, nil, nil, Result);
  CheckViewParams(Result);
end;

function TcxPivotGridCustomStyles.GetSelectionParams: TcxViewParams;
const
  AStyleIndex: array[Boolean] of Integer = (gs_Inactive, gs_Selected);
begin
  GetViewParams(AStyleIndex[PivotGrid.Controller.Focused], nil, nil, Result);
end;

procedure TcxPivotGridCustomStyles.Changed(AIndex: Integer);
begin
  inherited Changed(AIndex);
  if PivotGrid <> nil then
    PivotGrid.LayoutChanged;
end;

procedure TcxPivotGridCustomStyles.CheckViewParams(var AParams: TcxViewParams);
begin
  if SuppressContentColoration then
    AParams.Color := clWindow;
  if SuppressBackgroundBitmaps then
    AParams.Bitmap := nil;
end;

function TcxPivotGridCustomStyles.GetContentStyleIndexByCell(ACell: TcxPivotGridDataCellViewInfo): Integer;
const
  AStyleID: array[TcxPivotGridDataCellLimitValueType] of Integer =
    (gs_ColumnMaximumValue, gs_ColumnMinimumValue, gs_RowMaximumValue,
    gs_RowMinimumValue, gs_MaximumValue, gs_MinimumValue);
var
  ALimitValues: TcxPivotGridDataCellLimitValueTypes;
  I: TcxPivotGridDataCellLimitValueType;
  ANeedLimitValues: Boolean;
begin
  if ACell.IsTotal then
    Result := gs_Total
  else
  begin
    Result := gs_Content;
    ANeedLimitValues := False;
    for I := lvtColumnMaximum to lvtMinimum do
      ANeedLimitValues := ANeedLimitValues or (Values[AStyleID[I]] <> nil);
    if ANeedLimitValues then
    begin
      ALimitValues := ACell.LimitValueTypes;
      if (lvtMaximum in ALimitValues) and (Values[AStyleID[lvtMaximum]] <> nil) then
        Result := AStyleID[lvtMaximum];
      if (Result = gs_Content) and (lvtMinimum in ALimitValues) and (Values[AStyleID[lvtMinimum]] <> nil) then
        Result := AStyleID[lvtMinimum];
      if (Result = gs_Content) and (lvtColumnMaximum in ALimitValues) and (Values[AStyleID[lvtColumnMaximum]] <> nil) then
        Result := AStyleID[lvtColumnMaximum];
      if (Result = gs_Content) and (lvtColumnMinimum in ALimitValues) and (Values[AStyleID[lvtColumnMinimum]] <> nil) then
        Result := AStyleID[lvtColumnMinimum];
      if (Result = gs_Content) and (lvtRowMaximum in ALimitValues) and (Values[AStyleID[lvtRowMaximum]] <> nil) then
        Result := AStyleID[lvtRowMaximum];
      if (Result = gs_Content) and (lvtRowMinimum in ALimitValues) and (Values[AStyleID[lvtRowMinimum]] <> nil) then
        Result := AStyleID[lvtRowMinimum];
    end;
  end;
end;

procedure TcxPivotGridCustomStyles.GetDefaultHeadersAreaViewParams(
  out AParams: TcxViewParams);
var
  APivotGrid: TcxCustomPivotGrid;
  APainter: TcxCustomLookAndFeelPainterClass;
begin
  APivotGrid := PivotGrid;
  APainter := APivotGrid.LookAndFeelPainter;
  InternalGetViewParams(gs_HeaderBackground, nil, nil, AParams);
  if AParams.Font = nil then
    AParams.Font := APivotGrid.Font;
  if AParams.Color = clDefault then
    AParams.Color := APainter.PivotGridHeadersAreaColor;
  if AParams.TextColor = clDefault then
    AParams.TextColor := APainter.PivotGridHeadersAreaTextColor;
end;

procedure TcxPivotGridCustomStyles.GetDefaultViewParams(Index: Integer;
  AData: TObject; out AParams: TcxViewParams);
var
  APivotGrid: TcxCustomPivotGrid;
  APainter: TcxCustomLookAndFeelPainterClass;
begin
  APivotGrid := PivotGrid;
  APainter := APivotGrid.LookAndFeelPainter;
  AParams.Font := APivotGrid.Font;
  AParams.TextColor := APivotGrid.Font.Color;
  AParams.Color := APivotGrid.Color;
  AParams.Bitmap := nil;
  case Index of
    gs_FieldHeader, gs_RowHeader, gs_ColumnHeader:
      begin
        AParams.Color := APainter.DefaultHeaderColor;
        AParams.TextColor := APainter.DefaultHeaderTextColor;
        if (Index = gs_FieldHeader) and (AData = nil) then
          AParams.TextColor := clRed;
      end;
    gs_HeaderBackground:
      begin
        AParams.Color := APainter.DefaultHeaderBackgroundColor;
        AParams.TextColor := APainter.DefaultHeaderBackgroundTextColor;
      end;
    gs_Prefilter:
      begin
        AParams.Color := APainter.DefaultHeaderBackgroundColor;
        AParams.TextColor := APainter.DefaultFilterBoxTextColor;
      end;
    gs_ColumnHeaderArea, gs_RowHeaderArea, gs_FilterHeaderArea, gs_DataHeaderArea:
      GetDefaultHeadersAreaViewParams(AParams);
    gs_FilterSeparator:
      begin
        AParams.TextColor := APainter.DefaultSeparatorColor;
        AParams.Color := APainter.DefaultHeaderBackgroundColor;
      end;
    gs_Content, gs_ColumnMaximumValue, gs_ColumnMinimumValue, gs_MaximumValue,
    gs_MinimumValue, gs_RowMaximumValue, gs_RowMinimumValue, gs_Background:
      begin
        AParams.Color := ColorToRgb(APainter.DefaultContentColor);
        AParams.TextColor := APainter.DefaultContentTextColor;
      end;
    gs_Total:
      begin
        AParams.Color := Dark(ColorToRgb(APainter.DefaultContentColor), 90);
        AParams.TextColor := APainter.DefaultContentTextColor;
      end;
    gs_Selected:
      begin
        AParams.Color := APainter.DefaultSelectionColor;
        AParams.TextColor := APainter.DefaultSelectionTextColor;
      end;
    gs_Inactive:
      begin
        AParams.Color := APainter.DefaultInactiveColor;
        AParams.TextColor := APainter.DefaultInactiveTextColor;
      end;
  else
    inherited GetDefaultViewParams(Index, AData, AParams);
  end;
end;

function TcxPivotGridCustomStyles.GetPivotGrid: TcxCustomPivotGrid;
begin
  if GetOwner is TcxCustomPivotGrid then
    Result := GetOwner as TcxCustomPivotGrid
  else
    Result := nil;
end;

{ TcxPivotGridStyles }

function TcxPivotGridStyles.GetColumnHeaderParams(AColumn: TcxPivotGridViewDataItem): TcxViewParams;
begin
  if (AColumn.Field <> nil) and (AColumn.Field.Styles.ColumnHeader <> nil) then
    Result := AColumn.Field.Styles.GetColumnHeaderParams(AColumn)
  else
    Result := inherited GetColumnHeaderParams(AColumn);
end;

function TcxPivotGridStyles.GetContentParams(ACell: TcxPivotGridDataCellViewInfo): TcxViewParams;
var
  AStyleIndex: Integer;
begin
  AStyleIndex := -1;
  if (ACell.DataField <> nil) then
  begin
    AStyleIndex := ACell.DataField.Styles.GetContentStyleIndexByCell(ACell);
    if ACell.DataField.Styles.Values[AStyleIndex] <> nil then
      Result := ACell.DataField.Styles.GetContentParams(ACell)
    else
      AStyleIndex := -1;
  end;
  if AStyleIndex = -1 then
    Result := inherited GetContentParams(ACell);
end;

function TcxPivotGridStyles.GetRowHeaderParams(ARow: TcxPivotGridViewDataItem): TcxViewParams;
begin
  if (ARow.Field <> nil) and (ARow.Field.Styles.RowHeader <> nil) then
    Result := ARow.Field.Styles.GetRowHeaderParams(ARow)
  else
    Result := inherited GetRowHeaderParams(ARow);
end;

{ TcxPivotGridFieldStyles }

procedure TcxPivotGridFieldStyles.GetDefaultViewParams(Index: Integer;
  AData: TObject; out AParams: TcxViewParams);
begin
  PivotGrid.Styles.GetViewParams(Index, AData, PivotGrid.Styles.Values[Index], AParams)
end;

function TcxPivotGridFieldStyles.GetPivotGrid: TcxCustomPivotGrid;
begin
  if Owner is TcxCustomPivotGrid then
    Result := TcxCustomPivotGrid(Owner)
  else
    if (Owner is TcxPivotGridField) then
      Result := TcxPivotGridField(Owner).PivotGrid
    else
      Result := nil;
end;

{ TcxPivotGridStyleSheet }

class function TcxPivotGridStyleSheet.GetStylesClass: TcxCustomStylesClass;
begin
  Result := TcxPivotGridStyles;
end;

function TcxPivotGridStyleSheet.GetStylesValue: TcxPivotGridStyles;
begin
  Result := GetStyles as TcxPivotGridStyles;
end;

procedure TcxPivotGridStyleSheet.SetStylesValue(AValue: TcxPivotGridStyles);
begin
  SetStyles(AValue);
end;

{ TcxPivotGridCustomOptions }

constructor TcxPivotGridCustomOptions.Create(AOwner: TcxCustomPivotGrid);
begin
  FPivotGrid := AOwner;
end;

procedure TcxPivotGridCustomOptions.Assign(Source: TPersistent);
begin
  if Source is TcxPivotGridCustomOptions then
  else
    inherited Assign(Source);
end;

function TcxPivotGridCustomOptions.GetOwner: TPersistent;
begin
  Result := FPivotGrid;
end;

procedure TcxPivotGridCustomOptions.Changed;
begin
  PivotGrid.LayoutChanged;
end;

procedure TcxPivotGridCustomOptions.SetBoolValue(
  var AFieldValue: Boolean; AValue: Boolean);
begin
  if AFieldValue <> AValue then
  begin
    AFieldValue := AValue;
    Changed;
  end;
end;

{  TcxPivotGridOptionsBehavior }

constructor TcxPivotGridOptionsBehavior.Create(AOwner: TcxCustomPivotGrid);
begin
  inherited Create(AOwner);
  FieldHeaderHints := True;
  GroupHeaderHints := True;
end;

procedure TcxPivotGridOptionsBehavior.Assign(Source: TPersistent);
begin
  if Source is TcxPivotGridOptionsBehavior then
  begin
    CellHints := TcxPivotGridOptionsBehavior(Source).CellHints;
    FieldHeaderHints := TcxPivotGridOptionsBehavior(Source).FieldHeaderHints;
    GroupHeaderHints := TcxPivotGridOptionsBehavior(Source).GroupHeaderHints;
  end
  else
    inherited Assign(Source);
end;

{ TcxPivotGridOptionsCustomize }

constructor TcxPivotGridOptionsCustomize.Create(AOwner: TcxCustomPivotGrid);
begin
  inherited Create(AOwner);
  FFiltering := True;
  FHiding := True;
  FMoving := True;
  FQuickCustomization := True;
  FQuickPrefiltering := True;
  FSizing := True;
  FSorting := True;
  FilterResizable := True;
end;

procedure TcxPivotGridOptionsCustomize.Assign(Source: TPersistent);
begin
  if Source is TcxPivotGridOptionsCustomize then
  begin
    FFiltering := TcxPivotGridOptionsCustomize(Source).FFiltering;
    FHiding := TcxPivotGridOptionsCustomize(Source).FHiding;
    FMoving := TcxPivotGridOptionsCustomize(Source).FMoving;
    FQuickCustomization := TcxPivotGridOptionsCustomize(Source).FQuickCustomization;
    FQuickPrefiltering := TcxPivotGridOptionsCustomize(Source).FQuickPrefiltering;
    FSizing := TcxPivotGridOptionsCustomize(Source).FSizing;
    FSorting := TcxPivotGridOptionsCustomize(Source).FSorting;
    FilterResizable := TcxPivotGridOptionsCustomize(Source).FilterResizable;
  end
  else
    inherited Assign(Source);
end;

procedure TcxPivotGridOptionsCustomize.SetFiltering(AValue: Boolean);
begin
  if FFiltering <> AValue then
  begin
    FFiltering := AValue;
    PivotGrid.RefreshFilterableFieldsList;
    Changed;
  end;
end;

procedure TcxPivotGridOptionsCustomize.SetValue(AIndex: Integer; AValue: Boolean);
begin
  case AIndex of
    0:
      SetFiltering(AValue);
    1:
      SetBoolValue(FHiding, AValue);
    2:
      SetBoolValue(FMoving, AValue);
    3:
      SetBoolValue(FQuickCustomization, AValue);
    4:
      SetBoolValue(FSizing, AValue);
    5:
      SetBoolValue(FSorting, AValue);
    6:
      SetBoolValue(FFilterResizable, AValue);
    7:
      SetBoolValue(FQuickPrefiltering, AValue);
  end;
end;

{ TcxPivotGridOptionsView }

constructor TcxPivotGridOptionsView.Create(AOwner: TcxCustomPivotGrid);
begin
  inherited Create(AOwner);
  FColumnFields := True;
  FColumnGrandTotals := True;
  FColumnTotals := True;
  FDataFields := True;
  FDropArrowColor := cxPivotGridDropArrowColor;
  FFilterFields := True;
  FFilterSeparator := True;
  FFilterDropDownMaxItemCount := cxPivotGridDropDownMaxItemCount;
  FFilterDropDownWidth := cxPivotGridDropDownWidth;
  FPivotGrid := AOwner;
  FRowFields := True;
  FRowGrandTotals := True;
  FRowTotals := True;
  FGridLineColor := clDefault;
  FGridLines := pglBoth;
end;

procedure TcxPivotGridOptionsView.Assign(Source: TPersistent);
var
  AOptions: TcxPivotGridOptionsView;
begin
  if Source is TcxPivotGridOptionsView then
  begin
    AOptions := TcxPivotGridOptionsView(Source);
    FColumnFields := AOptions.ColumnFields;
    FColumnGrandTotals := AOptions.ColumnGrandTotals;
    FColumnTotals := AOptions.ColumnTotals;
    FDataFields := AOptions.DataFields;
    FDropArrowColor := AOptions.DropArrowColor;
    FFilterFields := AOptions.FilterFields;
    FFilterSeparator := AOptions.FilterSeparator;
    FFilterDropDownMaxItemCount := AOptions.FilterDropDownMaxItemCount;
    FFilterDropDownWidth := AOptions.FilterDropDownWidth;
    FGrandTotalsForSingleValues := AOptions.GrandTotalsForSingleValues;
    FGridLineColor := AOptions.GridLineColor;
    FGridLines := AOptions.GridLines;
    FMarkNarrowCells := AOptions.MarkNarrowCells;
    FRowFields := AOptions.RowFields;
    FRowGrandTotals := AOptions.RowGrandTotals;
    FRowTotals := AOptions.RowTotals;
    FTotalsForSingleValues := AOptions.TotalsForSingleValues;
    FColumnGrandTotalText := AOptions.ColumnGrandTotalText;
    FRowGrandTotalText := AOptions.RowGrandTotalText;
    FColumnTotalsLocation := AOptions.ColumnTotalsLocation;
    FRowTotalsLocation := AOptions.RowTotalsLocation;
  end;
  inherited Assign(Source);
end;

procedure TcxPivotGridOptionsView.Changed;
begin
  PivotGrid.DataChanged;
end;

function TcxPivotGridOptionsView.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TcxPivotGridOptionsView._AddRef: Integer;
begin
  Result := -1;
end;

function TcxPivotGridOptionsView._Release: Integer;
begin
  Result := -1;
end;

// IcxPivotGridSizableObject

procedure TcxPivotGridOptionsView.ApplyBestFit;
begin
end;

function TcxPivotGridOptionsView.CanResize: Boolean;
begin
  Result := PivotGrid.OptionsCustomize.Sizing;
end;

function TcxPivotGridOptionsView.GetActualWidth: Integer;
begin
  Result := GrandTotalWidth;
  if Result = 0 then
    Result := cxPivotGridDefaultFieldWidth;
  Result := Max(Result, GetMinWidth);
end;

function TcxPivotGridOptionsView.GetMinWidth: Integer;
begin
  Result := cxPivotGridDefaultFieldMinWidth;
end;

procedure TcxPivotGridOptionsView.SetWidth(AValue: Integer);
begin
  GrandTotalWidth := AValue;
end;

function TcxPivotGridOptionsView.GetScrollBars: TScrollStyle;
begin
  Result := PivotGrid.ScrollBars;
end;

function TcxPivotGridOptionsView.GetTotalsLocation: TcxPivotGridTotalsLocation;
begin
  if (FColumnTotalsLocation <> FRowTotalsLocation) then
    Result := tlCustom
  else
    Result := FColumnTotalsLocation;
end;

procedure TcxPivotGridOptionsView.SetColumnFields(AValue: Boolean);
begin
  SetBoolValue(FColumnFields, AValue);
end;

procedure TcxPivotGridOptionsView.SetColumnGrandTotals(AValue: Boolean);
begin
  SetBoolValue(FColumnGrandTotals, AValue);
end;

procedure TcxPivotGridOptionsView.SetColumnGrandTotalText(const AValue: string);
begin
  if AnsiCompareStr(FColumnGrandTotalText, AValue) <> 0 then
  begin
    FColumnGrandTotalText := AValue;
    Changed;
  end;
end;

procedure TcxPivotGridOptionsView.SetColumnTotals(AValue: Boolean);
begin
  SetBoolValue(FColumnTotals, AValue);
end;

procedure TcxPivotGridOptionsView.SetColumnTotalsLocation(AValue: TcxPivotGridTotalsLocation);
begin
  if (FColumnTotalsLocation <> AValue) and (AValue <> tlCustom) then
  begin
    FColumnTotalsLocation := AValue;
    Changed;
  end;
end;

procedure TcxPivotGridOptionsView.SetDataFields(AValue: Boolean);
begin
  SetBoolValue(FDataFields, AValue);
end;

procedure TcxPivotGridOptionsView.SetFilterDropDownMaxItemCount(AValue: Integer);
begin
  AValue := Max(1, AValue);
  if FFilterDropDownMaxItemCount <> AValue then
  begin
    FFilterDropDownMaxItemCount := AValue;
    Changed;
  end;
end;

procedure TcxPivotGridOptionsView.SetFilterDropDownWidth(AValue: Integer);
begin
  AValue := Max(AValue, cxPivotGridFilterPopupMinWidth);
  if FFilterDropDownWidth <> AValue then
  begin
    FFilterDropDownWidth := AValue;
    Changed;
  end;
end;

procedure TcxPivotGridOptionsView.SetFilterFields(AValue: Boolean);
begin
  SetBoolValue(FFilterFields, AValue);
end;

procedure TcxPivotGridOptionsView.SetFilterSeparator(AValue: Boolean);
begin
  SetBoolValue(FFilterSeparator, AValue);
end;

procedure TcxPivotGridOptionsView.SetGrandTotalWidth(AValue: Integer);
begin
  AValue := Max(AValue, 0);
  if AValue > 0 then
    AValue := Max(AValue, cxPivotGridDefaultFieldMinWidth);
  if FGrandTotalWidth <> AValue then
  begin
    FGrandTotalWidth := AValue;
    Changed;
  end;
end;

procedure TcxPivotGridOptionsView.SetGrandTotalsForSingleValues(AValue: Boolean);
begin
  SetBoolValue(FGrandTotalsForSingleValues, AValue);
end;

procedure TcxPivotGridOptionsView.SetGridLineColor(AValue: TColor);
begin
  if FGridLineColor <> AValue then
  begin
    FGridLineColor := AValue;
    if GridLines <> pglNone then
      Changed;
  end;
end;

procedure TcxPivotGridOptionsView.SetGridLines(AValue: TcxPivotGridLines);
begin
  if FGridLines <> AValue then
  begin
    FGridLines := AValue;
    Changed;
  end;
end;

procedure TcxPivotGridOptionsView.SetMarkNarrowCells(AValue: Boolean);
begin
  SetBoolValue(FMarkNarrowCells, AValue);
end;

procedure TcxPivotGridOptionsView.SetRowFields(AValue: Boolean);
begin
  SetBoolValue(FRowFields, AValue);
end;

procedure TcxPivotGridOptionsView.SetRowGrandTotals(AValue: Boolean);
begin
  SetBoolValue(FRowGrandTotals, AValue);
end;

procedure TcxPivotGridOptionsView.SetRowGrandTotalText(const AValue: string);
begin
  if AnsiCompareStr(FRowGrandTotalText, AValue) <> 0 then
  begin
    FRowGrandTotalText := AValue;
    Changed;
  end;
end;

procedure TcxPivotGridOptionsView.SetRowTotals(AValue: Boolean);
begin
  SetBoolValue(FRowTotals, AValue);
end;

procedure TcxPivotGridOptionsView.SetRowTotalsLocation(AValue: TcxPivotGridTotalsLocation);
begin
  if (FRowTotalsLocation <> AValue) and (AValue <> tlCustom) then
  begin
    FRowTotalsLocation := AValue;
    Changed;
  end;
end;

procedure TcxPivotGridOptionsView.SetScrollBars(AValue: TScrollStyle);
begin
  if AValue <> ScrollBars then
    PivotGrid.ScrollBars := AValue;
end;

procedure TcxPivotGridOptionsView.SetTotalsForSingleValues(AValue: Boolean);
begin
  SetBoolValue(FTotalsForSingleValues, AValue);
end;

procedure TcxPivotGridOptionsView.SetTotalsLocation(
  const AValue: TcxPivotGridTotalsLocation);
begin
  if (AValue <> GetTotalsLocation) and (AValue <> tlCustom) then
  begin
    FColumnTotalsLocation := AValue;
    FRowTotalsLocation := AValue;
    Changed;
  end;
end;

{ TcxPivotGridOptionsData }

constructor TcxPivotGridOptionsData.Create(AOwner: TcxCustomPivotGrid);
begin
  inherited Create(AOwner);
  FSaveExpanding := True;
  FVariationNullIgnore := True;
end;

procedure TcxPivotGridOptionsData.Assign(Source: TPersistent);
begin
  if Source is TcxPivotGridOptionsData then
    with TcxPivotGridOptionsData(Source) do
    begin
      Self.FAnsiSort := AnsiSort;
      Self.FSummaryNullIgnore := SummaryNullIgnore;
      Self.FSaveExpanding := SaveExpanding;
      Self.FVariationNullIgnore := FVariationNullIgnore;
    end;
  inherited Assign(Source);
end;

procedure TcxPivotGridOptionsData.Changed;
begin
  PivotGrid.DataChanged;
end;

function TcxPivotGridOptionsData.CompareAsString(const V1, V2: Variant): Integer;
begin
  if AnsiSort then
    Result := AnsiCompareStr(V1, V2)
  else
    Result := VarCompare(V1, V2);
end;

procedure TcxPivotGridOptionsData.SetAnsiSort(AValue: Boolean);
begin
  SetBoolValue(FAnsiSort, AValue);
end;

procedure TcxPivotGridOptionsData.SetCalculationBase(
  AValue: TcxPivotGridCalculationBaseType);
begin
  if AValue <> FCalculationBase then
  begin
    FCalculationBase := AValue;
    Changed;
  end;
end;

procedure TcxPivotGridOptionsData.SetSummaryNullIgnore(AValue: Boolean);
begin
  SetBoolValue(FSummaryNullIgnore, AValue);
end;

procedure TcxPivotGridOptionsData.SetVariationNullIgnore(AValue: Boolean);
begin
  SetBoolValue(FVariationNullIgnore, AValue);
end;

{ TcxPivotGridOptionsPrefilter }

constructor TcxPivotGridOptionsPrefilter.Create(AOwner: TcxCustomPivotGrid);
begin
  inherited;
  FCustomizeButton := True;
  FMRUItemsList := True;
  FMRUItemsListCount := 10;
  FPosition := pfpBottom;
  FVisible := pfvNonEmpty;
end;

procedure TcxPivotGridOptionsPrefilter.Assign(Source: TPersistent);
var
  AOptions: TcxPivotGridOptionsPrefilter;
begin
  if Source is TcxPivotGridOptionsPrefilter then
  begin
    AOptions := TcxPivotGridOptionsPrefilter(Source);
    CustomizeButton := AOptions.CustomizeButton;
    MRUItemsList := AOptions.MRUItemsList;
    MRUItemsListCount := AOptions.MRUItemsListCount;
    FMRUItemsListDropDownCount := AOptions.MRUItemsListDropDownCount;
    Position := AOptions.Position;
    Visible := AOptions.Visible;
  end;
  inherited Assign(Source);
end;

procedure TcxPivotGridOptionsPrefilter.SetCustomizeButton(AValue: Boolean);
begin
  if FCustomizeButton <> AValue then
  begin
    FCustomizeButton := AValue;
    Changed;
  end;
end;

procedure TcxPivotGridOptionsPrefilter.SetMRUItemsList(AValue: Boolean);
begin
  if FMRUItemsList <> AValue then
  begin
    FMRUItemsList := AValue;
    Changed;
  end;
end;

procedure TcxPivotGridOptionsPrefilter.SetMRUItemsListCount(AValue: Integer);
begin
  AValue := Max(0, AValue);
  if FMRUItemsListCount <> AValue then
  begin
    FMRUItemsListCount := AValue;
    Changed;
  end;
end;

procedure TcxPivotGridOptionsPrefilter.SetMRUItemsListDropDownCount(AValue: Integer);
begin
  AValue := Max(0, AValue);
  if FMRUItemsListDropDownCount <> AValue then
  begin
    FMRUItemsListDropDownCount := AValue;
    Changed;
  end;
end;

procedure TcxPivotGridOptionsPrefilter.SetPosition(AValue: TcxPivotGridPrefilterPosition);
begin
  if FPosition <> AValue then
  begin
    FPosition := AValue;
    Changed;
  end;
end;

procedure TcxPivotGridOptionsPrefilter.SetVisible(AValue: TcxPivotGridPrefilterVisible);
begin
  if FVisible <> AValue then
  begin
    FVisible := AValue;
    Changed;
  end;
end;

{ TcxPivotGridOptionsSelection }

constructor TcxPivotGridOptionsSelection.Create(AOwner: TcxCustomPivotGrid);
begin
  inherited Create(AOwner);
  FIncludeCells := [osiCrossCells, osiGrandTotalCells, osiTotalCells];
end;

procedure TcxPivotGridOptionsSelection.Assign(Source: TPersistent);
begin
  if Source is TcxPivotGridOptionsSelection then
  begin
    HideFocusRect := TcxPivotGridOptionsSelection(Source).HideFocusRect;
    HideSelection := TcxPivotGridOptionsSelection(Source).HideSelection;
    IncludeCells := TcxPivotGridOptionsSelection(Source).IncludeCells;
    MultiSelect := TcxPivotGridOptionsSelection(Source).MultiSelect;
  end;
  inherited Assign(Source)
end;

procedure TcxPivotGridOptionsSelection.SetHideFocusRect(AValue: Boolean);
begin
  SetBoolValue(FHideFocusRect, AValue);
end;

procedure TcxPivotGridOptionsSelection.SetHideSelection(AValue: Boolean);
begin
  SetBoolValue(FHideSelection, AValue);
end;

procedure TcxPivotGridOptionsSelection.SetIncludeCells(const AValue: TcxPivotGridOptionsSelectionIncludes);
begin
  if FIncludeCells <> AValue then
  begin
    FIncludeCells := AValue;
    Changed;
  end;
end;

procedure TcxPivotGridOptionsSelection.SetMultiSelect(AValue: Boolean);
begin
  SetBoolValue(FMultiSelect, AValue);
end;

{ TcxPivotGridCustomCustomizationForm }

constructor TcxPivotGridCustomCustomizationForm.Create(AOwner: TComponent);
begin
  inherited CreateNew(nil);
  FPivotGrid := AOwner as TcxCustomPivotGrid;
  Init;
  CreateControls;
  RefreshList;
  Constraints.MinWidth := cxPivotGridCustomizationMinWidth;
  Constraints.MinHeight := cxPivotGridCustomizationMinHeight;
end;

destructor TcxPivotGridCustomCustomizationForm.Destroy;
begin
  if not PivotGrid.IsDestroying then
  begin
    PivotGrid.Customization.FForm := nil;
    PivotGrid.Customization.FFormBounds := BoundsRect;
  end;
  inherited Destroy;
end;

procedure TcxPivotGridCustomCustomizationForm.RefreshList;
begin
end;

procedure TcxPivotGridCustomCustomizationForm.CreateControls;
begin
end;

procedure TcxPivotGridCustomCustomizationForm.CreateParams(
  var Params: TCreateParams);
begin
  inherited;
  with Params do
  begin
    Style := Style or WS_POPUP;
    if not PivotGrid.IsDestroying then
      WndParent := PivotGrid.Handle
    else
      WndParent := 0;
  end;
end;

procedure TcxPivotGridCustomCustomizationForm.DoClose(var Action: TCloseAction);
begin
{$IFDEF DELPHI10}
  Hide;
{$ENDIF}
  FreeAndNil(FHookTimer);
  Action := caFree;
end;

procedure TcxPivotGridCustomCustomizationForm.DoCustomDrawFieldHeader(
  ACanvas: TcxCanvas; ACell: TcxPivotGridCustomCellViewInfo; var ADone: Boolean);
begin
  PivotGrid.Painter.DoCustomDrawFieldHeader(ACanvas, ACell, ADone);
end;

procedure TcxPivotGridCustomCustomizationForm.DoShow;
begin
  if FHookTimer = nil then
  begin
    FHookTimer := TcxTimer.Create(nil);
    with FHookTimer do
    begin
      Interval := 100;
      OnTimer := HookTimerHandler;
    end;
  end;
  inherited DoShow;
end;

function TcxPivotGridCustomCustomizationForm.GetDragAndDropObjectClass(
  AField: TcxPivotGridField): TcxDragAndDropObjectClass;
begin
  Result := TcxPivotGridDragAndDropObject;
  PivotGrid.Controller.DownField := AField;
end;

procedure TcxPivotGridCustomCustomizationForm.Init;
var
  I: Integer;
const
  UnusedItems: array[0..4, 0..1] of Integer =
    ((7, MF_BYPOSITION), (5, MF_BYPOSITION), (SC_MAXIMIZE, MF_BYCOMMAND),
    (SC_MINIMIZE, MF_BYCOMMAND), (SC_RESTORE, MF_BYCOMMAND));
begin
  Caption := cxGetResourceString(@scxFieldListCaption);
  BorderStyle := bsSizeToolWin;
  BorderIcons := [biSystemMenu];
  Font.Assign(PivotGrid.Font);
  Width := cxPivotGridCustomizationDefaultWidth;
  Height := cxPivotGridCustomizationDefaultHeight;
  Color := clBtnFace;
  FontHeight := cxTextHeight(Font);
  for I := 0 to High(UnusedItems) do
    DeleteMenu(GetSystemMenu(Handle, False), UnusedItems[I, 0], UnusedItems[I, 1]);
end;

function TcxPivotGridCustomCustomizationForm.GetIsLocked: Boolean;
begin
  Result := PivotGrid.IsLocked
end;

function TcxPivotGridCustomCustomizationForm.GetLookAndFeel: TcxLookAndFeel;
begin
  Result := PivotGrid.LookAndFeel;
end;

function TcxPivotGridCustomCustomizationForm.GetPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := PivotGrid.LookAndFeelPainter;
end;

procedure TcxPivotGridCustomCustomizationForm.HookTimerHandler(Sender: TObject);
begin
  if IsIconic(Application.Handle) then
    Visible := False
  else
    if not IsControlVisible(PivotGrid) then
      PivotGrid.Customization.Visible := False
    else
      if not Visible then
      begin
        ShowWindow(Handle, SW_SHOWNOACTIVATE);
        Visible := True;
      end;
end;

{ TcxPivotGridCustomization }

destructor TcxPivotGridCustomization.Destroy;
begin
  FreeAndNil(FForm);
  inherited Destroy;
end;

procedure TcxPivotGridCustomization.CustomizationFormNeeded;
begin
  if FForm = nil then
  begin
    FForm := cxPivotGridCustomizationFormClass.Create(PivotGrid);
    FForm.OnShow := OnShowCustomization;
    FForm.OnHide := OnHideCustomization;
    if IsRectEmpty(FFormBounds) then
    begin
      FFormBounds.BottomRight := PivotGrid.ClientToScreen(PivotGrid.ClientRect.BottomRight);
      FFormBounds.Left := FFormBounds.Right - FForm.Width;
      FFormBounds.Top := FFormBounds.Bottom - FForm.Height;
    end
  end;
end;

procedure TcxPivotGridCustomization.CustomizationVisibleChanged;
begin
  PivotGrid.DoCustomization;
end;

procedure TcxPivotGridCustomization.OnShowCustomization(Sender: TObject);
begin
  CustomizationVisibleChanged;
end;

procedure TcxPivotGridCustomization.OnHideCustomization(Sender: TObject);
begin
  FFormBounds := Form.BoundsRect;
  CustomizationVisibleChanged;
end;

procedure TcxPivotGridCustomization.Refresh;
begin
  if Visible then
  begin
    if Form.IsLocked then
      PostMessage(PivotGrid.Handle, DXM_REFRESHCUSTOMIZATION, 0, 0)
    else
      Form.RefreshList;
  end;
end;

function TcxPivotGridCustomization.GetForm: TcxPivotGridCustomCustomizationForm;
begin
  CustomizationFormNeeded;
  Result := FForm;
end;

function TcxPivotGridCustomization.GetFormBounds: TRect;
begin
  if Visible then
    Result := Form.BoundsRect
  else
    Result := FFormBounds;
end;

function TcxPivotGridCustomization.GetVisible: Boolean;
begin
  Result := (FForm <> nil) and Form.Visible;
end;

procedure TcxPivotGridCustomization.SetVisible(AValue: Boolean);
begin
  if AValue <> Visible then
  begin
    CustomizationFormNeeded;
    if AValue then
    begin
      Form.BoundsRect := FFormBounds;
      Form.RefreshList;
    end
    else
      FreeAndNil(Form.FHookTimer);
    Form.Visible := AValue;
  end;
end;

procedure TcxPivotGridCustomization.SetFormBounds(const AValue: TRect);
begin
  if not Visible then
    FFormBounds := AValue
  else
    FForm.BoundsRect := AValue;
end;

{ TcxPivotGridOptionsDataField }

constructor TcxPivotGridOptionsDataField.Create(AOwner: TcxCustomPivotGrid);
begin
  inherited Create(AOwner);
  FAreaIndex := -1;
  FWidth := cxPivotGridDefaultFieldWidth;
  FMoving := True;
  FMinWidth := cxPivotGridDefaultFieldMinWidth;
  FViewInfo := TcxPivotGridFieldHeaderCellViewInfo.CreateEx(Self);
end;

destructor TcxPivotGridOptionsDataField.Destroy;
begin
  FViewInfo.Free;
  inherited Destroy;
end;

procedure TcxPivotGridOptionsDataField.Assign(Source: TPersistent);
begin
  if Source is TcxPivotGridOptionsDataField then
  begin
    FArea := TcxPivotGridOptionsDataField(Source).FArea;
    FAreaIndex := TcxPivotGridOptionsDataField(Source).FAreaIndex;
    FCaption := TcxPivotGridOptionsDataField(Source).Caption;
    FMinWidth := TcxPivotGridOptionsDataField(Source).FMinWidth;
    FMoving := TcxPivotGridOptionsDataField(Source).Moving;
    FWidth := TcxPivotGridOptionsDataField(Source).FWidth;
  end;
  inherited Assign(Source);
end;

procedure TcxPivotGridOptionsDataField.ApplyBestFit;
var
  AWidth, I: Integer;
begin
  PivotGrid.BeginUpdate;
  try
    if Area = dfaRow then
    begin
      AWidth := ViewInfo.MeasureWidth;
      for I := 0 to DataBuilder.DataFields.Count - 1 do
        AWidth := Max(AWidth, DataBuilder.DataFields[I].ViewInfo.MeasureWidth);
      Width := AWidth;
    end
    else
      for I := 0 to DataBuilder.DataFields.Count - 1 do
        DataBuilder.DataFields[I].ApplyBestFit;
  finally
    PivotGrid.EndUpdate;
  end;
end;

function TcxPivotGridOptionsDataField.CanDrag: Boolean;
begin
  Result := Moving and PivotGrid.OptionsCustomize.Moving;
end;

function TcxPivotGridOptionsDataField.CanDrop(Area: TcxPivotGridFieldArea): Boolean;
begin
  Result := Area in [faRow, faColumn];
end;

function TcxPivotGridOptionsDataField.CanRemove: Boolean;
begin
  Result := False;
end;

function TcxPivotGridOptionsDataField.CanResize: Boolean;
begin
  Result := PivotGrid.OptionsCustomize.Sizing;
end;

function TcxPivotGridOptionsDataField.CheckIndex(AIndex: Integer;
  AFields: TcxPivotGridFields; AArea: TcxPivotGridFieldArea): Integer;
var
  I: Integer;
  AField: TcxPivotGridField;
begin
  if AIndex < 0 then
    Result := AFields.Count
  else
  begin
    Result := AIndex;
    for I := 0 to PivotGrid.FieldCount - 1 do
    begin
      AField := PivotGrid.Fields[I];
      if AField.Visible or (AField.AreaIndex = -1) or (AField.Area <> AArea) then Continue;
      if AField.AreaIndex < AIndex then
        Dec(Result);
    end;
    Result := Min(Result, AFields.Count);
  end;
end;

procedure TcxPivotGridOptionsDataField.DragDrop(
  AArea: TcxPivotGridFieldArea; AIndex: Integer);
var
  ANewArea: TcxPivotGridDataFieldArea;
begin
  if not (AArea in [faRow, faColumn]) then Exit;
  PivotGrid.BeginUpdate;
  try
    if AArea = faColumn then
      ANewArea := dfaColumn
    else
      ANewArea := dfaRow;
    if (ANewArea = Area) and (AreaIndex >= 0) and (AIndex > AreaIndex) then
      Dec(AIndex);
    Area := ANewArea;
    AreaIndex := AIndex;
  finally
    PivotGrid.EndUpdate;
  end;
  PivotGrid.DoFieldPosChanged(nil);
end;

function TcxPivotGridOptionsDataField.GetActualAreaIndex(
  AInHeaderArea: Boolean = True): Integer;
begin
  Result := -1;
  if (Area = dfaNone) and AInHeaderArea then Exit;
  if Area = dfaRow then
  begin
    if AInHeaderArea and not PivotGrid.OptionsView.RowFields then
      Result := -1
    else
      Result := CheckIndex(AreaIndex, PivotGrid.DataBuilder.RowFields, faRow)
  end
  else
  begin
    if AInHeaderArea and not PivotGrid.OptionsView.ColumnFields then
      Result := -1
    else
      Result := CheckIndex(AreaIndex, PivotGrid.DataBuilder.ColumnFields, faColumn);
  end;
end;

function TcxPivotGridOptionsDataField.IsSameArea(
  AArea: TcxPivotGridFieldArea): Boolean;
begin
  Result := (Area <> dfaNone) and (DataAreaToFieldArea[Area] = AArea);
end;

function TcxPivotGridOptionsDataField.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TcxPivotGridOptionsDataField._AddRef: Integer;
begin
  Result := -1;
end;

function TcxPivotGridOptionsDataField._Release: Integer;
begin
  Result := -1;
end;

function TcxPivotGridOptionsDataField.GetActualWidth: Integer;
begin
  Result := Width;
  if Result = 0 then
    Result := ViewInfo.MeasureWidth;
  Result := Max(Result, cxPivotGridDefaultFieldMinWidth);
end;

function TcxPivotGridOptionsDataField.GetCaption: string;
begin
  if not IsCaptionAssigned then
    Result := cxGetResourceString(@scxDataField)
  else
    Result := FCaption;
end;

function TcxPivotGridOptionsDataField.GetDataBuilder: TcxPivotGridDataBuilder;
begin
  Result := PivotGrid.DataBuilder;
end;

function TcxPivotGridOptionsDataField.GetHeaderWidth: Integer;
begin
  Result := ViewInfo.MeasureWidth;
end;

procedure TcxPivotGridOptionsDataField.SetArea(AValue: TcxPivotGridDataFieldArea);
begin
  if FArea <> AValue then
  begin
    FArea := AValue;
    Changed;
  end;
end;

procedure TcxPivotGridOptionsDataField.SetAreaIndex(AValue: Integer);
begin
  AValue := Max(-1, AValue);
  if AValue <> FAreaIndex then
  begin
    FAreaIndex := AValue;
    if (AValue <> -1) and (Area <> dfaNone) then
      if not PivotGrid.SetFieldAreaIndex(Self, DataAreaToFieldArea[Area], AValue) then
        FAreaIndex := AValue;
    if not PivotGrid.IsLocked then
      PivotGrid.DoFieldPosChanged(nil);
    Changed;
  end;
end;

procedure TcxPivotGridOptionsDataField.SetCaption(const AValue: string);
begin
  if FCaption <> AValue then
  begin
    FCaption := AValue;
    FIsCaptionAssigned := cxGetResourceString(@scxDataField) <> FCaption;
    Changed;
  end;
end;

procedure TcxPivotGridOptionsDataField.SetWidth(AValue: Integer);
begin
  AValue := Max(MinWidth, AValue);
  if FWidth <> AValue then
  begin
    FWidth := AValue;
    Changed;
  end;
end;

procedure TcxPivotGridOptionsDataField.ChangeExpanding;
begin
end;

procedure TcxPivotGridOptionsDataField.ChangeSorting;
begin
  SetState(cxbsNormal);
end;

function TcxPivotGridOptionsDataField.GetMinWidth: Integer;
begin
  Result := FMinWidth;
end;

function TcxPivotGridOptionsDataField.GetViewInfo: TcxPivotGridFieldHeaderCellViewInfo;
begin
  Result := ViewInfo;
end;

function TcxPivotGridOptionsDataField.GetVisible: Boolean;
begin
  Result := Area <> dfaNone;
end;

procedure TcxPivotGridOptionsDataField.SetMinWidth(AValue: Integer);
begin
  AValue := Max(0, AValue);
  if FMinWidth <> AValue then
  begin
    FMinWidth := AValue;
    Width := Width;
    Changed;
  end;
end;

procedure TcxPivotGridOptionsDataField.SetState(AState: TcxButtonState);
begin
  ViewInfo.State := AState;
  PivotGrid.InvalidateRect(ViewInfo.Bounds, False);
end;

procedure TcxPivotGridOptionsDataField.SetVisible(AValue: Boolean);
begin
end;

{ TcxPivotGridHitTest }

constructor TcxPivotGridHitTest.Create(AOwner: TcxCustomPivotGrid);
begin
  FOwner := AOwner;
end;

destructor TcxPivotGridHitTest.Destroy;
begin
  FResizeField := nil;
  inherited Destroy;
end;

procedure TcxPivotGridHitTest.Clear;
begin
  Flags := 0;
  FField := nil;
  FHitObject := nil;
  FResizeField := nil;
end;

procedure TcxPivotGridHitTest.Recalculate;
begin
  Clear;
  ViewInfo.CalculateHitTest(Self);
end;

function TcxPivotGridHitTest.GetBitState(AIndex: Integer): Boolean;
begin
  Result := (Flags and (1 shl AIndex)) <> 0;
end;

function TcxPivotGridHitTest.GetGroupItem: TcxPivotGridGroupItem;
var
  AObject: TObject;
begin
  Result := nil;
  AObject := HitObject;
  if AObject is TcxPivotGridHeaderCellViewInfo then
  begin
    AObject := TcxPivotGridHeaderCellViewInfo(HitObject).Data;
    if AObject is TcxPivotGridViewDataItem then
      AObject := TcxPivotGridViewDataItem(AObject).GroupItem;
    if AObject is TcxPivotGridGroupItem then
      Result := TcxPivotGridGroupItem(AObject);
  end;
end;

function TcxPivotGridHitTest.GetPosValue(AIndex: Integer): Integer;
begin
  if AIndex = 0 then
    Result := FHitPoint.X
  else
    Result := FHitPoint.Y
end;

function TcxPivotGridHitTest.GetViewInfo: TcxPivotGridViewInfo;
begin
  Result := PivotGrid.ViewInfo;
end;

procedure TcxPivotGridHitTest.SetBitState(AIndex: Integer; AValue: Boolean);
begin
  if AValue then
    Flags := Flags or (1 shl AIndex)
  else
    Flags := Flags and not (1 shl AIndex);
end;

procedure TcxPivotGridHitTest.SetPosValue(AIndex, AValue: Integer);
begin
  if AIndex = 0 then
    FHitPoint.X := AValue
  else
    FHitPoint.Y := AValue;
  Recalculate;
end;

procedure TcxPivotGridHitTest.SetHitPoint(const AValue: TPoint);
begin
  FHitPoint := AValue;
  Recalculate;
end;

{ TcxPivotGridHotTrackController }

constructor TcxPivotGridHotTrackController.Create(AOwner: TcxPivotGridController);
begin
  FOwner := AOwner;
end;

procedure TcxPivotGridHotTrackController.Clear;
begin
  FCell := nil;
end;

procedure TcxPivotGridHotTrackController.Update(
  AObject: TcxPivotGridCustomCellViewInfo);
begin
  if Cell <> AObject then
  begin
    UpdateState(Cell);
    FCell := AObject;
  end;
  UpdateState(AObject);
end;

procedure TcxPivotGridHotTrackController.UpdateState(
  AObject: TcxPivotGridCustomCellViewInfo);
begin
  if (AObject <> nil) and AObject.SetHotTrack(HitTest) then
    PivotGrid.InvalidateRect(AObject.ClipRect, False);
end;

function TcxPivotGridHotTrackController.GetHitTest: TcxPivotGridHitTest;
begin
  Result := Owner.HitTest;
end;

function TcxPivotGridHotTrackController.GetPivotGrid: TcxCustomPivotGrid;
begin
  Result := Owner.PivotGrid;
end;

{ TcxPivotGridHintController }

constructor TcxPivotGridHintController.Create(AOwner: TcxPivotGridController);
begin
  FOwner := AOwner;
  FHintCheckerTimer := TTimer.Create(nil);
end;

destructor TcxPivotGridHintController.Destroy;
begin
  HideHint;
  FreeAndNil(FHintCheckerTimer);
  inherited Destroy;
end;

procedure TcxPivotGridHintController.HideHint;
begin
  StopHintCheckerTimer;
  EndMouseTracking(Self);
  HintAreaBounds := cxEmptyRect;
  if HintWindow <> nil then
    ShowWindow(HintWindow.Handle, SW_HIDE);
  FreeAndNil(FHintWindow);
  FHintVisible := False;
  HintObject := nil;
end;

procedure TcxPivotGridHintController.ShowHint;
var
  R, R1: TRect;
begin
  HideHint;
  HintWindowNeeded;
  if GetHintInfo(R, R1) then
  begin
    HintAreaBounds := R;
    if not IsMouseTracking(Self) then
      BeginMouseTracking(PivotGrid, HintAreaBounds, Self);
    FHintVisible := True;
    StartHintCheckerTimer;
    cxActivateHint(HintWindow, R1, HintText);
  end;
end;

procedure TcxPivotGridHintController.Update;
begin
  if not PtInRect(FHintAreaBounds, HitTest.HitPoint) or
    HitTest.HitAtFilter or HitTest.HitAtButton then HideHint;
  if NeedShowHint then
    ShowHint;
end;

function TcxPivotGridHintController.CanShowHint: Boolean;
begin
  Result := Application.Active;
end;

function TcxPivotGridHintController.GetHintInfo(
  var ABounds, AWindowBounds: TRect): Boolean;
begin
  Result := (HitTest.HitObject <> nil) and CanShowHint;
  if Result then
  begin
    FHintText := HitTest.HitObject.HintText;
    Result := (Length(FHintText) > 0) and (HintObject <> HitTest.HitObject);
    if Result then
    begin
      ABounds := HitTest.HitObject.ClipRect;
      AWindowBounds := HintWindow.CalcHintRect(MaxInt, HintText, nil);
      with PivotGrid.ClientToScreen(ABounds.TopLeft) do
        OffsetRect(AWindowBounds, X, Y);
      HintObject := HitTest.HitObject;
    end;
  end;
end;

procedure TcxPivotGridHintController.HintCheckerTimerHandler(Sender: TObject);
begin
  if not CanShowHint then HideHint;
end;

procedure TcxPivotGridHintController.HintWindowNeeded;
begin
  if (HintWindow = nil) or (HintWindow.ClassType <> HintWindowClass) then
  begin
    FreeAndNil(FHintWindow);
    FHintWindow := HintWindowClass.Create(nil);
    FHintWindow.Color := Application.HintColor;
  end;
end;

function TcxPivotGridHintController.NeedShowHint: Boolean;
begin
  with PivotGrid.OptionsBehavior do
  begin
    Result := (HitTest.HitObject <> nil) and (HitTest.HitAtDataCell and CellHints) or
      (HitTest.HitAtGroupHeader and GroupHeaderHints) or
      (HitTest.HitAtField and FieldHeaderHints);
    Result := Result and HitTest.HitObject.NeedShowHint(HitTest.HitPoint) and
      (HitTest.HitObject <> HintObject);
  end;
end;

procedure TcxPivotGridHintController.MouseLeave;
begin
  HideHint;
end;

procedure TcxPivotGridHintController.StartHintCheckerTimer;
begin
  FHintCheckerTimer.Interval := 100;
  FHintCheckerTimer.OnTimer := HintCheckerTimerHandler;
  FHintCheckerTimer.Enabled := True;
end;

procedure TcxPivotGridHintController.StopHintCheckerTimer;
begin
  FHintCheckerTimer.Enabled := False;
  FHintCheckerTimer.OnTimer := nil;
end;

function TcxPivotGridHintController.GetHitTest: TcxPivotGridHitTest;
begin
  Result := PivotGrid.HitTest;
end;

function TcxPivotGridHintController.GetPivotGrid: TcxCustomPivotGrid;
begin
  Result := Owner.PivotGrid;
end;

{ TcxPivotGridController }

constructor TcxPivotGridController.Create(AOwner: TcxCustomPivotGrid);
begin
  FOwner := AOwner;
  FHintController := CreateHintController;
  FHotTrackController := CreateHotTrackController;
  FFilterPopup := CreateFilterPopup;

  FPrefilterPopup := TcxPivotGridMRUPrefilterPopup.Create(PivotGrid);
  FPrefilterPopup.LookAndFeel.MasterLookAndFeel := PivotGrid.LookAndFeel;

  FSelectionTimer := TTimer.Create(nil);
  FIgnoreSelection := False;
end;

destructor TcxPivotGridController.Destroy;
begin
  StopSelectionTimer;
  FHintController.Free;
  FSelectionTimer.Free;
  FHotTrackController.Free;
  FPrefilterPopup.Free;
  FFilterPopup.Free;
  inherited Destroy;
end;

procedure TcxPivotGridController.Clear;
begin
  FHotTrackController.Clear;
  DownField := nil;
end;

procedure TcxPivotGridController.BeforeMouseDown(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
end;

procedure TcxPivotGridController.DblClick;
begin
  CalculateIgnoreSelection;
  HitTest.Recalculate;
  with HitTest do
  begin
    if HitAtHorzSizingEdge and (ResizeField <> nil) and ResizeField.CanResize then
      HitTest.ResizeField.ApplyBestFit;
  end;
end;

procedure TcxPivotGridController.KeyDown(var AKey: Word; AShift: TShiftState);
const
  Navigation: array[Boolean] of Integer = (-1, 1);
begin
  case AKey of
    VK_INSERT:
      if ssCtrl in AShift then PivotGrid.CopyToClipboard(False);
    VK_UP, VK_DOWN:
      SetSelectionInc(0, Navigation[AKey = VK_DOWN], AShift);
    VK_LEFT, VK_RIGHT:
      ProcessNavigationByStep(AKey = VK_LEFT, AShift);
    VK_PRIOR, VK_NEXT:
      begin
        ViewData.DoNextPage(AKey = VK_NEXT);
        SetSelectionInc(0, Navigation[AKey = VK_NEXT] * ViewData.RowsPerPage, AShift);
      end;
    VK_HOME, VK_END:
      if ssCtrl in AShift then
        SetSelection(FocusedCell.X, MaxInt * Navigation[AKey = VK_END], AShift - [ssCtrl])
      else
        SetSelection(MaxInt * Navigation[AKey = VK_END], FocusedCell.Y, AShift);
    VK_TAB:
      ProcessTabKeyDown(ssShift in AShift);
  end;
  case AKey of
    VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT, VK_PRIOR, VK_NEXT, VK_HOME, VK_END, VK_TAB:
      begin
        ViewData.Selection.ApplyTemporarySelection(True);
        PivotGrid.ViewData.MakeSelectionVisible;
      end;
  end;
end;

procedure TcxPivotGridController.KeyPress(var AKey: Char);
begin
  case AKey of
    ^C:
    begin
      PivotGrid.CopyToClipboard(False);
      AKey := #0;
    end;
    ^A:
    begin
      PivotGrid.ViewData.Selection.MakeNew(Rect(0, 0, MaxInt, MaxInt));
      AKey := #0;
    end;
    #13:
      AKey := #0;
  end;
end;

procedure TcxPivotGridController.MakeCellFocused(
  ACell: TcxPivotGridDataCellViewInfo; AShift: TShiftState);
begin
  SetSelection(ACell.ColumnIndex, ACell.RowIndex, AShift);
end;

procedure TcxPivotGridController.MouseDown(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  HintController.HideHint;
  CalculateIgnoreSelection;
  if HitTest.HitAtField or HitTest.HitAtDataField then
    DoFieldHeaderClick(HitTest.Field, Shift);
  if Button = mbLeft then
  begin
    if IsButtonDown then
      PivotGrid.LayoutChanged;
    if HitTest.HitAtFilter and
      not FilterOpenedBeforeClick and not IsDesigning then
    begin
      FFilterPopup.Field := HitTest.Field as TcxPivotGridField;
      FFilterPopup.Popup;
    end;
    if HitTest.HitAtPrefilter and not PrefilterOpenedBeforeClick and not IsDesigning then
    begin
      if TcxPivotGridPrefilterViewInfo(HitTest.HitObject).SetPressed(HitTest, True) then
        PivotGrid.InvalidateRect(TcxPivotGridPrefilterViewInfo(HitTest.HitObject).Bounds, False);
      if HitTest.HitAtPrefilterDropDownButton or
        HitTest.HitAtPrefilterCaption and ViewInfo.Prefilter.CanMRUPopupShow then
        FPrefilterPopup.Popup;
    end;
  end;
  FilterOpenedBeforeClick := False;
  PrefilterOpenedBeforeClick := False;
  if FIgnoreSelection or ((HitTest.HitAtDataCell and IsCellSelected(HitTest.HitObject as TcxPivotGridDataCellViewInfo) and
    (Button = mbRight))) then
      Exit;
  SuspendSelectionTimer := HitTest.HitAtDataCell;
  MakeSelected(Shift);
end;

procedure TcxPivotGridController.MouseLeave;
begin
  Update;
  HotTrackController.Update(HitTest.HitObject);
  FIgnoreSelection := False;
end;

procedure TcxPivotGridController.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if PivotGrid.DragAndDropState = ddsNone then
  begin
    HotTrackController.Update(HitTest.HitObject);
    if (ssLeft in Shift) then
    begin
      MakeSelected(Shift, True);
      if SuspendSelectionTimer then
        CheckSelectionTimer(X, Y);
    end;
    if [ssLeft, ssRight] * Shift <> [] then
      HintController.HideHint
    else
      HintController.Update;
  end;
end;

procedure TcxPivotGridController.MouseUp(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
  APrefilter: TcxPivotGridPrefilter;
begin
  SuspendSelectionTimer := False;
  if (DownField <> nil) and not HitTest.HitAtFilter and not FilterOpenedBeforeClick then
    DownField.ChangeSorting;
  for I := 0 to PivotGrid.FieldCount - 1 do
  begin
    if PivotGrid.Fields[I].ViewInfo.State = cxbsPressed then
      PivotGrid.Fields[I].SetState(cxbsNormal);
  end;
  APrefilter := PivotGrid.ViewInfo.Prefilter;
  if APrefilter.Visible then
  begin
    APrefilter.ViewInfo.SetPressed(HitTest, False);
    PivotGrid.InvalidateRect(APrefilter.ViewInfo.Bounds, False);
  end;
  StopSelectionTimer;
  HintController.Update;
  DownField := nil;
  if not FIgnoreSelection then
    ViewData.Selection.ApplyTemporarySelection(False);
  FIgnoreSelection := False;
end;

procedure TcxPivotGridController.StartSelectionTimer;
begin
  if SelectionTimer.Enabled then Exit;
  SelectionTimer.Interval := cxPivotGridAutoScrollInterval;
  SelectionTimer.Enabled := True;
  SelectionTimer.OnTimer := SelectionTimerHandler;
end;

procedure TcxPivotGridController.StopSelectionTimer;
begin
  SelectionTimer.OnTimer := nil;
  SelectionTimer.Enabled := False;
end;

procedure TcxPivotGridController.Update;
begin
  if PivotGrid.HandleAllocated then
    HitTest.HitPoint := PivotGrid.ScreenToClient(GetMouseCursorPos)
  else
    HitTest.HitPoint := cxNullPoint;
end;

procedure TcxPivotGridController.CalculateAnchor(AShift: TShiftState);
var
  ADataItem: TcxPivotGridViewDataItem;
begin
  if not (ssShift in AShift) or (ssCtrl in AShift) or not (ssLeft in AShift) then
  begin
    if HitTest.HitAtDataCell then
      with TcxPivotGridDataCellViewInfo(HitTest.HitObject) do
        ViewData.AnchorCells := Rect(ColumnIndex, RowIndex, ColumnIndex, RowIndex)
    else
      if HitTest.HitAtGroupHeader and (HitTest.HitObject is TcxPivotGridHeaderCellViewInfo) then
      begin
        if TcxPivotGridHeaderCellViewInfo(HitTest.HitObject).Data is TcxPivotGridViewDataItem then
        begin
          ADataItem := TcxPivotGridHeaderCellViewInfo(HitTest.HitObject).Data as TcxPivotGridViewDataItem;
          if (ADataItem.IsDataField and (ADataItem.Parent.GroupItem is TcxPivotGridColumnItem)) or (ADataItem.GroupItem is TcxPivotGridColumnItem) then
            ViewData.AnchorCells := Rect(ADataItem.GetChildLeftVisibleIndex, -1, ADataItem.GetChildRightVisibleIndex, -1)
          else
            ViewData.AnchorCells := Rect(-1, ADataItem.GetChildLeftVisibleIndex, -1, ADataItem.GetChildRightVisibleIndex);
        end;
      end
      else
        ViewData.AnchorCells := cxInvalidRect;
  end;
end;

function TcxPivotGridController.CalculateFilterDropDownSize(
  AFilter: TcxPivotGridFieldFilter): TSize;
begin
  if not OptionsCustomize.FilterResizable then
  begin
    Result.cx := Max(cxPivotGridFilterPopupMinWidth,
      OptionsView.FilterDropDownWidth);
    Result.cy := Max(cxPivotGridFilterPopupMinHeight,
      FilterPopup.GetHeight(OptionsView.FilterDropDownMaxItemCount));
  end
  else
  begin
    Result := AFilter.WindowSize;
    if cxSizeIsEqual(Result, cxNullSize) then
      Result := Size(cxPivotGridFilterPopupDefaultWidth, cxPivotGridFilterPopupDefaultHeight);
  end;
end;

procedure TcxPivotGridController.CheckSelectionTimer(const X, Y: Integer);
var
  R: TRect;
begin
  R := ViewInfo.DataCellsBounds;
  InflateRect(R, -cxPivotGridAutoScrollAreaWidth, -cxPivotGridAutoScrollAreaWidth);
  if not PtInRect(R, Point(X, Y)) and SuspendSelectionTimer and HitTest.HitAtDataCell then
    StartSelectionTimer
  else
    StopSelectionTimer;
end;

function TcxPivotGridController.CreateFilterPopup: TcxPivotGridFilterPopup;
begin
  Result := TcxPivotGridFilterPopup.Create(PivotGrid);
  Result.LookAndFeel.MasterLookAndFeel := PivotGrid.LookAndFeel;
end;

function TcxPivotGridController.CreateHintController: TcxPivotGridHintController;
begin
  Result := TcxPivotGridHintController.Create(Self);
end;

function TcxPivotGridController.CreateHotTrackController: TcxPivotGridHotTrackController;
begin
  Result := TcxPivotGridHotTrackController.Create(Self)
end;

procedure TcxPivotGridController.DoFieldHeaderClick(
  AField: TPersistent; AShift: TShiftState);
var
  ADownField: IcxPivotGridField;
begin
  if not (ssLeft in AShift) then Exit;
  if PivotGrid.IsDesignerAvailable and (AField is TcxPivotGridField) or (AField = nil) then
    DesignerHelper.Select(AField, AShift);
  if Supports(AField, IcxPivotGridField, DownField) and not HitTest.HitAtFilter then
  begin
    ADownField := DownField;
    if not HitTest.HitAtButton then
      DownField.SetState(cxbsPressed)
    else
      DownField.ChangeExpanding;
    DownField := ADownField;
  end;
end;

function TcxPivotGridController.GetCursor(const X, Y: Integer): TCursor;
begin
  Result := crDefault;
  HitTest.HitPoint := Point(X, Y);
  if HitTest.HitAtHorzSizingEdge then
    Result := crcxPivotGridHorzSize;
end;

function TcxPivotGridController.GetDragAndDropObjectClass: TcxDragAndDropObjectClass;
begin
  if HitTest.HitAtDataField or HitTest.HitAtField then
    Result := TcxPivotGridDragAndDropObject
  else
    if HitTest.HitAtHorzSizingEdge then
      Result := TcxPivotGridResizingObject
    else
      Result := nil;
end;

function TcxPivotGridController.IsButtonDown: Boolean;
begin
  Result := HitTest.HitAtButton and (HitTest.GroupItem <> nil);
  if Result then
    HitTest.GroupItem.Expanded := not HitTest.GroupItem.Expanded;
end;

function TcxPivotGridController.IsCellSelected(
  ACell: TcxPivotGridDataCellViewInfo): Boolean;
begin
  Result := ViewData.IsCellSelected(ACell.RowIndex, ACell.ColumnIndex);
end;

procedure TcxPivotGridController.MakeSelected(AShift: TShiftState; AMouseMove: Boolean = False);
var
  AObject: TObject;
begin
  if FIgnoreSelection then
    Exit;
  if (HitTest.HitAtDataCell and (HitTest.HitObject is TcxPivotGridDataCellViewInfo)) then
    with HitTest.HitObject as TcxPivotGridDataCellViewInfo do
      if not ViewData.CanCellSelect(RowIndex, ColumnIndex) then
        Exit;
  if not AMouseMove then
    CalculateAnchor(AShift);
  if ((ssRight in AShift) or (ssLeft in AShift)) then
  begin
    if HitTest.HitAtGroupHeader and (HitTest.HitObject is TcxPivotGridHeaderCellViewInfo) and not FIgnoreSelection then
    begin
      AObject := TcxPivotGridHeaderCellViewInfo(HitTest.HitObject).Data;
      if (AObject is TcxPivotGridViewDataItem) then
        ViewData.HeaderCellSelect(TcxPivotGridViewDataItem(AObject), AShift);
    end
    else
      if HitTest.HitAtDataCell and (HitTest.HitObject is TcxPivotGridDataCellViewInfo) then
        MakeCellFocused(TcxPivotGridDataCellViewInfo(HitTest.HitObject), AShift);
  end;
end;

function TcxPivotGridController.ProcessNavigationByStep(AGoBackward: Boolean;
  AShiftState: TShiftState): Boolean;

  function IsLastCellInLine: Boolean;
  begin
    if AGoBackward then
      Result := FocusedCell.X = 0
    else
      Result := FocusedCell.X = ViewData.ColumnCount - 1;
  end;

  function IsLastCellInRow: Boolean;
  begin
    if AGoBackward then
      Result := FocusedCell.Y = 0
    else
      Result := FocusedCell.Y = ViewData.RowCount - 1;
  end;

const
  Navigation: array[Boolean] of Integer = (1, -1);
begin
  Result := IsLastCellInLine;
  if not Result then
    SetSelectionInc(Navigation[AGoBackward], 0, AShiftState)
  else
    if PivotGrid.OptionsBehavior.FocusCellOnCycle then
    begin
      Result := IsLastCellInRow;
      if not Result then
        SetSelectionInc(-Navigation[AGoBackward] * ViewData.ColumnCount,
          Navigation[AGoBackward], []);
    end;
end;

procedure TcxPivotGridController.ProcessTabKeyDown(AGoBackward: Boolean);
begin
  if PivotGrid.OptionsBehavior.FocusCellOnTab then
  begin
    if PivotGrid.IsFocused and ProcessNavigationByStep(AGoBackward, []) then
      PostMessage(GetParentForm(PivotGrid).Handle, WM_NEXTDLGCTL, WPARAM(AGoBackward), 0);
  end;
end;

procedure TcxPivotGridController.SelectionTimerHandler(Sender: TObject);
var
  R: TRect;
  APos: TPoint;
  DX, DY: Integer;
begin
  R := ViewInfo.DataCellsBounds;
  InflateRect(R, -cxPivotGridAutoScrollAreaWidth, -cxPivotGridAutoScrollAreaWidth);
  APos := PivotGrid.ScreenToClient(GetMouseCursorPos);
  DX := 0;
  DY := 0;
  if APos.X < R.Left then
    DX := -1
  else
    if APos.X > R.Right then
      DX := 1;
  if APos.Y < R.Top then
    DY := -1
  else
    if APos.Y > R.Bottom then
      DY := 1;
  SetSelectionInc(DX, DY, [ssLeft], True);
  if (DX <> 0) or (DY <> 0) then
    ViewData.MakeSelectionVisible;
end;

procedure TcxPivotGridController.SetSelection(
  ACol, ARow: Integer; AShift: TShiftState);
var
  R: TRect;
begin
  ViewData.AdjustCellIndexes(ARow, ACol, (ssLeft in AShift) or (ssRight in AShift));
  if PivotGrid.OptionsSelection.MultiSelect and ((ssCtrl in AShift) or (ssLeft in AShift) or (ssShift in AShift)) then
    with cxRect(Point(ACol, ARow), ViewData.AnchorCells.TopLeft) do
      R := Rect(Min(Left, Right), Min(Top, Bottom), Max(Left, Right), Max(Top, Bottom))
  else
    R := cxRect(Point(ACol, ARow), Point(ACol, ARow));
  ViewData.Selection.InnerSetFocusedCell(Point(ACol, ARow));
  ViewData.ValidateSelection(R);
  ViewData.Selection.ChangeSelection(R, AShift);
end;

procedure TcxPivotGridController.SetSelectionInc(const DX, DY: Integer; AShift: TShiftState; AByTimer: Boolean = False);
var
  AColumn, ARow: Integer;
begin
  AColumn := FocusedCell.X + DX;
  ARow := FocusedCell.Y + DY;
  if ssCtrl in AShift then
  begin
    if DX > 0 then
      for AColumn := FocusedCell.X + DX to ViewData.ColumnCount - 1 do
        if Length(ViewData.GetCellAsText(FocusedCell.Y, AColumn)) > 0 then
          Break;
    if DX < 0 then
      for AColumn := FocusedCell.X + DX downto 0 do
        if Length(ViewData.GetCellAsText(FocusedCell.Y, AColumn)) > 0 then
          Break;
    if DY > 0 then
      for ARow := FocusedCell.Y + DY to ViewData.RowCount - 1 do
        if Length(ViewData.GetCellAsText(ARow, FocusedCell.X)) > 0 then
          Break;
    if DY < 0 then
      for ARow := FocusedCell.Y + DY downto 0 do
        if Length(ViewData.GetCellAsText(ARow, FocusedCell.X)) > 0 then
          Break;
  end;
  ViewData.AdjustCellIndexes(ARow, AColumn, (ssLeft in AShift) or (ssRight in AShift));
  if not AByTimer and not (ssShift in AShift) then
    ViewData.AnchorCells := Rect(AColumn, ARow, AColumn, ARow);
  SetSelection(AColumn, ARow, AShift + [ssLeft] - [ssCtrl]);
end;

function TcxPivotGridController.StartDragAndDrop(const P: TPoint): Boolean;
var
  AField: IcxPivotGridField;
begin
  HitTest.HitPoint := P;
  Result := (HitTest.HitAtField or HitTest.HitAtDataField) and
    Supports(HitTest.Field, IcxPivotGridField, AField) and AField.CanDrag;
  Result := Result or HitTest.HitAtHorzSizingEdge;
  Result := Result and not (HitTest.HitAtButton or HitTest.HitAtFilter);
end;

procedure TcxPivotGridController.CalculateIgnoreSelection;
begin
  with HitTest do
    FIgnoreSelection := FIgnoreSelection or HitAtButton or
      (HitAtHorzSizingEdge and (ResizeField <> nil) and ResizeField.CanResize);
end;

function TcxPivotGridController.GetFocused: Boolean;
begin
  Result := PivotGrid.IsFocused;
end;

function TcxPivotGridController.GetFocusedCell: TPoint;
begin
  Result := PivotGrid.ViewData.FocusedCell;
end;

function TcxPivotGridController.GetHitTest: TcxPivotGridHitTest;
begin
  Result := PivotGrid.HitTest;
end;

function TcxPivotGridController.GetIsDesigning: Boolean;
begin
  Result := PivotGrid.IsDesigning;
end;

function TcxPivotGridController.GetOptionsCustomize: TcxPivotGridOptionsCustomize;
begin
  Result := PivotGrid.OptionsCustomize;
end;

function TcxPivotGridController.GetOptionsSelection: TcxPivotGridOptionsSelection;
begin
  Result := PivotGrid.OptionsSelection;
end;

function TcxPivotGridController.GetOptionsView: TcxPivotGridOptionsView;
begin
  Result := PivotGrid.OptionsView;
end;

function TcxPivotGridController.GetViewData: TcxPivotGridViewData;
begin
  Result := PivotGrid.ViewData;
end;

function TcxPivotGridController.GetViewInfo: TcxPivotGridViewInfo;
begin
  Result := PivotGrid.ViewInfo;
end;

procedure SetEmptyRegion(AHandle: HWND);
var
  AEmptyRgn: HRGN;
begin
  AEmptyRgn := CreateRectRgn(0, 0, 0, 0);
  SetWindowRgn(AHandle, AEmptyRgn, True);
  DeleteObject(AEmptyRgn);
end;

{ TcxPivotGridMRUPrefilterPopup }

constructor TcxPivotGridMRUPrefilterPopup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Parent := TcxCustomPivotGrid(AOwner);
  Visible := False;
end;

procedure TcxPivotGridMRUPrefilterPopup.Popup;
begin
  BeforePopup;
  DroppedDown := True;
end;

procedure TcxPivotGridMRUPrefilterPopup.BeforePopup;
var
  ARect: TRect;
begin
  Style.LookAndFeel.NativeStyle := PivotGrid.LookAndFeel.NativeStyle;
  Visible := False;
  Prefilter.ViewInfo.SetDroppedDown(PivotGrid.HitTest, True);
  PivotGrid.InvalidateRect(Prefilter.ViewInfo.Bounds, False);
  ARect := Prefilter.ViewInfo.GetDropDownWindowOwnerBounds;
  ARect.Top := ARect.Bottom - Height + 1;
  ARect.Left := ARect.Left - PopupWindow.ViewInfo.GetClientExtent.Left - cxTextOffset - 1;
  BoundsRect := ARect;
  InitValues;
  if PivotGrid.OptionsPrefilter.MRUItemsListDropDownCount = 0 then
    Properties.DropDownRows := MaxInt
  else
    Properties.DropDownRows := PivotGrid.OptionsPrefilter.MRUItemsListDropDownCount;
  Visible := True;
end;

procedure TcxPivotGridMRUPrefilterPopup.DoCloseUp;
begin
  inherited DoCloseUp;
  PivotGrid.Controller.PreFilterOpenedBeforeClick := (PivotGrid.HitTest.HitAtPrefilterDropDownButton or
    PivotGrid.HitTest.HitAtPrefilterCaption) and (FCloseUpReason = crUnknown);
  Prefilter.ViewInfo.SetDroppedDown(PivotGrid.HitTest, False);
  PivotGrid.InvalidateRect(Prefilter.ViewInfo.Bounds, False);
  if FCloseUpReason <> crUnknown then
    SelectedMRUItem.AssignTo(PivotGrid.DataController.Filter);
end;

procedure TcxPivotGridMRUPrefilterPopup.InitValues;
var
  I: Integer;
begin
  with Properties.Items do
  begin
    BeginUpdate;
    try
      Clear;
      with PivotGrid.PrefilterMRUItems do
        for I := 0 to VisibleCount - 1 do
          AddObject(VisibleItems[I].Caption, VisibleItems[I]);
    finally
      EndUpdate;
    end;
  end;
end;

procedure TcxPivotGridMRUPrefilterPopup.UpdateWindowRegion;
begin
  SetEmptyRegion(Handle);
end;

function TcxPivotGridMRUPrefilterPopup.GetPivotGrid: TcxCustomPivotGrid;
begin
  Result := TcxCustomPivotGrid(Parent);
end;

function TcxPivotGridMRUPrefilterPopup.GetPrefilter: TcxPivotGridPrefilter;
begin
  Result := PivotGrid.ViewInfo.Prefilter;
end;

function TcxPivotGridMRUPrefilterPopup.SelectedMRUItem: TcxPivotGridFilterMRUItem;
begin
  Result := TcxPivotGridFilterMRUItem(Properties.Items.Objects[SelectedItem]);
end;

{ TcxPivotGridFilterPopup }

constructor TcxPivotGridFilterPopup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Left := cxInvisiblePos;
  Top := cxInvisiblePos;
  Parent := TcxCustomPivotGrid(AOwner);
  AutoSize := False;
  Visible := False;
  Properties.PopupAutoSize := False;
  Properties.PopupMinWidth := cxPivotGridFilterPopupMinWidth;
  Properties.PopupMinHeight := cxPivotGridFilterPopupMinHeight;
  Properties.PopupSysPanelStyle := True;
  CreateControls;
  Properties.PopupControl := Values;
end;

procedure TcxPivotGridFilterPopup.Popup;
begin
  BeforePopup;
  DroppedDown := True;
end;

procedure TcxPivotGridFilterPopup.SaveChanges;
var
  I: Integer;
  AIsInclude: Boolean;
const
  AStates: array[Boolean] of TcxCheckBoxState = (cbsUnchecked, cbsChecked);
begin
  AIsInclude := GetCheckedCount < (Values.Items.Count div 2);
  Filter.BeginUpdate;
  try
    Filter.Clear;
    Filter.FilterType := TcxPivotGridFilterType(AIsInclude);
    for I := 1 to Values.Items.Count - 1 do
      if (Values.Items[I].State = AStates[AIsInclude]) then
        Filter.Values.Add(GetFieldValueByValueIndex(I));
  finally
    Filter.EndUpdate;
  end;
end;

procedure TcxPivotGridFilterPopup.TranslationChanged;
begin
  UpdateButtonCaptions;
end;

function TcxPivotGridFilterPopup.AddValue(
  const AValue: TcxPivotGridVariantValue): TcxCheckListBoxItem;
begin
  Result := Values.Items.Add;
  if Field.UseEditProperties and (Field.SummaryVariation = svNone) and
    (Field.Area <> faData) then
    Result.Text := Field.GetUserEditProperties.GetDisplayText(AValue.Value)
  else
    Result.Text := Field.GetGroupValueDisplayText(AValue.Value);
  if AValue.FUnUsed then
    Result.State := cbsGrayed
  else
    Result.State := TcxCheckBoxState(not Filter.HasFilter or
      Filter.Contains(AValue.Value));
  Result.ItemObject := AValue;
end;

procedure TcxPivotGridFilterPopup.BeforePopup;

  procedure CalculateButton(AButton: TcxButton; ASize: TSize);
  begin
    AButton.Font := PivotGrid.Font;
    AButton.Width := ASize.cx;
    AButton.Height := ASize.cy;
  end;

  procedure CalculateButtons;
  var
    ASize: TSize;
  begin
    ASize.cx := MulDiv(Max(cxTextWidth(PivotGrid.Font, FOkButton.Caption),
      cxTextWidth(PivotGrid.Font, FCancelButton.Caption)), 3, 2);
    ASize.cy := MulDiv(cxTextHeight(PivotGrid.Font), 20, 13);
    CalculateButton(FCancelButton, ASize);
    CalculateButton(FOkButton, ASize);
  end;

begin
  Properties.PopupSizeable := PivotGrid.OptionsCustomize.FilterResizable;
  Style.LookAndFeel.NativeStyle := PivotGrid.LookAndFeel.NativeStyle;
  Visible := False;
  Style.TransparentBorder := False;
  with Field.ViewInfo do
  begin
    BoundsRect := Rect(Bounds.Left, Bounds.Top,
      Bounds.Right, Bounds.Bottom);
    FPrevFilterState := FilterState;
    State := cxbsNormal;
    FilterState := cxbsPressed;
  end;
  with PivotGrid.Controller.CalculateFilterDropDownSize(Filter) do
    SetPopupSize(cx, cy);
  BoundsRect := cxRectSetRight(BoundsRect, Field.ViewInfo.Bounds.Right);
  Properties.PopupAlignment := taRightJustify;
  Visible := True;

  CalculateButtons;
  PopupWindow.MinSysPanelHeight := Max(cxPivotGridFilterMinSysPanelHeight,
    FCancelButton.Height + (FCancelButton.Height div 3));
  ActiveProperties.PopupMinWidth := Max(cxPivotGridFilterPopupMinWidth, ((FCancelButton.Height div 3) +
    FCancelButton.Width) * 2 + GetSystemMetrics(SM_CXVSCROLL) + FCancelButton.Height div 2);
end;

procedure TcxPivotGridFilterPopup.ButtonClickHandler(ASender: TObject);
var
  AReason: TcxEditCloseUpReason;
begin
  if TComponent(ASender).Tag = 1 then
    AReason := crClose
  else
    AReason := crCancel;
  CloseUp(AReason);
end;

procedure TcxPivotGridFilterPopup.CheckButtonsEnabled;
begin
  OkButton.Enabled := ShowAllState <> cbsUnchecked;
end;

procedure TcxPivotGridFilterPopup.CreateControls;
begin
  // Values - CheckListBox initialize
  FValues := TcxCheckListBox.Create(Self);
  FValues.BoundsRect := Rect(cxInvisiblePos, cxInvisiblePos,
    cxPivotGridFilterPopupMinWidth, cxPivotGridFilterPopupMinHeight);
  FValues.Visible := False;
  FValues.Style.LookAndFeel.MasterLookAndFeel := LookAndFeel;
  FValues.Parent := PivotGrid;
  FValues.Style.HotTrack := False;
  FValues.Style.BorderStyle := cbsNone;
  FValues.Style.TransparentBorder := False;
  FValues.EditValueFormat := cvfStatesString;
  FValues.OnEditValueChanged := ValuesChanges;
  // Buttons intialize
  FCancelButton := CreateButton(0);
  FCancelButton.Cancel := True;
  FOkButton := CreateButton(1);
  FOkButton.Default := True;
  UpdateButtonCaptions;
end;

procedure TcxPivotGridFilterPopup.DoCloseUp;
begin
  inherited DoCloseUp;
  if FPrevFilterState = cxbsHot then
  begin
    Field.ViewInfo.FilterState := cxbsNormal;
    PivotGrid.InvalidateRect(Field.ViewInfo.Bounds, False);
  end;
  if (FCloseUpReason <> crCancel) and (ShowAllState <> cbsUnchecked) and FilterModified then
    SaveChanges;
  Filter.WindowSize := cxSize(PopupWindow.Width, PopupWindow.Height);
  PivotGrid.Controller.FilterOpenedBeforeClick := (FCloseUpReason = crUnknown) and
    PivotGrid.HitTest.HitAtFilter and (PivotGrid.HitTest.Field = Field)
end;

function TcxPivotGridFilterPopup.GetCheckedCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 1 to Values.Items.Count - 1 do
  begin
    if Values.Items[I].State = cbsChecked then
      Inc(Result);
  end;
end;

function TcxPivotGridFilterPopup.GetFieldValueByValueIndex(
  AIndex: Integer): Variant;
begin
  Result := TcxPivotGridVariantValue(Values.Items[AIndex].ItemObject).Value;
end;

function TcxPivotGridFilterPopup.GetHeight(AItemCount: Integer): Integer;
begin
  Result := FValues.GetHeight(AItemCount) +
    PopupWindow.ViewInfo.GetSysPanelHeight + cxPivotGridDoubleSpace;
end;

function TcxPivotGridFilterPopup.GetStateByCount(
  ACount: Integer): TcxCheckBoxState;
begin
  if ACount = 0 then
    Result := cbsUnchecked
  else
    if ACount = Values.Items.Count - 1 then
      Result := cbsChecked
    else
      Result := cbsGrayed;
end;

procedure TcxPivotGridFilterPopup.InitValues;
var
  I: Integer;
  AShowAllItem: TcxCheckListBoxItem;
begin
  with Values.Items do
  begin
    BeginUpdate;
    PivotGrid.ShowHourglassCursor;
    FLocked := True;
    try
      Clear;
      FShowAllState := cbsUnchecked;
      AShowAllItem := Values.Items.Add;
      AShowAllItem.Text := cxGetResourceString(@scxPivotGridShowAll);
      for I := 0 to Field.GroupValueList.Count - 1 do
        AddValue(Field.GroupValueList.Items[I]);
      FShowAllState := GetStateByCount(GetCheckedCount);;
      AShowAllItem.State := FShowAllState;
    finally
      FLocked := False;
      PivotGrid.HideHourglassCursor;
      CheckButtonsEnabled;
      EndUpdate;
    end;
  end;
  FFilterModified := False;
end;

procedure TcxPivotGridFilterPopup.SetPopupSize(const AWidth, AHeight: Integer);
begin
  Values.Width := AWidth - cxTextOffset;
  Values.Height := AHeight - cxTextOffset;
  Properties.PopupHeight := AHeight;
  Properties.PopupWidth := AWidth;
end;

procedure TcxPivotGridFilterPopup.SetupPopupWindow;
var
  AHeight, AWidth, ADelta: Integer;
  R: TRect;
begin
  if FCancelButton = nil then
  begin
    inherited SetupPopupWindow;
    Exit;
  end;
  TcxEditStyleAccess(Style).PopupCloseButton := False;
  inherited SetupPopupWindow;
  AHeight := FCancelButton.Height;
  AWidth := FCancelButton.Width;
  ADelta := AWidth + AHeight div 6;
  Values.Style.Font := PivotGrid.Font;

  R := Rect(0, 0, 0, PopupWindow.ViewInfo.GetSysPanelHeight);
  if PopupWindow.ViewInfo.SizeGripCorner in [coBottomLeft, coBottomRight] then
    R := cxRectSetBottom(R, PopupWindow.Height);

  if PopupWindow.ViewInfo.SizeGripCorner in [coTopRight, coBottomRight] then
  begin
    R := cxRectSetRight(R, PopupWindow.Width -
      cxRectWidth(PopupWindow.ViewInfo.SizeGripRect));
    Inc(ADelta, PopupWindow.Width - R.Left)
  end
  else
  begin
    Inc(ADelta, AHeight div 6);
    if ADelta - AWidth < R.Left then
      ADelta := R.Left + AWidth;
  end;

  if PopupWindow.ViewInfo.SizeGripCorner in [coTopLeft, coTopRight] then
    FCancelButton.Anchors := [akTop, akRight]
  else
    FCancelButton.Anchors := [akBottom, akRight];
  FCancelButton.SetBounds(PopupWindow.Width - ADelta,
    (R.Bottom + R.Top - AHeight) div 2 - 1,  AWidth, AHeight);

  if FOkButton <> nil then
  begin
    FOkButton.SetBounds(FCancelButton.Left - (AWidth + (AHeight div 3)),
      FCancelButton.Top, AWidth, AHeight);
    FOkButton.Anchors := FCancelButton.Anchors;
  end;

  InitValues;
end;

procedure TcxPivotGridFilterPopup.UpdateWindowRegion;
begin
  SetEmptyRegion(Handle);
end;

procedure TcxPivotGridFilterPopup.ValuesChanges(Sender: TObject);
begin
  if FLocked then Exit;
  FFilterModified := True;
  if Values.Items[0].State <> FShowAllState then
    ShowAllState := Values.Items[0].State
  else
  begin
    FLocked := True;
    try
      FShowAllState := GetStateByCount(GetCheckedCount);
      Values.Items[0].State := FShowAllState;
    finally
      FLocked := False;
    end;
  end;
  CheckButtonsEnabled;
end;

function TcxPivotGridFilterPopup.GetPivotGrid: TcxCustomPivotGrid;
begin
  Result := TcxCustomPivotGrid(Parent);
end;

function TcxPivotGridFilterPopup.CreateButton(ATag: Integer): TcxButton;
begin
  Result := TcxButton.Create(Self);
  Result.Parent := PopupWindow;
  Result.Height := 20;
  Result.Tag := ATag;
  Result.LookAndFeel.MasterLookAndFeel := LookAndFeel;
  Result.OnClick := ButtonClickHandler;
end;

procedure TcxPivotGridFilterPopup.UpdateButtonCaptions;
begin
  FCancelButton.Caption := cxGetResourceString(@scxPivotGridCancel);
  FOkButton.Caption := cxGetResourceString(@scxPivotGridOk);
end;

function TcxPivotGridFilterPopup.GetFilter: TcxPivotGridFieldFilter;
begin
  Result := Field.Filter;
end;

procedure TcxPivotGridFilterPopup.SetField(AField: TcxPivotGridField);
begin
  if FField <> AField then
  begin
    FField := AField;
  end;
end;

procedure TcxPivotGridFilterPopup.SetShowAllState(AValue: TcxCheckBoxState);
var
  I: Integer;
begin
  if (FShowAllState <> AValue) and not FLocked then
  begin
    FLocked := True;
    FShowAllState := AValue;
    Values.Items.BeginUpdate;
    try
      for I := 0 to Values.Items.Count - 1 do
        Values.Items[I].State := AValue;
    finally
      Values.Items.EndUpdate;
      FLocked := False;
    end;
  end;
end;

{ TcxPivotGridCustomDragDropObject }

function TcxPivotGridCustomDragDropObject.GetPivotGrid: TcxCustomPivotGrid;
begin
  Result := TcxCustomPivotGrid(Control);
end;

function TcxPivotGridCustomDragDropObject.GetHitTest: TcxPivotGridHitTest;
begin
  Result := PivotGrid.HitTest;
end;

function TcxPivotGridCustomDragDropObject.GetOptionsView: TcxPivotGridOptionsView;
begin
  Result := PivotGrid.OptionsView;
end;

function TcxPivotGridCustomDragDropObject.GetPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := PivotGrid.LookAndFeelPainter;
end;

function TcxPivotGridCustomDragDropObject.GetViewInfo: TcxPivotGridViewInfo;
begin
  Result := PivotGrid.ViewInfo;
end;

{ TcxPivotGridResizingObject }

procedure TcxPivotGridResizingObject.BeginDragAndDrop;
begin
  SizingBounds := ViewInfo.RowsBounds;
  SizingBounds.Right := ViewInfo.Bounds.Right;
  if CurMousePos.Y <= SizingBounds.Top then
  begin
    with ViewInfo.ColumnsBounds do
    begin
      SizingBounds.Left := Left;
      SizingBounds.Top := Bottom - ViewInfo.HeaderHeight;
    end;
  end;
  StartPos := CurMousePos.X;
  FSizeCursorPos := CurMousePos.X;
  SizableObject := HitTest.ResizeField;
  StartPosDelta := HitTest.ResizeFieldStartPos - StartPos;
  SizingBounds.Left := CurMousePos.X - SizableObject.GetActualWidth + SizableObject.GetMinWidth;
  inherited BeginDragAndDrop;
end;

procedure TcxPivotGridResizingObject.DirtyChanged;
begin
  Canvas.InvertRect(SizeMarkBounds);
end;

procedure TcxPivotGridResizingObject.DragAndDrop(
  const P: TPoint; var Accepted: Boolean);
begin
  Accepted := True;
  SizeCursorPos := P.X;
  inherited DragAndDrop(P, Accepted);
end;

function TcxPivotGridResizingObject.GetDragAndDropCursor(
  Accepted: Boolean): TCursor;
begin
  Result := crcxPivotGridHorzSize;
end;

function TcxPivotGridResizingObject.GetImmediateStart: Boolean;
begin
  Result := True;
end;

function TcxPivotGridResizingObject.GetSizeDelta: Integer;
begin
  Result := SizeCursorPos - StartPos;
end;

function TcxPivotGridResizingObject.GetSizeMarkBounds: TRect;
begin
  Result := cxRectSetWidth(SizingBounds, Min(Max(SizingBounds.Left,
    StartPos + SizeDelta + StartPosDelta), SizingBounds.Right) - 1,
    cxPivotGridSizeMarkWidth);
end;

procedure TcxPivotGridResizingObject.SetSizeCursorPos(AValue: Integer);
begin
  if FSizeCursorPos <> AValue then
  begin
    Dirty := True;
    FSizeCursorPos := AValue;
  end;
end;

procedure TcxPivotGridResizingObject.EndDragAndDrop(Accepted: Boolean);
begin
  inherited EndDragAndDrop(Accepted);
  if Accepted and (SizeDelta <> 0) then
    SetSizeDelta(SizeDelta);
end;

procedure TcxPivotGridResizingObject.SetSizeDelta(ADelta: Integer);
begin
  SizableObject.SetWidth(SizableObject.GetActualWidth + ADelta);
  PivotGrid.Modified;
end;

{ TcxPivotGridDragAndDropObject }

function TcxPivotGridDragAndDropObject.AboveCustomization: Boolean;
begin
  Result := CanRemove;
  if Result then
    Result := PtInRect(PivotGrid.Customization.Form.BoundsRect, GetMouseCursorPos);
end;

procedure TcxPivotGridDragAndDropObject.BeginDragAndDrop;
begin
  FDragField := PivotGrid.Controller.DownField;
  PivotGrid.Controller.DownField := nil;
  TransparentMask := TList.Create;
  if DragField = nil then
    Control.FinishDragAndDrop(False)
  else
  begin
    DragImage := CreateDragImage;
    SaveImage := CreateBitmap(GetDragImageSize);
    TempImage := CreateBitmap(GetDragImageSize);
    with FieldViewInfo.Bounds do
    begin
      if FieldViewInfo.Visible then
        HotSpot := Point(TopLeft.X - CurMousePos.X, TopLeft.Y - CurMousePos.Y)
      else
        HotSpot := cxPointInvert(CurMousePos);
    end;
    HotSpot := PivotGrid.ClientToScreen(HotSpot);
  end;
  inherited BeginDragAndDrop;
end;

function TcxPivotGridDragAndDropObject.CanRemove: Boolean;
begin
  Result := PivotGrid.Customization.Visible and DragField.CanRemove;
  if Result and not PivotGrid.OptionsCustomize.Hiding then
    Result := PtInRect(PivotGrid.Customization.Form.BoundsRect, GetMouseCursorPos);
end;

function TcxPivotGridDragAndDropObject.CheckArea(const P: TPoint;
  var AInfo: TcxPivotGridDragDropAreaInfo): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to DragDropAreaCount - 1 do
  begin
    AInfo := DragDropAreas[I];
    Result := PtInRect(AInfo.Bounds, P);
    if Result then Break;
  end;
  Result := Result and DragField.CanDrop(AInfo.Area);
end;

function TcxPivotGridDragAndDropObject.CreateDragImage: TBitmap;
var
  R: TRect;
  I, J: Integer;
  AField: TcxPivotGridField;
  ACanvas: TcxCanvas;
  AGroup: TcxPivotGridFieldGroup;
  AViewInfo: TcxPivotGridFieldHeaderCellViewInfo;

begin
  with GetDragImageSize do
    R := cxRect(0, 0, cx, cy);
  Result := CreateBitmap(Windows.TSize(R.BottomRight));
  ACanvas := TcxCanvas.Create(Result.Canvas);
  try
    AViewInfo := FieldViewInfo;
    TransparentMask.Count := R.Right;
    if (AViewInfo.Group <> nil) and AViewInfo.Group.Visible then
    begin
      AGroup := AViewInfo.Group;
      for I := 0 to AGroup.FieldCount - 1 do
      begin
        AField := AGroup.Fields[I];
        R.Right := R.Left + cxRectWidth(AField.ViewInfo.Bounds);
        if not AField.VisibleInGroup then Break;
        AField.ViewInfo.PaintTo(ACanvas, R, cxbsNormal,
          PivotGrid.Painter.DoCustomDrawFieldHeader);
        R.Left := R.Right + cxPivotGridHorzSpace;
        for J := R.Right to R.Left - 1 do
        begin
          if J < TransparentMask.Count then
            TransparentMask.List^[J] := Pointer(1);
        end;
      end;
    end
    else
      AViewInfo.PaintTo(ACanvas, R, cxbsNormal, PivotGrid.Painter.DoCustomDrawFieldHeader);
  finally
    ACanvas.Free;
  end;
end;

procedure TcxPivotGridDragAndDropObject.DragAndDrop(
  const P: TPoint; var Accepted: Boolean);
var
  R, OldR, NewR: TRect;
begin
  Accepted := CheckArea(P, DragDropInfo);
  if Accepted and not IsSameDropPlace then
    Accepted := PivotGrid.Groups.CanDropTo(DragDropInfo.Area, DragDropInfo.AreaIndex);
  inherited DragAndDrop(P, Accepted);
  NewR := GetImageBounds(P);
  if not DragImageVisible then
    ShowDragImage
  else
  begin
    OldR := GetImageBounds(PrevMousePos);
    if cxRectIntersect(R, NewR, OldR) then
      CopyIntersectedImage(R, OldR, NewR)
    else
      CopyImage(OldR, NewR);
  end;
  ChangeArrowPos(not Accepted or IsSameDropPlace);
  AAccepted := Accepted;
end;

procedure TcxPivotGridDragAndDropObject.DragDropField(
  AArea: TcxPivotGridFieldArea; AAreaIndex: Integer);
begin
  PivotGrid.BeginUpdate;
  PivotGrid.ShowHourglassCursor;
  try
    if not IsSameDropPlace then
    begin
      DragField.DragDrop(AArea, AAreaIndex);
      PivotGrid.Modified;
    end;
  finally
    PivotGrid.EndUpdate;
    if FieldViewInfo.Field is TcxPivotGridField then
      PivotGrid.DoFieldPosChanged(TcxPivotGridField(FieldViewInfo.Field))
    else
      PivotGrid.DoFieldPosChanged(nil);
    PivotGrid.HideHourglassCursor;
  end;
end;

procedure TcxPivotGridDragAndDropObject.EndDragAndDrop(Accepted: Boolean);
begin
  inherited EndDragAndDrop(Accepted);
  if DragField <> nil then
  begin
    HideDragImage;
    DragField.SetState(cxbsNormal);
    RestoreArrows;
    if Accepted and AAccepted then
      DragDropField(DragDropInfo.Area, DragDropInfo.AreaIndex)
    else
      if Accepted and not AAccepted and CanRemove then
      begin
        if FieldViewInfo.Group <> nil then
          FieldViewInfo.Group.Visible := False
        else
          DragField.SetVisible(False);
        PivotGrid.Modified;
      end;
  end;
  FreeAndNil(TempImage);
  FreeAndNil(DragImage);
  FreeAndNil(SaveImage);
  FreeAndNil(ArrowsSaveBitmap);
  FreeAndNil(TransparentMask);
end;

function TcxPivotGridDragAndDropObject.GetDragAndDropCursor(
  Accepted: Boolean): TCursor;
begin
  if Accepted or AboveCustomization then
    Result := crcxPivotGridArrow
  else
    if CanRemove then
      Result := crcxPivotGridRemove
    else
      Result := crcxPivotGridNoDrop;
end;

function TcxPivotGridDragAndDropObject.GetDragImageSize: TSize;
var
  I: Integer;
  AField: TcxPivotGridField;
  AGroup: TcxPivotGridFieldGroup;
  AViewInfo: TcxPivotGridFieldHeaderCellViewInfo;
begin
  if not ImageSizeCalculated then
  begin
    AViewInfo := FieldViewInfo;
    ImageSize := cxRectSize(AViewInfo.Bounds);
    if (AViewInfo.Group <> nil) and AViewInfo.Group.Visible then
    begin
      AGroup := AViewInfo.Group;
      for I := 1 to AGroup.FieldCount - 1 do
      begin
        AField := AGroup.Fields[I];
        if not AField.VisibleInGroup then Break;
        Inc(ImageSize.cx, cxRectWidth(AField.ViewInfo.Bounds) + cxPivotGridHorzSpace);
      end;
    end;
  end;
  Result := ImageSize;
end;

function TcxPivotGridDragAndDropObject.IsSameDropPlace: Boolean;
begin
  Result := DragField.GetVisible and (DragDropInfo.Area = FieldViewInfo.Area);
  if Result then
  begin
    if FieldViewInfo.Group = nil then
    begin
      Result := ((DragDropInfo.AreaIndex - FieldViewInfo.AreaIndex) in [0, 1]) or
        (FieldViewInfo.Field = DragDropInfo.Field);
    end
    else
      Result := FieldViewInfo.Group.IsSameDropPlace(DragDropInfo.AreaIndex);
  end;
end;

function TcxPivotGridDragAndDropObject.IsPixelTransparent(
  ALine, APos: Integer): Boolean;
begin
  Result := (TransparentMask.List^[APos] <> nil) and (ALine <> ImageSize.cy div 2);
end;

procedure TcxPivotGridDragAndDropObject.TransparentMixDragImage;
var
  C1, C2: Double;
  ACount, AHeight, ALine, I: Integer;
  DstLine, BkSrcLine, SrcLine: PByteArray;
const
  Alpha = 200;
begin
  C1 := Alpha / 255;
  C2 := 1.0 - C1;
  with DragImage do
  begin
    AHeight := Height;
    ACount := ((Width * 24 + 31) and not 31) shr 3;
    BkSrcLine := SaveImage.ScanLine[AHeight - 1];
    SrcLine := DragImage.ScanLine[AHeight - 1];
    DstLine := TempImage.ScanLine[AHeight - 1];
  end;
  for ALine := 0 to AHeight - 1 do
  begin
    I := 0;
    while I < ACount do
    begin
      while (I < ACount - 1) and IsPixelTransparent(ALine, I div 3) do Inc(I, 3);
      DstLine^[I] := Round(SrcLine^[I] * C1) + Round(BkSrcLine^[I] * C2);
      Inc(I);
    end;
    Inc(Integer(BkSrcLine), ACount);
    Inc(Integer(SrcLine), ACount);
    Inc(Integer(DstLine), ACount);
  end;

end;

procedure TcxPivotGridDragAndDropObject.ChangeArrowPos(AllowHide: Boolean);
var
  ANewLine: TRect;
begin
  if not AllowHide then
  begin
    ANewLine := cxRectOffset(DragDropInfo.DisplayBounds,
      PivotGrid.ClientToScreen(cxNullPoint));
    if cxRectIsEqual(ArrowsLine, ANewLine) and (ArrowsSaveBitmap <> nil) then Exit;
  end
  else
    if (ArrowsSaveBitmap = nil) then Exit;
  HideDragImage;
  RestoreArrows;
  if AllowHide then
    FreeAndNil(ArrowsSaveBitmap)
  else
  begin
    ArrowsLine := ANewLine;
    DrawArrows;
  end;
  ShowDragImage;
end;

procedure TcxPivotGridDragAndDropObject.CopyIntersectedImage(
  const ARect, AOldRect, ANewRect: TRect);

  procedure IncV(const ARect: TRect; AOfs, Value: Integer; Direct: Boolean; out ARes: TRect);
  type
    TR = array[Boolean, 0..1] of Integer;
  begin
    ARes := ARect;
    TR(ARes)[Direct, AOfs] := TR(ARes)[not Direct, AOfs] + Value;
  end;

var
  R, R1: TRect;
  I: Integer;
  ADirect: Boolean;
  ASize: array[0..1] of Integer;
begin
  with ANewRect do
    TPoint(ASize) := cxPoint(AOldRect.Right - Right, AOldRect.Bottom - Bottom);

  cxCopyImage(SaveImage, TempImage, cxPointInvert(ANewRect.TopLeft),
    cxPointInvert(AOldRect.TopLeft), ARect);

  with CreateScreenCanvas do
  try
    for I := 0 to 1 do
    begin
      if ASize[I] <> 0 then
      begin
        ADirect := ASize[I] > 0;
        IncV(ANewRect, I, ASize[I], ADirect, R1);
        IncV(DragImageBounds, I, ASize[I], ADirect, R);
        TempImage.Canvas.CopyRect(R, Canvas, R1);
        IncV(AOldRect, I, -ASize[I], not ADirect, R1);
        IncV(DragImageBounds, I, -ASize[I], not ADirect, R);
        Canvas.CopyRect(R1, SaveImage.Canvas, R);
      end;
    end;
  finally
    Free;
  end;
  SwapImages(TempImage, SaveImage);
  DrawImage(ANewRect.TopLeft);
end;

procedure TcxPivotGridDragAndDropObject.CopyImage(
  const AOldRect, ANewRect: TRect);
begin
  RestoreScreen(PrevMousePos);
  GetScreenImage(CurMousePos);
  DrawImage(ANewRect.TopLeft);
end;

function TcxPivotGridDragAndDropObject.CreateBitmap(const ASize: TSize): TBitmap;
begin
  Result := TBitmap.Create;
  Result.PixelFormat := pf24bit;
  Result.Width := ASize.cx;
  Result.Height := ASize.cy;
end;

function TcxPivotGridDragAndDropObject.CreateScreenCanvas: TcxCanvas;
begin
  Result := TcxScreenCanvas.Create;
end;

procedure TcxPivotGridDragAndDropObject.DrawArrows;
var
  R: TRect;
  ScrR: array[0..1] of TRect;
  I: Integer;
begin
  GetArrowRects(ScrR[0], ScrR[1]);
  if ArrowsSaveBitmap = nil then
    ArrowsSaveBitmap := cxCreateBitmap(cxSize(20, 40));
  with CreateScreenCanvas do
  try
    for I := 0 to 1 do
    begin
      R := ScrR[I];
      OffsetRect(R, -ScrR[I].Left, -ScrR[I].Top);
      OffsetRect(R,  0, I * 20);
      ArrowsSaveBitmap.Canvas.CopyRect(R, Canvas, ScrR[I]);
    end;
    cxDrawArrows(Canvas, ArrowsLine, bLeft, DragDropArrowColor, clBtnText);
  finally
    Free;
  end;
end;

procedure TcxPivotGridDragAndDropObject.DrawImage(const APos: TPoint);
begin
  TransparentMixDragImage;
  with CreateScreenCanvas do
  try
    Draw(APos.X, APos.Y, TempImage);
  finally
    Free;
  end;
end;

procedure TcxPivotGridDragAndDropObject.GetArrowRects(out R1, R2: TRect);
begin
  with ArrowsLine do
  begin
     R1 := Rect(Left - 10, Top - 10, Left + 10, Top);
     R2 := Rect(Left - 10, Bottom, Left + 10, Bottom + 10);
  end;
end;

function TcxPivotGridDragAndDropObject.GetImageBounds(const APos: TPoint): TRect;
begin
  Result := DragImageBounds;
  OffsetRect(Result, HotSpot.X + APos.X, HotSpot.Y + APos.Y);
end;

procedure TcxPivotGridDragAndDropObject.GetScreenImage(
  const APos: TPoint);
begin
  with CreateScreenCanvas do
  try
    SaveImage.Canvas.CopyRect(DragImageBounds, Canvas, GetImageBounds(APos));
  finally
    Free;
  end;
end;

procedure TcxPivotGridDragAndDropObject.RestoreArrows;
var
  R: TRect;
  I: Integer;
  ARects: array[0..1] of TRect;
begin
  if ArrowsSaveBitmap = nil then Exit;
  GetArrowRects(ARects[0], ARects[1]);
  with CreateScreenCanvas do
  try
    for I := 0 to 1 do
    begin
      R := ARects[I];
      OffsetRect(R, -ARects[I].Left, -ARects[I].Top + I * 20);
      Canvas.CopyRect(ARects[I], ArrowsSaveBitmap.Canvas, R);
    end;
  finally
    Free;
  end;
end;

procedure TcxPivotGridDragAndDropObject.HideDragImage;
begin
  DragImageVisible := False;
  RestoreScreen(CurMousePos);
end;

procedure TcxPivotGridDragAndDropObject.RestoreScreen(
  const APos: TPoint);
begin
  with CreateScreenCanvas do
  try
    with cxPointOffset(APos, HotSpot) do
      Draw(X, Y, SaveImage);
  finally
    Free;
  end;
end;

procedure TcxPivotGridDragAndDropObject.ShowDragImage;
begin
  DragImageVisible := True;
  GetScreenImage(CurMousePos);
  DrawImage(GetImageBounds(CurMousePos).TopLeft);
end;

function TcxPivotGridDragAndDropObject.GetDragDropAreaCount: Integer;
begin
  Result := ViewInfo.FDragDropAreas.Count;
end;

function TcxPivotGridDragAndDropObject.GetDragDropArea(
  AIndex: Integer): TcxPivotGridDragDropAreaInfo;
begin
  Result := ViewInfo.FDragDropAreas[AIndex] as TcxPivotGridDragDropAreaInfo;
end;

function TcxPivotGridDragAndDropObject.GetDragDropArrowColor: TColor;
begin
  Result := PivotGrid.OptionsView.DropArrowColor;
end;

function TcxPivotGridDragAndDropObject.GetDragImageBounds: TRect;
begin
  Result.TopLeft := cxNullPoint;
  TSize(Result.BottomRight) := GetDragImageSize;
end;

function TcxPivotGridDragAndDropObject.GetFieldViewInfo: TcxPivotGridFieldHeaderCellViewInfo;
begin
  Result := DragField.GetViewInfo;
  if Result.Group <> nil then
    Result := Result.Group.Fields[0].ViewInfo;
end;

{ TcxPivotGridFieldFilter }

constructor TcxPivotGridFieldFilter.Create(AOwner: TcxPivotGridField);
begin
  inherited Create;
  FField := AOwner;
  FValues := TcxPivotGridVariantList.Create;
  FValues.OnChange := ValuesChanged;
end;

destructor TcxPivotGridFieldFilter.Destroy;
begin
  FValues.Free;
  inherited Destroy;
end;

procedure TcxPivotGridFieldFilter.Assign(Source: TPersistent);
var
  I: Integer;
begin
  if Source is TcxPivotGridFieldFilter then
  begin
    Clear;
    FFilterType := TcxPivotGridFieldFilter(Source).FilterType;
    for I := 0 to TcxPivotGridFieldFilter(Source).Values.Count - 1 do
      Values.Add(TcxPivotGridFieldFilter(Source).Values[I]);
  end
  else
    inherited Assign(Source);
end;

procedure TcxPivotGridFieldFilter.Clear;
begin
  FValues.Clear;
  Changed;
end;

function TcxPivotGridFieldFilter.Contains(const AValue: Variant): Boolean;
begin
  if FilterType = ftExcluded then
    Result := Values.IndexOf(AValue) = -1
  else
    Result := Values.IndexOf(AValue) <> -1;
end;

procedure TcxPivotGridFieldFilter.Changed;
begin
  if FLockCount = 0 then
  begin
    CallNotify(OnChange, Self);
    FModified := False;
  end
  else
    FModified := True;
end;

function TcxPivotGridFieldFilter.GetOwner: TPersistent;
begin
  Result := Field;
end;

procedure TcxPivotGridFieldFilter.ValuesChanged(ASender: TObject);
begin
  Changed;
end;

procedure TcxPivotGridFieldFilter.BeginUpdate;
begin
  Inc(FLockCount);
end;

procedure TcxPivotGridFieldFilter.EndUpdate(AForceUpdate: Boolean = True);
begin
  if FLockCount > 0 then
  begin
    Dec(FLockCount);
    if AForceUpdate or FModified then
      Changed;
  end;
end;

procedure TcxPivotGridFieldFilter.ReadData(AStream: TStream);
var
  AFilterType: TcxPivotGridFilterType;
  I: Integer;
  ACount: Integer;
begin
  AStream.ReadBuffer(AFilterType, SizeOf(AFilterType));
  FilterType := AFilterType;
  AStream.ReadBuffer(ACount, SizeOf(ACount));

  Values.BeginUpdate;
  try
    Values.Clear;
    for I := 0 to ACount - 1 do
      Values.Add(ReadVariantFunc(AStream));
  finally
    Values.EndUpdate;
  end;
end;

procedure TcxPivotGridFieldFilter.WriteData(AStream: TStream);
var
  AFilterType: TcxPivotGridFilterType;
  I: Integer;
  ACount: Integer;
begin
  AFilterType := FilterType;
  AStream.WriteBuffer(AFilterType, SizeOf(AFilterType));
  ACount := Values.Count;
  AStream.WriteBuffer(ACount, SizeOf(ACount));

  for I := 0 to ACount - 1 do
    WriteVariantProc(AStream, Values[I]);
end;

function TcxPivotGridFieldFilter.GetHasFilter: Boolean;
begin
  Result := Values.Count <> 0;
end;

function TcxPivotGridFieldFilter.GetPivotGrid: TcxCustomPivotGrid;
begin
  Result := Field.PivotGrid;
end;

procedure TcxPivotGridFieldFilter.SetFilterType(
  AFilterType: TcxPivotGridFilterType);
begin
  FFilterType := AFilterType;
  Changed;
end;

{ TcxPivotGridFieldOptions }

constructor TcxPivotGridFieldOptions.Create(AOwner: TcxPivotGridField);
begin
  FField := AOwner;
  FFiltering := True;
  FMoving := True;
  FSizing := True;
  FSorting := True;
end;

procedure TcxPivotGridFieldOptions.Assign(Source: TPersistent);
begin
  if Source is TcxPivotGridFieldOptions then
    with TcxPivotGridFieldOptions(Source) do
    begin
      Self.FFiltering := FFiltering;
      Self.FMoving := FMoving;
      Self.FSizing := FSizing;
      Self.FSorting := FSorting;
    end
  else
    inherited Assign(Source);
end;

function TcxPivotGridFieldOptions.CanFiltering: Boolean;
begin
  Result := Field.PivotGrid.OptionsCustomize.Filtering and
    Filtering;
end;

function TcxPivotGridFieldOptions.CanSorting: Boolean;
begin
  Result := Field.PivotGrid.OptionsCustomize.Sorting and
    Sorting and (Field.Area in [faColumn, faRow]);
end;

procedure TcxPivotGridFieldOptions.Changed;
begin
  Field.Changed;
end;

function TcxPivotGridFieldOptions.GetOwner: TPersistent;
begin
  Result := FField;
end;

procedure TcxPivotGridFieldOptions.SetOption(
  var AOption: Boolean; ANewValue: Boolean);
begin
  if AOption <> ANewValue then
  begin
    AOption := ANewValue;
    Changed;
  end;
end;

procedure TcxPivotGridFieldOptions.SetFiltering(AValue: Boolean);
begin
  if FFiltering <> AValue then
  begin
    FFiltering := AValue;
    Field.PivotGrid.RefreshFilterableFieldsList;
    Changed;
  end;
end;

procedure TcxPivotGridFieldOptions.SetMoving(AValue: Boolean);
begin
  SetOption(FMoving, AValue);
end;

procedure TcxPivotGridFieldOptions.SetSizing(AValue: Boolean);
begin
  SetOption(FSizing, AValue);
end;

procedure TcxPivotGridFieldOptions.SetSorting(AValue: Boolean);
begin
  SetOption(FSorting, AValue);
end;

{ TcxPivotGridCustomTotal }

constructor TcxPivotGridCustomTotal.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  SummaryType := stSum;
end;

procedure TcxPivotGridCustomTotal.Assign(Source: TPersistent);
begin
  if Source is TcxPivotGridCustomTotal then
  begin
    SummaryType := TcxPivotGridCustomTotal(Source).SummaryType;
    DisplayFormat := TcxPivotGridCustomTotal(Source).DisplayFormat;
  end;
end;

function TcxPivotGridCustomTotal.GetField: TcxPivotGridField;
begin
  Result := TcxPivotGridCustomTotalCollection(Collection).Field;
end;

function TcxPivotGridCustomTotal.GetPivotGrid: TcxCustomPivotGrid;
begin
  Result := Field.PivotGrid;
end;

procedure TcxPivotGridCustomTotal.SetDisplayFormat(const AValue: string);
begin
  if FDisplayFormat <> AValue then
  begin
    FDisplayFormat := AValue;
    Changed(True);
  end;
end;

procedure TcxPivotGridCustomTotal.SetSummaryType(AValue: TcxPivotGridSummaryType);
begin
  if FSummaryType <> AValue then
  begin
    FSummaryType := AValue;
    Changed(True);
  end;
end;

{ TcxPivotGridCustomTotalCollection }

constructor TcxPivotGridCustomTotalCollection.Create(AOwner: TcxPivotGridField);
begin
  inherited Create(TcxPivotGridCustomTotal);
  FOwner := AOwner;
end;

function TcxPivotGridCustomTotalCollection.Add(
  ASummaryType: TcxPivotGridSummaryType): TcxPivotGridCustomTotal;
begin
  PivotGrid.BeginUpdate;
  try
    Result := TcxPivotGridCustomTotal(inherited Add);
    Result.SummaryType := ASummaryType;
  finally
    PivotGrid.EndUpdate;
  end;
end;

function TcxPivotGridCustomTotalCollection.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TcxPivotGridCustomTotalCollection.Update(Item: TCollectionItem);
begin
  inherited Update(Item);
  if Field <> nil then
    Field.Changed;
end;

function TcxPivotGridCustomTotalCollection.GetItem(
  AIndex: Integer): TcxPivotGridCustomTotal;
begin
  Result := TcxPivotGridCustomTotal(inherited Items[AIndex]);
end;

function TcxPivotGridCustomTotalCollection.GetPivotGrid: TcxCustomPivotGrid;
begin
  Result := Field.PivotGrid;
end;

procedure TcxPivotGridCustomTotalCollection.SetItem(
  AIndex: Integer; AValue: TcxPivotGridCustomTotal);
begin
  Items[AIndex].Assign(AValue);
end;

{ TcxPivotGridSortBySummaryInfo }

constructor TcxPivotGridSortBySummaryInfo.Create(AOwner: TcxPivotGridField);
begin
  FOwner := AOwner;
  FSummaryType := stSum;
end;

procedure TcxPivotGridSortBySummaryInfo.Assign(Source: TPersistent);
begin
  if Source is TcxPivotGridSortBySummaryInfo then
  begin
    FField := TcxPivotGridSortBySummaryInfo(Source).Field;
    FSummaryType := TcxPivotGridSortBySummaryInfo(Source).SummaryType;
  end;
end;

procedure TcxPivotGridSortBySummaryInfo.Changed;
begin
  PivotGrid.DataChanged;
end;

function TcxPivotGridSortBySummaryInfo.GetOwner: TPersistent;
begin
  Result := Owner;
end;

function TcxPivotGridSortBySummaryInfo.ValidateProperties: Boolean;
begin
  Result := (Field <> nil) and (Field.Area = faData);
end;

function TcxPivotGridSortBySummaryInfo.GetPivotGrid: TcxCustomPivotGrid;
begin
  Result := Owner.PivotGrid;
end;

procedure TcxPivotGridSortBySummaryInfo.SetField(
  AValue: TcxPivotGridField);
begin
  if AValue <> FField then
  begin
    FField := AValue;
    Changed;
  end;
end;

procedure TcxPivotGridSortBySummaryInfo.SetSummaryType(
  AValue: TcxPivotGridSummaryType);
begin
  if AValue <> FSummaryType then
  begin
    FSummaryType := AValue;
    Changed;
  end;
end;

{ TcxPivotGridDefaultValuesProvider }

function TcxPivotGridDefaultValuesProvider.IsDisplayFormatDefined(
  AIsCurrencyValueAccepted: Boolean): Boolean;
begin
  with TcxPivotGridFieldDataBinding(Owner) do
    Result := PivotGrid.DataController.IsDisplayFormatDefined(
      Field.Index, not AIsCurrencyValueAccepted);
end;

{ TcxPivotGridFieldDataBinding }

constructor TcxPivotGridFieldDataBinding.Create(AOwner: TcxPivotGridField);
begin
  inherited Create;
  FField := AOwner;
  FDefaultValuesProvider := GetDefaultValuesProviderClass.Create(Self);
end;

destructor TcxPivotGridFieldDataBinding.Destroy;
begin
  FDefaultValuesProvider.Free;
  inherited;
end;

procedure TcxPivotGridFieldDataBinding.Assign(Source: TPersistent);
begin
  if Source is TcxPivotGridFieldDataBinding then
    ValueType := TcxPivotGridFieldDataBinding(Source).ValueType
  else
    inherited Assign(Source);
end;

function TcxPivotGridFieldDataBinding.GetDefaultValuesProvider: IcxEditDefaultValuesProvider;
begin
  Result := FDefaultValuesProvider;
  Init;
end;

function TcxPivotGridFieldDataBinding.GetDefaultValuesProviderClass: TcxCustomEditDefaultValuesProviderClass;
begin
  Result := TcxPivotGridDefaultValuesProvider;
end;

function TcxPivotGridFieldDataBinding.GetFilterFieldName: string;
begin
  Result := '';
end;

function TcxPivotGridFieldDataBinding.GetOwner: TPersistent;
begin
  Result := FField;
end;

procedure TcxPivotGridFieldDataBinding.Init;
begin
//do nothing
end;

function TcxPivotGridFieldDataBinding.GetPivotGrid: TcxCustomPivotGrid;
begin
  Result := Field.PivotGrid;
end;

function TcxPivotGridFieldDataBinding.GetValueType: string;
begin
  if ValueTypeClass <> nil then
    Result := ValueTypeClass.Caption
  else
    Result := '';
end;

function TcxPivotGridFieldDataBinding.GetValueTypeClass: TcxValueTypeClass;
begin
  Result := PivotGrid.DataController.GetItemValueTypeClass(Field.Index);
end;

procedure TcxPivotGridFieldDataBinding.SetValueType(AValue: string);
begin
  ValueTypeClass := cxValueTypeClassList.ItemByCaption(AValue);
end;

procedure TcxPivotGridFieldDataBinding.SetValueTypeClass(AValue: TcxValueTypeClass);
begin
  FValueTypeAssigned := True;
  PivotGrid.DataController.ChangeValueTypeClass(Field.Index, AValue);
  FField.PropertiesValueChanged;
end;

function TcxPivotGridFieldDataBinding.IsValueTypeStored: Boolean;
begin
  Result := FValueTypeAssigned;
end;

{ TcxPivotGridField }

constructor TcxPivotGridField.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  CreateSubClasses;
  FAllowedAreas := [faColumn..faData];
  FArea := faFilter;
  FAreaIndex := -1;
  FGroupExpanded := True;
  FGroupIntervalRange := cxPivotGridDefaultGroupIntervalRange;
  FImageIndex := -1;
  FSortOrder := soNone;
  FSummaryIndex := -1;
  FSummaryType := stSum;
  FMinWidth := cxPivotGridDefaultFieldMinWidth;
  FImageAlign := taLeftJustify;
  FFilter.OnChange := FilterChanged;
end;

destructor TcxPivotGridField.Destroy;
begin
  Group := nil;
  PivotGrid := nil;
  RepositoryItem := nil;
  DestroySubClasses;
  PropertiesValueChanged;
  DestroyEditViewData;
  FreeAndNil(FEditStyle);
  inherited Destroy;
end;

procedure TcxPivotGridField.Assign(Source: TPersistent);
begin
  if Source is TcxPivotGridField then
  begin
    AllowedAreas := TcxPivotGridField(Source).AllowedAreas;
    Area := TcxPivotGridField(Source).Area;
    AreaIndex := TcxPivotGridField(Source).AreaIndex;
    Caption := TcxPivotGridField(Source).Caption;
    CustomTotals := TcxPivotGridField(Source).CustomTotals;
    DataBinding := TcxPivotGridField(Source).DataBinding;
    DisplayFormat := TcxPivotGridField(Source).DisplayFormat;
    GroupExpanded := TcxPivotGridField(Source).GroupExpanded;
    GroupInterval := TcxPivotGridField(Source).GroupInterval;
    GroupIntervalRange := TcxPivotGridField(Source).GroupIntervalRange;
    Hidden := TcxPivotGridField(Source).Hidden;
    MinWidth := TcxPivotGridField(Source).MinWidth;
    ImageAlign := TcxPivotGridField(Source).ImageAlign;
    ImageIndex := TcxPivotGridField(Source).ImageIndex;
    Options := TcxPivotGridField(Source).Options;
    SortBySummaryInfo := TcxPivotGridField(Source).SortBySummaryInfo;
    SortOrder := TcxPivotGridField(Source).SortOrder;
    SummaryType := TcxPivotGridField(Source).SummaryType;
    SummaryVariation := TcxPivotGridField(Source).SummaryVariation;
    TopValueCount := TcxPivotGridField(Source).TopValueCount;
    TopValueShowOthers := TcxPivotGridField(Source).TopValueShowOthers;
    TotalsVisibility := TcxPivotGridField(Source).TotalsVisibility;
    Width := TcxPivotGridField(Source).Width;
    DataVisibility := TcxPivotGridField(Source).DataVisibility;
  end;
end;

procedure TcxPivotGridField.ApplyBestFit;
var
  AWidth, I: Integer;
begin
  if not VisibleInGroup or (Area = faFilter) then Exit;
  PivotGrid.CheckChanges;
  PivotGrid.ShowHourglassCursor;
  try
    AWidth := MinWidth;
    if (Area = faRow) or ((Area = faData) and (PivotGrid.OptionsDataField.Area = dfaRow)) then
    begin
      AWidth := Max(ViewInfo.MeasureWidth + cxPivotGridDoubleSpace,
        PivotGrid.ViewData.FRows.MeasureWidth(Self, False) + cxTextOffset)
    end
    else
      with PivotGrid.ViewData do
      begin
        AWidth := Max(AWidth, FColumns.MeasureWidth(Self, True) + cxTextOffset);
        if Area = faColumn then
        begin
          for I := 0 to PivotGrid.SummaryFields.Count - 1 do
            AWidth := Max(AWidth, CalculateDataWidth(PivotGrid.SummaryFields[I]) + cxTextOffset);
        end
        else
          AWidth := Max(AWidth, CalculateDataWidth(Self) + cxTextOffset);
      end;
    Width := AWidth;
    PivotGrid.DataChanged;
  finally
    PivotGrid.HideHourglassCursor;
  end;
end;

procedure TcxPivotGridField.CollapseAll;
begin
  SetExpanding(False);
end;

procedure TcxPivotGridField.ExpandAll;
begin
  SetExpanding(True);
end;

function TcxPivotGridField.GetGroupValue(ARecordIndex: Integer): Variant;
var
  S: string;
  Negative: Boolean;
  AGroupInterval: TcxPivotGridGroupInterval;
begin
  Result := Values[ARecordIndex];
  AGroupInterval := GroupInterval;
  if (Area = faData) and (AGroupInterval <> giAlphabetical) then
    AGroupInterval := giDefault;
  if AGroupInterval = giDefault then Exit;
  try
    case AGroupInterval of
      giDate:
        Result := DateOf(VarToDateTime(Result));
      giDateDay:
        Result := DayOfTheMonth(VarToDateTime(Result));
      giDateDayOfWeek:
        Result := DayOfWeek(VarToDateTime(Result));
      giDateDayOfYear:
        Result := DayOfTheYear(VarToDateTime(Result));
      giDateWeekOfMonth:
        Result := WeekOfTheMonth(VarToDateTime(Result));
      giDateWeekOfYear:
        Result := Trunc(DateOf(VarToDateTime(Result) - GetStartDateOfYear(VarToDateTime(Result)))) div 7 + 1;
      giDateMonth:
        Result := MonthOf(VarToDateTime(Result));
      giDateQuarter:
        Result := (MonthOf(VarToDateTime(Result)) - 1) div 3 + 1;
      giDateYear:
        Result := YearOf(VarToDateTime(Result));
      giYearAge:
        Result := YearsBetween(VarToDateTime(Result), PivotGrid.RefreshDate);
      giMonthAge:
        Result := MonthsBetween(VarToDateTime(Result), PivotGrid.RefreshDate);
      giWeekAge:
        Result := WeeksBetween(VarToDateTime(Result), PivotGrid.RefreshDate);
      giDayAge:
        Result := DaysBetween(VarToDateTime(Result), PivotGrid.RefreshDate);
      giAlphabetical:
      begin
        S := VarToStr(Result);
        if Length(S) > 0 then
          Result := S[1]
        else
          Result := '';
      end;
      giCustom:
        Result := DoGetGroupValue(Result, ARecordIndex);
    end;
    if AGroupInterval in [giYearAge, giMonthAge, giWeekAge, giDayAge, giNumeric] then
    begin
      if VarIsNumericEx(Result) then
      begin
        Negative := Result < 0;
        Result := Integer(Round(Result) div GroupIntervalRange);
        if Negative then
          Dec(Result);
      end
      else
        Result := 0;
    end;
  except
    on EVariantError do
      Result := Null
    else
      raise;
  end;
end;

function TcxPivotGridField.GetGroupValueDisplayText(
  const AGroupValue: Variant): string;
begin
  try
    case GroupInterval of
      giDateDayOfWeek:
        Result := dxFormatSettings.LongDayNames[Integer(AGroupValue)];
      giDateMonth:
        Result := dxFormatSettings.LongMonthNames[Integer(AGroupValue)];
      giDateQuarter:
        Result := Format(cxGetResourceString(@scxQuarterFormat), [Integer(AGroupValue)]);
      giYearAge, giMonthAge, giWeekAge, giDayAge, giNumeric:
      begin
        Result := Format('%d-%d', [Integer(AGroupValue * GroupIntervalRange),
          Integer((AGroupValue + 1) * GroupIntervalRange - 1)]);
      end;
      giCustom:
        Result := DoGetGroupValueDisplayText(AGroupValue);
    else
      Result := VarToStr(AGroupValue);
    end;
  except
    on EVariantError do
      Result := ''
    else
      raise;
  end;
end;

function TcxPivotGridField.GetParentComponent: TComponent;
begin
  Result := PivotGrid;
end;

function TcxPivotGridField.HasParent: Boolean;
begin
  Result := True;
end;

procedure TcxPivotGridField.SetAreaPosition(
  AArea: TcxPivotGridFieldArea; AAreaIndex:  Integer);
begin
  PivotGrid.BeginUpdate;
  try
    Area := AArea;
    AreaIndex := AAreaIndex;
  finally
    PivotGrid.EndUpdate;
  end;
end;

function TcxPivotGridField.CanDrag: Boolean;
begin
  Result := Options.Moving and PivotGrid.OptionsCustomize.Moving;
end;

function TcxPivotGridField.CanDrop(AArea: TcxPivotGridFieldArea): Boolean;
begin
  Result := AArea in AllowedAreas;
end;

function TcxPivotGridField.CanModifyArea: Boolean;
begin
  Result := (PivotGrid <> nil) and (Group = nil) or IsFirstFieldInGroup;
end;

function TcxPivotGridField.CanRemove: Boolean;
begin
  Result := True;
end;

function TcxPivotGridField.CanResize: Boolean;
begin
  Result := Options.Sizing and PivotGrid.OptionsCustomize.Sizing;
end;

procedure TcxPivotGridField.Changed(AIsViewChanged: Boolean = False);
begin
  if PivotGrid <> nil then
  begin
    if AIsViewChanged then
      PivotGrid.ViewChanged
    else
      PivotGrid.LayoutChanged;
    PivotGrid.Customization.Refresh;
  end;
end;

function TcxPivotGridField.CreateEditStyle(AProperties: TcxCustomEditProperties): TcxEditStyle;
begin
  Result := AProperties.GetStyleClass.Create(nil, True) as TcxEditStyle;
  Result.LookAndFeel.MasterLookAndFeel := PivotGrid.LookAndFeel;
end;

procedure TcxPivotGridField.CreateEditViewData;
begin
  FEditViewData := GetUserEditProperties.CreateViewData(FEditStyle, True)
end;

procedure TcxPivotGridField.DataChanged;
begin
  if PivotGrid <> nil then
  begin
    PivotGrid.DataChanged;
    PivotGrid.Customization.Refresh;
  end;
end;

function TcxPivotGridField.DefaultRepositoryItem: TcxEditRepositoryItem;
begin
  Result := GetDefaultEditDataRepositoryItems.GetItem(DataBinding.ValueTypeClass);
end;

procedure TcxPivotGridField.DestroyEditViewData;
begin
  FreeAndNil(FEditViewData);
end;

procedure TcxPivotGridField.DoCalculateCustomSummary(
  ACell: TcxPivotGridCrossCellSummary);
begin
  if Assigned(FOnCalculateCustomSummary) then
    FOnCalculateCustomSummary(Self, ACell);
end;

procedure TcxPivotGridField.DoGetDisplayText(
  ACell: TcxPivotGridDataCellViewInfo);
begin
  ACell.FDisplayText := FormatDisplayValue(ACell.Value, ACell.DisplayFormat,
    (ACell.Total = nil) and (SummaryVariation in [svPercent, svPercentOfColumn, svPercentOfRow]));
  InternalDoGetDisplayText(ACell, ACell.FDisplayText);
end;

function TcxPivotGridField.DoGetGroupImageIndex(AItem: TcxPivotGridViewDataItem;
  var AAlignHorz: TAlignment; var AAlignVert: TcxAlignmentVert): Integer;
begin
  Result := -1;
  if (PivotGrid.GroupHeaderImages <> nil) and Assigned(FOnGetGroupImageIndex) then
  begin
    AAlignHorz := taLeftJustify;
    AAlignVert := vaTop;
    FOnGetGroupImageIndex(Self, AItem, Result, AAlignHorz, AAlignVert);
    if (Result >= PivotGrid.GroupHeaderImages.Count) or (Result < 0) then
      Result := -1;
  end;
end;

function TcxPivotGridField.DoGetGroupValue(
  const AValue: Variant; ARecordIndex: Integer): Variant;
begin
  Result := AValue;
  if Assigned(FOngetGroupValue) then
    FOnGetGroupValue(Self, ARecordIndex, Result);
end;

function TcxPivotGridField.DoGetGroupValueDisplayText(
  const AValue: Variant): string;
begin
  Result := VarToStr(AValue);
  if Assigned(FOnGetGroupValueDisplayText) then
    FOnGetGroupValueDisplayText(Self, AValue, Result);
end;

procedure TcxPivotGridField.DoFilterChanged;
begin
  DataChanged;
  if PivotGrid <> nil then
    PivotGrid.DoFilterChanged;
end;

function TcxPivotGridField.DoGetProperties(ACell: TcxPivotGridCustomCellViewInfo): TcxCustomEditProperties;
begin
  Result := GetUserEditProperties;
  if Assigned(FOnGetProperties) then
    FOnGetProperties(Self, ACell, Result);
end;

procedure TcxPivotGridField.DoGetTotalDisplayText(AGroupItem: TcxPivotGridGroupItem; var AText: string);
begin
  if Assigned(FOnGetTotalDisplayText) then
    FOnGetTotalDisplayText(Self, AGroupItem, AText);
end;

procedure TcxPivotGridField.DragDrop(
  AArea: TcxPivotGridFieldArea; AAreaIndex: Integer);
var
  APrevVisible: Boolean;
  APrevAreaIndex: Integer;
begin
  APrevAreaIndex := AAreaIndex;
  APrevVisible := Visible;
  if (Area = AArea) and (AAreaIndex > ViewInfo.AreaIndex)
    and (AAreaIndex > 0) and Visible then Dec(AAreaIndex);
  PivotGrid.BeginUpdate;
  try
    FVisible := True;
    if Group <> nil then
    begin
      if Group.AreaIndex <> AreaIndex then
      begin
        Group.Fields[0].DragDrop(AArea, APrevAreaIndex);
        Exit;
      end;
      if ((AArea <> Group.Area) or not APrevVisible) and (AAreaIndex > ViewInfo.AreaIndex)  then
        Inc(AAreaIndex, Group.VisibleCount - 1);
      Group.InternalSetArea(AArea);
      Group.AreaIndex := AAreaIndex;
    end
    else
    begin
      FArea := AArea;
      AreaIndex := AAreaIndex;
    end;
  finally
    PivotGrid.DataChanged;
    PivotGrid.EndUpdate;
  end;
end;

function TcxPivotGridField.GetEditViewData: TcxCustomEditViewData;
begin
  if FEditViewData = nil then
    CreateEditViewData;
  Result := FEditViewData;
end;

procedure TcxPivotGridField.InitGroupValues;
var
  I, AGroupValueIndex: Integer;
begin
  if FGroupValuesValid then Exit;
  FGroupValueList.Clear;
  if PivotGrid.OLAPDataSource <> nil then
    PivotGrid.OLAPDataSource.InitializeMembers(FLink, FGroupValueList)
  else
  begin
    for I := 0 to RecordCount - 1 do
    begin
      AGroupValueIndex := FGroupValueList.Add(GetGroupValue(I));
      FGroupValueList.Items[AGroupValueIndex].FUnUsed := (PivotGrid.DataBuilder.FilteredIndexes[I] <= -2) or
        ((PivotGrid.DataBuilder.FilteredIndexes[I] = -1) and Filter.Contains(GetGroupValue(I)));
    end;
  end;
  FGroupValueList.MakeUnique;
  FGroupValuesValid := True;
end;

procedure TcxPivotGridField.InitProperties(AProperties: TcxCustomEditProperties);
begin
  if AProperties <> nil then
    with AProperties do
    begin
      LockUpdate(True);
      IDefaultValuesProvider := DataBinding.GetDefaultValuesProvider;
      LockUpdate(False);
    end;
end;

function TcxPivotGridField.IsCurrency(AType: TcxValueTypeClass): Boolean;
begin
  Result := (AType = TcxCurrencyValueType) or (AType = TcxFMTBcdValueType);
end;

function TcxPivotGridField.IsItemExpanded(
  AGroup: TcxPivotGridGroupItem): Boolean;
begin
  Result := (ExpandingInfo.Count <> 0) and
    (ExpandingInfo.IndexOf(AGroup.GetUniqueValue) <> -1);
end;

function TcxPivotGridField.HasSummaryVariation: Boolean;
begin
  Result := SummaryVariation <> svNone;
end;

function TcxPivotGridField.GetActualDisplayFormat: string;
begin
  Result := FDisplayFormat;
end;

function TcxPivotGridField.GetEditProperties: TcxCustomEditProperties;
begin
  Result := FPropertiesValue;
  InitProperties(Result);
end;

function TcxPivotGridField.GetEditStyle(AProperties: TcxCustomEditProperties;
  ALocal: Boolean): TcxEditStyle;
begin
  if ALocal then
    Result := CreateEditStyle(AProperties)
  else
    Result := FEditStyle;
end;

function TcxPivotGridField.GetUserEditProperties: TcxCustomEditProperties;
begin
  if FRepositoryItem <> nil then
    Result := FRepositoryItem.Properties
  else
    Result := FProperties;
  InitProperties(Result);
end;

function TcxPivotGridField.GetPropertiesValue: TcxCustomEditProperties;
begin
  if FLastUsedDefaultRepositoryItem <> nil then
  begin
    FLastUsedDefaultRepositoryItem.RemoveListener(Self);
    FLastUsedDefaultRepositoryItem := nil;
  end;
  if FPivotGrid = nil then
    Result := nil
  else
  begin
    Result := GetUserEditProperties;
    if (Result = nil) and (GetRepositoryItem <> nil) then
      Result := GetRepositoryItem.Properties;
  end;
end;

function TcxPivotGridField.GetRepositoryItem: TcxEditRepositoryItem;
begin
  Result := FRepositoryItem;
  if (Result = nil) and not GetIsDestroying then
  begin
    Result := DefaultRepositoryItem;
    if Result <> nil then
    begin
      Result.AddListener(Self);
      FLastUsedDefaultRepositoryItem := Result;
    end;
  end;
end;

procedure TcxPivotGridField.EditViewDataGetDisplayTextHandler(Sender: TcxCustomEditViewData;
  var AText: string);
var
  ACell: TcxPivotGridDataCellViewInfo;
begin
  if Sender.Data is TcxPivotGridDataCellViewInfo then
    ACell := TcxPivotGridDataCellViewInfo(Sender.Data)
  else
    ACell := nil;
  InternalDoGetDisplayText(ACell, AText);
end;

procedure TcxPivotGridField.PropertiesChanged;
begin
  FreeAndNil(FEditStyle);
  if UseEditProperties and not GetIsDestroying then
    FEditStyle := CreateEditStyle(GetUserEditProperties);
  Changed;
end;

procedure TcxPivotGridField.PropertiesChangedHandler(Sender: TObject);
begin
  PropertiesChanged;
end;

procedure TcxPivotGridField.PropertiesValueChanged;
begin
  FPropertiesValue := GetPropertiesValue;
end;

function TcxPivotGridField.UseEditProperties: Boolean;
begin
  Result := (FRepositoryItem <> nil) or (FProperties <> nil);
end;

function TcxPivotGridField.CreateCustomTotals: TcxPivotGridCustomTotalCollection;
begin
  Result := TcxPivotGridCustomTotalCollection.Create(Self);
end;

function TcxPivotGridField.CreateDataBinding: TcxPivotGridFieldDataBinding;
begin
  Result := TcxPivotGridFieldDataBinding.Create(Self);
end;

function TcxPivotGridField.CreateFilter: TcxPivotGridFieldFilter;
begin
  Result := TcxPivotGridFieldFilter.Create(Self);
end;

function TcxPivotGridField.CreateOptions: TcxPivotGridFieldOptions;
begin
  Result := TcxPivotGridFieldOptions.Create(Self);
end;

function TcxPivotGridField.CreateSortBySummaryInfo: TcxPivotGridSortBySummaryInfo;
begin
  Result := TcxPivotGridSortBySummaryInfo.Create(Self);
end;

function TcxPivotGridField.CreateStyles: TcxPivotGridFieldStyles;
begin
  Result := TcxPivotGridFieldStyles.Create(Self);
end;

procedure TcxPivotGridField.CreateSubClasses;
begin
  FDataBinding := CreateDataBinding;
  FExpandingInfo := TcxPivotGridVariantList.Create();
  FViewInfo := TcxPivotGridFieldHeaderCellViewInfo.CreateEx(Self);
  FCustomTotals := CreateCustomTotals;
  FFilter := CreateFilter;
  FOptions := CreateOptions;
  FSortBySummaryInfo := CreateSortBySummaryInfo;
  FStyles := CreateStyles;
  FGroupValueList := TcxPivotGridVariantList.Create;
end;

procedure TcxPivotGridField.DestroySubClasses;
begin
  FreeAndNil(FGroupValueList);
  FreeAndNil(FStyles);
  FreeAndNil(FCustomTotals);
  FreeAndNil(FFilter);
  FreeAndNil(FViewInfo);
  FreeAndNil(FOptions);
  FreeAndNil(FSortBySummaryInfo);
  FreeAndNil(FExpandingInfo);
  FreeAndNil(FDataBinding);
  DestroyProperties;
end;

procedure TcxPivotGridField.GroupCheckExpanding(
  AGroup: TcxPivotGridGroupItem);
begin
  AGroup.Expanded := IsItemExpanded(AGroup);
end;

procedure TcxPivotGridField.GroupExpandingChanged(
  ASender: TcxPivotGridGroupItem);
begin
  try
    if not PivotGrid.OptionsData.SaveExpanding then Exit;
    if ASender.FExpanded then
      ExpandingInfo.Add(ASender.GetUniqueValue)
    else
      ExpandingInfo.Remove(ASender.GetUniqueValue);
  finally
    if ASender.ChildrenNeeded and (PivotGrid.OLAPDataSource <> nil) then
      PivotGrid.DataBuilder.GroupExpandingChanged(ASender);
  end;
end;

function TcxPivotGridField.GetCaption: string;
begin
  if FIsCaptionAssigned then
    Result := FCaption
  else
    Result := Name;
end;

function TcxPivotGridField.GetDataType: TVarType;
begin
  if DataBinding.ValueTypeClass <> nil then
    Result := DataBinding.ValueTypeClass.GetVarType
  else
    if PivotGrid.IsOLAPActive then
      Result := varString
    else
      Result := varUnknown;
end;

function TcxPivotGridField.GetDisplayTextAssigned: Boolean;
begin
  Result := Assigned(FOnGetDisplayText);
end;

function TcxPivotGridField.IsRecordVisible(ARecordIndex: Integer): Boolean;
begin
  Result := not Filter.HasFilter or Filter.Contains(GetGroupValue(ARecordIndex));
end;

procedure TcxPivotGridField.SetAreaIndexInternal(
  AArea: TcxPivotGridFieldArea; AAreaIndex: Integer);
begin
  FArea := AArea;
  FAreaIndex := AAreaIndex;
end;

procedure TcxPivotGridField.SetExpanding(AValue: Boolean);
begin
  if Visible then
  begin
    PivotGrid.BeginUpdate;
    try
      PivotGrid.ShowHourglassCursor;
      if Area = faRow then
        PivotGrid.DataBuilder.Rows.SetFieldExpanding(Self, AValue)
      else
        if Area = faColumn then
          PivotGrid.DataBuilder.Columns.SetFieldExpanding(Self, AValue);
      PivotGrid.LayoutChanged;
    finally
      PivotGrid.EndUpdate;
      PivotGrid.HideHourglassCursor;
    end;
  end;
end;

procedure TcxPivotGridField.SetParentComponent(Value: TComponent);
begin
  PivotGrid := Value as TcxCustomPivotGrid;
end;

procedure TcxPivotGridField.SetPivotGrid(AValue: TcxCustomPivotGrid);
begin
  if AValue <> FPivotGrid then
  begin
    if FPivotGrid <> nil then
      FPivotGrid.RemoveField(Self);
    FPivotGrid := AValue;
    if FPivotGrid <> nil then
      PivotGrid.AddField(Self);
    PropertiesValueChanged;
  end;
end;

procedure TcxPivotGridField.SynchronizeUniqueName;
begin
  PivotGrid.SynchronizeUniqueName(Self);
end;

// IcxEditRepositoryItemListener

procedure TcxPivotGridField.ItemRemoved(Sender: TcxEditRepositoryItem);
begin
  if Sender = FLastUsedDefaultRepositoryItem then
    PropertiesValueChanged
  else
    RepositoryItem := nil;
end;

procedure TcxPivotGridField.RepositoryItemPropertiesChanged(Sender: TcxEditRepositoryItem);
begin
  PropertiesChanged;
end;

// IcxStoredObject
function TcxPivotGridField.GetObjectName: string;
begin
  Result := Name;
  if Result = '' then
    Result := ClassName + IntToStr(Index);
end;

function TcxPivotGridField.GetProperties(
  AProperties: TStrings): Boolean;
var
  I: Integer;
begin
  for I := Low(FieldDefaultStoredProperties) to High(FieldDefaultStoredProperties) do
    AProperties.Add(FieldDefaultStoredProperties[I]);
  if Assigned(OnGetStoredProperties) then
    OnGetStoredProperties(Self, AProperties);
  Result := True;
end;

procedure TcxPivotGridField.GetPropertyValue(
  const AName: string; var AValue: Variant);

  function GetFilterValue: Variant;
  var
    AStream: TStream;
  begin
    AStream := TMemoryStream.Create;
    try
      Filter.WriteData(AStream);
      Result := StreamToString(AStream);
    finally
      AStream.Free;
    end;
  end;

begin
  case GetPropertyIndex(AName, FieldDefaultStoredProperties) of
    6: AValue := GetFilterValue;
  end;
  if Assigned(OnGetStoredPropertyValue) then
    OnGetStoredPropertyValue(Self, AName, AValue);
end;

procedure TcxPivotGridField.SetPropertyValue(
  const AName: string; const AValue: Variant);

  procedure SetFilterValue;
  var
    AStream: TStream;
  begin
    AStream := TMemoryStream.Create;
    try
      StringToStream(dxVariantToAnsiString(AValue), AStream);
      AStream.Position := 0;
      Filter.ReadData(AStream);
    finally
      AStream.Free;
    end;
  end;

begin
  case GetPropertyIndex(AName, FieldDefaultStoredProperties) of
    6: SetFilterValue;
  end;
  if Assigned(OnSetStoredPropertyValue) then
    OnSetStoredPropertyValue(Self, AName, AValue);
end;

function TcxPivotGridField.GetAllowedAreas: TcxPivotGridFieldAreas;
begin
  Result := FAllowedAreas;
  if FLink <> nil then
    Result := DimensionAllowedAreas[FLink.IsMeasure]
end;

function TcxPivotGridField.GetActualWidth: Integer;
begin
  Result := FWidth;
  if Result = 0 then
    Result := cxPivotGridDefaultFieldWidth;
  Result := Max(MinWidth, Result);
end;

function TcxPivotGridField.GetController: TcxPivotGridController;
begin
  Result := PivotGrid.Controller;
end;

function TcxPivotGridField.GetDataBuilder: TcxPivotGridDataBuilder;
begin
  if PivotGrid <> nil then
    Result := PivotGrid.DataBuilder
  else
    Result := nil;
end;

function TcxPivotGridField.GetGroupExpanded: Boolean;
var
  ANextField: TcxPivotGridField;
begin
  Result := FGroupExpanded;
  if Result and (Group <> nil) then
  begin
    ANextField := Group.GetNextField(Self);
    Result := (ANextField <> nil) and ANextField.Visible;
  end;
end;

function TcxPivotGridField.GetGroupIndex: Integer;
begin
  Result := -1;
  if Group <> nil then
    Result := Group.Index;
end;

function TcxPivotGridField.GetGroupValueList: TcxPivotGridVariantList;
begin
  InitGroupValues;
  Result := FGroupValueList;
end;

function TcxPivotGridField.GetHeaderWidth: Integer;
begin
  Result := ViewInfo.MeasureWidth;
end;

function TcxPivotGridField.GetHidden: Boolean;
begin
  Result := FHidden or (PivotGrid.IsOLAPActive and (FLink = nil));
end;

function TcxPivotGridField.GetIndex: Integer;
begin
  Result := PivotGrid.FieldList.IndexOf(Self)
end;

function TcxPivotGridField.GetIsDestroying: Boolean;
begin
  Result := csDestroying in ComponentState;
end;

function TcxPivotGridField.GetIsHierarchy: Boolean;
begin
  Result := (Group <> nil) and (Group.FieldCount > 1);
end;

function TcxPivotGridField.GetMinWidth: Integer;
begin
  Result := FMinWidth;
end;

function TcxPivotGridField.GetPropertiesClassName: string;
begin
  if FProperties = nil then
    Result := ''
  else
    Result := FProperties.ClassName;
end;

function TcxPivotGridField.GetRecordCount: Integer;
begin
  Result := PivotGrid.RecordCount;
end;

function TcxPivotGridField.GetSortedBySummary: Boolean;
begin
  Result := SortBySummaryInfo.ValidateProperties;
end;

function TcxPivotGridField.GetUniqueName: WideString;
begin
  Result := FUniqueName;
  if (Result = '') and Assigned(FLink) then
    Result := FLink.UniqueName;
end;

function TcxPivotGridField.GetValueByRecordIndex(ARecordIndex: Integer): Variant;
begin
  ARecordIndex := PivotGrid.DataController.GetRowInfo(ARecordIndex).RecordIndex;
  if (Area <> faData) and (Properties <> nil) and (Properties.GetEditValueSource(False) = evsText) then
    Result := PivotGrid.DataController.DisplayTexts[ARecordIndex, Index]
  else
    Result := PivotGrid.DataController.Values[ARecordIndex, Index];
end;

function TcxPivotGridField.GetVisible: Boolean;
begin
  Result := FVisible and not Hidden;
end;

function TcxPivotGridField.GetVisibleInGroup: Boolean;
begin
  Result := Visible and ((Group = nil) or (Group.IsFieldVisible(Self)));
end;

function TcxPivotGridField.IsFirstFieldInGroup: Boolean;
begin
  Result := (Group <> nil) and (Group.Fields[0] = Self);
end;

procedure TcxPivotGridField.SetArea(AValue: TcxPivotGridFieldArea);
begin
  if not (AValue in AllowedAreas) then
    AValue := FArea;
  if CanModifyArea and (FArea <> AValue) then
  begin
    FArea := AValue;
    AreaIndex := MaxInt;
    if PivotGrid.IsRestoring and IsFirstFieldInGroup then
      Group.InternalSetArea(FArea);
    DataChanged;
  end;
end;

procedure TcxPivotGridField.SetAreaIndex(AValue: Integer);
begin
  AValue := Max(-1, AValue);
  if (PivotGrid <> nil) and CanModifyArea then
  begin
    if (Group <> nil) and (AValue > ViewInfo.AreaIndex) then
      Dec(AValue, Max(0, Group.VisibleCount - 1));
    if not PivotGrid.SetFieldAreaIndex(Self, Area, AValue) then
      FAreaIndex := AValue;
    // clear expanding information because field position changed
    ExpandingInfo.Clear;
    if not PivotGrid.IsLocked then
      PivotGrid.DoFieldPosChanged(Self);
    DataChanged;
  end;
end;

procedure TcxPivotGridField.SetCaption(const AValue: string);
begin
  if AValue <> Caption then
  begin
    FCaption := AValue;
    FIsCaptionAssigned := True;
    Changed;
  end;
end;

procedure TcxPivotGridField.SetCustomTotals(
  AValue: TcxPivotGridCustomTotalCollection);
begin
  FCustomTotals.Assign(AValue);
end;

procedure TcxPivotGridField.SetDataBinding(AValue: TcxPivotGridFieldDataBinding);
begin
  FDataBinding.Assign(AValue);
end;

procedure TcxPivotGridField.SetDataVisibility(AValue: TcxPivotGridFieldDataVisibility);
begin
  if AValue <> FDataVisibility then
  begin
    FDataVisibility := AValue;
    Changed;
  end;
end;

procedure TcxPivotGridField.SetDisplayFormat(const AValue: string);
begin
  if FDisplayFormat <> AValue then
  begin
    FDisplayFormat := AValue;
    Changed;
  end;
end;

procedure TcxPivotGridField.SetGroup(AValue: TcxPivotGridFieldGroup);
begin
  if (Group = AValue) or (csDestroying in ComponentState) then Exit;
  PivotGrid.BeginUpdate;
  try
    if Group <> nil then
      Group.Remove(Self);
    FGroup := AValue;
    if Group <> nil then
      Group.Add(Self);
    Changed;
  finally
    PivotGrid.EndUpdate;
  end;
end;

procedure TcxPivotGridField.SetGroupExpanded(AValue: Boolean);
begin
  if FGroupExpanded <> AValue then
  begin
    FGroupExpanded := AValue;
    DataChanged;
  end;
end;

procedure TcxPivotGridField.SetGroupIndex(AValue: Integer);
begin
  AValue := Min(Max(-1, AValue), PivotGrid.Groups.Count - 1);
  if AValue < 0 then
    SetGroup(nil)
  else
    SetGroup(PivotGrid.Groups[AValue]);
end;

procedure TcxPivotGridField.SetGroupInterval(
  AValue: TcxPivotGridGroupInterval);
begin
  if FGroupInterval <> AValue then
  begin
    FGroupInterval := AValue;
    DataChanged;
  end;
end;

procedure TcxPivotGridField.SetGroupIntervalRange(AValue: Integer);
begin
  AValue := Max(1, AValue);
  if AValue <> FGroupIntervalRange then
  begin
    FGroupIntervalRange := AValue;
    DataChanged;
  end;
end;

procedure TcxPivotGridField.SetHidden(AValue: Boolean);
begin
  if AValue <> FHidden then
  begin
    FHidden := AValue;
    Changed;
  end;
end;

procedure TcxPivotGridField.SetImageAlign(AValue: TAlignment);
begin
  if FImageAlign <> AValue then
  begin
    FImageAlign := AValue;
    Changed;
  end;
end;

procedure TcxPivotGridField.SetImageIndex(AValue: TImageIndex);
begin
  if FImageIndex <> AValue then
  begin
    FImageIndex := AValue;
    Changed;
  end;
end;

procedure TcxPivotGridField.SetIndex(AValue: Integer);

  function ValidateIndex(AValue, AMin, AMax: Integer): Integer;
  begin
    Result := AValue;
    if AValue < AMin then
      Result := AMin
    else
      if AValue > AMax then
        Result := AMax;
  end;

begin
  if (Index <> AValue) and (PivotGrid <> nil) then
  begin
    with PivotGrid.FieldList do
      Exchange(ValidateIndex(Index, 0, Count - 1), ValidateIndex(AValue, 0, Count - 1));
    PivotGrid.DataController.UpdateItemIndexes;
  end;
end;

procedure TcxPivotGridField.SetMinWidth(AValue: Integer);
begin
  AValue := Max(0, AValue);
  if FMinWidth <> AValue then
  begin
    FMinWidth := AValue;
    Width := Width;
    Changed;
  end;
end;

procedure TcxPivotGridField.SetOnGetProperties(AValue: TcxPivotGridGetPropertiesEvent);
begin
  if @FOnGetProperties <> @AValue then
  begin
    FOnGetProperties := AValue;
    Changed;
  end;
end;

procedure TcxPivotGridField.SetOptions(AValue: TcxPivotGridFieldOptions);
begin
  FOptions.Assign(AValue);
end;

procedure TcxPivotGridField.SetProperties(Value: TcxCustomEditProperties);
begin
  if (FProperties <> nil) and (Value <> nil) then FProperties.Assign(Value);
end;

procedure TcxPivotGridField.SetPropertiesClass(Value: TcxCustomEditPropertiesClass);
begin
  if FPropertiesClass <> Value then
  begin
    FPropertiesClass := Value;
    RecreateProperties;
    PropertiesValueChanged;
    PropertiesChanged;
  end;
end;

procedure TcxPivotGridField.SetPropertiesClassName(const Value: string);
begin
  PropertiesClass := TcxCustomEditPropertiesClass(GetRegisteredEditProperties.FindByClassName(Value));
end;

procedure TcxPivotGridField.SetRepositoryItem(Value: TcxEditRepositoryItem);
begin
  if FRepositoryItem <> Value then
  begin
    if FRepositoryItem <> nil then
      FRepositoryItem.RemoveListener(Self);
    FRepositoryItem := Value;
    if FRepositoryItem <> nil then
      FRepositoryItem.AddListener(Self);
    PropertiesValueChanged;
    PropertiesChanged;
  end;
end;

procedure TcxPivotGridField.SetSortOrder(AValue: TcxDataSortOrder);
begin
  if FSortOrder <> AValue then
  begin
    FSortOrder := AValue;
    DataChanged;
  end;
end;

procedure TcxPivotGridField.SetSortBySummaryInfo(
  AValue: TcxPivotGridSortBySummaryInfo);
begin
  FSortBySummaryInfo.Assign(AValue);
  DataChanged;
end;

procedure TcxPivotGridField.SetStyles(AValue: TcxPivotGridFieldStyles);
begin
  FStyles.Assign(AValue);
end;

procedure TcxPivotGridField.SetSummaryType(AValue: TcxPivotGridSummaryType);
begin
  if FSummaryType <> AValue then
  begin
    FSummaryType := AValue;
    DataChanged;
  end;
end;

procedure TcxPivotGridField.SetSummaryVariation(AValue: TcxPivotGridSummaryVariation);
begin
  if SummaryVariation <> AValue then
  begin
    FSummaryVariation := AValue;
    DataChanged;
  end;
end;

procedure TcxPivotGridField.SetTotalsVisibility(
  AValue: TcxPivotGridTotalsVisibility);
begin
  if AValue <> FTotalsVisibility then
  begin
    FTotalsVisibility := AValue;
    DataChanged;
  end;
end;

procedure TcxPivotGridField.SetTopValueCount(AValue: Integer);
begin
  if AValue <> FTopValueCount then
  begin
    FTopValueCount := AValue;
    DataChanged;
  end;
end;

procedure TcxPivotGridField.SetTopValueShowOthers(AValue: Boolean);
begin
  if AValue <> FTopValueShowOthers then
  begin
    FTopValueShowOthers := AValue;
    DataChanged;
  end;
end;

procedure TcxPivotGridField.SetUniqueName(const AValue: WideString);
begin
  if FUniqueName <> AValue then
  begin
    FUniqueName := AValue;
    SynchronizeUniqueName;
  end;
end;

procedure TcxPivotGridField.SetValueByRecordIndex(
  ARecordIndex: Integer; const AValue: Variant);
begin
  PivotGrid.DataController.Values[PivotGrid.DataController.GetRowInfo(ARecordIndex).RecordIndex, Index] := AValue;
end;

procedure TcxPivotGridField.SetVisible(AValue: Boolean);
begin
  if AValue <> FVisible then
  begin
    FVisible := AValue;
    if FAreaIndex = -1 then
      AreaIndex := MaxInt;
    FViewInfo.FBackground := nil;
    DataChanged;
  end;
end;

procedure TcxPivotGridField.SetWidth(AValue: Integer);
begin
  if AValue <> 0 then
    AValue := Max(MinWidth, AValue);
  if AValue <> FWidth then
  begin
    FWidth := AValue;
    Changed(True);
    if PivotGrid <> nil then
      PivotGrid.DoFieldSizeChanged(Self);
  end;
end;

procedure TcxPivotGridField.FilterChanged(Sender: TObject);
begin
  DoFilterChanged;
end;

procedure TcxPivotGridField.InternalDoGetDisplayText(ACell: TcxPivotGridDataCellViewInfo; var AText: string);
begin
  if GetDisplayTextAssigned then
    FOnGetDisplayText(Self, ACell, AText);
end;

function TcxPivotGridField.IsAllowedAreasStored: Boolean;
begin
  Result := FAllowedAreas <> [faColumn..faData];
  if FLink <> nil then
    Result := FAllowedAreas <> DimensionAllowedAreas[FLink.IsMeasure];
end;

function TcxPivotGridField.IsCustomTotalStored: Boolean;
begin
  Result := CustomTotals.Count > 0;
end;

procedure TcxPivotGridField.ChangeExpanding;
begin
  GroupExpanded := not GroupExpanded;
end;

procedure TcxPivotGridField.ChangeSorting;
const
  InvertedSortOrders: array[TcxDataSortOrder] of TcxDataSortOrder =
    (soDescending, soDescending, soAscending);
begin
  if (ViewInfo.State = cxbsPressed) then
  begin
    if not PivotGrid.IsDesigning and Options.CanSorting then
    begin
      PivotGrid.ShowHourglassCursor;
      try
        SortOrder := InvertedSortOrders[SortOrder];
      finally
        PivotGrid.HideHourglassCursor;
      end
    end
    else
      SetState(cxbsNormal);
  end;
end;

function TcxPivotGridField.GetViewInfo: TcxPivotGridFieldHeaderCellViewInfo;
begin
  Result := ViewInfo;
end;

procedure TcxPivotGridField.SetState(AState: TcxButtonState);
begin
  ViewInfo.State := AState;
  PivotGrid.InvalidateRect(ViewInfo.Bounds, False);
end;

procedure TcxPivotGridField.CreateProperties;
begin
  if FPropertiesClass <> nil then
  begin
    FProperties := FPropertiesClass.Create(Self);
    FProperties.OnPropertiesChanged := PropertiesChangedHandler;
  end;
end;

procedure TcxPivotGridField.DestroyProperties;
begin
  FreeAndNil(FProperties);
end;

procedure TcxPivotGridField.RecreateProperties;
begin
  DestroyProperties;
  CreateProperties;
end;

{ TcxPivotGridFieldGroup }

constructor TcxPivotGridFieldGroup.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FieldList := TcxList.Create;
end;

destructor TcxPivotGridFieldGroup.Destroy;
begin
  if not IsDestroying then Clear;
  FreeAndNil(FieldList);
  inherited Destroy;
end;

procedure TcxPivotGridFieldGroup.Add(AField: TcxPivotGridField);
begin
  if FieldList.IndexOf(AField) <> cxPivotGridInvalidIndex then Exit;
  PivotGrid.BeginUpdate;
  try
    FieldList.Add(AField);
    AField.Group := Self;
    AField.FArea := Area;
    if not PivotGrid.IsLoading then
      AreaIndex := Max(0, AreaIndex);
    GroupChanged;
  finally
    PivotGrid.EndUpdate;
  end;
end;

procedure TcxPivotGridFieldGroup.AddFields(AFields: array of TcxPivotGridField);
var
  I: Integer;
begin
  PivotGrid.BeginUpdate;
  try
    for I := Low(AFields) to High(AFields) do Add(AFields[I]);
  finally
    PivotGrid.EndUpdate;
  end;
end;

procedure TcxPivotGridFieldGroup.Clear;
begin
  PivotGrid.BeginUpdate;
  try
    while FieldCount > 0 do
      Remove(Fields[FieldCount - 1]);
  finally
    PivotGrid.EndUpdate;
  end;
end;

procedure TcxPivotGridFieldGroup.FullCollapse;
begin
  SetExpanded(False)
end;

procedure TcxPivotGridFieldGroup.FullExpand;
begin
  SetExpanded(True)
end;

function TcxPivotGridFieldGroup.IndexOf(AField: TcxPivotGridField): Integer;
begin
  Result := FieldList.IndexOf(AField);
end;

procedure TcxPivotGridFieldGroup.Insert(
  AIndex: Integer; AField: TcxPivotGridField);
begin
  PivotGrid.BeginUpdate;
  try
    AField.Group := nil;
    if AIndex >= FieldList.Count then
      FieldList.Add(AField)
    else
    begin
      if (AIndex = 0) and (FieldCount > 0) then
      begin
        AField.FArea := Area;
        AField.FAreaIndex := AreaIndex;
      end;
      FieldList.Insert(AIndex, AField);
    end;
    AField.Group := Self;
    AField.FArea := Area;
    AreaIndex := Max(0, AreaIndex);
    GroupChanged;
  finally
    PivotGrid.EndUpdate;
  end;
end;

function TcxPivotGridFieldGroup.IsFieldVisible(
  AField: TcxPivotGridField): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to FieldCount - 1 do
  begin
    Result := Result and Fields[I].Visible;
    if not Result or (AField = Fields[I]) then Break;
    Result := Result and Fields[I].GroupExpanded;
  end;
end;

function TcxPivotGridFieldGroup.IsLastVisibleField(
  AField: TcxPivotGridField): Boolean;
var
  AIndex: Integer;
begin
  Result := True;
  AIndex := FieldList.IndexOf(AField);
  if AIndex = -1 then Exit;
  Inc(AIndex);
  while Result and (AIndex < FieldCount) do
  begin
    Result := not Fields[AIndex].Visible;
    Inc(AIndex);
  end;
end;

procedure TcxPivotGridFieldGroup.Remove(AField: TcxPivotGridField);
var
  I, AIndex: Integer;
begin
  AIndex := FieldList.Remove(AField);
  if AIndex <> cxPivotGridInvalidIndex then
  begin
    PivotGrid.BeginUpdate;
    try
      AField.FGroup := nil;
      if (AIndex > 0) and (AIndex < FieldCount) then
      begin
        AField.AreaIndex := GetLatestIndex;
        for I := AIndex to FieldCount - 1 do
          Fields[I].AreaIndex := AreaIndex + I;
      end;
      GroupChanged;
    finally
      PivotGrid.EndUpdate;
    end;
  end;
end;

function TcxPivotGridFieldGroup.CanDropTo(
  AArea: TcxPivotGridFieldArea; AIndex: Integer): Boolean;
begin
  Result := True;
end;

function TcxPivotGridFieldGroup.GetLatestIndex: Integer;
begin
  Result := AreaIndex + FieldCount - 1;
end;

function TcxPivotGridFieldGroup.GetNextField(
  AField: TcxPivotGridField): TcxPivotGridField;
var
  AIndex: Integer;
begin
  Result := nil;
  AIndex := FieldList.IndexOf(AField) + 1;
  if AIndex < FieldCount then
    Result := Fields[AIndex];
end;

procedure TcxPivotGridFieldGroup.GroupChanged;
begin
  Changed(True);
  PivotGrid.DataChanged;
end;

procedure TcxPivotGridFieldGroup.InternalSetArea(AArea: TcxPivotGridFieldArea);
var
  I: Integer;
begin
  for I := 0 to FieldCount - 1 do
    Fields[I].FArea := AArea;
end;

function TcxPivotGridFieldGroup.IsSameDropPlace(AIndex: Integer): Boolean;
begin
  Dec(AIndex, Fields[0].ViewInfo.AreaIndex);
  Result := (AIndex >= 0) and (AIndex <= VisibleCount);
end;

procedure TcxPivotGridFieldGroup.ResetIndexes(var ANewIndex: Integer);
var
  I: Integer;
begin
  for I := 0 to FieldCount - 1 do
    Fields[I].SetAreaIndexInternal(Area, ANewIndex + I);
  Inc(ANewIndex, FieldCount - 1);
end;

procedure TcxPivotGridFieldGroup.SetExpanded(AExpanded: Boolean);
var
  I: Integer;
begin
  PivotGrid.BeginUpdate;
  try
    for I := 0 to FieldCount - 1 do
      Fields[I].GroupExpanded := AExpanded;
  finally
    PivotGrid.EndUpdate;
  end;
end;

function TcxPivotGridFieldGroup.GetArea: TcxPivotGridFieldArea;
begin
  if FieldCount > 0 then
    Result := Fields[0].Area
  else
    Result := faFilter;
end;

function TcxPivotGridFieldGroup.GetAreaIndex: Integer;
begin
  if FieldCount > 0 then
    Result := Fields[0].AreaIndex
  else
    Result := -1;
end;

function TcxPivotGridFieldGroup.GetCaption: string;
var
  I: Integer;
begin
  if FIsCaptionAssigned then
    Result := FCaption
  else
  begin
    Result := '';
    for I := 0 to FieldCount - 1 do
      if (I = 0) or Fields[I].Visible then
        Result := Result + '-' + Fields[I].Caption;
    Delete(Result, 1, 1);
  end;
end;

function TcxPivotGridFieldGroup.GetField(AIndex: Integer): TcxPivotGridField;
begin
  Result := TcxPivotGridField(FieldList[AIndex]);
end;

function TcxPivotGridFieldGroup.GetFieldCount: Integer;
begin
  Result := FieldList.Count;
end;

function TcxPivotGridFieldGroup.GetIsDestroying: Boolean;
begin
  Result := (Groups = nil) or (PivotGrid = nil) or PivotGrid.IsDestroying;
end;

function TcxPivotGridFieldGroup.GetPivotGrid: TcxCustomPivotGrid;
begin
  Result := Groups.PivotGrid
end;

function TcxPivotGridFieldGroup.GetVisible: Boolean;
begin
  Result := (FieldCount > 0) and Fields[0].Visible;
end;

function TcxPivotGridFieldGroup.GetVisibleCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to FieldCount - 1 do
  begin
    if Fields[I].VisibleInGroup then
      Inc(Result)
    else
      Break;
  end;
end;

function TcxPivotGridFieldGroup.GetGroups: TcxPivotGridFieldGroupCollection;
begin
  Result := TcxPivotGridFieldGroupCollection(Collection);
end;

procedure TcxPivotGridFieldGroup.SetArea(AValue: TcxPivotGridFieldArea);
begin
  if (FieldCount > 0) and (Area <> AValue) then
    Fields[0].Area := AValue;
end;

procedure TcxPivotGridFieldGroup.SetAreaIndex(AValue: Integer);
begin
  if FieldCount > 0 then
    Fields[0].AreaIndex := AValue;
end;

procedure TcxPivotGridFieldGroup.SetCaption(const AValue: string);
begin
  if FCaption <> AValue then
  begin
    FCaption := AValue;
    FIsCaptionAssigned := True;
    GroupChanged;
  end;
end;

procedure TcxPivotGridFieldGroup.SetVisible(AValue: Boolean);
begin
  if (Visible <> AValue) and (FieldCount > 0) then
  begin
    Fields[0].Visible := AValue;
    GroupChanged;
  end;
end;

{ TcxPivotGridFieldGroupCollection }

constructor TcxPivotGridFieldGroupCollection.Create(AOwner: TcxCustomPivotGrid);
begin
  inherited Create(TcxPivotGridFieldGroup);
  FOwner := AOwner;
end;

function TcxPivotGridFieldGroupCollection.Add: TcxPivotGridFieldGroup;
begin
  Result := inherited Add as TcxPivotGridFieldGroup;
end;

function TcxPivotGridFieldGroupCollection.CanDropTo(
  AArea: TcxPivotGridFieldArea; AIndex: Integer): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to Count - 1 do
    Result := Result and Items[I].CanDropTo(AArea, AIndex);
end;

function TcxPivotGridFieldGroupCollection.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TcxPivotGridFieldGroupCollection.Loaded;
var
  AIndex, I: Integer;
begin
  // sort and reindex after loaded
  for I := 0 to Count - 1 do
    with Items[I] do
    begin
      FieldList.Sort(@CompareFieldsOnLoading);
      AIndex := AreaIndex;
      ResetIndexes(AIndex);
    end;
end;

procedure TcxPivotGridFieldGroupCollection.Update(Item: TCollectionItem);
begin
  inherited Update(Item);
  if PivotGrid <> nil then
    PivotGrid.DataChanged;
end;

function TcxPivotGridFieldGroupCollection.GetItem(
  AIndex: Integer): TcxPivotGridFieldGroup;
begin
  Result := inherited Items[AIndex] as TcxPivotGridFieldGroup;
end;

procedure TcxPivotGridFieldGroupCollection.SetItem(
  AIndex: Integer; AValue: TcxPivotGridFieldGroup);
begin
  inherited Items[AIndex] := AValue;
end;

constructor TcxPivotGridCustomPopupMenu.Create(AOwner: TcxPivotGridPopupMenus);
begin
  FOwner := AOwner;
  FUseBuiltInMenu := True;
end;

destructor TcxPivotGridCustomPopupMenu.Destroy;
begin
  PopupMenu := nil;
  FreeAndNil(FBuiltInMenu);
  inherited Destroy;
end;

procedure TcxPivotGridCustomPopupMenu.Assign(Source: TPersistent);
begin
  if Source is TcxPivotGridCustomPopupMenu then
  begin
    UseBuiltInMenu := TcxPivotGridCustomPopupMenu(Source).FUseBuiltInMenu;
    PopupMenu := TcxPivotGridCustomPopupMenu(Source).PopupMenu;
    AssignValues(TcxPivotGridCustomPopupMenu(Source));
  end;
end;

procedure TcxPivotGridCustomPopupMenu.ExecuteCommand(ACommand: Integer);
begin
  ExecuteItem(GetItemByCommand(ACommand))
end;

function TcxPivotGridCustomPopupMenu.Popup(X, Y: Integer): Boolean;
begin
  CreateInternalMenu;
  Owner.DoOnPopup(Self, Result);
  if not Result then
  begin
    if UseBuiltInMenu then
      Result := ShowPopupMenu(PivotGrid, FBuiltInMenu, X, Y)
    else
      Result := ShowPopupMenu(PivotGrid, FPopupMenu, X, Y);
  end;
end;

procedure TcxPivotGridCustomPopupMenu.AssignValues(
  ASource: TcxPivotGridCustomPopupMenu);
begin

end;

procedure TcxPivotGridCustomPopupMenu.CreateInternalMenu;
begin
  FreeAndNil(FBuiltInMenu);
  FBuiltInMenu := TPopupMenu.Create(nil);
  FBuiltInMenu.Images := cxPivotGridPopupMenuImages;
  CreateItems;
end;

procedure TcxPivotGridCustomPopupMenu.CreateItems;
begin
end;

function TcxPivotGridCustomPopupMenu.CreateSeparator(AOwner: TMenuItem): TMenuItem;
begin
  Result := CreateSubItem(AOwner, '-', -1);
end;

function TcxPivotGridCustomPopupMenu.CreateSubItem(AOwner: TMenuItem;
  const ACaption: string; ACommand: Integer; AEnabled: Boolean): TMenuItem;
begin
  Result := TMenuItem.Create(nil);
  Result.Caption := ACaption;
  Result.Enabled := AEnabled;
  Result.Tag := ACommand;
  Result.OnClick := MenuItemClickHandler;
  AOwner.Add(Result);
end;

procedure TcxPivotGridCustomPopupMenu.DoExecute(ACommand: Integer);
begin
  if (ACommand = pgcmShowCustomization) or (ACommand = pgcmHideCustomization) then
    PivotGrid.Customization.Visible := ACommand = pgcmShowCustomization;
end;

procedure TcxPivotGridCustomPopupMenu.ExecuteItem(AItem: TMenuItem);
var
  AHandled: Boolean;
begin
  if AItem = nil then Exit;
  Owner.DoOnClick(AItem, AHandled);
  if not AHandled then
    DoExecute(AItem.Tag);
end;

function TcxPivotGridCustomPopupMenu.GetItemByCommand(ACommand: Integer): TMenuItem;

  function CheckItem(AItem: TMenuItem): TMenuItem;
  var
    I: Integer;
  begin
    Result := nil;
    if AItem.Tag = ACommand then
    begin
      Result := AItem;
      Exit;
    end;
    for I := 0 to AItem.Count - 1 do
    begin
      Result := CheckItem(AItem.Items[I]);
      if Result <> nil then Break;
    end;
  end;

begin
  Result := CheckItem(BuiltInMenu.Items);
end;

function TcxPivotGridCustomPopupMenu.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TcxPivotGridCustomPopupMenu.MenuItemClickHandler(Sender: TObject);
begin
  ExecuteItem(TMenuItem(Sender));
end;

procedure TcxPivotGridCustomPopupMenu.Notification(
  AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = PopupMenu) then
    PopupMenu := nil;
end;

function TcxPivotGridCustomPopupMenu.GetPivotGrid: TcxCustomPivotGrid;
begin
  Result := Owner.PivotGrid;
end;

function TcxPivotGridCustomPopupMenu.GetRoot: TMenuItem;
begin
  Result := FBuiltInMenu.Items;
end;

procedure TcxPivotGridCustomPopupMenu.SetPopupMenu(AValue: TComponent);
begin
  if PopupMenu <> AValue then
  begin
    if PopupMenu <> nil then
      PopupMenu.RemoveFreeNotification(PivotGrid);
    FPopupMenu := AValue;
    if PopupMenu <> nil then
      PopupMenu.FreeNotification(PivotGrid);
  end;
end;

{ TcxPivotGridFieldHeaderMenu }

constructor TcxPivotGridFieldHeaderMenu.Create(AOwner: TcxPivotGridPopupMenus);
begin
  inherited Create(AOwner);
  Items := [fpmiHide, fpmiOrder, fpmiFieldList];
end;

procedure TcxPivotGridFieldHeaderMenu.AssignValues(
  ASource: TcxPivotGridCustomPopupMenu);
begin
  inherited AssignValues(ASource);
  Items := TcxPivotGridFieldHeaderMenu(ASource).Items;
end;

procedure TcxPivotGridFieldHeaderMenu.CreateItems;
var
  AItem: TMenuItem;
  AFirst, APrev, ANext, ALast, AIndex: Integer;
begin
  inherited CreateItems;
  if fpmiHide in Items then
  begin
    CreateSubItem(Root, cxGetResourceString(@scxHide), pgcmHide,
      (Field <> nil) and PivotGrid.OptionsCustomize.Hiding);
    CreateSeparator(Root);
  end;
  // order
  if (fpmiOrder in Items) and ((Field = nil) or (Field.GroupIndex <= 0)) then
  begin
    AItem := CreateSubItem(Root, cxGetResourceString(@scxOrder), -1);
    AIndex := FieldViewInfo.AreaIndex;
    GetIndexes(AFirst, APrev, ANext, ALast);
    CreateSubItem(AItem, cxGetResourceString(@scxMoveToBeginning),
      pgcmMoveToBeginning, (AFirst < AIndex) and PivotGrid.OptionsCustomize.Moving);
    CreateSubItem(AItem, cxGetResourceString(@scxMoveToEnd),
      pgcmMoveToEnd, (ALast > AIndex) and PivotGrid.OptionsCustomize.Moving);
    CreateSubItem(AItem, cxGetResourceString(@scxMoveToLeft),
      pgcmMoveToLeft, (AFirst < AIndex) and PivotGrid.OptionsCustomize.Moving);
    CreateSubItem(AItem, cxGetResourceString(@scxMoveToRight),
      pgcmMoveToRight, (ALast > AIndex) and PivotGrid.OptionsCustomize.Moving);
  end;
  // field list
  if fpmiFieldList in Items then
  begin
    CreateSeparator(Root);
    with PivotGrid.Customization do
    begin
      CreateSubItem(Root, cxGetResourceString(scxCustomization[Visible]),
        CustomizationCommand[Visible], PivotGrid.OptionsCustomize.QuickCustomization);
    end;
  end;
end;

procedure TcxPivotGridFieldHeaderMenu.DoExecute(ACommand: Integer);
var
  AIndexes: array[0..3] of Integer;
begin
  case ACommand of
    pgcmHide:
      if Field.Group <> nil then
        Field.Group.Visible := False
      else
        Field.Visible := False;
    pgcmMoveToBeginning..pgcmMoveToRight:
    begin
      GetIndexes(AIndexes[0], AIndexes[2], AIndexes[3], AIndexes[1]);
      if Field <> nil then
        Field.AreaIndex := AIndexes[ACommand - pgcmMoveToBeginning]
      else
        OptionsDataField.AreaIndex := AIndexes[ACommand - pgcmMoveToBeginning];
    end;
  else
    inherited DoExecute(ACommand);
  end;
end;

procedure TcxPivotGridFieldHeaderMenu.GetIndexes(
  var AStart, APrev, ANext, AFinish: Integer);

  function GetCell(AIndex: Integer): TcxPivotGridFieldHeaderCellViewInfo;
  begin
    Result := TcxPivotGridFieldHeaderCellViewInfo(FieldHeaders[AIndex]);
  end;

  function SetPosValue(var APos: Integer; const AValue, ADefValue: Integer): Integer;
  begin
    Result := AValue;
    if APos = ADefValue then
      APos := AValue;
  end;

  procedure IncIndex(var AIndex: Integer; AInc: Integer);
  begin
    Inc(AIndex, AInc);
    if (AIndex > 0) and (AIndex < FieldHeaders.Count) and  (GetCell(AIndex).Group <> nil) then
      Inc(AIndex, AInc * (GetCell(AIndex).Group.VisibleCount - 1));
  end;

var
  AIndex, AAreaIndex, ACurIndex: Integer;
begin
  AAreaIndex := FieldViewInfo.AreaIndex;
  APrev := AAreaIndex;
  ANext := AAreaIndex;
  AIndex := FieldHeaders.IndexOf(FieldViewInfo);
  ACurIndex := AIndex;
  while (ACurIndex >= 0) and (GetCell(ACurIndex).Area = FieldViewInfo.Area) do
  begin
    AStart := SetPosValue(APrev, GetCell(ACurIndex).AreaIndex, AAreaIndex);
    IncIndex(ACurIndex, -1);
  end;
  ACurIndex := AIndex;
  while (ACurIndex < FieldHeaders.Count) and (GetCell(ACurIndex).Area = FieldViewInfo.Area) do
  begin
    AFinish := SetPosValue(ANext, GetCell(ACurIndex).AreaIndex, AAreaIndex);
    IncIndex(ACurIndex, 1);
  end;
end;

function TcxPivotGridFieldHeaderMenu.GetFieldHeaders: TcxPivotGridCells;
begin
  Result := PivotGrid.ViewInfo.FieldHeaders;
end;

function TcxPivotGridFieldHeaderMenu.GetFieldViewInfo: TcxPivotGridFieldHeaderCellViewInfo;
begin
  if Field <> nil then
    Result := Field.ViewInfo
  else
    Result := PivotGrid.OptionsDataField.ViewInfo;
end;

function TcxPivotGridFieldHeaderMenu.GetOptionsDataField: TcxPivotGridOptionsDataField;
begin
  Result := PivotGrid.OptionsDataField;
end;

function TcxPivotGridFieldHeaderMenu.IsItemsStored: Boolean;
begin
  Result := Items <> [fpmiHide, fpmiOrder, fpmiFieldList];
end;

{ TcxPivotGridGroupValueMenu }

constructor TcxPivotGridGroupValueMenu.Create(AOwner: TcxPivotGridPopupMenus);
begin
  inherited Create(AOwner);
  FItems := [vpmiExpandCollapse..vpmiCollapseAll];
end;

procedure TcxPivotGridGroupValueMenu.AssignValues(
  ASource: TcxPivotGridCustomPopupMenu);
begin
  if ASource is TcxPivotGridGroupValueMenu then
    Items := TcxPivotGridGroupValueMenu(ASource).Items;
  inherited AssignValues(ASource);
end;

procedure TcxPivotGridGroupValueMenu.CreateItems;
const
  ExpandCollapse: array[Boolean] of Integer =
    (pgcmExpand, pgcmCollapse);
begin
  inherited CreateItems;
  if vpmiExpandCollapse in Items then
  begin
    CreateSubItem(Root, cxGetResourceString(
      scxExpandCollapse[GroupItem.Expanded]), ExpandCollapse[GroupItem.Expanded]);
    CreateSeparator(Root);
  end;
  if vpmiExpandAll in Items then
    CreateSubItem(Root, cxGetResourceString(@scxExpandAll), pgcmExpandAll);

  if vpmiCollapseAll in Items then
    CreateSubItem(Root, cxGetResourceString(@scxCollapseAll), pgcmCollapseAll);
end;

procedure TcxPivotGridGroupValueMenu.DoExecute(ACommand: Integer);
var
  AItem: TcxPivotGridGroupItem;
begin
  inherited DoExecute(ACommand);
  case ACommand of
    pgcmExpand, pgcmCollapse:
      GroupItem.Expanded := not GroupItem.Expanded;
    pgcmExpandAll, pgcmCollapseAll:
    begin
      AItem := GroupItem;
      while AItem.Parent <> nil do
        AItem := AItem.Parent;
      AItem.SetFieldExpanding(GroupItem.Field, ACommand = pgcmExpandAll);
    end;
  else
    Exit;
  end;
  PivotGrid.LayoutChanged;
end;

function TcxPivotGridGroupValueMenu.IsItemsStored: Boolean;
begin
  Result := Items <> [vpmiExpandCollapse..vpmiCollapseAll];
end;

{ TcxPivotGridHeaderAreaMenu }

procedure TcxPivotGridHeaderAreaMenu.CreateItems;
begin
  inherited CreateItems;
  CreateSeparator(Root);
  with PivotGrid.Customization do
    CreateSubItem(Root, cxGetResourceString(scxCustomization[Visible]),
      CustomizationCommand[Visible], PivotGrid.OptionsCustomize.QuickCustomization);
  if PivotGrid.IsPrefilterEnabled then
    CreateSubItem(Root, cxGetResourceString(@scxShowPrefilterDialog),
      pgcmShowPrefilterDialog, PivotGrid.OptionsCustomize.QuickPrefiltering);
end;

procedure TcxPivotGridHeaderAreaMenu.DoExecute(ACommand: Integer);
begin
  case ACommand of
    pgcmShowPrefilterDialog:
      PivotGrid.ShowPrefilterDialog;
  else
    inherited DoExecute(ACommand);
  end;
end;

{ TcxPivotGridPopupMenus }

constructor TcxPivotGridPopupMenus.Create(AOwner: TcxCustomPivotGrid);
begin
  inherited Create(AOwner);
  CreateMenus;
end;

destructor TcxPivotGridPopupMenus.Destroy;
begin
  DestroyMenus;
  inherited Destroy;
end;

procedure TcxPivotGridPopupMenus.Assign(Source: TPersistent);
begin
  if Source is TcxPivotGridPopupMenus then
  begin
    FieldHeaderMenu := TcxPivotGridPopupMenus(Source).FieldHeaderMenu;
    GroupValueMenu := TcxPivotGridPopupMenus(Source).GroupValueMenu;
    HeaderAreaMenu := TcxPivotGridPopupMenus(Source).HeaderAreaMenu;
  end;
  inherited Assign(Source);
end;

procedure TcxPivotGridPopupMenus.DoOnClick(
  AItem: TMenuItem; var AHandled: Boolean);
begin
  AHandled := False;
  if Assigned(FOnClick) then
    FOnClick(PivotGrid, AItem, AHandled);
end;

function TcxPivotGridPopupMenus.CreateFieldHeaderMenu: TcxPivotGridFieldHeaderMenu;
begin
  Result := TcxPivotGridFieldHeaderMenu.Create(Self);
end;

function TcxPivotGridPopupMenus.CreateGroupValueMenu: TcxPivotGridGroupValueMenu;
begin
  Result := TcxPivotGridGroupValueMenu.Create(Self);
end;

function TcxPivotGridPopupMenus.CreateHeaderAreaMenu: TcxPivotGridHeaderAreaMenu;
begin
  Result := TcxPivotGridHeaderAreaMenu.Create(Self);
end;

procedure TcxPivotGridPopupMenus.CreateMenus;
begin
  FFieldHeaderMenu := CreateFieldHeaderMenu;
  FGroupValueMenu := CreateGroupValueMenu;
  FHeaderAreaMenu := CreateHeaderAreaMenu;
end;

procedure TcxPivotGridPopupMenus.DestroyMenus;
begin
  FreeAndNil(FFieldHeaderMenu);
  FreeAndNil(FGroupValueMenu);
  FreeAndNil(FHeaderAreaMenu);
end;

procedure TcxPivotGridPopupMenus.DoOnPopup(
  ASender: TcxPivotGridCustomPopupMenu; var AHandled: Boolean);
begin
  AHandled := False;
  if Assigned(FOnPopup) then
    FOnPopup(PivotGrid, ASender, AHandled);
end;

function TcxPivotGridPopupMenus.DoShowPopupMenu(const P: TPoint): Boolean;
begin
  Result := False;
  HitTest.HitPoint := PivotGrid.ScreenToClient(P);
  if HitTest.HitAtField then
  begin
    if HitTest.Field is TcxPivotGridField then
      FieldHeaderMenu.FField := PivotGrid.HitTest.Field as TcxPivotGridField
    else
      FieldHeaderMenu.FField := nil;
    Result := FieldHeaderMenu.Popup(P.X, P.Y)
  end
  else
    if HitTest.HitAtGroupHeader and (HitTest.GroupItem <> nil) and HitTest.GroupItem.HasChildren then
    begin
      if HitTest.GroupItem.Field <> nil then
      begin
        GroupValueMenu.FGroupItem := HitTest.GroupItem;
        Result := GroupValueMenu.Popup(P.X, P.Y);
      end;
    end
    else
      if HitTest.HitAtHeaderArea then
        Result := HeaderAreaMenu.Popup(P.X, P.Y);
end;

procedure TcxPivotGridPopupMenus.MenuItemClickHandler(Sender: TObject);
begin
//  DoOnClick((Sender as TMenuItem).Tag);
end;

procedure TcxPivotGridPopupMenus.Notification(
  AComponent: TComponent; Operation: TOperation);
begin
  FieldHeaderMenu.Notification(AComponent, Operation);
  GroupValueMenu.Notification(AComponent, Operation);
  HeaderAreaMenu.Notification(AComponent, Operation);
end;

function TcxPivotGridPopupMenus.GetHitTest: TcxPivotGridHitTest;
begin
  Result := PivotGrid.HitTest;
end;

procedure TcxPivotGridPopupMenus.SetFieldHeaderMenu(
  AValue: TcxPivotGridFieldHeaderMenu);
begin
  FFieldHeaderMenu.Assign(AValue);
end;

procedure TcxPivotGridPopupMenus.SetGroupValueMenu(
  AValue: TcxPivotGridGroupValueMenu);
begin
  GroupValueMenu.Assign(AValue);
end;

procedure TcxPivotGridPopupMenus.SetHeaderAreaMenu(
  AValue: TcxPivotGridHeaderAreaMenu);
begin
  HeaderAreaMenu.Assign(AValue);
end;

{ TcxPivotGridExportController }

constructor TcxPivotGridExportController.Create(APivotGrid: TcxCustomPivotGrid);
begin
  FPivotGrid := APivotGrid;
  Initialize;
end;

destructor TcxPivotGridExportController.Destroy;
begin
  Finalize;
  inherited Destroy;
end;

procedure TcxPivotGridExportController.Finalize;
begin
  ExpandColumns := False;
  ExpandRows := False;
  ReplaceStyles(nil);
  ViewInfo.DrawBorders := FSavedBorders;
  ViewInfo.DrawExpandButtons := FSavedExpandButtons;
  PivotGrid.OptionsPrefilter.Assign(FSavedPrefilterOptions);
  PivotGrid.OptionsView.Assign(FSavedOptionsView);
  PivotGrid.Styles.Assign(FSavedStyles);
  PivotGrid.Changes := PivotGrid.Changes + [gcLayout];
  PivotGrid.EndUpdate;
  FSavedStyles.Free;
  FSavedPrefilterOptions.Free;
  FSavedOptionsView.Free;
end;

procedure TcxPivotGridExportController.Initialize;
begin
  FSavedOptionsView := PivotGrid.CreateOptionsView;
  FSavedOptionsView.Assign(PivotGrid.OptionsView);
  FSavedPrefilterOptions := PivotGrid.CreateOptionsPrefilter;
  FSavedPrefilterOptions.Assign(PivotGrid.OptionsPrefilter);
  FSavedStyles := PivotGrid.CreateStyles;
  FSavedStyles.Assign(PivotGrid.Styles);
  FSavedBorders := ViewInfo.DrawBorders;
  FSavedExpandButtons := ViewInfo.DrawExpandButtons;
  PivotGrid.BeginUpdate;
  ExpandRows := True;
  ExpandColumns := True;
end;

function TcxPivotGridExportController.CalculateViewInfo: TcxPivotGridViewInfo;
var
  ALockCount: Integer;
begin
  Result := PivotGrid.ViewInfo;
  ALockCount := PivotGrid.LockCount;
  try
    PivotGrid.LockCount := 0;
    Result.FIsPrinting := True;
    PivotGrid.ViewData.Calculate;
    Result.Calculate;
    Result.BeforePaint;
  finally
    Result.FIsPrinting := False;
    PivotGrid.LockCount := ALockCount;
  end;
end;

procedure TcxPivotGridExportController.ReplaceStyles(
  AStyles: IcxPivotGridBaseStyles);
begin
  if AStyles = nil then
    PivotGrid.ViewInfo.FBaseStyles := PivotGrid.Styles
  else
    PivotGrid.ViewInfo.FBaseStyles := AStyles;
end;

function TcxPivotGridExportController.GetExpandColumns: Boolean;
begin
  Result := PivotGrid.ViewData.ExpandColumns;
end;

function TcxPivotGridExportController.GetExpandRows: Boolean;
begin
  Result := PivotGrid.ViewData.ExpandRows;
end;

function TcxPivotGridExportController.GetOptionsView: TcxPivotGridOptionsView;
begin
  Result := PivotGrid.OptionsView;
end;

function TcxPivotGridExportController.GetStyles: TcxPivotGridStyles;
begin
  Result := PivotGrid.Styles;
end;

function TcxPivotGridExportController.GetViewInfo: TcxPivotGridViewInfo;
begin
  Result := PivotGrid.ViewInfo
end;

procedure TcxPivotGridExportController.SetExpandColumns(AValue: Boolean);
begin
  PivotGrid.ViewData.ExpandColumns := AValue;
end;

procedure TcxPivotGridExportController.SetExpandRows(AValue: Boolean);
begin
  PivotGrid.ViewData.ExpandRows := AValue;
end;

{ TcxPivotGridFilterMRUItem }

function GetFilterStream(AFilter: TcxDataFilterCriteria): TMemoryStream;
begin
  Result := TMemoryStream.Create;
  AFilter.WriteData(Result);
end;

constructor TcxPivotGridFilterMRUItem.Create(AFilter: TcxDataFilterCriteria);
begin
  inherited Create;
  Filter := AFilter.DataController.CreateFilter;
  Filter.Assign(AFilter);
end;

destructor TcxPivotGridFilterMRUItem.Destroy;
begin
  Filter.Free;
  inherited;
end;

function TcxPivotGridFilterMRUItem.GetCaption: string;
begin
  Result := Filter.FilterCaption;
end;

function TcxPivotGridFilterMRUItem.StreamEquals(AStream: TMemoryStream): Boolean;
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

procedure TcxPivotGridFilterMRUItem.AssignTo(AFilter: TcxDataFilterCriteria);
begin
  AFilter.AssignItems(Filter);
end;

function TcxPivotGridFilterMRUItem.Equals(AItem: TcxMRUItem): Boolean;
begin
  Result := StreamEquals(TcxPivotGridFilterMRUItem(AItem).GetStream);
end;

function TcxPivotGridFilterMRUItem.FilterEquals(AFilter: TcxDataFilterCriteria): Boolean;
begin
  Result := StreamEquals(GetFilterStream(AFilter));
end;

function TcxPivotGridFilterMRUItem.GetStream: TMemoryStream;
begin
  Result := GetFilterStream(Filter);
end;

{ TcxPivotGridFilterMRUItems }

constructor TcxPivotGridFilterMRUItems.Create(APivotGrid: TcxCustomPivotGrid);
begin
  inherited Create;
  FPivotGrid := APivotGrid;
  FVisibleItems := TList.Create;
end;

destructor TcxPivotGridFilterMRUItems.Destroy;
begin
  FVisibleItems.Free;
  inherited;
end;

procedure TcxPivotGridFilterMRUItems.Add(AFilter: TcxDataFilterCriteria);
begin
  if not AFilter.IsEmpty then
  begin
    inherited Add(TcxPivotGridFilterMRUItem.Create(AFilter));
    RefreshVisibleItemsList;
  end;
end;

function TcxPivotGridFilterMRUItems.IsEmpty: Boolean;
begin
  Result := VisibleCount = 0;
end;

function TcxPivotGridFilterMRUItems.GetItem(Index: Integer): TcxPivotGridFilterMRUItem;
begin
  Result := TcxPivotGridFilterMRUItem(inherited Items[Index]);
end;

function TcxPivotGridFilterMRUItems.GetVisibleCount: Integer;
begin
  Result := FVisibleItems.Count;
end;

function TcxPivotGridFilterMRUItems.GetVisibleItem(Index: Integer): TcxPivotGridFilterMRUItem;
begin
  Result := TcxPivotGridFilterMRUItem(FVisibleItems[Index]);
end;

procedure TcxPivotGridFilterMRUItems.SetVisibleCount(AValue: Integer);
begin
  if AValue <> 0 then
    MaxCount := AValue + 1
  else
    MaxCount := 0;
  RefreshVisibleItemsList;
end;

procedure TcxPivotGridFilterMRUItems.RefreshVisibleItemsList;
var
  AFilter: TcxDataFilterCriteria;
  I: Integer;
  AItem: TcxPivotGridFilterMRUItem;
begin
  AFilter := PivotGrid.DataController.Filter;
  FVisibleItems.Clear;
  for I := 0 to Count - 1 do
  begin
    AItem := Items[I];
    if not AItem.FilterEquals(AFilter) then FVisibleItems.Add(AItem);
  end;
end;

{ TcxCustomPivotGrid }

constructor TcxCustomPivotGrid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  BeginUpdate;
  SetBounds(0, 0, 300, 250);
  Keys := [kArrows, kChars];
  BorderStyle := cxcbsDefault;
  Changes := [gcData];
  CreateSubClasses;
  if DesignerHelper <> nil then
    DesignerHelper.AddListener(Self);
  FNavigatorNotifier := TcxNavigatorControlNotifier.Create;
  EndUpdate;
end;

destructor TcxCustomPivotGrid.Destroy;
begin
  Inc(FLockCount);
  Controller.Clear;
  FreeAndNil(FNavigatorNotifier);
  if DesignerHelper <> nil then
    DesignerHelper.RemoveListener(Self);
  Customization.Visible := False;
  DestroySubClasses;
  inherited Destroy;
end;

procedure TcxCustomPivotGrid.AddListener(AListener: IcxPivotGridListener);
begin
  if FListeners.IndexOf(AListener) = -1 then
    FListeners.Add(AListener);
end;

procedure TcxCustomPivotGrid.ApplyBestFit;
var
  I: Integer;
begin
  CheckChanges;
  BeginUpdate;
  try
    for I := 0 to FieldCount - 1 do
      Fields[I].ApplyBestFit;
  finally
    EndUpdate;
  end;
end;

procedure TcxCustomPivotGrid.BeginUpdate;
begin
  Inc(FLockCount);
  if DataController <> nil then
    DataController.BeginUpdate;
end;

procedure TcxCustomPivotGrid.CopyToClipboard(ACopyAll: Boolean = False);
var
  ACopyRect: TRect;
  ARow, AColumn: Integer;
  ARowStr, ACopyToClipboardStr: string;
  APrevRow: TcxPivotGridViewDataItem;
const
  CRLF: string = #13#10;
  SEPARATOR: string = #9;
begin
  ACopyToClipboardStr := '';
  if ACopyAll then
    ACopyRect := Rect(0, 0, MaxInt, MaxInt)
  else
    ACopyRect := ViewData.Selection.GetCombinedSelectionBounds;
  with ACopyRect do
  begin
    BottomRight := Point(Min(Right, ViewData.ColumnCount - 1),
      Min(Bottom, ViewData.RowCount - 1));
  end;
  ShowHourglassCursor;
  try
    APrevRow := nil;
    for ARow := ACopyRect.Top to ACopyRect.Bottom do
    begin
      ARowStr := '';
      for AColumn := ACopyRect.Left to ACopyRect.Right do
      begin
        if ACopyAll or ViewData.IsCellSelected(ARow, AColumn) then
          ARowStr := ARowStr + ViewData.CellsAsText[ARow, AColumn];
        if AColumn <> ACopyRect.Right then
          // if not right most column need add column separator
          ARowStr := ARowStr + SEPARATOR;
      end;
      if (APrevRow <> nil) and not ViewData.IsGroupItemEquals(APrevRow, ViewData.Rows[ARow]) and
        (OptionsDataField.Area <> dfaRow) and not (APrevRow.IsTotal or APrevRow.IsGrandTotal) then
        APrevRow.ClearCache;
      APrevRow := ViewData.Rows[ARow];
      // if not last row need add row separator
      if ARow <> ACopyRect.Bottom then
        ARowStr := ARowStr + CRLF;
      ACopyToClipboardStr := ACopyToClipboardStr + ARowStr;
    end;
    Clipboard.AsText := ACopyToClipboardStr;
    DataChanged;
  finally
    HideHourglassCursor;
  end;
end;

function TcxCustomPivotGrid.CreateDrillDownDataSource: TcxCustomDataSource;
var
  ACells: TList;
begin
  ACells := TList.Create;
  try
    ViewData.PopulateSelectedCells(ACells);
    if IsOLAPActive then
      Result := OLAPDataSource.CreateDrillDownDataSource(ACells, FieldList)
    else
      Result := TcxPivotGridCrossCellDataSource.CreateEx(ACells)
  finally
    ACells.Free;
  end;
  TcxPivotGridCrossCellDataSource(Result).PivotGrid := Self;
end;

function TcxCustomPivotGrid.CreateField: TcxPivotGridField;
begin
  Result := GetFieldClass.Create(Owner);
  Result.PivotGrid := Self;
end;

procedure TcxCustomPivotGrid.DeleteAllFields;
var
  I: Integer;
begin
  if IsDestroying then Exit;
  BeginUpdate;
  try
    for I := 0 to FieldList.Count - 1 do
      TObject(FieldList.Last).Free;
    Groups.Clear;
  finally
    EndUpdate;
  end;
end;

procedure TcxCustomPivotGrid.EndUpdate;
begin
  Dec(FLockCount);
  if DataController.LockCount > 0 then
  begin
    ViewInfo.Clear;
    Include(FChanges, gcLayout);
    DataController.EndUpdate;
  end;
  CheckChanges;
end;

procedure TcxCustomPivotGrid.ShowPrefilterDialog;
begin
  if IsPrefilterEnabled then
    ExecuteFilterControlDialog(Self, LookAndFeel, FilterControlDialogApply);
end;

procedure TcxCustomPivotGrid.FullRefresh;
begin
  DataChanged;
end;

function TcxCustomPivotGrid.GetFieldByName(
  const AName: string): TcxPivotGridField;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FieldCount - 1 do
    if AnsiCompareText(Fields[I].Caption, AName) = 0 then
    begin
      Result := Fields[I];
      Break;
    end;
end;

procedure TcxCustomPivotGrid.LayoutChanged;
begin
  Changes := Changes + [gcLayout];
  if IsLocked then Exit;
  CheckChanges;
  Invalidate;
end;

procedure TcxCustomPivotGrid.RemoveListener(AListener: IcxPivotGridListener);
begin
  FListeners.Remove(AListener);
end;

procedure TcxCustomPivotGrid.RestoreFromIniFile(const AStorageName: string; ACreateChildren, ADeleteChildren: Boolean);
begin
  RestoreFrom(stIniFile, AStorageName, nil, ACreateChildren, ADeleteChildren);
end;

procedure TcxCustomPivotGrid.RestoreFromRegistry(const AStorageName: string; ACreateChildren, ADeleteChildren: Boolean);
begin
  RestoreFrom(stRegistry, AStorageName, nil, ACreateChildren, ADeleteChildren);
end;

procedure TcxCustomPivotGrid.RestoreFromStream(AStream: TStream; ACreateChildren, ADeleteChildren: Boolean);
begin
  RestoreFrom(stStream, '', AStream, ACreateChildren, ADeleteChildren);
end;

procedure TcxCustomPivotGrid.StoreToIniFile(
  const AStorageName: string; AReCreate: Boolean = True);
begin
  StoreTo(stIniFile, AStorageName, nil, AReCreate);
end;

procedure TcxCustomPivotGrid.StoreToRegistry(
  const AStorageName: string; AReCreate: Boolean = True);
begin
  StoreTo(stRegistry, AStorageName, nil, AReCreate);
end;

procedure TcxCustomPivotGrid.StoreToStream(AStream: TStream);
begin
  StoreTo(stStream, '', AStream);
end;

procedure TcxCustomPivotGrid.TranslationChanged;
begin
  DataChanged;
end;

procedure TcxCustomPivotGrid.AddField(AField: TcxPivotGridField);
begin
  if IsDestroying then Exit;
  FieldList.Add(AField);
  DataBuilder.DataController.AddItem(AField);
  DataChanged;
  Customization.Refresh;
  RefreshFilterableFieldsList;
end;

procedure TcxCustomPivotGrid.RemoveField(AField: TcxPivotGridField);
begin
  if FFields <> nil then
    FFields.Remove(AField);
  if IsDestroying then Exit;
  DataController.BeginUpdate;
  try
    DataController.RemoveItem(AField);
  finally
    DataController.EndUpdate;
  end;
  DataChanged;
  Customization.Refresh;
  RefreshFilterableFieldsList;
end;

procedure TcxCustomPivotGrid.BeforeMouseDown(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Controller.BeforeMouseDown(Button, Shift, X, Y);
  inherited BeforeMouseDown(Button, Shift, X, Y);
end;

procedure TcxCustomPivotGrid.BoundsChanged;
begin
  ViewChanged;
  inherited BoundsChanged;
end;

function TcxCustomPivotGrid.CanRetrieveFields(var AIsActive: Boolean): Boolean;
begin
  Result := FOLAPDataSource <> nil;
  AIsActive := IsOLAPActive;
end;

procedure TcxCustomPivotGrid.CheckChanges;
var
  AChanges: TcxPivotGridChanges;
begin
  if IsLocked or (Changes = []) then Exit;
  try
    FCustomSortAssigned := Assigned(FOnCompare);
    Controller.Clear;
    AChanges := Changes;
    Changes := [];
    if gcData in AChanges then
    begin
      DataBuilder.DataChanged;
      AChanges := AChanges + Changes + [gcLayout];
      Changes := [];
    end;
    if gcLayout in AChanges then
    begin
      DestroyEditViewDatas;
      ViewData.Calculate;
      AChanges := AChanges + Changes + [gcView];
      if ViewData.Selection.IsSelected then
      begin
        ViewData.Selection.ValidateSelections;
        AChanges := AChanges + Changes + [gcSelection];
      end;
      Changes := [];
    end;
    if gcView in AChanges then
    begin
      ViewInfo.Calculate;
      Invalidate;
    end;
    Controller.Update;
    UpdateMRUItems;

    if AChanges <> [] then
      SendNotification(AChanges);

    if gcLayout in AChanges then
      DoLayoutChanged;
    if gcSelection in AChanges then
      DoSelectionChanged;
  finally
    Changes := [];
  end;
end;

procedure TcxCustomPivotGrid.CheckUpdateScrollBars;
begin
  NeedUpdateScrollBarsPost := False;
  UpdateScrollBars;
end;

procedure TcxCustomPivotGrid.ClearCacheInformation;
var
  I: Integer;
begin
  if IsDestroying then Exit;
  for I := 0 to FieldCount - 1 do
    Fields[I].GroupValuesValid := False;
end;

procedure TcxCustomPivotGrid.CreateSubClasses;
begin
  FListeners := TInterfaceList.Create;
  FImagesListener := TChangeLink.Create;
  FImagesListener.OnChange := ImagesChangeHandler;
  FGroups := CreateGroups;
  FOptionsView := CreateOptionsView;
  FController := CreateController;
  FCustomization := CreateCustomization;
  FFields := TcxObjectList.Create;
  FFilterableFields := TcxPivotGridFields.Create;
  FDataController := CreateDataController;
  FDataBuilder := CreateDataBuilder;
  FViewInfo := CreateViewInfo;
  FViewData := CreateViewData;
  FPainter := CreatePainter;
  FOptionsCustomize := CreateOptionsCustomize;
  FOptionsBehavior := CreateOptionsBehavior;
  FOptionsData := CreateOptionsData;
  FOptionsDataField := CreateOptionsDataField;
  FOptionsPrefilter := CreateOptionsPrefilter;
  FOptionsSelection := CreateOptionsSelection;
  FPopupMenus := CreatePopupMenus;
  FStyles := CreateStyles;
  FSummaryFields := TcxPivotGridFields.Create;
  FHitTest := CreateHitTest;
  FPrefilterMRUItems := TcxPivotGridFilterMRUItems.Create(Self);
  UpdateMRUItems;
end;

procedure TcxCustomPivotGrid.DestroyEditViewDatas;
var
  I: Integer;
begin
  for I := 0 to FieldCount - 1 do
    Fields[I].DestroyEditViewData;
end;

procedure TcxCustomPivotGrid.DestroySubClasses;
begin
  FreeAndNil(FPrefilterMRUItems);
  OLAPDataSource := nil;
  SendNotification([]);
  FieldHeaderImages := nil;
  GroupHeaderImages := nil;
  FViewInfo.FBaseStyles := nil;
  FreeAndNil(FFilterableFields);
  FreeAndNil(FHitTest);
  FreeAndNil(FFields);
  FreeAndNil(FStyles);
  FreeAndNil(FDataController);
  FreeAndNil(FDataBuilder);
  FreeAndNil(FPainter);
  FreeAndNil(FSummaryFields);
  FreeAndNil(FViewData);
  FreeAndNil(FViewInfo);
  FreeAndNil(FOptionsCustomize);
  FreeAndNil(FOptionsBehavior);
  FreeAndNil(FOptionsData);
  FreeAndNil(FOptionsDataField);
  FreeAndNil(FOptionsPrefilter);
  FreeAndNil(FOptionsSelection);
  FreeAndNil(FOptionsView);
  FreeAndNil(FPopupMenus);
  FreeAndNil(FController);
  FreeAndNil(FCustomization);
  FreeAndNil(FGroups);
  FreeAndNil(FImagesListener);
  FListeners.Free;
end;

procedure TcxCustomPivotGrid.DataChanged;
begin
  ClearCacheInformation;
  Changes := Changes + [gcData];
  if IsLocked then Exit;
  CheckChanges;
  FNavigatorNotifier.RefreshNavigatorButtons;
end;

procedure TcxCustomPivotGrid.DataSourceChanged;
var
  I: Integer;
begin
  if IsLoading then Exit;
  BeginUpdate;
  try
    for I := FFields.Count - 1 downto 0 do
      Fields[I].SynchronizeUniqueName;
    DataChanged;
  finally
    EndUpdate;
  end;
end;

function TcxCustomPivotGrid.DoShowPopupMenu(
  AMenu: TComponent; X, Y: Integer): Boolean;
begin
  Result := PopupMenus.DoShowPopupMenu(Point(X, Y));
  if not Result then
    Result := inherited DoShowPopupMenu(AMenu, X, Y);
end;

procedure TcxCustomPivotGrid.FilterControlDialogApply(Sender: TObject);
begin
  DataController.Filter.Active := not DataController.Filter.IsEmpty;
end;

function TcxCustomPivotGrid.IsOLAPActive: Boolean;
begin
  Result := Assigned(FOLAPDataSource) and FOLAPDataSource.GetIsActive;
end;

function TcxCustomPivotGrid.IsPrefilterEnabled: Boolean;
begin
  Result := not IsOLAPActive;
end;

function TcxCustomPivotGrid.IsRestoring: Boolean;
begin
  Result := FIsRestoring;
end;

procedure TcxCustomPivotGrid.InitScrollBarsParameters;
begin
  if ViewData = nil then Exit;
  with ViewData do
  begin
    SetScrollBarInfo(sbHorizontal, 0, ColumnCount - 1,
      1, ColumnsPerPage, ColumnIndex, True, True);
    SetScrollBarInfo(sbVertical, 0, RowCount - 1,
      1, RowsPerPage, RowIndex, True, True)
  end;
end;

procedure TcxCustomPivotGrid.RefreshFilterableFieldsList;
var
  I: Integer;
begin
  FFilterableFields.Clear;
  if not OptionsCustomize.Filtering then Exit;
  for I := 0 to FieldCount - 1 do
    if Fields[I].Options.Filtering then
      FFilterableFields.Add(Fields[I]);
end;

procedure TcxCustomPivotGrid.ShowHourglassCursor;
begin
  if Visible and HandleAllocated then
  begin
    if FHourglassCursorRefCount = 0 then
      cxControls.ShowHourglassCursor;
    Inc(FHourglassCursorRefCount);
  end;
end;

procedure TcxCustomPivotGrid.SynchronizeUniqueName(AField: TcxPivotGridField);
begin
  if IsOLAPActive then
    AField.FLink := OLAPDataSource.GetLinkByUniqueName(AField.UniqueName)
  else
    AField.FLink := nil;
  if AField.FLink <> nil then
    AField.FUniqueName := AField.Link.UniqueName;
end;

procedure TcxCustomPivotGrid.UpdateMRUItems;
begin
  FPrefilterMRUItems.VisibleCount := OptionsPrefilter.MRUItemsListCount;
end;

procedure TcxCustomPivotGrid.HideHourglassCursor;
begin
  if FHourglassCursorRefCount = 1 then
    cxControls.HideHourglassCursor;
  if FHourglassCursorRefCount > 0 then
    Dec(FHourglassCursorRefCount);
end;

procedure TcxCustomPivotGrid.ImagesChangeHandler(Sender: TObject);
begin
  LayoutChanged;
end;

function TcxCustomPivotGrid.IsDestroying: Boolean;
begin
  Result := csDestroying in ComponentState;
end;

function TcxCustomPivotGrid.IsLoading: Boolean;
begin
  Result := csLoading in ComponentState;
end;

procedure TcxCustomPivotGrid.GetChildren(Proc: TGetChildProc; Root: TComponent);

  procedure DoStore(AField: TcxPivotGridField);
  begin
    if AField.Owner = Root then
      Proc(AField);
  end;

var
  I: Integer;
begin
  inherited GetChildren(Proc, Root);
  for I := 0 to FieldCount - 1 do
    DoStore(Fields[I]);
end;

function TcxCustomPivotGrid.GetCursor(
  X, Y: Integer): TCursor;
begin
  Result := crDefault;
  if not IsDesigning then
    Result := Controller.GetCursor(X, Y);
  if Result = crDefault then
    Result := inherited GetCursor(X, Y);
end;

function TcxCustomPivotGrid.GetDesignHitTest(
  X, Y: Integer; Shift: TShiftState): Boolean;
begin
  Result := inherited GetDesignHitTest(X, Y, Shift);
  if not Result then
  begin
    HitTest.HitPoint := Point(X, Y);
    Result := Controller.StartDragAndDrop(Point(X, Y)) or (DragAndDropState <> ddsNone) or
      HitTest.HitAtButton or HitTest.HitAtField;
    if not Result then
      Controller.HotTrackController.Update(nil);
  end;
end;

function TcxCustomPivotGrid.GetDragAndDropObjectClass: TcxDragAndDropObjectClass;
begin
  Result := Controller.GetDragAndDropObjectClass;
end;

function TcxCustomPivotGrid.GetFieldClass: TcxPivotGridFieldClass;
begin
  Result := TcxPivotGridField;
end;

procedure TcxCustomPivotGrid.Loaded;
begin
  DataController.Loaded;
  inherited Loaded;
  if OLAPDataSource <> nil then
    DataSourceChanged;
  Groups.Loaded;
  DataChanged;
end;

function TcxCustomPivotGrid.CreateController: TcxPivotGridController;
begin
  Result := TcxPivotGridController.Create(Self);
end;

function TcxCustomPivotGrid.CreateCustomization: TcxPivotGridCustomization;
begin
  Result := TcxPivotGridCustomization.Create(Self);
end;

function TcxCustomPivotGrid.CreateDataBuilder: TcxPivotGridDataBuilder;
begin
  Result := TcxPivotGridDataBuilder.Create(Self);
end;

function TcxCustomPivotGrid.CreateDataController: TcxCustomDataController;
begin
  Result := TcxPivotGridDataController.Create(Self);
end;

function TcxCustomPivotGrid.CreateGroups: TcxPivotGridFieldGroupCollection;
begin
  Result := TcxPivotGridFieldGroupCollection.Create(Self);
end;

function TcxCustomPivotGrid.CreateHitTest: TcxPivotGridHitTest;
begin
  Result := TcxPivotGridHitTest.Create(Self);
end;

function TcxCustomPivotGrid.CreateOptionsBehavior: TcxPivotGridOptionsBehavior;
begin
  Result := TcxPivotGridOptionsBehavior.Create(Self);
end;

function TcxCustomPivotGrid.CreateOptionsCustomize: TcxPivotGridOptionsCustomize;
begin
  Result := TcxPivotGridOptionsCustomize.Create(Self);
end;

function TcxCustomPivotGrid.CreateOptionsData: TcxPivotGridOptionsData;
begin
  Result := TcxPivotGridOptionsData.Create(Self);
end;

function TcxCustomPivotGrid.CreateOptionsDataField: TcxPivotGridOptionsDataField;
begin
  Result := TcxPivotGridOptionsDataField.Create(Self);
end;

function TcxCustomPivotGrid.CreateOptionsPrefilter: TcxPivotGridOptionsPrefilter;
begin
  Result := TcxPivotGridOptionsPrefilter.Create(Self);
end;

function TcxCustomPivotGrid.CreateOptionsSelection: TcxPivotGridOptionsSelection;
begin
  Result := TcxPivotGridOptionsSelection.Create(Self);
end;

function TcxCustomPivotGrid.CreateOptionsView: TcxPivotGridOptionsView;
begin
  Result := TcxPivotGridOptionsView.Create(Self);
end;

function TcxCustomPivotGrid.CreatePainter: TcxPivotGridPainter;
begin
  Result := TcxPivotGridPainter.Create(Self);
end;

function TcxCustomPivotGrid.CreatePopupMenus: TcxPivotGridPopupMenus;
begin
  Result := TcxPivotGridPopupMenus.Create(Self);
end;

function TcxCustomPivotGrid.CreateStyles: TcxPivotGridStyles;
begin
  Result := TcxPivotGridStyles.Create(Self);
end;

function TcxCustomPivotGrid.CreateViewData: TcxPivotGridViewData;
begin
  Result := TcxPivotGridViewData.Create(Self);
end;

function TcxCustomPivotGrid.CreateViewInfo: TcxPivotGridViewInfo;
begin
  Result := TcxPivotGridViewInfo.Create(Self);
end;

procedure TcxCustomPivotGrid.DblClick;
begin
  Controller.DblClick;
  inherited DblClick;
end;

procedure TcxCustomPivotGrid.DoCompare(AField: TcxPivotGridField;
  const AValue1, AValue2: Variant; var Compare: Integer);
begin
  if Assigned(FOnCompare) then
    FOnCompare(Self, AField, AValue1, AValue2, Compare);
end;

procedure TcxCustomPivotGrid.DoCustomDrawFieldHeader(ACanvas: TcxCanvas;
  ACell: TcxPivotGridFieldHeaderCellViewInfo; var ADone: Boolean);
begin
  ADone := False;
  if Assigned(FOnCustomDrawFieldHeader) then
    FOnCustomDrawFieldHeader(Self, ACanvas, ACell, ADone);
end;

procedure TcxCustomPivotGrid.DoCustomDrawColumnHeader(ACanvas: TcxCanvas;
  ACell: TcxPivotGridHeaderCellViewInfo; var ADone: Boolean);
begin
  ADone := False;
  if Assigned(FOnCustomDrawColumnHeader) then
    FOnCustomDrawColumnHeader(Self, ACanvas, ACell, ADone);
end;

procedure TcxCustomPivotGrid.DoCustomDrawPart(ACanvas: TcxCanvas;
  ACell: TcxPivotGridCustomCellViewInfo; var ADone: Boolean);
begin
  ADone := False;
  if Assigned(FOnCustomDrawPart) then
    FOnCustomDrawPart(Self, ACanvas, ACell, ADone);
end;

procedure TcxCustomPivotGrid.DoCustomDrawRowHeader(ACanvas: TcxCanvas;
  ACell: TcxPivotGridHeaderCellViewInfo; var ADone: Boolean);
begin
  ADone := False;
  if Assigned(FOnCustomDrawRowHeader) then
    FOnCustomDrawRowHeader(Self, ACanvas, ACell, ADone);
end;

procedure TcxCustomPivotGrid.DoCustomDrawCell(ACanvas: TcxCanvas;
  ACell: TcxPivotGridDataCellViewInfo; var ADone: Boolean);
begin
  ADone := False;
  if Assigned(FOnCustomDrawCell) then
    FOnCustomDrawCell(Self, ACanvas, ACell, ADone);
end;

procedure TcxCustomPivotGrid.DoCustomization;
begin
  if Assigned(FOnCustomization) then
    FOnCustomization(Self);
end;

procedure TcxCustomPivotGrid.DoFieldPosChanged(AField: TcxPivotGridField);
begin
  if Assigned(OnFieldPosChanged) then
    FOnFieldPosChanged(Self, AField);
end;

procedure TcxCustomPivotGrid.DoFieldSizeChanged(AField: TcxPivotGridField);
begin
  if Assigned(OnFieldSizeChanged) then
    OnFieldSizeChanged(Self, AField);
end;

procedure TcxCustomPivotGrid.DoFilterChanged;
begin
  CallNotify(OnFilterChanged, Self);
end;

procedure TcxCustomPivotGrid.DoLayoutChanged;
begin
  if Assigned(OnLayoutChanged) then
    FOnLayoutChanged(Self);
end;

procedure TcxCustomPivotGrid.DoPrefilterChanged;
begin
  PrefilterMRUItems.Add(DataController.Filter);
  DoFilterChanged;
end;

procedure TcxCustomPivotGrid.DoSelectionChanged;
begin
  FNavigatorNotifier.RefreshNavigatorButtons;
  if Assigned(FOnSelectionChanged) then
    FOnSelectionChanged(Self);
end;

procedure TcxCustomPivotGrid.FocusChanged;
begin
  inherited FocusChanged;
  if not IsLocked then
    ViewInfo.SelectionChanged;
end;

procedure TcxCustomPivotGrid.FontChanged;
begin
  inherited FontChanged;
  LayoutChanged;
end;

function TcxCustomPivotGrid.GetIsFocused: Boolean;
begin
  Result := inherited GetIsFocused;
  if not Result and (Controller <> nil) then
    Result := Controller.FilterPopup.HasPopupWindow;
end;

function TcxCustomPivotGrid.IsDesignerAvailable: Boolean;
begin
  Result := (DesignerHelper <> nil) and (FindRootDesigner(Self) <> nil);
end;

procedure TcxCustomPivotGrid.KeyDown(var Key: Word; Shift: TShiftState);
begin
  Controller.KeyDown(Key, Shift);
  inherited KeyDown(Key, Shift);
end;

procedure TcxCustomPivotGrid.KeyPress(var Key: Char);
begin
  Controller.KeyPress(Key);
  inherited KeyPress(Key);
end;

procedure TcxCustomPivotGrid.LookAndFeelChanged(Sender: TcxLookAndFeel;
  AChangedValues: TcxLookAndFeelValues);
begin
  inherited LookAndFeelChanged(Sender, AChangedValues);
  LayoutChanged;
end;

procedure TcxCustomPivotGrid.MouseDown(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  HitTest.ShiftState := Shift;
  HitTest.HitPoint := Point(X, Y);
  Controller.MouseDown(Button, Shift, X, Y);
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TcxCustomPivotGrid.MouseLeave(AControl: TControl);
begin
  Controller.MouseLeave;
end;

procedure TcxCustomPivotGrid.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  HitTest.ShiftState := Shift;
  HitTest.HitPoint := Point(X, Y);
  Controller.MouseMove(Shift, X, Y);
  inherited MouseMove(Shift, X, Y);
end;

procedure TcxCustomPivotGrid.MouseUp(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  HitTest.ShiftState := Shift;
  HitTest.HitPoint := Point(X, Y);
  Controller.MouseUp(Button, Shift, X, Y);
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TcxCustomPivotGrid.Notification(
  AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if PopupMenus <> nil then
    PopupMenus.Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = FFieldHeaderImages then
      FFieldHeaderImages := nil;
    if AComponent = FGroupHeaderImages then
      FGroupHeaderImages := nil;
    if AComponent = FOLAPDataSource then
      OLAPDataSource := nil;
  end;
end;

procedure TcxCustomPivotGrid.Paint;
begin
  CheckChanges;
  if Changes <> [] then Exit;
  CheckUpdateScrollBars;
  inherited Paint;
  Painter.Paint(Canvas);
  if DragAndDropState = ddsInProcess then
     TcxPivotGridCustomDragDropObject(DragAndDropObject).DirtyChanged;
end;

procedure TcxCustomPivotGrid.RecreatePainter;
begin
  FreeAndNil(FPainter);
  FPainter := CreatePainter;
end;

procedure TcxCustomPivotGrid.RecreateViewInfo;
begin
  FreeAndNil(FViewInfo);
  FViewInfo := CreateViewInfo;
end;

procedure TcxCustomPivotGrid.Scroll(AScrollBarKind: TScrollBarKind;
  AScrollCode: TScrollCode; var AScrollPos: Integer);
begin
  if AScrollCode = scEndScroll then Exit;
  if AScrollCode = scTrack then
    AScrollCode := scPosition;
  if AScrollBarKind = sbHorizontal then
  begin
    if ViewData.ScrollColumns(AScrollCode, AScrollPos) then
      Invalidate;
  end
  else
    if AScrollBarKind = sbVertical then
    begin
      if ViewData.ScrollRows(AScrollCode, AScrollPos) then
        Invalidate;
    end;
end;

procedure TcxCustomPivotGrid.SelectionChanged;
begin
  if not IsLocked then
    ViewInfo.SelectionChanged;
  Changes := Changes + [gcSelection];
  CheckChanges;
end;

procedure TcxCustomPivotGrid.SendNotification(AChanges: TcxPivotGridChanges);
var
  I: Integer;
  AIntf: IcxPivotGridListener;
begin
  for I := FListeners.Count - 1 downto 0 do
    if Supports(FListeners[I], IcxPivotGridListener, AIntf) then
    begin
      if gcLayout in AChanges then
        AIntf.LayoutChanged(Self);
      if gcData in AChanges then
        AIntf.DataChanged(Self);
      if gcSelection in AChanges then
        AIntf.SelectionChanged(Self);
      if AChanges = [] then
        AIntf.PivotRemoved(Self);
    end;
end;

function TcxCustomPivotGrid.SetFieldAreaIndex(AField: TPersistent;
  AArea: TcxPivotGridFieldArea; var AIndex: Integer): Boolean;
var
  I: Integer;
  AFields: TcxObjectList;
  ANewField: TcxPivotGridField;
  APosInfo: TcxPivotGridFieldPosition;
begin
  Result := not IsLoading and not IsRestoring;
  if not Result then Exit;
  APosInfo := TcxPivotGridFieldPosition.Create(AField);
  AFields := TcxObjectList.Create;
  try
    for I := 0 to FieldCount - 1 do
    begin
      ANewField := Fields[I];
      if (ANewField.Group <> nil) and (ANewField.Group[0] <> ANewField) then
        Continue;
      if (ANewField.Area = AArea) and not APosInfo.IsSameGroup(ANewField) then
        AFields.Add(TcxPivotGridFieldPosition.Create(ANewField));
    end;
    if OptionsDataField.IsSameArea(AArea) and (OptionsDataField <> AField) then
      AFields.Add(TcxPivotGridFieldPosition.Create(OptionsDataField));

    AFields.Sort(@CompareFieldsPosition);

    // correct with invisible indexes
    if AIndex <> MaxInt then
    begin
      for I := 0 to AFields.Count - 1 do
      begin
        if I >= AIndex then Break;
        if not TcxPivotGridFieldPosition(AFields[I]).Visible then
          Inc(AIndex)
        else
          if TcxPivotGridFieldPosition(AFields[I]).Group <> nil then
            Dec(AIndex, TcxPivotGridFieldPosition(AFields[I]).Group.VisibleCount - 1);
      end;
    end;

    AIndex := Max(0, AIndex);
    if AIndex >= AFields.Count then
      AFields.Add(APosInfo)
    else
      AFields.Insert(AIndex, APosInfo);

    AIndex := 0;
    for I := 0 to AFields.Count - 1 do
    begin
      TcxPivotGridFieldPosition(AFields[I]).SetAreaIndex(AIndex);
      Inc(AIndex);
    end;
  finally
    AFields.Free;
  end;
end;

function TcxCustomPivotGrid.StartDragAndDrop(const P: TPoint): Boolean;
begin
  Result := Controller.StartDragAndDrop(P);
end;

procedure TcxCustomPivotGrid.ViewChanged;
begin
  Changes := Changes + [gcView];
  CheckChanges;
  Invalidate;
end;

procedure TcxCustomPivotGrid.DoCreateAllFields;
begin
  FOLAPDataSource.RetrieveFields(Self);
end;

// IcxFilterControl
function TcxCustomPivotGrid.GetCaption(Index: Integer): string;
begin
  Result := FFilterableFields[Index].Caption;
end;

function TcxCustomPivotGrid.GetCount: Integer;
begin
  if IsPrefilterEnabled then
    Result := FFilterableFields.Count
  else
    Result := 0;
end;

function TcxCustomPivotGrid.GetCriteria: TcxFilterCriteria;
begin
  Result := DataController.Filter;
end;

function TcxCustomPivotGrid.GetItemLink(Index: Integer): TObject;
begin
  Result := FFilterableFields[Index];
end;

function TcxCustomPivotGrid.GetItemLinkID(Index: Integer): Integer;
begin
  Result := Index;
end;

function TcxCustomPivotGrid.GetItemLinkName(Index: Integer): string;
begin
  Result := FFilterableFields[Index].Name;
end;

function TcxCustomPivotGrid.GetFieldName(Index: Integer): string;
begin
  Result := FFilterableFields[Index].DataBinding.GetFilterFieldName;
end;

function TcxCustomPivotGrid.GetProperties(Index: Integer): TcxCustomEditProperties;
begin
  Result := FFilterableFields[Index].GetEditProperties;
end;

function TcxCustomPivotGrid.GetValueType(Index: Integer): TcxValueTypeClass;
begin
  Result := FFilterableFields[Index].DataBinding.ValueTypeClass;
end;

function TcxCustomPivotGrid.GetItem(Index: Integer): TObject;
begin
  Result := Fields[Index];
end;

function TcxCustomPivotGrid.GetItemID(AItem: TObject): Integer;
begin
  Result := FFields.IndexOf(AItem);
end;

function TcxCustomPivotGrid.GetItemValueSource(
  AItemIndex: Integer): TcxDataEditValueSource;
begin
  Result := evsValue;
  if (Fields[AItemIndex].Area <> faData) and (Fields[AItemIndex].Properties <> nil) then
    Result := Fields[AItemIndex].Properties.GetEditValueSource(false);
end;

procedure TcxCustomPivotGrid.UpdateControl(AInfo: TcxUpdateControlInfo);
begin
  if {(AInfo is TcxDataChangedInfo) or} (AInfo is TcxUpdateRecordInfo)then
    Exit;
  ClearCacheInformation;
  DataChanged;
end;

procedure TcxCustomPivotGrid.UpdateData;
begin
  ClearCacheInformation;
  DataChanged;
end;

procedure TcxCustomPivotGrid.UpdateItemIndexes;
begin
  DataChanged;
end;

// IcxNavigator
function TcxCustomPivotGrid.CanAppend: Boolean;
begin
  Result := False;
end;

function TcxCustomPivotGrid.CanDelete: Boolean;
begin
  Result := False;
end;

function TcxCustomPivotGrid.CanEdit: Boolean;
begin
  Result := False;
end;

function TcxCustomPivotGrid.CanInsert: Boolean;
begin
  Result := False;
end;

function TcxCustomPivotGrid.IsActive: Boolean;
begin
  Result := True;
end;

function TcxCustomPivotGrid.IsBof: Boolean;
begin
  Result := Controller.FocusedCell.Y = 0;
end;

function TcxCustomPivotGrid.IsBookmarkAvailable: Boolean;
begin
  Result := ViewData.FBookMarkRow <> -1;
end;

function TcxCustomPivotGrid.IsEditing: Boolean;
begin
  Result := False;
end;

function TcxCustomPivotGrid.IsEof: Boolean;
begin
  Result := Controller.FocusedCell.Y >= ViewData.RowCount - 1;
end;

procedure TcxCustomPivotGrid.ClearBookmark;
begin
  ViewData.FBookMarkRow := -1;
end;

procedure TcxCustomPivotGrid.DoAction(AButtonIndex: Integer);

  procedure SetRow(ARow: Integer; AAbsoluteValue: Boolean = False);
  begin
    if AAbsoluteValue then
      Controller.SetSelection(Controller.FocusedCell.X, ARow, [])
    else
      Controller.SetSelectionInc(0, ARow, []);
    ViewData.MakeSelectionVisible;
  end;

begin
  case AButtonIndex of
    NBDI_FIRST:
      SetRow(0, True);
    NBDI_PRIORPAGE:
      SetRow(-ViewData.RowsPerPage + 1);
    NBDI_PRIOR:
      SetRow(-1);
    NBDI_NEXT:
      SetRow(1);
    NBDI_NEXTPAGE:
      SetRow(ViewData.RowsPerPage - 1);
    NBDI_LAST:
      SetRow(ViewData.RowCount - 1, True);
    NBDI_SAVEBOOKMARK:
      ViewData.FBookMarkRow := Controller.FocusedCell.Y;
    NBDI_GOTOBOOKMARK:
      SetRow(ViewData.FBookMarkRow, True);
    NBDI_FILTER:
      ShowPrefilterDialog;
  end;
end;

function TcxCustomPivotGrid.GetNotifier: TcxNavigatorControlNotifier;
begin
  Result := FNavigatorNotifier;
end;

function TcxCustomPivotGrid.IsActionSupported(AButtonIndex: Integer): Boolean;
begin
  case AButtonIndex of
    NBDI_FIRST .. NBDI_LAST, NBDI_SAVEBOOKMARK .. NBDI_FILTER:
      Result := True;
  else
    Result := False;
  end;
end;

// IcxStoredObject
function TcxCustomPivotGrid.StoredObject_GetObjectName: string;
begin
  Result := Name;
end;

function TcxCustomPivotGrid.StoredObject_GetProperties(AProperties: TStrings): Boolean;
var
  I: Integer;
begin
  for I := Low(PivotGridDefaultStoredProperties) to High(PivotGridDefaultStoredProperties) do
    AProperties.Add(PivotGridDefaultStoredProperties[I]);
  if Assigned(OnGetStoredProperties) then
    OnGetStoredProperties(Self, AProperties);
  Result := True;
end;

procedure TcxCustomPivotGrid.StoredObject_GetPropertyValue(
  const AName: string; var AValue: Variant);

  function GetFilterValue: Variant;
  var
    AStream: TStream;
  begin
    AStream := TMemoryStream.Create;
    try
      DataController.Filter.WriteData(AStream);
      Result := StreamToString(AStream);
    finally
      AStream.Free;
    end;
  end;

begin
  case GetPropertyIndex(AName, PivotGridDefaultStoredProperties) of
    0: AValue := GetFilterValue;
    1: AValue := DataController.Filter.Active;
  end;
  if Assigned(OnGetStoredPropertyValue) then
    OnGetStoredPropertyValue(Self, AName, AValue);
end;

procedure TcxCustomPivotGrid.StoredObject_SetPropertyValue(
  const AName: string; const AValue: Variant);

  procedure SetFilterValue;
  var
    AStream: TStream;
  begin
    AStream := TMemoryStream.Create;
    try
      StringToStream(dxVariantToAnsiString(AValue), AStream);
      AStream.Position := 0;
      DataController.Filter.ReadData(AStream);
    finally
      AStream.Free;
    end;
  end;

begin
  case GetPropertyIndex(AName, PivotGridDefaultStoredProperties) of
    0: SetFilterValue;
    1: DataController.Filter.Active := AValue;
  end;
  if Assigned(OnSetStoredPropertyValue) then
    OnSetStoredPropertyValue(Self, AName, AValue);
end;

// IcxStoredParent
function TcxCustomPivotGrid.StoredParent_CreateChild(
  const AObjectName, AClassName: string): TObject;
begin
  if AClassName = GetFieldClass.ClassName then
  begin
    Result := CreateField;
    TcxPivotGridField(Result).Name := AObjectName;
    if Assigned(OnInitStoredObject) then
      FOnInitStoredObject(Self, Result);
  end
  else
    Result := nil;
end;

procedure TcxCustomPivotGrid.StoredParent_DeleteChild(
  const AObjectName: string; AObject: TObject);
begin
  AObject.Free;
end;

procedure TcxCustomPivotGrid.StoredParent_GetChildren(AChildren: TStringList);
var
  I: Integer;
begin
  for I := 0 to FieldCount - 1 do
    AChildren.AddObject('', Fields[I]);
end;

function TcxCustomPivotGrid.GetFieldCount: Integer;
begin
  Result := FFields.Count;
end;

function TcxCustomPivotGrid.GetField(AIndex: Integer): TcxPivotGridField;
begin
  Result := TcxPivotGridField(FieldList.List^[AIndex]);
end;

function TcxCustomPivotGrid.GetIsLocked: Boolean;
begin
  Result := IsLoading or IsDestroying;
  if not Result then
    Result := FLockCount <> 0;
end;

function TcxCustomPivotGrid.GetRecordCount: Integer;
begin
  Result := DataController.RowCount;
end;

procedure TcxCustomPivotGrid.SetField(
  AIndex: Integer; AValue: TcxPivotGridField);
begin
  Fields[AIndex].Assign(AValue);
end;

procedure TcxCustomPivotGrid.SetFieldHeaderImages(AValue: TCustomImageList);
begin
  SetImages(FFieldHeaderImages, AValue);
end;

procedure TcxCustomPivotGrid.SetGroupHeaderImages(AValue: TCustomImageList);
begin
  SetImages(FGroupHeaderImages, AValue);
end;

procedure TcxCustomPivotGrid.SetGroups(AValue: TcxPivotGridFieldGroupCollection);
begin
  FGroups.Assign(AValue);
end;

procedure TcxCustomPivotGrid.SetImages(var AField: TCustomImageList;
  ANewValue: TCustomImageList);
begin
  cxSetImageList(ANewValue, AField, ImagesListener, Self);
end;

procedure TcxCustomPivotGrid.SetOLAPDataSource(
  AValue: TcxPivotGridCustomOLAPDataSource);
begin
  if AValue <> OLAPDataSource then
  begin
    if FOLAPDataSource <> nil then
    begin
      FOLAPDataSource.RemoveFreeNotification(Self);
      FOLAPDataSource.RemoveListener(Self);
    end;
    FOLAPDataSource := AValue;
    if FOLAPDataSource <> nil then
    begin
      FOLAPDataSource.FreeNotification(Self);
      FOLAPDataSource.AddListener(Self);
    end;
    DataSourceChanged;
  end;
end;

procedure TcxCustomPivotGrid.SetOptionsBehavior(
  AValue: TcxPivotGridOptionsBehavior);
begin
  FOptionsBehavior.Assign(AValue);
end;

procedure TcxCustomPivotGrid.SetOptionsCustomize(
  AValue: TcxPivotGridOptionsCustomize);
begin
  FOptionsCustomize.Assign(AValue)
end;

procedure TcxCustomPivotGrid.SetOptionsData(AValue: TcxPivotGridOptionsData);
begin
  FOptionsData.Assign(AValue);
end;

procedure TcxCustomPivotGrid.SetOptionsDataField(
  AValue: TcxPivotGridOptionsDataField);
begin
  FOptionsDataField.Assign(AValue);
end;

procedure TcxCustomPivotGrid.SetOptionsPrefilter(AValue: TcxPivotGridOptionsPrefilter);
begin
  FOptionsPrefilter.Assign(AValue);
end;

procedure TcxCustomPivotGrid.SetOptionsSelection(
  AValue: TcxPivotGridOptionsSelection);
begin
  FOptionsSelection.Assign(AValue);
end;

procedure TcxCustomPivotGrid.SetOptionsView(AValue: TcxPivotGridOptionsView);
begin
  FOptionsView.Assign(AValue);
end;

procedure TcxCustomPivotGrid.SetPopupMenus(AValue: TcxPivotGridPopupMenus);
begin
  FPopupMenus.Assign(AValue);
end;

procedure TcxCustomPivotGrid.SetStyles(AValue: TcxPivotGridStyles);
begin
  FStyles.Assign(AValue);
end;

procedure TcxCustomPivotGrid.WMSetCursor(var Message: TWMSetCursor);
var
  P: TPoint;
  ACursor: TCursor;
begin
  ACursor := crDefault;
  P := ScreenToClient(GetMouseCursorPos);
  if IsDesigning and (DragAndDropState = ddsNone) and GetDesignHitTest(P.X, P.Y, [ssLeft]) then
    ACursor := Controller.GetCursor(P.X, P.Y);
  if ACursor <> crDefault then
    SetCursor(Screen.Cursors[ACursor])
  else
    inherited;
end;

procedure TcxCustomPivotGrid.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  if OptionsBehavior.FocusCellOnTab then
    Message.Result := Message.Result or DLGC_WANTTAB;
end;

procedure TcxCustomPivotGrid.WMRefreshCustomization(var Message: TMessage);
begin
  Customization.Refresh;
end;

procedure TcxCustomPivotGrid.RestoreFrom(AStorageType: TcxStorageType;
  const AStorageName: string; AStorageStream: TStream; ACreateChildren, ADeleteChildren: Boolean);
var
  AStorage: TcxStorage;
  AModes: TcxStorageModes;
begin
  AStorage := TcxStorage.Create(AStorageName, AStorageStream);
  try
    BeginUpdate;
    try
      AModes := [];
      if ACreateChildren then
        Include(AModes, smChildrenCreating);
      if ADeleteChildren then
        Include(AModes, smChildrenDeleting);
      AStorage.Modes := AModes;

      FIsRestoring := True;
      try
        case AStorageType of
          stIniFile: AStorage.RestoreFromIni(Self);
          stRegistry: AStorage.RestoreFromRegistry(Self);
          stStream: AStorage.RestoreFromStream(Self);
        end;
      finally
        FIsRestoring := False;
      end;
    finally
      EndUpdate;
    end;
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomPivotGrid.StoreTo(AStorageType: TcxStorageType;
  const AStorageName: string; AStorageStream: TStream; AReCreate: Boolean = True);
var
  AStorage: TcxStorage;
begin
  AStorage := TcxStorage.Create(AStorageName, AStorageStream);
  try
    BeginUpdate;
    try
      AStorage.ReCreate := ARecreate;
      case AStorageType of
        stIniFile: AStorage.StoreToIni(Self);
        stRegistry: AStorage.StoreToRegistry(Self);
        stStream: AStorage.StoreToStream(Self);
      end;
      AStorage.ReCreate := False;
    finally
      EndUpdate;
    end;
  finally
    AStorage.Free;
  end;
end;

{ TcxCustomDesignHelper }

procedure TcxPivotGridCustomDesignHelper.RefreshListener(
  APivotGrid: TcxCustomPivotGrid);
begin
  if not APivotGrid.IsLocked and APivotGrid.HandleAllocated then
  begin
    APivotGrid.ViewInfo.Calculate;
    APivotGrid.Invalidate;
  end;
end;

function cxPivotGridHierarchyImages: TImageList;
var
  B: TBitmap;
begin
  if FHierarchyImages = nil then
  begin
    FHierarchyImages := TImageList.CreateSize(16, 16);
    B := TBitmap.Create;
    try
      B.LoadFromResourceName(HInstance, 'CXPIVOTGRIDHIERARCHYIMAGES');
      FHierarchyImages.AddMasked(B, clFuchsia);
    finally
      B.Free;
    end;
  end;
  Result := FHierarchyImages;
end;

initialization
  crcxPivotGridArrow := crArrow;
  crcxPivotGridHorzSize := crcxHorzSize;
  crcxPivotGridNoDrop := crcxNoDrop;
  crcxPivotGridRemove := crcxRemove;

finalization
  FreeAndNil(FHierarchyImages);

end.
