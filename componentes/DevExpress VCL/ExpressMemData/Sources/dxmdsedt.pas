{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressMemData - CLX/VCL Edition                            }
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
{   (DCU, OBJ, DLL, DPU, SO, ETC.) ARE CONFIDENTIAL AND PROPRIETARY }
{   TRADE SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER}
{   IS LICENSED TO DISTRIBUTE THE EXPRESSMEMDATA                    }
{   AS PART OF AN EXECUTABLE PROGRAM ONLY.                          }
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

unit dxmdsedt;

interface

{$I cxVer.inc}

uses
{$IFDEF DELPHI6}
  DesignIntf,
{$ELSE}
  DsgnIntf,
{$ENDIF}
  Windows, Classes, Controls, Forms, StdCtrls, dxmdaset, ExtCtrls, Menus, Graphics;

type
  TfrmdxMemDataEditor = class(TForm)
  private
    ListBox: TListBox;
    pnButtons: TPanel;
    BAdd: TButton;
    BDelete: TButton;
    BUp: TButton;
    BDown: TButton;
    pmColumns: TPopupMenu;
    miShowButtons: TMenuItem;
    procedure ListBoxClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BAddClick(Sender: TObject);
    procedure BDeleteClick(Sender: TObject);
    procedure miUpClick(Sender: TObject);
    procedure miDownClick(Sender: TObject);
    procedure miSelectAllClick(Sender: TObject);
    procedure miShowButtonsClick(Sender: TObject);
    procedure ListBoxDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListBoxStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure ListBoxEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure ListBoxDragDrop(Sender, Source: TObject; X, Y: Integer);

    procedure CreateControls;

    procedure MoveField(ADirection: Integer);
    procedure GetSelection(AList: TList);
    procedure SetSelection(AList: TList);
  protected
  {$IFDEF DELPHI9}
    procedure CreateParams(var Params: TCreateParams); override;
  {$ENDIF}
  public
    Data: TdxMemData;
    FormDesigner: IDesigner;

    procedure FillList;
  end;

function ShowMemDataFieldEditor(AData: TdxMemData; AFormDesigner: IDesigner): Boolean;

implementation

uses
  Contnrs, DB, dxmdseda;

var
  FormList: TList;

const
  OldDragIndex: Integer = -1;

type
  TMemDataSetDesigner = class(TDataSetDesigner)
  private
   AForm: TfrmdxMemDataEditor;
   FDestroying: Boolean;
  public
    destructor Destroy; override;
    procedure DataEvent(Event: TDataEvent;
      Info: Longint); override;
  end;

destructor TMemDataSetDesigner.Destroy;
begin
  FDestroying := True;
  if AForm <> nil then
    AForm.Close;
  inherited Destroy;
end;

procedure TMemDataSetDesigner.DataEvent(Event: TDataEvent;
  Info: Longint);
var
  i, j: Integer;
begin
  if AForm <> nil then
    with AForm do
    begin
      ListBox.Items.BeginUpdate;
      for i := 0 to Data.FieldCount - 1 do
        if Data.Fields[i].Owner = Data.Owner then
        begin
          j := ListBox.Items.IndexOfObject(Data.Fields[i]);
          if j > -1 then
            ListBox.Items[j] := Data.Fields[i].FieldName;
        end;
      ListBox.Items.EndUpdate;
    end;
end;

function ShowMemDataFieldEditor(AData: TdxMemData; AFormDesigner: IDesigner): Boolean;
var
  AForm: TfrmdxMemDataEditor;
  i: Integer;
begin
  AForm := nil;
  for i := 0 to FormList.Count - 1 do
    if TfrmdxMemDataEditor(FormList[i]).Data = AData then
    begin
      AForm := TfrmdxMemDataEditor(FormList[i]);
      Break;
    end;
  if AForm = nil then
  begin
    AForm := TfrmdxMemDataEditor.CreateNew(nil);
    AForm.CreateControls;
    AForm.Data := AData;
    AForm.FormDesigner := AFormDesigner;
    TMemDataSetDesigner.Create(AData);
    TMemDataSetDesigner(AData.Designer).AForm := AForm;
    FormList.Add(AForm);
  end;
  with AForm do
  begin
    FillList;
    Caption := 'Editing ' + Data.Name + '.Fields';
    Show;
    Result := True;
  end;
end;

procedure TfrmdxMemDataEditor.FillList;
Var
  i: Integer;
begin
  ListBox.Items.BeginUpdate;
  ListBox.Items.Clear;
  for i := 0 to Data.FieldCount - 1 do
    if Data.Fields[i].Owner = Data.Owner then
      ListBox.Items.AddObject(Data.Fields[i].FieldName, Data.Fields[i]);
  ListBox.Items.EndUpdate;
  ListBoxClick(nil);
end;

procedure TfrmdxMemDataEditor.ListBoxClick(Sender: TObject);
var
  AList: IDesignerSelections;
  i: Integer;
