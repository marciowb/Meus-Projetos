
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressQuantumGrid Layout editor                            }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSGRID AND ALL ACCOMPANYING VCL }
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

unit dxGLayEd;

interface

{$I dxTLVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, dxLayout, Menus, dxWizard
  {$IFNDEF DELPHI6}, DsgnWnds, LibIntf, DsgnIntf{$ELSE}, DesignWindows, DesignIntf{$ENDIF};

type
  TFDBGridLayoutEditor = class(TDesignWindow)
    GridPanel: TPanel;
    BBands: TButton;
    BColumns: TButton;
    BSummary: TButton;
    BClear: TButton;
    LItems: TListBox;
    BAdd: TButton;
    BDelete: TButton;
    BWizard: TButton;
    pmItems: TPopupMenu;
    miAdd: TMenuItem;
    miDelete: TMenuItem;
    miSelectAll: TMenuItem;
    pmButtons: TPopupMenu;
    miBands: TMenuItem;
    miColumns: TMenuItem;
    miSummary: TMenuItem;
    miWizard: TMenuItem;
    miClear: TMenuItem;
    procedure LItemsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBandsClick(Sender: TObject);
    procedure BWizardClick(Sender: TObject);
    procedure BClearClick(Sender: TObject);
    procedure GridPanelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BAddClick(Sender: TObject);
    procedure BDeleteClick(Sender: TObject);
    procedure miSelectAllClick(Sender: TObject);
    procedure miBandsClick(Sender: TObject);
    procedure miColumnsClick(Sender: TObject);
    procedure miSummaryClick(Sender: TObject);
  private
    FDeleting: Boolean;
    procedure PrepareLayouts(ActiveLayout: TdxDBGridLayout);
    procedure UnprepareLayouts;
    function GetSelLayout: TdxDBGridLayout;
    procedure UpdateDesigner;
    procedure WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
    procedure WMNCCreate(var Message: TWMNCCreate); message WM_NCCREATE;
  protected
    _flag: Boolean;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function UniqueName(Component: TComponent): string; override;
  public
    {$IFDEF DELPHI6}
    PDesigner: IDesigner;
    {$ELSE}
    PDesigner: {$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF};
    {$ENDIF}
    LayoutList: TdxDBGridLayoutList;
    procedure FillList;
    procedure LoadSelectedItems(List: TList);
    procedure SelectItem;
    procedure UnselectAll;
    procedure SelectAll;
    procedure UpdateSelection;
    function GetEditState: TEditState; override;
    {$IFDEF DELPHI6}
    function EditAction(Action: TEditAction): Boolean; override;
    {$ELSE}
    procedure EditAction(Action: TEditAction); override;
    {$ENDIF}
    procedure Cut;
    procedure Copy;
    procedure Paste;
  end;

procedure ShowDBGridLayoutListEditor(ADBGridLayuotList: TdxDBGridLayoutList; ADesigner: Pointer);

implementation

{$R *.DFM}

uses
  dxGrEdtr;

const
  MinClientWidth  = 574;
  MinClientHeight = 282;

type
  { TdxDBGridLayoutDesigner }
  TdxDBGridLayoutDesigner = class(TdxDBGridLayoutListDesigner)
  private
    FDestroying: Boolean;
    FDesignerForm: TFDBGridLayoutEditor;
  public
    destructor Destroy; override;
    procedure ChangedName(Layout: TdxDBGridLayout); override;
    procedure LayoutChanged; override;
    property DesignerForm: TFDBGridLayoutEditor read FDesignerForm;
  end;

procedure ShowDBGridLayoutListEditor(ADBGridLayuotList: TdxDBGridLayoutList; ADesigner: Pointer);
var
  AForm: TFDBGridLayoutEditor;
begin
  if ADBGridLayuotList.Designer <> nil then
  begin
    TdxDBGridLayoutDesigner(ADBGridLayuotList.Designer).DesignerForm.Show;
    Exit;
  end;
  // Create Editor Form
  AForm := TFDBGridLayoutEditor.Create(nil);
  AForm.LayoutList := ADBGridLayuotList;
  TdxDBGridLayoutDesigner.Create(ADBGridLayuotList).FDesignerForm := AForm;
  with AForm do
  begin
    {$IFDEF DELPHI6}
    PDesigner := IDesigner(ADesigner);
    {$ELSE}
    PDesigner := {$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}(ADesigner);
    {$ENDIF}
    Designer := PDesigner;
    FillList;
    Caption := 'Editing '+LayoutList.Name;
    Show;
  end;
end;

{TdxDBGridLayoutDesigner}
destructor TdxDBGridLayoutDesigner.Destroy;
begin
  FDestroying := True;
  if FDesignerForm <> nil then
    with FDesignerForm do
      if not (csDestroying in ComponentState) then Release;
  inherited Destroy;
end;

procedure TdxDBGridLayoutDesigner.ChangedName(Layout: TdxDBGridLayout);
var
  I: Integer;
begin
  if LayoutList <> nil then
    with FDesignerForm.LItems do
    begin
      for I := 0 to Items.Count - 1 do
        if (TdxDBGridLayout(Items.Objects[I]) = Layout) then Break;
      if (0 <= I) and (I < Items.Count) then
      begin
        Items[I] := Layout.Name;
        Selected[I] := True;
      end;
    end;
end;

procedure TdxDBGridLayoutDesigner.LayoutChanged;
begin
  if (FDesignerForm <> nil) and (FDesignerForm.LayoutList <> nil) then
  begin
    FDesignerForm.FillList;
    FDesignerForm.Caption := 'Editing '+FDesignerForm.LayoutList.Name;
  end;
end;

{TFDBGridLayoutEditor}
procedure TFDBGridLayoutEditor.PrepareLayouts(ActiveLayout: TdxDBGridLayout);
var
  I: Integer;
begin
  with LItems do
    for I := 0 to Items.Count - 1 do
      if TdxDBGridLayout(Items.Objects[I]) <> ActiveLayout then
        TdxDBGridLayout(Items.Objects[I]).Active := False; // free grid
  // ActiveLayout
  if (ActiveLayout <> nil) then
  begin
    GridPanel.BevelInner := bvNone;
    ActiveLayout.DBGridParent := GridPanel;
    ActiveLayout.Active := True;
    ActiveLayout.DBGrid.SetBounds(0, 0, GridPanel.ClientWidth, GridPanel.ClientHeight);
    ActiveLayout.DBGrid.Align := alClient;
    ActiveLayout.DBGrid.Visible := True;
    ActiveLayout.DBGrid.Parent := GridPanel;
    ActiveLayout.DBGrid.OnMouseUp := GridPanelMouseUp;
  end;
end;

procedure TFDBGridLayoutEditor.UnprepareLayouts;
var
  I: Integer;
  Layout: TdxDBGridLayout;
begin
  if (LayoutList <> nil) and not (csDestroying in LayoutList.ComponentState) then
  with LItems do
  begin
    for I := 0 to Items.Count - 1 do
    begin
      Layout := TdxDBGridLayout(Items.Objects[I]);
      if Layout.Active and (Layout.DBGrid.Designer <> nil) then
        Layout.DBGrid.Designer.Free;
      Layout.Active := False; // free grid
    end;
  end;  
  GridPanel.BevelInner := bvLowered;
end;

function TFDBGridLayoutEditor.GetSelLayout: TdxDBGridLayout;
var
  I: Integer;
begin
  Result := nil;
  with LItems do
  begin
    if SelCount = 1 then
      for I := 0 to Items.Count - 1 do
      if Selected[I] then
      begin
        Result := TdxDBGridLayout(Items.Objects[I]);
        Break;
      end;
  end;
end;

procedure TFDBGridLayoutEditor.UpdateDesigner;
begin
  if PDesigner <> nil then PDesigner.Modified;
end;

procedure TFDBGridLayoutEditor.WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo);
begin
  Message.MinMaxInfo^.ptMinTrackSize := Point(MinClientWidth, MinClientHeight);
  inherited;
