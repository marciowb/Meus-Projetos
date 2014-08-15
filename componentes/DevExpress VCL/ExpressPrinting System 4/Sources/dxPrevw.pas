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

unit dxPreVw;

interface

{$I cxVer.inc}

uses
  Classes, Controls, Messages, Windows, Graphics, Forms, StdCtrls, SysUtils, 
  ExtCtrls, FlatSB, dxWrap, dxBkgnd, dxPSUtl, dxPSGlbl, cxGraphics, cxGeometry,
  cxControls, dxPSReportRenderCanvas, cxLookAndFeels, cxLookAndFeelPainters,
  IniFiles;

const
  dxPreviewDragHintOffset = 5;
  dxPreviewMarginSelectDelta = 3;
  dxPreviewMinZoomFactor = 5;
  dxPreviewScrollStep = 30;
  dxPreviewMinUsefulSize: TPoint = (X: 500; Y: 500);
  dxPreviewMinHeaderFooterSize = 127;

type
  TdxPreviewOptionBehavior = (pobAllowDragMargins, pobHotTrack, pobKeyNavigation,
    pobStoreInRegistry, pobThumbTracking, pobAutoSwapMargins, pobNonCenterizePages);
  TdxPreviewOptionsBehavior = set of TdxPreviewOptionBehavior;

  TdxPreviewOptionHint = (pohShowForMargins, pohShowOnDrag, pohShowOnScroll);
  TdxPreviewOptionsHint = set of TdxPreviewOptionHint;

  TdxPreviewOptionStore = (posZoom);
  TdxPreviewOptionsStore = set of TdxPreviewOptionStore;

  TdxPreviewOptionView = (povAutoHideScrollBars, povDefaultDrawPageBackground, povMargins, povPageSelection);
  TdxPreviewOptionsView = set of TdxPreviewOptionView;

  TdxPreviewOptionZoom = (pozZoomOnClick, pozZoomOnMouseRoll);
  TdxPreviewOptionsZoom = set of TdxPreviewOptionZoom;

  TdxPreviewDragStage = (pdsAfter, pdsBefore, pdsDrag);
  TdxPreviewMeasurementUnits = (pmuDefault, pmuInches, pmuMillimeters, pmuCentimeters, pmuPoints, pmuPicas);
  TdxPreviewPaperOrientation = (ppoPortrait, ppoLandscape);
  TdxPreviewScrollDirection = (psdLeft, psdUp, psdRight, psdDown);
  TdxPreviewZoomMode = (pzmNone, pzmPageWidth, pzmPages);

const
  dxPSPreviewDefaultBehaviorOptions =
    [pobAllowDragMargins, pobKeyNavigation, pobThumbTracking, pobAutoSwapMargins];
  dxPSPreviewDefaultOptionsView =
    [povAutoHideScrollBars, povDefaultDrawPageBackground, povMargins, povPageSelection];
  dxPSPreviewDefaultOptionsHint = [pohShowForMargins, pohShowOnDrag, pohShowOnScroll];

