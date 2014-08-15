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

unit cxGridCardView;

{$I cxVer.inc}

interface

uses
{$IFDEF DELPHI6}
  Variants,
{$ENDIF}
  Windows, Classes, Graphics, Controls, Forms, StdCtrls,
  cxClasses, cxGraphics, cxControls, cxStyles,
  cxGridCommon, cxGrid, cxGridCustomView, cxGridCustomTableView,
  cxDataStorage, cxCustomData;

const
  cxGridDefaultCardBorderWidth = 2;
  cxGridDefaultCardViewCaptionSeparator = ':';
  cxGridDefaultCardViewSeparatorWidth = 2;
  cxGridDefaultCardWidth = 200;
  cxGridMinCardBorderWidth = 1;
  cxGridMinCardWidth = 40;

  htCardViewBase = htCustomGridTableBase + 50;
  htRowFilterButton = htCardViewBase + 1;
  htRowCaption = htCardViewBase + 2;
  htCardScrollButtonUp = htCardViewBase + 3;
  htCardScrollButtonDown = htCardViewBase + 4;
  htSeparator = htCardViewBase + 5;

  ckRows = 2;

  bbCardViewFirst = bbCustomTableLast + 1;
  bbCaptionRow = bbCardViewFirst;
  bbCardBorder = bbCardViewFirst + 1;
  bbRowCaption = bbCardViewFirst + 2;
  bbCardViewLast = bbRowCaption;

  isRowFirst = isCustomItemLast + 1;
  isCaptionRow = isRowFirst;
  isRowCaption = isRowFirst + 1;
  isRowLast = isRowCaption;

  vsCardViewFirst = vsCustomTableLast + 1;
  vsCaptionRow = vsCardViewFirst;
  vsCardBorder = vsCardViewFirst + 1;
  vsRowCaption = vsCardViewFirst + 2;
  vsCardViewLast = vsRowCaption;

