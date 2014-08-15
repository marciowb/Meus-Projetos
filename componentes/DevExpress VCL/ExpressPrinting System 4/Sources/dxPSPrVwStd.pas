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

unit dxPSPrVwStd;

interface

{$I cxVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ComCtrls, 
  StdCtrls, ExtCtrls, ToolWin, Menus, ImgList, dxPSCore, dxExtCtrls, dxPrevw, 
  dxPSPrvw, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxSpinEdit, cxListBox, cxGraphics, cxDropDownEdit, cxLookAndFeels,
  cxLookAndFeelPainters, dxPSForm, cxGroupBox, dxThemeManager, IniFiles;

type
  TdxfmStdPreview = class(TForm)
    cbxPredefinedZoom: TcxComboBox;
    MainMenu1: TMainMenu;
    miEdit: TMenuItem;
    miEditFind: TMenuItem;
    miEditFindNext: TMenuItem;
    miEditReplace: TMenuItem;
    miExplorer: TMenuItem;
    miExplorerCreateNewFolder: TMenuItem;
    miExplorerDelete: TMenuItem;
    miExplorerProperties: TMenuItem;
    miExplorerRename: TMenuItem;
    miFile: TMenuItem;
    miFileClose: TMenuItem;
    miFileDesign: TMenuItem;
    miFileExit: TMenuItem;
    miFileLoad: TMenuItem;
    miFilePageSetup: TMenuItem;
    miFilePreferences: TMenuItem;
    miFilePrint: TMenuItem;
    miFilePrintStyles: TMenuItem;
    miFileRebuild: TMenuItem;
    miFileSave: TMenuItem;
    miFormat: TMenuItem;
    miFormatAutoText: TMenuItem;
    miFormatDateTime: TMenuItem;
    miFormatPageBackground: TMenuItem;
    miFormatPageNumbering: TMenuItem;
    miFormatShowHideEmptyPages: TMenuItem;
    miFormatShrinkToPageWidth: TMenuItem;
    miFormatTitle: TMenuItem;
    miGoToFirstPage: TMenuItem;
    miGoToLastPage: TMenuItem;
    miGoToNextPage: TMenuItem;
    miGoToPage: TMenuItem;
    miGoToPrevPage: TMenuItem;
    miHelp: TMenuItem;
    miHelpAbout: TMenuItem;
    miHelpTopics: TMenuItem;
    miLine1: TMenuItem;
    miLine10: TMenuItem;
    miLine11: TMenuItem;
    miLine12: TMenuItem;
    miLine13: TMenuItem;
    miLine14: TMenuItem;
    miLine2: TMenuItem;
    miLine20: TMenuItem;
    miLine3: TMenuItem;
    miLine30: TMenuItem;
    miLine31: TMenuItem;
    miLine32: TMenuItem;
    miLine33: TMenuItem;
    miLine34: TMenuItem;
    miLine39: TMenuItem;
    miLine4: TMenuItem;
    miLine40: TMenuItem;
    miLine5: TMenuItem;
    miLine6: TMenuItem;
    miLine7: TMenuItem;
    miLine8: TMenuItem;
    miLine9: TMenuItem;
    miView: TMenuItem;
    miViewExplorer: TMenuItem;
    miViewFlatTBtns: TMenuItem;
    miViewLargeTBtns: TMenuItem;
    miViewMarginBar: TMenuItem;
    miViewMargins: TMenuItem;
    miViewPageFooters: TMenuItem;
    miViewPageHeaders: TMenuItem;
    miViewStatusBar: TMenuItem;
    miViewThumbnails: TMenuItem;
    miViewToolBar: TMenuItem;
    miViewZoom: TMenuItem;
    miZoomFourPages: TMenuItem;
    miZoomPageWidth: TMenuItem;
    miZoomPercent100: TMenuItem;
    miZoomSetup: TMenuItem;
    miZoomTwoPages: TMenuItem;
    miZoomWholePage: TMenuItem;
    miZoomWidenToSourceWidth: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    pmDesigners: TPopupMenu;
    pmExplorer: TPopupMenu;
    pmiExplorerCreateFolder: TMenuItem;
    pmiExplorerDelete: TMenuItem;
    pmiExplorerLoadData: TMenuItem;
    pmiExplorerProperties: TMenuItem;
    pmiExplorerRename: TMenuItem;
    pmiExplorerUnloadData: TMenuItem;
    pmiFilePrintStyles: TMenuItem;
    pmiFlatBtns: TMenuItem;
    pmiGoToFirstPage: TMenuItem;
    pmiGoToLastPage: TMenuItem;
    pmiGoToNextPage: TMenuItem;
    pmiGoToPrevPage: TMenuItem;
    pmiLargeBtns: TMenuItem;
    pmiLargeThumbnails: TMenuItem;
    pmiPageSetup: TMenuItem;
    pmiReportDesign: TMenuItem;
    pmiReportShrinkToPageWidth: TMenuItem;
    pmiSmallThumbnails: TMenuItem;
    pmiZoom: TMenuItem;
    pmiZoomFourPages: TMenuItem;
    pmiZoomPageWidth: TMenuItem;
    pmiZoomPercent100: TMenuItem;
    pmiZoomTwoPages: TMenuItem;
    pmiZoomWholePage: TMenuItem;
    pmiZoomWidenToSourceWidth: TMenuItem;
    pmPreview: TPopupMenu;
    pmPrintStyles: TPopupMenu;
    pmThumbnails: TPopupMenu;
    pmToolBar: TPopupMenu;
    pnlActivePage: TcxGroupBox;
    pnlPredefinedZoom: TcxGroupBox;
    seActivePage: TcxSpinEdit;
    tbClose: TToolButton;
    tbFileLoad: TToolButton;
    tbFileSave: TToolButton;
    tbFileUnload: TToolButton;
    tbFourPage: TToolButton;
    tbGotoFirstPage: TToolButton;
    tbGotoLastPage: TToolButton;
    tbGotoNextPage: TToolButton;
    tbGotoPrevPage: TToolButton;
    tbHelp: TToolButton;
    tbMultiplePages: TToolButton;
    tbOnePage: TToolButton;
    tbPageBackground: TToolButton;
    tbPageSetup: TToolButton;
    tbPageWidth: TToolButton;
    tbPercent100: TToolButton;
    tbPrint: TToolButton;
    tbPrintDialog: TToolButton;
    tbReportDesigner: TToolButton;
    tbSeparator1: TToolButton;
    tbSeparator2: TToolButton;
    tbSeparator3: TToolButton;
    tbSeparator4: TToolButton;
    tbSeparator5: TToolButton;
    tbSeparator8: TToolButton;
    tbShrinkToPageWidth: TToolButton;
    tbTwoPage: TToolButton;
    tbViewExplorer: TToolButton;
    tbViewThumbnails: TToolButton;
    tbWidenToSourceWidth: TToolButton;
    Timer1: TTimer;
    ToolBar: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton5: TToolButton;
    tbExportToPDF: TToolButton;
    miLine21: TMenuItem;
    miExportToPDF: TMenuItem;
    Preview: TdxPSPreviewWindow;
    miFormatFootnotes: TMenuItem;
    ilToolBarSmall: TcxImageList;
    ilStub: TcxImageList;
    procedure pmiFlatBtnsClick(Sender: TObject);
    procedure pmiLargeBtnsClick(Sender: TObject);
    procedure PageSetupClick(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure ZoomClick(Sender: TObject);
    procedure GoToPageClick(Sender: TObject);
    procedure CloseClick(Sender: TObject);
    procedure cbxPredefinedZoomClick(Sender: TObject);
    procedure cbxPredefinedZoomKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure seActivePageExit(Sender: TObject);
    procedure seKeyPress(Sender: TObject; var Key: Char);
    procedure DesignClick(Sender: TObject);
    procedure PageBackgroundClick(Sender: TObject);
    procedure OptionsClick(Sender: TObject);
    procedure miViewMarginsClick(Sender: TObject);
    procedure HelpClick(Sender: TObject);
    procedure miViewMarginBarClick(Sender: TObject);
    procedure miViewStatusBarClick(Sender: TObject);
    procedure pmToolBarPopup(Sender: TObject);
    procedure pmPreviewPopup(Sender: TObject);
    procedure tbMultiplePagesClick(Sender: TObject);
    procedure miZoomSetupClick(Sender: TObject);
    procedure ShrinkToPageWidthClick(Sender: TObject);
    procedure miFormatDateTimeClick(Sender: TObject);
    procedure miFormatPageNumberingClick(Sender: TObject);
    procedure miViewPageHeadersClick(Sender: TObject);
    procedure miViewPageFootersClick(Sender: TObject);
    procedure miFormatShowHideEmptyPagesClick(Sender: TObject);
    procedure pmPrintStylesPopup(Sender: TObject);
    procedure miFormatAutoTextClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ViewExplorerClick(Sender: TObject);
    procedure ExplorerCreateNewFolderClick(Sender: TObject);
    procedure FileSaveClick(Sender: TObject);
    procedure ExplorerDeleteClick(Sender: TObject);
    procedure ExplorerRenameClick(Sender: TObject);
    procedure FileLoadClick(Sender: TObject);
    procedure pmExplorerPopup(Sender: TObject);
    procedure FileCloseClick(Sender: TObject);
    procedure miFormatTitleClick(Sender: TObject);
    procedure ViewThumbnailsClick(Sender: TObject);
    procedure pmiThumbnailsSizeClick(Sender: TObject);
    procedure pmThumbnailsPopup(Sender: TObject);
    procedure ExplorerPropertiesClick(Sender: TObject);
    procedure miFileRebuildClick(Sender: TObject);
    procedure cbxPredefinedZoomPropertiesCloseUp(Sender: TObject);
    procedure cbxPredefinedZoomPropertiesDrawItem(
      AControl: TcxCustomComboBox; ACanvas: TcxCanvas; AIndex: Integer;
      const ARect: TRect; AState: TOwnerDrawState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure miExportToPDFClick(Sender: TObject);
    procedure PreviewAddExplorerCommand(Sender: TObject; ACommand: TCustomdxPSExplorerContextCommand);
    procedure PreviewAfterPrintReport(Sender: TObject; AShowDialog: Boolean);
    procedure PreviewCreationComplete(Sender: TObject);
    procedure PreviewInitContent(Sender: TObject);
    procedure PreviewStyleListChanged(Sender: TObject);
    procedure PreviewUpdateControls(Sender: TObject);
    procedure PreviewUpdateExplorerCommands(Sender: TObject);
    procedure PreviewZoomFactorChanged(Sender: TObject);
    procedure PreviewZoomModeChanged(Sender: TObject);
    procedure miFormatFootnotesClick(Sender: TObject);
    procedure PreviewLoadProperties(Sender: TObject; AIniFile: TCustomIniFile; const ASectionName: string);
    procedure PreviewSaveProperties(Sender: TObject; AIniFile: TCustomIniFile; const ASectionName: string);
  private
    FExplorerContextCommandMenuItems: TList;
    FExplorerContextCommandPopupMenuItems: TList;
    FExplorerContextCommandToolButtons: TList;
    FFlatCtrls: Boolean;
    FilToolBarLarge: TImageList;
    FLargeBtns: Boolean;
    FLookAndFeel: TcxLookAndFeel;

    function GetExplorerContextCommandMenuItem(Index: Integer): TMenuItem;
    function GetExplorerContextCommandMenuItemCount: Integer;
    function GetExplorerContextCommandPopupMenuItem(Index: Integer): TMenuItem;
    function GetExplorerContextCommandPopupMenuItemCount: Integer;
    function GetExplorerContextCommandToolButton(Index: Integer): TToolButton;
    function GetExplorerContextCommandToolButtonCount: Integer;
    function GetLocked: Boolean;
    function GetReportLink: TBasedxReportLink;
    function GetToolBarImageList: TCustomImageList;

    procedure SetFlatCtrls(Value: Boolean);
    procedure SetLargeBtns(Value: Boolean);
    procedure PreviewAfterCreateControls;
    procedure UpdateControls;

    procedure LoadDefaultProperties;
    procedure SaveDefaultProperties;
    procedure LoadProperties(AIniFile: TCustomIniFile; const ASectionName: string);
    procedure SaveProperties(AIniFile: TCustomIniFile; const ASectionName: string);

    function CalculateWindowPos(Sender: TObject): TPoint;
    function CreateLargeImages(ASource: TCustomImageList): TImageList;
    procedure ArrangeToolBarCtrls;
    procedure AssignToolBarImages;
    procedure CheckItem(AParent: TMenuItem);
    procedure DoShowExplorerPopup(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SetupFlatCtrls;
    procedure WMInitMenu(var Message: TWMInitMenu); message WM_INITMENU;
  protected
    procedure Activate; override;
    procedure DoShow; override;
    procedure ExplorerContextCommandClick(Sender: TObject); virtual;
    procedure InitializeLookAndFeel;
    procedure InitializeZoomComboBox; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure LoadStrings;

    property ExplorerContextCommandMenuItemCount: Integer read GetExplorerContextCommandMenuItemCount;
    property ExplorerContextCommandMenuItems[Index: Integer]: TMenuItem read GetExplorerContextCommandMenuItem;
    property ExplorerContextCommandPopupMenuItemCount: Integer read GetExplorerContextCommandPopupMenuItemCount;
    property ExplorerContextCommandPopupMenuItems[Index: Integer]: TMenuItem read GetExplorerContextCommandPopupMenuItem;
    property ExplorerContextCommandToolButtonCount: Integer read GetExplorerContextCommandToolButtonCount;
    property ExplorerContextCommandToolButtons[Index: Integer]: TToolButton read GetExplorerContextCommandToolButton;
    property LookAndFeel: TcxLookAndFeel read FLookAndFeel;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AfterConstruction; override;

    property FlatCtrls: Boolean read FFlatCtrls write SetFlatCtrls;
    property LargeBtns: Boolean read FLargeBtns write SetLargeBtns;
    property Locked: Boolean read GetLocked;
    property ReportLink: TBasedxReportLink read GetReportLink;
    property ToolBarImageList: TCustomImageList read GetToolBarImageList;
  end;

implementation

{$R *.DFM}

uses
  Registry, CommCtrl, Math, {$IFDEF DELPHI7}Themes, UxTheme, {$ENDIF} cxClasses,
  dxPSGlbl, dxPSEngn, dxPgsDlg, dxPSRes, dxPSImgs, dxPrnDev, dxPSPopupMan,
  dxPSUtl, dxPSPDFExport;

const
  ToolBarHeight: array[Boolean] of Integer = (38, 54);
  ToolBtnSize: array[Boolean] of TSize = ((cx: 25; cy: 24), (cx: 40; cy: 40));
 
{ '500%, 200%, 150%, 100%, 75%, 50%, 25%, 10%,
  "Page Width", "Whole Page", "Two Pages", "Four Pages", "Widen To Source Width' }

  ZoomItemCount = 13;
  ZoomItemIndexes: array[0..ZoomItemCount - 1] of Integer =
    (-1, -1, -1, 5, -1, -1, -1, -1, 6, 7, 8, 9, 11);

  // strings used when saving(loading) properties to(from) registry

  sdxFlatCtrls = 'FlatCtrls';
  sdxLargeBtns = 'LargeBtns';

type
  TControlAccess = class(TControl);

  { TdxPSStandardPreviewDialogStyleInfo }

  TdxPSStandardPreviewDialogStyleInfo = class(TdxPSPreviewDialogStyleInfo)
  public
    class function CreatePreviewWindow: TdxPSCustomPreviewWindow; override;
    class function GetName: string; override;
  end;

{ Utility Routines }

function AddPercentSign(const S: string): string;
begin
  Result := S;
  if S[Length(S)] <> PercentSymbol then
    Result := Result + PercentSymbol;
end;

{ TdxfmStdPreview }

constructor TdxfmStdPreview.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLookAndFeel := TcxLookAndFeel.Create(nil);
  FExplorerContextCommandMenuItems := TList.Create;
  FExplorerContextCommandPopupMenuItems := TList.Create;
  FExplorerContextCommandToolButtons := TList.Create;
  InitializeLookAndFeel;
end;

destructor TdxfmStdPreview.Destroy;
begin
  SaveDefaultProperties;
  FreeAndNil(FExplorerContextCommandToolButtons);
  FreeAndNil(FExplorerContextCommandPopupMenuItems);
  FreeAndNil(FExplorerContextCommandMenuItems);
  FreeAndNil(FLookAndFeel);
  inherited Destroy;
end;

procedure TdxfmStdPreview.AfterConstruction;
begin
  FFlatCtrls := True;
  FLargeBtns := False;
  inherited AfterConstruction;
  ToolBar.HandleNeeded;
  ToolBar.Realign;
end;

procedure TdxfmStdPreview.Activate;
begin
  inherited Activate;
  Timer1.Enabled := True;
end;

procedure TdxfmStdPreview.DoShow;
begin
  inherited DoShow;
  ToolBar.Realign;
  ArrangeToolBarCtrls;
end;

procedure TdxfmStdPreview.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = Ord('Z')) and (ssAlt in Shift) and cbxPredefinedZoom.CanFocus then
    ActiveControl := cbxPredefinedZoom;
  if (Key = Ord('A')) and (ssAlt in Shift) and seActivePage.CanFocus then
    ActiveControl := seActivePage;
end;

procedure TdxfmStdPreview.ExplorerContextCommandClick(Sender: TObject);
var
  Command: TCustomdxPSExplorerContextCommand;
  CommandSet2: IdxPSExplorerContextCommands2;
begin
  Command := TCustomdxPSExplorerContextCommand(TTagToObj(TMenuItem(Sender).Tag));
  if Supports(TObject(Preview.Explorer), IdxPSExplorerContextCommands2, CommandSet2) then
  begin
    CommandSet2.InitializeCommand(Command);
    try
      if Command.Enabled then
        Command.Execute; {.1}
    finally
      CommandSet2.FinalizeCommand(Command);
    end;
  end;  
end;

procedure TdxfmStdPreview.InitializeLookAndFeel;
begin
  SetControlLookAndFeel(Self, LookAndFeel);
  SetControlLookAndFeel(cbxPredefinedZoom, LookAndFeel);
  SetControlLookAndFeel(seActivePage, LookAndFeel);
  LookAndFeel.NativeStyle := AreVisualStylesAvailable;
  LookAndFeel.Kind := lfStandard;
  LookAndFeel.SkinName := '';
end;

procedure TdxfmStdPreview.InitializeZoomComboBox;
var
  AItems: TStrings;
begin
  cbxPredefinedZoom.Properties.DropDownRows := Preview.PredefinedZooms.Count;
  AItems := cbxPredefinedZoom.Properties.Items;
  AItems.BeginUpdate;
  try
    AItems.Clear;
    AItems.Add('500' + PercentSymbol);
    AItems.Add('200' + PercentSymbol);
    AItems.Add('150' + PercentSymbol);
    AItems.Add('100' + PercentSymbol);
    AItems.Add('75' + PercentSymbol);
    AItems.Add('50' + PercentSymbol);
    AItems.Add('25' + PercentSymbol);
    AItems.Add('10' + PercentSymbol);
    AItems.Add(cxGetResourceString(@sdxPageWidth));
    AItems.Add(cxGetResourceString(@sdxWholePage));
    AItems.Add(cxGetResourceString(@sdxTwoPages));
    AItems.Add(cxGetResourceString(@sdxFourPages));
    AItems.Add(cxGetResourceString(@sdxWidenToSourceWidth));
  finally
    AItems.EndUpdate;
  end;
end;

procedure TdxfmStdPreview.LoadStrings;

  procedure SetHint(AButton: TControl; const AHint: string; AMenuItem: TMenuItem = nil);
  var
    S: string;
  begin
    if AMenuItem <> nil then
      S :=  ShortCutToText(AMenuItem.ShortCut)
    else
      S := AButton.Hint;
    AButton.Hint := AHint;
    if Length(S) > 0 then
      AButton.Hint := AButton.Hint + ' (' + S + ')';
  end;

begin
  inherited;
  
  { menus }
  miFile.Caption := cxGetResourceString(@sdxMenuFile);
  miFileDesign.Caption := cxGetResourceString(@sdxMenuFileDesign);
  miFileRebuild.Caption := cxGetResourceString(@sdxMenuFileRebuild);
  miFileSave.Caption := cxGetResourceString(@sdxMenuFileSave);
  miFileLoad.Caption := cxGetResourceString(@sdxMenuFileLoad);
  miFileClose.Caption := cxGetResourceString(@sdxMenuFileClose);
  miFilePrint.Caption := cxGetResourceString(@sdxMenuFilePrint);
  miFilePageSetup.Caption := cxGetResourceString(@sdxMenuFilePageSetup);
  miFilePrintStyles.Caption := cxGetResourceString(@sdxMenuPrintStyles);
  miExportToPDF.Caption := cxGetResourceString(@sdxMenuExportToPDF);
  pmiFilePrintStyles.Caption := cxGetResourceString(@sdxMenuPrintStyles);
  miFilePreferences.Caption := cxGetResourceString(@sdxMenuToolsOptions);
  miFileExit.Caption := cxGetResourceString(@sdxMenuFileExit);

  miExplorer.Caption := cxGetResourceString(@sdxMenuExplorer);
  miExplorerCreateNewFolder.Caption := cxGetResourceString(@sdxMenuExplorerCreateFolder);
  miExplorerDelete.Caption := cxGetResourceString(@sdxMenuExplorerDelete);
  miExplorerRename.Caption := cxGetResourceString(@sdxMenuExplorerRename);
  miExplorerProperties.Caption := cxGetResourceString(@sdxMenuExplorerProperties);
  
  miEdit.Caption := cxGetResourceString(@sdxMenuEdit);
  miEditFind.Caption := cxGetResourceString(@sdxMenuEditFind);
  miEditFindNext.Caption := cxGetResourceString(@sdxMenuEditFindNext);
  miEditReplace.Caption := cxGetResourceString(@sdxMenuEditReplace);

  miView.Caption := cxGetResourceString(@sdxMenuView);
  miViewMargins.Caption := cxGetResourceString(@sdxMenuViewMargins);
  miViewLargeTBtns.Caption := cxGetResourceString(@sdxMenuViewLargeToolBarButtons);
  miViewFlatTBtns.Caption := cxGetResourceString(@sdxMenuViewFlatToolBarButtons);
  miViewMarginBar.Caption := cxGetResourceString(@sdxMenuViewMarginsStatusBar);
  miViewStatusBar.Caption := cxGetResourceString(@sdxMenuViewPagesStatusBar);
  miViewExplorer.Caption := cxGetResourceString(@sdxMenuViewExplorer);
  miViewThumbnails.Caption := cxGetResourceString(@sdxMenuViewThumbnails);
  miViewZoom.Caption := cxGetResourceString(@sdxMenuZoom);
  miViewPageHeaders.Caption := cxGetResourceString(@sdxMenuViewPagesHeaders);
  miViewPageFooters.Caption := cxGetResourceString(@sdxMenuViewPagesFooters);

  miZoomPercent100.Caption := cxGetResourceString(@sdxMenuZoomPercent100);
  miZoomPageWidth.Caption := cxGetResourceString(@sdxMenuZoomPageWidth);
  miZoomWholePage.Caption := cxGetResourceString(@sdxMenuZoomWholePage);
  miZoomTwoPages.Caption := cxGetResourceString(@sdxMenuZoomTwoPages);
  miZoomFourPages.Caption := cxGetResourceString(@sdxMenuZoomFourPages);
  miZoomWidenToSourceWidth.Caption := cxGetResourceString(@sdxMenuZoomWidenToSourceWidth);
  miZoomSetup.Caption := cxGetResourceString(@sdxMenuZoomSetup);

  miFormat.Caption := cxGetResourceString(@sdxMenuFormat);
  miFormatTitle.Caption := cxGetResourceString(@sdxMenuFormatTitle);
  miFormatFootnotes.Caption := cxGetResourceString(@sdxMenuFormatFootnotes);
  miFormatShowHideEmptyPages.Caption := cxGetResourceString(@sdxMenuShowEmptyPages);
  miFormatAutoText.Caption := cxGetResourceString(@sdxMenuInsertEditAutoTextEntries);
  miFormatDateTime.Caption := cxGetResourceString(@sdxMenuFormatDateTime);
  miFormatPageNumbering.Caption := cxGetResourceString(@sdxMenuFormatPageNumbering);
  miFormatPageBackground.Caption := cxGetResourceString(@sdxMenuFormatPageBackground);
  miFormatShrinkToPageWidth.Caption := cxGetResourceString(@sdxMenuFormatShrinkToPage);

  miGotoPage.Caption := cxGetResourceString(@sdxMenuGotoPage);
  miGotoFirstPage.Caption := cxGetResourceString(@sdxMenuGotoPageFirst);
  miGotoPrevPage.Caption := cxGetResourceString(@sdxMenuGotoPagePrev);
  miGotoNextPage.Caption := cxGetResourceString(@sdxMenuGotoPageNext);
  miGotoLastPage.Caption := cxGetResourceString(@sdxMenuGotoPageLast);

  miHelp.Caption := cxGetResourceString(@sdxMenuHelp);
  miHelpTopics.Caption := cxGetResourceString(@sdxMenuHelpTopics);
  miHelpAbout.Caption := cxGetResourceString(@sdxMenuHelpAbout);

  { popup menus }
  pmiReportDesign.Caption := cxGetResourceString(@sdxMenuFileDesign);
  pmiPageSetup.Caption := cxGetResourceString(@sdxMenuFilePageSetup);
  pmiReportShrinkToPageWidth.Caption := cxGetResourceString(@sdxMenuFormatShrinkToPage);
  pmiZoom.Caption := cxGetResourceString(@sdxMenuZoom);
  pmiZoomPercent100.Caption := cxGetResourceString(@sdxMenuZoomPercent100);
  pmiZoomPageWidth.Caption := cxGetResourceString(@sdxMenuZoomPageWidth);
  pmiZoomWholePage.Caption := cxGetResourceString(@sdxMenuZoomWholePage);
  pmiZoomTwoPages.Caption := cxGetResourceString(@sdxMenuZoomTwoPages);
  pmiZoomFourPages.Caption := cxGetResourceString(@sdxMenuZoomFourPages);
  pmiZoomWidenToSourceWidth.Caption := cxGetResourceString(@sdxMenuZoomWidenToSourceWidth);

  pmiGotoFirstPage.Caption := cxGetResourceString(@sdxMenuGotoPageFirst);
  pmiGotoPrevPage.Caption := cxGetResourceString(@sdxMenuGotoPagePrev);
  pmiGotoNextPage.Caption := cxGetResourceString(@sdxMenuGotoPageNext);
  pmiGotoLastPage.Caption := cxGetResourceString(@sdxMenuGotoPageLast);

  pmiExplorerLoadData.Caption := cxGetResourceString(@sdxMenuFileLoad);
  pmiExplorerUnloadData.Caption := cxGetResourceString(@sdxMenuFileClose);
  pmiExplorerCreateFolder.Caption := cxGetResourceString(@sdxMenuExplorerCreateFolder);
  pmiExplorerDelete.Caption := cxGetResourceString(@sdxMenuExplorerDelete);
  pmiExplorerRename.Caption := cxGetResourceString(@sdxMenuExplorerRename);
  pmiExplorerProperties.Caption := cxGetResourceString(@sdxMenuExplorerProperties);

  pmiSmallThumbnails.Caption := cxGetResourceString(@sdxMenuThumbnailsSmall);
  pmiLargeThumbnails.Caption := cxGetResourceString(@sdxMenuThumbnailsLarge);
  
  pmiFlatBtns.Caption := cxGetResourceString(@sdxMenuViewFlatToolBarButtons);
  pmiLargeBtns.Caption := cxGetResourceString(@sdxMenuViewLargeToolBarButtons);

  { toolbar hints }
  SetHint(tbReportDesigner, cxGetResourceString(@sdxHintFileDesign), miFileDesign);
  tbPrint.Hint := cxGetResourceString(@sdxHintFilePrint) + dxPSPrVw.GetCurrentPrinterAsHint;
  SetHint(tbFileLoad, cxGetResourceString(@sdxHintFileLoad), miFileLoad);
  SetHint(tbFileUnload, cxGetResourceString(@sdxHintFileClose), miFileClose);
  SetHint(tbFileSave, cxGetResourceString(@sdxHintFileSave), miFileSave);
  SetHint(tbPrintDialog, cxGetResourceString(@sdxHintFilePrintDialog));
  SetHint(tbPageSetup, cxGetResourceString(@sdxHintFilePageSetup), miFilePageSetup);
  SetHint(tbPageBackground, cxGetResourceString(@sdxHintFormatPageBackground));
  SetHint(tbShrinkToPageWidth, cxGetResourceString(@sdxHintFormatShrinkToPage));
  SetHint(tbExportToPDF, cxGetResourceString(@sdxHintExportToPDF));

  SetHint(tbViewExplorer, cxGetResourceString(@sdxHintViewExplorer), miViewExplorer);
  SetHint(tbViewThumbnails, cxGetResourceString(@sdxHintViewThumbnails), miViewThumbnails);
    
  SetHint(cbxPredefinedZoom, cxGetResourceString(@sdxHintViewZoom));
  SetHint(tbPercent100, cxGetResourceString(@sdxHintZoomPercent100), miZoomPercent100);
  SetHint(tbPageWidth, cxGetResourceString(@sdxHintZoomPageWidth), miZoomPageWidth);
  SetHint(tbOnePage, cxGetResourceString(@sdxHintZoomWholePage), miZoomWholePage);
  SetHint(tbTwoPage, cxGetResourceString(@sdxHintZoomTwoPages), miZoomTwoPages);
  SetHint(tbFourPage, cxGetResourceString(@sdxHintZoomFourPages), miZoomFourPages);
  SetHint(tbMultiplePages, cxGetResourceString(@sdxHintZoomMultiplyPages));
  SetHint(tbWidenToSourceWidth, cxGetResourceString(@sdxHintZoomWidenToSourceWidth), miZoomWidenToSourceWidth);

  SetHint(tbGotoFirstPage, cxGetResourceString(@sdxHintGotoPageFirst), pmiGotoFirstPage);
  SetHint(tbGotoPrevPage, cxGetResourceString(@sdxHintGotoPagePrev), pmiGotoPrevPage);
  SetHint(tbGotoNextPage, cxGetResourceString(@sdxHintGotoPageNext), pmiGotoNextPage);
  SetHint(tbGotoLastPage, cxGetResourceString(@sdxHintGotoPageLast), pmiGotoLastPage);
  SetHint(seActivePage, cxGetResourceString(@sdxHintActivePage));

  SetHint(tbHelp, cxGetResourceString(@sdxHintHelpTopics), miHelp);
  SetHint(tbClose, cxGetResourceString(@sdxHintFileExit), miFileExit);
end;

function TdxfmStdPreview.CalculateWindowPos(Sender: TObject): TPoint;
var
  R: TRect;
begin
  if Sender is TToolButton then
  begin
    R := TToolButton(Sender).BoundsRect;
    MapWindowPoints(ToolBar.Handle, 0, R, 2);
    Result.X := R.Left;
    Result.Y := R.Bottom;
  end
  else
    Result := Preview.ClientOrigin;
end;

procedure TdxfmStdPreview.CheckItem(AParent: TMenuItem);
var
  Style: TBasedxPrintStyle;
  I: Integer;
  Item: TMenuItem;
begin
  if Preview.CanPrintStyle then 
  begin
    Style := Preview.ReportLink.StyleManager.CurrentStyle;
    for I := 0 to AParent.Count - 1 do 
    begin
      Item := AParent[I];
      if TTagToObj(Item.Tag) = Style then 
      begin
        Item.Checked := True;
        Exit;
      end;
    end;  
  end;  
end;

function TdxfmStdPreview.CreateLargeImages(ASource: TCustomImageList): TImageList;

  procedure DrawItem(ABitmap: TBitmap; AnImageIndex: Integer; const ASourceBounds, ADestBounds: TRect);
  var
    B: TBitmap;
  begin
    B := TBitmap.Create;
    try
      with ASourceBounds do 
      begin
        B.Width := Right - Left;
        B.Height := Bottom - Top;
      end;
      B.Canvas.Brush.Color := clFuchsia;
      B.Canvas.FillRect(ASourceBounds);
      ASource.Draw(B.Canvas, 0, 0, AnImageIndex);
      ABitmap.Canvas.CopyRect(ADestBounds, B.Canvas, ASourceBounds);
    finally
      B.Free;
    end;  
  end;
  
var
  DestBounds, SourceBounds: TRect;  
  Image: TBitmap;
  I: Integer;
begin
  Result := TImageList.Create(Self);

  Result.Width := 2 * ASource.Width; 
  Result.Height := 2 * ASource.Height;
  Result.AllocBy := ASource.Count;

  DestBounds := Bounds(0, 0, Result.Width, Result.Height);
  SourceBounds := Bounds(0, 0, ASource.Width, ASource.Height);
  
  Image := TBitmap.Create;
  try   
    Image.Width := Result.Width;
    Image.Height := Result.Height;
    for I := 0 to ASource.Count - 1 do
    begin          
      DrawItem(Image, I, SourceBounds, DestBounds);
      Result.AddMasked(Image, clDefault);
    end;
  finally
    Image.Free;
  end;
end;

function TdxfmStdPreview.GetExplorerContextCommandMenuItem(Index: Integer): TMenuItem;
begin
  Result := TMenuItem(FExplorerContextCommandMenuItems.Items[Index]);
end;

function TdxfmStdPreview.GetExplorerContextCommandMenuItemCount: Integer;
begin
  Result := FExplorerContextCommandMenuItems.Count;
end;

function TdxfmStdPreview.GetExplorerContextCommandPopupMenuItem(Index: Integer): TMenuItem;
begin
  Result := TMenuItem(FExplorerContextCommandPopupMenuItems.Items[Index]);
end;

function TdxfmStdPreview.GetExplorerContextCommandPopupMenuItemCount: Integer;
begin
  Result := FExplorerContextCommandPopupMenuItems.Count;
end;

function TdxfmStdPreview.GetExplorerContextCommandToolButton(Index: Integer): TToolButton;
begin
  Result := TToolButton(FExplorerContextCommandToolButtons.Items[Index]);
end;

function TdxfmStdPreview.GetExplorerContextCommandToolButtonCount: Integer;
begin
  Result := FExplorerContextCommandToolButtons.Count;
end;

procedure TdxfmStdPreview.SetFlatCtrls(Value: Boolean);
begin
  if FFlatCtrls <> Value then
  begin
    FFlatCtrls := Value;
    SetupFlatCtrls;
    UpdateControls;
  end;
end;

procedure TdxfmStdPreview.SetLargeBtns(Value: Boolean);
begin
  if FLargeBtns <> Value then
  begin
    FLargeBtns := Value;
    AssignToolBarImages;
    ArrangeToolBarCtrls;
    UpdateControls;
  end;
end;

procedure TdxfmStdPreview.UpdateControls;
begin
  if not Preview.Locked then
    Preview.UpdateControls;
end;

function TdxfmStdPreview.GetReportLink: TBasedxReportLink;
begin
  Result := Preview.ReportLink;
end;

function TdxfmStdPreview.GetToolBarImageList: TCustomImageList;
begin
  if LargeBtns then
    Result := FilToolBarLarge
  else
    Result := ilToolBarSmall;
end;

function TdxfmStdPreview.GetLocked: Boolean;
begin
  Result := Preview.Locked;
end;

procedure TdxfmStdPreview.AssignToolBarImages;
begin
  ToolBar.Images := ToolBarImageList;
  if ToolBarImageList = nil then
    cbxPredefinedZoom.Properties.ItemHeight := 18
  else
    cbxPredefinedZoom.Properties.ItemHeight := 2 + ToolBarImageList.Height;
end;

procedure TdxfmStdPreview.ArrangeToolBarCtrls;
const
  Widths: array[Boolean] of Integer = (140, 160);
begin
  ToolBar.Height := ToolBarHeight[FLargeBtns];
  ToolBar.ButtonWidth := ToolBtnSize[FLargeBtns].cx;
  ToolBar.ButtonHeight := ToolBtnSize[FLargeBtns].cy;
  pnlPredefinedZoom.Width := Widths[LargeBtns];
end;

procedure TdxfmStdPreview.SetupFlatCtrls;
const
  LookAndFeelKindMap: array[Boolean] of TcxLookAndFeelKind = (lfStandard, lfUltraFlat);
begin
  LookAndFeel.Kind := LookAndFeelKindMap[FlatCtrls];
  ToolBar.Flat := FlatCtrls;
end;

procedure TdxfmStdPreview.miViewMarginsClick(Sender: TObject);
begin
  if not Locked then
    Preview.ShowPageMargins := not Preview.ShowPageMargins;
end;

procedure TdxfmStdPreview.pmiFlatBtnsClick(Sender: TObject);
begin
  if not Locked then
    FlatCtrls := not FlatCtrls;
end;

procedure TdxfmStdPreview.pmiLargeBtnsClick(Sender: TObject);
begin
  if Locked then Exit;
  LargeBtns := not LargeBtns;
  if Assigned(Preview) then
    Preview.Invalidate;
end;

procedure TdxfmStdPreview.miViewMarginBarClick(Sender: TObject);
begin
  if not Locked then
    Preview.ShowMarginBar := not Preview.ShowMarginBar;
end;

procedure TdxfmStdPreview.miViewStatusBarClick(Sender: TObject);
begin
  if not Locked then
    Preview.ShowStatusBar := not Preview.ShowStatusBar;
end;

procedure TdxfmStdPreview.DesignClick(Sender: TObject);
begin
  tbReportDesigner.Down := True;
  try
    Preview.DoDesignReport;
  finally
    tbReportDesigner.Down := False;
  end;
end;

procedure TdxfmStdPreview.miFileRebuildClick(Sender: TObject);
begin
  Preview.RebuildReport;
end;

procedure TdxfmStdPreview.PageBackgroundClick(Sender: TObject);
begin
  tbPageBackground.Down := True;
  try
    Preview.DoShowPageBackgroundDlg(CalculateWindowPos(Sender));
  finally
    tbPageBackground.Down := False;
  end;
end;

procedure TdxfmStdPreview.PrintClick(Sender: TObject);
const
  BtnClicked: Boolean = False;
begin
  if BtnClicked then Exit;
  BtnClicked := True;
  try
    tbPrintDialog.Down := True;
    try
      Preview.DoPrintReport(Boolean(TTagToInt(TComponent(Sender).Tag)));
    finally
      tbPrintDialog.Down := False;
    end;
  finally
    BtnClicked := False;
  end;
end;

procedure TdxfmStdPreview.PageSetupClick(Sender: TObject);
const
  BtnClicked: Boolean = False;
begin
  if BtnClicked then Exit;
  BtnClicked := True;
  try
    tbPageSetup.Down := True;
    try
      Preview.DoPageSetupReport(0);
    finally
      tbPageSetup.Down := False;
    end;
  finally
    BtnClicked := False;
  end;
end;

procedure TdxfmStdPreview.ZoomClick(Sender: TObject);
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
      4: begin
          PageXCount := 2;
          PageYCount := 2;
        end;
      5: ReportLink.GetPageColRowCount(PageXCount, PageYCount);
    end;
  end;
  Preview.DoSetupZoomFactor(100, PageXCount, PageYCount, ZoomMode);
end;

procedure TdxfmStdPreview.ShrinkToPageWidthClick(Sender: TObject);
begin
  if Locked then Exit;
  if ReportLink <> nil then
  begin
    ReportLink.ShrinkToPageWidth := not ReportLink.ShrinkToPageWidth;
    Preview.DoShrinkToPageWidth(ReportLink.ShrinkToPageWidth);
  end;
end;

procedure TdxfmStdPreview.miFormatShowHideEmptyPagesClick(Sender: TObject);
begin
  if Locked then Exit;
  TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
  Preview.DoShowEmptyPages(TMenuItem(Sender).Checked);
end;

procedure TdxfmStdPreview.miZoomSetupClick(Sender: TObject);
begin
  Preview.DoShowZoomDlg;
end;

procedure TdxfmStdPreview.tbMultiplePagesClick(Sender: TObject);
var
  Origin: TPoint;
  YShift: Integer;
begin
  Origin := TToolButton(Sender).ClientOrigin;
  YShift := TToolButton(Sender).Height;

  tbMultiplePages.Down := True;
  try
    Preview.DoShowMultiplySelectPagesDlg(ilStub, 1, Origin, YShift);
  finally
    tbMultiplePages.Down := False;
  end;
end;

procedure TdxfmStdPreview.GoToPageClick(Sender: TObject);
begin
  case TTagToInt(TComponent(Sender).Tag) of
    0: Preview.GoToFirstPage;
    1: Preview.GoToPrevPage;
    2: Preview.GoToNextPage;
    3: Preview.GoToLastPage;
  end;
end;

procedure TdxfmStdPreview.CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TdxfmStdPreview.HelpClick(Sender: TObject);
begin
  Preview.DoInvokeHelp;
end;

procedure TdxfmStdPreview.cbxPredefinedZoomClick(Sender: TObject);
begin
  Preview.SetZoomFactorByText(cbxPredefinedZoom.Text);
  UpdateControls;
  cbxPredefinedZoom.Text := AddPercentSign(IntToStr(Preview.ZoomFactor));
end;

procedure TdxfmStdPreview.cbxPredefinedZoomKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) or (Key = VK_ESCAPE) then
    Windows.SetFocus(Preview.Handle);
end;

procedure TdxfmStdPreview.seActivePageExit(Sender: TObject);
begin
  if not Locked then
    Preview.DoActivePageChanged(seActivePage.Value - 1);
end;

procedure TdxfmStdPreview.seKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Char(VK_RETURN) then
    seActivePageExit(Sender);
end;

procedure TdxfmStdPreview.OptionsClick(Sender: TObject);
begin
  Preview.DoShowOptionsDlg;
end;

procedure TdxfmStdPreview.LoadDefaultProperties;
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

procedure TdxfmStdPreview.SaveDefaultProperties;
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

procedure TdxfmStdPreview.LoadProperties(
  AIniFile: TCustomIniFile; const ASectionName: string);
begin
  FlatCtrls := AIniFile.ReadBool(ASectionName, sdxFlatCtrls, FlatCtrls);
  LargeBtns := AIniFile.ReadBool(ASectionName, sdxLargeBtns, LargeBtns);
end;

procedure TdxfmStdPreview.SaveProperties(
  AIniFile: TCustomIniFile; const ASectionName: string);
begin
  AIniFile.WriteBool(ASectionName, sdxFlatCtrls, FlatCtrls);
  AIniFile.WriteBool(ASectionName, sdxLargeBtns, LargeBtns);
end;

procedure TdxfmStdPreview.DoShowExplorerPopup(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then 
    pmExplorer.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TdxfmStdPreview.pmToolBarPopup(Sender: TObject);
begin
  pmiFlatBtns.Checked := FlatCtrls;
  pmiLargeBtns.Checked := LargeBtns;
end;

procedure TdxfmStdPreview.pmPreviewPopup(Sender: TObject);
begin
  pmiReportDesign.Enabled := miFileDesign.Enabled;
  pmiReportDesign.Visible := miFileDesign.Visible;
  pmiPageSetup.Enabled := miFilePageSetup.Enabled;
  pmiPageSetup.Visible := miFilePageSetup.Visible;
  pmiFilePrintStyles.Visible := Preview.CanPrintStyle;
  CheckItem(pmiFilePrintStyles);
  miLine11.Visible := pmiReportDesign.Visible;
  pmiReportShrinkToPageWidth.Checked := miFormatShrinkToPageWidth.Checked;
  pmiReportShrinkToPageWidth.Enabled := miFormatShrinkToPageWidth.Enabled;
  pmiZoom.Enabled := Preview.Preview.PageCount > 0;
  pmiZoomPercent100.Enabled := miZoomPercent100.Enabled;
  pmiZoomPageWidth.Enabled := miZoomPageWidth.Enabled;
  pmiZoomWholePage.Enabled := miZoomWholePage.Enabled;
  pmiZoomTwoPages.Enabled := miZoomTwoPages.Enabled;
  pmiZoomFourPages.Enabled := miZoomFourPages.Enabled;
  pmiZoomWidenToSourceWidth.Enabled := miZoomWidenToSourceWidth.Enabled;
  pmiGotoFirstPage.Enabled := miGotoFirstPage.Enabled;
  pmiGotoPrevPage.Enabled := miGotoPrevPage.Enabled;
  pmiGotoNextPage.Enabled := miGotoNextPage.Enabled;
  pmiGotoLastPage.Enabled := miGotoLastPage.Enabled;
end;

procedure TdxfmStdPreview.pmPrintStylesPopup(Sender: TObject);
begin
  CheckItem(TPopupMenu(Sender).Items);
end;

procedure TdxfmStdPreview.miFormatAutoTextClick(Sender: TObject);
begin
  if Preview.IsAutoHFTextEntriesAvailable then
    ReportLink.StyleManager.ShowAutoHFTextEntriesDlg;
end;

procedure TdxfmStdPreview.miFormatDateTimeClick(Sender: TObject);
begin
  Preview.DoShowFormatDateTimeDlg;
end;

procedure TdxfmStdPreview.miFormatPageNumberingClick(Sender: TObject);
begin
  Preview.DoShowFormatPageNumbersDlg;
end;

procedure TdxfmStdPreview.miViewPageHeadersClick(Sender: TObject);
begin
  if not Locked then
    with TMenuItem(Sender) do
    begin
      Checked := not Checked;
      Preview.DoShowPageHeaders(Checked);
    end;
end;

procedure TdxfmStdPreview.miViewPageFootersClick(Sender: TObject);
begin
  if Locked then Exit;
  with TMenuItem(Sender) do
  begin
    Checked := not Checked;
    Preview.DoShowPageFooters(Checked);
  end;
end;

procedure TdxfmStdPreview.ViewExplorerClick(Sender: TObject);
begin
  if not Locked then 
    Preview.ShowExplorer := not Preview.ShowExplorer;
end;

procedure TdxfmStdPreview.ViewThumbnailsClick(Sender: TObject);
begin
  if not Locked then 
    Preview.ShowThumbnails := not Preview.ShowThumbnails;
end;

procedure TdxfmStdPreview.Timer1Timer(Sender: TObject);
begin
  tbPrint.Hint := cxGetResourceString(@sdxHintFilePrint) + GetCurrentPrinterAsHint;
  TTimer(Sender).Enabled := False;
end;

procedure TdxfmStdPreview.FileSaveClick(Sender: TObject);
const
  BtnClicked: Boolean = False;
begin
  if not BtnClicked then
  begin
    BtnClicked := True;
    try
      if Preview.IsExplorerAvailable then
        Preview.DoExplorerCreateNewItem
      else
      begin
        tbFileSave.Down := True;
        try
          Preview.DoExplorerCreateNewItem;
        finally
          tbFileSave.Down := False;
        end;
      end;
    finally
      BtnClicked := False;
    end;
  end;
end;

procedure TdxfmStdPreview.ExplorerCreateNewFolderClick(Sender: TObject);
begin
  Preview.DoExplorerCreateNewFolder;
end;

procedure TdxfmStdPreview.ExplorerDeleteClick(Sender: TObject);
begin
  Preview.DoExplorerDeleteItem;
end;

procedure TdxfmStdPreview.ExplorerRenameClick(Sender: TObject);
begin
  Preview.DoExplorerRenameItem;
end;

procedure TdxfmStdPreview.ExplorerPropertiesClick(Sender: TObject);
begin
  Preview.DoExplorerItemShowPropertySheets;
end;

procedure TdxfmStdPreview.FileLoadClick(Sender: TObject);
const
  BtnClicked: Boolean = False;
begin
  if not BtnClicked then
  begin
    BtnClicked := True;
    try
      if Preview.IsExplorerAvailable then
        Preview.DoExplorerLoadItemData
      else
      begin
        tbFileLoad.Down := True;
        try
          Preview.DoExplorerLoadItemData;
        finally
          tbFileLoad.Down := False;
        end;
      end;
    finally
      BtnClicked := False;
    end;
  end;
end;

procedure TdxfmStdPreview.FileCloseClick(Sender: TObject);
begin
  Preview.DoExplorerUnloadItemData;
end;

procedure TdxfmStdPreview.pmExplorerPopup(Sender: TObject);
begin
  Preview.UpdateExplorerContextCommands;            
  pmiExplorerLoadData.Enabled := Preview.CanLoadReport;
  pmiExplorerUnloadData.Enabled := Preview.CanUnloadReport;
  pmiExplorerCreateFolder.Enabled := Preview.IsExplorerAvailable and Preview.ExplorerTree.CanCreateFolder;
  pmiExplorerDelete.Enabled := Preview.IsExplorerAvailable and Preview.ExplorerTree.CanDeleteSelection;
  pmiExplorerRename.Enabled := Preview.IsExplorerAvailable and Preview.ExplorerTree.CanRenameSelectedItem;
  pmiExplorerProperties.Enabled := Preview.IsExplorerAvailable and Preview.ExplorerTree.CanShowPropertySheetsForSelectedItem;
end;                                                                    

procedure TdxfmStdPreview.miFormatTitleClick(Sender: TObject);
begin
  Preview.DoFormatTitle;
end;

procedure TdxfmStdPreview.miFormatFootnotesClick(Sender: TObject);
begin
  Preview.DoFormatFootnotes;
end;

procedure TdxfmStdPreview.pmiThumbnailsSizeClick(Sender: TObject);
begin
  Preview.ThumbnailsSize := TdxPSThumbnailsSize(TTagToInt(TComponent(Sender).Tag));
end;

procedure TdxfmStdPreview.pmThumbnailsPopup(Sender: TObject);
begin
  if Preview.ThumbnailsSize = tsSmall then
    pmiSmallThumbnails.Checked := True
  else
    pmiLargeThumbnails.Checked := True;
end;

procedure TdxfmStdPreview.WMInitMenu(var Message: TWMInitMenu);
begin
  inherited;
  CheckItem(miFilePrintStyles);
end;

procedure TdxfmStdPreview.cbxPredefinedZoomPropertiesCloseUp(Sender: TObject);
begin
  Windows.SetFocus(Preview.Handle);
end;

procedure TdxfmStdPreview.cbxPredefinedZoomPropertiesDrawItem(
  AControl: TcxCustomComboBox; ACanvas: TcxCanvas; AIndex: Integer;
  const ARect: TRect; AState: TOwnerDrawState);
var
  R: TRect;
begin
  R := ARect;
  ACanvas.FillRect(R, clDefault);
  if Assigned(ToolBarImageList) then
  begin
    if ZoomItemIndexes[AIndex] >= 0 then
      ToolBarImageList.Draw(ACanvas.Canvas, R.Left + 2, R.Top + 2, ZoomItemIndexes[AIndex]);
    Inc(R.Left, ToolBarImageList.Width + 5);
  end;
  ACanvas.Brush.Style := bsClear;
  ACanvas.DrawTexT(AControl.Properties.Items[AIndex], R, cxAlignVCenter or cxAlignLeft);
end;

procedure TdxfmStdPreview.miExportToPDFClick(Sender: TObject);
begin
  dxPSExportToPDF(ReportLink);
end;

procedure TdxfmStdPreview.PreviewAddExplorerCommand(
  Sender: TObject; ACommand: TCustomdxPSExplorerContextCommand);

  function IsCommandSeparator(ACommand: TCustomdxPSExplorerContextCommand): Boolean;
  begin
    Result := ACommand is TdxPSExplorerContextCommandSeparator;
  end;
   
  function AddExplorerContextCommandMenuItem(
    AParent: TMenuItem; ACommand: TCustomdxPSExplorerContextCommand): TMenuItem;
  begin
    Result := TMenuItem.Create(Self);
    Result.Caption := ACommand.Caption;
    Result.Enabled := ACommand.Enabled;
    Result.Hint := ACommand.Hint;
    Result.ShortCut := ACommand.ShortCut;
    Result.Tag := MakeTTag(ACommand);
    Result.OnClick := ExplorerContextCommandClick;
    Result.ImageIndex := ilToolBarSmall.AddMasked(ACommand.Bitmap, ACommand.Bitmap.TransparentColor);
    AParent.Insert(0, Result);
  end;

var
  MenuItem: TMenuItem; 
begin
  MenuItem := AddExplorerContextCommandMenuItem(pmExplorer.Items, ACommand);
  if not IsCommandSeparator(ACommand) and (FExplorerContextCommandPopupMenuItems.IndexOf(MenuItem) = -1) then
    FExplorerContextCommandPopupMenuItems.Add(MenuItem);

  MenuItem := AddExplorerContextCommandMenuItem(miExplorer, ACommand);
  if not IsCommandSeparator(ACommand) and (FExplorerContextCommandMenuItems.IndexOf(MenuItem) = -1) then
    FExplorerContextCommandMenuItems.Add(MenuItem);
end;

procedure TdxfmStdPreview.PreviewUpdateExplorerCommands(Sender: TObject);

  procedure UpdateMenuItems;
  var
    I: Integer;
  begin
    for I := 0 to ExplorerContextCommandMenuItemCount - 1 do
      with ExplorerContextCommandMenuItems[I] do 
        Enabled := TCustomdxPSExplorerContextCommand(TTagToObj(Tag)).Enabled;
  end;

  procedure UpdatePopupMenuItems;
  var
    I: Integer;
  begin
    for I := 0 to ExplorerContextCommandPopupMenuItemCount - 1 do
      with ExplorerContextCommandPopupMenuItems[I] do 
        Enabled := TCustomdxPSExplorerContextCommand(TTagToObj(Tag)).Enabled;
  end;
    
  procedure UpdateToolButtons;
  var
    I: Integer;
  begin
    for I := 0 to ExplorerContextCommandToolButtonCount - 1 do
      with ExplorerContextCommandToolButtons[I] do 
        Enabled := TCustomdxPSExplorerContextCommand(TTagToObj(Tag)).Enabled;
  end;
  
begin
  if not (csDestroying in ComponentState) then
  begin
    UpdateMenuItems;
    UpdatePopupMenuItems;
    UpdateToolButtons;
  end;  
end;

procedure TdxfmStdPreview.PreviewAfterCreateControls;
begin
  InitializeZoomComboBox;
  FilToolBarLarge := CreateLargeImages(ilToolBarSmall);
  ArrangeToolBarCtrls;
  AssignToolBarImages;
  SetupFlatCtrls;
  
  pmToolBar.OwnerDraw := True;
  pmToolBar.Images := ilToolBarSmall;

  pmPrintStyles.OwnerDraw := True;
  pmPrintStyles.Images := ilToolBarSmall;

  Menu.Images := ilToolBarSmall;
  pmPreview.Images := ilToolBarSmall;

  miFileDesign.ImageIndex := 0;
  miFileSave.ImageIndex := 19;
  miFileLoad.ImageIndex := 23;
  miFileClose.ImageIndex := 24;
  miFilePrint.ImageIndex := 2;
  miFilePageSetup.ImageIndex := 3;
  miFormatPageBackground.ImageIndex := 4;
  miFormatShrinkToPageWidth.ImageIndex := 12;

  miExplorerCreateNewFolder.ImageIndex := 20;
  miExplorerDelete.ImageIndex := 22;
  miExplorerProperties.ImageIndex := 29;

  miViewExplorer.ImageIndex := 30;
  miViewThumbnails.ImageIndex := 31;
  
  miZoomPercent100.ImageIndex := 5;
  miZoomPageWidth.ImageIndex := 6;
  miZoomWholePage.ImageIndex := 7;
  miZoomTwoPages.ImageIndex := 8;
  miZoomFourPages.ImageIndex := 9;
  miZoomWidenToSourceWidth.ImageIndex := 11;

  miFormatTitle.ImageIndex := 26;
  miFormatDateTime.ImageIndex := 28;
  miFormatPageNumbering.ImageIndex := 29;
  
  miGoToFirstPage.ImageIndex := 13;
  miGoToPrevPage.ImageIndex := 14;
  miGoToNextPage.ImageIndex := 15;
  miGoToLastPage.ImageIndex := 16;
  miHelpTopics.ImageIndex := 17;
  
  pmDesigners.OwnerDraw := True;
  pmDesigners.Images := ilToolBarSmall;
  
  pmiReportDesign.ImageIndex := 0;
  pmiPageSetup.ImageIndex := 3;
  pmiReportShrinkToPageWidth.ImageIndex := 12;

  pmiZoomPercent100.ImageIndex := 5;
  pmiZoomPageWidth.ImageIndex := 6;
  pmiZoomWholePage.ImageIndex := 7;
  pmiZoomTwoPages.ImageIndex := 8;
  pmiZoomFourPages.ImageIndex := 9;
  pmiZoomWidenToSourceWidth.ImageIndex := 11;

  pmiGoToFirstPage.ImageIndex := 13;
  pmiGoToPrevPage.ImageIndex := 14;
  pmiGoToNextPage.ImageIndex := 15;
  pmiGoToLastPage.ImageIndex := 16;

  pmExplorer.OwnerDraw := True;
  pmiExplorerLoadData.ImageIndex := 23;
  pmiExplorerUnloadData.ImageIndex := 24;
  pmiExplorerCreateFolder.ImageIndex := 20;
  pmiExplorerDelete.ImageIndex := 22;
  pmiExplorerProperties.ImageIndex := 29; 

  pmThumbnails.Images := ilStub;
end;

procedure TdxfmStdPreview.PreviewSaveProperties(Sender: TObject;
  AIniFile: TCustomIniFile; const ASectionName: string);
begin
  SaveProperties(AIniFile, dxPSFormGetActualSectionName(Self, ASectionName));
end;

procedure TdxfmStdPreview.PreviewStyleListChanged(Sender: TObject);
begin
  with ReportLink do
  begin
    BuildPageSetupMenu(pmPrintStyles.Items, nil, True);
    BuildPageSetupMenu(miFilePrintStyles, nil, True);
    BuildPageSetupMenu(pmiFilePrintStyles, nil, True);
  end;
end;

procedure TdxfmStdPreview.PreviewInitContent(Sender: TObject);
begin
  Preview.ThumbnailsPreview.PopupMenu := pmThumbnails;
  if Preview.IsExplorerAvailable then
    TControlAccess(Preview.ExplorerTree.Control).OnMouseUp := DoShowExplorerPopup;

  if Preview.ComponentPrinter <> nil then
    seActivePage.Properties.MaxValue := ReportLink.PageCount;
  cbxPredefinedZoom.Text := IntToStr(Preview.ZoomFactor) + PercentSymbol;

  if not Preview.IsExplorerAvailable then
  begin
    miFileSave.Caption := dxPSUtl.AddEndEllipsis(miFileSave.Caption);
    miFileLoad.Caption := dxPSUtl.AddEndEllipsis(miFileLoad.Caption);
  end;
end;

procedure TdxfmStdPreview.PreviewLoadProperties(
  Sender: TObject; AIniFile: TCustomIniFile; const ASectionName: string);
begin
  LoadProperties(AIniFile, dxPSFormGetActualSectionName(Self, ASectionName));
end;

procedure TdxfmStdPreview.PreviewAfterPrintReport(Sender: TObject; AShowDialog: Boolean);
begin
  if AShowDialog then
    tbPrint.Hint := cxGetResourceString(@sdxHintFilePrint) + GetCurrentPrinterAsHint;
end;

procedure TdxfmStdPreview.PreviewZoomFactorChanged(Sender: TObject);
begin
  cbxPredefinedZoom.Text := AddPercentSign(IntToStr(Preview.ZoomFactor));
end;

procedure TdxfmStdPreview.PreviewZoomModeChanged(Sender: TObject);
begin
  cbxPredefinedZoom.Text := AddPercentSign(IntToStr(Preview.ZoomFactor));
end;

procedure TdxfmStdPreview.PreviewUpdateControls(Sender: TObject);
const
  ButtonStyles: array[Boolean] of TToolButtonStyle = (tbsButton, tbsDropDown);
var
  HasPages: Boolean;
  PrevStyle: TToolButtonStyle;
begin
  if not Locked then
  begin
    HasPages := Preview.Preview.PageCount > 0;
    Preview.BeginUpdate;
    try
      { toolbar enabled }
      tbReportDesigner.Enabled := Preview.CanDesign;
      tbFileLoad.Enabled := Preview.CanLoadReport;
      tbFileUnload.Enabled := Preview.CanUnloadReport;
      tbFileSave.Enabled := Preview.CanSaveReport;
      tbExportToPDF.Enabled := Preview.CanExport;
      tbPrint.Enabled := Preview.CanPrint;
      tbPrintDialog.Enabled := Preview.CanPrintDialog;
      tbPageSetup.Enabled := Preview.CanPageSetup;
      tbExportToPDF.Enabled := Preview.CanExport;
      PrevStyle := tbPageSetup.Style;
      tbPageSetup.Style := ButtonStyles[Preview.CanPrintStyle];
      if PrevStyle <> tbPageSetup.Style then 
        if tbPageSetup.Style = tbsButton then 
        begin
          tbPageSetup.Width := ToolBtnSize[LargeBtns].cx;
          SendMessage(ToolBar.Handle, CM_RECREATEWND, 0, 0);
          tbPageSetup.DropDownMenu := nil;
        end
        else
          tbPageSetup.DropDownMenu := pmPrintStyles;
      
      tbClose.Enabled := not Preview.IsPrinting;

      tbPageBackground.Enabled := Preview.IsEnabled(peoPageBackground) and not Preview.IsPrinting;
      tbShrinkToPageWidth.Enabled := HasPages and not Preview.IsPrinting;

      tbViewExplorer.Visible := Preview.IsExplorerAvailable;
      tbViewExplorer.Down := Preview.ShowExplorer;
      tbViewThumbnails.Down := Preview.ShowThumbnails;

      tbPercent100.Enabled := HasPages;
      tbPageWidth.Enabled := HasPages;
      tbOnePage.Enabled := HasPages;
      tbTwoPage.Enabled := (Preview.PageCount > 1);
      tbFourPage.Enabled := (Preview.PageCount > 3);
      tbMultiplePages.Enabled := HasPages;
      tbWidenToSourceWidth.Enabled := HasPages and not Preview.IsPrinting;
      if ReportLink <> nil then
        tbShrinkToPageWidth.Down := ReportLink.ShrinkToPageWidth;
      cbxPredefinedZoom.Enabled := HasPages;

      tbGoToFirstPage.Enabled := HasPages and (Preview.Preview.SelPageIndex <> 0);
      tbGoToPrevPage.Enabled := HasPages and (Preview.Preview.SelPageIndex <> 0);
      tbGoToNextPage.Enabled := HasPages and (Preview.Preview.SelPageIndex <> Preview.PageCount - 1);
      tbGoToLastPage.Enabled := HasPages and (Preview.Preview.SelPageIndex <> Preview.PageCount - 1);
      seActivePage.Enabled := Preview.PageCount > 1;

      tbHelp.Enabled := Preview.IsEnabled(peoHelp);

      { menus enabled}
      miFileDesign.Enabled := tbReportDesigner.Enabled;
      miFileRebuild.Enabled := Preview.CanRebuild;
      miFileSave.Enabled := tbFileSave.Enabled;
      miFileLoad.Enabled := tbFileLoad.Enabled;
      miFileClose.Enabled := tbFileUnload.Enabled;
      miFilePrint.Enabled := tbPrint.Enabled;
      miFilePageSetup.Enabled := tbPageSetup.Enabled;
      miFilePrintStyles.Enabled := tbPageSetup.Enabled;
      miFilePreferences.Enabled := Preview.IsEnabled(peoPreferences);
      miFileExit.Enabled := tbClose.Enabled;
      miExportToPDF.Enabled := Preview.CanExport;

      if miFileDesign.Enabled and (ReportLink <> nil) then
        miFileDesign.Enabled := Preview.IsEnabled(peoReportDesign) and
          HasPages and ReportLink.CheckToDesign;

      miExplorer.Enabled := Preview.IsExplorerAvailable;
      miExplorerCreateNewFolder.Enabled := Preview.IsExplorerAvailable and Preview.ExplorerTree.CanCreateFolder;
      miExplorerDelete.Enabled := Preview.IsExplorerAvailable and Preview.ExplorerTree.CanDeleteSelection;
      if miExplorerDelete.Enabled then
        miExplorerDelete.ShortCut := ShortCut(VK_DELETE, [])
      else
        miExplorerDelete.ShortCut := 0;  
      miExplorerRename.Enabled := Preview.IsExplorerAvailable and Preview.ExplorerTree.CanRenameSelectedItem;
      miExplorerProperties.Enabled := Preview.IsExplorerAvailable and Preview.ExplorerTree.CanShowPropertySheetsForSelectedItem;
    
      miFormatAutoText.Enabled := Preview.IsAutoHFTextEntriesAvailable;
      miFormatTitle.Enabled := ReportLink.CanChangeTitle;
      miFormatFootnotes.Enabled := ReportLink.CanChangeFootnotes;
      miFormatPageBackground.Enabled := tbPageBackground.Enabled;
      miFormatShowHideEmptyPages.Enabled := HasPages and not (Preview.IsBuilding or Preview.IsPrinting);
      if ReportLink <> nil then
      begin                                  
        miFormatShowHideEmptyPages.Visible := ReportLink.EmptyPagesCanExist;
        miFormatShowHideEmptyPages.Checked := ReportLink.ShowEmptyPages;
      end;
      miFormatShrinkToPageWidth.Enabled := tbShrinkToPageWidth.Enabled;
      miFormatShrinkToPageWidth.Checked := tbShrinkToPageWidth.Down;

      miViewMargins.Checked := Preview.ShowPageMargins;
      miViewStatusBar.Checked := Preview.ShowStatusBar;
      miViewMarginBar.Checked := Preview.ShowMarginBar;
      miViewExplorer.Visible := Preview.IsExplorerAvailable;
      miViewExplorer.Checked := Preview.ShowExplorer;
      miViewThumbnails.Checked := Preview.ShowThumbnails;
      miViewPageHeaders.Enabled := HasPages and not (Preview.IsBuilding or Preview.IsPrinting);
      miViewPageFooters.Enabled := HasPages and not (Preview.IsBuilding or Preview.IsPrinting);
      if ReportLink <> nil then
      begin
        miViewPageHeaders.Checked := ReportLink.ShowPageHeader;
        miViewPageFooters.Checked := ReportLink.ShowPageFooter;
      end;
    
      miViewZoom.Enabled := HasPages;
      if miViewZoom.Enabled then
      begin
        miZoomPageWidth.Enabled := tbPageWidth.Enabled;
        miZoomPercent100.Enabled := tbPercent100.Enabled;
        miZoomWholePage.Enabled := tbOnePage.Enabled;
        miZoomTwoPages.Enabled := tbTwoPage.Enabled;
        miZoomFourPages.Enabled := tbFourPage.Enabled;
        miZoomWidenToSourceWidth.Enabled := tbWidenToSourceWidth.Enabled;
      end;

      miGoToPage.Enabled := HasPages;
      miGotoFirstPage.Enabled := tbGotoFirstPage.Enabled;
      miGotoPrevPage.Enabled := tbGotoPrevPage.Enabled;
      miGotoNextPage.Enabled := tbGotoNextPage.Enabled;
      miGotoLastPage.Enabled := tbGotoLastPage.Enabled;

      miHelp.Enabled := tbHelp.Enabled;

      if ToolBar.Visible then
      begin
        tbReportDesigner.Visible := Preview.IsVisible(pvoReportDesign);
        tbFileLoad.Visible := Preview.IsCommandLoadReportVisible;
        tbFileUnload.Visible := Preview.IsCommandUnloadReportVisible;
        tbFileSave.Visible := Preview.IsCommandSaveReportVisible;
      
        tbSeparator1.Visible := tbReportDesigner.Visible;

        tbPrint.Visible := Preview.IsVisible(pvoPrint);
        tbPrintDialog.Visible := Preview.IsVisible(pvoPrint);
        tbPageSetup.Visible := Preview.IsVisible(pvoPageSetup);
        tbSeparator2.Visible := Preview.IsVisible(pvoPrint) or Preview.IsVisible(pvoPageSetup);

        tbPageBackground.Visible := Preview.IsVisible(pvoPageBackground);
        tbSeparator3.Visible := Preview.IsVisible(pvoPageBackground);

        tbHelp.Visible := Preview.IsVisible(pvoHelp);
      end;

      { menus visibility }
      miFileLoad.Visible := Preview.IsCommandLoadReportVisible;
      miFileSave.Visible := Preview.IsCommandSaveReportVisible;
      miFileClose.Visible := Preview.IsCommandUnloadReportVisible;
      miFilePreferences.Visible := Preview.IsVisible(pvoPreferences);
      miLine1.Visible := miFilePreferences.Visible;

      miFileDesign.Visible := Preview.IsVisible(pvoReportDesign);
      miLine2.Visible := miFileDesign.Visible;
      miFilePrint.Visible := tbPrint.Visible;
      miFilePageSetup.Visible := tbPageSetup.Visible;
      miFilePrintStyles.Visible := Preview.CanPrintStyle;
      miFormatPageBackground.Visible := tbPageBackground.Visible;
      miLine3.Visible := (miFilePrint.Visible or miFilePageSetup.Visible or miFilePrintStyles.Visible);
      miLine13.Visible := miFormatPageBackground.Visible;
    
      miFormatAutoText.Visible := (ReportLink <> nil) and (ReportLink.StyleManager <> nil);
      miLine14.Visible := miFormatAutoText.Visible;
        
      miViewMargins.Checked := (povMargins in Preview.Preview.OptionsView);
      miHelp.Visible := Preview.IsVisible(pvoHelp);

      miExplorer.Visible := Preview.IsExplorerAvailable;
      pmiFlatBtns.Checked := FFlatCtrls; {popup}
      pmiLargeBtns.Checked := FLargeBtns; {popup}
      miViewFlatTBtns.Checked := FFlatCtrls;
      miViewLargeTBtns.Checked := FLargeBtns;

      if ToolBar.Visible then
      begin
        if not seActivePage.Enabled then
          seActivePage.Value := 0
        else
        begin
          seActivePage.Properties.MinValue := 1;
          if Assigned(ReportLink) then
          begin
            seActivePage.Properties.MaxValue := ReportLink.PageCount;
            seActivePage.Value := ReportLink.VirtualPageIndexToRealPageIndex(
              Preview.Preview.SelPageIndex) + 1;
          end;
        end;
      end;
      Preview.UpdateExplorerContextCommands;
    finally
      Preview.CancelUpdate;
    end;
    ToolBar.Update;
  end;
end;

procedure TdxfmStdPreview.PreviewCreationComplete(Sender: TObject);
begin
  LoadDefaultProperties;
  LoadStrings;
  PreviewAfterCreateControls;
end;

procedure TdxfmStdPreview.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := Preview.CanClosePreviewWindow;
end;

{ TdxPSStandardPreviewDialogStyleInfo }

class function TdxPSStandardPreviewDialogStyleInfo.CreatePreviewWindow: TdxPSCustomPreviewWindow;
begin
  with TdxfmStdPreview.Create(nil) do
    Result := Preview;
end;

class function TdxPSStandardPreviewDialogStyleInfo.GetName: string;
begin
  Result := 'Standard';
end;

initialization
  dxPSPreviewDialogManager.RegisterPreviewDialog(TdxPSStandardPreviewDialogStyleInfo);

finalization
  dxPSPreviewDialogManager.UnregisterPreviewDialog(TdxPSStandardPreviewDialogStyleInfo);

end.
