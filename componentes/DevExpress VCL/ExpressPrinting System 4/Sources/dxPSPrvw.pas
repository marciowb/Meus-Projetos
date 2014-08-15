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
  ImgList, Dialogs, Forms, Graphics,
  dxMessages, dxPSGlbl, dxPSCore, dxPSESys, dxPrevw,
  dxPSPrVwOpt, dxPrnPg, dxExtCtrls, dxBkgnd, cxLookAndFeels, cxControls,
  cxGraphics, cxGeometry, cxSplitter, cxLookAndFeelPainters, IniFiles;

type
  TfmPreviewStatusSection = (ssCurrentPage, ssPageCount, ssPaperSize, ssStatus);
  TfmPreviewStatusSections = set of TfmPreviewStatusSection;

  TdxPSExplorerVisibiltyState = (evsUndefined, evsHidden, evsShown);
  TdxPSThumbnailsVisibiltyState = (tvsUndefined, tvsHidden, tvsShown);
  TdxPSPageMarginsVisibilityState = (mvsUndefined, mvsHidden, mvsShown);
  
  TdxPSPreviewWindowStatusBarMode = (psbmNormal, psbmProgress);
  
  TdxPSPreviewWindow = class;
  TdxPSCustomStatusBar = class;
  TdxPSStatusBarPanel = class;

  TdxPSPreviewWindowAddExplorerCommandEvent = procedure (
    Sender: TObject; ACommand: TCustomdxPSExplorerContextCommand) of object;
  TdxPSPreviewWindowAfterPrintReportEvent = procedure (
    Sender: TObject; AShowDialog: Boolean) of object;
  TdxPSPreviewWindowCanShowMarginHint = procedure (Sender: TObject; var AAllow: Boolean) of object;
  TdxPSPreviewWindowHFToolBarShow = procedure (Sender: TObject; AShow: Boolean) of object;

  { TdxPSExplorerToolBar }

  TdxPSExplorerToolBar = class(TcxControl)
  protected
    procedure Paint; override;
  public
    property Font;
  end;

  { TdxPSExplorerHostPanel }

  TdxPSExplorerHostPanel = class(TcxControl)
  protected
    procedure Paint; override;
  end;

  { TdxPSExplorerCloseButton }

  TdxPSExplorerCloseButton = class(TSpeedButton)
  public
    constructor Create(AOwner: TComponent); override;
  end;
  
  { TdxPSPreviewExplorerChangeNotifier }
  
  TdxPSPreviewExplorerChangeNotifier = class(TdxPSExplorerChangeNotifierAdapter)
  private
    FPreview: TdxPSPreviewWindow;
  protected
    procedure ItemDataLoaded(AnItem: TdxPSExplorerItem); override;
    procedure ItemDataUnloaded(AnItem: TdxPSExplorerItem); override;
  public
    constructor Create(APreview: TdxPSPreviewWindow);
    //
    property Preview: TdxPSPreviewWindow read FPreview;
  end;

  { TdxPSPreviewWindowCustomHost }

  TdxPSPreviewWindowCustomHostOnSize = procedure (Sender: TObject; var AWidth, AHeight: Integer) of object;

  TdxPSPreviewWindowCustomHost = class(TcxControl)
  private
    FOnSizeChanging: TdxPSPreviewWindowCustomHostOnSize;
  protected
    procedure DoSizeChanging(var AWidth, AHeight: Integer); virtual;
    procedure Paint; override;
  public
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    //
    property OnResize;
    property OnSizeChanging: TdxPSPreviewWindowCustomHostOnSize read FOnSizeChanging write FOnSizeChanging;
  end;

  { TdxPSPreviewWindow }

  TdxPSPreviewWindowLoadPropertiesEvent = procedure
    (Sender: TObject; AIniFile: TCustomIniFile; const ASectionName: string) of object;

  TdxPSPreviewWindow = class(TdxPSCustomPreviewWindow, IdxPSExplorerTreeContainerHost)
  private
    FBuildEventsSubscriber: TdxEventSubscriber;
    FCurrentProgressValue: Integer;
    FEnableOptions: TdxPreviewEnableOptions;
    FFullPageCount: Integer;
    FHFEditPart: TdxPageTitlePart;
    FHFFunctionList: TStringList;
    FHFTextEntriesChangedSubscriber: TdxEventSubscriber;
    FLastOpCompleted: Integer;
    FLastValidZoomFactor: Integer;
    FLockPageSelection: Boolean;
    FOnAddExplorerCommand: TdxPSPreviewWindowAddExplorerCommandEvent;
    FOnAfterPrintReport: TdxPSPreviewWindowAfterPrintReportEvent;
    FOnCanShowMarginHint: TdxPSPreviewWindowCanShowMarginHint;
    FOnCreationComplete: TNotifyEvent;
    FOnHFTextEntriesChanged: TNotifyEvent;
    FOnHFToolBarVisibleChanged: TdxPSPreviewWindowHFToolBarShow;
    FOnInitContent: TNotifyEvent;
    FOnLoadProperties: TdxPSPreviewWindowLoadPropertiesEvent;
    FOnPreviewDblClick: TNotifyEvent;
    FOnSaveProperties: TdxPSPreviewWindowLoadPropertiesEvent;
    FOnStyleListChanged: TNotifyEvent;
    FOnUpdateControls: TNotifyEvent;
    FOnUpdateExplorerCommands: TNotifyEvent;
    FOnZoomFactorChanged: TNotifyEvent;
    FOnZoomModeChanged: TNotifyEvent;
    FPredefinedZooms: TStringList;
    FPreviewPopupMenu: TComponent;
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
    function GetProgressStatusPanel: TdxPSStatusBarPanel;
    function GetShowMarginBar: Boolean;
    function GetShowPageMargins: Boolean;
    function GetShowStatusBar: Boolean;
    function GetStatusTextPanel: TdxPSStatusBarPanel;
    function GetThumbnailsPaneWidth: Integer;
    function GetZoomOnClick: Boolean;
    procedure SetExplorerPaneWidth(Value: Integer);
    procedure SetPreviewPopupMenu(AValue: TComponent);
    procedure SetShowMarginBar(Value: Boolean);
    procedure SetShowPageMargins(Value: Boolean);
    procedure SetShowStatusBar(Value: Boolean);
    procedure SetThumbnailsPaneWidth(Value: Integer);
    procedure SetZoomOnClick(AValue: Boolean);

    function CreateSplitter(AAlign: TAlign; const AName: string; ALeft: Integer;
      AParent: TWinControl; AResizeControl: TControl; OnCanResizeEvent: TCanResizeEvent): TcxCustomSplitter;
    procedure FillEffectsApply(Sender: TObject);
    procedure ExplorerClose(Sender: TObject);
    procedure ExplorerSplitterCanResize(Sender: TObject; var NewSize: Integer; var Accept: Boolean);
    procedure ExplorerToolBarResize(Sender: TObject);
    procedure MarginBarDblClick(Sender: TObject);
    procedure MarginBarGetDrawParams(ASender: TdxPSCustomStatusBar; APanel: TdxPSStatusBarPanel; var ABkgColor, ATextColor: TColor);
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
    procedure StatusBarMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ThumbnailsPreviewSelectedPageChanged(Sender: TObject; APageIndex: Integer);
    procedure ThumbnailsSplitterCanResize(Sender: TObject; var NewSize: Integer; var Accept: Boolean);

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
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
    procedure WMSettingChange(var Message: TWMSettingChange); message WM_SETTINGCHANGE; 
  protected
    FExplorerChangeNotifier: TdxPSPreviewExplorerChangeNotifier;
    FExplorerCloseButton: TdxPSExplorerCloseButton;
    FExplorerPane: TdxPSPreviewWindowCustomHost;
    FExplorerSplitter: TcxCustomSplitter;
    FExplorerToolBar: TdxPSExplorerToolBar;
    FExplorerTree: TCustomdxPSExplorerTreeContainer;
    FExplorerTreeHost: TdxPSExplorerHostPanel;
    FMarginBar: TdxPSCustomStatusBar;
    FPreview: TdxPreview;
    FPreviewPane: TdxPSPreviewWindowCustomHost;
    FStatusBar: TdxPSCustomStatusBar;
    FThumbnailsPane: TdxPSPreviewWindowCustomHost;
    FThumbnailsPreview: TdxPreview;
    FThumbnailsSplitter: TcxCustomSplitter;                          
    FAreMarginsValid: Boolean;
    FReleased: Boolean;

    function CalculateStatusBarHeight: Integer;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure WndProc(var message: TMessage); override;

    function GetActivePageIndex: Integer; override;
    function GetBackground: TdxBackground; override;
    function GetExplorerTree: TCustomdxPSExplorerTreeContainer; override;
    function GetHFEditPart: TdxPageTitlePart; override;
    function GetPageCount: Integer; override;
    function GetPreviewEnableOptions: TdxPreviewEnableOptions; override;
    function GetPreviewVisibleOptions: TdxPreviewVisibleOptions; override;
    function GetSaveZoomPosition: Boolean; override;
    function GetShowExplorer: Boolean; override;
    function GetShowThumbnails: Boolean; override;
    function GetState: TdxPSPreviewState; override;
    function GetThumbnailsSize: TdxPSThumbnailsSize; override;
    function GetVisiblePageSize: TPoint; override;
    function GetZoomFactor: Integer; override;
    procedure SetActivePageIndex(Value: Integer); override;
    procedure SetBackground(const Value: TdxBackground); override;
    procedure SetFocusToControl(AControl: TWinControl);
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

    procedure AfterComponentPrinterChanged; override;
    procedure CreationComplete; override;
    procedure InitializeControlLookAndFeel(AControl: TControl);
    procedure InitializePreviewWindowLayout;
    procedure Paint; override;
    procedure Resize; override;

    procedure AddExplorerContextCommand(ACommand: TCustomdxPSExplorerContextCommand); override;
    procedure DoCreationComplete;
    procedure DoInitContent; virtual;

   {$IFDEF OLEDRAGANDDROP}
    function DoCanAccept: Boolean; override;
   {$ENDIF}

    procedure DoUpdatePanesState(Sender: TObject);
    procedure ExplorerPaneSizeChanging(Sender: TObject; var AWidth, AHeight: Integer);
    procedure ThumbnailsPreviewSizeChanging(Sender: TObject; var AWidth, AHeight: Integer);
    procedure UpdateThumbnailsSize;

    function MarginStatusPanel(AMargin: TdxPreviewPageMargin): TdxPSStatusBarPanel;
    function ProgressBarGetMaxValue: Integer;
    function SectionStatusPanel(AStatusSection: TfmPreviewStatusSection): TdxPSStatusBarPanel;
    procedure InvalidatePagesHeadersOrFooters;
    procedure PrepareProgress;
    procedure ProgressBarHide;
    procedure ProgressBarPlace;
    procedure ProgressBarRefresh;
    procedure ProgressBarShow;
    procedure RefreshMarginBar(AMargin: TdxPreviewPageMargin);
    procedure RefreshStatusBar(AStatusSections: TfmPreviewStatusSections);
    procedure SectionStatusPanelSetText(AStatusSection: TfmPreviewStatusSection; const AText: string);
    procedure UnprepareProgress;
    procedure UpdateStatusBarPanelWidths(AStatusBar: TdxPSCustomStatusBar);

    procedure LoadProperties(AIniFile: TCustomIniFile; const ASectionName: string);
    procedure SaveProperties(AIniFile: TCustomIniFile; const ASectionName: string);
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
    procedure CreateThumbnailsPreview; virtual;
    procedure CreateThumbnailsSplitter; virtual;
    procedure RefreshStatusPanels(AStatusBarMode: TdxPSPreviewWindowStatusBarMode); virtual;

    procedure DoAfterPrintReport(AShowDialog: Boolean); virtual;
    procedure DoLoadFromIniFile(AIniFile: TCustomIniFile; const ASectionName: string);
    procedure DoPreviewAfterDragMargin(APreview: TdxPreview; AMargin: TdxPreviewPageMargin); virtual;
    procedure DoPreviewBeforeDragMargin(APreview: TdxPreview; AMargin: TdxPreviewPageMargin); virtual;
    procedure DoPreviewDblClick(APreview: TdxPreview); virtual;
    procedure DoPreviewDragMargin(APreview: TdxPreview; AMargin: TdxPreviewPageMargin); virtual;
    procedure DoPreviewMarginChanged(APreview: TdxPreview; AMargin: TdxPreviewPageMargin); virtual;
    procedure DoSaveToIniFile(AIniFile: TCustomIniFile; const ASectionName: string);
    procedure DoUpdateControls; virtual;
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
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    procedure GoToFirstPage; override;
    procedure GoToLastPage; override;
    procedure GoToNextPage; override;
    procedure GoToPrevPage; override;
    procedure InitContent; override;
    procedure InvalidateAllPages; override;
    procedure InvalidateContent; override;
    procedure InvalidatePage(APageIndex: Integer); override;
    procedure InvalidatePagesContent; override;
    procedure InvalidatePagesFooterContent; override;
    procedure InvalidatePagesHeaderContent; override;
    procedure LoadFromIniFile(AIniFile: TCustomIniFile; const ASectionName: string); override;
    procedure SaveToIniFile(AIniFile: TCustomIniFile; const ASectionName: string); override;
    procedure UpdateControls; override;
    procedure UpdateControlsPosition;
    procedure UpdateExplorerContextCommands; override;

    function CanChangeMargins: Boolean;
    function CanClosePreviewWindow: Boolean; virtual;
    function CanDesign: Boolean;
    function CanExport: Boolean;
    function CanLoadReport: Boolean;
    function CanPageSetup: Boolean;
    function CanPrint: Boolean;
    function CanPrintDialog: Boolean;
    function CanPrintStyle: Boolean;
    function CanRebuild: Boolean;
    function CanSaveReport: Boolean;
    function CanUnloadReport: Boolean;
    function IsAutoHFTextEntriesAvailable: Boolean;
    function IsBuilding: Boolean;
    function IsCommandLoadReportVisible: Boolean;
    function IsCommandSaveReportVisible: Boolean;
    function IsCommandUnloadReportVisible: Boolean;
    function IsEnabled(AnOption: TdxPreviewEnableOption): Boolean;
    function IsMarginValueStatusPanel(APanel: TdxPSStatusBarPanel): Boolean;
    function IsPrinting: Boolean;
    function IsProgressState: Boolean;
    function IsStatusTextPanel(APanel: TdxPSStatusBarPanel): Boolean;
    function IsVisible(AnOption: TdxPreviewVisibleOption): Boolean;
                       
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
    procedure DoFormatFootnotes;
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
    procedure DoShowHFToolBar(Value: Boolean); virtual;
    procedure DoShowMultiplySelectPagesDlg(AImageList:TCustomImageList;
      AImageIndex: Integer; const Pt: TPoint; AYShift: Integer);
    procedure DoShowOptionsDlg;
    procedure DoShowPageBackgroundDlg(const Pt: TPoint);
    procedure DoShowPageFooters(Value: Boolean);
    procedure DoShowPageHeaders(Value: Boolean);
    procedure DoShowZoomDlg;
    procedure DoShrinkToPageWidth(Value: Boolean);
    procedure DoSyncPrintingPageBackground;
    procedure DoThumbnailsToggleShow(Value: Boolean);
    procedure DoUnloadReportLinkData;

    procedure BeginUpdate; override;
    procedure CancelUpdate; override;   
    procedure EndUpdate; override;
    function Locked: Boolean; override;

    procedure SetZoomFactorByText(const AText: string);

    property Explorer: TCustomdxPSExplorer read GetExplorer;
    property ExplorerCloseButton: TdxPSExplorerCloseButton read FExplorerCloseButton;
    property ExplorerPane: TdxPSPreviewWindowCustomHost read FExplorerPane;
    property ExplorerPaneWidth: Integer read GetExplorerPaneWidth write SetExplorerPaneWidth;
    property ExplorerSplitter: TcxCustomSplitter read FExplorerSplitter;
    property ExplorerToolBar: TdxPSExplorerToolBar read FExplorerToolBar;
    property ExplorerTreeHost: TdxPSExplorerHostPanel read FExplorerTreeHost;
    property Flat: Boolean read GetFlat;
    property HFFunctionList: TStringList read FHFFunctionList;
    property IsExplorerAvailable: Boolean read GetIsExplorerAvailable;
    property IsExplorerMode: Boolean read GetIsExplorerMode;
    property LookAndFeel;
    property MarginBar: TdxPSCustomStatusBar read FMarginBar;
    property PredefinedZooms: TStringList read FPredefinedZooms;
    property Preview: TdxPreview read FPreview;
    property PreviewPane: TdxPSPreviewWindowCustomHost read FPreviewPane;
    property PrinterPage: TdxPrinterPage read GetPrinterPage;
    property ProgressBar: TProgressBar read FProgressBar;
    property ProgressStatusPanel: TdxPSStatusBarPanel read GetProgressStatusPanel;
    property ShowMarginBar: Boolean read GetShowMarginBar write SetShowMarginBar;
    property ShowPageMargins: Boolean read GetShowPageMargins write SetShowPageMargins;
    property ShowStatusBar: Boolean read GetShowStatusBar write SetShowStatusBar;
    property StatusBar: TdxPSCustomStatusBar read FStatusBar;
    property StatusTextPanel: TdxPSStatusBarPanel read GetStatusTextPanel;
    property ThumbnailsPane: TdxPSPreviewWindowCustomHost read FThumbnailsPane;
    property ThumbnailsPaneWidth: Integer read GetThumbnailsPaneWidth write SetThumbnailsPaneWidth;
    property ThumbnailsPreview: TdxPreview read FThumbnailsPreview;
    property ThumbnailsSplitter: TcxCustomSplitter read FThumbnailsSplitter;
    property ZoomOnClick: Boolean read GetZoomOnClick write SetZoomOnClick;
  published
    property Align;
    property OnAddExplorerCommand: TdxPSPreviewWindowAddExplorerCommandEvent read FOnAddExplorerCommand write FOnAddExplorerCommand;
    property OnAfterPrintReport: TdxPSPreviewWindowAfterPrintReportEvent read FOnAfterPrintReport write FOnAfterPrintReport;
    property OnCanShowMarginHint: TdxPSPreviewWindowCanShowMarginHint read FOnCanShowMarginHint write FOnCanShowMarginHint;
    property OnCreationComplete: TNotifyEvent read FOnCreationComplete write FOnCreationComplete;
    property OnHFTextEntriesChanged: TNotifyEvent read FOnHFTextEntriesChanged write FOnHFTextEntriesChanged;
    property OnHFToolBarVisibleChanged: TdxPSPreviewWindowHFToolBarShow read FOnHFToolBarVisibleChanged write FOnHFToolBarVisibleChanged;
    property OnInitContent: TNotifyEvent read FOnInitContent write FOnInitContent;
    property OnLoadProperties: TdxPSPreviewWindowLoadPropertiesEvent read FOnLoadProperties write FOnLoadProperties;
    property OnPreviewDblClick: TNotifyEvent read FOnPreviewDblClick write FOnPreviewDblClick;
    property OnSaveProperties: TdxPSPreviewWindowLoadPropertiesEvent read FOnSaveProperties write FOnSaveProperties;
    property OnStyleListChanged: TNotifyEvent read FOnStyleListChanged write FOnStyleListChanged;
    property OnUpdateControls: TNotifyEvent read FOnUpdateControls write FOnUpdateControls;
    property OnUpdateExplorerCommands: TNotifyEvent read FOnUpdateExplorerCommands write FOnUpdateExplorerCommands;
    property OnZoomFactorChanged: TNotifyEvent read FOnZoomFactorChanged write FOnZoomFactorChanged;
    property OnZoomModeChanged: TNotifyEvent read FOnZoomModeChanged write FOnZoomModeChanged;
    property PreviewPopupMenu: TComponent read FPreviewPopupMenu write SetPreviewPopupMenu;
  end;

  { TdxPSStatusBarViewInfo }

  TdxPSStatusBarViewInfo = class(TObject)
  public
    BorderWidths: TRect;
    Bounds: TRect;
    SeparatorSize: Integer;
    SizeGripSize: TSize;
    TextIndent: Integer;
  end;

  { TdxPSStatusBarPanel }

  TdxPSStatusBarPanelStyle = (sbpsPanel, sbpsSeparator);

  TdxPSStatusBarPanel = class(TCollectionItem)
  private
    FAlignment: TAlignment;
    FBounds: TRect;
    FShowBorders: Boolean;
    FStyle: TdxPSStatusBarPanelStyle;
    FText: string;
    FTextRect: TRect;
    FWidth: Integer;
    procedure SetAlignment(AValue: TAlignment);
    procedure SetShowBorders(AValue: Boolean);
    procedure SetStyle(AStyle: TdxPSStatusBarPanelStyle);
    procedure SetText(const AText: string);
    procedure SetWidth(AValue: Integer);
  protected
    procedure Calculate(AViewInfo: TdxPSStatusBarViewInfo); virtual;
    //
    property Bounds: TRect read FBounds;
    property TextRect: TRect read FTextRect;
  public
    constructor Create(Collection: TCollection); override;
    //
    property Alignment: TAlignment read FAlignment write SetAlignment;
    property ShowBorders: Boolean read FShowBorders write SetShowBorders;
    property Style: TdxPSStatusBarPanelStyle read FStyle write SetStyle;
    property Text: string read FText write SetText;
    property Width: Integer read FWidth write SetWidth;
  end;

  { TdxPSStatusBarPanels }

  TdxPSStatusBarPanels = class(TCollection)
  private
    FStatusBar: TdxPSCustomStatusBar;
    function GetItem(Index: Integer): TdxPSStatusBarPanel;
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AStatusBar: TdxPSCustomStatusBar); virtual;
    function Add: TdxPSStatusBarPanel;
    function First: TdxPSStatusBarPanel;
    function Last: TdxPSStatusBarPanel;
    //
    property Items[Index: Integer]: TdxPSStatusBarPanel read GetItem; default;
    property StatusBar: TdxPSCustomStatusBar read FStatusBar;
  end;

  TdxPSStatusBarPanelGetDrawParamsEvent = procedure (ASender: TdxPSCustomStatusBar;
    APanel: TdxPSStatusBarPanel; var ABkgColor, ATextColor: TColor) of object; 

  { TdxPSCustomStatusBar }

  TdxPSCustomStatusBar = class(TcxControl)
  private
    FOnPanelGetDrawParams: TdxPSStatusBarPanelGetDrawParamsEvent;
    FPanels: TdxPSStatusBarPanels;
    FSizeGrip: Boolean;
    FSizeGripRect: TRect;
    FUpdateCount: Integer;
    function GetContentRect: TRect;
    function GetTextColor: TColor;
    procedure SetSizeGrip(AValue: Boolean);
  protected
    function CanShowSizeGrip: Boolean;
    procedure Calculate; virtual;
    procedure CalculateSizeGripBounds(AViewInfo: TdxPSStatusBarViewInfo); virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    function CreateViewInfo: TdxPSStatusBarViewInfo; virtual;
    procedure DoGetPanelDrawParams(APanel: TdxPSStatusBarPanel; var ABkgColor, ATextColor: TColor); virtual;
    procedure DrawBackground(ACanvas: TcxCanvas; const R: TRect); virtual;
    procedure DrawItem(ACanvas: TcxCanvas; APanel: TdxPSStatusBarPanel); virtual;
    procedure DrawPanelItem(ACanvas: TcxCanvas; APanel: TdxPSStatusBarPanel); virtual;
    procedure DrawPanelItemText(ACanvas: TcxCanvas; APanel: TdxPSStatusBarPanel; ATextColor: TColor); virtual;
    procedure DrawSepartorItem(ACanvas: TcxCanvas; APanel: TdxPSStatusBarPanel); virtual;
    procedure DrawSizeGrip(ACanvas: TcxCanvas; const R: TRect); virtual;
    procedure Paint; override;
    procedure Recalculate; virtual;
    procedure UpdateStateChanged(AUnlocked: Boolean);
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    //
    property ContentRect: TRect read GetContentRect;
    property SizeGripRect: TRect read FSizeGripRect;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function PanelFromPoint(APoint: TPoint; var APanel: TdxPSStatusBarPanel): Boolean; virtual;
    function PanelRect(AIndex: Integer): TRect; virtual;
    procedure InvalidatePanel(AIndex: Integer); virtual;
    //
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    //
    property OnPanelGetDrawParams: TdxPSStatusBarPanelGetDrawParamsEvent read FOnPanelGetDrawParams write FOnPanelGetDrawParams;
    property Panels: TdxPSStatusBarPanels read FPanels;
    property SizeGrip: Boolean read FSizeGrip write SetSizeGrip;
  end;

  { TdxPSStatusBar }

  TdxPSStatusBar = class(TdxPSCustomStatusBar)
  published
    property OnPanelGetDrawParams;
    property Panels;
    property SizeGrip;
  end;

