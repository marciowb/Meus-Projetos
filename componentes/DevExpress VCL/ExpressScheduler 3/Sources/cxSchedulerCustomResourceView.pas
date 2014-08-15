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
  Windows, Graphics, SysUtils, StdCtrls, Classes, Forms, Controls, Contnrs,
  DateUtils, Variants, Math, ImgList, Types,
  cxClasses, cxGraphics,
  cxGeometry, cxControls, cxStyles, cxEdit, cxContainer,
  cxSchedulerStorage, cxSchedulerUtils, cxSchedulerCustomControls, cxLookAndFeelPainters,
  cxDateUtils, cxEditUtils, cxSchedulerStrs, cxLookAndFeels;

const
  // default values
  cxTimeLineWidth: Integer = 7;
  cxEventImagesOffset = 1;
  cxEventBorderWidth = 1;

  cxHitDelta: Integer = 4;

  // hittest constants
  htcButton           = $3;
  htcContainer        = $4;
  htcTimeRuler        = $5;
  htcTimeZoneLabel    = $6;
  htcContent          = $7;
  htcDayHeader        = $8;
  htcGroupSeparator   = $9;
  htcResourceHeader   = $10;
  htcNavigationButton = $16;

type
  TcxSchedulerCustomViewInfoItem = class;
  TcxSchedulerCustomResourceViewViewInfo = class;
  TcxSchedulerCustomResourceViewHitTest = class;
  TcxSchedulerBackgroundCellViewInfo = class;
  TcxSchedulerContentCellViewInfo = class;
  TcxSchedulerDayHeaderCellViewInfo = class;
  TcxSchedulerEventCellViewInfo = class;
  TcxSchedulerExternalPainter = class;
  TcxSchedulerGroupSeparatorCellViewInfo = class;
  TcxSchedulerHeaderCellViewInfo = class;
  TcxSchedulerMoreEventsButtonViewInfo = class;
  TcxSchedulerResourceViewInfo = class;
  TcxCustomResourceViewAdapter = class;
  TcxSchedulerEventLayoutBuilder = class;
  TcxSchedulerEventImages = class;
  TcxSchedulerContentNavigationButtonViewInfo = class;
  TcxSchedulerCachedImage = class;

  TcxSchedulerContentNavigationButtonKind = (nbkPrevious, nbkNext);
  TcxSchedulerColumnPositionInResource = (cprIndefinite, cprFirst, cprLast, cprSingle);

  // custom draw event types definition

  TcxSchedulerCustomDrawBackgroundEvent = procedure(Sender: TObject; ACanvas: TcxCanvas;
    AViewInfo: TcxSchedulerBackgroundCellViewInfo; var ADone: Boolean) of object;

  TcxSchedulerCustomDrawButtonEvent = procedure(Sender: TObject; ACanvas: TcxCanvas;
    AViewInfo: TcxSchedulerMoreEventsButtonViewInfo; var ADone: Boolean) of object;

  TcxSchedulerCustomDrawDayHeaderEvent = procedure(Sender: TObject; ACanvas: TcxCanvas;
    AViewInfo: TcxSchedulerDayHeaderCellViewInfo; var ADone: Boolean) of object;

  TcxSchedulerCustomDrawNavigationButtonEvent = procedure(Sender: TObject; ACanvas: TcxCanvas;
    AViewInfo: TcxSchedulerContentNavigationButtonViewInfo; var ADone: Boolean) of object;

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
    procedure DoCustomDrawNavigationButton(
      AViewInfo: TcxSchedulerContentNavigationButtonViewInfo; var ADone: Boolean);
    procedure DoCustomDrawResourceHeader(
      AViewInfo: TcxSchedulerHeaderCellViewInfo; var ADone: Boolean);
    //cached paint
    function HasCustomDrawGroupSeparator: Boolean;
    function HasCustomDrawResourceHeader: Boolean;
  end;

  { IcxSchedulerEventImages }

  IcxSchedulerEventImages = interface
  ['{4C5A8F8B-5356-4D2B-9972-507A7D60954A}']
    procedure DoInitEventImages(AEvent: TcxSchedulerControlEvent;
      AImages: TcxSchedulerEventImages);
    function GetImages: TCustomImageList;
    function SupportEventImages: Boolean;
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
    FCache: TcxSchedulerCachedImage;
    function GetBitmap: TBitmap;
    function GetColor: TColor;
    function GetDateTimeHelper: TcxSchedulerDateTimeHelperClass;
    function GetHeight: Integer;
    function GetPainterHelper: TcxSchedulerPainterHelperClass;
    function GetTextColor: TColor;
    function GetWidth: Integer;
    procedure SetBitmap(AValue: TBitmap);
    procedure SetColor(AValue: TColor);
    procedure SetTextColor(AValue: TColor);
  protected
    FBackgroundDrawing: Boolean;
    FBorders: TcxBorders;
    FBounds: TRect;
    FCanvas: TcxCanvas;
    FClipRect: TRect;
    FClipRgn: TcxRegion;
    FClipRef: Integer;
    FDateTime: TDateTime;
    FDayBorderColor: TColor;
    FDisplayText: string;
    FExternalPainter: TcxSchedulerExternalPainter;
    FHasClipping: Boolean;
    FPainter: TcxCustomLookAndFeelPainterClass;
    FSavedClipRgn: TcxRegion;
    FTransparent: Boolean;
    FViewParams: TcxViewParams;
    FVisible: Boolean;
    procedure CalculateCellBounds(const ABounds, AVisibleRect: TRect);
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
    // custom draw support
    procedure AfterCustomDraw(ACanvas: TcxCanvas); virtual;
    procedure BeforeCustomDraw(ACanvas: TcxCanvas); virtual;
    procedure UpdateCachedImage(const AViewParams: TcxViewParams); virtual;


    property Cache: TcxSchedulerCachedImage read FCache write FCache;

    // class item settings
    property DateTimeHelper: TcxSchedulerDateTimeHelperClass read GetDateTimeHelper;
    property DisplayText: string read FDisplayText write FDisplayText;
    property PainterHelper: TcxSchedulerPainterHelperClass read GetPainterHelper;
    property ExternalPainter: TcxSchedulerExternalPainter read FExternalPainter;
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
    property Height: Integer read GetHeight;
    property Painter: TcxCustomLookAndFeelPainterClass read FPainter;
    property TextColor: TColor read GetTextColor write SetTextColor;
    property Transparent: Boolean read FTransparent write FTransparent;
    property ViewParams: TcxViewParams read FViewParams;
    property Visible: Boolean read FVisible;
    property Width: Integer read GetWidth;
  end;

  { TcxSchedulerBackgroundCellViewInfo }

  TcxSchedulerBackgroundCellViewInfo = class(TcxSchedulerCustomViewInfoItem)
  protected
    procedure DoDraw; override;
  end;

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
    DisplayBounds: TRect;
    FAlignHorz: TAlignment;
    FAlignVert: TcxAlignmentVert;
    FAutoHeight: Boolean;
    FButtonState: TcxButtonState;
    FDrawRotatedBackground: Boolean;
    FImageIndex: Integer;
    FImagePosition: TcxSchedulerHeaderImagePosition;
    FImages: TCustomImageList;
    FImageRectAssigned: Boolean;
    FImageRect: TRect;
    FIsResourceHeader: Boolean;
    FMultiLine: Boolean;
    FNeighbors: TcxNeighbors;
    FRotateBitmap: TcxBitmap;
    FRotateHeader: Boolean;
    FRotateText: Boolean;
    FSelected: Boolean;
    FSelectionBitmap: TcxBitmap;
    FSelectionColor: TColor;
    FSelectionRect: TRect;
    FSelectionTextColor: TColor;
    FShowEndEllipsis: Boolean;
    FTextRect: TRect;
    procedure CheckNeighbor(APrevCell: TcxSchedulerHeaderCellViewInfo);
    function CheckSelection: Boolean; virtual;
    procedure DoDraw; override;
    procedure DrawCaption(ACanvas: TcxCanvas = nil);
    procedure DrawHorizontalHeader; virtual;
    function DrawRotateBackground(ACanvas: TcxCanvas; const ABounds: TRect): Boolean; virtual;
    procedure DrawSelection; virtual;
    procedure DrawVerticalHeader; virtual;
    function GetTextOutcxFlags: Integer;
    function GetTextOutFlags: Integer;
    function HasImage: Boolean;
    procedure InitHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest); override;
    procedure TextOut(ACanvas: TcxCanvas; const AText: string; R: TRect);
    procedure ValidateSelection;
  public
    constructor Create(APainter: TcxCustomLookAndFeelPainterClass;
      const ABounds, AVisibleRect: TRect; const AViewParams: TcxViewParams); override;
    destructor Destroy; override;
    procedure Calculate(const AText: string); virtual;
    procedure CalculateImageLayout;

    property AlignHorz: TAlignment read FAlignHorz write FAlignHorz;
    property AlignVert: TcxAlignmentVert read FAlignVert write FAlignVert;
    property AutoHeight: Boolean read FAutoHeight;
    property DateTime: TDateTime read FDateTime write FDateTime;
    property ImageIndex: Integer read FImageIndex;
    property ImagePosition: TcxSchedulerHeaderImagePosition read FImagePosition;
    property ImageRect: TRect read FImageRect;
    property Images: TCustomImageList read FImages;
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
    function DrawBackground(ACanvas: TcxCanvas; const ABounds: TRect): Boolean; override;
    procedure DrawHorizontalHeader; override;
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
    FLastVisibleHour: Boolean;
    function GetBoundsRect(AType: Boolean): TRect;
    function GetDisplayText(AType: Boolean): string;
    function GetHasAdditionalTimeZone: Boolean;
  protected
    FAdditionalTimeZone: Integer;
    FAdditionalTimeZoneBiasDelta: Integer;
    FBounds: array[Boolean] of TRect;
    FDisplayTexts: array[Boolean] of string;
    FHour: Integer;
    FLargeFont: TFont;
    FLineCount: Integer;
    FShowMinutes: Boolean;
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
  public
    class function CalculateWidth(ATimeZoneCount, ALineCount: Integer; AFont1, AFont2: TFont): Integer;
    procedure Calculate(const ALabel1, ALabel2: string; ATimeZone, AAdditionalTimeZone: Integer;
      AAdditionalTimeZoneBiasDelta: Integer); overload; virtual;
    procedure Calculate(AHour, ALineCount: Integer; ATimeZone, AAdditionalTimeZone: Integer;
      ALargeFont: TFont; AAdditionalTimeZoneBiasDelta: Integer); overload; virtual;
    procedure SetBottom(AValue: Integer);

    property AdditionalTimeZone: Integer read FAdditionalTimeZone;
    property Bounds[ACurrentTimeZone: Boolean]: TRect read GetBoundsRect;
    property DisplayTexts[ACurrentTimeZone: Boolean]: string read GetDisplayText;
    property HasAdditionalTimeZone: Boolean read GetHasAdditionalTimeZone;
    property Hour: Integer read FHour;
    property LargeFont: TFont read FLargeFont;
    property LastVisibleHour: Boolean read FLastVisibleHour write FLastVisibleHour;
    property LineCount: Integer read FLineCount;
    property ShowMinutes: Boolean read FShowMinutes write FShowMinutes;
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
    function GetIsToday: Boolean;
    procedure SetSmallTextFont(AFont: TFont);
  protected
    FTextRect: TRect;
    FSmallFont: Boolean;
    FSmallFontCreated: Boolean;
    FSmallTextFont: TFont;
    procedure DoDraw; override;
    function GetLongDisplayText: string; virtual;
    property IsToday: Boolean read GetIsToday;
  public
    destructor Destroy; override;
    procedure SetContentState(AsDayOfMonth: Boolean; ASelected: Boolean;
      ATextHeight: Integer; const ASelectionParams: TcxViewParams);
    function UpdateSelection(ASelected: Boolean): Boolean;

    property DisplayText;
    property SmallFont: Boolean read FSmallFont;
    property SmallTextFont: TFont read FSmallTextFont write SetSmallTextFont;
    property Selected: Boolean read FSelected;
    property SelectionColor: TColor read FSelectionColor write FSelectionColor;
    property SelectionTextColor: TColor read FSelectionTextColor write FSelectionTextColor;
  end;

  TcxSchedulerEventImagesLayout = (eilAuto, eilHorizontal, eilVertical);

  { TcxSchedulerEventViewData }

  TcxSchedulerEventViewData = class
  public
    AlwaysShowTime: Boolean;
    AutoHeight: Boolean;
    Bitmap: TBitmap;
    BorderColor: TColor;
    Bounds: TRect;
    Canvas: TcxCanvas;
    Caption: string;
    ContentFinish: TDateTime;
    ContentStart: TDateTime;
    DrawAsProgress: Boolean;
    DrawShadows: Boolean;
    EditProperties: TcxCustomEditProperties;
    EditStyle: TcxCustomEditStyle;
    Event: TcxSchedulerControlEvent;
    ExternalPainter: TcxSchedulerExternalPainter;
    GetEventHint: function(AEvent: TcxSchedulerControlEvent): string of object;
    ImagesLayout: TcxSchedulerEventImagesLayout;
    LineHeight: Integer;
    MaxHeight: Integer;
    Painter: TcxCustomLookAndFeelPainterClass;
    Resource: TcxSchedulerResourceViewInfo;
    ShowAllDayEventsInContentArea: Boolean;
    ShowFinishTime: Boolean;
    ShowStartTime: Boolean;
    ShowTimeAsClock: Boolean;
    ShowTimeLine: Boolean;
    StartLine: Integer;
    TaskComplete: Integer;
    TaskStatus: TcxSchedulerEventTaskStatus;
    TimeLineParams: TcxViewParams;
    ViewParams: TcxViewParams;
    VisibleRect: TRect;
  end;

  { TcxSchedulerEventCellViewInfo }

  TcxSchedulerEventCellViewInfo = class(TcxSchedulerCustomViewInfoItem)
  private
    FEventFinish: TDateTime;
    FEventStart: TDateTime;
    FIsHeaderEvent: Boolean;
    function CalculateMessageHeight(const R: TRect): Integer;
    function GetBorderColor: TColor;
    function GetCaption: string;
    function GetCaptionBounds(const R: TRect): TRect;
    function GetContentFinish: TDateTime;
    function GetContentStart: TDateTime;
    function GetEvent: TcxSchedulerControlEvent;
    function GetHint: string;
    function GetIsHeaderEvent: Boolean;
    function GetMessage: string;
    function GetResourceInfo: TcxSchedulerResourceViewInfo;
    function GetResourceItem: TcxSchedulerStorageResourceItem;
    function GetSelected: Boolean;
    function GetShowingState(AIndex: Integer): Boolean;
    procedure SetBorderColor(AValue: TColor);
  protected
    FCaptionRect: TRect;
    FEditViewInfo: TcxCustomEditViewInfo;
    FFinishRect: TRect;
    FFinishText: string;
    FHidden: Boolean;
    FImages: TcxSchedulerEventImages;
    FMessageRect: TRect;
    FHint: string;
    FHintAssigned: Boolean;
    FHintNeeded: Boolean;
    FHintNeededCalculated: Boolean;
    FSeparatorColor: TColor;
    FShowMessage: Boolean;
    FStartRect: TRect;
    FStartText: string;
    FEventTimeRect: TRect;
    FTimeLineRect: TRect;
    FIsDetailCaption: Boolean;
    FIsDetailInfo: Boolean;
    ViewData: TcxSchedulerEventViewData;
    procedure AssignEditStyle(AEditStyle: TcxCustomEditStyle);
    procedure BeforeCustomDraw(ACanvas: TcxCanvas); override;
    procedure Calculate;
    procedure CalculateBorders; virtual;
    procedure CalculateCaptions; virtual;
    procedure CalculateDetailInfo; virtual;
    procedure CalculateNeedHint;
    procedure CalculateEditViewInfo;
    procedure CalculateShowTimeAsClock; virtual;
    //items layout

    function CalculateAutoLayoutImagesAutoHeight(AVisibleImages: TList): Integer;
    function CalculateHorizontalImagesAutoHeight: Integer;
    procedure CalculateMessageAutoLayout(var AHeight: Integer);
    function CalculateVerticalImagesAutoHeight: Integer;

    procedure CalculateItemsLayout; virtual;
    procedure CalculateDetailViewEventLayout;
    procedure CalculateHeaderEventLayout;
    procedure CalculateNonDetailEventLayout;
    procedure CalculateEventTimeAsClockLayout(const ABounds: TRect;
      const ACaptionWidth, AImagesWidth: Integer; var ALeft: Integer); virtual;
    procedure CalculateEventTimeAsTextLayout(const ABounds: TRect;
      const ACaptionWidth, AImagesWidth: Integer; var ALeft: Integer); virtual;
    function CalculateNonDetailEventImages(const ACaptionWidth: Integer;
      out AImagesWidth: Integer): TRect; virtual;
    function CalculateSingleLineImages(const ABounds: TRect; ARightLimit: Integer = 0): Integer;
    function SetItemRect(AShowItem: Boolean; const ABounds: TRect;
      AVertOffset: Integer; var APos: Integer): TRect;
    //time visibility
    procedure CalculateEventTimeVisibility; virtual;
    procedure CalculateDetailEventTimeVisibility; virtual;
    procedure CalculateNonDetailEventTimeVisibility; virtual;
    procedure CalculateVisibility; virtual;
    function CanAutoHideStandardImages: Boolean; virtual;
    function CanShowHint: Boolean; virtual;

    procedure DoDraw; override;
    procedure DrawCaption;
    procedure DrawContent; virtual;
    procedure DrawImages;
    procedure DrawMessageSeparator;
    procedure DrawTime;
    function GetCaptionAutoHeight(const R: TRect): Integer;
    function GetEditingRect: TRect; virtual;
    function GetForceShowClockInHeaderEvent: Boolean; virtual;
    function GetHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest; var ABreak: Boolean): Boolean; override;
    function GetImagesBounds: TRect;
    function GetImagesVerticalOffset(AImageHeight: Integer; AIsAbsolute: Boolean): Integer;
    function GetMessageRect(const ACaptionRect: TRect; AHasImages: Boolean): TRect;
    function HasReminder: Boolean; virtual;
    procedure Initialize; virtual;
    //hittest
    procedure InitHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest); override;
    procedure InitHitTestForHorzEvent(AHitTest: TcxSchedulerCustomResourceViewHitTest);

    procedure InitStandardEventImages;
    function IsHorzSizing: Boolean; virtual;
    function IsNeedDrawTime: Boolean; virtual;
    function IsTimeLineVisible: Boolean; virtual;
    function TruncTime(const ATime: TDateTime): TDateTime;

    property EventFinish: TDateTime read FEventFinish;
    property EventStart: TDateTime read FEventStart;
    property IsHeaderEvent: Boolean read FIsHeaderEvent;
    property IsDetailCaption: Boolean read FIsDetailCaption;
  public
    constructor Create(AViewData: TcxSchedulerEventViewData); reintroduce; virtual;
    destructor Destroy; override;

    procedure Draw(ACanvas: TcxCanvas; ABitmap: TBitmap); reintroduce; overload;
    procedure DrawState(ACanvas: TcxCanvas; const ARect: TRect; ABorders: TcxBorders; ABorderColor: TColor); overload;
    function MeasureHeight(ACanvas: TcxCanvas): Integer; virtual;
    procedure MoveTo(X, Y: Integer); virtual;

    property BorderColor: TColor read GetBorderColor write SetBorderColor;
    property Caption: string read GetCaption;
    property CaptionRect: TRect read FCaptionRect;
    property ClipRect: TRect read FClipRect;
    property ClipRgn: TcxRegion read FClipRgn write FClipRgn;
    property ContentFinish: TDateTime read GetContentFinish;
    property ContentStart: TDateTime read GetContentStart;
    property EditingRect: TRect read GetEditingRect;
    property EditViewInfo: TcxCustomEditViewInfo read FEditViewInfo;
    property Event: TcxSchedulerControlEvent read GetEvent;
    property EventTimeRect: TRect read FEventTimeRect;
    property EventViewData: TcxSchedulerEventViewData read ViewData;
    property FinishRect: TRect read FFinishRect;
    property FinishText: string read FFinishText;
    property Hidden: Boolean read FHidden write FHidden;
    property Hint: string read GetHint;
    property Images: TcxSchedulerEventImages read FImages;
    property IsDetailInfo: Boolean read FIsDetailInfo;
    property Message: string read GetMessage;
    property MessageRect: TRect read FMessageRect;
    property ResourceInfo: TcxSchedulerResourceViewInfo read GetResourceInfo;
    property ResourceItem: TcxSchedulerStorageResourceItem read GetResourceItem;
    property Selected: Boolean read GetSelected;
    property SeparatorColor: TColor read FSeparatorColor write FSeparatorColor;
    property ShowFinishTime: Boolean index 0 read GetShowingState;
    property ShowMessage: Boolean read FShowMessage;
    property ShowStartTime: Boolean index 1 read GetShowingState;
    property ShowTimeAsClock: Boolean index 2 read GetShowingState;
    property ShowTimeLine: Boolean index 3 read GetShowingState;
    property StartRect: TRect read FStartRect;
    property StartText: string read FStartText;
    property TimeLineRect: TRect read FTimeLineRect write FTimeLineRect;
    property Visible: Boolean read FVisible;
  end;

  { TcxSchedulerMoreEventsButtonViewInfo }

  TcxSchedulerMoreEventsButtonClick = procedure (Sender: TcxSchedulerMoreEventsButtonViewInfo) of object;

  TcxSchedulerMoreEventsButtonViewInfoClass = class of TcxSchedulerMoreEventsButtonViewInfo;

  TcxSchedulerMoreEventsButtonViewInfo = class(TcxSchedulerCustomResourceViewInfoItem)
  protected
    FEvent: TcxSchedulerEvent;
    FIsDown: Boolean;
    FOnClick: TcxSchedulerMoreEventsButtonClick;
    procedure DoDraw; override;
    procedure InitHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest); override;
    property OnClick: TcxSchedulerMoreEventsButtonClick read FOnClick write FOnClick;
  public
    procedure Click; virtual;

    property Event: TcxSchedulerEvent read FEvent write FEvent;
    property IsDown: Boolean read FIsDown;
    property DateTime;
    property Resource;
  end;

  { TcxSchedulerContentNavigationButtonViewInfo }

  TcxSchedulerContentNavigationButtonClick = procedure (Sender: TcxSchedulerContentNavigationButtonViewInfo) of object;

  TcxSchedulerContentNavigationButtonViewInfo = class(TcxSchedulerCustomResourceViewInfoItem)
  private
    FArrowRect: TRect;
    FCaption: string;
    FHitTest: TcxSchedulerCustomResourceViewHitTest;
    FInterval: TDateTime;
    FKind: TcxSchedulerContentNavigationButtonKind;
    FOnClick: TcxSchedulerContentNavigationButtonClick;
    FTextRect: TRect;
    function GetEnabled: Boolean;
  protected
    procedure DoDraw; override;
    procedure InitHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest); override;
    property Enabled: Boolean read GetEnabled;
    property OnClick: TcxSchedulerContentNavigationButtonClick read FOnClick write FOnClick;
  public
    procedure Click; virtual;
    property ArrowRect: TRect read FArrowRect;
    property Caption: string read FCaption write FCaption;
    property Interval: TDateTime read FInterval write FInterval;
    property Kind: TcxSchedulerContentNavigationButtonKind read FKind write FKind;
    property TextRect: TRect read FTextRect;
  end;

  { TcxSchedulerGroupSeparatorCellViewInfo }

  TcxSchedulerGroupSeparatorCellViewInfo = class(TcxSchedulerCustomViewInfoItem)
  private
    FDrawRotatedBackground: Boolean;
    FRotated: Boolean;
    function DrawRotateBackground(ACanvas: TcxCanvas; const ABounds: TRect): Boolean;
  protected
    FRotateBitmap: TcxBitmap;
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
    FImageIndex: Integer;
    FImagePosition: TcxSchedulerHeaderImagePosition;
    FImages: TCustomImageList;
    FResourceID: Variant;
    FResourceItem: TcxSchedulerStorageResourceItem;
    FTextRect: TRect;
    FVisibleEventCount: Integer;
  public
    constructor Create(AResource: TcxSchedulerStorageResourceItem); virtual;

    property Caption: string read FCaption;
    property Color: TColor read FColor;
    property ImageIndex: Integer read FImageIndex;
    property ImagePosition: TcxSchedulerHeaderImagePosition read FImagePosition;
    property Images: TCustomImageList read FImages;
    property ResourceID: Variant read FResourceID;
    property ResourceItem: TcxSchedulerStorageResourceItem read FResourceItem;
    property TextRect: TRect read FTextRect write FTextRect;
    property VisibleEventCount: Integer read FVisibleEventCount write FVisibleEventCount;
  end;

  { TcxSchedulerExternalPainter }

  TcxSchedulerExternalPainter = class(TInterfacedObject, IcxSchedulerCommonViewItemsPainter)
  private
    FCommonPainter: IcxSchedulerCommonViewItemsPainter;
    FPainter: TcxCustomLookAndFeelPainterClass;
    function GetPainterHelper: TcxSchedulerPainterHelperClass;
  protected
    property PainterHelper: TcxSchedulerPainterHelperClass read GetPainterHelper;
  public
    // IcxSchedulerCommonViewItemsPainter
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
    procedure DoCustomDrawNavigationButton(
      AViewInfo: TcxSchedulerContentNavigationButtonViewInfo; var ADone: Boolean); virtual;
    procedure DoCustomDrawResourceHeader(
      AViewInfo: TcxSchedulerHeaderCellViewInfo; var ADone: Boolean); virtual;
    function HasCustomDrawGroupSeparator: Boolean;
    function HasCustomDrawResourceHeader: Boolean;
    //
    function NeedDrawSelection: Boolean; virtual;
    function DrawCurrentTimeFirst: Boolean; virtual;
    //
    procedure DrawAllDayArea(ACanvas: TcxCanvas; const ARect: TRect;
      ABorderColor: TColor; ABorders: TcxBorders; AViewParams: TcxViewParams;
      ASelected: Boolean; ATransparent: Boolean); virtual;
    procedure DrawCurrentTime(ACanvas: TcxCanvas; AColor: TColor; AStart: TDateTime;
      ABounds: TRect); virtual;
    procedure DrawEvent(AViewInfo: TcxSchedulerEventCellViewInfo); virtual;
    procedure DrawEventAsProgress(AViewInfo: TcxSchedulerEventCellViewInfo); virtual;
    procedure DrawEventAsProgressText(AViewInfo: TcxSchedulerEventCellViewInfo;
      AContent: TRect; AProgressRect: TRect; const AText: string); virtual;
    procedure DrawTimeGridCurrentTime(ACanvas: TcxCanvas; AColor: TColor;
      const ATimeLineRect: TRect); virtual;
    procedure DrawTimeGridHeader(ACanvas: TcxCanvas; ABorderColor: TColor;
      AViewInfo: TcxSchedulerCustomViewInfoItem; ABorders: TcxBorders;
      ASelected: Boolean); virtual;
    procedure DrawTimeLine(ACanvas: TcxCanvas; const ARect: TRect;
      AViewParams: TcxViewParams; ABorders: TcxBorders;
      ABorderColor: TColor); virtual;
    procedure DrawTimeRulerBackground(ACanvas: TcxCanvas; const ARect: TRect;
      ABorders: TcxBorders; AViewParams: TcxViewParams; ATransparent: Boolean); virtual;
    procedure DrawShadow(ACanvas: TcxCanvas; const ARect, AVisibleRect: TRect;
      ABuffer: TBitmap); virtual;
    function MoreButtonSize(ASize: TSize): TSize; virtual;
    property Painter: TcxCustomLookAndFeelPainterClass read FPainter write FPainter;
    property CommonPainter: IcxSchedulerCommonViewItemsPainter read FCommonPainter write FCommonPainter;
  end;

  TcxSchedulerExternalPainterClass = class of TcxSchedulerExternalPainter;

  { TcxSchedulerCustomResourceView }

  TcxSchedulerCustomResourceView = class(TcxSchedulerCustomView)
  private
    FAdapter: TcxCustomResourceViewAdapter;
    FExternalPainter: TcxSchedulerExternalPainter;
    FGroupingKind: TcxSchedulerGroupingKind;
    FEventImagesLayout: TcxSchedulerEventImagesLayout;
    FShowEndTime: Boolean;
    FShowTimeAsClock: Boolean;
    FOnCustomDrawBackground: TcxSchedulerCustomDrawBackgroundEvent;
    FOnCustomDrawButton: TcxSchedulerCustomDrawButtonEvent;
    FOnCustomDrawContent: TcxSchedulerCustomDrawContentEvent;
    FOnCustomDrawDayHeader: TcxSchedulerCustomDrawDayHeaderEvent;
    FOnCustomDrawEvent: TcxSchedulerCustomDrawEventEvent;
    FOnCustomDrawGroupSeparator: TcxSchedulerCustomDrawGroupSeparatorEvent;
    FOnCustomDrawNavigationButton: TcxSchedulerCustomDrawNavigationButtonEvent;
    FOnCustomDrawResourceHeader: TcxSchedulerCustomDrawResourceHeaderEvent;
    procedure CheckSelectOnRightClick;
    function GetViewInfo: TcxSchedulerCustomResourceViewViewInfo;
    function IsRelevantSelection(out ATime: TDateTime; out AResource: TcxSchedulerStorageResourceItem): Boolean;
    procedure SetEventImagesLayout(const AValue: TcxSchedulerEventImagesLayout);
    procedure SetShowEndTime(const AValue: Boolean);
    procedure SetShowTimeAsClock(const AValue: Boolean);
  protected
    procedure CalculateViewInfo; override;
    procedure CheckGroupingKind(AStyle: TcxSchedulerGroupingKind;
      var ActuallyStyle: TcxSchedulerGroupingKind); virtual;
    procedure ClearCachedData; override;
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
    procedure DoCustomDrawNavigationButton(
      AViewInfo: TcxSchedulerContentNavigationButtonViewInfo; var ADone: Boolean); virtual;
    procedure DoCustomDrawResourceHeader(
      AViewInfo: TcxSchedulerHeaderCellViewInfo; var ADone: Boolean); virtual;
    procedure DoLayoutChanged; override;
    procedure DoMouseDown(AButton: TMouseButton; AShift: TShiftState; X, Y: Integer); override;
    function DoShowPopupMenu(X, Y: Integer): Boolean; override;
    function FindEventViewInfo(AEvent: TcxSchedulerEvent; const ADate: TDateTime;
      AResource: TcxSchedulerStorageResourceItem; var AViewInfo: TcxSchedulerEventCellViewInfo): Boolean;
    function GetCommonViewItemsPainter: IcxSchedulerCommonViewItemsPainter; virtual;
    function GetCompressWeekEnd: Boolean; virtual;
    function GetEditRectForEvent(AEvent: TcxSchedulerControlEvent; const ADate: TDateTime;
      AResource: TcxSchedulerStorageResourceItem): TRect; override;
    function GetEventHintText(AEvent: TcxSchedulerControlEvent): string; override;
    function GetEventVisibility(AEvent: TcxSchedulerControlEvent): Boolean; override;
    function GetGroupingKind: TcxSchedulerGroupingKind; override;
    function HasCustomDrawGroupSeparator: Boolean;
    function HasCustomDrawResourceHeader: Boolean;
    procedure InitScrollBarsParameters; override;
    function IsShowResources: Boolean; override;
    procedure LookAndFeelChanged(Sender: TcxLookAndFeel; AChangedValues: TcxLookAndFeelValues); override;
    procedure Scroll(AScrollBarKind: TScrollBarKind;
      AScrollCode: TScrollCode; var AScrollPos: Integer); override;
    procedure SetGroupingKind(AValue: TcxSchedulerGroupingKind); virtual;

    property Adapter: TcxCustomResourceViewAdapter read FAdapter write FAdapter;
    property EventImagesLayout: TcxSchedulerEventImagesLayout read FEventImagesLayout write SetEventImagesLayout;
    property ExternalPainter: TcxSchedulerExternalPainter read FExternalPainter;
    property ShowEndTime: Boolean read FShowEndTime write SetShowEndTime default True;
    property ShowTimeAsClock: Boolean read FShowTimeAsClock write SetShowTimeAsClock default False;
    property ViewInfo: TcxSchedulerCustomResourceViewViewInfo read GetViewInfo;

    property OnCustomDrawBackground: TcxSchedulerCustomDrawBackgroundEvent read FOnCustomDrawBackground write FOnCustomDrawBackground;
    property OnCustomDrawButton: TcxSchedulerCustomDrawButtonEvent read FOnCustomDrawButton write FOnCustomDrawButton;
    property OnCustomDrawContent: TcxSchedulerCustomDrawContentEvent read FOnCustomDrawContent write FOnCustomDrawContent;
    property OnCustomDrawDayHeader: TcxSchedulerCustomDrawDayHeaderEvent read FOnCustomDrawDayHeader write FOnCustomDrawDayHeader;
    property OnCustomDrawEvent: TcxSchedulerCustomDrawEventEvent read FOnCustomDrawEvent write FOnCustomDrawEvent;
    property OnCustomDrawGroupSeparator: TcxSchedulerCustomDrawGroupSeparatorEvent read FOnCustomDrawGroupSeparator write FOnCustomDrawGroupSeparator;
    property OnCustomDrawNavigationButton: TcxSchedulerCustomDrawNavigationButtonEvent read FOnCustomDrawNavigationButton write FOnCustomDrawNavigationButton;
    property OnCustomDrawResourceHeader: TcxSchedulerCustomDrawResourceHeaderEvent read FOnCustomDrawResourceHeader write FOnCustomDrawResourceHeader;
  public
    constructor Create(AOwner: TcxCustomScheduler); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure InitializePainter; virtual;
    procedure FinilizePainter; virtual;

    property GroupingKind: TcxSchedulerGroupingKind read FGroupingKind write SetGroupingKind default gkDefault;
  end;

  { TcxCustomResourceViewAdapter }

  TcxCustomResourceViewAdapter = class(TcxIUnknownObject)
  private
    FView: TcxSchedulerCustomResourceView;

    function GetCells: TcxObjectList;
    function GetContentLineHeight: Integer;
    function GetPainterHelper: TcxSchedulerPainterHelperClass;
    function GetResourceNavigator: TcxSchedulerResourceNavigator;
    function GetResources: TcxSchedulerStorageResourceItems;
    function GetScheduler: TcxCustomScheduler;
    function GetViewInfo: TcxSchedulerCustomResourceViewViewInfo;

  protected
    function CanCalculate: Boolean; virtual;
    function GetActualStart: TDateTime; virtual;
    function GetActualFinish: TDateTime; virtual;
    function GetCompressWeekends: Boolean; virtual;
    function GetDontPrintFreeTime: Boolean; virtual;
    function GetDontPrintWeekEnds: Boolean; virtual;
    function GetHideSelection: Boolean; virtual;
    function GetIsPrinting: Boolean; virtual;
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

    property Scheduler: TcxCustomScheduler read GetScheduler;
    property PainterHelper: TcxSchedulerPainterHelperClass read GetPainterHelper;
    property ResourceNavigator: TcxSchedulerResourceNavigator read GetResourceNavigator;
    property ViewInfo: TcxSchedulerCustomResourceViewViewInfo read GetViewInfo;
  public
    constructor Create(AView: TcxSchedulerCustomResourceView); virtual;

    procedure Calculate; overload;

    procedure GetPageResources(AResources: TcxObjectList); virtual;
    procedure GetPageDays(APageIndex: Integer; ADays: TcxSchedulerDateList);
    procedure Invalidate; virtual;

    property ActualStart: TDateTime read GetActualStart;
    property ActualFinish: TDateTime read GetActualFinish;
    property Cells: TcxObjectList read GetCells;
    property ContentLineHeight: Integer read GetContentLineHeight;
    property DontPrintFreeTime: Boolean read GetDontPrintFreeTime;
    property DontPrintWeekEnd: Boolean read GetDontPrintWeekEnds;
    property IsPrinting: Boolean read GetIsPrinting;
    property PagesPerWeek: Byte read GetPagesPerWeek;
    property PrintExactlyOneMonth: Boolean read GetPrintExactlyOneMonth;
    property PrintFrom: TDateTime index 0 read GetPrintRange;
    property PrintTo: TDateTime index 1 read GetPrintRange;
    property Resources: TcxSchedulerStorageResourceItems read GetResources;
    property StylesAdapter: IcxSchedulerStylesAdapter read GetStylesAdapter;
    property View: TcxSchedulerCustomResourceView read GetView write FView;
  end;

  TcxCustomResourceViewAdapterClass = class of TcxCustomResourceViewAdapter;

  { TcxSchedulerEventImages }

  TcxSchedulerEventImageType = (eitReminder, eitRecurrence, eitCustomOccurrence, eitCustom);

  { TcxSchedulerEventImageItem }

  TcxSchedulerEventImageItem = class(TCollectionItem)
  private
    FAutoHide: Boolean;
    FImageType: TcxSchedulerEventImageType;
    FImageIndex: Integer;
    FImages: TCustomImageList;
    FVisible: Boolean;
    function GetHeight: Integer;
    function GetWidth: Integer;
  protected
    FBounds: TRect;
    FHidden: Boolean;
  public
    constructor Create(Collection: TCollection); override;

    property AutoHide: Boolean read FAutoHide write FAutoHide;
    property Bounds: TRect read FBounds;
    property Height: Integer read GetHeight;
    property ImageIndex: Integer read FImageIndex;
    property ImageType: TcxSchedulerEventImageType read FImageType;
    property Images: TCustomImageList read FImages;
    property Visible: Boolean read FVisible write FVisible;
    property Width: Integer read GetWidth;
  end;

  { TcxSchedulerEventImages }

  TcxSchedulerEventImages = class(TCollection)
  private
    FForceVisibleHeight: Integer;
    FForceVisibleWidth: Integer;
    FImages: TCustomImageList;
    FLayout: TcxSchedulerEventImagesLayout;
    FItemHeight: Integer;
    FItemWidth: Integer;
    FTotalVisibleHeight: Integer;
    FTotalVisibleWidth: Integer;
    FTotalVisibleImageCount: Integer;
    FVisibleImageCount: Integer;
    function GetImageItem(AIndex: Integer): TcxSchedulerEventImageItem;
  protected
    function Calculate(const R: TRect): Integer;
    procedure CalculateForCols(AVisibleImages: TList; const ATopLeft: TPoint; AColCount: Integer);
    function CalculateImages(const R: TRect): Integer;
    function CalculateSingleColumnImages(const R: TRect): Integer;
    function CalculateSingleLineImages(const R: TRect; ARightLimit: Integer = 0): Integer;
    function Offset(ADeltaX, ADeltaY: Integer): Integer;
    function CreateVisibleList: TList;
    procedure Init(AImages: TCustomImageList);
    procedure SetItemBounds(AItem: TcxSchedulerEventImageItem; ALeft, ATop: Integer);

    property ItemHeight: Integer read FItemHeight;
    property ItemWidth: Integer read FItemWidth;
    property ForceVisibleHeight: Integer read FForceVisibleHeight;
    property ForceVisibleWidth: Integer read FForceVisibleWidth;
    property TotalVisibleHeight: Integer read FTotalVisibleHeight;
    property TotalVisibleWidth: Integer read FTotalVisibleWidth;
    property TotalVisibleImageCount: Integer read FTotalVisibleImageCount;
    property VisibleImageCount: Integer read FVisibleImageCount;
  public
    constructor Create(ALayout: TcxSchedulerEventImagesLayout);
    function Add(AImageIndex: Integer; AutoHide: Boolean = True): TcxSchedulerEventImageItem;
    function AddStandardImage(AImageType: TcxSchedulerEventImageType;
      AutoHide: Boolean = True): TcxSchedulerEventImageItem;

    property Items[Index: Integer]: TcxSchedulerEventImageItem read GetImageItem; default;
    property Layout: TcxSchedulerEventImagesLayout read FLayout write FLayout;
  end;

  { TcxSchedulerCachedImage }

  TcxSchedulerCachedImage = class
  private
    FImage: TcxBitmap;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Invalidate;
    function IsValid(AItem: TcxSchedulerCustomViewInfoItem): Boolean; virtual;
    procedure Update(AItem: TcxSchedulerCustomViewInfoItem); virtual;

    property Image: TcxBitmap read FImage;
  end;

  { TcxSchedulerResourceHeaderCachedImage }

  TcxSchedulerResourceHeaderCachedImage = class(TcxSchedulerCachedImage)
  private
    FDisplayText: string;
    FDateTime: TDateTime;
    FResourceItem: TcxSchedulerStorageResourceItem;
  public
    function IsValid(AItem: TcxSchedulerCustomViewInfoItem): Boolean; override;
    procedure Update(AItem: TcxSchedulerCustomViewInfoItem); override;
  end;

  { TcxSchedulerResourceHeaderCachedImageList }

  TcxSchedulerResourceHeaderCachedImageList = class(TcxObjectList)
  public
    function Add(AItem: TcxSchedulerHeaderCellViewInfo): TcxSchedulerResourceHeaderCachedImage;
    function GetCacheForItem(AItem: TcxSchedulerHeaderCellViewInfo): TcxSchedulerResourceHeaderCachedImage;
  end;

  { TcxSchedulerImageCacheManager }

  TcxSchedulerImageCacheManager = class
  private
    FResourceHeaders:  TcxSchedulerResourceHeaderCachedImageList;
    FSeparator: TcxSchedulerCachedImage;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Invalidate; virtual;

    property ResourceHeaders: TcxSchedulerResourceHeaderCachedImageList read FResourceHeaders;
    property Separator: TcxSchedulerCachedImage read FSeparator;
  end;

  { TcxSchedulerCustomResourceViewViewInfo }

  TcxSchedulerCustomResourceViewViewInfo = class(TcxSchedulerCustomViewViewInfo,
    IcxMouseTrackingCaller
  )
  private
    FButtonBounds: TRect;
    FButtonTextRect: TRect;
    FButtonArrowRect: TRect;
    FContentNavigationIntervals: TObjectList;
    FContentNavigationWithoutResources: Boolean;
    FEventWithoutResourceCount: Integer;
    FImageCacheManager: TcxSchedulerImageCacheManager;
    FHotContentNavigationButton: TcxSchedulerContentNavigationButtonViewInfo;
    procedure AddContentNavigationIntervalItem(AResourceIndex: Variant);
    procedure ClearContentNavigationIntervals;
    function GetClones: TcxSchedulerEventList;
    function GetCorrectColumnHeight(AColumnRect: TRect): Integer;
    function GetDay(AIndex: Integer): TDateTime;
    function GetDayCount: Integer;
    function GetShowEventsWithoutResource: Boolean;
    function GetGroupByDate: Boolean;
    function GetGroupByResource: Boolean;
    function GetGroupingKind: TcxSchedulerGroupingKind;
    function GetHasSeparator: Boolean;
    function GetHasVisibleBounds: Boolean;
    function GetHiddenSelection: Boolean;
    function GetMinResourceHeight: Integer;
    function GetMoreEventsButtonCount(AResourceIndex: Integer): Integer;
    function GetResource(AIndex: Integer): TcxSchedulerResourceViewInfo;
    function GetResourceCaption(AIndex: Integer): string;
    function GetResourceCount: Integer;
    function GetResourceHeaders: TcxSchedulerResourceHeaders;
    function GetPrintRange(Index: Integer): TDateTime;
    function GetSeparatorWidth: Integer;
    function GetView: TcxSchedulerCustomResourceView;
    function IsDrawContentNavigationButtons: Boolean;
    procedure SetContentNavigationButtonsIntervals;
    procedure SetHitContentNavigationButton(AButton: TcxSchedulerContentNavigationButtonViewInfo;
      AHitTest: TcxSchedulerCustomResourceViewHitTest);
    procedure SetHotContentNavigationButton(AButton: TcxSchedulerContentNavigationButtonViewInfo);
  protected
    FAdapter: TcxCustomResourceViewAdapter;
    FButtons: TcxSchedulerViewInfoCellList;
    FCanSelected: Boolean;
    FCells: TcxObjectList;
    FContentCells: TcxSchedulerViewInfoCellList;
    FContentFontHeight: Integer;
    FContentLineHeight: Integer;
    FDayBorderColor: TColor;
    FDayHeaderCells: TcxSchedulerViewInfoCellList;
    FDayHeaderHeight: Integer;
    FEventCells: TcxSchedulerViewInfoCellList;
    FEventImages: IcxSchedulerEventImages;
    FGroupSeparatorCells: TcxSchedulerViewInfoCellList;
    FGroupSeparatorParams: TcxViewParams;
    FGroupingKind: TcxSchedulerGroupingKind;
    FHasVisibleBounds: Boolean;
    FHeaderContainerCells: TcxSchedulerViewInfoCellList;
    FHideClones: Boolean;
    FHideSelection: Boolean;
    FHideSource: Boolean;
    FNavigationButtons: TcxSchedulerViewInfoCellList;
    FResources: TcxObjectList;
    FResourceBounds: array of TRect;
    FResourceHeaderCells: TcxSchedulerViewInfoCellList;
    FResourceHeaderHeight: Integer;
    FResourceImages: TCustomImageList;
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
    FUseResourceImages: Boolean;
    ScreenCanvas: TcxCanvas;

    // IcxMouseTrackingCaller
    procedure MouseLeave; virtual;

    function AddBackgroundSlot(const ABounds: TRect; ABorders: TcxBorders;
      const AText: string = ''): TcxSchedulerBackgroundSlotCellViewInfo; virtual;
    function AddButton(ABounds: TRect; const ADateTime: TDateTime;
      AIsDown: Boolean; AEvent: TcxSchedulerEvent): TcxSchedulerMoreEventsButtonViewInfo; virtual;
    function AddContentCell(const ARect: TRect; const AStart, AFinish: TDateTime;
      AResourceIndex: Integer): TcxSchedulerContentCellViewInfo; virtual;
    procedure AddContentNavigationButton(const AColumnRect: TRect; AResourceIndex: Integer;
      AColumnPositionInResource: TcxSchedulerColumnPositionInResource);
    function AddDayHeader(const ADate: TDateTime; const ABounds: TRect;
      AResourceIndex: Integer): TcxSchedulerDayHeaderCellViewInfo; overload; virtual;
    function AddDayHeader(const ADate: TDateTime; ATop, ALeft, ARight: Integer;
      AResourceIndex: Integer): TcxSchedulerDayHeaderCellViewInfo; overload;
    function AddEventCell(
      AViewData: TcxSchedulerEventViewData; AImmediateCalculate: Boolean = True): TcxSchedulerEventCellViewInfo; virtual;
    function AddGroupHorzSeparator(APos: Integer): TcxSchedulerGroupSeparatorCellViewInfo; virtual;
    function AddGroupSeparator(const ABounds: TRect): TcxSchedulerGroupSeparatorCellViewInfo; virtual;
    function AddGroupVertSeparator(APos: Integer): TcxSchedulerGroupSeparatorCellViewInfo; virtual;
    procedure AddResourceBounds(AResourceIndex: Integer; const ABounds: TRect);
    function AddResourceHeader(const AIndex: Integer;
      const ABounds: TRect): TcxSchedulerHeaderCellViewInfo; virtual;
    procedure AfterCalculate; override;
    function AreThereEventsInVisibleInterval(AResourceIndex: Integer): Boolean;
    procedure AssignResourceID(ACell: TcxSchedulerCustomResourceViewInfoItem; AIndex: Integer);
    procedure CalculateContentNavigationButtons; virtual;
    procedure CalculateMetrics; virtual;
    procedure CalculateNavigationButtonParams(AColumnRect: TRect; AKind: TcxSchedulerContentNavigationButtonKind;
      out AButtonWidth: Integer);
    procedure CalculateResourceHeadersAutoHeight(AWidth: Integer); virtual;
    function CalculateResourceHeaderWidth: Integer; virtual;
    function CanCalculateNavigationButtons: Boolean; virtual;

    function CanCacheGroupSeparator(AItem: TcxSchedulerGroupSeparatorCellViewInfo): Boolean; virtual;
    function CanCacheResourceHeader(AItem: TcxSchedulerHeaderCellViewInfo): Boolean; virtual;

    procedure Clear; override;
    procedure ClearResourceBounds;
    function ContentCellClass: TcxSchedulerContentCellViewInfoClass; virtual;
    procedure CreateCellInstance(AClass: TcxSchedulerCustomViewInfoItemClass;
      const ABounds: TRect; const AViewParams: TcxViewParams; var Instance); overload;
    procedure CreateCellInstance(AClass: TcxSchedulerCustomViewInfoItemClass;
      const ABounds, AVisibleBounds: TRect; const AViewParams: TcxViewParams; var Instance); overload;
    function CreateEventViewData(AEvent: TcxSchedulerControlEvent; const ABounds: TRect;
      const AStart, AFinish: TDateTime; AResource: TcxSchedulerResourceViewInfo): TcxSchedulerEventViewData; virtual;
    function CreateEventCellViewInfo(AViewData: TcxSchedulerEventViewData): TcxSchedulerEventCellViewInfo; virtual;
    function CreateImageCacheManager: TcxSchedulerImageCacheManager; virtual;
    procedure DoCalculate; override;
    procedure DoContentNavigationButtonClick(Sender: TcxSchedulerContentNavigationButtonViewInfo); virtual;
    procedure DoMoreEventsButtonClick(Sender: TcxSchedulerMoreEventsButtonViewInfo); virtual;
    procedure ExtractResources; virtual;
    function GetBounds: TRect; override;
    function GetContentNavigationInterval(AContentNavigationButton: TcxSchedulerContentNavigationButtonViewInfo): TDateTime;
    function GetContentParams(const ATime: TDateTime;
      AResource: TcxSchedulerResourceViewInfo): TcxViewParams; virtual;
    function GetDayHeaderHeight: Integer; virtual;
    function GetEventForResourceCount(AResourceIndex: Integer; out AResourceID: Variant): Integer; virtual;
    function GetEventWithoutResourceCount: Integer; virtual;
    function GetMoreEventButtonClass: TcxSchedulerMoreEventsButtonViewInfoClass; virtual;
    function GetResourceHeaderWidth: Integer;
    function GetResourceImagesSize: TSize; virtual;
    function GetResourcesContentWidth: Integer; virtual;
    function GetSelectionParams(const AParams: TcxViewParams): TcxViewParams;
    function GetSeparatorCount: Integer; virtual;
    function GetTimeLineParams: TcxViewParams; virtual;
    function GetFontHeight(AStyle: TcxStyle): Integer; overload;
    function GetFontHeight(const AParams: TcxViewParams): Integer; overload;
    function GetPageHeaderText: string; virtual;
    function GetResourceItemByIndex(AIndex: Integer): TcxSchedulerStorageResourceItem;
    function GetResourceViewInfoByItem(AItem: TcxSchedulerStorageResourceItem;
      var ResourceViewInfoIndex: Integer): TcxSchedulerResourceViewInfo;
    function GetStartDate(Index: Integer): TDateTime; virtual;
    function HasStorage: Boolean;
    function HasVisibleEvents: Boolean; virtual;
    procedure HideCloneEventsOnDragDrop;
    procedure HideSourceEventsOnDragDrop;
    procedure HotTrackNavigationButtons(AHitTest: TcxSchedulerCustomResourceViewHitTest);
    function IsTimeSelected(ATime: TDateTime; AResource: TObject): Boolean; virtual;
    function IsValidNavigationButtonsPlace(const AResourceRect: TRect): Boolean;
    procedure MakeTimeVisible(const ATime: TDateTime); virtual;
    function NavigationButtonOffset(AKind: TcxSchedulerContentNavigationButtonKind;
      AResourceIndex: Integer): Integer; virtual;
    procedure OnContentNavigationButtonClick(Sender: TcxSchedulerContentNavigationButtonViewInfo);
    procedure OnMoreEventsButtonClick(Sender: TcxSchedulerMoreEventsButtonViewInfo);
    procedure ProcessDateToDisplayText(ArrangeByType: Boolean = False); virtual;
    procedure ProcessCheckBorders(AList: TcxSchedulerViewInfoCellList;
      AHasCommonArea: Boolean; ANeighbors: TcxNeighbors = [];
      AExcludeBorders: TcxBorders = []; AAddBorders: TcxBorders = []);
    procedure ReturnVisibleInterval(var AStart, AEnd: TDateTime); virtual;
    function SetAdapter(Adapter: TcxCustomResourceViewAdapter): TcxCustomResourceViewAdapter;
    procedure SetResourceHasVisibleEvent(AEvent: TcxSchedulerControlEvent);
    procedure SetResourceTextRect(AResource: TcxSchedulerStorageResourceItem; const ARect: TRect);

    property HotContentNavigationButton: TcxSchedulerContentNavigationButtonViewInfo
      read FHotContentNavigationButton write SetHotContentNavigationButton;
    property ImageCacheManager: TcxSchedulerImageCacheManager read FImageCacheManager;
    property StartDates[AnIndex: Integer]: TDateTime read GetStartDate;
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
    property NavigationButtons: TcxSchedulerViewInfoCellList read FNavigationButtons;
    property PagesPerWeek: Byte read FPagesPerWeek;
    property PrimaryPage: Boolean read FPrimaryPage;
    property PrintFrom: TDateTime index 0 read GetPrintRange;
    property PrintTo: TDateTime index 1 read GetPrintRange;
    property PrintWeekEnds: Boolean read FPrintWeekEnds;
    property Resources[AIndex: Integer]: TcxSchedulerResourceViewInfo read GetResource;
    property ResourceCaptions[AIndex: Integer]: string read GetResourceCaption;
    property ResourceCount: Integer read GetResourceCount;
    property ResourceHeaders: TcxSchedulerResourceHeaders read GetResourceHeaders;
    property ResourceHeaderCells: TcxSchedulerViewInfoCellList read FResourceHeaderCells;
    property ResourceHeaderHeight: Integer read FResourceHeaderHeight;
    property ResourceImages: TCustomImageList read FResourceImages;
    property SelFinish: TDateTime read FSelFinish;
    property SelResource: TcxSchedulerResourceViewInfo read FSelResource;
    property SelStart: TDateTime read FSelStart;
    property SeparatorWidth: Integer read GetSeparatorWidth;
    property StylesAdapter: IcxSchedulerStylesAdapter read FStylesAdapter;
    property HiddenSelection: Boolean read GetHiddenSelection;
    property UseResourceImages: Boolean read FUseResourceImages;
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
  private
    FCalculatedHintBounds: Boolean;
    FHintText: string;
    FNavigationButtonClicked: Boolean;
    function GetHintController: TcxSchedulerHintController;
    function GetHitTest: TcxSchedulerCustomResourceViewHitTest;
    function GetView: TcxSchedulerCustomResourceView;
  protected
    function CreateNavigation: TcxSchedulerViewNavigation; override;
    function GetCursor(X, Y: Integer): TCursor; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseLeave; override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    // hint
    function GetDayHeaderDate: TDateTime; virtual;
    procedure InternalHideHint;
    procedure InternalShowHint(P: TPoint; const AHintText: string);
    function NeedShowDayHeaderHint: Boolean; virtual;
    function ShowHint: Boolean; virtual;
    procedure ShowDayHeaderHint; virtual;

    property HintController: TcxSchedulerHintController read GetHintController;
    property HitTest: TcxSchedulerCustomResourceViewHitTest read GetHitTest;
    property NavigationButtonClicked: Boolean read FNavigationButtonClicked write FNavigationButtonClicked;
    property View: TcxSchedulerCustomResourceView read GetView;
  end;

  { TcxSchedulerCustomResourceViewHitTest }

  TcxSchedulerCustomResourceViewHitTest = class(TcxSchedulerViewHitTest)
  private
    function GetContentCell: TcxSchedulerContentCellViewInfo;
    function GetHitContentNavigationButton: TcxSchedulerContentNavigationButtonViewInfo;
    function GetHeaderCell: TcxSchedulerHeaderCellViewInfo;
    function GetView: TcxSchedulerCustomResourceView;
  protected
    FButton: TcxSchedulerMoreEventsButtonViewInfo;
    FContentNavigationButton: TcxSchedulerContentNavigationButtonViewInfo;
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
    property HitContentNavigationButton: TcxSchedulerContentNavigationButtonViewInfo read GetHitContentNavigationButton;
    property TimeZone: Integer read FTimeZone;
  public
    function GetDragKind: TcxEventDragKind; override;
    procedure SetDragKind(AValue: TcxEventDragKind);

    property Button: TcxSchedulerMoreEventsButtonViewInfo read FButton;
    property ContentCell: TcxSchedulerContentCellViewInfo read GetContentCell;
    property ContentNavigationButton: TcxSchedulerContentNavigationButtonViewInfo read FContentNavigationButton;
    property EventCell: TcxSchedulerEventCellViewInfo read FEventCell;
    property HeaderCell: TcxSchedulerHeaderCellViewInfo read GetHeaderCell;
    property HitAtButton: Boolean index htcButton read GetBitState;
    property HitAtContent: Boolean index htcContent read GetBitState;
    property HitAtContentNavigationButton: Boolean index htcNavigationButton read GetBitState;
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
    procedure InitializePainter; override;
    procedure Paint; override;

    property Painter: IcxSchedulerCommonViewItemsPainter read FPainter;
    property View: TcxSchedulerCustomResourceView read GetView;
  end;

  { TcxSchedulerEventPlace }

  TcxSchedulerEventPlace = class
  public
    ColFinish: Integer;
    ColStart: Integer;
    Resource: TObject;
    Data: TObject;
    Event: TcxSchedulerEvent;
    LineFinish: Integer;
    LineStart: Integer;
    procedure AlignPosition(APlace: TcxSchedulerEventPlace);
    function IntersectHorz(APlace: TcxSchedulerEventPlace): Boolean;
    function IntersectVert(APlace: TcxSchedulerEventPlace): Boolean;
    procedure LineStartToEvent;
    procedure ResetPosition;
  end;

  { TcxSchedulerEventLayoutBuilder }

  TcxSchedulerEventLayoutBuilderGetEventPlaceProc = function(Sender: TcxSchedulerEventLayoutBuilder;
    AEvent: TcxSchedulerControlEvent; out AStartCol, AFinishCol: Integer; out ALineCount: Integer): Boolean of object;

  TcxSchedulerEventLayoutBuilder = class
  private
    FEventPlaces: TcxObjectList;
    function GetEventPlace(AIndex: Integer): TcxSchedulerEventPlace;
    function GetEventPlaceCount: Integer;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function AddEventPlace(AEvent: TcxSchedulerEvent;
      AStartCol, AFinishCol: Integer; ALineCount: Integer = 1; AResource: TObject = nil): TcxSchedulerEventPlace;
    procedure Clear;
    procedure Calculate; virtual;
    procedure CalculateEx(AEventsList: TcxSchedulerFilteredEventList;
      APlaceInfoProc: TcxSchedulerEventLayoutBuilderGetEventPlaceProc);
    property EventPlaceCount: Integer read GetEventPlaceCount;
    property EventPlaces[Index: Integer]: TcxSchedulerEventPlace read GetEventPlace;
    property EventPlacesList: TcxObjectList read FEventPlaces;
  end;