type
  TcxGridCardViewController = class;
  TcxGridCard = class;
  TcxGridCardViewViewData = class;
  TcxGridCardRowFilterButtonViewInfo = class;
  TcxGridCardRowCaptionViewInfo = class;
  TcxGridCardRowViewInfo = class;
  TcxCustomGridCardScrollButtonViewInfo = class;
  TcxGridCardExpandButtonViewInfo = class;
  TcxGridCardViewInfo = class;
  TcxGridCardViewColumns = class;
  TcxGridCardsViewInfo = class;
  TcxGridCardViewSeparatorsViewInfo = class;
  TcxGridCardViewViewInfo = class;
  TcxGridCardViewInfoCacheItem = class;
  TcxGridCardViewRow = class;
  TcxGridCardView = class;

  TcxGridCardExpandButtonAlignment = (cebaLeft, cebaRight);
  TcxGridCardViewLayoutDirection = (ldHorizontal, ldVertical);

  { hit tests }

  TcxGridCardRowFilterButtonHitTest = class(TcxGridRecordCellHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  public
    class function CanClick: Boolean; override;
  end;

  TcxGridCardRowCellHitTest = class(TcxGridRecordCellHitTest)
  public
    function DragAndDropObjectClass: TcxCustomGridDragAndDropObjectClass; override;
  end;

  TcxGridCardRowCaptionHitTest = class(TcxGridCardRowCellHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  public
    RowContainerKind: TcxGridItemContainerKind;
  end;

  TcxGridCardScrollButtonDownHitTest = class(TcxGridRecordHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  public
    class function CanClick: Boolean; override;
  end;

  TcxGridCardScrollButtonUpHitTest = class(TcxGridRecordHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  public
    class function CanClick: Boolean; override;
  end;

  TcxGridCardViewSeparatorHitTest = class(TcxCustomGridHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  public
    Index: Integer;
    Separators: TcxGridCardViewSeparatorsViewInfo;
    function Cursor: TCursor; override;
    function DragAndDropObjectClass: TcxCustomGridDragAndDropObjectClass; override;
  end;

  { view data }

  TcxGridCard = class(TcxCustomGridRecord)
  private
    FExpanded: Boolean;
    function GetGridView: TcxGridCardView;
  protected
    procedure DoCollapse(ARecurse: Boolean); override;
    procedure DoExpand(ARecurse: Boolean); override;
    function GetExpandable: Boolean; override;
    function GetExpanded: Boolean; override;
    function GetHasCells: Boolean; override;
    function GetViewInfoCacheItemClass: TcxCustomGridViewInfoCacheItemClass; override;
    function GetViewInfoClass: TcxCustomGridRecordViewInfoClass; override;
  public
    constructor Create(AViewData: TcxCustomGridTableViewData; AIndex: Integer;
      const ARecordInfo: TcxRowInfo); override;
    procedure GetVisibleRows(ARows: TList);
    property GridView: TcxGridCardView read GetGridView;
  end;

  TcxGridCardViewViewData = class(TcxCustomGridTableViewData)
  private
    function GetCard(Index: Integer): TcxGridCard;
    function GetCardCount: Integer;
  protected
    function GetRecordClass(ARecordInfo: TcxRowInfo): TcxCustomGridRecordClass; override;
  public
    property CardCount: Integer read GetCardCount;
    property Cards[Index: Integer]: TcxGridCard read GetCard;
  end;

  { controller }

  // drag&drop objects

  TcxGridRowContainerZone = class(TcxGridItemContainerZone)
  public
    GridRecord: TcxCustomGridRecord;
    constructor Create(AGridRecord: TcxCustomGridRecord; AItemIndex: Integer); reintroduce;
    function IsEqual(Value: TcxGridItemContainerZone): Boolean; override;
  end;

  TcxGridCardRowMovingObjectClass = class of TcxGridCardRowMovingObject;

  TcxGridCardRowMovingObject = class(TcxCustomGridTableItemMovingObject)
  private
    FSourceGridRecord: TcxCustomGridRecord;
    function GetDestZone: TcxGridRowContainerZone;
    function GetGridView: TcxGridCardView;
    function GetSourceItem: TcxGridCardViewRow;
    function GetViewInfo: TcxGridCardViewViewInfo;
    procedure SetDestZone(Value: TcxGridRowContainerZone);
    procedure SetSourceItem(Value: TcxGridCardViewRow);
  protected
    function AreArrowsVertical: Boolean; override;
    procedure CalculateDestParams(AHitTest: TcxCustomGridHitTest;
      out AContainerKind: TcxGridItemContainerKind; out AZone: TcxGridItemContainerZone); override;
    function CanRemove: Boolean; override;
    procedure EndDragAndDrop(Accepted: Boolean); override;
    function GetArrowAreaBounds(APlace: TcxGridArrowPlace): TRect; override;
    function GetArrowsClientRect: TRect; override;
    function GetSourceItemViewInfo: TcxCustomGridCellViewInfo; override;
    function IsValidDestination: Boolean; override;
    property DestZone: TcxGridRowContainerZone read GetDestZone write SetDestZone;
    property GridView: TcxGridCardView read GetGridView;
    property SourceGridRecord: TcxCustomGridRecord read FSourceGridRecord write FSourceGridRecord;
    property SourceItem: TcxGridCardViewRow read GetSourceItem write SetSourceItem;
    property ViewInfo: TcxGridCardViewViewInfo read GetViewInfo;
  public
    procedure Init(const P: TPoint; AParams: TcxCustomGridHitTest); override;
  end;

  TcxGridCardSizingObject = class(TcxCustomGridDragAndDropObject)
  private
    FCardColumnIndex: Integer;
    FCardOriginalWidth: Integer;
    FDestPointX: Integer;
    FSeparators: TList;
    function GetGridView: TcxGridCardView;
    function GetSeparator(Index: Integer): TRect;
    function GetSeparatorCount: Integer;
    function GetViewInfo: TcxGridCardViewViewInfo;
    procedure SetDestPointX(Value: Integer);
  protected
    procedure DirtyChanged; override;
    function GetCurrentWidth: Integer; virtual;
    function GetDeltaWidth: Integer; virtual;
    function GetDragAndDropCursor(Accepted: Boolean): TCursor; override;
    function GetImmediateStart: Boolean; override;
    function GetOriginalWidth: Integer; virtual;

    procedure BeginDragAndDrop; override;
    procedure DragAndDrop(const P: TPoint; var Accepted: Boolean); override;
    procedure EndDragAndDrop(Accepted: Boolean); override;

    procedure AddSeparator(const R: TRect);
    procedure CalculateSeparators;
    procedure ClearSeparators;
    procedure DrawSeparators;
    property SeparatorCount: Integer read GetSeparatorCount;
    property Separators[Index: Integer]: TRect read GetSeparator;

    property CardColumnIndex: Integer read FCardColumnIndex;
    property CardOriginalWidth: Integer read FCardOriginalWidth
      write FCardOriginalWidth;
    property CurrentWidth: Integer read GetCurrentWidth;
    property DeltaWidth: Integer read GetDeltaWidth;
    property DestPointX: Integer read FDestPointX write SetDestPointX;
    property GridView: TcxGridCardView read GetGridView;
    property OriginalWidth: Integer read GetOriginalWidth;
    property ViewInfo: TcxGridCardViewViewInfo read GetViewInfo;
  public
    constructor Create(AControl: TcxControl); override;
    destructor Destroy; override;
    procedure Init(const P: TPoint; AParams: TcxCustomGridHitTest); override;
  end;

  // customization form

  TcxGridCardRowsListBox = class(TcxCustomGridTableItemsListBox)
  private
    function GetGridView: TcxGridCardView;
  protected
    function CalculateItemHeight: Integer; override;
    function GetDragAndDropParams: TcxCustomGridHitTest; override;
    property GridView: TcxGridCardView read GetGridView;
  public
    procedure PaintItem(ACanvas: TcxCanvas; R: TRect; AIndex: Integer; AFocused: Boolean); override;
    procedure RefreshItems; override;
  end;

  TcxGridCardViewCustomizationForm = class(TcxCustomGridTableCustomizationForm)
  protected
    function GetItemsListBoxClass: TcxCustomGridTableItemsListBoxClass; override;
    function GetItemsPageCaption: string; override;
  end;

  // controllers

  TcxGridCardViewControllerImplClass = class of TcxGridCardViewControllerImpl;

  TcxGridCardViewControllerImpl = class
  private
    FController: TcxGridCardViewController;
    function GetControl: TcxControl;
    function GetDataController: TcxCustomDataController;
    function GetScrollBarOffsetBegin: Integer;
    function GetScrollBarOffsetEnd: Integer;
    function GetViewData: TcxGridCardViewViewData;
    function GetViewInfo: TcxGridCardViewViewInfo;
  protected
    property Control: TcxControl read GetControl;
    property Controller: TcxGridCardViewController read FController;
    property DataController: TcxCustomDataController read GetDataController;
    property ScrollBarOffsetBegin: Integer read GetScrollBarOffsetBegin;
    property ScrollBarOffsetEnd: Integer read GetScrollBarOffsetEnd;
    property ViewData: TcxGridCardViewViewData read GetViewData;
    property ViewInfo: TcxGridCardViewViewInfo read GetViewInfo;
  public
    constructor Create(AController: TcxGridCardViewController); virtual;
    function GetIsRecordsScrollHorizontal: Boolean; virtual; abstract;
    function GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind; virtual; abstract;
    function GetScrollDelta: Integer; virtual; abstract;
    procedure InitScrollBarsParameters; virtual; abstract;
    procedure KeyDown(var Key: Word; Shift: TShiftState); dynamic;
  end;

  TcxGridCardViewControllerHorizontalImpl = class(TcxGridCardViewControllerImpl)
  public
    function GetIsRecordsScrollHorizontal: Boolean; override;
    function GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind; override;
    function GetScrollDelta: Integer; override;
    procedure InitScrollBarsParameters; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  end;

  TcxGridCardViewControllerVerticalImpl = class(TcxGridCardViewControllerImpl)
  public
    function GetIsRecordsScrollHorizontal: Boolean; override;
    function GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind; override;
    function GetScrollDelta: Integer; override;
    procedure InitScrollBarsParameters; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  end;

  TcxGridCardViewController = class(TcxCustomGridTableController)
  private
    FImplementationObject: TcxGridCardViewControllerImpl;
    FScrollCardViewInfo: TcxGridCardViewInfo;

    function GetCustomizationForm: TcxGridCardViewCustomizationForm;
    function GetFocusedCardViewInfo: TcxGridCardViewInfo;
    function GetFocusedItem: TcxGridCardViewRow;
    function GetGridView: TcxGridCardView;
    function GetScrollDelta: Integer;
    function GetTopCardIndex: Integer;
    function GetViewData: TcxGridCardViewViewData;
    function GetViewInfo: TcxGridCardViewViewInfo;
    procedure SetFocusedItem(Value: TcxGridCardViewRow);
    procedure SetScrollCardViewInfo(Value: TcxGridCardViewInfo);
    procedure SetTopCardIndex(Value: Integer);
    procedure CreateImplementationObject;
    procedure DestroyImplementationObject;
    function GetImplementationObjectClass: TcxGridCardViewControllerImplClass;
  protected
    function CanFocusNextItem(AFocusedItemIndex, ANextItemIndex: Integer;
      AGoForward, AGoOnCycle, AGoToNextRecordOnCycle: Boolean): Boolean; override;
    function GetDesignHitTest(AHitTest: TcxCustomGridHitTest): Boolean; override;
    function GetDragScrollInterval: Integer; override;
    function GetIsRecordsScrollHorizontal: Boolean; override;
    function GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind; override;
    function IsKeyForMultiSelect(AKey: Word; AShift: TShiftState;
      AFocusedRecordChanged: Boolean): Boolean; override;
    procedure ScrollData(ADirection: TcxDirection); override;

    // internal draganddrop data scrolling
    function CanScrollData(ADirection: TcxDirection): Boolean; override;
    function GetScrollDataTimeInterval(ADirection: TcxDirection): Integer; override;
    property ScrollCardViewInfo: TcxGridCardViewInfo read FScrollCardViewInfo write SetScrollCardViewInfo;

    // customization
    function GetCustomizationFormClass: TcxCustomGridCustomizationFormClass; override;
    function GetRowDragAndDropObjectClass: TcxGridCardRowMovingObjectClass; virtual;

    property FocusedCardViewInfo: TcxGridCardViewInfo read GetFocusedCardViewInfo;
    property ImplementationObject: TcxGridCardViewControllerImpl read FImplementationObject;
    property ScrollDelta: Integer read GetScrollDelta;
    property ViewData: TcxGridCardViewViewData read GetViewData;
    property ViewInfo: TcxGridCardViewViewInfo read GetViewInfo;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    destructor Destroy; override;
    procedure CheckScrolling(const P: TPoint); override;
    function IsDataFullyVisible(AIsCallFromMaster: Boolean = False): Boolean; override;
    procedure MakeItemVisible(AItem: TcxCustomGridTableItem); override;

    function CanScrollFocusedCard(ADown: Boolean): Boolean;
    function ScrollFocusedCard(ADown: Boolean): Boolean;

    procedure InitScrollBarsParameters; override;
    procedure Scroll(AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode;
      var AScrollPos: Integer); override;

    procedure KeyDown(var Key: Word; Shift: TShiftState); override;

    procedure LayoutDirectionChanged;

    property CustomizationForm: TcxGridCardViewCustomizationForm read GetCustomizationForm;
    property FocusedItem: TcxGridCardViewRow read GetFocusedItem write SetFocusedItem;
    property GridView: TcxGridCardView read GetGridView;
    property TopCardIndex: Integer read GetTopCardIndex write SetTopCardIndex;
  end;

  { painters }

  TcxGridCardRowFilterButtonPainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxGridCardRowFilterButtonViewInfo;
  protected
    procedure Paint; override;
    property ViewInfo: TcxGridCardRowFilterButtonViewInfo read GetViewInfo;
  end;

  TcxGridCardRowCaptionPainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxGridCardRowCaptionViewInfo;
  protected
    procedure DrawContent; override;
    property ViewInfo: TcxGridCardRowCaptionViewInfo read GetViewInfo;
  end;

  TcxGridCardRowPainterClass = class of TcxGridCardRowPainter;

  TcxGridCardRowPainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxGridCardRowViewInfo;
  protected
    procedure DrawFocusRect; virtual;
    procedure Paint; override;
    property ViewInfo: TcxGridCardRowViewInfo read GetViewInfo;
  end;

  TcxGridCardScrollButtonPainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxCustomGridCardScrollButtonViewInfo;
  protected
    procedure DrawContent; override;
    function ExcludeFromClipRect: Boolean; override;
    property ViewInfo: TcxCustomGridCardScrollButtonViewInfo read GetViewInfo;
  end;

  TcxGridCardExpandButtonPainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxGridCardExpandButtonViewInfo;
  protected
    procedure Paint; override;
    property ViewInfo: TcxGridCardExpandButtonViewInfo read GetViewInfo;
  end;

  TcxGridCardPainter = class(TcxCustomGridRecordPainter)
  private
    FClipRegion: TcxRegion;
    function GetViewInfo: TcxGridCardViewInfo;
  protected
    procedure AfterPaint; override;
    procedure BeforePaint; override;
    procedure DrawBackground; override;
    procedure DrawCardBorder; virtual;
    procedure DrawExpandButton; override;
    function DrawExpandButtonBeforePaint: Boolean; override;
    procedure DrawRows; virtual;
    procedure DrawScrollButtons; virtual;
    procedure Paint; override;
    property ViewInfo: TcxGridCardViewInfo read GetViewInfo;
  end;

  TcxGridCardViewPainter = class(TcxCustomGridTablePainter)
  protected
    procedure DrawBackground; override;
    procedure DrawSeparators; virtual;
    procedure PaintContent; override;
    function ViewInfo: TcxGridCardViewViewInfo; reintroduce;
  end;

  { view infos }

  // column and columns

  TcxGridCardViewColumn = class
  private
    FColumns: TcxGridCardViewColumns;
    FIndex: Integer;
    FRows: TList;
    function GetLastRow: TcxGridCardViewInfo;
    function GetRow(Index: Integer): TcxGridCardViewInfo;
    function GetRowCount: Integer;
    function GetVisibleRowCount: Integer;
    procedure SetRow(Index: Integer; Value: TcxGridCardViewInfo);
  public
    constructor Create(AColumns: TcxGridCardViewColumns; AIndex: Integer);
    destructor Destroy; override;
    function GetNearestRow(APos: Integer): TcxGridCardViewInfo;
    property Index: Integer read FIndex;
    property LastRow: TcxGridCardViewInfo read GetLastRow;
    property RowCount: Integer read GetRowCount;
    property Rows[Index: Integer]: TcxGridCardViewInfo read GetRow write SetRow; default;
    property VisibleRowCount: Integer read GetVisibleRowCount;
  end;

  TcxGridCardViewColumnsClass = class of TcxGridCardViewColumns;

  TcxGridCardViewColumns = class
  private
    FCardsViewInfo: TcxGridCardsViewInfo;
    FItems: TList;
    function GetCount: Integer;
    function GetItem(Index: Integer): TcxGridCardViewColumn;
    function GetLast: TcxGridCardViewColumn;
    function GetVisibleCount: Integer;
    procedure CreateItems;
    procedure DestroyItems;
  protected
    property CardsViewInfo: TcxGridCardsViewInfo read FCardsViewInfo;
  public
    constructor Create(ACardsViewInfo: TcxGridCardsViewInfo);
    destructor Destroy; override;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TcxGridCardViewColumn read GetItem; default;
    property Last: TcxGridCardViewColumn read GetLast;
    property VisibleCount: Integer read GetVisibleCount;
  end;

  // card's row

  TcxGridCardRowCellViewInfo = class(TcxGridTableDataCellViewInfo)
  private
    FRowViewInfo: TcxGridCardRowViewInfo;
    function GetCardViewInfo: TcxGridCardViewInfo;
    function GetGridView: TcxGridCardView;
    function GetGridRecord: TcxGridCard;
    function GetRow: TcxGridCardViewRow;
  protected
    function GetAreaBounds: TRect; override;
    function GetBackgroundBitmap: TBitmap; override;
    function GetMultiLine: Boolean; override;
    function GetTransparent: Boolean; override;
    function HasFocusRect: Boolean; override;
  public
    constructor Create(ARowViewInfo: TcxGridCardRowViewInfo); reintroduce; virtual;
    function MouseDown(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; override;
    property CardViewInfo: TcxGridCardViewInfo read GetCardViewInfo;
    property GridRecord: TcxGridCard read GetGridRecord;
    property GridView: TcxGridCardView read GetGridView;
    property Row: TcxGridCardViewRow read GetRow;
    property RowViewInfo: TcxGridCardRowViewInfo read FRowViewInfo;
  end;

  TcxGridCardRowFilterButtonViewInfoClass = class of TcxGridCardRowFilterButtonViewInfo;

  TcxGridCardRowFilterButtonViewInfo = class(TcxCustomGridViewCellViewInfo,
    IcxGridFilterPopupOwner)
  private
    FRowCaptionViewInfo: TcxGridCardRowCaptionViewInfo;
    function GetActive: Boolean;
    function GetDropDownWindowValue: TcxGridFilterPopup;
    function GetRow: TcxGridCardViewRow;
  protected
    { IcxGridFilterPopupOwner }
    function GetItem: TcxCustomGridTableItem;

    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetVisible: Boolean; override;
    function GetWidth: Integer; override;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); override;

    function DropDownWindowExists: Boolean; override;
    function GetDropDownWindow: TcxCustomGridPopup; override;
    function GetDropDownWindowOwnerBounds: TRect; override;
    property DropDownWindow: TcxGridFilterPopup read GetDropDownWindowValue;
  public
    constructor Create(ARowCaptionViewInfo: TcxGridCardRowCaptionViewInfo); reintroduce; virtual;
    property Active: Boolean read GetActive;
    property Row: TcxGridCardViewRow read GetRow;
    property RowCaptionViewInfo: TcxGridCardRowCaptionViewInfo read FRowCaptionViewInfo;
  end;

  TcxGridCardRowCaptionViewInfoClass = class of TcxGridCardRowCaptionViewInfo;

  TcxGridCardRowCaptionViewInfo = class(TcxGridCardRowCellViewInfo)
  private
    FFilterButtonViewInfo: TcxGridCardRowFilterButtonViewInfo;
  protected
    function CalculateRealWidth: Integer; virtual;
    function CalculateWidth: Integer; override;
    function CalculateHeight: Integer; override;
    function CanShowEdit: Boolean; override;
    function CanShowHint: Boolean; override;
    function GetAlignmentHorz: TAlignment; override;
    function GetAlignmentVert: TcxAlignmentVert; override;
    function GetAutoHeight: Boolean; override;
    function GetFilterButtonBounds: TRect; virtual;
    function GetFilterButtonViewInfoClass: TcxGridCardRowFilterButtonViewInfoClass; virtual;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetShowEndEllipsis: Boolean; override;
    function GetText: string; override;
    function GetTextAreaBounds: TRect; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function GetVisible: Boolean; override;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); override;
    function UseStandardNeedShowHint: Boolean; override;
    property FilterButtonBounds: TRect read GetFilterButtonBounds;
  public
    constructor Create(ARowViewInfo: TcxGridCardRowViewInfo); override;
    destructor Destroy; override;
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); override;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
    property FilterButtonViewInfo: TcxGridCardRowFilterButtonViewInfo read FFilterButtonViewInfo;
  end;

  TcxGridCardRowDataViewInfoClass = class of TcxGridCardRowDataViewInfo;

  TcxGridCardRowDataViewInfo = class(TcxGridCardRowCellViewInfo)
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function GetAutoHeight: Boolean; override;
    function GetText: string; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
  end;

  TcxGridCardRowViewInfoClass = class of TcxGridCardRowViewInfo;

  TcxGridCardRowViewInfo = class(TcxCustomGridViewCellViewInfo)
  private
    FCaptionViewInfo: TcxGridCardRowCaptionViewInfo;
    FCardViewInfo: TcxGridCardViewInfo;
    FDataViewInfo: TcxGridCardRowDataViewInfo;
    FHeight: Integer;
    FIndex: Integer;
    FPartVisible: Boolean;
    function GetCaptionWidth: Integer;
    function GetDataWidth: Integer;
    function GetGridView: TcxGridCardView;
    function GetGridRecord: TcxGridCard;
    function GetGridViewInfo: TcxGridCardViewViewInfo;
    function GetMaxHeight: Integer;
    function GetRow: TcxGridCardViewRow;
    procedure CreateViewInfos;
    procedure DestroyViewInfos;
  protected
    function CalculateCaptionWidth: Integer; virtual;
    function CalculateHeight: Integer; override;
    function CalculatePartVisible: Boolean; virtual;
    function CalculateVisible: Boolean; virtual;
    function CalculateWidth: Integer; override;
    function GetCaptionViewInfoClass: TcxGridCardRowCaptionViewInfoClass; virtual;
    function GetCellBackgroundBitmap(ACell: TcxGridCardRowCellViewInfo): TBitmap; virtual;
    function GetCellTransparent(ACell: TcxGridCardRowCellViewInfo): Boolean; virtual;
    function GetDataViewInfoClass: TcxGridCardRowDataViewInfoClass; virtual;
    function GetHeight: Integer; override;
    function GetHidden: Boolean; virtual;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetIsDesignSelected: Boolean; override;
    function GetIsVisibleForPainting: Boolean; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;

    procedure GetCaptionViewParams(var AParams: TcxViewParams); virtual; abstract;
    procedure GetDataViewParams(var AParams: TcxViewParams); virtual; abstract;

    property CaptionWidth: Integer read GetCaptionWidth;
    property DataWidth: Integer read GetDataWidth;
    property MaxHeight: Integer read GetMaxHeight;
  public
    constructor Create(ACardViewInfo: TcxGridCardViewInfo; AIndex: Integer); reintroduce; virtual;
    destructor Destroy; override;
    procedure BeforeRecalculation; override;
    procedure Calculate(const ABounds: TRect); override;
    procedure CalculateVisibles;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
    property CaptionViewInfo: TcxGridCardRowCaptionViewInfo read FCaptionViewInfo;
    property CardViewInfo: TcxGridCardViewInfo read FCardViewInfo;
    property DataViewInfo: TcxGridCardRowDataViewInfo read FDataViewInfo;
    property GridRecord: TcxGridCard read GetGridRecord;
    property GridView: TcxGridCardView read GetGridView;
    property GridViewInfo: TcxGridCardViewViewInfo read GetGridViewInfo;
    property Height: Integer read GetHeight write FHeight;
    property Hidden: Boolean read GetHidden;
    property Index: Integer read FIndex;
    property PartVisible: Boolean read FPartVisible;
    property Row: TcxGridCardViewRow read GetRow;
  end;

  TcxGridCardDataRowViewInfo = class(TcxGridCardRowViewInfo)
  protected
    procedure GetCaptionViewParams(var AParams: TcxViewParams); override;
    function GetCellBackgroundBitmap(ACell: TcxGridCardRowCellViewInfo): TBitmap; override;
    procedure GetDataViewParams(var AParams: TcxViewParams); override;
  end;

  TcxGridCardCaptionRowCaptionViewInfo = class(TcxGridCardRowCaptionViewInfo)
  protected
    function GetTextAreaBounds: TRect; override;
  end;

  TcxGridCardCaptionRowDataViewInfo = class(TcxGridCardRowDataViewInfo)
  protected
    procedure GetEditViewDataContentOffsets(var R: TRect); override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetTextAreaBounds: TRect; override;
  end;

  TcxGridCardCaptionRowViewInfo = class(TcxGridCardRowViewInfo)
  protected
    function GetCaptionViewInfoClass: TcxGridCardRowCaptionViewInfoClass; override;
    procedure GetCaptionViewParams(var AParams: TcxViewParams); override;
    function GetCellBackgroundBitmap(ACell: TcxGridCardRowCellViewInfo): TBitmap; override;
    function GetCellTransparent(ACell: TcxGridCardRowCellViewInfo): Boolean; override;
    function GetDataViewInfoClass: TcxGridCardRowDataViewInfoClass; override;
    procedure GetDataViewParams(var AParams: TcxViewParams); override;
    //procedure GetDefaultViewParams(var AParams: TcxViewParams); override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
  end;

  // cards

  TcxCustomGridCardScrollButtonViewInfo = class(TcxCustomGridViewCellViewInfo)
  private
    FCardViewInfo: TcxGridCardViewInfo;
    FScrollTimer: TcxTimer;
    procedure ScrollTimerHandler(Sender: TObject);
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function CaptureMouseOnPress: Boolean; override;
    function GetHotTrack: Boolean; override;
    function GetIsDownButton: Boolean; virtual; abstract;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); override;
    procedure Scroll; virtual; abstract;
    procedure StateChanged; override;

    procedure StartAutoScrolling;
    procedure StopAutoScrolling;
    property ScrollTimer: TcxTimer read FScrollTimer;
  public
    constructor Create(ACardViewInfo: TcxGridCardViewInfo); reintroduce; virtual;
    property IsDownButton: Boolean read GetIsDownButton;
    property CardViewInfo: TcxGridCardViewInfo read FCardViewInfo;
  end;

  TcxGridCardScrollButtonDownViewInfoClass = class of TcxGridCardScrollButtonDownViewInfo;

  TcxGridCardScrollButtonDownViewInfo = class(TcxCustomGridCardScrollButtonViewInfo)
  protected
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetIsDownButton: Boolean; override;
    function GetVisible: Boolean; override;
    procedure Scroll; override;
  end;

  TcxGridCardScrollButtonUpViewInfoClass = class of TcxGridCardScrollButtonUpViewInfo;

  TcxGridCardScrollButtonUpViewInfo = class(TcxCustomGridCardScrollButtonViewInfo)
  protected
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetIsDownButton: Boolean; override;
    function GetVisible: Boolean; override;
    procedure Scroll; override;
  end;

  TcxGridCardExpandButtonViewInfoClass = class of TcxGridCardExpandButtonViewInfo;

  TcxGridCardExpandButtonViewInfo = class(TcxCustomGridViewCellViewInfo)
  private
    FCardViewInfo: TcxGridCardViewInfo;
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function CaptureMouseOnPress: Boolean; override;
    procedure Click; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetHotTrack: Boolean; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetVisible: Boolean; override;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); override;
  public
    constructor Create(ACardViewInfo: TcxGridCardViewInfo); reintroduce; virtual;
    function HasPoint(const P: TPoint): Boolean; override;
    property CardViewInfo: TcxGridCardViewInfo read FCardViewInfo;
  end;

  TcxGridCardViewInfo = class(TcxCustomGridRecordViewInfo)
  private
    FCaptionWidth: Integer;
    FCol: Integer;
    FExpandButtonViewInfo: TcxGridCardExpandButtonViewInfo;
    FPartVisibleRowCount: Integer;
    FRow: Integer;
    FRowViewInfos: TList;
    FScrollButtonDown: TcxGridCardScrollButtonDownViewInfo;
    FScrollButtonUp: TcxGridCardScrollButtonUpViewInfo;
    FVisibleRowCount: Integer;
    FVisibleRowViewInfos: TList;
    function GetCacheItem: TcxGridCardViewInfoCacheItem;
    function GetCaptionWidth: Integer;
    function GetCardBorderWidth: Integer;
    function GetFirstCaptionRowViewInfo: TcxGridCardRowViewInfo;
    function GetGridView: TcxGridCardView;
    function GetGridRecord: TcxGridCard;
    function GetRecordsViewInfo: TcxGridCardsViewInfo;
    function GetRowViewInfo(Index: Integer): TcxGridCardRowViewInfo;
    function GetRowViewInfoCount: Integer;
    function GetTopRowIndex: Integer;
    function GetVisibleRowViewInfo(Index: Integer): TcxGridCardRowViewInfo;
    function GetVisibleRowViewInfoCount: Integer;
    procedure SetTopRowIndex(Value: Integer);
    procedure CreateRowViewInfos;
    procedure DestroyRowViewInfos;
    procedure CreateScrollButtons;
    procedure DestroyScrollButtons;
  protected
    function CalculateCaptionWidth: Integer; virtual;
    procedure CalculateExpandButtonBounds(var ABounds: TRect); override;
    function CalculateHeight: Integer; override;
    procedure CalculateVisibleRowViewInfosList;
    function CalculateWidth: Integer; override;
    function CanGenerateExpandButtonHitTest: Boolean; override;
    function GetAutoHeight: Boolean; override;
    function GetBackgroundBitmapBounds: TRect; override;
    function GetCardBorderBackgroundBitmap: TBitmap; virtual;
    function GetCardBorderColor: TColor; virtual;
    function GetContentBounds: TRect; override;
    function GetContentHeight: Integer; override;
    function GetContentWidth: Integer; override;
    function GetExpandButtonAlignment: TcxGridCardExpandButtonAlignment; virtual;
    function GetExpandButtonAreaBounds: TRect; override;
    function GetExpandButtonAreaWidth: Integer; virtual;
    function GetExpandButtonSize: Integer; virtual;
    function GetHeight: Integer; override;
    function GetMaxRowViewInfoHeight: Integer; virtual;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetRestSpaceBounds: TRect; virtual;
    function GetScrollableAreaBounds: TRect; virtual;
    function GetScrollButtonDownBounds: TRect; virtual;
    function GetScrollButtonDownViewInfoClass: TcxGridCardScrollButtonDownViewInfoClass; virtual;
    function GetScrollButtonUpViewInfoClass: TcxGridCardScrollButtonUpViewInfoClass; virtual;
    function GetScrollButtonHeight: Integer; virtual;
    function GetScrollButtonUpBounds: TRect; virtual;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function GetVisible: Boolean; override;
    function GetWidth: Integer; override;

    function GetExpandButtonViewInfoClass: TcxGridCardExpandButtonViewInfoClass; virtual;
    function GetRowViewInfoClass(ARow: TcxGridCardViewRow): TcxGridCardRowViewInfoClass; virtual;

    property CacheItem: TcxGridCardViewInfoCacheItem read GetCacheItem;
    property ExpandButtonAreaWidth: Integer read GetExpandButtonAreaWidth;
    property ExpandButtonSize: Integer read GetExpandButtonSize;
    property FirstCaptionRowViewInfo: TcxGridCardRowViewInfo read GetFirstCaptionRowViewInfo;
    property MaxRowViewInfoHeight: Integer read GetMaxRowViewInfoHeight;
    property ScrollButtonDownBounds: TRect read GetScrollButtonDownBounds;
    property ScrollButtonHeight: Integer read GetScrollButtonHeight;
    property ScrollButtonUpBounds: TRect read GetScrollButtonUpBounds;
  public
    constructor Create(ARecordsViewInfo: TcxCustomGridRecordsViewInfo;
      ARecord: TcxCustomGridRecord); override;
    destructor Destroy; override;
    procedure BeforeRecalculation; override;
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); override;
    function GetBoundsForItem(AItem: TcxCustomGridTableItem): TRect; override;
    function GetCellViewInfoByItem(AItem: TcxCustomGridTableItem): TcxGridTableDataCellViewInfo; override;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
    function IsFullyVisible: Boolean;
    procedure MainCalculate(ALeftBound, ATopBound: Integer); override;
    procedure MakeRowVisible(ARow: TcxGridCardViewRow); virtual;
    function NeedsScrollingDown: Boolean; virtual;
    function NeedsScrollingUp: Boolean; virtual;
    function VisibleRowViewInfoIndexOf(ARow: TcxGridCardViewRow): Integer; overload;
    function VisibleRowViewInfoIndexOf(ARowViewInfo: TcxGridCardRowViewInfo): Integer; overload;

    property CaptionWidth: Integer read GetCaptionWidth;
    property CardBorderBackgroundBitmap: TBitmap read GetCardBorderBackgroundBitmap;
    property CardBorderColor: TColor read GetCardBorderColor;
    property CardBorderWidth: Integer read GetCardBorderWidth;
    property Col: Integer read FCol;
    property ExpandButtonAlignment: TcxGridCardExpandButtonAlignment read GetExpandButtonAlignment;
    property ExpandButtonViewInfo: TcxGridCardExpandButtonViewInfo read FExpandButtonViewInfo;
    property GridView: TcxGridCardView read GetGridView;
    property GridRecord: TcxGridCard read GetGridRecord;
    property PartVisibleRowCount: Integer read FPartVisibleRowCount;
    property RecordsViewInfo: TcxGridCardsViewInfo read GetRecordsViewInfo;
    property RestSpaceBounds: TRect read GetRestSpaceBounds;
    property Row: Integer read FRow;
    property RowViewInfoCount: Integer read GetRowViewInfoCount;
    property RowViewInfos[Index: Integer]: TcxGridCardRowViewInfo read GetRowViewInfo;
    property ScrollableAreaBounds: TRect read GetScrollableAreaBounds;
    property ScrollButtonDown: TcxGridCardScrollButtonDownViewInfo read FScrollButtonDown;
    property ScrollButtonUp: TcxGridCardScrollButtonUpViewInfo read FScrollButtonUp;
    property TopRowIndex: Integer read GetTopRowIndex write SetTopRowIndex;
    property VisibleRowCount: Integer read FVisibleRowCount;
    property VisibleRowViewInfoCount: Integer read GetVisibleRowViewInfoCount;
    property VisibleRowViewInfos[Index: Integer]: TcxGridCardRowViewInfo read GetVisibleRowViewInfo;
  end;

  TcxGridCardsViewInfo = class(TcxCustomGridRecordsViewInfo)
  private
    FCardHeight: Integer;
    FColumns: TcxGridCardViewColumns;
    FMaxCardHeight: Integer;
    function GetCardBorderWidth: Integer;
    function GetCardWidth: Integer;
    function GetCardContentWidth: Integer;
    function GetGridContentBounds: TRect;
    function GetGridView: TcxGridCardView;
    function GetGridViewInfo: TcxGridCardViewViewInfo;
    function GetItem(Index: Integer): TcxGridCardViewInfo;
    function GetViewData: TcxGridCardViewViewData;
  protected
    FPartVisibleCount: Integer;
    procedure Calculate; override;
    function CalculateBounds: TRect; override;
    function CalculateCardHeight: Integer; virtual;
    function CalculateMaxCardHeight: Integer; virtual;
    function GetAutoDataCellHeight: Boolean; virtual;
    function GetAutoDataRecordHeight: Boolean; override;
    //procedure GetDataCellDefaultViewParams(ARecord: TcxCustomGridRecord;
    //  AItem: TcxCustomGridTableItem; var AParams: TcxViewParams); override;
    function GetItemLeftBound(AIndex: Integer): Integer; override;
    function GetItemsOffset(AItemCountDelta: Integer): Integer; override;
    function GetItemTopBound(AIndex: Integer): Integer; override;
    procedure OffsetItem(AIndex, AOffset: Integer); override;

    property GridContentBounds: TRect read GetGridContentBounds;
    property GridView: TcxGridCardView read GetGridView;
    property GridViewInfo: TcxGridCardViewViewInfo read GetGridViewInfo;
    property ViewData: TcxGridCardViewViewData read GetViewData;
  public
    CardRowHeights: array of Integer;
    constructor Create(AGridViewInfo: TcxCustomGridTableViewInfo); override;
    destructor Destroy; override;
    function GetRealItem(ARecord: TcxCustomGridRecord): TcxGridCardViewInfo; reintroduce; virtual;
    function GetZone(AHitTest: TcxCustomGridHitTest): TcxGridItemContainerZone; virtual;
    function UseCardHeight: Boolean; virtual;

    property AutoDataCellHeight: Boolean read GetAutoDataCellHeight;
    property CardBorderWidth: Integer read GetCardBorderWidth;
    property CardContentWidth: Integer read GetCardContentWidth;
    property CardHeight: Integer read FCardHeight;
    property CardWidth: Integer read GetCardWidth;
    property Columns: TcxGridCardViewColumns read FColumns;
    property Items[Index: Integer]: TcxGridCardViewInfo read GetItem; default;
    property MaxCardHeight: Integer read FMaxCardHeight;
    property PartVisibleCount: Integer read FPartVisibleCount;
  end;

  TcxGridCardsHorizontalViewInfo = class(TcxGridCardsViewInfo)
  protected
    procedure Calculate; override;
  end;

  TcxGridCardsVerticalViewInfo = class(TcxGridCardsViewInfo)
  protected
    procedure Calculate; override;
  end;

  // separators

  TcxGridCardViewSeparatorsViewInfoClass = class of TcxGridCardViewSeparatorsViewInfo;

  TcxGridCardViewSeparatorsViewInfo = class
  private
    FGridViewInfo: TcxGridCardViewViewInfo;
    FItems: TList;
    function GetColor: TColor;
    function GetCount: Integer;
    function GetGridView: TcxGridCardView;
    function GetItem(Index: Integer): TRect;
    function GetRecordsViewInfo: TcxGridCardsViewInfo;
    function GetWidth: Integer;
    procedure SetItem(Index: Integer; const Value: TRect);
    procedure CreateItems;
    procedure DestroyItems;
  protected
    function GetHitTestItem(Index: Integer): TRect; virtual; abstract;
    function GetHitTestItemCount: Integer; virtual; abstract;

    property GridView: TcxGridCardView read GetGridView;
    property GridViewInfo: TcxGridCardViewViewInfo read FGridViewInfo;
    property HitTestItemCount: Integer read GetHitTestItemCount;
    property HitTestItems[Index: Integer]: TRect read GetHitTestItem;
    property RecordsViewInfo: TcxGridCardsViewInfo read GetRecordsViewInfo;
  public
    constructor Create(AGridViewInfo: TcxGridCardViewViewInfo); virtual;
    destructor Destroy; override;
    procedure Calculate; virtual; abstract;
    function GetHitTest(const P: TPoint): TcxGridCardViewSeparatorHitTest; virtual;

    property Color: TColor read GetColor;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TRect read GetItem write SetItem; default;
    property Width: Integer read GetWidth;
  end;

  TcxGridCardViewSeparatorsHorizontalViewInfo = class(TcxGridCardViewSeparatorsViewInfo)
  protected
    function GetHitTestItem(Index: Integer): TRect; override;
    function GetHitTestItemCount: Integer; override;
  public
    procedure Calculate; override;
  end;

  TcxGridCardViewSeparatorsVerticalViewInfo = class(TcxGridCardViewSeparatorsViewInfo)
  protected
    function GetHitTestItem(Index: Integer): TRect; override;
    function GetHitTestItemCount: Integer; override;
  public
    procedure Calculate; override;
  end;

  // card view

  TcxGridCardViewViewInfo = class(TcxCustomGridTableViewInfo)
  private
    FPrevCardHeight: Integer;
    FSeparatorsViewInfo: TcxGridCardViewSeparatorsViewInfo;
    function GetController: TcxGridCardViewController;
    function GetGridView: TcxGridCardView;
    function GetRecordsViewInfo: TcxGridCardsViewInfo;
    function GetViewData: TcxGridCardViewViewData;
  protected
    procedure CreateViewInfos; override;
    procedure DestroyViewInfos(AIsRecreating: Boolean); override;

    procedure AfterCalculating; override;
    procedure BeforeCalculating; override;
    procedure Calculate; override;
    procedure CalculateHeight(const AMaxSize: TPoint; var AHeight: Integer;
      var AFullyVisible: Boolean); override;
    procedure CalculateWidth(const AMaxSize: TPoint; var AWidth: Integer); override;
    function DoGetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
    function GetDefaultGridModeBufferCount: Integer; override;
    function GetScrollableAreaBoundsForEdit: TRect; override;

    function GetRecordsViewInfoClass: TcxCustomGridRecordsViewInfoClass; override;
    function GetSeparatorsViewInfoClass: TcxGridCardViewSeparatorsViewInfoClass; virtual;

    property Controller: TcxGridCardViewController read GetController;
    property GridView: TcxGridCardView read GetGridView;
    property ViewData: TcxGridCardViewViewData read GetViewData;
  public
    function CanOffsetView(ARecordCountDelta: Integer): Boolean; override;
    property RecordsViewInfo: TcxGridCardsViewInfo read GetRecordsViewInfo;
    property SeparatorsViewInfo: TcxGridCardViewSeparatorsViewInfo read FSeparatorsViewInfo;
  end;

  // cache

  TcxGridCardViewInfoCacheItem = class(TcxCustomGridTableViewInfoCacheItem)
  private
    FTopRowIndex: Integer;
    FIsTopRowIndexAssigned: Boolean;
    procedure SetTopRowIndex(Value: Integer);
  public
    procedure UnassignValues(AKeepMaster: Boolean); override;
    property TopRowIndex: Integer read FTopRowIndex write SetTopRowIndex;
    property IsTopRowIndexAssigned: Boolean read FIsTopRowIndexAssigned write FIsTopRowIndexAssigned;
  end;

  { view }

  TcxGridCardViewRowOptions = class(TcxCustomGridTableItemOptions)
  private
    FShowCaption: Boolean;
    procedure SetShowCaption(Value: Boolean);
  public
    constructor Create(AItem: TcxCustomGridTableItem); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Moving;
    property ShowCaption: Boolean read FShowCaption write SetShowCaption default True;
  end;

  TcxGridCardViewRowStyles = class(TcxCustomGridTableItemStyles)
  private
    FOnGetCaptionRowStyle: TcxGridGetCellStyleEvent;
    FOnGetCaptionStyle: TcxGridGetCellStyleEvent;
    function GetGridViewValue: TcxGridCardView;
    function GetItem: TcxGridCardViewRow;
    procedure SetOnGetCaptionRowStyle(Value: TcxGridGetCellStyleEvent);
    procedure SetOnGetCaptionStyle(Value: TcxGridGetCellStyleEvent);
  protected
    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure GetCaptionParams(ARecord: TcxCustomGridRecord; out AParams: TcxViewParams); virtual;
    procedure GetCaptionRowParams(ARecord: TcxCustomGridRecord; out AParams: TcxViewParams); virtual;
    property GridView: TcxGridCardView read GetGridViewValue;
    property Item: TcxGridCardViewRow read GetItem;
  published
    property Caption: TcxStyle index isRowCaption read GetValue write SetValue;
    property CaptionRow: TcxStyle index isCaptionRow read GetValue write SetValue;
    property OnGetCaptionRowStyle: TcxGridGetCellStyleEvent read FOnGetCaptionRowStyle
      write SetOnGetCaptionRowStyle;
    property OnGetCaptionStyle: TcxGridGetCellStyleEvent read FOnGetCaptionStyle
      write SetOnGetCaptionStyle;
  end;

  TcxGridCardViewRowKind = (rkData, rkCaption);

  TcxGridCardViewRow = class(TcxCustomGridTableItem)
  private
    FKind: TcxGridCardViewRowKind;
    function GetCaptionAlignmentHorz: TAlignment;
    function GetCaptionAlignmentVert: TcxAlignmentVert;
    function GetGridView: TcxGridCardView;
    function GetOptions: TcxGridCardViewRowOptions;
    function GetStyles: TcxGridCardViewRowStyles;
    procedure SetCaptionAlignmentHorz(Value: TAlignment);
    procedure SetCaptionAlignmentVert(Value: TcxAlignmentVert);
    procedure SetKind(Value: TcxGridCardViewRowKind);
    procedure SetOptions(Value: TcxGridCardViewRowOptions);
    procedure SetStyles(Value: TcxGridCardViewRowStyles);
    function IsCaptionAlignmentHorzStored: Boolean;
    function IsCaptionAlignmentVertStored: Boolean;
  protected
    function CanFocus(ARecord: TcxCustomGridRecord): Boolean; override;
    procedure CheckHeight(var AHeight: Integer); virtual;
    function DefaultWidth: Integer; override;
    function GetVisibleCaption: string; override;

    function GetOptionsClass: TcxCustomGridTableItemOptionsClass; override;
    function GetStylesClass: TcxCustomGridTableItemStylesClass; override;

    property GridView: TcxGridCardView read GetGridView;
  public
    procedure Assign(Source: TPersistent); override;
    function HasCardExpandButton: Boolean; virtual;
    function IsVisibleInCard(ACard: TcxGridCard): Boolean; virtual;
  published
    property CaptionAlignmentHorz: TAlignment read GetCaptionAlignmentHorz
      write SetCaptionAlignmentHorz stored IsCaptionAlignmentHorzStored;
    property CaptionAlignmentVert: TcxAlignmentVert read GetCaptionAlignmentVert
      write SetCaptionAlignmentVert stored IsCaptionAlignmentVertStored;
    property Hidden;
    property Kind: TcxGridCardViewRowKind read FKind write SetKind default rkData;
    property Options: TcxGridCardViewRowOptions read GetOptions write SetOptions;
    property SortIndex;
    property SortOrder;
    property Styles: TcxGridCardViewRowStyles read GetStyles write SetStyles;
  end;

  // options

  TcxGridCardViewBackgroundBitmaps = class(TcxCustomGridTableBackgroundBitmaps)
  protected
    function GetBitmapStyleIndex(Index: Integer): Integer; override;
  public
    procedure Assign(Source: TPersistent); override;
    function GetBitmap(Index: Integer): TBitmap; override;
  published
    property CaptionRow: TBitmap index bbCaptionRow read GetValue write SetValue;
    property CardBorder: TBitmap index bbCardBorder read GetValue write SetValue;
    property RowCaption: TBitmap index bbRowCaption read GetValue write SetValue;
  end;

  TcxGridCardViewFiltering = class(TcxCustomGridTableFiltering)
  private
    function GetRowMRUItemsList: Boolean;
    function GetRowMRUItemsListCount: Integer;
    function GetRowPopupDropDownWidth: Integer;
    function GetRowPopupMaxDropDownItemCount: Integer;
    procedure SetRowMRUItemsList(Value: Boolean);
    procedure SetRowMRUItemsListCount(Value: Integer);
    procedure SetRowPopupDropDownWidth(Value: Integer);
    procedure SetRowPopupMaxDropDownItemCount(Value: Integer);
  public  
    // obsolete - use RowPopupDropDownWidth
    property DropDownWidth;
    // obsolete - use RowPopupMaxDropDownItemCount
    property MaxDropDownCount;
  published
    property RowMRUItemsList: Boolean read GetRowMRUItemsList write SetRowMRUItemsList default True;
    property RowMRUItemsListCount: Integer read GetRowMRUItemsListCount
      write SetRowMRUItemsListCount default cxGridFilterDefaultItemMRUItemsListCount;
    property RowPopupDropDownWidth: Integer read GetRowPopupDropDownWidth
      write SetRowPopupDropDownWidth default 0;
    property RowPopupMaxDropDownItemCount: Integer read GetRowPopupMaxDropDownItemCount
      write SetRowPopupMaxDropDownItemCount default cxGridFilterDefaultItemPopupMaxDropDownItemCount;
  end;

  TcxGridCardViewOptionsBehavior = class(TcxCustomGridTableOptionsBehavior)
  private
    FRowCaptionHints: Boolean;
    procedure SetRowCaptionHints(Value: Boolean);
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    procedure Assign(Source: TPersistent); override;
  published
    property PullFocusing;
    property RowCaptionHints: Boolean read FRowCaptionHints write SetRowCaptionHints default True;
  end;

  TcxGridCardViewOptionsCustomize = class(TcxCustomGridTableOptionsCustomize)
  private
    FCardExpanding: Boolean;
    FCardSizing: Boolean;
    function GetGridView: TcxGridCardView;
    function GetRowFiltering: Boolean;
    function GetRowHiding: Boolean;
    function GetRowMoving: Boolean;
    procedure SetCardExpanding(Value: Boolean);
    procedure SetCardSizing(Value: Boolean);
    procedure SetRowFiltering(Value: Boolean);
    procedure SetRowHiding(Value: Boolean);
    procedure SetRowMoving(Value: Boolean);
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    procedure Assign(Source: TPersistent); override;
    property GridView: TcxGridCardView read GetGridView;
  published
    property CardExpanding: Boolean read FCardExpanding write SetCardExpanding default False;
    property CardSizing: Boolean read FCardSizing write SetCardSizing default True;
    property RowFiltering: Boolean read GetRowFiltering write SetRowFiltering default True;
    property RowHiding: Boolean read GetRowHiding write SetRowHiding default False;
    property RowMoving: Boolean read GetRowMoving write SetRowMoving default False;
  end;

  TcxGridCardViewOptionsData = class(TcxCustomGridTableOptionsData);

  TcxGridCardViewOptionsSelection = class(TcxCustomGridTableOptionsSelection);

  TcxGridCardViewOptionsView = class(TcxCustomGridTableOptionsView)
  private
    FCaptionSeparator: Char;
    FCaptionWidth: Integer;
    FCardBorderWidth: Integer;
    FCardExpandButtonAlignment: TcxGridCardExpandButtonAlignment;
    FCardWidth: Integer;
    FEmptyRows: Boolean;
    FSeparatorColor: TColor;
    FSeparatorWidth: Integer;
    function GetRowCaptionAutoHeight: Boolean;
    function GetRowCaptionEndEllipsis: Boolean;
    procedure SetCaptionSeparator(Value: Char);
    procedure SetCaptionWidth(Value: Integer);
    procedure SetCardBorderWidth(Value: Integer);
    procedure SetCardExpandButtonAlignment(Value: TcxGridCardExpandButtonAlignment);
    procedure SetCardWidth(Value: Integer);
    procedure SetEmptyRows(Value: Boolean);
    procedure SetRowCaptionAutoHeight(Value: Boolean);
    procedure SetRowCaptionEndEllipsis(Value: Boolean);
    procedure SetSeparatorColor(Value: TColor);
    procedure SetSeparatorWidth(Value: Integer);
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    procedure Assign(Source: TPersistent); override;
    function GetSeparatorColor: TColor;
  published
    property CaptionSeparator: Char read FCaptionSeparator write SetCaptionSeparator default cxGridDefaultCardViewCaptionSeparator;
    property CaptionWidth: Integer read FCaptionWidth write SetCaptionWidth default 0;
    property CardBorderWidth: Integer read FCardBorderWidth write SetCardBorderWidth
      default cxGridDefaultCardBorderWidth;
    property CardExpandButtonAlignment: TcxGridCardExpandButtonAlignment read FCardExpandButtonAlignment
      write SetCardExpandButtonAlignment default cebaRight;
    property CardWidth: Integer read FCardWidth write SetCardWidth default cxGridDefaultCardWidth;
    property CellAutoHeight;
    property CellTextMaxLineCount;
    property EmptyRows: Boolean read FEmptyRows write SetEmptyRows default True;
    property RowCaptionAutoHeight: Boolean read GetRowCaptionAutoHeight
      write SetRowCaptionAutoHeight default False;
    property RowCaptionEndEllipsis: Boolean read GetRowCaptionEndEllipsis write
      SetRowCaptionEndEllipsis default False;
    property SeparatorColor: TColor read FSeparatorColor write SetSeparatorColor default clDefault;
    property SeparatorWidth: Integer read FSeparatorWidth write SetSeparatorWidth
      default cxGridDefaultCardViewSeparatorWidth;
  end;

  // styles

  TcxGridCardViewStyles = class(TcxCustomGridTableViewStyles)
  private
    FOnGetCaptionRowStyle: TcxGridGetCellStyleEvent;
    FOnGetCardBorderStyle: TcxGridGetRecordStyleEvent;
    FOnGetRowCaptionStyle: TcxGridGetCellStyleEvent;
    procedure SetOnGetCaptionRowStyle(Value: TcxGridGetCellStyleEvent);
    procedure SetOnGetCardBorderStyle(Value: TcxGridGetRecordStyleEvent);
    procedure SetOnGetRowCaptionStyle(Value: TcxGridGetCellStyleEvent);
  protected
    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure GetCaptionRowParams(ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      out AParams: TcxViewParams); virtual;
    procedure GetCardBorderParams(ARecord: TcxCustomGridRecord; out AParams: TcxViewParams); virtual;
    procedure GetDataCellContentParams(ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      out AParams: TcxViewParams); override;
    procedure GetRowCaptionParams(ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      out AParams: TcxViewParams); virtual;
  published
    property CaptionRow: TcxStyle index vsCaptionRow read GetValue write SetValue;
    property CardBorder: TcxStyle index vsCardBorder read GetValue write SetValue;
    property RowCaption: TcxStyle index vsRowCaption read GetValue write SetValue;
    property StyleSheet;
    property OnGetCaptionRowStyle: TcxGridGetCellStyleEvent read FOnGetCaptionRowStyle
      write SetOnGetCaptionRowStyle;
    property OnGetCardBorderStyle: TcxGridGetRecordStyleEvent read FOnGetCardBorderStyle
      write SetOnGetCardBorderStyle;
    property OnGetRowCaptionStyle: TcxGridGetCellStyleEvent read FOnGetRowCaptionStyle
      write SetOnGetRowCaptionStyle;
  end;

  TcxGridCardViewStyleSheet = class(TcxCustomStyleSheet)
  private
    function GetStylesValue: TcxGridCardViewStyles;
    procedure SetStylesValue(Value: TcxGridCardViewStyles);
  public
    class function GetStylesClass: TcxCustomStylesClass; override;
  published
    property Styles: TcxGridCardViewStyles read GetStylesValue write SetStylesValue;
  end;

  // view

  TcxGridCardRowEvent = procedure(Sender: TcxGridCardView; ARow: TcxGridCardViewRow) of object;

  TcxGridCardView = class(TcxCustomGridTableView)
  private
    FLayoutDirection: TcxGridCardViewLayoutDirection;
    FOnRowPosChanged: TcxGridCardRowEvent;
    function GetBackgroundBitmaps: TcxGridCardViewBackgroundBitmaps;
    function GetControl: TcxCustomGrid;
    function GetController: TcxGridCardViewController;
    function GetDataController: TcxGridDataController;
    function GetFiltering: TcxGridCardViewFiltering;
    function GetFirstCaptionRow: TcxGridCardViewRow;
    function GetOptionsBehavior: TcxGridCardViewOptionsBehavior;
    function GetOptionsCustomize: TcxGridCardViewOptionsCustomize;
    function GetOptionsData: TcxGridCardViewOptionsData;
    function GetOptionsSelection: TcxGridCardViewOptionsSelection;
    function GetOptionsView: TcxGridCardViewOptionsView;
    function GetPainter: TcxGridCardViewPainter;
    function GetRow(Index: Integer): TcxGridCardViewRow;
    function GetRowCount: Integer;
    function GetStyles: TcxGridCardViewStyles;
    function GetViewData: TcxGridCardViewViewData;
    function GetViewInfo: TcxGridCardViewViewInfo;
    function GetVisibleRow(Index: Integer): TcxGridCardViewRow;
    function GetVisibleRowCount: Integer;
    procedure SetBackgroundBitmaps(Value: TcxGridCardViewBackgroundBitmaps);
    procedure SetDataController(Value: TcxGridDataController);
    procedure SetFiltering(Value: TcxGridCardViewFiltering);
    procedure SetLayoutDirection(Value: TcxGridCardViewLayoutDirection);
    procedure SetOnRowPosChanged(Value: TcxGridCardRowEvent);
    procedure SetOptionsBehavior(Value: TcxGridCardViewOptionsBehavior);
    procedure SetOptionsCustomize(Value: TcxGridCardViewOptionsCustomize);
    procedure SetOptionsData(Value: TcxGridCardViewOptionsData);
    procedure SetOptionsSelection(Value: TcxGridCardViewOptionsSelection);
    procedure SetOptionsView(Value: TcxGridCardViewOptionsView);
    procedure SetRow(Index: Integer; Value: TcxGridCardViewRow);
    procedure SetStyles(Value: TcxGridCardViewStyles);
  protected
    // IcxStoredObject
    function GetProperties(AProperties: TStrings): Boolean; override;
    procedure GetPropertyValue(const AName: string; var AValue: Variant); override;
    procedure SetPropertyValue(const AName: string; const AValue: Variant); override;
    // IcxGridViewLayoutEditorSupport - for design-time layout editor
    procedure AssignLayout(ALayoutView: TcxCustomGridView); override;
    function GetLayoutCustomizationFormButtonCaption: string; override;

    procedure DoAssign(ASource: TcxCustomGridView); override;
    function GetResizeOnBoundsChange: Boolean; override;
    procedure RecordChanged(ARecordIndex: Integer); override;

    function GetBackgroundBitmapsClass: TcxCustomGridBackgroundBitmapsClass; override;
    function GetFilteringClass: TcxCustomGridTableFilteringClass; override;
    function GetItemClass: TcxCustomGridTableItemClass; override;
    function GetOptionsBehaviorClass: TcxCustomGridOptionsBehaviorClass; override;
    function GetOptionsCustomizeClass: TcxCustomGridTableOptionsCustomizeClass; override;
    function GetOptionsDataClass: TcxCustomGridOptionsDataClass; override;
    function GetOptionsSelectionClass: TcxCustomGridOptionsSelectionClass; override;
    function GetOptionsViewClass: TcxCustomGridOptionsViewClass; override;
    function GetStylesClass: TcxCustomGridViewStylesClass; override;

    function GetControllerClass: TcxCustomGridControllerClass; override;
    function GetDataControllerClass: TcxCustomDataControllerClass; override;
    function GetPainterClass: TcxCustomGridPainterClass; override;
    function GetViewDataClass: TcxCustomGridViewDataClass; override;
    function GetViewInfoClass: TcxCustomGridViewInfoClass; override;

    function CanCardSizing: Boolean; virtual;

    procedure DoRowPositionChanged(ARow: TcxGridCardViewRow); virtual;

    property FirstCaptionRow: TcxGridCardViewRow read GetFirstCaptionRow;
  public
    function CreateRow: TcxGridCardViewRow;

    property Control: TcxCustomGrid read GetControl;
    property Controller: TcxGridCardViewController read GetController;
    property Painter: TcxGridCardViewPainter read GetPainter;
    property RowCount: Integer read GetRowCount;
    property Rows[Index: Integer]: TcxGridCardViewRow read GetRow write SetRow;
    property ViewData: TcxGridCardViewViewData read GetViewData;
    property ViewInfo: TcxGridCardViewViewInfo read GetViewInfo;
    property VisibleRowCount: Integer read GetVisibleRowCount;
    property VisibleRows[Index: Integer]: TcxGridCardViewRow read GetVisibleRow;
  published
    property BackgroundBitmaps: TcxGridCardViewBackgroundBitmaps read GetBackgroundBitmaps write
      SetBackgroundBitmaps;
    property DataController: TcxGridDataController read GetDataController
      write SetDataController;
    property Filtering: TcxGridCardViewFiltering read GetFiltering write SetFiltering;
    property LayoutDirection: TcxGridCardViewLayoutDirection read FLayoutDirection
      write SetLayoutDirection default ldHorizontal;
    property OptionsBehavior: TcxGridCardViewOptionsBehavior read GetOptionsBehavior
      write SetOptionsBehavior;
    property OptionsCustomize: TcxGridCardViewOptionsCustomize read GetOptionsCustomize
      write SetOptionsCustomize;
    property OptionsData: TcxGridCardViewOptionsData read GetOptionsData write SetOptionsData;
    property OptionsSelection: TcxGridCardViewOptionsSelection read GetOptionsSelection
      write SetOptionsSelection;
    property OptionsView: TcxGridCardViewOptionsView read GetOptionsView write SetOptionsView;
    property Styles: TcxGridCardViewStyles read GetStyles write SetStyles;
    property OnCustomization;
    property OnFilterControlDialogShow;
    property OnFilterCustomization;
    property OnFilterDialogShow;
    property OnRowPosChanged: TcxGridCardRowEvent read FOnRowPosChanged write SetOnRowPosChanged;
  end;

