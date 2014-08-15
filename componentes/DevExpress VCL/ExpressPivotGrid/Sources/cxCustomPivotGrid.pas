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
  Classes, SysUtils, Windows, Messages, Forms, StdCtrls, Graphics, Controls, cxContainer,
  cxClasses, cxControls, cxGraphics, cxCustomData, cxDataStorage, cxDataUtils,
  cxEdit, cxStyles, cxLookAndFeels, cxLookAndFeelPainters, cxGeometry, cxDrawTextUtils,
  cxVariants, Math, cxDropDownEdit, cxButtons, cxCheckListBox, cxCheckBox, cxFormats, cxStorage,
  {$IFDEF DELPHI6}
    Variants, DateUtils,
    {$IFNDEF NONDB}
       FMTBcd, SqlTimSt,
    {$ENDIF}
  {$ENDIF}
  cxDateUtils, Menus, Clipbrd, ExtCtrls, ImgList, dxOffice11, dxCore;

const
  // styles constants
  gs_Background       = 0;
  gs_ColumnHeader     = 1;
  gs_ColumnHeaderArea = 2;
  gs_Content          = 3;
  gs_DataHeaderArea   = 4;
  gs_FieldHeader      = 5;
  gs_FilterHeaderArea = 6;
  gs_FilterSeparator  = 7;
  gs_HeaderBackground = 8;
  gs_Inactive         = 9;
  gs_RowHeader        = 10;
  gs_RowHeaderArea    = 11;
  gs_Selected         = 12;
  gs_Total            = 13;

  gs_MaxStyleIndex    = gs_Total;

  // hit test constants
  htcButton         = 1;
  htcDataCell       = 2;
  htcDataHeader     = 3;
  htcFieldHeader    = 4;
  htcHeaderArea     = 5;
  htcFilter         = 6;
  htcGroupHeader    = 7;
  htcHorzSizingEdge = 8;
  htcVertSizingEdge = 9;

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
  EcxPivotGrid = class(Exception);

  TcxCustomPivotGrid = class;

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
  TcxPivotGridCrossCellSummary = class;

  TcxPivotGridField = class;
  TcxPivotGridFieldClass = class of TcxPivotGridField;
  TcxPivotGridFieldFilter = class;
  TcxPivotGridHitTest = class;
  TcxPivotGridController = class;

  TcxPivotGridChange = (gcLayout, gcData, gcView);
  TcxPivotGridChanges = set of TcxPivotGridChange;

  TcxPivotGridCustomCellViewInfo = class;
  TcxPivotGridHeaderBackgroundCellViewInfo = class;
  TcxPivotGridHeaderCellViewInfo = class;
  TcxPivotGridFieldHeaderCellViewInfo = class;
  TcxPivotGridDragDropAreaInfo = class;

  TcxPivotGridFieldArea = (faColumn, faRow, faFilter, faData);
  TcxPivotGridFieldAreas = set of TcxPivotGridFieldArea;

  TcxPivotGridDataFieldArea = (dfaNone, dfaColumn, dfaRow);
  TcxPivotGridDataFieldAreas = set of TcxPivotGridDataFieldArea;

  TcxPivotGridGroupInterval = (giDefault, giDate, giDateDay, giDateDayOfWeek,
    giDateDayOfYear, giDateWeekOfMonth, giDateWeekOfYear, giDateMonth, giDateQuarter,
    giDateYear, giYearAge, giMonthAge, giWeekAge, giDayAge, giAlphabetical, giNumeric, giCustom);

  TcxPivotGridTotalsLocation = (tlFar, tlNear);

	TcxPivotGridSummaryType = (stCount, stSum, stMin, stMax, stAverage,
    stStdDev, stStdDevP, stVariance, stVarianceP, stCustom);

  TcxPivotGridTotalsVisibility = (tvAutomatic, tvCustom, tvNone);

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
  public
    constructor Create(const AValue: Variant);
    function IsEqual(AValue: TcxPivotGridVariantValue): Boolean;
    function Compare(const AValue: Variant): Integer;
    
    property Value: Variant read FValue;
  end;

  TcxPivotGridVariantList = class
  private
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

    property Items[Index: Integer]: Integer read GetItem write SetItem; default;
  end;

  { TcxPivotGridFields }

  TcxPivotGridFields = class(TcxList)
  private
    function GetField(Index: Integer): TcxPivotGridField;
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
  public
    procedure BeforePaint;
    function CalculateHitTest(AHitTest: TcxPivotGridHitTest): Boolean;
    procedure DeleteAll;
    procedure ExcludeFromClipping(ACanvas: TcxCanvas);
    procedure Paint(ACanvas: TcxCanvas; AHandler: TcxPivotGridCustomDrawEvent); virtual;

    property Items[Index: Integer]: TcxPivotGridCustomCellViewInfo read GetItem; default;
  end;

// PivotGrid DataBuilder

  { TcxPivotGridGroupItem }

  TcxPivotGridGroupItem = class
  private
    FDataController: TcxCustomDataController;
    FDisplayText: string;
    FExpanded: Boolean;
    FField: TcxPivotGridField;
    FItems: TcxObjectList;
    FIndex: Integer;
    FParent: TcxPivotGridGroupItem;
    FRecordIndex: Integer;
    FRecords: TcxPivotGridRecords;
    function GetDisplayText: string;
    function GetExpanded: Boolean;
    function getNextSibling: TcxPivotGridGroupItem;
    function GetItem(AIndex: Integer): TcxPivotGridGroupItem;
    function GetItemCount: Integer;
    function GetLevel: Integer;
    function GetPivotGrid: TcxCustomPivotGrid;
    function getPrevSibling: TcxPivotGridGroupItem;
    procedure SetExpanded(AValue: Boolean);
  protected
    FInternalValue: Variant;
    FSortingValid: Boolean;
    FSummaryValue: Variant;
    FIsValueAsssigned: Boolean;
    function GetItemAlwaysExpanded: Boolean; virtual;
    function GetSize: Integer; virtual;
    function GetSingleItemSize: Integer; virtual;
    function GetTotalsCount: Integer; virtual;
    function GetValue: Variant; virtual;
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

    property ItemList: TcxObjectList read FItems;
    property SummaryValue: Variant read FSummaryValue;
  public
    constructor Create(AParent: TcxPivotGridGroupItem; ADataController: TcxCustomDataController;
      ARecordIndex: Integer;  AField: TcxPivotGridField); virtual;
    destructor Destroy; override;
    function AddChild(AClass: TcxPivotGridGroupItemClass): TcxPivotGridGroupItem; overload;
    function AddChild(AIndex, ARecordIndex: Integer; AField: TcxPivotGridField): TcxPivotGridGroupItem; overload;
    function Compare(const AValue: Variant): Integer;
    function CreateSummaryRecords: TcxPivotGridRecords; virtual;
    procedure DeleteChildren; virtual;
    function GetCellByCrossItem(AItem: TcxPivotGridGroupItem): TcxPivotGridCrossCell; virtual;
    function GetPrev: TcxPivotGridGroupItem;
    procedure MarkDeleted;
    procedure RemoveChildrenFrom(AItem: TcxPivotGridGroupItem);

    property DataController: TcxCustomDataController read FDataController;
    property DisplayText: string read GetDisplayText;
    property Expanded: Boolean read GetExpanded write SetExpanded;
    property Index: Integer read FIndex;
    property Field: TcxPivotGridField read FField;
    property ItemCount: Integer read GetItemCount;
    property Items[Index: Integer]: TcxPivotGridGroupItem read GetItem;
    property Level: Integer read GetLevel;
    property NextSibling: TcxPivotGridGroupItem read getNextSibling;
    property Parent: TcxPivotGridGroupItem read FParent;
    property PivotGrid: TcxCustomPivotGrid read GetPivotGrid;
    property PrevSibling: TcxPivotGridGroupItem read getPrevSibling;
    property RecordIndex: Integer read FRecordIndex;
    property Records: TcxPivotGridRecords read FRecords;
    property Size: Integer read GetSize;
    property TotalsCount: Integer read GetTotalsCount;
    property Value: Variant read GetValue;
  end;

  { TcxPivotGridRowItem }

  TcxPivotGridRowItem = class(TcxPivotGridGroupItem)
  protected
    FCrossCells: TcxObjectList;
    FPrevItem: TcxPivotGridGroupItem;
    FPrevCell: TcxPivotGridCrossCell;
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
    function GetRecordCount: Integer; override;
    function GetValue(ARecordHandle: TcxDataRecordHandle;
      AItemHandle: TcxDataItemHandle): Variant; override;
  public
    constructor Create(ACell: TcxPivotGridCrossCell); virtual;
    destructor Destroy; override;
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
  protected
    function AddSummaryCell(AField: TcxPivotGridField;
      ARecords: TcxPivotGridRecords): TcxPivotGridCrossCellSummary; virtual;
    function CreateCrossRecords: TcxPivotGridRecords;
    procedure DoCalculateSummary; virtual;
    function GetPrevCrossCellInRow: TcxPivotGridCrossCell; virtual;
    function GetPrevCrossCellInColumn: TcxPivotGridCrossCell; virtual;

    property PrevCrossCell: TcxPivotGridCrossCell read FPrevCrossCell write FPrevCrossCell;
    property Calculated: Boolean read FCalculated write FCalculated;
  public
    constructor Create(ARow, AColumn: TcxPivotGridGroupItem); virtual;
    destructor Destroy; override;
    procedure CalculateSummaries;
    function CreateDrillDownDataSource: TcxCustomDataSource; virtual;
    function GetSummaryByField(AField: TcxPivotGridField; ASummaryType: TcxPivotGridSummaryType): Variant;

    property Column: TcxPivotGridGroupItem read FColumn;
    property DataController: TcxCustomDataController read GetDataController;
    property PivotGrid: TcxCustomPivotGrid read GetPivotGrid;
    property Records: TcxPivotGridRecords read FRecords;
    property Row: TcxPivotGridGroupItem read FRow;
    property SummaryCellCount: Integer read GetSummaryCellCount;
    property SummaryCells[AIndex: Integer]: TcxPivotGridCrossCellSummary read GetSummaryCell; default;
  end;

  { TcxPivotGridCrossCellSummary }

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
    procedure CalculateSummaryVariation(APrevCell: TcxPivotGridCrossCellSummary); virtual;
    procedure CheckValue(var AValue: Variant); virtual;
    procedure DoCalculateSummary(ARecords: TcxPivotGridRecords); virtual;
    procedure GetDataTypes(var ASourceType, AFloatType: Integer);
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
    FFields: TcxPivotGridFields;
    FFilteredIndexes: TcxPivotGridRecords;
    FFilterFields: TcxPivotGridFields;
    FPivotGrid: TcxCustomPivotGrid;
    FRowFields: TcxPivotGridFields;
    FRows: TcxPivotGridGroupItem;
    function GetCrossCell(ARow, AColumn: TcxPivotGridGroupItem): TcxPivotGridCrossCell;
  protected
    procedure AddSummaryField(AField: TcxPivotGridField);
    procedure AfterDataChanged;
    procedure ApplyFilter; virtual;
    function CanGroup: Boolean;
    function CanGroupByColumns: Boolean;
    function CanGroupByRows: Boolean;
    procedure Clear; virtual;
    procedure CreateDataCells;
    procedure GroupBy(AFields: TcxPivotGridFields;
      ARoot: TcxPivotGridGroupItem); virtual;
    procedure GroupByColumns; virtual;
    procedure GroupByRows; virtual;
    procedure PopulateRecordsList;
    procedure SplitFieldsByGroups;
  public
    constructor Create(AOwner: TcxCustomPivotGrid);
    destructor Destroy; override;
    procedure DataChanged; virtual;
    property FilteredIndexes: TcxPivotGridRecords read FFilteredIndexes;

    property ColumnFields: TcxPivotGridFields read FColumnFields;
    property Columns: TcxPivotGridGroupItem read FColumns;
    property CrossCells[ARow, AColumn: TcxPivotGridGroupItem]: TcxPivotGridCrossCell read GetCrossCell;
    property Data: TcxPivotGridGroupItem read FData;
    property DataController: TcxCustomDataController read FDataController;
    property DataFields: TcxPivotGridFields read FDataFields;
    property Fields: TcxPivotGridFields read FFields;
    property FilterFields: TcxPivotGridFields read FFilterFields;
    property PivotGrid: TcxCustomPivotGrid read FPivotGrid;
    property RowFields: TcxPivotGridFields read FRowFields;
    property Rows: TcxPivotGridGroupItem read FRows;
  end;

