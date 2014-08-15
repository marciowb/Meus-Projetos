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

unit dxPSPrVw;

interface

{$I cxVer.inc}

uses
  Windows, Classes, SysUtils, Messages, Controls, ExtCtrls, ComCtrls, Buttons, 
  ImgList, Dialogs, Forms,
  dxMessages, dxPSGlbl, dxPSCore, dxPSESys, dxPrevw, dxPSPrVwOpt, 
  dxPrnPg, dxExtCtrls, dxBkgnd;

type
  TfmPreviewStatusSection = (ssCurrentPage, ssPageCount, ssPaperSize, ssStatus);
  TfmPreviewStatusSections = set of TfmPreviewStatusSection;

  TdxPSExplorerVisibiltyState = (evsUndefined, evsHidden, evsShown);
  TdxPSThumbnailsVisibiltyState = (tvsUndefined, tvsHidden, tvsShown);
  TdxPSPageMarginsVisibilityState = (mvsUndefined, mvsHidden, mvsShown);
  
  TdxPSPreviewWindowStatusBarMode = (psbmNormal, psbmProgress);
  
  TCustomdxPSPreviewWindow = class;
  
  TdxPSPreviewExplorerChangeNotifier = class(TdxPSExplorerChangeNotifierAdapter)
  private
    FPreview: TCustomdxPSPreviewWindow;
  protected
    procedure ItemDataLoaded(AnItem: TdxPSExplorerItem); override;
    procedure ItemDataUnloaded(AnItem: TdxPSExplorerItem); override;
  public
    constructor Create(APreview: TCustomdxPSPreviewWindow);
    property Preview: TCustomdxPSPreviewWindow read FPreview;
  end;

  TCustomdxPSPreviewWindow = class(TBasedxPreviewWindow, IdxPSExplorerTreeContainerHost)
  private
    FBuildEventsSubscriber: TdxEventSubscriber;    
    FComponentPrinter: TCustomdxComponentPrinter;
    FCurrentProgressValue: Integer;
    FEnableOptions: TdxPreviewEnableOptions;
    FFullPageCount: Integer;
    FHFEditPart: TdxPageTitlePart;
    FHFFunctionList: TStringList;
    FHFTextEntriesChangedSubscriber: TdxEventSubscriber;
    FLastOpCompleted: Integer;
    FLastValidZoomFactor: Integer;
    FLockPageSelection: Boolean;
    FPredefinedZooms: TStringList;
    FPrintEventsSubscriber: TdxEventSubscriber;
    FProgressBar: TProgressBar;
    FSaveExplorerPaneWidth: Integer;
    FSaveExplorerVisibility: TdxPSExplorerVisibiltyState;
    FSavePageMarginsVisibility: TdxPSPageMarginsVisibilityState;
    FSaveThumbnailsPaneWidth: Integer;
    FSaveThumbnailsVisibility: TdxPSThumbnailsVisibiltyState;
    FSaveZoomPosition: Boolean;
    FShowExplorer: Boolean;
    FShowMarginBar: Boolean;
    FShowStatusBar: Boolean;
    FShowThumbnails: Boolean;
    FState: TdxPSPreviewState;
    FStyleEventsSubscriber: TdxEventSubscriber;
    FThumbnailsSize: TdxPSThumbnailsSize;
    FUpdateCount: Integer;
    FVisibleOptions: TdxPreviewVisibleOptions;
    function GetExplorer: TCustomdxPSExplorer;
    function GetExplorerPaneWidth: Integer;
    function GetFlat: Boolean;
    function GetIsExplorerAvailable: Boolean;
    function GetIsExplorerMode: Boolean;
    function GetPrinterPage: TdxPrinterPage;
    function GetProgressStatusPanel: TStatusPanel;
    function GetShowMarginBar: Boolean;
    function GetShowPageMargins: Boolean;
    function GetShowStatusBar: Boolean;
    function GetStatusTextPanel: TStatusPanel;
    function GetThumbnailsPaneWidth: Integer;
    procedure SetExplorerPaneWidth(Value: Integer);
    procedure SetShowMarginBar(Value: Boolean);
    procedure SetShowPageMargins(Value: Boolean);
    procedure SetShowStatusBar(Value: Boolean);
    procedure SetThumbnailsPaneWidth(Value: Integer);
    
    procedure DrawStatusFrame(AStatusBar: TStatusBar; var R: TRect);
    procedure DrawStatusText(AStatusBar: TStatusBar; APanel: TStatusPanel;
      const R: TRect; AHighlighted, AMarginBar: Boolean);
    procedure FillEffectsApply(Sender: TObject);

    procedure ExplorerClose(Sender: TObject);
    procedure ExplorerSplitterCanResize(Sender: TObject; var NewSize: Integer; var Accept: Boolean);
    procedure ExplorerSplitterMouseUp(Sender: TObject; Button: TMouseButton; 
      Shift: TShiftState; X, Y: Integer);
    procedure ExplorerToolBarResize(Sender: TObject);
    procedure MarginBarDblClick(Sender: TObject);
    procedure MarginBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
    procedure PreviewAfterDragMargin(Sender: TObject; AMargin: TdxPreviewPageMargin);
    procedure PreviewBeforeDragMargin(Sender: TObject; AMargin: TdxPreviewPageMargin);
    procedure PreviewCalcPageCount(Sender: TObject);
    procedure PreviewCanShowMarginHint(Sender: TObject; var ACanShowHint: Boolean);
    procedure PreviewDblClick(Sender: TObject);
    procedure PreviewDragMargin(Sender: TObject; AMargin: TdxPreviewPageMargin);
    procedure PreviewMarginsChanged(Sender: TObject; AMargin: TdxPreviewPageMargin);
    procedure PreviewSelectedPageChanged(Sender: TObject; APageIndex: Integer);
    procedure PreviewSelectingPage(Sender: TObject; APageIndex: Integer; var ACanSelect: Boolean);
    procedure PreviewZoomFactorChanged(Sender: TObject);
    procedure PreviewZoomModeChanged(Sender: TObject);
    procedure StatusBarDblClick(Sender: TObject);
    procedure StatusBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
    procedure StatusBarMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ThumbnailsPreviewSelectedPageChanged(Sender: TObject; APageIndex: Integer);
    procedure ThumbnailsSplitterCanResize(Sender: TObject; var NewSize: Integer; var Accept: Boolean);
    procedure ThumbnailsSplitterMouseUp(Sender: TObject; Button: TMouseButton; 
      Shift: TShiftState; X, Y: Integer);

    procedure EndGenerateReport(Sender: TObject; AReportLink: TBasedxReportLink);
    procedure GenerateReportProgress(Sender: TObject; AReportLink: TBasedxReportLink; APercentDone: Double);
    procedure StartGenerateReport(Sender: TObject; AReportLink: TBasedxReportLink);
        
    procedure EndPrint(Sender: TObject; AReportLink: TBasedxReportLink);
    procedure NewPage(Sender: TObject; AReportLink: TBasedxReportLink; APageIndex: Integer);
    procedure StartPrint(Sender: TObject; AReportLink: TBasedxReportLink; FullPageCount: Integer);    
    
    procedure LoadZooms;
    procedure UpdateMarginBar;
    procedure UpdateStatusText;
    procedure WMAppCommand(var Message: TMessage); message WM_APPCOMMAND;
    procedure WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
    procedure WMSettingChange(var Message: TWMSettingChange); message WM_SETTINGCHANGE; 
    procedure WMSize(var Message: TWMSize); message WM_SIZE;   
  protected
    FExplorerChangeNotifier: TdxPSPreviewExplorerChangeNotifier;
    FExplorerCloseButton: TSpeedButton;
    FExplorerPane: TPanel;
    FExplorerSplitter: TSplitter;
    FExplorerToolBar: TPanel;
    FExplorerTree: TCustomdxPSExplorerTreeContainer;
    FExplorerTreeHost: TPanel;
    FMarginBar: TStatusBar;
    FPreview: TdxPreview;
    FPreviewPane: TPanel;
    FStatusBar: TStatusBar;
    FThumbnailsPane: TPanel;
    FThumbnailsPreview: TdxPreview;
    FThumbnailsSplitter: TSplitter;

    FAreMarginsValid: Boolean;
    FReleased: Boolean;

    procedure Activate; override;    
    procedure DoClose(var AAction: TCloseAction); override;
    procedure DoShow; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure WndProc(var message: TMessage); override;

    function GetActivePageIndex: Integer; override;
    function GetBackground: TdxBackground; override;
    function GetComponentPrinter: TCustomdxComponentPrinter; override;
    function GetExplorerTree: TCustomdxPSExplorerTreeContainer; override;
    function GetHFEditPart: TdxPageTitlePart; override;
    function GetPageCount: Integer; override;
    function GetPreviewEnableOptions: TdxPreviewEnableOptions; override;
    function GetPreviewVisibleOptions: TdxPreviewVisibleOptions; override;
    function GetSaveZoomPosition: Boolean; override;
    function GetShowExplorer: Boolean; override;
    function GetShowThumbnails: Boolean; override;
    function GetState: TdxPSPreviewState; override;
    function GetStatusPanelBounds(AStatusBar: TStatusBar; AIndex: Integer): TRect;
    function GetThumbnailsSize: TdxPSThumbnailsSize; override;
    function GetVisiblePageSize: TPoint; override;
    function GetZoomFactor: Integer; override;
    procedure SetActivePageIndex(Value: Integer); override;
    procedure SetBackground(const Value: TdxBackground); override;
    procedure SetComponentPrinter(const Value: TCustomdxComponentPrinter); override;
    procedure SetHFEditPart(const Value: TdxPageTitlePart); override;    
    procedure SetPageCount(Value: Integer); override;
    procedure SetPreviewEnableOptions(const Value: TdxPreviewEnableOptions); override;
    procedure SetPreviewVisibleOptions(const Value: TdxPreviewVisibleOptions); override;
    procedure SetSaveZoomPosition(Value: Boolean); override;
    procedure SetShowExplorer(Value: Boolean); override;
    procedure SetShowThumbnails(Value: Boolean); override;
    procedure SetState(const Value: TdxPSPreviewState); override;
    procedure SetThumbnailsSize(const Value: TdxPSThumbnailsSize); override;
    procedure SetZoomFactor(Value: Integer); override;

    procedure Resize; override;

    procedure CreationComplete; override;

    procedure BeginUpdate; override;
    procedure CancelUpdate; override;   
    procedure EndUpdate; override;
    function Locked: Boolean; override;

   {$IFDEF OLEDRAGANDDROP}
    function DoCanAccept: Boolean; override;
   {$ENDIF}
    
    function CanChangeMargins: Boolean;
    function CanClosePreviewWindow: Boolean; virtual;
    function CanDesign: Boolean;
    function CanLoadReport: Boolean;
    function CanPageSetup: Boolean;    
    function CanPrint: Boolean;
    function CanPrintDialog: Boolean;    
    function CanPrintStyle: Boolean;
    function CanRebuild: Boolean;
    function CanSaveReport: Boolean;
    function CanUnloadReport: Boolean;
    function IsCommandLoadReportVisible: Boolean;
    function IsCommandSaveReportVisible: Boolean;
    function IsCommandUnloadReportVisible: Boolean;
    
    procedure DoActivePageChanged(AValue: Integer);
    procedure DoClearHF;
    procedure DoDesignReport;
    procedure DoExplorerButtonsPosUpdate;
    procedure DoExplorerCreateNewFolder;
    procedure DoExplorerCreateNewItem;
    procedure DoExplorerDeleteItem;
    function DoExplorerItemShowPropertySheets: Boolean;
    procedure DoExplorerLoadItemData;
    procedure DoExplorerShowToggled(Value: Boolean);
    procedure DoExplorerRenameItem;
    procedure DoExplorerUnloadItemData;
    procedure DoFormatTitle;
    procedure DoInsertHF(const S: string);
    procedure DoInvokeHelp;
    procedure DoLoadReportLinkDataFromFile;
    procedure DoPageSetupReport(APageIndex: Integer);
    procedure DoPrintReport(AShowDialog: Boolean);
    procedure DoSaveReportLinkDataToFile;
    procedure DoSetupZoomFactor(AZoomFactor, APageXCount, APageYCount: Integer; 
      AZoomMode: TdxPreviewZoomMode);
    procedure DoShowEmptyPages(Value: Boolean);
    procedure DoShowFormatDateTimeDlg;
    procedure DoShowFormatPageNumbersDlg;
    procedure DoShowHFBackgroundDlg(const Pt: TPoint);
    procedure DoShowMultiplySelectPagesDlg(AImageList:TCustomImageList; 
      AImageIndex: Integer; const Pt: TPoint; AYShift: Integer);
    procedure DoShowOptionsDlg;
    procedure DoShowPageBackgroundDlg(const Pt: TPoint);
    procedure DoShowPageFooters(Value: Boolean);
    procedure DoShowPageHeaders(Value: Boolean);
    procedure DoShowZoomDlg;
    procedure DoShrinkToPageWidth(Value: Boolean);
    procedure DoThumbnailsToggleShow(Value: Boolean);
    procedure DoUnloadReportLinkData;

    procedure FixupPreviewWidth;
    procedure PreviewPaneResize(Sender: TObject);
    procedure ThumbnailsPreviewResize(Sender: TObject);
    procedure UpdateThumbnailsSize;
    
    function IsAutoHFTextEntriesAvailable: Boolean;
    function IsBuilding: Boolean;
    function IsEnabled(AnOption: TdxPreviewEnableOption): Boolean;
    function IsPrinting: Boolean;
    function IsProgressState: Boolean;
    function IsSizeGripActuallyShown: Boolean;
    function IsStatusTextPanel(APanel: TStatusPanel): Boolean;
    function IsVisible(AnOption: TdxPreviewVisibleOption): Boolean;
    procedure InvalidateStatusPanel(AStatusBar: TStatusBar; AIndex: Integer);
    procedure InvalidatePagesHeadersOrFooters;
    function IsMarginValueStatusPanel(APanel: TStatusPanel): Boolean;
    function MarginStatusPanel(AMargin: TdxPreviewPageMargin): TStatusPanel;
    procedure PrepareProgress;
    function ProgressBarGetMaxValue: Integer;
    procedure ProgressBarHide;
    procedure ProgressBarPlace;
    procedure ProgressBarRefresh;
    procedure ProgressBarShow;
    procedure UnprepareProgress;
    procedure RefreshStatusBar(AStatusSections: TfmPreviewStatusSections);
    procedure RefreshMarginBar(AMargin: TdxPreviewPageMargin);
    function SectionStatusPanel(AStatusSection: TfmPreviewStatusSection): TStatusPanel;
    procedure SectionStatusPanelSetText(AStatusSection: TfmPreviewStatusSection; const AText: string);
    procedure SetZoomFactorByText(const AText: string);
    procedure UpdateStatusBarPanelWidths(AStatusBar: TStatusBar);
    
    procedure LoadPropertiesFromRegistry(const APath: string);
    procedure SavePropertiesToRegistry(const APath: string);
    procedure SavePreferences(AData: TdxPreviewOptionsDlgData);
            
    procedure CreateControls; virtual;
    procedure CreateEventSubscribers; virtual;
    procedure CreateExplorerPane; virtual;
    procedure CreateExplorerSplitter; virtual;
    procedure CreateExplorerToolBar; virtual;
    procedure CreateExplorerTreeHost; virtual;
    procedure CreateMarginBar; virtual;    
    procedure CreatePreview; virtual;
    procedure CreatePreviewPane; virtual;
    procedure CreateProgressBar; virtual;
    procedure CreateStatusBar; virtual;
    procedure CreateThumbnailsPane; virtual;
    procedure CreateThumbnailsSplitter; virtual;
    procedure CreateThumbnailsPreview; virtual;
    procedure RefreshStatusPanels(AStatusBarMode: TdxPSPreviewWindowStatusBarMode); virtual;

    procedure DoAfterPrintReport(AShowDialog: Boolean); virtual;
    procedure DoPreviewAfterDragMargin(APreview: TdxPreview; AMargin: TdxPreviewPageMargin); virtual;
    procedure DoPreviewBeforeDragMargin(APreview: TdxPreview; AMargin: TdxPreviewPageMargin); virtual;
    procedure DoPreviewDblClick(APreview: TdxPreview); virtual;    
    procedure DoPreviewDragMargin(APreview: TdxPreview; AMargin: TdxPreviewPageMargin); virtual;
    procedure DoPreviewMarginChanged(APreview: TdxPreview; AMargin: TdxPreviewPageMargin); virtual;
    procedure DoPreviewZoomFactorChanged(APreview: TdxPreview); virtual;
    procedure DoPreviewZoomModeChanged(APreview: TdxPreview); virtual;
    procedure DoShowHFToolBar(Value: Boolean); virtual;
    function GetPreviewCanShowMarginHint(APreview: TdxPreview): Boolean; virtual;
    procedure HFTextEntriesChanged; virtual;
    procedure LoadStrings; virtual;
    procedure StyleListChanged(Sender: TObject); virtual;
    function ValidateMargins: Boolean; virtual;    

    { IdxPSExplorerTreeContainerHost }
    function IdxPSExplorerTreeContainerHost.GetFlat = IdxPSExplorerTreeContainerHost_GetFlat;
    function IdxPSExplorerTreeContainerHost.GetReportLink = IdxPSExplorerTreeContainerHost_GetReportLink;
    function IdxPSExplorerTreeContainerHost_GetFlat: Boolean;
    function IdxPSExplorerTreeContainerHost_GetReportLink: TBasedxReportLink;
    function GetTreeContainerParent: TWinControl;
    procedure UpdateState;
      
    property HFFunctionList: TStringList read FHFFunctionList;
    property PredefinedZooms: TStringList read FPredefinedZooms;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    function CloseQuery: Boolean; override;

    procedure GoToFirstPage; override;
    procedure GoToLastPage; override;
    procedure GoToNextPage; override;
    procedure GoToPrevPage; override;
    procedure InitContent; override;
    procedure InvalidateContent; override;
    procedure InvalidatePage(APageIndex: Integer); override;
    procedure InvalidateAllPages; override;
    procedure InvalidatePagesContent; override;
    procedure InvalidatePagesHeaderContent; override;
    procedure InvalidatePagesFooterContent; override;
    procedure LoadFromRegistry(const APath: string); override;
    procedure SaveToRegistry(const APath: string); override;    
    procedure UpdateControls; override;

    property Explorer: TCustomdxPSExplorer read GetExplorer;
    property IsExplorerAvailable: Boolean read GetIsExplorerAvailable;
    property ExplorerCloseButton: TSpeedButton read FExplorerCloseButton;
    property ExplorerPane: TPanel read FExplorerPane;
    property ExplorerPaneWidth: Integer read GetExplorerPaneWidth write SetExplorerPaneWidth;
    property ExplorerSplitter: TSplitter read FExplorerSplitter;
    property ExplorerToolBar: TPanel read FExplorerToolBar;
    property ExplorerTreeHost: TPanel read FExplorerTreeHost;
    property Flat: Boolean read GetFlat;
    property IsExplorerMode: Boolean read GetIsExplorerMode;
    property MarginBar: TStatusBar read FMarginBar;
    property Preview: TdxPreview read FPreview;
    property PreviewPane: TPanel read FPreviewPane;
    property ProgressBar: TProgressBar read FProgressBar;
    property ProgressStatusPanel: TStatusPanel read GetProgressStatusPanel;
    property PrinterPage: TdxPrinterPage read GetPrinterPage;
    property ShowMarginBar: Boolean read GetShowMarginBar write SetShowMarginBar;
    property ShowPageMargins: Boolean read GetShowPageMargins write SetShowPageMargins;
    property ShowStatusBar: Boolean read GetShowStatusBar write SetShowStatusBar;
    property StatusBar: TStatusBar read FStatusBar;
    property StatusTextPanel: TStatusPanel read GetStatusTextPanel;
    property ThumbnailsPane: TPanel read FThumbnailsPane;
    property ThumbnailsPaneWidth: Integer read GetThumbnailsPaneWidth write SetThumbnailsPaneWidth;
    property ThumbnailsPreview: TdxPreview read FThumbnailsPreview;
    property ThumbnailsSplitter: TSplitter read FThumbnailsSplitter;
  end;

  TdxPSStatusBar = class(TStatusBar)
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Resize; override;
  end;

