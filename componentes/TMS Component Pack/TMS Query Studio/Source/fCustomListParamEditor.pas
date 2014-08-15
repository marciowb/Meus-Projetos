unit fCustomListParamEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls,
  ExtCtrls, Menus, Buttons, fCustomParamEditor,
  atVisualQuery;

type
  TfmCustomListParamEditor = class(TfmCustomParamEditor)
    pnItems: TPanel;
    lbParamValues: TLabel;
    edParamValues: TListView;
    Label2: TLabel;
    edListItems: TListView;
    procedure btOkClick(Sender: TObject);
    procedure edParamValuesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure edListItemsClick(Sender: TObject);
    procedure edParamValuesEnter(Sender: TObject);
    procedure edListItemsChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure edParamValuesEdited(Sender: TObject; Item: TListItem;
      var S: String);
    procedure edListItemsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edParamValuesCompare(Sender: TObject; Item1,
      Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FDefaultParams : TStringList;
    procedure EditNewItem;
    procedure LoadParamValues;
    procedure ClearParamValuesLists;
    procedure CreateIncludeItem;
    function GetCurrentParams: TStringList;
    procedure AssignParamValues(ASource: TStrings; ATarget: TatParamValues );
    procedure Localize;
  protected
    procedure Loaded; override;
  public
  end;

var
  fmCustomListParamEditor: TfmCustomListParamEditor;

implementation

uses
  qsRes;

{$R *.DFM}

procedure TfmCustomListParamEditor.AssignParamValues(ASource: TStrings; ATarget: TatParamValues );
var c: integer;
begin
  { copia apenas os items que tem valor definido }
  ATarget.Clear;
  with ASource do
    for c:=0 to Count-1 do
      if Values[Names[c]]>'' then
        ATarget.Add(Strings[c]);
end;

procedure TfmCustomListParamEditor.btOkClick(Sender: TObject);
var c: integer;
begin
  inherited;
  with MetaSql do
  begin
    { inclui o novo parâmetro no VisualQuery }
    EditedObject := MetaSqlDef.ParamDefs.Add;
    with TatParamDef(EditedObject) do
    begin
      Caption := edCaption.Text;
      ParamType := Self.ParamType; { ptChooseList or ptCheckList }

      { first item is always the default item }
      with DefaultItem do
        AssignParamValues( FDefaultParams, ParamValues );

      { load list parameter items }
      for c:=0 to edListItems.Items.Count-2 do // ignore the last item (placeholder)
        with ListItems.Add do
        begin
          Text := edListitems.Items[c].Caption;
          AssignParamValues( TStringList(edListitems.Items[c].Data), ParamValues );
        end;
    end;
  end;
end;

function TfmCustomListParamEditor.GetCurrentParams: TStringList;
begin
  { obtém a lista de valores dos parâmetros associada ao item corrente no edListItems }
  if Assigned(edListItems.Selected) and Assigned(edListItems.Selected.Data) then
    result := TStringList(edListItems.Selected.Data)
  else
    result := FDefaultParams;
end;

procedure TfmCustomListParamEditor.edParamValuesKeyDown(Sender: TObject;var Key: Word; Shift: TShiftState);
var params : TStringList;
begin
  inherited;
  with TListView(Sender) do
    if not IsEditing and Enabled then
      case Key of
        VK_F2, VK_RETURN: { alteração }
          if Assigned(Selected) and (Shift=[]) then
          begin
            Selected.MakeVisible(false);
            Selected.EditCaption;
            Key := 0;
          end;
        VK_F4, VK_DELETE: { exclusão --> apenas limpa o caption }
          if Assigned(Selected) and (Shift=[]) then
          begin
            Selected.MakeVisible(false);
            Selected.Caption := '';
            params := GetCurrentParams;
            if Assigned(params) then
              { armazena o valor do parâmetro na lista que está associada ao item corrente }
              params.Values[ Selected.SubItems[0] ] := '';
          end;
      end;
end;

procedure TfmCustomListParamEditor.FormShow(Sender: TObject);
var c: integer;
begin
  inherited;
  { carrega os parêmetros disponíveis para os itens da lista }
  with MetaSqlDef.MetaSql do
  begin
    { carrega apenas os Params já presentes na meta-sql }
    for c:=0 to Params.Count-1 do
      edParamValues.Items.Add.SubItems.Add( Params[c].Name );

    { ordena a lista de parâmetros pelo nome }
    edParamValues.AlphaSort;
  end;
  
  { seleciona o primeiro item }
  with edParamValues do
    if Items.Count>0 then
    begin
      Selected := Items[0];
      ItemFocused := Selected;
    end;

  CreateIncludeItem;
end;

procedure TfmCustomListParamEditor.CreateIncludeItem;
begin
  { deixa um item default para facilitar a inclus"ao no final da lista de itens }
  with edListItems do
  begin
    Selected := Items.Add;
    Selected.Caption := '<' + _str(SIncludeANewItem) + '>';
    ItemFocused := Selected;
  end;
end;

procedure TfmCustomListParamEditor.edListItemsClick(Sender: TObject);
begin
  inherited;
  with TListView(Sender) do
    if Assigned(Selected) then
      if not Assigned(Selected.Data) then
        EditNewItem;
end;

procedure TfmCustomListParamEditor.EditNewItem;
var item : TListItem;
begin
  with edListItems do
  begin
    item := Selected;

    CreateIncludeItem;

    { altera o novo item }
    item.MakeVisible(false);
    item.Caption := '';
    item.EditCaption;
    { cria uma lista interna para armazenar o valor dos parâmetros
      associados ao item selecionado na lista }
    item.Data := TStringList.Create;
  end;
end;

procedure TfmCustomListParamEditor.edParamValuesEnter(Sender: TObject);
begin
  inherited;
  LoadParamValues;
end;

procedure TfmCustomListParamEditor.edListItemsChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  inherited;
  if (Item=edListItems.Selected) or (Item=nil) then
  begin
    if (Item=nil) or (Item.Data=nil) then
      lbParamValues.Caption := _str(SValuesAppliedNoItemSelected)
    else
      lbParamValues.Caption := Format(_str(SValuesAppliedItemSelected), [edListItems.Selected.Caption]);
    LoadParamValues;
  end;
end;

procedure TfmCustomListParamEditor.LoadParamValues;
var
  c: integer;
  params : TStringList;
begin
  params := GetCurrentParams;
  { carrega na primeira coluna o valor correspondente a cada um dos
    parâmetros que estão na coluna da direita }
  with edParamValues do
    for c:=0 to Items.Count-1 do
      if Assigned(params) then
        Items[c].Caption := params.Values[ Items[c].SubItems[0] ]
      else
        Items[c].Caption := '';
end;

procedure TfmCustomListParamEditor.edParamValuesEdited(Sender: TObject;Item: TListItem; var S: String);
var
  params : TStringList;
begin
  inherited;
  if Assigned(Item) then
  begin
    params := GetCurrentParams;
    if Assigned(params) then
      { armazena o valor do parâmetro na lista que está associada ao item corrente }
      params.Values[ Item.SubItems[0] ] := S;
  end;
end;

procedure TfmCustomListParamEditor.edListItemsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  with TListView(Sender) do
    if not IsEditing and Enabled then
      case Key of
        VK_F2, VK_RETURN: { alteração }
          if Assigned(Selected) and (Shift=[]) then
          begin
            if not Assigned(Selected.Data) then
              EditNewItem
            else
            begin
              Selected.MakeVisible(false);
              Selected.EditCaption;
            end;
            Key := 0;
          end;
        VK_F3, VK_INSERT: { inclusão }
          if Shift=[] then
          begin
             Selected := Items[ Items.Count-1 ];
             EditNewItem;
          end;
        VK_F4, VK_DELETE: { exclusão }
          if Assigned(Selected) and Assigned(Selected.Data) and (Shift=[]) then
          begin
            Selected.MakeVisible(false);
            TObject(Selected.Data).Free;
            Items.Delete(Selected.Index);
            if Assigned(ItemFocused) then
              Selected := ItemFocused;
          end;
       end;
end;

procedure TfmCustomListParamEditor.ClearParamValuesLists;
var c: integer;
begin
  with edListItems do
    for c:=0 to Items.Count-1 do
      if Assigned(Items[c].Data) then
        TObject(Items[c].Data).Free;
end;

procedure TfmCustomListParamEditor.edParamValuesCompare(Sender: TObject;
  Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  inherited;
  Compare := CompareText( Item1.SubItems[0], Item2.SubItems[0] );
end;

procedure TfmCustomListParamEditor.FormCreate(Sender: TObject);
begin
  inherited;
  FDefaultParams := TStringList.Create;
end;

procedure TfmCustomListParamEditor.FormDestroy(Sender: TObject);
begin
  ClearParamValuesLists;
  FDefaultParams.Free;
  inherited;
end;

procedure TfmCustomListParamEditor.Localize;
begin
  Self.Caption := _str('fmCustomListParamEditor.Self.Caption');
  lbParamValues.Caption := _str('fmCustomListParamEditor.lbParamValues.Caption');
  Label2.Caption := _str('fmCustomListParamEditor.Label2.Caption');
  edParamValues.Items[0].Caption := _str('fmCustomListParamEditor.edParamValues.Items0.Caption');
  edParamValues.Items[1].Caption := _str('fmCustomListParamEditor.edParamValues.Items1.Caption');
  edListItems.Items[0].Caption := _str('fmCustomListParamEditor.edListItems.Items0.Caption');
  lbInfo.Caption := _str('fmCustomListParamEditor.lbInfo.Caption');
end;

procedure TfmCustomListParamEditor.Loaded;
begin
  inherited;
  Localize;
end;

end.

