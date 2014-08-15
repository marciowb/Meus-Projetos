
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressDBTreeListControl editor                             }
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

unit dxDBTLEd;

interface

{$I dxTLVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, ExtCtrls, dxTL, ComCtrls, Buttons,
  dxCntner, dxDBCtrl, dxDBTL{$IFNDEF DELPHI6}, DsgnWnds, LibIntf, DsgnIntf{$ELSE},
  DesignWindows, DesignIntf{$ENDIF};

type
  {TFdxDBTreeListEditor}
  TFdxDBTreeListEditor = class(TDesignWindow)
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
    DBTreeList: TCustomdxDBTreeList;
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

procedure ShowdxDBTreeListEditor(ADBTreeList: TdxDBTreeList; ADesigner: Pointer;
  Id: Integer{0-Bands, 1-Columns}; AColumnOwner: TComponent);

implementation

{$R *.DFM}

uses dxGrColA, dxDTLReg, dxTLFlds;

const
  MinClientWidth  = 375;
  MinClientHeight = 305;

type

{TdxDBTreeListDesigner}
TdxDBTreeListDesigner = class(TdxTreeListDesigner)
private
  FDestroying: Boolean;
  FDesignerForm: TFdxDBTreeListEditor;
public
  destructor Destroy; override;
  procedure LayoutChanged; override;
  property DesignerForm: TFdxDBTreeListEditor read FDesignerForm;
end;

procedure ShowdxDBTreeListEditor(ADBTreeList: TdxDBTreeList; ADesigner: Pointer;
  Id: Integer; AColumnOwner: TComponent);
var
  AForm: TFdxDBTreeListEditor;
begin
  if ADBTreeList.Designer <> nil then
  begin
    with TdxDBTreeListDesigner(ADBTreeList.Designer).DesignerForm do
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
  AForm := TFdxDBTreeListEditor.Create(nil);
  AForm.DBTreeList := ADBTreeList;
  TdxDBTreeListDesigner.Create(ADBTreeList).FDesignerForm := AForm;
  with AForm do
  begin
    // TODO IFormDesigner
    {$IFDEF DELPHI6}
    Designer := IDesigner(ADesigner);
    {$ENDIF}
    ColumnOwner := AColumnOwner;
    PDesigner := ADesigner;
    FillLists;
    Caption := 'Editing '+ADBTreeList.Name;
    case Id of
      0: PageControl.ActivePage := tsBands;
      1: PageControl.ActivePage := tsColumns;
    end;
    Show;
  end;
end;

{TdxDBTreeListDesigner}
destructor TdxDBTreeListDesigner.Destroy;
begin
  FDestroying := True;
  if FDesignerForm <> nil then
  with FDesignerForm do
  begin
    if not (csDestroying in ComponentState) then
    begin
      Release;
    end;
    if Assigned(DBTreeList) and (csDestroying in DBTreeList.ComponentState) then
      DBTreeList := nil;
  end;
  inherited Destroy;
end;

procedure TdxDBTreeListDesigner.LayoutChanged;
begin
  if FDesignerForm <> nil then
  begin
    FDesignerForm.FillLists;
    FDesignerForm.Caption := 'Editing '+FDesignerForm.DBTreeList.Name;
  end;
end;

{TFdxDBTreeListEditor}
// protected TFdxDBTreeListEditor
procedure TFdxDBTreeListEditor.Activated;
begin
  SelectItem;
end;

function TFdxDBTreeListEditor.ObjectInList(ASelection: {$IFDEF DELPHI6} IDesignerSelections {$ELSE}
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

function TFdxDBTreeListEditor.SelectItems(ASelection: {$IFDEF DELPHI6} IDesignerSelections {$ELSE}
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

function TFdxDBTreeListEditor.UniqueName(Component: TComponent): string;
begin
  Result := '';
end;

procedure TFdxDBTreeListEditor.Notification(AComponent: TComponent; Operation: TOperation);
var
  I: Integer;
begin
  inherited Notification(AComponent, Operation);
  if csDestroying in ComponentState then Exit;
  if DBTreeList <> nil then
    if csDestroying in DBTreeList.ComponentState then Exit;
  if Operation = opRemove then
  with CListbox do
  begin
    for I := 0 to Items.Count - 1 do
      if (TdxTreeListColumn(Items.Objects[I]) = TdxTreeListColumn(AComponent)) then
    begin
      Items.Delete(I);
      UnselectAll;
      if (PDesigner <> nil) and (DBTreeList <> nil) then
        {$IFDEF DELPHI6}
          IDesigner(PDesigner).SelectComponent(nil);
        {$ELSE}
          {$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}(PDesigner).SelectComponent(nil);
        {$ENDIF}
      Break;
    end;
  end;
end;

// private TFdxDBTreeListEditor
procedure TFdxDBTreeListEditor.ColumnChangeName(Sender: TObject);
var
  I: Integer;
begin
  if DBTreeList <> nil then
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

procedure TFdxDBTreeListEditor.UpdateDesigner;
begin
  if PDesigner <> nil then
    {$IFDEF DELPHI6}
      IDesigner(PDesigner).Modified;
    {$ELSE}
      {$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}(PDesigner).Modified;
    {$ENDIF}
end;

procedure TFdxDBTreeListEditor.WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo);
begin
  Message.MinMaxInfo^.ptMinTrackSize := Point(MinClientWidth, MinClientHeight);
  inherited;
end;

procedure TFdxDBTreeListEditor.FormCreate(Sender: TObject);
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
end;

procedure TFdxDBTreeListEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

destructor TFdxDBTreeListEditor.Destroy;
var
  I: Integer;
begin
  Destroying;
  if (DBTreeList <> nil) and not (csDestroying in DBTreeList.ComponentState) then
  if (GetParentForm(DBTreeList) <> nil) then
  begin
    if (GetParentForm(DBTreeList).Designer <> nil) and Active then
      {$IFDEF DELPHI6}
        IDesigner(PDesigner).SelectComponent(nil);
      {$ELSE}
        {$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}(PDesigner).SelectComponent(nil);
      {$ENDIF}
    if Assigned(DBTreeList) and not (csDestroying in DBTreeList.ComponentState) then
    begin
      if (DBTreeList.Designer <> nil) and not (TdxDBTreeListDesigner(DBTreeList.Designer).FDestroying) then
      begin
        TdxDBTreeListDesigner(DBTreeList.Designer).FDesignerForm := nil;
        DBTreeList.Designer.Free;
      end;
      for I := 0 to DBTreeList.ColumnCount - 1 do
        DBTreeList.Columns[I].OnChangeName := nil;
    end;
  end;
  inherited Destroy;
end;

{$IFDEF DELPHI6}

procedure TFdxDBTreeListEditor.DesignerClosed(const Designer: IDesigner; AGoingDormant: Boolean);
begin
  if Designer = Self.Designer then
  begin
    FClosed := True;
    PDesigner := nil;
  end;
end;

procedure TFdxDBTreeListEditor.SelectionChanged(const ADesigner: IDesigner; const ASelection: IDesignerSelections);
begin
  if FClosed or (ADesigner <> Self.Designer) then Exit;
  if not Active and SelectItems(ASelection, True) then
  begin
    UnSelectAll;
    SelectItems(ASelection, False);
  end;
end;

{$ELSE}

procedure TFdxDBTreeListEditor.FormClosed(AForm: TCustomForm);
begin
  if Assigned(AForm) and (Pointer(AForm.Designer) = PDesigner) then
  begin
    FClosed := True;
    PDesigner := nil;
  end;
end;

procedure TFdxDBTreeListEditor.SelectionChanged(ASelection: {$IFDEF DELPHI5}TDesignerSelectionList{$ELSE}TComponentList{$ENDIF});
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

procedure TFdxDBTreeListEditor.FillLists;
var
  I: Integer;
begin
  // Bands
  with LBands do
  begin
    Items.BeginUpdate;
    Items.Clear;
    for I := 0 to DBTreeList.Bands.Count - 1 do
      Items.AddObject(IntToStr(I) + ' - ' + DBTreeList.Bands[I].ClassName,
        DBTreeList.Bands[I]);
    Items.EndUpdate;
  end;
  // Columns
  with CListBox do
  begin
    Items.BeginUpdate;
    Items.Clear;
//    if not DBTreeList.DefaultFields then
      for I := 0 to DBTreeList.ColumnCount - 1 do
      begin
        Items.AddObject(DBTreeList.Columns[I].Name, DBTreeList.Columns[I]);
        DBTreeList.Columns[I].OnChangeName := Self.ColumnChangeName;
        DBTreeList.Columns[I].FreeNotification(Self);
      end;
    Items.EndUpdate;
  end;
  // select component
  SelectItem;
end;

procedure TFdxDBTreeListEditor.LoadSelectedItems(List: TList; Id: Integer);
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
  end;
end;

procedure TFdxDBTreeListEditor.SelectItem;
begin
  case PageControl.ActivePage.TabIndex of
  0: LBandsClick(nil);
  1: CListBoxClick(nil);
  else
    CListBoxClick(nil);
  end;
end;

procedure TFdxDBTreeListEditor.UnSelectAll;
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
procedure TFdxDBTreeListEditor.CListBoxClick(Sender: TObject);
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
          IDesigner(PDesigner).SelectComponent(DBTreeList);
      {$ELSE}
        if List.Count > 0 then
          {$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}(PDesigner).SetSelections(List)
        else
          {$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}(PDesigner).SelectComponent(DBTreeList);
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
    BWizard.Enabled := (DBTreeList <> nil) and Assigned(DBTreeList.DataSource) and
      Assigned(DBTreeList.DataSource.DataSet) and (DBTreeList.DataSource.DataSet.FieldCount > 0);
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

procedure TFdxDBTreeListEditor.CListBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    ActivateInspector(#0);
    Key := 0;
  end;
end;

// drag drop
procedure TFdxDBTreeListEditor.CListBoxStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  FOldDragIndex := -1;
end;

procedure TFdxDBTreeListEditor.CListBoxEndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if (0 <= FOldDragIndex) and (FOldDragIndex < CListBox.Items.Count) then
  begin
    CListBox.Selected[FOldDragIndex] := False;
    FOldDragIndex := -1;
  end;
end;

procedure TFdxDBTreeListEditor.ListBoxDragOver(ListBox: TListBox;
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

procedure TFdxDBTreeListEditor.CListBoxDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  ListBoxDragOver(CListBox, Sender, Source, X, Y, State, Accept);
end;

procedure TFdxDBTreeListEditor.CListBoxDragDrop(Sender, Source: TObject; X,
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
    if (Index <> -1) and (DBTreeList <> nil) then
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
procedure TFdxDBTreeListEditor.BAddClick(Sender: TObject);
var
  AColumnClass: TdxDBTreeListColumnClass;
  P: TPoint;
begin
  P := Point(BAdd.Left + BAdd.Width, BAdd.Top);
  P := ClientToScreen(P);
  AColumnClass := TdxDBTreeListColumnClass(SelectdxTreeListColumn(P.X, P.Y, '', DBTreeListColumns));
  if AColumnClass <> nil then
  if DBTreeList <> nil then
  with CListBox do
  begin
    Items.BeginUpdate;
    try
//      DBTreeList.DefaultFields := False;
      DBTreeList.CreateColumnEx(AColumnClass, ColumnOwner);
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

procedure TFdxDBTreeListEditor.BDeleteClick(Sender: TObject);
var
  I, OldIndex: Integer;
  List: TList;
begin
  if (DBTreeList <> nil) and (CListbox.SelCount > 0) then
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
        with DBTreeList do
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

procedure TFdxDBTreeListEditor.BChangeClick(Sender: TObject);
var
  AColumnClass: TdxDBTreeListColumnClass;
  NewColumn, OldColumn: TdxDBTreeListColumn;
  P: TPoint;
  I, OldIndex : Integer;
  OldName: string;
  List: TList;
begin
  if (DBTreeList = nil) or (CListBox.SelCount <= 0) then Exit;
  P := Point(BAdd.Left + BAdd.Width, BChange.Top);
  P := ClientToScreen(P);
  OldName := '';
  for I := 0 to CListBox.Items.Count - 1 do
    if CListBox.Selected[I] then
    begin
      OldName := TdxDBTreeListColumn(CListBox.Items.Objects[I]).ClassName;
      Break;
    end;
  AColumnClass := TdxDBTreeListColumnClass(SelectdxTreeListColumn(P.X, P.Y, OldName, DBTreeListColumns));
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
        DBTreeList.BeginUpdate;
        try
          for I := 0 to List.Count - 1 do
          begin
            OldColumn := TdxDBTreeListColumn(List[I]);
            NewColumn := DBTreeList.CreateColumnEx(AColumnClass, ColumnOwner);
            NewColumn.Index := OldColumn.Index;
            NewColumn.Assign(OldColumn);
            OldName := OldColumn.Name;
            OldColumn.Free;
            NewColumn.Name := OldName;
          end;
        finally
          DBTreeList.EndUpdate;
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

procedure TFdxDBTreeListEditor.BUpClick(Sender: TObject);
var
  I, OldIndex: Integer;
begin
  if DBTreeList <> nil then
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

procedure TFdxDBTreeListEditor.BDownClick(Sender: TObject);
var
  I, OldIndex: Integer;
begin
  if DBTreeList <> nil then
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

procedure TFdxDBTreeListEditor.BWizardClick(Sender: TObject);
begin
  if DBTreeList <> nil then
  with DBTreeList do
  begin
    if not (Assigned(DataSource) and Assigned(DataSource.DataSet)) then Exit;
    if ShowdxDBFieldsEditor(DBTreeList, ColumnOwner) then
      FillLists;
    CListBox.SetFocus;
    CListBoxClick(nil);
    // modi
    UpdateDesigner;
  end;
end;

procedure TFdxDBTreeListEditor.BRestoreClick(Sender: TObject);
begin
  if DBTreeList <> nil then
  begin
    DBTreeList.RestoreColumnsDefaults;
    FillLists;
    // modi
    UpdateDesigner;
  end;
end;

procedure TFdxDBTreeListEditor.BRestoreWidthsClick(Sender: TObject);
var
  I: Integer;
begin
  // Restore Default Widths
  if DBTreeList <> nil then
  with DBTreeList do
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

procedure TFdxDBTreeListEditor.miSelectAllClick(Sender: TObject);
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
procedure TFdxDBTreeListEditor.BAddBandClick(Sender: TObject);
begin
  if DBTreeList <> nil then
  with LBands do
  begin
    Items.BeginUpdate;
    try
      DBTreeList.Bands.Add;
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

procedure TFdxDBTreeListEditor.BDeleteBandClick(Sender: TObject);
var
  I, OldIndex: Integer;
  List: TList;
begin
  if (DBTreeList <> nil) and (LBands.SelCount > 0) then
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

procedure TFdxDBTreeListEditor.BUpBandClick(Sender: TObject);
var
  I, OldIndex: Integer;
begin
  if DBTreeList <> nil then
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

procedure TFdxDBTreeListEditor.BDownBandClick(Sender: TObject);
var
  I, OldIndex: Integer;
begin
  if DBTreeList <> nil then
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

procedure TFdxDBTreeListEditor.BRestoreDefaultClick(Sender: TObject);
begin
  if DBTreeList <> nil then
  begin
    DBTreeList.Bands.RestoreDefaults;
    FillLists;
    // modi
    UpdateDesigner;
  end;
end;

procedure TFdxDBTreeListEditor.miAllBandsClick(Sender: TObject);
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

procedure TFdxDBTreeListEditor.LBandsClick(Sender: TObject);
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
          IDesigner(PDesigner).SelectComponent(DBTreeList);
      {$ELSE}
        if List.Count > 0 then
          {$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}(PDesigner).SetSelections(List)
        else
          {$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}(PDesigner).SelectComponent(DBTreeList);
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

procedure TFdxDBTreeListEditor.LBandsDragDrop(Sender, Source: TObject; X, Y: Integer);
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
    if (Index <> -1) and (DBTreeList <> nil) then
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

procedure TFdxDBTreeListEditor.LBandsEndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if (0 <= FOldDragIndex) and (FOldDragIndex < LBands.Items.Count) then
  begin
    LBands.Selected[FOldDragIndex] := False;
    FOldDragIndex := -1;
  end;
end;

procedure TFdxDBTreeListEditor.LBandsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  ListBoxDragOver(LBands, Sender, Source, X, Y, State, Accept);
end;

procedure TFdxDBTreeListEditor.PageControlChange(Sender: TObject);
begin
  SelectItem;
end;

end.