function GetCurrentPrinterAsHint: string;
  
function AddStatusPanel(AStatusBar: TStatusBar; AAlignment: TAlignment; 
  AStyle: TStatusPanelStyle; ABevel: TStatusPanelBevel; const AText: string; 
  AWidth: Integer): TStatusPanel;
  
// runtime created component names
  
const
  sdxExplorerCloseButton = 'ExplorerCloseButton';        // Don't localize
  sdxExplorerPane = 'ExplorerPane';                      // Don't localize
  sdxExplorerSplitter = 'ExplorerSplitter';              // Don't localize
  sdxExplorerToolBar = 'ExplorerToolBar';                // Don't localize
  sdxExplorerTreeHost = 'ExplorerTreeHost';              // Don't localize
  sdxMarginBar = 'MarginBar';                            // Don't localize
  sdxPreviewControl = 'PreviewControl';                  // Don't localize
  sdxPreviewPane = 'PreviewPane';                        // Don't localize
  sdxProgressBar = 'ProgressBar';                        // Don't localize
  sdxStatusBar = 'StatusBar';                            // Don't localize
  sdxThumbnailsPane = 'ThumbnailsPane';                  // Don't localize
  sdxThumbnailsPreviewControl = 'ThumbnailsPreview';     // Don't localize
  sdxThumbnailsSplitter = 'ThumbnailsSplitter';          // Don't localize

implementation

uses
  CommCtrl, Math, Registry, Graphics, ShlObj, ShellApi,
{$IFDEF DELPHI7}
  UxTheme, Themes,
{$ENDIF}
{$IFDEF OLEDRAGANDDROP}
  ActiveX,
{$ENDIF}
  dxCore, cxClasses, dxPSRes, 
  dxPrnDev, dxPSUtl, dxPgsDlg, dxfmClr, dxfmMnPg, dxfmDTFmt, dxfmPNFmt, dxPSEngn, 
  dxPSExtDlgs, dxPSPopupMan, dxPSEvnt, dxfmZoom;

type
  TSplitterAccess = class(TSplitter);
  
function MinPreviewSize: TPoint;
begin
  Result.X := 200;
  Result.Y := 200;
end;

const
  CloseGlyphIndex = 114;
  DefaultExplorerPaneWidth: Integer = 220;
  DefaultThumbnailsPaneWidth: Integer = 400;
  PredefinedZoomValueCount: Integer = 8;
  //MinPreviewSize: TPoint = (X: 200; Y: 200);

  Bevels: array[Boolean] of TStatusPanelBevel = (pbLowered, pbNone);
  LookAndFeels: array[Boolean] of TdxPreviewLookAndFeel = (plfStandard, plfUltraFlat);
  pssAll: TfmPreviewStatusSections = [ssCurrentPage, ssPageCount, ssPaperSize, ssStatus];

  // used as registry key(value) names when storing properties in registry

  //sdxPreviewControl = 'PreviewControl';                  // Don't localize
  sdxShowMarginBar = 'MarginBar';                        // Don't localize
  sdxShowStatusBar = 'StatusBar';                        // Don't localize
  sdxExplorerVisibilityState = 'ExplorerVisibility';     // Don't localize
  sdxExplorerPaneWidth = 'ExplorerPaneWidth';            // Don't localize
  sdxThumbnailsVisibilityState = 'ThumbnailsVisibility'; // Don't localize
  sdxThumbnailsPaneWidth = 'ThumbnailsPaneWidth';        // Don't localize
  
var
  ClosePaneGlyph: TBitmap;

{function IsEscKeyPressed(AWnd: HWND): Boolean;
var
  Msg: TMsg;
begin
  Result := PeekMessage(Msg, AWnd, WM_KEYFIRST, WM_KEYLAST, PM_NOREMOVE) and
    (LoWord(Msg.wParam) = VK_ESCAPE);
end;}

{ Color Management - mostly borrowed from dxBar.pas }
  
function GetActualColor(AColor: COLORREF): COLORREF;
var
  DC: HDC;
begin
  DC := GetDC(0);
  Result := GetNearestColor(DC, AColor);
  ReleaseDC(0, DC);
end;
  
function GetLightColor(ABtnFaceColorPart, AHighlightColorPart, AWindowColorPart: Integer): TColor;
var
  ABtnFaceColor, AHighlightColor, AWindowColor: TColor;

  function GetLightIndex(ABtnFaceValue, AHighlightValue, AWindowValue: Byte): Integer;
  begin
    Result :=
      MulDiv(ABtnFaceValue, ABtnFaceColorPart, 100) +
      MulDiv(AHighlightValue, AHighlightColorPart, 100) +
      MulDiv(AWindowValue, AWindowColorPart, 100);
    if Result < 0 then Result := 0;
    if Result > 255 then Result := 255;
  end;

begin
  ABtnFaceColor := GetSysColor(COLOR_BTNFACE);
  AHighlightColor := GetSysColor(COLOR_HIGHLIGHT);
  AWindowColor := GetSysColor(COLOR_WINDOW);
  if (ABtnFaceColor = 0) or (ABtnFaceColor = $FFFFFF) then
    Result := AHighlightColor
  else
    Result := RGB(
      GetLightIndex(GetRValue(ABtnFaceColor), GetRValue(AHighlightColor), GetRValue(AWindowColor)),
      GetLightIndex(GetGValue(ABtnFaceColor), GetGValue(AHighlightColor), GetGValue(AWindowColor)),
      GetLightIndex(GetBValue(ABtnFaceColor), GetBValue(AHighlightColor), GetBValue(AWindowColor)));
end;
  
function GetUltraFlatButtonBorderColor: TColor;
begin
  Result := GetActualColor(GetLightColor(-2, 30, 20));
end;

function GetUltraFlatButtonDownedColor: TColor;
begin
  Result := GetActualColor(GetLightColor(14, 44, 40));
end;

function GetUltraFlatButtonSelColor: TColor;
begin
  Result := GetActualColor(GetLightColor(-2, 30, 72));
end;

{ flat status bars }

function GetFlatStatusPanelHighlightColor: TColor;
begin
  Result := FindNearestColor(GetLightColor(-22, 30, 72));
end;

function GetFlatStatusPanelColor: TColor;
var
  Offset: Byte;
begin
  Offset := (255 - GetGValue(ColorToRGB(clBtnFace))) div 4;
  Result := FindNearestColor(OffsetColor(clBtnFace, Offset, Offset, Offset));
end;

function GetStatusColor(AStatusBar: TStatusBar): TColor;
begin
  Result := AStatusBar.Color;
end;

function GetStatusPanelBkColor(AStatusBar: TStatusBar; AFlat, AHighlighted: Boolean): TColor;
begin
  if AHighlighted then
    if AFlat then 
      Result := GetFlatStatusPanelHighLightColor
    else
      Result := clHighLight
  else 
    if AFlat then 
      Result := GetFlatStatusPanelColor
    else
      Result := GetStatusColor(AStatusBar);
  Result := ColorToRGB(Result);
end;

function GetStatusPanelTextColor(AStatusBar: TStatusBar; AFlat, AHighlighted: Boolean): TColor;
begin
  if AFlat or not AHighlighted then 
    Result := AStatusBar.Font.Color
  else  
    Result := clHighlightText;
  Result := ColorToRGB(Result);
end;
  
type
  TdxPSExplorerToolBar = class(TPanel)
  private
    FFlat: Boolean;
    procedure SetFlat(Value: Boolean);
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
  protected
   {$IFDEF DELPHI7}
    procedure Paint; override;
   {$ENDIF} 
  public  
    property Flat: Boolean read FFlat write SetFlat;
  end;
  
  TdxPSExplorerCloseButton = class(TSpeedButton)
  private
    FUltraFlat: Boolean;
  protected
    procedure Paint; override;
  public  
    property UltraFlat: Boolean read FUltraFlat write FUltraFlat;
  end;
  
{ TdxPSExplorerToolBar }  

{$IFDEF DELPHI7}

procedure TdxPSExplorerToolBar.Paint;
var
  Details: TThemedElementDetails;
  DC: HDC;
  F: HFONT;
begin
  with ThemeServices do 
    if ThemesEnabled then
    begin
      Details := GetElementDetails(thHeaderItemLeftNormal);
      DC := Canvas.Handle;
      DrawElement(DC, Details, ClientRect, nil);
      F := SelectObject(DC, Font.Handle);
      DrawText(DC, Details, Caption, ClientRect, DT_LEFT or DT_VCENTER or DT_SINGLELINE, 0);
      SelectObject(DC, F);
    end
    else
      inherited;
end;

{$ENDIF}

procedure TdxPSExplorerToolBar.SetFlat(Value: Boolean);
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    RecreateWnd;
  end;
end;

procedure TdxPSExplorerToolBar.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  InflateRect(Message.CalcSize_Params^.rgrc[0], -1, -1);
end;

procedure TdxPSExplorerToolBar.WMNCPaint(var Message: TWMNCPaint); 
var
  DC: HDC;
  R: TRect;
begin
  GetWindowRect(Handle, R);
  OffsetRect(R, -R.Left, -R.Top);
  DC := GetWindowDC(Handle);
  try
    if Flat then
      FrameRect(DC, R, GetSysColorBrush(COLOR_BTNSHADOW))
    else
      DrawEdge(DC, R, BDR_RAISEDINNER, BF_RECT);  
  finally
    ReleaseDC(Handle, DC); 
  end;
end;

{ TdxPSExplorerCloseButton }

procedure TdxPSExplorerCloseButton.Paint;
var
  R, GlyphRect: TRect;
begin
  if UltraFlat then
  begin
    R := ClientRect;
    if MouseInControl then
      Canvas.Brush.Color := GetUltraFlatButtonBorderColor
    else
      Canvas.Brush.Color := clBtnFace;
    Canvas.FrameRect(R);
    
    InflateRect(R, -1, -1);
    if MouseInControl then
      if FState in [bsDown] then
        Canvas.Brush.Color := GetUltraFlatButtonDownedColor
      else 
        Canvas.Brush.Color := GetUltraFlatButtonSelColor
    else
      Canvas.Brush.Color := clBtnFace;
      
    Canvas.FillRect(R);
    InflateRect(R, -1, -1);
    
    with R do
    begin
      Inc(Left, 1 + (Right - Left - Glyph.Width) div 2);
      Inc(Top, 1 + (Bottom - Top - Glyph.Height) div 2);
      Right := Left + Glyph.Width;
      Bottom := Top + Glyph.Height;
    end;  
    GlyphRect := Rect(0, 0, Glyph.Width, Glyph.Height);
    Canvas.BrushCopy(R, Glyph, GlyphRect, clBtnFace);
  end
  else
    inherited;
end;
    
{ helpers }
    
function GetCurrentPrinterAsHint: string;
begin
  Result := dxPrintDevice.CurrentDevice;
  if Result <> '' then 
    Result := ' (' + Result + ')';
end;    
 
function AddStatusPanel(AStatusBar: TStatusBar; AAlignment: TAlignment; 
  AStyle: TStatusPanelStyle; ABevel: TStatusPanelBevel; const AText: string; 
  AWidth: Integer): TStatusPanel;
begin
  Result := AStatusBar.Panels.Add;
  with Result do
  begin
    Alignment := AAlignment;
    Bevel := ABevel;
    Style := AStyle;
    Text := AText;
    if (AWidth <> -1) and (AText <> '') then
    begin
      Width := AStatusBar.Canvas.TextWidth(AText);
      if Width > 0 then Width := 3 + Width + 3;
      if Width < AWidth then Width := AWidth;
    end  
    else
      Width := AWidth;
  end;
