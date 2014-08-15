
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressQuantumGrid SummaryGroups Wizard                     }
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

unit dxWzSmGr;

interface

{$I dxTLVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, dxWizard, dxCntner, dxTL, dxTLClms, DB, dxDBCtrl;

type
  TFSmGrWizard = class(TForm)
    pnStyle: TPanel;
    pnButtons: TPanel;
    BBack: TButton;
    BNext: TButton;
    BCancel: TButton;
    Bevel: TBevel;
    Panel34: TPanel;
    rbGroupNode: TRadioButton;
    rbRowFooter: TRadioButton;
    Image1: TImage;
    Image2: TImage;
    Bevel2: TBevel;
    Bevel3: TBevel;
    pnItems1: TPanel;
    sbMoveLeft: TSpeedButton;
    sbMoveRight: TSpeedButton;
    cbAllFields: TCheckBox;
    pnName: TPanel;
    Panel1: TPanel;
    ESummaryGroupName: TEdit;
    Label5: TLabel;
    cbDefault: TCheckBox;
    imHint1: TImage;
    Memo1: TMemo;
    GroupBox1: TGroupBox;
    TL_Fields1: TdxTreeList;
    GroupBox2: TGroupBox;
    TL_SummaryItems1: TdxTreeList;
    colSummaryField: TdxTreeListPickColumn;
    colSummaryFormat: TdxTreeListPickColumn;
    colSummaryType: TdxTreeListImageColumn;
    pnItems2: TPanel;
    sbMoveLeft2: TSpeedButton;
    sbMoveRight2: TSpeedButton;
    GroupBox3: TGroupBox;
    TL_Columns: TdxTreeList;
    GroupBox4: TGroupBox;
    TL_SummaryItems2: TdxTreeList;
    colFieldName2: TdxTreeListPickColumn;
    colSummaryFormat2: TdxTreeListPickColumn;
    colSummaryType2: TdxTreeListImageColumn;
    colColumnName2: TdxTreeListPickColumn;
    colFieldName: TdxTreeListColumn;
    dxTreeListColumn2: TdxTreeListColumn;
    procedure FormCreate(Sender: TObject);
    procedure BBackClick(Sender: TObject);
    procedure BNextClick(Sender: TObject);
    procedure cbAllFieldsClick(Sender: TObject);
    procedure TL_Fields1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TL_Fields1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure sbMoveRightClick(Sender: TObject);
    procedure sbMoveLeftClick(Sender: TObject);
    procedure TL_SummaryItems1DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure TL_SummaryItems1DragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure sbMoveRight2Click(Sender: TObject);
    procedure TL_ColumnsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TL_ColumnsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure sbMoveLeft2Click(Sender: TObject);
    procedure TL_SummaryItems2DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure TL_SummaryItems2DragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure TL_Fields1DblClick(Sender: TObject);
    procedure TL_ColumnsDblClick(Sender: TObject);
  private
    Panels: array [0..PanelCount - 1] of TPanel;
    CurrentPanel: TPanel;
    procedure ShowPanel(Panel: TPanel);
  public
    Wizard: TFGrWizard;
  end;

function ShowSummaryGroupWizard(AGrWizard: TFGrWizard): Boolean;

implementation

{$R *.DFM}

uses
  dxDBGrid;

const
  PanelCount = 4;

function ShowSummaryGroupWizard(AGrWizard: TFGrWizard): Boolean;
var
  AForm: TFSmGrWizard;
  AGroup: TdxDBGridSummaryGroup;
  AItem: TdxDBGridSummaryItem;
  I: Integer;
begin
  Result := False;
  AForm := TFSmGrWizard.Create(AGrWizard);
  with AForm do
  begin
     Wizard := AGrWizard;
//     Height := 270;
     ClientHeight := pnStyle.Height + Bevel.Height + pnButtons.Height + 6*2;
     Left := AGrWizard.Left;
     Top := AGrWizard.Top + AGrWizard.Height - Height;
//     Width := AGrWizard.Width;
     Width := pnStyle.Width + 2*6;
     if ShowModal <> mrCancel then
     begin
       // Add Summary Group
       AGroup := Wizard.DBGrid.SummaryGroups.Add;
       if not rbRowFooter.Checked then // standard
       begin
         with TL_SummaryItems1 do
         begin
           for I := 0 to Count - 1 do
           begin
             AItem := AGroup.SummaryItems.Add;
             AItem.SummaryField := Items[I].Values[colSummaryField.Index];
             AItem.SummaryFormat := Items[I].Values[colSummaryFormat.Index];
             if (Items[I].Values[colSummaryType.Index] <> '') and
               (Items[I].Values[colSummaryType.Index] <> '0') then
               AItem.SummaryType := TdxSummaryType(StrToInt(Items[I].Values[colSummaryType.Index]));
           end;
         end;
       end
       else
       begin
         with TL_SummaryItems2 do
         begin
           for I := 0 to Count - 1 do
           begin
             AItem := AGroup.SummaryItems.Add;
             AItem.ColumnName := TdxDBGridColumn(Items[I].Data).Name;
             AItem.SummaryField := Items[I].Values[colFieldName2.Index];
             AItem.SummaryFormat := Items[I].Values[colSummaryFormat2.Index];
             if (Items[I].Values[colSummaryType2.Index] <> '') and
               (Items[I].Values[colSummaryType2.Index] <> '0') then
               AItem.SummaryType := TdxSummaryType(StrToInt(Items[I].Values[colSummaryType2.Index]));
           end;
         end;
       end;
       AGroup.DefaultGroup := cbDefault.Checked;
       try
         AGroup.Name := ESummaryGroupName.Text;
       except
       end;
       Result := True;
     end;
     Free;
  end;
end;

procedure TFSmGrWizard.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  Caption := 'SummaryGroup Wizard';
  // Load Panels
  Panels[0] := pnStyle;
  Panels[1] := pnItems1;
  Panels[2] := pnItems2;
  Panels[3] := pnName;
  for I := 0 to PanelCount - 1 do
  begin
    Panels[I].Left := 6;
    Panels[I].Top := 6;
  end;
  // Start
  ShowPanel(pnStyle);
end;

procedure TFSmGrWizard.ShowPanel(Panel: TPanel);
var
  I: Integer;
  Node: TdxTreeListNode;
begin
  case Panel.Tag of
  0: begin {Style}
     end;
  1: begin {Items1}
        // load fields
        cbAllFieldsClick(nil);
     end;
  2: begin {Item2}
        with TL_Columns do
        begin
          colColumnName2.Items.Clear;
          ClearNodes;
          for I := 0 to Wizard.DBGrid.ColumnCount - 1 do
          begin
            Node := Add;
            Node.Data := Wizard.DBGrid.Columns[I];
            Node.Values[0] := GetColumnCaption(Wizard.DBGrid.Columns[I]);
            colColumnName2.Items.Add(Node.Values[0]);
          end;
        end;
        with colFieldName2.Items do
        begin
          Clear;
          if Assigned(Wizard.DBGrid.DataLink.DataSet) then
            for I := 0 to Wizard.DBGrid.DataLink.DataSet.FieldCount - 1 do
              Add(Wizard.DBGrid.DataLink.DataSet.Fields[I].FieldName);
        end;
     end;
  3: begin {Finish}
       if ESummaryGroupName.Text = '' then
         ESummaryGroupName.Text := Wizard.DBGrid.Name + 'SummaryGroup' + IntToStr(Wizard.DBGrid.SummaryGroups.Count + 1);
     end;
  end;
  CurrentPanel := Panel;
  // SetButtons;
  BBack.Enabled := CurrentPanel.Tag <> 0;
  if CurrentPanel.Tag = (PanelCount - 1) then
  begin
    BNext.Caption := '&Finish';
    BNext.ModalResult := mrOK;
  end
  else
  begin
    BNext.Caption := '&Next >';
    BNext.ModalResult := mrNone;
  end;
  BNext.Default := CurrentPanel.Tag in [0, 3];
  Panel.Visible := True;
  // hide other panels
  for I := 0 to PanelCount - 1 do
  begin
    if Panels[I] <> Panel then
      Panels[I].Visible := False;
  end;
end;

// Back
procedure TFSmGrWizard.BBackClick(Sender: TObject);
begin
  if CurrentPanel.Tag = 3 then
  begin
    if rbRowFooter.Checked then
      ShowPanel(Panels[2])
    else ShowPanel(Panels[1]);
  end
  else 
  if CurrentPanel.Tag = 2 then
    ShowPanel(Panels[0])
  else ShowPanel(Panels[CurrentPanel.Tag - 1]);
end;

procedure TFSmGrWizard.BNextClick(Sender: TObject);
begin
  if CurrentPanel.Tag < PanelCount - 1 then
  begin
    if CurrentPanel.Tag = 1 then
      ShowPanel(Panels[3])
    else
    if (CurrentPanel.Tag = 0) and rbRowFooter.Checked then
      ShowPanel(Panels[2])
    else ShowPanel(Panels[CurrentPanel.Tag + 1]);
  end;
end;

//Events
procedure TFSmGrWizard.cbAllFieldsClick(Sender: TObject);
var
  I: Integer;
begin
  with TL_Fields1 do
  begin
     ClearNodes;
     if Assigned(Wizard.DBGrid.DataLink.DataSet) then
       for I := 0 to Wizard.DBGrid.DataLink.DataSet.FieldCount - 1 do
         if cbAllFields.Checked or (Wizard.DBGrid.DataLink.DataSet.Fields[I] is TNumericField) or
           (Wizard.DBGrid.DataLink.DataSet.Fields[I].DataType in [ftDate, ftTime, ftDateTime]) then
         Add.Values[0] :=(Wizard.DBGrid.DataLink.DataSet.Fields[I].FieldName);
  end;
end;

procedure TFSmGrWizard.sbMoveRightClick(Sender: TObject);
begin
  TL_SummaryItems1.DeleteSelection;
end;

procedure TFSmGrWizard.TL_Fields1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source = TL_SummaryItems1;
end;

procedure TFSmGrWizard.TL_Fields1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  if Source = TL_SummaryItems1 then
    sbMoveRightClick(nil);
end;

procedure TFSmGrWizard.sbMoveLeftClick(Sender: TObject);
var
  Node: TdxTreeListNode;
  I: Integer;
begin
  with TL_Fields1 do
  begin
    for I := 0 to SelectedCount - 1 do
    begin
      Node := TL_SummaryItems1.Add;
      Node.Values[colSummaryField.Index] := SelectedNodes[I].Values[0];
      Node.Values[colSummaryType.Index] := '1';
    end;
    ClearSelection;
  end;
end;

procedure TFSmGrWizard.TL_SummaryItems1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source = TL_Fields1;
end;

procedure TFSmGrWizard.TL_SummaryItems1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  if Source = TL_Fields1 then
    sbMoveLeftClick(nil);
end;

procedure TFSmGrWizard.sbMoveRight2Click(Sender: TObject);
begin
  TL_SummaryItems2.DeleteSelection;
end;

procedure TFSmGrWizard.TL_ColumnsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source = TL_SummaryItems2;
end;

procedure TFSmGrWizard.TL_ColumnsDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  if Source = TL_SummaryItems2 then
    sbMoveRight2Click(nil);
end;

procedure TFSmGrWizard.sbMoveLeft2Click(Sender: TObject);
var
  Node: TdxTreeListNode;
  I: Integer;
begin
  with TL_Columns do
  begin
    for I := 0 to SelectedCount - 1 do
    begin
      Node := TL_SummaryItems2.Add;
      Node.Values[colColumnName2.Index] := SelectedNodes[I].Values[0];
      Node.Data := SelectedNodes[I].Data;
      Node.Values[colSummaryType2.Index] := '1';
    end;
    ClearSelection;
  end;
end;

procedure TFSmGrWizard.TL_SummaryItems2DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source = TL_Columns;
end;

procedure TFSmGrWizard.TL_SummaryItems2DragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  if Source = TL_Columns then
    sbMoveLeft2Click(nil);
end;

procedure TFSmGrWizard.TL_Fields1DblClick(Sender: TObject);
begin
  sbMoveLeftClick(nil);
end;

procedure TFSmGrWizard.TL_ColumnsDblClick(Sender: TObject);
begin
  sbMoveLeft2Click(nil);
end;

end.

