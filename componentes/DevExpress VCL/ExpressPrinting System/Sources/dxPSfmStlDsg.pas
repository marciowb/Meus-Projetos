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

unit dxPSfmStlDsg;

interface

{$I cxVer.inc}

uses
   {$IFDEF DELPHI6} 
    DesignIntf, DesignWindows,
   {$ELSE} 
    DsgnIntf, DsgnWnds, LibIntf, 
   {$ENDIF} 
  Windows, Messages, SysUtils, Classes, Graphics, Controls, StdCtrls, Dialogs,
  ExtCtrls, ComCtrls, Menus, Forms, Buttons, ImgList, dxCore, dxPgsDlg, dxPSDsgProxies;

type
  TdxfmPrintStylesDesignWindow = class(TDesignWindow)
    pmStyles: TPopupMenu;
    pnlButtons: TPanel;
    btnAdd: TButton;
    btnDelete: TButton;
    miAdd: TMenuItem;
    miDelete: TMenuItem;
    miLine1: TMenuItem;
    miLine2: TMenuItem;
    miSelectAll: TMenuItem;
    btnSelectAll: TButton;
    btnPageSetup: TButton;
    miPageSetup: TMenuItem;
    miCopy: TMenuItem;
    miCut: TMenuItem;
    miPaste: TMenuItem;
    miRestoreDefaults: TMenuItem;
    miLine: TMenuItem;
    miShowButtons: TMenuItem;
    miLine5: TMenuItem;
    ilMenu: TImageList;
    btnMoveUp: TButton;
    btnMoveDown: TButton;
    miMoveUp: TMenuItem;
    miMoveDown: TMenuItem;
    miBackgroundEffects: TMenuItem;
    miBackgroundClear: TMenuItem;
    N2: TMenuItem;
    btnRestoreDefaults: TButton;
    miSetAsCurrent: TMenuItem;
    N3: TMenuItem;
    lbxStyles: TListBox;
    miEdit: TMenuItem;
    N1: TMenuItem;
    miBackground: TMenuItem;
    miAddStandard: TMenuItem;
    procedure pmStylesPopup(Sender: TObject);
    procedure lbxStylesClick(Sender: TObject);
    procedure lbxStylesDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lbxStylesDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RestoreDefaultsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditClick(Sender: TObject);
    procedure miShowButtonsClick(Sender: TObject);
    procedure MoveUpClick(Sender: TObject);
    procedure MoveDownClick(Sender: TObject);
    procedure lbxStylesEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure lbxStylesStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure PageSetupClick(Sender: TObject);
    procedure BackgroundClick(Sender: TObject);
    procedure ClearBackgroundClick(Sender: TObject);
    procedure lbxStylesDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure miSetAsCurrentClick(Sender: TObject);
    procedure lbxStylesKeyPress(Sender: TObject; var Key: Char);
    procedure AddClick(Sender: TObject);
    procedure AddStandardClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    FController: TdxPrintStyleManager;
    FSaveCursor: TCursor;
    FSaveDragIndex: Integer;

    function GetCurrentStyle: TBasedxPrintStyle;
    function GetControllerDesigner: TAbstractdxStyleManagerDesigner;
    function GetRegistryPath: string;
    function GetSelected(Index: Integer): Boolean;
    function GetSelectedCount: Integer;
    function GetStyleCount: Integer;
    function GetStyle(Index: Integer): TBasedxPrintStyle;
    procedure SetController(Value: TdxPrintStyleManager);
    procedure SetSelected(Index: Integer; Value: Boolean);

    procedure AddStyle;
    function CanAdd: Boolean;
    function CanAddStandard: Boolean;
    function CanBackgroundClear: Boolean;
    function CanBackgroundEffects: Boolean;
    function CanCopy: Boolean;
    function CanCut: Boolean;
    function CanDelete: Boolean;
    function CanMoveDown: Boolean;
    function CanMoveUp: Boolean;
    function CanPaste: Boolean;
    function CanPageSetup: Boolean;
    function CanRestoreDefaults: Boolean;
    function CanSelectAll: Boolean;
    function CanSetAsCurrent: Boolean;
   {$IFDEF DELPHI5}
    procedure CheckAddStyle;
   {$ENDIF}
    procedure CheckDeleteStyle;
    procedure Copy;
    procedure Cut;
    procedure Delete;
    procedure DeleteItem(AItem: TBasedxPrintStyle);
    procedure DrawDragRect;
    function GetMinWindowSize: TPoint;
    procedure GetSelections(const ASelections: TdxDesignSelectionList);
    function IndexOf(AItem: TBasedxPrintStyle): Integer;
    procedure InternalAddStyle(AStyleClass: TdxPrintStyleClass);
    procedure MoveSelection(ADelta: Integer);
    procedure Paste;
    procedure PrepareAddStandardItem(MenuItem: TMenuItem);
    procedure RefreshList;
    procedure RestoreLayout;
    procedure Select(AItem: TPersistent; AddToSelection: Boolean);
    procedure SelectAll;
    procedure SelectController;
    procedure StartWait;
    procedure StopWait;
    procedure StoreLayout;
    procedure UpdateCaption;
    procedure UpdateControlsState;
    procedure UpdateHScrollBar;
    procedure UpdateItem(AItem: TBasedxPrintStyle);
    procedure UpdateMenuState;
    procedure UpdateSelections(const ASelections: TdxDesignSelectionList);
    procedure WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
    procedure WMNCCreate(var Message: TWMNCCreate); message WM_NCCREATE;
    procedure WMNCDestroy(var Message: TWMNCCreate); message WM_NCDESTROY;
  protected
    procedure Activated; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    function UniqueName(Comp: TComponent): string; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

   {$IFDEF DELPHI6}
    function EditAction(Action: TEditAction): Boolean; override;
    procedure ItemDeleted(const ADesigner: IDesigner; Item: TPersistent); override;
    procedure ItemsModified(const Designer: IDesigner); override;
    procedure SelectionChanged(const ADesigner: IDesigner; const ASelection: IDesignerSelections); override;
   {$ELSE}
    procedure ComponentDeleted(Component: IPersistent); override;
    procedure EditAction(Action: TEditAction); override;
    procedure SelectionChanged(ASelection: {$IFDEF DELPHI5} TDesignerSelectionList {$ELSE} TComponentList{$ENDIF}); override;
    procedure FormModified; override;
   {$ENDIF}
    function GetEditState: TEditState; override;

    property CurrentStyle: TBasedxPrintStyle read GetCurrentStyle;
    property Controller: TdxPrintStyleManager read FController write SetController;
    property ControllerDesigner: TAbstractdxStyleManagerDesigner read GetControllerDesigner;
    property RegistryPath: string read GetRegistryPath;
    property Selected[Index: Integer]: Boolean read GetSelected write SetSelected;
    property SelectedCount: Integer read GetSelectedCount;
    property StyleCount: Integer read GetStyleCount;
    property Styles[Index: Integer]: TBasedxPrintStyle read GetStyle;
  end;

