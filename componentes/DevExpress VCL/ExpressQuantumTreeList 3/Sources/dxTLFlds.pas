
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressDBTreeListControl columns wizard                     }
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

unit dxTLFlds;

interface

{$I dxTLVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, dxTL, DB, dxCntner, dxEditor, dxDBCtrl, dxTLClms,
  dxDBTL;

type

{TFdxTreeListFields}
TFDBTreeListFields = class(TForm)
  Panel1: TPanel;
  BOk: TButton;
  BCancel: TButton;
  Panel2: TPanel;
  BHelp: TButton;
  BDelete: TButton;
  Wizard: TdxTreeList;
  colFieldName: TdxTreeListColumn;
  colColumnClass: TdxTreeListPickColumn;
  colVisible: TdxTreeListCheckColumn;
  procedure BDeleteClick(Sender: TObject);
  procedure WizardKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
private
  procedure WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
public
  ColumnOwner: TComponent;
  DBTreeList: TCustomdxDBTreeList;
end;

procedure GenerateColumnName(Col: TdxDBTreeListColumn);
function ShowdxDBFieldsEditor(ADBTreeList: TCustomdxDBTreeList; AColumnOwner: TComponent): Boolean;

implementation

{$R *.DFM}

uses dxDTLReg{$IFNDEF DELPHI6}, DsgnIntf{$ELSE}, DesignIntf, DesignEditors{$ENDIF};

function TrimAll(const S: string): string;
const
  ValidChar = ['A'..'Z', 'a'..'z', '_', '0'..'9'];
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(S) do
    if S[i] in ValidChar then Result := Result + S[i];
end;

procedure GenerateColumnName(Col: TdxDBTreeListColumn);
begin
  try
    with Col do Name := ATreeList.Name + TrimAll(FieldName);
  except
    on EComponentError do {Ignore rename errors };
  end;
end;

function ShowdxDBFieldsEditor(ADBTreeList: TCustomdxDBTreeList; AColumnOwner: TComponent): Boolean;
var
  AForm: TFDBTreeListFields;
  I: Integer;
  C: TdxDBTreeListColumnClass;
  Res: Integer;
  Column: TdxDBTreeListColumn;
begin
  Result := False;
  AForm := TFDBTreeListFields.Create(nil);
  with AForm do
  begin
    DBTreeList := ADBTreeList;
    ColumnOwner := AColumnOwner;
    // load columns classes
    with colColumnClass.Items do
    begin
      Clear;
      Add('None');
      for I := 0 to DBTreeListColumns.Count - 1 do
        Add(DBTreeListColumns[I]);
      colColumnClass.DropDownRows := colColumnClass.Items.Count;
    end;
    // load items
    if DBTreeList <> nil then
      with DBTreeList do
        if Assigned(DataLink.DataSet) then
        begin
          for I := 0 to DataLink.DataSet.FieldCount - 1 do
          begin
            Wizard.Add;
            Wizard.Items[I].Values[0] := DataLink.DataSet.Fields[I].FieldName;
            Wizard.Items[I].Values[1] :=
              DBTreeList.GetDefaultFieldColumnClass(DataLink.DataSet.Fields[I]).ClassName;
            if DataLink.DataSet.Fields[I].Visible then
              Wizard.Items[I].Values[2] := 'True'
            else Wizard.Items[I].Values[2] := 'False';
          end;
        end;
    if Wizard.Count > 0 then Wizard.FocusedColumn := 1;
    // show
    if ShowModal = mrOK then
    begin
      with DBTreeList do
      begin
        if ColumnCount > 0 then
          Res := MessageBox(Handle, 'Delete existing columns?', 'Confirm', MB_ICONQUESTION or MB_YESNO)
        else Res := ID_NO;
        BeginUpdate;
        try
          if Res = ID_YES then
            DestroyColumns;
          if Assigned(DataSource) and Assigned(DataSource.DataSet) then
          begin
            for I := 0 to Wizard.Count - 1 do
            begin
              C := TdxDBTreeListColumnClass(GetClass(Wizard.Items[I].Values[1]));
              if C <> nil then
              begin
                Column := CreateColumnEx(C, ColumnOwner);
                Column.FieldName := Wizard.Items[I].Values[0];
                Column.Visible := Wizard.Items[I].Values[2] = 'True';
                // generate column name
                GenerateColumnName(Column);
              end;
            end;
          end;
        finally
          EndUpdate;
        end;
      end;
      Result := True;
    end;
  end;
  AForm.Free;
end;

{TFdxTreeListFields}
procedure TFDBTreeListFields.WMGetMinMaxInfo(var Message : TWMGetMinMaxInfo);
begin
  Message.MinMaxInfo^.ptMinTrackSize := Point(300, 200);
  inherited;
end;

procedure TFDBTreeListFields.BDeleteClick(Sender: TObject);
var
  Key: Word;
begin
  Key := VK_DELETE;
  WizardKeyDown(nil, Key, [ssCtrl]);
end;

procedure TFDBTreeListFields.WizardKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Node: TdxTreeListNode;
begin
  with Wizard do
  if (Key = VK_DELETE) and (ssCtrl in Shift) and (FocusedNode <> nil) then
  begin
    Node := GetNextVisible(FocusedNode);
    FocusedNode.Free;
    if Node <> nil then
      Node.Focused := True;
    if FocusedNode <> nil then FocusedNode.MakeVisible;
  end;
end;

end.