//  Pivot ViewData

  { TcxPivotGridViewDataItem }

  TcxPivotGridViewDataItem = class
  private
    FIndex: Integer;
    FIsDataField: Boolean;
    FItems: TcxObjectList;
    FGroupItem: TcxPivotGridGroupItem;
    FParent: TcxPivotGridViewDataItem;
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
    function GetField: TcxPivotGridField; virtual;
    function GetIsTotal: Boolean; virtual;
    function GetSize: Integer; virtual;
    function GetValue: string; virtual;

    property PivotGrid: TcxCustomPivotGrid read GetPivotGrid;
  public
    constructor Create(AParent: TcxPivotGridViewDataItem; AGroupItem: TcxPivotGridGroupItem); virtual;
    destructor Destroy; override;
    function Add(AData: TcxPivotGridGroupItem): TcxPivotGridViewDataItem;
    function AddTotal(AData: TcxPivotGridGroupItem; AIndex: Integer): TcxPivotGridViewDataItem;
    procedure DeleteChildren;
    function GetGroupItem(var ADataField: TcxPivotGridField): TcxPivotGridGroupItem;
    function GetGroupItemByField(ADataField: TcxPivotGridField): TcxPivotGridGroupItem;
    function GetSummaryType(var ASummaryType: TcxPivotGridSummaryType;
      var ATotal: TcxPivotGridCustomTotal): Boolean;
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
    property Value: string read GetValue;
    property VisibleIndex: Integer read FVisibleIndex;
  end;

  { TcxPivotGridViewDataTotalItem }

  TcxPivotGridViewDataTotalItem = class(TcxPivotGridViewDataItem)
  private
    FTotal: TcxPivotGridCustomTotal;
  protected
    function GetIsTotal: Boolean; override;
    function GetValue: string; override;
    procedure SetTotal(AIndex: Integer);
  public
    property Total: TcxPivotGridCustomTotal read FTotal;
  end;

  { TcxPivotGridViewData }

  TcxPivotGridViewData = class
  private
    FColumnCount: Integer;
    FColumnIndex: Integer;
    FColumns: TcxPivotGridViewDataItem;
    FColumnsPerPage: Integer;
    FExpandColumns: Boolean;
    FExpandRows: Boolean;
    FOwner: TcxCustomPivotGrid;
    FRowCount: Integer;
    FRowIndex: Integer;
    FRows: TcxPivotGridViewDataItem;
    FRowsPerPage: Integer;
    FSelection: TRect;
    function GetCell(ARow, AColumn: Integer): TcxPivotGridCrossCellSummary;
    function GetCellAsText(ARow, AColumn: Integer): string;
    function GetColumn(AIndex: Integer): TcxPivotGridViewDataItem;
    function GetDataBuilder: TcxPivotGridDataBuilder;
    function GetFocusedCell: TPoint;
    function GetOptionsView: TcxPivotGridOptionsView;
    function GetRow(AIndex: Integer): TcxPivotGridViewDataItem;
    function GetSelection: TRect;
    procedure SetColumnIndex(AIndex: Integer);
    procedure SetFocusedCell(const APoint: TPoint);
    procedure SetRowIndex(AIndex: Integer);
    procedure SetSelection(const AValue: TRect);
  protected
    procedure Calculate;
    function CalculateDataWidth(AField: TcxPivotGridField): Integer; 
    procedure CalculateDataFieldInfo(var AFieldIndex: Integer;
      var AFields: TcxPivotGridGroupItem; AcceptedArea: TcxPivotGridDataFieldArea);
    procedure Clear;
    procedure DoNextPage(AGoForward: Boolean);
    function GetItemByIndex(AList: TcxPivotGridViewDataItem;
      AIndex, ACount: Integer): TcxPivotGridViewDataItem;
    procedure ProduceColumns;
    procedure ProduceRows;
    procedure Scroll(AScrollCode: TScrollCode; AItem: TcxPivotGridViewDataItem;
      APage, AMax, ASize, AScrollPos: Integer; var APos: Integer); virtual;
    function ScrollColumns(AScrollCode: TScrollCode; var AScrollPos: Integer): Boolean;
    function ScrollRows(AScrollCode: TScrollCode; var AScrollPos: Integer): Boolean;
    procedure ValidateIndexes;
    procedure ValidateSelection(var ASelection: TRect);
    
    property ExpandColumns: Boolean read FExpandColumns write FExpandColumns;
    property ExpandRows: Boolean read FExpandRows write FExpandRows;
  public
    constructor Create(AOwner: TcxCustomPivotGrid); virtual;
    destructor Destroy; override;
    function MakeSelectionVisible: Boolean;

    property Cells[Row, Column: Integer]: TcxPivotGridCrossCellSummary read GetCell;
    property CellsAsText[Row, Column: Integer]: string read GetCellAsText;
    property ColumnCount: Integer read FColumnCount;
    property ColumnIndex: Integer read FColumnIndex write SetColumnIndex;
    property Columns[AIndex: Integer]: TcxPivotGridViewDataItem read GetColumn;
    property ColumnsPerPage: Integer read FColumnsPerPage write FColumnsPerPage;
    property DataBuilder: TcxPivotGridDataBuilder read GetDataBuilder;
    property FocusedCell: TPoint read GetFocusedCell write SetFocusedCell;
    property OptionsView: TcxPivotGridOptionsView read GetOptionsView;
    property PivotGrid: TcxCustomPivotGrid read FOwner;
    property RowCount: Integer read FRowCount;
    property RowIndex: Integer read FRowIndex write SetRowIndex;
    property Rows[AIndex: Integer]: TcxPivotGridViewDataItem read GetRow;
    property RowsPerPage: Integer read FRowsPerPage write FRowsPerPage;
    property Selection: TRect read GetSelection write SetSelection;
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
    FGroupHeaderHints: Boolean;
  public
    constructor Create(AOwner: TcxCustomPivotGrid); override;
    procedure Assign(Source: TPersistent); override;
  published
    property CellHints: Boolean read FCellHints write FCellHints default False;
    property FieldHeaderHints: Boolean read FFieldHeaderHints write FFieldHeaderHints default True;
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
    FSizing: Boolean;
    FSorting: Boolean;
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
    property Sizing: Boolean index 4 read FSizing write SetValue default True;
    property Sorting: Boolean index 5 read FSorting write SetValue default True;
  end;

  { TcxPivotGridOptionsView }

  TcxPivotGridLines = (pglNone, pglHorz, pglVert, pglBoth);

  TcxPivotGridOptionsView = class(TcxPivotGridCustomOptions, IUnknown, IcxPivotGridSizableObject)
  private
    FColumnFields: Boolean;
    FColumnGrandTotals: Boolean;
    FColumnTotals: Boolean;
    FDataFields: Boolean;
    FDropArrowColor: TColor;
    FFilterDropDownMaxItemCount: Integer;
    FFilterDropDownWidth: Integer;
    FFilterFields: Boolean;
    FFilterSeparator: Boolean;
    FGrandTotalsForSingleValues: Boolean;
    FGrandTotalWidth: Integer;
    FGridLines: TcxPivotGridLines;
    FMarkNarrowCells: Boolean;
    FRowFields: Boolean;
    FRowGrandTotals: Boolean;
    FRowTotals: Boolean;
    FTotalsForSingleValues: Boolean;
    FTotalsLocation: TcxPivotGridTotalsLocation;
    function GetScrollBars: TScrollStyle;
    procedure SetColumnFields(AValue: Boolean);
    procedure SetColumnGrandTotals(AValue: Boolean);
    procedure SetColumnTotals(AValue: Boolean);
    procedure SetDataFields(AValue: Boolean);
    procedure SetFilterDropDownMaxItemCount(AValue: Integer);
    procedure SetFilterDropDownWidth(AValue: Integer);
    procedure SetFilterFields(AValue: Boolean);
    procedure SetFilterSeparator(AValue: Boolean);
    procedure SetGrandTotalWidth(AValue: Integer);
    procedure SetGrandTotalsForSingleValues(AValue: Boolean);
    procedure SetGridLines(AValue: TcxPivotGridLines);
    procedure SetMarkNarrowCells(AValue: Boolean);
    procedure SetRowFields(AValue: Boolean);
    procedure SetRowGrandTotals(AValue: Boolean);
    procedure SetRowTotals(AValue: Boolean);
    procedure SetScrollBars(AValue: TScrollStyle);
    procedure SetTotalsForSingleValues(AValue: Boolean);
    procedure SetTotalsLocation(AValue: TcxPivotGridTotalsLocation);
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
    property ColumnTotals: Boolean read FColumnTotals write SetColumnTotals default True;
    property DataFields: Boolean read FDataFields write SetDataFields default True;
    property DropArrowColor: TColor read FDropArrowColor write FDropArrowColor default cxPivotGridDropArrowColor;
    property FilterDropDownMaxItemCount: Integer read FFilterDropDownMaxItemCount write SetFilterDropDownMaxItemCount default cxPivotGridDropDownMaxItemCount;
    property FilterDropDownWidth: Integer read FFilterDropDownWidth write SetFilterDropDownWidth default cxPivotGridDropDownWidth;
    property FilterFields: Boolean read FFilterFields write SetFilterFields default True;
    property FilterSeparator: Boolean read FFilterSeparator write SetFilterSeparator default True;
    property GrandTotalWidth: Integer read FGrandTotalWidth write SetGrandTotalWidth default 0;
    property GrandTotalsForSingleValues: Boolean read FGrandTotalsForSingleValues write SetGrandTotalsForSingleValues default False;
    property GridLines: TcxPivotGridLines read FGridLines write SetGridLines default pglBoth;
    property MarkNarrowCells: Boolean read FMarkNarrowCells write SetMarkNarrowCells default False;
    property RowFields: Boolean read FRowFields write SetRowFields default True;
    property RowGrandTotals: Boolean read FRowGrandTotals write SetRowGrandTotals default True;
    property RowTotals: Boolean read FRowTotals write SetRowTotals default True;
    property ScrollBars: TScrollStyle read GetScrollBars write SetScrollBars default ssBoth;
    property TotalsForSingleValues: Boolean read FTotalsForSingleValues write SetTotalsForSingleValues default False;
    property TotalsLocation: TcxPivotGridTotalsLocation read FTotalsLocation write SetTotalsLocation default tlFar;
  end;

  { TcxPivotGridOptionsData }

  TcxPivotGridOptionsData = class(TcxPivotGridCustomOptions)
  private
    FAnsiSort: Boolean;
    FSaveExpanding: Boolean;
    FSummaryNullIgnore: Boolean;
    FVariationNullIgnore: Boolean;
    procedure SetAnsiSort(AValue: Boolean);
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
    property SaveExpanding: Boolean read FSaveExpanding write FSaveExpanding default True;
    property SummaryNullIgnore: Boolean read FSummaryNullIgnore write SetSummaryNullIgnore default False;
    property VariationNullIgnore: Boolean read FVariationNullIgnore write SetVariationNullIgnore default True;
  end;

  { TcxPivotGridOptionsSelection }

  TcxPivotGridOptionsSelection = class(TcxPivotGridCustomOptions)
  private
    FHideFocusRect: Boolean;
    FHideSelection: Boolean;
    FMultiSelect: Boolean;
    procedure SetHideFocusRect(AValue: Boolean);
    procedure SetHideSelection(AValue: Boolean);
    procedure SetMultiSelect(AValue: Boolean);
  public
    procedure Assign(Source: TPersistent); override;
  published
    property HideFocusRect: Boolean read FHideFocusRect write SetHideFocusRect default False; 
    property HideSelection: Boolean read FHideSelection write SetHideSelection default False;
    property MultiSelect: Boolean read FMultiSelect write SetMultiSelect default False;
  end;

  { TcxPivotGridCustomCustomizationForm }

  TcxPivotGridCustomCustomizationForm = class(TForm)
  private
    FHookTimer: TcxTimer;
    FPivotGrid: TcxCustomPivotGrid;
    function GetPainter: TcxCustomLookAndFeelPainterClass;
    function GetLookAndFeel: TcxLookAndFeel;
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
    function GetForm: TcxPivotGridCustomCustomizationForm;
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
    property Form: TcxPivotGridCustomCustomizationForm read GetForm;
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
    procedure DoDraw; virtual;
    function ExcludeBorders(const ABounds: TRect; ABorders: TcxBorders): TRect;
    function ExcludeFromPaint(ACanvas: TcxCanvas): Boolean; virtual;
    function GetHitTest(AHitTest: TcxPivotGridHitTest): Boolean; virtual;
    function NeedShowHint(const APoint: TPoint): Boolean; virtual;
    function SetHotTrack(APoint: TPoint): Boolean; virtual;

    property Borders: TcxBorders read FBorders write FBorders;
    property DisplayText: string read FDisplayText write FDisplayText; 
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

  { TcxPivotGridHeaderCellViewInfo }

  TcxPivotGridHeaderCellViewInfo = class(TcxPivotGridCustomCellViewInfo)
  protected
    FAlignHorz: TAlignment;
    FAlignVert: TcxAlignmentVert;
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
    FMultiLine: Boolean;
    FNeighbors: TcxNeighbors;
    FSizeField: TPersistent;
    FShowEndEllipsis: Boolean;
    FSortMarkBounds: TRect;
    FSortOrder: TcxDataSortOrder;
    FState: TcxButtonState;
    FTextBounds: TRect;
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
    property Data: TObject read FData;
  public
    constructor Create(APainter: TcxCustomLookAndFeelPainterClass; const ABounds,
      AVisibleRect: TRect; const AViewParams: TcxViewParams; const ADisplayText: string); reintroduce; overload;

    property AlignHorz: TAlignment read FAlignHorz write FAlignHorz;
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
    function SetHotTrack(APoint: TPoint): Boolean; override;
    function SingleOrLeftMostInGroup: Boolean;
    function SingleOrRightMostInGroup: Boolean;
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

  TcxPivotGridDataCellViewInfo = class(TcxPivotGridCustomCellViewInfo)
  private
    function GetColumnIndex: Integer;
    function GetDisplayFormat: string;
    function GetIsGrandTotal: Boolean;
    function GetIsTotal: Boolean;
    function GetRowIndex: Integer;
  protected
    FAlignment: TAlignment;
    FBorderColor: Integer;
    FCellSummary: TcxPivotGridCrossCellSummary;
    FColumn: TcxPivotGridViewDataItem;
    FCrossCell: TcxPivotGridCrossCell;
    FDataField: TcxPivotGridField;
    FFocusRectStyle: TcxPivotGridFocusRectStyle;
    FIsTotal: Boolean;
    FIsTotalAssigned: Boolean;
    FMarkNarrowCells: Boolean; 
    FRow: TcxPivotGridViewDataItem;
    FSelected: Boolean;
    FSummaryType: TcxPivotGridSummaryType;
    FTextBounds: TRect;
    FTotal: TcxPivotGridCustomTotal;
    FValue: Variant;
    procedure CalculateVisibleInfo; override;
    procedure DoDraw; override;
    procedure FormatDisplayValue;
    function GetHitTest(AHitTest: TcxPivotGridHitTest): Boolean; override;
    function NeedShowHint(const APoint: TPoint): Boolean; override;
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
    property MarkNarrowCells: Boolean read FMarkNarrowCells write FMarkNarrowCells;
    property Row: TcxPivotGridViewDataItem read FRow;
    property RowIndex: Integer read GetRowIndex;
    property Selected: Boolean read FSelected;
    property SummaryType: TcxPivotGridSummaryType read FSummaryType;
    property TextBounds: TRect read FTextBounds;
    property Total: TcxPivotGridCustomTotal read FTotal;
    property Value: Variant read FValue;
  end;

  { TcxPivotGridHeaderBackgroundCellViewInfo }

  TcxPivotGridHeaderBackgroundCellViewInfo = class(TcxPivotGridCustomCellViewInfo)
  protected
    FArea: TcxPivotGridFieldArea;
    FFieldHeadersBounds: TcxRect;
    FHasFields: Boolean;
    procedure DoDraw; override;
    function GetHitTest(AHitTest: TcxPivotGridHitTest): Boolean; override;
  public
    property Area: TcxPivotGridFieldArea read FArea;
    property DisplayText;
    property FieldHeadersBounds: TcxRect read FFieldHeadersBounds;
    property HasFields: Boolean read FHasFields;
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
    FSelection: TRect;
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
    property RowFieldsCount: Integer read GetRowFieldsCount;
    property RowHeaders: TcxPivotGridCells read FRowHeaders;
    property RowHeadersWidth: Integer read FRowHeadersWidth;
    property RowsBounds: TRect read FRowsBounds;
    property Selection: TRect read FSelection;
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
    function GetRowHeaderParams(ARow: TcxPivotGridViewDataItem): TcxViewParams;
  end;

  { TcxPivotGridStyles }

  TcxPivotGridGetContentStyleEvent = procedure(Sender: TcxCustomPivotGrid;
    ACell: TcxPivotGridDataCellViewInfo; var AStyle: TcxStyle) of object;
  TcxPivotGridGetHeaderItemStyleEvent = procedure(Sender: TcxCustomPivotGrid;
    AItem: TcxPivotGridViewDataItem; var AStyle: TcxStyle) of object;
  TcxPivotGridGetFieldHeaderStyleEvent = procedure(Sender: TcxCustomPivotGrid;
    AField: TcxPivotGridField; var AStyle: TcxStyle) of object;

  TcxPivotGridStyles = class(TcxStyles, IcxPivotGridBaseStyles)
  private
    FSuppressContentColoration: Boolean;
    FSuppressBackgroundBitmaps: Boolean;
    FOnGetColumnHeaderStyle: TcxPivotGridGetHeaderItemStyleEvent;
    FOnGetContentStyle: TcxPivotGridGetContentStyleEvent;
    FOnGetFieldHeaderStyle: TcxPivotGridGetFieldHeaderStyleEvent;
    FOnGetRowHeaderStyle: TcxPivotGridGetHeaderItemStyleEvent;
    function GetPivotGrid: TcxCustomPivotGrid;
  protected
    procedure Changed(AIndex: Integer); override;
    procedure CheckViewParams(var AParams: TcxViewParams);
    procedure GetDefaultHeadersAreaViewParams(out AParams: TcxViewParams); virtual;
    procedure GetDefaultViewParams(Index: Integer;
      AData: TObject; out AParams: TcxViewParams); override;

    property SuppressContentColoration: Boolean read FSuppressContentColoration write FSuppressContentColoration;
    property SuppressBackgroundBitmaps: Boolean read FSuppressBackgroundBitmaps write FSuppressBackgroundBitmaps;
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
    function GetBackgroundParams: TcxViewParams;
    function GetColumnHeaderParams(AColumn: TcxPivotGridViewDataItem): TcxViewParams;
    function GetContentParams(ACell: TcxPivotGridDataCellViewInfo): TcxViewParams;
    function GetFieldHeaderParams(AField: TcxPivotGridField): TcxViewParams;
    function GetFilterSeparatorParams: TcxViewParams;
    function GetHeaderBackgroundParams(AArea: TcxPivotGridFieldArea): TcxViewParams;
    function GetRowHeaderParams(ARow: TcxPivotGridViewDataItem): TcxViewParams;
    function GetSelectionParams: TcxViewParams;

    property PivotGrid: TcxCustomPivotGrid read GetPivotGrid;
  published
    property Background: TcxStyle index gs_Background read GetValue write SetValue;
    property ColumnHeader: TcxStyle index gs_ColumnHeader read GetValue write SetValue;
    property ColumnHeaderArea: TcxStyle index gs_ColumnHeaderArea read GetValue write SetValue;
    property Content: TcxStyle index gs_Content read GetValue write SetValue;
    property DataHeaderArea: TcxStyle index gs_DataHeaderArea read GetValue write SetValue;
    property FieldHeader: TcxStyle index gs_FieldHeader read GetValue write SetValue; 
    property FilterHeaderArea: TcxStyle index gs_FilterHeaderArea read GetValue write SetValue;
    property FilterSeparator: TcxStyle index gs_FilterSeparator read GetValue write SetValue;
    property HeaderBackground: TcxStyle index gs_HeaderBackground read GetValue write SetValue;
    property Inactive: TcxStyle index gs_Inactive read GetValue write SetValue;
    property RowHeader: TcxStyle index gs_RowHeader read GetValue write SetValue;
    property RowHeaderArea: TcxStyle index gs_RowHeaderArea read GetValue write SetValue;
    property Selected: TcxStyle index gs_Selected read GetValue write SetValue;
    property Total: TcxStyle index gs_Total read GetValue write SetValue;
    property StyleSheet;
    property OnGetColumnHeaderStyle: TcxPivotGridGetHeaderItemStyleEvent read FOnGetColumnHeaderStyle write FOnGetColumnHeaderStyle;
    property OnGetContentStyle: TcxPivotGridGetContentStyleEvent read FOnGetContentStyle write FOnGetContentStyle;
    property OnGetFieldHeaderStyle: TcxPivotGridGetFieldHeaderStyleEvent read FOnGetFieldHeaderStyle write FOnGetFieldHeaderStyle;
    property OnGetRowHeaderStyle: TcxPivotGridGetHeaderItemStyleEvent read FOnGetRowHeaderStyle write FOnGetRowHeaderStyle;
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
    procedure UpdateControl(AInfo: TcxUpdateControlInfo); override;
    
    property PivotGrid: TcxCustomPivotGrid read GetPivotGrid;
  public
    function GetItem(Index: Integer): TObject; override;
    function GetItemValueSource(AItemIndex: Integer): TcxDataEditValueSource; override;
    function GetItemID(AItem: TObject): Integer; override;
    procedure UpdateData; override;
    procedure UpdateItemIndexes; override;
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

    property HitObject: TcxPivotGridCustomCellViewInfo read FHitObject;
    property HitPoint: TPoint read FHitPoint write SetHitPoint;
    property HitX: Integer index 0 read GetPosValue write SetPosValue;
    property HitY: Integer index 1 read GetPosValue write SetPosValue;
    property PivotGrid: TcxCustomPivotGrid read FOwner;
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

  { TcxPivotGridFilterPopup }

  TcxPivotGridFilterPopup = class(TcxPopupEdit)
  private
    FField: TcxPivotGridField;
    function GetPivotGrid: TcxCustomPivotGrid;
    function GetFilter: TcxPivotGridFieldFilter;
    procedure SetField(AField: TcxPivotGridField);
    procedure SetShowAllState(AValue: TcxCheckBoxState);
    function CreateButton(const ACaption: string; ATag: Integer): TcxButton;
  protected
    FButtonWidth: Integer;
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
    FFilterPopup: TcxPivotGridFilterPopup;
    FHintController: TcxPivotGridHintController;
    FHotTrackController: TcxPivotGridHotTrackController;
    FOwner: TcxCustomPivotGrid;
    FSelectionTimer: TTimer;
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
    SuspendSelectionTimer: Boolean;
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
    procedure SelectionTimerHandler(Sender: TObject);
    procedure SetSelection(ACol, ARow: Integer; AShift: TShiftState);
    procedure SetSelectionInc(const DX, DY: Integer; AShift: TShiftState);
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
    FValues: TcxPivotGridVariantList;
    FWindowSize: TSize;
    function GetHasFilter: Boolean;
    function GetPivotGrid: TcxCustomPivotGrid;
    procedure SetFilterType(AFilterType: TcxPivotGridFilterType);
  protected
    procedure Changed; virtual;
    function GetOwner: TPersistent; override;
    procedure ValuesChanged(ASender: TObject); virtual;

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
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TcxPivotGridField); virtual;
    procedure Assign(Source: TPersistent); override;

    property Field: TcxPivotGridField read FField;
    property PivotGrid: TcxCustomPivotGrid read GetPivotGrid;
    property ValueTypeAssigned: Boolean read FValueTypeAssigned write FValueTypeAssigned;
    property ValueTypeClass: TcxValueTypeClass read GetValueTypeClass write SetValueTypeClass;
  published
    property ValueType: string read GetValueType write SetValueType stored IsValueTypeStored;
  end;

  { TcxPivotGridField }

  TcxPivotGridSummaryVariation = (svNone, svAbsolute, svPercent);

  TcxPivotGridCalculateCustomSummaryEvent = procedure(Sender: TcxPivotGridField;
    ASummary: TcxPivotGridCrossCellSummary) of object;

  TcxPivotGridGetDisplayTextEvent = procedure(Sender: TcxPivotGridField;
    ACell: TcxPivotGridDataCellViewInfo; var AText: string) of object;

  TcxPivotGridGetGroupValueDisplayTextEvent = procedure(Sender: TcxPivotGridField;
    const AGroupValue: Variant; var AText: string) of object;

  TcxPivotGridGetGroupValueEvent = procedure(Sender: TcxPivotGridField;
    ARecordIndex: Integer; var AValue: Variant) of object;

  TcxPivotGridFieldGetGroupImageIndex = procedure(Sender: TcxPivotGridField;
    const AItem: TcxPivotGridViewDataItem; var AImageIndex: Integer;
    var AImageAlignHorz: TAlignment; var AImageAlignVert: TcxAlignmentVert) of object;

  TcxPivotGridField = class(TComponent, IUnknown, IcxPivotGridSizableObject, IcxPivotGridField, IcxStoredObject)
  private
    FAllowedAreas: TcxPivotGridFieldAreas;
    FArea: TcxPivotGridFieldArea;
    FAreaIndex: Integer;
    FCaption: string;
    FCustomTotals: TcxPivotGridCustomTotalCollection;
    FCurrency: Boolean;
    FDataBinding: TcxPivotGridFieldDataBinding;
    FDisplayFormat: string;
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
    FMinWidth: Integer;
    FOptions: TcxPivotGridFieldOptions;
    FPivotGrid: TcxCustomPivotGrid;
    FSortOrder: TcxDataSortOrder;
    FSortBySummaryInfo: TcxPivotGridSortBySummaryInfo;
    FSummaryIndex: Integer;
    FSummaryType: TcxPivotGridSummaryType;
    FSummaryVariation: TcxPivotGridSummaryVariation;
    FTotalsVisibility: TcxPivotGridTotalsVisibility;
    FTopValueCount: Integer;
    FTopValueShowOthers: Boolean;
    FVisible: Boolean;
    FViewInfo: TcxPivotGridFieldHeaderCellViewInfo;
    FWidth: Integer;
    FOnCalculateCustomSummary: TcxPivotGridCalculateCustomSummaryEvent;
    FOnGetDisplayText: TcxPivotGridGetDisplayTextEvent;
    FOnGetGroupImageIndex: TcxPivotGridFieldGetGroupImageIndex;
    FOnGetGroupValue: TcxPivotGridGetGroupValueEvent;
    FOnGetGroupValueDisplayText: TcxPivotGridGetGroupValueDisplayTextEvent;
    function GetActualWidth: Integer;
    function GetController: TcxPivotGridController;
    function GetGroupExpanded: Boolean;
    function GetGroupIndex: Integer;
    function GetGroupValueList: TcxPivotGridVariantList;
    function GetHeaderWidth: Integer;
    function GetIndex: Integer;
    function GetMinWidth: Integer;
    function GetRecordCount: Integer;
    function GetSortedBySummary: Boolean;
    function GetValueByRecordIndex(ARecordIndex: Integer): Variant;
    function GetVisible: Boolean;
    function GetVisibleInGroup: Boolean;
    function IsFirstFieldInGroup: Boolean;
    procedure SetArea(AValue: TcxPivotGridFieldArea);
    procedure SetAreaIndex(AValue: Integer);
    procedure SetCaption(const AValue: string);
    procedure SetCustomTotals(AValue: TcxPivotGridCustomTotalCollection);
    procedure SetDataBinding(AValue: TcxPivotGridFieldDataBinding);
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
    procedure SetOptions(AValue: TcxPivotGridFieldOptions);
    procedure SetSortOrder(AValue: TcxDataSortOrder);
    procedure SetSortBySummaryInfo(AValue: TcxPivotGridSortBySummaryInfo);
    procedure SetSummaryType(AValue: TcxPivotGridSummaryType);
    procedure SetSummaryVariation(AValue: TcxPivotGridSummaryVariation);
    procedure SetTotalsVisibility(AValue: TcxPivotGridTotalsVisibility);
    procedure SetTopValueCount(AValue: Integer);
    procedure SetTopValueShowOthers(AValue: Boolean);
    procedure SetValueByRecordIndex(ARecordIndex: Integer; const AValue: Variant); 
    procedure SetVisible(AValue: Boolean);
    procedure SetWidth(AValue: Integer);
    //
    function IsAllowedAreasStored: Boolean;
    function IsCustomTotalStored: Boolean;
    // IcxPivotGridField
    procedure ChangeExpanding;
    procedure ChangeSorting;
    function GetViewInfo: TcxPivotGridFieldHeaderCellViewInfo;
    procedure SetState(AState: TcxButtonState);
  protected
    function CanDrag: Boolean; virtual;
    function CanDrop(AArea: TcxPivotGridFieldArea): Boolean; virtual;
    function CanModifyArea: Boolean;
    function CanRemove: Boolean; virtual;
    function CanResize: Boolean;
    procedure Changed; virtual;
    procedure DataChanged; virtual;
    procedure DoCalculateCustomSummary(ACell: TcxPivotGridCrossCellSummary); virtual;
    procedure DoGetDisplayText(ACell: TcxPivotGridDataCellViewInfo); virtual;
    function DoGetGroupImageIndex(AItem: TcxPivotGridViewDataItem;
      var AAlignHorz: TAlignment; var AAlignVert: TcxAlignmentVert): Integer; virtual;
    function DoGetGroupValue(const AValue: Variant; ARecordIndex: Integer): Variant; virtual;
    function DoGetGroupValueDisplayText(const AValue: Variant): string; virtual;
    procedure DragDrop(AArea: TcxPivotGridFieldArea; AAreaIndex: Integer); virtual;
    procedure InitGroupValues;
    function IsCurrency(AType: TcxValueTypeClass): Boolean; virtual;
    function GetActualDisplayFormat: string; virtual;
    // grouping
    function CreateCustomTotals: TcxPivotGridCustomTotalCollection; virtual;
    function CreateDataBinding: TcxPivotGridFieldDataBinding; virtual;
    function CreateFilter: TcxPivotGridFieldFilter; virtual;
    function CreateOptions: TcxPivotGridFieldOptions; virtual;
    function CreateSortBySummaryInfo: TcxPivotGridSortBySummaryInfo; virtual;
    procedure CreateSubClasses; virtual;
    procedure DestroySubClasses; virtual;
    procedure GroupCheckExpanding(AGroup: TcxPivotGridGroupItem);
    procedure GroupExpandingChanged(ASender: TcxPivotGridGroupItem); virtual;
    //
    function GetCaption: string; virtual;
    function GetDataBuilder: TcxPivotGridDataBuilder; virtual;
    function GetDisplayTextAssigned: Boolean;
    function IsRecordVisible(ARecordIndex: Integer): Boolean;
    procedure SetAreaIndexInternal(AArea: TcxPivotGridFieldArea; AAreaIndex: Integer);
    procedure SetExpanding(AValue: Boolean);
    procedure SetParentComponent(Value: TComponent); override;
    procedure SetPivotGrid(AValue: TcxCustomPivotGrid);
    // IcxStoredObject
    function GetObjectName: string;
    function GetProperties(AProperties: TStrings): Boolean; virtual;
    function GetPropertyIndex(const AName: string): Integer;
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
    property PivotGrid: TcxCustomPivotGrid read FPivotGrid write SetPivotGrid;
    property RecordCount: Integer read GetRecordCount;
    property SortedBySummary: Boolean read GetSortedBySummary;
    property SummaryIndex: Integer read FSummaryIndex;
    property VisibleInGroup: Boolean read GetVisibleInGroup;
    property Values[ARecordIndex: Integer]: Variant read GetValueByRecordIndex write SetValueByRecordIndex;
  published
    property Area: TcxPivotGridFieldArea read FArea write SetArea default faFilter;
    property AreaIndex: Integer read FAreaIndex write SetAreaIndex default cxPivotGridInvalidIndex;
    property AllowedAreas: TcxPivotGridFieldAreas read FAllowedAreas write FAllowedAreas stored IsAllowedAreasStored;
    property IsCaptionAssigned: Boolean read FIsCaptionAssigned write FIsCaptionAssigned default False;
    property Caption: string read GetCaption write SetCaption stored FIsCaptionAssigned;
    property CustomTotals: TcxPivotGridCustomTotalCollection read FCustomTotals write SetCustomTotals stored IsCustomTotalStored;
    property DataBinding: TcxPivotGridFieldDataBinding read FDataBinding write SetDataBinding;
    property DisplayFormat: string read FDisplayFormat write SetDisplayFormat;
    property Options: TcxPivotGridFieldOptions read FOptions write SetOptions;
    property ImageAlign: TAlignment read FImageAlign write SetImageAlign default taLeftJustify;
    property ImageIndex: TImageIndex read FImageIndex write SetImageIndex default -1;
    property GroupIndex: Integer read GetGroupIndex write SetGroupIndex default -1;
    property GroupExpanded: Boolean read GetGroupExpanded write SetGroupExpanded default True;
    property GroupInterval: TcxPivotGridGroupInterval read FGroupInterval write SetGroupInterval default giDefault;
    property GroupIntervalRange: Integer read FGroupIntervalRange write SetGroupIntervalRange default cxPivotGridDefaultGroupIntervalRange;
    property Hidden: Boolean read FHidden write SetHidden default False;
    property MinWidth: Integer read GetMinWidth write SetMinWidth default cxPivotGridDefaultFieldMinWidth;
    property SummaryType: TcxPivotGridSummaryType read FSummaryType write SetSummaryType default stSum;
    property SortBySummaryInfo: TcxPivotGridSortBySummaryInfo read FSortBySummaryInfo write SetSortBySummaryInfo;
    property SortOrder: TcxDataSortOrder read FSortOrder write SetSortOrder default soNone;
    property SummaryVariation: TcxPivotGridSummaryVariation read FSummaryVariation write SetSummaryVariation default svNone;
    property TotalsVisibility: TcxPivotGridTotalsVisibility read FTotalsVisibility write SetTotalsVisibility default tvAutomatic;
    property TopValueCount: Integer read FTopValueCount write SetTopValueCount default 0;
    property TopValueShowOthers: Boolean read FTopValueShowOthers write SetTopValueShowOthers default False;
    property Visible: Boolean read GetVisible write SetVisible default False;
    property Width: Integer read FWidth write SetWidth default 0;
    //                                                                              
    property OnCalculateCustomSummary: TcxPivotGridCalculateCustomSummaryEvent read FOnCalculateCustomSummary write FOnCalculateCustomSummary;
    property OnGetDisplayText: TcxPivotGridGetDisplayTextEvent read FOnGetDisplayText write FOnGetDisplayText;
    property OnGetGroupImageIndex: TcxPivotGridFieldGetGroupImageIndex read FOnGetGroupImageIndex write FOnGetGroupImageIndex;
    property OnGetGroupValue: TcxPivotGridGetGroupValueEvent read FOnGetGroupValue write FOnGetGroupValue;
    property OnGetGroupValueDisplayText: TcxPivotGridGetGroupValueDisplayTextEvent read FOnGetGroupValueDisplayText write FOnGetGroupValueDisplayText;  
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
  TcxPivotGridFieldPosChangedEvent = procedure(Sender: TcxCustomPivotGrid; AField: TcxPivotGridField) of object;

  TcxCustomPivotGrid = class(TcxControl, IUnknown, IcxStoredParent,
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
    FGroupHeaderImages: TCustomImageList;
    FGroups: TcxPivotGridFieldGroupCollection;
    FHasSummaryVariation: Boolean;
    FHitTest: TcxPivotGridHitTest;
    FImagesListener: TChangeLink;
    FIsLoading: Boolean; 
    FLockCount: Integer;
    FOptionsBehavior: TcxPivotGridOptionsBehavior;
    FOptionsCustomize: TcxPivotGridOptionsCustomize;
    FOptionsData: TcxPivotGridOptionsData;
    FOptionsDataField: TcxPivotGridOptionsDataField;
    FOptionsSelection: TcxPivotGridOptionsSelection;
    FOptionsView: TcxPivotGridOptionsView;
    FPainter: TcxPivotGridPainter;
    FPopupMenus: TcxPivotGridPopupMenus;
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
    FOnFieldPosChanged: TcxPivotGridFieldPosChangedEvent;
    FOnLayoutChanged: TNotifyEvent;
    FOnSelectionChanged: TNotifyEvent;
    function GetFieldCount: Integer;
    function GetField(AIndex: Integer): TcxPivotGridField;
    function GetIsLoading: Boolean;
    function GetIsLocked: Boolean;
    procedure SetField(AIndex: Integer; AValue: TcxPivotGridField);
    procedure SetFieldHeaderImages(AValue: TCustomImageList);
    procedure SetGroupHeaderImages(AValue: TCustomImageList);
    procedure SetGroups(AValue: TcxPivotGridFieldGroupCollection);
    procedure SetImages(var AField: TCustomImageList; ANewValue: TCustomImageList);
    procedure SetOptionsBehavior(AValue: TcxPivotGridOptionsBehavior);
    procedure SetOptionsCustomize(AValue: TcxPivotGridOptionsCustomize);
    procedure SetOptionsData(AValue: TcxPivotGridOptionsData);
    procedure SetOptionsDataField(AValue: TcxPivotGridOptionsDataField);
    procedure SetOptionsSelection(AValue: TcxPivotGridOptionsSelection);
    procedure SetOptionsView(AValue: TcxPivotGridOptionsView);
    procedure SetPopupMenus(AValue: TcxPivotGridPopupMenus);
    procedure SetStyles(AValue: TcxPivotGridStyles);
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
    // IcxStoredParent redirect
    function IcxStoredParent.CreateChild = StoredParent_CreateChild;
    procedure IcxStoredParent.DeleteChild = StoredParent_DeleteChild;
    procedure IcxStoredParent.GetChildren = StoredParent_GetChildren;
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
    procedure DestroySubClasses; virtual;
    procedure DataChanged; virtual;
    function DoShowPopupMenu(AMenu: TComponent; X, Y: Integer): Boolean; override;
    procedure ImagesChangeHandler(Sender: TObject);
    procedure InitScrollBarsParameters; override;

    function GetCursor(X, Y: Integer): TCursor; override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
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
    procedure DoLayoutChanged; virtual;
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
    // IcxStoredObject
    function GetObjectName: string;
    function GetProperties(AProperties: TStrings): Boolean; virtual;
    procedure GetPropertyValue(const AName: string; var AValue: Variant); virtual;
    procedure SetPropertyValue(const AName: string; const AValue: Variant); virtual;
    // IcxStoredParent
    function StoredParent_CreateChild(const AObjectName, AClassName: string): TObject; virtual;
    procedure StoredParent_DeleteChild(const AObjectName: string; AObject: TObject); virtual;
    procedure StoredParent_GetChildren(AChildren: TStringList); virtual;

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
    property OnFieldPosChanged: TcxPivotGridFieldPosChangedEvent read FOnFieldPosChanged write FOnFieldPosChanged;
    property OnLayoutChanged: TNotifyEvent read FOnLayoutChanged write FOnLayoutChanged; 
    property OnSelectionChanged: TNotifyEvent read FOnSelectionChanged write FOnSelectionChanged;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ApplyBestFit;
    procedure BeginUpdate;
    procedure CopyToClipboard(ACopyAll: Boolean = False); virtual;
    function CreateField: TcxPivotGridField; virtual;
    procedure DeleteAllFields;
    procedure EndUpdate;

    procedure FullRefresh;
    function GetFieldByName(const AName: string): TcxPivotGridField;
    procedure LayoutChanged;
    procedure RestoreFromIniFile(const AStorageName: string);
    procedure RestoreFromRegistry(const AStorageName: string);
    procedure RestoreFromStream(AStream: TStream);
    procedure StoreToIniFile(const AStorageName: string; AReCreate: Boolean = True);
    procedure StoreToRegistry(const AStorageName: string; AReCreate: Boolean = True);
    procedure StoreToStream(AStream: TStream);

    property Customization: TcxPivotGridCustomization read FCustomization;
    property DataController: TcxCustomDataController read FDataController;
    property FieldCount: Integer read GetFieldCount;
    property FieldHeaderImages: TCustomImageList read FFieldHeaderImages write SetFieldHeaderImages;
    property Fields[Index: Integer]: TcxPivotGridField read GetField write SetField;
    property Font;
    property GroupHeaderImages: TCustomImageList read FGroupHeaderImages write SetGroupHeaderImages;
    property Groups: TcxPivotGridFieldGroupCollection read FGroups write SetGroups;
    property HitTest: TcxPivotGridHitTest read FHitTest;
    property IsLoading: Boolean read GetIsLoading;
    property LookAndFeel;
    property LookAndFeelPainter;
    property OptionsBehavior: TcxPivotGridOptionsBehavior read FOptionsBehavior write SetOptionsBehavior;
    property OptionsCustomize: TcxPivotGridOptionsCustomize read FOptionsCustomize write SetOptionsCustomize; 
    property OptionsData: TcxPivotGridOptionsData read FOptionsData write SetOptionsData;
    property OptionsDataField: TcxPivotGridOptionsDataField read FOptionsDataField write SetOptionsDataField;
    property OptionsSelection: TcxPivotGridOptionsSelection read FOptionsSelection write SetOptionsSelection;
    property OptionsView: TcxPivotGridOptionsView read FOptionsView write SetOptionsView;
    property PopupMenus: TcxPivotGridPopupMenus read FPopupMenus write SetPopupMenus;
    property Styles: TcxPivotGridStyles read FStyles write SetStyles;
    property SummaryFields: TcxPivotGridFields read FSummaryFields;
    property ViewData: TcxPivotGridViewData read FViewData;
  published
    property PopupMenusEvents: TNotifyEvent read FPopupMenusEvents write FPopupMenusEvents;
    property StylesEvents: TNotifyEvent read FStylesEvents write FStylesEvents;
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

implementation

uses cxTextEdit, cxPivotGridCustomization, cxPivotGridStrs, cxLibraryConsts;

const
  cxInvisiblePos = 30000;

  E_NOINTERFACE = HResult($80004002);

  CustomizationCommand: array[Boolean] of Integer =
    (pgcmShowCustomization, pgcmHideCustomization);

  DataAreaToFieldArea: array[TcxPivotGridDataFieldArea] of TcxPivotGridFieldArea =
    (faFilter, faColumn, faRow);

  FieldProperties: array[0..5] of string  =
    ('SortOrder', 'GroupExpanded', 'Visible', 'Width', 'Area', 'AreaIndex');

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
  I: Integer;
  AItem: TcxPivotGridVariantValue;
begin
  I := 0;
  AItem := nil;
  MakeSorted; 
  while I < Count do
  begin
    if (I > 0) and AItem.IsEqual(Items[I]) then
      Delete(I)
    else
    begin
      AItem := Items[I];
      Inc(I);
    end;
  end;
end;

function TcxPivotGridVariantList.Remove(const AValue: Variant): Integer;
begin
  Result := IndexOf(AValue);
  if Result <> cxPivotGridInvalidIndex then
    Delete(Result);
end;

procedure TcxPivotGridVariantList.Changed;
begin
  if Assigned(FOnChange) then
    OnChange(Self);
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
//    Ite
    if not AItem.Visible then Continue;
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

function TcxPivotGridCells.GetItem(AIndex: Integer): TcxPivotGridCustomCellViewInfo;
begin
  Result := TcxPivotGridCustomCellViewInfo(List^[AIndex]);
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
        if PivotGrid.DataBuilder.FilteredIndexes[ARecord] <> -1 then
           Result.Add(ARecord);
      end;
  end;

var
  I: Integer;
begin
  Result := TcxPivotGridRecords.Create;
  if Parent = nil then  
  begin
    Result.Capacity := DataController.RecordCount;
    for I := 0 to DataController.RecordCount - 1 do
      if PivotGrid.DataBuilder.FilteredIndexes[I] <> -1 then
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
begin
  Result := nil;
  if Level = 0 then
    Result := getPrevSibling
  else
    if Level > 0 then
    begin
      Result := Parent.getPrevSibling;
      if Result <> nil then
        Result := Result.Items[Index];
    end;
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

function TcxPivotGridGroupItem.ChildItemsClass: TcxPivotGridGroupItemClass;
begin
  Result := TcxPivotGridGroupItemClass(Self.ClassType);
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
    if (Field = AField) and (ItemCount > 0) then
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
  finally
    PivotGrid.EndUpdate;
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

function TcxPivotGridGroupItem.GetExpanded: Boolean;
begin
  Result := (ItemCount > 0) and (FExpanded or GetItemAlwaysExpanded);
end;

function TcxPivotGridGroupItem.getNextSibling: TcxPivotGridGroupItem;
begin
  if Index < (Parent.ItemCount - 1) then
    Result := Parent.Items[Index + 1]
  else
    Result := nil;
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
    FExpanded := AValue;
    if Field <> nil then
    begin
      Field.GroupExpandingChanged(Self);
      PivotGrid.Changes := PivotGrid.Changes + [gcLayout];
      PivotGrid.Invalidate; 
    end;
  end;
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
  FCrossCells.Clear;
  FPrevItem := nil;
  FPrevCell := nil;
end;

function TcxPivotGridRowItem.GetCellByCrossItem(
  AItem: TcxPivotGridGroupItem): TcxPivotGridCrossCell;
var
  I: Integer;
  ACellFound: Boolean;
begin
  ACellFound := False;
  Result := FPrevCell;
  if FPrevItem <> AItem then
  begin
    FPrevItem := AItem;
    for I := 0 to FCrossCells.Count - 1 do
    begin
      Result := TcxPivotGridCrossCell(FCrossCells[I]);
      if Result.Column = AItem then
      begin
        FPrevCell := Result;
        ACellFound := True;
        Break;
      end;
    end;
    if not ACellFound then
    begin
      Result := TcxPivotGridCrossCell.Create(Self, AItem);
      FCrossCells.Add(Result);
      FPrevCell := Result;
    end;
  end;
  Result.CalculateSummaries;
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

destructor TcxPivotGridCrossCellDataSource.Destroy;
begin
  FreeAndNil(Records);
  inherited Destroy;
end;

function TcxPivotGridCrossCellDataSource.GetRecordCount: Integer;
begin
  Result := Records.Count;
end;

function TcxPivotGridCrossCellDataSource.GetValue(
  ARecordHandle: TcxDataRecordHandle; AItemHandle: TcxDataItemHandle): Variant;
var
  ARecordIndex: Integer;
  AField: TcxPivotGridField;
begin
  AField := PivotGrid.Fields[GetDefaultItemID(Integer(AItemHandle))];
  ARecordIndex := Records[Integer(ARecordHandle)];
  if AField.GroupInterval = giDefault then
    Result := PivotGrid.DataController.Values[ARecordIndex, AField.Index]
  else
    Result := AField.GetGroupValueDisplayText(AField.GetGroupValue(ARecordIndex));
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
  try
    FSummaryCells.Clear;
    DoCalculateSummary;
  finally
    Calculated := True;
  end;
end;

function TcxPivotGridCrossCell.CreateDrillDownDataSource: TcxCustomDataSource;
begin
  Result := TcxPivotGridCrossCellDataSource.Create(Self);
end;

function TcxPivotGridCrossCell.GetSummaryByField(
  AField: TcxPivotGridField; ASummaryType: TcxPivotGridSummaryType): Variant;
begin
  PivotGridError(AField.SummaryIndex <> cxPivotGridInvalidIndex,
    cxGetResourceString(@scxFieldNotADataField));
  Result := SummaryCells[AField.SummaryIndex].GetSummaryByType(ASummaryType);
end;

function TcxPivotGridCrossCell.AddSummaryCell(AField: TcxPivotGridField;
  ARecords: TcxPivotGridRecords): TcxPivotGridCrossCellSummary;
var
  APrevCell: TcxPivotGridCrossCellSummary;
begin
  Result := PivotGridCrossCellSummaryClass.Create(Self, AField);
  Result.DoCalculateSummary(ARecords);
  if AField.SummaryVariation <> svNone then
  begin
    if PrevCrossCell <> nil then
      APrevCell := PrevCrossCell.SummaryCells[AField.SummaryIndex]
    else
      APrevCell := nil;
    Result.CalculateSummaryVariation(APrevCell);
  end;
  FSummaryCells.Add(Result);
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
  for I := 0 to SummaryCellCount - 1 do
    SummaryCells[I].CalculateCustomSummary;
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

function TcxPivotGridCrossCell.GetSummaryCell(AIndex: Integer): TcxPivotGridCrossCellSummary;
begin
  Result := TcxPivotGridCrossCellSummary(FSummaryCells.List^[AIndex]);
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

function TcxPivotGridCrossCellSummary.GetValue(ARecordIndex: Integer): Variant;
begin
  Result := DataController.Values[ARecordIndex, DataField.Index];
end;

procedure TcxPivotGridCrossCellSummary.CalculateCustomSummary;
begin
  DataField.DoCalculateCustomSummary(Self);
end;

procedure TcxPivotGridCrossCellSummary.CalculateSummaryVariation(
  APrevCell: TcxPivotGridCrossCellSummary);
var
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
              FSummaryVariation := (AValue - APrevValue) * 100 / APrevValue;
              if not VarIsNull(FSummaryVariation) then
                VarCast(FSummaryVariation, FSummaryVariation, varDouble);
            end;
          end;
      end;
    except
      on EInvalidOp do
        FSummaryVariation := Null;
      on EDivByZero do
        FSummaryVariation := Null;
      on EVariantError do
        FSummaryVariation := Null;
    else
      raise;
    end;
  end;
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
  ARecords: TcxPivotGridRecords);
