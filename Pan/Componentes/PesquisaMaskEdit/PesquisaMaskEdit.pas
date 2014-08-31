unit PesquisaMaskEdit;

interface

uses
  SysUtils, Classes, Controls, StdCtrls, Mask, Buttons, DB, DBClient, Graphics,
  Messages, Windows, ZAbstractRODataset, ZAbstractDataset, ZDataset,
   Forms, uPesquisa, StrUtils, Classes_pan,uDMConexao_Pan;
                         
type
  TOnRegAchado = Procedure(ADataSet : TDataSet) of Object;
  TLabelTitulo = Class(TLabel)
  private
    function GetLeft: Integer;
    function GetTop: Integer;
    procedure SetLeft(const Value: Integer);
    procedure SetTop(const Value: Integer);
  published

    Public
      Constructor Create(Aowner : TComponent);Override;
    published
      Property Caption ;
      Property Font;
      Property Name;
      Property Color;
      property Left : Integer read GetLeft write SetLeft;
      Property Top : Integer read GetTop Write SetTop;
  End;
  TBtn = Class(TSpeedButton)
  private
    function GetHeight: Integer;
    function GetLeft: Integer;
    function GetTop: Integer;
    function GetWidth: Integer;
    procedure SetHeight(const Value: Integer);
    procedure SetLeft(const Value: Integer);
    procedure SetTop(const Value: Integer);
    procedure SetWidth(const Value: Integer);
  published
    Public
      Constructor Create(Aowner : TComponent);Override;
    published
      property Name;
      Property Visible;
      Property OnClick;
      property Left : Integer read GetLeft write SetLeft;
      Property Top : Integer read GetTop Write SetTop;
      Property Height : Integer read GetHeight write SetHeight;
      Property Width  : Integer read GetWidth write SetWidth;
  End;
  TEditDisplay = class(TEdit)
  private
    function GetHeight: Integer;
    function GetLeft: Integer;
    function GetTop: Integer;
    function GetWidth: Integer;
    procedure SetHeight(const Value: Integer);
    procedure SetLeft(const Value: Integer);
    procedure SetTop(const Value: Integer);
    procedure SetWidth(const Value: Integer);
  published
     Public
      Constructor Create(Aowner : TComponent);Override;
    published
      property Name;
      Property Visible;
      Property Font;
      property Color;
      property Left : Integer read GetLeft write SetLeft;
      Property Top : Integer read GetTop Write SetTop;
      Property Height : Integer read GetHeight write SetHeight;
      Property Width  : Integer read GetWidth write SetWidth;
  end;

  TaqPesquisaMaskEdit = class(TMaskEdit)
  private
    FDataSet: TDataSet;
    FLblTitulo: TLabelTitulo;
    FBtnPesquisa: TBtn;
    FBtnNovo: TBtn;
    FBtnEditar: TBtn;
    FDisplay: TEditDisplay;
    FCampoChave: String;
    FTitulo: String;
    FNomeTabela: String;
    FCampoDisplay: String;
    FValorChave: Integer;
    FOnRegAchado: TOnRegAchado;
    FTipoPesquisa: TTipoPesquisa;
    FUsaBtnNovo: Boolean;
    FUsaBtnEditar: Boolean;
    FUsaDisplay: Boolean;
    FCampoCodigo: String;
    FTamanhoCodigo: Integer;
    FTamanhoDisplay: Integer;
    function GetHeight: Integer;
    function GetLeft: Integer;
    function GetTop: Integer;
    function GetWidth: Integer;
    procedure SetHeight(const Value: Integer);
    procedure SetLeft(const Value: Integer);
    procedure SetTop(const Value: Integer);
    procedure SetWidth(const Value: Integer);
    procedure SetDataSet(const Value: TDataSet);
    procedure SetLblTitulo(const Value: TLabelTitulo);
    procedure SetBtnPesquisa(const Value: TBtn);
    procedure SetBtnNovo(const Value: TBtn);
    procedure SetBtnEditar(const Value: TBtn);
    procedure SetDisplay(const Value: TEditDisplay);
    function GetDireita: Integer;
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
    procedure SetCampoChave(const Value: String);
    procedure SetCampoDisplay(const Value: String);
    procedure SetNomeTabela(const Value: String);
    procedure SetTitulo(const Value: String);
    procedure SetValorChave(const Value: Integer);
    procedure SetOnRegAchado(const Value: TOnRegAchado);
    procedure SetTipoPesquisa(const Value: TTipoPesquisa);
    procedure SetUsaBtnNovo(const Value: Boolean);
    procedure SetUsaBtnEditar(const Value: Boolean);
    procedure SetUsaDisplay(const Value: Boolean);
    procedure SetCampoCodigo(const Value: String);
    procedure SetTamanhoCodigo(const Value: Integer);
    procedure SetTamanhoDisplay(const Value: Integer);
    { Private declarations }
  protected
    { Protected declarations }
    Procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    Procedure SetParent(AParent: TWinControl); override;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer;
      AHeight: Integer); override;
    procedure CMVisiblechanged(var Message: TMessage);
      message CM_VISIBLECHANGED;
    procedure CMEnabledchanged(var Message: TMessage);
      message CM_ENABLEDCHANGED;
    Procedure DisplayPosition;
    Procedure BtnNovoPosition;
    Procedure BtnEditarPosition;
    Procedure BtnPesquisaPosition;
    Procedure LblTituloPosition;
    Procedure AtuObj;
    Procedure BtnPesquisaClick(Sender : TObject) ;
  public
    { Public declarations }
    Constructor Create(Aowner : TComponent);Override;
    Procedure Configurar(aDataSet : TClientDataSet;aCampoChave : String ; aNomeTabela : String ;
                         aCampoDisplay : String; aTitulo : String; aTipoPesquisa : TTipoPesquisa;
                         aCampoCodigo: String = 'CODIGO'; aTamanhoCodigo : Integer = 6);
    Procedure Localiza ;
    Property ValorChave : Integer read FValorChave write SetValorChave;
  published
    { Published declarations }
    property Left : Integer read GetLeft write SetLeft;
    Property Top : Integer read GetTop Write SetTop;
    Property Height : Integer read GetHeight write SetHeight;
    Property Width  : Integer read GetWidth write SetWidth;
    Property Direita : Integer read GetDireita;

    Property DataSet : TDataSet read FDataSet write SetDataSet;
    Property CampoChave : String read FCampoChave write SetCampoChave;
    Property NomeTabela : String read FNomeTabela write SetNomeTabela;
    Property CampoDisplay : String read FCampoDisplay write SetCampoDisplay;
    Property Titulo : String read FTitulo write SetTitulo;
    Property TipoPesquisa :TTipoPesquisa read FTipoPesquisa write SetTipoPesquisa;
    Property CampoCodigo : String read FCampoCodigo write SetCampoCodigo;
    Property TamanhoCodigo : Integer read FTamanhoCodigo write SetTamanhoCodigo;

    
    Property OnRegAchado : TOnRegAchado read FOnRegAchado write SetOnRegAchado;
    Property UsaBtnNovo : Boolean read FUsaBtnNovo write SetUsaBtnNovo;
    Property UsaBtnEditar : Boolean read FUsaBtnEditar write SetUsaBtnEditar;
    Property UsaDisplay : Boolean read FUsaDisplay write SetUsaDisplay;

    Property LblTitulo : TLabelTitulo read FLblTitulo write SetLblTitulo;
    Property BtnPesquisa : TBtn read FBtnPesquisa write SetBtnPesquisa;
    Property BtnNovo : TBtn read FBtnNovo write SetBtnNovo;
    Property BtnEditar : TBtn read FBtnEditar write SetBtnEditar;
    Property Display : TEditDisplay read FDisplay Write SetDisplay;
    Property TamanhoDisplay : Integer read FTamanhoDisplay write SetTamanhoDisplay;


  end;

