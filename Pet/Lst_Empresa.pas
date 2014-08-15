unit Lst_Empresa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Lst_CadastroSimples, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxTL, cxTLdxBarBuiltInMenu, DBClient,
  pFIBClientDataSet, Menus, ActnList, cxInplaceContainer, cxTLData, cxDBTL,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxPC, ComCtrls, ToolWin, StdCtrls,
  Buttons, Mask, DBCtrls, LabelDBEdit, cxSplitter, ExtCtrls, EditPesquisa,
  cxContainer, cxImage, cxDBEdit, ExtDlgs, JvDBImage;

type
  TfrmLst_Empresa = class(TfrmLstCadastroSimples)
    LabelDBEdit1: TLabelDBEdit;
    LabelDBEdit2: TLabelDBEdit;
    LabelDBEdit3: TLabelDBEdit;
    LabelDBEdit4: TLabelDBEdit;
    LabelDBEdit5: TLabelDBEdit;
    LabelDBEdit6: TLabelDBEdit;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    GroupBox1: TGroupBox;
    edtCEP: TEditPesquisa;
    edtBairro: TLabeledEdit;
    edtCidade: TLabeledEdit;
    LabelDBEdit7: TLabelDBEdit;
    LabelDBEdit8: TLabelDBEdit;
    cxTabSheet2: TcxTabSheet;
    cxTabSheet3: TcxTabSheet;
    Panel5: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Open: TOpenPictureDialog;
    edtUf: TLabeledEdit;
    Logo: TJvDBImage;
    GroupBox2: TGroupBox;
    DBMemo1: TDBMemo;
    edtLayout: TEditPesquisa;
    LabelDBEdit9: TLabelDBEdit;
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCEPRegAchado(ADataSet: TDataSet);
    procedure edtCEPRegNaoAchado(ADataSet: TDataSet; Sender: TObject);
    procedure CdsCadastroAfterOpen(DataSet: TDataSet);
    procedure actGravarExecute(Sender: TObject);
    procedure edtLayoutAbrePesquisa(Sender: TObject; ADataSet: TDataSet;
      aTipoPesquisa: Integer; Titulo: string; out Resultado: Variant);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  frmLst_Empresa: TfrmLst_Empresa;

implementation

uses MinhasClasses, Comandos, uSQL, uLibPet;

{$R *.dfm}

procedure TfrmLst_Empresa.actGravarExecute(Sender: TObject);
begin
  VerificaEdit(edtCEP,'Informe o cep');
  inherited;

end;

procedure TfrmLst_Empresa.CdsCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;
  CdsCadastro.FieldByName('BAIRRO').ProviderFlags := [];
  CdsCadastro.FieldByName('CEP').ProviderFlags := [];
  CdsCadastro.FieldByName('CIDADE').ProviderFlags := [];
  CdsCadastro.FieldByName('UF').ProviderFlags := [];
  CdsCadastro.FieldByName('LOGRADOURO').ProviderFlags := [];
  FormataMascara(CdsCadastro.FieldByName('CNPJ'),tcCNPJ);
end;

procedure TfrmLst_Empresa.edtCEPRegAchado(ADataSet: TDataSet);
begin
  inherited;
  with getCds(GetSelect(tpImoCEP,'idcep = '+edtCEP.ValorChaveString)) do
  Begin
    edtBairro.Text := FieldByName('BAIRRO').AsString;
    edtCidade.Text := FieldByName('CIDADE').AsString;
    edtUf.Text :=     FieldByName('UF').AsString;
    Free;
  End;

end;

procedure TfrmLst_Empresa.edtCEPRegNaoAchado(ADataSet: TDataSet;
  Sender: TObject);
begin
  inherited;
  edtBairro.Clear;
  edtCidade.Clear;
  edtUf.Clear;
end;


procedure TfrmLst_Empresa.edtLayoutAbrePesquisa(Sender: TObject;
  ADataSet: TDataSet; aTipoPesquisa: Integer; Titulo: string;
  out Resultado: Variant);
begin
  Resultado := Imp_ReciboPet(CdsCadastro.FieldByName('IDEMPRESA').AsInteger,-1, tlLista);
  if Resultado > 0  then
  Begin
    if not (CdsCadastro.State in [dsEdit, dsInsert]) then
      actEditarExecute(nil);
    CdsCadastro.FieldByName('IDLAYOUT').Value := Resultado;
  End;
end;

procedure TfrmLst_Empresa.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa := tpPetEmpresa;
  CriaColuna('CODIGO','Código');
  CriaColuna('RAZAOSOCIAL','Razão social',120);
  ConfiguraEditPesquisa(edtCEP,CdsCadastro,tpImoCEP,'LOGRADOURO','CEP','CEP','IDCEP',8);
  ConfiguraEditPesquisa(edtLayout,CdsCadastro,tpLayout,'NOMELAYOUT','','IDLAYOUT','IDLAYOUT');
  edtLayout.CampoCodigo := 'IDLAYOUT';

end;

procedure TfrmLst_Empresa.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  CdsCadastro.FieldByName('LOGOMARCA').Clear;
end;

procedure TfrmLst_Empresa.SpeedButton2Click(Sender: TObject);
begin
  inherited;
  if OPen.Execute then
    TBlobField(CdsCadastro.FieldByName('LOGOMARCA')).LoadFromFile(Open.FileName);
end;

end.