end;

procedure TFDBGridLayoutEditor.WMNCCreate(var Message: TWMNCCreate);
var
  SysMenu: HMENU;
  Info: TMenuItemInfo;
  S: array [0..1023] of Char;
  ItemExist: Boolean;
begin
  SysMenu := GetSystemMenu(Handle, False);
  Info.cbSize := 44; // Required
  Info.fMask := MIIM_ID or MIIM_TYPE;
  Info.dwTypeData := @S[0];
  Info.cch := 1024;
  ItemExist := GetMenuItemInfo(SysMenu, SC_SIZE, False{MF_BYCOMMAND}, Info);
  inherited;
  if ItemExist then
    InsertMenuItem(SysMenu, 0, True, Info);
end;

procedure TFDBGridLayoutEditor.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    Style := Style or WS_THICKFRAME;
end;

procedure TFDBGridLayoutEditor.Notification(AComponent: TComponent; Operation: TOperation);
var
  I: Integer;
begin
  inherited Notification(AComponent, Operation);
  if csDestroying in ComponentState then Exit;
  if Operation = opRemove then
  with LItems do
  begin
    if not FDeleting then
      for I := 0 to Items.Count - 1 do
        if (Pointer(Items.Objects[I]) = Pointer(AComponent)) then
        begin
          Items.Delete(I);
          UnselectAll;
          UpdateSelection;
          Break;
        end;
  end;
