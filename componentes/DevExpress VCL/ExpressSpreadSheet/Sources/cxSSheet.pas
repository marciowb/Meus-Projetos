{*******************************************************************}
{                                                                   }
{       Developer Express Cross platform Visual Component Library   }
{       ExpressSpreadSheet main unit			            }
{                                                                   }
{       Copyright (c) 2001-2010 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSSPREADSHEET AND ALL           }
{   ACCOMPANYING VCL AND CLX CONTROLS AS PART OF AN EXECUTABLE      }
{   PROGRAM ONLY.                                                   }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit cxSSheet;

{$I cxVer.inc}

interface

uses
  Classes, SysUtils, Math,  Windows, Messages, Variants,
  Forms, StdCtrls, Menus, Controls, Dialogs, Graphics, ExtCtrls,
  dxCore, cxClasses, cxControls, cxGraphics,
{$IFNDEF cxLib10}
  cxLookAndFeels,
{$ENDIF}
  cxExcelConst, cxExcelAccess, cxSSHeaders, cxSSData,
  cxSSTypes, cxSSStyles, cxSSFormulas, cxSSViewInfo, cxSSPainters, cxSSEditors,
  cxSSUtils, cxSSPainterWrapper, cxSSIntf, cxSSRes, cxSSHistory, Clipbrd;

type
  TcxCustomSpreadSheetBook = class;
  TcxSSBookSheet = class;
  ESpreadSheetError = class(EdxException);

  TcxSSListenerClass = class of TcxSSListener;
  TcxSSBookSheetClass = class of TcxSSBookSheet;
  TcxSSFormatDialogClass = class of TcxSSFormatDialog;

  TcxScrollBars = (sbsNone, sbsHorizontal, sbsVertical, sbsBoth);

  { TcxSSListener }
  TcxSSListener = class
  private
    FLockCount: Integer;
    FOwner: TcxCustomSpreadSheetBook;
  protected
    function BeginUpdate: Integer;
    function EndUpdate: Integer;
    function IsLocked: Boolean;
    procedure OnActiveCellChanging(Sender: TcxSSBookSheet;
      const ActiveCell: TPoint; var CanSelect: Boolean); virtual;
    procedure OnActiveSheetChanging(Sender: TcxCustomSpreadSheetBook;
      const ActiveSheet: Integer; var CanSelect: Boolean); virtual;
    procedure OnChangeCellData(Sender: TcxSSBookSheet; const ACol, ARow: Integer); virtual;
    procedure OnChangeDefaultStyle(const AOldValue, ANewValue: TcxSSCellStyleRec); virtual;
    procedure OnChangeLockColRow(Sender: TcxSSBookSheet; AKind: TcxSSHeaderType;
      AIndex: Integer; AOldValue, ANewValue: Boolean); virtual;
    procedure OnChangeSelection(Sender: TcxSSBookSheet;
      const AOldValue, ANewValue: TRect); virtual;
    procedure OnChangeSheetCaption(Sender: TcxSSBookSheet; var ACaption: string); virtual;
    procedure OnChangeSizeColRow(Sender: TcxSSBookSheet; AKind: TcxSSHeaderType;
      AIndex: Integer; var ANewSize: TcxSSSize); virtual;
    procedure OnChangeVisibleColRow(Sender: TcxSSBookSheet; AKind: TcxSSHeadertype;
      AIndex: Integer;  AOldValue, ANewValue: Boolean); virtual;
    procedure OnClearCells(Sender: TcxSSBookSheet; const ACellRec: TRect;
      var AUseDefaultStyle, CanClear: Boolean); virtual;
    procedure OnEditing(Sender: TcxSSBookSheet; const ACol, ARow: Integer;
      var CanEdit: Boolean); virtual;
    procedure OnDeleteCells(Sender: TcxSSBookSheet; ACellRect: TRect;
      AModifyType: TcxSSModifyType); virtual;
    procedure OnHistoryChanged(Sender: TObject); virtual;
    procedure OnInsertCells(Sender: TcxSSBookSheet; ACellRect: TRect;
      AModifyType: TcxSSModifyType); virtual;
    procedure OnMergeCells(Sender: TcxSSBookSheet; ACellRect: TRect;
      AIsMerge: Boolean; var CanMerge: Boolean); virtual;
    procedure OnProgress(Sender: TObject; APercent: Byte); virtual;
    procedure OnResizeDataLength(Sender: TcxSSBookSheet; AType: TcxSSHeaderType); virtual;
    procedure OnSheetPopupMenu(Sender: TcxSSBookSheet;
      const AHitPoint: TPoint); virtual;
    procedure OnTopLeftChanging(Sender: TcxSSBookSheet; var ATopLeft: TPoint); virtual;
    procedure OnCaptionPopupMenu(Sender: TcxSSBookSheet;
      const AHitPoint: TPoint); virtual;
    procedure UpdateAfterChanged(Sender: TcxSSBookSheet; ACellRect: TRect); virtual;
    property LockRef: Integer read FLockCount;
  public
    constructor Create(AOwner: TcxCustomSpreadSheetBook); virtual;
    property Owner: TcxCustomSpreadSheetBook read FOwner;
  end;

  { TcxWorkBookControl }
  TcxWorkBookSubControl = class(TInterfacedObject)
  private
    FBounds: TRect;
    FOwner: TcxCustomSpreadSheetBook;
    FVisible: Boolean;
    function GetBoundsRect: TRect;
    function GetCanvas: TcxCanvasWrapper;
    function GetClientRect: TRect;
    function GetControlCanvas: TCanvas;
    function GetCursor: TCursor;
    function GetHeight: Integer;
    function GetLeft: Integer;
    function GetTop: Integer;
    function GetWidth: Integer;
    procedure SetBoundsRect(ARect: TRect);
    procedure SetCursor(const Value: TCursor);
    procedure SetHeight(const Value: Integer);
    procedure SetLeft(const Value: Integer);
    procedure SetTop(const Value: Integer);
    procedure SetVisible(const Value: Boolean);
    procedure SetWidth(const Value: Integer);
  protected
    function ClientToScreen(const X, Y: Integer): TPoint;
    procedure DblClick; virtual;
    procedure FocusChanged; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); virtual;
    procedure KeyPress(var Key: Char); virtual;
    procedure KeyUp(var Key: Word; Shift: TShiftState); virtual;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure Paint; virtual;
    procedure Resize; virtual;
    procedure SetBounds(const ALeft, ATop, AWidth, AHeight: Integer);
    procedure VisibleChanging; virtual;
    property Canvas: TcxCanvasWrapper read GetCanvas;
    property ControlCanvas: TCanvas read GetControlCanvas;
    property BoundsRect: TRect read GetBoundsRect write SetBoundsRect;
    property ClientRect: TRect read GetClientRect;
    property Height: Integer read GetHeight write SetHeight;
    property Left: Integer read GetLeft write SetLeft;
    property Owner: TcxCustomSpreadSheetBook read FOwner;
    property Top: Integer read GetTop write SetTop;
    property Visible: Boolean read FVisible write SetVisible;
    property Width: Integer read GetWidth write SetWidth;
    property Cursor: TCursor read GetCursor write SetCursor;
  public
    constructor Create(AOwner: TcxCustomSpreadSheetBook); virtual;
    procedure Invalidate; virtual;
    procedure InvalidateRect(ARect: TRect);
  end;

  TcxSSBookPageCaptionsClass = class of TcxSSBookPageCaptions;

  { TcxSSBookPageCaptions }
  TcxSSBookPageCaptions = class(TcxWorkBookSubControl)
  private
    FCaptionEditor: TcxSSInplaceTextEdit;
    FCaptionPainter: TcxPageCaptionPainter;
    FIsEditorActivate: Boolean;
    FMouseDownPos: TPoint;
    FSkipActivePageChanging: Boolean;
    FViewInfo: TcxSSBookCaptionViewInfo;
    function GetFirstVisibleCaption: Integer;
    procedure SetFirstVisibleCaption(const Value: Integer);
  protected
    procedure ActivateEditor;
    procedure DblClick; override;
    procedure DoEditCaption; virtual;
    function GetCaptionTextExtent(APage: Integer): TRect;
    function HitTest(X, Y: Integer; var AIndex: Integer): TcxSSCaptionHitTest;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure OnEditCaptionText(Sender: TObject); virtual;
    procedure OnEndEditCaption(Sender: TObject); virtual;
    procedure Paint; override;
    procedure ReCalcViewInfo; virtual;
    procedure Resize; override;
    procedure UpdateCaptionInfo(APage: Byte; AState: TcxSSCaptionStates); virtual;
    procedure VisibleChanging; override;
    property ViewInfo: TcxSSBookCaptionViewInfo read FViewInfo;
    property PageCaptionPainter: TcxPageCaptionPainter read FCaptionPainter write FCaptionPainter;
  public
    property FirstVisibleCaption: Integer read GetFirstVisibleCaption write SetFirstVisibleCaption;
    constructor Create(AOwner: TcxCustomSpreadSheetBook); override;
    destructor Destroy; override;
    procedure MakeTabVisible(AIndex: Integer);
  end;

  { TcxSSCellObject }
  TcxSSCellObject = class(TInterfacedObject, IcxSpreadSheetCell)
  private
    FCol: Integer;
    FComplexAction: TcxComplexAction;
    FCreatedStyle: TcxSSCellStyle;
    FOwner: TcxSSDataStorage;
    FAction: TcxCustomAction;
    FRow: Integer;
    function GetCellStyle: IcxSpreadSheetCellStyle;
    function GetCellTextValue: string;
    function GetCellValue: Variant;
    function GetDataType: TcxSSDataType;
    function GetDateTime: TDateTime;
    function GetDisplayText: string;
    function GetDisplayTextAlignment: TcxDisplayTextAlignment;
    function GetIsLoading: Boolean;
    function GetMergedRect: TRect;
    function GetOwnerSheet: TcxSSBookSheet;
    function GetStyle: TcxSSCellStyle;
    function GetStyleExist: Boolean;
    function GetText: string;
    procedure SetDateTime(const Value: TDateTime);
    procedure SetStyle(const Value: TcxSSCellStyle);
    procedure SetText(const Value: string);
    procedure SetTextEx(const Value: string; IsFormula: Boolean = False; Analyze: Boolean = True);
  protected
    procedure CheckCellWordBreak;
    property Action: TcxCustomAction read FAction;
    property ComplexAction: TcxComplexAction read FComplexAction;
    property IsLoading: Boolean read GetIsLoading;
    property Owner: TcxSSDataStorage read FOwner;
    property OwnerSheet: TcxSSBookSheet read GetOwnerSheet;
    property MergedRect: TRect read GetMergedRect;
  public
    constructor Create(AOwner: TcxSSDataStorage; ACol, ARow: Integer); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TcxSSCellObject); virtual;
    procedure SetCellText(const AText: string; const NeedParse: Boolean = False);
    property Col: Integer read FCol;
    property DateTime: TDateTime read GetDateTime write SetDateTime;
    property DataType: TcxSSDataType read GetDataType;
    property DisplayText: string read GetDisplayText;
    property DisplayTextAlignment: TcxDisplayTextAlignment read GetDisplayTextAlignment;
    property Text: string read GetText write SetText;
    property Row: Integer read FRow;
    property CellValue: Variant read GetCellValue;
    property Style: TcxSSCellStyle read GetStyle write SetStyle;
    property StyleExist: Boolean read GetStyleExist;
  end;

  TcxSSSheetState = (ssResize, ssColHeader, ssRowHeader, ssEditorActivate, ssSelection);
  TcxSSSheetStates = set of TcxSSSheetState;

  { TcxSSBookSheet }
  TcxSSBookSheet = class(TcxWorkBookSubControl, IcxBookSheet)
  private
    FChangedSizeValue: TcxSSSize;
    FCurrentPos: TPoint;
    FDataStorage: TcxSSDataStorage;
    FDownCellPos: TPoint;
    FEditingPos: TPoint;
    FIsEditMode: Boolean;
    FMouseDownPos: TPoint;
    FProtected: Boolean;
    FReadOnly: Boolean;
    FResizeHeaderType: TcxSSHeaderType;
    FSheetViewInfo: TcxSSheetViewInfo;
    FSheetState: TcxSSSheetStates;
    FShowGrid: Boolean;
    FShowHeaders: Boolean;
    FShowFormulas: Boolean;
    FSizeIndex: Integer;
    FStartSelection: TPoint;
    function GetActiveCell: TPoint;
    function GetCell(const ACol, ARow: Integer): IcxSpreadSheetCell;
    function GetCellEditor: TcxSSInplaceTextEdit;
    function GetColHeader: TcxSSHeader;
    function GetColumnCount: Integer;
    function GetCorners: TRect;
    function GetContentColCount: Integer;
    function GetContentRowCount: Integer;
    function GetCurrentCol: Integer;
    function GetCurrentRow: Integer;
    function GetHistory: TcxSpreadSheetHistory;
    function GetIsLoaded: Boolean;
    function GetListener: TcxSSListener;
    function GetPageIndex: Integer;
    function GetSheetCaption: string;
    function GetRowCount: Integer;
    function GetRowHeader: TcxSSHeader;
    function GetSelectionRect: TRect;
    function GetTopLeft: TPoint;
    procedure SetActiveCell(const Value: TPoint);
    procedure SetColRowSize(const AKind: TcxSSHeaderType;
      const AColumn, ASize: Integer; ALocked: Boolean; AVisible: Boolean = True);
    procedure SetCorners(const Value: TRect);
    procedure SetDefaultSize(const AKind: TcxSSHeaderType; ASize: Integer);
    procedure SetMergedCells(const ARect: TRect; IsMerge: Boolean);
    procedure SetPageDimension(const AHorzCount, AVertCount: Integer);
    procedure SetProtection(Value: Boolean);
    procedure SetSheetCaption(Value: string);
    procedure SetShowGrid(const Value: Boolean);
    procedure SetShowHeaders(const Value: Boolean);
    procedure SetShowFormulas(const Value: Boolean);
    procedure SetSelectionRect(Value: TRect);
    procedure SetTopLeft(const Value: TPoint);
    procedure SetViewInformation(const ASelectionRect: TRect;
      AViewFormulas, AViewGrid, AViewHeaders, AScrollBars: Boolean);
  protected
    procedure CellsChanged(const ARect: TRect); virtual;
    procedure DblClick; override;
    function DoEditorActivate: Boolean; virtual;
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean; virtual;
    procedure FocusChanged; override;
    procedure InitScrollBars; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure OnEndEditCell(Sender: TObject); virtual;
    procedure Paint; override;
    procedure Scroll(AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode;
      var AScrollPos: Integer; IsViewInfoUpdate: Boolean = True); virtual;
    function ViewInfoValid: Boolean;
    property CurrentPos: TPoint read FCurrentPos;
    property CellEditor: TcxSSInplaceTextEdit read GetCellEditor;
    property DataStorage: TcxSSDataStorage read FDataStorage;
    property IsEditMode: Boolean read FIsEditMode write FIsEditMode;
    property IsLoaded: Boolean read GetIsLoaded;
    property History: TcxSpreadSheetHistory read GetHistory;
    property Listener: TcxSSListener read GetListener;
    property TopLeft: TPoint read GetTopLeft write SetTopLeft;
    property ViewInfo: TcxSSheetViewInfo read FSheetViewInfo;
  public
    constructor Create(AOwner: TcxCustomSpreadSheetBook); override;
    destructor Destroy; override;
    procedure ApplyAutoHeight(ARow: Integer); virtual;
    procedure Assign(Source: TcxSSBookSheet); virtual;
    procedure ClearAll; virtual;
    procedure ClearCells(const ARect: TRect; SetDefaultStyle: Boolean = False);
    procedure Copy(const ARect: TRect; IsCut: Boolean);
    procedure DeleteCells(const ACells: TRect; ACellsModify: TcxSSCellsModify);
    procedure FormatCells(const ACells: TRect);
    function GetCellObject(ACol, ARow: Integer): TcxSSCellObject; virtual;
    procedure InsertCells(const ACells: TRect; ACellsModify: TcxSSCellsModify);
    procedure Invalidate; override;
    procedure Paste(const APlace: TPoint);
    procedure SelectCell(const ACol, ARow: Integer; OpenEditor: Boolean = False);
    procedure SetMergedState(const ARect: TRect; IsMerge: Boolean);
    procedure SetVisibleState(const ARect: TRect; ACols, ARows, AShow: Boolean);
    procedure Sort(const ARect: TRect; const ASortTypes: array of TcxSortType);
    property ActiveCell: TPoint read GetActiveCell write SetActiveCell;
    property Caption: string read GetSheetCaption write SetSheetCaption;
    property Col: Integer read GetCurrentCol;
    property Cols: TcxSSHeader read GetColHeader;
    property ColumnCount: Integer read GetColumnCount;
    property Corners: TRect read GetCorners write SetCorners;
    property ContentColCount: Integer read GetContentColCount;
    property ContentRowCount: Integer read GetContentRowCount;
    property PageIndex: Integer read GetPageIndex;
    property Protected: Boolean read FProtected write FProtected;
    property ReadOnly: Boolean read FReadOnly write FReadOnly;
    property Row: Integer read GetCurrentRow;
    property Rows: TcxSSHeader read GetRowHeader;
    property RowCount: Integer read GetRowCount;
    property SelectionRect: TRect read GetSelectionRect write SetSelectionRect;
    property ShowGrid: Boolean read FShowGrid write SetShowGrid;
    property ShowHeaders: Boolean read FShowHeaders write SetShowHeaders;
    property ShowFormulas: Boolean read FShowFormulas write SetShowFormulas;
  end;

  TcxSSActiveCellChangingEvent = procedure(Sender: TcxSSBookSheet;
    const ActiveCell: TPoint; var CanSelect: Boolean) of object;
  TcxSSActiveSheetChangingEvent = procedure(Sender: TcxCustomSpreadSheetBook;
    const ActiveSheet: Integer; var CanSelect: Boolean) of object;
  TcxSSCellChangeEvent = procedure(Sender: TcxSSBookSheet; const ACol, ARow: Integer) of object;
  TcxSSClearCellsEvent = procedure(Sender: TcxSSBookSheet; const ACellRect: TRect;
    var UseDefaultStyle, CanClear: Boolean) of object;
  TcxSSCustomPaintEvent = procedure (Sender: TObject;
    var PainterClass: TcxSheetPainterClass) of object;
  TcxSSDeleteSheetEvent = procedure(const ASheet: Integer; var CanDelete: Boolean) of object;
  TcxSSExchangeSheetsEvent  = procedure(const ASheet1, ASheet2: Integer; var CanExchange: Boolean) of object;
  TcxSSSetSelectionEvent = procedure (Sender: TObject; ASheet: TcxSSBookSheet) of object;
  TcxSSSetPositionEvent = procedure (Sender: TObject; ASheet: TcxSSBookSheet) of object;
  TcxSSChangeVisible = procedure (Sender: TObject; ASheet: TcxSSBookSheet;
    AChangedIndex: Integer; APrevValue, ANewValue: Boolean) of object;
  TcxSSPopupMenuEvent = procedure (Sender: TObject; X, Y: Integer) of object;
  TcxSSResizeEvent = procedure(Sender: TcxSSBookSheet;
    AIndex: Integer; var ANewSize: TcxSSSize) of object;
  TcxSSFormatCellsEvent = procedure(Sender: TObject; var ACells: TRect;
    var CanFormat: Boolean; out FormatDialogClass: TcxSSFormatDialogClass) of object;
  TcxSSTopLeftChangingEvent = procedure(Sender: TcxSSBookSheet; var ATopLeft: TPoint) of object;
  TcxSSMergeCellsEvent = procedure(Sender: TcxSSBookSheet; ACellRect: TRect;
    AIsMerge: Boolean; var CanMerge: Boolean) of object;
  TcxSSChangeCaptionEvent = procedure(Sender: TcxSSBookSheet; var ACaption: string) of object;
  TcxSSEditingEvent = procedure(Sender: TcxSSBookSheet; const ACol, ARow: Integer;
    var CanEdit: Boolean) of object;

  { TcxCustomSpreadSheetBook }
  TcxCustomSpreadSheetBook = class(TcxControl, IUnknown, IcxSpreadSheetBook)
  private
    FTimer: TTimer;
    FActivePage: Integer;
    FBufferedPaint: Boolean;
    FCanvas: TcxCanvasWrapper;
    FCaptionBar: TcxSSBookPageCaptions;
    FCaptureControl: TcxWorkBookSubControl;
    FCellEditor: TcxSSInplaceTextEdit;
    FColHeaderHeight: Integer;
    FContextPopupHandled: Boolean;
    FDefaultColWidth: TcxSSSize;
    FDefaultRowHeight: TcxSSSize;
    FFormulasCache: TcxSSFormulasCache;
    FFloatPrecision: Byte;
    FGridColor: TColor;
    FHeaderColor: TColor;
    FHeaderFont: TFont;
    FHistory: TcxSpreadSheetHistory;
    FHideSelection: Boolean;
    FIsLoaded: Boolean;
    FListener: TcxSSListener;
    FProtected: Boolean;
    FMouseDownPos: TPoint;
    FMousePos: TPoint;
    FModified: Boolean;
    FPainter: TcxSheetPainter;
    FPaintBitmap: TBitmap;
    FPainterType: TcxSSPainterType;
    FPages: TList;
    FPageVisible: array of Boolean;
    FPalette: TcxExcelPalette;
    FReadOnly: Boolean;
    FRowHeaderWidth: Integer;
    FRowsAutoHeight: Boolean;
    FScrollBars: TcxScrollBars;
    FSelectionColor: TColor;
    FShift: TShiftState;
    FShowCaptionBar: Boolean;
    FShowFormulas: Boolean;
    FShowGrid: Boolean;
    FStyleCache: TcxSSStyleCache;
    FWindowColor: TColor;
    FOnActiveCellChanging: TcxSSActiveCellChangingEvent;
    FOnActiveSheetChanging: TcxSSActiveSheetChangingEvent;
    FOnAfterCalculation: TNotifyEvent;
    FOnCaptionPopupMenu: TcxSSPopupMenuEvent;
    FOnCellChange: TcxSSCellChangeEvent;
    FOnClearCells: TcxSSClearCellsEvent;
    FOnChangeColVisible: TcxSSChangeVisible;
    FOnChangeCaption: TcxSSChangeCaptionEvent;
    FOnChangeRowVisible: TcxSSChangeVisible;
    FOnCustomPaint: TcxSSCustomPaintEvent;
    FOnEditing: TcxSSEditingEvent;
    FOnEndEdit: TNotifyEvent;
    FOnFormatCells: TcxSSFormatCellsEvent;
    FOnHistoryChanged: TNotifyEvent;
    FOnMergeCells: TcxSSMergeCellsEvent;
    FOnProgress: TcxProgressEvent;
    FOnResizeCol: TcxSSResizeEvent;
    FOnResizeRow: TcxSSResizeEvent;
    FOnSetSelection: TcxSSSetSelectionEvent;
    FOnSheetPopupMenu: TcxSSPopupMenuEvent;
    FOnTopLeftChanging: TcxSSTopLeftChangingEvent;
    FExcelProtectionStyle: Boolean;
    function AddSheet(const AName: string; AVisible: Boolean): IcxBookSheet;
    function GetActiveCell: TPoint;
    function GetActiveSheet: TcxSSBookSheet;
    function GetAutoReCalc: Boolean;
    function GetCell(APage: Word; ACol, ARow: Integer): IcxSpreadSheetCell;
    function GetDefinedNames: TcxSSNamesDef;
    function GetDefaultStyle: TcxSSDefaultStyle;
    function GetPage(APage: Integer): TcxSSBookSheet;
    function GetPageCount: Word;
    function GetPageSelection(APage: Word): TRect;
    function GetPageVisible(APage: Word): Boolean;
    function GetRCRefStyle: Boolean;
    function GetSelection: TRect;
    function GetSheet(APage: Word): IcxBookSheet;
    function GetShowHeaders: Boolean;
    procedure SetActiveCell(const AValue: TPoint);
    procedure SetActivePage(AValue: Integer);
    procedure SetAutoRecalc(const AValue: Boolean);
    procedure SetBufferedPaint(const AValue: Boolean);
    procedure SetColHeaderHeight(const AValue: Integer);
    procedure SetCustomPainter(const AValue: TcxSSCustomPaintEvent);
    procedure SetDefaultColWidth(const AValue: TcxSSSize);
    procedure SetDefaultStyle(const AStyle: PcxSSCellStyleRec);
    procedure SetDefaultStyleProperty(AValue: TcxSSDefaultStyle);
    procedure SetDefaultRowHeight(const AValue: TcxSSSize);
    procedure SetDefaultColor(const AValue: TColor);
    procedure SetFloatPrecision(const AValue: Byte);
    procedure SetGridColor(const AValue: TColor);
    procedure SetHeaderFont(AValue: TFont);
    procedure SetHeaderColor(const AValue: TColor);
    procedure SetPainterType(const AValue: TcxSSPainterType);
    procedure SetPageCount(const AValue: Word);
    procedure SetPageSelection(APage: Word; const AValue: TRect);
    procedure SetPageVisible(APage: Word; const AValue: Boolean);
    procedure SetPalette(const APalette: PcxExcelPalette);
    procedure SetProtection(Value: Boolean);
    procedure SetRCRefStyle(const AValue: Boolean);
    procedure SetReadOnly(const AValue: Boolean);
    procedure SetRowHeaderWidth(const AValue: Integer);
    procedure SetSelectionColor(const AValue: TColor);
    procedure SetScrollBars(const AValue: TcxScrollBars);
    procedure SetShowCaptionBar(const AValue: Boolean);
    procedure SetShowFormulas(const AValue: Boolean);
    procedure SetShowHeaders(const AValue: Boolean);
    procedure SetShowGrid(const AValue: Boolean);
    procedure SetSelection(const AValue: TRect);
    procedure CM_CHANGELOCALE(var Message: TMessage); message CM_WININICHANGE;
  protected
    IsDataLoading: Boolean;
    procedure AddPage(ASheet: TcxSSBookSheet); virtual;
    procedure AddSheetPage(const APageName: string = ''); virtual;
    procedure AdjustControls; virtual;
    procedure DblClick; override;
    procedure DoRecalc;
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
      MousePos: TPoint): Boolean; override;
    procedure DoContextPopup( MousePos: TPoint; var Handled: Boolean); override;
    procedure FocusChanged; override;
    function GetBookPageCaptionsClass: TcxSSBookPageCaptionsClass; virtual;
    function GetCaptionPainterClass: TcxPageCaptionPainterClass; virtual;
    function GetDataStorageClass: TcxSSDataStorageClass; virtual;
    function GetFormulasCacheClass: TcxFormulasCacheClass; virtual;
    function GetHeaderClass: TcxSSHeaderClass; virtual;
    function GetHistoryClass: TcxSSHistoryClass; virtual;
    function GetHScrollBarBounds: TRect; override;
    function GetInplaceEditClass: TcxSSInplaceEditClass; virtual;
    function GetListenerClass: TcxSSListenerClass; virtual;
    function GetPainterClass: TcxSheetPainterClass; virtual;
    function GetPalettePtr: PcxExcelPalette;
    function GetStyleCacheClass: TcxSSStyleCacheClass; virtual;
    function GetSheetClass: TcxSSBookSheetClass; virtual;
    function GetVScrollBarBounds: TRect; override;
    function GetViewInfoClass: TcxSSheetViewInfoClass; virtual;
    procedure InitScrollBarsParameters; override;
    procedure InternalUpdate; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure OnChangeHeaderStyle(Sender: TObject); virtual;
    procedure OnMouseTimerHandle(Sender: TObject); virtual;
    procedure Paint; override;
    procedure Resize; override;
    procedure Scroll(AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode;
      var AScrollPos: Integer); override;
    function SpreadSheetClipboardDataToData(ASheet: TcxSSBookSheet;
      const AColPos, ARowPos: Integer; out AChangedRect: TRect): Boolean; virtual;
    function SpreadSheetDataToClipboardData(ASheet: TcxSSBookSheet;
      const ACells: TRect): AnsiString; virtual;
    procedure SetModified;
    procedure VisibleChanging; override;
    function ViewInfoValid: Boolean;
    property ActiveCell: TPoint read GetActiveCell write SetActiveCell;
    property ActivePage: Integer read FActivePage write SetActivePage;
    property ActiveSheet: TcxSSBookSheet read GetActiveSheet;
    property AutoRecalc: Boolean read GetAutoRecalc write SetAutoRecalc default True;
    property CaptureControl: TcxWorkBookSubControl read FCaptureControl;
    property ColHeaderHeight: Integer read FColHeaderHeight write SetColHeaderHeight default 20;
    property CaptionBar: TcxSSBookPageCaptions read FCaptionBar;
    property Canvas: TcxCanvasWrapper read FCanvas;
    property DefaultColWidth: TcxSSSize read FDefaultColWidth write SetDefaultColWidth default 85;
    property DefaultRowHeight: TcxSSSize read FDefaultRowHeight write SetDefaultRowHeight default 20;
    property DefaultStyle: TcxSSDefaultStyle read GetDefaultStyle write SetDefaultStyleProperty;
    property DefinedNames: TcxSSNamesDef read GetDefinedNames;
    property FormulasCache: TcxSSFormulasCache read FFormulasCache;
    property GridColor: TColor read FGridColor write SetGridColor default clBtnFace;
    property HeaderColor: TColor read FHeaderColor write SetHeaderColor default clBtnFace;
    property HeaderFont: TFont read FHeaderFont write SetHeaderFont;
    property History: TcxSpreadSheetHistory read FHistory;
    property IsLoaded: Boolean read FIsLoaded;
    property Listener: TcxSSListener read FListener;
    property PageCount: Word read GetPageCount write SetPageCount default 1;
    property PageSelection[APage: Word]: TRect read GetPageSelection write SetPageSelection;
    property Pages[APage: Integer]: TcxSSBookSheet read GetPage; default;
    property PageVisible[APage: Word]: Boolean read GetPageVisible write SetPageVisible;
    property PaintBitmap: TBitmap read FPaintBitmap;
    property Painter: TcxSheetPainter read FPainter;
    property PainterType: TcxSSPainterType read FPainterType write SetPainterType default ptOffice97Style;
    property Palette: PcxExcelPalette read GetPalettePtr;
    property Precision: Byte read FFloatPrecision write SetFloatPrecision default 2;
    property RowHeaderWidth: Integer read FRowHeaderWidth write SetRowHeaderWidth default 85;
    property SelectionColor: TColor read FSelectionColor write SetSelectionColor default clHighLight;
    property StyleCache: TcxSSStyleCache read FStyleCache;
    property ShowCaptionBar: Boolean read FShowCaptionBar write SetShowCaptionBar default True;
    property ShowFormulas: Boolean read FShowFormulas write SetShowFormulas default False;
    property ShowGrid: Boolean read FShowGrid write SetShowGrid default True;
    property ShowHeaders: Boolean read GetShowHeaders write SetShowHeaders default True;
    property SelectionRect: TRect read GetSelection write SetSelection;
    property OnActiveCellChanging: TcxSSActiveCellChangingEvent read FOnActiveCellChanging
      write FOnActiveCellChanging;
    property OnActiveSheetChanging: TcxSSActiveSheetChangingEvent read FOnActiveSheetChanging
      write FOnActiveSheetChanging;
    property OnAfterCalculation: TNotifyEvent read FOnAfterCalculation write FOnAfterCalculation;
    property OnChangeColVisible: TcxSSChangeVisible read FOnChangeColVisible
      write FOnChangeColVisible;
    property OnChangeSheetCaption: TcxSSChangeCaptionEvent read FonChangeCaption write FonChangeCaption;
    property OnChangeRowVisible: TcxSSChangeVisible read FOnChangeRowVisible
      write FOnChangeRowVisible;
    property OnCellChange: TcxSSCellChangeEvent read FOnCellChange write FOnCellChange;
    property OnClearCells: TcxSSClearCellsEvent read FOnClearCells write FOnClearCells;
    property OnCustomPaint: TcxSSCustomPaintEvent read FOnCustomPaint write SetCustomPainter;
    property OnEditing: TcxSSEditingEvent read FOnEditing write FOnEditing;
    property OnEndEdit: TNotifyEvent read FOnEndEdit write FOnEndEdit;
    property OnFormatCells: TcxSSFormatCellsEvent read FOnFormatCells  write FOnFormatCells;
    property OnHistoryChanged: TNotifyEvent read FOnHistoryChanged write FOnHistoryChanged;
    property OnMergeCells: TcxSSMergeCellsEvent read FOnMergeCells write FOnMergeCells;
    property OnProgress: TcxProgressEvent read FOnProgress write FOnProgress;
    property OnResizeCol: TcxSSResizeEvent read FOnResizeCol write FOnResizeCol;
    property OnResizeRow: TcxSSResizeEvent read FOnResizeRow write FOnResizeRow;
    property OnSetSelection: TcxSSSetSelectionEvent read FOnSetSelection write FOnSetSelection;
    property OnSheetPopupMenu: TcxSSPopupMenuEvent read FOnSheetPopupMenu write FOnSheetPopupMenu;
    property OnCaptionPopupMenu: TcxSSPopupMenuEvent read FOnCaptionPopupMenu write FOnCaptionPopupMenu;
    property OnTopLeftChanging: TcxSSTopLeftChangingEvent read FOnTopLeftChanging write FOnTopLeftChanging;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function BeginUpdate: Integer;
    function CellsNameByRef(ASheet: Integer; const CellsRef: TRect; IsText: Boolean = True): string;
    procedure ClearAll;
    procedure DeactivateEditor;
    function DeleteName(const AName: string): Boolean; virtual;
    function DefineName(const AName: string; APage: Word; const ARect: TRect): Integer; virtual;
    function DefineNameEx(const AName: string; APage: Word; const ARect: TRect; Validate: Boolean = True): Integer; virtual;
    function EndUpdate: Integer;
    function HasRectName(ASheet: Integer; const ARect: TRect): Integer;
    function HitTest(const APoint: TPoint;
      out HitTestInfo: TcxSSHitTestInfo): Boolean;  virtual;
    procedure LoadFromFile(const AFileName: string); virtual;
    procedure LoadFromStream(Stream: TStream); virtual;
    procedure Recalc; virtual;
    procedure SaveToFile(const AFileName: string); virtual;
    procedure SaveToStream(AStream: TStream); virtual;
    procedure UpdateControl; virtual;
    property DocumentModified: Boolean read FModified;
  published
    property BufferedPaint: Boolean read FBufferedPaint write SetBufferedPaint default False;
    property ExcelProtectionStyle: Boolean read FExcelProtectionStyle write FExcelProtectionStyle default True;
    property HideSelection: Boolean read FHideSelection write FHideSelection default False;
    property R1C1ReferenceStyle: Boolean read GetRCRefStyle write SetRCRefStyle default False;
    property RowsAutoHeight: Boolean read FRowsAutoHeight write FRowsAutoHeight default True;
    property ScrollBars: TcxScrollBars read FScrollBars write SetScrollBars default sbsBoth;
    property BackgroundColor: TColor read FWindowColor write SetDefaultColor default clWindow;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly default False;
    property Protected: Boolean read FProtected write FProtected default False;
    property Visible;
  end;

  { TcxSSFormatDialog }
  TcxSSFormatDialog = class(TForm)
  public
  {$IFDEF DELPHI9}
    constructor Create(AOwner: TComponent); override;
  {$ENDIF}
    function Execute(const ACells: TRect; ASheet: TcxSSBookSheet): Boolean; virtual;
  published
    property Position default poDesigned;
  end;

  { TcxSpreadSheetBook }
  TcxSpreadSheetBook = class(TcxCustomSpreadSheetBook)
  private
    FOnDeleteSheet: TcxSSDeleteSheetEvent;
    FOnExchangeSheets: TcxSSExchangeSheetsEvent;
  public
    constructor Create(AOwner: TComponent); override;
    procedure AddSheetPage(const APageName: string = ''); override;
    procedure EditActiveSheetCaption;
    procedure ExchangeSheets(const ASheet1, ASheet2: Integer); virtual;
    procedure DeleteSheet(const ASheet: Integer); virtual;
    property ActiveCell;
    property ActivePage;
    property ActiveSheet;
    property DefinedNames;
    property History;
    property Palette;
    property Pages;
    property PageVisible;
    property SelectionRect;
  published
    property Align;
    property Anchors;
    property AutoRecalc;
    property ColHeaderHeight;
    property DefaultStyle;
    property DefaultColWidth;
    property DefaultRowHeight;
    property GridColor;
    property HeaderFont;
    property HeaderColor;
    property PainterType;
    property Precision;
    property PageCount;
    property PopupMenu;
    property RowHeaderWidth;
    property SelectionColor;
    property ShowCaptionBar;
    property ShowFormulas;
    property ShowGrid;
    property ShowHeaders;
    property OnDeleteSheet: TcxSSDeleteSheetEvent read FOnDeleteSheet write FOnDeleteSheet;
    property OnExchangeSheets: TcxSSExchangeSheetsEvent read FOnExchangeSheets write FOnExchangeSheets;
    property OnActiveCellChanging;
    property OnActiveSheetChanging;
    property OnAfterCalculation;
    property OnCellChange;
    property OnChangeColVisible;
    property OnChangeSheetCaption;
    property OnChangeRowVisible;
    property OnClearCells;
    property OnCustomPaint;
    property OnEditing;
    property OnEndEdit;
    property OnFormatCells;
    property OnHistoryChanged;
    property OnMergeCells;
    property OnProgress;
    property OnResizeCol;
    property OnResizeRow;
    property OnSetSelection;
    property OnSheetPopupMenu;
    property OnCaptionPopupMenu;
    property OnTopLeftChanging;
    property OnEnter;
    property OnExit;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

  { TcxSpreadSheet }
  TcxSpreadSheet = class(TcxCustomSpreadSheetBook)
  private
    function GetSheet: TcxSSBookSheet;
  public
    constructor Create(AOwner: TComponent); override;
    property Sheet: TcxSSBookSheet read GetSheet;
    property ActiveCell;
    property History;
    property DefinedNames;
    property Palette;
    property SelectionRect;
  published
    property Align;
    property Anchors;
    property AutoRecalc;
    property ColHeaderHeight;
    property DefaultStyle;
    property DefaultColWidth;
    property DefaultRowHeight;
    property GridColor;
    property HeaderFont;
    property HeaderColor;
    property PainterType;
    property Precision;
    property RowHeaderWidth;
    property SelectionColor;
    property ShowFormulas;
    property ShowGrid;
    property ShowHeaders;
    property OnActiveCellChanging;
    property OnAfterCalculation;
    property OnCellChange;
    property OnChangeColVisible;
    property OnChangeRowVisible;
    property OnClearCells;
    property OnCustomPaint;
    property OnEditing;
    property OnEndEdit;
    property OnFormatCells;
    property OnHistoryChanged;
    property OnMergeCells;
    property OnProgress;
    property OnResizeCol;
    property OnResizeRow;
    property OnSetSelection;
    property OnSheetPopupMenu;
    property OnTopLeftChanging;
    property OnEnter;
    property OnExit;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

  { TcxSSClipboard }
  TcxSSClipboard = class
  private
    function GetESSData: AnsiString;
    function GetUnicodeData: WideString;
    procedure SetUnicodeData(const Value: WideString);
    procedure SetESSData(const Value: AnsiString);
  protected
    function BufferSize(AFormat: Word): Integer;
    procedure GetBuffer(AFormat: Word; var ABuffer);
    procedure SetBuffer(AFormat: Word; const ABuffer; ASize: Integer; ClearClipboard: Boolean);
  public
    property DataAsUnicode: WideString read GetUnicodeData write SetUnicodeData;
    property DataAsEssFormat: AnsiString read GetESSData write SetEssData;
  end;

  function CanModify(ABook, ASheet: TObject; ACol, ARow: Integer): Boolean; overload;
  function CanModify(ABook, ASheet: TObject; const ARect: TRect): Boolean; overload;
  function CellReadOnly(ABook, ASheet: TObject; ACol, ARow: Integer): Boolean;

