unit DFENewField;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, DBClient;

type
  TfmDFENewField = class(TForm)
    gbProperties: TGroupBox;
    rgKind: TRadioGroup;
    gbLookup: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lbKeyField: TLabel;
    lbLookupDataset: TLabel;
    lbLookupKey: TLabel;
    lbResultField: TLabel;
    edName: TEdit;
    edComponent: TEdit;
    cbType: TComboBox;
    edSize: TEdit;
    cbKeyField: TComboBox;
    cbLookupDataset: TComboBox;
    cbLookupKey: TComboBox;
    cbResultField: TComboBox;
    btOk: TButton;
    btCancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure rgKindClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edNameChange(Sender: TObject);
    procedure cbTypeChange(Sender: TObject);
    procedure cbLookupDatasetChange(Sender: TObject);
  private
    FFieldOwner: TComponent;
    FFieldDataset: TDataset;
    function CheckFieldProperties: boolean;
    procedure EnableLookupGroup;
    procedure LoadFieldKindList;
    procedure LoadFieldTypeList;
    procedure LoadKeyFieldList;
    procedure LoadLookupDatasetList;
    procedure LoadLookupFieldLists;
    function GetFieldKind: TFieldKind;
    procedure SetFieldKind(const Value: TFieldKind);
    function GetFieldClass: TFieldClass;
    function GetFieldType: TFieldType;
    function GetLookupDataset: TDataset;
  public
    function CreateNewField: TField;
    property FieldClass: TFieldClass read GetFieldClass;
    property FieldDataset: TDataset read FFieldDataset write FFieldDataset;
    property FieldKind: TFieldKind read GetFieldKind write SetFieldKind;
    property FieldOwner: TComponent read FFieldOwner write FFieldOwner;
    property FieldType: TFieldType read GetFieldType;
    property LookupDataset: TDataset read GetLookupDataset;
  end;

function DFEMakeFieldComponentName(AOwner: TComponent; ADataset: TDataset; AFieldName: string): string;

implementation

uses
  TypInfo;

const
  TEXT_CIRCULARDATALINKS  = 'Circular datalinks are not allowed';
  TEXT_DUPLICATEFIELD     = '%s: Duplicate field name ''%s''';
  TEXT_EMPTYCOMPONENT     = 'Component must be specified';
  TEXT_EMPTYKEYFIELD      = 'Key fields must be specified';
  TEXT_EMPTYLOOKUPDATASET = 'Dataset must be specified';
  TEXT_EMPTYLOOKUPKEY     = 'Lookup keys must be specified';
  TEXT_EMPTYNAME          = 'Name must be specified';
  TEXT_EMPTYRESULTFIELD   = 'Result field must be specified';
  TEXT_EMPTYTYPE          = 'Type must be specified';

{$R *.dfm}

function DFEMakeFieldComponentName(AOwner: TComponent; ADataset: TDataset; AFieldName: string): string;
var
  i: integer;
  dsName, compName: string;
begin
  if AFieldName > '' then
  begin
    if Assigned(ADataset) then
      dsName := ADataset.Name
    else
      dsName := '';

    for i:=1 to Length(AFieldName) do
      case AFieldName[i] of
        'A'..'Z', 'a'..'z', '_':
          compName := compName + AFieldName[i];
        '0'..'9':
          if (compName > '') or (dsName > '') then
            compName := compName + AFieldName[i];
      end;

    if compName = '' then
      compName := 'Field';
    result := dsName + compName;

    if Assigned(AOwner) then
    begin
      i := 1;
      while AOwner.FindComponent(result) <> nil do
      begin
        Inc(i);
        result := Format('%s%s%d', [dsName, compName, i]);
      end;
    end;
  end
  else
    result := '';
end;

procedure TfmDFENewField.FormShow(Sender: TObject);
begin
  LoadFieldTypeList;
  LoadFieldKindList;
  LoadLookupDatasetList;
  LoadKeyFieldList;
  
  FieldKind := fkData;