end;

procedure TFDBGridLayoutEditor.FillList;
var
  I: Integer;
begin
  // Items
  with LItems do
  begin
    Items.BeginUpdate;
    try
      Items.Clear;
      for I := 0 to LayoutList.Count - 1 do
      begin
        Items.AddObject(LayoutList[I].Name, LayoutList[I]);
        LayoutList[I].FreeNotification(Self);
      end;
    finally
      Items.EndUpdate;
    end;
  end;
  // select component
  SelectItem;
end;

procedure TFDBGridLayoutEditor.LoadSelectedItems(List: TList);
var
  I: Integer;
begin
  with LItems do
    for I := 0 to Items.Count - 1 do
      if Selected[I] then
        List.Add(Items.Objects[I]);
end;

procedure TFDBGridLayoutEditor.SelectItem;
begin
  LItemsClick(nil);
end;

procedure TFDBGridLayoutEditor.UnselectAll;
var
  I: Integer;
begin
  with LItems do
  begin
    Items.BeginUpdate;
    if Items.Count > 0 then
    begin
      for I :=0 to Items.Count - 1 do
        Selected[I] := False;
    end;
    Items.EndUpdate;
    GridPanel.BevelInner := bvLowered;
  end;
end;

procedure TFDBGridLayoutEditor.SelectAll;
var
  I: Integer;
begin
  with LItems do
  begin
    for I := 0 to Items.Count - 1 do
      Selected[I] := True;
  end;
end;

function TFDBGridLayoutEditor.UniqueName(Component: TComponent): string;
begin
  Result := '';
  if (PDesigner <> nil) and (LayoutList <> nil) then
    Result := PDesigner.UniqueName(LayoutList.Name + 'Item');
end;

function TFDBGridLayoutEditor.GetEditState: TEditState;
begin
  Result := [];
  if ClipboardComponents then Result := [esCanPaste];
  if not _flag then
  if LItems.SelCount > 0 then
    Result := Result + [esCanCopy, esCanCut, esCanDelete];
end;

{$IFDEF DELPHI6}
function TFDBGridLayoutEditor.EditAction(Action: TEditAction): Boolean;
{$ELSE}
procedure TFDBGridLayoutEditor.EditAction(Action: TEditAction);
{$ENDIF}
begin
  {$IFDEF DELPHI6}
  Result := True;
  {$ENDIF}
  case Action of
    eaCut:
      Cut;
    eaCopy:
      Copy;
    eaPaste:
      Paste;
    eaDelete:
      BDeleteClick(nil);
    eaSelectAll:
      begin
        SelectAll;
        UpdateSelection;
      end;
   else
     {$IFDEF DELPHI6}
     Result := False;
     {$ENDIF}
  end;
end;

procedure TFDBGridLayoutEditor.Cut;
begin
  Copy;
  BDeleteClick(nil);
end;

procedure TFDBGridLayoutEditor.Copy;
var
  {$IFDEF DELPHI6}
    List: IDesignerSelections;
  {$ELSE}
    List: {$IFDEF DELPHI5}TDesignerSelectionList{$ELSE}TComponentList{$ENDIF};
  {$ENDIF}
  I: Integer;
