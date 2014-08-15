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

unit cxSchedulerCustomResourceView;

{$I cxVer.inc}

interface

uses
  Windows, Graphics, SysUtils, StdCtrls, Classes, Forms, Controls, cxClasses, cxGraphics, 
  {$IFDEF DELPHI6} DateUtils, {$ENDIF} cxGeometry, Math, cxStyles, cxEdit, cxContainer,
  cxSchedulerStorage, cxSchedulerUtils, cxSchedulerCustomControls, cxLookAndFeelPainters,
  {$IFDEF DELPHI6} Variants, {$ENDIF} cxDateUtils, ImgList, cxEditUtils;

const
  // default values
  cxTimeLineWidth: Integer = 7;

  cxHitDelta: Integer = 4;

  // hittest constants
  htcButton         = $3;
  htcContainer      = $4;
  htcTimeRuler      = $5;
  htcTimeZoneLabel =  $6;
  htcContent        = $7;
  htcDayHeader      = $8;
  htcGroupSeparator = $9;
  htcResourceHeader = $10;

type
  TcxSchedulerCustomViewInfoItem = class;
  TcxSchedulerCustomResourceViewViewInfo = class;
  TcxSchedulerCustomResourceViewHitTest = class;
  TcxSchedulerBackgroundCellViewInfo = class;
  TcxSchedulerContentCellViewInfo = class;
  TcxSchedulerDayHeaderCellViewInfo = class;
  TcxSchedulerEventCellViewInfo = class;
  TcxSchedulerGroupSeparatorCellViewInfo = class;
  TcxSchedulerHeaderCellViewInfo = class;
  TcxSchedulerMoreEventsButtonViewInfo = class;
  TcxSchedulerResourceViewInfo = class;
  TcxCustomResourceViewAdapter = class;

  // custom draw event types definition

  TcxSchedulerCustomDrawBackgroundEvent = procedure(Sender: TObject; ACanvas: TcxCanvas;
    AViewInfo: TcxSchedulerBackgroundCellViewInfo; var ADone: Boolean) of object;

  TcxSchedulerCustomDrawButtonEvent = procedure(Sender: TObject; ACanvas: TcxCanvas;
    AViewInfo: TcxSchedulerMoreEventsButtonViewInfo; var ADone: Boolean) of object;

  TcxSchedulerCustomDrawDayHeaderEvent = procedure(Sender: TObject; ACanvas: TcxCanvas;
    AViewInfo: TcxSchedulerDayHeaderCellViewInfo; var ADone: Boolean) of object;

  TcxSchedulerCustomDrawResourceHeaderEvent = procedure(Sender: TObject; ACanvas: TcxCanvas;
    AViewInfo: TcxSchedulerHeaderCellViewInfo; var ADone: Boolean) of object;

  TcxSchedulerCustomDrawContentEvent = procedure(Sender: TObject; ACanvas: TcxCanvas;
    AViewInfo: TcxSchedulerContentCellViewInfo; var ADone: Boolean) of object;

  TcxSchedulerCustomDrawEventEvent = procedure(Sender: TObject; ACanvas: TcxCanvas;
    AViewInfo: TcxSchedulerEventCellViewInfo; var ADone: Boolean) of object;

  TcxSchedulerCustomDrawGroupSeparatorEvent = procedure(Sender: TObject; ACanvas: TcxCanvas;
    AViewInfo: TcxSchedulerGroupSeparatorCellViewInfo; var ADone: Boolean) of object;

  { IcxSchedulerCommonViewItemsPainter }

  IcxSchedulerCommonViewItemsPainter = interface
  ['{0702AB17-C2F1-479D-B809-C3B972F8A334}']
    procedure DoCustomDrawBackground(
      AViewInfo: TcxSchedulerBackgroundCellViewInfo; var ADone: Boolean);
    procedure DoCustomDrawButton(
      AViewInfo: TcxSchedulerMoreEventsButtonViewInfo; var ADone: Boolean);
    procedure DoCustomDrawContent(
      AViewInfo: TcxSchedulerContentCellViewInfo; var ADone: Boolean);
    procedure DoCustomDrawDayHeader(
      AViewInfo: TcxSchedulerDayHeaderCellViewInfo; var ADone: Boolean);
    procedure DoCustomDrawEvent(
      AViewInfo: TcxSchedulerEventCellViewInfo; var ADone: Boolean);
    procedure DoCustomDrawGroupSeparator(
      AViewInfo: TcxSchedulerGroupSeparatorCellViewInfo; var ADone: Boolean);
    procedure DoCustomDrawResourceHeader(
      AViewInfo: TcxSchedulerHeaderCellViewInfo; var ADone: Boolean);
  end;

  { TcxSchedulerViewInfoCellList }

  TcxSchedulerCustomDrawItemProc = procedure(
    AItem: TcxSchedulerCustomViewInfoItem; var ADone: Boolean) of object;

  TcxSchedulerViewInfoCellList = class(TList)
  private
    function GetItem(AIndex: Integer): TcxSchedulerCustomViewInfoItem;
  public
    function CalculateHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest): Boolean;
    procedure Clear; override;
    procedure Draw(ACanvas: TcxCanvas; ADrawItemProc: TcxSchedulerCustomDrawItemProc);
    
    property Items[Index: Integer]: TcxSchedulerCustomViewInfoItem read GetItem; default;
  end;

  { TcxSchedulerCustomViewInfoItem }

  TcxSchedulerCustomViewInfoItem = class
  private
    function GetBitmap: TBitmap;
    function GetColor: TColor;
    function GetDateTimeHelper: TcxSchedulerDateTimeHelperClass;
    function GetPainterHelper: TcxSchedulerPainterHelperClass;
    function GetTextColor: TColor;
    procedure SetBitmap(AValue: TBitmap);
    procedure SetColor(AValue: TColor);
    procedure SetTextColor(AValue: TColor);
  protected
    FBackgroundDrawing: Boolean;
    FBounds: TRect;
    FBorders: TcxBorders;
    FCanvas: TcxCanvas;
    FClipRect: TRect;
    FClipRgn: TcxRegion;
    FClipRef: Integer; 
    FDateTime: TDateTime;
    FDisplayText: string;
    FHasClipping: Boolean;
    FPainter: TcxCustomLookAndFeelPainterClass;
    FSavedClipRgn: TcxRegion;
    FTransparent: Boolean;
    FViewParams: TcxViewParams;
    FVisible: Boolean;
    FDayBorderColor: TColor;
    procedure ClippingCreate(AHasClipping: Boolean); virtual;
    procedure ClippingRestore;
    procedure DoDraw; virtual; abstract;
    function DrawBackground(ACanvas: TcxCanvas; const ABounds: TRect): Boolean; virtual;
    procedure DrawFrame(const ARect: TRect; ABorders: TcxBorders = [];
      ABorderColor: TColor = clDefault; ALineWidth: Integer = 1);
    procedure DrawRect(const ARect: TRect; ABorders: TcxBorders = [];
      ABorderColor: TColor = clDefault; ALineWidth: Integer = 1);
    procedure DrawText(const ARect: TRect; const AText: string;
      AFlags: Integer; AFont: TFont = nil; AColor: TColor = clDefault);
    function GetFont: TFont; virtual;
    function GetHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest; var ABreak: Boolean): Boolean; virtual;
    procedure InitHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest); virtual;
    procedure RotateBitmap(ABitmap: TBitmap; ARotationAngle: TcxRotationAngle; AFlipHorizontally: Boolean = False);
    // custom draw support
    procedure AfterCustomDraw(ACanvas: TcxCanvas); virtual;
    procedure BeforeCustomDraw(ACanvas: TcxCanvas); virtual;

    // class item settings
    property DateTimeHelper: TcxSchedulerDateTimeHelperClass read GetDateTimeHelper;
    property DisplayText: string read FDisplayText write FDisplayText;
    property PainterHelper: TcxSchedulerPainterHelperClass read GetPainterHelper;
  public
    constructor Create(APainter: TcxCustomLookAndFeelPainterClass;
      const ABounds, AVisibleRect: TRect; const AViewParams: TcxViewParams); virtual;
    destructor Destroy; override;
    procedure Draw(ACanvas: TcxCanvas); virtual;

    property Borders: TcxBorders read FBorders write FBorders;
    property Bounds: TRect read FBounds;
    property Bitmap: TBitmap read GetBitmap write SetBitmap;
    property Canvas: TcxCanvas read FCanvas;
    property ClipRect: TRect read FClipRect;
    property Color: TColor read GetColor write SetColor;
    property Font: TFont read GetFont;
    property Painter: TcxCustomLookAndFeelPainterClass read FPainter;
    property TextColor: TColor read GetTextColor write SetTextColor;
    property Transparent: Boolean read FTransparent write FTransparent;
    property ViewParams: TcxViewParams read FViewParams;
    property Visible: Boolean read FVisible;
  end;

  { TcxSchedulerBackgroundCellViewInfo }

  TcxSchedulerBackgroundCellViewInfo = class(TcxSchedulerCustomViewInfoItem)
  protected
    procedure DoDraw; override;
  end;

