
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressInspector data-aware rows editor                     }
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

unit dxDBInEd;

interface

{$I dxInsVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxCntner, dxDBInsp, StdCtrls, ExtCtrls, Menus, dxInspct, dxInspEd{$IFNDEF DELPHI6},
  DsgnIntf{$ELSE}, DesignIntf, DesignEditors{$ENDIF};

type
  TdxDBInspectorEditForm = class(TdxInspectorEditForm)
    BWizard: TButton;
    miAddAllFields: TMenuItem;
    dxDBInspector: TdxDBInspector;
    N2: TMenuItem;
    procedure BAddClick(Sender: TObject);
    procedure BDeleteClick(Sender: TObject);
    procedure BChangeClick(Sender: TObject);
    procedure BWizardClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  protected
    procedure PrepareCloneInspector; override;
    procedure SelectRow(ARow: TdxInspectorRow); override;
  public
    DBInspector: TdxDBInspector;
  end;

  { TdxDBInspectorDesigner }

  TdxDBInspectorDesigner = class(TdxTextInspectorDesigner)
  public
    procedure LayoutChanged; override;
  end;

procedure ShowdxDBInspectorEditor(ADBInspector: TdxDBInspector; ADesigner: Pointer);

implementation

{$R *.DFM}

uses dxInRowA, dxInsReg;

function TrimAll(const S: string): string;
const
  ValidChar = ['A'..'Z', 'a'..'z', '_', '0'..'9'];
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(S) do
    if S[I] in ValidChar then
      Result := Result + S[I];
end;

procedure GenerateRowName(ARow: TdxInspectorRow);
begin
  try
    with ARow do
      Name := Inspector.Name + TrimAll(LinkObjectName);
  except
    on EComponentError do; // Ignore rename errors
  end;
end;

procedure ShowdxDBInspectorEditor(ADBInspector: TdxDBInspector; ADesigner: Pointer);
var
  AForm: TdxDBInspectorEditForm;
begin
  if ADBInspector.Designer <> nil then
  begin
     TdxDBInspectorDesigner(ADBInspector.Designer).DesignerForm.Show;
     Exit;
  end;
  AForm := TdxDBInspectorEditForm.Create(nil);
  AForm.DBInspector := ADBInspector;
  TdxDBInspectorDesigner.Create(ADBInspector).DesignerForm := AForm;
  with AForm do
  begin
    TextInspector := TdxDesignInspectorControl(DBInspector);
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
    Caption := 'Editing ' + DBInspector.Name + '.Rows';
    Show;
  end;
end;

procedure TdxDBInspectorDesigner.LayoutChanged;
begin
  if (DesignerForm <> nil) and not DesignerForm.LockUpdate then
    with TdxDBInspectorEditForm(DesignerForm) do
      if (DBInspector.DataSource = nil) or (DBInspector.DataSource.DataSet = nil) then
        dxDBInspector.DataSource := nil;
  inherited LayoutChanged;
end;

{ TdxDBInspectorEditForm }

procedure TdxDBInspectorEditForm.PrepareCloneInspector;
begin
  dxDBInspector.Color := DBInspector.Color;
  dxDBInspector.Font.Assign(DBInspector.Font);
  dxDBInspector.GridColor := DBInspector.GridColor;
  dxDBInspector.Options := dxDBInspector.Options - [dioEditing];
  dxDBInspector.PaintStyle := DBInspector.PaintStyle;
  dxDBInspector.DataSource := DBInspector.DataSource;
  if DBInspector.DefaultFields then
    dxDBInspector.ClearRows
  else
    dxDBInspector.AssignRows(DBInspector);
end;

procedure TdxDBInspectorEditForm.SelectRow(ARow: TdxInspectorRow);
begin
  inherited SelectRow(ARow);
  BWizard.Enabled := (dxDBInspector.DataSource <> nil) and
    (dxDBInspector.DataSource.DataSet <> nil) and
    (dxDBInspector.DataSource.DataSet.FieldCount > 0);
  miAddAllFields.Enabled := BWizard.Enabled;
end;

procedure TdxDBInspectorEditForm.BAddClick(Sender: TObject);
var
  ARowClass: TdxInspectorRowClass;
  P: TPoint;
begin
  P := Point(BAdd.Left + BAdd.Width, BAdd.Top);
  P := ClientToScreen(P);
  ARowClass := SelectdxInspectorRow(P.X, P.Y, '', DBInspectorRows);
  if (ARowClass <> nil) and (DBInspector <> nil) then
  begin
    DBInspector.DefaultFields := False;
    DBInspector.CreateRow(ARowClass);
    FillList;
    with dxInspector do
      if Count > 0 then Items[Count - 1].Focused := True;
    // select component
    SelectInspector(False);
  end;
end;

procedure TdxDBInspectorEditForm.BDeleteClick(Sender: TObject);
begin
  inherited;
  if (DBInspector <> nil) and (dxDBInspector.Count = 0) then
    DBInspector.DefaultFields := True;
end;

procedure TdxDBInspectorEditForm.BChangeClick(Sender: TObject);
var
  ARowClass: TdxInspectorRowClass;
  P: TPoint;
  APrevName: string;
  APrevIndex: Integer;
  ARow, ANewRow, APrevRow: TdxInspectorRow;
begin
  ARow := GetSelectedRow;
  if (DBInspector = nil) or (ARow = nil) then Exit;
  P := Point(BChange.Left + BChange.Width, BChange.Top );
  P := ClientToScreen(P);
  if ARow <> nil then
    APrevName := ARow.ClassName
  else
    APrevName := '';
  ARowClass := SelectdxInspectorRow(P.X, P.Y, APrevName, DBInspectorRows);
  if (ARowClass <> nil) and (ARowClass.ClassName <> APrevName) then
  begin
    UnSelectAll;
    if ListBoxActive then
      APrevIndex := LHidden.ItemIndex
    else
      APrevIndex := dxDBInspector.FocusedNumber;
    APrevRow := DBInspector.RowByName(ARow.Name);
    ANewRow := DBInspector.CreateRow(ARowClass);
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
    if ListBoxActive then
      LHidden.ItemIndex := APrevIndex
    else
      dxDBInspector.FocusedNumber := APrevIndex;
    // select component
    SelectInspector(ListBoxActive);
  end;
end;

// add all fields
procedure TdxDBInspectorEditForm.BWizardClick(Sender: TObject);
var
  Title, Msg: string;
  ARow: TdxInspectorRow;
  I: Integer;
begin
  if DBInspector <> Nil then
  begin
    LockUpdate := True;
    try
      UnSelectAll;
      if dxDBInspector.TotalRowCount > 0 then // confirm
      begin
        Title := 'Confirm'{LoadStr(dxSTitleWarning)};
        Msg := 'Delete existing rows?'{LoadStr(dxSDeleteRecordQuestion)};
        case MessageBox(Self.Handle, PChar(Msg), PChar(Title),
          MB_ICONQUESTION or MB_YESNOCANCEL) of
          ID_YES:
            DBInspector.ClearRows;
          ID_CANCEL:
            Exit; // go to finally
        end;
      end
      else
        DBInspector.DefaultFields := False;
      // add fields
      if (DBInspector.DataSource <> nil) and
         (DBInspector.DataSource.DataSet <> nil) then
        with DBInspector.DataSource.DataSet, DBInspector do
        begin
          for I := 0 to FieldCount - 1 do
          begin
            ARow := CreateRow(GetDefaultDBInspectorRowClass(Fields[I]));
            ARow.LinkObjectName := Fields[I].FieldName;
            // generate row name
            GenerateRowName(ARow);
            if not Fields[I].Visible then
              ARow.Visible := False;
          end;
        end;
      FillList;
      with dxDBInspector do
        if Count > 0 then
          Items[Count - 1].Focused := True;
      dxInspectorClick(nil);
      UpdateDesigner;
    finally
      LockUpdate := False;
    end;
  end;
end;

procedure TdxDBInspectorEditForm.FormCreate(Sender: TObject);
begin
  inherited;
  dxDBInspector.Align := alClient;
  dxInspector := TdxInspector(dxDBInspector); // ! 
end;

end.
