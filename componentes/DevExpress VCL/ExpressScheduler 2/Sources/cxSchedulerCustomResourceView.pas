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
{$IFDEF DELPHI6}
  Types,
{$ENDIF}
  Windows, Graphics, SysUtils, StdCtrls, Classes, Forms, Controls, cxClasses, cxGraphics,
{$IFDEF DELPHI6}
  DateUtils, Variants,
{$ENDIF} cxGeometry, Math, cxStyles, cxEdit, cxContainer,
  cxSchedulerStorage, cxSchedulerUtils, cxSchedulerCustomControls, cxLookAndFeelPainters,
  cxDateUtils, ImgList, cxEditUtils;

const
  // default values
  cxTimeLineWidth: Integer = 7;
  cxEventImagesOffset = 1;
  cxEventBorderWidth = 1;

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
  TcxSchedulerExternalPainter = class;
  TcxSchedulerGroupSeparatorCellViewInfo = class;
  TcxSchedulerHeaderCellViewInfo = class;
  TcxSchedulerMoreEventsButtonViewInfo = class;
  TcxSchedulerResourceViewInfo = class;
  TcxCustomResourceViewAdapter = class;
  TcxSchedulerEventLayoutBuilder = class;
  TcxSchedulerEventImages = class;

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
    FExternalPainter: TcxSchedulerExternalPainter;
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
  private
    function GetHeight: Integer;
    function GetWidth: Integer;
  protected
    DisplayBounds: TRect;
    FAlignHorz: TAlignment;
    FAlignVert: TcxAlignmentVert;
    FAutoHeight: Boolean;
    FButtonState: TcxButtonState;
    FCachedBitmap: TBitmap;
    FDrawRotatedBackground: Boolean;
    FImageIndex: Integer;
    FImagePosition: TcxSchedulerHeaderImagePosition;
    FImages: TCustomImageList;
    FImageRectAssigned: Boolean;
    FImageRect: TRect;
    FIsResourceHeader: Boolean;
    FMultiLine: Boolean;
    FNeighbors: TcxNeighbors;
    FRotateBitmap: TBitmap;
    FRotateHeader: Boolean;
    FRotateText: Boolean;
    FSelected: Boolean;
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
    procedure DrawVerticalHeader; virtual;
    function GetTextOutcxFlags: Integer;
    function GetTextOutFlags: Integer;
    function HasImage: Boolean;
    procedure InitHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest); override;
    procedure TextOut(ACanvas: TcxCanvas; const AText: string; R: TRect);
    procedure ValidateSelection;

    property Height: Integer read GetHeight;
    property Width: Integer read GetWidth;
  public
    constructor Create(APainter: TcxCustomLookAndFeelPainterClass;
      const ABounds, AVisibleRect: TRect; const AViewParams: TcxViewParams); override;
    destructor Destroy; override;
    procedure Calculate(const AText: string); virtual;
    procedure CalculateImageLayout;
    procedure Draw(ACanvas: TcxCanvas); override;

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
    FLastVisibleHour: Boolean;
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
    procedure Calculate(const ALabel1, ALabel2: string; ATimeZone, AAdditionalTimeZone: Integer); overload; virtual;
    procedure Calculate(AHour, ALineCount: Integer; ATimeZone, AAdditionalTimeZone: Integer; ALargeFont: TFont); overload; virtual;
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
    DrawShadows: Boolean;
    EditProperties: TcxCustomEditProperties;
    EditStyle: TcxCustomEditStyle;
    Event: TcxSchedulerControlEvent;
    ExternalPainter: TcxSchedulerExternalPainter;
    Hint: string;
    ImagesLayout: TcxSchedulerEventImagesLayout;
    LineHeight: Integer;
    MaxHeight: Integer;
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

  TcxSchedulerMoreEventsButtonViewInfo = class(TcxSchedulerCustomResourceViewInfoItem)
  protected
    FIsDown: Boolean;
    FOnClick: TcxSchedulerMoreEventsButtonClick;
    procedure DoDraw; override;
    procedure InitHitTest(AHitTest: TcxSchedulerCustomResourceViewHitTest); override;
    property OnClick: TcxSchedulerMoreEventsButtonClick read FOnClick write FOnClick;
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
    FImageIndex: Integer;
    FImagePosition: TcxSchedulerHeaderImagePosition;
    FImages: TCustomImageList;
    FResourceID: Variant;
    FResourceItem: TcxSchedulerStorageResourceItem;
    FTextRect: TRect;
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
    procedure DoCustomDrawResourceHeader(
      AViewInfo: TcxSchedulerHeaderCellViewInfo; var ADone: Boolean); virtual;
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
    FOnCustomDrawResourceHeader: TcxSchedulerCustomDrawResourceHeaderEvent;
    function GetViewInfo: TcxSchedulerCustomResourceViewViewInfo;
    procedure SetEventImagesLayout(const AValue: TcxSchedulerEventImagesLayout);
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

  TcxCustomResourceViewAdapter = class
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

    property Cells: TcxObjectList read GetCells;
    property ContentLineHeight: Integer read GetContentLineHeight;
    property DontPrintWeekEnd: Boolean read GetDontPrintWeekEnds;
    property PagesPerWeek: Byte read GetPagesPerWeek;
    property PrintExactlyOneMonth: Boolean read GetPrintExactlyOneMonth;
    property PrintFrom: TDateTime index 0 read GetPrintRange;
    property PrintTo: TDateTime index 1 read GetPrintRange;
    property Resources: TcxSchedulerStorageResourceItems read GetResources;
    property StylesAdapter: IcxSchedulerStylesAdapter read GetStylesAdapter;
    property View: TcxSchedulerCustomResourceView read GetView;
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
    function GetResourceHeaders: TcxSchedulerResourceHeaders;
    function GetPrintRange(Index: Integer): TDateTime;
    function GetSeparatorWidth: Integer;
    function GetView: TcxSchedulerCustomResourceView;
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
    FResources: TcxObjectList;
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
      AViewData: TcxSchedulerEventViewData; AImmediateCalculate: Boolean = True): TcxSchedulerEventCellViewInfo; virtual;
    function AddGroupHorzSeparator(APos: Integer): TcxSchedulerGroupSeparatorCellViewInfo; virtual;
    function AddGroupSeparator(const ABounds: TRect): TcxSchedulerGroupSeparatorCellViewInfo; virtual;
    function AddGroupVertSeparator(APos: Integer): TcxSchedulerGroupSeparatorCellViewInfo; virtual;
    function AddResourceHeader(const AIndex: Integer;
      const ABounds: TRect): TcxSchedulerHeaderCellViewInfo; virtual;
    procedure AfterCalculate; override;
    procedure AssignResourceID(ACell: TcxSchedulerCustomResourceViewInfoItem; AIndex: Integer);
    procedure CalculateMetrics; virtual;
    procedure CalculateResourceHeadersAutoHeight(AWidth: Integer); virtual;
    function CalculateResourceHeaderWidth: Integer; virtual; 
    procedure Clear; override;
    function ContentCellClass: TcxSchedulerContentCellViewInfoClass; virtual;
    procedure CreateCellInstance(AClass: TcxSchedulerCustomViewInfoItemClass;
      const ABounds: TRect; const AViewParams: TcxViewParams; var Instance); overload;
    procedure CreateCellInstance(AClass: TcxSchedulerCustomViewInfoItemClass;
      const ABounds, AVisibleBounds: TRect; const AViewParams: TcxViewParams; var Instance); overload;
    function CreateEventViewData(AEvent: TcxSchedulerControlEvent; const ABounds: TRect;
      const AStart, AFinish: TDateTime; AResource: TcxSchedulerResourceViewInfo): TcxSchedulerEventViewData; virtual;
    function CreateEventCellViewInfo(AViewData: TcxSchedulerEventViewData): TcxSchedulerEventCellViewInfo; virtual;
    procedure DoCalculate; override;
    procedure DoMoreEventsButtonClick(Sender: TcxSchedulerMoreEventsButtonViewInfo); virtual;
    procedure ExtractResources; virtual;
    function GetBounds: TRect; override;
    function GetContentParams(const ATime: TDateTime;
      AResource: TcxSchedulerResourceViewInfo): TcxViewParams; virtual;
    function GetDayHeaderHeight: Integer; virtual;
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
    function GetResourceViewInfoByItem(AItem: TcxSchedulerStorageResourceItem): TcxSchedulerResourceViewInfo;
    function HasStorage: Boolean;
    procedure HideCloneEventsOnDragDrop;
    procedure HideSourceEventsOnDragDrop;
    function IsTimeSelected(ATime: TDateTime; AResource: TObject): Boolean; virtual;
    procedure MakeTimeVisible(const ATime: TDateTime); virtual;
    procedure OnMoreEventsButtonClick(Sender: TcxSchedulerMoreEventsButtonViewInfo);
    procedure ProcessDateToDisplayText(ArrangeByType: Boolean = False); virtual;
    procedure ProcessCheckBorders(AList: TcxSchedulerViewInfoCellList;
      AHasCommonArea: Boolean; ANeighbors: TcxNeighbors = [];
      AExcludeBorders: TcxBorders = []; AAddBorders: TcxBorders = []);
    function SetAdapter(Adapter: TcxCustomResourceViewAdapter): TcxCustomResourceViewAdapter;
    procedure SetResourceTextRect(AResource: TcxSchedulerStorageResourceItem; const ARect: TRect);

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
    function GetHitTest: TcxSchedulerCustomResourceViewHitTest;
  protected
    function CreateNavigation: TcxSchedulerViewNavigation; override;
    function GetCursor(X, Y: Integer): TCursor; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    property HitTest: TcxSchedulerCustomResourceViewHitTest read GetHitTest;
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
    procedure SetDragKind(AValue: TcxEventDragKind);

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
    procedure Calculate;
    procedure CalculateEx(AEventsList: TcxSchedulerFilteredEventList;
      APlaceInfoProc: TcxSchedulerEventLayoutBuilderGetEventPlaceProc);
    property EventPlaceCount: Integer read GetEventPlaceCount;
    property EventPlaces[Index: Integer]: TcxSchedulerEventPlace read GetEventPlace;
  end;