var
  ExternalPainterClass: TcxSchedulerExternalPainterClass = TcxSchedulerExternalPainter;

function MakeTextOutcxFlags(AlignHorz: TAlignment;
  AlignVert: TcxAlignmentVert; AMultiline: Boolean = False): Integer;

implementation

uses
  cxDrawTextUtils, cxLibraryConsts, cxVariants, cxSchedulerDateNavigator, dxCore;

type
  TcxCustomEditStyleAccess = class(TcxCustomEditStyle);
  TcxCustomSchedulerAccess = class(TcxCustomScheduler);
  TcxDateNavigatorAccess = class(TcxSchedulerDateNavigator);
  TcxSchedulerControlEventAccess = class(TcxSchedulerControlEvent);

const
  ContentNavigationButtonWidth = 24;
  ContentNavigationButtonHeight = 172;
  ContentNavigationButtonReducedHeight = 32;
  MultiLines: array[Boolean] of Integer = (0, cxWordBreak or cxNoFullWidthCharBreak);
  cxDrawTextFlags: array[Boolean] of Cardinal = (
    cxAlignLeft or cxAlignVCenter or cxSingleLine,
    cxAlignLeft or cxAlignTop or cxWordBreak or cxDontBreakChars or cxNoFullWidthCharBreak);