function GetCurrentPrinterAsHint: string;
  
function AddStatusPanel(AStatusBar: TdxPSCustomStatusBar; AAlignment: TAlignment;
  AShowBorder: Boolean; const AText: string; AWidth: Integer;
  AStyle: TdxPSStatusBarPanelStyle = sbpsPanel): TdxPSStatusBarPanel;
  
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
  CommCtrl, Math, Registry, ShlObj, ShellApi,
{$IFDEF DELPHI7}
  UxTheme, Themes,
{$ENDIF}
{$IFDEF OLEDRAGANDDROP}
  ActiveX,
{$ENDIF}
  dxCore, cxClasses, dxPSRes, 
  dxPrnDev, dxPSUtl, dxPgsDlg, dxfmClr, dxfmMnPg, dxfmDTFmt, dxfmPNFmt, dxPSEngn, 
  dxPSExtDlgs, dxPSPopupMan, dxPSEvnt, dxfmZoom, Types, dxPSForm, dxPSHFLibrary;

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

{ TdxPSExplorerToolBar }  

procedure TdxPSExplorerToolBar.Paint;
var
  R: TRect;
begin
  R := ClientRect;
  LookAndFeelPainter.DrawPanelBackground(Canvas, Self, R, Color);
  LookAndFeelPainter.DrawPanelContent(Canvas, R, False);
  InflateRect(R, -2, -2);
  Canvas.Font.Assign(Font);
  Canvas.Brush.Style := bsClear;
  Canvas.DrawTexT(Caption, R, cxAlignLeft or cxAlignVCenter);