end;
 
function LoMetricToThousandthsOfInch(Value: Integer): Integer;
begin
  Result := MulDiv(Value, 1000, 254);
end;

function LoMetricToThousandthsOfMM(Value: Integer): Integer;
begin
  Result := 100 * Value;
end;

function DropPercentChar(const S: string): string;
var
  I: Integer;
begin
  I := Length(S);
  while (I > 0) and (S[I] = PercentSymbol) do Dec(I);
  Result := Copy(S, 1, I);
end;

{ TdxPSPreviewExplorerChangeNotifier }
  
constructor TdxPSPreviewExplorerChangeNotifier.Create(APreview: TCustomdxPSPreviewWindow);
begin
  FPreview := APreview;
  inherited Create(Preview.Explorer);
end;

procedure TdxPSPreviewExplorerChangeNotifier.ItemDataLoaded(AnItem: TdxPSExplorerItem);
begin
  Preview.UpdateControls;
end;

procedure TdxPSPreviewExplorerChangeNotifier.ItemDataUnloaded(AnItem: TdxPSExplorerItem);
begin
  Preview.UpdateControls;
end;

{ TCustomdxPSPreviewWindow }  

constructor TCustomdxPSPreviewWindow.Create(AOwner: TComponent);
begin
  inherited;
  FState := prsNone;
  FHFEditPart := tpLeft;
  FEnableOptions := [Low(TdxPreviewEnableOption)..High(TdxPreviewEnableOption)] - [peoHelp];
  FLastValidZoomFactor := 100;
  FVisibleOptions := [Low(TdxPreviewVisibleOption)..High(TdxPreviewVisibleOption)] - [pvoHelp];
  FSaveExplorerVisibility := evsUndefined;
  FSavePageMarginsVisibility := mvsUndefined;
  FSaveThumbnailsVisibility := tvsUndefined;
  FShowExplorer := False;
  FShowThumbnails := False;
  FSaveExplorerPaneWidth := DefaultExplorerPaneWidth;
  FSaveThumbnailsPaneWidth := DefaultThumbnailsPaneWidth;
  FThumbnailsSize := tsLarge;
end;

destructor TCustomdxPSPreviewWindow.Destroy;
begin
  dxPSPopupMan.dxPSPopupMenuController.UnregisterControl(ThumbnailsPreview);
  DoExplorerUnloadItemData;
  FreeAndNil(FExplorerChangeNotifier);
  FreeAndNil(FExplorerTree);
  FreeAndNil(FHFTextEntriesChangedSubscriber);
  FreeAndNil(FBuildEventsSubscriber);
  FreeAndNil(FPrintEventsSubscriber);
  FreeAndNil(FPredefinedZooms);
  FreeAndNil(FStyleEventsSubscriber);
  FreeAndNil(FHFFunctionList);
  inherited;
end;

procedure TCustomdxPSPreviewWindow.AfterConstruction;
begin
  FSaveZoomPosition := True;
  FShowStatusBar := True;
  FShowMarginBar := True;
  LoadZooms;
  FHFFunctionList := TStringList.Create;
  dxGetHFFunctionsList(FHFFunctionList);
  CreateControls;
  LoadStrings;
  inherited;
end;

procedure TCustomdxPSPreviewWindow.BeforeDestruction;
{$IFDEF OLEDRAGANDDROP}
var
  DropTarget: IDropTarget;
{$ENDIF}  
begin               
 {$IFDEF OLEDRAGANDDROP}
  if Supports(TObject(Self), IDropTarget, DropTarget) then
    CoLockObjectExternal(DropTarget, False, True);
  RevokeDragDrop(Preview.Handle);
 {$ENDIF}
  inherited;
end;

procedure TCustomdxPSPreviewWindow.Activate;
begin
  ActiveControl := FPreview;
  inherited;
end;

function TCustomdxPSPreviewWindow.CloseQuery: Boolean;
begin
  Result := CanClosePreviewWindow;
  if Result then 
    Result := inherited CloseQuery;
end;

procedure TCustomdxPSPreviewWindow.DoClose(var AAction: TCloseAction);
begin
  inherited;
  AAction := caFree;
end;

procedure TCustomdxPSPreviewWindow.DoShow;
begin
  inherited;
  //Bug in Win2K and ComCtl32.dll since IE 5.0 ?
  PostMessage(Handle, DXM_PS_UPDATEMARGINS, 0, 0);
end;  

procedure TCustomdxPSPreviewWindow.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_ESCAPE) and (ComponentPrinter <> nil) then
  begin
    if IsBuilding then ComponentPrinter.AbortBuilding := True;
    if IsPrinting then ComponentPrinter.AbortPrinting := True;
  end;  
end;

procedure TCustomdxPSPreviewWindow.WndProc(var Message: TMessage);
begin
  if Message.Msg = WM_DRAWITEM then
    if PDrawItemStruct(Message.lParam)^.hwndItem = StatusBar.Handle then
    begin
      StatusBar.Dispatch(Message);
      Exit;
    end;
  inherited;
  case message.Msg of 
    DXM_PS_UPDATEMARGINS: 
      UpdateMarginBar;
    DXM_PS_UPDATESTATUSPROGRESS:
      UpdateStatusText;
  end;    
end;
                  
procedure TCustomdxPSPreviewWindow.CreateControls;
{$IFDEF OLEDRAGANDDROP}
var
  DropTarget: IDropTarget;
{$ENDIF}  
begin
  CreateProgressBar;
  CreateStatusBar;
  CreateExplorerPane;
  CreateExplorerSplitter;
  CreatePreviewPane;
  CreatePreview;
  CreateMarginBar;
  CreateThumbnailsPane;
  CreateThumbnailsSplitter;
  CreateThumbnailsPreview;
  
  CreateEventSubscribers;
 {$IFDEF OLEDRAGANDDROP}
  if Supports(TObject(Self), IDropTarget, DropTarget) then
  begin
    RegisterDragDrop(Preview.Handle, DropTarget);
    CoLockObjectExternal(DropTarget, True, False);
  end;
 {$ENDIF} 
end;

procedure TCustomdxPSPreviewWindow.CreateEventSubscribers;
begin
  FPrintEventsSubscriber := TdxPSPrintReportSubscriber.Create([TdxPSPrintEvent]);
  TdxPSPrintReportSubscriber(FPrintEventsSubscriber).OnEndPrint := EndPrint;
  TdxPSPrintReportSubscriber(FPrintEventsSubscriber).OnProgressPrint := NewPage;
  TdxPSPrintReportSubscriber(FPrintEventsSubscriber).OnStartPrint := StartPrint;
  
  FBuildEventsSubscriber := TdxPSBuildReportSubscriber.Create([TdxPSBuildEvent]);  
  TdxPSBuildReportSubscriber(FBuildEventsSubscriber).OnEndGenerateReport := EndGenerateReport;
  TdxPSBuildReportSubscriber(FBuildEventsSubscriber).OnGenerateReportProgress := GenerateReportProgress;
  TdxPSBuildReportSubscriber(FBuildEventsSubscriber).OnStartGenerateReport := StartGenerateReport;

  FStyleEventsSubscriber := TdxStyleListChangedSubscriber.Create([TdxSMStyleListChangedEvent]);
  TdxStyleListChangedSubscriber(FStyleEventsSubscriber).OnStyleListChanged := StyleListChanged;
  
  FHFTextEntriesChangedSubscriber := TdxHFTextEntriesChangedSubscriber.Create([TdxHFTextEntriesChangedEvent]);
  TdxHFTextEntriesChangedSubscriber(FHFTextEntriesChangedSubscriber).OnHFTextEntriesChanged := HFTextEntriesChanged;
end;

procedure TCustomdxPSPreviewWindow.CreateExplorerPane;
const
  BevelOuters: array[Boolean] of TBevelCut = (bvLowered, bvNone);
begin
  FExplorerPane := TPanel.Create(Self);
  with ExplorerPane do 
  begin
    Parent := Self;
    Align := alLeft;
    BevelOuter := bvNone;
    BevelOuter := BevelOuters[Flat];
    BorderStyle := bsNone;      
    Caption := '';
    Name := sdxExplorerPane;
  end;  
  CreateExplorerToolBar;
  CreateExplorerTreeHost;
end;

procedure TCustomdxPSPreviewWindow.CreateExplorerSplitter;
begin
  FExplorerSplitter := TSplitter.Create(Self);
  with ExplorerSplitter do 
  begin
    Parent := Self;
    Align := alLeft;
    Left := ExplorerPane.Left + ExplorerPane.Width + 1;
    Name := sdxExplorerSplitter;
    ResizeStyle := rsUpdate;
    Width := 5;
    
    OnCanResize := ExplorerSplitterCanResize;
  end;
  TSplitterAccess(ExplorerSplitter).OnMouseUp := ExplorerSplitterMouseUp;
end;
                           
procedure TCustomdxPSPreviewWindow.CreateExplorerToolBar;

  function CalculateHeight: Integer;
  var
    DC: HDC;
    F: HFONT;
    Size: TSize;
  begin
    DC := GetDC(0);
    try
      F := SelectObject(DC, FExplorerToolBar.Font.Handle);
      GetTextExtentPoint32(DC, 'Wg', 2, Size);
      Result := MulDiv(Size.cY, 3, 2);
      SelectObject(DC, F);
    finally
      ReleaseDC(0, DC);
    end;
  end;

  procedure DoCreateToolBar;
  begin 
    FExplorerToolBar := TdxPSExplorerToolBar.Create(Self);
    with TdxPSExplorerToolBar(FExplorerToolBar) do 
    begin
      Parent := ExplorerPane;
      Align := alTop;
      Alignment := taLeftJustify;
      BevelOuter := bvNone;//bvRaised;
      BorderStyle := bsNone;
      Caption := ' ' + cxGetResourceString(@sdxExplorerCaption);
      Flat := Self.Flat;
      Height := CalculateHeight;
      Name := sdxExplorerToolBar;
      OnResize := ExplorerToolBarResize;
    end;
  end;
  
  procedure DoCreateCloseButton;
  begin 
    FExplorerCloseButton := TdxPSExplorerCloseButton.Create(Self);
    with TdxPSExplorerCloseButton(FExplorerCloseButton) do 
    begin
      Parent := FExplorerToolBar;

      Height := Parent.ClientHeight - 4;
      Width := Height + 2;
      Left := Parent.ClientWidth - Width - 1;
      Top := 1;
      
      Flat := True;
      Glyph := ClosePaneGlyph;
      Hint := cxGetResourceString(@sdxCloseExplorerHint);
     {$IFDEF DELPHI7}
       if not ThemeServices.ThemesEnabled then 
         Margin := 3;
     {$ELSE}
       Margin := 3;
     {$ENDIF} 
      Name := sdxExplorerCloseButton;
      ShowHint := True;
      Transparent := False;
      UltraFlat := Self.Flat;
      OnClick := ExplorerClose;
    end;
  end;
  
begin
  DoCreateToolBar;
  DoCreateCloseButton;
end;

procedure TCustomdxPSPreviewWindow.CreateExplorerTreeHost;
begin
  FExplorerTreeHost := TPanel.Create(Self);
  with FExplorerTreeHost do 
  begin
    Parent := ExplorerPane;
    Align := alClient;
    BevelInner := bvNone;
    BevelOuter := bvNone;
    BorderStyle := bsNone;
    Name := sdxExplorerTreeHost;
  end;
end;

procedure TCustomdxPSPreviewWindow.CreateMarginBar;
begin
  FMarginBar := TdxPSStatusBar.Create(Self);
  with FMarginBar do
  begin
    Parent := FPreviewPane;
    Align := alTop;
    Canvas.Font := Font;
    Height := 2 * GetSystemMetrics(SM_CXBORDER) + 2 * (3 + Ord(Flat)) + Canvas.TextHeight('Wq');    
    Name := sdxMarginBar;
    SizeGrip := False;
    
    OnDblClick := MarginBarDblClick;
    OnDrawPanel := MarginBarDrawPanel;
  end;                         

  AddStatusPanel(FMarginBar, taLeftJustify, psOwnerDraw, pbNone, DropAmpersand(cxGetResourceString(@sdxMargins)), 55);
  AddStatusPanel(FMarginBar, taRightJustify, psOwnerDraw, pbNone, DropAmpersand(cxGetResourceString(@sdxLeft)), 40);  
  AddStatusPanel(FMarginBar, taRightJustify, psOwnerDraw, Bevels[Flat], '', 70);    
  AddStatusPanel(FMarginBar, taRightJustify, psOwnerDraw, pbNone, DropAmpersand(cxGetResourceString(@sdxTop)), 40);        
  AddStatusPanel(FMarginBar, taRightJustify, psOwnerDraw, Bevels[Flat], '', 70);        
  AddStatusPanel(FMarginBar, taRightJustify, psOwnerDraw, pbNone, DropAmpersand(cxGetResourceString(@sdxRight)), 50); 
  AddStatusPanel(FMarginBar, taRightJustify, psOwnerDraw, Bevels[Flat], '', 70);   
  AddStatusPanel(FMarginBar, taRightJustify, psOwnerDraw, pbNone, DropAmpersand(cxGetResourceString(@sdxBottom)), 60);
  AddStatusPanel(FMarginBar, taRightJustify, psOwnerDraw, Bevels[Flat], '', 70);     
  AddStatusPanel(FMarginBar, taRightJustify, psOwnerDraw, pbNone, DropAmpersand(cxGetResourceString(@sdxHeader2)), 50); 
  AddStatusPanel(FMarginBar, taRightJustify, psOwnerDraw, Bevels[Flat], '', 70);   
  AddStatusPanel(FMarginBar, taRightJustify, psOwnerDraw, pbNone, DropAmpersand(cxGetResourceString(@sdxFooter2)), 50);
  AddStatusPanel(FMarginBar, taRightJustify, psOwnerDraw, Bevels[Flat], '', 70);     
  AddStatusPanel(FMarginBar, taRightJustify, psOwnerDraw, pbNone, '',  -1);
end;

procedure TCustomdxPSPreviewWindow.CreatePreview;
begin
  FPreview := TdxPreview.Create(Self);
  with FPreview do
  begin
    Parent := FPreviewPane;
    Align := alClient;
    LookAndFeel := LookAndFeels[Flat];
    if IsWin9X then
      OptionsBehavior := OptionsBehavior - [pobThumbTracking];    
    Name := sdxPreviewControl;
    OnCanShowMarginHint := PreviewCanShowMarginHint;
    OnDblClick := PreviewDblClick;
    OnSelectingPage := PreviewSelectingPage;
    
    TdxPreviewPageBackground(PageBackground).OnApply := FillEffectsApply;
  end;
end;

procedure TCustomdxPSPreviewWindow.CreatePreviewPane;
begin
  FPreviewPane := TPanel.Create(Self);
  with FPreviewPane do 
  begin
    Parent := Self;
    Align := alClient;
    BevelInner := bvNone;
    BevelOuter := bvNone;  
    Caption := '';
    Name := sdxPreviewPane;
    
    OnResize := PreviewPaneResize;
  end;  
end;
  
procedure TCustomdxPSPreviewWindow.CreateProgressBar;
begin
  FProgressBar := TProgressBar.Create(Self);
  with ProgressBar do
  begin
    Name := sdxProgressBar;
    BorderWidth := 2;
  end;  
end;

procedure TCustomdxPSPreviewWindow.CreateStatusBar;
begin
  FStatusBar := TdxPSStatusBar.Create(Self);
  with FStatusBar do 
  begin 
    Parent := Self;
    Canvas.Font := Font;
    Height := 2 * GetSystemMetrics(SM_CXBORDER) + 2 * (3 + Ord(Flat)) + Canvas.TextHeight('Wq');
    ShowHint := True;
    Name := sdxStatusBar;
  end;  
  RefreshStatusPanels(psbmNormal);
