unit DatasetFieldsEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DBCtrls, Menus, DB, ActnList, Clipbrd,
  DBClient, FormDesigner;

{$I ASCRIPT.INC}

type
  TfmDatasetFieldsEditor = class(TForm)
    DBNavigator: TDBNavigator;
    lsFields: TListBox;
    popFields: TPopupMenu;
    miAddFields: TMenuItem;
    miNewField: TMenuItem;
    miAddAllFields: TMenuItem;
    N1: TMenuItem;
    miCut: TMenuItem;
    miCopy: TMenuItem;
    miPaste: TMenuItem;
    miDelete: TMenuItem;
    miSelectAll: TMenuItem;
    alFields: TActionList;
    acAddFields: TAction;
    acNewField: TAction;
    acAddAllFields: TAction;
    acCut: TAction;
    acCopy: TAction;
    acPaste: TAction;
    acDelete: TAction;
    acSelectAll: TAction;
    dsNavigator: TDataSource;
    lsAggregates: TListBox;
    spAggregates: TSplitter;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure alFieldsUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure acAddFieldsExecute(Sender: TObject);
    procedure acNewFieldExecute(Sender: TObject);
    procedure acAddAllFieldsExecute(Sender: TObject);
    procedure acCutExecute(Sender: TObject);
    procedure acCopyExecute(Sender: TObject);
    procedure acPasteExecute(Sender: TObject);
    procedure acDeleteExecute(Sender: TObject);
    procedure acSelectAllExecute(Sender: TObject);
    procedure lsFieldsDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure lsFieldsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lsFieldsClick(Sender: TObject);
  private
    FEditedDataset: TDataset;
    FFieldsOwner: TComponent;
    FFormDesigner: TAdvCustomFormDesigner;
    function CanPasteFromClipboard: boolean;
    procedure DeleteSelectedItems(AListBox: TListBox);
    procedure FieldsToClipboard;
    function GetCurrentListBox: TListBox;
    function GetTitle: string;
    procedure LoadFields;
    procedure SelectAllItems(AListBox: TListBox);
    procedure SetDesignerFields;
    procedure SetEditedDataset(const Value: TDataset);
    procedure ShowAggregates;
  public
    property CurrentListBox: TListBox read GetCurrentListBox;
    property EditedDataset: TDataset read FEditedDataset write SetEditedDataset;
    property FieldsOwner: TComponent read FFieldsOwner write FFieldsOwner;
  end;

procedure EditDatasetFields(ADataset: TDataset; AOwner: TComponent=nil; AFormDesigner: TAdvCustomFormDesigner=nil);

implementation

uses
  DFEAddFields, DFENewField
  {$IFDEF DELPHI6_LVL}, Types{$ENDIF};

{$R *.dfm}

procedure EditDatasetFields(ADataset: TDataset; AOwner: TComponent=nil;
  AFormDesigner: TAdvCustomFormDesigner=nil);
begin
  with TfmDatasetFieldsEditor.Create(nil) do
  try
    EditedDataset := ADataset;
    if AOwner <> nil then
      FieldsOwner := AOwner
    else
      FieldsOwner := ADataset.Owner;
    FFormDesigner := AFormDesigner;
    Show;
  except
    Free;
    raise;
  end;
end;

procedure TfmDatasetFieldsEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfmDatasetFieldsEditor.FormShow(Sender: TObject);
begin
  Caption := GetTitle;
  LoadFields;
end;

function TfmDatasetFieldsEditor.GetTitle: string;
begin
  if Assigned(FieldsOwner) then
    result := FieldsOwner.Name
  else
    result := '';
  if result > '' then
    result := result + '.';
  if Assigned(EditedDataset) and (EditedDataset.Name > '') then
    result := result + EditedDataset.Name
  else
    result := result + '???';
end;

procedure TfmDatasetFieldsEditor.LoadFields;

  procedure Load(AListBox: TListBox; AFields: TFields);
  var
    i: integer;
  begin
    AListBox.Items.BeginUpdate;
    try
      AListBox.Items.Clear;
      for i:=0 to AFields.Count-1 do
        AListBox.Items.AddObject(AFields[i].FieldName, AFields[i]);
    finally
      AListBox.Items.EndUpdate;
    end;
  end;

begin
  Load(lsFields, EditedDataset.Fields);
  if EditedDataset is TClientDataset then
  begin
    Load(lsAggregates, EditedDataset.AggFields);
    ShowAggregates;
  end;
end;

procedure TfmDatasetFieldsEditor.alFieldsUpdate(Action: TBasicAction; var Handled: Boolean);
begin
  acCut.Enabled := CurrentListBox.SelCount > 0;
  acCopy.Enabled := CurrentListBox.SelCount > 0;
  acPaste.Enabled := CanPasteFromClipboard;
  acDelete.Enabled := CurrentListBox.SelCount > 0;