var
  ExternalPainterClass: TcxSchedulerExternalPainterClass = TcxSchedulerExternalPainter;    

function MakeTextOutcxFlags(AlignHorz: TAlignment;
  AlignVert: TcxAlignmentVert; AMultiline: Boolean = False): Integer;

implementation

uses
  cxDrawTextUtils, cxLibraryConsts, dxCore;

type
  TcxCustomEditStyleAccess = class(TcxCustomEditStyle);

const
  MultiLines: array[Boolean] of Integer = (0, cxWordBreak);
{$IFDEF USECXTEXTOUT}
  cxTextOutFlags: array[Boolean] of Cardinal = (
    CXTO_LEFT or CXTO_CENTER_VERTICALLY or CXTO_SINGLELINE,
    CXTO_LEFT or CXTO_TOP or CXTO_WORDBREAK or CXTO_EDITCONTROL);

function MakeTextOutFlags(AlignHorz: TAlignment;
  AlignVert: TcxAlignmentVert; AMultiline: Boolean = False): Integer;
const
  Horz: array[TAlignment] of Integer =
    (CXTO_LEFT, CXTO_RIGHT, CXTO_CENTER_HORIZONTALLY);
  Vert: array[TcxAlignmentVert] of Integer =
    (CXTO_TOP, CXTO_BOTTOM, CXTO_CENTER_VERTICALLY);