procedure Register;

implementation


procedure Register;
begin
  RegisterComponents('Kimera', [TaqPesquisaMaskEdit]);
end;

{ TLabelTitulo }

constructor TLabelTitulo.Create(Aowner: TComponent);
begin
  inherited create(Aowner);
  SetSubComponent(True);
  Name := 'Lbl';
  if Assigned(Aowner) then
    Caption := Aowner.Name;
 
end;

function TLabelTitulo.GetLeft: Integer;
begin
   Result := inherited Left;
end;

function TLabelTitulo.GetTop: Integer;
begin
   Result := inherited Top;
end;

procedure TLabelTitulo.SetLeft(const Value: Integer);
begin
  inherited Left := Value;
end;

procedure TLabelTitulo.SetTop(const Value: Integer);
begin
  inherited Top := Value;
end;

{ TBtn }

constructor TBtn.Create(Aowner: TComponent);
begin
  inherited Create(Aowner);
  SetSubComponent(True);
  Name := 'Btn';
  if Assigned(Aowner) then
    Caption := Aowner.Name;
  Width := 21;
  Height := 21;
end;

function TBtn.GetHeight: Integer;
begin
   Result := inherited Height;
end;

function TBtn.GetLeft: Integer;
begin
   Result := inherited Left;
end;