type
  TCMHintHide = TWMNoParams;

  TCustomdxPreview = class;
  TdxPreviewPageMargins = class;
  
  TdxPreviewPageClass = class of TdxPreviewPage;

  { TdxPreviewPage }

  TdxPreviewPage = class(TObject)
  private
    FBounds: TRect;
    FPreview: TCustomdxPreview;
    function GetIndex: Integer;
    function GetPartVisible: Boolean;
    function GetSelected: Boolean;
    function GetSiteBounds: TRect;
    function GetVisible: Boolean;
    function GetZoomed: Boolean;
    procedure SetBounds(const Value: TRect);
    procedure SetSelected(Value: Boolean);
  public
    constructor Create(APreview: TCustomdxPreview); virtual;

    function GetCursor: TCursor; virtual;
    function HasPoint(const Pt: TPoint): Boolean; overload;
    function HasPoint(X, Y: Integer): Boolean; overload;
    procedure MakeVisible;

    property Bounds: TRect read FBounds write SetBounds;
    property Index: Integer read GetIndex;
    property PartVisible: Boolean read GetPartVisible;
    property Preview: TCustomdxPreview read FPreview;
    property Selected: Boolean read GetSelected write SetSelected;
    property SiteBounds: TRect read GetSiteBounds;
    property Visible: Boolean read GetVisible;
    property Zoomed: Boolean read GetZoomed;
  end;

  TdxPreviewHitTest = (phtNoWhere, phtPage, phtMarginLeft, phtMarginTop,
    phtMarginRight, phtMarginBottom, phtMarginHeader, phtMarginFooter);
  TdxPreviewHitTests = set of TdxPreviewHitTest;
  
  TdxPreviewPageMarginClass = class of TdxPreviewPageMargin;

  { TdxPreviewPageMargin }
  
  TdxPreviewPageMargin = class(TPersistent)
  private
    FCaption: string;
    FDraggingPos: Integer;
    FEnabled: Boolean;
    FIsCaptionAssigned: Boolean;
    FMargins: TdxPreviewPageMargins;
    FMaxValue: Integer;
    FMinValue: Integer;
    FScreenBitmap: HBITMAP;
    FValue: Integer;
    FVisible: Boolean;
    function GetActualMaxValue: Integer;
    function GetActualMinValue: Integer;
    function GetActualValue: Integer;
    function GetBounds: TRect;
    function GetCaption: string;
    function GetDisplayText: string;
    function GetDraggingValue: Integer;
    function GetIsDragging: Boolean;
    function GetIsDraggingPosAssigned: Boolean;
    function GetMaxPos: Integer;
    function GetMinPos: Integer;
    function GetPageBounds: TRect;
    function GetPreview: TCustomdxPreview;
    function GetSelectableBounds: TRect;
    function GetVisibleValue: Integer;
    function IsCaptionStored: Boolean;
    function IsValueStored: Boolean;
    procedure SetCaption(const Value: string);
    procedure SetDraggingPos(Value: Integer);
    procedure SetEnabled(Value: Boolean);
    procedure SetMaxValue(AValue: Integer);
    procedure SetMinValue(AValue: Integer);
    procedure SetValue(AValue: Integer);
    procedure SetVisible(Value: Boolean);

    procedure ReadIsCaptionAssigned(AReader: TReader);
    procedure WriteIsCaptionAssigned(AWriter: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    
    function GetIsForceRecalculatePageCount: Boolean; virtual;
    function GetIsForward: Boolean; virtual;
    function GetIsVertical: Boolean; virtual;
    function DoGetActualMaxValue: Integer; virtual;
    function DoGetActualMinValue: Integer; virtual;
    function DoGetMaxMinValue: Integer; virtual;
    function DoPosFromValue(AValue: Integer): Integer; virtual;
    function DoValueFromPos(APos: Integer): Integer; virtual;
    
    procedure Changed(HardRefresh: Boolean); virtual;
    procedure DoAssign(Source: TdxPreviewPageMargin); virtual;
    procedure DoDragAfter;
    procedure DoDragBefore;
    procedure DoRestoreDefaults; virtual;

    procedure Draw(DC: HDC); virtual;
    procedure Invalidate; virtual;
    procedure Invert(DC: HDC); virtual;

    function CheckValue(Value: Integer): Integer;
    function PosFromValue(AValue: Integer): Integer;
    function ValueFromPos(APos: Integer): Integer;

    property ActualMaxValue: Integer read GetActualMaxValue;
    property ActualMinValue: Integer read GetActualMinValue;
    property ActualValue: Integer read GetActualValue;
    property Bounds: TRect read GetBounds;
    property DraggingPos: Integer read FDraggingPos write SetDraggingPos;
    property IsForceRecalculatePageCount: Boolean read GetIsForceRecalculatePageCount;
    property MaxPos: Integer read GetMaxPos;
    property MaxValue: Integer read FMaxValue write SetMaxValue; // HIMETRIC
    property MinPos: Integer read GetMinPos;
    property PageBounds: TRect read GetPageBounds;
    property Preview: TCustomdxPreview read GetPreview;
    property SelectableBounds: TRect read GetSelectableBounds;
  public
    constructor Create(AMargins: TdxPreviewPageMargins); virtual;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults;
    
    procedure BeginUpdate;
    procedure EndUpdate;

    function DefaultCaption: string; virtual;
    function DefaultValue: Integer; virtual;
    function GetHitTest: TdxPreviewHitTest; virtual;
    function GetCursor: TCursor; virtual;
    
    function HasPoint(const Pt: TPoint): Boolean; overload;
    function HasPoint(const Pt: TSmallPoint): Boolean; overload;
    function HasPoint(X, Y: Integer): Boolean; overload;
    
    property DisplayText: string read GetDisplayText;
    property DraggingValue: Integer read GetDraggingValue;
    property IsDragging: Boolean read GetIsDragging;
    property IsDraggingPosAssigned: Boolean read GetIsDraggingPosAssigned;
    property IsForward: Boolean read GetIsForward;
    property IsVertical: Boolean read GetIsVertical;
    property Margins: TdxPreviewPageMargins read FMargins;
    property VisibleValue: Integer read GetVisibleValue; // pixels
  published
    property Caption: string read GetCaption write SetCaption stored IsCaptionStored;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property MinValue: Integer read FMinValue write SetMinValue default 0;   // HIMETRIC      
    property Value: Integer read FValue write SetValue stored IsValueStored; // HIMETRIC
    property Visible: Boolean read FVisible write SetVisible default True;
  end;

  { TdxPreviewPageMarginBottom }

  TdxPreviewPageMarginBottom = class(TdxPreviewPageMargin)
  protected
    function GetIsForceRecalculatePageCount: Boolean; override;
    function GetIsForward: Boolean; override;
    function GetIsVertical: Boolean; override;
    function DoGetActualMaxValue: Integer; override;
    function DoGetActualMinValue: Integer; override;
    function DoGetMaxMinValue: Integer; override;
    function DoPosFromValue(AValue: Integer): Integer; override;
    function DoValueFromPos(APos: Integer): Integer; override;
  public
    function DefaultCaption: string; override;
    function DefaultValue: Integer; override;
    function GetHitTest: TdxPreviewHitTest; override;
    function GetCursor: TCursor; override;
  end;

  { TdxPreviewPageMarginFooter }
  
  TdxPreviewPageMarginFooter = class(TdxPreviewPageMargin)
  protected
    function GetIsForward: Boolean; override;
    function GetIsVertical: Boolean; override;
    function DoGetActualMaxValue: Integer; override;
    function DoGetMaxMinValue: Integer; override;
    function DoPosFromValue(AValue: Integer): Integer; override;
    function DoValueFromPos(APos: Integer): Integer; override;
  public
    function DefaultCaption: string; override;
    function DefaultValue: Integer; override;
    function GetHitTest: TdxPreviewHitTest; override;
    function GetCursor: TCursor; override;
  end;

  { TdxPreviewPageMarginHeader }
  
  TdxPreviewPageMarginHeader = class(TdxPreviewPageMargin)
  protected
    function GetIsForward: Boolean; override;
    function GetIsVertical: Boolean; override;
    function DoGetActualMaxValue: Integer; override;
    function DoGetMaxMinValue: Integer; override;
    function DoPosFromValue(AValue: Integer): Integer; override;
    function DoValueFromPos(APos: Integer): Integer; override;
  public
    function DefaultCaption: string; override;
    function DefaultValue: Integer; override;
    function GetHitTest: TdxPreviewHitTest; override;
    function GetCursor: TCursor; override;
  end;

  { TdxPreviewPageMarginLeft }
  
  TdxPreviewPageMarginLeft = class(TdxPreviewPageMargin)
  protected
    function GetIsForceRecalculatePageCount: Boolean; override;
    function GetIsForward: Boolean; override;
    function GetIsVertical: Boolean; override;
    function DoGetActualMaxValue: Integer; override;
    function DoGetMaxMinValue: Integer; override;
    function DoPosFromValue(AValue: Integer): Integer; override;
    function DoValueFromPos(APos: Integer): Integer; override;
  public
    function DefaultCaption: string; override;
    function DefaultValue: Integer; override;
    function GetHitTest: TdxPreviewHitTest; override;
    function GetCursor: TCursor; override;
  end;

  { TdxPreviewPageMarginRight }
  
  TdxPreviewPageMarginRight = class(TdxPreviewPageMargin)
  protected
    function GetIsForceRecalculatePageCount: Boolean; override;
    function GetIsForward: Boolean; override;
    function GetIsVertical: Boolean; override;
    function DoGetActualMaxValue: Integer; override;
    function DoGetMaxMinValue: Integer; override;
    function DoPosFromValue(AValue: Integer): Integer; override;
    function DoValueFromPos(APos: Integer): Integer; override;
  public
    function DefaultCaption: string; override;
    function DefaultValue: Integer; override;
    function GetHitTest: TdxPreviewHitTest; override;
    function GetCursor: TCursor; override;
  end;

  { TdxPreviewPageMarginTop }
  
  TdxPreviewPageMarginTop = class(TdxPreviewPageMargin)
  protected
    function GetIsForceRecalculatePageCount: Boolean; override;
    function GetIsForward: Boolean; override;
    function GetIsVertical: Boolean; override;
    function DoGetActualMaxValue: Integer; override;
    function DoGetActualMinValue: Integer; override;
    function DoGetMaxMinValue: Integer; override;
    function DoPosFromValue(AValue: Integer): Integer; override;
    function DoValueFromPos(APos: Integer): Integer; override;
  public  
    function DefaultCaption: string; override;
    function DefaultValue: Integer; override;
    function GetHitTest: TdxPreviewHitTest; override;
    function GetCursor: TCursor; override;
  end;

  { TdxPreviewPageMargins }

  TdxPreviewPageMarginsClass = class of TdxPreviewPageMargins;

  TdxPreviewPageMargins = class(TPersistent)
  private
    FMargins: TList;
    FPreview: TCustomdxPreview;
    FUpdateCount: Integer;
    function GetCount: Integer;
    function GetMargin(Index: Integer): TdxPreviewPageMargin;
    function GetMarginBottom: TdxPreviewPageMarginBottom;
    function GetMarginByCaption(const Caption: string): TdxPreviewPageMargin;
    function GetMarginByClass(Index: TdxPreviewPageMarginClass): TdxPreviewPageMargin;
    function GetMarginFooter: TdxPreviewPageMarginFooter;
    function GetMarginHeader: TdxPreviewPageMarginHeader;
    function GetMarginLeft: TdxPreviewPageMarginLeft;
    function GetMarginRight: TdxPreviewPageMarginRight;
    function GetMarginTop: TdxPreviewPageMarginTop;
    procedure SetMargin(Index: Integer; Value: TdxPreviewPageMargin);
    procedure SetMarginByClass(Index: TdxPreviewPageMarginClass; Value: TdxPreviewPageMargin);
    procedure SetMarginBottom(Value: TdxPreviewPageMarginBottom);
    procedure SetMarginFooter(Value: TdxPreviewPageMarginFooter);
    procedure SetMarginHeader(Value: TdxPreviewPageMarginHeader);
    procedure SetMarginLeft(Value: TdxPreviewPageMarginLeft);
    procedure SetMarginRight(Value: TdxPreviewPageMarginRight);
    procedure SetMarginTop(Value: TdxPreviewPageMarginTop);
  protected
    procedure DoAssign(Source: TdxPreviewPageMargins); virtual;
    procedure DoRestoreDefaults; virtual;

    function AddMargin(AClass: TdxPreviewPageMarginClass): TdxPreviewPageMargin; virtual;
    procedure AddMargins; virtual;
    procedure FreeAndNilMargins;
    procedure Update(AMargin: TdxPreviewPageMargin); virtual;
  public
    constructor Create(APreview: TCustomdxPreview); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; 

    procedure BeginUpdate;
    procedure EndUpdate;
    
    property Count: Integer read GetCount;
    property Margins[Index: Integer]: TdxPreviewPageMargin read GetMargin write SetMargin; default;
    property MarginsByCaption[const Caption: string]: TdxPreviewPageMargin read GetMarginByCaption;
    property MarginsByClass[Index: TdxPreviewPageMarginClass]: TdxPreviewPageMargin read GetMarginByClass write SetMarginByClass;
    property Preview: TCustomdxPreview read FPreview;
  published
    property Bottom: TdxPreviewPageMarginBottom read GetMarginBottom write SetMarginBottom;
    property Footer: TdxPreviewPageMarginFooter read GetMarginFooter write SetMarginFooter;
    property Header: TdxPreviewPageMarginHeader read GetMarginHeader write SetMarginHeader;
    property Left: TdxPreviewPageMarginLeft read GetMarginLeft write SetMarginLeft;
    property Right: TdxPreviewPageMarginRight read GetMarginRight write SetMarginRight;
    property Top: TdxPreviewPageMarginTop read GetMarginTop write SetMarginTop;
  end;

  { TdxPreviewPageBackground }

  TdxPreviewPageBackground = class(TdxBackground)
  private
    FBitmap: TBitmap;
    FPreview: TCustomdxPreview;
  protected  
    procedure DoApply; override;
    procedure DoChange(AChangeWhats: TdxBackgroundParams); override;
    function HasPreview: Boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Paint(ACanvas: TCanvas; const R: TRect); override;
    //
    property Preview: TCustomdxPreview read FPreview;
    property OnApply;
  end;

  TdxDrawPageContentEvent = procedure(Sender: TObject; ACanvas: TCanvas;
    ARect: TRect; APageIndex: Integer) of object;
    
  TdxGetPageNumberHintEvent = procedure(Sender: TObject; 
    AStartPage, AEndPage: Integer; var AHintString: string) of object;
    
  TdxCanShowMarginHintEvent = procedure(Sender: TObject; 
    var ACanShowHint: Boolean) of object;
    
  TdxMarginEvent = procedure(Sender: TObject; AMargin: TdxPreviewPageMargin) of object;
  
  TdxPreviewPageEvent = procedure(Sender: TObject; APageIndex: Integer) of object;
  
  TdxPageBackgroundDrawEvent = procedure(Sender: TObject; ACanvas: TCanvas;
    const ARect: TRect; APageIndex: Integer) of object;
    
  TdxSelectingPageEvent = procedure(Sender: TObject; APagePage: Integer;
    var ACanSelect: Boolean) of object;

  { TCustomdxPreview }

  TCustomdxPreview = class(TcxControl)
  private
    FAbsoluteIndentLeft: Integer;
    FAbsoluteIndentRight: Integer;
    FActualOriginalPageSize: TPoint;
    FBeforeDragPos: Integer;
    FBorderStyle: TBorderStyle;
    FContentCache: TcxBitmap;
    FContentCacheDirty: Boolean;
    FDraggingMargin: TdxPreviewPageMargin;
    FDragOffset: Integer;
    FHintHideLongTimer: TTimer;
    FHintHideShortTimer: TTimer;
    FHintShowTimer: TTimer;
    FHintWindow: TCustomControl;
    FHintWindowPageNumber: TCustomControl;
    FIndent: Integer;
    FIsNoPagesTextAssigned: Boolean;
    FLastMousePos: TPoint;
    FLeftPos: Integer;
    FMarginColor: TColor;
    FMarginPen: HPEN;
    FMargins: TdxPreviewPageMargins;
    FMaxZoomFactor: Integer;
    FMeasurementUnits: TdxPreviewMeasurementUnits;
    FMinFooterSize: Integer;
    FMinHeaderSize: Integer;
    FMinUsefulSize: TPoint;
    FMinZoomFactor: Integer;
    FNoPagesText: string;
    FOnAfterDragMargin: TdxMarginEvent;
    FOnBeforeDragMargin: TdxMarginEvent;
    FOnCalcPageCount: TNotifyEvent;
    FOnCanShowMarginHint: TdxCanShowMarginHintEvent;
    FOnChangePageCount: TNotifyEvent;
    FOnDragMargin: TdxMarginEvent;
    FOnDrawPageBackground: TdxPageBackgroundDrawEvent;
    FOnDrawPageContent: TdxDrawPageContentEvent;
    FOnGetPageNumberHint: TdxGetPageNumberHintEvent;
    FOnMarginChanged: TdxMarginEvent;
    FOnPostDrawPageContent: TdxDrawPageContentEvent;
    FOnSelectedPageChanged: TdxPreviewPageEvent;
    FOnSelectedPageChanging: TdxPreviewPageEvent;
    FOnSelectingPage: TdxSelectingPageEvent;
    FOnZoomFactorChanged: TNotifyEvent;
    FOnZoomModeChanged: TNotifyEvent;
    FOptionsBehavior: TdxPreviewOptionsBehavior;
    FOptionsHint: TdxPreviewOptionsHint;
    FOptionsStore: TdxPreviewOptionsStore;
    FOptionsView: TdxPreviewOptionsView;
    FOptionsZoom: TdxPreviewOptionsZoom;
    FOrientation: TdxPreviewPaperOrientation;
    FOriginalPageSize: TdxPointWrapper;
    FPageBackground: TdxBackground;
    FPages: TList;
    FPageSize: TPoint;
    FPageXCount: Integer;
    FPageYCount: Integer;
    FRegistryPath: string;
    FScrollBars: TScrollStyle;
    FScrollBarStyle: TScrollBarStyle;
    FSelPageIndex: Integer;
    FTopPos: Integer;
    FTransparent: Boolean;
    FUnzoomedFactor: Integer;
    FUnzoomedMode: TdxPreviewZoomMode;
    FUpdateCount: Integer;
    FZoomed: Boolean;
    FZoomedFixed: Boolean;
    FZoomFactor: Integer;
    FZooming: Boolean;
    FZoomMode: TdxPreviewZoomMode;
    FZoomModeFixed: Boolean;
    FZoomStep: Integer;
    function GetAbsoluteIndent: Integer;
    function GetActualMeasurementUnits: TdxPreviewMeasurementUnits;
    function GetAllRowCount: Integer;
    function GetClientHeight: Integer;
    function GetClientWidth: Integer;
    function GetColCount: Integer;
    function GetContentHeight: Integer;
    function GetContentWidth: Integer;
    function GetNoPagesText: string;
    function GetPage(Index: Integer): TdxPreviewPage;
    function GetPageBorders: TRect;
    function GetPageCount: Integer;
    function GetRowCount: Integer;
    function GetSelPageCol: Integer;
    function GetSelPageRow: Integer;
    function GetVirtualHeight: Integer;
    function GetVirtualWidth: Integer;
    function GetVisiblePageSize: TPoint;
    function IsNoPagesTextStored: Boolean;
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure SetLeftPos(Value: Integer);
    procedure SetMarginColor(Value: TColor);
    procedure SetMargins(Value: TdxPreviewPageMargins);
    procedure SetMaxZoomFactor(Value: Integer);
    procedure SetMinZoomFactor(Value: Integer);
    procedure SetMinFooterSize(Value: Integer);
    procedure SetMinHeaderSize(Value: Integer);
    procedure SetMinUsefulSize(const Value: TPoint);
    procedure SetNoPagesText(const Value: string);
    procedure SetOnCalcPageCount(Value: TNotifyEvent);
    procedure SetOptionsBehavior(Value:  TdxPreviewOptionsBehavior);
    procedure SetOptionsHint(Value:  TdxPreviewOptionsHint);
    procedure SetOptionsStore(Value: TdxPreviewOptionsStore);
    procedure SetOptionsView(Value: TdxPreviewOptionsView);
    procedure SetOptionsZoom(Value: TdxPreviewOptionsZoom);
    procedure SetOrientation(Value: TdxPreviewPaperOrientation);
    procedure SetOriginalPageSize(Value: TdxPointWrapper);
    procedure SetPageBackground(Value: TdxBackground);
    procedure SetPageCount(Value: Integer);
    procedure SetPageXCount(Value: Integer);
    procedure SetPageYCount(Value: Integer);
    procedure SetScrollBars(Value: TScrollStyle);
    procedure SetScrollBarStyle(Value: TScrollBarStyle);
    procedure SetSelPageIndex(Value: Integer);
    procedure SetTopPos(Value: Integer);
    procedure SetTransparent(AValue: Boolean);
    procedure SetZoomed(Value: Boolean);
    procedure SetZoomFactor(Value: Integer);
    procedure SetZoomMode(Value: TdxPreviewZoomMode);
    procedure SetZoomStep(Value: Integer);
    
    procedure AdjustOrientation;
    procedure AdjustPagesBounds;  
     
    procedure PageParametersChanging(Sender: TObject; Coords: TdxPointCoords;
      var Values: array of Integer);
    procedure PageParametersChanged(Sender: TObject; Coords: TdxPointCoords);
    procedure ResyncSelPageIndex;
   
    function CanAnyScrolling: Boolean;
    function CanHorzScrollBarBeVisible: Boolean;
    function CanHorzScrolling: Boolean;
    function CanPageScrolling(ADirection: TdxPreviewScrollDirection): Boolean;
    function CanVertScrollBarBeVisible: Boolean;
    function CanVertScrolling: Boolean;
    procedure ScrollPage(ADirection: TdxPreviewScrollDirection);

    function CanChangeMargins: Boolean;    
    procedure CancelDragMargin;
    procedure ClearLastMousePos;
    procedure FreeMarginPen;
    procedure RecreateMarginPen;

    procedure ActivateHint(AMargin: TdxPreviewPageMargin);
    procedure CancelHintHide;
    procedure CancelHintShow;
    procedure CreateHint;
    procedure DestroyHint;
    procedure ResetHintShowTimer(X, Y: Integer);
    procedure StartHintShow;
    
    procedure DestroyPageNumberHint;
    procedure UpdatePageNumberHint;
    
    procedure DesignerModified;            
    function IsDesigning: Boolean; 
    function IsParentFormActive: Boolean;

    procedure HintHideLongTimerHandler(Sender: TObject);    
    procedure HintHideShortTimerHandler(Sender: TObject);
    procedure HintShowTimerHandler(Sender: TObject);
    
    procedure ReadIsNoPagesTextAssigned(AReader: TReader);
    procedure WriteIsNoPagesTextAssigned(AWriter: TWriter);
    
    procedure CMCancelMode(var Message: TCMCancelMode); Message CM_CANCELMODE;
    procedure CMColorChanged(var Message: TMessage); Message CM_COLORCHANGED;
    procedure CMCtl3DChanged(var Message: TMessage); Message CM_CTL3DCHANGED;
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); Message CM_DESIGNHITTEST;
    procedure CMHintShow(var Message: TCMHintShow); Message CM_HINTSHOW;
    procedure CMSysColorChange(var Message: TMessage); Message CM_SYSCOLORCHANGE;
    procedure WMCaptureChanged(var Message: TMessage); Message WM_CAPTURECHANGED;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); Message WM_GETDLGCODE;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); Message WM_ERASEBKGND;
    procedure WMKillFocus(var Message: TWMKillFocus); Message WM_KILLFOCUS;
    procedure WMRButtonUp(var Message: TWMRButtonUp); Message WM_RBUTTONUP;
    procedure WMMouseActivate(var Message: TWMMouseActivate); Message WM_MOUSEACTIVATE;
    procedure WMMouseWheel(var Message: TWMMouseWheel); Message WM_MOUSEWHEEL;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); Message WM_NCCALCSIZE;
    procedure WMNCDestroy(var Message: TWMNCDestroy); Message WM_NCDESTROY;
    procedure WMNCHitTest(var Message: TWMNCHitTest); Message WM_NCHITTEST;
    procedure WMNCPaint(var Message: TWMNCPaint); Message WM_NCPAINT;
    procedure WMSetCursor(var Message: TWMSetCursor); Message WM_SETCURSOR;
    procedure WMSize(var Message: TWMSize); Message WM_SIZE;
  protected
    procedure AdjustSize; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure InitScrollBarsParameters; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
    procedure Scroll(AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode;
      var AScrollPos: Integer); override;
    procedure ScrollHorizontal(AScrollCode: TScrollCode; AScrollPos: Integer); virtual;
    procedure ScrollVertical(AScrollCode: TScrollCode; AScrollPos: Integer); virtual;
    procedure WndProc(var Message: TMessage); override;

    function CreateMargins: TdxPreviewPageMargins; virtual;
    function GetMarginsClass: TdxPreviewPageMarginsClass; virtual;
    
    function CreatePage: TdxPreviewPage; virtual;
    function GetPageClass: TdxPreviewPageClass; virtual;

    function CheckLeftPos(Value: Integer): Integer;
    function CheckTopPos(Value: Integer): Integer;
    procedure CheckContentCache;
    procedure CheckMargins;
    procedure CheckZoomFactor;
    procedure UpdatePreviewIndents;

    function CalculateIndent: Integer;
    function CanSelectPage(APageIndex: Integer): Boolean; dynamic;
    function CanShowMarginHint: Boolean; dynamic;
    function CreateBackgroundRegion(const APageBounds: TRect): TcxRegion;
    procedure DoAfterDragMargin(AMargin: TdxPreviewPageMargin); dynamic;
    procedure DoBeforeDragMargin(AMargin: TdxPreviewPageMargin); dynamic;
    procedure DoCalcPageCount; dynamic;
    procedure DoChangePageCount; dynamic;
    procedure DoDragMargin(AMargin: TdxPreviewPageMargin); dynamic;
    procedure DoDrawPageContent(ACanvas: TcxCanvas; R: TRect; APageIndex: Integer); dynamic;
    procedure DoGetPageNumberHintText(out AText: string); dynamic;
    procedure DoMarginChanged(AMargin: TdxPreviewPageMargin); dynamic;
    procedure DoZoomFactorChanged; dynamic;
    procedure DoZoomModeChanged; dynamic;
    procedure DoSelectedPageChanging; dynamic;
    procedure DoSelectedPageChanged; dynamic;

    procedure DrawContent(ACanvas: TcxCanvas; const R: TRect);
    procedure DrawMargins(DC: HDC);
    procedure DrawNoPages(ACanvas: TcxCanvas);
    procedure DrawPage(ACanvas: TcxCanvas; APage: TdxPreviewPage; ASelected: Boolean);
    procedure DrawPageBackground(ACanvas: TcxCanvas; APage: TdxPreviewPage; ASelected: Boolean); virtual;
    procedure DrawPages(ACanvas: TcxCanvas);
    procedure DrawPreviewBackground(ACanvas: TcxCanvas; const R: TRect);

    procedure InvalidateMargins;
    procedure InvalidatePageBorder(APageIndex: Integer);

    property AbsoluteIndent: Integer read GetAbsoluteIndent;
    property AbsoluteIndentLeft: Integer read FAbsoluteIndentLeft;
    property AbsoluteIndentRight: Integer read FAbsoluteIndentRight;
    property ContentHeight: Integer read GetContentHeight;
    property ContentWidth: Integer read GetContentWidth;
    property ContentCache: TcxBitmap read FContentCache;
    property ContentCacheDirty: Boolean read FContentCacheDirty write FContentCacheDirty;
    property ScrollBarStyle: TScrollBarStyle read FScrollBarStyle write SetScrollBarStyle default ssRegular;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure LoadFromIniFile(AIniFile: TCustomIniFile; const ASectionName: string); virtual;
    procedure LoadFromRegistry(const ARegistryPath: string); virtual;
    procedure SaveToIniFile(AIniFile: TCustomIniFile; const ASectionName: string); virtual;
    procedure SaveToRegistry(const ARegistryPath: string); virtual;

    function DefaultNoPagesText: string; virtual;

    procedure BeginUpdate;
    procedure CancelUpdate;
    procedure EndUpdate;
    function IsUpdateLocked: Boolean;

    procedure GetPartVisiblePageRanges(AStartIndex, AEndIndex: PInteger ); overload;
    procedure GetPartVisiblePageRanges(out AStartIndex, AEndIndex: Integer); overload;
    procedure GetVisiblePageRanges(AStartIndex, AEndIndex: PInteger ); overload;
    procedure GetVisiblePageRanges(out AStartIndex, AEndIndex: Integer); overload;

    procedure InvalidatePage(APageIndex: Integer);
    procedure InvalidatePages;
    procedure InvalidatePagesContent;
    procedure InvalidatePagesFooter;
    procedure InvalidatePagesHeader;

    function GetHitInfoAt(const Pt: TPoint): TdxPreviewHitTests; overload;
    function GetHitInfoAt(const Pt: TSmallPoint): TdxPreviewHitTests; overload;
    function GetHitInfoAt(X, Y: Integer): TdxPreviewHitTests; overload;
    procedure CalcPagesBounds(ATopPos, AWidth, AHeight: Integer);
    procedure FullRefresh;
    procedure HideAllHints;
    procedure MakeVisible(APageIndex: Integer);
    procedure SetPageXYCount(XCount, YCount: Integer);

    procedure ZoomIn;
    procedure ZoomOut;
    
    function MarginFromPoint(const Pt: TPoint): TdxPreviewPageMargin; overload;
    function MarginFromPoint(const Pt: TSmallPoint): TdxPreviewPageMargin; overload;
    function MarginFromPoint(X, Y: Integer): TdxPreviewPageMargin; overload;
    function MarginValueToString(Value: Integer): string;    

    function IndexOfPage(APage: TdxPreviewPage): Integer;
    function PageIndexFromPoint(const Pt: TPoint): Integer; overload;
    function PageIndexFromPoint(const Pt: TSmallPoint): Integer; overload;
    function PageIndexFromPoint(X, Y: Integer): Integer; overload;
    function PageSizeToString: string;    

    procedure SelectFirstPage;
    procedure SelectLastPage;
    procedure SelectNextPage;
    procedure SelectPrevPage;

    property ActualMeasurementUnits: TdxPreviewMeasurementUnits read GetActualMeasurementUnits;
    property ActualOriginalPageSize: TPoint read FActualOriginalPageSize; // in tenths of a mm with Orientation
    property AllRowCount: Integer read GetAllRowCount;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property ClientHeight: Integer read GetClientHeight;
    property ClientWidth: Integer read GetClientWidth;
    property ColCount: Integer read GetColCount;
    property DraggingMargin: TdxPreviewPageMargin read FDraggingMargin;
    property Indent: Integer read FIndent;
    property LeftPos: Integer read FLeftPos write SetLeftPos;
    property MarginColor: TColor read FMarginColor write SetMarginColor default clWindowText;
    property Margins: TdxPreviewPageMargins read FMargins write SetMargins;
    property MaxZoomFactor: Integer read FMaxZoomFactor write SetMaxZoomFactor default 500;
    property MeasurementUnits: TdxPreviewMeasurementUnits read FMeasurementUnits write FMeasurementUnits default pmuDefault;
    property MinFooterSize: Integer read FMinFooterSize write SetMinFooterSize default dxPreviewMinHeaderFooterSize;
    property MinHeaderSize: Integer read FMinHeaderSize write SetMinHeaderSize default dxPreviewMinHeaderFooterSize;
    property MinUsefulSize: TPoint read FMinUsefulSize write SetMinUsefulSize;
    property MinZoomFactor: Integer read FMinZoomFactor write SetMinZoomFactor default 10;
    property NoPagesText: string read GetNoPagesText write SetNoPagesText stored IsNoPagesTextStored;
    property OptionsBehavior: TdxPreviewOptionsBehavior read FOptionsBehavior write SetOptionsBehavior default dxPSPreviewDefaultBehaviorOptions;
    property OptionsHint: TdxPreviewOptionsHint read FOptionsHint write SetOptionsHint default dxPSPreviewDefaultOptionsHint;
    property OptionsStore: TdxPreviewOptionsStore read FOptionsStore write SetOptionsStore default [posZoom];
    property OptionsView: TdxPreviewOptionsView read FOptionsView write SetOptionsView default dxPSPreviewDefaultOptionsView;
    property OptionsZoom: TdxPreviewOptionsZoom read FOptionsZoom write SetOptionsZoom  default [pozZoomOnClick];
    property Orientation: TdxPreviewPaperOrientation read FOrientation write SetOrientation default ppoPortrait;
    property OriginalPageSize: TdxPointWrapper read FOriginalPageSize write SetOriginalPageSize; // in tenths of a mm
    property PageBackground: TdxBackground read FPageBackground write SetPageBackground;
    property PageBorders: TRect read GetPageBorders;
    property PageCount: Integer read GetPageCount write SetPageCount;
    property Pages[Index: Integer]: TdxPreviewPage read GetPage;
    property PageSize: TPoint read FPageSize; // in pixels = 100% zoom
    property PageXCount: Integer read FPageXCount write SetPageXCount default 1;
    property PageYCount: Integer read FPageYCount write SetPageYCount default 1;
    property RegistryPath: string read FRegistryPath write FRegistryPath;
    property RowCount: Integer read GetRowCount;
    property ScrollBars: TScrollStyle read FScrollBars write SetScrollBars default ssBoth;
    property SelPageCol: Integer read GetSelPageCol;
    property SelPageIndex: Integer read FSelPageIndex write SetSelPageIndex;
    property SelPageRow: Integer read GetSelPageRow;
    property TopPos: Integer read FTopPos write SetTopPos;
    property Transparent: Boolean read FTransparent write SetTransparent;
    property VirtualHeight: Integer read GetVirtualHeight;
    property VirtualWidth: Integer read GetVirtualWidth;
    property VisiblePageSize: TPoint read GetVisiblePageSize;
    property Zoomed: Boolean read FZoomed write SetZoomed;
    property ZoomFactor: Integer read FZoomFactor write SetZoomFactor stored True default 100;
    property ZoomMode: TdxPreviewZoomMode read FZoomMode write SetZoomMode default pzmNone; //Pages;
    property ZoomStep: Integer read FZoomStep write SetZoomStep default 10;

    property OnAfterDragMargin: TdxMarginEvent read FOnAfterDragMargin write FOnAfterDragMargin;
    property OnBeforeDragMargin: TdxMarginEvent read FOnBeforeDragMargin write FOnBeforeDragMargin;
    property OnCalcPageCount: TNotifyEvent read FOnCalcPageCount write SetOnCalcPageCount;
    property OnDrawPageBackground: TdxPageBackgroundDrawEvent read FOnDrawPageBackground write FOnDrawPageBackground;
    property OnDragMargin: TdxMarginEvent read FOnDragMargin write FOnDragMargin;
    property OnDrawPageContent: TdxDrawPageContentEvent read FOnDrawPageContent write FOnDrawPageContent;
    property OnGetPageNumberHint: TdxGetPageNumberHintEvent read FOnGetPageNumberHint write FOnGetPageNumberHint;
    property OnCanShowMarginHint: TdxCanShowMarginHintEvent read FOnCanShowMarginHint write FOnCanShowMarginHint;
    property OnChangePageCount: TNotifyEvent read FOnChangePageCount write FOnChangePageCount;
    property OnMarginChanged: TdxMarginEvent read FOnMarginChanged write FOnMarginChanged;
    property OnPostDrawPageContent: TdxDrawPageContentEvent read FOnPostDrawPageContent write FOnPostDrawPageContent;
    property OnSelectedPageChanged: TdxPreviewPageEvent read FOnSelectedPageChanged write FOnSelectedPageChanged;
    property OnSelectedPageChanging: TdxPreviewPageEvent read FOnSelectedPageChanging write FOnSelectedPageChanging;
    property OnSelectingPage: TdxSelectingPageEvent read FOnSelectingPage write FOnSelectingPage;
    property OnZoomFactorChanged: TNotifyEvent read FOnZoomFactorChanged write FOnZoomFactorChanged;
    property OnZoomModeChanged: TNotifyEvent read FOnZoomModeChanged write FOnZoomModeChanged;
  end;

  TdxPreview = class(TCustomdxPreview)
  published
    property Align;
    property Anchors;
    property BorderStyle;
    property Color default clBtnShadow;
    property Constraints;
    property Ctl3D;
    property DragMode;
    property Enabled;
    property LookAndFeel;
    property MarginColor;
    property Margins;
    property MaxZoomFactor;
    property MeasurementUnits;
    property MinFooterSize;
    property MinHeaderSize;
    property MinZoomFactor;
    property OptionsBehavior;
    property OptionsHint;
    property OptionsStore;
    property OptionsView;
    property OptionsZoom;
    property Orientation;
    property OriginalPageSize;
    property PageBackground;
    property PageXCount;
    property PageYCount;
   {$IFDEF DELPHI7}
    property ParentBackground;
   {$ENDIF}
    property ParentColor default False;
    property ParentCtl3D;
    property ParentShowHint;
    property PopupMenu;
    property ScrollBars;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Transparent;
    property Visible;
    property ZoomFactor;
    property ZoomMode;
    property ZoomStep;
    property OnAfterDragMargin;
    property OnBeforeDragMargin;
    property OnCalcPageCount;
    property OnCanResize;
    property OnConstrainedResize;
  {$IFDEF DELPHI5}
    property OnContextPopup;
  {$ENDIF}
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragMargin;
    property OnDragOver;
    property OnDrawPageBackground;
    property OnDrawPageContent;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetPageNumberHint;
    property OnCanShowMarginHint;
    property OnMarginChanged;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnSelectedPageChanged;
    property OnSelectedPageChanging;
    property OnSelectingPage;
    property OnStartDrag;
    property OnZoomFactorChanged;
    property OnZoomModeChanged;
  end;

const
  phtMargins: TdxPreviewHitTests = [phtMarginLeft..phtMarginFooter];
  phtMarginsHorz: TdxPreviewHitTests = [phtMarginTop, phtMarginBottom, phtMarginHeader];
  phtMarginsVert: TdxPreviewHitTests = [phtMarginLeft, phtMarginRight];

implementation

uses
 {$IFDEF DELPHI7} 
  Themes, UxTheme,
 {$ENDIF}
  Math, TypInfo, Registry, CommCtrl, cxClasses, dxPSRes, dxPSImgs, dxExtCtrls;

type
  TFloat = Extended;
    