begin
  Result := CXTO_PREVENT_LEFT_EXCEED or CXTO_PREVENT_TOP_EXCEED or
    Horz[AlignHorz] or Vert[AlignVert] + CXTO_SINGLELINE;
  if AMultiline then
  begin
    Result := CXTO_PREVENT_LEFT_EXCEED or CXTO_PREVENT_TOP_EXCEED or
      Horz[AlignHorz] or Vert[AlignVert] or CXTO_WORDBREAK;
  end;
end;
{$ELSE}
  cxDrawTextFlags: array[Boolean] of Cardinal = (
    cxAlignLeft or cxAlignVCenter or cxSingleLine,
    cxAlignLeft or cxAlignTop or cxWordBreak or cxDontBreakChars);
{$ENDIF}

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
    if AItem.FVisible then
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
      if not ADone then AItem.Draw(ACanvas);
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
  FCanvas := ACanvas;
  DoDraw;
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
  ACanvas.GetParams(FViewParams);
end;

procedure TcxSchedulerCustomViewInfoItem.BeforeCustomDraw(ACanvas: TcxCanvas);
begin
  ACanvas.SetParams(FViewParams);
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
  FImageIndex := -1;
  FButtonState := cxbsDefault;
  FAlignHorz := taCenter;
  FAlignVert := vaCenter;
  FBorders := cxBordersAll;
  FTextRect := cxRectInflate(FBounds, -cxTextOffset, 0);
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
  APrevCanvas: TcxCanvas;