implementation

uses
  SysUtils, Math, cxLookAndFeelPainters, cxScrollBar, cxGridStrs;

const
  CardIndent = 7;
  CardDataIndent = 2;
  CardExpandButtonOffset = 5;
  SeparatorSizingZone = 7;
  SeparatorSizingAddZone = 3;

  CardScrollingInterval = 300;

{ TcxGridCardRowFilterButtonHitTest }

class function TcxGridCardRowFilterButtonHitTest.GetHitTestCode: Integer;
begin
  Result := htRowFilterButton;
end;

class function TcxGridCardRowFilterButtonHitTest.CanClick: Boolean;
begin
  Result := False;
end;

{ TcxGridCardRowCellHitTest }

function TcxGridCardRowCellHitTest.DragAndDropObjectClass: TcxCustomGridDragAndDropObjectClass;
begin
  if TcxGridCardViewRow(Item).CanMove then
    Result := TcxGridCardView(GridView).Controller.GetRowDragAndDropObjectClass
  else
    Result := nil;
end;

{ TcxGridCardRowCaptionHitTest }

class function TcxGridCardRowCaptionHitTest.GetHitTestCode: Integer;
begin
  Result := htRowCaption;
end;

{ TcxGridCardScrollButtonDownHitTest }

class function TcxGridCardScrollButtonDownHitTest.GetHitTestCode: Integer;
begin
  Result := htCardScrollButtonDown;
end;

class function TcxGridCardScrollButtonDownHitTest.CanClick: Boolean;
begin
  Result := False;
end;

{ TcxGridCardScrollButtonUpHitTest }

class function TcxGridCardScrollButtonUpHitTest.GetHitTestCode: Integer;
begin
  Result := htCardScrollButtonUp;
end;

class function TcxGridCardScrollButtonUpHitTest.CanClick: Boolean;
begin
  Result := False;
end;

{ TcxGridCardViewSeparatorHitTest }

class function TcxGridCardViewSeparatorHitTest.GetHitTestCode: Integer;
begin
  Result := htSeparator;
end;

function TcxGridCardViewSeparatorHitTest.Cursor: TCursor;
begin
  Result := crSizeWE;
end;

function TcxGridCardViewSeparatorHitTest.DragAndDropObjectClass: TcxCustomGridDragAndDropObjectClass;
begin
  Result := TcxGridCardSizingObject;
end;

{ TcxGridCard }

constructor TcxGridCard.Create(AViewData: TcxCustomGridTableViewData; AIndex: Integer;
  const ARecordInfo: TcxRowInfo);
begin
  inherited;
  FExpanded := True;
end;

function TcxGridCard.GetGridView: TcxGridCardView;
begin
  Result := TcxGridCardView(inherited GridView);
end;

procedure TcxGridCard.DoCollapse(ARecurse: Boolean);
begin
  if FExpanded then
  begin
    if Focused then
      GridView.Controller.FocusedItem := nil;
    FExpanded := False;
    GridView.SizeChanged;
  end;
end;

procedure TcxGridCard.DoExpand(ARecurse: Boolean);
begin
  if not FExpanded then
  begin
    FExpanded := True;
    GridView.SizeChanged;
  end;
end;

function TcxGridCard.GetExpandable: Boolean;
begin
  Result := GridView.OptionsCustomize.CardExpanding;
end;

function TcxGridCard.GetExpanded: Boolean;
begin
  Result := not Expandable or FExpanded;
end;

function TcxGridCard.GetHasCells: Boolean;
begin
  Result := True;
end;

function TcxGridCard.GetViewInfoCacheItemClass: TcxCustomGridViewInfoCacheItemClass;
begin
  Result := TcxGridCardViewInfoCacheItem;
end;

function TcxGridCard.GetViewInfoClass: TcxCustomGridRecordViewInfoClass;
begin
  Result := TcxGridCardViewInfo;
end;

procedure TcxGridCard.GetVisibleRows(ARows: TList);
var
  I: Integer;
  ARow: TcxGridCardViewRow;
begin
  ARows.Clear;
  for I := 0 to GridView.VisibleRowCount - 1 do
  begin
    ARow := GridView.VisibleRows[I];
    if ARow.IsVisibleInCard(Self) then ARows.Add(ARow);
  end;
end;

{ TcxGridCardViewViewData }

function TcxGridCardViewViewData.GetCard(Index: Integer): TcxGridCard;
begin
  Result := TcxGridCard(Records[Index]);
end;

function TcxGridCardViewViewData.GetCardCount: Integer;
begin
  Result := RecordCount;
end;

function TcxGridCardViewViewData.GetRecordClass(ARecordInfo: TcxRowInfo): TcxCustomGridRecordClass;
begin
  Result := TcxGridCard;
end;

{ TcxGridRowContainerZone }

constructor TcxGridRowContainerZone.Create(AGridRecord: TcxCustomGridRecord;
  AItemIndex: Integer);
begin
  inherited Create(AItemIndex);
  GridRecord := AGridRecord;
end;

function TcxGridRowContainerZone.IsEqual(Value: TcxGridItemContainerZone): Boolean;
begin
  Result := inherited IsEqual(Value) and
    (GridRecord = (Value as TcxGridRowContainerZone).GridRecord);
end;

{ TcxGridCardRowMovingObject }

function TcxGridCardRowMovingObject.GetDestZone: TcxGridRowContainerZone;
begin
  Result := TcxGridRowContainerZone(inherited DestZone);
end;

function TcxGridCardRowMovingObject.GetGridView: TcxGridCardView;
begin
  Result := TcxGridCardView(inherited GridView);
end;

function TcxGridCardRowMovingObject.GetSourceItem: TcxGridCardViewRow;
begin
  Result := TcxGridCardViewRow(inherited SourceItem);
end;

function TcxGridCardRowMovingObject.GetViewInfo: TcxGridCardViewViewInfo;
begin
  Result := TcxGridCardViewViewInfo(inherited ViewInfo);
end;

procedure TcxGridCardRowMovingObject.SetDestZone(Value: TcxGridRowContainerZone);
begin
  inherited DestZone := Value;
end;

procedure TcxGridCardRowMovingObject.SetSourceItem(Value: TcxGridCardViewRow);
begin
  inherited SourceItem := Value;
end;

function TcxGridCardRowMovingObject.AreArrowsVertical: Boolean;
begin
  Result := False;
end;

procedure TcxGridCardRowMovingObject.CalculateDestParams(AHitTest: TcxCustomGridHitTest;
  out AContainerKind: TcxGridItemContainerKind; out AZone: TcxGridItemContainerZone);
begin
  inherited;
  if AContainerKind = ckNone then
  begin
    AZone := ViewInfo.RecordsViewInfo.GetZone(AHitTest);
    if AZone <> nil then
      AContainerKind := ckRows;
  end;
end;

function TcxGridCardRowMovingObject.CanRemove: Boolean;
begin
  Result :=
    (SourceItemContainerKind = ckRows) and SourceItem.CanHide and
    (GridView.Controller.Customization or GridView.OptionsCustomize.RowHiding);
end;

procedure TcxGridCardRowMovingObject.EndDragAndDrop(Accepted: Boolean);
var
  ARowPositionChanged: Boolean;

  function GetNewSourceItemIndex: Integer;
  begin
    if DestZone.ItemIndex = GridView.VisibleRowCount then
      Result := GridView.ItemCount - 1
    else
    begin
      Result := GridView.VisibleRows[DestZone.ItemIndex].Index;
      if SourceItem.Index < Result then Dec(Result);
    end;
  end;

begin
  inherited;
  if Accepted then
  begin
    ARowPositionChanged := False;
    GridView.BeginUpdate;
    try
      if DestItemContainerKind = ckRows then
        if IsValidDestination then
        begin
          SourceItem.Index := GetNewSourceItemIndex;
          SourceItem.Visible := True;
          ARowPositionChanged := True;
        end
        else
      else
        if CanRemove then
        begin
          SourceItem.Visible := False;
          ARowPositionChanged := True;
        end;
    finally
      GridView.EndUpdate;
    end;
    if ARowPositionChanged then
      GridView.DoRowPositionChanged(SourceItem);
  end;
end;

function TcxGridCardRowMovingObject.GetArrowAreaBounds(APlace: TcxGridArrowPlace): TRect;
var
  ACardViewInfo: TcxGridCardViewInfo;
begin
  ACardViewInfo := ViewInfo.RecordsViewInfo.GetRealItem(DestZone.GridRecord);
  with ACardViewInfo do
    if VisibleRowCount = 0 then
      Result := ACardViewInfo.ContentBounds
    else
      if DestZone.ItemIndex > VisibleRowViewInfos[TopRowIndex + PartVisibleRowCount - 1].Row.VisibleIndex then
      begin
        Result := VisibleRowViewInfos[TopRowIndex + PartVisibleRowCount - 1].Bounds;
        Result.Top := Result.Bottom;
      end
      else
        if RowViewInfos[DestZone.ItemIndex].Hidden then
        begin
          Result := RowViewInfos[DestZone.ItemIndex - 1].Bounds;
          Result.Top := Result.Bottom;
        end
        else
          Result := RowViewInfos[DestZone.ItemIndex].Bounds;
end;

function TcxGridCardRowMovingObject.GetArrowsClientRect: TRect;
begin
  Result := DestZone.GridRecord.ViewInfo.ContentBounds;
end;

function TcxGridCardRowMovingObject.GetSourceItemViewInfo: TcxCustomGridCellViewInfo;
var
  ARowViewInfo: TcxGridCardRowViewInfo;
begin
  if SourceItemContainerKind = ckRows then
  begin
    ARowViewInfo :=
      ViewInfo.RecordsViewInfo.GetRealItem(FSourceGridRecord).RowViewInfos[SourceItem.VisibleIndex];
    if ARowViewInfo.Row.Kind = rkCaption then
      Result := ARowViewInfo
    else
      Result := ARowViewInfo.CaptionViewInfo;
  end
  else
    Result := inherited GetSourceItemViewInfo;
end;

function TcxGridCardRowMovingObject.IsValidDestination: Boolean;
begin
  Result := DestItemContainerKind = ckRows;
  if Result then
  begin
    Result := not SourceItem.Visible or
      (DestZone.ItemIndex < SourceItem.VisibleIndex) or
      (SourceItem.VisibleIndex + 1 < DestZone.ItemIndex);
  end;
end;

procedure TcxGridCardRowMovingObject.Init(const P: TPoint; AParams: TcxCustomGridHitTest);
begin
  inherited;
  with AParams as TcxGridCardRowCellHitTest do
  begin
    SourceGridRecord := GridRecord;
    SourceItem := TcxGridCardViewRow(Item);
  end;
  if AParams is TcxGridCardRowCaptionHitTest then
    SourceItemContainerKind := TcxGridCardRowCaptionHitTest(AParams).RowContainerKind
  else
    SourceItemContainerKind := ckRows;
end;

{ TcxGridCardSizingObject }

constructor TcxGridCardSizingObject.Create(AControl: TcxControl);
begin
  inherited;
  FSeparators := TList.Create;
end;

destructor TcxGridCardSizingObject.Destroy;
begin
  ClearSeparators;
  FSeparators.Free;
  inherited;
end;

function TcxGridCardSizingObject.GetGridView: TcxGridCardView;
begin
  Result := TcxGridCardView(inherited GridView);
end;

function TcxGridCardSizingObject.GetSeparator(Index: Integer): TRect;
begin
  Result := PRect(FSeparators[Index])^;
end;

function TcxGridCardSizingObject.GetSeparatorCount: Integer;
begin
  Result := FSeparators.Count;
end;

function TcxGridCardSizingObject.GetViewInfo: TcxGridCardViewViewInfo;
begin
  Result := TcxGridCardViewViewInfo(inherited ViewInfo);
end;

procedure TcxGridCardSizingObject.SetDestPointX(Value: Integer);
var
  APrevWidth: Integer;
begin
  if FDestPointX <> Value then
  begin
    APrevWidth := CurrentWidth;
    FDestPointX := Value;
    if CurrentWidth <> APrevWidth then
      Dirty := True;
  end;
end;

procedure TcxGridCardSizingObject.DirtyChanged;
begin
  if not Dirty then
  begin
    ClearSeparators;
    CalculateSeparators;
  end;
  DrawSeparators;
end;

function TcxGridCardSizingObject.GetCurrentWidth: Integer;
begin
  Result := OriginalWidth + DeltaWidth;
  if Result < cxGridMinCardWidth then Result := cxGridMinCardWidth;
end;

function TcxGridCardSizingObject.GetDeltaWidth: Integer;
begin
  Result := (DestPointX - SourcePoint.X) div (FCardColumnIndex + 1);
end;

function TcxGridCardSizingObject.GetDragAndDropCursor(Accepted: Boolean): TCursor;
begin
  if Accepted then
    Result := crSizeWE
  else
    Result := inherited GetDragAndDropCursor(Accepted);
end;

function TcxGridCardSizingObject.GetImmediateStart: Boolean;
begin
  Result := True;
end;

function TcxGridCardSizingObject.GetOriginalWidth: Integer;
begin
  Result := GridView.OptionsView.CardWidth;
end;

procedure TcxGridCardSizingObject.BeginDragAndDrop;
begin
  FDestPointX := CurMousePos.X;
  inherited;
end;

procedure TcxGridCardSizingObject.DragAndDrop(const P: TPoint;
  var Accepted: Boolean);
begin
  DestPointX := P.X;
  Accepted := True;
  inherited;
end;

procedure TcxGridCardSizingObject.EndDragAndDrop(Accepted: Boolean);
begin
  inherited;
  if Accepted then
    GridView.OptionsView.CardWidth := CurrentWidth;
end;

procedure TcxGridCardSizingObject.AddSeparator(const R: TRect);
var
  ANewSeparator: PRect;
begin
  New(ANewSeparator);
  ANewSeparator^ := R;
  FSeparators.Add(ANewSeparator);
end;

procedure TcxGridCardSizingObject.CalculateSeparators;
var
  ACardWidth, APrevCardRight: Integer;
  R: TRect;