//  TcxSchedulerContentCellViewInfo = class;

  TcxSchedulerCustomViewInfoItemClass = class of TcxSchedulerCustomViewInfoItem;

  { TcxSchedulerCustomResourceViewInfoItem }

  TcxSchedulerCustomResourceViewInfoItem = class(TcxSchedulerCustomViewInfoItem)
  private
    FIsResourceAssigned: Boolean;
    FTimeFinish: TDateTime;
    FResource: TcxSchedulerResourceViewInfo;
  protected
    procedure InitHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest); override;

    property DateTime: TDateTime read FDateTime write FDateTime;
    property IsResourceAssigned: Boolean read FIsResourceAssigned;
    property Resource: TcxSchedulerResourceViewInfo read FResource write FResource;
    property TimeFinish: TDateTime read FTimeFinish;
  end;

  { TcxSchedulerHeaderCellViewInfo }

  TcxSchedulerHeaderCellViewInfo = class(TcxSchedulerCustomResourceViewInfoItem)
  protected
    FAlignHorz: TAlignment;
    FAlignVert: TcxAlignmentVert;
    FButtonState: TcxButtonState;
    FCachedBitmap: TBitmap;
    FDrawRotatedBackground: Boolean;
    FIsResourceHeader: Boolean;
    FMultiLine: Boolean;
    FNeighbors: TcxNeighbors;
    FRotateBitmap: TBitmap;
    FRotateHeader: Boolean;
    FRotateText: Boolean;
    FSelected: Boolean;                            
    FSelectionColor: TColor;
    FSelectionTextColor: TColor;
    FSelectionRect: TRect;
    FShowEndEllipsis: Boolean;
    FTextRect: TRect;
    procedure CheckNeighbor(APrevCell: TcxSchedulerHeaderCellViewInfo);
    function CheckSelection: Boolean; virtual;
    procedure DoDraw; override;
    procedure DrawHorizontalHeader; virtual;
    function DrawRotateBackground(ACanvas: TcxCanvas; const ABounds: TRect): Boolean; virtual;
    procedure DrawVerticalHeader; virtual;
    function GetTextOutFlags: Integer;
    procedure InitHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest); override;
    procedure TextOut(ACanvas: TcxCanvas; const AText: string; R: TRect);
    procedure ValidateSelection;
  public
    constructor Create(APainter: TcxCustomLookAndFeelPainterClass;
      const ABounds, AVisibleRect: TRect; const AViewParams: TcxViewParams); override;
    destructor Destroy; override;
    procedure Calculate(const AText: string); virtual;
    procedure Draw(ACanvas: TcxCanvas); override;

    property AlignHorz: TAlignment read FAlignHorz write FAlignHorz;
    property AlignVert: TcxAlignmentVert read FAlignVert write FAlignVert;
    property DateTime: TDateTime read FDateTime write FDateTime;
    property IsResourceHeader: Boolean read FIsResourceHeader; 
    property MultiLine: Boolean read FMultiLine write FMultiLine;
    property Neighbors: TcxNeighbors read FNeighbors write FNeighbors;
    property RotateHeader: Boolean read FRotateHeader write FRotateHeader;
    property RotateText: Boolean read FRotateText write FRotateText;
    property Selected: Boolean read FSelected write FSelected;
    property SelectionColor: TColor read FSelectionColor write FSelectionColor;
    property SelectionTextColor: TColor read FSelectionTextColor write FSelectionTextColor;
    property ShowEndEllipsis: Boolean read FShowEndEllipsis write FShowEndEllipsis;
    property TextRect: TRect read FTextRect;
    property Bounds;
    property DisplayText;
    property Painter;
    property Resource;
  end;

  { TcxSchedulerDayHeaderCellViewInfo }

  TcxSchedulerDayHeaderCellViewInfo = class(TcxSchedulerHeaderCellViewInfo)
  private
    FCompressed: Boolean;
  protected
    function CheckSelection: Boolean; override;
    procedure DoDraw; override;
    function DrawBackground(ACanvas: TcxCanvas; const ABounds: TRect): Boolean; override;
  public
    function ConvertDateToDisplayText(AType: Integer = 0): Integer; virtual;
    
    property Compressed: Boolean read FCompressed write FCompressed;
  end;

  { TcxSchedulerWeekDayHeaderCellViewInfo }

  TcxSchedulerWeekDayHeaderCellViewInfo = class(TcxSchedulerDayHeaderCellViewInfo)
  protected
    function GetDayText(AType: Integer): string;
    procedure InitHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest); override;
  public
    function ConvertDateToDisplayText(AType: Integer = 0): Integer; override;
  end;

  { TcxSchedulerContainerCellViewInfo }

  TcxSchedulerContainerCellViewInfo = class(TcxSchedulerCustomResourceViewInfoItem)
  protected
    FLineCount: Integer;
    FSelected: Boolean;
    procedure DoDraw; override;
    procedure InitHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest); override;
  public
    property LineCount: Integer read FLineCount write FLineCount;
    property DateTime;
    property Resource;
    property Selected: Boolean read FSelected write FSelected;
  end;

  { TcxSchedulerTimeRulerCellViewInfo }

  TcxSchedulerTimeRulerCellViewInfo = class(TcxSchedulerCustomViewInfoItem)
  private
    function GetBoundsRect(AType: Boolean): TRect;
    function GetDisplayText(AType: Boolean): string;
    function GetHasAdditionalTimeZone: Boolean;
  protected
    FAdditionalTimeZone: Integer;
    FBounds: array[Boolean] of TRect;
    FDisplayTexts: array[Boolean] of string;
    FHour: Integer;
    FLargeFont: TFont;
    FLineCount: Integer;
    FTimeZone: Integer;
    procedure CalculateDisplayInfo;
    procedure DoDraw; override;
    procedure DrawTimeZone(const ABounds: TRect; const AText: string; AIsCurrent: Boolean); virtual;
    procedure DrawTimeZoneLabel(const ABounds: TRect; const AText: string; ABorders: TcxBorders); virtual;
    procedure DrawCurrentTime(const AStart: TDateTime; ABounds: TRect);
    function GetAdditionalTime: TDateTime;
    function GetTimeDisplayText(const ATime: TDateTime): string;
    procedure InitHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest); override;
    //
    procedure AfterCustomDraw(ACanvas: TcxCanvas); override;
    procedure BeforeCustomDraw(ACanvas: TcxCanvas); override;
  public
    class function CalculateWidth(ATimeZoneCount, ALineCount: Integer; AFont1, AFont2: TFont): Integer;
    procedure Calculate(const ALabel1, ALabel2: string; ATimeZone, AAdditionalTimeZone: Integer); overload; virtual;
    procedure Calculate(AHour, ALineCount: Integer; ATimeZone, AAdditionalTimeZone: Integer; ALargeFont: TFont); overload; virtual;
    procedure SetBottom(AValue: Integer);

    property AdditionalTimeZone: Integer read FAdditionalTimeZone;
    property Bounds[ACurrentTimeZone: Boolean]: TRect read GetBoundsRect;
    property DisplayTexts[ACurrentTimeZone: Boolean]: string read GetDisplayText;
    property HasAdditionalTimeZone: Boolean read GetHasAdditionalTimeZone;
    property Hour: Integer read FHour;
    property LargeFont: TFont read FLargeFont;
    property LineCount: Integer read FLineCount;
    property TimeZone: Integer read FTimeZone;
  end;

  { TcxSchedulerContentCellViewInfo }

  TcxSchedulerContentCellViewInfo = class(TcxSchedulerCustomResourceViewInfoItem)
  protected
    FBorderColor: TColor;
    FDontPrint: Boolean;
    FLineCount: Integer;
    FShowTimeLine: Boolean;
    FTimeEvent: TcxSchedulerEventCellViewInfo;
    FTimeLineBorders: TcxBorders;
    FTimeLineParams: TcxViewParams;
    procedure DoDraw; override;
    procedure InitHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest); override;
  public
    constructor Create(APainter: TcxCustomLookAndFeelPainterClass;
      const ABounds, AVisibleRect: TRect; const AViewParams: TcxViewParams); override;
    procedure SetTime(const ATimeStart, ATimeFinish: TDateTime);
    
    property BorderColor: TColor read FBorderColor write FBorderColor;
    property DontPrint: Boolean read FDontPrint write FDontPrint;
    property LineCount: Integer read FLineCount write FLineCount;
    property ShowTimeLine: Boolean read FShowTimeLine write FShowTimeLine;
    property TimeEvent: TcxSchedulerEventCellViewInfo read FTimeEvent write FTimeEvent;
    property TimeLineBorders: TcxBorders read FTimeLineBorders write FTimeLineBorders;
    property TimeLineParams: TcxViewParams read FTimeLineParams write FTimeLineParams;
    property TimeStart: TDateTime read FDateTime;
    property TimeFinish;
    property Resource;
  end;

  TcxSchedulerContentCellViewInfoClass = class of TcxSchedulerContentCellViewInfo;

 { TcxSchedulerBackgroundSlotCellViewInfo }

  TcxSchedulerBackgroundSlotCellViewInfo = class(TcxSchedulerContentCellViewInfo)
  protected
    procedure DoDraw; override;
  public
    property DisplayText;
  end;

  { TcxSchedulerMonthDayContentCellViewInfo }

  TcxSchedulerMonthDayContentCellViewInfo = class(TcxSchedulerContentCellViewInfo)
  private
    FSelected: Boolean;
    FSelectionColor: TColor;
    FSelectionTextColor: TColor;
    FTextHeight: Integer;
    function GetIsToday: Boolean;
  protected
    FTextRect: TRect;
    procedure DoDraw; override;
    function GetLongDisplayText: string; virtual;
    property IsToday: Boolean read GetIsToday;
  public
    procedure SetContentState(AsDayOfMonth: Boolean; ASelected: Boolean;
      ATextHeight: Integer; const ASelectionParams: TcxViewParams);

    property DisplayText;
    property Selected: Boolean read FSelected;
    property SelectionColor: TColor read FSelectionColor write FSelectionColor;
    property SelectionTextColor: TColor read FSelectionTextColor write FSelectionTextColor;
    property TextHeight: Integer read FTextHeight write FTextHeight;
  end;

  { TcxSchedulerEventViewData }

  TcxSchedulerEventViewData = class
  public
    Bounds: TRect;
    Bitmap: TBitmap;
    Caption: string;
    ContentFinish: TDateTime;
    ContentStart: TDateTime;
    DrawShadows: Boolean;
    EditProperties: TcxCustomEditProperties;
    EditStyle: TcxCustomEditStyle;
    Event: TcxSchedulerControlEvent;
    ShowBell: Boolean;
    LineHeight: Integer; 
    LineIndex: Integer;
    Painter: TcxCustomLookAndFeelPainterClass;
    Resource: TcxSchedulerResourceViewInfo;
    ShowFinishTime: Boolean;
    ShowStartTime: Boolean;
    ShowTimeAsClock: Boolean;
    ShowTimeLine: Boolean;
    StartLine: Integer;
    TimeLineParams: TcxViewParams;
    ViewParams: TcxViewParams;
    VisibleRect: TRect;
  end;

  { TcxSchedulerEventCellViewInfo }

  TcxSchedulerEventCellViewInfo = class(TcxSchedulerCustomViewInfoItem)
  private
    function GetCaption: string;
    function GetContentFinish: TDateTime;
    function GetContentStart: TDateTime;
    function GetEvent: TcxSchedulerControlEvent;
    function GetIsHeaderEvent: Boolean;
    function GetMessage: string;
    function GetResourceInfo: TcxSchedulerResourceViewInfo;
    function GetResourceItem: TcxSchedulerStorageResourceItem;
    function GetSelected: Boolean;
    function GetShowingState(AIndex: Integer): Boolean;
    function SetItemRect(AShowItem: Boolean; const ABounds: TRect; var APos: Integer): TRect;
  protected
    FBellRect: TRect;
    FContentRect: TRect;
    FEditViewInfo: TcxCustomEditViewInfo;
    FFinishRect: TRect;
    FFinishText: string;
    FHidden: Boolean;
    FMessageRect: TRect;
    FRecurrenceRect: TRect;
    FSeparatorColor: TColor;
    FShowMessage: Boolean;
    FShowRecurrence: Boolean;
    FStartRect: TRect;
    FStartText: string;
    FIconRect: TRect;
    FIconW: Integer;
    FEventTimeRect: TRect;
    FTimeLineRect: TRect;
    FIsDetailInfo: Boolean;
    ViewData: TcxSchedulerEventViewData;
    procedure AssignEditStyle(AEditStyle: TcxCustomEditStyle);
    procedure BeforeCustomDraw(ACanvas: TcxCanvas); override;
    procedure Calculate; virtual;
    procedure CalculateEditViewInfo;
    procedure CalculateItemsLayout;
    procedure CalculateDayViewEventLayout;
    procedure CalculateHeaderEventLayout;
    procedure CalculateWeekViewEventLayout;
    procedure CalculateMetrics;
    procedure CalculateTimeLineParams;
    procedure CalculateVisibility;
    function CanShowHint: Boolean;
    function CaptionWidth: Integer;
    procedure DoDraw; override;
    procedure DrawSelection;
    procedure DrawShadow; virtual;
    procedure DrawState; overload;
    procedure DrawTime;
    function GetHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest; var ABreak: Boolean): Boolean; override;
    function GetEditingRect: TRect; virtual;
    procedure InitHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest); override;
    function TruncTime(const ATime: TDateTime): TDateTime;

    property IsHeaderEvent: Boolean read GetIsHeaderEvent;
  public
    constructor Create(AViewData: TcxSchedulerEventViewData); reintroduce; overload;
    destructor Destroy; override;
    procedure Draw(ACanvas: TcxCanvas; ABitmap: TBitmap); reintroduce; overload;
    procedure DrawState(ACanvas: TcxCanvas; const ARect: TRect; ABorders: TcxBorders; ABorderColor: TColor); overload;

    property Caption: string read GetCaption;
    property ClipRect: TRect read FClipRect;
    property ClipRgn: TcxRegion read FClipRgn write FClipRgn;
    property ContentFinish: TDateTime read GetContentFinish;
    property ContentRect: TRect read FContentRect;
    property ContentStart: TDateTime read GetContentStart;
    property EditingRect: TRect read GetEditingRect;
    property EditViewInfo: TcxCustomEditViewInfo read FEditViewInfo;
    property Event: TcxSchedulerControlEvent read GetEvent;
    property EventTimeRect: TRect read FEventTimeRect;
    property EventViewData: TcxSchedulerEventViewData read ViewData;
    property FinishRect: TRect read FFinishRect;
    property FinishText: string read FFinishText;
    property Hidden: Boolean read FHidden write FHidden;
    property IsDetailInfo: Boolean read FIsDetailInfo;
    property Message: string read GetMessage;
    property MessageRect: TRect read FMessageRect;
    property ResourceInfo: TcxSchedulerResourceViewInfo read GetResourceInfo;
    property ResourceItem: TcxSchedulerStorageResourceItem read GetResourceItem;
    property Selected: Boolean read GetSelected;
    property SeparatorColor: TColor read FSeparatorColor write FSeparatorColor;
    property ShowBell: Boolean index 0 read GetShowingState;
    property ShowFinishTime: Boolean index 1 read GetShowingState;
    property ShowMessage: Boolean read FShowMessage;
    property ShowRecurrence: Boolean read FShowRecurrence;
    property ShowStartTime: Boolean index 2 read GetShowingState;
    property ShowTimeAsClock: Boolean index 3 read GetShowingState;
    property ShowTimeLine: Boolean index 4 read GetShowingState;
    property StartRect: TRect read FStartRect;
    property StartText: string read FStartText;
    property TimeLineRect: TRect read FTimeLineRect;
    property Visible: Boolean read FVisible;
  end;

  { TcxSchedulerMoreEventsButtonViewInfo }

  TcxSchedulerButtonClick = procedure(Sender: TcxSchedulerMoreEventsButtonViewInfo) of object; 

  TcxSchedulerMoreEventsButtonViewInfo = class(TcxSchedulerCustomResourceViewInfoItem)
  protected
    FIsDown: Boolean;
    FOnClick: TcxSchedulerButtonClick;
    procedure DoDraw; override;
    procedure InitHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest); override;
    property OnClick: TcxSchedulerButtonClick read FOnClick write FOnClick;
  public
    procedure Click; virtual;

    property IsDown: Boolean read FIsDown;
    property DateTime;
    property Resource;
  end;

  { TcxSchedulerGroupSeparatorCellViewInfo }

  TcxSchedulerGroupSeparatorCellViewInfo = class(TcxSchedulerCustomViewInfoItem)
  private
    FDrawRotatedBackground: Boolean;
    FRotated: Boolean;
    function DrawRotateBackground(ACanvas: TcxCanvas; const ABounds: TRect): Boolean;
  protected
    FRotateBitmap: TBitmap;
    procedure DoDraw; override;
    procedure InitHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest); override;
  public
    destructor Destroy; override;
    property Rotated: Boolean read FRotated write FRotated;
  end;

  { TcxSchedulerResourceViewInfo }

  TcxSchedulerResourceViewInfo = class
  protected
    FCaption: string;
    FColor: TColor;
    FResourceID: Variant;
    FResourceItem: TcxSchedulerStorageResourceItem;
  public
    constructor Create(AResource: TcxSchedulerStorageResourceItem); virtual;
    
    property Caption: string read FCaption;
    property Color: TColor read FColor;
    property ResourceID: Variant read FResourceID;
    property ResourceItem: TcxSchedulerStorageResourceItem read FResourceItem;
  end;

  { TcxSchedulerCustomResourceView }

  TcxSchedulerCustomResourceView = class(TcxSchedulerCustomView)
  private
    FAdapter: TcxCustomResourceViewAdapter;
    FGroupingKind: TcxSchedulerGroupingKind;
    FShowEndTime: Boolean;
    FShowTimeAsClock: Boolean;
    FOnCustomDrawBackground: TcxSchedulerCustomDrawBackgroundEvent;
    FOnCustomDrawButton: TcxSchedulerCustomDrawButtonEvent;
    FOnCustomDrawContent: TcxSchedulerCustomDrawContentEvent;
    FOnCustomDrawDayHeader: TcxSchedulerCustomDrawDayHeaderEvent;
    FOnCustomDrawEvent: TcxSchedulerCustomDrawEventEvent;
    FOnCustomDrawGroupSeparator: TcxSchedulerCustomDrawGroupSeparatorEvent;
    FOnCustomDrawResourceHeader: TcxSchedulerCustomDrawResourceHeaderEvent;
    function GetViewInfo: TcxSchedulerCustomResourceViewViewInfo;
    procedure SetGroupingKind(AValue: TcxSchedulerGroupingKind);
    procedure SetShowEndTime(const AValue: Boolean);
    procedure SetShowTimeAsClock(const AValue: Boolean);
  protected
    procedure CalculateViewInfo; override;
    procedure CheckGroupingKind(AStyle: TcxSchedulerGroupingKind;
      var ActuallyStyle: TcxSchedulerGroupingKind); virtual;
    function CreateController: TcxSchedulerSubControlController; override;
    function CreateHitTest: TcxSchedulerSubControlHitTest; override;
    function CreateViewAdapter: TcxCustomResourceViewAdapter; virtual;
    procedure CreateSubClasses; override;
    procedure DestroySubClasses; override;
    procedure DoCustomDrawBackground(
      AViewInfo: TcxSchedulerBackgroundCellViewInfo; var ADone: Boolean); virtual;
    procedure DoCustomDrawButton(
      AViewInfo: TcxSchedulerMoreEventsButtonViewInfo; var ADone: Boolean); virtual;
    procedure DoCustomDrawContent(
      AViewInfo: TcxSchedulerContentCellViewInfo; var ADone: Boolean); virtual;
    procedure DoCustomDrawDayHeader(
      AViewInfo: TcxSchedulerDayHeaderCellViewInfo; var ADone: Boolean); virtual;
    procedure DoCustomDrawEvent(
      AViewInfo: TcxSchedulerEventCellViewInfo; var ADone: Boolean); virtual;
    procedure DoCustomDrawGroupSeparator(
      AViewInfo: TcxSchedulerGroupSeparatorCellViewInfo; var ADone: Boolean); virtual;
    procedure DoCustomDrawResourceHeader(
      AViewInfo: TcxSchedulerHeaderCellViewInfo; var ADone: Boolean); virtual;
    procedure DoLayoutChanged; override;
    function DoShowPopupMenu(X, Y: Integer): Boolean; override;
    function FindEventViewInfo(AEvent: TcxSchedulerEvent; const ADate: TDateTime;
      AResource: TcxSchedulerStorageResourceItem; var AViewInfo: TcxSchedulerEventCellViewInfo): Boolean;
    function GetCommonViewItemsPainter: IcxSchedulerCommonViewItemsPainter; virtual;
    function GetCompressWeekEnd: Boolean; virtual;
    function GetEditRectForEvent(AEvent: TcxSchedulerControlEvent; const ADate: TDateTime;
      AResource: TcxSchedulerStorageResourceItem): TRect; override;
    function GetEventVisibility(AEvent: TcxSchedulerControlEvent): Boolean; override;
    function GetGroupingKind: TcxSchedulerGroupingKind; override;
    procedure InitScrollBarsParameters; override;
    function IsShowResources: Boolean; override;
    procedure Scroll(AScrollBarKind: TScrollBarKind;
      AScrollCode: TScrollCode; var AScrollPos: Integer); override;

    property Adapter: TcxCustomResourceViewAdapter read FAdapter write FAdapter;
    property ShowEndTime: Boolean read FShowEndTime write SetShowEndTime default True;
    property ShowTimeAsClock: Boolean read FShowTimeAsClock write SetShowTimeAsClock default False;
    property ViewInfo: TcxSchedulerCustomResourceViewViewInfo read GetViewInfo;

    property OnCustomDrawBackground: TcxSchedulerCustomDrawBackgroundEvent read FOnCustomDrawBackground write FOnCustomDrawBackground;
    property OnCustomDrawButton: TcxSchedulerCustomDrawButtonEvent read FOnCustomDrawButton write FOnCustomDrawButton;
    property OnCustomDrawContent: TcxSchedulerCustomDrawContentEvent read FOnCustomDrawContent write FOnCustomDrawContent;
    property OnCustomDrawDayHeader: TcxSchedulerCustomDrawDayHeaderEvent read FOnCustomDrawDayHeader write FOnCustomDrawDayHeader;
    property OnCustomDrawEvent: TcxSchedulerCustomDrawEventEvent read FOnCustomDrawEvent write FOnCustomDrawEvent;
    property OnCustomDrawGroupSeparator: TcxSchedulerCustomDrawGroupSeparatorEvent read FOnCustomDrawGroupSeparator write FOnCustomDrawGroupSeparator;
    property OnCustomDrawResourceHeader: TcxSchedulerCustomDrawResourceHeaderEvent read FOnCustomDrawResourceHeader write FOnCustomDrawResourceHeader;
  public
    constructor Create(AOwner: TcxCustomScheduler); override;
    procedure Assign(Source: TPersistent); override;

    property GroupingKind: TcxSchedulerGroupingKind read FGroupingKind write SetGroupingKind default gkDefault;
  end;

  { TcxCustomResourceViewAdapter }

  TcxCustomResourceViewAdapter = class
  private
    FView: TcxSchedulerCustomResourceView;

    function GetCells: TcxObjectList;
    function GetContentLineHeight: Integer;
    function GetPainterHelper: TcxSchedulerPainterHelperClass;
    function GetResources: TcxSchedulerStorageResourceItems;
    function GetViewInfo: TcxSchedulerCustomResourceViewViewInfo;

  protected
    function CanCalculate: Boolean; virtual;
    function GetCompressWeekends: Boolean; virtual;
    function GetDontPrintWeekEnds: Boolean; virtual;
    function GetHideSelection: Boolean; virtual;
    function GetPageBounds: TRect; virtual;
    function GetPagesPerWeek: Byte; virtual;
    function GetPrimaryPage: Boolean; virtual;
    function GetPrintExactlyOneMonth: Boolean; virtual;
    function GetPrintRange(Index: Integer): TDateTime; virtual;
    function GetStylesAdapter: IcxSchedulerStylesAdapter; virtual;
    function GetView: TcxSchedulerCustomResourceView; virtual;

    procedure AfterCalculatePage; virtual;
    procedure BeforeCalculatePage; virtual;
    procedure DoInitialize(var ASelectedDays: TcxSchedulerDateList;
       var AEvents: TcxSchedulerCachedEventList); virtual;
    function GetPageHeaderText: string; virtual;
    procedure Store; virtual;
    procedure Restore; virtual;

    property PainterHelper: TcxSchedulerPainterHelperClass read GetPainterHelper;
    property Resources: TcxSchedulerStorageResourceItems read GetResources;
    property ViewInfo: TcxSchedulerCustomResourceViewViewInfo read GetViewInfo;

  public
    constructor Create(AView: TcxSchedulerCustomResourceView); virtual;

    procedure Calculate; overload;

    procedure GetPageResources(AResources: TcxObjectList); virtual;
    procedure GetPageDays(APageIndex: Integer; ADays: TcxSchedulerDateList);
    procedure Invalidate; virtual;

    property Cells: TcxObjectList read GetCells;
    property ContentLineHeight: Integer read GetContentLineHeight;
    property DontPrintWeekEnd: Boolean read GetDontPrintWeekEnds;
    property PagesPerWeek: Byte read GetPagesPerWeek;
    property PrintExactlyOneMonth: Boolean read GetPrintExactlyOneMonth;
    property PrintFrom: TDateTime index 0 read GetPrintRange;
    property PrintTo: TDateTime index 1 read GetPrintRange;
    property StylesAdapter: IcxSchedulerStylesAdapter read GetStylesAdapter;
    property View: TcxSchedulerCustomResourceView read GetView;
  end;

  TcxCustomResourceViewAdapterClass = class of TcxCustomResourceViewAdapter; 

  { TcxSchedulerCustomResourceViewViewInfo }

  TcxSchedulerCustomResourceViewViewInfo = class(TcxSchedulerCustomViewViewInfo)
  private
    function GetClones: TcxSchedulerEventList;
    function GetDay(AIndex: Integer): TDateTime;
    function GetDayCount: Integer;
    function GetShowEventsWithoutResource: Boolean;
    function GetGroupByDate: Boolean;
    function GetGroupByResource: Boolean;
    function GetGroupingKind: TcxSchedulerGroupingKind;
    function GetHasSeparator: Boolean;
    function GetHasVisibleBounds: Boolean; 
    function GetHiddenSelection: Boolean;
    function GetResource(AIndex: Integer): TcxSchedulerResourceViewInfo;
    function GetResourceCaption(AIndex: Integer): string;
    function GetResourceCount: Integer;
    function GetPrintRange(Index: Integer): TDateTime;
    function GetSeparatorWidth: Integer;
    function GetView: TcxSchedulerCustomResourceView;
  protected
    FAdapter: TcxCustomResourceViewAdapter;
    FButtons: TcxSchedulerViewInfoCellList;
    FCanSelected: Boolean;
    FCells: TcxObjectList;
    FContentCells: TcxSchedulerViewInfoCellList;
    FContentLineHeight: Integer;
    FDayBorderColor: TColor;
    FDayHeaderCells: TcxSchedulerViewInfoCellList;
    FDayHeaderHeight: Integer;
    FEventCells: TcxSchedulerViewInfoCellList;
    FGroupSeparatorCells: TcxSchedulerViewInfoCellList;
    FGroupSeparatorParams: TcxViewParams;
    FGroupingKind: TcxSchedulerGroupingKind;
    FHasVisibleBounds: Boolean;
    FHeaderContainerCells: TcxSchedulerViewInfoCellList;
    FHideClones: Boolean;
    FHideSelection: Boolean;
    FHideSource: Boolean;
    FResources: TcxObjectList;
    FResourceHeaderCells: TcxSchedulerViewInfoCellList;
    FResourceHeaderHeight: Integer;
    FSelectionParams: TcxViewParams;
    FSelStart: TDateTime;
    FSelFinish: TDateTime;
    FSelResource: TcxSchedulerResourceViewInfo;
    FStylesAdapter: IcxSchedulerStylesAdapter; 
    FTimeLineParams: TcxViewParams;
    // for page splitting
    FPageBounds: TRect;
    FPagesPerWeek: Byte;
    FPrimaryPage: Boolean; 
    FPrintWeekEnds: Boolean;

    function AddBackgroundSlot(const ABounds: TRect; ABorders: TcxBorders;
      const AText: string = ''): TcxSchedulerBackgroundSlotCellViewInfo; virtual;
    function AddButton(ABounds: TRect; const ADateTime: TDateTime;
      AResourceIndex: Integer; AIsDown: Boolean): TcxSchedulerMoreEventsButtonViewInfo; virtual;
    function AddContentCell(const ARect: TRect; const AStart, AFinish: TDateTime;
      AResourceIndex: Integer): TcxSchedulerContentCellViewInfo; virtual;
    function AddDayHeader(const ADate: TDateTime; const ABounds: TRect;
      AResourceIndex: Integer): TcxSchedulerDayHeaderCellViewInfo; overload; virtual;
    function AddDayHeader(const ADate: TDateTime; ATop, ALeft, ARight: Integer;
      AResourceIndex: Integer): TcxSchedulerDayHeaderCellViewInfo; overload;
    function AddEventCell(
      AViewData: TcxSchedulerEventViewData): TcxSchedulerEventCellViewInfo; virtual;
    function AddGroupHorzSeparator(APos: Integer): TcxSchedulerGroupSeparatorCellViewInfo; virtual;
    function AddGroupSeparator(const ABounds: TRect): TcxSchedulerGroupSeparatorCellViewInfo; virtual;
    function AddGroupVertSeparator(APos: Integer): TcxSchedulerGroupSeparatorCellViewInfo; virtual;
    function AddResourceHeader(const AIndex: Integer;
      const ABounds: TRect): TcxSchedulerHeaderCellViewInfo; virtual;
    procedure AfterCalculate; override;
    procedure AssignResourceID(ACell: TcxSchedulerCustomResourceViewInfoItem; AIndex: Integer);
    procedure CalculateMetrics; virtual;
    procedure Clear; override;
    function ContentCellClass: TcxSchedulerContentCellViewInfoClass; virtual;
    procedure CreateCellInstance(AClass: TcxSchedulerCustomViewInfoItemClass;
      const ABounds: TRect; const AViewParams: TcxViewParams; var Instance); overload;
    procedure CreateCellInstance(AClass: TcxSchedulerCustomViewInfoItemClass;
      const ABounds, AVisibleBounds: TRect; const AViewParams: TcxViewParams; var Instance); overload;
    function CreateEventViewData(AEvent: TcxSchedulerControlEvent; const ABounds: TRect;
      const AStart, AFinish: TDateTime; AResource: TcxSchedulerResourceViewInfo): TcxSchedulerEventViewData; virtual;
    procedure DoCalculate; override;
    procedure ExtractResources; virtual;
    function GetBounds: TRect; override;
    function GetContentParams(const ATime: TDateTime;
      AResource: TcxSchedulerResourceViewInfo): TcxViewParams; virtual;
    function GetDayHeaderHeight: Integer; virtual;
    function GetTimeLineParams: TcxViewParams; virtual;
    function GetSelectionParams(const AParams: TcxViewParams): TcxViewParams;
    function GetFontHeight(AStyle: TcxStyle): Integer; overload;
    function GetFontHeight(const AParams: TcxViewParams): Integer; overload;
    function GetPageHeaderText: string; virtual;
    function GetResourceItemByIndex(AIndex: Integer): TcxSchedulerStorageResourceItem;
    function GetResourceViewInfoByItem(AItem: TcxSchedulerStorageResourceItem): TcxSchedulerResourceViewInfo;
    procedure HideCloneEventsOnDragDrop;
    procedure HideSourceEventsOnDragDrop;
    function IsTimeSelected(ATime: TDateTime; AResource: TObject): Boolean; virtual;
    procedure MakeTimeVisible(const ATime: TDateTime); virtual;
    procedure OnClickMoreButton(Sender: TcxSchedulerMoreEventsButtonViewInfo); virtual;
    procedure ProcessDateToDisplayText(ArrangeByType: Boolean = False); virtual;
    procedure ProcessCheckBorders(AList: TcxSchedulerViewInfoCellList;
      AHasCommonArea: Boolean; ANeighbors: TcxNeighbors = [];
      AExcludeBorders: TcxBorders = []; AAddBorders: TcxBorders = []);
    function SetAdapter(Adapter: TcxCustomResourceViewAdapter): TcxCustomResourceViewAdapter;

    property View: TcxSchedulerCustomResourceView read GetView;
  public
    constructor Create(AOwner: TcxSchedulerSubControl); override;
    destructor Destroy; override;
    procedure Calculate; override;
    procedure CalculateHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest); virtual;
    procedure InitScrollBarsParameters; virtual;
    procedure ScrollHorizontal(AScrollCode: TScrollCode; var AScrollPos: Integer); virtual;
    procedure ScrollVertical(AScrollCode: TScrollCode; var AScrollPos: Integer); virtual;
    procedure SetEventsVisibility(AShowSources, AShowClones: Boolean; AForceRepaint: Boolean = False); override;

    property Adapter: TcxCustomResourceViewAdapter read FAdapter;
    property Buttons: TcxSchedulerViewInfoCellList read FButtons;
    property CanSelected: Boolean read FCanSelected; 
    property Clones: TcxSchedulerEventList read GetClones;
    property ContentCells: TcxSchedulerViewInfoCellList read FContentCells;
    property ContentLineHeight: Integer read FContentLineHeight;
    property DayCount: Integer read GetDayCount;
    property DayHeaderCells: TcxSchedulerViewInfoCellList read FDayHeaderCells;
    property DayHeaderHeight: Integer read GetDayHeaderHeight;
    property Days[Index: Integer]: TDateTime read GetDay;
    property EventCells: TcxSchedulerViewInfoCellList read FEventCells;
    property ShowEventsWithoutResource: Boolean read GetShowEventsWithoutResource;
    property GroupByDate: Boolean read GetGroupByDate;
    property GroupByResource: Boolean read GetGroupByResource;
    property GroupSeparatorCells: TcxSchedulerViewInfoCellList read FGroupSeparatorCells;
    property GroupSeparatorParams: TcxViewParams read FGroupSeparatorParams;
    property GroupingKind: TcxSchedulerGroupingKind read FGroupingKind;
    property HasSeparator: Boolean read GetHasSeparator;
    property HasVisibleBounds: Boolean read FHasVisibleBounds;
    property HeaderContainerCells: TcxSchedulerViewInfoCellList read FHeaderContainerCells;
    property HideSelection: Boolean read FHideSelection;
    property PagesPerWeek: Byte read FPagesPerWeek;
    property PrimaryPage: Boolean read FPrimaryPage;
    property PrintFrom: TDateTime index 0 read GetPrintRange;
    property PrintTo: TDateTime index 1 read GetPrintRange;
    property PrintWeekEnds: Boolean read FPrintWeekEnds;
    property Resources[AIndex: Integer]: TcxSchedulerResourceViewInfo read GetResource;
    property ResourceCaptions[AIndex: Integer]: string read GetResourceCaption;
    property ResourceCount: Integer read GetResourceCount;
    property ResourceHeaderCells: TcxSchedulerViewInfoCellList read FResourceHeaderCells;
    property ResourceHeaderHeight: Integer read FResourceHeaderHeight;
    property SelFinish: TDateTime read FSelFinish;
    property SelResource: TcxSchedulerResourceViewInfo read FSelResource;
    property SelStart: TDateTime read FSelStart;
    property SeparatorWidth: Integer read GetSeparatorWidth;
    property StylesAdapter: IcxSchedulerStylesAdapter read FStylesAdapter; 
    property HiddenSelection: Boolean read GetHiddenSelection;
  end;

  { TcxSchedulerCustomResourceViewNavigation }

  TcxSchedulerCustomResourceViewNavigation = class(TcxSchedulerViewNavigation)
  private
    function GetIsFirstResource: Boolean;
    function GetIsLastResource: Boolean;
    function GetGroupingKind: TcxSchedulerGroupingKind;
    function GetResourceObject: TcxSchedulerResourceViewinfo;
    function GetViewInfo: TcxSchedulerCustomResourceViewViewInfo;
  protected
    function GetNextResource(AGoToForward: Boolean): TcxSchedulerStorageResourceItem;
    function GetResourceItem: TcxSchedulerStorageResourceItem; override;
    function GetResourceFromViewInfo(AInfo: TcxSchedulerResourceViewInfo): TcxSchedulerStorageResourceItem;
    function RoundTime(const ADateTime: TDateTime): TDateTime;
  public
    procedure ValidateSelection(var ASelStart, ASelFinish: TDateTime;
      var AResource: TcxSchedulerStorageResourceItem); override;
    property IsFirstResource: Boolean read GetIsFirstResource;
    property IsLastResource: Boolean read GetIsLastResource;
    property GroupingKind: TcxSchedulerGroupingKind read GetGroupingKind;
    property ResourceItem: TcxSchedulerStorageResourceItem read GetResourceItem;
    property ResourceObject: TcxSchedulerResourceViewInfo read GetResourceObject;
    property ViewInfo: TcxSchedulerCustomResourceViewViewInfo read GetViewInfo;
  end;

  { TcxSchedulerCustomResourceViewController }

  TcxSchedulerCustomResourceViewController = class(TcxSchedulerViewController)
  protected
    function CreateNavigation: TcxSchedulerViewNavigation; override;
    function GetCursor(X, Y: Integer): TCursor; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  end;

  { TcxSchedulerCustomResourceViewHitTest }

  TcxSchedulerCustomResourceViewHitTest = class(TcxSchedulerViewHitTest)
  private
    function GetContentCell: TcxSchedulerContentCellViewInfo;
    function GetHeaderCell: TcxSchedulerHeaderCellViewInfo;
    function GetView: TcxSchedulerCustomResourceView;
  protected
    FButton: TcxSchedulerMoreEventsButtonViewInfo;
    FDragKind: TcxEventDragKind;
    FEventCell: TcxSchedulerEventCellViewInfo;
    FHitObject: TObject;
    FTimeZone: Integer;
    function CanMoveEvent(AEvent: TcxSchedulerControlEvent): Boolean; virtual;
    function CanResizeEvent(AEvent: TcxSchedulerControlEvent): Boolean; virtual;
    procedure Clear; override;
    procedure DoCalculate; override;
    function GetHitEvent: TcxSchedulerControlEvent; override;
    procedure SetHitTime(AItemFlag: Integer; const ATime: TDateTime); virtual;
    procedure SetResource(AResource: TcxSchedulerResourceViewInfo);
    procedure ValidateDragKind; virtual;

    property View: TcxSchedulerCustomResourceView read GetView;
    property HitAtTimeZoneLabel: Boolean index htcTimeZoneLabel read GetBitState;
    property TimeZone: Integer read FTimeZone;
  public
    function GetDragKind: TcxEventDragKind; override;
    
    property Button: TcxSchedulerMoreEventsButtonViewInfo read FButton;
    property ContentCell: TcxSchedulerContentCellViewInfo read GetContentCell;
    property EventCell: TcxSchedulerEventCellViewInfo read FEventCell;
    property HeaderCell: TcxSchedulerHeaderCellViewInfo read GetHeaderCell;
    property HitAtButton: Boolean index htcButton read GetBitState;
    property HitAtContent: Boolean index htcContent read GetBitState;
    property HitAtDayHeader: Boolean index htcDayHeader read GetBitState;
    property HitAtGroupSeparator: Boolean index htcGroupSeparator read GetBitState;
    property HitAtResourceHeader: Boolean index htcResourceHeader read GetBitState;
  end;

 { TcxSchedulerCustomViewPainter }

  TcxSchedulerCustomViewPainter = class(TcxSchedulerSubControlPainter)
  private
    function GetView: TcxSchedulerCustomResourceView;
  protected
    FPainter: IcxSchedulerCommonViewItemsPainter;
    procedure DrawBackgroundCell(AItem: TcxSchedulerBackgroundCellViewInfo); virtual;
    procedure DrawButtonCell(AItem: TcxSchedulerCustomViewInfoItem; var ADone: Boolean); virtual;
    procedure DrawContentCell(AItem: TcxSchedulerCustomViewInfoItem; var ADone: Boolean); virtual;
    procedure DrawEventCell(AItem: TcxSchedulerCustomViewInfoItem; var ADone: Boolean); virtual;
    procedure DrawGroupSeparatorCell(AItem: TcxSchedulerCustomViewInfoItem; var ADone: Boolean); virtual;
    procedure DrawHeaderCell(AItem: TcxSchedulerCustomViewInfoItem; var ADone: Boolean); virtual;
    procedure DrawResourceHeaderCell(AItem: TcxSchedulerCustomViewInfoItem; var ADone: Boolean); virtual;
  public
    constructor Create(AOwner: TcxSchedulerSubControl); override;
    procedure Paint; override;
    
    property Painter: IcxSchedulerCommonViewItemsPainter read FPainter;
    property View: TcxSchedulerCustomResourceView read GetView;
  end;