begin
  if not FVisible then Exit;
  ValidateSelection;
  FBackgroundDrawing := False;
  ATransparent := Transparent;
  APrevCanvas := FCanvas;
  if FCachedBitmap = nil then
  begin
    FCachedBitmap := cxCreateBitmap(cxRectSize(Bounds), pf32Bit);
    if Transparent then
      BitBlt(FCachedBitmap.Canvas.Handle, 0, 0, FCachedBitmap.Width,
        FCachedBitmap.Height, ACanvas.Handle, Bounds.Left, Bounds.Top, srcCopy);
    SetWindowOrgEx(FCachedBitmap.Canvas.Handle, FBounds.Left, FBounds.Top, nil);
    ASavedCanvas := ACanvas.Canvas;
    FCanvas := ACanvas;
    FCanvas.Canvas := FCachedBitmap.Canvas;
    CalculateImageLayout;
    if RotateText or RotateHeader then
      DrawVerticalHeader
    else
      DrawHorizontalHeader;
    ACanvas.Canvas := ASavedCanvas;
    SetWindowOrgEx(FCachedBitmap.Canvas.Handle, 0, 0, nil);
  end;
  ACanvas.Draw(FBounds.Left, FBounds.Top, FCachedBitmap);
  FCanvas := APrevCanvas;
  Transparent := ATransparent;
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
  FImageRectAssigned := FImageRectAssigned or not HasImage;
  if FImageRectAssigned then
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
  FImageRectAssigned := True;
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
  if Transparent and (DisplayText = '') then Exit;
  Painter.DrawHeader(Canvas, Bounds, TextRect, Neighbors, Borders,
    FButtonState, AlignHorz, AlignVert, MultiLine, ShowEndEllipsis, DisplayText,
    Font, TextColor, Color, DrawBackground, not (nRight in Neighbors));
end;

procedure TcxSchedulerHeaderCellViewInfo.DrawCaption(ACanvas: TcxCanvas = nil);
var
  ABitmap: TBitmap;
  ARgn: TcxRegion;
begin
  if ACanvas = nil then
    ACanvas := Canvas;
  ARgn := ACanvas.GetClipRegion;
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
        ABitmap := TBitmap.Create;
        try
          ABitmap.Width := Images.Width;
          ABitmap.Height := Images.Height;
          RotateBitmap(ABitmap, raMinus90);
          BitBlt(ABitmap.Canvas.Handle, 0, 0, Images.Height, Images.Width, ACanvas.Handle,
            FImageRect.Left, FImageRect.Top, srcCopy);
          RotateBitmap(ABitmap, raPlus90);
          Images.Draw(ABitmap.Canvas, 0, 0, ImageIndex{$IFDEF DELPHI6}, dsNormal, itImage {$ENDIF});
          RotateBitmap(ABitmap, raMinus90);
          ACanvas.Draw(FImageRect.Left, FImageRect.Top, ABitmap);
        finally
          ABitmap.Free;
        end; 
      end;
    end;
  finally
    ACanvas.SetClipRegion(ARgn, roSet);
  end;
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
  DrawCaption;
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
    if Transparent then
    begin
      BitBlt(FRotateBitmap.Canvas.Handle, 0, 0, FRotateBitmap.Width,
      FRotateBitmap.Height, Canvas.Handle, Bounds.Left, Bounds.Top, srcCopy);
    end;
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
      if not Transparent then
        Painter.DrawHeader(ABitmapCanvas, R, cxRectInflate(R, -cxTextOffset, -cxTextOffset),
          Neighbors, Borders, cxbsNormal, taCenter, vaCenter, False, False, '',
          Font, TextColor, Color, DrawRotateBackground);

      if RotateText then
      begin
        RotateBitmap(FRotateBitmap, ra0, True);
        DrawCaption(ABitmapCanvas);
        RotateBitmap(FRotateBitmap, raPlus90);
      end
      else
      begin
        RotateBitmap(FRotateBitmap, raPlus90, True);
        R.BottomRight := cxPoint(R.Bottom, R.Right);
        DrawCaption(ABitmapCanvas);
      end;
    finally
      FRotateBitmap.Canvas.Unlock;
      ABitmapCanvas.Free;
    end;
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