begin
  {$IFDEF DELPHI6}
    List := CreateSelectionList;
  {$ELSE}
    List := {$IFDEF DELPHI5}TDesignerSelectionList{$ELSE}TComponentList{$ENDIF}.Create;
  {$ENDIF}
  try
    with LItems do
    begin
      if SelCount > 0 then
        for I := 0 to Items.Count - 1 do
          if Selected[I] then
            List.Add({$IFNDEF DELPHI3}TComponent{$ELSE}TPersistent{$ENDIF}(Items.Objects[I]));
    end;
    if LayoutList <> nil then
      CopyComponents(LayoutList.Owner, List);
  finally
    {$IFNDEF DELPHI6}
    List.Free;
    {$ENDIF}
  end;
end;

procedure TFDBGridLayoutEditor.Paste;
var
  {$IFDEF DELPHI6}
    List: IDesignerSelections;
  {$ELSE}
    List: {$IFDEF DELPHI5}TDesignerSelectionList{$ELSE}TComponentList{$ENDIF};
  {$ENDIF}
begin
  {$IFDEF DELPHI6}
    List := CreateSelectionList;
  {$ELSE}
    List := {$IFDEF DELPHI5}TDesignerSelectionList{$ELSE}TComponentList{$ENDIF}.Create;
  {$ENDIF}
  try
    if LayoutList <> nil then
    begin
      PasteComponents(LayoutList.Owner, LayoutList, List);
      with LItems do
      begin
        Items.BeginUpdate;
        try
          FillList;
          Selected[Items.Count - 1] := True;
          ItemIndex := Items.Count - 1;
          SetFocus;
        finally
          Items.EndUpdate;
        end;
        LItemsClick(nil);
        UpdateDesigner;
      end;
    end;
  finally
    {$IFNDEF DELPHI6}
    List.Free;
    {$ENDIF}
  end;
end;

procedure TFDBGridLayoutEditor.UpdateSelection;
var
  {$IFDEF DELPHI6}
    List: IDesignerSelections;
  {$ELSE}
    List: {$IFDEF DELPHI5}TDesignerSelectionList{$ELSE}TComponentList{$ENDIF};
  {$ENDIF}
  I: Integer;
begin
  if Active then
  begin
    {$IFDEF DELPHI6}
      List := CreateSelectionList;
    {$ELSE}
      List := {$IFDEF DELPHI5}TDesignerSelectionList{$ELSE}TComponentList{$ENDIF}.Create;
    {$ENDIF}
    try
      with LItems do
      begin
        if SelCount > 0 then
          for I := 0 to Items.Count - 1 do
            if Selected[I] then
              List.Add({$IFNDEF DELPHI3}TComponent{$ELSE}TPersistent{$ENDIF}(Items.Objects[I]));
        if List.Count = 0 then List.Add(LayoutList);
        {TODO}
        PDesigner.SetSelections(List);
        SetSelection(List);
        if List.Count = 1 then
          PrepareLayouts(GetSelLayout)
        else UnprepareLayouts;
      end;
    finally
    end;
  end;
end;

procedure TFDBGridLayoutEditor.LItemsClick(Sender: TObject);
begin
  UpdateSelection;
  // Buttons
  with LItems do
  begin
    BDelete.Enabled := SelCount > 0;
    BClear.Enabled := BDelete.Enabled;
    miDelete.Enabled := BDelete.Enabled;
    miClear.Enabled := BDelete.Enabled;
    BBands.Enabled := SelCount = 1;
    BColumns.Enabled := BBands.Enabled;
    BSummary.Enabled := BBands.Enabled;
    BWizard.Enabled := BBands.Enabled;
    miBands.Enabled := BBands.Enabled;
    miColumns.Enabled := BBands.Enabled;
    miSummary.Enabled := BBands.Enabled;
    miWizard.Enabled := BBands.Enabled;
    if SelCount = 1 then
      GridPanel.BevelInner := bvNone
    else GridPanel.BevelInner := bvLowered;
  end;
end;

procedure TFDBGridLayoutEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  _flag := True;
  Action := caFree;
  if Assigned(LayoutList) and not (csDestroying in LayoutList.ComponentState) then
  begin
    UpdateSelection;
    UnprepareLayouts;
    if (LayoutList.Designer <> nil) and not (TdxDBGridLayoutDesigner(LayoutList.Designer).FDestroying) then
    begin
      TdxDBGridLayoutDesigner(LayoutList.Designer).FDesignerForm := nil;
      LayoutList.Designer.Free;
    end;
  end;
  PDesigner := nil;
end;