implementation

uses
  cxDrawTextUtils, cxLibraryConsts;

type
  TcxCustomEditStyleAccess = class(TcxCustomEditStyle);
  
const
  AlignmentsHorz: array[TAlignment] of Integer =
    (cxAlignLeft, cxAlignRight, cxAlignHCenter);
  AlignmentsVert: array[TcxAlignmentVert] of Integer =
    (cxAlignTop, cxAlignBottom, cxAlignVCenter);
  MultiLines: array[Boolean] of Integer = (0, cxWordBreak);

{ TcxSchedulerViewInfoCellList }

function TcxSchedulerViewInfoCellList.CalculateHitTest(
  AHitTest: TcxSchedulerCustomResourceViewHitTest): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Count - 1 do
    if Items[I].GetHitTest(AHitTest, Result) and Result then Exit;
end;

procedure TcxSchedulerViewInfoCellList.Clear;
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do
    Items[I].Free;
  inherited Clear;
end;

procedure TcxSchedulerViewInfoCellList.Draw(
  ACanvas: TcxCanvas; ADrawItemProc: TcxSchedulerCustomDrawItemProc);
var
  I: Integer;
  ADone: Boolean;
  AItem: TcxSchedulerCustomViewInfoItem;
  ASavedFont: TFont;
begin
  for I := 0 to Count - 1 do
  begin
    AItem := Items[I];
    if AItem.FVisible then
    begin
      ASavedFont := AItem.FViewParams.Font;
      AItem.BeforeCustomDraw(ACanvas);
      ADone := False;
      if AItem.FHasClipping then
      begin
        AItem.FCanvas := ACanvas;
        AItem.ClippingCreate(AItem.FHasClipping);
        ADrawItemProc(AItem, ADone);
        AItem.ClippingRestore;
      end
      else
        ADrawItemProc(AItem, ADone);
      AItem.AfterCustomDraw(ACanvas);
      if not ADone then AItem.Draw(ACanvas);
      AItem.FViewParams.Font := ASavedFont;
    end;
  end;
  SelectClipRgn(ACanvas.Handle, 0);
end;

function TcxSchedulerViewInfoCellList.GetItem(
  AIndex: Integer): TcxSchedulerCustomViewInfoItem;
begin
  Result := List^[AIndex];
end;

{ TcxSchedulerCustomViewInfoItem }

constructor TcxSchedulerCustomViewInfoItem.Create(
  APainter: TcxCustomLookAndFeelPainterClass;
  const ABounds, AVisibleRect: TRect; const AViewParams: TcxViewParams);
begin
  FPainter := APainter;
  FDateTime := NullDate;
  FViewParams := AViewParams;
  FBounds := ABounds;
  FVisible := cxRectIntersect(FClipRect, ABounds, AVisibleRect);
  FHasClipping := FVisible and not cxRectIsEqual(FClipRect, ABounds);
end;

destructor TcxSchedulerCustomViewInfoItem.Destroy;
begin
  FClipRgn.Free;
  inherited Destroy;
end;

procedure TcxSchedulerCustomViewInfoItem.Draw(ACanvas: TcxCanvas);
var
  ATransparent: Boolean;
  APrevCanvas: TcxCanvas;
  APrevParams: TcxViewParams;
begin
  if not FVisible then Exit;
  ATransparent := Transparent;
  APrevCanvas := FCanvas;
  ACanvas.GetParams(APrevParams);
  FCanvas := ACanvas;
  DoDraw;
  ACanvas.SetParams(APrevParams);
  FCanvas := APrevCanvas;
  Transparent := ATransparent;               
end;

procedure TcxSchedulerCustomViewInfoItem.ClippingCreate(AHasClipping: Boolean);
begin
  Inc(FClipRef);
  if not AHasClipping or (FClipRef > 1) then Exit;
  if FClipRgn = nil then
    FClipRgn := TcxRegion.Create(FClipRect);
  FSavedClipRgn := Canvas.GetClipRegion;
  Canvas.SetClipRegion(FClipRgn, roSet, False);
end;

procedure TcxSchedulerCustomViewInfoItem.ClippingRestore;
begin
  Dec(FClipRef);
  if (FClipRef = 0) and (FSavedClipRgn <> nil) then
  begin
    Canvas.SetClipRegion(FSavedClipRgn, roSet, True);
    FSavedClipRgn := nil;
  end;
end;

function TcxSchedulerCustomViewInfoItem.DrawBackground(
  ACanvas: TcxCanvas; const ABounds: TRect): Boolean;
begin
  Result := Transparent or Assigned(Bitmap) and not Bitmap.Empty;
  if Result and not Transparent then
    ACanvas.FillRect(ABounds, Bitmap);
end;

procedure TcxSchedulerCustomViewInfoItem.DrawFrame(
  const ARect: TRect; ABorders: TcxBorders = [];
  ABorderColor: TColor = clDefault; ALineWidth: Integer = 1);
begin
  Canvas.FrameRect(ARect, ABorderColor, ALineWidth, ABorders);
end;

procedure TcxSchedulerCustomViewInfoItem.DrawRect(
  const ARect: TRect; ABorders: TcxBorders = [];
  ABorderColor: TColor = clDefault; ALineWidth: Integer = 1);
begin
  if Transparent then
    Canvas.FrameRect(ARect, ABorderColor, ALineWidth, ABorders)
  else
    Canvas.FillRect(ARect, FViewParams, ABorders,  ABorderColor, ALineWidth);
end;

procedure TcxSchedulerCustomViewInfoItem.DrawText(
  const ARect: TRect; const AText: string; AFlags: Integer; AFont: TFont = nil; AColor: TColor = clDefault);
begin
  if AFont = nil then
    Canvas.Font := FViewParams.Font
  else
    Canvas.Font := AFont;
  if AColor <> clDefault then
    Canvas.Font.Color := AColor;
  Canvas.Brush.Style := bsClear;
  Canvas.DrawTexT(AText, ARect, AFlags);
end;

function TcxSchedulerCustomViewInfoItem.GetFont: TFont;
begin
  Result := FViewParams.Font;
end;

function TcxSchedulerCustomViewInfoItem.GetHitTest(
  AHitTest: TcxSchedulerCustomResourceViewHitTest; var ABreak: Boolean): Boolean;
begin
  Result := FVisible and PtInRect(FClipRect, AHitTest.HitPoint);
  ABreak := Result;
  if Result then
    InitHitTest(AHitTest);
end;

procedure TcxSchedulerCustomViewInfoItem.InitHitTest(
  AHitTest: TcxSchedulerCustomResourceViewHitTest);
begin
  AHitTest.FHitObject := Self;
end;

procedure TcxSchedulerCustomViewInfoItem.RotateBitmap(
  ABitmap: TBitmap; ARotationAngle: TcxRotationAngle; AFlipHorizontally: Boolean = False);
var
  PDest, PDestStart: ^DWORD;
  PSource, PSourceStart: ^DWord;
  PBuffer: Pointer;
  XSource, YSource: Integer;
  LineCopyingDirection: Integer;
  TempVar: Integer;
begin
  if ABitmap.Empty then Exit;
  case ARotationAngle of
    ra0:
      if AFlipHorizontally then
      begin
        with ABitmap do
        begin
          GetMem(PBuffer, Width * 4);
          for YSource := 0 to Height - 1 do
          begin
            PSourceStart := ScanLine[YSource];
            PSource := PSourceStart;
            Inc(PSource, Width - 1);
            PDest := PBuffer;
            for XSource := 0 to Width - 1 do
            begin
              PDest^ := PSource^;
              Inc(PDest);
              Dec(PSource);
            end;
            Move(PBuffer^, PSourceStart^, Width * 4);
          end;
        end;
        FreeMem(PBuffer);
      end;
    raPlus90, raMinus90:
      with ABitmap do
      begin
        GetMem(PBuffer, Width * Height * 4);

        LineCopyingDirection := 0;
        PDestStart := PBuffer;
        case ARotationAngle of
          raPlus90:
            begin
              Inc(PDestStart, Height * (Width - 1));
              LineCopyingDirection := 1;
            end;
          raMinus90:
            begin
              Inc(PDestStart, Height - 1);
              LineCopyingDirection := -1;
            end;
        end;

        for YSource := 0 to Height - 1 do
        begin
          PSource := ScanLine[YSource];
          PDest := PDestStart;
          if AFlipHorizontally then
          begin
            Inc(PSource, Width - 1);
            for XSource := 0 to Width - 1 do
            begin
              PDest^ := PSource^;
              Dec(PDest, Height * LineCopyingDirection);
              Dec(PSource);
            end
          end
          else
            for XSource := 0 to Width - 1 do
            begin
              PDest^ := PSource^;
              Dec(PDest, Height * LineCopyingDirection);
              Inc(PSource);
            end;
          Inc(PDestStart, LineCopyingDirection);
        end;

        TempVar := Width;
        Width := Height;
        Height := TempVar;
        if Width = Height then
        begin
          Width := Width + 1;
          Width := Width - 1;
        end;

        PDest := PBuffer;
        for YSource := 0 to Height - 1 do
        begin
          Move(PDest^, ScanLine[YSource]^, Width * 4);
          Inc(PDest, Width);
        end;

        FreeMem(PBuffer);
      end;
  end;
end;

// custom draw support
procedure TcxSchedulerCustomViewInfoItem.AfterCustomDraw(ACanvas: TcxCanvas);
begin
  FViewParams.TextColor := ACanvas.Font.Color;
  FViewParams.Color := ACanvas.Brush.Color;
  FViewParams.Font := ACanvas.Font;
end;

procedure TcxSchedulerCustomViewInfoItem.BeforeCustomDraw(ACanvas: TcxCanvas);
begin
  ACanvas.Font := FViewParams.Font;
  ACanvas.Font.Color := FViewParams.TextColor;
  ACanvas.SetBrushColor(FViewParams.Color);