var
  ACount, ANotNumericCount, I, ASourceType, AFloatType: Integer;
  AMinV, AMaxV, ASourceValue: Variant;
  AMin, AMax, ASum, ASumSquares, AValue: Extended;
  AVarianceP, ATotalVariance, AVariance: Extended;
begin
  Clear;
  // initialization
  ASum := 0;
  ACount := 0;
  ANotNumericCount := 0;
  AMinV := Null;
  AMaxV := Null;
  AMax := MinExtended;
  AMin := MaxExtended;
  ASumSquares := 0;
  GetDataTypes(ASourceType, AFloatType);
  // base calculation
  for I := 0 to ARecords.Count - 1 do
  begin
    if DataField.GroupInterval <> giDefault then
    begin
      ASourceValue := DataField.GetGroupValue(ARecords[I]);
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
      ASourceValue := GetValue(ARecords[I]);
    if (DataField.GroupInterval = giDefault) and not VarIsNumericEx(ASourceValue) then
    begin
      Inc(ANotNumericCount);
      if not SummaryNullIgnore or not VarIsNull(ASourceValue) then
        Inc(ACount);
      Continue;
    end;
    CheckValue(ASourceValue);
    AValue := ASourceValue;
    Inc(ACount);
    if AValue > AMax then
      AMax := AValue;
    if AValue < AMin then
      AMin := AValue;
    ASum := ASum + AValue;
    ASumSquares := ASumSquares + Sqr(AValue);
  end;
  // post calculation
  if ACount = 0 then Exit;
  // variance calculation
  ATotalVariance := ASumSquares - Sqr(ASum)/ACount;
  AVarianceP := ATotalVariance / ACount;
  // return calcualted values
  SetSummaryByType(stCount, ACount, varInteger);
  if ANotNumericCount >= ACount then Exit;
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