function TBtn.GetTop: Integer;
begin
  Result := inherited Top;
end;

function TBtn.GetWidth: Integer;
begin
  Result := inherited Width;
end;

procedure TBtn.SetHeight(const Value: Integer);
begin
  inherited Height := Value
end;

procedure TBtn.SetLeft(const Value: Integer);
begin
  inherited Left := Value
end;

procedure TBtn.SetTop(const Value: Integer);
begin
   inherited Top := Value
end;

procedure TBtn.SetWidth(const Value: Integer);
begin
  inherited width := Value
end;

{ TaqPesquisaMaskEdit }

procedure TaqPesquisaMaskEdit.AtuObj;
begin
  LblTituloPosition;
  BtnPesquisaPosition;
  BtnNovoPosition;
  BtnEditarPosition;
  DisplayPosition;
end;

procedure TaqPesquisaMaskEdit.BtnEditarPosition;
var
  P : TPOint;
begin
  if FBtnEditar = nil then
    Exit;

  P := Point(Left + WIdth+FBtnPesquisa.Width + 2, Top);
  if FBtnNovo <> nil then
    P := Point(Left + WIdth+FBtnPesquisa.Width+FBtnNovo.Width + 2, Top);
  FBtnEditar.SetBounds(P.X, P.Y, FBtnEditar.Width, Height);
end;

procedure TaqPesquisaMaskEdit.BtnNovoPosition;
var
  P : TPOint;
begin
  if FBtnNovo = nil then
    Exit;
  P := Point(Left + WIdth +FBtnPesquisa.Width +2, Top);
  FBtnNovo.SetBounds(P.X, P.Y, FBtnNovo.Width, Height);
end;

procedure TaqPesquisaMaskEdit.BtnPesquisaClick(Sender: TObject);
begin
  frmPesquisa := TfrmPesquisa.Create(Self);
  Try
    with frmPesquisa do
    Begin
       frmPesquisa.TipoPesquisa := FTipoPesquisa;
       frmPesquisa.Titulo := IfThen(FTitulo <> '', FTitulo,frmPesquisa.Titulo );
       if ShowModal = mrOk then
       Begin
         Text := CdsPesquisa.FieldByName(FCampoCodigo).AsString;
         Self.Localiza;
       End;
    End;
  Finally
    FreeAndNil(frmPesquisa);
  End;
end;

procedure TaqPesquisaMaskEdit.BtnPesquisaPosition;
var
  P : TPOint;