begin
  ACardWidth := CurrentWidth;
  with ViewInfo.ClientBounds do
  begin
    R.Right := Left;
    R.Top := Top + CardIndent;
    R.Bottom := Bottom - CardIndent;
  end;
  repeat
    R.Left := R.Right + CardIndent + ACardWidth;
    APrevCardRight := R.Left;
    if GridView.LayoutDirection = ldHorizontal then
      Inc(R.Left, CardIndent)
    else
      Inc(R.Left, (CardIndent - ViewInfo.SeparatorsViewInfo.Width) div 2);
    if R.Left >= ViewInfo.ClientBounds.Right then Exit;
    R.Right := R.Left + ViewInfo.SeparatorsViewInfo.Width;
    AddSeparator(R);
    if GridView.LayoutDirection = ldVertical then
      R.Right := APrevCardRight;
  until False;
end;

procedure TcxGridCardSizingObject.ClearSeparators;
var
  I: Integer;
begin
  for I := 0 to SeparatorCount - 1 do
    Dispose(PRect(FSeparators[I]));
  FSeparators.Clear;
end;

procedure TcxGridCardSizingObject.DrawSeparators;
var
  I: Integer;
begin
  for I := 0 to SeparatorCount - 1 do
    Canvas.InvertRect(Separators[I]);
end;

procedure TcxGridCardSizingObject.Init(const P: TPoint; AParams: TcxCustomGridHitTest);
begin
  inherited;
  FCardColumnIndex := (AParams as TcxGridCardViewSeparatorHitTest).Index;
end;

{ TcxGridCardRowsListBox }

function TcxGridCardRowsListBox.GetGridView: TcxGridCardView;
begin
  Result := TcxGridCardView(inherited GridView);
end;

function TcxGridCardRowsListBox.CalculateItemHeight: Integer;
begin
  Result := TcxGridCardRowCaptionViewInfo.GetCellHeight(Canvas.TextHeight('Qq'),
    LookAndFeelPainter);
end;

function TcxGridCardRowsListBox.GetDragAndDropParams: TcxCustomGridHitTest;
begin
  Result := TcxGridCardRowCaptionHitTest.Instance(Point(-1, -1));
  with TcxGridCardRowCaptionHitTest(Result) do
  begin
    GridView := Self.GridView;
    GridRecord := nil;
    Item := TcxCustomGridTableItem(DragAndDropItem);
    RowContainerKind := ckCustomizationForm;
  end;
end;

procedure TcxGridCardRowsListBox.PaintItem(ACanvas: TcxCanvas; R: TRect;
  AIndex: Integer; AFocused: Boolean);
begin
  with ACanvas do
  begin
    FillRect(R);
    Inc(R.Left, cxGridCellTextOffset);
    DrawText(Items[AIndex], R, cxAlignLeft or cxAlignVCenter or cxSingleLine or
      Ord(GridView.OptionsView.RowCaptionEndEllipsis) * cxShowEndEllipsis);
  end;
end;

procedure TcxGridCardRowsListBox.RefreshItems;
begin
  inherited;
  RefreshItemsAsTableItems;
end;

{ TcxGridCardViewCustomizationForm }

function TcxGridCardViewCustomizationForm.GetItemsListBoxClass: TcxCustomGridTableItemsListBoxClass;
begin
  Result := TcxGridCardRowsListBox;
end;

function TcxGridCardViewCustomizationForm.GetItemsPageCaption: string;
begin
  Result := cxGetResourceString(@scxGridCustomizationFormRowsPageCaption);
end;

{ TcxGridCardViewControllerImpl }

constructor TcxGridCardViewControllerImpl.Create(AController: TcxGridCardViewController);
begin
  inherited Create;
  FController := AController;
end;

function TcxGridCardViewControllerImpl.GetControl: TcxControl;
begin
  Result := FController.Control;
end;

function TcxGridCardViewControllerImpl.GetDataController: TcxCustomDataController;
begin
  Result := FController.DataController;
end;

function TcxGridCardViewControllerImpl.GetScrollBarOffsetBegin: Integer;
begin
  Result := FController.ScrollBarOffsetBegin;
end;

function TcxGridCardViewControllerImpl.GetScrollBarOffsetEnd: Integer;
begin
  Result := FController.ScrollBarOffsetEnd;
end;

function TcxGridCardViewControllerImpl.GetViewData: TcxGridCardViewViewData;
begin
  Result := FController.ViewData;
end;

function TcxGridCardViewControllerImpl.GetViewInfo: TcxGridCardViewViewInfo;
begin
  Result := FController.ViewInfo;
end;

procedure TcxGridCardViewControllerImpl.KeyDown(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_HOME:
      if DataController.IsGridMode then
        DataController.GotoFirst
      else
        Controller.FocusNextRecord(-1, True, False, False, False);
    VK_END:
      if DataController.IsGridMode then
        DataController.GotoLast
      else
        Controller.FocusNextRecord(-1, False, True, False, False);
  end;
end;

{ TcxGridCardViewControllerHorizontalImpl }

function TcxGridCardViewControllerHorizontalImpl.GetIsRecordsScrollHorizontal: Boolean;
begin
  Result := True;
end;

function TcxGridCardViewControllerHorizontalImpl.GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind;
begin
  Result := mwskHorizontal;
end;

function TcxGridCardViewControllerHorizontalImpl.GetScrollDelta: Integer;
begin
  if ViewInfo.RecordsViewInfo.Columns.Count = 0 then
    Result := 0
  else
    Result := ViewInfo.RecordsViewInfo.Columns[0].RowCount
end;

procedure TcxGridCardViewControllerHorizontalImpl.InitScrollBarsParameters;
begin
  with Controller do
  begin
    SetScrollBarInfo(sbHorizontal, 0, ScrollBarRecordCount - 1,
      ScrollDelta, ViewInfo.VisibleRecordCount, ScrollBarPos, True, CanHScrollBarHide);
    SetScrollBarInfo(sbVertical, 0, -1, 0, 0, 0, True, True);
  end;
end;

procedure TcxGridCardViewControllerHorizontalImpl.KeyDown(var Key: Word;
  Shift: TShiftState);

  procedure FocusRecordInNextColumn(ADirection: TcxDirection);
  var
    ARecordViewInfo: TcxGridCardViewInfo;
    ACheckPos: Integer;

    function MarginCol(AIsLeftDirection: Boolean): Integer;
    begin
      if AIsLeftDirection then
        Result := 0
      else
        Result := ViewInfo.RecordsViewInfo.Columns.VisibleCount - 1;
    end;

    function NextCol: Integer;
    begin
      if ARecordViewInfo = nil then
        Result := MarginCol(ADirection = dirRight)
      else
        if ADirection = dirLeft then
          Result := ARecordViewInfo.Col - 1
        else
          Result := ARecordViewInfo.Col + 1;
    end;

    function MarginRecordIndex: Integer;
    begin
      if ADirection = dirLeft then
        Result := 0
      else
        Result := ViewData.RecordCount - 1;
    end;

  begin
    with Controller do
      try
        if FocusedRecordIndex = -1 then
        begin
          if ADirection = dirLeft then
            GoToFirst
          else
            GoToLast(False);
          Exit;
        end;
        MakeFocusedRecordVisible;
        ARecordViewInfo := ViewInfo.RecordsViewInfo.GetRealItem(FocusedRecord);
        ACheckPos := ARecordViewInfo.Bounds.Top;
        if ARecordViewInfo.Col = MarginCol(ADirection = dirLeft) then
        begin
          ScrollData(ADirection);
          ARecordViewInfo := ViewInfo.RecordsViewInfo.GetRealItem(FocusedRecord);
          if (ARecordViewInfo <> nil) and
            (ARecordViewInfo.Col = MarginCol(ADirection = dirLeft)) then
          begin
            if ARecordViewInfo.Bounds.Top <> ACheckPos then
              GoToPrev(False)
            else
              if GridView.IsDetail then
                FocusNextRecord(MarginRecordIndex, ADirection = dirRight, False,
                  not (ssShift in Shift), not (ssShift in Shift));
            Exit;
          end;
        end;
        ARecordViewInfo := ViewInfo.RecordsViewInfo.Columns[NextCol].GetNearestRow(ACheckPos);
        FocusedRecord := ARecordViewInfo.GridRecord;
      finally
        MakeFocusedItemVisible;
      end;
  end;

begin
  inherited;
  with Controller do
    case Key of
      VK_LEFT:
        FocusRecordInNextColumn(dirLeft);
      VK_RIGHT:
        FocusRecordInNextColumn(dirRight);
      VK_UP:
        FocusNextRecord(FocusedRecordIndex, False, False, not (ssShift in Shift), not (ssShift in Shift));
      VK_DOWN:
        FocusNextRecord(FocusedRecordIndex, True, False, not (ssShift in Shift), not (ssShift in Shift));
    end;
end;

{ TcxGridCardViewControllerVerticalImpl }

function TcxGridCardViewControllerVerticalImpl.GetIsRecordsScrollHorizontal: Boolean;
begin
  Result := False;
end;

function TcxGridCardViewControllerVerticalImpl.GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind;
begin
  Result := mwskVertical;
end;

function TcxGridCardViewControllerVerticalImpl.GetScrollDelta: Integer;
begin
  Result := ViewInfo.RecordsViewInfo.Columns.Count;
end;

procedure TcxGridCardViewControllerVerticalImpl.InitScrollBarsParameters;
begin
  with Controller do
  begin
    SetScrollBarInfo(sbHorizontal, 0, -1, 0, 0, 0, True, CanHScrollBarHide);
    SetScrollBarInfo(sbVertical, 0, ScrollBarRecordCount - 1,
      ScrollDelta, ViewInfo.VisibleRecordCount, ScrollBarPos, True, True);
  end;    
end;

procedure TcxGridCardViewControllerVerticalImpl.KeyDown(var Key: Word;
  Shift: TShiftState);

  procedure FocusRecordInNextRow(ADirection: TcxDirection);
  var
    ANewFocusedRecordIndex: Integer;
    AIsNewFocusedRecordOutOfRange: Boolean;

    function NextRecordIndex: Integer;
    begin
      with Controller do
        if ADirection = dirUp then
          Result := FocusedRecordIndex - ScrollDelta
        else
          Result := FocusedRecordIndex + ScrollDelta;
    end;

    function IsOnBound: Boolean;
    begin
      Result :=
        DataController.IsGridMode and
          (DataController.IsBOF and (ADirection = dirUp) or
           DataController.IsEOF and (ADirection = dirDown)) or
        not DataController.IsGridMode and AIsNewFocusedRecordOutOfRange;
    end;

    function MarginRecordIndex: Integer;
    begin
      if ADirection = dirUp then
        Result := 0
      else
        Result := ViewData.RecordCount - 1;
    end;

  begin
    with Controller do
    begin
      if FocusedRecordIndex = -1 then
      begin
        if ADirection = dirUp then
          GoToFirst
        else
          GoToLast(False);
        Exit;
      end;
      MakeFocusedRecordVisible;
      ANewFocusedRecordIndex := NextRecordIndex;
      AIsNewFocusedRecordOutOfRange := (ANewFocusedRecordIndex < 0) or
        (ANewFocusedRecordIndex > ViewData.RecordCount - 1);
      if IsOnBound then
      begin
        if GridView.IsDetail then
          FocusNextRecord(MarginRecordIndex, ADirection = dirDown, False,
            not (ssShift in Shift), not (ssShift in Shift));
        Exit;
      end;
      if DataController.IsGridMode and AIsNewFocusedRecordOutOfRange or
        not ViewData.Records[ANewFocusedRecordIndex].Visible then
      begin
        ScrollData(ADirection);
        if AIsNewFocusedRecordOutOfRange then
        begin
          if ANewFocusedRecordIndex < 0 then ANewFocusedRecordIndex := 0;
          if ANewFocusedRecordIndex > ViewData.RecordCount - 1 then
            ANewFocusedRecordIndex := ViewData.RecordCount - 1;
        end;
      end;  
      FocusedRecordIndex := ANewFocusedRecordIndex;
    end;
  end;

begin
  inherited;
  with Controller do
    case Key of
      VK_LEFT:
        begin
          FocusNextRecord(FocusedRecordIndex, False, False, not (ssShift in Shift), not (ssShift in Shift));
          MakeFocusedItemVisible;
        end;
      VK_RIGHT:
        begin
          FocusNextRecord(FocusedRecordIndex, True, False, not (ssShift in Shift), not (ssShift in Shift));
          MakeFocusedItemVisible;
        end;
      VK_UP:
        FocusRecordInNextRow(dirUp);
      VK_DOWN:
        FocusRecordInNextRow(dirDown);
    end;
end;

{ TcxGridCardViewController }

constructor TcxGridCardViewController.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  CreateImplementationObject;
end;

destructor TcxGridCardViewController.Destroy;
begin
  DestroyImplementationObject;
  inherited;
end;

function TcxGridCardViewController.GetCustomizationForm: TcxGridCardViewCustomizationForm;
begin
  Result := TcxGridCardViewCustomizationForm(inherited CustomizationForm);
end;

function TcxGridCardViewController.GetFocusedCardViewInfo: TcxGridCardViewInfo;
begin
  if FocusedRecord = nil then
    Result := nil
  else
    Result := TcxGridCardViewInfo(FocusedRecord.ViewInfo);
end;

function TcxGridCardViewController.GetFocusedItem: TcxGridCardViewRow;
begin
  Result := TcxGridCardViewRow(inherited FocusedItem);
end;

function TcxGridCardViewController.GetGridView: TcxGridCardView;
begin
  Result := TcxGridCardView(inherited GridView);
end;

function TcxGridCardViewController.GetScrollDelta: Integer;
begin
  Result := ImplementationObject.GetScrollDelta;
end;

function TcxGridCardViewController.GetTopCardIndex: Integer;
begin
  Result := TopRecordIndex;
end;

function TcxGridCardViewController.GetViewData: TcxGridCardViewViewData;
begin
  Result := TcxGridCardViewViewData(inherited ViewData);
end;

function TcxGridCardViewController.GetViewInfo: TcxGridCardViewViewInfo;
begin
  Result := TcxGridCardViewViewInfo(inherited ViewInfo);
end;

procedure TcxGridCardViewController.SetFocusedItem(Value: TcxGridCardViewRow);
begin
  inherited FocusedItem := Value;
end;

procedure TcxGridCardViewController.SetScrollCardViewInfo(Value: TcxGridCardViewInfo);
var
  AScrollDirection: TcxDirection;
begin
  if FScrollCardViewInfo <> Value then
  begin
    AScrollDirection := ScrollDirection;
    ScrollDirection := dirNone;
    FScrollCardViewInfo := Value;
    if FScrollCardViewInfo <> nil then
      ScrollDirection := AScrollDirection;
  end;
end;

procedure TcxGridCardViewController.SetTopCardIndex(Value: Integer);
begin
  TopRecordIndex := Value;
end;

procedure TcxGridCardViewController.CreateImplementationObject;
begin
  FImplementationObject := GetImplementationObjectClass.Create(Self);
end;

procedure TcxGridCardViewController.DestroyImplementationObject;
begin
  FreeAndNil(FImplementationObject);
end;

function TcxGridCardViewController.GetImplementationObjectClass: TcxGridCardViewControllerImplClass;
begin
  case GridView.LayoutDirection of
    ldHorizontal:
      Result := TcxGridCardViewControllerHorizontalImpl;
    ldVertical:
      Result := TcxGridCardViewControllerVerticalImpl;
  else
    Result := nil;
  end;
end;

function TcxGridCardViewController.CanFocusNextItem(AFocusedItemIndex, ANextItemIndex: Integer;
  AGoForward, AGoOnCycle, AGoToNextRecordOnCycle: Boolean): Boolean;
begin
  Result := inherited CanFocusNextItem(AFocusedItemIndex, ANextItemIndex, AGoForward, AGoOnCycle, AGoToNextRecordOnCycle) and
    (not AGoToNextRecordOnCycle or
      (not AGoForward and (not CanScrollFocusedCard(False) or (ANextItemIndex < AFocusedItemIndex)) or
        AGoForward and (not CanScrollFocusedCard(True) or (ANextItemIndex > AFocusedItemIndex))));
end;

function TcxGridCardViewController.GetDesignHitTest(AHitTest: TcxCustomGridHitTest): Boolean;
begin
  Result := inherited GetDesignHitTest(AHitTest);
  if not Result then
    Result := AHitTest.HitTestCode in [htRowCaption, htCell];
end;

function TcxGridCardViewController.GetDragScrollInterval: Integer;
begin
  Result := 300;
end;

function TcxGridCardViewController.GetIsRecordsScrollHorizontal: Boolean;
begin
  Result := FImplementationObject.GetIsRecordsScrollHorizontal;
end;

function TcxGridCardViewController.GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind;
begin
  Result := FImplementationObject.GetMouseWheelScrollingKind;
end;

function TcxGridCardViewController.IsKeyForMultiSelect(AKey: Word;
  AShift: TShiftState; AFocusedRecordChanged: Boolean): Boolean;
begin
  Result := inherited IsKeyForMultiSelect(AKey, AShift, AFocusedRecordChanged) or
    (AKey = VK_LEFT) or (AKey = VK_RIGHT) or
    ((AKey = VK_UP) or (AKey = VK_DOWN) or (AKey = VK_HOME) or (AKey = VK_END)) and
      (not GridView.OptionsSelection.CellSelect or (FocusedItem = nil) or
        AFocusedRecordChanged);
end;

procedure TcxGridCardViewController.ScrollData(ADirection: TcxDirection);
begin
  if Site.DragAndDropState = ddsNone then
    ScrollRecords(ADirection in [dirRight, dirDown], ScrollDelta)
  else
    with FScrollCardViewInfo do
      case ADirection of
        dirUp:
          TopRowIndex := TopRowIndex - 1;
        dirDown:
          TopRowIndex := TopRowIndex + 1;
      end;
end;

function TcxGridCardViewController.CanScrollData(ADirection: TcxDirection): Boolean;
begin
  with FScrollCardViewInfo do
    case ADirection of
      dirUp:
        Result := NeedsScrollingUp;
      dirDown:
        Result := NeedsScrollingDown;
    else
      Result := inherited CanScrollData(ADirection);
    end;
end;

function TcxGridCardViewController.GetScrollDataTimeInterval(ADirection: TcxDirection): Integer;
begin
  if ADirection in [dirUp, dirDown] then
    Result := CardScrollingInterval
  else
    Result := inherited GetScrollDataTimeInterval(ADirection);
end;

function TcxGridCardViewController.GetCustomizationFormClass: TcxCustomGridCustomizationFormClass;
begin
  Result := TcxGridCardViewCustomizationForm;
end;

function TcxGridCardViewController.GetRowDragAndDropObjectClass: TcxGridCardRowMovingObjectClass;
begin
  Result := TcxGridCardRowMovingObject;
end;

procedure TcxGridCardViewController.CheckScrolling(const P: TPoint);
var
  AHitTest: TcxCustomGridHitTest;
begin
  AHitTest := ViewInfo.GetHitTest(P);
  case AHitTest.HitTestCode of
    htCardScrollButtonUp, htCardScrollButtonDown:
      begin
        ScrollCardViewInfo :=
          TcxCustomGridCardScrollButtonViewInfo(AHitTest.ViewInfo).CardViewInfo;
        if AHitTest.HitTestCode = htCardScrollButtonUp then
          ScrollDirection := dirUp
        else
          ScrollDirection := dirDown;
      end
  else
    ScrollDirection := dirNone;
  end;
end;

function TcxGridCardViewController.IsDataFullyVisible(AIsCallFromMaster: Boolean = False): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to ViewInfo.RecordsViewInfo.PartVisibleCount - 1 do
  begin
    Result := ViewInfo.RecordsViewInfo[I].IsFullyVisible;
    if not Result then Break;
  end;
  if Result then
    Result := inherited IsDataFullyVisible(AIsCallFromMaster);
end;

procedure TcxGridCardViewController.MakeItemVisible(AItem: TcxCustomGridTableItem);
begin
  MakeFocusedRecordVisible;
  if (AItem <> nil) and (FocusedCardViewInfo <> nil) and
    not TcxCustomGrid(Control).UpdateLocked then
    FocusedCardViewInfo.MakeRowVisible(TcxGridCardViewRow(AItem));
end;

function TcxGridCardViewController.CanScrollFocusedCard(ADown: Boolean): Boolean;
begin
  Result := (FocusedCardViewInfo <> nil) and
    (not ADown and FocusedCardViewInfo.NeedsScrollingUp or
     ADown and FocusedCardViewInfo.NeedsScrollingDown);
end;

function TcxGridCardViewController.ScrollFocusedCard(ADown: Boolean): Boolean;
var
  APrevTopRowIndex: Integer;
begin
  Result := (FocusedCardViewInfo <> nil) and CanScrollFocusedCard(ADown);
  if Result then
    with FocusedCardViewInfo do
    begin
      APrevTopRowIndex := TopRowIndex;
      TopRowIndex := TopRowIndex + 2 * Ord(ADown) - 1;
      Result := TopRowIndex <> APrevTopRowIndex;
    end;
end;

procedure TcxGridCardViewController.InitScrollBarsParameters;
begin
  ImplementationObject.InitScrollBarsParameters;
end;

procedure TcxGridCardViewController.Scroll(AScrollBarKind: TScrollBarKind;
  AScrollCode: TScrollCode; var AScrollPos: Integer);
begin
  case AScrollCode of
    scLineUp:
      ScrollData(dirLeft);
    scLineDown:
      ScrollData(dirRight);
    scPageUp:
      ScrollPage(False);
    scPageDown:
      ScrollPage(True);
    scTrack:
      if not DataController.IsGridMode then
        //TopCardIndex := AScrollPos;
        ScrollBarPos := AScrollPos;
    scPosition:
      if DataController.IsGridMode then
        ScrollBarPos := AScrollPos;
  end;
  AScrollPos := ScrollBarPos;
end;

procedure TcxGridCardViewController.KeyDown(var Key: Word; Shift: TShiftState);

  function ProcessFocusedItemKeys: Boolean;
  begin
    Result := False;
    if FocusedItem <> nil then
      case Key of
        VK_UP, VK_DOWN:
          Result := FocusNextCell(Key = VK_DOWN);
        VK_HOME:
          if Shift = [] then
          begin
            FocusNextItem(-1, True, False, False);
            Result := True;
          end;
        VK_END:
          if Shift = [] then
          begin
            FocusNextItem(-1, False, True, False);
            Result := True;
          end;
        VK_ESCAPE:
          if GridView.OptionsSelection.InvertSelect then
            FocusedItem := nil;
      end
    else
      if Key = VK_F2 then
        FocusNextItem(-1, True, False, False);
  end;

begin
  inherited;
  if FocusedRecordIndex <> -1 then
  begin
    if GridView.OptionsSelection.CellSelect and ProcessFocusedItemKeys then Exit;
    if ((Key = VK_UP) or (Key = VK_DOWN)) and ScrollFocusedCard(Key = VK_DOWN) then Exit;
  end;
  ImplementationObject.KeyDown(Key, Shift);
end;

procedure TcxGridCardViewController.LayoutDirectionChanged;
begin
  DestroyImplementationObject;
  CreateImplementationObject;
end;

{ TcxGridCardRowFilterButtonPainter }

function TcxGridCardRowFilterButtonPainter.GetViewInfo: TcxGridCardRowFilterButtonViewInfo;
begin
  Result := TcxGridCardRowFilterButtonViewInfo(inherited ViewInfo);
end;

procedure TcxGridCardRowFilterButtonPainter.Paint;
begin
  with ViewInfo do
    GridViewInfo.LookAndFeelPainter.DrawFilterDropDownButton(Self.Canvas,
      Bounds, ButtonState, Active);
end;

{ TcxGridCardRowCaptionPainter }

function TcxGridCardRowCaptionPainter.GetViewInfo: TcxGridCardRowCaptionViewInfo;
begin
  Result := TcxGridCardRowCaptionViewInfo(inherited ViewInfo);
end;

procedure TcxGridCardRowCaptionPainter.DrawContent;
begin
  inherited;
  ViewInfo.FilterButtonViewInfo.Paint(Canvas);
end;

{ TcxGridCardRowPainter }

function TcxGridCardRowPainter.GetViewInfo: TcxGridCardRowViewInfo;
begin
  Result := TcxGridCardRowViewInfo(inherited ViewInfo);
end;

procedure TcxGridCardRowPainter.DrawFocusRect;
begin
  with ViewInfo do
    if DataViewInfo.Focused then
      GridViewInfo.Painter.DrawFocusRect(Bounds, CardViewInfo.HideFocusRectOnExit);
end;

procedure TcxGridCardRowPainter.Paint;
begin
  ViewInfo.CaptionViewInfo.Paint(Canvas);
  ViewInfo.DataViewInfo.Paint(Canvas);
  DrawFocusRect;
end;

{ TcxGridCardScrollButtonPainter }

function TcxGridCardScrollButtonPainter.GetViewInfo: TcxCustomGridCardScrollButtonViewInfo;
begin
  Result := TcxCustomGridCardScrollButtonViewInfo(inherited ViewInfo);
end;

procedure TcxGridCardScrollButtonPainter.DrawContent;
const
  ScrollBarParts: array[Boolean] of TcxScrollBarPart = (sbpLineUp, sbpLineDown);
begin
  ViewInfo.GridViewInfo.LookAndFeelPainter.DrawScrollBarPart(Canvas, False,
    ViewInfo.Bounds, ScrollBarParts[ViewInfo.IsDownButton], ViewInfo.ButtonState);
end;

function TcxGridCardScrollButtonPainter.ExcludeFromClipRect: Boolean;
begin
  Result := True;
end;

{ TcxGridCardExpandButtonPainter }

function TcxGridCardExpandButtonPainter.GetViewInfo: TcxGridCardExpandButtonViewInfo;
begin
  Result := TcxGridCardExpandButtonViewInfo(inherited ViewInfo);
end;

procedure TcxGridCardExpandButtonPainter.Paint;
begin
  ViewInfo.LookAndFeelPainter.DrawGroupExpandButton(Canvas,
    ViewInfo.Bounds, ViewInfo.CardViewInfo.Expanded, ViewInfo.ButtonState);
end;

{ TcxGridCardPainter }

function TcxGridCardPainter.GetViewInfo: TcxGridCardViewInfo;
begin
  Result := TcxGridCardViewInfo(inherited ViewInfo);
end;

procedure TcxGridCardPainter.AfterPaint;
begin
  inherited;
  Canvas.SetClipRegion(FClipRegion, roSet);
end;

procedure TcxGridCardPainter.BeforePaint;
begin
  FClipRegion := Canvas.GetClipRegion;
  Canvas.IntersectClipRect(ViewInfo.Bounds);
  inherited;
end;

procedure TcxGridCardPainter.DrawBackground;
begin
  with ViewInfo do
    if Transparent then
      inherited
    else
    begin
      Self.Canvas.Brush.Color := Params.Color;
      Self.Canvas.FillRect(BackgroundBitmapBounds);
    end;
end;

procedure TcxGridCardPainter.DrawCardBorder;
var
  ABackgroundBitmap: TBitmap;
  ABounds: TRect;
begin
  ABounds := ViewInfo.Bounds;
  if ViewInfo.CardBorderBackgroundBitmap = nil then
    Canvas.FrameRect(ABounds, ViewInfo.CardBorderColor, ViewInfo.CardBorderWidth)
  else
    with ViewInfo.ContentBounds do
    begin  {4}
      ABackgroundBitmap := ViewInfo.CardBorderBackgroundBitmap;
      Canvas.FillRect(Rect(ABounds.Left, ABounds.Top, ABounds.Right, Top), ABackgroundBitmap);
      Canvas.FillRect(Rect(ABounds.Left, Top, Left, Bottom), ABackgroundBitmap);
      Canvas.FillRect(Rect(Right, Top, ABounds.Right, Bottom), ABackgroundBitmap);
      Canvas.FillRect(Rect(ABounds.Left, Bottom, ABounds.Right, ABounds.Bottom), ABackgroundBitmap);
    end;
end;

procedure TcxGridCardPainter.DrawExpandButton;
begin
  ViewInfo.ExpandButtonViewInfo.Paint(Canvas);
end;

function TcxGridCardPainter.DrawExpandButtonBeforePaint: Boolean;
begin
  Result := False;
end;

procedure TcxGridCardPainter.DrawRows;
var
  APrevClipRegion: TcxRegion;
  I: Integer;
begin
  APrevClipRegion := Canvas.GetClipRegion;
  try
    Canvas.IntersectClipRect(ViewInfo.ContentBounds);
    for I := ViewInfo.TopRowIndex to ViewInfo.TopRowIndex + ViewInfo.PartVisibleRowCount - 1 do
      ViewInfo.VisibleRowViewInfos[I].Paint(Canvas);
  finally
    Canvas.SetClipRegion(APrevClipRegion, roSet);
  end;
end;

procedure TcxGridCardPainter.DrawScrollButtons;
begin
  ViewInfo.ScrollButtonUp.Paint(Canvas);
  ViewInfo.ScrollButtonDown.Paint(Canvas);
end;

procedure TcxGridCardPainter.Paint;
begin
  DrawCardBorder;
  DrawScrollButtons;
  DrawRows;
  inherited;
end;

{ TcxGridCardViewPainter }

procedure TcxGridCardViewPainter.DrawBackground;
begin
  DrawSeparators;
  inherited;
end;

procedure TcxGridCardViewPainter.DrawSeparators;
var
  I: Integer;
  R: TRect;
begin
  Canvas.Brush.Color := ViewInfo.SeparatorsViewInfo.Color;
  for I := 0 to ViewInfo.SeparatorsViewInfo.Count - 1 do
  begin
    R := ViewInfo.SeparatorsViewInfo[I];
    Canvas.FillRect(R);
    Canvas.ExcludeClipRect(R);
  end;
end;

procedure TcxGridCardViewPainter.PaintContent;
begin
  DrawFilterBar;
  inherited;
end;

function TcxGridCardViewPainter.ViewInfo: TcxGridCardViewViewInfo;
begin
  Result := TcxGridCardViewViewInfo(inherited ViewInfo);
end;

{ TcxGridCardViewColumn }

constructor TcxGridCardViewColumn.Create(AColumns: TcxGridCardViewColumns; AIndex: Integer);
begin
  inherited Create;
  FColumns := AColumns;
  FIndex := AIndex;
  FRows := TList.Create;
end;

destructor TcxGridCardViewColumn.Destroy;
begin
  FRows.Free;
  inherited;
end;

function TcxGridCardViewColumn.GetLastRow: TcxGridCardViewInfo;
begin
  Result := Rows[VisibleRowCount - 1];
end;

function TcxGridCardViewColumn.GetRow(Index: Integer): TcxGridCardViewInfo;
begin
  Result := TcxGridCardViewInfo(FRows[Index]);
end;

function TcxGridCardViewColumn.GetRowCount: Integer;
begin
  Result := FRows.Count;
end;

function TcxGridCardViewColumn.GetVisibleRowCount: Integer;
begin
  if RowCount = 0 then
    Result := 0
  else
  begin
    for Result := RowCount - 1 downto 0 do
      if Rows[Result].Visible then Break;
    Inc(Result);
  end;  
end;

procedure TcxGridCardViewColumn.SetRow(Index: Integer; Value: TcxGridCardViewInfo);
begin
  if Index < RowCount then
    FRows[Index] := Value
  else
    FRows.Add(Value);
  Value.FCol := Self.Index;
  Value.FRow := Index;
end;

function TcxGridCardViewColumn.GetNearestRow(APos: Integer): TcxGridCardViewInfo;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to RowCount - 1 do
  begin
    Result := Rows[I];
    if APos < Result.Bounds.Bottom then Break;
  end;
end;

{ TcxGridCardViewColumns }

constructor TcxGridCardViewColumns.Create(ACardsViewInfo: TcxGridCardsViewInfo);
begin
  inherited Create;
  FCardsViewInfo := ACardsViewInfo;
  CreateItems;
end;

destructor TcxGridCardViewColumns.Destroy;
begin
  DestroyItems;
  inherited;
end;

function TcxGridCardViewColumns.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxGridCardViewColumns.GetItem(Index: Integer): TcxGridCardViewColumn;
begin
  if Index < Count then
    Result := TcxGridCardViewColumn(FItems[Index])
  else
  begin
    Result := TcxGridCardViewColumn.Create(Self, Index);
    FItems.Add(Result);
  end;
end;

function TcxGridCardViewColumns.GetLast: TcxGridCardViewColumn;
begin
  if Count = 0 then
    Result := nil
  else
    Result := Items[Count - 1];
end;

function TcxGridCardViewColumns.GetVisibleCount: Integer;
begin
  if Count = 0 then
    Result := 0
  else
  begin
    for Result := Count - 1 downto 0 do
      if Items[Result][0].Visible then Break;
    Inc(Result);    
  end;      
end;

procedure TcxGridCardViewColumns.CreateItems;
begin
  FItems := TList.Create;
end;

procedure TcxGridCardViewColumns.DestroyItems;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].Free;
  FItems.Free;