procedure TcxPivotGridCrossCellSummary.GetDataTypes(var ASourceType, AFloatType: Integer);
var
  AType: TcxValueTypeClass;
const
 OrdinalTypeSet: set of Byte = 
   [varSmallInt, varInteger, varBoolean, varByte
    {$IFDEF DELPHI6}, varWord, varShortInt, varLongWord, varInt64 {$ENDIF}];
begin
  ASourceType := varCurrency;
  AFloatType := varCurrency;
  if DataField <> nil then
  begin
    AType := DataController.GetItemValueTypeClass(DataField.Index);
    if (AType <> nil) and not DataField.IsCurrency(AType) then
    begin
      if AType.GetVarType in OrdinalTypeSet then
        ASourceType := varInteger
      else
        ASourceType := varDouble;
      AFloatType := varDouble;
    end;
  end;
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
  inherited Create;
  FPivotGrid := AOwner;
  FFields := TcxPivotGridFields.Create;
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

procedure TcxPivotGridDataBuilder.DataChanged;
begin
  Clear;          
  PivotGrid.RefreshDate := Date;
  PopulateRecordsList;
  SplitFieldsByGroups;
  ApplyFilter;
  GroupByRows;
  GroupByColumns;
  CreateDataCells;
  AfterDataChanged;
