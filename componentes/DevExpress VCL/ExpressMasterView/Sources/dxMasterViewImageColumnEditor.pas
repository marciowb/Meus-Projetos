
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressMasterView image column editor                       }
{                                                                   }
{       Copyright (c) 1999-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSMASTERVIEW AND ALL            }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM      }
{   ONLY.                                                           }
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

unit dxMasterViewImageColumnEditor;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, dxMasterViewColumns;

type
  TfrmImageColumnEditor = class(TForm)
    ButtonOk: TButton;
    ButtonCancel: TButton;
    ButtonAdd: TButton;
    ButtonDelete: TButton;
    Grid: TStringGrid;
    ButtonInsert: TButton;
    procedure ButtonAddClick(Sender: TObject);
    procedure ButtonInsertClick(Sender: TObject);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; Col, Row: Integer; Rect: TRect; State: TGridDrawState);
    procedure GridSelectCell(Sender: TObject; Col, Row: Integer; var CanSelect: Boolean);
    procedure GridSetEditText(Sender: TObject; ACol, ARow: Integer; const Value: string);
    procedure GridGetEditText(Sender: TObject; ACol, ARow: Integer; var Value: String);
    procedure FormShow(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FColumn: TdxMasterViewImageColumn;
    FPrevCellText: string;
  end;

function EditImageColumnItems(AColumn: TdxMasterViewImageColumn): Boolean;

implementation

{$R *.DFM}

uses
  dxMasterViewStrs;

type
  TDummyGrid = class(TStringGrid);

function EditImageColumnItems(AColumn: TdxMasterViewImageColumn): Boolean;
var
  I, AImageIndex: Integer;
begin
  with TfrmImageColumnEditor.Create(nil) do
  begin
    FColumn := AColumn;
    with Grid do
    begin
      if AColumn.Images <> nil then ColWidths[0] := AColumn.Images.Width;
      ColWidths[3] := ClientWidth - 1 - //GetSystemMetrics(SM_CXVSCROLL) -
        (ColWidths[0] + 1 + ColWidths[1] + 1 + ColWidths[2] + 1);
      if AColumn.Images <> nil then
        DefaultRowHeight := AColumn.Images.Height
      else
        DefaultRowHeight := 20;
      RowHeights[0] := 20;
      if AColumn.Items.Count = 0 then
      begin
        RowCount := 2;
        Cells[2, 1] := '-1';
      end
      else
        RowCount := 1 + AColumn.Items.Count;
      Cells[1, 0] := LoadStr(dxsMVImageColumnEditorValueText);
      Cells[2, 0] := LoadStr(dxsMVImageColumnEditorImageIndexText);
      Cells[3, 0] := LoadStr(dxsMVImageColumnEditorDescriptionIndex);
      for I := 0 to AColumn.Items.Count - 1 do
      begin
        Cells[1, I + 1] := AColumn.Items.Values[I];
        Cells[2, I + 1] := IntToStr(AColumn.Items.ImageIndexes[I]);
        Cells[3, I + 1] := AColumn.Items.Descriptions[I];
      end;
    end;
    Result := ShowModal = mrOk;
    if Result then
      with Grid do
      begin
        AColumn.Items.BeginUpdate;
        try
          if (RowCount > 2) or (Cells[2, 1] <> '-1') then
          begin
            AColumn.Items.Count := RowCount - 1;
            for I := 1 to RowCount - 1 do
            begin
              try
                AImageIndex := StrToInt(Cells[2, I]);
              except
                AImageIndex := -1;
              end;
              AColumn.Items.Change(I - 1, Cells[1, I], AImageIndex, Cells[3, I]);
            end;
          end
          else
            AColumn.Items.Clear;
        finally
          AColumn.Items.EndUpdate;
        end;
      end;
    Free;
  end;
end;

procedure TfrmImageColumnEditor.ButtonAddClick(Sender: TObject);
var
  AImageIndex: Integer;
begin
  with TDummyGrid(Grid) do
  begin
    RowCount := RowCount + 1;
    try
      AImageIndex := StrToInt(Cells[2, RowCount - 2]);
      if AImageIndex > -1 then Inc(AImageIndex);
    except
      AImageIndex := -1;
    end;  
    Cells[1, RowCount - 1] := '';
    Cells[2, RowCount - 1] := IntToStr(AImageIndex);
    Cells[3, RowCount - 1] := '';
    InvalidateCell(0, RowCount - 1);
    Row := RowCount - 1;
  end;
end;

procedure TfrmImageColumnEditor.ButtonInsertClick(Sender: TObject);
var
  PrevRow, I: Integer;
begin
  if Grid.Row < 1 then Exit;
  with TDummyGrid(Grid) do
  begin
    PrevRow := Row;
    RowCount := RowCount + 1;
    for I := RowCount - 2 downto Row do MoveRow(I, I + 1);
    Cells[1, PrevRow] := '';
    Cells[2, PrevRow] := '-1';
    Cells[3, PrevRow] := '';
    InvalidateCell(0, PrevRow);
    Row := PrevRow;
  end;
end;

procedure TfrmImageColumnEditor.ButtonDeleteClick(Sender: TObject);
var
  PrevRow: Integer;
begin
  with TDummyGrid(Grid) do
    if Row > 0 then
    begin
      PrevRow := Row;
      if RowCount > 2 then DeleteRow(Row)
      else
      begin
        Cells[1, 1] := '';
        Cells[2, 1] := '-1';
        Cells[3, 1] := '';
        InvalidateCell(0, 1);
      end;
      if PrevRow <= RowCount - 1 then
        Row := PrevRow
      else
        Row := RowCount - 1;
    end;
end;

procedure TfrmImageColumnEditor.GridDrawCell(Sender: TObject;
  Col, Row: Integer; Rect: TRect; State: TGridDrawState);
var
  AImageIndex: Integer;
begin
  if (Col = 0) and (Row > 0) and (FColumn.Images <> nil) then
  begin
    try
      AImageIndex := StrToInt(Grid.Cells[2, Row]);
    except
      AImageIndex := -1;
    end;
    if (0 <= AImageIndex) and (AImageIndex < FColumn.Images.Count) then
      FColumn.Images.Draw(Grid.Canvas, Rect.Left, Rect.Top, AImageIndex)
    else
      Grid.Canvas.FillRect(Rect);
  end;
end;

procedure TfrmImageColumnEditor.GridSelectCell(Sender: TObject;
  Col, Row: Integer; var CanSelect: Boolean);
begin
  if Col = 0 then CanSelect := False;
end;

procedure TfrmImageColumnEditor.FormShow(Sender: TObject);
begin
  Grid.Col := 1;
end;

procedure TfrmImageColumnEditor.GridSetEditText(Sender: TObject;
  ACol, ARow: Integer; const Value: string);
begin
  TDummyGrid(Grid).InvalidateCell(0, ARow);
end;

procedure TfrmImageColumnEditor.GridKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE:
      with Grid do
        if EditorMode then
          if Cells[Col, Row] <> FPrevCellText then
            Cells[Col, Row] := FPrevCellText
          else
            EditorMode := False;
    VK_INSERT:
      if not Grid.EditorMode then ButtonAdd.Click;
    VK_DELETE:
      if not Grid.EditorMode then ButtonDelete.Click;
  end;
end;

procedure TfrmImageColumnEditor.GridGetEditText(Sender: TObject;
  ACol, ARow: Integer; var Value: String);
begin
  FPrevCellText := Grid.Cells[ACol, ARow]; 
end;

end.