begin
  if FBtnPesquisa = nil then
    Exit;
  P := Point(Left + WIdth + 2, Top);
  FBtnPesquisa.SetBounds(P.X, P.Y, FBtnPesquisa.Width, Height);
end;

procedure TaqPesquisaMaskEdit.CMEnabledchanged(var Message: TMessage);
begin
  if FLblTitulo <> nil then
    FLblTitulo.Visible := Enabled;
  if FBtnPesquisa <> nil then
    FBtnPesquisa.Visible := Enabled;
  if FBtnNovo <> nil then
    FBtnNovo.Visible := Enabled;
  if FbtnEditar <> nil then
    FbtnEditar.Visible := Enabled;
  if FDisplay <> nil then
    FDisplay.Visible := Enabled;

end;

procedure TaqPesquisaMaskEdit.CMVisiblechanged(var Message: TMessage);
begin
  if FLblTitulo <> nil then
    FLblTitulo.Visible := Visible;
  if FBtnPesquisa <> nil then
    FBtnPesquisa.Visible := Visible;
  if FBtnNovo <> nil then
    FBtnNovo.Visible := Visible;
  if FbtnEditar <> nil then
    FbtnEditar.Visible := Visible;
  if FDisplay <> nil then
    FDisplay.Visible := Visible;

end;

procedure TaqPesquisaMaskEdit.CNKeyDown(var Message: TWMKeyDown);
begin
  inherited;
  with message do
  Begin
   if not (csDesigning in ComponentState) then
    begin
      Case CharCode of
      VK_F2 :
      Begin
        FBtnPesquisa.Click;
        
      End;
      VK_F3 :
        FBtnNovo.Click;
      vk_F5 :
        FBtnEditar.Click;
      VK_RETURN:
      Begin
        if Length(Text) < 6 then
           Text := FormatFloat('000000', StrToInt(Text));
        Localiza;
      End;
      end;
    end;
  End;

end;

procedure TaqPesquisaMaskEdit.Configurar(aDataSet: TClientDataSet; aCampoChave,
  aNomeTabela, aCampoDisplay: String; aTitulo: String; aTipoPesquisa : TTipoPesquisa;
  aCampoCodigo: String = 'CODIGO'; aTamanhoCodigo : Integer = 6);
begin
  FDataSet := aDataSet;
  FCampoChave := aCampoChave;
  FNomeTabela := aNomeTabela;
  FCampoDisplay := aCampoDisplay;
  FTitulo := aTitulo;
  FTipoPesquisa := aTipoPesquisa ;
  FCampoCodigo := aCampoCodigo;
  FTamanhoCodigo := aTamanhoCodigo;
end;