function MakeTextOutcxFlags(AlignHorz: TAlignment;
  AlignVert: TcxAlignmentVert; AMultiline: Boolean = False): Integer;
begin
  Result := cxAlignmentsHorz[AlignHorz] or cxDontBreakChars or
    cxAlignmentsVert[AlignVert] or MultiLines[AMultiline];
end;

function MakeRect(ALeft, ATop: Integer; ASize: TSize): TRect;
begin
  Result.Left := ALeft;
  Result.Top := ATop;
  Result.Right := ALeft + ASize.cx;
  Result.Bottom := ATop + ASize.cy;
end;

function GetTrueMultilineTextHeight(ACanvas: TcxCanvas; const S: string; ABounds: TRect): Integer;
var
  ARowCount: Integer;
  ATextFlags: Cardinal;
  ATextParams: TcxTextParams;
  ATextRows: TcxTextRows;
begin
  ABounds.Bottom := 30000;
  ATextFlags := CXTO_CALCROWCOUNT or CXTO_LEFT or CXTO_TOP or CXTO_WORDBREAK or CXTO_EDITCONTROL;
  ATextParams := cxCalcTextParams(ACanvas.Canvas, ATextFlags);
  cxMakeTextRows(ACanvas.Canvas, PChar(S), Length(S), ABounds, ATextParams, ATextRows, ARowCount);
  Result := ATextParams.RowHeight * Max(ARowCount, 1);
  cxResetTextRows(ATextRows);
end;

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
    if AItem.FVisible and not cxRectIsEmpty(AItem.Bounds) then
    begin
      ASavedFont := AItem.FViewParams.Font;
      AItem.BeforeCustomDraw(ACanvas);
      ADone := False;
      AItem.FCanvas := ACanvas;
      if AItem.FHasClipping then
      begin
        AItem.ClippingCreate(AItem.FHasClipping);
        ADrawItemProc(AItem, ADone);
        AItem.ClippingRestore;
      end
      else
        ADrawItemProc(AItem, ADone);
      AItem.AfterCustomDraw(ACanvas);
      if not ADone then
        AItem.Draw(ACanvas);
      AItem.FViewParams.Font := ASavedFont;
    end;
  end;
// need Optimize if custom draw not supported do not need
// custom draw canvas preparation

//  SelectClipRgn(ACanvas.Handle, 0);
// TODO: draw and custom draw events
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
  CalculateCellBounds(ABounds, AVisibleRect);
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
  if Cache <> nil then
  begin
    if not Cache.IsValid(Self) then
    begin
      Cache.Update(Self);
      UpdateCachedImage(APrevParams);
    end;
    ACanvas.Draw(Bounds.Left, Bounds.Top, Cache.Image);
  end
  else
  begin
    FCanvas := ACanvas;
    DoDraw;
  end;
  ACanvas.SetParams(APrevParams);
  FCanvas := APrevCanvas;
  Transparent := ATransparent;
end;

procedure TcxSchedulerCustomViewInfoItem.CalculateCellBounds(
  const ABounds, AVisibleRect: TRect);
begin
  FBounds := ABounds;
  FVisible := cxRectIntersect(FClipRect, ABounds, AVisibleRect);
  FHasClipping := FVisible and not cxRectIsEqual(FClipRect, ABounds);
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
    Canvas.FillRect(ARect, FViewParams, ABorders, ABorderColor, ALineWidth);
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

// custom draw support
procedure TcxSchedulerCustomViewInfoItem.AfterCustomDraw(ACanvas: TcxCanvas);
begin
  ACanvas.GetParams(FViewParams);
end;

procedure TcxSchedulerCustomViewInfoItem.BeforeCustomDraw(ACanvas: TcxCanvas);
begin
  ACanvas.SetParams(FViewParams);
end;

procedure TcxSchedulerCustomViewInfoItem.UpdateCachedImage(
  const AViewParams: TcxViewParams);
begin
  if Transparent then
    BitBlt(Cache.Image.Canvas.Handle, 0, 0, Width, Height, Canvas.Handle,
      Bounds.Left, Bounds.Top, srcCopy);
  FCanvas := Cache.Image.cxCanvas;
  Canvas.SetParams(AViewParams);
  Canvas.WindowOrg := Bounds.TopLeft;
  DoDraw;
  Canvas.WindowOrg := cxNullPoint;
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

function TcxSchedulerCustomViewInfoItem.GetHeight: Integer;
begin
  Result := Bounds.Bottom - Bounds.Top;
end;

function TcxSchedulerCustomViewInfoItem.GetPainterHelper: TcxSchedulerPainterHelperClass;
begin
  Result := TcxSchedulerHelpersFactory.PainterHelperClass;
end;

function TcxSchedulerCustomViewInfoItem.GetTextColor: TColor;
begin
  Result := FViewParams.TextColor;
end;

function TcxSchedulerCustomViewInfoItem.GetWidth: Integer;
begin
  Result := Bounds.Right - Bounds.Left;
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
  FImageIndex := -1;
  FButtonState := cxbsDefault;
  FAlignHorz := taCenter;
  FAlignVert := vaCenter;
  FBorders := cxBordersAll;
  FTextRect := cxRectInflate(FBounds, -cxTextOffset, 0);
end;

destructor TcxSchedulerHeaderCellViewInfo.Destroy;
begin
  FreeAndNil(FSelectionBitmap);
  FreeAndNil(FRotateBitmap);
  inherited Destroy;
end;

procedure TcxSchedulerHeaderCellViewInfo.Calculate(const AText: string);
begin
  FDisplayText := AText;
end;

procedure TcxSchedulerHeaderCellViewInfo.CalculateImageLayout;
const
  Alignments: array[TcxSchedulerHeaderImagePosition] of TAlignment =
    (taLeftJustify, taCenter, taRightJustify, taCenter);
var
  ATopLeft: TPoint;
  ATextSize, AImageSize: TSize;
  ABounds: TRect;
begin
  FImageRectAssigned := HasImage;
  if not FImageRectAssigned then
  begin
    FTextRect := cxRectInflate(PainterHelper.ExcludeBorders(Bounds, Borders), -cxTextOffset, 0);
    if not HasImage and RotateHeader then
    begin
      if RotateText then
        FTextRect := MakeRect(0, 0, cxSize(Height, Width))
      else
        FTextRect := MakeRect(0, 0, cxSize(Width, Height));
      InflateRect(FTextRect, -(cxTextOffset + 1), -(cxTextOffset + 1));
    end;
    DisplayBounds := FTextRect;
    Exit;
  end;
  FTextRect := cxTextRect(PainterHelper.ExcludeBorders(Bounds, Borders));
  FAlignHorz := Alignments[ImagePosition];
  FAlignVert := vaTop;
  MultiLine := AutoHeight;
  // calculate text and image extents
  AImageSize := cxSize(Images.Width, Images.Height);
  if RotateHeader and RotateText then
  begin
    AImageSize := cxSize(Images.Height, Images.Width);
    ABounds := MakeRect(0, 0, cxSize(Height - 2, Width - 2));
    FTextRect := cxTextRect(ABounds);
  end
  else
  begin
    ABounds := Bounds;
    if RotateHeader then
    begin
      OffsetRect(ABounds, -ABounds.Left, -ABounds.Top);
      FTextRect := cxTextRect(ABounds);
    end;
  end;
  DisplayBounds := cxRectInflate(ABounds, -1, -1);
  if AutoHeight and (ImagePosition in [ipLeft, ipRight]) then
    Dec(FTextRect.Right, AImageSize.cx + cxTextOffset * 2);
  if Length(DisplayText) > 0 then
  begin
//    Canvas.Font.Assign(Font);
//    Canvas.TextExtent(DisplayText, FTextRect, GetTextOutcxFlags);
    FTextRect.Right := FTextRect.Left + cxRectWidth(Resource.FTextRect);
    FTextRect.Bottom := FTextRect.Top + cxRectHeight(Resource.FTextRect);
  end
  else
    FTextRect := cxNullRect;
  ATextSize := cxRectSize(FTextRect);
  ATopLeft := cxPointOffset(cxRectCenter(ABounds), 1, -1 + Byte(RotateHeader));
  if ImagePosition in [ipLeft, ipRight] then
  begin
    Dec(ATopLeft.X, (AImageSize.cx + ATextSize.cx + cxTextOffset) div 2);
    FTextRect := MakeRect(ATopLeft.X, ATopLeft.y - ATextSize.cy div 2, ATextSize);
    FImageRect := MakeRect(ATopLeft.X, ATopLeft.y - AImageSize.cy div 2, AImageSize);
  end
  else
  begin
    Dec(ATopLeft.Y, (AImageSize.cy + ATextSize.cy + cxTextOffset) div 2);
    FTextRect := MakeRect(ATopLeft.x - ATextSize.cx div 2, ATopLeft.y, ATextSize);
    FImageRect := MakeRect(ATopLeft.x - AImageSize.cx div 2, ATopLeft.y, AImageSize);
  end;
  // calculate text bounds
  if Length(DisplayText) > 0 then
  begin
    case ImagePosition of
      ipLeft:
        OffsetRect(FTextRect, AImageSize.cx + cxTextOffset, 0);
      ipTop:
        OffsetRect(FTextRect, 0, AImageSize.cy + cxTextOffset);
      ipRight:
        OffsetRect(FImageRect, ATextSize.cx + cxTextOffset, 0);
      ipBottom:
        OffsetRect(FImageRect, 0, ATextSize.cy + cxTextOffset);
    end;
  end;
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
  ValidateSelection;
  CalculateImageLayout;
  FBackgroundDrawing := False;
  if RotateText or RotateHeader then
    DrawVerticalHeader
  else
    DrawHorizontalHeader;
end;

procedure TcxSchedulerHeaderCellViewInfo.DrawCaption(ACanvas: TcxCanvas = nil);
var
  ABitmap: TcxBitmap;
begin
  if ACanvas = nil then
    ACanvas := Canvas;
  ACanvas.SaveClipRegion;
  try
    ACanvas.Brush.Style := bsClear;
    ACanvas.IntersectClipRect(DisplayBounds);
    ACanvas.Font := Font;
    ACanvas.Font.Color := TextColor;
    ACanvas.DrawTexT(DisplayText, TextRect, GetTextOutcxFlags);
    if FImageRectAssigned and HasImage then
    begin
      if not RotateText then
        ACanvas.DrawImage(Images, FImageRect.Left, FImageRect.Top, ImageIndex)
      else
      begin                          //todo:
        ABitmap := TcxBitmap.CreateSize(Images.Width, Images.Height, pf32bit);
        try
          ABitmap.Rotate(raMinus90);
          cxBitBlt(ABitmap.Canvas.Handle, ACanvas.Handle, ABitmap.ClientRect, FImageRect.TopLeft, SRCCOPY);
          ABitmap.Rotate(raPlus90);
          Images.Draw(ABitmap.Canvas, 0, 0, ImageIndex);
          ABitmap.Rotate(raMinus90);
          ACanvas.Draw(FImageRect.Left, FImageRect.Top, ABitmap);
        finally
          ABitmap.Free;
        end;
      end;
    end;
  finally
    ACanvas.RestoreClipRegion;
  end;
end;

procedure TcxSchedulerHeaderCellViewInfo.DrawHorizontalHeader;
begin
  if not Transparent then
    Painter.DrawHeader(Canvas, Bounds, TextRect, Neighbors, Borders,
      FButtonState, AlignHorz, AlignVert, MultiLine, ShowEndEllipsis, '',
      Font, TextColor, Color, DrawBackground, not (nRight in Neighbors));
  if not FBackgroundDrawing and Selected then
    DrawSelection;
  if DisplayText <> '' then
    DrawCaption;
end;

function TcxSchedulerHeaderCellViewInfo.DrawRotateBackground(
  ACanvas: TcxCanvas; const ABounds: TRect): Boolean;
begin
  Result := FDrawRotatedBackground;
end;

procedure TcxSchedulerHeaderCellViewInfo.DrawSelection;
begin
  if FSelectionBitmap = nil then
    FSelectionBitmap := TcxBitmap.CreateSize(Bounds, pf32bit)
  else
    FSelectionBitmap.SetSize(Width, Height);
  cxBitBlt(FSelectionBitmap.Canvas.Handle, Canvas.Handle, FSelectionBitmap.ClientRect, Bounds.TopLeft, SRCCOPY);
  cxAlphaBlend(FSelectionBitmap, cxRectOffset(FSelectionRect, -Bounds.Left, -Bounds.Top), ColorToRgb(SelectionColor));
  cxBitBlt(Canvas.Handle, FSelectionBitmap.Canvas.Handle, Bounds, cxNullPoint, SRCCOPY);
end;

procedure TcxSchedulerHeaderCellViewInfo.DrawVerticalHeader;

  procedure CreateRotatedBitmap;
  begin
    FRotateBitmap := TcxBitmap.CreateSize(Bounds, pf32bit);
    FRotateBitmap.Canvas.Lock;
    if Transparent then
      cxBitBlt(FRotateBitmap.Canvas.Handle, Canvas.Handle, FRotateBitmap.ClientRect, Bounds.TopLeft, SRCCOPY);
    FRotateBitmap.cxCanvas.WindowOrg := Bounds.TopLeft;
  end;

var
  R: TRect;
begin
  if FRotateBitmap = nil then
  begin
    CreateRotatedBitmap;
    FDrawRotatedBackground := DrawBackground(FRotateBitmap.cxCanvas, Bounds);

    if not Transparent then
    begin
      FRotateBitmap.Rotate(raPlus90, True);
      R := FRotateBitmap.ClientRect;
      Painter.DrawHeader(FRotateBitmap.cxCanvas, R, cxRectInflate(R, -cxTextOffset, -cxTextOffset),
        Neighbors, Borders, cxbsNormal, taCenter, vaCenter, False, False, '',
        Font, TextColor, Color, DrawRotateBackground);
      FRotateBitmap.Rotate(raPlus90, True);
    end;

    if RotateText then
    begin
      FRotateBitmap.Rotate(raMinus90);
      DrawCaption(FRotateBitmap.cxCanvas);
      FRotateBitmap.Rotate(raPlus90);
    end
    else
      DrawCaption(FRotateBitmap.cxCanvas);
  end;
  Canvas.Draw(Bounds.Left, Bounds.Top, FRotateBitmap);
end;

function TcxSchedulerHeaderCellViewInfo.GetTextOutcxFlags: Integer;
begin
  Result := MakeTextOutcxFlags(AlignHorz, AlignVert, AutoHeight);
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
  if AutoHeight then
  begin
    Result := CXTO_PREVENT_LEFT_EXCEED or CXTO_PREVENT_TOP_EXCEED or
      Horz[AlignHorz] or Vert[AlignVert] or CXTO_WORDBREAK;
  end;
end;