end;

function TfmDFENewField.GetFieldKind: TFieldKind;
begin
  result := TFieldKind(rgKind.ItemIndex);
end;

procedure TfmDFENewField.LoadFieldTypeList;
var
  ft: TFieldType;
begin
  cbType.Items.BeginUpdate;
  try
    cbType.Items.Clear;
    for ft:=Low(TFieldType) to High(TFieldType) do
      if ft <> ftUnknown then
        cbType.Items.Add(FieldTypeNames[ft]);
  finally
    cbType.Items.EndUpdate;
  end;
end;

procedure TfmDFENewField.LoadLookupDatasetList;
var
  i: integer;
begin
  if Assigned(FieldOwner) then
  begin
    cbLookupDataset.Items.BeginUpdate;
    try
      cbLookupDataset.Items.Clear;
      for i:=0 to FieldOwner.ComponentCount-1 do
        if FieldOwner.Components[i] is TDataset then
          cbLookupDataset.Items.AddObject(FieldOwner.Components[i].Name, FieldOwner.Components[i]);
    finally
      cbLookupDataset.Items.EndUpdate;
    end;                                
  end;
end;

procedure TfmDFENewField.SetFieldKind(const Value: TFieldKind);
begin
  rgKind.ItemIndex := Ord(Value);
end;

procedure TfmDFENewField.rgKindClick(Sender: TObject);
begin
  EnableLookupGroup;
  if FieldKind = fkAggregate then
    cbType.Text := 'Aggregate';
end;

procedure TfmDFENewField.EnableLookupGroup;
var
  lkenable, lkdataset: boolean;
begin
  lkenable := FieldKind = fkLookup;
  lkdataset := LookupDataset <> nil;

  lbKeyField.Enabled := lkenable;
  cbKeyField.Enabled := lkenable;
  lbLookupDataset.Enabled := lkenable;
  cbLookupDataset.Enabled := lkenable;
  lbLookupKey.Enabled := lkenable and lkdataset;
  cbLookupKey.Enabled := lkenable and lkdataset;
  lbResultField.Enabled := lkenable and lkdataset;
  cbResultField.Enabled := lkenable and lkdataset;
end;

procedure TfmDFENewField.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := (ModalResult <> mrOk) or CheckFieldProperties;
end;

function TfmDFENewField.CheckFieldProperties: boolean;

  function Check(ACondition: boolean; AControl: TWinControl; AError: string): boolean;
  begin
    if ACondition then
      result := True
    else
    begin
      if AControl.CanFocus then
        AControl.SetFocus;
      raise Exception.Create(AError);
    end;
  end;
  
begin
  result := Check(edName.Text > '', edName, TEXT_EMPTYNAME)
        and Check(edComponent.Text > '', edComponent, TEXT_EMPTYCOMPONENT)
        and Check((FieldType <> ftUnknown) or (FieldKind = fkAggregate), cbType, TEXT_EMPTYTYPE)
        and Check(FieldDataset.FindField(edName.Text) = nil, edName, Format(TEXT_DUPLICATEFIELD, [FieldDataset.Name, edName.Text]))
        and Check((FieldKind <> fkLookup) or (cbKeyField.Text > ''), cbKeyField, TEXT_EMPTYKEYFIELD)
        and Check((FieldKind <> fkLookup) or (LookupDataset <> nil), cbLookupDataset, TEXT_EMPTYLOOKUPDATASET)
        and Check((FieldKind <> fkLookup) or (FieldDataset <> LookupDataset), cbLookupDataset, TEXT_CIRCULARDATALINKS)
        and Check((FieldKind <> fkLookup) or (cbLookupKey.Text > ''), cbLookupKey, TEXT_EMPTYLOOKUPKEY)
        and Check((FieldKind <> fkLookup) or (cbResultField.Text > ''), cbResultField, TEXT_EMPTYRESULTFIELD);
end;