// ButtonPanel
procedure TFDBGridLayoutEditor.BBandsClick(Sender: TObject);
var
  SelLayout: TdxDBGridLayout;
begin
  SelLayout := GetSelLayout;
  if SelLayout <> nil then
  begin
    PrepareLayouts(SelLayout);
    ShowdxDBGridEditor(SelLayout.DBGrid, Pointer(PDesigner), TButton(Sender).Tag, SelLayout.DBGrid);
  end;
end;

procedure TFDBGridLayoutEditor.BWizardClick(Sender: TObject);
var
  SelLayout: TdxDBGridLayout;
begin
  SelLayout := GetSelLayout;
  if (SelLayout <> nil) and SelLayout.Active then
  begin
    if SelLayout.DBGrid.Designer <> nil then SelLayout.DBGrid.Designer.Free;
    PrepareLayouts(SelLayout);
    ShowdxDBGridWizard(SelLayout.DBGrid, Pointer(PDesigner), SelLayout.DBGrid.Owner);
    UpdateSelection;
    UpdateDesigner;
  end;
end;

procedure TFDBGridLayoutEditor.BClearClick(Sender: TObject);
var
  List: TList;
  I: Integer;
begin
  // SelLayout.Clear;
  UnprepareLayouts;
  List := TList.Create;
  try
    LoadSelectedItems(List);
    for I := 0 to List.Count - 1 do
      TdxDBGridLayout(List[I]).Clear;
    UpdateDesigner;
  finally
    List.Free;
  end;
  PrepareLayouts(GetSelLayout);
  UpdateSelection;
end;

procedure TFDBGridLayoutEditor.GridPanelMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
  SelLayout: TdxDBGridLayout;
begin
  SelLayout := GetSelLayout;
  if (SelLayout <> nil) and SelLayout.Active and
    (SelLayout.DBGrid.Parent = GridPanel) then
  begin
    SelLayout.DBGrid.SetFocus;
    PDesigner.SelectComponent(SelLayout.DBGrid);
  end;
  UpdateDesigner;
  if (Sender is TWinControl) and (Button = mbRight) then
    with Sender as TWinControl do
    begin
      P := ClientToScreen(Point(X, Y));
      pmButtons.Popup(P.X, P.Y);
    end;
end;

// Items Panel
procedure TFDBGridLayoutEditor.BAddClick(Sender: TObject);
begin
  if LayoutList <> nil then
  with LItems do
  begin
    Items.BeginUpdate;
    try
      LayoutList.AddLayout;
      FillList;
      Selected[Items.Count - 1] := True;
      ItemIndex := Items.Count - 1;
      SetFocus;
    finally
      Items.EndUpdate;
    end;
    LItemsClick(nil);
    UpdateDesigner;
  end;
end;

procedure TFDBGridLayoutEditor.BDeleteClick(Sender: TObject);
var
  I, OldIndex: Integer;
  List: TList;
begin
  if (LayoutList <> nil) and (LItems.SelCount > 0) then
  with LItems do
  begin
    OldIndex := ItemIndex;
    List := TList.Create;
    try
      LoadSelectedItems(List);
      Items.BeginUpdate;
      try
        UnselectAll;
        SelectItem;
        FDeleting := True;
        try
          for I := 0 to List.Count - 1 do
            TdxDBGridLayout(List[I]).Free;
        finally
          FDeleting := False;
        end;
        FillList;
        if OldIndex >= Items.Count then
          OldIndex := Items.Count - 1;
        if (OldIndex <> -1) and (Items.Count > 0) then
          Selected[OldIndex] := True;
        SetFocus;
      finally
        Items.EndUpdate;
      end;
      LItemsClick(nil);
      UpdateDesigner;
    finally
      List.Free;
    end;
  end;
end;

procedure TFDBGridLayoutEditor.miSelectAllClick(Sender: TObject);
begin
  SelectAll;
  LItemsClick(nil);
end;

procedure TFDBGridLayoutEditor.miBandsClick(Sender: TObject);
begin
  BBandsClick(BBands);
end;

procedure TFDBGridLayoutEditor.miColumnsClick(Sender: TObject);
begin
  BBandsClick(BColumns);
end;

procedure TFDBGridLayoutEditor.miSummaryClick(Sender: TObject);
begin
  BBandsClick(BSummary);
end;

end.
