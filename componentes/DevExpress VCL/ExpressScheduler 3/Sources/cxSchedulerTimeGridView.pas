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

unit cxSchedulerTimeGridView;

{$I cxVer.inc}

interface

uses
  Windows, Forms, Classes, Math, StdCtrls, Graphics, Controls, ExtCtrls, Contnrs,
  SysUtils, Types, DateUtils, Menus,
  cxControls, cxEdit, cxGraphics, cxStyles, cxGeometry,
  cxLookAndFeelPainters, cxSchedulerCustomControls, cxSchedulerCustomResourceView,
  cxSchedulerUtils, cxSchedulerStorage, cxSchedulerStrs, cxDateUtils, cxClasses,
  cxDrawTextUtils, dxOffice11, cxScrollBar;

const
  htcMajorScale      = $11;
  htcMajorSeparator  = $12;
  htcMinorScale      = $13;
  htcSelectionBar    = $14;

  cxHorzEventIndent        = 2;

  cxMinutesPerDay          = 60 * 24;
  cxMinHourScale           =  1;
  cxMaxHourScale           = 60;
  cxMinColumnWidth         = 15;

  cxDefaultMinorUnitWidth = 50;

  cxMinSelectionBarHeight  = 5;

  // TimeGrid styles
  cxcsMajorScale          = 0;
  cxcsMajorScaleUnitSeparator = 1;
  cxcsMinorScale          = 3;
  cxcsSelectionBar        = 2;
  cxcsMaxTimeGridStyle    = cxcsSelectionBar;

type
  TcxSchedulerTimeGridView = class;
  TcxSchedulerTimeGridViewViewInfo = class;
  TcxSchedulerTimeGridSelectionBarCell = class;
  TcxSchedulerTimeGridMinorScaleCell = class;
  TcxSchedulerTimeGridMajorScaleCell = class;
  TcxSchedulerTimeBuilder = class;
  TcxSchedulerTimeGridViewHitTest = class;
  TcxSchedulerTimeGridMoreEventsButtonViewInfo = class;
  TcxSchedulerTimeGridScrollBar = class;
  TcxSchedulerTimeGridResourceScroll = class;
  //
  TcxSchedulerTimeGridScaleUnit = (suHour, suDay, suWeek, suMonth, suQuarter, suYear);
  TcxSchedulerTimeGridScaleUnits = set of TcxSchedulerTimeGridScaleUnit;
  TcxSchedulerTimeGridScaleTextType = (sttUnknown, sttShort, sttMiddle, sttLong);

  { TcxCustomWeekViewDragEventHelper }

  TcxTimeGridDragEventHelper = class(TcxDragEventHelper)
  private
    function GetHitTest: TcxSchedulerTimeGridViewHitTest;
  protected
    procedure CorrectAllDayEventProperty;
    function IsValidTime: Boolean; override;
    procedure UpdateViewClonesTime; override;

    property HitTest: TcxSchedulerTimeGridViewHitTest read GetHitTest;
  end;

  { TcxTimeGridEventSizing }

  TcxTimeGridEventSizing = class(TcxEventSizingHelper)
  private
    function GetTimeBuilder: TcxSchedulerTimeBuilder;
    function GetHitTest: TcxSchedulerTimeGridViewHitTest;
  protected
    function IsValidTime: Boolean; override;
    procedure UpdateEventBounds; override;

    property HitTest: TcxSchedulerTimeGridViewHitTest read GetHitTest;
    property TimeBuilder: TcxSchedulerTimeBuilder read GetTimeBuilder;
  end;

  { TcxSchedulerTimeGridViewController }

  TcxSchedulerTimeGridViewController = class(TcxSchedulerCustomResourceViewController)
  private
    FTimer: TTimer;
    function GetHitTest: TcxSchedulerTimeGridViewHitTest;
    function GetView: TcxSchedulerTimeGridView;
    function GetViewInfo: TcxSchedulerTimeGridViewViewInfo;
  protected
    FPos: TPoint;
    FIsEditingBeforeMouseDown: Boolean;
    function CreateDragEventHelper: TcxDragEventHelper; override;
    function CreateNavigation: TcxSchedulerViewNavigation; override;
    function CreateResizeEventHelper: TcxEventSizingHelper; override;
    // todo: scrolling timer (need move to CustomResourceView), and optimize day view
    procedure BeforeMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure CancelScroll; override;
    procedure CheckScrolling(const APos: TPoint); override;
    procedure InitTimer(AllowStart: Boolean; AScrollCode: TScrollCode); virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Scrolling(AScrollCode: TScrollCode; var AScrollPos: Integer); virtual;
    procedure SyncEventSelection(AEvent: TcxSchedulerControlEvent); override;
    procedure OnTimer(Sender: TObject); virtual;

    property HitTest: TcxSchedulerTimeGridViewHitTest read GetHitTest;
    property Timer: TTimer read FTimer;
    property View: TcxSchedulerTimeGridView read GetView;
    property ViewInfo: TcxSchedulerTimeGridViewViewInfo read GetViewInfo;
  public
    constructor Create(AOwner: TcxSchedulerSubControl); override;
    destructor Destroy; override;
  end;

  { TcxSchedulerTimeGridViewNavigation }

  TcxSchedulerTimeGridViewNavigation = class(TcxSchedulerCustomResourceViewNavigation)
  private
    function GetTimeBuilder: TcxSchedulerTimeBuilder;
    function GetView: TcxSchedulerTimeGridView;
    function GetViewInfo: TcxSchedulerTimeGridViewViewInfo;
  protected
    property TimeBuilder: TcxSchedulerTimeBuilder read GetTimeBuilder;
    property View: TcxSchedulerTimeGridView read GetView;
    property ViewInfo: TcxSchedulerTimeGridViewViewInfo read GetViewInfo;
  public
    procedure KeyDown(var AKey: Word; AShift: TShiftState); override;
    procedure ValidateSelection(var ASelStart, ASelFinish: TDateTime;
      var AResource: TcxSchedulerStorageResourceItem); override;
  end;

  { TcxSchedulerTimeGridViewStyles }

  TcxSchedulerGetScaleItemStyleEvent = procedure(Sender: TObject;
    const ADateTime: TDateTime; var AStyle: TcxStyle) of object;

  TcxSchedulerTimeGridViewStyles = class(TcxStyles)
  private
    FScheduler: TcxCustomScheduler;
    FOnGetMajorScaleParams: TcxSchedulerGetScaleItemStyleEvent;
    FOnGetMinorScaleParams: TcxSchedulerGetScaleItemStyleEvent;
    FOnGetSelectionBarParams: TcxSchedulerGetScaleItemStyleEvent;
    function GetTimeGrid: TcxSchedulerTimeGridView;
  protected
    procedure Changed(AIndex: Integer); override;
    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;
    function GetSelectionBarParamsEx(const ADateTime: TDateTime; ASelected: Boolean): TcxViewParams; virtual; 
    function IsTimeSelected(const ADateTime: TDateTime): Boolean;
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
    // time grid visual parameters
    function GetMajorScaleParams(const ADateTime: TDateTime): TcxViewParams;
    function GetMajorScaleUnitSeparatorParams: TcxViewParams;
    function GetMinorScaleParams(const ADateTime: TDateTime): TcxViewParams;
    function GetSelectionBarParams(const ADateTime: TDateTime): TcxViewParams;

    property Scheduler: TcxCustomScheduler read FScheduler;
    property TimeGrid: TcxSchedulerTimeGridView read GetTimeGrid;
  published
    property MajorScale: TcxStyle index cxcsMajorScale read GetValue write SetValue;
    property MajorScaleUnitSeparator: TcxStyle index cxcsMajorScaleUnitSeparator read GetValue write SetValue;
    property MinorScale: TcxStyle index cxcsMinorScale read GetValue write SetValue;
    property SelectionBar: TcxStyle index cxcsSelectionBar read GetValue write SetValue;
    property OnGetMajorScaleParams: TcxSchedulerGetScaleItemStyleEvent read FOnGetMajorScaleParams write FOnGetMajorScaleParams;    
    property OnGetMinorScaleParams: TcxSchedulerGetScaleItemStyleEvent read FOnGetMinorScaleParams write FOnGetMinorScaleParams;
    property OnGetSelectionBarParams: TcxSchedulerGetScaleItemStyleEvent read FOnGetSelectionBarParams write FOnGetSelectionBarParams;
  end;

  { TcxSchedulerTimeGridViewScales }

  TcxSchedulerTimeGridViewScales = class(TPersistent)
  private
    FMajor: Boolean;
    FMajorUnit: TcxSchedulerTimeGridScaleUnit;
    FMajorUnitSeparatorWidth: Integer;
    FMinor: Boolean;
    FMinorUnit: TcxSchedulerTimeGridScaleUnit;
    FMinorUnitWidth: Integer;
    FOwner: TcxSchedulerTimeGridView;
    FTimeStep: Integer;
    function GetScheduler: TcxCustomScheduler;
    procedure SetMajor(AValue: Boolean);
    procedure SetMajorUnit(AValue: TcxSchedulerTimeGridScaleUnit);
    procedure SetMajorUnitSeparatorWidth(AValue: Integer);
    procedure SetMinor(AValue: Boolean);
    procedure SetMinorUnit(AValue: TcxSchedulerTimeGridScaleUnit);
    procedure SetMinorUnitWidth(AValue: Integer);
    procedure SetTimeStep(AValue: Integer);
  protected
    procedure Changed; virtual;
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TcxSchedulerTimeGridView); virtual;
    procedure Assign(Source: TPersistent); override;

    property Scheduler: TcxCustomScheduler read GetScheduler;
    property TimeGrid: TcxSchedulerTimeGridView read FOwner;
  published
    property Major: Boolean read FMajor write SetMajor default True;
    property MajorUnit: TcxSchedulerTimeGridScaleUnit read FMajorUnit write SetMajorUnit default suDay;
    property MajorUnitSeparatorWidth: Integer read FMajorUnitSeparatorWidth write SetMajorUnitSeparatorWidth default cxDefaultSplitterWidth;
    property Minor: Boolean read FMinor write SetMinor default True;
    property MinorUnit: TcxSchedulerTimeGridScaleUnit read FMinorUnit write SetMinorUnit default suHour;
    property MinorUnitWidth: Integer read FMinorUnitWidth write SetMinorUnitWidth default cxDefaultMinorUnitWidth;
    property TimeStep: Integer read FTimeStep write SetTimeStep default 30;
  end;

  { TcxSchedulerTimeGridViewHitTest }

  TcxSchedulerTimeGridViewHitTest = class(TcxSchedulerCustomResourceViewHitTest)
  protected
    function HitAtScale: Boolean;
  public
    property HitAtMajorScale: Boolean index htcMajorScale read GetBitState;
    property HitAtMajorSeparator: Boolean index htcMajorSeparator read GetBitState;
    property HitAtMinorScale: Boolean index htcMinorScale read GetBitState;
    property HitAtSelectionBar: Boolean index htcSelectionBar read GetBitState;
  end;

  { TcxSchedulerTimeGridView }

  TcxSchedulerCustomDrawMajorUnitEvent = procedure(Sender: TObject; ACanvas: TcxCanvas;
    AViewInfo: TcxSchedulerTimeGridMajorScaleCell; var ADone: Boolean) of object;
  TcxSchedulerCustomDrawMinorUnitEvent  = procedure(Sender: TObject; ACanvas: TcxCanvas;
    AViewInfo: TcxSchedulerTimeGridMinorScaleCell; var ADone: Boolean) of object;
  TcxSchedulerCustomDrawSelectionBarEvent  = procedure(Sender: TObject; ACanvas: TcxCanvas;
    AViewInfo: TcxSchedulerTimeGridSelectionBarCell; var ADone: Boolean) of object;

  TcxSchedulerTimeGridViewGetUnitDisplayTextEvent = procedure(Sender: TcxSchedulerTimeGridView;
    const AStart, AFinish: TDateTime; ATextType: TcxSchedulerTimeGridScaleTextType; var AText: string) of object;

  TcxSchedulerTimeGridView = class(TcxSchedulerCustomResourceView)
  private
    FEventMaxLineCount: Integer;
    FScales: TcxSchedulerTimeGridViewScales;
    FEventDetailInfo: Boolean;
    FShowMoreEventsButton: Boolean;
    FShowResourceScrollBar: Boolean;
    FSnapEventsToTimeSlots: Boolean;
    FStyles: TcxSchedulerTimeGridViewStyles;
    FVisibleFinish: TDateTime;
    FVisibleStart: TDateTime;
    FWorkDaysOnly: Boolean;
    FWorkTimeOnly: Boolean;
    FOnCustomDrawMajorUnit: TcxSchedulerCustomDrawMajorUnitEvent;
    FOnCustomDrawMinorUnit: TcxSchedulerCustomDrawMinorUnitEvent;
    FOnCustomDrawSelectionBar: TcxSchedulerCustomDrawSelectionBarEvent;
    FOnGetMajorUnitDisplayText: TcxSchedulerTimeGridViewGetUnitDisplayTextEvent;
    FOnGetMinorUnitDisplayText: TcxSchedulerTimeGridViewGetUnitDisplayTextEvent;
    function GetHitTest: TcxSchedulerTimeGridViewHitTest;
    function GetViewInfo: TcxSchedulerTimeGridViewViewInfo;
    procedure SetEventMaxLineCount(AValue: Integer);
    procedure SetScales(AValue: TcxSchedulerTimeGridViewScales);
    procedure SetShowMoreEventsButton(AValue: Boolean);
    procedure SetShowResourceScrollBar(AValue: Boolean);
    procedure SetEventDetailInfo(AValue: Boolean);
    procedure SetSnapEventsToTimeSlots(AValue: Boolean);
    procedure SetStyles(AValue: TcxSchedulerTimeGridViewStyles);
    procedure SetVisibleStart(AValue: TDateTime);
    procedure SetWorkDaysOnly(AValue: Boolean);
    procedure SetWorkTimeOnly(AValue: Boolean);
  protected
    FLockSelectionCounter: Integer;
    FScrollPosition: Integer;
    FScrollUpdateLocked: Boolean;
    ScaleTextType: TcxSchedulerTimeGridScaleTextType;
    function CanDeactivateOnDateNavigatorSelectionChange: Boolean; override;
    function CanSelectPeriod: Boolean; override;
    procedure Changed; override;
    procedure CheckRefresh;
    function CreateController: TcxSchedulerSubControlController; override;
    function CreateHitTest: TcxSchedulerSubControlHitTest; override;
    function CreatePainter: TcxSchedulerSubControlPainter; override;
    function CreateScales: TcxSchedulerTimeGridViewScales; virtual;
    function CreateStyles: TcxSchedulerTimeGridViewStyles; virtual;
    function CreateViewAdapter: TcxCustomResourceViewAdapter; override;
    function CreateViewInfo: TcxSchedulerSubControlViewInfo; override;
    procedure DeactivateView; override;
    procedure DoDrawSelectionBarCell(AItem: TcxSchedulerTimeGridSelectionBarCell; var ADone: Boolean); virtual;
    procedure DoDrawTimeLineCell(AItem: TcxSchedulerTimeGridMinorScaleCell; var ADone: Boolean); virtual;
    procedure DoDrawTimeLineHeaderCell(AItem: TcxSchedulerTimeGridMajorScaleCell; var ADone: Boolean); virtual;
    procedure DoGetMajorUnitDisplayText(const AStart, AFinish: TDateTime;
      ATextType: TcxSchedulerTimeGridScaleTextType; var AText: string); virtual;
    procedure DoGetMinorUnitDisplayText(const AStart, AFinish: TDateTime;
      ATextType: TcxSchedulerTimeGridScaleTextType; var AText: string); virtual;
    function GetCompressWeekEnd: Boolean; override;
    function GetControlEventLineStart(AEvent: TcxSchedulerControlEvent): Integer;
    function GetEditWithSingleLineEditor(AEvent: TcxSchedulerControlEvent): Boolean; override;
    function GetFirstVisibleDate: TDateTime; override;
    function GetFirstVisibleTime: TDateTime; override;
    function GetLastVisibleDate: TDateTime; override;
    function GetLastVisibleTime: TDateTime; override;
    function GetScrollTimeHint: string; override;
    function GetTimeIncrement: TDateTime; override;
    function GetViewContentRect: TRect; override;
    procedure InitScrollBarsParameters; override;
    function IsSnapEventsToTimeSlots: Boolean;
    procedure MakeEventVisible(AEvent: TcxSchedulerControlEvent;
      const ADate: TDateTime; AResource: TcxSchedulerStorageResourceItem); override;
    procedure MakeLineVisible(AResource: TcxSchedulerStorageResourceItem;
      AEvent: TcxSchedulerControlEvent); virtual;
    procedure ScaleChanged; virtual;
    procedure Scroll(AScrollBarKind: TScrollBarKind;
      AScrollCode: TScrollCode; var AScrollPos: Integer); override;
    procedure SelectedDaysChanged; override;
    procedure UpdateDateNavigatorSelection;
    procedure ValidateSelectionFinishTime(var ADateTime: TDateTime); override;
    procedure VisibleChanged; override;
    //
    property ViewInfo: TcxSchedulerTimeGridViewViewInfo read GetViewInfo;
  public
    constructor Create(AOwner: TcxCustomScheduler); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetMajorUnitDisplayText(const AStart, AFinish: TDateTime;
      ATextType: TcxSchedulerTimeGridScaleTextType): string;
    function GetMinorUnitDisplayText(const AStart, AFinish: TDateTime;
      ATextType: TcxSchedulerTimeGridScaleTextType): string;

    property HitTest: TcxSchedulerTimeGridViewHitTest read GetHitTest;
    property VisibleFinish: TDateTime read FVisibleFinish;
    property VisibleStart: TDateTime read FVisibleStart write SetVisibleStart;
  published
    property Active;
    property EventImagesLayout default eilAuto;
    property EventMaxLineCount: Integer read FEventMaxLineCount write SetEventMaxLineCount default 0;
    property Scales: TcxSchedulerTimeGridViewScales read FScales write SetScales;
    property ShowMoreEventsButton: Boolean read FShowMoreEventsButton write SetShowMoreEventsButton default True;
    property ShowResourceScrollBar: Boolean read FShowResourceScrollBar write SetShowResourceScrollBar default True;
    property Styles: TcxSchedulerTimeGridViewStyles read FStyles write SetStyles;
    property EventDetailInfo: Boolean read FEventDetailInfo write SetEventDetailInfo default False;
    property ShowTimeAsClock;
    property SnapEventsToTimeSlots: Boolean read FSnapEventsToTimeSlots write SetSnapEventsToTimeSlots default True;
    property WorkDaysOnly: Boolean read FWorkDaysOnly write SetWorkDaysOnly default False;
    property WorkTimeOnly: Boolean read FWorkTimeOnly write SetWorkTimeOnly default False;
    property OnCustomDrawMajorUnit: TcxSchedulerCustomDrawMajorUnitEvent read FOnCustomDrawMajorUnit write FOnCustomDrawMajorUnit;
    property OnCustomDrawMinorUnit: TcxSchedulerCustomDrawMinorUnitEvent read FOnCustomDrawMinorUnit write FOnCustomDrawMinorUnit;
    property OnCustomDrawSelectionBar: TcxSchedulerCustomDrawSelectionBarEvent read FOnCustomDrawSelectionBar write FOnCustomDrawSelectionBar;
    property OnGetMajorUnitDisplayText: TcxSchedulerTimeGridViewGetUnitDisplayTextEvent read FOnGetMajorUnitDisplayText write FOnGetMajorUnitDisplayText;
    property OnGetMinorUnitDisplayText: TcxSchedulerTimeGridViewGetUnitDisplayTextEvent read FOnGetMinorUnitDisplayText write FOnGetMinorUnitDisplayText;
  end;

  { TcxSchedulerTimeBuilder }

  TcxSchedulerTimeBuilder = class
  protected
    CheckTime: Boolean;
    CheckDays: Boolean;
    CheckMidnight: Boolean;
    MajorUnit: TcxSchedulerTimeGridScaleUnit;
    MinorUnit: TcxSchedulerTimeGridScaleUnit;
    TimeScale: Integer;
    TimeStep : Integer;
    ScaleUnit: TDateTime;
    WorkDays: TDays;
    WorkFinish: TDateTime;
    WorkStart: TDateTime;
    function CalculateDateTime(const ADateTime: TDateTime; AInc: Integer): TDateTime;
    function CalculateDateTimeDateTimeWithoutCheckWorkDays(const ADateTime: TDateTime; AInc: Integer): TDateTime;
    function CalculateScaleUnit(const AScaleUnit: Integer): Integer;
    procedure CalculateWorkTime(AIsWorkTimeOnly: Boolean; var AWorkStart, AWorkFinish: TDateTime);
    procedure CalculateWorkDays(AIsWorkDaysOnly: Boolean; var AWorkDays: TDays);
    function GetScaleStep: TDateTime;
    function RoundTime(const ADateTime: TDateTime): TDateTime;
    procedure ValidateMidnightForward(var ADateTime: TDateTime);
    function ValidateStartTime(const ADateTime: TDateTime): TDateTime;
    function ValidateTime(var ADateTime: TDateTime; AGoForward: Boolean; AInc: Integer = 1): Boolean;
    procedure ValidateUnits(var AMajorUnit, AMinorUnit: TcxSchedulerTimeGridScaleUnit);
  public
    procedure CalculateActualStart(var ActualStart, AVisibleStart: TDateTime;
      var AStartIndex: Integer);
    procedure CheckWorkDays(var ADateTime: TDateTime; AGoForward: Boolean);
    function Dec(const ADateTime: TDateTime): TDateTime;
    function Inc(const ADateTime: TDateTime): TDateTime;
    procedure Initialize(AView: TcxSchedulerTimeGridView; AWorkTimeOnly, AWorkDaysOnly: Boolean);
    function IsPeriodChanged(const AFirst, ANext: TDateTime): Boolean;
    function TimeCorrected(var AStart, AFinish: TDateTime; AGoForward: Boolean = True): Boolean;
    function TimeMode: Boolean;
    procedure ValidateVisibleStart(var ADateTime: TDateTime);
  end;

  { TcxSchedulerTimeGridViewEventCellViewInfo }

  TcxSchedulerTimeGridViewEventCellViewInfo = class(TcxSchedulerEventCellViewInfo)
  protected
    procedure CalculateCaptions; override;
    procedure CalculateDetailInfo; override;
    procedure CalculateEventTimeAsClockLayout(const ABounds: TRect;
      const ACaptionWidth, AImagesWidth: Integer; var ALeft: Integer); override;
    procedure CalculateEventTimeVisibility; override;
    function CalculateNonDetailEventImages(const ACaptionWidth: Integer;
      out AImagesWidth: Integer): TRect; override;
    procedure CalculateItemsLayout; override;
    procedure CalculateShowTimeAsClock; override;
    function GetEditingRect: TRect; override;
    procedure InitHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest); override;
  end;

  { IcxSchedulerTimeGridViewAdapter }

  IcxSchedulerTimeGridViewAdapter = interface
  ['{A1808B72-237C-41D0-B864-BE8E24894F22}']
    function GetLineOffset: Integer;
    function GetShowResourceHeaders: Boolean;
    function GetShowLinks: Boolean;
    function GetShowScales: Boolean;
    function GetWorkDaysOnly: Boolean;
    function GetWorkTimeOnly: Boolean;
  end;

  { TcxSchedulerTimeGridViewAdapter }

  TcxSchedulerTimeGridViewAdapter = class(TcxCustomResourceViewAdapter, IcxSchedulerTimeGridViewAdapter)
  protected
    FVisibleStart: TDateTime;
    function GetLineOffset: Integer;
    function GetPrintRange(Index: Integer): TDateTime; override;
    function GetShowLinks: Boolean;
    function GetShowResourceHeaders: Boolean;
    function GetShowScales: Boolean;
    function GetWorkDaysOnly: Boolean;
    function GetWorkTimeOnly: Boolean;
    procedure Store; override;
    procedure Restore; override;
  end;

  { TcxSchedulerTimeGridViewViewInfo }

  TcxSchedulerTimeGridViewViewInfo = class(TcxSchedulerCustomResourceViewViewInfo)
  private
    FResourceViewShift: TcxObjectList;
    procedure CalculateResourceViewShifts(ABuilder: TcxSchedulerEventLayoutBuilder);
    procedure ClearMoreEventButtons;
    function GetGroupCount: Integer;
    function GetGroupLineCount(AIndex: Integer): Integer;
    function GetResourceHeight: Integer;
    function GetResourceViewShift(Index: Integer): TcxSchedulerTimeGridResourceScroll;
    function GetTimeGridView: TcxSchedulerTimeGridView;
    function GetVisibleLineCount(AResourceIndex: Integer): Integer;
    procedure PrepareMoreEventButtons;
    // calculate scales items
    procedure CalculateMajorScale;
    procedure CalculateMinorScale;
    procedure CalculateSelectionBar;
  protected
    FActualStartTime: TDateTime;
    FColumnCount: Integer;
    FColumnWidth: Integer;
    FEventMinSize: Integer; 
    FEventRowHeight: Integer;
    FFirstVisibleIndex: Integer;
    FLastVisibleTime: TDateTime;
    FLineOffset: Integer; 
    FMajorScaleHeight: Integer;
    FMajorTextType: TcxSchedulerTimeGridScaleTextType;
    FMinorScaleHeight: Integer;
    FMinorTextType: TcxSchedulerTimeGridScaleTextType;
    FPrintResourceHeaders: Boolean;
    FPrintScales: Boolean;
    FResourceHeaderWidth: Integer;
    FScales: TcxSchedulerTimeGridViewScales;
    FScalesBounds: TRect;
    FScalesHeight: Integer;
    FScaleUnit: TDateTime;
    FSelectionBarHeight: Integer;
    FSeparatorWidth: Integer;
    FShowLinks: Boolean;
    FTimeBuilder: TcxSchedulerTimeBuilder;
    FTimeLineCells: TcxSchedulerViewInfoCellList;
    FVisibleColumnCount: Integer;
    FWorkTimeOnly: Boolean;
    FWorkDaysOnly: Boolean;
    procedure AddEventForCalculation(ABuilder: TcxSchedulerEventLayoutBuilder;
      AEvent: TcxSchedulerControlEvent; AResourceIndex: Integer); virtual;
    function AddEventViewInfo(APlace: TcxSchedulerEventPlace; AResourceIndex: Integer;
      const AStart, AFinish: TDateTime): TcxSchedulerEventCellViewInfo;
    procedure AddMajorScaleCell(ABounds: TRect; const AStart, AFinish: TDateTime); virtual;
    procedure AddMajorSeparator(var ALeft: Integer);
    procedure AddMinorScaleCell(const ABounds: TRect; const AStart, AFinish: TDateTime); virtual;
    function AddSelectionBarCell(const ABounds: TRect;
      const AStart, AFinish: TDateTime): TcxSchedulerTimeGridSelectionBarCell; virtual;
    procedure AddTimeLineItem(AClass: TcxSchedulerCustomViewInfoItemClass; const ABounds: TRect;
      AType: Byte; const AStart, AFinish: TDateTime; const AViewParams: TcxViewParams; var Instance);
    procedure AdjustTextType;
    procedure CalculateContentCells; virtual;
    procedure CalculateEventPosition(AEvent: TcxSchedulerControlEvent;
      AColIndex: Integer; out AStartX, AFinishX: Integer; out AStart, AFinish: TDateTime);
    procedure CalculateEvents; virtual;
    procedure CalculateMetrics; override;
    procedure CalculateResourceBounds;
    procedure CalculateResourceHeaderCells; virtual;
    procedure CalculateResourceHeadersAutoHeight(AWidth: Integer); override;
    procedure CalculateResourceTopBottom(AResourceIndex: Integer; var ABounds: TRect);
    procedure CalculateScales; virtual;
    procedure CalculateScalesHeight;
    procedure ChangeResourceShift(AResourceIndex, ADelta: Integer);
    procedure CheckEventVisibility(ACell: TcxSchedulerEventCellViewInfo; AIndex: Integer); virtual;
    function CheckFinishTime(const ATime: TDateTime; AUnit: TcxSchedulerTimeGridScaleUnit): TDateTime; virtual;
    procedure Clear; override;
    function CreateEventCellViewInfo(AViewData: TcxSchedulerEventViewData): TcxSchedulerEventCellViewInfo; override;
    function CreateLayoutBuilder: TcxSchedulerEventLayoutBuilder; virtual;
    procedure DoCalculate; override;
    procedure DoContentNavigationButtonClick(Sender: TcxSchedulerContentNavigationButtonViewInfo); override;
    procedure DoResourceVerticalScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure DoTimeGridMoreEventsButtonClick(Sender: TcxSchedulerMoreEventsButtonViewInfo);
    function IsColumnEvent(AEvent: TcxSchedulerControlEvent; AColumnIndex: Integer): Boolean;
    function IsEventVisible(AEvent: TcxSchedulerControlEvent): Boolean; virtual;
    function IsMinorUnitBreak(AColumn: Integer): Boolean;
    function GetActualPos(const APos: Integer; const  ATime, AStart, AFinish: TDateTime ): Integer; virtual;
    function GetContentParams(const ATime: TDateTime;
      AResource: TcxSchedulerResourceViewInfo): TcxViewParams; override;
    function GetEventClipRect(AEventViewInfo: TcxSchedulerEventCellViewInfo): TRect;
    function GetIndentBetweenLines: Integer; virtual;
    procedure GetItemInfo(AIndex1, AIndex2, ATop, AHeight: Integer;
      var ABounds: TRect; var AStart, AFinish: TDateTime);
    function GetNeedShowCurrentTime: Boolean; virtual;
    function GetMoreEventButtonClass: TcxSchedulerMoreEventsButtonViewInfoClass; override;
    function GetResourceScrollBarMax(I: Integer): Integer;
    function GetResourceImagesSize: TSize; override;
    function GetResourcesContentWidth: Integer; override;
    function GetResourceScrollBarKind: TScrollBarKind; override;
    function GetStyleFont(AStyle: TcxStyle): TFont;
    procedure MakeTimeVisible(const ATime: TDateTime); override;
    function MeasureFontHeight(AStyle: TcxStyle; AHeight: Integer; Borders: TcxBorders): Integer;
    procedure Realign(APlace: TcxSchedulerEventPlace);
    procedure ReturnVisibleInterval(var AStart, AEnd: TDateTime); override;
    procedure RestoreScrollInfo;
    procedure StoreScrollInfo;
    procedure ValidateStartTime;

    property ResourceViewShift[Index: Integer]: TcxSchedulerTimeGridResourceScroll read GetResourceViewShift;
    property ResourceViewShiftList: TcxObjectList read FResourceViewShift;
    property VisibleLineCount[Index: Integer]: Integer read GetVisibleLineCount;
  public
    constructor Create(AOwner: TcxSchedulerSubControl); override;
    destructor Destroy; override;
    procedure CalculateHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest); override;

    property ActualStartTime: TDateTime read FActualStartTime;
    property ColumnCount: Integer read FColumnCount;
    property ColumnWidth: Integer read FColumnWidth;
    property FirstVisibleIndex: Integer read FFirstVisibleIndex;
    property IndentBetweenLines: Integer read GetIndentBetweenLines;
    property GroupCount: Integer read GetGroupCount;
    property GroupLineCount[Index: Integer]: Integer read GetGroupLineCount;
    property MajorTextType: TcxSchedulerTimeGridScaleTextType read FMajorTextType;
    property MinorTextType: TcxSchedulerTimeGridScaleTextType read FMinorTextType;
    property Scales: TcxSchedulerTimeGridViewScales read FScales;
    property ScalesHeight: Integer read FScalesHeight;
    property ScaleUnit: TDateTime read FScaleUnit;
    property TimeBuilder: TcxSchedulerTimeBuilder read FTimeBuilder;
    property TimeLineCells: TcxSchedulerViewInfoCellList read FTimeLineCells;
    property ResourceHeaderWidth: Integer read FResourceHeaderWidth;
    property View: TcxSchedulerTimeGridView read GetTimeGridView;
    property VisibleColumnCount: Integer read FVisibleColumnCount;
    property WorkDaysOnly: Boolean read FWorkDaysOnly;
    property WorkTimeOnly: Boolean read FWorkTimeOnly;
  end;

  { TcxSchedulerTimeGridScaleCell }

  TcxSchedulerTimeGridScaleCell = class(TcxSchedulerCustomViewInfoItem)
  private
    FAlignHorz: TAlignment;
    FAlignVert: TcxAlignmentVert;
    FBorderColor: TColor;
  protected
    FTimeFinish: TDateTime;
    ItemType: Integer;
    property AlignHorz: TAlignment read FAlignHorz write FAlignHorz;
    property AlignVert: TcxAlignmentVert read FAlignVert write FAlignVert;
    property BorderColor: TColor read FBorderColor write FBorderColor;
    property TimeFinish: TDateTime read FTimeFinish;
    property TimeStart: TDateTime read FDateTime;
  public
    constructor Create(APainter: TcxCustomLookAndFeelPainterClass;
      const ABounds, AVisibleRect: TRect; const AViewParams: TcxViewParams); override;
  end;

  { TcxSchedulerTimeGridMinorScaleCell }

  TcxSchedulerTimeGridMinorScaleCell = class(TcxSchedulerTimeGridScaleCell)
  protected
    FHideDisplayText: Boolean;
    FTextBounds: TRect;
    procedure Calculate; virtual;
    procedure DoDraw; override;
    procedure DrawContent;
    procedure InitHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest); override;
  public
    property AlignHorz;
    property AlignVert;
    property BorderColor;
    property DisplayText;
    property TimeFinish;
    property TimeStart;
    property TextBounds: TRect read FTextBounds; 
  end;

  { TcxSchedulerTimeGridMajorScaleCell }

  TcxSchedulerTimeGridMajorScaleCell = class(TcxSchedulerTimeGridMinorScaleCell)
  protected
    FRightIndent: Integer;
    procedure Calculate; override;
    procedure DoDraw; override;
    procedure InitHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest); override;
  public
    property DisplayText;
    property HideDisplayText: Boolean read FHideDisplayText write FHideDisplayText;
    property RightIndent: Integer read FRightIndent;
  end;

  { TcxSchedulerTimeGridSelectionBarCell }

  TcxSchedulerTimeGridSelectionBarCell = class(TcxSchedulerTimeGridMinorScaleCell)
  protected
    FIsCurrentTimeCell: Boolean;
    FSelected: Boolean;
    FShowCurrentTime: Boolean;
    FTimeLineRect: TRect;
    FViewHeight: Integer;
    procedure Calculate; override;
    procedure CalculateTimeLineParams(ANeedShowCurrentTime: Boolean);
    procedure DoDraw; override;
    procedure InitHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest); override;

    property ViewHeight: Integer read FViewHeight;
  public
    property IsCurrentTimeCell: Boolean read FIsCurrentTimeCell;
    property Selected: Boolean read FSelected;
    property ShowCurrentTime: Boolean read FShowCurrentTime;
    property TimeLineRect: TRect read FTimeLineRect;
  end;

  { TcxSchedulerMajorSeparatorCellViewInfo }

  TcxSchedulerMajorSeparatorCellViewInfo = class(TcxSchedulerGroupSeparatorCellViewInfo)
  protected
    FContentBounds: TRect;
    procedure DoDraw; override;
    procedure InitHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest); override;
  public
    property ContentBounds: TRect read FContentBounds;
  end;

  { TcxSchedulerTimeGridViewPainter }

  TcxSchedulerTimeGridViewPainter = class(TcxSchedulerCustomViewPainter)
  private
    FView: TcxSchedulerTimeGridView;
    function GetViewInfo: TcxSchedulerTimeGridViewViewInfo;
  protected
    procedure DrawTimeLineCellItem(AItem: TcxSchedulerCustomViewInfoItem; var ADone: Boolean); virtual;
    //
  public
    procedure Paint; override;
    property View: TcxSchedulerTimeGridView read FView;
    property ViewInfo: TcxSchedulerTimeGridViewViewInfo read GetViewInfo;
  end;

  { TcxSchedulerTimeGridMoreEventsButton }

  TcxSchedulerTimeGridMoreEventsButtonViewInfo = class(TcxSchedulerMoreEventsButtonViewInfo)
  private
    FDelta: Integer;
    FResourceIndex: Integer;
    FValidDelta: Boolean;
  public
    property Delta: Integer read FDelta write FDelta;
    property ResourceIndex: Integer read FResourceIndex write FResourceIndex;
    property ValidDelta: Boolean read FValidDelta write FValidDelta;
  end;

  { TcxSchedulerTimeGridScrollBar }

  TcxSchedulerTimeGridScrollBar = class(TcxControlScrollBar)
  private
    FResourceIndex: Integer;
  public
    property ResourceIndex: Integer read FResourceIndex;
  end;

  { TcxSchedulerTimeGridResourceScroll }

  TcxSchedulerTimeGridResourceScroll = class
  private
    FData: Integer;
    FEventMaxLine: Integer;
    FMoreEventButtons: array of TcxSchedulerMoreEventsButtonViewInfo;
    FScrollBar: TcxSchedulerTimeGridScrollBar;
  protected
    FShift: Integer;
    procedure ClearMoreEventButtons;
    procedure SetEventMaxLine(AValue: Integer);
    procedure Store(AClear: Boolean);
    procedure Restore;
  public
    destructor Destroy; override;
    procedure CreateScrollBar(AResourceBounds: TRect;
      ATimeGridView: TcxSchedulerTimeGridView; AResourceIndex, ARange, APosition: Integer);

    property ScrollBar: TcxSchedulerTimeGridScrollBar read FScrollBar;
  end;

