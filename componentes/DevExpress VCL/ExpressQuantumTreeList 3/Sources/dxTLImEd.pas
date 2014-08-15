
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressQuantumTreeList image column editor                  }
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

unit dxTLImEd;

interface

{$I dxTLVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, dxCntner, Grids, Menus, dxTLClms;

type
TExtStringGrid = class;

TFdxTLImageValuesEdit = class(TForm)
  Panel1: TPanel;
  BOk: TButton;
  BCancel: TButton;
  Panel2: TPanel;
  BHelp: TButton;
  BAdd: TButton;
  BDelete: TButton;
  BInsert: TButton;
  PopupMenu: TPopupMenu;
  miAdd: TMenuItem;
  miInsert: TMenuItem;
  miDelete: TMenuItem;
  N1: TMenuItem;
  miHelp: TMenuItem;
  procedure BAddClick(Sender: TObject);
  procedure BDeleteClick(Sender: TObject);
  procedure BInsertClick(Sender: TObject);
  procedure StringGridDrawCell(Sender: TObject; Col, Row: LongInt;
    Rect: TRect; State: TGridDrawState);
  procedure FormCreate(Sender: TObject);
private
  FImages: TImageList;
  procedure SetImages(Value: TImageList);
  procedure WMGetMinMaxInfo(var Message : TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
protected
  StringGrid: TExtStringGrid;
  procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  procedure SetColumnWidths;
public
  ADefaultImages: Boolean;
  procedure SetImageIndexes;
  property Images: TImageList read FImages write SetImages;
end;

TExtStringGrid = class (TStringGrid)
private
  FOldText: String;
  function GetForm: TFdxTLImageValuesEdit;
  procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
  procedure WMSize(var Msg: TWMSize); message WM_SIZE;
protected
  procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  function CanEditShow: Boolean; override;
  function GetEditText(ACol, ARow: Longint): string; override;
  procedure SetEditText(ACol, ARow: Longint; const Value: string); override;
end;

function ShowImagesValuesEditor(AColumn : TdxTreeListImageColumn) : Boolean;

var
  FdxTLImageValuesEdit: TFdxTLImageValuesEdit;

implementation

{$R *.DFM}

function ShowImagesValuesEditor(AColumn : TdxTreeListImageColumn) : Boolean;
Var
  AForm : TFdxTLImageValuesEdit;
  C, i, k : Integer;
begin
  Result := False;
  AForm := TFdxTLImageValuesEdit.Create(Nil);
  with AForm do
  begin
    Caption := AColumn.Name+'  (ImageIndexes, Values, Descriptions)';
    Images := AColumn.Images;
    ADefaultImages := AColumn.DefaultImages;

    with StringGrid do
    begin
      C := AColumn.Values.Count;
      while (C > 0) and (Trim(AColumn.Values[C-1])='') Do Dec(C);
      if (Images <> Nil) and (C < Images.Count) and AColumn.DefaultImages then
           C := Images.Count;
      for i := 0 to C - 1 do
      begin
        if AColumn.DefaultImages then
          k := i
        else
        try
          k := StrToInt(AColumn.ImageIndexes[i]);
        except
          k := -1;
        end;
        Cells[1, i+1] := IntToStr(k);
        if i < AColumn.Values.Count then
          Cells[2, i+1] := AColumn.Values[i];
        if i < AColumn.Descriptions.Count then
          Cells[3, i+1] := AColumn.Descriptions[i];
      end;
      if C < 1 then C := 1;
      RowCount := C + 1;
    end;
    SetImageIndexes;
    SetColumnWidths;
    ActiveControl := StringGrid;
    ShowModal;
    if (ModalResult = mrOk) then
    begin
      if AColumn.TreeList <> Nil then AColumn.TreeList.BeginUpdate;
      try
        AColumn.ImageIndexes.Clear;
        AColumn.Values.Clear;
        AColumn.Descriptions.Clear;
        with StringGrid do
        for i := 1 to RowCount - 1 do
        begin
          AColumn.ImageIndexes.Add(Cells[1, i]);
          AColumn.Values.Add(Cells[2, i]);
          AColumn.Descriptions.Add(Cells[3, i]);
        end;
        while (AColumn.Values.Count > 0) and
              (Trim(AColumn.Values[AColumn.Values.Count-1]) = '') do
          AColumn.Values.Delete(AColumn.Values.Count - 1);
        while (AColumn.Descriptions.Count > 0) and
              (Trim(AColumn.Descriptions[AColumn.Descriptions.Count-1]) = '') do
          AColumn.Descriptions.Delete(AColumn.Descriptions.Count - 1);
      finally
        if AColumn.TreeList <> nil then AColumn.TreeList.EndUpdate;
      end;
      Result := True;
    end;
  end;
  AForm.Free;
end;

{TExtStringGrid}
procedure TExtStringGrid.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if (Key = VK_ESCAPE) and EditorMode then
  begin
    if InplaceEditor.Modified then Cells[Col, Row] := FOldText
    else EditorMode := False;
  end; 
end;

function TExtStringGrid.CanEditShow: Boolean;
begin
  Result := inherited CanEditShow;
  if (Col = 1) and GetForm.ADefaultImages then
    Result := False;
end;

function TExtStringGrid.GetEditText(ACol, ARow: Longint): string;
begin
  Result := inherited GetEditText(ACol, ARow);
  FOldText := Result;
end;

procedure TExtStringGrid.SetEditText(ACol, ARow: Longint; const Value: string);
begin
  inherited SetEditText(ACol, ARow, Value);
  if (ACol = 1) then
    InvalidateCell(ACol-1, ARow);
end;

function TExtStringGrid.GetForm: TFdxTLImageValuesEdit;
begin
  Result := TFdxTLImageValuesEdit(GetParentForm(Self));
end;

procedure TExtStringGrid.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  inherited;
//  Message.Result := 1;
end;

procedure TExtStringGrid.WMSize(var Msg: TWMSize);
begin
  inherited;
  GetForm.SetColumnWidths;
end;

procedure TFdxTLImageValuesEdit.BAddClick(Sender: TObject);
begin
  with StringGrid do
  begin
    RowCount := RowCount + 1;
    if ADefaultImages then
      Cells[1, RowCount-1] := IntToStr(RowCount-2)
    else Cells[1, RowCount-1] := '-1';
    if ADefaultImages then
      SetImageIndexes;
    Row := RowCount-1;   
  end;
end;

procedure TFdxTLImageValuesEdit.SetImageIndexes;
var
  i: Integer;
begin
  if ADefaultImages then
  with StringGrid do
    for i := 1 to RowCount - 1 do
      Cells[1, i] := IntToStr(i - 1);
end;

procedure TFdxTLImageValuesEdit.BDeleteClick(Sender: TObject);
var
  i, j: Integer;
begin
  with StringGrid do
  begin
    // move data
    if Row < (RowCount - 1) then
      for i := Row to RowCount - 2 do
        for j := 0 to ColCount - 1 do
          Cells[j, i] := Cells[j, i+1];
    // clear
    for j := 0 to ColCount - 1 do
      Cells[j, RowCount-1] := '';
    if RowCount > 2 then
      RowCount := RowCount - 1;
    if ADefaultImages then
      SetImageIndexes;
  end;
end;

procedure TFdxTLImageValuesEdit.BInsertClick(Sender: TObject);
var
  i, j: Integer;
begin
  with StringGrid do
  begin
    RowCount := RowCount + 1;
    // move data
    for i := RowCount - 2 downto Row do
      for j := 0 to ColCount - 1 do
        Cells[j, i+1] := Cells[j, i];
    // clear
    for i := 0 to ColCount - 1 do
      Cells[i, Row] := '';

    if ADefaultImages then
      SetImageIndexes
    else Cells[1, Row] := '-1';
  end;
end;

// protected TFdxTLImageValuesEdit
procedure TFdxTLImageValuesEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
    if AComponent = Images then Images := nil;
end;

// private TFdxTLImageValuesEdit
procedure TFdxTLImageValuesEdit.SetImages(Value: TImageList);
begin
  FImages := Value;
  if Value <> nil then
    Value.FreeNotification(Self);

  if StringGrid <> nil then
  with StringGrid do
  begin
    // calc size
    Canvas.Font := Font;
    DefaultRowHeight := Canvas.TextHeight('Wg') + 4;
    if (Images <> nil) and (Images.Height > DefaultRowHeight) then
      DefaultRowHeight := Images.Height;
    RowHeights[0] := Canvas.TextHeight('Wg') + 4 + 2;
    StringGrid.Invalidate;
  end;
end;

procedure TFdxTLImageValuesEdit.WMGetMinMaxInfo(var Message : TWMGetMinMaxInfo);
begin
  Message.MinMaxInfo^.ptMinTrackSize := Point(300, 300);
  inherited;
end;

procedure TFdxTLImageValuesEdit.SetColumnWidths;
const
  col1 = 50;
  col2 = 50;
  colTotal = 50 + 50 + 100;
var
  W: Integer;
begin
  if StringGrid <> nil then
  with StringGrid do
  begin
    // calc size
    if Images <> nil then
      ColWidths[0] := Images.Width;
    W := ClientWidth - ColWidths[0];
    // Col Widths
    ColWidths[1] := (col1 * W ) div colTotal;
    ColWidths[2] := (col2 * W ) div colTotal;
    ColWidths[3] := W - ColWidths[1] - ColWidths[2] - ColCount;
  end;
end;

procedure TFdxTLImageValuesEdit.StringGridDrawCell(Sender: TObject; Col,
  Row: LongInt; Rect: TRect; State: TGridDrawState);
var
  Text: String;
  Index: Integer;
begin
  if StringGrid <> nil then
  with StringGrid.Canvas do
  begin
    Font := StringGrid.Font;
    if (Row = 0) then
    begin
      Brush.Color := clBtnFace;
      FillRect(Rect);
      DrawEdge(Handle, Rect, BDR_RAISEDINNER, BF_BOTTOMRIGHT);
      DrawEdge(Handle, Rect, BDR_RAISEDINNER, BF_TOPLEFT);
      InflateRect(Rect, -1, -1);
    end
    else
    begin
      if (gdSelected in State) and (Row > 0) then
      begin
        Brush.Color := clHighlight;
        Font.Color := clHighlightText;
      end
      else
        Brush.Color := StringGrid.Color;
    end;
    if (Col = 0) and (Row > 0) then
    begin
      // image
      FillRect(Rect);
      try
        Index := StrToInt(StringGrid.Cells[1, Row]);
      except
        Index := -1;
      end;
      if (Images <> nil) and
        (Index >= 0) and (Index < Images.Count) then
        Images.Draw(StringGrid.Canvas, Rect.Left, Rect.Top, Index);
    end
    else
    begin
      Text := StringGrid.Cells[Col, Row];
      ExtTextOut(Handle, Rect.Left + 2, Rect.Top + 2, ETO_CLIPPED or
         ETO_OPAQUE, @Rect, PChar(Text), Length(Text), nil);
      if (gdFocused in State) then
        DrawFocusRect(Rect);
    end;
  end;
end;

procedure TFdxTLImageValuesEdit.FormCreate(Sender: TObject);
begin
  StringGrid := TExtStringGrid.Create(Self);
  with StringGrid do
  begin
    Visible := False;
    Parent := Self;
    // properties
    Align := alClient;
    ColCount := 4;
    Ctl3D := True;
    DefaultDrawing := False;
    Options := [goFixedVertLine, goFixedHorzLine, goVertLine,
      goHorzLine, goDrawFocusSelected, goEditing, goThumbTracking];
    ParentCtl3D := False;
    RowCount := 2;
    ScrollBars := ssVertical;
    OnDrawCell := StringGridDrawCell;
    // Captions
    Cells[1, 0] := 'Image Index';
    Cells[2, 0] := 'Value';
    Cells[3, 0] := 'Description';
    // size
    Canvas.Font := Font;
    DefaultRowHeight := Canvas.TextHeight('Wg') + 4;
    Visible := True;
  end;
end;

end.
