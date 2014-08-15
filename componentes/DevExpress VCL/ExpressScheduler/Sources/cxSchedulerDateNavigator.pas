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

unit cxSchedulerDateNavigator;

{$I cxVer.Inc}

interface

uses
{$IFDEF DELPHI6}
  Types,
{$ELSE}
  MultiMon,
{$ENDIF}
  Windows, SysUtils, Classes, Controls, Graphics, ExtCtrls,
  cxSchedulerCustomControls, cxSchedulerUtils, cxContainer, cxClasses,
  cxGraphics, cxLookAndFeelPainters, cxStyles, cxControls, cxDateUtils;

const
  // hit test codes
  htcCalendar         = 2;
  htcDayCaptions      = 3;
  htcMonthName        = 4;
  htcNextMonth        = 5;
  htcPrevMonth        = 6;
  htcWeekSelectionBar = 7;

  // style indexes
  cxdnBackground       = 0;
  cxdnContent          = 1;
  cxdnHeader           = 2;
  cxdnSelection        = 3;
  //for PS
  cxcsDateNavigatorFirst = cxdnBackground;
  cxcsDateNavigatorLast = cxdnSelection;

  cxDaysCalendarMaxColCount = 8;
  cxMaxMonthViewInfoDays    = 6 * 7;
  cxMaxWeekCount       = 6;

