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

{$I cxGridVer.inc}

interface

uses
  Windows,
  Classes, Graphics, Controls, Forms, StdCtrls,
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

  htCardViewBase = 300;
  htRowCaption = htCardViewBase + 1;
  htSeparator = htCardViewBase + 2;

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
  TcxGridCardViewViewData = class;
  TcxGridCardRowViewInfo = class;
  TcxGridCardViewInfo = class;
  TcxGridCardViewColumns = class;
  TcxGridCardsViewInfo = class;
  TcxGridCardViewSeparatorsViewInfo = class;
  TcxGridCardViewViewInfo = class;
  TcxGridCardViewRow = class;
  TcxGridCardView = class;

  TcxGridCardViewLayoutDirection = (ldHorizontal, ldVertical);

  { hit tests }

  TcxGridCardRowCaptionHitTest = class(TcxGridRecordCellHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  TcxGridCardViewSeparatorHitTest = class(TcxCustomGridHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  public
    Index: Integer;
    Separators: TcxGridCardViewSeparatorsViewInfo;
    class function Cursor: TCursor; override;
    function DragAndDropObjectClass: TcxCustomGridDragAndDropObjectClass; override;
  end;

  { controller }

  TcxGridCardSizingObject = class(TcxCustomGridTableDragAndDropObject)
  private
    FCardColumnIndex: Integer;
    FCardOriginalWidth: Integer;
    FDestPointX: Integer;
    function GetGridView: TcxGridCardView;
    procedure SetDestPointX(Value: Integer);
  protected
    procedure DirtyChanged; override;
    function GetDragAndDropCursor(Accepted: Boolean): TCursor; override;
    function GetImmediateStart: Boolean; override;

    procedure RestoreCardWidth;
    procedure SaveCardWidth;

    property CardColumnIndex: Integer read FCardColumnIndex;
    property CardOriginalWidth: Integer read FCardOriginalWidth
      write FCardOriginalWidth;
    property DestPointX: Integer read FDestPointX write SetDestPointX;
    property GridView: TcxGridCardView read GetGridView;
  public
    procedure BeginDragAndDrop; override;
    procedure DragAndDrop(const P: TPoint; var Accepted: Boolean); override;
    procedure EndDragAndDrop(Accepted: Boolean); override;
    procedure Init(const P: TPoint; AParams: TcxCustomGridHitTest); override;
  end;

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

    function GetGridView: TcxGridCardView;
    function GetScrollDelta: Integer;
    function GetTopCardIndex: Integer;
    function GetViewData: TcxGridCardViewViewData;
    function GetViewInfo: TcxGridCardViewViewInfo;
    procedure SetTopCardIndex(Value: Integer);
    procedure CreateImplementationObject;
    procedure DestroyImplementationObject;
    function GetImplementationObjectClass: TcxGridCardViewControllerImplClass;
  protected
    function GetIsRecordsScrollHorizontal: Boolean; override;
    function GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind; override;
    function IsKeyForMultiSelect(AKey: Word; AShift: TShiftState;
      AFocusedRecordChanged: Boolean): Boolean; override;
    procedure ScrollData(ADirection: TcxDirection);

    property ImplementationObject: TcxGridCardViewControllerImpl read FImplementationObject;
    property ScrollDelta: Integer read GetScrollDelta;
    property ViewData: TcxGridCardViewViewData read GetViewData;
    property ViewInfo: TcxGridCardViewViewInfo read GetViewInfo;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    destructor Destroy; override;
    procedure MakeItemVisible(AItem: TcxCustomGridTableItem); override;

    procedure InitScrollBarsParameters; override;
    procedure Scroll(AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode;
      var AScrollPos: Integer); override;

    procedure KeyDown(var Key: Word; Shift: TShiftState); override;

    procedure LayoutDirectionChanged;

    property GridView: TcxGridCardView read GetGridView;
    property TopCardIndex: Integer read GetTopCardIndex write SetTopCardIndex;
  end;

  { painters }

  TcxGridCardRowPainterClass = class of TcxGridCardRowPainter;

  TcxGridCardRowPainter = class
  private
    FCanvas: TcxCanvas;
    FViewInfo: TcxGridCardRowViewInfo;
  protected
    procedure DrawFocusRect; virtual;
    property Canvas: TcxCanvas read FCanvas;
    property ViewInfo: TcxGridCardRowViewInfo read FViewInfo;
  public
    constructor Create(ACanvas: TcxCanvas; AViewInfo: TcxGridCardRowViewInfo); virtual;
    procedure Paint; virtual;
  end;

  TcxGridCardPainter = class(TcxCustomGridRecordPainter)
  private
    function GetViewInfo: TcxGridCardViewInfo;
  protected
    procedure DrawCardBorder; virtual;
    procedure DrawRows; virtual;
    procedure Paint; override;
    property ViewInfo: TcxGridCardViewInfo read GetViewInfo;
  end;

  TcxGridCardViewPainter = class(TcxCustomGridTablePainter)
  protected
    procedure DrawBackground; override;
    procedure DrawSeparators; virtual;
    function ViewInfo: TcxGridCardViewViewInfo; reintroduce;
  end;

  { view data }

  TcxGridCard = class(TcxCustomGridRecord)
  protected
    function GetHasCells: Boolean; override;
    function GetViewInfoClass: TcxCustomGridRecordViewInfoClass; override;
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
    function GetBackgroundBitmap: TBitmap; override;
    function GetTransparent: Boolean; override;
  public
    constructor Create(ARowViewInfo: TcxGridCardRowViewInfo); reintroduce; virtual;
    property CardViewInfo: TcxGridCardViewInfo read GetCardViewInfo;
    property GridRecord: TcxGridCard read GetGridRecord;
    property GridView: TcxGridCardView read GetGridView;
    property Row: TcxGridCardViewRow read GetRow;
    property RowViewInfo: TcxGridCardRowViewInfo read FRowViewInfo;
  end;

  TcxGridCardRowCaptionViewInfoClass = class of TcxGridCardRowCaptionViewInfo;

  TcxGridCardRowCaptionViewInfo = class(TcxGridCardRowCellViewInfo)
  protected
    function CalculateRealWidth: Integer; virtual;
    function CalculateWidth: Integer; override;
    function CalculateHeight: Integer; override;
    function CanShowHint: Boolean; override;
    function GetAlignmentHorz: TAlignment; override;
    function GetAlignmentVert: TcxAlignmentVert; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetMultiLine: Boolean; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetShowEndEllipsis: Boolean; override;
    function GetText: string; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
  end;

  TcxGridCardRowDataViewInfoClass = class of TcxGridCardRowDataViewInfo;

  TcxGridCardRowDataViewInfo = class(TcxGridCardRowCellViewInfo)
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function GetMultiLine: Boolean; override;
    function GetText: string; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
  end;

  TcxGridCardRowViewInfoClass = class of TcxGridCardRowViewInfo;

  TcxGridCardRowViewInfo = class
  private
    FCaptionViewInfo: TcxGridCardRowCaptionViewInfo;
    FCardViewInfo: TcxGridCardViewInfo;
    FDataViewInfo: TcxGridCardRowDataViewInfo;
    FHeight: Integer;
    FIndex: Integer;
    function GetCaptionWidth: Integer;
    function GetDataWidth: Integer;
    function GetGridView: TcxGridCardView;
    function GetGridRecord: TcxGridCard;
    function GetGridViewInfo: TcxGridCardViewViewInfo;
    function GetRow: TcxGridCardViewRow;
    procedure CreateViewInfos;
    procedure DestroyViewInfos;
  protected
    procedure BeforeRecalculation; virtual;
    procedure Calculate(const ABounds: TRect); virtual;
    function CalculateCaptionWidth: Integer; virtual;
    function CalculateHeight: Integer; virtual;
    function GetCaptionViewInfoClass: TcxGridCardRowCaptionViewInfoClass; virtual;
    function GetCellBackgroundBitmap(ACell: TcxGridCardRowCellViewInfo): TBitmap; virtual;
    function GetCellTransparent(ACell: TcxGridCardRowCellViewInfo): Boolean; virtual;
    function GetDataViewInfoClass: TcxGridCardRowDataViewInfoClass; virtual;
    function GetHeight: Integer; virtual;
    function GetPainterClass: TcxGridCardRowPainterClass; virtual;

    procedure GetCaptionViewParams(var AParams: TcxViewParams); virtual; abstract;
    procedure GetDataViewParams(var AParams: TcxViewParams); virtual; abstract;
    procedure GetViewParams(var AParams: TcxViewParams); virtual; abstract;

    property CaptionWidth: Integer read GetCaptionWidth;
    property CardViewInfo: TcxGridCardViewInfo read FCardViewInfo;
    property DataWidth: Integer read GetDataWidth;
    property GridView: TcxGridCardView read GetGridView;
    property GridRecord: TcxGridCard read GetGridRecord;
    property GridViewInfo: TcxGridCardViewViewInfo read GetGridViewInfo;
    property Row: TcxGridCardViewRow read GetRow;
  public
    Bounds: TRect;
    constructor Create(ACardViewInfo: TcxGridCardViewInfo; AIndex: Integer); virtual;
    destructor Destroy; override;
    function GetHitTest(const P: TPoint): TcxGridRecordCellHitTest; virtual;
    property CaptionViewInfo: TcxGridCardRowCaptionViewInfo read FCaptionViewInfo;
    property DataViewInfo: TcxGridCardRowDataViewInfo read FDataViewInfo;
    property Height: Integer read GetHeight;
    property Index: Integer read FIndex;
  end;

  TcxGridCardDataRowViewInfo = class(TcxGridCardRowViewInfo)
  protected
    procedure GetCaptionViewParams(var AParams: TcxViewParams); override;
    function GetCellBackgroundBitmap(ACell: TcxGridCardRowCellViewInfo): TBitmap; override;
    procedure GetDataViewParams(var AParams: TcxViewParams); override;
  end;

  TcxGridCardCaptionRowViewInfo = class(TcxGridCardRowViewInfo)
  protected
    procedure GetCaptionViewParams(var AParams: TcxViewParams); override;
    function GetCellBackgroundBitmap(ACell: TcxGridCardRowCellViewInfo): TBitmap; override;
    function GetCellTransparent(ACell: TcxGridCardRowCellViewInfo): Boolean; override;
    procedure GetDataViewParams(var AParams: TcxViewParams); override;
    //procedure GetDefaultViewParams(var AParams: TcxViewParams); override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
  end;

  // cards

  TcxGridCardViewInfo = class(TcxCustomGridRecordViewInfo)
  private
    FCaptionWidth: Integer;
    FCol: Integer;
    FRow: Integer;
    FRowViewInfos: TList;
    function GetCaptionWidth: Integer;
    function GetCardBorderWidth: Integer;
    function GetGridView: TcxGridCardView;
    function GetGridRecord: TcxGridCard;
    function GetRecordsViewInfo: TcxGridCardsViewInfo;
    function GetRowViewInfo(Index: Integer): TcxGridCardRowViewInfo;
    function GetRowViewInfoCount: Integer;
    procedure CreateRowViewInfos;
    procedure DestroyRowViewInfos;
  protected
    function CalculateCaptionWidth: Integer; virtual;
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function GetAutoHeight: Boolean; override;
    function GetCardBorderBackgroundBitmap: TBitmap; virtual;
    //function GetBackgroundBitmapBounds: TRect; override;
    function GetCardBorderColor: TColor; virtual;
    function GetContentBounds: TRect; override;
    function GetContentWidth: Integer; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetTransparent: Boolean; override;
    function GetVisible: Boolean; override;
    function GetWidth: Integer; override;

    function GetRowViewInfoClass(ARow: TcxGridCardViewRow): TcxGridCardRowViewInfoClass; virtual;
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

    property CaptionWidth: Integer read GetCaptionWidth;
    property CardBorderBackgroundBitmap: TBitmap read GetCardBorderBackgroundBitmap;
    property CardBorderColor: TColor read GetCardBorderColor;
    property CardBorderWidth: Integer read GetCardBorderWidth;
    property Col: Integer read FCol;
    property GridView: TcxGridCardView read GetGridView;
    property GridRecord: TcxGridCard read GetGridRecord;
    property RecordsViewInfo: TcxGridCardsViewInfo read GetRecordsViewInfo;
    property Row: Integer read FRow;
    property RowViewInfoCount: Integer read GetRowViewInfoCount;
    property RowViewInfos[Index: Integer]: TcxGridCardRowViewInfo read GetRowViewInfo;
  end;

  TcxGridCardsViewInfo = class(TcxCustomGridRecordsViewInfo)
  private
    FCardHeight: Integer;
    FColumns: TcxGridCardViewColumns;
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
    function CalculateBounds: TRect; override;
    function CalculateCardHeight: Integer; virtual;
    function GetAutoCardHeight: Boolean; virtual;
    //procedure GetDataCellDefaultViewParams(ARecord: TcxCustomGridRecord;
    //  AItem: TcxCustomGridTableItem; var AParams: TcxViewParams); override;

    property GridContentBounds: TRect read GetGridContentBounds;
    property GridView: TcxGridCardView read GetGridView;
    property GridViewInfo: TcxGridCardViewViewInfo read GetGridViewInfo;
    property ViewData: TcxGridCardViewViewData read GetViewData;
  public
    constructor Create(AGridViewInfo: TcxCustomGridTableViewInfo); override;
    destructor Destroy; override;
    procedure Calculate; override;
    function GetRealItem(ARecord: TcxCustomGridRecord; ARecordIndex: Integer): TcxGridCardViewInfo; reintroduce; virtual;

    property AutoCardHeight: Boolean read GetAutoCardHeight;
    property CardBorderWidth: Integer read GetCardBorderWidth;
    property CardContentWidth: Integer read GetCardContentWidth;
    property CardHeight: Integer read FCardHeight;
    property CardWidth: Integer read GetCardWidth;
    property Columns: TcxGridCardViewColumns read FColumns;
    property Items[Index: Integer]: TcxGridCardViewInfo read GetItem; default;
    property PartVisibleCount: Integer read FPartVisibleCount;
  end;

  TcxGridCardsHorizontalViewInfo = class(TcxGridCardsViewInfo)
  public
    procedure Calculate; override;
  end;

  TcxGridCardsVerticalViewInfo = class(TcxGridCardsViewInfo)
  public
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
    function GetDefaultGridModeBufferCount: Integer; override;

    function GetRecordsViewInfoClass: TcxCustomGridRecordsViewInfoClass; override;
    function GetSeparatorsViewInfoClass: TcxGridCardViewSeparatorsViewInfoClass; virtual;

    property Controller: TcxGridCardViewController read GetController;
    property GridView: TcxGridCardView read GetGridView;
    property ViewData: TcxGridCardViewViewData read GetViewData;
  public
    function CanOffsetView(ARecordCountDelta: Integer): Boolean; override;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
    property RecordsViewInfo: TcxGridCardsViewInfo read GetRecordsViewInfo;
    property SeparatorsViewInfo: TcxGridCardViewSeparatorsViewInfo read FSeparatorsViewInfo;
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
    property ShowCaption: Boolean read FShowCaption write SetShowCaption default True;
  end;

  TcxGridCardViewRowStyles = class(TcxCustomGridTableItemStyles)
  private
    FOnGetCaptionRowStyle: TcxGridGetCellStyleEvent;
    FOnGetCaptionStyle: TcxGridGetCellStyleEvent;
    function GetGridViewValue: TcxGridCardView;
  protected
    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure GetCaptionParams(ARecord: TcxCustomGridRecord; out AParams: TcxViewParams); virtual;
    procedure GetCaptionRowParams(ARecord: TcxCustomGridRecord; out AParams: TcxViewParams); virtual;
    property GridView: TcxGridCardView read GetGridViewValue;
  published
    property Caption: TcxStyle index isRowCaption read GetValue write SetValue;
    property CaptionRow: TcxStyle index isCaptionRow read GetValue write SetValue;
    property OnGetCaptionRowStyle: TcxGridGetCellStyleEvent read FOnGetCaptionRowStyle
      write FOnGetCaptionRowStyle;
    property OnGetCaptionStyle: TcxGridGetCellStyleEvent read FOnGetCaptionStyle
      write FOnGetCaptionStyle;
  end;

  TcxGridCardViewRowKind = (rkData, rkCaption);

  TcxGridCardViewRow = class(TcxCustomGridTableItem)
  private
    FKind: TcxGridCardViewRowKind;
    function GetCaptionAlignmentHorz: TAlignment;
    function GetCaptionAlignmentVert: TcxAlignmentVert;
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
    // IcxStoredObject
    function GetStoredProperties(AProperties: TStrings): Boolean; override;
    procedure GetPropertyValue(const AName: string; var AValue: Variant); override;
    procedure SetPropertyValue(const AName: string; const AValue: Variant); override;

    function CanFocus: Boolean; override;
    function DefaultWidth: Integer; override;
    function GetOptionsClass: TcxCustomGridTableItemOptionsClass; override;
    function GetStylesClass: TcxCustomGridTableItemStylesClass; override;

    function GridView: TcxGridCardView;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property CaptionAlignmentHorz: TAlignment read GetCaptionAlignmentHorz
      write SetCaptionAlignmentHorz stored IsCaptionAlignmentHorzStored;
    property CaptionAlignmentVert: TcxAlignmentVert read GetCaptionAlignmentVert
      write SetCaptionAlignmentVert stored IsCaptionAlignmentVertStored;
    property Kind: TcxGridCardViewRowKind read FKind write SetKind default rkData;
    property Options: TcxGridCardViewRowOptions read GetOptions write SetOptions;
    property SortOrder;  //!!!
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

  TcxGridCardViewOptionsBehavior = class(TcxCustomGridTableOptionsBehavior)
  public
    constructor Create(AGridView: TcxCustomGridView); override;
  published
    property PullFocusing;
  end;

  TcxGridCardViewOptionsData = class(TcxCustomGridTableOptionsData);

  TcxGridCardViewOptionsSelection = class(TcxCustomGridTableOptionsSelection);

  TcxGridCardViewOptionsView = class(TcxCustomGridTableOptionsView)
  private
    FCaptionSeparator: Char;
    FCaptionWidth: Integer;
    FCardBorderWidth: Integer;
    FCardWidth: Integer;
    FSeparatorColor: TColor;
    FSeparatorWidth: Integer;
    function GetRowCaptionAutoHeight: Boolean;
    function GetRowCaptionEndEllipsis: Boolean;
    procedure SetCaptionSeparator(Value: Char);
    procedure SetCaptionWidth(Value: Integer);
    procedure SetCardBorderWidth(Value: Integer);
    procedure SetCardWidth(Value: Integer);
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
    property CardWidth: Integer read FCardWidth write SetCardWidth default cxGridDefaultCardWidth;
    property CellAutoHeight;
    property CellTextMaxLineCount;
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
    property OnGetCaptionRowStyle: TcxGridGetCellStyleEvent read FOnGetCaptionRowStyle
      write FOnGetCaptionRowStyle;
    property OnGetCardBorderStyle: TcxGridGetRecordStyleEvent read FOnGetCardBorderStyle
      write FOnGetCardBorderStyle;
    property OnGetRowCaptionStyle: TcxGridGetCellStyleEvent read FOnGetRowCaptionStyle
      write FOnGetRowCaptionStyle;
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

  {TcxGridCardViewSummaryGroupItemLink = class(TcxDataSummaryGroupItemLink)
  private
    function GetRow: TcxGridCardViewRow;
    procedure SetRow(Value: TcxGridCardViewRow);
  published
    property Row: TcxGridCardViewRow read GetRow write SetRow;
  end;

  TcxGridCardViewSummaryItem = class(TcxDataSummaryItem)
  private
    function GetRow: TcxGridCardViewRow;
    procedure SetRow(Value: TcxGridCardViewRow);
  published
    property Row: TcxGridCardViewRow read GetRow write SetRow;
  end;}

  TcxGridCardView = class(TcxCustomGridTableView)
  private
    FLayoutDirection: TcxGridCardViewLayoutDirection;
    function GetBackgroundBitmaps: TcxGridCardViewBackgroundBitmaps;
    function GetControl: TcxCustomGrid;
    function GetController: TcxGridCardViewController;
    function GetOptionsBehavior: TcxGridCardViewOptionsBehavior;
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
    procedure SetLayoutDirection(Value: TcxGridCardViewLayoutDirection);
    procedure SetOptionsBehavior(Value: TcxGridCardViewOptionsBehavior);
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

    procedure DoAssign(ASource: TcxCustomGridView); override;
    function IsEqualHeightRecords: Boolean; override;

    function GetBackgroundBitmapsClass: TcxCustomGridBackgroundBitmapsClass; override;
    function GetItemClass: TcxCustomGridTableItemClass; override;
    function GetOptionsBehaviorClass: TcxCustomGridTableOptionsBehaviorClass; override;
    function GetOptionsSelectionClass: TcxCustomGridOptionsSelectionClass; override;
    function GetOptionsViewClass: TcxCustomGridOptionsViewClass; override;
    function GetStylesClass: TcxCustomGridViewStylesClass; override;

    function GetControllerClass: TcxCustomGridControllerClass; override;
    function GetDataControllerClass: TcxCustomDataControllerClass; override;
    function GetPainterClass: TcxCustomGridPainterClass; override;
    function GetViewDataClass: TcxCustomGridViewDataClass; override;
    function GetViewInfoClass: TcxCustomGridViewInfoClass; override;

    //function GetSummaryGroupItemLinkClass: TcxDataSummaryGroupItemLinkClass; override;
    //function GetSummaryItemClass: TcxDataSummaryItemClass; override;

    function CanCardSizing: Boolean; virtual;
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
    property LayoutDirection: TcxGridCardViewLayoutDirection read FLayoutDirection
      write SetLayoutDirection default ldHorizontal;
    property OptionsBehavior: TcxGridCardViewOptionsBehavior read GetOptionsBehavior
      write SetOptionsBehavior;
    property OptionsData: TcxGridCardViewOptionsData read GetOptionsData write SetOptionsData;
    property OptionsSelection: TcxGridCardViewOptionsSelection read GetOptionsSelection
      write SetOptionsSelection;
    property OptionsView: TcxGridCardViewOptionsView read GetOptionsView write SetOptionsView;
    property Styles: TcxGridCardViewStyles read GetStyles write SetStyles;
  end;

implementation

uses
  SysUtils, Math, cxLookAndFeelPainters;

const
  CardIndent = 7;
  CardDataIndent = 2;
  SeparatorSizingZone = 7;
  SeparatorSizingAddZone = 3;

{ TcxGridCardRowCaptionHitTest }

class function TcxGridCardRowCaptionHitTest.GetHitTestCode: Integer;
begin
  Result := htRowCaption;
end;

{ TcxGridCardViewSeparatorHitTest }

class function TcxGridCardViewSeparatorHitTest.GetHitTestCode: Integer;
begin
  Result := htSeparator;
end;

class function TcxGridCardViewSeparatorHitTest.Cursor: TCursor;
begin
  Result := crSizeWE;
end;

function TcxGridCardViewSeparatorHitTest.DragAndDropObjectClass: TcxCustomGridDragAndDropObjectClass;
begin
  Result := TcxGridCardSizingObject;
end;

{ TcxGridCardSizingObject }

function TcxGridCardSizingObject.GetGridView: TcxGridCardView;
begin
  Result := TcxGridCardView(inherited GridView);
end;

procedure TcxGridCardSizingObject.SetDestPointX(Value: Integer);
begin
  if FDestPointX <> Value then
  begin
    Dirty := True;
    FDestPointX := Value;
  end;
end;

procedure TcxGridCardSizingObject.DirtyChanged;
begin
  if not Dirty then
    GridView.OptionsView.CardWidth :=
      CardOriginalWidth + (DestPointX - SourcePoint.X) div (FCardColumnIndex + 1);
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

procedure TcxGridCardSizingObject.RestoreCardWidth;
begin
  GridView.OptionsView.CardWidth := CardOriginalWidth;
end;

procedure TcxGridCardSizingObject.SaveCardWidth;
begin
  CardOriginalWidth := GridView.OptionsView.CardWidth;
end;

procedure TcxGridCardSizingObject.BeginDragAndDrop;
begin
  FDestPointX := CurMousePos.X;
  SaveCardWidth;
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
  if not Accepted then RestoreCardWidth;
end;

procedure TcxGridCardSizingObject.Init(const P: TPoint; AParams: TcxCustomGridHitTest);
begin
  inherited;
  FCardColumnIndex := (AParams as TcxGridCardViewSeparatorHitTest).Index;
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
        Controller.FocusNextRecord(-1, True, False, False);
    VK_END:
      if DataController.IsGridMode then
        DataController.GotoLast
      else
        Controller.FocusNextRecord(-1, False, True, False);
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
    begin
      if FocusedRecordIndex = -1 then
      begin
        if ADirection = dirLeft then
          GoToFirst
        else
          GoToLast(False);
        Exit;
      end;
      MakeFocusedRecordVisible;
      ARecordViewInfo := ViewInfo.RecordsViewInfo.GetRealItem(FocusedRecord, FocusedRecordIndex);
      ACheckPos := ARecordViewInfo.Bounds.Top;
      if ARecordViewInfo.Col = MarginCol(ADirection = dirLeft) then
      begin
        ScrollData(ADirection);
        ARecordViewInfo := ViewInfo.RecordsViewInfo.GetRealItem(FocusedRecord, FocusedRecordIndex);
        if (ARecordViewInfo <> nil) and
          (ARecordViewInfo.Col = MarginCol(ADirection = dirLeft)) then
        begin
          if GridView.IsDetail then
            FocusNextRecord(MarginRecordIndex, ADirection = dirRight, False, False);
          Exit;
        end;
      end;
      ARecordViewInfo := ViewInfo.RecordsViewInfo.Columns[NextCol].GetNearestRow(ACheckPos);
      FocusedRecord := ARecordViewInfo.GridRecord;
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
        FocusNextRecord(FocusedRecordIndex, False, False, False);
      VK_DOWN:
        FocusNextRecord(FocusedRecordIndex, True, False, False);
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
          FocusNextRecord(MarginRecordIndex, ADirection = dirDown, False, False);
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
        FocusNextRecord(FocusedRecordIndex, False, False, False);
      VK_RIGHT:
        FocusNextRecord(FocusedRecordIndex, True, False, False);
      VK_UP:
        FocusRecordInNextRow(dirUp);
      VK_DOWN:
        FocusRecordInNextRow(dirDown)
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
  ScrollRecords(ADirection in [dirRight, dirDown], ScrollDelta);
end;

procedure TcxGridCardViewController.MakeItemVisible(AItem: TcxCustomGridTableItem);
begin
  MakeFocusedRecordVisible;  //!!!
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
          FocusedItem := nil;
      end
    else
      if Key = VK_F2 then
        FocusNextItem(-1, True, False, False);
  end;

begin
  inherited;
  if GridView.OptionsSelection.CellSelect and (FocusedRecordIndex <> -1) and
    ProcessFocusedItemKeys then Exit;
  ImplementationObject.KeyDown(Key, Shift);
end;

procedure TcxGridCardViewController.LayoutDirectionChanged;
begin
  DestroyImplementationObject;
  CreateImplementationObject;
end;

{ TcxGridCardRowPainter }

constructor TcxGridCardRowPainter.Create(ACanvas: TcxCanvas;
  AViewInfo: TcxGridCardRowViewInfo);
begin
  inherited Create;
  FCanvas := ACanvas;
  FViewInfo := AViewInfo;
end;

procedure TcxGridCardRowPainter.DrawFocusRect;
begin
  with ViewInfo do
    if DataViewInfo.Focused{ GridRecord.Focused and Row.Focused} then
      GridViewInfo.Painter.DrawFocusRect(Bounds, CardViewInfo.HideFocusRect);
end;

procedure TcxGridCardRowPainter.Paint;
begin
  with ViewInfo do
  begin
    CaptionViewInfo.Paint;
    DataViewInfo.Paint;
    DrawFocusRect;
  end;
end;

{ TcxGridCardPainter }

function TcxGridCardPainter.GetViewInfo: TcxGridCardViewInfo;
begin
  Result := TcxGridCardViewInfo(inherited ViewInfo);
end;

procedure TcxGridCardPainter.DrawCardBorder;
var
  ABackgroundBitmap: TBitmap;
begin
  with ViewInfo, Self.Canvas do
    if CardBorderBackgroundBitmap = nil then
      FrameRect(Bounds, CardBorderColor, CardBorderWidth)
    else
      with ContentBounds do
      begin  {4}
        ABackgroundBitmap := CardBorderBackgroundBitmap;
        FillRect(Rect(Bounds.Left, Bounds.Top, Bounds.Right, Top), ABackgroundBitmap);
        FillRect(Rect(Bounds.Left, Top, Left, Bottom), ABackgroundBitmap);
        FillRect(Rect(Right, Top, Bounds.Right, Bottom), ABackgroundBitmap);
        FillRect(Rect(Bounds.Left, Bottom, Bounds.Right, Bounds.Bottom), ABackgroundBitmap);
      end;
end;

procedure TcxGridCardPainter.DrawRows;
var
  I: Integer;
  ARowViewInfo: TcxGridCardRowViewInfo;
begin
  for I := 0 to ViewInfo.RowViewInfoCount - 1 do
  begin
    ARowViewInfo := ViewInfo.RowViewInfos[I];
    with ARowViewInfo.GetPainterClass.Create(Canvas, ARowViewInfo) do
      try
        Paint;
      finally
        Free;
      end;
  end;
end;

procedure TcxGridCardPainter.Paint;
begin
  DrawCardBorder;
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

function TcxGridCardViewPainter.ViewInfo: TcxGridCardViewViewInfo;
begin
  Result := TcxGridCardViewViewInfo(inherited ViewInfo);
end;

{ TcxGridCard }

function TcxGridCard.GetHasCells: Boolean;
begin
  Result := True;
end;

function TcxGridCard.GetViewInfoClass: TcxCustomGridRecordViewInfoClass;
begin
  Result := TcxGridCardViewInfo;
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

function TcxGridCardRowCellViewInfo.GetBackgroundBitmap: TBitmap;
begin  {4}
  Result := FRowViewInfo.GetCellBackgroundBitmap(Self);
end;

function TcxGridCardRowCellViewInfo.GetTransparent: Boolean;
begin  {4}
  Result := FRowViewInfo.GetCellTransparent(Self);
end;

{ TcxGridCardRowCaptionViewInfo }

function TcxGridCardRowCaptionViewInfo.CalculateRealWidth: Integer;
begin
  CalculateParams;
  Result := TextAreaWidth;
end;

function TcxGridCardRowCaptionViewInfo.CalculateWidth: Integer;
begin
  Result := FRowViewInfo.CaptionWidth;
end;

function TcxGridCardRowCaptionViewInfo.CalculateHeight: Integer;
begin
  Result := GetTextCellHeight(GridViewInfo, LookAndFeelPainter);
end;

function TcxGridCardRowCaptionViewInfo.CanShowHint: Boolean;
begin
  Result := False;
end;

function TcxGridCardRowCaptionViewInfo.GetAlignmentHorz: TAlignment;
begin
  Result := Row.CaptionAlignmentHorz;
end;

function TcxGridCardRowCaptionViewInfo.GetAlignmentVert: TcxAlignmentVert;
begin
  Result := Row.CaptionAlignmentVert;
end;

function TcxGridCardRowCaptionViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridCardRowCaptionHitTest;
end;

function TcxGridCardRowCaptionViewInfo.GetMultiLine: Boolean;
begin
  Result := GridView.OptionsView.RowCaptionAutoHeight;
end;

function TcxGridCardRowCaptionViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxCustomGridCellPainter;
end;

function TcxGridCardRowCaptionViewInfo.GetShowEndEllipsis: Boolean;
begin
  Result := GridView.OptionsView.RowCaptionEndEllipsis;
end;

function TcxGridCardRowCaptionViewInfo.GetText: string;
begin
  Result := Row.Caption;
  if GridView.OptionsView.CaptionSeparator <> #0 then
    Result := Result + GridView.OptionsView.CaptionSeparator;
end;

procedure TcxGridCardRowCaptionViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  FRowViewInfo.GetCaptionViewParams(AParams);
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

function TcxGridCardRowDataViewInfo.GetMultiLine: Boolean;
begin
  Result := AutoHeight;
end;

function TcxGridCardRowDataViewInfo.GetText: string;
begin
  Result := inherited GetText;
  if (Result = '') and not Row.Options.ShowCaption then
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
  inherited Create;
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
  if Row.Options.ShowCaption then
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
  Result := FCardViewInfo.GridView;
end;

function TcxGridCardRowViewInfo.GetGridRecord: TcxGridCard;
begin
  Result := CardViewInfo.GridRecord;
end;

function TcxGridCardRowViewInfo.GetGridViewInfo: TcxGridCardViewViewInfo;
begin
  Result := GridView.ViewInfo;
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

procedure TcxGridCardRowViewInfo.BeforeRecalculation;
begin
  FCaptionViewInfo.BeforeRecalculation;
  FDataViewInfo.BeforeRecalculation;
end;

procedure TcxGridCardRowViewInfo.Calculate(const ABounds: TRect);
begin
  Bounds := ABounds;
  FCaptionViewInfo.Calculate(ABounds.Left, ABounds.Top, -1, Height);
  FDataViewInfo.Calculate(ABounds.Left + FCaptionViewInfo.Width, ABounds.Top, -1, Height);
end;

function TcxGridCardRowViewInfo.CalculateCaptionWidth: Integer;
begin
  Result := FCaptionViewInfo.CalculateRealWidth;
end;

function TcxGridCardRowViewInfo.CalculateHeight: Integer;
begin
  Result := Max(FCaptionViewInfo.CalculateHeight, FDataViewInfo.CalculateHeight);
end;

function TcxGridCardRowViewInfo.GetCaptionViewInfoClass: TcxGridCardRowCaptionViewInfoClass;
begin
  Result := TcxGridCardRowCaptionViewInfo;
end;

function TcxGridCardRowViewInfo.GetCellBackgroundBitmap(ACell: TcxGridCardRowCellViewInfo): TBitmap;
begin  {4}
  Result := GridView.BackgroundBitmaps.GetBitmap(bbContent);
end;

function TcxGridCardRowViewInfo.GetCellTransparent(ACell: TcxGridCardRowCellViewInfo): Boolean;
begin  {4}
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

function TcxGridCardRowViewInfo.GetPainterClass: TcxGridCardRowPainterClass;
begin
  Result := TcxGridCardRowPainter;
end;

function TcxGridCardRowViewInfo.GetHitTest(const P: TPoint): TcxGridRecordCellHitTest;
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

{ TcxGridCardCaptionRowViewInfo }

procedure TcxGridCardCaptionRowViewInfo.GetCaptionViewParams(var AParams: TcxViewParams);
begin
  GetViewParams(AParams);
end;

function TcxGridCardCaptionRowViewInfo.GetCellBackgroundBitmap(ACell: TcxGridCardRowCellViewInfo): TBitmap;
begin   {4}
  Result := GridView.BackgroundBitmaps.GetBitmap(bbCaptionRow);
end;

function TcxGridCardCaptionRowViewInfo.GetCellTransparent(ACell: TcxGridCardRowCellViewInfo): Boolean;
begin   {4}
  Result := inherited GetCellTransparent(ACell) and not ACell.Selected;
end;

procedure TcxGridCardCaptionRowViewInfo.GetDataViewParams(var AParams: TcxViewParams);
begin
  GetViewParams(AParams);
end;

procedure TcxGridCardCaptionRowViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  GridView.Styles.GetDataCellParams(GridRecord, Row, AParams);
end;

{ TcxGridCardViewInfo }

constructor TcxGridCardViewInfo.Create(ARecordsViewInfo: TcxCustomGridRecordsViewInfo;
  ARecord: TcxCustomGridRecord);
begin
  inherited;
  FCaptionWidth := -1;
  CreateRowViewInfos;
end;

destructor TcxGridCardViewInfo.Destroy;
begin
  DestroyRowViewInfos;
  inherited;
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

function TcxGridCardViewInfo.GetContentBounds: TRect;
begin
  Result := inherited GetContentBounds;
  InflateRect(Result, -CardBorderWidth, -CardBorderWidth);
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
  Result := FRowViewInfos[Index];
end;

function TcxGridCardViewInfo.GetRowViewInfoCount: Integer;
begin
  Result := FRowViewInfos.Count;
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
end;

procedure TcxGridCardViewInfo.DestroyRowViewInfos;
var
  I: Integer;
begin
  for I := 0 to RowViewInfoCount - 1 do RowViewInfos[I].Free;
  FreeAndNil(FRowViewInfos);
end;

function TcxGridCardViewInfo.CalculateCaptionWidth: Integer;
var
  I, ACaptionWidth: Integer;
begin
  Result := GridView.OptionsView.CaptionWidth;
  if Result = 0 then
  begin
    for I := 0 to RowViewInfoCount - 1 do
      if RowViewInfos[I].Row.Options.ShowCaption then
      begin
        ACaptionWidth := RowViewInfos[I].CalculateCaptionWidth;
        if ACaptionWidth > Result then Result := ACaptionWidth;
      end;
    Inc(Result, CardDataIndent);
  end;
  if Result > RecordsViewInfo.CardContentWidth then
    Result := RecordsViewInfo.CardContentWidth;
end;

function TcxGridCardViewInfo.CalculateHeight: Integer;
var
  I: Integer;
begin
  if RecordsViewInfo.AutoCardHeight or (RecordsViewInfo.CardHeight = -1) then
  begin
    Result := 2 * CardBorderWidth;
    for I := 0 to RowViewInfoCount - 1 do
      Inc(Result, RowViewInfos[I].Height);
  end
  else
    Result := RecordsViewInfo.CardHeight;
end;

function TcxGridCardViewInfo.CalculateWidth: Integer;
begin
  Result := 0;
end;

function TcxGridCardViewInfo.GetAutoHeight: Boolean;
begin
  Result := RecordsViewInfo.AutoDataRecordHeight;
end;

(*function TcxGridCardViewInfo.GetBackgroundBitmapBounds: TRect;
begin  {4}
  Result := inherited GetBackgroundBitmapBounds;
  Inc(Result.Left, CaptionWidth);
end;*)

function TcxGridCardViewInfo.GetCardBorderBackgroundBitmap: TBitmap;
begin  {4}
  Result := GridView.BackgroundBitmaps.GetBitmap(bbCardBorder);
end;

function TcxGridCardViewInfo.GetCardBorderColor: TColor;
var
  AParams: TcxViewParams;
begin
  GridView.Styles.GetCardBorderParams(GridRecord, AParams);
  Result := AParams.Color;
end;

function TcxGridCardViewInfo.GetContentWidth: Integer;
begin
  Result := RecordsViewInfo.CardContentWidth;
end;

function TcxGridCardViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridCardPainter;
end;

function TcxGridCardViewInfo.GetTransparent: Boolean;
begin          {4}
  Result := False;
end;

function TcxGridCardViewInfo.GetVisible: Boolean;
begin
  Result := Index < RecordsViewInfo.PartVisibleCount;
end;

function TcxGridCardViewInfo.GetWidth: Integer;
begin
  Result := RecordsViewInfo.CardWidth;
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
  inherited;
  for I := 0 to RowViewInfoCount - 1 do
    RowViewInfos[I].BeforeRecalculation;
end;

procedure TcxGridCardViewInfo.Calculate(ALeftBound, ATopBound: Integer;
  AWidth: Integer = -1; AHeight: Integer = -1);
var
  I: Integer;
  R: TRect;
begin
  inherited;
  R := ContentBounds;
  for I := 0 to RowViewInfoCount - 1 do
  begin
    R.Bottom := R.Top + RowViewInfos[I].Height;
    RowViewInfos[I].Calculate(R);
    R.Top := R.Bottom;
  end;
end;

function TcxGridCardViewInfo.GetBoundsForItem(AItem: TcxCustomGridTableItem): TRect;
begin
  Result := RowViewInfos[AItem.VisibleIndex].Bounds;
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
  AHitTest: TcxGridRecordCellHitTest;
begin
  Result := inherited GetHitTest(P);
  if Result <> nil then
    for I := 0 to RowViewInfoCount - 1 do
    begin
      AHitTest := RowViewInfos[I].GetHitTest(P);
      if AHitTest <> nil then
      begin
        Result := AHitTest;
        Exit;
      end;
    end;  
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
      Result := GridViewInfo.GetFontHeight(GetFont(True));
      Result := TcxGridCardRowCaptionViewInfo.GetCellHeight(Result, GridViewInfo.LookAndFeelPainter);
    end;

    function CalculateDataHeight: Integer;
    begin
      Result := GetCellHeight(ARow.CalculateDefaultCellHeight(Canvas, GetFont(False)));
    end;

  begin
    Result := Max(CalculateCaptionHeight, CalculateDataHeight);
  end;

begin
  Result := 2 * CardBorderWidth;
  for I := 0 to GridView.VisibleRowCount - 1 do
    Inc(Result, CalculateRowHeight(GridView.VisibleRows[I]));
  {if MaxCount = 0 then
    Result := 0
  else
    Result := Items[0].CalculateHeight;}
end;

function TcxGridCardsViewInfo.GetAutoCardHeight: Boolean;
begin
  Result := AutoDataRecordHeight or GridView.OptionsView.RowCaptionAutoHeight;
end;

{procedure TcxGridCardsViewInfo.GetDataCellDefaultViewParams(ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AParams: TcxViewParams);
begin
  inherited;
  RealItems[ARecord.Index].RowViewInfos[AItem.VisibleIndex].GetDefaultViewParams(AParams);
end;}

procedure TcxGridCardsViewInfo.Calculate;
begin
  inherited;
  FCardHeight := CalculateCardHeight;
end;

function TcxGridCardsViewInfo.GetRealItem(ARecord: TcxCustomGridRecord;
  ARecordIndex: Integer): TcxGridCardViewInfo;
begin
  Result := TcxGridCardViewInfo(inherited GetRealItem(ARecord, ARecordIndex));
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

    if (ALeftBound + Items[I].Width <= GridContentBounds.Right) or (ACol = 0) then
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
  inherited;
  if not IsInternalUse and not SizeCalculating and (RecordsViewInfo.CardHeight <> FPrevCardHeight) then
    Controller.PostGridModeBufferCountUpdate;
end;

procedure TcxGridCardViewViewInfo.BeforeCalculating;
begin
  inherited;
  if not IsInternalUse and not SizeCalculating then
    FPrevCardHeight := RecordsViewInfo.CardHeight;
end;

procedure TcxGridCardViewViewInfo.Calculate;
begin
  RecreateViewInfos;
  inherited;
  SeparatorsViewInfo.Calculate;
end;

procedure TcxGridCardViewViewInfo.CalculateHeight(const AMaxSize: TPoint;
  var AHeight: Integer; var AFullyVisible: Boolean);
var
  I, AColumnHeight: Integer;
begin
  MainCalculate(Classes.Bounds(cxGridInvisibleCoordinate, 0, AMaxSize.X, AMaxSize.Y));
  if RecordsViewInfo.Columns.Count = 0 then
    AHeight := 2 * CardIndent + RecordsViewInfo.CardHeight
  else
  begin
    AHeight := 0;
    for I := 0 to RecordsViewInfo.Columns.Count - 1 do
    begin
      AColumnHeight := RecordsViewInfo.Columns[I].LastRow.Bounds.Bottom + CardIndent;
      if AHeight < AColumnHeight then AHeight := AColumnHeight;
    end;
  end;  
  AFullyVisible := True;
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
begin             {2}
  Result := False;
end;

function TcxGridCardViewViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
begin
  Result := SeparatorsViewInfo.GetHitTest(P);
  if Result = nil then
    Result := inherited GetHitTest(P);
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
    GridView.SizeChanged;
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
      if not CanFocus then Focused := False;
      GridView.SizeChanged;
    end;
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

function TcxGridCardViewRow.GetStoredProperties(AProperties: TStrings): Boolean;
begin
  inherited GetStoredProperties(AProperties);
  with AProperties do
    Add('Kind');
  Result := True;
end;

procedure TcxGridCardViewRow.GetPropertyValue(const AName: string; var AValue: Variant);
begin
  if AName = 'Kind' then
    AValue := Kind
  else
    inherited;
end;

procedure TcxGridCardViewRow.SetPropertyValue(const AName: string; const AValue: Variant);
begin
  if AName = 'Kind' then
    Kind := AValue
  else
    inherited;
end;

function TcxGridCardViewRow.CanFocus: Boolean;
begin
  Result := inherited CanFocus and (FKind = rkData);
end;

function TcxGridCardViewRow.DefaultWidth: Integer;
begin
  Result := DataBinding.DefaultWidth(False);
end;

function TcxGridCardViewRow.GetOptionsClass: TcxCustomGridTableItemOptionsClass;
begin
  Result := TcxGridCardViewRowOptions;
end;

function TcxGridCardViewRow.GetStylesClass: TcxCustomGridTableItemStylesClass;
begin
  Result := TcxGridCardViewRowStyles;
end;

function TcxGridCardViewRow.GridView: TcxGridCardView;
begin
  Result := TcxGridCardView(inherited GridView);
end;

procedure TcxGridCardViewRow.Assign(Source: TPersistent);
begin                   //!!!
  if Source is TcxGridCardViewRow then
    with TcxGridCardViewRow(Source) do
    begin
      Self.Kind := Kind;
    end;
  inherited;
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

{ TcxGridCardViewOptionsBehavior }

constructor TcxGridCardViewOptionsBehavior.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FocusCellOnCycle := True;
end;

{ TcxGridCardViewOptionsView }

constructor TcxGridCardViewOptionsView.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FCardBorderWidth := cxGridDefaultCardBorderWidth;
  FCaptionSeparator := cxGridDefaultCardViewCaptionSeparator;
  FCardWidth := cxGridDefaultCardWidth;
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
    SizeChanged;
  end;
end;

procedure TcxGridCardViewOptionsView.SetCaptionWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FCaptionWidth <> Value then
  begin
    FCaptionWidth := Value;
    SizeChanged;
  end;
end;

procedure TcxGridCardViewOptionsView.SetCardBorderWidth(Value: Integer);
begin
  if Value < cxGridMinCardBorderWidth then Value := cxGridMinCardBorderWidth;
  if FCardBorderWidth <> Value then
  begin
    FCardBorderWidth := Value;
    SizeChanged;
  end;
end;

procedure TcxGridCardViewOptionsView.SetCardWidth(Value: Integer);
begin
  if Value < cxGridMinCardWidth then Value := cxGridMinCardWidth;
  if FCardWidth <> Value then
  begin
    FCardWidth := Value;
    SizeChanged;
    TcxGridCardView(GridView).Controller.PostGridModeBufferCountUpdate;
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
    LayoutChanged;
  end;
end;

procedure TcxGridCardViewOptionsView.SetSeparatorWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FSeparatorWidth <> Value then
  begin
    FSeparatorWidth := Value;
    LayoutChanged;
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
      Self.CardWidth := CardWidth;
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

(*{ TcxGridCardViewSummaryGroupItemLink }

function TcxGridCardViewSummaryGroupItemLink.GetRow: TcxGridCardViewRow;
begin
  Result := TcxGridCardViewRow(ItemLink);
end;

procedure TcxGridCardViewSummaryGroupItemLink.SetRow(Value: TcxGridCardViewRow);
begin
  ItemLink := Value;
end;

{ TcxGridCardViewSummaryItem }

function TcxGridCardViewSummaryItem.GetRow: TcxGridCardViewRow;
begin
  Result := TcxGridCardViewRow(ItemLink);
end;

procedure TcxGridCardViewSummaryItem.SetRow(Value: TcxGridCardViewRow);
begin
  ItemLink := Value;
end;*)

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

function TcxGridCardView.GetOptionsBehavior: TcxGridCardViewOptionsBehavior;
begin
  Result := TcxGridCardViewOptionsBehavior(inherited OptionsBehavior);
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

procedure TcxGridCardView.SetLayoutDirection(Value: TcxGridCardViewLayoutDirection);
begin
  if FLayoutDirection <> Value then
  begin
    FLayoutDirection := Value;
    Controller.LayoutDirectionChanged;
    SizeChanged;
  end;
end;

procedure TcxGridCardView.SetOptionsBehavior(Value: TcxGridCardViewOptionsBehavior);
begin
  inherited OptionsBehavior := Value;
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

procedure TcxGridCardView.DoAssign(ASource: TcxCustomGridView);
begin
  if ASource is TcxGridCardView then
    with TcxGridCardView(ASource) do
    begin
      Self.LayoutDirection := LayoutDirection;
    end;
  inherited;
end;

function TcxGridCardView.IsEqualHeightRecords: Boolean;
begin
  Result := inherited IsEqualHeightRecords;//False;
end;

function TcxGridCardView.GetBackgroundBitmapsClass: TcxCustomGridBackgroundBitmapsClass;
begin        {4}
  Result := TcxGridCardViewBackgroundBitmaps;
end;

function TcxGridCardView.GetItemClass: TcxCustomGridTableItemClass;
begin
  Result := TcxGridCardViewRow;
end;

function TcxGridCardView.GetOptionsBehaviorClass: TcxCustomGridTableOptionsBehaviorClass;
begin
  Result := TcxGridCardViewOptionsBehavior;
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

{function TcxGridCardView.GetSummaryGroupItemLinkClass: TcxDataSummaryGroupItemLinkClass;
begin
  Result := TcxGridCardViewSummaryGroupItemLink;
end;}

{function TcxGridCardView.GetSummaryItemClass: TcxDataSummaryItemClass;
begin
  Result := TcxGridCardViewSummaryItem;
end;}

function TcxGridCardView.CanCardSizing: Boolean;
begin
  Result := True; //!!! 
end;

function TcxGridCardView.CreateRow: TcxGridCardViewRow;
begin
  Result := TcxGridCardViewRow(CreateItem);
end;

initialization
  cxGridRegisteredViews.Register(TcxGridCardView, 'Card View');
  Classes.RegisterClasses([TcxGridCardViewRow, TcxGridCardViewStyleSheet]);

finalization
  cxGridRegisteredViews.Unregister(TcxGridCardView);

end.