function TcxSchedulerHeaderCellViewInfo.HasImage: Boolean;
begin
  Result := ImageIndex >=0
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
  if not FImageRectAssigned then
    R := cxRectInflate(R, -1, -(cxTextOffset + 1));
  with ACanvas.Canvas do
  begin
    Font := FViewParams.Font;
    Font.Color := FViewParams.TextColor;
    cxTextOut(Handle, AText, R, GetTextOutFlags);
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
    if cxRectWidth(FTextRect) <= 0 then Exit;
    FDisplayText := DateTimeHelper.DayToStr(FDateTime, Result, Compressed);
  until (Result = DateTimeHelper.DayToStrFormatCount - 1) or
    (cxTextWidth(Font, DisplayText) <= cxRectWidth(FTextRect) - cxTextOffset);
end;

function TcxSchedulerDayHeaderCellViewInfo.CheckSelection: Boolean;
begin
  Result := True;
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
    Canvas.FillRect(FSelectionRect, SelectionColor);
  Result := (FButtonState = cxbsHot) or Selected;
end;

procedure TcxSchedulerDayHeaderCellViewInfo.DrawHorizontalHeader;
begin
  if Selected and not (FButtonState = cxbsHot) then
  begin
    Color := FSelectionColor;
    TextColor := FSelectionTextColor;
  end;
  inherited DrawHorizontalHeader;
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
  ADay := Trunc(FDateTime) + 1;
  if ADay > 7 then
  begin
    case AType of
      0:
        Result := dxFormatSettings.LongDayNames[7]+ '/' + dxFormatSettings.LongDayNames[1];
      1:
        Result := dxFormatSettings.ShortDayNames[7]+ '/' + dxFormatSettings.ShortDayNames[1];
    else
      Result := AnsiUpperCase(dxFormatSettings.LongDayNames[7][1]+ '/' + dxFormatSettings.LongDayNames[1][1]);
    end;
  end
  else
    case AType of
      0:
        Result := dxFormatSettings.LongDayNames[ADay];
      1:
        Result := dxFormatSettings.ShortDayNames[ADay];
    else
      Result := AnsiUpperCase(dxFormatSettings.LongDayNames[ADay][1]);
    end;
end;

{ TcxSchedulerContainerCellViewInfo }

procedure TcxSchedulerContainerCellViewInfo.DoDraw;
begin
  FExternalPainter.DrawAllDayArea(Canvas, Bounds, FDayBorderColor, Borders,
    ViewParams, Selected, Transparent);
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
  const ALabel1, ALabel2: string; ATimeZone, AAdditionalTimeZone: Integer;
  AAdditionalTimeZoneBiasDelta: Integer);
begin
  Calculate(-1, 1, ATimeZone, AAdditionalTimeZone, nil, AAdditionalTimeZoneBiasDelta);
  FDisplayTexts[True] := ALabel1;
  FDisplayTexts[False] := ALabel2;
end;

procedure TcxSchedulerTimeRulerCellViewInfo.Calculate(AHour, ALineCount: Integer;
  ATimeZone, AAdditionalTimeZone: Integer; ALargeFont: TFont;
  AAdditionalTimeZoneBiasDelta: Integer);
begin
  FHour := AHour;
  FLineCount := ALineCount;
  FAdditionalTimeZone := AAdditionalTimeZone;
  FAdditionalTimeZoneBiasDelta := AAdditionalTimeZoneBiasDelta;
  FTimeZone := ATimeZone;
  FLargeFont := ALargeFont;
  if FVisible then
    CalculateDisplayInfo;
end;

procedure TcxSchedulerTimeRulerCellViewInfo.SetBottom(AValue: Integer);
begin
  FClipRect.Bottom := AValue;
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
      DrawTimeZone(Bounds[ACurrentTimeZone], DisplayTexts[ACurrentTimeZone],
        ACurrentTimeZone)
    else
      DrawTimeZoneLabel(Bounds[ACurrentTimeZone],
        DisplayTexts[ACurrentTimeZone], ABorders[ACurrentTimeZone]);
  end;
  ClippingRestore;
end;

procedure TcxSchedulerTimeRulerCellViewInfo.DrawTimeZoneLabel(
  const ABounds: TRect; const AText: string; ABorders: TcxBorders);
begin
  FExternalPainter.DrawTimeRulerBackground(Canvas, ABounds, ABorders, ViewParams,
    Transparent);
  DrawText(cxTextRect(ABounds), AText, cxAlignBottom or cxAlignLeft, Font, TextColor);
end;

procedure TcxSchedulerTimeRulerCellViewInfo.DrawTimeZone(
  const ABounds: TRect; const AText: string; AIsCurrent: Boolean);
var
  J, LH: Integer;
  S: string;
  R, R1, TextR: TRect;
const
  cxRightCenterAlign: Integer = cxAlignVCenter or cxAlignRight or cxDontClip;
  cxRightTopAlign: Integer = cxAlignTop or cxAlignRight or cxDontClip;
begin
  LH := cxRectHeight(inherited Bounds) div LineCount;
  FExternalPainter.DrawTimeRulerBackground(Canvas, ABounds, [bRight], ViewParams,
    Transparent);
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
  if AIsCurrent and FExternalPainter.DrawCurrentTimeFirst then
    DrawCurrentTime(FDateTime, ABounds);
  if LineCount > 1 then
  begin
    J := Length(AText);
    DrawText(Rect(TextR.Left, TextR.Top, R.Left - cxTextOffset, TextR.Bottom),
      Copy(AText, 1, J - 3), cxRightTopAlign, LargeFont, TextColor);
    R1 := Rect(R.Left, TextR.Top, TextR.Right, TextR.Top + LH - 3);
    DrawText(R1, Copy(AText, J - 1, 2), cxAlignCenter, Font, TextColor);
    if ShowMinutes and AIsCurrent then
      for J := 1 to LineCount - 1 do
      begin
        OffsetRect(R1, 0, LH);
        S := IntToStr(MulDiv(60, J, LineCount));
        if Length(S) < 2 then
          S := '0' + S;
        DrawText(R1, S, cxAlignCenter, Font, TextColor);
      end;
  end
  else
    DrawText(TextR, AText, cxRightCenterAlign, Font, TextColor);
  if AIsCurrent and not FExternalPainter.DrawCurrentTimeFirst then
    DrawCurrentTime(FDateTime, ABounds);
  R.Left := ABounds.Left + 5;
  if (Hour <> 23) and not LastVisibleHour then
    DrawFrame(R, [bBottom], clBtnShadow)
  else
    DrawFrame(ABounds, [bBottom], clBtnShadow);
end;

procedure TcxSchedulerTimeRulerCellViewInfo.DrawCurrentTime(
  const AStart: TDateTime; ABounds: TRect);
var
  ADelta: Double;
begin
  with DateTimeHelper do
    ADelta := TimeZoneBias(CurrentTimeZone) - TimeZoneBias(TimeZone);
  FExternalPainter.DrawCurrentTime(Canvas, Color, AStart - ADelta, ABounds);
  Canvas.Brush.Style := bsClear;
end;

function TcxSchedulerTimeRulerCellViewInfo.GetAdditionalTime: TDateTime;
begin
  Result := DateTimeHelper.ConvertToAnotherTimeZone(
    (Hour + FAdditionalTimeZoneBiasDelta / MinsPerHour) * HourToTime + Date,
    TimeZone, AdditionalTimeZone);
end;

function TcxSchedulerTimeRulerCellViewInfo.GetTimeDisplayText(
  const ATime: TDateTime): string;
var
  APos: Integer;
begin
  Result := DateTimeHelper.HourToStr(ATime);
  if LineCount > 1 then
  begin
    APos := Pos(dxFormatSettings.TimeSeparator, Result);
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
      FExternalPainter.DrawTimeLine(Canvas, R, FTimeLineParams, FTimeLineBorders,
        FTimeLineParams.TextColor)
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

destructor TcxSchedulerMonthDayContentCellViewInfo.Destroy;
begin
  if FSmallFontCreated then
    FreeAndNil(FSmallTextFont);
  inherited Destroy;
end;

procedure TcxSchedulerMonthDayContentCellViewInfo.SetContentState(
  AsDayOfMonth: Boolean; ASelected: Boolean;
  ATextHeight: Integer; const ASelectionParams: TcxViewParams);
begin
  FSelectionColor := ASelectionParams.Color;
  FSelectionTextColor := ASelectionParams.TextColor;
  FTextRect := PainterHelper.ExcludeBorders(Bounds, Borders);
  if AsDayOfMonth then
    FDisplayText := IntToStr(DayOf(TimeStart))
  else
    FDisplayText := GetLongDisplayText;
  FSelected := ASelected;
  FTextRect.Bottom := Min(FTextRect.Bottom, FTextRect.Top + ATextHeight);
  if not SmallFont then
    FTextRect.Left := Max(FTextRect.Left,
      FTextRect.Right - PainterHelper.TextWidth(Font, DisplayText)) - cxTextOffset * 2
  else
  begin
    if FSmallTextFont = nil then
    begin
      SmallTextFont := TFont.Create;
      FSmallFontCreated := True;
      FSmallTextFont.Assign(Font);
      FSmallTextFont.Size := Round(Font.Size * 2 / 3);
    end;
    FTextRect.Left := Max(FTextRect.Left, FTextRect.Right -
      PainterHelper.TextWidth(FSmallTextFont, DisplayText)) - cxTextOffset;
  end;
end;

function TcxSchedulerMonthDayContentCellViewInfo.UpdateSelection(ASelected: Boolean): Boolean;
begin
  Result := FSelected <> ASelected;
  if Result then
    FSelected := ASelected;
end;

procedure TcxSchedulerMonthDayContentCellViewInfo.DoDraw;
const
  TextFlags = CXTO_PREVENT_LEFT_EXCEED or CXTO_PREVENT_TOP_EXCEED or
              CXTO_CENTER_VERTICALLY or CXTO_RIGHT;
var
  R: TRect;
  AColor: Integer;
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
      InflateRect(R, -1, 0);
      Canvas.SetBrushColor(SelectionColor);
      if not IsToday then
        Canvas.FillRect(R)
      else
      begin
        R := FTextRect;
        R.Left := Max(Bounds.Left, (R.Left - cxTextOffset * 2));
        Inc(R.Bottom);
        InflateRect(R, -1, -1);
        Canvas.FillRect(R);
      end;
    end;
    if SmallFont then
      Canvas.Font := SmallTextFont
    else
      Canvas.Font := Font;
    if Selected then
      AColor := SelectionTextColor
    else
      AColor := TextColor;
    Canvas.Brush.Style := bsClear;
    cxTextOut(Canvas.Handle, DisplayText, FTextRect, TextFlags, nil, 0, 0,
      cxTextOffset + 1, AColor);
  end;
end;

function TcxSchedulerMonthDayContentCellViewInfo.GetLongDisplayText: string;
begin
  Result := dxFormatSettings.LongMonthNames[MonthOf(TimeStart)] + ', ' + IntToStr(DayOf(TimeStart));
  if cxTextWidth(Font, Result) >= (cxRectWidth(FTextRect) div 2) then
    Result := dxFormatSettings.ShortMonthNames[MonthOf(TimeStart)] + ' ' + IntToStr(DayOf(TimeStart));
end;

function TcxSchedulerMonthDayContentCellViewInfo.GetIsToday: Boolean;
begin
  Result := Date = TimeStart;
end;

procedure TcxSchedulerMonthDayContentCellViewInfo.SetSmallTextFont(AFont: TFont);
begin
  if FSmallFontCreated then
     FreeAndNil(FSmallFont);
  FSmallTextFont := AFont;
end;

{ TcxSchedulerEventCellViewInfo }

constructor TcxSchedulerEventCellViewInfo.Create(
  AViewData: TcxSchedulerEventViewData);
begin
  inherited Create(AViewData.Painter, AViewData.Bounds,
    AViewData.VisibleRect, AViewData.ViewParams);
  FExternalPainter := AViewData.ExternalPainter;
  ViewData := AViewData;
  FSeparatorColor := clBtnShadow;
  FCanvas := AViewData.Canvas;
  FImages := TcxSchedulerEventImages.Create(AViewData.ImagesLayout);
  Initialize;
end;

destructor TcxSchedulerEventCellViewInfo.Destroy;
begin                                                                   
  ViewData.Free;
  FImages.Free;
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

function TcxSchedulerEventCellViewInfo.MeasureHeight(ACanvas: TcxCanvas): Integer;
var
  L: TList;
begin
  Canvas.Font := Font;
  FIsHeaderEvent := GetIsHeaderEvent;
  CalculateVisibility;
  FCaptionRect := cxRectInflate(Bounds, -(cxTextOffset + 1), -(cxTextOffset + 1));
  L := Images.CreateVisibleList;
  try
    case Images.Layout of
      eilHorizontal:
        Result := CalculateHorizontalImagesAutoHeight;
      eilVertical:
        Result := CalculateVerticalImagesAutoHeight;
      else //eilAuto:;
        Result := CalculateAutoLayoutImagesAutoHeight(L);
    end;
  finally
    L.Free;
  end;
  Result := Max(ViewData.LineHeight, Result);
end;

procedure TcxSchedulerEventCellViewInfo.MoveTo(X, Y: Integer);

  procedure ShiftRect(var R: TRect);
  begin
    if not cxRectIsEmpty(R) then OffsetRect(R, X, Y);
  end;

var
  I: Integer;
begin
  ShiftRect(ViewData.Bounds);
  CalculateCellBounds(ViewData.Bounds, ViewData.VisibleRect);
  if not Visible or Hidden then Exit;
  ShiftRect(FCaptionRect);
  ShiftRect(FFinishRect);
  ShiftRect(FMessageRect);
  ShiftRect(FStartRect);
  ShiftRect(FEventTimeRect);
  ShiftRect(FTimeLineRect);
  if FShowMessage then
    CalculateEditViewInfo;
  for I := 0 to Images.Count - 1 do
    ShiftRect(Images[I].FBounds);
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
  Canvas.Font := Font;
  CalculateItemsLayout;
end;

procedure TcxSchedulerEventCellViewInfo.CalculateBorders;
begin
end;

procedure TcxSchedulerEventCellViewInfo.CalculateCaptions;
begin
  FStartText := DateTimeHelper.TimeToStr(EventStart);
  FFinishText := DateTimeHelper.TimeToStr(EventFinish);
end;

procedure TcxSchedulerEventCellViewInfo.CalculateDetailInfo;
begin
  FIsDetailInfo := ViewData.AutoHeight or (not IsHeaderEvent and
    ((TimeOf(ContentFinish) <> 0) or (TimeOf(ContentStart) <> 0)));
  FIsDetailCaption := FIsDetailInfo and not IsHeaderEvent;
  FShowMessage := IsDetailInfo and (Length(Message) > 0);
end;

procedure TcxSchedulerEventCellViewInfo.CalculateNeedHint;
var
  R: TRect;
begin
  if FHintNeededCalculated then Exit;
  FHintNeeded := CanShowHint;
  if not FHintNeeded then
  begin
    R := FCaptionRect;
    Canvas.TextExtent(Hint, R, cxDrawTextFlags[IsDetailCaption]);
    FHintNeeded := (FCaptionRect.Right < R.Right) or (FCaptionRect.Bottom < R.Bottom);
  end;
  FHintNeededCalculated := True;
end;

procedure TcxSchedulerEventCellViewInfo.CalculateEditViewInfo;
var
  AProperties: TcxCustomEditProperties;
  AEditViewData: TcxCustomEditViewData;
begin
  if not ViewData.AutoHeight then
  begin
    FMessageRect := GetMessageRect(CaptionRect, Images.VisibleImageCount > 0);
    FCaptionRect.Bottom := Min(FMessageRect.Top, Bounds.Bottom - cxTextOffset);
  end;
  if cxRectIsEmpty(FMessageRect) then
  begin
    FShowMessage := False;
    Exit;
  end;
  if FEditViewInfo = nil then
    FEditViewInfo := TcxCustomEditViewInfo(ViewData.EditProperties.GetViewInfoClass.Create);
  AProperties := ViewData.EditProperties;
  AEditViewData := AProperties.CreateViewData(ViewData.EditStyle, True);
  try
    Include(AEditViewData.PaintOptions, epoAutoHeight);
    AssignEditStyle(ViewData.EditStyle);
    AEditViewData.ContentOffset := cxSimpleRect;
    AEditViewData.EditValueToDrawValue(Canvas, Message, FEditViewInfo);
    AEditViewData.CalculateEx(Canvas, FMessageRect,
      cxInvalidPoint, cxmbNone, [], FEditViewInfo, False);
  finally
    AEditViewData.Free;
  end;
end;

procedure TcxSchedulerEventCellViewInfo.CalculateShowTimeAsClock;
begin
  ViewData.ShowTimeAsClock := IsHeaderEvent or
    (ViewData.ShowTimeAsClock and not IsDetailInfo);
end;

function TcxSchedulerEventCellViewInfo.CalculateAutoLayoutImagesAutoHeight(
  AVisibleImages: TList): Integer;

  function GetEventTextsHeight(const AWidth: Integer): Integer;
  var
    R: TRect;
  begin
    R := cxRect(0, 0, AWidth, MaxInt);
    Result := GetCaptionAutoHeight(R) + 2 * cxTextOffset;
    if ShowMessage then
    begin
      Inc(R.Right, 3);
      Inc(Result, CalculateMessageHeight(R) + 1);
    end;
  end;

  function GetColCountForRowCount(ARowCount: Integer): Integer;
  begin
    Result := Images.TotalVisibleImageCount div ARowCount;
    if (Images.TotalVisibleImageCount mod ARowCount) > 0 then
      Inc(Result);
    Result := Max(1, Result);
  end;
var
  I, ANewColCount, ACaptionWidth, ASpaceWidth, AImagesHeight,
  AImagesWidth, AImagesColCount, AImagesRowCount,
  ATextsHeight: Integer;
begin
  ASpaceWidth := cxRectWidth(Bounds) - 2 * cxTextOffset;
  ACaptionWidth := Canvas.TextWidth(Caption);
  if (Images.TotalVisibleImageCount < 2) or
   (ASpaceWidth >= Images.TotalVisibleWidth + cxEventImagesGap + ACaptionWidth) then
  begin
    Result := CalculateHorizontalImagesAutoHeight;
    Exit;
  end;
  AImagesWidth := 0;
  AImagesRowCount := 1;
  AImagesColCount := 0;
  for I := 1 to Images.TotalVisibleImageCount do
  begin
    AImagesRowCount := I;
    AImagesHeight := Min(Images.TotalVisibleImageCount, (AImagesRowCount + 1)) *
      (Images.ItemHeight + cxEventImagesGap) + 4;
    ANewColCount := GetColCountForRowCount(AImagesRowCount);
    if ANewColCount <> AImagesColCount then
    begin
      AImagesColCount := ANewColCount;
      AImagesWidth := AImagesColCount * (Images.ItemWidth + cxEventImagesGap) + 1;
      if ASpaceWidth <= AImagesWidth then Continue;
      ATextsHeight := GetEventTextsHeight(ASpaceWidth - AImagesWidth);
      if ATextsHeight < AImagesHeight then Break;
    end
    else Continue;
  end;
  Result := AImagesRowCount * (Images.ItemHeight + cxEventImagesGap) + 1;
  Images.CalculateForCols(AVisibleImages,
    cxPointOffset(Bounds.TopLeft, cxEventImagesOffset + cxEventBorderWidth,
    cxEventImagesOffset + cxEventBorderWidth), AImagesColCount);
  Inc(FCaptionRect.Left,  AImagesWidth);
  CalculateMessageAutoLayout(Result);
end;

function TcxSchedulerEventCellViewInfo.CalculateHorizontalImagesAutoHeight: Integer;
var
  ARightLimit, ACaptionWidth, ACaptionHeight, AMessageHeight, ASpaceWidth,
  AMessageTop, AImagesWidth: Integer;
  AImagesRect, R: TRect;
begin
  Result := Images.ItemHeight + cxTextOffset;
  ASpaceWidth := cxRectWidth(Bounds) - 2 * cxTextOffset;
  ACaptionWidth := Canvas.TextWidth(Caption);
  AImagesRect := cxRectInflate(Bounds, -cxTextOffset, -cxTextOffset);
  if Images.ForceVisibleWidth + cxEventImagesGap >= ASpaceWidth then
  begin
    FCaptionRect := cxNullRect;
    Images.CalculateSingleLineImages(AImagesRect);
    AMessageTop := Bounds.Top + cxTextOffset + Result + cxEventImagesGap;
  end
  else
  begin
    ARightLimit := 0;
    if not (Images.TotalVisibleWidth + cxEventImagesGap + ACaptionWidth <= ASpaceWidth) then
    begin
      R := FCaptionRect;
      R.Left := Min(AImagesRect.Left + Images.TotalVisibleWidth, R.Right - 1);
      Canvas.TextExtent(Caption, R, cxWordBreak or cxDontBreakChars);
      if R.Right > FCaptionRect.Right then
      begin
        ACaptionWidth := cxRectWidth(R);
        Dec(AImagesRect.Right, ACaptionWidth);
        ARightLimit := Bounds.Right - cxTextOffset - cxRectWidth(R);
      end;
    end;
    AImagesWidth := Images.CalculateSingleLineImages(AImagesRect, ARightLimit);
    if AImagesWidth > 0 then Inc(AImagesWidth);
    Inc(FCaptionRect.Left, AImagesWidth);
    ACaptionHeight := GetCaptionAutoHeight(CaptionRect);
    FCaptionRect.Bottom := FCaptionRect.Top + ACaptionHeight;
    Result := Max(Result, ACaptionHeight + 2 * cxTextOffset);
    AMessageTop := FCaptionRect.Top + Result;
  end;
  if FShowMessage then
  begin
    FMessageRect := cxRect(Bounds.Left + cxEventImagesGap, AMessageTop - 1, Bounds.Right - 1, 0);
    AMessageHeight := CalculateMessageHeight(FMessageRect);
    FMessageRect.Bottom := FMessageRect.Top + AMessageHeight;
    Inc(Result, AMessageHeight + 1);
    CalculateEditViewInfo;
  end;
end;

procedure TcxSchedulerEventCellViewInfo.CalculateMessageAutoLayout(var AHeight: Integer);
var
  ACaptionHeight, AMessageHeight, AMessageTop: Integer;
begin
  if not cxRectIsEmpty(CaptionRect) then
  begin
    ACaptionHeight := GetCaptionAutoHeight(CaptionRect);
    FCaptionRect.Bottom := CaptionRect.Top + ACaptionHeight;
    Inc(ACaptionHeight, 2 * cxTextOffset);
    AHeight := Max(AHeight, ACaptionHeight);
    if FShowMessage then
    begin
      AMessageTop := FCaptionRect.Top +  ACaptionHeight - 1;
      FMessageRect := cxRect(FCaptionRect.Left - 2, AMessageTop, Bounds.Right - 1, 0);
      AMessageHeight := CalculateMessageHeight(FMessageRect);
      FMessageRect.Bottom := FMessageRect.Top + AMessageHeight;
      AHeight := Max(AHeight, ACaptionHeight + AMessageHeight);
      CalculateEditViewInfo;
    end;
  end
  else FShowMessage := False;
end;

function TcxSchedulerEventCellViewInfo.CalculateVerticalImagesAutoHeight: Integer;
var
  AImagesRect: TRect;
begin
  Result := Images.ItemHeight + cxTextOffset;
  if Images.TotalVisibleHeight > 0 then
  begin
    AImagesRect := cxRectInflate(Bounds, -cxTextOffset, -cxTextOffset);
    AImagesRect.Bottom := AImagesRect.Top + Images.TotalVisibleHeight;
    if (cxRectWidth(AImagesRect) > Images.ItemWidth + cxEventImagesGap) or
       (Images.ForceVisibleHeight > 0) then
    begin
      Inc(FCaptionRect.Left, Images.ItemWidth + cxTextOffset);
      Result := Images.TotalVisibleHeight + cxEventImagesGap;
    end;
    Images.CalculateSingleColumnImages(AImagesRect);
  end;
  CalculateMessageAutoLayout(Result);
end;

procedure TcxSchedulerEventCellViewInfo.CalculateItemsLayout;
begin
  if IsDetailInfo then
    CalculateDetailViewEventLayout
  else
    CalculateHeaderEventLayout;
end;

procedure TcxSchedulerEventCellViewInfo.CalculateDetailViewEventLayout;
var
  AImagesWidth: Integer;
begin
  FCaptionRect := cxRectInflate(Bounds, -cxTextOffset, -(cxTextOffset + 1));
  AImagesWidth := Images.Calculate(GetImagesBounds);
  Images.Offset(0, GetImagesVerticalOffset(Images.ItemHeight, False));
  Inc(FCaptionRect.Left, AImagesWidth + cxEventImagesGap);
  if FShowMessage then CalculateEditViewInfo;
end;

procedure TcxSchedulerEventCellViewInfo.CalculateHeaderEventLayout;
var
  ACaptionRect: TRect;
  ALeft, AWidth, AImagesWidth, ACaptionWidth, AVertOffset: Integer;
  ACanShowClock: Boolean;
  R: TRect;

  procedure CalculateCaption;
  var
    R: TRect;
  begin
    InflateRect(ACaptionRect, -cxTextOffset, 0);
    R := cxRectSetLeft(cxRectInflate(Bounds, -1, -1), 0,
      cxRectWidth(ACaptionRect) - (ACaptionWidth + cxTextOffset));
    AImagesWidth := Images.CalculateSingleLineImages(R);
    if AImagesWidth <> 0 then Inc(AImagesWidth, cxTextOffset);
    AWidth := AImagesWidth + ACaptionWidth;
  end;