begin
  if (csDesigning in Data.ComponentState) then
  begin
    AList := CreateSelectionList;
    try
      for i := 0 to Listbox.Items.Count - 1 do
        if Listbox.Selected[i] then
          AList.Add(TComponent(Listbox.Items.Objects[i]));
        if AList.Count > 0 then
          FormDesigner.SetSelections(AList)
        else
          FormDesigner.SelectComponent(Data);
    finally
      AList := nil;
    end;
  end;
  BDelete.Enabled := Listbox.SelCount > 0;
  BUp.Enabled := Listbox.SelCount > 0;
  BDown.Enabled := Listbox.SelCount > 0;
end;

procedure TfrmdxMemDataEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (Data <> nil) and Not (csDestroying in Data.ComponentState)
  and (Data.Designer <> nil) and not TMemDataSetDesigner(Data.Designer).FDestroying then
  begin
    TMemDataSetDesigner(Data.Designer).AForm := nil;
    Data.Designer.Free;
  end;
  FormList.Remove(self);
  Action := caFree;
end;

procedure TfrmdxMemDataEditor.BAddClick(Sender: TObject);
var
  AField: TField;
  P: TPoint;
begin
  P := Point(BAdd.Left + BAdd.Width, BAdd.Top);
  P := ClientToScreen(P);
  Data.Close;
  AField := GetMemDataNewFieldType(Data, P.X, P.Y, FormDesigner);
  if AField <> nil then
  begin
    FillList;
    ListBox.Selected[ListBox.Items.Count-1] := True;
    ListBox.ItemIndex := ListBox.Items.Count-1;
    ListBox.SetFocus;
    ListBoxClick(nil);
  end;
end;

procedure TfrmdxMemDataEditor.BDeleteClick(Sender: TObject);
var
  i, OldIndex: Integer;
  List: TList;
begin
  if Data <> nil then
  begin
    OldIndex := ListBox.ItemIndex;
    List := TList.Create;
    for i := 0 to ListBox.Items.Count - 1 do
     if ListBox.Selected[i] then
        List.Add(ListBox.Items.Objects[i]);
    for i := 0 to List.Count - 1 do
       TField(List[i]).Free;
    List.Free;
    FillList;
    if OldIndex >= ListBox.Items.Count then
      OldIndex := ListBox.Items.Count - 1;
    if (OldIndex <> -1) and (ListBox.Items.Count > 0) then
      ListBox.Selected[OldIndex] := True;
    ListBox.SetFocus;
    ListBoxClick(nil);
  end;
end;

procedure TfrmdxMemDataEditor.miUpClick(Sender: TObject);
begin
  MoveField(-1);
end;

procedure TfrmdxMemDataEditor.miDownClick(Sender: TObject);
begin
  MoveField(1);
end;

procedure TfrmdxMemDataEditor.miSelectAllClick(Sender: TObject);
var
  i: Integer;
begin
  with ListBox do
    for i := 0 to Items.Count - 1 do
      Selected[i] := True;
  ListBox.SetFocus;
  ListBoxClick(nil);
end;

procedure TfrmdxMemDataEditor.miShowButtonsClick(Sender: TObject);
begin
  miShowButtons.Checked := not miShowButtons.Checked;
  pnButtons.Visible := miShowButtons.Checked;
end;

procedure TfrmdxMemDataEditor.ListBoxDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  Index: Integer;
begin
  Accept := Source = ListBox;
  if not Accept then
    Exit;
  Index := ListBox.ItemAtPos(Point(X, Y), True);
  if OldDragIndex <> Index then
  begin
    if OldDragIndex <> -1 then
      ListBox.Selected[OldDragIndex] := False;
    if Index <> -1 then
      if not ListBox.Selected[Index] then
      begin
        ListBox.Selected[Index] := True;
        OldDragIndex := Index;
      end
      else
        OldDragIndex := -1;
  end;
  if (Index <> -1) then
    ListBox.ItemIndex := Index;
end;

procedure TfrmdxMemDataEditor.ListBoxStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  OldDragIndex := -1;
end;

procedure TfrmdxMemDataEditor.ListBoxEndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if OldDragIndex <> -1 then
  begin
    ListBox.Selected[OldDragIndex] := False;
    OldDragIndex := -1;
  end;
end;

procedure TfrmdxMemDataEditor.ListBoxDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  i, Index: Integer;
  List: TList;
begin
  if OldDragIndex <> -1 then
  begin
    ListBox.Selected[OldDragIndex] := False;
    OldDragIndex := -1;
  end;
  Index := ListBox.ItemAtPos(Point(X, Y), True);
  if (Index <> -1) and (Data <> nil) then
  begin
    List := TList.Create;
    try
      GetSelection(List);
      if TField(List[0]).Index > Index then
        for i := List.Count - 1 downto 0 do
          TField(List[i]).Index := Index + 1
      else
        for i := 0 to List.Count - 1 do
          TField(List[i]).Index := Index + 1;
      if FormDesigner <> nil then
        FormDesigner.Modified;
      FillList;
      SetSelection(List);
      ListBoxClick(nil);
    finally
      List.Free;
    end;
  end;