end;

procedure TfmDatasetFieldsEditor.acAddFieldsExecute(Sender: TObject);
var
  i: integer;
  field: TField;
  dsactive: boolean;
begin
  with TfmDFEAddFields.Create(nil) do
  try
    Dataset := FEditedDataset;

    if ShowModal = mrOk then
    begin
      dsactive := FEditedDataset.Active;
      lsFields.Items.BeginUpdate;
      try
        FEditedDataset.Close;
        for i:=0 to lsFields.Items.Count-1 do
          lsFields.Selected[i] := False;
        for i:=0 to SelectedFieldCount-1 do
        begin
          field := SelectedFields[i].CreateField(FFieldsOwner);
          field.Name := DFEMakeFieldComponentName(FFieldsOwner, FEditedDataset, field.FieldName);
          lsFields.ItemIndex := lsFields.Items.AddObject(field.FieldName, field);
          lsFields.Selected[lsFields.ItemIndex] := True;
        end;
      finally
        lsFields.Items.EndUpdate;
        SetDesignerFields;
        FEditedDataset.Active := dsactive;
      end;
    end;
  finally
    Free;
  end;
end;

procedure TfmDatasetFieldsEditor.acNewFieldExecute(Sender: TObject);
var
  field: TField;
  flist: TListBox;
  i: integer;
  dsactive: boolean;
begin
  with TfmDFENewField.Create(nil) do
  try
    FieldDataset := FEditedDataset;
    FieldOwner := FFieldsOwner;
    if ShowModal = mrOk then
    begin
      dsactive := FEditedDataset.Active;
      try
        FEditedDataset.Close;
        field := CreateNewField;
        if (field.FieldKind <> fkAggregate) or not lsAggregates.Visible then
          flist := lsFields
        else
          flist := lsAggregates;
        flist.ItemIndex := flist.Items.AddObject(field.FieldName, field);
        for i:=0 to flist.Items.Count-1 do
          flist.Selected[i] := i = flist.ItemIndex;
      finally
        SetDesignerFields;
        FEditedDataset.Active := dsactive;
      end;
    end;
  finally
    Free;
  end;
end;

procedure TfmDatasetFieldsEditor.acAddAllFieldsExecute(Sender: TObject);
var
  i: integer;
  field: TField;
  dsactive: boolean;
begin
  FEditedDataset.FieldDefs.Update;

  dsactive := FEditedDataset.Active;
  lsFields.Items.BeginUpdate;
  try
    FEditedDataset.Close;
    for i:=0 to lsFields.Items.Count-1 do
      lsFields.Selected[i] := False;
    for i:=0 to FEditedDataset.FieldDefs.Count-1 do
      if FEditedDataset.FindField(FEditedDataset.FieldDefs[i].Name) = nil then
      begin
        field := FEditedDataset.FieldDefs[i].CreateField(FFieldsOwner);
        field.Name := DFEMakeFieldComponentName(FFieldsOwner, FEditedDataset, field.FieldName);
        lsFields.ItemIndex := lsFields.Items.AddObject(field.FieldName, field);
        lsFields.Selected[lsFields.ItemIndex] := True;
      end;
  finally
    lsFields.Items.EndUpdate;
    SetDesignerFields;
    FEditedDataset.Active := dsactive;
  end;
end;

procedure TfmDatasetFieldsEditor.acCutExecute(Sender: TObject);
begin
  FieldsToClipboard;
  acDelete.Execute;
end;

procedure TfmDatasetFieldsEditor.acCopyExecute(Sender: TObject);
begin
  FieldsToClipboard;
end;

procedure TfmDatasetFieldsEditor.acPasteExecute(Sender: TObject);
var
  strStream: TStringStream;
  binStream: TMemoryStream;
  field: TField;
begin
  strStream := TStringStream.Create(Clipboard.AsText);
  binStream := TMemoryStream.Create;
  try
    field := nil;
    try
      strStream.Position := 0;
      while strStream.Position < strStream.Size do
      begin
        ObjectTextToBinary(strStream, binStream);
        binStream.Position := 0;
        field := binStream.ReadComponent(nil) as TField;
        field.Name := DFEMakeFieldComponentName(FFieldsOwner, FEditedDataset, field.FieldName);
        FFieldsOwner.InsertComponent(field);
        field.DataSet := FEditedDataset;
        lsFields.ItemIndex := lsFields.Items.AddObject(field.FieldName, field);
        lsFields.Selected[lsFields.ItemIndex] := True;
        field := nil;
        binStream.Clear;
      end;
    except
      if Assigned(field) then
        FreeAndNil(field);
      raise;
    end;
  finally
    strStream.Free;
    binStream.Free;
  end;