procedure TfmDFENewField.edNameChange(Sender: TObject);
begin
  edComponent.Text := DFEMakeFieldComponentName(FFieldOwner, FFieldDataset, edName.Text);
end;

procedure TfmDFENewField.cbTypeChange(Sender: TObject);
begin
  edSize.Enabled := (FieldClass = nil) or IsPublishedProp(FieldClass, 'Size');
  if not edSize.Enabled then
    edSize.Text := '0';
end;

function TfmDFENewField.GetFieldClass: TFieldClass;
begin
  if (FieldType <> ftUnknown) or (FieldKind <> fkAggregate) then
    result := DefaultFieldClasses[FieldType]
  else
    result := TAggregateField;
end;

function TfmDFENewField.GetFieldType: TFieldType;
var
  ft: TFieldType;
begin
  for ft:=Low(TFieldType) to High(TFieldType) do
    if SameText(cbType.Text, FieldTypeNames[ft]) then
    begin
      result := ft;
      exit;
    end;
  result := ftUnknown;
end;

function TfmDFENewField.GetLookupDataset: TDataset;
begin
  if (FieldKind = fkLookup) and Assigned(FieldOwner) then
    result := FieldOwner.FindComponent(cbLookupDataset.Text) as TDataset
  else
    result := nil;
end;

procedure TfmDFENewField.LoadKeyFieldList;
var
  i: integer;
begin
  if Assigned(FieldDataset) then
  begin
    cbKeyField.Items.BeginUpdate;
    try
      cbKeyField.Items.Clear;
      for i:=0 to FieldDataset.FieldCount-1 do
        cbKeyField.Items.Add(FieldDataset.Fields[i].FieldName);
    finally
      cbKeyField.Items.EndUpdate;
    end;
  end;
end;

procedure TfmDFENewField.cbLookupDatasetChange(Sender: TObject);
begin
  EnableLookupGroup;
  LoadLookupFieldLists;
end;

procedure TfmDFENewField.LoadLookupFieldLists;
var
  dslookup: TDataset;
  i: integer;
begin
  dslookup := LookupDataset;
  if dslookup <> nil then
  begin
    cbLookupKey.Items.BeginUpdate;
    try
      cbLookupKey.Items.Clear;
      for i:=0 to dslookup.FieldCount-1 do
        cbLookupKey.Items.Add(dslookup.Fields[i].FieldName);
    finally
      cbLookupKey.Items.EndUpdate;
    end;
    cbResultField.Items.Assign(cbLookupKey.Items);
  end;
end;

procedure TfmDFENewField.LoadFieldKindList;
const
  FieldKindItem: array[TFieldKind] of string =
    ('&Data', '&Calculated', '&Lookup', '&InternalCalc', 'A&ggregate');
var
  fk: TFieldKind;
begin
  rgKind.Items.BeginUpdate;
  try
    rgKind.Items.Clear;
    for fk:=Low(TFieldKind) to High(TFieldKind) do
      if (fk < fkInternalCalc) or (Assigned(FieldDataset) and (FieldDataset is TClientDataset)) then
        rgKind.Items.Add(FieldKindItem[fk]);
    rgKind.Columns := rgKind.Items.Count;
  finally
    rgKind.Items.EndUpdate;
  end;
end;

function TfmDFENewField.CreateNewField: TField;
begin
  result := GetFieldClass.Create(FieldOwner);
  try
    result.FieldKind := Self.FieldKind;
    result.FieldName := edName.Text;
    result.Name := edComponent.Text;
    result.Size := StrToIntDef(edSize.Text, 0);
    result.Dataset := FieldDataset;

    if FieldKind = fkLookup then
    begin
      result.KeyFields := cbKeyField.Text;
      result.LookupDataset := Self.LookupDataset;
      result.LookupKeyFields := cbLookupKey.Text;
      result.LookupResultField := cbResultField.Text;
    end;
  except
    Free;
    raise;
  end;
end;

end.

