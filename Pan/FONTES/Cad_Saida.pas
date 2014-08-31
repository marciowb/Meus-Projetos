unit Cad_Saida;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao_Pan, JvExControls, JvEnterTab, StdCtrls, Mask, DBCtrls,
  LabelDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxDBEdit, LabelDateEdit, PesquisaMaskEdit_Pan,
  ComCtrls, ToolWin, cxSplitter, ExtCtrls, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, DBClient, ActnList, ImgList, Classes_Pan, Lst_Cadastro, ppDB,
  ppDBPipe, ppDBBDE, ppBands, ppCache, ppClass, ppComm, ppRelatv, ppProd,
  ppReport, ppEndUsr, IniFiles, cxMemo, JvExForms, JvScrollBox, ppParameter,
  gtCstDocEng, gtClasses, gtTXTEng, ppTypes;

type
  TfrmCad_Saida = class(TfrmPadrao)
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    DataSaidas: TDataSource;
    CdsSaidas: TClientDataSet;
    ActionList1: TActionList;
    cxImageList1: TcxImageList;
    actNovo: TAction;
    actEditar: TAction;
    actPesquisar: TAction;
    actDeletar: TAction;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    actGravar: TAction;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    actCancelar: TAction;
    actImprimir: TAction;
    ToolButton7: TToolButton;
    actSair: TAction;
    ToolButton8: TToolButton;
    ppDesigner1: TppDesigner;
    DataMaster: TppBDEPipeline;
    PanImprime: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    Ovo: TAction;
    Panel2: TPanel;
    Panel4: TPanel;
    GrpTextos: TGroupBox;
    cxSplitter1: TcxSplitter;
    cxGrid1: TcxGrid;
    TVSaidas: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    pnlPrincipal: TPanel;
    edtNumOnu: TLabelDBEdit;
    edtPesoBruto: TLabelDBEdit;
    DBEdit1: TDBEdit;
    edtPesoLiquido: TLabelDBEdit;
    DBEdit2: TDBEdit;
    edtFabricacao: TLabelDateEdit;
    edtValidade: TLabelDateEdit;
    edtCodigoProduto: TaqPesquisaMaskEdit_Pan;
    edtLote: TLabelDBEdit;
    edtCodigoCliente: TaqPesquisaMaskEdit_Pan;
    JvScrollBox1: TJvScrollBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Texto1: TcxDBMemo;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    cxDBMemo1: TcxDBMemo;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    cxDBMemo2: TcxDBMemo;
    GroupBox8: TGroupBox;
    GroupBox9: TGroupBox;
    cxDBMemo3: TcxDBMemo;
    GroupBox10: TGroupBox;
    GroupBox11: TGroupBox;
    cxDBMemo4: TcxDBMemo;
    GroupBox12: TGroupBox;
    GroupBox13: TGroupBox;
    cxDBMemo5: TcxDBMemo;
    Panel3: TPanel;
    edtCodigoTexto: TaqPesquisaMaskEdit_Pan;
    edtCodigoClasse: TaqPesquisaMaskEdit_Pan;
    LabelDBEdit6: TLabelDBEdit;
    LabelDBEdit1: TLabelDBEdit;
    LabelDBEdit2: TLabelDBEdit;
    LabelDBEdit3: TLabelDBEdit;
    LabelDBEdit4: TLabelDBEdit;
    LabelDBEdit5: TLabelDBEdit;
    actCalc: TAction;
    ToolButton9: TToolButton;
    ppParameterList1: TppParameterList;
    procedure FormCreate(Sender: TObject);
    procedure actNovoExecute(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
    procedure actDeletarExecute(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    procedure actGravarExecute(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure actImprimirExecute(Sender: TObject);
    procedure actSairExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure edtCodigoProdutoRegAchado(ADataSet: TDataSet);
    procedure edtCodigoProdutoBtnNovoClick(Sender: TObject);
    procedure edtCodigoProdutoBtnEditarClick(Sender: TObject);
    procedure edtCodigoClienteBtnEditarClick(Sender: TObject);
    procedure edtCodigoClienteBtnNovoClick(Sender: TObject);
    procedure edtCodigoClasseBtnNovoClick(Sender: TObject);
    procedure edtCodigoClasseBtnEditarClick(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction; var Handled: Boolean);
    procedure CdsSaidasAfterOpen(DataSet: TDataSet);
    procedure OvoExecute(Sender: TObject);
    procedure CdsSaidasNewRecord(DataSet: TDataSet);
    procedure CdsSaidasFabricacaoValidate(Sender: TField);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure CdsSaidasAfterScroll(DataSet: TDataSet);
    procedure DataSaidasDataChange(Sender: TObject; Field: TField);
    procedure edtFabricacaoExit(Sender: TObject);
    procedure CdsSaidasAfterPost(DataSet: TDataSet);
    procedure edtCodigoTextoRegAchado(ADataSet: TDataSet);
    procedure actCalcExecute(Sender: TObject);
    procedure edtCodigoTextoBtnNovoClick(Sender: TObject);
    procedure edtCodigoTextoBtnEditarClick(Sender: TObject);
    procedure CdsSaidasBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    Dias : Integer;
  public
    { Public declarations }
    Procedure PodeAlterar;
    Procedure Atu_Dados;
    Procedure AbreCadastro(aTipoForm : TTipoForm ;Tabela, Chave : String ;Novo : Boolean; Edita : Boolean);
  end;

var
  frmCad_Saida: TfrmCad_Saida;
  Alteracao : TTipoAlteracao;
implementation

uses uDMConexao_Pan,   uPesquisa_PAN, Comandos_Pan, Lst_CadastroPadrao,
  Lst_Textos, Dlg_Regiao;

{$R *.dfm}

procedure TfrmCad_Saida.AbreCadastro(aTipoForm: TTipoForm;Tabela, Chave : String; Novo, Edita: Boolean);
begin
  frmLst_Cadastro := TfrmLst_Cadastro.Create(Self);
  Try
    with frmLst_Cadastro do
    Begin
      TipoForm := aTipoForm;
      NomeTabela := Tabela;
      NomeChave := Chave;
      NovoReg := Novo;
      EditaReg := EditaReg;
      ShowModal;
    End;
  Finally
    FreeAndNil(frmLst_Cadastro);
  End;
end;

procedure TfrmCad_Saida.actCalcExecute(Sender: TObject);
begin
  inherited;
  WinExec('Calc.exe', SW_NORMAL);
end;

procedure TfrmCad_Saida.actCancelarExecute(Sender: TObject);
begin
  inherited;
  CdsSaidas.Cancel;
//  edtValidade.Enabled := False;
  edtCodigoCliente.Limpa;
  edtCodigoClasse.Limpa;
  edtCodigoProduto.Limpa;
  edtCodigoTexto.Limpa;
//  edtLote.SetFocus;
end;

procedure TfrmCad_Saida.actDeletarExecute(Sender: TObject);
var
  Save : TBookmark;
begin
  inherited;
  if ConfirmaDel then
  Begin
    Try
      LockWindowUpdate(Handle);
      AlteraBanco(taDeleta, CdsSaidas, 'SAIDA', 'IDSAIDA');
      CdsSaidas.Delete;
//      edtValidade.Enabled := False;
    Finally
      LockWindowUpdate(0);
    End;
  End;

end;

procedure TfrmCad_Saida.actEditarExecute(Sender: TObject);
begin
  inherited;
  CdsSaidas.Edit;
  Alteracao := taModifica;
  pnlPrincipal.Enabled := True;
  edtLote.SetFocus;
end;

procedure TfrmCad_Saida.actGravarExecute(Sender: TObject);
begin
  inherited;
  CdsSaidas.Post;
  if Pergunda('Deseja imprimir agora?') then
    actImprimirExecute(nil);
end;

procedure TfrmCad_Saida.actImprimirExecute(Sender: TObject);
var
  ini : TIniFile;
  ID : String;
  DacimalSep, Sep, Dt : Char;
  Data, rtm : String;
begin
  inherited;
  ini := TIniFile.Create(ExtractFilePath(ParamStr(0))+'Conexao.ini');
  Try
    DacimalSep := DecimalSeparator;
    Sep := DateSeparator;
    Data := ShortDateFormat;
    rtm := ExtractFilePath(ParamStr(0))+ ini.ReadString('Layout', 'LayoutPT', 'Layout_Panamericana_1_0.rtm');
    frmDlgRegiao := TfrmDlgRegiao.Create(Self);
    with frmDlgRegiao do
    Begin
      if ShowModal = mrOk then
      Begin
        case grpOpcao.ItemIndex of
         0:
           Begin
             DecimalSeparator := Char(ini.ReadString('Brasil', 'Decimal', ',')[1]);
             ShortDateFormat  := ini.ReadString('Brasil', 'FormatoData', 'dd/mm/yyyy');
             DateSeparator    := Char(ini.ReadString('Brasil', 'DataSeparador', '/')[1]);
           end;
         1:
           Begin
             DecimalSeparator := Char(ini.ReadString('USA', 'Decimal', '.')[1]);
             ShortDateFormat  := ini.ReadString('USA', 'FormatoData', 'yyyy-mm-dd');
             DateSeparator    := Char(ini.ReadString('USA', 'DataSeparador', '-')[1]);
           end;
        end;
        
      End else
        Abort;
    End;
  Finally
    FreeAndNil(frmDlgRegiao);
  End;
   
  if not FileExists(rtm) then
  Begin
    AvisaErro('Não foi encontrado o arquivo de layout.');
    abort;
  End;

  Try
    CdsSaidas.DisableControls;
    id := CdsSaidas.FieldByName('IDSAIDA').AsString;
    CdsSaidas.Filtered := False;
    CdsSaidas.Filter := 'IDSAIDA = '+ID;
    CdsSaidas.Filtered := True;
    PanImprime.Template.FileName :=rtm;
    PanImprime.Template.LoadFromFile;
    PanImprime.AllowPrintToFile := True;
    PanImprime.DeviceType := dtTextFile;
    PanImprime.TextFileName := 'C:\Teste.txt';
    PanImprime.Print;

  Finally
    CdsSaidas.Filtered := False;
    CdsSaidas.Filter := '';
    CdsSaidas.Filtered := True;
    
    DecimalSeparator := DacimalSep;
    ShortDateFormat:= Data;
    DateSeparator :=  Sep;

    CdsSaidas.EnableControls;
  End;

end;

procedure TfrmCad_Saida.OvoExecute(Sender: TObject);
begin
  inherited;
  if Pergunda('Essa opção irá apagar permanentemente todos os dados do sistema. Deseja continuar?') then
     ppDesigner1.ShowModal;
end;

procedure TfrmCad_Saida.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  actNovo.Enabled := CdsSaidas.State in [dsBrowse];
  actEditar.Enabled := actNovo.Enabled;
  actDeletar.Enabled := (CdsSaidas.State in [dsBrowse]) and ( not CdsSaidas.IsEmpty);
  actImprimir.Enabled := (CdsSaidas.State in [dsBrowse]) and (CdsSaidas.RecordCount > 0);
  actGravar.Enabled := CdsSaidas.State in [dsEdit, dsInsert];
  actCancelar.Enabled := actGravar.Enabled;
  pnlPrincipal.Enabled := CdsSaidas.State in [dsEdit, dsInsert];
  grpTextos.Enabled := CdsSaidas.State in [dsEdit, dsInsert];
end;

procedure TfrmCad_Saida.actNovoExecute(Sender: TObject);
begin
  inherited;
  Alteracao := taInsere;
  edtCodigoCliente.Limpa;
  edtCodigoProduto.Limpa;
  edtCodigoClasse.Limpa;
  edtCodigoTexto.Limpa;
  pnlPrincipal.Enabled := True;
  edtLote.SetFocus;
  CdsSaidas.Append; 

end;

procedure TfrmCad_Saida.actPesquisarExecute(Sender: TObject);
var
  I : Integer;
begin
  inherited;
  PodeAlterar;
  frmPesquisa := TfrmPesquisa.Create(Self);
  Try
    with frmPesquisa do
    Begin
      TipoPesquisa := tpSaida;
      Maxmiza := True;
      if ShowModal = mrOk then
      Begin
        CdsSaidas.DisableControls;
        CdsSaidas.Insert;
        for I := 0 to CdsPesquisa.Fields.Count - 1 do
        Begin
          CdsSaidas.Fields[i].Value := CdsPesquisa.Fields[i].Value;
        End;
        CdsSaidas.Post;
        CdsSaidas.EnableControls;
      End;
    End;
  Finally
    FreeAndNil(frmPesquisa);
  End;
end;

procedure TfrmCad_Saida.actSairExecute(Sender: TObject);
begin
  inherited;
  PodeAlterar;
  Close;
end;

procedure TfrmCad_Saida.Atu_Dados;
var
  StrSQL : String;
begin
  StrSQL :=
      'SELECT S.DATA, S.FABRICACAO, S.HORA, S.IDCLASSERISCO,    '+
      '       S.IDSAIDA, S.LOTE,S.PESOBRUTO, S.PESOLIQUIDO, P.UNIDADE,  '+
      '       S.VALIDADE, P.CODIGO CODIGOPRODUTO, P.DIASVALIDADE, P.IDPRODUTO, P.NOMEPRODUTO,  '+
      '       C.CODIGO CODIGOCLIENTE, C.IDCLIENTE, C.NOMECLIENTE, CR.CLASSE,   '+
      '       S.NUMONU, T.CODIGO CODIGOTEXTO, T.DESCRICAO, T.IDTEXTOS, S.TEXTO1, S.TEXTO2, '+
      '       S.TEXTO3, S.TEXTO4, S.TEXTO5, S.TEXTO6, S.TITULO1, S.TITULO2, S.TITULO3, '+
      '       S.TITULO4, S.TITULO5, S.TITULO6  '+
      '  FROM PAN.SAIDA S  '+
      ' INNER JOIN PAN.PRODUTO P  '+
      '    ON (S.IDPRODUTO = P.IDPRODUTO)  '+
      ' INNER JOIN PAN.CLIENTE C  '+
      '    ON (C.IDCLIENTE = S.IDCLIENTE)  '+
      '  LEFT JOIN PAN.CLASSERISCO CR  '+
      '    ON (CR.IDCLASSERISCO = S.IDCLASSERISCO)  '+
			'  LEFT JOIN TEXTOS T  '+
			'    ON (T.IDTEXTOS = S.IDTEXTOS)  '+
      ' ORDER BY S.IDSAIDA DESC  '+
      ' LIMIT 50 ';
  Try
    CdsSaidas.AfterScroll := nil;
    Atu_Cds(CdsSaidas, StrSQL) ;
    CdsSaidas.AfterScroll := CdsSaidasAfterScroll;
  Finally
    CdsSaidasAfterScroll(nil);
  End;
end;

procedure TfrmCad_Saida.CdsSaidasAfterOpen(DataSet: TDataSet);
begin
  inherited;
  CdsSaidas.FieldByName('CODIGOPRODUTO').ProviderFlags := [];
  CdsSaidas.FieldByName('CODIGOCLIENTE').ProviderFlags := [];
  CdsSaidas.FieldByName('DIASVALIDADE').ProviderFlags := [];
  CdsSaidas.FieldByName('NOMEPRODUTO').ProviderFlags := [];
  CdsSaidas.FieldByName('NOMECLIENTE').ProviderFlags := [];
  CdsSaidas.FieldByName('CLASSE').ProviderFlags := [];
  CdsSaidas.FieldByName('IDSAIDA').ProviderFlags := [];
  CdsSaidas.FieldByName('UNIDADE').ProviderFlags := [];
  CdsSaidas.FieldByName('CODIGOTEXTO').ProviderFlags := [];
  CdsSaidas.FieldByName('DESCRICAO').ProviderFlags := [];
//  CdsSaidas.FieldByName('TEXTO1').ProviderFlags := [];
//  CdsSaidas.FieldByName('TEXTO2').ProviderFlags := [];
//  CdsSaidas.FieldByName('TEXTO3').ProviderFlags := [];
//  CdsSaidas.FieldByName('TEXTO4').ProviderFlags := [];
//  CdsSaidas.FieldByName('TEXTO5').ProviderFlags := [];
//  CdsSaidas.FieldByName('TEXTO6').ProviderFlags := [];
//  CdsSaidas.FieldByName('TITULO1').ProviderFlags := [];
//  CdsSaidas.FieldByName('TITULO2').ProviderFlags := [];
//  CdsSaidas.FieldByName('TITULO3').ProviderFlags := [];
//  CdsSaidas.FieldByName('TITULO4').ProviderFlags := [];
//  CdsSaidas.FieldByName('TITULO5').ProviderFlags := [];
//  CdsSaidas.FieldByName('TITULO6').ProviderFlags := [];

  (CdsSaidas.FieldByName('PESOBRUTO') AS TNumericField).DisplayFormat := '0.0';
  (CdsSaidas.FieldByName('PESOBRUTO') AS TNumericField).EditFormat := '0.0';
  (CdsSaidas.FieldByName('PESOLIQUIDO') AS TNumericField).DisplayFormat := '0.0';
  (CdsSaidas.FieldByName('PESOLIQUIDO') AS TNumericField).EditFormat := '0.0';
//  CdsSaidas.FieldByName('FABRICACAO').OnValidate := CdsSaidasFabricacaoValidate;
end;

procedure TfrmCad_Saida.CdsSaidasAfterPost(DataSet: TDataSet);
label
  Atu;
begin
  inherited;
  Try
    if Alteracao = taModifica then
    Begin
      if Pergunda('Deseja gravar um novo registro?') then
      Begin
         AlteraBanco(taInsere,CdsSaidas, 'SAIDA', 'IDSAIDA' );
         goto Atu;
      End else
        AlteraBanco(taModifica,CdsSaidas, 'SAIDA', 'IDSAIDA' );

    End else
       AlteraBanco(taInsere,CdsSaidas, 'SAIDA', 'IDSAIDA' );
    Atu :
    CdsSaidas.AfterScroll := nil;
    Atu_Dados;
//    edtValidade.Enabled := False;
  Finally
    CdsSaidas.AfterScroll := CdsSaidasAfterScroll;
    CdsSaidasAfterScroll(nil);
    LockWindowUpdate(0);
  End;
end;

procedure TfrmCad_Saida.CdsSaidasAfterScroll(DataSet: TDataSet);
begin
  inherited;
  edtCodigoCliente.Localiza;
  edtCodigoClasse.Localiza;
  edtCodigoProduto.Localiza;
  edtCodigoTexto.Localiza;
end;

procedure TfrmCad_Saida.CdsSaidasBeforePost(DataSet: TDataSet);
begin
  inherited;
  VerificaEdit(edtCodigoProduto, 'Informe o produto');
  VerificaEdit(edtCodigoCliente, 'Informe o cliente');
  VerificaEdit(edtCodigoClasse, 'Informe a classe');
//  VerificaEdit(edtCodigoTexto, 'Informe o texto');
  VerificaEdit(CdsSaidas, edtNumOnu, '', 'Informe o Nº ONU');
  VerificaEdit(CdsSaidas, edtPesoBruto, '', 'Informe o peso bruto');
  VerificaEdit(CdsSaidas, edtPesoLiquido, '', 'Informe o peso líquido');
  VerificaEdit(CdsSaidas, edtLote, '', 'Informe o lote');
  if CdsSaidas.FieldByName('FABRICACAO').AsDateTime < StrToDate(GetDataServidor) then
     AvisaErro('Fabricação com data anterior a data atual.');
 
  CdsSaidas.FieldByName('DATA').AsString := GetDataServidor;
  CdsSaidas.FieldByName('HORA').AsString := GetHoraServidor;
  
end;

procedure TfrmCad_Saida.CdsSaidasFabricacaoValidate(Sender: TField);
begin
  inherited;
   CdsSaidas.FieldByName('VALIDADE').AsDateTime := CdsSaidas.FieldByName('FABRICACAO').AsDateTime + Dias;

end;

procedure TfrmCad_Saida.CdsSaidasNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsSaidas.FieldByName('FABRICACAO').Value := GetDataServidor;
  end;

procedure TfrmCad_Saida.DataSaidasDataChange(Sender: TObject; Field: TField);
begin
  inherited;
//  edtCodigoCliente.Localiza;
//  edtCodigoClasse.Localiza;
//  edtCodigoProduto.Localiza;
end;

procedure TfrmCad_Saida.edtCodigoClasseBtnEditarClick(Sender: TObject);
begin
  inherited;
  AbreCadastro(tfClasse, 'CLASSERISCO', 'IDCLASSERISCO', False, True);
end;

procedure TfrmCad_Saida.edtCodigoClasseBtnNovoClick(Sender: TObject);
begin
  inherited;
  AbreCadastro(tfClasse, 'CLASSERISCO', 'IDCLASSERISCO', True, False);
end;

procedure TfrmCad_Saida.edtCodigoClienteBtnEditarClick(Sender: TObject);
begin
  inherited;
  AbreCadastro(tfCliente, 'CLIENTE', 'IDCLIENTE', False, True);
end;

procedure TfrmCad_Saida.edtCodigoClienteBtnNovoClick(Sender: TObject);
begin
  inherited;
  AbreCadastro(tfCliente, 'CLIENTE', 'IDCLIENTE', True, False);
end;

procedure TfrmCad_Saida.edtCodigoProdutoBtnEditarClick(Sender: TObject);
begin
  inherited;
  AbreCadastro(tfProduto, 'PRODUTO', 'IDPRODUTO', False, True);
end;

procedure TfrmCad_Saida.edtCodigoProdutoBtnNovoClick(Sender: TObject);
begin
  inherited;
  AbreCadastro(tfProduto, 'PRODUTO', 'IDPRODUTO', True, False);
end;

procedure TfrmCad_Saida.edtCodigoProdutoRegAchado(ADataSet: TDataSet);
var
  StrSQL : String;
  Cds : TClientDataSet ;
begin
  inherited;
  StrSQL :=
      'SELECT COALESCE(DIASVALIDADE,0)DIAS, UNIDADE, NUMONU  '+
      '  FROM PRODUTO '+
      ' WHERE IDPRODUTO = '+ IntToStr(edtCodigoProduto.ValorChave);
  Try
    Cds := TClientDataSet.Create(nil);
    Atu_Cds(Cds, StrSQL);
    Dias := Cds.FieldByName('DIAS').AsInteger;
    if CdsSaidas.State in [dsEdit, dsInsert] then
    Begin
      CdsSaidas.FieldByName('UNIDADE').AsString := Cds.FieldByName('UNIDADE').AsString;
      CdsSaidas.FieldByName('NUMONU').AsString := Cds.FieldByName('NUMONU').AsString;
    End;
  Finally
    FreeAndNil(Cds);
  End;

end;

procedure TfrmCad_Saida.edtCodigoTextoBtnEditarClick(Sender: TObject);
begin
  inherited;
  frmLst_Textos := TfrmLst_Textos.Create(Self);
  Try
    with frmLst_Textos do
    Begin
      NomeTabela := 'TEXTOS';
      NomeChave := 'IDTEXTOS';
      EditaReg := True;
      ShowModal;
    End;
  Finally
    FreeAndNil(frmLst_Textos);
  End;
end;

procedure TfrmCad_Saida.edtCodigoTextoBtnNovoClick(Sender: TObject);
begin
  inherited;
  frmLst_Textos := TfrmLst_Textos.Create(Self);
  Try
    with frmLst_Textos do
    Begin
      NomeTabela := 'TEXTOS';
      NomeChave := 'IDTEXTOS';
      NovoReg := True;
      ShowModal;
    End;
  Finally
    FreeAndNil(frmLst_Textos);
  End;
end;

procedure TfrmCad_Saida.edtCodigoTextoRegAchado(ADataSet: TDataSet);
var
  StrSQL : String;
   Cds : TClientDataSet ;
begin
  inherited;
  StrSQL :=
     'SELECT T.DESCRICAO, T.IDTEXTOS, T.TEXTO1, T.TEXTO2, T.TEXTO3,  '+
     '       T.TEXTO4, T.TEXTO5, T.TEXTO6, T.TITULO1, T.TITULO2,       '+
     '       T.TITULO3, T.TITULO4, T.TITULO5, T.TITULO6, T.CODIGO '+
     '  FROM TEXTOS T '+
     ' WHERE T.IDTEXTOS = '+ ADataSet.FieldByName('IDTEXTOS').AsString;
  Try
    Cds := TClientDataSet.Create(nil);
    Atu_Cds(Cds, StrSQL);
    if CdsSaidas.State in [dsEdit, dsInsert] then
    Begin
      CdsSaidas.FieldByName('TEXTO1').AsString := Cds.FieldByName('TEXTO1').AsString;
      CdsSaidas.FieldByName('TEXTO2').AsString := Cds.FieldByName('TEXTO2').AsString;
      CdsSaidas.FieldByName('TEXTO3').AsString := Cds.FieldByName('TEXTO3').AsString;
      CdsSaidas.FieldByName('TEXTO4').AsString := Cds.FieldByName('TEXTO4').AsString;
      CdsSaidas.FieldByName('TEXTO5').AsString := Cds.FieldByName('TEXTO5').AsString;
      CdsSaidas.FieldByName('TEXTO6').AsString := Cds.FieldByName('TEXTO6').AsString;
      CdsSaidas.FieldByName('TITULO1').AsString := Cds.FieldByName('TITULO1').AsString;
      CdsSaidas.FieldByName('TITULO2').AsString := Cds.FieldByName('TITULO2').AsString;
      CdsSaidas.FieldByName('TITULO3').AsString := Cds.FieldByName('TITULO3').AsString;
      CdsSaidas.FieldByName('TITULO4').AsString := Cds.FieldByName('TITULO4').AsString;
      CdsSaidas.FieldByName('TITULO5').AsString := Cds.FieldByName('TITULO5').AsString;
      CdsSaidas.FieldByName('TITULO6').AsString := Cds.FieldByName('TITULO6').AsString;
    End;
  Finally
    FreeAndNil(Cds);
  End;


end;

procedure TfrmCad_Saida.edtFabricacaoExit(Sender: TObject);
begin
  inherited;
  CdsSaidas.FieldByName('VALIDADE').AsDateTime := CdsSaidas.FieldByName('FABRICACAO').AsDateTime + Dias;
end;

procedure TfrmCad_Saida.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  actSairExecute(nil);
//  inherited;

end;
procedure TfrmCad_Saida.FormCreate(Sender: TObject);
begin
  inherited;
  Maxmiza := True;
end;

procedure TfrmCad_Saida.FormKeyPress(Sender: TObject; var Key: Char);
begin
//  inherited;
  case key of
    #13:
      Begin
        if ActiveControl = edtCodigoClasse then
        Begin
          if Pergunda('Deseja gravar?') then
          Begin
            actGravarExecute(nil);
            Exit;
          End;
          Key := #0;
        End;
        SelectNext(ActiveControl, True, True);
      End;
    #27:
      Begin
        if ActiveControl = edtLote then
        Begin
          actSairExecute(nil);
          Key := #0;
          Exit;     
        End;
        SelectNext(ActiveControl, False, True);
      End;
  end;
end;

procedure TfrmCad_Saida.FormShow(Sender: TObject);
var
  i : Integer;
begin
  inherited;
  MontaGrid(TvSaidas, 'IDSAIDA', 'ID', tcInt);
  MontaGrid(TvSaidas, 'DATA', 'Data', tcData, 80);
  MontaGrid(TvSaidas, 'HORA', 'Hora', tcHora, 80);
  MontaGrid(TvSaidas, 'CODIGOPRODUTO', 'Cód. produto', tcString, 80);
  MontaGrid(TvSaidas, 'NOMEPRODUTO', 'Produto', tcString, 300);
  MontaGrid(TvSaidas, 'CODIGOCLIENTE', 'Cód. cliente', tcString, 80);
  MontaGrid(TvSaidas, 'NOMECLIENTE', 'Cliente', tcString, 150);

  edtCodigoProduto.Configurar(DataSaidas.DataSet, 'IDPRODUTO', 'PRODUTO', 'NOMEPRODUTO','Produto', tpProduto, 'CODIGO','CODIGOPRODUTO');
  edtCodigoCliente.Configurar(DataSaidas.DataSet, 'IDCLIENTE', 'CLIENTE', 'NOMECLIENTE','Cliente', tpCliente, 'CODIGO', 'CODIGOCLIENTE');
  edtCodigoClasse.Configurar(DataSaidas.DataSet, 'IDCLASSERISCO', 'CLASSERISCO', 'CLASSE','Produto', tpClasse, 'CLASSE', 'CLASSE', 6,tcString);
  edtCodigoTexto.Configurar(DataSaidas.DataSet, 'IDTEXTOS', 'TEXTOS', 'DESCRICAO','Texto', tpTextos, 'CODIGO', 'CODIGOTEXTO');

  Atu_Dados;
  for I := 0 to ComponentCount - 1 do
  Begin
    if Components[i] is TLabelDBEdit then
     (Components[i] as TLabelDBEdit).CharCase := ecUpperCase;
  End;

end;


procedure TfrmCad_Saida.PodeAlterar;
begin
  if CdsSaidas.State in [dsInsert, dsEdit] then
  Begin
    AvisaOK('Grave ou cancele as modificações antes.');
    Abort;
  End;
end;

end.