end;

procedure TfmDatasetFieldsEditor.acDeleteExecute(Sender: TObject);
var
  i: integer;
  dsactive: boolean;
begin
  dsactive := FEditedDataset.Active;
  try
    for i:=0 to CurrentListBox.Items.Count-1 do
      if CurrentListBox.Selected[i] then
        CurrentListBox.Items.Objects[i].Free;
    DeleteSelectedItems(CurrentListBox);
    ShowAggregates;
  finally
    FEditedDataset.Active := dsactive;
  end;
end;

procedure TfmDatasetFieldsEditor.acSelectAllExecute(Sender: TObject);
begin
  SelectAllItems(CurrentListBox);
end;

procedure TfmDatasetFieldsEditor.SetEditedDataset(const Value: TDataset);
begin
  FEditedDataset := Value;
  dsNavigator.Dataset := FEditedDataset;
  ShowAggregates;
end;

function TfmDatasetFieldsEditor.GetCurrentListBox: TListBox;
begin
  if lsAggregates.Visible and lsAggregates.Focused then
    result := lsAggregates
  else
    result := lsFields;
end;

procedure TfmDatasetFieldsEditor.ShowAggregates;
begin
  lsAggregates.Visible := Assigned(FEditedDataset) and (FEditedDataset is TClientDataset) and (lsAggregates.Items.Count > 0);
  spAggregates.Visible := lsAggregates.Visible;
end;

procedure TfmDatasetFieldsEditor.lsFieldsDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Sender = Source;
end;

procedure TfmDatasetFieldsEditor.lsFieldsDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  flist: TListBox;
  findex, i: integer;
begin
  if Sender = Source then
  begin
    flist := Sender as TListBox;
    findex := flist.ItemAtPos(Point(X, Y), False);
    for i:=0 to flist.Items.Count-1 do
      if flist.Selected[i] then
        if findex < flist.Items.Count then
          flist.Items.Move(i, findex)
        else
          flist.Items.Move(i, flist.Items.Count-1);
    for i:=0 to flist.Items.Count-1 do
      TField(flist.Items.Objects[i]).Index := i;
  end;
end;

procedure TfmDatasetFieldsEditor.FieldsToClipboard;
var
  binStream: TMemoryStream;
  strStream: TStringStream;
  i: integer;
begin
  binStream := TMemoryStream.Create;
  strStream := TStringStream.Create('');
  try
    for i:=0 to CurrentListBox.Items.Count-1 do
      if CurrentListBox.Selected[i] then
      begin
        binStream.WriteComponent(CurrentListBox.Items.Objects[i] as TField);
        binStream.Position := 0;
        ObjectBinaryToText(binStream, strStream);
        binStream.Clear;
      end;
    Clipboard.AsText := strStream.DataString;
  finally
    strStream.Free;
    binStream.Free;
  end;
end;

function TfmDatasetFieldsEditor.CanPasteFromClipboard: boolean;
var
  buf: array[1..7] of char;
begin
  Clipboard.GetTextBuf(@buf, SizeOf(buf));
  result := SameText('object'#0, buf);
end;

var
  ft: TFieldType;

procedure TfmDatasetFieldsEditor.DeleteSelectedItems(AListBox: TListBox);
var
  i: integer;
begin
  for i:=AListBox.Items.Count-1 downto 0 do
    if AListBox.Selected[i] then
      AListBox.Items.Delete(i);
end;

procedure TfmDatasetFieldsEditor.SelectAllItems(AListBox: TListBox);
var
  i: integer;
begin
  for i:=0 to AListBox.Items.Count-1 do
    AListBox.Selected[i] := true;
end;

procedure TfmDatasetFieldsEditor.lsFieldsClick(Sender: TObject);
begin
  SetDesignerFields;
end;

procedure TfmDatasetFieldsEditor.SetDesignerFields;
var
  i: integer;
begin
  if FFormDesigner <> nil then
  begin
    {if CurrentListBox.ItemIndex >= 0 then
      FFormDesigner.Component := TComponent(CurrentListBox.Items.Objects[CurrentListBox.ItemIndex]);}
    FFormDesigner.UnselectAll;
    for i:=0 to CurrentListBox.Items.Count-1 do
      if CurrentListBox.Selected[i] then
        FFormDesigner.AddComponent(TComponent(CurrentListBox.Items.Objects[i]));
  end;
end;

initialization
  for ft:=Low(TFieldType) to High(TFieldType) do
    if DefaultFieldClasses[ft] <> nil then
      RegisterClass(DefaultFieldClasses[ft]);
end.