const
  ValidMinorUnits: array[TcxSchedulerTimeGridScaleUnit] of TcxSchedulerTimeGridScaleUnits =
    ([], [suHour], [suDay], [suDay], [suDay, suMonth], [suDay, suMonth, suQuarter]);

  // unit caption text formats

  WeekTextFormats: array[TcxSchedulerTimeGridScaleTextType] of string =
    ('mmmm dd, yyyy', 'mmm dd, yy', 'mmmm dd, yy', 'mmmm dd, yyyy');
  MonthTextFormats: array[TcxSchedulerTimeGridScaleTextType] of string =
    ('mmmm, yyyy', 'mm, yy', 'mmm, yy', 'mmmm, yyyy');
  QuarterTextFormats: array[TcxSchedulerTimeGridScaleTextType, 0..3] of string =
   (('Q1{ ''yy}', 'Q2{ ''yy}', 'Q3{ ''yy}', 'Q4{ ''yy}'),
    ('Q1{ ''yy}', 'Q2{ ''yy}', 'Q3{ ''yy}', 'Q4{ ''yy}'),
    ('Q1{ ''yyyy}', 'Q2{ ''yyyy}', 'Q3 ''{yyyy}', 'Q4{ ''yyyy}'),
    ('1st Quarter{, yyyy}', '2nd Quarter{, yyyy}',
     '3rd Quarter{, yyyy}', '4th Quarter{, yyyy}'));
  YearTextFormats: array[0..1] of string = ('yyyy', 'yy');

implementation

uses
  dxCore;

const
  DefaultBorders = [bRight, bBottom];
  Direction: array[Boolean] of Integer = (-1, 1);

  ScrollMaxPos: Integer = 50;
  ScrollPage: Integer = 5;

type
  TcxSchedulerControlEventAccess = class(TcxSchedulerControlEvent);

function cxTimeLineCellsCompare(ACell1, ACell2: TcxSchedulerTimeGridMinorScaleCell): Integer;
begin
  Result := ACell2.Bounds.Top - ACell1.Bounds.Top;
  if Result = 0 then
    Result := ACell2.Bounds.Left - ACell1.Bounds.Left;
end;

function GetQuarterAsText(ATextType: TcxSchedulerTimeGridScaleTextType;
   const ADateTime: TDateTime; AIncludeYear: Boolean = False): string;
var
  I, J, K: Integer;
  AYear: string;
  ValidYearFormat: Boolean;