end;

procedure TCustomdxPSPreviewWindow.CreateThumbnailsPane;
begin
  FThumbnailsPane := TPanel.Create(Self);
  with ThumbnailsPane do
  begin
    Parent := PreviewPane;

    Align := alRight;
    BevelInner := bvNone;
    BevelOuter := bvNone;  
    Caption := '';
    Name := sdxThumbnailsPane;

    OnResize := ThumbnailsPreviewResize;
  end;
end;

procedure TCustomdxPSPreviewWindow.CreateThumbnailsSplitter;
begin
  FThumbnailsSplitter := TSplitter.Create(Self);
  with ThumbnailsSplitter do
  begin
    Parent := PreviewPane;
    Align := alRight;
    Left := FThumbnailsPane.Left - 1;
    ResizeStyle := rsUpdate;
    Width := 5;    
    Name := sdxThumbnailsSplitter;
    
    OnCanResize := ThumbnailsSplitterCanResize;
  end;
  TSplitterAccess(ThumbnailsSplitter).OnMouseUp := ThumbnailsSplitterMouseUp;
end;

procedure TCustomdxPSPreviewWindow.CreateThumbnailsPreview;
begin
  FThumbnailsPreview := TdxPreview.Create(Self);
  with ThumbnailsPreview do
  begin
    Parent := FThumbnailsPane;
    Align := alClient;
    LookAndFeel := LookAndFeels[Flat];
    MinZoomFactor := 5;
    Name := sdxThumbnailsPreviewControl;
    OptionsBehavior := OptionsBehavior + [pobNonCenterizePages];
    if IsWin9X then
      OptionsBehavior := OptionsBehavior - [pobThumbTracking];    
    OptionsView := OptionsView - [povMargins];
    OptionsZoom := OptionsZoom - [pozZoomOnClick];
    SelectionFrameThickness := 4;
    ZoomFactor := dxThumbnailsZoomFactors[ThumbnailsSize];

    OnSelectedPageChanged := ThumbnailsPreviewSelectedPageChanged;
    OnSelectingPage := PreviewSelectingPage;    
  end;
end;

procedure TCustomdxPSPreviewWindow.RefreshStatusPanels(AStatusBarMode: TdxPSPreviewWindowStatusBarMode);

  function GetProgressModeCaption: string;
  begin
    if IsBuilding then
      Result := cxGetResourceString(@sdxBuildingReportStatusText)
    else
      if IsPrinting  then
        Result := cxGetResourceString(@sdxPrintingReportStatusText)
      else
        Result := '';  
  end;

begin                 
  StatusBar.Panels.Clear;
  StatusBar.Panels.BeginUpdate;
  try
    case AStatusBarMode of
      psbmNormal:
        begin
          AddStatusPanel(StatusBar, taRightJustify, psOwnerDraw, pbNone, DropAmpersand(cxGetResourceString(@sdxPage)) +  ':', 40);
          AddStatusPanel(StatusBar, taRightJustify, psOwnerDraw, Bevels[Flat], '', 45);
          AddStatusPanel(StatusBar, taCenter, psOwnerDraw, pbNone, cxGetResourceString(@sdxOf), 30);    
          AddStatusPanel(StatusBar, taRightJustify, psOwnerDraw, Bevels[Flat], '', 45);      
          AddStatusPanel(StatusBar, taLeftJustify, psOwnerDraw, pbNone, cxGetResourceString(@sdxPages), 50);    
          AddStatusPanel(StatusBar, taLeftJustify, psOwnerDraw, Bevels[Flat], '', 4);        
          AddStatusPanel(StatusBar, taRightJustify, psOwnerDraw, pbNone, cxGetResourceString(@sdxPaperSize), 80);
          AddStatusPanel(StatusBar, taLeftJustify, psOwnerDraw, Bevels[Flat], '', 150);   
          AddStatusPanel(StatusBar, taRightJustify, psOwnerDraw, pbNone, cxGetResourceString(@sdxStatus), 60);
          AddStatusPanel(StatusBar, taLeftJustify, psOwnerDraw, Bevels[Flat], cxGetResourceString(@sdxStatusReady), -1);

          StatusBar.OnDblClick := StatusBarDblClick;
          StatusBar.OnDrawPanel := StatusBarDrawPanel;
          StatusBar.OnMouseMove := StatusBarMouseMove;
       end;
       
     psbmProgress:
       begin
          // !!! Update GetProgressStatusPanel in case of change ProgressBar Site Index

          //AddStatusPanel(StatusBar, taLeftJustify, psText, pbNone, GetProgressModeCaption, 2);
          AddStatusPanel(StatusBar, taLeftJustify, psText, pbNone, '', 300);   //ProgressBar Site
          AddStatusPanel(StatusBar, taLeftJustify, psText, pbNone, GetProgressModeCaption, -1);
          //AddStatusPanel(StatusBar, taLeftJustify, psText, pbNone, cxGetResourceString(@sdxPressEscToCancel), -1); 
          StatusBar.OnDblClick := nil;
          StatusBar.OnDrawPanel := nil;
          StatusBar.OnMouseMove := nil;
       end;
    end;
  finally
    StatusBar.Panels.EndUpdate;
  end;  
  StatusBar.Refresh;
end;

procedure TCustomdxPSPreviewWindow.BeginUpdate;
begin
  Preview.BeginUpdate;
  Inc(FUpdateCount);
end;

procedure TCustomdxPSPreviewWindow.CancelUpdate;
begin
  if FUpdateCount <> 0 then 
  begin
    Preview.CancelUpdate;
    Dec(FUpdateCount);
  end;
end;

procedure TCustomdxPSPreviewWindow.EndUpdate;
begin
  if FUpdateCount <> 0 then 
  begin
    Preview.EndUpdate;
    Dec(FUpdateCount);
    if FUpdateCount = 0 then UpdateControls;
  end;
end;

function TCustomdxPSPreviewWindow.Locked: Boolean;
begin
  Result := (FUpdateCount <> 0) or (ComponentPrinter = nil);
end;

{$IFDEF OLEDRAGANDDROP}
function TCustomdxPSPreviewWindow.DoCanAccept: Boolean;
begin
  Result := inherited DoCanAccept and IsVisible(pvoReportFileOperations);
end;
{$ENDIF}

procedure TCustomdxPSPreviewWindow.LoadZooms;
begin
  FPredefinedZooms := TStringList.Create;
  with FPredefinedZooms do
  begin
    AddObject('500' + PercentSymbol, TObject(Integer(500)));
    AddObject('200' + PercentSymbol, TObject(Integer(200)));
    AddObject('150' + PercentSymbol, TObject(Integer(150)));
    AddObject('100' + PercentSymbol, TObject(Integer(100)));
    AddObject( '75' + PercentSymbol, TObject(Integer(75)));
    AddObject( '50' + PercentSymbol, TObject(Integer(50)));
    AddObject( '25' + PercentSymbol, TObject(Integer(25)));
    AddObject( '10' + PercentSymbol, TObject(Integer(10)));
    AddObject(cxGetResourceString(@sdxPageWidth), TObject(Integer(-1)));
    AddObject(cxGetResourceString(@sdxWholePage), TObject(Integer(-1)));
    AddObject(cxGetResourceString(@sdxTwoPages), TObject(Integer(-1)));
    AddObject(cxGetResourceString(@sdxFourPages), TObject(Integer(-1)));
    AddObject(cxGetResourceString(@sdxWidenToSourceWidth), TObject(Integer(-1)));
  end;
end;

function TCustomdxPSPreviewWindow.CanClosePreviewWindow: Boolean;
begin
  Result := True;
  if not FReleased and (ComponentPrinter <> nil) then
  begin
    Result := not (IsBuilding or IsPrinting) or Application.Terminated;
    FReleased := not Application.Terminated and 
      (IsBuilding or (IsPrinting and MessageQuestion(cxGetResourceString(@sdxAbortPrinting))));
    if FReleased then ComponentPrinter.AbortPrinting := True; {1. - Abort}
  end;
end;
  
function TCustomdxPSPreviewWindow.GetActivePageIndex: Integer;
begin
  if Preview <> nil then
    Result := Preview.SelPageIndex
  else
    Result := 0;
end;

function TCustomdxPSPreviewWindow.GetBackground: TdxBackground;
begin
  if Preview <> nil then
    Result := Preview.PageBackground
  else
    Result := nil;
end;

function TCustomdxPSPreviewWindow.GetComponentPrinter: TCustomdxComponentPrinter;
begin
  Result := FComponentPrinter;
end;

function TCustomdxPSPreviewWindow.GetExplorerTree: TCustomdxPSExplorerTreeContainer;
begin
  Result := FExplorerTree;
end;

function TCustomdxPSPreviewWindow.GetState: TdxPSPreviewState;
begin
  Result := FState;
end;

function TCustomdxPSPreviewWindow.GetStatusPanelBounds(AStatusBar: TStatusBar;
  AIndex: Integer): TRect;
begin
  AStatusBar.Perform(SB_GETRECT, AIndex, Integer(@Result));
end;  

function TCustomdxPSPreviewWindow.GetThumbnailsSize: TdxPSThumbnailsSize;
begin
  Result := FThumbnailsSize;
end;
                   
function TCustomdxPSPreviewWindow.GetVisiblePageSize: TPoint;
begin
  if Preview <> nil then
    Result := Preview.VisiblePageSize
  else
    Result := Point(0, 0);
end;

function TCustomdxPSPreviewWindow.GetZoomFactor: Integer;
begin
  if Preview <> nil then
    Result := Preview.ZoomFactor
  else
    Result := 100;
end;

function TCustomdxPSPreviewWindow.GetExplorer: TCustomdxPSExplorer;
begin
  if ComponentPrinter <> nil then
    Result := ComponentPrinter.Explorer
  else
    Result := nil;
end;

function TCustomdxPSPreviewWindow.GetExplorerPaneWidth: Integer;
begin
  if ExplorerPane <> nil then 
    Result := ExplorerPane.Width
  else
    Result := 0;
end;

function TCustomdxPSPreviewWindow.GetFlat: Boolean;
begin
  Result := (dxPSEngine.LookAndFeel in [pslfFlat, pslfOffice11])
   {$IFDEF DELPHI7}
    and (not dxPSEngine.UseNativeLookAndFeel or not ThemeServices.ThemesEnabled)
   {$ENDIF}; 
end;

function TCustomdxPSPreviewWindow.GetIsExplorerAvailable: Boolean;
begin
  Result := Explorer <> nil;
end;

function TCustomdxPSPreviewWindow.GetIsExplorerMode: Boolean;
begin
  Result := (ComponentPrinter <> nil) and (ComponentPrinter.Explorer <> nil);//Mode = cpmExplorer);
end;

function TCustomdxPSPreviewWindow.GetPrinterPage: TdxPrinterPage;
begin
  if ReportLink <> nil then
    Result := ReportLink.RealPrinterPage
  else
    Result := nil;
end;

function TCustomdxPSPreviewWindow.GetPreviewEnableOptions: TdxPreviewEnableOptions;
begin
  Result := FEnableOptions;
end;

function TCustomdxPSPreviewWindow.GetPreviewVisibleOptions: TdxPreviewVisibleOptions;
begin
  Result := FVisibleOptions;
end;

function TCustomdxPSPreviewWindow.GetHFEditPart: TdxPageTitlePart;
begin
  Result := FHFEditPart;
end;

function TCustomdxPSPreviewWindow.GetPageCount: Integer;
begin
  if Preview <> nil then 
    Result := Preview.PageCount
  else
    Result := 0;
end;

function TCustomdxPSPreviewWindow.GetSaveZoomPosition: Boolean;
begin
  Result := FSaveZoomPosition;
end;

function TCustomdxPSPreviewWindow.GetShowExplorer: Boolean;
begin
  Result := FShowExplorer;
end;

function TCustomdxPSPreviewWindow.GetShowThumbnails: Boolean;
begin
  Result := FShowThumbnails;
end;

function TCustomdxPSPreviewWindow.GetProgressStatusPanel: TStatusPanel;
begin
  //with StatusBar do 
    Result := StatusBar.Panels[0];
end;

function TCustomdxPSPreviewWindow.GetShowMarginBar: Boolean;
begin
  Result := FShowMarginBar;
end;

function TCustomdxPSPreviewWindow.GetShowPageMargins: Boolean;
begin
  Result := pvoPageMargins in VisibleOptions;
end;

function TCustomdxPSPreviewWindow.GetShowStatusBar: Boolean;
begin
  Result := FShowStatusBar;
end;

function TCustomdxPSPreviewWindow.GetStatusTextPanel: TStatusPanel;
begin
  with StatusBar do 
    Result := Panels[Panels.Count - 1];
end;

function TCustomdxPSPreviewWindow.GetThumbnailsPaneWidth: Integer;
begin
  if ThumbnailsPane <> nil then 
    Result := ThumbnailsPane.Width
  else
    Result := 0;
end;

procedure TCustomdxPSPreviewWindow.SetActivePageIndex(Value: Integer);
begin
  if Preview <> nil then 
    Preview.SelPageIndex := Value;
end;

procedure TCustomdxPSPreviewWindow.SetState(const Value: TdxPSPreviewState);
begin
  FState := Value;
end;

procedure TCustomdxPSPreviewWindow.SetThumbnailsSize(const Value: TdxPSThumbnailsSize);
begin
  if FThumbnailsSize <> Value then
  begin
    FThumbnailsSize := Value;
    UpdateThumbnailsSize;
    UpdateControls;
  end;
end;

procedure TCustomdxPSPreviewWindow.SetZoomFactor(Value: Integer);
begin
  if Preview <> nil then 
    Preview.ZoomFactor := Value;
end;

procedure TCustomdxPSPreviewWindow.CreationComplete;
begin
  inherited;
  if FSavePageMarginsVisibility <> mvsUndefined then
    ShowPageMargins := FSavePageMarginsVisibility = mvsShown;
end;

procedure TCustomdxPSPreviewWindow.Resize;
begin
  inherited Resize;
  if FStatusBar <> nil then
    FStatusBar.Invalidate;
end;

procedure TCustomdxPSPreviewWindow.SetBackground(const Value: TdxBackground);
begin
  if Preview <> nil then 
    Preview.PageBackground := Value;
  UpdateControls;
end;

procedure TCustomdxPSPreviewWindow.SetComponentPrinter(const Value: TCustomdxComponentPrinter);
var
  ExplorerTreeContainerHost: IdxPSExplorerTreeContainerHost;
  ExplorerContextCommands: IdxPSExplorerContextCommands;
  ExplorerContextCommandBuilder: IdxPSExplorerContextCommandBuilder;