end;

{ TcxGridCardRowCellViewInfo }

constructor TcxGridCardRowCellViewInfo.Create(ARowViewInfo: TcxGridCardRowViewInfo);
begin
  FRowViewInfo := ARowViewInfo;
  inherited Create(FRowViewInfo.CardViewInfo, FRowViewInfo.Row);
end;

function TcxGridCardRowCellViewInfo.GetCardViewInfo: TcxGridCardViewInfo;
begin
  Result := TcxGridCardViewInfo(RecordViewInfo);
end;

function TcxGridCardRowCellViewInfo.GetGridRecord: TcxGridCard;
begin
  Result := TcxGridCard(inherited GridRecord);
end;

function TcxGridCardRowCellViewInfo.GetGridView: TcxGridCardView;
begin
  Result := TcxGridCardView(inherited GridView);
end;

function TcxGridCardRowCellViewInfo.GetRow: TcxGridCardViewRow;
begin
  Result := FRowViewInfo.Row;
end;

function TcxGridCardRowCellViewInfo.GetAreaBounds: TRect;
begin
  Result := inherited GetAreaBounds;
  IntersectRect(Result, Result, CardViewInfo.ScrollableAreaBounds);
end;

function TcxGridCardRowCellViewInfo.GetBackgroundBitmap: TBitmap;
begin
  Result := FRowViewInfo.GetCellBackgroundBitmap(Self);
end;

function TcxGridCardRowCellViewInfo.GetMultiLine: Boolean;
begin
  Result := AutoHeight;
end;

function TcxGridCardRowCellViewInfo.GetTransparent: Boolean;
begin
  Result := FRowViewInfo.GetCellTransparent(Self);
end;

function TcxGridCardRowCellViewInfo.HasFocusRect: Boolean;
begin
  Result := False;
end;

function TcxGridCardRowCellViewInfo.MouseDown(AHitTest: TcxCustomGridHitTest;
  AButton: TMouseButton; AShift: TShiftState): Boolean;
var
  AGridViewInfo: TcxGridCardViewViewInfo;
begin
  AGridViewInfo := GridView.ViewInfo;
  AGridViewInfo.AddActiveViewInfo(Self);
  try
    Result := inherited MouseDown(AHitTest, AButton, AShift);
    if AGridViewInfo.IsViewInfoActive(Self) then
      if (AButton = mbLeft) and not (ssDouble in AShift) and GridView.IsDesigning then
      begin
        GridView.Controller.DesignController.SelectObject(Row, not (ssShift in AShift));
        Result := True;
      end;
  finally
    AGridViewInfo.RemoveActiveViewInfo(Self);
  end;
end;

{ TcxGridCardRowFilterButtonViewInfo }

constructor TcxGridCardRowFilterButtonViewInfo.Create(ARowCaptionViewInfo: TcxGridCardRowCaptionViewInfo);
begin
  inherited Create(ARowCaptionViewInfo.GridViewInfo);
  FRowCaptionViewInfo := ARowCaptionViewInfo;
end;

function TcxGridCardRowFilterButtonViewInfo.GetActive: Boolean;
begin
  Result := Row.Filtered;
end;

function TcxGridCardRowFilterButtonViewInfo.GetDropDownWindowValue: TcxGridFilterPopup;
begin
  Result := TcxGridFilterPopup(inherited DropDownWindow);
end;

function TcxGridCardRowFilterButtonViewInfo.GetRow: TcxGridCardViewRow;
begin
  Result := FRowCaptionViewInfo.Row;
end;

function TcxGridCardRowFilterButtonViewInfo.GetItem: TcxCustomGridTableItem;
begin
  Result := Row;
end;

function TcxGridCardRowFilterButtonViewInfo.CalculateHeight: Integer;
begin
  Result := 0;
end;

function TcxGridCardRowFilterButtonViewInfo.CalculateWidth: Integer;
begin
  Result := 0;
end;

function TcxGridCardRowFilterButtonViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridCardRowFilterButtonHitTest;
end;

function TcxGridCardRowFilterButtonViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridCardRowFilterButtonPainter;
end;

function TcxGridCardRowFilterButtonViewInfo.GetVisible: Boolean;
begin
  Result := TcxGridCardViewRow(FRowCaptionViewInfo.Item).CanFilter(True);
end;

function TcxGridCardRowFilterButtonViewInfo.GetWidth: Integer;
begin
  Result := GridViewInfo.LookAndFeelPainter.FilterDropDownButtonSize.X;
end;

procedure TcxGridCardRowFilterButtonViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  inherited;
  with TcxGridCardRowFilterButtonHitTest(AHitTest) do
  begin
    GridRecord := FRowCaptionViewInfo.GridRecord;
    Item := Row;
  end;
end;

function TcxGridCardRowFilterButtonViewInfo.DropDownWindowExists: Boolean;
begin
  Result := TcxGridCardView(GridView).Controller.HasFilterPopup;
end;

function TcxGridCardRowFilterButtonViewInfo.GetDropDownWindow: TcxCustomGridPopup;
begin
  Result := TcxGridCardView(GridView).Controller.FilterPopup;
end;

function TcxGridCardRowFilterButtonViewInfo.GetDropDownWindowOwnerBounds: TRect;
begin
  Result := Bounds;
  with FRowCaptionViewInfo.Bounds do
  begin
    Result.Left := Left;
    Result.Right := Right;
  end;
end;

{ TcxGridCardRowCaptionViewInfo }

constructor TcxGridCardRowCaptionViewInfo.Create(ARowViewInfo: TcxGridCardRowViewInfo);
begin
  inherited;
  FFilterButtonViewInfo := GetFilterButtonViewInfoClass.Create(Self);
end;

destructor TcxGridCardRowCaptionViewInfo.Destroy;
begin
  FFilterButtonViewInfo.Free;
  inherited;
end;

function TcxGridCardRowCaptionViewInfo.CalculateRealWidth: Integer;
begin
  CalculateParams;
  Result := TextWidthWithOffset;
  if Row.HasCardExpandButton and (CardViewInfo.ExpandButtonAlignment = cebaLeft) then
    Inc(Result, CardViewInfo.ExpandButtonAreaWidth);
  if FFilterButtonViewInfo.Visible then
    Inc(Result, cxGridCellTextOffset + FFilterButtonViewInfo.Width);
end;

function TcxGridCardRowCaptionViewInfo.CalculateWidth: Integer;
begin
  Result := FRowViewInfo.CaptionWidth;
end;

function TcxGridCardRowCaptionViewInfo.CalculateHeight: Integer;
begin
  Result := GetTextCellHeight(GridViewInfo, LookAndFeelPainter);
end;

function TcxGridCardRowCaptionViewInfo.CanShowEdit: Boolean;
begin
  Result := False;
end;

function TcxGridCardRowCaptionViewInfo.CanShowHint: Boolean;
begin
  Result := GridView.OptionsBehavior.RowCaptionHints;
end;

function TcxGridCardRowCaptionViewInfo.GetAlignmentHorz: TAlignment;
begin
  Result := Row.CaptionAlignmentHorz;
end;

function TcxGridCardRowCaptionViewInfo.GetAlignmentVert: TcxAlignmentVert;
begin
  Result := Row.CaptionAlignmentVert;
end;

function TcxGridCardRowCaptionViewInfo.GetAutoHeight: Boolean;
begin
  Result := GridView.OptionsView.RowCaptionAutoHeight;
end;

function TcxGridCardRowCaptionViewInfo.GetFilterButtonBounds: TRect;
begin
  Result := TextAreaBounds;
  with Result do
  begin
    Left := Right + cxGridCellTextOffset;
    Right := Left + FFilterButtonViewInfo.Width;
  end;
end;

function TcxGridCardRowCaptionViewInfo.GetFilterButtonViewInfoClass: TcxGridCardRowFilterButtonViewInfoClass;
begin
  Result := TcxGridCardRowFilterButtonViewInfo;
end;

function TcxGridCardRowCaptionViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridCardRowCaptionHitTest;
end;

function TcxGridCardRowCaptionViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridCardRowCaptionPainter;
end;

function TcxGridCardRowCaptionViewInfo.GetShowEndEllipsis: Boolean;
begin
  Result := GridView.OptionsView.RowCaptionEndEllipsis;
end;

function TcxGridCardRowCaptionViewInfo.GetText: string;
begin
  Result := Row.VisibleCaption;
end;

function TcxGridCardRowCaptionViewInfo.GetTextAreaBounds: TRect;
begin
  Result := inherited GetTextAreaBounds;
  if FFilterButtonViewInfo.Visible then
    Dec(Result.Right, cxGridCellTextOffset + FFilterButtonViewInfo.Width);
end;

procedure TcxGridCardRowCaptionViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  FRowViewInfo.GetCaptionViewParams(AParams);
end;

function TcxGridCardRowCaptionViewInfo.GetVisible: Boolean;
begin
  Result := Row.Options.ShowCaption;
end;

procedure TcxGridCardRowCaptionViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  inherited;
  TcxGridCardRowCaptionHitTest(AHitTest).RowContainerKind := ckRows;
end;

function TcxGridCardRowCaptionViewInfo.UseStandardNeedShowHint: Boolean;
begin
  Result := True;
end;

procedure TcxGridCardRowCaptionViewInfo.Calculate(ALeftBound, ATopBound: Integer;
  AWidth: Integer = -1; AHeight: Integer = -1);
begin
  inherited;
  if FFilterButtonViewInfo.Visible then
    FFilterButtonViewInfo.Calculate(FilterButtonBounds);
end;

function TcxGridCardRowCaptionViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
begin
  if FFilterButtonViewInfo.Visible then
  begin
    Result := FFilterButtonViewInfo.GetHitTest(P);
    if Result <> nil then Exit;
  end;
  Result := inherited GetHitTest(P);
end;

{ TcxGridCardRowDataViewInfo }

function TcxGridCardRowDataViewInfo.CalculateHeight: Integer;
begin
  CalculateParams;
  if MultiLine then
    Result := inherited CalculateHeight
  else
    Result := Row.CalculateDefaultCellHeight(Canvas, Params.Font);
  Result := CardViewInfo.RecordsViewInfo.GetCellHeight(Result);
end;

function TcxGridCardRowDataViewInfo.CalculateWidth: Integer;
begin
  Result := FRowViewInfo.DataWidth;
end;

function TcxGridCardRowDataViewInfo.GetAutoHeight: Boolean;
begin
  Result := CardViewInfo.RecordsViewInfo.AutoDataCellHeight;
end;

function TcxGridCardRowDataViewInfo.GetText: string;
begin
  Result := inherited GetText;
  if (Result = '') and not RowViewInfo.CaptionViewInfo.Visible then
    Result := '<' + Row.Caption +  '>';
end;

procedure TcxGridCardRowDataViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  FRowViewInfo.GetDataViewParams(AParams);
end;

{ TcxGridCardRowViewInfo }

constructor TcxGridCardRowViewInfo.Create(ACardViewInfo: TcxGridCardViewInfo;
  AIndex: Integer);
begin
  inherited Create(ACardViewInfo.GridViewInfo);
  FCardViewInfo := ACardViewInfo;
  FIndex := AIndex;
  CreateViewInfos;
end;

destructor TcxGridCardRowViewInfo.Destroy;
begin
  DestroyViewInfos;
  inherited;
end;

function TcxGridCardRowViewInfo.GetCaptionWidth: Integer;
begin
  if FCaptionViewInfo.Visible then
    Result := CardViewInfo.CaptionWidth
  else
    Result := 0;
end;

function TcxGridCardRowViewInfo.GetDataWidth: Integer;
begin
  Result := CardViewInfo.ContentWidth - CaptionWidth;
end;

function TcxGridCardRowViewInfo.GetGridView: TcxGridCardView;
begin
  Result := TcxGridCardView(inherited GridView);
end;

function TcxGridCardRowViewInfo.GetGridRecord: TcxGridCard;
begin
  Result := FCardViewInfo.GridRecord;
end;

function TcxGridCardRowViewInfo.GetGridViewInfo: TcxGridCardViewViewInfo;
begin
  Result := TcxGridCardViewViewInfo(inherited GridViewInfo);
end;

function TcxGridCardRowViewInfo.GetMaxHeight: Integer;
begin
  Result := FCardViewInfo.MaxRowViewInfoHeight;
end;

function TcxGridCardRowViewInfo.GetRow: TcxGridCardViewRow;
begin
  Result := GridView.VisibleRows[FIndex];
end;

procedure TcxGridCardRowViewInfo.CreateViewInfos;
begin
  FCaptionViewInfo := GetCaptionViewInfoClass.Create(Self);
  FDataViewInfo := GetDataViewInfoClass.Create(Self); 
end;

procedure TcxGridCardRowViewInfo.DestroyViewInfos;
begin
  FreeAndNil(FDataViewInfo);
  FreeAndNil(FCaptionViewInfo);
end;

function TcxGridCardRowViewInfo.CalculateCaptionWidth: Integer;
begin
  Result := FCaptionViewInfo.CalculateRealWidth;
end;

function TcxGridCardRowViewInfo.CalculateHeight: Integer;
begin
  if CardViewInfo.RecordsViewInfo.UseCardHeight then
    Result := CardViewInfo.RecordsViewInfo.CardRowHeights[Index]
  else
  begin
    Result := FDataViewInfo.CalculateHeight;
    if FCaptionViewInfo.Visible then
      Result := Max(Result, FCaptionViewInfo.CalculateHeight);
    Row.CheckHeight(Result);
  end;
end;

function TcxGridCardRowViewInfo.CalculatePartVisible: Boolean;
begin
  Result := Bounds.Top < CardViewInfo.ContentBounds.Bottom;
end;

function TcxGridCardRowViewInfo.CalculateVisible: Boolean;
begin
  Result := Bounds.Bottom <= CardViewInfo.ContentBounds.Bottom;
end;

function TcxGridCardRowViewInfo.CalculateWidth: Integer;
begin
  Result := 0;
end;

function TcxGridCardRowViewInfo.GetCaptionViewInfoClass: TcxGridCardRowCaptionViewInfoClass;
begin
  Result := TcxGridCardRowCaptionViewInfo;
end;

function TcxGridCardRowViewInfo.GetCellBackgroundBitmap(ACell: TcxGridCardRowCellViewInfo): TBitmap;
begin
  Result := GridView.BackgroundBitmaps.GetBitmap(bbContent);
end;

function TcxGridCardRowViewInfo.GetCellTransparent(ACell: TcxGridCardRowCellViewInfo): Boolean;
begin
  Result := ACell.BackgroundBitmap <> nil;
end;

function TcxGridCardRowViewInfo.GetDataViewInfoClass: TcxGridCardRowDataViewInfoClass;
begin
  Result := TcxGridCardRowDataViewInfo;
end;

function TcxGridCardRowViewInfo.GetHeight: Integer;
begin
  if FHeight = 0 then
    FHeight := CalculateHeight;
  Result := FHeight;
end;

function TcxGridCardRowViewInfo.GetHidden: Boolean;
begin
  Result := FCardViewInfo.VisibleRowViewInfoIndexOf(Self) = -1;
end;

function TcxGridCardRowViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := nil;
end;

function TcxGridCardRowViewInfo.GetIsDesignSelected: Boolean;
begin
  Result := GridView.IsDesigning and
    GridView.Controller.DesignController.IsObjectSelected(Row);
end;

function TcxGridCardRowViewInfo.GetIsVisibleForPainting: Boolean;
begin
  Result := FPartVisible;
end;

function TcxGridCardRowViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridCardRowPainter;
end;

procedure TcxGridCardRowViewInfo.BeforeRecalculation;
begin
  inherited;
  FCaptionViewInfo.BeforeRecalculation;
  FDataViewInfo.BeforeRecalculation;
  Visible := False;
  FPartVisible := False;
end;

procedure TcxGridCardRowViewInfo.Calculate(const ABounds: TRect);
begin
  Bounds := ABounds;
  CalculateVisibles;
  FCaptionViewInfo.Calculate(ABounds.Left, ABounds.Top, -1, Height);
  FDataViewInfo.Calculate(ABounds.Left + FCaptionViewInfo.Width, ABounds.Top, -1, Height);
end;

procedure TcxGridCardRowViewInfo.CalculateVisibles;
begin
  FPartVisible := CalculatePartVisible;
  Visible := CalculateVisible;
end;

function TcxGridCardRowViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
begin
  Result := TcxGridRecordCellHitTest(CaptionViewInfo.GetHitTest(P));
  if Result = nil then
    Result := TcxGridRecordCellHitTest(DataViewInfo.GetHitTest(P));
end;

{ TcxGridCardDataRowViewInfo }

procedure TcxGridCardDataRowViewInfo.GetCaptionViewParams(var AParams: TcxViewParams);
begin
  Row.Styles.GetCaptionParams(GridRecord, AParams);
end;

function TcxGridCardDataRowViewInfo.GetCellBackgroundBitmap(ACell: TcxGridCardRowCellViewInfo): TBitmap;
begin  {4}
  if ACell = CaptionViewInfo then
    Result := GridView.BackgroundBitmaps.GetBitmap(bbRowCaption)
  else
    Result := inherited GetCellBackgroundBitmap(ACell);
end;

procedure TcxGridCardDataRowViewInfo.GetDataViewParams(var AParams: TcxViewParams);
begin
  Row.Styles.GetContentParams(GridRecord, AParams);
end;

{ TcxGridCardCaptionRowCaptionViewInfo }

function TcxGridCardCaptionRowCaptionViewInfo.GetTextAreaBounds: TRect;
begin
  Result := inherited GetTextAreaBounds;
  if Row.HasCardExpandButton and (CardViewInfo.ExpandButtonAlignment = cebaLeft) then
    Inc(Result.Left, CardViewInfo.ExpandButtonAreaWidth);
end;

{ TcxGridCardCaptionRowDataViewInfo }

procedure TcxGridCardCaptionRowDataViewInfo.GetEditViewDataContentOffsets(var R: TRect);
var
  R1, R2: TRect;
begin
  inherited;
  R1 := inherited GetTextAreaBounds;
  R2 := TextAreaBounds;
  Inc(R.Left, R2.Left - R1.Left);
  Inc(R.Right, R1.Right - R2.Right);
end;

function TcxGridCardCaptionRowDataViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridCardRowCellHitTest;
end;

function TcxGridCardCaptionRowDataViewInfo.GetTextAreaBounds: TRect;
begin
  Result := inherited GetTextAreaBounds;
  if Row.HasCardExpandButton then
    case CardViewInfo.ExpandButtonAlignment of
      cebaLeft:
        if not RowViewInfo.CaptionViewInfo.Visible then
          Inc(Result.Left, CardViewInfo.ExpandButtonAreaWidth);
      cebaRight:
        Dec(Result.Right, CardViewInfo.ExpandButtonAreaWidth);
    end;
end;

{ TcxGridCardCaptionRowViewInfo }

function TcxGridCardCaptionRowViewInfo.GetCaptionViewInfoClass: TcxGridCardRowCaptionViewInfoClass;
begin
  Result := TcxGridCardCaptionRowCaptionViewInfo;
end;

procedure TcxGridCardCaptionRowViewInfo.GetCaptionViewParams(var AParams: TcxViewParams);
begin
  GetViewParams(AParams);
end;