implementation

uses
  cxSSDesigner, cxLibraryConsts;

{$R *.res}

type
  TcxHeaderAccess = class(TcxSSHeader);
  TcxHistoryAccess = class(TcxSpreadSheetHistory);
  TcxDataStorageAccess = class(TcxSSDataStorage);
  TcxFormulasAccess = class(TcxSSFormulasCache);
  TcxStyleAccess = class(TcxSSCellStyle);
  TCustomControlAccess = class(TCustomControl);
  TWinControlAccess = class(TWinControl);

var
  cxSSClipboard: TcxSSClipboard;
  CF_ESSDATA: Integer;

const
  SCF_ESSCLIPBOARDFORMAT = 'ExpressSpreadSheet 1.0';
  CellTerminator =   #9;
  RowTerminator = #13#10;

  cxHScrollHeight: Integer = 16;
  cxVScrollWidth: Integer = 16;
  ScrollersVisible: array[TcxScrollBars, TScrollBarKind] of Boolean =
    ((False, False), (True, False), (False, True), (True, True));

function OrdinalToFormatStr(const AString: string; AFormat: TxlsDataFormat; ADig: Byte): string;
var
  AFValue: Double;
  ABValue: Boolean;
  AColor: Word;
begin
  Result := AString;
  if AFormat <> $31 then
  begin
    if cxTryStrToFloat(AString, AFValue) then
      Result := TcxSSUtils.FormatText(AFValue, AFormat, ADig, AColor)
    else
      if cxTryStrToBool(AString, ABValue) then
        Result := TcxSSUtils.FormatText(Byte(ABValue), AFormat, ADig, AColor)
  end;
end;

function CellReadOnly(ABook, ASheet: TObject; ACol, ARow: Integer): Boolean;
var
  Wb: TcxCustomSpreadSheetBook;
  Sh: TcxSSBookSheet;
  AHasCell: Boolean;
  AState: TcxSSCellStates;
begin
  Wb := TcxCustomSpreadSheetBook(ABook);
  Sh := TcxSSBookSheet(ASheet);
  Result := not Wb.IsDataLoading;
  if not Result then Exit;
  AState := Sh.DataStorage.Cells[ACol, ARow].StylePtr^.CellState;
  AHasCell := Sh.DataStorage.HasCell(ACol, ARow);
  if Wb.ExcelProtectionStyle then
  begin
    Result := Wb.Protected or Sh.Protected;
    if Result then
    begin
      if AHasCell then
        Result := cLocked in AState
      else
        Result := Sh.Cols.LockProtect[ACol];
    end;
  end
  else
    Result := Wb.ReadOnly or Sh.ReadOnly or (cReadOnly in AState);
end;

function CanModify(ABook, ASheet: TObject; ACol, ARow: Integer): Boolean;
begin
  Result := not CellReadOnly(ABook, ASheet, ACol, ARow);
end;

function CanModify(ABook, ASheet: TObject; const ARect: TRect): Boolean;
var
  I, J: Integer;
begin
  Result := True;
  for I := ARect.Left to ARect.Right do
    for J := ARect.Top to ARect.Bottom do
    begin
      Result := Result and CanModify(ABook, ASheet, I, J);
      if not Result then Exit;
    end;
end;

{ TcxSSFormatDialog }

{$IFDEF DELPHI9}
constructor TcxSSFormatDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Position := poDesigned;
end;
{$ENDIF}

function TcxSSFormatDialog.Execute(const ACells: TRect; ASheet: TcxSSBookSheet): Boolean;
begin
  Result := False;
end;

{ TcxSSListener }
constructor TcxSSListener.Create(AOwner: TcxCustomSpreadSheetBook);
begin
  FOwner := AOwner;
  FLockCount := 0;
end;

function TcxSSListener.BeginUpdate: Integer;
begin
  Inc(FLockCount);
  Result := FLockCount;
end;

function TcxSSListener.EndUpdate: Integer;
begin
  if FLockCount > 0 then
    Dec(FLockCount);
  Result := FLockCount;
end;

function TcxSSListener.IsLocked: Boolean;
begin
  Result := FLockCount > 0;
end;

procedure TcxSSListener.OnActiveCellChanging(Sender: TcxSSBookSheet;
  const ActiveCell: TPoint; var CanSelect: Boolean);
begin
  if IsLocked then Exit;
  if Assigned(Owner.OnActiveCellChanging) then
    Owner.OnActiveCellChanging(Sender, ActiveCell, CanSelect)
end;

procedure TcxSSListener.OnActiveSheetChanging(Sender: TcxCustomSpreadSheetBook;
  const ActiveSheet: Integer; var CanSelect: Boolean);
begin
  if IsLocked then Exit;
  if Assigned(Owner.OnActiveSheetChanging) then
    Owner.OnActiveSheetChanging(Sender, ActiveSheet, CanSelect);
end;

procedure TcxSSListener.OnChangeCellData(Sender: TcxSSBookSheet;
  const ACol, ARow: Integer);
begin
  if IsLocked then Exit;
  if Sender.ViewInfoValid then
    Sender.ViewInfo.UpdateCellInfo(ACol, ARow);
  if Assigned(Owner.OnCellChange) then
    Owner.OnCellChange(Sender, ACol, ARow);
end;

procedure TcxSSListener.OnChangeDefaultStyle(const AOldValue,
  ANewValue: TcxSSCellStyleRec);
begin
  if IsLocked then Exit;
  if Owner.ViewInfoValid then
    Owner.ActiveSheet.ViewInfo.UpdateViewInfo;
end;

procedure TcxSSListener.OnChangeLockColRow(Sender: TcxSSBookSheet;
  AKind: TcxSSHeadertype; AIndex: Integer; AOldValue, ANewValue: Boolean);
begin
  if IsLocked then Exit;
end;

procedure TcxSSListener.OnChangeSelection(Sender: TcxSSBookSheet;
  const AOldValue, ANewValue: TRect);
begin
  if IsLocked then Exit;
  if Sender.ViewInfoValid then
    Sender.ViewInfo.UpdateOnChangeSelection;
  if Assigned(Owner.OnSetSelection) then
    Owner.OnSetSelection(Owner, Sender);
end;

procedure TcxSSListener.OnChangeSheetCaption(Sender: TcxSSBookSheet;
  var ACaption: string);
begin
  Owner.SetModified;
  if IsLocked then Exit;
  if Assigned(Owner.OnChangeSheetCaption) then
    Owner.OnChangeSheetCaption(Sender, ACaption);
end;

procedure TcxSSListener.OnChangeSizeColRow(Sender: TcxSSBookSheet;
  AKind: TcxSSHeaderType; AIndex: Integer; var ANewSize: TcxSSSize);
begin
  with Owner do
  begin
    if (AKind = htCol) and Assigned(OnResizeCol) then
      OnResizeCol(Sender, AIndex, ANewSize)
    else
      if (AKind = htRow) and Assigned(OnResizeRow) then
         OnResizeRow(Sender, AIndex, ANewSize);
  end;
end;

procedure TcxSSListener.OnChangeVisibleColRow(Sender: TcxSSBookSheet;
  AKind: TcxSSHeaderType; AIndex: Integer;  AOldValue, ANewValue: Boolean);
var
  I: Integer;