end;

function TcxSchedulerCustomViewInfoItem.GetBitmap: TBitmap;
begin
  Result := FViewParams.Bitmap;
end;

function TcxSchedulerCustomViewInfoItem.GetColor: TColor;
begin
  Result := FViewParams.Color;
end;

function TcxSchedulerCustomViewInfoItem.GetDateTimeHelper: TcxSchedulerDateTimeHelperClass;
begin
  Result := cxSchedulerUtils.DateTimeHelper;
end;

function TcxSchedulerCustomViewInfoItem.GetPainterHelper: TcxSchedulerPainterHelperClass;
begin
  Result := TcxSchedulerHelpersFactory.PainterHelperClass;
end;

function TcxSchedulerCustomViewInfoItem.GetTextColor: TColor;
begin
  Result := FViewParams.TextColor;
end;

procedure TcxSchedulerCustomViewInfoItem.SetBitmap(
  AValue: TBitmap);
begin
  FViewParams.Bitmap := AValue;
end;

procedure TcxSchedulerCustomViewInfoItem.SetColor(
  AValue: TColor);
begin
  FViewParams.Color := AValue;
end;

procedure TcxSchedulerCustomViewInfoItem.SetTextColor(
  AValue: TColor);
begin
  FViewParams.TextColor := AValue;
end;

{ TcxSchedulerBackgroundCellViewInfo }

procedure TcxSchedulerBackgroundCellViewInfo.DoDraw;
begin
  DrawRect(Bounds, Borders, clBtnShadow);
end;

{ TcxSchedulerCustomResourceViewInfoItem }

procedure TcxSchedulerCustomResourceViewInfoItem.InitHitTest(
  AHitTest: TcxSchedulerCustomResourceViewHitTest);
begin
  if IsResourceAssigned then
  begin
    AHitTest.SetResource(FResource);
    AHitTest.SetBitState(htcResource, True);
  end;
end;

{ TcxSchedulerHeaderCellViewInfo }

constructor TcxSchedulerHeaderCellViewInfo.Create(
  APainter: TcxCustomLookAndFeelPainterClass;
  const ABounds, AVisibleRect: TRect; const AViewParams: TcxViewParams);
begin
  inherited Create(APainter, ABounds, AVisibleRect, AViewParams);
  FButtonState := cxbsDefault;
  FAlignHorz := taCenter;
  FAlignVert := vaCenter;
  FBorders := cxBordersAll;
  FTextRect := cxTextRect(FBounds);
end;

destructor TcxSchedulerHeaderCellViewInfo.Destroy;
begin
  FCachedBitmap.Free;
  FRotateBitmap.Free;
  inherited Destroy;
end;

procedure TcxSchedulerHeaderCellViewInfo.Calculate(const AText: string);
begin
  FDisplayText := AText;
end;

procedure TcxSchedulerHeaderCellViewInfo.Draw(ACanvas: TcxCanvas);
var
  ATransparent: Boolean;
  ASavedCanvas: TCanvas;
begin
  if not FVisible then Exit;
  ValidateSelection;
  FBackgroundDrawing := False;
  ATransparent := Transparent;
  if FCachedBitmap = nil then
     FCachedBitmap := cxCreateBitmap(cxRectSize(Bounds), pf32Bit);
  SetWindowOrgEx(FCachedBitmap.Canvas.Handle, FBounds.Left, FBounds.Top, nil);
  ASavedCanvas := ACanvas.Canvas;
  FCanvas := ACanvas;
  FCanvas.Canvas := FCachedBitmap.Canvas;
  if RotateText or RotateHeader then
    DrawVerticalHeader
  else
    DrawHorizontalHeader;
  ACanvas.Canvas := ASavedCanvas;
  SetWindowOrgEx(FCachedBitmap.Canvas.Handle, 0, 0, nil);
  ACanvas.Draw(FBounds.Left, FBounds.Top, FCachedBitmap);
  FCanvas := nil;
  Transparent := ATransparent;
end;

procedure TcxSchedulerHeaderCellViewInfo.CheckNeighbor(
  APrevCell: TcxSchedulerHeaderCellViewInfo);
begin
  if (APrevCell = nil) or (APrevCell.RotateHeader <> RotateHeader)  then Exit;
  if (RotateHeader and (APrevCell.Bounds.Bottom <> Bounds.Top)) or
    (not RotateHeader and (APrevCell.Bounds.Right <> Bounds.Left)) then
    Exclude(APrevCell.FBorders, bRight);
end;

function TcxSchedulerHeaderCellViewInfo.CheckSelection: Boolean;
begin
  Result := False;
end;

procedure TcxSchedulerHeaderCellViewInfo.DoDraw;
begin
  Painter.DrawHeader(Canvas, Bounds, TextRect, Neighbors, Borders,
    FButtonState, AlignHorz, AlignVert, MultiLine, ShowEndEllipsis, DisplayText,
    Font, TextColor, Color, DrawBackground);
end;

procedure TcxSchedulerHeaderCellViewInfo.DrawHorizontalHeader;
var
  AText: string;
begin
  AText := DisplayText;
  FDisplayText := '';
  DoDraw;
  if not FBackgroundDrawing and Selected then
    cxAlphaBlend(FCachedBitmap, FSelectionRect, ColorToRgb(SelectionColor));
  DisplayText := AText;
  TextOut(Canvas, DisplayText, Bounds);
end;

function TcxSchedulerHeaderCellViewInfo.DrawRotateBackground(
  ACanvas: TcxCanvas; const ABounds: TRect): Boolean;
begin
  Result := FDrawRotatedBackground;
end;

procedure TcxSchedulerHeaderCellViewInfo.DrawVerticalHeader;

  procedure CreateRotatedBitmap;
  begin
    with Bounds do
      FRotateBitmap := cxCreateTrueColorBitmap(Right - Left, Bottom - Top);
    FRotateBitmap.PixelFormat := pf32bit;
    FRotateBitmap.Canvas.Lock;
  end;

var
  R: TRect;
  ABitmapCanvas: TcxCanvas;
begin
  if FRotateBitmap = nil then
  begin
    CreateRotatedBitmap;
    ABitmapCanvas := TcxCanvas.Create(FRotateBitmap.Canvas);
    try
      ABitmapCanvas.WindowOrg := Bounds.TopLeft;
      FDrawRotatedBackground := DrawBackground(ABitmapCanvas, Bounds);

      RotateBitmap(FRotateBitmap, raPlus90, True);

      R := cxRect(0, 0, FRotateBitmap.Width, FRotateBitmap.Height);
      Painter.DrawHeader(ABitmapCanvas, R, cxRectInflate(R, -cxTextOffset, -cxTextOffset),
        Neighbors, Borders, cxbsNormal, taCenter, vaCenter, False, False, '',
        Font, TextColor, Color, DrawRotateBackground);

      if RotateText then
      begin
        RotateBitmap(FRotateBitmap, ra0, True);
        TextOut(ABitmapCanvas, DisplayText, R);
        RotateBitmap(FRotateBitmap, raPlus90);
      end
      else
      begin
        RotateBitmap(FRotateBitmap, raPlus90, True);
        R.BottomRight := cxPoint(R.Bottom, R.Right);
        TextOut(ABitmapCanvas, DisplayText, R);
      end;
    finally
      FRotateBitmap.Canvas.Unlock;
      ABitmapCanvas.Free;
    end;
  end;
  Canvas.Draw(Bounds.Left, Bounds.Top, FRotateBitmap);
end;

function TcxSchedulerHeaderCellViewInfo.GetTextOutFlags: Integer;
const
  Horz: array[TAlignment] of Integer =
    (CXTO_LEFT, CXTO_RIGHT, CXTO_CENTER_HORIZONTALLY);
  Vert: array[TcxAlignmentVert] of Integer =
    (CXTO_TOP, CXTO_BOTTOM, CXTO_CENTER_VERTICALLY);
begin
  Result := CXTO_PREVENT_LEFT_EXCEED or CXTO_PREVENT_TOP_EXCEED or
    Horz[AlignHorz] or Vert[AlignVert] + CXTO_SINGLELINE;
end;

procedure TcxSchedulerHeaderCellViewInfo.InitHitTest(
  AHitTest: TcxSchedulerCustomResourceViewHitTest);
begin
  inherited InitHitTest(AHitTest);
  if IsResourceAssigned then
    AHitTest.SetBitState(htcResourceHeader, True);
  if DateTime <> NullDate then
    AHitTest.SetHitTime(htcDayHeader, DateTime);
end;

procedure TcxSchedulerHeaderCellViewInfo.TextOut(ACanvas: TcxCanvas;
  const AText: string; R: TRect);
begin
  if Length(AText) = 0 then Exit;
  R := cxRectInflate(R, -1, -(cxTextOffset + 1));
  with ACanvas.Canvas do
  begin
    Font := FViewParams.Font;
    Font.Color := FViewParams.TextColor;
    Brush.Style := bsClear;
    cxTextOut(Handle, PChar(AText), R, GetTextOutFlags);
  end;
end;

procedure TcxSchedulerHeaderCellViewInfo.ValidateSelection;
begin
  if CheckSelection and (Date = DateOf(FDateTime)) then
    FButtonState := cxbsHot;
  if Selected then
  begin
    if Selected then
      TextColor := FSelectionTextColor;
    FSelectionRect := PainterHelper.ExcludeBorders(Bounds, Borders);
    if FButtonState = cxbsHot then
    begin
      FSelectionRect.Left := Max(FSelectionRect.Left, FSelectionRect.Right -
        PainterHelper.TextWidth(Font, DisplayText) - cxTextOffset * 2);
    end;
  end;
end;

{ TcxSchedulerDayHeaderCellViewInfo }

function TcxSchedulerDayHeaderCellViewInfo.ConvertDateToDisplayText(
  AType: Integer = 0): Integer;
begin
  Result := AType - 1;
  repeat
    Inc(Result);
    FDisplayText := DateTimeHelper.DayToStr(FDateTime, Result, Compressed);
  until (Result = DateTimeHelper.DayToStrFormatCount - 1) or
    (cxTextWidth(Font, DisplayText) <= cxRectWidth(FTextRect) - 2{lcm!!!});
end;

function TcxSchedulerDayHeaderCellViewInfo.CheckSelection: Boolean;
begin
  Result := True; 
end;

procedure TcxSchedulerDayHeaderCellViewInfo.DoDraw;
begin
  if Selected and not (FButtonState = cxbsHot) then
  begin
    Color := FSelectionColor;
    TextColor := FSelectionTextColor;
  end;
  inherited DoDraw;
end;

function TcxSchedulerDayHeaderCellViewInfo.DrawBackground(
  ACanvas: TcxCanvas; const ABounds: TRect): Boolean;
var
  R: TRect;
begin
  FBackgroundDrawing := True; 
  Result := inherited DrawBackground(ACanvas, ABounds);
  if Result then Exit;
  R := PainterHelper.ExcludeBorders(Bounds, Borders);
  if FButtonState = cxbsHot then
    PainterHelper.DrawGradientRect(Canvas, Color, R);
  if Selected then
  begin
    Canvas.SetBrushColor(SelectionColor);
    Canvas.FillRect(FSelectionRect);
  end;
  Result := (FButtonState = cxbsHot) or Selected;
end;

{ TcxSchedulerWeekDayHeaderCellViewInfo }

function TcxSchedulerWeekDayHeaderCellViewInfo.ConvertDateToDisplayText(
  AType: Integer = 0): Integer;
begin
  Result := AType - 1;
  repeat
    Inc(Result);
    FDisplayText := GetDayText(Result);
  until (Result = 3) or (cxTextWidth(Font, DisplayText) <= cxRectWidth(FTextRect));
  if (DateOf(FDateTime) + 1) > 7 then
    Result := 0;
end;

procedure TcxSchedulerWeekDayHeaderCellViewInfo.InitHitTest(
  AHitTest: TcxSchedulerCustomResourceViewHitTest);
begin
  inherited InitHitTest(AHitTest);
  AHitTest.SetBitState(htcTime, False);
end;

function TcxSchedulerWeekDayHeaderCellViewInfo.GetDayText(
  AType: Integer): string;
var
  ADay: Integer;
begin
  //DELPHI8! check Trunc()
  ADay := Trunc(FDateTime) + 1;
  if ADay > 7 then
  begin
    case AType of
      0:
        Result := LongDayNames[7]+ '/' + LongDayNames[1];
      1:
        Result := ShortDayNames[7]+ '/' + ShortDayNames[1];
    else
      Result := AnsiUpperCase(LongDayNames[7][1]+ '/' + LongDayNames[1][1]);
    end;
  end
  else
    case AType of
      0:
        Result := LongDayNames[ADay];
      1:
        Result := ShortDayNames[ADay];
    else
      Result := AnsiUpperCase(LongDayNames[ADay][1]);
    end;
end;

{ TcxSchedulerContainerCellViewInfo }

procedure TcxSchedulerContainerCellViewInfo.DoDraw;
begin
  DrawRect(Bounds, Borders, FDayBorderColor);
end;

procedure TcxSchedulerContainerCellViewInfo.InitHitTest(
  AHitTest: TcxSchedulerCustomResourceViewHitTest);
begin
  inherited InitHitTest(AHitTest);
  AHitTest.FHitObject := Self;
  AHitTest.SetHitTime(htcContainer, DateTime);
end;

{ TcxSchedulerTimeRulerCellViewInfo }

procedure TcxSchedulerTimeRulerCellViewInfo.Calculate(
  const ALabel1, ALabel2: string; ATimeZone, AAdditionalTimeZone: Integer);
begin
  Calculate(-1, 1, ATimeZone, AAdditionalTimeZone, nil);
  FDisplayTexts[True] := ALabel1;
  FDisplayTexts[False] := ALabel2;
end;

procedure TcxSchedulerTimeRulerCellViewInfo.Calculate(AHour, ALineCount: Integer;
  ATimeZone, AAdditionalTimeZone: Integer; ALargeFont: TFont);
begin
  FHour := AHour;
  FLineCount := ALineCount;
  FAdditionalTimeZone := AAdditionalTimeZone;
  FTimeZone := ATimeZone;
  FLargeFont := ALargeFont;
  if FVisible then
    CalculateDisplayInfo;
end;

procedure TcxSchedulerTimeRulerCellViewInfo.SetBottom(AValue: Integer);
begin
  TcxSchedulerCustomViewInfoItem(Self).FClipRect.Bottom := AValue;
end;

class function TcxSchedulerTimeRulerCellViewInfo.CalculateWidth(
  ATimeZoneCount, ALineCount: Integer; AFont1, AFont2: TFont): Integer;
begin
  if ALineCount = 1 then
    Result := TcxSchedulerPainterHelper.TextWidth(AFont1, ' 24:PM')
  else
  begin
    Result := TcxSchedulerPainterHelper.TextWidth(AFont1, ' 24') +
      cxTextWidth(AFont2, 'pm') + cxTextOffset;
  end;
  Inc(Result, cxTextOffset shl 2);
  if ATimeZoneCount > 1 then
    Result := Result shl 1;
end;

procedure TcxSchedulerTimeRulerCellViewInfo.CalculateDisplayInfo;
begin
  FBounds[True] := inherited Bounds;
  FDateTime := Hour * HourToTime;
  if Hour >= 0 then
    FDisplayTexts[True] := GetTimeDisplayText(FDateTime);
  FBounds[False] := inherited Bounds;
  if HasAdditionalTimeZone then
  begin
    FBounds[True].Left := cxRectCenter(inherited Bounds).X;
    FBounds[False].Right := FBounds[True].Left;
    if Hour >= 0 then
      FDisplayTexts[False] := GetTimeDisplayText(GetAdditionalTime);
  end;
end;

procedure TcxSchedulerTimeRulerCellViewInfo.DoDraw;
var
  ACurrentTimeZone: Boolean;
const
  ABorders: array[Boolean] of TcxBorders = ([bBottom], [bBottom, bRight]);
begin
  ClippingCreate(FHasClipping);
  for ACurrentTimeZone := not HasAdditionalTimeZone to True do
  begin
    if Hour >= 0 then
      DrawTimeZone(Bounds[ACurrentTimeZone],
        DisplayTexts[ACurrentTimeZone], ACurrentTimeZone)
    else
      DrawTimeZoneLabel(Bounds[ACurrentTimeZone],
        DisplayTexts[ACurrentTimeZone], ABorders[ACurrentTimeZone]);
  end;
  ClippingRestore;
end;

procedure TcxSchedulerTimeRulerCellViewInfo.DrawTimeZoneLabel(
  const ABounds: TRect; const AText: string; ABorders: TcxBorders);
begin
  DrawRect(ABounds, ABorders, clBtnShadow);
  DrawText(cxTextRect(ABounds), AText, cxAlignBottom or cxAlignLeft, Font, TextColor); 
end;

procedure TcxSchedulerTimeRulerCellViewInfo.DrawTimeZone(
  const ABounds: TRect; const AText: string; AIsCurrent: Boolean);
var
  J, LH: Integer;
  R, TextR: TRect;
const
  cxRightCenterAlign: Integer = cxAlignVCenter or cxAlignRight or cxDontClip;
  cxRightTopAlign: Integer = cxAlignTop or cxAlignRight or cxDontClip;
begin
  LH := cxRectHeight(inherited Bounds) div LineCount;
  DrawRect(ABounds, [bRight], clBtnShadow);
  R := cxRectSetHeight(ABounds, LH);
  R.Left := (R.Left + R.Right) div 2 + cxTextOffset shl 1;
  Dec(R.Right, 6);
  for J := 0 to LineCount - 2 do
  begin
    Canvas.FrameRect(R, clBtnShadow, 1, [bBottom]);
    OffsetRect(R, 0, LH);
  end;
  Canvas.Brush.Style := bsClear;
  TextR := cxRectInflate(PainterHelper.ExcludeBorders(ABounds,
    [bRight, bBottom]), -5, -cxTextOffset);
  if AIsCurrent then
    DrawCurrentTime(FDateTime, ABounds);
  if LineCount > 1 then
  begin
    J := Length(AText);
    DrawText(Rect(TextR.Left, TextR.Top, R.Left - cxTextOffset, TextR.Bottom),
      Copy(AText, 1, J - 3), cxRightTopAlign, LargeFont, TextColor);
    DrawText(Rect(R.Left, TextR.Top, TextR.Right, TextR.Top + LH - 3),
      Copy(AText, J - 1, 2), cxAlignCenter, Font, TextColor);
  end
  else
    DrawText(TextR, AText, cxRightCenterAlign, Font, TextColor);
  R.Left := ABounds.Left + 5;
  if Hour <> 23 then
    DrawFrame(R, [bBottom], clBtnShadow)
  else
    DrawFrame(ABounds, [bBottom], clBtnShadow);
end;

procedure TcxSchedulerTimeRulerCellViewInfo.DrawCurrentTime(
  const AStart: TDateTime; ABounds: TRect);
var
  Y: Integer;
  ANow: TDateTime;
begin
  ANow := TimeOf(Now) - TimeOf(AStart);
  if (ANow < 0) or (ANow >= HourToTime) then Exit;
  Y := Round(ABounds.Top + (ANow * cxRectHeight(ABounds)) / HourToTime);
  Dec(Y, 3);
  Dec(ABounds.Right);
  if Y < ABounds.Top then
    Y := ABounds.Top;
  PainterHelper.DrawGradientRect(Canvas, Color, cxRectSetTop(ABounds, Y - 6, 6));
  Canvas.Brush.Style := bsClear;
end;

function TcxSchedulerTimeRulerCellViewInfo.GetAdditionalTime: TDateTime;
begin
  Result := DateTimeHelper.ConvertToAnotherTimeZone(
    Hour * HourToTime + Date, TimeZone, AdditionalTimeZone);
end;

function TcxSchedulerTimeRulerCellViewInfo.GetTimeDisplayText(
  const ATime: TDateTime): string;