begin
  FComponentPrinter := Value;
  if ComponentPrinter = nil then Exit;

  { Preview }
  SaveZoomPosition := ComponentPrinter.PreviewOptions.SaveZoomPosition;
  with Preview do 
  begin
    OnDrawPageContent := PaintPage;
    OnCalcPageCount := PreviewCalcPageCount;
    OnSelectedPageChanged := PreviewSelectedPageChanged;
    OnAfterDragMargin := PreviewAfterDragMargin;
    OnBeforeDragMargin := PreviewBeforeDragMargin;
    OnDragMargin := PreviewDragMargin;
    OnMarginChanged := PreviewMarginsChanged;
    OnZoomFactorChanged := PreviewZoomFactorChanged;
    OnZoomModeChanged := PreviewZoomModeChanged;
  end;
  
  { Thumbnails }
  with ThumbnailsPreview do 
  begin
    OnDrawPageContent := PaintThumbnailPage;
    OnCalcPageCount := PreviewCalcPageCount;
  end;
  if FSaveThumbnailsPaneWidth <> -1 then
    ThumbnailsPaneWidth := FSaveThumbnailsPaneWidth;
  ShowThumbnails := FSaveThumbnailsVisibility = tvsShown;
  DoThumbnailsToggleShow(ShowThumbnails);
  
  { Explorer }
  ExplorerPane.Visible := IsExplorerAvailable;
  if FSaveExplorerPaneWidth <> -1 then 
    ExplorerPaneWidth := FSaveExplorerPaneWidth;
  FExplorerSplitter.Visible := IsExplorerAvailable;
  if IsExplorerAvailable and Supports(TObject(Self), IdxPSExplorerTreeContainerHost, ExplorerTreeContainerHost) then 
  begin
    FExplorerTree := Explorer.CreateTree(ExplorerTreeContainerHost); 
    Explorer.BuildTree(ExplorerTree);
    FExplorerChangeNotifier := TdxPSPreviewExplorerChangeNotifier.Create(Self);
  end;
  if IsExplorerAvailable and
    Supports(TObject(Explorer), IdxPSExplorerContextCommands, ExplorerContextCommands) and
    Supports(TObject(Self), IdxPSExplorerContextCommandBuilder, ExplorerContextCommandBuilder) then 
    ExplorerContextCommands.BuildCommandSet(ExplorerContextCommandBuilder);
  
  ShowExplorer := IsExplorerAvailable and (FSaveExplorerVisibility = evsShown);
  DoExplorerShowToggled(ShowExplorer);
   
  InitContent;
  UpdateControls;
  FAreMarginsValid := ValidateMargins;
  StyleListChanged(ReportLink.StyleManager);  
end;

procedure TCustomdxPSPreviewWindow.SetHFEditPart(const Value: TdxPageTitlePart);
begin
  FHFEditPart := Value;
end;

procedure TCustomdxPSPreviewWindow.SetPageCount(Value: Integer);
begin
  if Preview <> nil then 
    Preview.PageCount := Value;
  if ThumbnailsPreview <> nil then 
    ThumbnailsPreview.PageCount := Value;  
end;

procedure TCustomdxPSPreviewWindow.SetPreviewEnableOptions(const Value: TdxPreviewEnableOptions);
begin
  FEnableOptions := Value;
  if (ReportLink <> nil) and not ReportLink.CheckToDesign then
    FEnableOptions := FEnableOptions - [peoReportDesign];
  UpdateControls;
end;

procedure TCustomdxPSPreviewWindow.SetPreviewVisibleOptions(const Value: TdxPreviewVisibleOptions);
begin
  FVisibleOptions := Value;
  if FPreview <> nil then 
  begin
    with FPreview do 
      if pvoPageMargins in FVisibleOptions then 
        OptionsView := OptionsView + [povMargins]
      else
        OptionsView := OptionsView - [povMargins];
    UpdateControls;
  end;  
end;

procedure TCustomdxPSPreviewWindow.SetSaveZoomPosition(Value: Boolean);
begin
  FSaveZoomPosition := Value;
  if FPreview <> nil then 
    if SaveZoomPosition then 
      FPreview.OptionsStore := FPreview.OptionsStore + [posZoom]
    else
      FPreview.OptionsStore := FPreview.OptionsStore - [posZoom];
end;

procedure TCustomdxPSPreviewWindow.SetShowExplorer(Value: Boolean);
begin
  if IsExplorerAvailable then 
  begin
    if FShowExplorer <> Value then
    begin
      FShowExplorer := Value;
      DoExplorerShowToggled(FShowExplorer);
    end;
  end
  else
    FShowExplorer := False;  
end;

procedure TCustomdxPSPreviewWindow.SetShowThumbnails(Value: Boolean);
begin
  if FShowThumbnails <> Value then
  begin
    FShowThumbnails := Value;
    DoThumbnailsToggleShow(FShowThumbnails);
  end;
end;

procedure TCustomdxPSPreviewWindow.SetExplorerPaneWidth(Value: Integer);
begin
  if ExplorerPane <> nil then 
    ExplorerPane.Width := Value;
end;

procedure TCustomdxPSPreviewWindow.SetShowMarginBar(Value: Boolean);
begin
  if FShowMarginBar <> Value then
  begin
    FShowMarginBar := Value;
    if not (csLoading in ComponentState) then UpdateControls;
  end;
end;

procedure TCustomdxPSPreviewWindow.SetShowPageMargins(Value: Boolean);
begin
  if (pvoPageMargins in VisibleOptions) <> Value then
    if Value then
      VisibleOptions := VisibleOptions + [pvoPageMargins]
    else   
      VisibleOptions := VisibleOptions - [pvoPageMargins];
end;

procedure TCustomdxPSPreviewWindow.SetShowStatusBar(Value: Boolean);
begin
  if FShowStatusBar <> Value then
  begin
    FShowStatusBar := Value;
    UpdateControls;
  end;
end;

procedure TCustomdxPSPreviewWindow.SetThumbnailsPaneWidth(Value: Integer);
begin
  if ThumbnailsPane <> nil then 
    ThumbnailsPane.Width := Value;
end;

procedure TCustomdxPSPreviewWindow.GoToFirstPage;
begin
  if Preview <> nil then 
    Preview.SelectFirstPage;
end;

procedure TCustomdxPSPreviewWindow.GoToLastPage;
begin
  if Preview <> nil then 
    Preview.SelectLastPage;
end;

procedure TCustomdxPSPreviewWindow.GoToNextPage;
begin
  if Preview <> nil then 
    Preview.SelectNextPage;
end;

procedure TCustomdxPSPreviewWindow.GoToPrevPage;
begin
  if Preview <> nil then 
    Preview.SelectPrevPage;
end;

procedure TCustomdxPSPreviewWindow.HFTextEntriesChanged;
begin
end;

procedure TCustomdxPSPreviewWindow.LoadStrings;
begin
  with FStatusBar do 
  begin
    Panels[0].Text := DropAmpersand(cxGetResourceString(@sdxPage)) + ':';
    Panels[2].Text := LowerCase(cxGetResourceString(@sdxOf));
    Panels[4].Text := cxGetResourceString(@sdxPages);
    Panels[6].Text := cxGetResourceString(@sdxPaperSize);
    Panels[8].Text := cxGetResourceString(@sdxStatus);
    Panels[9].Text := cxGetResourceString(@sdxStatusReady);
  end;  
end;

procedure TCustomdxPSPreviewWindow.StyleListChanged(Sender: TObject);
begin
end;

function  TCustomdxPSPreviewWindow.ValidateMargins: Boolean;
begin
  Result := (PrinterPage = nil) or PrinterPage.ValidateMargins;
end;

{ IdxPSExplorerTreeContainerHost }

function TCustomdxPSPreviewWindow.IdxPSExplorerTreeContainerHost_GetFlat: Boolean;
begin
  Result := Flat;
end;

function TCustomdxPSPreviewWindow.IdxPSExplorerTreeContainerHost_GetReportLink: TBasedxReportLink;
begin
  Result := Self.ReportLink;
end;

function TCustomdxPSPreviewWindow.GetTreeContainerParent: TWinControl;
begin
  Result := FExplorerTreeHost;
end;

procedure TCustomdxPSPreviewWindow.UpdateState;
var
  Item: TCustomdxPSExplorerItem;
begin
  if not (csDestroying in ComponentState) then 
  begin
    Item := ExplorerTree.FocusedItem;
    if Item is TdxPSExplorerFolder then
      ComponentPrinter.Explorer.ActiveFolder := TdxPSExplorerFolder(Item)
    else  
      ComponentPrinter.Explorer.ActiveFolder := nil;
    UpdateControls;
  end;  
end;

procedure TCustomdxPSPreviewWindow.InitContent;
const
  PreviewPaperOrientationMap: array[TdxPrinterOrientation] of TdxPreviewPaperOrientation = (ppoPortrait, ppoLandscape);
var
  Link: TBasedxReportLink;
  Page: TdxPrinterPage;
  R: TRect;
begin
  Link := ReportLink;
  Page := PrinterPage;
  FPreview.OriginalPageSize.Point := Page.PageSizeLoMetric;
  if not Page.AutoSwapMargins then
    FPreview.OptionsBehavior := FPreview.OptionsBehavior - [pobAutoSwapMargins];
  FPreview.Orientation := TdxPreviewPaperOrientation(Page.Orientation);
  FPreview.MinUsefulSize := Point(Page.MinPrintableAreaLoMetric, Page.MinPrintableAreaLoMetric);
  FPreview.PageCount := Link.VisiblePageCount;
  if FThumbnailsPreview <> nil then
  begin 
    FThumbnailsPreview.PageCount := Link.VisiblePageCount;
    FThumbnailsPreview.Orientation := PreviewPaperOrientationMap[Link.RealPrinterPage.Orientation];
  end;
  FPreview.MaxZoomFactor := 500;
  FPreview.MinZoomFactor := 10;
  FPreview.MinHeaderSize := 0;
  FPreview.MinFooterSize := 0;
  
  FPreview.MeasurementUnits := TdxPreviewMeasurementUnits(Page.MeasurementUnits);
  R := Page.MinMarginsLoMetric;
  FPreview.Margins.Left.MinValue := R.Left;
  FPreview.Margins.Top.MinValue := R.Top;
  FPreview.Margins.Right.MinValue := R.Right;
  FPreview.Margins.Bottom.MinValue := R.Bottom;

  R := Page.MarginsLoMetric;
  FPreview.Margins.Header.Value := Page.HeaderLoMetric;
  FPreview.Margins.Footer.Value := Page.FooterLoMetric;
  FPreview.Margins.Left.Value := R.Left;
  FPreview.Margins.Top.Value := R.Top;
  FPreview.Margins.Right.Value := R.Right;
  FPreview.Margins.Bottom.Value := R.Bottom;
  FPreview.MinFooterSize := 0;
  FPreview.MinHeaderSize := 0;
  FPreview.PageBackground := Page.Background;

  if not SaveZoomPosition then FPreview.ZoomFactor := 100;
  HFTextEntriesChanged;

  UpdateStatusText;
end;

procedure TCustomdxPSPreviewWindow.InvalidateContent;
begin
  if Preview <> nil then Preview.Invalidate;
  if ThumbnailsPreview <> nil then ThumbnailsPreview.Invalidate;
end;

procedure TCustomdxPSPreviewWindow.InvalidatePage(APageIndex: Integer);
begin
  if Preview <> nil then 
    Preview.InvalidatePage(APageIndex);
  if ThumbnailsPreview <> nil then 
    ThumbnailsPreview.InvalidatePage(APageIndex);
end;

procedure TCustomdxPSPreviewWindow.InvalidateAllPages;
begin
  if Preview <> nil then 
    Preview.InvalidatePages;
  if ThumbnailsPreview <> nil then 
    ThumbnailsPreview.InvalidatePages;
end;

procedure TCustomdxPSPreviewWindow.InvalidatePagesContent;
begin
  if Preview <> nil then 
    Preview.InvalidatePagesContent;
  if ThumbnailsPreview <> nil then 
    ThumbnailsPreview.InvalidatePagesContent;
end;

procedure TCustomdxPSPreviewWindow.InvalidatePagesHeaderContent;
begin
  if Preview <> nil then 
    Preview.InvalidatePagesHeader;
  if ThumbnailsPreview <> nil then 
    ThumbnailsPreview.InvalidatePagesHeader;
end;

procedure TCustomdxPSPreviewWindow.InvalidatePagesFooterContent;
begin
  if Preview <> nil then 
    Preview.InvalidatePagesFooter;
  if ThumbnailsPreview <> nil then 
    ThumbnailsPreview.InvalidatePagesFooter;
end;

procedure TCustomdxPSPreviewWindow.UpdateControls;
begin
  if Locked then Exit;
  inherited;
  BeginUpdate;
  try
    if CanChangeMargins then 
      Preview.OptionsBehavior := Preview.OptionsBehavior + [pobAllowDragMargins]
    else  
      Preview.OptionsBehavior := Preview.OptionsBehavior - [pobAllowDragMargins];    
  
    RefreshStatusBar(pssAll);
    RefreshMarginBar(nil);

    FMarginBar.Visible := ShowMarginBar;
    FStatusBar.Visible := ShowStatusBar;
    FMarginBar.ShowHint := CanChangeMargins;  

    //if ComponentPrinter <> nil then
    //   Preview.Enabled := not (cpsPrinting in ComponentPrinter.State);
  finally
    CancelUpdate;
  end;  
end;

// event handlers

procedure TCustomdxPSPreviewWindow.ExplorerClose(Sender: TObject);
begin
  ShowExplorer := False;
end;

procedure TCustomdxPSPreviewWindow.ExplorerSplitterCanResize(Sender: TObject; 
  var NewSize: Integer; var Accept: Boolean);

  function CalculateNewSize: Integer;
  begin
    Result := ExplorerSplitter.Parent.ClientWidth - MinPreviewSize.X - ExplorerSplitter.Width;
  end;
  
var
  Size: Integer;  
begin
  Accept := PreviewPane.Width >= MinPreviewSize.X;
  Size := CalculateNewSize;
  if NewSize > Size then 
    NewSize := Size;
end;  