function TcxGridCardCaptionRowViewInfo.GetCellBackgroundBitmap(ACell: TcxGridCardRowCellViewInfo): TBitmap;
begin
  Result := GridView.BackgroundBitmaps.GetBitmap(bbCaptionRow);
end;

function TcxGridCardCaptionRowViewInfo.GetCellTransparent(ACell: TcxGridCardRowCellViewInfo): Boolean;
begin   
  Result := inherited GetCellTransparent(ACell) and not ACell.Selected;
end;

function TcxGridCardCaptionRowViewInfo.GetDataViewInfoClass: TcxGridCardRowDataViewInfoClass;
begin
  Result := TcxGridCardCaptionRowDataViewInfo;
end;

procedure TcxGridCardCaptionRowViewInfo.GetDataViewParams(var AParams: TcxViewParams);
begin
  GetViewParams(AParams);
end;

procedure TcxGridCardCaptionRowViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  GridView.Styles.GetDataCellParams(GridRecord, Row, AParams);
end;

{ TcxCustomGridCardScrollButtonViewInfo }

constructor TcxCustomGridCardScrollButtonViewInfo.Create(ACardViewInfo: TcxGridCardViewInfo);
begin
  inherited Create(ACardViewInfo.GridViewInfo);
  FCardViewInfo := ACardViewInfo;
end;

procedure TcxCustomGridCardScrollButtonViewInfo.ScrollTimerHandler(Sender: TObject);
begin
  if Visible then
    Scroll
  else
    StopAutoScrolling;
end;

function TcxCustomGridCardScrollButtonViewInfo.CalculateHeight: Integer;
begin
  Result := 0;
end;

function TcxCustomGridCardScrollButtonViewInfo.CalculateWidth: Integer;
begin
  Result := Width;
end;

function TcxCustomGridCardScrollButtonViewInfo.CaptureMouseOnPress: Boolean;
begin
  Result := True;
end;

function TcxCustomGridCardScrollButtonViewInfo.GetHotTrack: Boolean;
begin
  Result := True;
end;

function TcxCustomGridCardScrollButtonViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridCardScrollButtonPainter;
end;

procedure TcxCustomGridCardScrollButtonViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  FCardViewInfo.InitHitTest(AHitTest);
  inherited;
end;

procedure TcxCustomGridCardScrollButtonViewInfo.StateChanged;
begin
  inherited;
  case State of
    gcsSelected:
      StopAutoScrolling;
    gcsPressed:
      begin
        Scroll;
        StartAutoScrolling;
      end;
    gcsNone:
      StopAutoScrolling;
  end;
end;

procedure TcxCustomGridCardScrollButtonViewInfo.StartAutoScrolling;
begin
  FScrollTimer := TcxTimer.Create(nil);
  with FScrollTimer do
  begin
    Interval := CardScrollingInterval;
    OnTimer := ScrollTimerHandler;
  end;
end;

procedure TcxCustomGridCardScrollButtonViewInfo.StopAutoScrolling;
begin
  FreeAndNil(FScrollTimer);
end;

{ TcxGridCardScrollButtonDownViewInfo }

function TcxGridCardScrollButtonDownViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridCardScrollButtonDownHitTest;
end;

function TcxGridCardScrollButtonDownViewInfo.GetIsDownButton: Boolean;
begin
  Result := True;
end;

function TcxGridCardScrollButtonDownViewInfo.GetVisible: Boolean;
begin
  Result := CardViewInfo.NeedsScrollingDown;
end;

procedure TcxGridCardScrollButtonDownViewInfo.Scroll;
begin
  with CardViewInfo do
    TopRowIndex := TopRowIndex + 1;
end;

{ TcxGridCardScrollButtonUpViewInfo }

function TcxGridCardScrollButtonUpViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridCardScrollButtonUpHitTest;
end;

function TcxGridCardScrollButtonUpViewInfo.GetIsDownButton: Boolean;
begin
  Result := False;
end;

function TcxGridCardScrollButtonUpViewInfo.GetVisible: Boolean;
begin
  Result := CardViewInfo.NeedsScrollingUp;
end;

procedure TcxGridCardScrollButtonUpViewInfo.Scroll;
begin
  with CardViewInfo do
    TopRowIndex := TopRowIndex - 1;
end;

{ TcxGridCardExpandButtonViewInfo }

constructor TcxGridCardExpandButtonViewInfo.Create(ACardViewInfo: TcxGridCardViewInfo);
begin
  inherited Create(ACardViewInfo.GridViewInfo);
  FCardViewInfo := ACardViewInfo;
end;

function TcxGridCardExpandButtonViewInfo.CalculateHeight: Integer;
begin
  Result := 0;
end;

function TcxGridCardExpandButtonViewInfo.CalculateWidth: Integer;
begin
  Result := 0;
end;

function TcxGridCardExpandButtonViewInfo.CaptureMouseOnPress: Boolean;
begin
  Result := True;
end;

procedure TcxGridCardExpandButtonViewInfo.Click;
begin
  inherited;
  with FCardViewInfo do
    Expanded := not Expanded;
end;

function TcxGridCardExpandButtonViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridExpandButtonHitTest;
end;

function TcxGridCardExpandButtonViewInfo.GetHotTrack: Boolean;
begin
  Result := True;
end;

function TcxGridCardExpandButtonViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridCardExpandButtonPainter;
end;

function TcxGridCardExpandButtonViewInfo.GetVisible: Boolean;
begin
  Result := FCardViewInfo.GridRecord.Expandable;
end;

procedure TcxGridCardExpandButtonViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  inherited;
  TcxGridExpandButtonHitTest(AHitTest).GridRecord := FCardViewInfo.GridRecord;
end;

function TcxGridCardExpandButtonViewInfo.HasPoint(const P: TPoint): Boolean;
begin
  Result := inherited HasPoint(P) and
    LookAndFeelPainter.IsPointOverGroupExpandButton(Bounds, P);
end;

{ TcxGridCardViewInfo }

constructor TcxGridCardViewInfo.Create(ARecordsViewInfo: TcxCustomGridRecordsViewInfo;
  ARecord: TcxCustomGridRecord);
begin
  inherited;
  FCaptionWidth := -1;
  CreateRowViewInfos;
  CreateScrollButtons;
  FExpandButtonViewInfo := GetExpandButtonViewInfoClass.Create(Self);
end;

destructor TcxGridCardViewInfo.Destroy;
begin
  FreeAndNil(FExpandButtonViewInfo);
  DestroyScrollButtons;
  DestroyRowViewInfos;
  inherited;
end;

function TcxGridCardViewInfo.GetCacheItem: TcxGridCardViewInfoCacheItem;
begin
  Result := TcxGridCardViewInfoCacheItem(inherited CacheItem);
end;

function TcxGridCardViewInfo.GetCaptionWidth: Integer;
begin
  if FCaptionWidth = -1 then
    FCaptionWidth := CalculateCaptionWidth;
  Result := FCaptionWidth;
end;

function TcxGridCardViewInfo.GetCardBorderWidth: Integer;
begin
  Result := RecordsViewInfo.CardBorderWidth;
end;

function TcxGridCardViewInfo.GetFirstCaptionRowViewInfo: TcxGridCardRowViewInfo;
var
  ARow: TcxGridCardViewRow;
begin
  ARow := GridView.FirstCaptionRow;
  if ARow = nil then
    Result := nil
  else
    Result := RowViewInfos[ARow.VisibleIndex];
end;

function TcxGridCardViewInfo.GetGridView: TcxGridCardView;
begin
  Result := TcxGridCardView(inherited GridView);
end;

function TcxGridCardViewInfo.GetGridRecord: TcxGridCard;
begin
  Result := TcxGridCard(inherited GridRecord);
end;

function TcxGridCardViewInfo.GetRecordsViewInfo: TcxGridCardsViewInfo;
begin
  Result := TcxGridCardsViewInfo(inherited RecordsViewInfo);
end;

function TcxGridCardViewInfo.GetRowViewInfo(Index: Integer): TcxGridCardRowViewInfo;
begin
  Result := TcxGridCardRowViewInfo(FRowViewInfos[Index]);
end;

function TcxGridCardViewInfo.GetRowViewInfoCount: Integer;
begin
  Result := FRowViewInfos.Count;
end;

function TcxGridCardViewInfo.GetTopRowIndex: Integer;
begin
  if CacheItem.IsTopRowIndexAssigned then
    Result := CacheItem.TopRowIndex
  else
  begin
    Result := 0;
    CacheItem.TopRowIndex := Result;
  end;
end;

function TcxGridCardViewInfo.GetVisibleRowViewInfo(Index: Integer): TcxGridCardRowViewInfo;
begin
  Result := TcxGridCardRowViewInfo(FVisibleRowViewInfos[Index]);
end;

function TcxGridCardViewInfo.GetVisibleRowViewInfoCount: Integer;
begin
  Result := FVisibleRowViewInfos.Count;
end;