const
  { strings used when saving(loading) properties to(from) registry }
  sdxOptionsBehavior = 'OptionsBehavior';            // Don't localize
  sdxOptionsHint = 'OptionHint';                     // Don't localize
  sdxOptionsView = 'OptionView';                     // Don't localize
  sdxOptionsZoom = 'OptionZoom';                     // Don't localize
  sdxZoomFactor = 'ZoomFactor';                      // Don't localize
  sdxZoomStep = 'ZoomStep';                          // Don't localize
  sdxZoomMode = 'ZoomMode';                          // Don't localize
  sdxPageXCount = 'PageXCount';                      // Don't localize
  sdxPageYCount = 'PageYCount';                      // Don't localize
  sdxMarginColor = 'MarginColor';                    // Don't localize
  sdxMeasurementUnits = 'MeasurementUnits';          // Don't localize
  sdxOrientation = 'Orientation';                    // Don't localize

  NullDraggingPos = -Maxint;
  dxShowHintTimerID = 1;
  dxHideHintTimerID = 2;
  
  dxPreviewHideHintShortTime = 500;
  dxPreviewHideHintLongTime = 10000;
  dxPreviewShowHintTime = 500;
  
var
  A4_LOMETRIC: TPoint = (X: 2100; Y: 2970);
  FLongShowHintTime: DWORD;
    
  crdxPreviewHorzResize: TCursor;
  crdxPreviewVertResize: TCursor;
  crdxPreviewZoomIn: TCursor;
  crdxPreviewZoomOut: TCursor;
  crdxPreviewFullScroll: TCursor;
  crdxPreviewHorzScroll: TCursor;
  crdxPreviewVertScroll: TCursor;
  crdxPreviewUpScroll: TCursor;
  crdxPreviewRightScroll: TCursor;
  crdxPreviewDownScroll: TCursor;
  crdxPreviewLeftScroll: TCursor;
  crdxPreviewTopLeftScroll: TCursor;
  crdxPreviewBottomLeftScroll: TCursor;
  crdxPreviewTopRightLeftScroll: TCursor;
  crdxPreviewBottomRightScroll: TCursor;

  
{$IFDEF DELPHI6}
    {$WARN SYMBOL_PLATFORM OFF} 
{$ENDIF}

function GetDefaultMeasurementUnits: TdxPreviewMeasurementUnits;
begin
  if GetLocaleChar(LOCALE_USER_DEFAULT, LOCALE_IMEASURE, '0') = '0' then
    Result := pmuMillimeters
  else
    Result := pmuInches;
end;

{$IFDEF DELPHI6}
    {$WARN SYMBOL_PLATFORM ON}  
{$ENDIF}

function LoMetricToPixels(const Pt: TPoint): TPoint; overload;
var
  DC: HDC;
begin
  DC := GetDC(0);
  try
    Result.X := MulDiv(Pt.X, GetDeviceCaps(DC, LOGPIXELSX), 254);
    Result.Y := MulDiv(Pt.Y, GetDeviceCaps(DC, LOGPIXELSY), 254);
    //Result.X := MulDiv(Value.X, GetDeviceCaps(DC, HORZRES), 10 * GetDeviceCaps(DC, HORZSIZE));
    //Result.Y := MulDiv(Value.Y, GetDeviceCaps(DC, VERTRES), 10 * GetDeviceCaps(DC, VERTSIZE));  
  finally
    ReleaseDC(0, DC);
  end;
end;

function LoMetricToPixels(Value: Integer): Integer; overload;
var
  DC: HDC;
begin
  DC := GetDC(0);
  try
    Result := MulDiv(Value, GetDeviceCaps(DC, LOGPIXELSX), 254);
    //Result := MulDiv(Value, GetDeviceCaps(DC, HORZRES), 10 * GetDeviceCaps(DC, HORZSIZE));
  finally
    ReleaseDC(0, DC);
  end;
end;

function PixelsToLoMetric(Value: Integer): Integer;
var
  DC: HDC;
begin
  DC := GetDC(0);
  try
    Result := MulDiv(Value, 254, GetDeviceCaps(DC, LOGPIXELSX));
  finally
    ReleaseDC(0, DC);
  end;
end;

function LoMetricToAnother(Units: TdxPreviewMeasurementUnits; Value: Integer): TFloat;
var
  AUnits: TdxPreviewMeasurementUnits;
begin
  if Units = pmuDefault then
    AUnits := GetDefaultMeasurementUnits
  else
    AUnits := Units;
    
  case AUnits of
    pmuInches:
      Result := Value / 254;
    pmuMillimeters:
      Result := Value / 10;
    pmuCentimeters:
      Result := Value / 100;
    pmuPoints:
      Result := Value * 72 / 254;
  else { pmuPicas}
      Result := Value * 6 / 254;
  end;
end;

function MinMax(const AValue, AMinValue, AMaxValue: Integer): Integer;
begin
  if AMaxValue >= AMinValue then
    Result := Min(AMaxValue, Max(AValue, AMinValue))
  else
    Result := AMaxValue;
end;

function MaxMin(const AValue, AMinValue, AMaxValue: Integer): Integer;
begin
  Result := Max(AMinValue, Min(AValue, AMaxValue)); 
end;

type
  { TdxPreviewHintWindow }

  TdxPreviewHintWindow = class(TCustomControl)
  private
    FirstPos: TPoint;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;

    procedure DrawBorder(DC: HDC; R: TRect);
    procedure DrawText(DC: HDC; const R: TRect);
  public
    constructor Create(AOwner: TComponent); override;
    procedure ActivateHint(P: TPoint; const AHint: string; Margin: TdxPreviewPageMargin);
  end;

{ TdxPreviewHintWindow }

constructor TdxPreviewHintWindow.Create(AOwner: TComponent);
var
  AMetrics: TNonClientMetrics;
begin
  inherited Create(AOwner);
{$IFDEF DELPHI14}
  AMetrics.cbSize := TNonClientMetrics.SizeOf;
{$ELSE}
  AMetrics.cbSize := SizeOf(TNonClientMetrics);
{$ENDIF}
  if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @AMetrics, 0) then
    Canvas.Font.Handle := CreateFontIndirect(AMetrics.lfStatusFont)
  else
    Canvas.Font.Size := 8;
end;

procedure TdxPreviewHintWindow.ActivateHint(
  P: TPoint; const AHint: string; Margin: TdxPreviewPageMargin);
var
  R: TRect;
  AWidth, AHeight: Integer;
begin
  Application.CancelHint;
  Caption := AHint;

  R := Rect(0, 0, Screen.Width, 0);
  Windows.DrawText(Canvas.Handle, PChar(AHint), Length(AHint), R, 
    DT_CALCRECT or DT_LEFT or DT_NOPREFIX);
  Inc(R.Right, 2 * (1 + 2));
  Inc(R.Bottom, 2 * (1 + 2));
  AWidth := R.Right;
  AHeight := R.Bottom;
  if IsWindowVisible(Handle) then
  begin
    if AWidth < Width then AWidth := Width;
    if AHeight < Height then AHeight := Height;
  end
  else
    FirstPos := P;

  if Assigned(Margin) then
  begin
    if Margin.IsForward then
      if Margin.IsVertical then
        OffsetRect(R, -(dxPreviewDragHintOffset + AWidth), dxPreviewDragHintOffset)
      else
        OffsetRect(R, dxPreviewDragHintOffset, -(dxPreviewDragHintOffset + AHeight))
    else
      OffsetRect(R, dxPreviewDragHintOffset, dxPreviewDragHintOffset);
  end
  else {scroll bar hint}
    OffsetRect(R, -(GetSystemMetrics(SM_CXVSCROLL) + AWidth), 0);

  OffsetRect(R, FirstPos.X, FirstPos.Y);

  with R do
  begin
    if Right > Screen.Width then
      OffsetRect(R, Screen.Width - Right, 0);
    if Bottom > Screen.Height then
      OffsetRect(R, 0, Screen.Height - Bottom);
    if Left < 0 then
      OffsetRect(R, -Left, 0);
    if Top < 0 then
      OffsetRect(R, 0, -Top);
  end;

  if IsWindowVisible(Handle) then
  begin
    if (Width <> AWidth) or (Height <> AHeight) then
      ShowWindow(Handle, SW_HIDE)
    else
    begin
      InvalidateRect(Handle, nil, False);
      UpdateWindow(Handle);
    end;
  end;
  
  if not IsWindowVisible(Handle) then
    SetWindowPos(Handle, HWND_TOPMOST, R.Left, R.Top, AWidth, AHeight,
      SWP_SHOWWINDOW or SWP_NOACTIVATE);
end;

procedure TdxPreviewHintWindow.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TdxPreviewHintWindow.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP or WS_DISABLED;
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
    if IsWin32Version(5, 1) then
      WindowClass.Style := WindowClass.Style or CS_DROPSHADOW;   
    ExStyle := WS_EX_TOOLWINDOW;
  end;
end;

procedure TdxPreviewHintWindow.Paint;
var
  R: TRect;
begin
  R := ClientRect;
  DrawBorder(Canvas.Handle, R);
  InflateRect(R, -1, -1);
  DrawText(Canvas.Handle, R);
end;

procedure TdxPreviewHintWindow.DrawBorder(DC: HDC; R: TRect);
begin
 {$IFDEF DELPHI7} 
  with ThemeServices do
    if ThemesEnabled then
    begin
      DrawEdge(DC, GetElementDetails(twWindowRoot), R, BDR_RAISEDOUTER, BF_RECT);
      Exit;
    end;  
 {$ENDIF}
  DrawEdge(DC, R, BDR_RAISEDOUTER, BF_RECT);
end;

procedure TdxPreviewHintWindow.DrawText(DC: HDC; const R: TRect);
begin
  SetTextColor(DC, GetSysColor(COLOR_INFOTEXT));
  SetBkColor(DC, GetSysColor(COLOR_INFOBK));
  ExtTextOut(DC, R.Left + 2, R.Top + 2, ETO_OPAQUE, @R, PChar(Caption), Length(Caption), nil);
end;

{ TdxPreviewPageBackground }

constructor TdxPreviewPageBackground.Create;
begin
  inherited Create;
  FBitmap := TBitmap.Create;
end;

destructor TdxPreviewPageBackground.Destroy;
begin
  FreeAndNil(FBitmap);
  inherited Destroy;
end;

procedure TdxPreviewPageBackground.Paint(ACanvas: TCanvas; const R: TRect);
begin
  if (Mode = bmPicture) and (PictureMode = ppmCenter) and (Preview.ZoomFactor <> 100) then
  begin
    FBitmap.Width := MulDiv(Picture.Width, Preview.ZoomFactor, 100);
    FBitmap.Height := MulDiv(Picture.Height, Preview.ZoomFactor, 100);
    FBitmap.Canvas.StretchDraw(Rect(0, 0, FBitmap.Width, FBitmap.Height), Picture);
    cxBkgndDrawPicture(FBitmap, ACanvas, R, PictureMode, 1, 1);
  end
  else
    inherited Paint(ACanvas, R);
end;

procedure TdxPreviewPageBackground.DoApply;
begin
  inherited DoApply;
  if HasPreview and not Preview.IsUpdateLocked then 
  begin
    Preview.InvalidatePages;    
    Preview.DesignerModified;
  end;  
end;

procedure TdxPreviewPageBackground.DoChange(AChangeWhats: TdxBackgroundParams);
begin
  inherited DoChange(AChangeWhats); 
  if (UpdateCount = 0) and IsRepaintNeeded and HasPreview and not Preview.IsUpdateLocked then
    FPreview.InvalidatePages;
end;

function TdxPreviewPageBackground.HasPreview: Boolean;
begin
  Result := Preview <> nil;
end;

{ TdxPreviewPage }

constructor TdxPreviewPage.Create(APreview: TCustomdxPreview);
begin
  inherited Create;
  Assert(APreview <> nil);
  FPreview := APreview;
end;

function TdxPreviewPage.GetCursor: TCursor;
begin
  if Zoomed then
    Result := crdxPreviewZoomOut
  else
    Result := crdxPreviewZoomIn;
end;

function TdxPreviewPage.HasPoint(const Pt: TPoint): Boolean;
var
  R: TRect;
begin
  Result := IntersectRect(R, SiteBounds, Preview.ClientRect) and PtInRect(R, Pt);
end;

function TdxPreviewPage.HasPoint(X, Y: Integer): Boolean; 
begin
  Result := HasPoint(Point(X, Y));
end;

procedure TdxPreviewPage.MakeVisible;
begin
  Preview.MakeVisible(Index);
end;

function TdxPreviewPage.GetIndex: Integer;
begin
  Result := Preview.IndexOfPage(Self);
end;

function TdxPreviewPage.GetPartVisible: Boolean;
var
  R: TRect;
begin
  Result := IntersectRect(R, Bounds, Preview.ClientRect);
end;

function TdxPreviewPage.GetSelected: Boolean;
begin
  Result := Preview.SelPageIndex = Index;
end;

function TdxPreviewPage.GetSiteBounds: TRect;
begin
  Result := cxRectInflate(Bounds, Preview.PageBorders);
end;

function TdxPreviewPage.GetVisible: Boolean;
var
  R: TRect;
begin
  Result := IntersectRect(R, Bounds, Preview.ClientRect) and EqualRect(R, Bounds);
end;

function TdxPreviewPage.GetZoomed: Boolean;
begin
  Result := Selected and Preview.Zoomed;
end;

procedure TdxPreviewPage.SetBounds(const Value: TRect);
begin
  FBounds := Value;
end;

procedure TdxPreviewPage.SetSelected(Value: Boolean);
begin
  Preview.SelPageIndex := Index;
end;

{ TdxPreviewPageMargin }

constructor TdxPreviewPageMargin.Create(AMargins: TdxPreviewPageMargins);
begin
  inherited Create;
  FMargins := AMargins;
  FDraggingPos := NullDraggingPos;
  FEnabled := True;
  FMaxValue := -1;
  FVisible := True;
end;

procedure TdxPreviewPageMargin.Assign(Source: TPersistent);
begin
  if Source is TdxPreviewPageMargin then
  begin
    BeginUpdate;
    try
      DoAssign(TdxPreviewPageMargin(Source));
    finally
      EndUpdate;
    end;
  end    
  else
    inherited Assign(Source);
end;

procedure TdxPreviewPageMargin.RestoreDefaults;
begin
  BeginUpdate;
  try
    DoRestoreDefaults;
  finally
    EndUpdate;
  end;
end;

procedure TdxPreviewPageMargin.BeginUpdate;
begin
  if Margins <> nil then
    Margins.BeginUpdate;
end;

procedure TdxPreviewPageMargin.EndUpdate;
begin
  if Margins <> nil then
    Margins.EndUpdate;
end;

function TdxPreviewPageMargin.DefaultCaption: string;
begin
  Result := '';
end;

function TdxPreviewPageMargin.DefaultValue: Integer;
begin
  Result := 0;
end;

function TdxPreviewPageMargin.GetHitTest: TdxPreviewHitTest;
begin
  Result := phtPage;
end;

function TdxPreviewPageMargin.GetCursor: TCursor;
begin
  Result := crDefault;
end;

function TdxPreviewPageMargin.HasPoint(const Pt: TPoint): Boolean;
begin
  Result := Visible and Enabled and PtInRect(SelectableBounds, Pt);
end;

function TdxPreviewPageMargin.HasPoint(const Pt: TSmallPoint): Boolean;
begin
  Result := HasPoint(SmallPointToPoint(Pt));
end;

function TdxPreviewPageMargin.HasPoint(X, Y: Integer): Boolean;
begin
  Result := HasPoint(Point(X, Y));
end;

procedure TdxPreviewPageMargin.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('IsCaptionAssigned', ReadIsCaptionAssigned, WriteIsCaptionAssigned, 
    FIsCaptionAssigned and (FCaption = ''));
end;

function TdxPreviewPageMargin.GetIsForceRecalculatePageCount: Boolean;
begin
  Result := False;
end;

function TdxPreviewPageMargin.GetIsForward: Boolean;
begin
  Result := False;
end;

function TdxPreviewPageMargin.GetIsVertical: Boolean;
begin
  Result := False;
end;

function TdxPreviewPageMargin.DoGetActualMaxValue: Integer;
begin
  Result := MaxValue;
end;

function TdxPreviewPageMargin.DoGetActualMinValue: Integer;
begin
  Result := MinValue;
end;

function TdxPreviewPageMargin.DoGetMaxMinValue: Integer;
begin
  Result := 0;
end;

function TdxPreviewPageMargin.DoPosFromValue(AValue: Integer): Integer;
begin
  Result := AValue;
end;

function TdxPreviewPageMargin.DoValueFromPos(APos: Integer): Integer;
begin
  Result := APos;
end;

procedure TdxPreviewPageMargin.Changed(HardRefresh: Boolean);
begin
  if Assigned(Margins) then
  begin
    if HardRefresh then
      Margins.Update(nil)
    else
      Margins.Update(Self)
  end;
end;

procedure TdxPreviewPageMargin.DoAssign(Source: TdxPreviewPageMargin);
begin
  Enabled := Source.Enabled;
  MaxValue := Source.MaxValue;
  MinValue := Source.MinValue;
  Value := Source.Value;
  Visible := Source.Visible;
end;

procedure TdxPreviewPageMargin.DoDragAfter;
begin
  if Preview <> nil then
  begin
    Preview.DestroyHint;
    DeleteObject(FScreenBitmap);
    Invert(Preview.Canvas.Handle);
    Preview.DoAfterDragMargin(Self);
  end;  
end;

procedure TdxPreviewPageMargin.DoDragBefore;
var
  DC: HDC;
begin
  if Preview <> nil then
  begin
    Preview.DoBeforeDragMargin(Self);

    DC := GetDC(Preview.Handle);
    try
      Invert(DC);
      with PageBounds do
        if IsVertical then
          FScreenBitmap := CreateCompatibleBitmap(DC, 1, Bottom - Top)
        else
          FScreenBitmap := CreateCompatibleBitmap(DC, Right - Left, 1);
    finally
      ReleaseDC(Preview.Handle, DC);
    end;  
  
    with Preview do
      if pohShowOnDrag in OptionsHint then
        CreateHint
      else
        DestroyHint;
  end;      
end;

procedure TdxPreviewPageMargin.DoRestoreDefaults;
begin
  Enabled := True;
  MaxValue := -1;
  MinValue := 0;
  Value := DefaultValue;
  Visible := True;
  FIsCaptionAssigned := False;
end;

procedure TdxPreviewPageMargin.Draw(DC: HDC);
var
  R: TRect;
  Pen: HPEN;
begin
  if Preview <> nil then
  begin
    R := Bounds;
    Pen := SelectObject(DC, Preview.FMarginPen);
    SetBkMode(DC, Windows.TRANSPARENT);
    try
      if IsVertical then
      begin
        MoveToEx(DC, R.Left, R.Top, nil);
        LineTo(DC, R.Left, R.Bottom);
      end
      else
      begin
        MoveToEx(DC, R.Left, R.Top, nil);
        LineTo(DC, R.Right, R.Top);
      end;
    finally
      SetBkMode(DC, Windows.OPAQUE);
      SelectObject(DC, Pen);
    end;
  end;  
end;

procedure TdxPreviewPageMargin.Invalidate;
var
  R: TRect;
begin
  if (Preview <> nil) and Preview.HandleAllocated then
  begin
    R := Bounds;
    if IsVertical then
      Inc(R.Right)
    else
      Inc(R.Bottom);

    InvalidateRect(Preview.Handle, @R, False);
  end;
end;

procedure TdxPreviewPageMargin.Invert(DC: HDC);
begin
  with Bounds do
    BitBlt(DC, Left, Top, Right - Left + Ord(IsVertical),
      Bottom - Top + Ord(not IsVertical), 0, 0, 0, DSTINVERT);
end;

function TdxPreviewPageMargin.CheckValue(Value: Integer): Integer;
begin
  Result := MinMax(Value, ActualMinValue, ActualMaxValue);
end;

function TdxPreviewPageMargin.PosFromValue(AValue: Integer): Integer;
begin
  Result := LoMetricToPixels(AValue);
  if Preview <> nil then
    Result := MulDiv(Result, Preview.ZoomFactor, 100);
  Result := DoPosFromValue(Result);  
end;

function TdxPreviewPageMargin.ValueFromPos(APos: Integer): Integer;
begin
  if APos = MinPos then
  begin
    if IsForward then
      Result := ActualMinValue
    else
      Result := ActualMaxValue;
  end
  else
    if APos = MaxPos then
    begin
      if IsForward then
        Result := ActualMaxValue
      else
        Result := ActualMinValue;
    end
    else 
      if APos = PosFromValue(FValue) then
        Result := FValue
      else
      begin
        Result := DoValueFromPos(APos);
        if Preview <> nil then
          Result := PixelsToLoMetric(MulDiv(Result, 100, Preview.ZoomFactor));
        CheckValue(Result);
      end;
end;

function TdxPreviewPageMargin.GetActualMaxValue: Integer;
begin
  if (Preview <> nil) and Preview.CanChangeMargins then
  begin
    Result := DoGetActualMaxValue;
    if (FMaxValue <> -1) and (Result > FMaxValue) then 
      Result := FMaxValue;
  end
  else
    Result := FMaxValue;
end;

function TdxPreviewPageMargin.GetActualMinValue: Integer;
begin
  if (Preview <> nil) and Preview.CanChangeMargins then
    Result := Max(MinValue, DoGetActualMinValue)
  else
    Result := MinValue;