end;

{ TdxPSExplorerHostPanel }

procedure TdxPSExplorerHostPanel.Paint;
begin
  LookAndFeelPainter.DrawPanelBackground(Canvas, Self, ClientRect, Color);
  LookAndFeelPainter.DrawPanelContent(Canvas, ClientRect, False);
end;

{ TdxPSExplorerCloseButton }

constructor TdxPSExplorerCloseButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Flat := True;
  Transparent := True;
  Glyph := ClosePaneGlyph;
  Hint := cxGetResourceString(@sdxCloseExplorerHint);
  Name := sdxExplorerCloseButton;
  ShowHint := True;
end;
    
{ helpers }
    
function GetCurrentPrinterAsHint: string;
begin
  Result := dxPrintDevice.CurrentDevice;
  if Result <> '' then 
    Result := ' (' + Result + ')';
end;    

function AddStatusPanel(AStatusBar: TdxPSCustomStatusBar; AAlignment: TAlignment;
  AShowBorder: Boolean; const AText: string; AWidth: Integer;
  AStyle: TdxPSStatusBarPanelStyle = sbpsPanel): TdxPSStatusBarPanel;
begin
  AStatusBar.BeginUpdate;
  try
    Result := AStatusBar.Panels.Add;
    Result.Alignment := AAlignment;
    Result.ShowBorders := AShowBorder;
    Result.Text := AText;
    if (AWidth <> -1) and (AText <> '') then
      AWidth := Max(6 + AStatusBar.Canvas.TextWidth(AText), AWidth);
    Result.Width := AWidth;
    Result.Style := AStyle;
  finally
    AStatusBar.EndUpdate;
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
  
constructor TdxPSPreviewExplorerChangeNotifier.Create(APreview: TdxPSPreviewWindow);
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

{ TdxPSPreviewWindowCustomHost }

procedure TdxPSPreviewWindowCustomHost.DoSizeChanging(var AWidth, AHeight: Integer);
begin
  if Assigned(OnSizeChanging) then OnSizeChanging(Self, AWidth, AHeight);
end;

procedure TdxPSPreviewWindowCustomHost.Paint;
begin
  LookAndFeelPainter.DrawWindowContent(Canvas, ClientRect);
end;

procedure TdxPSPreviewWindowCustomHost.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  DoSizeChanging(AWidth, AHeight);
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
end;

{ TdxPSPreviewWindow }  

constructor TdxPSPreviewWindow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
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

destructor TdxPSPreviewWindow.Destroy;
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
  inherited Destroy;
end;

procedure TdxPSPreviewWindow.AfterConstruction;
begin
  FSaveZoomPosition := True;
  FShowStatusBar := True;
  FShowMarginBar := True;
  LoadZooms;
  FHFFunctionList := TStringList.Create;
  dxGetHFFunctionsList(FHFFunctionList);
  CreateControls;
  LoadStrings;
  inherited AfterConstruction;
end;

procedure TdxPSPreviewWindow.BeforeDestruction;
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

function TdxPSPreviewWindow.CalculateStatusBarHeight: Integer;
var
  AOldFont: HFONT;
  DC: HDC;
begin
  DC := GetDC(0);
  try
    AOldFont := SelectObject(DC, Font.Handle);
    Result := 2 * GetSystemMetrics(SM_CXBORDER) + 2 * (3 + Ord(Flat)) + cxTextSize(DC, 'Wq').cy;
    SelectObject(DC, AOldFont);
  finally
    ReleaseDC(0, DC);
  end;
end;

procedure TdxPSPreviewWindow.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_ESCAPE) and (ComponentPrinter <> nil) then
  begin
    if IsBuilding then ComponentPrinter.AbortBuilding := True;
    if IsPrinting then ComponentPrinter.AbortPrinting := True;
  end;  
end;

procedure TdxPSPreviewWindow.WndProc(var Message: TMessage);
begin
  inherited WndProc(Message);
  case message.Msg of 
    DXM_PS_UPDATEMARGINS:
      UpdateMarginBar;
    DXM_PS_UPDATESTATUSPROGRESS:
      UpdateStatusText;
  end;    
end;
                  
procedure TdxPSPreviewWindow.CreateControls;
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

procedure TdxPSPreviewWindow.CreateEventSubscribers;
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

procedure TdxPSPreviewWindow.CreateExplorerPane;
begin
  FExplorerPane := TdxPSPreviewWindowCustomHost.Create(Self);
  ExplorerPane.Parent := Self;
  ExplorerPane.Align := alLeft;
  ExplorerPane.Name := sdxExplorerPane;
  CreateExplorerToolBar;
  CreateExplorerTreeHost;
end;

procedure TdxPSPreviewWindow.CreateExplorerSplitter;
begin
  FExplorerSplitter := CreateSplitter(alLeft, sdxExplorerSplitter,
    ExplorerPane.Left + ExplorerPane.Width + 1, Self, ExplorerPane,
    ExplorerSplitterCanResize);
end;
                           
procedure TdxPSPreviewWindow.CreateExplorerToolBar;

  function CalculateHeight: Integer;
  var
    AOldFont: HFONT;
    DC: HDC;
  begin
    DC := GetDC(0);
    try
      AOldFont := SelectObject(DC, FExplorerToolBar.Font.Handle);
      Result := MulDiv(cxTextSize(DC, 'Wg').cY, 3, 2);
      SelectObject(DC, AOldFont);
    finally
      ReleaseDC(0, DC);
    end;
  end;

  procedure DoCreateToolBar;
  begin 
    FExplorerToolBar := TdxPSExplorerToolBar.Create(Self);
    FExplorerToolBar.Parent := ExplorerPane;
    FExplorerToolBar.Align := alTop;
    FExplorerToolBar.Caption := ' ' + cxGetResourceString(@sdxExplorerCaption);
    FExplorerToolBar.Height := CalculateHeight;
    FExplorerToolBar.Name := sdxExplorerToolBar;
    FExplorerToolBar.OnResize := ExplorerToolBarResize;
    InitializeControlLookAndFeel(FExplorerToolBar);
  end;
  
  procedure DoCreateCloseButton;
  const
    ButtonSize = 18;
  begin
    FExplorerCloseButton := TdxPSExplorerCloseButton.Create(Self);
    FExplorerCloseButton.Parent := FExplorerToolBar;
    FExplorerCloseButton.SetBounds(
      0, (FExplorerToolBar.ClientHeight - ButtonSize) div 2, ButtonSize, ButtonSize);
    FExplorerCloseButton.Anchors := [akTop, akRight];
    FExplorerCloseButton.OnClick := ExplorerClose;
    DoExplorerButtonsPosUpdate;
  end;

begin
  DoCreateToolBar;
  DoCreateCloseButton;
end;

procedure TdxPSPreviewWindow.CreateExplorerTreeHost;
begin
  FExplorerTreeHost := TdxPSExplorerHostPanel.Create(Self);
  FExplorerTreeHost.Parent := ExplorerPane;
  FExplorerTreeHost.Align := alClient;
  FExplorerTreeHost.Name := sdxExplorerTreeHost;
  InitializeControlLookAndFeel(FExplorerTreeHost);
end;

procedure TdxPSPreviewWindow.CreateMarginBar;
begin
  FMarginBar := TdxPSStatusBar.Create(Self);
  FMarginBar.Parent := FPreviewPane;
  FMarginBar.Align := alTop;
  FMarginBar.Canvas.Font := Font;
  FMarginBar.Height := CalculateStatusBarHeight;
  FMarginBar.Name := sdxMarginBar;
  FMarginBar.SizeGrip := False;
  FMarginBar.OnDblClick := MarginBarDblClick;
  FMarginBar.OnPanelGetDrawParams := MarginBarGetDrawParams;
  FMarginBar.LookAndFeel.MasterLookAndFeel := LookAndFeel; 

  AddStatusPanel(FMarginBar, taLeftJustify, False, DropAmpersand(cxGetResourceString(@sdxMargins)), 55);
  AddStatusPanel(FMarginBar, taRightJustify, False, DropAmpersand(cxGetResourceString(@sdxLeft)), 40);
  AddStatusPanel(FMarginBar, taRightJustify, not Flat, '', 70);
  AddStatusPanel(FMarginBar, taRightJustify, False, DropAmpersand(cxGetResourceString(@sdxTop)), 40);
  AddStatusPanel(FMarginBar, taRightJustify, not Flat, '', 70);
  AddStatusPanel(FMarginBar, taRightJustify, False, DropAmpersand(cxGetResourceString(@sdxRight)), 50);
  AddStatusPanel(FMarginBar, taRightJustify, not Flat, '', 70);   
  AddStatusPanel(FMarginBar, taRightJustify, False, DropAmpersand(cxGetResourceString(@sdxBottom)), 60);
  AddStatusPanel(FMarginBar, taRightJustify, not Flat, '', 70);
  AddStatusPanel(FMarginBar, taRightJustify, False, DropAmpersand(cxGetResourceString(@sdxHeader2)), 50);
  AddStatusPanel(FMarginBar, taRightJustify, not Flat, '', 70);
  AddStatusPanel(FMarginBar, taRightJustify, False, DropAmpersand(cxGetResourceString(@sdxFooter2)), 50);
  AddStatusPanel(FMarginBar, taRightJustify, not Flat, '', 70);
  AddStatusPanel(FMarginBar, taRightJustify, False, '',  -1);
end;

procedure TdxPSPreviewWindow.CreatePreview;
begin
  FPreview := TdxPreview.Create(Self);
  FPreview.Parent := FPreviewPane;
  FPreview.Align := alClient;
  if IsWin9X then
    FPreview.OptionsBehavior := FPreview.OptionsBehavior - [pobThumbTracking];
  FPreview.Name := sdxPreviewControl;
  FPreview.OnCanShowMarginHint := PreviewCanShowMarginHint;
  FPreview.OnDblClick := PreviewDblClick;
  FPreview.OnSelectingPage := PreviewSelectingPage;
  FPreview.LookAndFeel.MasterLookAndFeel := LookAndFeel;
  FPreview.PopupMenu := PreviewPopupMenu;
  TdxPreviewPageBackground(FPreview.PageBackground).OnApply := FillEffectsApply;
end;

procedure TdxPSPreviewWindow.CreatePreviewPane;
begin
  FPreviewPane := TdxPSPreviewWindowCustomHost.Create(Self);
  FPreviewPane.Parent := Self;
  FPreviewPane.Align := alClient;
  FPreviewPane.BevelInner := bvNone;
  FPreviewPane.BevelOuter := bvNone;
  FPreviewPane.Caption := '';
  FPreviewPane.Name := sdxPreviewPane;
end;
  
procedure TdxPSPreviewWindow.CreateProgressBar;
begin
  FProgressBar := TProgressBar.Create(Self);
  FProgressBar.Name := sdxProgressBar;
  FProgressBar.BorderWidth := 2;
end;

procedure TdxPSPreviewWindow.CreateStatusBar;
begin
  FStatusBar := TdxPSStatusBar.Create(Self);
  FStatusBar.Parent := Self;
  FStatusBar.ShowHint := True;
  FStatusBar.SizeGrip := True;
  FStatusBar.Name := sdxStatusBar;
  FStatusBar.Height := CalculateStatusBarHeight;
  FStatusBar.LookAndFeel.MasterLookAndFeel := LookAndFeel;
  RefreshStatusPanels(psbmNormal);
end;

function TdxPSPreviewWindow.CreateSplitter(AAlign: TAlign;
  const AName: string; ALeft: Integer; AParent: TWinControl;
  AResizeControl: TControl; OnCanResizeEvent: TCanResizeEvent): TcxCustomSplitter;
begin
  Result := TcxSplitter.Create(Self);
  Result.Parent := AParent;
  Result.Align := AAlign;
  Result.Width := 5;
  Result.Name := AName;
  Result.Left := ALeft;
  InitializeControlLookAndFeel(Result);
  TcxSplitter(Result).OnCanResize := OnCanResizeEvent;
  TcxSplitter(Result).Control := AResizeControl;
end;

procedure TdxPSPreviewWindow.CreateThumbnailsPane;
begin
  FThumbnailsPane := TdxPSPreviewWindowCustomHost.Create(Self);
  ThumbnailsPane.Parent := PreviewPane;
  ThumbnailsPane.Align := alRight;
  ThumbnailsPane.BevelInner := bvNone;
  ThumbnailsPane.BevelOuter := bvNone;
  ThumbnailsPane.Caption := '';
  ThumbnailsPane.Name := sdxThumbnailsPane;
end;

procedure TdxPSPreviewWindow.CreateThumbnailsSplitter;
begin
  FThumbnailsSplitter := CreateSplitter(alRight, sdxThumbnailsSplitter,
    FThumbnailsPane.Left - 1, PreviewPane, ThumbnailsPane,
    ThumbnailsSplitterCanResize);
end;