type
  TcxSchedulerDateNavigatorDayNumberViewInfo = class;
  TcxSchedulerDateNavigatorMonthHeaderViewInfo = class;
  TcxSchedulerDateNavigatorMonthContentViewInfo = class;
  TcxSchedulerDateNavigatorMonthViewInfo = class;
  TcxSchedulerDateNavigatorViewInfo = class;
  TcxSchedulerDateNavigator = class;
  TcxSchedulerDateNavigatorViewInfoClass = class of TcxSchedulerDateNavigatorViewInfo;

  { TcxSchedulerDateNavigatorPainter }

  TcxSchedulerDateNavigatorPainter = class(TcxSchedulerSubControlPainter)
  private
    FHeaderParams: TcxViewParams; //for callback procedure
    FDateNavigator: TcxSchedulerDateNavigator;
    FHeaderTransparent: Boolean;
    procedure CheckDrawFrame(const ABounds: TRect; ADate: TDateTime);
    function DrawHeaderBackground(ACanvas: TcxCanvas; const ABounds: TRect): Boolean;
  protected
    procedure DoDrawDayCaptions(AViewInfo: TcxSchedulerDateNavigatorMonthContentViewInfo); virtual;
    procedure DoDrawDayNumbers(AViewInfo: TcxSchedulerDateNavigatorMonthContentViewInfo); virtual;
    procedure DoDrawMonthContent(AViewInfo: TcxSchedulerDateNavigatorMonthContentViewInfo); virtual;
    procedure DoDrawMonthHeader(AViewInfo: TcxSchedulerDateNavigatorMonthHeaderViewInfo); virtual;
    procedure DrawBackground; virtual;
    procedure DrawDayNumber(ADayInfo: TcxSchedulerDateNavigatorDayNumberViewInfo);
    procedure DrawMonthHeader(AViewInfo: TcxSchedulerDateNavigatorMonthHeaderViewInfo); virtual;
    procedure DrawSeparators(AViewInfo: TcxSchedulerDateNavigatorMonthContentViewInfo); virtual;
    procedure DrawWeekNumbers(AViewInfo: TcxSchedulerDateNavigatorMonthContentViewInfo); virtual;
    property DateNavigator: TcxSchedulerDateNavigator read FDateNavigator;
  public
    constructor Create(AOwner: TcxSchedulerSubControl); override;
    procedure Paint; override;
  end;

  TcxSchedulerDateNavigatorPainterClass = class of TcxSchedulerDateNavigatorPainter;

  { TcxSchedulerDateNavigatorCaptionViewInfo }

  TcxSchedulerDateNavigatorCaptionViewInfo = class
  private
    FBounds: TRect;
    FSaveParams: TcxViewParams;
    FText: string;
    FTransparent: Boolean;
    FViewParams: TcxViewParams;
  protected
    procedure RestoreParams;
    procedure SaveParams(ATransparent: Boolean);

    property Text: string read FText write FText;
    property Transparent: Boolean read FTransparent write FTransparent;
  public
    property Bounds: TRect read FBounds;
    property ViewParams: TcxViewParams read FViewParams write FViewParams;
  end;

  { TcxSchedulerDateNavigatorDayNumberViewInfo }

  TcxSchedulerDateNavigatorDayNumberViewInfo = class(TcxSchedulerDateNavigatorCaptionViewInfo)
  private
    FBold: Boolean;
    FDate: TDateTime;
    FGrayed: Boolean;
    FSelected: Boolean;
    FSelectionSideBounds: TRect;
  public
    property Bold: Boolean read FBold write FBold;
    property Bounds;
    property Date: TDateTime read FDate;
    property Grayed: Boolean read FGrayed;
    property Selected: Boolean read FSelected;
    property SelectionSideBounds: TRect read FSelectionSideBounds;
    property Text;
    property Transparent;
    property ViewParams;
  end;

  { TcxSchedulerDateNavigatorDayCaptionViewInfo }

  TcxSchedulerDateNavigatorDayCaptionViewInfo = class(TcxSchedulerDateNavigatorCaptionViewInfo)
  private
    FIndex: Byte;
  public
    property Bounds;
    property Index: Byte read FIndex;
    property Text;
    property Transparent;
    property ViewParams;
  end;

  { TcxSchedulerDateNavigatorMonthHeaderViewInfo }

  TcxSchedulerDateNavigatorMonthHeaderViewInfo = class(TcxSchedulerDateNavigatorCaptionViewInfo)
  private
    FArrows: TcxHeaderArrows;
    FNeighbors: TcxNeighbors;
    FOwner: TcxSchedulerDateNavigatorMonthViewInfo;
    FMonthNameBounds: TRect;
    function GetMonth: Integer;
    function GetMonthNameBounds: TRect;
    function GetYear: Integer;
  protected
    procedure Calculate(const ABounds: TRect); virtual;
  public
    constructor Create(AOwner: TcxSchedulerDateNavigatorMonthViewInfo);
    property Arrows: TcxHeaderArrows read FArrows;
    property Bounds;
    property Month: Integer read GetMonth;
    property Neighbors: TcxNeighbors read FNeighbors;
    property MonthNameBounds: TRect read FMonthNameBounds;
    property Owner: TcxSchedulerDateNavigatorMonthViewInfo read FOwner;
    property Text;
    property Transparent;
    property ViewParams;
    property Year: Integer read GetYear;
  end;

  { TcxSchedulerDateNavigatorMonthContentViewInfo }

  TcxSchedulerDateNavigatorMonthContentViewInfo = class
  private
    FBounds: TRect;
    FCol: Integer;
    FRow: Integer;
    FDateNavigator: TcxSchedulerDateNavigator;
    FDays: array[0..cxMaxMonthViewInfoDays - 1] of TcxSchedulerDateNavigatorDayNumberViewInfo;
    FDayCount: Integer;
    FDayCaptions: array[0..6] of TcxSchedulerDateNavigatorDayCaptionViewInfo;
    FFont: TFont;
    FFontCharset: TFontCharset;
    FHorzSeparatorBound: TRect;
    FMonth: Integer;
    FOwner: TcxSchedulerDateNavigatorMonthViewInfo;
    FSaveParams: TcxViewParams;
    FSelectedParams: TcxViewParams;
    FTransparent: Boolean;
    FVertSeparatorBound: TRect;
    FViewInfo: TcxSchedulerDateNavigatorViewInfo;
    FViewParams: TcxViewParams;
    FWeekBounds: array[0..5] of TRect;
    FWeekCount: Integer;
    FWeekTexts: array[0..5] of string;
    FWeekSelectionBarBounds: TRect;
    FYear: Integer;
    procedure CreateDayInfos;
    procedure CreateDayCaptionInfos;
    procedure DestroyDayInfos;
    procedure DestroyDayCaptionInfos;
    function GetDayCaptionInfo(Index: Byte): TcxSchedulerDateNavigatorDayCaptionViewInfo;
    function GetDayRectFromColAndRow(ACol, ARow: Integer): TRect;
    function GetDayNumberViewInfo(Index: Byte): TcxSchedulerDateNavigatorDayNumberViewInfo;
    function GetGrayed(ADate: TDateTime): Boolean;
    function GetSelectionSideBounds(const ADayBounds: TRect; ACol: Integer): TRect;
    function IsValidDayIndex(Index: Byte): Boolean;
    function IsValidDayCaptionIndex(Index: Byte): Boolean;
    function IsValidWeekIndex(Index: Byte): Boolean;
    procedure SetWeekText(Index: Byte; const Value: string);
  protected
    procedure CalcAndAddDayInfo(ADate: TDateTime; const ABounds: TRect;
      const ASelectionSideBounds: TRect);
    procedure Calculate(ACol, ARow, AYear, AMonth: Integer); virtual;
    procedure CalcDays; virtual;
    procedure CalcDayCaptions; virtual;
    procedure CalcParams; virtual;
    procedure CalcSeparatorsBound; virtual;
    function GetDateViewParams(ADate: TDateTime; ASelected: Boolean): TcxViewParams; virtual;
    function GetDayText(ADate: TDateTime): string; virtual;
    function GetDayCaptionText(Index: Byte): string; virtual;
    function GetWeekBound(Index: Byte): TRect; virtual;
    function GetWeekText(Index: Byte): string; virtual;
    procedure RestoreParams;
    procedure SaveParams;
    procedure UpdateElementsAfterCustomDraw(ACanvas: TcxCanvas);

    property DateNavigator: TcxSchedulerDateNavigator read FDateNavigator;
    property Font: TFont read FFont;
    property FontCharset: TFontCharset read FFontCharset;
    property Owner: TcxSchedulerDateNavigatorMonthViewInfo read FOwner;
    property ViewInfo: TcxSchedulerDateNavigatorViewInfo read FViewInfo;
    property WeekSelectionBarBounds: TRect read FWeekSelectionBarBounds;
  public
    constructor Create(AOwner: TcxSchedulerDateNavigatorMonthViewInfo); virtual;
    destructor Destroy; override;

    property Bounds: TRect read FBounds;
    property Col: Integer read FCol;
    property DayCount: Integer read FDayCount;
    property Days[Index: Byte]: TcxSchedulerDateNavigatorDayNumberViewInfo read GetDayNumberViewInfo;
    property DayCaptions[Index: Byte]: TcxSchedulerDateNavigatorDayCaptionViewInfo read GetDayCaptionInfo;
    property HorzSeparatorBound: TRect read FHorzSeparatorBound;
    property Month: Integer read FMonth;
    property Row: Integer read FRow;
    property SelectedParams: TcxViewParams read FSelectedParams;
    property Transparent: Boolean read FTransparent write FTransparent;
    property VertSeparatorBound: TRect read FVertSeparatorBound;
    property ViewParams: TcxViewParams read FViewParams;
    property WeekCount: Integer read FWeekCount;
    property WeekBounds[Index: Byte]: TRect read GetWeekBound;
    property WeekTexts[Index: Byte]: string read GetWeekText write SetWeekText;
    property Year: Integer read FYear;
  end;

  { TcxSchedulerDateNavigatorMonthViewInfo }

  TcxSchedulerDateNavigatorMonthViewInfo = class
  private
    FBounds: TRect;
    FCol: Integer;
    FRow: Integer;
    FContent: TcxSchedulerDateNavigatorMonthContentViewInfo;
    FHeader: TcxSchedulerDateNavigatorMonthHeaderViewInfo;
    FMonth: Integer;
    FOwner: TcxSchedulerDateNavigatorViewInfo;
    FYear: Integer;
  protected
    procedure Calculate(ACol, ARow, AYear, AMonth: Integer); virtual;
    function GetHeaderArrows: TcxHeaderArrows;
    function GetHeaderNeighbors: TcxNeighbors;

    property Owner: TcxSchedulerDateNavigatorViewInfo read FOwner;
  public
    constructor Create(AOwner: TcxSchedulerDateNavigatorViewInfo); virtual;
    destructor Destroy; override;

    property Bounds: TRect read FBounds;
    property Col: Integer read FCol;
    property Content: TcxSchedulerDateNavigatorMonthContentViewInfo read FContent;
    property Header: TcxSchedulerDateNavigatorMonthHeaderViewInfo read FHeader;
    property Month: Integer read FMonth;
    property Row: Integer read FRow;
    property Year: Integer read FYear;
  end;

  { TcxSchedulerDateNavigatorViewInfo }

  TcxSchedulerDateNavigatorViewInfo = class(TcxSchedulerSubControlViewInfo)
  private
    FCalendarBounds: TRect;
    FColCount: Integer;
    FColWidth: Integer;
    FContentParams: TcxViewParams;
    FDayCaptionsHeight: Integer;
    FHeaderBorderSize: Integer;
    FHeaderHeight: Integer;
    FHeaderParams: TcxViewParams;
    FMonthSize: TSize;
    FMonthViewInfoList: TList;
    FOwner: TcxSchedulerDateNavigator;
    FRowCount: Integer;
    FRowHeight: Integer;
    FSelectedParams: TcxViewParams;
    FSideWidth: Integer;
    procedure DestroyMonthViewInfoList;
    function GetMonthViewInfo(ACol, ARow: Integer): TcxSchedulerDateNavigatorMonthViewInfo;
  protected
    procedure DoCalculate; override;
    procedure CalculateCalendarBounds;
    procedure CalculateMonthViewInfos;
    procedure CalculateViewParams;
    procedure CheckMonthViewInfoCount;
    function GetCol(X: Integer): Integer;
    function GetHeaderRect(ACol, ARow: Integer): TRect;
    function GetInternalRect(ACol, ARow: Integer): TRect;
    function GetLeftArrowRect: TRect;
    function GetMonthRect(ACol, ARow: Integer): TRect;
    function GetRightArrowRect: TRect;
    function GetRow(Y: Integer): Integer;
    procedure CalcInternalSizes;
    property CalendarBounds: TRect read FCalendarBounds;
    property ColCount: Integer read FColCount;
    property ColWidth: Integer read FColWidth;
    property ContentParams: TcxViewParams read FContentParams;
    property DayCaptionsHeight: Integer read FDayCaptionsHeight;
    property HeaderBorderSize: Integer read FHeaderBorderSize;
    property HeaderHeight: Integer read FHeaderHeight;
    property HeaderParams: TcxViewParams read FHeaderParams;
    property Owner: TcxSchedulerDateNavigator read FOwner;
    property RowCount: Integer read FRowCount;
    property RowHeight: Integer read FRowHeight;
    property SelectedParams: TcxViewParams read FSelectedParams;
    property SideWidth: Integer read FSideWidth;
  public
    constructor Create(AOwner: TcxSchedulerSubControl); override;
    destructor Destroy; override;
    property MonthSize: TSize read FMonthSize;
    property MonthViewInfo[ACol, ARow: Integer]: TcxSchedulerDateNavigatorMonthViewInfo read GetMonthViewInfo;
  end;

  { TcxSchedulerDateNavigatorStyles }

  TcxSchedulerDateNavigatorStyles = class(TcxStyles)
  private
    function GetDateNavigator: TcxSchedulerDateNavigator;
  protected
    procedure Changed(AIndex: Integer); override;
    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
    function GetBackgroundParams: TcxViewParams;
    function GetContentParams: TcxViewParams;
    function GetHeaderParams: TcxViewParams;
    function GetSelectionParams: TcxViewParams;
    property DateNavigator: TcxSchedulerDateNavigator read GetDateNavigator;
  published
    property Background: TcxStyle index cxdnBackground read GetValue write SetValue;
    property Content: TcxStyle index cxdnContent read GetValue write SetValue;
    property Header: TcxStyle index cxdnHeader read GetValue write SetValue;
    property Selection: TcxStyle index cxdnSelection read GetValue write SetValue;
  end;

  { TcxSchedulerDateNavigatorHitTest }

  TcxSchedulerDateNavigatorHitTest = class(TcxSchedulerSubControlHitTest)
  private
    FMonthViewInfo: TcxSchedulerDateNavigatorMonthViewInfo;
    function GetFirstWeekSelectableDate: TDateTime;
    function GetOwner: TcxSchedulerDateNavigator;
    function GetViewInfo: TcxSchedulerDateNavigatorViewInfo;
  protected
    procedure Clear; override;
    procedure DoCalculate; override;
    procedure CalcMonth; virtual;
    function CheckDayCaptions: Boolean;
    function CheckMonthHeader: Boolean;
    function CheckWeekSelectionBar: Boolean;

    property Owner: TcxSchedulerDateNavigator read GetOwner;
    property ViewInfo: TcxSchedulerDateNavigatorViewInfo read GetViewInfo;
  public
    property HitAtCalendar: Boolean index htcCalendar read GetBitState;
    property HitAtDayCaptions: Boolean index htcDayCaptions read GetBitState;
    property HitAtMonthName: Boolean index htcMonthName read GetBitState;
    property HitAtNextMonth: Boolean index htcNextMonth read GetBitState;
    property HitAtPrevMonth: Boolean index htcPrevMonth read GetBitState;
    property HitAtTime;
    property HitAtWeekSelectionBar: Boolean index htcWeekSelectionBar read GetBitState;
    property MonthViewInfo: TcxSchedulerDateNavigatorMonthViewInfo read FMonthViewInfo;
    property Time;
  end;

  { TcxSchedulerDateNavigatorController }

  TcxSchedulerDateNavigatorController = class(TcxSchedulerSubControlController)
  private
    FDragDate: TDateTime;
    FExtSelect: Boolean;
    FIgnoreMouseMove: Boolean;
    FSaveSelectionIsWeeks: Boolean;
    FSaveSelectionList: TcxSchedulerDateList;
    FSelFinish: TDateTime;
    FSelStart: TDateTime;
    FSingleSelection: Boolean;
    FTimer: TTimer;
    FUnselect: Boolean;
    function GetHitTest: TcxSchedulerDateNavigatorHitTest;
    function GetOwner: TcxSchedulerDateNavigator;
    function GetViewInfo: TcxSchedulerDateNavigatorViewInfo;
    procedure SetDragDate(const Value: TDateTime);
    procedure StartTimer(AFuture: Boolean);
    procedure StopTimer;
    procedure TimerProc(Sender: TObject);
  protected
    //overriden
    procedure DoCancelMode; override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
    function GetCursor(X, Y: Integer): TCursor; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseLeave; override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    //methods
    procedure CalculateSelection(AConcatenate: Boolean); virtual;
    procedure ProcessSelectionOnMouseDown(AShift: TShiftState);
    procedure ProcessSelectionOnMouseMove(AShift: TShiftState);
    property HitTest: TcxSchedulerDateNavigatorHitTest read GetHitTest;
    property Owner: TcxSchedulerDateNavigator read GetOwner;
    property ViewInfo: TcxSchedulerDateNavigatorViewInfo read GetViewInfo;
  public
    constructor Create(AOwner: TcxSchedulerSubControl); override;
    destructor Destroy; override;
    property DragDate: TDateTime read FDragDate write SetDragDate;
  end;

  TcxSchedulerPeriodChangedEvent = procedure(Sender: TObject;
    const AStart, AFinish: TDateTime) of object;

  TcxSchedulerDateNavigatorCustomDrawBackgroundEvent = procedure (Sender: TObject;
    ACanvas: TcxCanvas; const ABounds: TRect; var AViewParams: TcxViewParams;
    var ADone: Boolean) of object;
  TcxSchedulerDateNavigatorCustomDrawDayNumberEvent = procedure (Sender: TObject;
    ACanvas: TcxCanvas; AViewInfo: TcxSchedulerDateNavigatorDayNumberViewInfo;
    var ADone: Boolean) of object;
  TcxSchedulerDateNavigatorCustomDrawDayCaptionEvent = procedure (Sender: TObject;
    ACanvas: TcxCanvas; AViewInfo: TcxSchedulerDateNavigatorDayCaptionViewInfo;
    var ADone: Boolean) of object;
  TcxSchedulerDateNavigatorCustomDrawContentEvent = procedure (Sender: TObject;
    ACanvas: TcxCanvas; AViewInfo: TcxSchedulerDateNavigatorMonthContentViewInfo;
    var ADone: Boolean) of object;
  TcxSchedulerDateNavigatorCustomDrawHeaderEvent = procedure (Sender: TObject;
    ACanvas: TcxCanvas; AViewInfo: TcxSchedulerDateNavigatorMonthHeaderViewInfo;
    var ADone: Boolean) of object;

  TcxSchedulerDateNavigator = class(TcxSchedulerCustomDateNavigator)
  private
    FActualFirstWeekOfYear: TcxFirstWeekOfYear;
    FColCount: Integer;
    FFirstDate: TDateTime;
    FFirstWeekOfYear: TcxFirstWeekOfYear;
    FLastDate: TDateTime;
    FListBox: TcxCustomPopupWindow;
    FListBoxDelta: Integer;
    FRealFirstDate: TDateTime;
    FRealLastDate: TDateTime;
    FRowCount: Integer;
    FSelectionIsWeeks: Boolean;
    FSelectPeriod: Boolean;
    FShowDatesContainingEventsInBold: Boolean;
    FShowWeekNumbers: Boolean;
    FStyles: TcxSchedulerDateNavigatorStyles;
    FToday: TDateTime;
    // custom draw
    FOnCustomDrawBackground: TcxSchedulerDateNavigatorCustomDrawBackgroundEvent;
    FOnCustomDrawContent: TcxSchedulerDateNavigatorCustomDrawContentEvent;
    FOnCustomDrawDayCaption: TcxSchedulerDateNavigatorCustomDrawDayCaptionEvent;
    FOnCustomDrawDayNumber: TcxSchedulerDateNavigatorCustomDrawDayNumberEvent;
    FOnCustomDrawHeader: TcxSchedulerDateNavigatorCustomDrawHeaderEvent;
    FOnPeriodChanged: TcxSchedulerPeriodChangedEvent;
    FOnSelectionChanged: TcxSchedulerPeriodChangedEvent;
    function GetActualFirstWeekOfYear: TcxFirstWeekOfYear;
    function GetController: TcxSchedulerDateNavigatorController;
    function GetDate: TDateTime;
    function GetHitTest: TcxSchedulerDateNavigatorHitTest;
    function GetLastDate: TDateTime;
    function GetViewInfo: TcxSchedulerDateNavigatorViewInfo;
    procedure SetColCount(Value: Integer);
    procedure SetDate(Value: TDateTime);
    procedure SetFirstWeekOfYear(Value: TcxFirstWeekOfYear);
    procedure SetRowCount(Value: Integer);
    procedure SetSelectPeriod(Value: Boolean);
    procedure SetShowDatesContainingEventsInBold(Value: Boolean);
    procedure SetShowWeekNumbers(Value: Boolean);
    procedure SetStyles(const Value: TcxSchedulerDateNavigatorStyles);
  protected
    IsLocked: Boolean;
    // store interface
    procedure GetProperties(AProperties: TStrings); override;
    procedure GetPropertyValue(const AName: string; var AValue: Variant); override;
    procedure SetPropertyValue(const AName: string; const AValue: Variant); override;
    //
    function AllowDesignHitTest(X, Y: Integer; Shift: TShiftState): Boolean; override;
    procedure CheckSizes; override;
    procedure CreateSubClasses; override;
    function CreateController: TcxSchedulerSubControlController; override;
    function CreateHitTest: TcxSchedulerSubControlHitTest; override;
    function CreatePainter: TcxSchedulerSubControlPainter; override;
    function CreateViewInfo: TcxSchedulerSubControlViewInfo; override;
    procedure DestroySubClasses; override;
    procedure DoLayoutChanged; override;
    //methods
    function CanDrawSelectionSide: Boolean;
    procedure CheckSelectionBounds; virtual;
    procedure DoSelectionChanged; virtual;
    procedure DoPeriodChangedEvent; override;
    procedure DoSelectionChangedEvent; override;
    procedure DoScrollSelection(AScrollDelta: Integer); override;
    procedure DoScrollSelection(AForward: Boolean;
      ANeedDate: TDateTime; AIsByPage: Boolean); override;
    procedure EnsureSelectionVisible;
    function IsDateSelected(ADate: TDateTime): Boolean; virtual;
    function IsDateHasEvent(ADate: TDateTime): Boolean; virtual;
    procedure FormatChanged; override;
    function GetMonthSize: TSize; override;
    function GetRealFirstDate: TDateTime; override;
    function GetRealLastDate: TDateTime; override;
    function GetShowDatesContainingEventsInBold: Boolean; override;
    procedure RefreshDays;
    procedure SetFirstDate(Value: TDateTime); virtual;
    procedure ShowMonthPopup(AMonthInfo: TcxSchedulerDateNavigatorMonthViewInfo); virtual;
    procedure StepToPast;
    procedure StepToFuture;
    procedure UpdateCalculatedValues; virtual;
    procedure UpdateDragging; override;
    procedure UpdateSelection; override;
    // support custom draw
    procedure AfterCustomDraw(ACanvas: TcxCanvas; var AParams: TcxViewParams); virtual;
    procedure BeforeCustomDraw(ACanvas: TcxCanvas; const AParams: TcxViewParams); virtual;
    function DoCustomDrawBackground(ACanvas: TcxCanvas;
      const ABounds: TRect; var AViewParams: TcxViewParams): Boolean; virtual;
    function DoCustomDrawDayNumber(ACanvas: TcxCanvas;
      ADayInfo: TcxSchedulerDateNavigatorDayNumberViewInfo): Boolean; virtual;
    function DoCustomDrawDayCaption(ACanvas: TcxCanvas;
      ADayCaptionInfo: TcxSchedulerDateNavigatorDayCaptionViewInfo): Boolean; virtual;
    function DoCustomDrawContent(ACanvas: TcxCanvas;
      AViewInfo: TcxSchedulerDateNavigatorMonthContentViewInfo): Boolean; virtual;
    function DoCustomDrawHeader(ACanvas: TcxCanvas;
      AViewInfo: TcxSchedulerDateNavigatorMonthHeaderViewInfo): Boolean; virtual;

    property Controller: TcxSchedulerDateNavigatorController read GetController;
    property ViewInfo: TcxSchedulerDateNavigatorViewInfo read GetViewInfo;
  public
    constructor Create(AOwner: TcxCustomScheduler); override;
    procedure SetIntegralSizes; override;

    property ActualFirstWeekOfYear: TcxFirstWeekOfYear read FActualFirstWeekOfYear;
    property Date: TDateTime read GetDate write SetDate;
    property FirstDate: TDateTime read FFirstDate write SetFirstDate;
    property HitTest: TcxSchedulerDateNavigatorHitTest read GetHitTest;
    property LastDate: TDateTime read FLastDate;
    property RealFirstDate: TDateTime read FRealFirstDate;
    property RealLastDate: TDateTime read FRealLastDate;
    property SelectionIsWeeks: Boolean read FSelectionIsWeeks write FSelectionIsWeeks;
    property SelectionList: TcxSchedulerDateList read GetSelection;
    property SelectPeriod: Boolean read FSelectPeriod write SetSelectPeriod;
  published
    property ColCount: Integer read FColCount write SetColCount default 1;
    property FirstWeekOfYear: TcxFirstWeekOfYear
      read FFirstWeekOfYear write SetFirstWeekOfYear default fwySystem;
    property RowCount: Integer read FRowCount write SetRowCount default 1;
    property ShowDatesContainingEventsInBold: Boolean
      read FShowDatesContainingEventsInBold write SetShowDatesContainingEventsInBold default True;
    property ShowWeekNumbers: Boolean read FShowWeekNumbers write SetShowWeekNumbers default True;
    property Styles: TcxSchedulerDateNavigatorStyles read FStyles write SetStyles;
    property Visible default True;

    property OnCustomDrawBackground: TcxSchedulerDateNavigatorCustomDrawBackgroundEvent
      read FOnCustomDrawBackground write FOnCustomDrawBackground;
    property OnCustomDrawDayCaption: TcxSchedulerDateNavigatorCustomDrawDayCaptionEvent
      read FOnCustomDrawDayCaption write FOnCustomDrawDayCaption;
    property OnCustomDrawDayNumber: TcxSchedulerDateNavigatorCustomDrawDayNumberEvent
      read FOnCustomDrawDayNumber write FOnCustomDrawDayNumber;
    property OnCustomDrawContent: TcxSchedulerDateNavigatorCustomDrawContentEvent
      read FOnCustomDrawContent write FOnCustomDrawContent;
    property OnCustomDrawHeader: TcxSchedulerDateNavigatorCustomDrawHeaderEvent
      read FOnCustomDrawHeader write FOnCustomDrawHeader;
    property OnPeriodChanged: TcxSchedulerPeriodChangedEvent read FOnPeriodChanged
      write FOnPeriodChanged;
    property OnSelectionChanged: TcxSchedulerPeriodChangedEvent read FOnSelectionChanged
      write FOnSelectionChanged;
  end;