procedure dxShowPrintStylesDesigner(AStyleController: TdxPrintStyleManager; AFormDesigner: TFormDesigner);
//function dxPrintStyleUniqueName(AStyleController: TdxPrintStyleManager; AComponent: TComponent): string;

implementation

{$R *.DFM}

uses
   {$IFDEF DELPHI5} 
    DesignConst,
   {$ELSE} 
    LibConst,
   {$ENDIF}
  Registry, CommCtrl, dxPrnPg, dxBkgnd, dxPSGlbl, dxPSUtl, dxPSPopupMan, 
  dxPSfmStlAdd;

const
  sdxCantPasteComponent = 'Can''t paste component %s here !';
  sdxStyleDesigner = 'Editing %s%s%s Styles';

  { don't localize }
  sdxButtonBar = 'ButtonBar';
  sdxWidth = 'Width';
  sdxHeight = 'Height';

type
  TdxStyleManagerDesigner = class(TAbstractdxStyleManagerDesigner)
  private
    FDesignWindow: TdxfmPrintStylesDesignWindow;
    FFormDesigner: TFormDesigner;
    FUpdateCount: Integer;

    function GetDesignWindow: TdxfmPrintStylesDesignWindow;
    procedure Activate;
  protected
    procedure Modified; override;
    procedure Update(AItem: TBasedxPrintStyle); override;
  public
    constructor Create(AStyleController: TdxPrintStyleManager; AFormDesigner: TFormDesigner);
    destructor Destroy; override;

    procedure BeginUpdate; override;
    procedure CancelUpdate; override;
    procedure EndUpdate; override;

    property DesignWindow: TdxfmPrintStylesDesignWindow read GetDesignWindow;
    property FormDesigner: TFormDesigner read FFormDesigner;
  end;

procedure dxShowPrintStylesDesigner(AStyleController: TdxPrintStyleManager; AFormDesigner: TFormDesigner);
begin
  if AStyleController.Designer = nil then
    TdxStyleManagerDesigner.Create(AStyleController, AFormDesigner);
  TdxStyleManagerDesigner(AStyleController.Designer).Activate;
end;

{ TdxStyleManagerDesigner }

constructor TdxStyleManagerDesigner.Create(AStyleController: TdxPrintStyleManager;
  AFormDesigner: TFormDesigner);
begin
  inherited Create(AStyleController);
  FFormDesigner := AFormDesigner;
end;

destructor TdxStyleManagerDesigner.Destroy;
begin
  if FDesignWindow <> nil then
  begin
    FDesignWindow.Designer := nil;
    FDesignWindow.Free;
  end;
  inherited Destroy;
end;

procedure TdxStyleManagerDesigner.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TdxStyleManagerDesigner.CancelUpdate;
begin
  if FUpdateCount <> 0 then Dec(FUpdateCount);
end;

procedure TdxStyleManagerDesigner.EndUpdate;
begin
  if FUpdateCount <> 0 then
  begin
    Dec(FUpdateCount);
    if FUpdateCount = 0 then Update(nil);
  end;
end;

function TdxStyleManagerDesigner.GetDesignWindow: TdxfmPrintStylesDesignWindow;
begin
  if FDesignWindow = nil then
  begin
    FDesignWindow := TdxfmPrintStylesDesignWindow.Create(nil);
    FDesignWindow.Designer := FormDesigner;
    FDesignWindow.Controller := StyleManager;
  end;
  Result := FDesignWindow;
end;

procedure TdxStyleManagerDesigner.Activate;
begin
  DesignWindow.Show;
end;

procedure TdxStyleManagerDesigner.Modified;
begin
  if FormDesigner <> nil then FormDesigner.Modified;
end;

procedure TdxStyleManagerDesigner.Update(AItem: TBasedxPrintStyle);
begin
  if (FUpdateCount = 0) and (FDesignWindow <> nil) then
    DesignWindow.UpdateItem(AItem);
end;

{ TdxfmPrintStylesDesignWindow }

constructor TdxfmPrintStylesDesignWindow.Create(AOwner: TComponent);

  function MakeTTag(AnAction: TEditAction):  Integer ;
  begin
    Result := Integer(AnAction);
  end;
  
begin
  HelpContext := dxPSGlbl.dxhcPrintStylesDesignWindow;
  inherited;

  pmStyles.Images := ilMenu;
  miAdd.ImageIndex := 0;
  miCopy.ImageIndex := 1;
  miCut.ImageIndex := 2;
  miPaste.ImageIndex := 3;
  miDelete.ImageIndex := 4;
  miPageSetup.ImageIndex := 6;
  miMoveUp.ImageIndex := 7;
  miMoveDown.ImageIndex := 8;
  miBackgroundEffects.ImageIndex := 9;

  miCut.Tag := MakeTTag(eaCut);
  miCopy.Tag := MakeTTag(eaCopy);
  miPaste.Tag := MakeTTag(eaPaste);
  miDelete.Tag := MakeTTag(eaDelete);
  miSelectAll.Tag := MakeTTag(eaSelectAll);

  btnDelete.Tag := MakeTTag(eaDelete);
  btnSelectAll.Tag := MakeTTag(eaSelectAll);

  RestoreLayout;
  dxPSPopupMenuController.RegisterControl(lbxStyles);
end;

destructor TdxfmPrintStylesDesignWindow.Destroy;
begin
  dxPSPopupMenuController.UnregisterControl(lbxStyles);
  StoreLayout;
  if ControllerDesigner <> nil then
    TdxStyleManagerDesigner(ControllerDesigner).FDesignWindow := nil;
  inherited Destroy;
end;

procedure TdxfmPrintStylesDesignWindow.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  MenuItem: TMenuItem;
begin
  MenuItem := pmStyles.FindItem(Key, fkShortCut);
  if (MenuItem <> nil) and MenuItem.Enabled and MenuItem.Visible then
  begin
    MenuItem.Click;
    Key := 0;
  end
  else
    if Key = VK_ESCAPE then
    begin
      Close;
      Key := 0;
    end;
end;

procedure TdxfmPrintStylesDesignWindow.FormResize(Sender: TObject);
begin
  UpdateHScrollBar;
end;

procedure TdxfmPrintStylesDesignWindow.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if not (csDestroying in Controller.ComponentState) then
    SelectController;
  Action := caFree;
end;

procedure TdxfmPrintStylesDesignWindow.AddClick(Sender: TObject);
begin
  AddStyle;
  ActiveControl := lbxStyles;
end;

procedure TdxfmPrintStylesDesignWindow.lbxStylesClick(Sender: TObject);
var
  Selections: TdxDesignSelectionList;
begin
  Selections := CreateDesignSelectionList;
  GetSelections(Selections);
  Designer.SetSelections(Selections);
end;

procedure TdxfmPrintStylesDesignWindow.PageSetupClick(Sender: TObject);
begin
  if CurrentStyle.PageSetup then Designer.Modified;
end;

procedure TdxfmPrintStylesDesignWindow.lbxStylesStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  FSaveDragIndex := -1;
end;

procedure TdxfmPrintStylesDesignWindow.lbxStylesEndDrag(Sender,
  Target: TObject; X, Y: Integer);
begin
  DrawDragRect;
end;

procedure TdxfmPrintStylesDesignWindow.lbxStylesDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  Index: Integer;
begin
  Accept := Sender = Source;
  if Accept then
    with TListBox(Sender) do
    begin
      Index := ItemAtPos(MakePoint(X, Y), True);
      Accept := (Index <> -1) and (FSaveDragIndex <> ItemIndex);
      DrawDragRect;
      FSaveDragIndex := Index;
      DrawDragRect;
    end;
end;

procedure TdxfmPrintStylesDesignWindow.lbxStylesDragDrop(Sender,
  Source: TObject; X, Y: Integer);
begin
  MoveSelection(FSaveDragIndex - TListBox(Sender).ItemIndex);
end;

procedure TdxfmPrintStylesDesignWindow.lbxStylesKeyPress(Sender: TObject;
  var Key: Char);
begin
  case Key of
    #13, #33..#126:
      begin
        if Key = #13 then Key := #0;
        ActivateInspector(Key);
        Key := #0;
      end;
    #27:
      begin
        SelectController;
        Key := #0;
      end;
  end;
end;

procedure TdxfmPrintStylesDesignWindow.EditClick(Sender: TObject);
begin
  EditAction(TEditAction(TComponent(Sender).Tag));
end;

procedure TdxfmPrintStylesDesignWindow.MoveUpClick(Sender: TObject);
begin
  MoveSelection(-1);
end;

procedure TdxfmPrintStylesDesignWindow.MoveDownClick(Sender: TObject);
begin
  MoveSelection(1);
end;

procedure TdxfmPrintStylesDesignWindow.lbxStylesDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  dxPgsDlg.dxPSDrawStyleItem(Styles[Index], TListBox(Control), Index, State, Rect, False, True);
end;

procedure TdxfmPrintStylesDesignWindow.miSetAsCurrentClick(Sender: TObject);
begin
  Controller.CurrentStyle := CurrentStyle;
end;

procedure TdxfmPrintStylesDesignWindow.RestoreDefaultsClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to StyleCount - 1 do
    if Selected[I] or (SelectedCount = 0) then
      Styles[I].RestoreDefaults;
end;

procedure TdxfmPrintStylesDesignWindow.BackgroundClick(Sender: TObject);
var
  Background: TdxBackground;
  I: Integer;
begin
  StartWait;
  try
    Background := TdxBackground.Create;
    try
      for I := 0 to StyleCount - 1 do
        if Selected[I] or (SelectedCount = 0) then
        begin
          Background.Assign(Styles[I].PrinterPage.Background);
          Break;
        end;

      if Background.SetupEffects then
      begin
        for I := 0 to StyleCount - 1 do
          if Selected[I] or (SelectedCount = 0) then
            Styles[I].PrinterPage.Background := Background;
        Designer.Modified;
      end;
    finally
      Background.Free;
    end;
  finally
    StopWait;
  end;
end;

procedure TdxfmPrintStylesDesignWindow.ClearBackgroundClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to StyleCount - 1 do
    if Selected[I] or (SelectedCount = 0) then
      Styles[I].PrinterPage.Background.Clear;
  Designer.Modified;
end;

procedure TdxfmPrintStylesDesignWindow.pmStylesPopup(Sender: TObject);
begin
  UpdateMenuState;
end;

procedure TdxfmPrintStylesDesignWindow.miShowButtonsClick(Sender: TObject);
begin
  pnlButtons.Visible := not pnlButtons.Visible;
end;

{$IFDEF DELPHI6}
function TdxfmPrintStylesDesignWindow.EditAction(Action: TEditAction): Boolean;
{$ELSE}
procedure TdxfmPrintStylesDesignWindow.EditAction(Action: TEditAction);
{$ENDIF}
begin
 {$IFDEF DELPHI6}
  Result := True;
 {$ENDIF}
  case Action of
    eaCut: Cut;
    eaCopy: Copy;
    eaPaste: Paste;
    eaDelete: Delete;
    eaSelectAll: SelectAll;
  end;
end;

function TdxfmPrintStylesDesignWindow.GetEditState: TEditState;
begin
  Result := [];
  if CanCut then
    Result := Result + [esCanCut];
  if CanCopy then
    Result := Result + [esCanCopy];
  if CanPaste then
    Result := Result + [esCanPaste];
  if CanDelete then
    Result := Result + [esCanDelete];
  if CanSelectAll then
    Result := Result + [esCanSelectAll];
end;

{$IFDEF DELPHI6}

procedure TdxfmPrintStylesDesignWindow.ItemDeleted(const ADesigner: IDesigner;
  Item: TPersistent);
begin
  inherited;
  if (ADesigner = Designer) and (Item is TBasedxPrintStyle) and
    (Controller <> nil) and not (csDestroying in Controller.ComponentState) then
    DeleteItem(TBasedxPrintStyle(Item));
end;

procedure TdxfmPrintStylesDesignWindow.ItemsModified(const Designer: IDesigner);
begin
  inherited;
  UpdateCaption;
end;

procedure TdxfmPrintStylesDesignWindow.SelectionChanged(const ADesigner: IDesigner;
  const ASelection: IDesignerSelections);
begin
  inherited;
  UpdateSelections(ASelection);
end;

{$ELSE}

procedure TdxfmPrintStylesDesignWindow.ComponentDeleted(Component: IPersistent);
var
  Item: TPersistent;
begin
  inherited;
  Item := dxPSDsgProxies.TryExtractPersistent(Component);
  if (Item is TBasedxPrintStyle) and
    (Controller <> nil) and not (csDestroying in Controller.ComponentState) then
    DeleteItem(TBasedxPrintStyle(Item));
end;

procedure TdxfmPrintStylesDesignWindow.SelectionChanged(
  ASelection: {$IFDEF DELPHI5} TDesignerSelectionList {$ELSE} TComponentList {$ENDIF});
begin
  inherited;
  UpdateSelections(ASelection);
end;

procedure TdxfmPrintStylesDesignWindow.FormModified;
begin
  inherited;
  UpdateCaption;
end;

{$ENDIF}

procedure TdxfmPrintStylesDesignWindow.Activated;
var
  Selections: TdxDesignSelectionList;
begin
  inherited Activated;
  Selections := CreateDesignSelectionList;
  try
    Designer.GetSelections(Selections);
    UpdateSelections(Selections);
  finally
    FreeDesignSelectionList(Selections);
  end;
end;

procedure TdxfmPrintStylesDesignWindow.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    Style := Style or WS_THICKFRAME;
{$IFDEF DELPHI9}
  Params.WndParent := Application.MainForm.Handle;
{$ENDIF}
end;

procedure TdxfmPrintStylesDesignWindow.CreateWnd;
begin
  inherited CreateWnd;
  SendMessage(Handle, WM_SETICON, 1, Icon.Handle)
end;

function TdxfmPrintStylesDesignWindow.UniqueName(Comp: TComponent): string;
begin
  Result := dxPgsDlg.dxPSPrintStyleUniqueName(Controller, Comp);
end;

function TdxfmPrintStylesDesignWindow.GetCurrentStyle: TBasedxPrintStyle;
begin
  if StyleCount <> 0 then
    Result := Styles[lbxStyles.ItemIndex]
  else
    Result := nil;
end;
    
function TdxfmPrintStylesDesignWindow.GetControllerDesigner: TAbstractdxStyleManagerDesigner;
begin
  if Controller <> nil then
    Result := Controller.Designer
  else
    Result := nil;
end;

function TdxfmPrintStylesDesignWindow.GetRegistryPath: string;
begin
  Result :=
    dxPSDsgProxies.GetBaseRegistryKey + '\' + dxPSGlbl.sdxPSRegPathRunTimeFormLayouts + '\' + dxPSUtl.DropT(ClassName);
end;

function TdxfmPrintStylesDesignWindow.GetSelected(Index: Integer): Boolean;
begin
  Result := lbxStyles.Selected[Index];
end;

function TdxfmPrintStylesDesignWindow.GetSelectedCount: Integer;
begin
  Result := lbxStyles.SelCount;
end;

function TdxfmPrintStylesDesignWindow.GetStyleCount: Integer;
begin
  Result := lbxStyles.Items.Count;
end;

function TdxfmPrintStylesDesignWindow.GetStyle(Index: Integer): TBasedxPrintStyle;
begin
  Result := TBasedxPrintStyle(lbxStyles.Items.Objects[Index]);
end;

procedure TdxfmPrintStylesDesignWindow.SetController(Value: TdxPrintStyleManager);
begin
  if FController <> Value then
  begin
    FController := Value;
    UpdateCaption;
    RefreshList;
  end;
end;

procedure TdxfmPrintStylesDesignWindow.SetSelected(Index: Integer; Value: Boolean);
begin
  lbxStyles.Selected[Index] := Value;
end;

procedure TdxfmPrintStylesDesignWindow.AddStyle;
var
  StyleClass: TdxPrintStyleClass;
  Origin: TPoint;
begin
 {$IFDEF DELPHI5}
  CheckAddStyle;
 {$ENDIF}
  Origin := ClientToScreen(MakePoint(btnAdd.Left + btnAdd.Width, btnAdd.Top - 40));
  StyleClass := dxSelectStyleClass(Origin);
  if StyleClass <> nil then
    InternalAddStyle(StyleClass);
end;

procedure TdxfmPrintStylesDesignWindow.AddStandardClick(Sender: TObject);
var
  StyleClass: TdxPrintStyleClass;
begin
 {$IFDEF DELPHI5}
  CheckAddStyle;
 {$ENDIF}
  StyleClass := TdxPrintStyleClass(TComponent(Sender).Tag);
  if StyleClass <> nil then
    InternalAddStyle(StyleClass);
end;

function TdxfmPrintStylesDesignWindow.CanAdd: Boolean;
begin
{$IFDEF DELPHI5}
  Result := not ((Controller <> nil) and (Controller.Owner <> nil) and
    (csInline in Controller.Owner.ComponentState));
{$ELSE}
  Result := True;
{$ENDIF}
end;

function TdxfmPrintStylesDesignWindow.CanAddStandard: Boolean;
begin
  Result := CanAdd and (CurrentStyle <> nil);
end;

function TdxfmPrintStylesDesignWindow.CanBackgroundClear: Boolean;
begin
  Result := StyleCount <> 0;
end;

function TdxfmPrintStylesDesignWindow.CanBackgroundEffects: Boolean;
begin
  Result := StyleCount <> 0;
end;

function TdxfmPrintStylesDesignWindow.CanCopy: Boolean;
begin
  Result := SelectedCount <> 0;
end;

function TdxfmPrintStylesDesignWindow.CanCut: Boolean;
begin
  Result := CanCopy and CanDelete;
end;

function TdxfmPrintStylesDesignWindow.CanDelete: Boolean;
var
  I: Integer;
begin
  Result := SelectedCount <> 0;
  if Result then
    for I := 0 to StyleCount - 1 do
      if Selected[I] and (csAncestor in Styles[I].ComponentState) then
      begin
        Result := False;
        Exit;
      end;
end;

function TdxfmPrintStylesDesignWindow.CanMoveDown: Boolean;
var
  I, Counter: Integer;
begin
  Counter := 0;
  for I := StyleCount - 1 downto 0 do
  begin
    if not Selected[I] then
    begin
      Result := Counter < SelectedCount;
      Exit;
    end;
    Inc(Counter);
  end;
  Result := False;
end;

function TdxfmPrintStylesDesignWindow.CanMoveUp: Boolean;
var
  I: Integer;
begin
  for I := 0 to StyleCount - 1 do
    if not Selected[I] then
    begin
      Result := I < SelectedCount;
      Exit;
    end;
  Result := False;
end;

function TdxfmPrintStylesDesignWindow.CanPaste: Boolean;
begin
  Result := CanAdd and ClipboardComponents {$IFDEF DELPHI5} and Designer.CanPaste {$ENDIF};
end;

function TdxfmPrintStylesDesignWindow.CanPageSetup: Boolean;
begin
  Result := SelectedCount = 1;
end;

function TdxfmPrintStylesDesignWindow.CanRestoreDefaults: Boolean;
begin
  Result := CurrentStyle <> nil;
end;

function TdxfmPrintStylesDesignWindow.CanSelectAll: Boolean;
begin
  Result := StyleCount <> SelectedCount;
end;

function TdxfmPrintStylesDesignWindow.CanSetAsCurrent: Boolean;
begin
  Result := (SelectedCount = 1) and not CurrentStyle.IsCurrentStyle;
end;

{$IFDEF DELPHI5}
procedure TdxfmPrintStylesDesignWindow.CheckAddStyle;
begin
  if not CanAdd then
    raise EdxException.CreateRes(@SCantAddToFrame);
end;
{$ENDIF}

procedure TdxfmPrintStylesDesignWindow.CheckDeleteStyle;
begin
  if not CanDelete then
    raise EdxException.CreateRes(@SCantDeleteAncestor);
end;

procedure TdxfmPrintStylesDesignWindow.Copy;
var
  Components: TdxDesignSelectionList;
begin
  Components := CreateDesignSelectionList;
  try
    GetSelections(Components);
    CopyComponents(Controller.Owner, Components);
  finally
    FreeDesignSelectionList(Components);
  end;
  UpdateHScrollBar;
end;

procedure TdxfmPrintStylesDesignWindow.Cut;
begin
  Copy;
  CheckDeleteStyle;
  Delete;
end;

procedure TdxfmPrintStylesDesignWindow.Delete;
var
  Selections: TdxDesignSelectionList;
  I, ItemIndex: Integer;
  Item: TComponent;
begin
  StartWait;
  try
    ControllerDesigner.BeginUpdate;
    try
      Selections := CreateDesignSelectionList;
      try
        GetSelections(Selections);
        ItemIndex := lbxStyles.ItemIndex;
        for I := 0 to Selections.Count - 1 do
        begin
          Item := TComponent(Selections[I]);
          if not (csAncestor in Item.ComponentState) then Item.Free;
        end;
        if ItemIndex < 0 then
          ItemIndex := 0;
        if ItemIndex > StyleCount - 1 then
          ItemIndex := StyleCount - 1;
      finally
        FreeDesignSelectionList(Selections);
      end;
    finally
      ControllerDesigner.CancelUpdate;
    end;  
    if ItemIndex <> -1 then
      Select(Styles[ItemIndex], False)
    else
      SelectController;
    UpdateHScrollBar;  
  finally
    StopWait;
  end;
end;

procedure TdxfmPrintStylesDesignWindow.DeleteItem(AItem: TBasedxPrintStyle);
var
  Index, ItemIndex: Integer;
begin
  Index := IndexOf(AItem);
  if Index <> -1 then
  begin
    ItemIndex := lbxStyles.ItemIndex;
    lbxStyles.Items.Delete(Index);
    
    if ItemIndex < 0 then
      ItemIndex := 0;
    if ItemIndex > StyleCount - 1 then
      ItemIndex := StyleCount - 1;
    if ItemIndex <> -1 then
      Select(Styles[ItemIndex], False)
    else
      SelectController;
    UpdateHScrollBar;
  end;
end;

procedure TdxfmPrintStylesDesignWindow.DrawDragRect;
begin
  with lbxStyles do
    if (FSaveDragIndex <> -1) and (FSaveDragIndex <> ItemIndex) then
      Canvas.DrawFocusRect(ItemRect(FSaveDragIndex));
end;

function TdxfmPrintStylesDesignWindow.GetMinWindowSize: TPoint;
begin
  Result.X := 300;
  Result.Y := btnRestoreDefaults.Top + btnRestoreDefaults.Height +
    GetSystemMetrics(SM_CYCAPTION) + 2 * GetSystemMetrics(SM_CXFRAME) + 4;
end;

procedure TdxfmPrintStylesDesignWindow.GetSelections(const ASelections: TdxDesignSelectionList);
var
  I: Integer;
begin
  for I := 0 to StyleCount - 1 do
    if Selected[I] then
      ASelections.Add(Styles[I]);
  if ASelections.Count = 0 then
    ASelections.Add(Controller);
end;

function TdxfmPrintStylesDesignWindow.IndexOf(AItem: TBasedxPrintStyle): Integer;
begin
  Result := lbxStyles.Items.IndexOfObject(AItem);
end;

procedure TdxfmPrintStylesDesignWindow.InternalAddStyle(AStyleClass: TdxPrintStyleClass);
var
  Style: TBasedxPrintStyle;
begin
//  AStyle := TBasedxPrintStyle(Designer.CreateComponent(AStyleClass, Designer.GetRoot, 0, 0, 0, 0));
  ControllerDesigner.BeginUpdate;
  try
    Style := Controller.AddStyleEx(AStyleClass, Designer.GetRoot);
    Style.Name := UniqueName(Style);
  finally
    ControllerDesigner.CancelUpdate;
  end;
  lbxStyles.Items.AddObject(Style.Name, Style);
  Select(Style, False);
  UpdateHScrollBar;
  lbxStyles.Update;
end;

procedure TdxfmPrintStylesDesignWindow.MoveSelection(ADelta: Integer);

  procedure MoveDown(ADelta: Integer);
  var
    I, Index: Integer;
  begin
    for I := StyleCount - 1 downto 0 do
      if Selected[I] then
      begin
        Index := Styles[I].Index;
        Inc(Index, ADelta);
        if Index > StyleCount - 1 then Index := StyleCount - 1;
//        while (Index < StyleCount) and Selected[Index] do Inc(Index);
        Styles[I].Index := Index;
      end;
  end;

  procedure MoveUp(ADelta: Integer);
  var
    I, Index: Integer;
  begin
    for I := 0 to StyleCount - 1 do
      if Selected[I] then
      begin
        Index := Styles[I].Index;
        Inc(Index, ADelta);
        if Index < 0 then Index := 0;
//        while (Index > -1) and Selected[Index] do Dec(Index);
        Styles[I].Index := Index;
      end;
  end;

begin
  ControllerDesigner.BeginUpdate;
  try
    if ADelta > 0 then
      MoveDown(ADelta)
    else
      MoveUp(ADelta);
  finally
    ControllerDesigner.EndUpdate;
  end;
end;

procedure TdxfmPrintStylesDesignWindow.Paste;
var
  Components: TdxDesignSelectionList;
  I: Integer;
begin
  Components := CreateDesignSelectionList;
  try
    StartWait;
    try
      lbxStyles.Items.BeginUpdate;
      try
        ControllerDesigner.BeginUpdate;
        try
          PasteComponents(Controller.Owner, Controller, Components);
        finally
          ControllerDesigner.EndUpdate;
        end;
        for I := StyleCount - 1 downto StyleCount - Components.Count do
          Selected[I] := True;
        Designer.SetSelections(Components);
      finally
        lbxStyles.Items.EndUpdate;
      end;
    finally
      StopWait;
    end;
  finally
    FreeDesignSelectionList(Components);
  end;
  UpdateHScrollBar;
end;

procedure TdxfmPrintStylesDesignWindow.PrepareAddStandardItem(MenuItem: TMenuItem);
begin
  if CanAddStandard then 
  begin
    MenuItem.Caption := 'Add ' + DropT(CurrentStyle.ClassName);
    MenuItem.Tag := MakeTTag(CurrentStyle.ClassType);
  end;
end;

procedure TdxfmPrintStylesDesignWindow.RefreshList;
var
  Selections: TdxDesignSelectionList;
  I, Index: Integer;
  Item: TBasedxPrintStyle;
  Component: TPersistent;
begin
  lbxStyles.Items.BeginUpdate;
  try
    Selections := CreateDesignSelectionList;
    try
      GetSelections(Selections);

      lbxStyles.Items.Clear;
      if Controller = nil then Exit;

      for I := 0 to Controller.Count - 1 do
      begin
        Item := Controller[I];
        if Item.Owner = Controller.Owner then 
          lbxStyles.Items.AddObject(Item.Name, Item);
      end;

      for I := 0 to Selections.Count - 1 do
      begin
        Component := Selections[I];
        if Component is TBasedxPrintStyle then
        begin
          Index := IndexOf(TBasedxPrintStyle(Component));
          if Index <> -1 then
            Selected[Index] := True;
        end;
      end;
    finally
      FreeDesignSelectionList(Selections);
    end;
  finally
    lbxStyles.Items.EndUpdate;
  end;
end;

procedure TdxfmPrintStylesDesignWindow.RestoreLayout;
begin
  with TRegistry.Create do
  try
    try
      if OpenKey(RegistryPath, False) then
      begin
        if ValueExists(sdxButtonBar) then
          pnlButtons.Visible := ReadBool(sdxButtonBar);
        if ValueExists(sdxWidth) then
          Width := ReadInteger(sdxWidth);
        if ValueExists(sdxHeight) then
          Height := ReadInteger(sdxHeight);
      end;
    except
      Abort;
    end;
  finally
    Free;
  end;
end;                               

procedure TdxfmPrintStylesDesignWindow.Select(AItem: TPersistent; AddToSelection: Boolean);
var
  Selections: TdxDesignSelectionList;
begin
  Selections := CreateDesignSelectionList;
  if AddToSelection then
    Designer.GetSelections(Selections);
  Selections.Add(AItem);
  Designer.SetSelections(Selections);
end;

procedure TdxfmPrintStylesDesignWindow.SelectAll;
var
  Selections: TdxDesignSelectionList;
  I: Integer;
begin
  Selections := CreateDesignSelectionList;
  for I := 0 to StyleCount - 1 do
    Selections.Add(Styles[I]);
  Designer.SetSelections(Selections);
end;

procedure TdxfmPrintStylesDesignWindow.SelectController;
begin
  Select(Controller, False);
end;

procedure TdxfmPrintStylesDesignWindow.StartWait;
begin
  FSaveCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
end;

procedure TdxfmPrintStylesDesignWindow.StopWait;
begin
  Screen.Cursor := FSaveCursor;
end;

procedure TdxfmPrintStylesDesignWindow.StoreLayout;
begin
  with TRegistry.Create do
  try
    try
      if OpenKey(RegistryPath, True) then
      begin
        WriteBool(sdxButtonBar, pnlButtons.Visible);
        WriteInteger(sdxWidth, Width);
        WriteInteger(sdxHeight, Height);
      end;
    except
      Abort;
    end;
  finally
    Free;
  end;
end;

procedure TdxfmPrintStylesDesignWindow.UpdateCaption;
var
  NewCaption: string;
begin
  if (Controller <> nil) and (Controller.Owner <> nil) then
    NewCaption := Format(sdxStyleDesigner, [Controller.Owner.Name, '.', Controller.Name]);
  if Caption <> NewCaption then
    Caption := NewCaption;
end;

procedure TdxfmPrintStylesDesignWindow.UpdateControlsState;
begin
  btnAdd.Enabled := CanAdd;
  btnDelete.Enabled := CanDelete;
  btnSelectAll.Enabled := CanSelectAll;
  btnMoveUp.Enabled := CanMoveUp;
  btnMoveDown.Enabled := CanMoveDown;
  btnPageSetup.Enabled := CanPageSetup;
  btnRestoreDefaults.Enabled := CanRestoreDefaults;
end;

procedure TdxfmPrintStylesDesignWindow.UpdateHScrollBar;
var
  I, W, W2: Integer;
begin
  W := 0;
  with lbxStyles, Items do
  begin
    for I := 0 to Count - 1 do
    begin
      if I = Controller.CurrentStyleIndex then
        Canvas.Font.Style := [fsBold]
      else
        Canvas.Font.Style := [];
      W2 := dxStyleGlyphSize.X + 4 + Canvas.TextWidth(Items[I]);
      if W2 > W then W := W2;
    end;
    Perform(LB_SETHORIZONTALEXTENT, W, 0);
    Canvas.Font.Style := [];
  end;
end;

procedure TdxfmPrintStylesDesignWindow.UpdateItem(AItem: TBasedxprintStyle);
var
  Index: Integer;
  R: TRect;
begin
  if AItem <> nil then
  begin
    Index := IndexOf(AItem);
    if Index <> -1 then
    begin
      lbxStyles.Items[Index] := AItem.Name;
      R := lbxStyles.ItemRect(Index);
      InvalidateRect(lbxStyles.Handle, @R, False);
      UpdateHScrollBar;
    end
  end
  else
    RefreshList;
  UpdateControlsState;
end;

procedure TdxfmPrintStylesDesignWindow.UpdateMenuState;
begin
  miAdd.Enabled := CanAdd;
  miAddStandard.Visible := CanAddStandard;
  PrepareAddStandardItem(miAddStandard);
  miCut.Enabled := CanCut;
  miCopy.Enabled := CanCopy;
  miPaste.Enabled := CanPaste;
  miDelete.Enabled := CanDelete;
  miSelectAll.Enabled := CanSelectAll;
  miMoveUp.Enabled := CanMoveUp;
  miMoveDown.Enabled := CanMoveDown;
  miPageSetup.Enabled := CanPageSetup;
  miSetAsCurrent.Enabled := CanSetAsCurrent;
  miRestoreDefaults.Enabled := CanRestoreDefaults;
  miBackgroundEffects.Enabled := CanBackgroundEffects;
  miBackgroundClear.Enabled := CanBackgroundClear;
  miShowButtons.Checked := pnlButtons.Visible;
end;

procedure TdxfmPrintStylesDesignWindow.UpdateSelections(const ASelections: TdxDesignSelectionList);

  function InSelection(AStyle: TBasedxPrintStyle): Boolean;
  var
    I: Integer;
  begin
    for I := 0 to ASelections.Count - 1 do
      if AStyle = ASelections[I] then
      begin
        Result := True;
        Exit;
      end;
    Result := False;
  end;

var
  I: Integer;
begin
  if (ASelections = nil) or (Controller = nil) or (csDestroying in Controller.ComponentState) or 
    (ControllerDesigner = nil) or (TdxStyleManagerDesigner(ControllerDesigner).FUpdateCount <> 0) then
    Exit;
  for I := 0 to StyleCount - 1 do
    if Selected[I] xor InSelection(Styles[I]) then
      Selected[I] := not Selected[I];
  UpdateControlsState;
end;

procedure TdxfmPrintStylesDesignWindow.WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo);
begin
  inherited;
  with Message.MinMaxInfo^ do 
    ptMinTrackSize := GetMinWindowSize;
end;

procedure TdxfmPrintStylesDesignWindow.WMNCCreate(var Message: TWMNCCreate);
const 
  TypeDataSize = 32;
var
  SysMenu: HMENU;
  P: Pointer;
  S: array[0..TypeDataSize - 1] of Char;
  Info: TMenuItemInfo;
  ItemExist: Boolean;
begin
  SysMenu := GetSystemMenu(Handle, False);
    P := @S[0]; 
    Info.cbSize := SizeOf(Info) - SizeOf(HBITMAP);
    Info.fMask := MIIM_ID or MIIM_TYPE;
    Info.dwTypeData := P;
    Info.cch := TypeDataSize;
    ItemExist := GetMenuItemInfo(SysMenu, SC_SIZE, False, Info);
    inherited;
    if ItemExist then
      InsertMenuItem(SysMenu, 0, True, Info);
end;

procedure TdxfmPrintStylesDesignWindow.WMNCDestroy(var Message: TWMNCCreate);
begin
  GetSystemMenu(Handle, True);
  inherited;
end;

end.