var
  APos: Integer;
begin
  Result := DateTimeHelper.HourToStr(ATime);
  if LineCount > 1 then
  begin
    APos := Pos(TimeSeparator, Result);
    if APos = 0 then
      APos := Pos(' ', Result);
    if APos = 0 then
      APos := Length(Result) - 2;
    Result := Copy(Result, 1, APos - 1) + ' ' + AnsiLowerCase(Copy(Result, APos + 1, 2));
  end;
end;

procedure TcxSchedulerTimeRulerCellViewInfo.InitHitTest(
  AHitTest: TcxSchedulerCustomResourceViewHitTest);
var
  LH: Integer;
  ACurrentTimeZone: Boolean;
  ATime, ATimePerLine: TDateTime;
begin
  inherited InitHitTest(AHitTest);
  if Hour >= 0 then
  begin
    LH := cxRectHeight(inherited Bounds) div FLineCount;
    ATimePerLine := 60 / FLineCount * MinuteToTime;
    ATime := (AHitTest.HitY - inherited Bounds.Top) div LH * ATimePerLine + FHour * HourToTime;
    AHitTest.SetHitTime(htcTimeRuler, ATime);
  end
  else
    AHitTest.SetBitState(htcTimeZoneLabel, True);
  for ACurrentTimeZone := not HasAdditionalTimeZone to True do
    if PtInRect(Bounds[ACurrentTimeZone], AHitTest.HitPoint) then
    begin
      if ACurrentTimeZone then
        AHitTest.FTimeZone := TimeZone
      else
        AHitTest.FTimeZone := AdditionalTimeZone;
    end;
end;

procedure TcxSchedulerTimeRulerCellViewInfo.AfterCustomDraw(ACanvas: TcxCanvas);
begin
  FViewParams.TextColor := ACanvas.Font.Color;
  FViewParams.Color := ACanvas.Brush.Color;
end;

procedure TcxSchedulerTimeRulerCellViewInfo.BeforeCustomDraw(ACanvas: TcxCanvas);
begin
  ACanvas.Font := FViewParams.Font;
  ACanvas.Font.Color := FViewParams.TextColor;
  ACanvas.SetBrushColor(FViewParams.Color);
end;

function TcxSchedulerTimeRulerCellViewInfo.GetBoundsRect(
  AType: Boolean): TRect;
begin
  Result := FBounds[AType];
end;

function TcxSchedulerTimeRulerCellViewInfo.GetDisplayText(
  AType: Boolean): string;
begin
  Result := FDisplayTexts[AType];
end;

function TcxSchedulerTimeRulerCellViewInfo.GetHasAdditionalTimeZone: Boolean;
begin
  Result := AdditionalTimeZone >= 0;
end;

{ TcxSchedulerContentCellViewInfo }

constructor TcxSchedulerContentCellViewInfo.Create(
  APainter: TcxCustomLookAndFeelPainterClass;
  const ABounds, AVisibleRect: TRect; const AViewParams: TcxViewParams);
begin
  inherited Create(APainter, ABounds, AVisibleRect, AViewParams);
  FTimeLineBorders := [bLeft, bRight];
  BorderColor := clDefault; 
end;

procedure TcxSchedulerContentCellViewInfo.SetTime(
  const ATimeStart, ATimeFinish: TDateTime);
begin
  FDateTime := ATimeStart;
  FTimeFinish := ATimeFinish;
end;

procedure TcxSchedulerContentCellViewInfo.DoDraw;
var
  R: TRect;
begin
  if BorderColor = clDefault then
    BorderColor := FDayBorderColor;
  if FShowTimeLine then
  begin
    R := Bounds;
    Inc(R.Left, cxTimeLineWidth);
    DrawRect(R, Borders, BorderColor);
    R := cxRectSetRight(R, R.Left, cxTimeLineWidth);
    if FTimeEvent = nil then
      Canvas.FillRect(R, FTimeLineParams, FTimeLineBorders, FTimeLineParams.TextColor)
    else
      FTimeEvent.DrawState(Canvas, R, FTimeLineBorders, FTimeLineParams.TextColor);
  end
  else
    DrawRect(Bounds, Borders, BorderColor);
end;

procedure TcxSchedulerContentCellViewInfo.InitHitTest(
  AHitTest: TcxSchedulerCustomResourceViewHitTest);
begin
  inherited InitHitTest(AHitTest);
  AHitTest.SetHitTime(htcContent, FDateTime);
  AHitTest.FHitObject := Self;
end;

{ TcxSchedulerBackgroundSlotCellViewInfo }

procedure TcxSchedulerBackgroundSlotCellViewInfo.DoDraw;
begin
  inherited DoDraw;
end;

{ TcxSchedulerMonthDayContentCellViewInfo }

procedure TcxSchedulerMonthDayContentCellViewInfo.SetContentState(
  AsDayOfMonth: Boolean; ASelected: Boolean;
  ATextHeight: Integer; const ASelectionParams: TcxViewParams);
begin
  FSelectionColor := ASelectionParams.Color;
  FSelectionTextColor := ASelectionParams.TextColor;
  FTextRect := cxRectInflate(PainterHelper.ExcludeBorders(Bounds,
    cxBordersAll), -cxTextOffset, 0);
  if AsDayOfMonth then
    FDisplayText := IntToStr(DayOf(TimeStart))
  else
    FDisplayText := GetLongDisplayText;
  FSelected := ASelected;
  FTextRect.Bottom := Min(FTextRect.Bottom, FTextRect.Top + ATextHeight);
  FTextRect.Left := Max(FTextRect.Left,
    FTextRect.Right - PainterHelper.TextWidth(Font, DisplayText));
end;

procedure TcxSchedulerMonthDayContentCellViewInfo.DoDraw;
var
  R: TRect;
begin
  inherited DoDraw;
  if DisplayText <> '' then
  begin
    R := PainterHelper.ExcludeBorders(Bounds, Borders);
    R.Bottom := FTextRect.Bottom;
    if not Transparent and IsToday then
      PainterHelper.DrawGradientRect(Canvas, Color, R);
    if Selected then
    begin
      Inc(R.Top);
      Canvas.SetBrushColor(SelectionColor);
      if not IsToday then
        Canvas.FillRect(R)
      else
        Canvas.FillRect(cxRectInflate(FTextRect, cxTextOffset, 0));
    end;
    Canvas.Font := Font;
    if Selected then
      Canvas.Font.Color := SelectionTextColor
    else
      Canvas.Font.Color := TextColor;
    Canvas.Brush.Style := bsClear;
    Canvas.DrawTexT(DisplayText, FTextRect, cxAlignRight or cxAlignVCenter);
  end;
end;

function TcxSchedulerMonthDayContentCellViewInfo.GetLongDisplayText: string;
begin
  Result := LongMonthNames[MonthOf(TimeStart)] + ', ' + IntToStr(DayOf(TimeStart));
  if cxTextWidth(Font, Result) >= (cxRectWidth(FTextRect) div 2) then
    Result := ShortMonthNames[MonthOf(TimeStart)] + ' ' + IntToStr(DayOf(TimeStart));
end;

function TcxSchedulerMonthDayContentCellViewInfo.GetIsToday: Boolean;
begin
  Result := Date = TimeStart;
end;

{ TcxSchedulerEventCellViewInfo }

constructor TcxSchedulerEventCellViewInfo.Create(
  AViewData: TcxSchedulerEventViewData);
begin
  inherited Create(AViewData.Painter, AViewData.Bounds,
    AViewData.VisibleRect, AViewData.ViewParams);
  ViewData := AViewData;
  if not Visible or Hidden then Exit;
  FSeparatorColor := clBtnShadow;
  Calculate;
end;

destructor TcxSchedulerEventCellViewInfo.Destroy;
begin
  ViewData.Free;
  FEditViewInfo.Free;
  inherited Destroy;
end;

procedure TcxSchedulerEventCellViewInfo.Draw(
  ACanvas: TcxCanvas; ABitmap: TBitmap);
begin
  ViewData.Bitmap := ABitmap;
  inherited Draw(ACanvas);
end;

procedure TcxSchedulerEventCellViewInfo.DrawState(ACanvas: TcxCanvas;
  const ARect: TRect; ABorders: TcxBorders; ABorderColor: TColor);
begin
  PainterHelper.DrawState(ACanvas, ARect, Event.State, ABorders, ABorderColor);
end;

procedure TcxSchedulerEventCellViewInfo.AssignEditStyle(
  AEditStyle: TcxCustomEditStyle);
var
  AStyle: TcxCustomEditStyleAccess;
begin
  AStyle := TcxCustomEditStyleAccess(AEditStyle);
  AStyle.FAssignedValues := AStyle.FAssignedValues -
    [svFont] + [svColor, svButtonTransparency];
  AStyle.StyleData.Font := Font;
  AStyle.StyleData.Color := Color;
  AStyle.StyleData.FontColor := TextColor;
  AStyle.ButtonTransparency :=  ebtHideInactive;
  AStyle.Changed;
end;

procedure TcxSchedulerEventCellViewInfo.BeforeCustomDraw(ACanvas: TcxCanvas);
begin
  FViewParams := ViewData.ViewParams;
  inherited BeforeCustomDraw(ACanvas);
end;

procedure TcxSchedulerEventCellViewInfo.Calculate;
begin
  FBorders := cxBordersAll;
  FStartText := DateTimeHelper.TimeToStr(Event.Start);
  FFinishText := DateTimeHelper.TimeToStr(Event.Finish);
  ViewData.ShowTimeLine := ViewData.ShowTimeLine and not IsHeaderEvent;
  if Selected and ViewData.ShowTimeLine then
    FVisible := cxRectIntersect(FClipRect,
      cxRectInflate(Bounds, 0, cxTimeLineWidth), ViewData.VisibleRect);
  CalculateMetrics;
  CalculateVisibility;
  CalculateItemsLayout;
  if ViewData.ShowTimeLine then
  begin
    CalculateTimeLineParams;
    Exclude(FBorders, bLeft);
  end;
  CalculateEditViewInfo;
  if not IsHeaderEvent then
    InflateRect(FContentRect, -1, 0);
end;

procedure TcxSchedulerEventCellViewInfo.CalculateEditViewInfo;
const
  AFlags: array[Boolean] of Integer =(
   DT_LEFT or DT_TOP or DT_CALCRECT,
   DT_LEFT or DT_TOP or DT_WORDBREAK or DT_CALCRECT);
var
  R: TRect;
  AProperties: TcxCustomEditProperties;
  AEditViewData: TcxCustomEditViewData;
begin
  R := FContentRect;
  if not IsHeaderEvent then
    InflateRect(R, -1, 0);
  FShowMessage := FShowMessage and (Trim(Message) <> ''); //todo: 
  if not FShowMessage then
  begin
    FContentRect.Bottom := FBounds.Bottom - cxTextOffset;
    Exit; 
  end;
  Windows.DrawText(cxScreenCanvas.Handle, PChar(ViewData.Caption), -1, R,
    AFlags[IsDetailInfo]);
  if R.Bottom > FContentRect.Bottom then
    FContentRect.Bottom := R.Bottom;
  if FContentRect.Bottom > FBounds.Bottom then
  begin
    FContentRect.Bottom := FBounds.Bottom - cxTextOffset;
    FShowMessage := False;
  end;
  if not FShowMessage then Exit;
  FEditViewInfo := TcxCustomEditViewInfo(ViewData.EditProperties.GetViewInfoClass.Create);
  FMessageRect.Top := FContentRect.Bottom + cxTextOffset;
  AProperties := ViewData.EditProperties;
  AEditViewData := AProperties.CreateViewData(ViewData.EditStyle, True);
  try
    AssignEditStyle(ViewData.EditStyle);
    AEditViewData.EditValueToDrawValue(Canvas, Message, FEditViewInfo);
    AEditViewData.ContentOffset :=
      cxRect(cxTextOffset, cxTextOffset, cxTextOffset, cxTextOffset);
    AEditViewData.CalculateEx(Canvas, FMessageRect,
      cxInvalidPoint, cxmbNone, [], FEditViewInfo, False);
  finally
    AEditViewData.Free;
  end;
end;

procedure TcxSchedulerEventCellViewInfo.CalculateItemsLayout;
begin
  with cxRectSize(FContentRect) do
  begin
    FIconRect := Rect(0, 0, Max(CY, PainterHelper.IconsWidth), Max(CY, PainterHelper.IconsHeight));
    FIconW := FIconRect.Right; 
  end;
  if IsDetailInfo then
    CalculateDayViewEventLayout
  else
  begin
    if IsHeaderEvent then
      CalculateHeaderEventLayout
    else
      CalculateWeekViewEventLayout
  end;
end;

procedure TcxSchedulerEventCellViewInfo.CalculateDayViewEventLayout;
begin
  Inc(FContentRect.Left, cxTextOffset);
  FBellRect := SetItemRect(ShowBell, FIconRect, FContentRect.Left);
  FRecurrenceRect := SetItemRect(FShowRecurrence, FIconRect, FContentRect.Left);
  if ShowStartTime then
  begin
    with DateTimeHelper do
    begin
      ViewData.Caption := TimeToStr(Event.Start) + '-' +
         TimeToStr(Event.Finish) + ' ' + ViewData.Caption;
    end;
  end;
  Inc(FContentRect.Top, 1);
end;

procedure TcxSchedulerEventCellViewInfo.CalculateHeaderEventLayout;
var
  ALeft: Integer;
begin
  if ShowStartTime then
  begin
    FStartRect := cxRectOffset(FIconRect, FContentRect.TopLeft);
    FContentRect.Left := FStartRect.Right;
  end;
  if ShowFinishTime then
  begin
    FFinishRect := cxRectOffset(FIconRect, FContentRect.Right - FIconW, FContentRect.Top);
    FContentRect.Right := FFinishRect.Left;
  end;
  InflateRect(FContentRect, -cxTextOffset, 0);
  with FContentRect do
    ALeft := (Right + Left - (CaptionWidth +
      (Byte(FShowRecurrence) + Byte(ShowBell)) * (FIconW + cxTextOffset))) div 2;
  ALeft := Max(ALeft, FContentRect.Left);
  if FShowRecurrence then
  begin
    FRecurrenceRect := cxRectOffset(FIconRect, ALeft, FContentRect.Top);
    Inc(ALeft, FIconW + cxTextOffset);
  end;
  if ShowBell then
  begin
    FBellRect := cxRectOffset(FIconRect, ALeft, FContentRect.Top);
    Inc(ALeft, FIconW + cxTextOffset);
  end;
  FContentRect.Left := ALeft;
end;

procedure TcxSchedulerEventCellViewInfo.CalculateWeekViewEventLayout;
var
  R: TRect;
  ALeft: Integer;
begin
  ALeft := FContentRect.Left;
  if not ShowTimeAsClock then
  begin
    if Is24HourTimeFormat then
      R := cxRectSetWidth(FIconRect, cxTextWidth(Font, '00:00'))
    else
      R := cxRectSetWidth(FIconRect, Max(cxTextWidth(Font, '00:00' + TimeAMString),
        cxTextWidth(Font, '00:00' + TimePMString)));
    R := cxRectOffset(R, 0, -1);
  end
  else
    R := FIconRect;
  FStartRect := SetItemRect(ShowStartTime, R, FContentRect.Left);
  FFinishRect := SetItemRect(ShowFinishTime, R, FContentRect.Left);
  FRecurrenceRect := SetItemRect(ShowRecurrence, FIconRect, FContentRect.Left);
  FBellRect := SetItemRect(ShowBell, FIconRect, FContentRect.Left);
  if ALeft = FContentRect.Left then
    Inc(FContentRect.Left, cxTextOffset);
end;

procedure TcxSchedulerEventCellViewInfo.CalculateMetrics;
begin
  if not ViewData.ShowTimeLine then
    FVisible := FVisible and (FClipRect.Bottom = FBounds.Bottom);
  if ViewData.ShowTimeLine then
    Inc(FBounds.Left, cxTimeLineWidth);
  FContentRect := PainterHelper.ExcludeBorders(FBounds, cxBordersAll);
  FMessageRect := FContentRect;
end;

procedure TcxSchedulerEventCellViewInfo.CalculateTimeLineParams;
var
  LTime: Double;
  AStart, AFinish: TDateTime;
  ATop, AHeight: Integer;
begin
  AStart := Max(Event.Start, ContentStart);
  AFinish := Min(Event.Finish, ContentFinish);
  if (ContentFinish - ContentStart) <= 0 then
  begin
    AHeight := 0;
    ATop := 0;
  end
  else
  begin
    LTime := (cxRectHeight(FBounds) - 2) / (ContentFinish - ContentStart);
    ATop := Round((AStart - ContentStart) * LTime) + 1;
    AHeight := Round((AFinish - ContentStart) * LTime + 1) - ATop;
  end;
  Inc(ATop, FBounds.Top);
  FTimeLineRect := cxRectSetRight(FBounds, FBounds.Left, cxTimeLineWidth);
  FEventTimeRect := cxRectBounds(FTimeLineRect.Left, ATop, cxTimeLineWidth, AHeight);
end;

procedure TcxSchedulerEventCellViewInfo.CalculateVisibility;
begin
  FIsDetailInfo := not IsHeaderEvent and
    ((TimeOf(ContentFinish) <> 0) or (TimeOf(ContentStart) <> 0));
  if not IsHeaderEvent and IsDetailInfo then
    FContentRect.Bottom := FContentRect.Top + ViewData.LineHeight - 2;
  FMessageRect.Top := FContentRect.Bottom + cxTextOffset;
  FShowMessage := cxRectHeight(FMessageRect) > cxRectHeight(FContentRect);
  ViewData.ShowBell := {Event.Reminder}False and Event.Enabled and ViewData.ShowBell;
  if IsDetailInfo then
  begin
    ViewData.ShowFinishTime := (TruncTime(ContentFinish) > TruncTime(Event.Finish)) or
      (TruncTime(ContentStart) < TruncTime(Event.Start));
    ViewData.ShowStartTime := ViewData.ShowFinishTime;
  end
  else
  begin
    ViewData.ShowFinishTime := ViewData.ShowFinishTime or (Event.Duration >= 1);
    ViewData.ShowFinishTime := ViewData.ShowFinishTime and (ContentFinish >= Event.Finish);
    ViewData.ShowStartTime := (ContentStart <= Event.Start);
    if not ShowFinishTime and (TruncTime(ContentFinish) < TruncTime(Event.Finish)) then
      Exclude(FBorders, bRight);
    if not ShowStartTime and (TruncTime(ContentStart) > TruncTime(Event.Start)) then
      Exclude(FBorders, bLeft);
    if Event.AllDayEvent then
    begin
      ViewData.ShowFinishTime := False;
      ViewData.ShowStartTime := False;
    end;
  end;
  ViewData.ShowTimeAsClock := IsHeaderEvent or
    (ViewData.ShowTimeAsClock and not IsDetailInfo);
  if ShowTimeAsClock and ViewData.ShowFinishTime then
    ViewData.ShowFinishTime := ContentFinish > Event.Finish;
  if ShowTimeAsClock and ViewData.ShowStartTime then
    ViewData.ShowStartTime := ContentStart < Event.Start;
  FShowRecurrence := Event.EventType <> etNone;
end;

function TcxSchedulerEventCellViewInfo.CanShowHint: Boolean;
var
  W: Integer;
begin
  W := cxTextWidth(Font, ViewData.Caption);
  Result := W > cxRectWidth(FContentRect);
end;

function TcxSchedulerEventCellViewInfo.CaptionWidth: Integer;
begin
  Result := cxTextWidth(Font, Caption);
end;

procedure TcxSchedulerEventCellViewInfo.DoDraw;
var
  R: TRect;