implementation

uses
{$IFDEF DELPHI6}
  DateUtils,
{$ENDIF}
  cxGeometry, Forms, cxFormats, cxLibraryConsts;

const
  cxDateStartNavigatorTime = 400;
  cxDateNavigatorTime = 200;
  cxdnTextFlags = cxSingleLine + cxAlignVCenter + cxAlignRight;

var
  DayNames: array[1..7] of string;

procedure GetLocaleSettings;
var
  I: Integer;
begin
  for I := 1 to 7 do
    DayNames[I] := ShortDayNames[I][1];
end;

function Max(A, B: Integer): Integer;
begin
  if A > B then Result := A else Result := B;
end;

function Min(A, B: Integer): Integer;
begin
  if A < B then Result := A else Result := B;
end;

procedure DecMonth(var AYear, AMonth: Word);
begin
  if AMonth = 1 then
  begin
    Dec(AYear);
    AMonth := 12;
  end
  else Dec(AMonth);
end;

procedure IncMonth(var AYear, AMonth: Word);
begin
  if AMonth = 12 then
  begin
    Inc(AYear);
    AMonth := 1;
  end
  else Inc(AMonth);
end;

procedure ChangeMonth(var AYear, AMonth: Word; Delta: Integer);
var
  Month: Integer;
begin
  Inc(AYear, Delta div 12);
  Month := AMonth;
  Inc(Month, Delta mod 12);
  if Month < 1 then
  begin
    Dec(AYear);
    Month := 12 + Month;
  end;
  if Month > 12 then
  begin
    Inc(AYear);
    Month := Month - 12;
  end;
  AMonth := Month;
end;

function GetDateElement(ADate: TDateTime; Index: Integer): Integer;
var
  AYear, AMonth, ADay: Word;
begin
  DecodeDate(ADate, AYear, AMonth, ADay);
  case Index of
    1: Result := AYear;
    2: Result := AMonth;
    3: Result := ADay;
    else Result := -1;
  end;
end;