function TcxSchedulerHeaderCellViewInfo.GetHeight: Integer;
begin
  Result := Bounds.Bottom - Bounds.Top;
end;

function TcxSchedulerHeaderCellViewInfo.GetWidth: Integer;
begin
  Result := Bounds.Right - Bounds.Left;
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
begin
  FExternalPainter.DrawCurrentTime(Canvas, Color, AStart, ABounds);
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
  Result := LongMonthNames[MonthOf(TimeStart)] + ', ' + IntToStr(DayOf(TimeStart));
  if cxTextWidth(Font, Result) >= (cxRectWidth(FTextRect) div 2) then
    Result := ShortMonthNames[MonthOf(TimeStart)] + ' ' + IntToStr(DayOf(TimeStart));
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
    ShiftRect(Images[0].FBounds);
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
  FHintNeeded := not Event.AllDayEvent and not IsDetailInfo and
    (cxRectIsEmpty(FinishRect) or cxRectIsEmpty(StartRect));
  if not FHintNeeded then
  begin
    R := FCaptionRect;
  {$IFDEF USECXTEXTOUT}
    with TcxScreenCanvas.Create do
    try
      Font := Self.Font;
      cxTextOut(Canvas, PChar(ViewData.Hint), R, CXTO_CALCRECT or cxTextOutFlags[IsDetailCaption]);
    finally
      Free;
    end;
  {$ELSE}
    Canvas.TextExtent(ViewData.Hint, R, cxDrawTextFlags[IsDetailCaption]);
  {$ENDIF}
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
    R := cxRectSetWidth(R, Max(Canvas.TextWidth('00:00' + TimeAMString),
      Canvas.TextWidth('00:00' + TimePMString)));
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
{$IFDEF USECXTEXTOUT}
  cxTextOut(Canvas.Canvas, PChar(ViewData.Caption), FCaptionRect, cxTextOutFlags[IsDetailCaption]);
{$ELSE}
  Canvas.Brush.Style := bsClear;
  Canvas.DrawText(ViewData.Caption, FCaptionRect, cxDrawTextFlags[IsDetailCaption]);
  Canvas.Brush.Style := bsSolid;
{$ENDIF}
end;

procedure TcxSchedulerEventCellViewInfo.DrawContent;
begin
  ViewData.ExternalPainter.DrawEvent(Self);
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
        begin
          Images.DrawingStyle := dsTransparent;
          Canvas.DrawImage(Images, Bounds.Left, Bounds.Top, ImageIndex);
        end;
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
  Result := Result and not Hidden;
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
    if Reminder and Storage.IsReminderAvailable and Storage.Reminders.Active then
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
{$IFDEF USECXTEXTOUT}
var
  ARowCount: Integer;
  ATextFlags: Cardinal;
  ATextParams: TcxTextParams;
  ATextRows: TcxTextRows;
{$ENDIF}
begin
  Result := R;
{$IFDEF USECXTEXTOUT}
  with TcxScreenCanvas.Create do
  try
    Font := Self.Font;
    ATextFlags := CXTO_CALCROWCOUNT or cxTextOutFlags[True];
    Result.Bottom := MaxInt;
    ATextParams := cxCalcTextParams(Canvas, ATextFlags);
    cxMakeTextRows(Canvas, PChar(ViewData.Caption), Result, ATextParams, ATextRows, ARowCount, 0);
    Result.Bottom := Result.Top + ARowCount * TextHeight('Wg');
    ATextRows := nil;
  finally
    Free;
  end;
{$ELSE}
  if Length(ViewData.Caption) > 0 then
    Canvas.TextExtent(ViewData.Caption, Result, cxDrawTextFlags[IsDetailCaption])
  else
    Canvas.TextExtent('Wg', Result, cxDrawTextFlags[IsDetailCaption]);
{$ENDIF}
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
  MoreEventButtonGlyphs.DrawingStyle := dsTransparent;
  Canvas.DrawImage(MoreEventButtonGlyphs, Bounds.Left, Bounds.Top, Byte(not IsDown));
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