procedure TcxGridCardViewInfo.SetTopRowIndex(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if TopRowIndex <> Value then
  begin
    CacheItem.TopRowIndex := Value;
    Recalculate;
    Invalidate;
  end;
end;

procedure TcxGridCardViewInfo.CreateRowViewInfos;
var
  I: Integer;
  ARow: TcxGridCardViewRow;
begin
  FRowViewInfos := TList.Create;
  for I := 0 to GridView.VisibleRowCount - 1 do
  begin
    ARow := GridView.VisibleRows[I];
    FRowViewInfos.Add(GetRowViewInfoClass(ARow).Create(Self, I));
  end;
  FVisibleRowViewInfos := TList.Create;
end;

procedure TcxGridCardViewInfo.DestroyRowViewInfos;
var
  I: Integer;
begin
  FreeAndNil(FVisibleRowViewInfos);
  for I := 0 to RowViewInfoCount - 1 do RowViewInfos[I].Free;
  FreeAndNil(FRowViewInfos);
end;

procedure TcxGridCardViewInfo.CreateScrollButtons;
begin
  FScrollButtonDown := GetScrollButtonDownViewInfoClass.Create(Self);
  FScrollButtonUp := GetScrollButtonUpViewInfoClass.Create(Self);
end;

procedure TcxGridCardViewInfo.DestroyScrollButtons;
begin
  FreeAndNil(FScrollButtonUp);
  FreeAndNil(FScrollButtonDown);
end;

function TcxGridCardViewInfo.CalculateCaptionWidth: Integer;
var
  I, ACaptionWidth: Integer;
  ARowViewInfo: TcxGridCardRowViewInfo;
begin
  Result := GridView.OptionsView.CaptionWidth;
  if Result = 0 then
  begin
    for I := 0 to VisibleRowViewInfoCount - 1 do
    begin
      ARowViewInfo := VisibleRowViewInfos[I];
      if ARowViewInfo.CaptionViewInfo.Visible then
      begin
        ACaptionWidth := ARowViewInfo.CalculateCaptionWidth;
        if ACaptionWidth > Result then Result := ACaptionWidth;
      end;
    end;
    Inc(Result, CardDataIndent);
  end;
  if Result > RecordsViewInfo.CardContentWidth then
    Result := RecordsViewInfo.CardContentWidth;
end;

procedure TcxGridCardViewInfo.CalculateExpandButtonBounds(var ABounds: TRect);
var
  ASize: Integer;
begin
  ABounds := ExpandButtonAreaBounds;
  if IsRectEmpty(ABounds) then Exit;
  ASize := ExpandButtonSize;
  with ABounds do
  begin
    Left := (Left + Right - ASize) div 2;
    Right := Left + ASize;
    Top := (Top + Bottom - ASize) div 2;
    Bottom := Top + ASize;
  end;
end;

function TcxGridCardViewInfo.CalculateHeight: Integer;
var
  I: Integer;
begin
  if RecordsViewInfo.UseCardHeight then
    Result := RecordsViewInfo.CardHeight
  else
  begin
    CalculateParams;
    CalculateVisibleRowViewInfosList;
    Result := 2 * CardBorderWidth;
    for I := 0 to VisibleRowViewInfoCount - 1 do
      Inc(Result, VisibleRowViewInfos[I].Height);
  end;
{  if Result > RecordsViewInfo.MaxCardHeight then
    Result := RecordsViewInfo.MaxCardHeight;}
end;

procedure TcxGridCardViewInfo.CalculateVisibleRowViewInfosList;
var
  I: Integer;
begin
  GridRecord.GetVisibleRows(FVisibleRowViewInfos);
  for I := 0 to FVisibleRowViewInfos.Count - 1 do
    FVisibleRowViewInfos[I] := RowViewInfos[TcxGridCardViewRow(FVisibleRowViewInfos[I]).VisibleIndex];
end;

function TcxGridCardViewInfo.CalculateWidth: Integer;
begin       
  Result := Width;
end;

function TcxGridCardViewInfo.CanGenerateExpandButtonHitTest: Boolean;
begin
  Result := False;
end;

function TcxGridCardViewInfo.GetAutoHeight: Boolean;
begin
  Result := RecordsViewInfo.AutoDataRecordHeight;
end;

function TcxGridCardViewInfo.GetBackgroundBitmapBounds: TRect;
begin
  Result := RestSpaceBounds;
end;

function TcxGridCardViewInfo.GetCardBorderBackgroundBitmap: TBitmap;
begin
  Result := GridView.BackgroundBitmaps.GetBitmap(bbCardBorder);
end;

function TcxGridCardViewInfo.GetCardBorderColor: TColor;
var
  AParams: TcxViewParams;
begin
  GridView.Styles.GetCardBorderParams(GridRecord, AParams);
  Result := AParams.Color;
end;

function TcxGridCardViewInfo.GetContentBounds: TRect;
begin
  Result := inherited GetContentBounds;
  InflateRect(Result, -CardBorderWidth, -CardBorderWidth);
  Inc(Result.Top, FScrollButtonUp.Height);
  Dec(Result.Bottom, FScrollButtonDown.Height);
end;

function TcxGridCardViewInfo.GetContentHeight: Integer;
begin
  with ContentBounds do
    Result := Bottom - Top;
end;

function TcxGridCardViewInfo.GetContentWidth: Integer;
begin
  with ContentBounds do
    Result := Right - Left;
end;

function TcxGridCardViewInfo.GetExpandButtonAlignment: TcxGridCardExpandButtonAlignment;
begin
  Result := GridView.OptionsView.CardExpandButtonAlignment;
end;

function TcxGridCardViewInfo.GetExpandButtonAreaBounds: TRect;
var
  ARowViewInfo: TcxGridCardRowViewInfo;
  AOwnerViewInfo: TcxGridCardRowCellViewInfo;
begin
  ARowViewInfo := FirstCaptionRowViewInfo;
  if (ARowViewInfo = nil) or not ARowViewInfo.PartVisible then
    SetRectEmpty(Result)
  else
  begin
    Result := ARowViewInfo.Bounds;
    case ExpandButtonAlignment of
      cebaLeft:
        begin
          Result.Right := Result.Left + ExpandButtonAreaWidth;
          if ARowViewInfo.CaptionViewInfo.Visible then
            AOwnerViewInfo := ARowViewInfo.CaptionViewInfo
          else
            AOwnerViewInfo := ARowViewInfo.DataViewInfo;
        end;
      cebaRight:
        begin
          Result.Left := Result.Right - ExpandButtonAreaWidth;
          AOwnerViewInfo := ARowViewInfo.DataViewInfo;
        end;
    else
      AOwnerViewInfo := nil;
    end;
    if IsRectEmpty(AOwnerViewInfo.TextAreaBounds) then
      SetRectEmpty(Result);
  end;
end;

function TcxGridCardViewInfo.GetExpandButtonAreaWidth: Integer;
begin
  Result := CardExpandButtonOffset + ExpandButtonSize + CardExpandButtonOffset;
end;

function TcxGridCardViewInfo.GetExpandButtonSize: Integer;
begin
  Result := LookAndFeelPainter.GroupExpandButtonSize;
end;

function TcxGridCardViewInfo.GetHeight: Integer;
begin
  Result := Min(inherited GetHeight, RecordsViewInfo.MaxCardHeight);
end;

function TcxGridCardViewInfo.GetMaxRowViewInfoHeight: Integer;
begin
  Result := ContentHeight;
  if NeedsScrollingUp then
    Dec(Result, ScrollButtonHeight);
end;

function TcxGridCardViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridCardPainter;
end;

function TcxGridCardViewInfo.GetRestSpaceBounds: TRect;
begin
  if (VisibleRowCount = 0) or not NeedsScrollingUp or NeedsScrollingDown then
    SetRectEmpty(Result)
  else
  begin
    Result := ContentBounds;
    Result.Top := RowViewInfos[TopRowIndex + VisibleRowCount - 1].Bounds.Bottom;
  end;
end;

function TcxGridCardViewInfo.GetScrollableAreaBounds: TRect;
begin
  Result := ContentBounds;
  if FScrollButtonUp.Visible then
    Result.Top := FScrollButtonUp.Bounds.Bottom;
  if FScrollButtonDown.Visible then
    Result.Bottom := FScrollButtonDown.Bounds.Top;
end;

function TcxGridCardViewInfo.GetScrollButtonDownBounds: TRect;
begin
  Result := ContentBounds;
  with Result do
    Top := Bottom - ScrollButtonHeight;
end;

function TcxGridCardViewInfo.GetScrollButtonDownViewInfoClass: TcxGridCardScrollButtonDownViewInfoClass;
begin
  Result := TcxGridCardScrollButtonDownViewInfo;
end;

function TcxGridCardViewInfo.GetScrollButtonUpViewInfoClass: TcxGridCardScrollButtonUpViewInfoClass;
begin
  Result := TcxGridCardScrollButtonUpViewInfo;
end;

function TcxGridCardViewInfo.GetScrollButtonHeight: Integer;
begin
  Result := MulDiv(GetScrollBarSize.cy, 3, 4);
end;

function TcxGridCardViewInfo.GetScrollButtonUpBounds: TRect;
begin
  Result := ContentBounds;
  with Result do
    Bottom := Top + ScrollButtonHeight;
end;

procedure TcxGridCardViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  GridView.Styles.GetRecordContentParams(GridRecord, nil, AParams);
end;

function TcxGridCardViewInfo.GetVisible: Boolean;
begin
  Result := Index < RecordsViewInfo.PartVisibleCount;
end;

function TcxGridCardViewInfo.GetWidth: Integer;
begin
  Result := RecordsViewInfo.CardWidth;
end;

function TcxGridCardViewInfo.GetExpandButtonViewInfoClass: TcxGridCardExpandButtonViewInfoClass;
begin
  Result := TcxGridCardExpandButtonViewInfo;
end;

function TcxGridCardViewInfo.GetRowViewInfoClass(ARow: TcxGridCardViewRow): TcxGridCardRowViewInfoClass;
const
  RowViewInfoClasses: array[TcxGridCardViewRowKind] of TcxGridCardRowViewInfoClass =
    (TcxGridCardDataRowViewInfo, TcxGridCardCaptionRowViewInfo);
begin
  Result := RowViewInfoClasses[ARow.Kind];
end;

procedure TcxGridCardViewInfo.BeforeRecalculation;
var
  I: Integer;
begin
  FVisibleRowCount := 0;
  FPartVisibleRowCount := 0;
  inherited;
  for I := 0 to RowViewInfoCount - 1 do
    RowViewInfos[I].BeforeRecalculation;
  FExpandButtonViewInfo.BeforeRecalculation;  
end;

procedure TcxGridCardViewInfo.Calculate(ALeftBound, ATopBound: Integer;
  AWidth: Integer = -1; AHeight: Integer = -1);

  procedure CalculateRows;
  var
    R: TRect;
    I: Integer;
  begin
    FVisibleRowCount := 0;
    FPartVisibleRowCount := 0;
    R := ContentBounds;
    if NeedsScrollingUp then
      Inc(R.Top, ScrollButtonHeight);
    for I := TopRowIndex to VisibleRowViewInfoCount - 1 do
      with VisibleRowViewInfos[I] do
      begin
        Height := Min(Height, MaxHeight);
        R.Bottom := R.Top + Height;
        Calculate(R);
        if Visible then Inc(FVisibleRowCount);
        if PartVisible then
          Inc(FPartVisibleRowCount)
        else
          Break;
        R.Top := R.Bottom;
      end;
  end;

  procedure RecalculateRowVisibles;
  var
    I: Integer;
  begin
    FVisibleRowCount := 0;
    FPartVisibleRowCount := 0;
    for I := TopRowIndex to VisibleRowViewInfoCount - 1 do
      with VisibleRowViewInfos[I] do
      begin
        CalculateVisibles;
        if Visible then Inc(FVisibleRowCount);
        if PartVisible then
          Inc(FPartVisibleRowCount)
        else
          Break;
      end;
  end;

begin
  CalculateVisibleRowViewInfosList;
  SetRectEmpty(FScrollButtonDown.Bounds);
  SetRectEmpty(FScrollButtonUp.Bounds);
  inherited;
  CalculateRows;
  if FScrollButtonDown.Visible then
    FScrollButtonDown.Calculate(ScrollButtonDownBounds);
  if FScrollButtonUp.Visible then
    FScrollButtonUp.Calculate(ScrollButtonUpBounds);
  RecalculateRowVisibles;
end;

function TcxGridCardViewInfo.GetBoundsForItem(AItem: TcxCustomGridTableItem): TRect;
begin
  with RowViewInfos[AItem.VisibleIndex] do
    if Hidden then
      Result := inherited GetBoundsForItem(AItem)
    else
      Result := Bounds;
end;

function TcxGridCardViewInfo.GetCellViewInfoByItem(AItem: TcxCustomGridTableItem): TcxGridTableDataCellViewInfo;
begin
  if AItem.VisibleIndex = -1 then
    Result := nil
  else
    Result := RowViewInfos[AItem.VisibleIndex].DataViewInfo;
end;

function TcxGridCardViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
var
  I: Integer;
  AHitTest: TcxCustomGridHitTest;
begin
  Result := FScrollButtonUp.GetHitTest(P);
  if Result = nil then
  begin
    Result := FScrollButtonDown.GetHitTest(P);
    if Result = nil then
    begin
      Result := FExpandButtonViewInfo.GetHitTest(P);
      if Result = nil then
      begin
        Result := inherited GetHitTest(P);
        if Result <> nil then
          for I := TopRowIndex to TopRowIndex + PartVisibleRowCount - 1 do
          begin
            AHitTest := VisibleRowViewInfos[I].GetHitTest(P);
            if AHitTest <> nil then
            begin
              Result := AHitTest;
              Exit;
            end;
          end;
      end;
    end;
  end;
end;

function TcxGridCardViewInfo.IsFullyVisible: Boolean;
begin
  Result := (inherited GetHeight <= RecordsViewInfo.MaxCardHeight){ and
    not (NeedsScrollingUp or NeedsScrollingDown)};
end;

procedure TcxGridCardViewInfo.MainCalculate(ALeftBound, ATopBound: Integer);
begin
  inherited;
  if FExpandButtonViewInfo.Visible then
    FExpandButtonViewInfo.Calculate(ExpandButtonBounds);
end;

procedure TcxGridCardViewInfo.MakeRowVisible(ARow: TcxGridCardViewRow);
var
  AVisibleRowIndex: Integer;
begin
  AVisibleRowIndex := VisibleRowViewInfoIndexOf(ARow);
  if AVisibleRowIndex = -1 then Exit;
  if AVisibleRowIndex < TopRowIndex then
    TopRowIndex := AVisibleRowIndex
  else
    if AVisibleRowIndex >= TopRowIndex + VisibleRowCount then
      while not VisibleRowViewInfos[AVisibleRowIndex].Visible and (AVisibleRowIndex <> TopRowIndex) do
        TopRowIndex := TopRowIndex + 1;
end;

function TcxGridCardViewInfo.NeedsScrollingDown: Boolean;
begin
  Result := (TopRowIndex + VisibleRowCount < VisibleRowViewInfoCount) and
    ((VisibleRowCount > 0) or (TopRowIndex <> VisibleRowViewInfoCount - 1));
end;

function TcxGridCardViewInfo.NeedsScrollingUp: Boolean;
begin
  Result := TopRowIndex > 0;
end;

function TcxGridCardViewInfo.VisibleRowViewInfoIndexOf(ARow: TcxGridCardViewRow): Integer;
begin
  if ARow.VisibleIndex = -1 then
    Result := -1
  else
    Result := VisibleRowViewInfoIndexOf(RowViewInfos[ARow.VisibleIndex]);
end;

function TcxGridCardViewInfo.VisibleRowViewInfoIndexOf(ARowViewInfo: TcxGridCardRowViewInfo): Integer;
begin
  Result := FVisibleRowViewInfos.IndexOf(ARowViewInfo);
end;

{ TcxGridCardsViewInfo }

constructor TcxGridCardsViewInfo.Create(AGridViewInfo: TcxCustomGridTableViewInfo);
begin
  inherited;
  FCardHeight := -1;
  FColumns := TcxGridCardViewColumns.Create(Self);
end;

destructor TcxGridCardsViewInfo.Destroy;
begin
  FColumns.Free;
  inherited;
end;

function TcxGridCardsViewInfo.GetCardBorderWidth: Integer;
begin
  Result := GridView.OptionsView.CardBorderWidth;
end;

function TcxGridCardsViewInfo.GetCardWidth: Integer;
begin
  Result := GridView.OptionsView.CardWidth;
end;

function TcxGridCardsViewInfo.GetCardContentWidth: Integer;
begin
  Result := CardWidth - 2 * CardBorderWidth;
end;

function TcxGridCardsViewInfo.GetGridContentBounds: TRect;
begin
  Result := GridViewInfo.ClientBounds;
end;

function TcxGridCardsViewInfo.GetGridView: TcxGridCardView;
begin
  Result := TcxGridCardView(inherited GridView);
end;

function TcxGridCardsViewInfo.GetGridViewInfo: TcxGridCardViewViewInfo;
begin
  Result := TcxGridCardViewViewInfo(inherited GridViewInfo);
end;

function TcxGridCardsViewInfo.GetItem(Index: Integer): TcxGridCardViewInfo;
begin
  Result := TcxGridCardViewInfo(inherited Items[Index]);
end;

function TcxGridCardsViewInfo.GetViewData: TcxGridCardViewViewData;
begin
  Result := TcxGridCardViewViewData(inherited ViewData);
end;

procedure TcxGridCardsViewInfo.Calculate;
begin
  inherited;
  FCardHeight := CalculateCardHeight;
  FMaxCardHeight := CalculateMaxCardHeight;
end;

function TcxGridCardsViewInfo.CalculateBounds: TRect;
begin
  Result := inherited CalculateBounds;
  InflateRect(Result, -CardIndent, -CardIndent);
end;

function TcxGridCardsViewInfo.CalculateCardHeight: Integer;
var
  I: Integer;

  function CalculateRowHeight(ARow: TcxGridCardViewRow): Integer;

    function GetFont(AIsCaption: Boolean): TFont;
    var
      AParams: TcxViewParams;
    begin
      if ARow.Kind = rkCaption then
        GridView.Styles.GetDataCellParams(nil, ARow, AParams)
      else
        if AIsCaption then
          ARow.Styles.GetCaptionParams(nil, AParams)
        else
          ARow.Styles.GetContentParams(nil, AParams);
      Result := AParams.Font;
    end;

    function CalculateCaptionHeight: Integer;
    begin
      if ARow.Options.ShowCaption then
      begin
        Result := GridViewInfo.GetFontHeight(GetFont(True));
        Result := TcxGridCardRowCaptionViewInfo.GetCellHeight(Result, GridViewInfo.LookAndFeelPainter);
      end
      else
        Result := 0;
    end;

    function CalculateDataHeight: Integer;
    begin
      Result := GetCellHeight(ARow.CalculateDefaultCellHeight(Canvas, GetFont(False)));
    end;

  begin
    Result := Max(CalculateCaptionHeight, CalculateDataHeight);
    ARow.CheckHeight(Result);
  end;

begin
  Result := 2 * CardBorderWidth;
  SetLength(CardRowHeights, GridView.VisibleRowCount);
  for I := 0 to GridView.VisibleRowCount - 1 do
  begin
    CardRowHeights[I] := CalculateRowHeight(GridView.VisibleRows[I]);
    Inc(Result, CardRowHeights[I]);
  end;
end;

function TcxGridCardsViewInfo.CalculateMaxCardHeight: Integer;
begin
  with Bounds do
    Result := Bottom - Top;
  if Result < 0 then Result := 0;
end;

function TcxGridCardsViewInfo.GetAutoDataCellHeight: Boolean;
begin
  Result := inherited GetAutoDataRecordHeight;
end;

function TcxGridCardsViewInfo.GetAutoDataRecordHeight: Boolean;
begin
  Result := inherited GetAutoDataRecordHeight or
    GridView.OptionsView.RowCaptionAutoHeight or
    not GridView.OptionsView.EmptyRows or
    GridView.OptionsCustomize.CardExpanding;
end;

{procedure TcxGridCardsViewInfo.GetDataCellDefaultViewParams(ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AParams: TcxViewParams);
begin
  inherited;
  RealItems[ARecord.Index].RowViewInfos[AItem.VisibleIndex].GetDefaultViewParams(AParams);
end;}

function TcxGridCardsViewInfo.GetItemLeftBound(AIndex: Integer): Integer;
begin
  Result := 0;
end;

function TcxGridCardsViewInfo.GetItemsOffset(AItemCountDelta: Integer): Integer;
begin
  Result := 0;
end;

function TcxGridCardsViewInfo.GetItemTopBound(AIndex: Integer): Integer;
begin
  Result := 0;
end;

procedure TcxGridCardsViewInfo.OffsetItem(AIndex, AOffset: Integer);
begin
end;

function TcxGridCardsViewInfo.GetRealItem(ARecord: TcxCustomGridRecord): TcxGridCardViewInfo;
begin
  Result := TcxGridCardViewInfo(inherited GetRealItem(ARecord));
end;

function TcxGridCardsViewInfo.GetZone(AHitTest: TcxCustomGridHitTest): TcxGridItemContainerZone;
var
  AGridRecord: TcxCustomGridRecord;
  ACardViewInfo: TcxGridCardViewInfo;
  ARowIndex: Integer;
  R: TRect;
begin
  if (AHitTest is TcxGridRecordHitTest) and
    TcxGridCardViewController(Controller).CanHandleHitTest(AHitTest) then
  begin
    AGridRecord := TcxGridRecordHitTest(AHitTest).GridRecord;
    ACardViewInfo := GetRealItem(AGridRecord);
    if AHitTest is TcxGridRecordCellHitTest then
    begin
      ARowIndex := TcxGridRecordCellHitTest(AHitTest).Item.VisibleIndex;
      R := ACardViewInfo.RowViewInfos[ARowIndex].Bounds;
      if AHitTest.Pos.Y >= (R.Top + R.Bottom) div 2 then
        Inc(ARowIndex);
    end
    else
      if AHitTest.HitTestCode = htCardScrollButtonUp then
        ARowIndex := ACardViewInfo.TopRowIndex
      else
        if (AHitTest.HitTestCode = htCardScrollButtonDown) or
          PtInRect(ACardViewInfo.RestSpaceBounds, AHitTest.Pos) then
          ARowIndex := ACardViewInfo.TopRowIndex + ACardViewInfo.VisibleRowCount
        else
          if ACardViewInfo.VisibleRowCount = 0 then
            ARowIndex := 0
          else
          begin
            Result := nil;
            Exit;
          end;
    Result := TcxGridRowContainerZone.Create(AGridRecord, ARowIndex);
  end
  else
    Result := nil;
end;

function TcxGridCardsViewInfo.UseCardHeight: Boolean;
begin
  Result := not AutoDataRecordHeight and (FCardHeight <> -1);
end;

{ TcxGridCardsHorizontalViewInfo }

procedure TcxGridCardsHorizontalViewInfo.Calculate;
var
  ALeftBound, ATopBound, ACol, ARow, I: Integer;
begin
  inherited;
  ACol := 0;
  ARow := 0;
  ALeftBound := Bounds.Left;
  ATopBound := Bounds.Top;

  for I := 0 to MaxCount - 1 do
  begin
    if I <> 0 then
      if ATopBound + Items[I].Height > Bounds.Bottom then
      begin
        Inc(ACol);
        ARow := 0;
        Inc(ALeftBound, Items[I - 1].Width +
          CardIndent + GridViewInfo.SeparatorsViewInfo.Width + CardIndent);
        if ALeftBound >= GridContentBounds.Right then Break;
        ATopBound := Bounds.Top;
      end;

    if GridViewInfo.CalculateDown then
    begin
      Columns[ACol][ARow] := Items[I];
      Items[I].MainCalculate(ALeftBound, ATopBound);
    end;

    if ((ALeftBound + Items[I].Width <= GridContentBounds.Right) or (ACol = 0)) then
      Inc(FVisibleCount);
    Inc(FPartVisibleCount);
    Inc(ARow);
    Inc(ATopBound, Items[I].Height + CardIndent);
  end;
end;

{ TcxGridCardsVerticalViewInfo }

procedure TcxGridCardsVerticalViewInfo.Calculate;
var
  ALeftBound, ATopBound, ARowHeight, ACol, ARow, I: Integer;
  AIsVisibleCountCalculated: Boolean;

  procedure CalcVisibleCount;
  begin
    if not AIsVisibleCountCalculated then
      if (ATopBound + Items[I].Height <= GridContentBounds.Bottom) or (ARow = 0) then
        Inc(FVisibleCount)
      else
      begin
        Dec(FVisibleCount, ACol);
        AIsVisibleCountCalculated := True;
      end;
  end;

begin
  inherited;
  ACol := 0;
  ARow := 0;
  ALeftBound := Bounds.Left;
  ATopBound := Bounds.Top;
  ARowHeight := 0;
  AIsVisibleCountCalculated := False;
  
  for I := 0 to MaxCount - 1 do
  begin
    if I <> 0 then
      if ALeftBound + Items[I].Width > Bounds.Right then
      begin
        ACol := 0;
        Inc(ARow);
        ALeftBound := Bounds.Left;
        Inc(ATopBound, ARowHeight +
          CardIndent + GridViewInfo.SeparatorsViewInfo.Width + CardIndent);
        if ATopBound >= GridContentBounds.Bottom then Break;
        ARowHeight := 0;
      end;

    if GridViewInfo.CalculateDown then
    begin
      Columns[ACol][ARow] := Items[I];
      Items[I].MainCalculate(ALeftBound, ATopBound);
    end;

    CalcVisibleCount;

    Inc(ACol);
    if ARowHeight < Items[I].Height then
      ARowHeight := Items[I].Height;
    Inc(ALeftBound, Items[I].Width + CardIndent);
  end;
  FPartVisibleCount := FVisibleCount;
end;

{ TcxGridCardViewSeparatorsViewInfo }

constructor TcxGridCardViewSeparatorsViewInfo.Create(AGridViewInfo: TcxGridCardViewViewInfo);
begin
  inherited Create;
  FGridViewInfo := AGridViewInfo;
  CreateItems;
end;

destructor TcxGridCardViewSeparatorsViewInfo.Destroy;
begin
  DestroyItems;
  inherited;
end;

function TcxGridCardViewSeparatorsViewInfo.GetColor: TColor;
begin
  Result := GridView.OptionsView.GetSeparatorColor;
end;

function TcxGridCardViewSeparatorsViewInfo.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxGridCardViewSeparatorsViewInfo.GetGridView: TcxGridCardView;
begin
  Result := FGridViewInfo.GridView;
end;

function TcxGridCardViewSeparatorsViewInfo.GetItem(Index: Integer): TRect;
begin
  Result := PRect(FItems[Index])^;
end;

function TcxGridCardViewSeparatorsViewInfo.GetRecordsViewInfo: TcxGridCardsViewInfo;
begin
  Result := FGridViewInfo.RecordsViewInfo;
end;

function TcxGridCardViewSeparatorsViewInfo.GetWidth: Integer;
begin
  Result := GridView.OptionsView.SeparatorWidth;
end;

procedure TcxGridCardViewSeparatorsViewInfo.SetItem(Index: Integer; const Value: TRect);
var
  ARect: PRect;
begin
  if Index >= Count then
  begin
    New(ARect);
    FItems.Add(ARect);
  end;
  PRect(FItems[Index])^ := Value;
end;

procedure TcxGridCardViewSeparatorsViewInfo.CreateItems;
begin
  FItems := TList.Create;
end;

procedure TcxGridCardViewSeparatorsViewInfo.DestroyItems;
var
  I: Integer;
begin
  for I := 0 to FItems.Count - 1 do Dispose(PRect(FItems[I]));
  FreeAndNil(FItems);
end;

function TcxGridCardViewSeparatorsViewInfo.GetHitTest(const P: TPoint): TcxGridCardViewSeparatorHitTest;
var
  I: Integer;
begin
  if GridView.CanCardSizing and PtInRect(GridViewInfo.ClientBounds, P) then
    for I := 0 to HitTestItemCount - 1 do
      if PtInRect(HitTestItems[I], P) then
      begin
        Result := TcxGridCardViewSeparatorHitTest(TcxGridCardViewSeparatorHitTest.Instance(P));
        Result.Separators := Self;
        Result.Index := I;
        Exit;
      end;
  Result := nil;
end;

{ TcxGridCardViewSeparatorsHorizontalViewInfo }

function TcxGridCardViewSeparatorsHorizontalViewInfo.GetHitTestItem(Index: Integer): TRect;
begin
  Result := Items[Index];
  InflateRect(Result, SeparatorSizingAddZone, 0);
end;

function TcxGridCardViewSeparatorsHorizontalViewInfo.GetHitTestItemCount: Integer;
begin
  Result := Count;
end;

procedure TcxGridCardViewSeparatorsHorizontalViewInfo.Calculate;
var
  AMostBottomBound, I: Integer;
  R: TRect;

  function GetMostBottomBound: Integer;
  var
    I: Integer;
  begin
    Result := 0;
    for I := 0 to RecordsViewInfo.Columns.Count - 1 do
      with RecordsViewInfo.Columns[I].LastRow.Bounds do
        if Result < Bottom then Result := Bottom;
  end;

begin
  AMostBottomBound := GetMostBottomBound;
  for I := 0 to RecordsViewInfo.Columns.Count - 1 do
  begin
    R.Left := RecordsViewInfo.Columns[I][0].Bounds.Right + CardIndent;
    R.Right := R.Left + Width;
    with GridViewInfo.ClientBounds do
    begin
      R.Top := Top + CardIndent;
      R.Bottom := Bottom - CardIndent;
    end;
    if R.Bottom < AMostBottomBound then R.Bottom := AMostBottomBound;
    Items[I] := R;
  end;
end;

{ TcxGridCardViewSeparatorsVerticalViewInfo }

function TcxGridCardViewSeparatorsVerticalViewInfo.GetHitTestItem(Index: Integer): TRect;
begin
  Result := RecordsViewInfo.Columns[Index][0].Bounds;
  Result.Left := Result.Right + (CardIndent - SeparatorSizingZone) div 2;
  Result.Right := Result.Left + SeparatorSizingZone;
  Result.Bottom := GridViewInfo.ClientBounds.Bottom - CardIndent;
end;

function TcxGridCardViewSeparatorsVerticalViewInfo.GetHitTestItemCount: Integer;
begin
  Result := RecordsViewInfo.Columns.Count;
end;

procedure TcxGridCardViewSeparatorsVerticalViewInfo.Calculate;
var
  AMostRightBound, I: Integer;
  R: TRect;

  function GetMostRightBound: Integer;
  begin
    Result := RecordsViewInfo.Columns[0][0].Bounds.Right;
  end;

  function GetRowBottom(ARowIndex: Integer): Integer;
  var
    I: Integer;
  begin
    Result := 0;
    for I := 0 to RecordsViewInfo.Columns.Count - 1 do
      with RecordsViewInfo.Columns[I] do
        if ARowIndex < RowCount then
          with Rows[ARowIndex] do
            if Result < Bounds.Bottom then Result := Bounds.Bottom;
  end;

begin
  if RecordsViewInfo.Columns.Count = 0 then Exit;
  AMostRightBound := GetMostRightBound;
  for I := 0 to RecordsViewInfo.Columns[0].RowCount - 1 do
  begin
    R.Top := GetRowBottom(I) + CardIndent;
    R.Bottom := R.Top + Width;
    with GridViewInfo.ClientBounds do
    begin
      R.Left := Left + CardIndent;
      R.Right := Right - CardIndent;
    end;
    if R.Right < AMostRightBound then R.Right := AMostRightBound;
    Items[I] := R;
  end;
end;

{ TcxGridCardViewViewInfo }

function TcxGridCardViewViewInfo.GetController: TcxGridCardViewController;
begin
  Result := TcxGridCardViewController(inherited Controller);
end;

function TcxGridCardViewViewInfo.GetGridView: TcxGridCardView;
begin
  Result := TcxGridCardView(inherited GridView);
end;

function TcxGridCardViewViewInfo.GetRecordsViewInfo: TcxGridCardsViewInfo;
begin
  Result := TcxGridCardsViewInfo(inherited RecordsViewInfo);
end;

function TcxGridCardViewViewInfo.GetViewData: TcxGridCardViewViewData;
begin
  Result := TcxGridCardViewViewData(inherited ViewData);
end;

procedure TcxGridCardViewViewInfo.CreateViewInfos;
begin
  inherited;
  FSeparatorsViewInfo := GetSeparatorsViewInfoClass.Create(Self);
end;

procedure TcxGridCardViewViewInfo.DestroyViewInfos(AIsRecreating: Boolean);
begin
  FreeAndNil(FSeparatorsViewInfo);
  inherited;
end;

procedure TcxGridCardViewViewInfo.AfterCalculating;
begin
  if Visible and (RecordsViewInfo.CardHeight <> FPrevCardHeight) then
    Controller.PostGridModeBufferCountUpdate;
  inherited;
end;

procedure TcxGridCardViewViewInfo.BeforeCalculating;
begin
  inherited;
  if Visible then
    FPrevCardHeight := RecordsViewInfo.CardHeight;
end;

procedure TcxGridCardViewViewInfo.Calculate;
begin
  RecreateViewInfos;
  FilterViewInfo.MainCalculate;
  inherited;
  SeparatorsViewInfo.Calculate;
end;

procedure TcxGridCardViewViewInfo.CalculateHeight(const AMaxSize: TPoint;
  var AHeight: Integer; var AFullyVisible: Boolean);
var
  AIsParentViewInfoCalculatedDown: Boolean;
  I, AColumnHeight: Integer;
  ALastRow: TcxGridCardViewInfo;
begin
  MainCalculate(Classes.Bounds(
    cxGridInvisibleCoordinate, 0, AMaxSize.X, AMaxSize.Y));
  AFullyVisible := Controller.IsDataFullyVisible;
  if RecordsViewInfo.Columns.Count = 0 then
    AHeight := 2 * CardIndent + RecordsViewInfo.CardHeight
  else
  begin
    AHeight := 0;
    AIsParentViewInfoCalculatedDown :=
      (GridView.MasterGridView.ViewInfo as TcxCustomGridTableViewInfo).CalculateDown;
    {if AIsParentViewInfoCalculatedDown then
      AFullyVisible := True;}
    for I := 0 to RecordsViewInfo.Columns.Count - 1 do
    begin
      ALastRow := RecordsViewInfo.Columns[I].LastRow;
      AColumnHeight := ALastRow.Bounds.Bottom + CardIndent;
      if AHeight < AColumnHeight then AHeight := AColumnHeight;
      if AIsParentViewInfoCalculatedDown and AFullyVisible then
        AFullyVisible := ALastRow.IsFullyVisible;
    end;
  end;
  Inc(AHeight, GetNonRecordsAreaHeight(False));
  inherited;
end;

procedure TcxGridCardViewViewInfo.CalculateWidth(const AMaxSize: TPoint; var AWidth: Integer);
begin
//  AWidth := AMaxSize.X;
  //MainCalculate(Bounds(cxGridInvisibleCoordinate, 0, AMaxSize.X, AMaxSize.Y));  it is supposed that calculation was called from GetHeight
  if RecordsViewInfo.Columns.Count = 0 then
    AWidth := 0
  else
    if RecordsViewInfo.Columns.Count = RecordsViewInfo.Columns.VisibleCount then
      AWidth := RecordsViewInfo.Columns.Last[0].Bounds.Right + CardIndent
    else
      AWidth := AMaxSize.X;
  inherited;
end;

function TcxGridCardViewViewInfo.DoGetHitTest(const P: TPoint): TcxCustomGridHitTest;
begin
  Result := SeparatorsViewInfo.GetHitTest(P);
  if Result = nil then
    Result := inherited DoGetHitTest(P);
end;

function TcxGridCardViewViewInfo.GetDefaultGridModeBufferCount: Integer;

  function GetColumnWidth: Integer;
  begin
    Result := RecordsViewInfo.CardWidth + CardIndent;
  end;

  function GetRowHeight: Integer;
  begin
    Result := RecordsViewInfo.CardHeight + CardIndent;
  end;

begin
  if (RecordsViewInfo.CardWidth = 0) or (RecordsViewInfo.CardHeight = 0) then
  begin
    Controller.PostGridModeBufferCountUpdate;
    Result := 0;
  end
  else
    Result := RoundDiv(Screen.Width, GetColumnWidth) * RoundDiv(Screen.Height, GetRowHeight) + 2;
end;

function TcxGridCardViewViewInfo.GetScrollableAreaBoundsForEdit: TRect;
begin
  Result := inherited GetScrollableAreaBoundsForEdit;
  IntersectRect(Result, Result, Controller.FocusedCardViewInfo.ScrollableAreaBounds);
end;

function TcxGridCardViewViewInfo.GetRecordsViewInfoClass: TcxCustomGridRecordsViewInfoClass;
begin
  case GridView.LayoutDirection of
    ldHorizontal:
      Result := TcxGridCardsHorizontalViewInfo;
    ldVertical:
      Result := TcxGridCardsVerticalViewInfo;
  else
    Result := nil;
  end;
end;

function TcxGridCardViewViewInfo.GetSeparatorsViewInfoClass: TcxGridCardViewSeparatorsViewInfoClass;
begin
  case GridView.LayoutDirection of
    ldHorizontal:
      Result := TcxGridCardViewSeparatorsHorizontalViewInfo;
    ldVertical:
      Result := TcxGridCardViewSeparatorsVerticalViewInfo;
  else
    Result := nil;
  end;
end;

function TcxGridCardViewViewInfo.CanOffsetView(ARecordCountDelta: Integer): Boolean;
begin
  Result := False;
end;

{ TcxGridCardViewInfoCacheItem }

procedure TcxGridCardViewInfoCacheItem.SetTopRowIndex(Value: Integer);
begin
  FTopRowIndex := Value;
  FIsTopRowIndexAssigned := True;
end;

procedure TcxGridCardViewInfoCacheItem.UnassignValues(AKeepMaster: Boolean);
begin
  inherited;
  FIsTopRowIndexAssigned := False;
end;

{ TcxGridCardViewRowOptions }

constructor TcxGridCardViewRowOptions.Create(AItem: TcxCustomGridTableItem);
begin
  inherited;
  FShowCaption := True;
end;

procedure TcxGridCardViewRowOptions.SetShowCaption(Value: Boolean);
begin
  if FShowCaption <> Value then
  begin
    FShowCaption := Value;
    Changed(ticSize);
  end;
end;

procedure TcxGridCardViewRowOptions.Assign(Source: TPersistent);
begin
  if Source is TcxGridCardViewRowOptions then
    ShowCaption := TcxGridCardViewRowOptions(Source).ShowCaption;
  inherited;
end;

{ TcxGridCardViewRowStyles }

function TcxGridCardViewRowStyles.GetGridViewValue: TcxGridCardView;
begin
  Result := TcxGridCardView(inherited GridView);
end;

function TcxGridCardViewRowStyles.GetItem: TcxGridCardViewRow;
begin
  Result := TcxGridCardViewRow(inherited Item);
end;

procedure TcxGridCardViewRowStyles.SetOnGetCaptionRowStyle(Value: TcxGridGetCellStyleEvent);
begin
  if @FOnGetCaptionRowStyle <> @Value then
  begin
    FOnGetCaptionRowStyle := Value;
    Item.Changed(ticProperty);
  end;
end;

procedure TcxGridCardViewRowStyles.SetOnGetCaptionStyle(Value: TcxGridGetCellStyleEvent);
begin
  if @FOnGetCaptionStyle <> @Value then
  begin
    FOnGetCaptionStyle := Value;
    Item.Changed(ticProperty);
  end;
end;

procedure TcxGridCardViewRowStyles.GetDefaultViewParams(Index: Integer; AData: TObject;
  out AParams: TcxViewParams);
begin
  case Index of
    isCaptionRow:
      GridView.Styles.GetCaptionRowParams(TcxCustomGridRecord(AData), Item, AParams);
    isRowCaption:
      GridView.Styles.GetRowCaptionParams(TcxCustomGridRecord(AData), Item, AParams);
  else
    inherited;
  end;
end;

procedure TcxGridCardViewRowStyles.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TcxGridCardViewRowStyles then
    with TcxGridCardViewRowStyles(Source) do
    begin
      Self.Caption := Caption;
      Self.CaptionRow := CaptionRow;
      Self.OnGetCaptionRowStyle := OnGetCaptionRowStyle;
      Self.OnGetCaptionStyle := OnGetCaptionStyle;
    end;
end;

procedure TcxGridCardViewRowStyles.GetCaptionParams(ARecord: TcxCustomGridRecord;
  out AParams: TcxViewParams);
var
  AStyle: TcxStyle;
begin
  AStyle := nil;
  if Assigned(FOnGetCaptionStyle) then
    FOnGetCaptionStyle(GridView, ARecord, Item, AStyle);
  GetViewParams(isRowCaption, ARecord, AStyle, AParams);
end;

procedure TcxGridCardViewRowStyles.GetCaptionRowParams(ARecord: TcxCustomGridRecord;
  out AParams: TcxViewParams);
var
  AStyle: TcxStyle;
begin
  AStyle := nil;
  if Assigned(FOnGetCaptionRowStyle) then
    FOnGetCaptionRowStyle(GridView, ARecord, Item, AStyle);
  GetViewParams(isCaptionRow, ARecord, AStyle, AParams);
end;

{ TcxGridCardViewRow }

function TcxGridCardViewRow.GetCaptionAlignmentHorz: TAlignment;
begin
  Result := HeaderAlignmentHorz;
end;

function TcxGridCardViewRow.GetCaptionAlignmentVert: TcxAlignmentVert;
begin
  Result := HeaderAlignmentVert;
end;

function TcxGridCardViewRow.GetGridView: TcxGridCardView;
begin
  Result := TcxGridCardView(inherited GridView);
end;

function TcxGridCardViewRow.GetOptions: TcxGridCardViewRowOptions;
begin
  Result := TcxGridCardViewRowOptions(inherited Options);
end;

function TcxGridCardViewRow.GetStyles: TcxGridCardViewRowStyles;
begin
  Result := TcxGridCardViewRowStyles(inherited Styles);
end;

procedure TcxGridCardViewRow.SetCaptionAlignmentHorz(Value: TAlignment);
begin
  HeaderAlignmentHorz := Value;
end;

procedure TcxGridCardViewRow.SetCaptionAlignmentVert(Value: TcxAlignmentVert);
begin
  HeaderAlignmentVert := Value;
end;

procedure TcxGridCardViewRow.SetKind(Value: TcxGridCardViewRowKind);
begin
  if FKind <> Value then
  begin
    FKind := Value;
    if Visible then
    begin
      if not CanFocus(nil) then Focused := False;
      Changed(ticSize);
    end
    else
      Changed(ticProperty);
  end;
end;

procedure TcxGridCardViewRow.SetOptions(Value: TcxGridCardViewRowOptions);
begin
  inherited Options := Value;
end;

procedure TcxGridCardViewRow.SetStyles(Value: TcxGridCardViewRowStyles);
begin
  inherited Styles := Value;
end;

function TcxGridCardViewRow.IsCaptionAlignmentHorzStored: Boolean;
begin
  Result := IsHeaderAlignmentHorzStored;
end;

function TcxGridCardViewRow.IsCaptionAlignmentVertStored: Boolean;
begin
  Result := IsHeaderAlignmentVertStored;
end;

function TcxGridCardViewRow.CanFocus(ARecord: TcxCustomGridRecord): Boolean;
begin
  Result := inherited CanFocus(ARecord) and (FKind = rkData) and
    ((ARecord = nil) or IsVisibleInCard(TcxGridCard(ARecord)));
end;

procedure TcxGridCardViewRow.CheckHeight(var AHeight: Integer);
begin
  if HasCardExpandButton and (AHeight < GridView.LookAndFeelPainter.GroupExpandButtonSize) then
    AHeight := GridView.LookAndFeelPainter.GroupExpandButtonSize;
end;

function TcxGridCardViewRow.DefaultWidth: Integer;
begin
  Result := DataBinding.DefaultWidth(False);
end;

function TcxGridCardViewRow.GetVisibleCaption: string;
begin
  Result := inherited GetVisibleCaption;
  if GridView.OptionsView.CaptionSeparator <> #0 then
    Result := Result + GridView.OptionsView.CaptionSeparator;
end;

function TcxGridCardViewRow.GetOptionsClass: TcxCustomGridTableItemOptionsClass;
begin
  Result := TcxGridCardViewRowOptions;
end;

function TcxGridCardViewRow.GetStylesClass: TcxCustomGridTableItemStylesClass;
begin
  Result := TcxGridCardViewRowStyles;
end;

procedure TcxGridCardViewRow.Assign(Source: TPersistent);
begin
  if Source is TcxGridCardViewRow then
    with TcxGridCardViewRow(Source) do
    begin
      Self.Kind := Kind;
    end;
  inherited;
end;

function TcxGridCardViewRow.HasCardExpandButton: Boolean;
begin
  Result := GridView.OptionsCustomize.CardExpanding and
    (FKind = rkCaption) and (GridView.FirstCaptionRow = Self);
end;

function TcxGridCardViewRow.IsVisibleInCard(ACard: TcxGridCard): Boolean;
begin
  Result := Visible;
  if Result and (FKind = rkData) then
    Result := ACard.Expanded and
      (GridView.OptionsView.EmptyRows or not VarIsNull(ACard.Values[Index]));
end;

{ TcxGridCardViewBackgroundBitmaps }

function TcxGridCardViewBackgroundBitmaps.GetBitmapStyleIndex(Index: Integer): Integer;
begin
  case Index of
    bbCaptionRow:
      Result := vsCaptionRow;
    bbCardBorder:
      Result := vsCardBorder;
    bbRowCaption:
      Result := vsRowCaption;
  else
    Result := inherited GetBitmapStyleIndex(Index);
  end;  
end;

procedure TcxGridCardViewBackgroundBitmaps.Assign(Source: TPersistent);
begin
  if Source is TcxGridCardViewBackgroundBitmaps then
    with TcxGridCardViewBackgroundBitmaps(Source) do
    begin
      Self.CaptionRow := CaptionRow;
      Self.CardBorder := CardBorder;
      Self.RowCaption := RowCaption;
    end;
  inherited;
end;

function TcxGridCardViewBackgroundBitmaps.GetBitmap(Index: Integer): TBitmap;
begin
  Result := inherited GetBitmap(Index);
  if Result = nil then
    case Index of
      bbRowCaption:
        Result := GetBitmap(bbContent);
    end;
end;

{ TcxGridCardViewFiltering }

function TcxGridCardViewFiltering.GetRowMRUItemsList: Boolean;
begin
  Result := ItemMRUItemsList;
end;

function TcxGridCardViewFiltering.GetRowMRUItemsListCount: Integer;
begin
  Result := ItemMRUItemsListCount;
end;

function TcxGridCardViewFiltering.GetRowPopupDropDownWidth: Integer;
begin
  Result := ItemPopupDropDownWidth;
end;

function TcxGridCardViewFiltering.GetRowPopupMaxDropDownItemCount: Integer;
begin
  Result := ItemPopupMaxDropDownItemCount;
end;

procedure TcxGridCardViewFiltering.SetRowMRUItemsList(Value: Boolean);
begin
  ItemMRUItemsList := Value;
end;

procedure TcxGridCardViewFiltering.SetRowMRUItemsListCount(Value: Integer);
begin
  ItemMRUItemsListCount := Value;
end;

procedure TcxGridCardViewFiltering.SetRowPopupDropDownWidth(Value: Integer);
begin
  ItemPopupDropDownWidth := Value;
end;

procedure TcxGridCardViewFiltering.SetRowPopupMaxDropDownItemCount(Value: Integer);
begin
  ItemPopupMaxDropDownItemCount := Value;
end;

{ TcxGridCardViewOptionsBehavior }

constructor TcxGridCardViewOptionsBehavior.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FocusCellOnCycle := True;
  FRowCaptionHints := True;
end;

procedure TcxGridCardViewOptionsBehavior.SetRowCaptionHints(Value: Boolean);
begin
  if FRowCaptionHints <> Value then
  begin
    FRowCaptionHints := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxGridCardViewOptionsBehavior.Assign(Source: TPersistent);
begin
  if Source is TcxGridCardViewOptionsBehavior then
    with TcxGridCardViewOptionsBehavior(Source) do
      Self.RowCaptionHints := RowCaptionHints;
  inherited;
end;

{ TcxGridCardViewOptionsCustomize }

constructor TcxGridCardViewOptionsCustomize.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  RowMoving := False;
  FCardSizing := True;
end;

function TcxGridCardViewOptionsCustomize.GetGridView: TcxGridCardView;
begin
  Result := TcxGridCardView(inherited GridView);
end;

function TcxGridCardViewOptionsCustomize.GetRowFiltering: Boolean;
begin
  Result := ItemFiltering;
end;

function TcxGridCardViewOptionsCustomize.GetRowHiding: Boolean;
begin
  Result := ItemHiding;
end;

function TcxGridCardViewOptionsCustomize.GetRowMoving: Boolean;
begin
  Result := ItemMoving;
end;

procedure TcxGridCardViewOptionsCustomize.SetCardExpanding(Value: Boolean);
begin
  if FCardExpanding <> Value then
  begin
    if Value then
      GridView.Controller.FocusedItem := nil;
    FCardExpanding := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridCardViewOptionsCustomize.SetCardSizing(Value: Boolean);
begin
  if FCardSizing <> Value then
  begin
    FCardSizing := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxGridCardViewOptionsCustomize.SetRowFiltering(Value: Boolean);
begin
  ItemFiltering := Value;
end;

procedure TcxGridCardViewOptionsCustomize.SetRowHiding(Value: Boolean);
begin
  ItemHiding := Value;
end;

procedure TcxGridCardViewOptionsCustomize.SetRowMoving(Value: Boolean);
begin
  ItemMoving := Value;
end;

procedure TcxGridCardViewOptionsCustomize.Assign(Source: TPersistent);
begin
  if Source is TcxGridCardViewOptionsCustomize then
    with TcxGridCardViewOptionsCustomize(Source) do
    begin
      Self.CardExpanding := CardExpanding;
      Self.CardSizing := CardSizing;
    end;
  inherited;
end;

{ TcxGridCardViewOptionsView }

constructor TcxGridCardViewOptionsView.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FCardBorderWidth := cxGridDefaultCardBorderWidth;
  FCaptionSeparator := cxGridDefaultCardViewCaptionSeparator;
  FCardExpandButtonAlignment := cebaRight;
  FCardWidth := cxGridDefaultCardWidth;
  FEmptyRows := True;
  FSeparatorColor := clDefault;
  FSeparatorWidth := cxGridDefaultCardViewSeparatorWidth;
end;

function TcxGridCardViewOptionsView.GetRowCaptionAutoHeight: Boolean;
begin
  Result := ItemCaptionAutoHeight;
end;

function TcxGridCardViewOptionsView.GetRowCaptionEndEllipsis: Boolean;
begin
  Result := ItemCaptionEndEllipsis;
end;

procedure TcxGridCardViewOptionsView.SetCaptionSeparator(Value: Char);
begin
  if FCaptionSeparator <> Value then
  begin
    FCaptionSeparator := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridCardViewOptionsView.SetCaptionWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FCaptionWidth <> Value then
  begin
    FCaptionWidth := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridCardViewOptionsView.SetCardBorderWidth(Value: Integer);
begin
  if Value < cxGridMinCardBorderWidth then Value := cxGridMinCardBorderWidth;
  if FCardBorderWidth <> Value then
  begin
    FCardBorderWidth := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridCardViewOptionsView.SetCardExpandButtonAlignment(Value: TcxGridCardExpandButtonAlignment);
begin
  if FCardExpandButtonAlignment <> Value then
  begin
    FCardExpandButtonAlignment := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridCardViewOptionsView.SetCardWidth(Value: Integer);
begin
  if Value < cxGridMinCardWidth then Value := cxGridMinCardWidth;
  if FCardWidth <> Value then
  begin
    FCardWidth := Value;
    Changed(vcSize);
    TcxGridCardView(GridView).Controller.PostGridModeBufferCountUpdate;
  end;
end;

procedure TcxGridCardViewOptionsView.SetEmptyRows(Value: Boolean);
begin
  if FEmptyRows <> Value then
  begin
    if not Value then
      GridView.Controller.FocusedItem := nil; 
    FEmptyRows := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridCardViewOptionsView.SetRowCaptionAutoHeight(Value: Boolean);
begin
  ItemCaptionAutoHeight := Value;
end;

procedure TcxGridCardViewOptionsView.SetRowCaptionEndEllipsis(Value: Boolean);
begin
  ItemCaptionEndEllipsis := Value;
end;

procedure TcxGridCardViewOptionsView.SetSeparatorColor(Value: TColor);
begin
  if FSeparatorColor <> Value then
  begin
    FSeparatorColor := Value;
    Changed(vcLayout);
  end;
end;

procedure TcxGridCardViewOptionsView.SetSeparatorWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FSeparatorWidth <> Value then
  begin
    FSeparatorWidth := Value;
    Changed(vcLayout);
  end;
end;

procedure TcxGridCardViewOptionsView.Assign(Source: TPersistent);
begin
  if Source is TcxGridCardViewOptionsView then
    with TcxGridCardViewOptionsView(Source) do
    begin
      Self.CaptionSeparator := CaptionSeparator;
      Self.CaptionWidth := CaptionWidth;
      Self.CardBorderWidth := CardBorderWidth;
      Self.CardExpandButtonAlignment := CardExpandButtonAlignment;
      Self.CardWidth := CardWidth;
      Self.EmptyRows := EmptyRows;
      Self.SeparatorColor := SeparatorColor;
      Self.SeparatorWidth := SeparatorWidth;
    end;
  inherited;
end;

function TcxGridCardViewOptionsView.GetSeparatorColor: TColor;
begin
  Result := FSeparatorColor;
  if Result = clDefault then
    Result := LookAndFeelPainter.DefaultSeparatorColor;
end;

{ TcxGridCardViewStyles }

procedure TcxGridCardViewStyles.SetOnGetCaptionRowStyle(Value: TcxGridGetCellStyleEvent);
begin
  if @FOnGetCaptionRowStyle <> @Value then
  begin
    FOnGetCaptionRowStyle := Value;
    GridView.Changed(vcProperty);
  end;
end;

procedure TcxGridCardViewStyles.SetOnGetCardBorderStyle(Value: TcxGridGetRecordStyleEvent);
begin
  if @FOnGetCardBorderStyle <> @Value then
  begin
    FOnGetCardBorderStyle := Value;
    GridView.Changed(vcProperty);
  end;
end;

procedure TcxGridCardViewStyles.SetOnGetRowCaptionStyle(Value: TcxGridGetCellStyleEvent);
begin
  if @FOnGetRowCaptionStyle <> @Value then
  begin
    FOnGetRowCaptionStyle := Value;
    GridView.Changed(vcProperty);
  end;
end;

procedure TcxGridCardViewStyles.GetDefaultViewParams(Index: Integer; AData: TObject;
  out AParams: TcxViewParams);
begin
  case Index of
    vsCardBorder:
      GetRecordContentParams(TcxCustomGridRecord(AData), nil, AParams);
      //Color := DefaultContentColor;
  else
    inherited;
    with AParams, LookAndFeelPainter do
      case Index of
        vsCaptionRow:
          begin
            if AData <> nil then
              with TcxGridDataCellPos(AData) do
                inherited GetDataCellContentParams(GridRecord, Item, AParams);
            Color := DefaultHeaderColor;
            TextColor := DefaultHeaderTextColor;
          end;
        vsRowCaption:
          if AData <> nil then
            with TcxGridDataCellPos(AData) do
              GetDataCellContentParams(GridRecord, Item, AParams);
      end;
  end;
end;

procedure TcxGridCardViewStyles.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TcxGridCardViewStyles then
    with TcxGridCardViewStyles(Source) do
    begin
      Self.CaptionRow := CaptionRow;
      Self.CardBorder := CardBorder;
      Self.RowCaption := RowCaption;
      Self.OnGetCaptionRowStyle := OnGetCaptionRowStyle;
      Self.OnGetCardBorderStyle := OnGetCardBorderStyle;
      Self.OnGetRowCaptionStyle := OnGetRowCaptionStyle;
    end;
end;

procedure TcxGridCardViewStyles.GetCaptionRowParams(ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AParams: TcxViewParams);
var
  AStyle: TcxStyle;
  ADataCellPos: TcxGridDataCellPos;
begin
  AStyle := nil;
  if Assigned(FOnGetCaptionRowStyle) then
    FOnGetCaptionRowStyle(GridView, ARecord, AItem, AStyle);
  ADataCellPos := TcxGridDataCellPos.Create;
  try
    with ADataCellPos do
    begin
      GridRecord := ARecord;
      Item := AItem;
    end;
    GetViewParams(vsCaptionRow, ADataCellPos, AStyle, AParams);
  finally
    ADataCellPos.Free;
  end;
end;

procedure TcxGridCardViewStyles.GetCardBorderParams(ARecord: TcxCustomGridRecord;
  out AParams: TcxViewParams);
var
  AStyle: TcxStyle;
begin
  AStyle := nil;
  if Assigned(FOnGetCardBorderStyle) then
    FOnGetCardBorderStyle(GridView, ARecord, AStyle);
  GetViewParams(vsCardBorder, ARecord, AStyle, AParams);
end;

procedure TcxGridCardViewStyles.GetDataCellContentParams(ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AParams: TcxViewParams);
begin
  if (AItem = nil) or (TcxGridCardViewRow(AItem).Kind <> rkCaption) then
    inherited
  else
    TcxGridCardViewRow(AItem).Styles.GetCaptionRowParams(ARecord, AParams);
end;

procedure TcxGridCardViewStyles.GetRowCaptionParams(ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AParams: TcxViewParams);
var
  AStyle: TcxStyle;
  ADataCellPos: TcxGridDataCellPos;
begin
  AStyle := nil;
  if Assigned(FOnGetRowCaptionStyle) then
    FOnGetRowCaptionStyle(GridView, ARecord, AItem, AStyle);
  ADataCellPos := TcxGridDataCellPos.Create;
  try
    with ADataCellPos do
    begin
      GridRecord := ARecord;
      Item := AItem;
    end;
    GetViewParams(vsRowCaption, ADataCellPos, AStyle, AParams);
  finally
    ADataCellPos.Free;
  end;
end;

{ TcxGridCardViewStyleSheet }

function TcxGridCardViewStyleSheet.GetStylesValue: TcxGridCardViewStyles;
begin
  Result := TcxGridCardViewStyles(GetStyles);
end;

procedure TcxGridCardViewStyleSheet.SetStylesValue(Value: TcxGridCardViewStyles);
begin
  SetStyles(Value);
end;

class function TcxGridCardViewStyleSheet.GetStylesClass: TcxCustomStylesClass;
begin
  Result := TcxGridCardViewStyles;
end;

{ TcxGridCardView }

function TcxGridCardView.GetBackgroundBitmaps: TcxGridCardViewBackgroundBitmaps;
begin
  Result := TcxGridCardViewBackgroundBitmaps(inherited BackgroundBitmaps);
end;

function TcxGridCardView.GetControl: TcxCustomGrid;
begin
  Result := TcxCustomGrid(inherited Control);
end;

function TcxGridCardView.GetController: TcxGridCardViewController;
begin
  Result := TcxGridCardViewController(inherited Controller);
end;

function TcxGridCardView.GetDataController: TcxGridDataController;
begin
  Result := TcxGridDataController(FDataController);
end;

function TcxGridCardView.GetFiltering: TcxGridCardViewFiltering;
begin
  Result := TcxGridCardViewFiltering(inherited Filtering);
end;

function TcxGridCardView.GetFirstCaptionRow: TcxGridCardViewRow;
var
  I: Integer;
begin
  for I := 0 to VisibleRowCount - 1 do
  begin
    Result := VisibleRows[I];
    if Result.Kind = rkCaption then Exit;
  end;
  Result := nil;
end;

function TcxGridCardView.GetOptionsBehavior: TcxGridCardViewOptionsBehavior;
begin
  Result := TcxGridCardViewOptionsBehavior(inherited OptionsBehavior);
end;

function TcxGridCardView.GetOptionsCustomize: TcxGridCardViewOptionsCustomize;
begin
  Result := TcxGridCardViewOptionsCustomize(inherited OptionsCustomize);
end;

function TcxGridCardView.GetOptionsData: TcxGridCardViewOptionsData;
begin
  Result := TcxGridCardViewOptionsData(inherited OptionsData);
end;

function TcxGridCardView.GetOptionsSelection: TcxGridCardViewOptionsSelection;
begin
  Result := TcxGridCardViewOptionsSelection(inherited OptionsSelection);
end;

function TcxGridCardView.GetOptionsView: TcxGridCardViewOptionsView;
begin
  Result := TcxGridCardViewOptionsView(inherited OptionsView);
end;

function TcxGridCardView.GetPainter: TcxGridCardViewPainter;
begin
  Result := TcxGridCardViewPainter(inherited Painter);
end;

function TcxGridCardView.GetRow(Index: Integer): TcxGridCardViewRow;
begin
  Result := TcxGridCardViewRow(Items[Index]);
end;

function TcxGridCardView.GetRowCount: Integer;
begin
  Result := ItemCount;
end;

function TcxGridCardView.GetStyles: TcxGridCardViewStyles;
begin
  Result := TcxGridCardViewStyles(inherited Styles);
end;

function TcxGridCardView.GetViewData: TcxGridCardViewViewData;
begin
  Result := TcxGridCardViewViewData(inherited ViewData);
end;

function TcxGridCardView.GetViewInfo: TcxGridCardViewViewInfo;
begin
  Result := TcxGridCardViewViewInfo(inherited ViewInfo);
end;

function TcxGridCardView.GetVisibleRow(Index: Integer): TcxGridCardViewRow;
begin
  Result := TcxGridCardViewRow(VisibleItems[Index]);
end;

function TcxGridCardView.GetVisibleRowCount: Integer;
begin
  Result := VisibleItemCount;
end;

procedure TcxGridCardView.SetBackgroundBitmaps(Value: TcxGridCardViewBackgroundBitmaps);
begin
  inherited BackgroundBitmaps := Value;
end;

procedure TcxGridCardView.SetDataController(Value: TcxGridDataController);
begin
  FDataController.Assign(Value);
end;

procedure TcxGridCardView.SetFiltering(Value: TcxGridCardViewFiltering);
begin
  inherited Filtering := Value;
end;

procedure TcxGridCardView.SetLayoutDirection(Value: TcxGridCardViewLayoutDirection);
begin
  if FLayoutDirection <> Value then
  begin
    FLayoutDirection := Value;
    Controller.LayoutDirectionChanged;
    Changed(vcSize);
  end;
end;

procedure TcxGridCardView.SetOnRowPosChanged(Value: TcxGridCardRowEvent);
begin
  if @FOnRowPosChanged <> @Value then
  begin
    FOnRowPosChanged := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxGridCardView.SetOptionsBehavior(Value: TcxGridCardViewOptionsBehavior);
begin
  inherited OptionsBehavior := Value;
end;

procedure TcxGridCardView.SetOptionsCustomize(Value: TcxGridCardViewOptionsCustomize);
begin
  inherited OptionsCustomize := Value;
end;

procedure TcxGridCardView.SetOptionsData(Value: TcxGridCardViewOptionsData);
begin
  inherited OptionsData := Value;
end;

procedure TcxGridCardView.SetOptionsSelection(Value: TcxGridCardViewOptionsSelection);
begin
  inherited OptionsSelection := Value;
end;

procedure TcxGridCardView.SetOptionsView(Value: TcxGridCardViewOptionsView);
begin
  inherited OptionsView := Value;
end;

procedure TcxGridCardView.SetRow(Index: Integer; Value: TcxGridCardViewRow);
begin
  Items[Index] := Value;
end;

procedure TcxGridCardView.SetStyles(Value: TcxGridCardViewStyles);
begin
  inherited Styles := Value;
end;

function TcxGridCardView.GetProperties(AProperties: TStrings): Boolean;
begin
  AProperties.Add('CardWidth');
  Result := inherited GetProperties(AProperties);
end;

procedure TcxGridCardView.GetPropertyValue(const AName: string; var AValue: Variant);
begin
  if AName = 'CardWidth' then
    AValue := OptionsView.CardWidth
  else
    inherited;
end;

procedure TcxGridCardView.SetPropertyValue(const AName: string; const AValue: Variant);
begin
  if AName = 'CardWidth' then
   OptionsView.CardWidth := AValue
  else
    inherited;
end;

procedure TcxGridCardView.AssignLayout(ALayoutView: TcxCustomGridView);
begin
  inherited;
  OptionsView.CardWidth := (ALayoutView as TcxGridCardView).OptionsView.CardWidth;
end;

function TcxGridCardView.GetLayoutCustomizationFormButtonCaption: string;
begin
  Result := 'Rows customization';
end;

procedure TcxGridCardView.DoAssign(ASource: TcxCustomGridView);
begin
  if ASource is TcxGridCardView then
    with TcxGridCardView(ASource) do
    begin
      Self.LayoutDirection := LayoutDirection;
      Self.OnRowPosChanged := OnRowPosChanged;
    end;
  inherited;
end;

function TcxGridCardView.GetResizeOnBoundsChange: Boolean;
begin
  Result := True;
end;

procedure TcxGridCardView.RecordChanged(ARecordIndex: Integer);
begin
  inherited;
  with Controller do
    if not OptionsView.EmptyRows and
      (FocusedRecord <> nil) and (FocusedRecord.RecordIndex = ARecordIndex) and
      (FocusedCardViewInfo <> nil) and (FocusedItem <> nil) and
      (FocusedCardViewInfo.VisibleRowViewInfoIndexOf(FocusedItem) = -1) then
      SizeChanged;
end;

function TcxGridCardView.GetBackgroundBitmapsClass: TcxCustomGridBackgroundBitmapsClass;
begin
  Result := TcxGridCardViewBackgroundBitmaps;
end;

function TcxGridCardView.GetFilteringClass: TcxCustomGridTableFilteringClass;
begin
  Result := TcxGridCardViewFiltering;
end;

function TcxGridCardView.GetItemClass: TcxCustomGridTableItemClass;
begin
  Result := TcxGridCardViewRow;
end;

function TcxGridCardView.GetOptionsBehaviorClass: TcxCustomGridOptionsBehaviorClass;
begin
  Result := TcxGridCardViewOptionsBehavior;
end;

function TcxGridCardView.GetOptionsCustomizeClass: TcxCustomGridTableOptionsCustomizeClass;
begin
  Result := TcxGridCardViewOptionsCustomize;
end;

function TcxGridCardView.GetOptionsDataClass: TcxCustomGridOptionsDataClass;
begin
  Result := TcxGridCardViewOptionsData;
end;

function TcxGridCardView.GetOptionsSelectionClass: TcxCustomGridOptionsSelectionClass;
begin
  Result := TcxGridCardViewOptionsSelection;
end;

function TcxGridCardView.GetOptionsViewClass: TcxCustomGridOptionsViewClass;
begin
  Result := TcxGridCardViewOptionsView;
end;

function TcxGridCardView.GetStylesClass: TcxCustomGridViewStylesClass;
begin
  Result := TcxGridCardViewStyles;
end;

function TcxGridCardView.GetControllerClass: TcxCustomGridControllerClass;
begin
  Result := TcxGridCardViewController;
end;

function TcxGridCardView.GetDataControllerClass: TcxCustomDataControllerClass;
begin
  Result := TcxGridDataController;
end;

function TcxGridCardView.GetPainterClass: TcxCustomGridPainterClass;
begin
  Result := TcxGridCardViewPainter;
end;

function TcxGridCardView.GetViewDataClass: TcxCustomGridViewDataClass;
begin
  Result := TcxGridCardViewViewData;
end;

function TcxGridCardView.GetViewInfoClass: TcxCustomGridViewInfoClass;
begin
  Result := TcxGridCardViewViewInfo;
end;

function TcxGridCardView.CanCardSizing: Boolean;
begin
  Result := OptionsCustomize.CardSizing;
end;

procedure TcxGridCardView.DoRowPositionChanged(ARow: TcxGridCardViewRow);
begin
  if Assigned(FOnRowPosChanged) then FOnRowPosChanged(Self, ARow);
end;

function TcxGridCardView.CreateRow: TcxGridCardViewRow;
begin
  Result := TcxGridCardViewRow(CreateItem);
end;

initialization
  cxGridRegisteredViews.Register(TcxGridCardView, 'Cards');
  Classes.RegisterClasses([TcxGridCardViewRow, TcxGridCardViewStyleSheet]);

finalization
  cxGridRegisteredViews.Unregister(TcxGridCardView);

end.
