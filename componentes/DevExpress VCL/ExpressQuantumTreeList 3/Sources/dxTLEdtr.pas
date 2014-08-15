
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressQuantumTreeList editor                               }
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

unit dxTLEdtr;

interface

{$I dxTLVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, ExtCtrls, dxTL, ComCtrls, Buttons{$IFNDEF DELPHI6},
  DsgnWnds, DsgnIntf{$ELSE}, DesignWindows, DesignIntf{$ENDIF};

type
  {TFdxTreeListEditor}
  TFdxTreeListEditor = class(TDesignWindow)
    Panel4: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel1: TPanel;
    PageControl: TPageControl;
    tsColumns: TTabSheet;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel8: TPanel;
    pnButtons: TPanel;
    BAdd: TButton;
    BDelete: TButton;
    BUp: TButton;
    BDown: TButton;
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
    miRestore: TMenuItem;
    miRestoreDefaultWidths: TMenuItem;
    miSelectAll: TMenuItem;
    tsBands: TTabSheet;
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
    procedure BRestoreClick(Sender: TObject);
    procedure BRestoreWidthsClick(Sender: TObject);
    procedure miSelectAllClick(Sender: TObject);
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
    TreeListControl: TdxTreeList;
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
    procedure ListBoxDragOver(ListBox: TListBox; Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure LoadSelectedItems(List: TList; Id: Integer);
    procedure SelectItem;
    procedure UnSelectAll;
  end;

procedure ShowdxTreeListControlEditor(ATreeListControl: TdxTreeList; ADesigner: Pointer;
  Id: Integer{0-Bands, 1-Columns}; AColumnOwner: TComponent);

implementation

{$R *.DFM}

uses dxGrColA, dxTLReg;

const
  MinClientWidth  = 375;
  MinClientHeight = 305 - 29;

type
{TdxTreeListControlDesigner}
TdxTreeListControlDesigner = class(TdxTreeListDesigner)
private
  FDestroying: Boolean;
  FDesignerForm: TFdxTreeListEditor;
public
  destructor Destroy; override;
  procedure LayoutChanged; override;
  property DesignerForm: TFdxTreeListEditor read FDesignerForm;
end;

procedure ShowdxTreeListControlEditor(ATreeListControl: TdxTreeList; ADesigner: Pointer;
  Id: Integer; AColumnOwner: TComponent);
var
  AForm: TFdxTreeListEditor;
begin
  if ATreeListControl.Designer <> nil then
  begin
    with TdxTreeListControlDesigner(ATreeListControl.Designer).DesignerForm do
    begin
      case Id of
      0: PageControl.ActivePage := tsBands;
      1: PageControl.ActivePage := tsColumns;
      end;
      ColumnOwner := AColumnOwner;
      Show;
    end;
    Exit;
  end;
  AForm := TFdxTreeListEditor.Create(nil);
  AForm.TreeListControl := ATreeListControl;
  TdxTreeListControlDesigner.Create(ATreeListControl).FDesignerForm := AForm;
  with AForm do
  begin
    {$IFDEF DELPHI6}
    Designer := IDesigner(ADesigner);
    {$ENDIF}
    ColumnOwner := AColumnOwner;
    PDesigner := ADesigner;
    FillLists;
    Caption := 'Editing '+ATreeListControl.Name;
    case Id of
      0: PageControl.ActivePage := tsBands;
      1: PageControl.ActivePage := tsColumns;
    end;
    Show;
  end;
end;

{TdxTreeListControlDesigner}
destructor TdxTreeListControlDesigner.Destroy;
begin
  FDestroying := True;
  if FDesignerForm <> nil then
  with FDesignerForm do
  begin
    if not (csDestroying in ComponentState) then Release;
    if Assigned(TreeListControl) and (csDestroying in TreeListControl.ComponentState) then
      TreeListControl := nil;
  end;
  inherited Destroy;
end;

procedure TdxTreeListControlDesigner.LayoutChanged;
begin
  if FDesignerForm <> nil then
  begin
    FDesignerForm.FillLists;
    FDesignerForm.Caption := 'Editing '+FDesignerForm.TreeListControl.Name;
  end;
end;

{TTFdxTreeListEditor}
// protected TTFdxTreeListEditor
procedure TFdxTreeListEditor.Activated;
begin
  SelectItem;
end;

function TFdxTreeListEditor.ObjectInList(ASelection: {$IFDEF DELPHI6} IDesignerSelections {$ELSE}
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

function TFdxTreeListEditor.SelectItems(ASelection: {$IFDEF DELPHI6} IDesignerSelections {$ELSE}
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
end;

function TFdxTreeListEditor.UniqueName(Component: TComponent): string;
begin
end;

procedure TFdxTreeListEditor.Notification(AComponent: TComponent; Operation: TOperation);
var
  I: Integer;
begin
  inherited Notification(AComponent, Operation);
  if csDestroying in ComponentState then Exit;
  if TreeListControl <> nil then
    if csDestroying in TreeListControl.ComponentState then Exit;
  if Operation = opRemove then
  with CListbox do
  begin
    for I := 0 to Items.Count - 1 do
      if (TdxTreeListColumn(Items.Objects[I]) = TdxTreeListColumn(AComponent)) then
    begin
      Items.Delete(I);
      UnselectAll;
      if (PDesigner <> nil) and (TreeListControl <> nil) then
        {$IFDEF DELPHI6}
          IDesigner(PDesigner).SelectComponent(nil);
        {$ELSE}
          {$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}(PDesigner).SelectComponent(nil);
        {$ENDIF}
      Break;
    end;
  end;
end;

// private TTFdxTreeListEditor
procedure TFdxTreeListEditor.ColumnChangeName(Sender: TObject);
var
  I: Integer;
begin
  if TreeListControl <> nil then
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
      end;
    end;
  end;
end;

procedure TFdxTreeListEditor.UpdateDesigner;
begin
  if PDesigner <> nil then
    {$IFDEF DELPHI6}
      IDesigner(PDesigner).Modified;
    {$ELSE}
      {$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}(PDesigner).Modified;
    {$ENDIF}
end;

procedure TFdxTreeListEditor.WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo);
begin
  Message.MinMaxInfo^.ptMinTrackSize := Point(MinClientWidth, MinClientHeight);
  inherited;
end;

procedure TFdxTreeListEditor.FormCreate(Sender: TObject);
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
  miRestore.Caption := BRestore.Caption;
  miRestoreDefaultWidths.Caption := BRestoreWidths.Caption;
end;

procedure TFdxTreeListEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

destructor TFdxTreeListEditor.Destroy;
var
  I: Integer;
begin
  Destroying;
  if (TreeListControl <> nil) and not (csDestroying in TreeListControl.ComponentState) then
  begin
    if (GetParentForm(TreeListControl) <> nil) and (GetParentForm(TreeListControl).Designer <> nil) then
    begin
      if Active then
        {$IFDEF DELPHI6}
          IDesigner(PDesigner).SelectComponent(nil);
        {$ELSE}
          {$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}(PDesigner).SelectComponent(nil);
        {$ENDIF}
      if Assigned(TreeListControl) and not (csDestroying in TreeListControl.ComponentState) then
      begin
        if (TreeListControl.Designer <> nil) and not (TdxTreeListControlDesigner(TreeListControl.Designer).FDestroying) then
        begin
          TdxTreeListControlDesigner(TreeListControl.Designer).FDesignerForm := nil;
          TreeListControl.Designer.Free;
        end;
        for I := 0 to TreeListControl.ColumnCount - 1 do
          TreeListControl.Columns[I].OnChangeName := nil;
      end;
    end;
  end;
  inherited Destroy;
end;

{$IFDEF DELPHI6}

procedure TFdxTreeListEditor.DesignerClosed(const Designer: IDesigner; AGoingDormant: Boolean);
begin
  if Designer = Self.Designer then
  begin
    FClosed := True;
    PDesigner := nil;
//    Release;
  end;
end;

procedure TFdxTreeListEditor.SelectionChanged(const ADesigner: IDesigner; const ASelection: IDesignerSelections);
begin
  if FClosed or (ADesigner <> Self.Designer) then Exit;
  if not Active and SelectItems(ASelection, True) then
  begin
    UnSelectAll;
    SelectItems(ASelection, False);
  end;
end;

{$ELSE}

procedure TFdxTreeListEditor.FormClosed(AForm: TCustomForm);
begin
  if Assigned(AForm) and (Pointer(AForm.Designer) = PDesigner) then
  begin
    FClosed := True;
    PDesigner := nil;
//    Release;
  end;
end;

procedure TFdxTreeListEditor.SelectionChanged(ASelection: {$IFDEF DELPHI5}TDesignerSelectionList{$ELSE}TComponentList{$ENDIF});
begin
  if FClosed then Exit;
  if not Active and SelectItems(ASelection, True) then
  begin
    UnSelectAll;
    SelectItems(ASelection, False);
  end;
end;

{$ENDIF}

procedure TFdxTreeListEditor.FillLists;
var
  I: Integer;
begin
  // Bands
  with LBands do
  begin
    Items.BeginUpdate;
    Items.Clear;
    for I := 0 to TreeListControl.Bands.Count - 1 do
      Items.AddObject(IntToStr(I) + ' - ' + TreeListControl.Bands[I].ClassName,
        TreeListControl.Bands[I]);
    Items.EndUpdate;
  end;
  // Columns
  with CListBox do
  begin
    Items.BeginUpdate;
    Items.Clear;
    for I := 0 to TreeListControl.ColumnCount - 1 do
    begin
      Items.AddObject(TreeListControl.Columns[I].Name, TreeListControl.Columns[I]);
      TreeListControl.Columns[I].OnChangeName := Self.ColumnChangeName;
      TreeListControl.Columns[I].FreeNotification(Self);
    end;
    Items.EndUpdate;
  end;
  // select component
  SelectItem;
end;

procedure TFdxTreeListEditor.LoadSelectedItems(List: TList; Id: Integer);
var
  I: Integer;
begin
  // TODO collection
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
  end;
end;

procedure TFdxTreeListEditor.SelectItem;
begin
  case PageControl.ActivePage.TabIndex of
  0: LBandsClick(nil);
  1: CListBoxClick(nil);
  else
    CListBoxClick(nil);
  end;
end;

procedure TFdxTreeListEditor.UnSelectAll;
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
end;

// CListBox - Columns
procedure TFdxTreeListEditor.CListBoxClick(Sender: TObject);
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
          IDesigner(PDesigner).SelectComponent(TreeListControl);
      {$ELSE}
        if List.Count > 0 then
          {$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}(PDesigner).SetSelections(List)
        else
          {$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}(PDesigner).SelectComponent(TreeListControl);
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
    {PopupMenu}
    miDelete.Enabled := BDelete.Enabled;
    miChangetype.Enabled := BChange.Enabled;
    miUp.Enabled := BUp.Enabled;
    miDown.Enabled := BDown.Enabled;
    miRestore.Enabled := BRestore.Enabled;
    miRestoreDefaultWidths.Enabled := BRestoreWidths.Enabled;
  end;
end;

procedure TFdxTreeListEditor.CListBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then ActivateInspector(#0);
end;

// drag drop
procedure TFdxTreeListEditor.CListBoxStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  FOldDragIndex := -1;
end;

procedure TFdxTreeListEditor.CListBoxEndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if (0 <= FOldDragIndex) and (FOldDragIndex < CListBox.Items.Count) then
  begin
    CListBox.Selected[FOldDragIndex] := False;
    FOldDragIndex := -1;
  end;
end;

procedure TFdxTreeListEditor.ListBoxDragOver(ListBox: TListBox;
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

procedure TFdxTreeListEditor.CListBoxDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  ListBoxDragOver(CListBox, Sender, Source, X, Y, State, Accept);
end;

procedure TFdxTreeListEditor.CListBoxDragDrop(Sender, Source: TObject; X,
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
    if (Index <> -1) and (TreeListControl <> nil) then
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
procedure TFdxTreeListEditor.BAddClick(Sender: TObject);
var
  AColumnClass: TdxTreeListColumnClass;
  P: TPoint;
begin
  P := Point(BAdd.Left + BAdd.Width, BAdd.Top);
  P := ClientToScreen(P);
  AColumnClass := SelectdxTreeListColumn(P.X, P.Y, '', ATreeListColumns);
  if AColumnClass <> nil then
  if TreeListControl <> nil then
  with CListBox do
  begin
    Items.BeginUpdate;
    try
      TreeListControl.CreateColumnEx(AColumnClass, ColumnOwner);
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

procedure TFdxTreeListEditor.BDeleteClick(Sender: TObject);
var
  I, OldIndex: Integer;
  List: TList;
begin
  if (TreeListControl <> nil) and (CListbox.SelCount > 0) then
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
        with TreeListControl do
        begin
          BeginUpdate;
          try
            for I := 0 to List.Count - 1 do
              TdxTreeListColumn(List[I]).Free;
          finally
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

procedure TFdxTreeListEditor.BChangeClick(Sender: TObject);
var
  AColumnClass: TdxTreeListColumnClass;
  NewColumn, OldColumn: TdxTreeListColumn;
  P: TPoint;
  I, OldIndex : Integer;
  OldName: string;
  List: TList;
begin
  if (TreeListControl = nil) or (CListBox.SelCount <= 0) then Exit;
  P := Point(BAdd.Left + BAdd.Width, BChange.Top);
  P := ClientToScreen(P);
  OldName := '';
  for I := 0 to CListBox.Items.Count - 1 do
    if CListBox.Selected[I] then
    begin
      OldName := TdxTreeListColumn(CListBox.Items.Objects[I]).ClassName;
      Break;
    end;
  AColumnClass := SelectdxTreeListColumn(P.X, P.Y, OldName, ATreeListColumns);
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
        TreeListControl.BeginUpdate;
        try
          for I := 0 to List.Count - 1 do
          begin
            OldColumn := TdxTreeListColumn(List[I]);
            NewColumn := TreeListControl.CreateColumnEx(AColumnClass, ColumnOwner);
            NewColumn.Index := OldColumn.Index;
            NewColumn.Assign(OldColumn);
            OldName := OldColumn.Name;
            OldColumn.Free;
            NewColumn.Name := OldName;
          end;
        finally
          TreeListControl.EndUpdate;
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

procedure TFdxTreeListEditor.BUpClick(Sender: TObject);
var
  I, OldIndex: Integer;
begin
  if TreeListControl <> nil then
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

procedure TFdxTreeListEditor.BDownClick(Sender: TObject);
var
  I, OldIndex: Integer;
begin
  if TreeListControl <> nil then
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

procedure TFdxTreeListEditor.BRestoreClick(Sender: TObject);
begin
  if TreeListControl <> nil then
  begin
    TreeListControl.RestoreColumnsDefaults;
    FillLists;
    // modi
    UpdateDesigner;
  end;
end;

procedure TFdxTreeListEditor.BRestoreWidthsClick(Sender: TObject);
var
  I: Integer;
begin
  // Restore Default Widths
  if TreeListControl <> nil then
  with TreeListControl do
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

procedure TFdxTreeListEditor.miSelectAllClick(Sender: TObject);
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

// Bands
procedure TFdxTreeListEditor.BAddBandClick(Sender: TObject);
begin
  if TreeListControl <> nil then
  with LBands do
  begin
    Items.BeginUpdate;
    try
      TreeListControl.Bands.Add;
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

procedure TFdxTreeListEditor.BDeleteBandClick(Sender: TObject);
var
  I, OldIndex: Integer;
  List: TList;
begin
  if (TreeListControl <> nil) and (LBands.SelCount > 0) then
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

procedure TFdxTreeListEditor.BUpBandClick(Sender: TObject);
var
  I, OldIndex: Integer;
begin
  if TreeListControl <> nil then
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

procedure TFdxTreeListEditor.BDownBandClick(Sender: TObject);
var
  I, OldIndex: Integer;
begin
  if TreeListControl <> nil then
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

procedure TFdxTreeListEditor.BRestoreDefaultClick(Sender: TObject);
begin
  if TreeListControl <> nil then
  begin
    TreeListControl.Bands.RestoreDefaults;
    FillLists;
    // modi
    UpdateDesigner;
  end;
end;

procedure TFdxTreeListEditor.miAllBandsClick(Sender: TObject);
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

procedure TFdxTreeListEditor.LBandsClick(Sender: TObject);
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
          IDesigner(PDesigner).SelectComponent(TreeListControl);
      {$ELSE}
        if List.Count > 0 then
          {$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}(PDesigner).SetSelections(List)
        else
          {$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}(PDesigner).SelectComponent(TreeListControl);
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

procedure TFdxTreeListEditor.LBandsDragDrop(Sender, Source: TObject; X, Y: Integer);
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
    if (Index <> -1) and (TreeListControl <> nil) then
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

procedure TFdxTreeListEditor.LBandsEndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if (0 <= FOldDragIndex) and (FOldDragIndex < LBands.Items.Count) then
  begin
    LBands.Selected[FOldDragIndex] := False;
    FOldDragIndex := -1;
  end;
end;

procedure TFdxTreeListEditor.LBandsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  ListBoxDragOver(LBands, Sender, Source, X, Y, State, Accept);
end;

procedure TFdxTreeListEditor.PageControlChange(Sender: TObject);
begin
  SelectItem;
end;

end.