end;

procedure TcxPivotGridDataBuilder.AddSummaryField(
  AField: TcxPivotGridField);
begin
  AField.FSummaryIndex := PivotGrid.SummaryFields.IndexOf(AField);
  if AField.SummaryIndex = cxPivotGridInvalidIndex then
    AField.FSummaryIndex := PivotGrid.SummaryFields.Add(AField);
  with PivotGrid do
    HasSummaryVariation := HasSummaryVariation or (AField.SummaryVariation <> svNone);
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
  ARecordIndex, I: Integer;
  AFilteredList: TcxPivotGridFields;
begin
  AFilteredList := TcxPivotGridFields.Create;
  try
    AFilteredList.Assign(Fields);
    for I := AFilteredList.Count - 1 downto 0 do
    begin
      if (AFilteredList[I].Area = faData) or not AFilteredList[I].Filter.HasFilter then
        AFilteredList.Delete(I);
    end;
    if AFilteredList.Count > 0 then
    begin
      for ARecordIndex := 0 to DataController.RecordCount - 1 do
        for I := 0 to AFilteredList.Count - 1 do
          if not AFilteredList[I].IsRecordVisible(ARecordIndex) then
          begin
            FilteredIndexes[ARecordIndex] := -1;
            Break;
          end;
     end; 
  finally
    AFilteredList.Free;
  end;
end;

function TcxPivotGridDataBuilder.CanGroup: Boolean;
begin
  Result := (DataController.RecordCount > 0) and (DataFields.Count > 0);
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
  FilteredIndexes.Clear;
  Columns.DeleteChildren;
  Rows.DeleteChildren;
  ColumnFields.Clear;
  RowFields.Clear;
  FilterFields.Clear;
  Data.DeleteChildren;
  DataFields.Clear;
  PivotGrid.SummaryFields.Clear;
end;

procedure TcxPivotGridDataBuilder.CreateDataCells;
var
  I: Integer;
  AItem: TcxPivotGridDataItem;
begin
  for I := 0 to DataFields.Count - 1 do
  begin
    AItem := TcxPivotGridDataItem.Create(FData, DataController, -1, DataFields[I]);
    FData.ItemList.Add(AItem);
  end;
end;

procedure TcxPivotGridDataBuilder.GroupBy(AFields: TcxPivotGridFields;
  ARoot: TcxPivotGridGroupItem);
var
  AValue: Variant;
  AParent: TcxPivotGridGroupItem;
  I, J, AIndex, AFieldIndex: Integer;
begin
  for I := 0 to DataController.RecordCount - 1 do
  begin
    AIndex := 0;
    AParent := TcxPivotGridGroupItem(ARoot);
    AFieldIndex := 0;
    if FilteredIndexes[I] = -1 then Continue;
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

procedure TcxPivotGridDataBuilder.PopulateRecordsList;
var
  I: Integer;
begin
  FilteredIndexes.Count := DataController.RecordCount;
  for I := 0 to DataController.RecordCount - 1 do
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
    if AField.VisibleInGroup then
      AFields.Add(AField);
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

function TcxPivotGridDataBuilder.GetCrossCell(
  ARow, AColumn: TcxPivotGridGroupItem): TcxPivotGridCrossCell;
begin
  Result := ARow.GetCellByCrossItem(AColumn);
end;

{ TcxPivotGridDataController }

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

procedure TcxPivotGridDataController.UpdateControl(AInfo: TcxUpdateControlInfo);
begin
  PivotGrid.UpdateControl(AInfo);
end;

function TcxPivotGridDataController.GetPivotGrid: TcxCustomPivotGrid;
begin
  Result := TcxCustomPivotGrid(GetOwner);
end;

{ TcxPivotGridViewDataItem }

constructor TcxPivotGridViewDataItem.Create(
  AParent: TcxPivotGridViewDataItem; AGroupItem: TcxPivotGridGroupItem);
begin
  FGroupItem := AGroupItem;
  FParent := AParent;
  FItems := TcxObjectList.Create;
  FVisibleIndex := -1;
end;

destructor TcxPivotGridViewDataItem.Destroy;
begin
  FItems.Free;
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

procedure TcxPivotGridViewDataItem.DeleteChildren;
begin
  FItems.Clear;
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
  Result := IsTotal and (TcxPivotGridViewDataTotalItem(Self).Total <> nil);
  if Result then
  begin
    ATotal := TcxPivotGridViewDataTotalItem(Self).Total;
    ASummaryType := ATotal.SummaryType;
  end
  else
    if Parent <> nil then
      Result := Parent.GetSummaryType(ASummaryType, ATotal);
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
      if ItemCount > 0 then
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
  Result := not IsTotal and (GroupItem.ItemCount > 0);
end;

function TcxPivotGridViewDataItem.GetHasChildren: Boolean;
begin
  Result := ItemCount > 0;
end;

function TcxPivotGridViewDataItem.GetExpanded: Boolean;
begin
  Result := HasButton and GroupItem.Expanded;
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
  Result := IsTotal and (GroupItem.Parent = nil);
end;

function TcxPivotGridViewDataItem.GetIsTotalItem: Boolean;
var
  AItem: TcxPivotGridViewDataItem;
begin
  Result := IsTotal;
  AItem := Self.Parent; 
  while not Result and (AItem <> nil) do
  begin
    Result := AItem.IsTotal;
    AItem := AItem.Parent;
  end;
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

function TcxPivotGridViewDataTotalItem.GetIsTotal: Boolean;
begin
  Result := True;
end;

function TcxPivotGridViewDataTotalItem.GetValue: string;
begin
  if IsGrandTotal then
    Result := cxGetResourceString(@scxGrandTotal)
  else
  begin
    if Total = nil then
      Result := Format(cxGetResourceString(@scxGroupTotal), [inherited GetValue])
    else
      Result := Format(cxGetResourceString(
        TotalDescriptions[Total.SummaryType]), [inherited GetValue]);
  end;
end;

procedure TcxPivotGridViewDataTotalItem.SetTotal(AIndex: Integer);
begin
  if not IsGrandTotal and (Field.TotalsVisibility = tvCustom) then
    FTotal := Field.CustomTotals[AIndex]; 
end;

{ TcxPivotGridViewData }

constructor TcxPivotGridViewData.Create(AOwner: TcxCustomPivotGrid);
begin
  FOwner := AOwner;
  FRows := TcxPivotGridViewDataItem.Create(nil, DataBuilder.Rows);
  FColumns := TcxPivotGridViewDataItem.Create(nil, DataBuilder.Columns);
end;

destructor TcxPivotGridViewData.Destroy;
begin
  FRows.Free;
  FColumns.Free;
  inherited Destroy;
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

procedure TcxPivotGridViewData.Calculate;
begin
  Clear;
  ProduceColumns;
  ProduceRows;
  ValidateIndexes;
end;

function TcxPivotGridViewData.CalculateDataWidth(AField: TcxPivotGridField): Integer;
var
  ARow, AColumn: TcxPivotGridViewDataItem;
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
      ARow := ARow.GetNextVisible;
    end;
  finally
    AFakeCell.Free;
  end;
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

procedure TcxPivotGridViewData.Clear;
begin
  FRows.DeleteChildren;
  FColumns.DeleteChildren;
end;

procedure TcxPivotGridViewData.DoNextPage(AGoForward: Boolean);
begin
  if AGoForward then
    RowIndex := RowIndex + RowsPerPage
  else
    RowIndex := RowIndex - RowsPerPage;
end;

function TcxPivotGridViewData.GetItemByIndex(AList: TcxPivotGridViewDataItem;
  AIndex, ACount: Integer): TcxPivotGridViewDataItem;

// todo: not optimal recursive algoritm

  function DoFind(AItem: TcxPivotGridViewDataItem;
    var AFoundItem: TcxPivotGridViewDataItem): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    if AItem.VisibleIndex = AIndex then
    begin
      AFoundItem := AItem;
      Result := True;
    end
    else
      if AItem.ItemCount > 0 then
      begin
        for I := 0 to AItem.ItemCount - 1 do
        begin
          Result := DoFind(AItem.Items[I], AFoundItem);
          if Result then Break;
        end;
      end;
  end;

begin
  if not DoFind(AList, Result) then
    Result := nil;
end;

type
  TcxPivotGridItemsProducer = class
  protected
    DataLevel: Integer;
    DataFields: TcxPivotGridGroupItem;
    Dest: TcxPivotGridViewDataItem;
    ItemsCount: Integer;
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
    function IncCount: Integer;
    procedure ProcessItem(AItem: TcxPivotGridGroupItem;
      ALevel: Integer; AParent: TcxPivotGridViewDataItem); virtual;
    function Produce: Integer; virtual;
    function SkipFieldProcessing(AParent: TcxPivotGridViewDataItem; AField: TcxPivotGridField): Boolean;
    function TotalNeeded(AVisible, ASingleVisible: Boolean; AItem: TcxPivotGridGroupItem): Boolean;
  public
    constructor Create(ASource: TcxPivotGridGroupItem;
      ADest: TcxPivotGridViewDataItem; ALocation: TcxPivotGridTotalsLocation;
      ATotals, ASingleTotals, AGrandTotals, ASingleGrandTotals: Boolean);
  end;

constructor TcxPivotGridItemsProducer.Create(ASource: TcxPivotGridGroupItem;
  ADest: TcxPivotGridViewDataItem; ALocation: TcxPivotGridTotalsLocation;
  ATotals, ASingleTotals, AGrandTotals, ASingleGrandTotals: Boolean);
begin
  Dest := ADest;
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
  if (ALevel < 0) and (AItem.ItemCount = 0) then Exit;
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
      AParent.FVisibleIndex := IncCount;
  end;
end;

function TcxPivotGridItemsProducer.AddData(AItem: TcxPivotGridGroupItem;
  ALevel: Integer; AParent: TcxPivotGridViewDataItem): Boolean;
var
  I, J: Integer;
  ADataItem: TcxPivotGridViewDataItem;
  V: Variant;
begin
  Result := (ALevel = DataLevel) or (not AItem.Expanded and
    (AItem.ItemCount > 0) and (DataLevel <> MaxInt) and (DataLevel > ALevel));
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
        ADataItem.FVisibleIndex := IncCount;
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
        ATotal.FVisibleIndex := IncCount;
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
      Result := Result and (DataFields.Items[I].Field.SummaryVariation <> svNone)
end;

function TcxPivotGridItemsProducer.IncCount: Integer;
begin
  Result := ItemsCount;
  Inc(ItemsCount);
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

function TcxPivotGridItemsProducer.Produce: Integer;
begin
  Dest.DeleteChildren;
  VariationFieldsOnly := IsVariationFieldsOnly; 
  ProcessItem(Source, -1, Dest);
  DeleteEmptyItems;
  Result := ItemsCount;
end;

function TcxPivotGridItemsProducer.SkipFieldProcessing(
  AParent: TcxPivotGridViewDataItem; AField: TcxPivotGridField): Boolean;
begin
  Result := (AField.SummaryVariation <> svNone) and
    (AParent.IsGrandTotal or (AParent.Index = 0) or ((AParent.Index = 1) and AParent.IsTotal));
  if Result and AParent.IsGrandTotal then
    Result := (Source.ItemCount > 0) or not VariationFieldsOnly;
end;

function TcxPivotGridItemsProducer.TotalNeeded(
  AVisible, ASingleVisible: Boolean; AItem: TcxPivotGridGroupItem): Boolean;
begin
  Result := AVisible and AItem.Expanded and (AItem.ItemCount > 0) and
    (ASingleVisible or (AItem.ItemCount > 1));
  if not Result then
    Result := (AItem.Level = -1) and (AItem.ItemCount = 0);
end;

procedure TcxPivotGridViewData.ProduceColumns;
var
  AProducer: TcxPivotGridItemsProducer;
begin
  with OptionsView do
  begin
    AProducer := TcxPivotGridItemsProducer.Create(DataBuilder.Columns, FColumns,
      TotalsLocation, ColumnTotals, TotalsForSingleValues,
      ColumnGrandTotals, GrandTotalsForSingleValues);
  end;
  try
    CalculateDataFieldInfo(AProducer.DataLevel, AProducer.DataFields, dfaColumn);
    FColumnCount := AProducer.Produce;
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
    AProducer := TcxPivotGridItemsProducer.Create(DataBuilder.Rows, FRows,
      TotalsLocation, RowTotals, TotalsForSingleValues,
      RowGrandTotals, GrandTotalsForSingleValues);
  end;
  try
    CalculateDataFieldInfo(AProducer.DataLevel, AProducer.DataFields, dfaRow);
    FRowCount := AProducer.Produce;
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
  if FColumnIndex >= FColumnCount then
    FColumnIndex := FColumnCount - 1;
  if FRowIndex >= FRowCount then
    FRowIndex := FRowCount - 1;
end;

procedure TcxPivotGridViewData.ValidateSelection(var ASelection: TRect);
begin
  ASelection.Left := Min(Max(0, ASelection.Left), ColumnCount - 1);
  ASelection.Top := Min(Max(0, ASelection.Top), RowCount - 1);
  if PivotGrid.OptionsSelection.MultiSelect then
  begin
    ASelection.Right := Min(Max(0, ASelection.Right), ColumnCount - 1);
    ASelection.Bottom := Min(Max(0, ASelection.Bottom), RowCount - 1);
  end
  else
    ASelection.BottomRight := ASelection.TopLeft;
end;

function TcxPivotGridViewData.GetCell(
  ARow, AColumn: Integer): TcxPivotGridCrossCellSummary;
var
  ADataField: TcxPivotGridField;
  ACrossCell: TcxPivotGridCrossCell;
  ARowGroup, AColGroup: TcxPivotGridGroupItem;
begin
  ARowGroup := Rows[ARow].GetGroupItem(ADataField);
  AColGroup := Columns[AColumn].GetGroupItem(ADataField);
  if DataBuilder.DataFields.Count = 1 then
    ADataField := DataBuilder.DataFields[0];
  ACrossCell := ARowGroup.GetCellByCrossItem(AColGroup);
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
  Result := GetItemByIndex(FColumns, AIndex, FColumnCount);
end;

function TcxPivotGridViewData.GetDataBuilder: TcxPivotGridDataBuilder;
begin
  Result := PivotGrid.DataBuilder;
end;

function TcxPivotGridViewData.GetFocusedCell: TPoint;
begin
  Result := FSelection.TopLeft;
end;

function TcxPivotGridViewData.GetOptionsView: TcxPivotGridOptionsView;
begin
  Result := PivotGrid.OptionsView;
end;

function TcxPivotGridViewData.GetRow(
  AIndex: Integer): TcxPivotGridViewDataItem;
begin
  Result := GetItemByIndex(FRows, AIndex, FRowCount);
end;

function TcxPivotGridViewData.GetSelection: TRect;
begin
  with FSelection do
  begin
    Result := Rect(Min(Left, Right), Min(Top, Bottom),
      Max(Left, Right), Max(Top, Bottom));
  end;
end;

procedure TcxPivotGridViewData.SetColumnIndex(AIndex: Integer);
begin
  AIndex := Min(FColumnCount - 1, Max(0, AIndex));
  if AIndex <>  FColumnIndex then
  begin
    FColumnIndex := AIndex;
    PivotGrid.ViewChanged;
  end;
end;

procedure TcxPivotGridViewData.SetFocusedCell(const APoint: TPoint);
begin
  if Int64(APoint) <> Int64(FSelection.TopLeft) then
  begin
    FSelection.TopLeft := APoint;
    ValidateSelection(FSelection);
    PivotGrid.SelectionChanged;
  end;