begin
  FCaptionRect := cxRectInflate(Bounds, -cxTextOffset, -1);
  R := cxRect(0, 0, EventImages.Width, EventImages.Height);
  AVertOffset := GetImagesVerticalOffset(R.Bottom, True);
  ACaptionWidth := Canvas.TextWidth(ViewData.Caption);
  ACaptionRect := FCaptionRect;
  ACanShowClock := cxRectWidth(ACaptionRect) >= EventImages.Width + cxEventImagesGap;
  if ShowStartTime and ACanShowClock then
  begin
    FStartRect := cxRectOffset(R, Bounds.Left + (cxEventBorderWidth + cxEventImagesOffset), AVertOffset);
    ACaptionRect.Left := FStartRect.Right;
  end;
  if ShowFinishTime and ACanShowClock then
  begin
    FFinishRect := cxRectOffset(R, Bounds.Right - R.Right - (cxEventBorderWidth + cxEventImagesOffset), AVertOffset);
    ACaptionRect.Right := FFinishRect.Left;
  end;
  CalculateCaption;
  if (ShowStartTime or ShowFinishTime) and
    (ACaptionWidth + Images.TotalVisibleWidth > cxRectWidth(ACaptionRect)) and
    not GetForceShowClockInHeaderEvent then
  begin
    FStartRect := cxEmptyRect;
    FFinishRect := cxEmptyRect;
    ViewData.ShowStartTime := False;
    ViewData.ShowFinishTime := False;
    ACaptionRect := FCaptionRect;
    CalculateCaption;
  end;
  with ACaptionRect do
    ALeft := Max(Left + ((Right - Left - AWidth) div 2), ACaptionRect.Left);
  Images.Offset(ALeft, GetImagesVerticalOffset(Images.ItemHeight, False));
  ACaptionRect.Left := ALeft + AImagesWidth;
  FCaptionRect := ACaptionRect;
end;

procedure TcxSchedulerEventCellViewInfo.CalculateNonDetailEventLayout;
var
  R: TRect;
  ALeft, ACaptionWidth, AImagesWidth: Integer;
begin
  FCaptionRect := cxRectInflate(Bounds, -cxTextOffset, -1);
  ALeft := CaptionRect.Left;
  ACaptionWidth := Canvas.TextWidth(ViewData.Caption);
  R := CalculateNonDetailEventImages(ACaptionWidth, AImagesWidth);
  if ShowFinishTime or ShowStartTime then
  begin
    if ShowTimeAsClock then
      CalculateEventTimeAsClockLayout(R, ACaptionWidth, AImagesWidth, ALeft)
    else
      CalculateEventTimeAsTextLayout(R, ACaptionWidth, AImagesWidth, ALeft);
  end;
  AImagesWidth := Images.Offset(ALeft - FCaptionRect.Left,
    GetImagesVerticalOffset(Images.ItemHeight, False));
  if AImagesWidth > 0 then Inc(AImagesWidth);
  Inc(ALeft, AImagesWidth + cxEventImagesOffset);
  FCaptionRect.Left := ALeft;
end;

procedure TcxSchedulerEventCellViewInfo.CalculateEventTimeAsClockLayout(
  const ABounds: TRect; const ACaptionWidth, AImagesWidth: Integer; var ALeft: Integer);
var
  R: TRect;
  AVertOffset: Integer;
begin
  R := cxRectBounds(0, 0, TcxSchedulerPainterHelper.IconsWidth,
    TcxSchedulerPainterHelper.IconsHeight);
  AVertOffset := GetImagesVerticalOffset(R.Bottom, True);
  FStartRect := SetItemRect(ShowStartTime, R, AVertOffset, ALeft);
  FFinishRect := SetItemRect(ShowFinishTime, R, AVertOffset, ALeft);
  Inc(ALeft);
end;

procedure TcxSchedulerEventCellViewInfo.CalculateEventTimeAsTextLayout(
  const ABounds: TRect; const ACaptionWidth, AImagesWidth: Integer; var ALeft: Integer);
var
  ASpaceWidth, AWidth: Integer;
  R: TRect;
begin
  ASpaceWidth := cxRectWidth(ABounds) - AImagesWidth;
  with Canvas.TextExtent('00:00') do
    R := cxRectBounds(ABounds.Left, 0, CX, CY);
  if not Is24HourTimeFormat then
    R := cxRectSetWidth(R, Max(Canvas.TextWidth('00:00' + dxFormatSettings.TimeAMString),
      Canvas.TextWidth('00:00' + dxFormatSettings.TimePMString)));
  AWidth := cxRectWidth(R);
  if ASpaceWidth >= AWidth then
  begin
    FStartRect := cxRect(ALeft, FCaptionRect.Top, ALeft + AWidth, FCaptionRect.Bottom);
    Inc(AWidth, Canvas.TextWidth('0') div 2);
    Inc(ALeft, AWidth);
    Dec(ASpaceWidth, AWidth);
    if ShowFinishTime and (ASpaceWidth >= AWidth) then
    begin
      FFinishRect := cxRectOffset(FStartRect, AWidth, 0);
      Inc(ALeft, AWidth);
    end;
  end;
end;

function TcxSchedulerEventCellViewInfo.CalculateNonDetailEventImages(
  const ACaptionWidth: Integer; out AImagesWidth: Integer): TRect;
begin
  Result := GetImagesBounds;
  AImagesWidth := CalculateSingleLineImages(Result);
end;

function TcxSchedulerEventCellViewInfo.CalculateSingleLineImages(
  const ABounds: TRect; ARightLimit: Integer = 0): Integer;
begin
  Result := Images.CalculateSingleLineImages(ABounds, ARightLimit);
end;

function TcxSchedulerEventCellViewInfo.SetItemRect(AShowItem: Boolean;
  const ABounds: TRect; AVertOffset: Integer; var APos: Integer): TRect;
begin
  Result := cxNullRect;
  if AShowItem then
  begin
    if ((APos + cxRectWidth(ABounds)) <= cxRectCenter(FBounds).X) then
    begin
      Result := cxRectOffset(ABounds, APos, AVertOffset);
      APos := Result.Right + cxTextOffset;
    end;
  end
end;

procedure TcxSchedulerEventCellViewInfo.CalculateEventTimeVisibility;
begin
  if IsDetailInfo then
    CalculateDetailEventTimeVisibility
  else
    CalculateNonDetailEventTimeVisibility;
end;

procedure TcxSchedulerEventCellViewInfo.CalculateDetailEventTimeVisibility;
begin
  ViewData.ShowFinishTime := (IsDetailCaption and ViewData.AlwaysShowTime) or
    ((ViewData.ContentFinish > EventFinish) and (ViewData.ContentStart <> EventFinish)) or
    (ViewData.ContentStart < EventStart);
  ViewData.ShowStartTime := ViewData.ShowFinishTime;
end;

procedure TcxSchedulerEventCellViewInfo.CalculateNonDetailEventTimeVisibility;
begin
  if Event.AllDayEvent then
  begin
    ViewData.ShowFinishTime := False;
    ViewData.ShowStartTime := False;
  end
  else
  begin
    ViewData.ShowFinishTime := (ViewData.ContentFinish >= EventFinish) and
      (ViewData.ShowFinishTime or (Event.Duration >= 1));
    ViewData.ShowStartTime := (ContentStart <= EventStart);
  end;
end;

procedure TcxSchedulerEventCellViewInfo.CalculateVisibility;
begin
  if ViewData.ShowTimeLine then
  begin
    if Selected then
      FVisible := cxRectIntersect(FClipRect, cxRectInflate(Bounds, 0, cxTimeLineWidth), ViewData.VisibleRect);
  end
  else
    FVisible := FVisible and (FClipRect.Bottom = FBounds.Bottom);
  CalculateDetailInfo;
  CalculateShowTimeAsClock;
  CalculateEventTimeVisibility;
  CalculateBorders;
end;

function TcxSchedulerEventCellViewInfo.CanAutoHideStandardImages: Boolean;
begin
  Result := False;
end;

function TcxSchedulerEventCellViewInfo.CanShowHint: Boolean;
begin
  Result := not Event.AllDayEvent and not IsDetailInfo and
    (cxRectIsEmpty(FinishRect) or cxRectIsEmpty(StartRect));
end;

procedure TcxSchedulerEventCellViewInfo.DoDraw;
begin
  if FHidden then Exit;
  ClippingCreate(True);
  DrawContent;
  ClippingRestore;
end;

procedure TcxSchedulerEventCellViewInfo.DrawCaption;
begin
  if cxRectIsEmpty(FCaptionRect) or (ViewData.Caption = '') then Exit;
  Canvas.Brush.Style := bsClear;
  Canvas.DrawText(ViewData.Caption, FCaptionRect, cxDrawTextFlags[IsDetailCaption]);
  Canvas.Brush.Style := bsSolid;
end;

procedure TcxSchedulerEventCellViewInfo.DrawContent;
begin
  if ViewData.DrawAsProgress then
    ExternalPainter.DrawEventAsProgress(Self)
  else
  begin
    ExternalPainter.DrawEvent(Self);
    if not Event.IsEditing then
      DrawImages;
    if IsNeedDrawTime then
      DrawTime;
    DrawCaption;
    if FShowMessage then
    begin
      FEditViewInfo.Transparent := True;
      FEditViewInfo.TextColor := TextColor;
      FEditViewInfo.PaintEx(Canvas);
      DrawMessageSeparator;
    end;
  end;
end;

procedure TcxSchedulerEventCellViewInfo.DrawImages;
var
  I: Integer;
  ASaveRgn: TcxRegion;
begin
  with Images do
  begin
    if Count = 0 then Exit;
    ASaveRgn := Canvas.GetClipRegion;
    Canvas.IntersectClipRect(cxRectInflate(Bounds, -1, -1));
    for I := 0 to Count - 1 do
      with Items[I] do
        if Visible and not FHidden then
          PainterHelper.DrawTransparentImage(Canvas, Images, Bounds.Left, Bounds.Top, ImageIndex);
    Canvas.SetClipRegion(ASaveRgn, roSet);
  end;
end;

procedure TcxSchedulerEventCellViewInfo.DrawMessageSeparator;
var
  R: TRect;
begin
  R := cxRectInflate(MessageRect, -(1 + Byte(not ShowTimeLine)), 1, -2, 0);
  Canvas.FrameRect(R, SeparatorColor, 1, [bTop]);
end;

procedure TcxSchedulerEventCellViewInfo.DrawTime;
const
  RightJustify = cxAlignRight or cxAlignVCenter or cxSingleLine;
begin
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

function TcxSchedulerEventCellViewInfo.GetCaptionAutoHeight(const R: TRect): Integer;
begin
  if (Caption <> '') and not cxRectIsEmpty(CaptionRect) then
    Result := GetTrueMultilineTextHeight(Canvas, ViewData.Caption, R)
  else
    Result := Canvas.FontHeight(Font);
end;

function TcxSchedulerEventCellViewInfo.GetEditingRect: TRect;
begin
  cxRectIntersect(Result, PainterHelper.ExcludeBorders(Bounds, Borders), FClipRect);
  with Result do
  begin
    if IsDetailCaption then
    begin
      Inc(Left, cxTextOffset - Byte(bLeft in Borders));
      Dec(Right);
    end
    else
      Inc(Left);
  end;
end;

function TcxSchedulerEventCellViewInfo.GetForceShowClockInHeaderEvent: Boolean;
begin
  Result := True;
end;

function TcxSchedulerEventCellViewInfo.GetHitTest(
  AHitTest: TcxSchedulerCustomResourceViewHitTest; var ABreak: Boolean): Boolean;
begin
  Result := inherited GetHittest(AHitTest, ABreak);
  Result := Result and not Hidden and Event.Enabled;
  if Result and not Hidden and ShowTimeLine and Selected then
    ABreak := not PtInRect(CaptionRect, AHitTest.HitPoint) and not
      PtInRect(MessageRect, AHitTest.HitPoint)
  else
    ABreak := False;
end;

function TcxSchedulerEventCellViewInfo.GetImagesBounds: TRect;
begin
  with Bounds do
    Result := cxRect(Left + cxEventBorderWidth + cxEventImagesOffset - Byte(ViewData.ShowTimeLine),
      Top + cxEventBorderWidth,
      (Left + Right - cxTextOffset) div 2,
      Bottom - (cxEventBorderWidth + cxEventImagesOffset));
end;

function TcxSchedulerEventCellViewInfo.GetImagesVerticalOffset(
  AImageHeight: Integer; AIsAbsolute: Boolean): Integer;
begin
  Result := cxEventImagesOffset;
  if not FIsDetailCaption then
    Result := Max(Result, (cxRectHeight(Bounds) - 2 * cxEventBorderWidth - AImageHeight) div 2);
  if AIsAbsolute then
    Inc(Result, Bounds.Top + cxEventBorderWidth);
end;

function TcxSchedulerEventCellViewInfo.GetMessageRect(const ACaptionRect: TRect;
  AHasImages: Boolean): TRect;
var
  ACaptionBottom: Integer;
  R: TRect;
begin
  if not cxRectIsEmpty(ACaptionRect) then
  begin
    R := GetCaptionBounds(ACaptionRect);
    ACaptionBottom := R.Bottom + cxTextOffset; //bottom text offset
  end
  else
    ACaptionBottom := Bounds.Top + cxTextOffset;
  if AHasImages then
    ACaptionBottom := Max(ACaptionBottom, Bounds.Top + Images.ItemHeight);
  Inc(ACaptionBottom); //horz line
  Result.Top := ACaptionBottom;
  Result.Bottom := Bounds.Bottom;
  Result.Right := Bounds.Right - 1;
  if Images.Layout = eilHorizontal then
    Result.Left := Bounds.Left + cxEventBorderWidth
  else
    Result.Left := R.Left - cxTextOffset;
end;

function TcxSchedulerEventCellViewInfo.HasReminder: Boolean;
begin
  with Event do
  begin
    Result := Storage.Reminders.Active and Storage.IsReminderAvailable and Reminder;
    if Result and (ResourceItem <> nil) and Storage.IsReminderByResourceAvailable then
      Result := HasReminderForResourceID(ResourceItem.ResourceID);
  end;
end;

procedure TcxSchedulerEventCellViewInfo.Initialize;
begin
  FBorders := cxBordersAll;
  FEventStart := TruncTime(Event.Start);
  FEventFinish := TruncTime(Event.Finish);
  FIsHeaderEvent := GetIsHeaderEvent;
  FStartRect := cxNullRect;
  FFinishRect := cxNullRect;
  FTimeLineRect := cxNullRect;
  ViewData.ShowTimeLine := ViewData.ShowTimeLine and IsTimeLineVisible;
  InitStandardEventImages;
  CalculateVisibility;
  CalculateCaptions;
end;

procedure TcxSchedulerEventCellViewInfo.InitHitTest(
  AHitTest: TcxSchedulerCustomResourceViewHitTest);
begin
  AHitTest.FEventCell := Self;
  AHitTest.FEventBounds := FClipRect;
  AHitTest.FDragKind := edkMoveEvent;
  CalculateNeedHint;
  AHitTest.FNeedShowHint := FHintNeeded;
end;

procedure TcxSchedulerEventCellViewInfo.InitHitTestForHorzEvent(
  AHitTest: TcxSchedulerCustomResourceViewHitTest);
begin
  if (bLeft in Borders) and ((AHitTest.HitX - Bounds.Left) <= cxHitDelta) then
    AHitTest.FDragKind := edkResizeStart
  else
    if (bRight in Borders) and ((Bounds.Right - AHitTest.HitX) <= cxHitDelta) then
      AHitTest.FDragKind := edkResizeEnd;
end;

procedure TcxSchedulerEventCellViewInfo.InitStandardEventImages;
var
  AutoHide: Boolean;
begin
  AutoHide := CanAutoHideStandardImages;
  with Event do
  begin
    if HasReminder then
      Images.AddStandardImage(eitReminder, AutoHide);
    case EventType of
      etOccurrence: Images.AddStandardImage(eitRecurrence, AutoHide);
      etCustom: Images.AddStandardImage(eitCustomOccurrence, AutoHide);
    end;
  end;
end;

function TcxSchedulerEventCellViewInfo.IsHorzSizing: Boolean;
begin
  Result := True;
end;

function TcxSchedulerEventCellViewInfo.IsNeedDrawTime: Boolean;
begin
  Result := ViewData.ShowFinishTime or ViewData.ShowStartTime;
end;

function TcxSchedulerEventCellViewInfo.IsTimeLineVisible: Boolean;
begin
  Result := False;
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

function TcxSchedulerEventCellViewInfo.CalculateMessageHeight(const R: TRect): Integer;

  function CreateEditViewData: TcxCustomEditViewData;
  begin
    with ViewData do
      Result := EditProperties.CreateViewData(EditStyle, True);
  end;

var
  AEditViewData: TcxCustomEditViewData;
  ASize: TcxEditSizeProperties;
begin
  AEditViewData := CreateEditViewData;
  try
    AssignEditStyle(ViewData.EditStyle);
    AEditViewData.ContentOffset := cxSimpleRect;
    ASize.MaxLineCount := 0;
    ASize.Height := -1;
    ASize.Width := cxRectWidth(R);
    Result := AEditViewData.GetEditSize(Canvas, Message, ASize).cy;
  finally
    AEditViewData.Free;
  end;
end;

function TcxSchedulerEventCellViewInfo.GetBorderColor: TColor;
begin
  Result := ViewData.BorderColor;
end;

function TcxSchedulerEventCellViewInfo.GetCaption: string;
begin
  Result := ViewData.Caption;
end;

function TcxSchedulerEventCellViewInfo.GetCaptionBounds(const R: TRect): TRect;
begin
  Result := R;
  if Length(ViewData.Caption) > 0 then
    Canvas.TextExtent(ViewData.Caption, Result, cxDrawTextFlags[IsDetailCaption])
  else
    Canvas.TextExtent('Wg', Result, cxDrawTextFlags[IsDetailCaption]);
end;

function TcxSchedulerEventCellViewInfo.GetContentStart: TDateTime;
begin
  Result := ViewData.ContentStart;
end;

function TcxSchedulerEventCellViewInfo.GetEvent: TcxSchedulerControlEvent;
begin
  Result := ViewData.Event;
end;

function TcxSchedulerEventCellViewInfo.GetHint: string;
begin
  if not FHintAssigned then
    FHint := ViewData.GetEventHint(Event);
  FHintAssigned := True;
  Result := FHint;
end;

function TcxSchedulerEventCellViewInfo.GetIsHeaderEvent: Boolean;
begin
  Result := Event.AllDayEvent or ((Event.Finish - Event.Start) >= 1);
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
    0: Result := ViewData.ShowFinishTime;
    1: Result := ViewData.ShowStartTime;
    2: Result := ViewData.ShowTimeAsClock;
    3: Result := ViewData.ShowTimeLine;
  else
    Result := False;
  end;
end;

procedure TcxSchedulerEventCellViewInfo.SetBorderColor(AValue: TColor);
begin
  ViewData.BorderColor := AValue;
end;

{ TcxSchedulerMoreEventsButtonViewInfo }

procedure TcxSchedulerMoreEventsButtonViewInfo.Click;
begin
  if Assigned(FOnClick) then
    FOnClick(Self);
end;

procedure TcxSchedulerMoreEventsButtonViewInfo.DoDraw;
begin
  PainterHelper.DrawTransparentImage(Canvas, MoreEventButtonGlyphs,
    Bounds.Left, Bounds.Top, Byte(not IsDown));
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

{ TcxSchedulerContentNavigationButtonViewInfo }

procedure TcxSchedulerContentNavigationButtonViewInfo.Click;
begin
  if Enabled and Assigned(FOnClick) then
    FOnClick(Self);
end;

procedure TcxSchedulerContentNavigationButtonViewInfo.DoDraw;
var
  AState: TcxButtonState;
begin
  if Enabled then
  begin
    if (FHitTest <> nil) and (FHitTest.FContentNavigationButton = Self) then
      AState := cxbsHot
    else
      AState := cxbsNormal;
  end
  else
    AState := cxbsDisabled;
  Painter.DrawSchedulerNavigationButton(Canvas, Bounds, Kind = nbkNext,
    AState, Caption, TextRect, ArrowRect);
end;

procedure TcxSchedulerContentNavigationButtonViewInfo.InitHitTest(
  AHitTest: TcxSchedulerCustomResourceViewHitTest);
begin
  FHitTest := AHitTest;
  inherited InitHitTest(AHitTest);
  AHitTest.SetBitState(htcNavigationButton, True);
  AHitTest.FContentNavigationButton := Self;
end;

function TcxSchedulerContentNavigationButtonViewInfo.GetEnabled: Boolean;
begin
  Result := Abs(Interval) < cxMaxDateTime;
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
    FRotateBitmap := TcxBitmap.CreateSize(Bounds, pf32bit);
    FRotateBitmap.Canvas.Lock;
    FRotateBitmap.cxCanvas.WindowOrg := Bounds.TopLeft;
  end;

begin
  if not Rotated then
    Painter.DrawHeader(Canvas, Bounds, Bounds, [nRight, nLeft], cxBordersAll, cxbsNormal,
      taLeftJustify, vaCenter, False, False, '', nil, clNone, Color, DrawBackground)
  else
  begin
    if FRotateBitmap = nil then
    begin
      CreateRotatedBitmap;
      FDrawRotatedBackground := DrawBackground(FRotateBitmap.cxCanvas, Bounds);

      FRotateBitmap.Rotate(raPlus90, True);

      Painter.DrawHeader(FRotateBitmap.cxCanvas, Rect(0, 0, FRotateBitmap.Width,
        FRotateBitmap.Height), cxNullRect, [nRight, nLeft], cxBordersAll,
        cxbsNormal, taCenter, vaCenter, False, False, '', nil, clNone, Color,
        DrawRotateBackground);

      FRotateBitmap.Rotate(raPlus90, True);
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
  FImages := AResource.Resources.Images;
  FImageIndex := AResource.ActualImageIndex;
end;

{ TcxSchedulerExternalPainter }

procedure TcxSchedulerExternalPainter.DoCustomDrawBackground(
  AViewInfo: TcxSchedulerBackgroundCellViewInfo; var ADone: Boolean);
begin
  if FCommonPainter <> nil then
    FCommonPainter.DoCustomDrawBackground(AViewInfo, ADone);
end;

procedure TcxSchedulerExternalPainter.DoCustomDrawButton(
  AViewInfo: TcxSchedulerMoreEventsButtonViewInfo; var ADone: Boolean);
begin
  if FCommonPainter <> nil then
    FCommonPainter.DoCustomDrawButton(AViewInfo, ADone);
end;

procedure TcxSchedulerExternalPainter.DoCustomDrawContent(
  AViewInfo: TcxSchedulerContentCellViewInfo; var ADone: Boolean);
begin
  if FCommonPainter <> nil then
    FCommonPainter.DoCustomDrawContent(AViewInfo, ADone);
end;

procedure TcxSchedulerExternalPainter.DoCustomDrawDayHeader(
  AViewInfo: TcxSchedulerDayHeaderCellViewInfo; var ADone: Boolean);
begin
  if FCommonPainter <> nil then
    FCommonPainter.DoCustomDrawDayHeader(AViewInfo, ADone);
end;

procedure TcxSchedulerExternalPainter.DoCustomDrawEvent(
  AViewInfo: TcxSchedulerEventCellViewInfo; var ADone: Boolean);
begin
  if FCommonPainter <> nil then
    FCommonPainter.DoCustomDrawEvent(AViewInfo, ADone);
end;

procedure TcxSchedulerExternalPainter.DoCustomDrawGroupSeparator(
  AViewInfo: TcxSchedulerGroupSeparatorCellViewInfo; var ADone: Boolean);
begin
  if FCommonPainter <> nil then
    FCommonPainter.DoCustomDrawGroupSeparator(AViewInfo, ADone);
end;

procedure TcxSchedulerExternalPainter.DoCustomDrawNavigationButton(
  AViewInfo: TcxSchedulerContentNavigationButtonViewInfo; var ADone: Boolean);
begin
  if FCommonPainter <> nil then
    FCommonPainter.DoCustomDrawNavigationButton(AViewInfo, ADone);
end;

procedure TcxSchedulerExternalPainter.DoCustomDrawResourceHeader(
  AViewInfo: TcxSchedulerHeaderCellViewInfo; var ADone: Boolean);
begin
  if FCommonPainter <> nil then
    FCommonPainter.DoCustomDrawResourceHeader(AViewInfo, ADone);
end;

function TcxSchedulerExternalPainter.HasCustomDrawGroupSeparator: Boolean;
begin
  Result := (FCommonPainter <> nil) and
    FCommonPainter.HasCustomDrawGroupSeparator;
end;

function TcxSchedulerExternalPainter.HasCustomDrawResourceHeader: Boolean;
begin
  Result := (FCommonPainter <> nil) and
    FCommonPainter.HasCustomDrawResourceHeader;
end;

procedure TcxSchedulerExternalPainter.DrawAllDayArea(ACanvas: TcxCanvas;
  const ARect: TRect; ABorderColor: TColor; ABorders: TcxBorders;
  AViewParams: TcxViewParams; ASelected: Boolean; ATransparent: Boolean);