begin
  if FHidden then Exit;
  ClippingCreate(True);
  DrawRect(FBounds, FBorders, clBlack);
  if ShowBell then
    PainterHelper.DrawIcon(Canvas, FBellRect, rcBellIndex, FViewParams, True);
  if FShowRecurrence then
    PainterHelper.DrawIcon(Canvas, FRecurrenceRect,
      rcRecurrenceIndex + Byte(Event.EventType = etCustom), FViewParams, True);
  DrawTime;
  if IsHeaderEvent or not IsDetailInfo then
    DrawText(FContentRect, ViewData.Caption, cxAlignLeft or cxAlignVCenter or cxSingleLine, Font, TextColor)
  else
  begin
    R := FContentRect;
    cxTextOut(Canvas.Canvas, PChar(ViewData.Caption), R, CXTO_LEFT or CXTO_TOP or CXTO_WORDBREAK);
  end;
  if FShowMessage then
  begin
    FEditViewInfo.Transparent := True;
    FEditViewInfo.TextColor := TextColor;
    FEditViewInfo.PaintEx(Canvas);
    Canvas.FrameRect(cxRectInflate(FMessageRect, -1, -1, -2, 0), SeparatorColor, 1, [bTop]);
  end;
  if ShowTimeLine then
  begin
   DrawState;
   DrawShadow;
   DrawSelection;
  end;
  ClippingRestore;
end;

procedure TcxSchedulerEventCellViewInfo.DrawSelection;
var
  R: TRect;
begin
  if not Hidden and ShowTimeLine and Selected then
  begin
    R := cxRectSetTop(Bounds, Bounds.Top - cxTimeLineWidth + 1, cxTimeLineWidth);
    Dec(R.Left, cxTimeLineWidth);
    PainterHelper.DrawState(Canvas, R, Event.State, cxBordersAll);
    R := cxRectSetTop(R, Bounds.Bottom - 1);
    PainterHelper.DrawState(Canvas, R, Event.State, cxBordersAll);
  end;
end;

procedure TcxSchedulerEventCellViewInfo.DrawShadow;
var
  R: TRect;
begin
  if (ViewData.DrawShadows) and (ViewData.Bitmap <> nil) and
    not Hidden and not Selected and ShowTimeLine then
  begin
    R := Bounds;
    PainterHelper.DrawShadow(Canvas, R, ViewData.VisibleRect, ViewData.Bitmap);
  end;
end;

procedure TcxSchedulerEventCellViewInfo.DrawState;
begin
  if Selected then
    PainterHelper.DrawState(Canvas, FTimeLineRect, Event.State, cxBordersAll)
  else
  begin
    Canvas.FillRect(FTimeLineRect, ViewData.TimeLineParams, cxBordersAll, clBlack);
    PainterHelper.DrawState(Canvas, FEventTimeRect, Event.State, [bLeft, bRight]);
  end;
end;

procedure TcxSchedulerEventCellViewInfo.DrawTime;
const
  RightJustify = cxAlignRight or cxAlignVCenter or cxSingleLine;
begin
  if not (ShowStartTime or ShowFinishTime) or
    (not ShowTimeAsClock and IsDetailInfo) then Exit;
  if ShowTimeAsClock then
  begin
    if ShowStartTime then
      PainterHelper.DrawClock(Canvas, FStartRect, Event.Start, FViewParams);
    if ShowFinishTime then
      PainterHelper.DrawClock(Canvas, FFinishRect, Event.Finish, FViewParams);
  end
  else
  begin
    DrawText(FStartRect, FStartText, RightJustify);
    DrawText(FFinishRect, FFinishText, RightJustify);
  end;
end;

function TcxSchedulerEventCellViewInfo.GetHitTest(
  AHitTest: TcxSchedulerCustomResourceViewHitTest; var ABreak: Boolean): Boolean;
begin
  Result := inherited GetHittest(AHitTest, ABreak);
  Result := Result and not Hidden;
  if Result and not Hidden and ShowTimeLine and Selected then
    ABreak := not PtInRect(ContentRect, AHitTest.HitPoint) and not
      PtInRect(MessageRect, AHitTest.HitPoint) 
  else
    ABreak := False;
end;

function TcxSchedulerEventCellViewInfo.GetEditingRect: TRect;
begin
  cxRectIntersect(Result,
    PainterHelper.ExcludeBorders(FBounds, Borders), FClipRect);
  if not IsDetailInfo and not IsHeaderEvent then
  begin
    if ShowStartTime then
      Result.Left := FContentRect.Left - cxTextOffset;
    Result := PainterHelper.ExcludeBorders(Result, cxBordersAll);
  end;
  if IsDetailInfo and not IsHeaderEvent then
    Inc(Result.Left, 3);
end;

procedure TcxSchedulerEventCellViewInfo.InitHitTest(
  AHitTest: TcxSchedulerCustomResourceViewHitTest);
begin
  AHitTest.FEventCell := Self;
  AHitTest.FEventBounds := FClipRect; 
  AHitTest.FDragKind := edkMoveEvent;
  AHitTest.FNeedShowHint := CanShowHint;
  if IsDetailInfo then
  begin
    if ShowTimeLine and PtInRect(FTimeLineRect, AHitTest.HitPoint) then
      AHitTest.FDragKind := edkEventDragRect
    else
    begin
      if (AHitTest.HitY - Bounds.Top) <= cxHitDelta then
        AHitTest.FDragKind := edkResizeStart
      else
      if (Bounds.Bottom - AHitTest.HitY) <= cxHitDelta then
        AHitTest.FDragKind := edkResizeEnd;
    end;
  end
  else
  begin
    if IsHeaderEvent then
    begin
      if (bLeft in Borders) and ((AHitTest.HitX - Bounds.Left) <= cxHitDelta) then
        AHitTest.FDragKind := edkResizeStart
      else
      if (bRight in Borders) and ((Bounds.Right - AHitTest.HitX) <= cxHitDelta) then
        AHitTest.FDragKind := edkResizeEnd;
    end
    else
      if (ShowStartTime and (AHitTest.HitX <= FStartRect.Right)) or
        (ShowFinishTime and (AHitTest.HitX <= FFinishRect.Right)) then
        AHitTest.FDragKind := edkEventDragRect
  end;
end;

function TcxSchedulerEventCellViewInfo.TruncTime(
  const ATime: TDateTime): TDateTime;
begin
  Result := DateTimeHelper.RoundTime(ATime);
end;

function TcxSchedulerEventCellViewInfo.GetContentFinish: TDateTime;
begin
  Result := ViewData.ContentFinish;
end;

function TcxSchedulerEventCellViewInfo.GetCaption: string;
begin
  Result := ViewData.Caption;
end;

function TcxSchedulerEventCellViewInfo.GetContentStart: TDateTime;
begin
  Result := ViewData.ContentStart;
end;

function TcxSchedulerEventCellViewInfo.GetEvent: TcxSchedulerControlEvent;
begin
  Result := ViewData.Event;
end;

function TcxSchedulerEventCellViewInfo.GetIsHeaderEvent: Boolean;
begin
  Result := Event.AllDayEvent or
    ((Event.Finish - Event.Start) >= 1);
end;

function TcxSchedulerEventCellViewInfo.GetMessage: string;
begin
  Result := Event.Message;
end;

function TcxSchedulerEventCellViewInfo.GetResourceInfo: TcxSchedulerResourceViewInfo;
begin
  Result := ViewData.Resource;
end;

function TcxSchedulerEventCellViewInfo.GetResourceItem: TcxSchedulerStorageResourceItem;
begin
  Result := nil;
  if ResourceInfo <> nil then
    Result := ResourceInfo.ResourceItem;
end;

function TcxSchedulerEventCellViewInfo.GetSelected: Boolean;
begin
  Result := Event.Selected;
end;

function TcxSchedulerEventCellViewInfo.GetShowingState(
  AIndex: Integer): Boolean;
begin
  case AIndex of
    0:
      Result := ViewData.ShowBell;
    1:
      Result := ViewData.ShowFinishTime;
    2:
      Result := ViewData.ShowStartTime;
    3:
      Result := ViewData.ShowTimeAsClock;
    4:
      Result := ViewData.ShowTimeLine;
  else
    Result := False;
  end;
end;

function TcxSchedulerEventCellViewInfo.SetItemRect(AShowItem: Boolean;
  const ABounds: TRect; var APos: Integer): TRect;
begin
  Result := cxNullRect;
  if AShowItem then
  begin
    if ((APos + cxRectWidth(ABounds)) <= cxRectCenter(FBounds).X) then
    begin
      Result := cxRectOffset(ABounds, APos, FContentRect.Top);
      APos := Result.Right + cxTextOffset;
    end;
  end
end;

{ TcxSchedulerMoreEventsButtonViewInfo }

procedure TcxSchedulerMoreEventsButtonViewInfo.Click;
begin
  if Assigned(FOnClick) then
    FOnClick(Self);
end;

procedure TcxSchedulerMoreEventsButtonViewInfo.DoDraw;
begin
  MoreEventButtonGlyphs.DrawingStyle := dsTransparent;
  MoreEventButtonGlyphs.Draw(Canvas.Canvas, Bounds.Left, Bounds.Top, Byte(not IsDown));
end;

procedure TcxSchedulerMoreEventsButtonViewInfo.InitHitTest(
  AHitTest: TcxSchedulerCustomResourceViewHitTest);
begin
  inherited InitHitTest(AHitTest);
  AHitTest.SetBitState(htcButton, True);
  AHitTest.FButton := Self;
  if Int(DateTime) > 0 then
    AHitTest.SetHitTime(htcTime, Int(DateTime));
end;

{ TcxSchedulerGroupSeparatorCellViewInfo }

destructor TcxSchedulerGroupSeparatorCellViewInfo.Destroy;
begin
  FreeAndNil(FRotateBitmap);
  inherited Destroy;
end;

procedure TcxSchedulerGroupSeparatorCellViewInfo.DoDraw;

  procedure CreateRotatedBitmap;
  begin
    with Bounds do
      FRotateBitmap := cxCreateTrueColorBitmap(Right - Left, Bottom - Top);
    FRotateBitmap.PixelFormat := pf32bit;
    FRotateBitmap.Canvas.Lock;
  end;

var
  ABitmapCanvas: TcxCanvas;
begin
  if not Rotated then
    Painter.DrawHeader(Canvas, Bounds, Bounds, [nRight, nLeft], cxBordersAll, cxbsNormal,
      taLeftJustify, vaCenter, False, False, '', nil, clNone, Color, DrawBackground)
  else
  begin
    if FRotateBitmap = nil then
    begin
      CreateRotatedBitmap;
      ABitmapCanvas := TcxCanvas.Create(FRotateBitmap.Canvas);
      try
        ABitmapCanvas.WindowOrg := Bounds.TopLeft;
        FDrawRotatedBackground := DrawBackground(ABitmapCanvas, Bounds);

        RotateBitmap(FRotateBitmap, raPlus90, True);

        Painter.DrawHeader(ABitmapCanvas, Rect(0, 0, FRotateBitmap.Width,
          FRotateBitmap.Height), cxNullRect, [nRight, nLeft], cxBordersAll,
          cxbsNormal, taCenter, vaCenter, False, False, '', nil, clNone, Color,
          DrawRotateBackground);

        RotateBitmap(FRotateBitmap, raPlus90, True);
      finally
        FRotateBitmap.Canvas.Unlock;
        ABitmapCanvas.Free;
      end;
    end;
    Canvas.Draw(Bounds.Left, Bounds.Top, FRotateBitmap);
  end;
end;

procedure TcxSchedulerGroupSeparatorCellViewInfo.InitHitTest(
  AHitTest: TcxSchedulerCustomResourceViewHitTest);
begin
  AHitTest.SetBitState(htcGroupSeparator, True);
end;

function TcxSchedulerGroupSeparatorCellViewInfo.DrawRotateBackground(
  ACanvas: TcxCanvas; const ABounds: TRect): Boolean;
begin
  Result := FDrawRotatedBackground;
end;

{ TcxSchedulerResourceViewInfo }

constructor TcxSchedulerResourceViewInfo.Create(
  AResource: TcxSchedulerStorageResourceItem);
begin
  FResourceItem := AResource;
  FColor := AResource.Color;
  FResourceID := AResource.ResourceID;
  FCaption := AResource.Resources.GetResourceName(FResourceItem);
end;

{ TcxSchedulerCustomResourceView }

constructor TcxSchedulerCustomResourceView.Create(
  AOwner: TcxCustomScheduler);
begin
  inherited Create(AOwner);
  FShowEndTime := True;
end;

procedure TcxSchedulerCustomResourceView.Assign(Source: TPersistent);
begin
  if Source is TcxSchedulerCustomResourceView then
  begin
    ShowEndTime := TcxSchedulerCustomResourceView(Source).ShowEndTime;
    ShowTimeAsClock := TcxSchedulerCustomResourceView(Source).ShowTimeAsClock;
    FGroupingKind := TcxSchedulerCustomResourceView(Source).GroupingKind;
  end;
  inherited Assign(Source);  
end;

procedure TcxSchedulerCustomResourceView.CalculateViewInfo;
begin
  Adapter.Calculate;
end;

procedure TcxSchedulerCustomResourceView.CheckGroupingKind(
  AStyle: TcxSchedulerGroupingKind; var ActuallyStyle: TcxSchedulerGroupingKind);
begin
  ActuallyStyle := AStyle;
end;

function TcxSchedulerCustomResourceView.CreateController: TcxSchedulerSubControlController;
begin
  Result := TcxSchedulerCustomResourceViewController.Create(Self);
end;

function TcxSchedulerCustomResourceView.CreateHitTest: TcxSchedulerSubControlHitTest;
begin
  Result := TcxSchedulerCustomResourceViewHitTest.Create(Self);
end;

function TcxSchedulerCustomResourceView.CreateViewAdapter: TcxCustomResourceViewAdapter;
begin
  Result := TcxCustomResourceViewAdapter.Create(Self);
end;

procedure TcxSchedulerCustomResourceView.CreateSubClasses;
begin
  inherited CreateSubClasses;
  FAdapter := CreateViewAdapter;
  ViewInfo.FAdapter := FAdapter;
end;

procedure TcxSchedulerCustomResourceView.DestroySubClasses;
var
  Adapter: TObject;
begin
  Adapter := ViewInfo.FAdapter;
  inherited DestroySubClasses;
  Adapter.Free;
end;

procedure TcxSchedulerCustomResourceView.DoCustomDrawBackground(
  AViewInfo: TcxSchedulerBackgroundCellViewInfo; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawBackground) then
    FOnCustomDrawBackground(Self, Canvas, AViewInfo, ADone);
end;

procedure TcxSchedulerCustomResourceView.DoCustomDrawButton(
  AViewInfo: TcxSchedulerMoreEventsButtonViewInfo; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawButton) then
    FOnCustomDrawButton(Self, Canvas, AViewInfo, ADone);
end;

procedure TcxSchedulerCustomResourceView.DoCustomDrawContent(
  AViewInfo: TcxSchedulerContentCellViewInfo; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawContent) then
    FOnCustomDrawContent(Self, Canvas, AViewInfo, ADone);
end;

procedure TcxSchedulerCustomResourceView.DoCustomDrawDayHeader(
  AViewInfo: TcxSchedulerDayHeaderCellViewInfo; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawDayHeader) then
    FOnCustomDrawDayHeader(Self, Canvas, AViewInfo, ADone);
end;

procedure TcxSchedulerCustomResourceView.DoCustomDrawEvent(
  AViewInfo: TcxSchedulerEventCellViewInfo; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawEvent) then
    FOnCustomDrawEvent(Self, Canvas, AViewInfo, ADone);
end;

procedure TcxSchedulerCustomResourceView.DoCustomDrawGroupSeparator(
  AViewInfo: TcxSchedulerGroupSeparatorCellViewInfo; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawGroupSeparator) then
    FOnCustomDrawGroupSeparator(Self, Canvas, AViewInfo, ADone);
end;

procedure TcxSchedulerCustomResourceView.DoCustomDrawResourceHeader(
  AViewInfo: TcxSchedulerHeaderCellViewInfo; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawResourceHeader) then
    FOnCustomDrawResourceHeader(Self, Canvas, AViewInfo, ADone);
end;

procedure TcxSchedulerCustomResourceView.DoLayoutChanged;
begin
  inherited DoLayoutChanged;
end;

function TcxSchedulerCustomResourceView.DoShowPopupMenu(X, Y: Integer): Boolean;
begin
  if HitTest.HitAtEvent then
    Result := not Controller.IsEditing and Scheduler.EventPopupMenu.Popup(X, Y)
  else
    Result := Scheduler.ContentPopupMenu.Popup(X, Y)
end;

function TcxSchedulerCustomResourceView.FindEventViewInfo(AEvent: TcxSchedulerEvent;
  const ADate: TDateTime; AResource: TcxSchedulerStorageResourceItem;
  var AViewInfo: TcxSchedulerEventCellViewInfo): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to ViewInfo.EventCells.Count - 1 do
  begin
    AViewInfo := TcxSchedulerEventCellViewInfo(ViewInfo.EventCells[I]);
    if AViewInfo.Event = AEvent then
    begin
      Result := True;
      with AViewInfo do 
      begin
        if (AResource = nil) or (ResourceItem = AResource) then
          if (ADate = NullDate) or ((DateOf(ContentStart) = ADate) or (IsHeaderEvent and
            (ADate >= DateOf(ContentStart)) and (ADate < DateOf(ContentFinish)))) then Break;
      end;
    end;
  end;
end;

function TcxSchedulerCustomResourceView.GetCommonViewItemsPainter: IcxSchedulerCommonViewItemsPainter;
begin
  if not Supports(TObject(Scheduler), IcxSchedulerCommonViewItemsPainter, Result) then
    Result := nil;
end;

function TcxSchedulerCustomResourceView.GetCompressWeekEnd: Boolean;
begin
  Result := False; 
end;

function TcxSchedulerCustomResourceView.GetEditRectForEvent(
  AEvent: TcxSchedulerControlEvent; const ADate: TDateTime;
  AResource: TcxSchedulerStorageResourceItem): TRect;
var
  AViewInfo: TcxSchedulerEventCellViewInfo;
begin
  if FindEventViewInfo(AEvent, ADate, AResource, AViewInfo) then
    Result := AViewInfo.EditingRect
  else
    Result := inherited GetEditRectForEvent(AEvent, ADate, AResource);
end;

procedure TcxSchedulerCustomResourceView.InitScrollBarsParameters;
begin
  ViewInfo.InitScrollBarsParameters;
end;

function TcxSchedulerCustomResourceView.GetEventVisibility(
  AEvent: TcxSchedulerControlEvent): Boolean;
var
  AViewInfo: TcxSchedulerEventCellViewInfo;
begin
  Result := FindEventViewInfo(AEvent, NullDate, nil, AViewInfo)
end;

function TcxSchedulerCustomResourceView.GetGroupingKind: TcxSchedulerGroupingKind;
begin
  Result := GroupingKind;
  if Result = gkDefault then
    Result := OptionsView.GroupingKind;
end;

function TcxSchedulerCustomResourceView.IsShowResources: Boolean;
var
  AKind: TcxSchedulerGroupingKind;
begin
  Result := inherited IsShowResources;
  if Result then
  begin
    AKind := GroupingKind;
    if AKind = gkDefault then
      AKind := OptionsView.GroupingKind;
    Result := AKind <> gkNone;
  end;
end;

procedure TcxSchedulerCustomResourceView.Scroll(AScrollBarKind: TScrollBarKind;
  AScrollCode: TScrollCode; var AScrollPos: Integer);
begin
  if AScrollBarKind = sbHorizontal then
    ViewInfo.ScrollHorizontal(AScrollCode, AScrollPos)
  else
    ViewInfo.ScrollVertical(AScrollCode, AScrollPos);
  inherited Scroll(AScrollBarKind, AScrollCode, AScrollPos);
end;

function TcxSchedulerCustomResourceView.GetViewInfo: TcxSchedulerCustomResourceViewViewInfo;
begin
  Result := TcxSchedulerCustomResourceViewViewInfo(inherited ViewInfo);
end;

procedure TcxSchedulerCustomResourceView.SetGroupingKind(
  AValue: TcxSchedulerGroupingKind);