end;

procedure TcxPivotGridViewData.SetRowIndex(AIndex: Integer);
begin
  AIndex := Min(FRowCount - 1, Max(0, AIndex));
  if AIndex <>  FRowIndex then
  begin
    FRowIndex := AIndex;
    PivotGrid.ViewChanged;
  end;
end;

procedure TcxPivotGridViewData.SetSelection(const AValue: TRect);
begin
  if not EqualRect(FSelection, AValue) then
  begin
    FSelection := AValue;
    ValidateSelection(FSelection);
    PivotGrid.SelectionChanged;
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
  FViewParams.Color := ACanvas.Brush.Color;
  FViewParams.TextColor := ACanvas.Font.Color;
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

function TcxPivotGridCustomCellViewInfo.GetHitTest(
  AHitTest: TcxPivotGridHitTest): Boolean;
begin
  CheckVisibleInfo; 
  Result := Visible and PtInRect(ClipRect, AHitTest.HitPoint);
  if Result then
    AHitTest.FHitObject := Self;
end;

function TcxPivotGridCustomCellViewInfo.NeedShowHint(const APoint: TPoint): Boolean;
begin
  Result := False;
end;

function TcxPivotGridCustomCellViewInfo.SetHotTrack(APoint: TPoint): Boolean;
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
  FTextBounds := cxRectInflate(ExcludeBorders(Bounds, Borders), -cxTextOffset, -cxTextOffset);
  if HasButton then
  begin
    with Painter do
    begin
      FButtonRect := cxRectSetSize(FTextBounds, ExpandButtonSize, ExpandButtonSize);
      OffsetRect(FButtonRect, 1, 1);
    end;
    CheckClipping(FButtonRect.Right + cxTextOffset > Bounds.Right - cxTextOffset);
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
  with ViewParams do
  begin 
    Result := (Bitmap <> nil) and not Bitmap.Empty;
    if Result and not Transparent then
      ACanvas.FillRect(ABounds, ViewParams.Bitmap)
    else
      Result := Transparent;
  end;
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
      cxAlignmentsVert[AlignVert] or MultiLines[MultiLine] or
      ShowEndEllipsises[ShowEndEllipsis]);
    Canvas.Brush.Style := bsSolid;
  end;
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
    (cxTextWidth(Font, DisplayText) > cxRectWidth(TextBounds));
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
  Result := cxTextWidth(FViewParams.Font, DisplayText);
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
  APoint: TPoint): Boolean;

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
  if not PtInRect(ClipRect, APoint) then
  begin
    ChangeState(FFilterState, cxbsNormal);
    ChangeState(FState, cxbsNormal);
  end
  else
  begin
    ChangeState(FState, cxbsHot);
    if PtInRect(FFilterBounds, APoint) then
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
  FTextBounds := cxTextRect(ExcludeBorders(Bounds, FBorders));
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
  if (Total = nil) and (DataField.SummaryVariation <> svNone) then
    FValue := CellSummary.SummaryVariation
  else
    FValue := CellSummary.GetSummaryByType(SummaryType);
  FIsTotal := GetIsTotal;
  FAlignment := taRightJustify;
  FormatDisplayValue;
end;

procedure TcxPivotGridDataCellViewInfo.DoDraw;
var
  AFlags: Integer;
const
  AlignHorz: array[TAlignment] of Integer =
    (cxAlignLeft, cxAlignRight, cxAlignHCenter);
begin
  if not Transparent then
    Canvas.FillRect(Bounds, FViewParams, Borders, BorderColor);
  if DisplayText <> '' then
  begin
    Canvas.Brush.Style := bsClear;
    AFlags := AlignHorz[Align] or cxAlignVCenter;
    if MarkNarrowCells and (cxTextWidth(Font, DisplayText) > cxRectWidth(TextBounds)) then
      Canvas.DrawTexT(ReplaceDigitsByPattern(DisplayText), TextBounds, AFlags)
    else
      Canvas.DrawTexT(DisplayText, TextBounds, AFlags);
  end;
  if FocusRectStyle = frsLine then
    Canvas.InvertFrame(ExcludeBorders(Bounds, Borders), 1)
  else
    if FocusRectStyle = frsDot then
    begin
      Canvas.Brush.Style := bsSolid;
      Canvas.DrawFocusRect(ExcludeBorders(Bounds, Borders));
    end;
end;

procedure TcxPivotGridDataCellViewInfo.FormatDisplayValue;
begin
  DataField.DoGetDisplayText(Self);
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
  Result := cxTextWidth(Font, DisplayText) > cxRectWidth(TextBounds);
end;

function TcxPivotGridDataCellViewInfo.ReplaceDigitsByPattern(const ADisplayText: string): string;
begin
  SetLength(Result, Length(ADisplayText));
  FillChar(Result[1], Length(ADisplayText), cxPivotPatternChar);
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

  function IsTotalItem(AItem: TcxPivotGridViewDataItem): Boolean;
  begin
    Result := AItem.IsTotal;
    while not Result and (AItem.Parent <> nil) do
    begin
      AItem := AItem.Parent;
      Result := AItem.IsTotal;
    end;
  end;

begin
  if FIsTotalAssigned then
    Result := FIsTotal
  else
    Result := IsTotalItem(Column) or IsTotalItem(Row);
end;

function TcxPivotGridDataCellViewInfo.GetRowIndex: Integer;
begin
  Result := Row.VisibleIndex;
end;

{ TcxPivotGridHeaderBackgroundCellViewInfo }

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
    FPainter.DrawGroupByBox(FCanvas, FieldHeadersBounds.Rect, FViewParams.Bitmap <> nil, FViewParams.Color,
      FViewParams.Bitmap);
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
  Painter.DrawHeaderSeparator(Canvas, Bounds, IndentSize, ViewParams.TextColor,
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
end;

destructor TcxPivotGridViewInfo.Destroy;
begin
  Clear;
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
end;

procedure TcxPivotGridViewInfo.InvalidateRect(const ARect: TRect);
begin
  PivotGrid.InvalidateRect(ARect, False);
end;

procedure TcxPivotGridViewInfo.SelectionChanged;
var
  I: Integer;
begin
  FSelection := ViewData.Selection;
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
  Result.SetBounds(ABounds, Bounds);
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
    Painter, ABounds, Bounds, AParams);
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
  ABounds := cxRectSetTop(Bounds, ATop, cxPivotGridFilterSeparatorHeight);
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
        if DataBuilder.DataFields[I].SummaryVariation = svNone then
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
  AStyle := Styles.GetValue(AStyleIndex);
  if (AStyle = nil) or not (svFont in AStyle.AssignedValues) then
    Result := PivotGrid.Font
  else
    Result := AStyle.Font;
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
  if IntersectRect(ABounds, ABounds, Bounds) and not IsPrinting then
  begin
    Result := TcxPivotGridCustomCellViewInfo.Create(Painter, ABounds, Bounds, FViewParams);
    CommonCells.Add(Result);
  end;
end;

function TcxPivotGridViewInfo.AddColumnItem(
  ABounds: TRect; AItem: TcxPivotGridViewDataItem): TcxPivotGridHeaderCellViewInfo;
begin
  Result := TcxPivotGridHeaderCellViewInfo.Create(
    Painter, ABounds, ColumnsBounds, BaseStyles.GetColumnHeaderParams(AItem));
  Result.FData := AItem;
  with AItem do
  begin
    Result.Neighbors := GetItemNeighbors(AItem.Level = 0, ABounds.Left <= ColumnsBounds.Left,
      not AItem.HasChildren, AItem.GetNextVisible = nil);
    if not AItem.Expanded and not AItem.HasChildren then
    begin
      Result.FSizeField := AItem.Field;
      if AItem.IsGrandTotal then
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
  Result.FData := AItem;
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
  with Selection do
  begin
    ACell.FSelected := not IsPrinting and not PivotGrid.IsDesigning and (ACell.ColumnIndex >= Left) and
      (ACell.RowIndex >= Top) and (ACell.ColumnIndex <= Right) and (ACell.RowIndex <= Bottom);
  end;
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
    cxTextHeight(GetFont(gs_FieldHeader))), GetIconsSize.cx + cxTextOffset * 2);
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
  ACell.DisplayText := VarToStr(AItem.Value);
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
    if Bottom > Bounds.Bottom then
    begin
      Bottom := Bounds.Bottom;
      ViewData.RowsPerPage := Max(1, ViewData.RowsPerPage - 1);
    end
    else
      AddPartBackground(cxRectSetTop(Bounds, FDataCellsBounds.Bottom));
  end;
  FRowsBounds := cxRectSetLeft(FDataCellsBounds, Bounds.Left, RowHeadersWidth);
  CreateRows(FRowItems);
end;

