unit fCustomEditor;

{$I tmsdefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, atMetaSql, Menus, atVisualQuery, ComCtrls,
  DB, DBTables
  {$IFDEF TMSDOTNET}
  , Types
  {$ENDIF}
  ;

type
  TEditPopupMode = (epNone, epInsertFieldAlias, epInsertField, epInsertTableAlias);
  TEditorFormStyle = (esToolWindow, esFixedFrame);

  TEditorClass = class of TfmCustomEditor;

  {$IFNDEF TMSDOTNET}
  HackWinControl = class(TWinControl);
  {$ENDIF}

  TfmCustomEditor = class(TForm)
    PopupMenu1: TPopupMenu;
    pnBottom: TPanel;
    pnButton: TPanel;
    btOk: TBitBtn;
    btCancel: TBitBtn;
    pnTitle: TPanel;
    pnInfo: TPanel;
    lbInfo: TLabel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btOkClick(Sender: TObject);
  private
    FVisualQuery : TatVisualQuery;
    FMetaSqlDef : TatMetaSqlDef;
    FEditPopupMode : TEditPopupMode;
    FEditedObject : TObject;
    procedure SetVisualQuery(const Value: TatVisualQuery);
    procedure Localize;
  protected
    procedure Loaded; override;
    function ComboFindObject(combo: TComboBox; i: integer): integer;
    function ComboMatchItem(combo: TComboBox; txt: string): boolean;
    procedure ProcessLookupComboKey(Sender: TObject; var key: char);

    procedure LoadParamNameCombo(combo: TComboBox);
    procedure AdjustDefaultItems;
    procedure SetEditedObject(const Value: TObject); virtual;
    procedure ValidationError(ARaise:boolean;msg: string; args: array of const;ctrl: TWinControl);
    function ParseMetaSql(const sql:string):TatMetaSql;
    function MetaSql: TatMetaSql;
    procedure AdjustClientRect(var Rect: TRect); override;
    procedure LoadTableNameList( lst: TStrings );
    procedure LoadFieldNameList( ATableName: string; lst: TStrings );
  public
    property MetaSqlDef: TatMetaSqlDef read FMetaSqlDef write FMetaSqlDef;
    property EditPopupMode: TEditPopupMode read FEditPopupMode write FEditPopupMode;
    property EditedObject : TObject read FEditedObject write SetEditedObject;
    property VisualQuery : TatVisualQuery read FVisualQuery write SetVisualQuery;
  end;

var
  fmCustomEditor: TfmCustomEditor;
  EditorFormStyle : TEditorFormStyle = esToolWindow;

procedure OpenItemEditor(
  AEditorClass: TEditorClass;
  X, Y: integer;
  AVisualQuery: TatVisualQuery;
  AMetaSqlDef: TatMetaSqlDef;
  var AEditedObj: TObject );

function JoinConditions( ASqlTable: TatSqlTable ): TatSqlJoin;
//function PrettyText(s:string): string;

implementation

uses
  qsRes;

{$R *.DFM}

function JoinConditions( ASqlTable: TatSqlTable ): TatSqlJoin;
var c: integer;
begin
  { retorna o join conditions de uma tabela }
  with ASqlTable, MetaSql do
    for c:=0 to TableJoins.Count-1 do
      if SameText( TableAlias, TableJoins[c].ForeignTableAlias ) then
      begin
        result := TableJoins[c];
        Exit;
      end;
  result := nil;
end;

//function PrettyText(s:string): string;
//begin
//  result := AnsiUpperCase(Copy(s,1,1))+AnsiLowerCase(Copy(s,2,Length(s)));
//end;

procedure OpenItemEditor(
  AEditorClass: TEditorClass;
  X, Y: integer;
  AVisualQuery: TatVisualQuery;
  AMetaSqlDef: TatMetaSqlDef;
  var AEditedObj: TObject );
begin
  { inclui uma condição com o assistente de inclusão }
  with AEditorClass.Create(Application) do
  try
    Left := X;
    Top := Y;
    MetaSqlDef := AMetaSqlDef;
    EditedObject := AEditedObj;
    FVisualQuery := AVisualQuery;
    if ShowModal<>mrCancel then
      AEditedObj := EditedObject;
  finally
    Release;
  end;
end;

procedure TfmCustomEditor.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
   if (word(Key)=VK_RETURN) and
      not (ActiveControl is TListView) then
   begin
      SelectNext(ActiveControl,true,true);
      Key:=#0;
   end;
end;

procedure TfmCustomEditor.ValidationError(ARaise:boolean;msg:string;args:array of const;ctrl:TWinControl);
begin
   if ARaise then
   begin
      ctrl.SetFocus;
      ModalResult := mrNone;
      raise Exception.CreateFmt(msg,args);
   end;
end;

procedure TfmCustomEditor.FormShow(Sender: TObject);
var c: integer;
begin
  { if form do not fit well on the screen, then realign it to the center }
  if (Top+Height > Screen.Height) or
     (Left+Width > Screen.Width) then
  begin
    Left := (Screen.Width-Width) div 2;
    Top := (Screen.Height-Height) div 2;
  end;

  { form visual style }
  case EditorFormStyle of
    esToolWindow:
      begin
        Height := Height - pnTitle.Height;
        pnTitle.Visible := False;
      end;
    esFixedFrame:
      begin
        pnTitle.Visible := True;
        pnTitle.Caption := Caption;
      end;
  end;

  { form color }
  Color := FVisualQuery.Color; 

  { editor customization }
  for c:=0 to ComponentCount-1 do
  begin
    { editor color }
    if (Components[c] is TCustomComboBox) or
       (Components[c] is TCustomEdit) or
       (Components[c] is TCustomListView) then
      {$IFDEF TMSDOTNET}
      (Components[c] as TControl).Color := FVisualQuery.EditorColor;
      {$ELSE}
      HackWinControl(Components[c]).Color := FVisualQuery.EditorColor;
      {$ENDIF}

    { default key press processing }
    if Components[c] is TComboBox then
      TComboBox(Components[c]).OnKeyPress := ProcessLookupComboKey;
  end;
end;

procedure TfmCustomEditor.AdjustDefaultItems;
var c: integer;
begin
   { ajusta todos os ComboBox para seu primeiro item, quando houver }
   for c:=0 to ComponentCount-1 do
      if (Components[c] is TComboBox) then
         with TComboBox(Components[c]) do
            if (Items.Count>0) and (ItemIndex=-1) then
               ItemIndex:=0;
end;

function TfmCustomEditor.ParseMetaSql(const sql:string):TatMetaSql;
begin
   result := TatMetaSql.Create(Self);
   try
      SQLStringToMetaSQL(sql,result);
      { retorna a meta-sql criada aqui }

   except
      { em caso de falha no parsing, destrói a meta-sql criada aqui }
      result.Free;
      raise;
   end;
end;

procedure TfmCustomEditor.SetEditedObject(
  const Value: TObject);
begin
  FEditedObject := Value;
end;

function TfmCustomEditor.MetaSql: TatMetaSql;
begin
   result := MetaSqlDef.MetaSql;
end;

procedure TfmCustomEditor.FormPaint(Sender: TObject);
begin
  with Canvas, ClientRect do
  begin
    case EditorFormStyle of
      esToolWindow:
        begin
          { render the raised outline frame }
          Brush.Color := clBtnShadow;
          FrameRect(Rect(Left,Top,Right,Bottom));
        end;
      esFixedFrame:
        begin
          { render the raised outline frame }
          Brush.Color := clBlack;
          FrameRect(Rect(Left,Top,Right-2,Bottom-2));
          Brush.Color := clGray;
          FrameRect(Rect(Left+2,Bottom-2,Right,Bottom));
          FrameRect(Rect(Right-2,Top+2,Right,Bottom));
        end;
    end;
  end;
end;

procedure TfmCustomEditor.LoadParamNameCombo(combo:TComboBox);
var c, i : integer;
    txt : string;
begin
  { carrega a lista de nomes de parâmetros com sugestões de nomes }
  txt := combo.Text;
  combo.Items.Clear;
  with MetaSqlDef.MetaSql do
  begin
    { carrega os Params presentes na meta-sql }
    for c:=0 to Params.Count-1 do
      combo.Items.AddObject( Params[c].Name, Params[c] );

    { carrega os Fields presentes na meta-sql }
    for c:=0 to SqlFields.Count-1 do
      if combo.Items.IndexOf( SqlFields[c].FieldAlias )=-1 then
        combo.Items.AddObject( SqlFields[c].FieldAlias, SqlFields[c] );
  end;
  { tenta recuperar o item anteriormente posicionado no combo }
  i:=combo.Items.IndexOf(txt);
  if (i>-1) then
    combo.ItemIndex := i;
end;

procedure TfmCustomEditor.AdjustClientRect(var Rect: TRect);
begin
  inherited;
  { adjust the actual client rect, reserving space to the outline frame }
  with Rect do
  begin
     if EditorFormStyle=esToolWindow then
     begin
       Left := Left + 1;
       Top := Top + 1;
       Right := Right - 1;
       Bottom := Bottom - 1;
     end
     else
     begin
       Left := Left + 1;
       Top := Top + 1;
       Right := Right - 3;
       Bottom := Bottom - 3;
     end;
  end;
end;

procedure TfmCustomEditor.btOkClick(Sender: TObject);
var c: integer;
begin
  { execute OnEnter and OnExit for all editors}
  {$IFDEF TMSDOTNET}
  for c:=0 to ComponentCount-1 do
    if (Components[c] is TWinControl) then
      with Components[c] as TWinControl do
      begin
        Perform(CM_ENTER, 0, 0);
        Perform(CM_ENTER, 0, 0);
      end;
  {$ELSE}
  for c:=0 to ComponentCount-1 do
    if (Components[c] is TWinControl) then
      with HackWinControl(Components[c]) do
      begin
        if Assigned(OnEnter) then
          OnEnter(Self);
        if Assigned(OnExit) then
          OnExit(Self);
      end;
  {$ENDIF}
end;

function TfmCustomEditor.ComboMatchItem( combo:TComboBox; txt:string ):boolean;
var ss,i:integer;
begin
   result:=false;
   { verifica se a digitação do combo equivale a algum item, neste caso aponta para este item }
   with combo do
   begin
      i:=Items.IndexOf(Txt);
      if (i<>ItemIndex) then
      begin
         if (i>-1) then
         begin
            ss:=SelStart;
            ItemIndex:=i;
            SelStart:=ss+1;
            result:=true;
         end;
      end;
   end;
end;

procedure TfmCustomEditor.ProcessLookupComboKey( Sender: TObject; var key:char );
var c     : integer;
    aux0  : string;
    aux1  : string;
    combo : TComboBox;
begin
   { sugere o complemento para a digitação feita com base nos itens do combo }
   combo := Sender as TCombobox;
   with combo do
   begin
      if (key>#32) then
      begin
         aux0:=Text;
         Delete(aux0,SelStart+1,SelLength);
         Insert(Key,aux0,SelStart+1);
         if (SelStart+1>=length(aux0)) then
         begin
            for c:=0 to Items.Count-1 do
            begin
               if pos(AnsiUpperCase(aux0),AnsiUpperCase(items[c]))=1 then
               begin
                  aux1:=aux0;
                  ItemIndex:=c;
                  SelStart:=length(aux1);
                  SelLength:=length(Text)-SelStart+1;
                  Key:=#0;
                  Exit;
              end;
            end;
         end;
         if ComboMatchItem(combo,aux0) then key:=#0;
      end
      else
         if word(key)=VK_BACK then
         begin
            aux0:=Text;
            Delete(aux0,SelStart+1,SelLength);
            if SelLength=0 then Delete(aux0,SelStart,1);
            if ComboMatchItem(combo,aux0) then Key:=#0;
         end;
   end;
end;

function TfmCustomEditor.ComboFindObject( combo:TComboBox; i:integer ):integer;
begin
   with combo do
      for result:=0 to Items.Count-1 do
         if i=integer(Items.Objects[result]) then exit;
   result:=-1;
end;

procedure TfmCustomEditor.LoadTableNameList(lst: TStrings);
begin
  if Assigned(FVisualQuery) and
    Assigned(FVisualQuery.Database) then
    FVisualQuery.Database.LoadTableNameList(lst);
end;

procedure TfmCustomEditor.LoadFieldNameList(ATableName: string; lst: TStrings);
begin
  if Assigned(FVisualQuery) and
    Assigned(FVisualQuery.Database) then
    FVisualQuery.Database.LoadFieldNameList(ATablename,lst);
end;

procedure TfmCustomEditor.SetVisualQuery(const Value: TatVisualQuery);
begin
  FVisualQuery := Value;
end;

procedure TfmCustomEditor.Localize;
begin
  Self.Caption := _str('fmCustomEditor.Self.Caption');
  btOk.Caption := _str('fmCustomEditor.btOk.Caption');
  btCancel.Caption := _str('fmCustomEditor.btCancel.Caption');
  lbInfo.Caption := _str('fmCustomEditor.lbInfo.Caption');
end;

procedure TfmCustomEditor.Loaded;
begin
  inherited;
  Localize;
end;

end.