constructor TaqPesquisaMaskEdit.Create(Aowner: TComponent);
begin
  inherited Create(Aowner);
  Width := 65;
  Text := '';
  
  FLblTitulo := TLabelTitulo.Create(Self);
  FLblTitulo.FreeNotification(Self);
  FLblTitulo.Name :=Self.Name + 'LblTitulo';
  FLblTitulo.Top := Self.Top - Height + 6;
  FLblTitulo.Left := Self.Left ;
  FLblTitulo.Caption := 'Titulo';

  FBtnPesquisa := TBtn.Create(Self);
  FBtnPesquisa.FreeNotification(Self);
  FBtnPesquisa.Name := Self.Name + 'BtnPesquisa';
  FBtnPesquisa.Left := Left +2;
  FBtnPesquisa.Top := Top;
  FBtnPesquisa.Height := Height;
  FBtnPesquisa.Caption := '';
  FBtnPesquisa.Hint :='F2 para pesquisar';
  FBtnPesquisa.ShowHint := True;
  FBtnPesquisa.OnClick := BtnPesquisaClick;
  
  FBtnNovo := TBtn.Create(Self);
  FBtnNovo.FreeNotification(Self);
  FBtnNovo.Name := Self.Name + 'BtnNovo';
  FBtnNovo.Left := Left +2;
  FBtnNovo.Top := Top;
  FBtnNovo.Height := Height;
  FBtnNovo.Hint :='F3 para criar novo registro';
  FBtnNovo.ShowHint := True;


  FBtnEditar := TBtn.Create(Self);
  FBtnEditar.FreeNotification(Self);
  FBtnEditar.Name := Self.Name + 'BtnEditar';
  FBtnEditar.Left := Left +2;
  FBtnEditar.Top := Top;
  FBtnEditar.Height := Height;
  FBtnEditar.Hint :='F5 para editar esse registro';
  FBtnEditar.ShowHint := True;

  FDisplay := TEditDisplay.Create(Self);
  FDisplay.FreeNotification(Self);
  FDisplay.Name := Self.Name + 'Display';
  FDisplay.Top := Self.Top;
  FDisplay.Height := Self.Height;
  FDisplay.Left := Left + WIdth+FBtnPesquisa.Width+FBtnNovo.Width +FBtnEditar.Width+ 2;

  FUsaBtnNovo := True;
  FUsaBtnEditar := True;
  FUsaDisplay := True;

  LblTituloPosition;
  BtnPesquisaPosition;
  BtnNovoPosition;
  BtnEditarPosition;
  DisplayPosition;
 
end;

procedure TaqPesquisaMaskEdit.DisplayPosition;
var
  P : TPOint;
begin
  if FDisplay = nil then
    Exit;

  P := Point(Left + WIdth+FBtnPesquisa.Width + 2, Top);
  if (FBtnNovo <> nil ) and (FBtnNovo.Visible ) then
    P := Point(Left + WIdth+FBtnPesquisa.Width+FBtnNovo.Width + 2, Top)
  else
    P := Point(Left + WIdth+FBtnPesquisa.Width+ + 2, Top);

  if (FBtnEditar <> nil) and (FBtnEditar.Visible) then
    if (FBtnNovo <> nil) and (FBtnNovo.Visible) then
      P := Point(Left + WIdth+FBtnPesquisa.Width+FBtnNovo.Width +FBtnEditar.Width+ 2, Top)
    else
      P := Point(Left + WIdth+FBtnPesquisa.Width+FBtnEditar.Width+ 2, Top)
  else
    P := Point(Left + WIdth+FBtnPesquisa.Width+ 2, Top);
    
  FDisplay.SetBounds(P.X, P.Y, FDisplay.Width, Height);

end;

function TaqPesquisaMaskEdit.GetDireita: Integer;
begin
  Result := Left + Width;
  if FBtnPesquisa <> nil then
    Result := Result + FBtnPesquisa.Left + FBtnPesquisa.Width;
  if FBtnNovo <> nil then
    Result := Result + FBtnNovo.Left + FBtnNovo.Width;
  if FBtnEditar <> nil then
    Result := Result + FBtnEditar.Left + FBtnEditar.Width;
  if FDisplay <> nil then
    Result := Result + FDisplay.Left + FDisplay.Width;
end;

function TaqPesquisaMaskEdit.GetHeight: Integer;
begin
   Result := inherited Height;
end;

function TaqPesquisaMaskEdit.GetLeft: Integer;
begin
   Result := inherited Left;
end;

function TaqPesquisaMaskEdit.GetTop: Integer;
begin
  Result := inherited Top;
end;

function TaqPesquisaMaskEdit.GetWidth: Integer;
begin
  Result := inherited Width;
end;

procedure TaqPesquisaMaskEdit.LblTituloPosition;
var
  P : TPOint;
begin
  if FLblTitulo = nil then
     Exit;
  P := Point(Left, Top - Height + 6);
  FLblTitulo.SetBounds(P.X, p.Y, FLblTitulo.Width, FLblTitulo.Height);
end;

procedure TaqPesquisaMaskEdit.Localiza;
var
  StrSQL : String;
  Q : TZQuery;
