unit atQueryCombo;

{$I tmsdefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  {$IFDEF DELPHI6_LVL}Variants,{$ENDIF}
  StdCtrls, ExtCtrls, DB, DBTables;

type
  TatComboBox = class;
  TKeyValueNotFoundEvent = procedure (Sender:TatComboBox;AKeyValue:integer;var s:string) of object;
  TQuickSearchMode = (qsNone, qsInitial, qsFull);

  TatComboBox = class(TComboBox)
  private
    FKeyValue           : variant;
    FOnLoadItems        : TNotifyEvent;
    FOnKeyValueNotFound : TKeyValueNotFoundEvent;
    FOnSetKeyValue      : TNotifyEvent;
    FQuickSearchMode    : TQuickSearchMode;
    FQuickSearchDelay   : integer;
    FAutosize           : boolean;
    FOnChangeItems      : TNotifyEvent;
    { internal }
    FQuickSearchTimer   : TTimer;
    FKeyValueSearch     : boolean;
    FUpdating           : boolean; 
    procedure SmartComboQuickSearchTimer(Sender: TObject);
    procedure DoQuickSearch;
    function GetKeyValue: variant;
    procedure SetKeyValue(Value: variant);
    procedure CheckPendingQuickSearch;
    procedure UpdateKeyValue;
    procedure SetQuickSearchDelay(const Value: integer);
    procedure StartTimerToQuickSearch;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure CBSetCurSel(var Message: TMessage); message CB_SETCURSEL;
    procedure WMSetText(var Message: TMessage); message WM_SETTEXT;
    procedure CBResetContent(var Message: TMessage); message CB_RESETCONTENT;
    procedure CBAddString(var Message: TMessage); message CB_ADDSTRING;
    procedure CBDeleteString(var Message: TMessage); message CB_DELETESTRING;
    procedure CBInsertString(var Message: TMessage); message CB_INSERTSTRING;
    procedure WMSetReDraw(var Message: TWMSetRedraw); message WM_SETREDRAW;
    procedure DoChangeKeyValue(Value: variant);
    procedure SetInternalAutosize(const Value: boolean);
    procedure StringsChange;
    function ItemsWidth: integer;
  protected
    procedure DropDown; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure DoExit; override;
    procedure Change; override;
    procedure LoadItems; virtual;
    procedure AutoAdjustSize(w: integer); virtual;
  public
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    procedure DoLoadItems; // força a carga dos items do combo
  published
    property KeyValue:variant read GetKeyValue write SetKeyValue;
    property QuickSearchMode:TQuickSearchMode read FQuickSearchMode write FQuickSearchMode default qsFull;
    property KeyValueSearch:boolean read FKeyValueSearch write FKeyValueSearch default false;
    property QuickSearchDelay: integer read FQuickSearchDelay write SetQuickSearchDelay default 0;
    property OnLoadItems : TNotifyEvent read FOnLoadItems write FOnLoadItems;
    property OnKeyValueNotFound:TKeyValueNotFoundEvent read FOnKeyValueNotFound write FOnKeyValueNotFound;
    property OnSetKeyValue:TNotifyEvent read FOnSetKeyValue write FOnSetKeyValue;
    property Autosize: boolean read FAutosize write SetInternalAutosize;
    property OnChangeItems: TNotifyEvent read FOnChangeItems write FOnChangeItems;
  end;

  TatQueryCombo = class(TatComboBox) // *** permitir usar dataset genérico  
  private
    { Private declarations }
    FDatabaseName : string;
    FSql          : TStringList;
    FQuery        : TQuery;
    procedure SetDatabaseName(const Value: string);
    procedure SetSQL(const Value: TStringList);
    procedure LoadItemsFromQuery; 
  protected
    { Protected declarations }
    procedure LoadItems; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property DatabaseName : string read FDatabaseName write SetDatabaseName;
    property SQL          : TStringList read FSQL write SetSQL;
  end;

implementation

uses
  qsRes;

{ TatComboBox }

constructor TatComboBox.Create(AOwner: TComponent);
begin
   inherited;
   FKeyValue := Null;
   { Cria e prepara o temporizador da digitação }
   FQuickSearchTimer:=TTimer.Create(Self);
   with FQuickSearchTimer do
   begin
      Enabled  := false;
      Interval := FQuickSearchDelay;
      OnTimer  := SmartComboQuickSearchTimer;
   end;
   DoChangeKeyValue(Null);
   FQuickSearchMode := qsInitial;
   FKeyValueSearch := false;
end;

destructor TatComboBox.Destroy;
begin
   FQuickSearchTimer.Free;
   inherited;
end;

procedure TatComboBox.DoQuickSearch;
var c       : integer;
    aux     : string;
    i,l,s,p : integer;
    l0,p0   : integer;
begin
  aux := AnsiUpperCase(Text);
  { Se o texto digitado não for um número inteiro e tiver comprimento
    maior que 0 então pesquisa este texto no início dos itens do combo }
  { também não faz a busca rápida se não estiver com o cursor no final do texto
    ou não tiver pressionado algum caracter de digitação (> #32) }
  if (length(aux)>0) and (not FKeyValueSearch or (StrToIntDef(aux,-999999999)=-999999999)) then
  begin
    i := -1;
    s := SelStart;
    l := MaxInt;
    p := MaxInt;
    { A pesquisa nunca distingue maiúsculas de minúsculas }
    case FQuickSearchMode of
      qsNone:
        begin
          { Pesquisa por correspondência exata }
          for c:=0 to Items.Count-1 do
            if AnsiCompareText(aux,items[c])=0 then
            begin
              i:=c;
              Break;
            end;
          { Não seleciona nada }
          l:=0;
        end;
      qsInitial:
        begin
          { procura o primeiro item que tenha o fragmento digitado como
            parte inicial }
          for c:=0 to Items.Count-1 do
            if (pos(aux,AnsiUpperCase(items[c]))=1) then
            begin
              i := c;
              l := Length(Items[i]);
              Break;
            end;
          { Seleciona do cursor até o final do texto }
          l := l - s + 1;
        end;
      qsFull:
        begin
          { pesquisa o texto em qualquer posição, mas dá preferência pela
            correspondência mais próxima do início ou pelo item mais curto
            quando estirem coincidências na mesma posição }
          for c:=0 to Items.Count-1 do
          begin
            l0:=Length(Items[c]);
            p0:=pos(AnsiUpperCase(aux),AnsiUpperCase(items[c]));
            if (p0>0) and ((p0<p) or ((p0=p) and (l0<l))) then
            begin
              i:=c;
              l:=l0;
              p:=p0;
            end;
          end;
          { Seleciona do final do fragmento até o final do texto }
          s := SelStart+p-1;
          l := Length(Items[i])-s+1;
        end;
    end;
    { Se encontrou correspondência, então atualiza o texto e a chave }
    if i>-1 then
    begin
      ItemIndex := i;
      {$WARNINGS OFF}
      DoChangeKeyValue( integer(Items.Objects[i]) );
      {$WARNINGS ON}
      SelStart := s;
      SelLength := l;
    end;
  end;
end;

procedure TatComboBox.CheckPendingQuickSearch;
begin
  if FQuickSearchTimer.Enabled then
     SmartComboQuickSearchTimer(Self);
end;

procedure TatComboBox.DoExit;
begin
  inherited;
  { Se existe alguma pesquisa pendente então a atualiza na saída do combo }
  CheckPendingQuickSearch;
  { Se o texto foi deixado com um número então tenta traduzir este código
    a partir dos itens do combo, se não encontrar o código então gera um
    evento notificando que o código digitado não existe no combo }
  if (ItemIndex=-1) and (FKeyValueSearch) and (StrToIntDef(Text,-999999999)<>-999999999) then
    KeyValue := StrToInt(Text);
  { Deixa o cursor posicionado no final }
  SelStart := Length(Text)+1;
end;

procedure TatComboBox.DropDown;
begin
  { Quando tentar abrir a lista de itens, certifica-se que os itens estão
    atualizados }
  DoLoadItems;
  inherited;
end;

procedure TatComboBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  { Se está tentado percorrer pelos itens do combo então certifica que os
    itens estejam atualizados }
  if (Shift=[]) and (Key=VK_DOWN) or (key=VK_UP) then
    DoLoadItems;
  inherited;
end;

procedure TatComboBox.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  { Se o conteúdo não for um número inteiro e a tecla pressionada
    foi digitada como um caracter no final do texto, então inicia a busca rápida }
  if (not FKeyValueSearch or (StrToIntDef(Text,-999999999)=-999999999))
    and (Key<>VK_DELETE) and (Key>=32) and (Key<=255) and (SelStart=Length(Text)) then
    { Reinicia o temporizador da busca rápida a cada tecla pressionada }
    StartTimerToQuickSearch;
end;

procedure TatComboBox.StartTimerToQuickSearch;
begin
  with FQuickSearchTimer do
  begin
    if Interval>0 then
    begin
      { start a delay to make search }
      Enabled := False;
      Enabled := True;
    end
    else
      { do not delay, just execute OnTimer }
      if Assigned(OnTimer) then
        OnTimer(Self);
  end;
end;

procedure TatComboBox.SmartComboQuickSearchTimer(Sender:TObject);
begin
  FQuickSearchTimer.Enabled := False;
  { Para fazer a busca rápida, primeiro certifica-se que os itens estejam
    atualizados }
  DoLoadItems;
  DoQuickSearch;
end;

procedure TatComboBox.DoLoadItems;
var aux   : string;
    s,l,i : integer;
begin
  { Atualiza os itens do combo através do Evento, mas mantém o texto inalterado }
  aux:=Text;
  s:=SelStart;
  l:=SelLength;
  i:=ItemIndex;
  LoadItems;
  { Restaura o estado do combo anterior à atualização }
  if (i<Items.Count) and (Items[i]=aux) then
     ItemIndex:=i
  else
     Text:=aux;
  SelStart:=s;
  SelLength:=l;
end;

procedure TatComboBox.LoadItems;
begin
  if Assigned(FOnLoadItems) then
    FOnLoadItems(Self);
end;

function TatComboBox.GetKeyValue: variant;
begin
  { Se existe alguma pesquisa pendente então a atualiza na saída do combo }
  CheckPendingQuickSearch;
  result := FKeyValue;
end;

procedure TatComboBox.SetKeyValue(Value: variant);
var s: string;
begin
  if Value <> FKeyValue then
  begin
    { Tenta encontrar o item no combo, se encontrar posiciona o item
      senão apenas deixa a chave posicionada }
    if not VarIsNull(Value) then
    begin
      { Se a chave não existe permite resolução gerando um evento }
      if (ItemIndex=-1) and Assigned(FOnKeyValueNotFound) then
      begin
        { Permite a tradução do código no evento }
        s := Text;
        FOnKeyValueNotFound( Self, Value, s );
        Text := s;
      end;
    end
    else
      Value := Null;

    DoChangeKeyValue( Value );
  end;
end;

procedure TatComboBox.DoChangeKeyValue(Value: variant);
begin
  { atualiza o valor do FKeyValue (interno) }
  { Atenção! O ItemIndex nem sempre corresponderá ao item corrente de fato,
    O usuário não deve se basear no ItemIndex para obter a chave corrente }
  if Value <> FKeyValue then
  begin
    FKeyValue := Value;
    if Assigned(FOnSetKeyValue) then
      FOnSetKeyValue( Self );
  end;
end;

procedure TatComboBox.UpdateKeyValue;
var i : variant;
begin
  { ajusta o valor do KeyValue de acordo com o texto selecionado no combo }

  { se o não ItemIndex corresponde ao texto selecionado então
    tenta encontrar um item que corresponda ao texto corrente }
  {$WARNINGS OFF}
  if (ItemIndex>-1) and SameText(Items[ItemIndex],Text) then
    i := integer(Items.Objects[ItemIndex])
  else
  begin
    i := Items.IndexOf(Text);
    if (i > -1) then
      i := integer(Items.Objects[i])
    else
      i := Null;
  end;
  {$WARNINGS ON}

  DoChangeKeyValue( i );
end;

procedure TatComboBox.Change;
begin
   inherited;
   UpdateKeyValue;
end;

procedure TatComboBox.SetQuickSearchDelay(const Value: integer);
begin
  FQuickSearchDelay := Value;
end;

procedure TatComboBox.CNCommand(var Message: TWMCommand);
begin
  inherited;
  { se o item corrente na lista foi alterado, também altera a valor da chave }
  case Message.NotifyCode of
    CBN_SELCHANGE, CBN_CLOSEUP: UpdateKeyValue;
  end;
end;

procedure TatComboBox.CBSetCurSel(var Message: TMessage);
begin
  inherited;
  { ao modificar o valor do ItemIndex, também deve atualizar o KeyValue }
  UpdateKeyValue;
end;

procedure TatComboBox.WMSetText(var Message: TMessage);
begin
  inherited;
  { ao modificar o text do combo, também atualiza o KeyValue }
  UpdateKeyValue;
end;

procedure TatComboBox.SetInternalAutosize(const Value: boolean);
begin
  if FAutosize <> Value then
  begin
    FAutosize := Value;
    if FAutosize then
      AutoAdjustSize( ItemsWidth );
  end;
end;

function TatComboBox.ItemsWidth: integer;
var c, w: integer;
begin
  result := Width;
  try
    for c:=0 to Items.Count-1 do
    begin
      w := Canvas.TextWidth(Items[c]) + 4;
      if (c = 0) or (w > result) then
        result := w;
    end;
  except
     // handle not created
     result := Width;
  end;
end;

procedure TatComboBox.AutoAdjustSize( w: integer );
begin
  { descendants can constraint or change the automatic adjustment }
  Width := w;
end;

procedure TatComboBox.StringsChange;
begin
  if Assigned(FOnChangeItems) then
    FOnChangeItems(Self);
  if FAutosize then
    AutoAdjustSize( ItemsWidth );
end;

procedure TatComboBox.CBAddString(var Message: TMessage);
begin
  inherited;
  if not FUpdating then
    StringsChange;
end;

procedure TatComboBox.CBDeleteString(var Message: TMessage);
begin
  inherited;
  if not FUpdating then
    StringsChange;
end;

procedure TatComboBox.CBInsertString(var Message: TMessage);
begin
  inherited;
  if not FUpdating then
    StringsChange;
end;

procedure TatComboBox.CBResetContent(var Message: TMessage);
begin
  inherited;
  if not FUpdating then
    StringsChange;
end;

procedure TatComboBox.WMSetReDraw(var Message: TWMSetRedraw);
begin
  inherited;
  FUpdating := (Message.Redraw = 0);
  if not FUpdating then
    StringsChange;
end;

{ TatQueryCombo }

constructor TatQueryCombo.Create(AOwner: TComponent);
begin
  inherited;
  FSql := TStringList.Create;
end;

destructor TatQueryCombo.Destroy;
begin
  if Assigned(FQuery) then FQuery.Free;
  if Assigned(FSql) then FSql.Free;
  inherited;
end;

procedure TatQueryCombo.LoadItems;
begin
  inherited;
  { if SQL is present then check to see if it is already opened }
  if (FSql.Count>0) and not Assigned(FQuery) then
    { load items from internal query (connected to a TDatabase) }
    LoadItemsFromQuery;
end;

procedure TatQueryCombo.SetDatabaseName(const Value: string);
begin
  FDatabaseName := Value;
end;

procedure TatQueryCombo.SetSQL(const Value: TStringList);
begin
  FSQL := Value;
end;

procedure TatQueryCombo.LoadItemsFromQuery;
var c: integer;
begin
  Screen.Cursor := crHourGlass;
  try
    if FDatabaseName='' then
      raise Exception.Create(_str(SDatabaseNameNotInformed));
    { create the internal query, at first drop down }
    FQuery := TQuery.Create(Self);
    with FQuery do
    try
      DatabaseName := FDatabaseName;
      SQL.Assign( FSql );
      Open;
      if (FieldCount=0) then
        raise Exception.Create(_str(SInvalidSQLForQueryCombo));

      Items.BeginUpdate;
      try
        c := 0;
        while not eof do
        begin
          Inc(c);
          { se o primeiro campo é inteiro então usa-o como chave exclusiva
            senão usa um contador como chave exclusiva }
          {$WARNINGS OFF}
          if (Fields[0].DataType in [ftInteger,ftAutoInc,ftFloat]) then
            Items.AddObject( Fields[1].AsString, TObject(Fields[0].AsInteger) )
          else
            Items.AddObject( Fields[0].AsString, TObject(c) );
          {$WARNINGS ON}
          Next;
        end;                         
      finally
        Items.EndUpdate;
      end;
    except
      on ex: Exception do
      begin
        FreeAndNil(FQuery);
        raise Exception.CreateFmt(
          _str(SErrorOpeningQueryCombo) + #13#10 +
          '''%s'''#13#10 +
          _str(SSQLIs) + #13#10 +
          '''%s''',
          [ ex.message,
            FSql.Text ] );
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

end.