procedure TdxPSPreviewWindow.CreateThumbnailsPreview;
begin
  FThumbnailsPreview := TdxPreview.Create(Self);
  FThumbnailsPreview.Parent := FThumbnailsPane;
  FThumbnailsPreview.Align := alClient;
  FThumbnailsPreview.LookAndFeel.MasterLookAndFeel := LookAndFeel;
  FThumbnailsPreview.MinZoomFactor := 5;
  FThumbnailsPreview.Name := sdxThumbnailsPreviewControl;
  FThumbnailsPreview.OptionsBehavior := FThumbnailsPreview.OptionsBehavior + [pobNonCenterizePages];
  if IsWin9X then
    FThumbnailsPreview.OptionsBehavior := FThumbnailsPreview.OptionsBehavior - [pobThumbTracking];
  FThumbnailsPreview.OptionsView := FThumbnailsPreview.OptionsView - [povMargins];
  FThumbnailsPreview.OptionsZoom := FThumbnailsPreview.OptionsZoom - [pozZoomOnClick];
  FThumbnailsPreview.ZoomFactor := dxThumbnailsZoomFactors[ThumbnailsSize];
  FThumbnailsPreview.OnSelectedPageChanged := ThumbnailsPreviewSelectedPageChanged;
  FThumbnailsPreview.OnSelectingPage := PreviewSelectingPage;
end;

procedure TdxPSPreviewWindow.RefreshStatusPanels(AStatusBarMode: TdxPSPreviewWindowStatusBarMode);

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
  StatusBar.BeginUpdate;
  try
    StatusBar.Panels.Clear;
    case AStatusBarMode of
      psbmNormal:
        begin
          AddStatusPanel(StatusBar, taRightJustify, False, DropAmpersand(cxGetResourceString(@sdxPage)) +  ':', 40);
          AddStatusPanel(StatusBar, taRightJustify, not Flat, '', 45);
          AddStatusPanel(StatusBar, taCenter, False, cxGetResourceString(@sdxOf), 30);
          AddStatusPanel(StatusBar, taRightJustify, not Flat, '', 45);
          AddStatusPanel(StatusBar, taRightJustify, False, cxGetResourceString(@sdxPages), 50);
          AddStatusPanel(StatusBar, taLeftJustify, not Flat, '', 4, sbpsSeparator);
          AddStatusPanel(StatusBar, taRightJustify, False, cxGetResourceString(@sdxPaperSize), 80);
          AddStatusPanel(StatusBar, taRightJustify, not Flat, '', 150);   
          AddStatusPanel(StatusBar, taRightJustify, False, cxGetResourceString(@sdxStatus), 60);
          AddStatusPanel(StatusBar, taLeftJustify, not Flat, cxGetResourceString(@sdxStatusReady), -1);

          StatusBar.OnDblClick := StatusBarDblClick;
          StatusBar.OnMouseMove := StatusBarMouseMove;
       end;
       
     psbmProgress:
       begin
          // !!! Update GetProgressStatusPanel in case of change ProgressBar Site Index

          //AddStatusPanel(StatusBar, taLeftJustify, psText, pbNone, GetProgressModeCaption, 2);
          AddStatusPanel(StatusBar, taLeftJustify, False, '', 300);   //ProgressBar Site
          AddStatusPanel(StatusBar, taLeftJustify, False, GetProgressModeCaption, -1);
          //AddStatusPanel(StatusBar, taLeftJustify, psText, pbNone, cxGetResourceString(@sdxPressEscToCancel), -1); 
          StatusBar.OnDblClick := nil;
          StatusBar.OnMouseMove := nil;
       end;
    end;
  finally
    StatusBar.EndUpdate;
  end;
end;

procedure TdxPSPreviewWindow.BeginUpdate;
begin
  Preview.BeginUpdate;
  Inc(FUpdateCount);
end;

procedure TdxPSPreviewWindow.CancelUpdate;
begin
  if FUpdateCount <> 0 then 
  begin
    Preview.CancelUpdate;
    Dec(FUpdateCount);
  end;
end;

procedure TdxPSPreviewWindow.EndUpdate;
begin
  if FUpdateCount <> 0 then 
  begin
    Preview.EndUpdate;
    Dec(FUpdateCount);
    if FUpdateCount = 0 then
      UpdateControls;
  end;
end;

function TdxPSPreviewWindow.Locked: Boolean;
begin
  Result := FUpdateCount <> 0;
end;

{$IFDEF OLEDRAGANDDROP}
function TdxPSPreviewWindow.DoCanAccept: Boolean;
begin
  Result := inherited DoCanAccept and IsVisible(pvoReportFileOperations);
end;
{$ENDIF}

procedure TdxPSPreviewWindow.LoadZooms;
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

function TdxPSPreviewWindow.CanClosePreviewWindow: Boolean;
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
  
function TdxPSPreviewWindow.GetActivePageIndex: Integer;
begin
  if Preview <> nil then
    Result := Preview.SelPageIndex
  else
    Result := 0;
end;

function TdxPSPreviewWindow.GetBackground: TdxBackground;
begin
  if Preview <> nil then
    Result := Preview.PageBackground
  else
    Result := nil;
end;

function TdxPSPreviewWindow.GetExplorerTree: TCustomdxPSExplorerTreeContainer;
begin
  Result := FExplorerTree;
end;

function TdxPSPreviewWindow.GetState: TdxPSPreviewState;
begin
  Result := FState;
end;

function TdxPSPreviewWindow.GetThumbnailsSize: TdxPSThumbnailsSize;
begin
  Result := FThumbnailsSize;
end;
                   
function TdxPSPreviewWindow.GetVisiblePageSize: TPoint;
begin
  if Preview <> nil then
    Result := Preview.VisiblePageSize
  else
    Result := Point(0, 0);
end;

function TdxPSPreviewWindow.GetZoomFactor: Integer;
begin
  if Preview <> nil then
    Result := Preview.ZoomFactor
  else
    Result := 100;
end;

function TdxPSPreviewWindow.GetExplorer: TCustomdxPSExplorer;
begin
  if ComponentPrinter <> nil then
    Result := ComponentPrinter.Explorer
  else
    Result := nil;
end;

function TdxPSPreviewWindow.GetExplorerPaneWidth: Integer;
begin
  if ExplorerPane = nil then
    Result := 0
  else
    Result := ExplorerPane.Width;
end;

function TdxPSPreviewWindow.GetFlat: Boolean;
begin
  Result := (dxPSEngine.DialogsLookAndFeel.Kind in [lfFlat, lfOffice11]) and not
    (dxPSEngine.IsSkinsStyle
    {$IFDEF DELPHI7}
      or dxPSEngine.IsNativeStyle or ThemeServices.ThemesEnabled
    {$ENDIF});
end;

function TdxPSPreviewWindow.GetIsExplorerAvailable: Boolean;
begin
  Result := Explorer <> nil;
end;

function TdxPSPreviewWindow.GetIsExplorerMode: Boolean;
begin
  Result := (ComponentPrinter <> nil) and (ComponentPrinter.Explorer <> nil);
end;

function TdxPSPreviewWindow.GetPrinterPage: TdxPrinterPage;
begin
  if ReportLink <> nil then
    Result := ReportLink.RealPrinterPage
  else
    Result := nil;
end;

function TdxPSPreviewWindow.GetPreviewEnableOptions: TdxPreviewEnableOptions;
begin
  Result := FEnableOptions;
end;

function TdxPSPreviewWindow.GetPreviewVisibleOptions: TdxPreviewVisibleOptions;
begin
  Result := FVisibleOptions;
end;

function TdxPSPreviewWindow.GetHFEditPart: TdxPageTitlePart;
begin
  Result := FHFEditPart;
end;

function TdxPSPreviewWindow.GetPageCount: Integer;
begin
  if Preview <> nil then 
    Result := Preview.PageCount
  else
    Result := 0;
end;

function TdxPSPreviewWindow.GetSaveZoomPosition: Boolean;
begin
  Result := FSaveZoomPosition;
end;

function TdxPSPreviewWindow.GetShowExplorer: Boolean;
begin
  Result := FShowExplorer;
end;

function TdxPSPreviewWindow.GetShowThumbnails: Boolean;
begin
  Result := FShowThumbnails;
end;

function TdxPSPreviewWindow.GetProgressStatusPanel: TdxPSStatusBarPanel;
begin
  Result := StatusBar.Panels.First;
end;

function TdxPSPreviewWindow.GetShowMarginBar: Boolean;
begin
  Result := FShowMarginBar;
end;

function TdxPSPreviewWindow.GetShowPageMargins: Boolean;
begin
  Result := pvoPageMargins in VisibleOptions;
end;

function TdxPSPreviewWindow.GetShowStatusBar: Boolean;
begin
  Result := FShowStatusBar;
end;

function TdxPSPreviewWindow.GetStatusTextPanel: TdxPSStatusBarPanel;
begin
  Result := StatusBar.Panels.Last;
end;

function TdxPSPreviewWindow.GetThumbnailsPaneWidth: Integer;
begin
  if ThumbnailsPane <> nil then 
    Result := ThumbnailsPane.Width
  else
    Result := 0;
end;

procedure TdxPSPreviewWindow.SetPreviewPopupMenu(AValue: TComponent);
begin
  FPreviewPopupMenu := AValue;
  if Assigned(Preview) then
    Preview.PopupMenu := AValue;
end;

procedure TdxPSPreviewWindow.SetActivePageIndex(Value: Integer);
begin
  if Preview <> nil then 
    Preview.SelPageIndex := Value;
end;

procedure TdxPSPreviewWindow.SetState(const Value: TdxPSPreviewState);
begin
  FState := Value;
end;

procedure TdxPSPreviewWindow.SetThumbnailsSize(const Value: TdxPSThumbnailsSize);
begin
  if FThumbnailsSize <> Value then
  begin
    FThumbnailsSize := Value;
    UpdateThumbnailsSize;
    UpdateControls;
  end;
end;

procedure TdxPSPreviewWindow.SetZoomFactor(Value: Integer);
begin
  if Preview <> nil then 
    Preview.ZoomFactor := Value;
end;

procedure TdxPSPreviewWindow.CreationComplete;
begin
  inherited CreationComplete;
  if FSavePageMarginsVisibility <> mvsUndefined then
    ShowPageMargins := FSavePageMarginsVisibility = mvsShown;
  InitializePreviewWindowLayout;
  DoCreationComplete;
end;

procedure TdxPSPreviewWindow.InitializeControlLookAndFeel(AControl: TControl);
var
  AContainer: IcxLookAndFeelContainer;
begin
  if Supports(AControl, IcxLookAndFeelContainer, AContainer) then
    AContainer.GetLookAndFeel.MasterLookAndFeel := LookAndFeel;
end;

procedure TdxPSPreviewWindow.InitializePreviewWindowLayout;
begin
  PreviewPane.OnResize := DoUpdatePanesState;
  if Assigned(ThumbnailsPane) then
  begin
    ThumbnailsPane.OnResize := DoUpdatePanesState;
    ThumbnailsPane.OnSizeChanging := ThumbnailsPreviewSizeChanging;
  end;
  if Assigned(ExplorerPane) then
  begin
    ExplorerPane.OnResize := DoUpdatePanesState;
    ExplorerPane.OnSizeChanging := ExplorerPaneSizeChanging;
  end;
  PreviewPane.Realign;
end;

procedure TdxPSPreviewWindow.Paint;
begin
  LookAndFeelPainter.DrawWindowContent(Canvas, ClientRect);
end;

procedure TdxPSPreviewWindow.Resize;
begin
  inherited Resize;
  if Assigned(FStatusBar) then
  begin
    FStatusBar.Calculate;
    FStatusBar.Invalidate;
  end;
end;

procedure TdxPSPreviewWindow.SetBackground(const Value: TdxBackground);
begin
  if Preview <> nil then 
    Preview.PageBackground := Value;
  UpdateControls;
end;

procedure TdxPSPreviewWindow.AddExplorerContextCommand(
  ACommand: TCustomdxPSExplorerContextCommand);
begin
  if Assigned(OnAddExplorerCommand) then
    OnAddExplorerCommand(Self, ACommand);
end;

procedure TdxPSPreviewWindow.DoCreationComplete;
begin
  if Assigned(OnCreationComplete) then OnCreationComplete(Self);
end;

procedure TdxPSPreviewWindow.DoInitContent;
begin
  if Assigned(OnInitContent) then OnInitContent(Self);
end;

procedure TdxPSPreviewWindow.UpdateExplorerContextCommands;
begin
  if Assigned(OnUpdateExplorerCommands) then
    OnUpdateExplorerCommands(Self);
end;

procedure TdxPSPreviewWindow.UpdateControlsPosition;
begin
  if IsExplorerAvailable then
    ExplorerSplitter.Left := ExplorerPane.Width + 1;
  if Assigned(ThumbnailsPane) then
  begin
    ThumbnailsPane.AdjustSize;
    ThumbnailsSplitter.Left := ThumbnailsPane.Left - ThumbnailsSplitter.Width - 1;
  end;
end;

procedure TdxPSPreviewWindow.AfterComponentPrinterChanged;
var
  ExplorerTreeContainerHost: IdxPSExplorerTreeContainerHost;
  ExplorerContextCommands: IdxPSExplorerContextCommands;
  ExplorerContextCommandBuilder: IdxPSExplorerContextCommandBuilder;
