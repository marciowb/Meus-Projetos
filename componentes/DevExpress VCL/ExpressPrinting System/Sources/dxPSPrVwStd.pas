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
  dxPSPrvw, cxControls;

type
  TdxfmStdPreview = class(TCustomdxPSPreviewWindow)
    pmToolBar: TPopupMenu;
    pmiFlatBtns: TMenuItem;
    pmiLargeBtns: TMenuItem;
    MainMenu1: TMainMenu;
    miFilePageSetup: TMenuItem;
    miFilePrint: TMenuItem;
    miFilePreferences: TMenuItem;
    miLine1: TMenuItem;
    miFileExit: TMenuItem;
    miView: TMenuItem;
    miViewMargins: TMenuItem;
    miLine4: TMenuItem;
    miViewFlatTBtns: TMenuItem;
    miViewLargeTBtns: TMenuItem;
    miViewZoom: TMenuItem;
    miZoomPercent100: TMenuItem;
    miLine6: TMenuItem;
    miZoomPageWidth: TMenuItem;
    miZoomWholePage: TMenuItem;
    miZoomTwoPages: TMenuItem;
    miZoomFourPages: TMenuItem;
    miGoToPage: TMenuItem;
    miGoToFirstPage: TMenuItem;
    miGoToPrevPage: TMenuItem;
    miLine8: TMenuItem;
    miGoToNextPage: TMenuItem;
    miGoToLastPage: TMenuItem;
    miFileDesign: TMenuItem;
    miFile: TMenuItem;
    miFormatPageBackground: TMenuItem;
    miHelp: TMenuItem;
    miHelpTopics: TMenuItem;
    miLine5: TMenuItem;
    miViewToolBar: TMenuItem;
    miViewMarginBar: TMenuItem;
    miViewStatusBar: TMenuItem;
    miLine7: TMenuItem;
    miZoomWidenToSourceWidth: TMenuItem;
    pmPreview: TPopupMenu;
    pmiZoomPercent100: TMenuItem;
    miLine10: TMenuItem;
    pmiZoomPageWidth: TMenuItem;
    pmiZoomWholePage: TMenuItem;
    pmiZoomTwoPages: TMenuItem;
    pmiZoomFourPages: TMenuItem;
    pmiZoomWidenToSourceWidth: TMenuItem;
    miLine9: TMenuItem;
    miLine11: TMenuItem;
    pmiGoToFirstPage: TMenuItem;
    pmiGoToPrevPage: TMenuItem;
    pmiGoToNextPage: TMenuItem;
    pmiGoToLastPage: TMenuItem;
    miLine20: TMenuItem;
    miZoomSetup: TMenuItem;
    pmiReportShrinkToPageWidth: TMenuItem;
    miFormatShrinkToPageWidth: TMenuItem;
    miLine12: TMenuItem;
    pmiReportDesign: TMenuItem;
    pmiZoom: TMenuItem;
    ilToolBarSmall: TImageList;
    ilStub: TImageList;
    miLine2: TMenuItem;
    miLine3: TMenuItem;
    miFormat: TMenuItem;
    miLine13: TMenuItem;
    miFormatDateTime: TMenuItem;
    N4: TMenuItem;
    miFormatPageNumbering: TMenuItem;
    N5: TMenuItem;
    miEdit: TMenuItem;
    miEditFind: TMenuItem;
    miEditFindNext: TMenuItem;
    N6: TMenuItem;
    miEditReplace: TMenuItem;
    miFormatAutoText: TMenuItem;
    miViewPageHeaders: TMenuItem;
    miViewPageFooters: TMenuItem;
    N1: TMenuItem;
    pmiPageSetup: TMenuItem;
    N2: TMenuItem;
    miHelpAbout: TMenuItem;
    N3: TMenuItem;
    miFormatShowHideEmptyPages: TMenuItem;
    pmPrintStyles: TPopupMenu;
    miFilePrintStyles: TMenuItem;
    pmiFilePrintStyles: TMenuItem;
    miLine14: TMenuItem;
    pmDesigners: TPopupMenu;
    ToolBar: TToolBar;
    tbReportDesigner: TToolButton;
    tbSeparator1: TToolButton;
    tbPrint: TToolButton;
    tbPrintDialog: TToolButton;
    tbPageSetup: TToolButton;
    tbSeparator2: TToolButton;
    tbPageBackground: TToolButton;
    tbShrinkToPageWidth: TToolButton;
    tbSeparator3: TToolButton;
    tbPercent100: TToolButton;
    tbPageWidth: TToolButton;
    tbOnePage: TToolButton;
    tbTwoPage: TToolButton;
    tbFourPage: TToolButton;
    tbMultiplePages: TToolButton;
    tbWidenToSourceWidth: TToolButton;
    tbSeparator4: TToolButton;
    pnlZoomCbx: TPanel;
    tbSeparator5: TToolButton;
    tbGotoFirstPage: TToolButton;
    tbGotoPrevPage: TToolButton;
    ToolButton2: TToolButton;
    pnlCurrentPage: TPanel;
    ToolButton1: TToolButton;
    tbGotoNextPage: TToolButton;
    tbGotoLastPage: TToolButton;
    tbSeparator8: TToolButton;
    tbHelp: TToolButton;
    tbClose: TToolButton;
    Timer1: TTimer;
    miViewExplorer: TMenuItem;
    miExplorer: TMenuItem;
    miExplorerCreateNewFolder: TMenuItem;
    miLine31: TMenuItem;
    miExplorerDelete: TMenuItem;
    miExplorerRename: TMenuItem;
    miFileSave: TMenuItem;
    tbFileSave: TToolButton;
    miFileLoad: TMenuItem;
    miLine32: TMenuItem;
    pmExplorer: TPopupMenu;
    pmiExplorerLoadData: TMenuItem;
    miLine33: TMenuItem;
    pmiExplorerCreateFolder: TMenuItem;
    miLine34: TMenuItem;
    pmiExplorerDelete: TMenuItem;
    pmiExplorerRename: TMenuItem;
    miFileClose: TMenuItem;
    pmiExplorerUnloadData: TMenuItem;
    miFormatTitle: TMenuItem;
    N7: TMenuItem;
    tbFileLoad: TToolButton;
    miLine30: TMenuItem;
    miViewThumbnails: TMenuItem;
    pmThumbnails: TPopupMenu;
    pmiSmallThumbnails: TMenuItem;
    pmiLargeThumbnails: TMenuItem;
    pmiExplorerProperties: TMenuItem;
    miExplorerProperties: TMenuItem;
    miLine40: TMenuItem;
    miLine39: TMenuItem;
    tbViewExplorer: TToolButton;
    tbViewThumbnails: TToolButton;
    ToolButton5: TToolButton;
    tbFileUnload: TToolButton;
    miFileRebuild: TMenuItem;
    procedure pmiFlatBtnsClick(Sender: TObject);
    procedure pmiLargeBtnsClick(Sender: TObject);
    procedure PageSetupClick(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure ZoomClick(Sender: TObject);
    procedure GoToPageClick(Sender: TObject);
    procedure CloseClick(Sender: TObject);
    procedure cbxPredefinedZoomClick(Sender: TObject);
    procedure cbxPredefinedZoomCloseUp(Sender: TObject; AAccept: Boolean);
    procedure cbxPredefinedZoomExit(Sender: TObject);
    procedure cbxPredefinedZoomKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure seActivePageExit(Sender: TObject);
    procedure seKeyPress(Sender: TObject; var Key: Char);
    procedure seActivePageButtonClick(Sender: TObject;
      ButtonType: TdxButtonType; Button: TUDBtnType);
    procedure DesignClick(Sender: TObject);
    procedure PageBackgroundClick(Sender: TObject);
    procedure pnlZoomCbxResize(Sender: TObject);
    procedure pnlCurrentPageResize(Sender: TObject);
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
  private
    FExplorerContextCommandMenuItems: TList;
    FExplorerContextCommandPopupMenuItems: TList;
    FExplorerContextCommandToolButtons: TList;
    FFlatCtrls: Boolean;
    FLargeBtns: Boolean;

    FcbxPredefinedZoom: TCustomEdit;
    FilToolBarLarge: TImageList;
    FseActivePage: TCustomEdit;

    function GetExplorerContextCommandMenuItem(Index: Integer): TMenuItem;
    function GetExplorerContextCommandMenuItemCount: Integer;
    function GetExplorerContextCommandPopupMenuItem(Index: Integer): TMenuItem;
    function GetExplorerContextCommandPopupMenuItemCount: Integer;
    function GetExplorerContextCommandToolButton(Index: Integer): TToolButton;
    function GetExplorerContextCommandToolButtonCount: Integer;
    
    procedure SetFlatCtrls(Value: Boolean);
    procedure SetLargeBtns(Value: Boolean);

    procedure ArrangeToolBarCtrls;
    procedure AssignToolBarImages;
    function CalculateWindowPos(Sender: TObject): TPoint;
    procedure CheckItem(AParent: TMenuItem);
    function CreateLargeImages(ASource: TCustomImageList): TImageList;
    procedure DoShowExplorerPopup(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure LoadPropertiesFromRegistry(const APath: string);
    procedure SavePropertiesToRegistry(const APath: string);
    procedure SetupFlatCtrls;
    procedure WMInitMenu(var Message: TWMInitMenu); message WM_INITMENU;
  protected
    procedure Activate; override;  
    procedure DoShow; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;

    procedure AddExplorerContextCommand(ACommand: TCustomdxPSExplorerContextCommand); override;
    procedure UpdateExplorerContextCommands; override;
    procedure ExplorerContextCommandClick(Sender: TObject); virtual;
    
    procedure CreateControls; override;
    procedure DoAfterPrintReport(AShowDialog: Boolean); override;
    procedure DoPreviewZoomFactorChanged(APreview: TdxPreview); override;
    procedure DoPreviewZoomModeChanged(APreview: TdxPreview); override;
    procedure LoadStrings; override;
    procedure StyleListChanged(Sender: TObject); override;

    property ExplorerContextCommandMenuItemCount: Integer read GetExplorerContextCommandMenuItemCount;
    property ExplorerContextCommandMenuItems[Index: Integer]: TMenuItem read GetExplorerContextCommandMenuItem;
    property ExplorerContextCommandPopupMenuItemCount: Integer read GetExplorerContextCommandPopupMenuItemCount;
    property ExplorerContextCommandPopupMenuItems[Index: Integer]: TMenuItem read GetExplorerContextCommandPopupMenuItem;
    property ExplorerContextCommandToolButtonCount: Integer read GetExplorerContextCommandToolButtonCount;
    property ExplorerContextCommandToolButtons[Index: Integer]: TToolButton read GetExplorerContextCommandToolButton;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AfterConstruction; override;

    procedure InitContent; override;
    procedure LoadFromRegistry(const APath: string); override;
    procedure SaveToRegistry(const APath: string); override;
    procedure UpdateControls; override;

    property FlatCtrls: Boolean read FFlatCtrls write SetFlatCtrls;
    property LargeBtns: Boolean read FLargeBtns write SetLargeBtns;
  end;

implementation

{$R *.DFM}

uses
  Registry, CommCtrl, Math, {$IFDEF DELPHI7}Themes, UxTheme, {$ENDIF} cxClasses,
  dxPSGlbl, dxPSEngn, dxPgsDlg, dxPSRes, dxPSImgs, dxPrnDev, dxPSPopupMan, dxPSUtl;

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

var
  ToolBarImages: array[Boolean] of TImageList;

type
  TControlAccess = class(TControl);
  
  TdxZoomFactorComboEdit = class;

  TdxPopupBox = class(TListBox)
  private
    function GetEdit: TdxZoomFactorComboEdit;
    function GetTextColor(Index: Integer; State: TOwnerDrawState): TColor;
   {$IFDEF DELPHI5}
    procedure WMContextMenu(var message: TWMContextMenu); message WM_CONTEXTMENU;
   {$ENDIF}
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure WndProc(var message: TMessage); override;

    property Edit: TdxZoomFactorComboEdit read GetEdit;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TdxPopupBoxItem = class
  public
    Enabled: Boolean;
    ImageIndex: Integer;
    constructor Create(AEnabled: Boolean; AnImageIndex: Integer);
  end;
    
  TdxCloseUpEvent = procedure(Sender: TObject; AAccept: Boolean) of object;

  TdxZoomFactorComboEdit = class(TCustomEdit)
  private
    FBorderWidth: Integer;
    FButtonWidth: Integer;
    FDropDownCount: Integer;
    FDroppedDown: Boolean;
    FFlat: Boolean;
    FImages: TImageList;
    FImagesChangeLink: TChangeLink;
    FIsMousePressed: Boolean;
    FItemIndex: Integer;
    FItemList: TList;
    FItems: TStrings;
    FLockChanges: Boolean;
    FPopupBox: TdxPopupBox;
    FSaveText: string;
    FOnCloseUp: TdxCloseUpEvent;
    FOnDropDown: TNotifyEvent;
    function GetButtonRect: TRect;
    function GetHotTrackAllowed: Boolean;
    function GetImageIndex(Index: Integer): Integer;
    function GetItemEnabled(Index: Integer): Boolean;
    function GetMouseInButtonBounds: Boolean;
    function GetMouseInControlBounds: Boolean;
    function GetMousePos: TPoint;
    function GetPopupItem(Index: Integer): TdxPopupBoxItem;
    procedure SetDropDownCount(Value: Integer);
    procedure SetDroppedDown(Value: Boolean);
    procedure SetFlat(Value: Boolean);
    procedure SetImages(Value: TImageList);
    procedure SetImageIndex(Index: Integer; Value: Integer);
    procedure SetIsMousePressed(Value: Boolean);
    procedure SetItemEnabled(Index: Integer; Value: Boolean);
    procedure SetItemIndex(Value: Integer);
    procedure SetItems(Value: TStrings);

    procedure CloseUp(Accept: Boolean);
    procedure DrawBorder(DC: HDC);
    procedure DrawButton(DC: HDC);
    procedure DrawNonClientArea;
    procedure DropDown;
    procedure InvalidateNCArea;
    procedure MakeZoomItems;
    procedure WMCaptureChanged(var Message: TMessage); message WM_CAPTURECHANGED;
   {$IFDEF DELPHI5}
    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
   {$ENDIF}
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMNCLButtonDown(var Message: TWMNCLButtonDown); message WM_NCLBUTTONDOWN;
    procedure WMNCLButtonUp(var Message: TWMNCLButtonDown); message WM_NCLBUTTONUP;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
    procedure WMSetText(var Message: TWMSetText); message WM_SETTEXT;
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW; 
  protected
    procedure Change; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DoEnter; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure WndProc(var message: TMessage); override;
    
    function AddItem(AnEnabled: Boolean; AnItemIndex: Integer): Integer;
    procedure InsertItem(AnIndex: Integer; AnEnabled: Boolean; AnItemIndex: Integer);
    procedure RemoveItem(AnIndex: Integer);
    
    property BorderWidth: Integer read FBorderWidth;
    property ButtonRect: TRect read GetButtonRect;
    property ButtonWidth: Integer read FButtonWidth;
    property HotTrackAllowed: Boolean read GetHotTrackAllowed;
    property IsMousePressed: Boolean read FIsMousePressed write SetIsMousePressed;
    property MouseInButtonBounds: Boolean read GetMouseInButtonBounds;
    property MouseInControlBounds: Boolean read GetMouseInControlBounds;
    property MousePos: TPoint read GetMousePos;
    property PopupBox: TdxPopupBox read FPopupBox;
    property PopupItems[Index: Integer]: TdxPopupBoxItem read GetPopupItem;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;

    function FindItemIndexByText(const AText: string): Integer;
    procedure SelectNext;
    procedure SelectPrev;

    property DroppedDown: Boolean read FDroppedDown write SetDroppedDown;
    property ItemEnabled[Index: Integer]: Boolean read GetItemEnabled write SetItemEnabled;
    property ImageIndexes[Index: Integer]: Integer read GetImageIndex write SetImageIndex;
  published
    property DropDownCount: Integer read FDropDownCount write SetDropDownCount default 8;
    property Flat: Boolean read FFlat write SetFlat  default False;
    property Images: TImageList read FImages write SetImages;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    property Items: TStrings read FItems write SetItems;

    property OnClick;
    property OnCloseUp: TdxCloseUpEvent read FOnCloseUp write FOnCloseUp;
    property OnDropDown: TNotifyEvent read FOnDropDown write FOnDropDown;
  end;

{ Utility Routines }
  
function AddPercentSign(const S: string): string;
begin
  Result := S;
  if S[Length(S)] <> PercentSymbol then
    Result := Result + PercentSymbol;
end;

{ TdxPopupBox }

constructor TdxPopupBox.Create(AOwner: TComponent);
begin
  inherited;
  Style := lbOwnerDrawVariable;
  ControlStyle := ControlStyle - [csCaptureMouse];
end;

procedure TdxPopupBox.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
  begin
    Style := Style or WS_BORDER or LBS_OWNERDRAWFIXED and not LBS_WANTKEYBOARDINPUT;
    ExStyle := WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
    WindowClass.Style := CS_SAVEBITS;
  end;
end;

procedure TdxPopupBox.CreateWnd;
begin
  inherited;
  Windows.SetParent(Handle, 0);
  CallWindowProc(DefWndProc, Handle, WM_SETFOCUS, 0, 0);
  Items := Edit.Items;
end;

procedure TdxPopupBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
const
  TextColor: array[Boolean] of TColor = (clWindowText, clHighlightText);
var
  S: string;  
begin
  Canvas.FillRect(Rect);
  with Edit do 
    if (Images <> nil) and (ImageIndexes[Index] > -1) then
      Images.Draw(Canvas, Rect.Left + 1, Rect.Top + 1, ImageIndexes[Index], ItemEnabled[Index]);

  if Edit.Images <> nil then
    Inc(Rect.Left, Edit.Images.Width + 5);
  Canvas.Font.Color := GetTextColor(Index, State);  
  Canvas.Brush.Style := bsClear;
  S := Items[Index];
  DrawText(Canvas.Handle, PChar(S), Length(S), Rect, DT_LEFT or DT_VCENTER or DT_SINGLELINE or DT_NOPREFIX);
end;

procedure TdxPopupBox.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  Index: Integer;
begin
  inherited;
  Index := ItemAtPos(MakePoint(X, Y), True);
  if (Index > -1) and Edit.ItemEnabled[Index] then
    ItemIndex := Index;
end;

procedure TdxPopupBox.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  Accept: Boolean;
  Pt: TPoint;
begin
  inherited;
  if Button = mbLeft then
  begin
    Pt := MakePoint(X, Y);
    Accept := PtInRect(MakeRect(0, 0, Width, Height), Pt) and Edit.ItemEnabled[ItemAtPos(Pt, True)];
    Edit.CloseUp(Accept);
  end;
end;

procedure TdxPopupBox.WndProc(var Message: TMessage);
begin
  if not ((Message.Msg = LB_SETCURSEL) and ((Message.wParam = -1) or not Edit.ItemEnabled[Message.wParam])) then
    inherited;
end;

function TdxPopupBox.GetEdit: TdxZoomFactorComboEdit;
begin
  Result := TdxZoomFactorComboEdit(Owner);
end;

function TdxPopupBox.GetTextColor(Index: Integer; State: TOwnerDrawState): TColor;
begin
  if Edit.ItemEnabled[Index] then
    if odSelected in State then
      Result := clHighlightText
    else
      Result := clWindowText
  else
    Result := clGrayText;
end;

{$IFDEF DELPHI5}

procedure TdxPopupBox.WMContextMenu(var Message: TWMContextMenu);
begin
  //DefaultHandler(message);
end;

{$ENDIF}

procedure TdxPopupBox.WMLButtonDown(var Message: TWMLButtonDown);
var
  Index: Integer;
begin
  Index := ItemAtPos(SmallPointToPoint(Message.Pos), True);
  if (Index > -1) and Edit.ItemEnabled[Index] then
    inherited;
end;

procedure TdxPopupBox.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  InflateRect(Message.CalcSize_Params^.rgrc[0], -2, -2);
end;

procedure TdxPopupBox.WMNCPaint(var Message: TWMNCPaint);
var
  R: TRect;
  DC: HDC;
begin
  GetWindowRect(Handle, R);
  OffsetRect(R, -R.Left, -R.Top);
  DC := GetWindowDC(Handle);
  try
    DrawEdge(DC, R, EDGE_RAISED, BF_ADJUST or BF_RECT);
  finally
    ReleaseDC(Handle, DC);
  end;  
end;

procedure TdxPopupBox.WMRButtonUp(var Message: TWMRButtonUp);
begin
  DefaultHandler(Message);
end;

procedure TdxPopupBox.CMHintShow(var Message: TCMHintShow);
begin
  Message.Result := 1;
end;

procedure TdxPopupBox.CNCommand(var Message: TWMCommand);
begin
  inherited;
  if (Message.NotifyCode = CBN_SELCHANGE) and Edit.ItemEnabled[ItemIndex] then
  begin
    Edit.FLockChanges := True;
    try
      Edit.Text := Items[ItemIndex];
    finally
      Edit.FLockChanges := False;
    end;
  end;
end;

type
  TdxComboEditStrings = class(TStringList)
  private
    FComboEdit: TdxZoomFactorComboEdit;
  protected
    procedure SetUpdateState(Updating: Boolean); override;
  public
    constructor Create(AComboEdit: TdxZoomFactorComboEdit);
    destructor Destroy; override;

    function Add(const S: string): Integer; override;
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    procedure Insert(Index: Integer; const S: string); override;
    property ComboEdit: TdxZoomFactorComboEdit read FComboEdit;
  end;

constructor TdxComboEditStrings.Create(AComboEdit: TdxZoomFactorComboEdit);
begin
  inherited Create;
  FComboEdit := AComboEdit;
end;

destructor TdxComboEditStrings.Destroy;
begin
  Clear;
  inherited;
end;

function TdxComboEditStrings.Add(const S: string): Integer;
begin
  inherited Add(S);
  Result := ComboEdit.AddItem(True, -1);
end;

procedure TdxComboEditStrings.Insert(Index: Integer; const S: string);
begin
  inherited;
  ComboEdit.InsertItem(Index, True, -1);
end;

procedure TdxComboEditStrings.Delete(Index: Integer);
begin
  ComboEdit.RemoveItem(Index);
  inherited;
end;

procedure TdxComboEditStrings.Clear;
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do
    Delete(I);
  inherited;
end;

procedure TdxComboEditStrings.SetUpdateState(Updating: Boolean);
begin
  SendMessage(ComboEdit.Handle, WM_SETREDRAW, Ord(not Updating), 0);
  if not Updating then ComboEdit.Refresh;
end;

{ TdxPopupBoxItem }

constructor TdxPopupBoxItem.Create(AEnabled: Boolean; AnImageIndex: Integer);
begin
  inherited Create;
  Enabled := AEnabled;
  ImageIndex := AnImageIndex;
end;

{ TdxZoomFactorComboEdit }

constructor TdxZoomFactorComboEdit.Create(Owner: TComponent);
begin
  inherited;
  FBorderWidth := 3;
  FDropDownCount := 8;
  FItemIndex := -1;

  FImagesChangeLink := TChangeLink.Create;

  FItemList := TList.Create;
  FItems := TdxComboEditStrings.Create(Self);
  MakeZoomItems;

  FFlat := True;
  ControlStyle := ControlStyle - [csSetCaption, csFramed];
  Ctl3D := False;
  BorderStyle := Forms.bsNone;
  Parent := Owner as TWinControl;
  FButtonWidth := GetSystemMetrics(SM_CXVSCROLL);

  FPopupBox := TdxPopupBox.Create(Self);
  FPopupBox.Parent := Self;
  FPopupBox.Visible := False;
  FPopupBox.IntegralHeight := False;
end;

destructor TdxZoomFactorComboEdit.Destroy;
begin
  FItems.Free;
  FItemList.Free;
  FImagesChangeLink.Free;
  FPopupBox.Free;
  inherited;
end;

function TdxZoomFactorComboEdit.FindItemIndexByText(const AText: string): Integer;
begin 
  Result := FItems.IndexOf(AText);
end;

procedure TdxZoomFactorComboEdit.SelectNext;
begin
  if ItemIndex < Items.Count then
    ItemIndex := ItemIndex + 1;
end;

procedure TdxZoomFactorComboEdit.SelectPrev;
begin
  if ItemIndex > 0 then
  {begin
    V := IntToStr(Drop
  end
  else}
    ItemIndex := ItemIndex - 1;
end;

procedure TdxZoomFactorComboEdit.Change;
begin
  if FLockChanges then Exit;
  inherited;
end;

procedure TdxZoomFactorComboEdit.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.Style := Params.Style or WS_CLIPCHILDREN;
end;

procedure TdxZoomFactorComboEdit.DoEnter;
begin
  FSaveText := Text;
  inherited;
end;

procedure TdxZoomFactorComboEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if cxShiftStateMoveOnly(Shift) then
    case Key of
      VK_UP: SelectPrev;
      VK_DOWN: SelectNext;
    end;
  inherited;  
end;

procedure TdxZoomFactorComboEdit.KeyPress(var Key: Char);
begin
  inherited;
  if (Key = Char(VK_RETURN)) or (Key = Char(VK_ESCAPE)) then Key := #0;
end;

procedure TdxZoomFactorComboEdit.WndProc(var Message: TMessage);

  procedure ProcessDropDownKeys(var Key: Word; Shift: TShiftState);

    function IsDropDownKey: Boolean;
    begin
      if ssAlt in Shift then
        Result := (Key = VK_F4) or (Key = VK_DOWN)
      else
        Result := Key = VK_F4;
    end;
    
  begin
    if IsDropDownKey then
    begin
      if DroppedDown then
        CloseUp(False)
      else
        DropDown;
      Key := 0;
    end;

    if not (ssAlt in Shift) then
    begin
      if (Key = VK_RETURN) and DroppedDown then
      begin
        CloseUp(True);
        Key := 0;
      end;

      if Key = VK_ESCAPE then
      begin
        if DroppedDown then
          CloseUp(False)
        else
          Text := FSaveText;
        Key := 0;
      end;
    end;  
  end;

var
  CharKey: Word;
begin
  case Message.Msg of
    WM_KEYDOWN,
    WM_SYSKEYDOWN,
    WM_CHAR:
      begin
        with TWMKey(Message) do
        begin
          CharKey := CharCode;
          ProcessDropDownKeys(CharKey, KeyDataToShiftState(KeyData));
          CharCode := CharKey;
          if CharCode = 0 then Exit;
        
          if ((CharCode = VK_UP) or (CharCode = VK_DOWN)) and PopupBox.Visible then
          begin
            with Message do
              SendMessage(PopupBox.Handle, Msg, wParam, lParam);
            Exit;
          end;
        end;
      end;  

    CM_ENABLEDCHANGED,
    CM_MOUSEENTER,
    CM_MOUSELEAVE,
    WM_SETFOCUS,
    WM_KILLFOCUS:
      InvalidateNCArea;
  end;
  inherited;
end;

function TdxZoomFactorComboEdit.AddItem(AnEnabled: Boolean; AnItemIndex: Integer): Integer;
begin
  Result := FItemList.Add(TdxPopupBoxItem.Create(AnEnabled, AnItemIndex));
end;

procedure TdxZoomFactorComboEdit.InsertItem(AnIndex: Integer; AnEnabled: Boolean; 
  AnItemIndex: Integer);
begin
  FItemList.Insert(AnIndex, TdxPopupBoxItem.Create(AnEnabled, AnItemIndex));
end;

procedure TdxZoomFactorComboEdit.RemoveItem(AnIndex: Integer);
begin
  PopupItems[AnIndex].Free;
  FItemList.Delete(AnIndex);
end;

function TdxZoomFactorComboEdit.GetButtonRect: TRect;
begin
  GetWindowRect(Handle, Result);
  InflateRect(Result, -BorderWidth, -BorderWidth);
  Result.Left := Result.Right - ButtonWidth;
end;

function TdxZoomFactorComboEdit.GetHotTrackAllowed: Boolean;
begin
  Result := Flat and not (csDesigning in ComponentState) and 
    (Focused or (MouseInControlBounds and GetParentForm(Self).Active));
end;

function TdxZoomFactorComboEdit.GetImageIndex(Index: Integer): Integer;
begin
  Result := PopupItems[Index].ImageIndex;
end;

function TdxZoomFactorComboEdit.GetItemEnabled(Index: Integer): Boolean;
begin
  Result := PopupItems[Index].Enabled;
end;

function TdxZoomFactorComboEdit.GetMouseInButtonBounds: Boolean;
begin
  Result := PtInRect(ButtonRect, MousePos);
end;

function TdxZoomFactorComboEdit.GetMouseInControlBounds: Boolean;
var
  R: TRect;
begin
  GetWindowRect(Handle, R);
  Result := PtInRect(R, MousePos);
end;

function TdxZoomFactorComboEdit.GetMousePos: TPoint;
begin
  GetCursorPos(Result);
end;

function TdxZoomFactorComboEdit.GetPopupItem(Index: Integer): TdxPopupBoxItem;
begin
  Result := TdxPopupBoxItem(FItemList[Index]);
end;

procedure TdxZoomFactorComboEdit.SetDropDownCount(Value: Integer);
begin
  if Value < 1 then 
    Value := 1;
  if FDropDownCount <> Value then 
    FDropDownCount := Value;
end;

procedure TdxZoomFactorComboEdit.SetDroppedDown(Value: Boolean);
begin
  if FDroppedDown <> Value then
  begin
    FDroppedDown := Value;
    if DroppedDown then
      DropDown
    else
      CloseUp(False);
  end;
end;

procedure TdxZoomFactorComboEdit.SetFlat(Value: Boolean);
const
  BorderStyleMap: array[Boolean] of TBorderStyle = (bsSingle, bsNone);
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    Ctl3D := not Flat;
    BorderStyle := BorderStyleMap[Flat];
  end;
end;

procedure TdxZoomFactorComboEdit.SetImageIndex(Index: Integer; Value: Integer);
begin
  PopupItems[Index].ImageIndex := Value;
end;

procedure TdxZoomFactorComboEdit.SetIsMousePressed(Value: Boolean);
begin
  if FIsMousePressed <> Value then
  begin
    FIsMousePressed := Value;
    InvalidateNCArea;
  end;  
end;

procedure TdxZoomFactorComboEdit.SetImages(Value: TImageList);
begin
  if Images <> nil then
    Images.UnregisterChanges(FImagesChangeLink);
  FImages := Value;
  if Images <> nil then
  begin
    Images.RegisterChanges(FImagesChangeLink);
    Images.FreeNotification(Self);
    PopupBox.ItemHeight := Images.Height + 2;
  end;
end;

procedure TdxZoomFactorComboEdit.SetItemEnabled(Index: Integer; Value: Boolean);
begin
  PopupItems[Index].Enabled := Value;
end;

procedure TdxZoomFactorComboEdit.SetItemIndex(Value: Integer);
begin
  if Value < -1 then 
    Value := -1;
  if Value > Items.Count - 1 then 
    Value := Items.Count - 1;
  if FItemIndex <> Value then
  begin
    FItemIndex := Value;
    if FItemIndex > -1 then
      Text := Items[FItemIndex]
    else
      Text := '';
  end;
end;

procedure TdxZoomFactorComboEdit.SetItems(Value: TStrings);
begin
  Items.Assign(Value);
end;

procedure TdxZoomFactorComboEdit.CloseUp(Accept: Boolean);
begin
  if PopupBox.Visible then
  begin
    FDroppedDown := False;
    if GetCapture <> 0 then 
      SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    SetWindowPos(FPopupBox.Handle, 0, 0, 0, 0, 0,
      SWP_NOZORDER or SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    if Accept and (PopupBox.ItemIndex <> -1) then
      Text := PopupBox.Items.Strings[FPopupBox.ItemIndex];
    PopupBox.Visible := False;

    if Assigned(FOnCloseUp) then FOnCloseUp(Self, Accept);
    if Accept then Click;

    Invalidate;
    InvalidateNCArea;
  end;  
end;

procedure TdxZoomFactorComboEdit.DrawBorder(DC: HDC);
var
  R: TRect;
  Color: COLORREF;
 {$IFDEF DELPHI7}
  Details: TThemedElementDetails;
 {$ENDIF}
begin
  GetWindowRect(Handle, R);
  OffsetRect(R, -R.Left, -R.Top);
  if not Flat then
  begin
   {$IFDEF DELPHI7}
    with ThemeServices do
      if ThemesEnabled then
      begin
        Details := GetElementDetails(teEditTextNormal);
        DrawEdge(DC, Details, R, BDR_RAISEDOUTER, BF_RECT or BF_FLAT);
        InflateRect(R, -1, -1);
        DrawEdge(DC, Details, R, BDR_RAISEDINNER, BF_RECT or BF_MONO);
        InflateRect(R, -1, -1);
        DrawEdge(DC, Details, R, BDR_RAISEDINNER, BF_RECT or BF_MONO);
        Exit;
      end;
   {$ENDIF} 
    DrawEdge(DC, R, EDGE_SUNKEN, BF_RECT);
    InflateRect(R, -2, -2);
    FrameRect(DC, R, GetSysColorBrush(COLOR_WINDOW));
  end
  else
  begin
    if HotTrackAllowed then
    begin
      DrawEdge(DC, R, BDR_SUNKENOUTER, BF_RECT);
      InflateRect(R, -1, -1);
      FrameRect(DC, R, GetSysColorBrush(COLOR_BTNFACE));
    end
    else
    begin
      FrameRect(DC, R, GetSysColorBrush(COLOR_BTNFACE));
      InflateRect(R, -1, -1);
      if Enabled then
        Color := COLOR_BTNFACE
      else
        Color := COLOR_WINDOW;
      FrameRect(DC, R, GetSysColorBrush(Color));
    end;
    InflateRect(R, -1, -1);
    FrameRect(DC, R, GetSysColorBrush(COLOR_WINDOW));
  end;
end;

procedure TdxZoomFactorComboEdit.DrawButton(DC: HDC);

 {$IFDEF DELPHI7}
  function GetThemeState(ADowned: Boolean): TThemedComboBox;
  begin
    if not Enabled then
      Result := tcDropDownButtonDisabled
    else  
      if ADowned then
        Result := tcDropDownButtonPressed
      else
        if MouseInButtonBounds then
          Result := tcDropDownButtonHot 
        else
          Result := tcDropDownButtonNormal;
  end;
 {$ENDIF}

  function ButtonRect: TRect;
  begin
    Result := BoundsRect;
    OffsetRect(Result, -Result.Left, -Result.Top);
    InflateRect(Result, -BorderWidth, -BorderWidth);
    Result.Left := Result.Right - ButtonWidth;
  end;
  
const
  Pusheds: array[Boolean] of UINT = (0, DFCS_PUSHED);
  Enableds: array[Boolean] of UINT = (DFCS_INACTIVE, 0);
  Downeds: array[Boolean] of UINT = (BDR_RAISEDOUTER, BDR_SUNKENINNER);
  InnerEdges: array[Boolean] of UINT = (BDR_RAISEDINNER, 0);
  OuterEdges: array[Boolean] of UINT = (0, BDR_SUNKENOUTER);
var
  R: TRect;
  Downed: Boolean;
begin
 R := ButtonRect;
 Downed := DroppedDown or (MouseInButtonBounds and IsMousePressed);
 {$IFDEF DELPHI7} 
  with ThemeServices do
    if ThemesEnabled then
    begin
      DrawElement(DC, GetElementDetails(GetThemeState(Downed)), R);
      Exit;  
    end;  
 {$ENDIF}
   
  DrawFrameControl(DC, R, DFC_SCROLL, DFCS_FLAT or DFCS_SCROLLCOMBOBOX or Pusheds[Downed] or Enableds[Enabled]);
  DrawEdge(DC, R, OuterEdges[Downed] or InnerEdges[Downed] or Downeds[Downed], BF_RECT);

  ExcludeClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
end;

procedure TdxZoomFactorComboEdit.DrawNonClientArea;
var
  DC: HDC;
begin
  DC := GetWindowDC(Handle);
  try
    DrawBorder(DC);
    DrawButton(DC);
  finally
    ReleaseDC(Handle, DC);
  end;
end;

procedure TdxZoomFactorComboEdit.DropDown;
var
  ADesktopBounds: TRect; 

  function CalculatePopupPos: TPoint;
  begin
    Result := Parent.ClientToScreen(MakePoint(Left, Top));
    with Result do
    begin
      if X + PopupBox.Width > ADesktopBounds.Right then
        X := ADesktopBounds.Right - PopupBox.Width;
      if X < ADesktopBounds.Left then X := ADesktopBounds.Left;

      Inc(Y, Height);
      if Y + PopupBox.Height > Screen.Height then
        if Y - (PopupBox.Height + Height) > 0 then
          Dec(Y, PopupBox.Height + Height)
        else
          Y := 0;
    end;
  end;

var
  Pt: TPoint;
begin
  ADesktopBounds := GetDesktopWorkArea(Parent.ClientToScreen(MakePoint(Left, Top)));
  if (PopupBox <> nil) and not PopupBox.Visible then
  begin
    FDroppedDown := True;
    SelectAll;

    PopupBox.Width := Width;
    PopupBox.Height := DropDownCount * PopupBox.ItemHeight + 4;
    PopupBox.Color := Color;
    PopupBox.Font := Font;
    PopupBox.ItemIndex := PopupBox.Items.IndexOf(Text);

    Pt := CalculatePopupPos;
    SetWindowPos(PopupBox.Handle, HWND_TOP, Pt.X, Pt.Y, 0, 0, SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
    PopupBox.Visible := True;
    Invalidate;
    Windows.SetFocus(Handle);

    if Assigned(FOnDropDown) then FOnDropDown(Self);
  end;
end;

procedure TdxZoomFactorComboEdit.InvalidateNCArea;
const
  Flags: UINT = SWP_FRAMECHANGED or SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER;
begin
  SetWindowPos(Handle, 0, 0, 0, 0, 0, Flags);
end;

procedure TdxZoomFactorComboEdit.MakeZoomItems;
begin
  with Items do
  begin
    Clear;
    Add('500' + PercentSymbol);
    Add('200' + PercentSymbol);
    Add('150' + PercentSymbol);
    Add('100' + PercentSymbol);
    Add('75' + PercentSymbol);
    Add('50' + PercentSymbol);
    Add('25' + PercentSymbol);
    Add('10' + PercentSymbol);
    Add(cxGetResourceString(@sdxPageWidth));
    Add(cxGetResourceString(@sdxWholePage));
    Add(cxGetResourceString(@sdxTwoPages));
    Add(cxGetResourceString(@sdxFourPages));
    Add(cxGetResourceString(@sdxWidenToSourceWidth));
  end;
end;

procedure TdxZoomFactorComboEdit.WMCaptureChanged(var Message: TMessage);
begin
  inherited;
  IsMousePressed := False;
end;

{$IFDEF DELPHI5}

procedure TdxZoomFactorComboEdit.WMContextMenu(var Message: TWMContextMenu);
begin
  if DroppedDown then
    DefaultHandler(Message)
  else
    inherited;
end;

{$ENDIF}

procedure TdxZoomFactorComboEdit.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  IsMousePressed := False;
  CloseUp(False);
end;

procedure TdxZoomFactorComboEdit.WMMouseMove(var Message: TWMMouseMove);
begin
  inherited;
  if not MouseInButtonBounds then
    Perform(WM_NCLBUTTONUP, 0, TMessage(Message).lParam);
end;

procedure TdxZoomFactorComboEdit.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  with Message.CalcSize_Params^ do
  begin
    InflateRect(rgrc[0], -FBorderWidth, -FBorderWidth);
    Dec(rgrc[0].Right, FButtonWidth);
  end;
end;

procedure TdxZoomFactorComboEdit.WMNCHitTest(var Message: TWMNCHitTest);
begin
  inherited;
  if MouseInButtonBounds then
    message.Result := HTBORDER
  else
    Perform(WM_NCLBUTTONUP, 0, TMessage(Message).lParam);
end;

procedure TdxZoomFactorComboEdit.WMNCLButtonDown(var Message: TWMNCLButtonDown);
begin
  inherited;
  if MouseInButtonBounds then
  begin
    IsMousePressed := True;
    DroppedDown := not FPopupBox.Visible;
  end;
end;

procedure TdxZoomFactorComboEdit.WMNCLButtonUp(var message: TWMNCLButtonDown);
begin
  inherited;
  IsMousePressed := False;
end;

procedure TdxZoomFactorComboEdit.WMNCPaint(var Message: TWMNCPaint);
begin
  DrawNonClientArea;
end;

procedure TdxZoomFactorComboEdit.WMRButtonUp(var Message: TWMRButtonUp);
begin
  if DroppedDown then
    DefaultHandler(Message)
  else
    inherited;
end;

procedure TdxZoomFactorComboEdit.WMSetText(var Message: TWMSetText);
var
  Index: Integer;
begin
  inherited;
  Index := FindItemIndexByText(Text);
  if Index <> -1 then
    ItemIndex := Index;
end;

procedure TdxZoomFactorComboEdit.CMCancelMode(var Message: TCMCancelMode);
begin
  if (Message.Sender <> Self) and (Message.Sender <> FPopupBox) then
    CloseUp(False);
end;

procedure TdxZoomFactorComboEdit.CMHintShow(var Message: TCMHintShow);
begin
  Message.Result := Integer(DroppedDown);
end;

{ TdxfmStdPreview }

constructor TdxfmStdPreview.Create(AOwner: TComponent);
begin
  inherited;
  FExplorerContextCommandMenuItems := TList.Create;
  FExplorerContextCommandPopupMenuItems := TList.Create;
  FExplorerContextCommandToolButtons := TList.Create;
{$IFDEF DELPHI7}
  pnlZoomCbx.ParentBackground := False;
  pnlCurrentPage.ParentBackground := False;
{$ENDIF}
end;

destructor TdxfmStdPreview.Destroy; 
begin                                                
  FreeAndNil(FExplorerContextCommandToolButtons);
  FreeAndNil(FExplorerContextCommandPopupMenuItems);
  FreeAndNil(FExplorerContextCommandMenuItems);
  inherited;
end;

procedure TdxfmStdPreview.AfterConstruction;
begin
  FFlatCtrls := True;
  FLargeBtns := False;
  inherited;
  ToolBar.HandleNeeded;
  ToolBar.Realign;
end;

procedure TdxfmStdPreview.Activate;
begin
  inherited;
  Timer1.Enabled := True;
end;

procedure TdxfmStdPreview.DoShow;
begin
  inherited;
  ToolBar.Realign;
end;

procedure TdxfmStdPreview.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = Ord('Z')) and (ssAlt in Shift) and FcbxPredefinedZoom.CanFocus then
    ActiveControl := FcbxPredefinedZoom;
  if (Key = Ord('A')) and (ssAlt in Shift) and FseActivePage.CanFocus then
    ActiveControl := FseActivePage;
end;

procedure TdxfmStdPreview.AddExplorerContextCommand(ACommand: TCustomdxPSExplorerContextCommand);

  function IsCommandSeparator(ACommand: TCustomdxPSExplorerContextCommand): Boolean;
  begin
    Result := ACommand is TdxPSExplorerContextCommandSeparator;
  end;
   
  function AddExplorerContextCommandMenuItem(AParent: TMenuItem; ACommand: TCustomdxPSExplorerContextCommand): TMenuItem;
  begin
    Result := TMenuItem.Create(Self);
    with Result do
    begin
      Bitmap := ACommand.Bitmap;
      Caption := ACommand.Caption;
      Enabled := ACommand.Enabled;
      Hint := ACommand.Hint;
      ShortCut := ACommand.ShortCut;
      Tag := MakeTTag(ACommand);

      OnClick := ExplorerContextCommandClick;
    end;
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

procedure TdxfmStdPreview.UpdateExplorerContextCommands;

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

procedure TdxfmStdPreview.ExplorerContextCommandClick(Sender: TObject);
var
  Command: TCustomdxPSExplorerContextCommand;
  CommandSet2: IdxPSExplorerContextCommands2;
begin
  Command := TCustomdxPSExplorerContextCommand(TTagToObj(TMenuItem(Sender).Tag));
  if Supports(TObject(Explorer), IdxPSExplorerContextCommands2, CommandSet2) then
  begin
    CommandSet2.InitializeCommand(Command);
    try
      if Command.Enabled then Command.Execute; {.1}
    finally
      CommandSet2.FinalizeCommand(Command);
    end;
  end;  
end;

procedure TdxfmStdPreview.CreateControls;
begin
  inherited;

  FseActivePage := TdxPSSpinEdit.Create(Self);
  with TdxPSSpinEdit(FseActivePage) do
  begin
    Parent := pnlCurrentPage;
    Width := pnlCurrentPage.Width - Left;
    //MaxValue := Preview.PageCount;
    Value := 1;
    OnKeyPress := seKeyPress;
    OnButtonClick := seActivePageButtonClick;
    OnExit := seActivePageExit;
  end;

  FcbxPredefinedZoom := TdxZoomFactorComboEdit.Create(pnlZoomCbx);
  with TdxZoomFactorComboEdit(FcbxPredefinedZoom) do
  begin
    Height := FseActivePage.Height;
    DropDownCount := PredefinedZooms.Count;
    OnClick := cbxPredefinedZoomClick;
    OnCloseUp := cbxPredefinedZoomCloseUp;
    OnExit := cbxPredefinedZoomExit;
    OnKeyDown := cbxPredefinedZoomKeyDown;
  end;

  FilToolBarLarge := CreateLargeImages(ilToolBarSmall);
  ToolBarImages[False] := ilToolBarSmall;
  ToolBarImages[True] := FilToolBarLarge;
  ArrangeToolBarCtrls;
  AssignToolBarImages;
  SetupFlatCtrls;

  Preview.PopupMenu := pmPreview;
  
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
  pmExplorer.Images := ilToolBarSmall;
  
  pmiExplorerLoadData.ImageIndex := 23;
  pmiExplorerUnloadData.ImageIndex := 24;
  pmiExplorerCreateFolder.ImageIndex := 20;
  pmiExplorerDelete.ImageIndex := 22;
  pmiExplorerProperties.ImageIndex := 29; 

  pmThumbnails.Images := ilStub;
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
//  miFormatHeaderAndFooter.Caption := cxGetResourceString(@sdxMenuFormatHeaderAndFooter);
  miFormatTitle.Caption := cxGetResourceString(@sdxMenuFormatTitle);
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

  SetHint(tbViewExplorer, cxGetResourceString(@sdxHintViewExplorer), miViewExplorer);
  SetHint(tbViewThumbnails, cxGetResourceString(@sdxHintViewThumbnails), miViewThumbnails);
    
  SetHint(FcbxPredefinedZoom, cxGetResourceString(@sdxHintViewZoom));
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
  SetHint(FseActivePage, cxGetResourceString(@sdxHintActivePage));

  SetHint(tbHelp, cxGetResourceString(@sdxHintHelpTopics), miHelp);
  SetHint(tbClose, cxGetResourceString(@sdxHintFileExit), miFileExit);
end;

procedure TdxfmStdPreview.StyleListChanged(Sender: TObject);
begin
  with ReportLink do
    if Sender = StyleManager then 
    begin
      BuildPageSetupMenu(pmPrintStyles.Items, nil, True);     
      BuildPageSetupMenu(miFilePrintStyles, nil, True);
      BuildPageSetupMenu(pmiFilePrintStyles, nil, True);
    end;  
end;

procedure TdxfmStdPreview.InitContent;
begin
  inherited;

  ThumbnailsPreview.PopupMenu := pmThumbnails;
  
  if IsExplorerAvailable then
    TControlAccess(ExplorerTree.Control).OnMouseUp := DoShowExplorerPopup; 
   
  if ComponentPrinter <> nil then
    TdxPSSpinEdit(FseActivePage).MaxValue := ReportLink.PageCount;
  FcbxPredefinedZoom.Text := IntToStr(ZoomFactor) + PercentSymbol;

  if not IsExplorerAvailable then
  begin
    miFileSave.Caption := dxPSUtl.AddEndEllipsis(miFileSave.Caption);
    miFileLoad.Caption := dxPSUtl.AddEndEllipsis(miFileLoad.Caption);
  end;  
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
  if CanPrintStyle then 
  begin
    Style := ReportLink.StyleManager.CurrentStyle;
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

  DestBounds := MakeBounds(0, 0, Result.Width, Result.Height);
  SourceBounds := MakeBounds(0, 0, ASource.Width, ASource.Height);
  
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

procedure TdxfmStdPreview.DoAfterPrintReport(AShowDialog: Boolean);
begin
  if AShowDialog then
    tbPrint.Hint := cxGetResourceString(@sdxHintFilePrint) + GetCurrentPrinterAsHint;
end;

procedure TdxfmStdPreview.DoPreviewZoomFactorChanged(APreview: TdxPreview);
begin
  FcbxPredefinedZoom.Text := AddPercentSign(IntToStr(ZoomFactor));
  //FPreview.ZoomMode := pzmNone;
end;

procedure TdxfmStdPreview.DoPreviewZoomModeChanged(APreview: TdxPreview);
begin
  FcbxPredefinedZoom.Text := AddPercentSign(IntToStr(ZoomFactor));
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
    if not Locked then UpdateControls;
  end;
end;

procedure TdxfmStdPreview.SetLargeBtns(Value: Boolean);
begin
  if FLargeBtns <> Value then
  begin
    FLargeBtns := Value;
    AssignToolBarImages;
    ArrangeToolBarCtrls;
    if not Locked then UpdateControls;
  end;
end;

procedure TdxfmStdPreview.AssignToolBarImages;
var
  I: Integer;
begin
  ToolBar.Images := ToolBarImages[FLargeBtns];
  with TdxZoomFactorComboEdit(FcbxPredefinedZoom) do
  begin
    Images := ToolBarImages[FLargeBtns];
    for I := 0 to Items.Count - 1 do
      ImageIndexes[I] := ZoomItemIndexes[I];
  end;
end;

procedure TdxfmStdPreview.ArrangeToolBarCtrls;
const
  Widths: array[Boolean] of Integer = (140, 160);
begin
  with ToolBar do
  begin
    Height := ToolBarHeight[FLargeBtns];
    ButtonWidth := ToolBtnSize[FLargeBtns].cx;
    ButtonHeight := ToolBtnSize[FLargeBtns].cy;
  end;
  pnlZoomCbx.Width := Widths[LargeBtns];
  TdxZoomFactorComboEdit(FcbxPredefinedZoom).Width := pnlZoomCbx.Width;
  TdxZoomFactorComboEdit(FcbxPredefinedZoom).Perform(CM_RECREATEWND, 0, 0);
end;

procedure TdxfmStdPreview.SetupFlatCtrls;
begin
  ToolBar.Flat := FFlatCtrls;
  TdxZoomFactorComboEdit(FcbxPredefinedZoom).Flat := FFlatCtrls;
  TdxPSSpinEdit(FseActivePage).Flat := FFlatCtrls;
end;

procedure TdxfmStdPreview.miViewMarginsClick(Sender: TObject);
begin
  if Locked then Exit;
  ShowPageMargins := not ShowPageMargins;
end;

procedure TdxfmStdPreview.pmiFlatBtnsClick(Sender: TObject);
begin
  if Locked then Exit;
  FlatCtrls := not FlatCtrls;
end;

procedure TdxfmStdPreview.pmiLargeBtnsClick(Sender: TObject);
begin
  if Locked then Exit;
  LargeBtns := not LargeBtns;
  if Assigned(Preview) then Preview.Invalidate;
end;

procedure TdxfmStdPreview.miViewMarginBarClick(Sender: TObject);
begin
  if Locked then Exit;
  ShowMarginBar := not ShowMarginBar;
end;

procedure TdxfmStdPreview.miViewStatusBarClick(Sender: TObject);
begin
  if Locked then Exit;
  ShowStatusBar := not ShowStatusBar;
end;

procedure TdxfmStdPreview.DesignClick(Sender: TObject);
begin
  tbReportDesigner.Down := True;
  try
    DoDesignReport;
  finally
    tbReportDesigner.Down := False;
  end;
end;

procedure TdxfmStdPreview.miFileRebuildClick(Sender: TObject);
begin
  RebuildReport;
end;

procedure TdxfmStdPreview.PageBackgroundClick(Sender: TObject);
begin
  tbPageBackground.Down := True;
  try
    DoShowPageBackgroundDlg(CalculateWindowPos(Sender));
  finally
    tbPageBackground.Down := False;
  end;
end;

procedure TdxfmStdPreview.pnlZoomCbxResize(Sender: TObject);
begin
  with TPanel(Sender) do
    FcbxPredefinedZoom.Top := (Height - FcbxPredefinedZoom.Height) div 2 + 1;
end;

procedure TdxfmStdPreview.pnlCurrentPageResize(Sender: TObject);
begin
  with TPanel(Sender) do
    FseActivePage.Top := (Height - FseActivePage.Height) div 2 + 1;
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
      DoPrintReport(Boolean(TTagToInt(TComponent(Sender).Tag)));
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
      DoPageSetupReport(0);
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
    case TTagToInt(TComponent(Sender).Tag) of
      3: PageXCount := 2;
      4: begin
          PageXCount := 2;
          PageYCount := 2;
        end;
      5: ReportLink.GetPageColRowCount(PageXCount, PageYCount);
    end;
  DoSetupZoomFactor(100, PageXCount, PageYCount, ZoomMode);
end;

procedure TdxfmStdPreview.ShrinkToPageWidthClick(Sender: TObject);
begin
  if Locked then Exit;
  if ReportLink <> nil then
  begin
    ReportLink.ShrinkToPageWidth := not ReportLink.ShrinkToPageWidth;
    DoShrinkToPageWidth(ReportLink.ShrinkToPageWidth);
  end;
end;

procedure TdxfmStdPreview.miFormatShowHideEmptyPagesClick(Sender: TObject);
begin
  if Locked then Exit;
  TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
  DoShowEmptyPages(TMenuItem(Sender).Checked);
end;

procedure TdxfmStdPreview.miZoomSetupClick(Sender: TObject);
begin
  DoShowZoomDlg;
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
    DoShowMultiplySelectPagesDlg(ilStub, 1, Origin, YShift);
  finally
    tbMultiplePages.Down := False;
  end;
end;

procedure TdxfmStdPreview.GoToPageClick(Sender: TObject);
begin
  case TTagToInt(TComponent(Sender).Tag) of
    0: GoToFirstPage;
    1: GoToPrevPage;
    2: GoToNextPage;
    3: GoToLastPage;
  end;
end;

procedure TdxfmStdPreview.CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TdxfmStdPreview.HelpClick(Sender: TObject);
begin
  DoInvokeHelp;
end;

procedure TdxfmStdPreview.UpdateControls;
const
  ButtonStyles: array[Boolean] of TToolButtonStyle = (tbsButton, tbsDropDown);
var
  HasPages: Boolean;
  PrevStyle: TToolButtonStyle;
begin
  if Locked then Exit;
  inherited;
  HasPages := FPreview.PageCount > 0;
  BeginUpdate;
  try
    { toolbar enabled }
    tbReportDesigner.Enabled := CanDesign;
    tbFileLoad.Enabled := CanLoadReport;
    tbFileUnload.Enabled := CanUnloadReport;
    tbFileSave.Enabled := CanSaveReport;
    tbPrint.Enabled := CanPrint;
    tbPrintDialog.Enabled := CanPrintDialog;
    tbPageSetup.Enabled := CanPageSetup;
    PrevStyle := tbPageSetup.Style;
    tbPageSetup.Style := ButtonStyles[CanPrintStyle];
    if PrevStyle <> tbPageSetup.Style then 
      if tbPageSetup.Style = tbsButton then 
      begin
        tbPageSetup.Width := ToolBtnSize[LargeBtns].cx;
        SendMessage(ToolBar.Handle, CM_RECREATEWND, 0, 0);
        tbPageSetup.DropDownMenu := nil;
      end
      else
        tbPageSetup.DropDownMenu := pmPrintStyles;
      
    tbClose.Enabled := not IsPrinting;

    tbPageBackground.Enabled := IsEnabled(peoPageBackground) and not IsPrinting;
    tbShrinkToPageWidth.Enabled := HasPages and not IsPrinting;

    tbViewExplorer.Visible := IsExplorerAvailable;
    tbViewExplorer.Down := ShowExplorer;
    tbViewThumbnails.Down := ShowThumbnails;
    
    tbPercent100.Enabled := HasPages;
    tbPageWidth.Enabled := HasPages;
    tbOnePage.Enabled := HasPages;
    tbTwoPage.Enabled := (Preview.PageCount > 1);
    tbFourPage.Enabled := (Preview.PageCount > 3);
    tbMultiplePages.Enabled := HasPages;
    tbWidenToSourceWidth.Enabled := HasPages and not IsPrinting;
    if ReportLink <> nil then
      tbShrinkToPageWidth.Down := ReportLink.ShrinkToPageWidth;

    with TdxZoomFactorComboEdit(FcbxPredefinedZoom) do
    begin
      Enabled := HasPages;
      ItemEnabled[Items.Count - 3] := Preview.PageCount > 1;
      ItemEnabled[Items.Count - 2] := Preview.PageCount > 3;
    end;

    tbGoToFirstPage.Enabled := HasPages and (Preview.SelPageIndex <> 0);
    tbGoToPrevPage.Enabled := HasPages and (Preview.SelPageIndex <> 0);
    tbGoToNextPage.Enabled := HasPages and (Preview.SelPageIndex <> Preview.PageCount - 1);
    tbGoToLastPage.Enabled := HasPages and (Preview.SelPageIndex <> Preview.PageCount - 1);
    FseActivePage.Enabled := Preview.PageCount > 1;

    tbHelp.Enabled := IsEnabled(peoHelp);

    { menus enabled}
    miFileDesign.Enabled := tbReportDesigner.Enabled;
    miFileRebuild.Enabled := CanRebuild;
    miFileSave.Enabled := tbFileSave.Enabled;
    miFileLoad.Enabled := tbFileLoad.Enabled;
    miFileClose.Enabled := tbFileUnload.Enabled;
    miFilePrint.Enabled := tbPrint.Enabled;
    miFilePageSetup.Enabled := tbPageSetup.Enabled;
    miFilePrintStyles.Enabled := tbPageSetup.Enabled;
    miFilePreferences.Enabled := IsEnabled(peoPreferences);
    miFileExit.Enabled := tbClose.Enabled;

    if miFileDesign.Enabled and (ReportLink <> nil) then
      miFileDesign.Enabled := IsEnabled(peoReportDesign) and HasPages and ReportLink.CheckToDesign;

    miExplorer.Enabled := IsExplorerAvailable;
    miExplorerCreateNewFolder.Enabled := IsExplorerAvailable and ExplorerTree.CanCreateFolder;
    miExplorerDelete.Enabled := IsExplorerAvailable and ExplorerTree.CanDeleteSelection;
    if miExplorerDelete.Enabled then
      miExplorerDelete.ShortCut := ShortCut(VK_DELETE, [])
    else
      miExplorerDelete.ShortCut := 0;  
    miExplorerRename.Enabled := IsExplorerAvailable and ExplorerTree.CanRenameSelectedItem;
    miExplorerProperties.Enabled := IsExplorerAvailable and ExplorerTree.CanShowPropertySheetsForSelectedItem;
    
    miFormatAutoText.Enabled := IsAutoHFTextEntriesAvailable;
    miFormatTitle.Enabled := ReportLink.CanChangeTitle;
    miFormatPageBackground.Enabled := tbPageBackground.Enabled;
    miFormatShowHideEmptyPages.Enabled := HasPages and not IsBuilding and not IsPrinting;
    if ReportLink <> nil then
    begin                                  
      miFormatShowHideEmptyPages.Visible := ReportLink.EmptyPagesCanExist;
      miFormatShowHideEmptyPages.Checked := ReportLink.ShowEmptyPages;
    end;
    miFormatShrinkToPageWidth.Enabled := tbShrinkToPageWidth.Enabled;
    miFormatShrinkToPageWidth.Checked := tbShrinkToPageWidth.Down;

    miViewMargins.Checked := ShowPageMargins;
    miViewStatusBar.Checked := ShowStatusBar;
    miViewMarginBar.Checked := ShowMarginBar;
    miViewExplorer.Visible := IsExplorerAvailable;
    miViewExplorer.Checked := ShowExplorer;
    miViewThumbnails.Checked := ShowThumbnails;
    miViewPageHeaders.Enabled := HasPages and not IsBuilding and not IsPrinting;
    miViewPageFooters.Enabled := HasPages and not IsBuilding and not IsPrinting;
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
      tbReportDesigner.Visible := IsVisible(pvoReportDesign);
      tbFileLoad.Visible := IsCommandLoadReportVisible;
      tbFileUnload.Visible := IsCommandUnloadReportVisible;
      tbFileSave.Visible := IsCommandSaveReportVisible;
      
      tbSeparator1.Visible := tbReportDesigner.Visible;

      tbPrint.Visible := IsVisible(pvoPrint);
      tbPrintDialog.Visible := IsVisible(pvoPrint);
      tbPageSetup.Visible := IsVisible(pvoPageSetup);
      tbSeparator2.Visible := (IsVisible(pvoPrint) or IsVisible(pvoPageSetup));

      tbPageBackground.Visible := IsVisible(pvoPageBackground);
      tbSeparator3.Visible := IsVisible(pvoPageBackground);

      tbHelp.Visible := IsVisible(pvoHelp);
      //tbSeparator8.Visible := tbHelp.Visible;
    end;

    { menus visibility }
    miFileLoad.Visible := IsCommandLoadReportVisible;
    miFileSave.Visible := IsCommandSaveReportVisible;
    miFileClose.Visible := IsCommandUnloadReportVisible;
    miFilePreferences.Visible := IsVisible(pvoPreferences);
    miLine1.Visible := miFilePreferences.Visible;

    miFileDesign.Visible := IsVisible(pvoReportDesign);
    miLine2.Visible := miFileDesign.Visible;
    miFilePrint.Visible := tbPrint.Visible;
    miFilePageSetup.Visible := tbPageSetup.Visible;
    miFilePrintStyles.Visible := CanPrintStyle;
    miFormatPageBackground.Visible := tbPageBackground.Visible;
    miLine3.Visible := (miFilePrint.Visible or miFilePageSetup.Visible or miFilePrintStyles.Visible);
    miLine13.Visible := miFormatPageBackground.Visible;
    
    miFormatAutoText.Visible := (ReportLink <> nil) and (ReportLink.StyleManager <> nil);
    miLine14.Visible := miFormatAutoText.Visible;
        
    miViewMargins.Checked := (povMargins in Preview.OptionsView);
    miHelp.Visible := IsVisible(pvoHelp);

    miExplorer.Visible := IsExplorerAvailable;
    //miLine30.Visible := IsExplorerAvailable;

    pmiFlatBtns.Checked := FFlatCtrls; {popup}
    pmiLargeBtns.Checked := FLargeBtns; {popup}
    miViewFlatTBtns.Checked := FFlatCtrls;
    miViewLargeTBtns.Checked := FLargeBtns;

    if ToolBar.Visible then
    begin
      with TdxPSSpinEdit(FseActivePage) do
        if Enabled then
        begin
          MinValue := 1;
          if ReportLink <> nil then
          begin
            MaxValue := ReportLink.PageCount;
            Value := ReportLink.VirtualPageIndexToRealPageIndex(FPreview.SelPageIndex) + 1;
          end
        end
        else
          AsInteger := -1;
    end;

    UpdateExplorerContextCommands;
  finally
    CancelUpdate;
  end;
  ToolBar.Update;
end;

procedure TdxfmStdPreview.cbxPredefinedZoomClick(Sender: TObject);
begin
  SetZoomFactorByText(FcbxPredefinedZoom.Text);
  UpdateControls;
  FcbxPredefinedZoom.Text := AddPercentSign(IntToStr(ZoomFactor));
end;

procedure TdxfmStdPreview.cbxPredefinedZoomCloseUp(Sender: TObject; AAccept: Boolean);
begin
  Windows.SetFocus(Preview.Handle);
end;

procedure TdxfmStdPreview.cbxPredefinedZoomExit(Sender: TObject);
begin
  cbxPredefinedZoomClick(nil);
end;

procedure TdxfmStdPreview.cbxPredefinedZoomKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) or (Key = VK_ESCAPE) then
    Windows.SetFocus(Preview.Handle);
end;

procedure TdxfmStdPreview.seActivePageExit(Sender: TObject);
begin
  if Locked then Exit;
  DoActivePageChanged(TdxPSSpinEdit(FseActivePage).AsInteger - 1);
end;

procedure TdxfmStdPreview.seKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Char(VK_RETURN) then seActivePageExit(Sender);
end;

procedure TdxfmStdPreview.seActivePageButtonClick(Sender: TObject;
  ButtonType: TdxButtonType; Button: TUDBtnType);
begin
  case Button of
    btNext:
      GoToNextPage;
    btPrev:
      GoToPrevPage;
  end;
end;

procedure TdxfmStdPreview.OptionsClick(Sender: TObject);
begin
  DoShowOptionsDlg;
end;

procedure TdxfmStdPreview.SaveToRegistry(const APath: string);
begin
  inherited;
  SavePropertiesToRegistry(APath)
end;

procedure TdxfmStdPreview.LoadFromRegistry(const APath: string);
begin
  inherited;
  LoadPropertiesFromRegistry(APath);
end;

procedure TdxfmStdPreview.SavePropertiesToRegistry(const APath: string);

  procedure DoStore(const ARegistryPath: string);
  begin
    with TRegistry.Create do
    try
      if OpenKey(ARegistryPath, True) then
      try
        WriteBool(sdxFlatCtrls, FlatCtrls);
        WriteBool(sdxLargeBtns, LargeBtns);
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

procedure TdxfmStdPreview.DoShowExplorerPopup(Sender: TObject; Button: TMouseButton; 
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then 
    pmExplorer.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TdxfmStdPreview.LoadPropertiesFromRegistry(const APath: string);
var
  Registry: TRegistry;
begin
  Registry := TRegistry.Create;
  with Registry do
  try
    if OpenKey(APath, False) then
    try
      if ValueExists(sdxFlatCtrls) then 
        FlatCtrls := ReadBool(sdxFlatCtrls);
      if ValueExists(sdxLargeBtns) then 
        LargeBtns := ReadBool(sdxLargeBtns);
    except
      on ERegistryException do
        { ignore }
      else
        raise;
    end;
  finally
    Free;
  end;
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
  pmiFilePrintStyles.Visible := CanPrintStyle;
  CheckItem(pmiFilePrintStyles);
  miLine11.Visible := pmiReportDesign.Visible;
  pmiReportShrinkToPageWidth.Checked := miFormatShrinkToPageWidth.Checked;
  pmiReportShrinkToPageWidth.Enabled := miFormatShrinkToPageWidth.Enabled;
  pmiZoom.Enabled := FPreview.PageCount > 0;
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
  if IsAutoHFTextEntriesAvailable then
    ReportLink.StyleManager.ShowAutoHFTextEntriesDlg;
end;

procedure TdxfmStdPreview.miFormatDateTimeClick(Sender: TObject);
begin
  DoShowFormatDateTimeDlg;
end;

procedure TdxfmStdPreview.miFormatPageNumberingClick(Sender: TObject);
begin
  DoShowFormatPageNumbersDlg;
end;

procedure TdxfmStdPreview.miViewPageHeadersClick(Sender: TObject);
begin
  if Locked then Exit;
  with TMenuItem(Sender) do
  begin
    Checked := not Checked;
    DoShowPageHeaders(Checked);
  end;
end;

procedure TdxfmStdPreview.miViewPageFootersClick(Sender: TObject);
begin
  if Locked then Exit;
  with TMenuItem(Sender) do
  begin
    Checked := not Checked;
    DoShowPageFooters(Checked);
  end;
end;

procedure TdxfmStdPreview.ViewExplorerClick(Sender: TObject);
begin
  if not Locked then 
    ShowExplorer := not ShowExplorer;
end;

procedure TdxfmStdPreview.ViewThumbnailsClick(Sender: TObject);
begin
  if not Locked then 
    ShowThumbnails := not ShowThumbnails;
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
  if BtnClicked then Exit;
  BtnClicked := True;
  try
    if not IsExplorerAvailable then tbFileSave.Down := True;
    try
      DoExplorerCreateNewItem;
    finally
      if not IsExplorerAvailable then tbFileSave.Down := False;
    end;
  finally
    BtnClicked := False;
  end;
end;

procedure TdxfmStdPreview.ExplorerCreateNewFolderClick(Sender: TObject);
begin
  DoExplorerCreateNewFolder;
end;

procedure TdxfmStdPreview.ExplorerDeleteClick(Sender: TObject);
begin
  DoExplorerDeleteItem;
end;

procedure TdxfmStdPreview.ExplorerRenameClick(Sender: TObject);
begin
  DoExplorerRenameItem;
end;

procedure TdxfmStdPreview.ExplorerPropertiesClick(Sender: TObject);
begin
  DoExplorerItemShowPropertySheets;
end;

procedure TdxfmStdPreview.FileLoadClick(Sender: TObject);
const
  BtnClicked: Boolean = False;
begin
  if BtnClicked then Exit;
  BtnClicked := True;
  try
    if not IsExplorerAvailable then tbFileLoad.Down := True;
    try
      DoExplorerLoadItemData;
    finally
      if not IsExplorerAvailable then tbFileLoad.Down := False;
    end;
  finally
    BtnClicked := False;
  end;
end;

procedure TdxfmStdPreview.FileCloseClick(Sender: TObject);
begin
  DoExplorerUnloadItemData;
end;

procedure TdxfmStdPreview.pmExplorerPopup(Sender: TObject);
begin
  UpdateExplorerContextCommands;            
  pmiExplorerLoadData.Enabled := CanLoadReport;
  pmiExplorerUnloadData.Enabled := CanUnloadReport;
  pmiExplorerCreateFolder.Enabled := IsExplorerAvailable and ExplorerTree.CanCreateFolder;
  pmiExplorerDelete.Enabled := IsExplorerAvailable and ExplorerTree.CanDeleteSelection;
  pmiExplorerRename.Enabled := IsExplorerAvailable and ExplorerTree.CanRenameSelectedItem;
  pmiExplorerProperties.Enabled := IsExplorerAvailable and ExplorerTree.CanShowPropertySheetsForSelectedItem;
end;                                                                    

procedure TdxfmStdPreview.miFormatTitleClick(Sender: TObject);
begin
  DoFormatTitle;
end;

procedure TdxfmStdPreview.pmiThumbnailsSizeClick(Sender: TObject);
begin
  ThumbnailsSize := TdxPSThumbnailsSize(TTagToInt(TComponent(Sender).Tag));
end;

procedure TdxfmStdPreview.pmThumbnailsPopup(Sender: TObject);
begin
  if ThumbnailsSize = tsSmall then 
    pmiSmallThumbnails.Checked := True
  else
    pmiLargeThumbnails.Checked := True;
end;

procedure TdxfmStdPreview.WMInitMenu(var Message: TWMInitMenu);
begin
  inherited;
  CheckItem(miFilePrintStyles);
end;

initialization
  dxPSRegisterPreviewWindow(TdxfmStdPreview);

finalization
  dxPSUnregisterPreviewWindow(nil);

end.