procedure TcxSchedulerExternalPainter.DoCustomDrawResourceHeader(
  AViewInfo: TcxSchedulerHeaderCellViewInfo; var ADone: Boolean);
begin
  if FCommonPainter <> nil then
    FCommonPainter.DoCustomDrawResourceHeader(AViewInfo, ADone);
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

procedure TcxSchedulerExternalPainter.DrawEvent(AViewInfo: TcxSchedulerEventCellViewInfo);
begin
  with AViewInfo do
    DrawRect(FBounds, FBorders, ViewData.BorderColor);
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

procedure TcxSchedulerCustomResourceView.SetEventImagesLayout(
  const AValue: TcxSchedulerEventImagesLayout);
begin
  if FEventImagesLayout <> AValue then
  begin
    FEventImagesLayout := AValue;
    LayoutChanged;
  end;
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
  FEventImages := nil;
  FResources.Free;
  FButtons.Free;
  FCells.Free;
  inherited Destroy;
end;

procedure TcxSchedulerCustomResourceViewViewInfo.Calculate;
begin
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

function TcxSchedulerCustomResourceViewViewInfo.AddButton(
  ABounds: TRect; const ADateTime: TDateTime; AResourceIndex: Integer;
  AIsDown: Boolean): TcxSchedulerMoreEventsButtonViewInfo;
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
    CreateCellInstance(TcxSchedulerMoreEventsButtonViewInfo, ABounds,
      Styles.GetBackgroundParams, Result)
  else
    CreateCellInstance(TcxSchedulerMoreEventsButtonViewInfo, ABounds,
      GetContentParams(ADateTime, nil), Result);
  Result.FIsDown := AIsDown;
  Result.FDateTime := ADateTime;
  Result.FOnClick := OnMoreEventsButtonClick;
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
    with Resources[AIndex] do
    begin
      Result.FAutoHeight := ResourceHeaders.MultilineCaptions;
      Result.FImageIndex := ImageIndex;
      Result.FImagePosition := ImagePosition;
      Result.FImages := Images;
    end;
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
  Result.Hint := GetEventHint(AEvent);
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
  Result.Caption := DoGetEventDisplayText(AEvent);
  Result.ImagesLayout := View.EventImagesLayout;
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

procedure TcxSchedulerCustomResourceViewViewInfo.DoMoreEventsButtonClick(
  Sender: TcxSchedulerMoreEventsButtonViewInfo);
begin
end;

procedure TcxSchedulerCustomResourceViewViewInfo.ExtractResources;
var
  I: Integer;
begin
  FResources.Clear;
  Adapter.GetPageResources(FResources);
  for I := 0 to FResources.Count - 1 do
    Resources[I].FImagePosition := ResourceHeaders.ImagePosition;
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

function TcxSchedulerCustomResourceViewViewInfo.HasStorage: Boolean;
begin
  Result := View.Scheduler.Storage <> nil;
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

procedure TcxSchedulerCustomResourceViewViewInfo.OnMoreEventsButtonClick(
  Sender: TcxSchedulerMoreEventsButtonViewInfo);
begin
  if not DoSchedulerMoreEventsButtonClick then
    DoMoreEventsButtonClick(Sender);
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
  if HitTest.HitAtButton then
    Exclude(Shift, ssDouble);
  inherited MouseDown(Button, Shift, X, Y);
  if HitTest.HitAtButton then
    HitTest.Button.Click;
end;

function TcxSchedulerCustomResourceViewController.GetHitTest: TcxSchedulerCustomResourceViewHitTest;
begin
  Result := TcxSchedulerCustomResourceViewHitTest(inherited HitTest);
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
  Result := Integer(AEventPlace1.Resource) - Integer(AEventPlace1.Resource);
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