end;

function TdxPreviewPageMargin.GetActualValue: Integer;
begin
  Result := LoMetricToPixels(Value);
  if Assigned(Preview) then
    Result := MulDiv(Result, Preview.ZoomFactor, 100);
end;

function TdxPreviewPageMargin.GetBounds: TRect;
var
  AValue: Integer;
begin
  if IsDragging and IsDraggingPosAssigned then
    AValue := DraggingPos
  else
    AValue := PosFromValue(Value);

  Result := PageBounds;
  if IsVertical then
    Result := Rect(AValue, PageBounds.Top, AValue, PageBounds.Bottom)
  else
    Result := Rect(PageBounds.Left, AValue, PageBounds.Right, AValue);
end;

function TdxPreviewPageMargin.GetCaption: string;
begin
  if FIsCaptionAssigned then
    Result := FCaption
  else
    Result := DefaultCaption;
end;

function TdxPreviewPageMargin.GetDisplayText: string;
begin
  Result := Caption;
  if Preview <> nil then
  begin
    Result := Result + ': ';
    if IsDragging then
      Result := Result + Preview.MarginValueToString(DraggingValue)
    else
      Result := Result + Preview.MarginValueToString(Value);
  end;    
end;

function TdxPreviewPageMargin.GetDraggingValue: Integer;
begin
  if IsDraggingPosAssigned then
    Result := ValueFromPos(FDraggingPos)
  else
    Result := -1;
end;

function TdxPreviewPageMargin.GetIsDragging: Boolean;
begin
  Result := (Preview <> nil) and (Preview.DraggingMargin = Self);
end;

function TdxPreviewPageMargin.GetIsDraggingPosAssigned: Boolean;
begin
  Result := FDraggingPos <> NullDraggingPos;
end;

function TdxPreviewPageMargin.GetMaxPos: Integer;
begin
  if IsForward then
    Result := PosFromValue(ActualMaxValue)
  else
    Result := PosFromValue(ActualMinValue);
end;

function TdxPreviewPageMargin.GetMinPos: Integer;
begin
  if IsForward then
    Result := PosFromValue(ActualMinValue)
  else
    Result := PosFromValue(ActualMaxValue);
end;

function TdxPreviewPageMargin.GetPageBounds: TRect;
begin
  if Preview = nil then
    Result := cxNullRect
  else
    with Preview do
      if SelPageIndex > -1 then
        Result := Pages[SelPageIndex].Bounds
      else
      begin
        if PageCount > 0 then
          Result := Pages[0].Bounds
        else
          Result := cxNullRect
      end;
end;

function TdxPreviewPageMargin.GetPreview: TCustomdxPreview;
begin
  if Margins = nil then
    Result := nil
  else
    Result := Margins.Preview;
end;

function TdxPreviewPageMargin.GetSelectableBounds: TRect;
begin
  Result := Bounds;
  if IsVertical then
    InflateRect(Result, dxPreviewMarginSelectDelta, 0)
  else
    InflateRect(Result, 0, dxPreviewMarginSelectDelta);
end;

function TdxPreviewPageMargin.GetVisibleValue: Integer;
begin
  Result := LoMetricToPixels(Value);
  if Preview <> nil then
    Result := MulDiv(Result, Preview.ZoomFactor, 100);
end;

function TdxPreviewPageMargin.IsCaptionStored: Boolean;
begin
  Result := FIsCaptionAssigned and (FCaption <> DefaultCaption);
end;

function TdxPreviewPageMargin.IsValueStored: Boolean;
begin
  Result := Value <> DefaultValue;
end;

procedure TdxPreviewPageMargin.SetCaption(const Value: string);
begin
  if Caption <> Value then
  begin
    FCaption := Value;
    FIsCaptionAssigned := True;
  end;
end;

procedure TdxPreviewPageMargin.SetDraggingPos(Value: Integer);

  procedure SaveScreenImage(DC, BitmapDC: HDC);
  begin
    if IsDraggingPosAssigned then
    begin
      with PageBounds do
        if IsVertical then
          BitBlt(BitmapDC, 0, 0, 1, Bottom - Top, DC, FDraggingPos, Top, SRCCOPY)
        else
          BitBlt(BitmapDC, 0, 0, Right - Left, 1, DC, Left, FDraggingPos, SRCCOPY);
    end;
  end;

  procedure RestoreScreenImage(DC, BitmapDC: HDC);
  begin
    if IsDraggingPosAssigned then
    begin
      with PageBounds do
        if IsVertical then
          BitBlt(DC, FDraggingPos, Top, 1, Bottom - Top, BitmapDC, 0, 0, SRCCOPY)
        else
          BitBlt(DC, Left, FDraggingPos, Right - Left, 1, BitmapDC, 0, 0, SRCCOPY);
    end;
  end;

var
  DC, BitmapDC: HDC;
begin
  if Preview <> nil then
  begin
    if Value <> NullDraggingPos then
      Value := MinMax(Value, MinPos, MaxPos);
  
    if FDraggingPos <> Value then
    begin
      DC := GetDC(Preview.Handle);
      try
        BitmapDC := CreateCompatibleDC(DC);
        try
          FScreenBitmap := SelectObject(BitmapDC, FScreenBitmap);
          RestoreScreenImage(DC, BitmapDC);
          FDraggingPos := Value;
          SaveScreenImage(DC, BitmapDC);
          if IsDraggingPosAssigned then
          begin
            Preview.ActivateHint(Self);
            Draw(DC);
          end;
          FScreenBitmap := SelectObject(BitmapDC, FScreenBitmap);
        finally
          DeleteDC(BitmapDC);
        end;  
      finally
        ReleaseDC(Preview.Handle, DC);
      end;  
    
      if IsDraggingPosAssigned then 
        Preview.DoDragMargin(Self);
    end;
  end;  
end;

procedure TdxPreviewPageMargin.SetMaxValue(AValue: Integer);
begin
  AValue := Max(-1, AValue);
  if FMaxValue <> AValue then
  begin
    FMaxValue := AValue;
    if MaxValue <> -1 then
    begin
      Value := Min(Value, MaxValue);
      MinValue := Min(MinValue, MaxValue);
    end;
  end;
end;

procedure TdxPreviewPageMargin.SetMinValue(AValue: Integer);
begin
  AValue := Max(AValue, 0);
  if FMinValue <> AValue then
  begin
    if (Preview <> nil) and Preview.CanChangeMargins then
      AValue := Min(DoGetMaxMinValue, AValue);

    FMinValue := AValue;
    if (MaxValue <> -1) and (MinValue > MaxValue) then
      MaxValue := MinValue;
    Value := Max(MinValue, Value);
  end;
end;

procedure TdxPreviewPageMargin.SetValue(AValue: Integer);
begin
  AValue := CheckValue(AValue);
  if FValue <> AValue then
  begin
    FValue := AValue;
    if (Preview <> nil) and Preview.CanChangeMargins then
    begin
      Preview.DoMarginChanged(Self);
      Changed(True);
    end;
  end;
end;

