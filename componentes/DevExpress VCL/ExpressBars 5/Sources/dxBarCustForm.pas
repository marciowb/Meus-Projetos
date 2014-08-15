
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressBars customizing form                                }
{                                                                   }
{       Copyright (c) 1998-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSBARS AND ALL ACCOMPANYING VCL }
{   CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.                 }
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

unit dxBarCustForm;

interface

{$I cxVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Menus, Buttons, dxBar;

type
  TdxBarCustomizingFormPainter = class
  protected
    class procedure DrawSubItemArrow(ACanvas: TCanvas; X, Y: Integer; ASelected: Boolean); virtual;
  public
    class function BrushColors(Selected: Boolean; AItem: TdxBarItem): TColor; virtual;
    class procedure DrawButtonOrSubItem(ACanvas: TCanvas; ARect: TRect;
      AItem: TdxBarItem; ACaption: string; Selected: Boolean); virtual;
    class procedure DrawEditOrCombo(ACanvas: TCanvas; ARect: TRect;
      AItem: TdxBarItem; ACaption: string; Selected: Boolean); virtual;
    class procedure DrawFocusedRect(ACanvas: TCanvas; ARect: TRect; AItem: TdxBarItem); virtual;
    class function FontColors(Selected: Boolean): TColor; virtual;
  end;

  TdxBarCustomizingFormPainterClass = class of TdxBarCustomizingFormPainter;

  TdxBarCustomizingFormStandardPainter = class(TdxBarCustomizingFormPainter)
  public
    class procedure DrawFocusedRect(ACanvas: TCanvas; ARect: TRect; AItem: TdxBarItem); override;
  end;

  TdxBarCustomizingFormFlatPainter = class(TdxBarCustomizingFormPainter)
  public
    class function BrushColors(Selected: Boolean; AItem: TdxBarItem): TColor; override;
    class procedure DrawButtonOrSubItem(ACanvas: TCanvas; ARect: TRect;
      AItem: TdxBarItem; ACaption: string; Selected: Boolean); override;
    class procedure DrawEditOrCombo(ACanvas: TCanvas; ARect: TRect;
      AItem: TdxBarItem; ACaption: string; Selected: Boolean); override;
    class function FontColors(Selected: Boolean): TColor; override;
  end;

  TdxBarCustomizingFormOffice11Painter = class(TdxBarCustomizingFormFlatPainter)
  public
    class function BrushColors(Selected: Boolean; AItem: TdxBarItem): TColor; override;
    class procedure DrawButtonOrSubItem(ACanvas: TCanvas; ARect: TRect;
      AItem: TdxBarItem; ACaption: string; Selected: Boolean); override;
    class procedure DrawEditOrCombo(ACanvas: TCanvas; ARect: TRect;
      AItem: TdxBarItem; ACaption: string; Selected: Boolean); override;
    class function FontColors(Selected: Boolean): TColor; override;
  end;

  TdxBarCustomizingFormXPPainter = class(TdxBarCustomizingFormPainter)
  public
    class procedure DrawButtonOrSubItem(ACanvas: TCanvas; ARect: TRect;
      AItem: TdxBarItem; ACaption: string; Selected: Boolean); override;
    class procedure DrawEditOrCombo(ACanvas: TCanvas; ARect: TRect;
      AItem: TdxBarItem; ACaption: string; Selected: Boolean); override;
    class procedure DrawFocusedRect(ACanvas: TCanvas; ARect: TRect; AItem: TdxBarItem); override;
  end;

  TdxBarCustomizingForm = class(TForm)
    Panel1: TPanel;
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    BBarDelete: TButton;
    BBarNew: TButton;
    BBarRename: TButton;
    BClose: TButton;
    LabelToobars: TLabel;
    TabSheet3: TTabSheet;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    LCategories: TListBox;
    LCommandsPlace: TListBox;
    LabelCategories: TLabel;
    LabelCommands: TLabel;
    TabSheet4: TTabSheet;
    LAllCommands: TListBox;
    CBShowCommandsWithShortCut: TCheckBox;
    Panel5: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    DescriptionLabel: TLabel;
    LabelDescription: TLabel;
    Bevel1: TBevel;
    BarManager1: TdxBarManager;
    CategoriesPopupMenu: TdxBarPopupMenu;
    CategoriesAdd: TdxBarButton;
    CategoriesInsert: TdxBarButton;
    CategoriesRename: TdxBarButton;
    CategoriesDelete: TdxBarButton;
    CommandsAdd: TdxBarButton;
    CommandsDelete: TdxBarButton;
    CommandsClear: TdxBarButton;
    CommandsPopupMenu: TdxBarPopupMenu;
    CommandsSubMenuEditor: TdxBarButton;
    CommandsMoveUp: TdxBarButton;
    CommandsMoveDown: TdxBarButton;
    CategoriesVisible: TdxBarButton;
    CategoriesItemsVisible: TdxBarCombo;
    BarsListBoxPlace: TListBox;
    CategoriesPopupButtonPlace: TSpeedButton;
    CommandsPopupButtonPlace: TSpeedButton;
    BBarReset: TButton;
    StandardOptionsPanel: TPanel;
    LabelMenuAnimations: TLabel;
    ComboBoxMenuAnimations: TComboBox;
    CBHint1: TCheckBox;
    CBHint2: TCheckBox;
    CBLargeIcons: TCheckBox;
    EnhancedOptionsPanel: TPanel;
    Label1: TLabel;
    ComboBoxMenuAnimationsEx: TComboBox;
    CBHint1Ex: TCheckBox;
    CBHint2Ex: TCheckBox;
    CBLargeIconsEx: TCheckBox;
    Bevel2: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel3: TBevel;
    CBMenusShowRecentItemsFirst: TCheckBox;
    CBShowFullMenusAfterDelay: TCheckBox;
    BResetUsageData: TButton;
    BHelp: TBitBtn;
    TabSheet5: TTabSheet;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    lbGroups: TListBox;
    btnGroupAdd: TButton;
    btnGroupDelete: TButton;
    lbGroupItems: TListBox;
    btnGroupItemAdd: TButton;
    btnGroupItemDelete: TButton;
    btnMoveUp: TSpeedButton;
    btnMoveDown: TSpeedButton;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PageControlChange(Sender: TObject);
    procedure BHelpClick(Sender: TObject);
    procedure BCloseClick(Sender: TObject);
    procedure BBarNewClick(Sender: TObject);
    procedure BBarRenameClick(Sender: TObject);
    procedure BBarDeleteClick(Sender: TObject);
    procedure BBarResetClick(Sender: TObject);
    procedure LCategoriesClick(Sender: TObject);
    procedure LCategoriesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LCategoriesMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LCategoriesDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure LCategoriesEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure CategoriesPopupMenuPopup(Sender: TObject);
    procedure CategoriesAddClick(Sender: TObject);
    procedure CategoriesInsertClick(Sender: TObject);
    procedure CategoriesRenameClick(Sender: TObject);
    procedure CategoriesItemsVisibleChange(Sender: TObject);
    procedure CategoriesVisibleClick(Sender: TObject);
    procedure CategoriesDeleteClick(Sender: TObject);
    procedure LCommandsClick(Sender: TObject);
    procedure CommandsPopupMenuPopup(Sender: TObject);
    procedure CommandsAddClick(Sender: TObject);
    procedure CommandsDeleteClick(Sender: TObject);
    procedure CommandsClearClick(Sender: TObject);
    procedure CommandsMoveUpClick(Sender: TObject);
    procedure CommandsMoveDownClick(Sender: TObject);
    procedure CommandsSubMenuEditorClick(Sender: TObject);
    procedure CBMenusShowRecentItemsFirstClick(Sender: TObject);
    procedure CBShowFullMenusAfterDelayClick(Sender: TObject);
    procedure BResetUsageDataClick(Sender: TObject);
    procedure CBLargeIconsClick(Sender: TObject);
    procedure CBHint1Click(Sender: TObject);
    procedure CBHint1ExClick(Sender: TObject);
    procedure CBHint2Click(Sender: TObject);
    procedure ComboBoxMenuAnimationsClick(Sender: TObject);
    procedure LAllCommandsClick(Sender: TObject);
    procedure LAllCommandsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure CBShowCommandsWithShortCutClick(Sender: TObject);

    procedure lbGroupsClick(Sender: TObject);
    procedure lbGroupsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure lbGroupsEnter(Sender: TObject);
    procedure lbGroupsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbGroupsMeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure btnGroupAddClick(Sender: TObject);
    procedure btnGroupDeleteClick(Sender: TObject);

    procedure lbGroupItemsClick(Sender: TObject);
    procedure lbGroupItemsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure lbGroupItemsEnter(Sender: TObject);
    procedure lbGroupItemsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGroupItemAddClick(Sender: TObject);
    procedure btnGroupItemDeleteClick(Sender: TObject);

    procedure btnMoveUpClick(Sender: TObject);
    procedure btnMoveDownClick(Sender: TObject);
  private
    BarsListBox: TListBox;
    LCommands: TListBox;
    DontSelectComponent: Boolean;
    FDontSelectGroupItems: Boolean;
    FDraggingCategoryIndex: Integer;
    FManualProcessing: Boolean;
    FRefreshGroupsEnablesLockCount: Integer;
    LastActiveGroupListBox: (glbGroups, glbItems);

    FAllCommandsNameWidth: Integer;
    FAllCommandsCaptionWidth: Integer;
    FAllCommandsShortCutWidth: Integer;

    function GetPainterClass: TdxBarCustomizingFormPainterClass;
    function GetSelectedGroup: TdxBarGroup;
    function GetSelectedGroupItems: TList;
    procedure SetSelectedGroup(Value: TdxBarGroup);
    procedure SetSelectedGroupItems(Value: TList);

    procedure BarsListBoxClick(Sender: TObject);
    procedure MoveCommand(Delta: Integer);
    procedure SelectBarManager;
    procedure CreateAllCommandsListBoxItems;
    procedure RefreshAllCommandsListBox;
    procedure CreateGroupsListBoxItems;
    procedure CreateGroupItemsListBoxItems;
    procedure BeginRefreshGroupsEnables;
    procedure EndRefreshGroupsEnables;
    procedure RefreshGroupsEnables;
    procedure SelectedGroupChanged(RefreshData: Boolean);
    procedure SelectedGroupItemsChanged;

    procedure WMActivate(var Message: TWMActivate); message WM_ACTIVATE;
    procedure WMDestroy(var Message: TWMDestroy); message WM_DESTROY;