begin
  with Sender, SelectionRect do
  begin
    if (AKind = htRow) and ((AIndex >= Top) or (AIndex <= Bottom)) and not ANewValue then
    begin
      I := AIndex + 1;
      while not Sender.Rows.Visible[I] do Inc(I);
      SelectionRect := Rect(Left, I, Right, I);
    end;
  end;
  if AKind = htCol then
  begin
    if Assigned(Owner.OnChangeColVisible) then
      Owner.OnChangeColVisible(Owner, Sender, AIndex, AOldValue, ANewValue)
  end
  else
  begin
    if Assigned(Owner.OnChangeRowVisible) then
      Owner.OnChangeRowVisible(Owner, Sender, AIndex, AOldValue, ANewValue);
  end;
  if IsLocked then Exit;
  if Sender.ViewInfoValid then
    Sender.ViewInfo.UpdateViewInfo;
end;

procedure TcxSSListener.OnClearCells(Sender: TcxSSBookSheet; const ACellRec: TRect;
  var AUseDefaultStyle, CanClear: Boolean);
begin
  if Assigned(Owner.OnClearCells) then
    Owner.OnClearCells(Sender, ACellRec, AUseDefaultStyle, CanClear);
end;

procedure TcxSSListener.OnEditing(Sender: TcxSSBookSheet;
  const ACol, ARow: Integer; var CanEdit: Boolean);
begin
  if IsLocked then Exit;
  if Assigned(FOwner.OnEditing) then
    FOwner.OnEditing(Sender, ACol, ARow, CanEdit);
end;

procedure TcxSSListener.OnDeleteCells(Sender: TcxSSBookSheet; ACellRect: TRect;
  AModifyType: TcxSSModifyType);
begin
  if IsLocked then Exit;
end;

procedure TcxSSListener.OnHistoryChanged(Sender: TObject);
begin
  if IsLocked then Exit;
  if Assigned(Owner.OnHistoryChanged) then
    Owner.OnHistoryChanged(Owner);
end;

procedure TcxSSListener.OnInsertCells(Sender: TcxSSBookSheet;
  ACellRect: TRect; AModifyType: TcxSSModifyType);
begin
  if IsLocked then Exit;
end;

procedure TcxSSListener.OnMergeCells(Sender: TcxSSBookSheet;
  ACellRect: TRect; AIsMerge: Boolean; var CanMerge: Boolean);
begin
  if IsLocked then Exit;
  if Assigned(Owner.OnMergeCells) then
    Owner.OnMergeCells(Sender, ACellRect, AIsMerge, CanMerge);
end;

procedure TcxSSListener.OnSheetPopupMenu(Sender: TcxSSBookSheet;
  const AHitPoint: TPoint);
begin
  try
    if Assigned(Owner.OnContextPopup) then
      Owner.OnContextPopup(Owner, AHitPoint, Owner.FContextPopupHandled);
    if Owner.FContextPopupHandled or Assigned(Owner.PopupMenu) then Exit;
    if Assigned(Owner.OnSheetPopupMenu) then
      Owner.OnSheetPopupMenu(Sender, AHitPoint.X, AHitPoint.Y);
  finally
    Owner.FContextPopupHandled := False;
  end;
end;

procedure TcxSSListener.OnCaptionPopupMenu(Sender: TcxSSBookSheet;
  const AHitPoint: TPoint);
begin
  try
    if Assigned(Owner.OnContextPopup) then
      Owner.OnContextPopup(Owner, AHitPoint, Owner.FContextPopupHandled);
    if  Owner.FContextPopupHandled or Assigned(Owner.PopupMenu) then Exit;
    if Assigned(Owner.OnCaptionPopupMenu) then
      Owner.OnCaptionPopupMenu(Sender, AHitPoint.X, AHitPoint.Y);
  finally
    Owner.FContextPopupHandled := False;
  end;
end;

procedure TcxSSListener.OnTopLeftChanging(Sender: TcxSSBookSheet;
  var ATopLeft: TPoint);
begin
  if Assigned(Owner.OnTopLeftChanging) then
    Owner.OnTopLeftChanging(Sender, ATopLeft);
end;

procedure TcxSSListener.OnProgress(Sender: TObject; APercent: Byte);
begin
  if Assigned(Owner.OnProgress) then
    Owner.OnProgress(Owner, APercent);
end;

procedure TcxSSListener.OnResizeDataLength(Sender: TcxSSBookSheet;
  AType: TcxSSHeaderType);
begin
  if IsLocked then Exit;
end;

procedure TcxSSListener.UpdateAfterChanged(Sender: TcxSSBookSheet; ACellRect: TRect);
begin
  if IsLocked then Exit;
  Owner.DoRecalc;
  if Sender.ViewInfoValid then
    Sender.ViewInfo.UpdateCellsInfo(ACellRect);
end;

{ TcxWorkBookSubControl }
constructor TcxWorkBookSubControl.Create(AOwner: TcxCustomSpreadSheetBook);
begin
  FOwner := AOwner;
  FVisible := True;
end;

procedure TcxWorkBookSubControl.Invalidate;
begin
  Owner.InvalidateRect(BoundsRect, False);
end;

procedure TcxWorkBookSubControl.InvalidateRect(ARect: TRect);
begin
  if not Visible or Owner.Listener.IsLocked or not Owner.HandleAllocated then Exit;
  OffsetRect(ARect, Left, Top);
  if IntersectRect(ARect, BoundsRect, ARect) then;
  Owner.InvalidateRect(ARect, False);
end;

function TcxWorkBookSubControl.ClientToScreen(const X, Y: Integer): TPoint;
begin
  Result := Point(X + FBounds.Left, Y + FBounds.Top);
  Result := Owner.ClientToScreen(Result)
end;

procedure TcxWorkBookSubControl.DblClick;
begin
end;

procedure TcxWorkBookSubControl.FocusChanged;
begin
end;

procedure TcxWorkBookSubControl.KeyDown(var Key: Word; Shift: TShiftState);
begin
end;

procedure TcxWorkBookSubControl.KeyPress(var Key: Char);
begin
end;

procedure TcxWorkBookSubControl.KeyUp(var Key: Word; Shift: TShiftState);
begin
end;

procedure TcxWorkBookSubControl.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
end;

procedure TcxWorkBookSubControl.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
end;

procedure TcxWorkBookSubControl.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
end;

procedure TcxWorkBookSubControl.Paint;
begin
  if Visible then
    Canvas.ExcludeClipRect(BoundsRect);
end;

procedure TcxWorkBookSubControl.Resize;
begin
  Invalidate;
end;

procedure TcxWorkBookSubControl.SetBounds(const ALeft, ATop, AWidth, AHeight: Integer);
begin
  if EqualRect(FBounds, Rect(ALeft, ATop, AWidth, AHeight)) then Exit;
  FBounds := Rect(ALeft, ATop, AWidth, AHeight);
  Resize;
end;

procedure TcxWorkBookSubControl.VisibleChanging;
begin
end;

function TcxWorkBookSubControl.GetBoundsRect: TRect;
begin
  Result := Rect(FBounds.Left, FBounds.Top,
    FBounds.Left + FBounds.Right, FBounds.Top + FBounds.Bottom);
end;

function TcxWorkBookSubControl.GetCanvas: TcxCanvasWrapper;
begin
  Result := Owner.Canvas;
end;

function TcxWorkBookSubControl.GetClientRect: TRect;
begin
  Result := Rect(0, 0, FBounds.Right, FBounds.Bottom);
end;

function TcxWorkBookSubControl.GetControlCanvas: TCanvas;
begin
  Result := TCustomControlAccess(Owner).Canvas;
end;

function TcxWorkBookSubControl.GetCursor: TCursor;
begin
  Result := Owner.Cursor;
end;

function TcxWorkBookSubControl.GetHeight: Integer;
begin
  Result := FBounds.Bottom;
end;

function TcxWorkBookSubControl.GetLeft: Integer;
begin
  Result := FBounds.Left;
end;

function TcxWorkBookSubControl.GetTop: Integer;
begin
  Result := FBounds.Top;
end;

function TcxWorkBookSubControl.GetWidth: Integer;
begin
  Result := FBounds.Right;
end;

procedure TcxWorkBookSubControl.SetBoundsRect(ARect: TRect);
begin
  ARect.Bottom := ARect.Bottom - ARect.Top;
  ARect.Right := ARect.Right  - ARect.Left;
  if not EqualRect(ARect, FBounds) then
  begin
    FBounds := ARect;
    Resize;
  end;
end;

procedure TcxWorkBookSubControl.SetCursor(const Value: TCursor);
begin
  Owner.Cursor := Value;
end;

procedure TcxWorkBookSubControl.SetHeight(const Value: Integer);
begin
  if FBounds.Bottom = Value then Exit;
  FBounds.Bottom := Value;
  Resize;
end;

procedure TcxWorkBookSubControl.SetLeft(const Value: Integer);
begin
  FBounds.Left := Value;
  Invalidate;
end;

procedure TcxWorkBookSubControl.SetTop(const Value: Integer);
begin
  FBounds.Top := Value;
  Invalidate;
end;

procedure TcxWorkBookSubControl.SetVisible(const Value: Boolean);
begin
  if Value <> FVisible then
  begin
    if Value then
      Invalidate;
    FVisible := Value;
    VisibleChanging;
  end;
end;

procedure TcxWorkBookSubControl.SetWidth(const Value: Integer);
begin
  FBounds.Right := Value;
  Resize;
end;

{ TcxSSBookPageCaptions }
constructor TcxSSBookPageCaptions.Create(AOwner: TcxCustomSpreadSheetBook);
begin
  inherited Create(AOwner);
  FCaptionPainter := Owner.GetCaptionPainterClass.Create;
  FViewInfo.FirstVisibleCaption := 0;
end;

destructor TcxSSBookPageCaptions.Destroy;
begin
  FCaptionPainter.Free;
  inherited Destroy;
end;

procedure TcxSSBookPageCaptions.MakeTabVisible(AIndex: Integer);

   function IsVisible: Integer;
   var
     W: Integer;
     R: TRect;
   begin
     if (AIndex < 0) or (AIndex >= Length(FViewInfo.Bricks)) then
     begin
       Result := 0;
       Exit;
     end;
     R := FViewInfo.Bricks[AIndex].BoundsRect;
     Result := FirstVisibleCaption - AIndex;
     if Result > 0 then
       Result := -1
     else
       if Result < 0 then
         Result := 1;
     if Result > 0 then
     begin
       if Owner.HScrollBar.Visible then
         W := Owner.Width shr 1
       else
         W := Owner.Width;
       if R.Right < W then
         Result := 0;
     end;
   end;

begin
  while IsVisible <> 0 do
    FirstVisibleCaption := FirstVisibleCaption + IsVisible;
end;

procedure TcxSSBookPageCaptions.ActivateEditor;
var
  ARect: TRect;
begin
  if FCaptionEditor = nil then
  begin
     FCaptionEditor :=
       Owner.GetInplaceEditClass.Create(Owner, False) as TcxSSInplaceTextEdit;
     FCaptionEditor.Parent := Owner;
     FCaptionEditor.WantTab := True;
     FCaptionEditor.OnEndEdit := OnEndEditCaption;
     FCaptionEditor.OnChange := OnEditCaptionText;
  end;
  FCaptionEditor.Font.Assign(Owner.HeaderFont);
  ARect := FViewInfo.Bricks[Owner.ActivePage].BoundsRect;
  OffsetRect(ARect, 13, 0);
  FCaptionEditor.SetBounds(ARect.Left + 2, ARect.Top + 2,
     ARect.Right - ARect.Left - 2, ARect.Bottom - ARect.Top - 2);
  with Owner.ActiveSheet do
    FCaptionEditor.InitEditor(Caption, Caption);
end;

procedure TcxSSBookPageCaptions.DblClick;
var
  AIndex: Integer;
begin
  if HitTest(FMouseDownPos.X, FMouseDownPos.Y, AIndex) <> htCaption then Exit;
  if Owner.ActivePage < 0 then Exit;
  with Owner.ActiveSheet.SelectionRect do
  if CanModify(Owner, Owner.ActiveSheet, Left, Top) then
  begin
    ActivateEditor;
    FIsEditorActivate := True;
  end;
end;

procedure TcxSSBookPageCaptions.DoEditCaption;

  function SheetRectIsVisible(const ARect: TRect): Boolean;
  var
    W: Integer;
  begin
    if Owner.HScrollBar.Visible then
      W := Owner.Width shr 1
    else
      W := Owner.Width;
    Result := ARect.Right < W;
  end;

begin
  if Owner.ActivePage < FirstVisibleCaption then
    FirstVisibleCaption := Owner.ActivePage;
  while (FirstVisibleCaption < Owner.ActivePage) and
    not SheetRectIsVisible(FViewInfo.Bricks[Owner.ActivePage].BoundsRect) do
  begin
    FirstVisibleCaption := FirstVisibleCaption + 1;
  end;
  ActivateEditor;
  FCaptionEditor.SetFocus;
end;

function TcxSSBookPageCaptions.GetCaptionTextExtent(APage: Integer): TRect;
var
  I: Byte;
begin
  Canvas.SelectFont(Owner.HeaderFont);
  with FViewInfo do
  begin
    Result := Rect(0, Bounds.Top, 0, Bounds.Bottom - 1);
    for I := FirstVisibleCaption to APage do
      if csHidden in Bricks[I].State then
        Continue
      else
      begin
        Result.Left := Result.Right;
        if Owner.HandleAllocated then
          Result.Right := Result.Left +
            Canvas.TextWidth(Bricks[I].DisplayText) + 30;
        if Result.Left > 0 then OffsetRect(Result, -10, 0);
      end;
  end;
end;

function TcxSSBookPageCaptions.HitTest(X, Y: Integer;
  var AIndex: Integer): TcxSSCaptionHitTest;

  function CheckHitInCaption(ACaptionRect: TRect; AX, AY: Integer): Boolean;
  var
    DX: Integer;
  begin
    OffsetRect(ACaptionRect, -Left, -Top);
    AX := AX - Left;
    AY := AY - Top;
    DX := Round(AY * 10 / Height);
    Result := (AY > ACaptionRect.Top) and (AY < ACaptionRect.Bottom) and
              ((AX >= (ACaptionRect.Left + DX)) and (AX <= (ACaptionRect.Right - DX)))
  end;

var
  I: Integer;
  AHitPoint: TPoint;
begin
  Result := htNone;
  AIndex := 0;
  AHitPoint := Point(X + Left, Y + Top);
  with FViewInfo do
  begin
    for I := 0 to 3 do
     if PtInRect(BtnBricks[TcxSSNavigatorBtn(I)], AHitPoint) then
     begin
       AIndex := I;
       Result := htButton;
       Exit;
     end;
    AIndex := -1;
    for I := FViewInfo.FirstVisibleCaption to Length(Bricks) - 1 do
     if not (csHidden in Bricks[I].State) then
     begin
       if CheckHitInCaption(Bricks[I].BoundsRect, AHitPoint.X, AHitPoint.Y) then
       begin
         if (AIndex < 0) or (csCurrent in Bricks[I].State) then
           AIndex := I;
       end;
     end;
     if AIndex >=0 then
       Result := htCaption;
  end;
end;

procedure TcxSSBookPageCaptions.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  AHitRes: Integer;
  AHitType: TcxSSCaptionHitTest;
  AIsDown: Boolean;

begin
  Cursor := crDefault;
  AHitType := HitTest(X, Y, AHitRes);
  with FViewInfo do
  begin
    if BtnDown <> -1 then
    begin
      AIsDown := (AHitType = htButton) and (AHitRes = BtnDown);
      if AIsDown <> IsButtonDown then
      begin
        IsButtonDown := AIsDown;
        if not Owner.Listener.IsLocked then
          Owner.InvalidateRect(BtnBricks[TcxSSNavigatorBtn(BtnDown)], False);
      end;
    end;
  end;
end;

procedure TcxSSBookPageCaptions.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  AHitRes: Integer;
  AHitType: TcxSSCaptionHitTest;
begin
  if FIsEditorActivate then Exit;
  if Button = mbRight then
    Owner.Listener.OnCaptionPopupMenu(Owner.ActiveSheet,
      ClientToScreen(X, Y))
  else
    with FViewInfo do
    begin
      FMouseDownPos := Point(X, Y);
      AHitType := HitTest(X, Y, AHitRes);
      with Owner do
      begin
        if AHitType = htButton then
        begin
          IsButtonDown := True;
          BtnDown := AHitRes;
          if not Listener.IsLocked then
            InvalidateRect(BtnBricks[TcxSSNavigatorBtn(AHitRes)], False);
        end
        else
          if AHitType = htCaption then
          begin
            FSkipActivePageChanging := True;
            ActivePage := AHitRes;
          end;
      end;
    end;
end;

procedure TcxSSBookPageCaptions.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  AHitRes: Integer;
  AHitType: TcxSSCaptionHitTest;
  ACaption: Integer;
begin
  inherited;
  if FIsEditorActivate then
  begin
    FIsEditorActivate := False;
    FCaptionEditor.Font.Assign(Owner.HeaderFont);
    FCaptionEditor.SetFocus;
    Exit;
  end;
  FMouseDownPos := Point(X, Y);
  AHitType := HitTest(X, Y, AHitRes);
  if AHitType = htButton then
  begin
    ACaption := FViewInfo.FirstVisibleCaption;
    if FViewInfo.BtnDown = AHitRes then
    begin
      case AHitRes of
        0:
          ACaption := 0;
        1:
          if ACaption > 0 then
            Dec(ACaption);
        2:
          if ACaption < (Owner.PageCount - 1) then
            Inc(ACaption);
        3:
          ACaption := Owner.PageCount - 1;
      end;
    end;
    if not Self.Owner.Listener.IsLocked then
      Self.Owner.InvalidateRect(FViewInfo.BtnBricks[TcxSSNavigatorBtn(FViewInfo.BtnDown)], False);
    FirstVisibleCaption := ACaption;
  end
  else
    if (AHitType = htCaption) and not FSkipActivePageChanging then
      Owner.ActivePage := AHitRes;
  FSkipActivePageChanging := False;
  FViewInfo.IsButtonDown := False;
  FViewInfo.BtnDown := -1;
end;

procedure TcxSSBookPageCaptions.OnEditCaptionText(Sender: TObject);
var
  I: Integer;
begin
  with ViewInfo do
  begin
    Bricks[Owner.ActivePage].DisplayText := (Sender as TcxSSInplaceTextEdit).Text;
    for I := Owner.ActivePage to Owner.PageCount - 1 do
    begin
      Bricks[I].BoundsRect := GetCaptionTextExtent(I);
      OffsetRect(Bricks[I].BoundsRect, BtnBricks[nbEnd].Right, 0);
    end;
  end;
  Invalidate;
end;

procedure TcxSSBookPageCaptions.OnEndEditCaption(Sender: TObject);
var
  ARect: TRect;
begin
  if FCaptionEditor.Focused then
    Owner.SetFocus;
  FCaptionEditor.Visible := False;
  try
    Owner.ActiveSheet.Caption := FCaptionEditor.Text;
  finally
    RecalcViewInfo;
    ARect.TopLeft := ViewInfo.Bricks[Owner.ActivePage].BoundsRect.TopLeft;
    ARect.BottomRight := ViewInfo.Bounds.BottomRight;
    if not Owner.Listener.IsLocked then
      Owner.InvalidateRect(ARect, False);
  end;
end;

procedure TcxSSBookPageCaptions.Paint;
begin
  FViewInfo.FillColor := Canvas.GetNativeColor(Owner.HeaderColor);
  FViewInfo.Font := Owner.HeaderFont;
  FCaptionPainter.Paint(Canvas, FViewInfo);
  inherited;
end;

procedure TcxSSBookPageCaptions.ReCalcViewInfo;
var
  I: Integer;
  ALeft: Integer;
const
  AVisibleState: array[Boolean] of TcxSSCaptionStates = ([csHidden], []);
  AActiveState: array[Boolean] of TcxSSCaptionStates = ([], [csCurrent]);
begin
  if not Owner.HandleAllocated or Owner.Listener.IsLocked then Exit;
  Canvas.BeginPaint(ControlCanvas);
  with FViewInfo do
  begin
    IsButtonDown := False;
    BtnDown := -1;
    Font := Owner.HeaderFont;
    Bounds := Rect(Left, Top, Left + Width, Top + Height);
    SetLength(Bricks, Owner.PageCount);
    Enabled := [nbStart, nbPrev, nbNext, nbEnd];
    for I := 0 to 3 do
      BtnBricks[TcxSSNavigatorBtn(I)] := Rect(Bounds.Left + I * Height, Bounds.Top,
        Bounds.Left + (I + 1) * Height, Bounds.Bottom - 1);
      with FViewInfo do
      begin
        ALeft := BtnBricks[nbEnd].Right;
        for I := FViewInfo.FirstVisibleCaption to Owner.PageCount - 1 do
        begin
          Bricks[I].DisplayText := Owner.Pages[I].Caption;
          Bricks[I].State := AVisibleState[Owner.PageVisible[I]] +
                             AActiveState[Owner.ActivePage = I];
          Bricks[I].BoundsRect := GetCaptionTextExtent(I);
          OffsetRect(Bricks[I].BoundsRect, ALeft, 0);
        end;
      end;
  end;
  Canvas.Canvas.Font.Assign(Owner.HeaderFont);
  Height := Canvas.TextHeight('I') + 5;
end;

procedure TcxSSBookPageCaptions.Resize;
begin
  inherited Resize;
  if not EqualRect(ClientRect, FViewInfo.Bounds) then RecalcViewInfo;
end;

procedure TcxSSBookPageCaptions.UpdateCaptionInfo(APage: Byte;
  AState: TcxSSCaptionStates);
begin
  if APage < Length(FViewInfo.Bricks) then
  begin
    with FViewInfo.Bricks[APage] do
    begin
      State := AState;
      InvalidateRect(ClientRect);
    end;
  end;
end;

procedure TcxSSBookPageCaptions.VisibleChanging;
begin
  if Owner.CaptionBar.Visible then
    Owner.HScrollBar.Left := Owner.CaptionBar.Width
  else
    Owner.HScrollBar.Left := 0
end;

function TcxSSBookPageCaptions.GetFirstVisibleCaption: Integer;
begin
  Result := FViewInfo.FirstVisibleCaption;
end;

procedure TcxSSBookPageCaptions.SetFirstVisibleCaption(const Value: Integer);
begin
  if FirstVisibleCaption <> Value then
  begin
    FViewInfo.FirstVisibleCaption := Value;
    RecalcViewInfo;
    InvalidateRect(ClientRect);
  end;
end;

{ TcxSSCellObject }
constructor TcxSSCellObject.Create(AOwner: TcxSSDataStorage; ACol, ARow: Integer);
begin
  FOwner := AOwner;
  FCol := ACol;
  FRow := ARow;
  FComplexAction := nil;
  with TcxHistoryAccess((FOwner.ParentBook as TcxCustomSpreadSheetBook).History) do
    AddComplexAction(TcxComplexAction, cxGetResourceString(@scxChangeCellsData), FComplexAction)
end;

destructor TcxSSCellObject.Destroy;
begin
  if FComplexAction <> nil then
    TcxHistoryAccess((FOwner.ParentBook as TcxCustomSpreadSheetBook).History).StopComplexAction;
  if Assigned(FCreatedStyle) then FCreatedStyle.Free;
  inherited;
end;

procedure TcxSSCellObject.Assign(Source: TcxSSCellObject);
begin
  if Source <> nil then
  begin
    Style.ReadOnly := False;
    Text := Source.Text;
    Style.Assign(Source.Style);
  end;
end;

procedure TcxSSCellObject.SetCellText(const AText: string;
  const NeedParse: Boolean = False);
var
  ARec: TcxSSCellRec;
