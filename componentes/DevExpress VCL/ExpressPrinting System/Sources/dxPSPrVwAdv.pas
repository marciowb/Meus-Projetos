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

unit dxPSPrVwAdv;

interface
                
{$I cxVer.inc}

uses
  Windows, SysUtils, Classes, Messages, Graphics, Controls, ComCtrls, StdCtrls, 
  ExtCtrls, Forms, Menus, ImgList, dxPSCore, dxPSESys, dxPrevw, dxPSPrvw, dxBar, 
  dxBarPopupMenuEd, dxBarExtItems, cxClasses;

type
  TdxfmPreviewWdxBar = class(TCustomdxPSPreviewWindow)
    dxBarManager: TdxBarManager;
    bbFile: TdxBarSubItem;
    bbToolsOptions: TdxBarButton;
    bbFileDesign: TdxBarButton;
    bbFilePrint: TdxBarButton;
    bbFilePrintDialog: TdxBarButton;
    bbView: TdxBarSubItem;
    bbZoomPercent100: TdxBarButton;
    bbZoomPageWidth: TdxBarButton;
    bbZoomWholePage: TdxBarButton;
    bbZoomTwoPages: TdxBarButton;
    bbGoToPage: TdxBarSubItem;
    bbGoToFirstPage: TdxBarButton;
    bbGoToPrevPage: TdxBarButton;
    bbGoToNextPage: TdxBarButton;
    bbGoToLastPage: TdxBarButton;
    bbHelp: TdxBarSubItem;
    bbHelpTopics: TdxBarButton;
    bbZoomFourPages: TdxBarButton;
    ilToolBar: TImageList;
    bbZoomWidenToSourceWidth: TdxBarButton;
    seActivePage: TdxBarSpinEdit;
    pmPreview: TdxBarPopupMenu;
    bbViewToolbars: TdxBarToolbarsListItem;
    bbZoomMultiplePages: TdxBarButton;
    cbxPredefinedZoom: TdxBarImageCombo;
    bbZoomSetup: TdxBarButton;
    bbFileExit: TdxBarButton;
    bbFormatShrinkToPageWidth: TdxBarButton;
    bbViewMargins: TdxBarButton;
    bbViewMarginBar: TdxBarButton;
    bbViewStatusBar: TdxBarButton;
    bsiShortcutPreview: TdxBarSubItem;
    bsiInsertHFAutoText: TdxBarSubItem;
    bbInsertHFPageNumber: TdxBarButton;
    bbInsertHFTotalPages: TdxBarButton;
    bbInsertHFPageOfPages: TdxBarButton;
    bbInsertHFDate: TdxBarButton;
    bbInsertHFTime: TdxBarButton;
    bbInsertHFDateTime: TdxBarButton;
    bbViewHFSwitchHeaderFooter: TdxBarButton;
    bbInsertHFUserName: TdxBarButton;
    bbInsertHFMachineName: TdxBarButton;
    bbViewHFClose: TdxBarButton;
    bbFormatHeaderAndFooter: TdxBarButton;
    bbViewSwitchToLeftPart: TdxBarButton;
    bbViewSwitchToCenterPart: TdxBarButton;
    bbViewSwitchToRightPart: TdxBarButton;
    bbFormatHFClear: TdxBarButton;
    bbFormat: TdxBarSubItem;
    bbEdit: TdxBarSubItem;
    bbFilePageSetup: TdxBarButton;
    bliInsertAutoTextEntries: TdxBarListItem;
    bbInsertEditAutoText: TdxBarButton;
    bbFormatHFBackground: TdxBarButton;
    bbFormatDateTime: TdxBarButton;
    bbFormatPageNumbering: TdxBarButton;
    bbEditFind: TdxBarButton;
    bbEditFindNext: TdxBarButton;
    bbEditReplace: TdxBarButton;
    bbViewPageHeaders: TdxBarButton;
    bbViewPageFooters: TdxBarButton;
    bbViewPages: TdxBarSubItem;
    bbFormatPageBackground: TdxBarButton;
    bbViewZoom: TdxBarSubItem;
    bbToolsCustomize: TdxBarButton;
    bbTools: TdxBarSubItem;
    bbHelpAbout: TdxBarButton;
    bbInsert: TdxBarSubItem;
    bbFormatShowHideEmptyPages: TdxBarButton;
    bsiNewMenuNewMenu: TdxBarSubItem;
    pmPrintStyles: TdxBarPopupMenu;
    bliPrintStyles: TdxBarListItem;
    bbDefinePrintStyles: TdxBarButton;
    bsiInsertAutoText: TdxBarSubItem;
    TimerHint: TTimer;
    bbFileLoad: TdxBarButton;
    bbExplorerCreateNewFolder: TdxBarButton;
    bbExplorerDelete: TdxBarButton;
    bbExplorerRename: TdxBarButton;
    bbExplorer: TdxBarSubItem;
    bbFileSave: TdxBarButton;
    bbViewExplorer: TdxBarButton;
    pmExplorer: TdxBarPopupMenu;
    bsiShortCutExplorer: TdxBarSubItem;
    bbFileClose: TdxBarButton;
    bbFormatTitle: TdxBarButton;
    pmThumbnails: TdxBarPopupMenu;
    bbViewThumbnails: TdxBarButton;
    bbThumbnailsSmall: TdxBarButton;
    bbThumbnailsLarge: TdxBarButton;
    bsiShortcutThumbnails: TdxBarSubItem;
    bbExplorerProperties: TdxBarButton;
    bbFileRebuild: TdxBarButton;
    procedure PageSetupClick(Sender: TObject);
    procedure ZoomClick(Sender: TObject);
    procedure GoToPageClick(Sender: TObject);
    procedure CloseClick(Sender: TObject);
    procedure DesignClick(Sender: TObject);
    procedure PageBackgroundClick(Sender: TObject);
    procedure bbViewMarginsClick(Sender: TObject);
    procedure HelpClick(Sender: TObject);
    procedure bbViewMarginBarClick(Sender: TObject);
    procedure bbViewStatusBarClick(Sender: TObject);
    procedure seActivePageChange(Sender: TObject);
    procedure cbxPredefinedZoomChange(Sender: TObject);
    procedure seActivePageButtonClick(Sender: TdxBarSpinEdit;
      Button: TdxBarSpinEditButton);
    procedure bbZoomMultiplePagesClick(Sender: TObject);
    procedure bbZoomSetupClick(Sender: TObject);
    procedure cbxPredefinedZoomClick(Sender: TObject);
    procedure bbFormatShrinkToPageWidthClick(Sender: TObject);
    procedure miCustomizePopupClick(Sender: TObject);
    procedure dxBarManagerBarVisibleChange(Sender: TdxBarManager; ABar: TdxBar);
    procedure bbViewHFCloseClick(Sender: TObject);
    procedure bbFormatHeaderAndFooterClick(Sender: TObject);
    procedure InsertHFClick(Sender: TObject);
    procedure bbViewHFSwitchHeaderFooterClick(Sender: TObject);
    procedure bbFormatDateTimeClick(Sender: TObject);
    procedure SwitchPartClick(Sender: TObject);
    procedure bbFormatHFClearClick(Sender: TObject);
    procedure bbFormatHFBackgroundClick(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure bbFormatPageNumbersClick(Sender: TObject);
    procedure bbViewPageHeadersClick(Sender: TObject);
    procedure bbViewPageFootersClick(Sender: TObject);
    procedure bbToolsCustomizeClick(Sender: TObject);
    procedure dxBarManagerShowCustomizingForm(Sender: TObject);
    procedure dxBarManagerHideCustomizingForm(Sender: TObject);
    procedure bbFormatShowHideEmptyPagesClick(Sender: TObject);
    procedure bbToolsOptionsClick(Sender: TObject);
    procedure TimerHintTimer(Sender: TObject);
    procedure FileSaveClick(Sender: TObject);
    procedure ExplorerLoadDataClick(Sender: TObject);
    procedure ExplorerCreateNewFolderClick(Sender: TObject);
    procedure ExplorerDeleteItemClick(Sender: TObject);
    procedure ExplorerRenameItemClick(Sender: TObject);
    procedure bbViewExplorerClick(Sender: TObject);
    procedure pmExplorerPopup(Sender: TObject);
    procedure bbFileCloseClick(Sender: TObject);
    procedure bbFormatTitleClick(Sender: TObject);
    procedure bbThumbnailsSizeClick(Sender: TObject);
    procedure bbViewThumbnailsClick(Sender: TObject);
    procedure bbExplorerPropertiesClick(Sender: TObject);
    procedure bbFileRebuildClick(Sender: TObject);
  private
    FExplorerContextCommands: TList;
    function GetExplorerContextCommand(Index: Integer): TCustomdxPSExplorerContextCommand;
    function GetExplorerContextCommandCount: Integer;

    function CalcWindowPos(Sender: TObject): TPoint;
    procedure DoShowExplorerPopup(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure EnableItemsWhileBuilding(Value: Boolean);
    procedure PostCreateFolderMessage;
    procedure SetBarItemVisibility(Item: TdxBarItem; Value: Boolean);

    function ShortcutBar: TdxBar;
    procedure ShowShortCutBar(Value: Boolean);

    procedure EnabledHFItems(Value: Boolean);
    function HFBar: TdxBar;
    procedure ShowHFBar(Value: Boolean);
    procedure UpdateHFState(Value: Boolean);

    procedure LoadBarManagerFromRegistry(const APath: string);
    procedure SaveBarManagerToRegistry(const APath: string);
  protected
    procedure Activate; override;
    procedure WndProc(var Message: TMessage); override;

    procedure AddExplorerContextCommand(ACommand: TCustomdxPSExplorerContextCommand); override;
    procedure ExplorerContextCommandClick(Sender: TObject); virtual;
    procedure UpdateExplorerContextCommands; override;

    procedure DoAfterPrintReport(AShowDialog: Boolean); override;
    procedure DoPreviewDblClick(APreview: TdxPreview); override;
    procedure DoPreviewZoomFactorChanged(APreview: TdxPreview); override;
    procedure DoPreviewZoomModeChanged(APreview: TdxPreview); override;
    procedure DoShowHFToolBar(Value: Boolean); override;
    function GetPreviewCanShowMarginHint(APreview: TdxPreview): Boolean; override;
    procedure HFTextEntriesChanged; override;
    procedure LoadStrings; override;
    procedure StyleListChanged(Sender: TObject); override;

    property ExplorerContextCommandCount: Integer read GetExplorerContextCommandCount;
    property ExplorerContextCommands[Index: Integer]: TCustomdxPSExplorerContextCommand read GetExplorerContextCommand;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AfterConstruction; override;

    procedure InitContent; override;
    procedure LoadFromRegistry(const APath: string); override;
    procedure SaveToRegistry(const APath: string); override;
    procedure UpdateControls; override;
  end;

implementation

{$R *.DFM}

uses                                                             
{$IFDEF EXPRESSBARS5}
  cxLookAndFeels, dxThemeManager,
{$ENDIF}
  Registry, CommCtrl, Math,
  dxMessages, dxPSRes, dxPrnPg, dxPSGlbl, dxPSPopupMan,
  dxPSUtl, dxPSPgsMnuBld, dxPSEngn, dxPgsDlg, dxPSEvnt, dxPSAutoHFTextMnuBld,
  dxPSfmAutoHFTextFmt, dxPrnDev;

const
  PageSelectorImageIndex = 35;

  sdxToolBars = '\ToolBars';                           // Don't Localize
  
type
  TWinControlAccess = class(TWinControl);
  
  TdxBarPSPopupMenuBuilder = class(TAbstractdxPSPopupMenuBuilder)
  private
    FBarHostForm: TCustomForm;
    FBarManager: TdxBarManager;
  protected
    function BuildPopup(const AControl: TControl; 
      const APopupMenu: TPopupMenu): TComponent; override;
    class function CanShowPopup(const APopupMenu: TPopupMenu): Boolean; override;
    procedure FreePopup(var APopupMenu: TComponent); override;
    procedure InvokePopup(const X, Y: Integer; const AControl: TControl; 
      const APopupMenu: TComponent); override;
    class function RequireProcessDoPopup: Boolean; override;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

  TdxBarPSPageSetupMenuBuilder = class(TAbstractdxPSPageSetupMenuBuilder)
  public   
    procedure BuildPageSetupMenu(ARootItem: TObject; AData: Pointer; 
      AIncludeDefineItem: Boolean; AStyles: TStringList; ACurrentStyle: TBasedxPrintStyle;
      AOnStyleClick, AOnDefineStylesClick: TNotifyEvent); override;
    class function ExtractPrintStyleFromObj(Obj: TObject): TBasedxPrintStyle; override;
  end;

  TdxBarPSAutoHFTextMenuBuilder = class(TAbstractdxPSAutoHFTextMenuBuilder)
  public    
    procedure BuildAutoHFTextEntriesMenu(ARootItem: TObject; AData: Pointer; 
      AIncludeSetupAutoHFTextEntriesItem: Boolean; AAutoHFTextEntries: TStrings;
      AOnHFTextEntriesClick, AOnSetupHFTextEntriesClick: TNotifyEvent); override;
    class function ExtractAutoHFTextEntryIndexFromObj(Obj: TObject): Integer; override;
  end;
  
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
{$IFDEF EXPRESSBARS5}
  BarManagerStyleMap: array[dxPSGlbl.TdxPSLookAndFeel] of dxBar.TdxBarManagerStyle = 
    (dxBar.bmsEnhanced, dxBar.bmsFlat, dxBar.bmsXP, dxBar.bmsOffice11);
{$ELSE}
  BarManagerStyleMap: array[dxPSGlbl.TdxPSLookAndFeel] of dxBar.TdxBarManagerStyle = 
    (dxBar.bmsEnhanced, dxBar.bmsFlat, dxBar.bmsFlat, dxBar.bmsFlat);
{$ENDIF}
begin
  with dxPSEngine do 
 {$IFDEF EXPRESSBARS5}
    if UseNativeLookAndFeel and dxThemeManager.AreVisualStylesAvailable then 
    begin
      ABarManager.Style := dxBar.bmsUseLookAndFeel;
      ABarManager.LookAndFeel.NativeStyle := True;
    end
    else
      ABarManager.Style := BarManagerStyleMap[LookAndFeel];  
 {$ElSE}
   ABarManager.Style := BarManagerStyleMap[LookAndFeel]; 
 {$ENDIF}     
end;

{ TdxBarPSPopupMenuBuilder }  

constructor TdxBarPSPopupMenuBuilder.Create;
begin
  inherited;
  FBarHostForm := TCustomForm.CreateNew(nil);
  FBarManager := TdxBarManager.Create(FBarHostForm);
  SetupBarManagerStyle(FBarManager);
end;
     
destructor TdxBarPSPopupMenuBuilder.Destroy;
begin
  FBarHostForm.Free;
  inherited;
end;

class function TdxBarPSPopupMenuBuilder.CanShowPopup(const APopupMenu: TPopupMenu): Boolean;
begin
  Result := inherited CanShowPopup(APopupMenu) and  dxBar_DoesNotHaveActivePopup;
end;

function TdxBarPSPopupMenuBuilder.BuildPopup(const AControl: TControl; 
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

procedure TdxBarPSPopupMenuBuilder.FreePopup(var APopupMenu: TComponent);
var
  I: Integer;
begin
  for I := 0 to FBarManager.ItemCount - 1 do
    FBarManager.Items[I].Free;
  FreeAndNil(APopupMenu);
end;

procedure TdxBarPSPopupMenuBuilder.InvokePopup(const X, Y: Integer;
  const AControl: TControl; const APopupMenu: TComponent);
begin
  if APopupMenu is TdxBarPopupMenu then
    TdxBarPopupMenu(APopupMenu).Popup(X, Y);
end;

class function TdxBarPSPopupMenuBuilder.RequireProcessDoPopup: Boolean;
begin
  Result := True;
end;

{ TdxBarPSPageSetupMenuBuilder } 

class function TdxBarPSPageSetupMenuBuilder.ExtractPrintStyleFromObj(Obj: TObject): TBasedxPrintStyle;
begin
  with TdxBarListItem(Obj) do 
    Result := TBasedxPrintStyle(Items.Objects[ItemIndex]);
end;

procedure TdxBarPSPageSetupMenuBuilder.BuildPageSetupMenu(ARootItem: TObject; 
  AData: Pointer; AIncludeDefineItem: Boolean; 
  AStyles: TStringList; ACurrentStyle: TBasedxPrintStyle; 
  AOnStyleClick, AOnDefineStylesClick: TNotifyEvent);
begin
  if not (ARootItem is TdxBarListItem) then Exit;
    
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

{ TdxBarPSAutoHFTextMenuBuilder }

procedure TdxBarPSAutoHFTextMenuBuilder.BuildAutoHFTextEntriesMenu(ARootItem: TObject; 
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

class function TdxBarPSAutoHFTextMenuBuilder.ExtractAutoHFTextEntryIndexFromObj(Obj: TObject): Integer;
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

procedure ProcessMessages;
begin
  //Application.ProcessMessages;
end;
  
{ TdxfmPreviewWdxBar }

constructor TdxfmPreviewWdxBar.Create(AOwner: TComponent);
begin
  inherited;
  FExplorerContextCommands := TList.Create;
  SetupBarManagerStyle(dxBarManager);
end;

destructor TdxfmPreviewWdxBar.Destroy;
begin
  FreeAndNil(FExplorerContextCommands);
  inherited;
end;

procedure TdxfmPreviewWdxBar.AfterConstruction;
var
  Bar: TdxBar;
begin
  inherited;
  cbxPredefinedZoom.DropDownCount := PredefinedZooms.Count;
  seActivePage.Value := 1;
  
  ShowHFBar(False);
  Bar := ShortCutBar;
  if Bar <> nil then Bar.Hidden := True;

  dxBarManager.PopupMenuLinks[0].Control := Preview;
  dxBarManager.PopupMenuLinks[1].Control := ThumbnailsPreview;
end;

procedure TdxfmPreviewWdxBar.InitContent;

  procedure AddEndEllipsis(AnItem: TdxBarButton);
  begin
    with AnItem do                              
      if AnsiLastChar(Caption) <> '.' then Caption := dxPSUtl.AddEndEllipsis(Caption);
  end;

begin
  inherited;

  if ReportLink <> nil then
    seActivePage.MaxValue := ReportLink.PageCount;
  cbxPredefinedZoom.Text := IntToStr(ZoomFactor) + PercentSymbol;

  if IsExplorerAvailable then
    TWinControlAccess(ExplorerTree.Control).OnMouseUp := DoShowExplorerPopup; 

  if not IsExplorerAvailable then
  begin
    AddEndEllipsis(bbFileSave);
    AddEndEllipsis(bbFileLoad);
  end;  
end;
                                           
procedure TdxfmPreviewWdxBar.LoadFromRegistry(const APath: string);
begin
  inherited;
  LoadBarManagerFromRegistry(APath);
end;

procedure TdxfmPreviewWdxBar.SaveToRegistry(const APath: string);
begin
  inherited;
  SaveBarManagerToRegistry(APath);
end;

procedure TdxfmPreviewWdxBar.UpdateControls;
const
  ButtonStyles: array[Boolean] of TdxBarButtonStyle = (bsDefault, bsDropDown);
var
  Bar: TdxBar;
  PagesExists, B: Boolean;
  PageXCount, PageYCount, Index: Integer;
begin
  if Locked or (csDestroying in ComponentState) then Exit;
  
  inherited;
  
  PagesExists := FPreview.PageCount > 0;
  BeginUpdate;
  try
    EnableItemsWhileBuilding(True);
    
    bbFileDesign.Enabled := CanDesign;
    bbFileRebuild.Enabled := CanRebuild;
    bbFileSave.Enabled := CanSaveReport;
    bbFileLoad.Enabled := CanLoadReport;
    bbFileClose.Enabled := CanUnloadReport;
    bbFilePrint.Enabled := CanPrint;
    bbFilePrintDialog.Enabled := CanPrintDialog;
    bbFilePageSetup.Enabled := CanPageSetup;
    bbFilePageSetup.ButtonStyle := ButtonStyles[CanPrintStyle];    
    bbFileExit.Enabled := not IsPrinting;

    bbExplorer.Enabled := IsExplorerAvailable;
    bbExplorerCreateNewFolder.Enabled := IsExplorerAvailable and ExplorerTree.CanCreateFolder;
    bbExplorerDelete.Enabled := IsExplorerAvailable and ExplorerTree.CanDeleteSelection;
    bbExplorerRename.Enabled := IsExplorerAvailable and ExplorerTree.CanRenameSelectedItem;
    bbExplorerProperties.Enabled := IsExplorerAvailable and ExplorerTree.CanShowPropertySheetsForSelectedItem;
    
    bbFormatShowHideEmptyPages.Down := (ReportLink <> nil) and ReportLink.ShowEmptyPages;
    bbFormatTitle.Enabled := (ReportLink <> nil) and ReportLink.CanChangeTitle;
    bbFormatPageBackground.Enabled := IsEnabled(peoPageBackground) and not IsPrinting;
    bbFormatShrinkToPageWidth.Enabled := PagesExists and not IsPrinting;
    if ReportLink <> nil then
    begin
      bbFormatShrinkToPageWidth.Down := ReportLink.ShrinkToPageWidth;
      SetBarItemVisibility(bbFormatShowHideEmptyPages, ReportLink.EmptyPagesCanExist);
      bbFormatShowHideEmptyPages.Down := ReportLink.ShowEmptyPages;
    end;

    bbZoomPageWidth.Enabled := PagesExists;
    bbZoomPercent100.Enabled := PagesExists;
    bbZoomWholePage.Enabled := PagesExists;
    bbZoomTwoPages.Enabled := PagesExists and (FPreview.PageCount > 1);
    bbZoomFourPages.Enabled := PagesExists and (FPreview.PageCount > 3);
    bbZoomMultiplePages.Enabled := PagesExists;
    if ReportLink <> nil then
    begin
      ReportLink.GetPageColRowCount(PageXCount, PageYCount);
      bbZoomWidenToSourceWidth.Enabled := PageXCount > 1;
    end;
    cbxPredefinedZoom.Enabled := bbZoomPageWidth.Enabled;
    bbZoomSetup.Enabled := bbZoomPageWidth.Enabled;

    bbGoToFirstPage.Enabled := PagesExists and (FPreview.SelPageIndex <> 0);
    bbGoToPrevPage.Enabled := PagesExists and (Preview.SelPageIndex <> 0);
    bbGoToNextPage.Enabled := PagesExists and (Preview.SelPageIndex <> FPreview.PageCount - 1);
    bbGoToLastPage.Enabled := PagesExists and (Preview.SelPageIndex <> FPreview.PageCount - 1);
    seActivePage.Enabled := Preview.PageCount > 1;

    bbHelp.Enabled := IsEnabled(peoHelp);
    bbHelpTopics.Enabled := IsEnabled(peoHelp);
    //bbHelpAbout.Enabled := IsEnabled(peoHelp);

    bbViewMargins.Down := ShowPageMargins;
    bbViewMarginBar.Down := ShowMarginBar;
    bbViewStatusBar.Down := ShowStatusBar;
    SetBarItemVisibility(bbViewExplorer, IsExplorerAvailable);
    bbViewExplorer.Down := ShowExplorer;
    bbViewThumbnails.Down := ShowThumbnails;
    bbThumbnailsSmall.Down := ThumbnailsSize = tsSmall;
    bbThumbnailsLarge.Down := ThumbnailsSize = tsLarge;
    if ReportLink <> nil then
    begin
      bbViewPageHeaders.Down := ReportLink.ShowPageHeader;
      bbViewPageFooters.Down := ReportLink.ShowPageFooter;
    end;
   
    SetBarItemVisibility(bbFileDesign, IsVisible(pvoReportDesign));
    SetBarItemVisibility(bbFileSave, IsCommandSaveReportVisible);
    SetBarItemVisibility(bbFileLoad, IsCommandLoadReportVisible);
    SetBarItemVisibility(bbFileClose, IsCommandUnloadReportVisible);
    SetBarItemVisibility(bbFilePrint, IsVisible(pvoPrint));
    SetBarItemVisibility(bbFilePrintDialog, IsVisible(pvoPrint));
    SetBarItemVisibility(bbFilePageSetup, IsVisible(pvoPageSetup));
                         
    SetBarItemVisibility(bbExplorer, IsExplorerAvailable);
    SetBarItemVisibility(bbExplorerCreateNewFolder, IsExplorerAvailable);
    SetBarItemVisibility(bbExplorerDelete, IsExplorerAvailable);
    SetBarItemVisibility(bbExplorerRename, IsExplorerAvailable);
    SetBarItemVisibility(bbExplorerProperties, IsExplorerAvailable);
    SetBarItemVisibility(bsiShortcutExplorer, IsExplorerAvailable);

    B := (ReportLink <> nil) and (ReportLink.StyleManager <> nil);
    SetBarItemVisibility(bsiInsertHFAutoText, B);
    SetBarItemVisibility(bbInsertEditAutoText, B);
    SetBarItemVisibility(bsiInsertAutoText, B);
    SetBarItemVisibility(bliInsertAutoTextEntries, B);
    SetBarItemVisibility(bbFormatPageBackground, IsVisible(pvoPageBackground));
    SetBarItemVisibility(bbHelp, IsVisible(pvoHelp));
    SetBarItemVisibility(bbHelpTopics, IsVisible(pvoHelp));
    //SetBarItemVisibility(bbHelpAbout, IsVisible(pvoHelp));

    if seActivePage.Enabled then
    begin
      seActivePage.MinValue := 1;
      if ReportLink <> nil then
      begin
        seActivePage.MaxValue := ReportLink.PageCount;
        seActivePage.Value := ReportLink.VirtualPageIndexToRealPageIndex(FPreview.SelPageIndex) + 1;
      end
    end
    else
      seActivePage.Value := -1;
      
    if IsBuilding or IsPrinting then 
      EnableItemsWhileBuilding(False);
      
    if HFBar <> nil then 
      EnabledHFItems(HFBar.Visible);

    { Categories visibility }

    { Edit }
    Index := dxBarManager.Categories.IndexOf(DropAmpersand(cxGetResourceString(@sdxMenuEdit)));
    if Index <> -1 then
      dxBarManager.CategoryVisible[Index] := False;
      
    { Help }
    Index := dxBarManager.Categories.IndexOf(DropAmpersand(cxGetResourceString(@sdxMenuHelp)));
    if Index <> -1 then
      dxBarManager.CategoryVisible[Index] := 
        (bbHelpTopics.Visible = ivAlways) or (bbHelpAbout.Visible = ivAlways);
        
    { Shortcut Menus }
    Index := dxBarManager.Categories.IndexOf(DropAmpersand(cxGetResourceString(@sdxMenuShortCutMenus)));
    if Index <> -1 then
      dxBarManager.CategoryVisible[Index] := False;
      
    { Explorer }
    Index := dxBarManager.Categories.IndexOf(DropAmpersand(cxGetResourceString(@sdxMenuExplorer)));
    if Index <> -1 then
      dxBarManager.CategoryVisible[Index] := IsExplorerAvailable;
      
    { AutoText }                 
    Bar := dxBarManager.BarByCaption(cxGetResourceString(@sdxAutoTextBar));
    if Bar <> nil then 
      Bar.Hidden := not IsAutoHFTextEntriesAvailable;

    { Explorer } 
    Bar := dxBarManager.BarByCaption(cxGetResourceString(@sdxExplorerToolBar));
    if Bar <> nil then 
      Bar.Hidden := not IsExplorerAvailable;

    UpdateExplorerContextCommands;
  finally
    CancelUpdate;
  end;
end;

procedure TdxfmPreviewWdxBar.bbViewMarginsClick(Sender: TObject);
begin
  if Locked then Exit;
  ShowPageMargins := TdxBarButton(Sender).Down;
end;

procedure TdxfmPreviewWdxBar.bbViewMarginBarClick(Sender: TObject);
begin
  if Locked then Exit;
  ShowMarginBar := TdxBarButton(Sender).Down;
end;

procedure TdxfmPreviewWdxBar.bbViewStatusBarClick(Sender: TObject);
begin
  if Locked then Exit;
  ShowStatusBar := TdxBarButton(Sender).Down;
end;

procedure TdxfmPreviewWdxBar.bbViewExplorerClick(Sender: TObject);
begin
  if Locked then Exit;
  ShowExplorer := TdxBarButton(Sender).Down;
end;

procedure TdxfmPreviewWdxBar.pmExplorerPopup(Sender: TObject);
begin
  UpdateControls;
end;

procedure TdxfmPreviewWdxBar.bbThumbnailsSizeClick(Sender: TObject);
begin
  ThumbnailsSize := TdxPSThumbnailsSize(TTagToInt(TComponent(Sender).Tag));
end;

procedure TdxfmPreviewWdxBar.bbViewThumbnailsClick(Sender: TObject);
begin
  if Locked then Exit;
  ShowThumbnails := TdxBarButton(Sender).Down;
end;

procedure TdxfmPreviewWdxBar.DesignClick(Sender: TObject);
begin
  DoDesignReport;
end;

procedure TdxfmPreviewWdxBar.bbFileRebuildClick(Sender: TObject);
begin
  if CanRebuild then RebuildReport;
end;

procedure TdxfmPreviewWdxBar.PrintClick(Sender: TObject);
const
  BtnClicked: Boolean = False;
begin
  if BtnClicked then Exit;
  ProcessMessages;
  BtnClicked := True;
  try
    DoPrintReport(Boolean(TTagToInt(TComponent(Sender).Tag)));
  finally
    BtnClicked := False;
  end;
end;

procedure TdxfmPreviewWdxBar.PageSetupClick(Sender: TObject);
const
  BtnClicked: Boolean = False;
begin
  if BtnClicked then Exit;
  ProcessMessages;
  BtnClicked := True;
  try
    DoPageSetupReport(0);
  finally
    BtnClicked := False;
  end;
end;

procedure TdxfmPreviewWdxBar.FileSaveClick(Sender: TObject);
begin
  DoExplorerCreateNewItem;
end;

procedure TdxfmPreviewWdxBar.ExplorerLoadDataClick(Sender: TObject);
begin
  ProcessMessages;
  DoExplorerLoadItemData;
end;

procedure TdxfmPreviewWdxBar.bbFileCloseClick(Sender: TObject);
begin
  ProcessMessages;
  DoExplorerUnloadItemData;
end;

procedure TdxfmPreviewWdxBar.ExplorerCreateNewFolderClick(Sender: TObject);
begin
  ExplorerTree.FocusedItem := ExplorerTree.SelectedItem;
  PostCreateFolderMessage;
end;

procedure TdxfmPreviewWdxBar.PostCreateFolderMessage;
begin
  PostMessage(Handle, DXM_PS_CREATEFOLDER, 0, 0);
end;

procedure TdxfmPreviewWdxBar.ExplorerDeleteItemClick(Sender: TObject);
begin
  ProcessMessages;
  DoExplorerDeleteItem;
end;

procedure TdxfmPreviewWdxBar.ExplorerRenameItemClick(Sender: TObject);
begin
  ProcessMessages;
  DoExplorerRenameItem;
end;

procedure TdxfmPreviewWdxBar.bbExplorerPropertiesClick(
  Sender: TObject);
begin
  DoExplorerItemShowPropertySheets;
end;

procedure TdxfmPreviewWdxBar.PageBackgroundClick(Sender: TObject);
begin
  ProcessMessages;
  DoShowPageBackgroundDlg(CalcWindowPos(Sender));
end;

procedure TdxfmPreviewWdxBar.bbFormatShrinkToPageWidthClick(Sender: TObject);
begin
  if ReportLink <> nil then
  begin
    ReportLink.ShrinkToPageWidth := not ReportLink.ShrinkToPageWidth;
    DoShrinkToPageWidth(ReportLink.ShrinkToPageWidth);
  end;
end;

procedure TdxfmPreviewWdxBar.bbFormatShowHideEmptyPagesClick(Sender: TObject);
begin
  if Locked then Exit;
  DoShowEmptyPages(TdxBarButton(Sender).Down);
end;

procedure TdxfmPreviewWdxBar.bbZoomSetupClick(Sender: TObject);
begin
  ProcessMessages;
  DoShowZoomDlg;
end;

procedure TdxfmPreviewWdxBar.cbxPredefinedZoomClick(Sender: TObject);
begin
  ProcessMessages;
  DoShowZoomDlg;
end;

procedure TdxfmPreviewWdxBar.bbZoomMultiplePagesClick(Sender: TObject);
var
  Link: TdxBarItemLink;
  R: TRect;
  YShift: Integer;
begin
  Link := TdxBarItem(Sender).ClickItemLink;
  if (Link <> nil) and (Link.Control <> nil) then
  begin
    R := Link.ItemRect;
    MapWindowPoints(Link.BarControl.Handle, 0, R, 2);
    YShift := R.Bottom - R.Top;
  end
  else
  begin
    GetWindowRect(Preview.Handle, R);
    OffsetRect(R, 3, 0);
    YShift := 3;
  end;
  DoShowMultiplySelectPagesDlg(ilToolBar, PageSelectorImageIndex, R.TopLeft, YShift);
end;

procedure TdxfmPreviewWdxBar.GoToPageClick(Sender: TObject);
begin
  case TTagToInt(TComponent(Sender).Tag) of
    0: GoToFirstPage;
    1: GoToPrevPage;
    2: GoToNextPage;
    3: GoToLastPage;
  end;
end;

procedure TdxfmPreviewWdxBar.CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TdxfmPreviewWdxBar.HelpClick(Sender: TObject);
begin
  ProcessMessages;
  DoInvokeHelp;
end;

procedure TdxfmPreviewWdxBar.Activate;
begin
  inherited;
  TimerHint.Enabled := True;
end;

procedure TdxfmPreviewWdxBar.WndProc(var Message: TMessage);
begin
  if Message.Msg = DXM_PS_CREATEFOLDER then
  begin
    ExplorerTree.SelectedItem := ExplorerTree.FocusedItem;
    DoExplorerCreateNewFolder;
  end
  else
    inherited;
end;

procedure TdxfmPreviewWdxBar.AddExplorerContextCommand(ACommand: TCustomdxPSExplorerContextCommand);

  procedure AddBarControl(AnItemLinks: TdxBarItemLinks; ABarButton: TdxBarButton);
  begin
    with AnItemLinks.Add do 
    begin
      Item := ABarButton;
      Index := 0;
      BringToTopInRecentList(True);
    end;
  end;
  
  procedure BeginGroup(AnItemLinks: TdxBarItemLinks);
  begin
    if AnItemLinks.Count <> 0 then 
      AnItemLinks[0].BeginGroup := True;
  end;
  
var
  BarButton: TdxBarButton;
begin
  if ACommand is TdxPSExplorerContextCommandSeparator then
  begin
    BeginGroup(bbExplorer.ItemLinks);
    BeginGroup(dxBarManager.BarByCaption(cxGetResourceString(@sdxExplorerBar)).ItemLinks);
    BeginGroup(pmExplorer.ItemLinks);
  end
  else
  begin
    BarButton := TdxBarButton.Create(Self);
    with BarButton do
    begin
      Glyph := ACommand.Bitmap;
      Caption := ACommand.Caption;
      Enabled := ACommand.Enabled;
      Hint := ACommand.Hint;
      ShortCut := ACommand.ShortCut;
      Tag := MakeTTag(ACommand);

      Category := dxBarManager.Categories.IndexOf(DropAmpersand(cxGetResourceString(@sdxMenuExplorer)));
      OnClick := ExplorerContextCommandClick;
    end;  

    AddBarControl(bbExplorer.ItemLinks, BarButton);
    AddBarControl(dxBarManager.BarByCaption(cxGetResourceString(@sdxExplorerBar)).ItemLinks, BarButton);
    AddBarControl(pmExplorer.ItemLinks, BarButton);
    ACommand.Data := Integer(BarButton);

    if FExplorerContextCommands.IndexOf(ACommand) = -1 then
      FExplorerContextCommands.Add(ACommand);
  end;   
end;

procedure TdxfmPreviewWdxBar.ExplorerContextCommandClick(Sender: TObject);
var
  Command: TCustomdxPSExplorerContextCommand;
  CommandSet2: IdxPSExplorerContextCommands2;
begin
  Command := TCustomdxPSExplorerContextCommand(TTagToObj(TdxBarButton(Sender).Tag));
  if Supports(TObject(Explorer), IdxPSExplorerContextCommands2, CommandSet2) then
  begin
    CommandSet2.InitializeCommand(Command);
    try
      if Command.Enabled then Command.Execute; {.1}
    finally
      CommandSet2.FinalizeCommand(Command);
    end;
  end;  
  UpdateControls;
end;

procedure TdxfmPreviewWdxBar.UpdateExplorerContextCommands;
var
  I: Integer;
begin
  if not (csDestroying in ComponentState) then 
    for I := 0 to ExplorerContextCommandCount - 1 do
      with ExplorerContextCommands[I] do
        TdxBarButton(Data).Enabled := Enabled;
end;

procedure TdxfmPreviewWdxBar.DoAfterPrintReport(AShowDialog: Boolean);
begin
  if AShowDialog then
    bbFilePrint.Hint := cxGetResourceString(@sdxHintFilePrint) + GetCurrentPrinterAsHint;
end;

procedure TdxfmPreviewWdxBar.DoPreviewDblClick(APreview: TdxPreview);
begin
  ShowHFBar(False);
end;

procedure TdxfmPreviewWdxBar.DoPreviewZoomFactorChanged(APreview: TdxPreview);
begin
  cbxPredefinedZoom.Text := AddPercentageChar(IntToStr(ZoomFactor));
end;

procedure TdxfmPreviewWdxBar.DoPreviewZoomModeChanged(APreview: TdxPreview);
begin
  cbxPredefinedZoom.Text := AddPercentageChar(IntToStr(ZoomFactor));
end;

function TdxfmPreviewWdxBar.GetPreviewCanShowMarginHint(APreview: TdxPreview): Boolean;
begin
  Result := ActiveBarControl = nil;
end;

procedure TdxfmPreviewWdxBar.HFTextEntriesChanged;
begin
  if IsAutoHFTextEntriesAvailable then 
    ReportLink.StyleManager.BuildAutoHFTextEntriesMenu(bliInsertAutoTextEntries, bbInsertEditAutoText, True);
end;

procedure TdxfmPreviewWdxBar.LoadStrings;
begin
  inherited;
  with dxBarManager do
  begin
    Bars[0].Caption := cxGetResourceString(@sdxMenuBar);
    Bars[1].Caption := cxGetResourceString(@sdxStandardBar);
    Bars[2].Caption := cxGetResourceString(@sdxHeaderFooterBar);
    Bars[3].Caption := cxGetResourceString(@sdxShortCutMenusBar);
    Bars[4].Caption := cxGetResourceString(@sdxAutoTextBar);
    Bars[5].Caption := cxGetResourceString(@sdxExplorerBar);

    Categories[0] := DropAmpersand(cxGetResourceString(@sdxMenuFile));
    Categories[1] := DropAmpersand(cxGetResourceString(@sdxMenuExplorer));
    Categories[2] := DropAmpersand(cxGetResourceString(@sdxMenuEdit));
    Categories[3] := DropAmpersand(cxGetResourceString(@sdxMenuInsert));
    Categories[4] := DropAmpersand(cxGetResourceString(@sdxMenuView));
    Categories[5] := DropAmpersand(cxGetResourceString(@sdxMenuFormat));
    Categories[6] := DropAmpersand(cxGetResourceString(@sdxMenuZoom));
    Categories[7] := DropAmpersand(cxGetResourceString(@sdxMenuTools));
    Categories[8] := DropAmpersand(cxGetResourceString(@sdxMenuGotoPage));
    Categories[9] := DropAmpersand(cxGetResourceString(@sdxMenuHelp));
    Categories[10] := DropAmpersand(cxGetResourceString(@sdxMenuBuiltInMenus));
    Categories[11] := DropAmpersand(cxGetResourceString(@sdxMenuShortCutMenus));
    Categories[12] := DropAmpersand(cxGetResourceString(@sdxMenuNewMenu));
  end;

  bbFile.Caption := cxGetResourceString(@sdxMenuFile);
  bbFileSave.Caption := cxGetResourceString(@sdxMenuFileSave);
  bbFileLoad.Caption := cxGetResourceString(@sdxMenuFileLoad);
  bbFileClose.Caption := cxGetResourceString(@sdxMenuFileClose);
  bbFileDesign.Caption := cxGetResourceString(@sdxMenuFileDesign);
  bbFilePrintDialog.Caption := cxGetResourceString(@sdxMenuFilePrint);
  bbFilePrint.Caption := DropEndEllipsis(cxGetResourceString(@sdxMenuFilePrint));
  bbFileRebuild.Caption := cxGetResourceString(@sdxMenuFileRebuild);
//  bbFilePrintSetup.Caption := cxGetResourceString(@sdxMenuFilePrintSetup);
  bliPrintStyles.Caption := cxGetResourceString(@sdxMenuPrintStyles);
  bbFilePageSetup.Caption := cxGetResourceString(@sdxMenuFilePageSetup);
  bbFileExit.Caption := cxGetResourceString(@sdxMenuFileExit);

  bbExplorer.Caption := cxGetResourceString(@sdxMenuExplorer);
  bbExplorerCreateNewFolder.Caption := cxGetResourceString(@sdxMenuExplorerCreateFolder);
  bbExplorerDelete.Caption := cxGetResourceString(@sdxMenuExplorerDelete);
  bbExplorerRename.Caption := cxGetResourceString(@sdxMenuExplorerRename);
  bbExplorerProperties.Caption := cxGetResourceString(@sdxMenuExplorerProperties);
  
  bbEdit.Caption := cxGetResourceString(@sdxMenuEdit);
  bbEditFind.Caption := cxGetResourceString(@sdxMenuEditFind);
  bbEditFindNext.Caption := cxGetResourceString(@sdxMenuEditFindNext);
  bbEditReplace.Caption := cxGetResourceString(@sdxMenuEditReplace);

  bbInsert.Caption := cxGetResourceString(@sdxMenuInsert);
  bsiInsertHFAutoText.Caption := cxGetResourceString(@sdxMenuInsertAutoText);
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

  bbView.Caption := cxGetResourceString(@sdxMenuView);
  bbViewMargins.Caption := cxGetResourceString(@sdxMenuViewMargins);
  bbViewMarginBar.Caption := cxGetResourceString(@sdxMenuViewMarginsStatusBar);
  bbViewStatusBar.Caption := cxGetResourceString(@sdxMenuViewPagesStatusBar);
  bbViewExplorer.Caption := cxGetResourceString(@sdxMenuViewExplorer);
  bbViewThumbnails.Caption := cxGetResourceString(@sdxMenuViewThumbnails);
  bbThumbnailsSmall.Caption := cxGetResourceString(@sdxMenuThumbnailsSmall);
  bbThumbnailsLarge.Caption := cxGetResourceString(@sdxMenuThumbnailsLarge);
  bbViewToolbars.Caption := cxGetResourceString(@sdxMenuViewToolBars);
  bbViewZoom.Caption := cxGetResourceString(@sdxMenuZoom);
  
  bbZoomPercent100.Caption := cxGetResourceString(@sdxMenuZoomPercent100);
  bbZoomPageWidth.Caption := cxGetResourceString(@sdxMenuZoomPageWidth);
  bbZoomWholePage.Caption := cxGetResourceString(@sdxMenuZoomWholePage);
  bbZoomTwoPages.Caption := cxGetResourceString(@sdxMenuZoomTwoPages);
  bbZoomFourPages.Caption := cxGetResourceString(@sdxMenuZoomFourPages);
  bbZoomMultiplePages.Caption := cxGetResourceString(@sdxMenuZoomMultiplyPages);
  bbZoomWidenToSourceWidth.Caption := cxGetResourceString(@sdxMenuZoomWidenToSourceWidth);
  bbZoomSetup.Caption := cxGetResourceString(@sdxMenuZoomSetup);
  bbViewPages.Caption := cxGetResourceString(@sdxMenuPages);
  bbViewPageHeaders.Caption := cxGetResourceString(@sdxMenuViewPagesHeaders);
  bbViewPageFooters.Caption := cxGetResourceString(@sdxMenuViewPagesFooters);
  bbViewSwitchToLeftPart.Caption := cxGetResourceString(@sdxMenuViewSwitchToLeftPart);
  bbViewSwitchToRightPart.Caption := cxGetResourceString(@sdxMenuViewSwitchToRightPart);
  bbViewSwitchToCenterPart.Caption := cxGetResourceString(@sdxMenuViewSwitchToCenterPart);
  bbViewHFSwitchHeaderFooter.Caption := cxGetResourceString(@sdxMenuViewHFSwitchHeaderFooter);
  bbViewHFClose.Caption := cxGetResourceString(@sdxMenuViewHFClose);

  bbFormat.Caption := cxGetResourceString(@sdxMenuFormat);
  bbFormatTitle.Caption := cxGetResourceString(@sdxMenuFormatTitle);
  bbFormatHeaderAndFooter.Caption := cxGetResourceString(@sdxMenuFormatHeaderAndFooter);
  bbFormatDateTime.Caption := cxGetResourceString(@sdxMenuFormatDateTime);
  bbFormatPageNumbering.Caption := cxGetResourceString(@sdxMenuFormatPageNumbering);
  bbFormatPageBackground.Caption := cxGetResourceString(@sdxMenuFormatPageBackground);
  bbFormatShrinkToPageWidth.Caption := cxGetResourceString(@sdxMenuFormatShrinkToPage);
  bbFormatShowHideEmptyPages.Caption := cxGetResourceString(@sdxMenuShowEmptyPages);
  bbFormatHFBackground.Caption := cxGetResourceString(@sdxMenuFormatHFBackground);
  bbFormatHFClear.Caption := cxGetResourceString(@sdxMenuFormatHFClear);

  bbGotoPage.Caption := cxGetResourceString(@sdxMenuGotoPage);
  bbGotoFirstPage.Caption := cxGetResourceString(@sdxMenuGotoPageFirst);
  bbGotoPrevPage.Caption := cxGetResourceString(@sdxMenuGotoPagePrev);
  bbGotoNextPage.Caption := cxGetResourceString(@sdxMenuGotoPageNext);
  bbGotoLastPage.Caption := cxGetResourceString(@sdxMenuGotoPageLast);

  bbTools.Caption := cxGetResourceString(@sdxMenuTools);
  bbToolsCustomize.Caption := cxGetResourceString(@sdxMenuToolsCustomize);
  bbToolsOptions.Caption := cxGetResourceString(@sdxMenuToolsOptions);

  bbHelp.Caption := cxGetResourceString(@sdxMenuHelp);
  bbHelpTopics.Caption := cxGetResourceString(@sdxMenuHelpTopics);
  bbHelpAbout.Caption := cxGetResourceString(@sdxMenuHelpAbout);

  cbxPredefinedZoom.Caption := cxGetResourceString(@sdxMenuZoom) + ':';
  cbxPredefinedZoom.Items[8] := cxGetResourceString(@sdxPageWidth); 
  cbxPredefinedZoom.Items[9] := cxGetResourceString(@sdxWholePage);
  cbxPredefinedZoom.Items[10] := cxGetResourceString(@sdxTwoPages); 
  cbxPredefinedZoom.Items[11] := cxGetResourceString(@sdxFourPages); 
  cbxPredefinedZoom.Items[12] := cxGetResourceString(@sdxWidenToSourceWidth);
  seActivePage.Caption := cxGetResourceString(@sdxMenuActivePage);

  bsiShortcutPreview.Caption := cxGetResourceString(@sdxMenuShortcutPreview);
  bsiShortcutExplorer.Caption := cxGetResourceString(@sdxMenuShortcutExplorer);
  bsiShortcutThumbnails.Caption := cxGetResourceString(@sdxMenuShortcutThumbnails);

  bsiNewMenuNewMenu.Caption := cxGetResourceString(@sdxMenuNewMenu);

  { hints }
  bbFileDesign.Hint := cxGetResourceString(@sdxHintFileDesign);
  bbFileSave.Hint := cxGetResourceString(@sdxHintFileSave);
  bbFileLoad.Hint := cxGetResourceString(@sdxHintFileLoad);
  bbFileClose.Hint := cxGetResourceString(@sdxHintFileClose);
  bbFilePrint.Hint := cxGetResourceString(@sdxHintFilePrint) + dxPSPrVw.GetCurrentPrinterAsHint;
  bbFilePrintDialog.Hint := cxGetResourceString(@sdxHintFilePrintDialog);
//  bbFilePrintSetup.Hint := cxGetResourceString(@sdxHintFilePrintSetup);
  bbFilePageSetup.Hint := cxGetResourceString(@sdxHintFilePageSetup);
  bbFileExit.Hint := cxGetResourceString(@sdxHintFileExit);

  bbExplorerCreateNewFolder.Hint := cxGetResourceString(@sdxHintExplorerCreateFolder);
  bbExplorerDelete.Hint := cxGetResourceString(@sdxHintExplorerDelete);
  bbExplorerRename.Hint := cxGetResourceString(@sdxHintExplorerRename);
  bbExplorerProperties.Hint := cxGetResourceString(@sdxHintExplorerProperties);
  
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
  bbViewHFSwitchHeaderFooter.Hint := cxGetResourceString(@sdxHintViewHFSwitchHeaderFooter);
  bbViewHFClose.Hint := cxGetResourceString(@sdxHintViewHFClose);

  bbFormatTitle.Hint := cxGetResourceString(@sdxHintFormatTitle);
  bbFormatDateTime.Hint := cxGetResourceString(@sdxHintFormatDateTime);
  bbFormatPageNumbering.Hint := cxGetResourceString(@sdxHintFormatPageNumbering);
  bbFormatPageBackground.Hint := cxGetResourceString(@sdxHintFormatPageBackground);
  bbFormatShrinkToPageWidth.Hint := cxGetResourceString(@sdxHintFormatShrinkToPage);
  bbFormatHFBackground.Hint := cxGetResourceString(@sdxHintFormatHFBackground);
  bbFormatHFClear.Hint := cxGetResourceString(@sdxHintFormatHFClear);

  bbGotoFirstPage.Hint := cxGetResourceString(@sdxHintGotoPageFirst);
  bbGotoPrevPage.Hint := cxGetResourceString(@sdxHintGotoPagePrev);
  bbGotoNextPage.Hint := cxGetResourceString(@sdxHintGotoPageNext);
  bbGotoLastPage.Hint := cxGetResourceString(@sdxHintGotoPageLast);
  seActivePage.Hint := cxGetResourceString(@sdxHintActivePage);

  bbToolsCustomize.Hint := cxGetResourceString(@sdxHintToolsCustomize);
  bbToolsOptions.Hint := cxGetResourceString(@sdxHintToolsOptions);

  bbHelpTopics.Hint := cxGetResourceString(@sdxHintHelpTopics);
  bbHelpAbout.Hint := cxGetResourceString(@sdxHintHelpAbout);
end;

procedure TdxfmPreviewWdxBar.StyleListChanged(Sender: TObject);
begin
  if Sender = ReportLink.StyleManager then 
    ReportLink.BuildPageSetupMenu(bliPrintStyles, bbDefinePrintStyles, True);
end;

procedure TdxfmPreviewWdxBar.ZoomClick(Sender: TObject);
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
    case TTagToInt(TComponent(Sender).Tag) of
      3: PageXCount := 2;
      4:
        begin
          PageXCount := 2;
          PageYCount := 2;
        end;
      5: ReportLink.GetPageColRowCount(PageXCount, PageYCount);
    end;
  DoSetupZoomFactor(100, PageXCount, PageYCount, ZoomMode);
end;

procedure TdxfmPreviewWdxBar.SetBarItemVisibility(Item: TdxBarItem; Value: Boolean);
begin
  Item.Visible := VisibleToBarItemVisible(Value);
end;

procedure TdxfmPreviewWdxBar.DoShowHFToolBar(Value: Boolean);
begin
  ShowHFBar(Value);
end;

procedure TdxfmPreviewWdxBar.seActivePageChange(Sender: TObject);
var
  V: Integer;
begin
  if Locked then Exit;
  V := seActivePage.IntCurValue;
  if V < seActivePage.MinValue then V := Round(seActivePage.MinValue);
  if V > seActivePage.MaxValue then V := Round(seActivePage.MaxValue);
  DoActivePageChanged(V - 1);
end;

procedure TdxfmPreviewWdxBar.seActivePageButtonClick(
  Sender: TdxBarSpinEdit; Button: TdxBarSpinEditButton);
begin
  if Locked then Exit;
  case Button of
    sbUp: 
      GoToNextPage;
    sbDown: 
      GoToPrevPage;
  end;
end;

procedure TdxfmPreviewWdxBar.cbxPredefinedZoomChange(Sender: TObject);
begin
  SetZoomFactorByText(cbxPredefinedZoom.Text);
  if cbxPredefinedZoom.DroppedDown then Windows.SetFocus(Preview.Handle);
  UpdateControls;
  cbxPredefinedZoom.Text := AddPercentageChar(IntToStr(ZoomFactor));
end;
                
procedure TdxfmPreviewWdxBar.dxBarManagerBarVisibleChange(Sender: TdxBarManager;
  ABar: TdxBar);
begin
  if ABar = HFBar then UpdateHFState(ABar.Visible);
end;

procedure TdxfmPreviewWdxBar.miCustomizePopupClick(Sender: TObject);
begin
  ShowdxBarSubMenuEditor(pmPreview.ItemLinks);
end;

procedure TdxfmPreviewWdxBar.bbViewHFCloseClick(Sender: TObject);
begin
  DoShowHFToolBar(False);
end;

procedure TdxfmPreviewWdxBar.bbFormatHeaderAndFooterClick(Sender: TObject);
begin
  DoShowHFToolBar(TdxBarButton(Sender).Down);
end;

procedure TdxfmPreviewWdxBar.InsertHFClick(Sender: TObject);
begin
  DoInsertHF(HFFunctionList[TTagToInt(TComponent(Sender).Tag)]);
end;

procedure TdxfmPreviewWdxBar.bbFormatHFClearClick(Sender: TObject);
begin
  DoClearHF;
end;

procedure TdxfmPreviewWdxBar.bbViewHFSwitchHeaderFooterClick(Sender: TObject);
begin
  if TdxBarButton(Sender).Down then 
    State := prsEditFooters
  else  
    State := prsEditHeaders;
end;

procedure TdxfmPreviewWdxBar.bbFormatDateTimeClick(Sender: TObject);
begin
  ProcessMessages;
  DoShowFormatDateTimeDlg;
end;

procedure TdxfmPreviewWdxBar.bbFormatTitleClick(Sender: TObject);
begin
  ProcessMessages;
  DoFormatTitle;
end;

procedure TdxfmPreviewWdxBar.bbFormatPageNumbersClick(Sender: TObject);
begin
  ProcessMessages;
  DoShowFormatPageNumbersDlg;
end;

procedure TdxfmPreviewWdxBar.SwitchPartClick(Sender: TObject);
begin
  HFEditPart := TdxPageTitlePart(TTagToInt(TdxBarButton(Sender).Tag));
end;

procedure TdxfmPreviewWdxBar.bbFormatHFBackgroundClick(Sender: TObject);
begin
  ProcessMessages;
  DoShowHFBackgroundDlg(CalcWindowPos(Sender));
end;

procedure TdxfmPreviewWdxBar.bbViewPageHeadersClick(Sender: TObject);
begin
  if Locked then Exit;
  DoShowPageHeaders(TdxBarButton(Sender).Down);
end;

procedure TdxfmPreviewWdxBar.bbViewPageFootersClick(Sender: TObject);
begin
  if Locked then Exit;
  DoShowPageFooters(TdxBarButton(Sender).Down);
end;

procedure TdxfmPreviewWdxBar.bbToolsCustomizeClick(Sender: TObject);
begin
  dxBarManager.Customizing(True);
end;

procedure TdxfmPreviewWdxBar.bbToolsOptionsClick(Sender: TObject);
begin
  DoShowOptionsDlg;
end;

procedure TdxfmPreviewWdxBar.dxBarManagerShowCustomizingForm(Sender: TObject);
begin
  ShowShortCutBar(True);
end;

procedure TdxfmPreviewWdxBar.dxBarManagerHideCustomizingForm(Sender: TObject);
begin
  ShowShortCutBar(False);
end;

function TdxfmPreviewWdxBar.GetExplorerContextCommand(Index: Integer): TCustomdxPSExplorerContextCommand;
begin
  Result := TCustomdxPSExplorerContextCommand(FExplorerContextCommands.Items[Index]);
end;

function TdxfmPreviewWdxBar.GetExplorerContextCommandCount: Integer;
begin
  Result := FExplorerContextCommands.Count;
end;

function TdxfmPreviewWdxBar.CalcWindowPos(Sender: TObject): TPoint;
var
  Link: TdxBarItemLink;
  R: TRect;
begin
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

procedure TdxfmPreviewWdxBar.EnableItemsWhileBuilding(Value: Boolean);
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

procedure TdxfmPreviewWdxBar.DoShowExplorerPopup(Sender: TObject; 
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then 
    pmExplorer.PopupFromCursorPos;
end;

function TdxfmPreviewWdxBar.ShortcutBar: TdxBar;
begin
  Result := dxBarManager.BarByCaption(DropAmpersand(cxGetResourceString(@sdxShortCutMenusBar)));
end;
  
procedure TdxfmPreviewWdxBar.ShowShortCutBar(Value: Boolean);
var
  Bar: TdxBar;
begin
  Bar := ShortcutBar;
  if Bar <> nil then
  begin
    Bar.Hidden := not Value;
    Bar.Visible := False;
    if Value then
    begin
      bsiShortcutPreview.ItemLinks := pmPreview.ItemLinks;
      bsiShortcutExplorer.ItemLinks := pmExplorer.ItemLinks;
      bsiShortcutThumbnails.ItemLinks := pmThumbnails.ItemLinks;
    end
    else
    begin
      pmPreview.ItemLinks := bsiShortcutPreview.ItemLinks;
      pmExplorer.ItemLinks := bsiShortcutExplorer.ItemLinks;
      pmThumbnails.ItemLinks := bsiShortcutThumbnails.ItemLinks;
    end;  
  end;
end;

procedure TdxfmPreviewWdxBar.EnabledHFItems(Value: Boolean);
begin
  bbInsertHFPageNumber.Enabled := Value;
  bbInsertHFTotalPages.Enabled := Value;
  bbInsertHFPageOfPages.Enabled := Value;
  bbInsertHFDate.Enabled := Value;
  bbInsertHFTime.Enabled := Value;
  bbInsertHFDateTime.Enabled := Value;
  bbViewHFSwitchHeaderFooter.Enabled := Value;
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

function TdxfmPreviewWdxBar.HFBar: TdxBar;
begin
  Result := dxBarManager.BarByCaption(DropAmpersand(cxGetResourceString(@sdxHeaderFooterBar)));
end;

procedure TdxfmPreviewWdxBar.ShowHFBar(Value: Boolean);
var
  Bar: TdxBar;
begin
  Bar := HFBar;
  if Bar <> nil then Bar.Visible := Value;
end;

procedure TdxfmPreviewWdxBar.UpdateHFState(Value: Boolean);
begin
  EnabledHFItems(Value);
  if Preview <> nil then
    if Value then
      Preview.OptionsZoom := Preview.OptionsZoom - [pozZoomOnClick]
    else
      Preview.OptionsZoom := Preview.OptionsZoom + [pozZoomOnClick];
  bbFormatHeaderAndFooter.Down := Value;
  
  if Value then 
    if bbViewHFSwitchHeaderFooter.Down then 
      State := prsEditFooters
    else
      State := prsEditHeaders
  else
    State := prsNone;
end;

procedure TdxfmPreviewWdxBar.LoadBarManagerFromRegistry(const APath: string);
var
  IsSameVersion: Boolean;
begin
  with TRegistry.Create do
  try
    IsSameVersion := OpenKey(APath + '\Version', False);
    if IsSameVersion then
    try
      IsSameVersion := ValueExists('Major') and ValueExists('Minor');
      if IsSameVersion then
        IsSameVersion := (ReadInteger('Major') = dxPSVerMajor) and 
                         (ReadInteger('Minor') = dxPSVerMinor);
    except
      on ERegistryException do
        IsSameVersion := False
      else
        raise;
    end;
  finally
    Free;
  end;

  if IsSameVersion then
  begin
    dxBarManager.LoadFromRegistry(APath + sdxToolBars);
    pmPreview.ItemLinks := bsiShortcutPreview.ItemLinks;
    pmExplorer.ItemLinks := bsiShortcutExplorer.ItemLinks;
    pmThumbnails.ItemLinks := bsiShortcutThumbnails.ItemLinks;
  end
  else
  begin
    bsiShortcutPreview.ItemLinks := pmPreview.ItemLinks;
    bsiShortcutExplorer.ItemLinks := pmExplorer.ItemLinks;
    bsiShortcutThumbnails.ItemLinks := pmThumbnails.ItemLinks;
  end;  
end;

procedure TdxfmPreviewWdxBar.SaveBarManagerToRegistry(const APath: string);
begin
  with TRegistry.Create do
  try
    if OpenKey(APath + '\Version', True) then
    try
      WriteInteger('Major', dxPSVerMajor);
      WriteInteger('Minor', dxPSVerMinor);
    except
      on ERegistryException do
      else
        raise;
    end;
  finally
    Free;
  end;
  dxBarManager.SaveToRegistry(APath + sdxToolBars);
end;

procedure TdxfmPreviewWdxBar.TimerHintTimer(Sender: TObject);
begin
  bbFilePrint.Hint := cxGetResourceString(@sdxHintFilePrint) + GetCurrentPrinterAsHint;
  TTimer(Sender).Enabled := False;
end;

initialization
  dxPSPopupMenuController.RegisterBuilder(TdxBarPSPopupMenuBuilder);
  dxPSAutoHFTextMenuBuilderFactory.RegisterBuilder(TdxBarPSAutoHFTextMenuBuilder);
  dxPSPageSetupMenuBuilderFactory.RegisterBuilder(TdxBarPSPageSetupMenuBuilder);
  
  dxPSRegisterPreviewWindow(TdxfmPreviewWdxBar);
  
  dxPSGlbl.PSCanShowHintFunc := dxBar_DoesNotHaveActivePopup;
  
finalization
  dxPSGlbl.PSCanShowHintFunc := nil;

  dxPSUnregisterPreviewWindow(TdxfmPreviewWdxBar);

  dxPSPageSetupMenuBuilderFactory.UnregisterBuilder(TdxBarPSPageSetupMenuBuilder);  
  dxPSAutoHFTextMenuBuilderFactory.UnregisterBuilder(TdxBarPSAutoHFTextMenuBuilder);
  dxPSPopupMenuController.UnregisterBuilder(TdxBarPSPopupMenuBuilder);  
  
end.

                                                                  