procedure TcxPivotGridViewInfo.CalculateHitTest(AHitTest: TcxPivotGridHitTest);
begin
  if not FieldHeaders.CalculateHitTest(AHitTest) then
    if not ColumnHeaders.CalculateHitTest(AHitTest) then
      if not RowHeaders.CalculateHitTest(AHitTest) then
        if not CommonCells.CalculateHitTest(AHitTest) then
          DataCells.CalculateHitTest(AHitTest);
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
  FDataCellsBounds := Bounds;
  // row headers
  FRowHeadersWidth := 0;
  for I := 0 to DataBuilder.RowFields.Count - 1 do
    Inc(FRowHeadersWidth, DataBuilder.RowFields[I].GetActualWidth);
  if FRowHeadersWidth = 0 then
    FRowHeadersWidth := OptionsView.GetActualWidth;
  if IsDataFieldVisible([dfaRow]) then
    Inc(FRowHeadersWidth, OptionsDataField.GetActualWidth);
  // cells bounds
  FDataCellsBounds := cxRect(Point(Bounds.Left + RowHeadersWidth,
    Bounds.Top + FilterHeight), Bounds.BottomRight);
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
  AFieldBounds := cxRectSetTop(Bounds, Bounds.Top + cxPivotGridSpace, FFieldHeaderHeight);
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
        Left := Bounds.Left + cxPivotGridHorzSpace;
        Right := Left + AField.HeaderWidth;
        Top := Bottom + cxPivotGridSpace;
        Bottom := Top + FFieldHeaderHeight;
      end;
      Inc(FFilterHeight, FFieldHeaderHeight + cxPivotGridSpace);
      ARowFieldCount := 1;
    end
    else
      Inc(ARowFieldCount);
    AFilterBounds := cxRectSetBottom(Bounds, Bounds.Top + FFilterHeight, FFieldHeaderHeight);
    AddFieldHeader(AFieldBounds, AField, faFilter, I);
    AFieldBounds.Left := AFieldBounds.Right + cxPivotGridHorzSpace;
  end;
  AFilterBounds := cxRectSetHeight(Bounds, FFilterHeight);
  // filter separator cell
  if OptionsView.FilterSeparator then
  begin
    Inc(FFilterHeight, cxPivotGridDoubleSpace + cxPivotGridFilterSeparatorHeight);
    AFilterBounds.Bottom := Bounds.Top + FFilterHeight;
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
  with DataCellsBounds  do
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
    InvalidateRect(ACell.ClipRect);
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
    FSelection := ViewData.Selection;
    FNeedCorrectHeaders := not IsPrinting and
      (Painter.HeaderBorders([nLeft..nBottom]) <> cxBordersAll);
    FDataCellsBounds := Bounds;
    FFieldHeadersBounds.Rect := Bounds;
    CalculateFieldsLayout;
    CalculateColumns;
    CalculateRows;
    FFieldHeadersBounds.Bottom := DataCellsBounds.Top;
    CalculateCells;
    CorrectBackground;
    PivotGrid.NeedUpdateScrollBarsPost := True;
  finally
    PivotGrid.Controller.Update;
  end;
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
  ABounds := cxRectSetTop(Bounds, Bounds.Top + FilterHeight);
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
  ABounds := cxRectSetTop(Bounds, Bounds.Top + FilterHeight,
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
  ABounds := cxRectSetTop(Bounds, Bounds.Top + FilterHeight);
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
    FieldHeaders.Paint(Canvas, DoCustomDrawFieldHeader);
    FieldHeaders.ExcludeFromClipping(Canvas);
    ColumnHeaders.Paint(Canvas, DoCustomDrawColumnHeader);
    CommonCells.Paint(Canvas, DoCustomDrawPart);
    RowHeaders.Paint(Canvas, DoCustomDrawRowHeader);
    DataCells.Paint(Canvas, DoCustomDrawDataCell);
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

{ TcxPivotGridStyles }

constructor TcxPivotGridStyles.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  BitmapInViewParams := True;
end;

procedure TcxPivotGridStyles.Assign(Source: TPersistent);
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

function TcxPivotGridStyles.GetBackgroundParams: TcxViewParams;
begin
  GetViewParams(gs_Background, nil, nil, Result);
  CheckViewParams(Result);
end;

function TcxPivotGridStyles.GetColumnHeaderParams(
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

function TcxPivotGridStyles.GetContentParams(
  ACell: TcxPivotGridDataCellViewInfo): TcxViewParams;
var
  AStyle: TcxStyle;
  ASelParams: TcxViewParams;
const
  AStyleID: array[Boolean] of Integer = (gs_Content, gs_Total);
begin
  AStyle := nil;
  if Assigned(FOnGetContentStyle) then
  begin
    ACell.CheckVisibleInfo;
    FOnGetContentStyle(PivotGrid, ACell, AStyle);
  end;
  if AStyle = nil then
    //todo: optimize get style for fastest working with styles
    GetViewParams(AStyleID[ACell.IsTotal], ACell, nil, Result)
  else
    GetViewParams(AStyleID[ACell.IsTotal], ACell, AStyle, Result);
  if ACell.Selected then
  begin
    ASelParams := GetSelectionParams;
    Result.Bitmap := nil;
    Result.Color := ASelParams.Color;
    Result.TextColor := ASelParams.TextColor;
  end;
  CheckViewParams(Result);
end;

function TcxPivotGridStyles.GetFieldHeaderParams(
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

function TcxPivotGridStyles.GetFilterSeparatorParams: TcxViewParams;
begin
  GetViewParams(gs_FilterSeparator, nil, nil, Result);
  CheckViewParams(Result);
end;

function TcxPivotGridStyles.GetHeaderBackgroundParams(
  AArea: TcxPivotGridFieldArea): TcxViewParams;
const
  AStyleID: array[TcxPivotGridFieldArea] of Integer =
    (gs_ColumnHeaderArea, gs_RowHeaderArea, gs_FilterHeaderArea, gs_DataHeaderArea);
begin
  GetViewParams(AStyleID[AArea], nil, nil, Result);
  CheckViewParams(Result);
end;                                           

function TcxPivotGridStyles.GetRowHeaderParams(
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

function TcxPivotGridStyles.GetSelectionParams: TcxViewParams;
const
  AStyleIndex: array[Boolean] of Integer = (gs_Inactive, gs_Selected);
begin
  GetViewParams(AStyleIndex[PivotGrid.Controller.Focused], nil, nil, Result);
end;

procedure TcxPivotGridStyles.Changed(AIndex: Integer);
begin
  inherited Changed(AIndex);
  if PivotGrid <> nil then
    PivotGrid.LayoutChanged;
end;

procedure TcxPivotGridStyles.CheckViewParams(var AParams: TcxViewParams);
begin
  if SuppressContentColoration then
    AParams.Color := clWindow;
  if SuppressBackgroundBitmaps then
    AParams.Bitmap := nil;
end;

procedure TcxPivotGridStyles.GetDefaultHeadersAreaViewParams(
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

procedure TcxPivotGridStyles.GetDefaultViewParams(Index: Integer;
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
    gs_ColumnHeaderArea, gs_RowHeaderArea, gs_FilterHeaderArea, gs_DataHeaderArea:
      GetDefaultHeadersAreaViewParams(AParams);
    gs_FilterSeparator:
    begin
      AParams.TextColor := APainter.DefaultSeparatorColor;
      AParams.Color := APainter.DefaultHeaderBackgroundColor;
    end;
    gs_Content, gs_Background:
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

function TcxPivotGridStyles.GetPivotGrid: TcxCustomPivotGrid;
begin
  if GetOwner is TcxCustomPivotGrid then
    Result := GetOwner as TcxCustomPivotGrid
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
    FSizing := TcxPivotGridOptionsCustomize(Source).FSizing;
    FSorting := TcxPivotGridOptionsCustomize(Source).FSorting;
    FilterResizable := TcxPivotGridOptionsCustomize(Source).FilterResizable;
  end
  else
    inherited Assign(Source);
end;

procedure TcxPivotGridOptionsCustomize.SetValue(AIndex: Integer; AValue: Boolean);
begin
  case AIndex of
    0:
      SetBoolValue(FFiltering, AValue);
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
    FGridLines := AOptions.GridLines;
    FMarkNarrowCells := AOptions.MarkNarrowCells;
    FRowFields := AOptions.RowFields;
    FRowGrandTotals := AOptions.RowGrandTotals;
    FRowTotals := AOptions.RowTotals;
    FTotalsForSingleValues := AOptions.TotalsForSingleValues;
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

procedure TcxPivotGridOptionsView.SetColumnFields(AValue: Boolean);
begin
  SetBoolValue(FColumnFields, AValue);
end;

procedure TcxPivotGridOptionsView.SetColumnGrandTotals(AValue: Boolean);
begin
  SetBoolValue(FColumnGrandTotals, AValue);
end;

procedure TcxPivotGridOptionsView.SetColumnTotals(AValue: Boolean);
begin
  SetBoolValue(FColumnTotals, AValue);
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

procedure TcxPivotGridOptionsView.SetRowTotals(AValue: Boolean);
begin
  SetBoolValue(FRowTotals, AValue);
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
  AValue: TcxPivotGridTotalsLocation);
begin
  if FTotalsLocation <> AValue then
  begin
    FTotalsLocation := AValue;
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

procedure TcxPivotGridOptionsData.SetSummaryNullIgnore(AValue: Boolean);
begin
  SetBoolValue(FSummaryNullIgnore, AValue);
end;

procedure TcxPivotGridOptionsData.SetVariationNullIgnore(AValue: Boolean);
begin
  SetBoolValue(FVariationNullIgnore, AValue);
end;

{ TcxPivotGridOptionsSelection }

procedure TcxPivotGridOptionsSelection.Assign(Source: TPersistent);
begin
  if Source is TcxPivotGridOptionsSelection then
  begin
    HideFocusRect := TcxPivotGridOptionsSelection(Source).HideFocusRect; 
    HideSelection := TcxPivotGridOptionsSelection(Source).HideSelection;
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

function TcxPivotGridCustomCustomizationForm.GetPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := PivotGrid.LookAndFeelPainter; 
end;

function TcxPivotGridCustomCustomizationForm.GetLookAndFeel: TcxLookAndFeel;
begin
  Result := PivotGrid.LookAndFeel;
end;

procedure TcxPivotGridCustomCustomizationForm.HookTimerHandler(Sender: TObject);
begin
  if IsIconic(Application.Handle) then
    Visible := False
  else
    if not PivotGrid.Visible or not IsWindowVisible(PivotGrid.Handle) then
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
  if Visible then Form.RefreshList;
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
  if (AObject <> nil) and AObject.SetHotTrack(HitTest.HitPoint) then
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
    HintWindow.ActivateHint(R1, HintText);
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
    FHintText := HitTest.HitObject.DisplayText;
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
  FSelectionTimer := TTimer.Create(nil);
end;

destructor TcxPivotGridController.Destroy;
begin
  StopSelectionTimer;
  FHintController.Free;
  FSelectionTimer.Free;
  FHotTrackController.Free;
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
      SetSelectionInc(Navigation[AKey = VK_RIGHT], 0, AShift);
    VK_PRIOR, VK_NEXT:
    begin
      ViewData.DoNextPage(AKey = VK_NEXT);
      SetSelectionInc(0, Navigation[AKey = VK_NEXT] * ViewData.RowsPerPage, AShift);
    end;
    VK_HOME, VK_END:
    begin
      if ssCtrl in AShift then
        SetSelection(MaxInt * Navigation[AKey = VK_END], MaxInt * Navigation[AKey = VK_END], AShift)
      else
        SetSelection(MaxInt * Navigation[AKey = VK_END], FocusedCell.Y, AShift)
    end;
  end;
  case AKey of 
    VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT, VK_PRIOR, VK_NEXT, VK_HOME, VK_END:
      PivotGrid.ViewData.MakeSelectionVisible;
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
      PivotGrid.ViewData.Selection := Rect(0, 0, MaxInt, MaxInt);
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
  end;
  FilterOpenedBeforeClick := False;
  if HitTest.HitAtDataCell and (Button = mbRight) and
    IsCellSelected(HitTest.HitObject as TcxPivotGridDataCellViewInfo) then Exit;
  SuspendSelectionTimer := HitTest.HitAtDataCell;
  if SuspendSelectionTimer then
    MakeCellFocused(TcxPivotGridDataCellViewInfo(HitTest.HitObject), Shift - [ssLeft]);
end;

procedure TcxPivotGridController.MouseLeave;
begin
  Update;
  HotTrackController.Update(HitTest.HitObject);
end;

procedure TcxPivotGridController.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if PivotGrid.DragAndDropState = ddsNone then
  begin
    HotTrackController.Update(HitTest.HitObject);
    if (ssLeft in Shift) and SuspendSelectionTimer then
    begin
      if HitTest.HitAtDataCell then
        MakeCellFocused(TcxPivotGridDataCellViewInfo(HitTest.HitObject), Shift);
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
begin
  SuspendSelectionTimer := False;
  if (DownField <> nil) and not HitTest.HitAtFilter and not FilterOpenedBeforeClick then
    DownField.ChangeSorting;
  for I := 0 to PivotGrid.FieldCount - 1 do
  begin
    if PivotGrid.Fields[I].ViewInfo.State = cxbsPressed then
      PivotGrid.Fields[I].SetState(cxbsNormal);
  end; 
  StopSelectionTimer;
  HintController.Update;
  DownField := nil; 
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
    if Int64(Result) = 0 then
      Result := Size(cxPivotGridFilterPopupDefaultWidth, cxPivotGridFilterPopupDefaultHeight);
  end;
end;

procedure TcxPivotGridController.CheckSelectionTimer(const X, Y: Integer);
var
  R: TRect;
begin
  R := ViewInfo.DataCellsBounds;
  InflateRect(R, -cxPivotGridAutoScrollAreaWidth, -cxPivotGridAutoScrollAreaWidth);
  if not PtInRect(R, Point(X, Y)) and SuspendSelectionTimer then
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
var
  R: TRect; 
begin
  with ViewData.Selection do 
    R := Rect(Min(Left, Right), Min(Top, Bottom), Max(Left, Right), Max(Top, Bottom));
  Result := (ACell.ColumnIndex >= R.Left) and (ACell.RowIndex >= R.Top) and
    (ACell.ColumnIndex <= R.Right) and (ACell.RowIndex <= R.Bottom);
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
  SetSelectionInc(DX, DY, [ssLeft]);
  if (DX <> 0) or (DY <> 0) then
    ViewData.MakeSelectionVisible;
end;

procedure TcxPivotGridController.SetSelection(
  ACol, ARow: Integer; AShift: TShiftState);
var
  R: TRect;
begin
  R := cxRect(Point(ACol, ARow),  PivotGrid.ViewData.FSelection.BottomRight);
  if [ssShift, ssLeft] * AShift = [] then
    R.BottomRight := R.TopLeft;
  ViewData.ValidateSelection(R);
  ViewData.Selection := R;
end;

procedure TcxPivotGridController.SetSelectionInc(
  const DX, DY: Integer; AShift: TShiftState);
begin
  SetSelection(FocusedCell.X + DX, FocusedCell.Y + DY, AShift);
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
  PopupWindow.MinSysPanelHeight := cxPivotGridFilterMinSysPanelHeight;
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
  PivotGrid.BeginUpdate;
  try
    Filter.Clear;
    Filter.FilterType := TcxPivotGridFilterType(AIsInclude);
    for I := 1 to Values.Items.Count - 1 do
      if Values.Items[I].State = AStates[AIsInclude] then
        Filter.Values.Add(GetFieldValueByValueIndex(I));
  finally
    PivotGrid.EndUpdate;
  end;
end;

function TcxPivotGridFilterPopup.AddValue(
  const AValue: TcxPivotGridVariantValue): TcxCheckListBoxItem;
begin
  Result := Values.Items.Add;
  Result.Text := Field.GetGroupValueDisplayText(AValue.Value);
  Result.State := TcxCheckBoxState(not Filter.HasFilter or
    Filter.Contains(AValue.Value));
  Result.ItemObject := AValue;
end;

procedure TcxPivotGridFilterPopup.BeforePopup;
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
end;

procedure TcxPivotGridFilterPopup.ButtonClickHandler(ASender: TObject);
begin
  if TComponent(ASender).Tag = 1 then
    CloseUp(crClose)
  else
    CloseUp(crCancel);
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
  FCancelButton := CreateButton(cxGetResourceString(@scxPivotGridCancel), 0);
  FCancelButton.Cancel := True;
  FOkButton := CreateButton(cxGetResourceString(@scxPivotGridOk), 1);

  FButtonWidth := MulDiv(Max(cxTextWidth(PivotGrid.Font, FOkButton.Caption),
    cxTextWidth(PivotGrid.Font, FCancelButton.Caption)), 3, 2);
  FOkButton.Default := True;
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
    PopupWindow.ViewInfo.GetSysPanelHeight + cxTextOffset * 2;
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
    ShowHourglassCursor;
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
      HideHourglassCursor;
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
  AHeight, ADelta: Integer;
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
  ADelta := FButtonWidth + AHeight div 6;
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
    if ADelta - FButtonWidth < R.Left then
      ADelta := R.Left + FButtonWidth;
  end;

  if PopupWindow.ViewInfo.SizeGripCorner in [coTopLeft, coTopRight] then
    FCancelButton.Anchors := [akTop, akRight]
  else
    FCancelButton.Anchors := [akBottom, akRight];
  FCancelButton.SetBounds(PopupWindow.Width - ADelta,
    (R.Bottom + R.Top - AHeight) div 2 - 1,  FButtonWidth, AHeight);

  if FOkButton <> nil then
  begin
    FOkButton.SetBounds(FCancelButton.Left - (FButtonWidth + (AHeight div 3)),
      FCancelButton.Top, FButtonWidth, AHeight);
    FOkButton.Anchors := FCancelButton.Anchors;
  end;
  InitValues;
end;

procedure TcxPivotGridFilterPopup.UpdateWindowRegion;
var
  AEmptyRgn: HRGN;
begin
  AEmptyRgn := CreateRectRgn(0, 0, 0, 0);
  SetWindowRgn(Handle, AEmptyRgn, True);
  DeleteObject(AEmptyRgn);
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

function TcxPivotGridFilterPopup.CreateButton(
  const ACaption: string; ATag: Integer): TcxButton;
begin
  Result := TcxButton.Create(Self);
  Result.Caption := ACaption;
  Result.Parent := PopupWindow;
  Result.Height := 20;
  Result.Tag := ATag;
  Result.LookAndFeel.MasterLookAndFeel := LookAndFeel;
  Result.OnClick := ButtonClickHandler;
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
  ShowHourglassCursor;
  try
    if not IsSameDropPlace then
    begin
      DragField.DragDrop(AArea, AAreaIndex);
      PivotGrid.Modified;
    end;
  finally
    HideHourglassCursor;
    PivotGrid.EndUpdate;
    if FieldViewInfo.Field is TcxPivotGridField then 
      PivotGrid.DoFieldPosChanged(TcxPivotGridField(FieldViewInfo.Field))
    else
      PivotGrid.DoFieldPosChanged(nil);
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
      PivotGrid.ClientToScreen(Point(0, 0)));
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
  if Field <> nil then
    Field.DataChanged;
end;

function TcxPivotGridFieldFilter.GetOwner: TPersistent;
begin
  Result := Field;
end;

procedure TcxPivotGridFieldFilter.ValuesChanged(ASender: TObject);
begin
  Changed;
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
    Filtering and (Field.Area <> faData);
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
  SetOption(FFiltering, AValue);
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

{ TcxPivotGridFieldDataBinding }

constructor TcxPivotGridFieldDataBinding.Create(AOwner: TcxPivotGridField);
begin
  FField := AOwner;
end;

procedure TcxPivotGridFieldDataBinding.Assign(Source: TPersistent);
begin
  if Source is TcxPivotGridFieldDataBinding then
    ValueType := TcxPivotGridFieldDataBinding(Source).ValueType
  else
    inherited Assign(Source);
end;

function TcxPivotGridFieldDataBinding.GetOwner: TPersistent;
begin
  Result := FField;
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
end;

destructor TcxPivotGridField.Destroy;
begin
  Group := nil;
  PivotGrid := nil;
  DestroySubClasses;
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
  end;
end;

procedure TcxPivotGridField.ApplyBestFit;
var
  AWidth, I: Integer;
begin
  if not VisibleInGroup or (Area = faFilter) then Exit;
  PivotGrid.CheckChanges;
  ShowHourglassCursor;
  try
    AWidth := MinWidth;
    if (Area = faRow) or ((Area = faData) and (PivotGrid.OptionsDataField.Area = dfaRow)) then
    begin
      AWidth := Max(ViewInfo.MeasureWidth + cxTextOffset * 2,
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
  finally
    HideHourglassCursor;
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
        Result := WeekOfTheYear(VarToDateTime(Result));
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
        Result := LongDayNames[Integer(AGroupValue)];
      giDateMonth:
        Result := LongMonthNames[Integer(AGroupValue)];
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

procedure TcxPivotGridField.Changed;
begin
  if PivotGrid <> nil then
  begin
    PivotGrid.LayoutChanged;
    PivotGrid.Customization.Refresh;
  end;
end;

procedure TcxPivotGridField.DataChanged;
begin
  if PivotGrid <> nil then
  begin
    PivotGrid.DataChanged;
    PivotGrid.Customization.Refresh;
  end;
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
    (ACell.Total = nil) and (SummaryVariation = svPercent));
  if GetDisplayTextAssigned then
    FOnGetDisplayText(Self, ACell, ACell.FDisplayText);
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

procedure TcxPivotGridField.InitGroupValues;
var
  I: Integer;
begin
  if FGroupValuesValid then Exit;
  FGroupValueList.Clear;
  for I := 0 to RecordCount - 1 do
    FGroupValueList.Add(GetGroupValue(I));
  FGroupValueList.MakeUnique;
  FGroupValuesValid := True; 
end;

function TcxPivotGridField.IsCurrency(AType: TcxValueTypeClass): Boolean;
begin
  Result := (AType = TcxCurrencyValueType) {$IFDEF DELPHI6} or (AType = TcxFMTBcdValueType) {$ENDIF};
end;

function TcxPivotGridField.GetActualDisplayFormat: string; 
begin
  Result := FDisplayFormat; 
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

procedure TcxPivotGridField.CreateSubClasses;
begin
  FDataBinding := CreateDataBinding;
  FExpandingInfo := TcxPivotGridVariantList.Create();
  FViewInfo := TcxPivotGridFieldHeaderCellViewInfo.CreateEx(Self);
  FCustomTotals := CreateCustomTotals;
  FFilter := CreateFilter;
  FOptions := CreateOptions;
  FSortBySummaryInfo := CreateSortBySummaryInfo;
  FGroupValueList := TcxPivotGridVariantList.Create;
end;

procedure TcxPivotGridField.DestroySubClasses;
begin
  FreeAndNil(FGroupValueList);
  FreeAndNil(FCustomTotals);
  FreeAndNil(FFilter);
  FreeAndNil(FViewInfo);
  FreeAndNil(FOptions);
  FreeAndNil(FSortBySummaryInfo);
  FreeAndNil(FExpandingInfo);
  FreeAndNil(FDataBinding);
end;

procedure TcxPivotGridField.GroupCheckExpanding(
  AGroup: TcxPivotGridGroupItem);
begin
  AGroup.Expanded := (ExpandingInfo.Count = 0) or
    (ExpandingInfo.IndexOf(AGroup.Value) = -1);
end;

procedure TcxPivotGridField.GroupExpandingChanged(
  ASender: TcxPivotGridGroupItem);
begin
  if not PivotGrid.OptionsData.SaveExpanding then Exit;
  if ASender.Expanded then
    ExpandingInfo.Remove(ASender.Value)
  else
    ExpandingInfo.AddUnique(ASender.Value);
end;

function TcxPivotGridField.GetCaption: string;
begin
  if FIsCaptionAssigned then
    Result := FCaption
  else
    Result := Name;
end;

function TcxPivotGridField.GetDataBuilder: TcxPivotGridDataBuilder;
begin
  Result := nil;
end;

function TcxPivotGridField.GetDisplayTextAssigned: Boolean;
begin
  Result := Assigned(FOnGetDisplayText);
end;

function TcxPivotGridField.IsRecordVisible(ARecordIndex: Integer): Boolean;
begin
  Result := (Area = faData) or not Filter.HasFilter or
    Filter.Contains(GetGroupValue(ARecordIndex));
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
      if Area = faRow then
        PivotGrid.DataBuilder.Rows.SetFieldExpanding(Self, AValue)
      else
        if Area = faColumn then
          PivotGrid.DataBuilder.Columns.SetFieldExpanding(Self, AValue);
      PivotGrid.LayoutChanged;
    finally
      PivotGrid.EndUpdate;
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
  end;
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
  for I := 0 to High(FieldProperties) do
    AProperties.Add(FieldProperties[I]);
  Result := True;
end;

function TcxPivotGridField.GetPropertyIndex(
  const AName: string): Integer;
var
  I: Integer;
begin
  for I := 0 to High(FieldProperties) do
    if SameText(FieldProperties[I], AName) then
    begin
      Result := I;
      Exit;
    end;
  Result := -1;
end;

procedure TcxPivotGridField.GetPropertyValue(
  const AName: string; var AValue: Variant);
begin
  PivotGridError(False, scxNotImplemented);
end;

procedure TcxPivotGridField.SetPropertyValue(
  const AName: string; const AValue: Variant);
begin
  PivotGridError(False, scxNotImplemented);
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

function TcxPivotGridField.GetIndex: Integer;
begin
  Result := PivotGrid.FieldList.IndexOf(Self)
end;

function TcxPivotGridField.GetMinWidth: Integer;
begin
  Result := FMinWidth; 
end;

function TcxPivotGridField.GetRecordCount: Integer;
begin
  Result := PivotGrid.DataController.RecordCount; 
end;

function TcxPivotGridField.GetSortedBySummary: Boolean;
begin
  Result := SortBySummaryInfo.ValidateProperties;
end;

function TcxPivotGridField.GetValueByRecordIndex(ARecordIndex: Integer): Variant;
begin
  Result := PivotGrid.DataController.Values[ARecordIndex, Index];
end;

function TcxPivotGridField.GetVisible: Boolean;
begin
  Result := FVisible;
end;

function TcxPivotGridField.GetVisibleInGroup: Boolean;
begin
  Result := FVisible and ((Group = nil) or (Group.IsFieldVisible(Self)));
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
    if PivotGrid.IsLoading and IsFirstFieldInGroup then
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
  if Group = AValue then Exit;
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

procedure TcxPivotGridField.SetOptions(AValue: TcxPivotGridFieldOptions);
begin
  FOptions.Assign(AValue);
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

procedure TcxPivotGridField.SetSummaryType(AValue: TcxPivotGridSummaryType);
begin
  if FSummaryType <> AValue then
  begin
    FSummaryType := AValue;
    DataChanged;
  end;
end;

procedure TcxPivotGridField.SetSummaryVariation(
  AValue: TcxPivotGridSummaryVariation);
begin
  if AValue <> FSummaryVariation then
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

procedure TcxPivotGridField.SetValueByRecordIndex(
  ARecordIndex: Integer; const AValue: Variant);
begin
  PivotGrid.DataController.Values[ARecordIndex, Index] := AValue;
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
    Changed;
  end;
end;

function TcxPivotGridField.IsAllowedAreasStored: Boolean;
begin
  Result := FAllowedAreas <> [faColumn..faData] 
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
      ShowHourglassCursor;
      try
        SortOrder := InvertedSortOrders[SortOrder];
      finally
        HideHourglassCursor;
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
begin
  inherited DoExecute(ACommand);
  case ACommand of
    pgcmExpand, pgcmCollapse:
      GroupItem.Expanded := not GroupItem.Expanded;
    pgcmExpandAll, pgcmCollapseAll:
      GroupItem.Parent.SetFieldExpanding(GroupItem.Field, ACommand = pgcmExpandAll);
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
  begin
    CreateSubItem(Root, cxGetResourceString(scxCustomization[Visible]),
      CustomizationCommand[Visible], PivotGrid.OptionsCustomize.QuickCustomization);
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
    if HitTest.HitAtGroupHeader and (HitTest.GroupItem <> nil) and (HitTest.GroupItem.ItemCount > 0) then
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
  PivotGrid.OptionsView.Assign(FSavedOptionsView);
  PivotGrid.Styles.Assign(FSavedStyles);
  PivotGrid.Changes := PivotGrid.Changes + [gcLayout];
  PivotGrid.EndUpdate;
  FSavedStyles.Free;
  FSavedOptionsView.Free;
end;

procedure TcxPivotGridExportController.Initialize;
begin
  FSavedOptionsView := PivotGrid.CreateOptionsView;
  FSavedOptionsView.Assign(PivotGrid.OptionsView);
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
  EndUpdate;
end;

destructor TcxCustomPivotGrid.Destroy;
begin
  Inc(FLockCount);
  if DesignerHelper <> nil then
    DesignerHelper.RemoveListener(Self);
  Customization.Visible := False; 
  DestroySubClasses;
  inherited Destroy;
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
  ACopyToClipboardStr, ARowStr: string;
const
  CRLF: string = #13#10;
  SEPARATOR: string = #9;
begin
  ACopyToClipboardStr := '';
  if ACopyAll then
    ACopyRect := Rect(0, 0, MaxInt, MaxInt)
  else
    ACopyRect := ViewData.Selection;
  with ACopyRect do
  begin
    BottomRight := Point(Min(Right, ViewData.ColumnCount - 1),
      Min(Bottom, ViewData.RowCount - 1));
  end;
  ShowHourglassCursor;
  try
    for ARow := ACopyRect.Top to ACopyRect.Bottom do
    begin
      ARowStr := '';
      for AColumn := ACopyRect.Left to ACopyRect.Right do
      begin
        ARowStr := ARowStr + ViewData.CellsAsText[ARow, AColumn];
        if AColumn <> ACopyRect.Right then
          // if not right most column need add column separator
          ARowStr := ARowStr + SEPARATOR;
      end;
      // if not last row need add row separator
      if ARow <> ACopyRect.Bottom then
        ARowStr := ARowStr + CRLF;
      ACopyToClipboardStr := ACopyToClipboardStr + ARowStr;
    end;
    Clipboard.AsText := ACopyToClipboardStr;
  finally
    HideHourglassCursor;
  end;
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
  BeginUpdate;
  try
    for I := 0 to FieldList.Count - 1 do
      TObject(FieldList.Last).Free;
  finally
    EndUpdate;
  end;
end;

procedure TcxCustomPivotGrid.EndUpdate;
begin
  Dec(FLockCount);
  if DataController.LockCount > 0 then
    DataController.EndUpdate;
  CheckChanges;
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

procedure TcxCustomPivotGrid.RestoreFromIniFile(const AStorageName: string);
var
  AStorage: TcxStorage;
begin
  AStorage := TcxStorage.Create(AStorageName);
  try
    BeginUpdate;
    try
      FIsLoading := True;
      AStorage.RestoreFromIni(Self);
    finally
      FIsLoading := False;
      EndUpdate;
    end;
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomPivotGrid.RestoreFromRegistry(const AStorageName: string);
var
  AStorage: TcxStorage;
begin
  AStorage := TcxStorage.Create(AStorageName);
  try
    BeginUpdate;
    try
      FIsLoading := True;
      AStorage.RestoreFromRegistry(Self);
    finally
      FIsLoading := False;
      EndUpdate;
    end;
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomPivotGrid.RestoreFromStream(AStream: TStream);
var
  AStorage: TcxStorage;
begin
  AStorage := TcxStorage.Create(AStream);
  try
    BeginUpdate;
    try
      if AStream.Position = AStream.Size then
        AStream.Position := 0;
      FIsLoading := True;
      AStorage.RestoreFromStream(Self);
    finally
      FIsLoading := False;
      EndUpdate;
    end;
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomPivotGrid.StoreToIniFile(
  const AStorageName: string; AReCreate: Boolean = True);
var
  AStorage: TcxStorage;
begin
  AStorage := TcxStorage.Create(AStorageName);
  try
    BeginUpdate;
    try
      AStorage.ReCreate := ARecreate;
      AStorage.StoreToIni(Self);
      AStorage.ReCreate := False;
    finally
      EndUpdate;
    end;
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomPivotGrid.StoreToRegistry(
  const AStorageName: string; AReCreate: Boolean = True);
var
  AStorage: TcxStorage;
begin
  AStorage := TcxStorage.Create(AStorageName);
  try
    BeginUpdate;
    try
      AStorage.ReCreate := ARecreate;
      AStorage.StoreToRegistry(Self);
      AStorage.ReCreate := False;
    finally
      EndUpdate;
    end;
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomPivotGrid.StoreToStream(AStream: TStream);
var
  AStorage: TcxStorage;
begin
  AStorage := TcxStorage.Create(AStream);
  try
    BeginUpdate;
    try
      AStorage.StoreToStream(Self);
      AStorage.ReCreate := False;
    finally
      EndUpdate;
    end;
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomPivotGrid.AddField(AField: TcxPivotGridField);
begin
  if IsDestroying then Exit;
  FieldList.Add(AField);
  DataBuilder.DataController.AddItem(AField);
  DataChanged;
  Customization.Refresh;
end;

procedure TcxCustomPivotGrid.RemoveField(AField: TcxPivotGridField);
begin
  if IsDestroying then Exit;
  DataController.BeginUpdate;
  try
    DataController.RemoveItem(AField);
    FFields.Remove(AField);
  finally
    DataController.EndUpdate;
  end;
  DataChanged;
  Customization.Refresh;
end;

procedure TcxCustomPivotGrid.BeforeMouseDown(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Controller.BeforeMouseDown(Button, Shift, X, Y);
  inherited BeforeMouseDown(Button, Shift, X, Y);
end;

procedure TcxCustomPivotGrid.BoundsChanged;
begin
  LayoutChanged;
  inherited BoundsChanged;
end;

function TcxCustomPivotGrid.CanRetrieveFields(var AIsActive: Boolean): Boolean;
begin
  Result := False;
  AIsActive := False;
end;

procedure TcxCustomPivotGrid.CheckChanges;
begin
  if IsLocked then Exit;
  try
    FCustomSortAssigned := Assigned(FOnCompare);
    if Changes <> [] then
      Controller.Clear;
    if gcData in Changes then
    begin
      DataBuilder.DataChanged;
      Changes := [gcLayout];
    end;
    if gcLayout in Changes then
    begin
      ViewData.Calculate;
      Changes := Changes + [gcView];
    end;
    if Changes <> [] then
      DoLayoutChanged;
    if gcView in Changes then
    begin
      ViewInfo.Calculate;
      Invalidate;
    end;
    Controller.Update;
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
  FImagesListener := TChangeLink.Create;
  FImagesListener.OnChange := ImagesChangeHandler;
  FGroups := CreateGroups;
  FOptionsView := CreateOptionsView;
  FController := CreateController;
  FCustomization := CreateCustomization;
  FFields := TcxObjectList.Create;
  FDataController := CreateDataController;
  FDataBuilder := CreateDataBuilder;
  FViewInfo := CreateViewInfo;
  FViewData := CreateViewData;
  FPainter := CreatePainter;
  FOptionsCustomize := CreateOptionsCustomize;
  FOptionsBehavior := CreateOptionsBehavior;
  FOptionsData := CreateOptionsData;
  FOptionsDataField := CreateOptionsDataField;
  FOptionsSelection := CreateOptionsSelection;
  FPopupMenus := CreatePopupMenus;
  FStyles := CreateStyles;
  FSummaryFields := TcxPivotGridFields.Create;
  FHitTest := CreateHitTest;
end;

procedure TcxCustomPivotGrid.DestroySubClasses;
begin
  FieldHeaderImages := nil;
  GroupHeaderImages := nil;
  FViewInfo.FBaseStyles := nil;
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
  FreeAndNil(FOptionsSelection);
  FreeAndNil(FOptionsView);
  FreeAndNil(FPopupMenus);
  FreeAndNil(FHitTest);
  FreeAndNil(FController);
  FreeAndNil(FCustomization);
  FreeAndNil(FGroups);
  FreeAndNil(FImagesListener);
end;

procedure TcxCustomPivotGrid.DataChanged;
begin
  ClearCacheInformation;
  Changes := Changes + [gcData];
  if IsLocked then Exit;
  CheckChanges;
end;

function TcxCustomPivotGrid.DoShowPopupMenu(
  AMenu: TComponent; X, Y: Integer): Boolean;
begin
  Result := PopupMenus.DoShowPopupMenu(Point(X, Y));
  if not Result then
    Result := inherited DoShowPopupMenu(AMenu, X, Y);
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

procedure TcxCustomPivotGrid.ImagesChangeHandler(Sender: TObject);
begin
  LayoutChanged; 
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

procedure TcxCustomPivotGrid.DoLayoutChanged;
begin
  if Assigned(OnLayoutChanged) then
    FOnLayoutChanged(Self);
end;

procedure TcxCustomPivotGrid.DoSelectionChanged;
begin
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
  HitTest.HitPoint := Point(X, Y);
  Controller.MouseMove(Shift, X, Y);
  inherited MouseMove(Shift, X, Y);
end;

procedure TcxCustomPivotGrid.MouseUp(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
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
     ViewInfo.SelectionChanged
   else
    Changes := Changes + [gcLayout];
  DoSelectionChanged;
end;

function TcxCustomPivotGrid.SetFieldAreaIndex(AField: TPersistent;
  AArea: TcxPivotGridFieldArea; var AIndex: Integer): Boolean;
var
  I: Integer;
  AFields: TcxObjectList;
  ANewField: TcxPivotGridField;
  APosInfo: TcxPivotGridFieldPosition;
begin
  Result := not IsLoading;
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
end;

procedure TcxCustomPivotGrid.DoCreateAllFields;
begin
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
end;

procedure TcxCustomPivotGrid.UpdateControl(AInfo: TcxUpdateControlInfo);
begin
//  if (AInfo is TcxDataChangedInfo) or (AInfo is TcxUpdateRecordInfo) then
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

// IcxStoredObject
function TcxCustomPivotGrid.GetObjectName: string;
begin
  Result := Name;
end;

function TcxCustomPivotGrid.GetProperties(AProperties: TStrings): Boolean;
begin
  Result := True;
end;

procedure TcxCustomPivotGrid.GetPropertyValue(
  const AName: string; var AValue: Variant);
begin
end;

procedure TcxCustomPivotGrid.SetPropertyValue(
  const AName: string; const AValue: Variant);
begin
end;

// IcxStoredParent
function TcxCustomPivotGrid.StoredParent_CreateChild(
  const AObjectName, AClassName: string): TObject;
begin
  if AClassName = GetFieldClass.ClassName then
  begin
    Result := CreateField;
    TcxPivotGridField(Result).Name := AObjectName;
  end
  else
    Result := nil;
end;

procedure TcxCustomPivotGrid.StoredParent_DeleteChild(
  const AObjectName: string; AObject: TObject);
begin
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

function TcxCustomPivotGrid.GetIsLoading: Boolean;
begin
  Result := inherited IsLoading or FIsLoading;
end;

function TcxCustomPivotGrid.GetIsLocked: Boolean;
begin
  Result := IsLoading or IsDestroying;
  if not Result then
    Result := FLockCount <> 0;
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

initialization
  crcxPivotGridArrow := crArrow;
  crcxPivotGridHorzSize := crcxHorzSize;
  crcxPivotGridNoDrop := crcxNoDrop;
  crcxPivotGridRemove := crcxRemove;

finalization

end.