begin
  if ATransparent then
    ACanvas.FrameRect(ARect, ABorderColor, 1, ABorders)
  else
    ACanvas.FillRect(ARect, AViewParams, ABorders,  ABorderColor, 1);
end;

procedure TcxSchedulerExternalPainter.DrawCurrentTime(ACanvas: TcxCanvas;
  AColor: TColor; AStart: TDateTime; ABounds: TRect);
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
  PainterHelper.DrawGradientRect(ACanvas, AColor, cxRectSetTop(ABounds, Y - 6, 6));
end;

function TcxSchedulerExternalPainter.NeedDrawSelection: Boolean;
begin
  Result := True;
end;

function TcxSchedulerExternalPainter.DrawCurrentTimeFirst: Boolean;
begin
  Result := True;
end;

procedure TcxSchedulerExternalPainter.DrawEvent(
  AViewInfo: TcxSchedulerEventCellViewInfo);
begin
  with AViewInfo do
    DrawRect(Bounds, Borders, ViewData.BorderColor);
end;

procedure TcxSchedulerExternalPainter.DrawEventAsProgress(
  AViewInfo: TcxSchedulerEventCellViewInfo);
var
  AContent: TRect;
  AProgressRect: TRect;
begin
  with AViewInfo do
  begin
    AContent := cxRectContent(Bounds, Painter.SchedulerEventProgressOffsets);
    AProgressRect := AContent;
    AProgressRect.Right := AProgressRect.Left +
      Trunc(ViewData.TaskComplete / 100 * cxRectWidth(AProgressRect));
    Painter.DrawSchedulerEventProgress(Canvas, Bounds, AProgressRect, ViewParams,
      Transparent);
    Canvas.Brush.Style := bsClear;
    Canvas.Font.Color := Painter.ProgressBarTextColor;
    DrawEventAsProgressText(AViewInfo, AContent, AProgressRect,
      IntToStr(ViewData.TaskComplete) + '%');
  end;
end;

procedure TcxSchedulerExternalPainter.DrawEventAsProgressText(
  AViewInfo: TcxSchedulerEventCellViewInfo; AContent: TRect; AProgressRect: TRect;
  const AText: string);
begin
  Painter.DrawProgressBarText(AViewInfo.Canvas, False, False, AText,
    cxRectCenter(AContent, AViewInfo.Canvas.TextExtent(AText)),
    AContent, AProgressRect);
end;

procedure TcxSchedulerExternalPainter.DrawTimeGridCurrentTime(ACanvas: TcxCanvas;
  AColor: TColor; const ATimeLineRect: TRect);
begin
  ACanvas.FillRect(ATimeLineRect, AColor);
end;

procedure TcxSchedulerExternalPainter.DrawTimeGridHeader(ACanvas: TcxCanvas;
  ABorderColor: TColor; AViewInfo: TcxSchedulerCustomViewInfoItem;
  ABorders: TcxBorders; ASelected: Boolean);
begin
  with AViewInfo do
    DrawRect(Bounds, Borders, ABorderColor);
end;

procedure TcxSchedulerExternalPainter.DrawTimeLine(ACanvas: TcxCanvas;
  const ARect: TRect; AViewParams: TcxViewParams; ABorders: TcxBorders;
  ABorderColor: TColor);
begin
  ACanvas.FillRect(ARect, AViewParams, ABorders, ABorderColor);
end;

procedure TcxSchedulerExternalPainter.DrawTimeRulerBackground(ACanvas: TcxCanvas;
  const ARect: TRect; ABorders: TcxBorders; AViewParams: TcxViewParams;
  ATransparent: Boolean);
begin
  if ATransparent then
    ACanvas.FrameRect(ARect, clBtnShadow, 1, ABorders)
  else
    ACanvas.FillRect(ARect, AViewParams, ABorders,  clBtnShadow, 1);
end;

procedure TcxSchedulerExternalPainter.DrawShadow(ACanvas: TcxCanvas;
  const ARect, AVisibleRect: TRect; ABuffer: TBitmap);
begin
  PainterHelper.DrawShadow(ACanvas, ARect, AVisibleRect, ABuffer);
end;

function TcxSchedulerExternalPainter.GetPainterHelper: TcxSchedulerPainterHelperClass;
begin
  Result := SchedulerHelpersFactory.PainterHelperClass;
end;

function TcxSchedulerExternalPainter.MoreButtonSize(ASize: TSize): TSize;
begin
  Result := ASize;
end;

{ TcxSchedulerCustomResourceView }

constructor TcxSchedulerCustomResourceView.Create(
  AOwner: TcxCustomScheduler);
begin
  inherited Create(AOwner);
  FShowEndTime := True;
  InitializePainter;
end;

destructor TcxSchedulerCustomResourceView.Destroy;
begin
  FinilizePainter;
  inherited Destroy;
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

procedure TcxSchedulerCustomResourceView.InitializePainter;
begin
  if FExternalPainter = nil then
    FExternalPainter := ExternalPainterClass.Create;
end;

procedure TcxSchedulerCustomResourceView.FinilizePainter;
begin
  FExternalPainter := nil;
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

procedure TcxSchedulerCustomResourceView.ClearCachedData;
begin
  ViewInfo.ImageCacheManager.Invalidate;
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

procedure TcxSchedulerCustomResourceView.DoCustomDrawNavigationButton(
  AViewInfo: TcxSchedulerContentNavigationButtonViewInfo; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawNavigationButton) then
    FOnCustomDrawNavigationButton(Self, Canvas, AViewInfo, ADone);
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
  if Active then
  begin
    if (ViewInfo.GroupingKind = gkNone) and (Scheduler.SelResource <> nil) then
      with Controller.Navigation do
        ReplaceSelParams(SelStart, SelFinish, nil)
    else
      if (ViewInfo.GroupingKind <> gkNone) and (Scheduler.SelResource = nil) then
        with Controller.Navigation do
          ReplaceSelParams(SelStart, SelFinish, VisibleResources[0]);
  end;
end;

procedure TcxSchedulerCustomResourceView.DoMouseDown(AButton: TMouseButton; AShift: TShiftState; X, Y: Integer);
begin
  inherited DoMouseDown(AButton, AShift, X, Y);
  if AButton = mbRight then
    CheckSelectOnRightClick;
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
var
  ACustomPainter: IcxSchedulerCommonViewItemsPainter;
begin
  if not Supports(TObject(Scheduler), IcxSchedulerCommonViewItemsPainter, ACustomPainter) then
    ACustomPainter := nil;
  InitializePainter;
  ExternalPainter.Painter := LookAndFeelPainter;
  ExternalPainter.CommonPainter := ACustomPainter;
  Result := ExternalPainter;
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

function TcxSchedulerCustomResourceView.GetEventHintText(AEvent: TcxSchedulerControlEvent): string;
var
  AViewInfo: TcxSchedulerEventCellViewInfo;
begin
  if FindEventViewInfo(AEvent, NullDate, nil, AViewInfo) then
    Result := AViewInfo.Hint
  else
    Result := inherited GetEventHintText(AEvent);
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

function TcxSchedulerCustomResourceView.HasCustomDrawGroupSeparator: Boolean;
begin
  Result := Assigned(FOnCustomDrawGroupSeparator) or
    ExternalPainter.HasCustomDrawGroupSeparator;
end;
function TcxSchedulerCustomResourceView.HasCustomDrawResourceHeader: Boolean;
begin
  Result := Assigned(FOnCustomDrawResourceHeader) or
    ExternalPainter.HasCustomDrawResourceHeader;
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

procedure TcxSchedulerCustomResourceView.LookAndFeelChanged(
  Sender: TcxLookAndFeel; AChangedValues: TcxLookAndFeelValues);
begin
  ViewInfo.ImageCacheManager.Invalidate;
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

procedure TcxSchedulerCustomResourceView.CheckSelectOnRightClick;
var
  ATime: TDateTime;
  AResource: TcxSchedulerStorageResourceItem;
begin
  if Scheduler.OptionsBehavior.SelectOnRightClick and
    not IsRelevantSelection(ATime, AResource) and HitTest.HitAtTime then
  begin
    if AResource <> nil then
      Scheduler.SelectTime(ATime, ATime, AResource)
    else
      Scheduler.SelectTime(ATime, ATime, Scheduler.SelResource)
  end;
end;

function TcxSchedulerCustomResourceView.GetViewInfo: TcxSchedulerCustomResourceViewViewInfo;
begin
  Result := TcxSchedulerCustomResourceViewViewInfo(inherited ViewInfo);
end;

function TcxSchedulerCustomResourceView.IsRelevantSelection(out ATime: TDateTime; out AResource: TcxSchedulerStorageResourceItem): Boolean;
begin
  ATime := HitTest.Time;
  if ATime < 1 then
    ATime := ATime + DateOf(Scheduler.SelStart);
  AResource := HitTest.Resource;
  Result := ((ATime >= Scheduler.SelStart) and (ATime < Scheduler.SelFinish)) and
    ((Scheduler.SelResource = AResource) or (AResource = nil));
end;

procedure TcxSchedulerCustomResourceView.SetEventImagesLayout(
  const AValue: TcxSchedulerEventImagesLayout);
begin
  if FEventImagesLayout <> AValue then
  begin
    FEventImagesLayout := AValue;
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
    if (FPrevAdapter <> Self) and FView.Active then
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
  ACount, I: Integer;
  AResourceViewInfo: TcxSchedulerResourceViewInfo;
begin
  if Resources = nil then Exit;
  Scheduler.ValidateFirstVisibleResourceIndex;
  ACount := Resources.VisibleResourceCount;
  with Scheduler.OptionsView do
  begin
    if (ResourcesPerPage > 0) and (ACount > ResourcesPerPage) then
      ACount := ResourcesPerPage;
  end;
  for I := 0 to ACount - 1 do
  begin
    AResourceViewInfo := TcxSchedulerResourceViewInfo.Create(
      Resources.VisibleResources[Scheduler.FirstVisibleResourceIndex + I]);
    AResources.Add(AResourceViewInfo);
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

function TcxCustomResourceViewAdapter.GetActualStart: TDateTime;
begin
  Result := PrintFrom;
end;

function TcxCustomResourceViewAdapter.GetActualFinish: TDateTime;
begin
  Result := PrintTo;
end;

function TcxCustomResourceViewAdapter.GetCompressWeekends: Boolean;
begin
  Result := View.GetCompressWeekEnd;
end;

function TcxCustomResourceViewAdapter.GetDontPrintFreeTime: Boolean;
begin
  Result := False;
end;

function TcxCustomResourceViewAdapter.GetDontPrintWeekEnds: Boolean;
begin
  Result := False;
end;

function TcxCustomResourceViewAdapter.GetHideSelection: Boolean;
begin
  Result := View.OptionsView.HideSelection and not View.Scheduler.IsFocused;
end;

function TcxCustomResourceViewAdapter.GetIsPrinting: Boolean;
begin
  Result := False;
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
var
  AEventHeight, AIconHeight: Integer;
  AImages: TCustomImageList;
begin
  with View do
  begin
    AEventHeight := OptionsView.EventHeight;
    AImages := Scheduler.EventImages;
  end;
  with ViewInfo do
  begin
    Result := GetFontHeight(StylesAdapter.GetEventParams(nil)) + 2 * cxTextOffset;
    if AEventHeight = 0 then
    begin
      if AImages <> nil then
        AIconHeight := Max(PainterHelper.IconsHeight, AImages.Height)
      else
        AIconHeight := PainterHelper.IconsHeight;
      Result := Max(AIconHeight + cxTextOffset + 2 * cxEventImagesOffset, Result);
    end
    else
      Result := Max(AEventHeight, Result);
  end;
end;

function TcxCustomResourceViewAdapter.GetPainterHelper: TcxSchedulerPainterHelperClass;
begin
  Result := TcxSchedulerHelpersFactory.PainterHelperClass;
end;

function TcxCustomResourceViewAdapter.GetResourceNavigator: TcxSchedulerResourceNavigator;
begin
  Result := View.Scheduler.ResourceNavigator;
end;

function TcxCustomResourceViewAdapter.GetResources: TcxSchedulerStorageResourceItems;
begin
  Result := View.Resources;
end;

function TcxCustomResourceViewAdapter.GetScheduler: TcxCustomScheduler;
begin
  Result := View.Scheduler;
end;

function TcxCustomResourceViewAdapter.GetViewInfo: TcxSchedulerCustomResourceViewViewInfo;
begin
  Result := View.ViewInfo;
end;

{ TcxSchedulerEventImageItem }

constructor TcxSchedulerEventImageItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FAutoHide := True;
  FImageIndex := -1;
  FVisible := True;
end;

function TcxSchedulerEventImageItem.GetHeight: Integer;
begin
  Result := Images.Height;
end;

function TcxSchedulerEventImageItem.GetWidth: Integer;
begin
  Result := Images.Width;
end;

{ TcxSchedulerEventImages }

constructor TcxSchedulerEventImages.Create(
  ALayout: TcxSchedulerEventImagesLayout);
begin
  inherited Create(TcxSchedulerEventImageItem);
  FLayout := ALayout;
  FItemHeight := EventImages.Height;
  FItemWidth := EventImages.Width;
end;

function TcxSchedulerEventImages.Add(AImageIndex: Integer;
  AutoHide: Boolean = True): TcxSchedulerEventImageItem;
begin
  if (FImages = nil) or ((AImageIndex < 0) or (AImageIndex >= FImages.Count)) then
  begin
    Result := nil;
    Exit;
  end;
  Result := TcxSchedulerEventImageItem(inherited Add);
  Result.FImageIndex := AImageIndex;
  Result.AutoHide := AutoHide;
  Result.FImageType := eitCustom;
  Result.FImages := FImages;
end;

function TcxSchedulerEventImages.AddStandardImage(
  AImageType: TcxSchedulerEventImageType;
  AutoHide: Boolean = True): TcxSchedulerEventImageItem;
const
  Indexes: array[TcxSchedulerEventImageType] of TImageIndex = (4, 2, 3, -1);
begin
  Result := TcxSchedulerEventImageItem(inherited Add);
  Result.AutoHide := AutoHide;
  Result.FImageType := AImageType;
  Result.FImages := EventImages;
  Result.FImageIndex := Indexes[AImageType];
end;

function TcxSchedulerEventImages.Calculate(const R: TRect): Integer;
begin
  case FLayout of
    eilAuto: Result := CalculateImages(R);
    eilHorizontal: Result := CalculateSingleLineImages(R);
  else
    Result := CalculateSingleColumnImages(R);
  end;
end;

procedure TcxSchedulerEventImages.CalculateForCols(AVisibleImages: TList;
  const ATopLeft: TPoint; AColCount: Integer);
var
  ARow, ACol, AIndex: Integer;
begin
  AIndex := 0;
  ACol := 0;
  ARow := 0;
  while AIndex < TotalVisibleImageCount do
  begin
    SetItemBounds(TcxSchedulerEventImageItem(AVisibleImages[AIndex]),
      ATopLeft.X + ACol * (ItemWidth + cxEventImagesGap),
      ATopLeft.Y + ARow * (ItemHeight + cxEventImagesGap));
    if ACol = AColCount - 1 then
    begin
      ACol := 0;
      Inc(ARow);
    end
    else Inc(ACol);
    Inc(AIndex);
  end;
end;

function TcxSchedulerEventImages.CalculateImages(const R: TRect): Integer;
var
  I, AWidth, AHeight, ACount, ARows, AColIndex,
  ARowIndex: Integer;
  L: TList;
  RS: TSize;

  procedure CheckAutoHideItems;
  var
    I: Integer;
    AItem: TcxSchedulerEventImageItem;
  begin
    if ACount >= L.Count then Exit;
    for I := L.Count - 1 downto 0 do
    begin
      AItem := TcxSchedulerEventImageItem(L[I]);
      if AItem.AutoHide then
      begin
        AItem.FHidden := True;
        L.Delete(I);
        if ACount >= L.Count then break;
      end;
    end;
  end;

begin
  AHeight := ItemHeight + cxEventImagesGap;
  RS := cxRectSize(R);
  ARows := Max(1, RS.cy div AHeight);
  if ARows = 1 then
  begin
    Result := CalculateSingleLineImages(R);
    Exit;
  end;
  Result := 0;
  L := CreateVisibleList;
  try
    if L.Count = 0 then Exit;
    AWidth := ItemWidth + cxEventImagesGap;
    ACount := Max(1, RS.cx div AWidth) * ARows;
    CheckAutoHideItems;
    AColIndex := 0;
    ARowIndex := 0;
    for I := 0 to L.Count - 1 do
    begin
      SetItemBounds(TcxSchedulerEventImageItem(L[I]),
        R.Left + AColIndex * AWidth,
        R.Top + ARowIndex * AHeight);
      Result := Max(Result, (AColIndex + 1) * AWidth);
      Inc(ARowIndex);
      if ARowIndex = ARows then
      begin
        Inc(AColIndex);
        ARowIndex := 0;
      end;
    end;
    FVisibleImageCount := L.Count;
  finally
    L.Free;
  end;
end;

function TcxSchedulerEventImages.CalculateSingleLineImages(const R: TRect; ARightLimit: Integer = 0): Integer;
var
  I, ALeft, AImageWidth, ATotalWidth, ARectWidth: Integer;
  L: TList;
  AItem: TcxSchedulerEventImageItem;

  procedure CheckAutoHideItems;
  var
    I: Integer;
    AItem: TcxSchedulerEventImageItem;
  begin
    if ARectWidth >= ATotalWidth then Exit;
    if ARightLimit > 0 then
      ARectWidth := Min(ARightLimit, Max(ARectWidth, ForceVisibleWidth));
    for I := L.Count - 1 downto 0 do
    begin
      AItem := TcxSchedulerEventImageItem(L.List^[I]);
      if AItem.AutoHide then
      begin
        AItem.FHidden := True;
        Dec(ATotalWidth, AImageWidth);
        L.Delete(I);
        if ARectWidth >= ATotalWidth then break;
      end;
    end;
  end;

begin
  Result := 0;
  L := CreateVisibleList;
  try
    if L.Count = 0 then Exit;
    ATotalWidth := TotalVisibleWidth;
    ARectWidth := R.Right - R.Left;
    AImageWidth := ItemWidth + cxEventImagesGap;
    CheckAutoHideItems;
    ALeft := R.Left;
    for I := 0 to L.Count - 1 do
    begin
      AItem := TcxSchedulerEventImageItem(L.List^[I]);
      SetItemBounds(AItem, ALeft, R.Top);
      Inc(ALeft, AImageWidth);
      Inc(Result, AImageWidth);
    end;
    FVisibleImageCount := L.Count;
  finally
    L.Free;
  end;
end;

function TcxSchedulerEventImages.CalculateSingleColumnImages(const R: TRect): Integer;
var
  I, ATop, AWidth, AHeight, ATotalHeight: Integer;
  RS: TSize;
  L: TList;

  procedure CheckAutoHideItems;
  var
    I: Integer;
    AItem: TcxSchedulerEventImageItem;
  begin
    if RS.cy + cxEventImagesGap >= ATotalHeight then Exit;
    for I := L.Count - 1 downto 0 do
    begin
      AItem := TcxSchedulerEventImageItem(L.List^[I]);
      if AItem.AutoHide then
      begin
        AItem.FHidden := True;
        Dec(ATotalHeight, AHeight);
        L.Delete(I);
        if RS.cy + cxEventImagesGap >= ATotalHeight then break;
      end;
    end;
  end;

  function CanAutoHideAllItems: Boolean;
  var
    I: Integer;
  begin
    Result := True;
    for I := 0 to L.Count - 1 do
      if not TcxSchedulerEventImageItem(L.List^[I]).AutoHide then
      begin
        Result := False;
        break;
      end;
  end;

begin
  Result := 0;
  L := CreateVisibleList;
  try
    if L.Count = 0 then Exit;
    ATotalHeight := TotalVisibleHeight;
    RS := cxRectSize(R);
    AWidth := ItemWidth + cxEventImagesGap;
    if (RS.cx < AWidth) and CanAutoHideAllItems then Exit;
    AHeight := ItemHeight + cxEventImagesGap;
    CheckAutoHideItems;
    if L.Count = 0 then Exit;
    Result := AWidth;
    ATop := R.Top;
    for I := 0 to L.Count - 1 do
    begin
      SetItemBounds(TcxSchedulerEventImageItem(L.List^[I]), R.Left, ATop);
      Inc(ATop, AHeight);
    end;
    FVisibleImageCount := L.Count;
  finally
    L.Free;
  end;
end;

function TcxSchedulerEventImages.CreateVisibleList: TList;
var
  I: Integer;
  AItem: TcxSchedulerEventImageItem;
begin
  FVisibleImageCount := 0;
  FForceVisibleHeight := 0;
  FForceVisibleWidth := 0;
  FTotalVisibleImageCount := 0;
  Result := TList.Create;
  for I := 0 to Count - 1 do
  begin
    AItem := Items[I];
    if AItem.Visible then
    begin
      Inc(FTotalVisibleImageCount);
      if not AItem.AutoHide then
      begin
        Inc(FForceVisibleHeight, ItemHeight + cxEventImagesGap);
        Inc(FForceVisibleWidth, ItemWidth + cxEventImagesGap);
      end;
      AItem.FHidden := False;
      Result.Add(AItem);
    end
    else AItem.FHidden := True;
  end;
  FTotalVisibleWidth := (ItemWidth + cxEventImagesGap) * Result.Count;
  FTotalVisibleHeight := (ItemHeight + cxEventImagesGap) * Result.Count;
end;

procedure TcxSchedulerEventImages.Init(AImages: TCustomImageList);
begin
  FVisibleImageCount := 0;
  FImages := AImages;
  if (FImages <> nil) then
  begin
    if FImages.Height > FItemHeight then FItemHeight := FImages.Height;
    if FImages.Width > FItemWidth then FItemWidth := FImages.Width;
  end;
end;

