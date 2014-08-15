
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressQuantumGrid editor                                   }
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

unit dxGrEdtr;

interface

{$I dxTLVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, ExtCtrls, dxTL, dxDBGrid, ComCtrls, Buttons, dxCntner, dxDBCtrl,
  dxGrWzrd{$IFNDEF DELPHI6}, DsgnWnds, DsgnIntf{$ELSE}, DesignWindows, DesignIntf{$ENDIF};

type
  {TFdxDBGridEditor}
  TFdxDBGridEditor = class(TDesignWindow)
    Panel4: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel1: TPanel;
    PageControl: TPageControl;
    tsColumns: TTabSheet;
    tsSummaryGroups: TTabSheet;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel8: TPanel;
    pnButtons: TPanel;
    BAdd: TButton;
    BDelete: TButton;
    BUp: TButton;
    BDown: TButton;
    BWizard: TButton;
    BRestore: TButton;
    BChange: TButton;
    BRestoreWidths: TButton;
    CListBox: TListBox;
    pmColumns: TPopupMenu;
    miAdd: TMenuItem;
    miDelete: TMenuItem;
    miChangetype: TMenuItem;
    miUp: TMenuItem;
    miDown: TMenuItem;   
    miWizard: TMenuItem;
    miRestore: TMenuItem;
    miRestoreDefaultWidths: TMenuItem;
    miSelectAll: TMenuItem;
    tsBands: TTabSheet;
    Panel9: TPanel;
    Panel10: TPanel;
    pnItems: TPanel;
    pnGroups: TPanel;
    Panel11: TPanel;
    Panel7: TPanel;
    Panel16: TPanel;
    GroupBox1: TGroupBox;
    LGroups: TListBox;
    Panel17: TPanel;
    Panel18: TPanel;
    Panel19: TPanel;
    Panel21: TPanel;
    BAddGroup: TButton;
    BDeleteGroup: TButton;
    GroupBox2: TGroupBox;
    LItems: TListBox;
    Panel14: TPanel;
    Panel20: TPanel;
    Panel22: TPanel;
    Panel23: TPanel;
    BAddItem: TButton;
    BDeleteItem: TButton;
    pmGroups: TPopupMenu;
    miAddGroup: TMenuItem;
    miDeleteGroup: TMenuItem;
    miSellectGroup: TMenuItem;
    N1: TMenuItem;
    pmItems: TPopupMenu;
    miAddItem: TMenuItem;
    miDeleteItem: TMenuItem;
    MenuItem3: TMenuItem;
    miSelectItems: TMenuItem;
    Panel12: TPanel;
    BAddBand: TButton;
    BDeleteBand: TButton;
    BUpBand: TButton;
    BDownBand: TButton;
    BRestoreDefault: TButton;
    Panel13: TPanel;
    Panel15: TPanel;
    Panel24: TPanel;
    LBands: TListBox;
    pmBands: TPopupMenu;
    miAddBand: TMenuItem;
    miDeleteBand: TMenuItem;
    miUpBand: TMenuItem;
    miDownBand: TMenuItem;
    miRestoreBands: TMenuItem;
    miAllBands: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CListBoxClick(Sender: TObject);
    procedure CListBoxStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure CListBoxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CListBoxEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure CListBoxDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure CListBoxDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure BAddClick(Sender: TObject);
    procedure BDeleteClick(Sender: TObject);
    procedure BChangeClick(Sender: TObject);
    procedure BUpClick(Sender: TObject);
    procedure BDownClick(Sender: TObject);
    procedure BWizardClick(Sender: TObject);
    procedure BRestoreClick(Sender: TObject);
    procedure BRestoreWidthsClick(Sender: TObject);
    procedure miSelectAllClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure LGroupsClick(Sender: TObject);
    procedure miSellectGroupClick(Sender: TObject);
    procedure LGroupsEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure LGroupsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure LGroupsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure BAddGroupClick(Sender: TObject);
    procedure BDeleteGroupClick(Sender: TObject);
    procedure LItemsClick(Sender: TObject);
    procedure LItemsEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure LItemsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure LItemsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure BAddItemClick(Sender: TObject);
    procedure BDeleteItemClick(Sender: TObject);
    procedure miSelectItemsClick(Sender: TObject);
    procedure BRestoreDefaultClick(Sender: TObject);
    procedure BAddBandClick(Sender: TObject);
    procedure BDeleteBandClick(Sender: TObject);
    procedure BUpBandClick(Sender: TObject);
    procedure BDownBandClick(Sender: TObject);
    procedure miAllBandsClick(Sender: TObject);
    procedure LBandsClick(Sender: TObject);
    procedure LBandsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure LBandsEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure LBandsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure PageControlChange(Sender: TObject);
  private
    FOldDragIndex: Integer;
    FClosed: Boolean;
    procedure ColumnChangeName(Sender: TObject);
    procedure UpdateDesigner;
    procedure WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
  protected
    procedure Activated; override;
    function ObjectInList(ASelection: {$IFDEF DELPHI6} IDesignerSelections {$ELSE}
      {$IFDEF DELPHI5}TDesignerSelectionList{$ELSE}TComponentList{$ENDIF}{$ENDIF};
      AItem: TPersistent): Boolean;
    function SelectItems(ASelection: {$IFDEF DELPHI6} IDesignerSelections {$ELSE}
      {$IFDEF DELPHI5}TDesignerSelectionList{$ELSE}TComponentList{$ENDIF}{$ENDIF};
      AFlagCheck: Boolean): Boolean;
    function UniqueName(Component: TComponent): string; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    PDesigner: Pointer;
    DBGrid: TCustomdxDBGrid;
    ColumnOwner: TComponent;
    destructor Destroy; override;
    {$IFDEF DELPHI6}
    procedure DesignerClosed(const Designer: IDesigner; AGoingDormant: Boolean); override;
    procedure SelectionChanged(const ADesigner: IDesigner; const ASelection: IDesignerSelections); override;
    {$ELSE}
    procedure FormClosed(AForm: TCustomForm); override;
    procedure SelectionChanged(ASelection: {$IFDEF DELPHI5}TDesignerSelectionList{$ELSE}TComponentList{$ENDIF}); override;
    {$ENDIF}
    procedure FillLists;
    procedure FillSummaryItems;
    procedure ListBoxDragOver(ListBox: TListBox; Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure LoadSelectedItems(List: TList; Id: Integer);
    procedure SelectItem;
    procedure UnSelectAll;
  end;

procedure ShowdxDBGridEditor(ADBGrid: TdxDBGrid; ADesigner: Pointer;
  Id: Integer{0-Bands, 1-Columns, 2-SummaryGroups}; AColumnOwner: TComponent);

implementation

{$R *.DFM}

uses dxGrColA, dxGrReg;

const
  MinClientWidth  = 375;
  MinClientHeight = 305;

type

{TdxDBGridDesigner}
TdxDBGridDesigner = class(TdxTreeListDesigner)
private
  FDestroying: Boolean;
  FDesignerForm: TFdxDBGridEditor;
public
  destructor Destroy; override;
  procedure LayoutChanged; override;
  property DesignerForm: TFdxDBGridEditor read FDesignerForm;
end;

procedure ShowdxDBGridEditor(ADBGrid: TdxDBGrid; ADesigner: Pointer;
  Id: Integer; AColumnOwner: TComponent);
var
  AForm: TFdxDBGridEditor;
begin
  if ADBGrid.Designer <> nil then
  begin
    with TdxDBGridDesigner(ADBGrid.Designer).DesignerForm do
    begin
      case Id of
      0: PageControl.ActivePage := tsBands;
      1: PageControl.ActivePage := tsColumns;
      2: PageControl.ActivePage := tsSummaryGroups;
      end;
      ColumnOwner := AColumnOwner;
      Show;
    end;
    Exit;
  end;
  AForm := TFdxDBGridEditor.Create(nil);
  AForm.DBGrid := ADBGrid;
  TdxDBGridDesigner.Create(ADBGrid).FDesignerForm := AForm;
  with AForm do
  begin
    {$IFDEF DELPHI6}
    Designer := IDesigner(ADesigner);
    {$ENDIF}
    ColumnOwner := AColumnOwner;
    PDesigner := ADesigner;
    FillLists;
    Caption := 'Editing '+ADBGrid.Name;
    case Id of
      0: PageControl.ActivePage := tsBands;
      1: PageControl.ActivePage := tsColumns;
      2: PageControl.ActivePage := tsSummaryGroups;
    end;
    Show;
  end;
end;

{TdxDBGridDesigner}
destructor TdxDBGridDesigner.Destroy;
begin
  FDestroying := True;
  if FDesignerForm <> nil then
  with FDesignerForm do
  begin
    if not (csDestroying in ComponentState) then
    begin
      Release;
    end;   
    if Assigned(DBGrid) and (csDestroying in DBGrid.ComponentState) then
      DBGrid := nil;
  end;
  inherited Destroy;
end;

procedure TdxDBGridDesigner.LayoutChanged;
begin
  if FDesignerForm <> nil then
  begin
    FDesignerForm.FillLists;
    FDesignerForm.Caption := 'Editing '+FDesignerForm.DBGrid.Name;
  end;
end;

{TTFdxDBGridEditor}
// protected TTFdxDBGridEditor
procedure TFdxDBGridEditor.Activated;
begin
  SelectItem;
end;

function TFdxDBGridEditor.ObjectInList(ASelection: {$IFDEF DELPHI6} IDesignerSelections {$ELSE}
  {$IFDEF DELPHI5}TDesignerSelectionList{$ELSE}TComponentList{$ENDIF}{$ENDIF};
  AItem: TPersistent): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to ASelection.Count - 1 do
    if AItem = ASelection[I] then
    begin
      Result := True;
      Break;
    end;
end;

function TFdxDBGridEditor.SelectItems(ASelection: {$IFDEF DELPHI6} IDesignerSelections {$ELSE}
  {$IFDEF DELPHI5}TDesignerSelectionList{$ELSE}TComponentList{$ENDIF}{$ENDIF};
  AFlagCheck: Boolean): Boolean;

  function SelectList(AListBox: TListBox; AFlagCheck: Boolean): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    with AListBox do
    begin
      for I := 0 to Items.Count - 1 do
      begin
        if ObjectInList(ASElection, TPersistent(Items.Objects[I])) then
          if AFlagCheck then
          begin
            Result := True;
            Break;
          end
          else
            Selected[I] := True;
      end;
    end;
  end;

begin
  Result := False;
  if SelectList(LBands, AFlagCheck) then
  begin
    PageControl.ActivePage := tsBands;
    Result := True;
  end;
  if SelectList(CListBox, AFlagCheck) then
  begin
    PageControl.ActivePage := tsColumns;
    Result := True;
  end;
  if SelectList(LGroups, AFlagCheck) then
  begin
    PageControl.ActivePage := tsSummaryGroups;
    Result := True;
  end;
end;

function TFdxDBGridEditor.UniqueName(Component: TComponent): string;
begin
end;

procedure TFdxDBGridEditor.Notification(AComponent: TComponent; Operation: TOperation);
var
  I: Integer;
begin
  inherited Notification(AComponent, Operation);
  if csDestroying in ComponentState then Exit;
  if DBGrid <> nil then
    if csDestroying in DBGrid.ComponentState then Exit;
  if Operation = opRemove then
  with CListbox do
  begin
    for I := 0 to Items.Count - 1 do
      if (TdxTreeListColumn(Items.Objects[I]) = TdxTreeListColumn(AComponent)) then
    begin
      Items.Delete(I);
      UnselectAll;
      if (PDesigner <> nil) and (DBGrid <> nil) then
        {$IFDEF DELPHI6}
          IDesigner(PDesigner).SelectComponent(nil);
        {$ELSE}
          {$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}(PDesigner).SelectComponent(nil);
        {$ENDIF}
      Break;
    end;
  end;
end;

// private TTFdxDBGridEditor
procedure TFdxDBGridEditor.ColumnChangeName(Sender: TObject);
var
  I: Integer;
begin
  if DBGrid <> nil then
  begin
    // Columns
    if Sender is TdxTreeListColumn then
    with CListbox do
    begin
      for I := 0 to Items.Count - 1 do
        if (TdxTreeListColumn(Items.Objects[I]) = TdxTreeListColumn(Sender)) then Break;
      if (0 <= I) and (I < Items.Count) then
      begin
        Items[I] := TComponent(Sender).Name;
        Selected[I] := True;
        // refresh summary items
        FillSummaryItems;
      end;
    end;
    // Groups
    if Sender is TdxDBGridSummaryGroup then
    with LGroups do
    begin
      for I := 0 to Items.Count - 1 do
        if (TdxDBGridSummaryGroup(Items.Objects[I]) = TdxDBGridSummaryGroup(Sender)) then Break;
      if (0 <= I) and (I < Items.Count) then
      begin
        Items[I] := TdxDBGridSummaryGroup(Sender).Name;
        Selected[I] := True;
      end;
    end;
  end;
end;

procedure TFdxDBGridEditor.UpdateDesigner;
begin
  if PDesigner <> nil then
    {$IFDEF DELPHI6}
      IDesigner(PDesigner).Modified;
    {$ELSE}
      {$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}(PDesigner).Modified;
    {$ENDIF}
end;

procedure TFdxDBGridEditor.WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo);
begin
  Message.MinMaxInfo^.ptMinTrackSize := Point(MinClientWidth, MinClientHeight);
  inherited;
end;

procedure TFdxDBGridEditor.FormCreate(Sender: TObject);
begin
  // Bands
  miAddBand.Caption := BAddBand.Caption;
  miDeleteBand.Caption := BDeleteBand.Caption;
  miUpBand.Caption := BUpBand.Caption;
  miDownBand.Caption := BDownBand.Caption;
  miRestoreBands.Caption := BRestoreDefault.Caption;
  //Columns
  miAdd.Caption := BAdd.Caption;
  miDelete.Caption := BDelete.Caption;
  miChangetype.Caption := BChange.Caption;
  miUp.Caption := BUp.Caption;
  miDown.Caption := BDown.Caption;
  miWizard.Caption := BWizard.Caption;
  miRestore.Caption := BRestore.Caption;
  miRestoreDefaultWidths.Caption := BRestoreWidths.Caption;
  // Summary
  miAddGroup.Caption := BAddGroup.Caption;
  miDeleteGroup.Caption := BDeleteGroup.Caption;
  miAddItem.Caption := BAddItem.Caption;
  miDeleteItem.Caption := BDeleteItem.Caption;
end;

procedure TFdxDBGridEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

destructor TFdxDBGridEditor.Destroy;
var
  I: Integer;
begin
  Destroying;
  if (DBGrid <> nil) and not (csDestroying in DBGrid.ComponentState) then
  if (GetParentForm(DBGrid) <> nil) {and (GetParentForm(DBGrid).Designer <> nil)} then
  begin
    if (GetParentForm(DBGrid).Designer <> nil) and Active then
      {$IFDEF DELPHI6}
        IDesigner(PDesigner).SelectComponent(nil);
      {$ELSE}
        {$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}(PDesigner).SelectComponent(nil);
      {$ENDIF}
    if Assigned(DBGrid) and not (csDestroying in DBGrid.ComponentState) then
    begin
      if (DBGrid.Designer <> nil) and not (TdxDBGridDesigner(DBGrid.Designer).FDestroying) then
      begin
        TdxDBGridDesigner(DBGrid.Designer).FDesignerForm := nil;
        DBGrid.Designer.Free;
      end;
      for I := 0 to DBGrid.ColumnCount - 1 do
        DBGrid.Columns[I].OnChangeName := nil;
      for I := 0 to DBGrid.SummaryGroups.Count - 1 do
        DBGrid.SummaryGroups[I].OnChangeName := nil;
    end;
  end;
  inherited Destroy;
end;

{$IFDEF DELPHI6}

procedure TFdxDBGridEditor.DesignerClosed(const Designer: IDesigner; AGoingDormant: Boolean);
begin
  if Designer = Self.Designer then
  begin
    FClosed := True;
    PDesigner := nil;
  end;
end;

procedure TFdxDBGridEditor.SelectionChanged(const ADesigner: IDesigner; const ASelection: IDesignerSelections);
begin
  if FClosed or (ADesigner <> Self.Designer) then Exit;
  if not Active and SelectItems(ASelection, True) then
  begin
    UnSelectAll;
    SelectItems(ASelection, False);
  end;
end;

{$ELSE}

procedure TFdxDBGridEditor.FormClosed(AForm: TCustomForm);
begin
  if Assigned(AForm) and (Pointer(AForm.Designer) = PDesigner) then
  begin
    FClosed := True;
    PDesigner := nil;
  end;
end;

procedure TFdxDBGridEditor.SelectionChanged(ASelection: {$IFDEF DELPHI5}TDesignerSelectionList{$ELSE}TComponentList{$ENDIF});
begin
  if ASelection = nil then Exit;
  if FClosed then Exit;
  if not Active and SelectItems(ASelection, True) then
  begin
    UnSelectAll;
    SelectItems(ASelection, False);
  end;
end;

{$ENDIF}

procedure TFdxDBGridEditor.FillLists;
var
  I: Integer;
begin
  // Bands
  with LBands do
  begin
    Items.BeginUpdate;
    Items.Clear;
    for I := 0 to DBGrid.Bands.Count - 1 do
      Items.AddObject(IntToStr(I) + ' - ' + DBGrid.Bands[I].ClassName,
        DBGrid.Bands[I]);
    Items.EndUpdate;
  end;
  // Columns
  with CListBox do
  begin
    Items.BeginUpdate;
    Items.Clear;
    if not DBGrid.DefaultFields then
      for I := 0 to DBGrid.ColumnCount - 1 do
      begin
        Items.AddObject(DBGrid.Columns[I].Name, DBGrid.Columns[I]);
        DBGrid.Columns[I].OnChangeName := Self.ColumnChangeName;
        DBGrid.Columns[I].FreeNotification(Self);
      end;
    Items.EndUpdate;
  end;
  // Summary
  with LGroups do
  begin
    Items.BeginUpdate;
    Items.Clear;
    for I := 0 to DBGrid.SummaryGroups.Count - 1 do
    begin
      Items.AddObject(DBGrid.SummaryGroups[I].Name, DBGrid.SummaryGroups[I]);
      DBGrid.SummaryGroups[I].OnChangeName := Self.ColumnChangeName;
    end;
    Items.EndUpdate;
  end;
  FillSummaryItems;
  // select component
  SelectItem;
end;

procedure TFdxDBGridEditor.LoadSelectedItems(List: TList; Id: Integer);
var
  I: Integer;
begin
  case Id of
  0: with LBands do
     begin
       for I := 0 to Items.Count - 1 do
         if Selected[I] then
           List.Add(Items.Objects[I]);
     end;
  1: with CListbox do
     begin
       for I := 0 to Items.Count - 1 do
         if Selected[I] then
           List.Add(Items.Objects[I]);
     end;
  2: with LGroups do
     begin
       for I := 0 to Items.Count - 1 do
         if Selected[I] then
           List.Add(Items.Objects[I]);
     end;
  3: with LItems do
     begin
       for I := 0 to Items.Count - 1 do
         if Selected[I] then
           List.Add(Items.Objects[I]);
     end;
  end;
end;

procedure TFdxDBGridEditor.SelectItem;
begin
  case PageControl.ActivePage.TabIndex of
  0: LBandsClick(nil);
  1: CListBoxClick(nil);
  2: begin
       if not (LItems.Focused or BAddItem.Focused or BDeleteItem.Focused) then
         LGroupsClick(nil)
       else LItemsClick(nil); 
     end;
  else
    CListBoxClick(nil);
  end;
end;

procedure TFdxDBGridEditor.UnSelectAll;
var
  I: Integer;
begin
  // Bands
  with LBands do
  begin
    Items.BeginUpdate;
    if Items.Count > 0 then
    begin
       for I :=0 to Items.Count - 1 do
         Selected[I] := False;
    end;
    Items.EndUpdate;
  end;
  // Columns
  with CListbox do
  begin
    Items.BeginUpdate;
    if Items.Count > 0 then
    begin
       for I :=0 to Items.Count - 1 do
         CListBox.Selected[I] := False;
    end;
    Items.EndUpdate;
  end;
  // Summary
  with LGroups do
  begin
    Items.BeginUpdate;
    if Items.Count > 0 then
    begin
       for I :=0 to Items.Count - 1 do
         Selected[I] := False;
    end;
    Items.EndUpdate;
  end;
  with LItems do
  begin
    Items.BeginUpdate;
    if Items.Count > 0 then
    begin
       for I :=0 to Items.Count - 1 do
         Selected[I] := False;
    end;
    Items.EndUpdate;
  end;
end;

// CListBox - Columns
procedure TFdxDBGridEditor.CListBoxClick(Sender: TObject);
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
    with CListbox do
    begin
      if SelCount > 0 then
        for I := 0 to Items.Count - 1 do
          if Selected[I] then
            List.Add({$IFNDEF DELPHI3}TComponent{$ELSE}TPersistent{$ENDIF}(Items.Objects[I]));
      {$IFDEF DELPHI6}
        if List.Count > 0 then
          IDesigner(PDesigner).SetSelections(List)
        else
          IDesigner(PDesigner).SelectComponent(DBGrid);
      {$ELSE}
        if List.Count > 0 then
          {$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}(PDesigner).SetSelections(List)
        else
          {$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}(PDesigner).SelectComponent(DBGrid);
      {$ENDIF}
    end;
  finally
    {$IFNDEF DELPHI6}
    List.Free;
    {$ENDIF}
  end;
  with CListbox do
  begin
    BDelete.Enabled := SelCount > 0;
    BChange.Enabled := SelCount > 0;
    BUp.Enabled := SelCount > 0;
    BDown.Enabled := SelCount > 0;
    BRestore.Enabled := Items.Count > 0;
    BRestoreWidths.Enabled := Items.Count > 0;
    BWizard.Enabled := (DBGrid <> nil) and Assigned(DBGrid.DataSource) and
      Assigned(DBGrid.DataSource.DataSet) and (DBGrid.DataSource.DataSet.FieldCount > 0);
    {PopupMenu}
    miDelete.Enabled := BDelete.Enabled;
    miChangetype.Enabled := BChange.Enabled;
    miUp.Enabled := BUp.Enabled;
    miDown.Enabled := BDown.Enabled;
    miRestore.Enabled := BRestore.Enabled;
    miRestoreDefaultWidths.Enabled := BRestoreWidths.Enabled;
    miWizard.Enabled := BWizard.Enabled;
  end;
end;

procedure TFdxDBGridEditor.CListBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then ActivateInspector(#0);
end;

// drag drop
procedure TFdxDBGridEditor.CListBoxStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  FOldDragIndex := -1;
end;

procedure TFdxDBGridEditor.CListBoxEndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if (0 <= FOldDragIndex) and (FOldDragIndex < CListBox.Items.Count) then
  begin
    CListBox.Selected[FOldDragIndex] := False;
    FOldDragIndex := -1;
  end;
end;

procedure TFdxDBGridEditor.ListBoxDragOver(ListBox: TListBox;
  Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  Index: Integer;
begin
  if Source = ListBox then
  with ListBox do
  begin
    Accept := True;
    Index := ItemAtPos(Point(X, Y), True);
    if (FOldDragIndex <> Index) then
    begin
      if (0 <= FOldDragIndex) and (FOldDragIndex < Items.Count) then
        Selected[FOldDragIndex] := False;
      if Index <> -1 then
        if not Selected[Index] then
        begin
          Selected[Index] := True;
          FOldDragIndex := Index;
        end
        else
        begin
          FOldDragIndex := -1;
        end;
    end;
    ItemIndex := Index;
  end
  else Accept := False;
end;

procedure TFdxDBGridEditor.CListBoxDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  ListBoxDragOver(CListBox, Sender, Source, X, Y, State, Accept);
end;

procedure TFdxDBGridEditor.CListBoxDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  I, Index, OldIndex: Integer;
begin
  with CListBox do
  begin
    if (0 <= FOldDragIndex) and (FOldDragIndex < Items.Count) then
    begin
      Selected[FOldDragIndex] := False;
      FOldDragIndex := -1;
    end;
    Index := ItemAtPos(Point(X, Y), True);
    OldIndex := ItemIndex;
    if (Index <> -1) and (DBGrid <> nil) then
    begin
      for I := Items.Count - 1 downto 0 do
      begin
        if Selected[I] then
          TdxTreeListColumn(Items.Objects[I]).Index:= Index;
      end;
      FillLists;
      if OldIndex < 0 then OldIndex := 0;
      if OldIndex >= Items.Count then
        OldIndex := Items.Count - 1;
      if (OldIndex <> -1) and (Items.Count > 0) then
        Selected[OldIndex] := True;
      CListBoxClick(nil);
      UpdateDesigner;
    end;
  end;
end;

// Buttons
procedure TFdxDBGridEditor.BAddClick(Sender: TObject);
var
  AColumnClass: TdxDBTreeListColumnClass;
  P: TPoint;
begin
  P := Point(BAdd.Left + BAdd.Width, BAdd.Top);
  P := ClientToScreen(P);
  AColumnClass := TdxDBTreeListColumnClass(SelectdxTreeListColumn(P.X, P.Y, '', ADBGroupListColumns));
  if AColumnClass <> nil then
  if DBGrid <> nil then
  with CListBox do
  begin
    Items.BeginUpdate;
    try
      DBGrid.DefaultFields := False;
      DBGrid.CreateColumnEx(AColumnClass, ColumnOwner);
      FillLists;
      Selected[Items.Count - 1] := True;
      ItemIndex := Items.Count - 1;
      CListBox.SetFocus;
    finally
      Items.EndUpdate;
    end;
    CListBoxClick(nil);
    UpdateDesigner;
  end;
end;

procedure TFdxDBGridEditor.BDeleteClick(Sender: TObject);
var
  I, OldIndex: Integer;
  List: TList;
begin
  if (DBGrid <> nil) and (CListbox.SelCount > 0) then
  with CListbox do
  Begin
    OldIndex := ItemIndex;
    List := TList.Create;
    try
      LoadSelectedItems(List, 1{Columns});
      Items.BeginUpdate;
      try
        UnSelectAll;
        SelectItem;
        with DBGrid do
        begin
          BeginUpdate;
          BeginGrouping;
          try
            for I := 0 to List.Count - 1 do
              TdxTreeListColumn(List[I]).Free;
          finally
            EndGrouping;
            EndUpdate;
          end;
        end;  
        FillLists;
        if OldIndex >= Items.Count then
          OldIndex := Items.Count - 1;
        if (OldIndex <> -1) and (Items.Count > 0) then
          Selected[OldIndex] := True;
        CListBox.SetFocus;
      finally
        Items.EndUpdate;
      end;
      CListBoxClick(nil);
      UpdateDesigner;
    finally
      List.Free;
    end;
  End;
end;

procedure TFdxDBGridEditor.BChangeClick(Sender: TObject);
var
  AColumnClass: TdxDBTreeListColumnClass;
  NewColumn, OldColumn: TdxDBTreeListColumn;
  P: TPoint;
  I, OldIndex : Integer;
  OldName: string;
  List: TList;
begin
  if (DBGrid = nil) or (CListBox.SelCount <= 0) then Exit;
  P := Point(BAdd.Left + BAdd.Width, BChange.Top);
  P := ClientToScreen(P);
  OldName := '';
  for I := 0 to CListBox.Items.Count - 1 do
    if CListBox.Selected[I] then
    begin
      OldName := TdxDBTreeListColumn(CListBox.Items.Objects[I]).ClassName;
      Break;
    end;
  AColumnClass := TdxDBTreeListColumnClass(SelectdxTreeListColumn(P.X, P.Y, OldName, ADBGroupListColumns));
  if (AColumnClass <> nil) and (AColumnClass.ClassName <> OldName) then
  with CListbox do
  begin
    OldIndex := ItemIndex;
    List := TList.Create;
    try
      LoadSelectedItems(List, 1{Columns});
      Items.BeginUpdate;
      try
        UnSelectAll;
        SelectItem;
        DBGrid.BeginUpdate;
        DBGrid.BeginGrouping;
        try
          for I := 0 to List.Count - 1 do
          begin
            OldColumn := TdxDBTreeListColumn(List[I]);
            NewColumn := DBGrid.CreateColumnEx(AColumnClass, ColumnOwner);
            NewColumn.Index := OldColumn.Index;
            NewColumn.Assign(OldColumn);
            OldName := OldColumn.Name;
            OldColumn.Free;
            NewColumn.Name := OldName;
          end;
        finally
          DBGrid.EndGrouping;
          DBGrid.EndUpdate;
        end;
        FillLists;
        if OldIndex >= Items.Count then
          OldIndex := Items.Count - 1;
        if (OldIndex <> -1) and (Items.Count > 0) then
          Selected[OldIndex] := True;
        CListBox.SetFocus;
      finally
        Items.EndUpdate;
      end;
      CListBoxClick(nil);
      UpdateDesigner;
    finally
      List.Free;
    end;
  end;
end;

procedure TFdxDBGridEditor.BUpClick(Sender: TObject);
var
  I, OldIndex: Integer;
begin
  if DBGrid <> nil then
  with CListBox do
  begin
    Items.BeginUpdate;
    try
      OldIndex := 0;
      for I := 0 to Items.Count - 1 do
        if Selected[I] then
        Begin
          TdxTreeListColumn(Items.Objects[I]).Index:=
            TdxTreeListColumn(Items.Objects[I]).Index - 1;
          OldIndex := I - 1;
        End;
      FillLists;
      if OldIndex < 0 then OldIndex := 0;
      if OldIndex >= Items.Count then
        OldIndex := Items.Count - 1;
      if (OldIndex <> -1) and (Items.Count > 0) then
        Selected[OldIndex] := True;
    finally
      Items.EndUpdate;
    end;
    CListBoxClick(nil);
    // modi
    UpdateDesigner;
  end;
end;

procedure TFdxDBGridEditor.BDownClick(Sender: TObject);
var
  I, OldIndex: Integer;
begin
  if DBGrid <> nil then
  with CListBox do
  begin
    Items.BeginUpdate;
    try
      OldIndex := 0;
      for I := 0 to Items.Count - 1 do
        if Selected[I] then
        begin
          TdxTreeListColumn(Items.Objects[I]).Index:=
            TdxTreeListColumn(Items.Objects[I]).Index + 1;
          OldIndex := I + 1;
        end;
      FillLists;
      if OldIndex < 0 then OldIndex := 0;
      if OldIndex >= Items.Count then
        OldIndex := Items.Count - 1;
      if (OldIndex <> -1) and (Items.Count > 0) then
        Selected[OldIndex] := True;
    finally
      Items.EndUpdate;
    end;
    CListBoxClick(nil);
    // modi
    UpdateDesigner;
  end;
end;

procedure TFdxDBGridEditor.BWizardClick(Sender: TObject);
begin
  if DBGrid <> nil then
  with DBGrid do
  begin
    if not (Assigned(DataSource) and Assigned(DataSource.DataSet)) then Exit;
    if ShowdxDBFieldsEditor(DBGrid, ColumnOwner) then
      FillLists;
    CListBox.SetFocus;
    CListBoxClick(nil);
    // modi
    UpdateDesigner;
  end;
end;

procedure TFdxDBGridEditor.BRestoreClick(Sender: TObject);
begin
  if DBGrid <> nil then
  begin
    DBGrid.RestoreColumnsDefaults;
    FillLists;
    // modi
    UpdateDesigner;
  end;
end;

procedure TFdxDBGridEditor.BRestoreWidthsClick(Sender: TObject);
var
  I: Integer;
begin
  // Restore Default Widths
  if DBGrid <> nil then
  with DBGrid do
  Begin
    BeginUpdate;
    try
      for I := 0 to ColumnCount - 1 do
        Columns[I].RestoreDefaultWidth;
    finally
      EndUpdate;
    end;
    FillLists;
    // modi
    UpdateDesigner;
  End;
end;

procedure TFdxDBGridEditor.miSelectAllClick(Sender: TObject);
var
  I: Integer;
begin
  with CListBox do
  begin
    for I := 0 to Items.Count - 1 do
      Selected[I] := True;
    CListBox.SetFocus;
    CListBoxClick(nil);
  end;
end;

// Summary
procedure TFdxDBGridEditor.FormResize(Sender: TObject);
var
  D, W: Integer;
begin
  D := (pnGroups.Width - pnItems.Width) div 2;
  if Abs(D) > 1 then
  begin
    W := pnGroups.Width - D;
    if W < 177 then W := 177;
    pnGroups.Width := W;
  end;
end;

procedure TFdxDBGridEditor.LGroupsClick(Sender: TObject);
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
    with LGroups do
    begin
      if SelCount > 0 then
        for I := 0 to Items.Count - 1 do
          if Selected[I] then
            List.Add({$IFNDEF DELPHI3}TComponent{$ELSE}TPersistent{$ENDIF}(Items.Objects[I]));
      {$IFDEF DELPHI6}
        if List.Count > 0 then
          IDesigner(PDesigner).SetSelections(List)
        else
          IDesigner(PDesigner).SelectComponent(DBGrid);
      {$ELSE}
        if List.Count > 0 then
          {$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}(PDesigner).SetSelections(List)
        else
          {$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}(PDesigner).SelectComponent(DBGrid);
      {$ENDIF}
    end;
  finally
    {$IFNDEF DELPHI6}
    List.Free;
    {$ENDIF}
  end;
  with LGroups do
  begin
    BDeleteGroup.Enabled := SelCount > 0;
    miDeleteGroup.Enabled := BDeleteGroup.Enabled;
  end;
  // Select SummaryItems
  FillSummaryItems;
  with LItems do
  begin
    BAddItem.Enabled := LGroups.SelCount > 0;
    miAddItem.Enabled := BAddItem.Enabled;
    BDeleteItem.Enabled := SelCount > 0;
    miDeleteItem.Enabled := BDeleteItem.Enabled;
  end;
end;

procedure TFdxDBGridEditor.miSellectGroupClick(Sender: TObject);
var
  I: Integer;
begin
  with LGroups do
  begin
    for I := 0 to Items.Count - 1 do
      Selected[I] := True;
    LGroups.SetFocus;
    LGroupsClick(nil);
  end;
end;

procedure TFdxDBGridEditor.LGroupsEndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if (0 <= FOldDragIndex) and (FOldDragIndex < LGroups.Items.Count) then
  begin
    LGroups.Selected[FOldDragIndex] := False;
    FOldDragIndex := -1;
  end;
end;

procedure TFdxDBGridEditor.LGroupsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  ListBoxDragOver(LGroups, Sender, Source, X, Y, State, Accept);
end;

procedure TFdxDBGridEditor.LGroupsDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  I, Index, OldIndex: Integer;
begin
  with LGroups do
  begin
    if (0 <= FOldDragIndex) and (FOldDragIndex < Items.Count) then
    begin
      Selected[FOldDragIndex] := False;
      FOldDragIndex := -1;
    end;
    Index := ItemAtPos(Point(X, Y), True);
    OldIndex := ItemIndex;
    if (Index <> -1) and (DBGrid <> nil) then
    begin
      for I := Items.Count - 1 downto 0 do
      begin
        if Selected[I] then
          TCollectionItem(Items.Objects[I]).Index:= Index;
      end;
      FillLists;
      if OldIndex < 0 then OldIndex := 0;
      if OldIndex >= Items.Count then
        OldIndex := Items.Count - 1;
      if (OldIndex <> -1) and (Items.Count > 0) then
        Selected[OldIndex] := True;
      LGroupsClick(nil);
      UpdateDesigner;
    end;
  end;
end;

procedure TFdxDBGridEditor.BAddGroupClick(Sender: TObject);
begin
  if DBGrid <> nil then
  with LGroups do
  begin
    Items.BeginUpdate;
    try
      DBGrid.SummaryGroups.Add;
      FillLists;
      Selected[Items.Count - 1] := True;
      ItemIndex := Items.Count - 1;
      LGroups.SetFocus;
    finally
      Items.EndUpdate;
    end;
    LGroupsClick(nil);
    UpdateDesigner;
  end;
end;


procedure TFdxDBGridEditor.BDeleteGroupClick(Sender: TObject);
var
  I, OldIndex: Integer;
  List: TList;
begin
  if (DBGrid <> nil) and (LGroups.SelCount > 0) then
  with LGroups do
  Begin
    OldIndex := ItemIndex;
    List := TList.Create;
    try
      LoadSelectedItems(List, 2{Groups});
      Items.BeginUpdate;
      try
        UnSelectAll;
        SelectItem;
        for I := 0 to List.Count - 1 do
          TCollectionItem(List[I]).Free;
        FillLists;
        if OldIndex >= Items.Count then
          OldIndex := Items.Count - 1;
        if (OldIndex <> -1) and (Items.Count > 0) then
          Selected[OldIndex] := True;
        LGroups.SetFocus;
      finally
        Items.EndUpdate;
      end;
      LGroupsClick(nil);
      UpdateDesigner;
    finally
      List.Free;
    end;
  End;
end;

// Summary: Items

procedure TFdxDBGridEditor.FillSummaryItems;
var
  I, J: Integer;
  SummaryGroup: TdxDBGridSummaryGroup;
begin
  with LItems do
  begin
    Items.BeginUpdate;
    try
      Clear;
      for I := 0 to LGroups.Items.Count - 1 do
      begin
        if LGroups.Selected[I] then // select items
        begin
          SummaryGroup := TdxDBGridSummaryGroup(LGroups.Items.Objects[I]);
          for J := 0 to SummaryGroup.SummaryItems.Count - 1 do
            Items.AddObject('['+IntToStr(I)+']['+ IntTostr(J)+ '] - ' + SummaryGroup.SummaryItems[J].DisplayName,
              SummaryGroup.SummaryItems[J]);
        end;
      end;
    finally
      Items.EndUpdate;
    end;
  end;
end;

procedure TFdxDBGridEditor.LItemsClick(Sender: TObject);
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
      {$IFDEF DELPHI6}
        if List.Count > 0 then
          IDesigner(PDesigner).SetSelections(List)
        else
          IDesigner(PDesigner).SelectComponent(DBGrid);
      {$ELSE}
        if List.Count > 0 then
          {$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}(PDesigner).SetSelections(List)
        else
          {$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}(PDesigner).SelectComponent(DBGrid);
      {$ENDIF}
    end;
  finally
    {$IFNDEF DELPHI6}
    List.Free;
    {$ENDIF}
  end;
  with LItems do
  begin
    BDeleteItem.Enabled := SelCount > 0;
    miDeleteItem.Enabled := BDeleteItem.Enabled;
  end;
end;

procedure TFdxDBGridEditor.LItemsEndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if (0 <= FOldDragIndex) and (FOldDragIndex < LItems.Items.Count) then
  begin
    LItems.Selected[FOldDragIndex] := False;
    FOldDragIndex := -1;
  end;
end;

procedure TFdxDBGridEditor.LItemsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  ListBoxDragOver(LItems, Sender, Source, X, Y, State, Accept);
end;

procedure TFdxDBGridEditor.LItemsDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  I, Index, OldIndex: Integer;
begin
  with LItems do
  begin
    if (0 <= FOldDragIndex) and (FOldDragIndex < Items.Count) then
    begin
      Selected[FOldDragIndex] := False;
      FOldDragIndex := -1;
    end;
    Index := ItemAtPos(Point(X, Y), True);
    OldIndex := ItemIndex;
    if (Index <> -1) and (DBGrid <> nil) then
    begin
      for I := Items.Count - 1 downto 0 do
      begin
        if Selected[I] then
          TCollectionItem(Items.Objects[I]).Index:= Index;
      end;
      FillSummaryItems;
      if OldIndex < 0 then OldIndex := 0;
      if OldIndex >= Items.Count then
        OldIndex := Items.Count - 1;
      if (OldIndex <> -1) and (Items.Count > 0) then
        Selected[OldIndex] := True;
      LItemsClick(nil);
      UpdateDesigner;
    end;
  end;
end;

procedure TFdxDBGridEditor.BAddItemClick(Sender: TObject);
var
  SummaryGroup: TdxDBGridSummaryGroup;
  I: Integer;
begin
  if DBGrid <> nil then
  with LItems do
  begin
    Items.BeginUpdate;
    try
      SummaryGroup := nil;
      for I := 0 to LGroups.Items.Count - 1 do
      begin
        if LGroups.Selected[I] then // select items
        begin
          SummaryGroup := TdxDBGridSummaryGroup(LGroups.Items.Objects[I]);
          Break;
        end;
      end;
      if SummaryGroup <> nil then
      begin
        SummaryGroup.SummaryItems.Add;
        FillSummaryItems;
        Selected[Items.Count - 1] := True;
        ItemIndex := Items.Count - 1;
        LItems.SetFocus;
      end;
    finally
      Items.EndUpdate;
    end;
    LItemsClick(nil);
    UpdateDesigner;
  end;
end;

procedure TFdxDBGridEditor.BDeleteItemClick(Sender: TObject);
var
  I, OldIndex: Integer;
  List: TList;
begin
  if (DBGrid <> nil) and (LItems.SelCount > 0) then
  with LItems do
  Begin
    OldIndex := ItemIndex;
    List := TList.Create;
    try
      LoadSelectedItems(List, 3{Items});
      Items.BeginUpdate;
      try
//        UnSelectAll;
//        SelectItem;
        for I := 0 to List.Count - 1 do
          TCollectionItem(List[I]).Free;
        FillSummaryItems;
        if OldIndex >= Items.Count then
          OldIndex := Items.Count - 1;
        if (OldIndex <> -1) and (Items.Count > 0) then
          Selected[OldIndex] := True;
        LItems.SetFocus;
      finally
        Items.EndUpdate;
      end;
      LItemsClick(nil);
      UpdateDesigner;
    finally
      List.Free;
    end;
  End;
end;

procedure TFdxDBGridEditor.miSelectItemsClick(Sender: TObject);
var
  I: Integer;
begin
  with LItems do
  begin
    for I := 0 to Items.Count - 1 do
      Selected[I] := True;
    LItems.SetFocus;
    LItemsClick(nil);
  end;
end;

// Bands

procedure TFdxDBGridEditor.BAddBandClick(Sender: TObject);
begin
  if DBGrid <> nil then
  with LBands do
  begin
    Items.BeginUpdate;
    try
      DBGrid.Bands.Add;
      FillLists;
      Selected[Items.Count - 1] := True;
      ItemIndex := Items.Count - 1;
      LBands.SetFocus;
    finally
      Items.EndUpdate;
    end;
    LBandsClick(nil);
    UpdateDesigner;
  end;
end;

procedure TFdxDBGridEditor.BDeleteBandClick(Sender: TObject);
var
  I, OldIndex: Integer;
  List: TList;
begin
  if (DBGrid <> nil) and (LBands.SelCount > 0) then
  with LBands do
  Begin
    OldIndex := ItemIndex;
    List := TList.Create;
    try
      LoadSelectedItems(List, 0{Groups});
      Items.BeginUpdate;
      try
        UnSelectAll;
        SelectItem;
        for I := 0 to List.Count - 1 do
          TCollectionItem(List[I]).Free;
        FillLists;
        if OldIndex >= Items.Count then
          OldIndex := Items.Count - 1;
        if (OldIndex <> -1) and (Items.Count > 0) then
          Selected[OldIndex] := True;
        LBands.SetFocus;
      finally
        Items.EndUpdate;
      end;
      LBandsClick(nil);
      UpdateDesigner;
    finally
      List.Free;
    end;
  End;
end;

procedure TFdxDBGridEditor.BUpBandClick(Sender: TObject);
var
  I, OldIndex: Integer;
begin
  if DBGrid <> nil then
  with LBands do
  begin
    Items.BeginUpdate;
    try
      OldIndex := 0;
      for I := 0 to Items.Count - 1 do
        if Selected[I] then
        begin
          TCollectionItem(Items.Objects[I]).Index:=
            TCollectionItem(Items.Objects[I]).Index - 1;
          OldIndex := I - 1;
        end;
      FillLists;
      if OldIndex < 0 then OldIndex := 0;
      if OldIndex >= Items.Count then
        OldIndex := Items.Count - 1;
      if (OldIndex <> -1) and (Items.Count > 0) then
        Selected[OldIndex] := True;
    finally
      Items.EndUpdate;
    end;
    LBandsClick(nil);
    // modi
    UpdateDesigner;
  end;
end;

procedure TFdxDBGridEditor.BDownBandClick(Sender: TObject);
var
  I, OldIndex: Integer;
begin
  if DBGrid <> nil then
  with LBands do
  begin
    Items.BeginUpdate;
    try
      OldIndex := 0;
      for I := 0 to Items.Count - 1 do
        if Selected[I] then
        begin
          TCollectionItem(Items.Objects[I]).Index:=
            TCollectionItem(Items.Objects[I]).Index + 1;
          OldIndex := I + 1;
        end;
      FillLists;
      if OldIndex < 0 then OldIndex := 0;
      if OldIndex >= Items.Count then
        OldIndex := Items.Count - 1;
      if (OldIndex <> -1) and (Items.Count > 0) then
        Selected[OldIndex] := True;
    finally
      Items.EndUpdate;
    end;
    LBandsClick(nil);
    // modi
    UpdateDesigner;
  end;
end;

procedure TFdxDBGridEditor.BRestoreDefaultClick(Sender: TObject);
begin
  if DBGrid <> nil then
  begin
    DBGrid.Bands.RestoreDefaults;
    FillLists;
    // modi
    UpdateDesigner;
  end;
end;

procedure TFdxDBGridEditor.miAllBandsClick(Sender: TObject);
var
  I: Integer;
begin
  with LBands do
  begin
    for I := 0 to Items.Count - 1 do
      Selected[I] := True;
    LBands.SetFocus;
    LBandsClick(nil);
  end;
end;

procedure TFdxDBGridEditor.LBandsClick(Sender: TObject);
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
    with LBands do
    begin
      if SelCount > 0 then
        for I := 0 to Items.Count - 1 do
          if Selected[I] then
            List.Add({$IFNDEF DELPHI3}TComponent{$ELSE}TPersistent{$ENDIF}(Items.Objects[I]));
      {$IFDEF DELPHI6}
        if List.Count > 0 then
          IDesigner(PDesigner).SetSelections(List)
        else
          IDesigner(PDesigner).SelectComponent(DBGrid);
      {$ELSE}
        if List.Count > 0 then
          {$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}(PDesigner).SetSelections(List)
        else
          {$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}(PDesigner).SelectComponent(DBGrid);
      {$ENDIF}
    end;
  finally
    {$IFNDEF DELPHI6}
    List.Free;
    {$ENDIF}
  end;
  with LBands do
  begin
    BDeleteBand.Enabled := SelCount > 0;
    BUpBand.Enabled := BDeleteBand.Enabled;
    BDownBand.Enabled := BDeleteBand.Enabled;
    BRestoreDefault.Enabled := Items.Count > 0;
    {PopupMenu}
    miDeleteBand.Enabled := BDeleteBand.Enabled;
    miUpBand.Enabled := BDeleteBand.Enabled;
    miDownBand.Enabled := BDeleteBand.Enabled;
    miRestoreBands.Enabled := BRestoreDefault.Enabled;
  end;
end;

procedure TFdxDBGridEditor.LBandsDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  I, Index, OldIndex: Integer;
begin
  with LBands do
  begin
    if (0 <= FOldDragIndex) and (FOldDragIndex < Items.Count) then
    begin
      Selected[FOldDragIndex] := False;
      FOldDragIndex := -1;
    end;
    Index := ItemAtPos(Point(X, Y), True);
    OldIndex := ItemIndex;
    if (Index <> -1) and (DBGrid <> nil) then
    begin
      for I := Items.Count - 1 downto 0 do
      begin
        if Selected[I] then
          TCollectionItem(Items.Objects[I]).Index:= Index;
      end;
      FillLists;
      if OldIndex < 0 then OldIndex := 0;
      if OldIndex >= Items.Count then
        OldIndex := Items.Count - 1;
      if (OldIndex <> -1) and (Items.Count > 0) then
        Selected[OldIndex] := True;
      LBandsClick(nil);
      UpdateDesigner;
    end;
  end;
end;

procedure TFdxDBGridEditor.LBandsEndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if (0 <= FOldDragIndex) and (FOldDragIndex < LBands.Items.Count) then
  begin
    LBands.Selected[FOldDragIndex] := False;
    FOldDragIndex := -1;
  end;
end;

procedure TFdxDBGridEditor.LBandsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  ListBoxDragOver(LBands, Sender, Source, X, Y, State, Accept);
end;

procedure TFdxDBGridEditor.PageControlChange(Sender: TObject);
begin
  SelectItem;
end;

end.
