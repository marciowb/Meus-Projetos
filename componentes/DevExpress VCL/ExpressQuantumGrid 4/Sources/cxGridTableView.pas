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

unit cxGridTableView;

{$I cxGridVer.inc}

interface

uses
  Windows, Messages,
  Classes, Graphics, Controls, ImgList, Forms, Buttons, StdCtrls, ExtCtrls, ComCtrls,
  cxClasses, cxControls, cxGraphics, cxLookAndFeelPainters, cxStyles, cxListBox,
  cxStorage,
  cxContainer, cxEdit,
  cxGrid, cxGridCommon, cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridViewData,
  cxCustomData, cxFilter, cxData, cxDataStorage;

const
  htGridBase = 200;
  htGroupByBox = htGridBase + 1;
  htColumnHeader = htGridBase + 2;
  htColumnHeaderHorzSizingEdge = htGridBase + 3;
  htColumnHeaderFilterButton = htGridBase + 4;
  htFooter = htGridBase + 5;
  htFooterCell = htGridBase + 6;
  htGroupFooter = htGridBase + 7;
  htGroupFooterCell = htGridBase + 8;
  htFilter = htGridBase + 9;
  htFilterActivateButton = htGridBase + 10;
  htFilterCloseButton = htGridBase + 11;
  htFilterCustomizeButton = htGridBase + 12;
  htRowIndicator = htGridBase + 13;
  htRowSizingEdge = htGridBase + 14;
  htIndicator = htGridBase + 15;
  htRowLevelIndent = htGridBase + 16;
  htCustomizationForm = htGridBase + 17;
  htHeader = htGridBase + 18;

  ccNone = 0;
  ccHeader = 1;
  ccGroupByBox = 2;
  ccCustomizationForm = 3;
  ccFooter = 4;

  cxGridCustomizationFormDefaultWidth = 180;
  cxGridCustomizationFormDefaultHeight = 300;

  cxGridDefaultIndicatorWidth = 12;

  cxGridDefaultNewItemRowSeparatorWidth = 6;
  cxGridMinNewItemRowSeparatorWidth = 2;

  cxGridTableFilterDefaultMaxDropDownCount = 15;

  cxGridPreviewDefaultLeftIndent = 20;
  cxGridPreviewDefaultMaxLineCount = 3;
  cxGridPreviewDefaultRightIndent = 5;

  cxGridHeaderSizingEdgeSize = 8;
  cxGridRowSizingEdgeSize = 8;

  isColumnFirst = isCustomItemLast + 1;
  isFooter = isColumnFirst;
  isHeader = isColumnFirst + 1;
  isColumnLast = isHeader;

  bbTableFirst = bbCustomTableLast + 1;
  bbFilterBox = bbTableFirst;
  bbFooter = bbTableFirst + 1;
  bbHeader = bbTableFirst + 2;
  bbGroup = bbTableFirst + 3;
  bbGroupByBox = bbTableFirst + 4;
  bbIndicator = bbTableFirst + 5;
  bbPreview = bbTableFirst + 6;
  bbTableLast = bbPreview;

  vsTableFirst = vsCustomTableLast + 1;
  vsFilterBox = vsTableFirst;
  vsFooter = vsTableFirst + 1;
  vsGroup = vsTableFirst + 2;
  vsGroupByBox = vsTableFirst + 3;
  vsHeader = vsTableFirst + 4;
  vsNewItemRowInfoText = vsTableFirst + 5;
  vsIndicator = vsTableFirst + 6;
  vsPreview = vsTableFirst + 7;
  vsTableLast = vsPreview;

type
  TcxCustomGridTableItemsListBox = class;
  TcxGridTableCustomizationForm = class;
  TcxGridTableController = class;
  TcxCustomGridPartViewInfo = class;
  TcxGridColumnHeaderAreaPainterClass = class of TcxGridColumnHeaderAreaPainter;
  TcxGridColumnContainerZone = class;
  TcxGridColumnContainerViewInfo = class;
  TcxGridColumnHeaderAreaViewInfoClass = class of TcxGridColumnHeaderAreaViewInfo;
  TcxGridColumnHeaderAreaViewInfo = class;
  TcxGridColumnHeaderFilterButtonViewInfo = class;
  TcxGridColumnHeaderGlyphViewInfo = class;
  TcxGridColumnHeaderViewInfoClass = class of TcxGridColumnHeaderViewInfo;
  TcxGridColumnHeaderViewInfo = class;
  TcxGridHeaderViewInfo = class;
  TcxGridFooterViewInfo = class;
  TcxCustomGridFilterButtonViewInfo = class;
  TcxGridFilterActivateButtonViewInfo = class;
  TcxGridFilterButtonsViewInfo = class;
  TcxGridFilterViewInfo = class;
  TcxCustomGridIndicatorItemViewInfo = class;
  TcxGridIndicatorRowItemViewInfo = class;
  TcxGridIndicatorFooterItemViewInfo = class;
  TcxGridIndicatorViewInfo = class;
  TcxGridRowFooterViewInfo = class;
  TcxGridRowFootersViewInfo = class;
  TcxCustomGridRowViewInfo = class;
  TcxGridRowsViewInfo = class;
  TcxGridTableViewInfo = class;
  TcxGridTableViewInfoCacheItem = class;
  TcxGridTableFiltering = class;
  TcxGridColumn = class;
  TcxGridTableView = class;

  TcxGridColumnContainerKind = Integer;

  { hit tests }

  // custom column

  TcxCustomGridColumnHitTestClass = class of TcxCustomGridColumnHitTest;

  TcxCustomGridColumnHitTest = class(TcxCustomGridViewHitTest)
  public
    Column: TcxGridColumn;
    ColumnContainerKind: TcxGridColumnContainerKind;
    //procedure Assign(Source: TcxCustomGridHitTest); override;
  end;

  // group by box

  TcxGridGroupByBoxHitTest = class(TcxCustomGridViewHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  // column header

  TcxGridColumnHeaderHitTest = class(TcxCustomGridColumnHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  public
    function DragAndDropObjectClass: TcxCustomGridDragAndDropObjectClass; override;
  end;

  TcxGridColumnHeaderHorzSizingEdgeHitTest = class(TcxCustomGridColumnHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  public
    class function Cursor: TCursor; override;
    function DragAndDropObjectClass: TcxCustomGridDragAndDropObjectClass; override;
  end;

  TcxGridColumnHeaderFilterButtonHitTest = class(TcxCustomGridColumnHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  // header

  TcxGridHeaderHitTest = class(TcxCustomGridViewHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  // footer

  TcxGridFooterHitTest = class(TcxCustomGridViewHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  TcxGridFooterCellHitTest = class(TcxCustomGridColumnHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  TcxGridGroupFooterHitTest = class(TcxGridFooterHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  TcxGridGroupFooterCellHitTest = class(TcxGridFooterCellHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  // filter

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

  TcxGridFilterCustomizeButtonHitTest = class(TcxCustomGridViewHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  // indicator

  TcxGridRowIndicatorHitTest = class(TcxGridRecordHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  TcxGridRowSizingEdgeHitTest = class(TcxGridRecordHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  public
    class function Cursor: TCursor; override;
    function DragAndDropObjectClass: TcxCustomGridDragAndDropObjectClass; override;
  end;

  TcxGridIndicatorHitTest = class(TcxCustomGridViewHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  // row

  TcxGridRowLevelIndentHitTest = class(TcxGridRecordHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  public
    class function CanClick: Boolean; override;
  end;

  // customization form

  TcxGridCustomozationFormHitTest = class(TcxCustomGridViewHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  { controller }

  TcxGridDragAndDropObject = class(TcxCustomGridTableDragAndDropObject)
  private
    function GetController: TcxGridTableController;
    function GetGridView: TcxGridTableView;
    function GetViewInfo: TcxGridTableViewInfo;
  protected
    procedure AfterScrolling; virtual;
    procedure BeforeScrolling; virtual;
    property Controller: TcxGridTableController read GetController;
    property GridView: TcxGridTableView read GetGridView;
    property ViewInfo: TcxGridTableViewInfo read GetViewInfo;
  end;

  TcxGridArrowNumber = (anFirst, anLast);
  TcxGridArrowPlace = (apLeft, apTop, apRight, apBottom);

  TcxCustomGridMovingObject = class(TcxGridDragAndDropObject)
  private
    FArrowsVisible: Boolean;
    FDragImage: TBitmap;
    FDragImageCanvas: TcxCanvas;
    FDragImageOffset: TPoint;
    FDragImagePos: TPoint;
    FDragImageSavingBitmap: TBitmap;
    FDragImageSavingPos: TPoint;
    FDragImageVisible: Boolean;
    FSavingBitmap: TBitmap;

    function GetArrowPlace(AArrowNumber: TcxGridArrowNumber): TcxGridArrowPlace;
    function GetCustomizationForm: TcxGridTableCustomizationForm;
    function GetDragImageSavingCanvas: TCanvas;
    function GetSavingBitmap: TBitmap;
    function GetSavingCanvas: TCanvas;

    procedure CreateDragImage;
    procedure DestroyDragImage;
  protected
    procedure AfterScrolling; override;
    procedure BeforeScrolling; override;
    procedure DirtyChanged; override;
    function GetDragAndDropCursor(Accepted: Boolean): TCursor; override;

    procedure ChangeArrowsVisibility(AVisible: Boolean);
    procedure ChangeDragImagePosition(AVisible: Boolean = True);

    function AreArrowsVertical: Boolean; virtual;
    function CalculateDragImageOffset: TPoint; virtual;
    function CanRemove: Boolean; virtual; abstract;
    function GetArrowAreaBounds(APlace: TcxGridArrowPlace): TRect; virtual; abstract;
    function GetArrowBounds(APlace: TcxGridArrowPlace): TRect; virtual;
    function GetArrowsClientRect: TRect; virtual;
    function GetCustomizationFormListBox: TcxCustomGridTableItemsListBox; virtual; abstract;
    function GetDragImageBounds(AMousePos: TPoint): TRect; virtual;
    function GetSourceItem: TObject; virtual; abstract;
    function GetSourceItemBounds: TRect; virtual;
    function GetSourceItemViewInfo: TcxCustomGridCellViewInfo; virtual;
    procedure InitDragImage; virtual;
    function IsSourceCustomizationForm: Boolean; virtual; abstract;
    function IsValidDestination: Boolean; virtual; abstract;

    property ArrowBounds[APlace: TcxGridArrowPlace]: TRect read GetArrowBounds;
    property ArrowPlaces[AArrowNumber: TcxGridArrowNumber]: TcxGridArrowPlace read GetArrowPlace;
    property ArrowsClientRect: TRect read GetArrowsClientRect;
    property CustomizationForm: TcxGridTableCustomizationForm read GetCustomizationForm;
    property CustomizationFormListBox: TcxCustomGridTableItemsListBox read GetCustomizationFormListBox;
    property DragImage: TBitmap read FDragImage;
    property DragImageCanvas: TcxCanvas read FDragImageCanvas;
    property DragImageOffset: TPoint read FDragImageOffset;
    property DragImagePos: TPoint read FDragImagePos write FDragImagePos;
    property DragImageSavingBitmap: TBitmap read FDragImageSavingBitmap;
    property DragImageSavingCanvas: TCanvas read GetDragImageSavingCanvas;
    property DragImageSavingPos: TPoint read FDragImageSavingPos write FDragImageSavingPos;
    property DragImageVisible: Boolean read FDragImageVisible write FDragImageVisible;
    property SavingBitmap: TBitmap read GetSavingBitmap;
    property SavingCanvas: TCanvas read GetSavingCanvas;
    property SourceItem: TObject read GetSourceItem;
    property SourceItemBounds: TRect read GetSourceItemBounds;
    property SourceItemViewInfo: TcxCustomGridCellViewInfo read GetSourceItemViewInfo;
  public
    constructor Create(AControl: TcxControl); override;
    destructor Destroy; override;
    procedure BeginDragAndDrop; override;
    procedure DragAndDrop(const P: TPoint; var Accepted: Boolean); override;
    procedure EndDragAndDrop(Accepted: Boolean); override;
  end;

  TcxGridColumnHeaderMovingObjectClass = class of TcxGridColumnHeaderMovingObject;

  TcxGridColumnHeaderMovingObject = class(TcxCustomGridMovingObject)
  private
    FDestColumnContainerKind: TcxGridColumnContainerKind;
    FDestZone: TcxGridColumnContainerZone;
    FSourceColumn: TcxGridColumn;
    FSourceColumnContainerKind: TcxGridColumnContainerKind;

    procedure SetDestColumnContainerKind(Value: TcxGridColumnContainerKind);
    procedure SetDestZone(Value: TcxGridColumnContainerZone);
  protected
    function CanRemove: Boolean; override;
    procedure DoColumnMoving; virtual;
    function GetArrowAreaBounds(APlace: TcxGridArrowPlace): TRect; override;
    function GetArrowAreaBoundsForHeader(APlace: TcxGridArrowPlace): TRect; virtual;
    function GetCustomizationFormListBox: TcxCustomGridTableItemsListBox; override;
    function GetSourceItem: TObject; override;
    function GetSourceItemViewInfo: TcxCustomGridCellViewInfo; override;
    function IsSourceCustomizationForm: Boolean; override;
    function IsValidDestination: Boolean; override;
    function IsValidDestinationForVisibleSource: Boolean; virtual;

    property DestColumnContainerKind: TcxGridColumnContainerKind
      read FDestColumnContainerKind write SetDestColumnContainerKind;
    property DestZone: TcxGridColumnContainerZone read FDestZone write SetDestZone;
    property SourceColumn: TcxGridColumn read FSourceColumn write FSourceColumn;
    property SourceColumnContainerKind: TcxGridColumnContainerKind
      read FSourceColumnContainerKind write FSourceColumnContainerKind;
  public
    constructor Create(AControl: TcxControl); override;
    destructor Destroy; override;
    procedure BeginDragAndDrop; override;
    procedure DragAndDrop(const P: TPoint; var Accepted: Boolean); override;
    procedure EndDragAndDrop(Accepted: Boolean); override;
    procedure Init(const P: TPoint; AParams: TcxCustomGridHitTest); override;
  end;

  TcxCustomGridSizingObject = class(TcxGridDragAndDropObject)
  private
    FDestPointX: Integer;
    FDestPointY: Integer;
    FOriginalSize: Integer;
    procedure SetDestPointX(Value: Integer);
    procedure SetDestPointY(Value: Integer);
  protected
    procedure DirtyChanged; override;
    function GetCurrentSize: Integer; virtual;
    function GetDeltaSize: Integer; virtual;
    function GetDragAndDropCursor(Accepted: Boolean): TCursor; override;
    function GetHorzSizingMarkBounds: TRect; virtual;
    function GetImmediateStart: Boolean; override;
    function GetIsHorizontalSizing: Boolean; virtual;
    function GetSizingItemBounds: TRect; virtual; abstract;
    function GetSizingMarkBounds: TRect; virtual;
    function GetSizingMarkWidth: Integer; virtual; abstract;
    function GetVertSizingMarkBounds: TRect; virtual;

    property CurrentSize: Integer read GetCurrentSize;
    property DeltaSize: Integer read GetDeltaSize;
    property DestPointX: Integer read FDestPointX write SetDestPointX;
    property DestPointY: Integer read FDestPointY write SetDestPointY;
    property IsHorizontalSizing: Boolean read GetIsHorizontalSizing;
    property OriginalSize: Integer read FOriginalSize write FOriginalSize;
    property SizingItemBounds: TRect read GetSizingItemBounds;
    property SizingMarkBounds: TRect read GetSizingMarkBounds;
    property SizingMarkWidth: Integer read GetSizingMarkWidth;
  public
    procedure DragAndDrop(const P: TPoint; var Accepted: Boolean); override;
    procedure Init(const P: TPoint; AParams: TcxCustomGridHitTest); override;
  end;

  TcxCustomGridColumnSizingObject = class(TcxCustomGridSizingObject)
  private
    FColumn: TcxGridColumn;
    function GetColumnHeaderViewInfo: TcxGridColumnHeaderViewInfo;
  protected  
    function GetSizingItemBounds: TRect; override;
    function GetSizingMarkWidth: Integer; override;
    property Column: TcxGridColumn read FColumn write FColumn;
    property ColumnHeaderViewInfo: TcxGridColumnHeaderViewInfo read GetColumnHeaderViewInfo;
  public
    procedure Init(const P: TPoint; AParams: TcxCustomGridHitTest); override;
  end;

  TcxGridColumnHorzSizingObject = class(TcxCustomGridColumnSizingObject)
  protected
    function GetCurrentSize: Integer; override;
  public
    procedure BeginDragAndDrop; override;
    procedure EndDragAndDrop(Accepted: Boolean); override;
  end;

  TcxGridRowSizingObject = class(TcxCustomGridSizingObject)
  private
    FRow: TcxCustomGridRow;
    function GetRowViewInfo: TcxCustomGridRowViewInfo;
  protected
    function GetCurrentSize: Integer; override;
    function GetIsHorizontalSizing: Boolean; override;
    function GetSizingItemBounds: TRect; override;
    function GetSizingMarkWidth: Integer; override;
    property Row: TcxCustomGridRow read FRow;
    property RowViewInfo: TcxCustomGridRowViewInfo read GetRowViewInfo;
  public
    procedure BeginDragAndDrop; override;
    procedure EndDragAndDrop(Accepted: Boolean); override;
    procedure Init(const P: TPoint; AParams: TcxCustomGridHitTest); override;
  end;

  TcxGridFilterPopupClass = class of TcxGridFilterPopup;

  TcxGridFilterPopup = class(TcxCustomPopupWindow)
  private
    FGridView: TcxGridTableView;
    FListBox: TcxListBox;
    FListBoxItems: TStringList;                     
    FOwnerViewInfo: TcxGridColumnHeaderFilterButtonViewInfo;
    FValueList: TcxDataFilterValueList;
    function GetColumn: TcxGridColumn;
    function GetFilter: TcxDataFilterCriteria;
    procedure SetOwnerViewInfo(Value: TcxGridColumnHeaderFilterButtonViewInfo);
    procedure ListBoxDrawItem(AControl: TcxListBox; ACanvas: TcxCanvas;
      AIndex: Integer; ARect: TRect; AState: TOwnerDrawState);
    procedure ListBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ListBoxMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ListBoxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  protected
    procedure AddListBoxItems; virtual;
    procedure AdjustListBoxSize; virtual;
    procedure ApplyFilter(AItemIndex: Integer); virtual;
    function CalculateOwnerBounds: TRect; virtual;
    procedure CreateListBox; virtual;
    procedure InitPopup; override;
    procedure Paint; override;
    procedure VisibleChanged; override;

    property Column: TcxGridColumn read GetColumn;
    property Filter: TcxDataFilterCriteria read GetFilter;
    property GridView: TcxGridTableView read FGridView;
    property ListBoxItems: TStringList read FListBoxItems;
    property OwnerViewInfo: TcxGridColumnHeaderFilterButtonViewInfo read FOwnerViewInfo
      write SetOwnerViewInfo;
    property ValueList: TcxDataFilterValueList read FValueList;
  public
    constructor Create(AGridView: TcxGridTableView); reintroduce; virtual;
    destructor Destroy; override;
    procedure CloseUp; override;
    procedure CloseUpAndFocusGridView;
    procedure Popup(AOwnerViewInfo: TcxGridColumnHeaderFilterButtonViewInfo); reintroduce; virtual;
  end;

  TcxCustomGridTableItemsListBox = class(TListBox)
  private
    FcxCanvas: TcxCanvas;
    FDragAndDropItemIndex: Integer;
    FMouseDownPos: TPoint;
    function GetDragAndDropItem: TObject;
    function GetGridView: TcxGridTableView;
    function GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
    procedure WMCancelMode(var Message: TWMCancelMode); message WM_CANCELMODE;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    procedure CalculateBorderStyle;
    procedure CalculateItemHeight;
    function GetDragAndDropParams: TcxCustomGridHitTest; virtual; abstract;

    property DragAndDropItem: TObject read GetDragAndDropItem;
    property DragAndDropItemIndex: Integer read FDragAndDropItemIndex;
    property GridView: TcxGridTableView read GetGridView;
    property LookAndFeelPainter: TcxCustomLookAndFeelpainterClass read GetLookAndFeelPainter;
  public
    constructor Create(AOwner: TComponent); reintroduce;
    destructor Destroy; override;
    function IndexOfItem(AItem: TObject): Integer;
    procedure PaintItem(ACanvas: TcxCanvas; R: TRect; AIndex: Integer; AFocused: Boolean);
    procedure RefreshItems; virtual;
  end;

  TcxGridTableColumnsListBoxClass = class of TcxGridTableColumnsListBox;

  TcxGridTableColumnsListBox = class(TcxCustomGridTableItemsListBox)
  protected
    function GetDragAndDropParams: TcxCustomGridHitTest; override;
  public
    procedure RefreshItems; override;
  end;

  TcxGridTableCustomizationFormClass = class of TcxGridTableCustomizationForm;

  TcxGridTableCustomizationForm = class(TForm)
  private
    FColumnsListBox: TcxGridTableColumnsListBox;
    FColumnsPage: TTabSheet;
    FController: TcxGridTableController;
    FHookTimer: TTimer;
    FOffset: Integer;
    FPageControl: TPageControl;
    FStep: Integer;
    function GetGridView: TcxGridTableView;
    function GetViewInfo: TcxGridTableViewInfo;
    procedure HookTimerHandler(Sender: TObject);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DoClose(var Action: TCloseAction); override;
    procedure DoShow; override;

    procedure CalculateConsts; virtual;
    procedure CreateControls; virtual;
    function CreatePage(const ACaption: string; AVisible: Boolean): TTabSheet;

    function GetColumnsListBoxBounds: TRect; virtual;
    function GetColumnsListBoxClass: TcxGridTableColumnsListBoxClass; virtual;
    function GetContentBounds: TRect; virtual;
    function GetPageControlBounds: TRect; virtual;
    procedure InitPageControl; virtual;

    property ColumnsListBox: TcxGridTableColumnsListBox read FColumnsListBox;
    property ContentBounds: TRect read GetContentBounds;
    property GridView: TcxGridTableView read GetGridView;
    property Offset: Integer read FOffset write FOffset;
    property PageControl: TPageControl read FPageControl;
    property Step: Integer read FStep write FStep;
    property ViewInfo: TcxGridTableViewInfo read GetViewInfo;
  public
    constructor Create(AController: TcxGridTableController); reintroduce; virtual;
    destructor Destroy; override;
    property Controller: TcxGridTableController read FController;
    procedure ActivatePage(APage: TTabSheet);
    procedure RefreshData; virtual;
    property ColumnsPage: TTabSheet read FColumnsPage;
  end;

  TcxGridDragOpenInfoMasterDataRowTab = class(TcxGridDragOpenInfoTab)
  public
    GridRow: TcxGridMasterDataRow;
    constructor Create(ALevel: TcxGridLevel; AGridRow: TcxGridMasterDataRow); reintroduce; virtual;
    function Equals(AInfo: TcxCustomGridDragOpenInfo): Boolean; override;
    procedure Run; override;
  end;

  TcxGridTableController = class(TcxCustomGridTableController)
  private
    FCustomization: Boolean;
    FCustomizationForm: TcxGridTableCustomizationForm;
    FCustomizationFormBounds: TRect;
    FFilterPopup: TcxGridFilterPopup;
    FHorzSizingColumn: TcxGridColumn;
    FLeftPos: Integer;
    FMovingColumn: TcxGridColumn;
    FPressedColumn: TcxGridColumn;
    FScrollDirection: TcxDirection;
    FScrollTimer: TTimer;

    function GetDragAndDropObject: TcxGridDragAndDropObject;
    function GetFilterPopup: TcxGridFilterPopup;
    function GetFocusedColumn: TcxGridColumn;
    function GetFocusedColumnIndex: Integer;
    function GetFocusedRow: TcxCustomGridRow;
    function GetFocusedRowIndex: Integer;
    function GetGridView: TcxGridTableView;
    function GetIsColumnHorzSizing: Boolean;
    function GetIsColumnMoving: Boolean;
    function GetSelectedRow(Index: Integer): TcxCustomGridRow;
    function GetSelectedRowCount: Integer;
    function GetTopRowIndex: Integer;
    function GetViewData: TcxGridViewData;
    function GetViewInfo: TcxGridTableViewInfo;
    procedure SetCustomization(Value: Boolean);
    procedure SetFocusedColumn(Value: TcxGridColumn);
    procedure SetFocusedColumnIndex(Value: Integer);
    procedure SetFocusedRow(Value: TcxCustomGridRow);
    procedure SetFocusedRowIndex(Value: Integer);
    procedure SetLeftPos(Value: Integer);
    procedure SetPressedColumn(Value: TcxGridColumn);
    procedure SetScrollDirection(Value: TcxDirection);
    procedure SetTopRowIndex(Value: Integer);

    procedure CreateScrollTimer;
    procedure DestroyScrollTimer;
    procedure ScrollTimerHandler(Sender: TObject);
  protected
    function CanAppend(ACheckOptions: Boolean): Boolean; override;
    function CanDelete(ACheckOptions: Boolean): Boolean; override;
    function CanScroll(ADirection: TcxDirection): Boolean;
    procedure CheckCoordinates; override;
    procedure CheckLeftPos(var Value: Integer);
    function GetDesignHitTest(AHitTest: TcxCustomGridHitTest): Boolean; override;
    function GetDragScrollDirection(X, Y: Integer): TcxDirection; override;
    function GetFilterPopupClass: TcxGridFilterPopupClass; virtual;
    function GetFocusedRecord: TcxCustomGridRecord; override;
    function GetIsRecordsScrollHorizontal: Boolean; override;
    function GetMaxTopRecordIndexValue: Integer; override;
    function GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind; override;
    function GetScrollBarRecordCount: Integer; override;
    function IsColumnFixedDuringHorzSizing(AColumn: TcxGridColumn): Boolean; virtual;
    function IsKeyForMultiSelect(AKey: Word; AShift: TShiftState;
      AFocusedRecordChanged: Boolean): Boolean; override;
    function IsPixelScrollBar(AKind: TScrollBarKind): Boolean; override;
    procedure LeftPosChanged; virtual;
    function NeedsAdditionalRowsScrolling(AIsCallFromMaster: Boolean = False): Boolean; virtual;
    procedure RemoveFocus; override;
    procedure ScrollData(ADirection: TcxDirection);
    procedure SetFocusedRecord(Value: TcxCustomGridRecord); override;
    procedure ShowNextPage; override;
    procedure ShowPrevPage; override;

    function GetColumnHeaderDragAndDropObjectClass: TcxGridColumnHeaderMovingObjectClass; virtual;
    function GetCustomizationFormClass: TcxGridTableCustomizationFormClass; virtual;
    function GetRealCustomizationFormBounds: TRect;
    procedure HideCustomizationForm;
    procedure ShowCustomizationForm;

    // delphi drag and drop
    function GetDragOpenInfo(AHitTest: TcxCustomGridHitTest): TcxCustomGridDragOpenInfo; override;

    property DragAndDropObject: TcxGridDragAndDropObject read GetDragAndDropObject;
    property ScrollDirection: TcxDirection read FScrollDirection write SetScrollDirection;
    property ViewData: TcxGridViewData read GetViewData;
    property ViewInfo: TcxGridTableViewInfo read GetViewInfo;
  public
    destructor Destroy; override;
    procedure CheckScrolling(const P: TPoint);
    procedure DoCancelMode; override;
    function HasFilterPopup: Boolean;
    procedure MakeItemVisible(AItem: TcxCustomGridTableItem); override;
    procedure MakeRecordVisible(ARecord: TcxCustomGridRecord); override;
    procedure RefreshCustomizationForm;

    procedure InitScrollBarsParameters; override;
    function IsDataFullyVisible(AIsCallFromMaster: Boolean = False): Boolean; override;
    procedure Scroll(AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode;
      var AScrollPos: Integer); override;

    procedure EndDragAndDrop(Accepted: Boolean); override;

    procedure KeyDown(var Key: Word; Shift: TShiftState); override;

    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    property Customization: Boolean read FCustomization write SetCustomization;
    property CustomizationForm: TcxGridTableCustomizationForm read FCustomizationForm;
    property CustomizationFormBounds: TRect read FCustomizationFormBounds
      write FCustomizationFormBounds;
    property FilterPopup: TcxGridFilterPopup read GetFilterPopup;
    property FocusedColumn: TcxGridColumn read GetFocusedColumn write SetFocusedColumn;
    property FocusedColumnIndex: Integer read GetFocusedColumnIndex write SetFocusedColumnIndex;
    property FocusedRow: TcxCustomGridRow read GetFocusedRow write SetFocusedRow;
    property FocusedRowIndex: Integer read GetFocusedRowIndex write SetFocusedRowIndex;
    property GridView: TcxGridTableView read GetGridView;
    property HorzSizingColumn: TcxGridColumn read FHorzSizingColumn;
    property IsColumnHorzSizing: Boolean read GetIsColumnHorzSizing;
    property IsColumnMoving: Boolean read GetIsColumnMoving;
    property LeftPos: Integer read FLeftPos write SetLeftPos;
    property MovingColumn: TcxGridColumn read FMovingColumn;
    property PressedColumn: TcxGridColumn read FPressedColumn write SetPressedColumn;
    property SelectedRowCount: Integer read GetSelectedRowCount;
    property SelectedRows[Index: Integer]: TcxCustomGridRow read GetSelectedRow;
    property TopRowIndex: Integer read GetTopRowIndex write SetTopRowIndex;
  end;

  { painters }

  // part

  TcxCustomGridPartPainter = class(TcxCustomGridCellPainter);

  // column container

  TcxGridColumnContainerPainterClass = class of TcxGridColumnContainerPainter;

  TcxGridColumnContainerPainter = class(TcxCustomGridPartPainter)
  private
    function GetViewInfo: TcxGridColumnContainerViewInfo;
  protected
    procedure DrawContent; override;
    procedure DrawItems; virtual;
    function DrawItemsFirst: Boolean; virtual;
    function ExcludeFromClipRect: Boolean; override;
    property ViewInfo: TcxGridColumnContainerViewInfo read GetViewInfo;
  end;

  // header

  TcxGridColumnHeaderAreaPainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxGridColumnHeaderAreaViewInfo;
  protected
    property ViewInfo: TcxGridColumnHeaderAreaViewInfo read GetViewInfo;
  end;

  TcxGridColumnHeaderSortingMarkPainter = class(TcxGridColumnHeaderAreaPainter)
  protected
    procedure Paint; override;
  end;

  TcxGridColumnHeaderFilterButtonPainter = class(TcxGridColumnHeaderAreaPainter)
  private
    function GetViewInfo: TcxGridColumnHeaderFilterButtonViewInfo;
  protected
    procedure Paint; override;
    property ViewInfo: TcxGridColumnHeaderFilterButtonViewInfo read GetViewInfo;
  end;

  TcxGridColumnHeaderGlyphPainter = class(TcxGridColumnHeaderAreaPainter)
  private
    function GetViewInfo: TcxGridColumnHeaderGlyphViewInfo;
  protected
    procedure Paint; override;
    property ViewInfo: TcxGridColumnHeaderGlyphViewInfo read GetViewInfo;
  end;

  TcxGridColumnHeaderPainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxGridColumnHeaderViewInfo;
  protected
    procedure DrawBorders; override;
    procedure DrawContent; override;
    procedure DrawPressed; virtual;
    function ExcludeFromClipRect: Boolean; override;
    procedure Paint; override;
    property ViewInfo: TcxGridColumnHeaderViewInfo read GetViewInfo;
  end;

  TcxGridHeaderPainter = class(TcxGridColumnContainerPainter)
  protected
    function DrawItemsFirst: Boolean; override;
  end;

  // group by box

  TcxGridGroupByBoxPainterClass = class of TcxGridGroupByBoxPainter;

  TcxGridGroupByBoxPainter = class(TcxGridColumnContainerPainter)
  protected
    procedure DrawContent; override;
  end;

  // footer

  TcxGridFooterCellPainter = class(TcxGridColumnHeaderPainter)
  protected
    procedure DrawBorders; override;
    procedure DrawContent; override;
  end;

  TcxGridFooterPainterClass = class of TcxGridFooterPainter;

  TcxGridFooterPainter = class(TcxGridColumnContainerPainter)
  private
    function GetViewInfo: TcxGridFooterViewInfo;
  protected
    procedure DrawBorders; override;
    function DrawItemsFirst: Boolean; override;
    procedure DrawSeparator; virtual;
    property ViewInfo: TcxGridFooterViewInfo read GetViewInfo;
  end;

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

  TcxGridFilterCustomizeButtonPainter = class(TcxCustomGridFilterButtonPainter)
  protected
    procedure Paint; override;
  end;

  TcxGridFilterPainterClass = class of TcxGridFilterPainter;

  TcxGridFilterPainter = class(TcxCustomGridPartPainter)
  private
    function GetViewInfo: TcxGridFilterViewInfo;
  protected
    procedure DrawButtons; virtual;
    function ExcludeFromClipRect: Boolean; override;
    procedure Paint; override;
    property ViewInfo: TcxGridFilterViewInfo read GetViewInfo;
  end;

  // indicator

  TcxCustomGridIndicatorItemPainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxCustomGridIndicatorItemViewInfo;
  protected
    function ExcludeFromClipRect: Boolean; override;
    property ViewInfo: TcxCustomGridIndicatorItemViewInfo read GetViewInfo;
  end;

  TcxGridIndicatorHeaderItemPainter = class(TcxCustomGridIndicatorItemPainter)
  protected
    procedure DrawContent; override;
  end;

  TcxGridIndicatorRowItemPainter = class(TcxCustomGridIndicatorItemPainter)
  private
    function GetViewInfo: TcxGridIndicatorRowItemViewInfo;
  protected
    procedure DrawContent; override;
    property ViewInfo: TcxGridIndicatorRowItemViewInfo read GetViewInfo;
  end;

  TcxGridIndicatorFooterItemPainter = class(TcxCustomGridIndicatorItemPainter)
  private
    function GetViewInfo: TcxGridIndicatorFooterItemViewInfo;
  protected
    procedure DrawBorders; override;
    property ViewInfo: TcxGridIndicatorFooterItemViewInfo read GetViewInfo;
  end;

  TcxGridIndicatorPainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxGridIndicatorViewInfo;
  protected
    procedure DrawContent; override;
    procedure DrawItems; virtual;
    function DrawItemsFirst: Boolean; virtual;
    function ExcludeFromClipRect: Boolean; override;
    property ViewInfo: TcxGridIndicatorViewInfo read GetViewInfo;
  end;

  // custom row

  TcxCustomGridRowPainter = class(TcxCustomGridRecordPainter)
  private
    function GetViewInfo: TcxCustomGridRowViewInfo;
  protected
    procedure DrawFooters; virtual;
    procedure DrawIndent; virtual;
    procedure DrawIndentPart(ALevel: Integer; const ABounds: TRect); virtual;
    procedure DrawLastHorzGridLine; virtual;
    procedure DrawSeparator; virtual;
    procedure Paint; override;
    property ViewInfo: TcxCustomGridRowViewInfo read GetViewInfo;
  end;

  // rows

  TcxGridRowsPainterClass = class of TcxGridRowsPainter;

  TcxGridRowsPainter = class(TcxCustomGridRecordsPainter)
  private
    function GetViewInfo: TcxGridRowsViewInfo;
  protected
    property ViewInfo: TcxGridRowsViewInfo read GetViewInfo;
  public
    class procedure DrawDataRowCells(ARowViewInfo: TcxCustomGridRowViewInfo); virtual;
    procedure Paint; override;
  end;

  // table

  TcxGridTablePainter = class(TcxCustomGridTablePainter)
  private
    FGridLines: TList;
    function GetController: TcxGridTableController;
    function GetGridView: TcxGridTableView;
    function GetViewInfo: TcxGridTableViewInfo;
  protected
    function CanOffset(AItemsOffset, DX, DY: Integer): Boolean; override;
    procedure DrawFilterBar; virtual;
    procedure DrawFooter; virtual;
    procedure DrawGroupByBox; virtual;
    procedure DrawHeader; virtual;
    procedure DrawIndicator; virtual;
    procedure DrawRecords; override;
    procedure Offset(AItemsOffset: Integer); override;
    procedure Offset(DX, DY: Integer); override;
    procedure PaintContent; override;
  public
    procedure AddGridLine(const R: TRect);
    property Controller: TcxGridTableController read GetController;
    property GridView: TcxGridTableView read GetGridView;
    property ViewInfo: TcxGridTableViewInfo read GetViewInfo;
  end;

  { view infos }

  // grid part

  TcxGridPartAlignment = (gpaTop, gpaBottom);

  TcxCustomGridPartViewInfo = class(TcxCustomGridViewCellViewInfo)
  private
    FHeight: Integer;
    function GetGridView: TcxGridTableView;
    function GetGridViewInfo: TcxGridTableViewInfo;
    function GetIndex: Integer;
  protected
    function CalculateBounds: TRect; virtual;
    procedure CalculateInvisible; virtual;
    procedure CalculateVisible; virtual;
    function CustomDrawBackground(ACanvas: TcxCanvas): Boolean; override;
    function GetAlignment: TcxGridPartAlignment; virtual; abstract;
    function GetHeight: Integer; override;
    function GetIsAutoWidth: Boolean; virtual; abstract;
    function GetIsPart: Boolean; virtual;
    function GetIsScrollable: Boolean; virtual; abstract;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function HasCustomDrawBackground: Boolean; override;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); override;

    property Alignment: TcxGridPartAlignment read GetAlignment;
    property Index: Integer read GetIndex;
    property IsAutoWidth: Boolean read GetIsAutoWidth;
    property IsPart: Boolean read GetIsPart;
    property IsScrollable: Boolean read GetIsScrollable;
  public
    constructor Create(AGridViewInfo: TcxGridTableViewInfo); virtual;
    destructor Destroy; override;
    procedure MainCalculate;
    property GridView: TcxGridTableView read GetGridView;
    property GridViewInfo: TcxGridTableViewInfo read GetGridViewInfo;
  end;

  // column container

  TcxGridColumnContainerZone = class
  public
    ColumnIndex: Integer;
    constructor Create(AColumnIndex: Integer);
    function IsEqual(Value: TcxGridColumnContainerZone): Boolean; virtual;
  end;

  TcxGridColumnContainerViewInfo = class(TcxCustomGridPartViewInfo)
  private
    FItemHeight: Integer;
    FItems: TList;
    function GetController: TcxGridTableController;
    function GetCount: Integer;
    function GetInternalItem(Index: Integer): TcxGridColumnHeaderViewInfo;
    function GetItem(Index: Integer): TcxGridColumnHeaderViewInfo;
    function GetItemHeight: Integer;
    function CreateItem(AIndex: Integer): TcxGridColumnHeaderViewInfo;
    procedure CreateItems;
    procedure DestroyItems;
  protected
    function CalculateItemHeight: Integer; virtual;
    function GetAutoHeight: Boolean; virtual;
    function GetColumn(Index: Integer): TcxGridColumn; virtual; abstract;
    function GetColumnAdditionalWidth(AColumn: TcxGridColumn): Integer;
    function GetColumnCount: Integer; virtual; abstract;
    function GetColumnMinWidth(AColumn: TcxGridColumn): Integer; virtual;
    function GetColumnNeighbors(AColumn: TcxGridColumn): TcxNeighbors; virtual;
    function GetColumnWidth(AColumn: TcxGridColumn): Integer; virtual;
    function GetItemClass: TcxGridColumnHeaderViewInfoClass; virtual;
    function GetItemMultiLinePainting: Boolean; virtual;
    function GetItemsAreaBounds: TRect; virtual;
    function GetKind: TcxGridColumnContainerKind; virtual; abstract;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetZonesAreaBounds: TRect; virtual;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); override;
    procedure Offset(DX, DY: Integer); override;

    property AutoHeight: Boolean read GetAutoHeight;
    property ColumnCount: Integer read GetColumnCount;
    property Columns[Index: Integer]: TcxGridColumn read GetColumn;
    property Controller: TcxGridTableController read GetController;
    property ZonesAreaBounds: TRect read GetZonesAreaBounds;
  public
    constructor Create(AGridViewInfo: TcxGridTableViewInfo); override;
    destructor Destroy; override;
    procedure BeforeRecalculation; override;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
    function GetZone(const P: TPoint): TcxGridColumnContainerZone; virtual;
    property Count: Integer read GetCount;
    property InternalItems[Index: Integer]: TcxGridColumnHeaderViewInfo read GetInternalItem;
    property ItemHeight: Integer read GetItemHeight;
    property ItemMultiLinePainting: Boolean read GetItemMultiLinePainting;
    property Items[Index: Integer]: TcxGridColumnHeaderViewInfo read GetItem; default;
    property ItemsAreaBounds: TRect read GetItemsAreaBounds;
    property Kind: TcxGridColumnContainerKind read GetKind;
  end;

  // column header areas

  TcxGridColumnHeaderAreaViewInfo = class(TcxCustomGridViewCellViewInfo)
  private
    FColumnHeaderViewInfo: TcxGridColumnHeaderViewInfo;
    function GetColumn: TcxGridColumn;
    function GetGridView: TcxGridTableView;
    function GetGridViewInfo: TcxGridTableViewInfo;
  protected
    function GetAlignmentVert: TcxAlignmentVert; override;
    function GetCanvas: TcxCanvas; override;
    function GetHeight: Integer; override;
    function GetIsOccupyingSpace: Boolean; virtual;
    function GetTransparent: Boolean; reintroduce; virtual; abstract;
    function GetWidth: Integer; override;
    function HasMouse(AHitTest: TcxCustomGridHitTest): Boolean; override;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); override;
    //procedure Invalidate; virtual;

    property Column: TcxGridColumn read GetColumn;
    property ColumnHeaderViewInfo: TcxGridColumnHeaderViewInfo read FColumnHeaderViewInfo;
    property GridView: TcxGridTableView read GetGridView;
    property GridViewInfo: TcxGridTableViewInfo read GetGridViewInfo;
    property IsOccupyingSpace: Boolean read GetIsOccupyingSpace;
  public
    constructor Create(AColumnHeaderViewInfo: TcxGridColumnHeaderViewInfo); virtual;
    procedure Calculate(const ABounds: TRect; var ATextAreaBounds: TRect); reintroduce; virtual;
    property AlignmentHorz: TAlignment read GetAlignmentHorz;
    property AlignmentVert: TcxAlignmentVert read GetAlignmentVert;
    property Height: Integer read GetHeight;
    property Transparent: Boolean read GetTransparent;
    property Width: Integer read GetWidth;
  end;

  TcxGridColumnHeaderSortingMarkViewInfo = class(TcxGridColumnHeaderAreaViewInfo)
  private
    function GetSortOrder: TcxGridSortOrder;
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function GetAlignmentHorz: TAlignment; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetTransparent: Boolean; override;
    property SortOrder: TcxGridSortOrder read GetSortOrder;
  end;

  TcxGridColumnHeaderHorzSizingEdgeViewInfo = class(TcxGridColumnHeaderAreaViewInfo)
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function GetAlignmentHorz: TAlignment; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetIsOccupyingSpace: Boolean; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetTransparent: Boolean; override;
  public
    procedure Calculate(const ABounds: TRect; var ATextAreaBounds: TRect); override;
    function MouseDown(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; override;
  end;

  TcxGridColumnHeaderFilterButtonViewInfo = class(TcxGridColumnHeaderAreaViewInfo)
  private
    function GetActive: Boolean;
    function GetDropDownWindow: TcxGridFilterPopup;
  protected
    procedure BeforeStateChange; override;
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function EmulateMouseMoveAfterCalculate: Boolean; override;
    function GetAlignmentHorz: TAlignment; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetHotTrack: Boolean; override;
    function GetIsCheck: Boolean; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetTransparent: Boolean; override;
    procedure StateChanged; override;

    procedure CloseUp; virtual;
    procedure DropDown; virtual;
  public
    destructor Destroy; override;
    property Active: Boolean read GetActive;
    property DropDownWindow: TcxGridFilterPopup read GetDropDownWindow;
  end;

  TcxGridColumnHeaderGlyphViewInfo = class(TcxGridColumnHeaderAreaViewInfo)
  private
    function GetGlyph: TBitmap;
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function GetAlignmentHorz: TAlignment; override;
    function GetAlignmentVert: TcxAlignmentVert; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetTransparent: Boolean; override;
  public
    property Glyph: TBitmap read GetGlyph;
  end;

  // column header

  TcxGridColumnHeaderViewInfo = class(TcxCustomGridViewCellViewInfo)
  private
    FAdditionalWidth: Integer;
    FAreaViewInfos: TList;
    FColumn: TcxGridColumn;
    FContainer: TcxGridColumnContainerViewInfo;
    FHasTextOffsetLeft: Boolean;
    FHasTextOffsetRight: Boolean;
    FNeighbors: TcxNeighbors;
    FRealWidth: Integer;
    FTextAreaBounds: TRect;
    FWidth: Integer;

    function GetAreaViewInfoCount: Integer;
    function GetAreaViewInfo(Index: Integer): TcxGridColumnHeaderAreaViewInfo;
    function GetGridView: TcxGridTableView;
    function GetGridViewInfo: TcxGridTableViewInfo;
    function GetIndex: Integer;
    function GetIsFixed: Boolean;
    function GetRealBounds: TRect;
    function GetRealWidth: Integer;

    procedure EnumAreaViewInfoClasses(AClass: TClass);
    procedure CreateAreaViewInfos;
    procedure DestroyAreaViewInfos;
  protected
    function CalculateHasTextOffsetLeft: Boolean; virtual;
    function CalculateHasTextOffsetRight: Boolean; virtual;
    function CalculateHeight: Integer; override;
    function CalculateRealWidth(Value: Integer): Integer;
    procedure CalculateTextAreaBounds; virtual;
    procedure CalculateVisible(ALeftBound, AWidth: Integer); virtual;
    function CalculateWidth: Integer; override;
    function CanFilter: Boolean; virtual;
    function CanHorzSize: Boolean; virtual;
    function CanPress: Boolean; virtual;
    function CanSort: Boolean; virtual;
    procedure CheckWidth(var Value: Integer); virtual;
    function CustomDraw(ACanvas: TcxCanvas): Boolean; override;
    procedure DoCalculateParams; override;
    function GetAlignmentHorz: TAlignment; override;
    function GetAlignmentVert: TcxAlignmentVert; override;
    procedure GetAreaViewInfoClasses(AProc: TcxGridClassEnumeratorProc); virtual;
    function GetBackgroundBitmap: TBitmap; override;
    function GetBorders: TcxBorders; override;
    function GetBorderWidth(AIndex: TcxBorder): Integer; override;
    function GetCanvas: TcxCanvas; override;
    class function GetCellBorderWidth(ALookAndFeelPainter: TcxCustomLookAndFeelPainterClass): Integer; virtual;
    class function GetCellHeight(ATextHeight: Integer;
      ALookAndFeelPainter: TcxCustomLookAndFeelPainterClass): Integer; override;
    function GetDataOffset: Integer; virtual;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetHotTrack: Boolean; override;
    function GetIsPressed: Boolean; virtual;
    function GetMaxWidth: Integer; virtual;
    function GetMinWidth: Integer; virtual;
    function GetMultiLine: Boolean; override;
    function GetMultiLinePainting: Boolean; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetShowEndEllipsis: Boolean; override;
    function GetText: string; override;
    function GetTextAreaBounds: TRect; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function GetWidth: Integer; override;
    function HasCustomDraw: Boolean; override;
    function HasGlyph: Boolean; virtual;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); override;
    procedure Offset(DX, DY: Integer); override;
    procedure SetWidth(Value: Integer); override;
    procedure StateChanged; override;

    property AdditionalWidth: Integer read FAdditionalWidth write FAdditionalWidth;
    property AreaViewInfoCount: Integer read GetAreaViewInfoCount;
    property AreaViewInfos[Index: Integer]: TcxGridColumnHeaderAreaViewInfo read GetAreaViewInfo;
    property GridView: TcxGridTableView read GetGridView;
    property GridViewInfo: TcxGridTableViewInfo read GetGridViewInfo;
    property HasTextOffsetLeft: Boolean read FHasTextOffsetLeft;
    property HasTextOffsetRight: Boolean read FHasTextOffsetRight;
  public
    constructor Create(AContainer: TcxGridColumnContainerViewInfo;
      AColumn: TcxGridColumn); virtual;
    destructor Destroy; override;
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); override;
    function GetBestFitWidth: Integer; virtual;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
    procedure InitAutoWidthItem(AAutoWidthItem: TcxAutoWidthItem);
    function MouseDown(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; override;

    property Column: TcxGridColumn read FColumn;
    property Container: TcxGridColumnContainerViewInfo read FContainer;
    property DataOffset: Integer read GetDataOffset;
    property Index: Integer read GetIndex;
    property IsFixed: Boolean read GetIsFixed;
    property IsPressed: Boolean read GetIsPressed;
    property MaxWidth: Integer read GetMaxWidth;
    property MinWidth: Integer read GetMinWidth;
    property Neighbors: TcxNeighbors read FNeighbors write FNeighbors;
    property RealBounds: TRect read GetRealBounds;
    property RealWidth: Integer read GetRealWidth;
  end;

  // header

  TcxGridHeaderViewInfoSpecificClass = class of TcxGridHeaderViewInfoSpecific;

  TcxGridHeaderViewInfoSpecific = class
  private
    FContainerViewInfo: TcxGridHeaderViewInfo;
    function GetGridViewInfo: TcxGridTableViewInfo;
    function GetItemHeight: Integer;
  protected
    function CalculateHeight: Integer; virtual;
    function GetHeight: Integer; virtual;
  public
    constructor Create(AContainerViewInfo: TcxGridHeaderViewInfo); virtual;
    property ContainerViewInfo: TcxGridHeaderViewInfo read FContainerViewInfo;
    property GridViewInfo: TcxGridTableViewInfo read GetGridViewInfo;
    property Height: Integer read GetHeight;
    property ItemHeight: Integer read GetItemHeight;
  end;

  TcxGridHeaderViewInfoClass = class of TcxGridHeaderViewInfo;

  TcxGridHeaderViewInfo = class(TcxGridColumnContainerViewInfo)
  private
    FSpecific: TcxGridHeaderViewInfoSpecific;
  protected
    procedure CalculateColumnAutoWidths; virtual;
    procedure CalculateColumnWidths; virtual;
    function CalculateHeight: Integer; override;
    procedure CalculateInvisible; override;
    function CalculateItemHeight: Integer; override;
    procedure CalculateItems; virtual;
    procedure CalculateVisible; override;
    function CalculateWidth: Integer; override;
    function CanCalculateAutoWidths: Boolean; virtual;
    function DrawColumnBackgroundHandler(ACanvas: TcxCanvas; const ABounds: TRect): Boolean; virtual;
    function GetAlignment: TcxGridPartAlignment; override;
    function GetAutoHeight: Boolean; override;
    function GetColumn(Index: Integer): TcxGridColumn; override;
    function GetColumnBackgroundBitmap: TBitmap; virtual;
    function GetColumnCount: Integer; override;
    function GetColumnNeighbors(AColumn: TcxGridColumn): TcxNeighbors; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetIsAutoWidth: Boolean; override;
    function GetIsScrollable: Boolean; override;
    function GetItemMultiLinePainting: Boolean; override;
    function GetKind: TcxGridColumnContainerKind; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function GetVisible: Boolean; override;
    function GetWidth: Integer; override;
    function GetZonesAreaBounds: TRect; override;
    function IsAlwaysVisibleForCalculation: Boolean; virtual;
    function IsHeightAssigned: Boolean; virtual;
    procedure Offset(DX, DY: Integer); override;
    procedure RecalculateItemVisibles;
    property AutoHeight: Boolean read GetAutoHeight;
    property ColumnBackgroundBitmap: TBitmap read GetColumnBackgroundBitmap;
  public
    constructor Create(AGridViewInfo: TcxGridTableViewInfo); override;
    destructor Destroy; override;
    procedure AssignColumnWidths;
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); override;
    property Specific: TcxGridHeaderViewInfoSpecific read FSpecific;
  end;

  // group by box

  TcxGridGroupByBoxColumnHeaderViewInfo = class(TcxGridColumnHeaderViewInfo)
  protected
    function CalculateHeight: Integer; override;
    function InheritedCalculateHeight: Integer;
  end;

  TcxGridGroupByBoxViewInfoClass = class of TcxGridGroupByBoxViewInfo;

  TcxGridGroupByBoxViewInfo = class(TcxGridColumnContainerViewInfo)
  private
    function GetGroupByBoxVerOffset: Integer;
    function GetLinkLineBounds(Index: Integer; Horizontal: Boolean): TRect;
  protected
    function CalculateHeight: Integer; override;
    function CalculateItemHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function GetAlignment: TcxGridPartAlignment; override;
    function GetAlignmentVert: TcxAlignmentVert; override;
    function GetBackgroundBitmap: TBitmap; override;
    function GetColumn(Index: Integer): TcxGridColumn; override;
    function GetColumnCount: Integer; override;
    function GetColumnWidth(AColumn: TcxGridColumn): Integer; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetIsAutoWidth: Boolean; override;
    function GetIsScrollable: Boolean; override;
    function GetItemClass: TcxGridColumnHeaderViewInfoClass; override;
    function GetKind: TcxGridColumnContainerKind; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetText: string; override;
    function GetTextAreaBounds: TRect; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function GetVisible: Boolean; override;
    property GroupByBoxVerOffset: Integer read GetGroupByBoxVerOffset;
  public
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); override;
    property LinkLineBounds[Index: Integer; Horizontal: Boolean]: TRect read GetLinkLineBounds;
  end;

  // footer

  TcxGridFooterCellViewInfo = class(TcxGridColumnHeaderViewInfo)
  private
    function GetSummary: TcxDataSummary;
  protected
    procedure AfterCalculateBounds(var ABounds: TRect); override;
    function CanPress: Boolean; override;
    function CustomDraw(ACanvas: TcxCanvas): Boolean; override;
    function GetAlignmentHorz: TAlignment; override;
    function GetBackgroundBitmap: TBitmap; override;
    procedure GetAreaViewInfoClasses(AProc: TcxGridClassEnumeratorProc); override;
    function GetBorders: TcxBorders; override;
    class function GetCellBorderWidth(ALookAndFeelPainter: TcxCustomLookAndFeelPainterClass): Integer; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetIsPressed: Boolean; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetSummaryItemIndex: Integer; virtual;
    function GetText: string; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function GetVisible: Boolean; override;
    function HasCustomDraw: Boolean; override;
    property Summary: TcxDataSummary read GetSummary;
  public
    function GetBestFitWidth: Integer; override;
    property SummaryItemIndex: Integer read GetSummaryItemIndex;
  end;

  TcxGridFooterViewInfoClass = class of TcxGridFooterViewInfo;

  TcxGridFooterViewInfo = class(TcxGridHeaderViewInfo)
  protected
    function CalculateBounds: TRect; override;
    function CalculateHeight: Integer; override;
    function CalculateItemHeight: Integer; override;
    procedure CalculateItem(AIndex: Integer); virtual;
    procedure CalculateItems; override;
    function CanCalculateAutoWidths: Boolean; override;
    function GetAlignment: TcxGridPartAlignment; override;
    function GetAutoHeight: Boolean; override;
    function GetBackgroundBitmap: TBitmap; override;
    function GetBordersBounds: TRect; virtual;
    function GetBorders: TcxBorders; override;
    function GetBorderWidth(AIndex: TcxBorder): Integer; override;
    function GetColumnWidth(AColumn: TcxGridColumn): Integer; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetIsAutoWidth: Boolean; override;
    function GetIsScrollable: Boolean; override;
    function GetItemClass: TcxGridColumnHeaderViewInfoClass; override;
    function GetItemHeight(AIndex: Integer): Integer; virtual;
    function GetItemLeftBound(AIndex: Integer): Integer; virtual;
    function GetItemsAreaBounds: TRect; override;
    function GetItemTopBound(AIndex: Integer): Integer; virtual;
    function GetKind: TcxGridColumnContainerKind; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetSeparatorBounds: TRect; virtual;
    function GetSeparatorColor: TColor; virtual;
    function GetSeparatorWidth: Integer; virtual;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function GetVisible: Boolean; override;
    function HasSeparator: Boolean; virtual;
    function IsAlwaysVisibleForCalculation: Boolean; override;
    function IsHeightAssigned: Boolean; override;
    function IsItemVisible(AIndex: Integer): Boolean; virtual;
    procedure Offset(DX, DY: Integer); override;
  public
    property BordersBounds: TRect read GetBordersBounds;
    property SeparatorBounds: TRect read GetSeparatorBounds;
    property SeparatorColor: TColor read GetSeparatorColor;
    property SeparatorWidth: Integer read GetSeparatorWidth;
  end;

  // filter

  TcxGridFilterButtonAlignment = (fbaLeft, fbaRight);

  TcxCustomGridFilterButtonViewInfoClass = class of TcxCustomGridFilterButtonViewInfo;

  TcxCustomGridFilterButtonViewInfo = class(TcxCustomGridViewCellViewInfo)
  private
    FContainer: TcxGridFilterButtonsViewInfo;
    function GetFilter: TcxDataFilterCriteria;
    function GetGridView: TcxGridTableView;
  protected
    function GetAlignment: TcxGridFilterButtonAlignment; virtual;
    function GetCanvas: TcxCanvas; override;
    function GetHotTrack: Boolean; override;
    function GetVisible: Boolean; override;
    procedure StateChanged; override;

    property Container: TcxGridFilterButtonsViewInfo read FContainer;
    property Filter: TcxDataFilterCriteria read GetFilter;
  public
    constructor Create(AContainer: TcxGridFilterButtonsViewInfo); virtual;
    property Alignment: TcxGridFilterButtonAlignment read GetAlignment;
    property GridView: TcxGridTableView read GetGridView;
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
    function GetTextAreaBounds: TRect; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function GetVisible: Boolean; override;
  end;

  TcxGridFilterButtonsViewInfoClass = class of TcxGridFilterButtonsViewInfo;

  TcxGridFilterButtonsViewInfo = class
  private
    FFilterViewInfo: TcxGridFilterViewInfo;
    FItems: TList;
    function GetCount: Integer;
    function GetGridView: TcxGridTableView;
    function GetHeight: Integer;
    function GetItem(Index: Integer): TcxCustomGridFilterButtonViewInfo;
    function GetWidth(AAlignment: TcxGridFilterButtonAlignment): Integer;
    function GetWidthLeftPart: Integer;
    function GetWidthRightPart: Integer;
    procedure DestroyItems;
  protected
    procedure AddItems; virtual;
    property FilterViewInfo: TcxGridFilterViewInfo read FFilterViewInfo;
    property GridView: TcxGridTableView read GetGridView;
  public
    constructor Create(AFilterViewInfo: TcxGridFilterViewInfo); virtual;
    destructor Destroy; override;
    procedure AddItem(AItemClass: TcxCustomGridFilterButtonViewInfoClass);
    procedure Calculate(const ABounds: TRect); virtual;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; virtual;

    property Count: Integer read GetCount;
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
    function GetFiltering: TcxGridTableFiltering;
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
    function GetIsAutoWidth: Boolean; override;
    function GetIsScrollable: Boolean; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetText: string; override;
    function GetTextAreaBounds: TRect; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function GetVisible: Boolean; override;

    function GetButtonsViewInfoClass: TcxGridFilterButtonsViewInfoClass; virtual;

    property Filter: TcxDataFilterCriteria read GetFilter;
    property Filtering: TcxGridTableFiltering read GetFiltering;
  public
    constructor Create(AGridViewInfo: TcxGridTableViewInfo); override;
    destructor Destroy; override;
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); override;
//    procedure Calculate; override;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
    property ButtonsViewInfo: TcxGridFilterButtonsViewInfo read FButtonsViewInfo;
  end;

  // indicator

  TcxCustomGridIndicatorItemViewInfoClass = class of TcxCustomGridIndicatorItemViewInfo;

  TcxCustomGridIndicatorItemViewInfo = class(TcxCustomGridViewCellViewInfo)
  private
    FContainer: TcxGridIndicatorViewInfo;
    function GetGridView: TcxGridTableView;
    function GetGridViewInfo: TcxGridTableViewInfo;
  protected
    function CalculateWidth: Integer; override;
    function CustomDraw(ACanvas: TcxCanvas): Boolean; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function HasCustomDraw: Boolean; override;
  public
    constructor Create(AContainer: TcxGridIndicatorViewInfo); virtual;
    destructor Destroy; override;
    property Container: TcxGridIndicatorViewInfo read FContainer;
    property GridView: TcxGridTableView read GetGridView;
    property GridViewInfo: TcxGridTableViewInfo read GetGridViewInfo;
  end;

  TcxGridIndicatorHeaderItemViewInfo = class(TcxCustomGridIndicatorItemViewInfo)
  protected
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
  end;

  TcxGridIndicatorRowItemViewInfo = class(TcxCustomGridIndicatorItemViewInfo)
  private
    FRowViewInfo: TcxCustomGridRowViewInfo;
    function GetGridRecord: TcxCustomGridRow;
    function GetGridView: TcxGridTableView;
  protected
    function GetBackgroundBitmap: TBitmap; override;
    function GetIndicatorKind: TcxIndicatorKind; virtual;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetRowSizingEdgeBounds: TRect; virtual;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); override;
    property RowSizingEdgeBounds: TRect read GetRowSizingEdgeBounds;
  public
    destructor Destroy; override;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
    function MouseDown(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; override;
    property GridRecord: TcxCustomGridRow read GetGridRecord;
    property GridView: TcxGridTableView read GetGridView;
    property IndicatorKind: TcxIndicatorKind read GetIndicatorKind;
    property RowViewInfo: TcxCustomGridRowViewInfo read FRowViewInfo write FRowViewInfo;
  end;

  TcxGridIndicatorFooterItemViewInfo = class(TcxCustomGridIndicatorItemViewInfo)
  private
    function GetSeparatorWidth: Integer;
  protected
    function GetBackgroundBitmap: TBitmap; override;
    function GetBorders: TcxBorders; override;
    function GetBordersBounds: TRect; virtual;
    function GetBorderWidth(AIndex: TcxBorder): Integer; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetSeparatorBounds: TRect; virtual;
    function HasSeparator: Boolean;
  public
    property BordersBounds: TRect read GetBordersBounds;
    property SeparatorBounds: TRect read GetSeparatorBounds;
    property SeparatorWidth: Integer read GetSeparatorWidth;
  end;

  TcxGridIndicatorViewInfoClass = class of TcxGridIndicatorViewInfo;

  TcxGridIndicatorViewInfo = class(TcxCustomGridViewCellViewInfo)
  private
    FItems: TList;
    function GetCount: Integer;
    function GetGridView: TcxGridTableView;
    function GetGridViewInfo: TcxGridTableViewInfo;
    function GetItem(Index: Integer): TcxCustomGridIndicatorItemViewInfo;
    procedure DestroyItems;
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function GetBackgroundBitmap: TBitmap; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function GetVisible: Boolean; override;
    function GetWidth: Integer; override;

    function AddItem(AItemClass: TcxCustomGridIndicatorItemViewInfoClass): TcxCustomGridIndicatorItemViewInfo; overload;
    function AddItem(ATopBound, AHeight: Integer;
      AItemClass: TcxCustomGridIndicatorItemViewInfoClass): TcxCustomGridIndicatorItemViewInfo; overload;
  public
    constructor Create(AGridViewInfo: TcxGridTableViewInfo); virtual;
    destructor Destroy; override;
    function AddRowItem(ARowViewInfo: TcxCustomGridRowViewInfo): TcxCustomGridIndicatorItemViewInfo;
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); override;
    procedure CalculateRowItem(ARowViewInfo: TcxCustomGridRowViewInfo;
      AItem: TcxCustomGridIndicatorItemViewInfo);
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
    function GetRowItemBounds(AGridRecord: TcxCustomGridRow): TRect;
    property Count: Integer read GetCount;
    property GridView: TcxGridTableView read GetGridView;
    property GridViewInfo: TcxGridTableViewInfo read GetGridViewInfo;
    property Items[Index: Integer]: TcxCustomGridIndicatorItemViewInfo read GetItem;
  end;

  // custom row

  TcxGridRowFooterCellViewInfo = class(TcxGridFooterCellViewInfo)
  private
    function GetContainer: TcxGridRowFooterViewInfo;
    function GetGridRecord: TcxCustomGridRow;
    function GetRowViewInfo: TcxCustomGridRowViewInfo;
  protected
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetSummaryItemIndex: Integer; override;
    function GetText: string; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
  public
    property Container: TcxGridRowFooterViewInfo read GetContainer;
    property GridRecord: TcxCustomGridRow read GetGridRecord;
    property RowViewInfo: TcxCustomGridRowViewInfo read GetRowViewInfo;
  end;

  TcxGridRowFooterViewInfoClass = class of TcxGridRowFooterViewInfo;

  TcxGridRowFooterViewInfo = class(TcxGridFooterViewInfo)
  private
    FContainer: TcxGridRowFootersViewInfo;
    FLevel: Integer;
    function GetIndent: Integer;
    function GetGridRecord: TcxCustomGridRow;
    function GetGroupLevel: Integer;
    function GetRowViewInfo: TcxCustomGridRowViewInfo;
  protected
    function CalculateBounds: TRect; override;
    function CalculateWidth: Integer; override;
    function GetColumnWidth(AColumn: TcxGridColumn): Integer; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetIsPart: Boolean; override;
    function GetItemClass: TcxGridColumnHeaderViewInfoClass; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function GetVisible: Boolean; override;
    function HasSeparator: Boolean; override;
    property Indent: Integer read GetIndent;
  public
    constructor Create(AContainer: TcxGridRowFootersViewInfo; ALevel: Integer); reintroduce; virtual;
    property Container: TcxGridRowFootersViewInfo read FContainer;
    property GridRecord: TcxCustomGridRow read GetGridRecord;
    property GroupLevel: Integer read GetGroupLevel;
    property Level: Integer read FLevel;
    property RowViewInfo: TcxCustomGridRowViewInfo read GetRowViewInfo;
  end;

  TcxGridRowFootersViewInfoClass = class of TcxGridRowFootersViewInfo;

  TcxGridRowFootersViewInfo = class
  private
    FHeight: Integer;
    FItems: TList;
    FRowViewInfo: TcxCustomGridRowViewInfo;
    function GetCount: Integer;
    function GetGridViewInfo: TcxGridTableViewInfo;
    function GetHeight: Integer;
    function GetItem(Index: Integer): TcxGridRowFooterViewInfo;
    function GetVisibleItem(Index: Integer): TcxGridRowFooterViewInfo;
    procedure CreateItems;
    procedure DestroyItems;
  protected
    procedure BeforeRecalculation; virtual;
    procedure Calculate(ALeftBound, ATopBound: Integer); virtual;
    function CalculateHeight: Integer; virtual;
    function GetItemClass: TcxGridRowFooterViewInfoClass; virtual;
  public
    constructor Create(ARowViewInfo: TcxCustomGridRowViewInfo); virtual;
    destructor Destroy; override;
    function GetCellBestFitWidth(ACellIndex: Integer): Integer;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; virtual;
    procedure Offset(DX, DY: Integer); virtual;
    procedure Paint;

    property Count: Integer read GetCount;
    property GridViewInfo: TcxGridTableViewInfo read GetGridViewInfo;
    property Items[Index: Integer]: TcxGridRowFooterViewInfo read GetItem; default;
    property Height: Integer read GetHeight;
    property RowViewInfo: TcxCustomGridRowViewInfo read FRowViewInfo;
    property VisibleItems[Index: Integer]: TcxGridRowFooterViewInfo read GetVisibleItem;
  end;

  TcxCustomGridRowViewInfoClass = class of TcxCustomGridRowViewInfo;

  TcxCustomGridRowViewInfo = class(TcxCustomGridRecordViewInfo)
  private
    FFootersViewInfo: TcxGridRowFootersViewInfo;
    FIndicatorItem: TcxCustomGridIndicatorItemViewInfo;
    function GetCacheItem: TcxGridTableViewInfoCacheItem;
    function GetGridView: TcxGridTableView;
    function GetGridLines: TcxGridLines;
    function GetGridRecord: TcxCustomGridRow;
    function GetGridViewInfo: TcxGridTableViewInfo;
    function GetHasSeparator: Boolean;
    function GetLevel: Integer;
    function GetLevelIndent: Integer;
    function GetLevelIndentBounds(Index: Integer): TRect;
    function GetLevelIndentHorzLineBounds(Index: Integer): TRect;
    function GetLevelIndentSpaceBounds(Index: Integer): TRect;
    function GetLevelIndentVertLineBounds(Index: Integer): TRect;
    function GetRecordsViewInfo: TcxGridRowsViewInfo;
    function GetSeparatorWidth: Integer;
    procedure CreateFootersViewInfo;
    procedure DestroyFootersViewInfo;
    procedure RecreateFootersViewInfo;
  protected
    function CalculateHeight: Integer; override;
    function CalculateLevelIndentHorzLineBounds(ALevel: Integer; const ABounds: TRect): TRect;
    function CalculateLevelIndentSpaceBounds(ALevel: Integer; const ABounds: TRect): TRect;
    function CalculateLevelIndentVertLineBounds(ALevel: Integer; const ABounds: TRect): TRect;
    function CalculateWidth: Integer; override;
    function CanSize: Boolean; virtual;
    procedure CheckRowHeight(var AValue: Integer); virtual; abstract;
    function GetAutoHeight: Boolean; override;
    function GetBaseHeight: Integer; virtual;
    function GetBottomPartHeight: Integer; virtual;
    function GetCellTransparent(ACell: TcxGridTableCellViewInfo): Boolean; override;
    function GetContentBounds: TRect; override;
    function GetContentIndent: Integer; virtual;
    function GetContentWidth: Integer; override;
    function GetDataHeight: Integer; virtual;
    function GetDataIndent: Integer; virtual;
    function GetDataWidth: Integer; virtual;
    function GetFocusRectBounds: TRect; override;
    function GetFootersViewInfoClass: TcxGridRowFootersViewInfoClass; virtual;
    function GetLastHorzGridLineBounds: TRect; virtual;
    function GetMaxHeight: Integer; virtual;
    function GetNonBaseHeight: Integer; virtual;
    function GetRowHeight: Integer; virtual;
    function GetSeparatorBounds: TRect; virtual;
    function GetSeparatorColor: TColor; virtual;
    function GetShowSeparator: Boolean; virtual;
    function GetVisible: Boolean; override;
    function GetWidth: Integer; override;
    function HasFooter(ALevel: Integer): Boolean; virtual;
    function HasLastHorzGridLine: Boolean; virtual;
    procedure Offset(DX, DY: Integer); override;
    procedure SetRowHeight(Value: Integer); virtual; abstract;

    property BaseHeight: Integer read GetBaseHeight;
    property BottomPartHeight: Integer read GetBottomPartHeight;
    property CacheItem: TcxGridTableViewInfoCacheItem read GetCacheItem;
    property IndicatorItem: TcxCustomGridIndicatorItemViewInfo read FIndicatorItem;
    property LastHorzGridLineBounds: TRect read GetLastHorzGridLineBounds;
    property Level: Integer read GetLevel;
    property LevelIndent: Integer read GetLevelIndent;
    property NonBaseHeight: Integer read GetNonBaseHeight;
    property RowHeight: Integer read GetRowHeight write SetRowHeight;
    property ShowSeparator: Boolean read GetShowSeparator;
  public
    constructor Create(ARecordsViewInfo: TcxCustomGridRecordsViewInfo;
      ARecord: TcxCustomGridRecord); override;
    destructor Destroy; override;
    procedure BeforeRecalculation; override;
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); override;
    function Click(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; override;
    function GetBoundsForInvalidate(AItem: TcxCustomGridTableItem): TRect; override;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;

    property ContentIndent: Integer read GetContentIndent;
    property DataHeight: Integer read GetDataHeight;
    property DataIndent: Integer read GetDataIndent;
    property DataWidth: Integer read GetDataWidth;
    property FootersViewInfo: TcxGridRowFootersViewInfo read FFootersViewInfo;
    property GridView: TcxGridTableView read GetGridView;
    property GridLines: TcxGridLines read GetGridLines;
    property GridRecord: TcxCustomGridRow read GetGridRecord;
    property GridViewInfo: TcxGridTableViewInfo read GetGridViewInfo;
    property HasSeparator: Boolean read GetHasSeparator;
    property LevelIndentBounds[Index: Integer]: TRect read GetLevelIndentBounds;
    property LevelIndentHorzLineBounds[Index: Integer]: TRect read GetLevelIndentHorzLineBounds;
    property LevelIndentSpaceBounds[Index: Integer]: TRect read GetLevelIndentSpaceBounds;
    property LevelIndentVertLineBounds[Index: Integer]: TRect read GetLevelIndentVertLineBounds;
    property MaxHeight: Integer read GetMaxHeight;
    property RecordsViewInfo: TcxGridRowsViewInfo read GetRecordsViewInfo;
    property SeparatorBounds: TRect read GetSeparatorBounds;
    property SeparatorColor: TColor read GetSeparatorColor;
    property SeparatorWidth: Integer read GetSeparatorWidth;
  end;

  // rows

  TcxGridRowsViewInfoClass = class of TcxGridRowsViewInfo;

  TcxGridRowsViewInfo = class(TcxCustomGridRecordsViewInfo)
  private
    FContentBounds: TRect;
    FDataRowHeight: Integer;
    FGroupRowHeight: Integer;
    FNewItemRowViewInfo: TcxCustomGridRowViewInfo;
    FRestHeight: Integer;
    FRowHeight: Integer;
    function GetGridView: TcxGridTableView;
    function GetGridLines: TcxGridLines;
    function GetGridViewInfo: TcxGridTableViewInfo;
    function GetHasNewItemRecord: Boolean;
    function GetHeaderViewInfo: TcxGridHeaderViewInfo;
    function GetItem(Index: Integer): TcxCustomGridRowViewInfo;
    function GetNewItemRowViewInfo: TcxCustomGridRowViewInfo;
    function GetPainterClassValue: TcxGridRowsPainterClass;
    function GetViewData: TcxGridViewData;
  protected
    FPartVisibleCount: Integer;
    procedure Calculate; override;
    function CalculateBounds: TRect; override;
    procedure CalculateConsts; virtual;
    function CalculateContentBounds: TRect; virtual;
    function CalculateDataRowHeight: Integer; virtual;
    function CalculateGroupRowHeight: Integer; virtual;
    function CalculateRestHeight(ATopBound: Integer): Integer; virtual;
    function CalculateRowHeight: Integer; virtual;
    procedure CalculateVisibleCount; override;
    function GetAutoDataRecordHeight: Boolean; override;
    function GetCommonDataRowHeight: Integer; virtual;
    function GetGroupBackgroundBitmap: TBitmap; virtual;
    function GetItemLeftBound(AIndex: Integer): Integer; override;
    function GetItemsOffset(AItemCountDelta: Integer): Integer; override;
    function GetItemTopBound(AIndex: Integer): Integer; override;
    function GetIsScrollable: Boolean; virtual;
    function GetNewItemRowViewInfoClass: TcxCustomGridRowViewInfoClass; virtual;
    function GetPainterClass: TcxCustomGridRecordsPainterClass; override;
    function GetRowWidth: Integer; virtual;
    function GetSeparatorWidth: Integer; virtual;
    function GetShowNewItemRow: Boolean; virtual;
    function HasLastHorzGridLine(ARowViewInfo: TcxCustomGridRowViewInfo): Boolean; virtual;
    procedure OffsetItem(AIndex, AOffset: Integer); override;

    property GridView: TcxGridTableView read GetGridView;
    property GridViewInfo: TcxGridTableViewInfo read GetGridViewInfo;
    property HasNewItemRecord: Boolean read GetHasNewItemRecord;
    property HeaderViewInfo: TcxGridHeaderViewInfo read GetHeaderViewInfo;
    property IsScrollable: Boolean read GetIsScrollable;
    property ShowNewItemRow: Boolean read GetShowNewItemRow;
    property ViewData: TcxGridViewData read GetViewData;
  public
    destructor Destroy; override;
    procedure AfterConstruction; override;
    function CalculateCustomGroupRowHeight(AParams: TcxViewParams): Integer; virtual;
    function CanDataRowSize: Boolean; virtual;
    function GetCellHeight(ACellContentHeight: Integer): Integer; override;
    function GetDataRowCellsAreaViewInfoClass: TClass; virtual;
    function GetFooterCellBestFitWidth(ACellIndex: Integer): Integer;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
    function GetRealItem(ARecord: TcxCustomGridRecord; ARecordIndex: Integer): TcxCustomGridRecordViewInfo; override;
    function GetRestHeight(ATopBound: Integer): Integer; virtual;
    function IsDataRowHeightAssigned: Boolean; virtual;
    procedure Offset(DX, DY: Integer); override;

    property CommonDataRowHeight: Integer read GetCommonDataRowHeight;
    property ContentBounds: TRect read FContentBounds;
    property DataRowHeight: Integer read FDataRowHeight;
    property GridLines: TcxGridLines read GetGridLines;
    property GroupBackgroundBitmap: TBitmap read GetGroupBackgroundBitmap;
    property GroupRowHeight: Integer read FGroupRowHeight write FGroupRowHeight;
    property Items[Index: Integer]: TcxCustomGridRowViewInfo read GetItem; default;
    property NewItemRowViewInfo: TcxCustomGridRowViewInfo read GetNewItemRowViewInfo;
    property PainterClass: TcxGridRowsPainterClass read GetPainterClassValue;
    property PartVisibleCount: Integer read FPartVisibleCount;
    property RowHeight: Integer read FRowHeight write FRowHeight;
    property RowWidth: Integer read GetRowWidth;
    property SeparatorWidth: Integer read GetSeparatorWidth;
  end;

  // table

  TcxGridTableViewInfo = class(TcxCustomGridTableViewInfo)
  private
    FDataWidth: Integer;
    FFooterViewInfo: TcxGridFooterViewInfo;
    FFilterViewInfo: TcxGridFilterViewInfo;
    FGroupByBoxViewInfo: TcxGridGroupByBoxViewInfo;
    FHeaderViewInfo: TcxGridHeaderViewInfo;
    FIndicatorViewInfo: TcxGridIndicatorViewInfo;
    FParts: TList;
    FPrevDataRowHeight: Integer;

    function GetController: TcxGridTableController;
    function GetDataWidth: Integer;
    function GetGridView: TcxGridTableView;
    function GetGridLineColor: TColor;
    function GetGridLines: TcxGridLines;
    function GetLeftPos: Integer;
    function GetLevelIndentBackgroundBitmap: TBitmap;
    function GetLevelIndentColor(Index: Integer): TColor;
    function GetPart(Index: Integer): TcxCustomGridPartViewInfo;
    function GetPartCount: Integer;
    function GetPartsBottomHeight: Integer;
    function GetPartsCustomHeight(AAlignment: TcxGridPartAlignment): Integer;
    function GetPartsTopHeight: Integer;
    function GetRecordsViewInfo: TcxGridRowsViewInfo;
    function GetViewData: TcxGridViewData;

    procedure AddPart(AItem: TcxCustomGridPartViewInfo);
    procedure RemovePart(AItem: TcxCustomGridPartViewInfo);
  protected
    procedure AfterCalculating; override;
    procedure BeforeCalculating; override;
    procedure CreateViewInfos; override;
    procedure DestroyViewInfos(AIsRecreating: Boolean); override;
    procedure Calculate; override;
    function CalculateClientBounds: TRect; override;
    procedure CalculateHeight(const AMaxSize: TPoint; var AHeight: Integer;
      var AFullyVisible: Boolean); override;
    function CalculateVisibleEqualHeightRecordCount: Integer; override;
    procedure CalculateWidth(const AMaxSize: TPoint; var AWidth: Integer); override;
    function GetDefaultGridModeBufferCount: Integer; override;
    procedure Offset(DX, DY: Integer); override;
    procedure RecreateViewInfos; override;

    function GetFooterPainterClass: TcxGridFooterPainterClass; virtual;
    function GetRecordsViewInfoClass: TcxCustomGridRecordsViewInfoClass; override;

    function CalculateDataWidth: Integer; virtual;
    function CalculatePartBounds(APart: TcxCustomGridPartViewInfo): TRect; virtual;
    function GetFilterViewInfoClass: TcxGridFilterViewInfoClass; virtual;
    function GetFirstItemAdditionalWidth: Integer; virtual;
    function GetFooterViewInfoClass: TcxGridFooterViewInfoClass; virtual;
    function GetGridLineWidth: Integer; virtual;
    function GetGroupByBoxViewInfoClass: TcxGridGroupByBoxViewInfoClass; virtual;
    function GetHeaderViewInfoClass: TcxGridHeaderViewInfoClass; virtual;
    function GetIndicatorViewInfoClass: TcxGridIndicatorViewInfoClass; virtual;
    function GetLevelSeparatorColor: TColor; virtual;
    function GetHeaderViewInfoSpecificClass: TcxGridHeaderViewInfoSpecificClass; virtual;
    function GetNonRowsAreaHeight(ACheckScrollBar: Boolean): Integer; virtual;
    function GetScrollableAreaBoundsHorz: TRect; override;
    function GetScrollableAreaBoundsVert: TRect; override;

    property Controller: TcxGridTableController read GetController;
    property PartCount: Integer read GetPartCount;
    property Parts[Index: Integer]: TcxCustomGridPartViewInfo read GetPart;
    property ViewData: TcxGridViewData read GetViewData;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    destructor Destroy; override;
    function GetCellBorders(AIsRight, AIsBottom: Boolean): TcxBorders; virtual;
    function GetCellHeight(AIndex, ACellHeight: Integer): Integer; virtual;
    function GetCellTopOffset(AIndex, ACellHeight: Integer): Integer; virtual;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
    function GetOffsetBounds(AItemsOffset: Integer; out AUpdateBounds: TRect): TRect; overload; virtual;
    function GetOffsetBounds(DX, DY: Integer; out AUpdateBounds: TRect): TRect; overload; virtual;

    // for extended lookup edit
    function GetNearestPopupHeight(AHeight: Integer; AAdditionalRecord: Boolean = False): Integer; override;
    function GetPopupHeight(ADropDownRowCount: Integer): Integer; override;

    property DataWidth: Integer read GetDataWidth;
    property FilterViewInfo: TcxGridFilterViewInfo read FFilterViewInfo;
    property FirstItemAdditionalWidth: Integer read GetFirstItemAdditionalWidth;
    property FooterViewInfo: TcxGridFooterViewInfo read FFooterViewInfo;
    property GridLineColor: TColor read GetGridLineColor;
    property GridLines: TcxGridLines read GetGridLines;
    property GridLineWidth: Integer read GetGridLineWidth;
    property GridView: TcxGridTableView read GetGridView;
    property GroupByBoxViewInfo: TcxGridGroupByBoxViewInfo read FGroupByBoxViewInfo;
    property HeaderViewInfo: TcxGridHeaderViewInfo read FHeaderViewInfo;
    property IndicatorViewInfo: TcxGridIndicatorViewInfo read FIndicatorViewInfo;
    property LeftPos: Integer read GetLeftPos;
    property LevelIndentBackgroundBitmap: TBitmap read GetLevelIndentBackgroundBitmap;
    property LevelIndentColors[Index: Integer]: TColor read GetLevelIndentColor;
    property LevelSeparatorColor: TColor read GetLevelSeparatorColor;
    property PartsBottomHeight: Integer read GetPartsBottomHeight;
    property PartsTopHeight: Integer read GetPartsTopHeight;
    property RecordsViewInfo: TcxGridRowsViewInfo read GetRecordsViewInfo;
  end;

  // cache

  TcxGridTableViewInfoCacheItem = class(TcxCustomGridTableViewInfoCacheItem)
  private
    FIsPreviewHeightAssigned: Boolean;
    FPreviewHeight: Integer;
    procedure SetPreviewHeight(Value: Integer);
  public
    procedure UnassignValues(AKeepMaster: Boolean); override;
    property IsPreviewHeightAssigned: Boolean read FIsPreviewHeightAssigned
      write FIsPreviewHeightAssigned;
    property PreviewHeight: Integer read FPreviewHeight write SetPreviewHeight;
  end;

  TcxGridMasterTableViewInfoCacheItem = class(TcxGridTableViewInfoCacheItem)
  private
    FIsDetailsSiteHeightAssigned: Boolean;
    FIsDetailsSiteNormalHeightAssigned: Boolean;
    FIsDetailsSiteWidthAssigned: Boolean;
    FDetailsSiteHeight: Integer;
    FDetailsSiteNormalHeight: Integer;
    FDetailsSiteWidth: Integer;
    FUnassigningValues: Boolean;
    function GetGridRecord: TcxGridMasterDataRow;
    procedure SetDetailsSiteHeight(Value: Integer);
    procedure SetDetailsSiteNormalHeight(Value: Integer);
    procedure SetDetailsSiteWidth(Value: Integer);
  protected
    property GridRecord: TcxGridMasterDataRow read GetGridRecord;
  public
    procedure UnassignValues(AKeepMaster: Boolean); override;
    property IsDetailsSiteHeightAssigned: Boolean read FIsDetailsSiteHeightAssigned
      write FIsDetailsSiteHeightAssigned;
    property IsDetailsSiteNormalHeightAssigned: Boolean read FIsDetailsSiteNormalHeightAssigned
      write FIsDetailsSiteNormalHeightAssigned;
    property IsDetailsSiteWidthAssigned: Boolean read FIsDetailsSiteWidthAssigned
      write FIsDetailsSiteWidthAssigned;
    property DetailsSiteHeight: Integer read FDetailsSiteHeight write SetDetailsSiteHeight;
    property DetailsSiteNormalHeight: Integer read FDetailsSiteNormalHeight
      write SetDetailsSiteNormalHeight;
    property DetailsSiteWidth: Integer read FDetailsSiteWidth write SetDetailsSiteWidth;
  end;

  TcxGridTableViewInfoCache = class(TcxCustomGridTableViewInfoCache)
  protected
    function GetItemClass: TcxCustomGridViewInfoCacheItemClass; override;
  end;

  { view }

  // column

  TcxGridColumnOptions = class(TcxCustomGridTableItemOptions)
  private
    FHorzSizing: Boolean;
    function GetGridView: TcxGridTableView;
    procedure SetHorzSizing(Value: Boolean);
  protected
    property GridView: TcxGridTableView read GetGridView;
  public
    constructor Create(AItem: TcxCustomGridTableItem); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Grouping;
    property HorzSizing: Boolean read FHorzSizing write SetHorzSizing default True;
    property Moving;
    property Sorting;
  end;

  TcxGridGetHeaderStyleEvent = procedure(Sender: TcxGridTableView;
    AColumn: TcxGridColumn; {$IFDEF BCB}var{$ELSE}out{$ENDIF} AStyle: TcxStyle) of object;

  TcxGridColumnStyles = class(TcxCustomGridTableItemStyles)
  private
    FOnGetFooterStyle: TcxGridGetCellStyleEvent;
    FOnGetHeaderStyle: TcxGridGetHeaderStyleEvent;
    function GetGridViewValue: TcxGridTableView;
    function GetItem: TcxGridColumn;
  protected
    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure GetFooterParams(ARecord: TcxCustomGridRecord; out AParams: TcxViewParams); virtual;
    procedure GetHeaderParams(out AParams: TcxViewParams); virtual;
    property GridView: TcxGridTableView read GetGridViewValue;
    property Item: TcxGridColumn read GetItem;
  published
    property Footer: TcxStyle index isFooter read GetValue write SetValue;
    property Header: TcxStyle index isHeader read GetValue write SetValue;
    property OnGetFooterStyle: TcxGridGetCellStyleEvent read FOnGetFooterStyle write FOnGetFooterStyle;
    property OnGetHeaderStyle: TcxGridGetHeaderStyleEvent read FOnGetHeaderStyle write FOnGetHeaderStyle;
  end;

  TcxGridColumnCustomDrawHeaderEvent = procedure(Sender: TcxGridTableView; ACanvas: TcxCanvas;
    AViewInfo: TcxGridColumnHeaderViewInfo; var ADone: Boolean) of object;

  TcxGridColumnUserFilteringEvent = procedure(Sender: TcxGridColumn;
    const AValue: Variant; const ADisplayText: string) of object;

  TcxGridColumn = class(TcxCustomGridTableItem)
  private
    FFooterAlignmentHorz: TAlignment;
    FHeaderGlyph: TBitmap;
    FHeaderGlyphAlignmentHorz: TAlignment;
    FHeaderGlyphAlignmentVert: TcxAlignmentVert;
    FHidden: Boolean;
    FIsFooterAlignmentHorzAssigned: Boolean;
    FOnCustomDrawFooterCell: TcxGridColumnCustomDrawHeaderEvent;
    FOnCustomDrawHeader: TcxGridColumnCustomDrawHeaderEvent;
    FOnHeaderClick: TNotifyEvent;
    FOnUserFiltering: TcxGridColumnUserFilteringEvent;

    function GetFooterAlignmentHorz: TAlignment;
    function GetGridView: TcxGridTableView;
    function GetHidden: Boolean;
    function GetIsPreview: Boolean;
    function GetOptions: TcxGridColumnOptions;
    function GetStyles: TcxGridColumnStyles;
    procedure SetFooterAlignmentHorz(Value: TAlignment);
    procedure SetHeaderGlyph(Value: TBitmap);
    procedure SetHeaderGlyphAlignmentHorz(Value: TAlignment);
    procedure SetHeaderGlyphAlignmentVert(Value: TcxAlignmentVert);
    procedure SetHidden(Value: Boolean);
    procedure SetIsPreview(Value: Boolean);
    procedure SetOptions(Value: TcxGridColumnOptions);
    procedure SetStyles(Value: TcxGridColumnStyles);

    function IsFooterAlignmentHorzStored: Boolean;
    function IsHiddenStored: Boolean;

    procedure HeaderGlyphChanged(Sender: TObject);
  protected
    // IcxStoredObject
    function GetStoredProperties(AProperties: TStrings): Boolean; override;
    procedure GetPropertyValue(const AName: string; var AValue: Variant); override;
    procedure SetPropertyValue(const AName: string; const AValue: Variant); override;

    procedure CreateSubClasses; override;
    procedure DestroySubClasses; override;

    procedure AssignColumnWidths; virtual;
    function CanFilter(ACheckGridViewOptions: Boolean): Boolean; override;
    function CanHorzSize: Boolean; override;
    procedure CaptionChanged; override;
    procedure ForceWidth(Value: Integer); override;
    function GetBestFitWidth: Integer; override;
    function GetFilterable: Boolean; override;
    function GetFixed: Boolean; override;
    function GetIsBottom: Boolean; virtual;
    function GetIsLeft: Boolean; virtual;
    function GetIsMostBottom: Boolean; virtual;
    function GetIsMostLeft: Boolean; virtual;
    function GetIsMostRight: Boolean; virtual;
    function GetIsRight: Boolean; virtual;
    function GetVisible: Boolean; override;
    function HasCustomDrawFooterCell: Boolean;
    function HasCustomDrawHeader: Boolean;
    procedure HiddenChanged; virtual;
    function HideOnGrouping: Boolean; virtual;
    function IsVisibleStored: Boolean; override;
    //procedure VisibleChanged; dynamic;

    function GetHeaderViewInfoClass: TcxGridColumnHeaderViewInfoClass;
    function GetOptionsClass: TcxCustomGridTableItemOptionsClass; override;
    function GetStylesClass: TcxCustomGridTableItemStylesClass; override;
    function GetViewInfoClass: TcxCustomGridCellViewInfoClass;

    procedure DoCustomDrawFooterCell(ACanvas: TcxCanvas; AViewInfo: TcxGridColumnHeaderViewInfo;
      var ADone: Boolean); virtual;
    procedure DoCustomDrawHeader(ACanvas: TcxCanvas; AViewInfo: TcxGridColumnHeaderViewInfo;
      var ADone: Boolean); virtual;
    procedure DoHeaderClick; virtual;
    procedure DoUserFiltering(const AValue: Variant; const ADisplayText: string); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property GridView: TcxGridTableView read GetGridView;
    property Filtered;
    property IsBottom: Boolean read GetIsBottom;
    property IsLeft: Boolean read GetIsLeft;
    property IsMostBottom: Boolean read GetIsMostBottom;
    property IsMostLeft: Boolean read GetIsMostLeft;
    property IsMostRight: Boolean read GetIsMostRight;
    property IsPreview: Boolean read GetIsPreview write SetIsPreview;
    property IsRight: Boolean read GetIsRight;
  published
    property FooterAlignmentHorz: TAlignment read GetFooterAlignmentHorz write SetFooterAlignmentHorz
      stored IsFooterAlignmentHorzStored;
    property GroupIndex;
    property HeaderAlignmentHorz;
    property HeaderAlignmentVert;
    property HeaderGlyph: TBitmap read FHeaderGlyph write SetHeaderGlyph;
    property HeaderGlyphAlignmentHorz: TAlignment read FHeaderGlyphAlignmentHorz
      write SetHeaderGlyphAlignmentHorz default taLeftJustify;
    property HeaderGlyphAlignmentVert: TcxAlignmentVert read FHeaderGlyphAlignmentVert
      write SetHeaderGlyphAlignmentVert default vaCenter;
    property Hidden: Boolean read GetHidden write SetHidden stored IsHiddenStored;
    property MinWidth;
    property Options: TcxGridColumnOptions read GetOptions write SetOptions;
    property SortOrder;
    property Styles: TcxGridColumnStyles read GetStyles write SetStyles;
    property Width;
    property OnCustomDrawFooterCell: TcxGridColumnCustomDrawHeaderEvent read FOnCustomDrawFooterCell write FOnCustomDrawFooterCell;
    property OnCustomDrawHeader: TcxGridColumnCustomDrawHeaderEvent read FOnCustomDrawHeader write FOnCustomDrawHeader;
    property OnHeaderClick: TNotifyEvent read FOnHeaderClick write FOnHeaderClick;
    property OnGetFilterDisplayText;
    property OnGetFilterValues;
    property OnUserFiltering: TcxGridColumnUserFilteringEvent read FOnUserFiltering write FOnUserFiltering;
  end;

  // options

  {4}
  TcxGridTableBackgroundBitmaps = class(TcxCustomGridTableBackgroundBitmaps)
  protected
    function GetBitmapStyleIndex(Index: Integer): Integer; override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property FilterBox: TBitmap index bbFilterBox read GetValue write SetValue;
    property Footer: TBitmap index bbFooter read GetValue write SetValue;
    property Header: TBitmap index bbHeader read GetValue write SetValue;
    property Group: TBitmap index bbGroup read GetValue write SetValue;
    property GroupByBox: TBitmap index bbGroupByBox read GetValue write SetValue;
    property Indicator: TBitmap index bbIndicator read GetValue write SetValue;
    property Preview: TBitmap index bbPreview read GetValue write SetValue;
  end;

  // behavior

  TcxGridTableOptionsBehavior = class(TcxCustomGridTableOptionsBehavior)
  private
    FExpandMasterRowOnDblClick: Boolean;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    procedure Assign(Source: TPersistent); override;
  published
    property BestFitMaxRecordCount;
    property ExpandMasterRowOnDblClick: Boolean read FExpandMasterRowOnDblClick write FExpandMasterRowOnDblClick default True;
    property FocusCellOnCycle;
    property PullFocusing;
  end;

  // filter

  TcxGridFilterItemList = class;

  TcxCustomGridFilterItem = class
  private
    FParent: TcxGridFilterItemList;
  protected
    function GetIsList: Boolean; virtual; abstract;
  public
    constructor Create(AParent: TcxGridFilterItemList);
    destructor Destroy; override;
    property IsList: Boolean read GetIsList;
    property Parent: TcxGridFilterItemList read FParent;
  end;

  TcxGridFilterItem = class(TcxCustomGridFilterItem)
  private
    FDisplayText: string;
    FColumn: TcxGridColumn;
    FOperatorKind: TcxFilterOperatorKind;
    FValue: Variant;
  protected
    function GetIsList: Boolean; override;
  public
    constructor Create(AParent: TcxGridFilterItemList; AColumn: TcxGridColumn;
      AOperatorKind: TcxFilterOperatorKind; const AValue: Variant;
      const ADisplayText: string);
    property Column: TcxGridColumn read FColumn;
    property DisplayText: string read FDisplayText write FDisplayText;
    property OperatorKind: TcxFilterOperatorKind read FOperatorKind write FOperatorKind;
    property Value: Variant read FValue write FValue;
  end;

  TcxGridFilterItemList = class(TcxCustomGridFilterItem)
  private
    FBoolOperatorKind: TcxFilterBoolOperatorKind;
    FItems: TList;
    FOnChange: TNotifyEvent;
    function GetCount: Integer;
    function GetItem(Index: Integer): TcxCustomGridFilterItem;
    procedure SetBoolOperatorKind(Value: TcxFilterBoolOperatorKind);
    procedure InternalAddItem(AItem: TcxCustomGridFilterItem);
    procedure InternalRemoveItem(AItem: TcxCustomGridFilterItem);
  protected
    procedure Changed; virtual;
    function GetIsList: Boolean; override;
  public
    constructor Create(AParent: TcxGridFilterItemList; ABoolOperatorKind: TcxFilterBoolOperatorKind);
    destructor Destroy; override;
    function AddItem(AColumn: TcxGridColumn; AOperatorKind: TcxFilterOperatorKind;
      const AValue: Variant; const ADisplayText: string): TcxGridFilterItem;
    function AddItemList(ABoolOperatorKind: TcxFilterBoolOperatorKind): TcxGridFilterItemList;
    procedure Assign(ACriteriaItemList: TcxFilterCriteriaItemList);
    procedure AssignTo(ACriteriaItemList: TcxFilterCriteriaItemList);
    procedure Clear;
    function HasItem(AItem: TcxCustomGridFilterItem): Boolean;

    property BoolOperatorKind: TcxFilterBoolOperatorKind read FBoolOperatorKind
      write SetBoolOperatorKind;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TcxCustomGridFilterItem read GetItem; default;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TcxGridTableFiltering = class(TcxCustomGridTableFiltering)
  published
    property CustomizeDialog;
    property DropDownWidth;
    property MaxDropDownCount;
    property Visible;
  end;

  // customize

  TcxGridTableOptionsCustomizeClass = class of TcxGridTableOptionsCustomize;

  TcxGridTableOptionsCustomize = class(TcxCustomGridTableOptionsCustomize)
  private
    FColumnFiltering: Boolean;
    FColumnHiding: Boolean;
    FColumnHidingOnGrouping: Boolean;
    FColumnHorzSizing: Boolean;
    FDataRowSizing: Boolean;
    FGroupRowSizing: Boolean;
    function GetColumnGrouping: Boolean;
    function GetColumnMoving: Boolean;
    function GetColumnSorting: Boolean;
    function GetGridView: TcxGridTableView;
    procedure SetColumnFiltering(Value: Boolean);
    procedure SetColumnGrouping(Value: Boolean);
    procedure SetColumnHorzSizing(Value: Boolean);
    procedure SetColumnMoving(Value: Boolean);
    procedure SetColumnSorting(Value: Boolean);
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    procedure Assign(Source: TPersistent); override;
    property GridView: TcxGridTableView read GetGridView;
  published
    property ColumnFiltering: Boolean read FColumnFiltering write SetColumnFiltering default True;
    property ColumnGrouping: Boolean read GetColumnGrouping write SetColumnGrouping default True;
    property ColumnHiding: Boolean read FColumnHiding write FColumnHiding default False;
    property ColumnHidingOnGrouping: Boolean read FColumnHidingOnGrouping write FColumnHidingOnGrouping default True;
    property ColumnHorzSizing: Boolean read FColumnHorzSizing write SetColumnHorzSizing default True;
    property ColumnMoving: Boolean read GetColumnMoving write SetColumnMoving default True;
    property ColumnSorting: Boolean read GetColumnSorting write SetColumnSorting default True;
    property DataRowSizing: Boolean read FDataRowSizing write FDataRowSizing default False;
    property GroupRowSizing: Boolean read FGroupRowSizing write FGroupRowSizing default False;
  end;

  // data

  TcxGridTableOptionsData = class(TcxCustomGridTableOptionsData);

  // selection

  TcxGridTableOptionsSelection = class(TcxCustomGridTableOptionsSelection);

  // view

  TcxGridGroupFootersMode = (gfInvisible, gfVisibleWhenExpanded, gfAlwaysVisible);

  TcxGridTableOptionsView = class(TcxCustomGridTableOptionsView)
  private
    FColumnAutoWidth: Boolean;
    FDataRowHeight: Integer;
    FExpandButtonsForEmptyDetails: Boolean;
    FFooter: Boolean;
    FGridLineColor: TColor;
    FGridLines: TcxGridLines;
    FGroupByBox: Boolean;
    FGroupFooters: TcxGridGroupFootersMode;
    FGroupRowHeight: Integer;
    FHeader: Boolean;
    FHeaderHeight: Integer;
    FIndicator: Boolean;
    FIndicatorWidth: Integer;
    FNewItemRow: Boolean;
    FNewItemRowInfoText: string;
    FNewItemRowSeparatorColor: TColor;
    FNewItemRowSeparatorWidth: Integer;
    FRowSeparatorColor: TColor;
    FRowSeparatorWidth: Integer;
    function GetGridView: TcxGridTableView;
    function GetHeaderAutoHeight: Boolean;
    function GetHeaderEndEllipsis: Boolean;
    procedure SetColumnAutoWidth(Value: Boolean);
    procedure SetDataRowHeight(Value: Integer);
    procedure SetExpandButtonsForEmptyDetails(Value: Boolean);
    procedure SetFooter(Value: Boolean);
    procedure SetGridLineColor(Value: TColor);
    procedure SetGridLines(Value: TcxGridLines);
    procedure SetGroupByBox(Value: Boolean);
    procedure SetGroupFooters(Value: TcxGridGroupFootersMode);
    procedure SetGroupRowHeight(Value: Integer);
    procedure SetHeader(Value: Boolean);
    procedure SetHeaderAutoHeight(Value: Boolean);
    procedure SetHeaderEndEllipsis(Value: Boolean);
    procedure SetHeaderHeight(Value: Integer);
    procedure SetIndicator(Value: Boolean);
    procedure SetIndicatorWidth(Value: Integer);
    procedure SetNewItemRow(Value: Boolean);
    procedure SetNewItemRowInfoText(const Value: string);
    procedure SetNewItemRowSeparatorColor(Value: TColor);
    procedure SetNewItemRowSeparatorWidth(Value: Integer);
    procedure SetRowSeparatorColor(Value: TColor);
    procedure SetRowSeparatorWidth(Value: Integer);
    function IsNewItemRowInfoTextStored: Boolean;
  protected
    procedure ItemCaptionAutoHeightChanged; override;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    procedure Assign(Source: TPersistent); override;
    procedure CheckDataRowHeight(var AValue: Integer); virtual;
    procedure CheckGroupRowHeight(var AValue: Integer); virtual;
    function GetGridLineColor: TColor;
    function GetNewItemRowSeparatorColor: TColor;
    function GetRowSeparatorColor: TColor;
    property GridView: TcxGridTableView read GetGridView;
  published
    property CellAutoHeight;
    property CellTextMaxLineCount;
    property ColumnAutoWidth: Boolean read FColumnAutoWidth write SetColumnAutoWidth default False;
    property DataRowHeight: Integer read FDataRowHeight write SetDataRowHeight default 0;
    property ExpandButtonsForEmptyDetails: Boolean read FExpandButtonsForEmptyDetails
      write SetExpandButtonsForEmptyDetails default True;
    property Footer: Boolean read FFooter write SetFooter default False;
    property GridLineColor: TColor read FGridLineColor write SetGridLineColor default clDefault;
    property GridLines: TcxGridLines read FGridLines write SetGridLines default glBoth;
    property GroupByBox: Boolean read FGroupByBox write SetGroupByBox default True;
    property GroupFooters: TcxGridGroupFootersMode read FGroupFooters write SetGroupFooters default gfInvisible;
    property GroupRowHeight: Integer read FGroupRowHeight write SetGroupRowHeight default 0;
    property Header: Boolean read FHeader write SetHeader default True;
    property HeaderAutoHeight: Boolean read GetHeaderAutoHeight write SetHeaderAutoHeight default False;
    property HeaderEndEllipsis: Boolean read GetHeaderEndEllipsis write SetHeaderEndEllipsis default False;
    property HeaderHeight: Integer read FHeaderHeight write SetHeaderHeight default 0;
    property Indicator: Boolean read FIndicator write SetIndicator default False;
    property IndicatorWidth: Integer read FIndicatorWidth write SetIndicatorWidth default cxGridDefaultIndicatorWidth;
    property NewItemRow: Boolean read FNewItemRow write SetNewItemRow default False;
    property NewItemRowInfoText: string read FNewItemRowInfoText write SetNewItemRowInfoText
      stored IsNewItemRowInfoTextStored;
    property NewItemRowSeparatorColor: TColor read FNewItemRowSeparatorColor
      write SetNewItemRowSeparatorColor default clDefault;
    property NewItemRowSeparatorWidth: Integer read FNewItemRowSeparatorWidth
      write SetNewItemRowSeparatorWidth default cxGridDefaultNewItemRowSeparatorWidth;
    property RowSeparatorColor: TColor read FRowSeparatorColor write SetRowSeparatorColor default clDefault;
    property RowSeparatorWidth: Integer read FRowSeparatorWidth write SetRowSeparatorWidth default 0;
  end;

  // preview

  TcxGridPreviewPlace = (ppBottom, ppTop);

  TcxGridPreviewClass = class of TcxGridPreview;

  TcxGridPreview = class(TcxCustomGridOptions)
  private
    FAutoHeight: Boolean;
    FColumn: TcxGridColumn;
    FLeftIndent: Integer;
    FMaxLineCount: Integer;
    FPlace: TcxGridPreviewPlace;
    FRightIndent: Integer;
    FVisible: Boolean;
    function GetActive: Boolean;
    procedure SetAutoHeight(Value: Boolean);
    procedure SetColumn(Value: TcxGridColumn);
    procedure SetLeftIndent(Value: Integer);
    procedure SetMaxLineCount(Value: Integer);
    procedure SetPlace(Value: TcxGridPreviewPlace);
    procedure SetRightIndent(Value: Integer);
    procedure SetVisible(Value: Boolean);
  protected
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure SizeChanged;
    function GridView: TcxGridTableView; reintroduce;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    procedure Assign(Source: TPersistent); override;
    property Active: Boolean read GetActive;
  published
    property AutoHeight: Boolean read FAutoHeight write SetAutoHeight default True;
    property Column: TcxGridColumn read FColumn write SetColumn;
    property LeftIndent: Integer read FLeftIndent write SetLeftIndent
      default cxGridPreviewDefaultLeftIndent;
    property MaxLineCount: Integer read FMaxLineCount write SetMaxLineCount
      default cxGridPreviewDefaultMaxLineCount;
    property Place: TcxGridPreviewPlace read FPlace write SetPlace default ppBottom;
    property RightIndent: Integer read FRightIndent write SetRightIndent
      default cxGridPreviewDefaultRightIndent;
    property Visible: Boolean read FVisible write SetVisible default False;
  end;

  // styles

  TcxGridGetGroupStyleEvent = procedure(Sender: TcxGridTableView; ARecord: TcxCustomGridRecord;
    ALevel: Integer; {$IFDEF BCB}var{$ELSE}out{$ENDIF} AStyle: TcxStyle) of object;

  TcxGridTableViewStyles = class(TcxCustomGridTableViewStyles)
  private
    FOnGetFooterStyle: TcxGridGetCellStyleEvent;
    FOnGetGroupStyle: TcxGridGetGroupStyleEvent;
    FOnGetHeaderStyle: TcxGridGetHeaderStyleEvent;
    FOnGetPreviewStyle: TcxGridGetCellStyleEvent;
    function GetGridViewValue: TcxGridTableView;
  protected
    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure GetContentParams(ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      out AParams: TcxViewParams); override;
    procedure GetFooterParams(ARecord: TcxCustomGridRecord; AItem: TcxGridColumn;
      out AParams: TcxViewParams); virtual;
    procedure GetGroupParams(ARecord: TcxCustomGridRecord; ALevel: Integer;
      out AParams: TcxViewParams); virtual;
    procedure GetHeaderParams(AItem: TcxGridColumn; out AParams: TcxViewParams); virtual;
    procedure GetPreviewParams(ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      out AParams: TcxViewParams); virtual;
    procedure GetRecordContentParams(ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      out AParams: TcxViewParams); override;
    property GridView: TcxGridTableView read GetGridViewValue;
  published
    property FilterBox: TcxStyle index vsFilterBox read GetValue write SetValue;
    property Footer: TcxStyle index vsFooter read GetValue write SetValue;
    property Group: TcxStyle index vsGroup read GetValue write SetValue;
    property GroupByBox: TcxStyle index vsGroupByBox read GetValue write SetValue;
    property Header: TcxStyle index vsHeader read GetValue write SetValue;
    property Indicator: TcxStyle index vsIndicator read GetValue write SetValue;
    property NewItemRowInfoText: TcxStyle index vsNewItemRowInfoText read GetValue write SetValue;
    property Preview: TcxStyle index vsPreview read GetValue write SetValue;
    property OnGetFooterStyle: TcxGridGetCellStyleEvent read FOnGetFooterStyle write FOnGetFooterStyle;
    property OnGetGroupStyle: TcxGridGetGroupStyleEvent read FOnGetGroupStyle write FOnGetGroupStyle;
    property OnGetHeaderStyle: TcxGridGetHeaderStyleEvent read FOnGetHeaderStyle write FOnGetHeaderStyle;
    property OnGetPreviewStyle: TcxGridGetCellStyleEvent read FOnGetPreviewStyle write FOnGetPreviewStyle;
  end;

  TcxGridTableViewStyleSheet = class(TcxCustomStyleSheet)
  private
    function GetStylesValue: TcxGridTableViewStyles;
    procedure SetStylesValue(Value: TcxGridTableViewStyles);
  public
    class function GetStylesClass: TcxCustomStylesClass; override;
  published
    property Styles: TcxGridTableViewStyles read GetStylesValue write SetStylesValue;
  end;

  // grid view

  TcxGridTableSummaryGroupItemLink = class(TcxDataSummaryGroupItemLink,
    {$IFNDEF DELPHI6}IUnknown,{$ENDIF} IcxStoredObject)
  private
    function GetColumn: TcxGridColumn;
    procedure SetColumn(Value: TcxGridColumn);
  protected
    // IInterface
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    // IcxStoredObject
    function GetObjectName: string;
    function GetProperties(AProperties: TStrings): Boolean;
    procedure GetPropertyValue(const AName: string; var AValue: Variant);
    procedure SetPropertyValue(const AName: string; const AValue: Variant);
  published
    property Column: TcxGridColumn read GetColumn write SetColumn;
  end;

  TcxGridTableSummaryItem = class(TcxDataSummaryItem,
    {$IFNDEF DELPHI6}IUnknown,{$ENDIF} IcxStoredObject)
  private
    function GetColumn: TcxGridColumn;
    function GetGridView: TcxGridTableView;
    procedure SetColumn(Value: TcxGridColumn);
  protected
    // IInterface
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    // IcxStoredObject
    function GetObjectName: string;
    function GetProperties(AProperties: TStrings): Boolean;
    procedure GetPropertyValue(const AName: string; var AValue: Variant);
    procedure SetPropertyValue(const AName: string; const AValue: Variant);
    property GridView: TcxGridTableView read GetGridView;
  published
    property Column: TcxGridColumn read GetColumn write SetColumn;
  end;

  TcxGridColumnEvent = procedure(Sender: TcxGridTableView; AColumn: TcxGridColumn) of object;
  TcxGridIndicatorCellCustomDrawEvent = procedure(Sender: TcxGridTableView;
    ACanvas: TcxCanvas; AViewInfo: TcxCustomGridIndicatorItemViewInfo; var ADone: Boolean) of object;
  TcxGridPartCustomDrawBackgroundEvent = procedure(Sender: TcxGridTableView;
    ACanvas: TcxCanvas; AViewInfo: TcxCustomGridCellViewInfo; var ADone: Boolean) of object;

  TcxGridTableView = class(TcxCustomGridTableView)
  private
    FPreview: TcxGridPreview;
    FOnColumnHeaderClick: TcxGridColumnEvent;
    FOnColumnPosChanged: TcxGridColumnEvent;
    FOnColumnSizeChanged: TcxGridColumnEvent;
    FOnCustomDrawColumnHeader: TcxGridColumnCustomDrawHeaderEvent;
    FOnCustomDrawFooterCell: TcxGridColumnCustomDrawHeaderEvent;
    FOnCustomDrawGroupCell: TcxGridTableCellCustomDrawEvent;
    FOnCustomDrawIndicatorCell: TcxGridIndicatorCellCustomDrawEvent;
    FOnCustomDrawPartBackground: TcxGridPartCustomDrawBackgroundEvent;
    FOnCustomization: TNotifyEvent;
    FOnLeftPosChanged: TNotifyEvent;

    function GetBackgroundBitmaps: TcxGridTableBackgroundBitmaps;
    function GetColumn(Index: Integer): TcxGridColumn;
    function GetColumnCount: Integer;
    function GetController: TcxGridTableController;
    function GetFiltering: TcxGridTableFiltering;
    function GetGroupedColumn(Index: Integer): TcxGridColumn;
    function GetGroupedColumnCount: Integer;
    function GetOptionsBehavior: TcxGridTableOptionsBehavior;
    function GetOptionsCustomize: TcxGridTableOptionsCustomize;
    function GetOptionsData: TcxGridTableOptionsData;
    function GetOptionsSelection: TcxGridTableOptionsSelection;
    function GetOptionsView: TcxGridTableOptionsView;
    function GetPainter: TcxGridTablePainter;
    function GetStyles: TcxGridTableViewStyles;
    function GetViewData: TcxGridViewData;
    function GetViewInfo: TcxGridTableViewInfo;
    function GetViewInfoCache: TcxGridTableViewInfoCache;
    function GetVisibleColumn(Index: Integer): TcxGridColumn;
    function GetVisibleColumnCount: Integer;
    procedure SetBackgroundBitmaps(Value: TcxGridTableBackgroundBitmaps);
    procedure SetColumn(Index: Integer; Value: TcxGridColumn);
    procedure SetFiltering(Value: TcxGridTableFiltering);
    procedure SetOptionsBehavior(Value: TcxGridTableOptionsBehavior);
    procedure SetOptionsCustomize(Value: TcxGridTableOptionsCustomize);
    procedure SetOptionsData(Value: TcxGridTableOptionsData);
    procedure SetOptionsSelection(Value: TcxGridTableOptionsSelection);
    procedure SetOptionsView(Value: TcxGridTableOptionsView);
    procedure SetPreview(Value: TcxGridPreview);
    procedure SetStyles(Value: TcxGridTableViewStyles);
  protected
    // IcxStoredObject
    function GetProperties(AProperties: TStrings): Boolean; override;
    procedure GetPropertyValue(const AName: string; var AValue: Variant); override;
    procedure SetPropertyValue(const AName: string; const AValue: Variant); override;

    procedure CreateOptions; override;
    procedure DestroyOptions; override;

    function CanOffset(ARecordCountDelta: Integer): Boolean; override;
    function CanOffsetHorz: Boolean; virtual;
    procedure DoAssign(ASource: TcxCustomGridView); override;
    function GetIsControlFocused: Boolean; override;
    function GetResizeOnBoundsChange: Boolean; override;
    function HasCustomDrawColumnHeader: Boolean;
    function HasCustomDrawFooterCell: Boolean;
    function HasCustomDrawGroupCell: Boolean;
    function HasCustomDrawIndicatorCell: Boolean;
    function HasCustomDrawPartBackground: Boolean;
    function IsEqualHeightRecords: Boolean; override;
    procedure LookAndFeelChanged; override;

    function GetControllerClass: TcxCustomGridControllerClass; override;
    function GetDataControllerClass: TcxCustomDataControllerClass; override;
    function GetPainterClass: TcxCustomGridPainterClass; override;
    function GetViewDataClass: TcxCustomGridViewDataClass; override;
    function GetViewInfoCacheClass: TcxCustomGridViewInfoCacheClass; override;
    function GetViewInfoClass: TcxCustomGridViewInfoClass; override;

    function GetBackgroundBitmapsClass: TcxCustomGridBackgroundBitmapsClass; override;
    function GetFilteringClass: TcxCustomGridTableFilteringClass; override;
    function GetOptionsBehaviorClass: TcxCustomGridTableOptionsBehaviorClass; override;
    function GetOptionsCustomizeClass: TcxCustomGridTableOptionsCustomizeClass; override;
    function GetOptionsSelectionClass: TcxCustomGridOptionsSelectionClass; override;
    function GetOptionsViewClass: TcxCustomGridOptionsViewClass; override;
    function GetPreviewClass: TcxGridPreviewClass; virtual;
    function GetStylesClass: TcxCustomGridViewStylesClass; override;

    function GetSummaryGroupItemLinkClass: TcxDataSummaryGroupItemLinkClass; override;
    function GetSummaryItemClass: TcxDataSummaryItemClass; override;

    function GetItemClass: TcxCustomGridTableItemClass; override;
    procedure ItemVisibilityChanged(AItem: TcxCustomGridTableItem; Value: Boolean); override;
    procedure RemoveItem(AItem: TcxCustomGridTableItem); override;

    procedure RefreshCustomizationForm;

    procedure DoColumnHeaderClick(AColumn: TcxGridColumn); virtual;
    procedure DoColumnPosChanged(AColumn: TcxGridColumn); virtual;
    procedure DoColumnSizeChanged(AColumn: TcxGridColumn); virtual;
    procedure DoCustomDrawColumnHeader(ACanvas: TcxCanvas; AViewInfo: TcxGridColumnHeaderViewInfo;
      var ADone: Boolean); virtual;
    procedure DoCustomDrawFooterCell(ACanvas: TcxCanvas; AViewInfo: TcxGridColumnHeaderViewInfo;
      var ADone: Boolean); virtual;
    procedure DoCustomDrawGroupCell(ACanvas: TcxCanvas; AViewInfo: TcxGridTableCellViewInfo;
      var ADone: Boolean); virtual;
    procedure DoCustomDrawIndicatorCell(ACanvas: TcxCanvas; AViewInfo: TcxCustomGridIndicatorItemViewInfo;
      var ADone: Boolean); virtual;
    procedure DoCustomDrawPartBackground(ACanvas: TcxCanvas; AViewInfo: TcxCustomGridCellViewInfo;
      var ADone: Boolean); virtual;
    procedure DoCustomization; virtual;
    procedure DoLeftPosChanged; virtual;
  public
    destructor Destroy; override;
    function CreateColumn: TcxGridColumn;

    // for extended lookup edit
    class function CanBeLookupList: Boolean; override;

    property ColumnCount: Integer read GetColumnCount;
    property Columns[Index: Integer]: TcxGridColumn read GetColumn write SetColumn;
    property Controller: TcxGridTableController read GetController;
    property GroupedColumnCount: Integer read GetGroupedColumnCount;
    property GroupedColumns[Index: Integer]: TcxGridColumn read GetGroupedColumn;
    property Painter: TcxGridTablePainter read GetPainter;
    property ViewData: TcxGridViewData read GetViewData;
    property ViewInfo: TcxGridTableViewInfo read GetViewInfo;
    property ViewInfoCache: TcxGridTableViewInfoCache read GetViewInfoCache;
    property VisibleColumnCount: Integer read GetVisibleColumnCount;
    property VisibleColumns[Index: Integer]: TcxGridColumn read GetVisibleColumn;
  published
    property BackgroundBitmaps: TcxGridTableBackgroundBitmaps read GetBackgroundBitmaps
      write SetBackgroundBitmaps;
    property Filtering: TcxGridTableFiltering read GetFiltering write SetFiltering;
    property OptionsBehavior: TcxGridTableOptionsBehavior read GetOptionsBehavior
      write SetOptionsBehavior;
    property OptionsCustomize: TcxGridTableOptionsCustomize read GetOptionsCustomize
      write SetOptionsCustomize;
    property OptionsData: TcxGridTableOptionsData read GetOptionsData write SetOptionsData;
    property OptionsSelection: TcxGridTableOptionsSelection read GetOptionsSelection
      write SetOptionsSelection;
    property OptionsView: TcxGridTableOptionsView read GetOptionsView write SetOptionsView;
    property Preview: TcxGridPreview read FPreview write SetPreview;
    property Styles: TcxGridTableViewStyles read GetStyles write SetStyles;

    property OnColumnHeaderClick: TcxGridColumnEvent read FOnColumnHeaderClick write FOnColumnHeaderClick;
    property OnColumnPosChanged: TcxGridColumnEvent read FOnColumnPosChanged write FOnColumnPosChanged;
    property OnColumnSizeChanged: TcxGridColumnEvent read FOnColumnSizeChanged write FOnColumnSizeChanged;
    property OnCustomDrawColumnHeader: TcxGridColumnCustomDrawHeaderEvent read FOnCustomDrawColumnHeader write FOnCustomDrawColumnHeader;
    property OnCustomDrawFooterCell: TcxGridColumnCustomDrawHeaderEvent read FOnCustomDrawFooterCell write FOnCustomDrawFooterCell;
    property OnCustomDrawGroupCell: TcxGridTableCellCustomDrawEvent read FOnCustomDrawGroupCell write FOnCustomDrawGroupCell;
    property OnCustomDrawIndicatorCell: TcxGridIndicatorCellCustomDrawEvent read FOnCustomDrawIndicatorCell write FOnCustomDrawIndicatorCell;
    property OnCustomDrawPartBackground: TcxGridPartCustomDrawBackgroundEvent read FOnCustomDrawPartBackground write FOnCustomDrawPartBackground;
    property OnCustomization: TNotifyEvent read FOnCustomization write FOnCustomization;
    property OnFilterControlDialogShow;
    property OnLeftPosChanged: TNotifyEvent read FOnLeftPosChanged write FOnLeftPosChanged;
  end;

implementation

uses
  SysUtils, Math,
{$IFDEF DELPHI6}
  Variants,
{$ENDIF}
  cxScrollBar, cxGridDetailsSite, cxGridRows, cxGridStrs, cxFilterConsts, cxLibraryConsts;

const
  GroupByBoxLeftOffset = 6;
  GroupByBoxTopOffset = 8;
  GroupByBoxHorOffset = 4;
  GroupByBoxLineVerOffset = 4;
  GroupByBoxColumnWidth = 100;
  GroupByBoxLineWidth = 1;
  GroupByBoxLineColor = clBtnText;
  HScrollDelta = 10;

  FooterSeparatorWidth = 1;

  FilterButtonsFirstOffset = 4;
  FilterButtonsOffset = 4;
  FilterTextOffset = 3;

  TopIndexNone = -2;
  RowIndexNone = -1;

  ColumnHeaderHitTestCodes = [htColumnHeader];

  ColumnHeaderMovingZoneSize = 15;

  DragAndDropArrowWidth = 11;
  DragAndDropArrowHeight = 9;
  DragAndDropArrowBorderColor = clBlack;
  DragAndDropArrowColor = clLime;

  ColumnSizingMarkWidth = 1;
  RowSizingMarkWidth = 1;

  ScrollHotZoneWidth = 15;
  ScrollTimeIntervalVert = 70;
  ScrollTimeIntervalHorz = ScrollTimeIntervalVert div 2;

type
  TcxControlAccess = class(TcxControl);
  TcxCustomGridCellViewInfoAccess = class(TcxCustomGridCellViewInfo);

{ TcxCustomGridColumnHitTest }

{procedure TcxCustomGridColumnHitTest.Assign(Source: TcxCustomGridHitTest);
begin
  if Source is TcxCustomGridColumnHitTest then
    with TcxCustomGridColumnHitTest(Source) do
    begin
      Self.Column := Column;
    end
  else
    inherited;
end;}

{ TcxGridGroupByBoxHitTest }

class function TcxGridGroupByBoxHitTest.GetHitTestCode: Integer;
begin
  Result := htGroupByBox;
end;

{ TcxGridColumnHeaderHitTest }

class function TcxGridColumnHeaderHitTest.GetHitTestCode: Integer;
begin
  Result := htColumnHeader;
end;

function TcxGridColumnHeaderHitTest.DragAndDropObjectClass: TcxCustomGridDragAndDropObjectClass;
begin
  if Column.CanMove then
    Result := TcxGridTableView(GridView).Controller.GetColumnHeaderDragAndDropObjectClass
  else
    Result := nil;
end;

{ TcxGridColumnHeaderHorzSizingEdgeHitTest }

class function TcxGridColumnHeaderHorzSizingEdgeHitTest.GetHitTestCode: Integer;
begin
  Result := htColumnHeaderHorzSizingEdge;
end;

class function TcxGridColumnHeaderHorzSizingEdgeHitTest.Cursor: TCursor;
begin
  Result := crcxGridHorzSize;
end;

function TcxGridColumnHeaderHorzSizingEdgeHitTest.DragAndDropObjectClass: TcxCustomGridDragAndDropObjectClass;
begin
  Result := TcxGridColumnHorzSizingObject;
end;

{ TcxGridColumnHeaderFilterButtonHitTest }

class function TcxGridColumnHeaderFilterButtonHitTest.GetHitTestCode: Integer;
begin
  Result := htColumnHeaderFilterButton;
end;

{ TcxGridHeaderHitTest }

class function TcxGridHeaderHitTest.GetHitTestCode: Integer;
begin
  Result := htHeader;
end;

{ TcxGridFooterHitTest }

class function TcxGridFooterHitTest.GetHitTestCode: Integer;
begin
  Result := htFooter;
end;

{ TcxGridFooterCellHitTest }

class function TcxGridFooterCellHitTest.GetHitTestCode: Integer;
begin
  Result := htFooterCell;
end;

{ TcxGridGroupFooterHitTest }

class function TcxGridGroupFooterHitTest.GetHitTestCode: Integer;
begin
  Result := htGroupFooter;
end;

{ TcxGridGroupFooterCellHitTest }

class function TcxGridGroupFooterCellHitTest.GetHitTestCode: Integer;
begin
  Result := htGroupFooterCell;
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

{ TcxGridFilterCustomizeButtonHitTest }

class function TcxGridFilterCustomizeButtonHitTest.GetHitTestCode: Integer;
begin
  Result := htFilterCustomizeButton;
end;

{ TcxGridRowIndicatorHitTest }

class function TcxGridRowIndicatorHitTest.GetHitTestCode: Integer;
begin
  Result := htRowIndicator;
end;

{ TcxGridRowSizingEdgeHitTest }

class function TcxGridRowSizingEdgeHitTest.GetHitTestCode: Integer;
begin
  Result := htRowSizingEdge;
end;

class function TcxGridRowSizingEdgeHitTest.Cursor: TCursor;
begin
  Result := crcxGridVertSize;
end;

function TcxGridRowSizingEdgeHitTest.DragAndDropObjectClass: TcxCustomGridDragAndDropObjectClass;
begin
  Result := TcxGridRowSizingObject;
end;

{ TcxGridIndicatorHitTest }

class function TcxGridIndicatorHitTest.GetHitTestCode: Integer;
begin
  Result := htIndicator;
end;

{ TcxGridRowLevelIndentHitTest }

class function TcxGridRowLevelIndentHitTest.GetHitTestCode: Integer;
begin
  Result := htRowLevelIndent;
end;

class function TcxGridRowLevelIndentHitTest.CanClick: Boolean;
begin
  Result := False;
end;

{ TcxGridCustomozationFormHitTest }

class function TcxGridCustomozationFormHitTest.GetHitTestCode: Integer;
begin
  Result := htCustomizationForm;
end;

{ TcxGridDragAndDropObject }

function TcxGridDragAndDropObject.GetController: TcxGridTableController;
begin
  Result := TcxGridTableController(inherited Controller);
end;

function TcxGridDragAndDropObject.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxGridDragAndDropObject.GetViewInfo: TcxGridTableViewInfo;
begin
  Result := TcxGridTableViewInfo(inherited ViewInfo);
end;

procedure TcxGridDragAndDropObject.AfterScrolling;
begin
end;

procedure TcxGridDragAndDropObject.BeforeScrolling;
begin
end;

{ TcxCustomGridMovingObject }

constructor TcxCustomGridMovingObject.Create(AControl: TcxControl);
begin
  inherited;
  FDragImagePos := Point(-1, -1);
end;

destructor TcxCustomGridMovingObject.Destroy;
begin
  FSavingBitmap.Free;
  inherited;
end;

function TcxCustomGridMovingObject.GetArrowPlace(AArrowNumber: TcxGridArrowNumber): TcxGridArrowPlace;
begin
  Result := TcxGridArrowPlace(2 * Ord(AArrowNumber) + Ord(AreArrowsVertical));
{  if AreArrowsVertical then
    if AArrowNumber = anFirst then
      Result := apTop
    else
      Result := apBottom
  else
    if AArrowNumber = anFirst then
      Result := apLeft
    else
      Result := apRight;}
end;

function TcxCustomGridMovingObject.GetCustomizationForm: TcxGridTableCustomizationForm;
begin
  Result := Controller.CustomizationForm;
end;

function TcxCustomGridMovingObject.GetDragImageSavingCanvas: TCanvas;
begin
  Result := DragImageSavingBitmap.Canvas;
end;

function TcxCustomGridMovingObject.GetSavingBitmap: TBitmap;
begin
  if FSavingBitmap = nil then
  begin
    FSavingBitmap := TBitmap.Create;
    with FSavingBitmap do
    begin
      Width := 2 * DragAndDropArrowWidth;
      Height := DragAndDropArrowWidth;
    end;
  end;
  Result := FSavingBitmap;
end;

function TcxCustomGridMovingObject.GetSavingCanvas: TCanvas;
begin
  Result := SavingBitmap.Canvas;
end;

procedure TcxCustomGridMovingObject.CreateDragImage;
begin
  FDragImage := TBitmap.Create;
  FDragImageCanvas := TcxCanvas.Create(FDragImage.Canvas);
  InitDragImage;
  FDragImageSavingBitmap := TBitmap.Create;
  with FDragImageSavingBitmap do
  begin
    Width := FDragImage.Width;
    Height := FDragImage.Height;
  end
end;

procedure TcxCustomGridMovingObject.DestroyDragImage;
begin
  FreeAndNil(FDragImageSavingBitmap);
  FreeAndNil(FDragImageCanvas);
  FreeAndNil(FDragImage);
end;

procedure TcxCustomGridMovingObject.AfterScrolling;
begin
  ChangeArrowsVisibility(True);
  ChangeDragImagePosition(True);
  inherited;
end;

procedure TcxCustomGridMovingObject.BeforeScrolling;
begin
  inherited;
  ChangeDragImagePosition(False);
  ChangeArrowsVisibility(False);
end;

procedure TcxCustomGridMovingObject.DirtyChanged;
begin
  inherited;
  if Dirty then
    ChangeDragImagePosition(False);
  ChangeArrowsVisibility(not Dirty);
  if not Dirty then
    ChangeDragImagePosition(True);
end;

function TcxCustomGridMovingObject.GetDragAndDropCursor(Accepted: Boolean): TCursor;
begin
  if Accepted then
    Result := crArrow
  else
    if CanRemove then
      Result := crcxGridRemove
    else
      Result := crcxGridNoDrop;
end;

procedure TcxCustomGridMovingObject.ChangeArrowsVisibility(AVisible: Boolean);
var
  ACanvas: TcxScreenCanvas;

  procedure SaveBackground;
  var
    R: TRect;
  begin
    R := ArrowBounds[ArrowPlaces[anFirst]];
    OffsetRect(R, -R.Left, -R.Top);
    SavingCanvas.CopyRect(R, ACanvas.Canvas, ArrowBounds[ArrowPlaces[anFirst]]);
    OffsetRect(R, R.Right - R.Left, 0);
    SavingCanvas.CopyRect(R, ACanvas.Canvas, ArrowBounds[ArrowPlaces[anLast]]);
  end;

  procedure RestoreBackground;
  var
    R: TRect;
  begin
    R := ArrowBounds[ArrowPlaces[anFirst]];
    OffsetRect(R, -R.Left, -R.Top);
    ACanvas.CopyRect(ArrowBounds[ArrowPlaces[anFirst]], SavingCanvas, R);
    OffsetRect(R, R.Right - R.Left, 0);
    ACanvas.CopyRect(ArrowBounds[ArrowPlaces[anLast]], SavingCanvas, R);
  end;

  procedure DrawArrows;

    procedure DrawArrow(AArrowPlace: TcxGridArrowPlace);
    var
      R: TRect;
      P: array[1..7] of TPoint;

      procedure CalculatePointsForLeftArrow;
      begin
        with R do
        begin
          P[1] := Point(Left + 3, Top);
          P[2] := Point(Left + 3, Top + 3);
          P[3] := Point(Left, Top + 3);
          P[4] := Point(Left, Bottom - 4);
          P[5] := Point(Left + 3, Bottom - 4);
          P[6] := Point(Left + 3, Bottom - 1);
          P[7] := Point(Right - 1, Top + 5);
        end;
      end;

      procedure CalculatePointsForTopArrow;
      begin
        with R do
        begin
          P[1] := Point(Left + 3, Top);
          P[2] := Point(Right - 4, Top);
          P[3] := Point(Right - 4, Top + 3);
          P[4] := Point(Right - 1, Top + 3);
          P[5] := Point(Left + 5, Bottom - 1);
          P[6] := Point(Left, Top + 3);
          P[7] := Point(Left + 3, Top + 3);
        end;
      end;

      procedure CalculatePointsForRightArrow;
      begin
        with R do
        begin
          P[1] := Point(Right - 4, Top);
          P[2] := Point(Right - 4, Top + 3);
          P[3] := Point(Right - 1, Top + 3);
          P[4] := Point(Right - 1, Bottom - 4);
          P[5] := Point(Right - 4, Bottom - 4);
          P[6] := Point(Right - 4, Bottom - 1);
          P[7] := Point(Left, Top + 5);
        end;
      end;

      procedure CalculatePointsForBottomArrow;
      begin
        with R do
        begin
          P[1] := Point(Left + 3, Bottom - 1);
          P[2] := Point(Right - 4, Bottom - 1);
          P[3] := Point(Right - 4, Bottom - 4);
          P[4] := Point(Right - 1, Bottom - 4);
          P[5] := Point(Left + 5, Top);
          P[6] := Point(Left, Bottom - 4);
          P[7] := Point(Left + 3, Bottom - 4);
        end;
      end;

    begin
      R := ArrowBounds[AArrowPlace];
      case AArrowPlace of
        apLeft:
          CalculatePointsForLeftArrow;
        apTop:
          CalculatePointsForTopArrow;
        apRight:
          CalculatePointsForRightArrow;
        apBottom:
          CalculatePointsForBottomArrow;
      end;
      ACanvas.Brush.Color := DragAndDropArrowColor;
      ACanvas.Pen.Color := DragAndDropArrowBorderColor;
      ACanvas.Polygon(P);
    end;

  begin
    DrawArrow(ArrowPlaces[anFirst]);
    DrawArrow(ArrowPlaces[anLast]);
  end;

begin
  if AVisible and not IsValidDestination then AVisible := False;
  if FArrowsVisible <> AVisible then
  begin
    FArrowsVisible := AVisible;
    ACanvas := TcxScreenCanvas.Create;
    try
      if FArrowsVisible then
      begin
        SaveBackground;
        DrawArrows;
      end
      else
        RestoreBackground;
    finally
      ACanvas.Free;
    end;
  end;  
end;

procedure TcxCustomGridMovingObject.ChangeDragImagePosition(AVisible: Boolean = True);
var
  ACanvas: TcxScreenCanvas;

  procedure SaveBackground;
  var
    AScreenR, ASaveR: TRect;
  begin
    FDragImageSavingPos := CurMousePos;
    AScreenR := GetDragImageBounds(FDragImageSavingPos);
    ASaveR := AScreenR;
    OffsetRect(ASaveR, -ASaveR.Left, -ASaveR.Top);
    DragImageSavingCanvas.CopyRect(ASaveR, ACanvas.Canvas, AScreenR);
  end;

  procedure RestoreBackground;
  var
    AScreenR, ASaveR: TRect;
  begin
    AScreenR := GetDragImageBounds(FDragImageSavingPos);
    ASaveR := AScreenR;
    OffsetRect(ASaveR, -ASaveR.Left, -ASaveR.Top);
    ACanvas.CopyRect(AScreenR, DragImageSavingCanvas, ASaveR);
  end;

  procedure DrawImage;
  var
    AScreenR, AImageR: TRect;
  begin
    AScreenR := GetDragImageBounds(FDragImagePos);
    AImageR := AScreenR;
    OffsetRect(AImageR, -AImageR.Left, -AImageR.Top);
    ACanvas.CopyRect(AScreenR, FDragImage.Canvas, AImageR);
  end;

  procedure ShowImage;
  begin
    FDragImagePos := CurMousePos;
    SaveBackground;
    DrawImage;
  end;

  procedure HideImage;
  begin
    RestoreBackground;
  end;

  procedure MoveImage;
  var
    AOldBounds, ANewBounds: TRect;

    function GetChangeBounds(const AOldBounds, ANewBounds: TRect; ABorder: TcxBorder): TRect;
    begin
      Result := ANewBounds;
      case ABorder of
        bLeft:
          Result.Right := AOldBounds.Left;
        bTop:
          Result.Bottom := AOldBounds.Top;
        bRight:
          Result.Left := AOldBounds.Right;
        bBottom:
          Result.Top := AOldBounds.Bottom;
      end;
    end;

    procedure RestoreChanges;
    var
      R: TRect;
      I: TcxBorder;

      procedure RestoreChange(const R: TRect);
      var
        ASavingBitmapR: TRect;
      begin
        if IsRectEmpty(R) then Exit;
        ASavingBitmapR := R;
        with AOldBounds do
          OffsetRect(ASavingBitmapR, -Left, -Top);
        ACanvas.CopyRect(R, DragImageSavingCanvas, ASavingBitmapR);
      end;

    begin
      if IntersectRect(R, AOldBounds, ANewBounds) then
        for I := Low(I) to High(I) do
          RestoreChange(GetChangeBounds(ANewBounds, AOldBounds, I))
      else
        RestoreChange(AOldBounds);
    end;

    procedure OffsetSavingBitmap;
    var
      R1, R2: TRect;
    begin
      R1 := AOldBounds;
      with R1 do
        OffsetRect(R1, -Left, -Top);
      R2 := R1;
      OffsetRect(R2, AOldBounds.Left - ANewBounds.Left, AOldBounds.Top - ANewBounds.Top);
      DragImageSavingCanvas.CopyRect(R2, DragImageSavingCanvas, R1);
    end;

    procedure SaveChanges;
    var
      I: TcxBorder;

      procedure SaveChange(const R: TRect);
      var
        ASavingBitmapR: TRect;
      begin
        if IsRectEmpty(R) then Exit;
        ASavingBitmapR := R;
        with ANewBounds do
          OffsetRect(ASavingBitmapR, -Left, -Top);
        DragImageSavingCanvas.CopyRect(ASavingBitmapR, ACanvas.Canvas, R);
      end;

    begin
      for I := Low(I) to High(I) do
        SaveChange(GetChangeBounds(AOldBounds, ANewBounds, I));
    end;

  begin
    FDragImagePos := CurMousePos;
    AOldBounds := GetDragImageBounds(FDragImageSavingPos);
    ANewBounds := GetDragImageBounds(FDragImagePos);
    FDragImageSavingPos := FDragImagePos;

    RestoreChanges;
    OffsetSavingBitmap;
    SaveChanges;
    DrawImage;
  end;

begin
  ACanvas := TcxScreenCanvas.Create;
  try
    if FDragImageVisible <> AVisible then
    begin
      FDragImageVisible := AVisible;
      if AVisible then
        ShowImage
      else
        HideImage;
    end
    else
      if FDragImageVisible and
        ((FDragImagePos.X <> CurMousePos.X) or (DragImagePos.Y <> CurMousePos.Y)) then
        MoveImage;
  finally
    ACanvas.Free;
  end;
end;

function TcxCustomGridMovingObject.AreArrowsVertical: Boolean;
begin
  Result := True;
end;

function TcxCustomGridMovingObject.CalculateDragImageOffset: TPoint;
begin
  with SourceItemBounds, SourcePoint do
  begin
    Result.X := MulDiv(X - Left, FDragImage.Width, Right - Left);
    Result.Y := MulDiv(Y - Top, FDragImage.Height, Bottom - Top);
  end;
end;

function TcxCustomGridMovingObject.GetArrowBounds(APlace: TcxGridArrowPlace): TRect;

  procedure CheckResult;

    procedure CheckValue(var Value: Integer);
    begin
      with ArrowsClientRect do
      begin
        if Value < Left then Value := Left;
        if Value > Right - 1 then Value := Right - 1;
      end;
    end;

  begin
    CheckValue(Result.Left);
    CheckValue(Result.Right);
  end;

  procedure CalculateHorizontalArrowBounds;
  begin
    Result.Bottom := Result.Top + 1;
    InflateRect(Result, 0, DragAndDropArrowWidth div 2);
    if APlace = apLeft then
    begin
      Result.Right := Result.Left;
      Dec(Result.Left, DragAndDropArrowHeight);
    end
    else
    begin
      Result.Left := Result.Right;
      Inc(Result.Right, DragAndDropArrowHeight);
    end;
  end;

  procedure CalculateVerticalArrowBounds;
  begin
    Result.Right := Result.Left + 1;
    InflateRect(Result, DragAndDropArrowWidth div 2, 0);
    if APlace = apTop then
    begin
      Result.Bottom := Result.Top;
      Dec(Result.Top, DragAndDropArrowHeight);
    end
    else
    begin
      Result.Top := Result.Bottom;
      Inc(Result.Bottom, DragAndDropArrowHeight);
    end;
  end;

  procedure ConvertToScreenCoordinates;
  begin
    with GridView.Site, Result do
    begin
      TopLeft := ClientToScreen(TopLeft);
      BottomRight := ClientToScreen(BottomRight);
    end;
  end;

begin
  Result := GetArrowAreaBounds(APlace);
  CheckResult;
  if APlace in [apLeft, apRight] then
    CalculateHorizontalArrowBounds
  else
    CalculateVerticalArrowBounds;
  ConvertToScreenCoordinates;
end;

function TcxCustomGridMovingObject.GetArrowsClientRect: TRect;
begin
  Result := ViewInfo.Bounds;
end;

function TcxCustomGridMovingObject.GetDragImageBounds(AMousePos: TPoint): TRect;
begin
  Result := Rect(0, 0, FDragImage.Width, FDragImage.Height);
  with Control.ClientToScreen(AMousePos) do
    OffsetRect(Result, X - FDragImageOffset.X, Y - FDragImageOffset.Y);
end;

function TcxCustomGridMovingObject.GetSourceItemBounds: TRect;
begin
  if SourceItemViewInfo <> nil then
    Result := SourceItemViewInfo.Bounds
  else
    if IsSourceCustomizationForm then
      with CustomizationFormListBox do
      begin
        Result := ItemRect(IndexOfItem(SourceItem));
        MapWindowRect(Handle, Control.Handle, Result);
      end
    else
      Result := Rect(0, 0, 0, 0);
end;

function TcxCustomGridMovingObject.GetSourceItemViewInfo: TcxCustomGridCellViewInfo;
begin
  Result := nil;
end;

procedure TcxCustomGridMovingObject.InitDragImage;

  procedure InitUsingSourceItemViewInfo;
  var
    AViewInfo: TcxCustomGridCellViewInfo;
  begin
    AViewInfo := SourceItemViewInfo;
    with AViewInfo.Bounds.TopLeft do
      SetViewportOrgEx(DragImage.Canvas.Handle, -X, -Y, nil);
    AViewInfo.Paint(DragImageCanvas);
  end;

  procedure InitFromCustomizationForm;
  var
    R: TRect;
  begin
    R := SourceItemBounds;
    with R do
      OffsetRect(R, -Left, -Top);
    with CustomizationFormListBox do
      PaintItem(DragImageCanvas, R, IndexOfItem(SourceItem), False);
  end;

begin
  with FDragImage, SourceItemBounds do
  begin
    Width := Right - Left;
    Height := Bottom - Top;
  end;
  if SourceItemViewInfo <> nil then
    InitUsingSourceItemViewInfo
  else
    if IsSourceCustomizationForm then
      InitFromCustomizationForm;
end;

procedure TcxCustomGridMovingObject.BeginDragAndDrop;
begin
  CreateDragImage;
  FDragImageOffset := CalculateDragImageOffset;
  Control.Update;
  inherited;
end;

procedure TcxCustomGridMovingObject.DragAndDrop(const P: TPoint; var Accepted: Boolean);
begin
  inherited;
  ChangeDragImagePosition;
  Controller.CheckScrolling(P);
end;

procedure TcxCustomGridMovingObject.EndDragAndDrop(Accepted: Boolean);
begin
  inherited;
  DestroyDragImage;
end;

{ TcxGridColumnHeaderMovingObject }

constructor TcxGridColumnHeaderMovingObject.Create(AControl: TcxControl);
begin
  inherited;
  FDestColumnContainerKind := ccNone;
end;

destructor TcxGridColumnHeaderMovingObject.Destroy;
begin
  DestZone := nil;
  inherited;
end;

procedure TcxGridColumnHeaderMovingObject.SetDestColumnContainerKind(Value: TcxGridColumnContainerKind);
begin
  if FDestColumnContainerKind <> Value then
  begin
    Dirty := True;
    FDestColumnContainerKind := Value;
  end;
end;

procedure TcxGridColumnHeaderMovingObject.SetDestZone(Value: TcxGridColumnContainerZone);
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

function TcxGridColumnHeaderMovingObject.CanRemove: Boolean;
begin
  Result :=
    (SourceColumnContainerKind = ccGroupByBox) and SourceColumn.CanGroup or
    (SourceColumnContainerKind = ccHeader) and SourceColumn.CanHide and
      (GridView.OptionsCustomize.ColumnHiding or GridView.Controller.Customization);
end;

procedure TcxGridColumnHeaderMovingObject.DoColumnMoving;
var
  AIndex: Integer;
begin
  with SourceColumn do
  begin
    if DestZone.ColumnIndex = GridView.VisibleColumnCount then
      AIndex := GridView.ColumnCount - 1
    else
    begin
      AIndex := GridView.VisibleColumns[DestZone.ColumnIndex].Index;
      if Index < AIndex then Dec(AIndex);
    end;
    Index := AIndex;
  end;
end;

function TcxGridColumnHeaderMovingObject.GetArrowAreaBounds(APlace: TcxGridArrowPlace): TRect;

  procedure CalculateForGroupByBox;
  begin
    with ViewInfo.GroupByBoxViewInfo do
      if DestZone.ColumnIndex = Count then
        if Count = 0 then
        begin
          Result := Bounds;
          Inc(Result.Left, GroupByBoxLeftOffset);
          InflateRect(Result, 0, -GroupByBoxTopOffset);
        end
        else
        begin
          Result := Items[Count - 1].Bounds;
          Result.Left := Result.Right + GroupByBoxHorOffset div 2;
        end
      else
      begin
        Result := Items[DestZone.ColumnIndex].Bounds;
        Dec(Result.Left, GroupByBoxHorOffset div 2);
        if DestZone.ColumnIndex <> 0 then
          OffsetRect(Result, 0, -GroupByBoxVerOffset div 2);
      end;
  end;

begin
  if DestColumnContainerKind = ccGroupByBox then
    CalculateForGroupByBox
  else
    Result := GetArrowAreaBoundsForHeader(APlace);
end;

function TcxGridColumnHeaderMovingObject.GetArrowAreaBoundsForHeader(APlace: TcxGridArrowPlace): TRect;
begin
  with ViewInfo.HeaderViewInfo do
    if DestZone.ColumnIndex = Count then
      if Count = 0 then
        Result := Bounds
      else
      begin
        Result := Items[Count - 1].Bounds;
        Result.Left := Result.Right;
      end
    else
      Result := Items[DestZone.ColumnIndex].Bounds;
end;

function TcxGridColumnHeaderMovingObject.GetCustomizationFormListBox: TcxCustomGridTableItemsListBox;
begin
  Result := CustomizationForm.ColumnsListBox;
end;

function TcxGridColumnHeaderMovingObject.GetSourceItem: TObject;
begin
  Result := SourceColumn;
end;

function TcxGridColumnHeaderMovingObject.GetSourceItemViewInfo: TcxCustomGridCellViewInfo;
begin
  case SourceColumnContainerKind of
    ccGroupByBox:
      Result := ViewInfo.GroupByBoxViewInfo[SourceColumn.GroupIndex];
    ccHeader:
      Result := ViewInfo.HeaderViewInfo[SourceColumn.VisibleIndex];
  else
    Result := inherited GetSourceItemViewInfo;
  end;
end;

function TcxGridColumnHeaderMovingObject.IsSourceCustomizationForm: Boolean;
begin
  Result := SourceColumnContainerKind = ccCustomizationForm;
end;

function TcxGridColumnHeaderMovingObject.IsValidDestination: Boolean;
begin
  Result := DestColumnContainerKind in [ccGroupByBox, ccHeader];
  if Result then
  begin
    case DestColumnContainerKind of
      ccGroupByBox:
        Result := SourceColumn.GroupIndex = -1;
      ccHeader:
        Result := not SourceColumn.Visible;
    end;
    Result := Result or IsValidDestinationForVisibleSource;
  end;
end;

function TcxGridColumnHeaderMovingObject.IsValidDestinationForVisibleSource: Boolean;
begin
  case DestColumnContainerKind of
    ccGroupByBox:
      Result :=
        (DestZone.ColumnIndex < SourceColumn.GroupIndex) or
        (SourceColumn.GroupIndex + 1 < DestZone.ColumnIndex);
    ccHeader:
      Result :=
        (SourceColumnContainerKind = ccGroupByBox) or
        (DestZone.ColumnIndex < SourceColumn.VisibleIndex) or
        (SourceColumn.VisibleIndex + 1 < DestZone.ColumnIndex);
  else
    Result := False;
  end;
end;

procedure TcxGridColumnHeaderMovingObject.BeginDragAndDrop;
begin
  if CustomizationForm <> nil then
    with CustomizationForm do
      ActivatePage(ColumnsPage);
  Controller.FMovingColumn := SourceColumn;
  inherited;
end;

procedure TcxGridColumnHeaderMovingObject.DragAndDrop(const P: TPoint; var Accepted: Boolean);
var
  ADestZone: TcxGridColumnContainerZone;
  AHitTest: TcxCustomGridHitTest;
begin
  ADestZone := nil;
  AHitTest := ViewInfo.GetHitTest(P);
  if AHitTest.HitTestCode = htCustomizationForm then
    DestColumnContainerKind := ccCustomizationForm
  else
  begin
    ADestZone := ViewInfo.GroupByBoxViewInfo.GetZone(P);
    if ADestZone = nil then
    begin
      ADestZone := ViewInfo.HeaderViewInfo.GetZone(P);
      if ADestZone = nil then
        DestColumnContainerKind := ccNone
      else
        DestColumnContainerKind := ccHeader;
    end
    else
      DestColumnContainerKind := ccGroupByBox;
  end;    
  DestZone := ADestZone;
  Accepted := DestColumnContainerKind <> ccNone;
  inherited;
end;

procedure TcxGridColumnHeaderMovingObject.EndDragAndDrop(Accepted: Boolean);
var
  APrevGroupIndex: Integer;
  AColumnPosChanged: Boolean;

  procedure DoColumnGrouping;
  begin
    if IsValidDestination then
      with SourceColumn do
        if CanGroup then
        begin
          GroupIndex := DestZone.ColumnIndex -
            Byte((GroupIndex <> -1) and (GroupIndex < DestZone.ColumnIndex));
          if HideOnGrouping and CanHide then Visible := False;
          AColumnPosChanged := True;
        end;
  end;

  procedure DoColumnRemoving;
  begin
    if not CanRemove then Exit;
    with SourceColumn do
      case SourceColumnContainerKind of
        ccGroupByBox:
          if CanGroup then
          begin
            GroupIndex := -1;
            if (DestColumnContainerKind <> ccCustomizationForm) and
              ShowOnUngrouping and WasVisibleBeforeGrouping then
              Visible := True;
            AColumnPosChanged := True;
          end;
        ccHeader:
          if CanHide then
          begin
            Visible := False;
            AColumnPosChanged := True;
          end;  
      end;
  end;

begin
  inherited;
  Controller.FMovingColumn := nil;
  if Accepted then
  begin
    AColumnPosChanged := False;
    APrevGroupIndex := SourceColumn.GroupIndex;
    case DestColumnContainerKind of
      ccGroupByBox:
        DoColumnGrouping;
      ccHeader:
        if IsValidDestination then
        begin
          DoColumnMoving;
          with SourceColumn do
          begin
            if (SourceColumnContainerKind = ccGroupByBox) and CanGroup then
              GroupIndex := -1;
            Visible := True;
          end;
          AColumnPosChanged := True;
        end;
    else
      DoColumnRemoving;
    end;
    if SourceColumn.GroupIndex <> APrevGroupIndex then
      Controller.MakeFocusedRecordVisible;
    if AColumnPosChanged then
      GridView.DoColumnPosChanged(SourceColumn);
  end;
end;

procedure TcxGridColumnHeaderMovingObject.Init(const P: TPoint; AParams: TcxCustomGridHitTest);
begin
  inherited;
  with AParams as TcxGridColumnHeaderHitTest do
  begin
    SourceColumn := Column;
    SourceColumnContainerKind := ColumnContainerKind;
  end;
end;

{ TcxCustomGridSizingObject }

procedure TcxCustomGridSizingObject.SetDestPointX(Value: Integer);
begin
  if FDestPointX <> Value then
  begin
    Dirty := True;
    FDestPointX := Value;
  end;
end;

procedure TcxCustomGridSizingObject.SetDestPointY(Value: Integer);
begin
  if FDestPointY <> Value then
  begin
    Dirty := True;
    FDestPointY := Value;
  end;
end;

procedure TcxCustomGridSizingObject.DirtyChanged;
begin
  Canvas.InvertRect(SizingMarkBounds);
end;

function TcxCustomGridSizingObject.GetCurrentSize: Integer;
begin
  Result := OriginalSize + DeltaSize;
end;

function TcxCustomGridSizingObject.GetDeltaSize: Integer;
begin
  if IsHorizontalSizing then
    Result := DestPointX - SourcePoint.X
  else
    Result := DestPointY - SourcePoint.Y;
end;

function TcxCustomGridSizingObject.GetDragAndDropCursor(Accepted: Boolean): TCursor;
begin
  if IsHorizontalSizing then
    Result := crcxGridHorzSize
  else
    Result := crcxGridVertSize;
end;

function TcxCustomGridSizingObject.GetHorzSizingMarkBounds: TRect;
begin
  with Result do
  begin
    Right := SizingItemBounds.Left + CurrentSize;
    Left := Right - SizingMarkWidth;
    Top := SizingItemBounds.Top;
    Bottom := ViewInfo.Bounds.Bottom - ViewInfo.PartsBottomHeight;
  end;
end;

function TcxCustomGridSizingObject.GetImmediateStart: Boolean;
begin
  Result := True;
end;

function TcxCustomGridSizingObject.GetIsHorizontalSizing: Boolean;
begin
  Result := True;
end;

function TcxCustomGridSizingObject.GetSizingMarkBounds: TRect;
begin
  if IsHorizontalSizing then
    Result := GetHorzSizingMarkBounds
  else
    Result := GetVertSizingMarkBounds;
end;

function TcxCustomGridSizingObject.GetVertSizingMarkBounds: TRect;
begin
  with Result do
  begin
    Left := ViewInfo.Bounds.Left;
    Right := ViewInfo.Bounds.Right;
    Bottom := SizingItemBounds.Top + CurrentSize;
    Top := Bottom - SizingMarkWidth;
  end;
end;

procedure TcxCustomGridSizingObject.DragAndDrop(const P: TPoint; var Accepted: Boolean);
begin
  if IsHorizontalSizing then
    DestPointX := P.X
  else
    DestPointY := P.Y;
  Accepted := True;
  inherited;
end;

procedure TcxCustomGridSizingObject.Init(const P: TPoint; AParams: TcxCustomGridHitTest);
begin
  inherited;
  FDestPointX := SourcePoint.X;
  FDestPointY := SourcePoint.Y;
end;

{ TcxCustomGridColumnSizingObject }

function TcxCustomGridColumnSizingObject.GetColumnHeaderViewInfo: TcxGridColumnHeaderViewInfo;
begin
  Result := ViewInfo.HeaderViewInfo[Column.VisibleIndex];
end;

function TcxCustomGridColumnSizingObject.GetSizingItemBounds: TRect;
begin
  Result := ColumnHeaderViewInfo.Bounds;
end;

function TcxCustomGridColumnSizingObject.GetSizingMarkWidth: Integer;
begin
  Result := ColumnSizingMarkWidth;
end;

procedure TcxCustomGridColumnSizingObject.Init(const P: TPoint; AParams: TcxCustomGridHitTest);
begin
  inherited;
  Column := (AParams as TcxCustomGridColumnHitTest).Column;
end;

{ TcxGridColumnHorzSizingObject }

function TcxGridColumnHorzSizingObject.GetCurrentSize: Integer;
begin
  Result := inherited GetCurrentSize;
  ColumnHeaderViewInfo.CheckWidth(Result);
end;

procedure TcxGridColumnHorzSizingObject.BeginDragAndDrop;
begin
  OriginalSize := ColumnHeaderViewInfo.Width;
  Controller.FHorzSizingColumn := Column;
  inherited;
end;

procedure TcxGridColumnHorzSizingObject.EndDragAndDrop(Accepted: Boolean);
begin
  inherited;
  if Accepted and (CurrentSize <> OriginalSize) then
  begin
    Column.ForceWidth(ColumnHeaderViewInfo.CalculateRealWidth(CurrentSize));
    Controller.FHorzSizingColumn := nil;
    GridView.SizeChanged;
    GridView.DoColumnSizeChanged(Column);
  end
  else
    Controller.FHorzSizingColumn := nil;
end;

{ TcxGridRowSizingObject }

function TcxGridRowSizingObject.GetRowViewInfo: TcxCustomGridRowViewInfo;
begin
  Result := TcxCustomGridRowViewInfo(FRow.ViewInfo);
end;

function TcxGridRowSizingObject.GetCurrentSize: Integer;
begin
  Result := inherited GetCurrentSize;
  RowViewInfo.CheckRowHeight(Result);
end;

function TcxGridRowSizingObject.GetIsHorizontalSizing: Boolean;
begin
  Result := False;
end;

function TcxGridRowSizingObject.GetSizingItemBounds: TRect;
begin                          //!!!
  Result := RowViewInfo.Bounds;
end;

function TcxGridRowSizingObject.GetSizingMarkWidth: Integer;
begin
  Result := RowSizingMarkWidth;
end;

procedure TcxGridRowSizingObject.BeginDragAndDrop;
begin
  OriginalSize := RowViewInfo.RowHeight;
  inherited;
end;

procedure TcxGridRowSizingObject.EndDragAndDrop(Accepted: Boolean);
begin
  inherited;
  if Accepted then
    RowViewInfo.RowHeight := CurrentSize;
end;

procedure TcxGridRowSizingObject.Init(const P: TPoint; AParams: TcxCustomGridHitTest);
begin
  inherited;
  FRow := TcxCustomGridRow((AParams as TcxGridRowSizingEdgeHitTest).GridRecord);
end;

{ TcxCustomGridTableItemsListBox }

constructor TcxCustomGridTableItemsListBox.Create(AOwner: TComponent);
begin
  inherited;
  Color := clBtnFace;
  Sorted := True;
  Style := lbOwnerDrawFixed;
  CalculateBorderStyle;
  FcxCanvas := TcxCanvas.Create(Canvas);
  FDragAndDropItemIndex := -1;
end;

destructor TcxCustomGridTableItemsListBox.Destroy;
begin
  FcxCanvas.Free;
  inherited;
end;

function TcxCustomGridTableItemsListBox.GetDragAndDropItem: TObject;
begin
  Result := Items.Objects[FDragAndDropItemIndex];
end;

function TcxCustomGridTableItemsListBox.GetGridView: TcxGridTableView;
begin
  Result := (Owner as TcxGridTableCustomizationForm).Controller.GridView;
end;

function TcxCustomGridTableItemsListBox.GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := (Owner as TcxGridTableCustomizationForm).ViewInfo.LookAndFeelPainter;
end;

procedure TcxCustomGridTableItemsListBox.WMCancelMode(var Message: TWMCancelMode);
begin
  inherited;
  FDragAndDropItemIndex := -1;
end;

procedure TcxCustomGridTableItemsListBox.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  inherited;
  if BorderStyle = bsNone then
    InflateRect(Message.CalcSize_Params^.rgrc[0], -1, -1);
end;

procedure TcxCustomGridTableItemsListBox.WMNCPaint(var Message: TWMNCPaint);
var
  R: TRect;
  DC: HDC;
begin
  inherited;
  if BorderStyle = bsNone then
  begin
    GetWindowRect(Handle, R);
    OffsetRect(R, -R.Left, -R.Top);
    DC := GetWindowDC(Handle);
    DrawEdge(DC, R, BDR_SUNKENOUTER, BF_RECT);
    ReleaseDC(Handle, DC);
  end;  
end;

procedure TcxCustomGridTableItemsListBox.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
    WindowClass.Style := WindowClass.Style or CS_HREDRAW;
end;

procedure TcxCustomGridTableItemsListBox.CreateWnd;
begin
  inherited;
  CalculateItemHeight;
end;

procedure TcxCustomGridTableItemsListBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
begin
  PaintItem(FcxCanvas, Rect, Index, odFocused in State);
  if odFocused in State then FcxCanvas.DrawFocusRect(Rect);
end;

procedure TcxCustomGridTableItemsListBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_ESCAPE then GridView.Site.FinishDragAndDrop(False);
end;

procedure TcxCustomGridTableItemsListBox.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  AItemIndex: Integer;
begin
  inherited;
  if Button = mbLeft then
  begin
    AItemIndex := ItemAtPos(Point(X, Y), True);
    if AItemIndex <> -1 then
    begin
      FDragAndDropItemIndex := AItemIndex;
      FMouseDownPos := Point(X, Y);
    end;
  end;
end;

procedure TcxCustomGridTableItemsListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  AParams: TcxCustomGridHitTest;
  P: TPoint;
begin
  inherited;
  if (FDragAndDropItemIndex <> -1) and
    (not IsPointInDragDetectArea(FMouseDownPos, X, Y) or
     (ItemAtPos(Point(X, Y), False) <> FDragAndDropItemIndex)) then
  begin
    AParams := GetDragAndDropParams;
    with GridView do
    begin
      P := FMouseDownPos;
      P := Site.ScreenToClient(ClientToScreen(P));
      Controller.DragAndDropObjectClass := AParams.DragAndDropObjectClass;
      Controller.DragAndDropObject.Init(P, AParams);
      Site.BeginDragAndDrop;
    end;  
    FDragAndDropItemIndex := -1;
  end;
end;

procedure TcxCustomGridTableItemsListBox.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  FDragAndDropItemIndex := -1;
end;

procedure TcxCustomGridTableItemsListBox.CalculateBorderStyle;
begin
  if LookAndFeelPainter.HeaderBorderSize <= 1 then
    BorderStyle := bsNone
  else
    BorderStyle := bsSingle;
end;

procedure TcxCustomGridTableItemsListBox.CalculateItemHeight;
begin
  ItemHeight := 2 * (LookAndFeelPainter.HeaderBorderSize + cxTextOffset) + Canvas.TextHeight('Qq');
end;

function TcxCustomGridTableItemsListBox.IndexOfItem(AItem: TObject): Integer;
begin
  Result := Items.IndexOfObject(AItem);
end;

procedure TcxCustomGridTableItemsListBox.PaintItem(ACanvas: TcxCanvas; R: TRect;
  AIndex: Integer; AFocused: Boolean);
const
  States: array[Boolean] of TcxButtonState = (cxbsNormal, cxbsHot);
var
  ATextR, ASelectionR: TRect;
begin
  ACanvas.Font.Color := clBtnText;
  ASelectionR := R;
  with LookAndFeelPainter do
  begin
    InflateRect(ASelectionR, -HeaderBorderSize, -HeaderBorderSize);
    ATextR := ASelectionR;
    InflateRect(ATextR, -cxTextOffset, 0);
    DrawHeader(ACanvas, R, ATextR, [],
      cxBordersAll, States[AFocused], taLeftJustify, vaCenter, False,
      GridView.OptionsView.HeaderEndEllipsis, Items[AIndex], ACanvas.Font,
      clBtnText, clBtnFace, GridView.ViewInfo.HeaderViewInfo.DrawColumnBackgroundHandler{4});
    if AFocused then
      DrawHeaderPressed(ACanvas, ASelectionR);
  end;
end;

procedure TcxCustomGridTableItemsListBox.RefreshItems;
begin
  CalculateItemHeight;
end;

{ TcxGridTableColumnsListBox }

function TcxGridTableColumnsListBox.GetDragAndDropParams: TcxCustomGridHitTest;
begin
  Result := TcxGridColumnHeaderHitTest.Instance(Point(-1, -1));
  with TcxGridColumnHeaderHitTest(Result) do
  begin
    GridView := Self.GridView;
    Column := TcxGridColumn(DragAndDropItem);
    ColumnContainerKind := ccCustomizationForm;
  end;
end;

procedure TcxGridTableColumnsListBox.RefreshItems;
var
  I: Integer;
  AColumn: TcxGridColumn;
begin
  inherited;
  with Items do
  begin
    BeginUpdate;
    try
      Clear;
      for I := 0 to GridView.ColumnCount - 1 do
      begin
        AColumn := GridView.Columns[I];
        if not AColumn.Hidden and not AColumn.Visible then
          AddObject(AColumn.Caption, AColumn);
      end;
    finally
      EndUpdate;
    end;
  end;
end;

{ TcxGridCustomizationForm }

// TODO: system menu, hiding when control is hidden or minimized

constructor TcxGridTableCustomizationForm.Create(AController: TcxGridTableController);
begin
  inherited CreateNew(nil);
  FController := AController;
  Caption := cxGetResourceString(@scxGridCustomizationFormCaption);
  BorderStyle := bsSizeToolWin;
  Font := TcxControlAccess(Controller.Control).Font;
  CalculateConsts;
  CreateControls;
end;

destructor TcxGridTableCustomizationForm.Destroy;
begin
  FHookTimer.Free;
  FController.Customization := False;
  inherited;
end;

function TcxGridTableCustomizationForm.GetGridView: TcxGridTableView;
begin
  Result := FController.GridView;
end;

function TcxGridTableCustomizationForm.GetViewInfo: TcxGridTableViewInfo;
begin
  Result := FController.ViewInfo;
end;

procedure TcxGridTableCustomizationForm.HookTimerHandler(Sender: TObject);
begin
  if IsIconic(Application.Handle) then
    Visible := False
  else
    if not IsWindowVisible(FController.Site.Handle) then
      FController.Customization := False
    else
      if not Visible then
      begin
        ShowWindow(Handle, SW_SHOWNOACTIVATE);
        Visible := True;
      end;
end;

procedure TcxGridTableCustomizationForm.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
  begin
    Style := Style or WS_POPUP;
//    Style := WS_POPUP or WS_CLIPCHILDREN or WS_CLIPSIBLINGS or WS_CAPTION or
//      WS_SYSMENU or WS_SIZEBOX;
//    ExStyle := WS_EX_TOOLWINDOW or WS_EX_DLGMODALFRAME or WS_EX_CONTROLPARENT;
//    WindowClass.Style := CS_SAVEBITS;
    WndParent := FController.Site.Handle;
  end;
end;

procedure TcxGridTableCustomizationForm.DoClose(var Action: TCloseAction);
begin
  FreeAndNil(FHookTimer);
  Action := caFree;
end;

procedure TcxGridTableCustomizationForm.DoShow;
begin
  if FHookTimer = nil then
  begin
    FHookTimer := TTimer.Create(nil);
    with FHookTimer do
    begin
      Interval := 100;
      OnTimer := HookTimerHandler;
    end;
  end;  
  inherited;
end;

procedure TcxGridTableCustomizationForm.CalculateConsts;
begin
  FOffset := Canvas.TextHeight('Qq') div 6;
  FStep := 2 * FOffset;
end;

procedure TcxGridTableCustomizationForm.CreateControls;

  procedure CreatePageControl;
  begin
    FPageControl := TPageControl.Create(Self);
    with FPageControl do
    begin
      Anchors := [akTop, akLeft, akRight, akBottom];
      BoundsRect := GetPageControlBounds;
      Parent := Self;
      InitPageControl;
    end;
  end;

  procedure CreateColumnsListBox;
  begin
    FColumnsListBox := GetColumnsListBoxClass.Create(Self);
    with FColumnsListBox do
    begin
      Align := alClient;
      Parent := FColumnsPage;
      RefreshItems;
    end;
  end;

begin
  CreatePageControl;
  CreateColumnsListBox;
end;

function TcxGridTableCustomizationForm.CreatePage(const ACaption: string;
  AVisible: Boolean): TTabSheet;
begin
  Result := TTabSheet.Create(FPageControl);
  with Result do
  begin
    PageControl := FPageControl;
    Caption := ACaption;
    TabVisible := AVisible;
  end;
end;

function TcxGridTableCustomizationForm.GetColumnsListBoxBounds: TRect;
begin
  Result := FColumnsPage.ClientRect;
end;

function TcxGridTableCustomizationForm.GetColumnsListBoxClass: TcxGridTableColumnsListBoxClass;
begin
  Result := TcxGridTableColumnsListBox;
end;

function TcxGridTableCustomizationForm.GetContentBounds: TRect;
begin
  Result := ClientRect;
  InflateRect(Result, -Offset, -Offset);
end;

function TcxGridTableCustomizationForm.GetPageControlBounds: TRect;
begin
  Result := ContentBounds;
end;

procedure TcxGridTableCustomizationForm.InitPageControl;
begin
  FColumnsPage := CreatePage(cxGetResourceString(@scxGridCustomizationFormColumnsPageCaption),
    GridView.OptionsCustomize.ColumnMoving);
end;

procedure TcxGridTableCustomizationForm.ActivatePage(APage: TTabSheet);
begin
  if APage.TabVisible then
    FPageControl.ActivePage := APage;
end;

procedure TcxGridTableCustomizationForm.RefreshData;
begin
  FColumnsListBox.RefreshItems;
end;

{ TcxGridDragOpenInfoMasterDataRowTab }

constructor TcxGridDragOpenInfoMasterDataRowTab.Create(ALevel: TcxGridLevel;
  AGridRow: TcxGridMasterDataRow);
begin
  inherited Create(ALevel);
  GridRow := AGridRow;
end;

function TcxGridDragOpenInfoMasterDataRowTab.Equals(AInfo: TcxCustomGridDragOpenInfo): Boolean;
begin
  Result := inherited Equals(AInfo) and
    (GridRow = TcxGridDragOpenInfoMasterDataRowTab(AInfo).GridRow);
end;

procedure TcxGridDragOpenInfoMasterDataRowTab.Run;
begin
  GridRow.ActiveDetailIndex := Level.Index;
end;

{ TcxGridTableController }

destructor TcxGridTableController.Destroy;
begin
  FFilterPopup.Free;
  inherited;
end;

function TcxGridTableController.GetDragAndDropObject: TcxGridDragAndDropObject;
begin
  Result := TcxGridDragAndDropObject(inherited DragAndDropObject);
end;

function TcxGridTableController.GetFilterPopup: TcxGridFilterPopup;
begin
  if FFilterPopup = nil then
    FFilterPopup := GetFilterPopupClass.Create(GridView);
  Result := FFilterPopup;
end;

function TcxGridTableController.GetFocusedColumn: TcxGridColumn;
begin
  Result := TcxGridColumn(FocusedItem);
end;

function TcxGridTableController.GetFocusedColumnIndex: Integer;
begin
  Result := FocusedItemIndex;
end;

function TcxGridTableController.GetFocusedRow: TcxCustomGridRow;
begin
  Result := TcxCustomGridRow(FocusedRecord);
end;

function TcxGridTableController.GetFocusedRowIndex: Integer;
begin
  Result := FocusedRecordIndex;
end;

function TcxGridTableController.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxGridTableController.GetIsColumnHorzSizing: Boolean;
begin
  Result := FHorzSizingColumn <> nil;
end;

function TcxGridTableController.GetIsColumnMoving: Boolean;
begin
  Result := FMovingColumn <> nil;
end;

function TcxGridTableController.GetSelectedRow(Index: Integer): TcxCustomGridRow;
begin
  Result := TcxCustomGridRow(SelectedRecords[Index]);
end;

function TcxGridTableController.GetSelectedRowCount: Integer;
begin
  Result := SelectedRecordCount;
end;

function TcxGridTableController.GetTopRowIndex: Integer;
begin
  Result := TopRecordIndex;
end;

function TcxGridTableController.GetViewData: TcxGridViewData;
begin
  Result := TcxGridViewData(inherited ViewData);
end;

function TcxGridTableController.GetViewInfo: TcxGridTableViewInfo;
begin
  Result := TcxGridTableViewInfo(inherited ViewInfo);
end;

procedure TcxGridTableController.SetCustomization(Value: Boolean);
begin
  if FCustomization <> Value then
  begin
    FCustomization := Value;
    if Value then
      ShowCustomizationForm
    else
      HideCustomizationForm;
    TcxCustomGrid(Control).SendNotifications(gnkCustomization);
    GridView.DoCustomization;  
  end;
end;

procedure TcxGridTableController.SetFocusedColumn(Value: TcxGridColumn);
begin
  FocusedItem := Value;
end;

procedure TcxGridTableController.SetFocusedColumnIndex(Value: Integer);
begin
  FocusedItemIndex := Value;
end;

procedure TcxGridTableController.SetFocusedRow(Value: TcxCustomGridRow);
begin
  FocusedRecord := Value;
end;

procedure TcxGridTableController.SetFocusedRowIndex(Value: Integer);
begin
  FocusedRecordIndex := Value;
end;

procedure TcxGridTableController.SetLeftPos(Value: Integer);
var
  APrevLeftPos: Integer;

//var ft,lt:integer;

begin
  CheckLeftPos(Value);
  if FLeftPos <> Value then
  begin

    //ft:=gettickcount;

    APrevLeftPos := FLeftPos;
    FLeftPos := Value;
    if GridView.CanOffsetHorz then   {2}
      GridView.Offset(0, APrevLeftPos - FLeftPos, 0)
    else
      LeftPosChanged;
    GridView.DoLeftPosChanged;

    {site.Update;
    lt := gettickcount;
    application.MainForm.Caption := inttostr(lt-ft);}

  end;
end;

procedure TcxGridTableController.SetPressedColumn(Value: TcxGridColumn);
var
  R1, R2: TRect;

  procedure GetUpdateRects;

    function GetUpdateRect(AContainerViewInfo: TcxGridColumnContainerViewInfo;
      AIndex: Integer): TRect;
    begin
      if AIndex <> -1 then
        Result := AContainerViewInfo[AIndex].Bounds
      else
        Result := Rect(0, 0, 0, 0);
    end;

  begin
    R1 := GetUpdateRect(ViewInfo.GroupByBoxViewInfo, FPressedColumn.GroupIndex);
    R2 := GetUpdateRect(ViewInfo.HeaderViewInfo, FPressedColumn.VisibleIndex);
  end;

  procedure InvalidateRects;
  begin
    GridView.ViewChanged(R1);
    GridView.ViewChanged(R2);
  end;

begin
  if FPressedColumn <> Value then
  begin
    if Value = nil then GetUpdateRects;
    FPressedColumn := Value;
    if Value <> nil then GetUpdateRects;
    InvalidateRects;
  end;
end;

procedure TcxGridTableController.SetScrollDirection(Value: TcxDirection);
begin
  if FScrollDirection <> Value then
  begin
    DestroyScrollTimer;
    FScrollDirection := Value;
    if FScrollDirection <> dirNone then
      CreateScrollTimer;
  end;
end;

procedure TcxGridTableController.SetTopRowIndex(Value: Integer);
begin
  TopRecordIndex := Value;
end;

procedure TcxGridTableController.CreateScrollTimer;
begin
  FScrollTimer := TTimer.Create(nil);
  with FScrollTimer do
  begin
    Interval := ScrollTimeIntervalHorz;
    OnTimer := ScrollTimerHandler;
  end;
end;

procedure TcxGridTableController.DestroyScrollTimer;
begin
  FreeAndNil(FScrollTimer);
end;

procedure TcxGridTableController.ScrollTimerHandler(Sender: TObject);
var
  AAccepted: Boolean;
begin
  if CanScroll(FScrollDirection) then
  begin
    if DragAndDropObject <> nil then
      DragAndDropObject.BeforeScrolling;
    ScrollData(FScrollDirection);
    if DragAndDropObject <> nil then
    begin
      Site.Update;
      DragAndDropObject.AfterScrolling;
      TcxControlAccess(Site).DragAndDrop(Site.ScreenToClient(Mouse.CursorPos), AAccepted);
    end;
  end;
end;

function TcxGridTableController.CanAppend(ACheckOptions: Boolean): Boolean;
begin
  Result := inherited CanAppend(ACheckOptions) and not ViewData.HasNewItemRecord;
end;

function TcxGridTableController.CanDelete(ACheckOptions: Boolean): Boolean;
begin
  Result := inherited CanDelete(ACheckOptions) and
    (not ViewData.HasNewItemRecord or not ViewData.NewItemRow.Focused);
end;

function TcxGridTableController.CanScroll(ADirection: TcxDirection): Boolean;
var
  Value: Integer;
begin
  case ADirection of
    dirLeft:
      Result := LeftPos <> 0;
    dirRight:
      begin
        Value := LeftPos + HScrollDelta;
        CheckLeftPos(Value);
        Result := LeftPos <> Value;
      end;
    dirUp:
      Result := TopRowIndex <> 0;
    dirDown:
      begin
        Value := TopRowIndex + 1;
        CheckTopRecordIndex(Value);
        Result := TopRowIndex <> Value;
      end;
  else
    Result := False;
  end;
end;

procedure TcxGridTableController.CheckCoordinates;
begin
  inherited;
  LeftPos := LeftPos;
end;

procedure TcxGridTableController.CheckLeftPos(var Value: Integer);
begin
  if Value > ViewInfo.DataWidth - ViewInfo.ClientWidth then
    Value := ViewInfo.DataWidth - ViewInfo.ClientWidth;
  if Value < 0 then Value := 0;
end;

function TcxGridTableController.GetDesignHitTest(AHitTest: TcxCustomGridHitTest): Boolean;
begin
  Result := inherited GetDesignHitTest(AHitTest);
  if not Result then
    Result := AHitTest.HitTestCode in [htExpandButton, htTab];
end;

function TcxGridTableController.GetDragScrollDirection(X, Y: Integer): TcxDirection;
var
  R: TRect;
begin
  Result := inherited GetDragScrollDirection(X, Y);
  if Result = dirNone then
  begin
    R := ViewInfo.ScrollableAreaBoundsHorz;
    if PtInRect(R, Point(X, Y)) then
      if X < R.Left + ScrollHotZoneWidth then
        Result := dirLeft
      else
        if R.Right - ScrollHotZoneWidth <= X then
          Result := dirRight;
  end;
end;

function TcxGridTableController.GetFilterPopupClass: TcxGridFilterPopupClass;
begin
  Result := TcxGridFilterPopup;
end;

function TcxGridTableController.GetFocusedRecord: TcxCustomGridRecord;
begin
  Result := inherited GetFocusedRecord;
  if (Result = nil) and ViewData.HasNewItemRecord and ViewData.NewItemRow.Selected then
    Result := ViewData.NewItemRow;
end;

function TcxGridTableController.GetIsRecordsScrollHorizontal: Boolean;
begin
  Result := False;
end;

function TcxGridTableController.GetMaxTopRecordIndexValue: Integer;
begin
  if NeedsAdditionalRowsScrolling then
    Result := TopRowIndex + 1
  else
    Result := inherited GetMaxTopRecordIndexValue;
end;

function TcxGridTableController.GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind;
begin
  Result := mwskVertical;
end;

function TcxGridTableController.GetScrollBarRecordCount: Integer;
begin
  Result := inherited GetScrollBarRecordCount;
  if NeedsAdditionalRowsScrolling then Inc(Result);
end;

function TcxGridTableController.IsColumnFixedDuringHorzSizing(AColumn: TcxGridColumn): Boolean;
begin
  Result :=
    (AColumn = ForcingWidthItem) or
    not ForcingWidthItem.IsLast and (AColumn.VisibleIndex < ForcingWidthItem.VisibleIndex);
end;

function TcxGridTableController.IsKeyForMultiSelect(AKey: Word; AShift: TShiftState;
  AFocusedRecordChanged: Boolean): Boolean;
begin
  Result := inherited IsKeyForMultiSelect(AKey, AShift, AFocusedRecordChanged) or
    (AKey = VK_UP) or (AKey = VK_DOWN) or
    ((AKey = VK_HOME) or (AKey = VK_END)) and
      (not GridView.OptionsSelection.CellSelect or (FocusedRecord = nil) or not FocusedRecord.HasCells);
end;

function TcxGridTableController.IsPixelScrollBar(AKind: TScrollBarKind): Boolean;
begin
  Result := AKind = sbHorizontal;
end;

procedure TcxGridTableController.LeftPosChanged;
begin
  GridView.LayoutChanged;
end;

function TcxGridTableController.NeedsAdditionalRowsScrolling(AIsCallFromMaster: Boolean = False): Boolean;
var
  ALastRow: TcxCustomGridRow;
begin
  Result := False;
  if GridView.IsMaster and
    ((ViewInfo.VisibleRecordCount > 1) or AIsCallFromMaster) and
    (TopRowIndex = inherited GetScrollBarRecordCount - ViewInfo.VisibleRecordCount) then
  begin
    ALastRow := ViewData.Rows[ViewData.RowCount - 1];
    if ALastRow is TcxGridMasterDataRow and ALastRow.Expanded and
      TcxGridMasterDataRow(ALastRow).ActiveDetailGridViewExists then
      Result := not TcxGridMasterDataRow(ALastRow).ActiveDetailGridView.Controller.IsDataFullyVisible(True);
  end;
end;

procedure TcxGridTableController.RemoveFocus;
begin
  with ViewData do
    if HasNewItemRecord and NewItemRow.Focused then
      NewItemRow.Focused := False;
  inherited;
end;

procedure TcxGridTableController.ScrollData(ADirection: TcxDirection);
begin
  case ADirection of
    dirLeft:
      LeftPos := LeftPos - HScrollDelta;
    dirRight:
      LeftPos := LeftPos + HScrollDelta;
    dirUp:
      ScrollRecords(False, 1);
    dirDown:
      ScrollRecords(True, 1);
  end;
end;

procedure TcxGridTableController.SetFocusedRecord(Value: TcxCustomGridRecord);
var
  ARecordIndex: Integer;
begin
  if (FocusedRecord <> Value) and ViewData.HasNewItemRecord then
    if Value = ViewData.NewItemRow then
    begin
      Value.Selected := True;
      Value := ViewData.NewItemRow;
    end
    else
      if FocusedRecord = ViewData.NewItemRow then
      begin
        ARecordIndex := ViewData.GetRecordIndexByRecord(Value);
        FocusedRecord.Selected := False;
        Value := ViewData.GetRecordByRecordIndex(ARecordIndex);
      end;
  inherited;
end;

procedure TcxGridTableController.ShowNextPage;
begin
  if TopRecordIndex = -1 then Exit;
  if ViewInfo.VisibleRecordCount = 1 then
    TopRecordIndex := TopRecordIndex + 1
  else
    TopRecordIndex := TopRecordIndex + (ViewInfo.VisibleRecordCount - 1);
end;

procedure TcxGridTableController.ShowPrevPage;
var
  AVisibleRowCount: Integer;
begin
  if TopRecordIndex = -1 then Exit;
  if TopRecordIndex = 0 then
    if DataController.IsGridMode then
      AVisibleRowCount := ViewInfo.VisibleRecordCount
    else
      Exit
  else
  begin
    AVisibleRowCount := GetVisibleRecordCount(TopRecordIndex, False);
    if DataController.IsGridMode and (TopRecordIndex - (AVisibleRowCount - 1) = 0) and
      (AVisibleRowCount < ViewInfo.VisibleRecordCount) then
      AVisibleRowCount := ViewInfo.VisibleRecordCount;
  end;
  if AVisibleRowCount = 1 then
    TopRecordIndex := TopRecordIndex - 1
  else
    if DataController.IsGridMode then
      TopRecordIndex := TopRecordIndex - (AVisibleRowCount - 1)
    else
      InternalTopRecordIndex := TopRecordIndex - (AVisibleRowCount - 1);
end;

function TcxGridTableController.GetColumnHeaderDragAndDropObjectClass: TcxGridColumnHeaderMovingObjectClass;
begin
  Result := TcxGridColumnHeaderMovingObject;
end;

function TcxGridTableController.GetCustomizationFormClass: TcxGridTableCustomizationFormClass;
begin
  Result := TcxGridTableCustomizationForm;
end;

function TcxGridTableController.GetRealCustomizationFormBounds: TRect;
var
  AHeaderBottomBound: Integer;
begin
  if IsRectEmpty(FCustomizationFormBounds) then
  begin
    Result.BottomRight := Site.ClientToScreen(Site.ClientRect.BottomRight);
    Result.Left := Result.Right - cxGridCustomizationFormDefaultWidth;
    Result.Top := Result.Bottom - cxGridCustomizationFormDefaultHeight;
    AHeaderBottomBound := Site.ClientToScreen(ViewInfo.HeaderViewInfo.Bounds.BottomRight).Y;
    if Result.Top < AHeaderBottomBound then
      OffsetRect(Result, 0, AHeaderBottomBound - Result.Top);
  end
  else
    Result := CustomizationFormBounds;
end;

procedure TcxGridTableController.HideCustomizationForm;
begin
  if not (csDestroying in FCustomizationForm.ComponentState) then
    FCustomizationForm.Free;
  FCustomizationForm := nil;
end;

procedure TcxGridTableController.ShowCustomizationForm;
begin
  FCustomizationForm := GetCustomizationFormClass.Create(Self);
  FCustomizationForm.BoundsRect := GetRealCustomizationFormBounds;
  FCustomizationForm.Show;
end;

function TcxGridTableController.GetDragOpenInfo(AHitTest: TcxCustomGridHitTest): TcxCustomGridDragOpenInfo;
begin
  Result := inherited GetDragOpenInfo(AHitTest);
  if (Result = nil) and (AHitTest.HitTestCode = htTab) then
    with TcxGridDetailsSiteTabHitTest(AHitTest) do
      Result := TcxGridDragOpenInfoMasterDataRowTab.Create(Level, Owner as TcxGridMasterDataRow);
end;

procedure TcxGridTableController.CheckScrolling(const P: TPoint);
var
  R: TRect;
begin
  R := ViewInfo.ScrollableAreaBoundsHorz;
  if PtInRect(R, P) then
    if P.X < R.Left + ScrollHotZoneWidth then
      ScrollDirection := dirLeft
    else
      if R.Right - ScrollHotZoneWidth <= P.X then
        ScrollDirection := dirRight
      else
        ScrollDirection := dirNone
  else
    ScrollDirection := dirNone;
end;

procedure TcxGridTableController.DoCancelMode;
begin
  inherited;
  PressedColumn := nil;
end;

function TcxGridTableController.HasFilterPopup: Boolean;
begin
  Result := FFilterPopup <> nil;
end;

procedure TcxGridTableController.MakeItemVisible(AItem: TcxCustomGridTableItem);
var
  R: TRect;

  function GetColumnBounds: TRect;
  begin
    Result := ViewInfo.HeaderViewInfo[AItem.VisibleIndex].Bounds;
  end;

begin
  if (AItem = nil) or (AItem.VisibleIndex = -1) or
    (AItem.VisibleIndex >= ViewInfo.HeaderViewInfo.Count){!!!} then
    Exit;
  MakeFocusedRecordVisible;
  if TcxGridColumn(AItem).CanScroll then
  begin
    R := GetColumnBounds;
    with ViewInfo.ScrollableAreaBoundsHorz do
      if R.Right - R.Left >= Right - Left then
        LeftPos := LeftPos - (Left - R.Left)
      else
      begin
        if R.Right > Right then
        begin
          LeftPos := LeftPos + (R.Right - Right);
          R := GetColumnBounds;
        end;
        if R.Left < Left then
          LeftPos := LeftPos - (Left - R.Left);
      end;
  end;
end;

procedure TcxGridTableController.MakeRecordVisible(ARecord: TcxCustomGridRecord);
begin
  if ViewData.HasNewItemRecord and (ARecord = ViewData.NewItemRow) then
    GridView.MakeMasterGridRecordVisible
  else
    inherited;
end;

procedure TcxGridTableController.RefreshCustomizationForm;
begin
  if CustomizationForm <> nil then
    CustomizationForm.RefreshData;
end;

procedure TcxGridTableController.InitScrollBarsParameters;
begin
  Controller.SetScrollBarInfo(sbHorizontal, 0, ViewInfo.DataWidth - 1,
    HScrollDelta, ViewInfo.ClientWidth, LeftPos, True, CanHScrollBarHide);
  Controller.SetScrollBarInfo(sbVertical, 0, ScrollBarRecordCount - 1,
    1, ViewInfo.VisibleRecordCount, ScrollBarPos, True, True);
end;

function TcxGridTableController.IsDataFullyVisible(AIsCallFromMaster: Boolean = False): Boolean;
begin
  Result := inherited IsDataFullyVisible(AIsCallFromMaster);
  if Result and GridView.IsMaster then
    Result := not NeedsAdditionalRowsScrolling(AIsCallFromMaster);
end;

procedure TcxGridTableController.Scroll(AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode;
  var AScrollPos: Integer);

  procedure ScrollHorizontal;
  begin
    case AScrollCode of
      scLineUp:
        ScrollData(dirLeft);
      scLineDown:
        ScrollData(dirRight);
      scPageUp:
        LeftPos := LeftPos - ViewInfo.ScrollableAreaWidth;
      scPageDown:
        LeftPos := LeftPos + ViewInfo.ScrollableAreaWidth;
      scTrack:
        LeftPos := AScrollPos;
    end;
    AScrollPos := LeftPos;
  end;

  procedure ScrollVertical;
  begin
    case AScrollCode of
      scLineUp:
        ScrollData(dirUp);
      scLineDown:
        ScrollData(dirDown);
      scPageUp:
        ScrollPage(False);
      scPageDown:
        ScrollPage(True);
      scTrack:
        if not DataController.IsGridMode then
          ScrollBarPos := AScrollPos;
      scPosition:
        if DataController.IsGridMode then
          ScrollBarPos := AScrollPos;
    end;
    AScrollPos := ScrollBarPos;
  end;

begin
  case AScrollBarKind of
    sbHorizontal:
      ScrollHorizontal;
    sbVertical:
      ScrollVertical;
  end;
end;

procedure TcxGridTableController.EndDragAndDrop(Accepted: Boolean);
begin
  ScrollDirection := dirNone;
  PressedColumn := nil;
  inherited;
end;

procedure TcxGridTableController.KeyDown(var Key: Word; Shift: TShiftState);

  function FocusNewItemRow: Boolean;
  var
    ACycleChanged: Boolean;
  begin
    Result := ViewData.HasNewItemRecord and not ViewData.NewItemRow.Focused;
    if Result then
    begin
      if DataController.IsGridMode then
        Result := DataController.IsBOF
      else
        Result := FindNextRecord(FocusedRecordIndex, False, False, ACycleChanged) = -1;
      if Result then
        ViewData.NewItemRow.Focused := True;
    end;
  end;

  function DefocusNewItemRow: Boolean;
  begin
    Result := ViewData.HasNewItemRecord and ViewData.NewItemRow.Focused and
      (TopRecordIndex <> -1);
    if Result then
    begin
      FocusedRecordIndex := TopRecordIndex;
      Result := FocusedRecordIndex = TopRecordIndex;
    end;
  end;

//var ft,lt:integer;

begin
  case Key of
    VK_LEFT, VK_RIGHT:
      if FocusNextCell(Key = VK_RIGHT) then Key := 0;
    VK_PRIOR:
      if FocusNewItemRow or
        ViewData.HasNewItemRecord and ViewData.NewItemRow.Focused then
        Exit;
    VK_NEXT:
      if DefocusNewItemRow then Exit;
  end;
  inherited;  //!!!!
  case Key of
    VK_LEFT:
      ScrollData(dirLeft);
    VK_RIGHT:
      ScrollData(dirRight);
    VK_UP:
    {3}
    {begin
      ft:=gettickcount;}

      if not FocusNewItemRow then
        FocusNextRecord(FocusedRowIndex, False, False, True);

      {site.update;
      lt:=gettickcount;
      application.mainform.Caption := inttostr(lt-ft);
    end;}

    VK_DOWN:
    {3}
    {begin
      ft:=gettickcount;}

      if not DefocusNewItemRow then
        FocusNextRecord(FocusedRowIndex, True, False, True);

      {site.update;
      lt:=gettickcount;
      application.mainform.Caption := inttostr(lt-ft);
    end;}

    VK_HOME:
      if (ssCtrl in Shift) or not FocusedRecordHasCells(True) then
        if DataController.IsGridMode then
          DataController.GotoFirst
        else
          FocusNextRecord(-1, True, False, False)
      else
        FocusNextItem(-1, True, False, False);
    VK_END:
      if (ssCtrl in Shift) or not FocusedRecordHasCells(True) then
        if DataController.IsGridMode then
          DataController.GotoLast
        else
          FocusNextRecord(-1, False, True, False)
      else
        FocusNextItem(-1, False, True, False);
  end;
end;

procedure TcxGridTableController.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);

  procedure ProcessSorting;
  var
    ASortOrder: TcxGridSortOrder;
  begin
    if not PressedColumn.CanSort then Exit;
    try
      ShowHourglassCursor;
      BeginUpdate;
      try
        with PressedColumn do
          if ssCtrl in Shift then
            SortOrder := soNone
          else
          begin
            if SortOrder = soAscending then
              ASortOrder := soDescending
            else
              ASortOrder := soAscending;
            if not (ssShift in Shift) and (PressedColumn.GroupIndex = -1) then
              DataController.ClearSorting(True);
            SortOrder := ASortOrder;
          end;
      finally
        EndUpdate;
        HideHourglassCursor;
      end;
    finally
      MakeFocusedRecordVisible;
      DesignerModified;
    end;
  end;

begin
  inherited;
  if Site.IsMouseInPressedArea(X, Y) and (PressedColumn <> nil) then
    ProcessSorting;
  PressedColumn := nil;
end;

{ TcxGridColumnContainerPainter }

function TcxGridColumnContainerPainter.GetViewInfo: TcxGridColumnContainerViewInfo;
begin
  Result := TcxGridColumnContainerViewInfo(inherited ViewInfo);
end;

procedure TcxGridColumnContainerPainter.DrawContent;
var
  AClipRegion: TcxRegion;
begin
  AClipRegion := Canvas.GetClipRegion;
  try
    Canvas.IntersectClipRect(ViewInfo.Bounds);
    if DrawItemsFirst then
    begin
      DrawItems;
      inherited;
    end
    else
    begin
      inherited;
      DrawItems;
    end
  finally
    Canvas.SetClipRegion(AClipRegion, roSet);
  end;
end;

procedure TcxGridColumnContainerPainter.DrawItems;
var
  I: Integer;
  AViewInfo: TcxGridColumnHeaderViewInfo;
begin
  for I := 0 to ViewInfo.Count - 1 do
  begin
    AViewInfo := ViewInfo.InternalItems[I];
    if AViewInfo <> nil then AViewInfo.Paint;
  end;
end;

function TcxGridColumnContainerPainter.DrawItemsFirst: Boolean;
begin
  Result := True;
end;

function TcxGridColumnContainerPainter.ExcludeFromClipRect: Boolean;
begin      
  Result := True;
end;

{ TcxGridColumnHeaderAreaPainter }

function TcxGridColumnHeaderAreaPainter.GetViewInfo: TcxGridColumnHeaderAreaViewInfo;
begin
  Result := TcxGridColumnHeaderAreaViewInfo(inherited ViewInfo);
end;

{ TcxGridColumnHeaderSortingMarkPainter }

procedure TcxGridColumnHeaderSortingMarkPainter.Paint;
begin
  ViewInfo.LookAndFeelPainter.DrawSortingMark(Canvas, ViewInfo.Bounds,
    TcxGridColumnHeaderSortingMarkViewInfo(ViewInfo).SortOrder = soAscending);
end;

{ TcxGridColumnHeaderFilterButtonPainter }

function TcxGridColumnHeaderFilterButtonPainter.GetViewInfo: TcxGridColumnHeaderFilterButtonViewInfo;
begin
  Result := TcxGridColumnHeaderFilterButtonViewInfo(inherited ViewInfo);
end;

procedure TcxGridColumnHeaderFilterButtonPainter.Paint;
begin
  ViewInfo.LookAndFeelPainter.DrawFilterDropDownButton(Canvas, ViewInfo.Bounds,
     GridCellStateToButtonState(ViewInfo.State), ViewInfo.Active);
end;

{ TcxGridColumnHeaderGlyphPainter }

function TcxGridColumnHeaderGlyphPainter.GetViewInfo: TcxGridColumnHeaderGlyphViewInfo;
begin
  Result := TcxGridColumnHeaderGlyphViewInfo(inherited ViewInfo);
end;

procedure TcxGridColumnHeaderGlyphPainter.Paint;
begin
  with ViewInfo.Bounds do
    Canvas.DrawGlyph(Left, Top, ViewInfo.Glyph);
end;

{ TcxGridColumnHeaderPainter }

function TcxGridColumnHeaderPainter.GetViewInfo: TcxGridColumnHeaderViewInfo;
begin
  Result := TcxGridColumnHeaderViewInfo(inherited ViewInfo);
end;

procedure TcxGridColumnHeaderPainter.DrawBorders;
begin
  // inherited;
end;

procedure TcxGridColumnHeaderPainter.DrawContent;
const
  States: array[TcxGridCellState] of TcxButtonState = (cxbsNormal, cxbsHot, cxbsPressed);
var
  AState: TcxButtonState;
  I: Integer;
begin
  with ViewInfo do
  begin
    if IsMainCanvasInUse then
    begin
      AState := States[State];
      if IsPressed then AState := cxbsPressed;
    end
    else
      AState := cxbsNormal;
    LookAndFeelPainter.DrawHeader(Self.Canvas, Bounds, TextAreaBounds, Neighbors,
      Borders, AState, AlignmentHorz, AlignmentVert, MultiLinePainting, ShowEndEllipsis,
      Text, Params.Font, Params.TextColor, Params.Color,
      ViewInfo.GridViewInfo.HeaderViewInfo.DrawColumnBackgroundHandler{4});
  end;
  for I := 0 to ViewInfo.AreaViewInfoCount - 1 do
    ViewInfo.AreaViewInfos[I].Paint(Canvas);
end;

procedure TcxGridColumnHeaderPainter.DrawPressed;
begin
  with ViewInfo do
    LookAndFeelPainter.DrawHeaderPressed(Self.Canvas, Bounds);
end;

function TcxGridColumnHeaderPainter.ExcludeFromClipRect: Boolean;
begin
  Result := True;
end;

procedure TcxGridColumnHeaderPainter.Paint;
begin
  inherited;
  if ViewInfo.IsPressed and IsMainCanvasInUse then DrawPressed;
end;

{ TcxGridHeaderPainter }

function TcxGridHeaderPainter.DrawItemsFirst: Boolean;
begin
  Result := ViewInfo.LookAndFeelPainter.HeaderDrawCellsFirst;
end;

{ TcxGridGroupByBoxPainter }

procedure TcxGridGroupByBoxPainter.DrawContent;
var
  I: Integer;
  J: Boolean;
  R: TRect;
begin
  inherited;
  Canvas.Brush.Color := GroupByBoxLineColor;
  for I := 0 to ViewInfo.Count - 2 do
    for J := Low(J) to High(J) do
    begin
      R := TcxGridGroupByBoxViewInfo(ViewInfo).LinkLineBounds[I, J];
      with Canvas do
      begin
        FillRect(R);
        //ExcludeClipRect(R);
      end;
    end;
end;

{ TcxGridFooterCellPainter }

procedure TcxGridFooterCellPainter.DrawBorders;
begin
  // inherited;
end;

procedure TcxGridFooterCellPainter.DrawContent;
begin
  with ViewInfo do
    LookAndFeelPainter.DrawFooterCell(Self.Canvas, Bounds, AlignmentHorz,
      AlignmentVert, MultiLine, Text, Params.Font, Params.TextColor, Params.Color,
      DrawBackgroundHandler);
end;

{ TcxGridFooterPainter }

function TcxGridFooterPainter.GetViewInfo: TcxGridFooterViewInfo;
begin
  Result := TcxGridFooterViewInfo(inherited ViewInfo);
end;

procedure TcxGridFooterPainter.DrawBorders;
begin
  if ViewInfo.HasSeparator then DrawSeparator;
  ViewInfo.LookAndFeelPainter.DrawFooterBorder(Canvas, ViewInfo.BordersBounds);
end;

function TcxGridFooterPainter.DrawItemsFirst: Boolean;
begin
  Result := ViewInfo.LookAndFeelPainter.FooterDrawCellsFirst;
end;

procedure TcxGridFooterPainter.DrawSeparator;
begin
  Canvas.Brush.Color := ViewInfo.SeparatorColor;
  Canvas.FillRect(ViewInfo.SeparatorBounds);
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
    GridCellStateToButtonState(ViewInfo.State));
end;

{ TcxGridFilterActivateButtonPainter }

function TcxGridFilterActivateButtonPainter.GetViewInfo: TcxGridFilterActivateButtonViewInfo;
begin
  Result := TcxGridFilterActivateButtonViewInfo(inherited ViewInfo);
end;

procedure TcxGridFilterActivateButtonPainter.DrawContent;
begin
  ViewInfo.LookAndFeelPainter.DrawFilterActivateButton(Canvas, ViewInfo.Bounds,
    GridCellStateToButtonState(ViewInfo.State), ViewInfo.Checked);
end;

{ TcxGridFilterCustomizeButtonPainter }

procedure TcxGridFilterCustomizeButtonPainter.Paint;
begin
  ViewInfo.LookAndFeelPainter.DrawButton(Canvas, ViewInfo.Bounds, ViewInfo.Text,
    GridCellStateToButtonState(ViewInfo.State));
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

{ TcxCustomGridIndicatorItemPainter }

function TcxCustomGridIndicatorItemPainter.GetViewInfo: TcxCustomGridIndicatorItemViewInfo;
begin
  Result := TcxCustomGridIndicatorItemViewInfo(inherited ViewInfo);
end;

function TcxCustomGridIndicatorItemPainter.ExcludeFromClipRect: Boolean;
begin
  Result := True;
end;

{ TcxGridIndicatorHeaderItemPainter }

procedure TcxGridIndicatorHeaderItemPainter.DrawContent;
begin
  with ViewInfo do
    LookAndFeelPainter.DrawHeader(Self.Canvas, Bounds, Bounds, [], cxBordersAll,
      cxbsNormal, taLeftJustify, vaTop, False, False, '', nil, clNone, Params.Color,
      GridViewInfo.HeaderViewInfo.DrawColumnBackgroundHandler{4});
end;

{ TcxGridIndicatorRowItemPainter }

function TcxGridIndicatorRowItemPainter.GetViewInfo: TcxGridIndicatorRowItemViewInfo;
begin
  Result := TcxGridIndicatorRowItemViewInfo(inherited ViewInfo);
end;

procedure TcxGridIndicatorRowItemPainter.DrawContent;
begin
  with ViewInfo do
    LookAndFeelPainter.DrawIndicatorItem(Self.Canvas, Bounds, IndicatorKind, Params.Color,
      DrawBackgroundHandler);
end;

{ TcxGridIndicatorFooterItemPainter }

function TcxGridIndicatorFooterItemPainter.GetViewInfo: TcxGridIndicatorFooterItemViewInfo;
begin
  Result := TcxGridIndicatorFooterItemViewInfo(inherited ViewInfo);
end;

procedure TcxGridIndicatorFooterItemPainter.DrawBorders;
begin
  with Canvas, ViewInfo do
  begin
    if HasSeparator then
    begin
      Brush.Color := GridViewInfo.FooterViewInfo.SeparatorColor;
      FillRect(SeparatorBounds);
    end;
    LookAndFeelPainter.DrawFooterBorder(Self.Canvas, BordersBounds);
  end;
end;

{ TcxGridIndicatorPainter }

function TcxGridIndicatorPainter.GetViewInfo: TcxGridIndicatorViewInfo;
begin
  Result := TcxGridIndicatorViewInfo(inherited ViewInfo);
end;

procedure TcxGridIndicatorPainter.DrawContent;
begin
  if DrawItemsFirst then
  begin
    DrawItems;
    inherited;
  end
  else
  begin
    inherited;
    DrawItems;
  end;
end;

procedure TcxGridIndicatorPainter.DrawItems;
var
  I: Integer;
begin
  with ViewInfo do
    for I := 0 to Count - 1 do
      Items[I].Paint;
end;

function TcxGridIndicatorPainter.DrawItemsFirst: Boolean;
begin
  Result := ViewInfo.LookAndFeelPainter.IndicatorDrawItemsFirst;
end;

function TcxGridIndicatorPainter.ExcludeFromClipRect: Boolean;
begin
  Result := True;
end;

{ TcxCustomGridRowPainter }

function TcxCustomGridRowPainter.GetViewInfo: TcxCustomGridRowViewInfo;
begin
  Result := TcxCustomGridRowViewInfo(inherited ViewInfo);
end;

procedure TcxCustomGridRowPainter.DrawFooters;
begin
  ViewInfo.FootersViewInfo.Paint;
end;

procedure TcxCustomGridRowPainter.DrawIndent;
var
  I: Integer;
begin
  for I := 0 to ViewInfo.Level - 1 do
    DrawIndentPart(I, ViewInfo.LevelIndentBounds[I]);
end;

procedure TcxCustomGridRowPainter.DrawIndentPart(ALevel: Integer; const ABounds: TRect);
begin
  with Canvas, ViewInfo do
  begin
    if GridViewInfo.LevelIndentBackgroundBitmap = nil then
    begin
      Brush.Color := GridViewInfo.LevelIndentColors[ALevel];
      FillRect(CalculateLevelIndentSpaceBounds(ALevel, ABounds));
    end
    else    {4}
      FillRect(CalculateLevelIndentSpaceBounds(ALevel, ABounds),
        GridViewInfo.LevelIndentBackgroundBitmap);

    Brush.Color := GridViewInfo.LevelSeparatorColor;
    FillRect(CalculateLevelIndentVertLineBounds(ALevel, ABounds));

    Brush.Color := GridViewInfo.GridLineColor;
    FillRect(CalculateLevelIndentHorzLineBounds(ALevel, ABounds));
  end;
end;

procedure TcxCustomGridRowPainter.DrawLastHorzGridLine;
begin
  with Canvas do
  begin
    Brush.Color := ViewInfo.GridViewInfo.GridLineColor;
    FillRect(ViewInfo.LastHorzGridLineBounds);
  end;
end;

procedure TcxCustomGridRowPainter.DrawSeparator;
begin
  Canvas.Brush.Color := ViewInfo.SeparatorColor;
  Canvas.FillRect(ViewInfo.SeparatorBounds);
end;

procedure TcxCustomGridRowPainter.Paint;
begin
  DrawFooters;
  DrawIndent;
  if ViewInfo.HasLastHorzGridLine then DrawLastHorzGridLine;
  if ViewInfo.HasSeparator then DrawSeparator;
  inherited;
end;

{ TcxGridRowsPainter }

function TcxGridRowsPainter.GetViewInfo: TcxGridRowsViewInfo;
begin
  Result := TcxGridRowsViewInfo(inherited ViewInfo);
end;

class procedure TcxGridRowsPainter.DrawDataRowCells(ARowViewInfo: TcxCustomGridRowViewInfo);
var
  I: Integer;
  ACellViewInfo: TcxGridDataCellViewInfo;
begin
  with ARowViewInfo as TcxGridDataRowViewInfo do
  begin
    for I := 0 to CellViewInfoCount - 1 do
    begin
      ACellViewInfo := InternalCellViewInfos[I];
      if ACellViewInfo <> nil then ACellViewInfo.Paint;
    end;
    CellsAreaViewInfo.Paint;
  end;
end;

procedure TcxGridRowsPainter.Paint;
begin
  with ViewInfo do
    if HasNewItemRecord then NewItemRowViewInfo.Paint;
  inherited;
end;

{ TcxGridTablePainter }

function TcxGridTablePainter.GetController: TcxGridTableController;
begin
  Result := TcxGridTableController(inherited Controller);
end;

function TcxGridTablePainter.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxGridTablePainter.GetViewInfo: TcxGridTableViewInfo;
begin
  Result := TcxGridTableViewInfo(inherited ViewInfo);
end;

function TcxGridTablePainter.CanOffset(AItemsOffset, DX, DY: Integer): Boolean;
begin
  Result := inherited CanOffset(AItemsOffset, DX, DY) and
    ((AItemsOffset <> 0) or not GridView.IsMaster) and
    (ViewInfo.RecordsViewInfo.GroupBackgroundBitmap = nil) and
    ((AItemsOffset <> 0) or (ViewInfo.HeaderViewInfo.BackgroundBitmap = nil)) and
    (ViewInfo.FooterViewInfo.BackgroundBitmap = nil) and
    ((AItemsOffset <> 0) or not GridView.OptionsView.NewItemRow or
     (GridView.OptionsView.NewItemRowInfoText = ''));
end;

procedure TcxGridTablePainter.DrawFilterBar;
begin
  ViewInfo.FilterViewInfo.Paint;
end;

procedure TcxGridTablePainter.DrawFooter;
begin
  ViewInfo.FooterViewInfo.Paint;
end;

procedure TcxGridTablePainter.DrawGroupByBox;
begin
  ViewInfo.GroupByBoxViewInfo.Paint;
end;

procedure TcxGridTablePainter.DrawHeader;
begin
  ViewInfo.HeaderViewInfo.Paint;
end;

procedure TcxGridTablePainter.DrawIndicator;
begin
  ViewInfo.IndicatorViewInfo.Paint;
end;

procedure TcxGridTablePainter.DrawRecords;

  procedure DrawGridLines;
  type
    PPointArray = ^TPointArray;
    TPointArray = array of TPoint;
    PIntegerArray = ^TIntegerArray;
    TIntegerArray = array[0..0] of Integer;
  var
    P: TPointArray;
    N: PIntegerArray;
    I: Integer;
  begin
    SetLength(P, FGridLines.Count * 2);
    GetMem(N, FGridLines.Count * SizeOf(Integer));
    for I := 0 to FGridLines.Count - 1 do
    begin
      with PRect(FGridLines[I])^ do
      begin
        P[2 * I] := TopLeft;
        if Bottom = Top + 1 then
          P[2 * I + 1] := Point(Right, Top)
        else
          P[2 * I + 1] := Point(Left, Bottom);
      end;
      N^[I] := 2;
    end;
    with Canvas do
    begin
      Pen.Color := ViewInfo.GridLineColor;
      PolyPolyLine(Handle, P[0], N^, FGridLines.Count);
    end;
    FreeMem(N);
    P := nil;
  end;

  procedure ClearGridLines;
  var
    I: Integer;
  begin
    for I := 0 to FGridLines.Count - 1 do
      Dispose(PRect(FGridLines[I]));
  end;

begin
  FGridLines := TList.Create;
  try
    inherited;
    DrawGridLines;
  finally
    ClearGridLines;
    FreeAndNil(FGridLines);
  end;
end;

procedure TcxGridTablePainter.Offset(AItemsOffset: Integer);
var
  R, AUpdateBounds: TRect;
begin  {2}
  R := ViewInfo.GetOffsetBounds(AItemsOffset, AUpdateBounds);
  ScrollWindowEx(Site.Handle, 0, AItemsOffset, @R, nil, 0, nil, SW_ERASE or SW_INVALIDATE);
  Site.InvalidateRect(AUpdateBounds, True);
  Controller.InvalidateFocusedRecord;
end;

procedure TcxGridTablePainter.Offset(DX, DY: Integer);
var
  R, AUpdateBounds: TRect;
begin  {2}
  R := ViewInfo.GetOffsetBounds(DX, DY, AUpdateBounds);
  ScrollWindowEx(Site.Handle, DX, 0, @R, nil, 0, nil, SW_ERASE or SW_INVALIDATE);
  Site.InvalidateRect(AUpdateBounds, True);
  Controller.InvalidateFocusedRecord;
  Site.Update;
end;

procedure TcxGridTablePainter.PaintContent;
//var
//  ft,lt{,i}:integer;
begin
  {ft:=gettickcount;
  for I:=1 to 10 do
  begin}
  DrawGroupByBox;
  DrawFilterBar;
  DrawIndicator;
  DrawHeader;
  DrawFooter;
  inherited;
  {end;
  lt:=gettickcount;
  application.mainform.caption :=
  inttostr(lt-ft);}
end;

procedure TcxGridTablePainter.AddGridLine(const R: TRect);
var
  AR: PRect;
begin
  New(AR);
  AR^ := R;
  FGridLines.Add(AR);
end;

{ TcxCustomGridPartViewInfo }

constructor TcxCustomGridPartViewInfo.Create(AGridViewInfo: TcxGridTableViewInfo);
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

function TcxCustomGridPartViewInfo.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxCustomGridPartViewInfo.GetGridViewInfo: TcxGridTableViewInfo;
begin
  Result := TcxGridTableViewInfo(inherited GridViewInfo);
end;

function TcxCustomGridPartViewInfo.GetIndex: Integer;
begin
  Result := GridViewInfo.FParts.IndexOf(Self);
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

function TcxCustomGridPartViewInfo.GetHeight: Integer;
begin
  Result := inherited GetHeight;
  if Result = 0 then Result := FHeight;
end;

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

{ TcxGridColumnContainerZone }

constructor TcxGridColumnContainerZone.Create(AColumnIndex: Integer);
begin
  inherited Create;
  ColumnIndex := AColumnIndex;
end;

function TcxGridColumnContainerZone.IsEqual(Value: TcxGridColumnContainerZone): Boolean;
begin
  Result := (Value <> nil) and (ColumnIndex = Value.ColumnIndex);
end;

{ TcxGridColumnContainerViewInfo }

constructor TcxGridColumnContainerViewInfo.Create(AGridViewInfo: TcxGridTableViewInfo);
begin
  inherited;
  FItemHeight := -1;
  CreateItems;
end;

destructor TcxGridColumnContainerViewInfo.Destroy;
begin
  DestroyItems;
  inherited;
end;

function TcxGridColumnContainerViewInfo.GetController: TcxGridTableController;
begin
  Result := GridView.Controller;
end;

function TcxGridColumnContainerViewInfo.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxGridColumnContainerViewInfo.GetInternalItem(Index: Integer): TcxGridColumnHeaderViewInfo;
begin
  Result := TcxGridColumnHeaderViewInfo(FItems[Index]);
end;

function TcxGridColumnContainerViewInfo.GetItem(Index: Integer): TcxGridColumnHeaderViewInfo;
begin
  Result := InternalItems[Index];
  if Result = nil then
  begin
    Result := CreateItem(Index);
    FItems[Index] := Result;
  end;
end;

function TcxGridColumnContainerViewInfo.GetItemHeight: Integer;
begin
  if FItemHeight = -1 then
    FItemHeight := CalculateItemHeight;
  Result := FItemHeight;
end;

function TcxGridColumnContainerViewInfo.CreateItem(AIndex: Integer): TcxGridColumnHeaderViewInfo;
begin
  Result := GetItemClass.Create(Self, Columns[AIndex]);
end;

procedure TcxGridColumnContainerViewInfo.CreateItems;
begin
  FItems := TList.Create;
  FItems.Count := ColumnCount;
end;

procedure TcxGridColumnContainerViewInfo.DestroyItems;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do InternalItems[I].Free;
  FreeAndNil(FItems);
end;

function TcxGridColumnContainerViewInfo.CalculateItemHeight: Integer;
begin
  CalculateParams;
  Result := GetItemClass.GetCellHeight(
    GridViewInfo.GetFontHeight(Params.Font), LookAndFeelPainter);
end;

function TcxGridColumnContainerViewInfo.GetAutoHeight: Boolean;
begin
  Result := False;
end;

function TcxGridColumnContainerViewInfo.GetColumnAdditionalWidth(AColumn: TcxGridColumn): Integer;
begin
  if AColumn.IsMostLeft then
    Result := GridViewInfo.FirstItemAdditionalWidth
  else
    Result := 0;
end;

function TcxGridColumnContainerViewInfo.GetColumnMinWidth(AColumn: TcxGridColumn): Integer;
begin
  Result := AColumn.MinWidth + GetColumnAdditionalWidth(AColumn);
end;

function TcxGridColumnContainerViewInfo.GetColumnNeighbors(AColumn: TcxGridColumn): TcxNeighbors;
begin
  Result := [];
end;

function TcxGridColumnContainerViewInfo.GetColumnWidth(AColumn: TcxGridColumn): Integer;
begin
  Result := AColumn.Width + GetColumnAdditionalWidth(AColumn);
end;

function TcxGridColumnContainerViewInfo.GetItemClass: TcxGridColumnHeaderViewInfoClass;
begin
  Result := TcxGridColumnHeaderViewInfo;
end;

function TcxGridColumnContainerViewInfo.GetItemMultiLinePainting: Boolean;
begin
  Result := False;
end;

function TcxGridColumnContainerViewInfo.GetItemsAreaBounds: TRect;
begin
  Result := Bounds;
end;

function TcxGridColumnContainerViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridColumnContainerPainter;
end;

function TcxGridColumnContainerViewInfo.GetZonesAreaBounds: TRect;
begin
  Result := Bounds;
  Result.Right := GridViewInfo.ClientBounds.Right;
end;

procedure TcxGridColumnContainerViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  inherited;
  if AHitTest is TcxCustomGridColumnHitTest then
    TcxCustomGridColumnHitTest(AHitTest).ColumnContainerKind := Kind;
end;

procedure TcxGridColumnContainerViewInfo.Offset(DX, DY: Integer);
var
  I: Integer;
begin       {2}
  inherited;
  for I := 0 to Count - 1 do
    Items[I].DoOffset(DX, DY);
end;

procedure TcxGridColumnContainerViewInfo.BeforeRecalculation;
var
  I: Integer;
begin
  inherited;
  for I := 0 to Count - 1 do
    Items[I].BeforeRecalculation;
end;

function TcxGridColumnContainerViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := Items[I].GetHitTest(P);
    if Result <> nil then Exit;
  end;
  Result := inherited GetHitTest(P);
end;

function TcxGridColumnContainerViewInfo.GetZone(const P: TPoint): TcxGridColumnContainerZone;
var
  R: TRect;
  ALastBound, I: Integer;
begin
  Result := nil;
  if not Visible then Exit;
  R := ZonesAreaBounds;
  if not PtInRect(R, P) then Exit;
  ALastBound := R.Right;
  for I := 0 to Count do
  begin
    if I = Count then
      R.Right := ALastBound
    else
      with Items[I] do
        R.Right := (Bounds.Left + Bounds.Right) div 2;
    if PtInRect(R, P) then
    begin
      Result := TcxGridColumnContainerZone.Create(I);
      Break;
    end;
    R.Left := R.Right;
  end;
end;

{ TcxGridColumnHeaderAreaViewInfo }

constructor TcxGridColumnHeaderAreaViewInfo.Create(AColumnHeaderViewInfo: TcxGridColumnHeaderViewInfo);
begin
  inherited Create(AColumnHeaderViewInfo.GridViewInfo);
  FColumnHeaderViewInfo := AColumnHeaderViewInfo;
end;

function TcxGridColumnHeaderAreaViewInfo.GetColumn: TcxGridColumn;
begin
  Result := FColumnHeaderViewInfo.Column;
end;

function TcxGridColumnHeaderAreaViewInfo.GetGridView: TcxGridTableView;
begin
  Result := FColumnHeaderViewInfo.GridView;
end;

function TcxGridColumnHeaderAreaViewInfo.GetGridViewInfo: TcxGridTableViewInfo;
begin
  Result := FColumnHeaderViewInfo.GridViewInfo;
end;

function TcxGridColumnHeaderAreaViewInfo.GetAlignmentVert: TcxAlignmentVert;
begin
  Result := vaCenter;
end;

function TcxGridColumnHeaderAreaViewInfo.GetCanvas: TcxCanvas;
begin
  Result := GridViewInfo.Canvas;
end;

function TcxGridColumnHeaderAreaViewInfo.GetHeight: Integer;
begin
  Result := CalculateHeight;
end;

function TcxGridColumnHeaderAreaViewInfo.GetIsOccupyingSpace: Boolean;
begin
  Result := True;
end;

function TcxGridColumnHeaderAreaViewInfo.GetWidth: Integer;
begin
  Result := CalculateWidth;
end;

function TcxGridColumnHeaderAreaViewInfo.HasMouse(AHitTest: TcxCustomGridHitTest): Boolean;
begin
  Result := inherited HasMouse(AHitTest);
  if Result then
    with TcxCustomGridColumnHitTest(AHitTest) do
      Result := (Column = Self.Column) and
        (ColumnContainerKind = ColumnHeaderViewInfo.Container.Kind);
end;

procedure TcxGridColumnHeaderAreaViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  FColumnHeaderViewInfo.InitHitTest(AHitTest);
  inherited;
end;

{procedure TcxGridColumnHeaderAreaViewInfo.Invalidate;
begin
  if GridView <> nil then
    GridView.ViewChanged(Bounds);
end;}

procedure TcxGridColumnHeaderAreaViewInfo.Calculate(const ABounds: TRect;
  var ATextAreaBounds: TRect);

  procedure AlignHorizontally;
  begin
    case AlignmentHorz of
      taLeftJustify:
        begin
          Bounds.Right := Bounds.Left + Width;
          if IsOccupyingSpace then
            ATextAreaBounds.Left := Bounds.Right;
        end;
      taRightJustify:
        begin
          Bounds.Left := Bounds.Right - Width;
          if IsOccupyingSpace then
            ATextAreaBounds.Right := Bounds.Left;
        end;
      taCenter:
        begin
          Inc(Bounds.Left, (Bounds.Right - Bounds.Left - Width) div 2);
          Bounds.Right := Bounds.Left + Width;
        end;
    end;
  end;

  procedure AlignVertically;
  begin
    case AlignmentVert of
      vaTop:
        Bounds.Bottom := Bounds.Top + Height;
      vaBottom:
        Bounds.Top := Bounds.Bottom - Height;
      vaCenter:
        begin
          Inc(Bounds.Top, (Bounds.Bottom - Bounds.Top - Height) div 2);
          Bounds.Bottom := Bounds.Top + Height;
        end;
    end;
  end;

begin
  if IsOccupyingSpace then
    Bounds := ATextAreaBounds
  else
    Bounds := ABounds;
  if Width <> 0 then AlignHorizontally;
  if Height <> 0 then AlignVertically;
  with Bounds do
    inherited Calculate(Left, Top, Right - Left, Bottom - Top);
end;

{ TcxGridColumnHeaderSortingMarkViewInfo }

function TcxGridColumnHeaderSortingMarkViewInfo.GetSortOrder: TcxGridSortOrder;
begin
  Result := Column.SortOrder;
end;

function TcxGridColumnHeaderSortingMarkViewInfo.CalculateHeight: Integer;
begin
  Result := LookAndFeelPainter.SortingMarkAreaSize.Y;
end;

function TcxGridColumnHeaderSortingMarkViewInfo.CalculateWidth: Integer;
begin
  Result := LookAndFeelPainter.SortingMarkAreaSize.X;
end;

function TcxGridColumnHeaderSortingMarkViewInfo.GetAlignmentHorz: TAlignment;
begin
  Result := taRightJustify;
end;

function TcxGridColumnHeaderSortingMarkViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := nil;
end;

function TcxGridColumnHeaderSortingMarkViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridColumnHeaderSortingMarkPainter;
end;

function TcxGridColumnHeaderSortingMarkViewInfo.GetTransparent: Boolean;
begin
  Result := True;
end;

{ TcxGridColumnHeaderHorzSizingEdgeViewInfo }

function TcxGridColumnHeaderHorzSizingEdgeViewInfo.CalculateHeight: Integer;
begin
  Result := 0;
end;

function TcxGridColumnHeaderHorzSizingEdgeViewInfo.CalculateWidth: Integer;
begin
  Result := cxGridHeaderSizingEdgeSize;
end;

function TcxGridColumnHeaderHorzSizingEdgeViewInfo.GetAlignmentHorz: TAlignment;
begin
  Result := taRightJustify;
end;

function TcxGridColumnHeaderHorzSizingEdgeViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridColumnHeaderHorzSizingEdgeHitTest;
end;

function TcxGridColumnHeaderHorzSizingEdgeViewInfo.GetIsOccupyingSpace: Boolean;
begin
  Result := False;
end;

function TcxGridColumnHeaderHorzSizingEdgeViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := nil;
end;

function TcxGridColumnHeaderHorzSizingEdgeViewInfo.GetTransparent: Boolean;
begin
  Result := True;
end;

procedure TcxGridColumnHeaderHorzSizingEdgeViewInfo.Calculate(const ABounds: TRect;
  var ATextAreaBounds: TRect);
begin
  inherited;
  OffsetRect(Bounds, Width div 2, 0);
end;

function TcxGridColumnHeaderHorzSizingEdgeViewInfo.MouseDown(AHitTest: TcxCustomGridHitTest;
  AButton: TMouseButton; AShift: TShiftState): Boolean;
begin
  Result := inherited MouseDown(AHitTest, AButton, AShift);
  if (AButton = mbLeft) and (ssDouble in AShift) then
  begin
    Column.ApplyBestFit;
    Result := True;
  end;  
end;

{ TcxGridFilterPopup }

constructor TcxGridFilterPopup.Create(AGridView: TcxGridTableView);
begin
  inherited Create(AGridView.Site);
  FGridView := AGridView;
  AlignHorz := pahRight;
  OwnerParent := FGridView.Site;
  CaptureFocus := True;
  IsTopMost := True;
  FListBoxItems := TStringList.Create;
  FValueList := Filter.CreateValueList;
  CreateListBox;
end;

destructor TcxGridFilterPopup.Destroy;
begin
  FValueList.Free;
  FListBoxItems.Free;
  inherited;
end;

function TcxGridFilterPopup.GetColumn: TcxGridColumn;
begin
  Result := FOwnerViewInfo.Column;
end;

function TcxGridFilterPopup.GetFilter: TcxDataFilterCriteria;
begin
  Result := FGridView.DataController.Filter;
end;

procedure TcxGridFilterPopup.SetOwnerViewInfo(Value: TcxGridColumnHeaderFilterButtonViewInfo);
begin
  if FOwnerViewInfo <> Value then
  begin
    if (Value = nil) and Visible then
      CloseUp;
    FOwnerViewInfo := Value;
  end;
end;

procedure TcxGridFilterPopup.ListBoxDrawItem(AControl: TcxListBox; ACanvas: TcxCanvas;
  AIndex: Integer; ARect: TRect; AState: TOwnerDrawState);
begin
  with AControl, ACanvas do
  begin
    FillRect(ARect);
    Inc(ARect.Left, 2);
    DrawText(Items[AIndex], ARect, cxSingleLine or cxAlignLeft or cxAlignTop);
    Dec(ARect.Left, 2);
    if odFocused in AState then DrawFocusRect(ARect);
  end;
end;

procedure TcxGridFilterPopup.ListBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN:
      ApplyFilter(FListBox.ItemIndex);
    VK_ESCAPE:
      CloseUpAndFocusGridView;
  end;
end;

procedure TcxGridFilterPopup.ListBoxMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  with FListBox do
    ItemIndex := ItemAtPos(Point(X, Y), True);
end;

procedure TcxGridFilterPopup.ListBoxMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ApplyFilter(FListBox.ItemAtPos(Point(X, Y), True))
end;

procedure TcxGridFilterPopup.AddListBoxItems;
begin
  Column.DataBinding.GetFilterStrings(FListBoxItems, FValueList);
end;

procedure TcxGridFilterPopup.AdjustListBoxSize;
var
  ADropDownCount: Integer;

  function CalculateClientHeight: Integer;
  begin
    Result := ADropDownCount * FListBox.ItemHeight;
  end;

  function CalculateClientWidth: Integer;
  var
    I, AItemWidth: Integer;
  begin
    Result := FGridView.Filtering.DropDownWidth;
    if Result = 0 then
    begin
      for I := 0 to FListBoxItems.Count - 1 do
      begin
        AItemWidth := FListBox.Canvas.TextWidth(FListBoxItems[I]);
        if AItemWidth > Result then Result := AItemWidth;
      end;
      Inc(Result, 2 * 2);
    end;
    if ADropDownCount < FListBoxItems.Count then
      Inc(Result, GetScrollBarSize.cx);
  end;

begin
  with FListBox do
  begin
    ADropDownCount := FGridView.Filtering.GetDropDownCount(FListBoxItems.Count);
    ItemHeight := Canvas.TextHeight('Qq');
    ClientHeight := CalculateClientHeight;
    ClientWidth := CalculateClientWidth;
    if NCWidth + Width < FOwnerViewInfo.ColumnHeaderViewInfo.Width then
      Width := FOwnerViewInfo.ColumnHeaderViewInfo.Width - NCWidth;
  end;
end;

procedure TcxGridFilterPopup.ApplyFilter(AItemIndex: Integer);
begin
  CloseUpAndFocusGridView;
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
            Column.Filtered := False;
          fviCustom:
            FGridView.Filtering.RunCustomizeDialog(Column);
          fviBlanks:
            Column.DataBinding.AddToFilter(nil, foEqual, Value,
              cxGetResourceString(@cxSFilterBlankCaption));
          fviNonBlanks:
            Column.DataBinding.AddToFilter(nil, foNotEqual, Value,
              cxGetResourceString(@cxSFilterBlankCaption));
          fviUser:
            Column.DoUserFiltering(Value, DisplayText);
          fviValue:
            Column.DataBinding.AddToFilter(nil, foEqual, Value, DisplayText);
        end;
      end;  
    finally
      Filter.EndUpdate;
    end;
  end;
end;

function TcxGridFilterPopup.CalculateOwnerBounds: TRect;
begin
  Result := FOwnerViewInfo.Bounds;
  with FOwnerViewInfo.ColumnHeaderViewInfo.Bounds do
  begin
    Result.Left := Left;
    Result.Right := Right;
  end;
end;

procedure TcxGridFilterPopup.CreateListBox;
begin   
  FListBox := TcxListBox.Create(Self);
  with FListBox do
  begin
    Style.LookAndFeel.MasterLookAndFeel := TcxCustomGrid(GridView.Control).LookAndFeel;
    ListStyle := lbOwnerDrawFixed;
    with Style do
    begin
      BorderStyle := cbsNone;
      HotTrack := False;
      TransparentBorder := False;
    end;  
    Parent := Self;
    OnDrawItem := ListBoxDrawItem;
    OnKeyDown := ListBoxKeyDown;
    OnMouseMove := ListBoxMouseMove;
    OnMouseUp := ListBoxMouseUp;
  end;
end;

procedure TcxGridFilterPopup.InitPopup;
begin
  ShowHourglassCursor;
  try
    inherited;
    BorderStyle := FGridView.LookAndFeelPainter.PopupBorderStyle;
    Font := TcxControlAccess(FGridView.Control).Font;
    OwnerBounds := CalculateOwnerBounds;
    with FListBox do
      Canvas.Font := Font;
    AddListBoxItems;
    AdjustListBoxSize;
    FListBox.Items := FListBoxItems;
    FListBox.ItemIndex := FValueList.GetIndexByCriteriaItem(Column.DataBinding.FilterCriteriaItem);
  finally
    HideHourglassCursor;
  end;
end;

procedure TcxGridFilterPopup.Paint;
begin
  DrawFrame;
end;

procedure TcxGridFilterPopup.VisibleChanged;
begin
  inherited;
  if not Visible and (FOwnerViewInfo <> nil) then
  begin
    FOwnerViewInfo.State := gcsNone;
  end;
end;

procedure TcxGridFilterPopup.CloseUp;
begin
  inherited CloseUp;
  FListBox.Clear;
  TcxControlAccess(GridView.Site).FocusChanged;
  //TcxCustomGridAccess(GridView.Control).UpdateFocusing(GridView.IsControlFocused{ Site.IsFocused});
  //GridView.Controller.InvalidateSelection;
end;

procedure TcxGridFilterPopup.CloseUpAndFocusGridView;
begin
  CloseUp;
end;

procedure TcxGridFilterPopup.Popup(AOwnerViewInfo: TcxGridColumnHeaderFilterButtonViewInfo);
begin
  FOwnerViewInfo := AOwnerViewInfo;
  inherited Popup(FListBox);
end;

{ TcxGridColumnHeaderFilterButtonViewInfo }

destructor TcxGridColumnHeaderFilterButtonViewInfo.Destroy;
begin
  if GridView.Controller.HasFilterPopup and
    (DropDownWindow.OwnerViewInfo = Self) then
    DropDownWindow.OwnerViewInfo := nil;
  inherited;
end;

function TcxGridColumnHeaderFilterButtonViewInfo.GetActive: Boolean;
begin
  Result := Column.Filtered;
end;

function TcxGridColumnHeaderFilterButtonViewInfo.GetDropDownWindow: TcxGridFilterPopup;
begin
  Result := GridView.Controller.FilterPopup;
end;

procedure TcxGridColumnHeaderFilterButtonViewInfo.BeforeStateChange;
begin
  inherited;
  if State = gcsPressed then CloseUp;
end;

function TcxGridColumnHeaderFilterButtonViewInfo.CalculateHeight: Integer;
begin
  Result := LookAndFeelPainter.FilterDropDownButtonSize.Y;
end;

function TcxGridColumnHeaderFilterButtonViewInfo.CalculateWidth: Integer;
begin
  Result := LookAndFeelPainter.FilterDropDownButtonSize.X;
end;

function TcxGridColumnHeaderFilterButtonViewInfo.EmulateMouseMoveAfterCalculate: Boolean;
begin
  Result := True;
end;

function TcxGridColumnHeaderFilterButtonViewInfo.GetAlignmentHorz: TAlignment;
begin
  Result := taRightJustify;
end;

function TcxGridColumnHeaderFilterButtonViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridColumnHeaderFilterButtonHitTest;
end;

function TcxGridColumnHeaderFilterButtonViewInfo.GetHotTrack: Boolean;
begin
  Result := True;
end;

function TcxGridColumnHeaderFilterButtonViewInfo.GetIsCheck: Boolean;
begin
  Result := True;
end;

function TcxGridColumnHeaderFilterButtonViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridColumnHeaderFilterButtonPainter;
end;

function TcxGridColumnHeaderFilterButtonViewInfo.GetTransparent: Boolean;
begin
  Result := False;
end;

procedure TcxGridColumnHeaderFilterButtonViewInfo.StateChanged;
begin
  inherited;
  if State = gcsPressed then DropDown;
end;

procedure TcxGridColumnHeaderFilterButtonViewInfo.CloseUp;
begin
(*   // check!
  DropDownWindow.DestroyHandle;
*)
  //GridView.Controller.InvalidateSelection;
end;

procedure TcxGridColumnHeaderFilterButtonViewInfo.DropDown;
begin
  DropDownWindow.Popup(Self);
end;

{ TcxGridColumnHeaderGlyphViewInfo }

function TcxGridColumnHeaderGlyphViewInfo.GetGlyph: TBitmap;
begin
  Result := Column.HeaderGlyph;
end;

function TcxGridColumnHeaderGlyphViewInfo.CalculateHeight: Integer;
begin
  Result := Glyph.Height;
end;

function TcxGridColumnHeaderGlyphViewInfo.CalculateWidth: Integer;
begin
  Result := Glyph.Width;
end;

function TcxGridColumnHeaderGlyphViewInfo.GetAlignmentHorz: TAlignment;
begin
  Result := Column.HeaderGlyphAlignmentHorz;
end;

function TcxGridColumnHeaderGlyphViewInfo.GetAlignmentVert: TcxAlignmentVert;
begin
  Result := Column.HeaderGlyphAlignmentVert;
end;

function TcxGridColumnHeaderGlyphViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := nil;
end;

function TcxGridColumnHeaderGlyphViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridColumnHeaderGlyphPainter;
end;

function TcxGridColumnHeaderGlyphViewInfo.GetTransparent: Boolean;
begin
  Result := True;
end;

{ TcxGridColumnHeaderViewInfo }

constructor TcxGridColumnHeaderViewInfo.Create(AContainer: TcxGridColumnContainerViewInfo;
  AColumn: TcxGridColumn);
begin
  inherited Create(AContainer.GridViewInfo);
  FAreaViewInfos := TList.Create;
  FContainer := AContainer;
  FColumn := AColumn;
  FWidth := -1;
  Width := -1;
  CreateAreaViewInfos;
end;

destructor TcxGridColumnHeaderViewInfo.Destroy;
begin
  DestroyAreaViewInfos;
  FAreaViewInfos.Free;
  inherited;
end;

function TcxGridColumnHeaderViewInfo.GetAreaViewInfoCount: Integer;
begin
  Result := FAreaViewInfos.Count;
end;

function TcxGridColumnHeaderViewInfo.GetAreaViewInfo(Index: Integer): TcxGridColumnHeaderAreaViewInfo;
begin
  Result := TcxGridColumnHeaderAreaViewInfo(FAreaViewInfos[Index]);
end;

function TcxGridColumnHeaderViewInfo.GetGridView: TcxGridTableView;
begin
  Result := FContainer.GridView;
//  if Result.IsDestroying then Result := nil;
end;

function TcxGridColumnHeaderViewInfo.GetGridViewInfo: TcxGridTableViewInfo;
begin
  Result := FContainer.GridViewInfo;
end;

function TcxGridColumnHeaderViewInfo.GetIndex: Integer;
begin
  Result := FColumn.VisibleIndex;
end;

function TcxGridColumnHeaderViewInfo.GetIsFixed: Boolean;
begin
  Result := FColumn.Fixed;
end;

function TcxGridColumnHeaderViewInfo.GetRealBounds: TRect;
begin
  Result := Bounds;
  Inc(Result.Left, FAdditionalWidth);
end;

function TcxGridColumnHeaderViewInfo.GetRealWidth: Integer;
begin
  if FRealWidth = 0 then
    FRealWidth := CalculateRealWidth(Width);
  Result := FRealWidth;
end;

procedure TcxGridColumnHeaderViewInfo.EnumAreaViewInfoClasses(AClass: TClass);
begin
  FAreaViewInfos.Add(TcxGridColumnHeaderAreaViewInfoClass(AClass).Create(Self));
end;

procedure TcxGridColumnHeaderViewInfo.CreateAreaViewInfos;
begin
  GetAreaViewInfoClasses(EnumAreaViewInfoClasses);
end;

procedure TcxGridColumnHeaderViewInfo.DestroyAreaViewInfos;
var
  I: Integer;
begin
  for I := 0 to AreaViewInfoCount - 1 do
    AreaViewInfos[I].Free;
end;

function TcxGridColumnHeaderViewInfo.CalculateHasTextOffsetLeft: Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to AreaViewInfoCount - 1 do
    with AreaViewInfos[I] do
      if IsOccupyingSpace and (AlignmentHorz = taLeftJustify) then Exit;
  Result := False;    
end;

function TcxGridColumnHeaderViewInfo.CalculateHasTextOffsetRight: Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to AreaViewInfoCount - 1 do
    with AreaViewInfos[I] do
      if IsOccupyingSpace and (AlignmentHorz = taRightJustify) then Exit;
  Result := False;
end;

function TcxGridColumnHeaderViewInfo.CalculateHeight: Integer;
begin
  Result := GetTextCellHeight(GridViewInfo, LookAndFeelPainter);
end;

function TcxGridColumnHeaderViewInfo.CalculateRealWidth(Value: Integer): Integer;
begin
  Result := Value - FContainer.GetColumnAdditionalWidth(Column);
end;

procedure TcxGridColumnHeaderViewInfo.CalculateTextAreaBounds;

  procedure CalcAreaViewInfos;
  var
    I: Integer;
  begin
    for I := 0 to AreaViewInfoCount - 1 do
      AreaViewInfos[I].Calculate(Bounds, FTextAreaBounds);
  end;

begin
  FTextAreaBounds := inherited GetTextAreaBounds;
  CalcAreaViewInfos;
  if FHasTextOffsetLeft then
    Inc(FTextAreaBounds.Left, cxGridCellTextOffset);
  if FHasTextOffsetRight then
    Dec(FTextAreaBounds.Right, cxGridCellTextOffset);
end;

procedure TcxGridColumnHeaderViewInfo.CalculateVisible(ALeftBound, AWidth: Integer);
begin
  with GridViewInfo.ClientBounds do
    Visible := (ALeftBound < Right) and (ALeftBound + AWidth > Left);
end;

function TcxGridColumnHeaderViewInfo.CalculateWidth: Integer;
begin
  if FWidth = -1 then
    FWidth := FContainer.GetColumnWidth(Column);
  Result := FWidth;
end;

function TcxGridColumnHeaderViewInfo.CanFilter: Boolean;
begin
  Result := FColumn.CanFilter(True);
end;

function TcxGridColumnHeaderViewInfo.CanHorzSize: Boolean;
begin
  Result := FColumn.CanHorzSize and (Container.Kind = ccHeader);
end;

function TcxGridColumnHeaderViewInfo.CanPress: Boolean;
begin
  Result := True;
end;

function TcxGridColumnHeaderViewInfo.CanSort: Boolean;
begin
  Result := FColumn.SortOrder <> soNone;
end;

procedure TcxGridColumnHeaderViewInfo.CheckWidth(var Value: Integer);
begin
  if Value < MinWidth then Value := MinWidth;
  if Value > MaxWidth then Value := MaxWidth;
end;

function TcxGridColumnHeaderViewInfo.CustomDraw(ACanvas: TcxCanvas): Boolean;
begin
  Result := inherited CustomDraw(ACanvas);
  if not Result then
  begin
    FColumn.DoCustomDrawHeader(ACanvas, Self, Result);
    if not Result then
      GridView.DoCustomDrawColumnHeader(ACanvas, Self, Result);
  end;
end;

procedure TcxGridColumnHeaderViewInfo.DoCalculateParams;
begin
  FNeighbors := FContainer.GetColumnNeighbors(Column);
  FHasTextOffsetLeft := CalculateHasTextOffsetLeft;
  FHasTextOffsetRight := CalculateHasTextOffsetRight;
  inherited;
  CalculateTextAreaBounds;
end;

function TcxGridColumnHeaderViewInfo.GetAlignmentHorz: TAlignment;
begin
  Result := FColumn.HeaderAlignmentHorz;
end;

function TcxGridColumnHeaderViewInfo.GetAlignmentVert: TcxAlignmentVert;
begin
  Result := FColumn.HeaderAlignmentVert;
end;

procedure TcxGridColumnHeaderViewInfo.GetAreaViewInfoClasses(AProc: TcxGridClassEnumeratorProc);
begin
  if CanHorzSize then AProc(TcxGridColumnHeaderHorzSizingEdgeViewInfo);
  if CanFilter then AProc(TcxGridColumnHeaderFilterButtonViewInfo);
  if CanSort then AProc(TcxGridColumnHeaderSortingMarkViewInfo);
  if HasGlyph then AProc(TcxGridColumnHeaderGlyphViewInfo);
end;

function TcxGridColumnHeaderViewInfo.GetBackgroundBitmap: TBitmap;
begin
  Result := GridViewInfo.HeaderViewInfo.ColumnBackgroundBitmap;
end;

function TcxGridColumnHeaderViewInfo.GetBorders: TcxBorders;
begin
  Result := LookAndFeelPainter.HeaderBorders(Neighbors);
end;

function TcxGridColumnHeaderViewInfo.GetBorderWidth(AIndex: TcxBorder): Integer;
begin
  Result := GetCellBorderWidth(LookAndFeelPainter);
end;

function TcxGridColumnHeaderViewInfo.GetCanvas: TcxCanvas;
begin
  Result := GridViewInfo.Canvas;
end;

class function TcxGridColumnHeaderViewInfo.GetCellBorderWidth(ALookAndFeelPainter: TcxCustomLookAndFeelPainterClass): Integer;
begin
  Result := ALookAndFeelPainter.HeaderBorderSize;
end;

class function TcxGridColumnHeaderViewInfo.GetCellHeight(ATextHeight: Integer;
  ALookAndFeelPainter: TcxCustomLookAndFeelPainterClass): Integer;
begin
  Result := inherited GetCellHeight(ATextHeight, ALookAndFeelPainter);
  Inc(Result, 2 * GetCellBorderWidth(ALookAndFeelPainter));
end;

function TcxGridColumnHeaderViewInfo.GetDataOffset: Integer;
begin
  Result := Bounds.Right - RealWidth;
end;

function TcxGridColumnHeaderViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridColumnHeaderHitTest;
end;

function TcxGridColumnHeaderViewInfo.GetHotTrack: Boolean;
begin
  Result := LookAndFeelPainter.IsHeaderHotTrack;
end;

function TcxGridColumnHeaderViewInfo.GetIsPressed: Boolean;
begin
  Result := (State = gcsPressed) or (GridViewInfo.Controller.PressedColumn = Column);
end;

function TcxGridColumnHeaderViewInfo.GetMaxWidth: Integer;
var
  AIndex, I: Integer;
begin
  if GridView.OptionsView.ColumnAutoWidth then
  begin
    Result := GridViewInfo.ClientWidth;
    AIndex := Column.VisibleIndex;
    if AIndex = FContainer.Count - 1 then
      for I := 0 to AIndex - 1 do
        Dec(Result, FContainer[I].MinWidth)
    else
      for I := 0 to FContainer.Count - 1 do
      begin
        if I < AIndex then
          Dec(Result, FContainer[I].Width);
        if I > AIndex then
          Dec(Result, FContainer[I].MinWidth);
      end;
    if Result < MinWidth then Result := MinWidth;
  end
  else
    Result := MaxInt;
end;

function TcxGridColumnHeaderViewInfo.GetMinWidth: Integer;
begin
  Result := FContainer.GetColumnMinWidth(Column);
end;

function TcxGridColumnHeaderViewInfo.GetMultiLine: Boolean;
begin
  Result := FContainer.AutoHeight;
end;

function TcxGridColumnHeaderViewInfo.GetMultiLinePainting: Boolean;
begin
  Result := inherited GetMultiLinePainting or FContainer.ItemMultiLinePainting;
end;

function TcxGridColumnHeaderViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridColumnHeaderPainter;
end;

function TcxGridColumnHeaderViewInfo.GetShowEndEllipsis: Boolean;
begin
  Result := GridView.OptionsView.HeaderEndEllipsis;
end;

function TcxGridColumnHeaderViewInfo.GetText: string;
begin
  Result := Column.Caption;
end;

function TcxGridColumnHeaderViewInfo.GetTextAreaBounds: TRect;
begin
  Result := FTextAreaBounds;
end;

procedure TcxGridColumnHeaderViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  Column.Styles.GetHeaderParams(AParams);
end;

function TcxGridColumnHeaderViewInfo.GetWidth: Integer;
begin
  Result := inherited GetWidth - FAdditionalWidth;
end;

function TcxGridColumnHeaderViewInfo.HasCustomDraw: Boolean;
begin
  Result := Column.HasCustomDrawHeader or GridView.HasCustomDrawColumnHeader;
end;

function TcxGridColumnHeaderViewInfo.HasGlyph: Boolean;
begin
  Result := not FColumn.HeaderGlyph.Empty;
end;

procedure TcxGridColumnHeaderViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  FContainer.InitHitTest(AHitTest);
  inherited;
  (AHitTest as TcxCustomGridColumnHitTest).Column := Column;
end;

procedure TcxGridColumnHeaderViewInfo.Offset(DX, DY: Integer);
var
  I: Integer;
begin  {2}
  inherited;
  OffsetRect(FTextAreaBounds, DX, DY);
  for I := 0 to AreaViewInfoCount - 1 do
    AreaViewInfos[I].DoOffset(DX, DY);
end;

procedure TcxGridColumnHeaderViewInfo.SetWidth(Value: Integer);
begin
  inherited;
  FWidth := Value;
end;

procedure TcxGridColumnHeaderViewInfo.StateChanged;
begin
  inherited;
  case State of
    gcsPressed:
      MouseCapture := True;
    gcsNone:
      MouseCapture := False;
  end;
end;

procedure TcxGridColumnHeaderViewInfo.Calculate(ALeftBound, ATopBound: Integer;
  AWidth: Integer = -1; AHeight: Integer = -1);

  procedure CheckHiddenBorders;
  var
    AHiddenBorders: TcxBorders;
  begin
    CalculateParams;
    AHiddenBorders := cxBordersAll - Borders;
    if AHiddenBorders <> [] then
    begin
      if bLeft in AHiddenBorders then
      begin
        Dec(ALeftBound, BorderWidth[bLeft]);
        Inc(AWidth, BorderWidth[bLeft]);
        Inc(FAdditionalWidth, BorderWidth[bLeft]);
      end;
      if bTop in AHiddenBorders then
      begin
        Dec(ATopBound, BorderWidth[bTop]);
        Inc(AHeight, BorderWidth[bTop]);
      end;
      Borders := cxBordersAll;
    end;
  end;

begin
  FAdditionalWidth := 0;
  if AWidth = -1 then
    AWidth := CalculateWidth;
  CalculateVisible(ALeftBound, AWidth);
  CheckHiddenBorders;
  inherited;
  {if Visible then }CalculateTextAreaBounds;
end;

function TcxGridColumnHeaderViewInfo.GetBestFitWidth: Integer;
var
  I: Integer;
begin
  Result := BorderSize[bLeft] + TextAreaWidth + BorderSize[bRight] -
    FAdditionalWidth;
  if FHasTextOffsetLeft then Inc(Result, cxGridCellTextOffset);
  if FHasTextOffsetRight then Inc(Result, cxGridCellTextOffset);
  for I := 0 to AreaViewInfoCount - 1 do
    with AreaViewInfos[I] do
      if IsOccupyingSpace then Inc(Result, Width);
end;

function TcxGridColumnHeaderViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
var
  I: Integer;
begin
  for I := 0 to AreaViewInfoCount - 1 do
  begin
    Result := AreaViewInfos[I].GetHitTest(P);
    if Result <> nil then Exit;
  end;
  Result := inherited GetHitTest(P);
end;

procedure TcxGridColumnHeaderViewInfo.InitAutoWidthItem(AAutoWidthItem: TcxAutoWidthItem);
begin
  AAutoWidthItem.MinWidth := MinWidth;
  AAutoWidthItem.Width := CalculateWidth;
  AAutoWidthItem.Fixed := IsFixed;
end;

function TcxGridColumnHeaderViewInfo.MouseDown(AHitTest: TcxCustomGridHitTest;
  AButton: TMouseButton; AShift: TShiftState): Boolean;
begin
  Result := inherited MouseDown(AHitTest, AButton, AShift);
  if (AButton = mbLeft) and not (ssDouble in AShift) and CanPress then
  begin
    GridView.Controller.PressedColumn := FColumn;
    FColumn.DoHeaderClick;
    Result := True;
  end;
end;

{ TcxGridHeaderViewInfoSpecific }

constructor TcxGridHeaderViewInfoSpecific.Create(AContainerViewInfo: TcxGridHeaderViewInfo);
begin
  inherited Create;
  FContainerViewInfo := AContainerViewInfo;
end;

function TcxGridHeaderViewInfoSpecific.GetGridViewInfo: TcxGridTableViewInfo;
begin
  Result := FContainerViewInfo.GridViewInfo;
end;

function TcxGridHeaderViewInfoSpecific.GetItemHeight: Integer;
begin
  Result := FContainerViewInfo.ItemHeight;
end;

function TcxGridHeaderViewInfoSpecific.CalculateHeight: Integer;
begin
  Result := ItemHeight;
end;

function TcxGridHeaderViewInfoSpecific.GetHeight: Integer;
begin
  Result := CalculateHeight;
end;

{ TcxGridHeaderViewInfo }

constructor TcxGridHeaderViewInfo.Create(AGridViewInfo: TcxGridTableViewInfo);
begin
  inherited;
  FSpecific := AGridViewInfo.GetHeaderViewInfoSpecificClass.Create(Self);
end;

destructor TcxGridHeaderViewInfo.Destroy;
begin
  FSpecific.Free;
  inherited;
end;

procedure TcxGridHeaderViewInfo.CalculateColumnAutoWidths;
var
  AAutoWidthObject: TcxAutoWidthObject;
  I: Integer;
begin
  AAutoWidthObject := TcxAutoWidthObject.Create(Count);
  try
    for I := 0 to Count - 1 do
      Items[I].InitAutoWidthItem(AAutoWidthObject.AddItem);
    AAutoWidthObject.AvailableWidth := GridViewInfo.ClientWidth;
    AAutoWidthObject.Calculate;
    for I := 0 to Count - 1 do
      Items[I].Width := AAutoWidthObject[I].AutoWidth;
  finally
    AAutoWidthObject.Free;
  end;
end;

procedure TcxGridHeaderViewInfo.CalculateColumnWidths;
begin
  if CanCalculateAutoWidths then CalculateColumnAutoWidths;
end;

function TcxGridHeaderViewInfo.CalculateHeight: Integer;
begin
  Result := FSpecific.Height;
end;

procedure TcxGridHeaderViewInfo.CalculateInvisible;
begin
  if IsAlwaysVisibleForCalculation then
  begin
    CalculateVisible;
    FHeight := 0;
    Bounds := Rect(0, 0, 0, 0);
  end
  else
    inherited;
end;

function TcxGridHeaderViewInfo.CalculateItemHeight: Integer;
var
  I, AColumnHeight: Integer;
begin
  if IsHeightAssigned then
    Result := GridView.OptionsView.HeaderHeight
  else
  begin
    Result := 0;
    CalculateParams;
    for I := 0 to Count - 1 do
      if Items[I].Visible then
      begin
        AColumnHeight := Items[I].CalculateHeight;
        if AColumnHeight > Result then Result := AColumnHeight;
      end;
    if Result = 0 then
      Result := inherited CalculateItemHeight;
  end;    
end;

procedure TcxGridHeaderViewInfo.CalculateItems;
var
  ALeftBound, ATopBound, I, AWidth: Integer;
  AItem: TcxGridColumnHeaderViewInfo;
begin
  with ItemsAreaBounds do
  begin
    ALeftBound := Left;
    ATopBound := Top;
  end;
  for I := 0 to Count - 1 do
  begin
    AItem := Items[I];
    AWidth := AItem.CalculateWidth;
    AItem.Calculate(ALeftBound, ATopBound, AWidth, ItemHeight);
    Inc(ALeftBound, AWidth);
  end;
end;

procedure TcxGridHeaderViewInfo.CalculateVisible;
begin
  CalculateColumnWidths;
  inherited;
end;

function TcxGridHeaderViewInfo.CalculateWidth: Integer;
begin
  Result := GridViewInfo.RecordsViewInfo.RowWidth;
end;

function TcxGridHeaderViewInfo.CanCalculateAutoWidths: Boolean;
begin
  Result := GridView.OptionsView.ColumnAutoWidth;
end;

function TcxGridHeaderViewInfo.DrawColumnBackgroundHandler(ACanvas: TcxCanvas;
  const ABounds: TRect): Boolean;
begin  {4}
  Result := ColumnBackgroundBitmap <> nil;
  if Result then
    ACanvas.FillRect(ABounds, ColumnBackgroundBitmap);
end;

function TcxGridHeaderViewInfo.GetAlignment: TcxGridPartAlignment;
begin
  Result := gpaTop;
end;

function TcxGridHeaderViewInfo.GetAutoHeight: Boolean;
begin
  Result := GridView.OptionsView.HeaderAutoHeight;
end;

function TcxGridHeaderViewInfo.GetColumn(Index: Integer): TcxGridColumn;
begin
  Result := GridView.VisibleColumns[Index];
end;

function TcxGridHeaderViewInfo.GetColumnBackgroundBitmap: TBitmap;
begin     {4}
  Result := GridView.BackgroundBitmaps.GetBitmap(bbHeader);
end;

function TcxGridHeaderViewInfo.GetColumnCount: Integer;
begin
  Result := GridView.VisibleColumnCount;
end;

function TcxGridHeaderViewInfo.GetColumnNeighbors(AColumn: TcxGridColumn): TcxNeighbors;
begin
  Result := [];
  if not AColumn.IsLeft then Include(Result, nLeft);
  if not AColumn.IsRight then Include(Result, nRight);
end;

function TcxGridHeaderViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridHeaderHitTest;
end;

function TcxGridHeaderViewInfo.GetIsAutoWidth: Boolean;
begin
  Result := False;
end;

function TcxGridHeaderViewInfo.GetIsScrollable: Boolean;
begin
  Result := True;
end;

function TcxGridHeaderViewInfo.GetItemMultiLinePainting: Boolean;
begin
  Result := inherited GetItemMultiLinePainting or IsHeightAssigned;
end;

function TcxGridHeaderViewInfo.GetKind: TcxGridColumnContainerKind;
begin
  Result := ccHeader;
end;

function TcxGridHeaderViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridHeaderPainter;
end;

procedure TcxGridHeaderViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  GridView.Styles.GetHeaderParams(nil, AParams);
end;

function TcxGridHeaderViewInfo.GetVisible: Boolean;
begin
  Result := GridView.OptionsView.Header;
end;

function TcxGridHeaderViewInfo.GetWidth: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    Inc(Result, Items[I].CalculateWidth);
end;

function TcxGridHeaderViewInfo.GetZonesAreaBounds: TRect;
begin
  Result := inherited GetZonesAreaBounds;
  InflateRect(Result, 0, ColumnHeaderMovingZoneSize);
end;

function TcxGridHeaderViewInfo.IsAlwaysVisibleForCalculation: Boolean;
begin
  Result := True;
end;

function TcxGridHeaderViewInfo.IsHeightAssigned: Boolean;
begin
  Result := GridView.OptionsView.HeaderHeight <> 0;
end;

procedure TcxGridHeaderViewInfo.Offset(DX, DY: Integer);
begin                                 {2}
  inherited;
  RecalculateItemVisibles;
end;

procedure TcxGridHeaderViewInfo.RecalculateItemVisibles;
var
  I: Integer;
begin        
  for I := 0 to Count - 1 do
    with Items[I] do
      CalculateVisible(Bounds.Left, Bounds.Right - Bounds.Left);
end;

procedure TcxGridHeaderViewInfo.AssignColumnWidths;
var
  I: Integer;
begin
  GridView.BeginUpdate;
  try
    for I := 0 to Count - 1 do
      with Items[I] do
        Column.Width := RealWidth;
  finally
    GridView.EndUpdate;
  end;
end;

procedure TcxGridHeaderViewInfo.Calculate(ALeftBound, ATopBound: Integer;
  AWidth: Integer = -1; AHeight: Integer = -1);
begin
  inherited;
  CalculateItems;
end;

{ TcxGridGroupByBoxColumnHeaderViewInfo }

function TcxGridGroupByBoxColumnHeaderViewInfo.CalculateHeight: Integer;
begin
  Result := TcxGridGroupByBoxViewInfo(Container).ItemHeight;
end;

function TcxGridGroupByBoxColumnHeaderViewInfo.InheritedCalculateHeight: Integer;
begin
  Result := inherited CalculateHeight;
end;

{ TcxGridGroupByBoxViewInfo }

function TcxGridGroupByBoxViewInfo.GetGroupByBoxVerOffset: Integer;
begin
  Result := ItemHeight div 2;
end;

function TcxGridGroupByBoxViewInfo.GetLinkLineBounds(Index: Integer;
  Horizontal: Boolean): TRect;
begin
  Result := Items[Index].Bounds;
  Result.Left := Result.Right - 2 * GroupByBoxHorOffset;
  Result.Top := Result.Bottom;
  Inc(Result.Bottom, GroupByBoxLineVerOffset);
  if Horizontal then
  begin
    Result.Top := Result.Bottom - GroupByBoxLineWidth;
    Inc(Result.Right, GroupByBoxHorOffset);
  end
  else
    Result.Right := Result.Left + GroupByBoxLineWidth;
end;

function TcxGridGroupByBoxViewInfo.CalculateHeight: Integer;

  function TextHeight: Integer;
  begin
    CalculateParams;
    Result := GridViewInfo.GetFontHeight(Params.Font);
    GetCellTextAreaSize(Result);
    Inc(Result, 2);
  end;

begin
  Result := ColumnCount;
  if Result = 0 then
    Result := 2 * GroupByBoxTopOffset + TextHeight
  else
    Result := 2 * GroupByBoxTopOffset +
      ItemHeight div 2 * (Result + 1) + Byte(Odd(ItemHeight));
end;

function TcxGridGroupByBoxViewInfo.CalculateItemHeight: Integer;
var
  I, AColumnHeight: Integer;
begin
  Result := 0;
  CalculateParams;
  for I := 0 to Count - 1 do
  begin
    AColumnHeight := TcxGridGroupByBoxColumnHeaderViewInfo(Items[I]).InheritedCalculateHeight;
    if AColumnHeight > Result then Result := AColumnHeight;
  end;
  if Result = 0 then
    Result := inherited CalculateItemHeight;
end;

function TcxGridGroupByBoxViewInfo.CalculateWidth: Integer;
begin
  Result := GridViewInfo.ClientWidth;
end;

function TcxGridGroupByBoxViewInfo.GetAlignment: TcxGridPartAlignment;
begin
  Result := gpaTop;
end;

function TcxGridGroupByBoxViewInfo.GetAlignmentVert: TcxAlignmentVert;
begin
  Result := vaCenter;
end;

function TcxGridGroupByBoxViewInfo.GetBackgroundBitmap: TBitmap;
begin     {4}
  Result := GridView.BackgroundBitmaps.GetBitmap(bbGroupByBox);
end;

function TcxGridGroupByBoxViewInfo.GetColumn(Index: Integer): TcxGridColumn;
begin
  Result := GridView.GroupedColumns[Index];
end;

function TcxGridGroupByBoxViewInfo.GetColumnCount: Integer;
begin
  Result := GridView.GroupedColumnCount;
end;

function TcxGridGroupByBoxViewInfo.GetColumnWidth(AColumn: TcxGridColumn): Integer;
begin
  Result := Items[AColumn.GroupIndex].GetBestFitWidth;
end;

function TcxGridGroupByBoxViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridGroupByBoxHitTest;
end;

function TcxGridGroupByBoxViewInfo.GetIsAutoWidth: Boolean;
begin
  Result := True;
end;

function TcxGridGroupByBoxViewInfo.GetIsScrollable: Boolean;
begin
  Result := False;
end;

function TcxGridGroupByBoxViewInfo.GetItemClass: TcxGridColumnHeaderViewInfoClass;
begin
  Result := TcxGridGroupByBoxColumnHeaderViewInfo;
end;

function TcxGridGroupByBoxViewInfo.GetKind: TcxGridColumnContainerKind;
begin
  Result := ccGroupByBox;
end;

function TcxGridGroupByBoxViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridGroupByBoxPainter;
end;

function TcxGridGroupByBoxViewInfo.GetText: string;
begin
  if Count = 0 then
    Result := cxGetResourceString(@scxGridGroupByBoxCaption)
  else
    Result := '';
end;

function TcxGridGroupByBoxViewInfo.GetTextAreaBounds: TRect;
begin
  Result := inherited GetTextAreaBounds;
  Inc(Result.Left, GroupByBoxLeftOffset);
end;

procedure TcxGridGroupByBoxViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  GridView.Styles.GetViewParams(vsGroupByBox, nil, nil, AParams);
end;

function TcxGridGroupByBoxViewInfo.GetVisible: Boolean;
begin
  Result := GridView.OptionsView.GroupByBox;
end;

procedure TcxGridGroupByBoxViewInfo.Calculate(ALeftBound, ATopBound: Integer;
  AWidth: Integer = -1; AHeight: Integer = -1);
var
  I: Integer;
  AColumnHeaderViewInfo: TcxGridColumnHeaderViewInfo;
begin
  inherited;
  with Bounds do
  begin
    ALeftBound := Left + GroupByBoxLeftOffset;
    ATopBound := Top + GroupByBoxTopOffset;
  end;
  for I := 0 to Count - 1 do
  begin
    AColumnHeaderViewInfo := Items[I];
    AColumnHeaderViewInfo.Calculate(ALeftBound, ATopBound);
    Inc(ALeftBound, AColumnHeaderViewInfo.Width + GroupByBoxHorOffset);
    Inc(ATopBound, GroupByBoxVerOffset);
  end;
end;

{ TcxGridFooterCellViewInfo }

function TcxGridFooterCellViewInfo.GetSummary: TcxDataSummary;
begin
  Result := GridView.DataController.Summary;
end;

procedure TcxGridFooterCellViewInfo.AfterCalculateBounds(var ABounds: TRect);
begin
  inherited;
  with LookAndFeelPainter do
    InflateRect(ABounds, -FooterCellOffset, -FooterCellOffset);
end;

function TcxGridFooterCellViewInfo.CanPress: Boolean;
begin
  Result := False;
end;

function TcxGridFooterCellViewInfo.CustomDraw(ACanvas: TcxCanvas): Boolean;
begin
  Result := False;
  Column.DoCustomDrawFooterCell(ACanvas, Self, Result);
  if not Result then
    GridView.DoCustomDrawFooterCell(ACanvas, Self, Result);
end;

function TcxGridFooterCellViewInfo.GetAlignmentHorz: TAlignment;
begin
  Result := Column.FooterAlignmentHorz;
end;

function TcxGridFooterCellViewInfo.GetBackgroundBitmap: TBitmap;
begin   {4}
  Result := Container.BackgroundBitmap;
end;

procedure TcxGridFooterCellViewInfo.GetAreaViewInfoClasses(AProc: TcxGridClassEnumeratorProc);
begin
end;

function TcxGridFooterCellViewInfo.GetBorders: TcxBorders;
begin
  Result := cxBordersAll;
end;

class function TcxGridFooterCellViewInfo.GetCellBorderWidth(ALookAndFeelPainter: TcxCustomLookAndFeelPainterClass): Integer;
begin
  Result := ALookAndFeelPainter.FooterCellBorderSize;
end;

function TcxGridFooterCellViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridFooterCellHitTest;
end;

function TcxGridFooterCellViewInfo.GetIsPressed: Boolean;
begin
  Result := False;
end;

function TcxGridFooterCellViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridFooterCellPainter;
end;

function TcxGridFooterCellViewInfo.GetSummaryItemIndex: Integer;
begin
  Result := Summary.FooterSummaryItems.IndexOfItemLink(Column);
end;

function TcxGridFooterCellViewInfo.GetText: string;
begin               
  if SummaryItemIndex = -1 then
    Result := ''
  else
    Result := Summary.FooterSummaryTexts[SummaryItemIndex];
end;

procedure TcxGridFooterCellViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  Column.Styles.GetFooterParams(nil, AParams);
end;

function TcxGridFooterCellViewInfo.GetVisible: Boolean;
begin
  Result := SummaryItemIndex <> -1;
end;

function TcxGridFooterCellViewInfo.HasCustomDraw: Boolean;
begin
  Result := Column.HasCustomDrawFooterCell or GridView.HasCustomDrawFooterCell;
end;

function TcxGridFooterCellViewInfo.GetBestFitWidth: Integer;
begin
  Result := inherited GetBestFitWidth + 2 * LookAndFeelPainter.FooterCellOffset;
end;

{ TcxGridFooterViewInfo }

function TcxGridFooterViewInfo.CalculateBounds: TRect;
begin
  Result := inherited CalculateBounds;
  with GridViewInfo.HeaderViewInfo.CalculateBounds do
  begin
    Result.Left := Left;
    Result.Right := Right;
  end;
end;

function TcxGridFooterViewInfo.CalculateHeight: Integer;
begin
  CalculateParams;
  Result := BorderSize[bTop] + inherited CalculateHeight + BorderSize[bBottom];
  if HasSeparator then Inc(Result, SeparatorWidth);
end;

function TcxGridFooterViewInfo.CalculateItemHeight: Integer;
begin
  Result := inherited CalculateItemHeight + 2 * LookAndFeelPainter.FooterCellOffset;
end;

procedure TcxGridFooterViewInfo.CalculateItem(AIndex: Integer);
begin
  Items[AIndex].Calculate(GetItemLeftBound(AIndex), GetItemTopBound(AIndex),
    -1, GetItemHeight(AIndex));
end;

procedure TcxGridFooterViewInfo.CalculateItems;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    if IsItemVisible(I) then CalculateItem(I);
end;

function TcxGridFooterViewInfo.CanCalculateAutoWidths: Boolean;
begin
  Result := False;
end;

function TcxGridFooterViewInfo.GetAlignment: TcxGridPartAlignment;
begin
  Result := gpaBottom;
end;

function TcxGridFooterViewInfo.GetAutoHeight: Boolean;
begin
  Result := False;
end;

function TcxGridFooterViewInfo.GetBackgroundBitmap: TBitmap;
begin  {4}
  Result := GridView.BackgroundBitmaps.GetBitmap(bbFooter);
end;

function TcxGridFooterViewInfo.GetBordersBounds: TRect;
begin
  Result := Bounds;
  if HasSeparator then Inc(Result.Top, SeparatorWidth);
end;

function TcxGridFooterViewInfo.GetBorders: TcxBorders;
begin
  Result := LookAndFeelPainter.FooterBorders;
end;

function TcxGridFooterViewInfo.GetBorderWidth(AIndex: TcxBorder): Integer;
begin
  Result := LookAndFeelPainter.FooterBorderSize;
end;

function TcxGridFooterViewInfo.GetColumnWidth(AColumn: TcxGridColumn): Integer;
begin
  Result := GridViewInfo.HeaderViewInfo[AColumn.VisibleIndex].Width;
  if AColumn.IsMostLeft then
    Dec(Result, BorderSize[bLeft]);
  if AColumn.IsMostRight then
    Dec(Result, BorderSize[bRight]);
end;

function TcxGridFooterViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridFooterHitTest;
end;

function TcxGridFooterViewInfo.GetIsAutoWidth: Boolean;
begin
  Result := GridViewInfo.HeaderViewInfo.IsAutoWidth;
end;

function TcxGridFooterViewInfo.GetIsScrollable: Boolean;
begin
  Result := GridViewInfo.HeaderViewInfo.IsScrollable;
end;

function TcxGridFooterViewInfo.GetItemClass: TcxGridColumnHeaderViewInfoClass;
begin
  Result := TcxGridFooterCellViewInfo;
end;

function TcxGridFooterViewInfo.GetItemHeight(AIndex: Integer): Integer;
begin
  Result := GridViewInfo.GetCellHeight(AIndex, ItemHeight);
end;

function TcxGridFooterViewInfo.GetItemLeftBound(AIndex: Integer): Integer;
begin
  if Items[AIndex].Column.IsMostLeft then
    Result := ItemsAreaBounds.Left
  else
    Result := GridViewInfo.HeaderViewInfo[AIndex].RealBounds.Left;
end;

function TcxGridFooterViewInfo.GetItemsAreaBounds: TRect;
begin
  Result := BordersBounds;
  with Result do
  begin
    Inc(Left, BorderSize[bLeft]);
    Inc(Top, BorderSize[bTop]);
    Dec(Right, BorderSize[bRight]);
    Dec(Bottom, BorderSize[bBottom]);
  end;
end;

function TcxGridFooterViewInfo.GetItemTopBound(AIndex: Integer): Integer;
begin
  Result := ItemsAreaBounds.Top + GridViewInfo.GetCellTopOffset(AIndex, ItemHeight);
end;

function TcxGridFooterViewInfo.GetKind: TcxGridColumnContainerKind;
begin
  Result := ccFooter;
end;

function TcxGridFooterViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := GridViewInfo.GetFooterPainterClass;
end;

function TcxGridFooterViewInfo.GetSeparatorBounds: TRect;
begin
  Result := Bounds;
  Result.Bottom := Result.Top + SeparatorWidth;
end;

function TcxGridFooterViewInfo.GetSeparatorColor: TColor;
begin
  Result := GridViewInfo.GridLineColor;
end;

function TcxGridFooterViewInfo.GetSeparatorWidth: Integer;
begin
  Result := FooterSeparatorWidth;
end;

procedure TcxGridFooterViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  GridView.Styles.GetFooterParams(nil, nil, AParams);
end;

function TcxGridFooterViewInfo.GetVisible: Boolean;
begin
  Result := GridView.OptionsView.Footer;
end;

function TcxGridFooterViewInfo.HasSeparator: Boolean;
begin
  Result := True;
end;

function TcxGridFooterViewInfo.IsAlwaysVisibleForCalculation: Boolean;
begin
  Result := False;
end;

function TcxGridFooterViewInfo.IsHeightAssigned: Boolean;
begin
  Result := False;
end;

function TcxGridFooterViewInfo.IsItemVisible(AIndex: Integer): Boolean;
begin
  Result := GridViewInfo.HeaderViewInfo[AIndex].Visible;
end;

procedure TcxGridFooterViewInfo.Offset(DX, DY: Integer);
var
  I: Integer;
begin
  inherited;
  if DX <> 0 then
    for I := 0 to Count - 1 do
      if IsItemVisible(I) then
        if not Items[I].Calculated then
          CalculateItem(I)
        else
      else
        Items[I].Calculated := False;
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

function TcxCustomGridFilterButtonViewInfo.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
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

procedure TcxCustomGridFilterButtonViewInfo.StateChanged;
begin
  inherited;
  case State of
    gcsPressed:
      MouseCapture := True;
    gcsNone:
      MouseCapture := False;
  end;
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

{ TcxGridFilterCustomizeButtonViewInfo }

function TcxGridFilterCustomizeButtonViewInfo.CalculateHeight: Integer;
begin
  Result := BorderWidth[bTop] + BorderWidth[bBottom] + TextAreaHeight +
    2 * LookAndFeelPainter.ButtonTextOffset;
end;

function TcxGridFilterCustomizeButtonViewInfo.CalculateWidth: Integer;
begin
  Result := BorderWidth[bLeft] + BorderWidth[bRight] + TextAreaWidth +
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

function TcxGridFilterCustomizeButtonViewInfo.GetTextAreaBounds: TRect;
begin
  Result := inherited GetTextAreaBounds;
  if LookAndFeelPainter.ButtonSymbolState(GridCellStateToButtonState(State)) = cxbsPressed then
    OffsetRect(Result, 1, 1);
end;

procedure TcxGridFilterCustomizeButtonViewInfo.GetViewParams(var AParams: TcxViewParams);
var
  AState: TcxButtonState;
begin
  AState := GridCellStateToButtonState(State);
  with AParams do
  begin
    Color := LookAndFeelPainter.ButtonColor(AState);
    Font := Container.FilterViewInfo.Params.Font;
    TextColor := LookAndFeelPainter.ButtonSymbolColor(AState);
  end;
end;

function TcxGridFilterCustomizeButtonViewInfo.GetVisible: Boolean;
begin
  Result := GridView.Filtering.CustomizeDialog;
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

function TcxGridFilterButtonsViewInfo.GetGridView: TcxGridTableView;
begin
  Result := FFilterViewInfo.GridView;
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
  Result := FItems[Index];
end;

function TcxGridFilterButtonsViewInfo.GetWidth(AAlignment: TcxGridFilterButtonAlignment): Integer;
var
  I: Integer;
begin
  Result := 0;
  if Count <> 0 then
  begin
    for I := 0 to Count - 1 do
      with Items[I] do
        if Visible and (Alignment = AAlignment) then
          Inc(Result, CalculateWidth + FilterButtonsOffset);
    if Result <> 0 then
      Inc(Result, 2 * FilterButtonsFirstOffset - FilterButtonsOffset);
  end;
end;

function TcxGridFilterButtonsViewInfo.GetWidthLeftPart: Integer;
begin
  Result := GetWidth(fbaLeft);
end;

function TcxGridFilterButtonsViewInfo.GetWidthRightPart: Integer;
begin
  Result := GetWidth(fbaRight);
end;

procedure TcxGridFilterButtonsViewInfo.DestroyItems;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do Items[I].Free;
  FItems.Clear;
end;

procedure TcxGridFilterButtonsViewInfo.AddItems;
begin
  AddItem(TcxGridFilterCloseButtonViewInfo);
  AddItem(TcxGridFilterActivateButtonViewInfo);
  AddItem(TcxGridFilterCustomizeButtonViewInfo);
end;

procedure TcxGridFilterButtonsViewInfo.AddItem(AItemClass: TcxCustomGridFilterButtonViewInfoClass);
begin
  FItems.Add(AItemClass.Create(Self));
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
          ALeftMargin := Bounds.Right + FilterButtonsOffset
        else
          ARightMargin := Bounds.Left - FilterButtonsOffset;
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

constructor TcxGridFilterViewInfo.Create(AGridViewInfo: TcxGridTableViewInfo);
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

function TcxGridFilterViewInfo.GetFiltering: TcxGridTableFiltering;
begin
  Result := GridView.Filtering;
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
  Result := FilterTextOffset + TextAreaHeight + FilterTextOffset;
  AButtonsHeight := FButtonsViewInfo.Height;
  if Result < AButtonsHeight then Result := AButtonsHeight;
end;

function TcxGridFilterViewInfo.CalculateWidth: Integer;
begin
  Result := GridViewInfo.ClientWidth;
end;

function TcxGridFilterViewInfo.GetAlignment: TcxGridPartAlignment;
begin
  Result := gpaBottom;
end;

function TcxGridFilterViewInfo.GetAlignmentVert: TcxAlignmentVert;
begin
  Result := vaCenter;
end;

function TcxGridFilterViewInfo.GetBackgroundBitmap: TBitmap;
begin       {4}
  Result := GridView.BackgroundBitmaps.GetBitmap(bbFilterBox);
end;

function TcxGridFilterViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridFilterHitTest;
end;

function TcxGridFilterViewInfo.GetIsAutoWidth: Boolean;
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
  Result := (Filtering.Visible = fvAlways) or
    (Filtering.Visible = fvNonEmpty) and not Filter.IsEmpty;
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

{ TcxCustomGridIndicatorItemViewInfo }

constructor TcxCustomGridIndicatorItemViewInfo.Create(AContainer: TcxGridIndicatorViewInfo);
begin
  inherited Create(AContainer.GridViewInfo);
  FContainer := AContainer;
end;

destructor TcxCustomGridIndicatorItemViewInfo.Destroy;
begin
  FContainer.FItems.Remove(Self);
  inherited;
end;

function TcxCustomGridIndicatorItemViewInfo.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxCustomGridIndicatorItemViewInfo.GetGridViewInfo: TcxGridTableViewInfo;
begin
  Result := TcxGridTableViewInfo(inherited GridViewInfo);
end;

function TcxCustomGridIndicatorItemViewInfo.CalculateWidth: Integer;
begin
  Result := FContainer.Width;
end;

function TcxCustomGridIndicatorItemViewInfo.CustomDraw(ACanvas: TcxCanvas): Boolean;
begin
  Result := inherited CustomDraw(ACanvas);
  if not Result then
    GridView.DoCustomDrawIndicatorCell(ACanvas, Self, Result);
end;

function TcxCustomGridIndicatorItemViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridIndicatorHitTest;
end;

function TcxCustomGridIndicatorItemViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxCustomGridIndicatorItemPainter;
end;

procedure TcxCustomGridIndicatorItemViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  GridView.Styles.GetViewParams(vsIndicator, nil, nil, AParams);
end;

function TcxCustomGridIndicatorItemViewInfo.HasCustomDraw: Boolean;
begin
  Result := GridView.HasCustomDrawIndicatorCell;
end;

{ TcxGridIndicatorHeaderItemViewInfo }

function TcxGridIndicatorHeaderItemViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridIndicatorHeaderItemPainter;
end;

{ TcxGridIndicatorRowItemViewInfo }

destructor TcxGridIndicatorRowItemViewInfo.Destroy;
begin
  FRowViewInfo.FIndicatorItem := nil;
  inherited;
end;

function TcxGridIndicatorRowItemViewInfo.GetGridRecord: TcxCustomGridRow;
begin
  Result := FRowViewInfo.GridRecord;
end;

function TcxGridIndicatorRowItemViewInfo.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxGridIndicatorRowItemViewInfo.GetBackgroundBitmap: TBitmap;
begin  {4}
  Result := GridView.BackgroundBitmaps.GetBitmap(bbIndicator);
end;

function TcxGridIndicatorRowItemViewInfo.GetIndicatorKind: TcxIndicatorKind;
var
  ARecordSelected: Boolean;
begin
  if GridRecord.IsNewItemRow then
    Result := ikInsert
  else
    if GridRecord.IsEditing then
      if dceInsert in GridView.DataController.EditState then
        Result := ikInsert
      else
        Result := ikEdit
    else
    begin
      ARecordSelected := GridView.OptionsSelection.MultiSelect and GridRecord.Selected;
      if GridRecord.Focused then
        if ARecordSelected then
          Result := ikMultiArrow
        else
          Result := ikArrow
      else
        if ARecordSelected then
          Result := ikMultiDot
        else
          Result := ikNone;
    end;
end;

function TcxGridIndicatorRowItemViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridRowIndicatorHitTest;
end;

function TcxGridIndicatorRowItemViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridIndicatorRowItemPainter;
end;

function TcxGridIndicatorRowItemViewInfo.GetRowSizingEdgeBounds: TRect;
begin
  Result := Bounds;
  with Result do
  begin
    Top := Bottom - cxGridRowSizingEdgeSize div 2;
    Inc(Bottom, cxGridRowSizingEdgeSize div 2);
  end;  
end;

procedure TcxGridIndicatorRowItemViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  inherited;
  TcxGridRecordHitTest(AHitTest).GridRecord := GridRecord;
  if AHitTest is TcxGridRowIndicatorHitTest then
    AHitTest.ViewInfo := GridRecord.ViewInfo;
end;

function TcxGridIndicatorRowItemViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
begin
  if TcxCustomGridRowViewInfo(GridRecord.ViewInfo).CanSize and
    PtInRect(RowSizingEdgeBounds, P) then
  begin
    Result := TcxGridRowSizingEdgeHitTest.Instance(P);
    InitHitTest(Result);
  end
  else
    Result := inherited GetHitTest(P);
end;

function TcxGridIndicatorRowItemViewInfo.MouseDown(AHitTest: TcxCustomGridHitTest;
  AButton: TMouseButton; AShift: TShiftState): Boolean;
begin
  Result := inherited MouseDown(AHitTest, AButton, AShift);
  if (AButton = mbLeft) and (ssDouble in AShift) and
    (AHitTest.HitTestCode = htRowSizingEdge) then
    RowViewInfo.RowHeight := 0;
end;

{ TcxGridIndicatorFooterItemViewInfo }

function TcxGridIndicatorFooterItemViewInfo.GetSeparatorWidth: Integer;
begin
  Result := GridViewInfo.FooterViewInfo.SeparatorWidth;
end;

function TcxGridIndicatorFooterItemViewInfo.GetBackgroundBitmap: TBitmap;
begin  {4}
  Result := GridViewInfo.FooterViewInfo.BackgroundBitmap;
end;

function TcxGridIndicatorFooterItemViewInfo.GetBorders: TcxBorders;
begin
  Result := LookAndFeelPainter.FooterBorders;
end;

function TcxGridIndicatorFooterItemViewInfo.GetBordersBounds: TRect;
begin
  Result := Bounds;
  if HasSeparator then Inc(Result.Top, SeparatorWidth);
end;

function TcxGridIndicatorFooterItemViewInfo.GetBorderWidth(AIndex: TcxBorder): Integer;
begin
  Result := LookAndFeelPainter.FooterBorderSize;
  if (AIndex = bTop) and HasSeparator then Inc(Result, SeparatorWidth);
end;

function TcxGridIndicatorFooterItemViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridIndicatorFooterItemPainter;
end;

function TcxGridIndicatorFooterItemViewInfo.GetSeparatorBounds: TRect;
begin
  Result := Bounds;
  Result.Bottom := Result.Top + SeparatorWidth;
end;

function TcxGridIndicatorFooterItemViewInfo.HasSeparator: Boolean;
begin
  Result := GridViewInfo.FooterViewInfo.HasSeparator;
end;

{ TcxGridIndicatorViewInfo }

constructor TcxGridIndicatorViewInfo.Create(AGridViewInfo: TcxGridTableViewInfo);
begin
  inherited Create(AGridViewInfo);
  FItems := TList.Create;
end;

destructor TcxGridIndicatorViewInfo.Destroy;
begin
  DestroyItems;
  FItems.Free;
  inherited;
end;

function TcxGridIndicatorViewInfo.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxGridIndicatorViewInfo.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxGridIndicatorViewInfo.GetGridViewInfo: TcxGridTableViewInfo;
begin
  Result := TcxGridTableViewInfo(inherited GridViewInfo);
end;

function TcxGridIndicatorViewInfo.GetItem(Index: Integer): TcxCustomGridIndicatorItemViewInfo;
begin
  Result := FItems[Index];
end;

procedure TcxGridIndicatorViewInfo.DestroyItems;
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do Items[I].Free;
end;

function TcxGridIndicatorViewInfo.CalculateHeight: Integer;
begin
  with GridViewInfo do
    Result := HeaderViewInfo.Height + ClientHeight + FooterViewInfo.Height;
end;

function TcxGridIndicatorViewInfo.CalculateWidth: Integer;
begin
  if Visible then
    Result := GridView.OptionsView.IndicatorWidth
  else
    Result := 0;
end;

function TcxGridIndicatorViewInfo.GetBackgroundBitmap: TBitmap;
begin  {4}
  Result := GridViewInfo.BackgroundBitmap;
end;

function TcxGridIndicatorViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridIndicatorHitTest;
end;

function TcxGridIndicatorViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridIndicatorPainter;
end;

procedure TcxGridIndicatorViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  AParams.Color := GridViewInfo.BackgroundColor;
end;

function TcxGridIndicatorViewInfo.GetVisible: Boolean;
begin
  Result := GridView.OptionsView.Indicator;
end;

function TcxGridIndicatorViewInfo.GetWidth: Integer;
begin
  Result := CalculateWidth;
end;

function TcxGridIndicatorViewInfo.AddItem(AItemClass: TcxCustomGridIndicatorItemViewInfoClass): TcxCustomGridIndicatorItemViewInfo;
begin
  Result := AItemClass.Create(Self);
  FItems.Add(Result);
end;

function TcxGridIndicatorViewInfo.AddItem(ATopBound, AHeight: Integer;
  AItemClass: TcxCustomGridIndicatorItemViewInfoClass): TcxCustomGridIndicatorItemViewInfo;
begin
  Result := AddItem(AItemClass);
  Result.Calculate(Bounds.Left, ATopBound, Width, AHeight);
end;

function TcxGridIndicatorViewInfo.AddRowItem(ARowViewInfo: TcxCustomGridRowViewInfo): TcxCustomGridIndicatorItemViewInfo;
begin
  Result := AddItem(TcxGridIndicatorRowItemViewInfo);
  TcxGridIndicatorRowItemViewInfo(Result).RowViewInfo := ARowViewInfo;
end;

procedure TcxGridIndicatorViewInfo.Calculate(ALeftBound, ATopBound: Integer;
  AWidth: Integer = -1; AHeight: Integer = -1);
begin
  inherited;
  if GridViewInfo.HeaderViewInfo.Visible then
    AddItem(Bounds.Top, GridViewInfo.HeaderViewInfo.Height, TcxGridIndicatorHeaderItemViewInfo);
  if GridViewInfo.FooterViewInfo.Visible then
    AddItem(Bounds.Bottom - GridViewInfo.FooterViewInfo.Height,
      GridViewInfo.FooterViewInfo.Height, TcxGridIndicatorFooterItemViewInfo);
end;

procedure TcxGridIndicatorViewInfo.CalculateRowItem(ARowViewInfo: TcxCustomGridRowViewInfo;
  AItem: TcxCustomGridIndicatorItemViewInfo);
begin
  AItem.Calculate(Bounds.Left, ARowViewInfo.Bounds.Top, Width, ARowViewInfo.Height);
end;

function TcxGridIndicatorViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := Items[I].GetHitTest(P);
    if Result <> nil then Exit;
  end;
  Result := inherited GetHitTest(P);
end;

function TcxGridIndicatorViewInfo.GetRowItemBounds(AGridRecord: TcxCustomGridRow): TRect;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    if (Items[I] is TcxGridIndicatorRowItemViewInfo) and
      (TcxGridIndicatorRowItemViewInfo(Items[I]).GridRecord = AGridRecord) then
    begin
      Result := Items[I].Bounds;
      Exit;
    end;
  Result := Rect(0, 0, 0, 0);
end;

{ TcxGridRowFooterCellViewInfo }

function TcxGridRowFooterCellViewInfo.GetContainer: TcxGridRowFooterViewInfo;
begin
  Result := TcxGridRowFooterViewInfo(inherited Container);
end;

function TcxGridRowFooterCellViewInfo.GetGridRecord: TcxCustomGridRow;
begin
  Result := Container.GridRecord;
end;

function TcxGridRowFooterCellViewInfo.GetRowViewInfo: TcxCustomGridRowViewInfo;
begin
  Result := Container.RowViewInfo;
end;

function TcxGridRowFooterCellViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridGroupFooterCellHitTest;
end;

function TcxGridRowFooterCellViewInfo.GetSummaryItemIndex: Integer;
begin
  Result := Summary.GroupFooterIndexOfItemLink[Container.GroupLevel, Column];
end;

function TcxGridRowFooterCellViewInfo.GetText: string;
begin
  Result := Summary.GroupFooterSummaryTexts[GridRecord.Index, Container.GroupLevel,
    SummaryItemIndex];
end;

procedure TcxGridRowFooterCellViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  Column.Styles.GetFooterParams(GridRecord, AParams);
end;

{ TcxGridRowFooterViewInfo }

constructor TcxGridRowFooterViewInfo.Create(AContainer: TcxGridRowFootersViewInfo;
  ALevel: Integer);
begin
  inherited Create(AContainer.GridViewInfo);
  FContainer := AContainer;
  FLevel := ALevel;
end;

function TcxGridRowFooterViewInfo.GetIndent: Integer;
begin
  Result := GridViewInfo.LevelIndent * (FContainer.RowViewInfo.Level - FLevel);
end;

function TcxGridRowFooterViewInfo.GetGridRecord: TcxCustomGridRow;
begin
  Result := RowViewInfo.GridRecord;
end;

function TcxGridRowFooterViewInfo.GetGroupLevel: Integer;
begin
  Result := RowViewInfo.Level - FLevel;
  if GridView.OptionsView.GroupFooters = gfVisibleWhenExpanded then
    Dec(Result);
end;

function TcxGridRowFooterViewInfo.GetRowViewInfo: TcxCustomGridRowViewInfo;
begin
  Result := FContainer.RowViewInfo;
end;

function TcxGridRowFooterViewInfo.CalculateBounds: TRect;
begin
  Result := Bounds;
end;

function TcxGridRowFooterViewInfo.CalculateWidth: Integer;
begin
  Result := inherited CalculateWidth - Indent;
end;

function TcxGridRowFooterViewInfo.GetColumnWidth(AColumn: TcxGridColumn): Integer;
begin
  Result := inherited GetColumnWidth(AColumn);
  if AColumn.IsMostLeft then Dec(Result, Indent);
end;

function TcxGridRowFooterViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridGroupFooterHitTest;
end;

function TcxGridRowFooterViewInfo.GetIsPart: Boolean;
begin
  Result := False;
end;

function TcxGridRowFooterViewInfo.GetItemClass: TcxGridColumnHeaderViewInfoClass;
begin
  Result := TcxGridRowFooterCellViewInfo;
end;

procedure TcxGridRowFooterViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  GridView.Styles.GetFooterParams(GridRecord, nil, AParams);
end;

function TcxGridRowFooterViewInfo.GetVisible: Boolean;
begin
  Result := True;
end;

function TcxGridRowFooterViewInfo.HasSeparator: Boolean;
begin
  Result := False;
end;

{ TcxGridRowFootersViewInfo }

constructor TcxGridRowFootersViewInfo.Create(ARowViewInfo: TcxCustomGridRowViewInfo);
begin
  inherited Create;
  FRowViewInfo := ARowViewInfo;
  FHeight := -1;
  CreateItems;
end;

destructor TcxGridRowFootersViewInfo.Destroy;
begin
  DestroyItems;
  inherited;
end;

function TcxGridRowFootersViewInfo.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxGridRowFootersViewInfo.GetGridViewInfo: TcxGridTableViewInfo;
begin
  Result := FRowViewInfo.GridViewInfo;
end;

function TcxGridRowFootersViewInfo.GetHeight: Integer;
begin
  if FHeight = -1 then
    FHeight := CalculateHeight;
  Result := FHeight;  
end;

function TcxGridRowFootersViewInfo.GetItem(Index: Integer): TcxGridRowFooterViewInfo;
begin
  Result := FItems[Index];
end;

function TcxGridRowFootersViewInfo.GetVisibleItem(Index: Integer): TcxGridRowFooterViewInfo;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := Items[I];
    if Result.Level = Index then Exit;
  end;
  Result := nil;  
end;

procedure TcxGridRowFootersViewInfo.CreateItems;
var
  I: Integer;
begin
  FItems := TList.Create;
  for I := 0 to FRowViewInfo.Level do
    if FRowViewInfo.HasFooter(I) then
      FItems.Add(GetItemClass.Create(Self, I));
end;

procedure TcxGridRowFootersViewInfo.DestroyItems;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do Items[I].Free;
  FItems.Free;
end;

procedure TcxGridRowFootersViewInfo.BeforeRecalculation;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].BeforeRecalculation;
end;

procedure TcxGridRowFootersViewInfo.Calculate(ALeftBound, ATopBound: Integer);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Items[I].Calculate(ALeftBound - Items[I].Level * GridViewInfo.LevelIndent, ATopBound);
    Inc(ATopBound, Items[I].Height);
  end;
end;

function TcxGridRowFootersViewInfo.CalculateHeight: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    Inc(Result, Items[I].CalculateHeight);
end;

function TcxGridRowFootersViewInfo.GetItemClass: TcxGridRowFooterViewInfoClass;
begin
  Result := TcxGridRowFooterViewInfo;
end;

function TcxGridRowFootersViewInfo.GetCellBestFitWidth(ACellIndex: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    Result := Max(Result, Items[I][ACellIndex].GetBestFitWidth);
end;

function TcxGridRowFootersViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
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

procedure TcxGridRowFootersViewInfo.Offset(DX, DY: Integer);
var
  I: Integer;
begin       {2}
  for I := 0 to Count - 1 do
    Items[I].DoOffset(DX, DY);
end;

procedure TcxGridRowFootersViewInfo.Paint;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do Items[I].Paint;
end;

{ TcxCustomGridRowViewInfo }

constructor TcxCustomGridRowViewInfo.Create(ARecordsViewInfo: TcxCustomGridRecordsViewInfo;
  ARecord: TcxCustomGridRecord);
begin
  inherited;
  FIndicatorItem := GridViewInfo.IndicatorViewInfo.AddRowItem(Self);
  CreateFootersViewInfo;
end;

destructor TcxCustomGridRowViewInfo.Destroy;
begin
  DestroyFootersViewInfo;
  FIndicatorItem.Free;
  inherited;
end;

function TcxCustomGridRowViewInfo.GetCacheItem: TcxGridTableViewInfoCacheItem;
begin
  Result := TcxGridTableViewInfoCacheItem(inherited CacheItem);
end;

function TcxCustomGridRowViewInfo.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxCustomGridRowViewInfo.GetGridLines: TcxGridLines;
begin
  Result := RecordsViewInfo.GridLines;
end;

function TcxCustomGridRowViewInfo.GetGridRecord: TcxCustomGridRow;
begin
  Result := TcxCustomGridRow(inherited GridRecord);
end;

function TcxCustomGridRowViewInfo.GetGridViewInfo: TcxGridTableViewInfo;
begin
  Result := TcxGridTableViewInfo(inherited GridViewInfo);
end;

function TcxCustomGridRowViewInfo.GetHasSeparator: Boolean;
begin
  Result := SeparatorWidth <> 0;
end;

function TcxCustomGridRowViewInfo.GetLevel: Integer;
begin
  Result := GridRecord.Level;
end;

function TcxCustomGridRowViewInfo.GetLevelIndent: Integer;
begin
  Result := Level * GridViewInfo.LevelIndent;
end;

function TcxCustomGridRowViewInfo.GetLevelIndentBounds(Index: Integer): TRect;
begin
  Result := Bounds;
  if Index = -1 then
    Result.Right := ContentIndent
  else
  begin
    Inc(Result.Left, GridViewInfo.LevelIndent * Index);
    Result.Right := Result.Left + GridViewInfo.LevelIndent;
    if HasFooter(Level - Index) then
      Result.Bottom := FFootersViewInfo.VisibleItems[Level - Index].Bounds.Top;
  end;
end;

function TcxCustomGridRowViewInfo.GetLevelIndentHorzLineBounds(Index: Integer): TRect;
begin
  Result := CalculateLevelIndentHorzLineBounds(Index, LevelIndentBounds[Index]);
end;

function TcxCustomGridRowViewInfo.GetLevelIndentSpaceBounds(Index: Integer): TRect;
begin
  Result := CalculateLevelIndentSpaceBounds(Index, LevelIndentBounds[Index]);
end;

function TcxCustomGridRowViewInfo.GetLevelIndentVertLineBounds(Index: Integer): TRect;
begin
  Result := CalculateLevelIndentVertLineBounds(Index, LevelIndentBounds[Index]);
end;

function TcxCustomGridRowViewInfo.GetRecordsViewInfo: TcxGridRowsViewInfo;
begin
  Result := TcxGridRowsViewInfo(inherited RecordsViewInfo);
end;

function TcxCustomGridRowViewInfo.GetSeparatorWidth: Integer;
begin
  if ShowSeparator then
    Result := RecordsViewInfo.SeparatorWidth
  else
    Result := 0;
end;

procedure TcxCustomGridRowViewInfo.CreateFootersViewInfo;
begin
  FFootersViewInfo := GetFootersViewInfoClass.Create(Self);
end;

procedure TcxCustomGridRowViewInfo.DestroyFootersViewInfo;
begin
  FFootersViewInfo.Free;
end;

procedure TcxCustomGridRowViewInfo.RecreateFootersViewInfo;
begin
  DestroyFootersViewInfo;
  CreateFootersViewInfo;
end;

function TcxCustomGridRowViewInfo.CalculateHeight: Integer;
begin
  Result := BottomPartHeight;
end;

function TcxCustomGridRowViewInfo.CalculateLevelIndentHorzLineBounds(ALevel: Integer;
  const ABounds: TRect): TRect;
begin
  Result := ABounds;
  with Result do
  begin
    Top := CalculateLevelIndentSpaceBounds(ALevel, ABounds).Bottom;
    Bottom := Top + GridViewInfo.GridLineWidth;
    if Bottom > ABounds.Bottom then Bottom := ABounds.Bottom;
  end;  
end;

function TcxCustomGridRowViewInfo.CalculateLevelIndentSpaceBounds(ALevel: Integer;
  const ABounds: TRect): TRect;
var
  AIsParentRecordLast: Boolean;
begin
  AIsParentRecordLast := GridRecord.IsParentRecordLast[Level - ALevel - 1];
  Result := ABounds;
  if GridLines in [glBoth, glHorizontal] then
    Dec(Result.Right, GridViewInfo.GridLineWidth);
  if (GridLines <> glNone) and ((GridLines <> glVertical) and AIsParentRecordLast) then
    Dec(Result.Bottom, GridViewInfo.GridLineWidth);
  if AIsParentRecordLast and not HasFooter(Level - ALevel) then
    Dec(Result.Bottom, SeparatorWidth);
end;

function TcxCustomGridRowViewInfo.CalculateLevelIndentVertLineBounds(ALevel: Integer;
  const ABounds: TRect): TRect;
begin
  Result := ABounds;
  with CalculateLevelIndentSpaceBounds(ALevel, ABounds) do
  begin
    Result.Left := Right;
    Result.Bottom := Bottom;
  end;
end;

function TcxCustomGridRowViewInfo.CalculateWidth: Integer;
begin
  Result := 0{Width};
end;

function TcxCustomGridRowViewInfo.CanSize: Boolean;
begin
  Result := False;
end;

function TcxCustomGridRowViewInfo.GetAutoHeight: Boolean;
begin
  Result := RecordsViewInfo.AutoRecordHeight;
end;

function TcxCustomGridRowViewInfo.GetBaseHeight: Integer;
begin
  Result := DataHeight;
end;

function TcxCustomGridRowViewInfo.GetBottomPartHeight: Integer;
begin
  Result := FFootersViewInfo.Height + SeparatorWidth;
  if HasLastHorzGridLine then
    Inc(Result, GridViewInfo.GridLineWidth);
end;

function TcxCustomGridRowViewInfo.GetCellTransparent(ACell: TcxGridTableCellViewInfo): Boolean;
begin  {4}
  Result := inherited GetCellTransparent(ACell) and not ACell.Selected;
end;

function TcxCustomGridRowViewInfo.GetContentBounds: TRect;
begin
  Result := inherited GetContentBounds;
  Result.Left := ContentIndent;
  Result.Bottom := Result.Top + DataHeight;
end;

function TcxCustomGridRowViewInfo.GetContentIndent: Integer;
begin
  Result := Bounds.Left + LevelIndent;
end;

function TcxCustomGridRowViewInfo.GetContentWidth: Integer;
begin
  Result := Width - LevelIndent;
end;

function TcxCustomGridRowViewInfo.GetDataHeight: Integer;
begin
  Result := Height - BottomPartHeight;
end;

function TcxCustomGridRowViewInfo.GetDataIndent: Integer;
begin
  Result := ContentIndent;
end;

function TcxCustomGridRowViewInfo.GetDataWidth: Integer;
begin
  Result := ContentWidth;
end;

function TcxCustomGridRowViewInfo.GetFocusRectBounds: TRect;
begin
  Result := inherited GetFocusRectBounds;
  Result.Left := DataIndent;
  if GridLines <> glNone then
    Dec(Result.Right, GridViewInfo.GridLineWidth);
  Result.Bottom := Result.Top + DataHeight;
  if GridLines in [glBoth, glHorizontal] then
    Dec(Result.Bottom, GridViewInfo.GridLineWidth);
end;

function TcxCustomGridRowViewInfo.GetFootersViewInfoClass: TcxGridRowFootersViewInfoClass;
begin
  Result := TcxGridRowFootersViewInfo;
end;

function TcxCustomGridRowViewInfo.GetLastHorzGridLineBounds: TRect;
begin
  Result := Bounds;
  Result.Top := Result.Bottom - GridViewInfo.GridLineWidth;
end;

function TcxCustomGridRowViewInfo.GetMaxHeight: Integer;
begin
  Result := Height;
end;

function TcxCustomGridRowViewInfo.GetNonBaseHeight: Integer;
begin
  Result := Height - BaseHeight;
end;

function TcxCustomGridRowViewInfo.GetRowHeight: Integer;
begin
  Result := Height;
end;

function TcxCustomGridRowViewInfo.GetSeparatorBounds: TRect;
var
  I: Integer;
begin
  with Result do
  begin
    Left := ContentIndent;
    Right := Left + ContentWidth;
    for I := 0 to Level - 1 do
      if GridRecord.IsParentRecordLast[I] then
        Dec(Left, GridViewInfo.LevelIndent)
      else
        Break;
    Bottom := Bounds.Bottom;
    Top := Bottom - SeparatorWidth;
  end;
end;
            
function TcxCustomGridRowViewInfo.GetSeparatorColor: TColor;
begin
  Result := GridView.OptionsView.GetRowSeparatorColor;
end;

function TcxCustomGridRowViewInfo.GetShowSeparator: Boolean;
begin
  Result := True;
end;

function TcxCustomGridRowViewInfo.GetVisible: Boolean;
begin
  Result := Index < RecordsViewInfo.PartVisibleCount;
end;

function TcxCustomGridRowViewInfo.GetWidth: Integer;
begin
  Result := RecordsViewInfo.RowWidth;
end;

function TcxCustomGridRowViewInfo.HasFooter(ALevel: Integer): Boolean;
begin
  if GridView.OptionsView.GroupFooters = gfInvisible then
    Result := False
  else
  begin
    if GridView.OptionsView.GroupFooters = gfAlwaysVisible then
      Dec(ALevel);
    Result := (0 <= ALevel) and (ALevel < Level) and
      GridRecord.IsParentRecordLast[ALevel];
  end;
{  Result :=
    (GridView.OptionsView.GroupFooters = gfVisibleWhenExpanded) and
    ((ALevel <> Level) and GridRecord.IsParentRecordLast[ALevel]) or
    (GridView.OptionsView.GroupFooters = gfAlwaysVisible) and
    (ALevel <> 0) and GridRecord.IsParentRecordLast[ALevel - 1];}
end;

function TcxCustomGridRowViewInfo.HasLastHorzGridLine: Boolean;
begin
  Result := RecordsViewInfo.HasLastHorzGridLine(Self) and GridRecord.IsLast;
end;

procedure TcxCustomGridRowViewInfo.Offset(DX, DY: Integer);
begin   {2}
  inherited;
  FIndicatorItem.DoOffset(0, DY);
  FFootersViewInfo.Offset(DX, DY);
end;

procedure TcxCustomGridRowViewInfo.BeforeRecalculation;
begin
  inherited;
  FFootersViewInfo.BeforeRecalculation;
end;

procedure TcxCustomGridRowViewInfo.Calculate(ALeftBound, ATopBound: Integer;
  AWidth: Integer = -1; AHeight: Integer = -1);
begin
  RecreateFootersViewInfo;
  inherited;
  GridViewInfo.IndicatorViewInfo.CalculateRowItem(Self, FIndicatorItem);
  FFootersViewInfo.Calculate(ContentIndent, ATopBound + Height - BottomPartHeight);
end;

function TcxCustomGridRowViewInfo.Click(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
  AShift: TShiftState): Boolean;
var
  AGridRecord: TcxCustomGridRow;
begin
  AGridRecord := GridRecord;
  Result := inherited Click(AHitTest, AButton, AShift);
  if Result and (ssDouble in AShift) and AGridRecord.ExpandOnDblClick then
    with AGridRecord do
      Expanded := not Expanded;
end;

function TcxCustomGridRowViewInfo.GetBoundsForInvalidate(AItem: TcxCustomGridTableItem): TRect;
var
  R: TRect;
begin
  Result := inherited GetBoundsForInvalidate(AItem);
  if AItem = nil then
    with GridViewInfo.IndicatorViewInfo do
      if Visible then
      begin
        R := GetRowItemBounds(GridRecord);
        if R.Left < Result.Left then Result.Left := R.Left;
      end;
end;

function TcxCustomGridRowViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
begin
  Result := FFootersViewInfo.GetHitTest(P);
  if Result = nil then
  begin
    Result := inherited GetHitTest(P);
    if (Result <> nil) and PtInRect(LevelIndentBounds[-1], P) then
    begin
      Result := TcxGridRowLevelIndentHitTest.Instance(P);
      InitHitTest(Result);
    end;
  end;
end;

{ TcxGridRowsViewInfo }

destructor TcxGridRowsViewInfo.Destroy;
begin
  FNewItemRowViewInfo.Free;
  inherited;
end;

function TcxGridRowsViewInfo.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxGridRowsViewInfo.GetGridLines: TcxGridLines;
begin
  Result := GridViewInfo.GridLines;
end;

function TcxGridRowsViewInfo.GetGridViewInfo: TcxGridTableViewInfo;
begin
  Result := TcxGridTableViewInfo(inherited GridViewInfo);
end;

function TcxGridRowsViewInfo.GetHasNewItemRecord: Boolean;
begin
  Result := NewItemRowViewInfo <> nil;
end;

function TcxGridRowsViewInfo.GetHeaderViewInfo: TcxGridHeaderViewInfo;
begin
  Result := GridViewInfo.HeaderViewInfo;
end;

function TcxGridRowsViewInfo.GetItem(Index: Integer): TcxCustomGridRowViewInfo;
begin
  Result := TcxCustomGridRowViewInfo(inherited Items[Index]);
end;

function TcxGridRowsViewInfo.GetNewItemRowViewInfo: TcxCustomGridRowViewInfo;
begin
  Result := FNewItemRowViewInfo;
  if (Result <> nil) and (Result.GridRecord = nil) then
    Result := nil;
end;

function TcxGridRowsViewInfo.GetPainterClassValue: TcxGridRowsPainterClass;
begin
  Result := TcxGridRowsPainterClass(GetPainterClass);
end;

function TcxGridRowsViewInfo.GetViewData: TcxGridViewData;
begin
  Result := TcxGridViewData(inherited ViewData);
end;

procedure TcxGridRowsViewInfo.Calculate;

  procedure CalculateItems;
  var
    I: Integer;
  begin
    for I := 0 to FPartVisibleCount - 1 do
      Items[I].MainCalculate(GetItemLeftBound(I), GetItemTopBound(I));
  end;

begin
  CalculateConsts;
  inherited;
  FContentBounds := CalculateContentBounds;
  if GridViewInfo.CalculateDown and HasNewItemRecord then
    FNewItemRowViewInfo.MainCalculate(ContentBounds.Left, Bounds.Top);
  CalculateVisibleCount;  {2}
  if GridViewInfo.CalculateDown and (FirstRecordIndex <> -1) then CalculateItems;
end;

function TcxGridRowsViewInfo.CalculateBounds: TRect;
begin
  Result := inherited CalculateBounds;
  if IsScrollable then
    Dec(Result.Left, GridViewInfo.LeftPos);
  Result.Right := Result.Left + RowWidth;
end;

procedure TcxGridRowsViewInfo.CalculateConsts;
begin
  FRowHeight := CalculateRowHeight;
  FDataRowHeight := CalculateDataRowHeight;
  FGroupRowHeight := CalculateGroupRowHeight;
end;

function TcxGridRowsViewInfo.CalculateContentBounds: TRect;
begin
  Result := Bounds;
  if HasNewItemRecord then
    Inc(Result.Top, FNewItemRowViewInfo.Height);
end;

function TcxGridRowsViewInfo.CalculateDataRowHeight: Integer;
begin
  Result := FRowHeight;
end;

function TcxGridRowsViewInfo.CalculateGroupRowHeight: Integer;
var
  AParams: TcxViewParams;
begin
  Result := GridView.OptionsView.GroupRowHeight;
  if Result = 0 then
  begin
    GridView.Styles.GetGroupParams(nil, 0, AParams);
    Result := CalculateCustomGroupRowHeight(AParams);
  end;  
end;

function TcxGridRowsViewInfo.CalculateRestHeight(ATopBound: Integer): Integer;
begin
  Result := ContentBounds.Bottom - ATopBound;
  {if not GridViewInfo.IsCalculating or GridViewInfo.CalculateDown then
    Result := ContentBounds.Bottom - ATopBound
  else
    Result := MaxInt - 100000;}
end;

function TcxGridRowsViewInfo.CalculateRowHeight: Integer;
var
  I, AFontHeight: Integer;
  AParams: TcxViewParams;
begin
  if IsDataRowHeightAssigned then
    Result := GridView.OptionsView.DataRowHeight
  else
  begin
    if GridView.VisibleColumnCount = 0 then
    begin
      GridView.Styles.GetContentParams(nil, nil, AParams);
      Result := GridViewInfo.GetFontHeight(AParams.Font);
      GetCellTextAreaSize(Result);
    end
    else
    begin
      Result := 0;
      for I := 0 to HeaderViewInfo.Count - 1 do
      begin
        GridView.Styles.GetDataCellParams(nil, HeaderViewInfo[I].Column, AParams);
        AFontHeight := HeaderViewInfo[I].Column.CalculateDefaultCellHeight(Canvas, AParams.Font);
        if AFontHeight > Result then Result := AFontHeight;
      end;
    end;
    Result := GetCellHeight(Result);
  end;  
end;

procedure TcxGridRowsViewInfo.CalculateVisibleCount;
var
  ALastBottom, I, AHeight: Integer;
begin  {2}
  inherited;
  FPartVisibleCount := 0;
  if FirstRecordIndex = -1 then Exit;
  ALastBottom := ContentBounds.Top;
  for I := 0 to MaxCount - 1 do
  begin
    Inc(FPartVisibleCount);
    FRestHeight := CalculateRestHeight(ALastBottom);
    AHeight := Items[I].MaxHeight;
    Inc(ALastBottom, AHeight);
    if ALastBottom > ContentBounds.Bottom then Break;
    Inc(FVisibleCount);
    if ALastBottom = ContentBounds.Bottom then Break;
  end;
  if (FVisibleCount = 0) and (MaxCount > 0) then
    FVisibleCount := 1;
end;

function TcxGridRowsViewInfo.GetAutoDataRecordHeight: Boolean;
begin
  Result := inherited GetAutoDataRecordHeight and not IsDataRowHeightAssigned;
end;

function TcxGridRowsViewInfo.GetCommonDataRowHeight: Integer;
begin
  Result := FDataRowHeight + SeparatorWidth;
end;

function TcxGridRowsViewInfo.GetGroupBackgroundBitmap: TBitmap;
begin
  Result := GridView.BackgroundBitmaps.GetBitmap(bbGroup);
end;

function TcxGridRowsViewInfo.GetItemLeftBound(AIndex: Integer): Integer;
begin   {2}
  Result := ContentBounds.Left;
end;

function TcxGridRowsViewInfo.GetItemsOffset(AItemCountDelta: Integer): Integer;
var
  I: Integer;
begin   {2}
  Result := 0;
  for I := 0 to Abs(AItemCountDelta) - 1 do
    Inc(Result, Items[I].Height);
  if AItemCountDelta > 0 then
    Result := -Result;
end;

function TcxGridRowsViewInfo.GetItemTopBound(AIndex: Integer): Integer;
begin      {2}
  if AIndex = 0 then
    Result := ContentBounds.Top
  else
    Result := Items[AIndex - 1].Bounds.Bottom;
end;

function TcxGridRowsViewInfo.GetIsScrollable: Boolean;
begin
  Result := HeaderViewInfo.IsScrollable;
end;

function TcxGridRowsViewInfo.GetNewItemRowViewInfoClass: TcxCustomGridRowViewInfoClass;
begin
  Result := TcxGridNewItemRowViewInfo;
end;

function TcxGridRowsViewInfo.GetPainterClass: TcxCustomGridRecordsPainterClass;
begin
  Result := TcxGridRowsPainter;
end;

function TcxGridRowsViewInfo.GetRowWidth: Integer;
begin
  Result := GridViewInfo.DataWidth;
end;

function TcxGridRowsViewInfo.GetSeparatorWidth: Integer;
begin
  Result := GridView.OptionsView.RowSeparatorWidth;
end;

function TcxGridRowsViewInfo.GetShowNewItemRow: Boolean;
begin
  Result := GridView.OptionsView.NewItemRow;
end;

function TcxGridRowsViewInfo.HasLastHorzGridLine(ARowViewInfo: TcxCustomGridRowViewInfo): Boolean;
begin
  Result := (GridLines = glVertical) and
    ((ARowViewInfo = nil) and (SeparatorWidth = 0) or
     (ARowViewInfo <> nil) and not ARowViewInfo.HasSeparator);
end;

procedure TcxGridRowsViewInfo.OffsetItem(AIndex, AOffset: Integer);
begin   {2} 
  Items[AIndex].DoOffset(0, AOffset);
end;

procedure TcxGridRowsViewInfo.AfterConstruction;
begin
  inherited;
  if ShowNewItemRow then
    FNewItemRowViewInfo := GetNewItemRowViewInfoClass.Create(Self, ViewData.NewItemRow);
end;

function TcxGridRowsViewInfo.CalculateCustomGroupRowHeight(AParams: TcxViewParams): Integer;
begin
  Result := GridViewInfo.GetFontHeight(AParams.Font);
  if Result < GridViewInfo.ExpandButtonSize then
    Result := GridViewInfo.ExpandButtonSize;
  GetCellTextAreaSize(Result);
  Result := GetCellHeight(Result);
  {if GridLines in [glBoth, glHorizontal] then
    Inc(Result, GridViewInfo.GridLineWidth);}
end;

function TcxGridRowsViewInfo.CanDataRowSize: Boolean;
begin
  Result := GridView.OptionsCustomize.DataRowSizing;
end;

function TcxGridRowsViewInfo.GetCellHeight(ACellContentHeight: Integer): Integer;
begin
  Result := inherited GetCellHeight(ACellContentHeight);
  if GridLines in [glBoth, glHorizontal] then
    Inc(Result, GridViewInfo.GridLineWidth);
end;

function TcxGridRowsViewInfo.GetDataRowCellsAreaViewInfoClass: TClass;
begin
  Result := TcxGridDataRowCellsAreaViewInfo;
end;

function TcxGridRowsViewInfo.GetFooterCellBestFitWidth(ACellIndex: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    Result := Max(Result, Items[I].FootersViewInfo.GetCellBestFitWidth(ACellIndex));
end;

function TcxGridRowsViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
begin
  Result := inherited GetHitTest(P);
  if (Result = nil) and HasNewItemRecord then
    Result := FNewItemRowViewInfo.GetHitTest(P);
end;

function TcxGridRowsViewInfo.GetRealItem(ARecord: TcxCustomGridRecord;
  ARecordIndex: Integer): TcxCustomGridRecordViewInfo;
begin
  if (ARecordIndex = -1) and (ARecord <> nil) and
    ViewData.HasNewItemRecord and ARecord.IsNewItemRecord then
    Result := NewItemRowViewInfo
  else
    Result := inherited GetRealItem(ARecord, ARecordIndex);
end;

function TcxGridRowsViewInfo.GetRestHeight(ATopBound: Integer): Integer;
begin
  if GridViewInfo.IsCalculating then
    Result := FRestHeight
  else
    Result := CalculateRestHeight(ATopBound);
end;

function TcxGridRowsViewInfo.IsDataRowHeightAssigned: Boolean;
begin
  Result := GridView.OptionsView.DataRowHeight <> 0;
end;

procedure TcxGridRowsViewInfo.Offset(DX, DY: Integer);
var
  I: Integer;
begin                               {2}
  inherited;
  OffsetRect(FContentBounds, DX, 0);
  if HasNewItemRecord then
    FNewItemRowViewInfo.DoOffset(DX, 0);
  for I := 0 to Count - 1 do
    Items[I].DoOffset(DX, 0);
end;

{ TcxGridTableViewInfo }

constructor TcxGridTableViewInfo.Create(AGridView: TcxCustomGridView);
begin
  FParts := TList.Create;
  inherited;
end;

destructor TcxGridTableViewInfo.Destroy;
begin
  FParts.Free;
  inherited;
end;

function TcxGridTableViewInfo.GetController: TcxGridTableController;
begin
  Result := TcxGridTableController(inherited Controller);
end;

function TcxGridTableViewInfo.GetDataWidth: Integer;
begin
  if FDataWidth = 0 then
    FDataWidth := CalculateDataWidth;
  Result := FDataWidth;
end;

function TcxGridTableViewInfo.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxGridTableViewInfo.GetGridLineColor: TColor;
begin
  Result := GridView.OptionsView.GetGridLineColor;
end;

function TcxGridTableViewInfo.GetGridLines: TcxGridLines;
begin
  Result := GridView.OptionsView.GridLines;
end;

function TcxGridTableViewInfo.GetLeftPos: Integer;
begin
  Result := Controller.LeftPos;
end;

function TcxGridTableViewInfo.GetLevelIndentBackgroundBitmap: TBitmap;
begin   {4}
  Result := RecordsViewInfo.GroupBackgroundBitmap;
end;

function TcxGridTableViewInfo.GetLevelIndentColor(Index: Integer): TColor;
var
  AParams: TcxViewParams;
begin
  GridView.Styles.GetGroupParams(nil, Index, AParams);
  Result := AParams.Color;
end;

function TcxGridTableViewInfo.GetPart(Index: Integer): TcxCustomGridPartViewInfo;
begin
  Result := FParts[Index];
end;

function TcxGridTableViewInfo.GetPartCount: Integer;
begin
  Result := FParts.Count;
end;

function TcxGridTableViewInfo.GetPartsBottomHeight: Integer;
begin
  Result := GetPartsCustomHeight(gpaBottom);
end;

function TcxGridTableViewInfo.GetPartsCustomHeight(AAlignment: TcxGridPartAlignment): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to PartCount - 1 do
    with Parts[I] do
      if Alignment = AAlignment then Inc(Result, Height);
end;

function TcxGridTableViewInfo.GetPartsTopHeight: Integer;
begin
  Result := GetPartsCustomHeight(gpaTop);
end;

function TcxGridTableViewInfo.GetRecordsViewInfo: TcxGridRowsViewInfo;
begin
  Result := TcxGridRowsViewInfo(inherited RecordsViewInfo);
end;

function TcxGridTableViewInfo.GetViewData: TcxGridViewData;
begin
  Result := TcxGridViewData(inherited ViewData);
end;

procedure TcxGridTableViewInfo.AddPart(AItem: TcxCustomGridPartViewInfo);
begin
  FParts.Add(AItem);
end;

procedure TcxGridTableViewInfo.RemovePart(AItem: TcxCustomGridPartViewInfo);
begin
  FParts.Remove(AItem);
end;

procedure TcxGridTableViewInfo.AfterCalculating;
begin
  inherited;
  if not IsInternalUse and not SizeCalculating and (RecordsViewInfo.DataRowHeight <> FPrevDataRowHeight) then
    Controller.PostGridModeBufferCountUpdate;
end;

procedure TcxGridTableViewInfo.BeforeCalculating;
begin
  inherited;
  if not IsInternalUse and not SizeCalculating then
    FPrevDataRowHeight := RecordsViewInfo.DataRowHeight;
end;

procedure TcxGridTableViewInfo.CreateViewInfos;
begin
//  inherited; - because of new item row view info in banded view
  FGroupByBoxViewInfo := GetGroupByBoxViewInfoClass.Create(Self);
  FHeaderViewInfo := GetHeaderViewInfoClass.Create(Self);
  FFilterViewInfo := GetFilterViewInfoClass.Create(Self);
  FFooterViewInfo := GetFooterViewInfoClass.Create(Self);
  FIndicatorViewInfo := GetIndicatorViewInfoClass.Create(Self);
  inherited;
end;

procedure TcxGridTableViewInfo.DestroyViewInfos(AIsRecreating: Boolean);
begin
  inherited;
  FreeAndNil(FIndicatorViewInfo);
  FreeAndNil(FFooterViewInfo);
  FreeAndNil(FHeaderViewInfo);
  FreeAndNil(FGroupByBoxViewInfo);
  FreeAndNil(FFilterViewInfo);
//  inherited;
end;

{var
  max: integer;}

procedure TcxGridTableViewInfo.Calculate;
(*var
  ft,lt{,i}: Integer;*)
begin
  //ft := gettickcount;

//for I := 1 to 10 do

  try
    RecreateViewInfos;
    GroupByBoxViewInfo.MainCalculate;
    HeaderViewInfo.MainCalculate;
    FilterViewInfo.MainCalculate;
    FooterViewInfo.MainCalculate;
    ClientBounds := CalculateClientBounds;
    IndicatorViewInfo.Calculate(Bounds.Left, ClientBounds.Top - HeaderViewInfo.Height);
  finally
    inherited;
  end;

(*if CalculateDown then
begin
  lt := gettickcount;
  //if lt - ft > max then max := lt - ft;
  //if TcxGridLevel(GridView.Level).IsTop then
  application.MainForm.Caption :=
  //inttostr(max);
  inttostr(lt - ft);
end;*)
end;

function TcxGridTableViewInfo.CalculateClientBounds: TRect;
begin
  Result := inherited CalculateClientBounds;
  Inc(Result.Left, IndicatorViewInfo.Width);
  Inc(Result.Top, PartsTopHeight);
  Dec(Result.Bottom, PartsBottomHeight);
end;

procedure TcxGridTableViewInfo.CalculateHeight(const AMaxSize: TPoint;
  var AHeight: Integer; var AFullyVisible: Boolean);
begin
  MainCalculate(Classes.Bounds(cxGridInvisibleCoordinate, 0, AMaxSize.X, AMaxSize.Y));
  if VisibleRecordCount = 0 then
    AHeight := GetNonRowsAreaHeight(False) + RecordsViewInfo.DataRowHeight
  else
    AHeight := RecordsViewInfo.Items[RecordsViewInfo.Count - 1].Bounds.Bottom +
      PartsBottomHeight;
  AFullyVisible := (VisibleRecordCount = 0) or
    (VisibleRecordCount = ViewData.RowCount - FirstRecordIndex) and
    Controller.IsDataFullyVisible(True);
  inherited;
end;

function TcxGridTableViewInfo.CalculateVisibleEqualHeightRecordCount: Integer;
begin
  Result := (Bounds.Bottom - Bounds.Top - GetNonRowsAreaHeight(False)) div
    RecordsViewInfo.CommonDataRowHeight;
end;

procedure TcxGridTableViewInfo.CalculateWidth(const AMaxSize: TPoint; var AWidth: Integer);
begin
  if GridView.OptionsView.ColumnAutoWidth then
    with Site.ClientBounds do
      AWidth := Right - Left
  else
    AWidth := IndicatorViewInfo.Width + DataWidth;
  inherited;
end;

function TcxGridTableViewInfo.GetDefaultGridModeBufferCount: Integer;
begin
  if RecordsViewInfo.DataRowHeight = 0 then
  begin
    Controller.PostGridModeBufferCountUpdate;
    Result := 0;
  end
  else
    Result := Screen.Height div RecordsViewInfo.DataRowHeight + 2;
end;

procedure TcxGridTableViewInfo.Offset(DX, DY: Integer);
var
  I: Integer;
begin {2}
  for I := 0 to PartCount - 1 do
    with Parts[I] do
      if IsScrollable then Offset(DX, 0);
  inherited;
end;

procedure TcxGridTableViewInfo.RecreateViewInfos;
begin
  FDataWidth := 0;
  inherited;
end;

function TcxGridTableViewInfo.GetFooterPainterClass: TcxGridFooterPainterClass;
begin
  Result := TcxGridFooterPainter;
end;

function TcxGridTableViewInfo.GetRecordsViewInfoClass: TcxCustomGridRecordsViewInfoClass;
begin
  Result := TcxGridRowsViewInfo;
end;

function TcxGridTableViewInfo.CalculateDataWidth: Integer;
begin
  Result := HeaderViewInfo.Width;
  if (Result = 0) and GridView.OptionsView.ColumnAutoWidth then
    Result := ClientWidth;
end;

function TcxGridTableViewInfo.CalculatePartBounds(APart: TcxCustomGridPartViewInfo): TRect;
var
  I: Integer;
begin
  Result := ClientBounds;
  if APart.IsScrollable then
    Dec(Result.Left, LeftPos)
  else
    if APart.IsAutoWidth then
    begin
      Result.Left := Bounds.Left;
      Result.Right := Bounds.Right;
    end;
  if not APart.IsAutoWidth then
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

function TcxGridTableViewInfo.GetFilterViewInfoClass: TcxGridFilterViewInfoClass;
begin
  Result := TcxGridFilterViewInfo;
end;

function TcxGridTableViewInfo.GetFirstItemAdditionalWidth: Integer;
begin
  Result := (GridView.GroupedColumnCount + Ord(GridView.IsMaster)) * LevelIndent;
end;

function TcxGridTableViewInfo.GetFooterViewInfoClass: TcxGridFooterViewInfoClass;
begin
  Result := TcxGridFooterViewInfo;
end;

function TcxGridTableViewInfo.GetGridLineWidth: Integer;
begin
  Result := 1;
end;

function TcxGridTableViewInfo.GetGroupByBoxViewInfoClass: TcxGridGroupByBoxViewInfoClass;
begin
  Result := TcxGridGroupByBoxViewInfo;
end;

function TcxGridTableViewInfo.GetHeaderViewInfoClass: TcxGridHeaderViewInfoClass;
begin
  Result := TcxGridHeaderViewInfo;
end;

function TcxGridTableViewInfo.GetIndicatorViewInfoClass: TcxGridIndicatorViewInfoClass;
begin
  Result := TcxGridIndicatorViewInfo;
end;

function TcxGridTableViewInfo.GetLevelSeparatorColor: TColor;
begin
  Result := GridLineColor;
end;

function TcxGridTableViewInfo.GetHeaderViewInfoSpecificClass: TcxGridHeaderViewInfoSpecificClass;
begin
  Result := TcxGridHeaderViewInfoSpecific;
end;

function TcxGridTableViewInfo.GetNonRowsAreaHeight(ACheckScrollBar: Boolean): Integer;
begin
  Result := PartsTopHeight + PartsBottomHeight;
  with RecordsViewInfo do
    if NewItemRowViewInfo <> nil then
      Inc(Result, NewItemRowViewInfo.Height);
  if ACheckScrollBar then AddScrollBarHeight(Result);
end;

function TcxGridTableViewInfo.GetScrollableAreaBoundsHorz: TRect;
begin
  Result := inherited GetScrollableAreaBoundsHorz;
  Dec(Result.Top, HeaderViewInfo.Height);
  Inc(Result.Bottom, FooterViewInfo.Height);
end;

function TcxGridTableViewInfo.GetScrollableAreaBoundsVert: TRect;
begin
  Result := inherited GetScrollableAreaBoundsVert;
  Dec(Result.Left, IndicatorViewInfo.Width);
  Result.Top := RecordsViewInfo.ContentBounds.Top;
end;

function TcxGridTableViewInfo.GetCellBorders(AIsRight, AIsBottom: Boolean): TcxBorders;
begin
  case GridLines of
    glBoth:
      Result := [bRight, bBottom];
    glNone:
      Result := [];
    glVertical:
      Result := [bRight];
    glHorizontal:
      begin
        if AIsRight then
          Result := [bRight]
        else
          Result := [];
        Include(Result, bBottom);
      end;
  end;
end;

function TcxGridTableViewInfo.GetCellHeight(AIndex, ACellHeight: Integer): Integer;
begin
  Result := ACellHeight;
end;

function TcxGridTableViewInfo.GetCellTopOffset(AIndex, ACellHeight: Integer): Integer;
begin
  Result := 0;
end;

function TcxGridTableViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
var
  AScreenP: TPoint;
  I: Integer;
begin
  AScreenP := Site.ClientToScreen(P);
  if (Controller.CustomizationForm <> nil) and
    PtInRect(Controller.CustomizationForm.BoundsRect, AScreenP) then
  begin
    Result := TcxGridCustomozationFormHitTest.Instance(P);
    InitHitTest(Result);
  end
  else
  begin
    if PtInRect(Site.ClientBounds, P) then
    begin
      Result := IndicatorViewInfo.GetHitTest(P);
      if Result <> nil then Exit;
      for I := 0 to PartCount - 1 do
        if Parts[I].Visible then
        begin
          Result := Parts[I].GetHitTest(P);
          if Result <> nil then Exit;
        end;
    end;
    Result := inherited GetHitTest(P);
  end;
end;

function TcxGridTableViewInfo.GetOffsetBounds(AItemsOffset: Integer; out AUpdateBounds: TRect): TRect;
begin     {2}
  Result := ScrollableAreaBoundsVert;
  AUpdateBounds := Result;
  if AItemsOffset < 0 then
  begin
    Inc(Result.Top, -AItemsOffset);
    with RecordsViewInfo do
      if VisibleCount >= 2 then
        Result.Bottom := Items[VisibleCount - 2].Bounds.Bottom;
    AUpdateBounds.Top := Result.Bottom + AItemsOffset;
  end
  else
  begin
    Dec(Result.Bottom, AItemsOffset);
    with RecordsViewInfo do
      if PartVisibleCount >= 2 then
        Result.Top := Items[1].Bounds.Top;
    AUpdateBounds.Bottom := Result.Top + AItemsOffset;
  end;
end;

function TcxGridTableViewInfo.GetOffsetBounds(DX, DY: Integer; out AUpdateBounds: TRect): TRect;
begin     {2}
  Result := ScrollableAreaBoundsHorz;
  AUpdateBounds := Result;
  if DX < 0 then
  begin
    Inc(Result.Left, -DX);
    AUpdateBounds.Left := Result.Right + DX;
  end
  else
  begin
    Dec(Result.Right, DX);
    AUpdateBounds.Right := Result.Left + DX;
  end;
end;

function TcxGridTableViewInfo.GetNearestPopupHeight(AHeight: Integer;
  AAdditionalRecord: Boolean = False): Integer;
var
  ARowCount: Integer;
begin
  ARowCount := (AHeight - GetNonRowsAreaHeight(True)) div RecordsViewInfo.DataRowHeight;
  if ARowCount < 1 then ARowCount := 1;
  if ARowCount > ViewData.RowCount + Ord(AAdditionalRecord) then
    ARowCount := ViewData.RowCount + Ord(AAdditionalRecord);
  Result := GetNonRowsAreaHeight(True) + ARowCount * RecordsViewInfo.DataRowHeight;  
end;

function TcxGridTableViewInfo.GetPopupHeight(ADropDownRowCount: Integer): Integer;
begin
  Result := GetNonRowsAreaHeight(True) + ADropDownRowCount * RecordsViewInfo.DataRowHeight;
end;

{ TcxGridTableViewInfoCacheItem }

procedure TcxGridTableViewInfoCacheItem.SetPreviewHeight(Value: Integer);
begin
  FPreviewHeight := Value;
  IsPreviewHeightAssigned := True;
end;

procedure TcxGridTableViewInfoCacheItem.UnassignValues(AKeepMaster: Boolean);
begin
  inherited;
  IsPreviewHeightAssigned := False;
end;

{ TcxGridMasterTableViewInfoCacheItem }

function TcxGridMasterTableViewInfoCacheItem.GetGridRecord: TcxGridMasterDataRow;
begin
  Result := TcxGridMasterDataRow(inherited GridRecord);
end;

procedure TcxGridMasterTableViewInfoCacheItem.SetDetailsSiteHeight(Value: Integer);
begin
  FDetailsSiteHeight := Value;
  IsDetailsSiteHeightAssigned := True;
end;

procedure TcxGridMasterTableViewInfoCacheItem.SetDetailsSiteNormalHeight(Value: Integer);
begin
  FDetailsSiteNormalHeight := Value;
  IsDetailsSiteNormalHeightAssigned := True;
end;

procedure TcxGridMasterTableViewInfoCacheItem.SetDetailsSiteWidth(Value: Integer);
begin
  FDetailsSiteWidth := Value;
  IsDetailsSiteWidthAssigned := True;
end;

procedure TcxGridMasterTableViewInfoCacheItem.UnassignValues(AKeepMaster: Boolean);
begin
  if FUnassigningValues then Exit;
  FUnassigningValues := True;
  try
    inherited;
    IsDetailsSiteHeightAssigned := False;
    IsDetailsSiteNormalHeightAssigned := False;
    IsDetailsSiteWidthAssigned := False;
    if GridRecord.ActiveDetailGridViewExists then
      GridRecord.ActiveDetailGridView.ViewInfoCache.UnassignValues(AKeepMaster);
  finally
    FUnassigningValues := False;
  end;
end;

{ TcxGridTableViewInfoCache }

function TcxGridTableViewInfoCache.GetItemClass: TcxCustomGridViewInfoCacheItemClass;
begin
  if GridView.IsMaster then
    Result := TcxGridMasterTableViewInfoCacheItem
  else
    Result := TcxGridTableViewInfoCacheItem;
end;

{ TcxGridColumnOptions }

constructor TcxGridColumnOptions.Create(AItem: TcxCustomGridTableItem);
begin
  inherited;
  FHorzSizing := True;
end;

function TcxGridColumnOptions.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

procedure TcxGridColumnOptions.SetHorzSizing(Value: Boolean);
begin
  if FHorzSizing <> Value then
  begin
    FHorzSizing := Value;
    Changed;
  end;
end;

procedure TcxGridColumnOptions.Assign(Source: TPersistent);
begin
  if Source is TcxGridColumnOptions then
    with TcxGridColumnOptions(Source) do
      Self.HorzSizing := HorzSizing;
  inherited;
end;

{ TcxGridColumnStyles }

function TcxGridColumnStyles.GetGridViewValue: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxGridColumnStyles.GetItem: TcxGridColumn;
begin
  Result := TcxGridColumn(inherited Item);
end;

procedure TcxGridColumnStyles.GetDefaultViewParams(Index: Integer; AData: TObject;
  out AParams: TcxViewParams);
begin
  case Index of
    isFooter:
      GridView.Styles.GetFooterParams(TcxCustomGridRecord(AData), Item, AParams);
    isHeader:
      GridView.Styles.GetHeaderParams(Item, AParams);
  else
    inherited;
  end;
end;

procedure TcxGridColumnStyles.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TcxGridColumnStyles then
    with TcxGridColumnStyles(Source) do
    begin
      Self.Footer := Footer;
      Self.Header := Header;
      Self.OnGetFooterStyle := OnGetFooterStyle;
      Self.OnGetHeaderStyle := OnGetHeaderStyle;
    end;
end;

procedure TcxGridColumnStyles.GetFooterParams(ARecord: TcxCustomGridRecord;
  out AParams: TcxViewParams);
var
  AStyle: TcxStyle;
begin
  AStyle := nil;
  if Assigned(FOnGetFooterStyle) then
    FOnGetFooterStyle(GridView, ARecord, Item, AStyle);
  GetViewParams(isFooter, ARecord, AStyle, AParams);
end;

procedure TcxGridColumnStyles.GetHeaderParams(out AParams: TcxViewParams);
var
  AStyle: TcxStyle;
begin
  AStyle := nil;
  if Assigned(FOnGetHeaderStyle) then
    FOnGetHeaderStyle(GridView, Item, AStyle);
  GetViewParams(isHeader, nil, AStyle, AParams);
end;

{ TcxGridColumn }

constructor TcxGridColumn.Create(AOwner: TComponent);
begin
  inherited;
  FHeaderGlyphAlignmentVert := vaCenter;
end;

destructor TcxGridColumn.Destroy;
begin
  IsPreview := False;
  inherited;
end;

function TcxGridColumn.GetFooterAlignmentHorz: TAlignment;
begin
  if FIsFooterAlignmentHorzAssigned then
    Result := FFooterAlignmentHorz
  else
    Result := GetDefaultValuesProvider.DefaultAlignment;
end;

function TcxGridColumn.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxGridColumn.GetHidden: Boolean;
begin
  Result := FHidden or IsPreview;
end;

function TcxGridColumn.GetIsPreview: Boolean;
begin
  Result := GridView.Preview.Column = Self;
end;

function TcxGridColumn.GetOptions: TcxGridColumnOptions;
begin
  Result := TcxGridColumnOptions(inherited Options);
end;

function TcxGridColumn.GetStyles: TcxGridColumnStyles;
begin
  Result := TcxGridColumnStyles(inherited Styles);
end;

procedure TcxGridColumn.SetFooterAlignmentHorz(Value: TAlignment);
begin
  if (FooterAlignmentHorz <> Value) or IsLoading then
  begin
    FFooterAlignmentHorz := Value;
    FIsFooterAlignmentHorzAssigned := True;
    Changed(ticLayout);
  end;
end;

procedure TcxGridColumn.SetHeaderGlyph(Value: TBitmap);
begin
  FHeaderGlyph.Assign(Value);
end;

procedure TcxGridColumn.SetHeaderGlyphAlignmentHorz(Value: TAlignment);
begin
  if FHeaderGlyphAlignmentHorz <> Value then
  begin
    FHeaderGlyphAlignmentHorz := Value;
    Changed(ticLayout);
  end;
end;

procedure TcxGridColumn.SetHeaderGlyphAlignmentVert(Value: TcxAlignmentVert);
begin
  if FHeaderGlyphAlignmentVert <> Value then
  begin
    FHeaderGlyphAlignmentVert := Value;
    Changed(ticLayout);
  end;
end;

procedure TcxGridColumn.SetHidden(Value: Boolean);
begin
  if Hidden <> Value then
  begin
    FHidden := Value;
    HiddenChanged;
  end;
end;

procedure TcxGridColumn.SetIsPreview(Value: Boolean);
begin
  if IsPreview <> Value then
    if Value then
      GridView.Preview.Column := Self
    else
      GridView.Preview.Column := nil;
end;

procedure TcxGridColumn.SetOptions(Value: TcxGridColumnOptions);
begin
  inherited Options := Value;
end;

procedure TcxGridColumn.SetStyles(Value: TcxGridColumnStyles);
begin
  inherited Styles := Value;
end;

function TcxGridColumn.IsFooterAlignmentHorzStored: Boolean;
begin
  Result := FIsFooterAlignmentHorzAssigned and
    (FFooterAlignmentHorz <> GetDefaultValuesProvider.DefaultAlignment);
end;

function TcxGridColumn.IsHiddenStored: Boolean;
begin
  Result := Hidden and not IsPreview;
end;

procedure TcxGridColumn.HeaderGlyphChanged(Sender: TObject);
begin
  Changed(ticLayout);
end;

function TcxGridColumn.GetStoredProperties(AProperties: TStrings): Boolean;
begin
  inherited GetStoredProperties(AProperties);
  with AProperties do
  begin
    Add('GroupIndex');
    Add('Width');
  end;
  Result := True;
end;

procedure TcxGridColumn.GetPropertyValue(const AName: string; var AValue: Variant);
begin
  if AName = 'Width' then
    AValue := Width
  else
    if AName = 'GroupIndex' then
      AValue := GroupIndex
    else
      inherited;
end;

procedure TcxGridColumn.SetPropertyValue(const AName: string; const AValue: Variant);
begin
  if AName = 'Width' then
    Width := AValue
  else
    if AName = 'GroupIndex' then
      GroupIndex := AValue
    else
      inherited;
end;

procedure TcxGridColumn.CreateSubClasses;
begin
  inherited;
  FHeaderGlyph := TBitmap.Create;
  FHeaderGlyph.OnChange := HeaderGlyphChanged;
end;

procedure TcxGridColumn.DestroySubClasses;
begin
  FreeAndNil(FHeaderGlyph);
  inherited;
end;

procedure TcxGridColumn.AssignColumnWidths;
begin
  with GridView do
    if OptionsView.ColumnAutoWidth then
      ViewInfo.HeaderViewInfo.AssignColumnWidths;
end;

function TcxGridColumn.CanFilter(ACheckGridViewOptions: Boolean): Boolean;
begin
  Result := inherited CanFilter(ACheckGridViewOptions) and
    (not ACheckGridViewOptions or GridView.OptionsCustomize.ColumnFiltering);
end;

function TcxGridColumn.CanHorzSize: Boolean;
begin
  Result := GridView.OptionsCustomize.ColumnHorzSizing and Options.HorzSizing;
end;

procedure TcxGridColumn.CaptionChanged;
begin
  inherited;
  GridView.RefreshCustomizationForm;
end;

procedure TcxGridColumn.ForceWidth(Value: Integer);
begin
  AssignColumnWidths;
  inherited;
  AssignColumnWidths;
end;

function TcxGridColumn.GetBestFitWidth: Integer;
var
  ABorders: TcxBorders;
begin
  Result := inherited GetBestFitWidth;
  ABorders := GridView.ViewInfo.GetCellBorders(IsMostRight, False);
  Inc(Result, (Ord(bLeft in ABorders) + Ord(bRight in ABorders)) * GridView.ViewInfo.GridLineWidth);
  if (VisibleIndex <> -1) and GridView.Visible then
  begin
    if GridView.OptionsView.Header then
      Result := Max(Result, GridView.ViewInfo.HeaderViewInfo[VisibleIndex].GetBestFitWidth);
    if GridView.OptionsView.Footer then
      Result := Max(Result, GridView.ViewInfo.FooterViewInfo[VisibleIndex].GetBestFitWidth);
    Result := Max(Result, GridView.ViewInfo.RecordsViewInfo.GetFooterCellBestFitWidth(VisibleIndex));
  end;
end;

function TcxGridColumn.GetFilterable: Boolean;
begin
  Result := inherited GetFilterable {and not Hidden};
end;

function TcxGridColumn.GetFixed: Boolean;
begin
  Result := inherited GetFixed or not Options.HorzSizing or
    (GridView.Controller.ForcingWidthItem <> nil) and
    GridView.Controller.IsColumnFixedDuringHorzSizing(Self);
end;

function TcxGridColumn.GetIsBottom: Boolean;
begin
  Result := True;
end;

function TcxGridColumn.GetIsLeft: Boolean;
begin
  Result := IsFirst;
end;

function TcxGridColumn.GetIsMostBottom: Boolean;
begin
  Result := IsBottom;
end;

function TcxGridColumn.GetIsMostLeft: Boolean;
begin
  Result := IsLeft;
end;

function TcxGridColumn.GetIsMostRight: Boolean;
begin
  Result := IsRight;
end;

function TcxGridColumn.GetIsRight: Boolean;
begin
  Result := IsLast;
end;

function TcxGridColumn.GetVisible: Boolean;
begin
  Result := inherited GetVisible and not IsPreview;
end;

function TcxGridColumn.HasCustomDrawFooterCell: Boolean;
begin
  Result := Assigned(FOnCustomDrawFooterCell);
end;

function TcxGridColumn.HasCustomDrawHeader: Boolean;
begin
  Result := Assigned(FOnCustomDrawHeader);
end;

procedure TcxGridColumn.HiddenChanged;
begin
  with GridView do
  begin
    //RefreshFilterableItemsList;
    RefreshCustomizationForm;
  end;
end;

function TcxGridColumn.HideOnGrouping: Boolean;
begin
  Result := GridView.OptionsCustomize.ColumnHidingOnGrouping;
end;

function TcxGridColumn.IsVisibleStored: Boolean;
begin
  Result := inherited IsVisibleStored and not IsPreview;
end;

{procedure TcxGridColumn.VisibleChanged;
begin
  //FGridView.RefreshVisibleColumnsList;
  //FGridView.RefreshCustomizationForm;
end;}

function TcxGridColumn.GetHeaderViewInfoClass: TcxGridColumnHeaderViewInfoClass;
begin
  Result := TcxGridColumnHeaderViewInfo;
end;

function TcxGridColumn.GetOptionsClass: TcxCustomGridTableItemOptionsClass;
begin
  Result := TcxGridColumnOptions;
end;

function TcxGridColumn.GetStylesClass: TcxCustomGridTableItemStylesClass;
begin
  Result := TcxGridColumnStyles;
end;

function TcxGridColumn.GetViewInfoClass: TcxCustomGridCellViewInfoClass;
begin
  Result := TcxGridDataCellViewInfo;
end;

procedure TcxGridColumn.DoCustomDrawFooterCell(ACanvas: TcxCanvas;
  AViewInfo: TcxGridColumnHeaderViewInfo; var ADone: Boolean);
begin
  if HasCustomDrawFooterCell then
    FOnCustomDrawFooterCell(GridView, ACanvas, AViewInfo, ADone);
end;

procedure TcxGridColumn.DoCustomDrawHeader(ACanvas: TcxCanvas;
  AViewInfo: TcxGridColumnHeaderViewInfo; var ADone: Boolean);
begin
  if HasCustomDrawHeader then
    FOnCustomDrawHeader(GridView, ACanvas, AViewInfo, ADone);
end;

procedure TcxGridColumn.DoHeaderClick;
begin
  if Assigned(FOnHeaderClick) then FOnHeaderClick(Self);
  GridView.DoColumnHeaderClick(Self);
end;

procedure TcxGridColumn.DoUserFiltering(const AValue: Variant; const ADisplayText: string);
begin
  if Assigned(FOnUserFiltering) then FOnUserFiltering(Self, AValue, ADisplayText);
end;

procedure TcxGridColumn.Assign(Source: TPersistent);
begin
  if Source is TcxGridColumn then
    with TcxGridColumn(Source) do
    begin
      Self.FooterAlignmentHorz := FooterAlignmentHorz;
      Self.HeaderGlyph := HeaderGlyph;
      Self.HeaderGlyphAlignmentHorz := HeaderGlyphAlignmentHorz;
      Self.HeaderGlyphAlignmentVert := HeaderGlyphAlignmentVert;
      Self.Hidden := Hidden;
      Self.OnCustomDrawFooterCell := OnCustomDrawFooterCell;
      Self.OnCustomDrawHeader := OnCustomDrawHeader;
      Self.OnHeaderClick := OnHeaderClick;
      Self.OnUserFiltering := OnUserFiltering;
    end;
  inherited;
end;

{ TcxGridTableBackgroundBitmaps }

function TcxGridTableBackgroundBitmaps.GetBitmapStyleIndex(Index: Integer): Integer;
begin
  case Index of
    bbFilterBox:
      Result := vsFilterBox;
    bbFooter:
      Result := vsFooter;
    bbHeader:
      Result := vsHeader;
    bbGroup:
      Result := vsGroup;
    bbGroupByBox:
      Result := vsGroupByBox;
    bbIndicator:
      Result := vsIndicator;
    bbPreview:
      Result := vsPreview;
  else
    Result := inherited GetBitmapStyleIndex(Index);
  end;
end;

procedure TcxGridTableBackgroundBitmaps.Assign(Source: TPersistent);
begin
  if Source is TcxGridTableBackgroundBitmaps then
    with TcxGridTableBackgroundBitmaps(Source) do
    begin
      Self.FilterBox := FilterBox;
      Self.Footer := Footer;
      Self.Header := Header;
      Self.Group := Group;
      Self.GroupByBox := GroupByBox;
      Self.Indicator := Indicator;
      Self.Preview := Preview;
    end;
  inherited;
end;

{ TcxGridTableOptionsBehavior }

constructor TcxGridTableOptionsBehavior.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FExpandMasterRowOnDblClick := True;
end;

procedure TcxGridTableOptionsBehavior.Assign(Source: TPersistent);
begin
  if Source is TcxGridTableOptionsBehavior then
    with TcxGridTableOptionsBehavior(Source) do
      Self.ExpandMasterRowOnDblClick := ExpandMasterRowOnDblClick;
  inherited;
end;

{ TcxCustomGridFilterItem }

constructor TcxCustomGridFilterItem.Create(AParent: TcxGridFilterItemList);
begin
  inherited Create;
  FParent := AParent;
end;

destructor TcxCustomGridFilterItem.Destroy;
begin
  if FParent <> nil then
    FParent.InternalRemoveItem(Self);
  inherited;
end;

{ TcxGridFilterItem }

constructor TcxGridFilterItem.Create(AParent: TcxGridFilterItemList;
  AColumn: TcxGridColumn; AOperatorKind: TcxFilterOperatorKind; const AValue: Variant;
  const ADisplayText: string);
begin
  inherited Create(AParent);
  FColumn := AColumn;
  FOperatorKind := AOperatorKind;
  FValue := AValue;
  FDisplayText := ADisplayText;
end;

function TcxGridFilterItem.GetIsList: Boolean;
begin
  Result := False;
end;

{ TcxGridFilterItemList }

constructor TcxGridFilterItemList.Create(AParent: TcxGridFilterItemList;
  ABoolOperatorKind: TcxFilterBoolOperatorKind);
begin
  inherited Create(AParent);
  FBoolOperatorKind := ABoolOperatorKind;
  FItems := TList.Create;
end;

destructor TcxGridFilterItemList.Destroy;
begin
  Clear;
  FItems.Free;
  inherited;
end;

function TcxGridFilterItemList.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxGridFilterItemList.GetItem(Index: Integer): TcxCustomGridFilterItem;
begin
  Result := TcxCustomGridFilterItem(FItems[Index]);
end;

procedure TcxGridFilterItemList.SetBoolOperatorKind(Value: TcxFilterBoolOperatorKind);
begin
  if FBoolOperatorKind <> Value then
  begin
    FBoolOperatorKind := Value;
    Changed;
  end;
end;

procedure TcxGridFilterItemList.InternalAddItem(AItem: TcxCustomGridFilterItem);
begin
  FItems.Add(AItem);
  Changed;
end;

procedure TcxGridFilterItemList.InternalRemoveItem(AItem: TcxCustomGridFilterItem);
begin
  FItems.Remove(AItem);
  Changed;
end;

procedure TcxGridFilterItemList.Changed;
begin
  if Assigned(FOnChange) then FOnChange(Self);
  if FParent <> nil then FParent.Changed;
end;

function TcxGridFilterItemList.GetIsList: Boolean;
begin
  Result := True;
end;

function TcxGridFilterItemList.AddItem(AColumn: TcxGridColumn;
  AOperatorKind: TcxFilterOperatorKind; const AValue: Variant;
  const ADisplayText: string): TcxGridFilterItem;
begin
  Result := TcxGridFilterItem.Create(Self, AColumn, AOperatorKind, AValue, ADisplayText);
  InternalAddItem(Result);
end;

function TcxGridFilterItemList.AddItemList(ABoolOperatorKind: TcxFilterBoolOperatorKind): TcxGridFilterItemList;
begin
  Result := TcxGridFilterItemList.Create(Self, ABoolOperatorKind);
  InternalAddItem(Result);
end;

procedure TcxGridFilterItemList.Assign(ACriteriaItemList: TcxFilterCriteriaItemList);
var
  I: Integer;
  AItemList: TcxFilterCriteriaItemList;
begin
  Clear;
  BoolOperatorKind := ACriteriaItemList.BoolOperatorKind;
  for I := 0 to ACriteriaItemList.Count - 1 do
    if ACriteriaItemList[I].IsItemList then
    begin
      AItemList := TcxFilterCriteriaItemList(ACriteriaItemList[I]);
      AddItemList(AItemList.BoolOperatorKind).Assign(AItemList);
    end
    else
      with TcxFilterCriteriaItem(ACriteriaItemList[I]) do
        Self.AddItem(ItemLink as TcxGridColumn, OperatorKind, Value, DisplayValue);
end;

procedure TcxGridFilterItemList.AssignTo(ACriteriaItemList: TcxFilterCriteriaItemList);
var
  I: Integer;
  AItemList: TcxGridFilterItemList;
begin
  ACriteriaItemList.Clear;
  ACriteriaItemList.BoolOperatorKind := FBoolOperatorKind;
  for I := 0 to Count - 1 do
    if Items[I].IsList then
    begin
      AItemList := TcxGridFilterItemList(Items[I]);
      AItemList.AssignTo(ACriteriaItemList.AddItemList(AItemList.BoolOperatorKind));
    end
    else
      with TcxGridFilterItem(Items[I]) do
        ACriteriaItemList.AddItem(Column, OperatorKind, Value, DisplayText);
end;

procedure TcxGridFilterItemList.Clear;
begin
  while Count <> 0 do Items[0].Free;
end;

function TcxGridFilterItemList.HasItem(AItem: TcxCustomGridFilterItem): Boolean;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := Items[I] = AItem;
    if not Result and Items[I].IsList then
      Result := TcxGridFilterItemList(Items[I]).HasItem(AItem);
    if Result then Exit;
  end;
  Result := False;
end;

{ TcxGridTableOptionsCustomize }

constructor TcxGridTableOptionsCustomize.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FColumnFiltering := True;
  FColumnHidingOnGrouping := True;
  FColumnHorzSizing := True;
end;

function TcxGridTableOptionsCustomize.GetColumnGrouping: Boolean;
begin
  Result := ItemGrouping;
end;

function TcxGridTableOptionsCustomize.GetColumnMoving: Boolean;
begin
  Result := ItemMoving;
end;

function TcxGridTableOptionsCustomize.GetColumnSorting: Boolean;
begin
  Result := ItemSorting;
end;

function TcxGridTableOptionsCustomize.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

procedure TcxGridTableOptionsCustomize.SetColumnFiltering(Value: Boolean);
begin
  if FColumnFiltering <> Value then
  begin
    FColumnFiltering := Value;
    LayoutChanged;
  end;
end;

procedure TcxGridTableOptionsCustomize.SetColumnGrouping(Value: Boolean);
begin
  ItemGrouping := Value;
end;

procedure TcxGridTableOptionsCustomize.SetColumnHorzSizing(Value: Boolean);
begin
  if FColumnHorzSizing <> Value then
  begin
    FColumnHorzSizing := Value;
    LayoutChanged;
  end;
end;

procedure TcxGridTableOptionsCustomize.SetColumnMoving(Value: Boolean);
begin
  ItemMoving := Value;
end;

procedure TcxGridTableOptionsCustomize.SetColumnSorting(Value: Boolean);
begin
  ItemSorting := Value;
end;

procedure TcxGridTableOptionsCustomize.Assign(Source: TPersistent);
begin
  if Source is TcxGridTableOptionsCustomize then
    with TcxGridTableOptionsCustomize(Source) do
    begin
      Self.ColumnFiltering := ColumnFiltering;
      Self.ColumnHiding := ColumnHiding;
      Self.ColumnHidingOnGrouping := ColumnHidingOnGrouping;
      Self.ColumnHorzSizing := ColumnHorzSizing;
      Self.DataRowSizing := DataRowSizing;
      Self.GroupRowSizing := GroupRowSizing;
    end;
  inherited;
end;

{ TcxGridTableOptionsView }

constructor TcxGridTableOptionsView.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FExpandButtonsForEmptyDetails := True;
  FGridLineColor := clDefault;
  FGroupByBox := True;
  FHeader := True;
  FIndicatorWidth := cxGridDefaultIndicatorWidth;
  FNewItemRowInfoText := cxGetResourceString(@scxGridNewItemRowInfoText);
  FNewItemRowSeparatorColor := clDefault;
  FNewItemRowSeparatorWidth := cxGridDefaultNewItemRowSeparatorWidth;
  FRowSeparatorColor := clDefault;
end;

function TcxGridTableOptionsView.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxGridTableOptionsView.GetHeaderAutoHeight: Boolean;
begin
  Result := ItemCaptionAutoHeight;
end;

function TcxGridTableOptionsView.GetHeaderEndEllipsis: Boolean;
begin
  Result := ItemCaptionEndEllipsis;
end;

procedure TcxGridTableOptionsView.SetColumnAutoWidth(Value: Boolean);
begin
  if FColumnAutoWidth <> Value then
  begin
    FColumnAutoWidth := Value;
    SizeChanged;
  end;
end;

procedure TcxGridTableOptionsView.SetDataRowHeight(Value: Integer);
begin
  CheckDataRowHeight(Value);
  if FDataRowHeight <> Value then
  begin
    FDataRowHeight := Value;
    SizeChanged;
    GridView.Controller.DesignerModified;
  end;
end;

procedure TcxGridTableOptionsView.SetExpandButtonsForEmptyDetails(Value: Boolean);
begin
  if FExpandButtonsForEmptyDetails <> Value then
  begin
    FExpandButtonsForEmptyDetails := Value;
    LayoutChanged;
  end;
end;

procedure TcxGridTableOptionsView.SetFooter(Value: Boolean);
begin
  if FFooter <> Value then
  begin
    FFooter := Value;
    SizeChanged;
  end;
end;

procedure TcxGridTableOptionsView.SetGridLineColor(Value: TColor);
begin
  if FGridLineColor <> Value then
  begin
    FGridLineColor := Value;
    LayoutChanged;
  end;
end;

procedure TcxGridTableOptionsView.SetGridLines(Value: TcxGridLines);
begin
  if FGridLines <> Value then
  begin
    FGridLines := Value;
    SizeChanged;
  end;
end;

procedure TcxGridTableOptionsView.SetGroupByBox(Value: Boolean);
begin
  if FGroupByBox <> Value then
  begin
    FGroupByBox := Value;
    SizeChanged;
  end;
end;

procedure TcxGridTableOptionsView.SetGroupFooters(Value: TcxGridGroupFootersMode);
begin
  if FGroupFooters <> Value then
  begin
    FGroupFooters := Value;
    SizeChanged;
  end;
end;

procedure TcxGridTableOptionsView.SetGroupRowHeight(Value: Integer);
begin
  CheckGroupRowHeight(Value);
  if FGroupRowHeight <> Value then
  begin
    FGroupRowHeight := Value;
    SizeChanged;
    GridView.Controller.DesignerModified;
  end;
end;

procedure TcxGridTableOptionsView.SetHeader(Value: Boolean);
begin
  if FHeader <> Value then
  begin
    FHeader := Value;
    SizeChanged;
  end;
end;

procedure TcxGridTableOptionsView.SetHeaderAutoHeight(Value: Boolean);
begin
  ItemCaptionAutoHeight := Value;
end;

procedure TcxGridTableOptionsView.SetHeaderEndEllipsis(Value: Boolean);
begin
  ItemCaptionEndEllipsis := Value;
end;

procedure TcxGridTableOptionsView.SetHeaderHeight(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FHeaderHeight <> Value then
  begin
    FHeaderHeight := Value;
    SizeChanged;
  end;
end;

procedure TcxGridTableOptionsView.SetIndicator(Value: Boolean);
begin
  if FIndicator <> Value then
  begin
    FIndicator := Value;
    SizeChanged;
  end;
end;

procedure TcxGridTableOptionsView.SetIndicatorWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FIndicatorWidth <> Value then
  begin
    FIndicatorWidth := Value;
    SizeChanged;
  end;
end;

procedure TcxGridTableOptionsView.SetNewItemRow(Value: Boolean);
begin
  if FNewItemRow <> Value then
  begin
    FNewItemRow := Value;
    GridView.ViewData.CheckNewItemRecord;
    GridView.DataController.UseNewItemRowForEditing := FNewItemRow;
  end;
end;

procedure TcxGridTableOptionsView.SetNewItemRowInfoText(const Value: string);
begin
  if FNewItemRowInfoText <> Value then
  begin
    FNewItemRowInfoText := Value;
    LayoutChanged;
  end;
end;

procedure TcxGridTableOptionsView.SetNewItemRowSeparatorColor(Value: TColor);
begin
  if FNewItemRowSeparatorColor <> Value then
  begin
    FNewItemRowSeparatorColor := Value;
    LayoutChanged;
  end;
end;

procedure TcxGridTableOptionsView.SetNewItemRowSeparatorWidth(Value: Integer);
begin
  if Value < cxGridMinNewItemRowSeparatorWidth then
    Value := cxGridMinNewItemRowSeparatorWidth;
  if FNewItemRowSeparatorWidth <> Value then
  begin
    FNewItemRowSeparatorWidth := Value;
    SizeChanged;
  end;
end;

procedure TcxGridTableOptionsView.SetRowSeparatorColor(Value: TColor);
begin
  if FRowSeparatorColor <> Value then
  begin
    FRowSeparatorColor := Value;
    LayoutChanged;
  end;
end;

procedure TcxGridTableOptionsView.SetRowSeparatorWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FRowSeparatorWidth <> Value then
  begin
    FRowSeparatorWidth := Value;
    SizeChanged;
  end;
end;

function TcxGridTableOptionsView.IsNewItemRowInfoTextStored: Boolean;
begin
  Result := FNewItemRowInfoText <> cxGetResourceString(@scxGridNewItemRowInfoText);
end;

procedure TcxGridTableOptionsView.ItemCaptionAutoHeightChanged;
begin
  LayoutChanged;
end;

procedure TcxGridTableOptionsView.Assign(Source: TPersistent);
begin
  if Source is TcxGridTableOptionsView then
    with TcxGridTableOptionsView(Source) do
    begin
      Self.ColumnAutoWidth := ColumnAutoWidth;
      Self.DataRowHeight := DataRowHeight;
      Self.ExpandButtonsForEmptyDetails := ExpandButtonsForEmptyDetails;
      Self.Footer := Footer;
      Self.GridLineColor := GridLineColor;
      Self.GridLines := GridLines;
      Self.GroupByBox := GroupByBox;
      Self.GroupFooters := GroupFooters;
      Self.GroupRowHeight := GroupRowHeight;
      Self.Header := Header;
      Self.HeaderHeight := HeaderHeight;
      Self.Indicator := Indicator;
      Self.IndicatorWidth := IndicatorWidth;
      Self.NewItemRow := NewItemRow;
      Self.NewItemRowInfoText := NewItemRowInfoText;
      Self.NewItemRowSeparatorColor := NewItemRowSeparatorColor;
      Self.NewItemRowSeparatorWidth := NewItemRowSeparatorWidth;
      Self.RowSeparatorColor := RowSeparatorColor;
      Self.RowSeparatorWidth := RowSeparatorWidth;
    end;
  inherited;
end;

procedure TcxGridTableOptionsView.CheckDataRowHeight(var AValue: Integer);
begin
  if AValue < 0 then AValue := 0;
end;

procedure TcxGridTableOptionsView.CheckGroupRowHeight(var AValue: Integer);
begin
  if AValue < 0 then AValue := 0;
end;

function TcxGridTableOptionsView.GetGridLineColor: TColor;
begin
  Result := FGridLineColor;
  if Result = clDefault then
    Result := LookAndFeelPainter.DefaultGridLineColor;
end;

function TcxGridTableOptionsView.GetNewItemRowSeparatorColor: TColor;
begin
  Result := FNewItemRowSeparatorColor;
  if Result = clDefault then
    Result := LookAndFeelPainter.DefaultHeaderColor;
end;

function TcxGridTableOptionsView.GetRowSeparatorColor: TColor;
begin
  Result := FRowSeparatorColor;
  if Result = clDefault then
    Result := LookAndFeelPainter.DefaultRecordSeparatorColor;
end;

{ TcxGridPreview }

constructor TcxGridPreview.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FAutoHeight := True;
  FLeftIndent := cxGridPreviewDefaultLeftIndent;
  FMaxLineCount := cxGridPreviewDefaultMaxLineCount;
  FRightIndent := cxGridPreviewDefaultRightIndent;
end;

function TcxGridPreview.GetActive: Boolean;
begin
  Result := FVisible and (FColumn <> nil);
end;

procedure TcxGridPreview.SetAutoHeight(Value: Boolean);
begin
  if FAutoHeight <> Value then
  begin
    FAutoHeight := Value;
    if FVisible then SizeChanged; 
  end;
end;

procedure TcxGridPreview.SetColumn(Value: TcxGridColumn);
var
  APrevColumn: TcxGridColumn;
begin
  if (Value <> nil) and (Value.GridView <> GridView) then Value := nil;
  if FColumn <> Value then
  begin
    APrevColumn := FColumn;
    FColumn := Value;
    GridView.BeginUpdate;
    try
      if APrevColumn <> nil then
      begin
        GridView.ItemVisibilityChanged(APrevColumn, APrevColumn.InternalVisible);
        APrevColumn.HiddenChanged;
      end;
      if FColumn <> nil then
      begin
        GridView.ItemVisibilityChanged(FColumn, False);
        FColumn.HiddenChanged;
      end;
    finally
      GridView.EndUpdate;
    end;
  end;
end;

procedure TcxGridPreview.SetLeftIndent(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FLeftIndent <> Value then
  begin
    FLeftIndent := Value;
    if FVisible then SizeChanged;
  end;
end;

procedure TcxGridPreview.SetMaxLineCount(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FMaxLineCount <> Value then
  begin
    FMaxLineCount := Value;
    if FVisible then SizeChanged;
  end;
end;

procedure TcxGridPreview.SetPlace(Value: TcxGridPreviewPlace);
begin
  if FPlace <> Value then
  begin
    FPlace := Value;
    if FVisible then SizeChanged;
  end;
end;

procedure TcxGridPreview.SetRightIndent(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FRightIndent <> Value then
  begin
    FRightIndent := Value;
    if FVisible then SizeChanged;
  end;
end;

procedure TcxGridPreview.SetVisible(Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    SizeChanged;
  end;
end;

procedure TcxGridPreview.Notification(AComponent: TComponent;
  AOperation: TOperation);
begin
  inherited;
  if (AOperation = opRemove) and (AComponent = Column) then
    Column := nil;
end;

procedure TcxGridPreview.SizeChanged;
begin
  (GridView as TcxGridTableView).SizeChanged;
end;

function TcxGridPreview.GridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

procedure TcxGridPreview.Assign(Source: TPersistent);
begin
  if Source is TcxGridPreview then
    with TcxGridPreview(Source) do
    begin
      Self.AutoHeight := AutoHeight;
      if Self.GridView.AssigningPattern and (Column <> nil) then
        Self.Column := Self.GridView.Columns[Column.Index]
      else
        Self.Column := Column;
      Self.LeftIndent := LeftIndent;
      Self.MaxLineCount := MaxLineCount;
      Self.Place := Place;
      Self.RightIndent := RightIndent;
      Self.Visible := Visible;
    end;
  inherited;
end;

{ TcxGridTableViewStyles }

function TcxGridTableViewStyles.GetGridViewValue: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

procedure TcxGridTableViewStyles.GetDefaultViewParams(Index: Integer; AData: TObject;
  out AParams: TcxViewParams);
begin
  inherited;
  with AParams, LookAndFeelPainter do
    case Index of
      vsFilterBox:
        begin
          Color := DefaultFilterBoxColor;
          TextColor := DefaultFilterBoxTextColor;
        end;
      vsFooter:
        begin
          Color := DefaultFooterColor;
          TextColor := DefaultFooterTextColor;
        end;
      vsGroup:
        begin
          inherited GetContentParams(TcxCustomGridRecord(AData), nil, AParams);
          Color := DefaultGroupColor;
          TextColor := DefaultGroupTextColor;
        end;
      vsGroupByBox:
        begin
          Color := DefaultGroupByBoxColor;
          TextColor := DefaultGroupByBoxTextColor;
        end;
      vsHeader:
        begin
          Color := DefaultHeaderColor;
          TextColor := DefaultHeaderTextColor;
        end;
      vsIndicator:
        Color := DefaultHeaderColor;
      vsNewItemRowInfoText:
        begin
          GetContentParams(TcxCustomGridRecord(AData), nil, AParams);
          TextColor := clGrayText;
        end;  
      vsPreview:
        begin
          inherited GetContentParams(TcxCustomGridRecord(AData),
            GridView.Preview.Column, AParams);
          TextColor := DefaultPreviewTextColor;
        end;
    end;
end;

procedure TcxGridTableViewStyles.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TcxGridTableViewStyles then
    with TcxGridTableViewStyles(Source) do
    begin
      Self.FilterBox := FilterBox;
      Self.Footer := Footer;
      Self.Group := Group;
      Self.GroupByBox := GroupByBox;
      Self.Header := Header;
      Self.Indicator := Indicator;
      Self.NewItemRowInfoText := NewItemRowInfoText;
      Self.Preview := Preview;
      Self.OnGetFooterStyle := OnGetFooterStyle;
      Self.OnGetGroupStyle := OnGetGroupStyle;
      Self.OnGetHeaderStyle := OnGetHeaderStyle;
      Self.OnGetPreviewStyle := OnGetPreviewStyle;
    end;
end;

procedure TcxGridTableViewStyles.GetContentParams(ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AParams: TcxViewParams);
begin
  if (AItem <> nil) and TcxGridColumn(AItem).IsPreview then
    GetPreviewParams(ARecord, AItem, AParams)
  else
    inherited;
end;

procedure TcxGridTableViewStyles.GetFooterParams(ARecord: TcxCustomGridRecord;
  AItem: TcxGridColumn; out AParams: TcxViewParams);
var
  AStyle: TcxStyle;
begin
  AStyle := nil;
  if Assigned(FOnGetFooterStyle) then
    FOnGetFooterStyle(GridView, ARecord, AItem, AStyle);
  GetViewParams(vsFooter, ARecord, AStyle, AParams);
end;

procedure TcxGridTableViewStyles.GetGroupParams(ARecord: TcxCustomGridRecord;
  ALevel: Integer; out AParams: TcxViewParams);
var
  AStyle: TcxStyle;
begin
  AStyle := nil;
  if Assigned(FOnGetGroupStyle) then
  begin
    if ARecord <> nil then ALevel := ARecord.Level;
    FOnGetGroupStyle(GridView, ARecord, ALevel, AStyle);
  end;
  GetViewParams(vsGroup, ARecord, AStyle, AParams);
end;

procedure TcxGridTableViewStyles.GetHeaderParams(AItem: TcxGridColumn;
  out AParams: TcxViewParams);
var
  AStyle: TcxStyle;
begin
  AStyle := nil;
  if Assigned(FOnGetHeaderStyle) then
    FOnGetHeaderStyle(GridView, AItem, AStyle);
  GetViewParams(vsHeader, nil, AStyle, AParams);
end;

procedure TcxGridTableViewStyles.GetPreviewParams(ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AParams: TcxViewParams);
var
  AStyle: TcxStyle;
begin
  AStyle := nil;
  if Assigned(FOnGetPreviewStyle) then
    FOnGetPreviewStyle(GridView, ARecord, AItem, AStyle);
  GetViewParams(vsPreview, ARecord, AStyle, AParams);
end;

procedure TcxGridTableViewStyles.GetRecordContentParams(ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AParams: TcxViewParams);
begin
  if ARecord is TcxGridGroupRow then
    GetGroupParams(ARecord, -1, AParams)
  else
    inherited;
end;

{ TcxGridTableViewStyleSheet }

function TcxGridTableViewStyleSheet.GetStylesValue: TcxGridTableViewStyles;
begin
  Result := TcxGridTableViewStyles(GetStyles);
end;

procedure TcxGridTableViewStyleSheet.SetStylesValue(Value: TcxGridTableViewStyles);
begin
  SetStyles(Value);
end;

class function TcxGridTableViewStyleSheet.GetStylesClass: TcxCustomStylesClass;
begin
  Result := TcxGridTableViewStyles;
end;

{ TcxGridTableSummaryGroupItemLink }

function TcxGridTableSummaryGroupItemLink.GetColumn: TcxGridColumn;
begin
  Result := TcxGridColumn(ItemLink);
end;

procedure TcxGridTableSummaryGroupItemLink.SetColumn(Value: TcxGridColumn);
begin
  ItemLink := Value;
end;

function TcxGridTableSummaryGroupItemLink.QueryInterface(const IID: TGUID; out Obj): HResult;
const
  E_NOINTERFACE = HResult($80004002);
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TcxGridTableSummaryGroupItemLink._AddRef: Integer;
begin
  Result := -1;
end;

function TcxGridTableSummaryGroupItemLink._Release: Integer;
begin
  Result := -1;
end;

function TcxGridTableSummaryGroupItemLink.GetObjectName: string;
begin
  Result := '';
end;

function TcxGridTableSummaryGroupItemLink.GetProperties(AProperties: TStrings): Boolean;
begin
  AProperties.Add('Column');
  Result := True;
end;

procedure TcxGridTableSummaryGroupItemLink.GetPropertyValue(const AName: string;
  var AValue: Variant);
begin
  if AName = 'Column' then
    if Column <> nil then
      AValue := Column.Name
    else
      AValue := '';
end;

procedure TcxGridTableSummaryGroupItemLink.SetPropertyValue(const AName: string;
  const AValue: Variant);
var
  I: Integer;
begin
  if AName = 'Column' then
  begin
    Column := nil;
    with TcxCustomGridTableView((DataController as IcxCustomGridDataController).GridView) do
      for I := 0 to ItemCount - 1 do
        if Items[I].Name = AValue then
        begin
          Column := Items[I] as TcxGridColumn;
          Break;
        end;
  end;
end;

{ TcxGridTableSummaryItem }

function TcxGridTableSummaryItem.GetColumn: TcxGridColumn;
begin
  Result := TcxGridColumn(ItemLink);
end;

function TcxGridTableSummaryItem.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(TcxGridDataController(DataController).GridView);
end;

procedure TcxGridTableSummaryItem.SetColumn(Value: TcxGridColumn);
begin
  ItemLink := Value;
end;

function TcxGridTableSummaryItem.QueryInterface(const IID: TGUID; out Obj): HResult;
const
  E_NOINTERFACE = HResult($80004002);
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TcxGridTableSummaryItem._AddRef: Integer;
begin
  Result := -1;
end;

function TcxGridTableSummaryItem._Release: Integer;
begin
  Result := -1;
end;

function TcxGridTableSummaryItem.GetObjectName: string;
begin
  Result := '';
end;

function TcxGridTableSummaryItem.GetProperties(AProperties: TStrings): Boolean;
begin
  AProperties.Add('Column');
  Result := False;
end;

procedure TcxGridTableSummaryItem.GetPropertyValue(const AName: string; var AValue: Variant);
begin
  if AName = 'Column' then
    if Column <> nil then
      AValue := Column.GetObjectName
    else
      AValue := '';
end;

procedure TcxGridTableSummaryItem.SetPropertyValue(const AName: string; const AValue: Variant);
begin
  if AName = 'Column' then
    Column := TcxGridColumn(GridView.FindItemByObjectName(AValue));
end;

{ TcxGridTableView }

destructor TcxGridTableView.Destroy;
begin
  Controller.Customization := False;
  inherited;
end;

function TcxGridTableView.GetBackgroundBitmaps: TcxGridTableBackgroundBitmaps;
begin
  Result := TcxGridTableBackgroundBitmaps(inherited BackgroundBitmaps);
end;

function TcxGridTableView.GetColumn(Index: Integer): TcxGridColumn;
begin
  Result := TcxGridColumn(Items[Index]);
end;

function TcxGridTableView.GetColumnCount: Integer;
begin
  Result := ItemCount;
end;

function TcxGridTableView.GetController: TcxGridTableController;
begin
  Result := TcxGridTableController(inherited Controller);
end;

function TcxGridTableView.GetFiltering: TcxGridTableFiltering;
begin
  Result := TcxGridTableFiltering(inherited Filtering);
end;

function TcxGridTableView.GetGroupedColumn(Index: Integer): TcxGridColumn;
begin
  Result := TcxGridColumn(GroupedItems[Index]);
end;

function TcxGridTableView.GetGroupedColumnCount: Integer;
begin
  Result := GroupedItemCount;
end;

function TcxGridTableView.GetOptionsBehavior: TcxGridTableOptionsBehavior;
begin
  Result := TcxGridTableOptionsBehavior(inherited OptionsBehavior);
end;

function TcxGridTableView.GetOptionsCustomize: TcxGridTableOptionsCustomize;
begin
  Result := TcxGridTableOptionsCustomize(inherited OptionsCustomize);
end;

function TcxGridTableView.GetOptionsData: TcxGridTableOptionsData;
begin
  Result := TcxGridTableOptionsData(inherited OptionsData);
end;

function TcxGridTableView.GetOptionsSelection: TcxGridTableOptionsSelection;
begin
  Result := TcxGridTableOptionsSelection(inherited OptionsSelection);
end;

function TcxGridTableView.GetOptionsView: TcxGridTableOptionsView;
begin
  Result := TcxGridTableOptionsView(inherited OptionsView);
end;

function TcxGridTableView.GetPainter: TcxGridTablePainter;
begin
  Result := TcxGridTablePainter(inherited Painter);
end;

function TcxGridTableView.GetStyles: TcxGridTableViewStyles;
begin
  Result := TcxGridTableViewStyles(inherited Styles);
end;

function TcxGridTableView.GetViewData: TcxGridViewData;
begin
  Result := TcxGridViewData(inherited ViewData);
end;

function TcxGridTableView.GetViewInfo: TcxGridTableViewInfo;
begin
  Result := TcxGridTableViewInfo(inherited ViewInfo);
end;

function TcxGridTableView.GetViewInfoCache: TcxGridTableViewInfoCache;
begin
  Result := TcxGridTableViewInfoCache(inherited ViewInfoCache);
end;

function TcxGridTableView.GetVisibleColumn(Index: Integer): TcxGridColumn;
begin
  Result := TcxGridColumn(VisibleItems[Index]);
end;

function TcxGridTableView.GetVisibleColumnCount: Integer;
begin
  Result := VisibleItemCount;
end;

procedure TcxGridTableView.SetBackgroundBitmaps(Value: TcxGridTableBackgroundBitmaps);
begin
  inherited BackgroundBitmaps := Value;
end;

procedure TcxGridTableView.SetColumn(Index: Integer; Value: TcxGridColumn);
begin
  Items[Index] := Value;
end;

procedure TcxGridTableView.SetFiltering(Value: TcxGridTableFiltering);
begin
  inherited Filtering := Value;
end;

procedure TcxGridTableView.SetOptionsBehavior(Value: TcxGridTableOptionsBehavior);
begin
  inherited OptionsBehavior := Value;
end;

procedure TcxGridTableView.SetOptionsCustomize(Value: TcxGridTableOptionsCustomize);
begin
  inherited OptionsCustomize := Value;
end;

procedure TcxGridTableView.SetOptionsData(Value: TcxGridTableOptionsData);
begin
  inherited OptionsData := Value;
end;

procedure TcxGridTableView.SetOptionsSelection(Value: TcxGridTableOptionsSelection);
begin
  inherited OptionsSelection := Value;
end;

procedure TcxGridTableView.SetOptionsView(Value: TcxGridTableOptionsView);
begin
  inherited OptionsView := Value;
end;

procedure TcxGridTableView.SetPreview(Value: TcxGridPreview);
begin
  FPreview.Assign(Value);
end;

procedure TcxGridTableView.SetStyles(Value: TcxGridTableViewStyles);
begin
  inherited Styles := Value;
end;

function TcxGridTableView.GetProperties(AProperties: TStrings): Boolean;
begin
  with AProperties do
  begin
    Add('Footer');
    Add('GroupByBox');
    Add('GroupFooters');
    Add('NewItemRow');
  end;
  Result := inherited GetProperties(AProperties);
end;

procedure TcxGridTableView.GetPropertyValue(const AName: string; var AValue: Variant);
begin
  if AName = 'Footer' then
    AValue := OptionsView.Footer
  else
    if AName = 'GroupByBox' then
      AValue := OptionsView.GroupByBox
    else
      if AName = 'GroupFooters' then
        AValue := OptionsView.GroupFooters = gfVisibleWhenExpanded
      else
        if AName = 'NewItemRow' then
          AValue := OptionsView.NewItemRow
        else
          inherited;
end;

procedure TcxGridTableView.SetPropertyValue(const AName: string; const AValue: Variant);
begin
  if AName = 'Footer' then
    OptionsView.Footer := AValue
  else
    if AName = 'GroupByBox' then
      OptionsView.GroupByBox := AValue
    else
      if AName = 'GroupFooters' then
        if AValue then
          OptionsView.GroupFooters := gfVisibleWhenExpanded
        else
          OptionsView.GroupFooters := gfInvisible
      else
        if AName = 'NewItemRow' then
          OptionsView.NewItemRow := AValue
        else
          inherited;
end;

procedure TcxGridTableView.CreateOptions;
begin
  inherited;
  FPreview := GetPreviewClass.Create(Self);
end;

procedure TcxGridTableView.DestroyOptions;
begin
  FreeAndNil(FPreview);
  inherited;
end;

function TcxGridTableView.CanOffset(ARecordCountDelta: Integer): Boolean;
begin   {2}
  Result := inherited CanOffset(ARecordCountDelta) and not IsMaster;
end;

function TcxGridTableView.CanOffsetHorz: Boolean;
begin  
  Result := not TcxCustomGrid(Control).UpdateLocked and
    (not IsMaster or (GroupedColumnCount = 0));
end;

procedure TcxGridTableView.DoAssign(ASource: TcxCustomGridView);
begin
  if ASource is TcxGridTableView then
    with TcxGridTableView(ASource) do
    begin
      Self.OptionsCustomize := OptionsCustomize;
      Self.OnColumnHeaderClick := OnColumnHeaderClick;
      Self.OnColumnPosChanged := OnColumnPosChanged;
      Self.OnColumnSizeChanged := OnColumnSizeChanged;
      Self.OnCustomDrawColumnHeader := OnCustomDrawColumnHeader;
      Self.OnCustomDrawFooterCell := OnCustomDrawFooterCell;
      Self.OnCustomDrawGroupCell := OnCustomDrawGroupCell;
      Self.OnCustomDrawIndicatorCell := OnCustomDrawIndicatorCell;
      Self.OnCustomDrawPartBackground := OnCustomDrawPartBackground;
      Self.OnCustomization := OnCustomization;
      Self.OnLeftPosChanged := OnLeftPosChanged;
    end;
  inherited;
  if ASource is TcxGridTableView then
    Preview := TcxGridTableView(ASource).Preview;
end;

function TcxGridTableView.GetIsControlFocused: Boolean;
begin
  Result := inherited GetIsControlFocused or Controller.FilterPopup.Visible;
end;

function TcxGridTableView.GetResizeOnBoundsChange: Boolean;
begin
  Result := inherited GetResizeOnBoundsChange or
    OptionsView.ColumnAutoWidth or Preview.Active or IsMaster;
end;

function TcxGridTableView.HasCustomDrawColumnHeader: Boolean;
begin
  Result := Assigned(FOnCustomDrawColumnHeader);
end;

function TcxGridTableView.HasCustomDrawFooterCell: Boolean;
begin
  Result := Assigned(FOnCustomDrawFooterCell);
end;

function TcxGridTableView.HasCustomDrawGroupCell: Boolean;
begin
  Result := Assigned(FOnCustomDrawGroupCell);
end;

function TcxGridTableView.HasCustomDrawIndicatorCell: Boolean;
begin
  Result := Assigned(FOnCustomDrawIndicatorCell);
end;

function TcxGridTableView.HasCustomDrawPartBackground: Boolean;
begin
  Result := Assigned(FOnCustomDrawPartBackground);
end;

function TcxGridTableView.IsEqualHeightRecords: Boolean;
begin
  Result := inherited IsEqualHeightRecords and
    not ViewInfo.RecordsViewInfo.HasLastHorzGridLine(nil) and
    not Preview.Visible and (GroupedColumnCount = 0) and not IsMaster;
end;

procedure TcxGridTableView.LookAndFeelChanged;
begin
  inherited;
  RefreshCustomizationForm;
end;

function TcxGridTableView.GetControllerClass: TcxCustomGridControllerClass;
begin
  Result := TcxGridTableController;
end;

function TcxGridTableView.GetDataControllerClass: TcxCustomDataControllerClass;
begin
  Result := TcxGridDataController;
end;

function TcxGridTableView.GetPainterClass: TcxCustomGridPainterClass;
begin
  Result := TcxGridTablePainter;
end;

function TcxGridTableView.GetViewDataClass: TcxCustomGridViewDataClass;
begin
  Result := TcxGridViewData;
end;

function TcxGridTableView.GetViewInfoCacheClass: TcxCustomGridViewInfoCacheClass;
begin
  Result := TcxGridTableViewInfoCache; 
end;

function TcxGridTableView.GetViewInfoClass: TcxCustomGridViewInfoClass;
begin
  Result := TcxGridTableViewInfo;
end;

function TcxGridTableView.GetBackgroundBitmapsClass: TcxCustomGridBackgroundBitmapsClass;
begin
  Result := TcxGridTableBackgroundBitmaps;
end;

function TcxGridTableView.GetFilteringClass: TcxCustomGridTableFilteringClass;
begin
  Result := TcxGridTableFiltering;
end;

function TcxGridTableView.GetOptionsBehaviorClass: TcxCustomGridTableOptionsBehaviorClass;
begin
  Result := TcxGridTableOptionsBehavior;
end;

function TcxGridTableView.GetOptionsCustomizeClass: TcxCustomGridTableOptionsCustomizeClass;
begin
  Result := TcxGridTableOptionsCustomize;
end;

function TcxGridTableView.GetOptionsSelectionClass: TcxCustomGridOptionsSelectionClass;
begin
  Result := TcxGridTableOptionsSelection;
end;

function TcxGridTableView.GetOptionsViewClass: TcxCustomGridOptionsViewClass;
begin
  Result := TcxGridTableOptionsView;
end;

function TcxGridTableView.GetPreviewClass: TcxGridPreviewClass;
begin
  Result := TcxGridPreview;
end;

function TcxGridTableView.GetStylesClass: TcxCustomGridViewStylesClass;
begin
  Result := TcxGridTableViewStyles;
end;

function TcxGridTableView.GetSummaryGroupItemLinkClass: TcxDataSummaryGroupItemLinkClass;
begin
  Result := TcxGridTableSummaryGroupItemLink;
end;

function TcxGridTableView.GetSummaryItemClass: TcxDataSummaryItemClass;
begin
  Result := TcxGridTableSummaryItem;
end;

function TcxGridTableView.GetItemClass: TcxCustomGridTableItemClass;
begin
  Result := TcxGridColumn;
end;

procedure TcxGridTableView.ItemVisibilityChanged(AItem: TcxCustomGridTableItem;
  Value: Boolean);
begin
  inherited;
  RefreshCustomizationForm;
end;

procedure TcxGridTableView.RemoveItem(AItem: TcxCustomGridTableItem);
begin
  inherited;
  RefreshCustomizationForm;
end;

procedure TcxGridTableView.RefreshCustomizationForm;
begin
  Controller.RefreshCustomizationForm;
end;

procedure TcxGridTableView.DoColumnHeaderClick(AColumn: TcxGridColumn);
begin
  if Assigned(FOnColumnHeaderClick) then FOnColumnHeaderClick(Self, AColumn);
end;

procedure TcxGridTableView.DoColumnPosChanged(AColumn: TcxGridColumn);
begin
  if Assigned(FOnColumnPosChanged) then FOnColumnPosChanged(Self, AColumn);
end;

procedure TcxGridTableView.DoColumnSizeChanged(AColumn: TcxGridColumn);
begin
  if Assigned(FOnColumnSizeChanged) then FOnColumnSizeChanged(Self, AColumn);
end;

procedure TcxGridTableView.DoCustomDrawColumnHeader(ACanvas: TcxCanvas;
  AViewInfo: TcxGridColumnHeaderViewInfo; var ADone: Boolean);
begin
  if HasCustomDrawColumnHeader then
    FOnCustomDrawColumnHeader(Self, ACanvas, AViewInfo, ADone);
end;

procedure TcxGridTableView.DoCustomDrawFooterCell(ACanvas: TcxCanvas;
  AViewInfo: TcxGridColumnHeaderViewInfo; var ADone: Boolean);
begin
  if HasCustomDrawFooterCell then
    FOnCustomDrawFooterCell(Self, ACanvas, AViewInfo, ADone);
end;

procedure TcxGridTableView.DoCustomDrawGroupCell(ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
begin
  if HasCustomDrawGroupCell then
    FOnCustomDrawGroupCell(Self, ACanvas, AViewInfo, ADone);
end;

procedure TcxGridTableView.DoCustomDrawIndicatorCell(ACanvas: TcxCanvas;
  AViewInfo: TcxCustomGridIndicatorItemViewInfo; var ADone: Boolean);
begin
  if HasCustomDrawIndicatorCell then
    FOnCustomDrawIndicatorCell(Self, ACanvas, AViewInfo, ADone);
end;

procedure TcxGridTableView.DoCustomDrawPartBackground(ACanvas: TcxCanvas;
  AViewInfo: TcxCustomGridCellViewInfo; var ADone: Boolean);
begin
  if HasCustomDrawPartBackground then
    FOnCustomDrawPartBackground(Self, ACanvas, AViewInfo, ADone);
end;

procedure TcxGridTableView.DoCustomization;
begin
  if Assigned(FOnCustomization) then FOnCustomization(Self);
end;

procedure TcxGridTableView.DoLeftPosChanged;
begin
  if Assigned(FOnLeftPosChanged) then FOnLeftPosChanged(Self);
end;

function TcxGridTableView.CreateColumn: TcxGridColumn;
begin
  Result := TcxGridColumn(CreateItem);
end;

class function TcxGridTableView.CanBeLookupList: Boolean;
begin
  Result := True;
end;

initialization
  cxGridRegisteredViews.Register(TcxGridTableView, 'Table');
  Classes.RegisterClasses([TcxGridColumn, TcxGridTableViewStyleSheet]);

finalization
  cxGridRegisteredViews.Unregister(TcxGridTableView);

end.