begin
  inherited AfterComponentPrinterChanged;
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

procedure TdxPSPreviewWindow.SetFocusToControl(AControl: TWinControl);
begin
  if Form.Visible and Visible and Enabled and Assigned(AControl) then
  begin
    if AControl.CanFocus then
      AControl.SetFocus;
  end;
end;

procedure TdxPSPreviewWindow.SetHFEditPart(const Value: TdxPageTitlePart);
begin
  FHFEditPart := Value;
end;

procedure TdxPSPreviewWindow.SetPageCount(Value: Integer);
begin
  if Preview <> nil then 
    Preview.PageCount := Value;
  if ThumbnailsPreview <> nil then 
    ThumbnailsPreview.PageCount := Value;  
end;

procedure TdxPSPreviewWindow.SetPreviewEnableOptions(const Value: TdxPreviewEnableOptions);
begin
  FEnableOptions := Value;
  if (ReportLink <> nil) and not ReportLink.CheckToDesign then
    FEnableOptions := FEnableOptions - [peoReportDesign];
  UpdateControls;
end;

procedure TdxPSPreviewWindow.SetPreviewVisibleOptions(const Value: TdxPreviewVisibleOptions);
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

procedure TdxPSPreviewWindow.SetSaveZoomPosition(Value: Boolean);
begin
  FSaveZoomPosition := Value;
  if FPreview <> nil then
  begin
    if SaveZoomPosition then
      FPreview.OptionsStore := FPreview.OptionsStore + [posZoom]
    else
      FPreview.OptionsStore := FPreview.OptionsStore - [posZoom];
  end;
end;

procedure TdxPSPreviewWindow.SetShowExplorer(Value: Boolean);
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

procedure TdxPSPreviewWindow.SetShowThumbnails(Value: Boolean);
begin
  if FShowThumbnails <> Value then
  begin
    FShowThumbnails := Value;
    DoThumbnailsToggleShow(FShowThumbnails);
  end;
end;

procedure TdxPSPreviewWindow.SetExplorerPaneWidth(Value: Integer);
begin
  if ExplorerPane <> nil then 
    ExplorerPane.Width := Value;
end;

procedure TdxPSPreviewWindow.SetShowMarginBar(Value: Boolean);
begin
  if FShowMarginBar <> Value then
  begin
    FShowMarginBar := Value;
    if not (csLoading in ComponentState) then
      UpdateControls;
  end;
end;

procedure TdxPSPreviewWindow.SetShowPageMargins(Value: Boolean);
begin
  if (pvoPageMargins in VisibleOptions) <> Value then
    if Value then
      VisibleOptions := VisibleOptions + [pvoPageMargins]
    else   
      VisibleOptions := VisibleOptions - [pvoPageMargins];
end;

procedure TdxPSPreviewWindow.SetShowStatusBar(Value: Boolean);
begin
  if FShowStatusBar <> Value then
  begin
    FShowStatusBar := Value;
    UpdateControls;
  end;
end;

procedure TdxPSPreviewWindow.SetThumbnailsPaneWidth(Value: Integer);
begin
  if ThumbnailsPane <> nil then 
    ThumbnailsPane.Width := Value;
end;

function TdxPSPreviewWindow.GetZoomOnClick: Boolean;
begin
  Result := Assigned(Preview) and (pozZoomOnClick in Preview.OptionsZoom);
end;

procedure TdxPSPreviewWindow.SetZoomOnClick(AValue: Boolean);
begin
  if Assigned(Preview) then
  begin
    if AValue then
      Preview.OptionsZoom := Preview.OptionsZoom + [pozZoomOnClick]
    else
      Preview.OptionsZoom := Preview.OptionsZoom - [pozZoomOnClick];
  end;
end;

procedure TdxPSPreviewWindow.GoToFirstPage;
begin
  if Preview <> nil then 
    Preview.SelectFirstPage;
end;

procedure TdxPSPreviewWindow.GoToLastPage;
begin
  if Preview <> nil then 
    Preview.SelectLastPage;
end;

procedure TdxPSPreviewWindow.GoToNextPage;
begin
  if Preview <> nil then 
    Preview.SelectNextPage;
end;

procedure TdxPSPreviewWindow.GoToPrevPage;
begin
  if Preview <> nil then 
    Preview.SelectPrevPage;
end;

procedure TdxPSPreviewWindow.HFTextEntriesChanged;
begin
  if Assigned(OnHFTextEntriesChanged) then
    OnHFTextEntriesChanged(Self);
end;

procedure TdxPSPreviewWindow.LoadStrings;
begin
  if IsDesignTime then Exit;

  with FStatusBar do 
  begin
    Panels.Items[0].Text := DropAmpersand(cxGetResourceString(@sdxPage)) + ':';
    Panels.Items[2].Text := LowerCase(cxGetResourceString(@sdxOf));
    Panels.Items[4].Text := cxGetResourceString(@sdxPages);
    Panels.Items[6].Text := cxGetResourceString(@sdxPaperSize);
    Panels.Items[8].Text := cxGetResourceString(@sdxStatus);
    Panels.Items[9].Text := cxGetResourceString(@sdxStatusReady);
  end;  
end;

procedure TdxPSPreviewWindow.StyleListChanged(Sender: TObject);
begin
  if Assigned(OnStyleListChanged) then OnStyleListChanged(Self);
end;

function  TdxPSPreviewWindow.ValidateMargins: Boolean;
begin
  Result := (PrinterPage = nil) or PrinterPage.ValidateMargins;
end;

{ TdxPSPreviewWindow }

function TdxPSPreviewWindow.IdxPSExplorerTreeContainerHost_GetFlat: Boolean;
begin
  Result := Flat;
end;

function TdxPSPreviewWindow.IdxPSExplorerTreeContainerHost_GetReportLink: TBasedxReportLink;
begin
  Result := Self.ReportLink;
end;

function TdxPSPreviewWindow.GetTreeContainerParent: TWinControl;
begin
  Result := FExplorerTreeHost;
end;

procedure TdxPSPreviewWindow.UpdateState;
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

procedure TdxPSPreviewWindow.InitContent;
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
  DoInitContent;
end;

procedure TdxPSPreviewWindow.InvalidateContent;
begin
  if Preview <> nil then
    Preview.Invalidate;
  if ThumbnailsPreview <> nil then
    ThumbnailsPreview.Invalidate;
end;

procedure TdxPSPreviewWindow.InvalidatePage(APageIndex: Integer);
begin
  if Preview <> nil then 
    Preview.InvalidatePage(APageIndex);
  if ThumbnailsPreview <> nil then 
    ThumbnailsPreview.InvalidatePage(APageIndex);
end;

procedure TdxPSPreviewWindow.InvalidateAllPages;
begin
  if Preview <> nil then 
    Preview.InvalidatePages;
  if ThumbnailsPreview <> nil then 
    ThumbnailsPreview.InvalidatePages;
end;

procedure TdxPSPreviewWindow.InvalidatePagesContent;
begin
  if Preview <> nil then 
    Preview.InvalidatePagesContent;
  if ThumbnailsPreview <> nil then 
    ThumbnailsPreview.InvalidatePagesContent;
end;

procedure TdxPSPreviewWindow.InvalidatePagesHeaderContent;
begin
  if Preview <> nil then 
    Preview.InvalidatePagesHeader;
  if ThumbnailsPreview <> nil then 
    ThumbnailsPreview.InvalidatePagesHeader;
end;

procedure TdxPSPreviewWindow.InvalidatePagesFooterContent;
begin
  if Preview <> nil then 
    Preview.InvalidatePagesFooter;
  if ThumbnailsPreview <> nil then 
    ThumbnailsPreview.InvalidatePagesFooter;
end;

procedure TdxPSPreviewWindow.UpdateControls;
begin                                
  if not (Locked or IsDestroying) then
  begin
    inherited UpdateControls;
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
    finally
      CancelUpdate;
    end;
    DoUpdateControls;
  end;
end;

// event handlers

procedure TdxPSPreviewWindow.ExplorerClose(Sender: TObject);
begin
  ShowExplorer := False;
end;

procedure TdxPSPreviewWindow.ExplorerSplitterCanResize(
  Sender: TObject; var NewSize: Integer; var Accept: Boolean);
var
  ATempValue: Integer;
begin
  Accept := True;
  ExplorerPaneSizeChanging(Sender, NewSize, ATempValue);
end;

procedure TdxPSPreviewWindow.ExplorerToolBarResize(Sender: TObject);
begin
  DoExplorerButtonsPosUpdate;
end;

procedure TdxPSPreviewWindow.FillEffectsApply(Sender: TObject);
begin
  FPreview.PageBackground := TdxBackground(Sender);
  UpdateControls;
end;

procedure TdxPSPreviewWindow.PreviewMarginsChanged(Sender: TObject; AMargin: TdxPreviewPageMargin);
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

procedure TdxPSPreviewWindow.PreviewAfterDragMargin(Sender: TObject; AMargin: TdxPreviewPageMargin);
begin
  DoPreviewAfterDragMargin(TdxPreview(Sender), AMargin);
  UpdateControls;
end;

procedure TdxPSPreviewWindow.PreviewBeforeDragMargin(Sender: TObject; AMargin: TdxPreviewPageMargin);
begin
  DoPreviewBeforeDragMargin(TdxPreview(Sender), AMargin);
  UpdateControls;
end;

procedure TdxPSPreviewWindow.PreviewDragMargin(Sender: TObject; AMargin: TdxPreviewPageMargin);
begin
  DoPreviewDragMargin(TdxPreview(Sender), AMargin);  
end;

procedure TdxPSPreviewWindow.PreviewCalcPageCount(Sender: TObject);
begin
  if ReportLink <> nil then
  begin
    Preview.PageCount := ReportLink.VisiblePageCount;
    if Preview.DraggingMargin = nil then
      UpdateControls;
    ThumbnailsPreview.PageCount := Preview.PageCount;
  end;
end;
  
procedure TdxPSPreviewWindow.PreviewZoomFactorChanged(Sender: TObject);
begin
  if Assigned(OnZoomFactorChanged) then OnZoomFactorChanged(Self)
end;

procedure TdxPSPreviewWindow.PreviewZoomModeChanged(Sender: TObject);
begin
  if Assigned(OnZoomModeChanged) then OnZoomModeChanged(Self);
end;

procedure TdxPSPreviewWindow.PreviewCanShowMarginHint(
  Sender: TObject; var ACanShowHint: Boolean);
begin
  if Assigned(OnCanShowMarginHint) then
    OnCanShowMarginHint(Sender, ACanShowHint);
end;

procedure TdxPSPreviewWindow.PreviewSelectingPage(Sender: TObject; 
  APageIndex: Integer; var ACanSelect: Boolean);
begin
  if (ReportLink <> nil) and ReportLink.ShowEmptyPages and ReportLink.IsEmptyPage(APageIndex) then 
    ACanSelect := False;
end;  

procedure TdxPSPreviewWindow.PreviewSelectedPageChanged(Sender: TObject; APageIndex: Integer);
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

procedure TdxPSPreviewWindow.PreviewDblClick(Sender: TObject);
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

procedure TdxPSPreviewWindow.StatusBarDblClick(Sender: TObject);
var
  APoint: TPoint;
begin
  if CanPageSetup then
  begin
    GetCursorPos(APoint);
    if PtInRect(StatusBar.PanelRect(7), APoint) then
      DoPageSetupReport(0);
  end;
end;

procedure TdxPSPreviewWindow.StatusBarMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
const 
  PtInRect: Boolean = False;
var 
  APoint: TPoint;
begin
  if CanPageSetup then
  begin
    APoint := Point(X, Y);
    if Windows.PtInRect(StatusBar.PanelRect(7), APoint) xor PtInRect then
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

procedure TdxPSPreviewWindow.ThumbnailsPreviewSelectedPageChanged(
  Sender: TObject; APageIndex: Integer);
begin
  if not FLockPageSelection then
  begin
    FLockPageSelection := True;
    try
      Preview.SelPageIndex := APageIndex;
    finally
      FLockPageSelection := False;
    end;
  end;
end;

procedure TdxPSPreviewWindow.ThumbnailsSplitterCanResize(
  Sender: TObject; var NewSize: Integer; var Accept: Boolean);
var
  ATempValue: Integer; 
begin
  Accept := True;
  ThumbnailsPreviewSizeChanging(Sender, NewSize, ATempValue);
end;
  
procedure TdxPSPreviewWindow.MarginBarDblClick(Sender: TObject);
begin
  if CanPageSetup then
    DoPageSetupReport(1);
end;

procedure TdxPSPreviewWindow.MarginBarGetDrawParams(
  ASender: TdxPSCustomStatusBar; APanel: TdxPSStatusBarPanel;
  var ABkgColor, ATextColor: TColor);
begin
  if MarginStatusPanel(Preview.DraggingMargin) = APanel then
  begin
    ABkgColor := LookAndFeelPainter.DefaultSelectionColor;
    ATextColor := LookAndFeelPainter.DefaultSelectionTextColor;
  end;
end;

procedure TdxPSPreviewWindow.DoShowFormatDateTimeDlg;
begin
  if ReportLink.ShowDateTimeFormatsDlg then
  begin
    Preview.InvalidatePagesHeader;
    Preview.InvalidatePagesFooter;
  end;