    property SelectedGroup: TdxBarGroup read GetSelectedGroup write SetSelectedGroup;
    property SelectedGroupItems: TList read GetSelectedGroupItems write SetSelectedGroupItems;
  protected
    function CanDeleteCategoryItems(ACategoryIndex: Integer): Boolean;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure RefreshGroupsListBox;
    procedure RefreshGroupItemsListBox;
  public
    BarManager: TdxBarManager;
    constructor CreateEx(ABarManager: TdxBarManager);
    destructor Destroy; override;
    procedure MouseWheelHandler(var Message: TMessage); override;
    procedure BarManagerStyleChanged;
    procedure SelectPage(APageIndex: Integer);
    procedure UpdateHelpButton;
    procedure UpdateOptions;
    procedure UpdateVisibility(const AWindowPos: TWindowPos);
    property PainterClass: TdxBarCustomizingFormPainterClass read GetPainterClass;
  end;

procedure dxBarCustomizing(ABarManager: TdxBarManager; AShow: Boolean);
function dxBarCustomizingForm: TdxBarCustomizingForm;

procedure HostBarManagerStyleChanged;
procedure UpdateHelpButton;
procedure DeleteCustomizingBar(ABar: TdxBar);
procedure UpdateCustomizingBars(ABar: TdxBar);
procedure UpdateCustomizingBarItems;
procedure UpdateCustomizingBarItemsEx(AItem: TdxBarItem; Reread: Boolean);
procedure FullUpdateCustomizingBarItems;
procedure UpdateBarManagerOptions;
procedure UpdateCustomizingCommands(AItem: TdxBarItem);
procedure UpdateCustomizingAllCommands;
procedure UpdateGroups;
procedure UpdateGroupItems; 

implementation

{$R *.DFM}

uses
{$IFDEF DELPHI8}
  Types,
{$ENDIF}
  dxBarNameEd, dxBarPopupMenuEd, dxBarItemEd, dxBarStrs, dxBarAddGroupItemsEd,
  TypInfo, dxUxTheme, dxThemeManager, dxThemeConsts, dxOffice11, cxClasses,
  dxCommon, cxGraphics;

const
  AllCommandsIndent = 5;

type
  TDummyBarManager = class(TdxBarManager);
  TDummyBar = class(TdxBar);
  TDummyItem = class(TdxBarItem);
  TDummyContainerItem = class(TCustomdxBarContainerItem);

{ TCheckListBox }

type
  TCheckListBox = class(TListBox)
  private
    FCheckWidth: Integer;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
  protected
    procedure Click; override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure KeyPress(var Key: Char); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure WndProc(var Message: TMessage); override;
  public
    BarManager: TdxBarManager;
    constructor Create(AOwner: TComponent); override;
    procedure InvalidateCheck(Index: Integer);
    procedure ToggleCheck(AIndex: Integer);
  end;

constructor TCheckListBox.Create(AOwner: TComponent);
begin
  inherited;
  Style := lbOwnerDrawFixed;
end;

procedure TCheckListBox.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  inherited;
  ToggleCheck(ItemAtPos(SmallPointToPoint(Message.Pos), True));
end;

procedure TCheckListBox.CNDrawItem(var Message: TWMDrawItem);
begin
  with Message.DrawItemStruct^ do
  begin
    FCheckWidth := rcItem.Bottom - rcItem.Top;
    Inc(rcItem.Left, FCheckWidth);
  end;
  inherited;
end;

procedure TCheckListBox.Click;
begin
  if BarManager.Designing then
    if (0 <= ItemIndex) and (ItemIndex < Items.Count) then
      dxBarDesigner.SelectComponent(BarManager, TdxBar(Items.Objects[ItemIndex]))
    else
      dxBarDesigner.SelectComponent(BarManager, BarManager);
  inherited;
end;

procedure TCheckListBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
const
  Checks: array[Boolean] of Integer = (0, DFCS_CHECKED);
  Inactives: array[Boolean] of Integer = (DFCS_INACTIVE, 0);
begin
  inherited;
  with Rect do
  begin
    Dec(Left, FCheckWidth - 1);
    Right := Left + FCheckWidth - 2;
    InflateRect(Rect, 0, -(Bottom - Top - (Right - Left)) div 2);
  end;
  with TDummyBar(Items.Objects[Index]) do
    DrawFrameControl(Canvas.Handle, Rect, DFC_BUTTON,
      DFCS_BUTTONCHECK or Checks[Visible] or Inactives[CanClose]);
end;

procedure TCheckListBox.KeyPress(var Key: Char);
begin
  inherited;
  if Key = ' ' then ToggleCheck(ItemIndex);
end;

procedure TCheckListBox.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  AIndex: Integer;
begin
  inherited;
  AIndex := ItemAtPos(Point(X, Y), True);
  if (AIndex > -1) and (Items.Count > 0) and
    (X - ItemRect(AIndex).Left < FCheckWidth) then
    ToggleCheck(AIndex);
end;

procedure TCheckListBox.WndProc(var Message: TMessage);
begin
  with Message do
    if (Msg = WM_LBUTTONDBLCLK) and (LOWORD(lParam) < FCheckWidth) then
      Msg := WM_LBUTTONDOWN;
  inherited;
end;

procedure TCheckListBox.InvalidateCheck(Index: Integer);
var
  R: TRect;
begin
  if Index < 0 then Exit;
  R := ItemRect(Index);
  R.Right := R.Left + FCheckWidth;
  InvalidateRect(Handle, @R, True);
  UpdateWindow(Handle);
end;

procedure TCheckListBox.ToggleCheck(AIndex: Integer);
begin
  if (0 <= AIndex) and (AIndex < Items.Count) then
    if TDummyBar(Items.Objects[AIndex]).CanClose then
    begin
      with TdxBar(Items.Objects[AIndex]) do Visible := not Visible;
      InvalidateCheck(AIndex);
      TDummyBarManager(BarManager).DesignerModified;
    end
    else MessageBeep(MB_OK);
end;

{ procedures }

var
  FdxBarCustomizingForm: TdxBarCustomizingForm;
  FCloseCustomizingFormFlag: Boolean;
  FDisabledWindows: TList;

procedure EnableWindows(AFlag: Boolean);
var
  I: Integer;
begin
  if AFlag then
  begin
    for I := 0 to FDisabledWindows.Count - 1 do
      if IsWindow(HWND(FDisabledWindows[I])) then
        EnableWindow(HWND(FDisabledWindows[I]), True);
    FDisabledWindows.Free;
  end
  else
  begin
    FDisabledWindows := TList.Create;
    for I := 0 to dxBarManagerList.Count - 1 do
      with dxBarManagerList[I].MainForm do
        if HandleAllocated then
          if IsWindowEnabled(Handle) then
          begin
            EnableWindow(Handle, False);
            FDisabledWindows.Add(Pointer(Handle));
          end;
  end;
end;

procedure dxBarCustomizing(ABarManager: TdxBarManager; AShow: Boolean);
begin
  if AShow then
  begin
    if FdxBarCustomizingForm <> nil then Exit;

    if Assigned(ABarManager.OnShowCustomizingForm) then
      ABarManager.OnShowCustomizingForm(ABarManager);

    EnableWindows(False);

    FdxBarCustomizingForm := TdxBarCustomizingForm.CreateEx(ABarManager);
    FdxBarCustomizingForm.Show;
  end
  else
  begin
    if not FCloseCustomizingFormFlag then
    begin
      EnableWindows(True);
      FdxBarCustomizingForm.Free;
      FdxBarCustomizingForm := nil;
    end;
    if dxBarSubMenuEditor <> nil then dxBarSubMenuEditor.Free;