begin
  if NeedParse then
    Text := AText
  else
  begin
    ARec := FOwner[FCol, FRow];
    if ARec.DataType = dtFunction then
      (FOwner.ParentBook as TcxCustomSpreadSheetBook).FormulasCache.DestroyFunction(ARec.FuncRecPtr);
    ARec.DataType := dtText;
    ARec.Text := AText;
    FOwner[FCol, FRow] := ARec;
    CheckCellWordBreak;
  end;
end;

procedure TcxSSCellObject.CheckCellWordBreak;
begin
  OwnerSheet.ApplyAutoHeight(FRow);
end;

function TcxSSCellObject.GetCellStyle: IcxSpreadSheetCellStyle;
begin
  Supports(TObject(Style), IcxSpreadSheetCellStyle, Result);
end;

function TcxSSCellObject.GetCellTextValue: string;
var
  ACell: TcxSSCellRec;
  AColor: Word;
begin
  ACell := Owner[FCol, FRow];
  if (ACell.DataType = dtFunction) then
  begin
    Result :=
      TcxCustomSpreadSheetBook(Owner.ParentBook).FormulasCache.FuncRecToDisplayText(ACell.FuncRecPtr, AColor);
  end
  else
    if ACell.DataType = dtDateTime then
      Result := FloatToStr(ACell.DateTime)
    else
      Result := ACell.Text;
end;

function TcxSSCellObject.GetCellValue: Variant;

  function TextToValue(const AText: string): Variant;
  var
    AFloat: Double;
    ABool: Boolean;
  begin
    if cxTryStrToFloat(AText, AFloat) then
      Result := AFloat
    else
      if cxTryStrToBool(AText, ABool) then
        Result := ABool
      else
        Result := AText;
  end;

var
  ACell: TcxSSCellRec;
begin
  ACell := FOwner[FCol, FRow];
  case ACell.DataType of
    dtText:
      Result := TextToValue(ACell.Text);
    dtFunction:
      Result := TcxCustomSpreadSheetBook(Owner.ParentBook).FormulasCache.GetFuncValue(ACell.FuncRecPtr);
    dtDateTime:
      Result := ACell.DateTime;
    dtControl:
      Result := Integer(ACell.Control);
  end;
end;

function TcxSSCellObject.GetDataType: TcxSSDataType;
begin
  Result := FOwner.CellDataType[FCol, FRow];
end;

function TcxSSCellObject.GetDateTime: TDateTime;
begin
  Result := FOwner.CellDateTime[FCol, FRow];
end;

function TcxSSCellObject.GetDisplayText: string;
begin
  Result := OrdinalToFormatStr(GetCellTextValue, Owner[FCol, FRow].StylePtr^.FormatIndex,
    TcxCustomSpreadSheetBook(Owner.ParentBook).Precision);
end;

function TcxSSCellObject.GetDisplayTextAlignment: TcxDisplayTextAlignment;
var
  C: Word;
  S: string;
  ACell: TcxSSCellRec;
  AHorzAlign: TcxHorzTextAlign;
begin
  ACell := Owner[FCol, FRow];
  if ACell.DataType = dtFunction then
    S := OwnerSheet.Owner.FormulasCache.FuncRecToDisplayText(ACell.FuncRecPtr, C, False)
  else
    S := ACell.Text;
  with ACell.StylePtr^ do
  begin
    AHorzAlign := HorzAlign;
    if AHorzAlign = haGeneral then
    begin
      if FormatIndex <> $31 then
      begin
        if cxTryStrToFloat(S) then
          Result := dtaRight
        else
          if cxTryStrToBool(S) then
            Result := dtaCenter
          else
            Result := dtaLeft;
      end
      else
        Result := dtaLeft;
    end
    else
      Result := TcxDisplayTextAlignment(Byte(AHorzAlign) - 1);
  end;
end;

function TcxSSCellObject.GetIsLoading: Boolean;
begin
  Result := OwnerSheet.Owner.FormulasCache.IsLoading;
end;

function TcxSSCellObject.GetMergedRect: TRect;
begin
  TcxSSDataStorage(FOwner).CheckInMergeRange(Point(FCol, FRow), Result);
end;

function TcxSSCellObject.GetOwnerSheet: TcxSSBookSheet;
begin
  Result := TcxSSBookSheet(Owner.Owner);
end;

function TcxSSCellObject.GetText: string;
begin
  Result := FOwner.CellText[FCol, FRow];
end;

function TcxSSCellObject.GetStyle: TcxSSCellStyle;
begin
  if not Assigned(FCreatedStyle) then
    FCreatedStyle := TcxSSCellStyle.Create(
      TcxCustomSpreadSheetBook(Owner.ParentBook).StyleCache, Owner, FCol, FRow);
  Result := FCreatedStyle;
end;

function TcxSSCellObject.GetStyleExist: Boolean;
begin
  Result := (FCreatedStyle <> nil) or
    (FOwner[FCol, FRow].StylePtr <> TcxCustomSpreadSheetBook(Owner.ParentBook).StyleCache.StyleList[0]);
end;

procedure TcxSSCellObject.SetStyle(const Value: TcxSSCellStyle);
begin
  if Assigned(FCreatedStyle) and (FCreatedStyle <> Value) then
    FCreatedStyle.Assign(Value)
  else
    GetStyle.Assign(Value);
end;

procedure TcxSSCellObject.SetDateTime(const Value: TDateTime);
begin
  FOwner.CellDateTime[FCol, FRow] := Value;
  if Style.Format = 0 then
  begin
    if Trunc(Value) = 0 then
      Style.Format := $15
    else
    begin
      if Frac(Value) = 0 then
        Style.Format := $0E
      else
        Style.Format := $16;
    end;
  end;
end;

procedure TcxSSCellObject.SetText(const Value: string);
begin
  if CellReadOnly(OwnerSheet.Owner, OwnerSheet, Col, Row) then Exit;
  SetTextEx(Value);
end;

procedure TcxSSCellObject.SetTextEx(const Value: string;
  IsFormula: Boolean = False; Analyze: Boolean = True);
var
  DT: TDateTime;
  C: Currency;
begin
  if CellReadOnly(OwnerSheet.Owner, OwnerSheet, Col, Row) then Exit;
  if ((Style.Format = 0) or FormatIsDateTime(TcxStyleAccess(Style).StyleInfo.FormatIndex))
   and cxTryStrToDateTime(Value, DT) and not cxTryStrToFloat(Value) then
     SetDateTime(DT)
  else
    if ((Style.Format = 0) or FormatIsCurrency(TcxStyleAccess(Style).StyleInfo.FormatIndex)) and
      cxTryStrToCurr(Value, C) and not cxTryStrToFloat(Value) then
    begin
      FOwner.CellText[FCol, FRow] := FloatToStr(C);
      if Style.Format = 0 then
        Style.Format := $8;
    end
    else
      TcxDataStorageAccess(FOwner).SetCellTextEx(FCol, FRow, Value, IsFormula, Analyze);
  CheckCellWordBreak;
  TcxCustomSpreadSheetBook(Owner.ParentBook).UpdateControl;
end;

{ TcxSSBookSheet }
constructor TcxSSBookSheet.Create(AOwner: TcxCustomSpreadSheetBook);
begin
  inherited Create(AOwner);
  FDataStorage := Owner.GetDataStorageClass.Create(Self);
  FSheetViewInfo := Owner.GetViewInfoClass.Create(Self);
  FShowFormulas := Owner.ShowFormulas;
  FShowGrid := Owner.ShowGrid;
  FShowHeaders := True;
  FSheetState := [];
  FCurrentPos := Point(0, 0);
  FVisible := False;
end;

destructor TcxSSBookSheet.Destroy;
begin
  try
    FDataStorage.Free;
    FSheetViewInfo.Free;
  finally
    inherited Destroy;
  end;
end;

procedure TcxSSBookSheet.Assign(Source: TcxSSBookSheet);
begin
  if Source <> nil then
  begin
    Owner.BeginUpdate;
    try
      FReadOnly := Source.FReadOnly;
      FShowGrid := Source.ShowGrid;
      FShowHeaders := Source.FShowHeaders;
      FShowFormulas := Source.FShowFormulas;
      DataStorage.Assign(Source.DataStorage);
      Cols.Assign(Source.Cols);
      Rows.Assign(Source.Rows);
    finally
      Owner.EndUpdate;
    end;
  end;
end;

procedure TcxSSBookSheet.ClearAll;
begin
  Owner.DeactivateEditor;
  Owner.History.StartComplexAction(cxGetResourceString(@scxClearAllAction));
  try
    DataStorage.ClearCells(Rect(-1, -1, -1, -1), True);
  finally
    if ViewInfoValid then
      ViewInfo.UpdateViewInfo;
  end;
  Owner.History.StopComplexAction;
end;

procedure TcxSSBookSheet.ClearCells(const ARect: TRect;
  SetDefaultStyle: Boolean = False);
var
  I: Integer;
  StartAction: Boolean;
begin
  if not CanModify(Owner, Self, ARect) then Exit;
  Owner.DeactivateEditor;
  StartAction := Owner.History.StartComplexAction(cxGetResourceString(@scxClearCells));
  try
    DataStorage.ClearCells(ARect, SetDefaultStyle);
    for I := ARect.Top to ARect.Bottom do ApplyAutoHeight(I);
  finally
    if StartAction then
      Owner.History.StopComplexAction;
    ViewInfo.UpdateViewInfo;
    CellsChanged(ARect);
  end;
end;

procedure TcxSSBookSheet.DeleteCells(const ACells: TRect; ACellsModify: TcxSSCellsModify);
begin
  if Owner.ExcelProtectionStyle and not CanModify(Owner, Self, ACells) then Exit;
  with Owner do
  begin
    BeginUpdate;
    try
      if ACellsModify in [msAllRow, msAllCol] then
        FormulasCache.UpdateRef(FPages.IndexOf(Self),  ACells, True, ACellsModify = msAllCol);
      DataStorage.DeleteCells(ACells, ACellsModify);
    finally
      EndUpdate;
    end;
  end;
end;

procedure TcxSSBookSheet.Copy(const ARect: TRect; IsCut: Boolean);
var
  I, J: Integer;
  AText: string;
  Action: TcxComplexAction;
begin
  for J := ARect.Top to ARect.Bottom do
  begin
    for I := ARect.Left to ARect.Right do
    begin
      AText := AText + DataStorage[I, J].Text;
      if I < ARect.Right then
        AText := AText + CellTerminator;
    end;
    if J < ARect.Bottom then
      AText := AText + RowTerminator;
  end;
  cxSSClipboard.DataAsEssFormat := Owner.SpreadSheetDataToClipboardData(Self, ARect) + #13#10;
  cxSSClipboard.DataAsUnicode := AText + #13#10;
  if IsCut and CanModify(Owner, Self, ARect) then
  begin
    TcxHistoryAccess(Owner.History).AddComplexAction(TcxComplexAction, cxGetResourceString(@scxCutCommand), Action);
    try
      DataStorage.ClearCells(ARect);
    finally
      if Action <> nil then
        TcxHistoryAccess(Owner.History).StopComplexAction;
    end;
  end;
end;

procedure TcxSSBookSheet.FormatCells(const ACells: TRect);
var
  ADesignerClass: TcxSSFormatDialogClass;
  ACanFormat: Boolean;
  AForm: TForm;
  ARect: TRect;
begin
  ADesignerClass := TcxSSStyleDesigner;
  ACanFormat := True;
  if Assigned(Owner.FOnFormatCells) then
    Owner.OnFormatCells(Owner, PRect(@ACells)^, ACanFormat, ADesignerClass);
  if ACanFormat then
  begin
    History.StartComplexAction(cxGetResourceString(@scxChangeCellsStyle));
    try
      AForm := ADesignerClass.Create(nil);
      ARect := Owner.BoundsRect;
      ARect.TopLeft := Owner.ClientToScreen(ARect.TopLeft);
      ARect.BottomRight := Owner.ClientToScreen(ARect.BottomRight);
      AForm.Top := (ARect.Top + ARect.Bottom - AForm.Height) shr 1;
      AForm.Left := (ARect.Left + ARect.Right - AForm.Width) shr 1;
      try
        (AForm as TcxSSFormatDialog).Execute(ACells, Self);
      finally
        AForm.Free;
      end;
    finally
      History.StopComplexAction;
    end;
  end;
end;

procedure TcxSSBookSheet.InsertCells(const ACells: TRect;
  ACellsModify: TcxSSCellsModify);
begin
  if Owner.ExcelProtectionStyle and not CanModify(Owner, Self, ACells) then Exit;
  with Owner do
  begin
    BeginUpdate;
    try
      if ACellsModify in [msAllRow, msAllCol] then
        FormulasCache.UpdateRef(FPages.IndexOf(Self),  ACells, False, ACellsModify = msAllCol);
      DataStorage.InsertCells(ACells, ACellsModify);
    finally
      EndUpdate;
    end;
  end;
end;

procedure TcxSSBookSheet.Invalidate;
begin
  if not Owner.CaptionBar.Visible then
    Owner.Invalidate
  else
    inherited Invalidate;
end;

procedure TcxSSBookSheet.Paste(const APlace: TPoint);
var
  S: string;
  AText: string;
  APos, I: Integer;
  ACol, ARow: Integer;
  Action: TcxComplexAction;
  ACanEdit: Boolean;
  AChangedCells: TRect;
  AreCellsChanged: Boolean;

