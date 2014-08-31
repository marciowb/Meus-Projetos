unit uPesquisa_PAN;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao_Pan, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, ExtCtrls, StdCtrls, Menus, cxLookAndFeelPainters, cxButtons, DBClient,
  Classes_Pan, StrUtils, JvExControls, JvEnterTab, cxContainer, cxListBox,
  cxDBEdit, Mask, cxLabel, cxDBLabel, DBCtrls, cxProgressBar, cxDBProgressBar,
  cxTextEdit, cxMemo;

type


  TfrmPesquisa = class(TfrmPadrao)
    Panel1: TPanel;
    pnlRodape: TPanel;
    TvPesquisa: TcxGridDBTableView;
    GridPesquisaLevel1: TcxGridLevel;
    GridPesquisa: TcxGrid;
    btnProcura: TcxButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    chkPorParte: TCheckBox;
    chkTempoReal: TCheckBox;
    btnOk: TcxButton;
    btnCancelar: TcxButton;
    DataPesquisa: TDataSource;
    CdsPesquisa: TClientDataSet;
    CdsCamposPesquisa: TClientDataSet;
    CdsCamposPesquisaDisplayCampo: TStringField;
    CdsCamposPesquisaCampoBD: TStringField;
    CdsCamposPesquisaTipoCampo: TIntegerField;
    DataCampoPesquisa: TDataSource;
    edtPesquisa: TMaskEdit;
    ListaCamposPesquisa: TcxListBox;
    lblDisplay: TcxLabel;
    lblCaption: TLabel;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure ListaCamposPesquisaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnProcuraClick(Sender: TObject);
    procedure edtPesquisaChange(Sender: TObject);
    procedure CdsPesquisaAfterScroll(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure TvPesquisaCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure vPesquisaColumn1GetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure TvPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    FTipoPesquisa: TTipoPesquisa;
    FTitulo: String;
    procedure SetTitulo(const Value: String);
    { Private declarations }
  public
    { Public declarations }
    Property TipoPesquisa : TTipoPesquisa read FTipoPesquisa write FTipoPesquisa;
    Procedure Localiza(StrSQL : String);
    Function GetSQL : String;
    Function GetWhere(Txt : String = '') : String;
    Procedure CriaCampoPesquisa(pNomeCampoDisplay :String; pNomeCampoBanco : String; TipoCampo : TTipoCampo);
    Procedure GeraCamposGrid ;
    Procedure CriaCampo(Titulo : String; NomeCampoCds : String; TipoCampo: TTipoCampo; Largura : Integer; Agrupa : Boolean = False);
    property Titulo : String read FTitulo  write SetTitulo;
  end;

var
  frmPesquisa: TfrmPesquisa;

implementation

uses Comandos_Pan,  uDmConexao_Pan;

{$R *.dfm}

{ TfrmPesquisa }

procedure TfrmPesquisa.btnCancelarClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfrmPesquisa.btnOkClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrOk;
end;

procedure TfrmPesquisa.btnProcuraClick(Sender: TObject);
begin
  inherited;
  Localiza(GetSQL);
end;

procedure TfrmPesquisa.CdsPesquisaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  pnlRodape.Caption := ' Registro atual: '+IntToStr(CdsPesquisa.RecNo)+' de '+IntToStr(CdsPesquisa.RecordCount)+' registros';
end;

procedure TfrmPesquisa.CriaCampo(Titulo, NomeCampoCds: String; TipoCampo : TTipoCampo; Largura : Integer; Agrupa : Boolean = False);
begin
  if Agrupa then
  Begin
    with MontaGrid(TvPesquisa,NomeCampoCds,Titulo,  TipoCampo, Largura)do
    Begin
      GroupBy(1);
    End;
  End else
    MontaGrid(TvPesquisa,NomeCampoCds,Titulo,  TipoCampo, Largura);
end;

procedure TfrmPesquisa.CriaCampoPesquisa(pNomeCampoDisplay,
  pNomeCampoBanco: String; TipoCampo: TTipoCampo);
begin
  CdsCamposPesquisa.Append;
  CdsCamposPesquisaDisplayCampo.Value := pNomeCampoDisplay;
  CdsCamposPesquisaCampoBD.Value := pNomeCampoBanco;
  CdsCamposPesquisaTipoCampo.AsString :=VarToWideStr(TipoCampo);
  CdsCamposPesquisa.Post;
  ListaCamposPesquisa.Items.Add(CdsCamposPesquisaDisplayCampo.Value);

end;

procedure TfrmPesquisa.edtPesquisaChange(Sender: TObject);
begin
  inherited;
  if chkTempoReal.Checked then
    Localiza(GetSQL);
end;

procedure TfrmPesquisa.FormCreate(Sender: TObject);
begin
  inherited;
  ActiveControl := nil;
                           
end;

procedure TfrmPesquisa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  case key of
    VK_UP:
      Begin
        TvPesquisa.DataController.GotoPrev;
        if (key =  VK_UP ) and (key = VK_CONTROL ) then
          TvPesquisa.DataController.GotoFirst;
      End;
    VK_DOWN:
      Begin
        TvPesquisa.DataController.GotoNext;
        if (key = VK_DOWN) and (key =VK_CONTROL ) then
           TvPesquisa.DataController.GotoLast;
      End;
    VK_F2 :
      ListaCamposPesquisa.SetFocus;
    VK_F3 :
       chkPorParte.Checked := not chkPorParte.Checked;
    VK_F6 :
       chkTempoReal.Checked := not chkTempoReal.Checked;
    vk_F5 :
      edtPesquisa.SetFocus;
       
    VK_RETURN:
      Begin
         Key := 0;
        if ActiveControl = edtPesquisa then
          btnProcuraClick(nil);
        if  ActiveControl = GridPesquisa then
           btnOkClick(nil);
        if ActiveControl = ListaCamposPesquisa then
           ListaCamposPesquisaClick(nil);
      End;
    VK_ESCAPE:
      Begin
        btnCancelarClick(nil);
      End;
  end ;

end;

procedure TfrmPesquisa.FormKeyPress(Sender: TObject; var Key: Char);
begin
//  inherited;

end;

procedure TfrmPesquisa.FormShow(Sender: TObject);
begin
  inherited;
  GeraCamposGrid;
  ListaCamposPesquisa.ItemIndex := 0;
  ListaCamposPesquisaClick(nil);

  JvEnterAsTab1.EnterAsTab := False;
end;

procedure TfrmPesquisa.GeraCamposGrid;
begin
   case TipoPesquisa of
     tpProduto:
       Begin
         Titulo := 'Produto';
         CriaCampoPesquisa('Código', 'CODIGO', tcString);
         CriaCampoPesquisa('Produto', 'NOMEPRODUTO', tcString);
         CriaCampo('Código', 'CODIGO', tcString, 80);
         CriaCampo('Produto', 'NOMEPRODUTO', tcString, 250);
       end;
     tpCliente:
       Begin
         Titulo := 'Cliente';
         CriaCampoPesquisa('Código', 'CODIGO', tcString);
         CriaCampoPesquisa('Cliente', 'NOMECLIENTE', tcString);
         CriaCampo('Código', 'CODIGO', tcString, 80);
         CriaCampo('Cliente', 'NOMECLIENTE', tcString, 250);
       End;
     tpSaida:
       Begin
         Titulo := 'Saída';
         CriaCampoPesquisa('Cliente', 'NOMECLIENTE', tcString);
         CriaCampoPesquisa('Data do cadastro', 'DATA', tcData);
         CriaCampoPesquisa('Nº ONU ', 'NUMONU', tcInt);
         CriaCampoPesquisa('Lote', 'LOTE', tcString);
         CriaCampoPesquisa('Produto', 'NOMEPRODUTO', tcString);
         CriaCampo('ID', 'IDSAIDA', tcInt, 65);
         CriaCampo('Data', 'DATA', tcData, 80);
         CriaCampo('Hora', 'HORA', tcHora, 80);
         CriaCampo('Lote', 'LOTE', tcString, 100);
         CriaCampo('Cód. Cliente', 'CODIGOCLIENTE', tcString, 80);
         CriaCampo('Cliente', 'NOMECLIENTE', tcString, 250);
         CriaCampo('Nº ONU', 'NUMONU', tcString, 80);
         CriaCampo('Cód. produto', 'CODIGOPRODUTO', tcString, 80);
         CriaCampo('Produto', 'NOMEPRODUTO', tcString, 300);
         CriaCampo('Peso bruto', 'PESOBRUTO', tcReal, 100);
         CriaCampo('Peso líquido', 'PESOLIQUIDO', tcReal, 100);
         CriaCampo('Classe de risco', 'CLASSE', tcString, 60);
         CriaCampo('Fabricação', 'FABRICACAO', tcData, 80);
         CriaCampo('Validade', 'VALIDADE', tcData, 80);
       end;
     tpClasse :
       Begin
         Titulo := 'Classe de risco';
         CriaCampoPesquisa('Classe', 'CLASSE', tcString);
         CriaCampo('Classe', 'CLASSE', tcString, 60);
       End;
     tpTextos :
       Begin
         Titulo := 'Texto';
         CriaCampoPesquisa('Código', 'CODIGO', tcString);
         CriaCampoPesquisa('Descrição', 'DESCRICAO', tcString);
         CriaCampo('Código', 'CODIGO', tcString, 80);
         CriaCampo('Descrição', 'DESCRICAO', tcString, 150, True);
         CriaCampo('Titulo 01', 'TITULO1', tcString, 100);
         CriaCampo('Texto 01', 'TEXTO1', tcString, 300);
         CriaCampo('Titulo 02', 'TITULO1', tcString, 100);
         CriaCampo('Texto 02', 'TEXTO1', tcString, 300);
         CriaCampo('Titulo 03', 'TITULO1', tcString, 100);
         CriaCampo('Texto 03', 'TEXTO1', tcString, 300);
         CriaCampo('Titulo 04', 'TITULO1', tcString, 100);
         CriaCampo('Texto 04', 'TEXTO1', tcString, 300);
         CriaCampo('Titulo 05', 'TITULO1', tcString, 100);
         CriaCampo('Texto 05', 'TEXTO1', tcString, 300);
         CriaCampo('Titulo 06', 'TITULO1', tcString, 100);
         CriaCampo('Texto 06', 'TEXTO1', tcString, 300);
         
       End;
   end;

end;

function TfrmPesquisa.GetSQL: String;
begin
  case TipoPesquisa of
    tpCliente :
      Begin
        Result :=
          'SELECT IDCLIENTE, NOMECLIENTE, CODIGO '+
          '  FROM cliente '+
          ' WHERE '+ GetWhere;
      End;
    tpProduto:
      Begin
        Result :=
          'SELECT IDPRODUTO, CODIGO, NOMEPRODUTO '+
          '  FROM PRODUTO '+
          ' WHERE '+ GetWhere;
      end;
    tpSaida :
      Begin
        Result :=
          'SELECT S.DATA, S.FABRICACAO, S.HORA, S.IDCLASSERISCO, '+
          '       S.IDSAIDA, S.LOTE, S.NUMONU, S.PESOBRUTO, S.PESOLIQUIDO, '+
          '       S.VALIDADE, P.CODIGO CODIGOPRODUTO, P.diasvalidade, P.IDPRODUTO, P.NOMEPRODUTO, '+
          '       C.CODIGO CODIGOCLIENTE, C.IDCLIENTE, C.NOMECLIENTE, CR.CLASSE'+
          '  FROM SAIDA S  '+
          ' INNER JOIN	PRODUTO P '+
          '    ON (S.IDPRODUTO = P.IDPRODUTO)  '+
          ' INNER JOIN CLIENTE C '+
          '    ON (C.IDCLIENTE = S.IDCLIENTE) '+
          '  LEFT JOIN	CLASSERISCO CR     '+
          '    ON (CR.IDCLASSERISCO = S.IDCLASSERISCO) '+
          ' WHERE '+ GetWhere;
      End;
    tpClasse :
      Begin
        Result :=
          'SELECT IDCLASSERISCO, CLASSE '+
          '  FROM classerisco '+
          ' WHERE '+GetWhere;
      End;

    tpTextos :
      Begin
        Result :=
          'SELECT T.DESCRICAO, T.IDTEXTOS, T.TEXTO1, T.TEXTO2, T.TEXTO3,  '+
          '       T.TEXTO4, T.TEXTO5, T.TEXTO6, T.TITULO1, T.TITULO2,       '+
          '       T.TITULO3, T.TITULO4, T.TITULO5, T.TITULO6, T.CODIGO '+
          '  FROM TEXTOS T '+
          ' WHERE '+ GetWhere+
          ' ORDER BY T.IDTEXTOS ';


      End;
    
  end;

end;

function TfrmPesquisa.GetWhere(Txt : String = ''): String;
var
  Str, Campo : String;
  i : Integer;
begin
  CdsCamposPesquisa.First;
  while not CdsCamposPesquisa.Eof do
  Begin
    if ListaCamposPesquisa.Items.Strings[ListaCamposPesquisa.ItemIndex] = CdsCamposPesquisaDisplayCampo.AsString then
       Break;
    CdsCamposPesquisa.Next;
  End;

  if TTipoCampo(CdsCamposPesquisaTipoCampo.Value) = tcString then
  Begin
     Str := IfThen(chkPorParte.Checked, ' Like '+QuotedStr('%'+edtPesquisa.Text+'%'),' Like '+QuotedStr(edtPesquisa.Text+'%'));
  End;
  if TTipoCampo(CdsCamposPesquisaTipoCampo.Value) = tcData then
  begin
    Str := IfThen(chkPorParte.Checked , ' >= ' ,' = ')+GetData(edtPesquisa.Text);
  end;


  Campo := CdsCamposPesquisaCampoBD.AsString + Str;
  Result := IfThen(Txt = '',Campo, Txt);
end;

procedure TfrmPesquisa.ListaCamposPesquisaClick(Sender: TObject);
begin
  inherited;
  CdsCamposPesquisa.First;
  while not CdsCamposPesquisa.Eof do
  Begin
    if CdsCamposPesquisaDisplayCampo.AsString =
        ListaCamposPesquisa.Items.Strings[ListaCamposPesquisa.ItemIndex] then
      Break;
    CdsCamposPesquisa.Next;
  End;

  lblDisplay.Caption := CdsCamposPesquisaDisplayCampo.AsString;
  edtPesquisa.EditMask := ''; 
  if TTipoCampo(CdsCamposPesquisaTipoCampo.Value) = tcData then
     FormataMascara(edtPesquisa, tcData);
  if TTipoCampo(CdsCamposPesquisaTipoCampo.Value) = tcCEP then
     FormataMascara(edtPesquisa, tcCEP);
  if TTipoCampo(CdsCamposPesquisaTipoCampo.Value) = tcCNPJ then
     FormataMascara(edtPesquisa, tcCNPJ);
  if TTipoCampo(CdsCamposPesquisaTipoCampo.Value) = tcCPF then
     FormataMascara(edtPesquisa, tcCPF);

  chkTempoReal.Enabled := TTipoCampo(CdsCamposPesquisaTipoCampo.Value) <> tcData ;

  edtPesquisa.SetFocus;
end;

procedure TfrmPesquisa.Localiza(StrSQL: String);
begin
  if not Atu_Cds(CdsPesquisa, StrSQL) then
    Exit;
  CdsPesquisa.First;
 if not  chkTempoReal.Checked then
   GridPesquisa.SetFocus;
    
end;

procedure TfrmPesquisa.SetTitulo(const Value: String);
begin
  FTitulo := Value;
  lblCaption.Caption := FTitulo ;
  
end;

procedure TfrmPesquisa.TvPesquisaCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  btnOkClick(nil);
end;

procedure TfrmPesquisa.TvPesquisaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if key = #13 then
    btnOkClick(nil);
end;

procedure TfrmPesquisa.vPesquisaColumn1GetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  //
end;

end.