begin
  if (FCampoCodigo  = '')and  (FCampoChave = '') and (FCampoDisplay = '') then
    Exit;
  if FDataSet <> nil then
  Begin
    if Trim(Text) = '' then
     Text :=  FDataSet.FieldByName(FCampoCodigo).AsString;
  End;
  StrSQL :=
    'SELECT '+FCampoCodigo+', '+ FCampoChave+','+ FCampoDisplay+
    '  FROM '+FNomeTabela +
    ' WHERE '+FCampoCodigo+ '= '+ QuotedStr(Self.Text);
  Q := TZQuery.Create(nil);
  Try
    Q.Connection := DMCOnexao.Conexao;
    Q.Close;
    Q.SQL.Text := StrSQL;
    Q.Open;
    if Trim(Text) = '' then
         Exit;
    if Q.IsEmpty then
    Begin
      Application.MessageBox('Não foi encontrado nenhum registro com esse código.','Atenção');
      Exit;
    End;
    Text := Q.FieldByName(FCampoCodigo).AsString;
    FDisplay.Text :=Q.FieldByName(FCampoDisplay).AsString;
    FValorChave := Q.FieldByName(FCampoChave).AsInteger;
    if FDataSet <> NIL then
    Begin
      if   (FDataSet.State in [dsInsert, dsEdit]) then
      Begin
        FDataSet.FieldByName(FCampoChave).AsInteger :=  FValorChave;
      End;

    End;
    if Assigned(FOnRegAchado) then
       FOnRegAchado(Q);
  Finally
    FreeAndNil(Q);
  End;
end;

procedure TaqPesquisaMaskEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FLblTitulo ) and (Operation = opRemove)then
     FLblTitulo := nil;
  if (AComponent = FBtnPesquisa ) and (Operation = opRemove)then
    FBtnPesquisa := nil;
  if (AComponent = FBtnNovo ) and (Operation = opRemove)then
     FBtnNovo := nil;
  if (AComponent = FBtnEditar ) and (Operation = opRemove)then
     FBtnEditar := nil;
  if (AComponent = FDisplay ) and (Operation = opRemove)then
     FDisplay := nil;
  
end;

procedure TaqPesquisaMaskEdit.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  AtuObj;
end;

procedure TaqPesquisaMaskEdit.SetBtnEditar(const Value: TBtn);
begin
  FBtnEditar := Value;
end;

procedure TaqPesquisaMaskEdit.SetBtnNovo(const Value: TBtn);
begin
  FBtnNovo := Value;
end;

procedure TaqPesquisaMaskEdit.SetBtnPesquisa(const Value: TBtn);
begin
  FBtnPesquisa := Value;
end;

procedure TaqPesquisaMaskEdit.SetCampoChave(const Value: String);
begin
  FCampoChave := Value;
end;

procedure TaqPesquisaMaskEdit.SetCampoCodigo(const Value: String);
begin
  FCampoCodigo := Value;
end;

procedure TaqPesquisaMaskEdit.SetCampoDisplay(const Value: String);
begin
  FCampoDisplay := Value;
end;

procedure TaqPesquisaMaskEdit.SetDataSet(const Value: TDataSet);
begin
  FDataSet := Value;
end;

procedure TaqPesquisaMaskEdit.SetDisplay(const Value: TEditDisplay);
begin
  FDisplay := Value;
end;

procedure TaqPesquisaMaskEdit.SetHeight(const Value: Integer);
begin
  inherited Height := Value;
end;

procedure TaqPesquisaMaskEdit.SetLblTitulo(const Value: TLabelTitulo);
begin
  FLblTitulo := Value;
end;

procedure TaqPesquisaMaskEdit.SetLeft(const Value: Integer);
begin
  inherited Left := Value;
end;

procedure TaqPesquisaMaskEdit.SetNomeTabela(const Value: String);
begin
  FNomeTabela := Value;