function TcxSchedulerEventImages.Offset(ADeltaX, ADeltaY: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    with Items[I] do
    begin
      if not FHidden then
      begin
        FBounds := cxRectOffset(FBounds, ADeltaX, ADeltaY);
        Inc(Result, ItemWidth + cxEventImagesGap);
      end;
    end;
end;

procedure TcxSchedulerEventImages.SetItemBounds(
  AItem: TcxSchedulerEventImageItem; ALeft, ATop: Integer);
begin
  Inc(ALeft, Max(0, (ItemWidth - AItem.Width) div 2));
  Inc(ATop, Max(0, (ItemHeight - AItem.Height) div 2));
  AItem.FBounds := cxRectBounds(ALeft, ATop, AItem.Width, AItem.Height);
end;

function TcxSchedulerEventImages.GetImageItem(
  AIndex: Integer): TcxSchedulerEventImageItem;
begin
  Result := TcxSchedulerEventImageItem(inherited Items[AIndex]);
end;

{ TcxSchedulerCachedImage }

constructor TcxSchedulerCachedImage.Create;
begin
  inherited;
  FImage := TcxBitmap.CreateSize(0, 0, pf32bit);
end;

destructor TcxSchedulerCachedImage.Destroy;
begin
  FreeAndNil(FImage);
  inherited Destroy;
end;

procedure TcxSchedulerCachedImage.Invalidate;
begin
  Image.SetSize(0, 0);
end;

function TcxSchedulerCachedImage.IsValid(AItem: TcxSchedulerCustomViewInfoItem): Boolean;
begin
  Result := (Image.Width = AItem.Width) and (Image.Height = AItem.Height);
end;

procedure TcxSchedulerCachedImage.Update(AItem: TcxSchedulerCustomViewInfoItem);
begin
  if not cxRectIsEmpty(AItem.Bounds) then
  begin
    Image.SetSize(AItem.Width, AItem.Height);
    Image.cxCanvas.Canvas.Lock;
  end;
end;

{ TcxSchedulerResourceHeaderCachedImage }

function TcxSchedulerResourceHeaderCachedImage.IsValid(AItem: TcxSchedulerCustomViewInfoItem): Boolean;
begin
  Result := inherited IsValid(AItem);
  if Result then
  begin
    Result := (TcxSchedulerHeaderCellViewInfo(AItem).DisplayText = FDisplayText) and
      (TcxSchedulerHeaderCellViewInfo(AItem).DateTime = FDateTime);
  end;
end;

procedure TcxSchedulerResourceHeaderCachedImage.Update(AItem: TcxSchedulerCustomViewInfoItem);
begin
  inherited Update(AItem);
  FDisplayText := TcxSchedulerHeaderCellViewInfo(AItem).DisplayText;
  FDateTime := TcxSchedulerHeaderCellViewInfo(AItem).DateTime;
end;

{ TcxSchedulerResourceHeaderCachedImageList }

function TcxSchedulerResourceHeaderCachedImageList.Add(AItem: TcxSchedulerHeaderCellViewInfo): TcxSchedulerResourceHeaderCachedImage;
begin
  Result := TcxSchedulerResourceHeaderCachedImage.Create;
  if AItem.Resource <> nil then
    Result.FResourceItem := AItem.Resource.ResourceItem;
  inherited Add(Result);
end;

function TcxSchedulerResourceHeaderCachedImageList.GetCacheForItem(
  AItem: TcxSchedulerHeaderCellViewInfo): TcxSchedulerResourceHeaderCachedImage;

  function GetResourceItem(AItem: TcxSchedulerHeaderCellViewInfo): TcxSchedulerStorageResourceItem;
  begin
    if AItem.Resource = nil then
      Result := nil
    else
      Result := AItem.Resource.ResourceItem;
  end;

var
  I: Integer;
  ACachedItem: TcxSchedulerResourceHeaderCachedImage;
begin
  Result := nil;
  for I := 0 to Count - 1 do
  begin
    ACachedItem := TcxSchedulerResourceHeaderCachedImage(Items[I]);
    if ACachedItem.FResourceItem = GetResourceItem(AItem) then
    begin
      Result := ACachedItem;
      Break;
    end;
  end;
  if Result = nil then
    Result := Add(AItem);
end;

{ TcxSchedulerImageCacheManager }

constructor TcxSchedulerImageCacheManager.Create;
begin
  FResourceHeaders := TcxSchedulerResourceHeaderCachedImageList.Create;
  FSeparator := TcxSchedulerCachedImage.Create;
end;

destructor TcxSchedulerImageCacheManager.Destroy;
begin
  FResourceHeaders.Free;
  FSeparator.Free;
  inherited Destroy;
end;

procedure TcxSchedulerImageCacheManager.Invalidate;
begin
  ResourceHeaders.Clear;
  Separator.Invalidate;
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
  FNavigationButtons := TcxSchedulerViewInfoCellList.Create;
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
  // cache
  FImageCacheManager := CreateImageCacheManager;
end;

destructor TcxSchedulerCustomResourceViewViewInfo.Destroy;
begin
  HotContentNavigationButton := nil;
  FreeAndNil(FImageCacheManager);
  FEventImages := nil;
  FResources.Free;
  FButtons.Free;
  FNavigationButtons.Free;
  FCells.Free;
  FreeAndNil(FContentNavigationIntervals);
  inherited Destroy;
end;

procedure TcxSchedulerCustomResourceViewViewInfo.Calculate;
begin
  if ScreenCanvas = nil then
    ScreenCanvas := TcxScreenCanvas.Create;
  try
    Supports(TObject(View.Scheduler), IcxSchedulerEventImages, FEventImages);
    FPrimaryPage := Adapter.GetPrimaryPage;
    Adapter.DoInitialize(FSelectedDays, FEvents);
    FHasVisibleBounds := GetHasVisibleBounds;
    FPrintWeekEnds := not Adapter.DontPrintWeekEnd;
    FPagesPerWeek := Adapter.PagesPerWeek;
    FPageBounds := Adapter.GetPageBounds;
    FCanSelected := not Adapter.GetHideSelection;
    inherited Calculate;
  finally
    FreeAndNil(ScreenCanvas);
  end;
end;

procedure TcxSchedulerCustomResourceViewViewInfo.CalculateHitTest(
  AHitTest: TcxSchedulerCustomResourceViewHitTest);
begin
  FEventCells.CalculateHitTest(AHitTest);
  if not FNavigationButtons.CalculateHitTest(AHitTest) then
    if not FDayHeaderCells.CalculateHitTest(AHitTest) then
      if not FResourceHeaderCells.CalculateHitTest(AHitTest) then
        if not FHeaderContainerCells.CalculateHitTest(AHitTest) then
          if not FButtons.CalculateHitTest(AHitTest) then
            if not FContentCells.CalculateHitTest(AHitTest) then
              FGroupSeparatorCells.CalculateHitTest(AHitTest);
  if AHitTest.HitAtButton and AHitTest.HitAtEvent then
  begin
    AHitTest.FHitObject := nil;
    AHitTest.FEventCell := nil;
  end;
  HotTrackNavigationButtons(AHitTest);
end;

procedure TcxSchedulerCustomResourceViewViewInfo.InitScrollBarsParameters;
begin
  CheckResourceNavigator;
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

procedure TcxSchedulerCustomResourceViewViewInfo.MouseLeave;
begin
  if View.HitTest is TcxSchedulerCustomResourceViewHitTest then
    SetHitContentNavigationButton(nil, TcxSchedulerCustomResourceViewHitTest(View.HitTest));
end;

function TcxSchedulerCustomResourceViewViewInfo.AddButton(
  ABounds: TRect; const ADateTime: TDateTime;
   AIsDown: Boolean; AEvent: TcxSchedulerEvent): TcxSchedulerMoreEventsButtonViewInfo;
var
  AMoreButtonSize: TSize;
begin
  ABounds := cxRectInflate(ABounds, -cxTextOffset, -cxTextOffset);
  AMoreButtonSize := View.ExternalPainter.MoreButtonSize(
    Size(PainterHelper.MoreButtonWidth, PainterHelper.MoreButtonHeight));

  ABounds.Left := ABounds.Right - AMoreButtonSize.cx;
  if AIsDown then
    ABounds.Top := ABounds.Bottom - AMoreButtonSize.cy
  else
    ABounds.Bottom := ABounds.Top + AMoreButtonSize.cy;
  if DateOf(ADateTime) = 0 then
    CreateCellInstance(GetMoreEventButtonClass, ABounds,
      Styles.GetBackgroundParams, Result)
  else
    CreateCellInstance(GetMoreEventButtonClass, ABounds,
      GetContentParams(ADateTime, nil), Result);
  Result.FIsDown := AIsDown;
  Result.FDateTime := ADateTime;
  Result.FOnClick := OnMoreEventsButtonClick;
  Result.Event := AEvent;
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

procedure TcxSchedulerCustomResourceViewViewInfo.AddContentNavigationButton(
  const AColumnRect: TRect; AResourceIndex: Integer;
  AColumnPositionInResource: TcxSchedulerColumnPositionInResource);

  procedure AddAppointedButton(AKind: TcxSchedulerContentNavigationButtonKind);
  const
    AButtonTexts: array[TcxSchedulerContentNavigationButtonKind] of pointer =
      (@scxPrevAppointment, @scxNextAppointment);
  var
    AButton: TcxSchedulerContentNavigationButtonViewInfo;
    AWidth, AButtonOffset: Integer;
  begin
    CalculateNavigationButtonParams(AColumnRect, AKind, AWidth);

    AButtonOffset := NavigationButtonOffset(AKind, AResourceIndex);
    OffsetRect(FButtonBounds, AButtonOffset, 0);
    CreateCellInstance(TcxSchedulerContentNavigationButtonViewInfo, FButtonBounds,
      Styles.GetBackgroundParams, AButton);
    AButton.FOnClick := OnContentNavigationButtonClick;
    AssignResourceID(AButton, AResourceIndex);
    AButton.FKind := AKind;
    OffsetRect(FButtonTextRect, AButtonOffset, 0);
    AButton.FTextRect := FButtonTextRect;
    OffsetRect(FButtonArrowRect, AButtonOffset, 0);
    AButton.FArrowRect := FButtonArrowRect;
    AButton.Caption := cxGetResourceString(AButtonTexts[AKind]);
    FNavigationButtons.Add(AButton);
    AddContentNavigationIntervalItem(AResourceIndex);
  end;

var
  AColumnHeight: Integer;
begin
  if Adapter.IsPrinting then Exit;

  AColumnHeight := GetCorrectColumnHeight(AColumnRect);
  if Scheduler.OptionsView.ShowNavigationButtons and
    not AreThereEventsInVisibleInterval(AResourceIndex) and
    (AColumnPositionInResource <> cprIndefinite) and
    (AColumnHeight > ContentNavigationButtonReducedHeight) then
  begin
    case AColumnPositionInResource of
      cprFirst: AddAppointedButton(nbkPrevious);
      cprLast: AddAppointedButton(nbkNext);
      cprSingle:
        begin
          AddAppointedButton(nbkPrevious);
          AddAppointedButton(nbkNext);
        end;
    end;
  end;
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
  AViewData: TcxSchedulerEventViewData;
  AImmediateCalculate: Boolean = True): TcxSchedulerEventCellViewInfo;
begin
  Result := CreateEventCellViewInfo(AViewData);
  if (FEventImages <> nil) and FEventImages.SupportEventImages then
  begin
    Result.Images.Init(FEventImages.GetImages);
    FEventImages.DoInitEventImages(AViewData.Event, Result.Images);
  end;
  if AImmediateCalculate then Result.Calculate;
  EventCells.Add(Result);
  SetResourceHasVisibleEvent(AViewData.Event);
end;

function TcxSchedulerCustomResourceViewViewInfo.AddGroupHorzSeparator(
  APos: Integer): TcxSchedulerGroupSeparatorCellViewInfo;
begin
  Result := AddGroupSeparator(cxRectSetTop(Bounds, APos, SeparatorWidth));
  if Result = nil then Exit;
  Result.Rotated := True;
  if CanCacheGroupSeparator(Result) then
    Result.Cache := ImageCacheManager.Separator;
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

procedure TcxSchedulerCustomResourceViewViewInfo.AddResourceBounds(
  AResourceIndex: Integer; const ABounds: TRect);
begin
  if Length(FResourceBounds) <> ResourceCount then
    SetLength(FResourceBounds, ResourceCount);
  FResourceBounds[AResourceIndex] := ABounds;
end;

function TcxSchedulerCustomResourceViewViewInfo.AddResourceHeader(
  const AIndex: Integer; const ABounds: TRect): TcxSchedulerHeaderCellViewInfo;
begin
  CreateCellInstance(TcxSchedulerHeaderCellViewInfo, ABounds,
    StylesAdapter.GetResourceHeaderParams(GetResourceItemByIndex(AIndex)), Result);
  Result.FIsResourceHeader := AIndex >= 0;
  if Result.IsResourceHeader then
  begin
    Result.FDisplayText := ResourceCaptions[AIndex];
    AssignResourceID(Result, AIndex);
    with Resources[AIndex] do
    begin
      Result.FAutoHeight := ResourceHeaders.MultilineCaptions;
      Result.FImageIndex := ImageIndex;
      Result.FImagePosition := ImagePosition;
      Result.FImages := Images;
    end;
  end;
  ResourceHeaderCells.Add(Result);
  if CanCacheResourceHeader(Result) then
    Result.Cache := ImageCacheManager.ResourceHeaders.GetCacheForItem(Result);
end;

procedure TcxSchedulerCustomResourceViewViewInfo.AfterCalculate;
begin
  inherited AfterCalculate;
  if FHideClones then
    HideCloneEventsOnDragDrop;
  if FHideSource then
    HideSourceEventsOnDragDrop;
  if Scheduler.OptionsView.ShowNavigationButtons then
    SetContentNavigationButtonsIntervals;
end;

function TcxSchedulerCustomResourceViewViewInfo.AreThereEventsInVisibleInterval(
  AResourceIndex: Integer): Boolean;
var
  AResourceID: Variant;
begin
  Result := (((GetGroupingKind = gkNone) or (AResourceIndex < 0))
    and (HasVisibleEvents or (GetMoreEventsButtonCount(-1) <> 0))) or
    ((GetGroupingKind <> gkNone) and (AResourceIndex >= 0) and
    ((GetEventForResourceCount(AResourceIndex, AResourceID) <> 0) or
    (GetEventWithoutResourceCount <> 0)));
end;

procedure TcxSchedulerCustomResourceViewViewInfo.AssignResourceID(
  ACell: TcxSchedulerCustomResourceViewInfoItem; AIndex: Integer);
begin
  if AIndex >= 0 then
    ACell.Resource := Resources[AIndex];
  ACell.FIsResourceAssigned := AIndex >= 0;
end;

procedure TcxSchedulerCustomResourceViewViewInfo.CalculateContentNavigationButtons;
var
  AResourceIndex: Integer;
begin
  if IsDrawContentNavigationButtons then
  begin
    if ResourceCount > 0 then
      for AResourceIndex := 0 to ResourceCount - 1 do
        AddContentNavigationButton(FResourceBounds[AResourceIndex], AResourceIndex,
          cprSingle)
    else
      AddContentNavigationButton(Bounds, -1, cprSingle);
  end;
end;

procedure TcxSchedulerCustomResourceViewViewInfo.CalculateMetrics;
begin
  FHideSelection := View.OptionsView.HideSelection and not View.Scheduler.IsFocused;
  FGroupSeparatorParams := Styles.GetGroupSeparatorParams;
  FTimeLineParams := GetTimeLineParams;
  FSelectionParams := Styles.GetSelectionParams;
  FContentLineHeight := Adapter.GetContentLineHeight;
  FContentFontHeight := cxTextHeight(StylesAdapter.GetContentParams(Now, nil).Font) + cxTextOffset * 2;
  FDayHeaderHeight :=
    LookAndFeelPainter.HeaderHeight(GetFontHeight(StylesAdapter.GetDayHeaderStyle));
  FResourceHeaderHeight :=
    LookAndFeelPainter.HeaderHeight(GetFontHeight(StylesAdapter.GetResourceHeaderStyle));
  FUseResourceImages := HasStorage and View.Scheduler.Storage.Resources.AreImagesUsed;
  if HasStorage then
    FResourceImages := View.Scheduler.Storage.Resources.Images
  else
    FResourceImages := nil;
  if HasStorage then
  begin
    if ResourceHeaders.Height <> 0 then
      FResourceHeaderHeight := ResourceHeaders.Height;
    CalculateResourceHeadersAutoHeight(GetResourceHeaderWidth - cxTextOffset * 3);
    if ResourceHeaders.Height <> 0 then
      FResourceHeaderHeight := ResourceHeaders.Height;
  end;
end;

procedure TcxSchedulerCustomResourceViewViewInfo.CalculateNavigationButtonParams(
  AColumnRect: TRect; AKind: TcxSchedulerContentNavigationButtonKind;
  out AButtonWidth: Integer);
var
  AHeight, AMiddle: Integer;
  AIsCollapsed: Boolean;
begin
  AIsCollapsed := Round(ContentNavigationButtonHeight * 1.5) >=
    GetCorrectColumnHeight(AColumnRect);
  if AIsCollapsed then
    AHeight := ContentNavigationButtonReducedHeight
  else
    AHeight := ContentNavigationButtonHeight;

  AMiddle := (AColumnRect.Top + AColumnRect.Bottom) div 2;
  case AKind of
    nbkPrevious: FButtonBounds := Rect(AColumnRect.Left, AMiddle - AHeight div 2,
      AColumnRect.Left + ContentNavigationButtonWidth, AMiddle + AHeight div 2);
    nbkNext: FButtonBounds := Rect(AColumnRect.Right - ContentNavigationButtonWidth,
      AMiddle - AHeight div 2, AColumnRect.Right, AMiddle + AHeight div 2);
  else
    FButtonBounds := cxNullRect;
  end;
  with ScreenCanvas do
  begin
    SetParams(Styles.GetBackgroundParams);
    LookAndFeelPainter.CalculateSchedulerNavigationButtonRects(
      AKind = nbkNext, AIsCollapsed, TextExtent(cxGetResourceString(@scxPrevAppointment)),
      TextExtent(cxGetResourceString(@scxNextAppointment)), FButtonBounds, FButtonTextRect,
      FButtonArrowRect);
  end;
  AButtonWidth := FButtonBounds.Right - FButtonBounds.Left;
end;

procedure TcxSchedulerCustomResourceViewViewInfo.CalculateResourceHeadersAutoHeight(
  AWidth: Integer);

  function CalculateResourceHeight(AResource: TcxSchedulerStorageResourceItem;
    AWidth: Integer): Integer;
  var
    R: TRect;
    AFont: TFont;
    AText: string;
    AHasImage: Boolean;
  begin
    AFont := Styles.GetResourceHeaderParams(AResource).Font;
    AHasImage := UseResourceImages and (AResource.ActualImageIndex >= 0);
    if AHasImage and (ResourceHeaders.ImagePosition in [ipLeft, ipRight]) then
      AWidth := Max(0, AWidth - (GetResourceImagesSize.cx + cxTextOffset * 2));
    R := Rect(0, 0, Max(AWidth, 2), 0);
    AText := AResource.Resources.GetResourceName(AResource);
    ScreenCanvas.Font.Assign(AFont);
    ScreenCanvas.TextExtent(AText, R,
      MakeTextOutcxFlags(taLeftJustify, vaCenter, ResourceHeaders.MultilineCaptions));
    Result := R.Bottom - R.Top + cxTextOffset * 3;
    SetResourceTextRect(AResource, R);
    if AHasImage then
    begin
      if (ResourceHeaders.ImagePosition in [ipTop, ipBottom]) then
        Inc(Result, GetResourceImagesSize.cy + cxTextOffset * 4)
      else
        Result := Max(Result, GetResourceImagesSize.cy + cxTextOffset * 3);
    end;
  end;

var
  I: Integer;
begin
  AWidth := Max(0, AWidth);
  for I := 0 to Adapter.Resources.VisibleResourceCount - 1 do
    FResourceHeaderHeight := Max(FResourceHeaderHeight, CalculateResourceHeight(
      Adapter.Resources.VisibleResources[I], AWidth));
end;

function TcxSchedulerCustomResourceViewViewInfo.CalculateResourceHeaderWidth: Integer;
var
  I: Integer;
  AWidth: Integer;

  function CalculateWidth(AResource: TcxSchedulerStorageResourceItem): Integer;
  var
    R: TRect;
    AText: string;
    AHasImage: Boolean;
    AViewParams: TcxViewParams;
  begin
    AViewParams := StylesAdapter.GetResourceHeaderParams(AResource);
    Result := 0;
    AHasImage := AResource.ActualImageIndex >= 0;
    AText := AResource.Resources.GetResourceName(AResource);
    if Length(AText) > 0 then
    begin
      R := Rect(0, 0, FResourceHeaderHeight, AWidth);
      if AHasImage and (ResourceHeaders.ImagePosition in [ipTop, ipBottom]) then
        Dec(R.Bottom, ResourceImages.Height + cxTextOffset * 3);
      ScreenCanvas.Font.Assign(AViewParams.Font);
      ScreenCanvas.TextExtent(AText, R, MakeTextOutcxFlags(taLeftJustify,
        vaCenter, ResourceHeaders.MultilineCaptions));
      Result := R.Right - R.Left + cxTextOffset * 3;
      SetResourceTextRect(AResource, R);
      if AHasImage and (ResourceHeaders.ImagePosition in [ipTop, ipBottom]) then
        Result := Max(Result, ResourceImages.Width + cxTextOffset * 4);
    end;
    if AHasImage and (ResourceHeaders.ImagePosition in [ipLeft, ipRight]) then
      Inc(Result, ResourceImages.Width + cxTextOffset * 4);
  end;

begin
  AWidth := GetResourceHeaderWidth - cxTextOffset * 3;
  Result := FResourceHeaderHeight;
  for I := 0 to Adapter.Resources.VisibleResourceCount - 1 do
    Result := Max(Result, CalculateWidth(Adapter.Resources.VisibleResources[I]));
end;

function TcxSchedulerCustomResourceViewViewInfo.CanCalculateNavigationButtons: Boolean;
begin
  Result := Scheduler.OptionsView.ShowNavigationButtons and not Adapter.IsPrinting;
end;

function TcxSchedulerCustomResourceViewViewInfo.CanCacheGroupSeparator(
  AItem: TcxSchedulerGroupSeparatorCellViewInfo): Boolean;
begin
  Result := AItem.Rotated and (AItem.Bitmap = nil) and not View.HasCustomDrawGroupSeparator;
end;

function TcxSchedulerCustomResourceViewViewInfo.CanCacheResourceHeader(
  AItem: TcxSchedulerHeaderCellViewInfo): Boolean;
begin
  Result := (AItem.Bitmap = nil) and not View.HasCustomDrawResourceHeader;
end;

procedure TcxSchedulerCustomResourceViewViewInfo.Clear;
begin
  FResources.Clear;
  GroupSeparatorCells.Clear;
  Buttons.Clear;
  NavigationButtons.Clear;
  ContentCells.Clear;
  EventCells.Clear;
  DayHeaderCells.Clear;
  ResourceHeaderCells.Clear;
  HeaderContainerCells.Clear;
  ClearResourceBounds;
  ClearContentNavigationIntervals;
end;

procedure TcxSchedulerCustomResourceViewViewInfo.ClearResourceBounds;
var
  I: Integer;
begin
  for I := 0 to Length(FResourceBounds) - 1 do
    FResourceBounds[I] := cxNullRect;
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
  TcxSchedulerCustomViewInfoItem(Instance).FExternalPainter := View.ExternalPainter;
end;

function TcxSchedulerCustomResourceViewViewInfo.CreateEventViewData(
  AEvent: TcxSchedulerControlEvent; const ABounds: TRect;
  const AStart, AFinish: TDateTime; AResource: TcxSchedulerResourceViewInfo): TcxSchedulerEventViewData;
var
  ALocation: string;
begin
  Result := TcxSchedulerEventViewData.Create;
  Result.Bounds := ABounds;
  Result.VisibleRect := Bounds;
  Result.Canvas := View.Canvas;
  Result.ContentStart := DateTimeHelper.RoundTime(AStart);
  Result.ExternalPainter := View.ExternalPainter;
{$IFNDEF DEBUGPAINT}
  Result.Bitmap := View.Bitmap;
{$ENDIF}
  Result.GetEventHint := GetEventHint;
  Result.BorderColor := View.OptionsView.EventBorderColor;
  Result.ContentFinish := DateTimeHelper.RoundTime(AFinish);
  Result.Event := AEvent;
  Result.ShowTimeAsClock := View.ShowTimeAsClock;
  Result.TimeLineParams := FTimeLineParams;
  Result.ShowFinishTime := View.ShowEndTime;
  Result.Painter := LookAndFeelPainter;
  Result.ViewParams := StylesAdapter.GetEventParams(AEvent);
  Result.EditProperties := View.GetEditProperties(AEvent);
  Result.EditStyle := View.GetEditStyle(AEvent);
  Result.Resource := AResource;
  if (AEvent <> nil) and AEvent.Shared and (AResource <> nil) then
    AEvent.LockResource(AResource.ResourceID);
  Result.Caption := DoGetEventDisplayText(AEvent);
  AEvent.UnlockResource;
  Result.ImagesLayout := View.EventImagesLayout;
  Result.DrawAsProgress := False;
  Result.TaskComplete := AEvent.TaskComplete;
  Result.TaskStatus := AEvent.TaskStatus;
  ALocation := Trim(AEvent.Location);
  if ALocation <> '' then
    Result.Caption := Result.Caption + ' (' + ALocation + ')';
  Result.LineHeight := FContentLineHeight;
end;

function TcxSchedulerCustomResourceViewViewInfo.CreateEventCellViewInfo(
  AViewData: TcxSchedulerEventViewData): TcxSchedulerEventCellViewInfo;
begin
  Result := TcxSchedulerEventCellViewInfo.Create(AViewData);
end;

function TcxSchedulerCustomResourceViewViewInfo.CreateImageCacheManager: TcxSchedulerImageCacheManager;
begin
  Result := TcxSchedulerImageCacheManager.Create;
end;

procedure TcxSchedulerCustomResourceViewViewInfo.DoCalculate;
var
  Temp: Integer;
begin
  FDayBorderColor := View.OptionsView.DayBorderColor;
  if FDayBorderColor = clDefault then
    FDayBorderColor := clWindowText;
  FEventWithoutResourceCount := 0;
  ExtractResources;
  FGroupingKind := GetGroupingKind;
  if FGroupingKind = gkNone then
    FResources.Clear;
  if SelectedDays.Count = 0 then
    SelectedDays.Add(Date);
  with View.Controller.Navigation do
    Self.FSelResource := GetResourceViewInfoByItem(SelResource, Temp);
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

procedure TcxSchedulerCustomResourceViewViewInfo.DoContentNavigationButtonClick(
  Sender: TcxSchedulerContentNavigationButtonViewInfo);
begin
  TcxCustomSchedulerAccess(Scheduler).PeriodChanged;
  TcxDateNavigatorAccess(Scheduler.DateNavigator).MakeSelectionVisible;
end;

procedure TcxSchedulerCustomResourceViewViewInfo.DoMoreEventsButtonClick(
  Sender: TcxSchedulerMoreEventsButtonViewInfo);
begin
end;

procedure TcxSchedulerCustomResourceViewViewInfo.ExtractResources;
var
  I: Integer;
begin
  Adapter.GetPageResources(FResources);
  for I := 0 to FResources.Count - 1 do
    Resources[I].FImagePosition := ResourceHeaders.ImagePosition;
end;

function TcxSchedulerCustomResourceViewViewInfo.GetBounds: TRect;
begin
  Result := FPageBounds;
end;

function TcxSchedulerCustomResourceViewViewInfo.GetContentNavigationInterval(
  AContentNavigationButton: TcxSchedulerContentNavigationButtonViewInfo): TDateTime;

  function GetContentNavigationInfo(AIndex: Integer): TcxSchedulerContentNavigationInfo;
  begin
    Result := TcxSchedulerContentNavigationInfo(FContentNavigationIntervals[AIndex]);
  end;

  function GetInterval(AIndex: Integer): TDateTime;
  begin
    if AContentNavigationButton.Kind = nbkPrevious then
      Result := - GetContentNavigationInfo(AIndex).FIntervalBefore
    else
      Result := GetContentNavigationInfo(AIndex).FIntervalAfter;
  end;

var
  I: Integer;