begin
  CheckGroupingKind(AValue, AValue);
  if (FGroupingKind <> AValue) then
  begin
    FGroupingKind := AValue;
    LayoutChanged;
  end;
end;

procedure TcxSchedulerCustomResourceView.SetShowEndTime(
  const AValue: Boolean);
begin
  if FShowEndTime <> AValue then
  begin
    FShowEndTime := AValue;
    LayoutChanged;
  end;
end;

procedure TcxSchedulerCustomResourceView.SetShowTimeAsClock(
  const AValue: Boolean);
begin
  if FShowTimeAsClock <> AValue then
  begin
    FShowTimeAsClock := AValue;
    LayoutChanged;
  end;
end;

  { TcxCustomResourceViewAdapter }

constructor TcxCustomResourceViewAdapter.Create(
  AView: TcxSchedulerCustomResourceView);
begin
  FView := AView;
end;

procedure TcxCustomResourceViewAdapter.Calculate;
var
  FPrevAdapter: TcxCustomResourceViewAdapter;
begin
  FPrevAdapter := FView.ViewInfo.SetAdapter(Self);
  FPrevAdapter.Store;
  try
    BeforeCalculatePage;
    FView.ViewInfo.Calculate;
    AfterCalculatePage;
  finally
    FView.ViewInfo.SetAdapter(FPrevAdapter);
    if FPrevAdapter <> Self then
    begin
      FPrevAdapter.Restore;
      FView.ViewInfo.Calculate;
    end;
    FView.ViewInfo.FStylesAdapter := nil;
  end;
end;

procedure TcxCustomResourceViewAdapter.GetPageResources(
  AResources: TcxObjectList);
var
  I: Integer;
begin
  if Resources = nil then Exit;
  for I := 0 to Resources.VisibleResourceCount - 1 do
  begin
    AResources.Add(TcxSchedulerResourceViewInfo.Create(
      Resources.VisibleResources[I]));
  end;
end;

procedure TcxCustomResourceViewAdapter.GetPageDays(
  APageIndex: Integer; ADays: TcxSchedulerDateList);
begin
end;

procedure TcxCustomResourceViewAdapter.Invalidate;
begin
end;

function TcxCustomResourceViewAdapter.CanCalculate: Boolean;
begin
  Result := View.Active;
end;

function TcxCustomResourceViewAdapter.GetCompressWeekends: Boolean;
begin
  Result := View.GetCompressWeekEnd;
end;

function TcxCustomResourceViewAdapter.GetDontPrintWeekEnds: Boolean;
begin
  Result := False; 
end;

function TcxCustomResourceViewAdapter.GetHideSelection: Boolean;
begin
  Result := View.OptionsView.HideSelection and not View.Scheduler.IsFocused;
end;

function TcxCustomResourceViewAdapter.GetPageBounds: TRect;
begin
  Result := View.ClientRect;
end;

function TcxCustomResourceViewAdapter.GetPagesPerWeek: Byte;
begin
  Result := 1;
end;

function TcxCustomResourceViewAdapter.GetPrimaryPage: Boolean;
begin
  Result := True;
end;

function TcxCustomResourceViewAdapter.GetPrintExactlyOneMonth: Boolean; 
begin
  Result := False;
end;

function TcxCustomResourceViewAdapter.GetPrintRange(
  Index: Integer): TDateTime;
begin
  Result := NullDate;
end;

function TcxCustomResourceViewAdapter.GetStylesAdapter: IcxSchedulerStylesAdapter;
begin
  Result := FView.Styles;
end;

function TcxCustomResourceViewAdapter.GetView: TcxSchedulerCustomResourceView;
begin
  Result := FView;
end;

procedure TcxCustomResourceViewAdapter.AfterCalculatePage;
begin
end;

procedure TcxCustomResourceViewAdapter.BeforeCalculatePage;
begin
end;

procedure TcxCustomResourceViewAdapter.DoInitialize(
  var ASelectedDays: TcxSchedulerDateList; var AEvents: TcxSchedulerCachedEventList);
begin
  ASelectedDays := View.Scheduler.SelectedDays;
  AEvents := ViewInfo.GetSchedulerEventsList;
end;

function TcxCustomResourceViewAdapter.GetPageHeaderText: string;
begin
  Result := ViewInfo.GetPageHeaderText;
end;

procedure TcxCustomResourceViewAdapter.Store;
begin
end;

procedure TcxCustomResourceViewAdapter.Restore;
begin
end;

function TcxCustomResourceViewAdapter.GetCells: TcxObjectList;
begin
  Result := ViewInfo.FCells;
end;

function TcxCustomResourceViewAdapter.GetContentLineHeight: Integer;
begin
  with ViewInfo do
  begin
    Result := Max(PainterHelper.IconsHeight + cxTextOffset,
      GetFontHeight(StylesAdapter.GetEventParams(nil)) + 2 * cxTextOffset);
  end;
end;

function TcxCustomResourceViewAdapter.GetPainterHelper: TcxSchedulerPainterHelperClass;
begin
  Result := TcxSchedulerHelpersFactory.PainterHelperClass;
end;

function TcxCustomResourceViewAdapter.GetResources: TcxSchedulerStorageResourceItems;
begin
  Result := View.Resources;
end;

function TcxCustomResourceViewAdapter.GetViewInfo: TcxSchedulerCustomResourceViewViewInfo;
begin
  Result := View.ViewInfo;
end;

{ TcxSchedulerCustomResourceViewViewInfo }

constructor TcxSchedulerCustomResourceViewViewInfo.Create(
  AOwner: TcxSchedulerSubControl);
begin
  inherited Create(AOwner);
  FCells := TcxObjectList.Create;
  FResources := TcxObjectList.Create;
  FGroupSeparatorCells := TcxSchedulerViewInfoCellList.Create;
  FButtons := TcxSchedulerViewInfoCellList.Create;
  FContentCells := TcxSchedulerViewInfoCellList.Create;
  FEventCells := TcxSchedulerViewInfoCellList.Create;
  FDayHeaderCells := TcxSchedulerViewInfoCellList.Create;
  FResourceHeaderCells := TcxSchedulerViewInfoCellList.Create;
  FHeaderContainerCells := TcxSchedulerViewInfoCellList.Create;
  FCells.Add(FEventCells);
  FCells.Add(FGroupSeparatorCells);
  FCells.Add(FDayHeaderCells);
  FCells.Add(FResourceHeaderCells);
  FCells.Add(FContentCells);
  FCells.Add(FHeaderContainerCells);
end;

destructor TcxSchedulerCustomResourceViewViewInfo.Destroy;
begin
  FResources.Free;
  FButtons.Free;
  FCells.Free;
  inherited Destroy;
end;

procedure TcxSchedulerCustomResourceViewViewInfo.Calculate;
begin
  FPrimaryPage := Adapter.GetPrimaryPage;
  Adapter.DoInitialize(FSelectedDays, FEvents);
  FHasVisibleBounds := GetHasVisibleBounds;
  FPrintWeekEnds := not Adapter.DontPrintWeekEnd;
  FPagesPerWeek := Adapter.PagesPerWeek;
  FPageBounds := Adapter.GetPageBounds;
  FCanSelected := not Adapter.GetHideSelection;
  inherited Calculate;
end;

procedure TcxSchedulerCustomResourceViewViewInfo.CalculateHitTest(
  AHitTest: TcxSchedulerCustomResourceViewHitTest);
begin
  FEventCells.CalculateHitTest(AHitTest);
  if not FDayHeaderCells.CalculateHitTest(AHitTest) then
    if not FResourceHeaderCells.CalculateHitTest(AHitTest) then
        if not FHeaderContainerCells.CalculateHitTest(AHitTest) then
          if not FButtons.CalculateHitTest(AHitTest) then
            FContentCells.CalculateHitTest(AHitTest);
  if AHitTest.HitAtButton and AHitTest.HitAtEvent then
  begin
    AHitTest.FHitObject := nil;
    AHitTest.FEventCell := nil;
  end;
end;

procedure TcxSchedulerCustomResourceViewViewInfo.InitScrollBarsParameters;
begin
end;

procedure TcxSchedulerCustomResourceViewViewInfo.ScrollHorizontal(
  AScrollCode: TScrollCode; var AScrollPos: Integer);
begin
end;

procedure TcxSchedulerCustomResourceViewViewInfo.ScrollVertical(
  AScrollCode: TScrollCode; var AScrollPos: Integer);
begin
end;

procedure TcxSchedulerCustomResourceViewViewInfo.SetEventsVisibility(
  AShowSources, AShowClones: Boolean; AForceRepaint: Boolean = False);
var
  ARepaint: Boolean;
begin
  ARepaint := AForceRepaint or (FHideSource <> not AShowSources) or
    (FHideClones <> not AShowClones);
  FHideSource := not AShowSources;
  FHideClones := not AShowClones;
  if ARepaint then View.Refresh;
end;

function TcxSchedulerCustomResourceViewViewInfo.AddButton(
  ABounds: TRect; const ADateTime: TDateTime; AResourceIndex: Integer;
  AIsDown: Boolean): TcxSchedulerMoreEventsButtonViewInfo;
begin
  ABounds := cxRectInflate(ABounds, -cxTextOffset, -cxTextOffset);
  ABounds.Left := ABounds.Right - PainterHelper.MoreButtonWidth;
  if AIsDown then
    ABounds.Top := ABounds.Bottom - PainterHelper.MoreButtonHeight
  else
    ABounds.Bottom := ABounds.Top + PainterHelper.MoreButtonHeight;
  if DateOf(ADateTime) = 0 then
    CreateCellInstance(TcxSchedulerMoreEventsButtonViewInfo, ABounds,
      Styles.GetBackgroundParams, Result)
  else
    CreateCellInstance(TcxSchedulerMoreEventsButtonViewInfo, ABounds,
      GetContentParams(ADateTime, nil), Result);
  Result.FIsDown := AIsDown;
  Result.FDateTime := ADateTime;
  Result.FOnClick := OnClickMoreButton;
  AssignResourceID(Result, AResourceIndex);
  FButtons.Add(Result);
end;

function TcxSchedulerCustomResourceViewViewInfo.AddBackgroundSlot(const ABounds: TRect;
  ABorders: TcxBorders; const AText: string = ''): TcxSchedulerBackgroundSlotCellViewInfo;
begin
  CreateCellInstance(TcxSchedulerBackgroundSlotCellViewInfo, ABounds,
    Styles.GetBackgroundParams, Result);
  Result.FBorders := ABorders;
  AssignResourceID(Result, -1);
  ContentCells.Add(Result);
end;

function TcxSchedulerCustomResourceViewViewInfo.AddContentCell(const ARect: TRect;
  const AStart, AFinish: TDateTime; AResourceIndex: Integer): TcxSchedulerContentCellViewInfo;
begin
  CreateCellInstance(ContentCellClass, ARect,
    GetContentParams(AStart, Resources[AResourceIndex]), Result);
  Result.SetTime(AStart, AFinish);
  AssignResourceID(Result, AResourceIndex);
  ContentCells.Add(Result);
end;

function TcxSchedulerCustomResourceViewViewInfo.AddDayHeader(
  const ADate: TDateTime; const ABounds: TRect;
  AResourceIndex: Integer): TcxSchedulerDayHeaderCellViewInfo;
begin
  CreateCellInstance(TcxSchedulerDayHeaderCellViewInfo, ABounds,
    StylesAdapter.GetDayHeaderParams(ADate), Result);
  Result.DateTime := ADate;
  AssignResourceID(Result, AResourceIndex);
  FDayHeaderCells.Add(Result);
end;

function TcxSchedulerCustomResourceViewViewInfo.AddDayHeader(
  const ADate: TDateTime; ATop, ALeft, ARight: Integer;
  AResourceIndex: Integer): TcxSchedulerDayHeaderCellViewInfo;
begin
  Result := AddDayHeader(ADate,
    cxRect(ALeft, ATop, ARight, ATop + FDayHeaderHeight), AResourceIndex);
end;

function TcxSchedulerCustomResourceViewViewInfo.AddEventCell(
  AViewData: TcxSchedulerEventViewData): TcxSchedulerEventCellViewInfo;
begin
  Result := TcxSchedulerEventCellViewInfo.Create(AViewData);
  EventCells.Add(Result);
end;

function TcxSchedulerCustomResourceViewViewInfo.AddGroupHorzSeparator(
  APos: Integer): TcxSchedulerGroupSeparatorCellViewInfo;
begin
  Result := AddGroupSeparator(cxRectSetTop(Bounds, APos, SeparatorWidth));
  if Result <> nil then
    Result.Rotated := True;
end;

function TcxSchedulerCustomResourceViewViewInfo.AddGroupSeparator(
  const ABounds: TRect): TcxSchedulerGroupSeparatorCellViewInfo;
begin
  Result := nil;
  if not HasSeparator then Exit;
  CreateCellInstance(TcxSchedulerGroupSeparatorCellViewInfo, ABounds,
    FGroupSeparatorParams, Result);
  GroupSeparatorCells.Add(Result);
end;

function TcxSchedulerCustomResourceViewViewInfo.AddGroupVertSeparator(
  APos: Integer): TcxSchedulerGroupSeparatorCellViewInfo;
begin
  Result := AddGroupSeparator(cxRectSetLeft(Bounds, APos, SeparatorWidth));
end;

function TcxSchedulerCustomResourceViewViewInfo.AddResourceHeader(
  const AIndex: Integer; const ABounds: TRect): TcxSchedulerHeaderCellViewInfo;
begin
  CreateCellInstance(TcxSchedulerHeaderCellViewInfo, ABounds,
    StylesAdapter.GetResourceHeaderParams(GetResourceItemByIndex(AIndex)), Result);
  if AIndex >= 0 then
  begin
    Result.FDisplayText := ResourceCaptions[AIndex];
    AssignResourceID(Result, AIndex);
  end;
  ResourceHeaderCells.Add(Result);
  Result.FIsResourceHeader := True;
end;

procedure TcxSchedulerCustomResourceViewViewInfo.AfterCalculate;
begin
  inherited AfterCalculate;
  if FHideClones then
    HideCloneEventsOnDragDrop;
  if FHideSource then
    HideSourceEventsOnDragDrop;
end;

procedure TcxSchedulerCustomResourceViewViewInfo.AssignResourceID(
  ACell: TcxSchedulerCustomResourceViewInfoItem; AIndex: Integer);
begin
  if AIndex >= 0 then
    ACell.Resource := Resources[AIndex];
  ACell.FIsResourceAssigned := AIndex >= 0;
end;

procedure TcxSchedulerCustomResourceViewViewInfo.CalculateMetrics;
begin
  FHideSelection := View.OptionsView.HideSelection and not View.Scheduler.IsFocused;
  FGroupSeparatorParams := Styles.GetGroupSeparatorParams;
  FTimeLineParams := GetTimeLineParams;
  FSelectionParams := Styles.GetSelectionParams;
  FContentLineHeight := Adapter.GetContentLineHeight;
  FDayHeaderHeight :=
    LookAndFeelPainter.HeaderHeight(GetFontHeight(StylesAdapter.GetDayHeaderStyle));
  FResourceHeaderHeight :=
    LookAndFeelPainter.HeaderHeight(GetFontHeight(StylesAdapter.GetResourceHeaderStyle));
end;

procedure TcxSchedulerCustomResourceViewViewInfo.Clear;
begin
  FResources.Clear;
  GroupSeparatorCells.Clear;
  Buttons.Clear;
  ContentCells.Clear;
  EventCells.Clear;
  DayHeaderCells.Clear;
  ResourceHeaderCells.Clear;
  HeaderContainerCells.Clear;
end;

function TcxSchedulerCustomResourceViewViewInfo.ContentCellClass: TcxSchedulerContentCellViewInfoClass;
begin
  Result := TcxSchedulerContentCellViewInfo
end;

procedure TcxSchedulerCustomResourceViewViewInfo.CreateCellInstance(
  AClass: TcxSchedulerCustomViewInfoItemClass; const ABounds: TRect;
  const AViewParams: TcxViewParams; var Instance);
begin
  CreateCellInstance(AClass, ABounds, Bounds, AViewParams, Instance);
end;

procedure TcxSchedulerCustomResourceViewViewInfo.CreateCellInstance(
  AClass: TcxSchedulerCustomViewInfoItemClass; const ABounds,
  AVisibleBounds: TRect; const AViewParams: TcxViewParams; var Instance);
begin
  Pointer(Instance) := AClass.Create(LookAndFeelPainter,
    ABounds, AVisibleBounds, AViewParams);
  TcxSchedulerCustomViewInfoItem(Instance).FDayBorderColor := FDayBorderColor;
end;

function TcxSchedulerCustomResourceViewViewInfo.CreateEventViewData(
  AEvent: TcxSchedulerControlEvent; const ABounds: TRect;
  const AStart, AFinish: TDateTime; AResource: TcxSchedulerResourceViewInfo): TcxSchedulerEventViewData;
var
  ALocation: string;
begin
  Result := TcxSchedulerEventViewData.Create;
  Result.ShowBell := True;
  Result.Bounds := ABounds;
  Result.VisibleRect := Bounds;
  Result.ContentStart := AStart;
{$IFNDEF DEBUGPAINT}
  Result.Bitmap := View.Bitmap;
{$ENDIF}  
  Result.ContentFinish := AFinish;
  Result.Event := AEvent;
  Result.ShowTimeAsClock := View.ShowTimeAsClock;
  Result.TimeLineParams := FTimeLineParams;
  Result.ShowFinishTime := View.ShowEndTime;
  Result.Painter := LookAndFeelPainter;
  Result.ViewParams := StylesAdapter.GetEventParams(AEvent);
  Result.EditProperties := View.GetEditProperties(AEvent);
  Result.EditStyle := View.GetEditStyle(AEvent);
  Result.Resource := AResource;
  Result.Caption := DoGetEventDisplayText(AEvent);
  ALocation := Trim(AEvent.Location);
  if ALocation <> '' then
    Result.Caption := Result.Caption + ' (' + ALocation + ')';
  Result.LineHeight := FContentLineHeight;
end;

procedure TcxSchedulerCustomResourceViewViewInfo.DoCalculate;
begin
  FDayBorderColor := View.OptionsView.DayBorderColor;
  if FDayBorderColor = clDefault then
    FDayBorderColor := clWindowText;
  ExtractResources;
  FGroupingKind := GetGroupingKind;
  if FGroupingKind = gkNone then
    FResources.Clear;
  if SelectedDays.Count = 0 then
    SelectedDays.Add(Date);
  with View.Controller.Navigation do
    Self.FSelResource := GetResourceViewInfoByItem(SelResource);
  if (FSelResource = nil) and (ResourceCount > 0) then
    FSelResource := Resources[0];
  CalculateMetrics;
  View.Controller.Navigation.CheckSelection;
  with View.Controller.Navigation do
  begin
    Self.FSelStart := DateTimeHelper.RoundTime(Min(SelStart, SelFinish));
    Self.FSelFinish := DateTimeHelper.RoundTime(Max(SelStart, SelFinish));
  end;
end;

procedure TcxSchedulerCustomResourceViewViewInfo.ExtractResources;
begin
  FResources.Clear;
  Adapter.GetPageResources(FResources);
end;

function TcxSchedulerCustomResourceViewViewInfo.GetBounds: TRect;
begin
  Result := FPageBounds;
end;

function TcxSchedulerCustomResourceViewViewInfo.GetContentParams(
  const ATime: TDateTime; AResource: TcxSchedulerResourceViewInfo): TcxViewParams;
begin
  if AResource = nil then
    Result := StylesAdapter.GetContentParams(ATime, nil)
  else
    Result := StylesAdapter.GetContentParams(ATime, AResource.ResourceItem)
end;

function TcxSchedulerCustomResourceViewViewInfo.GetDayHeaderHeight: Integer;
begin
  Result := FDayHeaderHeight; 
end;

function TcxSchedulerCustomResourceViewViewInfo.GetTimeLineParams: TcxViewParams;
begin
  Result := StylesAdapter.GetContentParams(NullDate, nil)