end;

procedure TaqPesquisaMaskEdit.SetOnRegAchado(const Value: TOnRegAchado);
begin
  FOnRegAchado := Value;
end;

procedure TaqPesquisaMaskEdit.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  if FLblTitulo <> nil then
  Begin
    FLblTitulo.SetParent(AParent);
    FLblTitulo.Visible := True;
  End;
  if FBtnPesquisa <> nil then
  Begin
    FBtnPesquisa.SetParent(AParent);
    FBtnPesquisa.Visible := True;
  End;
  if FBtnNovo <> nil then
  Begin
    FBtnNovo.SetParent(AParent);
    FBtnNovo.Visible := True;
  End;
  if FBtnEditar <> nil then
  Begin
    FBtnEditar.SetParent(AParent);
    FBtnEditar.Visible := True;
  End;
  if FDisplay <> nil then
  Begin
    FDisplay.SetParent(AParent);
    FDisplay.Visible := True;
  End;



end;

procedure TaqPesquisaMaskEdit.SetTamanhoCodigo(const Value: Integer);
begin
  FTamanhoCodigo := Value;
  Self.MaxLength := Value;
end;

procedure TaqPesquisaMaskEdit.SetTamanhoDisplay(const Value: Integer);
begin
   FTamanhoDisplay := Value;
   FDisplay.Width := Value;
   AtuObj;
end;

procedure TaqPesquisaMaskEdit.SetTipoPesquisa(const Value: TTipoPesquisa);
begin
  FTipoPesquisa := Value;
end;

procedure TaqPesquisaMaskEdit.SetTitulo(const Value: String);
begin
  FTitulo := Value;
end;

procedure TaqPesquisaMaskEdit.SetTop(const Value: Integer);
begin
   inherited Top := Value;
end;

procedure TaqPesquisaMaskEdit.SetUsaBtnEditar(const Value: Boolean);
begin
  FUsaBtnEditar := Value;
  FBtnEditar.Visible := Value;
  AtuObj;
end;

procedure TaqPesquisaMaskEdit.SetUsaBtnNovo(const Value: Boolean);
begin
  FUsaBtnNovo := Value;
  FBtnNovo.Visible := Value;
  AtuObj;
end;

procedure TaqPesquisaMaskEdit.SetUsaDisplay(const Value: Boolean);
begin
  FUsaDisplay := Value;
  FDisplay.Visible := Value ;
  AtuObj;
end;

procedure TaqPesquisaMaskEdit.SetValorChave(const Value: Integer);
begin
  FValorChave := Value;
end;

procedure TaqPesquisaMaskEdit.SetWidth(const Value: Integer);
begin
  inherited Width := Value;
end;

{ TEditDisplay }

constructor TEditDisplay.Create(Aowner: TComponent);
begin
  inherited Create(Aowner);
  SetSubComponent(True);
  Name := 'EdtDisplay';
  if Assigned(Aowner) then
    Caption := Aowner.Name;
  Self.Color := clSkyBlue;
  Self.Width := 200;
  Self.ReadOnly := True;
  Self.TabStop := False;
end;

function TEditDisplay.GetHeight: Integer;
begin
  Result := inherited Height;
end;

function TEditDisplay.GetLeft: Integer;
begin
  Result := inherited Left;
end;

function TEditDisplay.GetTop: Integer;
begin
  Result := inherited Top;
end;

function TEditDisplay.GetWidth: Integer;
begin
  Result := inherited Width;
end;

procedure TEditDisplay.SetHeight(const Value: Integer);
begin
  inherited Height := Value;
end;

procedure TEditDisplay.SetLeft(const Value: Integer);
begin
  inherited Left := Value;
end;

procedure TEditDisplay.SetTop(const Value: Integer);
begin
  inherited Top := Value;
end;

procedure TEditDisplay.SetWidth(const Value: Integer);
begin
  inherited Width := Value;
end;

end.