procedure TCustomdxPSPreviewWindow.ExplorerSplitterMouseUp(Sender: TObject; 
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if ExplorerPane.Width <> 0 then
    FSaveExplorerPaneWidth := ExplorerPane.Width;
end;

procedure TCustomdxPSPreviewWindow.ExplorerToolBarResize(Sender: TObject);
begin
  DoExplorerButtonsPosUpdate;
end;

procedure TCustomdxPSPreviewWindow.DrawStatusFrame(AStatusBar: TStatusBar; var R: TRect);
begin
  with AStatusBar.Canvas do
  begin
    Brush.Color := GetStatusColor(AStatusBar);
    FillRect(Rect(R.Left, R.Bottom - 1, R.Right, R.Bottom));
    
    Dec(R.Bottom);
    Brush.Color := clBtnShadow;
    FrameRect(R);
  end;  
  InflateRect(R, -1, -1);
end;

procedure TCustomdxPSPreviewWindow.DrawStatusText(AStatusBar: TStatusBar;
  APanel: TStatusPanel; const R: TRect; AHighlighted, AMarginBar: Boolean);
const
  BrushStyles: array[Boolean] of TBrushStyle = (bsClear, bsSolid);
var
  S: string;
  W, X, Y: Integer;
begin
  with AStatusBar.Canvas do
  begin
    Font.Color := GetStatusPanelTextColor(AStatusBar, Flat, AHighlighted);
    if AMarginBar and IsMarginValueStatusPanel(APanel) then
      Brush.Color := GetStatusPanelBkColor(AStatusBar, Flat, AHighlighted)
    else
      Brush.Color := AStatusBar.Color;
    Brush.Style := BrushStyles[AHighlighted or Flat];

    S := APanel.Text;
    W := TextWidth(S);
    with R do 
    begin
      if W > Right - Left - 2 then 
        W := Right - Left - 2;
      X := Right - W - 1;
      if X < Left + 1 then 
        X := Left + 1;
      Y := Top + 1 + Byte(not Flat);
    end;  
    TextRect(R, X, Y, S);
  end;  
end;
  
procedure TCustomdxPSPreviewWindow.FillEffectsApply(Sender: TObject);
begin
  FPreview.PageBackground := TdxBackground(Sender);
  UpdateControls;
end;

procedure TCustomdxPSPreviewWindow.PreviewMarginsChanged(Sender: TObject; AMargin: TdxPreviewPageMargin);
var
  V: Integer;
begin
  if Locked then Exit;
  
  V := AMargin.Value;
  case FPreview.ActualMeasurementUnits of
    pmuInches:
      V := LoMetricToThousandthsOfInch(V);
    pmuMillimeters:
      V := LoMetricToThousandthsOfMM(V);
  end;
    
  if PrinterPage <> nil then
    if AMargin is TdxPreviewPageMarginLeft then
      PrinterPage.Margins.Left := V
    else if AMargin is TdxPreviewPageMarginTop then
      PrinterPage.Margins.Top := V
    else if AMargin is TdxPreviewPageMarginRight then
      PrinterPage.Margins.Right := V
    else if AMargin is TdxPreviewPageMarginBottom then
      PrinterPage.Margins.Bottom := V
    else if AMargin is TdxPreviewPageMarginFooter then
      PrinterPage.Footer := V
    else if AMargin is TdxPreviewPageMarginHeader then
      PrinterPage.Header := V;

  DoPreviewMarginChanged(TdxPreview(Sender), AMargin);
end;

procedure TCustomdxPSPreviewWindow.PreviewAfterDragMargin(Sender: TObject; AMargin: TdxPreviewPageMargin);
begin
  DoPreviewAfterDragMargin(TdxPreview(Sender), AMargin);
  UpdateControls;
end;

procedure TCustomdxPSPreviewWindow.PreviewBeforeDragMargin(Sender: TObject; AMargin: TdxPreviewPageMargin);
begin
  DoPreviewBeforeDragMargin(TdxPreview(Sender), AMargin);
  UpdateControls;
end;

procedure TCustomdxPSPreviewWindow.PreviewDragMargin(Sender: TObject; AMargin: TdxPreviewPageMargin);
begin
  DoPreviewDragMargin(TdxPreview(Sender), AMargin);  
end;

procedure TCustomdxPSPreviewWindow.PreviewCalcPageCount(Sender: TObject);
begin
  if ReportLink <> nil then
  begin
    Preview.PageCount := ReportLink.VisiblePageCount;
    if Preview.DraggingMargin = nil then UpdateControls;

    ThumbnailsPreview.PageCount := Preview.PageCount;
  end;
end;
  
procedure TCustomdxPSPreviewWindow.PreviewZoomFactorChanged(Sender: TObject);
begin
  DoPreviewZoomFactorChanged(TdxPreview(Sender));
end;

procedure TCustomdxPSPreviewWindow.PreviewZoomModeChanged(Sender: TObject);
begin
  DoPreviewZoomModeChanged(TdxPreview(Sender));
end;

procedure TCustomdxPSPreviewWindow.PreviewCanShowMarginHint(Sender: TObject;
  var ACanShowHint: Boolean);
begin
  ACanShowHint := GetPreviewCanShowMarginHint(TdxPreview(Sender));
end;

procedure TCustomdxPSPreviewWindow.PreviewSelectingPage(Sender: TObject; 
  APageIndex: Integer; var ACanSelect: Boolean);
begin
  if (ReportLink <> nil) and ReportLink.ShowEmptyPages and ReportLink.IsEmptyPage(APageIndex) then 
    ACanSelect := False;
end;  

procedure TCustomdxPSPreviewWindow.PreviewSelectedPageChanged(Sender: TObject; APageIndex: Integer);
begin
  if ReportLink <> nil then
    ReportLink.CurrentPage := ReportLink.VirtualPageIndexToRealPageIndex(APageIndex) + 1;

  //SectionStatusPanel(ssCurrentPage).Text := IntToStr(ReportLink.CurrentPage);      
  UpdateControls;
  FStatusBar.Update;
  if not FLockPageSelection then 
  begin
    if (APageIndex = -1) and (ThumbnailsPreview.PageCount <> 0) then 
      APageIndex := 0;
    ThumbnailsPreview.SelPageIndex := APageIndex;
  end;  
end;

procedure TCustomdxPSPreviewWindow.PreviewDblClick(Sender: TObject);
var
  HitTests: TdxPreviewHitTests;
  Pt: TPoint;
begin
  DoPreviewDblClick(TdxPreview(Sender));
  GetCursorPos(Pt);
  Pt := FPreview.ScreenToClient(Pt);
  HitTests := FPreview.GetHitInfoAt(Pt.X, Pt.Y);
  if (phtNoWhere in HitTests) and CanDesign then
    DoDesignReport
  else 
    if (HitTests * phtMargins <> []) and CanChangeMargins and CanPageSetup then
      DoPageSetupReport(1);
end;

procedure TCustomdxPSPreviewWindow.StatusBarDblClick(Sender: TObject);
var
  R: TRect;
  Pt: TPoint;
begin
  if CanPageSetup then 
  begin
    R := GetStatusPanelBounds(StatusBar, 7);
    MapWindowPoints(StatusBar.Handle, 0, R, 2);
    GetCursorPos(Pt);
    if PtInRect(R, Pt) then DoPageSetupReport(0);
  end;
end;
                              
procedure TCustomdxPSPreviewWindow.StatusBarDrawPanel(StatusBar: TStatusBar; 
  Panel: TStatusPanel; const Rect: TRect);
 
  function GetStatusColor: TColor;
  begin
    if ValidateMargins then              
      Result := clBtnFace
    else
      Result := clInfoBk;  
  end;
  
  procedure DrawStatusStateText(const R: TRect);
  var
    X, Y: Integer;
  begin
    with StatusBar.Canvas do
    begin
      Brush.Color := GetStatusColor;
      FillRect(R);
      Brush.Style := bsClear;
      X := R.Left + 2; 
      Y := R.Top + (R.Bottom - R.Top - TextHeight('Wg')) div 2;
      TextRect(R, X, Y, Panel.Text);
      Brush.Style := bsSolid;
    end;
  end;
    
const
  FramedPanelIndexes: set of Byte = [1, 3, 5, 7, 9];
var
  R: TRect;
begin       
  R := Rect;
  if Flat and (Panel.Index in FramedPanelIndexes) then
  begin 
    if IsSizeGripActuallyShown and (Panel.Index = StatusBar.Panels.Count - 1) then
      Dec(R.Right, GetSystemMetrics(SM_CXVSCROLL));
    DrawStatusFrame(StatusBar, R);
  end;  
  if IsStatusTextPanel(Panel) then
    DrawStatusStateText(R) 
  else
    DrawStatusText(StatusBar, Panel, R, False, False); 
end;

procedure TCustomdxPSPreviewWindow.StatusBarMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
const 
  PtInRect: Boolean = False;
var 
  R: TRect;
  Pt: TPoint;
begin
  if CanPageSetup then
  begin
    R := GetStatusPanelBounds(StatusBar, 7);
    Pt := Point(X, Y);
    if Windows.PtInRect(R, Pt) xor PtInRect then
    begin 
      PtInRect := not PtInRect;
      Application.CancelHint;
      if PtInRect then 
        StatusBar.Hint := cxGetResourceString(@sdxHintDoubleClickForChangePaperSize)
      else 
        StatusBar.Hint := '';
    end;  
  end;  
end;

procedure TCustomdxPSPreviewWindow.ThumbnailsPreviewSelectedPageChanged(Sender: TObject; 
  APageIndex: Integer);
begin
  if FLockPageSelection then Exit;

  FLockPageSelection := True;
  try
    Preview.SelPageIndex := APageIndex;
  finally
    FLockPageSelection := False;
  end;  
end;

procedure TCustomdxPSPreviewWindow.ThumbnailsSplitterCanResize(Sender: TObject; 
  var NewSize: Integer; var Accept: Boolean);

  function CalculateNewSize: Integer;
  begin
    Result := ThumbnailsSplitter.Parent.ClientWidth - MinPreviewSize.X - ThumbnailsSplitter.Width;
  end;
  
var
  Size: Integer;  
begin
  Accept := Preview.Width >= MinPreviewSize.X;
  Size := CalculateNewSize;
  if NewSize > Size then NewSize := Size;
end;  
  
procedure TCustomdxPSPreviewWindow.ThumbnailsSplitterMouseUp(Sender: TObject; 
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if ThumbnailsPane.Width <> 0 then
    FSaveThumbnailsPaneWidth := ThumbnailsPane.Width;
end;  

procedure TCustomdxPSPreviewWindow.MarginBarDblClick(Sender: TObject);
begin
  if CanPageSetup then DoPageSetupReport(1);
end;

procedure TCustomdxPSPreviewWindow.MarginBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);

  function IsHighlighted: Boolean;
  begin
    Result := (Preview.DraggingMargin <> nil) and (MarginStatusPanel(Preview.DraggingMargin) = Panel);
  end;
  
var
  R: TRect;  
begin           
  R := Rect;
  if Flat and IsMarginValueStatusPanel(Panel) then 
    DrawStatusFrame(StatusBar, R);
  DrawStatusText(StatusBar, Panel, R, IsHighlighted, True);
end;

procedure TCustomdxPSPreviewWindow.DoShowFormatDateTimeDlg;
begin
  if ReportLink.ShowDateTimeFormatsDlg then
  begin
    Preview.InvalidatePagesHeader;
    Preview.InvalidatePagesFooter;
  end;
end;

procedure TCustomdxPSPreviewWindow.DoShowFormatPageNumbersDlg;
begin
  if ReportLink.ShowPageNumberFormatsDlg then 
  begin
    Preview.InvalidatePagesHeader;
    Preview.InvalidatePagesFooter;
  end;
end;

procedure TCustomdxPSPreviewWindow.DoShowHFToolBar(Value: Boolean);
begin
end;

procedure TCustomdxPSPreviewWindow.DoShowZoomDlg;
begin
  dxZoomDlg(Preview);
end;

procedure TCustomdxPSPreviewWindow.DoShowPageBackgroundDlg(const Pt: TPoint);
begin
  if dxChooseBackgroundDlg(Preview.PageBackground, Pt, dxDefaultBackgroundDlgData) then
    if PrinterPage <> nil then
      PrinterPage.Background := Preview.PageBackground;
end;

procedure TCustomdxPSPreviewWindow.DoShowMultiplySelectPagesDlg(AImageList: TCustomImageList;
  AImageIndex: Integer; const Pt: TPoint; AYShift: Integer);
var
  Origin: TPoint;
  MaxColCount, MaxRowCount, ColCount, RowCount: Integer;  
begin
  Origin := Pt;
  Inc(Origin.Y, AYShift);
  MaxColCount := 
     Floor((FPreview.ClientWidth - 2 * FPreview.Indent) /
           (FPreview.Indent + MulDiv(FPreview.PageSize.X, FPreview.MinZoomFactor, 100)));
//  AMaxColCount := (MulDiv(Preview.ClientWidth, 100, Preview.ZoomFactor) - dxPreviewIndent) div
//     (MulDiv(Preview.PageSize.X, 10, 100) + dxPreviewIndent);
  MaxRowCount := 
    Floor((FPreview.ClientHeight - 2 * FPreview.Indent) /
          (FPreview.Indent + MulDiv(FPreview.PageSize.Y, FPreview.MinZoomFactor, 100)));
    
  if MaxColCount = 0 then MaxColCount := 1;
  if MaxRowCount = 0 then MaxRowCount := 1;
  if MaxColCount > 3 then 
    ColCount := 3
  else 
    ColCount := MaxColCount;
  if MaxRowCount > 2 then 
    RowCount := 2
  else 
    RowCount := MaxRowCount;
    
  if dxChooseMultiplePages(AImageList, AImageIndex, Origin, AYShift, 
    MaxColCount, MaxRowCount, ColCount, RowCount) then
  begin
    FPreview.ZoomMode := pzmPages;
    FPreview.SetPageXYCount(ColCount, RowCount);
  end;
end;

procedure TCustomdxPSPreviewWindow.DoShowEmptyPages(Value: Boolean);
begin
  if ReportLink <> nil then
  begin
    ReportLink.ShowEmptyPages := Value;
    if FPreview.PageCount <> ReportLink.VisiblePageCount then 
    begin
      FPreview.PageCount := ReportLink.VisiblePageCount;
      if ThumbnailsPreview <> nil then
        ThumbnailsPreview.PageCount := ReportLink.VisiblePageCount;
    end
    else
      FPreview.Invalidate;
  end;    
  UpdateControls;  
end;

procedure TCustomdxPSPreviewWindow.DoShowOptionsDlg;
var
  Data: TdxPreviewOptionsDlgData;
begin
  FillChar(Data, SizeOf(TdxPreviewOptionsDlgData), 0);
  with Data do 
  begin
    MarginColor := Preview.MarginColor;
    MeasurementUnits := TdxMeasurementUnits(Preview.MeasurementUnits);
    ShowMarginsHintWhileDragging := pohShowOnDrag in Preview.OptionsHint;
    ShowMarginHints := pohShowForMargins in Preview.OptionsHint;
    ShowMargins := povMargins in Preview.OptionsView;
    ZoomOnMouseRoll := pozZoomOnMouseRoll in Preview.OptionsZoom;
    ZoomStep := Preview.ZoomStep;
  end;
  
  if dxShowPSPreviewOptionsDlg(Data) then SavePreferences(Data);    
  
  UpdateControls;
end;

procedure TCustomdxPSPreviewWindow.DoShrinkToPageWidth(Value: Boolean);
begin
  if ReportLink <> nil then
    if FPreview.PageCount <> ReportLink.VisiblePageCount then
    begin 
      FPreview.PageCount := ReportLink.VisiblePageCount;
      if ThumbnailsPreview <> nil then
        ThumbnailsPreview.PageCount := ReportLink.VisiblePageCount;
    end
    else
      FPreview.Invalidate;
  UpdateControls;
end;

procedure TCustomdxPSPreviewWindow.DoThumbnailsToggleShow(Value: Boolean);
begin
  if Value then 
  begin
    if FSaveThumbnailsPaneWidth <> -1 then 
      ThumbnailsPane.Width := FSaveThumbnailsPaneWidth
    else  
      ThumbnailsPane.Width := DefaultThumbnailsPaneWidth;
    ThumbnailsSplitter.Left := ThumbnailsPane.Left - ThumbnailsSplitter.Width;

    FixupPreviewWidth;
  end
  else
  begin
    ThumbnailsPane.Width := 0;
    ThumbnailsPane.Left := ThumbnailsPane.Parent.Width;
  end;  
    
  if Visible and Enabled then   
    if not Value then 
      if Preview.CanFocus then
        ActiveControl := Preview
      else
        ActiveControl := nil  
    else  
      ThumbnailsPreview.SetFocus;
      
  UpdateControls;  
end;

procedure TCustomdxPSPreviewWindow.DoUnloadReportLinkData;
begin
  ReportLink.DataSource := rldsComponent;
end;

procedure TCustomdxPSPreviewWindow.FixupPreviewWidth;
var
  AvailableWidth: Integer;
begin
  if Preview.Width < MinPreviewSize.X then
  begin 
    AvailableWidth := PreviewPane.ClientWidth - MinPreviewSize.X - ThumbnailsSplitter.Width;
    if AvailableWidth < 0 then   
      AvailableWidth := 0;

    if ShowThumbnails and (ThumbnailsPane.Width > AvailableWidth) then
      ThumbnailsPane.Width := AvailableWidth;
  end;
end;

procedure TCustomdxPSPreviewWindow.PreviewPaneResize(Sender: TObject);
begin
  if ShowThumbnails then 
    if Preview.Width < MinPreviewSize.X then 
    begin
      ThumbnailsPane.Width := PreviewPane.ClientWidth - MinPreviewSize.X - ThumbnailsSplitter.Width;
      Preview.Width := MinPreviewSize.X;
    end;
  ShowExplorer := ExplorerPane.Width <> 0;
end;

procedure TCustomdxPSPreviewWindow.ThumbnailsPreviewResize(Sender: TObject);
begin
  ShowThumbnails := ThumbnailsPane.Width <> 0;
end;

procedure TCustomdxPSPreviewWindow.UpdateThumbnailsSize;
begin
  ThumbnailsPreview.ZoomFactor := dxPSCore.dxThumbnailsZoomFactors[ThumbnailsSize];
end;

procedure TCustomdxPSPreviewWindow.DoDesignReport;
begin
  if ReportLink <> nil then
  begin
    ReportLink.DesignReport;
    UpdateControls;
  end;   
end;

procedure TCustomdxPSPreviewWindow.DoLoadReportLinkDataFromFile;
var
  Dialog: TdxPSOpenReportDialog;
begin
  if ReportLink <> nil then
  begin
    Dialog := TdxPSOpenReportDialog.Create(nil);
    with Dialog do
    try
      if Execute then 
        ReportLink.LoadDataFromFile(FileName);
    finally
      Free;
    end;
  end;  
end;

procedure TCustomdxPSPreviewWindow.DoPageSetupReport(APageIndex: Integer);
var
  PreviewBtnClicked, PrintBtnClicked: Boolean;
begin
  if ComponentPrinter.PageSetupEx(APageIndex, False, CanPrintDialog, PreviewBtnClicked, PrintBtnClicked, nil) then
  begin
    InitContent;
    UpdateControls;
  end;
  InvalidatePagesContent;
  if PrintBtnClicked then 
    DoPrintReport(True);
end;

procedure TCustomdxPSPreviewWindow.DoPrintReport(AShowDialog: Boolean);
begin
  ComponentPrinter.Print(AShowDialog, nil, nil);
  {if AShowDialog then }UpdateControls;
  DoAfterPrintReport(AShowDialog);
  if FReleased then Release;
end;

procedure TCustomdxPSPreviewWindow.DoSaveReportLinkDataToFile;
var
  fsDialog: TdxPSSaveReportDialog;
begin
  if ReportLink <> nil then
  begin
    fsDialog := TdxPSSaveReportDialog.Create(nil);
    with fsDialog do
    try
      FileName := ReportLink.GetNewReportStorageName;
      if Execute then 
      begin
        FileName := ChangeFileExt(FileName, '.' + dxPSCore.dxPSReportFileShortExtension);
        ReportLink.SaveDataToFile(FileName);
      end;  
    finally              
      Free;
    end; 
  end;  
end;

function TCustomdxPSPreviewWindow.CanDesign: Boolean;
begin
  Result := IsVisible(pvoReportDesign) and IsEnabled(peoReportDesign) and 
    (ReportLink <> nil) and ReportLink.CheckToDesign and not IsPrinting and not IsBuilding;
end;

function TCustomdxPSPreviewWindow.CanPrint: Boolean;
begin
  Result := IsVisible(pvoPrint) and IsEnabled(peoPrint) and (ReportLink <> nil) and 
    (ReportLink.PageCount > 0) and (dxPrnDev.dxGetDefaultPrinter <> '') and not IsPrinting;
end;

function TCustomdxPSPreviewWindow.CanPrintDialog: Boolean;
begin
  Result := CanPrint;
end;

function TCustomdxPSPreviewWindow.CanPrintStyle: Boolean;
begin                                                                                       
  Result := (ReportLink <> nil) and (ReportLink.StyleManager <> nil) and 
    IsVisible(pvoPrintStyles);
end;

function TCustomdxPSPreviewWindow.CanRebuild: Boolean;
begin
  Result := (ReportLink <> nil) and ReportLink.DataProviderPresent and 
    (ComponentPrinter.State * [cpsBuilding, cpsPrinting] = [])
end;

function TCustomdxPSPreviewWindow.CanLoadReport: Boolean;
begin
  if IsExplorerAvailable then 
    Result := (ExplorerTree <> nil) and ExplorerTree.CanLoadSelectedItemData and not IsBuilding
  else
    Result := IsVisible(pvoReportFileOperations) and (ReportLink <> nil) and 
      ReportLink.CanLoadData and not IsBuilding;
end;

function TCustomdxPSPreviewWindow.CanPageSetup: Boolean;
begin
  Result := IsVisible(pvoPageSetup) and IsEnabled(peoPageSetup) 
    and (ComponentPrinter <> nil) and not IsPrinting;
end;

function TCustomdxPSPreviewWindow.CanChangeMargins: Boolean;
begin
  Result := IsEnabled(peoCanChangeMargins) and not IsPrinting and not IsBuilding;
end;

function TCustomdxPSPreviewWindow.CanSaveReport: Boolean;
begin
  if not ComponentPrinter.IsExplorerMode then
  begin
    if IsExplorerAvailable and (ReportLink = nil) then
      Result := (ExplorerTree <> nil) and ExplorerTree.CanCreateItem
    else
      Result := (ReportLink <> nil) and IsVisible(pvoReportFileOperations) and ReportLink.CanSaveData;
  end
  else
    Result := False;
end;

function TCustomdxPSPreviewWindow.CanUnloadReport: Boolean;
begin
  if IsExplorerAvailable then
    Result := (ExplorerTree <> nil) and ExplorerTree.CanUnloadItemData
  else
    Result := IsVisible(pvoReportFileOperations) and (ReportLink <> nil) and 
      ReportLink.CanUnloadData;
end;

function TCustomdxPSPreviewWindow.IsCommandLoadReportVisible: Boolean;
begin
  Result := IsExplorerAvailable or IsVisible(pvoReportFileOperations);
end;

function TCustomdxPSPreviewWindow.IsCommandSaveReportVisible: Boolean;
begin
  Result := IsExplorerAvailable or IsVisible(pvoReportFileOperations);
end;

function TCustomdxPSPreviewWindow.IsCommandUnloadReportVisible: Boolean;
begin
  Result := IsExplorerAvailable or IsVisible(pvoReportFileOperations);
end;

function TCustomdxPSPreviewWindow.IsEnabled(AnOption: TdxPreviewEnableOption): Boolean;
begin
  Result := AnOption in FEnableOptions;
end;

function TCustomdxPSPreviewWindow.IsVisible(AnOption: TdxPreviewVisibleOption): Boolean;
begin
  Result := AnOption in FVisibleOptions;
end;

function TCustomdxPSPreviewWindow.IsAutoHFTextEntriesAvailable: Boolean;
begin
  Result := (ReportLink <> nil) and (ReportLink.StyleManager <> nil);
end;

function TCustomdxPSPreviewWindow.IsBuilding: Boolean;
begin
  Result := (ComponentPrinter <> nil) and (cpsBuilding in ComponentPrinter.State);
end;

function TCustomdxPSPreviewWindow.IsPrinting: Boolean;
begin
  Result := ((ComponentPrinter <> nil) and (cpsPrinting in ComponentPrinter.State)) or 
    dxPrintDevice.Printing;
end;

function TCustomdxPSPreviewWindow.IsProgressState: Boolean;
begin
  Result := (ComponentPrinter <> nil) and 
    (ComponentPrinter.State * [cpsBuilding, cpsPrinting] <> []);
end;

function TCustomdxPSPreviewWindow.IsSizeGripActuallyShown: Boolean;
begin
  Result := StatusBar.SizeGrip and (WindowState = wsNormal);
end;

function TCustomdxPSPreviewWindow.IsStatusTextPanel(APanel: TStatusPanel): Boolean;
begin
  Result := APanel = StatusTextPanel;
end;

procedure TCustomdxPSPreviewWindow.InvalidateStatusPanel(AStatusBar: TStatusBar; 
  AIndex: Integer);
var
  R: TRect;
begin
  R := GetStatusPanelBounds(AStatusBar, AIndex);
  InvalidateRect(AStatusBar.Handle, @R, False);
end;

procedure TCustomdxPSPreviewWindow.InvalidatePagesHeadersOrFooters;
begin
  case State of 
    prsEditHeaders: 
      FPreview.InvalidatePagesHeader;
    prsEditFooters:
      FPreview.InvalidatePagesFooter;
  end;
end;

procedure TCustomdxPSPreviewWindow.RefreshStatusBar(AStatusSections: TfmPreviewStatusSections);
begin
  if not IsProgressState then
  begin
    if ReportLink <> nil then
    begin
      if ssCurrentPage in AStatusSections then
        SectionStatusPanelSetText(ssCurrentPage, IntToStr(ReportLink.CurrentPage));
      if ssPageCount in AStatusSections then
        SectionStatusPanelSetText(ssPageCount, IntToStr(ReportLink.PageCount));
    end;

    if ssPaperSize in AStatusSections then
      SectionStatusPanelSetText(ssPaperSize, FPreview.PageSizeToString);

    if ssStatus in AStatusSections then 
    begin
      InvalidateStatusPanel(StatusBar, StatusBar.Panels.Count - 1);
      StatusBar.Update;
    end;  
    UpdateStatusBarPanelWidths(StatusBar);
  end;  
end;

procedure TCustomdxPSPreviewWindow.RefreshMarginBar(AMargin: TdxPreviewPageMargin);
begin
  with FPreview do 
    if AMargin = nil then
    begin
      MarginStatusPanel(Margins.Left).Text := MarginValueToString(Margins.Left.Value);
      MarginStatusPanel(Margins.Top).Text := MarginValueToString(Margins.Top.Value);
      MarginStatusPanel(Margins.Right).Text := MarginValueToString(Margins.Right.Value);
      MarginStatusPanel(Margins.Bottom).Text := MarginValueToString(Margins.Bottom.Value);
      MarginStatusPanel(Margins.Header).Text := MarginValueToString(Margins.Header.Value);
      MarginStatusPanel(Margins.Footer).Text := MarginValueToString(Margins.Footer.Value);
    end
    else
      MarginStatusPanel(AMargin).Text := MarginValueToString(AMargin.DraggingValue);
end;

function TCustomdxPSPreviewWindow.IsMarginValueStatusPanel(APanel: TStatusPanel): Boolean;
const 
  Indexes: set of Byte = [2, 4, 6, 8, 10, 12];
begin
  Result := APanel.Index in Indexes;
end;

function TCustomdxPSPreviewWindow.MarginStatusPanel(AMargin: TdxPreviewPageMargin): TStatusPanel;
//pmLeft, pmTop, pmRight, pmBottom, pmHeader, pmFooter
var
  Index: Integer;
begin
  if AMargin is TdxPreviewPageMarginLeft then
    Index := 2
  else if AMargin is TdxPreviewPageMarginTop then
    Index := 4
  else if AMargin is TdxPreviewPageMarginRight then
    Index := 6
  else if AMargin is TdxPreviewPageMarginBottom then
    Index := 8
  else if AMargin is TdxPreviewPageMarginFooter then
    Index := 12
  else //if AMargin is TdxPreviewPageMarginHeader then
    Index := 10;
  Result := FMarginBar.Panels[Index];
end;

function TCustomdxPSPreviewWindow.SectionStatusPanel(AStatusSection: TfmPreviewStatusSection): TStatusPanel;
const 
  Indexes: array [TfmPreviewStatusSection] of Integer = (1, 3, 7, 9);
begin
  if Indexes[AStatusSection] < FStatusBar.Panels.Count then
    Result := FStatusBar.Panels[Indexes[AStatusSection]]
  else
    Result := nil;
end;

procedure TCustomdxPSPreviewWindow.SectionStatusPanelSetText(
  AStatusSection: TfmPreviewStatusSection; const AText: string);
begin
  if SectionStatusPanel(AStatusSection) <> nil then
    SectionStatusPanel(AStatusSection).Text := AText;
end;

procedure TCustomdxPSPreviewWindow.DoPreviewMarginChanged(APreview: TdxPreview; 
  AMargin: TdxPreviewPageMargin);
begin
  if FPreview.DraggingMargin = nil then RefreshMarginBar(AMargin);
end;

procedure TCustomdxPSPreviewWindow.DoPreviewAfterDragMargin(APreview: TdxPreview; 
  AMargin: TdxPreviewPageMargin);
var
  MarginsValid: Boolean;  
begin
  RefreshMarginBar(AMargin);
  MarginsValid := ValidateMargins;
  if (MarginsValid <> FAreMarginsValid) and not MarginsValid then 
    SysUtils.Beep;
  FAreMarginsValid := MarginsValid;
  UpdateStatusText;
  RefreshStatusBar([ssStatus]);
end;

procedure TCustomdxPSPreviewWindow.DoPreviewBeforeDragMargin(APreview: TdxPreview; 
  AMargin: TdxPreviewPageMargin);
begin
  RefreshMarginBar(AMargin);
end;

procedure TCustomdxPSPreviewWindow.DoPreviewDragMargin(APreview: TdxPreview; 
  AMargin: TdxPreviewPageMargin);
begin
  RefreshMarginBar(AMargin);
end;

procedure TCustomdxPSPreviewWindow.DoPreviewZoomFactorChanged(APreview: TdxPreview);
begin
end;

procedure TCustomdxPSPreviewWindow.DoPreviewZoomModeChanged(APreview: TdxPreview);
begin
end;

function TCustomdxPSPreviewWindow.GetPreviewCanShowMarginHint(APreview: TdxPreview): Boolean;
begin
  Result := True;
end;

procedure TCustomdxPSPreviewWindow.DoPreviewDblClick(APreview: TdxPreview);
begin
end;

procedure TCustomdxPSPreviewWindow.DoAfterPrintReport(AShowDialog: Boolean);
begin
end;

procedure TCustomdxPSPreviewWindow.DoSetupZoomFactor(AZoomFactor, APageXCount, 
  APageYCount: Integer; AZoomMode: TdxPreviewZoomMode);
begin
  FPreview.ZoomMode := AZoomMode;
  case FPreview.ZoomMode of 
    pzmNone: 
      FPreview.ZoomFactor := AZoomFactor;
    pzmPages: 
      FPreview.SetPageXYCount(APageXCount, APageYCount);
  end;
  UpdateControls;
end;

procedure TCustomdxPSPreviewWindow.DoActivePageChanged(AValue: Integer);
begin
  if ReportLink <> nil then 
    if ReportLink.ShowEmptyPages then
      ActivePageIndex := ReportLink.RealPageIndexToVirtualPageIndex(AValue, True)
    else
      ActivePageIndex := AValue;
end;

procedure TCustomdxPSPreviewWindow.DoExplorerButtonsPosUpdate;
begin
  FExplorerCloseButton.Left := FExplorerToolBar.ClientWidth - FExplorerCloseButton.Width - 1;
end;

procedure TCustomdxPSPreviewWindow.DoExplorerCreateNewFolder;
begin
  if (ExplorerTree <> nil) and ExplorerTree.CanCreateFolder then
    Explorer.CreateNewFolder(ExplorerTree.CreationParent);
end;

procedure TCustomdxPSPreviewWindow.DoExplorerCreateNewItem;
begin
  if CanSaveReport then 
    if IsExplorerAvailable then 
    begin
      if ExplorerTree <> nil then
      begin
        ExplorerTree.CreateItem;
        ShowExplorer := True;
      end;  
    end
    else
      DoSaveReportLinkDataToFile;
end;

procedure TCustomdxPSPreviewWindow.DoExplorerDeleteItem;
begin
  if ExplorerTree <> nil then ExplorerTree.DeleteSelection;
end;

function TCustomdxPSPreviewWindow.DoExplorerItemShowPropertySheets: Boolean;
begin
  Result := (ExplorerTree <> nil) and ExplorerTree.ShowSelectedItemPropertySheets;
end;
                           
procedure TCustomdxPSPreviewWindow.DoExplorerLoadItemData;
begin
  if CanLoadReport then 
    if IsExplorerAvailable then 
      ExplorerTree.LoadSelectedItemData
    else
      DoLoadReportLinkDataFromFile;
end;

procedure TCustomdxPSPreviewWindow.DoExplorerRenameItem;
begin
  ExplorerTree.BeginEdit;
end;

procedure TCustomdxPSPreviewWindow.DoExplorerShowToggled(Value: Boolean);
begin
  if ExplorerPane <> nil then
  begin
    if Value then 
    begin
      if FSaveExplorerPaneWidth <> -1 then 
        ExplorerPane.Width := FSaveExplorerPaneWidth
      else  
        ExplorerPane.Width := DefaultExplorerPaneWidth;
      ExplorerSplitter.Left := ExplorerPane.Width + 1;
    end
    else
    begin
      ExplorerPane.Width := 0;
      ExplorerPane.Left := 0;
    end;  
    
    if Visible and Enabled then   
    begin
      if not Value then 
        if Preview.CanFocus then
          ActiveControl := Preview
        else
          ActiveControl := nil  
      else  
        if ExplorerTree <> nil then
          ExplorerTree.SetFocus;
    end;
      
    UpdateControls;  
  end;  
end;

procedure TCustomdxPSPreviewWindow.DoExplorerUnloadItemData;
begin
  if CanUnloadReport then 
    if IsExplorerAvailable then 
      ExplorerTree.UnloadItemData
    else
      DoUnloadReportLinkData;
end;

procedure TCustomdxPSPreviewWindow.DoFormatTitle;
begin
  ReportLink.ShowTitlePropertiesDlg;
end;

procedure TCustomdxPSPreviewWindow.DoInsertHF(const S: string);
var
  Strings: TStrings;
begin
  case State of 
    prsEditHeaders: 
      Strings := PrinterPage.PageHeader.Titles[HFEditPart];
    prsEditFooters:
      Strings := PrinterPage.PageFooter.Titles[HFEditPart];
  else
    Exit;    
  end;
  Strings.Text := Strings.Text + S;
  InvalidatePagesHeadersOrFooters;
end;

procedure TCustomdxPSPreviewWindow.DoInvokeHelp;
begin
  if HelpContext <> 0 then Application.HelpContext(HelpContext);
end;

procedure TCustomdxPSPreviewWindow.DoClearHF;
begin
  if PrinterPage = nil then Exit;
  case State of
    prsEditHeaders: 
      PrinterPage.PageHeader.Titles[HFEditPart].Text := '';
    prsEditFooters: 
      PrinterPage.PageFooter.Titles[HFEditPart].Text := '';
   end;   
  InvalidatePagesHeadersOrFooters;
end;

procedure TCustomdxPSPreviewWindow.DoShowHFBackgroundDlg(const Pt: TPoint);
var
  Background: TdxBackground;
begin
  case State of
    prsEditHeaders: 
      Background := PrinterPage.PageHeader.Background;
    prsEditFooters: 
      Background := PrinterPage.PageFooter.Background;
  else
    Exit;    
  end;   
  if dxChooseBackgroundDlg(Background, Pt, dxDefaultBackgroundDlgData) then
    InvalidatePagesHeadersOrFooters;
end;

procedure TCustomdxPSPreviewWindow.DoShowPageHeaders(Value: Boolean);
begin
  ReportLink.ShowPageHeader := Value;
  FPreview.InvalidatePagesHeader;
end;

procedure TCustomdxPSPreviewWindow.DoShowPageFooters(Value: Boolean);
begin
  ReportLink.ShowPageFooter := Value;
  FPreview.InvalidatePagesFooter;
end;

procedure TCustomdxPSPreviewWindow.PrepareProgress;
begin
  RefreshStatusPanels(psbmProgress);
  ProgressBarShow;
  FLastOpCompleted := 0;    
  FCurrentProgressValue := 0;
end;

function TCustomdxPSPreviewWindow.ProgressBarGetMaxValue: Integer;
begin  
  if cpsPrinting in ComponentPrinter.State then
    Result := FFullPageCount
  else
    Result := 100;
end;

procedure TCustomdxPSPreviewWindow.ProgressBarHide;
begin
  ProgressBar.Parent := nil;
end;

procedure TCustomdxPSPreviewWindow.ProgressBarPlace;
var
  R: TRect;
begin
  R := GetStatusPanelBounds(StatusBar, ProgressStatusPanel.Index);
  InflateRect(R, -1, -1);
  if Flat then Dec(R.Bottom);
  ProgressBar.BoundsRect := R;
end;

procedure TCustomdxPSPreviewWindow.ProgressBarRefresh;
begin
  //UpdateStatusText;
  ProgressBar.Position := FCurrentProgressValue;
end;

procedure TCustomdxPSPreviewWindow.ProgressBarShow;
begin
  ProgressBar.Position := 0;
  ProgressBar.Max := ProgressBarGetMaxValue;
  ProgressBar.Parent := StatusBar;
  ProgressBarPlace;
end;

procedure TCustomdxPSPreviewWindow.UnprepareProgress;
begin
  ProgressBarHide;
  RefreshStatusPanels(psbmNormal);
  UpdateControls;
  PostMessage(Handle, DXM_PS_UPDATESTATUSPROGRESS, 0, 0);
end;

procedure TCustomdxPSPreviewWindow.GenerateReportProgress(Sender: TObject;
  AReportLink: TBasedxReportLink; APercentDone: Double {mask : '##0.00'});
begin
  if Sender <> ComponentPrinter then Exit;
  FCurrentProgressValue := Trunc(APercentDone);
  ProgressBarRefresh;
  //if IsEscKeyPressed(Handle) then ComponentPrinter.AbortBuilding := True;
end;

procedure TCustomdxPSPreviewWindow.EndGenerateReport(Sender: TObject;
  AReportLink: TBasedxReportLink);
begin
  if Sender <> ComponentPrinter then Exit;
  UnprepareProgress;
  if Preview.SelPageIndex > ReportLink.PageCount - 1 then
    Preview.SelPageIndex := ReportLink.PageCount - 1;
end;

procedure TCustomdxPSPreviewWindow.StartGenerateReport(Sender: TObject;
  AReportLink: TBasedxReportLink);
begin
  if Sender <> ComponentPrinter then Exit;

  Preview.PageCount := 0;
  Preview.Update;

  ThumbnailsPreview.PageCount := 0;
  ThumbnailsPreview.Update;

  PrepareProgress;
  UpdateControls;
end;

procedure TCustomdxPSPreviewWindow.EndPrint(Sender: TObject; AReportLink: TBasedxReportLink);
begin
  if Sender <> ComponentPrinter then Exit;
  UnprepareProgress;
  UpdateControls;
end;

procedure TCustomdxPSPreviewWindow.NewPage(Sender: TObject; AReportLink: TBasedxReportLink;
  APageIndex: Integer);
begin
  if Sender <> ComponentPrinter then Exit;
  FCurrentProgressValue := APageIndex;
  ProgressBarRefresh;
end;

procedure TCustomdxPSPreviewWindow.StartPrint(Sender: TObject; AReportLink: TBasedxReportLink;
  FullPageCount: Integer);
begin
  if Sender <> ComponentPrinter then Exit;
  FFullPageCount := FullPageCount;
  UpdateControls;
  PrepareProgress;
end;

procedure TCustomdxPSPreviewWindow.UpdateMarginBar;
var
  I: Integer;
  R: TRect;
begin
  with MarginBar do
  begin
    //dxRecreateWnd(MarginBar);
    Perform(CM_RECREATEWND, 0, 0);
    Refresh;
    Canvas.Font := Font;
    for I := 0 to Panels.Count - 1 do
      if Panels[I].Style = psOwnerDraw then
      begin
        R := GetStatusPanelBounds(MarginBar, I);
        InflateRect(R, -1, -1);
        MarginBarDrawPanel(FMarginBar, Panels[I], R);
      end;
  end;  
end;

procedure TCustomdxPSPreviewWindow.SetZoomFactorByText(const AText: string);
var
  V, I, PageXCount, PageYCount: Integer;
begin
  I := FPredefinedZooms.IndexOf(AText);
  if I > -1 then
    if I < PredefinedZoomValueCount then
    begin
      FPreview.ZoomMode := pzmNone;
      FPreview.ZoomFactor := Integer(FPredefinedZooms.Objects[I]);
    end
    else
    begin
      if I = PredefinedZoomValueCount then
        FPreview.ZoomMode := pzmPageWidth
      else
        FPreview.ZoomMode := pzmPages;
        
      case I - PredefinedZoomValueCount of
        1: FPreview.SetPageXYCount(1, 1);
        2: FPreview.SetPageXYCount(2, 1);
        3: FPreview.SetPageXYCount(2, 2);
        4: begin
             ReportLink.GetPageColRowCount(PageXCount, PageYCount);
             FPreview.SetPageXYCount(PageXCount, 1);
           end;
      end;
    end
  else
  begin
    try
      V := StrToInt(DropPercentChar(AText));
    except
      try
        V := Round(StrToFloat(DropPercentChar(AText)));
      except
        V := FLastValidZoomFactor;
      end;
    end;
    FPreview.ZoomFactor := V;
  end;
  FLastValidZoomFactor := FPreview.ZoomFactor;
end;

procedure TCustomdxPSPreviewWindow.UpdateStatusBarPanelWidths(AStatusBar: TStatusBar);

  procedure UpdateStatusBarPanelWidth(APanel: TStatusPanel);
  var
    TextWidth: Integer;
  begin
    TextWidth := AStatusBar.Canvas.TextWidth(APanel.Text);
    if TextWidth = 0 then
      APanel.Width := 4     
    else
      if APanel.Width < 3 + TextWidth + 3 then 
        APanel.Width := 3 + TextWidth + 3;
  end;
  
var
  I: Integer;
begin
  for I := 0 to AStatusBar.Panels.Count - 1 do
    UpdateStatusBarPanelWidth(AStatusBar.Panels[I]);
end;

procedure TCustomdxPSPreviewWindow.SavePreferences(AData: TdxPreviewOptionsDlgData);
begin
  with Preview do
  begin
    if AData.ShowMarginHints then 
      OptionsHint := OptionsHint + [pohShowForMargins]
    else
      OptionsHint := OptionsHint - [pohShowForMargins];

    if AData.ShowMarginsHintWhileDragging then
      OptionsHint := OptionsHint + [pohShowOnDrag]
    else
      OptionsHint := OptionsHint - [pohShowOnDrag];
    
    if AData.ZoomOnMouseRoll then
      OptionsZoom := OptionsZoom + [pozZoomOnMouseRoll]
    else
      OptionsZoom := OptionsZoom - [pozZoomOnMouseRoll];

    ZoomStep := AData.ZoomStep;
    MarginColor := AData.MarginColor;    
    MeasurementUnits :=
      dxPreVw.TdxPreviewMeasurementUnits(AData.MeasurementUnits);
  end;
  
  ShowPageMargins := AData.ShowMargins;
  PrinterPage.MeasurementUnits := AData.MeasurementUnits;
end;

procedure TCustomdxPSPreviewWindow.SaveToRegistry(const APath: string);
begin
  inherited;
  SavePropertiesToRegistry(APath);
end;

procedure TCustomdxPSPreviewWindow.LoadFromRegistry(const APath: string);
begin
  inherited;
  LoadPropertiesFromRegistry(APath);
end;

procedure TCustomdxPSPreviewWindow.SavePropertiesToRegistry(const APath: string);

  procedure DoStore(const ARegistryPath: string);
  begin
    Preview.SaveToRegistry(ARegistryPath + '\' + sdxPreviewControl);
    
    with TRegistry.Create do      
    try
      if OpenKey(ARegistryPath, True) then
      try
        WriteBool(sdxShowMarginBar, ShowMarginBar);
        WriteBool(sdxShowStatusBar, ShowStatusBar);

        WriteInteger(sdxExplorerVisibilityState, Ord(ShowExplorer) + 1);
        if ExplorerPaneWidth <> 0 then 
          WriteInteger(sdxExplorerPaneWidth, ExplorerPaneWidth);

        WriteInteger(sdxThumbnailsVisibilityState, Ord(ShowThumbnails) + 1);
        if ThumbnailsPaneWidth <> 0 then 
          WriteInteger(sdxThumbnailsPaneWidth, ThumbnailsPaneWidth);
      except  
        on ERegistryException do
        else
          raise;
      end;
    finally
      Free;
    end;   
  end;
   
begin
  DoStore(APath);
  if IsDesignTime and (dxPSEngine.RegistryPath <> '') then
    DoStore(dxPSEngine.RegistryPath);
end;

procedure TCustomdxPSPreviewWindow.LoadPropertiesFromRegistry(const APath: string);
begin
  FPreview.LoadFromRegistry(APath + '\' + sdxPreviewControl);
  if povMargins in FPreview.OptionsView then
    FSavePageMarginsVisibility := mvsShown
  else
    FSavePageMarginsVisibility := mvsHidden;
  
  with TRegistry.Create do 
  try
    if OpenKey(APath, False) then
    try
      if ValueExists(sdxShowMarginBar) then 
        FShowMarginBar := ReadBool(sdxShowMarginBar);

      if ValueExists(sdxShowStatusBar) then 
        FShowStatusBar := ReadBool(sdxShowStatusBar);
        
      if ValueExists(sdxExplorerVisibilityState) then 
        FSaveExplorerVisibility := TdxPSExplorerVisibiltyState(ReadInteger(sdxExplorerVisibilityState))
      else
        FSaveExplorerVisibility := evsUndefined;

      if ValueExists(sdxExplorerPaneWidth) then   
        FSaveExplorerPaneWidth := ReadInteger(sdxExplorerPaneWidth);

      if ValueExists(sdxThumbnailsVisibilityState) then 
        FSaveThumbnailsVisibility := TdxPSThumbnailsVisibiltyState(ReadInteger(sdxThumbnailsVisibilityState))
      else
        FSaveThumbnailsVisibility := tvsUndefined;

      if ValueExists(sdxThumbnailsPaneWidth) then   
        FSaveThumbnailsPaneWidth := ReadInteger(sdxThumbnailsPaneWidth);
    except  
      on ERegistryException do
      else
        raise;
    end;
  finally
    Free;
  end;
end;
    
procedure TCustomdxPSPreviewWindow.UpdateStatusText;

  function GetStatusText: string;
  begin
    if ValidateMargins then
      Result := cxGetResourceString(@sdxStatusReady)
    else 
      Result := cxGetResourceString(@sdxOutsideMargins);
  end;
  
begin
  StatusTextPanel.Text := GetStatusText;
  StatusBar.Update;
end;

procedure TCustomdxPSPreviewWindow.WMAppCommand(var Message: TMessage);
begin
  with Message do 
    case dxPSGlbl.GET_APPCOMMAND_LPARAM(lParam) of
      APPCOMMAND_BROWSER_BACKWARD:
        begin
          GotoPrevPage;
          Result := 1;
        end;  

      APPCOMMAND_BROWSER_FORWARD:
        begin
          GotoNextPage;
          Result := 1;
        end;  

      APPCOMMAND_BROWSER_HOME:
        begin
          GotoFirstPage;
          Result := 1;
        end;  

      APPCOMMAND_HELP:
        begin
          DoInvokeHelp;
          Result := 1;
        end;  
      
      APPCOMMAND_OPEN:
        begin
          DoExplorerLoadItemData;
          Result := 1;
        end;
      APPCOMMAND_CLOSE:
        begin
          Close;
          Result := 1;
        end;  
      
      APPCOMMAND_SAVE: 
        begin
          Result := Ord(CanSaveReport);
          if Result = 1 then DoExplorerCreateNewItem;
        end;
      
      APPCOMMAND_PRINT: 
        begin
          DoPrintReport(True);
          Result := 1;
        end;  
    end;
  inherited;  
end;

procedure TCustomdxPSPreviewWindow.WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo);
begin
  inherited;
  with Message.MinMaxInfo.ptMinTrackSize do 
  begin
    X := 360;
    Y := 300;
  end;
end;

procedure TCustomdxPSPreviewWindow.WMSettingChange(var Message: TWMSettingChange);
begin
  inherited;
  with Message do
    if (Flag = 0) and (Section = 'intl') then
    begin
      RefreshMarginBar(nil);
      RefreshStatusBar([ssPaperSize]);
    end;  
end;

procedure TCustomdxPSPreviewWindow.WMSize(var Message: TWMSize);
begin
  inherited;
{  if (StatusBar <> nil) and (Message.SizeType = SIZE_MAXIMIZED) and Flat then
    StatusBar.Invalidate; }
end;

{  TdxPSStatusBar }

procedure TdxPSStatusBar.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    WindowClass.style := WindowClass.style or CS_HREDRAW or CS_VREDRAW;
end;

procedure TdxPSStatusBar.Resize;
begin
  inherited Resize;
  Invalidate;
  Update; 
end;

initialization
  ClosePaneGlyph := dxPSUtl.CreateGlyphBitmap(CloseGlyphIndex, 0, 0, 7);

finalization
  FreeAndNil(ClosePaneGlyph);

end.