end;

function TcxSchedulerCustomResourceViewViewInfo.GetSelectionParams(
  const AParams: TcxViewParams): TcxViewParams;
begin
  Result := AParams;
  if View.Scheduler.Focused or not HideSelection then
  begin
    Result := FSelectionParams;
    Result.Bitmap := nil;
  end;
end;

function TcxSchedulerCustomResourceViewViewInfo.GetFontHeight(
  AStyle: TcxStyle): Integer;
begin
  if (AStyle = nil) or not (cxStyles.svFont in AStyle.AssignedValues) then
    Result := PainterHelper.TextHeight(DefaultFont)
  else
    Result := PainterHelper.TextHeight(AStyle.Font);
end;

function TcxSchedulerCustomResourceViewViewInfo.GetFontHeight(
  const AParams: TcxViewParams): Integer;
begin
  Result := PainterHelper.TextHeight(AParams.Font);
end;

function TcxSchedulerCustomResourceViewViewInfo.GetPageHeaderText: string;
begin
  Result := FormatDateTime(LongDateFormat, Days[0]);
  if Days[0] <> Days[DayCount - 1] then
    Result := Result + ' - ' + FormatDateTime(LongDateFormat, Days[DayCount - 1]);
end;

function TcxSchedulerCustomResourceViewViewInfo.GetResourceItemByIndex(
  AIndex: Integer): TcxSchedulerStorageResourceItem;
begin
  Result := nil;
  if AIndex >= 0 then
    Result := Resources[AIndex].ResourceItem;
end;

function TcxSchedulerCustomResourceViewViewInfo.GetResourceViewInfoByItem(
  AItem: TcxSchedulerStorageResourceItem): TcxSchedulerResourceViewInfo;
var
  I: Integer;
begin
  Result := nil; 
  for I := 0 to ResourceCount - 1 do
    if Resources[I].ResourceItem = AItem then
      Result := Resources[I];
end;

procedure TcxSchedulerCustomResourceViewViewInfo.ProcessCheckBorders(
  AList: TcxSchedulerViewInfoCellList; AHasCommonArea: Boolean;
  ANeighbors: TcxNeighbors = []; AExcludeBorders: TcxBorders = [];
  AAddBorders: TcxBorders = []);
var
  I: Integer;
  DrawCommonBorders: Boolean;
  ACell, APrevCell: TcxSchedulerHeaderCellViewInfo;
begin
  DrawCommonBorders :=
    LookAndFeelPainter.HeaderBorders([nLeft..nBottom]) = cxBordersAll;
  APrevCell := nil;
  for I := 0 to AList.Count - 1 do
  begin
    ACell := TcxSchedulerHeaderCellViewInfo(AList[I]);
    ACell.FNeighbors := [nLeft, nRight];
    if (I = 0) and not ACell.RotateHeader then
    begin
      Exclude(ACell.FNeighbors, nLeft);
      if AHasCommonArea then
        Include(ACell.FNeighbors, nBottom);
    end;
    ACell.FNeighbors := ACell.FNeighbors + ANeighbors;
    ACell.FBorders := LookAndFeelPainter.HeaderBorders(ACell.FNeighbors);
    if not DrawCommonBorders then
    begin
      ACell.CheckNeighbor(APrevCell);
      ACell.FBorders := ACell.FBorders - AExcludeBorders + AAddBorders;
    end;
    if I = (AList.Count - 1) then
    begin
      Exclude(ACell.FBorders, bRight);
      Exclude(ACell.FNeighbors, nRight);
    end; 
    APrevCell := ACell;
  end;
end;

function TcxSchedulerCustomResourceViewViewInfo.SetAdapter(
  Adapter: TcxCustomResourceViewAdapter): TcxCustomResourceViewAdapter;
begin
  Result := FAdapter;
  FAdapter := Adapter;
  FStylesAdapter := FAdapter.GetStylesAdapter;
end;

procedure TcxSchedulerCustomResourceViewViewInfo.ProcessDateToDisplayText(
  ArrangeByType: Boolean = False);
var
  I: Integer;
  AType: Integer;
begin
  AType := 0;
  for I := 0 to FDayHeaderCells.Count - 1 do
    AType := Max(TcxSchedulerDayHeaderCellViewInfo(
      FDayHeaderCells[I]).ConvertDateToDisplayText, AType);
  if ArrangeByType and (AType > 0) then
  begin
    for I := 0 to FDayHeaderCells.Count - 1 do
      TcxSchedulerDayHeaderCellViewInfo(
         FDayHeaderCells[I]).ConvertDateToDisplayText(AType);
  end;
end;

procedure TcxSchedulerCustomResourceViewViewInfo.HideCloneEventsOnDragDrop;
var
  I: Integer;
  AEventCell: TcxSchedulerEventCellViewInfo;
begin
  for I := 0 to EventCells.Count - 1 do
  begin
    AEventCell := TcxSchedulerEventCellViewInfo(EventCells[I]);
    if Events.Clones.IndexOf(AEventCell.Event) <> -1 then
      AEventCell.Hidden := True;
  end;
end;

procedure TcxSchedulerCustomResourceViewViewInfo.HideSourceEventsOnDragDrop;
var
  I, J: Integer;
  AEventCell: TcxSchedulerEventCellViewInfo;
begin
  for I := 0 to EventCells.Count - 1 do
  begin
    AEventCell := TcxSchedulerEventCellViewInfo(EventCells[I]);
    for J := 0 to Events.Clones.Count - 1 do
      if TcxSchedulerControlEvent(Events.Clones[J]).Source = AEventCell.Event then
      begin
        AEventCell.Hidden := True;
        Break;
      end;
  end;
end;

function TcxSchedulerCustomResourceViewViewInfo.IsTimeSelected(
  ATime: TDateTime; AResource: TObject): Boolean;
begin
  ATime := DateTimeHelper.RoundTime(ATime);
  Result := not HideSelection and ((AResource = FSelResource) and
    (ATime >= SelStart) and (ATime <= SelFinish));
  Result := Result and CanSelected; 
end;

procedure TcxSchedulerCustomResourceViewViewInfo.MakeTimeVisible(
  const ATime: TDateTime);
begin
end;

procedure TcxSchedulerCustomResourceViewViewInfo.OnClickMoreButton(
  Sender: TcxSchedulerMoreEventsButtonViewInfo);
begin
end;

function TcxSchedulerCustomResourceViewViewInfo.GetClones: TcxSchedulerEventList;
begin
  Result := View.EventList.Clones;
end;

function TcxSchedulerCustomResourceViewViewInfo.GetDay(AIndex: Integer): TDateTime;
begin
  Result := Integer(SelectedDays.List^[AIndex]);
end;

function TcxSchedulerCustomResourceViewViewInfo.GetDayCount: Integer;
begin
  Result := SelectedDays.Count;
end;

function TcxSchedulerCustomResourceViewViewInfo.GetShowEventsWithoutResource: Boolean;
begin
  Result := View.OptionsView.ShowEventsWithoutResource or (FGroupingKind = gkNone);
end;

function TcxSchedulerCustomResourceViewViewInfo.GetGroupByDate: Boolean;
begin
  Result := GroupingKind = gkByDate;
end;

function TcxSchedulerCustomResourceViewViewInfo.GetGroupByResource: Boolean;
begin
  Result := GroupingKind = gkByResource;
end;

function TcxSchedulerCustomResourceViewViewInfo.GetGroupingKind: TcxSchedulerGroupingKind;
begin
  Result := View.GroupingKind;
  if Result = gkDefault then
    Result := View.OptionsView.GroupingKind;
  if ResourceCount = 0 then
    Result := gkNone
  else
    if Result = gkDefault then
      Result := gkByResource;
end;

function TcxSchedulerCustomResourceViewViewInfo.GetHasSeparator: Boolean;
begin
  Result := (SeparatorWidth > 0) and (GroupingKind <> gkNone);
end;

function TcxSchedulerCustomResourceViewViewInfo.GetHasVisibleBounds: Boolean;
begin
  Result := (PrintFrom <> NullDate) and (PrintTo <> NullDate)
end;

function TcxSchedulerCustomResourceViewViewInfo.GetHiddenSelection: Boolean;
begin
  Result := View.Controller.IsEditing or (Events.Selection.Count > 0);
end;

function TcxSchedulerCustomResourceViewViewInfo.GetResource(
  AIndex: Integer): TcxSchedulerResourceViewInfo;
begin
  if AIndex < 0 then
    Result := nil
  else
    Result := TcxSchedulerResourceViewInfo(FResources[AIndex]);
end;

function TcxSchedulerCustomResourceViewViewInfo.GetResourceCaption(
  AIndex: Integer): string;
begin
  Result := Resources[AIndex].Caption;
end;

function TcxSchedulerCustomResourceViewViewInfo.GetResourceCount: Integer;
begin
  Result := FResources.Count;
end;

function TcxSchedulerCustomResourceViewViewInfo.GetPrintRange(
  Index: Integer): TDateTime;
begin
  Result := Adapter.GetPrintRange(Index)
end;

function TcxSchedulerCustomResourceViewViewInfo.GetSeparatorWidth: Integer;
begin
  Result := View.OptionsView.GroupSeparatorWidth;
end;

function TcxSchedulerCustomResourceViewViewInfo.GetView: TcxSchedulerCustomResourceView;
begin
  Result := TcxSchedulerCustomResourceView(Owner);
end;

{ TcxSchedulerCustomResourceViewNavigation }

procedure TcxSchedulerCustomResourceViewNavigation.ValidateSelection(
  var ASelStart, ASelFinish: TDateTime;
  var AResource: TcxSchedulerStorageResourceItem);
begin
  AResource := ResourceItem;
end;

function TcxSchedulerCustomResourceViewNavigation.GetNextResource(
  AGoToForward: Boolean): TcxSchedulerStorageResourceItem;
var
  AIndex: Integer;
begin
  Result := ResourceItem;
  AIndex := ViewInfo.FResources.IndexOf(ResourceObject) + Byte(AGoToForward) * 2 - 1;
  if (AIndex < 0) or (AIndex >= ViewInfo.FResources.Count) then Exit;
  Result := ViewInfo.GetResourceItemByIndex(AIndex);
end;

function TcxSchedulerCustomResourceViewNavigation.GetResourceItem: TcxSchedulerStorageResourceItem;
begin
  Result := nil;
  if ResourceObject <> nil then
    Result := ResourceObject.ResourceItem;
end;

function TcxSchedulerCustomResourceViewNavigation.GetResourceFromViewInfo(
  AInfo: TcxSchedulerResourceViewInfo): TcxSchedulerStorageResourceItem;
begin
  Result := nil;
  if AInfo <> nil then
    Result := AInfo.ResourceItem;
end;

function TcxSchedulerCustomResourceViewNavigation.RoundTime(
  const ADateTime: TDateTime): TDateTime;
begin
  Result := DateTimeHelper.RoundTime(ADateTime);
end;

function TcxSchedulerCustomResourceViewNavigation.GetIsFirstResource: Boolean;
begin
  Result := ViewInfo.FResources.IndexOf(ResourceObject) <= 0;
end;

function TcxSchedulerCustomResourceViewNavigation.GetIsLastResource: Boolean;
begin
  Result := ViewInfo.FResources.IndexOf(ResourceObject) =
    (ViewInfo.FResources.Count - 1);
end;

function TcxSchedulerCustomResourceViewNavigation.GetGroupingKind: TcxSchedulerGroupingKind;
begin
  Result := ViewInfo.FGroupingKind;
end;

function TcxSchedulerCustomResourceViewNavigation.GetResourceObject: TcxSchedulerResourceViewinfo;
begin
  Result := ViewInfo.FSelResource;
end;

function TcxSchedulerCustomResourceViewNavigation.GetViewInfo: TcxSchedulerCustomResourceViewViewInfo;
begin
  Result := TcxSchedulerCustomResourceView(View).ViewInfo;
end;

{ TcxSchedulerCustomResourceViewController }

function TcxSchedulerCustomResourceViewController.CreateNavigation: TcxSchedulerViewNavigation;
begin
  Result := TcxSchedulerCustomResourceViewNavigation.Create(View);
end;

function TcxSchedulerCustomResourceViewController.GetCursor(X, Y: Integer): TCursor;
begin
  with HitTest do
  begin
    case GetDragKind of
      edkEventDragRect:
        Result := crSchedulerSplitAll;
      edkResizeStart, edkResizeEnd:
        with Event do
          if AllDayEvent or (Duration >= 1) then
            Result := crSchedulerHorzResize
          else
            Result := crSchedulerVertResize;
    else
      Result := inherited GetCursor(X, Y);
    end;
  end;
end;

procedure TcxSchedulerCustomResourceViewController.MouseDown(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  with TcxSchedulerCustomResourceViewHitTest(HitTest) do
    if HitAtButton then Button.Click;
end;

{ TcxSchedulerCustomResourceViewHitTest }

function TcxSchedulerCustomResourceViewHitTest.GetDragKind: TcxEventDragKind;
begin
  ValidateDragKind;
  Result := FDragKind;
end;

function TcxSchedulerCustomResourceViewHitTest.CanMoveEvent(
  AEvent: TcxSchedulerControlEvent): Boolean;
var
  AResource: TcxSchedulerStorageResourceItem;
begin
  Result := Scheduler.EventOperations.Moving;
  if Result then
  begin
    AResource := AEvent.GetResourceItem;
    Result := (AResource = nil) or not AResource.ReadOnly;
  end;
end;

function TcxSchedulerCustomResourceViewHitTest.CanResizeEvent(
  AEvent: TcxSchedulerControlEvent): Boolean;
var
  AResource: TcxSchedulerStorageResourceItem;
begin
  Result := Scheduler.EventOperations.Sizing;
  if Result then
  begin
    AResource := AEvent.GetResourceItem;
    Result := (AResource = nil) or not AResource.ReadOnly;
  end;
end;

procedure TcxSchedulerCustomResourceViewHitTest.Clear;
begin
  FDragKind := edkNone;
  FEventCell := nil;
  FResource := nil;
  FHitObject := nil;
  inherited Clear;
end;

procedure TcxSchedulerCustomResourceViewHitTest.DoCalculate;
begin
  inherited DoCalculate;
  if HitAtControl then
    View.ViewInfo.CalculateHitTest(Self);
end;

function TcxSchedulerCustomResourceViewHitTest.GetHitEvent: TcxSchedulerControlEvent;
begin
  Result := inherited GetHitEvent;
  if FEventCell <> nil then
    Result := FEventCell.Event;
end;

procedure TcxSchedulerCustomResourceViewHitTest.SetHitTime(
  AItemFlag: Integer; const ATime: TDateTime);
begin
  SetBitState(AItemFlag, True);
  SetBitState(htcTime, True);
  FTime := ATime;
end;

procedure TcxSchedulerCustomResourceViewHitTest.SetResource(
  AResource: TcxSchedulerResourceViewInfo);
begin
  if AResource = nil then
    FResource := nil
  else
    FResource := AResource.ResourceItem;
end;

procedure TcxSchedulerCustomResourceViewHitTest.ValidateDragKind;
begin
  if (Event = nil) or ((FDragKind in [edkEventDragRect, edkMoveEvent]) and not CanMoveEvent(Event)) or
     ((FDragKind in [edkResizeStart, edkResizeEnd]) and not CanResizeEvent(Event)) then
    FDragKind := edkNone;
end;

function TcxSchedulerCustomResourceViewHitTest.GetContentCell: TcxSchedulerContentCellViewInfo;
begin
  if HitAtContent then
    Result := TcxSchedulerContentCellViewInfo(FHitObject)
  else
    Result := nil;
end;

function TcxSchedulerCustomResourceViewHitTest.GetHeaderCell: TcxSchedulerHeaderCellViewInfo;
begin
  if HitAtDayHeader or HitAtResourceHeader then
    Result := TcxSchedulerHeaderCellViewInfo(FHitObject)
  else
    Result := nil;
end;

function TcxSchedulerCustomResourceViewHitTest.GetView: TcxSchedulerCustomResourceView;
begin
  Result := TcxSchedulerCustomResourceView(inherited Owner);
end;

{ TcxSchedulerCustomViewPainter }

constructor TcxSchedulerCustomViewPainter.Create(
  AOwner: TcxSchedulerSubControl);
begin
  inherited Create(AOwner);
  FPainter := View.GetCommonViewItemsPainter;
end;

procedure TcxSchedulerCustomViewPainter.Paint;
begin
end;

procedure TcxSchedulerCustomViewPainter.DrawBackgroundCell(
  AItem: TcxSchedulerBackgroundCellViewInfo);
var
  ADone: Boolean;
begin
  if AItem = nil then Exit;
  ADone := False;
  AItem.BeforeCustomDraw(Canvas);
  if Painter <> nil then
    Painter.DoCustomDrawBackground(AItem, ADone);
  if not ADone then
    View.DoCustomDrawBackground(AItem, ADone);
  AItem.AfterCustomDraw(Canvas);
  if not ADone then
    AItem.Draw(Canvas);
end;

procedure TcxSchedulerCustomViewPainter.DrawButtonCell(
  AItem: TcxSchedulerCustomViewInfoItem; var ADone: Boolean);
begin
  if Painter <> nil then
    Painter.DoCustomDrawButton(TcxSchedulerMoreEventsButtonViewInfo(AItem), ADone);
  if not ADone then
    View.DoCustomDrawButton(TcxSchedulerMoreEventsButtonViewInfo(AItem), ADone);
end;

procedure TcxSchedulerCustomViewPainter.DrawContentCell(
  AItem: TcxSchedulerCustomViewInfoItem; var ADone: Boolean);
begin
  if Painter <> nil then
    Painter.DoCustomDrawContent(TcxSchedulerContentCellViewInfo(AItem), ADone);
  if not ADone then
    View.DoCustomDrawContent(TcxSchedulerContentCellViewInfo(AItem), ADone);
end;

procedure TcxSchedulerCustomViewPainter.DrawEventCell(
  AItem: TcxSchedulerCustomViewInfoItem; var ADone: Boolean);
begin
  with TcxSchedulerEventCellViewInfo(AItem) do
    if Hidden or not Visible then Exit; 
  if Painter <> nil then
    Painter.DoCustomDrawEvent(TcxSchedulerEventCellViewInfo(AItem), ADone);
  if not ADone then
    View.DoCustomDrawEvent(TcxSchedulerEventCellViewInfo(AItem), ADone);
end;

procedure TcxSchedulerCustomViewPainter.DrawHeaderCell(
  AItem: TcxSchedulerCustomViewInfoItem; var ADone: Boolean);
begin
  if Painter <> nil then
    Painter.DoCustomDrawDayHeader(TcxSchedulerDayHeaderCellViewInfo(AItem), ADone);
  if not ADone then
    View.DoCustomDrawDayHeader(TcxSchedulerDayHeaderCellViewInfo(AItem), ADone);
end;

procedure TcxSchedulerCustomViewPainter.DrawGroupSeparatorCell(
  AItem: TcxSchedulerCustomViewInfoItem; var ADone: Boolean);
begin
  if Painter <> nil then
    Painter.DoCustomDrawGroupSeparator(TcxSchedulerGroupSeparatorCellViewInfo(AItem), ADone);
  if not ADone then
    View.DoCustomDrawGroupSeparator(TcxSchedulerGroupSeparatorCellViewInfo(AItem), ADone);
end;

procedure TcxSchedulerCustomViewPainter.DrawResourceHeaderCell(
  AItem: TcxSchedulerCustomViewInfoItem; var ADone: Boolean);
begin
  if Painter <> nil then
    Painter.DoCustomDrawResourceHeader(TcxSchedulerHeaderCellViewInfo(AItem), ADone);
  if not ADone then
    View.DoCustomDrawResourceHeader(TcxSchedulerHeaderCellViewInfo(AItem), ADone);
end;

function TcxSchedulerCustomViewPainter.GetView: TcxSchedulerCustomResourceView;
begin
  Result := TcxSchedulerCustomResourceView(Owner);
end;

end.