begin
  ACol := APlace.X;
  ARow := APlace.Y;
  if not CanModify(Owner, Self, ACol, ARow) then Exit;
  ACanEdit := True;
  Owner.Listener.OnEditing(Self, ACol, ARow, ACanEdit);
  if not ACanEdit then Exit;
  APos := 1;
  TcxHistoryAccess(Owner.History).AddComplexAction(TcxComplexAction, cxGetResourceString(@scxPasteCommand), Action);
  Owner.BeginUpdate;
  AreCellsChanged := True;
  try
    try
      if not Owner.SpreadSheetClipboardDataToData(Self, APlace.X, APlace.Y, AChangedCells) then
      begin
        AChangedCells := Rect(ACol, ARow, ACol - 1, ARow - 1);
        S := cxSSClipBoard.DataAsUnicode;
        if (Length(S) > 0) and (S[Length(S)] = #0) then
          SetLength(S, Length(S) - 1);
        AText := '';
        AChangedCells.TopLeft := APlace;
        while APos < Length(S) do
        begin
          I := APos;
          while (I < Length(S)) and not dxCharInSet(S[I], [#9, #13, #10]) do Inc(I);
          if I <> APos then
            AText := System.Copy(S, APos, I - APos)
          else
          begin
            if S[I] = #9 then
            begin
              Inc(ACol);
            end
            else
              if S[I] = #13 then
              begin
                if (I < Length(S)) and (S[I + 1] = #10) then
                  Inc(I);
                Inc(ARow);
                ACol := APlace.X;
              end;
            Inc(I);
            if I > Length(S) then Dec(ARow);
            AText := '';
          end;
          if I <= Length(S) then
          begin
            if CanModify(Owner, Self, ACol, ARow) then
            with GetCellObject(ACol, ARow) do
            try
              Text := AText;
            finally
              Free;
            end;
          end;
          AChangedCells.Bottom := ARow;
          APos := I;
          AChangedCells.Right := Max(AChangedCells.Right, ACol);
        end;
      end;
    except
      on ESpreadSheetError do
      begin
        AreCellsChanged := False;
        raise;
      end
      else
        raise;
    end;
  finally
    if Assigned(Owner.FOnEndEdit) then Owner.FOnEndEdit(Self);
    if AreCellsChanged then
      CellsChanged(AChangedCells);
    Owner.EndUpdate;
    Owner.UpdateControl;
    if Action <> nil then
      TcxHistoryAccess(Owner.History).StopComplexAction;
  end;
end;

function TcxSSBookSheet.GetCellObject(ACol, ARow: Integer): TcxSSCellObject;
begin
  Result := TcxSSCellObject(DataStorage.CreateAccessCellObject(ACol, ARow));
end;

procedure TcxSSBookSheet.SelectCell(const ACol, ARow: Integer;
  OpenEditor: Boolean = False);
begin
  if (CellEditor <> nil) and CellEditor.Visible then Exit;
  DataStorage.Selection := Rect(ACol, ARow, ACol, ARow);
  if OpenEditor then
  begin
    Owner.SetFocus;
    if DoEditorActivate then
    begin
      CellEditor.SetFocus;
      CellEditor.SetCursorPosition(Point(0, 0));
    end;
  end;
  Invalidate;
end;

procedure TcxSSBookSheet.SetMergedState(const ARect: TRect; IsMerge: Boolean);
begin
  if not CanModify(Owner, Self, ARect) then Exit;
  Owner.BeginUpdate;
  try
    DataStorage.MergeUnMerge(ARect, IsMerge);
    if IsMerge then
    begin
      with GetCellObject(ARect.Left, ARect.Top) do
      try
        if Text <> '' then
          CheckCellWordBreak;
      finally
        Free;
      end;
    end;
  finally
    Owner.EndUpdate;
{    if not Listener.IsLocked then
      ViewInfo.UpdateViewInfo;}
  end;
end;

procedure TcxSSBookSheet.SetVisibleState(const ARect: TRect;
  ACols, ARows, AShow: Boolean);
var
  I: Integer;
  R: TRect;
begin
  if (Owner.FCellEditor <> nil) and Owner.FCellEditor.Focused then
    Owner.SetFocus;
  Owner.BeginUpdate;
  try
    if ACols then
      for I := ARect.Left to ARect.Right do
      begin
        DataStorage.Headers[htCol].Visible[I] := AShow;
        if AShow and (DataStorage.Headers[htCol].Size[I] = 0) then
          DataStorage.Headers[htCol].Size[I] :=
             DataStorage.Headers[htCol].DefaultSize;
      end;
    if ARows then
      for I := ARect.Top to ARect.Bottom do
      begin
        DataStorage.Headers[htRow].Visible[I] := AShow;
        if AShow and (DataStorage.Headers[htRow].Size[I] = 0) then
          DataStorage.Headers[htRow].Size[I] :=
            DataStorage.Headers[htRow].DefaultSize;
     end;
  finally
    if not AShow and EqualRect(ARect, SelectionRect) then
    begin
      R := ARect;
      if ACols then
        with TcxHeaderAccess(Cols) do
          OffsetRect(R, GetNextItem(ARect.Left, True) - ARect.Left, 0);
      if ARows then
        with TcxHeaderAccess(Rows) do
          OffsetRect(R, 0, GetNextItem(ARect.Top, True) - ARect.Top);
      SelectionRect := R;
    end;
    Owner.EndUpdate;
    Owner.UpdateControl;
  end;
end;

procedure TcxSSBookSheet.Sort(const ARect: TRect; const ASortTypes: array of TcxSortType);
var
  Action: TcxComplexAction;
begin
  TcxHistoryAccess(Owner.History).AddComplexAction(TcxComplexAction, cxGetResourceString(@scxSortCellsAction), Action);
  try
    Owner.BeginUpdate;
    try
      DataStorage.Sort(ARect, ASortTypes);
    finally
      Owner.EndUpdate;
    end;
  finally
    if Action <> nil then
      TcxHistoryAccess(Owner.History).StopComplexAction;
  end;
end;

function TcxSSBookSheet.DoEditorActivate: Boolean;
var
  ATopLeft: TPoint;
  ARect: TRect;
  I, J: Integer;
begin
  if CellReadOnly(Owner, Self, DataStorage.Col, DataStorage.Row) then Exit;
  Result := True;
  Listener.OnEditing(Self, DataStorage.Col, DataStorage.Row, Result);
  if not Result then Exit;
  if CellEditor = nil then
  begin
    Owner.FCellEditor :=
      Owner.GetInplaceEditClass.Create(Owner, True) as TcxSSInplaceTextEdit;
    CellEditor.Parent := Owner;
    CellEditor.OnEndEdit := OnEndEditCell;
  end;
  if DataStorage.Col < ViewInfo.LeftCol then
    ViewInfo.LeftCol := DataStorage.Col;
  if DataStorage.Row < ViewInfo.TopRow then
    ViewInfo.TopRow := DataStorage.Row;
  ATopLeft := TPoint(ViewInfo.TopLeft);
  FEditingPos := Point(DataStorage.Col, DataStorage.Row);
  ARect := DataStorage.CellRect(ATopLeft.X, ATopLeft.Y,
    DataStorage.Col, DataStorage.Row, True);
  with GetCellObject(DataStorage.Col, DataStorage.Row) do
  try
    Style.Font.AssignTo(CellEditor.Font);
    if Style.Brush.BackgroundColor <= 55 then
      CellEditor.Color := Self.Owner.Palette^[Style.Brush.BackgroundColor]
    else
      CellEditor.Color := Self.Owner.BackgroundColor;
  finally
    Free;
  end;
  with ViewInfo.InfoData do
    for I := 0 to Length(Bricks) - 1 do
    if Bricks[I, 0].Col >= DataStorage.Col then
    begin
      for J := 0 to Length(Bricks[0]) do
      if Bricks[0, J].Row >= DataStorage.Row then
      with Bricks[I, J] do
      begin
        if not IsMerge then
        begin
          ViewInfo.ClearBrickText(I, J);
          CellEditor.AutoWidth := True;
          CellEditor.MinimalWidth := Max(RectWidth(DisplayRect), RectWidth(TextRect)) - 5;
          CellEditor.MinimalHeight := Max(RectHeight(DisplayRect), RectHeight(TextRect)) - 5;
          ARect := Rect(TextRect.Left + 3, DisplayRect.Top, TextRect.Right, DisplayRect.Bottom + 2);
          InflateRect(ARect, 0, -2);
        end
        else
        begin
          CellEditor.AutoWidth := True;
          ARect := UnionBricks[UnionIndex].DisplayRect;
          OffsetRect(ARect, 1, 1);
          InflateRect(ARect, -3, -2);
          CellEditor.MinimalWidth := RectWidth(ARect);
          CellEditor.MinimalHeight := RectHeight(ARect);
        end;
        Dec(ARect.Bottom, 1);
        Break;
      end;
      if ARect.Right < ViewInfo.RowHeaderWidth then
        ARect.Right := ViewInfo.RowHeaderWidth;
      if ARect.Top < ViewInfo.ColHeaderHeight then
        ARect.Top := ViewInfo.ColHeaderHeight;
      Break;
    end;
  CellEditor.SetBounds(ARect.Left - 2, ARect.Top, RectWidth(ARect), RectHeight(ARect));
  CellEditor.InitEditor(DataStorage.CellText[Col, Row], DataStorage.CellText[Col, Row]);
  FSheetState := [ssEditorActivate];
  CellEditor.OnEndEdit := OnEndEditCell;
  ViewInfo.UpdateOnChangeSelection;
end;

function TcxSSBookSheet.DoMouseWheel(Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint): Boolean;
begin
  Owner.DeactivateEditor;
  Result := True;
end;

procedure TcxSSBookSheet.ApplyAutoHeight(ARow: Integer);

  function GetCellHeight(ACol: Integer): Integer;
  var
    I: Integer;
    R, R1: TRect;
    ACell: TcxSSCellRec;
    ASettings: TcxTextParameters;
    S: string;
  begin
    ACell := DataStorage.Cells[ACol, ARow];
    Result := 0;
    if ACell.DataType <> dtText then Exit;
    R := ClientRect;
    R.Right := R.Left;
    if DataStorage.CheckInMergeRange(Point(ACol, ARow), R1) then
      Exit;
    with R1 do
      for I := Left to Right do Inc(R.Right, Cols[I]);
    InflateRect(R, -2, -2);

    if (R.Right <= R.Left) or (ACell.Text = '') then Exit;
    if Owner.FormulasCache.IsLoading or ACell.StylePtr^.WordBreak then
    begin
      Canvas.SelectFont(ACell.StylePtr^.FontPtr^.FontHandle);
      Result := Canvas.TextHeight('Wg') + 2;
      if not ACell.StylePtr^.WordBreak then Exit;
      with ACell.StylePtr^ do
      begin
        S := OrdinalToFormatStr(ACell.Text, FormatIndex,
          TcxCustomSpreadSheetBook(Owner).Precision);
        Canvas.CalculateTextExtents(S, R, HorzAlign, VertAlign, WordBreak, ASettings);
      end;
      if (Length(ASettings.TextBricks) = 1) and (Rows.DefaultSize > Result) then
        Result := Rows.DefaultSize
      else
        Result := Result * Length(ASettings.TextBricks);
    end;
  end;

var
  I: Integer;
  ASize: Integer;
begin
  if Owner.IsDataLoading or not Owner.RowsAutoHeight {or not Rows.IsDefault[ARow]} then Exit;
  ASize := 0;
  for I := 0 to DataStorage.GetContentColCount do
    ASize := Max(ASize, GetCellHeight(I));
  if ASize <> 0 then
  begin
    if not Owner.FormulasCache.IsLoading then
      TcxHeaderAccess(Rows).ResetDefault(ARow);
    TcxHeaderAccess(Rows).SetScaledSize(ARow, ASize);
  end;
end;

procedure TcxSSBookSheet.CellsChanged(const ARect: TRect);
var
  I, J: Integer;
begin
  for I := ARect.Left to ARect.Right do
    for J := ARect.Top to ARect.Bottom do
      if Assigned(Owner.OnCellChange) then Owner.OnCellChange(Self, I, J);
end;

procedure TcxSSBookSheet.DblClick;
const
  InactiveStates: TcxSSHitTestStates =
    [htRowHeader, htResize, htUpperLeft, htColHeader];
var
  AHitState: TcxSSHitTestStates;
  ACol, ARow: Integer;
begin
  AHitState := ViewInfo.HitTest(FMouseDownPos.X, FMouseDownPos.Y, ACol, ARow);
  if InactiveStates * AHitState <> [] then Exit;
  DoEditorActivate;
end;

procedure TcxSSBookSheet.FocusChanged;
begin
  inherited;
  if not (ssEditorActivate in FSheetState) then FSheetState := [];
  if Owner.HideSelection then
    ViewInfo.UpdateOnCancelMode;
end;

procedure TcxSSBookSheet.InitScrollBars;

  procedure SetInfo(Kind: TScrollBarKind; MaxLine, Up, Down: Integer);
  var
    AMax: Integer;
  begin
    AMax := Max(MaxLine, Down);
    if (AMax > MaxLine) and (Up > 0) then
      Dec(AMax);
    with Owner do
      SetScrollBarInfo(Kind, 0, AMax, 1,
        Down - Up, Up, ScrollersVisible[ScrollBars, Kind], True);
  end;

begin
  SetInfo(sbVertical, DataStorage.MaxRow, Corners.Top, Corners.Bottom);
  SetInfo(sbHorizontal, DataStorage.MaxColumn, Corners.Left, Corners.Right);
  Owner.VScrollbar.ApplyData;
  Owner.HScrollbar.ApplyData;
end;

procedure TcxSSBookSheet.KeyDown(var Key: Word; Shift: TShiftState);

  procedure ChangeCursorPos(AKey: Integer; AShift: TShiftState);
  var
    APos: TRect;
    AOldPos: TPoint;
    ARect: TRect;

  begin
    with DataStorage do
    begin
      if ssSelection in FSheetState then
      begin
        APos.TopLeft := FCurrentPos;
        APos.BottomRight := FCurrentPos;
      end
      else
        APos := Selection;

      AOldPos := FCurrentPos;
      case AKey of
        VK_LEFT:
          FCurrentPos.X :=
            TcxHeaderAccess(Headers[htCol]).GetNextItem(APos.Left, False);
        VK_UP:
          FCurrentPos.Y :=
            TcxHeaderAccess(Headers[htRow]).GetNextItem(APos.Top, False);
        VK_RIGHT:
          FCurrentPos.X :=
            TcxHeaderAccess(Headers[htCol]).GetNextItem(APos.Right, True);
        VK_DOWN:
          FCurrentPos.Y :=
            TcxHeaderAccess(Headers[htRow]).GetNextItem(APos.Bottom, True);
      end;
      if (ssSelection in FSheetState) then
      begin
        ARect := Selection;
        case AKey of
          VK_LEFT:
            if AOldPos.X = ARect.Right then
            begin
              ARect.Left := AOldPos.X;
              ARect := CheckSelectionRect(ARect);
              if ARect.Left <> AOldPos.X then
                 FCurrentPos.X := ARect.Left - 1
            end;
          VK_UP:
            if AOldPos.Y = ARect.Bottom then
            begin
              ARect.Top := AOldPos.Y;
              ARect := CheckSelectionRect(ARect);
              if ARect.Top <> AOldPos.Y then
                 FCurrentPos.Y := ARect.Top - 1
            end;
          VK_RIGHT:
            begin
              if AOldPos.X = ARect.Left then
                ARect.Right := AOldPos.X
              else
                ARect.Left := AOldPos.X;
              ARect := CheckSelectionRect(ARect);
              if ARect.Right <> AOldPos.X then FCurrentPos.X := ARect.Right + 1
            end;
          VK_DOWN:
            begin
              if AOldPos.Y = ARect.Top then
                ARect.Bottom := AOldPos.Y
              else
                ARect.Top := AOldPos.Y;
              ARect := CheckSelectionRect(ARect);
              if ARect.Bottom <> AOldPos.Y then FCurrentPos.Y := ARect.Bottom + 1
            end;
        end;
      end;
    end;
  end;

  function GetCorners: TRect;
  begin
    Result.TopLeft := TPoint(ViewInfo.TopLeft);
    Result.BottomRight := TPoint(ViewInfo.BottomRight);
  end;

  procedure ValidateCorners(var ACorners: TRect; var APos: TPoint);
  begin
    if APos.X < ACorners.Left then
       ViewInfo.LeftCol := APos.X
      else
        if FCurrentPos.X > ACorners.Right then
          ViewInfo.RightCol := APos.X;
    if APos.Y < ACorners.Top then
      ViewInfo.TopRow := APos.Y
    else
      if APos.Y > ACorners.Bottom then
         ViewInfo.BottomRow := APos.Y
  end;

  function IsUnusedKey: Boolean;
  begin
    Result := (ssAlt in Shift) and (DataStorage.SelectionState = ssMultiSelect) or
      (Key = VK_APPS);
  end;

var
  ACorners: TRect;
  AScrollsPos: TPoint;

begin
  inherited KeyDown(Key, Shift);
  if IsUnusedKey then
    Exit;
  if (Key = VK_F2) and (not ((ssShift in Shift) or (ssCtrl in Shift)
    or CellReadOnly(Owner, Self, FEditingPos.X, FEditingPos.Y))) then
  begin
    if DoEditorActivate then
    begin
      CellEditor.SetFocus;
      CellEditor.SetCursorPosition(Point(0, 0));
    end;
    Exit;
  end;
  if Key = VK_TAB then
  begin
    FSheetState := [];
    if ssShift in Shift then
      Key := VK_LEFT
    else
      Key := VK_RIGHT;
    Shift := [];
  end;
  if not (ssShift in Shift) then
    FCurrentPos := DataStorage.Selection.TopLeft;
  if Key = VK_CONTROL then Exit;
  ACorners := GetCorners;
  with DataStorage do
  begin
    if SelectionState = ssCurrentSelect then FCurrentPos := Point(Col, Row);
    if (Key = VK_SHIFT) or (not (ssSelection in FSheetState) and (ssShift in Shift))  then
    begin
      FStartSelection := Selection.TopLeft;
      FCurrentPos := Selection.BottomRight;
      FSheetState := [ssSelection];
    end;
    if Key = VK_SHIFT then Exit;
    ValidateCorners(ACorners, FCurrentPos);
    case Key of
      VK_LEFT..VK_DOWN :
        ChangeCursorPos(Key, Shift);
      VK_PRIOR:
      begin
        ViewInfo.BottomRow := ACorners.Top;
        FCurrentPos.Y := ViewInfo.TopRow;
        ACorners := GetCorners;
      end;
      VK_NEXT:
      begin
        FCurrentPos.Y := Row - ACorners.Top;
        ViewInfo.TopRow := ACorners.Bottom;
        FCurrentPos.Y   := ViewInfo.TopRow;
        ACorners := GetCorners;
      end;
      VK_END:
        if ssCtrl in Shift then
          FCurrentPos := Point(MaxColumn, MaxRow);
      VK_HOME:
      begin
        if ssCtrl in Shift then
          FCurrentPos := Point(0, 0)
        else
          FCurrentPos.X := 0;
        while not Cols.Visible[FCurrentPos.X] do Inc(FCurrentPos.X);
        while not Rows.Visible[FCurrentPos.Y] do Inc(FCurrentPos.Y);
      end;
      VK_DELETE:
      begin
        if Shift = [ssShift] then
          Copy(SelectionRect, True)
        else
          Self.ClearCells(DataStorage.Selection, ssCtrl in Shift);
      end;
      VK_RETURN:
        FCurrentPos.Y := FCurrentPos.Y + 1;
      VK_INSERT:
      begin
        if Shift = [ssShift] then
          Paste(SelectionRect.TopLeft)
        else
          if Shift = [ssCtrl] then
            Copy(SelectionRect, False);
      end;
    end;
    ValidateCorners(ACorners, FCurrentPos);
    if not (ssSelection in FSheetState) and (Key <> VK_Shift) then
      with FCurrentPos do Selection := Rect(X, Y, X, Y)
    else
      Selection := Rect(FCurrentPos.X, FCurrentPos.Y,
        FStartSelection.X, FStartSelection.Y);
  end;
  AScrollsPos := TPoint(ViewInfo.TopLeft);
  if (Key = VK_PRIOR) or (Key = VK_NEXT) or (Key = VK_END) or (Key = VK_HOME)  or
    ((Key >= VK_LEFT) or (Key <=VK_DOWN)) then
    begin
      Scroll(sbHorizontal, scPosition, AScrollsPos.X, False);
      Scroll(sbVertical, scPosition, AScrollsPos.Y, False);
    end;
end;

procedure TcxSSBookSheet.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if (Byte(Key) >= $21) and not CellReadOnly(Owner, Self, DataStorage.Col, DataStorage.Row) then
  begin
    if DoEditorActivate then
    begin
      CellEditor.Text := Key;
      CellEditor.SetFocus;
      CellEditor.SetCursorPosition(Point(1, 0));
    end
    else
      Exit;
  end;
end;

procedure TcxSSBookSheet.KeyUp(var Key: Word; Shift: TShiftState);
begin
  if Key = VK_SHIFT then FSheetState := [];
  inherited;
end;

procedure TcxSSBookSheet.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  ACol, ARow: Integer;
  AHitState: TcxSSHitTestStates;
const
  AResizeCursor: array[Boolean] of TCursor = (crVSplit, crHSplit);
  AState: array[Boolean] of TcxSSSheetState = (ssRowHeader, ssColHeader);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if ssEditorActivate in FSheetState then
  begin
    CellEditor.SetFocus;
    CellEditor.SetCursorPosition(CellEditor.GetEditPos(X - CellEditor.Left, Y - CellEditor.Top));
    FSheetState := [];
    Exit;
  end;
  FMouseDownPos := Point(X, Y);
  AHitState := ViewInfo.HitTest(X, Y, ACol, ARow);
  if htResize in AHitState then
  begin
    if ACol < 0 then
    begin
      FResizeHeaderType := htRow;
      FSizeIndex := ARow
    end
    else
    begin
      FResizeHeaderType := htCol;
      FSizeIndex := ACol;
    end;
    FSheetState := [ssResize] +  [AState[htColHeader in AHitState]];
    FChangedSizeValue := DataStorage.Headers[FResizeHeaderType][FSizeIndex];
  end
  else
  begin
    if mbRight = Button then
      if (ACol < 0) or (ARow < 0) or DataStorage.IsMultiSelection then
        Listener.OnSheetPopupMenu(Self, ClientToScreen(X, Y))
      else
      begin
        DataStorage.Selection := Rect(ACol, ARow, ACol, ARow);
        FDownCellPos := Point(ACol, ARow);
        Listener.OnSheetPopupMenu(Self, ClientToScreen(X, Y))
      end;
     if (htCell in AHitState) and not (Button = mbRight) then
     begin
       if Button = mbLeft then
         FSheetState := [ssSelection];
       DataStorage.Selection := Rect(ACol, ARow, ACol, ARow);
       FDownCellPos := Point(ACol, ARow);
     end;
  end;
end;

procedure TcxSSBookSheet.MouseMove(Shift: TShiftState; X, Y: Integer);

  procedure CheckNeedScrollContent;
  var
    ANeedViewInfoUpdate: Boolean;

    procedure DoScroll(AKind: TScrollBarKind; ACode: TScrollCode; APos: Integer);
    begin
      if APos > 0 then
      begin
        Scroll(AKind, ACode, APos, False);
        ANeedViewInfoUpdate := True;
      end;
    end;

  begin
    if Y < Owner.ColHeaderHeight then
      DoScroll(sbVertical, scLineUp, ViewInfo.TopRow)
    else
      if Y > Height then
        DoScroll(sbVertical, scLineDown, ViewInfo.BottomRow);
    if X < Owner.RowHeaderWidth then
      DoScroll(sbHorizontal, scLineUp, ViewInfo.LeftCol)
    else
      if X > Width then
        DoScroll(sbHorizontal, scLineDown, ViewInfo.RightCol);
    if ANeedViewInfoUpdate then
      ViewInfo.TopLeft := Point(Owner.HScrollBar.Data.Position,
        Owner.VScrollBar.Data.Position);
  end;

var
  ACol, ARow: Integer;
  AHitState: TcxSSHitTestStates;
  ASize: Integer;
  AR, ACr: TRect;

const
  AResizeCursor: array[Boolean] of TCursor = (crVSplit, crHSplit);

begin
  inherited MouseMove(Shift, X, Y);
  if ((ssLeft in Shift) or (ssRight in Shift)) and
     not ((ssResize in FSheetState) or (ssSelection in FSheetState)) then Exit;
  // if need scrolling
  if (ssLeft in Shift) and not (ssResize in FSheetState) then
    CheckNeedScrollContent;
  //..........
  if (ssSelection in FSheetState) and not ((ssLeft in Shift) or (ssRight in Shift)) then Exit;
  AHitState := ViewInfo.HitTest(X, Y, ACol, ARow);
  if (ssResize in FSheetState) and (ssLeft in Shift) then
  begin
    if FResizeHeaderType = htCol then
       ASize := X - FMouseDownPos.X
    else
       ASize := Y - FMouseDownPos.Y;
    ASize := ASize + FChangedSizeValue + 1;
    if ASize < 0 then
       ASize := 0;
    DataStorage.Headers[FResizeHeaderType].Size[FSizeIndex] := ASize;
  end
  else
  begin
    if (htResize in AHitState) and not (ssSelection in FSheetState)  then
    begin
      Cursor := AResizeCursor[htColHeader in AHitState];
      if htColHeader in AHitState then
        FSizeIndex := ACol
      else
        FSizeIndex := ARow;
    end
    else
    begin
      Cursor := crSSSelect;
      if ssSelection in FSheetState then
      begin
        with ViewInfo.InfoData do
        begin
          if ACol < 0 then ACol := 0;
          if ARow < 0 then ARow := 0;
        end;
        DataStorage.Selection := Rect(ACol, ARow, FDownCellPos.X, FDownCellPos.Y);
        AR := DataStorage.Selection;
        ACr.TopLeft := ViewInfo.TopLeft;
        ACr.BottomRight := ViewInfo.BottomRight;
{        if (ARow > FDownCellPos.Y) then
        begin
          if (AR.Bottom - 1) >= ACr.Bottom then
            ViewInfo.BottomRow := AR.Bottom;
        end
        else
          if (ARow <= FDownCellPos.Y) then
          begin
          end; }
      end;
    end;
  end;
end;

procedure TcxSSBookSheet.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if not (ssEditorActivate in FSheetState) then
  begin
    FSheetState := [];
    Exit;
  end
  else
    FSheetState := [];
end;

procedure TcxSSBookSheet.OnEndEditCell(Sender: TObject);
begin
  if Owner.HandleAllocated then
  begin
    try
      FSheetState := [];
      CellEditor.Visible := False;
      with GetCellObject(FEditingPos.X, FEditingPos.Y) do
      try
        FIsEditMode := True;
        Text := CellEditor.DisplayText;
      finally
        FIsEditMode := False;
        Free;
      end;
    finally
      ViewInfo.UpdateViewInfo;
      if Assigned(Owner.FOnEndEdit) then
        Owner.FOnEndEdit(Self);
    end;
  end;
end;

procedure TcxSSBookSheet.Paint;
begin
  ViewInfo.InfoChanged := False;
  Owner.Painter.Paint(Canvas, ViewInfo.InfoData);
end;

procedure TcxSSBookSheet.Scroll(AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode;
  var AScrollPos: Integer;  IsViewInfoUpdate: Boolean = True);
var
  AMax: Integer;
  AUpPos: Integer;
  ADown: Integer;
  APageSize: Integer;
  AScroller: TcxControlScrollBar;
begin
  if AScrollCode = scEndScroll then Exit;
  if AScrollBarKind = sbHorizontal then
  begin
    AScroller := Owner.HScrollBar;
    AMax := Max(DataStorage.MaxColumn, ViewInfo.RightCol);
    AUpPos := ViewInfo.LeftCol +
      TcxHeaderAccess(DataStorage.Headers[htCol]).GetCountItems(ViewInfo.LeftCol,
      Width - ViewInfo.RowHeaderWidth, False) + 1;
    ADown:= FSheetViewInfo.RightCol;
    APageSize := ViewInfo.RightCol - ViewInfo.LeftCol;
    if FSheetViewInfo.RightCol = FSheetViewInfo.LeftCol then
    begin
      if AScrollCode = scPageUp then
        Dec(AUpPos)
      else
        Inc(ADown);
      Inc(APageSize);
    end;
  end
  else
  begin
    AScroller := Owner.VScrollBar;
    AMax := Max(DataStorage.MaxRow, ViewInfo.BottomRow);
    AUpPos := ViewInfo.TopRow +
      TcxHeaderAccess(DataStorage.Headers[htRow]).GetCountItems(ViewInfo.TopRow,
      Height - ViewInfo.ColHeaderHeight, False) + 1;
    ADown:= FSheetViewInfo.BottomRow;
    APageSize := ViewInfo.BottomRow - ViewInfo.TopRow;
    if FSheetViewInfo.TopRow = FSheetViewInfo.BottomRow then
    begin
      Inc(ADown);
      Inc(APageSize);
    end;
  end;
  if AUpPos < 0 then AUpPos := 0;
  with AScroller.Data do
  begin
    Position := AScroller.Position;
    Max := AScroller.Max;
    PageSize := APageSize;
    case AScrollCode of
      scLineUp  :
        Position :=
          TcxHeaderAccess(DataStorage.Headers[TcxSSHeaderType(AScrollBarKind)]).GetNextItem(Position, False);
      scLineDown:
        Position :=
          TcxHeaderAccess(DataStorage.Headers[TcxSSHeaderType(AScrollBarKind)]).GetNextItem(Position, True);
      scPageDown:
        Position := ADown;
      scPageUp:
        Position := AUpPos;
      scPosition:
        Position := AScrollPos;
    end;
    if Position < 0 then Position := 0;
    if (Position + PageSize) > AMax then Max := Position + PageSize - 1;
    if Max < 15 then Max := 15;
  end;
  if IsViewInfoUpdate then
  case AScrollBarKind of
    sbHorizontal:
    begin
      FSheetViewInfo.LeftCol := AScroller.Data.Position;
      AScrollPos := FSheetViewInfo.LeftCol;
    end;
    sbVertical:
    begin
      FSheetViewInfo.TopRow := AScroller.Data.Position;
      AScrollPos := FSheetViewInfo.TopRow;
    end;
  end;
//  InitScrollBars;
//  AScroller.ApplyData;
end;

function TcxSSBookSheet.ViewInfoValid: Boolean;
begin
  Result := Visible and (ViewInfo <> nil) and
    (Owner <> nil) and (Owner.ActiveSheet = Self);
end;

function TcxSSBookSheet.GetActiveCell: TPoint;
begin
  Result := DataStorage.Selection.TopLeft;
end;

function TcxSSBookSheet.GetCellEditor: TcxSSInplaceTextEdit;
begin
  Result := Owner.FCellEditor;
end;

function TcxSSBookSheet.GetColHeader: TcxSSHeader;
begin
  Result := DataStorage.Headers[htCol];
end;

function TcxSSBookSheet.GetColumnCount: Integer;
begin
  Result := DataStorage.MaxColumn;
end;

function TcxSSBookSheet.GetCorners: TRect;
begin
  if ViewInfo <> nil then
  begin
    with ViewInfo do
    begin
      Result.TopLeft := TopLeft;
      Result.BottomRight := BottomRight;
    end;
  end
  else
    Result := Rect(0, 0, 0, 0);
end;

function TcxSSBookSheet.GetContentColCount: Integer;
begin
  Result := DataStorage.GetContentColCount;
end;

function TcxSSBookSheet.GetContentRowCount: Integer;
begin
  Result := DataStorage.GetContentRowCount;
end;

function TcxSSBookSheet.GetCurrentCol: Integer;
begin
  Result := DataStorage.Col;
end;

function TcxSSBookSheet.GetCurrentRow: Integer;
begin
  Result := DataStorage.Row;
end;

function TcxSSBookSheet.GetCell(const ACol, ARow: Integer): IcxSpreadSheetCell;
begin
  Supports(TObject(GetCellObject(ACol, ARow)), IcxSpreadSheetCell, Result);
end;

function TcxSSBookSheet.GetHistory: TcxSpreadSheetHistory;
begin
  Result := Owner.History;
end;

function TcxSSBookSheet.GetIsLoaded: Boolean;
begin
  Result := Owner.IsLoaded;
end;

function TcxSSBookSheet.GetListener: TcxSSListener;
begin
  Result := (Owner as TcxCustomSpreadSheetBook).Listener;
end;

function TcxSSBookSheet.GetPageIndex: Integer;
begin
  Result := Owner.FPages.IndexOf(Self);
end;

function TcxSSBookSheet.GetSheetCaption: string;
begin
  Result := DataStorage.SheetCaption;
end;

function TcxSSBookSheet.GetRowCount: Integer;
begin
  Result := DataStorage.MaxRow;
end;

function TcxSSBookSheet.GetRowHeader: TcxSSHeader;
begin
  Result := DataStorage.Headers[htRow];
end;

function TcxSSBookSheet.GetSelectionRect: TRect;
begin
  Result := DataStorage.Selection;
end;

function TcxSSBookSheet.GetTopLeft: TPoint;
begin
  Result := ViewInfo.TopLeft;
end;

procedure TcxSSBookSheet.SetActiveCell(const Value: TPoint);
begin
  DataStorage.Selection := Rect(Value.X, Value.Y, Value.X, Value.Y);
end;

procedure TcxSSBookSheet.SetColRowSize(const AKind: TcxSSHeaderType;
  const AColumn, ASize: Integer; ALocked: Boolean; AVisible: Boolean = True);
begin
  with DataStorage.Headers[AKind] do
  begin
    Size[AColumn] := ASize;
    LockProtect[AColumn] := ALocked;
    Visible[AColumn] := AVisible;
  end;
end;

procedure TcxSSBookSheet.SetCorners(const Value: TRect);
begin
  ViewInfo.TopLeft := Value.TopLeft;
end;

procedure TcxSSBookSheet.SetDefaultSize(const AKind: TcxSSHeaderType;
  ASize: Integer);
begin
  DataStorage.Headers[AKind].DefaultSize := ASize;
end;

procedure TcxSSBookSheet.SetMergedCells(const ARect: TRect; IsMerge: Boolean);
begin
  SetMergedState(ARect, IsMerge);
end;

procedure TcxSSBookSheet.SetPageDimension(const AHorzCount, AVertCount: Integer);
begin
  DataStorage.Dimension := TSize(Point(AHorzCount + 1, AVertCount + 1));
  DataStorage.SetCapacity(TSize(Point(AHorzCount, AVertCount)));
end;

procedure TcxSSBookSheet.SetProtection(Value: Boolean);
begin
  FProtected := Value;
end;

procedure TcxSSBookSheet.SetSheetCaption(Value: string);
var
  I: Integer;
begin
  Owner.Listener.OnChangeSheetCaption(Self, Value);
  if DataStorage.SheetCaption <> Value then
  begin
    for I := 0 to Owner.PageCount - 1 do
      if (Owner.Pages[I] <> Self) and (AnsiCompareText(Owner.Pages[I].DataStorage.SheetCaption, Value) = 0) then
        raise ESpreadSheetError.Create(cxGetResourceString(@scxSpreadSheetInvalidSheetCaption));
    DataStorage.SheetCaption := Value;
    Owner.CaptionBar.ReCalcViewInfo;
    Owner.UpdateControl;
  end;
end;

procedure TcxSSBookSheet.SetShowGrid(const Value: Boolean);
begin
  if Value = FShowGrid then Exit;
  FShowGrid := Value;
  ViewInfo.UpdateViewInfo;
end;

procedure TcxSSBookSheet.SetShowHeaders(const Value: Boolean);
begin
  if FShowHeaders = Value then Exit;
  FShowHeaders := Value;
  Owner.UpdateControl;
end;

procedure TcxSSBookSheet.SetShowFormulas(const Value: Boolean);
begin
  if Value = FShowFormulas then Exit;
  FShowFormulas := Value;
  Owner.UpdateControl;
end;

procedure TcxSSBookSheet.SetSelectionRect(Value: TRect);

  function GetActualSize(AItems: TcxSSHeader; AStart, AFinish: Integer): Integer;
  var
    I: Integer;
  begin
    Result := 0;
    for I := AStart to AFinish do
    begin
      Inc(Result, AItems.Size[I]);
      if Result <> 0 then Break;
    end;
  end;

var
  ColsWidth, RowsHeight: Integer;
begin
  repeat
    ColsWidth := GetActualSize(Cols, Value.Left, Value.Right);
    if ColsWidth = 0 then
    begin
      OffsetRect(Value, 1, 0);
      ColsWidth := GetActualSize(Cols, Value.Left, Value.Right);
    end;
    RowsHeight := GetActualSize(Rows, Value.Top, Value.Bottom);
    if RowsHeight = 0 then
    begin
      OffsetRect(Value, 0, 1);
      RowsHeight := GetActualSize(Rows, Value.Top, Value.Bottom);
    end;
  until (ColsWidth <> 0) and (RowsHeight <> 0);
  DataStorage.Selection := Value;
end;

procedure TcxSSBookSheet.SetTopLeft(const Value: TPoint);
begin
  ViewInfo.TopLeft := Value;
end;

procedure TcxSSBookSheet.SetViewInformation(const ASelectionRect: TRect;
  AViewFormulas, AViewGrid, AViewHeaders, AScrollBars: Boolean);
begin
  FShowHeaders := AViewHeaders;
  FShowGrid :=  AViewGrid;
  FShowFormulas := AViewFormulas;
  DataStorage.Selection := ASelectionRect;
  Owner.UpdateControl;
end;

{ TcxCustomSpreadSheetBook }
constructor TcxCustomSpreadSheetBook.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFloatPrecision := 2;
  FListener := GetListenerClass.Create(Self);
  FRowsAutoHeight := True;
  FHistory := GetHistoryClass.Create;
  FExcelProtectionStyle := True;
  TcxHistoryAccess(FHistory).HistoryOwner := Self;
  TcxHistoryAccess(FHistory).OnChange := FListener.OnHistoryChanged;
  TcxHistoryAccess(FHistory).BeginUpdate;
  FPaintBitmap := nil;
  FBufferedPaint := False;
  FPalette := cxExcelStdColors;
  FHeaderFont := TFont.Create;
  FCanvas := TcxCanvasWrapper.Create(@FPalette);
  FHeaderFont.OnChange := OnChangeHeaderStyle;
  FCaptionBar := GetBookPageCaptionsClass.Create(Self);
  FPages := TList.Create;
  FCaptionBar.Visible := True;
  FShowCaptionBar := True;
  FShowGrid := True;
  FDefaultColWidth := 85;
  FDefaultRowHeight := 20;
  FColHeaderHeight := 20;
  FRowHeaderWidth := 85;
  FPainterType := ptOffice97Style;
  FPainter := GetPainterClass.Create;
  FStyleCache := GetStyleCacheClass.Create(Self);
  FFormulasCache := GetFormulasCacheClass.Create(Self);
  FReadOnly := False;
  Keys := [kAll, kArrows, kChars, kTab];
  HScrollBar.Visible := True;
  VScrollBar.Visible := True;
  SetDefaultColor(clWindow);
  SetGridColor(clBtnFace);
  SetHeaderColor(clBtnFace);
  ScrollBars := sbsBoth;
  SetSelectionColor(clHighLight);
  SetBounds(Left, Top, 350, 200);
  TcxHistoryAccess(FHistory).EndUpdate;
  {$IFNDEF cxLib10}
  LookAndFeel.Kind := lfFlat;
  {$ENDIF}
  FTimer := TTimer.Create(Self);
  FTimer.Interval := 10;
  FTimer.Enabled := False;
  FTimer.OnTimer := OnMouseTimerHandle;
end;

destructor TcxCustomSpreadSheetBook.Destroy;
var
  I: Integer;
begin
  FTimer.Enabled := False;
  FTimer.Free;
  FListener.BeginUpdate;
  if Assigned(FPaintBitmap) then
    FPaintBitmap.Free;
  for I := 0 to PageCount - 1 do
    Pages[I]._Release;
  FCellEditor.Free;
  FHistory.Free;
  FCaptionBar.Free;
  FCanvas.Free;
  FPainter.Free;
  FHeaderFont.Free;
  FPages.Free;
  FStyleCache.Free;
  FFormulasCache.Free;
  FListener.Free;
  inherited Destroy;
end;

procedure TcxCustomSpreadSheetBook.Assign(Source: TPersistent);
var
  I: Integer;
  ASourceBook: TcxCustomSpreadSheetBook;
begin
  if (Source is TcxCustomSpreadSheetBook) and (Source <> Self) then
  begin
    ASourceBook := TcxCustomSpreadSheetBook(Source);
    Listener.BeginUpdate;
    try
      ClearAll;
      DefaultStyle.Assign(ASourceBook.DefaultStyle);
      FPalette := ASourceBook.FPalette;
      for I := 0 to ASourceBook.PageCount - 1 do
      begin
        AddSheetPage;
        Pages[I].Assign(ASourceBook[I]);
      end;
    finally
      Listener.EndUpdate;
      CaptionBar.FirstVisibleCaption := ASourceBook.CaptionBar.FirstVisibleCaption;
      FActivePage := -1;
      ActivePage := ASourceBook.ActivePage;
      CaptionBar.RecalcViewInfo;
      FReadOnly := ASourceBook.FReadOnly;
      Invalidate;
    end;
  end;
end;

function TcxCustomSpreadSheetBook.BeginUpdate: Integer;
begin
  Result := FListener.BeginUpdate;
  if FFormulasCache <> nil then
    FFormulasCache.Lock := True;
end;

function TcxCustomSpreadSheetBook.CellsNameByRef(ASheet: Integer;
  const CellsRef: TRect; IsText: Boolean = True): string;

  function CellRefToText(const APoint: TPoint): string;
  begin
    if R1C1ReferenceStyle then
      Result := 'R' + IntToStr(APoint.Y + 1) + 'C' + IntToStr(APoint.X + 1) + ''
    else
      Result := TcxSSUtils.ColumnNameByIndex(APoint.X, R1C1ReferenceStyle) + IntToStr(APoint.Y + 1);
  end;

var
  I: Integer;
const
  Separators: array[Boolean] of string = (':', ' x ');
begin
  if IsText then
  begin
    for I := 0 to Length(DefinedNames) - 1 do
    begin
      with DefinedNames[I].Definition do
      begin
        if (Page = ASheet) and EqualRect(TRect(Area), CellsRef) and not DefinedNames[I].IsDeleted then
        begin
          Result := DefinedNames[I].Name;
          Exit;
        end;
      end;
    end;
  end;
  Result := CellRefToText(CellsRef.TopLeft);
  if Int64(CellsRef.TopLeft) <> Int64(CellsRef.BottomRight) then
    Result := Result + Separators[IsText] + CellRefToText(CellsRef.BottomRight)
end;

procedure TcxCustomSpreadSheetBook.ClearAll;
var
  I: Integer;
begin
  for I := 0 to PageCount - 1 do
    Pages[I]._Release;
  FormulasCache.Clear;
  FStyleCache.Clear;
  FPages.Clear;
  FActivePage := 0;
  FHistory.Clear;
  if HandleAllocated and not Listener.IsLocked then
    Invalidate;
end;

procedure TcxCustomSpreadSheetBook.DeactivateEditor;
begin
  if Assigned(FCellEditor) and FCellEditor.Visible then
  begin
    FCellEditor.Visible := False;
    SetFocus;
  end;
end;

function TcxCustomSpreadSheetBook.DeleteName(const AName: string): Boolean;
begin
  Result := FFormulasCache.DeleteName(AName);
end;

function TcxCustomSpreadSheetBook.DefineName(const AName: string;
  APage: Word; const ARect: TRect): Integer;
begin
  Result := FFormulasCache.DefineName(AName, APage, TRange(ARect));
end;

function TcxCustomSpreadSheetBook.DefineNameEx(const AName: string;
  APage: Word; const ARect: TRect; Validate: Boolean = True): Integer;
begin
  Result := FFormulasCache.DefineName(AName, APage, TRange(ARect), Validate);
end;

function TcxCustomSpreadSheetBook.EndUpdate: Integer;
begin
  FFormulasCache.Lock := False;
  Result := FListener.EndUpdate;
  if Assigned(FCaptionBar) then
  begin
    FCaptionBar.ReCalcViewInfo;
    FCaptionBar.Invalidate;
  end;
  if Result <= 0 then
    UpdateControl;
end;

function TcxCustomSpreadSheetBook.HasRectName(ASheet: Integer; const ARect: TRect): Integer;
var
  I: Integer;
  ANames: TcxSSNamesDef;
begin
  ANames := DefinedNames;
  Result := -1;
  for I := 0 to Length(ANames) - 1 do
    with ANames[I].Definition do
      if (Page = ASheet) and EqualRect(TRect(Area), ARect) and not ANames[I].IsDeleted then
      begin
        Result := I;
        Break;
      end;
end;

function TcxCustomSpreadSheetBook.HitTest(const APoint: TPoint; out HitTestInfo: TcxSSHitTestInfo): Boolean;
var
  I: Integer;
  ACol, ARow: Integer;
  AStates: TcxSSHitTestStates;
begin
  FillChar(HitTestInfo, SizeOf(HitTestInfo), 0);
  Result := False;
  if FCaptionBar.Visible and PtInRect(FCaptionBar.BoundsRect, APoint) then
  begin
    case FCaptionBar.HitTest(APoint.X, APoint.Y - FCaptionBar.Top, I) of
      htCaption:
      begin
        HitTestInfo.HitType := htSheetCaption;
        HitTestInfo.Page := I;
        Result := True;
      end;
      htButton:
      begin
        HitTestInfo.HitType := htCaptionButton;
        HitTestInfo.Button := TcxSSNavigatorBtn(I);
        Result := True;
      end;
    end;
  end
  else
    if (PageCount > 0) and PtInRect(ActiveSheet.BoundsRect, APoint) then
    begin
      Result := True;
      AStates := ActiveSheet.ViewInfo.HitTest(APoint.X, APoint.Y, ACol, ARow);
      if htCell in AStates then
      begin
        HitTestInfo.HitType := htSheetCell;
        HitTestInfo.CellCol := ACol;
        HitTestInfo.CellRow := ARow;
      end
      else
        if htRowHeader in AStates then
        begin
          HitTestInfo.HitType := htSheetRow;
          HitTestInfo.Row := ARow;
        end
        else
          if htColHeader in AStates then
          begin
            HitTestInfo.HitType := htSheetColumn;
            HitTestInfo.Col := ACol;
          end
          else
            if htUpperLeft in AStates then
            begin
              HitTestInfo.HitType := htSheetColumn;
              HitTestInfo.CellCol := -1;
              HitTestInfo.CellRow := -1;
            end;
    end;
end;

procedure TcxCustomSpreadSheetBook.LoadFromFile(const AFileName: string);
var
  AFileStream: TFileStream;
begin
  if FileExists(AFileName) then
  begin
    AFileStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyNone);
    try
      LoadFromStream(AFileStream);
    finally
      AFileStream.Free;
    end;
  end
  else
    raise ESpreadSheetError.CreateFmt(cxGetResourceString(@scxSpreadSheetInvalidFileName), [AFileName]);
end;

procedure TcxCustomSpreadSheetBook.LoadFromStream(Stream: TStream);
var
  AReader: TcxExcelFileReader;
  ACursor: TCursor;
  I, J: Integer;
  ALockRef: Integer;
begin
  ALockRef := TcxFormulasAccess(FFormulasCache).FLockRef;
  AReader := TcxExcelFileReader.Create(Self);
  ReadOnly := False;
  History.Clear;
  History.BeginUpdate;
  BeginUpdate;
  ACursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  R1C1ReferenceStyle := False;
  IsDataLoading := True;
  if FCaptionBar.Visible then
    FCaptionBar.FirstVisibleCaption := 0;
  try
    FIsLoaded := True;
    if AReader.AssignStream(Stream) then
    begin
      try
        ClearAll;
        FFormulasCache.IsLoading := True;
        FFormulasCache.Lock := True;
        FPalette := cxExcelStdColors;
        AReader.OnProgress := Listener.OnProgress;
        AReader.OpenStream;
        FModified := False;
      except
        try
          ClearAll;
          if PageCount <> 0 then
            Pages[0].Caption := cxGetResourceString(@scxSheetName) + IntToStr(1)
          else
            AddSheetPage;
        finally
          raise EdxException.Create(cxGetResourceString(@scxSpreadSheetInvalidStreamFormat));
        end;
      end
    end
    else
      raise ESpreadSheetError.Create(cxGetResourceString(@scxSpreadSheetInvalidStreamFormat));
    if AReader.HasUnknownFunction then
      raise ESpreadSheetError.Create(cxGetResourceString(@scxXLSFileHasUnknownFunction));
  finally
    IsDataLoading := False;
    if RowsAutoHeight then
    begin
      for I := 0 to PageCount - 1 do
        for J := 0 to Pages[I].RowCount - 1 do
          Pages[I].ApplyAutoHeight(J);
    end;
    FActivePage := -1;
    ActivePage := 0;
    FIsLoaded := False;
    FFormulasCache.IsLoading := False;
    Screen.Cursor := ACursor;
    EndUpdate;
    AReader.Free;
    AdjustControls;
    UpdateControl;
    History.EndUpdate;
    History.Clear;
    TcxFormulasAccess(FFormulasCache).FLockRef := ALockRef;
  end;
end;

procedure TcxCustomSpreadSheetBook.Recalc;
begin
  if Listener.IsLocked then Exit;
  FFormulasCache.Updating := True;
  try
    if PageCount > 0 then FFormulasCache.Recalc;
  finally
    FFormulasCache.Updating := False;
    if (FFormulasCache.FuncCount > 0)then
    try
      if Assigned(OnAfterCalculation) then
      begin
        Listener.BeginUpdate;
        OnAfterCalculation(Self);
        Listener.EndUpdate;
      end;
    finally
      InternalUpdate;
    end;
  end;
end;

procedure TcxCustomSpreadSheetBook.SaveToFile(const AFileName: string);
var
  AStream: TFileStream;
begin
  AStream := TFileStream.Create(AFileName, fmOpenWrite or fmCreate or fmShareDenyNone);
  try
    SaveToStream(AStream);
  finally
    AStream.Free;
  end;
end;

procedure TcxCustomSpreadSheetBook.SaveToStream(AStream: TStream);
var
  I, J: Integer;
  ACursor: TCursor;
  APage: Integer;
  AWriter: TcxExcelFileWriter;

  procedure SetColsRowsInformation;
  var
    J: Integer;
    AHeader: TcxHeaderAccess;
  begin
    AHeader := TcxHeaderAccess(Pages[APage].Cols);
    AWriter.SetDefaultColWidth(APage, AHeader.DefaultSize);
    for J := 0 to AHeader.Count - 1 do
    if J < 255 then
      with AHeader.Data^[J] do
        if (hsHidden in States) or (not (hsDefault in States)) or not (hsLockProtect in States) then
          AWriter.SetColStyle(APage, J, Size, (hsLockProtect in States) <> DefaultStyle.Locked, hsHidden in States);
    AHeader := TcxHeaderAccess(Pages[APage].Rows);
    AWriter.SetDefaultRowHeight(APage, AHeader.DefaultSize);
    for J := 0 to AHeader.Count - 1 do
    begin
     if J < $FFFF then
       with AHeader.Data^[J] do
         if (hsHidden in States) or (not (hsDefault in States)) then
           AWriter.SetRowStyle(APage, J, Size, hsHidden in States);
    end;
  end;

  procedure SetCellValue(ACol, ARow: Word; ACell: PcxSSCellRec; AllowFormula: Boolean = False);
  var
    AStackItem: TcxStackItem;
  begin
    if (ACell <> nil) and (AllowFormula = (ACell^.DataType = dtFunction)) then
    begin
      AWriter.SelectStyle(ACell.StylePtr);
      case ACell^.DataType of
        dtText:
          AWriter.SetCellValue(APage, ACol, ARow, ACell^.Text, ACell^.StylePtr^.FormatIndex = $31);
        dtDateTime:
          AWriter.SetCellValue(APage, ACol, ARow, ACell^.DateTime);
        dtFunction:
          try
            AStackItem :=
              FFormulasCache.SpreadSheetTokensToExcelTokens(ACell^.FuncRecPtr);
            if AStackItem.Size > 0 then
              AWriter.SetCellFunction(APage, ACol, ARow,
                ACell^.FuncRecPtr^.CalcResult, AStackItem.Size, AStackItem.Tokens);
          finally
            FreeMem(AStackItem.Tokens);
            FillChar(AStackItem, SizeOf(TcxStackItem), 0);
            AStackItem.Tokens := nil;
          end;
      end;
    end;
  end;

begin
  AWriter := TcxExcelFileWriter.Create(Self);
  ACursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  Listener.OnProgress(Self, 0);
  TcxHistoryAccess(History).Clear;
  TcxHistoryAccess(History).BeginUpdate;
  try
    AWriter.PageCount := PageCount;
    AWriter.SetPalette(@FPalette);
    AWriter.SetProtection(-1, Protected);
    for I := 0 to Length(DefinedNames) - 1 do
      AWriter.DefineName(@DefinedNames[I]);
    AWriter.SetDefaultStyle(TcxStyleAccess(StyleCache.DefaultStyle).StylePtr);
    for APage := 0 to PageCount - 1 do
    begin
      Listener.OnProgress(Self, MulDiv(APage, 100, PageCount));
      AWriter.AddSheet(Pages[APage].Caption, Pages[APage].ShowGrid, True);
      AWriter.SetProtection(APage, Pages[APage].Protected);
      with TcxDataStorageAccess(Pages[APage].DataStorage) do
      begin
        SetColsRowsInformation;
        for I := 0 to MaxColumn - 1 do
          for J := 0 to Columns[I].CellsCount - 1 do
            if (I <= 255) and (J <= $FFFF) then
              SetCellValue(I, J, Columns[I].Cells^[J]);
        for I := 0 to MaxColumn - 1 do
          for J := 0 to Columns[I].CellsCount - 1 do
            if (I <= 255) and (J <= $FFFF) then
              SetCellValue(I, J, Columns[I].Cells^[J], True);
        AWriter.SetMergedCells(APage, MergedCells.Rects);
      end;
    end;
    AWriter.SaveToStream(AStream);
  finally
    Screen.Cursor := ACursor;
    TcxHistoryAccess(History).EndUpdate;
    AWriter.Free;
    Listener.OnProgress(Self, 100);
  end;
  FModified := False;
end;

procedure TcxCustomSpreadSheetBook.UpdateControl;
begin
  if not Listener.IsLocked then
  begin
    DoRecalc;
    InternalUpdate;
  end;
end;

procedure TcxCustomSpreadSheetBook.AddPage(ASheet: TcxSSBookSheet);
var
  APageId: Integer;
begin
  APageId := FPages.Add(ASheet);
  if APageId = 0 then
  begin
    FActivePage := 0;
    ASheet.Visible := True;
  end
  else
    ASheet.Visible := False;
  SetLength(FPageVisible, APageId + 1);
  PageVisible[APageId] := True;
  if HandleAllocated then
  begin
    FCaptionBar.ReCalcViewInfo;
    FCaptionBar.Invalidate;
  end;
  if (APageID = 0) or (APageID = ActivePage) then
    AdjustControls;
end;

procedure TcxCustomSpreadSheetBook.AddSheetPage(const APageName: string = '');
var
  ASheetPage: TcxSSBookSheet;
begin
  BeginUpdate;
  try
    ASheetPage := GetSheetClass.Create(Self);
    ASheetPage._AddRef;
    if APageName = '' then
      ASheetPage.DataStorage.SheetCaption := cxGetResourceString(@scxSheetName) + IntToStr(PageCount + 1)
    else
      ASheetPage.DataStorage.SheetCaption := APageName;
    AddPage(ASheetPage);
  finally
    EndUpdate;
  end;
end;

procedure TcxCustomSpreadSheetBook.AdjustControls;
var
  AVScrollWidth: Integer;
  AHScrollHeight: Integer;
  AHeight: Integer;
  AWidth: Integer;
begin
  if FCaptionBar = nil then Exit;
  if FCaptionBar.Visible then
    FCaptionBar.RecalcViewInfo;
  if ScrollersVisible[FScrollBars, sbVertical] then
    AVScrollWidth := VScrollBar.Width
  else
    AVScrollWidth := 0;
  if FCaptionBar.Visible or ScrollersVisible[FScrollBars, sbHorizontal] then
    AHScrollHeight := FCaptionBar.Height
  else
    AHScrollHeight := 0;
  if HandleAllocated then
  begin
    AHeight := ClientHeight;
    AWidth := ClientWidth;
  end
  else
  begin
    AHeight := Height;
    AWidth := Width;
  end;
  if FCaptionBar.Visible then
    FCaptionBar.SetBounds(0,  AHeight - AHScrollHeight, Width,  AHScrollHeight);
  if PageCount > 0 then
    ActiveSheet.SetBounds(0, 0, AWidth - AVScrollWidth,
      AHeight - AHScrollHeight);
  UpdateControl;
  FCaptionBar.ReCalcViewInfo;
  FCaptionBar.Invalidate;
end;

procedure TcxCustomSpreadSheetBook.DblClick;
begin
  inherited;
  if PageCount > 0 then
  begin
    with FMouseDownPos do
    begin
      if FCaptionBar.Visible and PtInRect(FCaptionBar.BoundsRect, Point(X, Y)) then
        FCaptionBar.DblClick
      else
        ActiveSheet.DblClick;
    end;
  end;
end;

procedure TcxCustomSpreadSheetBook.DoRecalc;
begin
  if AutoRecalc then Recalc;
end;

function TcxCustomSpreadSheetBook.DoMouseWheel(Shift: TShiftState;
  WheelDelta: Integer;  MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheel(Shift, WheelDelta, MousePos);
  if (PageCount > 0) and ((FCaptureControl = nil) or
    ((FCaptureControl <> nil) and (FCaptureControl = ActiveSheet))) then
    Result := ActiveSheet.DoMousewheel(Shift, WheelDelta, MousePos);
end;

procedure TcxCustomSpreadSheetBook.DoContextPopup(
   MousePos: TPoint; var Handled: Boolean);
begin
  if not FContextPopupHandled then
  begin
    inherited;
    FContextPopupHandled := False;
  end;
end;

procedure TcxCustomSpreadSheetBook.FocusChanged;
begin
  FCaptionBar.FocusChanged;
  if PageCount > 0 then
    ActiveSheet.FocusChanged;
end;

function TcxCustomSpreadSheetBook.GetBookPageCaptionsClass: TcxSSBookPageCaptionsClass;
begin
  Result := TcxSSBookPageCaptions;
end;

function TcxCustomSpreadSheetBook.GetCaptionPainterClass: TcxPageCaptionPainterClass;
begin
  Result := TcxPageCaptionPainter
end;

function TcxCustomSpreadSheetBook.GetDataStorageClass: TcxSSDataStorageClass;
begin
  Result := TcxSSDataStorage;
end;

function TcxCustomSpreadSheetBook.GetFormulasCacheClass: TcxFormulasCacheClass;
begin
  Result := TcxSSFormulasCache;
end;

function TcxCustomSpreadSheetBook.GetHeaderClass: TcxSSHeaderClass;
begin
  Result := TcxSSHeader;
end;

function TcxCustomSpreadSheetBook.GetHistoryClass: TcxSSHistoryClass;
begin
  Result := TcxSpreadSheetHistory;
end;

function TcxCustomSpreadSheetBook.GetHScrollBarBounds: TRect;
var
  AClientSize: TSize;
  HScrollHeight: Integer;
begin
  if FCaptionBar.Visible then
    HScrollHeight := FCaptionBar.Height
  else
    HScrollHeight := cxHScrollHeight;
  AClientSize := TSize(ClientRect.BottomRight);
  if ScrollersVisible[FScrollBars, sbHorizontal] then
  with AClientSize do
  begin
    if ScrollersVisible[FScrollBars, sbVertical] then
      Result := Rect(0, CY - HScrollHeight, CX - cxVScrollWidth, CY)
    else
      Result := Rect(0, CY - HScrollHeight, CX, CY);
    if FCaptionBar.Visible then
      Result.Left := CX shr 1
  end;
end;

function TcxCustomSpreadSheetBook.GetInplaceEditClass: TcxSSInplaceEditClass;
begin
  Result := TcxSSInplaceTextEdit;
end;

function TcxCustomSpreadSheetBook.GetListenerClass: TcxSSListenerClass;
begin
  Result := TcxSSListener;
end;

function TcxCustomSpreadSheetBook.GetPainterClass: TcxSheetPainterClass;
const
  APainters: array[TcxSSPainterType] of TcxSheetPainterClass =
    (TcxSheetPainter, TcxXPPainter, TcxSheetPainter);
begin
  Result := APainters[FPainterType];
  if (FPainterType = ptCustom) and not IsDesigning then
    if Assigned(FOnCustomPaint) then
       FOnCustomPaint(Self, Result);
end;

function TcxCustomSpreadSheetBook.GetPalettePtr: PcxExcelPalette;
begin
  Result := @FPalette;
end;

function TcxCustomSpreadSheetBook.GetStyleCacheClass: TcxSSStyleCacheClass;
begin
  Result := TcxSSStyleCache;
end;

function TcxCustomSpreadSheetBook.GetSheetClass: TcxSSBookSheetClass;
begin
  Result := TcxSSBookSheet;
end;

function TcxCustomSpreadSheetBook.GetVScrollBarBounds: TRect;
var
  AClientSize: TSize;
begin
  AClientSize := TSize(ClientRect.BottomRight);
  if ScrollersVisible[FScrollBars, sbVertical] then
  with AClientSize do
  begin
    if ScrollersVisible[FScrollBars, sbHorizontal] or FCaptionBar.Visible then
      Result := Rect(CX - cxVScrollWidth, 0, CX, CY - HScrollbar.Height)
    else
      Result := Rect(CX - cxVScrollWidth, 0, CX, CY)
  end;
end;

function TcxCustomSpreadSheetBook.GetViewInfoClass: TcxSSheetViewInfoClass;
begin
  Result := TcxSSheetViewInfo;
end;

procedure TcxCustomSpreadSheetBook.Paint;
var
  ARect: TRect;

  procedure PaintControls;
  var
    AClipRgn: TcxRegion;
  begin
    AClipRgn := inherited Canvas.GetClipRegion();
    if FCaptionBar.Visible then
      inherited Canvas.ExcludeClipRect(FCaptionBar.BoundsRect);
    if ActiveSheet.Visible then
      ActiveSheet.Paint;
    inherited Canvas.SetClipRegion(AClipRgn, roSet);
    if FCaptionBar.Visible then
      FCaptionBar.Paint;
  end;

begin
  inherited Paint;
  Painter.HideSelection := HideSelection and not Focused;
  Canvas.BeginPaint(inherited Canvas.Canvas);
  if PageCount > 0 then
  begin
    if BufferedPaint then
    begin
      Canvas.BeginPaint(FPaintBitmap.Canvas);
      SelectClipRgn(FPaintBitmap.Canvas.Handle, 0);
      if (FCaptionBar <> nil) and (FCaptionBar.Visible) then
        FCaptionBar.Paint;
      if ActiveSheet.ViewInfo.InfoChanged then
        ActiveSheet.Paint;
      BitBlt(inherited Canvas.Handle, 0, 0, Width,
         Height, FPaintBitmap.Canvas.Handle, 0, 0, srcCopy);
    end
    else
      PaintControls;
  end
  else
  begin
    ARect := Rect(0, 0, ClientWidth - 1, ClientHeight -1);
    Canvas.FillRect(ARect, fsSolid, clBtnFace, cxSSDefaultColorValue);
    Canvas.FrameRect(ARect, clBtnHighLight, clBtnShadow);
  end;
end;

procedure TcxCustomSpreadSheetBook.InitScrollBarsParameters;
begin
  if PageCount > 0 then
    ActiveSheet.InitScrollBars;
end;

procedure TcxCustomSpreadSheetBook.InternalUpdate;
begin
  if PageCount > 0 then
    ActiveSheet.ViewInfo.UpdateViewInfo;
  if HandleAllocated then
    UpdateScrollBars
  else
    if PageCount > 0 then
      ActiveSheet.InitScrollBars;
  if not Listener.IsLocked then Invalidate;
end;

procedure TcxCustomSpreadSheetBook.KeyDown(var Key: Word; Shift: TShiftState);

  function InKeys(const AKeys: WideString): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    if Length(AKeys) <> 0 then
      for I := 1 to Length(AKeys) do
      if Result then
        Break
      else
        Result := WideChar(Key) = AKeys[I];
  end;

begin
  inherited KeyDown(Key, Shift);
  if PageCount > 0 then
  begin
    if (ssCtrl in Shift) and InKeys('CXVZY') then
    with ActiveSheet do
    begin
      case WideChar(Key) of
        'C':
          Copy(SelectionRect, False);
        'X':
          Copy(SelectionRect, True);
        'V':
          Paste(SelectionRect.TopLeft);
        'Z':
          History.Undo(1);
        'Y':
          History.Redo(1);
      end;
    end
    else
    begin
      case Key of
        VK_F9:
          try
            FFormulasCache.Lock := False;
            Recalc;
          finally
            FFormulasCache.Lock := True;
            UpdateControl;
          end;
      else
        if (FCaptureControl = nil) and ViewInfoValid then
          ActiveSheet.KeyDown(Key, Shift);
      end;
    end;
  end;
end;

procedure TcxCustomSpreadSheetBook.KeyPress(var Key: Char);
begin
  if PageCount > 0 then
  begin
    if (FCaptureControl = nil) and ViewInfoValid then
      ActiveSheet.KeyPress(Key);
  end;
  inherited;
end;

procedure TcxCustomSpreadSheetBook.KeyUp(var Key: Word; Shift: TShiftState);
begin
  if PageCount > 0 then
  begin
    if (FCaptureControl = nil) and ViewInfoValid then
      ActiveSheet.KeyUp(Key, Shift);
  end;
  inherited;
end;

procedure TcxCustomSpreadSheetBook.Loaded;
begin
  inherited;
  AdjustControls;
  if Assigned(FCaptionBar) then
    FCaptionBar.RecalcViewInfo;
  UpdateControl;
end;

procedure TcxCustomSpreadSheetBook.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  R: TRect;
begin
  FMousePos := Point(X, Y);
  if PageCount > 0 then
  begin
    if (FCaptureControl = FCaptionBar) or
      ((FCaptureControl = nil) and PtInRect(FCaptionBar.BoundsRect, Point(X, Y))) then
      FCaptionBar.MouseMove(Shift, X, Y - FCaptionBar.Top)
    else
      if ViewInfoValid then
      begin
        ActiveSheet.MouseMove(Shift, X, Y);
        FShift := Shift;
        R.BottomRight := ActiveSheet.ClientRect.BottomRight;
        R.TopLeft := Point(RowHeaderWidth, ColHeaderHeight);
        FTimer.Enabled := not PtInRect(R, FMousePos);
      end;
  end;
  inherited;
end;

procedure TcxCustomSpreadSheetBook.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  HitTestInfo: TcxSSHitTestInfo;
begin
  inherited;
  FContextPopupHandled := False;
  HitTest(Point(X, Y), HitTestInfo);
  if PageCount > 0 then
  begin
    Windows.SetFocus( Handle );
    FMouseDownPos := Point(X, Y);
    if FCaptionBar.Visible and PtInRect(FCaptionBar.BoundsRect, Point(X, Y)) then
    begin
      FCaptionBar.MouseDown(Button, Shift, X, Y - FCaptionBar.Top);
      if Button <> mbRight then
        FCaptureControl := FCaptionBar;
    end
    else
    begin
      if Button <> mbRight then
        FCaptureControl := ActiveSheet;
      if ViewInfoValid then
      begin
        ActiveSheet.MouseDown(Button, Shift, X, Y);
      end;
    end;
  end;
end;

procedure TcxCustomSpreadSheetBook.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FTimer.Enabled := False;
  inherited;
  if PageCount > 0 then
  begin
    if (FCaptionBar.Visible and PtInRect(FCaptionBar.BoundsRect, Point(X, Y))) or
      ((FCaptionBar <> nil) and (FCaptureControl = FCaptionBar)) then
      FCaptionBar.MouseUp(Button, Shift, X, Y - FCaptionBar.Top)
    else
      if ViewInfoValid then
        ActiveSheet.MouseUp(Button, Shift, X, Y);
    FCaptureControl := nil;
  end;
end;

procedure TcxCustomSpreadSheetBook.OnChangeHeaderStyle(Sender: TObject);
begin
  if ViewInfoValid then
    ActiveSheet.ViewInfo.UpdateViewInfo;
end;

procedure TcxCustomSpreadSheetBook.OnMouseTimerHandle(Sender: TObject);
begin
  with FMousePos do
    MouseMove(FShift, X, Y);
end;

procedure TcxCustomSpreadSheetBook.Resize;
begin
  inherited Resize;
  AdjustControls;
  if Assigned(FPaintBitmap) then
  begin
    FPaintBitmap.Height := Height;
    FPaintBitmap.Width := Width;
  end;
  if (FCaptionBar <> nil) and (FCaptionBar.FCaptionEditor <> nil) or
    (PageCount > 0) and (ActiveSheet.CellEditor <> nil) and CanFocus then SetFocus;
  UpdateScrollBars;
end;

function TcxCustomSpreadSheetBook.AddSheet(const AName: string;
  AVisible: Boolean): IcxBookSheet;
begin
  AddSheetPage(AName);
  Supports(TObject(Pages[PageCount - 1]), IcxBookSheet, Result);
end;

function TcxCustomSpreadSheetBook.GetActiveCell: TPoint;
begin
  Result := ActiveSheet.ActiveCell;
end;

function TcxCustomSpreadSheetBook.GetActiveSheet: TcxSSBookSheet;
begin
  Result := Pages[FActivePage];
end;

function TcxCustomSpreadSheetBook.GetAutoReCalc: Boolean;
begin
  Result := not FFormulasCache.Lock
end;

function TcxCustomSpreadSheetBook.GetCell(APage: Word;
  ACol, ARow: Integer): IcxSpreadSheetCell;
begin
  Result := Pages[APage].GetCell(ACol, ARow)
end;

function TcxCustomSpreadSheetBook.GetDefinedNames: TcxSSNamesDef;
begin
  Result := FFormulasCache.Names;
end;

function TcxCustomSpreadSheetBook.GetDefaultStyle: TcxSSDefaultStyle;
begin
  Result := FStyleCache.DefaultStyle;
end;

function TcxCustomSpreadSheetBook.GetPage(APage: Integer): TcxSSBookSheet;
begin
  try
    Result := TcxSSBookSheet(FPages[APage]);
  except
    raise ESpreadSheetError.Create(cxGetResourceString(@scxSpreadSheetInvalidSheetNumber));
  end;
end;

function TcxCustomSpreadSheetBook.GetPageCount: Word;
begin
  if not Assigned(FPages) then
    Result := 0
  else
    Result := FPages.Count;
end;

function TcxCustomSpreadSheetBook.GetPageSelection(APage: Word): TRect;
begin
  Result := Pages[APage].SelectionRect;
end;

function TcxCustomSpreadSheetBook.GetPageVisible(APage: Word): Boolean;
begin
  if APage >= Length(FPageVisible) then
    Result := False
  else
    Result := FPageVisible[APage]
end;

function TcxCustomSpreadSheetBook.GetRCRefStyle: Boolean;
begin
  Result := FFormulasCache.RCRefStyle;
end;

function TcxCustomSpreadSheetBook.GetSelection: TRect;
begin
  Result := ActiveSheet.SelectionRect;
end;

function TcxCustomSpreadSheetBook.GetSheet(APage: Word): IcxBookSheet;
begin
  Supports(TObject(Pages[APage]), IcxBookSheet, Result);
end;

function TcxCustomSpreadSheetBook.GetShowHeaders: Boolean;
begin
  Result := ActiveSheet.ShowHeaders;
end;

procedure TcxCustomSpreadSheetBook.SetPalette(
  const APalette: PcxExcelPalette);
begin
  FPalette := APalette^;
end;

procedure TcxCustomSpreadSheetBook.SetProtection(Value: Boolean);
begin
  FProtected := Value;
end;

procedure TcxCustomSpreadSheetBook.SetActiveCell(const AValue: TPoint);
begin
  ActiveSheet.ActiveCell := AValue;
end;

procedure TcxCustomSpreadSheetBook.SetActivePage(AValue: Integer);
var
  ACanSelect: Boolean;
const
  AState: array[Boolean] of TcxSSCaptionStates = ([], [csCurrent]);
begin
  if (FActivePage = AValue) or (AValue < 0) or (AValue >= PageCount) then Exit;
  while not FPageVisible[AValue] and (AValue < (PageCount - 1)) do Inc(AValue);
  while not FPageVisible[AValue] and (AValue > 0) do Dec(AValue);
  ACanSelect := True;
  Listener.OnActiveSheetChanging(Self, AValue, ACanSelect);
  if ACanSelect then
  begin
    if (FCellEditor <> nil) and FCellEditor.Focused then SetFocus;
    if AValue >= Length(FCaptionBar.ViewInfo.Bricks) then
      FCaptionBar.RecalcViewInfo;
    if FActivePage >= 0 then
      FCaptionBar.UpdateCaptionInfo(FActivePage, []);
    Pages[AValue].SetBounds(ClientBounds.Top, ClientBounds.Left,
                            ClientBounds.Right, ClientBounds.Bottom);
    Pages[AValue].Visible := True;
    if FActivePage >= 0 then
      Pages[FActivePage].Visible := False;
    FCaptionBar.UpdateCaptionInfo(AValue, [csCurrent]);
    FActivePage := AValue;
    ActiveSheet.SelectionRect := ActiveSheet.DataStorage.CheckSelectionRect(ActiveSheet.SelectionRect);
    if ViewInfoValid then
      ActiveSheet.ViewInfo.UpdateViewInfo;
    FCaptionBar.MakeTabVisible(FActivePage);
    ActiveSheet.Invalidate;
  end;
end;

procedure TcxCustomSpreadSheetBook.SetAutoRecalc(const AValue: Boolean);
begin
  if Assigned(FFormulasCache) then
  begin
    if (AValue and not FFormulasCache.Lock) or (not AValue and FFormulasCache.Lock) then Exit;
    FFormulasCache.Lock := not AValue;
    if AValue then ReCalc;
  end;
end;

procedure TcxCustomSpreadSheetBook.SetBufferedPaint(const AValue: Boolean);
begin
  if FBufferedPaint <> AValue then
  begin
    FBufferedPaint := AValue;
    if AValue then
    begin
      if FPaintBitmap = nil then
        FPaintBitmap := TBitmap.Create;
      FPaintBitmap.Width := Width;
      FPaintBitmap.Height := Height;
    end;
  end;
end;

procedure TcxCustomSpreadSheetBook.SetCustomPainter(const AValue: TcxSSCustomPaintEvent);
begin
  FOnCustomPaint := AValue;
  if Assigned(FPainter) then FPainter.Free;
  FPainter := GetPainterClass.Create;
  if PageCount > 0 then ActiveSheet.Invalidate;
end;

procedure TcxCustomSpreadSheetBook.SetColHeaderHeight(const AValue: Integer);
begin
  if (AValue <= 0) or (AValue = FColHeaderHeight) then Exit;
  FColHeaderHeight := AValue;
  if ViewInfoValid then
    ActiveSheet.ViewInfo.UpdateViewInfo;
end;

procedure TcxCustomSpreadSheetBook.SetDefaultColWidth(const AValue: TcxSSSize);
var
  I: Integer;
begin
  if AValue = FDefaultColWidth then Exit;
  FDefaultColWidth := AValue;
  for I := 0 to PageCount - 1 do
    Pages[I].DataStorage.Headers[htCol].DefaultSize := AValue;
  if ViewInfoValid then
    ActiveSheet.ViewInfo.UpdateViewInfo;
end;

procedure TcxCustomSpreadSheetBook.SetDefaultStyle(const AStyle: PcxSSCellStyleRec);
var
  AFontPtr: PcxSSFontRec;
begin
  AFontPtr := FStyleCache.Styles[0]^.FontPtr;
  DeleteObject(AFontPtr^.FontHandle);
  AStyle^.FontPtr^.FontHandle := CreateFontHandle(AStyle^.FontPtr);
  AFontPtr^ := AStyle^.FontPtr^;
  FStyleCache.Styles[0]^ := AStyle^;
  TcxStyleAccess(FStyleCache.DefaultStyle).StyleInfo := FStyleCache.Styles[0]^;
  FStyleCache.Styles[0]^.FontPtr := AFontPtr;
  FStyleCache.Styles[0]^.RefCount := 1;
  TcxStyleAccess(DefaultStyle).StyleInfo := FStyleCache.Styles[0]^;
end;

procedure TcxCustomSpreadSheetBook.SetDefaultStyleProperty(AValue: TcxSSDefaultStyle);
begin
  FStyleCache.DefaultStyle.Assign(AValue);
end;

procedure TcxCustomSpreadSheetBook.SetDefaultRowHeight(const AValue: TcxSSSize);
var
  I: Integer;
begin
  if AValue = FDefaultRowHeight then Exit;
  FDefaultRowHeight := AValue;
  for I := 0 to PageCount - 1 do
    Pages[I].DataStorage.Headers[htRow].DefaultSize := AValue;
  if ViewInfoValid then
    ActiveSheet.ViewInfo.UpdateViewInfo;
end;

procedure TcxCustomSpreadSheetBook.SetDefaultColor(const AValue: TColor);
begin
  if FWindowColor = AValue then Exit;
  FWindowColor := AValue;
  Canvas.WindowColor := Canvas.GetNativeColor(FWindowColor);
  if not Listener.IsLocked then
    Invalidate;
end;

procedure TcxCustomSpreadSheetBook.SetFloatPrecision(const AValue: Byte);
begin
  if FFloatPrecision <> AValue then
  begin
    FFloatPrecision := AValue;
    UpdateControl;
  end;
end;

procedure TcxCustomSpreadSheetBook.SetGridColor(const AValue: TColor);
begin
  if AValue <> FGridColor then
  begin
    FGridColor := AValue;
    Canvas.BorderColor := Canvas.GetNativeColor(FGridColor);
    if not Listener.IsLocked then
      Invalidate;
  end;
end;

procedure TcxCustomSpreadSheetBook.SetHeaderFont(AValue: TFont);
begin
  if not Assigned(AValue) then Exit;
  FHeaderFont.Assign(AValue);
  AdjustControls;
end;

procedure TcxCustomSpreadSheetBook.SetHeaderColor(const AValue: TColor);
begin
  if AValue <> FHeaderColor then
  begin
    FHeaderColor := AValue;
    if ViewInfoValid then
      PInteger(@ActiveSheet.ViewInfo.InfoData.HeaderColor)^ :=
        Canvas.GetNativeColor(FHeaderColor);
    if not Listener.IsLocked then
      Invalidate;
  end;
end;

procedure TcxCustomSpreadSheetBook.SetPainterType(const AValue: TcxSSPainterType);
begin
  if AValue = FPainterType then Exit;
  FPainterType := AValue;
  if Assigned(FPainter) then FPainter.Free;
  FPainter := GetPainterClass.Create;
  if ViewInfoValid then
    ActiveSheet.ViewInfo.InfoChanged := True;
  if not Listener.IsLocked then
    Invalidate;
end;

procedure TcxCustomSpreadSheetBook.SetPageCount(const AValue: Word);
var
  I, ACount: Integer;
begin
  if PageCount <> AValue then
  try
    BeginUpdate;
    ACount := PageCount;
    if ACount > AValue then
    begin
      for I := AValue to ACount - 1 do
      begin
        Pages[AValue]._Release;
        FPages.Delete(AValue);
      end;
      ActivePage := 0;
    end
    else
      if ACount < AValue then
      begin
        ACount := PageCount;
        for I := ACount to AValue - 1 do
          AddSheetPage;
      end;
  finally
    EndUpdate;
    FCaptionBar.Invalidate;
  end;
end;

procedure TcxCustomSpreadSheetBook.SetPageSelection(APage: Word;
  const AValue: TRect);
begin
  Pages[APage].SelectionRect := AValue;
end;

procedure TcxCustomSpreadSheetBook.SetPageVisible(APage: Word;
  const AValue: Boolean);
begin
  FPageVisible[APage] := AValue;
end;

procedure TcxCustomSpreadSheetBook.SetRCRefStyle(const AValue: Boolean);
begin
  if AValue <> FFormulasCache.RCRefStyle then
  begin
    FFormulasCache.RCRefStyle := AValue;
    UpdateControl;
  end;
end;

procedure TcxCustomSpreadSheetBook.SetReadOnly(const AValue: Boolean);
begin
  if AValue <> FReadOnly then
  begin
    DefaultStyle.ReadOnly := AValue;
    FReadOnly := AValue;
  end;
end;

procedure TcxCustomSpreadSheetBook.Scroll(AScrollBarKind: TScrollBarKind;
  AScrollCode: TScrollCode; var AScrollPos: Integer);
begin
  inherited Scroll(AScrollBarKind, AScrollCode, AScrollPos);
  if ViewInfoValid then
  begin
    ActiveSheet.Scroll(AScrollBarKind, AScrollCode, AScrollPos);
    ActiveSheet.InitScrollBars;
  end;
end;

function TcxCustomSpreadSheetBook.SpreadSheetClipboardDataToData(
  ASheet: TcxSSBookSheet; const AColPos, ARowPos: Integer; out AChangedRect: TRect): Boolean;

var
  DC, DR: Integer;

  procedure SetCellData(ACol, ARow: Integer; const AData: AnsiString);
  var
    ADataSize: Integer;
    ACell: TcxSSCellRec;
    AFont: TcxSSFontRec;
    ASide: TcxSSEdgeBorder;
    IsFuncValid: Boolean;

    procedure GetBuf(var Buf; ASize: Integer);
    begin
      Move(AData[ADataSize], Buf, ASize);
      Inc(ADataSize, ASize);
    end;

    function GetByte: Byte;
    begin
      GetBuf(Result, SizeOf(Result));
    end;

    function GetWord: Word;
    begin
      GetBuf(Result, SizeOf(Result));
    end;

    function GetString: string;
    var
      ASize: Integer;
    begin
      GetBuf(ASize, SizeOf(ASize));
      SetLength(Result, ASize div SizeOf(Char));
      if ASize > 0 then
        GetBuf(Result[1], ASize);
    end;

  begin
    if AData <> '' then
    begin
      IsFuncValid := True;
      ADataSize := 1;
      with ASheet.GetCellObject(ACol, ARow) do
      try
        if not CanModify(ASheet.Owner, ASheet, ACol, ARow) then Exit;
        with TcxStyleAccess(Style).StyleInfo do
        begin
          CellState := [];
          GetBuf(FormatIndex, SizeOf(FormatIndex));
          GetBuf(HorzAlign, SizeOf(HorzAlign));
          GetBuf(VertAlign, SizeOf(VertAlign));
          GetBuf(WordBreak, SizeOf(WordBreak));
          GetBuf(ShrinkToFit, SizeOf(ShrinkToFit));
          GetBuf(BrushStyle, SizeOf(BrushStyle));
          GetBuf(BrushFgColor, SizeOf(BrushFgColor));
          GetBuf(BrushBkColor, SizeOf(BrushBkColor));
          AFont.Name := GetString;
          AFont.FontColor := GetWord;
          Byte(AFont.Style) := GetByte;
          Byte(AFont.Charset) := GetByte;
          AFont.Size := SmallInt(GetByte);
          with Style.Font do
            AssignInfo(AFont.Name, AFont.Size, AFont.Style, AFont.Charset, AFont.FontColor);
          TcxStyleAccess(Style).DoOnChange(Style, siAll);
          for ASide := eLeft to eBottom do
          begin
            Borders[ASide].Style := TcxSSEdgeLineStyle(GetByte);
            Borders[ASide].Color := GetWord;
            TcxStyleAccess(Style).DoOnChange(Style.Borders[ASide], siBorder);
          end;
          GetBuf(CellState, SizeOf(TcxSSCellStates));
          TcxStyleAccess(Style).DoOnChange(Style, siAll);
        end;
      finally
        Free;
      end;
      ACell := ASheet.DataStorage[ACol, ARow];
      with ACell do
      try
        if (DataType = dtFunction) and (FuncRecPtr <> nil) then
        begin
          FormulasCache.DestroyFunction(FuncRecPtr);
          FuncRecPtr := nil;
{          FreeMem(FuncRecPtr^.CalcResult.Tokens);
          FreeMem(FuncRecPtr^.FuncTree.Tokens);
          FillChar(FuncRecPtr^.FuncTree, SizeOf(TcxStackItem), 0);
          FillChar(FuncRecPtr^.CalcResult, SizeOf(TcxStackItem), 0);}
        end;
        GetBuf(DataType, SizeOf(DataType));
        if DataType = dtDateTime then
          GetBuf(DateTime, SizeOf(DateTime))
        else
          if DataType = dtFunction then
          begin
            if FuncRecPtr = nil then
            begin
              New(FuncRecPtr);
              FillChar(FuncRecPtr^, SizeOf(TcxSSFuncRec), 0);
              FuncRecPtr^.Col := ACol;
              FuncRecPtr^.Row := ARow;
              FuncRecPtr^.Page := FPages.IndexOf(ASheet);
            end;
            with FuncRecPtr^ do
            begin
              States := fsSource;
              GetBuf(FuncRecPtr^.FuncTree.Size, SizeOf(FuncRecPtr^.FuncTree.Size));
              GetMem(FuncRecPtr^.FuncTree.Tokens, FuncRecPtr^.FuncTree.Size);
              GetBuf(FuncRecPtr^.FuncTree.Tokens^, FuncRecPtr^.FuncTree.Size);
            end;
            FFormulasCache.Add(FuncRecPtr);
            IsFuncValid := FFormulasCache.ValidateRef(FuncRecPtr);
            FFormulasCache.UpdateExternalLinks(FuncRecPtr, DR, DC);
            Text := FFormulasCache.FuncHandler.TokensToString(FuncRecPtr);
          end;
        if DataType <> dtFunction then
          Text := GetString;
      finally
        TcxDataStorageAccess(ASheet.DataStorage).SetCellRec(ACol, ARow, ACell);
        if not IsFuncValid then
          TcxDataStorageAccess(ASheet.DataStorage).SetCellTextEx(ACol, ARow, scxRefError);
      end;
    end;
  end;

var
  S, S1: AnsiString;
  R: TRect;
  ALen, APos: Integer;
  DX, DY, I, J: Integer;
  MergedCells: TcxSSRectsArray;
begin
  S := cxSSClipboard.DataAsEssFormat;
  Result := Length(S) > 0;
  if Result then
  try
    APos := 1;
    Move(S[1], R, SizeOf(R));
    Inc(APos, SizeOf(R));
    DX := R.Right - R.Left;
    DY := R.Bottom - R.Top;
    with TcxDataStorageAccess(ASheet.DataStorage).MergedCells do
      Result := IntersectMerge(Rect(AColPos, ARowPos, AColPos + DX + 1, ARowPos + DY + 1));
    if Result then
      raise ESpreadSheetError.Create(cxGetResourceString(@scxChangePartOfMergeCells))
    else
      Result := True;
    ALen := PInteger(@S[APos])^;
    Inc(APos, SizeOf(Integer));
    if ALen > 0 then
    begin
      SetLength(MergedCells, ALen);
      Move(S[APos], MergedCells[0], ALen * SizeOf(TRect));
      for I := 0 to ALen - 1 do
        OffsetRect(MergedCells[I], AColPos - R.Left, ARowPos - R.Top);
      Inc(APos, ALen shl 4);
    end;
    DC := AColPos - R.Left;
    DR := ARowPos - R.Top;
    for I := AColPos to AColPos + DX do
    begin
      for J := ARowPos to ARowPos + DY do
      begin
        Move(S[APos], ALen, SizeOf(ALen));
        Inc(APos, SizeOf(ALen));
        if (ALen + APos) < Length(S) then
        begin
          if ALen > 0 then
          begin
            SetLength(S1, ALen);
            Move(S[APos], S1[1], ALen);
            SetCellData(I, J, S1);
          end;
          Inc(APos, ALen);
        end
        else
          Break;
      end;
    end;
    AChangedRect := Rect(AColPos, ARowPos, AColPos + DX,  ARowPos + DY);
   for I := 0 to Length(MergedCells) - 1 do
     with MergedCells[I] do
       ASheet.SetMergedState(Rect(Left, Top, Right - 1, Bottom - 1), True);
  finally
    with TcxDataStorageAccess(ASheet.DataStorage) do
    begin
      if CheckInMergeRange(Point(AColPos, ARowPos), R) then
        SelectionRect := R;
    end;
  end;
end;

function TcxCustomSpreadSheetBook.SpreadSheetDataToClipboardData(
  ASheet: TcxSSBookSheet; const ACells: TRect): AnsiString;

  function GetCellData(ACol, ARow: Integer): AnsiString;
  var
    ADataSize: Integer;
    ACapacity: Integer;
    APtr: PByteArray;
  const
    Null: Integer = 0;

    procedure ReallocBuf(NeedSize: Integer);
    begin
      while (ADataSize + NeedSize) >= ACapacity do
        Inc(ACapacity, 2048);
      ReallocMem(APtr, ACapacity);
    end;

    procedure WriteBuf(const Buf; ASize: Integer; WriteSize: Boolean = False);
    begin
      if WriteSize then
      begin
        ReallocBuf(SizeOf(Integer));
        Move(ASize, APtr^[ADataSize], SizeOf(Integer));
        Inc(ADataSize, SizeOf(Integer));
      end;
      ReallocBuf(ASize);
      if ASize <> 0 then
      begin
        Move(Buf, APtr^[ADataSize], ASize);
        Inc(ADataSize, ASize);
      end;
    end;

  begin
    with ASheet.DataStorage[ACol, ARow] do
    begin
      ADataSize := 0;
      ACapacity := 0;
      APtr := nil;
      try
        with StylePtr^ do
        begin
          WriteBuf(FormatIndex, SizeOf(FormatIndex));
          WriteBuf(HorzAlign, SizeOf(HorzAlign));
          WriteBuf(VertAlign, SizeOf(VertAlign));
          WriteBuf(WordBreak, SizeOf(WordBreak));
          WriteBuf(ShrinkToFit, SizeOf(ShrinkToFit));
          WriteBuf(BrushStyle, SizeOf(BrushStyle));
          WriteBuf(BrushFgColor, SizeOf(BrushFgColor));
          WriteBuf(BrushBkColor, SizeOf(BrushBkColor));
          with FontPtr^ do
          begin
            WriteBuf(Name[1], Length(Name) * SizeOf(Char), True);
            WriteBuf(FontColor, SizeOf(FontColor));
            WriteBuf(Style, SizeOf(Style));
            WriteBuf(Charset, SizeOf(Charset));
            WriteBuf(Size, SizeOf(Size));
          end;
          WriteBuf(Borders, SizeOf(Borders));
          WriteBuf(CellState, SizeOf(TcxSSCellStates));
        end;
        WriteBuf(DataType, SizeOf(DataType));
        if DataType = dtDateTime then
          WriteBuf(DateTime, SizeOf(DateTime))
        else
          if (DataType = dtFunction) and (FuncRecPtr <> nil) and (FuncRecPtr^.FuncTree.Size <> 0) then
          begin
            WriteBuf(FuncRecPtr^.FuncTree.Size, SizeOf(FuncRecPtr^.FuncTree.Size));
            WriteBuf(FuncRecPtr^.FuncTree.Tokens^, FuncRecPtr^.FuncTree.Size);
          end;
         if Length(Text) > 0 then
           WriteBuf(Text[1], Length(Text) * SizeOf(Char), True)
         else
           WriteBuf(Null, SizeOf(Integer));
      finally
        SetLength(Result, ADataSize + SizeOf(Integer));
        Move(ADataSize, Result[1], SizeOf(Integer));
        Move(APtr^, Result[5], ADataSize);
        FreeMem(APtr);
      end;
    end;
  end;

var
  I, J: Integer;
  MergedCells: TcxSSRectsArray;
begin
  with TcxDataStorageAccess(ASheet.DataStorage).MergedCells do
    MergedCells := IntersectMergedCells(Rect(ACells.Left, ACells.Top, ACells.Right + 1, ACells.Bottom + 1));
  SetLength(Result, SizeOf(Integer) + (Length(MergedCells) + 1) * SizeOf(TRect));
  Move(ACells, Result[1], SizeOf(ACells));
  PInteger(@Result[1 + SizeOf(ACells)])^ := Length(MergedCells);
  if Length(MergedCells) > 0 then
    Move(MergedCells[0], Result[5 + SizeOf(ACells)], Length(MergedCells) * SizeOf(TRect));
  TcxHistoryAccess(History).BeginUpdate;
  try
    for I := ACells.Left to ACells.Right do
      for J := ACells.Top to ACells.Bottom do
        Result := Result + GetCellData(I, J);
  finally
    TcxHistoryAccess(History).EndUpdate;
  end;
end;

procedure TcxCustomSpreadSheetBook.VisibleChanging;
begin
  inherited;
  UpdateControl;
  AdjustControls;
end;

procedure TcxCustomSpreadSheetBook.SetModified;
begin
  FModified := True;
end;

function TcxCustomSpreadSheetBook.ViewInfoValid: Boolean;
begin
  Result := (PageCount > 0) and ActiveSheet.ViewInfoValid;
end;

procedure TcxCustomSpreadSheetBook.SetRowHeaderWidth(const AValue: Integer);
begin
  if (AValue = FRowHeaderWidth) or (AValue <= 0) then Exit;
  FRowHeaderWidth := AValue;
  if ViewInfoValid then
    ActiveSheet.ViewInfo.UpdateViewInfo;
end;

procedure TcxCustomSpreadSheetBook.SetSelectionColor(const AValue: TColor);
begin
  if FSelectionColor = AValue then Exit;
  FSelectionColor := AValue;
  Canvas.SelectionColor := Canvas.GetNativeColor(FSelectionColor);
  if not Listener.IsLocked then
    Invalidate;
end;

procedure TcxCustomSpreadSheetBook.SetScrollBars(const AValue: TcxScrollBars);
const
  AVisibleState: array[TcxScrollBars, 0..1] of Boolean =
    ((False, False), (True, False), (False, True), (True, True));
begin
  if AValue <> FScrollBars then
  begin
    FScrollBars := AValue;
    AdjustControls;
    if not Listener.IsLocked then
      InvalidateRect(Rect(0, Height - Max(FCaptionBar.Height, HScrollBar.Height),
        Width, Height), False);
  end;
end;

procedure TcxCustomSpreadSheetBook.SetShowCaptionBar(const AValue: Boolean);
begin
  if FShowCaptionBar = AValue then Exit;
  FShowCaptionBar := AValue;
  FCaptionBar.Visible := AValue;
  if AValue then
    FCaptionBar.RecalcViewInfo;
  AdjustControls;
end;

procedure TcxCustomSpreadSheetBook.SetShowFormulas(const AValue: Boolean);
var
  I: Integer;
begin
  if FShowFormulas = AValue then Exit;
  FShowFormulas := AValue;
  for I := 0 to PageCount - 1 do
    Pages[I].ShowFormulas := AValue;
end;

procedure TcxCustomSpreadSheetBook.SetShowHeaders(const AValue: Boolean);
var
  I: Integer;
begin
  for I := 0 to PageCount - 1 do
    Pages[I].FShowHeaders := AValue;
  if ViewInfoValid then
    ActiveSheet.ViewInfo.UpdateViewInfo;
end;

procedure TcxCustomSpreadSheetBook.SetSelection(const AValue: TRect);
begin
  ActiveSheet.SelectionRect := AValue;
end;

procedure TcxCustomSpreadSheetBook.SetShowGrid(const AValue: Boolean);
var
  I: Integer;
begin
  FShowGrid := AValue;
  for I := 0 to PageCount - 1 do
    Pages[I].ShowGrid := AValue;
end;

procedure TcxCustomSpreadSheetBook.CM_CHANGELOCALE(var Message: TMessage);
begin
  inherited;
  if IsWinNT then
    dxFormatSettings.CurrencyString := GetLocaleStrW(GetThreadLocale, LOCALE_SCURRENCY);
  GetFormatSettings;
  SetControlCodes;
  UpdateControl;
end;

{ TcxSpreadSheetBook }
constructor TcxSpreadSheetBook.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AddSheetPage;
end;

procedure TcxSpreadSheetBook.AddSheetPage(const APageName: string = '');
begin
  inherited;
end;

procedure TcxSpreadSheetBook.EditActiveSheetCaption;
begin
  FCaptionBar.DoEditCaption;
end;

procedure TcxSpreadSheetBook.ExchangeSheets(const ASheet1, ASheet2: Integer);
var
  ACanExchange: Boolean;
begin
  if (ASheet1 > PageCount) or (ASheet2 > PageCount) then Exit;
  if Assigned(FOnExchangeSheets) then
  begin
    ACanExchange := True;
    FOnExchangeSheets(ASheet1, ASheet2, ACanExchange);
    if not ACanExchange then Exit;
  end;
  FPages.Exchange(ASheet1, ASheet2);
  if ASheet1 = FActivePage then
    FActivePage := ASheet2
  else
    if ASheet2 = FActivePage then
      FActivePage := ASheet1;
  FormulasCache.UpdateOnExchangeSheets(ASheet1, ASheet2);
  FCaptionBar.ReCalcViewInfo;
  FCaptionBar.Invalidate;
  Recalc;
end;

procedure TcxSpreadSheetBook.DeleteSheet(const ASheet: Integer);
var
  ACanDelete: Boolean;
  AIndex, I: Integer;
begin
  if (ASheet >= PageCount) or (ASheet < 0) or (PageCount = 1) then Exit;
  if Assigned(FOnDeleteSheet) then
  begin
    ACanDelete := True;
    FOnDeleteSheet(ASheet, ACanDelete);
    if not ACanDelete then Exit;
  end;

  AIndex := -1;
  for I := PageCount - 1 downto 0 do
  begin
    if ((AIndex < 0) or (AIndex > ASheet)) and (I <> ASheet) and PageVisible[I] then
      AIndex := I;
  end;
  if AIndex = -1 then
    raise ESpreadSheetError.Create(cxGetResourceString(@scxSpreadSheetDeleteLastSheet));

  SetActivePage(AIndex);
  if FActivePage > ASheet then
    Dec(FActivePage);

  TcxSSBookSheet(FPages[ASheet])._Release;
  FPages.Delete(ASheet);
  if ASheet < PageCount then
    System.Move(FPageVisible[ASheet + 1], FPageVisible[ASheet],
      (PageCount - ASheet) * SizeOf(Boolean));
  SetLength(FPageVisible, Length(FPageVisible) - 1);
  FormulasCache.UpdateOnDeleteSheet(ASheet);
  if FCaptionBar.FirstVisibleCaption >= PageCount then
    FCaptionBar.FirstVisibleCaption :=  PageCount - 1;
  FCaptionBar.ReCalcViewInfo;
  UpdateControl;
end;

{ TcxSpreadSheet }
constructor TcxSpreadSheet.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ShowCaptionBar := False;
  AddSheetPage;
end;

function TcxSpreadSheet.GetSheet: TcxSSBookSheet;
begin
  Result := ActiveSheet;
end;

{ TcxSSClipboard }
function TcxSSClipboard.GetESSData: AnsiString;
begin
  SetLength(Result, BufferSize(CF_ESSDATA));
  if Length(Result) > 0 then
    GetBuffer(CF_ESSDATA, Result[1]);
end;

function TcxSSClipboard.GetUnicodeData: WideString;
begin
  if BufferSize(CF_UNICODETEXT) <> 0 then
  begin
    SetLength(Result, BufferSize(CF_UNICODETEXT) shr 1 - 1);
    GetBuffer(CF_UNICODETEXT, Result[1]);
  end
  else
    Result := ClipBoard.AsText;
  if (Result <> '') then
  begin
    case Result[Length(Result)] of
      #13, #10:;
    else
      Result := Result + #13#10;
    end;
  end;
end;

procedure TcxSSClipboard.SetESSData(const Value: AnsiString);
begin
  if Value <> '' then
  begin
      SetBuffer(CF_ESSDATA, Value[1], Length(Value) + 1, True);
  end;
end;

procedure TcxSSClipboard.SetUnicodeData(const Value: WideString);
begin
  if Value <> '' then
  begin
    SetBuffer(CF_UNICODETEXT, Value[1], (Length(Value) + 1) shl 1, False);
  end;
end;

function TcxSSClipboard.BufferSize(AFormat: Word): Integer;
var
  AData: THandle;
  ADataPtr: Pointer;
begin
  Result := 0;
  if not OpenClipboard(Application.Handle) then Exit;
  try
    AData := GetClipboardData(AFormat);
    if AData = 0 then Exit;
    ADataPtr := GlobalLock(AData);
    if ADataPtr = nil then Exit;
    try
      Result := GlobalSize(AData);
    finally
      GlobalUnlock(AData);
    end;
  finally
    CloseClipboard;
  end;
end;

procedure TcxSSClipboard.GetBuffer(AFormat: Word; var ABuffer);
var
  Data: THandle;
  DataPtr: Pointer;
begin
  if not OpenClipboard(Application.Handle) then Exit;
  try
    Data := GetClipboardData(AFormat);
    if Data = 0 then Exit;
    DataPtr := GlobalLock(Data);
    if DataPtr = nil then Exit;
    try
      Move(DataPtr^, ABuffer, GlobalSize(Data));
    finally
      GlobalUnlock(Data);
    end;
  finally
    CloseClipboard;
  end;
end;

procedure TcxSSClipboard.SetBuffer(AFormat: Word; const ABuffer; ASize: Integer;
  ClearClipboard: Boolean);
var
  Data: THandle;
  DataPtr: Pointer;
begin
  if not OpenClipboard(Application.Handle) then Exit;
  try
    if ClearClipBoard then
      EmptyClipboard;
    if ASize > 0 then
    begin
      Data := GlobalAlloc(GMEM_MOVEABLE + GMEM_DDESHARE, ASize);
      try
        DataPtr := GlobalLock(Data);
        try
          Move(ABuffer, DataPtr^, ASize);
          SetClipboardData(AFormat, Data);
        finally
          GlobalUnlock(Data);
        end;
      except
        GlobalFree(Data);
        raise;
      end;
    end;
  finally
    CloseClipBoard;
  end;
end;

{ procedure SaveBiffToFile;
  var
    Data: Integer;
    DataPtr: Pointer;
    AFormat, I: Integer;
    Name: array[0..255] of Char;
    F: File;
  begin
    OpenClipboard(0);
    try
      for I := 0 to CountClipboardFormats - 1 do
      begin
        AFormat := EnumClipBoardFormats(I);
        GetClipBoardFormatName(AFormat, Name, Sizeof(Name));
        if Name = 'Biff8' then
        begin
          Data := GetClipboardData(AFormat);
          if Data = 0 then Exit;
          DataPtr := GlobalLock(Data);
          if DataPtr = nil then Exit;
          try
            AssignFile(F, 'C:\BinaryClipboard.xls');
            Rewrite(F, 1);
            BlockWrite(F, DataPtr^, GlobalSize(Data));
            CloseFile(F);
          finally
            GlobalUnlock(Data);
          end;
        end;
      end;
    finally
      CloseClipboard;
    end;
  end;}

initialization
  CF_ESSDATA := RegisterClipboardFormat(SCF_ESSCLIPBOARDFORMAT);
  if IsWinNT then
    dxFormatSettings.CurrencyString := GetLocaleStrW(GetThreadLocale, LOCALE_SCURRENCY);
  cxSSClipboard := TcxSSClipboard.Create;
  if Screen.Cursors[crSSSelect] = Screen.Cursors[crDefault] then
    Screen.Cursors[crSSSelect] := LoadCursor(HInstance, 'CR_SELECT');
  if IsWinNT then
    dxFormatSettings.CurrencyString := GetLocaleStrW(GetThreadLocale, LOCALE_SCURRENCY);
  cxHScrollHeight := GetSystemMetrics(SM_CYHSCROLL);
  cxVScrollWidth := GetSystemMetrics(SM_CXVSCROLL);

finalization
  cxSSClipboard.Free;

end.