function DaysPerMonth(AYear, AMonth: Integer): Integer;
const
  DaysInMonth: array[1..12] of Integer =
    (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
begin
  Result := DaysInMonth[AMonth];
  if (AMonth = 2) and IsLeapYear(AYear) then Inc(Result);
end;

function CheckDay(AYear, AMonth, ADay: Integer): Integer;
begin
  if ADay < 1 then Result := 1
  else
    if ADay > DaysPerMonth(AYear, AMonth) then
      Result := DaysPerMonth(AYear, AMonth)
    else Result := ADay;
end;

function ColOfDate(ADate: TDateTime; StartOfWeek: TcxDayOfWeek): Integer;
begin
  Result := DayOfWeek(ADate) - StartOfWeek - 1;
  if Result < 0 then Inc(Result, 7);
end;

type

  { TcxSchedulerMonthListBox }

  TcxSchedulerMonthListBox = class(TcxCustomPopupWindow)
  private
    FOwner: TcxSchedulerDateNavigator;
    FOrigin: TPoint;
    FTopDate: TDateTime;
    FItemHeight: Integer;
    FItemIndex: Integer;
    FItems: TStrings;
    FTimer: TTimer;
    FSign: Integer;
    function GetDate: TDateTime;
    function GetViewInfo: TcxSchedulerDateNavigatorViewInfo;
    procedure SetItemIndex(Value: Integer);
    procedure SetTopDate(Value: TDateTime);
    procedure DoTimer(Sender: TObject);
  protected
    function CalculatePosition: TPoint; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DoShowed; override;
    procedure FontChanged;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure Paint; override;
    property ItemHeight: Integer read FItemHeight;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    property Items: TStrings read FItems;
    property Owner: TcxSchedulerDateNavigator read FOwner;
    property TopDate: TDateTime read FTopDate write SetTopDate;
    property ViewInfo: TcxSchedulerDateNavigatorViewInfo read GetViewInfo;
  public
    procedure BeforeDestruction; override;
    constructor Create(AOwner: TcxSchedulerDateNavigator); reintroduce;
    procedure CloseUp; override;
    procedure SetupMonth(R: TRect; ADate: TDateTime);
    property Date: TDateTime read GetDate;
  end;

function GetDesktopRect: TRect;
begin
{$IFDEF DELPHI6}
  Result := Screen.DesktopRect;
{$ELSE}
  with Result do
  begin
    Top := GetSystemMetrics(SM_YVIRTUALSCREEN);
    Left := GetSystemMetrics(SM_XVIRTUALSCREEN);
    Bottom := Top + GetSystemMetrics(SM_CYVIRTUALSCREEN);
    Right := Left + GetSystemMetrics(SM_CXVIRTUALSCREEN);
  end;
{$ENDIF}
end;

constructor TcxSchedulerMonthListBox.Create(AOwner: TcxSchedulerDateNavigator);
begin
  inherited Create(AOwner.Scheduler);
  OwnerParent := AOwner.Scheduler.Parent;
  FOwner := AOwner;
  IsTopMost := True;
  CaptureFocus := False;
  ControlStyle := [csCaptureMouse, csOpaque];
  FTopDate := NullDate;
  FTimer := TTimer.Create(nil);
  FTimer.Enabled := False;
  FTimer.Interval := 200;
  FTimer.OnTimer := DoTimer;
  Adjustable := False;
  BorderStyle := pbsFlat;
end;

procedure TcxSchedulerMonthListBox.BeforeDestruction;
begin
  FTimer.Free;
  FTimer := nil;
  inherited BeforeDestruction;
end;

procedure TcxSchedulerMonthListBox.CloseUp;
var
  ADate: TDateTime;
  AYear, AMonth, ADay: Word;
begin
  FTimer.Enabled := False;
  if GetCaptureControl = Self then SetCaptureControl(nil);
  inherited CloseUp;
  ADate := GetDate;
  with Owner do
  begin
    if ADate <> NullDate then
    begin
      DecodeDate(ADate, AYear, AMonth, ADay);
      ChangeMonth(AYear, AMonth, -FListBoxDelta);
      FirstDate := EncodeDate(AYear, AMonth, 1);
    end;
    Controller.DoCancelMode;
  end;
  Owner.EndUpdate;
end;

procedure TcxSchedulerMonthListBox.SetupMonth(R: TRect; ADate: TDateTime);
begin
  Font.Assign(ViewInfo.ContentParams.Font);
  FontChanged;
  R.TopLeft := Owner.Scheduler.ClientToScreen(R.TopLeft);
  R.BottomRight := Owner.Scheduler.ClientToScreen(R.BottomRight);
  R := cxRectOffset(R, Owner.Bounds.TopLeft);
  TopDate := ADate;
  FOrigin.X := Max(GetDesktopRect.Left,
    (R.Left + R.Right) div 2 - Width div 2);
  FOrigin.Y := Max(GetDesktopRect.Top,
    (R.Top + R.Bottom) div 2 - Height div 2);
  FItemIndex := 3;
end;

function TcxSchedulerMonthListBox.GetDate: TDateTime;
var
  Year, Month, Day: Word;
begin
  if ItemIndex = -1 then
    Result := NullDate
  else
  begin
    DecodeDate(TopDate, Year, Month, Day);
    ChangeMonth(Year, Month, ItemIndex);
    Result := EncodeDate(Year, Month, 1);
  end;
end;

function TcxSchedulerMonthListBox.GetViewInfo: TcxSchedulerDateNavigatorViewInfo;
begin
  Result := Owner.ViewInfo;
end;

procedure TcxSchedulerMonthListBox.SetItemIndex(Value: Integer);
var
  PrevItemIndex: Integer;

  procedure InvalidateItemRect(Index: Integer);
  var
    R: TRect;
  begin
    if Index = -1 then Exit;
    with R do
    begin
      Left := BorderWidths[bLeft];
      Top := Index * ItemHeight + BorderWidths[bTop];
      Right := Width - BorderWidths[bRight];
      Bottom := Top + ItemHeight;
    end;
    InvalidateRect(Handle, @R, False);
  end;

begin
  if not HandleAllocated then Exit;
  if FItemIndex <> Value then
  begin
    PrevItemIndex := FItemIndex;
    FItemIndex := Value;
    InvalidateItemRect(PrevItemIndex);
    InvalidateItemRect(FItemIndex);
  end;
end;

procedure TcxSchedulerMonthListBox.SetTopDate(Value: TDateTime);
begin
  if FTopDate <> Value then
  begin
    FTopDate := Value;
    Repaint;
  end;
end;

procedure TcxSchedulerMonthListBox.DoTimer(Sender: TObject);
var
  Year, Month, Day: Word;
begin
  DecodeDate(TopDate, Year, Month, Day);
  ChangeMonth(Year, Month, FSign);
  TopDate := EncodeDate(Year, Month, 1);
end;

function TcxSchedulerMonthListBox.CalculatePosition: TPoint;
begin
  Result.X := Min(cxRectWidth(GetDesktopRect) - Width, FOrigin.X);
  Result.Y := Min(cxRectHeight(GetDesktopRect) - Height, FOrigin.Y);
end;

procedure TcxSchedulerMonthListBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
end;

procedure TcxSchedulerMonthListBox.DoShowed;
begin
  SetCaptureControl(Self);
end;

procedure TcxSchedulerMonthListBox.FontChanged;
begin
  Canvas.Font.Assign(Font);
  FItemHeight := ViewInfo.HeaderHeight - 2;
  SetBounds(Left, Top,
    BorderWidths[bLeft] + BorderWidths[bRight] + 6 * ViewInfo.ColWidth,
    BorderWidths[bTop] + BorderWidths[bBottom] + 7 * FItemHeight);
end;

procedure TcxSchedulerMonthListBox.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  CloseUp;
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TcxSchedulerMonthListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
const
  Times: array[0..3] of UINT = (500, 250, 100, 50);
var
  Delta: Integer;
  Interval: Integer;
begin
  if cxRectPtIn(ClientRect, X, Y) then
  begin
    FTimer.Enabled := False;
    ItemIndex := Y div ItemHeight;
  end
  else
  begin
    ItemIndex := -1;
    if Y < 0 then Delta := Y
    else
      if Y >= ClientHeight then
        Delta := 1 + Y - ClientHeight
      else
      begin
        FTimer.Enabled := False;
        Exit;
      end;
    FSign := Delta div Abs(Delta);
    Interval := Abs(Delta) div ItemHeight;
    if Interval > 3 then Interval := 3;
    if not FTimer.Enabled or (Times[Interval] <> FTimer.Interval) then
    begin
      FTimer.Interval := Times[Interval];
      FTimer.Enabled := True;
    end;
  end;
end;

procedure TcxSchedulerMonthListBox.Paint;
const
  Colors: array[Boolean] of TColor = (clWindow, clWindowText);
var
  I: Integer;
  Year, Month, Day: Word;
  R: TRect;
  S: string;
begin
  Canvas.FrameRect(ClientRect, clBlack);
  DecodeDate(TopDate, Year, Month, Day);
  with R do
  begin
    Left  := BorderWidths[bLeft];
    Top   := BorderWidths[bTop];
    Right := Width - BorderWidths[bRight];
    Bottom := Top + ItemHeight;
  end;
  for I := 0 to 6 do
  begin
    with Canvas do
    begin
      if I = ItemIndex then
      begin
        Font.Color := ViewInfo.SelectedParams.TextColor;
        Brush.Color := ViewInfo.SelectedParams.Color;
        FillRect(R);
      end
      else
      begin
        Font.Color := ViewInfo.ContentParams.TextColor;
        FillRect(R, ViewInfo.ContentParams);
      end;
      S := Owner.DateTimeHelper.MonthYearToStr(Month, Year);
      Canvas.Brush.Style := bsClear;
      Inc(R.Right); // synchronize with header
      DrawText(S, R, cxAlignCenter or cxSingleLine, True);
      Dec(R.Right);
      Canvas.Brush.Style := bsSolid;
    end;
    IncMonth(Year, Month);
    OffsetRect(R, 0, ItemHeight);
  end;
end;

{ TcxSchedulerDateNavigatorController }

constructor TcxSchedulerDateNavigatorController.Create(AOwner: TcxSchedulerSubControl);
begin
  inherited Create(AOwner);
  FSaveSelectionList := TcxSchedulerDateList.Create;
end;

destructor TcxSchedulerDateNavigatorController.Destroy;
begin
  StopTimer; 
  FSaveSelectionList.Free;
  inherited Destroy;
end;

procedure TcxSchedulerDateNavigatorController.DoCancelMode;
begin
  StopTimer;
  FIgnoreMouseMove := False;
  FSingleSelection := False;
  FDragDate := NullDate;
  Screen.Cursor := crDefault;
  Owner.RefreshDays;
end;

procedure TcxSchedulerDateNavigatorController.DragOver(
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Accept and HitTest.HitAtTime;
end;

function TcxSchedulerDateNavigatorController.GetCursor(X, Y: Integer): TCursor;
begin
  if Owner.SelectPeriod and HitTest.HitAtWeekSelectionBar then
    Result := crCalendarMirrorArrow
  else
    Result := crDefault;
end;

procedure TcxSchedulerDateNavigatorController.MouseDown(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  procedure ProcessHeader;
  begin
    with HitTest do
    begin
      if HitAtPrevMonth then
      begin
        Owner.StepToPast;
        StartTimer(False);
      end
      else if HitAtNextMonth then
      begin
        Owner.StepToFuture;
        StartTimer(True);
      end
      else if HitAtMonthName then
        Owner.ShowMonthPopup(MonthViewInfo);
    end;
  end;

begin
  FIgnoreMouseMove := False;
  FSingleSelection := False;
  FSaveSelectionIsWeeks := False;
  if Button = mbLeft then
  begin
    Owner.CancelUpdates; // for a possible changed capture
    Owner.BeginUpdate;
    FExtSelect := Owner.SelectPeriod and (ssCtrl in Shift);
    FUnselect := FExtSelect;
    FSaveSelectionList.Assign(Owner.SelectionList);
    if not (ssDouble in Shift) then
      ProcessSelectionOnMouseDown(Shift);
    ProcessHeader;
  end;
end;

procedure TcxSchedulerDateNavigatorController.MouseLeave;
begin
  inherited MouseLeave;
  DoCancelMode;
end;

procedure TcxSchedulerDateNavigatorController.MouseMove(
  Shift: TShiftState; X, Y: Integer);
begin
  if FIgnoreMouseMove or (FTimer <> nil) then Exit;
  if (ssLeft in Shift) and (GetCaptureControl = Owner.Scheduler) then
    ProcessSelectionOnMouseMove(Shift);
end;

procedure TcxSchedulerDateNavigatorController.MouseUp(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DoCancelMode;
  if Button = mbLeft then
  begin
    if (Owner.SelectionList.Count > 0) and
      cxRectPtIn(ViewInfo.GetInternalRect(ViewInfo.GetCol(X), ViewInfo.GetRow(Y)), X, Y) then
    begin
      if Owner.SelectionList[Owner.SelectionList.Count - 1] < Owner.FirstDate then
        Owner.StepToPast;
      if Owner.SelectionList[0] > Owner.LastDate then
        Owner.StepToFuture;
    end;
    Owner.DoSelectionChanged;
    Owner.EndUpdate;
  end;
end;

procedure TcxSchedulerDateNavigatorController.CalculateSelection(AConcatenate: Boolean);

  procedure GetBoundParameters(out AStart, AFinish, AMax, AMin: Integer);
  begin
    //DELPHI8! check Trunc()
    AStart := Trunc(FSelStart);
    AFinish := Trunc(FSelFinish);
    if Owner.SelectionIsWeeks then
    begin
      if AStart < AFinish then
      begin
        Dec(AStart, ColOfDate(AStart, Byte(StartOfWeek)));
        Inc(AFinish, 6 - ColOfDate(AFinish, Byte(StartOfWeek)));
      end
      else
      begin
        Dec(AFinish, ColOfDate(AFinish, Byte(StartOfWeek)));
        Inc(AStart, 6 - ColOfDate(AStart, Byte(StartOfWeek)));
      end;
      AMax := cxMaxWeekCount * 7;
      AMin := 7;
    end
    else
    begin
      AMax := 14;
      AMin := 1;
    end;
  end;

var
  AIndex, ADelta, AStart, AFinish, AMax, AMin: Integer;
begin
  GetBoundParameters(AStart, AFinish, AMax, AMin);
  if FUnselect and (Owner.SelectionList.Count <= AMin) then Exit;
  Owner.SelectionList.Clear;
  if AConcatenate then Owner.SelectionList.Assign(FSaveSelectionList);
  ADelta := 2 * Byte(AStart < AFinish) - 1;
  while (AStart <> AFinish + ADelta) do
  begin
    AIndex := Owner.SelectionList.IndexOf(AStart);
    if AIndex < 0 then
    begin
      if not FUnselect and (Owner.SelectionList.Count < AMax) then
        Owner.SelectionList.Add(AStart);
    end
    else
      if FUnselect and (Owner.SelectionList.Count > AMin) then
        Owner.SelectionList.Delete(AIndex);
    Inc(AStart, ADelta);
  end;
  Owner.RefreshDays;
end;

procedure TcxSchedulerDateNavigatorController.ProcessSelectionOnMouseDown(
  AShift: TShiftState);

  procedure SelectDate(ADate: TDateTime);
  begin
    with Owner.SelectionList do
    begin
      if (ExistDate(ADate) and FUnselect and (Count = 1)) or
        (FExtSelect and (Count > 14)) then
      begin
        FIgnoreMouseMove := True;
        Exit;
      end;
    end;
    FSelStart := ADate;
    FSelFinish := ADate;
    Owner.SelectionIsWeeks := False;
    CalculateSelection(FExtSelect);
  end;

  procedure SelectWeek(ADate: TDateTime);
  begin
    if not Owner.SelectPeriod or (Owner.SelectionIsWeeks and FUnselect and
      (Owner.SelectionList.Count = 7)) then Exit;
    if not Owner.SelectionIsWeeks then
    begin
      FUnselect := False;
      Owner.SelectionList.Clear;
    end;
    FSaveSelectionIsWeeks := Owner.SelectionIsWeeks;
    FSelStart := ADate;
    FSelFinish := FSelStart + 6;
    CalculateSelection(FExtSelect and Owner.SelectionIsWeeks);
    Owner.SelectionIsWeeks := True;
  end;

var
  ADate: TDateTime;
begin
  ADate := HitTest.Time;
  if ADate = NullDate then Exit;
  FUnselect := FUnselect and Owner.SelectionList.ExistDate(ADate);
  if Owner.SelectPeriod and (ssShift in AShift) then
  begin
    FSelStart := Owner.SelectionList[0];
    FSelFinish := ADate;
    Owner.SelectionIsWeeks := HitTest.HitAtWeekSelectionBar or (Owner.SelectionList.Count > 14);
    CalculateSelection(not Owner.SelectionIsWeeks);
  end
  else
    if HitTest.HitAtTime then
      SelectDate(ADate)
    else if HitTest.HitAtWeekSelectionBar then
      SelectWeek(ADate)
    else if HitTest.HitAtControl and not HitTest.HitAtCalendar then
    begin
      FSingleSelection := True;
      SelectDate(ADate);
    end;
  if not (ssLeft in AShift) then
    Owner.DoSelectionChanged;  
end;

procedure TcxSchedulerDateNavigatorController.ProcessSelectionOnMouseMove(
  AShift: TShiftState);

  procedure ProcessDate(ADate: TDateTime);
  begin
    if FSingleSelection then
    begin
      FSelStart := ADate;
      FSelFinish := ADate;
      CalculateSelection(FExtSelect);
    end
    else
      if ADate <> FSelFinish then
      begin
        FSelFinish := ADate;
        if not Owner.SelectPeriod then FSelStart := FSelFinish;
        //DELPHI8! check Trunc()
        if not FExtSelect and
          (Abs(Trunc(FSelStart) - Trunc(ADate)) + 1 > cxDaysCalendarMaxColCount) then
          Owner.SelectionIsWeeks := True;
        CalculateSelection(FExtSelect and not Owner.SelectionIsWeeks);
      end;
  end;

  procedure ProcessWeek(ADate: TDateTime);
  begin
    if Owner.SelectionIsWeeks and Owner.SelectPeriod and (ADate <> FSelFinish) then
    begin
      FSelFinish := ADate;
      CalculateSelection(FExtSelect and FSaveSelectionIsWeeks);
    end;
  end;

begin
  if not HitTest.HitAtControl then
  begin
    FSelFinish := NullDate;
    Owner.SelectionList.Assign(FSaveSelectionList);
    Owner.RefreshDays;
  end
  else if HitTest.HitAtTime then
    ProcessDate(HitTest.Time)
  else if HitTest.HitAtWeekSelectionBar then
    ProcessWeek(HitTest.Time);
end;

function TcxSchedulerDateNavigatorController.GetHitTest: TcxSchedulerDateNavigatorHitTest;
begin
  Result := TcxSchedulerDateNavigatorHitTest(inherited HitTest);
end;

function TcxSchedulerDateNavigatorController.GetOwner: TcxSchedulerDateNavigator;
begin
  Result := TcxSchedulerDateNavigator(inherited Owner);
end;

function TcxSchedulerDateNavigatorController.GetViewInfo: TcxSchedulerDateNavigatorViewInfo;
begin
  Result := Owner.ViewInfo;
end;

procedure TcxSchedulerDateNavigatorController.SetDragDate(const Value: TDateTime);
begin
  if FDragDate <> Value then
  begin
    FDragDate := Value;
    Owner.Invalidate;
    //Owner.RefreshDays;
  end;
end;

procedure TcxSchedulerDateNavigatorController.StartTimer(AFuture: Boolean);
begin
  if Assigned(FTimer) then Exit;
  FTimer := TTimer.Create(nil);
  FTimer.Interval := cxDateStartNavigatorTime;
  FTimer.Tag := Ord(AFuture);
  FTimer.OnTimer := TimerProc;
end;

procedure TcxSchedulerDateNavigatorController.StopTimer;
begin
  FreeAndNil(FTimer);
end;

procedure TcxSchedulerDateNavigatorController.TimerProc(Sender: TObject);
var
  P: TPoint;
begin
  GetCursorPos(P);
  HitTest.HitPoint := Owner.Scheduler.ScreenToClient(P);
  case TTimer(Sender).Tag of
    0: if HitTest.HitAtPrevMonth then
      Owner.StepToPast;
  else
    if HitTest.HitAtNextMonth then
      Owner.StepToFuture;
  end;
  FTimer.Interval := cxDateNavigatorTime;
end;

{ TcxSchedulerDateNavigator }

constructor TcxSchedulerDateNavigator.Create(AOwner: TcxCustomScheduler);
var
  AYear, AMonth, ADay: Word;
begin
  inherited Create(AOwner);
  FRealFirstDate := NullDate;
  FRealLastDate := NullDate;
  FToday := SysUtils.Date;
  DecodeDate(FToday, AYear, AMonth, ADay);
  FFirstDate := EncodeDate(AYear, AMonth, 1);
  FFirstWeekOfYear := fwySystem;
  FActualFirstWeekOfYear := GetActualFirstWeekOfYear;
  FShowDatesContainingEventsInBold := True;
  FSelectPeriod := True;
  FColCount := 1;
  FRowCount := 1;
  FShowWeekNumbers := True;
  UpdateCalculatedValues;
end;

procedure TcxSchedulerDateNavigator.SetIntegralSizes;
begin
  ViewInfo.CalcInternalSizes;
  SetBounds(Left, Top,
    ColCount * ViewInfo.MonthSize.cx,
    RowCount * ViewInfo.MonthSize.cy);
end;

procedure TcxSchedulerDateNavigator.GetProperties(AProperties: TStrings);
begin
  if not Visible then Exit;
  with AProperties do
  begin
    if Scheduler.OptionsCustomize.IntegralSizing then
    begin
      Add('DNColCount');
      Add('DNRowCount');
    end
    else
    begin
      Add('DNWidth');
      Add('DNHeight');
    end;
  end;
end;

procedure TcxSchedulerDateNavigator.GetPropertyValue(const AName: string;
  var AValue: Variant);
begin
  if not Visible then Exit;
  if AName = 'DNColCount' then
    AValue := ColCount
  else
    if AName = 'DNRowCount' then
      AValue := RowCount
    else
      if AName = 'DNWidth' then
        AValue := Width
      else
        if AName = 'DNHeight' then
          AValue := Height
end;

procedure TcxSchedulerDateNavigator.SetPropertyValue(const AName: string;
  const AValue: Variant);
begin
  if not Visible then Exit;
  if Scheduler.OptionsCustomize.IntegralSizing then
  begin
    if AName = 'DNColCount' then
      ColCount := AValue
    else
      if AName = 'DNRowCount' then
        RowCount := AValue
  end
  else
  begin
    if AName = 'DNWidth' then
      Width := AValue
    else
      if AName = 'DNHeight' then
        Height := AValue;
  end;
end;

function TcxSchedulerDateNavigator.AllowDesignHitTest(X, Y: Integer;
  Shift: TShiftState): Boolean;
begin
  inherited AllowDesignHitTest(X, Y, Shift);
  Result := HitTest.HitAtCalendar;
  if Result then
  begin
    Result := HitTest.HitAtTime or HitTest.HitAtWeekSelectionBar or
      HitTest.HitAtMonthName or HitTest.HitAtNextMonth or HitTest.HitAtPrevMonth;
  end;
end;

procedure TcxSchedulerDateNavigator.CheckSizes;
begin
  if Scheduler.OptionsCustomize.IntegralSizing then
    SetIntegralSizes
  else
  begin
    ViewInfo.CalcInternalSizes;
    SetBounds(Left, Top,
      Max(ViewInfo.MonthSize.cx, FSavedSize.cx),
      Max(ViewInfo.MonthSize.cy, FSavedSize.cy));
  end;
end;

procedure TcxSchedulerDateNavigator.CreateSubClasses;
begin
  inherited CreateSubClasses;
  FStyles := TcxSchedulerDateNavigatorStyles.Create(Self);
  FListBox := TcxSchedulerMonthListBox.Create(Self);
end;

function TcxSchedulerDateNavigator.CreateController: TcxSchedulerSubControlController;
begin
  Result := TcxSchedulerDateNavigatorController.Create(Self);
end;

function TcxSchedulerDateNavigator.CreateHitTest: TcxSchedulerSubControlHitTest;
begin
  Result := TcxSchedulerDateNavigatorHitTest.Create(Self);
end;

function TcxSchedulerDateNavigator.CreatePainter: TcxSchedulerSubControlPainter;
begin
  Result := TcxSchedulerDateNavigatorPainter.Create(Self);
end;

function TcxSchedulerDateNavigator.CreateViewInfo: TcxSchedulerSubControlViewInfo;
begin
  Result := TcxSchedulerDateNavigatorViewInfo.Create(Self);
end;

procedure TcxSchedulerDateNavigator.DestroySubClasses;
begin
  FreeAndNil(FStyles);
  inherited DestroySubClasses;
  FreeAndNil(FListBox);
end;

procedure TcxSchedulerDateNavigator.DoLayoutChanged;
begin
  BeginUpdate;
  try
    UpdateCalculatedValues;
    ViewInfo.Calculate;
    FRowCount := ViewInfo.RowCount;
    FColCount := ViewInfo.ColCount;
  finally
    EndUpdate;
  end;
end;

function TcxSchedulerDateNavigator.CanDrawSelectionSide: Boolean;
begin
  Result := not ShowWeekNumbers and SelectionIsWeeks;
end;

procedure TcxSchedulerDateNavigator.CheckSelectionBounds;
var
  ASelectionCount: Integer;
  AFirstSelectedDate: TDateTime;

  procedure ShiftSelection(AForward: Boolean);
  var
    ADate: TDateTime;
    AYear, AMonth, ADay: Word;
    I: Integer;
  begin
    if AForward then ADate := LastDate else ADate := FirstDate;
    DecodeDate(ADate, AYear, AMonth, ADay);
    if SelectionIsWeeks then
      ADate := ADate - ColOfDate(ADate, Byte(StartOfWeek))
    else
      ADate := EncodeDate(AYear, AMonth,
        CheckDay(AYear, AMonth, GetDateElement(AFirstSelectedDate, 3)));
    SelectionList.Clear;
    for I := 0 to ASelectionCount - 1 do
    begin
      SelectionList.Add(ADate);
      ADate := ADate + 1;
    end;
  end;

begin
  ASelectionCount := SelectionList.Count;
  if ASelectionCount > 0 then
  begin
    AFirstSelectedDate := SelectionList[0];
    if (AFirstSelectedDate < FirstDate) then
      ShiftSelection(False)
    else
      if AFirstSelectedDate > LastDate then
        ShiftSelection(True);
  end;
end;

procedure TcxSchedulerDateNavigator.DoSelectionChanged;
begin
  if IsLocked then Exit;
  IsLocked := True;
  try
    SelectionList.Changed := False;
    PeriodChanged;
  finally
    IsLocked := False;
  end;
end;

procedure TcxSchedulerDateNavigator.DoPeriodChangedEvent;
begin
  if Assigned(FOnPeriodChanged) then
    FOnPeriodChanged(Self, RealFirstDate, RealLastDate);
end;

procedure TcxSchedulerDateNavigator.DoSelectionChangedEvent;
begin
  if Assigned(FOnSelectionChanged) then
    FOnSelectionChanged(Self, SelectionList[0], SelectionList[SelectionList.Count - 1]);
end;

procedure TcxSchedulerDateNavigator.DoScrollSelection(AScrollDelta: Integer);
begin
  if AScrollDelta = 0 then Exit;
  IsLocked := True;
  try
    while AScrollDelta <> 0 do
    begin
      ScrollSelection(AScrollDelta < 0, NullDate, False);
      Inc(AScrollDelta, Byte(AScrollDelta < 0) * 2 - 1);
    end;
  finally
    IsLocked := False;
    DoSelectionChanged;
  end;
end;

procedure TcxSchedulerDateNavigator.DoScrollSelection(AForward: Boolean;
  ANeedDate: TDateTime; AIsByPage: Boolean);

  procedure ScrollWeeks;
  var
    I, J, ANumPass: Integer;
    ADate: TDateTime;
  begin
    if AIsByPage then
      ANumPass := SelectionList.Count div 7
    else
      ANumPass := 1;
    for J := 1 to ANumPass do
      if AForward then
      begin
        ADate := SelectionList[SelectionList.Count - 1] + 1;
        for I := 0 to 6 do
        begin
          SelectionList.Add(ADate + I);
          SelectionList.Delete(0);
        end
      end
      else
      begin
        ADate := SelectionList[0] - 7;
        for I := 0 to 6 do
        begin
          SelectionList.Add(ADate + I);
          SelectionList.Delete(SelectionList.Count - 1);
        end;
      end;
  end;

  procedure ScrollDays;
  begin
    if AForward then
    begin
      SelectionList.Add(SelectionList[SelectionList.Count - 1] + 1);
      SelectionList.Delete(0);
    end
    else
    begin
      SelectionList.Add(SelectionList[0] - 1);
      SelectionList.Delete(SelectionList.Count - 1);
    end;
  end;

begin
  if (SelectionList.Count = 0) or SelectionList.ExistDate(ANeedDate) then Exit;
  if SelectionIsWeeks then
    ScrollWeeks
  else
    ScrollDays;
  EnsureSelectionVisible;
end;

procedure TcxSchedulerDateNavigator.EnsureSelectionVisible;
var
  AMinDate, AMaxDate: TDateTime;
begin
  if SelectionList.Count = 0 then Exit;
  if SelectionIsWeeks then
  begin
    AMinDate := RealFirstDate;
    AMaxDate := RealLastDate;
  end
  else
  begin
    AMinDate := FirstDate;
    AMaxDate := LastDate;
  end;
  if SelectionList[0] > AMaxDate then
    FirstDate := RealLastDate
  else
    if SelectionList[0] < AMinDate then
      FirstDate := RealFirstDate
    else
      DoSelectionChanged;
end;

function TcxSchedulerDateNavigator.IsDateSelected(ADate: TDateTime): Boolean;
begin
  Result := SelectionList.ExistDate(ADate);
end;

function TcxSchedulerDateNavigator.IsDateHasEvent(ADate: TDateTime): Boolean;
begin
  Result := ShowDatesContainingEventsInBold and EventDays.ExistDate(ADate);
end;

procedure TcxSchedulerDateNavigator.FormatChanged;
begin
  FActualFirstWeekOfYear := GetActualFirstWeekOfYear;
  GetLocaleSettings;
  RefreshDays;
end;

function TcxSchedulerDateNavigator.GetMonthSize: TSize;
begin
  Result := ViewInfo.MonthSize; 
end;

function TcxSchedulerDateNavigator.GetShowDatesContainingEventsInBold: Boolean;
begin
  Result := FShowDatesContainingEventsInBold;
end;

procedure TcxSchedulerDateNavigator.RefreshDays;
begin
  ViewInfo.CalculateMonthViewInfos;
  Invalidate;
end;

procedure TcxSchedulerDateNavigator.SetFirstDate(Value: TDateTime);
begin
  //DELPHI8! check
  Value := DateOf(Value) - (GetDateElement(Value, 3) - 1);
  if FFirstDate <> Value then
  begin
    BeginUpdate;
    FFirstDate := Value;
    UpdateCalculatedValues;
    CheckSelectionBounds;
    ViewInfo.Calculate;
    DoSelectionChanged;
    EndUpdate;
  end;
end;

procedure TcxSchedulerDateNavigator.ShowMonthPopup(
  AMonthInfo: TcxSchedulerDateNavigatorMonthViewInfo);
var
  AYear, AMonth, ADay: Word;
begin
  if AMonthInfo = nil then Exit;
  DecodeDate(FirstDate, AYear, AMonth, ADay);
  FListBoxDelta := AMonthInfo.Row * ColCount + AMonthInfo.Col;
  ChangeMonth(AYear, AMonth, FListBoxDelta - 3);
  TcxSchedulerMonthListBox(FListBox).SetupMonth(
    AMonthInfo.Header.MonthNameBounds, EncodeDate(AYear, AMonth, 1));
  FListBox.Popup(FListBox)
end;

procedure TcxSchedulerDateNavigator.StepToPast;
var
  AYear, AMonth, ADay: Word;
begin
  DecodeDate(FirstDate, AYear, AMonth, ADay);
  DecMonth(AYear, AMonth);
  FirstDate := EncodeDate(AYear, AMonth, 1);
end;

procedure TcxSchedulerDateNavigator.StepToFuture;
var
  AYear, AMonth, ADay: Word;
begin
  DecodeDate(FirstDate, AYear, AMonth, ADay);
  IncMonth(AYear, AMonth);
  FirstDate := EncodeDate(AYear, AMonth, 1);
end;

procedure TcxSchedulerDateNavigator.UpdateCalculatedValues;
begin
  FToday := SysUtils.Date;
  FLastDate := GetLastDate;
  FRealFirstDate := GetRealFirstDate;
  FRealLastDate := GetRealLastDate;
end;

procedure TcxSchedulerDateNavigator.UpdateDragging;
var
  ADate: TDateTime;
begin
  with HitTest do
  begin
    if HitAtTime then ADate := Time else ADate := NullDate;
    Controller.DragDate := ADate;
  end;
end;

procedure TcxSchedulerDateNavigator.UpdateSelection;
var
  ADate: TDateTime;
begin
  if SelectionList.Count > 0 then
  begin
    if SelectionIsWeeks then
      ADate := SelectionList[SelectionList.Count div 2]
    else
      ADate := SelectionList[0]
  end
  else
  begin
    ADate := FToday;
    SelectionList.Add(FToday)
  end;
  if (ADate < FirstDate) or (ADate > LastDate) then
    FirstDate := ADate;
  DoSelectionChanged;
end;

procedure TcxSchedulerDateNavigator.AfterCustomDraw(ACanvas: TcxCanvas;
  var AParams: TcxViewParams);
begin
  with ACanvas do
  begin
    AParams.Color := Brush.Color;
    AParams.Font := Font;
    AParams.TextColor := Font.Color;
  end;
end;

procedure TcxSchedulerDateNavigator.BeforeCustomDraw(ACanvas: TcxCanvas;
  const AParams: TcxViewParams);
begin
  with ACanvas do
  begin
    Brush.Color := AParams.Color;
    Font := AParams.Font;
    Font.Color := AParams.TextColor;
  end;
end;

function TcxSchedulerDateNavigator.DoCustomDrawBackground(ACanvas: TcxCanvas;
  const ABounds: TRect; var AViewParams: TcxViewParams): Boolean;
begin
  Result := False;
  if Assigned(FOnCustomDrawBackground) then
  begin
    BeforeCustomDraw(ACanvas, AViewParams);
    FOnCustomDrawBackground(Self, ACanvas, ABounds, AViewParams, Result);
    if not Result then
      AfterCustomDraw(ACanvas, AViewParams);
  end;
end;

function TcxSchedulerDateNavigator.DoCustomDrawDayNumber(ACanvas: TcxCanvas; ADayInfo: TcxSchedulerDateNavigatorDayNumberViewInfo): Boolean;
begin
  Result := False;
  if Assigned(FOnCustomDrawDayNumber) then
  begin
    BeforeCustomDraw(ACanvas, ADayInfo.FViewParams);
    FOnCustomDrawDayNumber(Self, ACanvas, ADayInfo, Result);
    if not Result then
      AfterCustomDraw(ACanvas, ADayInfo.FViewParams);
  end;
end;

function TcxSchedulerDateNavigator.DoCustomDrawDayCaption(ACanvas: TcxCanvas;
  ADayCaptionInfo: TcxSchedulerDateNavigatorDayCaptionViewInfo): Boolean;
begin
  Result := False;
  if Assigned(FOnCustomDrawDayCaption) then
  begin
    BeforeCustomDraw(ACanvas, ADayCaptionInfo.ViewParams);
    FOnCustomDrawDayCaption(Self, ACanvas, ADayCaptionInfo, Result);
    if not Result then
      AfterCustomDraw(ACanvas, ADayCaptionInfo.FViewParams);
  end;
end;

function TcxSchedulerDateNavigator.DoCustomDrawContent(ACanvas: TcxCanvas;
  AViewInfo: TcxSchedulerDateNavigatorMonthContentViewInfo): Boolean;
begin
  Result := False;
  if Assigned(FOnCustomDrawContent) then
  begin
    BeforeCustomDraw(ACanvas, AViewInfo.ViewParams);
    FOnCustomDrawContent(Self, ACanvas, AViewInfo, Result);
    if not Result then
    begin
      AfterCustomDraw(ACanvas, AViewInfo.FViewParams);
      AViewInfo.UpdateElementsAfterCustomDraw(ACanvas);
    end;
  end;
end;

function TcxSchedulerDateNavigator.DoCustomDrawHeader(ACanvas: TcxCanvas;
  AViewInfo: TcxSchedulerDateNavigatorMonthHeaderViewInfo): Boolean;
begin
  Result := False;
  if Assigned(FOnCustomDrawHeader) then
  begin
    BeforeCustomDraw(ACanvas, AViewInfo.ViewParams);
    FOnCustomDrawHeader(Self, ACanvas, AViewInfo, Result);
    if not Result then
      AfterCustomDraw(ACanvas, AViewInfo.FViewParams);
  end;
end;

function TcxSchedulerDateNavigator.GetActualFirstWeekOfYear: TcxFirstWeekOfYear; 
begin
  if FFirstWeekOfYear = fwySystem then
    Result := TcxFirstWeekOfYear(
      StrToInt(GetLocaleChar(GetUserDefaultLCID, LOCALE_IFIRSTWEEKOFYEAR, '0')) + 1)
  else
    Result := FFirstWeekOfYear;
end;

function TcxSchedulerDateNavigator.GetController: TcxSchedulerDateNavigatorController;
begin
  Result := TcxSchedulerDateNavigatorController(inherited Controller);
end;

function TcxSchedulerDateNavigator.GetDate: TDateTime;
begin
  if SelectionList.Count = 0 then
    Result := NullDate
  else
    Result := SelectionList[0];
end;

function TcxSchedulerDateNavigator.GetHitTest: TcxSchedulerDateNavigatorHitTest;
begin
  Result := TcxSchedulerDateNavigatorHitTest(inherited HitTest);
end;

function TcxSchedulerDateNavigator.GetLastDate: TDateTime;
var
  Year, Month, Day: Word;
begin
  DecodeDate(FirstDate, Year, Month, Day);
  ChangeMonth(Year, Month, ColCount * RowCount - 1);
  Result := EncodeDate(Year, Month, DaysPerMonth(Year, Month));
end;

function TcxSchedulerDateNavigator.GetRealFirstDate: TDateTime;
var
  ACol: Integer;
begin
  Result := FFirstDate;
  ACol := ColOfDate(FirstDate, Byte(StartOfWeek));
  if ACol = 0 then
    Result := Result - 7
  else
    Result := Result - ACol;
end;

function TcxSchedulerDateNavigator.GetRealLastDate: TDateTime;
var
  Year, Month, Day: Word;
  ACol: Integer;
begin
  Result := FLastDate;
  DecodeDate(Result, Year, Month, Day);
  ACol := ColOfDate(EncodeDate(Year, Month, 1), Byte(StartOfWeek));
  Result := Result + 6 * 7 - DaysPerMonth(Year, Month) - ACol;
  if (ACol = 0) and (ColCount * RowCount = 1) then Result := Result - 7;
end;

function TcxSchedulerDateNavigator.GetViewInfo: TcxSchedulerDateNavigatorViewInfo;
begin
  Result := TcxSchedulerDateNavigatorViewInfo(inherited ViewInfo);
end;

procedure TcxSchedulerDateNavigator.SetColCount(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if FColCount <> Value then
  begin
    FColCount := Value;
    ViewInfo.CalcInternalSizes;
    Width := Value * ViewInfo.MonthSize.cx;
  end;
end;

procedure TcxSchedulerDateNavigator.SetDate(Value: TDateTime);
begin
  if Value <> NullDate then
  begin
    SelectionList.Clear;
    if (Value < FirstDate) or (Value > LastDate) then
      FirstDate := Value;
    SelectionIsWeeks := False;
    SelectionList.Add(Value);
    RefreshDays;
  end;
end;

procedure TcxSchedulerDateNavigator.SetFirstWeekOfYear(
  Value: TcxFirstWeekOfYear);
begin
  if Value <> FFirstWeekOfYear then
  begin
    FFirstWeekOfYear := Value;
    FActualFirstWeekOfYear := GetActualFirstWeekOfYear;
    if ShowWeekNumbers then
      RefreshDays;
  end;
end;

procedure TcxSchedulerDateNavigator.SetRowCount(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if FRowCount <> Value then
  begin
    FRowCount := Value;
    ViewInfo.CalcInternalSizes;
    Height := Value * ViewInfo.MonthSize.cy;
  end;
end;

procedure TcxSchedulerDateNavigator.SetSelectPeriod(Value: Boolean);
begin
  if FSelectPeriod <> Value then
  begin
    FSelectPeriod := Value;
    if not Value then
      Date := Date;
  end;
end;

procedure TcxSchedulerDateNavigator.SetShowDatesContainingEventsInBold(Value: Boolean);
begin
  if FShowDatesContainingEventsInBold <> Value then
  begin
    FShowDatesContainingEventsInBold := Value;
    RefreshDays;
  end;
end;

procedure TcxSchedulerDateNavigator.SetShowWeekNumbers(Value: Boolean);
begin
  if FShowWeekNumbers <> Value then
  begin
    FShowWeekNumbers := Value;
    RefreshDays;
  end;
end;

procedure TcxSchedulerDateNavigator.SetStyles(
  const Value: TcxSchedulerDateNavigatorStyles);
begin
  FStyles.Assign(Value);
end;

{ TcxSchedulerDateNavigatorPainter }

constructor TcxSchedulerDateNavigatorPainter.Create(AOwner: TcxSchedulerSubControl);
begin
  inherited Create(AOwner);
  FDateNavigator := TcxSchedulerDateNavigator(AOwner);
end;

procedure TcxSchedulerDateNavigatorPainter.Paint;
var
  I, J: Integer;
  AMonthInfo: TcxSchedulerDateNavigatorMonthViewInfo;
begin
  Canvas.FillRect(DateNavigator.ViewInfo.CalendarBounds,
  DateNavigator.Styles.GetContentParams);
  for I := 0 to DateNavigator.ColCount - 1 do
    for J := 0 to DateNavigator.RowCount - 1 do
    begin
      AMonthInfo := DateNavigator.ViewInfo.MonthViewInfo[I, J];
      DoDrawMonthContent(AMonthInfo.Content);
      DoDrawMonthHeader(AMonthInfo.Header);
      DoDrawDayCaptions(AMonthInfo.Content);
      DoDrawDayNumbers(AMonthInfo.Content);
      DrawSeparators(AMonthInfo.Content);
      if DateNavigator.ShowWeekNumbers then
        DrawWeekNumbers(AMonthInfo.Content);
    end;
  Canvas.ExcludeClipRect(DateNavigator.ViewInfo.CalendarBounds);
  DrawBackground;
end;

procedure TcxSchedulerDateNavigatorPainter.DoDrawDayCaptions(
  AViewInfo: TcxSchedulerDateNavigatorMonthContentViewInfo);
var
  I: Integer;
  AInfo: TcxSchedulerDateNavigatorDayCaptionViewInfo;
begin
  for I := 0 to 6 do
  begin
    AInfo := AViewInfo.DayCaptions[I];
    AInfo.SaveParams(AViewInfo.Transparent);
    if not DateNavigator.DoCustomDrawDayCaption(Canvas, AInfo) then
    begin
      cxApplyViewParams(Canvas, AInfo.ViewParams);
      if not AInfo.Transparent then
        Canvas.FillRect(AInfo.Bounds, AInfo.ViewParams);
      Canvas.Brush.Style := bsClear;
      Canvas.DrawText(AInfo.Text, cxRectOffset(AInfo.Bounds, -2, 0), cxdnTextFlags);
      Canvas.Brush.Style := bsSolid;
    end;
    AInfo.RestoreParams;
  end;
end;

procedure TcxSchedulerDateNavigatorPainter.DoDrawDayNumbers(
  AViewInfo: TcxSchedulerDateNavigatorMonthContentViewInfo);
var
  I: Integer;
  ADayInfo: TcxSchedulerDateNavigatorDayNumberViewInfo;
begin
  for I := 0 to AViewInfo.FDayCount - 1 do
  begin
    ADayInfo := AViewInfo.FDays[I];
    ADayInfo.SaveParams(AViewInfo.Transparent and not ADayInfo.Selected);
    if not DateNavigator.DoCustomDrawDayNumber(Canvas, ADayInfo) then
      DrawDayNumber(ADayInfo);
    ADayInfo.RestoreParams;
  end;
end;

procedure TcxSchedulerDateNavigatorPainter.DoDrawMonthContent(
  AViewInfo: TcxSchedulerDateNavigatorMonthContentViewInfo);
begin
  AViewInfo.SaveParams;
  if not DateNavigator.DoCustomDrawContent(Canvas, AViewInfo) then
    // use owner's bounds
    Canvas.FillRect(AViewInfo.Owner.Bounds, AViewInfo.ViewParams);
  AViewInfo.RestoreParams;
end;

procedure TcxSchedulerDateNavigatorPainter.DoDrawMonthHeader(
  AViewInfo: TcxSchedulerDateNavigatorMonthHeaderViewInfo);
begin
  AViewInfo.SaveParams(False);
  if not DateNavigator.DoCustomDrawHeader(Canvas, AViewInfo) then
  begin
    FHeaderTransparent := AViewInfo.Transparent;
    DrawMonthHeader(AViewInfo);
  end;
  AViewInfo.RestoreParams;
end;

procedure TcxSchedulerDateNavigatorPainter.DrawDayNumber(
  ADayInfo: TcxSchedulerDateNavigatorDayNumberViewInfo);
begin
  cxApplyViewParams(Canvas, ADayInfo.ViewParams);
  with Canvas do
  begin
    if DateNavigator.ShowDatesContainingEventsInBold then
    begin
      if ADayInfo.Bold then
        Font.Style := Font.Style + [fsBold]
      else
        Font.Style := Font.Style - [fsBold];
    end;
    if not ADayInfo.Transparent then
    begin
      FillRect(ADayInfo.Bounds, ADayInfo.ViewParams);
      if not cxRectIsEmpty(ADayInfo.SelectionSideBounds) then
        FillRect(ADayInfo.SelectionSideBounds);
    end;
    CheckDrawFrame(ADayInfo.Bounds, ADayInfo.Date);
    Brush.Style := bsClear;
    DrawText(ADayInfo.Text, cxRectOffset(ADayInfo.Bounds, -2, 0), cxdnTextFlags);
    Brush.Style := bsSolid;
  end;
end;

procedure TcxSchedulerDateNavigatorPainter.DrawBackground;
var
  AViewParams: TcxViewParams;
begin
  with DateNavigator do
  begin
    AViewParams := Styles.GetBackgroundParams;
    if not DoCustomDrawBackground(Canvas, ClientRect, AViewParams) then
      Canvas.FillRect(ClientRect, AViewParams);
  end;
end;

procedure TcxSchedulerDateNavigatorPainter.DrawMonthHeader(
  AViewInfo: TcxSchedulerDateNavigatorMonthHeaderViewInfo);
begin
  FHeaderParams := AViewInfo.ViewParams;
  DateNavigator.LookAndFeelPainter.DrawMonthHeader(Canvas, AViewInfo.Bounds,
    AViewInfo.Text, AViewInfo.Neighbors, FHeaderParams, AViewInfo.Arrows,
    DateNavigator.ViewInfo.SideWidth, DrawHeaderBackground);
end;

procedure TcxSchedulerDateNavigatorPainter.DrawSeparators(
  AViewInfo: TcxSchedulerDateNavigatorMonthContentViewInfo);
begin
  with Canvas do
  begin
    SetBrushColor(clBtnShadow);
    FillRect(AViewInfo.HorzSeparatorBound);
    if DateNavigator.ShowWeekNumbers then
    begin
      FillRect(cxRectSetWidth(AViewInfo.VertSeparatorBound, 1));
      SetBrushColor(clBtnHighlight);
      FillRect(cxRectSetWidth(AViewInfo.VertSeparatorBound,
        AViewInfo.VertSeparatorBound.Left + 1, 1));
    end;
  end;
end;

procedure TcxSchedulerDateNavigatorPainter.DrawWeekNumbers(
  AViewInfo: TcxSchedulerDateNavigatorMonthContentViewInfo);
var
  I: Integer;
begin
  with Canvas do
  begin
    Brush.Style := bsClear;
    Font := AViewInfo.ViewParams.Font;
    Font.Color := AViewInfo.ViewParams.TextColor;
    Font.Size := MulDiv(AViewInfo.ViewParams.Font.Size, 2, 3);
    with AViewInfo do
      for I := 0 to FWeekCount - 1 do
        DrawText(FWeekTexts[I], FWeekBounds[I], cxdnTextFlags);
    Brush.Style := bsSolid;
    Font.Size := AViewInfo.ViewParams.Font.Size;
  end;
end;

procedure TcxSchedulerDateNavigatorPainter.CheckDrawFrame(
  const ABounds: TRect; ADate: TDateTime);
begin
  if ADate = DateNavigator.Controller.DragDate then
    Canvas.FrameRect(ABounds, clWindowText, 2)
  else
    if ADate = DateNavigator.FToday then
    begin
      Canvas.SetBrushColor(clMaroon);
      Canvas.FrameRect(ABounds);
    end;
end;

function TcxSchedulerDateNavigatorPainter.DrawHeaderBackground(ACanvas: TcxCanvas;
  const ABounds: TRect): Boolean;
begin
  Result := True;
  if not FHeaderTransparent then
    ACanvas.FillRect(ABounds, FHeaderParams);
end;

{ TcxSchedulerDateNavigatorCaptionViewInfo }

procedure TcxSchedulerDateNavigatorCaptionViewInfo.RestoreParams;
begin
  FViewParams := FSaveParams;
end;

procedure TcxSchedulerDateNavigatorCaptionViewInfo.SaveParams(ATransparent: Boolean);
begin
  FSaveParams := FViewParams;
  FTransparent := ATransparent;
end;

{ TcxSchedulerDateNavigatorMonthHeaderViewInfo }

constructor TcxSchedulerDateNavigatorMonthHeaderViewInfo.Create(
  AOwner: TcxSchedulerDateNavigatorMonthViewInfo);
begin
  inherited Create;
  FOwner := AOwner;
end;

procedure TcxSchedulerDateNavigatorMonthHeaderViewInfo.Calculate(const ABounds: TRect);
begin
  FBounds := ABounds;
  FText := Owner.Owner.DateTimeHelper.MonthYearToStr(Month, Year);
  FArrows := Owner.GetHeaderArrows;
  FNeighbors := Owner.GetHeaderNeighbors;
  FMonthNameBounds := GetMonthNameBounds;
  FViewParams := Owner.Owner.HeaderParams;
  FTransparent := False;
end;

function TcxSchedulerDateNavigatorMonthHeaderViewInfo.GetMonth: Integer;
begin
  Result := Owner.Month;
end;

function TcxSchedulerDateNavigatorMonthHeaderViewInfo.GetMonthNameBounds: TRect;
begin
  Result := Bounds;
  with Result do
  begin
    Inc(Left, Owner.Owner.ColWidth);
    Dec(Right, Owner.Owner.ColWidth);
    Dec(Bottom);
    Inc(Top);
  end;
end;

function TcxSchedulerDateNavigatorMonthHeaderViewInfo.GetYear: Integer;
begin
  Result := Owner.Year;
end;

{ TcxSchedulerDateNavigatorMonthContentViewInfo }

constructor TcxSchedulerDateNavigatorMonthContentViewInfo.Create(
  AOwner: TcxSchedulerDateNavigatorMonthViewInfo);
begin
  inherited Create;
  FOwner := AOwner;
  FViewInfo := AOwner.Owner;
  FDateNavigator := AOwner.Owner.Owner;
  FFont := TFont.Create;
  CreateDayInfos;
  CreateDayCaptionInfos;
end;

destructor TcxSchedulerDateNavigatorMonthContentViewInfo.Destroy;
begin
  DestroyDayCaptionInfos;
  DestroyDayInfos;
  FFont.Free;
  inherited Destroy;
end;

procedure TcxSchedulerDateNavigatorMonthContentViewInfo.CalcAndAddDayInfo(ADate: TDateTime;
  const ABounds: TRect; const ASelectionSideBounds: TRect);
var
  ASelected: Boolean;
begin
  ASelected := DateNavigator.IsDateSelected(ADate);
  with FDays[FDayCount] do
  begin
    FBold := DateNavigator.IsDateHasEvent(ADate);
    FBounds := ABounds;
    FDate := ADate;
    FGrayed := GetGrayed(ADate);
    FSelected := ASelected;
    if ASelected and DateNavigator.CanDrawSelectionSide then
      FSelectionSideBounds := ASelectionSideBounds
    else
      FSelectionSideBounds := cxNullRect;
    FText := IntToStr(GetDateElement(ADate, 3));
    FViewParams := GetDateViewParams(ADate, ASelected);
    if FGrayed then FViewParams.TextColor := clGrayText;
  end;
  Inc(FDayCount);
end;

procedure TcxSchedulerDateNavigatorMonthContentViewInfo.Calculate(
  ACol, ARow, AYear, AMonth: Integer);
begin
  FBounds := ViewInfo.GetInternalRect(ACol, ARow);
  FRow := ARow;
  FCol := ACol;
  FYear := AYear;
  FMonth := AMonth;
  CalcParams;
  CalcDayCaptions;
  CalcDays;
  with FWeekSelectionBarBounds do
  begin
    Left := Bounds.Left;
    Top := Bounds.Top + ViewInfo.DayCaptionsHeight;
    Right := Left + ViewInfo.SideWidth;
    Bottom := Top + ViewInfo.RowHeight * FWeekCount;
  end;
  CalcSeparatorsBound;
end;

procedure TcxSchedulerDateNavigatorMonthContentViewInfo.CalcDays; 
var
  R: TRect;
  I, J, ADayBase, ADaysPerMonth: Integer;
  ADate, ADateBase: TDateTime;
  AHasDate: Boolean;

  procedure CheckCalcWeekNumber(const R: TRect);
  begin
    if DateNavigator.ShowWeekNumbers then
    begin
      FWeekBounds[FWeekCount] := cxRect(R.Left - ViewInfo.SideWidth,
        R.Top - 1, R.Left - 3, R.Bottom);
      FWeekTexts[FWeekCount] := IntToStr(GetWeekNumber(ADate,
        DateNavigator.StartOfWeek, DateNavigator.FActualFirstWeekOfYear));
    end;
    Inc(FWeekCount);
  end;

  function GetDate(out ADate: TDateTime): Boolean;
  var
    ACurDay: Integer;
  begin
    ACurDay := ADayBase + J * 7 + I;
    Result :=  not ((ACurDay < 1) and (FCol + FRow <> 0) or
      (ACurDay > ADaysPerMonth) and ((FCol <> ViewInfo.ColCount - 1) or
      (FRow <> ViewInfo.RowCount - 1)));
    ADate := ADateBase + ACurDay;
  end;

begin
  FDayCount := 0;
  FWeekCount := 0;
  ADateBase := EncodeDate(FYear, FMonth, 1) - 1;
  ADayBase := 1 - ColOfDate(ADateBase + 1, Byte(DateNavigator.StartOfWeek));
  if (ADayBase = 1) and (FCol + FRow = 0) then Dec(ADayBase, 7);
  ADaysPerMonth := DaysPerMonth(FYear, FMonth);
  for I := 0 to 6 do
    for J := 0 to 5 do
    begin
      AHasDate := GetDate(ADate);
      R := GetDayRectFromColAndRow(I, J);
      if (I = 0) and not ((J = 5) and not AHasDate) then
        CheckCalcWeekNumber(R);
      if AHasDate then
        CalcAndAddDayInfo(ADate, R, GetSelectionSideBounds(R, I));
    end;
end;

procedure TcxSchedulerDateNavigatorMonthContentViewInfo.CalcDayCaptions;
var
  I: Integer;
  R: TRect;
begin
  with R do
  begin
    Top := Bounds.Top;
    Bottom := Top + ViewInfo.DayCaptionsHeight - 2;
    Right := Bounds.Left + ViewInfo.SideWidth;
  end;
  for I := 0 to 6 do
  begin
    with R do
    begin
      Left := Right;
      Right := Left + ViewInfo.ColWidth;
    end;
    FDayCaptions[I].FBounds := R;
    FDayCaptions[I].FIndex := I;
    FDayCaptions[I].FText := GetDayCaptionText(I);
    FDayCaptions[I].FViewParams := ViewParams;
  end;
end;

procedure TcxSchedulerDateNavigatorMonthContentViewInfo.CalcParams;
begin
  FViewParams := ViewInfo.ContentParams;
  FSelectedParams := ViewInfo.SelectedParams;
  FFontCharset := FViewParams.Font.Charset;
  if FFontCharset = DEFAULT_CHARSET then
    FFontCharset := GetDefFontCharset;
end;

procedure TcxSchedulerDateNavigatorMonthContentViewInfo.CalcSeparatorsBound;
begin
  with FHorzSeparatorBound do
  begin
    Left := Bounds.Left + ViewInfo.SideWidth;
    Right := Bounds.Right - ViewInfo.SideWidth + 1;
    Top := Bounds.Top + ViewInfo.DayCaptionsHeight - 2;
    Bottom := Top + 1;
  end;
  if DateNavigator.ShowWeekNumbers then
  begin
    with FVertSeparatorBound do
    begin
      Left := WeekSelectionBarBounds.Right;
      Right := Left + 2;
      Top := WeekSelectionBarBounds.Top - 1;
      Bottom := WeekSelectionBarBounds.Bottom;
    end
  end
  else
    FVertSeparatorBound := cxNullRect;
end;

function TcxSchedulerDateNavigatorMonthContentViewInfo.GetDateViewParams(ADate: TDateTime;
  ASelected: Boolean): TcxViewParams;
begin
  if ASelected then
    Result := SelectedParams
  else
    Result := ViewParams;
end;

function TcxSchedulerDateNavigatorMonthContentViewInfo.GetDayCaptionText(Index: Byte): string;
var
  ADayIndex: Integer;
begin
  if IsValidDayCaptionIndex(Index) then
  begin
    ADayIndex := Byte(DateNavigator.StartOfWeek) + 1 + Index;
    if ADayIndex > 7 then Dec(ADayIndex, 7);
    if FFontCharset in [ARABIC_CHARSET, CHINESEBIG5_CHARSET, GB2312_CHARSET] then
      Result := AnsiLastChar(ShortDayNames[ADayIndex])
    else
      Result := WideString(ShortDayNames[ADayIndex])[1];
  end
  else
    Result := '';
end;

function TcxSchedulerDateNavigatorMonthContentViewInfo.GetWeekBound(Index: Byte): TRect;
begin
  if IsValidWeekIndex(Index) then
    Result := FWeekBounds[Index]
  else
    Result := cxNullRect;
end;

function TcxSchedulerDateNavigatorMonthContentViewInfo.GetDayText(ADate: TDateTime): string;
begin
  if ADate <> NullDate then
    Result := IntToStr(GetDateElement(ADate, 3))
  else
    Result := '';
end;

function TcxSchedulerDateNavigatorMonthContentViewInfo.GetWeekText(Index: Byte): string;
begin
  if IsValidWeekIndex(Index) then
    Result := FWeekTexts[Index]
  else
    Result := '';
end;

procedure TcxSchedulerDateNavigatorMonthContentViewInfo.RestoreParams;
begin
  FViewParams := FSaveParams;
end;

procedure TcxSchedulerDateNavigatorMonthContentViewInfo.SaveParams;
begin
  FTransparent := False;
  FSaveParams := FViewParams;            
end;

procedure TcxSchedulerDateNavigatorMonthContentViewInfo.UpdateElementsAfterCustomDraw(
  ACanvas: TcxCanvas);
var
  I: Integer;
begin
  FFont.Assign(ACanvas.Font);
  for I := 0 to 6 do
    with FDayCaptions[I] do
    begin
      FViewParams.Color := Self.ViewParams.Color;
      FViewParams.TextColor := Self.ViewParams.TextColor;
      FViewParams.Font := FFont;
    end;
  for I := 0 to FDayCount - 1 do
    with FDays[I] do
      if not Selected then
      begin
        if not Grayed then
          FViewParams.TextColor := Self.ViewParams.TextColor;
        FViewParams.Color := Self.ViewParams.Color;
        FViewParams.Font := FFont;
      end;
end;

procedure TcxSchedulerDateNavigatorMonthContentViewInfo.CreateDayInfos;
var
  I: Integer;
begin
  for I := 0 to cxMaxMonthViewInfoDays - 1 do
    FDays[I] := TcxSchedulerDateNavigatorDayNumberViewInfo.Create;
end;

procedure TcxSchedulerDateNavigatorMonthContentViewInfo.CreateDayCaptionInfos;
var
  I: Integer;
begin
  for I := 0 to 6 do
    FDayCaptions[I] := TcxSchedulerDateNavigatorDayCaptionViewInfo.Create;
end;

procedure TcxSchedulerDateNavigatorMonthContentViewInfo.DestroyDayInfos;
var
  I: Integer;
begin
  for I := 0 to cxMaxMonthViewInfoDays - 1 do
    FDays[I].Free;
  FDayCount := 0;
end;

procedure TcxSchedulerDateNavigatorMonthContentViewInfo.DestroyDayCaptionInfos;
var
  I: Integer;
begin
  for I := 0 to 6 do
    FDayCaptions[I].Free;
end;

function TcxSchedulerDateNavigatorMonthContentViewInfo.GetDayCaptionInfo(
  Index: Byte): TcxSchedulerDateNavigatorDayCaptionViewInfo;
begin
  if IsValidDayCaptionIndex(Index) then
    Result := FDayCaptions[Index]
  else
    Result := nil;
end;

function TcxSchedulerDateNavigatorMonthContentViewInfo.GetDayRectFromColAndRow(
  ACol, ARow: Integer): TRect;
begin
  with Result do
  begin
    Left := Bounds.Left + ViewInfo.SideWidth + ACol * ViewInfo.ColWidth + 2;
    Top  := Bounds.Top + ViewInfo.DayCaptionsHeight + ARow * ViewInfo.RowHeight;
    Right := Left + ViewInfo.ColWidth;
    Bottom := Top + ViewInfo.RowHeight;
  end;
end;

function TcxSchedulerDateNavigatorMonthContentViewInfo.GetDayNumberViewInfo(
  Index: Byte): TcxSchedulerDateNavigatorDayNumberViewInfo;
begin
  if IsValidDayIndex(Index) then
    Result := FDays[Index]
  else
  begin
    Result.Text := '';
    FillChar(Result, SizeOf(Result), 0);
  end;
end;

function TcxSchedulerDateNavigatorMonthContentViewInfo.GetGrayed(ADate: TDateTime): Boolean;
begin
  Result := (ADate < DateNavigator.FirstDate) and (FCol + FRow = 0) or
   (ADate > DateNavigator.LastDate) and (FCol = ViewInfo.ColCount - 1) and
   (FRow = ViewInfo.RowCount - 1);
end;

function TcxSchedulerDateNavigatorMonthContentViewInfo.GetSelectionSideBounds(
  const ADayBounds: TRect; ACol: Integer): TRect;
begin
  if ((ACol = 0) or (ACol = 6)) and not DateNavigator.ShowWeekNumbers then
  begin
    Result := ADayBounds;
    with Result do
      if ACol = 0 then
      begin
        Right := Left;
        Left := Right - ViewInfo.ColWidth div 2;
      end
      else
      begin
        Left := Right;
        Right := Left + ViewInfo.ColWidth div 2;
      end;
  end
  else Result := cxNullRect;
end;

function TcxSchedulerDateNavigatorMonthContentViewInfo.IsValidDayIndex(Index: Byte): Boolean;
begin
  Result := Index < FDayCount;
end;

function TcxSchedulerDateNavigatorMonthContentViewInfo.IsValidDayCaptionIndex(Index: Byte): Boolean;
begin
  Result := Index in [0..6];
end;

function TcxSchedulerDateNavigatorMonthContentViewInfo.IsValidWeekIndex(Index: Byte): Boolean;
begin
  Result := Index < FWeekCount;
end;

procedure TcxSchedulerDateNavigatorMonthContentViewInfo.SetWeekText(Index: Byte; const Value: string);
begin
  if IsValidWeekIndex(Index) then
    FWeekTexts[Index] := Value;
end;

{ TcxSchedulerDateNavigatorMonthViewInfo }

constructor TcxSchedulerDateNavigatorMonthViewInfo.Create(
  AOwner: TcxSchedulerDateNavigatorViewInfo);
begin
  inherited Create;
  FOwner := AOwner;
  FHeader := TcxSchedulerDateNavigatorMonthHeaderViewInfo.Create(Self);
  FContent := TcxSchedulerDateNavigatorMonthContentViewInfo.Create(Self);
end;

destructor TcxSchedulerDateNavigatorMonthViewInfo.Destroy;
begin
  FContent.Free;
  FHeader.Free;
  inherited Destroy;
end;

procedure TcxSchedulerDateNavigatorMonthViewInfo.Calculate(ACol, ARow,
  AYear, AMonth: Integer);
begin
  FBounds := Owner.GetMonthRect(ACol, ARow);
  FRow := ARow;
  FCol := ACol;
  FYear := AYear;
  FMonth := AMonth;
  Header.Calculate(Owner.GetHeaderRect(ACol, ARow));
  Content.Calculate(ACol, ARow, AYear, AMonth);
end;

function TcxSchedulerDateNavigatorMonthViewInfo.GetHeaderArrows: TcxHeaderArrows;
const
  Arrows: array[Boolean, Boolean] of TcxHeaderArrows =
    ((haNone, haRight), (haLeft, haBoth));
begin
  if Row = 0 then
    Result := Arrows[Col = 0, Col = Owner.ColCount - 1]
  else
    Result := haNone;
end;

function TcxSchedulerDateNavigatorMonthViewInfo.GetHeaderNeighbors: TcxNeighbors;
begin
  if Owner.ColCount = 1 then
    Result := []
  else if Col = 0 then
    Result := [nRight]
  else if Col = Owner.ColCount - 1 then
    Result := [nLeft]
  else
    Result := [nLeft, nRight];
end;

{ TcxSchedulerDateNavigatorStyles }

constructor TcxSchedulerDateNavigatorStyles.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  BitmapInViewParams := True;
end;

procedure TcxSchedulerDateNavigatorStyles.Assign(Source: TPersistent);
var
  I: Integer;
begin
  if Source is TcxSchedulerDateNavigatorStyles then
  begin
    for I := cxdnBackground to cxdnSelection do
      SetValue(I, TcxSchedulerDateNavigatorStyles(Source).GetValue(I))
  end;
  inherited Assign(Source);
end;

procedure TcxSchedulerDateNavigatorStyles.Changed(AIndex: Integer);
begin
  DateNavigator.CheckSizes;
  DateNavigator.Refresh;
end;

function TcxSchedulerDateNavigatorStyles.GetBackgroundParams: TcxViewParams;
begin
  GetViewParams(cxdnBackground, nil, nil, Result);
end;

function TcxSchedulerDateNavigatorStyles.GetContentParams: TcxViewParams;
begin
  GetViewParams(cxdnContent, nil, nil, Result);
end;

function TcxSchedulerDateNavigatorStyles.GetHeaderParams: TcxViewParams;
begin
  GetViewParams(cxdnHeader, nil, nil, Result);
end;

function TcxSchedulerDateNavigatorStyles.GetSelectionParams: TcxViewParams;
begin
  GetViewParams(cxdnSelection, nil, nil, Result);
end;

procedure TcxSchedulerDateNavigatorStyles.GetDefaultViewParams(
  Index: Integer; AData: TObject; out AParams: TcxViewParams);

  function Painter: TcxCustomLookAndFeelPainterClass;
  begin
    Result := DateNavigator.LookAndFeelPainter;
  end;

begin
  AParams.Bitmap := nil;
  AParams.Font := DateNavigator.Scheduler.Font;
  case Index of
    cxdnHeader:
      begin
        AParams.Color := Painter.DefaultHeaderColor;
        AParams.TextColor := Painter.DefaultHeaderTextColor;
      end;
    cxdnBackground, cxdnContent:
      begin
        AParams.Color := Painter.DefaultSchedulerBackgroundColor;
        AParams.TextColor := Painter.DefaultSchedulerTextColor;
      end;
    cxdnSelection:
      begin
        AParams.Font := GetContentParams.Font;
        AParams.Color := Painter.DefaultDateNavigatorSelectionColor;
        AParams.TextColor := Painter.DefaultDateNavigatorSelectionTextColor;
      end;
  end;
end;

function TcxSchedulerDateNavigatorStyles.GetDateNavigator: TcxSchedulerDateNavigator;
begin
  Result := TcxSchedulerDateNavigator(inherited Owner);
end;

{ TcxSchedulerDateNavigatorHitTest }

procedure TcxSchedulerDateNavigatorHitTest.Clear;
begin
  inherited Clear;
  FTime := NullDate;
  FMonthViewInfo := nil;
end;

procedure TcxSchedulerDateNavigatorHitTest.DoCalculate;
var
  ACol, ARow: Integer;
  ADay, AYear, AMonth: Word;
begin
  inherited DoCalculate;
  if cxRectPtIn(ViewInfo.CalendarBounds, HitPoint) then
  begin
    SetBitState(htcCalendar, True);
    ACol := ViewInfo.GetCol(HitX);
    ARow := ViewInfo.GetRow(HitY);
    DecodeDate(Owner.FirstDate, AYear, AMonth, ADay);
    ChangeMonth(AYear, AMonth, ARow * ViewInfo.ColCount + ACol);
    FTime := EncodeDate(AYear, AMonth, 1);
    FMonthViewInfo := ViewInfo.MonthViewInfo[ACol, ARow];
    CalcMonth;
  end;
{$IFDEF DEBUG}
  if FHitDate <> NullDate then
    Application.MainForm.Caption := DateToStr(FHitDate)
  else
    Application.MainForm.Caption := 'NullDate'
{$ENDIF}
end;

procedure TcxSchedulerDateNavigatorHitTest.CalcMonth;
var
  R: TRect;
  ADate: TDateTime;
begin
  if CheckMonthHeader or CheckWeekSelectionBar or CheckDayCaptions then Exit;
  R := MonthViewInfo.Content.Bounds;
  with R do
  begin
    Inc(Top, ViewInfo.DayCaptionsHeight);
    Inc(Left, ViewInfo.SideWidth + 2);
    Dec(Right, ViewInfo.SideWidth);
  end;
  if cxRectPtIn(R, HitPoint) then
  begin
    SetBitState(htcTime, True);
    ADate := GetFirstWeekSelectableDate +
      ((HitY - R.Top) div ViewInfo.RowHeight) * 7 + ((HitX - R.Left) div ViewInfo.ColWidth);
    if (ADate < FTime) and (MonthViewInfo.Col + MonthViewInfo.Row > 0) then Exit;
    FTime := FTime + DaysPerMonth(MonthViewInfo.Year, MonthViewInfo.Month) - 1;
    if (ADate > FTime) and not ((MonthViewInfo.Col = Owner.ColCount - 1) and
      (MonthViewInfo.Row = Owner.RowCount - 1)) then Exit;
    FTime := ADate;
  end;
end;

function TcxSchedulerDateNavigatorHitTest.CheckDayCaptions: Boolean;
var
  R: TRect;
begin
  R := MonthViewInfo.Bounds;
  with R do
  begin
    Inc(Left, ViewInfo.SideWidth);
    Dec(Right, ViewInfo.SideWidth);
    Bottom := Top + ViewInfo.DayCaptionsHeight;
  end;
  Result := cxRectPtIn(R, HitPoint);
  if Result then
    SetBitState(htcDayCaptions, True);
end;

function TcxSchedulerDateNavigatorHitTest.CheckMonthHeader: Boolean;
begin
  Result := False;
  if cxRectPtIn(MonthViewInfo.Header.MonthNameBounds, HitPoint) then
  begin
    SetBitState(htcMonthName, True);
    Result := True;
  end
  else
    if cxRectPtIn(ViewInfo.GetLeftArrowRect, HitPoint) then
    begin
      SetBitState(htcPrevMonth, True);
      Result := True;
    end
    else
      if cxRectPtIn(ViewInfo.GetRightArrowRect, HitPoint) then
      begin
        SetBitState(htcNextMonth, True);
        Result := True;
      end;
end;

function TcxSchedulerDateNavigatorHitTest.CheckWeekSelectionBar: Boolean;
var
  AContent: TcxSchedulerDateNavigatorMonthContentViewInfo;
begin
  AContent := MonthViewInfo.Content;
  Result := cxRectPtIn(AContent.WeekSelectionBarBounds, HitPoint);
  if Result then
  begin
    SetBitState(htcWeekSelectionBar, True);
    FTime := GetFirstWeekSelectableDate +
      ((HitY - AContent.WeekSelectionBarBounds.Top) div ViewInfo.RowHeight) * 7;
  end;
end;

function TcxSchedulerDateNavigatorHitTest.GetFirstWeekSelectableDate: TDateTime;
begin
  Result := FTime - ColOfDate(FTime, Byte(Owner.StartOfWeek));
  if (MonthViewInfo.Col + MonthViewInfo.Row = 0) and
    (ColOfDate(Owner.FirstDate, Byte(Owner.StartOfWeek)) = 0) then
      Result := Result - 7;
end;

function TcxSchedulerDateNavigatorHitTest.GetOwner: TcxSchedulerDateNavigator;
begin
  Result := TcxSchedulerDateNavigator(inherited Owner);
end;

function TcxSchedulerDateNavigatorHitTest.GetViewInfo: TcxSchedulerDateNavigatorViewInfo;
begin
  Result := Owner.ViewInfo;
end;

{ TcxSchedulerDateNavigatorViewInfo }

constructor TcxSchedulerDateNavigatorViewInfo.Create(AOwner: TcxSchedulerSubControl);
begin
  inherited Create(AOwner);
  FOwner := TcxSchedulerDateNavigator(AOwner);
  FMonthViewInfoList := TList.Create;
end;

destructor TcxSchedulerDateNavigatorViewInfo.Destroy;
begin
  DestroyMonthViewInfoList;
  inherited Destroy;
end;

procedure TcxSchedulerDateNavigatorViewInfo.DoCalculate;
begin
  CalcInternalSizes;
  CalculateCalendarBounds;
  CheckMonthViewInfoCount;
  CalculateMonthViewInfos;
end;

procedure TcxSchedulerDateNavigatorViewInfo.CalculateCalendarBounds;
begin
  FCalendarBounds := Owner.ClientRect;
  FColCount := Max(1, Min(cxDaysCalendarMaxColCount, Owner.Width div MonthSize.cx));
  FRowCount := Max(1, Owner.Height div MonthSize.cy);
  FCalendarBounds := cxRect(0, 0, ColCount * MonthSize.cx, RowCount * MonthSize.cy);
  FCalendarBounds := cxRectOffset(FCalendarBounds,
    (Owner.Width - cxRectWidth(CalendarBounds)) div 2,
    (Owner.Height - cxRectHeight(CalendarBounds)) div 2);
  if FCalendarBounds.Left < 0 then
    FCalendarBounds := cxRectSetLeft(FCalendarBounds, 0);
  if FCalendarBounds.Top < 0 then
    FCalendarBounds := cxRectSetTop(FCalendarBounds, 0);
end;

procedure TcxSchedulerDateNavigatorViewInfo.CalculateMonthViewInfos;
var
  I, J: Integer;
  AYear, AMonth, ADay: Word;
begin
  DecodeDate(Owner.FirstDate, AYear, AMonth, ADay);
  for J := 0 to RowCount - 1 do
    for I := 0 to ColCount - 1 do
    begin
      MonthViewInfo[I, J].Calculate(I, J, AYear, AMonth);
      ChangeMonth(AYear, AMonth, 1);
    end;
end;

procedure TcxSchedulerDateNavigatorViewInfo.CalculateViewParams;
begin
  with Owner.Styles do
  begin
    FContentParams := GetContentParams;
    FHeaderParams := GetHeaderParams;
    FSelectedParams := GetSelectionParams;
  end;
end;

procedure TcxSchedulerDateNavigatorViewInfo.CheckMonthViewInfoCount;
var
  I, ACount: Integer;
begin
  ACount := RowCount * ColCount;
  for I := FMonthViewInfoList.Count - 1 downto ACount do
  begin
    TcxSchedulerDateNavigatorMonthViewInfo(FMonthViewInfoList[I]).Free;
    FMonthViewInfoList.Delete(I);
  end;
  for I := FMonthViewInfoList.Count to ACount - 1 do
    FMonthViewInfoList.Add(TcxSchedulerDateNavigatorMonthViewInfo.Create(Self));
end;

function TcxSchedulerDateNavigatorViewInfo.GetCol(X: Integer): Integer;
begin
  Result := (X - CalendarBounds.Left) div MonthSize.cx;
end;

function TcxSchedulerDateNavigatorViewInfo.GetHeaderRect(ACol, ARow: Integer): TRect;
begin
  with MonthSize do
    Result := cxRectOffset(cxRect(0, 0, cx, FHeaderHeight),
      CalendarBounds.Left + ACol * cx, CalendarBounds.Top + ARow * cy);
end;

function TcxSchedulerDateNavigatorViewInfo.GetInternalRect(ACol, ARow: Integer): TRect;
begin
  with MonthSize do
    Result := cxRectOffset(cxRect(0, FHeaderHeight, cx, cy),
      CalendarBounds.Left + ACol * cx, CalendarBounds.Top + ARow * cy);
end;

function TcxSchedulerDateNavigatorViewInfo.GetLeftArrowRect: TRect;
begin
  Result := cxRectBounds(CalendarBounds.Left + 1, CalendarBounds.Top + 1,
    FColWidth - 2, FHeaderHeight - 2);
end;

function TcxSchedulerDateNavigatorViewInfo.GetMonthRect(
  ACol, ARow: Integer): TRect;
begin
  with MonthSize do
    Result := cxRectOffset(cxRect(0, 0, cx, cy),
      CalendarBounds.Left + ACol * cx, CalendarBounds.Top + ARow * cy);
end;

function TcxSchedulerDateNavigatorViewInfo.GetRightArrowRect: TRect;
begin
  Result := cxRectBounds(CalendarBounds.Right - FColWidth,
    CalendarBounds.Top + HeaderBorderSize, FColWidth - HeaderBorderSize,
    FHeaderHeight - HeaderBorderSize);
end;

function TcxSchedulerDateNavigatorViewInfo.GetRow(Y: Integer): Integer;
begin
  Result := (Y - CalendarBounds.Top) div MonthSize.cy;
end;

procedure TcxSchedulerDateNavigatorViewInfo.CalcInternalSizes;
var
  ASymbolSize: TSize;
begin
  CalculateViewParams;
  FHeaderBorderSize := LookAndFeelPainter.ButtonBorderSize;
  FHeaderBorderSize := 1;
  ASymbolSize := cxTextExtent(ContentParams.Font, '0');
  FColWidth := 3 * ASymbolSize.cx - 1;
  FSideWidth := 2 * ASymbolSize.cx;
  FRowHeight := ASymbolSize.cy + 2;
  FDayCaptionsHeight := FRowHeight + 1;
  FHeaderHeight := cxTextHeight(HeaderParams.Font) + 5;
  FMonthSize.cx := (2 * FSideWidth + 7 * FColWidth);
  FMonthSize.cy := (FHeaderHeight + FDayCaptionsHeight + 6 * FRowHeight + 1);
end;

procedure TcxSchedulerDateNavigatorViewInfo.DestroyMonthViewInfoList;
var
  I: Integer;
begin
  for I := 0 to FMonthViewInfoList.Count - 1 do
    TcxSchedulerDateNavigatorMonthViewInfo(FMonthViewInfoList[I]).Free;
  FreeAndNil(FMonthViewInfoList);
end;

function TcxSchedulerDateNavigatorViewInfo.GetMonthViewInfo(
  ACol, ARow: Integer): TcxSchedulerDateNavigatorMonthViewInfo;
begin
  if (ARow < 0) or (ARow >= RowCount) or (ACol < 0) or (ACol >= ColCount) then
    Result := nil
  else
    Result := TcxSchedulerDateNavigatorMonthViewInfo(
      FMonthViewInfoList[ARow * ColCount + ACol]);
end;

initialization
  GetLocaleSettings;       

end.