const
  UnusedChars = [' ', '''', ',', '_'];
begin
  Result := QuarterTextFormats[ATextType, (MonthOf(ADateTime) - 1) div 3];
  I := Pos('{', Result);
  J := Pos('}', Result);
  ValidYearFormat := (I > 0) and (J > 0) and (J > I);
  if ValidYearFormat then
  begin
    if AIncludeYear then
    begin
      Delete(Result, J, 1);
      Delete(Result, I, 1);
      for K := 0 to High(YearTextFormats) do
      begin
        I := Pos(YearTextFormats[K], Result);
        if I = 0 then Continue;                                          
        AYear := FormatDateTime(YearTextFormats[K], ADateTime);
        Delete(Result, I, Length(YearTextFormats[K]));
        Insert(AYear, Result, I);
        Break;
      end
    end
    else
      Delete(Result, I, J - I + 1);
  end;
end;

function GetMinorCellDisplayText(ATextType: TcxSchedulerTimeGridScaleTextType;
  AScale, AMajorScale: TcxSchedulerTimeGridScaleUnit; const AStart, AFinish: TDateTime): string;
begin
  case AScale of
    suHour:                    
      Result := DateTimeHelper.TimeToStr(TimeOf(AStart));
    suDay:
    begin
      if ATextType in [sttLong, sttUnknown] then
        Result := DateTimeHelper.DateToLongDateStr(AStart)
      else
        if AMajorScale <= suMonth then
          Result := FormatDateTime('d ddd', AStart)
        else
          Result := FormatDateTime('d/m', AStart);
    end;
    suWeek:
      Result := GetMinorCellDisplayText(ATextType, suDay, AMajorScale, AStart, AStart) + '-'
        + GetMinorCellDisplayText(ATextType, suDay, AMajorScale, AFinish, AFinish);
    suMonth:
      Result := dxFormatSettings.LongMonthNames[MonthOf(AStart)];//
    suQuarter:
      Result := GetQuarterAsText(ATextType, AStart);
    suYear:
      Result := IntToStr(YearOf(AStart));
  else
    Result := '';
  end;
end;

function GetMajorCellDisplayText(ATextType: TcxSchedulerTimeGridScaleTextType;
  AScale: TcxSchedulerTimeGridScaleUnit; const AStart, AFinish: TDateTime): string;
begin
  case AScale of
    suDay:
      if ATextType = sttLong then
        Result := DateTimeHelper.DateToLongDateStr(AStart)
      else
        Result := DateTimeHelper.DateToLongDateStr(AStart);
    suWeek:
      Result := FormatDateTime(WeekTextFormats[ATextType], AStart) +
        ' - ' + FormatDateTime(WeekTextFormats[ATextType], AFinish);
    suMonth:
      Result := FormatDateTime(MonthTextFormats[ATextType], AStart);
    suQuarter:
      Result := GetQuarterAsText(ATextType, AStart, True);
    suYear:
      Result := GetMinorCellDisplayText(ATextType, suYear, suYear, AStart, AFinish);
  else
    Result := '';
  end;
end;

{ TcxTimeGridDragEventHelper }

procedure TcxTimeGridDragEventHelper.CorrectAllDayEventProperty;
var
  I: Integer;
  AEvent: TcxSchedulerControlEvent;
  ASaveStart, ASaveFinish: TDateTime;
  AllDay: Boolean;
begin
  for I := 0 to Clones.Count - 1 do
  begin
    AEvent := Clones[I];
    with AEvent do
    begin
      AllDay := (TimeOf(Start) = 0) and (TimeOf(Finish) = 0) and (Duration >= 1);
      if AllDay <> AllDayEvent then
      begin
        if AllDayEvent then
        begin
          ASaveStart := Start;
          ASaveFinish := Finish;
          AllDayEvent := False;
          Start := ASaveStart;
          Finish := ASaveFinish;
        end
        else
          AllDayEvent := True;
        CheckEventState(AEvent);
      end;
    end;
  end;
end;

function TcxTimeGridDragEventHelper.GetHitTest: TcxSchedulerTimeGridViewHitTest;
begin
  Result := TcxSchedulerTimeGridViewHitTest(inherited HitTest);
end;

function TcxTimeGridDragEventHelper.IsValidTime: Boolean;
begin
  Result := not HitTest.HitAtMajorScale and inherited IsValidTime;
end;

procedure TcxTimeGridDragEventHelper.UpdateViewClonesTime;
var
  I: Integer;
  ADelta: TDateTime;                         
begin
  ADelta := Controller.StartDragHitTime - HitTest.Time;
  for I := 0 to Clones.Count - 1 do
    with Clones[I] do
      MoveTo(Source.Start - ADelta);
  CorrectAllDayEventProperty;
end;

{ TcxTimeGridEventSizing }

function TcxTimeGridEventSizing.IsValidTime: Boolean;
begin
  Result := not HitTest.HitAtMajorScale and inherited IsValidTime;
end;

procedure TcxTimeGridEventSizing.UpdateEventBounds;
var
  AllDayEvent: Boolean;
  ATime, ASaveTime: TDateTime;
begin
  ATime := HitTest.Time;
  if Controller.DragKind = edkResizeStart then
  begin
    ATime := Min(ATime, Event.Finish);
    AllDayEvent := (TimeOf(Event.Finish) = 0) and (TimeOf(ATime) = 0) and
      (Event.Duration >= 1);
    if AllDayEvent <> Event.AllDayEvent then
    begin
      if Event.AllDayEvent then
      begin
        ASaveTime := Event.Finish;
        Event.AllDayEvent := AllDayEvent;
        Event.Finish := ASaveTime;
      end
      else
        Event.AllDayEvent := True;
      CheckEventState(Event);
    end;
    Event.Start := ATime;
  end
  else
  begin
    ATime := Max(Event.Start, TimeBuilder.Inc(ATime));
    AllDayEvent := (TimeOf(Event.Start) = 0) and (TimeOf(ATime) = 0) and
      (Event.Duration >= 1);
    if AllDayEvent <> Event.AllDayEvent then
    begin
      if Event.AllDayEvent then
      begin
        ASaveTime := Event.Start;
        Event.AllDayEvent := AllDayEvent;
        Event.Start := ASaveTime;
      end
      else
        Event.AllDayEvent := True;
      CheckEventState(Event);
    end;
    Event.Finish := ATime;
  end;
  RefreshCurrentView;
end;

function TcxTimeGridEventSizing.GetHitTest: TcxSchedulerTimeGridViewHitTest;
begin
  Result := TcxSchedulerTimeGridViewHitTest(inherited HitTest);
end;

function TcxTimeGridEventSizing.GetTimeBuilder: TcxSchedulerTimeBuilder;
begin
  Result := TcxSchedulerTimeGridView(Scheduler.CurrentView).ViewInfo.TimeBuilder;
end;

{ TcxSchedulerTimeGridViewController }

constructor TcxSchedulerTimeGridViewController.Create(AOwner: TcxSchedulerSubControl);
begin
  inherited Create(AOwner);
  FTimer := TTimer.Create(nil);
  FTimer.Enabled := False;
end;

destructor TcxSchedulerTimeGridViewController.Destroy;
begin
  FTimer.Free;
  inherited Destroy;
end;

function TcxSchedulerTimeGridViewController.CreateDragEventHelper: TcxDragEventHelper;
begin
  Result := TcxTimeGridDragEventHelper.Create(Scheduler);
end;

function TcxSchedulerTimeGridViewController.CreateNavigation: TcxSchedulerViewNavigation;
begin
  Result := TcxSchedulerTimeGridViewNavigation.Create(View);
end;

function TcxSchedulerTimeGridViewController.CreateResizeEventHelper: TcxEventSizingHelper;
begin
  Result := TcxTimeGridEventSizing.Create(Scheduler);
end;

procedure TcxSchedulerTimeGridViewController.BeforeMouseDown(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FIsEditingBeforeMouseDown := IsEditing;
  inherited BeforeMouseDown(Button, Shift, X, Y);
end;

procedure TcxSchedulerTimeGridViewController.CancelScroll;
begin
  InitTimer(False, scEndScroll);
end;

procedure TcxSchedulerTimeGridViewController.CheckScrolling(const APos: TPoint);
var
  ACanScroll: Boolean;
  AScrollCode: TScrollCode;
  R: TRect;
begin
  R := ViewInfo.Bounds;
  Inc(R.Top, ViewInfo.FScalesHeight);
  Inc(R.Left, ViewInfo.FResourceHeaderWidth);
  FPos := APos;
  ACanScroll := cxRectPtIn(R, APos);
  AScrollCode := TScrollCode(Timer.Tag);
  if APos.X < (R.Left + cxScrollZoneSize) then
    AScrollCode := scLineUp
  else
    if APos.X >= (R.Right - cxScrollZoneSize) then
      AScrollCode := scLineDown
    else
      ACanScroll := False;
  if (ACanScroll <> Timer.Enabled) or (Integer(AScrollCode) <> Timer.Tag) then
    InitTimer(ACanScroll, AScrollCode);
end;

procedure TcxSchedulerTimeGridViewController.InitTimer(
  AllowStart: Boolean; AScrollCode: TScrollCode);
begin
  if AllowStart and FIsEditingBeforeMouseDown then
  begin
    FIsEditingBeforeMouseDown := False;
    AllowStart := False;
  end;
  if not AllowStart then
    Timer.OnTimer := nil
  else
    Timer.OnTimer := OnTimer;
  Timer.Enabled := AllowStart;
  Timer.Interval := cxScrollInterval;
  Timer.Tag := Integer(AScrollCode);
end;

procedure TcxSchedulerTimeGridViewController.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if CanProcessMouseMove and (Button = mbLeft) and not NavigationButtonClicked then
    CheckScrolling(cxPoint(X, Y))
end;

procedure TcxSchedulerTimeGridViewController.MouseMove(
  Shift: TShiftState; X, Y: Integer);
begin
  if (DragKind = edkNone) and HitTest.HitAtScale and HitTest.HitAtTime then
    HitTest.FResource := Scheduler.SelResource;
  inherited MouseMove(Shift, X, Y);
  if CanProcessMouseMove and (ssLeft in Shift) and not NavigationButtonClicked then
    CheckScrolling(cxPoint(X, Y))
end;

procedure TcxSchedulerTimeGridViewController.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TcxSchedulerTimeGridViewController.Scrolling(AScrollCode: TScrollCode; var AScrollPos: Integer);
begin
  View.Scroll(sbHorizontal, AScrollCode, AScrollPos);
end;

procedure TcxSchedulerTimeGridViewController.SyncEventSelection(
  AEvent: TcxSchedulerControlEvent);
var
  AStart, AFinish: TDateTime;
  AViewInfo: tcxSchedulerEventCellViewInfo;
  AResourceItem: TcxSchedulerStorageResourceItem;
begin
  AResourceItem := nil;
  if HitTest.HitAtResource then
    AResourceItem := HitTest.Resource;
  if HitTest.HitAtEvent and (HitTest.EventCell <> nil) and (HitTest.Event = AEvent) then
    AViewInfo := HitTest.EventCell
  else
    if not View.FindEventViewInfo(AEvent.Source, AEvent.Start, AEvent.GetResourceItem, AViewInfo) then
      AViewInfo := nil;
  if AViewInfo <> nil then
  begin
    AStart := AViewInfo.ContentStart;
    AFinish := AViewInfo.ContentFinish - View.GetTimeIncrement;
    if View.WorkDaysOnly then
      ViewInfo.TimeBuilder.CheckWorkDays(AFinish, False);
    if AResourceItem = nil then
      AResourceItem := AEvent.GetResourceItem;
    TcxSchedulerTimeGridViewNavigation(Navigation).ReplaceSelParams(
      AStart, AFinish, AResourceItem);
  end
  else
    inherited SyncEventSelection(AEvent);
end;

procedure TcxSchedulerTimeGridViewController.OnTimer(Sender: TObject);

  function GetShiftState: TShiftState;
  const
    Buttons: array[Boolean] of Integer = (VK_LBUTTON, VK_RBUTTON);
  begin
    Result := [];
    if GetAsyncKeyState(Buttons[GetSystemMetrics(SM_SWAPBUTTON) <> 0]) < 0 then
      Include(Result, ssLeft);
    if GetAsyncKeyState(VK_CONTROL) < 0 then
      Include(Result, ssCtrl);
  end;

var
  APos: Integer;
  AShift: TShiftState;
begin
  AShift := GetShiftState;
  if not (ssLeft in AShift) then
  begin
    CancelScroll;
    SetCaptureControl(nil);
  end
  else
  begin
    APos := View.FScrollPosition;
    Scrolling(TScrollCode(Timer.Tag), APos);
    MouseMove(AShift, FPos.X, FPos.Y);
    if (DragKind in [edkResizeStart, edkResizeEnd]) then
      CheckUpdateEventBounds;
  end;
end;

function TcxSchedulerTimeGridViewController.GetHitTest: TcxSchedulerTimeGridViewHitTest;
begin
  Result := TcxSchedulerTimeGridViewHitTest(inherited HitTest);
end;

function TcxSchedulerTimeGridViewController.GetView: TcxSchedulerTimeGridView;
begin
  Result := TcxSchedulerTimeGridView(inherited View);
end;

function TcxSchedulerTimeGridViewController.GetViewInfo: TcxSchedulerTimeGridViewViewInfo;
begin
  Result := View.ViewInfo;
end;

{ TcxSchedulerTimeGridViewNavigation }

procedure TcxSchedulerTimeGridViewNavigation.KeyDown(
  var AKey: Word; AShift: TShiftState);
var
  AFinish: TDateTime;
begin
  case AKey of
    VK_LEFT, VK_RIGHT:
      with TimeBuilder do
      begin
        AFinish := CalculateDateTime(FCurrentAnchor, Direction[AKey = VK_RIGHT]);
        if CheckTime and (((AFinish > SelAnchor) and  (RoundTime(TimeOf(AFinish)) = WorkFinish)) {or
          IsPeriodChanged(AFinish, FCurrentAnchor)}) then
          AFinish := CalculateDateTime(AFinish, Direction[AKey = VK_RIGHT]);
        TimeBuilder.CheckWorkDays(AFinish, AKey = VK_RIGHT);
        ViewInfo.MakeTimeVisible(AFinish);
        SetSelAnchor(AFinish, AShift, FCurrentResource);
      end;
    VK_HOME:
      SetSelAnchor(View.VisibleStart, AShift, FCurrentResource);
    VK_END:
      SetSelAnchor(View.VisibleFinish, AShift, FCurrentResource);
    VK_UP, VK_DOWN:
      if not (ssShift in AShift) and (GetNextResource(AKey = VK_DOWN) <> FCurrentResource) then
        SetSelAnchor(FCurrentAnchor, AShift, GetNextResource(AKey = VK_DOWN))
      else
        if ScrollResourcesEx(AKey = VK_DOWN, FCurrentResource) then
          ReplaceSelParams(FCurrentResource);
  end;
  View.CheckRefresh;
end;

procedure TcxSchedulerTimeGridViewNavigation.ValidateSelection(
  var ASelStart, ASelFinish: TDateTime;
  var AResource: TcxSchedulerStorageResourceItem);

begin
  inherited ValidateSelection(ASelStart, ASelFinish, AResource);
  if ASelStart = NullDate then
  begin
    ASelStart := View.VisibleStart;
    ASelFinish := ASelStart;
  end;
  TimeBuilder.ValidateTime(ASelStart, True, 0);
  TimeBuilder.ValidateTime(ASelFinish, True, 0);
  TimeBuilder.CheckWorkDays(ASelStart, True);
  TimeBuilder.CheckWorkDays(ASelFinish, True);
end;

function TcxSchedulerTimeGridViewNavigation.GetTimeBuilder: TcxSchedulerTimeBuilder;
begin
  Result := ViewInfo.TimeBuilder;
end;

function TcxSchedulerTimeGridViewNavigation.GetView: TcxSchedulerTimeGridView;
begin
  Result := TcxSchedulerTimeGridView(inherited View);
end;

function TcxSchedulerTimeGridViewNavigation.GetViewInfo: TcxSchedulerTimeGridViewViewInfo;
begin
  Result := View.ViewInfo;
end;

{ TcxSchedulerTimeGridViewStyles }

constructor TcxSchedulerTimeGridViewStyles.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FScheduler := TimeGrid.Scheduler;
  BitmapInViewParams := True;
end;

procedure TcxSchedulerTimeGridViewStyles.Assign(Source: TPersistent);
var
  I: Integer;
begin
  if Source is TcxSchedulerTimeGridViewStyles then
    for I := 0 to cxcsMaxTimeGridStyle do
      SetValue(I, TcxSchedulerTimeGridViewStyles(Source).GetValue(I));
  inherited Assign(Source);
end;

function TcxSchedulerTimeGridViewStyles.GetMajorScaleParams(
  const ADateTime: TDateTime): TcxViewParams;
var
  AStyle: TcxStyle; 
begin
  AStyle := nil;
  if Assigned(FOnGetMajorScaleParams) then
    FOnGetMajorScaleParams(TimeGrid, ADateTime, AStyle);
  GetViewParams(cxcsMajorScale, nil, AStyle, Result);
end;

function TcxSchedulerTimeGridViewStyles.GetMajorScaleUnitSeparatorParams: TcxViewParams;
begin
  GetViewParams(cxcsMajorScaleUnitSeparator, nil, nil, Result);
end;

function TcxSchedulerTimeGridViewStyles.GetMinorScaleParams(
  const ADateTime: TDateTime): TcxViewParams;
var
  AStyle: TcxStyle;
begin
  AStyle := nil;
  if Assigned(FOnGetMinorScaleParams) then
    FOnGetMinorScaleParams(TimeGrid, ADateTime, AStyle);
  GetViewParams(cxcsMinorScale, nil, AStyle, Result);
end;

function TcxSchedulerTimeGridViewStyles.GetSelectionBarParams(
  const ADateTime: TDateTime): TcxViewParams;
begin
  Result := GetSelectionBarParamsEx(ADateTime, IsTimeSelected(ADateTime));
end;

procedure TcxSchedulerTimeGridViewStyles.Changed(AIndex: Integer);
begin
  inherited Changed(AIndex);
  TimeGrid.ScaleChanged;
end;

procedure TcxSchedulerTimeGridViewStyles.GetDefaultViewParams(
  Index: Integer; AData: TObject; out AParams: TcxViewParams);
var
  APainter: TcxCustomLookAndFeelPainterClass;
begin
  AParams.Bitmap := nil;
  AParams.Font := Scheduler.Font;
  AParams.TextColor := clBlack;
  APainter := TimeGrid.LookAndFeelPainter;
  case Index of
    cxcsSelectionBar:
    begin
      if Boolean(AData) then
        AParams.Color := Scheduler.Styles.GetSelectionParams.Color
      else
        AParams.Color := APainter.DefaultTimeGridSelectionBarColor;
    end;
    cxcsMajorScaleUnitSeparator, cxcsMajorScale:
    begin
      AParams.Color := APainter.DefaultTimeGridMajorScaleColor;
      AParams.TextColor := APainter.DefaultTimeGridMajorScaleTextColor;
    end;
    cxcsMinorScale:
    begin
      AParams.Color := APainter.DefaultTimeGridMinorScaleColor;
      AParams.TextColor := APainter.DefaultTimeGridMinorScaleTextColor;
    end;
  end;
end;

function TcxSchedulerTimeGridViewStyles.GetSelectionBarParamsEx(
  const ADateTime: TDateTime; ASelected: Boolean): TcxViewParams;
var
  AStyle: TcxStyle;
begin
  AStyle := nil;
  if Assigned(FOnGetSelectionBarParams) then
    FOnGetSelectionBarParams(TimeGrid, ADateTime, AStyle);
  GetViewParams(cxcsSelectionBar, TObject(ASelected), AStyle, Result);
end;

function TcxSchedulerTimeGridViewStyles.IsTimeSelected(
  const ADateTime: TDateTime): Boolean;
begin
  with TimeGrid.ViewInfo do
    Result := IsTimeSelected(ADateTime, FSelResource);
end;

function TcxSchedulerTimeGridViewStyles.GetTimeGrid: TcxSchedulerTimeGridView;
begin
  Result := TcxSchedulerTimeGridView(inherited GetOwner);
end;

{ TcxSchedulerTimeGridViewScales }

constructor TcxSchedulerTimeGridViewScales.Create(
  AOwner: TcxSchedulerTimeGridView);
begin
  FOwner := AOwner;
  Major := True;
  MajorUnitSeparatorWidth := cxDefaultSplitterWidth;
  MajorUnit := suDay;
  Minor := True;
  MinorUnit := suHour;
  MinorUnitWidth := cxDefaultMinorUnitWidth;
  TimeStep := 30;
end;

procedure TcxSchedulerTimeGridViewScales.Assign(Source: TPersistent);
begin
  if Source is TcxSchedulerTimeGridViewScales then
    with TcxSchedulerTimeGridViewScales(Source) do
    begin
      Self.FMajor := FMajor;
      Self.FMajorUnitSeparatorWidth := FMajorUnitSeparatorWidth;
      Self.FMajorUnit := FMajorUnit;
      Self.FMinor := FMinor;
      Self.FMinorUnit := FMinorUnit;
      Self.FMinorUnitWidth := FMinorUnitWidth;
      Self.FTimeStep := FTimeStep;
    end
  else
    inherited Assign(Source);
end;

procedure TcxSchedulerTimeGridViewScales.Changed;
begin
  TimeGrid.ScaleChanged;
end;

function TcxSchedulerTimeGridViewScales.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TcxSchedulerTimeGridViewScales.GetScheduler: TcxCustomScheduler;
begin
  Result := FOwner.Scheduler;
end;

procedure TcxSchedulerTimeGridViewScales.SetMajor(AValue: Boolean);
begin
  if AValue <> FMajor then
  begin
    FMajor := AValue;
    Changed;
  end;
end;

procedure TcxSchedulerTimeGridViewScales.SetMajorUnitSeparatorWidth(AValue: Integer);
begin
  AValue := Max(0, AValue);
  if AValue <> FMajorUnitSeparatorWidth then
  begin
    FMajorUnitSeparatorWidth := AValue;
    Changed;
  end;
end;

procedure TcxSchedulerTimeGridViewScales.SetMajorUnit(AValue: TcxSchedulerTimeGridScaleUnit);
begin
  if AValue <> FMajorUnit then
  begin
    FMajorUnit := AValue;
    Changed;
  end;
end;

procedure TcxSchedulerTimeGridViewScales.SetMinor(AValue: Boolean);
begin
  if AValue <> FMinor then
  begin
    FMinor := AValue;
    Changed;
  end;
end;

procedure TcxSchedulerTimeGridViewScales.SetMinorUnit(AValue: TcxSchedulerTimeGridScaleUnit);
begin
  if AValue <> FMinorUnit then
  begin
    FMinorUnit := AValue;
    Changed;
  end;
end;

procedure TcxSchedulerTimeGridViewScales.SetMinorUnitWidth(AValue: Integer);
begin
  AValue := Max(cxMinColumnWidth, AValue); 
  if AValue <> FMinorUnitWidth then
  begin
    FMinorUnitWidth := AValue;
    Changed;
  end;
end;

procedure TcxSchedulerTimeGridViewScales.SetTimeStep(AValue: Integer);
begin
  if AValue <> FTimeStep then
  begin
    FTimeStep := Max(cxMinHourScale, Min(cxMaxHourScale, AValue));
    while cxMaxHourScale mod FTimeStep <> 0 do Inc(FTimeStep);
    Changed;
  end;
end;

{ TcxSchedulerTimeGridViewHitTest }

function TcxSchedulerTimeGridViewHitTest.HitAtScale: Boolean;
begin
  Result := HitAtMajorScale or HitAtSelectionBar or HitAtMinorScale;
end;

{ TcxSchedulerTimeGridView }

constructor TcxSchedulerTimeGridView.Create(AOwner: TcxCustomScheduler);
begin
  inherited Create(AOwner);
  FVisibleStart := NullDate;
  FScales := CreateScales;
  FStyles := CreateStyles;
  EventImagesLayout := eilAuto;
  FScrollPosition := (ScrollMaxPos - ScrollPage) div 2;
  FShowMoreEventsButton := True;
  FShowResourceScrollBar := True;
  FSnapEventsToTimeSlots := True;
end;

destructor TcxSchedulerTimeGridView.Destroy;
begin
  FScales.Free;
  FStyles.Free;
  inherited Destroy;
end;

procedure TcxSchedulerTimeGridView.Assign(Source: TPersistent);
begin
  if Source is TcxSchedulerTimeGridView then
    with TcxSchedulerTimeGridView(Source) do
    begin
      Self.FScales.Assign(FScales);
      Self.FStyles.Assign(FStyles);
      Self.FShowMoreEventsButton := FShowMoreEventsButton;
      Self.FShowResourceScrollBar := FShowResourceScrollBar;
      Self.FWorkDaysOnly := FWorkDaysOnly;
      Self.FWorkTimeOnly := FWorkTimeOnly;
    end;
  inherited Assign(Source);
end;

function TcxSchedulerTimeGridView.GetMajorUnitDisplayText(
  const AStart, AFinish: TDateTime; ATextType: TcxSchedulerTimeGridScaleTextType): string;
begin
  Result := GetMajorCellDisplayText(ATextType, Scales.MajorUnit, AStart, AFinish);
  DoGetMajorUnitDisplayText(AStart, AFinish, ATextType, Result);
end;

function TcxSchedulerTimeGridView.GetMinorUnitDisplayText(
  const AStart, AFinish: TDateTime; ATextType: TcxSchedulerTimeGridScaleTextType): string;
begin
  Result := GetMinorCellDisplayText(ATextType, Scales.MinorUnit,
    Scales.MajorUnit, AStart, AFinish);
  DoGetMinorUnitDisplayText(AStart, AFinish, ATextType, Result);
end;

function TcxSchedulerTimeGridView.CanDeactivateOnDateNavigatorSelectionChange: Boolean;
begin
  Result := False;
end;

function TcxSchedulerTimeGridView.CanSelectPeriod: Boolean;
begin
  Result := False;
end;

procedure TcxSchedulerTimeGridView.Changed;
begin
  inherited Changed;
end;

procedure TcxSchedulerTimeGridView.CheckRefresh;
begin
  if (FirstVisibleDate < EventList.SelStart) or (LastVisibleDate >= EventList.SelFinish) then
    Scheduler.FullRefresh;
end;

function TcxSchedulerTimeGridView.CreateController: TcxSchedulerSubControlController;
begin
  Result := TcxSchedulerTimeGridViewController.Create(Self);
end;

function TcxSchedulerTimeGridView.CreateHitTest: TcxSchedulerSubControlHitTest;
begin
  Result := TcxSchedulerTimeGridViewHitTest.Create(Self);
end;

function TcxSchedulerTimeGridView.CreatePainter: TcxSchedulerSubControlPainter;
begin
  Result := TcxSchedulerTimeGridViewPainter.Create(Self);
end;

function TcxSchedulerTimeGridView.CreateScales: TcxSchedulerTimeGridViewScales;
begin
  Result := TcxSchedulerTimeGridViewScales.Create(Self);
end;

function TcxSchedulerTimeGridView.CreateStyles: TcxSchedulerTimeGridViewStyles;
begin
  Result := TcxSchedulerTimeGridViewStyles.Create(Self);
end;

function TcxSchedulerTimeGridView.CreateViewAdapter: TcxCustomResourceViewAdapter;
begin
  Result := TcxSchedulerTimeGridViewAdapter.Create(Self);
end;

function TcxSchedulerTimeGridView.CreateViewInfo: TcxSchedulerSubControlViewInfo;
begin
  Result := TcxSchedulerTimeGridViewViewInfo.Create(Self);
end;

procedure TcxSchedulerTimeGridView.DeactivateView;
begin
  inherited DeactivateView;
  ViewInfo.ResourceViewShiftList.Clear;
end;

procedure TcxSchedulerTimeGridView.DoDrawSelectionBarCell(
  AItem: TcxSchedulerTimeGridSelectionBarCell; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawSelectionBar) then
    OnCustomDrawSelectionBar(Self, Canvas, AItem, ADone);
end;

procedure TcxSchedulerTimeGridView.DoDrawTimeLineCell(
  AItem: TcxSchedulerTimeGridMinorScaleCell; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawMinorUnit) then
    FOnCustomDrawMinorUnit(Self, Canvas, AItem, ADone);
end;

procedure TcxSchedulerTimeGridView.DoDrawTimeLineHeaderCell(
  AItem: TcxSchedulerTimeGridMajorScaleCell; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawMajorUnit) then
    FOnCustomDrawMajorUnit(Self, Canvas, AItem, ADone);
end;

procedure TcxSchedulerTimeGridView.DoGetMajorUnitDisplayText(
  const AStart, AFinish: TDateTime;
  ATextType: TcxSchedulerTimeGridScaleTextType; var AText: string);
begin
  if Assigned(FOnGetMajorUnitDisplayText) then
    FOnGetMajorUnitDisplayText(Self, AStart, AFinish, ATextType, AText);
end;

procedure TcxSchedulerTimeGridView.DoGetMinorUnitDisplayText(
  const AStart, AFinish: TDateTime;
  ATextType: TcxSchedulerTimeGridScaleTextType; var AText: string);
begin
  if Assigned(FOnGetMinorUnitDisplayText) then
    FOnGetMinorUnitDisplayText(Self, AStart, AFinish, ATextType, AText);
end;

function TcxSchedulerTimeGridView.GetCompressWeekEnd: Boolean;
begin
  Result := False;
end;

function TcxSchedulerTimeGridView.GetControlEventLineStart(
  AEvent: TcxSchedulerControlEvent): Integer;
var
  I: Integer;
begin
  Result := TcxSchedulerControlEventAccess(AEvent).LineStart;
  if Result = 0 then
  begin
    for I := 0 to EventList.Count - 1 do
      if cxCompareSchedulerControlEvents(AEvent, EventList.Items[I]) = 0 then
      begin
        Result := TcxSchedulerControlEventAccess(EventList.Items[I]).LineStart;
        Break;
      end;
  end;
end;

function TcxSchedulerTimeGridView.GetEditWithSingleLineEditor(
  AEvent: TcxSchedulerControlEvent): Boolean;
begin
  Result := not EventDetailInfo;
end;

function TcxSchedulerTimeGridView.GetFirstVisibleDate: TDateTime;
begin
  Result := DateOf(VisibleStart);
  if (VisibleStart = NullDate) and (SelectedDays.Count > 0) then
    Result := SelectedDays[0] - 7;
end;

function TcxSchedulerTimeGridView.GetFirstVisibleTime: TDateTime;
begin
  Result := TimeOf(VisibleStart);
end;

function TcxSchedulerTimeGridView.GetLastVisibleDate: TDateTime;
begin
  if (FVisibleFinish = 0) and (VisibleStart > 0) then
    Result := VisibleStart + GetTimeIncrement
  else
    Result := DateOf(VisibleFinish);
  if (VisibleStart = NullDate) and (SelectedDays.Count > 0) then
    Result := SelectedDays[0] + 7;
end;

function TcxSchedulerTimeGridView.GetLastVisibleTime: TDateTime;
begin
  Result := TimeOf(VisibleFinish);
end;

function TcxSchedulerTimeGridView.GetScrollTimeHint: string;
begin
  Result := DateTimeToStr(FirstVisibleDate) +
    ' ' + cxTimeToStr(FirstVisibleTime, dxFormatSettings.ShortTimeFormat);
  Result := Result + ' - ';
  if LastVisibleDate <> FirstVisibleDate then
    Result := Result + #13#10 + DateTimeToStr(LastVisibleDate) + ' ';
  Result := Result + cxTimeToStr(LastVisibleTime, dxFormatSettings.ShortTimeFormat);
end;

function TcxSchedulerTimeGridView.GetTimeIncrement: TDateTime;
begin
  Result := inherited GetTimeIncrement;
  if Scales.MinorUnit = suHour then
    Result := Scales.TimeStep * MinuteToTime
  else
    if Scales.MinorUnit = suMonth then
      Result := 31; 
end;

function TcxSchedulerTimeGridView.GetViewContentRect: TRect;
begin
   Result := inherited GetViewContentRect;
end;

procedure TcxSchedulerTimeGridView.InitScrollBarsParameters;
var
  Position: Integer;
begin
  inherited InitScrollBarsParameters;
  Position := Min(Max(FScrollPosition, 0), ScrollMaxPos - 1);
  SetScrollBarInfo(sbHorizontal, 0, ScrollMaxPos, 1, ScrollPage, Position, True, True);
end;

function TcxSchedulerTimeGridView.IsSnapEventsToTimeSlots: Boolean;
begin
  Result := SnapEventsToTimeSlots;
end;

procedure TcxSchedulerTimeGridView.MakeEventVisible(
  AEvent: TcxSchedulerControlEvent; const ADate: TDateTime;
  AResource: TcxSchedulerStorageResourceItem);
begin
  ViewInfo.MakeTimeVisible(AEvent.Start);
  LayoutChanged;
  if AResource = nil then
    AResource := Scheduler.SelResource;
  MakeLineVisible(AResource, AEvent);
end;

procedure TcxSchedulerTimeGridView.MakeLineVisible(
  AResource: TcxSchedulerStorageResourceItem; AEvent: TcxSchedulerControlEvent);
var
  AnEventLineIndex, ADelta, AResourceIndex: Integer;
begin
  if Resources.Count > 0 then
    ViewInfo.GetResourceViewInfoByItem(AResource, AResourceIndex)
  else
    AResourceIndex := 0;
  AnEventLineIndex := GetControlEventLineStart(AEvent) +
    ViewInfo.GetResourceViewShift(AResourceIndex).FShift - ViewInfo.FLineOffset;
  ADelta := 0;
  if AnEventLineIndex < 0 then
    ADelta := -AnEventLineIndex
  else
    if AnEventLineIndex >= ViewInfo.GetVisibleLineCount(AResourceIndex) - 1 then
      ADelta := -(AnEventLineIndex - ViewInfo.GetVisibleLineCount(AResourceIndex) + 1);
  if ADelta <> 0 then
    ViewInfo.ChangeResourceShift(AResourceIndex, ADelta);
end;

procedure TcxSchedulerTimeGridView.ScaleChanged;
var
  AStart: TDateTime;
begin
  if (Scales = nil) or (ViewInfo = nil) then Exit;
  ScaleTextType := sttUnknown;
  if VisibleStart <> NullDate then
  begin
    AStart := Scheduler.SelStart;
    ViewInfo.TimeBuilder.Initialize(Self, WorkTimeOnly, WorkDaysOnly);
    ViewInfo.TimeBuilder.ValidateVisibleStart(AStart);
    ViewInfo.TimeBuilder.ValidateTime(AStart, False);
    Controller.Navigation.ReplaceSelParams(AStart, AStart, Scheduler.SelResource);
  end;
  Changed;
  Scheduler.FullRefresh;
end;

procedure TcxSchedulerTimeGridView.Scroll(AScrollBarKind: TScrollBarKind;
  AScrollCode: TScrollCode; var AScrollPos: Integer);
var
  AStartTime: TDateTime;
begin
  if FVisibleStart = NullDate then
    FVisibleStart := SelectedDays[0];
  AStartTime := VisibleStart;
  FScrollUpdateLocked := AScrollCode <> scEndScroll;
  case AScrollCode of
    scLineDown, scLineUp:
      with ViewInfo.TimeBuilder do
      begin
        System.Inc(FScrollPosition, Direction[AScrollCode = scLineDown]);
        AStartTime := CalculateDateTime(AStartTime, Direction[AScrollCode = scLineDown]);
        if CheckTime and (RoundTime(TimeOf(AStartTime)) = WorkFinish) then
          AStartTime := CalculateDateTime(AStartTime, Direction[AScrollCode = scLineDown]);
      end;
    scPageUp, scPageDown:
      begin
        AStartTime := ViewInfo.TimeBuilder.CalculateDateTime(AStartTime,
          Direction[AScrollCode = scPageDown] * ViewInfo.VisibleColumnCount);
        System.Inc(FScrollPosition, Direction[AScrollCode = scLineDown] * ViewInfo.VisibleColumnCount);
      end;
    scBottom, scTop, scPosition, scTrack:
      if AScrollPos <> FScrollPosition then
      begin
        AStartTime := ViewInfo.TimeBuilder.CalculateDateTime(AStartTime,
          AScrollPos - FScrollPosition);
        with ViewInfo.TimeBuilder do
        begin
          if CheckTime and (RoundTime(TimeOf(AStartTime)) = WorkFinish) then
            AStartTime := CalculateDateTime(AStartTime, Direction[AScrollPos - FScrollPosition > 0]);
        end;
        FScrollPosition := AScrollPos;
      end;
  end;
  VisibleStart := DateTimeHelper.RoundTime(AStartTime);
  if IsScrollingContent or (AScrollCode = scEndScroll) then
    AScrollPos := Max(Min(FScrollPosition, ScrollMaxPos - (ScrollPage * 2 - 1)), ScrollPage);
  if IsScrollingContent then
    GetScrollBar(sbHorizontal).Position := AScrollPos;
  FScrollPosition := AScrollPos;
  CheckRefresh;
  HideHintOnScroll(AScrollCode);
  if AScrollCode = scTrack then
    ShowHintOnScroll(GetScrollTimeHint, AScrollBarKind);
end;

procedure TcxSchedulerTimeGridView.SelectedDaysChanged;
var
  ADate: TDateTime;
begin
  if SelectedDays.Count > 0 then
  begin
    ADate := SelectedDays[0];
    ViewInfo.TimeBuilder.ValidateTime(ADate, True, 0);
    ViewInfo.TimeBuilder.CheckWorkDays(ADate, True);
    VisibleStart := ADate;
    if FLockSelectionCounter = 0 then
      Controller.Navigation.ReplaceSelParams(
        NullDate, NullDate, Scheduler.SelResource);
    Changed;
  end;
end;

procedure TcxSchedulerTimeGridView.UpdateDateNavigatorSelection;
var
  AStart: TDateTime;
begin
  AStart := FVisibleStart;
  inherited UpdateDateNavigatorSelection;
  VisibleStart := AStart;
end;

procedure TcxSchedulerTimeGridView.ValidateSelectionFinishTime(
  var ADateTime: TDateTime);
var
  Y, M, D: Word;
begin
  if Scales.MinorUnit < suDay then Exit;
  if Scales.MinorUnit > suDay then
    ADateTime := ADateTime - GetTimeIncrement; 
  DecodeDate(ADateTime, Y, M, D);
  case Scales.MinorUnit of
    suDay:
      ADateTime := EncodeDate(Y, M, D);
    suWeek:
      ADateTime := Trunc(ADateTime) - (DayOfTheWeek(ADateTime) - 1) + 6;
    suMonth:
      ADateTime := EncodeDate(Y, M, DaysPerMonth(Y, M));
    suQuarter:
    begin
      M := ((M - 1) div 3 + 1) * 3;
      ADateTime := EncodeDate(Y, M, DaysPerMonth(Y, M));
    end;
    suYear:
      ADateTime := EncodeDate(Y, 12, 31);
  end;
  if Scales.MinorUnit > suDay then
    ADateTime := ADateTime + 1;
end;

procedure TcxSchedulerTimeGridView.VisibleChanged;
begin
  inherited; 
  if not Visible then
    FVisibleStart := NullDate;
  Scheduler.FullRefresh;
end;

function TcxSchedulerTimeGridView.GetHitTest: TcxSchedulerTimeGridViewHitTest;
begin
  Result := TcxSchedulerTimeGridViewHitTest(inherited HitTest);
end; 

function TcxSchedulerTimeGridView.GetViewInfo: TcxSchedulerTimeGridViewViewInfo;
begin
  Result := TcxSchedulerTimeGridViewViewInfo(inherited ViewInfo);
end;

procedure TcxSchedulerTimeGridView.SetSnapEventsToTimeSlots(AValue: Boolean);
begin
  if FSnapEventsToTimeSlots <> AValue then
  begin
    FSnapEventsToTimeSlots := AValue;
    Changed;
  end;
end;

procedure TcxSchedulerTimeGridView.SetEventMaxLineCount(AValue: Integer);
begin
  AValue := Max(0, AValue);
  if AValue <> FEventMaxLineCount then
  begin
    FEventMaxLineCount := AValue;
    Changed;
  end;
end;

procedure TcxSchedulerTimeGridView.SetScales(
  AValue: TcxSchedulerTimeGridViewScales);
begin
  FScales.Assign(AValue);
  Changed;
end;

procedure TcxSchedulerTimeGridView.SetShowMoreEventsButton(AValue: Boolean);
begin
  if FShowMoreEventsButton <> AValue then
  begin
    FShowMoreEventsButton := AValue;
    Changed;
  end;
end;

procedure TcxSchedulerTimeGridView.SetShowResourceScrollBar(AValue: Boolean);
begin
  if FShowResourceScrollBar <> AValue then
  begin
    FShowResourceScrollBar := AValue;
    Changed;
  end;
end;

procedure TcxSchedulerTimeGridView.SetEventDetailInfo(AValue: Boolean);
begin
  if AValue <> FEventDetailInfo then
  begin
    FEventDetailInfo := AValue;
    Changed; 
  end;
end;

procedure TcxSchedulerTimeGridView.SetStyles(
  AValue: TcxSchedulerTimeGridViewStyles);
begin
  FStyles.Assign(AValue);
  Changed;
end;

procedure TcxSchedulerTimeGridView.SetVisibleStart(AValue: TDateTime);
begin
  if AValue <> FVisibleStart then
  begin
    Scheduler.DateNavigator.BeginUpdate;
    try
      FVisibleStart := AValue;
      if Controller.Navigation.SelStart = 0 then
        Controller.Navigation.ReplaceSelParams(NullDate, NullDate, Scheduler.SelResource);
      UpdateDateNavigatorSelection;
      Changed;
    finally
      Scheduler.DateNavigator.EndUpdate;
      if (FirstVisibleDate < EventList.SelStart) or (LastVisibleDate >= EventList.SelFinish) then
        Scheduler.FullRefresh;
    end;
  end;
end;

procedure TcxSchedulerTimeGridView.SetWorkDaysOnly(AValue: Boolean);
begin
  if AValue <> FWorkDaysOnly then
  begin
    FWorkDaysOnly := AValue;
    Changed;
  end;
end;

procedure TcxSchedulerTimeGridView.SetWorkTimeOnly(AValue: Boolean);
begin
  if AValue <> FWorkTimeOnly then
  begin
    FWorkTimeOnly := AValue;
    Changed;
  end;
end;

{ TcxSchedulerTimeGridViewEventCellViewInfo }

procedure TcxSchedulerTimeGridViewEventCellViewInfo.CalculateCaptions;
begin
  if (ShowFinishTime or ShowStartTime) and ViewData.AutoHeight then
  begin
    inherited CalculateCaptions;
    if EventStart <> EventFinish then
      ViewData.Caption := StartText + '-' + FinishText + ' ' + ViewData.Caption
    else
      ViewData.Caption := StartText + ' ' + ViewData.Caption;
  end
  else
    if not ShowTimeAsClock then
      inherited CalculateCaptions;
end;

procedure TcxSchedulerTimeGridViewEventCellViewInfo.CalculateDetailInfo;
begin
  FIsDetailInfo := ViewData.AutoHeight;
  FIsDetailCaption := FIsDetailInfo;
  FShowMessage := IsDetailInfo and (Length(Message) > 0);
end;

procedure TcxSchedulerTimeGridViewEventCellViewInfo.CalculateEventTimeAsClockLayout(
  const ABounds: TRect; const ACaptionWidth, AImagesWidth: Integer; var ALeft: Integer);
var
  ASpaceWidth, AIconsWidth, AVertOffset: Integer;
  R: TRect;
begin
  AIconsWidth := TcxSchedulerPainterHelper.IconsWidth;
  R := cxRectBounds(0, 0, AIconsWidth, TcxSchedulerPainterHelper.IconsHeight);
  AVertOffset := GetImagesVerticalOffset(R.Bottom, True);
  ASpaceWidth := cxRectWidth(CaptionRect) - (ACaptionWidth + AImagesWidth + cxEventImagesOffset);
  if ASpaceWidth > AIconsWidth then
  begin
    FStartRect := SetItemRect(ShowStartTime, R, AVertOffset, ALeft);
    Dec(ASpaceWidth, AIconsWidth + cxEventImagesGap);
    if ASpaceWidth > AIconsWidth then
      FFinishRect := SetItemRect(ShowFinishTime, R, AVertOffset, ALeft);
    Inc(ALeft);
  end;
end;

procedure TcxSchedulerTimeGridViewEventCellViewInfo.CalculateEventTimeVisibility;
begin
  if Event.AllDayEvent then
  begin
    ViewData.ShowFinishTime := False;
    ViewData.ShowStartTime := False;
  end
  else
    if IsHeaderEvent then
    begin
      ViewData.ShowFinishTime := (TimeOf(EventFinish) <> 0) and (ContentFinish <> EventFinish);
      ViewData.ShowStartTime := (TimeOf(EventStart) <> 0) and (ContentStart <> EventStart);
    end
    else
    begin
      ViewData.ShowFinishTime := (ContentFinish <> EventFinish) or (ContentStart <> EventStart);
      ViewData.ShowStartTime := ViewData.ShowFinishTime;
    end;
end;

function TcxSchedulerTimeGridViewEventCellViewInfo.CalculateNonDetailEventImages(
  const ACaptionWidth: Integer; out AImagesWidth: Integer): TRect;
begin
  Result := cxRectInflate(Bounds, -cxEventBorderWidth, 0);
  Inc(Result.Left, cxEventImagesOffset);
  Inc(Result.Top, cxEventImagesOffset);
  Result.Right := Result.Right - ACaptionWidth;
  AImagesWidth := CalculateSingleLineImages(Result, CaptionRect.Right);
end;

procedure TcxSchedulerTimeGridViewEventCellViewInfo.CalculateItemsLayout;
begin
  if not ViewData.AutoHeight then
  begin
    if Event.AllDayEvent then
      CalculateHeaderEventLayout
    else
      CalculateNonDetailEventLayout;
  end;    
end;

procedure TcxSchedulerTimeGridViewEventCellViewInfo.CalculateShowTimeAsClock;
begin
  ViewData.ShowTimeAsClock := ViewData.ShowTimeAsClock and not ViewData.AutoHeight;
end;

function TcxSchedulerTimeGridViewEventCellViewInfo.GetEditingRect: TRect;
begin
  Result := inherited GetEditingRect;
  Inc(Result.Top, Byte(ViewData.AutoHeight));
end;

procedure TcxSchedulerTimeGridViewEventCellViewInfo.InitHitTest(
  AHitTest: TcxSchedulerCustomResourceViewHitTest);
begin
  inherited InitHitTest(AHitTest);
  InitHitTestForHorzEvent(AHitTest);
end;

{ TcxSchedulerTimeGridViewAdapter }

function TcxSchedulerTimeGridViewAdapter.GetLineOffset: Integer;
begin
  Result := 0;
end;

function TcxSchedulerTimeGridViewAdapter.GetPrintRange(Index: Integer): TDateTime;
begin
  Result := TcxSchedulerTimeGridView(View).FVisibleStart;
  if Index <> 0 then
    Result := TcxSchedulerTimeGridView(View).FVisibleFinish;
end;

function TcxSchedulerTimeGridViewAdapter.GetShowLinks: Boolean;
begin
  Result := True; 
end;

function TcxSchedulerTimeGridViewAdapter.GetShowResourceHeaders: Boolean;
begin
  Result := True;
end;

function TcxSchedulerTimeGridViewAdapter.GetShowScales: Boolean;
begin
  Result := True;
end;

function TcxSchedulerTimeGridViewAdapter.GetWorkDaysOnly: Boolean;
begin
  Result := TcxSchedulerTimeGridView(View).WorkDaysOnly;
end;

function TcxSchedulerTimeGridViewAdapter.GetWorkTimeOnly: Boolean;
begin
  Result := TcxSchedulerTimeGridView(View).WorkTimeOnly;
end;

procedure TcxSchedulerTimeGridViewAdapter.Store;
begin
  FVisibleStart := TcxSchedulerTimeGridView(View).FVisibleStart;
  TcxSchedulerTimeGridView(View).ViewInfo.StoreScrollInfo; 
end;

procedure TcxSchedulerTimeGridViewAdapter.Restore;
begin
  TcxSchedulerTimeGridView(View).FVisibleStart := FVisibleStart;
  TcxSchedulerTimeGridView(View).ViewInfo.RestoreScrollInfo;
end;

{ TcxSchedulerTimeGridViewViewInfo }

constructor TcxSchedulerTimeGridViewViewInfo.Create(AOwner: TcxSchedulerSubControl);
begin
  inherited Create(AOwner);
  FTimeLineCells := TcxSchedulerViewInfoCellList.Create();
  FCells.Add(FTimeLineCells);
  FTimeBuilder := TcxSchedulerTimeBuilder.Create();
  FResourceViewShift := TcxObjectList.Create;
end;

destructor TcxSchedulerTimeGridViewViewInfo.Destroy;
begin
  FreeAndNil(FTimeBuilder);
  FreeAndNil(FResourceViewShift);
  inherited Destroy;
end;

procedure TcxSchedulerTimeGridViewViewInfo.CalculateHitTest(
  AHitTest: TcxSchedulerCustomResourceViewHitTest);
begin
  if not NavigationButtons.CalculateHitTest(AHitTest) then
    if not FTimeLineCells.CalculateHitTest(AHitTest) then
      inherited CalculateHitTest(AHitTest);
  HotTrackNavigationButtons(AHitTest);    
end;

procedure TcxSchedulerTimeGridViewViewInfo.AddEventForCalculation(
  ABuilder: TcxSchedulerEventLayoutBuilder; AEvent: TcxSchedulerControlEvent;
  AResourceIndex: Integer);

  procedure AddEventPlace(const AStartCol, AFinishCol: Integer;
    const AStart, AFinish: TDateTime);
  var
    APlace: TcxSchedulerEventPlace;
  begin
    APlace := ABuilder.AddEventPlace(AEvent,
      AStartCol, AFinishCol, 1, TObject(AResourceIndex));
    APlace.Data := AddEventViewInfo(APlace, AResourceIndex, AStart, AFinish);
  end;

var
  I: Integer;
  AItem: TcxSchedulerStorageResourceItem;
  AStart, AFinish: TDateTime;
  AStartCol, AFinishCol: Integer;
const
  Delta = 100;
begin
  AItem := nil;
  if AResourceIndex < ResourceCount then
    AItem := GetResourceItemByIndex(AResourceIndex);
  if not AEvent.IsResourceEvent(AItem, ShowEventsWithoutResource) or not IsEventVisible(AEvent) then Exit;
  if not Adapter.IsPrinting and ((AEvent.Finish <= View.VisibleStart) and not IsColumnEvent(AEvent,
    FirstVisibleIndex)) or (AEvent.Start >= FLastVisibleTime) then
  begin
    if not View.CheckEventsVisibility then
      if AEvent.Start >= FLastVisibleTime then
        AddEventPlace(Bounds.Right + Delta, Bounds.Right + Delta + 1, AEvent.Start, AEvent.Finish)
      else
        AddEventPlace(-Delta - 1, -Delta, AEvent.Start, AEvent.Finish);
    Exit;
  end;
  if Adapter.IsPrinting then
    I := 0
  else
    I := FirstVisibleIndex;
  while I < FColumnCount do
  begin
    if IsColumnEvent(AEvent, I) then
    begin
      CalculateEventPosition(AEvent, I, AStartCol, AFinishCol, AStart, AFinish);
      AddEventPlace(AStartCol, AFinishCol, AStart, AFinish);
      Break;
    end;
    Inc(I);
  end;
end;

function TcxSchedulerTimeGridViewViewInfo.AddEventViewInfo(
  APlace: TcxSchedulerEventPlace; AResourceIndex: Integer;
  const AStart, AFinish: TDateTime): TcxSchedulerEventCellViewInfo;
var
  I: Integer;
  ABounds, AVisibleBounds: TRect;
  AResource: TcxSchedulerResourceViewInfo;
  AViewData: TcxSchedulerEventViewData;
begin
  AVisibleBounds := Rect(ResourceHeaderWidth, ScalesHeight,
    Bounds.Right, Bounds.Bottom);
  if Integer(APlace.Resource) < ResourceCount then
  begin
    AResource := Resources[Integer(APlace.Resource)];
    with ResourceHeaderCells[1 + Integer(APlace.Resource)] do
    begin
      AVisibleBounds.Top := Bounds.Top;
      AVisibleBounds.Bottom := Bounds.Bottom;
    end;
  end
  else
    AResource := nil;
  ABounds := cxRect(APlace.ColStart, AVisibleBounds.Top + IndentBetweenLines,
    APlace.ColFinish, AVisibleBounds.Top + IndentBetweenLines + FContentLineHeight);
  if Adapter.IsPrinting then
    Inc(ABounds.Left);
  AViewData := CreateEventViewData(TcxSchedulerControlEvent(APlace.Event),
    ABounds, AStart, AFinish, AResource);
  AViewData.VisibleRect := AVisibleBounds;
  AViewData.AutoHeight := View.EventDetailInfo;
  AViewData.ShowTimeAsClock := AViewData.ShowTimeAsClock and not Adapter.IsPrinting; 
  Result := AddEventCell(AViewData, not AViewData.AutoHeight);
  if View.EventDetailInfo then
  begin
    I := Result.MeasureHeight(View.Canvas);
    APlace.LineFinish := (I div ContentLineHeight) - 1;
    if (I mod ContentLineHeight > 0) then Inc(APlace.LineFinish);
    if View.EventMaxLineCount > 0 then
      APlace.LineFinish := Min(View.EventMaxLineCount, APlace.LineFinish + 1) - 1;
  end;
end;

procedure TcxSchedulerTimeGridViewViewInfo.AddMajorScaleCell(
  ABounds: TRect; const AStart, AFinish: TDateTime);
var
  AItem: TcxSchedulerTimeGridMajorScaleCell;
begin
  if ABounds.Left > ResourceHeaderWidth then
    Dec(ABounds.Left);
  Inc(ABounds.Right, FSeparatorWidth);
  AddTimeLineItem(TcxSchedulerTimeGridMajorScaleCell, ABounds, 0,
    AStart, AFinish, View.Styles.GetMajorScaleParams(AStart), AItem);
  AItem.FDisplayText := View.GetMajorUnitDisplayText(AStart,
    CheckFinishTime(AFinish, Scales.MajorUnit), FMajorTextType);
  AItem.FBorders := [bBottom];
  AItem.FRightIndent := FSeparatorWidth;
end;

procedure TcxSchedulerTimeGridViewViewInfo.AddMajorSeparator(
  var ALeft: Integer);              
var
  ARect: TRect;
  ACell: TcxSchedulerMajorSeparatorCellViewInfo;
begin
  Dec(ALeft);
  ARect := Rect(ALeft, Bounds.Top,
    ALeft + FSeparatorWidth, Bounds.Bottom);
  CreateCellInstance(TcxSchedulerMajorSeparatorCellViewInfo,
    cxRectInflate(ARect, -1, 0), Bounds, View.Styles.GetMajorScaleUnitSeparatorParams, ACell);
  Inc(ARect.Top, FMajorScaleHeight);
  ACell.FContentBounds := ARect;
  Inc(ALeft, FSeparatorWidth);
  FGroupSeparatorCells.Insert(0, ACell);
end;

procedure TcxSchedulerTimeGridViewViewInfo.AddMinorScaleCell(const ABounds: TRect;
  const AStart, AFinish: TDateTime);
var
  AItem: TcxSchedulerTimeGridMinorScaleCell;
begin
  AddTimeLineItem(TcxSchedulerTimeGridMinorScaleCell, ABounds, 1, AStart, AFinish,
    View.Styles.GetMinorScaleParams(AStart), AItem);
  AItem.Borders := [bBottom];
  if Adapter.IsPrinting or (Scales.MajorUnitSeparatorWidth = 0) and (Scales.MajorUnit = suDay) then
  begin
    if TimeBuilder.IsPeriodChanged(AFinish, TimeBuilder.CalculateDateTime(AFinish, 2)) then
      AItem.Borders := [bBottom, bRight];
  end;
  AItem.FDisplayText := View.GetMinorUnitDisplayText(AStart,
    CheckFinishTime(AFinish, Scales.MinorUnit), FMajorTextType);
end;

function TcxSchedulerTimeGridViewViewInfo.AddSelectionBarCell(const ABounds: TRect;
  const AStart, AFinish: TDateTime): TcxSchedulerTimeGridSelectionBarCell;
begin
  AddTimeLineItem(TcxSchedulerTimeGridSelectionBarCell, ABounds, 2, AStart, AFinish,
    View.Styles.GetSelectionBarParams(AStart), Result);
  Result.FSelected := View.Styles.IsTimeSelected(AStart);
  Result.Borders := DefaultBorders;
  Result.FViewHeight := View.Height;
  Result.CalculateTimeLineParams(GetNeedShowCurrentTime);
end;

procedure TcxSchedulerTimeGridViewViewInfo.AddTimeLineItem(
  AClass: TcxSchedulerCustomViewInfoItemClass; const ABounds: TRect; AType: Byte;
  const AStart, AFinish: TDateTime; const AViewParams: TcxViewParams; var Instance);
var
  ACell: TcxSchedulerTimeGridMinorScaleCell;
begin
  CreateCellInstance(AClass, ABounds, FScalesBounds, AViewParams, Instance);
  ACell := TcxSchedulerTimeGridMinorScaleCell(Instance);
  ACell.ItemType := AType;
  ACell.FTimeFinish := AFinish;
  if AStart = AFinish then
    ACell.FTimeFinish := TimeBuilder.Inc(AStart);
  ACell.FDateTime := AStart;
  ACell.FVisible := ACell.FVisible and (ABounds.Bottom > ABounds.Top);
  FTimeLineCells.Add(TcxSchedulerTimeGridMinorScaleCell(Instance));
  if not ACell.Visible and Adapter.IsPrinting and (AClass = TcxSchedulerTimeGridSelectionBarCell) then
  begin
    if cxRectIntersect(cxRectInflate(ABounds, 0, 1), cxRectInflate(FScalesBounds, 0, 1)) then
      ACell.FVisible := True;
  end;
end;

procedure TcxSchedulerTimeGridViewViewInfo.AdjustTextType;
var
  I: Integer;
  ATextAdjusted: Boolean;
  ACell: TcxSchedulerTimeGridMinorScaleCell;

  procedure CheckScale(var ATextType: TcxSchedulerTimeGridScaleTextType);
  const
    RevertTypes: array[TcxSchedulerTimeGridScaleTextType] of TcxSchedulerTimeGridScaleTextType =
      (sttLong, sttUnknown, sttShort, sttMiddle);
  var
    S: string; 
  begin
    if ACell.ItemType = 0 then
      S := View.GetMajorUnitDisplayText(ACell.TimeStart,
        CheckFinishTime(ACell.TimeFinish, Scales.MajorUnit), ATextType)
    else
      S := View.GetMinorUnitDisplayText(ACell.TimeStart,
        CheckFinishTime(ACell.TimeFinish, Scales.MinorUnit), ATextType);
    ACell.DisplayText := S;
    if (ATextType <> sttShort) and
      (cxTextWidth(ACell.Font, S) > (cxRectWidth(ACell.Bounds) - cxTextOffset * 2)) then
    begin
      ATextType := RevertTypes[ATextType];
      ATextAdjusted := False;
    end;
  end;

begin
  FMajorTextType := sttUnknown;
  FMinorTextType := sttUnknown;
  repeat
    ATextAdjusted := True;
    for I := 0 to TimeLineCells.Count - 1 do
    begin
      ACell := TcxSchedulerTimeGridMinorScaleCell(TimeLineCells.List^[I]);
      case ACell.ItemType of
        0:
          CheckScale(FMajorTextType);
        1:
          CheckScale(FMinorTextType);
      end;
      if not ATextAdjusted then Break;
    end;
  until ATextAdjusted;
end;

procedure TcxSchedulerTimeGridViewViewInfo.CalculateContentCells;
var
  R: TRect;
  I, J, ID: Integer;
  AColor: TColor;
  ACell: TcxSchedulerTimeGridSelectionBarCell;
  AContentCell: TcxSchedulerContentCellViewInfo;
  AResource: TcxSchedulerStorageResourceItem;
begin
  R := Bounds;
  for I := 0 to Max(ResourceCount - 1, 0) do
  begin
    AResource := nil;
    if I <= (ResourceCount - 1) then
    begin
      ID := I;
      AResource := Resources[I].ResourceItem;
      R := ResourceHeaderCells[I + 1].Bounds
    end
    else
    begin
      R.Top := FScalesHeight;
      ID := -1;
    end;
    for J := 0 to ColumnCount - 1 do
    begin
      ACell := TcxSchedulerTimeGridSelectionBarCell(TimeLineCells.List^[J]);
      if not ACell.Visible then Continue;
      AColor := StylesAdapter.GetContentParams(ACell.TimeStart, True, AResource).Color;
      R.Left := ACell.Bounds.Left;
      R.Right := ACell.Bounds.Right;
      AContentCell := AddContentCell(R, ACell.TimeStart, ACell.TimeFinish, ID);
      AContentCell.Borders := [bRight];
      if TimeBuilder.MinorUnit = suHour then
        AContentCell.BorderColor := PainterHelper.GetSeparatorColor(AColor,
          IsMinorUnitBreak(J + 1), View.IsWorkTime(AResource, ACell.TimeFinish))
      else
        AContentCell.BorderColor := PainterHelper.GetSeparatorColor(AColor, True,
          View.IsWorkTime(AResource, ACell.TimeStart))
    end;
  end;
end;

procedure TcxSchedulerTimeGridViewViewInfo.CalculateEventPosition(
 AEvent: TcxSchedulerControlEvent; AColIndex: Integer;
 out AStartX, AFinishX: Integer; out AStart, AFinish: TDateTime);

var
  EventStart, EventFinish, AFirst, ALast: TDateTime;

  procedure CalculateForward;
  var
    AStartValue, AFinishValue: TDateTime;
  begin
    ALast := AFinish;
    AFirst := ALast;
    AStartValue := ALast;
    while AEvent.Finish > ALast do
    begin
      AStartValue := ALast;
      AFirst := ALast + MinuteToTime;
      if not TimeBuilder.ValidateTime(AFirst, True) then
        AFirst := AFirst - MinuteToTime;
      if AEvent.Finish < AFirst then Break;
      AFinishX := AFinishX + FColumnWidth;
      ALast := TimeBuilder.CalculateDateTimeDateTimeWithoutCheckWorkDays(AFirst, 1);
      AFirst := ALast;
      //
      TimeBuilder.CheckWorkDays(ALast, True);
      ALast := TimeBuilder.RoundTime(ALast);
      //
      if EventFinish > AFirst then
      begin
        AFinish := ALast;
        if (EventFinish > ALast) and TimeBuilder.IsPeriodChanged(AStartValue, ALast) then
          Inc(AFinishX, FSeparatorWidth - 1);
      end;
    end;
    if not View.IsSnapEventsToTimeSlots then
    begin
      AFinishValue := TimeBuilder.CalculateDateTimeDateTimeWithoutCheckWorkDays(AStartValue, 1);
      AFinishX := GetActualPos(AFinishX - FColumnWidth, EventFinish, AStartValue, AFinishValue);
    end;
  end;

  procedure CalculateBackward;
  var
    ACorrected: Boolean;
    AIsWorkDays: Boolean;
    AFirstWithoutCheckWorkDays: TDateTime;
  begin
    AFirst := AStart;
    ALast := AFirst;
    if not View.IsSnapEventsToTimeSlots and (EventStart >= AFirst) then
    begin
      AStartX := GetActualPos(AStartX, EventStart, AFirst, TimeBuilder.Inc(AFirst));
      Exit;
    end;
    while AEvent.Start < AFirst do
    begin
      ALast := AFirst;
      TimeBuilder.ValidateTime(ALast, False);
      AFirst := TimeBuilder.Dec(ALast);
      AFirstWithoutCheckWorkDays := TimeBuilder.CalculateDateTimeDateTimeWithoutCheckWorkDays(AFirst, -1);
      AIsWorkDays := AFinish <> AFirstWithoutCheckWorkDays;
      ACorrected := TimeBuilder.TimeCorrected(AFirst, ALast, False);
      if (EventStart <= AFirst) or ((EventStart > AFirst) and (EventStart < ALast) and
        not TimeBuilder.IsPeriodChanged(AFirst, EventStart)) then
      begin
        if AIsWorkDays then
          AStart := AFirstWithoutCheckWorkDays
        else
          AStart := AFirst;
        AStartX := AStartX - FColumnWidth;
      end;
      if not View.IsSnapEventsToTimeSlots and (EventStart >= AFirst) and not AIsWorkDays and not ACorrected then
        AStartX := GetActualPos(AStartX, EventStart, AFirst, ALast);
      if TimeBuilder.IsPeriodChanged(AFirst, ALast) and (EventStart <= AFirst) and not AIsWorkDays then
        Dec(AStartX, FSeparatorWidth);
    end;
  end;

begin
  with TcxSchedulerTimeGridSelectionBarCell(FTimeLineCells.List^[AColIndex]) do
  begin
    AStartX := Bounds.Left;
    AFinishX := Bounds.Left;
    AStart := TimeStart;
    AFinish := TimeStart;
    if AEvent.Duration < 1 * MinuteToTime then
    begin
      AFinishX := Bounds.Right;
      AFinish := TimeFinish;
    end;
  end;
  EventStart := DateTimeHelper.RoundTime(AEvent.Start);
  EventFinish := DateTimeHelper.RoundTime(AEvent.Finish);
  CalculateForward;
  CalculateBackward;
  // correct bounds by indent
  if not View.IsSnapEventsToTimeSlots then
  begin
    Inc(AStartX);
    AFinishX := Max(AFinishX, AStartX + FEventMinSize)
  end
  else
  begin
    Inc(AStartX, cxHorzEventIndent - 1);
    Dec(AFinishX, cxHorzEventIndent);
  end;
end;

procedure TcxSchedulerTimeGridViewViewInfo.CalculateEvents;

  procedure SaveEventsLineStart(ABuilder: TcxSchedulerEventLayoutBuilder);
  var
    I: Integer;
  begin
    for I := 0 to ABuilder.EventPlaceCount - 1 do
      ABuilder.EventPlaces[I].LineStartToEvent;
  end;

var
  AEventIndex, AResourceIndex: Integer;
  ABuilder: TcxSchedulerEventLayoutBuilder;
begin
  ABuilder := CreateLayoutBuilder;
  try
    ABuilder.Clear;
    for AResourceIndex := 0 to Max(ResourceCount - 1, 0) do
      for AEventIndex := 0 to Events.AbsoluteCount - 1 do
        AddEventForCalculation(ABuilder, Events.AbsoluteItems[AEventIndex], AResourceIndex);
    ABuilder.Calculate;
    CalculateResourceViewShifts(ABuilder);
    SaveEventsLineStart(ABuilder);
    for AEventIndex := 0 to ABuilder.EventPlaceCount - 1 do
      Realign(ABuilder.EventPlaces[AEventIndex]);
    for AEventIndex := EventCells.Count - 1 downto 0 do
      CheckEventVisibility(TcxSchedulerEventCellViewInfo(
        EventCells.List^[AEventIndex]), AEventIndex);
  finally
    ABuilder.Free;
  end;
end;

procedure TcxSchedulerTimeGridViewViewInfo.CalculateMetrics;
begin
  inherited CalculateMetrics;
  if Adapter.IsPrinting or (Scales.FMajorUnitSeparatorWidth = 0) then
    FSeparatorWidth := 1
  else
    FSeparatorWidth := Scales.FMajorUnitSeparatorWidth + 2;
  if (ResourceCount > 0) and FPrintResourceHeaders then
    FResourceHeaderWidth := FResourceHeaderHeight
  else
    FResourceHeaderWidth := 0;
  ValidateStartTime;
  CalculateScalesHeight;
  if TimeBuilder.MinorUnit = suHour then
    FColumnWidth := Max(Scales.MinorUnitWidth div (60 div Scales.TimeStep), 1)
  else
    FColumnWidth := Scales.MinorUnitWidth;
  with Bounds do
    FScalesBounds := Rect(Left + FResourceHeaderWidth, Top, Right, Top + FScalesHeight);
  FEventMinSize := cxTextWidth(Scheduler.Font, 'Wg');
end;

procedure TcxSchedulerTimeGridViewViewInfo.CalculateResourceBounds;
var
  I: Integer;
  R: TRect;
begin
  R := FBounds;
  R.Left := ResourceHeaderWidth;
  for I := 0 to ResourceCount - 1 do
  begin
    CalculateResourceTopBottom(I, R);
    AddResourceBounds(I, R);
  end;
end;

procedure TcxSchedulerTimeGridViewViewInfo.CalculateResourceHeaderCells;
var
  R: TRect;
  I: Integer;
  AHeader: TcxSchedulerHeaderCellViewInfo;
begin
  if ResourceCount = 0 then Exit;
  R := cxRectSetWidth(FBounds, ResourceHeaderWidth);
  AddResourceHeader(-1, cxRectSetSize(Bounds, ResourceHeaderWidth, FScalesHeight));
  for I := 0 to ResourceCount - 1 do
  begin
    CalculateResourceTopBottom(I, R);
    AHeader := AddResourceHeader(I, R);
    AHeader.RotateText := View.Scheduler.OptionsView.RotateResourceCaptions;
    AHeader.RotateHeader := True;
    if I < ResourceCount - 1 then
      AddGroupHorzSeparator(R.Bottom);
  end;
  ProcessCheckBorders(ResourceHeaderCells, True, [], []);
end;

procedure TcxSchedulerTimeGridViewViewInfo.CalculateResourceHeadersAutoHeight(
  AWidth: Integer);
begin
  if not ResourceHeaders.RotateCaptions then
    FResourceHeaderHeight := CalculateResourceHeaderWidth
  else
    inherited CalculateResourceHeadersAutoHeight(AWidth);
  FResourceHeaderWidth := FResourceHeaderHeight;
end;

procedure TcxSchedulerTimeGridViewViewInfo.CalculateResourceTopBottom(
  AResourceIndex: Integer; var ABounds: TRect);
var
  H: Integer;
begin
  H := GetResourceHeight;
  ABounds.Top := MulDiv(H, AResourceIndex, ResourceCount);
  ABounds.Bottom := MulDiv(H, AResourceIndex + 1, ResourceCount);
  OffsetRect(ABounds, 0, SeparatorWidth * AResourceIndex + FScalesHeight);
end;

procedure TcxSchedulerTimeGridViewViewInfo.CalculateScales;
var
  I: Integer;
begin
  CalculateSelectionBar;
  CalculateMinorScale;
  CalculateMajorScale;
  FEventRowHeight := FContentLineHeight + IndentBetweenLines;
  if View.ScaleTextType = sttUnknown then
  begin
    AdjustTextType;
    View.ScaleTextType := FMajorTextType;
  end;
  for I := 0 to TimeLineCells.Count - 1 do
    TcxSchedulerTimeGridMinorScaleCell(TimeLineCells[I]).Calculate;
end;

procedure TcxSchedulerTimeGridViewViewInfo.CalculateScalesHeight;
begin
  if not FPrintScales then
  begin
    FMajorScaleHeight := 0;
    FMinorScaleHeight := 0;
    FSelectionBarHeight := 0;
  end
  else
  begin
    FMajorScaleHeight := MeasureFontHeight(View.Styles.MajorScale, -1, [bBottom]);
    if not Scales.Major then
      FMajorScaleHeight := 0;
    FMinorScaleHeight := MeasureFontHeight(View.Styles.MinorScale, -1, [bBottom]);
    if not Scales.Minor then
      FMinorScaleHeight := 0;
    FSelectionBarHeight := MeasureFontHeight(View.Styles.SelectionBar, -1, [bBottom]);
    FSelectionBarHeight := Max(cxMinSelectionBarHeight, Round(FSelectionBarHeight / 1.5));
  end;
  FScalesHeight := FMajorScaleHeight + FMinorScaleHeight + FSelectionBarHeight;
end;

procedure TcxSchedulerTimeGridViewViewInfo.ChangeResourceShift(
  AResourceIndex, ADelta: Integer);
begin
  Inc(GetResourceViewShift(AResourceIndex).FShift, ADelta);
  View.Changed;
end;

procedure TcxSchedulerTimeGridViewViewInfo.CheckEventVisibility(
  ACell: TcxSchedulerEventCellViewInfo; AIndex: Integer);
begin
  if ACell.Hidden then
  begin
    ACell.Free;
    FEventCells.Delete(AIndex);
  end;
end;

function TcxSchedulerTimeGridViewViewInfo.CheckFinishTime(
  const ATime: TDateTime; AUnit: TcxSchedulerTimeGridScaleUnit): TDateTime;
begin
  Result := ATime;
{  if not View.WorkDaysOnly and (AUnit in [suWeek]) then
    Result := Result - 1;}
end;

procedure TcxSchedulerTimeGridViewViewInfo.Clear;
begin
  inherited Clear;
  FTimeLineCells.Clear;
end;

function TcxSchedulerTimeGridViewViewInfo.CreateEventCellViewInfo(
  AViewData: TcxSchedulerEventViewData): TcxSchedulerEventCellViewInfo;
begin
  Result := TcxSchedulerTimeGridViewEventCellViewInfo.Create(AViewData);
end;

function TcxSchedulerTimeGridViewViewInfo.CreateLayoutBuilder: TcxSchedulerEventLayoutBuilder;
begin
  Result := TcxSchedulerEventLayoutBuilder.Create;
end;

procedure TcxSchedulerTimeGridViewViewInfo.DoCalculate;
var
  AIntf: IcxSchedulerTimeGridViewAdapter;
begin
  Supports(Adapter, IcxSchedulerTimeGridViewAdapter, AIntf);
  FShowLinks := AIntf.GetShowLinks;
  FWorkTimeOnly := AIntf.GetWorkTimeOnly;
  FWorkDaysOnly := AIntf.GetWorkDaysOnly;
  FPrintResourceHeaders := AIntf.GetShowResourceHeaders;
  FPrintScales := AIntf.GetShowScales;
  FLineOffset := AIntf.GetLineOffset;
  AIntf := nil;
  View.FVisibleStart := Adapter.PrintFrom;
  FTimeBuilder.Initialize(View, WorkTimeOnly, WorkDaysOnly);
  FScales := View.Scales;
  inherited DoCalculate;
  CalculateResourceHeaderCells;
  CalculateScales;
  CalculateContentCells;
  CalculateEvents;
  CalculateResourceBounds;
  CalculateContentNavigationButtons;
  Inc(View.FLockSelectionCounter);
  try
    View.UpdateDateNavigatorSelection;
    View.Controller.Navigation.CheckSelection;
  finally
    Dec(View.FLockSelectionCounter);
  end;
end;

procedure TcxSchedulerTimeGridViewViewInfo.DoContentNavigationButtonClick(
  Sender: TcxSchedulerContentNavigationButtonViewInfo);
begin
  View.VisibleStart := View.VisibleStart + Sender.Interval;
  inherited DoContentNavigationButtonClick(Sender);
end;

procedure TcxSchedulerTimeGridViewViewInfo.DoResourceVerticalScroll(
  Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  GetResourceViewShift(TcxSchedulerTimeGridScrollBar(Sender).ResourceIndex).FShift :=
    -ScrollPos;
  View.Changed;
end;

procedure TcxSchedulerTimeGridViewViewInfo.DoTimeGridMoreEventsButtonClick(
  Sender: TcxSchedulerMoreEventsButtonViewInfo);
var
  ATimeGridButtonViewInfo: TcxSchedulerTimeGridMoreEventsButtonViewInfo;
begin
  ATimeGridButtonViewInfo := TcxSchedulerTimeGridMoreEventsButtonViewInfo(Sender);
  ChangeResourceShift(ATimeGridButtonViewInfo.ResourceIndex,
    ATimeGridButtonViewInfo.Delta);
end;

function TcxSchedulerTimeGridViewViewInfo.IsColumnEvent(
  AEvent: TcxSchedulerControlEvent; AColumnIndex: Integer): Boolean;
var
  AFinish, AStart: TDateTime;
begin
  Result := False;
  AStart := TcxSchedulerTimeGridSelectionBarCell(FTimeLineCells.List^[AColumnIndex]).TimeStart;
  AFinish := TcxSchedulerTimeGridSelectionBarCell(FTimeLineCells.List^[AColumnIndex]).TimeFinish;
  if (AEvent.Duration < 1) and View.WorkTimeOnly and
    ((TimeOf(AEvent.Finish) < View.WorkStart) and (TimeOf(AEvent.Start) > View.WorkFinish)) then
    Exit;
  if Scales.MinorUnit = suDay then
    Result := AEvent.IsDayEvent(AStart)
  else
    if Scales.MinorUnit > suDay then
      Result := (AEvent.Finish > AStart) and (AEvent.Start < AFinish)
    else
      if AEvent.Finish = AEvent.Start then
        Result := (AEvent.Start >= AStart) and (AEvent.Start < AFinish)
      else
      begin
        if AEvent.Finish > AStart then
          Result := {(AEvent.Start <= AStart) or
            (AEvent.Finish <= AFinish) todo: } AEvent.Start < AFinish
        else
          if AEvent.Finish = AStart then
            Result := AEvent.Start = AStart;
      end;
end;

function TcxSchedulerTimeGridViewViewInfo.IsEventVisible(
  AEvent: TcxSchedulerControlEvent): Boolean;
var
  I: Integer;
begin
  Result := True;
  if TcxSchedulerTimeGridViewController(View.Controller).ConsiderHiddenEvents  or
    (Events.Clones.Count = 0) or (not FHideClones and not FHideSource) then Exit;
  if AEvent.IsClone then
    Result := not FHideClones
  else
    if FHideSource then
    begin
      Result := True;
      for I := 0 to Events.Clones.Count - 1 do
        if TcxSchedulerControlEvent(Events.Clones[I]).Source = AEvent then
        begin
          Result := False;
          Break;
        end;
    end;
end;

function TcxSchedulerTimeGridViewViewInfo.IsMinorUnitBreak(AColumn: Integer): Boolean;

  function IsHourEqual(const ATime1, ATime2: TDateTime): Boolean;
  begin
    Result := (Round(ATime1 / MinuteToTime) div 60) =
      (Round(ATime2 / MinuteToTime) div 60);
  end;

begin
  if TimeBuilder.MinorUnit <> suHour then
    Result := True
  else
  begin
    Result := AColumn >= ColumnCount;
    if not Result then
    begin
       Result := not IsHourEqual(TcxSchedulerTimeGridSelectionBarCell(FTimeLineCells[AColumn - 1]).TimeStart,
         TcxSchedulerTimeGridSelectionBarCell(FTimeLineCells[AColumn]).TimeStart);
    end;
  end;
end;

function TcxSchedulerTimeGridViewViewInfo.GetActualPos(
 const APos: Integer; const  ATime, AStart, AFinish: TDateTime): Integer;
begin
  Result := APos;
  if DateTimeHelper.RoundTime(ATime) >= DateTimeHelper.RoundTime(AFinish) then
    Inc(Result, FColumnWidth)
  else
    if (ATime > AStart) and (ATime < AFinish) then
       Result := APos + Round((ATime - AStart) * FColumnWidth / (AFinish - AStart));
end;

function TcxSchedulerTimeGridViewViewInfo.GetContentParams(const ATime: TDateTime;
  AResource: TcxSchedulerResourceViewInfo): TcxViewParams;
begin
  Result := inherited GetContentParams(ATime, AResource);
  if not HiddenSelection and IsTimeSelected(ATime, AResource) then
    Result := GetSelectionParams(Result);
end;

function TcxSchedulerTimeGridViewViewInfo.GetEventClipRect(
  AEventViewInfo: TcxSchedulerEventCellViewInfo): TRect;
var
  I: Integer;
  AResourceInfo: TcxSchedulerResourceViewInfo;
begin
  AResourceInfo := AEventViewInfo.ResourceInfo;
  Result := Rect(ResourceHeaderWidth, ScalesHeight, Bounds.Right, Bounds.Bottom);
  if AResourceInfo <> nil then
  begin
    for I := 0 to ResourceCount - 1 do
      if Resources[I].ResourceItem = AResourceInfo.ResourceItem then
      begin
        with ResourceHeaderCells[I + 1].Bounds do
          Result := cxRectSetYPos(Result, Top, Bottom);
        Exit;
      end;
    Result := cxInvalidRect;
  end;
end;

function TcxSchedulerTimeGridViewViewInfo.GetIndentBetweenLines: Integer;
begin
  Result := cxTextOffset;
end;

procedure TcxSchedulerTimeGridViewViewInfo.GetItemInfo(AIndex1, AIndex2,
  ATop, AHeight: Integer; var ABounds: TRect; var AStart, AFinish: TDateTime);
begin
  AIndex2 := Min(ColumnCount - 1, AIndex2);
  AIndex1 := Min(ColumnCount - 1, AIndex1);
  with TcxSchedulerTimeGridSelectionBarCell(FTimeLineCells[AIndex1]) do
  begin
    ABounds.Left := Bounds.Left;
    AStart := TimeStart;
  end;
  ABounds.Top := ATop;
  ABounds.Bottom := ATop + AHeight;
  with TcxSchedulerTimeGridSelectionBarCell(FTimeLineCells[AIndex2]) do
  begin
    ABounds.Right := Bounds.Right;
    AFinish := TimeStart{Finish}; // todo: !!!!!!!!!!!!!!!!
  end;
end;

function TcxSchedulerTimeGridViewViewInfo.GetNeedShowCurrentTime: Boolean;
begin
  Result := True;
end;

function TcxSchedulerTimeGridViewViewInfo.GetMoreEventButtonClass: TcxSchedulerMoreEventsButtonViewInfoClass;
begin
  Result := TcxSchedulerTimeGridMoreEventsButtonViewInfo;
end;

function TcxSchedulerTimeGridViewViewInfo.GetResourceScrollBarMax(I: Integer): Integer;
begin
  Result := -1;
  if (I < 0) or (I >= FResourceViewShift.Count) then
    Exit;
  if ResourceViewShift[I].FScrollBar <> nil then
    Result := ResourceViewShift[I].FScrollBar.Max
end;

function TcxSchedulerTimeGridViewViewInfo.GetResourceImagesSize: TSize;
begin
  if ResourceImages = nil then
    Result := TSize(cxNullSize)
  else
    Result := cxSize(ResourceImages.Height, ResourceImages.Width);
end;

function TcxSchedulerTimeGridViewViewInfo.GetResourcesContentWidth: Integer;
begin
  CalculateScalesHeight;
  Result := (Bounds.Bottom - Bounds.Top) - FScalesHeight;
end;

function TcxSchedulerTimeGridViewViewInfo.GetResourceScrollBarKind: TScrollBarKind;
begin
  Result := sbVertical;
end;

function TcxSchedulerTimeGridViewViewInfo.GetStyleFont(AStyle: TcxStyle): TFont;
begin
  if (AStyle <> nil) and (cxStyles.svFont in AStyle.AssignedValues) then
    Result := AStyle.Font
  else
    Result := View.Scheduler.Font;
end;

procedure TcxSchedulerTimeGridViewViewInfo.MakeTimeVisible(
  const ATime: TDateTime);
var
  APos: Integer;
  AFinish: TDateTime;
begin
  if ATime < View.VisibleStart then
    View.FVisibleStart := ATime
  else
    if ATime > View.VisibleFinish then
    begin
      APos := Bounds.Right - FResourceHeaderWidth;
      View.FVisibleStart := ATime;
      while APos > Bounds.Left do
      begin
        TimeBuilder.CheckWorkDays(View.FVisibleStart, False);
        AFinish := View.FVisibleStart;
        Dec(APos, FColumnWidth);
        if TimeBuilder.IsPeriodChanged(View.FVisibleStart, AFinish) then
          if (APos - FColumnWidth) >= (Bounds.Left + FSeparatorWidth) then
            Dec(APos, FSeparatorWidth);
        if (APos - FColumnWidth) > Bounds.Left then
        begin
          View.FVisibleStart := TimeBuilder.Dec(AFinish);
          if not TimeBuilder.CheckMidnight then
            TimeBuilder.TimeCorrected(View.FVisibleStart, AFinish, False);
        end
        else
          Break;
      end;
    end;
end;

function TcxSchedulerTimeGridViewViewInfo.MeasureFontHeight(
  AStyle: TcxStyle; AHeight: Integer; Borders: TcxBorders): Integer;
begin
  Result := AHeight;
  if Result = -1 then
    Result := cxTextHeight(GetStyleFont(AStyle)) + cxTextOffset * 2;
  if bTop in Borders then Inc(Result);
  if bBottom in Borders then Inc(Result);
end;

procedure TcxSchedulerTimeGridViewViewInfo.Realign(APlace: TcxSchedulerEventPlace);

  function GetButton(AColumnIndex: Integer;
    IsDown: Boolean): TcxSchedulerMoreEventsButtonViewInfo;
  begin
    Result := GetResourceViewShift(Integer(
      APlace.Resource)).FMoreEventButtons[AColumnIndex * 2 + IfThen(IsDown, 1)];
  end;

  function GetMoreButtonHeight: Integer;
  begin
    Result := View.ExternalPainter.MoreButtonSize(
      Size(PainterHelper.MoreButtonWidth, PainterHelper.MoreButtonHeight)).cy;
  end;

  procedure AddMoreEventButton(AnEventLineIndex, ALineCount: Integer; R: TRect;
    ADateTime: TDateTime; IsVisible: Boolean);
  var
    AColumnIndex, ADelta: Integer;
    ADownDirection, CanChangeDelta: Boolean;
    AButton: TcxSchedulerTimeGridMoreEventsButtonViewInfo;
  begin
    AColumnIndex := R.Left div FColumnWidth;
    if (AColumnIndex < 0) or (AColumnIndex * 2 >=
      Length(GetResourceViewShift(Integer(
        APlace.Resource)).FMoreEventButtons)) then
      Exit;
    ADelta := 0;
    CanChangeDelta := False;
    ADownDirection := False;
    if AnEventLineIndex < 0 then
    begin
      ADelta := -AnEventLineIndex;
      R.Bottom := R.Top + GetMoreButtonHeight;
      CanChangeDelta := Abs(AnEventLineIndex) <= ALineCount - 1;
    end
    else
      if AnEventLineIndex >= ALineCount then
      begin
        ADelta := -(AnEventLineIndex - ALineCount + 1);
        ADownDirection := True;
        R.Top := R.Bottom - GetMoreButtonHeight;
        CanChangeDelta := AnEventLineIndex - ALineCount + 1 <= ALineCount - 1;
      end;
    if ADelta <> 0 then
    begin
      AButton := GetButton(AColumnIndex, ADownDirection) as TcxSchedulerTimeGridMoreEventsButtonViewInfo;
      if AButton = nil then
      begin
        AButton := AddButton(R, ADateTime, ADownDirection, APlace.Event) as TcxSchedulerTimeGridMoreEventsButtonViewInfo;
        AButton.FVisible := IsVisible;
        AButton.Delta := ADelta;
        AButton.ResourceIndex := Integer(APlace.Resource);
        AButton.OnClick :=DoTimeGridMoreEventsButtonClick;
        GetResourceViewShift(Integer(
          APlace.Resource)).FMoreEventButtons[AColumnIndex * 2 + IfThen(
          ADownDirection, 1)] := AButton;
      end
      else
        if CanChangeDelta and ((Abs(AButton.Delta) < Abs(ADelta)) or not AButton.ValidDelta) then
          AButton.Delta := ADelta;
      AButton.ValidDelta := CanChangeDelta;
    end;
  end;

var
  AEventRect, AButtonRect, AClipRect: TRect;
  ACell: TcxSchedulerTimeGridViewEventCellViewInfo;
  ALineCount, AnEventLineIndex: Integer;
  AViewData: TcxSchedulerEventViewData;
begin
  ALineCount := GetVisibleLineCount(Integer(APlace.Resource));
  AnEventLineIndex := APlace.LineStart +
    GetResourceViewShift(Integer(APlace.Resource)).FShift - FLineOffset;

  ACell := TcxSchedulerTimeGridViewEventCellViewInfo(APlace.Data);
  AViewData := ACell.EventViewData;

  AViewData.Bounds.Bottom := AViewData.VisibleRect.Top +
    (APlace.LineFinish - APlace.LineStart + 1) * FEventRowHeight;
  if not View.IsSnapEventsToTimeSlots then
    Dec(AViewData.Bounds.Left);
  ACell.MoveTo(0, AnEventLineIndex * FEventRowHeight);
  if ((0 > AnEventLineIndex) or (AnEventLineIndex >= ALineCount)) and
    TcxSchedulerTimeGridView(Owner).ShowMoreEventsButton then
  begin
    AEventRect := AViewData.Bounds;
    while AEventRect.Left < 0 do
      Inc(AEventRect.Left, FColumnWidth);
    AButtonRect := AEventRect;
    AButtonRect.Right := AButtonRect.Left + FColumnWidth;
    AButtonRect.Bottom := AViewData.VisibleRect.Bottom;
    AButtonRect.Top := AViewData.VisibleRect.Top;
    AClipRect := GetEventClipRect(ACell);
    while AEventRect.Right > AButtonRect.Left do
    begin
      if (AButtonRect.Left >= AClipRect.Left) and (AButtonRect.Right <= AClipRect.Right) then
      begin
        AddMoreEventButton(AnEventLineIndex, ALineCount, AButtonRect, ACell.Event.Start,
          (AViewData.VisibleRect.Bottom - AViewData.VisibleRect.Top) div 2 >=
          GetMoreButtonHeight);
      end;
      OffsetRect(AButtonRect, FColumnWidth, 0);
    end;
    ACell.Hidden := True;
  end;
end;

procedure TcxSchedulerTimeGridViewViewInfo.ReturnVisibleInterval(
  var AStart, AEnd: TDateTime);
begin
  AStart := View.VisibleStart;
  AEnd := AStart;
end;

procedure TcxSchedulerTimeGridViewViewInfo.RestoreScrollInfo;
var
  I: Integer;
begin
  for I := 0 to FResourceViewShift.Count - 1 do
    ResourceViewShift[I].Restore;
end;

procedure TcxSchedulerTimeGridViewViewInfo.StoreScrollInfo;
var
  I: Integer;
begin
  if FResourceViewShift = nil then Exit;
  for I := 0 to FResourceViewShift.Count - 1 do
    ResourceViewShift[I].Store(Adapter.IsPrinting);
end;

procedure TcxSchedulerTimeGridViewViewInfo.ValidateStartTime;
begin
  if View.FVisibleStart = NullDate then
  begin
    View.FVisibleStart := Days[0];
    if not Adapter.IsPrinting then
      View.Controller.Navigation.ReplaceSelParams(
        NullDate, NullDate, View.Scheduler.SelResource)
  end;
  FActualStartTime := FTimeBuilder.ValidateStartTime(Adapter.ActualStart);
  FTimeBuilder.CalculateActualStart(FActualStartTime,
    View.FVisibleStart, FFirstVisibleIndex);
  if not Adapter.IsPrinting then
  begin
    SelectedDays.Clear;
    SelectedDays.Add(View.FVisibleStart);
    TcxSchedulerTimeGridViewAdapter(Adapter).FVisibleStart := View.FVisibleStart;
  end;
end;

procedure TcxSchedulerTimeGridViewViewInfo.CalculateResourceViewShifts(
  ABuilder: TcxSchedulerEventLayoutBuilder);

  function GetResourceBounds(AIndex: Integer): TRect;
  var
    I, ADimension: Integer;
  begin
    Result := cxNullRect;
    for I := 0 to ABuilder.EventPlaceCount - 1 do
      if Integer(ABuilder.EventPlaces[I].Resource) = AIndex then
      begin
        Result := TcxSchedulerTimeGridViewEventCellViewInfo(
          ABuilder.EventPlaces[I].Data).EventViewData.VisibleRect;
        ADimension := Result.Right - Result.Left;
        Result.Left := View.Left;
        Result.Right := Result.Left + ADimension +
          IfThen(ResourceHeaderCells.Count > 0, ResourceHeaderHeight, 0);
        ADimension := Result.Bottom - Result.Top;
        Result.Top := View.Top + Result.Top;
        Result.Bottom := Result.Top + ADimension;
        Break;
      end;
  end;

  procedure PrepareResourceViewShifts;
  var
    I: Integer;
  begin
    if (ResourceCount > 0) and (FResourceViewShift.Count <> ResourceCount) or
      (ResourceCount = 0) and (FResourceViewShift.Count <> 1) then
        FResourceViewShift.Clear;
    for I := FResourceViewShift.Count to Max(0, ResourceCount - 1) do
      FResourceViewShift.Add(TcxSchedulerTimeGridResourceScroll.Create)
  end;

  procedure CalculateEventMaxLines;
  var
    AResourceIndex, I: Integer;
  begin
    for I := 0 to FResourceViewShift.Count - 1 do
      GetResourceViewShift(I).FEventMaxLine := 0;
    for I := 0 to ABuilder.EventPlaceCount - 1 do
    begin
      AResourceIndex := Integer(ABuilder.EventPlaces[I].Resource);
      GetResourceViewShift(AResourceIndex).SetEventMaxLine(
        ABuilder.EventPlaces[I].LineStart);
    end;
  end;

var
  I, AVisibleLineCount: Integer;
  AResourceViewShift: TcxSchedulerTimeGridResourceScroll;
begin
  PrepareResourceViewShifts;
  CalculateEventMaxLines;
  PrepareMoreEventButtons;

  for I := 0 to FResourceViewShift.Count - 1 do
  begin
    AVisibleLineCount := GetVisibleLineCount(I);
    AResourceViewShift := GetResourceViewShift(I);
    if AResourceViewShift.FEventMaxLine < AVisibleLineCount then
    begin
      AResourceViewShift.FShift := 0;
      FreeAndNil(GetResourceViewShift(I).FScrollBar);
    end
    else
      if TcxSchedulerTimeGridView(Owner).ShowResourceScrollBar then
        AResourceViewShift.CreateScrollBar(GetResourceBounds(I), Self.GetTimeGridView, I,
          AResourceViewShift.FEventMaxLine - GetVisibleLineCount(I) + 1, -AResourceViewShift.FShift)
      else
        FreeAndNil(GetResourceViewShift(I).FScrollBar);
  end;
end;

procedure TcxSchedulerTimeGridViewViewInfo.ClearMoreEventButtons;
var
  I: Integer;
begin
  for I := 0 to FResourceViewShift.Count - 1 do
    GetResourceViewShift(I).ClearMoreEventButtons;
end;

function TcxSchedulerTimeGridViewViewInfo.GetGroupCount: Integer;
begin
  Result := FResourceViewShift.Count;
end;

function TcxSchedulerTimeGridViewViewInfo.GetGroupLineCount(
  AIndex: Integer): Integer;
begin
  Result := Max(2, ResourceViewShift[AIndex].FEventMaxLine);
end;

function TcxSchedulerTimeGridViewViewInfo.GetResourceHeight: Integer;
begin
  Result := FBounds.Bottom - FBounds.Top -
    SeparatorWidth * (ResourceCount - 1) - FScalesHeight;
end;

function TcxSchedulerTimeGridViewViewInfo.GetResourceViewShift(
  Index: Integer): TcxSchedulerTimeGridResourceScroll;
begin
  if ResourceCount = 0 then
    Index := 0;
  Result := TcxSchedulerTimeGridResourceScroll(FResourceViewShift[Index]);
end;

function TcxSchedulerTimeGridViewViewInfo.GetTimeGridView: TcxSchedulerTimeGridView;
begin
  Result := TcxSchedulerTimeGridView(inherited View);
end;

function TcxSchedulerTimeGridViewViewInfo.GetVisibleLineCount(AResourceIndex: Integer): Integer;
begin
  if ResourceHeaderCells.Count > 0 then
    with ResourceHeaderCells[1 + AResourceIndex] do
      Result := (Bounds.Bottom - Bounds.Top) div FEventRowHeight
  else
    Result := (Bounds.Bottom - ScalesHeight) div FEventRowHeight;
end;

procedure TcxSchedulerTimeGridViewViewInfo.PrepareMoreEventButtons;
var
  I: Integer;
begin
  ClearMoreEventButtons;
  for I := 0 to FResourceViewShift.Count - 1 do
    SetLength(GetResourceViewShift(I).FMoreEventButtons, ColumnCount * 2);
end;

procedure TcxSchedulerTimeGridViewViewInfo.CalculateMajorScale;
var
  R: TRect;
  AIndex, I: Integer;
  AStart, AFinish, APrevFinish: TDateTime;
  ACell: TcxSchedulerTimeGridMajorScaleCell;
begin
  AIndex := 0;
  AStart := ActualStartTime;
  ACell := nil;
  for I := 1 to ColumnCount do
  begin
    AFinish := TcxSchedulerTimeGridSelectionBarCell(FTimeLineCells[I]).TimeStart;
    if TimeBuilder.IsPeriodChanged(AStart, AFinish) or (I = ColumnCount) then
    begin
      APrevFinish := AFinish;
      GetItemInfo(AIndex, I - 1, FBounds.Top, FMajorScaleHeight, R, AStart, AFinish);
      AddMajorScaleCell(R, AStart, AFinish);
      ACell := TcxSchedulerTimeGridMajorScaleCell(FTimeLineCells.Last);
      AStart := APrevFinish;
      AIndex := I;
    end;
  end;
  if ACell <> nil then
    Inc(ACell.FBounds.Right, Bounds.Right - Bounds.Left);
end;

procedure TcxSchedulerTimeGridViewViewInfo.CalculateMinorScale;
var
  R: TRect;
  AIndex, ATop, I: Integer;
  AStart, AFinish: TDateTime;
begin
  AIndex := 0;
  ATop := FBounds.Top + FMajorScaleHeight;
  for I := 1 to ColumnCount do
    if IsMinorUnitBreak(I) then
    begin
      GetItemInfo(AIndex, I - 1, ATop, FMinorScaleHeight, R, AStart, AFinish);
      AddMinorScaleCell(R, AStart, AFinish);
      AIndex := I;
    end;
end;

procedure TcxSchedulerTimeGridViewViewInfo.CalculateSelectionBar;
var
  ASelBounds: TRect;
  ALeft, AIndex: Integer;
  AActualFinish, AStart, AFinish: TDateTime;
begin
  AIndex := 0;
  AStart := ActualStartTime;
  ALeft := Bounds.Left + FResourceHeaderWidth - FColumnWidth * FirstVisibleIndex;
  ASelBounds := cxRectSetBottom(Bounds, Bounds.Top + FScalesHeight, FSelectionBarHeight);
  FVisibleColumnCount := 0;
  repeat
    AFinish := TimeBuilder.Inc(AStart);
    AActualFinish := AFinish;
    if TimeBuilder.MinorUnit = suHour then
      AActualFinish := TimeBuilder.RoundTime(AStart + View.GetTimeIncrement);
    if TimeBuilder.TimeCorrected(AStart, AFinish) then
    begin
      AddMajorSeparator(ALeft);
      AActualFinish := AFinish;
    end;
    ASelBounds := cxRectSetLeft(ASelBounds, ALeft, FColumnWidth);
    if (FVisibleColumnCount = 0) and (Bounds.Right > ALeft) then
      View.FVisibleStart := AStart;
    AddSelectionBarCell(ASelBounds, AStart, AActualFinish);
    if (AIndex >= FirstVisibleIndex) and ((ALeft + FColumnWidth) <= Bounds.Right) then
      Inc(FVisibleColumnCount);
    if (FVisibleColumnCount = 1) or (ASelBounds.Right <= Bounds.Right) then
      View.FVisibleFinish := AStart;
    FLastVisibleTime := AFinish;
    Inc(ALeft, FColumnWidth);
    Inc(AIndex);
    if (AIndex > FirstVisibleIndex) and TimeBuilder.IsPeriodChanged(AStart, AFinish) then
      AddMajorSeparator(ALeft);
    AStart := AFinish;
  until ALeft >= Bounds.Right;
  FColumnCount := FTimeLineCells.Count;
  FVisibleColumnCount := Max(FVisibleColumnCount, 1);
end;

{ TcxSchedulerTimeGridScaleCell }

constructor TcxSchedulerTimeGridScaleCell.Create(
  APainter: TcxCustomLookAndFeelPainterClass;
  const ABounds, AVisibleRect: TRect; const AViewParams: TcxViewParams);
begin
  inherited Create(APainter, ABounds, AVisibleRect, AViewParams);
  FBorderColor := clBtnShadow;
end;

{ TcxSchedulerTimeGridMinorScaleCell }

procedure TcxSchedulerTimeGridMinorScaleCell.Calculate;
begin
  FTextBounds := Bounds;
end;

procedure TcxSchedulerTimeGridMinorScaleCell.DoDraw;
begin
  DrawContent;
  if (MinuteOf(TimeFinish) = 0) or (bRight in Borders) then
    Canvas.FrameRect(Bounds, clBtnShadow, 1, [bRight])
  else
  begin
    Canvas.FrameRect(Rect(Bounds.Left, Bounds.Bottom - cxTextOffset * 2,
      Bounds.Right, Bounds.Bottom - 1), clBtnShadow, 1, [bRight])
  end;
end;

procedure TcxSchedulerTimeGridMinorScaleCell.DrawContent;
const
  Horz: array[TAlignment] of Integer =
    (CXTO_LEFT, CXTO_RIGHT, CXTO_CENTER_HORIZONTALLY);
  Vert: array[TcxAlignmentVert] of Integer =
    (CXTO_TOP, CXTO_BOTTOM, CXTO_CENTER_VERTICALLY);
var
  R: TRect;
  AFlags: Integer;
  ASelected: Boolean;
begin
  if Self is TcxSchedulerTimeGridSelectionBarCell then
    ASelected := TcxSchedulerTimeGridSelectionBarCell(Self).Selected
  else
    ASelected := False;
  FExternalPainter.DrawTimeGridHeader(Canvas, BorderColor, Self, Borders, ASelected);
  if not FHideDisplayText and (DisplayText <> '') then
  begin
    R := cxTextRect(PainterHelper.ExcludeBorders(FTextBounds, Borders));
    AFlags := Horz[AlignHorz] or Vert[AlignVert];
    SetBkMode(Canvas.Handle, Windows.Transparent);
    cxTextOut(Canvas.Handle, DisplayText, R, AFlags);
  end;
end;

procedure TcxSchedulerTimeGridMinorScaleCell.InitHitTest(
  AHitTest: TcxSchedulerCustomResourceViewHitTest);
begin
  inherited InitHitTest(AHitTest);
  TcxSchedulerTimeGridViewHitTest(AHitTest).SetHitTime(htcMinorScale, TimeStart);
end;

{ TcxSchedulerTimeGridMajorScaleCell }

procedure TcxSchedulerTimeGridMajorScaleCell.Calculate;
var
  W: Integer;
begin
  inherited Calculate;
  Dec(FTextBounds.Right, RightIndent);
  FTextBounds.Left := Max(Bounds.Left, ClipRect.Left);
  W := cxTextWidth(Font, FDisplayText) + cxTextOffset;
  if (Bounds.Left < ClipRect.Left) and (W >= cxRectWidth(FTextBounds)) then
  begin
    FAlignHorz := taRightJustify;
    FHideDisplayText := (cxRectWidth(FTextBounds) / W) < 0.5;
  end;
end;

procedure TcxSchedulerTimeGridMajorScaleCell.DoDraw;
begin
  DrawContent;
end;

procedure TcxSchedulerTimeGridMajorScaleCell.InitHitTest(
  AHitTest: TcxSchedulerCustomResourceViewHitTest);
begin
  inherited InitHitTest(AHitTest);
  TcxSchedulerTimeGridViewHitTest(AHitTest).SetHitTime(htcMajorScale, TimeStart);
end;

{ TcxSchedulerTimeGridSelectionBarCell }

procedure TcxSchedulerTimeGridSelectionBarCell.Calculate;
begin
end;

procedure TcxSchedulerTimeGridSelectionBarCell.CalculateTimeLineParams(
  ANeedShowCurrentTime: Boolean);
var
  ACurrentTime: TDateTime;
  ALeft: Integer;
begin
  ACurrentTime := Now;
  FIsCurrentTimeCell := (ACurrentTime >= TimeStart) and (ACurrentTime < TimeFinish);
  FShowCurrentTime := ANeedShowCurrentTime and IsCurrentTimeCell;
  if IsCurrentTimeCell then
  begin
    ALeft := Bounds.Left + Trunc((Bounds.Right - Bounds.Left) *
      (ACurrentTime - TimeStart) / (TimeFinish - TimeStart));
    FTimeLineRect := Rect(ALeft - 1, Bounds.Top, ALeft + 1, ViewHeight);
  end;
end;

procedure TcxSchedulerTimeGridSelectionBarCell.DoDraw;
begin
  DrawContent;
  if ShowCurrentTime then
    FExternalPainter.DrawTimeGridCurrentTime(Canvas,
      dxOffice11SelectedDownColor2, TimeLineRect);
end;

procedure TcxSchedulerTimeGridSelectionBarCell.InitHitTest(
  AHitTest: TcxSchedulerCustomResourceViewHitTest);
begin
  inherited InitHitTest(AHitTest);
  TcxSchedulerTimeGridViewHitTest(AHitTest).SetHitTime(htcSelectionBar, TimeStart);
end;

{ TcxSchedulerMajorSeparatorCellViewInfo }

procedure TcxSchedulerMajorSeparatorCellViewInfo.DoDraw;
begin
  Canvas.FillRect(Bounds, ViewParams);
  Canvas.FrameRect(ContentBounds, Painter.DefaultSchedulerBorderColor,
    1, [bLeft, bRight]);
end;

procedure TcxSchedulerMajorSeparatorCellViewInfo.InitHitTest(
  AHitTest: TcxSchedulerCustomResourceViewHitTest);
begin
  inherited InitHitTest(AHitTest);
  TcxSchedulerTimeGridViewHitTest(AHitTest).SetBitState(htcMajorSeparator, True);
end;

{ TcxSchedulerTimeGridViewPainter }

procedure TcxSchedulerTimeGridViewPainter.Paint;
begin
  FView := inherited View as TcxSchedulerTimeGridView;
  ViewInfo.ContentCells.Draw(Canvas, DrawContentCell);
  ViewInfo.DayHeaderCells.Draw(Canvas, DrawHeaderCell);
  ViewInfo.TimeLineCells.Draw(Canvas, DrawTimeLineCellItem);
  ViewInfo.ResourceHeaderCells.Draw(Canvas, DrawResourceHeaderCell);
  ViewInfo.GroupSeparatorCells.Draw(Canvas, DrawGroupSeparatorCell);
  ViewInfo.EventCells.Draw(Canvas, DrawEventCell);
  ViewInfo.Buttons.Draw(Canvas, DrawButtonCell);
  ViewInfo.NavigationButtons.Draw(Canvas, DrawButtonCell);
end;

procedure TcxSchedulerTimeGridViewPainter.DrawTimeLineCellItem(
  AItem: TcxSchedulerCustomViewInfoItem; var ADone: Boolean);
begin
  case TcxSchedulerTimeGridMinorScaleCell(AItem).ItemType of
    0:
     View.DoDrawTimeLineHeaderCell(TcxSchedulerTimeGridMajorScaleCell(AItem), ADone);
    1:
     View.DoDrawTimeLineCell(TcxSchedulerTimeGridMinorScaleCell(AItem), ADone);
    2:
     View.DoDrawSelectionBarCell(TcxSchedulerTimeGridSelectionBarCell(AItem), ADone);
  end;
end;

function TcxSchedulerTimeGridViewPainter.GetViewInfo: TcxSchedulerTimeGridViewViewInfo;
begin
  Result := TcxSchedulerTimeGridViewViewInfo(inherited ViewInfo);
end;

{ TcxSchedulerTimeBuilder }

procedure TcxSchedulerTimeBuilder.CalculateActualStart(
  var ActualStart, AVisibleStart: TDateTime; var AStartIndex: Integer);
var
  AStart: TDateTime;
begin
  AStartIndex := 0;
  CheckWorkDays(AVisibleStart, True);
  AVisibleStart := ValidateStartTime(AVisibleStart);
  AStart := ActualStart;
  if (AStart <> 0) or (AStart <> ActualStart) then
  begin
    while not IsPeriodChanged(Dec(ActualStart), AStart) do
      ActualStart := Dec(ActualStart);
  end;
  AStart := ActualStart;
  while AStart < AVisibleStart do
  begin
    AStart := Inc(AStart);
    AStartIndex := AStartIndex + 1;
  end;
end;

procedure TcxSchedulerTimeBuilder.CheckWorkDays(var ADateTime: TDateTime; AGoForward: Boolean);
begin
  if MinorUnit > suDay then Exit;
  while CheckDays and not (TDay(DayOfWeek(ADateTime) - 1) in WorkDays) do
     ADateTime := ADateTime + Byte(AGoForward) * 2 - 1;
end;

function TcxSchedulerTimeBuilder.Dec(const ADateTime: TDateTime): TDateTime;
begin
  Result := CalculateDateTime(ADateTime, -1);
end;

function TcxSchedulerTimeBuilder.Inc(const ADateTime: TDateTime): TDateTime;
begin
  Result := CalculateDateTime(ADateTime, 1);
end;

function TcxSchedulerTimeBuilder.IsPeriodChanged(
  const AFirst, ANext: TDateTime): Boolean;
begin
  Result := False;
  case MajorUnit of
    suDay:
      Result := DayOf(AFirst) - DayOf(ANext) <> 0;
    suWeek:
      Result := WeekOf(AFirst) - WeekOf(ANext) <> 0;
    suMonth:
      Result := MonthOf(AFirst) - MonthOf(ANext) <> 0;
    suQuarter:
      Result := (MonthOf(AFirst) - 1) div 3 - (MonthOf(ANext) - 1) div 3 <> 0;
    suYear:
      Result := YearOf(AFirst) - YearOf(ANext) <> 0;
  end;
end;

procedure TcxSchedulerTimeBuilder.Initialize(AView: TcxSchedulerTimeGridView;
  AWorkTimeOnly, AWorkDaysOnly: Boolean);
begin
  ValidateUnits(AView.Scales.FMajorUnit, AView.Scales.FMinorUnit);
  MajorUnit := AView.Scales.MajorUnit;
  MinorUnit := AView.Scales.MinorUnit;
  TimeStep := AView.Scales.TimeStep;
  TimeScale := CalculateScaleUnit(AView.Scales.TimeStep);
  WorkFinish := AView.WorkFinish;
  WorkStart := AView.WorkStart;
  WorkDays := AView.WorkDays;
  CalculateWorkTime(AWorkTimeOnly, WorkStart, WorkFinish);
  CalculateWorkDays(AWorkDaysOnly, WorkDays);
end;

function TcxSchedulerTimeBuilder.TimeCorrected(
  var AStart, AFinish: TDateTime; AGoForward: Boolean = True): Boolean;
begin
  Result := CheckTime and IsPeriodChanged(AStart, AFinish);
  if Result then
  begin
    if AGoForward then
    begin
      AStart := AFinish;
      AFinish := Inc(AStart)
    end
    else
    begin
      AStart := Dec(AStart);
      AFinish := AStart;
    end;
  end;
end;

function TcxSchedulerTimeBuilder.TimeMode: Boolean;
begin
  Result := (MajorUnit = suDay) and (MinorUnit = suHour)
end;

function TcxSchedulerTimeBuilder.CalculateDateTime(
  const ADateTime: TDateTime; AInc: Integer): TDateTime;
begin
  Result := CalculateDateTimeDateTimeWithoutCheckWorkDays(ADateTime, AInc);
  CheckWorkDays(Result, AInc > 0);
  Result := RoundTime(Result);
end;

function TcxSchedulerTimeBuilder.CalculateDateTimeDateTimeWithoutCheckWorkDays(
  const ADateTime: TDateTime; AInc: Integer): TDateTime;
var
  ATimeInc: Integer;
begin
  Result := ADateTime;
  ATimeInc := 1;
  if MinorUnit = suHour then
  begin
    Result := Result + AInc * TimeScale * MinuteToTime;
    if (ATimeInc = 1) and CheckTime and (Abs(Trunc(ADateTime) - Trunc(Result)) >= 1) then
      ATimeInc := 0;
    if CheckMidnight then
      ValidateMidnightForward(Result);
  end
  else
    if MinorUnit <= suWeek then
      Result := IncDay(Result, AInc * TimeScale)
  else
    if MinorUnit > suWeek then
      Result := StartOfTheMonth(SysUtils.IncMonth(Result, AInc * TimeScale));
  ValidateTime(Result, AInc > 0, ATimeInc);
  Result := RoundTime(Result);
end;

function TcxSchedulerTimeBuilder.CalculateScaleUnit(const AScaleUnit: Integer): Integer;
const
  TimeScales: array[TcxSchedulerTimeGridScaleUnit] of Integer =
    (1, 1, 7, 1, 3, 12);
begin
  Result := AScaleUnit;
  if not TimeMode then
    Result := TimeScales[MinorUnit];
end;

procedure TcxSchedulerTimeBuilder.CalculateWorkTime(AIsWorkTimeOnly: Boolean;
  var AWorkStart, AWorkFinish: TDateTime);
begin
  if not AIsWorkTimeOnly or not TimeMode then
  begin
    WorkFinish := EncodeTime(23, 59, 59, 0);
    WorkStart := 0;
  end;
  CheckTime := (TimeOf(WorkStart) > 0) or
    (TimeOf(WorkFinish) < EncodeTime(23, 59, 59, 0)) and (MinorUnit = suHour);
  WorkFinish := RoundTime(WorkFinish);
  WorkStart := RoundTime(WorkStart);
  CheckMidnight := AIsWorkTimeOnly and CheckTime and
    (TimeOf(WorkFinish) - EncodeTime(23, 59, 59, 0) <= SecondToTime);
end;

procedure TcxSchedulerTimeBuilder.CalculateWorkDays(
  AIsWorkDaysOnly: Boolean; var AWorkDays: TDays);
const
  FullWeek = [dSunday..dSaturday];
begin
  if not AIsWorkDaysOnly then
    WorkDays := FullWeek;
  CheckDays := FullWeek * WorkDays <> FullWeek;
end;

function TcxSchedulerTimeBuilder.GetScaleStep: TDateTime;
begin
  if TimeMode then
    Result := TimeScale * MinuteToTime
  else
    Result := TimeScale;
end;

procedure TcxSchedulerTimeBuilder.ValidateMidnightForward(
  var ADateTime: TDateTime);
const
  MSecToTime = 1 / MSecsPerDay;
begin
  if Abs(TimeOf(ADateTime - MSecToTime) - WorkFinish) <= MinuteToTime then
    ADateTime := DateOf(ADateTime - MSecToTime) + WorkFinish
end;

function TcxSchedulerTimeBuilder.RoundTime(const ADateTime: TDateTime): TDateTime;
begin
  Result := DateTimeHelper.RoundTime(ADateTime);
end;

function TcxSchedulerTimeBuilder.ValidateStartTime(
  const ADateTime: TDateTime): TDateTime;
begin
  Result := ADateTime;
  if CheckTime then
  begin
    if (RoundTime(TimeOf(Result)) > WorkFinish) then
      Result := Trunc(Result) + WorkFinish
    else
      if (RoundTime(TimeOf(Result)) < WorkStart) then
        Result := Trunc(Result) + WorkStart
  end;
  ValidateVisibleStart(Result);
end;

function TcxSchedulerTimeBuilder.ValidateTime(
  var ADateTime: TDateTime; AGoForward: Boolean; AInc: Integer = 1): Boolean;
var
  ARoundedDateTime: TDateTime;
  AMinorUnitsPerDay: Integer;
begin
  ARoundedDateTime := RoundTime(TimeOf(ADateTime));
  Result := CheckTime and ((ARoundedDateTime > WorkFinish) or
    (ARoundedDateTime < WorkStart));
  if Result then
  begin
    if (AInc = 0) and AGoForward and (ARoundedDateTime > WorkFinish) then
      AInc := 1;
    if AGoForward then
      ADateTime := RoundTime(Trunc(ADateTime) + AInc + WorkStart)
    else
    begin
      if CheckMidnight then
      begin
        AMinorUnitsPerDay := 24 * 60 div TimeStep;
        ADateTime := RoundTime(Trunc(ADateTime) - AInc +
          Trunc(WorkFinish * AMinorUnitsPerDay) / AMinorUnitsPerDay)
      end
      else
        ADateTime := RoundTime(Trunc(ADateTime) - AInc + WorkFinish);
    end;
  end;
end;

procedure TcxSchedulerTimeBuilder.ValidateUnits(
  var AMajorUnit, AMinorUnit: TcxSchedulerTimeGridScaleUnit);
var
  AUnit: TcxSchedulerTimeGridScaleUnit;
  AValidUnits: TcxSchedulerTimeGridScaleUnits;
begin
  if AMajorUnit = suHour then
    AMajorUnit := suDay;
  AValidUnits := ValidMinorUnits[AMajorUnit];
  if not (AMinorUnit in AValidUnits) then
  begin
    for AUnit := suHour to suYear do
      if AUnit in AValidUnits then
      begin
        AMinorUnit := AUnit;
        Break;
      end;
  end;
end;

procedure TcxSchedulerTimeBuilder.ValidateVisibleStart(
  var ADateTime: TDateTime);
begin
  case MinorUnit of
    suHour:
    begin
      ADateTime := Trunc(ADateTime) + (Round(TimeOf(ADateTime) /
        MinuteToTime) div TimeScale * TimeScale) * MinuteToTime;
    end;
    suDay:
      ADateTime := Trunc(ADateTime);
    suWeek:
    begin
      ADateTime := Trunc(ADateTime);
      while Byte(DayOfWeek(ADateTime)) <> 1 do ADateTime := ADateTime - 1;
    end;
    suMonth:
      ADateTime := StartOfTheMonth(ADateTime);
    suQuarter:
    begin
      ADateTime := StartOfTheMonth(ADateTime);
      while (MonthOf(ADateTime) - 1) mod 3 <> 0 do
        ADateTime := SysUtils.IncMonth(ADateTime, -1);
    end;
    suYear:
      ADateTime := StartOfTheYear(ADateTime);
  end;
  ADateTime := RoundTime(ADateTime);
end;

{ TcxSchedulerTimeGridResourceScroll }

destructor TcxSchedulerTimeGridResourceScroll.Destroy;
begin
  FScrollBar.Free;
  inherited Destroy;
end;

procedure TcxSchedulerTimeGridResourceScroll.CreateScrollBar(
  AResourceBounds: TRect; ATimeGridView: TcxSchedulerTimeGridView;
  AResourceIndex, ARange, APosition: Integer);
var
  AHeight: Integer;
begin
  if FScrollBar = nil then
  begin
    FScrollBar := TcxSchedulerTimeGridScrollBar.Create(nil);
    FScrollBar.Kind := sbVertical;
    FScrollBar.LookAndFeel.MasterLookAndFeel := ATimeGridView.GetSchedulerLookAndFeel();
  end;
  FScrollBar.FResourceIndex := AResourceIndex;
  FScrollBar.Min := 0;
  FScrollBar.Max := ARange;
  FScrollBar.Position := APosition;
  FScrollBar.LargeChange := ATimeGridView.ViewInfo.GetVisibleLineCount(AResourceIndex);
  AHeight := AResourceBounds.Bottom - AResourceBounds.Top - 1;
  FScrollBar.SetBounds(AResourceBounds.Right - GetScrollBarSize.cx + 1,
    AResourceBounds.Top + 2, GetScrollBarSize.cx, AHeight);
  FScrollBar.Visible := AHeight > 0;
  FScrollBar.OnScroll := ATimeGridView.ViewInfo.DoResourceVerticalScroll;
  FScrollBar.Parent := ATimeGridView.Scheduler;
end;

procedure TcxSchedulerTimeGridResourceScroll.ClearMoreEventButtons;
var
  I, ALength: Integer;
begin
  ALength := Length(FMoreEventButtons);
  for I := 0 to ALength - 1 do
    FMoreEventButtons[I] := nil;
end;

procedure TcxSchedulerTimeGridResourceScroll.SetEventMaxLine(AValue: Integer);
begin
  FEventMaxLine := Max(FEventMaxLine, AValue);
end;

procedure TcxSchedulerTimeGridResourceScroll.Store(AClear: Boolean);
begin
  FData := FShift;
  if AClear then
    FShift := 0;
end;

procedure TcxSchedulerTimeGridResourceScroll.Restore;
begin
  FShift := FData;  
end;

end.