end;

procedure TfrmdxMemDataEditor.CreateControls;

  function CreateMenuItem(ACaption: String; AShortCut: TShortCut; ANotifyEvent: TNotifyEvent): TMenuItem;
  begin
    Result := TMenuItem.Create(pmColumns);
    pmColumns.Items.Add(Result);
    Result.Caption := ACaption;
    Result.ShortCut := AShortCut;
    Result.OnClick := ANotifyEvent;
  end;

begin
  pmColumns := TPopupMenu.Create(self);
  CreateMenuItem('&Add...', 45, BAddClick);
  CreateMenuItem('&Delete', 46, BDeleteClick);
  CreateMenuItem('Move &Up', 0, miUpClick);
  CreateMenuItem('Move Dow&n', 0, miDownClick);
  CreateMenuItem('&Select All', 0, miSelectAllClick);
  CreateMenuItem('-', 0, nil);
  miShowButtons := CreateMenuItem('&Show Buttons', 0, miShowButtonsClick);
  miShowButtons.Checked := True;

  ListBox := TListBox.Create(self);
  with ListBox do
  begin
    Parent := self;
    Align := alClient;
    ListBox.DragMode := dmAutomatic;
    ItemHeight := 16;
    MultiSelect := True;
    PopupMenu := pmColumns;
    TabOrder := 0;
    OnClick := ListBoxClick;
    OnDragDrop := ListBoxDragDrop;
    OnDragOver := ListBoxDragOver;
    OnEndDrag := ListBoxEndDrag;
    OnStartDrag := ListBoxStartDrag;
  end;

  pnButtons := TPanel.Create(self);
  with pnButtons do
  begin
    Parent := self;
    Width := 107;
    Align := alRight;
    BevelOuter := bvNone;
    TabOrder := 1;
  end;

  BAdd := TButton.Create(self);
  with BAdd do
  begin
    Parent := pnButtons;
    Left := 8;
    Top := 7;
    Width := 92;
    Height := 28;
    Caption := '&Add ...';
    OnClick := BAddClick;
  end;

  BDelete := TButton.Create(self);
  with BDelete do
  begin
    Parent := pnButtons;
    Left := BAdd.Left;
    Top := BAdd.Top + BAdd.Height + BAdd.Top;
    Width := BAdd.Width;
    Height := BAdd.Height;
    Caption := '&Delete';
    OnClick := BDeleteClick;
  end;

  BUp := TButton.Create(self);
  with BUp do
  begin
    Parent := pnButtons;
    Left := BAdd.Left;
    Top := BDelete.Top + BDelete.Height + BAdd.Top;
    Width := BAdd.Width;
    Height := BAdd.Height;
    Caption := 'Move &Up';
    OnClick := miUpClick;
  end;

  BDown := TButton.Create(self);
  with BDown do
  begin
    Parent := pnButtons;
    Left := BAdd.Left;
    Top := BUp.Top + BUp.Height + BAdd.Top;
    Width := BAdd.Width;
    Height := BAdd.Height;
    Caption := 'Move Dow&n';
    OnClick := miDownClick;
  end;

  ActiveControl := ListBox;
  BorderIcons := [biSystemMenu];

    BorderStyle := bsSizeToolWin;

  Caption := 'Columns Editor';
  Left := 100;
  Top := 100;
  Color := clBtnFace;
  OnClose := FormClose;
end;

procedure TfrmdxMemDataEditor.MoveField(ADirection: Integer);
var
  i: Integer;
  List: TList;
begin
  if Data <> nil then
  begin
    List := TList.Create;
    try
      GetSelection(List);
      for i := 0 to List.Count - 1 do
        TField(List[i]).Index := TField(List[i]).Index + ADirection;
      if FormDesigner <> nil then
        FormDesigner.Modified;
      FillList;
      SetSelection(List);
    finally
      List.Free;
    end;
    ListBoxClick(nil);
  end;
end;

procedure TfrmdxMemDataEditor.GetSelection(AList: TList);
var
  I: Integer;
begin
  for I := 0 to ListBox.Items.Count - 1 do
    if ListBox.Selected[I] then
      AList.Add(ListBox.Items.Objects[i]);
end;

procedure TfrmdxMemDataEditor.SetSelection(AList: TList);
var
  I: Integer;
begin
  for I := 0 to ListBox.Items.Count - 1 do
    ListBox.Selected[I] := AList.IndexOf(ListBox.Items.Objects[I]) <> -1;
end;

{$IFDEF DELPHI9}
procedure TfrmdxMemDataEditor.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := Application.MainForm.Handle;
end;
{$ENDIF}

initialization
  FormList := TList.Create;

finalization
  FormList.Free;

end.