    if Assigned(ABarManager.OnHideCustomizingForm) then
      ABarManager.OnHideCustomizingForm(ABarManager);
  end;
end;

function dxBarCustomizingForm: TdxBarCustomizingForm;
begin
  Result := FdxBarCustomizingForm;
end;

procedure HostBarManagerStyleChanged;
begin
  if FdxBarCustomizingForm <> nil then
  begin
    UpdateCustomizingBarItems;
    UpdateBarManagerOptions;
    FdxBarCustomizingForm.BarManagerStyleChanged;
  end;
end;

procedure UpdateHelpButton;
begin
  if FdxBarCustomizingForm <> nil then
    FdxBarCustomizingForm.UpdateHelpButton;
end;

procedure DeleteCustomizingBar(ABar: TdxBar);
var
  I: Integer;
begin
  if FdxBarCustomizingForm <> nil then
    with TCheckListBox(FdxBarCustomizingForm.BarsListBox) do
    begin
      I := Items.IndexOfObject(ABar);
      if I <> -1 then
      begin
        Items.Delete(I);
//TODO:        Click;
      end;
    end;
end;

procedure UpdateCustomizingBars(ABar: TdxBar);
var
  I: Integer;
begin
  if FdxBarCustomizingForm <> nil then
    with TCheckListBox(FdxBarCustomizingForm.BarsListBox) do
    begin
      I := Items.IndexOfObject(ABar);
      if I > -1 then
      begin
        if Items[I] <> ABar.Caption then Items[I] := ABar.Caption;
        Click;
        InvalidateCheck(I);
      end;
    end;
end;

procedure UpdateCustomizingBarItems;
begin
  if FdxBarCustomizingForm <> nil then
    with FdxBarCustomizingForm do
    begin
      LCommands.Invalidate;
      DontSelectComponent := True;
      LCommandsClick(nil);
      DontSelectComponent := False;
      RefreshAllCommandsListBox;
    end;
end;

procedure UpdateCustomizingBarItemsEx(AItem: TdxBarItem; Reread: Boolean);
begin
  if (FdxBarCustomizingForm <> nil) and (AItem <> nil) then
    with FdxBarCustomizingForm do
    begin
      DontSelectComponent := True;
      if (LCategories.ItemIndex <> AItem.Category) or Reread then
      begin
        LCategories.ItemIndex := AItem.Category;
        LCategoriesClick(nil);
      end;
      LCommands.ItemIndex := LCommands.Items.IndexOfObject(AItem);
      LCommandsClick(nil);
      DontSelectComponent := False;
    end;
end;

procedure FullUpdateCustomizingBarItems;
var
  AItemIndex: Integer;
begin
  if FdxBarCustomizingForm <> nil then
    with FdxBarCustomizingForm do
    begin
      if not FManualProcessing then
      begin
        DontSelectComponent := True;
        AItemIndex := LCommands.ItemIndex;
        LCategoriesClick(nil);
        if AItemIndex > LCommands.Items.Count - 1 then
          AItemIndex := LCommands.Items.Count - 1;
        LCommands.ItemIndex := AItemIndex;
        LCommandsClick(nil);
        DontSelectComponent := False;
      end;
      CreateAllCommandsListBoxItems;
      if not FManualProcessing and (PageControl.ActivePage = Tabsheet4) then
        PageControlChange(nil);
    end;
end;

procedure UpdateBarManagerOptions;
begin
  if FdxBarCustomizingForm <> nil then
    FdxBarCustomizingForm.UpdateOptions;
end;

procedure UpdateCustomizingCommands(AItem: TdxBarItem);
begin
  if (FdxBarCustomizingForm <> nil) and
    (FdxBarCustomizingForm.LCategories.ItemIndex = AItem.Category) then
    FdxBarCustomizingForm.LCategoriesClick(nil);
end;

procedure UpdateCustomizingAllCommands;
begin
  if FdxBarCustomizingForm <> nil then
    FdxBarCustomizingForm.RefreshAllCommandsListBox;
end;

procedure UpdateGroups;
begin
  if FdxBarCustomizingForm <> nil then
    FdxBarCustomizingForm.RefreshGroupsListBox;
end;

procedure UpdateGroupItems;
begin
  if (FdxBarCustomizingForm <> nil) and FdxBarCustomizingForm.BarManager.Designing then
    FdxBarCustomizingForm.RefreshGroupItemsListBox;
end;

{ TCommandsListBox }

const
  dxBarGlyphSize = 16;
  dxBarButtonWidth = 23;
  dxBarButtonHeight = 22;
  dxBarComboBoxArrowWidth = 11;

type
  TCommandsListBox = class(TListBox)
  private
    procedure WMEraseBkGnd(var Message: TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure WMMouseActivate(var Message: TWMMouseActivate); message WM_MOUSEACTIVATE;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
  protected
    procedure DblClick; override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MeasureItem(Index: Integer; var Height: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

constructor TCommandsListBox.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csOpaque] - [csCaptureMouse];
  Style := lbOwnerDrawVariable;
end;

procedure TCommandsListBox.WMEraseBkGnd(var Message: TWMEraseBkGnd);
var
  R: TRect;
begin
  R := ClientRect;
  if Items.Count <> 0 then
    R.Top := ItemRect(Items.Count - 1).Bottom;
  FillRect(Message.DC, R, Brush.Handle);
  Message.Result := 1;
end;

procedure TCommandsListBox.WMMouseActivate(var Message: TWMMouseActivate);
var
  P: TPoint;
  AItemIndex: Integer;
begin
  inherited;
  GetCursorPos(P);
  Windows.ScreenToClient(Handle, P);
  AItemIndex := ItemAtPos(P, True);
  if AItemIndex > -1 then ItemIndex := AItemIndex;
end;

procedure TCommandsListBox.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  if (ItemIndex = -1) and (Items.Count > 0) then
  begin
    ItemIndex := 0;
    Click;
  end;
end;

procedure TCommandsListBox.CNDrawItem(var Message: TWMDrawItem);
var
  State: TOwnerDrawState;
  R: TRect;
begin
  if Items.Count > 0 then
  begin
    inherited;
    with Message.DrawItemStruct^ do
    begin
      State := TOwnerDrawState({$IFNDEF DELPHI5}WordRec({$ENDIF}LongRec(itemState).Lo{$IFNDEF DELPHI5}).Lo{$ENDIF});
      R := rcItem;
      if odFocused in State then DrawFocusRect(hDC, R); // hide default draw focus rect
    end;
  end;
end;

procedure TCommandsListBox.DblClick;
var
  AItemIndex: Integer;
  AItem: TdxBarItem;
begin
  AItemIndex := ItemIndex;
  if (0 <= AItemIndex) and (AItemIndex < Items.Count) then
  begin
    AItem := TdxBarItem(Items.Objects[AItemIndex]);
    if AItem.BarManager.Designing then
      dxBarDesigner.ShowDefaultEventHandler(AItem);
  end;
end;

procedure TCommandsListBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  Item: TdxBarItem;
  Selected: Boolean;
  S: string;
  PrevBrushColor, PrevPenColor: Integer;
  R: TRect;

  function FontColors(Selected: Boolean): TColor;
  begin
    Result := dxBarCustomizingForm.PainterClass.FontColors(Selected);
  end;

  function BrushColors(Selected: Boolean): TColor;
  begin
    Result := dxBarCustomizingForm.PainterClass.BrushColors(Selected, Item);
  end;

  procedure DrawButtonOrSubItem;
  begin
    dxBarCustomizingForm.PainterClass.DrawButtonOrSubItem(Canvas, Rect, Item, S, Selected);
  end;

  procedure DrawEditOrCombo;
  begin
    dxBarCustomizingForm.PainterClass.DrawEditOrCombo(Canvas, Rect, Item, S, Selected);
  end;

begin
  Item := TdxBarItem(Items.Objects[Index]);
  if Item = nil then Exit;
  Selected := odSelected in State;
  S := GetTextOf(Item.Caption);
  with Canvas do
  begin
    PrevBrushColor := Brush.Color;
    PrevPenColor := Pen.Color;

    R := Rect;
    if Item is TdxBarEdit then
      DrawEditOrCombo
    else
      DrawButtonOrSubItem;
    if Index = Items.Count - 1 then
    begin
      R := Rect;
      R.Top := R.Bottom;
      R.Bottom := ClientHeight;
      Brush.Color := BrushColors(False);
      FillRect(R);
    end;

    Brush.Color := PrevBrushColor;
    Pen.Color := PrevPenColor;

    if odFocused in State then
      dxBarCustomizingForm.PainterClass.DrawFocusedRect(Canvas, Rect, Item);
  end;
end;

procedure TCommandsListBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  with TdxBarCustomizingForm(GetParentForm(Self)) do
    if BarManager.Designing then
      case Key of
        VK_INSERT: if Shift = [] then CommandsAddClick(nil);
        VK_DELETE: if Shift = [] then CommandsDeleteClick(nil);
        VK_UP:
          if Shift = [ssCtrl] then
          begin
            MoveCommand(-1);
            Key := 0;
          end;
        VK_DOWN:
          if Shift = [ssCtrl] then
          begin
            MoveCommand(1);
            Key := 0;
          end;
      end;
  inherited;
end;

procedure TCommandsListBox.MeasureItem(Index: Integer; var Height: Integer);
begin
  Height := dxBarButtonHeight;
end;

procedure TCommandsListBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  case Button of
    mbLeft:
      if (ItemIndex > -1) and (Items.Count > 0) then
      begin
        Click;
        if DragDetect(Handle, ClientToScreen(Point(X, Y))) then
          TDummyBarManager(dxBarCustomizingForm.BarManager).DragAndDrop(TdxBarItem(Items.Objects[ItemIndex]), nil);
      end;
    mbRight:
      begin
        SetFocus;
        ItemIndex := ItemAtPos(Point(X, Y), True);
        Click;
        with ClientToScreen(Point(X, Y)), TdxBarCustomizingForm(GetParentForm(Self)) do
          if BarManager.Designing then
            CommandsPopupMenu.Popup(X, Y);
      end;
  end;
end;

{ TCheckableButton }

type
  TCheckableButton = class(TGraphicControl)
  private
    FDown: Boolean;
    FDropDownMenu: TdxBarPopupMenu;
    LButtonDown: Boolean;
    procedure SetDown(Value: Boolean);
    procedure SetDropDownMenu(Value: TdxBarPopupMenu);
    procedure DropDownMenuCloseup(Sender: TObject);
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure AdjustWithControl(AControl: TControl);
    property Down: Boolean read FDown write SetDown;
    property DropDownMenu: TdxBarPopupMenu read FDropDownMenu write SetDropDownMenu;
  end;

constructor TCheckableButton.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle - [csCaptureMouse];
end;

procedure TCheckableButton.SetDown(Value: Boolean);
begin
  if FDown <> Value then
  begin
    FDown := Value;
    Repaint;
    if FDown and (FDropDownMenu <> nil) then
      with ClientToScreen(Point(0, Height)) do
        FDropDownMenu.PopupEx(X, Y, 0, Height, True, nil);
  end;
end;

procedure TCheckableButton.SetDropDownMenu(Value: TdxBarPopupMenu);
begin
  if FDropDownMenu <> Value then
  begin
    FDropDownMenu := Value;
    FDropDownMenu.OnCloseup := DropDownMenuCloseup;
  end;
end;

procedure TCheckableButton.DropDownMenuCloseup(Sender: TObject);
var
  P: TPoint;
begin
  if FDown then
  begin
    GetCursorPos(P);
    P := ScreenToClient(P);
    LButtonDown := LeftButtonPressed and PtInRect(ClientRect, P);
    Down := False;
  end;
end;

procedure TCheckableButton.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  Repaint;
end;

procedure TCheckableButton.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  Repaint;
end;

procedure TCheckableButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if LButtonDown then LButtonDown := False
  else
    if Button = mbLeft then Down := True;
end;

procedure TCheckableButton.Paint;
const
  Borders: array[Boolean] of Integer = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
var
  R: TRect;
  P: TPoint;
begin
  with Canvas do
  begin
    R := ClientRect;
    GetCursorPos(P);
    P := ScreenToClient(P);
    if PtInRect(R, P) and GetParentForm(Self).Active or FDown then
      DrawEdge(Handle, R, Borders[FDown], BF_RECT);
    InflateRect(R, -1, -1);
    if FDown then OffsetRect(R, 1, 1);
    Brush.Style := bsClear;
    Font := Self.Font;
    Font.Color := clBtnText;
    cxDrawText(Handle, Caption, R, DT_CENTER or DT_NOCLIP or DT_SINGLELINE or DT_VCENTER);
    Brush.Style := bsSolid;
  end;
end;

procedure TCheckableButton.AdjustWithControl(AControl: TControl);
var
  AAdjustment: Integer;
begin
  AAdjustment := AControl.BoundsRect.Right + 5 - Left;
  SetBounds(Left + AAdjustment, Top, Width - AAdjustment, Height);
end;

{ TdxBarCustomizingFormPainter }

class function TdxBarCustomizingFormPainter.BrushColors(Selected: Boolean; AItem: TdxBarItem): TColor;
begin
  if Selected then
    Result := clHighlight
  else
    Result := clBtnFace;
end;

class procedure TdxBarCustomizingFormPainter.DrawButtonOrSubItem(ACanvas: TCanvas;
  ARect: TRect; AItem: TdxBarItem; ACaption: string; Selected: Boolean);
var
  R: TRect;
  S: string;
  IsGlyph: Boolean;
  W, H: Integer;
  FullImageRect: TRect;
begin
  R := ARect;
  with TDummyItem(AItem) do
    IsGlyph := not Glyph.Empty or ImageIndexLinked;
  with ACanvas, R do
  begin
    Right := Left + dxBarButtonWidth;
    Brush.Color := BrushColors(not IsGlyph and Selected, AItem);
    FillRect(R);
    Pen.Color := Brush.Color;
    MoveTo(Right, Top);
    LineTo(Right, Bottom);

    if IsGlyph then
    begin
      if Selected then
        DrawEdge(Handle, R, BDR_RAISEDINNER, BF_RECT);

      if AItem.Glyph.Empty then
        with AItem.GetCurImages do
        begin
          W := Width;
          H := Height;
        end
      else
        with AItem.Glyph do
        begin
          W := Width;
          H := Height;
        end;
      with R do
        R := Bounds((Left + Right - W) div 2, (Top + Bottom - H) div 2, W, H);
      FullImageRect := R;

      TransparentDraw(Handle, Brush.Handle, FullImageRect, R, AItem.Glyph,
        AItem.GetCurImages, AItem.ImageIndex, True, False, False{Flat},
        Selected, False, False, False{Shadow}, False{Transparent},
        clNone{Faded}, AItem.BarManager.ImageListBkColor);
    end;

    Font.Color := FontColors(Selected);
    Brush.Color := BrushColors(Selected, AItem);
    R := ARect;
    if (AItem is TdxBarButton) and (TdxBarButton(AItem).ButtonStyle = bsDropDown) then
      Dec(R.Right, 4 + 4 + 5);
    Inc(Left, dxBarButtonWidth + 1);
    FillRect(R);
    Inc(Left, 2);
    S := ACaption;
    if (AItem is TCustomdxBarContainerItem) and
      TDummyContainerItem(AItem).HideWhenRun then
      S := '(' + ACaption + ')';
    cxDrawText(Handle, S, R, DT_NOCLIP or DT_NOPREFIX or DT_SINGLELINE or DT_LEFT or DT_VCENTER);

    if (AItem is TdxBarButton) and (TdxBarButton(AItem).ButtonStyle = bsDropDown) then
    begin
      R.Left := R.Right;
      R.Right := ARect.Right;
      if Selected then
      begin
        DrawEdge(Handle, R, BDR_RAISEDINNER, BF_RECT);
        InflateRect(R, -1, -1);
      end
      else
      begin
        Dec(R.Left);
        DrawEdge(Handle, R, EDGE_ETCHED, BF_LEFT);
        Inc(R.Left, 2);
      end;
      Brush.Color := BrushColors(False, AItem);
      FillRect(R);
      Font.Color := FontColors(False);
      DrawSubItemArrow(ACanvas, ARect.Right - (4 + 5), ARect.Top + (dxBarButtonHeight - 7) div 2, False);
    end
    else
      if (AItem is TCustomdxBarSubItem) and not (AItem is TCustomdxBarContainerItem) or
        (AItem is TCustomdxBarContainerItem) and not TDummyContainerItem(AItem).HideWhenRun then
        DrawSubItemArrow(ACanvas, ARect.Right - (4 + 5), ARect.Top + (dxBarButtonHeight - 7) div 2, False);
  end;
end;

class procedure TdxBarCustomizingFormPainter.DrawEditOrCombo(ACanvas: TCanvas;
  ARect: TRect; AItem: TdxBarItem; ACaption: string; Selected: Boolean);
var
  R: TRect;
  S: string;
begin
  R := ARect;
  S := ACaption;
  with ACanvas, R do
  begin
    Font.Color := FontColors(Selected);
    Brush.Color := BrushColors(Selected, AItem);
    Right := Left + 2 + TextWidth(S) + 1;
    FillRect(R);
    Inc(Left, 2);
    cxDrawText(Handle, S, R, DT_NOCLIP or DT_NOPREFIX or DT_SINGLELINE or DT_LEFT or DT_VCENTER);
    Brush.Color := BrushColors(False, AItem);
    FillRect(Rect(Right, Top, Right + 4, Bottom));
    Left := Right + 4;
    Right := ARect.Right;
    if Selected then
      DrawEdge(Handle, R, BDR_SUNKENOUTER, BF_RECT)
    else
      FrameRect(R);
    InflateRect(R, -1, -1);
    FrameRect(R);
    InflateRect(R, -1, -1);
    if AItem is TCustomdxBarCombo then
      Dec(Right, 1 + dxBarComboBoxArrowWidth);
    Brush.Color := clWindow;
    FillRect(R);
    if AItem is TCustomdxBarCombo then
    begin
      Left := Right + 1;
      Right := Left + dxBarComboBoxArrowWidth;
      if Selected then
      begin
        DrawEdge(Handle, R, BDR_RAISEDINNER, BF_RECT);
        Pen.Color := BrushColors(False, AItem);
      end
      else
      begin
        Brush.Color := clBtnHighlight;
        FrameRect(R);
        Pen.Color := Brush.Color;
      end;
      MoveTo(Left - 1, Top);
      LineTo(Left - 1, Bottom);
      InflateRect(R, -1, -1);
      Brush.Color := BrushColors(False, AItem);
      FillRect(R);
      Pen.Color := clBtnText;
      InflateRect(R, 2, 0);
      DrawItemArrow(Handle, R, atDown, True, False, False{Flat});
    end;
  end;
end;

class procedure TdxBarCustomizingFormPainter.DrawFocusedRect(ACanvas: TCanvas;
  ARect: TRect; AItem: TdxBarItem);
begin
end;

class function TdxBarCustomizingFormPainter.FontColors(Selected: Boolean): TColor;
begin
  if Selected then
    Result := clHighlightText
  else
    Result := clBtnText;
end;

class procedure TdxBarCustomizingFormPainter.DrawSubItemArrow(ACanvas: TCanvas;
  X, Y: Integer; ASelected: Boolean);
begin
  with ACanvas do
  begin
    if ASelected and IsHighContrastWhite then
      Pen.Color := clWhite
    else
      Pen.Color := Font.Color;
    Brush.Color := Pen.Color;
    Polygon([Point(X, Y), Point(X, Y + 6), Point(X + 3, Y + 3)]);
  end;
end;

{ TdxBarCustomizingFormStandardPainter }

class procedure TdxBarCustomizingFormStandardPainter.DrawFocusedRect(ACanvas: TCanvas;
  ARect: TRect; AItem: TdxBarItem);
begin
  InflateRect(ARect, -2, -2);
  ACanvas.DrawFocusRect(ARect);
end;

{ TdxBarCustomizingFormFlatPainter }

class function TdxBarCustomizingFormFlatPainter.BrushColors(Selected: Boolean; AItem: TdxBarItem): TColor;
begin
  if Selected then
    Result := TDummyBarManager(AItem.BarManager).FlatToolbarsSelColor
  else
    Result := clWindow;
end;

class procedure TdxBarCustomizingFormFlatPainter.DrawButtonOrSubItem(ACanvas: TCanvas;
  ARect: TRect; AItem: TdxBarItem; ACaption: string; Selected: Boolean);
var
  R: TRect;
  S: string;
  IsGlyph: Boolean;
  W, H: Integer;
  FullImageRect: TRect;
begin
  R := ARect;
  with TDummyItem(AItem) do
    IsGlyph := not Glyph.Empty or ImageIndexLinked;
  with ACanvas, R do
  begin
    Brush.Color := BrushColors(Selected, AItem);
    if Selected then
    begin
      FillRect(R);
      Right := Left + Bottom - Top;
    end
    else
    begin
      Inc(Left, Bottom - Top);
      FillRect(R);
      Right := Left;
      Left := ARect.Left;
      Brush.Color := clBtnFace;
      FillRect(R);
    end;

    if IsGlyph then
    begin
      if AItem.Glyph.Empty then
        with AItem.GetCurImages do
        begin
          W := Width;
          H := Height;
        end
      else
        with AItem.Glyph do
        begin
          W := Width;
          H := Height;
        end;
      with R do
        R := Bounds((Left + Right - W) div 2, (Top + Bottom - H) div 2, W, H);
      FullImageRect := R;
      InflateRect(FullImageRect, 1, 1);

      TransparentDraw(Handle, Brush.Handle, FullImageRect, R, AItem.Glyph,
        AItem.GetCurImages, AItem.ImageIndex, True, False, True{Flat},
        Selected, False, False, True{Shadow}, False{Transparent},
        clNone{Faded}, AItem.BarManager.ImageListBkColor);
    end;
      
    Font.Color := FontColors(Selected);
    Brush.Color := BrushColors(Selected, AItem);
    R := ARect;
    if (AItem is TdxBarButton) and (TdxBarButton(AItem).ButtonStyle = bsDropDown) then
      Dec(R.Right, 4 + 4 + 5);
    Left := Bottom - Top + 10;
    S := ACaption;
    if (AItem is TCustomdxBarContainerItem) and
      TDummyContainerItem(AItem).HideWhenRun then
      S := '(' + ACaption + ')';
    cxDrawText(Handle, S, R, DT_NOCLIP or DT_NOPREFIX or DT_SINGLELINE or DT_LEFT or DT_VCENTER);

    if (AItem is TdxBarButton) and (TdxBarButton(AItem).ButtonStyle = bsDropDown) then
    begin
      R.Left := R.Right;
      R.Right := ARect.Right;
      if Selected then
        FrameFlatSelRect(Handle, R)
      else
        Windows.FrameRect(Handle, R, GetSysColorBrush(COLOR_BTNSHADOW));
      InflateRect(R, -1, -1);
      Brush.Color := BrushColors(Selected, AItem);
      FillRect(R);
      Font.Color := FontColors(False);
      DrawSubItemArrow(ACanvas, ARect.Right - (4 + 5), ARect.Top + (dxBarButtonHeight - 7) div 2, Selected);
    end
    else
      if (AItem is TCustomdxBarSubItem) and not (AItem is TCustomdxBarContainerItem) or
        (AItem is TCustomdxBarContainerItem) and not TDummyContainerItem(AItem).HideWhenRun then
        DrawSubItemArrow(ACanvas, ARect.Right - (4 + 5), ARect.Top + (dxBarButtonHeight - 7) div 2, Selected);
    if Selected then
      FrameFlatSelRect(Handle, ARect);
  end;
end;

class procedure TdxBarCustomizingFormFlatPainter.DrawEditOrCombo(ACanvas: TCanvas;
  ARect: TRect; AItem: TdxBarItem; ACaption: string; Selected: Boolean);
var
  R: TRect;
  S: string;
begin
  R := ARect;
  S := ACaption;
  with ACanvas, R do
  begin
    Font.Color := FontColors(Selected);
    Brush.Color := BrushColors(Selected, AItem);
    Right := Left + 1 + 5 + TextWidth(S) + 5;
    FillRect(R);
    if Selected then
    begin
      Inc(Right);
      FrameFlatSelRect(Handle, R);
      Dec(Right);
    end;
    Inc(Left, 5);
    cxDrawText(Handle, S, R, DT_NOCLIP or DT_NOPREFIX or DT_SINGLELINE or DT_LEFT or DT_VCENTER);
    Brush.Color := BrushColors(False, AItem);
    Left := Right;
    Right := ARect.Right;
    if Selected then
      FrameFlatSelRect(Handle, R)
    else
      Windows.FrameRect(Handle, R, GetSysColorBrush(COLOR_BTNSHADOW));
    InflateRect(R, -1, -1);
    if AItem is TCustomdxBarCombo then
      Dec(Right, 1 + dxBarComboBoxArrowWidth);
    Brush.Color := clWindow;
    FillRect(R);
    if AItem is TCustomdxBarCombo then
    begin
      Left := Right + 1;
      Right := Left + dxBarComboBoxArrowWidth;
      if Selected then
      begin
        InflateRect(R, 1, 1);
        FrameFlatSelRect(Handle, R);
      end
      else
      begin
        Brush.Color := clBtnHighlight;
        FrameRect(R);
        Pen.Color := Brush.Color;
      end;
      if not Selected then
      begin
        MoveTo(Left - 1, Top);
        LineTo(Left - 1, Bottom);
      end;
      InflateRect(R, -1, -1);
      if Selected then
        Brush.Color := TDummyBarManager(AItem.BarManager).FlatToolbarsSelColor
      else
        Brush.Color := BrushColors(False, AItem);
      FillRect(R);
      Pen.Color := clBtnText;
      if Selected then
        InflateRect(R, -1, -1);
      InflateRect(R, 2, 0);
      DrawItemArrow(Handle, R, atDown, True, Selected and IsHighContrastWhite, True{Flat});
    end;
  end;
end;

class function TdxBarCustomizingFormFlatPainter.FontColors(Selected: Boolean): TColor;
begin
  Result := clBtnText;
  if Selected and IsHighContrastWhite then
    Result := clBtnFace;
end;

{ TdxBarCustomizingFormOffice11Painter }

class function TdxBarCustomizingFormOffice11Painter.BrushColors(
  Selected: Boolean; AItem: TdxBarItem): TColor;
begin
  if Selected then
    Result := dxOffice11ToolbarSelectedColor
  else
    Result := dxOffice11MenuColor;
end;

class procedure TdxBarCustomizingFormOffice11Painter.DrawButtonOrSubItem(ACanvas: TCanvas;
  ARect: TRect; AItem: TdxBarItem; ACaption: string; Selected: Boolean);
var
  R: TRect;
  S: string;
  IsGlyph: Boolean;
  W, H: Integer;
  FullImageRect: TRect;
begin
  R := ARect;
  with TDummyItem(AItem) do
    IsGlyph := not Glyph.Empty or ImageIndexLinked;
  with ACanvas, R do
  begin
    Brush.Color := BrushColors(Selected, AItem);
    if Selected then
    begin
      FillRect(R);
      Right := Left + Bottom - Top;
    end
    else
    begin
      Inc(Left, Bottom - Top);
      FillRect(R);
      Right := Left;
      Left := ARect.Left;
      FillTubeGradientRect(Handle, R, dxOffice11MenuIndentColor1, dxOffice11MenuIndentColor2, True);
    end;

    if IsGlyph then
    begin
      if AItem.Glyph.Empty then
        with AItem.GetCurImages do
        begin
          W := Width;
          H := Height;
        end
      else
        with AItem.Glyph do
        begin
          W := Width;
          H := Height;
        end;
      with R do
        R := Bounds((Left + Right - W) div 2, (Top + Bottom - H) div 2, W, H);
      FullImageRect := R;
      InflateRect(FullImageRect, 1, 1);

      TransparentDraw(Handle, Brush.Handle, FullImageRect, R, AItem.Glyph,
        AItem.GetCurImages, AItem.ImageIndex, True, False, False{Flat},
        Selected, False, False, False{Shadow}, True{Transparent},
        clNone{Faded}, AItem.BarManager.ImageListBkColor);
    end;

    Font.Color := FontColors(Selected);
    Brush.Color := BrushColors(Selected, AItem);
    R := ARect;
    if (AItem is TdxBarButton) and (TdxBarButton(AItem).ButtonStyle = bsDropDown) then
      Dec(R.Right, 4 + 4 + 5);
    Left := Bottom - Top + 10;
    S := ACaption;
    if (AItem is TCustomdxBarContainerItem) and
      TDummyContainerItem(AItem).HideWhenRun then
      S := '(' + ACaption + ')';
    cxDrawText(Handle, S, R, DT_NOCLIP or DT_NOPREFIX or DT_SINGLELINE or DT_LEFT or DT_VCENTER);

    if (AItem is TdxBarButton) and (TdxBarButton(AItem).ButtonStyle = bsDropDown) then
    begin
      R.Left := R.Right;
      R.Right := ARect.Right;
      if Selected then
        Office11FrameSelectedRect(Handle, R)
      else
        Windows.FrameRect(Handle, R, dxOffice11BarSeparatorBrush1);
      InflateRect(R, -1, -1);
      Brush.Color := BrushColors(Selected, AItem);
      FillRect(R);
      Font.Color := FontColors(False);
      DrawSubItemArrow(ACanvas, ARect.Right - (4 + 5), ARect.Top + (dxBarButtonHeight - 7) div 2, Selected);
    end
    else
      if (AItem is TCustomdxBarSubItem) and not (AItem is TCustomdxBarContainerItem) or
        (AItem is TCustomdxBarContainerItem) and not TDummyContainerItem(AItem).HideWhenRun then
        DrawSubItemArrow(ACanvas, ARect.Right - (4 + 5), ARect.Top + (dxBarButtonHeight - 7) div 2, Selected);
    if Selected then
      Office11FrameSelectedRect(Handle, ARect);
  end;
end;

class procedure TdxBarCustomizingFormOffice11Painter.DrawEditOrCombo(ACanvas: TCanvas;
  ARect: TRect; AItem: TdxBarItem; ACaption: string; Selected: Boolean);
var
  R: TRect;
  S: string;
  W: Integer;
begin
  // indent
  R := ARect;
  with ACanvas, R do
  begin
    Brush.Color := BrushColors(Selected, AItem);
    // indent
    W := Bottom - Top;
    Right := Left + W;
    if Selected then
      FillRect(R)
    else
      FillTubeGradientRect(ACanvas.Handle, R, dxOffice11MenuIndentColor1, dxOffice11MenuIndentColor2, True);
    ARect.Left := Right;
    // caption
    R := ARect;
    S := ACaption;
    Font.Color := FontColors(Selected);
    Right := Left + 1 + 5 + TextWidth(S) + 10;
    FillRect(R);
    if Selected then
    begin
      Inc(Right);
      Office11FrameSelectedRect(Handle, Rect(R.Left - W, R.Top, R.Right, R.Bottom));
      Dec(Right);
    end;
    Inc(Left, 10);
    cxDrawText(Handle, S, R, DT_NOCLIP or DT_NOPREFIX or DT_SINGLELINE or DT_LEFT or DT_VCENTER);
    Brush.Color := BrushColors(False, AItem);
    Left := Right;
    Right := ARect.Right;
    if Selected then
      Office11FrameSelectedRect(Handle, R)
    else
      Windows.FrameRect(Handle, R, dxOffice11OwnerControlDownedBrush);
    InflateRect(R, -1, -1);
    if AItem is TCustomdxBarCombo then
      Dec(Right, 1 + dxBarComboBoxArrowWidth);
    Brush.Color := clWindow;
    FillRect(R);
    if AItem is TCustomdxBarCombo then
    begin
      Left := Right + 1;
      Right := Left + dxBarComboBoxArrowWidth;
      if Selected then
      begin
        InflateRect(R, 1, 1);
        Office11FrameSelectedRect(Handle, R);
      end
      else
      begin
        Brush.Color := clWindow;
        FrameRect(R);
        Pen.Color := Brush.Color;
      end;
      if not Selected then
      begin
        MoveTo(Left - 1, Top);
        LineTo(Left - 1, Bottom);
      end;
      InflateRect(R, -1, -1);
      if Selected then
        Brush.Color := dxOffice11ToolbarSelectedColor
      else
        Brush.Color := dxOffice11OwnerControlDownedColor;
      FillRect(R);
      Pen.Color := clBtnText;
      if Selected then
        InflateRect(R, -1, -1);
      InflateRect(R, 2, 0);
      DrawItemArrow(Handle, R, atDown, True, Selected and IsHighContrastWhite, True{Flat});
    end;
  end;
end;

class function TdxBarCustomizingFormOffice11Painter.FontColors(
  Selected: Boolean): TColor;
begin
  Result := dxOffice11TextEnabledColor;
  if Selected and IsHighContrastWhite then
    Result := clBtnFace;
end;

{ TdxBarCustomizingFormXPPainter }

class procedure TdxBarCustomizingFormXPPainter.DrawButtonOrSubItem(ACanvas: TCanvas;
  ARect: TRect; AItem: TdxBarItem; ACaption: string; Selected: Boolean);
var
  R: TRect;
  S: string;
  IsGlyph: Boolean;
  W, H: Integer;
  FullImageRect: TRect;
  ATheme: TdxTheme;
begin
  R := ARect;
  with TDummyItem(AItem) do
    IsGlyph := not Glyph.Empty or ImageIndexLinked;
  with ACanvas, R do
  begin
    Right := Left + dxBarButtonWidth;
    Brush.Color := BrushColors(not IsGlyph and Selected, AItem);
    FillRect(R);
    Pen.Color := Brush.Color;
    MoveTo(Right, Top);
    LineTo(Right, Bottom);

    if IsGlyph then
    begin
      if Selected and (AItem is TdxBarButton) then
      begin
        // xp
        ATheme := OpenTheme(totToolBar);
        DrawThemeBackground(ATheme, Handle, TP_BUTTON, TS_HOT, @R);
        // xp end
      end;

      if AItem.Glyph.Empty then
        with AItem.GetCurImages do
        begin
          W := Width;
          H := Height;
        end
      else
        with AItem.Glyph do
        begin
          W := Width;
          H := Height;
        end;
      with R do
        R := Bounds((Left + Right - W) div 2, (Top + Bottom - H) div 2, W, H);
      FullImageRect := R;

      TransparentDraw(Handle, Brush.Handle, FullImageRect, R, AItem.Glyph,
        AItem.GetCurImages, AItem.ImageIndex, True, False, False{Flat},
        Selected, False, False, False{Shadow}, True{Transparent},
        clNone{Faded}, AItem.BarManager.ImageListBkColor);
    end;

    Font.Color := FontColors(Selected);
    Brush.Color := BrushColors(Selected, AItem);
    R := ARect;
    if (AItem is TdxBarButton) and (TdxBarButton(AItem).ButtonStyle = bsDropDown) then
      Dec(R.Right, 4 + 4 + 5);
    Inc(Left, dxBarButtonWidth + 1);
    FillRect(R);
    Inc(Left, 2);
    S := ACaption;
    if (AItem is TCustomdxBarContainerItem) and
      TDummyContainerItem(AItem).HideWhenRun then
      S := '(' + ACaption + ')';
    cxDrawText(Handle, S, R, DT_NOCLIP or DT_NOPREFIX or DT_SINGLELINE or DT_LEFT or DT_VCENTER);

    if (AItem is TdxBarButton) and (TdxBarButton(AItem).ButtonStyle = bsDropDown) then
    begin
      R.Left := R.Right;
      R.Right := ARect.Right;
      Brush.Color := BrushColors(False, AItem);
      FillRect(R);
      // xp
      ATheme := OpenTheme(totToolBar);
      DrawThemeBackground(ATheme, Handle, TP_BUTTON, TS_HOT, @R);
      // xp end
      Font.Color := FontColors(False);
      DrawSubItemArrow(ACanvas, ARect.Right - (4 + 5), ARect.Top + (dxBarButtonHeight - 7) div 2, False);
    end
    else
      if (AItem is TCustomdxBarSubItem) and not (AItem is TCustomdxBarContainerItem) or
        (AItem is TCustomdxBarContainerItem) and not TDummyContainerItem(AItem).HideWhenRun then
        DrawSubItemArrow(ACanvas, ARect.Right - (4 + 5), ARect.Top + (dxBarButtonHeight - 7) div 2, False);
  end;
end;

class procedure TdxBarCustomizingFormXPPainter.DrawEditOrCombo(ACanvas: TCanvas;
  ARect: TRect; AItem: TdxBarItem; ACaption: string; Selected: Boolean);
var
  R, R1: TRect;
  S: string;
  ATheme: TdxTheme;
  AClipRgn: HRGN;
  AClipRgnExists: Boolean;
begin
  R := ARect;
  S := ACaption;
  with ACanvas, R do
  begin
    Font.Color := FontColors(Selected);
    Brush.Color := BrushColors(Selected, AItem);
    Right := Left + 2 + TextWidth(S) + 1;
    FillRect(R);
    Inc(Left, 2);
    cxDrawText(Handle, S, R, DT_NOCLIP or DT_NOPREFIX or DT_SINGLELINE or DT_LEFT or DT_VCENTER);
    Brush.Color := BrushColors(False, AItem);
    FillRect(Rect(Right, Top, Right + 4, Bottom));
    Left := Right + 4;
    Right := ARect.Right;
    // edit border
    FrameRect(R);
    InflateRect(R, -1, -1);
    // combo button
    if AItem is TCustomdxBarCombo then
    begin
      Dec(Right, dxBarComboBoxArrowWidth + 2);
      // xp
      R1 := R;
      R1.Left := R.Right;
      R1.Right := R1.Left + dxBarComboBoxArrowWidth + 2;
      ATheme := OpenTheme(totComboBox);
      DrawThemeBackground(ATheme, Handle, CP_DROPDOWNBUTTON, CBXS_NORMAL, @R1);
    end;
    FillRect(R);
    // xp
    ATheme := OpenTheme(totEdit);
    SaveClipRgn(Handle, AClipRgn, AClipRgnExists);
    R1 := R;
    InflateRect(R1, -1, -1);
    with R1 do
      ExcludeClipRect(Handle, Left, Top, Right, Bottom);
    DrawThemeBackground(ATheme, Handle, EP_EDITTEXT, ETS_NORMAL, @R);
    InflateRect(R, -1, -1);
    RestoreClipRgn(Handle, AClipRgn, AClipRgnExists);
    // xp end
    Brush.Color := clWindow;
    FillRect(R);
  end;
end;

class procedure TdxBarCustomizingFormXPPainter.DrawFocusedRect(ACanvas: TCanvas;
  ARect: TRect; AItem: TdxBarItem);
var
  IsGlyph: Boolean;
begin
//  InflateRect(ARect, -1, -1);
  with TDummyItem(AItem) do
    IsGlyph := not (AItem is TdxBarEdit) and (not Glyph.Empty or ImageIndexLinked);
  if IsGlyph then
    Inc(ARect.Left, dxBarButtonWidth + 1);
  ACanvas.DrawFocusRect(ARect);
end;

{ TdxBarCustomizingForm }

constructor TdxBarCustomizingForm.CreateEx(ABarManager: TdxBarManager);
var
  I: Integer;
  FoundVisibleBar: Boolean;

  function TextWidth(const S: string): Integer;
  var
    DC: HDC;
    PrevFont: HFONT;
    Size: TSize;
  begin
    DC := GetDC(0);
    PrevFont := SelectObject(DC, Font.Handle);
    cxGetTextExtentPoint32(DC, S, Size);
    SelectObject(DC, PrevFont);
    ReleaseDC(0, DC);
    Result := Size.cx;
  end;

  procedure PrepareMenuAnimationsLabel(ALabel: TLabel; ComboBox: TComboBox);
  begin
    with ALabel do
    begin
      Caption := cxGetResourceString(@dxSBAR_MENUANIMATIONS);
      if Left + Width + 10 > ComboBox.Left then
        ComboBox.Left := Left + Width + 10;
    end;
  end;

  procedure PrepareMenuAnimationsComboBox(ComboBox: TComboBox);
  var
    W, I: Integer;
  begin
    with ComboBox, Items do
    begin
      Clear;
      Add(cxGetResourceString(@dxSBAR_MENUANIM1));
      Add(cxGetResourceString(@dxSBAR_MENUANIM2));
      Add(cxGetResourceString(@dxSBAR_MENUANIM3));
      Add(cxGetResourceString(@dxSBAR_MENUANIM4));
      Add(cxGetResourceString(@dxSBAR_MENUANIM5));
      W := 0;
      for I := 0 to Count - 1 do
        if TextWidth(Items[I]) > W then W := TextWidth(Items[I]);
      Width := W + 54;
    end;
  end;

{$IFDEF DELPHI7}

  procedure SetupBevelSize(ALabel: TLabel; ABevel: TBevel);
  begin
    with ABevel, BoundsRect do
      BoundsRect := Rect(ALabel.BoundsRect.Right, Top, Right, Bottom);
  end;

{$ENDIF}

begin
  BarManager := ABarManager;
  inherited Create(nil);
  Font.Name := BarManager.Font.Name;
  Font.Charset := BarManager.Font.Charset;
  BarManager1.Font := BarManager.Font;

  // Global

  Caption := cxGetResourceString(@dxSBAR_CAPTION);
  TabSheet1.Caption := cxGetResourceString(@dxSBAR_TABSHEET1);
  TabSheet2.Caption := cxGetResourceString(@dxSBAR_TABSHEET2);
  TabSheet3.Caption := cxGetResourceString(@dxSBAR_TABSHEET3);
  with BClose do
  begin
    Caption := cxGetResourceString(@dxSBAR_CLOSE);
    Width := TextWidth(GetTextOf(Caption)) + 49;
    Left := Parent.Width - Panel3.Width - Width;
  end;
  UpdateHelpButton;

  // Toolbars sheet
  
  BarsListBox := TCheckListBox.Create(Self);
  with TCheckListBox(BarsListBox) do
  begin
    BarManager := Self.BarManager;
    BoundsRect := BarsListBoxPlace.BoundsRect;
    OnClick := BarsListBoxClick;
    Parent := BarsListBoxPlace.Parent;
    Canvas.Font := Font;
    ItemHeight := Canvas.TextHeight('0') + 2;
    TabOrder := BarsListBoxPlace.TabOrder;
  end;
  BarsListBoxPlace.Free;
  if BarManager.Designing or not TDummyBarManager(BarManager).CanReset then
    BBarReset.Hide;
  LabelToobars.FocusControl := BarsListBox;
  LabelToobars.Caption := cxGetResourceString(@dxSBAR_TOOLBARS);
  BBarNew.Caption := cxGetResourceString(@dxSBAR_TNEW);
  BBarRename.Caption := cxGetResourceString(@dxSBAR_TRENAME);
  BBarDelete.Caption := cxGetResourceString(@dxSBAR_TDELETE);
  BBarReset.Caption := cxGetResourceString(@dxSBAR_TRESET);

  // Commands sheet

  LCommands := TCommandsListBox.Create(Self);
  with LCommands do
  begin
    BoundsRect := LCommandsPlace.BoundsRect;
    OnClick := LCommandsClick;
    Parent := LCommandsPlace.Parent;
    TabOrder := LCommandsPlace.TabOrder;
  end;
  LCommandsPlace.Free;
  LabelCommands.FocusControl := LCommands;

  if BarManager.Designing then
  begin
    with TCheckableButton.Create(Self) do
    begin
      Caption := cxGetResourceString(@dxSBAR_MODIFY);
      BoundsRect := CategoriesPopupButtonPlace.BoundsRect;
      AdjustWithControl(LabelCategories);
      DropDownMenu := CategoriesPopupMenu;
      Parent := CategoriesPopupButtonPlace.Parent;
    end;
    with TCheckableButton.Create(Self) do
    begin
      Caption := cxGetResourceString(@dxSBAR_MODIFY);
      BoundsRect := CommandsPopupButtonPlace.BoundsRect;
      AdjustWithControl(LabelCommands);
      DropDownMenu := CommandsPopupMenu;
      Parent := CommandsPopupButtonPlace.Parent;
    end;
  end;
  CategoriesPopupButtonPlace.Free;
  CommandsPopupButtonPlace.Free;

  LabelCategories.Caption := cxGetResourceString(@dxSBAR_CATEGORIES);
  LabelCommands.Caption := cxGetResourceString(@dxSBAR_COMMANDS);
  LabelDescription.Caption := cxGetResourceString(@dxSBAR_DESCRIPTION);

  CategoriesAdd.Caption := cxGetResourceString(@dxSBAR_ADDEX);
  CategoriesInsert.Caption := cxGetResourceString(@dxSBAR_INSERTEX);
  CategoriesRename.Caption := cxGetResourceString(@dxSBAR_RENAMEEX);
  CategoriesVisible.Caption := cxGetResourceString(@dxSBAR_VISIBLE);
  CategoriesDelete.Caption := cxGetResourceString(@dxSBAR_DELETE);

  CommandsAdd.Caption := cxGetResourceString(@dxSBAR_ADDEX);
  CommandsDelete.Caption := cxGetResourceString(@dxSBAR_DELETE);
  CommandsClear.Caption := cxGetResourceString(@dxSBAR_CLEAR);
  CommandsMoveUp.Caption := cxGetResourceString(@dxSBAR_MOVEUP);
  CommandsMoveDown.Caption := cxGetResourceString(@dxSBAR_MOVEDOWN);
  CommandsSubMenuEditor.Caption := cxGetResourceString(@dxSBAR_SUBMENUEDITOR);

  // Options sheet

  if BarManager.GetPaintStyle = bmsStandard then
  begin
    CBLargeIcons.Caption := cxGetResourceString(@dxSBAR_LARGEICONS);
    CBHint1.Caption := cxGetResourceString(@dxSBAR_HINTOPT1);
    CBHint2.Caption := cxGetResourceString(@dxSBAR_HINTOPT2);
    PrepareMenuAnimationsLabel(LabelMenuAnimations, ComboBoxMenuAnimations);
    PrepareMenuAnimationsComboBox(ComboBoxMenuAnimations);
  end
  else
  begin
    Label3.Caption := cxGetResourceString(@dxSBAR_PERSMENUSANDTOOLBARS);
    CBMenusShowRecentItemsFirst.Caption := cxGetResourceString(@dxSBAR_MENUSSHOWRECENTITEMS);
    CBShowFullMenusAfterDelay.Caption := cxGetResourceString(@dxSBAR_SHOWFULLMENUSAFTERDELAY);
    with BResetUsageData do
    begin
      Caption := cxGetResourceString(@dxSBAR_RESETUSAGEDATA);
      Width := TextWidth(GetTextOf(Caption)) + 17;
    end;
    Label2.Caption := cxGetResourceString(@dxSBAR_OTHEROPTIONS);
    CBLargeIconsEx.Caption := cxGetResourceString(@dxSBAR_LARGEICONS);
    CBHint1Ex.Caption := cxGetResourceString(@dxSBAR_HINTOPT1);
    CBHint2Ex.Caption := cxGetResourceString(@dxSBAR_HINTOPT2);
    PrepareMenuAnimationsLabel(Label1, ComboBoxMenuAnimationsEx);
    PrepareMenuAnimationsComboBox(ComboBoxMenuAnimationsEx);
  end;

  // All Commands sheet

  if not BarManager.Designing then Tabsheet4.TabVisible := False;

  // Groups sheet

  if not BarManager.Designing then Tabsheet5.TabVisible := False;

  FoundVisibleBar := False;
  BarsListBox.Items.BeginUpdate;
  for I := 0 to BarManager.Bars.Count - 1 do
    if BarManager.Designing or not BarManager.Bars[I].Hidden then
    begin
      BarsListBox.Items.AddObject(BarManager.Bars[I].Caption, BarManager.Bars[I]);
      if not FoundVisibleBar and BarManager.Bars[I].Visible then
      begin
        BarsListBox.ItemIndex := I;
        FoundVisibleBar := True;
      end;
    end;
  BarsListBox.Items.EndUpdate;

  LCategories.Items.BeginUpdate;
  try
    for I := 0 to BarManager.Categories.Count - 1 do
      if BarManager.Designing or BarManager.CategoryVisible[I] then
        LCategories.Items.Add(ABarManager.Categories[I]);
    if LCategories.Items.Count > 0 then LCategories.ItemIndex := 0;
  finally
    LCategories.Items.EndUpdate;
  end;
  LCategoriesClick(nil);

  BarManagerStyleChanged;
  UpdateOptions;

  CreateAllCommandsListBoxItems;

  CreateGroupsListBoxItems;
                                         
{$IFDEF DELPHI7}
  SetupBevelSize(LabelDescription, Bevel1);
  SetupBevelSize(Label3, Bevel3);
  SetupBevelSize(Label2, Bevel2);
{$ENDIF}
end;

destructor TdxBarCustomizingForm.Destroy;
var
  ABarManager: TdxBarManager;
begin
  if not FCloseCustomizingFormFlag then
  begin
    FCloseCustomizingFormFlag := True;
    BarManager.Customizing(False);
  end;
  ABarManager := BarManager;
  inherited;
  FCloseCustomizingFormFlag := False;
  FdxBarCustomizingForm := nil;

  if not (csDestroying in ABarManager.ComponentState) and ABarManager.Designing then
    dxBarDesigner.SelectComponent(ABarManager, ABarManager);
end;

procedure TdxBarCustomizingForm.MouseWheelHandler(var Message: TMessage);
var
  P: TPoint;
  R: TRect;
  H: HWND;
  AControl: TWinControl;

  I, AScrollCode, AScrollLines: Integer;
begin
  P := SmallPointToPoint(TWMMouseWheel(Message).Pos);
  H := WindowFromPoint(P);
  if H <> 0 then
  begin
    GetWindowRect(H, R);
    AControl := FindControl(H);
    if (AControl is TCustomListBox) and PtInRect(R, P) and
      not (ActiveControl is TCustomListBox) then
    begin
      if SmallInt(HIWORD(Message.wParam)) > 0 then
        AScrollCode := SB_LINEUP
      else
        AScrollCode := SB_LINEDOWN;
      AScrollLines := {$IFDEF DELPHI4}Mouse.WheelScrollLines{$ELSE}3{$ENDIF};
      for I := 0 to AScrollLines - 1 do
        SendMessage(AControl.Handle, WM_VSCROLL, AScrollCode, 0);
      Exit;
    end;
  end;
  inherited MouseWheelHandler(Message);
end;

function TdxBarCustomizingForm.GetPainterClass: TdxBarCustomizingFormPainterClass;
begin
  if BarManager.PainterClass = TdxBarItemControlXPPainter then
    Result := TdxBarCustomizingFormXPPainter
  else
    if BarManager.PainterClass = TdxBarItemControlOffice11Painter then
      Result := TdxBarCustomizingFormOffice11Painter
    else
      if BarManager.PainterClass = TdxBarItemControlFlatPainter then
        Result := TdxBarCustomizingFormFlatPainter
      else
        Result := TdxBarCustomizingFormStandardPainter;
end;

function TdxBarCustomizingForm.GetSelectedGroup: TdxBarGroup;
begin
  with lbGroups do
    if ItemIndex = -1 then
      Result := nil
    else
      Result := TdxBarGroup(Items.Objects[ItemIndex]);
end;

function TdxBarCustomizingForm.GetSelectedGroupItems: TList;
var
  I: Integer;
begin
  Result := TList.Create;
  with lbGroupItems do
    for I := 0 to Items.Count - 1 do
      if Selected[I] then
        Result.Add(Items.Objects[I]);
end;

procedure TdxBarCustomizingForm.SetSelectedGroup(Value: TdxBarGroup);
begin
  if SelectedGroup <> Value then
  begin
    with lbGroups do
      ItemIndex := Items.IndexOfObject(Value);
    SelectedGroupChanged(True);
  end;
end;

procedure TdxBarCustomizingForm.SetSelectedGroupItems(Value: TList);
var
  I, J: Integer;
begin
  with lbGroupItems, Items do
  begin
    BeginUpdate;
    try
      for I := 0 to Count - 1 do
      begin
        J := Value.IndexOf(Objects[I]);
        lbGroupItems.Selected[I] := J <> -1;
      end;
    finally
      EndUpdate;
      Value.Free;
      SelectedGroupItemsChanged;
    end;
  end;
end;

procedure TdxBarCustomizingForm.BarsListBoxClick(Sender: TObject);
var
  EnableChange: Boolean;
  Bar: TdxBar;
begin
  EnableChange := (BarsListBox.ItemIndex > -1) and (BarsListBox.Items.Count > 0);
  if EnableChange then
    with BarsListBox do
      Bar := TdxBar(Items.Objects[ItemIndex])
  else
    Bar := nil;
  if not BarManager.Designing then
    EnableChange := EnableChange and not Bar.IsPredefined;
  BBarNew.Enabled := not BarManager.Designing or dxBarDesigner.CanAddComponent(BarManager);
  BBarRename.Enabled := EnableChange;
  BBarDelete.Enabled := EnableChange and
    (BarManager.Designing and dxBarDesigner.CanDeleteComponent(BarManager, nil) or
     not BarManager.Designing and TDummyBar(Bar).CanClose);
  BBarReset.Enabled := (Bar <> nil) and TDummyBar(Bar).CanReset;
end;

procedure TdxBarCustomizingForm.MoveCommand(Delta: Integer);
var
  AItemIndex: Integer;
begin
  with LCommands do
  begin
    AItemIndex := ItemIndex;
    if (Delta = -1) and (AItemIndex = 0) or
      (Delta = 1) and (AItemIndex = Items.Count - 1) then Exit;
    BarManager.ExchangeItems(
      TdxBarItem(Items.Objects[AItemIndex]).Index,
      TdxBarItem(Items.Objects[AItemIndex + Delta]).Index);
    Items.Exchange(AItemIndex, AItemIndex + Delta);
    ItemIndex := AItemIndex + Delta;
  end
end;

procedure TdxBarCustomizingForm.SelectBarManager;
begin
  if BarManager.Designing and not DontSelectComponent then
    dxBarDesigner.SelectComponent(BarManager, BarManager);
end;

procedure TdxBarCustomizingForm.CreateAllCommandsListBoxItems;
var
  PrevTopIndex, PrevItemIndex, I: Integer;
begin
  if not BarManager.Designing then Exit;
  with LAllCommands, Items do
  begin
    SendMessage(Handle, WM_SETREDRAW, WPARAM(False), 0);
    PrevTopIndex := TopIndex;
    PrevItemIndex := ItemIndex;
    BeginUpdate;
    try
      Clear;
      for I := 0 to BarManager.ItemCount - 1 do
        if (BarManager.Items[I].Category >= 0) and
          (not CBShowCommandsWithShortCut.Checked or
           (GetPropInfo(BarManager.Items[I].ClassInfo, 'ShortCut') <> nil)) then
          AddObject('', BarManager.Items[I]);
    finally
      TopIndex := PrevTopIndex;
      ItemIndex := PrevItemIndex;
      EndUpdate;
      SendMessage(Handle, WM_SETREDRAW, WPARAM(True), 0);
    end;
  end;
  RefreshAllCommandsListBox;
end;

procedure TdxBarCustomizingForm.RefreshAllCommandsListBox;
var
  I, W: Integer;
begin
  with LAllCommands, Items do
  begin
    Canvas.Font := Font;
    FAllCommandsNameWidth := 0;
    FAllCommandsCaptionWidth := 0;
    FAllCommandsShortCutWidth := 0;
    for I := 0 to Count - 1 do
      with TdxBarItem(Items.Objects[I]) do
      begin
        W := Canvas.TextWidth(Name);
        if W > FAllCommandsNameWidth then FAllCommandsNameWidth := W;
        W := Canvas.TextWidth(Caption);
        if W > FAllCommandsCaptionWidth then FAllCommandsCaptionWidth := W;
        W := Canvas.TextWidth(ShortCutToText(ShortCut));
        if W > FAllCommandsShortCutWidth then FAllCommandsShortCutWidth := W;
      end;
    Invalidate;
  end;
  SendMessage(LAllCommands.Handle, LB_SETHORIZONTALEXTENT,
    AllCommandsIndent + FAllCommandsNameWidth + AllCommandsIndent +
    AllCommandsIndent + FAllCommandsCaptionWidth + AllCommandsIndent +
    AllCommandsIndent + FAllCommandsShortCutWidth + AllCommandsIndent, 0);
end;

procedure TdxBarCustomizingForm.CreateGroupsListBoxItems;
var
  I: Integer;
  PrevGroup, Group: TdxBarGroup;
begin
  if not BarManager.Designing then Exit;
  PrevGroup := SelectedGroup;
  with lbGroups, Items do
  begin
    BeginUpdate;
    try
      Clear;
      for I := 0 to BarManager.GroupCount - 1 do
      begin
        Group := BarManager.Groups[I];
        AddObject(Group.Name, Group);
      end;
    finally
      SelectedGroup := PrevGroup;
      EndUpdate;
    end;
  end;
  RefreshGroupsEnables;
end;

procedure TdxBarCustomizingForm.CreateGroupItemsListBoxItems;
var
  I: Integer;
  Group: TdxBarGroup;
  Item: TComponent;
begin
  with lbGroupItems, Items do
  begin
    BeginUpdate;
    try
      Clear;
      Group := SelectedGroup;
      if Group <> nil then
        for I := 0 to Group.Count - 1 do
        begin
          Item := Group[I];
          AddObject(Item.Name, Item);
        end;
    finally
      EndUpdate;
    end;
  end;
  RefreshGroupsEnables;
end;

procedure TdxBarCustomizingForm.BeginRefreshGroupsEnables;
begin
  Inc(FRefreshGroupsEnablesLockCount);
end;

procedure TdxBarCustomizingForm.EndRefreshGroupsEnables;
begin
  if FRefreshGroupsEnablesLockCount > 0 then
  begin
    Dec(FRefreshGroupsEnablesLockCount);
    if FRefreshGroupsEnablesLockCount = 0 then
      RefreshGroupsEnables;
  end;
end;

procedure TdxBarCustomizingForm.RefreshGroupsEnables;
var
  AEnabled, MoveEnabled: Boolean;
  List: TList;
  I: Integer;
begin
  if FRefreshGroupsEnablesLockCount <> 0 then Exit;
  AEnabled := SelectedGroup <> nil;
  btnGroupAdd.Enabled := dxBarDesigner.CanAddComponent(BarManager);
  btnGroupDelete.Enabled := AEnabled and
    dxBarDesigner.CanDeleteComponent(BarManager, SelectedGroup);
  btnGroupItemAdd.Enabled := AEnabled;
  List := SelectedGroupItems;
  try
    btnGroupItemDelete.Enabled := List.Count <> 0;
    if LastActiveGroupListBox = glbGroups then
      MoveEnabled := AEnabled and (SelectedGroup.Index > 0)
    else
    begin
      MoveEnabled := False;
      for I := 0 to List.Count - 1 do
        if lbGroupItems.Items.IndexOfObject(List[I]) <> I then
        begin
          MoveEnabled := True;
          Break;
        end;
    end;
    btnMoveUp.Enabled := MoveEnabled;
    if LastActiveGroupListBox = glbGroups then
      MoveEnabled := AEnabled and (SelectedGroup.Index < BarManager.GroupCount - 1)
    else
    begin
      MoveEnabled := False;
      for I := 0 to List.Count - 1 do
        if lbGroupItems.Items.IndexOfObject(List[I]) <>
          lbGroupItems.Items.Count - List.Count + I then
        begin
          MoveEnabled := True;
          Break;
        end;
    end;
    btnMoveDown.Enabled := MoveEnabled;
  finally
    List.Free;
  end;
end;

procedure TdxBarCustomizingForm.SelectedGroupChanged(RefreshData: Boolean);
var
  Group: TdxBarGroup;
begin
  if RefreshData then CreateGroupItemsListBoxItems;
  Group := SelectedGroup;
  if Group = nil then
    SelectBarManager
  else
    dxBarDesigner.SelectComponent(BarManager, Group);
end;

procedure TdxBarCustomizingForm.SelectedGroupItemsChanged;
var
  List: TList;
begin
  RefreshGroupsEnables;
  if not FDontSelectGroupItems then
  begin
    List := SelectedGroupItems;
    try
      if List.Count = 1 then
        dxBarDesigner.SelectComponent(BarManager, TPersistent(List[0]))
      else
        SelectedGroupChanged(False);
    finally
      List.Free;
    end;
  end;  
end;

procedure TdxBarCustomizingForm.WMActivate(var Message: TWMActivate);
begin
  inherited;
  if not (csDestroying in ComponentState) then
    with TMessage(Message) do
    begin
      if //(wParam <> WA_INACTIVE) and
        (HWND(lParam) <> BarManager.MainForm.Handle) then
        SendMessage(BarManager.MainForm.Handle, Msg, wParam, lParam);
      if (wParam <> WA_INACTIVE) and (dxBarCustomizingPopup = nil) then
        PageControlChange(nil);
    end;
end;

procedure TdxBarCustomizingForm.WMDestroy(var Message: TWMDestroy);
begin
  inherited;
  BarManager.Customizing(False);
end;

function TdxBarCustomizingForm.CanDeleteCategoryItems(ACategoryIndex: Integer): Boolean;
var
  AItems: TList;
  I: Integer;
begin
  Result := ACategoryIndex <> -1;
  if not Result then Exit;
  AItems := TList.Create;
  try
    BarManager.GetAllItemsByCategory(ACategoryIndex, AItems);
    for I := 0 to AItems.Count - 1 do
    begin
      Result := dxBarDesigner.CanDeleteComponent(BarManager, TComponent(AItems[I]));
      if not Result then Break;
    end;
  finally
    AItems.Free;
  end;
end;

procedure TdxBarCustomizingForm.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
  begin
    Style := WS_POPUP or WS_CLIPSIBLINGS or WS_SYSMENU or WS_CAPTION;
    ExStyle := WS_EX_DLGMODALFRAME or WS_EX_WINDOWEDGE;
    WindowClass.Style := CS_OWNDC or CS_SAVEBITS;
    WndParent := BarManager.MainForm.Handle;
  end;
end;

procedure TdxBarCustomizingForm.RefreshGroupsListBox;
begin
  CreateGroupsListBoxItems;
end;

procedure TdxBarCustomizingForm.RefreshGroupItemsListBox;
var
  List: TList;
begin
  List := SelectedGroupItems;
  try
    BeginRefreshGroupsEnables;
    try
      lbGroupItems.Items.BeginUpdate;
      try
        CreateGroupItemsListBoxItems;
        FDontSelectGroupItems := True;
        try
          SelectedGroupItems := List;
        finally
          FDontSelectGroupItems := False;
        end;
      finally
        lbGroupItems.Items.EndUpdate;
      end;
    finally
      EndRefreshGroupsEnables;
    end;
  except
    List.Free;
    raise;
  end;
end;

procedure TdxBarCustomizingForm.BarManagerStyleChanged;
begin
  BarManager1.Style := BarManager.Style;
  BarManager1.LookAndFeel := BarManager.LookAndFeel;
  if BarManager.GetPaintStyle = bmsFlat then
    LCommands.Color := clWindow
  else
    LCommands.Color := clBtnFace;
end;

procedure TdxBarCustomizingForm.SelectPage(APageIndex: Integer);
begin
  with PageControl do
    ActivePage := Pages[APageIndex];
  PageControlChange(nil);
end;

procedure TdxBarCustomizingForm.UpdateHelpButton;
begin
  BHelp.Glyph := BarManager.HelpButtonGlyph;
  BHelp.Visible := BarManager.ShowHelpButton;
end;

procedure TdxBarCustomizingForm.UpdateOptions;
begin
  StandardOptionsPanel.Visible := BarManager.GetPaintStyle = bmsStandard;
  EnhancedOptionsPanel.Visible := BarManager.GetPaintStyle <> bmsStandard;

  CBMenusShowRecentItemsFirst.Checked := BarManager.MenusShowRecentItemsFirst;
  CBShowFullMenusAfterDelay.Checked := BarManager.ShowFullMenusAfterDelay;
  CBShowFullMenusAfterDelay.Enabled := CBMenusShowRecentItemsFirst.Checked;

  CBLargeIcons.Checked := BarManager.LargeIcons;
  CBLargeIconsEx.Checked := BarManager.LargeIcons;
  CBHint1.Checked := BarManager.ShowHint;
  CBHint1Ex.Checked := BarManager.ShowHint;
  CBHint2.Checked := BarManager.ShowShortcutInHint;
  CBHint2Ex.Checked := BarManager.ShowShortcutInHint;
  CBHint2Ex.Enabled := CBHint1Ex.Checked;
  ComboBoxMenuAnimations.ItemIndex := Ord(BarManager.MenuAnimations);
  ComboBoxMenuAnimationsEx.ItemIndex := Ord(BarManager.MenuAnimations);
end;

procedure TdxBarCustomizingForm.UpdateVisibility(const AWindowPos: TWindowPos);
begin
  if AWindowPos.flags and SWP_SHOWWINDOW <> 0 then
    ShowWindow(Handle, SW_SHOW)
  else
    if AWindowPos.flags and SWP_HIDEWINDOW <> 0 then
      ShowWindow(Handle, SW_HIDE);
end;

procedure TdxBarCustomizingForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  EnableWindows(True);
  Action := caFree;
end;

procedure TdxBarCustomizingForm.PageControlChange(Sender: TObject);
begin
  if PageControl.ActivePage = Tabsheet1 then
    TCheckListBox(BarsListBox).Click
  else
    if (PageControl.ActivePage = Tabsheet2) and BarManager.Designing then
      if dxBarDesigner.SelectedComponent(BarManager) is TdxBarItem then
        UpdateCustomizingBarItemsEx(TdxBarItem(dxBarDesigner.SelectedComponent(BarManager)), False)
      else
        LCommandsClick(nil)
    else
      if PageControl.ActivePage = Tabsheet4 then
        with LAllCommands.Items do
          if Count > 0 then
            if dxBarDesigner.SelectedComponent(BarManager) is TdxBarItem then
              LAllCommands.ItemIndex := IndexOfObject(dxBarDesigner.SelectedComponent(BarManager))
            else
              LAllCommandsClick(nil)
          else
            SelectBarManager
      else
        if PageControl.ActivePage = Tabsheet5 then
          SelectedGroupChanged(False);
end;

procedure TdxBarCustomizingForm.BHelpClick(Sender: TObject);
begin
  if not BarManager.Designing then
  begin
    TDummyBarManager(BarManager).DoHelpButtonClick;
    if BarManager.HelpContext <> 0 then
      Application.HelpContext(BarManager.HelpContext);
  end;    
end;

procedure TdxBarCustomizingForm.BCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TdxBarCustomizingForm.BBarNewClick(Sender: TObject);
var
  S: string;
  ABar: TdxBar;
  WorkArea: TRect;
begin
  S := BarManager.Bars.GetUniqueToolbarName(cxGetResourceString(@dxSBAR_TOOLBARNEWNAME));
  if dxBarEditName(S, 0, 0, BarManager, nil) then
  begin
    ABar := BarManager.Bars.Add;
    with ABar do
    begin
      Caption := S;
      WorkArea := GetWorkArea(Point(Left, Top));
      FloatLeft := Left - 50;
      if FloatLeft < WorkArea.Left then FloatLeft := Left + Width + 10;
      FloatTop := Top;
      if FloatTop < WorkArea.Top then FloatTop := WorkArea.Top + 10;
      Visible := True;
    end;
    with BarsListBox do
    begin
      Items.AddObject(ABar.Caption, ABar);
      ItemIndex := Items.Count - 1;
    end;
    TCheckListBox(BarsListBox).Click;
  end;
end;

procedure TdxBarCustomizingForm.BBarRenameClick(Sender: TObject);
var
  Bar: TdxBar;
  S: string;
  AItemIndex: Integer;
begin
  AItemIndex := BarsListBox.ItemIndex;
  Bar := TdxBar(BarsListBox.Items.Objects[AItemIndex]);
  S := Bar.Caption;
  if dxBarEditName(S, 0, 1, BarManager, Bar) then
  begin
    BarsListBox.Items[AItemIndex] := S;
    Bar.Caption := S;
    BarsListBox.ItemIndex := AItemIndex;
  end;
end;

procedure TdxBarCustomizingForm.BBarDeleteClick(Sender: TObject);
var
  AItemIndex: Integer;
  ABar: TdxBar;
begin
  AItemIndex := BarsListBox.ItemIndex;
  if Application.MessageBox(
    PChar(Format(cxGetResourceString(@dxSBAR_WANTTODELETETOOLBAR), [BarsListBox.Items[AItemIndex]])),
    PChar(Application.Title), MB_ICONEXCLAMATION or MB_OKCANCEL) = ID_OK then
  begin
    ABar := TdxBar(BarsListBox.Items.Objects[AItemIndex]);
    BarsListBox.Items.Delete(AItemIndex);
    if BarsListBox.Items.Count > 0 then
    begin
      if AItemIndex = BarsListBox.Items.Count then Dec(AItemIndex);
      BarsListBox.ItemIndex := AItemIndex;
    end;
    with TdxBar(ABar) do
      Index := Collection.Count - 1;
    TCheckListBox(BarsListBox).Click;
    TdxBar(ABar).Free;
  end;
end;

procedure TdxBarCustomizingForm.BBarResetClick(Sender: TObject);
begin
  with BarsListBox do
    TdxBar(Items.Objects[ItemIndex]).ResetWithConfirmation;
end;

procedure TdxBarCustomizingForm.LCategoriesClick(Sender: TObject);
var
  List: TList;
  I: Integer;
  Item: TdxBarItem;
begin
  SelectBarManager;
  LCommands.Items.BeginUpdate;
  try
    LCommands.Items.Clear;
    if LCategories.ItemIndex > -1 then
    begin
      List := TList.Create;
      with TDummyBarManager(BarManager) do
        GetItemsByCategory(GetCategoryRealIndex(LCategories.ItemIndex), List);
      for I := 0 to List.Count - 1 do
      begin
        Item := TdxBarItem(List[I]);
        LCommands.Items.AddObject(Item.Caption, Item);
      end;
      List.Free;
    end;
  finally
    LCommands.Items.EndUpdate;
  end;
  DescriptionLabel.Caption := '';
end;

procedure TdxBarCustomizingForm.LCategoriesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if BarManager.Designing then
    case Key of
      VK_INSERT: if Shift = [] then CategoriesInsertClick(nil);
      VK_DELETE: if Shift = [] then CategoriesDeleteClick(nil);
    end;
end;

procedure TdxBarCustomizingForm.LCategoriesMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  with LCategories do
    case Button of
      mbLeft:
        if BarManager.Designing and (ItemAtPos(Point(X, Y), True) > -1) then
        begin
          FDraggingCategoryIndex := ItemIndex;
          DragMode := dmAutomatic;
        end;
      mbRight:
        begin
          SetFocus;
          ItemIndex := ItemAtPos(Point(X, Y), True);
          LCategoriesClick(nil);
          if BarManager.Designing then
            with ClientToScreen(Point(X, Y)) do
              CategoriesPopupMenu.Popup(X, Y);
        end;
    end;
end;

procedure TdxBarCustomizingForm.LCategoriesDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  AItemIndex: Integer;
begin
  Accept := Source = Sender;
  if Accept then
  begin
    AItemIndex := LCategories.ItemAtPos(Point(X, Y), True);
    if AItemIndex > -1 then
    begin
      BarManager.Categories.Move(FDraggingCategoryIndex, AItemIndex);
      LCategories.Items.Move(FDraggingCategoryIndex, AItemIndex);
      LCategories.ItemIndex := AItemIndex;
      FDraggingCategoryIndex := AItemIndex;
    end;
  end;
end;

procedure TdxBarCustomizingForm.LCategoriesEndDrag(Sender, Target: TObject;
  X, Y: Integer);
begin
  LCategories.DragMode := dmManual;
end;

procedure TdxBarCustomizingForm.CategoriesPopupMenuPopup(Sender: TObject);
begin
  CategoriesInsert.Enabled := LCategories.ItemIndex > -1;
  CategoriesRename.Enabled := LCategories.ItemIndex > -1;
  with CategoriesVisible do
  begin
    Enabled := LCategories.ItemIndex > -1;
    Down := Enabled and Self.BarManager.CategoryVisible[LCategories.ItemIndex];
  end;
  with CategoriesItemsVisible do
  begin
    Enabled := CategoriesVisible.Enabled;
    if Enabled then
      ItemIndex := Ord(Self.BarManager.CategoryItemsVisible[LCategories.ItemIndex]);
  end;
  CategoriesDelete.Enabled := CanDeleteCategoryItems(LCategories.ItemIndex);
end;

procedure TdxBarCustomizingForm.CategoriesAddClick(Sender: TObject);
var
  S: string;
begin
  S := '';
  if dxBarEditName(S, 1, 0, BarManager, nil) then
  begin
    BarManager.Categories.Add(S);
    LCategories.Items.Add(S);
    LCategories.ItemIndex := LCategories.Items.Count - 1;
    LCategoriesClick(nil);
    LCategories.SetFocus;
  end;
end;

procedure TdxBarCustomizingForm.CategoriesInsertClick(Sender: TObject);
var
  S: string;
  AItemIndex: Integer;
begin
  AItemIndex := LCategories.ItemIndex;
  if AItemIndex > -1 then
  begin
    S := '';
    if dxBarEditName(S, 1, 1, BarManager, nil) then
    begin
      AItemIndex := LCategories.ItemIndex;
      BarManager.Categories.Insert(AItemIndex, S);
      LCategories.Items.Insert(AItemIndex, S);
      LCategories.ItemIndex := AItemIndex;
      LCategoriesClick(nil);
      LCategories.SetFocus;
    end;
  end;  
end;

procedure TdxBarCustomizingForm.CategoriesRenameClick(Sender: TObject);
var
  S: string;
  AItemIndex: Integer;
begin
  AItemIndex := LCategories.ItemIndex;
  if AItemIndex > -1 then
  begin
    S := LCategories.Items[AItemIndex];
    if dxBarEditName(S, 1, 2, BarManager, nil) then
    begin
      BarManager.Categories[AItemIndex] := S;
      LCategories.Items[AItemIndex] := S;
      LCategories.ItemIndex := AItemIndex;
      LCategories.SetFocus;
    end;
  end
end;

procedure TdxBarCustomizingForm.CategoriesVisibleClick(Sender: TObject);
begin
  BarManager.CategoryVisible[LCategories.ItemIndex] := TdxBarButton(Sender).Down;
  LCategories.SetFocus;
end;

procedure TdxBarCustomizingForm.CategoriesItemsVisibleChange(
  Sender: TObject);
begin
  BarManager.CategoryItemsVisible[LCategories.ItemIndex] :=
    TdxBarItemVisible(TdxBarCombo(Sender).ItemIndex);
  LCategories.SetFocus;
end;

procedure TdxBarCustomizingForm.CategoriesDeleteClick(Sender: TObject);
var
  AItemIndex: Integer;
begin
  if (LCategories.ItemIndex > -1) and (LCategories.Items.Count > 1) then
  begin
    AItemIndex := LCategories.ItemIndex;
    if Application.MessageBox(
      PChar(Format(cxGetResourceString(@dxSBAR_WANTTODELETECATEGORY), [LCategories.Items[AItemIndex]])),
      PChar(Application.Title), MB_ICONEXCLAMATION or MB_OKCANCEL) = ID_OK then
    begin
      SelectBarManager;
      BarManager.Categories.Delete(AItemIndex);
      LCategories.Items.Delete(AItemIndex);
      if AItemIndex = LCategories.Items.Count then Dec(AItemIndex);
      LCategories.ItemIndex := AItemIndex;
      LCategoriesClick(nil);
      LCategories.SetFocus;
    end;
  end;
end;

procedure TdxBarCustomizingForm.LCommandsClick(Sender: TObject);
var
  AItem: TdxBarItem;
begin
  BarManager.SelectedItem := nil;
  if (LCommands.ItemIndex > -1) and (LCommands.Items.Count > 0) then
    AItem := TdxBarItem(LCommands.Items.Objects[LCommands.ItemIndex])
  else
    AItem := nil;
  if BarManager.Designing and not DontSelectComponent then
    with dxBarDesigner do
      if AItem = nil then
        SelectComponent(BarManager, BarManager)
      else
        SelectComponent(BarManager, AItem);
  if AItem = nil then
    DescriptionLabel.Caption := ''
  else
    DescriptionLabel.Caption := AItem.Description;
  ProcessPaintMessages;
end;

procedure TdxBarCustomizingForm.CommandsPopupMenuPopup(Sender: TObject);

  function Item: TdxBarItem;
  begin
    if LCommands.ItemIndex = -1 then
      Result := nil
    else
      Result := TdxBarItem(LCommands.Items.Objects[LCommands.ItemIndex]);
  end;

begin
  CommandsAdd.Enabled := dxBarDesigner.CanAddComponent(BarManager);
  CommandsDelete.Enabled := (Item <> nil) and
    dxBarDesigner.CanDeleteComponent(BarManager, Item);
  CommandsClear.Enabled := (LCommands.Items.Count <> 0) and
    CanDeleteCategoryItems(LCategories.ItemIndex);
  CommandsMoveUp.Enabled := LCommands.ItemIndex > 0;
  CommandsMoveDown.Enabled :=
    (LCommands.ItemIndex > -1) and (LCommands.ItemIndex < LCommands.Items.Count - 1);
  CommandsSubMenuEditor.Enabled := CommandsDelete.Enabled and
    ((Item is TdxBarSubItem) or (Item is TdxBarContainerItem));
end;

procedure TdxBarCustomizingForm.CommandsAddClick(Sender: TObject);
var
  AItem: TdxBarItem;
begin
  AItem := dxBarItemAddEditor(BarManager, LCategories.ItemIndex);
  if AItem <> nil then
  begin
    UpdateCustomizingBarItemsEx(AItem, True);
    LCommandsClick(nil);
    CreateAllCommandsListBoxItems;
    LCommands.SetFocus;
  end;
end;

procedure TdxBarCustomizingForm.CommandsDeleteClick(Sender: TObject);
var
  AItemIndex: Integer;
  AItem: TdxBarItem;
begin
  AItemIndex := LCommands.ItemIndex;
  if (AItemIndex > -1) and (LCommands.Items.Count > 0) then
  begin
    FManualProcessing := True;
    try
      AItem := TdxBarItem(LCommands.Items.Objects[AItemIndex]);
      try
        try
          dxBarDesigner.DeleteComponent(BarManager, AItem);
        except
          LCategoriesClick(Sender);
          raise;
        end;
        LCommands.Items.Delete(AItemIndex);
      finally
        dxBarDesignerModified(BarManager);
        if AItemIndex > LCommands.Items.Count - 1 then Dec(AItemIndex);
        LCommands.ItemIndex := AItemIndex;
        LCommandsClick(Sender);
      end;
    finally
      FManualProcessing := False;
    end;
    LCommands.SetFocus;
  end;
end;

procedure TdxBarCustomizingForm.CommandsClearClick(Sender: TObject);
var
  I: Integer;
begin
  if Application.MessageBox(
    PChar(Format(cxGetResourceString(@dxSBAR_WANTTOCLEARCOMMANDS), [LCategories.Items[LCategories.ItemIndex]])),
    PChar(Application.Title), MB_ICONEXCLAMATION or MB_OKCANCEL) = ID_OK then
  begin
    FManualProcessing := True;
    try
      try
        for I := 0 to LCommands.Items.Count - 1 do
          dxBarDesigner.DeleteComponent(BarManager, TdxBarItem(LCommands.Items.Objects[I]));
      finally
        dxBarDesignerModified(BarManager);
        LCategoriesClick(Sender);
      end;
    finally
      FManualProcessing := False;
    end;  
    LCommands.SetFocus;
  end;
end;

procedure TdxBarCustomizingForm.CommandsMoveUpClick(Sender: TObject);
begin
  MoveCommand(-1);
  LCommands.SetFocus;
end;

procedure TdxBarCustomizingForm.CommandsMoveDownClick(Sender: TObject);
begin
  MoveCommand(1);
  LCommands.SetFocus;
end;

procedure TdxBarCustomizingForm.CommandsSubMenuEditorClick(Sender: TObject);
var
  ASubItem: TCustomdxBarSubItem;
begin
  LCommands.SetFocus;
  ASubItem := TCustomdxBarSubItem(LCommands.Items.Objects[LCommands.ItemIndex]);
  ShowdxBarSubMenuEditor(ASubItem.ItemLinks);
end;

procedure TdxBarCustomizingForm.CBMenusShowRecentItemsFirstClick(Sender: TObject);
begin
  CBShowFullMenusAfterDelay.Enabled := CBMenusShowRecentItemsFirst.Checked;
  BarManager.MenusShowRecentItemsFirst := CBMenusShowRecentItemsFirst.Checked;
end;

procedure TdxBarCustomizingForm.CBShowFullMenusAfterDelayClick(Sender: TObject);
begin
  BarManager.ShowFullMenusAfterDelay := CBShowFullMenusAfterDelay.Checked;
end;

procedure TdxBarCustomizingForm.BResetUsageDataClick(Sender: TObject);
begin
  BarManager.ResetUsageDataWithConfirmation;
end;

procedure TdxBarCustomizingForm.CBLargeIconsClick(Sender: TObject);
begin
  BarManager.LargeIcons := TCheckBox(Sender).Checked;
end;

procedure TdxBarCustomizingForm.CBHint1Click(Sender: TObject);
begin
  BarManager.ShowHint := TCheckBox(Sender).Checked;
end;

procedure TdxBarCustomizingForm.CBHint1ExClick(Sender: TObject);
begin
  CBHint2Ex.Enabled := CBHint1Ex.Checked;
  CBHint1Click(Sender);
end;

procedure TdxBarCustomizingForm.CBHint2Click(Sender: TObject);
begin
  BarManager.ShowShortCutInHint := TCheckBox(Sender).Checked;
end;

procedure TdxBarCustomizingForm.ComboBoxMenuAnimationsClick(Sender: TObject);
begin
  BarManager.MenuAnimations := TdxBarMenuAnimations(TComboBox(Sender).ItemIndex);
end;

procedure TdxBarCustomizingForm.LAllCommandsClick(Sender: TObject);
begin
  with LAllCommands do
    if (ItemIndex > -1) and (Items.Count > 0) then
      dxBarDesigner.SelectComponent(BarManager, TdxBarItem(Items.Objects[ItemIndex]));
end;

procedure TdxBarCustomizingForm.LAllCommandsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  W: Integer;
  LastRow: Boolean;
begin
  LastRow := Index = TListBox(Control).Items.Count - 1;
  with TListBox(Control), Canvas, TdxBarItem(Items.Objects[Index]), Rect do
  begin
    Pen.Color := Font.Color;
    FillRect(Rect);

    TextOut(Left + AllCommandsIndent, Top, Name);
    W := AllCommandsIndent + FAllCommandsNameWidth + AllCommandsIndent;
    MoveTo(W, Top);
    LineTo(W, Bottom);

    TextOut(W + AllCommandsIndent, Top, Caption);
    Inc(W, AllCommandsIndent + FAllcommandsCaptionWidth + AllCommandsIndent);
    MoveTo(W, Top);
    LineTo(W, Bottom);

    TextOut(W + AllCommandsIndent, Top, ShortCutToText(ShortCut));

    if LastRow then
    begin
      Pen.Color := clWindowText;
      W := AllCommandsIndent + FAllCommandsNameWidth + AllCommandsIndent;
      MoveTo(W, Bottom);
      LineTo(W, ClientHeight);
      Inc(W, AllCommandsIndent + FAllCommandsCaptionWidth + AllCommandsIndent);
      MoveTo(W, Bottom);
      LineTo(W, ClientHeight);
    end;
  end;
end;

procedure TdxBarCustomizingForm.CBShowCommandsWithShortCutClick(
  Sender: TObject);
begin
  CreateAllCommandsListBoxItems;
  PageControlChange(nil);
end;

procedure TdxBarCustomizingForm.lbGroupsClick(Sender: TObject);
begin
  SelectedGroupChanged(True);
end;

procedure TdxBarCustomizingForm.lbGroupsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  with TListBox(Control), Canvas do
  begin
    with Font do
      Style := Style + [fsBold];
    with Rect do
      cxExtTextOut(Handle, Items[Index], Point(Left + 2, Top + 1), Rect, ETO_OPAQUE);
  end;
end;

procedure TdxBarCustomizingForm.lbGroupsEnter(Sender: TObject);
begin
  LastActiveGroupListBox := glbGroups;
  RefreshGroupsEnables;
end;

procedure TdxBarCustomizingForm.lbGroupsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT:
      with btnGroupAdd do
        if Enabled then Click;
    VK_DELETE:
      with btnGroupDelete do
        if Enabled then Click;
  end;
end;

procedure TdxBarCustomizingForm.lbGroupsMeasureItem(Control: TWinControl;
  Index: Integer; var Height: Integer);
begin
  with TListBox(Control) do
    Canvas.Font := Font;
  Height := TListBox(Control).Canvas.TextHeight('Qq') + 2;
end;

procedure TdxBarCustomizingForm.btnGroupAddClick(Sender: TObject);
var
  Group: TdxBarGroup;
begin
  LastActiveGroupListBox := glbGroups;
  Group := BarManager.CreateGroup;
  Group.Name := dxBarDesigner.UniqueName(BarManager, 'dxBarGroup');
  BeginRefreshGroupsEnables;
  try
    CreateGroupsListBoxItems;
    SelectedGroup := Group;
  finally
    EndRefreshGroupsEnables;
  end;
end;

procedure TdxBarCustomizingForm.btnGroupDeleteClick(Sender: TObject);
var
  Group, NewGroup: TdxBarGroup;
begin
  LastActiveGroupListBox := glbGroups;
  Group := SelectedGroup;
  if Group <> nil then
  begin
    if Group.Index = BarManager.GroupCount - 1 then
      if Group.Index = 0 then
        NewGroup := nil
      else
        NewGroup := BarManager.Groups[Group.Index - 1]
    else
      NewGroup := BarManager.Groups[Group.Index + 1];
    BeginRefreshGroupsEnables;
    try
      lbGroups.Items.BeginUpdate;
      try
        SelectedGroup := NewGroup;
        Group.Free;
        CreateGroupsListBoxItems;
      finally
        lbGroups.Items.EndUpdate;
      end;
    finally
      EndRefreshGroupsEnables;
    end;
  end;
end;

procedure TdxBarCustomizingForm.lbGroupItemsClick(Sender: TObject);
begin
  SelectedGroupItemsChanged;
end;

procedure TdxBarCustomizingForm.lbGroupItemsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  with TListBox(Control), Canvas do
  begin
    if Items.Objects[Index] is TdxBarGroup then
      with Font do
        Style := Style + [fsBold];
    with Rect do
      cxExtTextOut(Handle, Items[Index], Point(Left + 2, Top + 1), Rect, ETO_OPAQUE);
  end;
end;

procedure TdxBarCustomizingForm.lbGroupItemsEnter(Sender: TObject);
begin
  LastActiveGroupListBox := glbItems;
  RefreshGroupsEnables;
end;

procedure TdxBarCustomizingForm.lbGroupItemsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT:
      with btnGroupItemAdd do
        if Enabled then Click;
    VK_DELETE:
      with btnGroupItemDelete do
        if Enabled then Click;
  end;
end;

procedure TdxBarCustomizingForm.btnGroupItemAddClick(Sender: TObject);
var
  Group: TdxBarGroup;
  GroupItems: TList;
  I: Integer;
begin
  LastActiveGroupListBox := glbItems;
  Group := SelectedGroup;
  GroupItems := TList.Create;
  try
    if dxBarChooseGroupItem(Group, GroupItems) then
    begin
      for I := 0 to GroupItems.Count - 1 do
        Group.Add(TComponent(GroupItems[I]));
      BeginRefreshGroupsEnables;
      try
        CreateGroupItemsListBoxItems;
        SelectedGroupItems := GroupItems;
      finally
        EndRefreshGroupsEnables;
      end;
      GroupItems := nil;
      dxBarDesignerModified(BarManager);
    end;
  finally
    if GroupItems <> nil then GroupItems.Free;
  end;
end;

procedure TdxBarCustomizingForm.btnGroupItemDeleteClick(Sender: TObject);
var
  Group: TdxBarGroup;
  List: TList;
  I: Integer;
  NewItem: TComponent;
begin
  LastActiveGroupListBox := glbItems;
  Group := SelectedGroup;
  List := SelectedGroupItems;
  try
    I := lbGroupItems.ItemIndex;
    if I = -1 then I := 0;
    NewItem := nil;
    for I := I to Group.Count - 1 do
      if not lbGroupItems.Selected[I] then
      begin
        NewItem := Group[I];
        Break;
      end;
    if NewItem = nil then
      for I := lbGroupItems.ItemIndex downto 0 do
        if not lbGroupItems.Selected[I] then
        begin
          NewItem := Group[I];
          Break;
        end;

    for I := 0 to List.Count - 1 do
      Group.Remove(TComponent(List[I]));

    BeginRefreshGroupsEnables;
    try
      lbGroupItems.Items.BeginUpdate;
      try
        CreateGroupItemsListBoxItems;
        List.Clear;
        List.Add(NewItem);
        SelectedGroupItems := List;
      finally
        lbGroupItems.Items.EndUpdate;
        dxBarDesignerModified(BarManager);
      end;
    finally
      EndRefreshGroupsEnables;
    end;
  except
    List.Free;
    raise;
  end;
end;

procedure TdxBarCustomizingForm.btnMoveUpClick(Sender: TObject);
var
  Group: TdxBarGroup;
  List: TList;
  I, J, K: Integer;
begin
  if LastActiveGroupListBox = glbGroups then
  begin
    with SelectedGroup do
      Index := Index - 1;
    CreateGroupsListBoxItems;
  end
  else
    try
      Group := SelectedGroup;
      List := SelectedGroupItems;
      try
        K := 0;
        for I := 0 to List.Count - 1 do
        begin
          J := Group.IndexOf(TComponent(List[I]));
          if I = 0 then
          begin
            K := J - 1;
            if K < 0 then K := 0;
            Group.Move(J, K);
          end
          else
            Group.Move(J, K + I);
        end;
      except
        List.Free;
        raise;
      end;
    finally
      RefreshGroupItemsListBox;
    end;
  dxBarDesignerModified(BarManager);
end;

procedure TdxBarCustomizingForm.btnMoveDownClick(Sender: TObject);
var
  Group: TdxBarGroup;
  List: TList;
  I, J, K: Integer;
begin
  if LastActiveGroupListBox = glbGroups then
  begin
    with SelectedGroup do
      Index := Index + 1;
    CreateGroupsListBoxItems;
  end
  else
    try
      Group := SelectedGroup;
      List := SelectedGroupItems;
      try
        K := 0;
        for I := List.Count - 1 downto 0 do
        begin
          J := Group.IndexOf(TComponent(List[I]));
          if I = List.Count - 1 then
          begin
            K := J + 1;
            if K > Group.Count - 1 then
              K := Group.Count - 1;
            Group.Move(J, K);
            Dec(K, List.Count - 1);
          end
          else
            Group.Move(J, K + I);
        end;
      except
        List.Free;
        raise;
      end;
    finally
      RefreshGroupItemsListBox;
    end;
  dxBarDesignerModified(BarManager);
end;

end.
