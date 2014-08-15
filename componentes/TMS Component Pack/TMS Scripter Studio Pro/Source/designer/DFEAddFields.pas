unit DFEAddFields;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB;

type
  TfmDFEAddFields = class(TForm)
    gbFields: TGroupBox;
    btOk: TButton;
    btCancel: TButton;
    lsFieldDefs: TListBox;
    procedure lsFieldDefsClick(Sender: TObject);
  private
    FDataset: TDataset;
    procedure ListFields;
    procedure SetDataset(const Value: TDataset);
    function GetSelectedField(AIndex: integer): TFieldDef;
    function GetSelectedFieldCount: integer;
    procedure SelectAllFields;
  public
    property Dataset: TDataset read FDataset write SetDataset;
    property SelectedFieldCount: integer read GetSelectedFieldCount;
    property SelectedFields[i: integer]: TFieldDef read GetSelectedField;
  end;

implementation

{$R *.dfm}

{ TfmDFEAddFields }

procedure TfmDFEAddFields.ListFields;
var
  i: integer;
begin
  FDataset.FieldDefs.Update;

  lsFieldDefs.Items.BeginUpdate;
  try
    lsFieldDefs.Items.Clear;
    for i:=0 to FDataset.FieldDefs.Count-1 do
      if FDataset.FindField(FDataset.FieldDefs[i].Name) = nil then
        lsFieldDefs.Items.AddObject(FDataset.FieldDefs[i].Name, FDataset.FieldDefs[i]);

    SelectAllFields;
    lsFieldDefs.ItemIndex := -1;
    btOk.Enabled := lsFieldDefs.Items.Count > 0;
  finally
    lsFieldDefs.Items.EndUpdate;
  end;
end;

procedure TfmDFEAddFields.SetDataset(const Value: TDataset);
begin
  FDataset := Value;
  ListFields;
end;

procedure TfmDFEAddFields.lsFieldDefsClick(Sender: TObject);
begin
  btOk.Enabled := lsFieldDefs.SelCount > 0;
end;

function TfmDFEAddFields.GetSelectedField(AIndex: integer): TFieldDef;
var
  i: integer;
begin
  for i:=0 to lsFieldDefs.Items.Count-1 do
  begin
    if lsFieldDefs.Selected[i] then
    begin
      if AIndex = 0 then
      begin
        result := lsFieldDefs.Items.Objects[i] as TFieldDef;
        exit;
      end
      else
        Dec(AIndex);
    end;
  end;
  result := nil;
end;

function TfmDFEAddFields.GetSelectedFieldCount: integer;
begin
  result := lsFieldDefs.SelCount;
end;

procedure TfmDFEAddFields.SelectAllFields;
var
  i: integer;
begin
  for i:=0 to lsFieldDefs.Items.Count-1 do
    lsFieldDefs.Selected[i] := true;
end;

end.

