{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressPrinting System COMPONENT SUITE                      }
{                                                                   }
{       Copyright (C) 1998-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSPRINTINGSYSTEM AND            }
{   ALL ACCOMPANYING VCL CONTROLS AS PART OF AN                     }
{   EXECUTABLE PROGRAM ONLY.                                        }
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

unit dxPScxSchedulerLnk;

{$I cxVer.Inc}

interface

uses
  Windows, Classes, SysUtils, Forms, Graphics, Controls, StdCtrls, ExtCtrls, ComCtrls,
  ImgList, Menus, cxGraphics, cxClasses, cxControls, cxStyles, cxLookAndFeels, cxLookAndFeelPainters,
  cxScheduler, cxEdit, cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxCheckBox, cxImageComboBox, cxTimeEdit, cxSpinEdit, cxDateUtils,
  dxPSCore, dxPSGlbl, dxExtCtrls, dxPScxCommon, dxPrevw, dxPgsdlg, dxPrnPg, cxSchedulerUtils,
  cxSchedulerStorage, cxSchedulerCustomControls, cxSchedulerCustomResourceView,
  cxSchedulerDayView, cxSchedulerDateNavigator, cxSchedulerWeekView, cxGeometry,
  dxCore, cxDrawTextUtils;

const
  // visual print style indexes

  vspsSchedulerFirst = 0;

  vspsSchedulerControlFirst = vspsSchedulerFirst + 0;
  vspsSchedulerContent = vspsSchedulerControlFirst + 0;
  vspsSchedulerDayHeader = vspsSchedulerControlFirst + 1;
  vspsSchedulerEvent = vspsSchedulerControlFirst + 2;
  vspsSchedulerResourceHeader = vspsSchedulerControlFirst + 3;
  vspsSchedulerControlLast = vspsSchedulerControlFirst + 3;

  vspsSchedulerViewDayFirst = vspsSchedulerControlLast + 1;
  vspsSchedulerTimeRuler = vspsSchedulerViewDayFirst + 0;
  vspsSchedulerViewDayLast = vspsSchedulerViewDayFirst + 0;

  vspsSchedulerDateNavigatorFirst = vspsSchedulerViewDayLast + 1;
  vspsSchedulerDateNavigatorContent = vspsSchedulerDateNavigatorFirst + 0;
  vspsSchedulerDateNavigatorHeader = vspsSchedulerDateNavigatorFirst + 1;
  vspsSchedulerDateNavigatorLast = vspsSchedulerDateNavigatorFirst + 1;

  vspsSchedulerNativeFirst = vspsSchedulerDateNavigatorLast + 1;
  vspsSchedulerSchedulerHeader = vspsSchedulerNativeFirst + 0;
  vspsSchedulerNotesAreaBlank = vspsSchedulerNativeFirst + 1;
  vspsSchedulerNotesAreaLined = vspsSchedulerNativeFirst + 2;
  vspsSchedulerTaskPad = vspsSchedulerNativeFirst + 3;
  vspsSchedulerNativeLast = vspsSchedulerNativeFirst + 3;

  vspsSchedulerLast = vspsSchedulerNativeLast;

  // custom draw ID's
  cdidSchedulerFirst = 1;
  cdidSchedulerSchedulerHeader            = cdidSchedulerFirst + 0;
  cdidSchedulerDateNavigatorHeader     = cdidSchedulerFirst + 1;
  cdidSchedulerDateNavigatorDay        = cdidSchedulerFirst + 2;
  cdidSchedulerDateNavigatorDayCaption = cdidSchedulerFirst + 3;
  cdidSchedulerDateNavigatorWeekNumber = cdidSchedulerFirst + 4;
  cdidSchedulerTimeRuler               = cdidSchedulerFirst + 5;
  cdidSchedulerNotesArea               = cdidSchedulerFirst + 6;
  cdidSchedulerTaskPad                 = cdidSchedulerFirst + 7;
  cdidSchedulerContent                 = cdidSchedulerFirst + 8;
  cdidSchedulerHeader                  = cdidSchedulerFirst + 9;
  // keep order
  cdidSchedulerEventCaption            = cdidSchedulerFirst + 10;
  cdidSchedulerEventStart              = cdidSchedulerFirst + 11;
  cdidSchedulerEventFinish             = cdidSchedulerFirst + 12;
  cdidSchedulerEventIcons              = cdidSchedulerFirst + 13;
  cdidSchedulerEventMessage            = cdidSchedulerFirst + 14;
  cdidSchedulerEventTimeLine           = cdidSchedulerFirst + 15;

  InterAreaSpace = 5;
  NotesAreaWidth = 1 / 3;
  SchedulerHeaderMinHeight = 1 / 10;
  SchedulerHeaderMaxHeight = 1 / 4;
  SchedulerHeaderSmallHeight = 1 / 18;

type
  TcxSchedulerReportItemsType = (srSchedulingArea, srHeader, srDateNavigator,
    srNotesBlank, srNotesLined, srTaskPad, srUnknownItem);
  TcxSchedulerReportEventPartType = (epCaption, epStart, epFinish, epIcons,
    epMessage, epTimeLine);

  TcxfmSchedulerReportLinkDesignWindow = class;

  TcxSchedulerReportLink = class;
  TcxCustomSchedulerReportLinkPrintStyle = class;
  TcxCustomSchedulerReportLinkPrintStyleClass = class of TcxCustomSchedulerReportLinkPrintStyle;

  TcxSchedulerReportLinkPrintStyles = class;
  TcxSchedulerReportPageItemCell = class;
  TcxSchedulerReportPageSite = class;
  TcxSchedulerReportSchedulingAreaCell = class;
  TcxSchedulerReportSchedulerHeaderCell = class;
  TcxSchedulerReportDateNavigatorCell = class;
  TcxSchedulerReportNotesAreaCell = class;
  TcxSchedulerReportTaskPadCell = class;

  TcxSchedulerReportCustomCell = class;
  TcxSchedulerReportCustomCellClass = class of TcxSchedulerReportCustomCell;
  TcxSchedulerReportCommonCellsProducer = class;

  // for options
  TcxCustomSchedulerReportLinkOptions = class;
  TcxSchedulerReportDateNavigatorHeader = class;
  TcxSchedulerReportDateNavigatorDay = class;
  TcxSchedulerReportDateNavigatorDayCaption = class;
  TcxSchedulerReportDateNavigatorWeekNumber = class;
  TcxSchedulerReportDailyTimeRulerCell = class;
  TcxSchedulerReportContentCell = class;
  TcxSchedulerReportCustomEventCell = class;
  TcxSchedulerReportSchedulerHeaderDataCell = class;
  TcxSchedulerReportNotesDataCell = class;
  TcxSchedulerReportHeaderItemCell = class;
  TcxSchedulerReportDetailsEventCell = class;
  TcxSchedulerReportDetailsEventCellClass = class of TcxSchedulerReportDetailsEventCell;

  { TcxCustomSchedulerReportLinkOptions }

  TcxCustomSchedulerReportLinkOptions = class(TdxCustomReportLinkOptions)
  private
    function GetReportLink: TcxSchedulerReportLink;
    function GetScheduler: TcxScheduler;
  public
    property ReportLink: TcxSchedulerReportLink read GetReportLink;
    property Scheduler: TcxScheduler read GetScheduler;
  end;

  { TcxSchedulerReportLinkPrintRange }

  TcxSchedulerReportLinkPrintRange = class(TcxCustomSchedulerReportLinkOptions)
  private
    FDatePrint: array[0..1] of TDate;
    FTimePrint: array[0..1] of TTime;
    function GetActiveStyle: TcxCustomSchedulerReportLinkPrintStyle;
    function GetDayCount: Integer;
    function GetMonthCount: Integer;
    function GetPrintDate(AIndex: Integer): TDate;
    function GetPrintTime(AIndex: Integer): TTime;
    function GetWeekCount: Integer;
    procedure SetPrintDate(AIndex: Integer; const Value: TDate);
    procedure SetPrintTime(AIndex: Integer; const Value: TTime);

    function IsDateStored(AIndex: Integer): Boolean;
    function IsTimeStored(AIndex: Integer): Boolean;
  protected
    procedure CheckTimeRange; virtual;
    function GetDateTimeIF(const AValue, ADefaultValue: TDateTime): TDateTime;

    function DesignerTabIndex: Integer; override;
    property ActiveStyle: TcxCustomSchedulerReportLinkPrintStyle read GetActiveStyle;
  public
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;

    function DefaultDatePrintFrom: TDate; virtual;
    function DefaultDatePrintTo: TDate; virtual;
    function DefaultTimePrintFrom: TTime; virtual;
    function DefaultTimePrintTo: TTime; virtual; 

    property DayCount: Integer read GetDayCount;
    property MonthCount: Integer read GetMonthCount;
    property WeekCount: Integer read GetWeekCount;
  published
    property PrintFrom: TDate index 0 read GetPrintDate write SetPrintDate stored IsDateStored;
    property PrintTo: TDate index 1 read GetPrintDate write SetPrintDate stored IsDateStored;
    property TimePrintFrom: TTime index 0 read GetPrintTime write SetPrintTime stored IsTimeStored;
    property TimePrintTo: TTime index 1 read GetPrintTime write SetPrintTime stored IsTimeStored;
  end;

  { TcxSchedulerReportLinkOptionsFormatting }

  TcxSchedulerReportLinkOptionsFormatting = class(TdxCustomReportLinkOptionsFormatting)
  private
    FSuppressContentColoration: Boolean;
    function GetReportLink: TcxSchedulerReportLink;
    procedure SetSuppressContentColoration(Value: Boolean);
  protected
    function DesignerTabIndex: Integer; override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;

    property ReportLink: TcxSchedulerReportLink read GetReportLink;
  published
    property SuppressContentColoration: Boolean read FSuppressContentColoration write SetSuppressContentColoration default False;
    property UseLookAndFeelColors;
  end;

  { TcxSchedulerReportLinkStyles }
  
  TcxSchedulerReportLinkStyles = class(TdxCustomReportLinkStyles, IcxSchedulerStylesAdapter, IcxSchedulerTimeRulerParams)
  private
    function GetExtStyles: TcxSchedulerStyles;
    function GetReportLink: TcxSchedulerReportLink;
    function GetUseSchedulerStyles: Boolean;
  protected
    FReportLink: TcxSchedulerReportLink;
    function DesignerTabIndex: Integer; override;

    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;
    class function GetStyleCaption(AnIndex: Integer): string; override;
    function GetStyleIndexByCaption(const Caption: string): Integer; override;

    // IcxSchedulerStylesAdapter
    function GetDayHeaderStyle: TcxStyle;
    function GetResourceHeaderStyle: TcxStyle;

    property ExtStyles: TcxSchedulerStyles read GetExtStyles;
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;

    function GetSchedulerHeaderParams: TcxViewParams; virtual;
    function GetContentParams(const ADateTime: TDateTime;
      AResource: TcxSchedulerStorageResourceItem): TcxViewParams; overload; virtual;
    function GetContentParams(const ADateTime: TDateTime; ALightColor: Boolean;
      AResource: TcxSchedulerStorageResourceItem): TcxViewParams; overload; virtual;
    function GetDateNavigatorContentParams: TcxViewParams; virtual;
    function GetDateNavigatorHeaderParams: TcxViewParams; virtual;
    function GetDayHeaderParams(const ADateTime: TDateTime): TcxViewParams; virtual;
    function GetEventParams(AEvent: TcxSchedulerEvent): TcxViewParams; virtual;
    function GetNotesAreaBlankParams: TcxViewParams; virtual;
    function GetNotesAreaLinedParams: TcxViewParams; virtual;
    function GetResourceHeaderParams(AResource: TcxSchedulerStorageResourceItem): TcxViewParams; virtual;
    function GetTaskPadParams: TcxViewParams; virtual;
    function GetTimeRulerParams: TcxViewParams; virtual;

    property UseSchedulerStyles: Boolean read GetUseSchedulerStyles;
    property ReportLink: TcxSchedulerReportLink read GetReportLink;
  published
    property SchedulerHeader: TcxStyle Index vspsSchedulerSchedulerHeader read GetValue write SetValue;
    property Content: TcxStyle Index vspsSchedulerContent read GetValue write SetValue;
    property DateNavigatorContent: TcxStyle Index vspsSchedulerDateNavigatorContent read GetValue write SetValue;
    property DateNavigatorHeader: TcxStyle Index vspsSchedulerDateNavigatorHeader read GetValue write SetValue;
    property DayHeader: TcxStyle Index vspsSchedulerDayHeader read GetValue write SetValue;
    property Event: TcxStyle Index vspsSchedulerEvent read GetValue write SetValue;
    property ResourceHeader: TcxStyle Index vspsSchedulerResourceHeader read GetValue write SetValue;
    property NotesAreaBlank: TcxStyle Index vspsSchedulerNotesAreaBlank read GetValue write SetValue;
    property NotesAreaLined: TcxStyle Index vspsSchedulerNotesAreaLined read GetValue write SetValue;
    property TaskPad: TcxStyle Index vspsSchedulerTaskPad read GetValue write SetValue;
    property TimeRuler: TcxStyle Index vspsSchedulerTimeRuler read GetValue write SetValue;

    property StyleSheet;
  end;

  TcxSchedulerReportLinkStyleSheet = class(TdxCustomReportLinkStyleSheet)
  private
    function GetStylesValue: TcxSchedulerReportLinkStyles;
    procedure SetStylesValue(Value: TcxSchedulerReportLinkStyles);
  public
    class function GetStylesClass: TcxCustomStylesClass; override;
  published
    property Styles: TcxSchedulerReportLinkStyles read GetStylesValue write SetStylesValue;
  end;

  { TcxSchedulerReportLinkRenderInfo }

  TcxSchedulerReportLinkRenderInfo = class(TdxPSReportRenderInfo)
  private
    function GetReportLink: TcxSchedulerReportLink;
  protected
    Rendering: Boolean;
    FPageColCount: Integer;
    FPageRowCount: Integer;
    procedure DoCalculate; override;
    function GetPageColCount: Integer; override;
    function GetPageRowCount: Integer; override;
    function IsLoading: Boolean;
  public
    function IsDrawPageTitleOnPage(APageIndex: Integer): Boolean; override;
    function IsDrawReportTitleOnPage(APageIndex: Integer): Boolean;
    property ReportLink: TcxSchedulerReportLink read GetReportLink;
  end;

  { TcxSchedulerReportRenderer }

  TcxSchedulerReportRenderer = class(TdxPSReportRenderer)
  public
    procedure PrepareRenderPage; override;
    procedure UnprepareRenderPage; override;
  end;

  { TcxSchedulerReportLink }
  TcxSchedulerReportLinkCanPrintEventEvent = procedure(Sender: TcxSchedulerReportLink;
    AEvent: TcxSchedulerEvent; var AllowPrint: Boolean) of object;

  { Initilization Events }

  TcxSchedulerReportLinkInitializeSchedulerHeaderEvent = procedure(
    Sender: TcxSchedulerReportLink; AItem: TcxSchedulerReportSchedulerHeaderCell) of object;
  TcxSchedulerReportLinkInitializeSchedulingAreaEvent = procedure(
    Sender: TcxSchedulerReportLink; AItem: TcxSchedulerReportSchedulingAreaCell) of object;
  TcxSchedulerReportLinkInitializeNotesEvent = procedure(
    Sender: TcxSchedulerReportLink; AItem: TcxSchedulerReportNotesAreaCell) of object;
  TcxSchedulerReportLinkInitializeTaskPadEvent = procedure(
    Sender: TcxSchedulerReportLink; AItem: TcxSchedulerReportTaskPadCell) of object;
  TcxSchedulerReportLinkInitializeEventCellEvent = procedure(
    Sender: TcxSchedulerReportLink; AItem: TcxSchedulerReportCustomEventCell) of object;

  { CustomDraw Events }

  TcxSchedulerReportLinkCustomDrawSchedulerHeaderCellEvent = procedure(Sender: TcxSchedulerReportLink;
    ACanvas: TCanvas; AItem: TcxSchedulerReportSchedulerHeaderDataCell; var ADone: Boolean) of object;
  TcxSchedulerReportLinkCustomDrawDateNavigatorHeaderCellEvent = procedure(Sender: TcxSchedulerReportLink;
    ACanvas: TCanvas; AItem: TcxSchedulerReportDateNavigatorHeader; var ADone: Boolean) of object;
  TcxSchedulerReportLinkCustomDrawDateNavigatorDayCellEvent = procedure(Sender: TcxSchedulerReportLink;
    ACanvas: TCanvas; AItem: TcxSchedulerReportDateNavigatorDay; var ADone: Boolean) of object;
  TcxSchedulerReportLinkCustomDrawDateNavigatorDayCaptionCellEvent = procedure(Sender: TcxSchedulerReportLink;
    ACanvas: TCanvas; AItem: TcxSchedulerReportDateNavigatorDayCaption; var ADone: Boolean) of object;
  TcxSchedulerReportLinkCustomDrawDateNavigatorWeekNumberCellEvent = procedure(Sender: TcxSchedulerReportLink;
    ACanvas: TCanvas; AItem: TcxSchedulerReportDateNavigatorWeekNumber; var ADone: Boolean) of object;
  TcxSchedulerReportLinkCustomDrawTimeRulerCellEvent = procedure(Sender: TcxSchedulerReportLink;
    ACanvas: TCanvas; AItem: TcxSchedulerReportDailyTimeRulerCell; var ADone: Boolean) of object;
  TcxSchedulerReportLinkCustomDrawNotesCellEvent = procedure(Sender: TcxSchedulerReportLink;
    ACanvas: TCanvas; AItem: TcxSchedulerReportNotesDataCell; var ADone: Boolean) of object;
  TcxSchedulerReportLinkCustomDrawContentCellEvent = procedure(Sender: TcxSchedulerReportLink;
    ACanvas: TCanvas; AItem: TcxSchedulerReportContentCell; var ADone: Boolean) of object;
  TcxSchedulerReportLinkCustomDrawHeaderCellEvent = procedure(Sender: TcxSchedulerReportLink;
    ACanvas: TCanvas; AItem: TcxSchedulerReportHeaderItemCell; var ADone: Boolean) of object;
  TcxSchedulerReportLinkCustomDrawEventPartCellEvent = procedure(Sender: TcxSchedulerReportLink;
    ACanvas: TCanvas; AItem: TAbstractdxReportCellData;
    APart: TcxSchedulerReportEventPartType; var ADone: Boolean) of object;

  TcxSchedulerReportLink = class(TdxCustomcxControlReportLink, IdxReportLinkController)
  private
    FLinkInPreviewMode: Boolean;
    FLookAndFeelItems: TList;
    FPageSites: TList;
    FPrintRange: TcxSchedulerReportLinkPrintRange;
    FPrintStyles: TcxSchedulerReportLinkPrintStyles;
    FTaskPadReportLink: TBasedxReportLink;
    FOnActivePrintStyleChanged: TNotifyEvent;
    FOnCanPrintEvent: TcxSchedulerReportLinkCanPrintEventEvent;
    
    FOnCustomDrawSchedulerHeaderCell: TcxSchedulerReportLinkCustomDrawSchedulerHeaderCellEvent;
    FOnCustomDrawDateNavigatorHeaderCell: TcxSchedulerReportLinkCustomDrawDateNavigatorHeaderCellEvent;
    FOnCustomDrawDateNavigatorDayCell: TcxSchedulerReportLinkCustomDrawDateNavigatorDayCellEvent;
    FOnCustomDrawDateNavigatorDayCaptionCell: TcxSchedulerReportLinkCustomDrawDateNavigatorDayCaptionCellEvent;
    FOnCustomDrawDateNavigatorWeekNumberCell: TcxSchedulerReportLinkCustomDrawDateNavigatorWeekNumberCellEvent;
    FOnCustomDrawTimeRulerCell: TcxSchedulerReportLinkCustomDrawTimeRulerCellEvent;
    FOnCustomDrawContentCell: TcxSchedulerReportLinkCustomDrawContentCellEvent;
    FOnCustomDrawHeaderCell: TcxSchedulerReportLinkCustomDrawHeaderCellEvent;
    FOnCustomDrawEventPartCell: TcxSchedulerReportLinkCustomDrawEventPartCellEvent;
    FOnCustomDrawNotesCell: TcxSchedulerReportLinkCustomDrawNotesCellEvent;
    FOnCustomDrawTaskPadCell: TcxSchedulerReportLinkCustomDrawNotesCellEvent;

    FOnInitializeSchedulingAreaCell: TcxSchedulerReportLinkInitializeSchedulingAreaEvent;
    FOnInitializeEventCell: TcxSchedulerReportLinkInitializeEventCellEvent;
    FOnInitializeHeaderPrimaryCell: TcxSchedulerReportLinkInitializeSchedulerHeaderEvent;
    FOnInitializeHeaderSecondaryCell: TcxSchedulerReportLinkInitializeSchedulerHeaderEvent;
    FOnInitializeNotesAreaCell: TcxSchedulerReportLinkInitializeNotesEvent;
    FOnInitializeTaskPadCell: TcxSchedulerReportLinkInitializeTaskPadEvent;
    function GetActiveStyles: TcxSchedulerReportLinkStyles;
    function GetDesignWindow: TcxfmSchedulerReportLinkDesignWindow;
    function GetEdgeMode: TdxCellEdgeMode;
    function GetLookAndFeelItem(Index: Integer): TdxReportVisualItem;
    function GetLookAndFeelItemCount: Integer;
    function GetOptionsFormatting: TcxSchedulerReportLinkOptionsFormatting;
    function GetPrintStyles: TcxSchedulerReportLinkPrintStyles;
    function GetRenderInfo: TcxSchedulerReportLinkRenderInfo;
    function GetScheduler: TcxScheduler;
    function GetStyles: TcxSchedulerReportLinkStyles;
    procedure SetOptionsFormatting(Value: TcxSchedulerReportLinkOptionsFormatting);
    procedure SetPrintRange(Value: TcxSchedulerReportLinkPrintRange);
    procedure SetPrintStyles(Value: TcxSchedulerReportLinkPrintStyles);
    procedure SetStyles(Value: TcxSchedulerReportLinkStyles);
    procedure SetTaskPadReportLink(Value: TBasedxReportLink);

  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    { IdxReportLinkController }
    function GetControlSiteBounds(AControl: TControl): TRect; virtual;

    procedure ConstructReport(AReportCells: TdxReportCells); override;
    procedure DoCreateReport; override;

    procedure CustomDraw(AItem: TAbstractdxReportCellData; ACanvas: TCanvas;
      ABoundsRect, AClientRect: TRect; var ADone: Boolean); override;

    procedure DoCanPrintEvent(AEvent: TcxSchedulerEvent; var AllowPrint: Boolean); virtual;

    procedure DoCustomDrawSchedulerHeaderCell(ACanvas: TCanvas;
      AItem: TcxSchedulerReportSchedulerHeaderDataCell; var ADone: Boolean); virtual;
    procedure DoCustomDrawDateNavigatorHeaderCell(ACanvas: TCanvas;
      AItem: TcxSchedulerReportDateNavigatorHeader; var ADone: Boolean); virtual;
    procedure DoCustomDrawDateNavigatorDayCell(ACanvas: TCanvas;
      AItem: TcxSchedulerReportDateNavigatorDay; var ADone: Boolean); virtual;
    procedure DoCustomDrawDateNavigatorDayCaptionCell(ACanvas: TCanvas;
      AItem: TcxSchedulerReportDateNavigatorDayCaption; var ADone: Boolean); virtual;
    procedure DoCustomDrawDateNavigatorWeekNumberCell(ACanvas: TCanvas;
      AItem: TcxSchedulerReportDateNavigatorWeekNumber; var ADone: Boolean); virtual;
    procedure DoCustomDrawTimeRulerCell(ACanvas: TCanvas;
      AItem: TcxSchedulerReportDailyTimeRulerCell; var ADone: Boolean); virtual;
    procedure DoCustomDrawContentCell(ACanvas: TCanvas;
      AItem: TcxSchedulerReportContentCell; var ADone: Boolean); virtual;
    procedure DoCustomDrawHeaderCell(ACanvas: TCanvas;
      AItem: TcxSchedulerReportHeaderItemCell; var ADone: Boolean); virtual;
    procedure DoCustomDrawEventPartCell(ACanvas: TCanvas;
      AItem: TAbstractdxReportCellData; var ADone: Boolean); virtual;
    procedure DoCustomDrawNotesCell(ACanvas: TCanvas;
      AItem: TcxSchedulerReportNotesDataCell; var ADone: Boolean); virtual;
    procedure DoCustomDrawTaskPadCell(ACanvas: TCanvas;
      AItem: TcxSchedulerReportNotesDataCell; var ADone: Boolean); virtual;

    function GetRealScaleFactor: Integer; override;
    function GetRebuildOnPageParamsChange(AUpdateCodes: TdxPrinterPageUpdateCodes): Boolean; override;
    function GetRendererClass: TdxPSReportRendererClass; override;
    function GetRenderInfoClass: TdxPSReportRenderInfoClass; override;
    procedure InternalRestoreDefaults; override;
    procedure InternalRestoreFromOriginal; override;
    procedure PrepareConstruct; override;
    procedure UnprepareConstruct; override;

    procedure CreateOptions; override;
    procedure DestroyOptions; override;
    function GetOptionsFormattingClass: TdxCustomReportLinkOptionsFormattingClass; override;

    function CreatePrintRange: TcxSchedulerReportLinkPrintRange; virtual;
    function CreatePrintStyles: TcxSchedulerReportLinkPrintStyles; virtual;

    function GetAreNativeStylesAvailable: Boolean; override;
    function GetStylesClass: TdxCustomReportLinkStylesClass; override;
    function GetStyleSheetClass: TdxCustomReportLinkStyleSheetClass; override;
    function GetStyleSheetPrototype: TdxCustomReportLinkStyleSheet; override;

    procedure ActivePrintStyleChanged; virtual;
    procedure DoActivePrintStyleChanged; virtual;

    procedure FormatLookAndFeelItems;
    procedure RegisterLookAndFeelItem(AItem: TdxReportVisualItem; AEdgeStyle: TdxCellEdgeStyle);

    procedure DoInitializeSchedulingAreaCell(AItem: TcxSchedulerReportSchedulingAreaCell); virtual;
    procedure DoInitializeEventCell(AItem: TcxSchedulerReportCustomEventCell); virtual;
    procedure DoInitializeHeaderPrimaryCell(AItem: TcxSchedulerReportSchedulerHeaderCell); virtual;
    procedure DoInitializeHeaderSecondaryCell(AItem: TcxSchedulerReportSchedulerHeaderCell); virtual;
    procedure DoInitializeNotesAreaCell(AItem: TcxSchedulerReportNotesAreaCell); virtual;
    procedure DoInitializeTaskPadCell(AItem: TcxSchedulerReportTaskPadCell); virtual;

    procedure AssignTaskPadData(ATaskPad: TcxSchedulerReportTaskPadCell);
    procedure InitializeTaskPadCell(ATaskPad: TcxSchedulerReportTaskPadCell); virtual;

    procedure SetCellViewParams(ACell: TdxReportVisualItem; const AParams: TcxViewParams); overload;
    procedure SetCellViewParams(ACell: TdxReportVisualItem; const AParams: TdxReportItemViewParams); overload;

    function AddPageSite(const ABounds: TRect): TcxSchedulerReportPageSite;  
    procedure BuildStyle; virtual;

    property ActiveStyles: TcxSchedulerReportLinkStyles read GetActiveStyles;

    property EdgeMode: TdxCellEdgeMode read GetEdgeMode;
    property LinkInPreviewMode: Boolean read FLinkInPreviewMode write FLinkInPreviewMode;
    property LookAndFeelItemCount: Integer read GetLookAndFeelItemCount;
    property LookAndFeelItems[Index: Integer]: TdxReportVisualItem read GetLookAndFeelItem;
    property PageSites: TList read FPageSites;
    property RenderInfo: TcxSchedulerReportLinkRenderInfo read GetRenderInfo;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    class function Aggregable: Boolean; override;
    procedure RebuildReport; override;

    property DesignWindow: TcxfmSchedulerReportLinkDesignWindow read GetDesignWindow;
    property Scheduler: TcxScheduler read GetScheduler;

  published
    property Color;
    property Font;

    property OptionsFormatting: TcxSchedulerReportLinkOptionsFormatting read GetOptionsFormatting write SetOptionsFormatting;
    property PrintRange: TcxSchedulerReportLinkPrintRange read FPrintRange write SetPrintRange;
    property PrintStyles: TcxSchedulerReportLinkPrintStyles read GetPrintStyles write SetPrintStyles;
    property ScaleFonts;
    property StyleRepository;
    property Styles: TcxSchedulerReportLinkStyles read GetStyles write SetStyles;
    property SupportedCustomDraw;
    property TaskPadReportLink: TBasedxReportLink read FTaskPadReportLink write SetTaskPadReportLink;

    property OnActivePrintStyleChanged: TNotifyEvent read FOnActivePrintStyleChanged write FOnActivePrintStyleChanged;
    property OnCanPrintEvent: TcxSchedulerReportLinkCanPrintEventEvent read FOnCanPrintEvent write FOnCanPrintEvent;

    property OnCustomDrawSchedulerHeaderCell: TcxSchedulerReportLinkCustomDrawSchedulerHeaderCellEvent
      read FOnCustomDrawSchedulerHeaderCell write FOnCustomDrawSchedulerHeaderCell;
    property OnCustomDrawDateNavigatorHeaderCell: TcxSchedulerReportLinkCustomDrawDateNavigatorHeaderCellEvent
      read FOnCustomDrawDateNavigatorHeaderCell write FOnCustomDrawDateNavigatorHeaderCell;
    property OnCustomDrawDateNavigatorDayCell: TcxSchedulerReportLinkCustomDrawDateNavigatorDayCellEvent
      read FOnCustomDrawDateNavigatorDayCell write FOnCustomDrawDateNavigatorDayCell;
    property OnCustomDrawDateNavigatorDayCaptionCell: TcxSchedulerReportLinkCustomDrawDateNavigatorDayCaptionCellEvent
      read FOnCustomDrawDateNavigatorDayCaptionCell write FOnCustomDrawDateNavigatorDayCaptionCell;
    property OnCustomDrawDateNavigatorWeekNumberCell: TcxSchedulerReportLinkCustomDrawDateNavigatorWeekNumberCellEvent
      read FOnCustomDrawDateNavigatorWeekNumberCell write FOnCustomDrawDateNavigatorWeekNumberCell;
    property OnCustomDrawTimeRulerCell: TcxSchedulerReportLinkCustomDrawTimeRulerCellEvent
      read FOnCustomDrawTimeRulerCell write FOnCustomDrawTimeRulerCell;
    property OnCustomDrawContentCell: TcxSchedulerReportLinkCustomDrawContentCellEvent
      read FOnCustomDrawContentCell write FOnCustomDrawContentCell;
    property OnCustomDrawHeaderCell: TcxSchedulerReportLinkCustomDrawHeaderCellEvent
      read FOnCustomDrawHeaderCell write FOnCustomDrawHeaderCell;
    property OnCustomDrawEventPartCell: TcxSchedulerReportLinkCustomDrawEventPartCellEvent
      read FOnCustomDrawEventPartCell write FOnCustomDrawEventPartCell;
    property OnCustomDrawNotesCell: TcxSchedulerReportLinkCustomDrawNotesCellEvent
      read FOnCustomDrawNotesCell write FOnCustomDrawNotesCell;
    property OnCustomDrawTaskPadCell: TcxSchedulerReportLinkCustomDrawNotesCellEvent
      read FOnCustomDrawTaskPadCell write FOnCustomDrawTaskPadCell;

    property OnInitializeSchedulingAreaCell: TcxSchedulerReportLinkInitializeSchedulingAreaEvent
      read FOnInitializeSchedulingAreaCell write FOnInitializeSchedulingAreaCell;
    property OnInitializeEventCell: TcxSchedulerReportLinkInitializeEventCellEvent
      read FOnInitializeEventCell write FOnInitializeEventCell;
    property OnInitializeHeaderPrimaryCell: TcxSchedulerReportLinkInitializeSchedulerHeaderEvent
      read FOnInitializeHeaderPrimaryCell write FOnInitializeHeaderPrimaryCell;
    property OnInitializeHeaderSecondaryCell: TcxSchedulerReportLinkInitializeSchedulerHeaderEvent
      read FOnInitializeHeaderSecondaryCell write FOnInitializeHeaderSecondaryCell;
    property OnInitializeNotesAreaCell: TcxSchedulerReportLinkInitializeNotesEvent
      read FOnInitializeNotesAreaCell write FOnInitializeNotesAreaCell;
    property OnInitializeTaskPadCell: TcxSchedulerReportLinkInitializeTaskPadEvent
      read FOnInitializeTaskPadCell write FOnInitializeTaskPadCell;
  end;

  { TcxCustomSchedulerReportLinkPrintStyle }

  TcxSchedulerReportLinkPeriodicPrintStyleLayout = (pslOnePage, pslTwoPages);

  TcxCustomSchedulerReportLinkPrintStyle = class(TPersistent,
    IUnknown, IdxPSCellParams, IdxPSCellParams2)
  private
    FBoldedDays: TcxSchedulerDateList;
    FCaption: string;
    FCompressWeekends: Boolean;
    FDontPrintWeekends: Boolean;
    FEvents: TcxSchedulerCachedEventList;
    FLayout: TcxSchedulerReportLinkPeriodicPrintStyleLayout;
    FPagesPerPeriod: Integer;
    FResourceCountPerPage: Integer;
    FShowNotesAreaBlank: Boolean;
    FShowNotesAreaLined: Boolean;
    FShowTaskPad: Boolean;
    FStyles: TcxSchedulerReportLinkPrintStyles;
    FUsedDays: TcxSchedulerDateList;
    function GetActive: Boolean;
    function GetHasAdditionalArea: Boolean;
    function GetIndex: Integer;
    function GetPageSite(AIndex: Integer): TcxSchedulerReportPageSite;
    function GetPeriodCount: Integer;
    function GetPrintRange: TcxSchedulerReportLinkPrintRange;
    function GetReportLink: TcxSchedulerReportLink;
    function GetResourceCount: Integer;
    function GetScheduler: TcxScheduler;
    function GetStorage: TcxCustomSchedulerStorage;
    function GetTimePrintFrom: TTime;
    function GetTimePrintTo: TTime;
    function GetVisualStyles: TcxSchedulerReportLinkStyles;
    function IsCaptionStored: Boolean;
    function IsLayoutStored: Boolean;
    function IsShowNotesAreaBlankStored: Boolean;
    function IsActiveStored: Boolean;
    procedure SetActive(Value: Boolean);
    procedure SetCaption(const Value: string);
    procedure SetCompressWeekends(Value: Boolean);
    procedure SetDontPrintWeekends(Value: Boolean);
    procedure SetLayout(Value: TcxSchedulerReportLinkPeriodicPrintStyleLayout);
    procedure SetResourceCountPerPage(Value: Integer);
    procedure SetShowNotesAreaBlank(Value: Boolean);
    procedure SetShowNotesAreaLined(Value: Boolean);
    procedure SetShowTaskPad(Value: Boolean);
    procedure SetTimePrintFrom(Value: TTime);
    procedure SetTimePrintTo(Value: TTime);
  protected
    CurrentDate: TDateTime;
    { IUnknown }
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    { IdxReportLinkController }
    function GetControlSiteBounds(AControl: TControl): TRect; virtual;
    { IdxPSCellParams }
    function IdxPSCellParams.GetAutoHeight = IdxPSCellParams_GetAutoHeight;
    function IdxPSCellParams.GetDC = IdxPSCellParams_GetDC;
    function IdxPSCellParams.GetDisplayGraphicsAsText = IdxPSCellParams_GetDisplayGraphicsAsText;
    function IdxPSCellParams.GetEndEllipsis = IdxPSCellParams_GetEndEllipsis;
    function IdxPSCellParams.GetFlatCheckMarks = IdxPSCellParams_GetFlatCheckMarks;
    function IdxPSCellParams.GetGraphicsText = IdxPSCellParams_GetGraphicsText;
    function IdxPSCellParams.GetMultiline = IdxPSCellParams_GetMultiline;
    function IdxPSCellParams.GetTransparentGraphics = IdxPSCellParams_GetTransparentGraphics;
    function IdxPSCellParams_GetAutoHeight: Boolean; virtual;
    function IdxPSCellParams_GetDC: HDC; virtual;
    function IdxPSCellParams_GetDisplayGraphicsAsText: Boolean; virtual;
    function IdxPSCellParams_GetEndEllipsis: Boolean; virtual;
    function IdxPSCellParams_GetFlatCheckMarks: Boolean; virtual;
    function IdxPSCellParams_GetGraphicsText: string; virtual;
    function IdxPSCellParams_GetMultiline: Boolean; virtual;
    function IdxPSCellParams_GetTransparentGraphics: Boolean; virtual;
    { IdxPSCellParams2 }
    function IdxPSCellParams2.GetPreviewMarginLeft = IdxPSCellParams2_GetPreviewMarginLeft;
    function IdxPSCellParams2.GetPreviewMarginRight = IdxPSCellParams2_GetPreviewMarginRight;
    function IdxPSCellParams2.GetPreviewMaxHeight = IdxPSCellParams2_GetPreviewMaxHeight;
    function IdxPSCellParams2.GetPreviewMaxLineCount = IdxPSCellParams2_GetPreviewMaxLineCount;
    function IdxPSCellParams2.GetRichEditGraphicClass = IdxPSCellParams2_GetRichEditGraphicClass;
    function IdxPSCellParams2.GetRichEditTransparent = IdxPSCellParams2_GetRichEditTransparent;
    function IdxPSCellParams2_GetPreviewMarginLeft: Integer; virtual;
    function IdxPSCellParams2_GetPreviewMarginRight: Integer; virtual;
    function IdxPSCellParams2_GetPreviewMaxHeight: Integer; virtual;
    function IdxPSCellParams2_GetPreviewMaxLineCount: Integer; virtual;
    function IdxPSCellParams2_GetRichEditGraphicClass: TGraphicClass; virtual;
    function IdxPSCellParams2_GetRichEditTransparent: Boolean; virtual;

    //
    function AddPageSite(const ABounds: TRect): TcxSchedulerReportPageSite; virtual;

    procedure AfterBuild; virtual;
    procedure BeforeBuild; virtual;
    procedure Build; virtual;
    procedure BuildPages; virtual;
    procedure BuildSchedulerCells(ASite: TcxSchedulerReportSchedulingAreaCell); virtual;
    procedure Progress(APercentDone: Double); virtual;

    procedure PrepareEvents; virtual;
    procedure DoCanPrintEvent(AEvent: TcxSchedulerEvent; var AllowPrint: Boolean); virtual;

    procedure Changed; virtual;
    procedure CreateObjects; virtual;
    procedure DestroyObjects; virtual;
    function GetPageCount: Integer; virtual;

    function GetRebuildOnPageParamsChange(AnUpdateCodes: TdxPrinterPageUpdateCodes): Boolean; virtual;

    function GetActualDatePrintFrom: TDate; virtual;
    function GetActualDatePrintTo: TDate; virtual;
    function GetCorrespondedView: TcxSchedulerCustomResourceView; virtual;
    function GetPagesPerPeriod: Integer; virtual;

    function GetGlyphIndex: Integer; virtual;
    function GetPreviewGlyphIndex: Integer; virtual;
    function GetSchedulerHeaderParams: TdxReportItemViewParams; virtual;

    procedure DrawDesignWindowPreview(ACanvas: TCanvas; const ABounds: TRect);
    // actually option state
    function GetResourcePageCount: Integer; virtual;
    function GetShowDateNavigator(APageIndex: Integer): Boolean; virtual;
    function GetShowNotesAreaBlank: Boolean; virtual;

    procedure SetBoolOption(var AOption: Boolean; Value: Boolean);
    function SupportTimeRange: Boolean; virtual;
    // draw options
    function SupportIcons: Boolean; virtual;
    function SupportMessage: Boolean; virtual;

    // report cells creation
    function CreateDateNavigatorCell(ASite: TdxReportCell; AYear, AMonth: Word): TcxSchedulerReportDateNavigatorCell; virtual;
    function CreateHeaderCell(ASite: TdxReportCell): TcxSchedulerReportSchedulerHeaderCell; virtual;
    function CreateNotesCell(ASite: TdxReportCell): TcxSchedulerReportNotesAreaCell; virtual;
    function CreateNotesLinedCell(ASite: TdxReportCell): TcxSchedulerReportNotesAreaCell; virtual;
    function CreateSchedulingAreaCell(ASite: TdxReportCell): TcxSchedulerReportSchedulingAreaCell; virtual;
    function CreateSchedulingCellsProducer(ASite: TcxSchedulerReportSchedulingAreaCell): TcxSchedulerReportCommonCellsProducer; virtual;
    function CreateTaskPadCell(ASite: TdxReportCell): TcxSchedulerReportTaskPadCell; virtual;

    procedure InitHeaderCell(ACell: TcxSchedulerReportSchedulerHeaderCell); virtual;
    function InitReportCell(ACell: TdxReportCell; const ABounds: TRect): TdxReportCell;

    procedure CorrectBoundsWithHeader(AHeader: TcxSchedulerReportSchedulerHeaderCell; var ABounds: TRect);
    procedure CreateAdditionalControls(ASite: TdxReportCell; AHasCalendar,
      AHasTaskPad, AHasNotes, AHasNotesLined, ARightSide: Boolean; var ABounds: TRect); virtual;

    procedure CreateControlsOnFirstPage(APageIndex: Integer;
      ASite, AHeader: TdxReportCell; ABounds: TRect); virtual;
    procedure CreateControlsOnSecondPage(APageIndex: Integer;
      ASite, AHeader: TdxReportCell; ABounds: TRect); virtual;
    procedure CreateHeaderDateNavigator(AHeader: TcxSchedulerReportSchedulerHeaderCell; APageIndex: Integer; out ABounds: TRect); virtual;
    procedure CreateLayoutForPeriod(APeriodIndex: Integer); virtual;
    procedure CreatePageSiteWithHeader(APageIndex: Integer;
      out ASite: TcxSchedulerReportPageSite; out AHeader: TcxSchedulerReportSchedulerHeaderCell;
      out ABounds: TRect; AIsPrimary: Boolean = True);
    // items visibility
    function CanSplitSchedulingOnTwoPages: Boolean; virtual;
    function GetHasPageHeader(APageIndex: Integer): Boolean; virtual;
    function GetHasPageReportTitle(APageIndex: Integer): Boolean; virtual;
    function GetPageHeaderHeight(const ASiteBounds: TRect; APageIndex: Integer): Integer;
    function GetPageIndex(APeriodIndex, AIndex: Integer): Integer;
    procedure GetPagePeriodAndIndex(APageIndex: Integer; var APeriodIndex, ASubIndex: Integer);
    function GetPageSiteBounds(APageIndex: Integer): TRect; virtual;
    function GetStartOfWeekOffset: Integer; virtual;
    // extracting events and dates for period
    procedure GetPageDateNavigatorInfo(
      APageIndex: Integer; out AYear, AMonth: Word); virtual;
    function GetDaysPerPeriod: Integer; virtual;
    procedure FillDatesForPage(ADateList: TcxSchedulerDateList;
      APageIndex, APeriodIndex, ASubIndex: Integer); virtual;

    property CompressWeekends: Boolean read FCompressWeekends write SetCompressWeekends default True;
    property DontPrintWeekends: Boolean read FDontPrintWeekends write SetDontPrintWeekends default False;
    property Events: TcxSchedulerCachedEventList read FEvents;
    property GlyphIndex: Integer read GetGlyphIndex;
    property Layout: TcxSchedulerReportLinkPeriodicPrintStyleLayout read FLayout write SetLayout stored IsLayoutStored;
    property PagesPerPeriod: Integer read FPagesPerPeriod;
    property PageSites[Index: Integer]: TcxSchedulerReportPageSite read GetPageSite;
    property PreviewGlyphIndex: Integer read GetPreviewGlyphIndex;
    property PrintRange: TcxSchedulerReportLinkPrintRange read GetPrintRange;
    property ResourceCount: Integer read GetResourceCount;
    property ResourceCountPerPage: Integer read FResourceCountPerPage write SetResourceCountPerPage default 0;
    property ShowNotesAreaBlank: Boolean read GetShowNotesAreaBlank write SetShowNotesAreaBlank stored IsShowNotesAreaBlankStored;
    property ShowNotesAreaLined: Boolean read FShowNotesAreaLined write SetShowNotesAreaLined default False;
    property ShowTaskPad: Boolean read FShowTaskPad write SetShowTaskPad default False;
    property StartOfWeekOffset: Integer read GetStartOfWeekOffset;
    property Storage: TcxCustomSchedulerStorage read GetStorage;
    property TimePrintFrom: TTime read GetTimePrintFrom write SetTimePrintFrom stored False;
    property TimePrintTo: TTime read GetTimePrintTo write SetTimePrintTo stored False;
    property UsedDays: TcxSchedulerDateList read FUsedDays;
  public
    constructor Create(AStyles: TcxSchedulerReportLinkPrintStyles); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    function DefaultCaption: string; virtual;
    function IsCompatibleWith(AView: TcxSchedulerCustomView): Boolean; virtual;
    procedure RestoreDefaults; virtual;

    property ActualDatePrintFrom: TDate read GetActualDatePrintFrom;
    property ActualDatePrintTo: TDate read GetActualDatePrintTo;
    property CorrespondedView: TcxSchedulerCustomResourceView read GetCorrespondedView;
    property HasAdditionalArea: Boolean read GetHasAdditionalArea;
    property Index: Integer read GetIndex;
    property PageCount: Integer read GetPageCount;
    property PeriodCount: Integer read GetPeriodCount;
    property ReportLink: TcxSchedulerReportLink read GetReportLink;
    property Scheduler: TcxScheduler read GetScheduler;
    property Styles: TcxSchedulerReportLinkPrintStyles read FStyles;
    property VisualStyles: TcxSchedulerReportLinkStyles read GetVisualStyles;
  published
    property Active: Boolean read GetActive write SetActive stored IsActiveStored;
    property Caption: string read FCaption write SetCaption stored IsCaptionStored;
  end;

  { TcxSchedulerReportLinkDailyPrintStyle }

  TcxSchedulerReportLinkDailyPrintStyle = class(TcxCustomSchedulerReportLinkPrintStyle)
  private
    FCurrentPagePerDate: Integer;
  protected
    procedure BeforeBuild; override;
    function CanSplitSchedulingOnTwoPages: Boolean; override;
    procedure CreateControlsOnFirstPage(APageIndex: Integer;
      ASite, AHeader: TdxReportCell; ABounds: TRect); override;
    procedure CreateControlsOnSecondPage(APageIndex: Integer;
      ASite, AHeader: TdxReportCell; ABounds: TRect); override;
    function CreateSchedulingCellsProducer(ASite: TcxSchedulerReportSchedulingAreaCell): TcxSchedulerReportCommonCellsProducer; override;
    procedure FillDatesForPage(ADateList: TcxSchedulerDateList;
      APageIndex, APeriodIndex, ASubIndex: Integer); override;
    function GetCorrespondedView: TcxSchedulerCustomResourceView; override;
    function GetGlyphIndex: Integer; override;
    function GetPageCount: Integer; override;
    function GetPagesPerPeriod: Integer; override;
    function GetShowNotesAreaBlank: Boolean; override;
    procedure InitHeaderCell(ACell: TcxSchedulerReportSchedulerHeaderCell); override;
    function SupportIcons: Boolean; override;
    function SupportMessage: Boolean; override;
    function SupportTimeRange: Boolean; override;
  public
    function DefaultCaption: string; override;
    function IsCompatibleWith(AView: TcxSchedulerCustomView): Boolean; override;
  published
    property Active;
    property Caption;
    property Layout;
    property ResourceCountPerPage;
    property ShowNotesAreaBlank;
    property ShowNotesAreaLined;
    property ShowTaskPad;
  end;

  { TcxSchedulerReportLinkCustomDetailsPrintStyle }

  TcxSchedulerReportLinkCustomDetailsPrintStyle = class(TcxCustomSchedulerReportLinkPrintStyle)
  private
    FTimeWidth: Integer;
    function GetPageWidth: Integer;
  protected
    BuildedPageCount: Integer;
    CellsOnPage: Integer;
    CurrentPage: TcxSchedulerReportPageSite;
    function AddPageSite(const ABounds: TRect): TcxSchedulerReportPageSite; override;
    procedure BeforeBuild; override;
    function GetNextPage(APrevPage: TcxSchedulerReportPageSite; out ABounds: TRect): TcxSchedulerReportPageSite;
    function GetPageCount: Integer; override;
    function MeasureTimeWidth: Integer; virtual;

    property PageWidth: Integer read GetPageWidth;
    property TimeWidth: Integer read FTimeWidth;
  end;

  { TcxSchedulerReportLinkDetailsPrintStyle }

  TcxSchedulerReportLinkDetailsPrintStylePaginationMode  = (dpmByDay, dpmByWeek, dpmByMonth);

  TcxSchedulerReportLinkDetailsPrintStyle = class(TcxSchedulerReportLinkCustomDetailsPrintStyle)
  private
    FPaginationMode: TcxSchedulerReportLinkDetailsPrintStylePaginationMode;
    FUsePagination: Boolean;
    procedure SetPaginationMode(Value: TcxSchedulerReportLinkDetailsPrintStylePaginationMode);
    procedure SetUsePagination(Value: Boolean);
  protected
    EventIndex, DayIndex: Integer;
    CurrentCell: TcxSchedulerReportDetailsEventCell;
    CurrentPageBounds: TRect;
    PreviousHeader: TcxSchedulerReportSchedulerHeaderCell;
    Site: TcxSchedulerReportPageSite;
    function AddDayHeader(ADate: TDateTime; AContinue: Boolean;
      var ABounds: TRect): TcxSchedulerReportSchedulerHeaderCell;
    procedure BeforeBuild; override;
    procedure BuildPages; override;
    function GetDayHeaderHeight: Integer; virtual;
    function GetDayHeaderText(AContinue: Boolean): string; virtual;
    function GetGlyphIndex: Integer; override;
    function GetPreviewGlyphIndex: Integer; override;
    function GetSchedulerHeaderParams: TdxReportItemViewParams; override;

    // layout calculation
    function AddEventCell(AEvent: TcxSchedulerEvent): TcxSchedulerReportDetailsEventCell; virtual;
    procedure CheckPagination;
    procedure HeaderNeeded; virtual;
    function NeedAddDayHeader: Boolean;
    function MeasureCellBounds: TRect; virtual;
    procedure PrepareNextPage;
    procedure SetCellPlace;

    property DayHeaderHeight: Integer read GetDayHeaderHeight;
  public
    procedure Assign(Source: TPersistent); override;
    function DefaultCaption: string; override;
    procedure RestoreDefaults; override;
  published
    property Active;
    property Caption;
    property PaginationMode: TcxSchedulerReportLinkDetailsPrintStylePaginationMode read FPaginationMode write SetPaginationMode default dpmByDay;
    property UsePagination: Boolean read FUsePagination write SetUsePagination default False;
  end;

  { TcxSchedulerReportLinkMemoPrintStyle }

  TcxSchedulerReportLinkMemoPrintStyle = class(TcxSchedulerReportLinkCustomDetailsPrintStyle)
  private
    FSelectedEventsOnly: Boolean;
    FStartEachItemOnNewPage: Boolean;
  protected
    Site: TdxReportCell;
    function AddEventCell(AEvent: TcxSchedulerEvent): TcxSchedulerReportDetailsEventCell; virtual;
    procedure BuildPages; override;
    procedure DoCanPrintEvent(AEvent: TcxSchedulerEvent; var AllowPrint: Boolean); override;
    function GetGlyphIndex: Integer; override;
    function GetPreviewGlyphIndex: Integer; override;
    function MeasureTimeWidth: Integer; override;
  public
    procedure Assign(Source: TPersistent); override;
    function DefaultCaption: string; override;
    procedure RestoreDefaults; override;
  published
    property Active;
    property Caption;
    property SelectedEventsOnly: Boolean read FSelectedEventsOnly write FSelectedEventsOnly default True;
    property StartEachItemOnNewPage: Boolean read FStartEachItemOnNewPage write FStartEachItemOnNewPage default True;
  end;

  { TcxSchedulerReportLinkMonthlyPrintStyle }

  TcxSchedulerReportLinkMonthlyPrintStyle = class(TcxCustomSchedulerReportLinkPrintStyle)
  private
    FPrintExactlyOneMonthPerPage: Boolean;
    procedure SetPrintExactlyOneMonthPerPage(Value: Boolean);
  protected
    procedure CreateControlsOnFirstPage(APageIndex: Integer;
      ASite, AHeader: TdxReportCell; ABounds: TRect); override;
    procedure CreateControlsOnSecondPage(APageIndex: Integer;
      ASite, AHeader: TdxReportCell; ABounds: TRect); override;
    procedure FillDatesForPage(ADateList: TcxSchedulerDateList;
      APageIndex, APeriodIndex, ASubIndex: Integer); override;
    function GetCorrespondedView: TcxSchedulerCustomResourceView; override;
    function GetDateForPage(APageIndex: Integer): TDateTime;
    function GetDaysPerPeriod: Integer; override;
    function GetGlyphIndex: Integer; override;
    function GetPageCount: Integer; override;
    procedure InitHeaderCell(ACell: TcxSchedulerReportSchedulerHeaderCell); override;
  public
    procedure Assign(Source: TPersistent); override;
    function DefaultCaption: string; override;
    function IsCompatibleWith(AView: TcxSchedulerCustomView): Boolean; override;
    procedure RestoreDefaults; override;
  published
    property Active;
    property Caption;
    property DontPrintWeekends;
    property Layout;
    property PrintExactlyOneMonthPerPage: Boolean read FPrintExactlyOneMonthPerPage write SetPrintExactlyOneMonthPerPage default False;
    property ResourceCountPerPage;
    property ShowNotesAreaBlank;
    property ShowNotesAreaLined;
    property ShowTaskPad;
  end;

  { TcxSchedulerReportLinkTrifoldPrintStyle }

  TcxSchedulerReportLinkTrifoldPrintStyleSectionMode = (smDailyCalendar, smWeeklyCalendar,
    smMonthlyCalendar, smTaskPad, smNotesAreaBlank, smNotesAreaLined);

  TcxSchedulerReportLinkTrifoldPrintStyle = class(TcxCustomSchedulerReportLinkPrintStyle)
  private
    FSections: array[0..2] of TcxSchedulerReportLinkTrifoldPrintStyleSectionMode;
    function GetSection(Index: Integer): TcxSchedulerReportLinkTrifoldPrintStyleSectionMode;
    procedure SetSection(Index: Integer; AValue: TcxSchedulerReportLinkTrifoldPrintStyleSectionMode);
    function IsSectionStored(Index: Integer): Boolean;
  protected
    FCurrentSection: TcxSchedulerReportLinkTrifoldPrintStyleSectionMode;
    FCurrentSchedulingArea: TcxSchedulerReportSchedulingAreaCell;
    FPageRange: Byte;
    procedure CreateLayoutForPeriod(APeriodIndex: Integer); override;
    procedure CreateLayoutForSection(ASite: TdxReportCell; APeriodIndex: Integer; const ABounds: TRect;
      ASection: TcxSchedulerReportLinkTrifoldPrintStyleSectionMode); virtual;
    procedure CreateSchedulingAreaWithHeader(ASite: TdxReportCell; ABounds: TRect); virtual;
    function CreateSchedulingCellsProducer(
      ASite: TcxSchedulerReportSchedulingAreaCell): TcxSchedulerReportCommonCellsProducer; override;
    procedure FillDatesForPage(ADateList: TcxSchedulerDateList;
      APageIndex, APeriodIndex, ASubIndex: Integer); override;
    function GetCorrespondedView: TcxSchedulerCustomResourceView; override;
    function GetGlyphIndex: Integer; override;
    function GetPageCount: Integer; override;
    procedure InitHeaderCell(ACell: TcxSchedulerReportSchedulerHeaderCell); override;
  public
    procedure Assign(Source: TPersistent); override;
    function DefaultCaption: string; override;
    procedure RestoreDefaults; override;
  published
    property Active;
    property Caption;
    property LeftSection: TcxSchedulerReportLinkTrifoldPrintStyleSectionMode index 0 read GetSection write SetSection stored IsSectionStored;
    property MiddleSection: TcxSchedulerReportLinkTrifoldPrintStyleSectionMode index 1 read GetSection write SetSection stored IsSectionStored;
    property RightSection: TcxSchedulerReportLinkTrifoldPrintStyleSectionMode index 2 read GetSection write SetSection stored IsSectionStored;
  end;

  { TcxSchedulerReportLinkWeeklyPrintStyle }

  TcxSchedulerReportLinkWeeklyPrintStyleArrange = (wsaTopToBottom, wsaLeftToRight);

  TcxSchedulerReportLinkWeeklyPrintStyle = class(TcxCustomSchedulerReportLinkPrintStyle)
  private
    FArrange: TcxSchedulerReportLinkWeeklyPrintStyleArrange;
    function IsArrangeStored: Boolean;
    procedure SetArrange(Value: TcxSchedulerReportLinkWeeklyPrintStyleArrange);
  protected
    procedure CreateControlsOnFirstPage(APageIndex: Integer;
      ASite, AHeader: TdxReportCell; ABounds: TRect); override;
    procedure CreateControlsOnSecondPage(APageIndex: Integer;
      ASite, AHeader: TdxReportCell; ABounds: TRect); override;
    function CreateSchedulingCellsProducer(
      ASite: TcxSchedulerReportSchedulingAreaCell): TcxSchedulerReportCommonCellsProducer; override;
    procedure FillDatesForPage(ADateList: TcxSchedulerDateList;
      APageIndex, APeriodIndex, ASubIndex: Integer); override;
    function GetCorrespondedView: TcxSchedulerCustomResourceView; override;
    function GetGlyphIndex: Integer; override;
    function GetDateForPage(APageIndex: Integer): TDateTime;
    function GetDaysPerPeriod: Integer; override;
    function GetPageCount: Integer; override;
    function GetStartOfWeekOffset: Integer; override;
    procedure InitHeaderCell(ACell: TcxSchedulerReportSchedulerHeaderCell); override;
    function CanDontPrintWeekends: Boolean; virtual;
    function SupportTimeRange: Boolean; override;
  public
    procedure Assign(Source: TPersistent); override;
    function DefaultCaption: string; override;
    function IsCompatibleWith(AView: TcxSchedulerCustomView): Boolean; override;
    procedure RestoreDefaults; override;
  published
    property Active;
    property Arrange: TcxSchedulerReportLinkWeeklyPrintStyleArrange read FArrange write SetArrange stored IsArrangeStored;
    property Caption;
    property DontPrintWeekends;
    property Layout;
    property ResourceCountPerPage;
    property ShowNotesAreaBlank;
    property ShowNotesAreaLined;
    property ShowTaskPad;
  end;

  { TcxSchedulerReportLinkPrintStyles }

  TcxSchedulerReportLinkPrintStyles = class(TcxCustomSchedulerReportLinkOptions)
  private
    FActiveStyle: TcxCustomSchedulerReportLinkPrintStyle;
    FActiveStyleAssigned: Boolean;
    FItems: TList;
    function GetCount: Integer;
    function GetItem(Index: Integer): TcxCustomSchedulerReportLinkPrintStyle;
    function GetStyleDaily: TcxSchedulerReportLinkDailyPrintStyle;
    function GetStyleDetails: TcxSchedulerReportLinkDetailsPrintStyle;
    function GetStyleMemo: TcxSchedulerReportLinkMemoPrintStyle;
    function GetStyleMonthly: TcxSchedulerReportLinkMonthlyPrintStyle;
    function GetStyleTrifold: TcxSchedulerReportLinkTrifoldPrintStyle;
    function GetStyleWeekly: TcxSchedulerReportLinkWeeklyPrintStyle;
    procedure SetActiveStyle(Value: TcxCustomSchedulerReportLinkPrintStyle);
    procedure SetActiveStyleAssigned(Value: Boolean);
    procedure SetItem(Index: Integer; Value: TcxCustomSchedulerReportLinkPrintStyle);
    procedure SetStyleDaily(Value: TcxSchedulerReportLinkDailyPrintStyle);
    procedure SetStyleDetails(Value: TcxSchedulerReportLinkDetailsPrintStyle);
    procedure SetStyleMemo(Value: TcxSchedulerReportLinkMemoPrintStyle);
    procedure SetStyleMonthly(Value: TcxSchedulerReportLinkMonthlyPrintStyle);
    procedure SetStyleTrifold(Value: TcxSchedulerReportLinkTrifoldPrintStyle);
    procedure SetStyleWeekly(Value: TcxSchedulerReportLinkWeeklyPrintStyle);
  protected
    procedure CreateObjects; override;
    procedure DestroyObjects; override;

    { IdxReportLinkOptionsDesignerSupport }

    function DesignerTabIndex: Integer; override;

    function CreateStyle(AStyleClass: TcxCustomSchedulerReportLinkPrintStyleClass): TcxCustomSchedulerReportLinkPrintStyle; virtual;
    procedure CreateStyles; virtual;
    procedure DestroyStyles; virtual;
    procedure GetStyleByClassEx(AClass: TcxCustomSchedulerReportLinkPrintStyleClass; var AInstance);
    procedure SetActiveStyleEx(Value: TcxCustomSchedulerReportLinkPrintStyle);

    procedure ActiveStyleChanged; virtual;
    procedure StyleChanged(AStyle: TcxCustomSchedulerReportLinkPrintStyle); virtual;
  public
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;

    function GetCorrespondingStyle: TcxCustomSchedulerReportLinkPrintStyle; virtual;
    function GetStyleByClass(AClass: TcxCustomSchedulerReportLinkPrintStyleClass): TcxCustomSchedulerReportLinkPrintStyle;
    function GetStyleByName(const Name: string): TcxCustomSchedulerReportLinkPrintStyle;
    function GetStyleByView(View: TcxSchedulerCustomView): TcxCustomSchedulerReportLinkPrintStyle;

    function IndexOf(AItem: TcxCustomSchedulerReportLinkPrintStyle): Integer;

    property ActiveStyle: TcxCustomSchedulerReportLinkPrintStyle read FActiveStyle write SetActiveStyle stored False;
    property ActiveStyleAssigned: Boolean read FActiveStyleAssigned write SetActiveStyleAssigned;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TcxCustomSchedulerReportLinkPrintStyle read GetItem write SetItem; default;
  published
    property Daily: TcxSchedulerReportLinkDailyPrintStyle read GetStyleDaily write SetStyleDaily;
    property Details: TcxSchedulerReportLinkDetailsPrintStyle read GetStyleDetails write SetStyleDetails;
    property Memo: TcxSchedulerReportLinkMemoPrintStyle read GetStyleMemo write SetStyleMemo;
    property Monthly: TcxSchedulerReportLinkMonthlyPrintStyle read GetStyleMonthly write SetStyleMonthly;
    property Trifold: TcxSchedulerReportLinkTrifoldPrintStyle read GetStyleTrifold write SetStyleTrifold;
    property Weekly: TcxSchedulerReportLinkWeeklyPrintStyle read GetStyleWeekly write SetStyleWeekly;
  end;

  { DesignWindow }

  TcxfmSchedulerReportLinkDesignWindow = class(TdxfmCustomcxControlReportLinkDesignWindow)
    PageControl1: TPageControl;
    tshPrintStyles: TTabSheet;
    tshStyles: TTabSheet;
    bvlStyles: TBevel;
    bvlStyleSheets: TBevel;
    lblStyleSheets: TLabel;
    bvlStylesHost: TBevel;
    Label1: TLabel;
    lblUseNativeStyles: TLabel;
    btnStyleColor: TButton;
    btnStyleFont: TButton;
    btnStyleBackgroundBitmap: TButton;
    cbxStyleSheets: TcxComboBox;
    btnStyleSheetNew: TButton;
    btnStyleSheetCopy: TButton;
    btnStyleSheetDelete: TButton;
    btnStylesSaveAs: TButton;
    btnStyleSheetRename: TButton;
    btnStyleBackgroundBitmapClear: TButton;
    btnStyleRestoreDefaults: TButton;
    chbxUseNativeStyles: TcxCheckBox;
    pmStyles: TPopupMenu;
    miStyleFont: TMenuItem;
    miStyleColor: TMenuItem;
    miLine3: TMenuItem;
    miStyleBackgroundBitmap: TMenuItem;
    miStyleBackgroundBitmapClear: TMenuItem;
    miLine2: TMenuItem;
    miStyleRestoreDefaults: TMenuItem;
    milLine: TMenuItem;
    miStylesSelectAll: TMenuItem;
    miLine4: TMenuItem;
    miStylesSaveAs: TMenuItem;
    ilStylesPopup: TImageList;
    lblPreviewWindow: TStaticText;
    pnlPreview: TPanel;
    cbxPrintStyles: TcxImageComboBox;
    lblPrintStylesOptions: TLabel;
    bvlPrintStyleOptions: TBevel;
    pcPrintStyleOptions: TPageControl;
    tshWeekly: TTabSheet;
    tshMonthly: TTabSheet;
    tshTrifold: TTabSheet;
    tshDetails: TTabSheet;
    tshMemo: TTabSheet;
    lblPrintStyleTrifoldSectionLeft: TLabel;
    lblPrintStyleTrifoldSectionMiddle: TLabel;
    lblPrintStyleTrifoldSectionRight: TLabel;
    lblPrintStyleWeeklyPrintTo: TLabel;
    lblPrintStyleWeeklyPrintFrom: TLabel;
    chbxPrintStyleWeeklyNotesAreaLined: TcxCheckBox;
    chbxPrintStyleWeeklyNotesAreaBlank: TcxCheckBox;
    lblPrintStyleWeeklyInclude: TLabel;
    lblPrintStyleWeeklyLayout: TLabel;
    lblPrintStyleWeeklyArrange: TLabel;
    cbxPrintStyleWeeklyArrange: TcxComboBox;
    cbxPrintStyleWeeklyLayout: TcxComboBox;
    chbxPrintStyleWeeklyTaskPad: TcxCheckBox;
    tePrintStyleWeeklyPrintFrom: TcxTimeEdit;
    tePrintStyleWeeklyPrintTo: TcxTimeEdit;
    cbxPrintStyleMonthlyLayout: TcxComboBox;
    lblPrintStyleMonthlyLayout: TLabel;
    lblPrintStyleMonthlyInclude: TLabel;
    chbxPrintStyleMonthlyTaskPad: TcxCheckBox;
    chbxPrintStyleMonthlyNotesAreaBlank: TcxCheckBox;
    chbxPrintStyleMonthlyNotesAreaLined: TcxCheckBox;
    chbxPrintStyleMonthlyDontPrintWeekends: TcxCheckBox;
    chbxPrintStyleMonthlyPrintExactlyOneMonthPerPage: TcxCheckBox;
    chbxPrintStyleWeeklyDontPrintWeekends: TcxCheckBox;
    pnlPrintStylesPreview: TPanel;
    pbxPrintStylesPreview: TPaintBox;
    chbxPrintStyleDetailsUsePagination: TcxCheckBox;
    cbxPrintStyleDetailsPagination: TcxComboBox;
    tshFormatting: TTabSheet;
    bvlLookAndFeel: TBevel;
    lblLookAndFeel: TLabel;
    imgLookAndFeel: TImage;
    cbxLookAndFeel: TcxComboBox;
    lblRefinements: TLabel;
    bvlRefinements: TBevel;
    imgRefinements: TImage;
    chbxSuppressBackgroundBitmaps: TcxCheckBox;
    tshPrintRange: TTabSheet;
    lblPrintRangeStart: TLabel;
    lblPrintRangeEnd: TLabel;
    lblPrintRangesMiscellaneous: TLabel;
    Bevel1: TBevel;
    dePrintRangeStart: TcxDateEdit;
    dePrintRangeEnd: TcxDateEdit;
    chbxHideDetailsOfPrivateAppointments: TcxCheckBox;
    cbxPrintStyleTrifoldSectionLeft: TcxComboBox;
    cbxPrintStyleTrifoldSectionMiddle: TcxComboBox;
    cbxPrintStyleTrifoldSectionRight: TcxComboBox;
    chbxSuppressContentColoration: TcxCheckBox;
    sePrintStyleMonthlyResourceCountPerPage: TcxSpinEdit;
    lblPrintStyleMonthlyResourceCountPerPage: TLabel;
    lblPrintStyleWeeklyResourceCountPerPage: TLabel;
    sePrintStyleWeeklyResourceCountPerPage: TcxSpinEdit;
    tshDaily: TTabSheet;
    lblPrintStyleDailyLayout: TLabel;
    lblPrintStyleDailyInclude: TLabel;
    lblPrintStyleDailyPrintFrom: TLabel;
    lblPrintStyleDailyPrintTo: TLabel;
    lblPrintStyleDailyResourceCountPerPage: TLabel;
    cbxPrintStyleDailyLayout: TcxComboBox;
    chbxPrintStyleDailyTaskPad: TcxCheckBox;
    chbxPrintStyleDailyNotesAreaBlank: TcxCheckBox;
    chbxPrintStyleDailyNotesAreaLined: TcxCheckBox;
    tePrintStyleDailyPrintFrom: TcxTimeEdit;
    tePrintStyleDailyPrintTo: TcxTimeEdit;
    sePrintStyleDailyResourceCountPerPage: TcxSpinEdit;
    cxEditStyleController1: TcxEditStyleController;
    pbPreview: TPaintBox;
    chbxPrintStyleMemoStartEachItemOnNewPage: TcxCheckBox;
    chbxPrintStyleMemoPrintOnlySelectedEvents: TcxCheckBox;
    procedure PageControl1Change(Sender: TObject);
    procedure lbxStylesClick(Sender: TObject);
    procedure btnStyleFontClick(Sender: TObject);
    procedure btnStyleColorClick(Sender: TObject);
    procedure btnStyleBackgroundBitmapClick(Sender: TObject);
    procedure btnStyleBackgroundBitmapClearClick(Sender: TObject);
    procedure btnStyleRestoreDefaultsClick(Sender: TObject);
    procedure btnStylesSaveAsClick(Sender: TObject);
    procedure cbxStyleSheetsClick(Sender: TObject);
    procedure miStylesSelectAllClick(Sender: TObject);
    procedure cbxStyleSheetsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnStyleSheetNewClick(Sender: TObject);
    procedure btnStyleSheetCopyClick(Sender: TObject);
    procedure btnStyleSheetDeleteClick(Sender: TObject);
    procedure btnStyleSheetRenameClick(Sender: TObject);
    procedure lblUseNativeStylesClick(Sender: TObject);
    procedure OptionsFormattingClick(Sender: TObject);
    procedure pmStylesPopup(Sender: TObject);
    procedure cbxPrintStylesClick(Sender: TObject);
    procedure pbxPrintStylesPreviewPaint(Sender: TObject);
    procedure cbxPrintStyleDailyLayoutClick(Sender: TObject);
    procedure chbxPrintStyleOptionsViewClick(Sender: TObject);
    procedure cbxPrintStyleWeeklyArrangeClick(Sender: TObject);
    procedure chbxPrintStyleWeeklyDontPrintWeekendsClick(Sender: TObject);
    procedure chbxPrintStyleMonthlyDontPrintWeekendsClick(Sender: TObject);
    procedure chbxPrintStyleMonthlyPrintExactlyOneMonthPerPageClick(
      Sender: TObject);
    procedure cbxPrintStyleTrifoldSectionModeClick(Sender: TObject);
    procedure chbxPrintStyleDetailsUsePaginationClick(Sender: TObject);
    procedure cbxPrintStyleDetailsPaginationClick(Sender: TObject);
    procedure cbxPrintStyleWeeklyLayoutClick(Sender: TObject);
    procedure cbxPrintStyleMonthlyLayoutClick(Sender: TObject);
    procedure dePrintRangeStartEditValueChanged(Sender: TObject);
    procedure dePrintRangeEndEditValueChanged(Sender: TObject);
    procedure cbxStyleSheetsPropertiesDrawItem(AControl: TcxCustomComboBox;
      ACanvas: TcxCanvas; AIndex: Integer; const ARect: TRect;
      AState: TOwnerDrawState);
    procedure tePrintStylePrintRangePropertiesEditValueChanged(
      Sender: TObject);
    procedure LookAndFeelChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure sePrintStyleResourceCountPerPagePropertiesEditValueChanged(
      Sender: TObject);
    procedure tePrintStylePrintRangePropertiesChange(Sender: TObject);
    procedure sePrintStyleResourceCountPerPagePropertiesChanged(
      Sender: TObject);
    procedure StyleController1StyleChanged(Sender: TObject);
    procedure pbPreviewPaint(Sender: TObject);
    procedure cbxLookAndFeelPropertiesChange(Sender: TObject);
    procedure chbxPrintStyleMemoStartEachItemOnNewPageClick(
      Sender: TObject);
    procedure chbxPrintStyleMemoPrintOnlySelectedEventsClick(
      Sender: TObject);
  private
    FActiveStyle: TcxCustomSchedulerReportLinkPrintStyle;
    FActiveStyleAssigned: Boolean;
    FIsFormClosing: Boolean;
    lbxStyles: TdxStylesListBox;
    wpPrintStyles: TList;

    function GetActivePrintStyle: TcxCustomSchedulerReportLinkPrintStyle;
    function GetActiveStyle: TcxStyle;
    function GetComponent: TcxScheduler;
    function GetHasSelectedStyles: Boolean;
    function GetHasSelectedStylesWithAssignedBitmap: Boolean;
    function GetReportLink: TcxSchedulerReportLink;

    function CanSelectAllStyles: Boolean;
    procedure CreateControls;

    procedure RecreateStylesListBox;
    procedure RestoreSelectedStyles(AList: TList);
    procedure SaveSelectedStyles(AList: TList);
    procedure SetActivePage;

    procedure SetOptionsFormattingByIndex(AnIndex: Integer; AValue: Boolean);
    procedure SetPrintStyleOptionsViewByIndex(AnIndex: Integer; AValue: Boolean);
    procedure SetPrintStyleRangeByIndex(AnIndex: Integer; const ATime: TDateTime);
    procedure SetPrintStyleResourceCountPerPageByIndex(AnIndex: Integer; AValue: TcxEditValue);

  protected
    procedure AssignDailyTabObjects; virtual;
    procedure AssignDetailsTabObjects; virtual;
    procedure AssignMemoTabObjects; virtual;
    procedure AssignMonthlyTabObjects; virtual;
    procedure AssignTrifoldTabObjects; virtual;
    procedure AssignWeeklyTabObjects; virtual;

    function CanApply: Boolean; override;
    procedure DoApply; override;
    procedure DoInitialize; override;
   {$IFDEF DELPHI7}
    function GetPreviewHost: TCustomPanel; override;
   {$ENDIF}

    function CheckPrintRange: Boolean; virtual;
    function CheckPrintStyleSettings: Boolean; virtual;
    function IsValidConditions: Boolean; virtual;
    procedure LoadCaption(AControl: TControl; StrPtr: Pointer); overload;
    procedure LoadCaption(AItem: TMenuItem; StrPtr: Pointer); overload;
    procedure LoadStrings; override;
    procedure LoadStringsCombo(ACombo: TcxComboBox; ACaptions: array of Pointer);
    procedure LoadStringsDaily; virtual;
    procedure LoadStringsDetails; virtual;
    procedure LoadStringsMemo; virtual;
    procedure LoadStringsMonthly; virtual;
    procedure LoadStringsOther; virtual;
    procedure LoadStringsTrifold; virtual;
    procedure LoadStringsWeekly; virtual;

    procedure PreviewDrawPageContent(ACanvas: TCanvas; ABounds: TRect); virtual;

    procedure UpdateControlsState; override;
    procedure UpdateEnabled(AControl: TControl; AEnabled: Boolean); overload;
    procedure UpdateEnabled(AItem: TMenuItem; AEnabled: Boolean); overload;
    procedure UpdateEnabledControls(AControls: array of TControl; AEnabled: Boolean);
    procedure UpdatePreview; override;

    function GetDesignerTabIndex: Integer; override;
    procedure SetDesignerTabIndex(Value: Integer); override;

    procedure DoActiveStyleSheetChanged; override;
    procedure DoFormActivated(AnActive: Boolean); override;
    procedure DoRefreshStylesList; override;
    procedure DoStyleChanged(const ACaption: string; AStyle: TcxStyle); override;
    procedure DoStylesChanged(AStrings: TStrings; ARecreate: Boolean); override;

    procedure GetSelectedStyleNames(AStrings: TStrings); override;
    procedure GetStyleNames(out AStrings: TStrings); override;
    procedure GetStyleSheetNames(out AStrings: TStrings); override;

    procedure ActivatePrintStyleTab; virtual;
    procedure AssignTabSheetObjects; virtual;
    function FindTabIndexByPrintStyle(APrintStyle: TcxCustomSchedulerReportLinkPrintStyle): Integer; virtual;
    procedure RefreshPrintStyles; virtual;

    property ActivePrintStyle: TcxCustomSchedulerReportLinkPrintStyle read GetActivePrintStyle;
    property ActiveStyle: TcxStyle read GetActiveStyle;
    property HasSelectedStyles: Boolean read GetHasSelectedStyles;
    property HasSelectedStylesWithAssignedBitmap: Boolean read GetHasSelectedStylesWithAssignedBitmap;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean; override;

    property Component: TcxScheduler read GetComponent;
    property ReportLink: TcxSchedulerReportLink read GetReportLink;
  end;

  // cells

  { TcxSchedulerReportPageSite }

  TcxSchedulerReportPageSite = class(TdxReportCell)
  protected
    FPageIndex: Integer;
    FPrimaryPage: Boolean;

    procedure ReadProperties(AReader: TdxPSDataReader); override;
    procedure WriteProperties(AWriter: TdxPSDataWriter); override;
  public
    property PageIndex: Integer read FPageIndex;
    property PrimaryPage: Boolean read FPrimaryPage;
  end;

  { TcxSchedulerReportPageItemCell }

  TcxSchedulerReportPageItemCell = class(TdxReportCell)
  private
    function GetPageIndex: Integer;
    function GetPageSite: TcxSchedulerReportPageSite;
    function GetPrimaryPage: Boolean;
    function GetReportLink: TcxSchedulerReportLink;
  protected
    function GetType: TcxSchedulerReportItemsType; virtual;

    procedure SetCellViewParams(AItem: TdxReportVisualItem; const AParams: TcxViewParams); overload;
    procedure SetCellViewParams(AItem: TdxReportVisualItem; const AParams: TdxReportItemViewParams); overload;

    property ReportLink: TcxSchedulerReportLink read GetReportLink;
  public
    constructor Create(AParent: TdxReportCell); override;
    property PageSite: TcxSchedulerReportPageSite read GetPageSite;
    property PrimaryPage: Boolean read GetPrimaryPage;
    property PageIndex: Integer read GetPageIndex;
  end;

  { TcxSchedulerReportNotesDataCell }

  TcxSchedulerReportNotesDataCell = class(TAbstractdxReportCellData)
  private
    FCaption: string;
    FCaptionHeight: Integer;
    FLined: Boolean;
    function GetMultiLine: Boolean;
    function GetTextAlignX: TcxTextAlignX;
    function GetTextAlignY: TcxTextAlignY;
    procedure SetMultiLine(Value: Boolean);
    procedure SetTextAlignX(Value: TcxTextAlignX);
    procedure SetTextAlignY(Value: TcxTextAlignY);
  protected
    procedure ReadData(AReader: TdxPSDataReader); override;
    procedure WriteData(AWriter: TdxPSDataWriter); override;
  public
    constructor Create(AParent: TdxReportCell); override;
    procedure DrawContent(DC: HDC; AStage: TdxPSRenderStages); override;

    property Caption: string read FCaption write FCaption;
    property CaptionHeight: Integer read FCaptionHeight write FCaptionHeight;
    property Lined: Boolean read FLined write FLined;
    property MultiLine: Boolean read GetMultiLine write SetMultiLine;
    property TextAlignX: TcxTextAlignX read GetTextAlignX write SetTextAlignX;
    property TextAlignY: TcxTextAlignY read GetTextAlignY write SetTextAlignY;
  end;

  TcxSchedulerReportNotesDataCellClass = class of TcxSchedulerReportNotesDataCell;

  { TcxSchedulerReportNotesAreaCell }

  TcxSchedulerReportNotesAreaCell = class(TcxSchedulerReportPageItemCell)
  private
    FLined: Boolean;
    function GetDataCell: TcxSchedulerReportNotesDataCell;
  protected
    procedure BoundsChanged; override;
    procedure ConvertCoords(APixelsNumerator, APixelsDenominator: Integer); override;
    function GetType: TcxSchedulerReportItemsType; override;
    function GetDataCellClass: TcxSchedulerReportNotesDataCellClass; virtual;
    procedure SetFontIndex(Value: Integer); override;
  public
    constructor Create(AParent: TdxReportCell); override;
    constructor CreateEx(AParent: TdxReportCell; ALined: Boolean);  virtual;
    property DataCell: TcxSchedulerReportNotesDataCell read GetDataCell;
    property Lined: Boolean read FLined;
  end;

  { TcxSchedulerReportTaskPadCell }

  TcxSchedulerReportTaskPadCell = class(TcxSchedulerReportNotesAreaCell)
  private
    function GetTaskPadDataSite: TdxReportCell;
  protected
    procedure BoundsChanged; override;
    function CalculateTaskPadDataSiteBounds: TRect; virtual;
    function GetType: TcxSchedulerReportItemsType; override;
  public
    constructor CreateEx(AParent: TdxReportCell; ALined: Boolean);  override;

    property TaskPadDataSite: TdxReportCell read GetTaskPadDataSite;
  end;

  { TcxSchedulerReportSchedulerHeaderDataCell }

  TcxSchedulerReportSchedulerHeaderDataCell = class(TAbstractdxReportCellData)
  public
    constructor Create(AParent: TdxReportCell); override;
  end;

  { TcxSchedulerReportSchedulerHeaderCell }

  TcxSchedulerReportSchedulerHeaderCell = class(TcxSchedulerReportPageItemCell)
  private
    FContent: TcxSchedulerReportSchedulerHeaderDataCell;
    FDate: TDateTime;
    FPrimaryText: string; //todo: remove
    FSecondaryText: string; //todo: remove
    FPrimaryTextCell: TdxReportCellString;
    FSecondaryTextCell: TdxReportCellString;
  protected
    function AddContentCell: TcxSchedulerReportSchedulerHeaderDataCell; virtual;
    function AddTextCell(AText: string; const ABounds: TRect; AMultiLine: Boolean): TdxReportCellString;
    function GetType: TcxSchedulerReportItemsType; override;

    property Date: TDateTime read FDate write FDate;
    property PrimaryText: string read FPrimaryText write FPrimaryText; //todo: remove
    property SecondaryText: string read FSecondaryText write FSecondaryText; //todo: remove
  public
    constructor Create(AParent: TdxReportCell); override;
    procedure AdjustTextSize;

    property Content: TcxSchedulerReportSchedulerHeaderDataCell read FContent;
    property PrimaryTextCell: TdxReportCellString read FPrimaryTextCell;
    property SecondaryTextCell: TdxReportCellString read FSecondaryTextCell;
  end;

  { TcxSchedulerReportDateNavigatorItem }

  TcxSchedulerReportDateNavigatorItem = class(TdxReportCellPreviewText)
  private
    function GetDateNavigator: TcxSchedulerReportDateNavigatorCell;
  protected
    function GetDefaultDTFormat: DWORD; override;
    procedure SetText(const Value: string); override;
  public
    constructor Create(AParent: TdxReportCell); override;

    property DateNavigator: TcxSchedulerReportDateNavigatorCell read GetDateNavigator;
  end;

  { TcxSchedulerReportDateNavigatorHeader }

  TcxSchedulerReportDateNavigatorHeader = class(TcxSchedulerReportDateNavigatorItem)
  private
    FMonth: Word;
    FYear: Word;
  protected
    function GetText: string; override;
    procedure ReadData(AReader: TdxPSDataReader); override;
    procedure WriteData(AWriter: TdxPSDataWriter); override;
  public
    constructor CreateEx(AParent: TdxReportCell; AYear, AMonth: Word);
    procedure Assign(Source: TPersistent); override;

    property Month: Word read FMonth;
    property Year: Word read FYear;
  end;

  { TcxSchedulerReportDateNavigatorDay }

  TcxSchedulerReportDateNavigatorDay = class(TcxSchedulerReportDateNavigatorItem)
  private
    FDay: Integer;
    FCol: Integer;
    FRow: Integer;
    function GetBold: Boolean;
    function GetDate: TDate;
    function GetMonth: Word;
    function GetYear: Word;
    procedure SetBold(Value: Boolean);
  protected
    function GetText: string; override;
    procedure ReadData(AReader: TdxPSDataReader); override;
    procedure WriteData(AWriter: TdxPSDataWriter); override;
  public
    constructor CreateEx(AParent: TdxReportCell;
      ADay, ACol, ARow: Integer; ABold: Boolean); virtual;
    procedure Assign(Source: TPersistent); override;

    property Col: Integer read FCol;
    property Date: TDate read GetDate;
    property Day: Integer read FDay write FDay;
    property Bold: Boolean read GetBold write SetBold;
    property Month: Word read GetMonth;
    property Row: Integer read FRow;
    property Year: Word read GetYear;
  end;

  { TcxSchedulerReportDateNavigatorDayCaption }

  TcxSchedulerReportDateNavigatorDayCaption = class(TcxSchedulerReportDateNavigatorItem)
  private
    FCol: Integer;
    FDayOfWeek: TDay;
    FDayText: string;
  protected
    function GetText: string; override;
    function GetDayText: string; virtual;
    procedure ReadData(AReader: TdxPSDataReader); override;
    procedure WriteData(AWriter: TdxPSDataWriter); override;
  public
    constructor CreateEx(AParent: TdxReportCell; ADayOfWeek: TDay; ACol: Integer); virtual;
    procedure Assign(Source: TPersistent); override;

    property Col: Integer read FCol;
    property DayOfWeek: TDay read FDayOfWeek;
  end;

  { TcxSchedulerReportDateNavigatorWeekNumber }

  TcxSchedulerReportDateNavigatorWeekNumber = class(TcxSchedulerReportDateNavigatorItem)
  private
    FWeekNumber: Integer;
    FRow: Integer;
  protected
    function GetText: string; override;
    procedure ReadData(AReader: TdxPSDataReader); override;
    procedure WriteData(AWriter: TdxPSDataWriter); override;
  public
    constructor CreateEx(AParent: TdxReportCell; AWeekNumber, ARow: Integer); virtual;
    procedure Assign(Source: TPersistent); override;

    property Row: Integer read FRow;
    property WeekNumber: Integer read FWeekNumber write FWeekNumber;
  end;

  { TcxSchedulerReportDateNavigatorCell }

  TcxSchedulerReportDateNavigatorCell = class(TcxSchedulerReportPageItemCell)
  private
    FBoldedDays: TcxSchedulerDateList;
    FFirstWeekOfYear: TcxFirstWeekOfYear;
    FMonth: Word;
    FShowDatesContainingEventsInBold: Boolean;
    FShowWeekNumbers: Boolean;
    FStartOfWeek: TDay;
    FYear: Word;

    FColWidth: Integer;
    FDayCaptionsHeight: Integer;
    FHeaderHeight: Integer;
    FMonthSize: TSize;
    FRowHeight: Integer;
    FVertOffset: Integer;
    FContentParams: TdxReportItemViewParams;
    FHeaderParams: TdxReportItemViewParams;

    FDayCaptionCount: Integer;
    FDayCount: Integer;
    FWeekNumberCount: Integer;

    class function GetMonthHeight(AHeaderHeight, ADayCaptionsHeight, ARowHeight: Integer): Integer;
    function GetDay(Index: Integer): TcxSchedulerReportDateNavigatorDay;
    function GetDayCaption(Index: Integer): TcxSchedulerReportDateNavigatorDayCaption;
    function GetHeader: TcxSchedulerReportDateNavigatorHeader;
    function GetWeekNumber(Index: Integer): TcxSchedulerReportDateNavigatorWeekNumber;
  protected
    procedure AdjustItemsVertical;
    function ColOfDate(ADate: TDateTime): Integer;
    procedure CreateDayCaptions; virtual;
    procedure CreateDay(const ABounds: TRect; ADate: TDateTime; ACol, ARow: Integer); virtual;
    procedure CreateItems;
    procedure CreateLines; virtual;
    procedure CreateMonth; virtual;
    procedure CreateMonthHeader; virtual;
    procedure CreateWeekNumber(const ABounds: TRect; ADate: TDateTime; ARow: Integer); virtual;
    class procedure GetContentPartSizes(AFont: TFont; var AColWidth, ARowHeight,
      ADayCaptionsHeight: Integer; AFontSize: Integer = 0); virtual;
    function GetDayBoundsFromColAndRow(ACol, ARow: Integer): TRect; virtual;
    function GetDayIsBold(ADate: TDateTime): Boolean; virtual;
    function GetHeaderBounds: TRect; virtual;
    class procedure GetHeaderPartSizes(AFont: TFont; var AHeaderHeight: Integer;
      AFontSize: Integer = 0); virtual;
    function GetMonthSize(const AContentParams, AHeaderParams: TdxReportItemViewParams): TSize;
    function GetType: TcxSchedulerReportItemsType; override;
    procedure SetViewParams(const AContentParams, AHeaderParams: TdxReportItemViewParams); virtual;

    procedure ReadData(AReader: TdxPSDataReader); override;
    procedure WriteData(AWriter: TdxPSDataWriter); override;

    property ColWidth: Integer read FColWidth;
    property DayCaptionsHeight: Integer read FDayCaptionsHeight;
    property HeaderHeight: Integer read FHeaderHeight;
    property MonthSize: TSize read FMonthSize;
    property RowHeight: Integer read FRowHeight;
    property ContentParams: TdxReportItemViewParams read FContentParams;
    property HeaderParams: TdxReportItemViewParams read FHeaderParams;
  public
    constructor Create(AParent: TdxReportCell); override;
    constructor CreateEx(AParent: TdxReportCell; AFirstWeekOfYear: TcxFirstWeekOfYear;
      AYear, AMonth: Word; AShowDatesContainingEventsInBold, AShowWeekNumbers: Boolean); virtual;

    procedure AdjustSize(var AContentParams, AHeaderParams: TdxReportItemViewParams; AHeight, AMaxHeight: Integer); virtual;
    function CalculateSize(const AContentParams, AHeaderParams: TdxReportItemViewParams): TSize;
    class function MeasureDateNavigatorHeight(const AContentParams, AHeaderParams: TcxViewParams): Integer; virtual;

    property FirstWeekOfYear: TcxFirstWeekOfYear read FFirstWeekOfYear write FFirstWeekOfYear;
    property Month: Word read FMonth write FMonth;
    property ShowDatesContainingEventsInBold: Boolean read FShowDatesContainingEventsInBold write FShowDatesContainingEventsInBold;
    property ShowWeekNumbers: Boolean read FShowWeekNumbers write FShowWeekNumbers;
    property StartOfWeek: TDay read FStartOfWeek;
    property Year: Word read FYear write FYear;

    // Helpers
    property DayCaptionCount: Integer read FDayCaptionCount;
    property DayCaptions[Index: Integer]: TcxSchedulerReportDateNavigatorDayCaption read GetDayCaption;
    property DayCount: Integer read FDayCount;
    property Days[Index: Integer]: TcxSchedulerReportDateNavigatorDay read GetDay;
    property Header: TcxSchedulerReportDateNavigatorHeader read GetHeader;
    property WeekNumberCount: Integer read FWeekNumberCount;
    property WeekNumbers[Index: Integer]: TcxSchedulerReportDateNavigatorWeekNumber read GetWeekNumber;
  end;

  { TcxSchedulerReportSchedulingAreaCell }

  TcxSchedulerReportSchedulingAreaCell = class(TcxSchedulerReportPageItemCell)
  private
    FVisibleDays: TcxSchedulerDateList;
    FDaysList: TStringList;
  protected
    function GetType: TcxSchedulerReportItemsType; override;
    property VisibleDays: TcxSchedulerDateList read FVisibleDays;
  public
    constructor Create(AParent: TdxReportCell); override;
    destructor Destroy; override;
    procedure DrawContent(DC: HDC; DrawRect: TRect; const OriginRect: TRect; AStage: TdxPSRenderStages); override;
    procedure DrawItself(DC: HDC; AStage: TdxPSRenderStages); override;
  end;

  TcxSchedulerReportCustomCell = class(TAbstractdxReportCellData)
  private
    function GetReportLink: TcxSchedulerReportLink;
  protected
    FDateTime: TDateTime;
    FDayBorderColor: TColor;
    procedure DrawCellFrame(DC: HDC; const ARect: TRect; ABorders: TcxBorders = [];
      ABorderColor: TColor = clDefault; ALineWidth: Integer = 1);
    procedure DrawCellRect(DC: HDC; const ARect: TRect; ABorders: TcxBorders = [];
      ABorderColor: TColor = clDefault; ALineWidth: Integer = 1; AColor: TColor = clDefault);
    procedure DrawCellText(DC: HDC; const ARect: TRect; const AText: string;
      AlignHorz: TcxTextAlignX; AlignVert: TcxTextAlignY; AFont: TFont = nil; AColor: TColor = clDefault);
    procedure DrawCellTextVert(DC: HDC; const ARect: TRect; const AText: string);
    procedure DrawCellState(DC: HDC; R: TRect;
      AState: Integer; ABorders: TcxBorders = []; ABorderColor: TColor = clBlack);

    function ExcludeBorders(const ARect: TRect; ABorders: TcxBorders; ABorderWidth: Integer = 1): TRect;
    function FixupWidth(AWidth: Integer): Integer;
    function GetFixupRect(DC: HDC; const ARect: TRect): TRect;
    function InflateRect(const ARect: TRect; dX, dY: Integer): TRect;
    function TextRect(const ARect: TRect): TRect;

    property ReportLink: TcxSchedulerReportLink read GetReportLink;
  public
    constructor CreateFrom(AParent: TdxReportCell; AViewInfo: TcxSchedulerCustomViewInfoItem); virtual;
    procedure DrawContent(DC: HDC; AStage: TdxPSRenderStages); override;
    class procedure RegisterMirrorClass; virtual;
    class function SchedulerCellClass: TcxSchedulerCustomViewInfoItemClass; virtual;
    procedure SuppressColoration; virtual;
  end;

  { TcxSchedulerReportContentCell }

  TcxSchedulerReportContentCell = class(TcxSchedulerReportCustomCell)
  protected
    FBorderColor: TColor;
    FShowTimeLine: Boolean;
    FState: Integer;
    FTimeLineBorders: TcxBorders;
    function HasBorderColoration: Boolean; override;
  public
    constructor CreateFrom(AParent: TdxReportCell; AViewInfo: TcxSchedulerCustomViewInfoItem); override;
    procedure Assign(Source: TPersistent); override;
    procedure DrawContent(DC: HDC; AStage: TdxPSRenderStages); override;
    class function SchedulerCellClass: TcxSchedulerCustomViewInfoItemClass; override;
    procedure SuppressColoration; override;
  end;

  { TcxSchedulerReportHeaderItemCell }

  TcxSchedulerReportHeaderItemCell = class(TcxSchedulerReportCustomCell)
  private
    FCaption: string;
    FDate: TDateTime;
    FIsResourceHeader: Boolean;
    FResourceID: Variant;
    FRotateText: Boolean;
    function GetTextAlignX: TcxTextAlignX;
    function GetTextAlignY: TcxTextAlignY;
    procedure SetTextAlignX(Value: TcxTextAlignX);
    procedure SetTextAlignY(Value: TcxTextAlignY);
  protected
    procedure ReadData(AReader: TdxPSDataReader); override;
    procedure WriteData(AWriter: TdxPSDataWriter); override;
  public
    constructor CreateFrom(AParent: TdxReportCell; AViewInfo: TcxSchedulerCustomViewInfoItem); override;
    procedure Assign(Source: TPersistent); override;
    procedure DrawContent(DC: HDC; AStage: TdxPSRenderStages); override;
    class function SchedulerCellClass: TcxSchedulerCustomViewInfoItemClass; override;
    property TextAlignX: TcxTextAlignX read GetTextAlignX write SetTextAlignX;
    property TextAlignY: TcxTextAlignY read GetTextAlignY write SetTextAlignY;
    property Caption: string read FCaption write FCaption;
    property Date: TDateTime read FDate;
    property IsResourceHeader: Boolean read FIsResourceHeader;
    property ResourceID: Variant read FResourceID;
    property RotateText: Boolean read FRotateText;
  end;

  { TcxSchedulerReportGroupSeparatorCell }

  TcxSchedulerReportGroupSeparatorCell = class(TcxSchedulerReportCustomCell)
  public
    constructor CreateFrom(AParent: TdxReportCell; AViewInfo: TcxSchedulerCustomViewInfoItem); override;
    class function SchedulerCellClass: TcxSchedulerCustomViewInfoItemClass; override;
  end;

  { TcxSchedulerReportContainerCell }

  TcxSchedulerReportContainerCell = class(TcxSchedulerReportCustomCell)
  public
    class function SchedulerCellClass: TcxSchedulerCustomViewInfoItemClass; override;
  end;

  { TcxSchedulerReportBackgroundSlotCell }

  TcxSchedulerReportBackgroundSlotCell = class(TcxSchedulerReportCustomCell)
  protected
    FDisplayText: string;
    procedure ReadData(AReader: TdxPSDataReader); override;
    procedure WriteData(AWriter: TdxPSDataWriter); override;
  public
    constructor CreateFrom(AParent: TdxReportCell; AViewInfo: TcxSchedulerCustomViewInfoItem); override;
    procedure DrawContent(DC: HDC; AStage: TdxPSRenderStages); override;
    class function SchedulerCellClass: TcxSchedulerCustomViewInfoItemClass; override;
    property DisplayText: string read FDisplayText write FDisplayText;
  end;

  { TcxSchedulerReportDailyTimeRulerCellsSite }

  TcxSchedulerReportDailyTimeRulerCellsSite = class(TdxReportCell)
  private
    FLargeFont: TFont;
    FLargeFontIndex: Integer;
    function GetLargeFont: TFont;
  protected
    procedure SetFontIndex(Index: Integer); override;
    procedure ReadProperties(AReader: TdxPSDataReader); override;
    procedure WriteProperties(AWriter: TdxPSDataWriter); override;
  public
    constructor Create(AParent: TdxReportCell); override;
    destructor Destroy; override;
    property LargeFont: TFont read GetLargeFont;
  end;

  { TcxSchedulerReportDailyTimeRulerCell }

  TcxSchedulerReportDailyTimeRulerCell = class(TcxSchedulerReportCustomCell)
  private
    function GetBoundsRect(AType: Boolean): TRect;
    function GetDisplayText(AType: Boolean): string;
    function GetLargeFont: TFont;
    function GetTimeRulerSite: TcxSchedulerReportDailyTimeRulerCellsSite;
  protected
    FHasAdditionalTimeZone: Boolean;
    FLineCount: Integer;
    FLineColor: TColor;
    FBounds: array[Boolean] of TRect;
    FDisplayTexts: array[Boolean] of string;
    FHour: Integer;
    procedure CalculateDisplayInfo;
    procedure DrawTimeZone(DC: HDC; const ABounds: TRect; const AText: string; AIsCurrent: Boolean); virtual;
    procedure DrawTimeZoneLabel(DC: HDC; const ABounds: TRect; const AText: string; ABorders: TcxBorders); virtual;

    procedure ReadData(AReader: TdxPSDataReader); override;
    procedure WriteData(AWriter: TdxPSDataWriter); override;

    property LargeFont: TFont read GetLargeFont;
  public
    constructor CreateFrom(AParent: TdxReportCell; AViewInfo: TcxSchedulerCustomViewInfoItem); override;
    procedure Assign(Source: TPersistent); override;
    procedure DrawContent(DC: HDC; AStage: TdxPSRenderStages); override;
    class function SchedulerCellClass: TcxSchedulerCustomViewInfoItemClass; override;
    procedure SuppressColoration; override;

    property Bounds[ACurrentTimeZone: Boolean]: TRect read GetBoundsRect;
    property DisplayTexts[ACurrentTimeZone: Boolean]: string read GetDisplayText;
    property HasAdditionalTimeZone: Boolean read FHasAdditionalTimeZone;
    property Hour: Integer read FHour;
    property LineCount: Integer read FLineCount;
    property TimeRulerSite: TcxSchedulerReportDailyTimeRulerCellsSite read GetTimeRulerSite;
  end;

  { TcxSchedulerReportMonthDayCell }

  TcxSchedulerReportMonthDayCell = class(TcxSchedulerReportContentCell)
  private
    FDisplayText: string;
    FDontPrint: Boolean;
  protected
    procedure ReadData(AReader: TdxPSDataReader); override;
    procedure WriteData(AWriter: TdxPSDataWriter); override;
  public
    constructor CreateFrom(AParent: TdxReportCell; AViewInfo: TcxSchedulerCustomViewInfoItem); override;
    procedure Assign(Source: TPersistent); override;
    procedure DrawContent(DC: HDC; AStage: TdxPSRenderStages); override;
    class function SchedulerCellClass: TcxSchedulerCustomViewInfoItemClass; override;
    property DisplayText: string read FDisplayText write FDisplayText;
  end;

  { TcxSchedulerReportTimeLinePart}

  TcxSchedulerReportTimeLinePart = class(TdxReportCellBox)
  private
    FState: Integer;
    FTriangle: Boolean;
  protected
    procedure ReadData(AReader: TdxPSDataReader); override;
    procedure WriteData(AWriter: TdxPSDataWriter); override;
    property State: Integer read FState write FState;
  public
    constructor CreateEx(AParent: TdxReportCell; ATriangle: Boolean; AState: Integer);
    procedure Assign(Source: TPersistent); override;
    procedure DrawContent(DC: HDC; AStage: TdxPSRenderStages); override;
  end;

  { TcxSchedulerReportTimeLineCell }

  TcxSchedulerReportTimeLineCell = class(TdxReportCell)
  private
    FCurrentValue: TAbstractdxReportCellData;
  public
    constructor Create(AParent: TdxReportCell); override;
    procedure SetTimeRect(const ABounds: TRect; AState: Integer);
  end;

  { TcxSchedulerReportCustomEventCell }

  TcxSchedulerReportCustomEventCell = class(TdxReportCell)
  private
    function GetPrintStyle: TcxCustomSchedulerReportLinkPrintStyle;
    function GetReportLink: TcxSchedulerReportLink;
    function GetSuppressColoration: Boolean;
  protected
    FCaptionCell: TdxReportCellString;
    FIconsCell: TdxReportCellString;
    FMessageCell: TAbstractdxReportCellData;
    FStartCell: TdxReportCellString;
    FFinishCell: TdxReportCellString;
    FTimeLineCell: TcxSchedulerReportTimeLineCell;
    procedure SetViewParams(const AViewParams: TcxViewParams); virtual;
  public
    function CreateStringCell(const AText: string; AData: Integer = 0): TdxReportCellString; virtual;

    property CaptionCell: TdxReportCellString read FCaptionCell;
    property IconsCell: TdxReportCellString read FIconsCell;
    property StartCell: TdxReportCellString read FStartCell;
    property FinishCell: TdxReportCellString read FFinishCell;
    property MessageCell: TAbstractdxReportCellData read FMessageCell;
    property PrintStyle: TcxCustomSchedulerReportLinkPrintStyle read GetPrintStyle;
    property ReportLink: TcxSchedulerReportLink read GetReportLink;
    property TimeLineCell: TcxSchedulerReportTimeLineCell read FTimeLineCell;
    property SuppressColoration: Boolean read GetSuppressColoration;
  end;

  { TcxSchedulerReportEventCell }

  TcxSchedulerReportEventCell = class(TcxSchedulerReportCustomEventCell)
  private
    FContentBounds: TRect;
    FEditViewInfo: TcxCustomEditViewInfo;
    FEventViewInfo: TcxSchedulerEventCellViewInfo;
    FHasDetailInfo: Boolean;
    FHasIcons: Boolean;
    FHasMessage: Boolean;
    FIconsString: string;
    FIsHeaderEvent: Boolean;
    FIsNeedCreateTimeCells: Boolean;
    FMessage: Variant;
    procedure CheckBounds(var ABounds: TRect);
    function GetEvent: TcxSchedulerControlEvent;
  protected
    procedure AdjustItemsHeight; virtual;
    procedure CalculateLayout; virtual;
    procedure CalculateTimeLine(DC: HDC); virtual;
    function CreateCaptionCell: TdxReportCellString; virtual;
    procedure CreateDataItems; virtual;
    function CreateIconCells: TdxReportCellString; virtual;
    procedure CreateMessageCell(AMessage: Variant;
      AProperties: TcxCustomEditProperties; AViewParams: TcxViewParams);
    function CreateTimeLineCell: TcxSchedulerReportTimeLineCell; virtual;
    function CreateTimeTextCell(const ATimeText: string): TdxReportCellString; virtual;
    function GetCaptionRect(DC: HDC): TRect; virtual;
    function GetContentBounds(DC: HDC): TRect; virtual;
    function GetHasIcons: Boolean; virtual;
    function GetHasMessage: Boolean; virtual;
    function GetIconsRect(DC: HDC): TRect; virtual;
    function GetIconsString: string; virtual;
    function GetMessageClass(AProperties: TcxCustomEditProperties): TdxReportCellDataClass; virtual;
    function GetMessageRect(DC: HDC): TRect; virtual;
    function GetRelativeRect(const R: TRect): TRect;
    function GetTimeLineRect(DC: HDC): TRect; virtual;
    procedure InitializeFromViewInfo(AEventViewInfo: TcxSchedulerEventCellViewInfo);
    procedure SetViewParams(const AViewParams: TcxViewParams); override;

    property ContentBounds: TRect read FContentBounds;
    property Event: TcxSchedulerControlEvent read GetEvent;
    property EventViewInfo: TcxSchedulerEventCellViewInfo read FEventViewInfo;
    property HasDetailInfo: Boolean read FHasDetailInfo;
    property HasIcons: Boolean read FHasIcons;
    property IsHeaderEvent: Boolean read FIsHeaderEvent;
    property IsNeedCreateTimeCells: Boolean read FIsNeedCreateTimeCells;
  public
    constructor CreateFrom(AParent: TdxReportCell; AEventViewInfo: TcxSchedulerEventCellViewInfo); virtual;

    property CaptionCell: TdxReportCellString read FCaptionCell;
    property HasMessage: Boolean read FHasMessage;
    property Message: Variant read FMessage;
    property MessageCell;
    property TimeLineCell;
    property IconsCell;
    property IconsString: string read FIconsString;
    property StartCell;
    property FinishCell;
  end;

  { TcxSchedulerReportDetailsEventCell }

  TcxSchedulerReportDetailsEventCell = class(TcxSchedulerReportCustomEventCell)
  protected
    FContinued: Boolean;
    FDate: TDateTime;

    FEvent: TcxSchedulerEvent;
    FLineHeight: Integer;
    procedure CreateCaptionCell; virtual;
    procedure CreateDataItems; virtual;
    procedure CreateMessageCell; virtual;
    procedure CreateTimeCell; virtual;
    function GetCaptionCellText: string; virtual;
    function GetMessageCellText: string; virtual;
    function GetTimeCellText: string; virtual;
    procedure SetViewParams(const AViewParams: TcxViewParams); override;
  public
    constructor CreateEx(AParent: TdxReportCell; AEvent: TcxSchedulerEvent;
      ADate: TDateTime; const AParams: TcxViewParams; AContinued: Boolean = False);
    function CalculateHeight: Integer; virtual;
    procedure CalculateLayout(AWidth, ATimeWidth: Integer); virtual;

    property Date: TDateTime read FDate;
    property Event: TcxSchedulerEvent read FEvent;
    property Continued: Boolean read FContinued;
  end;

  { TcxSchedulerReportMemoEventCell }

  TcxSchedulerReportMemoEventCell = class(TcxSchedulerReportDetailsEventCell)
  protected
    FCaptionLabelCell: TdxReportCellString;
    FHeaderCell: TdxReportCellString;
    FLocationCell: TdxReportCellString;
    FLocationLabelCell: TdxReportCellString;
    FShowTimeAsCell: TdxReportCellString;
    FShowTimeAsLabelCell: TdxReportCellString;
    FStartLabelCell: TdxReportCellString;
    FFinishLabelCell: TdxReportCellString;
    FRecurrenceCell: TdxReportCellString;
    FRecurrenceLabelCell: TdxReportCellString;
    FRecurrencePatternCell: TdxReportCellString;
    FRecurrencePatternLabelCell: TdxReportCellString;
    procedure CreateDataItems; override;
    function GetCaptionCellText: string; override;
    function GetMessageCellText: string; override;
    function GetTimeCellText: string; override;
    procedure SetViewParams(const AViewParams: TcxViewParams); override;

    procedure CalculateLabelAndData(ALabelCell, ADataCell: TAbstractdxReportCellData;
      DC: HDC; ATimeWidth, AWidth: Integer; var ATop: Integer); virtual;
    procedure CreateHeader; virtual;
    procedure CreateFinish; virtual;
    procedure CreateFinishCell; virtual;
    procedure CreateFinishLabelCell; virtual;
    procedure CreateLocation; virtual;
    procedure CreateLocationCell; virtual;
    procedure CreateLocationLabelCell; virtual;
    procedure CreateMessage; virtual;
    procedure CreateRecurrence; virtual;
    procedure CreateRecurrenceCell; virtual;
    procedure CreateRecurrenceLabelCell; virtual;
    procedure CreateRecurrencePattern; virtual;
    procedure CreateRecurrencePatternCell; virtual;
    procedure CreateRecurrencePatternLabelCell; virtual;
    procedure CreateShowTimeAs; virtual;
    procedure CreateShowTimeAsCell; virtual;
    procedure CreateShowTimeAsLabelCell; virtual;
    procedure CreateStart; virtual;
    procedure CreateStartLabelCell; virtual;
    procedure CreateSubject; virtual;
    procedure CreateSubjectLabelCell; virtual;
    function GetHeaderCellText: string; virtual;
    function GetRecurrenceCellText: string; virtual;
    function GetRecurrencePatternCellText: string; virtual;
    function GetShowTimeAsCellText: string; virtual;
  public
    procedure CalculateLayout(AWidth, ATimeWidth: Integer); override;

    property CaptionLabelCell: TdxReportCellString read FCaptionLabelCell;
    property HeaderCell: TdxReportCellString read FHeaderCell;
    property LocationCell: TdxReportCellString read FLocationCell;
    property LocationLabelCell: TdxReportCellString read FLocationLabelCell;
    property ShowTimeAsCell: TdxReportCellString read FShowTimeAsCell;
    property ShowTimeAsLabelCell: TdxReportCellString read FShowTimeAsLabelCell;
    property StartLabelCell: TdxReportCellString read FStartLabelCell;
    property FinishLabelCell: TdxReportCellString read FFinishLabelCell;
    property RecurrenceCell: TdxReportCellString read FRecurrenceCell;
    property RecurrenceLabelCell: TdxReportCellString read FRecurrenceLabelCell;
    property RecurrencePatternCell: TdxReportCellString read FRecurrencePatternCell;
    property RecurrencePatternLabelCell: TdxReportCellString read FRecurrencePatternLabelCell;
  end;

  { TcxSchedulerReportCommonCellsProducer }

  TcxSchedulerReportCommonCellsProducer = class(TcxCustomResourceViewAdapter)
  private
    FSite: TcxSchedulerReportSchedulingAreaCell;
    FStyle: TcxCustomSchedulerReportLinkPrintStyle;
    function GetStyles: TcxSchedulerReportLinkStyles;
  protected
    FBounds: TRect;

    procedure AfterCalculatePage; override;

    function CanCalculate: Boolean; override;

    procedure ConvertSchedulerCellToPSCells(AItem: TcxSchedulerCustomViewInfoItem;
      AReportItemClass: TcxSchedulerReportCustomCellClass); virtual;
    function CreateEventCell(AEventViewInfo: TcxSchedulerEventCellViewInfo): TcxSchedulerReportEventCell; virtual;

    procedure DoInitialize(
      var ASelectedDays: TcxSchedulerDateList; var AEvents: TcxSchedulerCachedEventList); override;
    // layout settings
    function GetCompressWeekends: Boolean; override;
    function GetDontPrintWeekEnds: Boolean; override;
    function GetHideSelection: Boolean; override;
    function GetPageBounds: TRect; override;
    function GetPagesPerWeek: Byte; override;
    function GetPrintExactlyOneMonth: Boolean; override;
    function GetPrintRange(Index: Integer): TDateTime; override;
    function GetPrimaryPage: Boolean; override;
    function GetStylesAdapter: IcxSchedulerStylesAdapter; override;
    // styles
    procedure SetCellViewParams(ACell: TdxReportVisualItem; const AParams: TcxViewParams); virtual;
  public
    constructor CreateEx(AStyle: TcxCustomSchedulerReportLinkPrintStyle;
      ASite: TcxSchedulerReportSchedulingAreaCell); virtual;
    procedure GetPageResources(AResources: TcxObjectList); override;
    procedure Produce; virtual;
    property Site: TcxSchedulerReportSchedulingAreaCell read FSite;
    property Style: TcxCustomSchedulerReportLinkPrintStyle read FStyle;
    property Styles: TcxSchedulerReportLinkStyles read GetStyles;
  end;

  TcxSchedulerReportCommonCellsProducerClass = class of TcxSchedulerReportCommonCellsProducer;

  { TcxSchedulerReportWeeksCellsProducer }

  TcxSchedulerReportWeeksCellsProducer = class(TcxSchedulerReportCommonCellsProducer)
  end;

  { TcxSchedulerReportDailyCellsProducer }

  TcxSchedulerReportDailyCellsProducer = class(TcxSchedulerReportCommonCellsProducer)
  private
    FRulerSite: TcxSchedulerReportDailyTimeRulerCellsSite;
  protected
    procedure AfterCalculatePage; override;
    procedure BeforeCalculatePage; override;

    function CreateTimeRulerSite: TcxSchedulerReportDailyTimeRulerCellsSite; virtual;
    procedure ConvertSchedulerCellToPSCells(AItem: TcxSchedulerCustomViewInfoItem;
      AReportItemClass: TcxSchedulerReportCustomCellClass); override;
  end;

var
  SpecialSymbolFont: TFont;

implementation

{$R *.dfm}
{$R dxPScxSchedulerLnk.res}

uses
  Messages, ShlObj, dxPSUtl, dxPSRes, dxPSPopupMan, Math,
{$IFDEF DELPHI6}
  DateUtils, Types,
{$ENDIF}
  ActiveX, CommCtrl;

const
  IDB_DXPSSCHEDULER_STYLEDESIGNPREVIEW = 'IDB_DXPSSCHEDULER_STYLEDESIGNPREVIEW';
  IDB_DXPSSCHEDULER_SMALLDESIGNPREVIEW = 'IDB_DXPSSCHEDULER_SMALLDESIGNPREVIEW';
  dxFormatShowDaysWithEventsInBold = dxPSGlbl.dxFormatCheckEnabled;
  dxFormatDayIsBold = dxPSGlbl.dxFormatCheckChecked;

type
  TLongRec = packed record
    Bytes: array [0..3] of Byte;
  end;

  TControlAccess = class(TControl);
  TcxSchedulerCachedEventListAccess = class(TcxSchedulerCachedEventList);

var
  MirrorClasses: TList;
  StyleImages: TImageList;
  SchedulerFontHandle: THandle;
  SchedulerFontFileName: string;
  StylePreviewImages: TImageList;
  StyleSheetPrototype: TcxSchedulerReportLinkStyleSheet;

{$IFNDEF DELPHI6}
function StartOfTheDay(const AValue: TDateTime): TDateTime;
begin
  Result := Trunc(AValue);
end;

function EndOfTheDay(const AValue: TDateTime): TDateTime;
begin
  Result := Trunc(AValue) + EncodeTime(23, 59, 59, 999);
end;

function StartOfTheWeek(const AValue: TDateTime): TDateTime;
begin
  Result := Trunc(AValue) - (DayOfTheWeek(AValue) - 1);
end;

function EndOfTheWeek(const AValue: TDateTime): TDateTime;
begin
  Result := EndOfTheDay(StartOfTheWeek(AValue) + 6);
end;

{$ENDIF}

procedure Rect2RectsVert(const ASource: TRect; var R1, R2: TRect); overload;
begin
  R1 := ASource;
  R2 := ASource;
  R1.Bottom := (ASource.Bottom + ASource.Top - InterAreaSpace) div 2;
  R2.Top := R1.Bottom + InterAreaSpace;
end;

procedure Rect2RectsVert(const ASource: TRect; var R1, R2, R3: TRect); overload;
var
  H: Integer;
begin
  R1 := ASource;
  R2 := ASource;
  R3 := ASource;
  H := ASource.Bottom - ASource.Top;
  R1.Bottom := ASource.Top + MulDiv(H, 1, 3);
  R2.Top := R1.Bottom + InterAreaSpace;
  R2.Bottom := ASource.Top + MulDiv(H, 2, 3);
  R3.Top := R2.Bottom + InterAreaSpace;
end;

procedure Rect2RectsHorz(const ASource: TRect; var R1, R2: TRect); overload;
begin
  R1 := ASource;
  R2 := ASource;
  R1.Right := (ASource.Left + ASource.Right - InterAreaSpace) div 2;
  R2.Left := R1.Right + InterAreaSpace;
end;

procedure Rect2RectsHorz(const ASource: TRect; var R1, R2, R3: TRect); overload;
var
  W: Integer;
begin
  R1 := ASource;
  R2 := ASource;
  R3 := ASource;
  W := ASource.Right - ASource.Left;
  R1.Right := ASource.Left + MulDiv(W, 1, 3);
  R2.Left := R1.Right + InterAreaSpace;
  R2.Right := ASource.Left + MulDiv(W, 2, 3);
  R3.Left := R2.Right + InterAreaSpace;
end;

function AdditionalWidth(const ABounds: TRect): Integer;
begin
  with ABounds do
    Result := Round((Right - Left) * NotesAreaWidth) - InterAreaSpace div 2;
end;

procedure SplitToRects(const ASource: TRect; AShowCalendar,
  AIsRightArea: Boolean; out R1, R2: TRect);
begin
  R1 := ASource;
  R2 := ASource;
  if AShowCalendar then
  begin
    if AIsRightArea then
    begin
      R2.Left := R2.Right - AdditionalWidth(R1);
      R1.Right := R2.Left - InterAreaSpace;
    end
    else
    begin
      R2.Right := R2.Left + AdditionalWidth(R1);
      R1.Left := R2.Right + InterAreaSpace;
    end;
  end;
end;

function SchedulerLinkStyleSheetPrototype: TcxSchedulerReportLinkStyleSheet;

  function CreateStyle(AColor, AFontColor: TColor): TcxStyle;
  begin
    Result := TcxStyle.Create(StyleSheetPrototype);
    with Result do
    begin
      Color := AColor;
      Font.Name := dxPSCore.dxPSDefaultFontName;
      Font.Color := AFontColor;
    end;
  end;

begin
  if StyleSheetPrototype = nil then
  begin
    StyleSheetPrototype := TcxSchedulerReportLinkStyleSheet.Create(nil);
    with StyleSheetPrototype.Styles as TcxSchedulerReportLinkStyles do
    begin
      SchedulerHeader := CreateStyle(dxPSCore.dxDefaultContentColor, dxPSCore.dxPSDefaultFontColor);
      Content := CreateStyle(dxPSCore.dxDefaultContentColor, dxPSCore.dxPSDefaultFontColor);
      DateNavigatorContent := CreateStyle(dxPSCore.dxDefaultContentColor, dxPSCore.dxPSDefaultFontColor);
      DateNavigatorHeader := CreateStyle(dxPSCore.dxDefaultContentColor, dxPSCore.dxPSDefaultFontColor);
      DayHeader := CreateStyle(dxPSCore.dxDefaultFixedColor, dxPSCore.dxPSDefaultFontColor);
      Event := CreateStyle(dxPSCore.dxDefaultContentColor, dxPSCore.dxPSDefaultFontColor);
      ResourceHeader := CreateStyle(dxPSCore.dxDefaultFixedColor, dxPSCore.dxPSDefaultFontColor);
      NotesAreaBlank := CreateStyle(dxPSCore.dxDefaultContentColor, dxPSCore.dxPSDefaultFontColor);
      NotesAreaLined := CreateStyle(dxPSCore.dxDefaultContentColor, dxPSCore.dxPSDefaultFontColor);
      TaskPad := CreateStyle(dxPSCore.dxDefaultContentColor, dxPSCore.dxPSDefaultFontColor);
      TimeRuler := CreateStyle(dxPSCore.dxDefaultFixedColor, dxPSCore.dxPSDefaultFontColor);
    end;
  end;
  Result := StyleSheetPrototype;
end;

function FindMirorClassForItem(AItem: TObject;
  var APSItemClass: TcxSchedulerReportCustomCellClass): Boolean;
var
  I: Integer;
begin
  APSItemClass := nil;
  Result := False;
  for I := MirrorClasses.Count - 1 downto 0 do
  begin
    APSItemClass := MirrorClasses[I];
    if AItem.InheritsFrom(APSItemClass.SchedulerCellClass) then
    begin
      Result := True;
      Break;
    end;
  end;
end;

{ TcxSchedulerReportLinkRenderInfo }

procedure TcxSchedulerReportLinkRenderInfo.DoCalculate;
var
  I: Integer;
begin
  if not IsLoading then
  begin
    if (ReportLink <> nil) and (ReportLink.PrintStyles.ActiveStyle <> nil) then
    begin
      FPageColCount := Byte(ReportLink.PrintStyles.ActiveStyle.Layout) + 1;
      FPageRowCount := ReportLink.PageSites.Count;
    end
    else
    begin
      FPageColCount := 1;
      FPageRowCount := 1;
    end;
  end;
  inherited DoCalculate;
  for I := 0 to PageRenderInfoCount - 1 do
    with PageRenderInfos[I] do
      TitleOffset := DataOffset;
end;

function TcxSchedulerReportLinkRenderInfo.GetPageColCount: Integer;
begin
  if not IsLoading then
    Result := 1//FPageColCount
  else
    Result := inherited GetPageColCount;
end;

function TcxSchedulerReportLinkRenderInfo.GetPageRowCount: Integer;
begin
  if not IsLoading then
    Result := FPageRowCount
  else
    Result := inherited GetPageColCount;
end;

function TcxSchedulerReportLinkRenderInfo.IsLoading: Boolean;
begin
  Result := ReportLink.DataSource = rldsExternalStorage;
end;

function TcxSchedulerReportLinkRenderInfo.IsDrawPageTitleOnPage(
  APageIndex: Integer): Boolean;
begin
  Result := Rendering and IsDrawReportTitleOnPage(APageIndex);
end;

function TcxSchedulerReportLinkRenderInfo.IsDrawReportTitleOnPage(
  APageIndex: Integer): Boolean;
begin
  case ReportLink.ReportTitleMode of
    tmNone:
      Result := False;
    tmOnFirstPage:
      Result := APageIndex = 0;
  else
    Result := APageIndex mod FPageColCount = 0;
  end;
end;

function TcxSchedulerReportLinkRenderInfo.GetReportLink: TcxSchedulerReportLink;
begin
  Result := TcxSchedulerReportLink(inherited ReportLink);
end;

{ TcxSchedulerReportRenderer }

procedure TcxSchedulerReportRenderer.PrepareRenderPage;
begin
  inherited PrepareRenderPage;
  TcxSchedulerReportLinkRenderInfo(RenderInfo).Rendering := True;
end;

procedure TcxSchedulerReportRenderer.UnprepareRenderPage;
begin
  TcxSchedulerReportLinkRenderInfo(RenderInfo).Rendering := False;
  inherited UnprepareRenderPage;
end;

{ TcxSchedulerReportLink }

constructor TcxSchedulerReportLink.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPageSites := TList.Create;
  FLookAndFeelItems := TList.Create;
end;

destructor TcxSchedulerReportLink.Destroy;
begin
  FreeAndNil(FPageSites);
  FreeAndNil(FLookAndFeelItems);
  inherited Destroy;
end;

procedure TcxSchedulerReportLink.Assign(Source: TPersistent);
begin
  if Source is TcxSchedulerReportLink then
    with TcxSchedulerReportLink(Source) do 
    begin
      Self.PrintRange := PrintRange;
      Self.PrintStyles := PrintStyles;
    end;
  inherited;
end;

class function TcxSchedulerReportLink.Aggregable: Boolean;
begin
  Result := False;
end;

procedure TcxSchedulerReportLink.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (TaskPadReportLink = AComponent) and (Operation = opRemove) then
    TaskPadReportLink := nil;
end;  

// IdxReportLinkController
function TcxSchedulerReportLink.GetControlSiteBounds(AControl: TControl): TRect;
begin
  if PrintStyles.ActiveStyle <> nil then
    Result := PrintStyles.ActiveStyle.GetControlSiteBounds(AControl)
  else
    Result := NullRect;
end;

procedure TcxSchedulerReportLink.ConstructReport(AReportCells: TdxReportCells);

  procedure CalculateSizes;

    procedure CalculateReportPartSizes(ACell: TdxReportCell);
    var
      Width, I, V: Integer;
    begin
      if ACell.CellCount > 0 then
      begin
        Width := 0;
        for I := 0 to ACell.CellCount - 1 do
        begin
          V := ACell.Cells[I].Width;
          if Width < V then Width := V;
        end;
        ACell.BoundsRect := MakeRect(0, 0, Width, ACell.LastCell.BoundsRect.Bottom);
      end;  
    end;
  
  begin
    with AReportCells do 
    begin
      CalculateReportPartSizes(Cells);
      if AreFooterCellsAllocated then CalculateReportPartSizes(FooterCells);
      if AreHeaderCellsAllocated then CalculateReportPartSizes(HeaderCells);
    end;
  end; 

begin
  if Scheduler = nil then Exit;
  inherited;

  if PrintStyles.ActiveStyle = nil then
    Exit;

  PrepareConstruct;
  try
    BuildStyle;
    if not AbortBuilding then CalculateSizes;
  finally
    UnprepareConstruct;
  end;
end;

procedure TcxSchedulerReportLink.DoCreateReport;
begin
  if (PrintStyles.ActiveStyle = nil) or not PrintStyles.ActiveStyleAssigned then
    PrintStyles.SetActiveStyleEx(PrintStyles.GetCorrespondingStyle);
  inherited DoCreateReport;
end;

function TcxSchedulerReportLink.GetRealScaleFactor: Integer;
begin
  Result := 100;
end;

procedure TcxSchedulerReportLink.CustomDraw(AItem: TAbstractdxReportCellData;
  ACanvas: TCanvas; ABoundsRect, AClientRect: TRect; var ADone: Boolean);
begin
  case AItem.GetCustomDrawID of
    cdidSchedulerContent:
      DoCustomDrawContentCell(ACanvas, TcxSchedulerReportContentCell(AItem), ADone);
    cdidSchedulerSchedulerHeader:
      DoCustomDrawSchedulerHeaderCell(ACanvas, TcxSchedulerReportSchedulerHeaderDataCell(AItem), ADone);
    cdidSchedulerDateNavigatorHeader:
      DoCustomDrawDateNavigatorHeaderCell(ACanvas, TcxSchedulerReportDateNavigatorHeader(AItem), ADone);
    cdidSchedulerDateNavigatorDay:
      DoCustomDrawDateNavigatorDayCell(ACanvas, TcxSchedulerReportDateNavigatorDay(AItem), ADone);
    cdidSchedulerDateNavigatorDayCaption:
      DoCustomDrawDateNavigatorDayCaptionCell(ACanvas, TcxSchedulerReportDateNavigatorDayCaption(AItem), ADone);
    cdidSchedulerDateNavigatorWeekNumber:
      DoCustomDrawDateNavigatorWeekNumberCell(ACanvas, TcxSchedulerReportDateNavigatorWeekNumber(AItem), ADone);
    cdidSchedulerTimeRuler:
      DoCustomDrawTimeRulerCell(ACanvas, TcxSchedulerReportDailyTimeRulerCell(AItem), ADone);
    cdidSchedulerEventCaption..cdidSchedulerEventTimeLine:
      DoCustomDrawEventPartCell(ACanvas, AItem, ADone);
    cdidSchedulerNotesArea:
      DoCustomDrawNotesCell(ACanvas, TcxSchedulerReportNotesDataCell(AItem), ADone);
    cdidSchedulerTaskPad:
      DoCustomDrawTaskPadCell(ACanvas, TcxSchedulerReportNotesDataCell(AItem), ADone);
    cdidSchedulerHeader:
      DoCustomDrawHeaderCell(ACanvas, TcxSchedulerReportHeaderItemCell(AItem), ADone);
  end;
end;

procedure TcxSchedulerReportLink.DoCanPrintEvent(AEvent: TcxSchedulerEvent;
  var AllowPrint: Boolean);
begin
  if Assigned(FOnCanPrintEvent) then
    FOnCanPrintEvent(Self, AEvent, AllowPrint);
end;

procedure TcxSchedulerReportLink.DoCustomDrawSchedulerHeaderCell(
  ACanvas: TCanvas; AItem: TcxSchedulerReportSchedulerHeaderDataCell; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawSchedulerHeaderCell) then
    FOnCustomDrawSchedulerHeaderCell(Self, ACanvas, AItem, ADone);
end;

procedure TcxSchedulerReportLink.DoCustomDrawDateNavigatorHeaderCell(
  ACanvas: TCanvas; AItem: TcxSchedulerReportDateNavigatorHeader; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawDateNavigatorHeaderCell) then
    FOnCustomDrawDateNavigatorHeaderCell(Self, ACanvas, AItem, ADone);
end;

procedure TcxSchedulerReportLink.DoCustomDrawDateNavigatorDayCell(
  ACanvas: TCanvas; AItem: TcxSchedulerReportDateNavigatorDay;
  var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawDateNavigatorDayCell) then
    FOnCustomDrawDateNavigatorDayCell(Self, ACanvas, AItem, ADone);
end;

procedure TcxSchedulerReportLink.DoCustomDrawDateNavigatorDayCaptionCell(
  ACanvas: TCanvas; AItem: TcxSchedulerReportDateNavigatorDayCaption;
  var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawDateNavigatorDayCaptionCell) then
    FOnCustomDrawDateNavigatorDayCaptionCell(Self, ACanvas, AItem, ADone);
end;

procedure TcxSchedulerReportLink.DoCustomDrawDateNavigatorWeekNumberCell(
  ACanvas: TCanvas; AItem: TcxSchedulerReportDateNavigatorWeekNumber;
  var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawDateNavigatorWeekNumberCell) then
    FOnCustomDrawDateNavigatorWeekNumberCell(Self, ACanvas, AItem, ADone);
end;

procedure TcxSchedulerReportLink.DoCustomDrawTimeRulerCell(
  ACanvas: TCanvas; AItem: TcxSchedulerReportDailyTimeRulerCell; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawTimeRulerCell) then
    FOnCustomDrawTimeRulerCell(Self, ACanvas, AItem, ADone);
end;

procedure TcxSchedulerReportLink.DoCustomDrawContentCell(
  ACanvas: TCanvas; AItem: TcxSchedulerReportContentCell; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawContentCell) then
    FOnCustomDrawContentCell(Self, ACanvas, AItem, ADone);
end;

procedure TcxSchedulerReportLink.DoCustomDrawHeaderCell(
  ACanvas: TCanvas; AItem: TcxSchedulerReportHeaderItemCell; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawHeaderCell) then
    FOnCustomDrawHeaderCell(Self, ACanvas, AItem, ADone);
end;

procedure TcxSchedulerReportLink.DoCustomDrawEventPartCell(
  ACanvas: TCanvas; AItem: TAbstractdxReportCellData; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawEventPartCell) then
    FOnCustomDrawEventPartCell(Self, ACanvas, AItem,
      TcxSchedulerReportEventPartType(AItem.GetCustomDrawID - cdidSchedulerEventCaption),
      ADone);
end;

procedure TcxSchedulerReportLink.DoCustomDrawNotesCell(ACanvas: TCanvas;
  AItem: TcxSchedulerReportNotesDataCell; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawNotesCell) then
    FOnCustomDrawNotesCell(Self, ACanvas, AItem, ADone);
end;

procedure TcxSchedulerReportLink.DoCustomDrawTaskPadCell(
  ACanvas: TCanvas; AItem: TcxSchedulerReportNotesDataCell; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawTaskPadCell) then
    FOnCustomDrawTaskPadCell(Self, ACanvas, AItem, ADone);
end;

function TcxSchedulerReportLink.GetRebuildOnPageParamsChange(AUpdateCodes: TdxPrinterPageUpdateCodes): Boolean;
begin
  if PrintStyles.ActiveStyle <> nil then
    Result := PrintStyles.ActiveStyle.GetRebuildOnPageParamsChange(AUpdateCodes)
  else
    Result := inherited GetRebuildOnPageParamsChange(AUpdateCodes);  
end;

function TcxSchedulerReportLink.GetRendererClass: TdxPSReportRendererClass;
begin
  Result := TcxSchedulerReportRenderer;
end;

function TcxSchedulerReportLink.GetRenderInfoClass: TdxPSReportRenderInfoClass;
begin
  Result := TcxSchedulerReportLinkRenderInfo;
end;

procedure TcxSchedulerReportLink.InternalRestoreDefaults;
begin
  inherited;
  PrintRange.RestoreDefaults;
  PrintStyles.RestoreDefaults;
end;

procedure TcxSchedulerReportLink.InternalRestoreFromOriginal;
begin
  inherited;
end;

procedure TcxSchedulerReportLink.RebuildReport;
begin
  inherited RebuildReport;
  if DesignWindow <> nil then
    DesignWindow.UpdatePreview;
end;

procedure TcxSchedulerReportLink.PrepareConstruct;
begin
  FLookAndFeelItems.Clear;
  inherited PrepareConstruct;
end;

procedure TcxSchedulerReportLink.UnprepareConstruct;
begin
  FormatLookAndFeelItems;
  inherited UnprepareConstruct;
end;

procedure TcxSchedulerReportLink.CreateOptions;
begin
  inherited CreateOptions;
  FPrintRange := CreatePrintRange;
  FPrintStyles := CreatePrintStyles;
end;

procedure TcxSchedulerReportLink.DestroyOptions;
begin
  FreeAndNil(FPrintStyles);
  FreeAndNil(FPrintRange);
  inherited DestroyOptions;
end;

function TcxSchedulerReportLink.GetOptionsFormattingClass: TdxCustomReportLinkOptionsFormattingClass;
begin
  Result := TcxSchedulerReportLinkOptionsFormatting;
end;

function TcxSchedulerReportLink.CreatePrintRange: TcxSchedulerReportLinkPrintRange;
begin
  Result := TcxSchedulerReportLinkPrintRange.Create(Self);
end;

function TcxSchedulerReportLink.CreatePrintStyles: TcxSchedulerReportLinkPrintStyles;
begin
  Result := TcxSchedulerReportLinkPrintStyles.Create(Self);
end;

function TcxSchedulerReportLink.GetAreNativeStylesAvailable: Boolean;
begin
  Result := OptionsFormatting.UseNativeStyles;
end;
   
function TcxSchedulerReportLink.GetStylesClass: TdxCustomReportLinkStylesClass;
begin
  Result := TcxSchedulerReportLinkStyles;
end;

function TcxSchedulerReportLink.GetStyleSheetClass: TdxCustomReportLinkStyleSheetClass;
begin
  Result := TcxSchedulerReportLinkStyleSheet;
end;

function TcxSchedulerReportLink.GetStyleSheetPrototype: TdxCustomReportLinkStyleSheet;
begin
  Result := SchedulerLinkStyleSheetPrototype;
end;

procedure TcxSchedulerReportLink.ActivePrintStyleChanged;
begin
  if not IsDestroying and not IsLoading then
  begin
    if Active then
    begin
      FreeRenderInfos;
      FreeRenderer;
      RebuildReport;
    end; 
    DoActivePrintStyleChanged;
  end;  
end;

procedure TcxSchedulerReportLink.DoActivePrintStyleChanged;
begin
  if Assigned(FOnActivePrintStyleChanged) then FOnActivePrintStyleChanged(Self);
end;

procedure TcxSchedulerReportLink.FormatLookAndFeelItems;
const
  Borders3D: array[Boolean] of TdxPSCellBorderClass =
   (TdxPSCellRaisedBorder, TdxPSCellRaisedSoftBorder);
var
  I: Integer;
begin
  for I := 0 to LookAndFeelItemCount - 1 do
    with LookAndFeelItems[I] do 
      if Effects3D then
        BorderClass := Borders3D[Soft3D]
      else
        BorderClass := TdxPSCellUltraFlatBorder;
end;

procedure TcxSchedulerReportLink.RegisterLookAndFeelItem(AItem: TdxReportVisualItem;
  AEdgeStyle: TdxCellEdgeStyle);
begin
  AItem.EdgeMode := Self.EdgeMode;
  AItem.Edge3DStyle := AEdgeStyle;
  FLookAndFeelItems.Add(AItem);
end;

procedure TcxSchedulerReportLink.DoInitializeSchedulingAreaCell(
  AItem: TcxSchedulerReportSchedulingAreaCell);
begin
  if Assigned(FOnInitializeSchedulingAreaCell) then
    FOnInitializeSchedulingAreaCell(Self, AItem);
end;

procedure TcxSchedulerReportLink.DoInitializeEventCell(AItem: TcxSchedulerReportCustomEventCell);
begin
  if Assigned(FOnInitializeEventCell) then
    FOnInitializeEventCell(Self, AItem);
end;

procedure TcxSchedulerReportLink.DoInitializeHeaderPrimaryCell(
  AItem: TcxSchedulerReportSchedulerHeaderCell);
begin
  if Assigned(FOnInitializeHeaderPrimaryCell) then
    FOnInitializeHeaderPrimaryCell(Self, AItem);
end;

procedure TcxSchedulerReportLink.DoInitializeHeaderSecondaryCell(
  AItem: TcxSchedulerReportSchedulerHeaderCell);
begin
  if Assigned(FOnInitializeHeaderSecondaryCell) then
    FOnInitializeHeaderSecondaryCell(Self, AItem);
end;

procedure TcxSchedulerReportLink.DoInitializeNotesAreaCell(
  AItem: TcxSchedulerReportNotesAreaCell);
begin
  if Assigned(FOnInitializeNotesAreaCell) then
    FOnInitializeNotesAreaCell(Self, AItem);
end;

procedure TcxSchedulerReportLink.DoInitializeTaskPadCell(
  AItem: TcxSchedulerReportTaskPadCell);
begin
  if Assigned(FOnInitializeTaskPadCell) then
    FOnInitializeTaskPadCell(Self, AItem);
end;

procedure TcxSchedulerReportLink.AssignTaskPadData(ATaskPad: TcxSchedulerReportTaskPadCell);

  procedure CropData(ASite: TdxReportCell);
  var
    CropBounds, R: TRect;
    I: Integer;
    Cell: TdxReportCell;
  begin
    CropBounds := ASite.AbsoluteRect;
    for I := ASite.CellCount - 1 downto 0 do
    begin
      Cell := ASite.Cells[I];
      if not IntersectRect(R, Cell.AbsoluteRect, CropBounds) then
        Cell.Free;
    end;
  end;

begin
  if (TaskPadReportLink <> nil) and TaskPadReportLink.DataProviderPresent then
  begin
    TaskPadReportLink.Controller := Renderer.ReportLink;
    try
      TaskPadReportLink.RebuildReport;
      ATaskPad.TaskPadDataSite.Assign(TaskPadReportLink.ReportCells.Cells);
      CropData(ATaskPad.TaskPadDataSite);
      ATaskPad.TaskPadDataSite.ClipChildren := True;
    finally
      TaskPadReportLink.Controller := nil;
    end;  
  end;
end;

procedure TcxSchedulerReportLink.InitializeTaskPadCell(ATaskPad: TcxSchedulerReportTaskPadCell);
begin
  AssignTaskPadData(ATaskPad);
  DoInitializeTaskPadCell(ATaskPad);
end;

procedure TcxSchedulerReportLink.SetCellViewParams(
  ACell: TdxReportVisualItem; const AParams: TcxViewParams);
var
  AdxPSViewParams: TdxReportItemViewParams;
begin
  if not Assigned(ACell) then Exit;
  FillChar(AdxPSViewParams, SizeOf(AdxPSViewParams), 0);
  AdxPSViewParams.NativeParams := AParams;
  SetCellViewParams(ACell, AdxPSViewParams);
end;

procedure TcxSchedulerReportLink.SetCellViewParams(
  ACell: TdxReportVisualItem; const AParams: TdxReportItemViewParams);
var
  AFont: TFont;
  AHasBitmap: Boolean;
begin
  if not Assigned(ACell) then Exit;
  AFont := TFont.Create;
  try
    AFont.Assign(AParams.NativeParams.Font);
    if not dxPSUtl.dxIsTrueTypeFont(AFont) then
      AFont.Name := Font.Name;
    AFont.Color := ColorToRGB(AParams.NativeParams.TextColor);
    if AParams.FontSize <> 0 then
      AFont.Size := AParams.FontSize;
    AFont.Style := AFont.Style + AParams.FontStyle;
    ACell.FontIndex := AddFontToPool(AFont);
    ACell.Transparent := ACell.Transparent or AParams.Transparent;
    with AParams.NativeParams do
    begin
      AHasBitmap := not OptionsFormatting.SuppressBackgroundBitmaps and
        (Bitmap <> nil) and not Bitmap.Empty;
      if AHasBitmap then
        ACell.BackgroundBitmapIndex := AddBackgroundBitmapToPool(Bitmap);
    end;
    if OptionsFormatting.SuppressContentColoration and not AHasBitmap then
      ACell.Color := clWhite
    else
      ACell.Color := ColorToRGB(AParams.NativeParams.Color);
  finally
    AFont.Free;
  end;
end;

function TcxSchedulerReportLink.AddPageSite(
  const ABounds: TRect): TcxSchedulerReportPageSite;
begin
  Result := TcxSchedulerReportPageSite.Create(ReportCells.Cells);
  Result.BoundsRect := ABounds;
  Result.CellSides := [];
  Result.Transparent := True;
  FPageSites.Add(Result);
  AddVerticalDelimiter(Result);
  AddHorizontalDelimiter(Result);
end;

procedure TcxSchedulerReportLink.BuildStyle;
begin
  FPageSites.Clear;
  if PrintStyles.ActiveStyle <> nil then
    with PrintStyles.ActiveStyle do
    begin
      BeforeBuild;
      RenderInfo.FPageColCount := Byte(PrintStyles.ActiveStyle.Layout) + 1;
      try
        Build;
      finally
        AfterBuild;
      end;
    end;
end;

function TcxSchedulerReportLink.GetActiveStyles: TcxSchedulerReportLinkStyles;
begin
  Result := inherited ActiveStyles as TcxSchedulerReportLinkStyles;
end;

function TcxSchedulerReportLink.GetDesignWindow: TcxfmSchedulerReportLinkDesignWindow;
begin
  Result := inherited DesignWindow as TcxfmSchedulerReportLinkDesignWindow;
end;

function TcxSchedulerReportLink.GetEdgeMode: TdxCellEdgeMode;
const
  EdgeModeMap: array[Boolean] of TdxCellEdgeMode = (cemPattern, cem3DEffects);
begin
  Result := EdgeModeMap[OptionsFormatting.LookAndFeelKind <> lfUltraFlat];
end;

function TcxSchedulerReportLink.GetLookAndFeelItem(Index: Integer): TdxReportVisualItem;
begin
  Result := TdxReportVisualItem(FLookAndFeelItems[Index]);
end;

function TcxSchedulerReportLink.GetLookAndFeelItemCount: Integer;
begin
  Result := FLookAndFeelItems.Count;
end;

function TcxSchedulerReportLink.GetOptionsFormatting: TcxSchedulerReportLinkOptionsFormatting;
begin
  Result := inherited OptionsFormatting as TcxSchedulerReportLinkOptionsFormatting;
end;

function TcxSchedulerReportLink.GetPrintStyles: TcxSchedulerReportLinkPrintStyles;
begin
  Result := FPrintStyles;
end;

function TcxSchedulerReportLink.GetRenderInfo: TcxSchedulerReportLinkRenderInfo;
begin
  Result := TcxSchedulerReportLinkRenderInfo(inherited RenderInfo);
end;

function TcxSchedulerReportLink.GetScheduler: TcxScheduler;
begin
  Result := Component as TcxScheduler;
end;

function TcxSchedulerReportLink.GetStyles: TcxSchedulerReportLinkStyles;
begin
  Result := inherited Styles as TcxSchedulerReportLinkStyles;
end;

procedure TcxSchedulerReportLink.SetOptionsFormatting(Value: TcxSchedulerReportLinkOptionsFormatting);
begin
  inherited OptionsFormatting := Value;
end;

procedure TcxSchedulerReportLink.SetPrintRange(Value: TcxSchedulerReportLinkPrintRange);
begin
  PrintRange.Assign(Value);
end;

procedure TcxSchedulerReportLink.SetPrintStyles(Value: TcxSchedulerReportLinkPrintStyles);
begin
  FPrintStyles.Assign(Value);
end;

procedure TcxSchedulerReportLink.SetStyles(Value: TcxSchedulerReportLinkStyles);
begin
  inherited Styles := Value;
end;

procedure TcxSchedulerReportLink.SetTaskPadReportLink(Value: TBasedxReportLink);
begin
  if (Value <> Self) and (FTaskPadReportLink <> Value) then
  begin
    FTaskPadReportLink := Value;
    if FTaskPadReportLink <> nil then         
      FTaskPadReportLink.FreeNotification(Self);
    LinkModified(True);
  end;
end;

{ TcxSchedulerReportLinkPrintRange }

procedure TcxSchedulerReportLinkPrintRange.Assign(Source: TPersistent);
begin
  if Source is TcxSchedulerReportLinkPrintRange then
    with TcxSchedulerReportLinkPrintRange(Source) do
    begin
      Move(FDatePrint, Self.FDatePrint[0], SizeOf(FDatePrint));
      Move(FTimePrint, Self.FTimePrint[0], SizeOf(FTimePrint));
    end;
  inherited Assign(Source);  
end;

procedure TcxSchedulerReportLinkPrintRange.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FDatePrint[0] := NullDate;
  FDatePrint[1] := NullDate;
  FTimePrint[0] := NullDate;
  FTimePrint[1] := NullDate;
end;
    
function TcxSchedulerReportLinkPrintRange.DefaultDatePrintFrom: TDate;
begin
  if Scheduler <> nil then
    Result := Scheduler.CurrentView.FirstVisibleDate
  else
    Result := Date;
end;

function TcxSchedulerReportLinkPrintRange.DefaultDatePrintTo: TDate;
begin
  if Scheduler <> nil then
    Result := Scheduler.CurrentView.LastVisibleDate
  else
    Result := Date;
end;

function TcxSchedulerReportLinkPrintRange.DefaultTimePrintFrom: TTime;
begin
  if Scheduler <> nil then
    Result := Scheduler.OptionsView.WorkStart
  else
    Result := 0;
end;

function TcxSchedulerReportLinkPrintRange.DefaultTimePrintTo: TTime;
begin
  if Scheduler <> nil then
    Result := Scheduler.OptionsView.WorkFinish
  else
    Result := 0;
end;

procedure TcxSchedulerReportLinkPrintRange.CheckTimeRange;
begin
{  if (PrintTo - PrintFrom) < 0 then
    FPrintTo := DateOf(PrintFrom) + TimeOf(FPrintTo);}
end;

function TcxSchedulerReportLinkPrintRange.GetDateTimeIF(
  const AValue, ADefaultValue: TDateTime): TDateTime;
begin
  Result := AValue;
  if Trunc(Result) = NullDate then
    Result := ADefaultValue;
end;

function TcxSchedulerReportLinkPrintRange.DesignerTabIndex: Integer;
begin
  Result := 0;
end;

function TcxSchedulerReportLinkPrintRange.GetActiveStyle: TcxCustomSchedulerReportLinkPrintStyle;
begin
  Result := ReportLink.PrintStyles.ActiveStyle;
end;

function TcxSchedulerReportLinkPrintRange.GetDayCount: Integer;
begin
  Result := Trunc(PrintTo) - Trunc(PrintFrom) + 1;
  if Result < 1 then
    Result := 1;
end;

function TcxSchedulerReportLinkPrintRange.GetMonthCount: Integer;

  function MonthOfDate(const ADate: TDateTime): Integer;
  var
    Y, M, D: Word;
  begin
    DecodeDate(ADate, Y, M, D);
    Result := Y * 12 + M;
  end;

begin
  Result := MonthOfDate(PrintTo) - MonthOfDate(PrintFrom) + 1;
end;

function TcxSchedulerReportLinkPrintRange.GetPrintDate(AIndex: Integer): TDate;
var
  DefaultDate: TTime;
begin
  if AIndex = 0 then
    DefaultDate := DefaultDatePrintFrom
  else
    DefaultDate := DefaultDatePrintTo;
  Result := GetDateTimeIF(DateOf(FDatePrint[AIndex]), DefaultDate);
end;

function TcxSchedulerReportLinkPrintRange.GetPrintTime(AIndex: Integer): TTime;
var
  DefaultTime: TTime;
begin
  if AIndex = 0 then
    DefaultTime := DefaultTimePrintFrom
  else
    DefaultTime := DefaultTimePrintTo;
  Result := TimeOf(GetDateTimeIF(FTimePrint[AIndex], DefaultTime));
end;

function TcxSchedulerReportLinkPrintRange.GetWeekCount: Integer;
begin                    
  Result := WeeksBetween(StartOfTheWeek(PrintFrom), IncDay(EndOfTheWeek(PrintTo)));
  if Result < 1 then Result := 1;
end;

procedure TcxSchedulerReportLinkPrintRange.SetPrintDate(
  AIndex: Integer; const Value: TDate);
begin
  if FDatePrint[AIndex] <> Value then
  begin
    FDatePrint[AIndex] := Value;
    Changed;
  end;
end;

procedure TcxSchedulerReportLinkPrintRange.SetPrintTime(
  AIndex: Integer; const Value: TTime);
begin
  if FTimePrint[AIndex] <> Value then
  begin
    FTimePrint[AIndex] := Value;
    Changed;
  end;
end;

function TcxSchedulerReportLinkPrintRange.IsDateStored(
  AIndex: Integer): Boolean;
begin
  Result := FDatePrint[AIndex] <> NullDate;
end;

function TcxSchedulerReportLinkPrintRange.IsTimeStored(
  AIndex: Integer): Boolean;
begin
  Result := FTimePrint[AIndex] <> NullDate;
end;

{ TcxSchedulerReportLinkOptionsFormatting }

procedure TcxSchedulerReportLinkOptionsFormatting.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TcxSchedulerReportLinkOptionsFormatting then
    with TcxSchedulerReportLinkOptionsFormatting(Source) do 
    begin
      Self.SuppressContentColoration := SuppressContentColoration;
    end;
end;

procedure TcxSchedulerReportLinkOptionsFormatting.RestoreDefaults;
begin
  inherited;
  SuppressContentColoration := False;
end;

function TcxSchedulerReportLinkOptionsFormatting.DesignerTabIndex: Integer;
begin
  Result := 2;
end;

function TcxSchedulerReportLinkOptionsFormatting.GetReportLink: TcxSchedulerReportLink;
begin
  Result := inherited ReportLink as TcxSchedulerReportLink;
end;

procedure TcxSchedulerReportLinkOptionsFormatting.SetSuppressContentColoration(Value: Boolean);
begin
  if FSuppressContentColoration <> Value then
  begin
    FSuppressContentColoration := Value;
    Changed;
  end;
end;

{ TcxCustomSchedulerReportLinkOptions }

function TcxCustomSchedulerReportLinkOptions.GetReportLink: TcxSchedulerReportLink;
begin
  Result := inherited ReportLink as TcxSchedulerReportLink;
end;

function TcxCustomSchedulerReportLinkOptions.GetScheduler: TcxScheduler;
begin
  if ReportLink <> nil then
    Result := ReportLink.Scheduler
  else
    Result := nil;
end;

{ TcxSchedulerReportLinkStyles }

constructor TcxSchedulerReportLinkStyles.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  BitmapInViewParams := True;
end;

procedure TcxSchedulerReportLinkStyles.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TcxSchedulerReportLinkStyles then
    with TcxSchedulerReportLinkStyles(Source) do
    begin
      Self.SchedulerHeader := SchedulerHeader;
      Self.Content := Content;
      Self.DateNavigatorContent := DateNavigatorContent;
      Self.DateNavigatorHeader := DateNavigatorHeader;
      Self.DayHeader := DayHeader;
      Self.Event := Event;
      Self.ResourceHeader := ResourceHeader;
      Self.NotesAreaBlank := NotesAreaBlank;
      Self.NotesAreaLined := NotesAreaLined;
      Self.TaskPad := TaskPad;
      Self.TimeRuler := TimeRuler;
    end;
end;

function TcxSchedulerReportLinkStyles.GetSchedulerHeaderParams: TcxViewParams;
begin
  GetViewParams(vspsSchedulerSchedulerHeader, nil, nil, Result);
end;

function TcxSchedulerReportLinkStyles.GetContentParams(const ADateTime: TDateTime;
  AResource: TcxSchedulerStorageResourceItem): TcxViewParams;
begin
  if UseSchedulerStyles then
    Result := ExtStyles.GetContentParams(ADateTime, AResource)
  else
    GetViewParams(vspsSchedulerContent, nil, nil, Result);
end;

function TcxSchedulerReportLinkStyles.GetContentParams(const ADateTime: TDateTime;
  ALightColor: Boolean; AResource: TcxSchedulerStorageResourceItem): TcxViewParams;
begin
  if UseSchedulerStyles then
    Result := ExtStyles.GetContentParams(ADateTime, ALightColor, AResource)
  else
    GetViewParams(vspsSchedulerContent, nil, nil, Result)
end;

function TcxSchedulerReportLinkStyles.GetDateNavigatorContentParams: TcxViewParams;
begin
  if UseSchedulerStyles then
  begin
    Result := TcxSchedulerDateNavigator(
      ExtStyles.Scheduler.DateNavigator).Styles.GetContentParams
  end
  else
    GetViewParams(vspsSchedulerDateNavigatorContent, nil, nil, Result);
end;

function TcxSchedulerReportLinkStyles.GetDateNavigatorHeaderParams: TcxViewParams;
begin
  if UseSchedulerStyles then
  begin
    Result := TcxSchedulerDateNavigator(
      ExtStyles.Scheduler.DateNavigator).Styles.GetHeaderParams
  end
  else
    GetViewParams(vspsSchedulerDateNavigatorHeader, nil, nil, Result);
end;

function TcxSchedulerReportLinkStyles.GetDayHeaderParams(
  const ADateTime: TDateTime): TcxViewParams;
begin
  if UseSchedulerStyles then
    Result := ExtStyles.GetDayHeaderParams(ADateTime)
  else
    GetViewParams(vspsSchedulerDayHeader, nil, nil, Result);
end;

function TcxSchedulerReportLinkStyles.GetEventParams(
  AEvent: TcxSchedulerEvent): TcxViewParams;
begin
  if UseSchedulerStyles then
    Result := ExtStyles.GetEventContentParams(AEvent)
  else
    GetViewParams(vspsSchedulerEvent, nil, nil, Result);
end;

function TcxSchedulerReportLinkStyles.GetNotesAreaBlankParams: TcxViewParams;
begin
  GetViewParams(vspsSchedulerNotesAreaBlank, nil, nil, Result);
end;

function TcxSchedulerReportLinkStyles.GetNotesAreaLinedParams: TcxViewParams;
begin
  GetViewParams(vspsSchedulerNotesAreaLined, nil, nil, Result);
end;

function TcxSchedulerReportLinkStyles.GetResourceHeaderParams(
  AResource: TcxSchedulerStorageResourceItem): TcxViewParams;
begin
  if UseSchedulerStyles then
    Result := ExtStyles.GetResourceHeaderParams(AResource)
  else
    GetViewParams(vspsSchedulerResourceHeader, nil, nil, Result);
end;

function TcxSchedulerReportLinkStyles.GetTaskPadParams: TcxViewParams;
begin
  GetViewParams(vspsSchedulerTaskPad, nil, nil, Result);
end;

function TcxSchedulerReportLinkStyles.GetTimeRulerParams: TcxViewParams;
begin
  if UseSchedulerStyles then
    Result := ReportLink.Scheduler.ViewDay.Styles.GetTimeRulerParams
  else
    GetViewParams(vspsSchedulerTimeRuler, nil, nil, Result);
end;

function TcxSchedulerReportLinkStyles.DesignerTabIndex: Integer;
begin
  Result := 3;
end;

procedure TcxSchedulerReportLinkStyles.GetDefaultViewParams(Index: Integer;
  AData: TObject; out AParams: TcxViewParams);
const
  FixedParts = [vspsSchedulerDayHeader, vspsSchedulerResourceHeader, vspsSchedulerTimeRuler];
begin
  inherited;
  if ReportLink <> nil then
    with AParams do
    begin
      if Index in FixedParts then
        Color := dxPSCore.dxDefaultFixedColor
      else
        Color := dxDefaultContentColor;
      Font := ReportLink.Font;
      TextColor := Font.Color;
    end;
end;

class function TcxSchedulerReportLinkStyles.GetStyleCaption(AnIndex: Integer): string;
begin
  case AnIndex of
    vspsSchedulerSchedulerHeader:
      Result := cxGetResourceString(@sdxSchedulerSchedulerHeader);
    vspsSchedulerContent:
      Result := cxGetResourceString(@sdxSchedulerContent);
    vspsSchedulerDateNavigatorContent:
      Result := cxGetResourceString(@sdxSchedulerDateNavigatorContent);
    vspsSchedulerDateNavigatorHeader:
      Result := cxGetResourceString(@sdxSchedulerDateNavigatorHeader);
    vspsSchedulerDayHeader:
      Result := cxGetResourceString(@sdxSchedulerDayHeader);
    vspsSchedulerEvent:
      Result := cxGetResourceString(@sdxSchedulerEvent);
    vspsSchedulerResourceHeader:
      Result := cxGetResourceString(@sdxSchedulerResourceHeader);
    vspsSchedulerNotesAreaBlank:
      Result := cxGetResourceString(@sdxSchedulerNotesAreaBlank);
    vspsSchedulerNotesAreaLined:
      Result := cxGetResourceString(@sdxSchedulerNotesAreaLined);
    vspsSchedulerTaskPad:
      Result := cxGetResourceString(@sdxSchedulerTaskPad);
  else {vspsSchedulerTimeRuler}
    Result := cxGetResourceString(@sdxSchedulerTimeRuler);
  end;  
end;

function TcxSchedulerReportLinkStyles.GetStyleIndexByCaption(const Caption: string): Integer;
begin
  for Result := vspsSchedulerFirst to vspsSchedulerLast do
    if dxPSUtl.dxSameText(Caption, GetStyleCaption(Result)) then 
      Exit;
  Result := -1;
end;

// IcxSchedulerStylesAdapter
function TcxSchedulerReportLinkStyles.GetDayHeaderStyle: TcxStyle;
begin
  if UseSchedulerStyles then
    Result := ExtStyles.DayHeader
  else
    Result := DayHeader;
end;

function TcxSchedulerReportLinkStyles.GetResourceHeaderStyle: TcxStyle;
begin
  if UseSchedulerStyles then
    Result := ExtStyles.ResourceHeader
  else
    Result := ResourceHeader;
end;

function TcxSchedulerReportLinkStyles.GetExtStyles: TcxSchedulerStyles;
begin
  Result := ReportLink.Scheduler.Styles;
end;

function TcxSchedulerReportLinkStyles.GetReportLink: TcxSchedulerReportLink;
begin
  Result := inherited ReportLink as TcxSchedulerReportLink;
  if Result = nil then
    Result := FReportLink;
end;

function TcxSchedulerReportLinkStyles.GetUseSchedulerStyles: Boolean;
begin
  if ReportLink = nil then
  begin
    Result := False;
    Exit;
  end;
  Result := not ReportLink.OptionsFormatting.UseNativeStyles;
  if not Result then 
    Result := (ReportLink = nil) or (ReportLink.Scheduler = nil);
end;

{ TcxSchedulerReportLinkStyleSheet }

class function TcxSchedulerReportLinkStyleSheet.GetStylesClass: TcxCustomStylesClass;
begin
  Result := TcxSchedulerReportLinkStyles;
end;

function TcxSchedulerReportLinkStyleSheet.GetStylesValue: TcxSchedulerReportLinkStyles;
begin
  if GetStyles is TcxSchedulerReportLinkStyles then
    Result := TcxSchedulerReportLinkStyles(GetStyles)
  else
    Result := nil;
end;

procedure TcxSchedulerReportLinkStyleSheet.SetStylesValue(Value: TcxSchedulerReportLinkStyles);
begin
  SetStyles(Value);
end;

{ TcxSchedulerReportLinkPrintStyles }

procedure TcxSchedulerReportLinkPrintStyles.Assign(Source: TPersistent);
var
  I: Integer;
begin
  if Source is TcxSchedulerReportLinkPrintStyles then
    for I := 0 to Count - 1 do 
      Items[I] := TcxSchedulerReportLinkPrintStyles(Source).Items[I];
  inherited;
end;

procedure TcxSchedulerReportLinkPrintStyles.RestoreDefaults;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].RestoreDefaults;
  inherited;
end;

function TcxSchedulerReportLinkPrintStyles.GetStyleByClass(
  AClass: TcxCustomSchedulerReportLinkPrintStyleClass): TcxCustomSchedulerReportLinkPrintStyle;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := Items[I];
    if Result.ClassType = AClass then Exit;
  end;
  Result := nil;
end;

function TcxSchedulerReportLinkPrintStyles.GetCorrespondingStyle: TcxCustomSchedulerReportLinkPrintStyle;
begin
  Result := nil;
  if Scheduler = nil then Exit;
  Result := GetStyleByView(Scheduler.CurrentView)
end;

function TcxSchedulerReportLinkPrintStyles.GetStyleByName(
  const Name: string): TcxCustomSchedulerReportLinkPrintStyle;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := Items[I];
    if CompareText(Result.Caption, Name) = 0 then Exit;
  end;
  Result := nil;
end;

function TcxSchedulerReportLinkPrintStyles.GetStyleByView(
  View: TcxSchedulerCustomView): TcxCustomSchedulerReportLinkPrintStyle;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := Items[I];
    if Result.IsCompatibleWith(View) then Exit;
  end;
  Result := nil;
end;

function TcxSchedulerReportLinkPrintStyles.IndexOf(AItem: TcxCustomSchedulerReportLinkPrintStyle): Integer;
begin
  Result := FItems.IndexOf(AItem);
end;

procedure TcxSchedulerReportLinkPrintStyles.CreateObjects;
begin
  inherited CreateObjects;
  FItems := TList.Create;
  CreateStyles;
end;

procedure TcxSchedulerReportLinkPrintStyles.DestroyObjects;
begin
  DestroyStyles;
  FreeAndNil(FItems);
  inherited DestroyObjects;
end;

function TcxSchedulerReportLinkPrintStyles.DesignerTabIndex: Integer;
begin
  Result := 1;
end;
 
function TcxSchedulerReportLinkPrintStyles.CreateStyle(
  AStyleClass: TcxCustomSchedulerReportLinkPrintStyleClass): TcxCustomSchedulerReportLinkPrintStyle;
begin
  Result := AStyleClass.Create(Self);
  FItems.Add(Result);
end;

procedure TcxSchedulerReportLinkPrintStyles.CreateStyles;
begin
  CreateStyle(TcxSchedulerReportLinkDailyPrintStyle);
  CreateStyle(TcxSchedulerReportLinkWeeklyPrintStyle);
  CreateStyle(TcxSchedulerReportLinkMonthlyPrintStyle);
  CreateStyle(TcxSchedulerReportLinkTrifoldPrintStyle);
  CreateStyle(TcxSchedulerReportLinkDetailsPrintStyle);
  CreateStyle(TcxSchedulerReportLinkMemoPrintStyle);
end;

procedure TcxSchedulerReportLinkPrintStyles.DestroyStyles;
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do
    Items[I].Free;
  FItems.Clear;
end;

procedure TcxSchedulerReportLinkPrintStyles.GetStyleByClassEx(
  AClass: TcxCustomSchedulerReportLinkPrintStyleClass; var AInstance);
begin
  TPersistent(AInstance) := GetStyleByClass(AClass);
end;

procedure TcxSchedulerReportLinkPrintStyles.SetActiveStyleEx(
  Value: TcxCustomSchedulerReportLinkPrintStyle);
begin
  if (ActiveStyle <> Value) or ActiveStyleAssigned then
  begin
    FActiveStyle := Value;
    ActiveStyleAssigned := False;
  end;
end;

procedure TcxSchedulerReportLinkPrintStyles.ActiveStyleChanged;
begin
  if ReportLink <> nil then
    ReportLink.ActivePrintStyleChanged;
end;

procedure TcxSchedulerReportLinkPrintStyles.StyleChanged(AStyle: TcxCustomSchedulerReportLinkPrintStyle);
begin
  Changed;
end;

function TcxSchedulerReportLinkPrintStyles.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxSchedulerReportLinkPrintStyles.GetItem(
  Index: Integer): TcxCustomSchedulerReportLinkPrintStyle;
begin
  Result := TcxCustomSchedulerReportLinkPrintStyle(FItems[Index]);
end;

function TcxSchedulerReportLinkPrintStyles.GetStyleDaily: TcxSchedulerReportLinkDailyPrintStyle;
begin
  GetStyleByClassEx(TcxSchedulerReportLinkDailyPrintStyle, Result);
end;

function TcxSchedulerReportLinkPrintStyles.GetStyleDetails: TcxSchedulerReportLinkDetailsPrintStyle;
begin
  GetStyleByClassEx(TcxSchedulerReportLinkDetailsPrintStyle, Result);
end;

function TcxSchedulerReportLinkPrintStyles.GetStyleMemo: TcxSchedulerReportLinkMemoPrintStyle;
begin
  GetStyleByClassEx(TcxSchedulerReportLinkMemoPrintStyle, Result);
end;

function TcxSchedulerReportLinkPrintStyles.GetStyleMonthly: TcxSchedulerReportLinkMonthlyPrintStyle;
begin
  GetStyleByClassEx(TcxSchedulerReportLinkMonthlyPrintStyle, Result);
end;

function TcxSchedulerReportLinkPrintStyles.GetStyleTrifold: TcxSchedulerReportLinkTrifoldPrintStyle;
begin
  GetStyleByClassEx(TcxSchedulerReportLinkTrifoldPrintStyle, Result);
end;

function TcxSchedulerReportLinkPrintStyles.GetStyleWeekly: TcxSchedulerReportLinkWeeklyPrintStyle;
begin
  GetStyleByClassEx(TcxSchedulerReportLinkWeeklyPrintStyle, Result);
end;

procedure TcxSchedulerReportLinkPrintStyles.SetActiveStyle(
  Value: TcxCustomSchedulerReportLinkPrintStyle);
begin
  if (FActiveStyle <> Value) or not FActiveStyleAssigned then
  begin
    FActiveStyle := Value;
    FActiveStyleAssigned := Value <> nil;
    ActiveStyleChanged;
    DesignerModified;
  end;
end;

procedure TcxSchedulerReportLinkPrintStyles.SetActiveStyleAssigned(
  Value: Boolean);
begin
  if FActiveStyleAssigned <> Value then
  begin
    FActiveStyleAssigned := Value;
    DesignerModified;
  end;
end;

procedure TcxSchedulerReportLinkPrintStyles.SetItem(Index: Integer;
  Value: TcxCustomSchedulerReportLinkPrintStyle);
begin
  Items[Index].Assign(Value);
end;

procedure TcxSchedulerReportLinkPrintStyles.SetStyleDaily(
  Value: TcxSchedulerReportLinkDailyPrintStyle);
begin
  Daily.Assign(Value);
end;

procedure TcxSchedulerReportLinkPrintStyles.SetStyleDetails(
  Value: TcxSchedulerReportLinkDetailsPrintStyle);
begin
  GetStyleDetails.Assign(Value);
end;

procedure TcxSchedulerReportLinkPrintStyles.SetStyleMemo(
  Value: TcxSchedulerReportLinkMemoPrintStyle);
begin
  GetStyleMemo.Assign(Value);
end;

procedure TcxSchedulerReportLinkPrintStyles.SetStyleMonthly(
  Value: TcxSchedulerReportLinkMonthlyPrintStyle);
begin
  Monthly.Assign(Value);
end;

procedure TcxSchedulerReportLinkPrintStyles.SetStyleTrifold(
  Value: TcxSchedulerReportLinkTrifoldPrintStyle);
begin
  GetStyleTrifold.Assign(Value);
end;

procedure TcxSchedulerReportLinkPrintStyles.SetStyleWeekly(
  Value: TcxSchedulerReportLinkWeeklyPrintStyle);
begin
  Weekly.Assign(Value);
end;

{ TcxCustomSchedulerReportLinkPrintStyle }

constructor TcxCustomSchedulerReportLinkPrintStyle.Create(AStyles: TcxSchedulerReportLinkPrintStyles);
begin
  inherited Create;
  FStyles := AStyles;
  FCaption := DefaultCaption;
  CreateObjects;
  RestoreDefaults;
end;

destructor TcxCustomSchedulerReportLinkPrintStyle.Destroy;
begin
  Active := False;
  DestroyObjects;
  inherited Destroy;
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.Assign(Source: TPersistent);
var
  ASource: TcxCustomSchedulerReportLinkPrintStyle;
begin
  if Source is TcxCustomSchedulerReportLinkPrintStyle then
  begin
    ASource := TcxCustomSchedulerReportLinkPrintStyle(Source);
    Caption := ASource.Caption;
    CompressWeekends := ASource.CompressWeekends;
    DontPrintWeekends := ASource.DontPrintWeekends;
    Layout := ASource.Layout;
    ResourceCountPerPage := ASource.ResourceCountPerPage;
    ShowNotesAreaBlank := ASource.ShowNotesAreaBlank;
    ShowNotesAreaLined := ASource.ShowNotesAreaLined;
    ShowTaskPad := ASource.ShowTaskPad;
    if SupportTimeRange then
    begin
      TimePrintFrom := ASource.TimePrintFrom;
      TimePrintTo := ASource.TimePrintTo;
    end;
  end
  else
    inherited;
end;

function TcxCustomSchedulerReportLinkPrintStyle.DefaultCaption: string;
begin
  Result := '';
end;

function TcxCustomSchedulerReportLinkPrintStyle.IsCompatibleWith(AView: TcxSchedulerCustomView): Boolean;
begin
  Result := False;
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.RestoreDefaults;
begin
  FCaption := DefaultCaption;
  FCompressWeekends := True;
  FDontPrintWeekends := False;
  FLayout := pslOnePage;
  ResourceCountPerPage := 0;
  ShowNotesAreaBlank := False;
  ShowNotesAreaLined := False;
  ShowTaskPad := False;
  if SupportTimeRange and (Scheduler <> nil) then
  begin
    TimePrintFrom :=  TimeOf(Scheduler.OptionsView.WorkStart);
    TimePrintTo := TimeOf(Scheduler.OptionsView.WorkFinish);
  end;
end;

// IdxReportLinkController
function TcxCustomSchedulerReportLinkPrintStyle.GetControlSiteBounds(AControl: TControl): TRect;
begin
  Result := NullRect;
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.Build;
begin
  FBoldedDays := TcxSchedulerDateList.Create;
  try
    if Storage <> nil then
    begin
      Events.SelStart := PrintRange.PrintFrom - 30;
      Events.SelFinish := PrintRange.PrintTo + 30;
      Storage.GetEvents(Events, Events.SelStart, Events.SelFinish);
    end;
    Events.ExtractUsedDays(FBoldedDays);
    PrepareEvents;
    BuildPages;
    Events.Clear;
    UsedDays.Clear;
  finally
    FreeAndNil(FBoldedDays);
  end;
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.BuildPages;
var
  I: Integer;
begin
  for I := 0 to PeriodCount - 1 do
  begin
    CreateLayoutForPeriod(I);
    Progress(100 * (I + 1) / PeriodCount);
    if ReportLink.AbortBuilding or ReportLink.LinkInPreviewMode then Break;
  end;
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.BuildSchedulerCells(
  ASite: TcxSchedulerReportSchedulingAreaCell);
var
  APageIndex, APeriodIndex, ASubIndex: Integer;
begin
  APageIndex := ASite.PageIndex;
  GetPagePeriodAndIndex(APageIndex, APeriodIndex, ASubIndex);
  FillDatesForPage(ASite.VisibleDays, APageIndex, APeriodIndex, ASubIndex);
  with CreateSchedulingCellsProducer(ASite) do
  try
    Produce;
  finally
    Free;
  end;
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.PrepareEvents;
var
  I: Integer;
  AEvent: TcxSchedulerEvent;
  AllowPrint: Boolean; 
begin
  for I := 0 to FEvents.AbsoluteCount - 1 do
  begin
    AEvent := FEvents.AbsoluteItems[I];
    AllowPrint := True;
    DoCanPrintEvent(AEvent, AllowPrint);
    if not AllowPrint then
      FEvents.Remove(AEvent);
  end;
  FEvents.Sort(TcxCompareEventsProc(@cxCompareSchedulerControlEvents));
  TcxSchedulerCachedEventListAccess(FEvents).Changed;
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.DoCanPrintEvent(
  AEvent: TcxSchedulerEvent; var AllowPrint: Boolean);
begin
  ReportLink.DoCanPrintEvent(AEvent, AllowPrint);
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.Progress(APercentDone: Double);
begin
  if ReportLink <> nil then
    ReportLink.DoProgress(APercentDone);
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.AfterBuild;
begin
  VisualStyles.FReportLink := nil;
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.BeforeBuild;
begin
  VisualStyles.FReportLink := ReportLink;
  CurrentDate := PrintRange.PrintFrom;
  FPagesPerPeriod := GetPagesPerPeriod;
end;

function TcxCustomSchedulerReportLinkPrintStyle.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TcxCustomSchedulerReportLinkPrintStyle._AddRef: Integer;
begin
  Result := 1;
end;

function TcxCustomSchedulerReportLinkPrintStyle._Release: Integer;
begin
  Result := 1;
end;

function TcxCustomSchedulerReportLinkPrintStyle.IdxPSCellParams_GetAutoHeight: Boolean;
begin 
  Result := False;
end;

function TcxCustomSchedulerReportLinkPrintStyle.IdxPSCellParams_GetDC: HDC;
begin
  Result := ReportLink.Renderer.DC;
end;

function TcxCustomSchedulerReportLinkPrintStyle.IdxPSCellParams_GetDisplayGraphicsAsText: Boolean;
begin 
  Result := ReportLink.OptionsRefinements.DisplayGraphicsAsText;
end;

function TcxCustomSchedulerReportLinkPrintStyle.IdxPSCellParams_GetEndEllipsis: Boolean;
begin 
  Result := False;
end;

function TcxCustomSchedulerReportLinkPrintStyle.IdxPSCellParams_GetFlatCheckMarks: Boolean;
begin 
  Result := ReportLink.OptionsRefinements.FlatCheckMarks;
end;

function TcxCustomSchedulerReportLinkPrintStyle.IdxPSCellParams_GetGraphicsText: string;
begin 
  Result := ReportLink.OptionsRefinements.GraphicsText;
end;

function TcxCustomSchedulerReportLinkPrintStyle.IdxPSCellParams_GetMultiline: Boolean;
begin
  Result := True;
end;

function TcxCustomSchedulerReportLinkPrintStyle.IdxPSCellParams_GetTransparentGraphics: Boolean;
begin 
  Result := ReportLink.OptionsRefinements.TransparentGraphics;
end;

function TcxCustomSchedulerReportLinkPrintStyle.IdxPSCellParams2_GetPreviewMarginLeft: Integer;
begin
  Result := 2;
end;

function TcxCustomSchedulerReportLinkPrintStyle.IdxPSCellParams2_GetPreviewMarginRight: Integer;
begin
  Result := 2;
end;

function TcxCustomSchedulerReportLinkPrintStyle.IdxPSCellParams2_GetPreviewMaxHeight: Integer;
begin
  Result := -1;
end;

function TcxCustomSchedulerReportLinkPrintStyle.IdxPSCellParams2_GetPreviewMaxLineCount: Integer;
begin
  Result := -1;
end;

function TcxCustomSchedulerReportLinkPrintStyle.IdxPSCellParams2_GetRichEditGraphicClass: TGraphicClass;
const
  GraphicClasses: array[Boolean] of TGraphicClass = (TMetafile, TBitmap);
begin
  Result := GraphicClasses[IdxPSCellParams2_GetRichEditTransparent];
end;

function TcxCustomSchedulerReportLinkPrintStyle.IdxPSCellParams2_GetRichEditTransparent: Boolean;
begin
  Result := ReportLink.OptionsRefinements.TransparentRichEdits;
end;

function TcxCustomSchedulerReportLinkPrintStyle.AddPageSite(
  const ABounds: TRect): TcxSchedulerReportPageSite;
begin
  Result := ReportLink.AddPageSite(ABounds);
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.Changed;
begin
  if Styles <> nil then Styles.StyleChanged(Self);
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.CreateObjects;
begin
  FUsedDays := TcxSchedulerDateList.Create;
  FEvents := TcxSchedulerCachedEventList.Create;
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.DestroyObjects;
begin
  FEvents.Free;
  FUsedDays.Free;
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetPageCount: Integer;
begin
  Result := 0;
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetRebuildOnPageParamsChange(
  AnUpdateCodes: TdxPrinterPageUpdateCodes): Boolean;
begin
  Result := True;
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetActualDatePrintFrom: TDate;
begin
  if PrintRange <> nil then
    Result := PrintRange.PrintFrom
  else
    Result := 0;  
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetActualDatePrintTo: TDate;
begin
  if PrintRange <> nil then
    Result := PrintRange.PrintTo
  else
    Result := 0;  
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetCorrespondedView: TcxSchedulerCustomResourceView;
begin
  Result := nil;
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetPagesPerPeriod: Integer;
begin
  Result := 1;
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetGlyphIndex: Integer;
begin
  Result := -1;
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetPreviewGlyphIndex: Integer;
begin
  Result := GetGlyphIndex;
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetSchedulerHeaderParams: TdxReportItemViewParams;
begin
  FillChar(Result, SizeOf(Result), 0);
  Result.NativeParams := VisualStyles.GetSchedulerHeaderParams;
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.DrawDesignWindowPreview(ACanvas: TCanvas; const ABounds: TRect);
var
  ALeft, ATop: Integer;
begin
  with ABounds do
  begin
    ALeft := (Left + Right - StylePreviewImages.Width) div 2;
    ATop :=  (Top + Bottom - StylePreviewImages.Height) div 2;
  end;
  StylePreviewImages.Draw(ACanvas, ALeft, ATop, PreviewGlyphIndex);
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetResourcePageCount: Integer;
begin
  Result := ResourceCountPerPage;
  if Result = 0 then
    Result := 1
  else
    if ResourceCount > 0 then
    begin
      Result := ResourceCount div ResourceCountPerPage +
        Byte(ResourceCount mod ResourceCountPerPage > 0);
    end;
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetShowDateNavigator(
  APageIndex: Integer): Boolean;
begin
  Result := True;
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetShowNotesAreaBlank: Boolean;
begin
  Result := FShowNotesAreaBlank;
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.SetBoolOption(
  var AOption: Boolean; Value: Boolean);
begin
  if AOption <> Value then
  begin
    AOption := Value;
    Changed;
  end;
end;

function TcxCustomSchedulerReportLinkPrintStyle.SupportTimeRange: Boolean;
begin
  Result := False;
end;

function TcxCustomSchedulerReportLinkPrintStyle.SupportIcons: Boolean;
begin
  Result := False;
end;

function TcxCustomSchedulerReportLinkPrintStyle.SupportMessage: Boolean;
begin
  Result := False;
end;

// report cells creation

function TcxCustomSchedulerReportLinkPrintStyle.CreateSchedulingAreaCell(
  ASite: TdxReportCell): TcxSchedulerReportSchedulingAreaCell;
begin
  Result := TcxSchedulerReportSchedulingAreaCell.Create(ASite);
end;

function TcxCustomSchedulerReportLinkPrintStyle.CreateSchedulingCellsProducer(
  ASite: TcxSchedulerReportSchedulingAreaCell): TcxSchedulerReportCommonCellsProducer;
begin
  Result := TcxSchedulerReportCommonCellsProducer.CreateEx(Self, ASite);
end;

function TcxCustomSchedulerReportLinkPrintStyle.CreateDateNavigatorCell(
  ASite: TdxReportCell; AYear, AMonth: Word): TcxSchedulerReportDateNavigatorCell;
begin
  with Scheduler.DateNavigator do
  begin
    Result := TcxSchedulerReportDateNavigatorCell.CreateEx(ASite,
      ActualFirstWeekOfYear, AYear, AMonth, ShowDatesContainingEventsInBold, ShowWeekNumbers);
    Result.FBoldedDays := Self.FBoldedDays;
  end;
end;

function TcxCustomSchedulerReportLinkPrintStyle.CreateHeaderCell(
  ASite: TdxReportCell): TcxSchedulerReportSchedulerHeaderCell;
begin
  Result := TcxSchedulerReportSchedulerHeaderCell.Create(ASite);
end;

function TcxCustomSchedulerReportLinkPrintStyle.CreateNotesCell(
  ASite: TdxReportCell): TcxSchedulerReportNotesAreaCell;
begin
  Result := TcxSchedulerReportNotesAreaCell.CreateEx(ASite, False);
end;

function TcxCustomSchedulerReportLinkPrintStyle.CreateNotesLinedCell(
  ASite: TdxReportCell): TcxSchedulerReportNotesAreaCell;
begin
  Result := TcxSchedulerReportNotesAreaCell.CreateEx(ASite, True);
end;

function TcxCustomSchedulerReportLinkPrintStyle.CreateTaskPadCell(
  ASite: TdxReportCell): TcxSchedulerReportTaskPadCell;
begin
  Result := TcxSchedulerReportTaskPadCell.CreateEx(ASite, False);
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.InitHeaderCell(
  ACell: TcxSchedulerReportSchedulerHeaderCell);
begin
  ReportLink.SetCellViewParams(ACell, GetSchedulerHeaderParams);
  ReportLink.SetCellViewParams(ACell.Content, GetSchedulerHeaderParams);
end;

function TcxCustomSchedulerReportLinkPrintStyle.InitReportCell(
  ACell: TdxReportCell; const ABounds: TRect): TdxReportCell;

  procedure InitAdditionalAreaCell(const AViewParams: TcxViewParams);
  begin
    ReportLink.SetCellViewParams(ACell, AViewParams);
    ReportLink.SetCellViewParams(TcxSchedulerReportNotesAreaCell(
      ACell).DataCell, AViewParams);
  end;

begin
  ACell.BoundsRect := ABounds;
  Result := ACell;
  if ReportLink = nil then Exit;
  ACell.Transparent := not ReportLink.OptionsFormatting.UseNativeStyles;
  if ACell is TcxSchedulerReportPageItemCell then
  begin
    case TcxSchedulerReportPageItemCell(ACell).GetType of
      srSchedulingArea:
      begin
        BuildSchedulerCells(TcxSchedulerReportSchedulingAreaCell(ACell));
        ReportLink.DoInitializeSchedulingAreaCell(
          TcxSchedulerReportSchedulingAreaCell(ACell));
      end;
      srHeader:
        InitHeaderCell(TcxSchedulerReportSchedulerHeaderCell(ACell));
      srNotesBlank:
      begin
        InitAdditionalAreaCell(VisualStyles.GetNotesAreaBlankParams);
        ReportLink.DoInitializeNotesAreaCell(
          TcxSchedulerReportNotesAreaCell(ACell));
      end;
      srNotesLined:
      begin
        InitAdditionalAreaCell(VisualStyles.GetNotesAreaLinedParams);
        ReportLink.DoInitializeNotesAreaCell(
          TcxSchedulerReportNotesAreaCell(ACell));
      end;
      srTaskPad:
      begin
        InitAdditionalAreaCell(VisualStyles.GetTaskPadParams);
        ReportLink.InitializeTaskPadCell(
          TcxSchedulerReportTaskPadCell(ACell));
      end;
    end;
  end;
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.CorrectBoundsWithHeader(
  AHeader: TcxSchedulerReportSchedulerHeaderCell; var ABounds: TRect);
begin
  if not AHeader.Visible then
    ABounds.Top := 0
  else
    ABounds.Top := AHeader.BoundsRect.Bottom + InterAreaSpace;
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.CreateAdditionalControls(
  ASite: TdxReportCell; AHasCalendar, AHasTaskPad, AHasNotes,
  AHasNotesLined, ARightSide: Boolean; var ABounds: TRect);
var
  R: array[0..2] of TRect;
  C: Integer;

  function GetAreaBounds(AllowShow: Boolean;
    var ABounds: TRect; var AIndex: Integer): Boolean;
  begin
    Result := AllowShow;
    if not Result then Exit;
    ABounds := R[AIndex];
    Inc(AIndex);
  end;

  procedure CreateCells;
  var
    AIndex: Integer;
    ABounds: TRect;
  begin
    AIndex := 0;
    if GetAreaBounds(AHasTaskPad, ABounds, AIndex) then
      InitReportCell(CreateTaskPadCell(ASite), ABounds);
    if GetAreaBounds(AHasNotes, ABounds, AIndex) then
      InitReportCell(CreateNotesCell(ASite), ABounds);
    if GetAreaBounds(AHasNotesLined, ABounds, AIndex) then
      InitReportCell(CreateNotesLinedCell(ASite), ABounds);
  end;

begin
  C := Byte(AHasTaskPad) + Byte(AHasNotes) + Byte(AHasNotesLined);
  if C = 0 then Exit;
  SplitToRects(ABounds, AHasCalendar, ARightSide, ABounds, R[0]);
  if C = 2 then
    Rect2RectsVert(R[0], R[0], R[1])
  else
    if C = 3 then
    begin
      if AHasCalendar then
        Rect2RectsVert(R[0], R[0], R[1], R[2])
      else
      begin
        Rect2RectsVert(R[0], R[1], R[0]);
        Rect2RectsHorz(R[1], R[1], R[2]);
      end;
    end;
  CreateCells;
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.CreateControlsOnFirstPage(
  APageIndex: Integer; ASite, AHeader: TdxReportCell; ABounds: TRect);
begin
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.CreateControlsOnSecondPage(
  APageIndex: Integer; ASite, AHeader: TdxReportCell; ABounds: TRect);
begin
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.CreateHeaderDateNavigator(
  AHeader: TcxSchedulerReportSchedulerHeaderCell; APageIndex: Integer; out ABounds: TRect);
var
  R: TRect;
  Y, M, D: Word;
  AHeight, H, ALeft: Integer;
  CP, HP: TdxReportItemViewParams;
  ACell: TcxSchedulerReportDateNavigatorCell;
begin
  FillChar(CP, SizeOf(CP), 0);
  FillChar(HP, SizeOf(HP), 0);
  AHeight := ABounds.Bottom - ABounds.Top;
  CP.NativeParams := VisualStyles.GetDateNavigatorContentParams;
  HP.NativeParams := VisualStyles.GetDateNavigatorHeaderParams;
  HP.Transparent := not ReportLink.OptionsFormatting.UseNativeStyles;
  GetPageDateNavigatorInfo(APageIndex, Y, M);
  ACell := CreateDateNavigatorCell(AHeader, Y, M);
  H := ACell.MeasureDateNavigatorHeight(CP.NativeParams, HP.NativeParams);
  if H > AHeight then
    ACell.AdjustSize(CP, HP, H, AHeight);
  R.TopLeft := Point(0, 0);
  R.BottomRight := TPoint(ACell.CalculateSize(CP, HP));
  OffsetRect(R, ABounds.Right - ABounds.Left - R.Right, 0);
  InflateRect(R, 0, -3);
  ACell.BoundsRect := R;
  ALeft := R.Left;
  if PrintRange.MonthCount > 1 then
  begin
     IncAMonth(Y, M, D);
     ACell.BoundsRect := cxRectSetRight(R, R.Left);
     ALeft := R.Left - (R.Right - R.Left);
     ACell := CreateDateNavigatorCell(AHeader, Y, M);
     if H > AHeight then
       ACell.AdjustSize(CP, HP, H, AHeight);
     ACell.CalculateSize(CP, HP);
     ACell.BoundsRect := R;
  end;
  AHeader.Content.BoundsRect := MakeRect(ABounds.Left + cxTextOffset,
    ABounds.Top + cxTextOffset,  ALeft, ABounds.Bottom - cxTextOffset);
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.CreateLayoutForPeriod(
  APeriodIndex: Integer);
var
  APageIndex: Integer;
  R: TRect;
  APage: TcxSchedulerReportPageSite;
  AHeader: TcxSchedulerReportSchedulerHeaderCell;
begin
  APageIndex := GetPageIndex(APeriodIndex, 0);
  CreatePageSiteWithHeader(APageIndex, APage, AHeader, R);
  CorrectBoundsWithHeader(AHeader, R);
  CreateControlsOnFirstPage(APageIndex, APage, AHeader, R);
  if Layout = pslTwoPages then
  begin
    CreatePageSiteWithHeader(APageIndex + 1, APage, AHeader, R, False);
    CorrectBoundsWithHeader(AHeader, R);
    CreateControlsOnSecondPage(APageIndex + 1, APage, AHeader, R);
  end;
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.CreatePageSiteWithHeader(
  APageIndex: Integer; out ASite: TcxSchedulerReportPageSite;
  out AHeader: TcxSchedulerReportSchedulerHeaderCell;
  out ABounds: TRect; AIsPrimary: Boolean = True);
var
  R: TRect;
begin
  ABounds := GetPageSiteBounds(APageIndex);
  ASite := AddPageSite(ABounds);
  ASite.FPageIndex := APageIndex;
  ASite.FPrimaryPage := AIsPrimary;
  ABounds := ASite.GetInnerBounds(0);
  if GetHasPageReportTitle(APageIndex) then
    Inc(ABounds.Top, ReportLink.RenderInfo.CalculateTitleHeight);
  if GetHasPageHeader(APageIndex) then
  begin
    R := ABounds;
    R.Bottom := R.Top + GetPageHeaderHeight(R, APageIndex);
    ABounds.Top := R.Bottom + InterAreaSpace;
    AHeader := CreateHeaderCell(ASite);
    Inc(R.Bottom, AHeader.BorderEdgeThicknesses[csBottom]);
    InitReportCell(AHeader, R);
    if GetShowDateNavigator(APageIndex) then
    begin
      R := AHeader.GetInnerBounds(0);
      CreateHeaderDateNavigator(TcxSchedulerReportSchedulerHeaderCell(AHeader), APageIndex, R);
    end;
    AHeader.AdjustTextSize;
    if AIsPrimary then
      ReportLink.DoInitializeHeaderPrimaryCell(AHeader)
    else
      ReportLink.DoInitializeHeaderSecondaryCell(AHeader);
  end;
end;

function TcxCustomSchedulerReportLinkPrintStyle.CanSplitSchedulingOnTwoPages: Boolean;
begin
  Result := Layout = pslTwoPages; 
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetHasPageHeader(
  APageIndex: Integer): Boolean;
begin
  Result := True;
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetHasPageReportTitle(
  APageIndex: Integer): Boolean;
begin
  case ReportLink.ReportTitleMode of
    tmNone:
      Result := False;
    tmOnFirstPage:
      Result := APageIndex div (Byte(Layout) + 1) = 0;
  else
    Result := True;
  end;
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetPageHeaderHeight(
  const ASiteBounds: TRect; APageIndex: Integer): Integer;
var
  AMin, AMax: Integer;
begin
  Result := 0;
  AMin := Round((ASiteBounds.Bottom - ASiteBounds.Top) * SchedulerHeaderMinHeight);
  AMax := Round((ASiteBounds.Bottom - ASiteBounds.Top) * SchedulerHeaderMaxHeight);
  if GetShowDateNavigator(APageIndex) and (ReportLink <> nil) then
  begin
    with VisualStyles do 
      Result := TcxSchedulerReportDateNavigatorCell.MeasureDateNavigatorHeight(
        GetDateNavigatorContentParams, GetDateNavigatorHeaderParams);
  end;
  Result := Max(Min(AMax, Result), AMin);
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetPageIndex(
  APeriodIndex, AIndex: Integer): Integer;
begin
  Result := (APeriodIndex * (Byte(Layout) + 1) + AIndex);
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.GetPagePeriodAndIndex(
  APageIndex: Integer; var APeriodIndex, ASubIndex: Integer);
begin
  ASubIndex := 0;
  if Layout = pslTwoPages then
  begin
    APeriodIndex := APageIndex div 2;
    ASubIndex := APageIndex mod 2;
  end
  else
    APeriodIndex := APageIndex;
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetPageSiteBounds(
  APageIndex: Integer): TRect;
begin
  Result := MakeBounds(0, 0, ReportLink.PageWidth, ReportLink.PageHeight);
  OffsetRect(Result, 0,  APageIndex * ReportLink.PageHeight);
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetStartOfWeekOffset: Integer;
begin
  Result := 0;
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.GetPageDateNavigatorInfo(
  APageIndex: Integer; out AYear, AMonth: Word);
var
  ADate: TDateTime;
  ADayCount: Integer;
begin
  ADayCount := APageIndex * GetDaysPerPeriod div
    ((Byte(Layout) + 1) * GetResourcePageCount);
  ADate := PrintRange.PrintFrom + ADayCount;
  AYear := YearOf(ADate);
  AMonth := MonthOf(ADate);
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetDaysPerPeriod: Integer;
begin
  Result := 1; 
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.FillDatesForPage(
  ADateList: TcxSchedulerDateList; APageIndex, APeriodIndex, ASubIndex: Integer);
begin
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetActive: Boolean;
begin
  if Styles <> nil then
    Result := (Styles.ActiveStyle = Self) and Styles.ActiveStyleAssigned
  else
    Result := False;
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetHasAdditionalArea: Boolean;
begin
  Result := ShowNotesAreaBlank or ShowNotesAreaLined or ShowTaskPad;
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetIndex: Integer;
begin
  if Styles <> nil then
    Result := Styles.IndexOf(Self)
  else
    Result := -1;  
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetPageSite(
  AIndex: Integer): TcxSchedulerReportPageSite;
begin
  if ReportLink <> nil then
    Result := TcxSchedulerReportPageSite(ReportLink.PageSites[AIndex])
  else
    Result := nil;
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetPeriodCount: Integer;
begin
  Result := PageCount;
  if Layout = pslTwoPages then
    Result := Result div 2; 
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetPrintRange: TcxSchedulerReportLinkPrintRange;
begin
  if ReportLink <> nil then
    Result := ReportLink.PrintRange
  else
    Result := nil;  
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetReportLink: TcxSchedulerReportLink;
begin
  if Styles <> nil then
    Result := Styles.ReportLink
  else
    Result := nil;
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetResourceCount: Integer;
begin
  if (Scheduler <> nil) and (Scheduler.Storage <> nil) and
   (Scheduler.Storage.Resources.ResourceItems.VisibleResourceCount > 0) then
    Result := Scheduler.Storage.Resources.ResourceItems.VisibleResourceCount
  else
    Result := 1;
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetScheduler: TcxScheduler;
begin
  if ReportLink <> nil then
    Result := ReportLink.Scheduler
  else
    Result := nil;
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetStorage: TcxCustomSchedulerStorage;
begin
  if Scheduler <> nil then 
    Result := Scheduler.Storage
  else
    Result := nil;
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetTimePrintFrom: TTime;
begin
  Result := TimeOf(PrintRange.TimePrintFrom);
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetTimePrintTo: TTime;
begin
  Result := TimeOf(PrintRange.TimePrintTo);
end;

function TcxCustomSchedulerReportLinkPrintStyle.GetVisualStyles: TcxSchedulerReportLinkStyles;
begin
  if ReportLink <> nil then 
    Result := ReportLink.ActiveStyles
  else
    Result := nil;
end;

function TcxCustomSchedulerReportLinkPrintStyle.IsCaptionStored: Boolean;
begin
  Result := (FCaption <> DefaultCaption);
end;

function TcxCustomSchedulerReportLinkPrintStyle.IsLayoutStored: Boolean;
begin
  Result := Layout <> pslOnePage;
end;

function TcxCustomSchedulerReportLinkPrintStyle.IsShowNotesAreaBlankStored: Boolean;
begin
  Result := FShowNotesAreaBlank <> False;
end;

function TcxCustomSchedulerReportLinkPrintStyle.IsActiveStored: Boolean;
begin
  Result := Active and Styles.ActiveStyleAssigned;
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.SetActive(Value: Boolean);
begin
  if Styles <> nil then
  begin
    if Value then
      Styles.ActiveStyle := Self
    else
      Styles.ActiveStyle := nil;
    Styles.ActiveStyleAssigned := Value;
  end;
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.SetCaption(const Value: string);
begin
  if Caption <> Value then
  begin
    FCaption := Value;
    Changed;
  end;
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.SetCompressWeekends(
  Value: Boolean);
begin
  SetBoolOption(FCompressWeekends, Value);
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.SetDontPrintWeekends(
  Value: Boolean);
begin
  SetBoolOption(FDontPrintWeekEnds, Value);
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.SetLayout(
  Value: TcxSchedulerReportLinkPeriodicPrintStyleLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    Changed;
  end;
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.SetResourceCountPerPage(
  Value: Integer);
begin
  if FResourceCountPerPage <> Value then
  begin
    FResourceCountPerPage := Value;
    Changed; 
  end;
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.SetShowNotesAreaBlank(
  Value: Boolean);
begin
  SetBoolOption(FShowNotesAreaBlank, Value);
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.SetShowNotesAreaLined(
  Value: Boolean);
begin
  SetBoolOption(FShowNotesAreaLined, Value);
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.SetShowTaskPad(Value: Boolean);
begin
  SetBoolOption(FShowTaskPad, Value);
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.SetTimePrintFrom(Value: TTime);
begin
  PrintRange.TimePrintFrom := Value;
end;

procedure TcxCustomSchedulerReportLinkPrintStyle.SetTimePrintTo(Value: TTime);
begin
  PrintRange.TimePrintTo := Value;
end;

{ TcxSchedulerReportLinkDailyPrintStyle }

function TcxSchedulerReportLinkDailyPrintStyle.DefaultCaption: string;
begin
  Result := cxGetResourceString(@sdxPrintStyleCaptionDaily);
end;

function TcxSchedulerReportLinkDailyPrintStyle.IsCompatibleWith(
  AView: TcxSchedulerCustomView): Boolean;
begin
  Result := AView is TcxSchedulerDayView;
end;

procedure TcxSchedulerReportLinkDailyPrintStyle.BeforeBuild;
begin
  inherited BeforeBuild;
  FCurrentPagePerDate := PagesPerPeriod;
end;

function TcxSchedulerReportLinkDailyPrintStyle.CanSplitSchedulingOnTwoPages: Boolean;
begin
  Result := False;
end;

procedure TcxSchedulerReportLinkDailyPrintStyle.CreateControlsOnFirstPage(
  APageIndex: Integer; ASite, AHeader: TdxReportCell; ABounds: TRect);
begin
  if Layout = pslOnePage then
    CreateAdditionalControls(ASite, True, ShowTaskPad,
      ShowNotesAreaBlank, ShowNotesAreaLined, True, ABounds);
  InitReportCell(CreateSchedulingAreaCell(ASite), ABounds);
end;

procedure TcxSchedulerReportLinkDailyPrintStyle.CreateControlsOnSecondPage(
  APageIndex: Integer; ASite, AHeader: TdxReportCell; ABounds: TRect);
begin
  CreateAdditionalControls(ASite, False, ShowTaskPad,
    ShowNotesAreaBlank, ShowNotesAreaLined, True, ABounds);
end;

function TcxSchedulerReportLinkDailyPrintStyle.CreateSchedulingCellsProducer(
  ASite: TcxSchedulerReportSchedulingAreaCell): TcxSchedulerReportCommonCellsProducer;
begin
  Result := TcxSchedulerReportDailyCellsProducer.CreateEx(Self, ASite);
end;

procedure TcxSchedulerReportLinkDailyPrintStyle.FillDatesForPage(
  ADateList: TcxSchedulerDateList; APageIndex, APeriodIndex, ASubIndex: Integer);
begin
  APageIndex := APageIndex div GetResourcePageCount;
  ADateList.Add(PrintRange.PrintFrom + APageIndex);
end;

function TcxSchedulerReportLinkDailyPrintStyle.GetCorrespondedView: TcxSchedulerCustomResourceView;
begin
  if Scheduler <> nil then
    Result := Scheduler.ViewDay
  else
    Result := inherited GetCorrespondedView;
end;

function TcxSchedulerReportLinkDailyPrintStyle.GetGlyphIndex: Integer;
begin
  Result := Byte(HasAdditionalArea);
  if Layout = pslTwoPages then
    Result := 2;
end;

function TcxSchedulerReportLinkDailyPrintStyle.GetPageCount: Integer;
begin
  Result := GetResourcePageCount * PrintRange.DayCount * (Byte(Layout) + 1);
end;

function TcxSchedulerReportLinkDailyPrintStyle.GetPagesPerPeriod: Integer;
var
  I, J: Integer;
begin
  if (ResourceCountPerPage = 0) or (ResourceCount < 2) then
    Result := Byte(Layout) + 1
  else
  begin
    I := Min(ResourceCount, ResourceCountPerPage);
    J := ResourceCount div I;
    if J * I < ResourceCount then Inc(J);
    Result := J * (Byte(Layout) + 1);
  end;
end;

function TcxSchedulerReportLinkDailyPrintStyle.GetShowNotesAreaBlank: Boolean;
begin
  Result := inherited GetShowNotesAreaBlank;
  if not Result and (Layout <> pslOnePage) then
    Result := not (ShowTaskPad or ShowNotesAreaLined);
end;

procedure TcxSchedulerReportLinkDailyPrintStyle.InitHeaderCell(
  ACell: TcxSchedulerReportSchedulerHeaderCell);
begin
  ReportLink.SetCellViewParams(ACell, VisualStyles.GetSchedulerHeaderParams);
  ACell.PrimaryText := DateTimeHelper.DateToLongDateStr(CurrentDate);
  ACell.SecondaryText := LongDayNames[DayOfWeek(CurrentDate)];
  inherited InitHeaderCell(ACell);
  Dec(FCurrentPagePerDate);
  if FCurrentPagePerDate = 0 then
  begin
    CurrentDate := CurrentDate + 1;
    FCurrentPagePerDate := PagesPerPeriod;
  end;  
end;

function TcxSchedulerReportLinkDailyPrintStyle.SupportIcons: Boolean;
begin
  Result := True;
end;

function TcxSchedulerReportLinkDailyPrintStyle.SupportMessage: Boolean;
begin
  Result := True;
end;

function TcxSchedulerReportLinkDailyPrintStyle.SupportTimeRange: Boolean;
begin
  Result := True;
end;

{ TcxSchedulerReportLinkCustomDetailsPrintStyle }

function TcxSchedulerReportLinkCustomDetailsPrintStyle.AddPageSite(
  const ABounds: TRect): TcxSchedulerReportPageSite;
begin
  Inc(BuildedPageCount);
  Result := inherited AddPageSite(ABounds);
end;

procedure TcxSchedulerReportLinkCustomDetailsPrintStyle.BeforeBuild;
begin
  CurrentPage := nil;
  CellsOnPage := 0;
  BuildedPageCount := 0;
  FTimeWidth := MeasureTimeWidth;
  inherited BeforeBuild;
end;

function TcxSchedulerReportLinkCustomDetailsPrintStyle.GetNextPage(
  APrevPage: TcxSchedulerReportPageSite; out ABounds: TRect): TcxSchedulerReportPageSite;
begin
  CellsOnPage := 0;
  if APrevPage = nil then
    Result := PageSites[0]
  else
    Result := AddPageSite(GetPageSiteBounds(BuildedPageCount));
  ABounds := Result.GetInnerBounds(0);
  if GetHasPageReportTitle(BuildedPageCount - 1) then
    Inc(ABounds.Top, ReportLink.RenderInfo.CalculateTitleHeight);
end;

function TcxSchedulerReportLinkCustomDetailsPrintStyle.GetPageCount: Integer;
begin
  Result := Max(1, BuildedPageCount);
end;

function TcxSchedulerReportLinkCustomDetailsPrintStyle.MeasureTimeWidth: Integer;
var
  AFont: TFont;
begin
  AFont := ReportLink.Font;
  if (VisualStyles.Event <> nil) and (cxStyles.svFont in VisualStyles.Event.AssignedValues) then
    AFont := VisualStyles.Event.Font;
  Result := cxTextWidth(AFont, '00:00 - 00:00') * 2;
end;

function TcxSchedulerReportLinkCustomDetailsPrintStyle.GetPageWidth: Integer;
begin
  Result := ReportLink.PageWidth;
end;

{ TcxSchedulerReportLinkDetailsPrintStyle }

procedure TcxSchedulerReportLinkDetailsPrintStyle.Assign(Source: TPersistent);
begin
  if Source is TcxSchedulerReportLinkDetailsPrintStyle then
  begin
    PaginationMode := TcxSchedulerReportLinkDetailsPrintStyle(Source).PaginationMode;
    UsePagination := TcxSchedulerReportLinkDetailsPrintStyle(Source).UsePagination;
  end;
  inherited Assign(Source); 
end;

function TcxSchedulerReportLinkDetailsPrintStyle.DefaultCaption: string;
begin
  Result := cxGetResourceString(@sdxPrintStyleCaptionDetails);
end;

procedure TcxSchedulerReportLinkDetailsPrintStyle.RestoreDefaults;
begin
  PaginationMode := dpmByDay;
  UsePagination := False;
  inherited RestoreDefaults;
end;

function TcxSchedulerReportLinkDetailsPrintStyle.AddDayHeader(ADate: TDateTime;
  AContinue: Boolean; var ABounds: TRect): TcxSchedulerReportSchedulerHeaderCell;
var
  R: TRect;
begin
  Result := TcxSchedulerReportSchedulerHeaderCell.Create(CurrentPage);
  Result.Date := ADate;
  R := cxRectSetHeight(ABounds, DayHeaderHeight);
  ABounds.Top := R.Bottom + InterAreaSpace;
  Result.Transparent := False;
  Result.PrimaryText := GetDayHeaderText(AContinue);
  InitReportCell(Result, R);
  Result.Content.BoundsRect := Result.GetInnerBounds(0);
  Result.AdjustTextSize;
end;

procedure TcxSchedulerReportLinkDetailsPrintStyle.BeforeBuild;
begin
  PreviousHeader := nil;
  CellsOnPage := 0;
  inherited BeforeBuild;
end;

procedure TcxSchedulerReportLinkDetailsPrintStyle.BuildPages;
var
  ADayEvents: TcxSchedulerEventList;
begin
  ADayEvents := TcxSchedulerEventList.Create;
  try
    CellsOnPage := 0;
    Site := nil;
    DayIndex := 0;
    while DayIndex < PrintRange.DayCount do
    begin
      ADayEvents.Clear;
      Events.ExtractEvents(CurrentDate, ADayEvents);
      Events.Sort(TcxCompareEventsProc(@cxCompareSchedulerControlEvents));
      if (ADayEvents.Count > 0) and (Site = nil) then
      begin
        Site := AddPageSite(GetPageSiteBounds(0));
        PrepareNextPage;
      end;
      if (CellsOnPage > 0) and (ADayEvents.Count > 0) then
        CheckPagination;
      EventIndex := 0;
      while EventIndex < ADayEvents.Count do
      begin
        CurrentCell := AddEventCell(ADayEvents[EventIndex]);
        ReportLink.DoInitializeEventCell(CurrentCell);
        if (CellsOnPage > 0) and (MeasureCellBounds.Bottom > CurrentPageBounds.Bottom) then
          PrepareNextPage;
        HeaderNeeded;
        SetCellPlace;
        Inc(EventIndex);
      end;
      CurrentDate := CurrentDate + 1;
      Inc(DayIndex);
    end;
  finally
    ADayEvents.Free;
  end;
end;

function TcxSchedulerReportLinkDetailsPrintStyle.GetDayHeaderHeight: Integer;
var
  DC: HDC;
begin
  DC := GetDC(0);
  try
    Result := ReportLink.Renderer.CalcTextHeight(DC, 'Wg', False, GetSchedulerHeaderParams.NativeParams.Font) * 2;
  finally
    ReleaseDC(0, DC);
  end
end;

function TcxSchedulerReportLinkDetailsPrintStyle.GetDayHeaderText(AContinue: Boolean): string;
begin
  Result := DateTimeHelper.DateToLongDateStr(CurrentDate);
  if AContinue then
    Result := Result + ' ' + cxGetResourceString(@sdxContinuedMessage);
end;

function TcxSchedulerReportLinkDetailsPrintStyle.GetGlyphIndex: Integer;
begin
  Result := 22;
end;

function TcxSchedulerReportLinkDetailsPrintStyle.GetPreviewGlyphIndex: Integer;
begin
  Result := 16;
end;

function TcxSchedulerReportLinkDetailsPrintStyle.GetSchedulerHeaderParams: TdxReportItemViewParams;
begin
  FillChar(Result, SizeOf(Result), 0);
  Result.NativeParams := VisualStyles.GetDayHeaderParams(CurrentDate);
  Include(Result.FontStyle, fsBold);
end;

function TcxSchedulerReportLinkDetailsPrintStyle.AddEventCell(
  AEvent: TcxSchedulerEvent): TcxSchedulerReportDetailsEventCell;
begin
  Result := TcxSchedulerReportDetailsEventCell.CreateEx(Site, AEvent,
    CurrentDate, VisualStyles.GetEventParams(AEvent),
    (AEvent.Start < CurrentDate) and (CurrentDate > PrintRange.PrintFrom));
  Result.CalculateLayout(PageWidth, TimeWidth);
end;

procedure TcxSchedulerReportLinkDetailsPrintStyle.CheckPagination;
begin
  if not UsePagination then Exit;
  case PaginationMode of
    dpmByDay:
      PrepareNextPage;
    dpmByWeek:
      if GetWeekNumber(CurrentDate, dSunday, fwySystem) <>
        GetWeekNumber(PreviousHeader.Date, dSunday, fwySystem) then
          PrepareNextPage;
    dpmByMonth:
      if MonthOf(CurrentDate) <> MonthOf(PreviousHeader.Date) then
        PrepareNextPage;
  end;
end;

procedure TcxSchedulerReportLinkDetailsPrintStyle.HeaderNeeded;
begin
  if NeedAddDayHeader then
    PreviousHeader := AddDayHeader(CurrentDate, EventIndex > 0, CurrentPageBounds);
end;

function TcxSchedulerReportLinkDetailsPrintStyle.NeedAddDayHeader: Boolean;
begin
  Result := (CellsOnPage = 0) or (PreviousHeader = nil) or (PreviousHeader.Date <> CurrentDate);
end;

function TcxSchedulerReportLinkDetailsPrintStyle.MeasureCellBounds: TRect;
begin
  Result := CurrentPageBounds;
  Result.Bottom := Result.Top + CurrentCell.CalculateHeight;
  if NeedAddDayHeader then
    Inc(Result.Bottom, DayHeaderHeight);
end;                      

procedure TcxSchedulerReportLinkDetailsPrintStyle.PrepareNextPage;
begin
  CurrentPage := GetNextPage(CurrentPage, CurrentPageBounds);
end;

procedure TcxSchedulerReportLinkDetailsPrintStyle.SetCellPlace;
begin
  Inc(CellsOnPage);
  CurrentCell.BoundsRect := MeasureCellBounds;
  CurrentCell.Parent := CurrentPage;
  CurrentPageBounds.Top := CurrentCell.BoundsRect.Bottom + InterAreaSpace;
end;

procedure TcxSchedulerReportLinkDetailsPrintStyle.SetPaginationMode(
  Value: TcxSchedulerReportLinkDetailsPrintStylePaginationMode);
begin
  if FPaginationMode <> Value then
  begin
    FPaginationMode := Value;
    Changed;
  end;
end;

procedure TcxSchedulerReportLinkDetailsPrintStyle.SetUsePagination(
  Value: Boolean);
begin
  SetBoolOption(FUsePagination, Value);
end;

{ TcxSchedulerReportLinkMemoPrintStyle }

procedure TcxSchedulerReportLinkMemoPrintStyle.Assign(Source: TPersistent);
begin
  if Source is TcxSchedulerReportLinkMemoPrintStyle then
    with TcxSchedulerReportLinkMemoPrintStyle(Source) do 
    begin
      Self.FSelectedEventsOnly := FSelectedEventsOnly;
      Self.FStartEachItemOnNewPage := FStartEachItemOnNewPage;
    end;
  inherited Assign(Source);
end;

function TcxSchedulerReportLinkMemoPrintStyle.DefaultCaption: string;
begin
  Result := cxGetResourceString(@sdxPrintStyleCaptionMemo);
end;

procedure TcxSchedulerReportLinkMemoPrintStyle.RestoreDefaults;
begin
  FSelectedEventsOnly := True;
  FStartEachItemOnNewPage := True;
  inherited RestoreDefaults;
end;

function TcxSchedulerReportLinkMemoPrintStyle.AddEventCell(
  AEvent: TcxSchedulerEvent): TcxSchedulerReportDetailsEventCell;
begin
  Result := TcxSchedulerReportMemoEventCell.CreateEx(CurrentPage, AEvent,
    NullDate, VisualStyles.GetEventParams(AEvent));
  Result.CalculateLayout(PageWidth, TimeWidth);
end;

procedure TcxSchedulerReportLinkMemoPrintStyle.BuildPages;
var
  I: Integer;
  APageBounds: TRect;
  ACell: TcxSchedulerReportDetailsEventCell;

  function GetCellBounds: TRect;
  begin
    Result := APageBounds;
    Result.Bottom := Result.Top + ACell.CalculateHeight;
  end;

begin
  Site := nil;
  if Events.Count = 0 then Exit;
  Site := AddPageSite(GetPageSiteBounds(0));
  CurrentPage := GetNextPage(CurrentPage, APageBounds);
  for I := 0 to Events.AbsoluteCount - 1 do
  begin
    ACell := AddEventCell(Events[I]);
    ReportLink.DoInitializeEventCell(ACell);
    if (CellsOnPage > 0) and (StartEachItemOnNewPage or
      (GetCellBounds.Bottom > APageBounds.Bottom)) then
      CurrentPage := GetNextPage(CurrentPage, APageBounds);
    ACell.Parent := CurrentPage;
    ACell.BoundsRect := GetCellBounds;
    APageBounds.Top := ACell.BoundsRect.Bottom + InterAreaSpace;
    Inc(CellsOnPage);
  end;
end;

procedure TcxSchedulerReportLinkMemoPrintStyle.DoCanPrintEvent(
  AEvent: TcxSchedulerEvent; var AllowPrint: Boolean);
var
  I: Integer;
  AUseEvent: Boolean;
begin
  if SelectedEventsOnly and (Scheduler <> nil) then
  begin
    AllowPrint := False;
    for I := 0 to Scheduler.SelectedEventCount - 1 do
    begin
      AllowPrint := Scheduler.SelectedEvents[I].Source = TcxSchedulerControlEvent(AEvent).Source;
      if AllowPrint then Break;
    end;
  end;
  AUseEvent := False;
  for I := 0 to PrintRange.DayCount - 1 do
    if AEvent.IsDayEvent(PrintRange.PrintFrom + I) then
    begin
      AUseEvent := True;
      Break;
    end;
  if AUseEvent then
    inherited DoCanPrintEvent(AEvent, AllowPrint)
  else
    AllowPrint := False;
end;

function TcxSchedulerReportLinkMemoPrintStyle.GetGlyphIndex: Integer;
begin
  Result := 20;
end;

function TcxSchedulerReportLinkMemoPrintStyle.GetPreviewGlyphIndex: Integer;
begin
  Result := 17;
end;

function TcxSchedulerReportLinkMemoPrintStyle.MeasureTimeWidth: Integer;
var
  AFont: TFont;
begin
  AFont := ReportLink.Font;
  if (VisualStyles.Event <> nil) and (cxStyles.svFont in VisualStyles.Event.AssignedValues) then
    AFont := VisualStyles.Event.Font;
  Result := 0;
  Result := Max(Result, cxTextWidth(AFont, cxGetResourceString(@sdxSubjectLabelCaption)));
  Result := Max(Result, cxTextWidth(AFont, cxGetResourceString(@sdxLocationLabelCaption)));
  Result := Max(Result, cxTextWidth(AFont, cxGetResourceString(@sdxStartLabelCaption)));
  Result := Max(Result, cxTextWidth(AFont, cxGetResourceString(@sdxFinishLabelCaption)));
  Result := Max(Result, cxTextWidth(AFont, cxGetResourceString(@sdxShowTimeAsLabelCaption)));
  Result := Max(Result, cxTextWidth(AFont, cxGetResourceString(@sdxRecurrenceLabelCaption)));
  Result := Max(Result, cxTextWidth(AFont, cxGetResourceString(@sdxRecurrencePatternLabelCaption)));
  if Result = 0 then
    Result := inherited MeasureTimeWidth
  else
    Inc(Result, cxTextWidth(AFont, '0000 - 0000'));
  Result := Min(PageWidth div 3, Result);  
end;

{ TcxSchedulerReportLinkMonthlyPrintStyle }

procedure TcxSchedulerReportLinkMonthlyPrintStyle.Assign(Source: TPersistent);
begin
  if Source is TcxSchedulerReportLinkMonthlyPrintStyle then
    PrintExactlyOneMonthPerPage :=
      TcxSchedulerReportLinkMonthlyPrintStyle(Source).PrintExactlyOneMonthPerPage;
  inherited Assign(Source);
end;

function TcxSchedulerReportLinkMonthlyPrintStyle.DefaultCaption: string;
begin
  Result := cxGetResourceString(@sdxPrintStyleCaptionMonthly);
end;

function TcxSchedulerReportLinkMonthlyPrintStyle.IsCompatibleWith(
  AView: TcxSchedulerCustomView): Boolean;
begin
  Result := AView is TcxSchedulerWeeksView;
end;

procedure TcxSchedulerReportLinkMonthlyPrintStyle.RestoreDefaults;
begin
  PrintExactlyOneMonthPerPage := False;
  inherited RestoreDefaults;
end;

procedure TcxSchedulerReportLinkMonthlyPrintStyle.CreateControlsOnFirstPage(
  APageIndex: Integer; ASite, AHeader: TdxReportCell; ABounds: TRect);
begin
  if Layout = pslTwoPages then
    CreateAdditionalControls(ASite, True, ShowTaskPad and
     (ShowNotesAreaLined or ShowNotesAreaBlank), False, False, False, ABounds)
  else
    CreateAdditionalControls(ASite, True, ShowTaskPad,
     ShowNotesAreaBlank, ShowNotesAreaLined, True, ABounds);
  InitReportCell(CreateSchedulingAreaCell(ASite), ABounds);
end;

procedure TcxSchedulerReportLinkMonthlyPrintStyle.CreateControlsOnSecondPage(
  APageIndex: Integer; ASite, AHeader: TdxReportCell; ABounds: TRect);
var
  HasTaskPad: Boolean;
begin
  HasTaskPad := ShowTaskPad and not (ShowNotesAreaBlank or ShowNotesAreaLined);
  CreateAdditionalControls(ASite, True, HasTaskPad, ShowNotesAreaBlank,
     ShowNotesAreaLined, True, ABounds);
  InitReportCell(CreateSchedulingAreaCell(ASite), ABounds);
end;

function TcxSchedulerReportLinkMonthlyPrintStyle.GetCorrespondedView: TcxSchedulerCustomResourceView;
begin
  if Scheduler <> nil then
    Result := Scheduler.ViewWeeks
  else
    Result := inherited GetCorrespondedView;
end;

procedure TcxSchedulerReportLinkMonthlyPrintStyle.FillDatesForPage(
  ADateList: TcxSchedulerDateList; APageIndex, APeriodIndex, ASubIndex: Integer);
var
  I: Integer;
  Y, M, D: Word;
  AStart: TDateTime;
begin
  AStart := GetDateForPage(APageIndex);
  DecodeDate(AStart, Y, M, D);
  for I := 0 to DaysInAMonth(Y, M) - 1 do
    ADateList.Add(AStart + I);
end;

function TcxSchedulerReportLinkMonthlyPrintStyle.GetDaysPerPeriod: Integer;
begin
  Result := 30;
end;

function TcxSchedulerReportLinkMonthlyPrintStyle.GetDateForPage(
  APageIndex: Integer): TDateTime;
var
  Y, M, D: Word;
  APeriodIndex: Integer;
begin
  APeriodIndex := APageIndex div (Byte(Layout) + 1) div GetResourcePageCount;
  DecodeDate(PrintRange.PrintFrom, Y, M, D);
  D := 1;
  IncAMonth(Y, M, D, APeriodIndex);
  Result := EncodeDate(Y, M, D);
end;

function TcxSchedulerReportLinkMonthlyPrintStyle.GetGlyphIndex: Integer;
begin
  Result := 11 + Byte(HasAdditionalArea);
  if Layout = pslTwoPages then
    Inc(Result, 2);
end;

function TcxSchedulerReportLinkMonthlyPrintStyle.GetPageCount: Integer;
begin
  Result := PrintRange.MonthCount * (Byte(Layout) + 1) * GetResourcePageCount;
end;

procedure TcxSchedulerReportLinkMonthlyPrintStyle.InitHeaderCell(
  ACell: TcxSchedulerReportSchedulerHeaderCell);

  function GetMonthText(ADate: TDateTime): string;
  begin
    Result := FormatDateTime('mmmm', ADate) + ' ' + IntToStr(YearOf(ADate));
  end;

var
  ADate: TDateTime;
begin
  ADate := GetDateForPage(ACell.PageIndex);
  if PrintExactlyOneMonthPerPage then
    ACell.PrimaryText := GetMonthText(ADate)
  else
    ACell.PrimaryText := GetMonthText(ADate) + ' - ' + GetMonthText(ADate + 32);
  inherited InitHeaderCell(ACell);
end;

procedure TcxSchedulerReportLinkMonthlyPrintStyle.SetPrintExactlyOneMonthPerPage(
  Value: Boolean);
begin
  SetBoolOption(FPrintExactlyOneMonthPerPage, Value);
end;

{ TcxSchedulerReportLinkTrifoldPrintStyle }

procedure TcxSchedulerReportLinkTrifoldPrintStyle.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TcxSchedulerReportLinkTrifoldPrintStyle then
    with TcxSchedulerReportLinkTrifoldPrintStyle(Source) do
    begin
      Self.LeftSection := LeftSection;
      Self.MiddleSection := MiddleSection;
      Self.RightSection := RightSection;
    end;
end;

function TcxSchedulerReportLinkTrifoldPrintStyle.DefaultCaption: string;
begin
  Result := cxGetResourceString(@sdxPrintStyleCaptionTrifold);
end;

procedure TcxSchedulerReportLinkTrifoldPrintStyle.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FSections[0] := smDailyCalendar;
  FSections[1] := smTaskPad;
  FSections[2] := smWeeklyCalendar;
end;

procedure TcxSchedulerReportLinkTrifoldPrintStyle.CreateLayoutForPeriod(
  APeriodIndex: Integer);
var
  I: Integer; 
  R: array[0..2] of TRect;
  ABounds: TRect;
  ASite: TcxSchedulerReportPageSite;
begin
  ABounds := GetPageSiteBounds(APeriodIndex);
  ASite := AddPageSite(ABounds);
  ASite.FPageIndex := APeriodIndex;
  ASite.FPrimaryPage := True;
  ABounds := ASite.GetInnerBounds(0);
  Rect2RectsHorz(ABounds, R[0], R[1], R[2]);
  for I := 0 to 2 do
    CreateLayoutForSection(ASite, APeriodIndex, R[I], FSections[I]);
end;

procedure TcxSchedulerReportLinkTrifoldPrintStyle.CreateLayoutForSection(
  ASite: TdxReportCell; APeriodIndex: Integer; const ABounds: TRect;
  ASection: TcxSchedulerReportLinkTrifoldPrintStyleSectionMode);
begin
  FCurrentSection := ASection;
  case ASection of
    smDailyCalendar:
      CreateSchedulingAreaWithHeader(ASite, ABounds);
    smWeeklyCalendar:
      CreateSchedulingAreaWithHeader(ASite, ABounds);
    smMonthlyCalendar:
      CreateSchedulingAreaWithHeader(ASite, ABounds);
    smTaskPad:
      InitReportCell(CreateTaskPadCell(ASite), ABounds);
    smNotesAreaBlank:
      InitReportCell(CreateNotesCell(ASite), ABounds);
    smNotesAreaLined:
      InitReportCell(CreateNotesLinedCell(ASite), ABounds);
  end;
end;

procedure TcxSchedulerReportLinkTrifoldPrintStyle.CreateSchedulingAreaWithHeader(
  ASite: TdxReportCell; ABounds: TRect);
var
  R: TRect;
  AHeader: TcxSchedulerReportSchedulerHeaderCell;
begin
  R := ABounds;
  R.Bottom := R.Top + Round((R.Bottom - R.Top) * SchedulerHeaderSmallHeight);
  ABounds.Top := R.Bottom + InterAreaSpace;
  FCurrentSchedulingArea := CreateSchedulingAreaCell(ASite);
  InitReportCell(FCurrentSchedulingArea, ABounds);
  AHeader := CreateHeaderCell(ASite);
  InitReportCell(AHeader, R);
  AHeader.Content.BoundsRect := AHeader.GetInnerBounds(0);
  AHeader.AdjustTextSize;
end;

function TcxSchedulerReportLinkTrifoldPrintStyle.CreateSchedulingCellsProducer(
  ASite: TcxSchedulerReportSchedulingAreaCell): TcxSchedulerReportCommonCellsProducer;
begin
  case FCurrentSection of
    smDailyCalendar:
      Result := TcxSchedulerReportDailyCellsProducer.CreateEx(Self, ASite);
    smWeeklyCalendar, smMonthlyCalendar:
      Result := TcxSchedulerReportWeeksCellsProducer.CreateEx(Self, ASite);
  else
    Result := nil;
  end;
end;

procedure TcxSchedulerReportLinkTrifoldPrintStyle.FillDatesForPage(
  ADateList: TcxSchedulerDateList; APageIndex, APeriodIndex, ASubIndex: Integer);
var
  I: Integer;
  ADate: TDateTime;
begin
  ADateList.Clear;
  case FCurrentSection of
    smDailyCalendar:
      ADateList.Add(APageIndex + PrintRange.PrintFrom);
    smWeeklyCalendar:
    begin
      ADate := StartOfTheWeek(PrintRange.PrintFrom +
        MulDiv(APageIndex * 7, PrintRange.WeekCount, PageCount));
      for I := 0 to 7 do
        ADateList.Add(ADate + I);
    end;
    smMonthlyCalendar:
    begin
      ADate := StartOfTheMonth(PrintRange.PrintFrom + APageIndex * FPageRange);
      for I := 0 to DaysInMonth(ADate) do
        ADateList.Add(ADate + I);
    end;
  end;
end;

function TcxSchedulerReportLinkTrifoldPrintStyle.GetCorrespondedView: TcxSchedulerCustomResourceView;
begin
  case FCurrentSection of
    smDailyCalendar:
      Result := Scheduler.ViewDay;
    smWeeklyCalendar:
      Result := Scheduler.ViewWeek;
    smMonthlyCalendar:
      Result := Scheduler.ViewWeeks;
  else
    Result := inherited GetCorrespondedView;
  end;
end;

function TcxSchedulerReportLinkTrifoldPrintStyle.GetGlyphIndex: Integer;
begin
  Result := 15;
end;

function TcxSchedulerReportLinkTrifoldPrintStyle.GetPageCount: Integer;
var
  I: Integer;
begin
  Result := 1;
  FPageRange := 30;
  for I := 0 to 2 do
  begin
    case FSections[I] of
      smDailyCalendar:
      begin
        Result := Max(Result, PrintRange.DayCount);
        FPageRange := 1;
      end;
      smWeeklyCalendar:
      begin
        Result := Max(Result, PrintRange.WeekCount);
        FPageRange := Min(FPageRange, 7);
      end;
      smMonthlyCalendar:
      begin
        Result := Max(Result, PrintRange.MonthCount);
        FPageRange := Min(FPageRange, 30);
      end;
    end;
  end;
end;

procedure TcxSchedulerReportLinkTrifoldPrintStyle.InitHeaderCell(
  ACell: TcxSchedulerReportSchedulerHeaderCell);
var
  AText: string;
  ADate1, ADate2: TDateTime;
begin
  with FCurrentSchedulingArea.VisibleDays do
  begin
    ADate1 := Items[0];
    ADate2 := Items[Count - 1];
  end;
  case FCurrentSection of
    smDailyCalendar:
      AText := DateTimeHelper.DateToLongDateStr(ADate1);
    smWeeklyCalendar:
      AText := DateTimeHelper.DayToStr(ADate1, 0, False) + ' - ' +
        DateTimeHelper.DayToStr(ADate2 - 1, 0, False);
    smMonthlyCalendar:
      if not cxGetDateFormat(ADate1, AText, DATE_YEARMONTH) then
        AText := FormatDateTime('mmmm', ADate1) + ' ' + IntToStr(YearOf(ADate1))
  end;
  ACell.PrimaryText := AText;
  inherited InitHeaderCell(ACell);
end;

function TcxSchedulerReportLinkTrifoldPrintStyle.GetSection(
  Index: Integer): TcxSchedulerReportLinkTrifoldPrintStyleSectionMode;
begin
  Result := FSections[Index];
end;

procedure TcxSchedulerReportLinkTrifoldPrintStyle.SetSection(
  Index: Integer; AValue: TcxSchedulerReportLinkTrifoldPrintStyleSectionMode);
begin
  if AValue <> FSections[Index] then
  begin
    FSections[Index] := AValue;
    Changed;
  end;
end;

function TcxSchedulerReportLinkTrifoldPrintStyle.IsSectionStored(
  Index: Integer): Boolean;
const
  Sections: array[0..2] of TcxSchedulerReportLinkTrifoldPrintStyleSectionMode =
    (smDailyCalendar, smTaskPad, smWeeklyCalendar);
begin
  Result := FSections[Index] <> Sections[Index];
end;

{ TcxSchedulerReportLinkWeeklyPrintStyle }

procedure TcxSchedulerReportLinkWeeklyPrintStyle.Assign(Source: TPersistent);
begin
  if Source is TcxSchedulerReportLinkWeeklyPrintStyle then
    Arrange := TcxSchedulerReportLinkWeeklyPrintStyle(Source).Arrange;
  inherited Assign(Source);
end;

function TcxSchedulerReportLinkWeeklyPrintStyle.DefaultCaption: string;
begin
  Result := cxGetResourceString(@sdxPrintStyleCaptionWeekly);
end;

function TcxSchedulerReportLinkWeeklyPrintStyle.IsCompatibleWith(
  AView: TcxSchedulerCustomView): Boolean;
begin
  Result := AView is TcxSchedulerWeekView;
end;

procedure TcxSchedulerReportLinkWeeklyPrintStyle.RestoreDefaults;
begin
  Arrange := wsaTopToBottom;
  inherited RestoreDefaults;
end;

procedure TcxSchedulerReportLinkWeeklyPrintStyle.CreateControlsOnFirstPage(
  APageIndex: Integer; ASite, AHeader: TdxReportCell; ABounds: TRect);
begin
  if Layout = pslTwoPages then
    CreateAdditionalControls(ASite, True, ShowTaskPad and
     (ShowNotesAreaLined or ShowNotesAreaBlank), False, False, False, ABounds)
  else
    CreateAdditionalControls(ASite, True, ShowTaskPad,
     ShowNotesAreaBlank, ShowNotesAreaLined, True, ABounds);
  InitReportCell(CreateSchedulingAreaCell(ASite), ABounds);
end;

procedure TcxSchedulerReportLinkWeeklyPrintStyle.CreateControlsOnSecondPage(
  APageIndex: Integer; ASite, AHeader: TdxReportCell; ABounds: TRect);
var
  HasTaskPad: Boolean;
begin
  HasTaskPad := ShowTaskPad and not (ShowNotesAreaBlank or ShowNotesAreaLined);
  CreateAdditionalControls(ASite, True, HasTaskPad, ShowNotesAreaBlank,
     ShowNotesAreaLined, True, ABounds);
  InitReportCell(CreateSchedulingAreaCell(ASite), ABounds);
end;

function TcxSchedulerReportLinkWeeklyPrintStyle.CreateSchedulingCellsProducer(
  ASite: TcxSchedulerReportSchedulingAreaCell): TcxSchedulerReportCommonCellsProducer;
const
  CellsProducers: array[Boolean] of TcxSchedulerReportCommonCellsProducerClass =
    (TcxSchedulerReportDailyCellsProducer, TcxSchedulerReportWeeksCellsProducer);
begin
  Result := CellsProducers[Arrange = wsaTopToBottom].CreateEx(Self, ASite);
end;

function TcxSchedulerReportLinkWeeklyPrintStyle.GetCorrespondedView: TcxSchedulerCustomResourceView;
begin
  if Scheduler <> nil then
  begin
    if Arrange = wsaTopToBottom then
      Result := Scheduler.ViewWeek
    else
      Result := Scheduler.ViewDay;
  end
  else
    Result := inherited GetCorrespondedView;
end;

function TcxSchedulerReportLinkWeeklyPrintStyle.GetGlyphIndex: Integer;
begin
  Result := 3 + Byte(Arrange) +  Byte(HasAdditionalArea) * 4 +
    Byte(Layout = pslTwoPages) * 2
end;

function TcxSchedulerReportLinkWeeklyPrintStyle.GetDateForPage(
  APageIndex: Integer): TDateTime;
begin
  Result := PrintRange.PrintFrom  + (APageIndex div GetResourcePageCount div
    (Byte(Layout) + 1)) * 7 + GetStartOfWeekOffset;
end;

function TcxSchedulerReportLinkWeeklyPrintStyle.GetDaysPerPeriod: Integer;
begin
  Result := 7;
end;

function TcxSchedulerReportLinkWeeklyPrintStyle.GetPageCount: Integer;
begin
  Result := PrintRange.WeekCount * (Byte(Layout) + 1) * GetResourcePageCount;
end;

function TcxSchedulerReportLinkWeeklyPrintStyle.GetStartOfWeekOffset: Integer;
begin
  Result := -DayOfWeek(PrintRange.PrintFrom) + 2;  //
end;

procedure TcxSchedulerReportLinkWeeklyPrintStyle.FillDatesForPage(
  ADateList: TcxSchedulerDateList; APageIndex, APeriodIndex, ASubIndex: Integer);
const
  DayCount: array[TcxSchedulerReportLinkPeriodicPrintStyleLayout, Boolean] of Integer =
    ((7, 7), (3, 4));
var
  I: Integer;
  AStart, ADate: TDateTime;
begin
  AStart := GetDateForPage(APageIndex);
  if Arrange = wsaLeftToRight then
    for I := 0 to DayCount[Layout, ASubIndex <> 0] - 1 do
    begin
      ADate := AStart + ASubIndex * 3 + I;
      if not DontPrintWeekEnds or not (DayOfWeek(ADate) in [1, 7]) then
        ADateList.Add(ADate);
    end
  else
  begin
    AStart := AStart + Byte(Scheduler.OptionsView.ActualStartOfWeek);
    for I := 0 to 6 do
      ADateList.Add(AStart + I);
  end;
end;

procedure TcxSchedulerReportLinkWeeklyPrintStyle.InitHeaderCell(
  ACell: TcxSchedulerReportSchedulerHeaderCell);

  function GetWeekDayText(ADate: TDateTime): string;
  begin
    Result := DateTimeHelper.DayToStr(ADate, 0, False);
  end;

var
  AWeekDate: TDateTime;
begin
  AWeekDate := GetDateForPage(ACell.PageIndex);
  ACell.PrimaryText := GetWeekDayText(AWeekDate) + ' - ' +
    GetWeekDayText(AWeekDate + 6);  
  inherited InitHeaderCell(ACell);
end;

function TcxSchedulerReportLinkWeeklyPrintStyle.CanDontPrintWeekends: Boolean;
begin
  Result := True;
end;

function TcxSchedulerReportLinkWeeklyPrintStyle.SupportTimeRange: Boolean;
begin
  Result := Arrange = wsaLeftToRight;
end;

function TcxSchedulerReportLinkWeeklyPrintStyle.IsArrangeStored: Boolean;
begin
  Result := Arrange <> wsaTopToBottom;
end;

procedure TcxSchedulerReportLinkWeeklyPrintStyle.SetArrange(
  Value: TcxSchedulerReportLinkWeeklyPrintStyleArrange);
begin
  if Arrange <> Value then
  begin
    FArrange := Value;
    Changed;
  end;
end;

{ TdxfmSchedulerReportLinkDesignWindow }

constructor TcxfmSchedulerReportLinkDesignWindow.Create(AOwner: TComponent);
begin
  HelpContext := dxhccxSchedulerReportLinkDesigner;
  inherited;
  wpPrintStyles := TList.Create;
  CreateControls;
  SetActivePage;
{$IFDEF DELPHI7}
  pnlPreview.ParentBackground := False;
{$ENDIF} 
end;

destructor TcxfmSchedulerReportLinkDesignWindow.Destroy;
begin
  FreeAndNil(wpPrintStyles);
  dxPSPopupMan.dxPSPopupMenuController.UnregisterControl(lbxStyles);
  inherited;
end;

function TcxfmSchedulerReportLinkDesignWindow.Execute: Boolean;
begin
  Self.FActiveStyle := ReportLink.PrintStyles.FActiveStyle;
  Self.FActiveStyleAssigned := ReportLink.PrintStyles.FActiveStyleAssigned;
  if (ReportLink.PrintStyles.ActiveStyle = nil) or not FActiveStyleAssigned then
    with ReportLink.PrintStyles do SetActiveStyleEx(GetCorrespondingStyle);
  Result := inherited Execute;
  if Result then
    ReportLink.PrintStyles.ActiveStyle := ActivePrintStyle
  else
  begin
    ReportLink.PrintStyles.FActiveStyleAssigned := FActiveStyleAssigned;
    ReportLink.PrintStyles.FActiveStyle := FActiveStyle;
  end;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.AssignDailyTabObjects;
var
  ADailyStyle: TcxSchedulerReportLinkDailyPrintStyle;
begin
  ADailyStyle := ReportLink.PrintStyles.Daily;
  cbxPrintStyleDailyLayout.ItemIndex := Integer(ADailyStyle.Layout);
  sePrintStyleDailyResourceCountPerPage.Properties.MaxValue := ADailyStyle.ResourceCount;
  sePrintStyleDailyResourceCountPerPage.Value := ADailyStyle.ResourceCountPerPage;
  chbxPrintStyleDailyTaskPad.Checked := ADailyStyle.ShowTaskPad;
  chbxPrintStyleDailyNotesAreaBlank.Checked := ADailyStyle.ShowNotesAreaBlank;
  chbxPrintStyleDailyNotesAreaLined.Checked := ADailyStyle.ShowNotesAreaLined;
  tePrintStyleDailyPrintFrom.Time := ADailyStyle.TimePrintFrom;
  tePrintStyleDailyPrintTo.Time := ADailyStyle.TimePrintTo;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.AssignDetailsTabObjects;
var
  ADetailsStyle: TcxSchedulerReportLinkDetailsPrintStyle;
begin
  ADetailsStyle := ReportLink.PrintStyles.Details;
  chbxPrintStyleDetailsUsePagination.Checked := ADetailsStyle.UsePagination;
  cbxPrintStyleDetailsPagination.ItemIndex := Integer(ADetailsStyle.PaginationMode);
end;

procedure TcxfmSchedulerReportLinkDesignWindow.AssignMemoTabObjects;
var
  AMemoStyle: TcxSchedulerReportLinkMemoPrintStyle;
begin
  AMemoStyle := ReportLink.PrintStyles.Memo;
  chbxPrintStyleMemoStartEachItemOnNewPage.Checked := AMemoStyle.StartEachItemOnNewPage;
  chbxPrintStyleMemoPrintOnlySelectedEvents.Checked := AMemoStyle.SelectedEventsOnly;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.AssignMonthlyTabObjects;
var
  AMonthlyStyle: TcxSchedulerReportLinkMonthlyPrintStyle;
begin
  AMonthlyStyle := ReportLink.PrintStyles.Monthly;
  cbxPrintStyleMonthlyLayout.ItemIndex := Integer(AMonthlyStyle.Layout);
  sePrintStyleMonthlyResourceCountPerPage.Properties.MaxValue := AMonthlyStyle.ResourceCount;
  sePrintStyleMonthlyResourceCountPerPage.Value := AMonthlyStyle.ResourceCountPerPage;
  chbxPrintStyleMonthlyTaskPad.Checked := AMonthlyStyle.ShowTaskPad;
  chbxPrintStyleMonthlyNotesAreaBlank.Checked := AMonthlyStyle.ShowNotesAreaBlank;
  chbxPrintStyleMonthlyNotesAreaLined.Checked := AMonthlyStyle.ShowNotesAreaLined;
  chbxPrintStyleMonthlyDontPrintWeekends.Checked := AMonthlyStyle.DontPrintWeekends;
  chbxPrintStyleMonthlyPrintExactlyOneMonthPerPage.Checked := AMonthlyStyle.PrintExactlyOneMonthPerPage;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.AssignTrifoldTabObjects;
var
  ATrifoldStyle: TcxSchedulerReportLinkTrifoldPrintStyle;
begin
  ATrifoldStyle := ReportLink.PrintStyles.Trifold;
  cbxPrintStyleTrifoldSectionLeft.ItemIndex := Byte(ATrifoldStyle.LeftSection);
  cbxPrintStyleTrifoldSectionMiddle.ItemIndex := Byte(ATrifoldStyle.MiddleSection);
  cbxPrintStyleTrifoldSectionRight.ItemIndex := Byte(ATrifoldStyle.RightSection);
end;

procedure TcxfmSchedulerReportLinkDesignWindow.AssignWeeklyTabObjects;
var
  AWeeklyStyle: TcxSchedulerReportLinkWeeklyPrintStyle;
begin
  AWeeklyStyle := ReportLink.PrintStyles.Weekly;
  cbxPrintStyleWeeklyArrange.ItemIndex := Integer(AWeeklyStyle.Arrange);
  cbxPrintStyleWeeklyLayout.ItemIndex := Integer(AWeeklyStyle.Layout);
  sePrintStyleWeeklyResourceCountPerPage.Properties.MaxValue := AWeeklyStyle.ResourceCount;
  sePrintStyleWeeklyResourceCountPerPage.Value := AWeeklyStyle.ResourceCountPerPage;
  chbxPrintStyleWeeklyTaskPad.Checked := AWeeklyStyle.ShowTaskPad;
  chbxPrintStyleWeeklyNotesAreaBlank.Checked := AWeeklyStyle.ShowNotesAreaBlank;
  chbxPrintStyleWeeklyNotesAreaLined.Checked := AWeeklyStyle.ShowNotesAreaLined;
  chbxPrintStyleWeeklyDontPrintWeekends.Checked := AWeeklyStyle.DontPrintWeekends;
  tePrintStyleWeeklyPrintFrom.Time := AWeeklyStyle.TimePrintFrom;
  tePrintStyleWeeklyPrintTo.Time := AWeeklyStyle.TimePrintTo;
end;

function TcxfmSchedulerReportLinkDesignWindow.CanApply: Boolean;
begin
  Result := inherited CanApply;// and not ReportLink.IsInconsistentState;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.DoApply;
begin
  if not IsValidConditions then Exit;
  ReportLink.PrintStyles.ActiveStyle := ActivePrintStyle;
  FActiveStyle := ReportLink.PrintStyles.FActiveStyle;
  FActiveStyleAssigned := ReportLink.PrintStyles.FActiveStyleAssigned;
  inherited DoApply;
  ReportLink.RebuildReport;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.DoInitialize;
begin

  lbxStyles.ReportLinkStyles := ReportLink.ActiveStyles;
  inherited DoInitialize;

  with ReportLink.PrintRange do
  begin
    dePrintRangeStart.Date := PrintFrom;
    dePrintRangeEnd.Date := PrintTo;
  end;

  AssignTabSheetObjects;
  RefreshPrintStyles;
  ActivatePrintStyleTab;

  AssignDailyTabObjects;
  AssignDetailsTabObjects;
  AssignMemoTabObjects;
  AssignMonthlyTabObjects;
  AssignTrifoldTabObjects;
  AssignWeeklyTabObjects;

  // Formatting
  with ReportLink.OptionsFormatting do
  begin
    cbxLookAndFeel.ItemIndex := Min(2, Integer(LookAndFeelKind));
    chbxSuppressBackgroundBitmaps.Checked := SuppressBackgroundBitmaps;
    chbxSuppressContentColoration.Checked := SuppressContentColoration;
    chbxUseNativeStyles.Checked := UseNativeStyles;
  end;

  PageControl1Change(nil);
end;

{$IFDEF DELPHI7}
function TcxfmSchedulerReportLinkDesignWindow.GetPreviewHost: TCustomPanel;
begin
  Result := pnlPreview;
end;
{$ENDIF}

function TcxfmSchedulerReportLinkDesignWindow.CheckPrintRange: Boolean;
begin
  Result := dePrintRangeEnd.Date >= dePrintRangeStart.Date;
  if not Result then
  begin
    MessageBox(0,
      PChar(cxGetResourceString(@sdxBadDatePrintRange)),
      PChar(cxGetResourceString(@sdxReportDesignerCaption)),
      MB_ICONINFORMATION or MB_OK);
    PageControl1.ActivePage := tshPrintRange;
    ActiveControl := dePrintRangeEnd;
  end;
end;

function TcxfmSchedulerReportLinkDesignWindow.CheckPrintStyleSettings: Boolean;

  procedure ShowWarning;
  begin
    MessageBox(0,
      PChar(cxGetResourceString(@sdxBadTimePrintRange)),
      PChar(cxGetResourceString(@sdxReportDesignerCaption)),
      MB_ICONINFORMATION or MB_OK);
  end;

begin
  if pcPrintStyleOptions.ActivePage = tshDaily then
  begin
    Result := TimeOf(tePrintStyleDailyPrintFrom.Time) <= TimeOf(tePrintStyleDailyPrintTo.Time);
    if not Result then
    begin
      ShowWarning;
      PageControl1.ActivePage := tshPrintStyles;
      pcPrintStyleOptions.ActivePage := tshDaily;
      ActiveControl := tePrintStyleDailyPrintTo;
    end;
  end
  else
    if pcPrintStyleOptions.ActivePage = tshWeekly then
    begin
      Result := TimeOf(tePrintStyleWeeklyPrintFrom.Time) <= TimeOf(tePrintStyleWeeklyPrintTo.Time);
      if not Result then
      begin
        ShowWarning;
        PageControl1.ActivePage := tshPrintStyles;
        pcPrintStyleOptions.ActivePage := tshWeekly;
        ActiveControl := tePrintStyleWeeklyPrintTo;
      end;
    end
    else
      Result := True;
end;

function TcxfmSchedulerReportLinkDesignWindow.IsValidConditions: Boolean;
begin
  Result := CheckPrintRange and CheckPrintStyleSettings;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.LoadCaption(
  AControl: TControl; StrPtr: Pointer);
begin
  TControlAccess(AControl).Caption := cxGetResourceString(StrPtr);
end;

procedure TcxfmSchedulerReportLinkDesignWindow.LoadCaption(
  AItem: TMenuItem; StrPtr: Pointer);
begin
  AItem.Caption := cxGetResourceString(StrPtr);
end;

procedure TcxfmSchedulerReportLinkDesignWindow.LoadStrings;
begin
  inherited LoadStrings;
  LoadStringsDaily;
  LoadStringsMonthly;
  LoadStringsWeekly;
  LoadStringsTrifold;
  LoadStringsDetails;
  LoadStringsMemo;
  LoadStringsOther;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.LoadStringsCombo(
  ACombo: TcxComboBox; ACaptions: array of Pointer);
var
  I: Integer;
begin
  with ACombo.Properties.Items do
  begin
    BeginUpdate;
    try
      Clear;
      for I := 0 to High(ACaptions) do
        if ACaptions[I] <> nil then Add(cxGetResourceString(ACaptions[I]));
    finally
      EndUpdate;
    end;
  end;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.LoadStringsDaily;
begin
  LoadCaption(lblPrintStyleDailyLayout, @sdxPrintStyleLayout);
  LoadStringsCombo(cbxPrintStyleDailyLayout,
    [@sdxPrintStyleDailyLayout1PPD,
    @sdxPrintStyleDailyLayout2PPD]);
  LoadCaption(lblPrintStyleDailyResourceCountPerPage,
    @sdxResourceCountPerPage);
  LoadCaption(lblPrintStyleDailyInclude,
    @sdxPrintStyleInclude);
  LoadCaption(chbxPrintStyleDailyTaskPad,
    @sdxPrintStyleIncludeTaskPad);
  LoadCaption(chbxPrintStyleDailyNotesAreaBlank,
    @sdxPrintStyleIncludeNotesAreaBlank);
  LoadCaption(chbxPrintStyleDailyNotesAreaLined,
    @sdxPrintStyleIncludeNotesAreaLined);
  LoadCaption(lblPrintStyleDailyPrintFrom, @sdxPrintStylePrintFrom);
  LoadCaption(lblPrintStyleDailyPrintTo, @sdxPrintStylePrintTo);
end;

procedure TcxfmSchedulerReportLinkDesignWindow.LoadStringsDetails;
begin
  LoadCaption(chbxPrintStyleDetailsUsePagination,
    @sdxPrintStyleDetailsStartNewPageEach);
  LoadStringsCombo(cbxPrintStyleDetailsPagination,
    [@sdxDay, @sdxWeek, @sdxMonth]);
end;

procedure TcxfmSchedulerReportLinkDesignWindow.LoadStringsMemo;
begin
  LoadCaption(chbxPrintStyleMemoStartEachItemOnNewPage,
    @sdxPrintStyleMemoStartEachItemOnNewPage);
  LoadCaption(chbxPrintStyleMemoPrintOnlySelectedEvents,
    @sdxPrintStyleMemoPrintOnlySelectedEvents);
end;

procedure TcxfmSchedulerReportLinkDesignWindow.LoadStringsMonthly;
begin
  LoadCaption(lblPrintStyleMonthlyLayout, @sdxPrintStyleLayout);
  LoadStringsCombo(cbxPrintStyleMonthlyLayout,
    [@sdxPrintStyleMonthlyLayout1PPM, @sdxPrintStyleMonthlyLayout2PPM]);
  LoadCaption(lblPrintStyleMonthlyResourceCountPerPage, @sdxResourceCountPerPage);
  LoadCaption(lblPrintStyleMonthlyInclude, @sdxPrintStyleInclude);
  LoadCaption(chbxPrintStyleMonthlyTaskPad, @sdxPrintStyleIncludeTaskPad);
  LoadCaption(chbxPrintStyleMonthlyNotesAreaBlank, @sdxPrintStyleIncludeNotesAreaBlank);
  LoadCaption(chbxPrintStyleMonthlyNotesAreaLined, @sdxPrintStyleIncludeNotesAreaLined);

  LoadCaption(chbxPrintStyleMonthlyDontPrintWeekends, @sdxPrintStyleDontPrintWeekEnds);
  LoadCaption(chbxPrintStyleMonthlyPrintExactlyOneMonthPerPage, @sdxPrintStyleMonthlyPrintExactly1MPP);
end;

procedure TcxfmSchedulerReportLinkDesignWindow.LoadStringsOther;

  procedure AdjustBevelSize(ABevel: TBevel; AControl: TControl);
  var
    Right: Integer;
  begin
    Right := ABevel.BoundsRect.Right;
    ABevel.Left := AControl.Left + AControl.Width + 10;
    ABevel.Width := Right - ABevel.Left;
  end;

begin
  lblPreviewWindow.Caption := DropAmpersand(cxGetResourceString(@sdxPreview));
  // Misc
  LoadCaption(tshPrintRange, @sdxPrintRanges);
  LoadCaption(lblPrintRangeStart, @sdxPrintRangeStart);
  LoadCaption(lblPrintRangeEnd, @sdxPrintRangeEnd);
  LoadCaption(lblPrintRangesMiscellaneous, @sdxMiscellaneous);
  LoadCaption(chbxHideDetailsOfPrivateAppointments,
    @sdxHideDetailsOfPrivateAppointments);
  LoadCaption(tshPrintStyles, @sdxTabPrintStyles);
  LoadCaption(lblPrintStylesOptions, @sdxOptions);
  AdjustBevelSize(bvlPrintStyleOptions, lblPrintStylesOptions);
  // Formatting
  LoadCaption(tshFormatting, @sdxFormatting);
  LoadCaption(lblLookAndFeel, @sdxLookAndFeel);
  AdjustBevelSize(bvlLookAndFeel, lblLookAndFeel);
  LoadStringsCombo(cbxLookAndFeel, [@sdxLookAndFeelFlat,
   @sdxLookAndFeelStandard, @sdxLookAndFeelUltraFlat]);
  LoadCaption(lblRefinements, @sdxRefinements);
  AdjustBevelSize(bvlRefinements, lblRefinements);
  LoadCaption(chbxSuppressBackgroundBitmaps, @sdxSuppressBackgroundBitmaps);
  LoadCaption(chbxSuppressContentColoration, @sdxSuppressContentColoration);
  // Styles
  LoadCaption(tshStyles, @sdxStyles);
  LoadCaption(lblUseNativeStyles, @sdxUseNativeStyles);
  AdjustBevelSize(bvlStyles, lblUseNativeStyles);
  LoadCaption(btnStyleColor, @sdxBtnColor);
  LoadCaption(btnStyleFont, @sdxBtnFont);
  LoadCaption(btnStyleBackgroundBitmap, @sdxBtnTexture);
  LoadCaption(btnStyleBackgroundBitmapClear, @sdxBtnTextureClear);
  LoadCaption(btnStyleRestoreDefaults, @sdxBtnRestoreDefaults);
  LoadCaption(btnStylesSaveAs, @sdxBtnSaveAs);
  LoadCaption(miStyleColor, @sdxBtnColor);
  LoadCaption(miStyleFont, @sdxBtnFont);
  LoadCaption(miStyleBackgroundBitmap, @sdxBtnTexture);
  LoadCaption(miStyleBackgroundBitmapClear, @sdxBtnTextureClear);
  LoadCaption(miStyleRestoreDefaults, @sdxBtnRestoreDefaults);
  LoadCaption(miStylesSelectAll, @sdxSelectAll);
  LoadCaption(miStylesSaveAs, @sdxBtnSaveAs);
  LoadCaption(lblStyleSheets, @sdxStyleSheets);
  AdjustBevelSize(bvlStyleSheets, lblStyleSheets);
  LoadCaption(btnStyleSheetNew, @sdxBtnNew);
  LoadCaption(btnStyleSheetCopy, @sdxBtnCopy);
  LoadCaption(btnStyleSheetDelete, @sdxBtnDelete);
  LoadCaption(btnStyleSheetRename, @sdxBtnRename);
end;

procedure TcxfmSchedulerReportLinkDesignWindow.LoadStringsTrifold;

  procedure FillTrifoldSectionStrings(ACombobox: TcxCombobox);
  begin
    LoadStringsCombo(ACombobox,
      [@sdxPrintStyleTrifoldSectionModeDailyCalendar,
       @sdxPrintStyleTrifoldSectionModeWeeklyCalendar,
       @sdxPrintStyleTrifoldSectionModeMonthlyCalendar,
       @sdxPrintStyleTrifoldSectionModeTaskPad,
       @sdxPrintStyleTrifoldSectionModeNotesBlank,
       @sdxPrintStyleTrifoldSectionModeNotesLined]);
  end;
  
begin
  LoadCaption(lblPrintStyleTrifoldSectionLeft, @sdxPrintStyleTrifoldSectionLeft);
  FillTrifoldSectionStrings(cbxPrintStyleTrifoldSectionLeft);
  LoadCaption(lblPrintStyleTrifoldSectionMiddle, @sdxPrintStyleTrifoldSectionMiddle);
  FillTrifoldSectionStrings(cbxPrintStyleTrifoldSectionMiddle);
  LoadCaption(lblPrintStyleTrifoldSectionRight, @sdxPrintStyleTrifoldSectionRight);
  FillTrifoldSectionStrings(cbxPrintStyleTrifoldSectionRight);
end;

procedure TcxfmSchedulerReportLinkDesignWindow.LoadStringsWeekly;
begin
  LoadCaption(lblPrintStyleWeeklyArrange, @sdxPrintStyleWeeklyArrange);
  LoadStringsCombo(cbxPrintStyleWeeklyArrange,
    [@sdxPrintStyleWeeklyArrangeT2B, @sdxPrintStyleWeeklyArrangeL2R]);

  LoadCaption(lblPrintStyleWeeklyLayout, @sdxPrintStyleLayout);
  LoadStringsCombo(cbxPrintStyleWeeklyLayout,
    [@sdxPrintStyleWeeklyLayout1PPW, @sdxPrintStyleWeeklyLayout2PPW]);
  LoadCaption(lblPrintStyleWeeklyResourceCountPerPage, @sdxResourceCountPerPage);
  LoadCaption(lblPrintStyleWeeklyInclude, @sdxPrintStyleInclude);
  LoadCaption(chbxPrintStyleWeeklyTaskPad, @sdxPrintStyleIncludeTaskPad);
  LoadCaption(chbxPrintStyleWeeklyNotesAreaBlank, @sdxPrintStyleIncludeNotesAreaBlank);
  LoadCaption(chbxPrintStyleWeeklyNotesAreaLined, @sdxPrintStyleIncludeNotesAreaLined);

  LoadCaption(lblPrintStyleWeeklyPrintFrom, @sdxPrintStylePrintFrom);
  LoadCaption(lblPrintStyleWeeklyPrintTo, @sdxPrintStylePrintTo);

  LoadCaption(chbxPrintStyleWeeklyDontPrintWeekends, @sdxPrintStyleDontPrintWeekEnds);
end;

procedure TcxfmSchedulerReportLinkDesignWindow.PreviewDrawPageContent(
  ACanvas: TCanvas; ABounds: TRect);
const
  AMessageFlags = CXTO_CENTER_HORIZONTALLY or CXTO_CENTER_VERTICALLY or CXTO_WORDBREAK;
var
  AMsg: PChar;
  R, R1: TRect;
  APrinter: TdxComponentPrinter;
  ALink: TcxSchedulerReportLink;
  ASource, ADest: TBitmap;
begin
  if ReportLink.Component = nil then
  begin
    ACanvas.Brush.Color := clWindow;
    ACanvas.FillRect(ABounds);
    Exit;
  end;
  APrinter := TdxComponentPrinter.Create(nil);
  try
    ALink := TcxSchedulerReportLink.Create(APrinter);
    ALink.LinkInPreviewMode := True;
    try
      ALink.Assign(ReportLink);
      ALink.PrinterPage.RestoreDefaults;
      ALink.Component := ReportLink.Component;
      ALink.ComponentPrinter := APrinter;
      AMsg := nil;
      with ALink do
        R1 := MakeBounds(0, 0, PageWidth, PageHeight);
      ASource := cxCreateBitmap(cxSize(R1.Right, R1.Bottom));
      ASource.Canvas.Lock;
      try
        R := cxRectOffset(ABounds, -ABounds.Left, -ABounds.Top);
        ALink.PrintStyles.ActiveStyle := ALink.PrintStyles[
          ReportLink.PrintStyles.IndexOf(ReportLink.PrintStyles.ActiveStyle)];
        ALink.RebuildReport;
        FillRect(ASource.Canvas.Handle, R1, GetSysColorBrush(COLOR_WINDOW));
        if ALink.PageCount > 0 then
          APrinter.PaintPage(ASource.Canvas, 0, R1, R1, ALink)
        else
          with ReportLink.PrintStyles do 
          begin
            if (FActiveStyle = Memo) and Memo.SelectedEventsOnly then
              AMsg := PChar(cxGetResourceString(@sdxCannotPrintNoSelectedItems))
            else
              AMsg := PChar(cxGetResourceString(@sdxCannotPrintNoItemsAvailable));
          end;
        ADest := cxCreateBitmap(cxSize(R.Right, R.Bottom));
        ADest.Canvas.Lock;
        try
          cxSmoothResizeBitmap(ASource, ADest);
          if AMsg <> nil then
            cxTextOut(ADest.Canvas.Handle, AMsg, R, AMessageFlags);
          ACanvas.Draw(0, 0, ADest);
        finally
          ADest.Canvas.UnLock;
          ADest.Free;
        end;
      finally
        ASource.Canvas.Unlock;
        ASource.Free;
      end;
    finally
      ALink.Free;
    end;
  finally
    APrinter.Free;
  end;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.UpdateControlsState;
begin
  inherited UpdateControlsState;

  UpdateEnabledControls([lblPrintStyleDailyPrintFrom, tePrintStyleDailyPrintFrom,
    lblPrintStyleDailyPrintTo, tePrintStyleDailyPrintTo],
    ReportLink.PrintStyles.Daily.SupportTimeRange);
  UpdateEnabledControls([lblPrintStyleWeeklyPrintFrom, tePrintStyleWeeklyPrintFrom,
    lblPrintStyleWeeklyPrintTo, tePrintStyleWeeklyPrintTo],
    ReportLink.PrintStyles.Weekly.SupportTimeRange);

  chbxPrintStyleWeeklyDontPrintWeekends.Enabled :=
    ReportLink.PrintStyles.Weekly.CanDontPrintWeekends;

  UpdateEnabled(lbxStyles, AreNativeStylesAvailable);
  UpdateEnabled(btnStyleColor, AreNativeStylesAvailable and HasSelectedStyles);
  UpdateEnabled(btnStyleFont,  AreNativeStylesAvailable and HasSelectedStyles);
  UpdateEnabled(btnStyleBackgroundBitmap, AreNativeStylesAvailable and HasSelectedStyles);
  UpdateEnabled(btnStyleBackgroundBitmapClear, AreNativeStylesAvailable and HasSelectedStylesWithAssignedBitmap);
  UpdateEnabled(btnStyleRestoreDefaults, AreNativeStylesAvailable and HasSelectedStyles);
  UpdateEnabled(btnStylesSaveAs, CanSaveStyles);

  UpdateEnabled(lblStyleSheets, AreNativeStylesAvailable);
  UpdateEnabled(cbxStyleSheets, AreNativeStylesAvailable);
  UpdateEnabled(btnStyleSheetNew, CanCreateStyleSheet);
  UpdateEnabled(btnStyleSheetCopy, CanCopyStyleSheet);
  UpdateEnabled(btnStyleSheetDelete, CanDeleteStyleSheet);
  UpdateEnabled(btnStyleSheetRename, CanRenameStyleSheet);
end;

procedure TcxfmSchedulerReportLinkDesignWindow.UpdateEnabled(
  AControl: TControl; AEnabled: Boolean);
begin
  TControlAccess(AControl).Enabled := AEnabled;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.UpdateEnabled(
  AItem: TMenuItem; AEnabled: Boolean);
begin
  AItem.Enabled := AEnabled;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.UpdateEnabledControls(
  AControls: array of TControl; AEnabled: Boolean);
var
  I: Integer;
begin
  for I := 0 to High(AControls) do
    UpdateEnabled(AControls[I], AEnabled);
end;

procedure TcxfmSchedulerReportLinkDesignWindow.UpdatePreview;
begin
  if Visible then
  begin
    RefreshPrintStyles;
    pbxPrintStylesPreview.Refresh;
    pbPreview.Refresh;
  end;
end;

function TcxfmSchedulerReportLinkDesignWindow.GetDesignerTabIndex: Integer;
begin
  Result := PageControl1.ActivePage.TabIndex;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.SetDesignerTabIndex(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if Value > PageControl1.PageCount - 1 then 
    Value := PageControl1.PageCount - 1;
  PageControl1.ActivePage := PageControl1.Pages[Value];
end;

procedure TcxfmSchedulerReportLinkDesignWindow.DoActiveStyleSheetChanged;
begin
  inherited;
  lbxStyles.ReportLinkStyles := ReportLink.ActiveStyles;
  with cbxStyleSheets do 
    ItemIndex := Properties.Items.IndexOfObject(ActiveStyleSheet);

  if not LockControlsUpdate then 
  begin
    Modified := True;
    UpdatePreview;
  end;  
end;

procedure TcxfmSchedulerReportLinkDesignWindow.DoFormActivated(AnActive: Boolean);
begin
  inherited;
  if not AnActive then lbxStyles.HideToolTips;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.DoRefreshStylesList;
var
  Styles: TcxSchedulerReportLinkStyles;
  List: TList;
begin
  Styles := ReportLink.ActiveStyles;
  with lbxStyles.Items do 
  begin
    BeginUpdate;
    try
      List := TList.Create;
      try
        SaveSelectedStyles(List);
        try
          Clear;
          AddObject(cxGetResourceString(@sdxSchedulerSchedulerHeader), Styles.SchedulerHeader);
          AddObject(cxGetResourceString(@sdxSchedulerContent), Styles.Content);
          AddObject(cxGetResourceString(@sdxSchedulerDateNavigatorContent), Styles.DateNavigatorContent);
          AddObject(cxGetResourceString(@sdxSchedulerDateNavigatorHeader), Styles.DateNavigatorHeader);
          AddObject(cxGetResourceString(@sdxSchedulerDayHeader), Styles.DayHeader);
          AddObject(cxGetResourceString(@sdxSchedulerEvent), Styles.Event);
          AddObject(cxGetResourceString(@sdxSchedulerResourceHeader), Styles.ResourceHeader);
          AddObject(cxGetResourceString(@sdxSchedulerNotesAreaBlank), Styles.NotesAreaBlank);
          AddObject(cxGetResourceString(@sdxSchedulerNotesAreaLined), Styles.NotesAreaLined);
          AddObject(cxGetResourceString(@sdxSchedulerTaskPad), Styles.TaskPad);
          AddObject(cxGetResourceString(@sdxSchedulerTimeRuler), Styles.TimeRuler);
        finally  
          RestoreSelectedStyles(List);
        end;  
      finally
        List.Free;
      end;
    finally
      EndUpdate;
    end;  
  end;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.DoStyleChanged(const ACaption: string;
  AStyle: TcxStyle);
begin
  inherited;
  Modified := True;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.DoStylesChanged(AStrings: TStrings;
  ARecreate: Boolean);
begin
  if ARecreate then 
    RecreateStylesListBox
  else
    lbxStyles.Invalidate;  
  Modified := True;
  UpdatePreview;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.GetSelectedStyleNames(AStrings: TStrings);
var
  I: Integer;
begin
  AStrings.Clear;
  with lbxStyles do
    for I := 0 to Items.Count - 1 do
      if Selected[I] then 
        AStrings.AddObject(Items[I], Items.Objects[I]);
end;

procedure TcxfmSchedulerReportLinkDesignWindow.GetStyleNames(out AStrings: TStrings);
begin
  AStrings := lbxStyles.Items;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.GetStyleSheetNames(out AStrings: TStrings);
begin
  AStrings := cbxStyleSheets.Properties.Items;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.ActivatePrintStyleTab;
begin
  pcPrintStyleOptions.ActivePageIndex := FindTabIndexByPrintStyle(ActivePrintStyle);
end;

procedure TcxfmSchedulerReportLinkDesignWindow.AssignTabSheetObjects;
begin
  with ReportLink.PrintStyles do
  begin
    tshDaily.Tag := MakeTTag(Daily);
    tshWeekly.Tag := MakeTTag(Weekly);
    tshMonthly.Tag := MakeTTag(Monthly);
    tshTrifold.Tag := MakeTTag(Trifold);
    tshDetails.Tag := MakeTTag(Details);
    tshMemo.Tag := MakeTTag(Memo);
  end;
end;

function TcxfmSchedulerReportLinkDesignWindow.FindTabIndexByPrintStyle(APrintStyle: TcxCustomSchedulerReportLinkPrintStyle): Integer;
begin
  for Result := 0 to pcPrintStyleOptions.PageCount - 1 do 
    if pcPrintStyleOptions.Pages[Result].Tag = MakeTTag(APrintStyle) then Exit;
  Result := -1;  
end;

procedure TcxfmSchedulerReportLinkDesignWindow.RefreshPrintStyles;
var
  AItems: TcxImageComboBoxItems;
  ActiveStyleIndex, I: Integer;

  procedure CheckAndAddPrintStyle(APrintStyle: TcxCustomSchedulerReportLinkPrintStyle);
  begin
    with TcxImageComboBoxItem(AItems.Add) do
    begin
      ImageIndex := APrintStyle.GlyphIndex;
      Description := APrintStyle.Caption;
      Value := Index;
      Tag := Integer(APrintStyle);
    end;
    if (ActiveStyleIndex = -1) and (APrintStyle = ReportLink.PrintStyles.ActiveStyle) then
      ActiveStyleIndex := AItems.Count - 1;
  end;

begin
  ActiveStyleIndex := cbxPrintStyles.ItemIndex;
  cbxPrintStyles.Properties.Images := StyleImages;
  AItems := cbxPrintStyles.Properties.Items;
  AItems.BeginUpdate;
  try
    AItems.Clear;
    for I := 0 to ReportLink.PrintStyles.Count - 1 do
      CheckAndAddPrintStyle(ReportLink.PrintStyles.Items[I]);
    cbxPrintStyles.ItemIndex := ActiveStyleIndex;
  finally
    AItems.EndUpdate;
  end;
end;

function TcxfmSchedulerReportLinkDesignWindow.GetActivePrintStyle: TcxCustomSchedulerReportLinkPrintStyle;
begin
  if cbxPrintStyles.ItemIndex <> -1 then
  begin
    with cbxPrintStyles.Properties.Items[cbxPrintStyles.ItemIndex] do
      Result := TcxCustomSchedulerReportLinkPrintStyle(Tag)
  end
  else
    Result := nil;
end;

function TcxfmSchedulerReportLinkDesignWindow.GetActiveStyle: TcxStyle;
begin
  with lbxStyles do
    if ItemIndex <> -1 then
      Result := TcxStyle(Items.Objects[ItemIndex])
    else
      Result := nil;
end;

function TcxfmSchedulerReportLinkDesignWindow.GetComponent: TcxScheduler;
begin
  Result := inherited Component as TcxScheduler;
end;

function TcxfmSchedulerReportLinkDesignWindow.GetHasSelectedStyles: Boolean;
begin
  Result := lbxStyles.SelCount <> 0;
end;                                     

function TcxfmSchedulerReportLinkDesignWindow.GetHasSelectedStylesWithAssignedBitmap: Boolean;
var
  Strings: TStrings;
  I: Integer;
  cxStyle: TcxStyle;
begin
  Result := True;
  Strings := TStringList.Create;
  try
    GetSelectedStyleNames(Strings);
    for I := 0 to Strings.Count - 1 do
    begin
      cxStyle := TcxStyle(Strings.Objects[I]);
      if (cxStyle <> nil) and (cxStyle.Bitmap <> nil) and not cxStyle.Bitmap.Empty then 
        Exit;
    end;  
  finally
    Strings.Free;
  end;  
  Result := False;
end;

function TcxfmSchedulerReportLinkDesignWindow.GetReportLink: TcxSchedulerReportLink;
begin
  Result := inherited ReportLink as TcxSchedulerReportLink;
end;

function TcxfmSchedulerReportLinkDesignWindow.CanSelectAllStyles: Boolean;
var
  I: Integer;
begin
  Result := AreNativeStylesAvailable;
  if Result then
  begin
    for I := 0 to lbxStyles.Items.Count - 1 do
      if not lbxStyles.Selected[I] then Exit;
    Result := False;
  end;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.CreateControls;

  procedure CreateStylesListBox;
  begin
    lbxStyles := TdxStylesListBox.Create(Self);
    lbxStyles.Parent := tshStyles;
    lbxStyles.BoundsRect := bvlStylesHost.BoundsRect;
    lbxStyles.PopupMenu := pmStyles;
    lbxStyles.TabOrder := chbxUseNativeStyles.TabOrder + 1;
    lbxStyles.OnClick := lbxStylesClick;
    bvlStylesHost.Visible := False;

    dxPSPopupMan.dxPSPopupMenuController.RegisterControl(lbxStyles);
  end;

begin
  CreateStylesListBox;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.RecreateStylesListBox;
var
  List: TList;
begin
  List := TList.Create;
  try
    SaveSelectedStyles(List);
    dxPSUtl.dxRecreateWnd(lbxStyles);
    RestoreSelectedStyles(List);
  finally
    List.Free;
  end;  
end;

procedure TcxfmSchedulerReportLinkDesignWindow.RestoreSelectedStyles(AList: TList);
var
  I: Integer;
begin
  for I := 0 to AList.Count - 1 do
    lbxStyles.Selected[Integer(AList[I])] := True;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.SaveSelectedStyles(AList: TList);
var
  I: Integer;
begin
  AList.Clear;
  for I := 0 to lbxStyles.Items.Count - 1 do
    if lbxStyles.Selected[I] then AList.Add(TObject(I));
end;

procedure TcxfmSchedulerReportLinkDesignWindow.SetActivePage;
begin
  PageControl1.ActivePage := PageControl1.Pages[DesignerTabIndex];
end;

procedure TcxfmSchedulerReportLinkDesignWindow.SetOptionsFormattingByIndex(AnIndex: Integer;
  AValue: Boolean);
begin
  if LockControlsUpdate then Exit;

  with ReportLink.OptionsFormatting do
    case AnIndex of
      0:
        begin
          UseNativeStyles := AValue;
          RecreateStylesListBox;
        end;
      1: SuppressBackgroundBitmaps := AValue;
      2: SuppressContentColoration := AValue;
    end;
  Modified := True;
  UpdatePreview;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.SetPrintStyleOptionsViewByIndex(AnIndex: Integer;
  AValue: Boolean);
begin
  if not LockControlsUpdate then
  begin
    case AnIndex of
      0:
        ActivePrintStyle.ShowTaskPad := AValue;
      1:
        ActivePrintStyle.ShowNotesAreaBlank := AValue;
      2:
        ActivePrintStyle.ShowNotesAreaLined := AValue;
    end;
    Modified := True;
    UpdatePreview;
  end;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.SetPrintStyleRangeByIndex(AnIndex: Integer;
  const ATime: TDateTime);
begin
  if not LockControlsUpdate then
  begin
    case AnIndex of
      0:
        ActivePrintStyle.TimePrintFrom := ATime;
      1:
        ActivePrintStyle.TimePrintTo := ATime;
    end;
    Modified := True;
    UpdatePreview; 
    UpdateControlsState;
  end;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.SetPrintStyleResourceCountPerPageByIndex(AnIndex: Integer;
  AValue: TcxEditValue);
begin
  if LockControlsUpdate then Exit;
  with ReportLink.PrintStyles do
    case AnIndex of
      0: Daily.ResourceCountPerPage := AValue;
      1: Weekly.ResourceCountPerPage := AValue;
      2: Monthly.ResourceCountPerPage := AValue;
    end;
  Modified := True;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);

  procedure ValidateEditors;
  begin
    FIsFormClosing := True;
    try
      dePrintRangeStart.ValidateEdit(False);
      dePrintRangeEnd.ValidateEdit(False);

      tePrintStyleDailyPrintFrom.ValidateEdit(False);
      tePrintStyleDailyPrintTo.ValidateEdit(False);
      tePrintStyleWeeklyPrintFrom.ValidateEdit(False);
      tePrintStyleWeeklyPrintTo.ValidateEdit(False);
    finally
      FisFormClosing := False;
    end;  
  end;
  
begin
  if ModalResult = mrOK then
  begin
    ValidateEditors;
    CanClose := IsValidConditions;
  end;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.PageControl1Change(Sender: TObject);
begin
  pnlPrintStylesPreview.Visible := PageControl1.ActivePage = tshPrintStyles;
  pnlPreview.Visible := PageControl1.ActivePage <> tshPrintStyles;
  lblPreviewWindow.Parent := PageControl1.ActivePage;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.lbxStylesClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  UpdateControlsState;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.btnStyleFontClick(Sender: TObject);
begin
  PerformStylesChangeFont;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.btnStyleColorClick(Sender: TObject);
begin
  PerformStylesChangeColor;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.btnStyleBackgroundBitmapClick(Sender: TObject);
begin
  PerformStylesChangeBitmap;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.btnStyleBackgroundBitmapClearClick(Sender: TObject);
begin
  PerformStylesClearBitmap;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.miStylesSelectAllClick(Sender: TObject);
{$IFNDEF DELPHI6}  
var
  I: Integer;
{$ENDIF}  
begin
  with lbxStyles do 
  begin
   {$IFDEF DELPHI6}
    SelectAll;
   {$ELSE}
    Items.BeginUpdate;
    try
      for I := 0 to Items.Count - 1 do
        Selected[I] := True; 
    finally
      Items.EndUpdate;
    end;    
   {$ENDIF} 
  end;
  UpdateControlsState;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.btnStyleRestoreDefaultsClick(Sender: TObject);
begin
  PerformStylesRestoreDefaults;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.btnStylesSaveAsClick(Sender: TObject);
begin
  PerformStylesSaveAsStyleSheet;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.cbxStyleSheetsClick(Sender: TObject);
begin
  with TcxComboBox(Sender) do 
    ActiveStyleSheet := TcxCustomStyleSheet(Properties.Items.Objects[ItemIndex]);
end;

procedure TcxfmSchedulerReportLinkDesignWindow.cbxStyleSheetsPropertiesDrawItem(
  AControl: TcxCustomComboBox; ACanvas: TcxCanvas; AIndex: Integer;
  const ARect: TRect; AState: TOwnerDrawState);
begin
  PerformStyleSheetDrawItem(ACanvas.Canvas, AIndex, ARect, AState, AControl.Enabled);
end;

procedure TcxfmSchedulerReportLinkDesignWindow.cbxStyleSheetsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  PerformStyleSheetKeyDown(Sender, Key, Shift);
end;

procedure TcxfmSchedulerReportLinkDesignWindow.btnStyleSheetNewClick(Sender: TObject);
begin
  PerformStyleSheetNew;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.btnStyleSheetCopyClick(Sender: TObject);
begin
  PerformStyleSheetCopy;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.btnStyleSheetDeleteClick(Sender: TObject);
begin
  PerformStyleSheetDelete;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.btnStyleSheetRenameClick(Sender: TObject);
begin
  PerformStyleSheetRename;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.lblUseNativeStylesClick(Sender: TObject);
begin
  if chbxUseNativeStyles.CanFocus then ActiveControl := chbxUseNativeStyles;
  chbxUseNativeStyles.Checked := not chbxUseNativeStyles.Checked;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.OptionsFormattingClick(Sender: TObject);
begin
  with TcxCheckBox(Sender) do
    SetOptionsFormattingByIndex(TTagToInt(Tag), Checked);
end;

procedure TcxfmSchedulerReportLinkDesignWindow.LookAndFeelChange(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  with TcxComboBox(Sender) do
    ReportLink.OptionsFormatting.LookAndFeelKind := TcxLookAndFeelKind(Properties.Items.Objects[ItemIndex]);
  Modified := True;
  UpdatePreview;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.pmStylesPopup(Sender: TObject);
begin
  lbxStyles.HideToolTips;
  UpdateEnabled(miStyleColor, AreNativeStylesAvailable and HasSelectedStyles);
  UpdateEnabled(miStyleFont, AreNativeStylesAvailable and HasSelectedStyles);
  UpdateEnabled(miStyleBackgroundBitmap, AreNativeStylesAvailable and HasSelectedStyles);
  UpdateEnabled(miStyleBackgroundBitmapClear, AreNativeStylesAvailable and HasSelectedStylesWithAssignedBitmap);
  UpdateEnabled(miStyleRestoreDefaults, AreNativeStylesAvailable and HasSelectedStyles);
  UpdateEnabled(miStylesSelectAll, CanSelectAllStyles);
  UpdateEnabled(miStylesSaveAs, CanSaveStyles);
end;

procedure TcxfmSchedulerReportLinkDesignWindow.dePrintRangeStartEditValueChanged(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.PrintRange.PrintFrom := TcxDateEdit(Sender).Date;
  Modified := True;
  UpdatePreview;
  UpdateControlsState;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.dePrintRangeEndEditValueChanged(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.PrintRange.PrintTo := TcxDateEdit(Sender).Date;
  Modified := True;
  UpdatePreview;
  UpdateControlsState;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.cbxPrintStylesClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  with ReportLink.PrintStyles do 
    FActiveStyle := Items[TcxComboBox(Sender).ItemIndex];
  ActivatePrintStyleTab;
  Modified := True;
  UpdatePreview;
  UpdateControlsState;
end;

// Daily
procedure TcxfmSchedulerReportLinkDesignWindow.cbxPrintStyleDailyLayoutClick(
  Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.PrintStyles.Daily.Layout :=
    TcxSchedulerReportLinkPeriodicPrintStyleLayout(TcxComboBox(Sender).ItemIndex);
  Modified := True;
  UpdatePreview;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.sePrintStyleResourceCountPerPagePropertiesChanged(
  Sender: TObject);
begin
  Modified := True;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.sePrintStyleResourceCountPerPagePropertiesEditValueChanged(
  Sender: TObject);
begin
  with TcxSpinEdit(Sender) do
    SetPrintStyleResourceCountPerPageByIndex(TTagToInt(Tag), Value);
end;

procedure TcxfmSchedulerReportLinkDesignWindow.chbxPrintStyleOptionsViewClick(
  Sender: TObject);
begin
  with TcxCheckBox(Sender) do
    SetPrintStyleOptionsViewByIndex(TTagToInt(Tag), Checked);
end;

procedure TcxfmSchedulerReportLinkDesignWindow.tePrintStylePrintRangePropertiesEditValueChanged(
  Sender: TObject);
begin
  with TcxTimeEdit(Sender) do
    SetPrintStyleRangeByIndex(TTagToInt(Tag), Time);
end;

procedure TcxfmSchedulerReportLinkDesignWindow.tePrintStylePrintRangePropertiesChange(
  Sender: TObject);
begin
  Modified := True;
end;

// Weekly
procedure TcxfmSchedulerReportLinkDesignWindow.cbxPrintStyleWeeklyArrangeClick(
  Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.PrintStyles.Weekly.Arrange :=
    TcxSchedulerReportLinkWeeklyPrintStyleArrange(TcxComboBox(Sender).ItemIndex);
  cbxPrintStyles.Invalidate;
  Modified := True;
  UpdatePreview;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.cbxPrintStyleWeeklyLayoutClick(
  Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.PrintStyles.Weekly.Layout :=
    TcxSchedulerReportLinkPeriodicPrintStyleLayout(TcxComboBox(Sender).ItemIndex);
  Modified := True;
  UpdatePreview;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.chbxPrintStyleWeeklyDontPrintWeekendsClick(
  Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.PrintStyles.Weekly.DontPrintWeekends := TcxCheckBox(Sender).Checked;
  Modified := True;
end;

// Monthly
procedure TcxfmSchedulerReportLinkDesignWindow.cbxPrintStyleMonthlyLayoutClick(
  Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.PrintStyles.Monthly.Layout :=
    TcxSchedulerReportLinkPeriodicPrintStyleLayout(TcxComboBox(Sender).ItemIndex);
  Modified := True;
  UpdatePreview;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.chbxPrintStyleMonthlyDontPrintWeekendsClick(
  Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.PrintStyles.Monthly.DontPrintWeekends :=
    TcxCheckBox(Sender).Checked;
  Modified := True;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.chbxPrintStyleMonthlyPrintExactlyOneMonthPerPageClick(
  Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.PrintStyles.Monthly.PrintExactlyOneMonthPerPage :=
    TcxCheckBox(Sender).Checked;
  Modified := True;
end;

// Tri-fold
procedure TcxfmSchedulerReportLinkDesignWindow.cbxPrintStyleTrifoldSectionModeClick(
  Sender: TObject);
begin
  if LockControlsUpdate or not (ActivePrintStyle is TcxSchedulerReportLinkTrifoldPrintStyle) then Exit;
  with TcxSchedulerReportLinkTrifoldPrintStyle(ActivePrintStyle) do
    FSections[TTagToInt(TcxComboBox(Sender).Tag)] := TcxSchedulerReportLinkTrifoldPrintStyleSectionMode(TcxComboBox(Sender).ItemIndex);
  Modified := True;
  UpdateControlsState;
end;

// Details
procedure TcxfmSchedulerReportLinkDesignWindow.chbxPrintStyleDetailsUsePaginationClick(
  Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.PrintStyles.Details.UsePagination := TcxCheckBox(Sender).Checked;
  Modified := True;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.cbxPrintStyleDetailsPaginationClick(
  Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.PrintStyles.Details.PaginationMode :=
    TcxSchedulerReportLinkDetailsPrintStylePaginationMode(TcxComboBox(Sender).ItemIndex);
  Modified := True;
end;

// Memo
procedure TcxfmSchedulerReportLinkDesignWindow.chbxPrintStyleMemoStartEachItemOnNewPageClick(
  Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.PrintStyles.Memo.StartEachItemOnNewPage := TcxCheckBox(Sender).Checked;
  Modified := True;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.chbxPrintStyleMemoPrintOnlySelectedEventsClick(
  Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.PrintStyles.Memo.SelectedEventsOnly := TcxCheckBox(Sender).Checked;
  Modified := True;
end;

procedure TcxfmSchedulerReportLinkDesignWindow.pbxPrintStylesPreviewPaint(Sender: TObject);
begin
  with TPaintBox(Sender) do
    if ActivePrintStyle <> nil then
      ActivePrintStyle.DrawDesignWindowPreview(Canvas, ClientRect);
end;

procedure TcxfmSchedulerReportLinkDesignWindow.StyleController1StyleChanged(
  Sender: TObject);
begin
//
end;

procedure TcxfmSchedulerReportLinkDesignWindow.pbPreviewPaint(
  Sender: TObject);
begin
  PreviewDrawPageContent(pbPreview.Canvas, pbPreview.ClientRect);
end;

procedure TcxfmSchedulerReportLinkDesignWindow.cbxLookAndFeelPropertiesChange(
  Sender: TObject);
begin
  ReportLink.OptionsFormatting.LookAndFeelKind := TcxLookAndFeelKind(cbxLookAndFeel.ItemIndex);
end;

{ TcxSchedulerReportPageSite }

procedure TcxSchedulerReportPageSite.ReadProperties(AReader: TdxPSDataReader);
begin
  inherited ReadProperties(AReader);
  FPageIndex := AReader.ReadInteger;
  FPrimaryPage := AReader.ReadBoolean;
end;

procedure TcxSchedulerReportPageSite.WriteProperties(AWriter: TdxPSDataWriter);
begin
  inherited WriteProperties(AWriter);
  AWriter.WriteInteger(FPageIndex);
  AWriter.WriteBoolean(FPrimaryPage);
end;

{ TcxSchedulerReportPageItemCell }

constructor TcxSchedulerReportPageItemCell.Create(AParent: TdxReportCell);
begin
  inherited Create(AParent);
  BorderClass := TdxPSCellUltraFlatBorder;
  ClipChildren := True;
end;

function TcxSchedulerReportPageItemCell.GetType: TcxSchedulerReportItemsType;
begin
  Result := srUnknownItem;
end;

procedure TcxSchedulerReportPageItemCell.SetCellViewParams(
  AItem: TdxReportVisualItem; const AParams: TcxViewParams);
begin
  ReportLink.SetCellViewParams(AItem, AParams);
end;

procedure TcxSchedulerReportPageItemCell.SetCellViewParams(
  AItem: TdxReportVisualItem; const AParams: TdxReportItemViewParams);
begin
  ReportLink.SetCellViewParams(AItem, AParams);
end;

function TcxSchedulerReportPageItemCell.GetPageIndex: Integer;
begin
  Result := PageSite.PageIndex;
end;

function TcxSchedulerReportPageItemCell.GetPageSite: TcxSchedulerReportPageSite;
var
  AParent: TdxReportCell;
begin
  AParent := inherited Parent;
  while (AParent <> nil) and not (AParent is TcxSchedulerReportPageSite) do
    AParent := AParent.Parent;
  Result := AParent as TcxSchedulerReportPageSite;
end;

function TcxSchedulerReportPageItemCell.GetPrimaryPage: Boolean;
begin
  Result := PageSite.PrimaryPage;
end;

function TcxSchedulerReportPageItemCell.GetReportLink: TcxSchedulerReportLink;
begin
  Result := TcxSchedulerReportLink(Renderer.ReportLink);
end;

{ TcxSchedulerReportNotesDataCell }

constructor TcxSchedulerReportNotesDataCell.Create(AParent: TdxReportCell);
begin
  inherited Create(AParent);
  TextAlignX := taCenterX;
  TextAlignY := taCenterY;
  CaptionHeight := 16;
  Data := cdidSchedulerNotesArea;
end;

procedure TcxSchedulerReportNotesDataCell.DrawContent(
  DC: HDC; AStage: TdxPSRenderStages);
var
  R: TRect;
  C, I: Integer;
begin
  inherited DrawContent(DC, AStage);
  if CaptionHeight <= 0  then Exit;
  R := GetInnerBounds(DC);
  FixupRect(DC, R);
  C := R.Bottom - R. Top;
  R.Bottom := R.Top + CaptionHeight;
  //
  if Caption <> '' then
  begin
    Renderer.DrawText(DC, R, -1, cxTextOffset,  cxTextOffset, Caption, Font,
      Color, TextAlignX, TextAlignY, False, MultiLine, False);
  end;
  //
  Inc(R.Bottom, Max(1, Renderer.LineThickness div 2));
  if Lined then
    C := (C - Renderer.LineThickness) div CaptionHeight
  else
    C := 1;
  R.Top := R.Bottom - Renderer.LineThickness;
  for I := 0 to C - 1 do
  begin
    FixupRect(DC, R);
    Renderer.FillRect(DC, R, clBlack);
    OffsetRect(R, 0, CaptionHeight);
  end;
end;

procedure TcxSchedulerReportNotesDataCell.ReadData(AReader: TdxPSDataReader);
begin
  inherited ReadData(AReader);
  FCaption := AReader.ReadString;
  FCaptionHeight := AReader.ReadInteger;
  FLined := AReader.ReadBoolean;
end;

procedure TcxSchedulerReportNotesDataCell.WriteData(AWriter: TdxPSDataWriter);
begin
  inherited WriteData(AWriter);
  AWriter.WriteString(FCaption);
  AWriter.WriteInteger(FCaptionHeight);
  AWriter.WriteBoolean(FLined);
end;

function TcxSchedulerReportNotesDataCell.GetMultiLine: Boolean;
begin
  Result := inherited MultiLine;
end;

function TcxSchedulerReportNotesDataCell.GetTextAlignX: TcxTextAlignX;
begin
  Result := inherited TextAlignX;
end;

function TcxSchedulerReportNotesDataCell.GetTextAlignY: TcxTextAlignY;
begin
  Result := inherited TextAlignY;
end;

procedure TcxSchedulerReportNotesDataCell.SetMultiLine(Value: Boolean);
begin
  inherited MultiLine := Value;
end;

procedure TcxSchedulerReportNotesDataCell.SetTextAlignX(
  Value: TcxTextAlignX);
begin
  inherited TextAlignX := Value;
end;

procedure TcxSchedulerReportNotesDataCell.SetTextAlignY(
  Value: TcxTextAlignY);
begin
  inherited TextAlignY := Value;
end;

{ TcxSchedulerReportNotesAreaCell }

constructor TcxSchedulerReportNotesAreaCell.Create(AParent: TdxReportCell);
begin
  inherited Create(AParent);
  AddDataItem(GetDataCellClass)
end;

constructor TcxSchedulerReportNotesAreaCell.CreateEx(AParent: TdxReportCell; ALined: Boolean);
begin
  Create(AParent);
  FLined := ALined;
  DataCell.CellSides := [];
  DataCell.Caption := cxGetResourceString(@sdxNotes);
  DataCell.Lined := ALined;
  ClipChildren := True;
end;

procedure TcxSchedulerReportNotesAreaCell.BoundsChanged;
begin
  inherited BoundsChanged;
  DataCell.BoundsRect := GetInnerBounds(0);
end;

procedure TcxSchedulerReportNotesAreaCell.ConvertCoords(
  APixelsNumerator, APixelsDenominator: Integer);
begin
  inherited ConvertCoords(APixelsNumerator, APixelsDenominator);
  DataCell.CaptionHeight := MulDiv(DataCell.CaptionHeight, APixelsNumerator, APixelsDenominator);
end;

function TcxSchedulerReportNotesAreaCell.GetType: TcxSchedulerReportItemsType;
begin
  Result := srNotesBlank;
  if DataCell.Lined then
    Result := srNotesLined;
end;

function TcxSchedulerReportNotesAreaCell.GetDataCellClass: TcxSchedulerReportNotesDataCellClass;
begin
  Result := TcxSchedulerReportNotesDataCell;
end;

procedure TcxSchedulerReportNotesAreaCell.SetFontIndex(Value: Integer);
begin
  inherited SetFontIndex(Value);
  if Font <> nil then
    DataCell.CaptionHeight := cxTextHeight(Font) + cxTextOffset * 2;
end;

function TcxSchedulerReportNotesAreaCell.GetDataCell: TcxSchedulerReportNotesDataCell;
begin
  if (DataItemCount > 0) and (DataItems[0] is TcxSchedulerReportNotesDataCell) then
    Result := TcxSchedulerReportNotesDataCell(DataItems[0])
  else
    Result := nil;
end;

{ TcxSchedulerReportTaskPadCell }

constructor TcxSchedulerReportTaskPadCell.CreateEx(
  AParent: TdxReportCell; ALined: Boolean);
begin
  inherited CreateEx(AParent, ALined);
  DataCell.Caption := cxGetResourceString(@sdxTaskPad);
  DataCell.Data := cdidSchedulerTaskPad;
end;

procedure TcxSchedulerReportTaskPadCell.BoundsChanged;
begin
  inherited;
  TaskPadDataSite.BoundsRect := CalculateTaskPadDataSiteBounds;
end;

function TcxSchedulerReportTaskPadCell.CalculateTaskPadDataSiteBounds: TRect;
begin
  Result := GetInnerBounds(NullDC);
  Inc(Result.Top, DataCell.CaptionHeight);
end;

function TcxSchedulerReportTaskPadCell.GetType: TcxSchedulerReportItemsType;
begin
  Result := srTaskPad;
end;

function TcxSchedulerReportTaskPadCell.GetTaskPadDataSite: TdxReportCell;
begin
  if CellCount = 0 then AddCell;
  Result := Cells[0];
  Result.CellSides := [];
  Result.BoundsRect := CalculateTaskPadDataSiteBounds;
end;

{ TcxSchedulerReportSchedulerHeaderDataCell }

constructor TcxSchedulerReportSchedulerHeaderDataCell.Create(AParent: TdxReportCell);
begin
  inherited Create(AParent);
  CellSides := [];
  Transparent := True;
  Data := cdidSchedulerSchedulerHeader;
end;

{ TcxSchedulerReportSchedulerHeaderCell }

constructor TcxSchedulerReportSchedulerHeaderCell.Create(AParent: TdxReportCell);
begin
  inherited Create(AParent);
  FContent := AddContentCell;
end;

procedure TcxSchedulerReportSchedulerHeaderCell.AdjustTextSize;
var
  R1, R2: TRect;
begin
  R1 := Content.BoundsRect;
  R2 := R1;
  if (SecondaryText <> '') and (PrimaryText <> '') then
  begin
    with R1 do
      Bottom := Bottom - (Bottom - Top) div 4;
    R2.Top := R1.Bottom;
  end;
  FPrimaryTextCell := AddTextCell(PrimaryText, R1, True);
  FSecondaryTextCell := AddTextCell(SecondaryText, R2, False);
  FContent.Index := MaxInt; //send to back
end;

function TcxSchedulerReportSchedulerHeaderCell.AddContentCell: TcxSchedulerReportSchedulerHeaderDataCell;
begin
  Result := TcxSchedulerReportSchedulerHeaderDataCell(AddDataItem(TcxSchedulerReportSchedulerHeaderDataCell));
end;

function TcxSchedulerReportSchedulerHeaderCell.AddTextCell(AText: string;
  const ABounds: TRect; AMultiLine: Boolean): TdxReportCellString;
var
  AFontH, ABoundsH: Integer;
  AParams: TdxReportItemViewParams;
begin
  if PrimaryText = '' then
  begin
    Result := nil;
    Exit;
  end;
  Result := AddDataItem(TdxReportCellString) as TdxReportCellString;
  Result.BoundsRect := ABounds;
  Result.Text := AText;
  Result.CellSides := [];
  Result.Transparent := True;
  Result.TextAlignY := taTop;
  Result.TextAlignX := taLeft;
  Result.Multiline := AMultiLine;
  if AMultiLine and (Pos('#13', AText) <> 0) then
    AText := Copy(AText, 1, Pos('#13', AText));
  AFontH := cxTextHeight(Font);
  ABoundsH := (ABounds.Bottom - ABounds.Top) - cxTextOffset * 2;
  if AMultiLine then
    ABoundsH := ABoundsH div 2;
  FillChar(AParams, SizeOf(AParams), 0);
  AParams.FontStyle := [];
  AParams.FontSize := MulDiv(Font.Size, ABoundsH, AFontH);
  while (AParams.FontSize > 3) and (cxTextWidth(Font, AText, AParams.FontSize) >
    ((ABounds.Right - ABounds.Left) - cxTextOffset * 2)) do Dec(AParams.FontSize, 2);
  AParams.Transparent := True;
  AParams.NativeParams.Font := Font;
  AParams.NativeParams.TextColor := Font.Color;
  ReportLink.SetCellViewParams(Result, AParams);
end;

function TcxSchedulerReportSchedulerHeaderCell.GetType: TcxSchedulerReportItemsType;
begin
  Result := srHeader;
end;

{ TcxSchedulerReportDateNavigatorItem }

constructor TcxSchedulerReportDateNavigatorItem.Create(AParent: TdxReportCell);
begin
  inherited Create(AParent);
  CellSides := [];
end;

function TcxSchedulerReportDateNavigatorItem.GetDefaultDTFormat: DWORD;
begin
  Result := CXTO_PATTERNEDTEXT or CXTO_SINGLELINE;
end;

procedure TcxSchedulerReportDateNavigatorItem.SetText(const Value: string);
begin
end;

function TcxSchedulerReportDateNavigatorItem.GetDateNavigator: TcxSchedulerReportDateNavigatorCell;
begin
  Result := Parent as TcxSchedulerReportDateNavigatorCell;
end;

{ TcxSchedulerReportDateNavigatorHeader }

constructor TcxSchedulerReportDateNavigatorHeader.CreateEx(AParent: TdxReportCell; AYear, AMonth: Word);
begin
  Create(AParent);
  Transparent := False;
  TextAlignX := taCenterX;
  Data := cdidSchedulerDateNavigatorHeader;
  FMonth := AMonth;
  FYear := AYear;
end;

procedure TcxSchedulerReportDateNavigatorHeader.Assign(Source: TPersistent);
begin
  if Source is TcxSchedulerReportDateNavigatorHeader then
    with TcxSchedulerReportDateNavigatorHeader(Source) do
    begin
      Self.FMonth := Month;
      Self.FYear := Year;
    end;
  inherited Assign(Source);
end;

function TcxSchedulerReportDateNavigatorHeader.GetText: string;
begin
  Result := LongMonthNames[Month] + ' ' + IntToStr(Year);
end;

procedure TcxSchedulerReportDateNavigatorHeader.ReadData(
  AReader: TdxPSDataReader);
begin
  inherited ReadData(AReader);
  FMonth := AReader.ReadInteger;
  FYear := AReader.ReadInteger;
end;

procedure TcxSchedulerReportDateNavigatorHeader.WriteData(
  AWriter: TdxPSDataWriter);
begin
  inherited WriteData(AWriter);
  AWriter.WriteInteger(FMonth);
  AWriter.WriteInteger(FYear);
end;

{ TcxSchedulerReportDateNavigatorDay }

constructor TcxSchedulerReportDateNavigatorDay.CreateEx(AParent: TdxReportCell;
  ADay, ACol, ARow: Integer; ABold: Boolean);
begin
  Create(AParent);
  RightIndent := 2;
  TextAlignX := taRight;
  TextAlignY := taCenterY;
  Data := cdidSchedulerDateNavigatorDay;
  FDay := ADay;
  FCol := ACol;
  FRow := ARow;
  Bold := ABold;
end;

procedure TcxSchedulerReportDateNavigatorDay.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TcxSchedulerReportDateNavigatorDay then
    with TcxSchedulerReportDateNavigatorDay(Source) do
    begin
      Self.FDay := Day;
      Self.FCol := Col;
      Self.FRow := Row;
    end;
end;

function TcxSchedulerReportDateNavigatorDay.GetText: string;
begin
  Result := IntToStr(Day);
end;

procedure TcxSchedulerReportDateNavigatorDay.ReadData(AReader: TdxPSDataReader);
var
  Value: Integer;
begin
  inherited ReadData(AReader);
  Value :=  AReader.ReadInteger;
  FDay := TLongRec(Value).Bytes[0];
  FCol := TLongRec(Value).Bytes[1];
  FRow := TLongRec(Value).Bytes[2];
end;

procedure TcxSchedulerReportDateNavigatorDay.WriteData(AWriter: TdxPSDataWriter);
var
  Value: Integer;
begin
  inherited WriteData(AWriter);
  TLongRec(Value).Bytes[0] := Day;
  TLongRec(Value).Bytes[1] := Col;
  TLongRec(Value).Bytes[2] := Row;
  AWriter.WriteInteger(Value);
end;

function TcxSchedulerReportDateNavigatorDay.GetDate: TDate;
begin
  Result := EncodeDate(Year, Month, Day);
end;

function TcxSchedulerReportDateNavigatorDay.GetBold: Boolean;
begin
  Result := GetFormatBit(dxFormatDayIsBold);
end;

function TcxSchedulerReportDateNavigatorDay.GetMonth: Word;
begin
  if DateNavigator <> nil then
    Result := DateNavigator.Month
  else
    Result := 1;
end;

function TcxSchedulerReportDateNavigatorDay.GetYear: Word;
begin
  if DateNavigator <> nil then
    Result := DateNavigator.Year
  else
    Result := 1;
end;

procedure TcxSchedulerReportDateNavigatorDay.SetBold(Value: Boolean);
begin
  SetFormatBit(dxFormatDayIsBold, Value);
end;

{ TcxSchedulerReportDateNavigatorDayCaption }

constructor TcxSchedulerReportDateNavigatorDayCaption.CreateEx(AParent: TdxReportCell;
  ADayOfWeek: TDay; ACol: Integer);
begin
  inherited Create(AParent);
  RightIndent := 2;
  TextAlignX := taRight;
  TextAlignY := taCenterY;
  Data := cdidSchedulerDateNavigatorDayCaption;
  FCol := ACol;
  FDayOfWeek := ADayOfWeek;
  FDayText := GetDayText;
end;

procedure TcxSchedulerReportDateNavigatorDayCaption.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TcxSchedulerReportDateNavigatorDayCaption then
    with TcxSchedulerReportDateNavigatorDayCaption(Source) do
    begin
      Self.FDayOfWeek := DayOfWeek;
      Self.FCol := Col;
      Self.FDayText := FDayText;
    end;
end;

function TcxSchedulerReportDateNavigatorDayCaption.GetText: string;
begin
  Result := FDayText;
end;

function TcxSchedulerReportDateNavigatorDayCaption.GetDayText: string;
var
  FDayIndex: Integer; 
begin
  FDayIndex := Byte(DateNavigator.StartOfWeek) + 1 + Col;
  if FDayIndex > 7 then Dec(FDayIndex, 7);

  if Font.Charset in [ARABIC_CHARSET, CHINESEBIG5_CHARSET, GB2312_CHARSET] then
    Result := AnsiLastChar(ShortDayNames[FDayIndex])
  else
    Result := WideString(ShortDayNames[FDayIndex])[1];
end;

procedure TcxSchedulerReportDateNavigatorDayCaption.ReadData(AReader: TdxPSDataReader);
begin
  inherited ReadData(AReader);
  FDayText := AReader.ReadString;
end;

procedure TcxSchedulerReportDateNavigatorDayCaption.WriteData(AWriter: TdxPSDataWriter);
begin
  inherited WriteData(AWriter);
  AWriter.WriteString(FDayText);
end;

{ TcxSchedulerReportDateNavigatorWeekNumber }

constructor TcxSchedulerReportDateNavigatorWeekNumber.CreateEx(AParent: TdxReportCell;
  AWeekNumber, ARow: Integer);
begin
  Create(AParent);
  RightIndent := 4;
  TextAlignX := taRight;
  TextAlignY := taCenterY;
  Data := cdidSchedulerDateNavigatorWeekNumber;
  FRow := ARow;
  FWeekNumber := AWeekNumber;
end;

procedure TcxSchedulerReportDateNavigatorWeekNumber.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TcxSchedulerReportDateNavigatorWeekNumber then
    with TcxSchedulerReportDateNavigatorWeekNumber(Source) do
    begin
      Self.FWeekNumber := WeekNumber;
      Self.FRow := Row;
    end;
end;

function TcxSchedulerReportDateNavigatorWeekNumber.GetText: string;
begin
  Result := IntToStr(WeekNumber);
end;

procedure TcxSchedulerReportDateNavigatorWeekNumber.ReadData(AReader: TdxPSDataReader);
var
  Value: Integer;
begin
  inherited ReadData(AReader);
  Value := AReader.ReadInteger;
  FWeekNumber := TLongRec(Value).Bytes[0];
  FRow := TLongRec(Value).Bytes[1];
end;

procedure TcxSchedulerReportDateNavigatorWeekNumber.WriteData(AWriter: TdxPSDataWriter);
var
  Value: Integer;
begin
  inherited WriteData(AWriter);
  TLongRec(Value).Bytes[0] := WeekNumber;
  TLongRec(Value).Bytes[1] := Row;
  AWriter.WriteInteger(Value);
end;

{ TcxSchedulerReportDateNavigatorCell }

constructor TcxSchedulerReportDateNavigatorCell.Create(AParent: TdxReportCell);
begin
  inherited Create(AParent);
  CellSides := [];
  Transparent := False;
  FStartOfWeek := TDay(DateTimeHelper.StartOfWeek);
end;

constructor TcxSchedulerReportDateNavigatorCell.CreateEx(AParent: TdxReportCell;
  AFirstWeekOfYear: TcxFirstWeekOfYear; AYear, AMonth: Word;
  AShowDatesContainingEventsInBold, AShowWeekNumbers: Boolean);
begin
  Create(AParent);
  FYear := AYear;
  FMonth := AMonth;
  FVertOffset := -1;
  FFirstWeekOfYear := AFirstWeekOfYear;
  FShowWeekNumbers := AShowWeekNumbers;
  FShowDatesContainingEventsInBold := AShowDatesContainingEventsInBold;
end;

procedure TcxSchedulerReportDateNavigatorCell.AdjustSize(var AContentParams,
  AHeaderParams: TdxReportItemViewParams; AHeight, AMaxHeight: Integer);

  function TestSize: Boolean;
  var
    ATestHeight: Integer;
  begin
    ATestHeight := GetMonthSize(AContentParams, AHeaderParams).cy;
    if AMaxHeight > (ATestHeight + RowHeight) then
    begin
      FVertOffset := (AMaxHeight - ATestHeight) div 2;
      Result := True;
    end
    else
      Result := False;
  end;

begin
  if TestSize then Exit;
  AContentParams.FontSize := Abs(AContentParams.NativeParams.Font.Size);
  AHeaderParams.FontSize := Abs(AHeaderParams.NativeParams.Font.Size);
  repeat
    if AContentParams.FontSize > AHeaderParams.FontSize then
      Dec(AContentParams.FontSize)
    else
      if AContentParams.FontSize < AHeaderParams.FontSize then
        Dec(AHeaderParams.FontSize)
      else
      begin
        Dec(AContentParams.FontSize);
        Dec(AHeaderParams.FontSize);
      end;
  until TestSize;
end;

function TcxSchedulerReportDateNavigatorCell.CalculateSize(
  const AContentParams, AHeaderParams: TdxReportItemViewParams): TSize;
begin
  FMonthSize := GetMonthSize(AContentParams, AHeaderParams);
  Result := FMonthSize;
  Inc(Result.cy, 2 * RowHeight);
  CreateItems;
  AdjustItemsVertical;
  SetViewParams(AContentParams, AHeaderParams);
end;

class function TcxSchedulerReportDateNavigatorCell.MeasureDateNavigatorHeight(
  const AContentParams, AHeaderParams: TcxViewParams): Integer;
var
  AColWidth, ARowHeight, ADayCaptionsHeight, AHeaderHeight: Integer;
begin
  GetContentPartSizes(AContentParams.Font, AColWidth, ARowHeight, ADayCaptionsHeight);
  GetHeaderPartSizes(AHeaderParams.Font, AHeaderHeight);
  Result := GetMonthHeight(AHeaderHeight, ADayCaptionsHeight, ARowHeight) + 2 * ARowHeight;
end;

procedure TcxSchedulerReportDateNavigatorCell.AdjustItemsVertical;
var
  I: Integer;
begin
  if FVertOffset < 0 then FVertOffset := RowHeight;
  for I := 0 to DataItemCount - 1 do
    with DataItems[I] do Top := Top + FVertOffset;
end;

function TcxSchedulerReportDateNavigatorCell.ColOfDate(ADate: TDateTime): Integer;
begin
  Result := DayOfWeek(ADate) - Byte(StartOfWeek) - 1;
  if Result < 0 then Inc(Result, 7);
end;

procedure TcxSchedulerReportDateNavigatorCell.CreateDayCaptions;
var
  R: TRect;
  I, ADayOfWeek: Integer;
  ACaption: TcxSchedulerReportDateNavigatorDayCaption;
begin
  R.Top := HeaderHeight;
  R.Bottom := R.Top + DayCaptionsHeight - 2;
  R.Right := ColWidth;
  FDayCaptionCount := 7;
  for I := 0 to FDayCaptionCount - 1 do
  begin
    ADayOfWeek := I + Byte(StartOfWeek);
    if ADayOfWeek > 6 then Dec(ADayOfWeek, 7);
    ACaption := TcxSchedulerReportDateNavigatorDayCaption.CreateEx(Self, TDay(ADayOfWeek), I);
    with ACaption do
    begin
      R.Left := R.Right;
      R.Right := R.Left + ColWidth;
      BoundsRect := R;
    end;
  end;
end;

procedure TcxSchedulerReportDateNavigatorCell.CreateDay(const ABounds: TRect;
  ADate: TDateTime; ACol, ARow: Integer);
var
  ADay: TcxSchedulerReportDateNavigatorDay;
begin
  ADay := TcxSchedulerReportDateNavigatorDay.CreateEx(Self, DayOf(ADate),
    ACol, ARow, GetDayIsBold(ADate));
  ADay.BoundsRect := ABounds;
end;

procedure TcxSchedulerReportDateNavigatorCell.CreateItems;
begin
  CreateMonthHeader;
  CreateDayCaptions;
  CreateMonth;
  CreateLines;
end;

procedure TcxSchedulerReportDateNavigatorCell.CreateLines;
var
  R: TRect;
begin
  R := GetHeaderBounds;
  R.Top := R.Bottom + DayCaptionsHeight;
  R.Bottom := R.Top + WeekNumberCount * RowHeight;
  with TdxReportCellBox.Create(Self) do
  begin
    if ShowWeekNumbers then CellSides := [csTop, csLeft] else CellSides := [csTop];
    BoundsRect := R;
  end;
end;

procedure TcxSchedulerReportDateNavigatorCell.CreateMonth;
var
  R: TRect;
  I, J, ADayBase, ADaysPerMonth: Integer;
  ADate, ADateBase: TDateTime;
  AHasDate: Boolean;

  function GetDate(out ADate: TDateTime): Boolean;
  begin
    ADate := ADateBase + ADayBase + J * 7 + I;
    Result := (ADate > ADateBase) and (ADate <= ADateBase + ADaysPerMonth);
  end;

begin
  FDayCount := 0;
  FWeekNumberCount := 0;
  ADateBase := EncodeDate(FYear, FMonth, 1) - 1;
  ADayBase := 1 - ColOfDate(ADateBase + 1);
  ADaysPerMonth := DaysPerMonth(FYear, FMonth);
  //loop has been split into two loops for the correct order of the DataItems
  for I := 0 to 6 do
    for J := 0 to 5 do
      if GetDate(ADate) then
      begin
        CreateDay(GetDayBoundsFromColAndRow(I, J), ADate, I, J);
        Inc(FDayCount);
      end;
  for I := 0 to 6 do
    for J := 0 to 5 do
    begin
      AHasDate := GetDate(ADate);
      if ShowWeekNumbers and (I = 0) and not ((J = 5) and not AHasDate) then
      begin
        R := cxRectOffset(GetDayBoundsFromColAndRow(I, J), -ColWidth, 0);
        Dec(R.Right, ColWidth div 8);
        CreateWeekNumber(R, ADate, J);
        Inc(FWeekNumberCount);
      end;
    end;
end;

procedure TcxSchedulerReportDateNavigatorCell.CreateMonthHeader;
begin
  TcxSchedulerReportDateNavigatorHeader.CreateEx(Self, Year, Month).BoundsRect := GetHeaderBounds;
end;

procedure TcxSchedulerReportDateNavigatorCell.CreateWeekNumber(
  const ABounds: TRect; ADate: TDateTime; ARow: Integer);
var
  AWeekNumber: TcxSchedulerReportDateNavigatorWeekNumber;
begin
  AWeekNumber := TcxSchedulerReportDateNavigatorWeekNumber.CreateEx(Self,
    cxDateUtils.GetWeekNumber(ADate, StartOfWeek, FirstWeekOfYear), ARow);
  AWeekNumber.BoundsRect := ABounds;
end;

class procedure TcxSchedulerReportDateNavigatorCell.GetContentPartSizes(
  AFont: TFont; var AColWidth, ARowHeight, ADayCaptionsHeight: Integer;
  AFontSize: Integer = 0);
var
  ASymbolSize: TSize;
begin
  ASymbolSize := cxTextExtent(AFont, '0', AFontSize);
  AColWidth := 3 * ASymbolSize.cx;
  ADayCaptionsHeight := ASymbolSize.cy + 1;
  ARowHeight := ASymbolSize.cy;
end;

function TcxSchedulerReportDateNavigatorCell.GetDayBoundsFromColAndRow(
  ACol, ARow: Integer): TRect;
begin
  with Result do
  begin
    Left := Succ(ACol) * ColWidth;
    Top  := HeaderHeight + DayCaptionsHeight + ARow * RowHeight;
    Right := Left + ColWidth;
    Bottom := Top + RowHeight;
  end;
end;

function TcxSchedulerReportDateNavigatorCell.GetDayIsBold(
  ADate: TDateTime): Boolean;
begin
  Result :=  FBoldedDays.IndexOf(ADate) <> -1; 
end;

function TcxSchedulerReportDateNavigatorCell.GetHeaderBounds: TRect;
begin
  Result := cxRect(ColWidth, 0, MonthSize.cx - MulDiv(ColWidth, 2, 3), HeaderHeight);
end;

class procedure TcxSchedulerReportDateNavigatorCell.GetHeaderPartSizes(
  AFont: TFont; var AHeaderHeight: Integer; AFontSize: Integer = 0);
begin
  AHeaderHeight := MulDiv(cxTextHeight(AFont, 'Wg', AFontSize), 3 , 2);
end;

function TcxSchedulerReportDateNavigatorCell.GetMonthSize(
  const AContentParams, AHeaderParams: TdxReportItemViewParams): TSize;
begin
  GetContentPartSizes(AContentParams.NativeParams.Font, FColWidth, FRowHeight,
    FDayCaptionsHeight, AContentParams.FontSize);
  GetHeaderPartSizes(AHeaderParams.NativeParams.Font, FHeaderHeight,
    AHeaderParams.FontSize);
  Result.cx := 9 * FColWidth;
  Result.cy := FHeaderHeight + FDayCaptionsHeight + 6 * FRowHeight + 1;
end;

function TcxSchedulerReportDateNavigatorCell.GetType: TcxSchedulerReportItemsType;
begin
  Result := srDateNavigator;
end;

procedure TcxSchedulerReportDateNavigatorCell.SetViewParams(
  const AContentParams, AHeaderParams: TdxReportItemViewParams);
var
  I: Integer;
  AParams: TdxReportItemViewParams;
begin
  FContentParams := AContentParams;
  FHeaderParams := AHeaderParams;
  SetCellViewParams(Self, AContentParams);
  SetCellViewParams(Header, AHeaderParams);
  for I := 0 to DayCount - 1 do
  begin
    AParams := AContentParams;
    if Days[I].Bold then
      Include(AParams.FontStyle, fsBold);
    SetCellViewParams(Days[I], AParams);
  end;
  for I := 0 to DayCaptionCount - 1 do
    SetCellViewParams(DayCaptions[I], AContentParams);
  AParams := AContentParams;
  if AParams.FontSize <> 0 then
    AParams.FontSize := MulDiv(AParams.FontSize, 2, 3)
  else
    AParams.FontSize := MulDiv(AParams.NativeParams.Font.Size, 2, 3);
  for I := 0 to WeekNumberCount - 1 do
    SetCellViewParams(WeekNumbers[I], AParams);
end;

procedure TcxSchedulerReportDateNavigatorCell.ReadData(AReader: TdxPSDataReader);
begin
  inherited ReadData(AReader);
  AReader.Read(FFirstWeekOfYear, SizeOf(FFirstWeekOfYear));
  FMonth := AReader.ReadInteger;
  FYear := AReader.ReadInteger;
  FShowDatesContainingEventsInBold := AReader.ReadBoolean;
  FShowWeekNumbers := AReader.ReadBoolean;
end;

procedure TcxSchedulerReportDateNavigatorCell.WriteData(AWriter: TdxPSDataWriter);
begin
  inherited WriteData(AWriter);
  AWriter.Write(FFirstWeekOfYear, SizeOf(FFirstWeekOfYear));
  AWriter.WriteInteger(FMonth);
  AWriter.WriteInteger(FYear);
  AWriter.WriteBoolean(FShowDatesContainingEventsInBold);
  AWriter.WriteBoolean(FShowWeekNumbers);
end;

class function TcxSchedulerReportDateNavigatorCell.GetMonthHeight(
  AHeaderHeight, ADayCaptionsHeight, ARowHeight: Integer): Integer;
begin
  Result := (AHeaderHeight + ADayCaptionsHeight + 6 * ARowHeight);
end;

function TcxSchedulerReportDateNavigatorCell.GetDay(
  Index: Integer): TcxSchedulerReportDateNavigatorDay;
begin
  Result := DataItems[Index + 1 + 7] as TcxSchedulerReportDateNavigatorDay;
end;

function TcxSchedulerReportDateNavigatorCell.GetDayCaption(
  Index: Integer): TcxSchedulerReportDateNavigatorDayCaption;
begin
  Result := DataItems[Index + 1] as TcxSchedulerReportDateNavigatorDayCaption;
end;

function TcxSchedulerReportDateNavigatorCell.GetHeader: TcxSchedulerReportDateNavigatorHeader;
begin
  Result := DataItems[0] as TcxSchedulerReportDateNavigatorHeader;
end;

function TcxSchedulerReportDateNavigatorCell.GetWeekNumber(
  Index: Integer): TcxSchedulerReportDateNavigatorWeekNumber;
begin
  Result := DataItems[Index + 1 + 7 + FDayCount] as TcxSchedulerReportDateNavigatorWeekNumber;
end;

{ TcxSchedulerReportSchedulingAreaCell }

constructor TcxSchedulerReportSchedulingAreaCell.Create(AParent: TdxReportCell);
begin
  inherited Create(AParent);
  FVisibleDays := TcxSchedulerDateList.Create;
  FDaysList := TStringList.Create;
  CellSides := [csLeft, csTop];
end;

destructor TcxSchedulerReportSchedulingAreaCell.Destroy;
begin
  FDaysList.Free;
  FVisibleDays.Free;
  inherited Destroy;
end;

procedure TcxSchedulerReportSchedulingAreaCell.DrawContent(
  DC: HDC; DrawRect: TRect; const OriginRect: TRect; AStage: TdxPSRenderStages);
begin
  inherited DrawContent(DC, DrawRect, OriginRect, AStage);
  if rsFirstPass in AStage then
    DrawBorders(DC);
end;

procedure TcxSchedulerReportSchedulingAreaCell.DrawItself(
  DC: HDC; AStage: TdxPSRenderStages);
begin
  if rsFirstPass in AStage then
  begin
    if IsBackgroundBitmapDrawn then
      DrawBackgroundBitmap(DC)
    else
      if IsBackgroundDrawn then
        DrawBackground(DC);
  end;
end;

function TcxSchedulerReportSchedulingAreaCell.GetType: TcxSchedulerReportItemsType;
begin
  Result := srSchedulingArea;
end;

{ TcxSchedulerReportCustomCell }

constructor TcxSchedulerReportCustomCell.CreateFrom(AParent: TdxReportCell;
  AViewInfo: TcxSchedulerCustomViewInfoItem);
begin
  inherited Create(AParent);
  Transparent := False;
  BoundsRect := AViewInfo.Bounds;
  CellSides := TdxCellSides(AViewInfo.Borders);
end;

procedure TcxSchedulerReportCustomCell.DrawContent(DC: HDC; AStage: TdxPSRenderStages);
begin
  inherited;
  //Renderer.ExcludeClipRect(GetFixupRect(DC, BoundsRect));
end;

class procedure TcxSchedulerReportCustomCell.RegisterMirrorClass;
begin
  MirrorClasses.Add(Self);
end;

class function TcxSchedulerReportCustomCell.SchedulerCellClass: TcxSchedulerCustomViewInfoItemClass;
begin
  Result := nil;
end;

procedure TcxSchedulerReportCustomCell.SuppressColoration;
begin
  FDayBorderColor := clBlack;
  Color := dxPSCore.dxDefaultContentColor;
end;

procedure TcxSchedulerReportCustomCell.DrawCellFrame(DC: HDC; const ARect: TRect;
  ABorders: TcxBorders = []; ABorderColor: TColor = clDefault; ALineWidth: Integer = 1);
begin
   Renderer.FrameRect(DC, GetFixupRect(DC, ARect),
     ABorderColor, TdxCellSides(ABorders), ALineWidth);
end;

procedure TcxSchedulerReportCustomCell.DrawCellRect(DC: HDC; const ARect: TRect;
  ABorders: TcxBorders = []; ABorderColor: TColor = clDefault; ALineWidth: Integer = 1;
  AColor: TColor = clDefault);
var
  R: TRect;
begin
  if Transparent then
    DrawCellFrame(DC, ARect, ABorders, ABorderColor, ALineWidth)
  else
  begin
    R := GetFixupRect(DC, ARect);
    if AColor = clDefault then
      AColor := Color;
    Renderer.FillRect(DC, R, AColor);
    Renderer.FrameRect(DC, R, ABorderColor, TdxCellSides(ABorders), ALineWidth);
  end;
end;

procedure TcxSchedulerReportCustomCell.DrawCellText(DC: HDC; const ARect: TRect;
  const AText: string; AlignHorz: TcxTextAlignX; AlignVert: TcxTextAlignY;
  AFont: TFont = nil; AColor: TColor = clDefault);
const
  Horz: array[TcxTextAlignX] of Integer =
    (CXTO_LEFT, CXTO_CENTER_HORIZONTALLY, CXTO_RIGHT, CXTO_LEFT, CXTO_LEFT);
  Vert: array[TcxTextAlignY] of Integer =
    (CXTO_TOP, CXTO_CENTER_VERTICALLY, CXTO_BOTTOM, CXTO_TOP);
var
  R: TRect;
  AMode: Integer;
  Flags: Integer;
begin
  if Length(AText) = 0 then Exit;
  R := GetFixupRect(DC, ARect);
  Flags := CXTO_PREVENT_LEFT_EXCEED or CXTO_PREVENT_TOP_EXCEED or CXTO_NOCLIP or
    Horz[AlignHorz] or Vert[AlignVert] + CXTO_SINGLELINE;
  if AFont = nil then
    AFont := Font;
  AMode := SetBkMode(DC, Windows.TRANSPARENT);
  Renderer.DrawTextEx(DC, R, -1, cxTextOffset,
    cxTextOffset, AText, AFont, Flags);
  SetBkMode(DC, AMode);
end;

procedure TcxSchedulerReportCustomCell.DrawCellTextVert(DC: HDC; const ARect: TRect;
  const AText: string);

  function CreateRotatedFont: HFONT;
  var
    ALogFont: TLogFont;
  begin
    FillChar(ALogFont, SizeOf(ALogFont), 0);
    with ALogFont do
    begin
      lfHeight := Font.Height;
      lfEscapement := 900;
      if fsBold in Font.Style then
        lfWeight := FW_BOLD
      else
        lfWeight := FW_NORMAL;
      lfItalic := Byte(fsItalic in Font.Style);
      lfUnderline := Byte(fsUnderline in Font.Style);
      lfStrikeOut := Byte(fsStrikeOut in Font.Style);
      lfCharSet := Byte(Font.Charset);
      StrPCopy(lfFaceName, Font.Name);
      case Font.Pitch of
        fpVariable: lfPitchAndFamily := VARIABLE_PITCH;
        fpFixed: lfPitchAndFamily := FIXED_PITCH;
      else
        lfPitchAndFamily := DEFAULT_PITCH;
      end;
    end;
    Result := CreateFontIndirect(ALogFont);
  end;

var
  R: TRect;
  AFont: THandle;
  ASavedDC: Integer;
  ASize: TSize;
begin
  if Length(AText) = 0 then Exit;
  ASavedDC := SaveDC(DC);
  AFont := CreateRotatedFont;
  SelectObject(DC, AFont);
  SetTextAlign(DC, TA_LEFT or TA_TOP or TA_NOUPDATECP);
  GetTextExtentPoint(DC, PChar(AText), Length(AText), ASize);
  R.Bottom := ARect.Bottom - ((ARect.Bottom - ARect.Top - ASize.cx) div 2);
  R.Top := R.Bottom - ASize.cx;
  R.Left := ARect.Left + ((ARect.Right - ARect.Left - ASize.cy) div 2);
  R.Right := R.Left + ASize.cy;
  if R.Left < ARect.Left then R := cxRectOffset(R, ARect.Left - R.Left, 0);
  if R.Top < ARect.Top then R := cxRectOffset(R, 0, ARect.Top - R.Top);
  R := GetFixupRect(DC, R);
  TextOut(DC, R.Left, R.Bottom, PChar(AText), Length(AText));
  RestoreDC(DC, ASavedDC);
  DeleteObject(AFont);
end;

procedure TcxSchedulerReportCustomCell.DrawCellState(DC: HDC; R: TRect;
  AState: Integer; ABorders: TcxBorders = []; ABorderColor: TColor = clBlack);
var
  ABrushHandle: HBrush;
  APenHandle: HPen;
  Points: array[0..2] of TPoint;
begin
  FixupRect(DC, R);
  if R.Top = R.Bottom then
  begin
    R := ExcludeBorders(R, ABorders);
    ABrushHandle := SelectObject(DC, StateBrushes[AState].Handle);
    APenHandle := SelectObject(DC, GetStockObject(BLACK_PEN));
    Points[0] := Point(R.Left, R.Top);
    Points[1] := Point(R.Right, R.Top);
    Points[2] := Point(R.Right, R.Top + R.Right - R.Left);
    Windows.Polygon(DC, Points, 3);
    SelectObject(DC, APenHandle);
    SelectObject(DC, ABrushHandle);
  end
  else
  begin
    DrawCellFrame(DC, R, ABorders, ABorderColor, 1);
    FillRect(DC, ExcludeBorders(R, ABorders), StateBrushes[AState].Handle);
  end;
end;

function TcxSchedulerReportCustomCell.ExcludeBorders(const ARect: TRect;
  ABorders: TcxBorders; ABorderWidth: Integer = 1): TRect;
begin
  Result := ARect;
  with Result do
  begin
    if bLeft in ABorders then
      Inc(Left, ABorderWidth * LineThickness);
    if bRight in ABorders then
      Dec(Right, ABorderWidth * LineThickness);
    if bTop in ABorders then
      Inc(Top, ABorderWidth * LineThickness);
    if bBottom in ABorders then
      Dec(Bottom, ABorderWidth * LineThickness);
  end;
end;

function TcxSchedulerReportCustomCell.FixupWidth(AWidth: Integer): Integer;
begin
  if not Renderer.IsPrinting then
    Result := MulDiv(AWidth * Renderer.UnitsPerPixel, Renderer.ZoomFactor, 100)
  else
    Result := MulDiv(AWidth * Renderer.UnitsPerPixel, Renderer.PPI * 5, 72 * 7);
end;

function TcxSchedulerReportCustomCell.GetFixupRect(DC: HDC; const ARect: TRect): TRect;
begin
  Result := ARect;
  FixupRect(DC, Result);
end;

function TcxSchedulerReportCustomCell.InflateRect(const ARect: TRect; dX, dY: Integer): TRect;
begin
  Result := ARect;
end;

function TcxSchedulerReportCustomCell.TextRect(const ARect: TRect): TRect;
var
  L: Integer;
begin
  L := FixupWidth(cxTextOffset);
  Result := ARect;
  InflateRect(Result, -L, -L);
end;

function TcxSchedulerReportCustomCell.GetReportLink: TcxSchedulerReportLink;
begin
  Result := TcxSchedulerReportLink(Renderer.ReportLink);
end;

{ TcxSchedulerReportContentCell }

constructor TcxSchedulerReportContentCell.CreateFrom(
  AParent: TdxReportCell; AViewInfo: TcxSchedulerCustomViewInfoItem);
var
  R: TRect;
begin
  inherited CreateFrom(AParent, AViewInfo);
  Data := cdidSchedulerContent;
  if AViewInfo is TcxSchedulerContentCellViewInfo then
    with TcxSchedulerContentCellViewInfo(AViewInfo) do
    begin
      R := Bounds;
      //Self.FDontPrint := DontPrint;
      Self.BoundsRect := R;
      Self.FBorderColor := BorderColor;
      Self.FShowTimeLine := ShowTimeLine;
      Self.FTimeLineBorders := TimeLineBorders;
      if TimeEvent <> nil then
        Self.FState := TimeEvent.Event.State
      else
        Self.FState := -1;
      if ShowTimeLine then
      begin
        CellSideColors[csRight] := clBlack;
        CellSideColors[csbottom] := FBorderColor;
      end;
      CellSides := csAll;
    end;
end;

procedure TcxSchedulerReportContentCell.Assign(Source: TPersistent);
begin
  if Source is TcxSchedulerReportContentCell then
    with TcxSchedulerReportContentCell(Source) do
    begin
      Self.FBorderColor := FBorderColor;
      Self.FShowTimeLine := FShowTimeLine;
      Self.FState := FState;
      Self.FTimeLineBorders := FTimeLineBorders;
    end;
  inherited Assign(Source);
end;

procedure TcxSchedulerReportContentCell.DrawContent(DC: HDC;
  AStage: TdxPSRenderStages);
var
  R: TRect;
begin
  inherited DrawContent(DC, AStage);
  R := BoundsRect;
  if FShowTimeLine then
  begin
    R.Right := R.Left + FixupWidth(cxTimeLineWidth);
    if FState = -1 then
      DrawCellRect(DC, R, FTimeLineBorders - [bLeft], clBlack, 1, clWhite)
    else
      DrawCellState(DC, R, FState, FTimeLineBorders, clBlack);
  end
end;

class function TcxSchedulerReportContentCell.SchedulerCellClass: TcxSchedulerCustomViewInfoItemClass;
begin
  Result := TcxSchedulerContentCellViewInfo;
end;

procedure TcxSchedulerReportContentCell.SuppressColoration;
var
  I: TdxCellSide;
begin
  for I := csLeft to csBottom do
    CellSideColors[I] := clBlack;
  FBorderColor := clBlack;
  if FState <> -1 then
    Inc(FState, 4);
  inherited SuppressColoration;
end;

function TcxSchedulerReportContentCell.HasBorderColoration: Boolean;
begin
  Result := True;
end;

{ TcxSchedulerReportHeaderItemCell }

constructor TcxSchedulerReportHeaderItemCell.CreateFrom(
  AParent: TdxReportCell; AViewInfo: TcxSchedulerCustomViewInfoItem);
begin
  inherited CreateFrom(AParent, AViewInfo);
  Data := cdidSchedulerHeader;
  if AViewInfo is TcxSchedulerHeaderCellViewInfo then
    with TcxSchedulerHeaderCellViewInfo(AViewInfo) do
    begin
      Self.TextAlignX := TextAlignXMap[AlignHorz];
      Self.TextAlignY := TextAlignYMap[AlignVert];
      Self.FRotateText := RotateText;
      Self.FCaption := DisplayText;
      Self.FIsResourceHeader := IsResourceHeader;
      Self.FResourceID := ResourceID;
    end;
  CellSides := csAll;
  ReportLink.RegisterLookAndFeelItem(Self, cesRaised);
end;

procedure TcxSchedulerReportHeaderItemCell.Assign(Source: TPersistent);
begin
  if Source is TcxSchedulerReportHeaderItemCell then
    with TcxSchedulerReportHeaderItemCell(Source) do
    begin
      Self.FCaption := FCaption;
      Self.FDate := FDate;
      Self.FResourceID := FResourceID;
      Self.FRotateText := FRotateText;
    end;
  inherited Assign(Source);
end;

procedure TcxSchedulerReportHeaderItemCell.DrawContent(
  DC: HDC; AStage: TdxPSRenderStages);
begin
  inherited DrawContent(DC, AStage);
  if FRotateText then
    DrawCellTextVert(DC, BoundsRect, FCaption)
  else
    DrawCellText(DC, BoundsRect, FCaption, TextAlignX, TextAlignY, Font);
end;

class function TcxSchedulerReportHeaderItemCell.SchedulerCellClass: TcxSchedulerCustomViewInfoItemClass;
begin
  Result := TcxSchedulerHeaderCellViewInfo;
end;

procedure TcxSchedulerReportHeaderItemCell.ReadData(AReader: TdxPSDataReader);
begin
   inherited ReadData(AReader);
  FRotateText := AReader.ReadBoolean;
  FCaption  := AReader.ReadString;
end;

procedure TcxSchedulerReportHeaderItemCell.WriteData(AWriter: TdxPSDataWriter);
begin
  inherited WriteData(AWriter);
  AWriter.WriteBoolean(FRotateText);
  AWriter.WriteString(FCaption);
end;

function TcxSchedulerReportHeaderItemCell.GetTextAlignX: TcxTextAlignX;
begin
  Result := inherited TextAlignX;
end;

function TcxSchedulerReportHeaderItemCell.GetTextAlignY: TcxTextAlignY;
begin
  Result := inherited TextAlignY;
end;

procedure TcxSchedulerReportHeaderItemCell.SetTextAlignX(
  Value: TcxTextAlignX);
begin
  inherited TextAlignX := Value;
end;

procedure TcxSchedulerReportHeaderItemCell.SetTextAlignY(
  Value: TcxTextAlignY);
begin
  inherited TextAlignY := Value;
end;

{ TcxSchedulerReportGroupSeparatorCell }

constructor TcxSchedulerReportGroupSeparatorCell.CreateFrom(
  AParent: TdxReportCell; AViewInfo: TcxSchedulerCustomViewInfoItem);
begin
  inherited CreateFrom(AParent, AViewInfo);
  CellSides := csAll;
  ReportLink.RegisterLookAndFeelItem(Self, cesRaised);
end;

class function TcxSchedulerReportGroupSeparatorCell.SchedulerCellClass: TcxSchedulerCustomViewInfoItemClass;
begin
  Result := TcxSchedulerGroupSeparatorCellViewInfo;
end;

{ TcxSchedulerReportContainerCell }

class function TcxSchedulerReportContainerCell.SchedulerCellClass: TcxSchedulerCustomViewInfoItemClass;
begin
  Result := TcxSchedulerContainerCellViewInfo;
end;

{ TcxSchedulerReportBackgroundSlotCell }

constructor TcxSchedulerReportBackgroundSlotCell.CreateFrom(
  AParent: TdxReportCell; AViewInfo: TcxSchedulerCustomViewInfoItem);
begin
  inherited CreateFrom(AParent, AViewInfo);
  if AViewInfo is TcxSchedulerBackgroundSlotCellViewInfo then
    with TcxSchedulerBackgroundSlotCellViewInfo(AViewInfo) do
      Self.FDisplayText := DisplayText;
end;

procedure TcxSchedulerReportBackgroundSlotCell.DrawContent(
  DC: HDC; AStage: TdxPSRenderStages);
begin
  DrawCellRect(DC, BoundsRect, TcxBorders(CellSides), clWindowText);
  DrawCellText(DC, BoundsRect, DisplayText, taLeft, taTop);
end;

class function TcxSchedulerReportBackgroundSlotCell.SchedulerCellClass: TcxSchedulerCustomViewInfoItemClass;
begin
  Result := TcxSchedulerBackgroundSlotCellViewInfo;
end;

procedure TcxSchedulerReportBackgroundSlotCell.ReadData(AReader: TdxPSDataReader);
begin
  inherited ReadData(AReader);
  FDisplayText := AReader.ReadString;
end;

procedure TcxSchedulerReportBackgroundSlotCell.WriteData(AWriter: TdxPSDataWriter);
begin
  inherited WriteData(AWriter);
  AWriter.WriteString(FDisplayText);
end;

{ TcxSchedulerReportDailyTimeRulerCellsSite }

constructor TcxSchedulerReportDailyTimeRulerCellsSite.Create(AParent: TdxReportCell);
begin
  inherited Create(AParent);
  FLargeFont := TFont.Create;
  FontIndex := ReportCells.ReportLink.AddFontToPool(Font);
  CellSides := [];
end;

destructor TcxSchedulerReportDailyTimeRulerCellsSite.Destroy;
begin
  FLargeFont.Free;
  inherited Destroy;
end;

procedure TcxSchedulerReportDailyTimeRulerCellsSite.SetFontIndex(Index: Integer);
begin
  inherited SetFontIndex(Index);
  if Font <> nil then
  begin
    FLargeFont.Assign(Font);
    FLargeFont.Size := Font.Size * 2;
    FLargeFontIndex := ReportCells.ReportLink.AddFontToPool(FLargeFont);
  end;
end;

procedure TcxSchedulerReportDailyTimeRulerCellsSite.ReadProperties(
  AReader: TdxPSDataReader);
begin
  inherited ReadProperties(AReader);
  FLargeFontIndex := AReader.ReadInteger;
end;

procedure TcxSchedulerReportDailyTimeRulerCellsSite.WriteProperties(
  AWriter: TdxPSDataWriter);
begin
  inherited WriteProperties(AWriter);
  AWriter.WriteInteger(FLargeFontIndex);
end;

function TcxSchedulerReportDailyTimeRulerCellsSite.GetLargeFont: TFont;
begin
  if (FLargeFontIndex <> -1) and (ReportCells <> nil) then
    Result := ReportCells.GetFontByIndex(FLargeFontIndex)
  else
    Result := nil;
end;

{ TcxSchedulerReportDailyTimeRulerCell }

constructor TcxSchedulerReportDailyTimeRulerCell.CreateFrom(
  AParent: TdxReportCell; AViewInfo: TcxSchedulerCustomViewInfoItem);
var
  I: Boolean;
begin
  inherited CreateFrom(AParent, AViewInfo);
  CellSides := [csRight];
  Data := cdidSchedulerTimeRuler;
  FLineColor := clBtnShadow;
  TimeRulerSite.Width := Max(TimeRulerSite.Width, Width);
  if AViewInfo is TcxSchedulerTimeRulerCellViewInfo then
    with TcxSchedulerTimeRulerCellViewInfo(AViewInfo) do
    begin
      TimeRulerSite.Height := Max(TimeRulerSite.Height, ClipRect.Bottom);
      Self.FHour := Hour;
      Self.FHasAdditionalTimeZone := HasAdditionalTimeZone;
      Self.FLineCount:= LineCount;
      for I := False to True do
      begin
        Self.FBounds[I] := Bounds[I];
        Self.FDisplayTexts[I] := DisplayTexts[I];
      end;
    end;
end;

procedure TcxSchedulerReportDailyTimeRulerCell.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TcxSchedulerReportDailyTimeRulerCell then
  with TcxSchedulerReportDailyTimeRulerCell(Source) do
  begin
    Self.FHasAdditionalTimeZone := FHasAdditionalTimeZone;
    Self.FLineCount := FLineCount;
    Self.FBounds[False] := FBounds[False];
    Self.FBounds[True] := FBounds[True];
    Self.FDisplayTexts[False] := FDisplayTexts[False];
    Self.FDisplayTexts[True] := FDisplayTexts[True];
    Self.FHour := FHour;
  end;
end;

procedure TcxSchedulerReportDailyTimeRulerCell.DrawContent(
  DC: HDC; AStage: TdxPSRenderStages);
var
  I: Boolean;
const
  ABorders: array[Boolean] of TcxBorders = ([bBottom], [bBottom, bRight]);
begin
  if Index = 0 then
    CellSides := CellSides + [csBottom];
  inherited;
  CalculateDisplayInfo;
  for I := not HasAdditionalTimeZone to True do
  begin
    if Hour >= 0 then
      DrawTimeZone(DC, Bounds[I], DisplayTexts[I], I)
    else
      DrawTimeZoneLabel(DC, Bounds[I], DisplayTexts[I], ABorders[I]);
  end;
end;

class function TcxSchedulerReportDailyTimeRulerCell.SchedulerCellClass: TcxSchedulerCustomViewInfoItemClass;
begin
  Result := TcxSchedulerTimeRulerCellViewInfo;
end;

procedure TcxSchedulerReportDailyTimeRulerCell.SuppressColoration;
begin
  inherited SuppressColoration;
  FLineColor := clBlack;
end;

procedure TcxSchedulerReportDailyTimeRulerCell.CalculateDisplayInfo;
begin
  FBounds[True] := BoundsRect;
  FBounds[False] := BoundsRect;
  if HasAdditionalTimeZone then
  begin
    FBounds[True].Left := cxRectCenter(BoundsRect).X;
    FBounds[False].Right := FBounds[True].Left;
  end;
end;

procedure TcxSchedulerReportDailyTimeRulerCell.DrawTimeZone(DC: HDC;
  const ABounds: TRect; const AText: string; AIsCurrent: Boolean);
var
  J, LH: Integer;
  R, TextR: TRect;
begin
  LH := cxRectHeight(BoundsRect) div LineCount;
  R := BoundsRect;
  Dec(R.Right, FixupWidth(6));
  if not IsLastItem then
    DrawCellFrame(DC, R, [bBottom], FLineColor);

  R := cxRectSetHeight(ABounds, LH);
  R.Left := (R.Left + R.Right) div 2 + FixupWidth(cxTextOffset * 2);
  Dec(R.Right, FixupWidth(6));
  for J := 0 to LineCount - 2 do
  begin
    DrawCellFrame(DC, R, [bBottom], FLineColor, 1);
    OffsetRect(R, 0, LH);
  end;
  TextR := cxRectInflate(ExcludeBorders(ABounds,
    [bRight, bBottom]), -FixupWidth(5), -FixupWidth(cxTextOffset));

  if LineCount > 1 then
  begin
    J := Length(AText);
    DrawCellText(DC, Rect(TextR.Left, TextR.Top, R.Left - FixupWidth(cxTextOffset), TextR.Bottom),
      Copy(AText, 1, J - 3), taRight, taTop, LargeFont, LargeFont.Color);
    DrawCellText(DC, Rect(R.Left, TextR.Top, TextR.Right, TextR.Top + LH - FixupWidth(3)),
      Copy(AText, J - 1, 2), taCenterX, taTop, Font);
  end
  else
    DrawCellText(DC, TextR, AText, taRight, taCenterY, Font);
  R.Left := ABounds.Left + FixupWidth(5);
  if not IsLastItem then
  begin
    if Hour <> 23 then
      DrawCellFrame(DC, R, [bBottom], FLineColor)
    else
      DrawCellFrame(DC, ABounds, [bBottom], FLineColor);
  end;
  if HasAdditionalTimeZone then
  begin
    R := GetInnerBounds(DC);
    R.Left := (R.Left + R.Right) div 2;
    R.Right := R.Left + LineThickness;
    Renderer.FillRect(DC, R, clBlack);
  end;
end;

procedure TcxSchedulerReportDailyTimeRulerCell.ReadData(AReader: TdxPSDataReader);
begin
  inherited ReadData(AReader);
  FHasAdditionalTimeZone := AReader.ReadBoolean;
  FLineCount := AReader.ReadInteger;
  FBounds[False] := AReader.ReadRect;
  FBounds[True] := AReader.ReadRect;
  FDisplayTexts[False] := AReader.ReadString;
  FDisplayTexts[True] := AReader.ReadString;
  FHour := AReader.ReadInteger;
  FLineColor := AReader.ReadInteger;
end;

procedure TcxSchedulerReportDailyTimeRulerCell.WriteData(AWriter: TdxPSDataWriter);
begin
  inherited WriteData(AWriter);
  AWriter.WriteBoolean(FHasAdditionalTimeZone);
  AWriter.WriteInteger(FLineCount);
  AWriter.WriteRect(FBounds[False]);
  AWriter.WriteRect(FBounds[True]);
  AWriter.WriteString(FDisplayTexts[False]);
  AWriter.WriteString(FDisplayTexts[True]);
  AWriter.WriteInteger(FHour);
  AWriter.WriteInteger(FLineColor);
end;

procedure TcxSchedulerReportDailyTimeRulerCell.DrawTimeZoneLabel(DC: HDC;
  const ABounds: TRect; const AText: string; ABorders: TcxBorders);
begin
  DrawCellText(DC, TextRect(ABounds), AText, taLeft, taBottom, Font, Font.Color);
end;

function TcxSchedulerReportDailyTimeRulerCell.GetBoundsRect(AType: Boolean): TRect;
begin
  Result := FBounds[AType];
end;

function TcxSchedulerReportDailyTimeRulerCell.GetDisplayText(AType: Boolean): string;
begin
  Result := FDisplayTexts[AType];
end;

function TcxSchedulerReportDailyTimeRulerCell.GetLargeFont: TFont;
begin
  Result := TimeRulerSite.LargeFont;
end;

function TcxSchedulerReportDailyTimeRulerCell.GetTimeRulerSite: TcxSchedulerReportDailyTimeRulerCellsSite;
begin
  Result := TcxSchedulerReportDailyTimeRulerCellsSite(Parent);
end;

{ TcxSchedulerReportMonthDayCell }

constructor TcxSchedulerReportMonthDayCell.CreateFrom(
  AParent: TdxReportCell; AViewInfo: TcxSchedulerCustomViewInfoItem);
begin
  inherited CreateFrom(AParent, AViewInfo);
  if AViewInfo is TcxSchedulerMonthDayContentCellViewInfo then
  begin
    FDontPrint := TcxSchedulerMonthDayContentCellViewInfo(AViewInfo).DontPrint;
    if FDontPrint then
    begin
      Transparent := True;
      FDisplayText := '';
    end
    else
      FDisplayText := TcxSchedulerMonthDayContentCellViewInfo(AViewInfo).DisplayText;
  end;
end;

procedure TcxSchedulerReportMonthDayCell.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TcxSchedulerReportMonthDayCell then
  begin
    FDontPrint := TcxSchedulerReportMonthDayCell(Source).FDontPrint;
    FDisplayText := TcxSchedulerReportMonthDayCell(Source).FDisplayText;
  end;
end;

procedure TcxSchedulerReportMonthDayCell.DrawContent(
  DC: HDC; AStage: TdxPSRenderStages);
var
  R: TRect;
begin
  inherited DrawContent(DC, AStage);
  if FDontPrint then Exit;
  if FDisplayText <> '' then
  begin
    R := ExcludeBorders(BoundsRect, TcxBorders(CellSides));
    DrawCellText(DC, R, FDisplayText, taRight, taTop);
  end;
end;

class function TcxSchedulerReportMonthDayCell.SchedulerCellClass: TcxSchedulerCustomViewInfoItemClass;
begin
  Result := TcxSchedulerMonthDayContentCellViewInfo;
end;

procedure TcxSchedulerReportMonthDayCell.ReadData(AReader: TdxPSDataReader);
begin
  inherited ReadData(AReader);
  FDisplayText := AReader.ReadString;
  FDontPrint := AReader.ReadBoolean;
end;

procedure TcxSchedulerReportMonthDayCell.WriteData(AWriter: TdxPSDataWriter);
begin
  inherited WriteData(AWriter);
  AWriter.WriteString(FDisplayText);
  AWriter.WriteBoolean(FDontPrint);
end;

{ TcxSchedulerReportTimeLinePart }

constructor TcxSchedulerReportTimeLinePart.CreateEx(AParent: TdxReportCell;
  ATriangle: Boolean; AState: Integer);
begin
  inherited Create(AParent);
  Transparent := False;
  FTriangle := ATriangle;
  FState := AState;
  Data := cdidSchedulerEventTimeLine;
end;

procedure TcxSchedulerReportTimeLinePart.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TcxSchedulerReportTimeLinePart then
  begin
    FState := TcxSchedulerReportTimeLinePart(Source).FState;
    FTriangle := TcxSchedulerReportTimeLinePart(Source).FTriangle;
  end;
end;

procedure TcxSchedulerReportTimeLinePart.DrawContent(DC: HDC;
  AStage: TdxPSRenderStages);
var
  R: TRect;
  ABrushHandle: HBrush;
  APenHandle: HPen;
  Points: array[0..2] of TPoint;
begin
  R := GetOuterBounds(DC);
  if FTriangle then
  begin
    Renderer.FillRect(DC, R, clWhite);
    ABrushHandle := SelectObject(DC, StateBrushes[FState].Handle);
    APenHandle := SelectObject(DC, GetStockObject(NULL_PEN));
    Points[0] := R.TopLeft;
    Points[1] := Point(R.Right, R.Top);
    Points[2] := Point(R.Right, R.Top + R.Right - R.Left);
    Windows.Polygon(DC, Points, 3);
    SelectObject(DC, GetStockObject(BLACK_PEN));
    Windows.MoveToEx(DC, R.Left, R.Top, nil);
    Windows.LineTo(DC, R.Right, R.Top + R.Right - R.Left);
    SelectObject(DC, APenHandle);
    SelectObject(DC, ABrushHandle);
  end
  else
    Windows.FillRect(DC, R, StateBrushes[FState].Handle);
  DrawBorders(DC);
end;

procedure TcxSchedulerReportTimeLinePart.ReadData(
  AReader: TdxPSDataReader);
begin
  inherited ReadData(AReader);
  FTriangle := AReader.ReadBoolean;
  FState := AReader.ReadInteger;
end;

procedure TcxSchedulerReportTimeLinePart.WriteData(
  AWriter: TdxPSDataWriter);
begin
  inherited WriteData(AWriter);
  AWriter.WriteBoolean(FTriangle);
  AWriter.WriteInteger(FState);
end;

{ TcxSchedulerReportTimeLineCell }

constructor TcxSchedulerReportTimeLineCell.Create(AParent: TdxReportCell);
begin
  inherited Create(AParent);
  Transparent := False;
  Color := clWhite;
end;

procedure TcxSchedulerReportTimeLineCell.SetTimeRect(const ABounds: TRect; AState: Integer);
var
  ATriangle: Boolean;
begin
  ATriangle := cxRectIsEmpty(ABounds);
  FCurrentValue := TcxSchedulerReportTimeLinePart.CreateEx(Self, ATriangle, AState);
  if ATriangle then
    FCurrentValue.BoundsRect := BoundsRect
  else
    FCurrentValue.BoundsRect := ABounds;
end;

{ TcxSchedulerReportCustomEventCell }

function TcxSchedulerReportCustomEventCell.CreateStringCell(
  const AText: string; AData: Integer = 0): TdxReportCellString;
begin
  Result := TdxReportCellString.Create(Self);
  Result.CellSides := [];
  Result.Multiline := True;
  Result.Text := AText;
  Result.Data := AData;
end;

procedure TcxSchedulerReportCustomEventCell.SetViewParams(const AViewParams: TcxViewParams);
var
  I: Integer;
begin
  ReportLink.SetCellViewParams(Self, AViewParams);
  for I := 0 to DataItemCount - 1 do
    ReportLink.SetCellViewParams(DataItems[I], AViewParams);
end;

function TcxSchedulerReportCustomEventCell.GetPrintStyle: TcxCustomSchedulerReportLinkPrintStyle;
begin
  Result := ReportLink.PrintStyles.ActiveStyle;
end;

function TcxSchedulerReportCustomEventCell.GetReportLink: TcxSchedulerReportLink;
begin
  Result := ReportCells.ReportLink as TcxSchedulerReportLink;
end;

function TcxSchedulerReportCustomEventCell.GetSuppressColoration: Boolean;
begin
  Result := ReportLink.OptionsFormatting.SuppressContentColoration;
end;

{ TcxSchedulerReportEventCell }

constructor TcxSchedulerReportEventCell.CreateFrom(AParent: TdxReportCell;
  AEventViewInfo: TcxSchedulerEventCellViewInfo);
begin
  inherited Create(AParent);
  ClipChildren := True;
  Transparent := False;
  InitializeFromViewInfo(AEventViewInfo);
  CreateDataItems;
  SetViewParams(AEventViewInfo.ViewParams);
  CalculateLayout;
end;

procedure TcxSchedulerReportEventCell.AdjustItemsHeight;

  procedure CheckItem(AItem: TAbstractdxReportCellData);
  var
    R: TRect;
  begin
    if Assigned(AItem) then
    begin
      R := AItem.BoundsRect;
      if HasMessage then
        R.Bottom := MessageCell.Top
      else
        R.Bottom := ContentBounds.Bottom;
      AItem.BoundsRect := R;
    end;
  end;

begin
  CheckItem(CaptionCell);
  CheckItem(IconsCell);
  CheckItem(StartCell);
  CheckItem(FinishCell);
end;

procedure TcxSchedulerReportEventCell.CalculateLayout;
var
  DC: HDC;
  W, H, ALeft, AHalfWidth: Integer;
begin
  DC := GetDC(0);
  try
    FContentBounds := GetContentBounds(DC);
    if Assigned(FTimeLineCell) then
      CalculateTimeLine(DC);
    if Assigned(IconsCell) then
    begin
      IconsCell.BoundsRect := GetIconsRect(DC);
      ALeft := IconsCell.BoundsRect.Right;
    end
    else ALeft := 0;
    if IsNeedCreateTimeCells then
    begin
      H := Renderer.CalcTextHeight(DC, '0', False, CaptionCell.Font);
      W := Renderer.CalcTextWidth(DC, '00:00', CaptionCell.Font);
      AHalfWidth := cxRectWidth(ContentBounds) div 2;
      if W < AHalfWidth then
      begin
        StartCell.BoundsRect := cxRectBounds(ALeft, 0, W, H);
        if W * 2 < AHalfWidth then
          FinishCell.BoundsRect := cxRectBounds(StartCell.BoundsRect.Right, 0, W, H)
        else
          FreeAndNil(FFinishCell);
      end
      else
        FreeAndNil(FStartCell);
    end;
    CaptionCell.BoundsRect := GetCaptionRect(DC);
    if Assigned(MessageCell) then
    begin
      MessageCell.BoundsRect := GetMessageRect(DC);
      MessageCell.AdjustContent(DC);
    end;
    AdjustItemsHeight;
  finally
    ReleaseDC(0, DC);
  end;
end;

procedure TcxSchedulerReportEventCell.CalculateTimeLine(DC: HDC);

   function GetTimeRectBrushIndex: Integer;
   begin
     Result := Event.State;
     if SuppressColoration then
       Inc(Result, 4);
   end;

   function GetActualTimeRect: TRect;
   begin
     Result := GetRelativeRect(EventViewInfo.EventTimeRect);
     if not cxRectIsEmpty(Result) then
       Result := cxRectInflate(Result, 0, 1);
   end;

begin
  if FTimeLineCell = nil then Exit;
  FTimeLineCell.BoundsRect := GetTimeLineRect(DC);
  FTimeLineCell.SetTimeRect(GetActualTimeRect, GetTimeRectBrushIndex);
end;

function TcxSchedulerReportEventCell.CreateCaptionCell: TdxReportCellString;
begin
  Result := AddDataItem(TdxReportCellString) as TdxReportCellString;
  with Result do
  begin
    Text := EventViewInfo.Caption;
    CellSides := [];
    Multiline := FHasDetailInfo and not IsHeaderEvent;
    if HasDetailInfo then TextAlignY := taTop;
    if IsHeaderEvent then TextAlignX := taCenterX;
  end;
end;

procedure TcxSchedulerReportEventCell.CreateDataItems;
begin
  if HasDetailInfo and not IsHeaderEvent then
    FTimeLineCell := CreateTimeLineCell;
  if HasIcons then
  begin
    FIconsCell := CreateIconCells;
    FIconsCell.Data := cdidSchedulerEventIcons;
  end;
  if IsNeedCreateTimeCells then
  begin
    FStartCell := CreateTimeTextCell(EventViewInfo.StartText);
    FStartCell.Data := cdidSchedulerEventStart;
    FFinishCell := CreateTimeTextCell(EventViewInfo.FinishText);
    FFinishCell.Data := cdidSchedulerEventFinish;
  end;
  FCaptionCell := CreateCaptionCell;
  FCaptionCell.Data := cdidSchedulerEventCaption;
  if HasMessage then
  begin
    CreateMessageCell(Event.Message, EventViewInfo.EventViewData.EditProperties,
      EventViewInfo.ViewParams);
    FMessageCell.Data := cdidSchedulerEventMessage;
  end;
end;

procedure TcxSchedulerReportEventCell.CreateMessageCell(AMessage: Variant;
  AProperties: TcxCustomEditProperties; AViewParams: TcxViewParams);
var
  AParams: TdxReportItemViewParams;
begin
  if AProperties = nil then
    FMessageCell := nil
  else
  begin
    FMessageCell := AddDataItem(GetMessageClass(AProperties));
    FillChar(AViewParams, SizeOf(AViewParams), 0);
    AParams.NativeParams := AViewParams;
    dxPScxCommon.dxPSDataMaps.InitializeItem(FMessageCell, AProperties, AMessage,
      PrintStyle, AParams);
    if not SuppressColoration then
      MessageCell.BorderColor := EventViewInfo.SeparatorColor;
    FMessageCell.CellSides := [csTop];
  end;
end;

function TcxSchedulerReportEventCell.CreateTimeTextCell(
  const ATimeText: string): TdxReportCellString;
begin
  Result := TdxReportCellString.Create(Self);
  Result.Text := ATimeText;
  Result.TextAlignX := taRight;
  Result.CellSides := [];
end;

function TcxSchedulerReportEventCell.CreateTimeLineCell: TcxSchedulerReportTimeLineCell;
begin
  Result := TcxSchedulerReportTimeLineCell.Create(Self);
end;

function TcxSchedulerReportEventCell.CreateIconCells: TdxReportCellString;
begin
  Result := AddDataItem(TdxReportCellString) as TdxReportCellString;
  with Result do
  begin
    CellSides := [];
    if HasDetailInfo then TextAlignY := taTop;
    FontIndex := Self.Parent.FontIndex;
    Text := IconsString;
  end;
end;

function TcxSchedulerReportEventCell.GetCaptionRect(DC: HDC): TRect;
begin
  Result := FContentBounds;
  if Assigned(FinishCell) then
    Result.Left := FinishCell.BoundsRect.Right
  else
    if Assigned(StartCell) then
      Result.Left := StartCell.BoundsRect.Right
    else
      if HasIcons then
        Result.Left := IconsCell.BoundsRect.Right;
  if HasMessage then
  begin
    Result.Bottom := Result.Top + CaptionCell.MeasureFontHeight(DC);
    Renderer.CalcTextRect(DC, CaptionCell.Text, Result, True, Font);
    Result.Right := ContentBounds.Right;
    CheckBounds(Result);
  end;
end;

function TcxSchedulerReportEventCell.GetContentBounds(DC: HDC): TRect;
begin
  Result := GetRelativeRect(EventViewInfo.Bounds);
  Dec(Result.Right);
  Dec(Result.Bottom);
end;

function TcxSchedulerReportEventCell.GetHasIcons: Boolean;
begin
  Result := PrintStyle.SupportIcons and (Event.IsRecurring {or Event.Remainder});
end;

function TcxSchedulerReportEventCell.GetHasMessage: Boolean;
begin
  Result := PrintStyle.SupportMessage and HasDetailInfo;
end;

function TcxSchedulerReportEventCell.GetIconsRect(DC: HDC): TRect;
begin
  Result := ContentBounds;
  Renderer.CalcTextRect(DC, IconsString, Result, False, IconsCell.Font);
  Result.Right := Result.Left + Renderer.CalcTextWidth(DC, IconsString, IconsCell.Font);
  if not HasDetailInfo then Result.Bottom := ContentBounds.Bottom;
  CheckBounds(Result);
end;

function TcxSchedulerReportEventCell.GetIconsString: string;
const
  //etNone, etPattern, etOccurrence, etException, etCustom
  IconChars: array[TcxEventType] of Char = (' ', ' ', 'B', ' ', 'C');
begin
  Result := '';
  if not HasIcons then Exit;
  with Event do
  begin
    //if Reminder then Result := 'A';
    if IsRecurring then Result := Result + IconChars[EventType];
  end;
end;

function TcxSchedulerReportEventCell.GetMessageClass(AProperties: TcxCustomEditProperties): TdxReportCellDataClass;
begin
  Result := dxPScxCommon.dxPSDataMaps.ItemClass(AProperties);
end;

function TcxSchedulerReportEventCell.GetMessageRect(DC: HDC): TRect;
begin
  Result := ContentBounds;
  if HasIcons then
    Result.Top := IconsCell.BoundsRect.Bottom;
  if CaptionCell.BoundsRect.Bottom > Result.Top then
    Result.Top := CaptionCell.BoundsRect.Bottom;
end;

function TcxSchedulerReportEventCell.GetRelativeRect(const R: TRect): TRect;
begin
  Result := cxRectOffset(R, cxPointInvert(BoundsRect.TopLeft));
end;

function TcxSchedulerReportEventCell.GetTimeLineRect(DC: HDC): TRect;
begin
  Result := cxRect(0, 0, ContentBounds.Left, Height);
end;

procedure TcxSchedulerReportEventCell.InitializeFromViewInfo(
  AEventViewInfo: TcxSchedulerEventCellViewInfo);
begin
  FEventViewInfo := AEventViewInfo;
  FEditViewInfo := AEventViewInfo.EditViewInfo;
  BoundsRect := AEventViewInfo.EventViewData.Bounds; //include timeline
  CellSides := TdxCellSides(AEventViewInfo.Borders);
  FIsHeaderEvent := Event.AllDayEvent or (Event.Duration > 1);
  FHasDetailInfo := AEventViewInfo.IsDetailInfo;
  FIsNeedCreateTimeCells := not (FIsHeaderEvent or FHasDetailInfo) and
    AEventViewInfo.ShowStartTime;
  FHasIcons := GetHasIcons;
  FHasMessage := GetHasMessage and AEventViewInfo.ShowMessage;
  FIconsString := GetIconsString;
  FMessage := AEventViewInfo.Message;
end;

procedure TcxSchedulerReportEventCell.SetViewParams(const AViewParams: TcxViewParams);
begin
  inherited SetViewParams(AViewParams);
  if HasIcons then
  begin
    SpecialSymbolFont.Size := AViewParams.Font.Size;
    IconsCell.FontIndex := Renderer.ReportLink.AddFontToPool(SpecialSymbolFont);
  end;
end;

procedure TcxSchedulerReportEventCell.CheckBounds(var ABounds: TRect);
begin
  cxRectIntersect(ABounds, ABounds, ContentBounds);
end;

function TcxSchedulerReportEventCell.GetEvent: TcxSchedulerControlEvent;
begin
  Result := EventViewInfo.Event;
end;

{ TcxSchedulerReportDetailsEventCell }

constructor TcxSchedulerReportDetailsEventCell.CreateEx(AParent: TdxReportCell;
  AEvent: TcxSchedulerEvent; ADate: TDateTime; const AParams: TcxViewParams;
  AContinued: Boolean = False);
begin
  inherited Create(AParent);
  CellSides := [];
  FContinued := AContinued;
  FDate := ADate;
  FEvent := AEvent;
  CreateDataItems;
  SetViewParams(AParams);
end;

procedure TcxSchedulerReportDetailsEventCell.CalculateLayout(AWidth, ATimeWidth: Integer);
var
  DC: HDC;
  ATop: Integer;
begin
  FCaptionCell.BoundsRect := MakeRect(ATimeWidth, 0, AWidth, 0);
  DC := GetDC(0);
  try
    FLineHeight := FCaptionCell.MeasureFontHeight(DC);
    FStartCell.BoundsRect := MakeRect(0, 0, ATimeWidth, FLineHeight);
    ATop := FCaptionCell.MeasureContentHeight(DC);
    FCaptionCell.Height := ATop;
    FMessageCell.BoundsRect := MakeRect(ATimeWidth, ATop, AWidth, ATop);
    ATop := FMessageCell.MeasureContentHeight(DC);
    FMessageCell.Height := Max(ATop, FLineHeight);
  finally
    ReleaseDC(0, DC);
  end;
end;

function TcxSchedulerReportDetailsEventCell.CalculateHeight: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to DataItemCount - 1 do
    with DataItems[I] do
      if Visible then Result := Max(Result, BoundsRect.Bottom);
end;

procedure TcxSchedulerReportDetailsEventCell.CreateCaptionCell;
begin
  FCaptionCell := CreateStringCell(GetCaptionCellText,
    cdidSchedulerEventCaption);
end;

procedure TcxSchedulerReportDetailsEventCell.CreateDataItems;
begin
  CreateCaptionCell;
  CreateTimeCell;
  CreateMessageCell;
end;

procedure TcxSchedulerReportDetailsEventCell.CreateMessageCell;
begin
  FMessageCell := CreateStringCell(GetMessageCellText, cdidSchedulerEventMessage);
end;

procedure TcxSchedulerReportDetailsEventCell.CreateTimeCell;
begin
  FStartCell := CreateStringCell(GetTimeCellText, cdidSchedulerEventStart);
end;

function TcxSchedulerReportDetailsEventCell.GetCaptionCellText: string;
begin
  Result := Event.Caption;
  if Trim(Event.Location) <> '' then
    Result := Result + ' -- ' + Event.Location;
end;

function TcxSchedulerReportDetailsEventCell.GetMessageCellText: string;
begin
  if Continued then
    Result := cxGetResourceString(@sdxSeeAboveMessage)
  else
    Result := Event.Message;
end;

function TcxSchedulerReportDetailsEventCell.GetTimeCellText: string;
begin
  if Event.AllDayEvent or ((DateOf(Event.Start) < Date) and (DateOf(Event.Finish) > Date)) then
    Result := cxGetResourceString(@sdxAllDayMessage)
  else
    Result := DateTimeHelper.TimeToStr(Max(Event.Start, Date)) + ' - ' +
      DateTimeHelper.TimeToStr(Min(Event.Finish, Date + 1));
end;

procedure TcxSchedulerReportDetailsEventCell.SetViewParams(
  const AViewParams: TcxViewParams);
var
  AParams: TdxReportItemViewParams;
begin
  inherited SetViewParams(AViewParams);
  FillChar(AParams, SizeOf(AParams), 0);
  AParams.NativeParams := AViewParams;
  Include(AParams.FontStyle, fsBold);
  ReportLink.SetCellViewParams(CaptionCell, AParams);
  ReportLink.SetCellViewParams(StartCell, AParams);
end;

{ TcxSchedulerReportMemoEventCell }

procedure TcxSchedulerReportMemoEventCell.CalculateLayout(AWidth,
  ATimeWidth: Integer);
var
  ATop, ASpace: Integer;
  DC: HDC;
begin
  DC := GetDC(0);
  try
    FLineHeight := Renderer.CalcTextHeight(DC, 'Wg', False, Font);
    ASpace := FLineHeight div 2;
    ATop := FLineHeight * 2;
    HeaderCell.BoundsRect := MakeRect(0, 0, AWidth, ATop);
    Inc(ATop, ASpace);
    CalculateLabelAndData(CaptionLabelCell, CaptionCell, DC, ATimeWidth, AWidth, ATop);
    CalculateLabelAndData(LocationLabelCell, LocationCell, DC, ATimeWidth, AWidth, ATop);
    if Assigned(CaptionLabelCell) or Assigned(LocationLabelCell) then Inc(ATop, ASpace);
    CalculateLabelAndData(StartLabelCell, StartCell, DC, ATimeWidth, AWidth, ATop);
    CalculateLabelAndData(FinishLabelCell, FinishCell, DC, ATimeWidth, AWidth, ATop);
    CalculateLabelAndData(ShowTimeAsLabelCell, ShowTimeAsCell, DC, ATimeWidth, AWidth, ATop);
    Inc(ATop, ASpace);
    CalculateLabelAndData(RecurrenceLabelCell, RecurrenceCell, DC, ATimeWidth, AWidth, ATop);
    CalculateLabelAndData(RecurrencePatternLabelCell, RecurrencePatternCell, DC, ATimeWidth, AWidth, ATop);
    if Assigned(MessageCell) then
    begin
      Inc(ATop, ASpace);
      MessageCell.BoundsRect := MakeRect(0, ATop, AWidth, ATop);
      MessageCell.Height := MessageCell.MeasureContentHeight(DC);
    end;
  finally
    ReleaseDC(0, DC);
  end;
end;

procedure TcxSchedulerReportMemoEventCell.CreateDataItems;
begin
  CreateHeader;
  CreateSubject;
  CreateLocation;
  CreateStart;
  CreateFinish;
  CreateShowTimeAs;
  CreateRecurrence;
  CreateRecurrencePattern;
  CreateMessage;
end;

function TcxSchedulerReportMemoEventCell.GetCaptionCellText: string;
begin
  Result := Event.Caption;
end;

function TcxSchedulerReportMemoEventCell.GetMessageCellText: string;
begin
  Result := Event.Message;
end;

function TcxSchedulerReportMemoEventCell.GetTimeCellText: string;
begin
  Result := FormatDateTime('ddd ddddd t', Event.Start);
end;

procedure TcxSchedulerReportMemoEventCell.SetViewParams(
  const AViewParams: TcxViewParams);
var
  AParams: TdxReportItemViewParams;
begin
  ReportLink.SetCellViewParams(Self, AViewParams);
  ReportLink.SetCellViewParams(CaptionCell, AViewParams);
  ReportLink.SetCellViewParams(LocationCell, AViewParams);
  ReportLink.SetCellViewParams(StartCell, AViewParams);
  ReportLink.SetCellViewParams(FinishCell, AViewParams);
  ReportLink.SetCellViewParams(ShowTimeAsCell, AViewParams);
  ReportLink.SetCellViewParams(RecurrenceCell, AViewParams);
  ReportLink.SetCellViewParams(RecurrencePatternCell, AViewParams);
  ReportLink.SetCellViewParams(MessageCell, AViewParams);

  FillChar(AParams, SizeOf(AParams), 0);
  AParams.NativeParams := AViewParams;
  Include(AParams.FontStyle, fsBold);
  ReportLink.SetCellViewParams(CaptionLabelCell, AParams);
  ReportLink.SetCellViewParams(LocationLabelCell, AParams);
  ReportLink.SetCellViewParams(StartLabelCell, AParams);
  ReportLink.SetCellViewParams(FinishLabelCell, AParams);
  ReportLink.SetCellViewParams(ShowTimeAsLabelCell, AParams);
  ReportLink.SetCellViewParams(RecurrenceLabelCell, AParams);
  ReportLink.SetCellViewParams(RecurrencePatternLabelCell, AParams);

  AParams.FontSize := MulDiv(AViewParams.Font.Size, 3, 2);
  ReportLink.SetCellViewParams(HeaderCell, AParams);
end;

procedure TcxSchedulerReportMemoEventCell.CalculateLabelAndData(
  ALabelCell, ADataCell: TAbstractdxReportCellData; DC: HDC;
  ATimeWidth, AWidth: Integer; var ATop: Integer);
begin
  if Assigned(ALabelCell) then
  begin
    ALabelCell.BoundsRect := MakeBounds(0, ATop, ATimeWidth, FLineHeight);
    ADataCell.BoundsRect := MakeRect(ATimeWidth, ATop, AWidth, ATop);
    ADataCell.Height := ADataCell.MeasureContentHeight(DC);
    Inc(ATop, Max(ADataCell.Height, FLineHeight));
  end;
end;

procedure TcxSchedulerReportMemoEventCell.CreateHeader;
begin
  FHeaderCell := CreateStringCell(GetHeaderCellText);
  FHeaderCell.BorderClass := TdxPSCellBoldFlatBorder;
  FHeaderCell.CellSides := [csBottom];
  FHeaderCell.TextAlignY := taBottom;
end;

procedure TcxSchedulerReportMemoEventCell.CreateFinish;
begin
  CreateFinishLabelCell;
  CreateFinishCell;
end;

procedure TcxSchedulerReportMemoEventCell.CreateFinishCell;
begin
  FFinishCell := CreateStringCell(FormatDateTime('ddd ddddd t', Event.Finish));
end;

procedure TcxSchedulerReportMemoEventCell.CreateFinishLabelCell;
begin
  FFinishLabelCell := CreateStringCell(
    cxGetResourceString(@sdxFinishLabelCaption));
end;

procedure TcxSchedulerReportMemoEventCell.CreateLocation;
begin
  if Event.Location = '' then Exit;
  CreateLocationLabelCell;
  CreateLocationCell;
end;

procedure TcxSchedulerReportMemoEventCell.CreateLocationCell;
begin
  FLocationCell := CreateStringCell(Event.Location);
end;

procedure TcxSchedulerReportMemoEventCell.CreateLocationLabelCell;
begin
  FLocationLabelCell := CreateStringCell(
    cxGetResourceString(@sdxLocationLabelCaption));
end;

procedure TcxSchedulerReportMemoEventCell.CreateMessage;
begin
  if GetMessageCellText = '' then Exit;
  CreateMessageCell;
end;

procedure TcxSchedulerReportMemoEventCell.CreateRecurrence;
begin
  CreateRecurrenceLabelCell;
  CreateRecurrenceCell;
end;

procedure TcxSchedulerReportMemoEventCell.CreateRecurrenceCell;
begin
  FRecurrenceCell := CreateStringCell(GetRecurrenceCellText);
end;

procedure TcxSchedulerReportMemoEventCell.CreateRecurrenceLabelCell;
begin
  FRecurrenceLabelCell := CreateStringCell(
    cxGetResourceString(@sdxRecurrenceLabelCaption));
end;

procedure TcxSchedulerReportMemoEventCell.CreateRecurrencePattern;
begin
  if not Event.IsRecurring then Exit;
  CreateRecurrencePatternLabelCell;
  CreateRecurrencePatternCell;
end;

procedure TcxSchedulerReportMemoEventCell.CreateRecurrencePatternCell;
begin
  FRecurrencePatternCell := CreateStringCell(GetRecurrencePatternCellText);
end;

procedure TcxSchedulerReportMemoEventCell.CreateRecurrencePatternLabelCell;
begin
  FRecurrencePatternLabelCell := CreateStringCell(
    cxGetResourceString(@sdxRecurrencePatternLabelCaption));
end;

procedure TcxSchedulerReportMemoEventCell.CreateShowTimeAs;
begin
  if GetShowTimeAsCellText = '' then Exit;
  CreateShowTimeAsLabelCell;
  CreateShowTimeAsCell;
end;

procedure TcxSchedulerReportMemoEventCell.CreateShowTimeAsCell;
begin
  FShowTimeAsCell := CreateStringCell(GetShowTimeAsCellText);
end;

procedure TcxSchedulerReportMemoEventCell.CreateShowTimeAsLabelCell;
begin
  FShowTimeAsLabelCell := CreateStringCell(
    cxGetResourceString(@sdxShowTimeAsLabelCaption));
end;

procedure TcxSchedulerReportMemoEventCell.CreateStart;
begin
  CreateStartLabelCell;
  CreateTimeCell;
end;

procedure TcxSchedulerReportMemoEventCell.CreateStartLabelCell;
begin
  FStartLabelCell := CreateStringCell(
    cxGetResourceString(@sdxStartLabelCaption));
end;

procedure TcxSchedulerReportMemoEventCell.CreateSubject;
begin
  if GetCaptionCellText = '' then Exit;
  CreateSubjectLabelCell;
  CreateCaptionCell;
end;

procedure TcxSchedulerReportMemoEventCell.CreateSubjectLabelCell;
begin
  FCaptionLabelCell := CreateStringCell(
    cxGetResourceString(@sdxSubjectLabelCaption));
end;

function TcxSchedulerReportMemoEventCell.GetHeaderCellText: string;
var
  AResource: TcxSchedulerStorageResourceItem;
begin
  AResource := Event.GetResourceItem;
  if AResource <> nil then
    Result := AResource.Name
  else
    Result := dxPSUtl.GetUserName;
end;

function TcxSchedulerReportMemoEventCell.GetRecurrenceCellText: string;
begin
  if Event.IsRecurring then
    case Event.RecurrenceInfo.Recurrence of
      cxreDaily:
        Result := cxGetResourceString(@scxRecurrenceDailyMessage);
      cxreWeekly:
        Result := cxGetResourceString(@scxRecurrenceWeeklyMessage);
      cxreMonthly:
        Result := cxGetResourceString(@scxRecurrenceMonthlyMessage);
      cxreYearly:
        Result := cxGetResourceString(@scxRecurrenceYearlyMessage);
    else
      Result := '';
    end
  else
    Result := cxGetResourceString(@sdxRecurrenceNoneMessage);
end;

function TcxSchedulerReportMemoEventCell.GetRecurrencePatternCellText: string;
begin
  if Event.IsRecurring and Assigned(cxGetRecurrenceDescriptionStringProc) then
    Result := cxGetRecurrenceDescriptionStringProc(Event.RecurrenceInfo)
  else
    Result := '';
end;

function TcxSchedulerReportMemoEventCell.GetShowTimeAsCellText: string;
begin
  case Event.State of
    tlsFree:
      Result := cxGetResourceString(@sdxShowTimeAsFreeMessage);
    tlsTentative:
      Result := cxGetResourceString(@sdxShowTimeAsTentativeMessage);
    tlsOutOfOffice:
      Result := cxGetResourceString(@sdxShowTimeAsOutOfOfficeMessage);
  else
    Result := '';
  end;
end;

{ TcxSchedulerReportCommonCellsProducer }

constructor TcxSchedulerReportCommonCellsProducer.CreateEx(
  AStyle: TcxCustomSchedulerReportLinkPrintStyle;
  ASite: TcxSchedulerReportSchedulingAreaCell);
begin
  inherited Create(AStyle.GetCorrespondedView);
  FStyle := AStyle;
  FSite := ASite;
end;

procedure TcxSchedulerReportCommonCellsProducer.GetPageResources(
  AResources: TcxObjectList);
var
  ResPerPage, APageIndex, I, J: Integer;
begin
  ResPerPage := Style.ResourceCountPerPage;
  if (Resources = nil) or (ResPerPage <= 0) or
    (ResPerPage >= Resources.VisibleResourceCount) then
  begin
    inherited GetPageResources(AResources);
    Exit;
  end;
  APageIndex := (Site.PageIndex div PagesPerWeek) mod Style.GetResourcePageCount;
  I := ResPerPage * APageIndex;
  J := Min(ResPerPage * (APageIndex + 1), Resources.VisibleResourceCount);
  while I < J do
  begin
    AResources.Add(TcxSchedulerResourceViewInfo.Create(
      Resources.VisibleResources[I]));
    I := I + 1;
  end;
end;

procedure TcxSchedulerReportCommonCellsProducer.Produce;
begin
  Calculate;
end;

procedure TcxSchedulerReportCommonCellsProducer.AfterCalculatePage;
var
  I, J: Integer;
  ASubList: TcxSchedulerViewInfoCellList;
  AItem: TcxSchedulerCustomViewInfoItem;
  AReportItemClass: TcxSchedulerReportCustomCellClass;
  AEventCell: TcxSchedulerReportEventCell;
begin
  for I := 0 to Cells.Count - 1 do
  begin
    ASubList := TcxSchedulerViewInfoCellList(Cells[I]);
    for J := 0 to ASubList.Count - 1 do
    begin
      AItem := ASubList[J];
      if AItem.Visible then
      begin
        if AItem is TcxSchedulerEventCellViewInfo then
        begin
          AEventCell := CreateEventCell(TcxSchedulerEventCellViewInfo(AItem));
          Style.ReportLink.DoInitializeEventCell(AEventCell);
        end
        else
          if FindMirorClassForItem(AItem, AReportItemClass) then
            ConvertSchedulerCellToPSCells(AItem, AReportItemClass);
      end;
    end;
  end;
end;

function TcxSchedulerReportCommonCellsProducer.CanCalculate: Boolean;
begin
  Result := True;
end;

function TcxSchedulerReportCommonCellsProducer.CreateEventCell(
  AEventViewInfo: TcxSchedulerEventCellViewInfo): TcxSchedulerReportEventCell;
begin
  Result := TcxSchedulerReportEventCell.CreateFrom(Site, AEventViewInfo);
end;

procedure TcxSchedulerReportCommonCellsProducer.ConvertSchedulerCellToPSCells(
  AItem: TcxSchedulerCustomViewInfoItem;
  AReportItemClass: TcxSchedulerReportCustomCellClass);
var
  APSItem: TcxSchedulerReportCustomCell;
begin
  APSItem := AReportItemClass.CreateFrom(FSite, AItem);
  SetCellViewParams(APSItem, AItem.ViewParams);
end;

procedure TcxSchedulerReportCommonCellsProducer.DoInitialize(
  var ASelectedDays: TcxSchedulerDateList; var AEvents: TcxSchedulerCachedEventList);
begin
  ASelectedDays := Site.VisibleDays;
  AEvents := Style.Events;
end;

function TcxSchedulerReportCommonCellsProducer.GetCompressWeekends: Boolean;
begin
  Result := Style.CompressWeekends;
end;

function TcxSchedulerReportCommonCellsProducer.GetDontPrintWeekEnds: Boolean;
begin
  Result := Style.DontPrintWeekends;
end;

function TcxSchedulerReportCommonCellsProducer.GetHideSelection: Boolean;
begin
  Result := True;
end;

function TcxSchedulerReportCommonCellsProducer.GetPageBounds: TRect;
begin
  Result := Site.GetInnerBounds(0);
end;

function TcxSchedulerReportCommonCellsProducer.GetPagesPerWeek: Byte;
begin
  Result := Integer(Style.Layout) + 1;
end;

function TcxSchedulerReportCommonCellsProducer.GetPrintExactlyOneMonth: Boolean;
begin
  Result := (Style is TcxSchedulerReportLinkMonthlyPrintStyle) and
    TcxSchedulerReportLinkMonthlyPrintStyle(Style).PrintExactlyOneMonthPerPage; 
end;

function TcxSchedulerReportCommonCellsProducer.GetPrintRange(
  Index: Integer): TDateTime;
begin
  if Index = 0 then
    Result := Style.TimePrintFrom
  else
    Result := Style.TimePrintTo;
end;

function TcxSchedulerReportCommonCellsProducer.GetPrimaryPage: Boolean;
begin
  Result := Site.PrimaryPage;
end;

function TcxSchedulerReportCommonCellsProducer.GetStylesAdapter: IcxSchedulerStylesAdapter;
begin
  Result := Styles;
end;

procedure TcxSchedulerReportCommonCellsProducer.SetCellViewParams(
  ACell: TdxReportVisualItem; const AParams: TcxViewParams);
begin
  Site.SetCellViewParams(ACell, AParams);
  if Style.ReportLink.OptionsFormatting.SuppressContentColoration then
    if ACell is TcxSchedulerReportCustomCell then
      TcxSchedulerReportCustomCell(ACell).SuppressColoration;
end;

function TcxSchedulerReportCommonCellsProducer.GetStyles: TcxSchedulerReportLinkStyles;
begin
  Result := Style.VisualStyles;
end;

{ TcxSchedulerReportDailyCellsProducer }

procedure TcxSchedulerReportDailyCellsProducer.AfterCalculatePage;
begin
  FRulerSite := CreateTimeRulerSite;
  SetCellViewParams(FRulerSite, Styles.GetTimeRulerParams);
{  FRulerSite.Transparent :=
    Style.ReportLink.OptionsFormatting.SuppressContentColoration;}
  inherited AfterCalculatePage;
end;

procedure TcxSchedulerReportDailyCellsProducer.BeforeCalculatePage;
begin
  Site.CellSides := csAll;
  inherited BeforeCalculatePage;
end;

procedure TcxSchedulerReportDailyCellsProducer.ConvertSchedulerCellToPSCells(
  AItem: TcxSchedulerCustomViewInfoItem;
  AReportItemClass: TcxSchedulerReportCustomCellClass);
begin
  if AReportItemClass = TcxSchedulerReportDailyTimeRulerCell then
    SetCellViewParams(AReportItemClass.CreateFrom(FRulerSite, AItem), AItem.ViewParams)
  else
    inherited ConvertSchedulerCellToPSCells(AItem, AReportItemClass);
end;

function TcxSchedulerReportDailyCellsProducer.CreateTimeRulerSite: TcxSchedulerReportDailyTimeRulerCellsSite;
begin
  Result := TcxSchedulerReportDailyTimeRulerCellsSite.Create(FSite);
  Result.Transparent := True;
  Result.ClipChildren := True;
end;

// registration unit part

procedure RegisterMirrorClasses;
begin
  MirrorClasses := TList.Create;
  TcxSchedulerReportContentCell.RegisterMirrorClass;
  TcxSchedulerReportHeaderItemCell.RegisterMirrorClass;
  TcxSchedulerReportGroupSeparatorCell.RegisterMirrorClass;
  TcxSchedulerReportContainerCell.RegisterMirrorClass;
  TcxSchedulerReportDailyTimeRulerCell.RegisterMirrorClass;
//  TcxSchedulerReportEventCell.RegisterMirrorClass;
  TcxSchedulerReportMonthDayCell.RegisterMirrorClass;
  TcxSchedulerReportBackgroundSlotCell.RegisterMirrorClass;
end;

procedure UnRegisterMirrorClasses;
begin
  MirrorClasses.Free;
end;

function GetFontFolder : string;
var
  APIDL: PItemIDList;
  APath: array[0..MAX_PATH] of Char;
  AMalloc: IMalloc;
begin                            
  Result := '';
  if ShGetSpecialFolderLocation(Application.Handle, CSIDL_FONTS, APIDL) = S_OK then
  begin
    if ShGetPathFromIDList(APIDL, APath) then
      Result := APath;
    if Succeeded(SHGetMalloc(AMalloc)) then
      AMalloc.Free(APIDL);
  end;
end;

procedure RegisterReportLinkClasses;
begin
  RegisterClasses([TcxSchedulerReportLinkStyles]);

  TcxSchedulerReportSchedulingAreaCell.Register;
  TcxSchedulerReportNotesAreaCell.Register;
  TcxSchedulerReportTaskPadCell.Register;
  TcxSchedulerReportSchedulerHeaderCell.Register;
  TcxSchedulerReportSchedulerHeaderDataCell.Register;

  //datenavigator
  TcxSchedulerReportDateNavigatorCell.Register;
  TcxSchedulerReportDateNavigatorHeader.Register;
  TcxSchedulerReportDateNavigatorDay.Register;
  TcxSchedulerReportDateNavigatorDayCaption.Register;
  TcxSchedulerReportDateNavigatorWeekNumber.Register;

  //scheduling area items
  TcxSchedulerReportContentCell.Register;
  TcxSchedulerReportHeaderItemCell.Register;
  TcxSchedulerReportGroupSeparatorCell.Register;
  TcxSchedulerReportContainerCell.Register;
  TcxSchedulerReportBackgroundSlotCell.Register;
  TcxSchedulerReportDailyTimeRulerCellsSite.Register;
  TcxSchedulerReportDailyTimeRulerCell.Register;
  TcxSchedulerReportMonthDayCell.Register;

  TcxSchedulerReportEventCell.Register;
  TcxSchedulerReportDetailsEventCell.Register;
  TcxSchedulerReportMemoEventCell.Register;

  TcxSchedulerReportTimeLineCell.Register;
  TcxSchedulerReportTimeLinePart.Register;

  TcxSchedulerReportPageSite.Register;

  dxPSRegisterReportLink(TcxSchedulerReportLink,
    TcxScheduler, TcxfmSchedulerReportLinkDesignWindow);
end;

type
  TAddFontMemResource = function (p1: Pointer; p2: DWORD; p3: PDesignVector; p4: LPDWORD): THandle; stdcall;
  TRemoveFontMemResource = function (p1: THandle): BOOL; stdcall;

var
  GDI32Lib: HMODULE;
  AddFontMemResource: TAddFontMemResource;
  RemoveFontMemResource: TRemoveFontMemResource;

procedure InitializeSchedulerLink;

  function LoadImagesFromResource(AWidth, AHeight: Integer;
    const AResourceName: string): TImageList;
  begin
    Result := TImageList.Create(nil);
    Result.Width := AWidth;
    Result.Height := AHeight;
    Result.Handle := ImageList_LoadImage(HInstance, PAnsiChar(AResourceName), AWidth,
      AHeight, CLR_DEFAULT, IMAGE_BITMAP, LR_DEFAULTCOLOR);
  end;

var
  Res : TResourceStream;
  Count: DWORD;
begin
  RegisterMirrorClasses;
  // images loading
  StyleImages := LoadImagesFromResource(58, 31, IDB_DXPSSCHEDULER_SMALLDESIGNPREVIEW);
  StylePreviewImages := LoadImagesFromResource(128, 76, IDB_DXPSSCHEDULER_STYLEDESIGNPREVIEW);

  // font loading
  GDI32Lib := LoadLibrary(gdi32);
  AddFontMemResource := GetProcAddress(GDI32Lib, 'AddFontMemResourceEx');
  RemoveFontMemResource := GetProcAddress(GDI32Lib, 'RemoveFontMemResourceEx');
  Res := TResourceStream.Create(hInstance, 'SCHEDULERFONT', 'PSSCHEDULERFONT');
  try
    if IsWin2KOrLater then
      SchedulerFontHandle := AddFontMemResource(Res.Memory, Res.Size, nil, @Count)
    else
    begin
      SchedulerFontFileName := GetFontFolder + '\' + 'dxPScxSchedulerLnk.ttf';
      Res.SavetoFile(SchedulerFontFileName);
      AddFontResource(PChar(SchedulerFontFileName));
    end;
  finally
    Res.Free;
  end;
  SpecialSymbolFont := TFont.Create;
  SpecialSymbolFont.Name := 'dxPScxScheduler';
  RegisterReportLinkClasses;
end;

procedure UnregisterReportLinkClasses;
begin
  TcxSchedulerReportSchedulingAreaCell.Unregister;
  TcxSchedulerReportNotesAreaCell.Unregister;
  TcxSchedulerReportTaskPadCell.Unregister;
  TcxSchedulerReportSchedulerHeaderCell.Unregister;
  TcxSchedulerReportSchedulerHeaderDataCell.Unregister;
  //datenavigator
  TcxSchedulerReportDateNavigatorCell.Unregister;
  TcxSchedulerReportDateNavigatorHeader.Unregister;
  TcxSchedulerReportDateNavigatorDay.Unregister;
  TcxSchedulerReportDateNavigatorDayCaption.Unregister;
  TcxSchedulerReportDateNavigatorWeekNumber.Unregister;

  //scheduling area items
  TcxSchedulerReportContentCell.Unregister;
  TcxSchedulerReportHeaderItemCell.Unregister;
  TcxSchedulerReportGroupSeparatorCell.Unregister;
  TcxSchedulerReportContainerCell.Unregister;
  TcxSchedulerReportBackgroundSlotCell.Unregister;
  TcxSchedulerReportDailyTimeRulerCellsSite.Unregister;
  TcxSchedulerReportDailyTimeRulerCell.Unregister;
  TcxSchedulerReportMonthDayCell.Unregister;

  TcxSchedulerReportEventCell.Unregister;
  TcxSchedulerReportDetailsEventCell.Unregister;
  TcxSchedulerReportMemoEventCell.Unregister;

  TcxSchedulerReportTimeLineCell.Unregister;
  TcxSchedulerReportTimeLinePart.Unregister;

  TcxSchedulerReportPageSite.Unregister;

  dxPSUnregisterReportLink(TcxSchedulerReportLink,
    TcxScheduler, TcxfmSchedulerReportLinkDesignWindow);
  UnRegisterClasses([TcxSchedulerReportLinkStyles]);
  UnRegisterMirrorClasses;
end;

procedure FinalizeSchedulerLink;
begin
  // images removing
  FreeAndNil(StyleImages);
  FreeAndNil(StylePreviewImages);

  // font removing
  if IsWin2KOrLater then
  begin
    if SchedulerFontHandle <> 0 then
      RemoveFontMemResource(SchedulerFontHandle);
  end
  else
  begin
    RemoveFontResource(PChar(SchedulerFontFileName));
    DeleteFile(PChar(SchedulerFontFileName));
  end;

  SpecialSymbolFont.Free;
  FreeLibrary(GDI32Lib);

  UnregisterReportLinkClasses;
end;

initialization
  InitializeSchedulerLink;

finalization
  FinalizeSchedulerLink;

end.
