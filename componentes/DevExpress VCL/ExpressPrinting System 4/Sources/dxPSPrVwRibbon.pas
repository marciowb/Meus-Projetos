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

unit dxPSPrVwRibbon;

interface
                
{$I cxVer.inc}

uses
  Windows, SysUtils, Classes, Messages, Graphics, Controls, ComCtrls, StdCtrls, 
  ExtCtrls, Forms, Menus, ImgList,
  dxMessages, dxPSCore, dxPSESys, dxPrevw, dxPSPrvw, dxBar,
  dxBarPopupMenuEd, dxBarExtItems, cxClasses, dxRibbonForm, cxGeometry, dxRibbon,
  cxControls, cxLookAndFeels, cxGraphics, dxRibbonGallery, dxBkGnd, Dialogs,
{$IFDEF EXPRESSBARS7}
  dxBarApplicationMenu,
{$ENDIF}
  cxLookAndFeelPainters, IniFiles, dxRibbonSkins;

type

  { TdxfmRibbonPreview }

  TdxRibbonPrintPreviewForm = class(TdxRibbonForm)
    bbAutoText: TdxBarSubItem;
    bbCloseHeaderAndFooter: TdxBarLargeButton;
    bbDefinePrintStyles: TdxBarButton;
    bbEdit: TdxBarSubItem;
    bbEditFind: TdxBarButton;
    bbEditFindNext: TdxBarButton;
    bbEditReplace: TdxBarButton;
    bbExplorerCreateNewFolder: TdxBarButton;
    bbExplorerDelete: TdxBarButton;
    bbExplorerRename: TdxBarButton;
    bbExportToPDF: TdxBarButton;
    bbFileClose: TdxBarButton;
    bbFileExit: TdxBarButton;
    bbFileLoad: TdxBarButton;
    bbFilePageSetup: TdxBarButton;
    bbFilePrint: TdxBarButton;
    bbFilePrintDialog: TdxBarButton;
    bbFileSave: TdxBarButton;
    bbFormatDateTime: TdxBarButton;
    bbFormatHFBackground: TdxBarButton;
    bbFormatHFClear: TdxBarButton;
    bbFormatPageNumbering: TdxBarButton;
    bbFormatShowHideEmptyPages: TdxBarButton;
    bbFormatTitle: TdxBarButton;
    bbGoToFirstPage: TdxBarButton;
    bbGoToLastPage: TdxBarButton;
    bbGoToNextPage: TdxBarButton;
    bbGoToPrevPage: TdxBarButton;
    bbInsertEditAutoText: TdxBarButton;
    bbInsertHFDate: TdxBarButton;
    bbInsertHFDateTime: TdxBarButton;
    bbInsertHFMachineName: TdxBarButton;
    bbInsertHFPageNumber: TdxBarButton;
    bbInsertHFPageOfPages: TdxBarButton;
    bbInsertHFTime: TdxBarButton;
    bbInsertHFTotalPages: TdxBarButton;
    bbInsertHFUserName: TdxBarButton;
    bbThumbnailsLarge: TdxBarButton;
    bbThumbnailsSmall: TdxBarButton;
    bbViewExplorer: TdxBarButton;
    bbViewHFClose: TdxBarButton;
    bbViewMarginBar: TdxBarButton;
    bbViewMargins: TdxBarButton;
    bbViewPageFooters: TdxBarButton;
    bbViewPageHeaders: TdxBarButton;
    bbViewStatusBar: TdxBarButton;
    bbViewSwitchToCenterPart: TdxBarButton;
    bbViewSwitchToLeftPart: TdxBarButton;
    bbViewSwitchToRightPart: TdxBarButton;
    bbViewThumbnails: TdxBarButton;
    bbZoom: TdxBarSubItem;
    bbZoomFourPages: TdxBarButton;
    bbZoomMultiplePages: TdxBarButton;
    bbZoomPageWidth: TdxBarButton;
    bbZoomPercent100: TdxBarButton;
    bbZoomSetup: TdxBarButton;
    bbZoomTwoPages: TdxBarButton;
    bbZoomWholePage: TdxBarButton;
    bbZoomWidenToSourceWidth: TdxBarButton;
    bliInsertAutoTextEntries: TdxBarListItem;
    bliPrintStyles: TdxBarListItem;
    bsiInsertAutoText: TdxBarSubItem;
    cbxPredefinedZoom: TdxBarImageCombo;
    dxBarExplorer: TdxBar;
    dxBarFormat: TdxBar;
    dxBarHeaderAndFooterParts: TdxBar;
    dxBarHeaderAndFooterClose: TdxBar;
    dxBarInsertAutoText: TdxBar;
    dxBarInsertDateTime: TdxBar;
    dxBarInsertName: TdxBar;
    dxBarInsertPageNumber: TdxBar;
    dxBarManager: TdxBarManager;
    dxBarMorePages: TdxBarButton;
    dxBarNavigation: TdxBar;
    dxBarQuickAccess: TdxBar;
    dxBarReport: TdxBar;
    dxBarZoom: TdxBar;
    dxRibbon: TdxRibbon;
    rtHeader: TdxRibbonTab;
    rtMain: TdxRibbonTab;
    seActivePage: TdxBarSpinEdit;
    TimerHint: TTimer;
    Preview: TdxPSPreviewWindow;
    ApplicationMenu: TdxBarApplicationMenu;
    bbNavigation: TdxBarSubItem;
    rtExplorer: TdxRibbonTab;
    bbReportProperties: TdxBarLargeButton;
    dxBarView: TdxBar;
    bbExplorer: TdxBarLargeButton;
    bbThumbnails: TdxBarLargeButton;
    bbClosePreview: TdxBarLargeButton;
    bbHeaderAndFooter: TdxBarLargeButton;
    ilSmallImages: TcxImageList;
    ilLargeImages: TcxImageList;
    dxBarExplorerReport: TdxBar;
    bbBarExplorerClose: TdxBarLargeButton;
    bbFormatFootnotes: TdxBarButton;
    pmPrintStyles: TdxRibbonPopupMenu;
    pmExplorer: TdxRibbonPopupMenu;
    pmThumbnails: TdxRibbonPopupMenu;
    dxBarPagesPopup: TdxRibbonPopupMenu;
    pmPreview: TdxRibbonPopupMenu;
    bbFileDesign: TdxBarLargeButton;
    bbFileRebuild: TdxBarLargeButton;
    rtFooter: TdxRibbonTab;
    dxBarPageSetup: TdxBar;
    bbPageSetup: TdxBarLargeButton;
    rgiBackgroundColor: TdxRibbonGalleryItem;
    bbFormatSubItem: TdxBarSubItem;
    bbBackgroundNoFill: TdxBarButton;
    bbBackgroundMoreColors: TdxBarButton;
    bbBackgroundFillEffects: TdxBarButton;
    bbFormatShrinkToPageWidth: TdxBarLargeButton;
    dxBarOutput: TdxBar;
    bbLargePrint: TdxBarLargeButton;
    bbLargePrintDialog: TdxBarLargeButton;
    bbLargeExportToPDF: TdxBarLargeButton;
    bbLargePageSetup: TdxBarLargeButton;
    bbView: TdxBarSubItem;
    procedure bbExplorerPropertiesClick(Sender: TObject);
    procedure bbExportToPDFClick(Sender: TObject);
    procedure bbFileCloseClick(Sender: TObject);
    procedure bbFileRebuildClick(Sender: TObject);
    procedure bbFormatDateTimeClick(Sender: TObject);
    procedure bbFormatHeaderAndFooterClick(Sender: TObject);
    procedure bbFormatHFBackgroundClick(Sender: TObject);
    procedure bbFormatHFClearClick(Sender: TObject);
    procedure bbFormatPageNumbersClick(Sender: TObject);
    procedure bbFormatShowHideEmptyPagesClick(Sender: TObject);
    procedure bbFormatShrinkToPageWidthClick(Sender: TObject);
    procedure bbFormatTitleClick(Sender: TObject);
    procedure bbThumbnailsSizeClick(Sender: TObject);
    procedure bbToolsCustomizeClick(Sender: TObject);
    procedure bbViewExplorerClick(Sender: TObject);
    procedure bbViewHFCloseClick(Sender: TObject);
    procedure bbViewMarginBarClick(Sender: TObject);
    procedure bbViewMarginsClick(Sender: TObject);
    procedure bbViewPageFootersClick(Sender: TObject);
    procedure bbViewPageHeadersClick(Sender: TObject);
    procedure bbViewStatusBarClick(Sender: TObject);
    procedure bbViewThumbnailsClick(Sender: TObject);
    procedure bbZoomMultiplePagesClick(Sender: TObject);
    procedure bbZoomSetupClick(Sender: TObject);
    procedure cbxPredefinedZoomChange(Sender: TObject);
    procedure cbxPredefinedZoomClick(Sender: TObject);
    procedure CloseClick(Sender: TObject);
    procedure DesignClick(Sender: TObject);
    procedure dxRibbonHelpButtonClick(Sender: TdxCustomRibbon);
    procedure ExplorerCreateNewFolderClick(Sender: TObject);
    procedure ExplorerDeleteItemClick(Sender: TObject);
    procedure ExplorerLoadDataClick(Sender: TObject);
    procedure ExplorerRenameItemClick(Sender: TObject);
    procedure FileSaveClick(Sender: TObject);
    procedure GoToPageClick(Sender: TObject);
    procedure HelpClick(Sender: TObject);
    procedure InsertHFClick(Sender: TObject);
    procedure PageBackgroundClick(Sender: TObject);
    procedure PageSetupClick(Sender: TObject);
    procedure pmExplorerPopup(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure seActivePageButtonClick(Sender: TdxBarSpinEdit; Button: TdxBarSpinEditButton);
    procedure seActivePageChange(Sender: TObject);
    procedure SwitchPartClick(Sender: TObject);
    procedure TimerHintTimer(Sender: TObject);
    procedure ZoomClick(Sender: TObject);
    procedure PreviewInitContent(Sender: TObject);
    procedure PreviewCanShowMarginHint(Sender: TObject; var AAllow: Boolean);
    procedure PreviewAddExplorerCommand(Sender: TObject; ACommand: TCustomdxPSExplorerContextCommand);
    procedure PreviewAfterPrintReport(Sender: TObject; AShowDialog: Boolean);
    procedure PreviewPreviewDblClick(Sender: TObject);
    procedure PreviewZoomFactorChanged(Sender: TObject);
    procedure PreviewZoomModeChanged(Sender: TObject);
    procedure PreviewHFToolBarVisibleChanged(Sender: TObject; AShow: Boolean);
    procedure PreviewStyleListChanged(Sender: TObject);
    procedure PreviewHFTextEntriesChanged(Sender: TObject);
    procedure PreviewUpdateExplorerCommands(Sender: TObject);
    procedure PreviewCreationComplete(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure PreviewUpdateControls(Sender: TObject);
    procedure bbClosePreviewClick(Sender: TObject);
    procedure bbExplorerClick(Sender: TObject);
    procedure bbThumbnailsClick(Sender: TObject);
    procedure bbHeaderAndFooterClick(Sender: TObject);
    procedure bbCloseHeaderAndFooterClick(Sender: TObject);
    procedure bbBarExplorerCloseClick(Sender: TObject);
    procedure bbFormatFootnotesClick(Sender: TObject);
    procedure dxRibbonTabChanged(Sender: TdxCustomRibbon);
    procedure bbPageSetupClick(Sender: TObject);
    procedure bbBackgroundNoFillClick(Sender: TObject);
    procedure bbBackgroundMoreColorsClick(Sender: TObject);
    procedure bbBackgroundFillEffectsClick(Sender: TObject);
    procedure PreviewLoadProperties(Sender: TObject; AIniFile: TCustomIniFile; const ASectionName: string);
    procedure PreviewSaveProperties(Sender: TObject; AIniFile: TCustomIniFile; const ASectionName: string);
    procedure bliPrintStylesGetData(Sender: TObject);
  private
    FExplorerContextCommands: TList;
    FHeaderAndFooterContextVisible: Boolean;
    function GetExplorerContextCommand(Index: Integer): TCustomdxPSExplorerContextCommand;
    function GetExplorerContextCommandCount: Integer;
    function GetExplorerTree: TCustomdxPSExplorerTreeContainer;
    function GetIsExplorerAvailable: Boolean;
    function GetIsPrinting: Boolean;
    function GetLocked: Boolean;
    function GetReportLink: TBasedxReportLink;
    function GetZoomFactor: Integer;

    function CalcWindowPos(Sender: TObject): TPoint;
    procedure ClearColorItemsSelection;
    procedure DoGalleryColorItemClick(Sender: TObject);
    procedure DoPageSetupReport(APageIndex: Integer);
    procedure DoSelectBackgroundColor(AColor: TColor);
    procedure DoShowExplorerPopup(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure EnableItemsWhileBuilding(Value: Boolean);
    procedure InitializeBackgroundColorsGallery;
    procedure PostCreateFolderMessage;
    procedure SetBarItemVisibility(Item: TdxBarItem; Value: Boolean);

    procedure EnabledHFItems(Value: Boolean);
    procedure UpdateHFState(Value: Boolean);
  protected
    procedure Activate; override;
    procedure WndProc(var Message: TMessage); override;

    procedure AddExplorerContextCommand(ACommand: TCustomdxPSExplorerContextCommand); virtual;
    procedure DoAfterPrintReport(AShowDialog: Boolean); virtual;
    procedure DoShowHFToolBar(Value: Boolean); virtual;
    procedure ExplorerContextCommandClick(Sender: TObject); virtual;
    procedure InitializeRibbonLookAndFeel;
    procedure LoadStrings; virtual;
    procedure UpdateExplorerContextCommands; virtual;
    procedure UpdateRibbonHelpButton; virtual;

    procedure LoadBarManagerDefaults;
    procedure SaveBarManagerDefaults;
    procedure LoadBarManager(AIniFile: TCustomIniFile; const ASectionName: string);
    procedure SaveBarManager(AIniFile: TCustomIniFile; const ASectionName: string);

    property ExplorerContextCommandCount: Integer read GetExplorerContextCommandCount;
    property ExplorerContextCommands[Index: Integer]: TCustomdxPSExplorerContextCommand read GetExplorerContextCommand;
    property ExplorerTree: TCustomdxPSExplorerTreeContainer read GetExplorerTree;
    property HeaderAndFooterContextVisible: Boolean read FHeaderAndFooterContextVisible;
    property IsExplorerAvailable: Boolean read GetIsExplorerAvailable;
    property IsPrinting: Boolean read GetIsPrinting;
    property Locked: Boolean read GetLocked;
    property ReportLink: TBasedxReportLink read GetReportLink;
    property ZoomFactor: Integer read GetZoomFactor;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure InitContent;
    procedure UpdateContexts;
    procedure UpdateControls;
  end;

implementation

{$R *.DFM}
{$R dxPSPrVwRibbon.res}

uses                                                             
  Types, Registry, CommCtrl, Math, dxPSRes, dxPrnPg, dxPSGlbl, dxPSPopupMan, dxPSImgs,
  dxPSUtl, dxPSPgsMnuBld, dxPSEngn, dxPgsDlg, dxPSEvnt, dxPSAutoHFTextMnuBld,
  dxPSfmAutoHFTextFmt, dxPrnDev, dxPSPDFExport, dxfmClr, dxPSForm;

const
  PageSelectorImageIndex = 35;

  IDB_DXPSPREVIEW_RIBBON_IMAGELIST = 'IDB_DXPSPREVIEW_RIBBON_IMAGELIST';
  sdxToolBars = 'ToolBars';                           // Don't Localize

type
  TWinControlAccess = class(TWinControl);
  TdxBarManagerAccess = class(TdxBarManager);

  { TdxRibbonPSPopupMenuBuilder }
  
  TdxRibbonPSPopupMenuBuilder = class(TAbstractdxPSPopupMenuBuilder)
  private
    FBarHostForm: TCustomForm;
    FBarManager: TdxBarManager;
  protected
    function BuildPopup(const AControl: TControl; 
      const APopupMenu: TPopupMenu): TComponent; override;
    class function CanShowPopup(const APopupMenu: TPopupMenu): Boolean; override;
    procedure FreePopup(var APopupMenu: TComponent); override;
    procedure InvokePopup(X, Y: Integer; AControl: TControl; APopupMenu: TComponent); override;
    class function RequireProcessDoPopup: Boolean; override;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

  { TdxRibbonPSPageSetupMenuBuilder }

  TdxRibbonPSPageSetupMenuBuilder = class(TdxStandardPSPageSetupMenuBuilder)
  public   
    procedure BuildPageSetupMenu(ARootItem: TObject; AData: Pointer; 
      AIncludeDefineItem: Boolean; AStyles: TStringList; ACurrentStyle: TBasedxPrintStyle;
      AOnStyleClick, AOnDefineStylesClick: TNotifyEvent); override;
    class function ExtractPrintStyleFromObj(Obj: TObject): TBasedxPrintStyle; override;
  end;

  { TdxRibbonPSAutoHFTextMenuBuilder }

  TdxRibbonPSAutoHFTextMenuBuilder = class(TAbstractdxPSAutoHFTextMenuBuilder)
  public    
    procedure BuildAutoHFTextEntriesMenu(ARootItem: TObject; AData: Pointer; 
      AIncludeSetupAutoHFTextEntriesItem: Boolean; AAutoHFTextEntries: TStrings;
      AOnHFTextEntriesClick, AOnSetupHFTextEntriesClick: TNotifyEvent); override;
    class function ExtractAutoHFTextEntryIndexFromObj(Obj: TObject): Integer; override;
  end;

  { TdxPSRibbonPreviewDialogStyleInfo }

  TdxPSRibbonPreviewDialogStyleInfo = class(TdxPSPreviewDialogStyleInfo)
  public
    class function CreatePreviewForm: TdxRibbonPrintPreviewForm; virtual;
    class function CreatePreviewWindow: TdxPSCustomPreviewWindow; override;
    class function GetName: string; override;
  end;

{$IFDEF EXPRESSBARS7}

  TdxPSRibbon2010PreviewDialogStyleInfo = class(TdxPSRibbonPreviewDialogStyleInfo)
  public
    class function CreatePreviewForm: TdxRibbonPrintPreviewForm; override;
    class function GetName: string; override;
  end;

{$ENDIF}

function VisibleToBarItemVisible(AValue: Boolean): TdxBarItemVisible;
{ivNever, ivInCustomizing, ivAlways}
begin
  Result := TdxBarItemVisible(2 * Byte(AValue));
end;
  
function dxBar_DoesNotHaveActivePopup: Boolean;
begin
  Result := dxBar.ActiveBarControl = nil;
end;
  
procedure SetupBarManagerStyle(ABarManager: TdxBarManager);
const
  BarManagerStyleMap: array[TcxLookAndFeelKind] of dxBar.TdxBarManagerStyle =
    (dxBar.bmsFlat, dxBar.bmsEnhanced, dxBar.bmsFlat, dxBar.bmsFlat);
begin
  ABarManager.Style := bmsUseLookAndFeel;
  ABarManager.LookAndFeel := dxPSEngine.DialogsLookAndFeel;
end;

{ TdxRibbonPSPopupMenuBuilder }  

constructor TdxRibbonPSPopupMenuBuilder.Create;
begin
  inherited;
  FBarHostForm := TCustomForm.CreateNew(nil);
  FBarManager := TdxBarManager.Create(FBarHostForm);
  SetupBarManagerStyle(FBarManager);
end;
     
destructor TdxRibbonPSPopupMenuBuilder.Destroy;
begin
  FreeAndNil(FBarHostForm);
  inherited Destroy;
end;
                                         
class function TdxRibbonPSPopupMenuBuilder.CanShowPopup(const APopupMenu: TPopupMenu): Boolean;
begin
  Result := inherited CanShowPopup(APopupMenu) and dxBar_DoesNotHaveActivePopup;
end;

function TdxRibbonPSPopupMenuBuilder.BuildPopup(const AControl: TControl; 
  const APopupMenu: TPopupMenu): TComponent;

  function IsSeparator(ABarItem: TdxBarItem): Boolean;
  begin
    Result := ABarItem.Caption = '-';
  end;

  function CreateItem(AMenuItem: TMenuItem): TdxBarItem;
  const 
    BarItemClasses: array[Boolean] of TdxBarItemClass = (TdxBarButton, TdxBarSubItem);
  var
    BarItemClass: TdxBarItemClass;
  begin
    Result := nil;
    BarItemClass := BarItemClasses[AMenuItem.Count > 0];
    if BarItemClass = nil then Exit;
    
    Result := BarItemClass.Create(FBarHostForm);

    Result.Action := AMenuItem.Action;
    Result.ImageIndex := AMenuItem.ImageIndex;
    Result.Glyph := AMenuItem.Bitmap;
    Result.Caption := AMenuItem.Caption;
    Result.Enabled := AMenuItem.Enabled;
    Result.HelpContext := AMenuItem.HelpContext;
    Result.Hint := AMenuItem.Hint;
    Result.ShortCut := AMenuItem.ShortCut;
    Result.Tag := AMenuItem.Tag;
    Result.Visible := VisibleToBarItemVisible(AMenuItem.Visible);
    if not (Result is TdxBarSubItem) then
      Result.OnClick := AMenuItem.OnClick;
    if Result is TdxBarButton then
    begin
      if AMenuItem.Checked or AMenuItem.RadioItem then
        TdxBarButton(Result).ButtonStyle := bsChecked;
      if AMenuItem.RadioItem then
        TdxBarButton(Result).GroupIndex := AMenuItem.GroupIndex;
      TdxBarButton(Result).Down := AMenuItem.Checked;
    end;
  end;

  procedure FixBeginGroup(AItemLinks: TdxBarItemLinks);
  var
    I: Integer;
    ItemLink: TdxBarItemLink;
  begin
    for I := AItemLinks.Count - 1 downto 0 do
    begin
      ItemLink := AItemLinks.Items[I];
      if IsSeparator(ItemLink.Item) then
      begin
        ItemLink.Free;
        if I < AItemLinks.Count then
          AItemLinks.Items[I].BeginGroup := True;
      end;
    end;
  end;

  procedure ProcessSubMenu(AItemLinks: TdxBarItemLinks; AMenuItem: TMenuItem);
  var
    I: Integer;
    MI: TMenuItem;
    Item: TdxBarItem;
  begin
    for I := 0 to AMenuItem.Count - 1 do
    begin
      MI := AMenuItem.Items[I];
      Item := CreateItem(MI);
      if Item <> nil then
      begin
        AItemLinks.Add.Item := Item;
        if Item is TdxBarSubItem then
          ProcessSubMenu(TdxBarSubItem(Item).ItemLinks, MI);
      end;
    end;
    FixBeginGroup(AItemLinks);
  end;

begin
  Result := nil;
  if (APopupMenu <> nil) and (APopupMenu.Items.Count > 0) then
  begin
    Result := TdxBarPopupMenu.Create(FBarHostForm);
    try
      FBarManager.Images := APopupMenu.Images;
      ProcessSubMenu(TdxBarPopupMenu(Result).ItemLinks, APopupMenu.Items);
    except
      FBarManager.Images := nil;
      Result.Free;
      raise;
    end;
  end;
end;

procedure TdxRibbonPSPopupMenuBuilder.FreePopup(var APopupMenu: TComponent);
var
  I: Integer;
begin
  for I := 0 to FBarManager.ItemCount - 1 do
    FBarManager.Items[I].Free;
  FreeAndNil(APopupMenu);
end;

procedure TdxRibbonPSPopupMenuBuilder.InvokePopup(
  X, Y: Integer; AControl: TControl; APopupMenu: TComponent);
var
  R: TRect;
begin
  if APopupMenu is TdxBarPopupMenu then
  begin
    if AControl = nil then
      TdxBarPopupMenu(APopupMenu).Popup(X, Y)
    else
    begin
      R := cxRectOffset(AControl.ClientRect, AControl.ClientToScreen(cxNullPoint));
      TdxBarPopupMenu(APopupMenu).PopupEx(X, Y, AControl.Width, AControl.Height, True, @R);
    end;
  end;
end;

class function TdxRibbonPSPopupMenuBuilder.RequireProcessDoPopup: Boolean;
begin
  Result := True;
end;

{ TdxRibbonPSPageSetupMenuBuilder } 

class function TdxRibbonPSPageSetupMenuBuilder.ExtractPrintStyleFromObj(Obj: TObject): TBasedxPrintStyle;
begin
  if Obj is TdxBarListItem then
  begin
    with TdxBarListItem(Obj) do
      Result := TBasedxPrintStyle(Items.Objects[ItemIndex]);
  end
  else
    Result := inherited ExtractPrintStyleFromObj(Obj);
end;

procedure TdxRibbonPSPageSetupMenuBuilder.BuildPageSetupMenu(ARootItem: TObject; 
  AData: Pointer; AIncludeDefineItem: Boolean; 
  AStyles: TStringList; ACurrentStyle: TBasedxPrintStyle; 
  AOnStyleClick, AOnDefineStylesClick: TNotifyEvent);
begin
  if not (ARootItem is TdxBarListItem) then
  begin
    inherited BuildPageSetupMenu(ARootItem, AData, AIncludeDefineItem,
      AStyles, ACurrentStyle, AOnStyleClick, AOnDefineStylesClick);
    Exit;
  end;

  with TdxBarListItem(ARootItem) do
  begin
    Items.Clear;  
    Items := AStyles;
    if Items.Count > 0 then ItemIndex := ACurrentStyle.Index;
    OnClick := AOnStyleClick;
  end;
      
  if AIncludeDefineItem and (TObject(AData) is TdxBarButton) then
    with TdxBarButton(AData) do
    begin
      Caption := cxGetResourceString(@sdxDefinePrintStylesMenuItem);
      OnClick := AOnDefineStylesClick;
    end;
end;                                           

{ TdxRibbonPSAutoHFTextMenuBuilder }

procedure TdxRibbonPSAutoHFTextMenuBuilder.BuildAutoHFTextEntriesMenu(ARootItem: TObject; 
  AData: Pointer; AIncludeSetupAutoHFTextEntriesItem: Boolean; 
  AAutoHFTextEntries: TStrings; AOnHFTextEntriesClick, AOnSetupHFTextEntriesClick: TNotifyEvent);
begin
  if not (ARootItem is TdxBarListItem) then Exit;
    
  with TdxBarListItem(ARootItem) do 
  begin
    Items.Clear;  
    Items := AAutoHFTextEntries;
    OnClick := AOnHFTextEntriesClick;
  end;

  if AIncludeSetupAutoHFTextEntriesItem and (TObject(AData) is TdxBarButton) then
    with TdxBarButton(AData) do
    begin
      Caption := cxGetResourceString(@sdxMenuInsertEditAutoTextEntries);
      OnClick := AOnSetupHFTextEntriesClick;
    end;
end;

class function TdxRibbonPSAutoHFTextMenuBuilder.ExtractAutoHFTextEntryIndexFromObj(Obj: TObject): Integer;
begin
  Result := TdxBarListItem(Obj).ItemIndex;
end;

{ utility routines }

function AddPercentageChar(const S: string): string;
begin
  Result := S;
  if Result[Length(Result)] <> PercentSymbol then
    Result := Result + PercentSymbol;
end;

{ TdxRibbonPrintPreviewForm }

constructor TdxRibbonPrintPreviewForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FExplorerContextCommands := TList.Create;
  dxBarManager.BeginUpdate;
  try
    SetupBarManagerStyle(dxBarManager);
    dxLoadImageListFromResources(ilSmallImages, IDB_DXPSPREVIEW_TOOLBARS_SMALLIMAGELIST);
    dxLoadImageListFromResources(ilLargeImages, IDB_DXPSPREVIEW_RIBBON_IMAGELIST, HInstance);
    InitializeRibbonLookAndFeel;
    InitializeBackgroundColorsGallery;
  finally
    dxBarManager.EndUpdate;
  end;
end;

destructor TdxRibbonPrintPreviewForm.Destroy;
begin
  SaveBarManagerDefaults;
  FreeAndNil(FExplorerContextCommands);
  inherited Destroy;
end;

procedure TdxRibbonPrintPreviewForm.LoadBarManagerDefaults;
var
  AIniFile: TCustomIniFile;
begin
  if dxPSStoringManager.BeginStoring(AIniFile) then
  try
    Preview.LoadFromIniFile(AIniFile, dxPSFormGetActualSectionName(Self));
  finally
    dxPSStoringManager.EndStoring(AIniFile);
  end;
end;

procedure TdxRibbonPrintPreviewForm.SaveBarManagerDefaults;
var
  AIniFile: TCustomIniFile;
begin
  if dxPSStoringManager.BeginStoring(AIniFile) then
  try
    Preview.SaveToIniFile(AIniFile, dxPSFormGetActualSectionName(Self));
  finally
    dxPSStoringManager.EndStoring(AIniFile);
  end;
end;

procedure TdxRibbonPrintPreviewForm.LoadBarManager(
  AIniFile: TCustomIniFile; const ASectionName: string);
const
  StorageType: array[Boolean] of TdxBarStoringKind = (skIni, skReg);
var
  AIsSameVersion: Boolean;
begin
  AIsSameVersion :=
    (AIniFile.ReadInteger(dxValidatePath(ASectionName) + 'Version', 'Major', 0) = dxPSVerMajor) and
    (AIniFile.ReadInteger(dxValidatePath(ASectionName) + 'Version', 'Minor', 0) = dxPSVerMinor);

  if AIsSameVersion then
  begin
    TdxBarManagerAccess(dxBarManager).LoadBarManager(
      AIniFile, dxValidatePath(ASectionName) + sdxToolBars,
      StorageType[AIniFile is TRegistryIniFile]);
  end;
end;

procedure TdxRibbonPrintPreviewForm.SaveBarManager(
  AIniFile: TCustomIniFile; const ASectionName: string);
const
  StorageType: array[Boolean] of TdxBarStoringKind = (skIni, skReg);
begin
  AIniFile.WriteInteger(dxValidatePath(ASectionName) + 'Version', 'Major', dxPSVerMajor);
  AIniFile.WriteInteger(dxValidatePath(ASectionName) + 'Version', 'Minor', dxPSVerMinor);
  TdxBarManagerAccess(dxBarManager).SaveBarManager(
    AIniFile, dxValidatePath(ASectionName) + sdxToolBars,
    StorageType[AIniFile is TRegistryIniFile]);
end;

procedure TdxRibbonPrintPreviewForm.AfterConstruction;
begin
  inherited AfterConstruction;
  cbxPredefinedZoom.DropDownCount := Preview.PredefinedZooms.Count;
  seActivePage.Value := 1;
end;

procedure TdxRibbonPrintPreviewForm.InitContent;

  procedure AddEndEllipsis(AItem: TdxBarButton);
  begin
    if AnsiLastChar(AItem.Caption) <> '.' then
      AItem.Caption := dxPSUtl.AddEndEllipsis(AItem.Caption);
  end;

begin
  dxRibbon.DocumentName := ReportLink.ReportDocument.Caption;
  Preview.ThumbnailsPreview.PopupMenu := pmThumbnails;
  cbxPredefinedZoom.Text := IntToStr(ZoomFactor) + PercentSymbol;
  if Assigned(ReportLink) then
    seActivePage.MaxValue := ReportLink.PageCount;
    
  if IsExplorerAvailable then
    TWinControlAccess(Preview.ExplorerTree.Control).OnMouseUp := DoShowExplorerPopup
  else
  begin
    AddEndEllipsis(bbFileSave);
    AddEndEllipsis(bbFileLoad);
  end;
end;

procedure TdxRibbonPrintPreviewForm.UpdateContexts;

  procedure SetContextVisible(AContext: TdxRibbonContext; AVisible: Boolean);
  begin
    if AContext.Visible <> AVisible then
    begin
      AContext.Visible := AVisible;
      if AVisible and (AContext.TabCount > 0) then
        AContext.Tabs[0].Active := True;
    end;
  end;

begin
  SetContextVisible(dxRibbon.Contexts.Items[0], Preview.ShowExplorer);
  SetContextVisible(dxRibbon.Contexts.Items[1], HeaderAndFooterContextVisible);
end;

procedure TdxRibbonPrintPreviewForm.UpdateControls;
const
  ButtonStyles: array[Boolean] of TdxBarButtonStyle = (bsDefault, bsDropDown);
var
  APagesExists, AStyleManagerAssigned: Boolean;
  APageXCount, APageYCount: Integer;
begin
  if Locked or (csDestroying in ComponentState) then Exit;  
  
  APagesExists := Preview.Preview.PageCount > 0;
  Preview.BeginUpdate;
  try
    EnableItemsWhileBuilding(True);

    bbFileDesign.Enabled := Preview.CanDesign;
    bbFileRebuild.Enabled := Preview.CanRebuild;
    bbFileSave.Enabled := Preview.CanSaveReport;
    bbFileLoad.Enabled := Preview.CanLoadReport;
    bbFileClose.Enabled := Preview.CanUnloadReport;
    bbFilePrint.Enabled := Preview.CanPrint;
    bbExportToPDF.Enabled := Preview.CanExport;
    bbFilePrintDialog.Enabled := Preview.CanPrintDialog;
    bbFilePageSetup.Enabled := Preview.CanPageSetup;
    bbFilePageSetup.ButtonStyle := ButtonStyles[Preview.CanPrintStyle];
    bbFileExit.Enabled := not IsPrinting;

    bbLargePrint.Enabled := Preview.CanPrint;
    bbLargeExportToPDF.Enabled := Preview.CanExport;
    bbLargePrintDialog.Enabled := Preview.CanPrintDialog;
    bbLargePageSetup.Enabled := Preview.CanPageSetup;

    bbExplorer.Enabled := IsExplorerAvailable;
    bbExplorerCreateNewFolder.Enabled := IsExplorerAvailable and ExplorerTree.CanCreateFolder;
    bbExplorerDelete.Enabled := IsExplorerAvailable and ExplorerTree.CanDeleteSelection;
    bbExplorerRename.Enabled := IsExplorerAvailable and ExplorerTree.CanRenameSelectedItem;
    bbReportProperties.Enabled := IsExplorerAvailable and ExplorerTree.CanShowPropertySheetsForSelectedItem;

    bbFormatShowHideEmptyPages.Down := Assigned(ReportLink) and ReportLink.ShowEmptyPages;
    bbFormatTitle.Enabled := Assigned(ReportLink) and ReportLink.CanChangeTitle;
    bbFormatFootnotes.Enabled := Assigned(ReportLink) and ReportLink.CanChangeFootnotes;
    rgiBackgroundColor.Enabled := Preview.IsEnabled(peoPageBackground) and not IsPrinting;
    bbFormatShrinkToPageWidth.Enabled := APagesExists and not IsPrinting;
    if Assigned(ReportLink) then
    begin
      bbFormatShrinkToPageWidth.Down := ReportLink.ShrinkToPageWidth;
      SetBarItemVisibility(bbFormatShowHideEmptyPages, ReportLink.EmptyPagesCanExist);
      bbFormatShowHideEmptyPages.Down := ReportLink.ShowEmptyPages;
      ReportLink.GetPageColRowCount(APageXCount, APageYCount);
      bbZoomWidenToSourceWidth.Enabled := APageXCount > 1;
    end;

    bbZoomPageWidth.Enabled := APagesExists;
    bbZoomPercent100.Enabled := APagesExists;
    bbZoomWholePage.Enabled := APagesExists;
    bbZoomTwoPages.Enabled := APagesExists and (Preview.PageCount > 1);
    bbZoomFourPages.Enabled := APagesExists and (Preview.PageCount > 3);
    bbZoomMultiplePages.Enabled := APagesExists;
    cbxPredefinedZoom.Enabled := bbZoomPageWidth.Enabled;
    bbZoomSetup.Enabled := bbZoomPageWidth.Enabled;

    bbExplorer.Down := Preview.ShowExplorer;
    bbThumbnails.Down := Preview.ShowThumbnails;

    bbGoToFirstPage.Enabled := APagesExists and (Preview.Preview.SelPageIndex <> 0);
    bbGoToPrevPage.Enabled := APagesExists and (Preview.Preview.SelPageIndex <> 0);
    bbGoToNextPage.Enabled := APagesExists and (Preview.Preview.SelPageIndex <> Preview.PageCount - 1);
    bbGoToLastPage.Enabled := APagesExists and (Preview.Preview.SelPageIndex <> Preview.PageCount - 1);
    seActivePage.Enabled := Preview.PageCount > 1;

    bbViewMargins.Down := Preview.ShowPageMargins;
    bbViewMarginBar.Down := Preview.ShowMarginBar;
    bbViewStatusBar.Down := Preview.ShowStatusBar;
    SetBarItemVisibility(bbViewExplorer, IsExplorerAvailable);
    bbViewExplorer.Down := Preview.ShowExplorer;
    bbViewThumbnails.Down := Preview.ShowThumbnails;
    bbThumbnailsSmall.Down := Preview.ThumbnailsSize = tsSmall;
    bbThumbnailsLarge.Down := Preview.ThumbnailsSize = tsLarge;
    if ReportLink <> nil then
    begin
      bbViewPageHeaders.Down := ReportLink.ShowPageHeader;
      bbViewPageFooters.Down := ReportLink.ShowPageFooter;
    end;

    SetBarItemVisibility(bbExplorer, IsExplorerAvailable);
    SetBarItemVisibility(bbFileDesign, Preview.IsVisible(pvoReportDesign));
    SetBarItemVisibility(bbFileSave, Preview.IsCommandSaveReportVisible);
    SetBarItemVisibility(bbFileLoad, Preview.IsCommandLoadReportVisible);
    SetBarItemVisibility(bbFileClose, Preview.IsCommandUnloadReportVisible);
    SetBarItemVisibility(bbFilePrint, Preview.IsVisible(pvoPrint));
    SetBarItemVisibility(bbFilePrintDialog, Preview.IsVisible(pvoPrint));
    SetBarItemVisibility(bbFilePageSetup, Preview.IsVisible(pvoPageSetup));

    AStyleManagerAssigned := (ReportLink <> nil) and (ReportLink.StyleManager <> nil);
    dxBarInsertAutoText.Visible := AStyleManagerAssigned;
    SetBarItemVisibility(bbInsertEditAutoText, AStyleManagerAssigned);
    SetBarItemVisibility(bsiInsertAutoText, AStyleManagerAssigned);
    SetBarItemVisibility(bliInsertAutoTextEntries, AStyleManagerAssigned);
    SetBarItemVisibility(rgiBackgroundColor, Preview.IsVisible(pvoPageBackground));

    if not seActivePage.Enabled then
      seActivePage.Value := -1
    else
    begin
      seActivePage.MinValue := 1;
      if ReportLink <> nil then
      begin
        seActivePage.MaxValue := ReportLink.PageCount;
        seActivePage.Value := ReportLink.VirtualPageIndexToRealPageIndex(
          Preview.Preview.SelPageIndex) + 1;
      end
    end;

    if Preview.IsBuilding or IsPrinting then 
      EnableItemsWhileBuilding(False);
      
    UpdateContexts;
    EnabledHFItems(bbHeaderAndFooter.Down);
    UpdateExplorerContextCommands;
    UpdateRibbonHelpButton;
  finally
    Preview.CancelUpdate;
  end;
end; 

procedure TdxRibbonPrintPreviewForm.bbViewMarginsClick(Sender: TObject);
begin
  if not Locked then
    Preview.ShowPageMargins := TdxBarButton(Sender).Down;
end;

procedure TdxRibbonPrintPreviewForm.bbViewMarginBarClick(Sender: TObject);
begin
  if not Locked then
    Preview.ShowMarginBar := TdxBarButton(Sender).Down;
end;

procedure TdxRibbonPrintPreviewForm.bbViewStatusBarClick(Sender: TObject);
begin
  if not Locked then
    Preview.ShowStatusBar := TdxBarButton(Sender).Down;
end;

procedure TdxRibbonPrintPreviewForm.bbViewExplorerClick(Sender: TObject);
begin
  if not Locked then
    Preview.ShowExplorer := TdxBarButton(Sender).Down;
end;

procedure TdxRibbonPrintPreviewForm.pmExplorerPopup(Sender: TObject);
begin
  UpdateControls;
end;

procedure TdxRibbonPrintPreviewForm.bbThumbnailsSizeClick(Sender: TObject);
begin
  Preview.ThumbnailsSize := TdxPSThumbnailsSize(TTagToInt(TComponent(Sender).Tag));
end;

procedure TdxRibbonPrintPreviewForm.bbViewThumbnailsClick(Sender: TObject);
begin
  if not Locked then
    Preview.ShowThumbnails := TdxBarButton(Sender).Down;
end;

procedure TdxRibbonPrintPreviewForm.DesignClick(Sender: TObject);
begin
  Preview.DoDesignReport;
end;

procedure TdxRibbonPrintPreviewForm.bbFileRebuildClick(Sender: TObject);
begin
  if Preview.CanRebuild then
    Preview.RebuildReport;
end;

procedure TdxRibbonPrintPreviewForm.PrintClick(Sender: TObject);
const
  BtnClicked: Boolean = False;
begin
  if not BtnClicked then
  begin
    BtnClicked := True;
    try
      Preview.DoPrintReport(Boolean(TTagToInt(TComponent(Sender).Tag)));
    finally
      BtnClicked := False;
    end;
  end;
end;

procedure TdxRibbonPrintPreviewForm.PageSetupClick(Sender: TObject);
begin
  DoPageSetupReport(0);
end;

procedure TdxRibbonPrintPreviewForm.FileSaveClick(Sender: TObject);
begin
  Preview.DoExplorerCreateNewItem;
end;

procedure TdxRibbonPrintPreviewForm.ExplorerLoadDataClick(Sender: TObject);
begin
  Preview.DoExplorerLoadItemData;
end;

procedure TdxRibbonPrintPreviewForm.bbFileCloseClick(Sender: TObject);
begin
  Preview.DoExplorerUnloadItemData;
end;

procedure TdxRibbonPrintPreviewForm.ExplorerCreateNewFolderClick(Sender: TObject);
begin
  ExplorerTree.FocusedItem := ExplorerTree.SelectedItem;
  PostCreateFolderMessage;
end;

procedure TdxRibbonPrintPreviewForm.InitializeBackgroundColorsGallery;

  function CreateColorBitmap(AColor: TColor): TcxAlphaBitmap;
  begin
    Result := TcxAlphaBitmap.CreateSize(12, 12);
    Result.cxCanvas.FillRect(Result.ClientRect, AColor);
    Result.cxCanvas.FrameRect(Result.ClientRect, clGrayText);
    Result.TransformBitmap(btmSetOpaque);
  end;

  procedure PopulateColors(AGroup: TdxRibbonGalleryGroup);
  var
    ABitmap: TcxAlphaBitmap;
    AItem: TdxRibbonGalleryGroupItem;
    I, J: Integer;
  begin
    for I := 0 to dxPaletteRowCount - 1 do
      for J := 0 to dxPaletteColCount - 1 do
      begin
        ABitmap := CreateColorBitmap(dxPaletteColors[J, I]);
        try
          AItem :=  AGroup.Items.Add;
          AItem.OnClick := DoGalleryColorItemClick;
          AItem.Tag := dxPaletteColors[J, I];
          AItem.Glyph := ABitmap;
          AItem.Caption := cxGetResourceString(dxPaletteColorHints[J, I]);
        finally
          ABitmap.Free;
        end;
      end;
  end;

begin
  PopulateColors(rgiBackgroundColor.GalleryGroups[0]);
end;

procedure TdxRibbonPrintPreviewForm.PostCreateFolderMessage;
begin
  PostMessage(Handle, DXM_PS_CREATEFOLDER, 0, 0);
end;

procedure TdxRibbonPrintPreviewForm.ExplorerDeleteItemClick(Sender: TObject);
begin
  Preview.DoExplorerDeleteItem;
end;

procedure TdxRibbonPrintPreviewForm.ExplorerRenameItemClick(Sender: TObject);
begin
  Preview.DoExplorerRenameItem;
end;

procedure TdxRibbonPrintPreviewForm.bbExplorerPropertiesClick(Sender: TObject);
begin
  Preview.DoExplorerItemShowPropertySheets;
end;

procedure TdxRibbonPrintPreviewForm.PageBackgroundClick(Sender: TObject);
begin
  Preview.DoShowPageBackgroundDlg(CalcWindowPos(Sender));
end;

procedure TdxRibbonPrintPreviewForm.bbFormatShrinkToPageWidthClick(Sender: TObject);
begin
  if Assigned(ReportLink) then
  begin
    ReportLink.ShrinkToPageWidth := not ReportLink.ShrinkToPageWidth;
    Preview.DoShrinkToPageWidth(ReportLink.ShrinkToPageWidth);
  end;
end;

procedure TdxRibbonPrintPreviewForm.bbFormatShowHideEmptyPagesClick(Sender: TObject);
begin
  if not Locked then
    Preview.DoShowEmptyPages(TdxBarButton(Sender).Down);
end;

procedure TdxRibbonPrintPreviewForm.bbZoomSetupClick(Sender: TObject);
begin
  Preview.DoShowZoomDlg;
end;

procedure TdxRibbonPrintPreviewForm.bliPrintStylesGetData(Sender: TObject);
begin
  if Assigned(ReportLink.CurrentPrintStyle) then
    bliPrintStyles.ItemIndex := ReportLink.CurrentPrintStyle.Index;
end;

procedure TdxRibbonPrintPreviewForm.cbxPredefinedZoomClick(Sender: TObject);
begin
  Preview.DoShowZoomDlg;
end;

procedure TdxRibbonPrintPreviewForm.bbZoomMultiplePagesClick(Sender: TObject);
var
  Link: TdxBarItemLink;
  R: TRect;
  YShift: Integer;
begin
  Link := TdxBarItem(Sender).ClickItemLink;
  if Assigned(Link) and Assigned(Link.Control) then
  begin
    R := Link.ItemRect;
    MapWindowPoints(Link.BarControl.Handle, 0, R, 2);
    YShift := R.Bottom - R.Top;
  end
  else
  begin
    GetWindowRect(Preview.Preview.Handle, R);
    OffsetRect(R, 3, 0);
    YShift := 3;
  end;
  Preview.DoShowMultiplySelectPagesDlg(ilSmallImages, PageSelectorImageIndex, R.TopLeft, YShift);
end;

procedure TdxRibbonPrintPreviewForm.GoToPageClick(Sender: TObject);
begin
  case TTagToInt(TComponent(Sender).Tag) of
    0: Preview.GoToFirstPage;
    1: Preview.GoToPrevPage;
    2: Preview.GoToNextPage;
    3: Preview.GoToLastPage;
  end;
end;

procedure TdxRibbonPrintPreviewForm.CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TdxRibbonPrintPreviewForm.HelpClick(Sender: TObject);
begin
  Preview.DoInvokeHelp;
end;

procedure TdxRibbonPrintPreviewForm.Activate;
begin
  inherited;
  TimerHint.Enabled := True;
end;

procedure TdxRibbonPrintPreviewForm.WndProc(var Message: TMessage);
begin
  if Message.Msg = DXM_PS_CREATEFOLDER then
  begin
    ExplorerTree.SelectedItem := ExplorerTree.FocusedItem;
    Preview.DoExplorerCreateNewFolder;
  end
  else
    inherited;
end;

procedure TdxRibbonPrintPreviewForm.AddExplorerContextCommand(
  ACommand: TCustomdxPSExplorerContextCommand);

  procedure AddBarControl(AItemLinks: TdxBarItemLinks; ABarButton: TdxBarButton);
  var
    ALink: TdxBarItemLink;
  begin
    ALink := AItemLinks.Add;
    ALink.Item := ABarButton;
    ALink.Index := 0;
    ALink.BringToTopInRecentList(True);
  end;

  procedure BeginGroup(AItemLinks: TdxBarItemLinks);
  begin
    if AItemLinks.Count <> 0 then
      AItemLinks[0].BeginGroup := True;
  end;
  
var
  ABarButton: TdxBarButton;
begin
  if ACommand is TdxPSExplorerContextCommandSeparator then
  begin
    BeginGroup(dxBarExplorer.ItemLinks);
    BeginGroup(pmExplorer.ItemLinks);
  end
  else
  begin
    ABarButton := TdxBarButton.Create(Self);
    ABarButton.Glyph := ACommand.Bitmap;
    ABarButton.Caption := ACommand.Caption;
    ABarButton.Enabled := ACommand.Enabled;
    ABarButton.Hint := ACommand.Hint;
    ABarButton.ShortCut := ACommand.ShortCut;
    ABarButton.Tag := MakeTTag(ACommand);
    ABarButton.OnClick := ExplorerContextCommandClick;

    AddBarControl(dxBarExplorer.ItemLinks, ABarButton);
    AddBarControl(pmExplorer.ItemLinks, ABarButton);
    ACommand.Data := Integer(ABarButton);

    if FExplorerContextCommands.IndexOf(ACommand) = -1 then
      FExplorerContextCommands.Add(ACommand);
  end;
end;

procedure TdxRibbonPrintPreviewForm.ExplorerContextCommandClick(Sender: TObject);
var
  Command: TCustomdxPSExplorerContextCommand;
  CommandSet2: IdxPSExplorerContextCommands2;
begin
  Command := TCustomdxPSExplorerContextCommand(TTagToObj(TdxBarButton(Sender).Tag));
  if Supports(Preview.Explorer, IdxPSExplorerContextCommands2, CommandSet2) then
  begin
    CommandSet2.InitializeCommand(Command);
    try
      if Command.Enabled then
        Command.Execute;
    finally
      CommandSet2.FinalizeCommand(Command);
    end;
  end;  
  UpdateControls;
end;

procedure TdxRibbonPrintPreviewForm.UpdateExplorerContextCommands;
var
  I: Integer;
begin
  if not (csDestroying in ComponentState) then
    for I := 0 to ExplorerContextCommandCount - 1 do
    begin
      with ExplorerContextCommands[I] do
        TdxBarButton(Data).Enabled := Enabled;
    end;
end;

procedure TdxRibbonPrintPreviewForm.UpdateRibbonHelpButton;
begin
  if Preview.IsEnabled(peoHelp) then
    dxRibbon.OnHelpButtonClick := dxRibbonHelpButtonClick
  else
    dxRibbon.OnHelpButtonClick := nil;
end;

procedure TdxRibbonPrintPreviewForm.DoAfterPrintReport(AShowDialog: Boolean);
begin
  if AShowDialog then
    bbFilePrint.Hint := cxGetResourceString(@sdxHintFilePrint) + GetCurrentPrinterAsHint;
end;

procedure TdxRibbonPrintPreviewForm.InitializeRibbonLookAndFeel;
begin
  if Assigned(dxPSEngine.DialogsLookAndFeel.SkinPainter) then
    dxRibbon.ColorSchemeName := dxPSEngine.DialogsLookAndFeel.SkinName
  else
    dxRibbon.ColorSchemeName := 'Blue';
end;

procedure TdxRibbonPrintPreviewForm.LoadStrings;
begin
  dxBarZoom.Caption := cxGetResourceString(@sdxRibbonPrintPreviewGroupZoom);
  dxBarReport.Caption := cxGetResourceString(@sdxRibbonPrintPreviewGroupReport);
  dxBarFormat.Caption := cxGetResourceString(@sdxRibbonPrintPreviewGroupFormat);
  dxBarNavigation.Caption := cxGetResourceString(@sdxRibbonPrintPreviewGroupNavigation);
  dxBarMorePages.Caption := cxGetResourceString(@sdxRibbonPrintPreviewPagesSubItem);
  dxBarView.Caption := cxGetResourceString(@sdxMenuShortcutPreview);
  dxBarExplorerReport.Caption := cxGetResourceString(@sdxRibbonPrintPreviewGroupReport);
  dxBarExplorer.Caption := cxGetResourceString(@sdxMenuExplorer);
  dxBarInsertAutoText.Caption := cxGetResourceString(@sdxMenuInsertAutoText);
  dxBarInsertDateTime.Caption := cxGetResourceString(@sdxMenuInsertDateTime);
  dxBarInsertName.Caption := cxGetResourceString(@sdxRibbonPrintPreviewGroupInsertName);
  dxBarInsertPageNumber.Caption := cxGetResourceString(@sdxRibbonPrintPreviewGroupInsertPageNumber);
  dxBarHeaderAndFooterParts.Caption := cxGetResourceString(@sdxRibbonPrintPreviewGroupParts);
  dxBarHeaderAndFooterClose.Caption := cxGetResourceString(@sdxBtnClose);
  dxBarOutput.Caption := cxGetResourceString(@sdxRibbonPrintPreviewGroupOutput);

  bbZoom.Caption := cxGetResourceString(@sdxRibbonPrintPreviewGroupZoom);
  bbFormatSubItem.Caption := cxGetResourceString(@sdxRibbonPrintPreviewGroupFormat);
  bbFormatSubItem.Hint := cxGetResourceString(@sdxRibbonPrintPreviewGroupFormat);
  bbNavigation.Caption := cxGetResourceString(@sdxRibbonPrintPreviewGroupNavigation);
  bbExplorer.Caption := cxGetResourceString(@sdxMenuExplorer);
  bbThumbnails.Caption := cxGetResourceString(@sdxMenuViewThumbnails);
  bbHeaderAndFooter.Caption := cxGetResourceString(@sdxMenuFormatHeaderAndFooter);
  bbClosePreview.Caption := cxGetResourceString(@sdxRibbonPrintPreviewClosePrintPreview);
  bbReportProperties.Caption := cxGetResourceString(@sdxMenuExplorerProperties);
  bbBarExplorerClose.Caption := cxGetResourceString(@sdxBtnClose);
  bbCloseHeaderAndFooter.Caption := cxGetResourceString(@sdxBtnClose);
  bbView.Caption := cxGetResourceString(@sdxMenuView);

  rtMain.Caption := DropAmpersand(cxGetResourceString(@sdxMenuShortcutPreview));
  rtExplorer.Caption := DropAmpersand(cxGetResourceString(@sdxMenuExplorer));
  rtHeader.Caption := cxGetResourceString(@sdxMenuViewSwitchToHeader);
  rtFooter.Caption := cxGetResourceString(@sdxMenuViewSwitchToFooter);
  bbPageSetup.Caption := cxGetResourceString(@sdxMenuFilePageSetup);
  dxBarPageSetup.Caption := DropAmpersand(cxGetResourceString(@sdxMenuFilePageSetup));

  dxRibbon.Contexts.Items[0].Caption := rtExplorer.Caption;
  dxRibbon.Contexts.Items[1].Caption := DropAmpersand(cxGetResourceString(@sdxHeaderFooterBar));

  bbFileSave.Caption := cxGetResourceString(@sdxMenuFileSave);
  bbFileLoad.Caption := cxGetResourceString(@sdxMenuFileLoad);
  bbFileClose.Caption := cxGetResourceString(@sdxMenuFileClose);
  bbFileDesign.Caption := cxGetResourceString(@sdxMenuFileDesign);
  bbFilePrintDialog.Caption := cxGetResourceString(@sdxMenuFilePrintDialog);
  bbFilePrint.Caption := DropEndEllipsis(cxGetResourceString(@sdxMenuFilePrint));
  bbFileRebuild.Caption := cxGetResourceString(@sdxMenuFileRebuild);
  bliPrintStyles.Caption := cxGetResourceString(@sdxMenuPrintStyles);
  bbFilePageSetup.Caption := cxGetResourceString(@sdxMenuFilePageSetup);
  bbFileExit.Caption := cxGetResourceString(@sdxMenuFileExit);
  bbExportToPDF.Caption := cxGetResourceString(@sdxMenuExportToPDF);

  bbLargePrint.Caption := DropEndEllipsis(cxGetResourceString(@sdxMenuFilePrint));
  bbLargeExportToPDF.Caption := cxGetResourceString(@sdxMenuExportToPDF);
  bbLargePrintDialog.Caption := cxGetResourceString(@sdxMenuFilePrintDialog);
  bbLargePageSetup.Caption := cxGetResourceString(@sdxMenuFilePageSetup);

  bbExplorerCreateNewFolder.Caption := cxGetResourceString(@sdxMenuExplorerCreateFolder);
  bbExplorerDelete.Caption := cxGetResourceString(@sdxMenuExplorerDelete);
  bbExplorerRename.Caption := cxGetResourceString(@sdxMenuExplorerRename);
  bbHeaderAndFooter.Caption := cxGetResourceString(@sdxMenuFormatHeaderAndFooter);
  
  bbEdit.Caption := cxGetResourceString(@sdxMenuEdit);
  bbEditFind.Caption := cxGetResourceString(@sdxMenuEditFind);
  bbEditFindNext.Caption := cxGetResourceString(@sdxMenuEditFindNext);
  bbEditReplace.Caption := cxGetResourceString(@sdxMenuEditReplace);

  bbInsertEditAutoText.Caption := cxGetResourceString(@sdxMenuInsertEditAutoTextEntries);
  bsiInsertAutoText.Caption := cxGetResourceString(@sdxMenuInsertAutoTextEntriesSubItem);
  bliInsertAutoTextEntries.Caption := cxGetResourceString(@sdxMenuInsertAutoTextEntries);
  bbInsertHFPageNumber.Caption := cxGetResourceString(@sdxMenuInsertPageNumber);
  bbInsertHFTotalPages.Caption := cxGetResourceString(@sdxMenuInsertTotalPages);
  bbInsertHFPageOfPages.Caption := cxGetResourceString(@sdxMenuInsertPageOfPages);
  bbInsertHFDateTime.Caption := cxGetResourceString(@sdxMenuInsertDateTime);
  bbInsertHFDate.Caption := cxGetResourceString(@sdxMenuInsertDate);
  bbInsertHFTime.Caption := cxGetResourceString(@sdxMenuInsertTime);
  bbInsertHFUserName.Caption := cxGetResourceString(@sdxMenuInsertUserName);
  bbInsertHFMachineName.Caption := cxGetResourceString(@sdxMenuInsertMachineName);

  bbViewMargins.Caption := cxGetResourceString(@sdxMenuViewMargins);
  bbViewMarginBar.Caption := cxGetResourceString(@sdxMenuViewMarginsStatusBar);
  bbViewStatusBar.Caption := cxGetResourceString(@sdxMenuViewPagesStatusBar);
  bbViewExplorer.Caption := cxGetResourceString(@sdxMenuViewExplorer);
  bbViewThumbnails.Caption := cxGetResourceString(@sdxMenuViewThumbnails);
  bbThumbnailsSmall.Caption := cxGetResourceString(@sdxMenuThumbnailsSmall);
  bbThumbnailsLarge.Caption := cxGetResourceString(@sdxMenuThumbnailsLarge);
  
  bbZoomPercent100.Caption := cxGetResourceString(@sdxMenuZoomPercent100);
  bbZoomPageWidth.Caption := cxGetResourceString(@sdxMenuZoomPageWidth);
  bbZoomWholePage.Caption := cxGetResourceString(@sdxMenuZoomWholePage);
  bbZoomTwoPages.Caption := cxGetResourceString(@sdxMenuZoomTwoPages);
  bbZoomFourPages.Caption := cxGetResourceString(@sdxMenuZoomFourPages);
  bbZoomMultiplePages.Caption := cxGetResourceString(@sdxMenuZoomMultiplyPages);
  bbZoomWidenToSourceWidth.Caption := cxGetResourceString(@sdxMenuZoomWidenToSourceWidth);
  bbZoomSetup.Caption := cxGetResourceString(@sdxMenuZoomSetup);
  bbViewPageHeaders.Caption := cxGetResourceString(@sdxMenuViewPagesHeaders);
  bbViewPageFooters.Caption := cxGetResourceString(@sdxMenuViewPagesFooters);
  bbViewSwitchToLeftPart.Caption := cxGetResourceString(@sdxMenuViewSwitchToLeftPart);
  bbViewSwitchToRightPart.Caption := cxGetResourceString(@sdxMenuViewSwitchToRightPart);
  bbViewSwitchToCenterPart.Caption := cxGetResourceString(@sdxMenuViewSwitchToCenterPart);
  bbViewHFClose.Caption := cxGetResourceString(@sdxMenuViewHFClose);

  bbFormatFootnotes.Caption := cxGetResourceString(@sdxMenuFormatFootnotes);
  bbFormatTitle.Caption := cxGetResourceString(@sdxMenuFormatTitle);
  bbFormatDateTime.Caption := cxGetResourceString(@sdxMenuFormatDateTime);
  bbFormatPageNumbering.Caption := cxGetResourceString(@sdxMenuFormatPageNumbering);
  bbFormatShrinkToPageWidth.Caption := cxGetResourceString(@sdxMenuFormatShrinkToPage);
  bbFormatShowHideEmptyPages.Caption := cxGetResourceString(@sdxMenuShowEmptyPages);
  bbFormatHFBackground.Caption := cxGetResourceString(@sdxMenuFormatHFBackground);
  bbFormatHFClear.Caption := cxGetResourceString(@sdxMenuFormatHFClear);

  rgiBackgroundColor.Caption := cxGetResourceString(@sdxHintFormatPageBackground);
  rgiBackgroundColor.GalleryGroups[0].Header.Caption := rgiBackgroundColor.Caption;
  bbBackgroundNoFill.Caption := cxGetResourceString(@sdxBtnNoFill);
  bbBackgroundMoreColors.Caption := cxGetResourceString(@sdxBtnMoreColors);
  bbBackgroundFillEffects.Caption := cxGetResourceString(@sdxBtnFillEffects);

  bbGotoFirstPage.Caption := cxGetResourceString(@sdxMenuGotoPageFirst);
  bbGotoPrevPage.Caption := cxGetResourceString(@sdxMenuGotoPagePrev);
  bbGotoNextPage.Caption := cxGetResourceString(@sdxMenuGotoPageNext);
  bbGotoLastPage.Caption := cxGetResourceString(@sdxMenuGotoPageLast);

  cbxPredefinedZoom.Caption := cxGetResourceString(@sdxMenuZoom) + ':';
  cbxPredefinedZoom.Items[8] := cxGetResourceString(@sdxPageWidth); 
  cbxPredefinedZoom.Items[9] := cxGetResourceString(@sdxWholePage);
  cbxPredefinedZoom.Items[10] := cxGetResourceString(@sdxTwoPages); 
  cbxPredefinedZoom.Items[11] := cxGetResourceString(@sdxFourPages);
  cbxPredefinedZoom.Items[12] := cxGetResourceString(@sdxWidenToSourceWidth);
  seActivePage.Caption := cxGetResourceString(@sdxMenuActivePage);

  { hints }
  bbFileDesign.Hint := cxGetResourceString(@sdxHintFileDesign);
  bbFileSave.Hint := cxGetResourceString(@sdxHintFileSave);
  bbFileLoad.Hint := cxGetResourceString(@sdxHintFileLoad);
  bbFileClose.Hint := cxGetResourceString(@sdxHintFileClose);
  bbFilePrint.Hint := cxGetResourceString(@sdxHintFilePrint) + dxPSPrVw.GetCurrentPrinterAsHint;
  bbFilePrintDialog.Hint := cxGetResourceString(@sdxHintFilePrintDialog);
  bbFilePageSetup.Hint := cxGetResourceString(@sdxHintFilePageSetup);
  bbFileExit.Hint := cxGetResourceString(@sdxHintFileExit);
  bbExportToPDF.Hint := cxGetResourceString(@sdxHintExportToPDF);

  bbLargePrint.Hint := cxGetResourceString(@sdxHintFilePrint) + dxPSPrVw.GetCurrentPrinterAsHint;
  bbLargeExportToPDF.Hint := cxGetResourceString(@sdxHintExportToPDF);
  bbLargePrintDialog.Hint := cxGetResourceString(@sdxHintFilePrintDialog);
  bbLargePageSetup.Hint := cxGetResourceString(@sdxHintFilePageSetup);  

  bbExplorerCreateNewFolder.Hint := cxGetResourceString(@sdxHintExplorerCreateFolder);
  bbExplorerDelete.Hint := cxGetResourceString(@sdxHintExplorerDelete);
  bbExplorerRename.Hint := cxGetResourceString(@sdxHintExplorerRename);
  
  bbEditFind.Hint := cxGetResourceString(@sdxHintEditFind);
  bbEditFindNext.Hint := cxGetResourceString(@sdxHintEditFindNext);
  bbEditReplace.Hint := cxGetResourceString(@sdxHintEditReplace);

  bbInsertEditAutoText.Hint := cxGetResourceString(@sdxHintInsertEditAutoTextEntries);
  bbInsertHFPageNumber.Hint := cxGetResourceString(@sdxHintInsertPageNumber);
  bbInsertHFTotalPages.Hint := cxGetResourceString(@sdxHintInsertTotalPages);
  bbInsertHFPageOfPages.Hint := cxGetResourceString(@sdxHintInsertPageOfPages);
  bbInsertHFDateTime.Hint := cxGetResourceString(@sdxHintInsertDateTime);
  bbInsertHFDate.Hint := cxGetResourceString(@sdxHintInsertDate);
  bbInsertHFTime.Hint := cxGetResourceString(@sdxHintInsertTime);
  bbInsertHFUserName.Hint := cxGetResourceString(@sdxHintInsertUserName);
  bbInsertHFMachineName.Hint := cxGetResourceString(@sdxHintInsertMachineName);
  
  bbViewMargins.Hint := cxGetResourceString(@sdxHintViewMargins);
  bbViewMarginBar.Hint := cxGetResourceString(@sdxHintViewMarginsStatusBar);
  bbViewStatusBar.Hint := cxGetResourceString(@sdxHintViewPagesStatusBar);
  bbViewExplorer.Hint := cxGetResourceString(@sdxHintViewExplorer);
  bbViewThumbnails.Hint := cxGetResourceString(@sdxHintViewThumbnails);
  bbThumbnailsSmall.Hint := cxGetResourceString(@sdxHintThumbnailsSmall);
  bbThumbnailsLarge.Hint := cxGetResourceString(@sdxHintThumbnailsLarge);
  cbxPredefinedZoom.Hint := cxGetResourceString(@sdxHintViewZoom);
  bbZoomPercent100.Hint := cxGetResourceString(@sdxHintZoomPercent100);
  bbZoomPageWidth.Hint := cxGetResourceString(@sdxHintZoomPageWidth);
  bbZoomWholePage.Hint := cxGetResourceString(@sdxHintZoomWholePage);
  bbZoomTwoPages.Hint := cxGetResourceString(@sdxHintZoomTwoPages);
  bbZoomFourPages.Hint := cxGetResourceString(@sdxHintZoomFourPages);
  bbZoomMultiplePages.Hint := cxGetResourceString(@sdxHintZoomMultiplyPages);
  bbZoomWidenToSourceWidth.Hint := cxGetResourceString(@sdxHintZoomWidenToSourceWidth);
  bbZoomSetup.Hint := cxGetResourceString(@sdxHintZoomSetup);
  bbViewPageHeaders.Hint := cxGetResourceString(@sdxHintViewPagesHeaders);
  bbViewPageFooters.Hint := cxGetResourceString(@sdxHintViewPagesFooters);
  bbViewSwitchToLeftPart.Hint := cxGetResourceString(@sdxHintViewSwitchToLeftPart);
  bbViewSwitchToRightPart.Hint := cxGetResourceString(@sdxHintViewSwitchToRightPart);
  bbViewSwitchToCenterPart.Hint := cxGetResourceString(@sdxHintViewSwitchToCenterPart);

  bbFormatFootnotes.Hint := cxGetResourceString(@sdxHintFormatFootnotes);
  bbFormatTitle.Hint := cxGetResourceString(@sdxHintFormatTitle);
  bbFormatDateTime.Hint := cxGetResourceString(@sdxHintFormatDateTime);
  bbFormatPageNumbering.Hint := cxGetResourceString(@sdxHintFormatPageNumbering);
  bbFormatShrinkToPageWidth.Hint := cxGetResourceString(@sdxHintFormatShrinkToPage);
  bbFormatHFBackground.Hint := cxGetResourceString(@sdxHintFormatHFBackground);
  bbFormatHFClear.Hint := cxGetResourceString(@sdxHintFormatHFClear);

  bbGotoFirstPage.Hint := cxGetResourceString(@sdxHintGotoPageFirst);
  bbGotoPrevPage.Hint := cxGetResourceString(@sdxHintGotoPagePrev);
  bbGotoNextPage.Hint := cxGetResourceString(@sdxHintGotoPageNext);
  bbGotoLastPage.Hint := cxGetResourceString(@sdxHintGotoPageLast);
  seActivePage.Hint := cxGetResourceString(@sdxHintActivePage);
end;

procedure TdxRibbonPrintPreviewForm.ZoomClick(Sender: TObject);
var
  PageXCount, PageYCount: Integer;
  ZoomMode: TdxPreviewZoomMode;
begin
  case TTagToInt(TComponent(Sender).Tag) of
    0: ZoomMode := pzmNone;
    1: ZoomMode := pzmPageWidth;
  else
    ZoomMode := pzmPages;
  end;
  PageXCount := 1;
  PageYCount := 1;
  if ZoomMode = pzmPages then
  begin
    case TTagToInt(TComponent(Sender).Tag) of
      3: PageXCount := 2;
      4:
        begin
          PageXCount := 2;
          PageYCount := 2;
        end;
      5: ReportLink.GetPageColRowCount(PageXCount, PageYCount);
    end;
  end;
  Preview.DoSetupZoomFactor(100, PageXCount, PageYCount, ZoomMode);
end;

procedure TdxRibbonPrintPreviewForm.SetBarItemVisibility(Item: TdxBarItem; Value: Boolean);
begin
  Item.Visible := VisibleToBarItemVisible(Value);
end;

procedure TdxRibbonPrintPreviewForm.DoShowHFToolBar(Value: Boolean);
begin
  if not Locked then
  begin
    Preview.BeginUpdate;
    try
      FHeaderAndFooterContextVisible := Value;
      bbHeaderAndFooter.Down := Value;
      UpdateContexts;
      UpdateHFState(Value);
    finally
      Preview.EndUpdate;
    end;
  end;
end;

procedure TdxRibbonPrintPreviewForm.seActivePageChange(Sender: TObject);
var
  V: Integer;
begin
  if not Locked then
  begin
    V := seActivePage.IntCurValue;
    V := Max(V, Round(seActivePage.MinValue));
    V := Min(V, Round(seActivePage.MaxValue));
    Preview.DoActivePageChanged(V - 1);
  end;
end;

procedure TdxRibbonPrintPreviewForm.seActivePageButtonClick(
  Sender: TdxBarSpinEdit; Button: TdxBarSpinEditButton);
begin
  if Locked then Exit;
  case Button of
    sbUp: 
      Preview.GoToNextPage;
    sbDown: 
      Preview.GoToPrevPage;
  end;
end;

procedure TdxRibbonPrintPreviewForm.cbxPredefinedZoomChange(Sender: TObject);
begin
  Preview.SetZoomFactorByText(cbxPredefinedZoom.Text);
  if cbxPredefinedZoom.DroppedDown then
    Windows.SetFocus(Preview.Handle);
  UpdateControls;
  cbxPredefinedZoom.Text := AddPercentageChar(IntToStr(ZoomFactor));
end;
                
procedure TdxRibbonPrintPreviewForm.bbViewHFCloseClick(Sender: TObject);
begin
  Preview.DoShowHFToolBar(False);
end;

procedure TdxRibbonPrintPreviewForm.bbFormatHeaderAndFooterClick(Sender: TObject);
begin
  Preview.DoShowHFToolBar(TdxBarButton(Sender).Down);
end;

procedure TdxRibbonPrintPreviewForm.InsertHFClick(Sender: TObject);
begin
  Preview.DoInsertHF(Preview.HFFunctionList[TTagToInt(TComponent(Sender).Tag)]);
end;

procedure TdxRibbonPrintPreviewForm.bbFormatHFClearClick(Sender: TObject);
begin
  Preview.DoClearHF;
end;

procedure TdxRibbonPrintPreviewForm.bbFormatDateTimeClick(Sender: TObject);
begin
  Preview.DoShowFormatDateTimeDlg;
end;

procedure TdxRibbonPrintPreviewForm.bbFormatTitleClick(Sender: TObject);
begin
  Preview.DoFormatTitle;
end;

procedure TdxRibbonPrintPreviewForm.bbFormatFootnotesClick(Sender: TObject);
begin
  Preview.DoFormatFootnotes;
end;

procedure TdxRibbonPrintPreviewForm.bbFormatPageNumbersClick(Sender: TObject);
begin
  Preview.DoShowFormatPageNumbersDlg;
end;

procedure TdxRibbonPrintPreviewForm.SwitchPartClick(Sender: TObject);
begin
  Preview.HFEditPart := TdxPageTitlePart(TTagToInt(TdxBarButton(Sender).Tag));
end;

procedure TdxRibbonPrintPreviewForm.bbFormatHFBackgroundClick(Sender: TObject);
begin
  Preview.DoShowHFBackgroundDlg(CalcWindowPos(Sender));
end;

procedure TdxRibbonPrintPreviewForm.bbViewPageHeadersClick(Sender: TObject);
begin
  if not Locked then
    Preview.DoShowPageHeaders(TdxBarButton(Sender).Down);
end;

procedure TdxRibbonPrintPreviewForm.bbViewPageFootersClick(Sender: TObject);
begin
  if not Locked then
    Preview.DoShowPageFooters(TdxBarButton(Sender).Down);
end;

procedure TdxRibbonPrintPreviewForm.bbToolsCustomizeClick(Sender: TObject);
begin
  dxBarManager.Customizing(True);
end;

function TdxRibbonPrintPreviewForm.GetExplorerContextCommand(
  Index: Integer): TCustomdxPSExplorerContextCommand;
begin
  Result := TCustomdxPSExplorerContextCommand(FExplorerContextCommands.Items[Index]);
end;

function TdxRibbonPrintPreviewForm.GetExplorerContextCommandCount: Integer;
begin
  Result := FExplorerContextCommands.Count;
end;

function TdxRibbonPrintPreviewForm.GetExplorerTree: TCustomdxPSExplorerTreeContainer;
begin
  Result := Preview.ExplorerTree;
end;

function TdxRibbonPrintPreviewForm.GetIsExplorerAvailable: Boolean;
begin
  Result := Preview.IsExplorerAvailable;
end;

function TdxRibbonPrintPreviewForm.GetIsPrinting: Boolean;
begin
  Result := Preview.IsPrinting;
end;

function TdxRibbonPrintPreviewForm.GetLocked: Boolean;
begin
  Result := Preview.Locked;
end;

function TdxRibbonPrintPreviewForm.GetReportLink: TBasedxReportLink;
begin
  Result := Preview.ReportLink;
end;

function TdxRibbonPrintPreviewForm.GetZoomFactor: Integer;
begin
  Result := Preview.ZoomFactor;
end;

function TdxRibbonPrintPreviewForm.CalcWindowPos(Sender: TObject): TPoint;
var
  Link: TdxBarItemLink;
  R: TRect;
begin
  Result := cxNullPoint;
  Link := TdxBarItem(Sender).ClickItemLink;
  if (Link <> nil) and (Link.Control <> nil) then
  begin
    R := Link.ItemRect;
    MapWindowPoints(Link.BarControl.Handle, 0, R, 2);
    Result.X := R.Left;
    Result.Y := R.Bottom;
  end
  else
    Result := Preview.ClientOrigin;
end;

procedure TdxRibbonPrintPreviewForm.EnableItemsWhileBuilding(Value: Boolean);
var
  Items: TList;
  I, J: Integer;
begin
  Items := TList.Create;
  try
    for I := 0 to dxBarManager.Categories.Count - 1 do
    begin
      dxBarManager.GetItemsByCategory(I, Items);
      for J := 0 to Items.Count - 1 do
        TdxBarItem(Items[J]).Enabled := Value;
    end;
  finally
    Items.Free;
  end;
  bbFileExit.Enabled := True;
end;

procedure TdxRibbonPrintPreviewForm.ClearColorItemsSelection;
var
  I: Integer;
  AGroup: TdxRibbonGalleryGroup;
begin
  AGroup := rgiBackgroundColor.GalleryGroups.Items[0];
  for I := 0 to AGroup.Items.Count - 1 do
    AGroup.Items[I].Selected := False;
end;

procedure TdxRibbonPrintPreviewForm.DoGalleryColorItemClick(Sender: TObject);
begin
  if Sender is TdxRibbonGalleryGroupItem then
    DoSelectBackgroundColor(TdxRibbonGalleryGroupItem(Sender).Tag);
end;

procedure TdxRibbonPrintPreviewForm.DoPageSetupReport(APageIndex: Integer);
const
  BtnClicked: Boolean = False;
begin
  if not BtnClicked then
  begin
    BtnClicked := True;
    try
      Preview.DoPageSetupReport(APageIndex);
    finally
      BtnClicked := False;
    end;
  end;
end;

procedure TdxRibbonPrintPreviewForm.DoSelectBackgroundColor(AColor: TColor);
begin
  Preview.Background.BeginUpdate;
  try
    bbBackgroundNoFill.Down := False;
    Preview.Background.Mode := bmBrush;
    Preview.Background.Brush.Style := bsSolid;
    Preview.Background.Brush.Color := AColor;
    Preview.DoSyncPrintingPageBackground;
  finally
    Preview.Background.EndUpdate;
  end;
end;

procedure TdxRibbonPrintPreviewForm.DoShowExplorerPopup(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then 
    pmExplorer.PopupFromCursorPos;
end;

procedure TdxRibbonPrintPreviewForm.EnabledHFItems(Value: Boolean);
begin
  bbInsertHFPageNumber.Enabled := Value;
  bbInsertHFTotalPages.Enabled := Value;
  bbInsertHFPageOfPages.Enabled := Value;
  bbInsertHFDate.Enabled := Value;
  bbInsertHFTime.Enabled := Value;
  bbInsertHFDateTime.Enabled := Value;
  bbInsertHFUserName.Enabled := Value;
  bbInsertHFMachineName.Enabled := Value;
  bbViewHFClose.Enabled := Value;
  bbViewSwitchToLeftPart.Enabled := Value;
  bbViewSwitchToCenterPart.Enabled := Value;
  bbViewSwitchToRightPart.Enabled := Value;
  bbFormatHFClear.Enabled := Value;
  
  bliInsertAutoTextEntries.Enabled := Value;
  bbFormatHFBackground.Enabled := Value;
end;

procedure TdxRibbonPrintPreviewForm.UpdateHFState(Value: Boolean);
const
  StateMap: array[Boolean] of TdxPSPreviewState = (prsEditHeaders, prsEditFooters);
begin
  EnabledHFItems(Value);
  Preview.ZoomOnClick := not Value;
  if Value then
    Preview.State := StateMap[dxRibbon.ActiveTab = rtFooter]
  else
    Preview.State := prsNone;
end;

procedure TdxRibbonPrintPreviewForm.TimerHintTimer(Sender: TObject);
begin
  bbFilePrint.Hint := cxGetResourceString(@sdxHintFilePrint) + GetCurrentPrinterAsHint;
  TTimer(Sender).Enabled := False;
end;

procedure TdxRibbonPrintPreviewForm.bbExportToPDFClick(Sender: TObject);
begin
  dxPSExportToPDF(ReportLink);
end;

procedure TdxRibbonPrintPreviewForm.dxRibbonHelpButtonClick(Sender: TdxCustomRibbon);
begin
  HelpClick(Sender);
end;

procedure TdxRibbonPrintPreviewForm.PreviewInitContent(Sender: TObject);
begin
  InitContent;
end;

procedure TdxRibbonPrintPreviewForm.PreviewLoadProperties(
  Sender: TObject; AIniFile: TCustomIniFile; const ASectionName: string);
begin
  LoadBarManager(AIniFile, ASectionName);
end;

procedure TdxRibbonPrintPreviewForm.PreviewCanShowMarginHint(
  Sender: TObject; var AAllow: Boolean);
begin
  AAllow := ActiveBarControl = nil;
end;

procedure TdxRibbonPrintPreviewForm.PreviewAddExplorerCommand(
  Sender: TObject; ACommand: TCustomdxPSExplorerContextCommand);
begin
  AddExplorerContextCommand(ACommand);
end;

procedure TdxRibbonPrintPreviewForm.PreviewAfterPrintReport(
  Sender: TObject; AShowDialog: Boolean);
begin
  DoAfterPrintReport(AShowDialog);
end;

procedure TdxRibbonPrintPreviewForm.PreviewPreviewDblClick(Sender: TObject);
begin
  DoShowHFToolBar(False);
end;
          
procedure TdxRibbonPrintPreviewForm.PreviewZoomFactorChanged(Sender: TObject);
begin
  cbxPredefinedZoom.Text := AddPercentageChar(IntToStr(ZoomFactor));
end;

procedure TdxRibbonPrintPreviewForm.PreviewZoomModeChanged(Sender: TObject);
begin
  cbxPredefinedZoom.Text := AddPercentageChar(IntToStr(ZoomFactor));
end;

procedure TdxRibbonPrintPreviewForm.PreviewHFToolBarVisibleChanged(
  Sender: TObject; AShow: Boolean);
begin
  DoShowHFToolBar(AShow);
end;

procedure TdxRibbonPrintPreviewForm.PreviewSaveProperties(
  Sender: TObject; AIniFile: TCustomIniFile; const ASectionName: string);
begin
  SaveBarManager(AIniFile, ASectionName);
end;

procedure TdxRibbonPrintPreviewForm.PreviewStyleListChanged(Sender: TObject);
begin
  ReportLink.BuildPageSetupMenu(bliPrintStyles, bbDefinePrintStyles, True);
end;

procedure TdxRibbonPrintPreviewForm.PreviewHFTextEntriesChanged(Sender: TObject);
begin
  if Preview.IsAutoHFTextEntriesAvailable then
    ReportLink.StyleManager.BuildAutoHFTextEntriesMenu(
      bliInsertAutoTextEntries, bbInsertEditAutoText, True);
end;

procedure TdxRibbonPrintPreviewForm.PreviewUpdateExplorerCommands(Sender: TObject);
begin
  UpdateExplorerContextCommands;
end;

procedure TdxRibbonPrintPreviewForm.PreviewCreationComplete(Sender: TObject);
begin
  LoadBarManagerDefaults;
  LoadStrings;
end;

procedure TdxRibbonPrintPreviewForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := Preview.CanClosePreviewWindow;
end;

procedure TdxRibbonPrintPreviewForm.PreviewUpdateControls(Sender: TObject);
begin
  UpdateControls;
end;

procedure TdxRibbonPrintPreviewForm.bbClosePreviewClick(Sender: TObject);
begin
  Close;
end;

procedure TdxRibbonPrintPreviewForm.bbExplorerClick(Sender: TObject);
begin
  if not Locked then
    Preview.DoExplorerShowToggled(TdxBarLargeButton(Sender).Down);
end;

procedure TdxRibbonPrintPreviewForm.bbThumbnailsClick(Sender: TObject);
begin
  if not Locked then
    Preview.DoThumbnailsToggleShow(TdxBarLargeButton(Sender).Down);
end;

procedure TdxRibbonPrintPreviewForm.bbHeaderAndFooterClick(Sender: TObject);
begin
  if not Locked then
    Preview.DoShowHFToolBar(TdxBarLargeButton(Sender).Down);
end;

procedure TdxRibbonPrintPreviewForm.bbCloseHeaderAndFooterClick(Sender: TObject);
begin
  Preview.DoShowHFToolBar(False);
end;

procedure TdxRibbonPrintPreviewForm.bbBarExplorerCloseClick(Sender: TObject);
begin
  Preview.DoExplorerShowToggled(False);
end;

procedure TdxRibbonPrintPreviewForm.dxRibbonTabChanged(Sender: TdxCustomRibbon);
begin
  if HeaderAndFooterContextVisible then
  begin
    if dxRibbon.ActiveTab = rtFooter then
      Preview.State := prsEditFooters
    else
      Preview.State := prsEditHeaders
  end;
end;

procedure TdxRibbonPrintPreviewForm.bbPageSetupClick(Sender: TObject);
begin
  DoPageSetupReport(2);
end;

procedure TdxRibbonPrintPreviewForm.bbBackgroundNoFillClick(Sender: TObject);
begin
  ClearColorItemsSelection;
  Preview.Background.Clear;
  Preview.DoSyncPrintingPageBackground;
  bbBackgroundNoFill.Down := True;
end;

procedure TdxRibbonPrintPreviewForm.bbBackgroundMoreColorsClick(Sender: TObject);
begin
  with TColorDialog.Create(nil) do
  try
    Color := Preview.Background.Brush.Color;
    if Execute then
    begin
      DoSelectBackgroundColor(Color);
      ClearColorItemsSelection;
    end;
  finally
    Free;
  end;
end;

procedure TdxRibbonPrintPreviewForm.bbBackgroundFillEffectsClick(Sender: TObject);
begin
  if Preview.Background.SetupEffects then
  begin
    bbBackgroundNoFill.Down := False;
    Preview.DoSyncPrintingPageBackground;
    ClearColorItemsSelection;
  end;
end;

{ TdxPSRibbonPreviewDialogStyleInfo }

class function TdxPSRibbonPreviewDialogStyleInfo.CreatePreviewForm: TdxRibbonPrintPreviewForm;
begin
  Result := TdxRibbonPrintPreviewForm.Create(nil);
end;

class function TdxPSRibbonPreviewDialogStyleInfo.CreatePreviewWindow: TdxPSCustomPreviewWindow;
begin
  Result := CreatePreviewForm.Preview;
end;

class function TdxPSRibbonPreviewDialogStyleInfo.GetName: string;
begin
  Result := 'Ribbon';
end;

{ TdxPSRibbon2010PreviewDialogStyleInfo }

{$IFDEF EXPRESSBARS7}

class function TdxPSRibbon2010PreviewDialogStyleInfo.CreatePreviewForm: TdxRibbonPrintPreviewForm;
begin
  Result := inherited CreatePreviewForm;
  Result.dxRibbon.Style := rs2010;
end;

class function TdxPSRibbon2010PreviewDialogStyleInfo.GetName: string;
begin
  Result := 'Ribbon2010';
end;

{$ENDIF}
initialization
  dxPSPopupMenuController.RegisterBuilder(TdxRibbonPSPopupMenuBuilder);
  dxPSAutoHFTextMenuBuilderFactory.RegisterBuilder(TdxRibbonPSAutoHFTextMenuBuilder);
  dxPSPageSetupMenuBuilderFactory.RegisterBuilder(TdxRibbonPSPageSetupMenuBuilder);
  dxPSPreviewDialogManager.RegisterPreviewDialog(TdxPSRibbonPreviewDialogStyleInfo);
{$IFDEF EXPRESSBARS7}
  dxPSPreviewDialogManager.RegisterPreviewDialog(TdxPSRibbon2010PreviewDialogStyleInfo);
{$ENDIF}
  dxPSGlbl.PSCanShowHintFunc := dxBar_DoesNotHaveActivePopup;

finalization
  dxPSGlbl.PSCanShowHintFunc := nil;
{$IFDEF EXPRESSBARS7}
  dxPSPreviewDialogManager.UnregisterPreviewDialog(TdxPSRibbon2010PreviewDialogStyleInfo);
{$ENDIF}
  dxPSPreviewDialogManager.UnregisterPreviewDialog(TdxPSRibbonPreviewDialogStyleInfo);
  dxPSPageSetupMenuBuilderFactory.UnregisterBuilder(TdxRibbonPSPageSetupMenuBuilder);
  dxPSAutoHFTextMenuBuilderFactory.UnregisterBuilder(TdxRibbonPSAutoHFTextMenuBuilder);
  dxPSPopupMenuController.UnregisterBuilder(TdxRibbonPSPopupMenuBuilder);
  
end.


