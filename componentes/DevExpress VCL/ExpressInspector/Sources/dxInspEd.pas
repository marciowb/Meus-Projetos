
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressInspector rows editor                                }
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

unit dxInspEd;

interface

{$I dxInsVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxCntner, dxInspct, StdCtrls, ExtCtrls, Menus{$IFNDEF DELPHI6}, DsgnIntf{$ELSE},
  DesignIntf, DesignEditors{$ENDIF};

type
  TdxDesignInspectorControl = class(TCustomdxInspectorControl);

  TdxInspectorEditForm = class(TForm)
    pnButtons: TPanel;
    BAdd: TButton;
    BDelete: TButton;
    BRestore: TButton;
    BChange: TButton;
    PopupMenu: TPopupMenu;
    miAdd: TMenuItem;
    miDelete: TMenuItem;
    miChangetype: TMenuItem;
    miRestoreDefaults: TMenuItem;
    N1: TMenuItem;
    miShowButtons: TMenuItem;
    cbDragDrop: TCheckBox;
    Panel1: TPanel;
    dxInspector: TdxInspector;
    Splitter1: TSplitter;
    Panel2: TPanel;
    LHidden: TListBox;
    Panel3: TPanel;
    Label1: TLabel;
    Bevel: TBevel;
    procedure dxInspectorDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure dxInspectorDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure BAddClick(Sender: TObject);
    procedure BDeleteClick(Sender: TObject);
    procedure BChangeClick(Sender: TObject);
    procedure dxInspectorClick(Sender: TObject);
    procedure BRestoreClick(Sender: TObject);
    procedure miShowButtonsClick(Sender: TObject);
    procedure cbDragDropClick(Sender: TObject);
    procedure dxInspectorChangeNode(Sender: TObject; OldNode,
      Node: TdxInspectorNode);
    procedure dxInspectorEnter(Sender: TObject);
    procedure LHiddenEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FListBoxActive: Boolean;
    function GetListBoxActive: Boolean;
    procedure WMGetMinMaxInfo(var Message : TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
  protected
    procedure CorrectComplexRow(APrevRow, ANewRow: TdxInspectorRow);
    procedure FillInspector; virtual;
    procedure FillList; virtual;
    procedure FillListBox; virtual;
    function GetSelectedRow: TdxInspectorRow;
    procedure PrepareCloneInspector; virtual;
    procedure SelectInspector(AListBoxActivate: Boolean); virtual;
    procedure SelectRow(ARow: TdxInspectorRow); virtual;
    procedure UpdateDesigner;
    procedure UnSelectAll;
  public
    LockUpdate: Boolean;
    {$IFDEF DELPHI6}
    PDesigner: IDesigner;
    {$ELSE}
      {$IFDEF DELPHI4}
      PDesigner: IFormDesigner;
      {$ELSE}
      PDesigner: TFormDesigner;
      {$ENDIF}
    {$ENDIF}
    TextInspector: TdxDesignInspectorControl;
    property ListBoxActive: Boolean read GetListBoxActive;
  end;

  { TdxTextInspectorDesigner }

  TdxTextInspectorDesigner = class(TdxInspectorDesigner)
  private
    FDestroying: Boolean;
    FDesignerForm: TdxInspectorEditForm;
  public
    destructor Destroy; override;
    procedure LayoutChanged; override;
    property DesignerForm: TdxInspectorEditForm read FDesignerForm write FDesignerForm;
  end;

procedure ShowdxInspectorEditor(AInspector: TdxInspector; ADesigner: Pointer);

implementation

{$R *.DFM}

uses
  dxInRowA, dxInsReg;

procedure ShowdxInspectorEditor(AInspector: TdxInspector; ADesigner: Pointer);
var
  AForm: TdxInspectorEditForm;
begin
  if AInspector.Designer <> nil then
  begin
     TdxTextInspectorDesigner(AInspector.Designer).DesignerForm.Show;
     Exit;
  end;
  AForm := TdxInspectorEditForm.Create(nil);
  AForm.TextInspector := TdxDesignInspectorControl(AInspector);
  TdxTextInspectorDesigner.Create(AInspector).FDesignerForm := AForm;
  with AForm do
  begin
    {$IFDEF DELPHI6}
    PDesigner := IDesigner(ADesigner);
    {$ELSE}
      {$IFDEF DELPHI4}
      PDesigner := IFormDesigner(ADesigner);
      {$ELSE}
      PDesigner := TFormDesigner(ADesigner);
      {$ENDIF}
    {$ENDIF}
    FillList;
    dxInspectorClick(nil);
    Caption := 'Editing ' + TextInspector.Name + '.Rows';
    Show;
  end;
end;

destructor TdxTextInspectorDesigner.Destroy;
begin
  FDestroying := True;
  if FDesignerForm <> nil then
    with FDesignerForm do
    begin
      Close;
      Free;
    end;
  inherited Destroy;
end;

procedure TdxTextInspectorDesigner.LayoutChanged;
begin
  if (FDesignerForm <> nil) and not FDesignerForm.LockUpdate then
    with FDesignerForm do
    begin
      FillList;
      Caption := 'Editing ' + TextInspector.Name + '.Rows';
    end;
end;

{ TdxInspectorEditForm }

procedure TdxInspectorEditForm.CorrectComplexRow(APrevRow, ANewRow: TdxInspectorRow);
var
  AComplexRow: TdxInspectorComplexRow;
  AIndex: Integer;
begin
  AComplexRow := TextInspector.ComplexRowByRow(APrevRow);
  if AComplexRow <> nil then
  begin
    AIndex := AComplexRow.Items.IndexOfRow(APrevRow);
    if AIndex <> -1 then
      AComplexRow.Items[AIndex].Row := ANewRow;
  end;
end;

procedure TdxInspectorEditForm.FillInspector;
var
  APrevFocusedRow, APrevTopRow: string;
  ARow: TdxInspectorRow;
begin
  with dxInspector do
  begin
    // save top indexes
    if FocusedNode <> nil then
    begin
      APrevTopRow := TdxInspectorRowNode(TopVisibleNode).Row.Name;
      APrevFocusedRow := TdxInspectorRowNode(FocusedNode).Row.Name;
    end
    else
    begin
      APrevTopRow := '';
      APrevFocusedRow := '';
    end;
    BeginUpdate;
    try
      PrepareCloneInspector;
      if TopNode <> nil then
        with TopNode do
        begin
          Focused := True;
          MakeVisible;
        end;
      // restore top indexes
      if APrevTopRow <> '' then
      begin
        ARow := RowByName(APrevTopRow);
        if (ARow <> nil) and (ARow.Node <> nil ) then
          TopIndex := ARow.Node.AbsoluteIndex;
      end;
      if APrevFocusedRow <> '' then
      begin
        ARow := RowByName(APrevFocusedRow);
        if (ARow <> nil) and (ARow.Node <> nil ) then
          ARow.Node.Focused := True;
      end;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TdxInspectorEditForm.FillList;
begin
  FillInspector;
  FillListBox;
end;

procedure TdxInspectorEditForm.FillListBox;
var
  ATopIndex, AItemIndex: Integer;
  I: Integer;
begin
  with dxInspector do
  begin
    with LHidden, Items do
    begin
      // save top indexes
      ATopIndex := TopIndex;
      AItemIndex := ItemIndex;
      BeginUpdate;
      try
        Clear;
        for I := 0 to TotalRowCount - 1 do
          if not Rows[I].Visible and not RowInComplexRow(Rows[I]) then
            AddObject(Rows[I].Name, Pointer(I));
        // restore top indexes
        TopIndex := ATopIndex;
        ItemIndex := AItemIndex;
      finally
        EndUpdate;
      end;
    end;
  end;
end;

function TdxInspectorEditForm.GetSelectedRow: TdxInspectorRow;
var
  ARowIndex: Integer;
begin
  Result := nil;
  if FListBoxActive then
  begin
    if LHidden.ItemIndex <> -1 then
    begin
      ARowIndex := Integer(LHidden.Items.Objects[LHidden.ItemIndex]);
      if (0 <= ARowIndex) and (ARowIndex < dxInspector.TotalRowCount) then
        Result := dxInspector.Rows[ARowIndex];
    end;
  end
  else
  begin
    if dxInspector.FocusedNode <> nil then
      Result := TdxInspectorRowNode(dxInspector.FocusedNode).Row;
  end;
end;

procedure TdxInspectorEditForm.PrepareCloneInspector;
begin
  dxInspector.Color := TextInspector.Color;
  dxInspector.Font.Assign(TextInspector.Font);
  dxInspector.GridColor := TextInspector.GridColor;
  dxInspector.Options := dxInspector.Options - [ioEditing];
  dxInspector.PaintStyle := TextInspector.PaintStyle;
  dxInspector.AssignRows(TextInspector);
end;

procedure TdxInspectorEditForm.SelectInspector(AListBoxActivate: Boolean);
begin
  FListBoxActive := AListBoxActivate;
  dxInspectorClick(nil);
  UpdateDesigner;
end;

procedure TdxInspectorEditForm.SelectRow(ARow: TdxInspectorRow);
begin
  if ARow <> nil then
    PDesigner.SelectComponent(ARow)
  else
    PDesigner.SelectComponent(TextInspector);
  if FListBoxActive then
    BDelete.Enabled := LHidden.ItemIndex <> -1
  else
    BDelete.Enabled := dxInspector.TotalRowCount > 0;
  BChange.Enabled := BDelete.Enabled;
  BRestore.Enabled := BDelete.Enabled;
  // PopupMenu
  miDelete.Enabled := BDelete.Enabled;
  miChangetype.Enabled := BChange.Enabled;
  miRestoreDefaults.Enabled := BRestore.Enabled;
end;

procedure TdxInspectorEditForm.UpdateDesigner;
begin
  if PDesigner <> nil then
    PDesigner.Modified;
end;

procedure TdxInspectorEditForm.UnSelectAll; {clear selection}
begin
  SelectRow(nil);
end;

function TdxInspectorEditForm.GetListBoxActive: Boolean;
begin
  Result := FListBoxActive;
end;

procedure TdxInspectorEditForm.WMGetMinMaxInfo(var Message : TWMGetMinMaxInfo);
begin
  Message.MinMaxInfo^.ptMinTrackSize := Point(290, 210);
  inherited;
end;

// Events

procedure TdxInspectorEditForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  if Assigned(TextInspector) and
    not (csDestroying in TextInspector.ComponentState) then
  begin
    if (TextInspector.Designer <> nil) and
       not (TdxTextInspectorDesigner(TextInspector.Designer).FDestroying) then
    begin
      SelectRow(nil);
      TdxTextInspectorDesigner(TextInspector.Designer).FDesignerForm := nil;
      TextInspector.Designer.Free;
    end;
  end;
end;

// Inspector Events

procedure TdxInspectorEditForm.dxInspectorDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var 
  AHitTest: TdxInspectorHitTest;
begin
  if Source = dxInspector then
  begin
    Accept:= True;
    if dxInspector.DragNode = nil then
    begin
      Accept:= False;
      Exit;
    end;
    AHitTest := dxInspector.GetHitTestInfoAt(X, Y);
    case AHitTest of
      ihtIndent, ihtButton, ihtImage:
        dxInspector.DragCursor := crdxInspectorInsert;
      ihtDisplayLabel, ihtLabel, ihtComplexRowSeparator:
        dxInspector.DragCursor := crdxInspectorAddChild;
      ihtNowhere:
        dxInspector.DragCursor := crdxInspectorAdd;
    end;
  end
  else
    Accept:= False;
end;

procedure TdxInspectorEditForm.dxInspectorDragDrop(Sender,
  Source: TObject; X, Y: Integer);

  function FindNodeInTextInspector(ANode: TdxInspectorNode): TdxInspectorNode;
  var
    ARow: TdxInspectorRow;
  begin
    if (ANode <> nil) and (TdxInspectorRowNode(ANode).Row <> nil ) then
    begin
      ARow := TextInspector.RowByName(TdxInspectorRowNode(ANode).Row.Name);
      if ARow <> nil then
        Result := ARow.Node
      else
        Result := nil;
    end
    else
      Result := nil;
  end;

var
  AHitTest: TdxInspectorHitTest;
  ANode, ADestinationNode: TdxInspectorNode;
  AAttachMode: TdxInspectorNodeAttachMode;
begin
  if Source <> dxInspector then Exit;
  with dxInspector do
  begin
    AHitTest := GetHitTestInfoAt(X, Y);
    if AHitTest in [ihtIndent, ihtButton, ihtImage, ihtDisplayLabel, ihtLabel,
      ihtColumnEdge, ihtComplexRowSeparator, ihtNowhere] then
    begin
      ADestinationNode := GetNodeAt(X, Y);
      AAttachMode := inaAddChild;
      case AHitTest of
        ihtIndent, ihtButton, ihtImage:
          AAttachMode := inaInsert;
        ihtDisplayLabel, ihtLabel, ihtComplexRowSeparator:
          AAttachMode := inaAddChild;
        ihtNowhere:
        begin
          AAttachMode := inaAdd;
          ADestinationNode := Items[0];
        end;
      end;
      ANode := DragNode;
      // find items
      ANode := FindNodeInTextInspector(ANode);
      ADestinationNode := FindNodeInTextInspector(ADestinationNode);
      // move rows in TextInspector
      if (ANode <> nil) and (ADestinationNode <> nil) then
      begin
        ANode.MoveTo(ADestinationNode, AAttachMode);
        UpdateDesigner;
      end;
    end;
  end;
end;

procedure TdxInspectorEditForm.dxInspectorClick(Sender: TObject);
var
  ARow: TdxInspectorRow;
begin
  if TextInspector <> nil then
    with TextInspector do
    begin
      ARow := GetSelectedRow;
      if ARow <> nil then
      begin
        ARow := TextInspector.RowByName(ARow.Name);
        SelectRow(ARow);
      end
      else
        SelectRow(nil);
    end;
end;

procedure TdxInspectorEditForm.dxInspectorChangeNode(Sender: TObject; OldNode,
  Node: TdxInspectorNode);
begin
  if dxInspector.LockUpdate = 0 then
    dxInspectorClick(nil);
end;

procedure TdxInspectorEditForm.dxInspectorEnter(Sender: TObject);
begin
  FListBoxActive := False;
end;

procedure TdxInspectorEditForm.LHiddenEnter(Sender: TObject);
begin
  FListBoxActive := True;
end;

procedure TdxInspectorEditForm.miShowButtonsClick(Sender: TObject);
begin
  miShowButtons.Checked := not miShowButtons.Checked;
  pnButtons.Visible := miShowButtons.Checked;
end;

procedure TdxInspectorEditForm.cbDragDropClick(Sender: TObject);
begin
  dxInspector.DragMode := TDragMode(cbDragDrop.Checked);
end;

// Buttons

procedure TdxInspectorEditForm.BAddClick(Sender: TObject);
var
  ARowClass: TdxInspectorRowClass;
  P: TPoint;
begin
  P := Point(BAdd.Left + BAdd.Width, BAdd.Top);
  P := ClientToScreen(P);
  ARowClass := SelectdxInspectorRow(P.X, P.Y, '', InspectorRows);
  if (ARowClass <> nil) and (TextInspector <> nil) then
  begin
    TextInspector.CreateRow(ARowClass);
    FillList;
    with dxInspector do
      if Count > 0 then Items[Count - 1].Focused := True;
    // select component
    SelectInspector(False);
  end;
end;

procedure TdxInspectorEditForm.BDeleteClick(Sender: TObject);
var
  ARow: TdxInspectorRow;
  APrevIndex: Integer;
begin
  if TextInspector <> nil then
  begin
    // Get Row
    if FListBoxActive then
      APrevIndex := LHidden.ItemIndex
    else
      APrevIndex := dxInspector.FocusedNumber;
    ARow := GetSelectedRow;
    // Delete Row
    if ARow <> nil then
    begin
      ARow := TextInspector.RowByName(ARow.Name);
      if ARow <> nil then
      begin
        UnSelectAll;
        LockUpdate := True;
        try
          ARow.Free;
        finally
          LockUpdate := False;
        end;
        FillList;
        if FListBoxActive then
          LHidden.ItemIndex := APrevIndex
        else
          dxInspector.FocusedNumber := APrevIndex;
        // select component
        SelectInspector(FListBoxActive);
      end;
    end;
  end;
end;

procedure TdxInspectorEditForm.BChangeClick(Sender: TObject);
var
  ARowClass: TdxInspectorRowClass;
  P: TPoint;
  APrevName: string;
  APrevIndex: Integer;
  ARow, ANewRow, APrevRow: TdxInspectorRow;
begin
  ARow := GetSelectedRow;
  if (TextInspector = nil) or (ARow = nil) then Exit;
  P := Point(BChange.Left + BChange.Width, BChange.Top );
  P := ClientToScreen(P);
  if ARow <> nil then
    APrevName := ARow.ClassName
  else
    APrevName := '';
  ARowClass := SelectdxInspectorRow(P.X, P.Y, APrevName, InspectorRows);
  if (ARowClass <> nil) and (ARowClass.ClassName <> APrevName) then
  begin
    UnSelectAll;
    if FListBoxActive then
      APrevIndex := LHidden.ItemIndex
    else
      APrevIndex := dxInspector.FocusedNumber;
    APrevRow := TextInspector.RowByName(ARow.Name);
    ANewRow := TextInspector.CreateRow(ARowClass);
    // move nodes
    ANewRow.Node.MoveTo(APrevRow.Node, inaInsert);
    if APrevRow.Node <> nil then
      while APrevRow.Node.HasChildren do
        APrevRow.Node[0].MoveTo(ANewRow.Node, inaAddChild);
    // FieldName
    ANewRow.Assign(APrevRow);
    ANewRow.LinkObjectName := APrevRow.LinkObjectName;
    APrevName := APrevRow.Name;
    CorrectComplexRow(APrevRow, ANewRow);
    APrevRow.Free;
    ANewRow.Name := APrevName;
    FillList;
    if FListBoxActive then
      LHidden.ItemIndex := APrevIndex
    else
      dxInspector.FocusedNumber := APrevIndex;
    // select component
    SelectInspector(FListBoxActive);
  end;
end;

procedure TdxInspectorEditForm.BRestoreClick(Sender: TObject);
begin
  if TextInspector <> nil then
  begin
    TextInspector.RestoreRowsDefaults;
    UpdateDesigner;
  end;
end;

end.