procedure TdxPreviewPageMargin.SetEnabled(Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    Changed(False);
  end;
end;

procedure TdxPreviewPageMargin.SetVisible(Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed(False);
  end;
end;

procedure TdxPreviewPageMargin.ReadIsCaptionAssigned(AReader: TReader);
begin
  FIsCaptionAssigned := AReader.ReadBoolean;
end;

procedure TdxPreviewPageMargin.WriteIsCaptionAssigned(AWriter: TWriter);
begin
  AWriter.WriteBoolean(FIsCaptionAssigned);
end;

{ TdxPreviewPageMarginBottom }

function TdxPreviewPageMarginBottom.DefaultCaption: string;
begin
  Result := cxGetResourceString(@sdxBottomMargin);
end;

function TdxPreviewPageMarginBottom.DefaultValue: Integer;
begin
  Result := 254;
end;

function TdxPreviewPageMarginBottom.GetHitTest: TdxPreviewHitTest;
begin
  Result := phtMarginBottom;
end;

function TdxPreviewPageMarginBottom.GetCursor: TCursor;
begin
  Result := crdxPreviewVertResize;
end;

function TdxPreviewPageMarginBottom.GetIsForceRecalculatePageCount: Boolean;
begin
  Result := True;
end;

function TdxPreviewPageMarginBottom.GetIsForward: Boolean;
begin
  Result := False;
end;

function TdxPreviewPageMarginBottom.GetIsVertical: Boolean;
begin
  Result := False;
end;

function TdxPreviewPageMarginBottom.DoGetActualMaxValue: Integer;
begin
  Result := Preview.ActualOriginalPageSize.Y - (Preview.MinUsefulSize.Y +
    MaxIntValue([Margins.Top.Value, Margins.Top.MinValue, Margins.Header.MinValue + Preview.MinHeaderSize]));
end;

function TdxPreviewPageMarginBottom.DoGetActualMinValue: Integer; 
begin
  Result := Min(Margins.Footer.Value + Preview.MinFooterSize, ActualMaxValue);
end;

function TdxPreviewPageMarginBottom.DoGetMaxMinValue: Integer;
begin
  Result := Preview.ActualOriginalPageSize.Y - (Margins.Top.Value + Preview.MinUsefulSize.Y);
end;

function TdxPreviewPageMarginBottom.DoPosFromValue(AValue: Integer): Integer;
begin
  Result := PageBounds.Bottom - 1 - AValue;
end;

function TdxPreviewPageMarginBottom.DoValueFromPos(APos: Integer): Integer;
begin
  Result := PageBounds.Bottom - 1 - APos;
end;
  
{ TdxPreviewPageMarginFooter }

function TdxPreviewPageMarginFooter.DefaultCaption: string;
begin
  Result := cxGetResourceString(@sdxFooterMargin);
end;

function TdxPreviewPageMarginFooter.DefaultValue: Integer;
begin
  Result := 127;
end;

function TdxPreviewPageMarginFooter.GetHitTest: TdxPreviewHitTest;
begin
  Result := phtMarginFooter;
end;

function TdxPreviewPageMarginFooter.GetCursor: TCursor;
begin
  Result := crdxPreviewVertResize;
end;
            
function TdxPreviewPageMarginFooter.GetIsForward: Boolean;
begin
  Result := False;
end;

function TdxPreviewPageMarginFooter.GetIsVertical: Boolean;
begin
  Result := False;
end;

function TdxPreviewPageMarginFooter.DoGetActualMaxValue: Integer;
begin
  Result := Preview.ActualOriginalPageSize.Y - (Margins.Top.Value + Preview.MinUsefulSize.Y + Preview.MinFooterSize);
end;

function TdxPreviewPageMarginFooter.DoGetMaxMinValue: Integer;
begin
  Result := Preview.ActualOriginalPageSize.Y - (Margins.Top.Value + Preview.MinUsefulSize.Y + Preview.MinFooterSize);
end;

function TdxPreviewPageMarginFooter.DoPosFromValue(AValue: Integer): Integer;
begin
  Result := PageBounds.Bottom - 1 - AValue;
end;

function TdxPreviewPageMarginFooter.DoValueFromPos(APos: Integer): Integer;
begin
  Result := PageBounds.Bottom - 1 - APos;
end;

{ TdxPreviewPageMarginHeader }

function TdxPreviewPageMarginHeader.DefaultCaption: string;
begin
  Result := cxGetResourceString(@sdxHeaderMargin);
end;

function TdxPreviewPageMarginHeader.DefaultValue: Integer;
begin
  Result := 127;
end;

function TdxPreviewPageMarginHeader.GetHitTest: TdxPreviewHitTest;
begin
  Result := phtMarginHeader;
end;

function TdxPreviewPageMarginHeader.GetCursor: TCursor;
begin
  Result := crdxPreviewVertResize;
end;

function TdxPreviewPageMarginHeader.GetIsForward: Boolean;
begin
  Result := True;
end;

function TdxPreviewPageMarginHeader.GetIsVertical: Boolean;
begin
  Result := False;
end;

function TdxPreviewPageMarginHeader.DoGetActualMaxValue: Integer;
begin
  Result := Preview.ActualOriginalPageSize.Y - (Preview.MinHeaderSize + Preview.MinUsefulSize.Y + Margins.Bottom.Value);
end;

function TdxPreviewPageMarginHeader.DoGetMaxMinValue: Integer;
begin
  Result := Preview.ActualOriginalPageSize.Y - (Margins.Bottom.Value + Preview.MinUsefulSize.Y + Preview.MinHeaderSize);
end;

function TdxPreviewPageMarginHeader.DoPosFromValue(AValue: Integer): Integer;
begin
  Result := PageBounds.Top + AValue;
end;

function TdxPreviewPageMarginHeader.DoValueFromPos(APos: Integer): Integer;
begin
  Result := APos - PageBounds.Top;
end;

{ TdxPreviewPageMarginLeft }

function TdxPreviewPageMarginLeft.DefaultCaption: string;
begin
  Result := cxGetResourceString(@sdxLeftMargin);
end;

function TdxPreviewPageMarginLeft.DefaultValue: Integer;
begin
  Result := 254;
end;

function TdxPreviewPageMarginLeft.GetHitTest: TdxPreviewHitTest;
begin
  Result := phtMarginLeft;
end;

function TdxPreviewPageMarginLeft.GetCursor: TCursor;
begin
  Result := crdxPreviewHorzResize;
end;

function TdxPreviewPageMarginLeft.GetIsForceRecalculatePageCount: Boolean;
begin
  Result := True;
end;

function TdxPreviewPageMarginLeft.GetIsForward: Boolean;
begin
  Result := True;
end;

function TdxPreviewPageMarginLeft.GetIsVertical: Boolean;
begin
  Result := True;
end;

function TdxPreviewPageMarginLeft.DoGetActualMaxValue: Integer;
begin
  Result := Max(ActualMinValue, Preview.ActualOriginalPageSize.X - (Preview.MinUsefulSize.X + Margins.Right.Value));
end;

function TdxPreviewPageMarginLeft.DoGetMaxMinValue: Integer;
begin
  Result := Preview.ActualOriginalPageSize.X - (Margins.Right.Value + Preview.MinUsefulSize.X);
end;

function TdxPreviewPageMarginLeft.DoPosFromValue(AValue: Integer): Integer;
begin
  Result := PageBounds.Left + AValue;
end;

function TdxPreviewPageMarginLeft.DoValueFromPos(APos: Integer): Integer;
begin
  Result := APos - PageBounds.Left;
end;

{ TdxPreviewPageMarginRight }

function TdxPreviewPageMarginRight.DefaultCaption: string;
begin
  Result := cxGetResourceString(@sdxRightMargin);
end;

function TdxPreviewPageMarginRight.DefaultValue: Integer;
begin
  Result := 254;
end;

function TdxPreviewPageMarginRight.GetHitTest: TdxPreviewHitTest;
begin
  Result := phtMarginRight;
end;

function TdxPreviewPageMarginRight.GetCursor: TCursor;
begin
  Result := crdxPreviewHorzResize;
end;

function TdxPreviewPageMarginRight.GetIsForceRecalculatePageCount: Boolean;
begin
  Result := True;
end;

function TdxPreviewPageMarginRight.GetIsForward: Boolean;
begin
  Result := False;
end;

function TdxPreviewPageMarginRight.GetIsVertical: Boolean;
begin
  Result := True; 
end;

function TdxPreviewPageMarginRight.DoGetActualMaxValue: Integer;
begin
  Result := Max(ActualMinValue, Preview.ActualOriginalPageSize.X - (Margins.Left.Value + Preview.MinUsefulSize.X));
end;

function TdxPreviewPageMarginRight.DoGetMaxMinValue: Integer;
begin
  Result := Preview.ActualOriginalPageSize.X - (Margins.Left.Value + Preview.MinUsefulSize.X);
end;

function TdxPreviewPageMarginRight.DoPosFromValue(AValue: Integer): Integer;
begin
  Result := PageBounds.Right - 1 - AValue;
end;
  
function TdxPreviewPageMarginRight.DoValueFromPos(APos: Integer): Integer;
begin
  Result := PageBounds.Right - 1 - APos;
end;

{ TdxPreviewPageMarginTop }

function TdxPreviewPageMarginTop.DefaultCaption: string;
begin
  Result := cxGetResourceString(@sdxTopMargin);
end;

function TdxPreviewPageMarginTop.DefaultValue: Integer;
begin
  Result := 254;
end;

function TdxPreviewPageMarginTop.GetHitTest: TdxPreviewHitTest;
begin
  Result := phtMarginLeft;
end;

function TdxPreviewPageMarginTop.GetCursor: TCursor;
begin
  Result := crdxPreviewVertResize;
end;

function TdxPreviewPageMarginTop.GetIsForceRecalculatePageCount: Boolean;
begin
  Result := True;
end;

function TdxPreviewPageMarginTop.GetIsForward: Boolean;
begin
  Result := True;
end;

function TdxPreviewPageMarginTop.GetIsVertical: Boolean;
begin
  Result := False;
end;

function TdxPreviewPageMarginTop.DoGetActualMaxValue: Integer;
begin
  Result := Preview.ActualOriginalPageSize.Y - (Preview.MinUsefulSize.Y + 
    MaxIntValue([Margins.Bottom.Value, Margins.Bottom.MinValue,
    Preview.MinFooterSize + Margins.Footer.MinValue]));
end;

function TdxPreviewPageMarginTop.DoGetActualMinValue: Integer; 
begin
  Result := Min(Margins.Header.Value + Preview.MinHeaderSize, ActualMaxValue);
end;

function TdxPreviewPageMarginTop.DoGetMaxMinValue: Integer;
begin
  Result := Preview.ActualOriginalPageSize.Y - (Margins.Bottom.Value + Preview.MinUsefulSize.Y);
end;

function TdxPreviewPageMarginTop.DoPosFromValue(AValue: Integer): Integer;
begin
  Result := PageBounds.Top + AValue;
end;

function TdxPreviewPageMarginTop.DoValueFromPos(APos: Integer): Integer;
begin
  Result := APos - PageBounds.Top;
end;

{ TdxPreviewPageMargins }

constructor TdxPreviewPageMargins.Create(APreview: TCustomdxPreview);
begin
  inherited Create;
  FPreview := APreview;
  FMargins := TList.Create;
  AddMargins;
end;

destructor TdxPreviewPageMargins.Destroy;
begin
  FreeAndNilMargins;
  inherited Destroy;
end;

procedure TdxPreviewPageMargins.Assign(Source: TPersistent);
begin
  if Source is TdxPreviewPageMargins then
  begin
    BeginUpdate;
    try
      DoAssign(TdxPreviewPageMargins(Source));
    finally
      EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxPreviewPageMargins.RestoreDefaults; 
begin
  BeginUpdate;
  try
    DoRestoreDefaults;
  finally
    EndUpdate;
  end;
end;

procedure TdxPreviewPageMargins.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TdxPreviewPageMargins.EndUpdate;
begin
  Dec(FUpdateCount);
  if FUpdateCount = 0 then
    Update(nil);
end;

procedure TdxPreviewPageMargins.DoAssign(Source: TdxPreviewPageMargins);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Margins[I].Assign(Source[I]);
end;

procedure TdxPreviewPageMargins.DoRestoreDefaults;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Margins[I].RestoreDefaults;
end;

function TdxPreviewPageMargins.AddMargin(AClass: TdxPreviewPageMarginClass): TdxPreviewPageMargin;
begin
  Result := AClass.Create(Self);
  FMargins.Add(Result);
end;

procedure TdxPreviewPageMargins.AddMargins;
begin
  AddMargin(TdxPreviewPageMarginLeft);
  AddMargin(TdxPreviewPageMarginTop);
  AddMargin(TdxPreviewPageMarginRight);
  AddMargin(TdxPreviewPageMarginBottom);
  AddMargin(TdxPreviewPageMarginHeader);
  AddMargin(TdxPreviewPageMarginFooter);
end;

procedure TdxPreviewPageMargins.FreeAndNilMargins;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Margins[I].Free;
  FreeAndNil(FMargins);
end;

procedure TdxPreviewPageMargins.Update(AMargin: TdxPreviewPageMargin);
begin
  if Assigned(Preview) and not Preview.IsUpdateLocked then
    Preview.FullRefresh;
end;

function TdxPreviewPageMargins.GetCount: Integer;
begin
  Result := FMargins.Count;
end;

function TdxPreviewPageMargins.GetMargin(Index: Integer): TdxPreviewPageMargin;
begin
  Result := TdxPreviewPageMargin(FMargins[Index]);
end;
                                  
function TdxPreviewPageMargins.GetMarginByCaption(const Caption: string): TdxPreviewPageMargin;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := Margins[I];
    if dxSameText(Result.Caption, Caption) then
      Exit;
  end;
  Result := nil;  
end;
                           
function TdxPreviewPageMargins.GetMarginByClass(Index: TdxPreviewPageMarginClass): TdxPreviewPageMargin;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := Margins[I];
    if Result.ClassType = Index then
      Exit;
  end;  
  Result := nil;
end;

function TdxPreviewPageMargins.GetMarginBottom: TdxPreviewPageMarginBottom;
begin
  Result := MarginsByClass[TdxPreviewPageMarginBottom] as TdxPreviewPageMarginBottom;
end;

function TdxPreviewPageMargins.GetMarginFooter: TdxPreviewPageMarginFooter;
begin
  Result := MarginsByClass[TdxPreviewPageMarginFooter] as TdxPreviewPageMarginFooter;
end;

function TdxPreviewPageMargins.GetMarginHeader: TdxPreviewPageMarginHeader;
begin
  Result := MarginsByClass[TdxPreviewPageMarginHeader] as TdxPreviewPageMarginHeader;
end;

function TdxPreviewPageMargins.GetMarginLeft: TdxPreviewPageMarginLeft;
begin
  Result := MarginsByClass[TdxPreviewPageMarginLeft] as TdxPreviewPageMarginLeft;
end;

function TdxPreviewPageMargins.GetMarginRight: TdxPreviewPageMarginRight;
begin
  Result := MarginsByClass[TdxPreviewPageMarginRight] as TdxPreviewPageMarginRight;
end;

function TdxPreviewPageMargins.GetMarginTop: TdxPreviewPageMarginTop;
begin
  Result := MarginsByClass[TdxPreviewPageMarginTop] as TdxPreviewPageMarginTop;
end;

procedure TdxPreviewPageMargins.SetMargin(Index: Integer; Value: TdxPreviewPageMargin);
begin
  Margins[Index].Assign(Value);
end;

procedure TdxPreviewPageMargins.SetMarginByClass(Index: TdxPreviewPageMarginClass; 
  Value: TdxPreviewPageMargin);
var
  Margin: TdxPreviewPageMargin;
begin
  Margin := MarginsByClass[Index];
  if Margin <> nil then
    Margin.Assign(Value);
end;

procedure TdxPreviewPageMargins.SetMarginBottom(Value: TdxPreviewPageMarginBottom);
begin
  MarginsByClass[TdxPreviewPageMarginBottom] := Value;
end;

procedure TdxPreviewPageMargins.SetMarginFooter(Value: TdxPreviewPageMarginFooter);
begin
  MarginsByClass[TdxPreviewPageMarginFooter] := Value;
end;

procedure TdxPreviewPageMargins.SetMarginHeader(Value: TdxPreviewPageMarginHeader);
begin
  MarginsByClass[TdxPreviewPageMarginHeader] := Value;
end;

procedure TdxPreviewPageMargins.SetMarginLeft(Value: TdxPreviewPageMarginLeft);
begin
  MarginsByClass[TdxPreviewPageMarginLeft] := Value;
end;

procedure TdxPreviewPageMargins.SetMarginRight(Value: TdxPreviewPageMarginRight);
begin
  MarginsByClass[TdxPreviewPageMarginRight] := Value;
end;

procedure TdxPreviewPageMargins.SetMarginTop(Value: TdxPreviewPageMarginTop);
begin
  MarginsByClass[TdxPreviewPageMarginTop] := Value;
end;

{ TCustomdxPreview }

constructor TCustomdxPreview.Create(AOwner: TComponent);

  function CreateTimer(AHandler: TNotifyEvent; AnInterval: Integer): TTimer;
  begin
    Result := TTimer.Create(Self);
    Result.Enabled := True;
    Result.Interval := AnInterval;
    Result.OnTimer := AHandler;
  end;
  
begin
  inherited Create(AOwner);
  FContentCache := TcxBitmap.Create;
  ControlStyle := ControlStyle - [csAcceptsControls, csCaptureMouse];
  ParentColor := False;
  Brush.Color := Color;

  FHintHideLongTimer := CreateTimer(HintHideLongTimerHandler, dxPreviewHideHintLongTime);
  FHintHideShortTimer := CreateTimer(HintHideShortTimerHandler, dxPreviewHideHintShortTime);
  FHintShowTimer := CreateTimer(HintShowTimerHandler, dxPreviewShowHintTime);
  
  FOptionsBehavior := dxPSPreviewDefaultBehaviorOptions;
  FOptionsHint := dxPSPreviewDefaultOptionsHint;
  FOptionsView := dxPSPreviewDefaultOptionsView;
  FOptionsZoom := [pozZoomOnClick];
  FOptionsStore := [posZoom];
  
  FBorderStyle := bsSingle;
  FPageBackground := TdxPreviewPageBackground.Create;
  TdxPreviewPageBackground(FPageBackground).FPreview := Self;
  MarginColor := clWindowText;
  FScrollBars := ssBoth;

  ClearLastMousePos;
  FMargins := CreateMargins;

  FMaxZoomFactor := 500;
  FMinFooterSize := dxPreviewMinHeaderFooterSize;
  FMinHeaderSize := dxPreviewMinHeaderFooterSize;
  FMinUsefulSize := dxPreviewMinUsefulSize;
  FMinZoomFactor := 5;

  FOriginalPageSize := TdxPointWrapper.Create(0, 0);
  FOriginalPageSize.OnChanging := PageParametersChanging;
  FOriginalPageSize.OnChanged := PageParametersChanged;
  FOriginalPageSize.Point := A4_LOMETRIC;

  FPages := TList.Create;
  FPageXCount := 1;
  FPageYCount := 1;
  FSelPageIndex := -1;
  FScrollBars := ssBoth;
  FScrollBarStyle := ssRegular;
  FUnzoomedFactor := 50;
  FTransparent := False;
  ZoomFactor := 100;
  ZoomMode := pzmNone;
  FZoomStep := 10;
  Height := 460;
  Width := 320;

  if IsDesigning then
  begin
    PageCount := 1;
    SelPageIndex := 0;
  end;
  FContentCacheDirty := True;
end;

destructor TCustomdxPreview.Destroy;
begin
  if not IsDesigning and (pobStoreInRegistry in OptionsBehavior) and (RegistryPath <> '') then
    SaveToRegistry(RegistryPath);
  DestroyPageNumberHint;
  DestroyHint;
  FreeMarginPen;
  FreeAndnil(FOriginalPageSize);
  FreeAndnil(FPageBackground);
  PageCount := 0;
  FreeAndNil(FPages);
  FreeAndNil(FMargins);
  FreeAndNil(FContentCache);
  inherited Destroy;
end;

procedure TCustomdxPreview.LoadFromIniFile(
  AIniFile: TCustomIniFile; const ASectionName: string);
begin
  OptionsHint := TdxPreviewOptionsHint(Byte(
    AIniFile.ReadInteger(ASectionName, sdxOptionsHint, Byte(OptionsHint))));
  OptionsView := TdxPreviewOptionsView(Byte(
    AIniFile.ReadInteger(ASectionName, sdxOptionsView, Byte(OptionsView))));
  OptionsZoom := TdxPreviewOptionsZoom(Byte(
    AIniFile.ReadInteger(ASectionName, sdxOptionsZoom, Byte(OptionsZoom))));

  ZoomStep := AIniFile.ReadInteger(ASectionName, sdxZoomStep, ZoomStep);
  MarginColor := AIniFile.ReadInteger(ASectionName, sdxMarginColor, MarginColor);
  MeasurementUnits := TdxPreviewMeasurementUnits(
    AIniFile.ReadInteger(ASectionName, sdxMeasurementUnits, Ord(MeasurementUnits)));
  Orientation := TdxPreviewPaperOrientation(
    AIniFile.ReadInteger(ASectionName, sdxOrientation, Ord(Orientation)));

  if posZoom in OptionsStore then
  begin
    ZoomFactor := AIniFile.ReadInteger(ASectionName, sdxZoomFactor, ZoomFactor);
    ZoomMode := TdxPreviewZoomMode(AIniFile.ReadInteger(ASectionName, sdxZoomMode, Ord(ZoomMode)));
    if ZoomMode = pzmPages then
    begin
      PageXCount := AIniFile.ReadInteger(ASectionName, sdxPageXCount, PageXCount);
      PageYCount := AIniFile.ReadInteger(ASectionName, sdxPageYCount, PageYCount);
    end;
  end;
end;

procedure TCustomdxPreview.LoadFromRegistry(const ARegistryPath: string);
var
  ARegIniFile: TRegistryIniFile;
begin
  ARegIniFile := TRegistryIniFile.Create('');
  try
    LoadFromIniFile(ARegIniFile, ARegistryPath);
  finally
    ARegIniFile.Free;
  end;
end;

procedure TCustomdxPreview.SaveToIniFile(
  AIniFile: TCustomIniFile; const ASectionName: string);
begin
  AIniFile.WriteInteger(ASectionName, sdxMeasurementUnits, Integer(MeasurementUnits));
  AIniFile.WriteInteger(ASectionName, sdxOptionsHint, Integer(Byte(OptionsHint)));
  AIniFile.WriteInteger(ASectionName, sdxOptionsView, Integer(Byte(OptionsView)));
  AIniFile.WriteInteger(ASectionName, sdxOptionsZoom, Integer(Byte(OptionsZoom)));
  AIniFile.WriteInteger(ASectionName, sdxOrientation, Integer(Orientation));
  AIniFile.WriteInteger(ASectionName, sdxMarginColor, Integer(MarginColor));
  AIniFile.WriteInteger(ASectionName, sdxZoomStep, ZoomStep);

  if posZoom in OptionsStore then
  begin
    AIniFile.WriteInteger(ASectionName, sdxZoomFactor, ZoomFactor);
    AIniFile.WriteInteger(ASectionName, sdxZoomMode, Integer(ZoomMode));
    if ZoomMode = pzmPages then
    begin
      AIniFile.WriteInteger(ASectionName, sdxPageXCount, PageXCount);
      AIniFile.WriteInteger(ASectionName, sdxPageYCount, PageYCount);
    end;
  end;
end;

procedure TCustomdxPreview.SaveToRegistry(const ARegistryPath: string);
var
  ARegIniFile: TRegistryIniFile;
begin
  ARegIniFile := TRegistryIniFile.Create('');
  try
    SaveToIniFile(ARegIniFile, ARegistryPath);
  finally
    ARegIniFile.Free;
  end;
end;

function TCustomdxPreview.DefaultNoPagesText: string;
begin
  Result := cxGetResourceString(@sdxNoPages);
end;

procedure TCustomdxPreview.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TCustomdxPreview.CancelUpdate;
begin
  if FUpdateCount <> 0 then
    Dec(FUpdateCount);
end;

procedure TCustomdxPreview.EndUpdate;
begin
  if FUpdateCount <> 0 then
  begin
    Dec(FUpdateCount);
    if not IsUpdateLocked then
    begin
      DoCalcPageCount;
      Invalidate;
    end;
  end;
end;

function TCustomdxPreview.IsUpdateLocked: Boolean;
begin
  Result := (FUpdateCount <> 0) or (csLoading in ComponentState);
end;

procedure TCustomdxPreview.GetPartVisiblePageRanges(AStartIndex, AEndIndex: PInteger);
var
  StartIndex, EndIndex: Integer;
begin
  GetPartVisiblePageRanges(StartIndex, EndIndex);

  if AStartIndex <> nil then 
    AStartIndex^ := StartIndex;

  if AEndIndex <> nil then 
    AEndIndex^ := EndIndex;
end;

procedure TCustomdxPreview.GetPartVisiblePageRanges(out AStartIndex, AEndIndex: Integer);
begin
  if PageCount <> 0 then
  begin
    AStartIndex := 0;
    while (AStartIndex < PageCount) and not Pages[AStartIndex].PartVisible do 
      Inc(AStartIndex);
  
    AEndIndex := AStartIndex;
    while (AEndIndex < PageCount) and Pages[AEndIndex].PartVisible do 
      Inc(AEndIndex);
    Dec(AEndIndex);
  end
  else
  begin
    AStartIndex := -1;
    AEndIndex := -1;
  end;  
end;
 
procedure TCustomdxPreview.GetVisiblePageRanges(AStartIndex, AEndIndex: PInteger );
var
  StartIndex, EndIndex: Integer;
begin
  GetVisiblePageRanges(StartIndex, EndIndex);

  if AStartIndex <> nil then 
    AStartIndex^ := StartIndex;

  if AEndIndex <> nil then 
    AEndIndex^ := EndIndex;
end;

procedure TCustomdxPreview.GetVisiblePageRanges(out AStartIndex, AEndIndex: Integer);
begin
  if PageCount <> 0 then 
  begin
    AStartIndex := 0;
    while (AStartIndex < PageCount) and not Pages[AStartIndex].Visible do
      Inc(AStartIndex);
    
    if AStartIndex = PageCount then 
    begin
      AStartIndex := -1;
      AEndIndex := -1;
    end  
    else 
    begin
      AEndIndex := AStartIndex;
      while (AEndIndex < PageCount) and Pages[AEndIndex].Visible do 
        Inc(AEndIndex);
      Dec(AEndIndex);
    end;
  end
  else
  begin
    AStartIndex := -1;
    AEndIndex := -1;
  end;     
end;

procedure TCustomdxPreview.InvalidatePage(APageIndex: Integer);
var
  R: TRect;
begin
  if (APageIndex > -1) and (APageIndex < PageCount) and HandleAllocated and
    IntersectRect(R, Pages[APageIndex].Bounds, ClientRect)
  then
  begin
    ContentCacheDirty := True;
    InvalidateRect(Pages[APageIndex].Bounds, False);
  end;
end;

procedure TCustomdxPreview.InvalidatePages;
var
  StartIndex, EndIndex, I: Integer;
begin
  if HandleAllocated and (PageCount <> 0) then
  begin
    GetPartVisiblePageRanges(StartIndex, EndIndex);
    if StartIndex >= 0 then
    begin
      ContentCacheDirty := True;
      for I := StartIndex to EndIndex do
        InvalidateRect(Pages[I].Bounds, False);
    end;
  end;
end;

procedure TCustomdxPreview.InvalidatePagesContent;
var
  StartIndex, EndIndex, I: Integer;
  R: TRect;
begin
  if not HandleAllocated or (PageCount = 0) then
    Exit;

  GetPartVisiblePageRanges(StartIndex, EndIndex);
  if StartIndex < 0 then
    Exit;
  
  for I := StartIndex to EndIndex do
  begin
    with Pages[I].Bounds do
      R := Rect(
        Left + Margins.Left.VisibleValue,
        Top + Margins.Top.VisibleValue,
        Right - Margins.Right.VisibleValue,
        Bottom - Margins.Bottom.VisibleValue);
    ContentCacheDirty := True;
    InvalidateRect(R, False);
  end;
end;

procedure TCustomdxPreview.InvalidatePagesFooter;
var
  StartIndex, EndIndex, I: Integer;
  R, CR: TRect;
begin
  if not HandleAllocated or (PageCount = 0) then Exit;
  
  ContentCacheDirty := True;
  GetPartVisiblePageRanges(StartIndex, EndIndex);
  if StartIndex < 0 then Exit;
  
  CR := ClientRect;
  for I := StartIndex to EndIndex do
  begin
    with Pages[I].Bounds do
      R := Rect(
        Left + Margins.Left.VisibleValue,
        Bottom - Margins.Bottom.VisibleValue,
        Right - Margins.Right.VisibleValue,
        Bottom - Margins.Footer.VisibleValue);
        
    if IntersectRect(R, R, CR) then
      InvalidateRect(R, False);
  end;
end;

procedure TCustomdxPreview.InvalidatePagesHeader;
var
  StartIndex, EndIndex, I: Integer;
  R, CR: TRect;
begin
  if not HandleAllocated or (PageCount = 0) then Exit;

  ContentCacheDirty := True;
  GetPartVisiblePageRanges(StartIndex, EndIndex);
  if StartIndex < 0 then Exit;
  
  CR := ClientRect;
  for I := StartIndex to EndIndex do
  begin
    with Pages[I].Bounds do
      R := Rect(
        Left + Margins.Left.VisibleValue,
        Top + Margins.Header.VisibleValue,
        Right - Margins.Right.VisibleValue,
        Top + Margins.Top.VisibleValue);
        
    if IntersectRect(R, R, CR) then
      InvalidateRect(R, False);
  end;
end;

procedure TCustomdxPreview.CalcPagesBounds(ATopPos, AWidth, AHeight: Integer);
var
  APageSize: TPoint;
  I, J, PageIndex: Integer;
  LeftOffset, TopOffset: Integer;
  R: TRect;
begin
  APageSize := VisiblePageSize;

  R := ClientRect;
  if (AWidth > cxRectWidth(R)) or (pobNonCenterizePages in OptionsBehavior) then
    LeftOffset := Indent
  else
    LeftOffset := (R.Right - AWidth) div 2 + Indent;
    
  if (AHeight > cxRectHeight(R)) or (pobNonCenterizePages in OptionsBehavior) then
    TopOffset := Indent
  else
    TopOffset := (R.Bottom - AHeight) div 2 + Indent;
    
  if ZoomFactor = MinZoomFactor then
  begin
    TopOffset := Max(Indent, TopOffset);
    LeftOffset := Max(Indent, LeftOffset);
  end;

  for J := 0 to AllRowCount - 1 do
  begin
    for I := 0 to ColCount - 1 do
    begin
      PageIndex := J * ColCount + I;
      if PageIndex > PageCount - 1 then 
        Break;

      R.Left := -LeftPos + LeftOffset + I * (APageSize.X + Indent);
      R.Top  := -ATopPos + TopOffset  + J * (APageSize.Y + Indent);
      Pages[PageIndex].Bounds := cxRectSetSize(R, APageSize.X, APageSize.Y);
    end;
  end;
end;

function TCustomdxPreview.GetHitInfoAt(const Pt: TPoint): TdxPreviewHitTests;
var
  Margin: TdxPreviewPageMargin;
begin
  if PtInRect(ClientRect, Pt) then
  begin
    if PageIndexFromPoint(Pt) < 0 then
      Result := [phtNoWhere]
    else
    begin
      Result := [phtPage];
      Margin := MarginFromPoint(Pt);
      if Margin <> nil then
        Result := Result + [Margin.GetHitTest];
    end;
  end
  else
    Result := [];
end;

function TCustomdxPreview.GetHitInfoAt(const Pt: TSmallPoint): TdxPreviewHitTests;
begin
  Result := GetHitInfoAt(SmallPointToPoint(Pt));
end;

function TCustomdxPreview.GetHitInfoAt(X, Y: Integer): TdxPreviewHitTests;
begin
  Result := GetHitInfoAt(Point(X, Y));
end;

procedure TCustomdxPreview.FullRefresh;
begin
  DoCalcPageCount;
  UpdatePreviewIndents;
  ContentCacheDirty := True;
  Invalidate;
end;

procedure TCustomdxPreview.HideAllHints;
begin
  CancelHintShow;
  CancelHintHide;
end;

procedure TCustomdxPreview.MakeVisible(APageIndex: Integer);

  function GetDeltaX(const R: TRect): Integer;
  begin
    Result := 0;
    if R.Right > ClientWidth then 
      Result := R.Right - ClientWidth;
    if R.Left - Result < 0 then 
      Result := R.Left;
  end;

  function GetDeltaY(const R: TRect): Integer;
  begin
    Result := 0;
    if R.Bottom > ClientHeight then 
      Result := R.Bottom - ClientHeight;
    if R.Top - Result < 0 then 
      Result := R.Top;  
  end;
  
begin
  if HandleAllocated and (APageIndex > -1) and (APageIndex < PageCount) then 
  begin
    CalcPagesBounds(TopPos, VirtualWidth, VirtualHeight);
    LeftPos := LeftPos + GetDeltaX(Pages[APageIndex].SiteBounds);
    TopPos := TopPos + GetDeltaY(Pages[APageIndex].SiteBounds);
    CalcPagesBounds(TopPos, VirtualWidth, VirtualHeight);
  end;  
end;

procedure TCustomdxPreview.SetPageXYCount(XCount, YCount: Integer);
begin
  BeginUpdate;
  try
    PageXCount := XCount;
    PageYCount := YCount;
  finally
    EndUpdate;
  end;
end;

procedure TCustomdxPreview.ZoomIn;
begin
  ZoomFactor := ZoomFactor + ZoomStep;
end;

procedure TCustomdxPreview.ZoomOut;
begin
  ZoomFactor := ZoomFactor - ZoomStep;
end;

function TCustomdxPreview.MarginFromPoint(const Pt: TPoint): TdxPreviewPageMargin;
var
  I: Integer;
begin
  if SelPageIndex <> -1 then
  begin 
    for I := Margins.Count - 1 downto 0 do
    begin
      Result := Margins[I];
      if Result.HasPoint(Pt) then
        Exit;
    end;
  end;
  Result := nil;
end;

function TCustomdxPreview.MarginFromPoint(const Pt: TSmallPoint): TdxPreviewPageMargin;
begin
  Result := MarginFromPoint(SmallPointToPoint(Pt));
end;

function TCustomdxPreview.MarginFromPoint(X, Y: Integer): TdxPreviewPageMargin;
begin
  Result := MarginFromPoint(Point(X, Y));
end;

function TCustomdxPreview.MarginValueToString(Value: Integer): string;
var
  DisplayValue: TFloat;
  Mask: string;
begin
  DisplayValue := LoMetricToAnother(FMeasurementUnits, Value);
  case ActualMeasurementUnits of
    pmuInches:
      Result := cxGetResourceString(@sdxUnitsInches);
    pmuMillimeters:
      Result := cxGetResourceString(@sdxUnitsMillimeters);
    pmuCentimeters:
      Result := cxGetResourceString(@sdxUnitsCentimeters);
    pmuPoints:
      Result := cxGetResourceString(@sdxUnitsPoints);
    pmuPicas:
      Result := cxGetResourceString(@sdxUnitsPicas);
  end;
  Mask := '########0.#';
  if ActualMeasurementUnits in [pmuInches, pmuCentimeters, pmuPicas] then
    Mask := Mask + '#';
  Result := FormatFloat(Mask, DisplayValue) + ' ' + Result;
end;

function TCustomdxPreview.IndexOfPage(APage: TdxPreviewPage): Integer;
begin
  Result := FPages.IndexOf(APage);
end;

function TCustomdxPreview.PageIndexFromPoint(const Pt: TPoint): Integer;
begin
  for Result := 0 to PageCount - 1 do
    if Pages[Result].HasPoint(Pt) then 
      Exit;
      
  Result := -1;
end;

function TCustomdxPreview.PageIndexFromPoint(const Pt: TSmallPoint): Integer;
begin
  Result := PageIndexFromPoint(SmallPointToPoint(Pt));
end;

function TCustomdxPreview.PageIndexFromPoint(X, Y: Integer): Integer;
begin
  Result := PageIndexFromPoint(Point(X, Y));
end;

function TCustomdxPreview.PageSizeToString: string;
var
  PageWidth, PageHeight: Double;
  Mask: string;
begin
  case ActualMeasurementUnits of
    pmuInches:
      Result := cxGetResourceString(@sdxUnitsInches);
    pmuMillimeters:
      Result := cxGetResourceString(@sdxUnitsMillimeters);
    pmuCentimeters:
      Result := cxGetResourceString(@sdxUnitsCentimeters);
    pmuPoints:
      Result := cxGetResourceString(@sdxUnitsPoints);
    pmuPicas:
      Result := cxGetResourceString(@sdxUnitsPicas);
  end;
                                                   
  Mask := '########0.#';
  if ActualMeasurementUnits in [pmuInches, pmuCentimeters, pmuPicas] then
    Mask := Mask + '#';
  PageWidth := LoMetricToAnother(FMeasurementUnits, OriginalPageSize.X);
  PageHeight := LoMetricToAnother(FMeasurementUnits, OriginalPageSize.Y);
    
  Result := FormatFloat(Mask, PageWidth) + ' ' + Result + ' x ' +  
    FormatFloat(Mask, PageHeight) + ' ' + Result;
end;

procedure TCustomdxPreview.SelectFirstPage;
var
  I: Integer;
  OldSelPageIndex: Integer;
begin
  I := 0;
  OldSelPageIndex := SelPageIndex;
  repeat
    SelPageIndex := I;    
    Inc(I);
  until (SelPageIndex + I = PageCount + 1) or (SelPageIndex <> OldSelPageIndex);
end;

procedure TCustomdxPreview.SelectLastPage;
var
  I: Integer;
  OldSelPageIndex: Integer;
begin
  I := 1;
  OldSelPageIndex := SelPageIndex;
  repeat
    SelPageIndex := PageCount - I;    
    Inc(I);
  until (I = -1) or (SelPageIndex <> OldSelPageIndex);
end;

procedure TCustomdxPreview.SelectNextPage;
var
  I: Integer;
  OldSelPageIndex: Integer;
begin
  I := 1;
  OldSelPageIndex := SelPageIndex;
  repeat
    SelPageIndex := SelPageIndex + I;    
    Inc(I);
  until (SelPageIndex + I = PageCount + 1) or (SelPageIndex <> OldSelPageIndex);
end;

procedure TCustomdxPreview.SelectPrevPage;
var
  I: Integer;
  OldSelPageIndex: Integer;
begin
  if SelPageIndex > 0 then 
  begin
    I := 1;
    OldSelPageIndex := SelPageIndex;
    repeat
      SelPageIndex := SelPageIndex - I;    
      Inc(I);
    until (SelPageIndex - I = -2) or (SelPageIndex <> OldSelPageIndex);
  end;  
end;

procedure TCustomdxPreview.AdjustSize;
begin
end;

procedure TCustomdxPreview.CreateParams(var Params: TCreateParams);
const
  CS_ON = CS_OWNDC;
  CS_OFF = CS_HREDRAW or CS_VREDRAW;
begin
  inherited CreateParams(Params);
  with Params do 
  begin
    WindowClass.Style := (WindowClass.Style or CS_ON) and not CS_OFF;
    if (FBorderStyle = bsSingle) and (LookAndFeel.Kind = lfStandard) then
    begin
      if NewStyleControls and Ctl3D then
      begin
        Style := Style and not WS_BORDER;
        ExStyle := ExStyle or WS_EX_CLIENTEDGE;
      end
      else
        Style := Style or WS_BORDER;
    end;
  end;      
end;

procedure TCustomdxPreview.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('IsNoPagesTextAssigned', ReadIsNoPagesTextAssigned,
    WriteIsNoPagesTextAssigned, FIsNoPagesTextAssigned and (FNoPagesText = ''));
end;

procedure TCustomdxPreview.KeyDown(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN:
      if (SelPageIndex > -1) and (DraggingMargin = nil) then
      begin
        HideAllHints;
        Zoomed := not Zoomed;
      end;
      
    VK_ADD:
      if (SelPageIndex > -1) and (DraggingMargin = nil) then
      begin
        HideAllHints;
        if GetKeyState(VK_CONTROL) < 0 then 
          ZoomIn
        else   
          if not Zoomed then 
            Zoomed := True;
      end;
      
    VK_SUBTRACT:
      if (SelPageIndex > -1) and (DraggingMargin = nil) then
      begin
        HideAllHints;
        if GetKeyState(VK_CONTROL) < 0 then 
          ZoomOut
        else  
          if Zoomed then 
            Zoomed := False;
      end;
      
    VK_MENU:
      if DraggingMargin = nil then 
        HideAllHints;
        
    VK_APPS:
      if (PopupMenu <> nil) or IsDesigning then 
        HideAllHints;
        
    VK_ESCAPE:
      if GetCapture = Handle then 
      begin 
        ReleaseCapture;
        Key := 0;
      end;  
      
    VK_PRIOR:
      if not (ssCtrl in Shift) then
        SelectPrevPage
      else  
        if CanPageScrolling(psdUp) then
        begin
          ScrollPage(psdUp);
          ScrollPage(psdUp);
        end;

    VK_NEXT:
      if not (ssCtrl in Shift) then
        SelectNextPage
      else  
        if CanPageScrolling(psdDown) then
        begin
          ScrollPage(psdDown);
          ScrollPage(psdDown);
        end;
        
    VK_END:
      SelectLastPage;
      
    VK_HOME:
      SelectFirstPage;
      
    VK_LEFT:
      if (ssCtrl in Shift) or (ColCount = 1) then
        if CanPageScrolling(psdLeft) then 
          ScrollPage(psdLeft)
        else  
      else 
        if SelPageCol > 0 then 
          SelectPrevPage;
          
    VK_UP:
      if ssAlt in Shift then
        ZoomIn
      else
        if (ssCtrl in Shift) or (ColCount = 1) then
          if CanPageScrolling(psdUp) then 
            ScrollPage(psdUp)
          else
        else 
          if SelPageRow > 0 then 
            SelPageIndex := SelPageIndex - ColCount;
          
    VK_RIGHT:
      if (ssCtrl in Shift) or (ColCount = 1) then
        if CanPageScrolling(psdRight) then 
          ScrollPage(psdRight)
        else  
      else 
        if SelPageCol < ColCount - 1 then 
          SelectNextPage;
          
    VK_DOWN:
      if ssAlt in Shift then
        ZoomOut
      else
        if (ssCtrl in Shift) or (ColCount = 1) then
          if CanPageScrolling(psdDown) then 
            ScrollPage(psdDown)
          else
        else 
          if SelPageRow < Ceil(PageCount / ColCount) - 1 then
            SelPageIndex := SelPageIndex + ColCount;
  end;
  inherited KeyDown(Key, Shift);
end;

procedure TCustomdxPreview.Loaded;
begin
  inherited Loaded;
  DoCalcPageCount;
  if not IsDesigning and (pobStoreInRegistry in OptionsBehavior) and (RegistryPath <> '') then
    LoadFromRegistry(RegistryPath);
end;

procedure TCustomdxPreview.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);

  function CanDragMargin(AMargin: TdxPreviewPageMargin): Boolean;
  begin
    Result := (pobAllowDragMargins in OptionsBehavior) and
      Assigned(AMargin) and AMargin.Enabled and not (ssDouble in Shift);
  end;

  procedure StartMarginDragging(AMargin: TdxPreviewPageMargin);
  var
    R: TRect;
  begin
    AMargin.DoDragBefore;
    R := AMargin.Bounds;
    FDraggingMargin := AMargin;
    if AMargin.IsVertical then
    begin
      FBeforeDragPos := X;
      FDragOffset := X - R.Left;
    end
    else
    begin
      FBeforeDragPos := Y;
      FDragOffset := Y - R.Top;
    end;
    AMargin.DraggingPos := FBeforeDragPos - FDragOffset;
    SetCapture(Handle);
  end;

  procedure StopMarginDragging;
  begin
    if Assigned(DraggingMargin) then
      ReleaseCapture;
  end;

  procedure ProcessClickBySelectedPage;
  var
    AMargin: TdxPreviewPageMargin;
  begin
    AMargin := MarginFromPoint(X, Y);
    if CanDragMargin(AMargin) then
      StartMarginDragging(AMargin);
    if (AMargin = nil) and (pozZoomOnClick in OptionsZoom) then
      Zoomed := not Zoomed;
  end;

var
  APageIndex, AOldPageIndex: Integer;
begin
  if Button <> mbLeft then
    StopMarginDragging
  else
  begin
    APageIndex := PageIndexFromPoint(X, Y);
    if APageIndex <> -1 then
    begin
      if SelPageIndex = APageIndex then
        ProcessClickBySelectedPage
      else
      begin
        AOldPageIndex := SelPageIndex;
        SelPageIndex := APageIndex;
        if AOldPageIndex <> SelPageIndex then
          ResetHintShowTimer(X, Y);
      end;
    end;
  end;

  if (Button = mbMiddle) and (DraggingMargin = nil) and CanAnyScrolling then
    DoScrolling
  else
    inherited MouseDown(Button, Shift, X, Y);
end;

procedure TCustomdxPreview.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  Pos: Integer;
  APageIndex: Integer;
begin
  inherited MouseMove(Shift, X, Y);
  if (FLastMousePos.X <> X) or (FLastMousePos.Y <> Y) then
  begin
    FLastMousePos := Point(X, Y);
    if FDraggingMargin = nil then
    begin
      ResetHintShowTimer(X, Y);
      if (pobHotTrack in OptionsBehavior) and IsParentFormActive then
      begin
        APageIndex := PageIndexFromPoint(X, Y);
        if APageIndex <> -1 then
          SelPageIndex := APageIndex;
      end;
    end
    else
    begin
      if DraggingMargin.IsVertical then
        Pos := X
      else
        Pos := Y;
        
      DraggingMargin.DraggingPos := Pos - FDragOffset;
    end;
  end;
end;

procedure TCustomdxPreview.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Margin: TdxPreviewPageMargin;
  Pos: Integer;
begin
  inherited MouseUp(Button, Shift, X, Y);
  if (Button = mbLeft) and Assigned(DraggingMargin) then
  begin
    Margin := DraggingMargin;
    with Margin do
    begin
      if IsVertical then
        Pos := X
      else
        Pos := Y;
        
      if FBeforeDragPos <> Pos then
        Value := ValueFromPos(Pos - FDragOffset);
    end;
    ReleaseCapture;
  end;
end;

procedure TCustomdxPreview.Paint;
begin
  CheckContentCache;
  cxBitBlt(Canvas.Handle, ContentCache.Canvas.Handle, ClientRect, cxNullPoint, SRCCOPY);
end;

procedure TCustomdxPreview.Scroll(
  AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode; var AScrollPos: Integer);
begin
  case AScrollBarKind of
    sbHorizontal:
      ScrollHorizontal(AScrollCode, AScrollPos);
    sbVertical:
      ScrollVertical(AScrollCode, AScrollPos);
  end;
  UpdateScrollBars;
  Update;
end;

procedure TCustomdxPreview.ScrollHorizontal(AScrollCode: TScrollCode; AScrollPos: Integer);
const
  SingsMap: array [Boolean] of Integer = (-1, 1);
begin
  case AScrollCode of
    scTop:
      LeftPos := 0;
    scBottom:
      LeftPos := ContentWidth;
    scLineUp, scLineDown:
      LeftPos := LeftPos + SingsMap[AScrollCode = scLineDown] * dxPreviewScrollStep;
    scPageUp, scPageDown:
      LeftPos := LeftPos + SingsMap[AScrollCode = scPageDown] * ClientWidth;
    scTrack:
      if pobThumbTracking in OptionsBehavior then
        LeftPos := AScrollPos;        
    scPosition:
      if not (pobThumbTracking in OptionsBehavior) then
        LeftPos := AScrollPos;
  end;
end;

procedure TCustomdxPreview.ScrollVertical(AScrollCode: TScrollCode; AScrollPos: Integer);
const
  SingsMap: array [Boolean] of Integer = (-1, 1);
begin
  case AScrollCode of
    scTop:
      TopPos := 0;
    scBottom:
      TopPos := ContentHeight;
    scLineUp, scLineDown:
      TopPos := TopPos + SingsMap[AScrollCode = scLineDown] * dxPreviewScrollStep;
    scPageUp, scPageDown:
      TopPos := TopPos + SingsMap[AScrollCode = scPageDown] * ClientHeight;
    scEndScroll:
      DestroyPageNumberHint;
    scPosition:
      if not (pobThumbTracking in OptionsBehavior) then
        TopPos := AScrollPos;
    scTrack:
      begin
        FHintShowTimer.Enabled := False;
        if pobThumbTracking in OptionsBehavior then
          TopPos := AScrollPos;
        if (pohShowOnScroll in OptionsHint) and (AllRowCount > 1) then
        begin
          CalcPagesBounds(AScrollPos, VirtualWidth, VirtualHeight);
          UpdatePageNumberHint;
        end;
      end;
  end;
end;

procedure TCustomdxPreview.WndProc(var Message: TMessage);

  function CanDispatchMessage(var AMouse: TWMMouse): Boolean;
  begin
    Result := not IsControlMouseMsg(AMouse) and
      (not (pozZoomOnClick in OptionsZoom) or (PageIndexFromPoint(AMouse.Pos) = -1));
  end;

  function HandleWindowMessage(var Message: TMessage): Boolean;
  begin
    Result := (Message.Msg = WM_LBUTTONDOWN) or (Message.Msg = WM_LBUTTONDBLCLK);
    if Result then
    begin
      Result := not (IsDesigning or Dragging) and
        (DragMode = dmAutomatic) and (DragKind = dkDrag);

      if Result and CanDispatchMessage(TWMMouse(Message)) then
      begin
        ControlState := ControlState + [csLButtonDown];
        Dispatch(Message);
      end;
    end;
  end;

begin
  if not HandleWindowMessage(Message) then
    inherited WndProc(Message);
end;

function TCustomdxPreview.CreateMargins: TdxPreviewPageMargins;
begin
  Result := GetMarginsClass.Create(Self);
end;

function TCustomdxPreview.GetMarginsClass: TdxPreviewPageMarginsClass;
begin
  Result := TdxPreviewPageMargins;
end;

function TCustomdxPreview.CreatePage: TdxPreviewPage;
begin
  Result := GetPageClass.Create(Self);
  FPages.Add(Result);
end;

function TCustomdxPreview.GetPageClass: TdxPreviewPageClass;
begin
  Result := TdxPreviewPage;
end;

function TCustomdxPreview.CheckLeftPos(Value: Integer): Integer;
begin
  Result := Max(0, Min(Value, VirtualWidth - ClientWidth));
end;

function TCustomdxPreview.CheckTopPos(Value: Integer): Integer;
begin
  Result := Max(0, Min(Value, VirtualHeight - ClientHeight));
end;

procedure TCustomdxPreview.CheckContentCache;
begin
  if ContentCacheDirty then
  begin
    ContentCacheDirty := False;
    if (Width <> ContentCache.Width) or (Height <> ContentCache.Height) then
      ContentCache.SetSize(Width, Height);
    DrawContent(ContentCache.cxCanvas, ContentCache.ClientRect);
  end;
end;

procedure TCustomdxPreview.CheckMargins;
var
  I: Integer;
begin
  for I := 0 to Margins.Count - 1  do
    with Margins[I] do
      Value := Value;
end;

procedure TCustomdxPreview.CheckZoomFactor;

  function CalcZoomFactor(Size, PageSize, I: Integer): Integer;
  begin
    Result := MulDiv(Size - AbsoluteIndentLeft * (1 + I), 100,
      AbsoluteIndentRight + I * (PageSize + AbsoluteIndentRight));
  end;

  function CalcZoomFactorX: Integer;
  var
    I: Integer;
  begin
    Result := MinZoomFactor;
    for I := FPageXCount downto 1 do
    begin
      Result := CalcZoomFactor(ClientWidth, PageSize.X, I);
      if Result >= MinZoomFactor then
        Break;
    end;
    Result := Max(MinZoomFactor, Result);
  end;

  function CalcZoomFactorY: Integer;
  var
    I: Integer;
  begin
    Result := MinZoomFactor;
    for I := FPageYCount downto 1 do
    begin
      Result := CalcZoomFactor(ClientHeight, PageSize.Y, I);
      if Result >= MinZoomFactor then
        Break;
    end;
    Result := Max(MinZoomFactor, Result);
  end;

var
  PageIndex, FirstPageIndex, LastPageIndex: Integer;
begin
  if not HandleAllocated then Exit;
  
  GetVisiblePageRanges(FirstPageIndex, LastPageIndex);
  if FirstPageIndex = 0 then 
    GetPartVisiblePageRanges(FirstPageIndex, LastPageIndex);

  if (SelPageIndex <> -1) and Pages[SelPageIndex].PartVisible then
    PageIndex := SelPageIndex
  else
    PageIndex := FirstPageIndex;

  FZoomModeFixed := True;
  try
    case ZoomMode of
      pzmPageWidth:
        ZoomFactor := MulDiv(ClientWidth, 100, PageSize.X + 2 * AbsoluteIndent);
      pzmPages:
        ZoomFactor := Min(CalcZoomFactorX, CalcZoomFactorY);
    end;
  finally
    FZoomModeFixed := False;
  end;
  UpdateScrollBars;
  LeftPos := LeftPos;
  TopPos := TopPos;
  MakeVisible(FirstPageIndex);
  if FirstPageIndex <> PageIndex then
    MakeVisible(PageIndex);
  if FUpdateCount = 0 then
    Invalidate;
end;

function TCustomdxPreview.CreateBackgroundRegion(const APageBounds: TRect): TcxRegion;
var
  ARect: TRect;
begin
  ARect := APageBounds;
  Inc(ARect.Left, Margins.Left.ActualValue);
  Inc(ARect.Top, Margins.Header.ActualValue);
  Dec(ARect.Right, Margins.Right.ActualValue);
  Dec(ARect.Bottom, Margins.Bottom.ActualValue);
  Result := TcxRegion.Create(ARect);
end;

function TCustomdxPreview.CanSelectPage(APageIndex: Integer): Boolean;
begin
  Result := True;
  if Assigned(OnSelectingPage) then
    OnSelectingPage(Self, APageIndex, Result);
end;

function TCustomdxPreview.CanShowMarginHint: Boolean;
begin
  Result := True;
  if Assigned(OnCanShowMarginHint) then
    OnCanShowMarginHint(Self, Result);
end;

procedure TCustomdxPreview.DoAfterDragMargin(AMargin: TdxPreviewPageMargin);
begin
  if Assigned(OnAfterDragMargin) then
    OnAfterDragMargin(Self, AMargin);
end;

procedure TCustomdxPreview.DoBeforeDragMargin(AMargin: TdxPreviewPageMargin);
begin
  if Assigned(OnBeforeDragMargin) then
    OnBeforeDragMargin(Self, AMargin);
end;

procedure TCustomdxPreview.DoCalcPageCount;
begin
  if FUpdateCount > 0 then Exit;
  if Assigned(OnCalcPageCount) then
    OnCalcPageCount(Self);
end;

procedure TCustomdxPreview.DoChangePageCount;
begin
  if Assigned(OnChangePageCount) then
    OnChangePageCount(Self);
end;

procedure TCustomdxPreview.DoDragMargin(AMargin: TdxPreviewPageMargin);
begin
  if Assigned(OnDragMargin) then
    OnDragMargin(Self, AMargin);
end;

procedure TCustomdxPreview.DoDrawPageContent(
  ACanvas: TcxCanvas; R: TRect; APageIndex: Integer);
begin
  if Assigned(OnDrawPageContent) then
    OnDrawPageContent(Self, ACanvas.Canvas, R, APageIndex);
end;

procedure TCustomdxPreview.DoGetPageNumberHintText(out AText: string);
var
  StartPage, EndPage: Integer;
begin
  AText := DropAmpersand(cxGetResourceString(@sdxPage)) + ':  ';
  GetPartVisiblePageRanges(StartPage, EndPage);
  AText := AText + IntToStr(StartPage + 1);
  if StartPage <> EndPage then 
    AText := AText + ' - ' + IntToStr(EndPage + 1);

  if Assigned(OnGetPageNumberHint) then
    OnGetPageNumberHint(Self, StartPage, EndPage, AText);
end;

procedure TCustomdxPreview.DoMarginChanged(AMargin: TdxPreviewPageMargin);
begin
  if Assigned(OnMarginChanged) then
    OnMarginChanged(Self, AMargin);
  if (AMargin <> nil) and AMargin.IsForceRecalculatePageCount then 
    DoCalcPageCount;
end;

procedure TCustomdxPreview.DoZoomFactorChanged;
begin
  if Assigned(OnZoomFactorChanged) then
    OnZoomFactorChanged(Self);
end;

procedure TCustomdxPreview.DoZoomModeChanged;
begin
  if Assigned(OnZoomModeChanged) then
    OnZoomModeChanged(Self);
end;

procedure TCustomdxPreview.DoSelectedPageChanging;
begin
  if Assigned(OnSelectedPageChanging) then
    OnSelectedPageChanging(Self, FSelPageIndex);
end;

procedure TCustomdxPreview.DoSelectedPageChanged;
begin
  if Assigned(OnSelectedPageChanged) then
    OnSelectedPageChanged(Self, SelPageIndex);
end;

procedure TCustomdxPreview.DrawContent(ACanvas: TcxCanvas; const R: TRect);
begin
  AdjustPagesBounds;
  DrawPreviewBackground(ACanvas, R);
  ACanvas.Brush.Color := clNone; // reset brush
  if PageCount = 0 then
    DrawNoPages(ACanvas)
  else
    DrawPages(ACanvas);
end;

procedure TCustomdxPreview.DrawMargins(DC: HDC);
var
  I: Integer;
  Margin: TdxPreviewPageMargin;
begin
  for I := 0 to Margins.Count - 1 do
  begin
    Margin := Margins[I];
    if Margin.Visible then
      Margin.Draw(DC);
  end;  
end;

procedure TCustomdxPreview.DrawPageBackground(
  ACanvas: TcxCanvas; APage: TdxPreviewPage; ASelected: Boolean);
var
  ACanDrawBackground: Boolean;
begin
  if Assigned(OnDrawPageBackground) then
    OnDrawPageBackground(Self, ACanvas.Canvas, APage.Bounds, APage.Index);

  ASelected := (povPageSelection in OptionsView) and ASelected;
  ACanDrawBackground := not Assigned(OnDrawPageBackground) and
    (povDefaultDrawPageBackground in OptionsView);
  LookAndFeelPainter.DrawPrintPreviewPageBackground(ACanvas,
    APage.SiteBounds, APage.Bounds, ASelected, ACanDrawBackground);
    
  if ACanDrawBackground and (PageBackground.Mode <> bmNone) then
  begin
    ACanvas.SaveClipRegion;
    try
      ACanvas.SetClipRegion(CreateBackgroundRegion(APage.Bounds), roIntersect);
      PageBackground.Paint(ACanvas.Canvas, APage.Bounds);
    finally
      ACanvas.RestoreClipRegion;
    end;
  end;
end;

procedure TCustomdxPreview.InvalidateMargins;
var
  I: Integer;
begin
  if povMargins in OptionsView then
  begin
    for I := 0 to Margins.Count - 1 do
      Margins[I].Invalidate;
  end;
end;

procedure TCustomdxPreview.InvalidatePageBorder(APageIndex: Integer);
var
  ARegion: TcxRegion;
begin
  if HandleAllocated and (APageIndex >= 0) and (APageIndex <= PageCount - 1) then
  begin
    ARegion := TcxRegion.Create(Pages[APageIndex].SiteBounds);
    try
      ARegion.Combine(TcxRegion.Create(Pages[APageIndex].Bounds), roSubtract);
      InvalidateRgn(ARegion, False);
    finally
      ARegion.Free;
    end;
  end;
end;

function TCustomdxPreview.GetAbsoluteIndent: Integer;
begin
  Result := AbsoluteIndentLeft + AbsoluteIndentRight; 
end;

function TCustomdxPreview.GetActualMeasurementUnits: TdxPreviewMeasurementUnits;
begin
  if MeasurementUnits = pmuDefault then
    Result := GetDefaultMeasurementUnits
  else
    Result := MeasurementUnits;
end;

function TCustomdxPreview.GetAllRowCount: Integer;
begin
  Result := ColCount;
  Result := PageCount div Result + Byte(PageCount mod Result > 0);
end;

function TCustomdxPreview.GetClientHeight: Integer;
begin
  Result := cxRectHeight(ClientBounds);
end;

function TCustomdxPreview.GetClientWidth: Integer;
begin
  Result := cxRectWidth(ClientBounds);
end;

function TCustomdxPreview.GetColCount: Integer;
begin
  if FZoomMode = pzmPageWidth then
    Result := 1
  else
  begin
    if FZoomMode = pzmNone then
      Result := (ClientWidth - Indent) div (VisiblePageSize.X + Indent)
    else
      Result := (MulDiv(ClientWidth, 100, FZoomFactor) - AbsoluteIndent) div (PageSize.X + AbsoluteIndent);

    Result := MaxMin(Result, 1, PageCount);
    if (FZoomMode = pzmPages) and (Result > FPageXCount) then
      Result := FPageXCount;
  end;
end;

function TCustomdxPreview.GetContentHeight: Integer;
begin
  Result := VirtualHeight - Integer(ZoomMode = pzmPages) * Indent - 1;
end;

function TCustomdxPreview.GetContentWidth: Integer;
begin
  Result := VirtualWidth - Integer(ZoomMode = pzmPages) * Indent - 1;
end;

function TCustomdxPreview.GetNoPagesText: string;
begin
  if FIsNoPagesTextAssigned then
    Result := FNoPagesText
  else
    Result := DefaultNoPagesText;
end;

procedure TCustomdxPreview.SetOptionsBehavior(Value: TdxPreviewOptionsBehavior);
var
  Changes: TdxPreviewOptionsBehavior;
  I: Integer;  
begin
  Changes := FOptionsBehavior + Value - FOptionsBehavior * Value;
  if Changes <> [] then 
  begin
    FOptionsBehavior := Value;
    if pobAllowDragMargins in Changes then
    begin
      for I := 0 to Margins.Count - 1 do
        Margins[I].Enabled := pobAllowDragMargins in Value;
    end;        
  end;
end;

procedure TCustomdxPreview.SetOptionsHint(Value: TdxPreviewOptionsHint);
var
  Changes: TdxPreviewOptionsHint;
begin
  Changes := FOptionsHint + Value - FOptionsHint * Value;
  if Changes <> [] then 
    FOptionsHint := Value;
end;

procedure TCustomdxPreview.SetOptionsStore(Value: TdxPreviewOptionsStore);
var
  Changes: TdxPreviewOptionsStore;
begin
  Changes := FOptionsStore + Value - FOptionsStore * Value;
  if Changes <> [] then 
    FOptionsStore := Value;
end;

procedure TCustomdxPreview.SetOptionsView(Value: TdxPreviewOptionsView);
var 
  Changes: TdxPreviewOptionsView;
  I: Integer;
begin
  Changes := FOptionsView + Value - FOptionsView * Value;
  if Changes <> [] then 
  begin
    FOptionsView := Value;

    if HandleAllocated then
    begin
      if [povDefaultDrawPageBackground, povPageSelection] * Changes <> [] then
        InvalidatePages
      else
        if povAutoHideScrollBars in Changes then
          RecreateWnd;
    end;
          
    if povMargins in Changes then
    begin
      for I := 0 to Margins.Count - 1 do
        Margins[I].Visible := povMargins in Value;
    end;
    ContentCacheDirty := True;
  end;
end;

procedure TCustomdxPreview.SetOptionsZoom(Value: TdxPreviewOptionsZoom);
var 
  Changes: TdxPreviewOptionsZoom;
begin
  Changes := FOptionsZoom + Value - FOptionsZoom * Value;
  if Changes <> [] then 
    FOptionsZoom := Value;
end;

procedure TCustomdxPreview.SetMarginColor(Value: TColor);
begin
  if FMarginColor <> Value then 
  begin
    FMarginColor := Value;
    RecreateMarginPen;
    if HandleAllocated then
      InvalidateMargins;
  end;
end;

procedure TCustomdxPreview.FreeMarginPen;
begin
  if FMarginPen <> 0 then
  begin
    DeleteObject(FMarginPen);
    FMarginPen := 0;
  end;
end;

procedure TCustomdxPreview.RecreateMarginPen;
begin
  FreeMarginPen;
  ContentCacheDirty := True;
  FMarginPen := CreatePen(PS_DOT, 1, ColorToRGB(MarginColor));
end;

function TCustomdxPreview.IsNoPagesTextStored: Boolean;
begin
  Result := FIsNoPagesTextAssigned and (FNoPagesText <> DefaultNoPagesText);
end;

procedure TCustomdxPreview.SetBorderStyle(Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    ContentCacheDirty := True;
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

function TCustomdxPreview.GetPage(index: Integer): TdxPreviewPage;
begin
  Result := TdxPreviewPage(FPages[index]);
end;

function TCustomdxPreview.GetPageCount: Integer;
begin
  Result := FPages.Count;
end;

function TCustomdxPreview.GetPageBorders: TRect;
begin
  Result := LookAndFeelPainter.PrintPreviewPageBordersWidth;
end;

function TCustomdxPreview.GetSelPageRow: Integer;
begin
  Result := SelPageIndex div ColCount;
end;

function TCustomdxPreview.GetSelPageCol: Integer;
begin
  Result := SelPageIndex - SelPageRow * ColCount;
end;

function TCustomdxPreview.GetRowCount: Integer;
begin
  if ZoomMode = pzmPageWidth then
    Result := 1
  else
  begin
    Result := Max(1, (MulDiv(ClientHeight, 100, FZoomFactor) - AbsoluteIndent) div (PageSize.Y + AbsoluteIndent));
    if (ZoomMode = pzmPages) and (Result > FPageYCount) then
      Result := FPageYCount;
  end;
end;

function TCustomdxPreview.GetVirtualHeight: Integer;
begin
  Result := Indent + AllRowCount * (VisiblePageSize.Y + Indent);
end;

function TCustomdxPreview.GetVirtualWidth: Integer;
begin
  if (PageCount = 0) or (ZoomMode = pzmPageWidth) then
    Result := ClientWidth
  else
    Result := Indent + ColCount * (VisiblePageSize.X + Indent);    
end;

procedure TCustomdxPreview.SetMinFooterSize(Value: Integer);
begin
  Value := Max(0, Value);
  if FMinFooterSize <> Value then
  begin
    Value := Min(Value, ActualOriginalPageSize.Y - MinUsefulSize.Y -
      MinHeaderSize - Margins.Footer.Value - Margins.Header.Value);
    FMinFooterSize := Value;
    Margins.Bottom.Value := Max(Margins.Bottom.Value, Margins.Footer.Value + Value);
    ContentCacheDirty := True;
  end;
end;

procedure TCustomdxPreview.SetMinHeaderSize(Value: Integer);
begin
  Value := Max(0, Value);
  if FMinHeaderSize <> Value then
  begin
    Value := Min(Value, ActualOriginalPageSize.Y - MinUsefulSize.Y - MinFooterSize -
      Margins.Footer.Value - Margins.Header.Value);
    FMinHeaderSize := Value;
    Margins.Top.Value := Max(Margins.Top.Value, Margins.Header.Value + Value);
    ContentCacheDirty := True;
  end;
end;

procedure TCustomdxPreview.SetMinUsefulSize(const Value: TPoint);
begin
  FMinUsefulSize.X := MinMax(Value.X, 0, 
    ActualOriginalPageSize.X - Margins.Left.Value - Margins.Right.Value);
  FMinUsefulSize.Y := MinMax(Value.Y, 0,
    ActualOriginalPageSize.Y - Margins.Top.Value - Margins.Bottom.Value);
  ContentCacheDirty := True;
end;

procedure TCustomdxPreview.SetNoPagesText(const Value: string);
begin
  if NoPagesText <> Value then
  begin
    FNoPagesText := Value;
    FIsNoPagesTextAssigned := True;
    ContentCacheDirty := True;
    if PageCount = 0 then
      Invalidate;
  end;
end;

function TCustomdxPreview.GetVisiblePageSize: TPoint;
begin
  Result.X := MulDiv(FPageSize.X, FZoomFactor, 100);
  Result.Y := MulDiv(FPageSize.Y, FZoomFactor, 100);
end;

procedure TCustomdxPreview.SetMargins(Value: TdxPreviewPageMargins);
begin
  FMargins.Assign(Value);
  ContentCacheDirty := True;
  if FUpdateCount = 0 then
    Invalidate;
end;

procedure TCustomdxPreview.SetLeftPos(Value: Integer);
begin
  Value := CheckLeftPos(Value);
  if FLeftPos <> Value then
  begin
    FLeftPos := Value;
    ContentCacheDirty := True;
    if HandleAllocated then
    begin
      UpdateScrollBars;
      Invalidate;
    end;
  end;
end;

procedure TCustomdxPreview.SetMaxZoomFactor(Value: Integer);
begin
  Value := Max(FMinZoomFactor, Value);
  if FMaxZoomFactor <> Value then
  begin
    FMaxZoomFactor := Value;
    ZoomFactor := Min(FMaxZoomFactor, ZoomFactor);
  end;
end;

procedure TCustomdxPreview.SetMinZoomFactor(Value: Integer);
begin
  Value := MinMax(Value, dxPreviewMinZoomFactor, FMaxZoomFactor);
  if FMinZoomFactor <> Value then
  begin
    FMinZoomFactor := Value;
    ZoomFactor := Max(ZoomFactor, FMinZoomFactor);
  end;
end;

procedure TCustomdxPreview.SetOnCalcPageCount(Value: TNotifyEvent);
begin
  if @FOnCalcPageCount <> @Value then
  begin
    FOnCalcPageCount := Value;
    if Assigned(FOnCalcPageCount) and ([csReading, csLoading] * ComponentState = []) then
    begin
      DoCalcPageCount;
      if HandleAllocated then
        Invalidate;
    end;
  end;  
end;

procedure TCustomdxPreview.SetOrientation(Value: TdxPreviewPaperOrientation);
begin
  if FOrientation <> Value then
  begin
    FOrientation := Value;
    AdjustOrientation;
  end;
end;

procedure TCustomdxPreview.AdjustOrientation;
var
  Temp, Temp1: Integer;
begin
  BeginUpdate;
  try
    if pobAutoSwapMargins in OptionsBehavior then
    begin
      if Orientation = ppoLandscape then
      begin
        Temp := Margins.Left.Value;
        Margins.Left.Value := Margins.Bottom.Value;
        Temp1 := Margins.Top.Value;
        Margins.Top.Value := Temp;
        Temp := Margins.Right.Value;
        Margins.Right.Value := Temp1;
        Margins.Bottom.Value := Temp;
      end
      else
      begin
        Temp := Margins.Bottom.Value;
        Margins.Bottom.Value := Margins.Left.Value;
        Temp1 := Margins.Right.Value;
        Margins.Right.Value := Temp;
        Temp := Margins.Top.Value;
        Margins.Top.Value := Temp1;
        Margins.Left.Value := Temp;
      end;
    end;
    PageParametersChanged(FOriginalPageSize, [pcX, pcY]);
    CheckMargins;
    ContentCacheDirty := True;
  finally
    EndUpdate;
    CheckZoomFactor;
  end;
end;

procedure TCustomdxPreview.PageParametersChanging(Sender: TObject;
  Coords: TdxPointCoords; var Values: array of Integer);
begin
  if (pcX in Coords) and (Values[0] < MinUsefulSize.X) then 
    Values[0] := MinUsefulSize.X;
  if (pcY in Coords) and (Values[1] < MinUsefulSize.Y) then
    Values[1] := MinUsefulSize.Y;
end;

procedure TCustomdxPreview.PageParametersChanged(Sender: TObject; Coords: TdxPointCoords);
var
 V: Integer;
begin
  FActualOriginalPageSize := OriginalPageSize.Point;
  if Orientation = ppoLandscape then
    with FActualOriginalPageSize do
    begin
      V := Y;
      Y := X;
      X := V;
    end;
  FPageSize := LoMetricToPixels(ActualOriginalPageSize);
  CheckMargins;
  CheckZoomFactor;
  ContentCacheDirty := True;
end;

procedure TCustomdxPreview.SetOriginalPageSize(Value: TdxPointWrapper);
begin
  if Value <> nil then
    OriginalPageSize.Assign(Value);
end;

procedure TCustomdxPreview.SetPageBackground(Value: TdxBackground);
begin
  PageBackground.Assign(Value);
end;

procedure TCustomdxPreview.SetPageCount(Value: Integer);
var
  I: Integer;
begin
  Value := Max(Value, 0);
  if PageCount <> Value then
  begin
    if Value < PageCount then
    begin
      for I := Value to FPages.Count - 1 do
        TdxPreviewPage(FPages[I]).Free;
      FPages.Count := Value;
    end
    else
    begin
      for I := PageCount to Value - 1 do
        CreatePage;
    end;
    // check SelPageIndex
    if not (csDestroying in ComponentState) then
    begin
      ContentCacheDirty := True;
      ResyncSelPageIndex;
      CheckZoomFactor;
    end;
  end;
end;

procedure TCustomdxPreview.ResyncSelPageIndex;
var
  Value: Integer;
begin
  Value := SelPageIndex;
  while (Value > -1) and not CanSelectPage(Value) do 
    Dec(Value);
  if Value = -1 then  
  begin
    Value := 0;
    while (Value < PageCount) and not CanSelectPage(Value) do 
      Inc(Value);
  end;
  if Value = PageCount then
    Value := -1;
  SelPageIndex := Value;
end;

procedure TCustomdxPreview.SetPageXCount(Value: Integer);
begin
  Value := Max(1, Value);
  if FPageXCount <> Value then
  begin
    FPageXCount := Value;
    ZoomMode := pzmPages;
    CheckZoomFactor;
    ContentCacheDirty := True;
  end;
end;

procedure TCustomdxPreview.SetPageYCount(Value: Integer);
begin
  Value := Max(1, Value);
  if FPageYCount <> Value then
  begin
    FPageYCount := Value;
    ZoomMode := pzmPages;
    CheckZoomFactor;
    ContentCacheDirty := True;
  end;
end;

procedure TCustomdxPreview.SetSelPageIndex(Value: Integer);
begin
  Value := MinMax(Value, -1, PageCount - 1);

  if FSelPageIndex <> Value then
  begin
    if (Value = -1) or CanSelectPage(Value) then
    begin
      ContentCacheDirty := True;
      DoSelectedPageChanging;
      if FSelPageIndex < PageCount then
      begin
        InvalidatePageBorder(FSelPageIndex);
        InvalidateMargins;
      end;
      FSelPageIndex := Value;
      if FSelPageIndex <> -1 then
      begin
        InvalidatePageBorder(FSelPageIndex);
        InvalidateMargins;
        MakeVisible(FSelPageIndex);
      end;
      DoSelectedPageChanged;
    end;
  end;
end;

procedure TCustomdxPreview.SetTopPos(Value: Integer);
begin
  Value := CheckTopPos(Value);
  if FTopPos <> Value then
  begin
    FTopPos := Value;
    ContentCacheDirty := True;
    if HandleAllocated then
    begin
      UpdateScrollBars;
      Invalidate;
    end;
  end;
end;

procedure TCustomdxPreview.SetTransparent(AValue: Boolean);
begin
  if AValue <> FTransparent then
  begin
    FTransparent := AValue;
    ContentCacheDirty := True;
    if HandleAllocated then
      Invalidate;
  end;
end;

procedure TCustomdxPreview.SetZoomed(Value: Boolean);
begin
  FZoomedFixed := True;
  if not FZoomed and Value then
  begin
    FZoomed := True;
    FUnzoomedFactor := ZoomFactor;
    FUnzoomedMode := ZoomMode;
    ZoomFactor := 100;
  end
  else
    if FZoomed then
    begin
      if ZoomFactor = 100 then
      begin
        FZoomed := False;
        ZoomMode := FUnzoomedMode;
        ZoomFactor := FUnzoomedFactor;
      end
      else
        ZoomFactor := 100;
    end;
  ContentCacheDirty := True;
  FZoomedFixed := False;
  UpdateWindow(Handle);
end;

procedure TCustomdxPreview.SetZoomStep(Value: Integer);
begin
  Value := Max(Value, 1);
  if FZoomStep <> Value then
    FZoomStep := Value;
end;

procedure TCustomdxPreview.SetZoomFactor(Value: Integer);

  procedure UpdateZoomFactorValue;
  begin
    if FZoomMode = pzmNone then
    begin
      FZooming := True;
      try
        CheckZoomFactor;
      finally
        FZooming := False;
      end;  
    end
    else 
      if (FUpdateCount = 0) then
        Invalidate;
  end;

begin
  Value := MinMax(Value, FMinZoomFactor, FMaxZoomFactor);
  if FZoomFactor <> Value then
  begin
    FZoomFactor := Value;
    if not FZoomModeFixed then
      FZoomMode := pzmNone;
    if not FZoomedFixed then
      FZoomed := FZoomFactor >= 100;
    ContentCacheDirty := True;
    UpdatePreviewIndents;
    FIndent := CalculateIndent;
    UpdateZoomFactorValue;
    DoZoomFactorChanged;
  end;
end;

procedure TCustomdxPreview.SetZoomMode(Value: TdxPreviewZoomMode);
begin
  if FZoomMode <> Value then
  begin
    FZoomMode := Value;
    CheckZoomFactor;
    ContentCacheDirty := True;
    DoZoomModeChanged;
  end;
end;

function TCustomdxPreview.CalculateIndent: Integer;
begin
  Result := AbsoluteIndentLeft + AbsoluteIndentRight * FZoomFactor div 100;
end;

procedure TCustomdxPreview.UpdatePreviewIndents;
begin
  FAbsoluteIndentLeft := 4 + Max(PageBorders.Left, PageBorders.Top);
  FAbsoluteIndentRight := 4 + Max(PageBorders.Right, PageBorders.Bottom) + 2;
end;

procedure TCustomdxPreview.CreateHint;
begin
  if FHintWindow = nil then
    FHintWindow := TdxPreviewHintWindow.Create(nil);
end;
                                      
procedure TCustomdxPreview.DestroyHint;
begin
  FreeAndNil(FHintWindow);
end;

procedure TCustomdxPreview.ActivateHint(AMargin: TdxPreviewPageMargin);
var
  Pt: TPoint;
begin
  if FHintWindow = nil then Exit;
  Pt := ScreenToClient(Mouse.CursorPos);
  with AMargin do
  begin
    if IsVertical then
      if IsDragging then
        Pt.X := DraggingPos
      else
        Pt.X := Bounds.Left
    else 
      if IsDragging then
        Pt.Y := DraggingPos
      else
        Pt.Y := Bounds.Top;
    Windows.ClientToScreen(Handle, Pt);
  end;  
  TdxPreviewHintWindow(FHintWindow).ActivateHint(Pt, AMargin.DisplayText, AMargin);
end;

procedure TCustomdxPreview.CancelHintHide;
begin
  FHintHideShortTimer.Enabled := False;
end;

procedure TCustomdxPreview.CancelHintShow;
begin
  FHintShowTimer.Enabled := False;
  DestroyHint;
end;

procedure TCustomdxPreview.StartHintShow;
begin
  FHintShowTimer.Enabled := True;
end;

procedure TCustomdxPreview.ClearLastMousePos;
begin
  FLastMousePos := Point(MaxInt, MaxInt);
end;

procedure TCustomdxPreview.CancelDragMargin;
begin
  if DraggingMargin = nil then Exit;
  DraggingMargin.DraggingPos := NullDraggingPos;
  DraggingMargin.DoDragAfter;
  FDraggingMargin := nil;
  ClearLastMousePos;
end;

procedure TCustomdxPreview.DestroyPageNumberHint;
begin
  FreeAndNil(FHintWindowPageNumber);
end;

procedure TCustomdxPreview.UpdatePageNumberHint;
var
  HintText: string;
begin
  if FHintWindowPageNumber = nil then
    FHintWindowPageNumber := TdxPreviewHintWindow.Create(nil);
  DoGetPageNumberHintText(HintText);
  TdxPreviewHintWindow(FHintWindowPageNumber).ActivateHint(Mouse.CursorPos, HintText, nil);
end;

procedure TCustomdxPreview.SetScrollBarStyle(Value: TScrollBarStyle);
begin
  if Value <> FScrollBarStyle then
  begin
    FScrollBarStyle := Value;
    RecreateWnd;
  end;
end;

function TCustomdxPreview.CanChangeMargins: Boolean;
begin
  Result := [csReading, csLoading] * ComponentState = [];
end;

procedure TCustomdxPreview.ScrollPage(ADirection: TdxPreviewScrollDirection);
const
  MsgMap: array[TdxPreviewScrollDirection] of Cardinal =
    (WM_HSCROLL, WM_VSCROLL, WM_HSCROLL, WM_VSCROLL);
  ScrollCodeMap: array[TdxPreviewScrollDirection] of Smallint =
    (SB_LINELEFT, SB_LINEUP, SB_LINERIGHT, SB_LINEDOWN);
  BarMap: array[TdxPreviewScrollDirection] of Integer =
    (SB_HORZ, SB_VERT, SB_HORZ, SB_VERT);
var
  Message: TWMScroll;
begin
  FillChar(Message, SizeOf(TMessage), 0);
  Message.Msg := MsgMap[ADirection];
  Message.ScrollCode := ScrollCodeMap[ADirection];
  Message.Pos := GetScrollPos(Handle, BarMap[ADirection]);
  Dispatch(Message);
end;

procedure TCustomdxPreview.DrawNoPages(ACanvas: TcxCanvas);
var
  R: TRect;
begin
  R := ClientRect;
  ACanvas.Font.Assign(Font);
  ACanvas.Font.Color := clWindow;
  ACanvas.Brush.Style := bsClear;
  cxDrawText(ACanvas.Handle, NoPagesText, R,
    DT_CALCRECT or DT_CENTER or DT_WORDBREAK or DT_TOP);
  R := cxRectCenter(ClientRect, cxRectWidth(R), cxRectHeight(R));
  cxDrawText(ACanvas.Handle, NoPagesText, R, DT_WORDBREAK);
end;

procedure TCustomdxPreview.DrawPage(
  ACanvas: TcxCanvas; APage: TdxPreviewPage; ASelected: Boolean);
var
  R: TRect;
begin
  R := APage.SiteBounds;
  if (R.Bottom > 0) and (R.Top < ClientHeight) and ACanvas.RectVisible(R) then
  begin
    DrawPageBackground(ACanvas, APage, ASelected);
    DoDrawPageContent(ACanvas, APage.Bounds, APage.Index);
    if (povMargins in OptionsView) and ASelected then
      DrawMargins(ACanvas.Handle);
  end;
end;

procedure TCustomdxPreview.DrawPages(ACanvas: TcxCanvas);
var
  I, J, APageIndex: Integer;
begin
  for J := 0 to AllRowCount - 1 do
  begin
    for I := 0 to ColCount - 1 do
    begin
      APageIndex := J * ColCount + I;
      if APageIndex > PageCount - 1 then
        Break;
      DrawPage(ACanvas, Pages[APageIndex], APageIndex = SelPageIndex);
    end;
  end;
end;

procedure TCustomdxPreview.DrawPreviewBackground(ACanvas: TcxCanvas; const R: TRect);
begin
  if Transparent then
    cxDrawTransparentControlBackground(Self, ACanvas, R)
  else
    LookAndFeelPainter.DrawPrintPreviewBackground(ACanvas, R);
end;

procedure TCustomdxPreview.AdjustPagesBounds;
begin
  if povAutoHideScrollBars in OptionsView then 
  begin
    CalcPagesBounds(TopPos, VirtualWidth + GetSystemMetrics(SM_CXVSCROLL), 
      VirtualHeight + GetSystemMetrics(SM_CXHSCROLL));
    if (VirtualWidth > ClientWidth) or (VirtualHeight > ClientHeight) then 
      CalcPagesBounds(TopPos, VirtualWidth, VirtualHeight);
  end
  else
    CalcPagesBounds(TopPos, VirtualWidth, VirtualHeight);
end;

function TCustomdxPreview.CanHorzScrollBarBeVisible: Boolean;
begin
  Result := ScrollBars in [ssBoth, ssHorizontal];
end;

function TCustomdxPreview.CanVertScrollBarBeVisible: Boolean;
begin
  Result := ScrollBars in [ssBoth, ssVertical];
end;

function TCustomdxPreview.CanAnyScrolling: Boolean;
begin
  Result := CanHorzScrolling or CanVertScrolling;
end;

function TCustomdxPreview.CanHorzScrolling: Boolean;
begin
  Result := (ZoomMode <> pzmPageWidth) and (ClientWidth < ContentWidth);
end;

function TCustomdxPreview.CanVertScrolling: Boolean;
begin
  Result := ClientHeight < ContentHeight;
end;

function TCustomdxPreview.CanPageScrolling(ADirection: TdxPreviewScrollDirection): Boolean;
begin
  Result := ((ZoomMode <> pzmPages) or (PageCount <> 1)) and 
    ((ADirection in [psdLeft, psdRight]) and CanHorzScrolling) or 
    ((ADirection in [psdUp, psdDown]) and CanVertScrolling);
end;

procedure TCustomdxPreview.InitScrollBarsParameters;
begin
  SetScrollBarInfo(sbHorizontal, 0, ContentWidth, dxPreviewScrollStep,
    ClientWidth, LeftPos, CanHorzScrollBarBeVisible, povAutoHideScrollBars in OptionsView);

  SetScrollBarInfo(sbVertical, 0, ContentHeight, dxPreviewScrollStep,
    ClientHeight, TopPos, CanVertScrollBarBeVisible, povAutoHideScrollBars in OptionsView);
end;
  
procedure TCustomdxPreview.ResetHintShowTimer(X, Y: Integer);
begin
  CancelHintShow;
  if not IsDesigning and IsParentFormActive and (pohShowForMargins in OptionsHint) and 
    (GetHitInfoAt(X, Y) * phtMargins <> []) and CanShowMarginHint
  then
    StartHintShow;
end;

procedure TCustomdxPreview.SetScrollBars(Value: TScrollStyle);
begin
  if FScrollBars <> Value then
  begin
    FScrollBars := Value;
    RecreateWnd;
  end;
end;

procedure TCustomdxPreview.DesignerModified;
var
  Designer: IDesignerNotify;
begin
  if IsDesigning then
  begin
    Designer := GetParentForm(Self).Designer;
    if Designer <> nil then
      Designer.Modified;
  end;
end;

function TCustomdxPreview.IsDesigning: Boolean; 
begin
  Result := csDesigning in ComponentState;
end;

function TCustomdxPreview.IsParentFormActive: Boolean;
var
  Form: TCustomForm;
begin
  Form := GetParentForm(Self);
  Result := (Form <> nil) and Form.Active;
end;

procedure TCustomdxPreview.HintHideLongTimerHandler(Sender: TObject);
begin
end;

procedure TCustomdxPreview.HintHideShortTimerHandler(Sender: TObject);
begin
  if not IsParentFormActive or (Time - FLongShowHintTime > dxPreviewHideHintLongTime) then
  begin
    DestroyHint;
    //FHintHideTimer.Enabled := False;
  end;
end;

procedure TCustomdxPreview.HintShowTimerHandler(Sender: TObject);
var
  Margin: TdxPreviewPageMargin;
begin
  FHintShowTimer.Enabled := False;
  Margin := MarginFromPoint(ScreenToClient(Mouse.CursorPos));
  if (Margin <> nil) and (not Margin.IsDragging or (pohShowOnDrag in OptionsHint)) then
  begin
    CreateHint;
    ActivateHint(Margin);
    FLongShowHintTime := GetTickCount;
    FHintHideShortTimer.Enabled := True;
  end;
end;

procedure TCustomdxPreview.ReadIsNoPagesTextAssigned(AReader: TReader);
begin
  FIsNoPagesTextAssigned := AReader.ReadBoolean;
end;

procedure TCustomdxPreview.WriteIsNoPagesTextAssigned(AWriter: TWriter);
begin
  AWriter.WriteBoolean(FIsNoPagesTextAssigned);
end;

procedure TCustomdxPreview.WMCaptureChanged(var Message: TMessage);
begin
  CancelDragMargin;
  DestroyPageNumberHint;
  inherited;
end;

procedure TCustomdxPreview.WMGetDlgCode(var Message: TWMGetDlgCode);
const 
  AllKeys: array[Boolean] of LongInt = (0, DLGC_WANTALLKEYS);
  ArrowKeys: array[Boolean] of LongInt = (0, DLGC_WANTARROWS);
begin
  inherited;
  Message.Result := Message.Result or 
    AllKeys[DraggingMargin <> nil] or ArrowKeys[pobKeyNavigation in OptionsBehavior];
end;

procedure TCustomdxPreview.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TCustomdxPreview.WMKillFocus(var Message: TWMKillFocus);
begin
  ClearLastMousePos;
  HideAllHints;
  inherited;
end;

procedure TCustomdxPreview.WMRButtonUp(var Message: TWMRButtonUp);
begin
  HideAllHints;
  inherited;
end;

procedure TCustomdxPreview.WMMouseActivate(var Message: TWMMouseActivate);
var
  Control: TWinControl;
  Pt: TPoint;
begin
  inherited;
  if not IsDesigning then
  begin
    Control := FindControl(GetFocus);
    if (Control = nil) or (GetParentForm(Control) <> GetParentForm(Self)) then
    begin
      Pt := ScreenToClient(Mouse.CursorPos);
      if (PageIndexFromPoint(Pt) > -1) {and not Assigned(MarginFromPoint(APt)) } then
        Message.Result := MA_ACTIVATEANDEAT;
    end;
    if CanFocus then
      SetFocus;
  end;
end;

procedure TCustomdxPreview.WMMouseWheel(var Message: TWMMouseWheel);
begin
  if DraggingMargin <> nil then
    Perform(WM_LBUTTONUP, Message.Keys, TMessage(Message).lParam);
  HideAllHints;

  if PageCount <> 0 then
  begin
    if (pozZoomOnMouseRoll in OptionsZoom) or (GetKeyState(VK_CONTROL) < 0) then
    begin
      if Message.WheelDelta > 0 then
        ZoomIn
      else
        ZoomOut;
    end
    else
      inherited;
  end;
end;

procedure TCustomdxPreview.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  inherited;
  if (LookAndFeel.Kind <> lfStandard) and (BorderStyle <> bsNone) then
    InflateRect(Message.CalcSize_Params^.rgrc[0], -1, -1);
end;

procedure TCustomdxPreview.WMNCDestroy(var Message: TWMNCDestroy);
begin
  HideAllHints;
  inherited;
end;

procedure TCustomdxPreview.WMNCHitTest(var Message: TWMNCHitTest);
begin
  DefaultHandler(Message);
end;

procedure TCustomdxPreview.WMNCPaint(var Message: TWMNCPaint);
const 
  Flat: array[Boolean] of UINT = (0, BF_FLAT);
var
  R: TRect;
  DC: HDC;
  AStyle: DWORD;
begin
  inherited;
  if (LookAndFeel.Kind <> lfStandard) and (BorderStyle <> bsNone) then
  begin
    GetWindowRect(Handle, R);
    OffsetRect(R, -R.Left, -R.Top);
    DC := GetWindowDC(Handle);
    try
      DrawEdge(DC, R, BDR_SUNKENOUTER, BF_RECT or Flat[LookAndFeel.Kind = lfUltraFlat]);

      AStyle := GetWindowLong(Handle, GWL_STYLE);
      if (AStyle and WS_HSCROLL <> 0) and (AStyle and WS_VSCROLL <> 0) then
      begin
        InflateRect(R, -1, -1);
        R.Left := R.Right - GetSystemMetrics(SM_CXVSCROLL);
        R.Top := R.Bottom - GetSystemMetrics(SM_CYHSCROLL);

        FillRect(DC, R, HBRUSH(COLOR_BTNFACE + 1));
      end;
    finally  
      ReleaseDC(Handle, DC);
    end;  
  end;
end;

procedure TCustomdxPreview.WMSetCursor(var Message: TWMSetCursor);
var
  Cursor: HCURSOR;
  Margin: TdxPreviewPageMargin;
  Pt: TPoint;
  HitInfo: TdxPreviewHitTests;
begin
  Cursor := 0;
  if Message.HitTest = HTCLIENT then
  begin
    Margin := DraggingMargin;
    if (Margin = nil) and IsParentFormActive then
    begin
      Pt := ScreenToClient(Mouse.CursorPos);
      HitInfo := GetHitInfoAt(Pt);
      if phtPage in HitInfo then
        if phtMargins * HitInfo <> [] then
        begin
          Margin := MarginFromPoint(Pt);
          if Margin.Enabled then
            Cursor := Screen.Cursors[Margin.GetCursor];
        end
        else 
          if not IsDesigning and (pozZoomOnClick in OptionsZoom) and (PageIndexFromPoint(Pt) = SelPageIndex) then
            if Zoomed then
              Cursor := Screen.Cursors[crdxPreviewZoomOut]
            else
              Cursor := Screen.Cursors[crdxPreviewZoomIn];
    end;
  end;
  
  if Cursor <> 0 then
    SetCursor(Cursor)
  else
    inherited;
end;

procedure TCustomdxPreview.WMSize(var Message: TWMSize);
begin
  inherited;
  ContentCacheDirty := True;
  CheckZoomFactor;
end;

procedure TCustomdxPreview.CMCancelMode(var Message: TCMCancelMode);
begin
  HideAllHints;
  inherited;
end;

procedure TCustomdxPreview.CMColorChanged(var Message: TMessage);
begin
  inherited;
  Brush.Color := Color;
  NotifyControls(CM_PARENTCOLORCHANGED);
end;

procedure TCustomdxPreview.CMCtl3DChanged(var Message: TMessage);
begin
  inherited;
  if (BorderStyle = bsSingle) and (LookAndFeel.Kind = lfStandard) then 
    RecreateWnd;
end;

procedure TCustomdxPreview.CMDesignHitTest(var Message: TCMDesignHitTest);
begin
  Message.Result := Integer((DraggingMargin <> nil) or (GetHitInfoAt(Message.Pos) * phtMargins <> []));
end;

procedure TCustomdxPreview.CMHintShow(var Message: TCMHintShow);
begin
  inherited;
  Message.Result := Integer((DraggingMargin <> nil) and 
    (PageIndexFromPoint(Message.HintInfo^.CursorPos) <> -1));
end;

procedure TCustomdxPreview.CMSysColorChange(var Message: TMessage);
begin
  inherited;
  if MarginColor and $80000000 = $80000000 then 
  begin
    RecreateMarginPen;
    InvalidateMargins;
  end;  
end;

function DefineCursor(const AResName: PChar): TCursor;
var
  Handle: HCURSOR;
begin
  Result := crDefault;
  Handle := LoadCursor(hInstance, AResName);
  if Handle > 0 then
  begin
    for Result := 100 to High(TCursor) do
      if Screen.Cursors[Result] = Screen.Cursors[crDefault] then
      begin
        Screen.Cursors[Result] := Handle;
        Exit;
      end;
    DestroyCursor(Handle);
    raise EOutOfResources.Create(cxGetResourceString(@sdxOutOfResources));
  end;
end;

procedure DefineCursors;
begin 
  crdxPreviewHorzResize := DefineCursor(IDC_DXPSPREVIEW_MARGINSMOVEHORZ);
  crdxPreviewVertResize := DefineCursor(IDC_DXPSPREVIEW_MARGINSMOVEVERT);
  crdxPreviewZoomIn := DefineCursor(IDC_DXPSPREVIEW_ZOOMIN);
  crdxPreviewZoomOut := DefineCursor(IDC_DXPSPREVIEW_ZOOMOUT);
  crdxPreviewFullScroll := DefineCursor(IDC_DXPSPREVIEW_SCROLLFULL);
  crdxPreviewHorzScroll := DefineCursor(IDC_DXPSPREVIEW_SCROLLHORZ);
  crdxPreviewVertScroll := DefineCursor(IDC_DXPSPREVIEW_SCROLLVERT);
  crdxPreviewUpScroll := DefineCursor(IDC_DXPSPREVIEW_WHEELSCROLLUP);
  crdxPreviewRightScroll := DefineCursor(IDC_DXPSPREVIEW_WHEELSCROLLRIGHT);
  crdxPreviewDownScroll := DefineCursor(IDC_DXPSPREVIEW_WHEELSCROLLDOWN);
  crdxPreviewLeftScroll := DefineCursor(IDC_DXPSPREVIEW_WHEELSCROLLLEFT);
  crdxPreviewTopLeftScroll := DefineCursor(IDC_DXPSPREVIEW_WHEELSCROLLTOPLEFT);
  crdxPreviewBottomLeftScroll := DefineCursor(IDC_DXPSPREVIEW_WHEELSCROLLBOTTOMLEFT);
  crdxPreviewTopRightLeftScroll := DefineCursor(IDC_DXPSPREVIEW_WHEELSCROLLTOPRIGHT);
  crdxPreviewBottomRightScroll := DefineCursor(IDC_DXPSPREVIEW_WHEELSCROLLBOTTOMRIGHT);
end;

initialization
  DefineCursors;
  
end.