begin
  Result := cxMaxDateTime;
  if AContentNavigationButton.Resource = nil then
    Result := GetInterval(0)
  else
    for I := 0 to FContentNavigationIntervals.Count - 1 do
      if VarEqualsSoft(GetContentNavigationInfo(I).FResourceID,
        AContentNavigationButton.Resource.ResourceID) then
      begin
        Result := GetInterval(I);
        Break;
      end;
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

function TcxSchedulerCustomResourceViewViewInfo.GetEventForResourceCount(
  AResourceIndex: Integer; out AResourceID: Variant): Integer;
begin
  Result := Resources[AResourceIndex].VisibleEventCount +
    GetMoreEventsButtonCount(AResourceIndex);
  AResourceID := Resources[AResourceIndex].ResourceID;
end;

function TcxSchedulerCustomResourceViewViewInfo.GetEventWithoutResourceCount: Integer;
begin
  Result := FEventWithoutResourceCount;
end;

function TcxSchedulerCustomResourceViewViewInfo.GetMoreEventButtonClass: TcxSchedulerMoreEventsButtonViewInfoClass;
begin
  Result := TcxSchedulerMoreEventsButtonViewInfo;
end;

function TcxSchedulerCustomResourceViewViewInfo.GetResourceHeaderWidth: Integer;
begin
  Result := GetResourcesContentWidth;
  if ResourceCount > 0 then
    Result := Max(0, (Result - SeparatorWidth * GetSeparatorCount) div ResourceCount);
end;

function TcxSchedulerCustomResourceViewViewInfo.GetResourceImagesSize: TSize;
begin
  if ResourceImages = nil then
    Result := TSize(cxNullSize)
  else
    Result := cxSize(ResourceImages.Width, ResourceImages.Height);
end;

function TcxSchedulerCustomResourceViewViewInfo.GetResourcesContentWidth: Integer;
begin
  Result := FBounds.Bottom - FBounds.Top - FDayHeaderHeight;
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

function TcxSchedulerCustomResourceViewViewInfo.GetSeparatorCount: Integer;
begin
  Result := ResourceCount - 1;
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
  Result := FormatDateTime(dxFormatSettings.LongDateFormat, Days[0]);
  if Days[0] <> Days[DayCount - 1] then
    Result := Result + ' - ' + FormatDateTime(dxFormatSettings.LongDateFormat, Days[DayCount - 1]);
end;

function TcxSchedulerCustomResourceViewViewInfo.GetResourceItemByIndex(
  AIndex: Integer): TcxSchedulerStorageResourceItem;
begin
  Result := nil;
  if AIndex >= 0 then
    Result := Resources[AIndex].ResourceItem;
end;

function TcxSchedulerCustomResourceViewViewInfo.GetResourceViewInfoByItem(
  AItem: TcxSchedulerStorageResourceItem;
  var ResourceViewInfoIndex: Integer): TcxSchedulerResourceViewInfo;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to ResourceCount - 1 do
    if Resources[I].ResourceItem = AItem then
    begin
      Result := Resources[I];
      ResourceViewInfoIndex := I;
    end;
end;

function TcxSchedulerCustomResourceViewViewInfo.GetStartDate(
  Index: Integer): TDateTime;
begin
  Result := SelectedDays[0];
end;

function TcxSchedulerCustomResourceViewViewInfo.HasStorage: Boolean;
begin
  Result := View.Scheduler.Storage <> nil;
end;

function TcxSchedulerCustomResourceViewViewInfo.HasVisibleEvents: Boolean;
begin
  Result := EventCells.Count <> 0;
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

procedure TcxSchedulerCustomResourceViewViewInfo.ReturnVisibleInterval(
  var AStart, AEnd: TDateTime);

   function IsDescreteSelection: Boolean;
   var
     I: Integer;
   begin
     Result := False;
     I := 0;
     while not Result and (I < SelectedDays.Count - 1) do
     begin
       Result := SelectedDays[I] + 1 <> SelectedDays[I + 1];
       Inc(I);
     end;
   end;

begin
  AStart := StartDates[0];
  if IsDescreteSelection then
    AEnd := AStart
  else
    AEnd := AStart + SelectedDays.Count - 1;
end;

function TcxSchedulerCustomResourceViewViewInfo.SetAdapter(
  Adapter: TcxCustomResourceViewAdapter): TcxCustomResourceViewAdapter;
begin
  Result := FAdapter;
  FAdapter := Adapter;
  FStylesAdapter := FAdapter.GetStylesAdapter;
end;

procedure TcxSchedulerCustomResourceViewViewInfo.SetResourceHasVisibleEvent(
  AEvent: TcxSchedulerControlEvent);
var
  AResourceIndex: Integer;
  AResourceFound: Boolean;
begin
  AResourceFound := False;
  for AResourceIndex := 0 to ResourceCount - 1 do
    if AEvent.IsSharedWithResource(Resources[AResourceIndex].ResourceID) then
    begin
      Resources[AResourceIndex].VisibleEventCount :=
        Resources[AResourceIndex].VisibleEventCount + 1;
      AResourceFound := True;
    end;
  if not AResourceFound then
    Inc(FEventWithoutResourceCount);
end;

procedure TcxSchedulerCustomResourceViewViewInfo.SetResourceTextRect(
  AResource: TcxSchedulerStorageResourceItem; const ARect: TRect);
var
  I: Integer;
begin
  for I := 0 to ResourceCount - 1 do
    if Resources[I].ResourceItem = AResource then
    begin
      Resources[I].FTextRect := ARect;
      Break;
    end;
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

procedure TcxSchedulerCustomResourceViewViewInfo.HotTrackNavigationButtons(
  AHitTest: TcxSchedulerCustomResourceViewHitTest);
var
  ANavigationButton: TcxSchedulerContentNavigationButtonViewInfo;
begin
  if not CanCalculateNavigationButtons then Exit;
  if Scheduler.OptionsBehavior.HotTrack then
    ANavigationButton := AHitTest.HitContentNavigationButton
  else
    ANavigationButton := nil;
  SetHitContentNavigationButton(ANavigationButton, AHitTest);
end;

function TcxSchedulerCustomResourceViewViewInfo.IsTimeSelected(
  ATime: TDateTime; AResource: TObject): Boolean;
begin
  ATime := DateTimeHelper.RoundTime(ATime);
  Result := not HideSelection and ((AResource = FSelResource) and
    (ATime >= SelStart) and (ATime <= SelFinish));
  Result := Result and CanSelected;
end;

function TcxSchedulerCustomResourceViewViewInfo.IsValidNavigationButtonsPlace(
  const AResourceRect: TRect): Boolean;
var
  AButtonWidth1, AButtonWidth2: Integer;
begin
  CalculateNavigationButtonParams(AResourceRect, nbkPrevious, AButtonWidth1);
  CalculateNavigationButtonParams(AResourceRect, nbkNext, AButtonWidth2);
  Result := AButtonWidth1 + AButtonWidth2 <= AResourceRect.Right - AResourceRect.Left;
end;

procedure TcxSchedulerCustomResourceViewViewInfo.MakeTimeVisible(
  const ATime: TDateTime);
begin
end;

function TcxSchedulerCustomResourceViewViewInfo.NavigationButtonOffset(
  AKind: TcxSchedulerContentNavigationButtonKind;
  AResourceIndex: Integer): Integer;
begin
  Result := 0;
end;

procedure TcxSchedulerCustomResourceViewViewInfo.OnContentNavigationButtonClick(
  Sender: TcxSchedulerContentNavigationButtonViewInfo);
var
  AResource: TcxSchedulerStorageResourceItem;
begin
  if Sender.Resource <> nil then
    AResource := Sender.Resource.ResourceItem
  else
    AResource := nil;
  if not DoSchedulerNavigationButtonClick(Sender.Interval, AResource) then
    DoContentNavigationButtonClick(Sender);
end;

procedure TcxSchedulerCustomResourceViewViewInfo.OnMoreEventsButtonClick(
  Sender: TcxSchedulerMoreEventsButtonViewInfo);
begin
  if not DoSchedulerMoreEventsButtonClick then
    DoMoreEventsButtonClick(Sender);
end;

procedure TcxSchedulerCustomResourceViewViewInfo.AddContentNavigationIntervalItem(
  AResourceIndex: Variant);
var
  AResourceID: Variant;
  I: Integer;
  AnAlreadyExists: Boolean;
begin
  if AResourceIndex > -1 then
    AResourceID := Resources[AResourceIndex].ResourceID
  else
  begin
    AResourceID := 0;
    FContentNavigationWithoutResources := True;
  end;
  AnAlreadyExists := False;
  I := 0;
  while not AnAlreadyExists and (I < FContentNavigationIntervals.Count) do
  begin
    AnAlreadyExists := VarEqualsSoft(TcxSchedulerContentNavigationInfo(
      FContentNavigationIntervals[I]).FResourceID, AResourceID);
    Inc(I);
  end;
  if not AnAlreadyExists then
    FContentNavigationIntervals.Add(TcxSchedulerContentNavigationInfo.Create(AResourceID));
end;

procedure TcxSchedulerCustomResourceViewViewInfo.ClearContentNavigationIntervals;
begin
  if FContentNavigationIntervals = nil then
    FContentNavigationIntervals := TObjectList.Create
  else
    FContentNavigationIntervals.Clear;
  FContentNavigationWithoutResources := False;
end;

function TcxSchedulerCustomResourceViewViewInfo.GetClones: TcxSchedulerEventList;
begin
  Result := View.EventList.Clones;
end;

function TcxSchedulerCustomResourceViewViewInfo.GetCorrectColumnHeight(
  AColumnRect: TRect): Integer;
begin
  Result := Min(AColumnRect.Bottom - AColumnRect.Top, GetMinResourceHeight);
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

function TcxSchedulerCustomResourceViewViewInfo.GetMinResourceHeight: Integer;
var
  I, AResourceHeight: Integer;
begin
  Result := MaxInt;
  if Length(FResourceBounds) = ResourceCount then
    for I := 0 to ResourceCount - 1 do
    begin
      AResourceHeight := FResourceBounds[I].Bottom - FResourceBounds[I].Top;
      if (AResourceHeight <> 0) and (Result > AResourceHeight) then
        Result := AResourceHeight;
    end;
end;

function TcxSchedulerCustomResourceViewViewInfo.GetMoreEventsButtonCount(
  AResourceIndex: Integer): Integer;

  function IsButtonWithoutResources(
    AButton: TcxSchedulerMoreEventsButtonViewInfo): Boolean;
  var
    I: Integer;
  begin
    Result := True;
    I := 0;
    while (I < ResourceCount) and Result do
    begin
      if AButton.Event.IsSharedWithResource(Resources[I].ResourceID) then
        Result := False;
      Inc(I);
    end;
  end;

var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Buttons.Count - 1 do
    if (Buttons[I] is TcxSchedulerMoreEventsButtonViewInfo) and
      ((AResourceIndex = -1) or
      TcxSchedulerMoreEventsButtonViewInfo(Buttons[I]).Event.IsSharedWithResource(
      Resources[AResourceIndex].ResourceID) or
      IsButtonWithoutResources(TcxSchedulerMoreEventsButtonViewInfo(Buttons[I])))
      then
      Inc(Result);
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

function TcxSchedulerCustomResourceViewViewInfo.GetResourceHeaders: TcxSchedulerResourceHeaders;
begin
  Result := View.OptionsView.ResourceHeaders;
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

function TcxSchedulerCustomResourceViewViewInfo.IsDrawContentNavigationButtons: Boolean;
var
  I: Integer;
begin
  Result := CanCalculateNavigationButtons;
  if Result then
  begin
    I := 0;
    if ResourceCount > 0 then
      while (I < ResourceCount) and Result do
      begin
        Result := IsValidNavigationButtonsPlace(FResourceBounds[I]);
        Inc(I);
      end
    else
      Result := IsValidNavigationButtonsPlace(Bounds);
  end;
end;

procedure TcxSchedulerCustomResourceViewViewInfo.SetContentNavigationButtonsIntervals;

   procedure FillContentNavigationIntervals;
   var
     ACalculator: TcxSchedulerContentNavigationCalculator;
     AStart, AFinish: TDateTime;
   begin
     ReturnVisibleInterval(AStart, AFinish);
     ACalculator := TcxSchedulerContentNavigationCalculator.Create;
     try
       ACalculator.FindNavigationIntervals(Scheduler.Storage,
         FContentNavigationIntervals, AStart, AFinish,
         FContentNavigationWithoutResources, ShowEventsWithoutResource);
     finally
       ACalculator.Free;
     end;
   end;

var
  I: Integer;
  AContentNavigationButton: TcxSchedulerContentNavigationButtonViewInfo;
begin
  FillContentNavigationIntervals;
  for I := 0 to FNavigationButtons.Count - 1 do
  begin
    AContentNavigationButton := TcxSchedulerContentNavigationButtonViewInfo(FNavigationButtons[I]);
    AContentNavigationButton.Interval := GetContentNavigationInterval(AContentNavigationButton);
  end;
end;

procedure TcxSchedulerCustomResourceViewViewInfo.SetHitContentNavigationButton(
  AButton: TcxSchedulerContentNavigationButtonViewInfo;
  AHitTest: TcxSchedulerCustomResourceViewHitTest);
begin
  HotContentNavigationButton := AButton;
end;

procedure TcxSchedulerCustomResourceViewViewInfo.SetHotContentNavigationButton(
  AButton: TcxSchedulerContentNavigationButtonViewInfo);
begin
  if FHotContentNavigationButton <> AButton then
  begin
    if FHotContentNavigationButton <> nil then
    begin
      EndMouseTracking(Self);
      View.RepaintRect(FHotContentNavigationButton.Bounds);
    end;
    FHotContentNavigationButton := AButton;
    if FHotContentNavigationButton <> nil then
    begin
      View.RepaintRect(FHotContentNavigationButton.Bounds);
      BeginMouseTracking(Scheduler,
        cxRectOffset(FHotContentNavigationButton.Bounds, View.Left, View.Top),
        Self);
    end;
  end;
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
const
  Cursors: array[Boolean] of TCursor = (crSchedulerVertResize, crSchedulerHorzResize);
begin
  with HitTest do
    case GetDragKind of
      edkEventDragRect:
        Result := crSchedulerSplitAll;
      edkResizeStart, edkResizeEnd:
        Result := Cursors[EventCell.IsHorzSizing];
    else
      Result := inherited GetCursor(X, Y);
    end;
end;

procedure TcxSchedulerCustomResourceViewController.MouseDown(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  NavigationButtonClicked := HitTest.HitAtContentNavigationButton;
  if HitTest.HitAtButton then
    Exclude(Shift, ssDouble);
  inherited MouseDown(Button, Shift, X, Y);
  if HitTest.HitAtButton then
    HitTest.Button.Click;
  InternalHideHint;
end;

procedure TcxSchedulerCustomResourceViewController.MouseLeave;
begin
  inherited MouseLeave;
  InternalHideHint;
  NavigationButtonClicked := False;
end;

procedure TcxSchedulerCustomResourceViewController.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if not NavigationButtonClicked then
    inherited MouseMove(Shift, X, Y);
  ShowHint;
end;

procedure TcxSchedulerCustomResourceViewController.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if (HitTest.HitAtContentNavigationButton) and (Button = mbLeft) then
    HitTest.ContentNavigationButton.Click;
  InternalHideHint;
  NavigationButtonClicked := False;
end;

function TcxSchedulerCustomResourceViewController.GetDayHeaderDate: TDateTime;
begin
  Result := HitTest.Time;
end;

procedure TcxSchedulerCustomResourceViewController.InternalHideHint;
begin
  HintController.Hide;
  FCalculatedHintBounds := False;
end;

procedure TcxSchedulerCustomResourceViewController.InternalShowHint(P: TPoint; const AHintText: string);
var
  R: TRect;
begin
  if (not FCalculatedHintBounds) then
  begin
    FHintText := AHintText;
    R := HintController.CalcHintRect(cxscMinHintWidth, AHintText, cxAlignRight);
    OffsetRect(R, P.X, P.Y + cxGetCursorSize.cy);
    HintController.Activate(R, AHintText, True, False);
    FCalculatedHintBounds := True;
  end;
end;

function TcxSchedulerCustomResourceViewController.NeedShowDayHeaderHint: Boolean;
var
  AGroupingKind: TcxSchedulerGroupingKind;
  AGroupByDate: Boolean;
begin
  AGroupingKind := View.GetGroupingKind;
  AGroupByDate := AGroupingKind in [gkByDate, gkDefault];
  Result := Scheduler.OptionsView.ShowHints and HitTest.HitAtDayHeader and
    (HitTest.HitAtTime) and ((AGroupByDate and
    not HitTest.HitAtResourceHeader) or not AGroupByDate);
end;

function TcxSchedulerCustomResourceViewController.ShowHint: Boolean;
begin
  Result := NeedShowDayHeaderHint;
  if Result then
    ShowDayHeaderHint
  else
  begin
    Result := HitTest.NeedShowHint;
    if not Result then
      InternalHideHint;
  end;
end;

procedure TcxSchedulerCustomResourceViewController.ShowDayHeaderHint;
var
  AHintText: string;
  ADate: TDateTime;
begin
  AHintText := '';
  ADate := GetDayHeaderDate;
  if TcxCustomSchedulerAccess(Scheduler).DoShowDateHint(ADate, AHintText) then
  begin
    if AnsiCompareText(AHintText, FHintText) <> 0 then
      InternalHideHint;
    InternalShowHint(GetMouseCursorPos, AHintText);
  end
  else
    InternalHideHint;
end;

function TcxSchedulerCustomResourceViewController.GetHintController: TcxSchedulerHintController;
begin
  Result := TcxCustomSchedulerAccess(Scheduler).HintController;
end;

function TcxSchedulerCustomResourceViewController.GetHitTest: TcxSchedulerCustomResourceViewHitTest;
begin
  Result := TcxSchedulerCustomResourceViewHitTest(inherited HitTest);
end;

function TcxSchedulerCustomResourceViewController.GetView: TcxSchedulerCustomResourceView;
begin
  Result := TcxSchedulerCustomResourceView(inherited View);
end;

{ TcxSchedulerCustomResourceViewHitTest }

function TcxSchedulerCustomResourceViewHitTest.GetDragKind: TcxEventDragKind;
begin
  ValidateDragKind;
  Result := FDragKind;
end;

procedure TcxSchedulerCustomResourceViewHitTest.SetDragKind(
  AValue: TcxEventDragKind);
begin
  FDragKind := AValue;
  ValidateDragKind;
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
  FContentNavigationButton := nil;
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

function TcxSchedulerCustomResourceViewHitTest.GetHitContentNavigationButton: TcxSchedulerContentNavigationButtonViewInfo;
begin
  if GetBitState(htcNavigationButton) then
    Result := FContentNavigationButton
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

procedure TcxSchedulerCustomViewPainter.InitializePainter;
begin
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
  if AItem is TcxSchedulerMoreEventsButtonViewInfo then
  begin
    if Painter <> nil then
      Painter.DoCustomDrawButton(TcxSchedulerMoreEventsButtonViewInfo(AItem), ADone);
    if not ADone then
      View.DoCustomDrawButton(TcxSchedulerMoreEventsButtonViewInfo(AItem), ADone);
  end
  else
  begin
    if Painter <> nil then
      Painter.DoCustomDrawNavigationButton(TcxSchedulerContentNavigationButtonViewInfo(AItem), ADone);
    if not ADone then
      View.DoCustomDrawNavigationButton(TcxSchedulerContentNavigationButtonViewInfo(AItem), ADone);
  end;
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

{ TcxSchedulerEventPlace }

procedure TcxSchedulerEventPlace.AlignPosition(APlace: TcxSchedulerEventPlace);
begin
  LineFinish := APlace.LineFinish + 1 + (LineFinish - LineStart);
  LineStart := APlace.LineFinish + 1;
end;

function TcxSchedulerEventPlace.IntersectHorz(APlace: TcxSchedulerEventPlace): Boolean;
begin
  Result := (APlace.Resource = Resource) and (APlace.ColFinish >= ColStart) and
    (APlace.ColStart <= ColFinish);
end;

function TcxSchedulerEventPlace.IntersectVert(APlace: TcxSchedulerEventPlace): Boolean;
begin
  Result := (APlace.Resource = Resource) and (APlace.LineFinish >= LineStart) and
    (APlace.LineStart <= LineFinish);
end;

procedure TcxSchedulerEventPlace.LineStartToEvent;
begin
  TcxSchedulerControlEventAccess(Event).LineStart := LineStart;
end;

procedure TcxSchedulerEventPlace.ResetPosition;
begin
  LineFinish := LineFinish - LineStart;
  LineStart := 0;
end;

function cxCompareEventPlaces(AEventPlace1, AEventPlace2: TcxSchedulerEventPlace): Integer;
var
  AAllDay1, AAllDay2: Boolean;
  AEvent1, AEvent2: TcxSchedulerEvent;
begin
  Result := Integer(AEventPlace1.Resource) - Integer(AEventPlace2.Resource);
  if Result <> 0 then Exit;
  AEvent1 := AEventPlace1.Event;
  AEvent2 := AEventPlace2.Event;
  AAllDay1 := AEvent1.AllDayEvent or (AEvent1.Duration >= 1);
  AAllDay2 := AEvent2.AllDayEvent or (AEvent2.Duration >= 1);
  Result := Byte(AAllDay2) - Byte(AAllDay1);
  if Result <> 0 then Exit;

  if AEventPlace1.ColStart < AEventPlace2.ColStart then
    Result := -1
  else
    if AEventPlace1.ColStart > AEventPlace2.ColStart then
      Result := 1
    else
      if AEventPlace1.ColFinish > AEventPlace2.ColFinish then
        Result := -1
      else
        if AEventPlace1.ColFinish < AEventPlace2.ColFinish then
          Result := 1
        else
          if AEvent1.Start < AEvent2.Start then
            Result := -1
          else
            if AEvent1.Start > AEvent2.Start then
              Result := 1
            else
              if AEvent1.Finish > AEvent2.Finish then
                Result := -1
              else
                if AEvent1.Finish < AEvent2.Finish then
                  Result := 1
                else
                  if AEvent1.RecordIndex < AEvent2.RecordIndex then
                    Result := -1
                  else
                    if AEvent1.RecordIndex > AEvent2.RecordIndex then
                      Result := 1
                    else
                      Result := 0;
end;

{ TcxSchedulerEventLayoutBuilder }

constructor TcxSchedulerEventLayoutBuilder.Create;
begin
  FEventPlaces := TcxObjectList.Create;
end;

destructor TcxSchedulerEventLayoutBuilder.Destroy;
begin
  FreeAndNil(FEventPlaces);
  inherited Destroy;
end;

function TcxSchedulerEventLayoutBuilder.AddEventPlace(AEvent: TcxSchedulerEvent;
  AStartCol, AFinishCol: Integer; ALineCount: Integer = 1; AResource: TObject = nil): TcxSchedulerEventPlace;
begin
  Result := TcxSchedulerEventPlace.Create;
  Result.ColStart := AStartCol;
  Result.ColFinish := AFinishCol;
  Result.Event := AEvent;
  Result.LineFinish := ALineCount - 1;
  Result.Resource := AResource;
  FEventPlaces.Add(Result);
end;

procedure TcxSchedulerEventLayoutBuilder.Clear;
begin
  FEventPlaces.Clear;
end;

procedure TcxSchedulerEventLayoutBuilder.Calculate;
var
  I, J, K: Integer;
  ACurPlace: TcxSchedulerEventPlace;
begin
  FEventPlaces.Sort(TListSortCompare(@cxCompareEventPlaces));
  for I := 1 to EventPlaceCount - 1 do
  begin
    J := I;
    K := I;
    ACurPlace := EventPlaces[I];
    repeat
      Dec(J);
      if ACurPlace.IntersectHorz(EventPlaces[J]) then K := J;
    until J = 0;
    ACurPlace.ResetPosition;
    J := K;
    while J < I do
    begin
      if ACurPlace.IntersectHorz(EventPlaces[J]) and ACurPlace.IntersectVert(EventPlaces[J]) then
      begin
        ACurPlace.AlignPosition(EventPlaces[J]);
        J := K;
      end
      else
        Inc(J);
    end;
  end;
end;

procedure TcxSchedulerEventLayoutBuilder.CalculateEx(AEventsList: TcxSchedulerFilteredEventList;
  APlaceInfoProc: TcxSchedulerEventLayoutBuilderGetEventPlaceProc);
var
  AEvent: TcxSchedulerControlEvent;
  I, AStartCol, AFinishCol, ALineCount: Integer;
begin
  Clear;
  for I := 0 to AEventsList.Count - 1 do
  begin
    AEvent := AEventsList[I];
    ALineCount := 1;
    if APlaceInfoProc(Self, AEventsList[I], AStartCol, AFinishCol, ALineCount) then
      AddEventPlace(AEvent, AStartCol, AFinishCol, ALineCount);
  end;
  Calculate;
end;

function TcxSchedulerEventLayoutBuilder.GetEventPlace(AIndex: Integer): TcxSchedulerEventPlace;
begin
  Result := TcxSchedulerEventPlace(FEventPlaces.List^[AIndex]);
end;

function TcxSchedulerEventLayoutBuilder.GetEventPlaceCount: Integer;
begin
  Result := FEventPlaces.Count;
end;

end.