end;

procedure TdxPSPreviewWindow.DoShowFormatPageNumbersDlg;
begin
  if ReportLink.ShowPageNumberFormatsDlg then 
  begin
    Preview.InvalidatePagesHeader;
    Preview.InvalidatePagesFooter;
  end;
end;

procedure TdxPSPreviewWindow.DoShowHFToolBar(Value: Boolean);
begin
  if Assigned(OnHFToolBarVisibleChanged) then
    OnHFToolBarVisibleChanged(Self, Value);
end;

procedure TdxPSPreviewWindow.DoShowZoomDlg;
begin
  dxZoomDlg(Preview);
end;

procedure TdxPSPreviewWindow.DoShowPageBackgroundDlg(const Pt: TPoint);
begin
  if dxChooseBackgroundDlg(Preview.PageBackground, Pt, dxDefaultBackgroundDlgData) then
    DoSyncPrintingPageBackground;
end;

procedure TdxPSPreviewWindow.DoShowMultiplySelectPagesDlg(AImageList: TCustomImageList;
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

procedure TdxPSPreviewWindow.DoShowEmptyPages(Value: Boolean);
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

procedure TdxPSPreviewWindow.DoShowOptionsDlg;
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
  
  if dxShowPSPreviewOptionsDlg(Data) then
    SavePreferences(Data);

  UpdateControls;
end;

procedure TdxPSPreviewWindow.DoShrinkToPageWidth(Value: Boolean);
begin
  if ReportLink <> nil then
  begin
    if FPreview.PageCount = ReportLink.VisiblePageCount then
      FPreview.Invalidate
    else
    begin
      FPreview.PageCount := ReportLink.VisiblePageCount;
      if ThumbnailsPreview <> nil then
        ThumbnailsPreview.PageCount := ReportLink.VisiblePageCount;
    end;
  end;
  UpdateControls;
end;

procedure TdxPSPreviewWindow.DoSyncPrintingPageBackground;
begin
  if Assigned(PrinterPage) then
    PrinterPage.Background := Preview.PageBackground;
end;

procedure TdxPSPreviewWindow.DoUpdateControls;
begin
  if Assigned(OnUpdateControls) then OnUpdateControls(Self);
end;

procedure TdxPSPreviewWindow.DoThumbnailsToggleShow(Value: Boolean);
begin
  if Value then 
  begin
    if FSaveThumbnailsPaneWidth <> -1 then 
      ThumbnailsPane.Width := FSaveThumbnailsPaneWidth
    else  
      ThumbnailsPane.Width := DefaultThumbnailsPaneWidth;
    SetFocusToControl(ThumbnailsPreview);
  end
  else
  begin
    ThumbnailsPane.Width := 0;
    ThumbnailsPane.Left := ThumbnailsPane.Parent.Width;
    SetFocusToControl(Preview);
  end;
  UpdateControlsPosition;
  UpdateControls;
end;

procedure TdxPSPreviewWindow.DoUnloadReportLinkData;
begin
  ReportLink.DataSource := rldsComponent;
end;

procedure TdxPSPreviewWindow.DoUpdatePanesState(Sender: TObject);
begin
  if Assigned(ExplorerPane) then  
  begin
    if ExplorerPane.Width <> 0 then
      FSaveExplorerPaneWidth := ExplorerPane.Width;
    ShowExplorer := ExplorerPane.Width <> 0;
  end;
  if Assigned(ThumbnailsPane) then
  begin
    if ThumbnailsPane.Width <> 0 then
      FSaveThumbnailsPaneWidth := ThumbnailsPane.Width;
    ShowThumbnails := ThumbnailsPane.Width <> 0;
  end;
  UpdateControlsPosition;
end;

procedure TdxPSPreviewWindow.ExplorerPaneSizeChanging(
  Sender: TObject; var AWidth, AHeight: Integer);
begin
  AWidth := Min(ClientWidth - MinPreviewSize.X, AWidth);
end;

procedure TdxPSPreviewWindow.ThumbnailsPreviewSizeChanging(
  Sender: TObject; var AWidth, AHeight: Integer);
begin
  AWidth := Min(PreviewPane.ClientWidth - MinPreviewSize.X, AWidth);
end;

procedure TdxPSPreviewWindow.UpdateThumbnailsSize;
begin
  ThumbnailsPreview.ZoomFactor := dxPSCore.dxThumbnailsZoomFactors[ThumbnailsSize];
end;

procedure TdxPSPreviewWindow.DoDesignReport;
begin
  if ReportLink <> nil then
  begin
    ReportLink.DesignReport;
    UpdateControls;
  end;   
end;

procedure TdxPSPreviewWindow.DoLoadReportLinkDataFromFile;
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

procedure TdxPSPreviewWindow.DoPageSetupReport(APageIndex: Integer);
var
  PreviewBtnClicked, PrintBtnClicked: Boolean;
begin
  if ComponentPrinter.PageSetupEx(APageIndex, False, CanPrintDialog, PreviewBtnClicked, PrintBtnClicked) then
  begin
    InitContent;
    UpdateControls;
  end;
  InvalidatePagesContent;
  if PrintBtnClicked then 
    DoPrintReport(True);
end;

procedure TdxPSPreviewWindow.DoPrintReport(AShowDialog: Boolean);
begin
  ComponentPrinter.Print(AShowDialog, nil, nil);
  UpdateControls;
  DoAfterPrintReport(AShowDialog);
  if FReleased then
    Self.Release;
end;

procedure TdxPSPreviewWindow.DoSaveReportLinkDataToFile;
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

function TdxPSPreviewWindow.CanDesign: Boolean;
begin
  Result := IsVisible(pvoReportDesign) and IsEnabled(peoReportDesign) and 
    (ReportLink <> nil) and ReportLink.CheckToDesign and not IsPrinting and not IsBuilding;
end;

function TdxPSPreviewWindow.CanPrint: Boolean;
begin
  Result := IsVisible(pvoPrint) and IsEnabled(peoPrint) and (ReportLink <> nil) and 
    (ReportLink.PageCount > 0) and (dxPrnDev.dxGetDefaultPrinter <> '') and not IsPrinting;
end;

function TdxPSPreviewWindow.CanPrintDialog: Boolean;
begin
  Result := CanPrint;
end;

function TdxPSPreviewWindow.CanPrintStyle: Boolean;
begin                                                                                       
  Result := (ReportLink <> nil) and (ReportLink.StyleManager <> nil) and 
    IsVisible(pvoPrintStyles);
end;

function TdxPSPreviewWindow.CanRebuild: Boolean;
begin
  Result := (ReportLink <> nil) and ReportLink.DataProviderPresent and 
    (ComponentPrinter.State * [cpsBuilding, cpsPrinting] = [])
end;

function TdxPSPreviewWindow.CanExport: Boolean;
begin
  Result := (ReportLink <> nil) and (ReportLink.PageCount > 0) and not IsPrinting;
end;

function TdxPSPreviewWindow.CanLoadReport: Boolean;
begin
  if IsExplorerAvailable then 
    Result := (ExplorerTree <> nil) and ExplorerTree.CanLoadSelectedItemData and not IsBuilding
  else
    Result := IsVisible(pvoReportFileOperations) and (ReportLink <> nil) and 
      ReportLink.CanLoadData and not IsBuilding;
end;

function TdxPSPreviewWindow.CanPageSetup: Boolean;
begin
  Result := IsVisible(pvoPageSetup) and IsEnabled(peoPageSetup) 
    and (ComponentPrinter <> nil) and not IsPrinting;
end;

function TdxPSPreviewWindow.CanChangeMargins: Boolean;
begin
  Result := IsEnabled(peoCanChangeMargins) and not IsPrinting and not IsBuilding;
end;

function TdxPSPreviewWindow.CanSaveReport: Boolean;
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

function TdxPSPreviewWindow.CanUnloadReport: Boolean;
begin
  if IsExplorerAvailable then
    Result := (ExplorerTree <> nil) and ExplorerTree.CanUnloadItemData
  else
    Result := IsVisible(pvoReportFileOperations) and (ReportLink <> nil) and 
      ReportLink.CanUnloadData;
end;

function TdxPSPreviewWindow.IsCommandLoadReportVisible: Boolean;
begin
  Result := IsExplorerAvailable or IsVisible(pvoReportFileOperations);
end;

function TdxPSPreviewWindow.IsCommandSaveReportVisible: Boolean;
begin
  Result := IsExplorerAvailable or IsVisible(pvoReportFileOperations);
end;

function TdxPSPreviewWindow.IsCommandUnloadReportVisible: Boolean;
begin
  Result := IsExplorerAvailable or IsVisible(pvoReportFileOperations);
end;

function TdxPSPreviewWindow.IsEnabled(AnOption: TdxPreviewEnableOption): Boolean;
begin
  Result := AnOption in FEnableOptions;
end;

function TdxPSPreviewWindow.IsVisible(AnOption: TdxPreviewVisibleOption): Boolean;
begin
  Result := AnOption in FVisibleOptions;
end;

function TdxPSPreviewWindow.IsAutoHFTextEntriesAvailable: Boolean;
begin
  Result := (ReportLink <> nil) and (ReportLink.StyleManager <> nil);
end;

function TdxPSPreviewWindow.IsBuilding: Boolean;
begin
  Result := (ComponentPrinter <> nil) and (cpsBuilding in ComponentPrinter.State);
end;

function TdxPSPreviewWindow.IsPrinting: Boolean;
begin
  Result := ((ComponentPrinter <> nil) and (cpsPrinting in ComponentPrinter.State)) or 
    dxPrintDevice.Printing;
end;

function TdxPSPreviewWindow.IsProgressState: Boolean;
begin
  Result := (ComponentPrinter <> nil) and 
    (ComponentPrinter.State * [cpsBuilding, cpsPrinting] <> []);
end;

function TdxPSPreviewWindow.IsStatusTextPanel(APanel: TdxPSStatusBarPanel): Boolean;
begin
  Result := APanel = StatusTextPanel;
end;

procedure TdxPSPreviewWindow.InvalidatePagesHeadersOrFooters;
begin
  case State of 
    prsEditHeaders: 
      FPreview.InvalidatePagesHeader;
    prsEditFooters:
      FPreview.InvalidatePagesFooter;
  end;
end;

procedure TdxPSPreviewWindow.RefreshStatusBar(AStatusSections: TfmPreviewStatusSections);
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
      StatusBar.InvalidatePanel(StatusBar.Panels.Count - 1);
    UpdateStatusBarPanelWidths(StatusBar);
  end;  
end;

procedure TdxPSPreviewWindow.RefreshMarginBar(AMargin: TdxPreviewPageMargin);
begin
  with FPreview do
  begin
    if Assigned(AMargin) and (AMargin.DraggingValue >= 0) then
      MarginStatusPanel(AMargin).Text := MarginValueToString(AMargin.DraggingValue)
    else
    begin
      MarginStatusPanel(Margins.Left).Text := MarginValueToString(Margins.Left.Value);
      MarginStatusPanel(Margins.Top).Text := MarginValueToString(Margins.Top.Value);
      MarginStatusPanel(Margins.Right).Text := MarginValueToString(Margins.Right.Value);
      MarginStatusPanel(Margins.Bottom).Text := MarginValueToString(Margins.Bottom.Value);
      MarginStatusPanel(Margins.Header).Text := MarginValueToString(Margins.Header.Value);
      MarginStatusPanel(Margins.Footer).Text := MarginValueToString(Margins.Footer.Value);
    end;
  end;
  MarginBar.Invalidate;
end;

function TdxPSPreviewWindow.IsMarginValueStatusPanel(APanel: TdxPSStatusBarPanel): Boolean;
const 
  Indexes: set of Byte = [2, 4, 6, 8, 10, 12];
begin
  Result := APanel.Index in Indexes;
end;

function TdxPSPreviewWindow.MarginStatusPanel(
  AMargin: TdxPreviewPageMargin): TdxPSStatusBarPanel;
//pmLeft, pmTop, pmRight, pmBottom, pmHeader, pmFooter
var
  AIndex: Integer;
begin
  AIndex := -1;
  if AMargin is TdxPreviewPageMarginLeft  then AIndex := 2;
  if AMargin is TdxPreviewPageMarginRight then AIndex := 6;
  if AMargin is TdxPreviewPageMarginTop   then AIndex := 4;
  if AMargin is TdxPreviewPageMarginBottom then AIndex := 8;
  if AMargin is TdxPreviewPageMarginFooter then AIndex := 12;
  if AMargin is TdxPreviewPageMarginHeader then AIndex := 10;
  
  if AIndex >= 0 then
    Result := FMarginBar.Panels.Items[AIndex]
  else
    Result := nil;
end;

function TdxPSPreviewWindow.SectionStatusPanel(
  AStatusSection: TfmPreviewStatusSection): TdxPSStatusBarPanel;
const 
  Indexes: array [TfmPreviewStatusSection] of Integer = (1, 3, 7, 9);
begin
  if Indexes[AStatusSection] < FStatusBar.Panels.Count then
    Result := FStatusBar.Panels.Items[Indexes[AStatusSection]]
  else
    Result := nil;
end;

procedure TdxPSPreviewWindow.SectionStatusPanelSetText(
  AStatusSection: TfmPreviewStatusSection; const AText: string);
begin
  if SectionStatusPanel(AStatusSection) <> nil then
    SectionStatusPanel(AStatusSection).Text := AText;
end;

procedure TdxPSPreviewWindow.DoPreviewMarginChanged(
  APreview: TdxPreview; AMargin: TdxPreviewPageMargin);
begin
  if FPreview.DraggingMargin = nil then
    RefreshMarginBar(AMargin);
end;

procedure TdxPSPreviewWindow.DoLoadFromIniFile(
  AIniFile: TCustomIniFile; const ASectionName: string);
begin
  if Assigned(OnLoadProperties) then
    OnLoadProperties(Self, AIniFile, ASectionName);
end;

procedure TdxPSPreviewWindow.DoSaveToIniFile(
  AIniFile: TCustomIniFile; const ASectionName: string);
begin
  if Assigned(OnSaveProperties) then
    OnSaveProperties(Self, AIniFile, ASectionName);
end;

procedure TdxPSPreviewWindow.DoPreviewAfterDragMargin(
  APreview: TdxPreview; AMargin: TdxPreviewPageMargin);
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

procedure TdxPSPreviewWindow.DoPreviewBeforeDragMargin(APreview: TdxPreview; 
  AMargin: TdxPreviewPageMargin);
begin
  RefreshMarginBar(AMargin);
end;

procedure TdxPSPreviewWindow.DoPreviewDragMargin(
  APreview: TdxPreview; AMargin: TdxPreviewPageMargin);
begin
  RefreshMarginBar(AMargin);
end;

procedure TdxPSPreviewWindow.DoPreviewDblClick(APreview: TdxPreview);
begin
  if Assigned(OnPreviewDblClick) then OnPreviewDblClick(Self);
end;

procedure TdxPSPreviewWindow.DoAfterPrintReport(AShowDialog: Boolean);
begin
  if Assigned(OnAfterPrintReport) then
    OnAfterPrintReport(Self, AShowDialog);
end;

procedure TdxPSPreviewWindow.DoSetupZoomFactor(AZoomFactor, APageXCount, 
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

procedure TdxPSPreviewWindow.DoActivePageChanged(AValue: Integer);
begin
  if Assigned(ReportLink) then
  begin
    if ReportLink.ShowEmptyPages then
      ActivePageIndex := ReportLink.RealPageIndexToVirtualPageIndex(AValue, True)
    else
      ActivePageIndex := AValue;
  end;
end;

procedure TdxPSPreviewWindow.DoExplorerButtonsPosUpdate;
begin
  FExplorerCloseButton.Left := FExplorerToolBar.ClientWidth - FExplorerCloseButton.Width - 1;
end;

procedure TdxPSPreviewWindow.DoExplorerCreateNewFolder;
begin
  if (ExplorerTree <> nil) and ExplorerTree.CanCreateFolder then
    Explorer.CreateNewFolder(ExplorerTree.CreationParent);
end;

procedure TdxPSPreviewWindow.DoExplorerCreateNewItem;
begin
  if CanSaveReport then
  begin 
    if not IsExplorerAvailable then
      DoSaveReportLinkDataToFile
    else
      if Assigned(ExplorerTree) then
      begin
        ExplorerTree.CreateItem;
        ShowExplorer := True;
      end;
  end;
end;

procedure TdxPSPreviewWindow.DoExplorerDeleteItem;
begin
  if ExplorerTree <> nil then
    ExplorerTree.DeleteSelection;
end;

function TdxPSPreviewWindow.DoExplorerItemShowPropertySheets: Boolean;
begin
  Result := (ExplorerTree <> nil) and ExplorerTree.ShowSelectedItemPropertySheets;
end;
                           
procedure TdxPSPreviewWindow.DoExplorerLoadItemData;
begin
  if CanLoadReport then
  begin
    if IsExplorerAvailable then
      ExplorerTree.LoadSelectedItemData
    else
      DoLoadReportLinkDataFromFile;    
  end;
end;

procedure TdxPSPreviewWindow.DoExplorerRenameItem;
begin
  ExplorerTree.BeginEdit;
end;

procedure TdxPSPreviewWindow.DoExplorerShowToggled(Value: Boolean);
begin
  if ExplorerPane <> nil then
  begin
    if Value then 
    begin
      if Assigned(ExplorerTree) then
        ExplorerTree.SetFocus;
      if FSaveExplorerPaneWidth <> -1 then 
        ExplorerPane.Width := FSaveExplorerPaneWidth
      else
        ExplorerPane.Width := DefaultExplorerPaneWidth;
    end
    else
    begin
      ExplorerPane.Width := 0;
      ExplorerPane.Left := 0;
      SetFocusToControl(Preview);
    end;
    UpdateControlsPosition;
    UpdateControls;
  end;
end;

procedure TdxPSPreviewWindow.DoExplorerUnloadItemData;
begin
  if CanUnloadReport then
  begin
    if IsExplorerAvailable then
      ExplorerTree.UnloadItemData
    else
      DoUnloadReportLinkData;
  end;
end;

procedure TdxPSPreviewWindow.DoFormatFootnotes;
begin
  ReportLink.ShowFootnotesPropertiesDlg;
end;

procedure TdxPSPreviewWindow.DoFormatTitle;
begin
  ReportLink.ShowTitlePropertiesDlg;
end;

procedure TdxPSPreviewWindow.DoInsertHF(const S: string);
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

procedure TdxPSPreviewWindow.DoInvokeHelp;
begin
  if HelpContext <> 0 then Application.HelpContext(HelpContext);
end;

procedure TdxPSPreviewWindow.DoClearHF;
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

procedure TdxPSPreviewWindow.DoShowHFBackgroundDlg(const Pt: TPoint);
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

procedure TdxPSPreviewWindow.DoShowPageHeaders(Value: Boolean);
begin
  ReportLink.ShowPageHeader := Value;
  FPreview.InvalidatePagesHeader;
end;

procedure TdxPSPreviewWindow.DoShowPageFooters(Value: Boolean);
begin
  ReportLink.ShowPageFooter := Value;
  FPreview.InvalidatePagesFooter;
end;

procedure TdxPSPreviewWindow.PrepareProgress;
begin
  RefreshStatusPanels(psbmProgress);
  ProgressBarShow;
  FLastOpCompleted := 0;    
  FCurrentProgressValue := 0;
end;

function TdxPSPreviewWindow.ProgressBarGetMaxValue: Integer;
begin  
  if cpsPrinting in ComponentPrinter.State then
    Result := FFullPageCount
  else
    Result := 100;
end;

procedure TdxPSPreviewWindow.ProgressBarHide;
begin
  ProgressBar.Parent := nil;
end;

procedure TdxPSPreviewWindow.ProgressBarPlace;
var
  R: TRect;
begin
  R := StatusBar.PanelRect(ProgressStatusPanel.Index);
  InflateRect(R, -1, -1);
  if Flat then
    Dec(R.Bottom);
  ProgressBar.BoundsRect := R;
end;

procedure TdxPSPreviewWindow.ProgressBarRefresh;
begin
  //UpdateStatusText;
  ProgressBar.Position := FCurrentProgressValue;
end;

procedure TdxPSPreviewWindow.ProgressBarShow;
begin
  ProgressBar.Position := 0;
  ProgressBar.Max := ProgressBarGetMaxValue;
  ProgressBar.Parent := StatusBar;
  ProgressBarPlace;
end;

procedure TdxPSPreviewWindow.UnprepareProgress;
begin
  ProgressBarHide;
  RefreshStatusPanels(psbmNormal);
  UpdateControls;
  PostMessage(Handle, DXM_PS_UPDATESTATUSPROGRESS, 0, 0);
end;

procedure TdxPSPreviewWindow.GenerateReportProgress(Sender: TObject;
  AReportLink: TBasedxReportLink; APercentDone: Double {mask : '##0.00'});
begin
  if Sender <> ComponentPrinter then Exit;
  FCurrentProgressValue := Trunc(APercentDone);
  ProgressBarRefresh;
  //if IsEscKeyPressed(Handle) then ComponentPrinter.AbortBuilding := True;
end;

procedure TdxPSPreviewWindow.EndGenerateReport(Sender: TObject;
  AReportLink: TBasedxReportLink);
begin
  if Sender <> ComponentPrinter then Exit;
  UnprepareProgress;
  if Preview.SelPageIndex > ReportLink.PageCount - 1 then
    Preview.SelPageIndex := ReportLink.PageCount - 1;
end;

procedure TdxPSPreviewWindow.StartGenerateReport(Sender: TObject;
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

procedure TdxPSPreviewWindow.EndPrint(Sender: TObject; AReportLink: TBasedxReportLink);
begin
  if Sender <> ComponentPrinter then Exit;
  UnprepareProgress;
  UpdateControls;
end;

procedure TdxPSPreviewWindow.NewPage(Sender: TObject; AReportLink: TBasedxReportLink;
  APageIndex: Integer);
begin
  if Sender <> ComponentPrinter then Exit;
  FCurrentProgressValue := APageIndex;
  ProgressBarRefresh;
end;

procedure TdxPSPreviewWindow.StartPrint(Sender: TObject; AReportLink: TBasedxReportLink;
  FullPageCount: Integer);
begin
  if Sender <> ComponentPrinter then Exit;
  FFullPageCount := FullPageCount;
  UpdateControls;
  PrepareProgress;
end;

procedure TdxPSPreviewWindow.UpdateMarginBar;
begin
  MarginBar.Refresh;
end;

procedure TdxPSPreviewWindow.SetZoomFactorByText(const AText: string);
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

procedure TdxPSPreviewWindow.UpdateStatusBarPanelWidths(
  AStatusBar: TdxPSCustomStatusBar);

  procedure UpdateStatusBarPanelWidth(APanel: TdxPSStatusBarPanel);
  var
    ATextWidth: Integer;
  begin
    if APanel.Width >= 0 then
    begin
      ATextWidth := AStatusBar.Canvas.TextWidth(APanel.Text);
      if ATextWidth = 0 then
        APanel.Width := 2
      else
        APanel.Width := Max(APanel.Width, 6 + ATextWidth);
    end;
  end;
  
var
  I: Integer;
begin
  for I := 0 to AStatusBar.Panels.Count - 1 do
    UpdateStatusBarPanelWidth(AStatusBar.Panels.Items[I]);
end;

procedure TdxPSPreviewWindow.SavePreferences(AData: TdxPreviewOptionsDlgData);
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

procedure TdxPSPreviewWindow.LoadFromIniFile(
  AIniFile: TCustomIniFile; const ASectionName: string);
begin
  inherited LoadFromIniFile(AIniFile, ASectionName);
  DoLoadFromIniFile(AIniFile, ASectionName);
  LoadProperties(AIniFile, ASectionName);
  InitContent;
end;

procedure TdxPSPreviewWindow.SaveToIniFile(
  AIniFile: TCustomIniFile; const ASectionName: string);
begin
  inherited SaveToIniFile(AIniFile, ASectionName);
  DoSaveToIniFile(AIniFile, ASectionName);
  SaveProperties(AIniFile, ASectionName);
end;

procedure TdxPSPreviewWindow.SaveProperties(
  AIniFile: TCustomIniFile; const ASectionName: string);
begin
  Preview.SaveToIniFile(AIniFile, dxValidatePath(ASectionName) + sdxPreviewControl);
  AIniFile.WriteBool(ASectionName, sdxShowMarginBar, ShowMarginBar);
  AIniFile.WriteBool(ASectionName, sdxShowStatusBar, ShowStatusBar);
  AIniFile.WriteInteger(ASectionName, sdxExplorerVisibilityState, Ord(ShowExplorer) + 1);
  if ExplorerPaneWidth <> 0 then
    AIniFile.WriteInteger(ASectionName, sdxExplorerPaneWidth, ExplorerPaneWidth);
  AIniFile.WriteInteger(ASectionName, sdxThumbnailsVisibilityState, Ord(ShowThumbnails) + 1);
  if ThumbnailsPaneWidth <> 0 then
    AIniFile.WriteInteger(ASectionName, sdxThumbnailsPaneWidth, ThumbnailsPaneWidth);
end;

procedure TdxPSPreviewWindow.LoadProperties(
  AIniFile: TCustomIniFile; const ASectionName: string);
const
  VisibilityMap: array[Boolean] of TdxPSPageMarginsVisibilityState = (mvsHidden, mvsShown);
begin
  FPreview.LoadFromIniFile(AIniFile, dxValidatePath(ASectionName) + sdxPreviewControl);
  FSavePageMarginsVisibility := VisibilityMap[povMargins in FPreview.OptionsView];
  FShowMarginBar := AIniFile.ReadBool(ASectionName, sdxShowMarginBar, FShowMarginBar);
  FShowStatusBar := AIniFile.ReadBool(ASectionName, sdxShowStatusBar, FShowStatusBar);
  FSaveExplorerPaneWidth := AIniFile.ReadInteger(
    ASectionName, sdxExplorerPaneWidth, FSaveExplorerPaneWidth);
  FSaveThumbnailsPaneWidth := AIniFile.ReadInteger(
    ASectionName, sdxThumbnailsPaneWidth, FSaveThumbnailsPaneWidth);
  FSaveExplorerVisibility := TdxPSExplorerVisibiltyState(
    AIniFile.ReadInteger(ASectionName, sdxExplorerVisibilityState, Ord(evsUndefined)));
  FSaveThumbnailsVisibility := TdxPSThumbnailsVisibiltyState(
    AIniFile.ReadInteger(ASectionName, sdxThumbnailsVisibilityState, Ord(tvsUndefined)));
  ShowPageMargins := FSavePageMarginsVisibility = mvsShown;
end;
    
procedure TdxPSPreviewWindow.UpdateStatusText;

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

procedure TdxPSPreviewWindow.WMAppCommand(var Message: TMessage);
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
          Release;
          Result := 1;
        end;

      APPCOMMAND_SAVE: 
        begin
          Result := Ord(CanSaveReport);
          if Result = 1 then
            DoExplorerCreateNewItem;
        end;
      
      APPCOMMAND_PRINT: 
        begin
          DoPrintReport(True);
          Result := 1;
        end;  
    end;
  inherited;  
end;

procedure TdxPSPreviewWindow.WMSetFocus(var Message: TWMSetFocus);
begin
  if Assigned(Preview) and Preview.HandleAllocated then
    Windows.SetFocus(Preview.Handle)
  else
    inherited;
end;

procedure TdxPSPreviewWindow.WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo);
begin
  inherited;
  with Message.MinMaxInfo.ptMinTrackSize do 
  begin
    X := 360;
    Y := 300;
  end;
end;

procedure TdxPSPreviewWindow.WMSettingChange(var Message: TWMSettingChange);
begin
  inherited;
  with Message do
    if (Flag = 0) and (Section = 'intl') then
    begin
      RefreshMarginBar(nil);
      RefreshStatusBar([ssPaperSize]);
    end;  
end;

{ TdxPSCustomStatusBar }

constructor TdxPSCustomStatusBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPanels := TdxPSStatusBarPanels.Create(Self);
  DoubleBuffered := True;
  Align := alBottom; 
end;

destructor TdxPSCustomStatusBar.Destroy;
begin
  FreeAndNil(FPanels);
  inherited Destroy;
end;

procedure TdxPSCustomStatusBar.BeginUpdate;
begin
  Inc(FUpdateCount);
  if FUpdateCount = 1 then
    UpdateStateChanged(False);
end;

procedure TdxPSCustomStatusBar.EndUpdate;
begin
  Dec(FUpdateCount);
  if FUpdateCount = 0 then
    UpdateStateChanged(True);
end;

function TdxPSCustomStatusBar.CanShowSizeGrip: Boolean;
var
  AForm: TCustomForm;
begin
  AForm := GetParentForm(Self);
  Result := Assigned(AForm) and (AForm.WindowState <> wsMaximized);
end;

procedure TdxPSCustomStatusBar.Calculate;
var
  I: Integer;
  AViewInfo: TdxPSStatusBarViewInfo;
begin
  AViewInfo := CreateViewInfo;
  try
    CalculateSizeGripBounds(AViewInfo);
    for I := 0 to Panels.Count - 1 do
      Panels.Items[I].Calculate(AViewInfo);
  finally
    AViewInfo.Free;
  end;
end;

procedure TdxPSCustomStatusBar.CalculateSizeGripBounds(AViewInfo: TdxPSStatusBarViewInfo);
begin
  FSizeGripRect := cxEmptyRect;
  if SizeGrip and CanShowSizeGrip then
  begin
    FSizeGripRect := cxRectContent(AViewInfo.Bounds, AViewInfo.BorderWidths);
    FSizeGripRect.Left := FSizeGripRect.Right - AViewInfo.SizeGripSize.cx;
    if cxRectHeight(FSizeGripRect) > AViewInfo.SizeGripSize.cy then
      FSizeGripRect := cxRectCenter(FSizeGripRect, AViewInfo.SizeGripSize);
  end;
end;

procedure TdxPSCustomStatusBar.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    WindowClass.style := WindowClass.style or CS_HREDRAW or CS_VREDRAW;
end;

function TdxPSCustomStatusBar.CreateViewInfo: TdxPSStatusBarViewInfo;
var
  ABorderSize: Integer;
begin
  ABorderSize := LookAndFeelPainter.BorderSize;

  Result := TdxPSStatusBarViewInfo.Create;
  Result.BorderWidths := Rect(ABorderSize, ABorderSize, ABorderSize, ABorderSize);
  Result.Bounds := ContentRect;
  Result.TextIndent := cxTextOffset;
  Result.SizeGripSize := LookAndFeelPainter.SizeGripSize;
  Result.SeparatorSize := LookAndFeelPainter.LabelLineHeight;
end;

procedure TdxPSCustomStatusBar.DoGetPanelDrawParams(APanel: TdxPSStatusBarPanel;
  var ABkgColor, ATextColor: TColor);
begin
  if Assigned(OnPanelGetDrawParams) then
    OnPanelGetDrawParams(Self, APanel, ABkgColor, ATextColor); 
end;

procedure TdxPSCustomStatusBar.DrawBackground(ACanvas: TcxCanvas; const R: TRect);
begin
  LookAndFeelPainter.DrawPanelBackground(ACanvas, Self, R, Color);
  LookAndFeelPainter.DrawPanelContent(ACanvas, R, False);
end;

procedure TdxPSCustomStatusBar.DrawItem(ACanvas: TcxCanvas; APanel: TdxPSStatusBarPanel);
begin
  case APanel.Style of
    sbpsPanel:
      DrawPanelItem(ACanvas, APanel);
    sbpsSeparator:
      DrawSepartorItem(ACanvas, APanel);
  end;
end;

procedure TdxPSCustomStatusBar.DrawPanelItem(ACanvas: TcxCanvas; APanel: TdxPSStatusBarPanel);
var
  ATextColor, ABkgColor: TColor;
begin
  ABkgColor := clNone;
  ATextColor := GetTextColor;
  DoGetPanelDrawParams(APanel, ABkgColor, ATextColor);
  ACanvas.FillRect(APanel.Bounds, ABkgColor);
  if APanel.ShowBorders then
    LookAndFeelPainter.DrawBorder(ACanvas, APanel.Bounds);
  DrawPanelItemText(ACanvas, APanel, ATextColor);
end;

procedure TdxPSCustomStatusBar.DrawSepartorItem(
  ACanvas: TcxCanvas; APanel: TdxPSStatusBarPanel); 
begin
  LookAndFeelPainter.DrawLabelLine(ACanvas, APanel.Bounds, clDefault, clDefault, True);
end;

procedure TdxPSCustomStatusBar.DrawPanelItemText(
  ACanvas: TcxCanvas; APanel: TdxPSStatusBarPanel; ATextColor: TColor);
const
  TextAlignFlagsMap: array[TAlignment] of Integer =
    (cxAlignLeft, cxAlignRight, cxAlignHCenter);
begin
  ACanvas.Font := Font;
  ACanvas.Font.Color := ATextColor;
  ACanvas.Brush.Style := bsClear;
  ACanvas.DrawTexT(APanel.Text, APanel.TextRect,
    cxAlignVCenter or TextAlignFlagsMap[APanel.Alignment]);
end;

procedure TdxPSCustomStatusBar.DrawSizeGrip(ACanvas: TcxCanvas; const R: TRect);
begin
  LookAndFeelPainter.DrawSizeGrip(ACanvas, R, clNone);
end;

procedure TdxPSCustomStatusBar.InvalidatePanel(AIndex: Integer);
begin
  InvalidateRect(PanelRect(AIndex), True);
  Update;
end;

procedure TdxPSCustomStatusBar.Paint;
var
  I: Integer;
begin
  DrawBackground(Canvas, ClientRect);
  for I := 0 to Panels.Count - 1 do
    DrawItem(Canvas, Panels.Items[I]);
  DrawSizeGrip(Canvas, SizeGripRect);
end;

function TdxPSCustomStatusBar.PanelFromPoint(
  APoint: TPoint; var APanel: TdxPSStatusBarPanel): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Panels.Count - 1 do
  begin
    Result := PtInRect(PanelRect(I), APoint);
    if Result then
    begin
      APanel := Panels.Items[I];
      Break;
    end;
  end;
end;

function TdxPSCustomStatusBar.PanelRect(AIndex: Integer): TRect;
begin
  Result := Panels.Items[AIndex].Bounds;
end;

procedure TdxPSCustomStatusBar.Recalculate;
begin
  if FUpdateCount = 0 then
  begin
    Calculate;
    Invalidate;
  end;
end;

procedure TdxPSCustomStatusBar.UpdateStateChanged(AUnlocked: Boolean);
begin
  SendMessage(Handle, WM_SETREDRAW, Ord(AUnlocked), Ord(AUnlocked));
  if AUnlocked then
    Recalculate;
end;

procedure TdxPSCustomStatusBar.WMNCHitTest(var Message: TWMNCHitTest);
begin
  inherited;
  if PtInRect(SizeGripRect, ScreenToClient(SmallPointToPoint(Message.Pos))) then
    Message.Result := HTBOTTOMRIGHT;
end;

function TdxPSCustomStatusBar.GetContentRect: TRect;
begin
  Result := ClientRect;
  InflateRect(Result, -1, -1);
end;

function TdxPSCustomStatusBar.GetTextColor: TColor;
begin
  if (Font.Color <> clWindowText) or (LookAndFeelPainter.PanelTextColor = clDefault) then
    Result := Font.Color
  else
    Result := LookAndFeelPainter.PanelTextColor;
end;

procedure TdxPSCustomStatusBar.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  if HandleAllocated then
    Recalculate;
end;

procedure TdxPSCustomStatusBar.SetSizeGrip(AValue: Boolean);
begin
  if AValue <> FSizeGrip then
  begin
    FSizeGrip := AValue;
    Recalculate;
  end;
end;

{ TdxPSStatusBarPanels }

constructor TdxPSStatusBarPanels.Create(AStatusBar: TdxPSCustomStatusBar);
begin
  inherited Create(TdxPSStatusBarPanel);
  FStatusBar := AStatusBar;
end;

function TdxPSStatusBarPanels.Add: TdxPSStatusBarPanel;
begin
  Result := TdxPSStatusBarPanel(inherited Add);
end;

function TdxPSStatusBarPanels.First: TdxPSStatusBarPanel;
begin
  Result := Items[0];
end;

function TdxPSStatusBarPanels.Last: TdxPSStatusBarPanel;
begin
  Result := Items[Count - 1];
end;

function TdxPSStatusBarPanels.GetItem(Index: Integer): TdxPSStatusBarPanel;
begin
  Result := TdxPSStatusBarPanel(inherited Items[Index]); 
end;

function TdxPSStatusBarPanels.GetOwner: TPersistent;
begin
  Result := FStatusBar;
end;

procedure TdxPSStatusBarPanels.Update(Item: TCollectionItem);
begin
  if Item = nil then
    FStatusBar.Recalculate
  else
    FStatusBar.InvalidatePanel(Item.Index);
end;

{ TdxPSStatusBarPanel }

constructor TdxPSStatusBarPanel.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FAlignment := taLeftJustify;
  FShowBorders := True;
  FWidth := 100;
end;

procedure TdxPSStatusBarPanel.Calculate(AViewInfo: TdxPSStatusBarViewInfo);

  function CalculateBounds(const R: TRect): TRect;
  begin
    Result := R;
    if Style = sbpsSeparator then
      FWidth := AViewInfo.SeparatorSize;
    if Width >= 0 then
      Result.Right := Result.Left + Width;
  end;

  function CalculateTextRect: TRect;
  begin
    Result := cxRectInflate(Bounds, -AViewInfo.TextIndent, -AViewInfo.TextIndent);
    if ShowBorders then
      Result := cxRectContent(Result, AViewInfo.BorderWidths);
  end;

begin
  FBounds := CalculateBounds(AViewInfo.Bounds);
  FTextRect := CalculateTextRect;
  AViewInfo.Bounds.Left := Bounds.Right + 1;
end;

procedure TdxPSStatusBarPanel.SetAlignment(AValue: TAlignment);
begin
  if AValue <> FAlignment then
  begin
    FAlignment := AValue;
    Changed(False);
  end;
end;

procedure TdxPSStatusBarPanel.SetShowBorders(AValue: Boolean);
begin
  if AValue <> FShowBorders then
  begin
    FShowBorders := AValue;
    Changed(False);
  end;
end;

procedure TdxPSStatusBarPanel.SetStyle(AStyle: TdxPSStatusBarPanelStyle);
begin
  if AStyle <> FStyle then
  begin
    FStyle := AStyle;
    Changed(True);
  end;
end;

procedure TdxPSStatusBarPanel.SetText(const AText: string);
begin
  if AText <> FText then
  begin
    FText := AText;
    Changed(False);
  end;
end;

procedure TdxPSStatusBarPanel.SetWidth(AValue: Integer);
begin
  if AValue <> FWidth then
  begin
    FWidth := AValue;
    Changed(True);
  end;
end;

initialization
  ClosePaneGlyph := CreateGlyphBitmap(CloseGlyphIndex, 0, 0, 7);

finalization
  FreeAndNil(ClosePaneGlyph);

end.

