unit Cad_Cliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Cad_CadastroPai, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, ComCtrls, DB, DBClient, pFIBClientDataSet, ActnList,
  cxPC, cxContainer, cxTreeView, Buttons, ExtCtrls, StdCtrls, Mask, DBCtrls,
  LabelDBEdit, EditPesquisa, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,MinhasClasses,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter;

type
  TfrmCad_Cliente = class(TfrmCad_CadastroPai)
    LabelDBEdit1: TLabelDBEdit;
    edtNome: TLabelDBEdit;
    LabelDBEdit3: TLabelDBEdit;
    LabelDBEdit4: TLabelDBEdit;
    LabelDBEdit5: TLabelDBEdit;
    LabelDBEdit6: TLabelDBEdit;
    LabelDBEdit7: TLabelDBEdit;
    LabelDBEdit8: TLabelDBEdit;
    LabelDBEdit9: TLabelDBEdit;
    LabelDBEdit10: TLabelDBEdit;
    GroupBox1: TGroupBox;
    edtCep: TEditPesquisa;
    edtBairro: TLabeledEdit;
    edtCidade: TLabeledEdit;
    edtUf: TLabeledEdit;
    LabelDBEdit11: TLabelDBEdit;
    LabelDBEdit12: TLabelDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    cxTabSheet1: TcxTabSheet;
    GroupBox2: TGroupBox;
    DBMemo1: TDBMemo;
    cxTabSheet2: TcxTabSheet;
    DataAnimais: TDataSource;
    CdsAnimais: TpFIBClientDataSet;
    GroupBox3: TGroupBox;
    cxGrid1: TcxGrid;
    TvAnimais: TcxGridDBTableView;
    TvAnimaisCODIGO: TcxGridDBColumn;
    TvAnimaisNOMEANIMAL: TcxGridDBColumn;
    TvAnimaisNOMETIPOANIMAL: TcxGridDBColumn;
    TvAnimaisNOMECATEGORIAANIMAL: TcxGridDBColumn;
    TvAnimaisPESO: TcxGridDBColumn;
    TvAnimaisDATANASCIMENTO: TcxGridDBColumn;
    TvAnimaisSEXO: TcxGridDBColumn;
    TvAnimaisCOMPRIMENTO: TcxGridDBColumn;
    TvAnimaisALTURA: TcxGridDBColumn;
    TvAnimaisNOMERACA: TcxGridDBColumn;
    TvAnimaisDATACADASTRO: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    GroupBox4: TGroupBox;
    DBMemo2: TDBMemo;
    LabelDBEdit2: TLabelDBEdit;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    actNovoAnimal: TAction;
    actEditarAnimal: TAction;
    actDelAnimal: TAction;
    procedure FormCreate(Sender: TObject);
    procedure edtCepRegAchado(ADataSet: TDataSet);
    procedure edtCepRegNaoAchado(ADataSet: TDataSet; Sender: TObject);
    procedure CdsCadastroAfterOpen(DataSet: TDataSet);
    procedure CdsCadastroNewRecord(DataSet: TDataSet);
    procedure actNovoExecute(Sender: TObject);
    procedure CdsCadastroAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure actImprimirExecute(Sender: TObject);
    procedure actNovoAnimalExecute(Sender: TObject);
    procedure actEditarAnimalExecute(Sender: TObject);
    procedure actDelAnimalExecute(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  frmCad_Cliente: TfrmCad_Cliente;

implementation

uses  Comandos, UDmConexao, uRelClientes, uLibPet;

{$R *.dfm}

procedure TfrmCad_Cliente.actDelAnimalExecute(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmCad_Cliente.actEditarAnimalExecute(Sender: TObject);
begin
  inherited;
  AbreCadastroAnimal(False,True,CdsAnimais.FieldByName('IDCLIENTE').AsInteger,CdsAnimais.FieldByName('IDANIMAL').AsInteger);

end;

procedure TfrmCad_Cliente.actImprimirExecute(Sender: TObject);
begin
  inherited;
  frmRelClientes := TfrmRelClientes.Create(nil);
  Try
    frmRelClientes.ShowModal;
  Finally
    FreeAndNil(frmRelClientes);
  End;
end;

procedure TfrmCad_Cliente.actNovoAnimalExecute(Sender: TObject);
begin
  inherited;
  AbreCadastroAnimal(True,False,CdsAnimais.FieldByName('IDCLIENTE').AsInteger);
end;

procedure TfrmCad_Cliente.actNovoExecute(Sender: TObject);
begin
  inherited;
  edtNome.SetFocus;
end;

procedure TfrmCad_Cliente.CdsCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;
  CdsCadastro.FieldByName('BAIRRO').ProviderFlags := [];
  CdsCadastro.FieldByName('CEP').ProviderFlags := [];
  CdsCadastro.FieldByName('CIDADE').ProviderFlags := [];
  CdsCadastro.FieldByName('UF').ProviderFlags := [];
  CdsCadastro.FieldByName('LOGRADOURO').ProviderFlags := [];
  FormataMascara(CdsCadastro.FieldByName('CPF'),tcCPF);
  FormataMascara(CdsCadastro.FieldByName('DATANASCIMENTO'),tcCampoData);
  FormataMascara(CdsCadastro.FieldByName('DATAEMISSAO'),tcCampoData);
end;

procedure TfrmCad_Cliente.CdsCadastroAfterScroll(DataSet: TDataSet);
begin
  inherited;
  SetCds(CdsAnimais,tpPetAnimal,'A.IDCLIENTE = '+ValorChave);
end;

procedure TfrmCad_Cliente.CdsCadastroNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsCadastro.FieldByName('FLAGSEXO').AsString := 'F';
  CdsCadastro.FieldByName('CODIGO').AsString := PadL(CdsCadastro.FieldByName('CODIGO').AsString,6,'0');
  CdsCadastro.FieldByName('DATACADASTRO').AsString := GetDataServidor;
end;

Procedure TfrmCad_Cliente.edtCepRegAchado(ADataSet: TDataSet);
begin
  inherited;
  with getCds(tpImoCEP,'idcep = '+edtCEP.ValorChaveString) do
  Begin
    edtBairro.Text := FieldByName('BAIRRO').AsString;
    edtCidade.Text := FieldByName('CIDADE').AsString;
    edtUf.Text :=     FieldByName('UF').AsString;
    Free;
  End;
end;

procedure TfrmCad_Cliente.edtCepRegNaoAchado(ADataSet: TDataSet;
  Sender: TObject);
begin
  inherited;
  edtBairro.Clear;
  edtCidade.Clear;
  edtUf.Clear;
end;

procedure TfrmCad_Cliente.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa := tpPetCliente;
  VerificaEdits := True;
  ConfiguraEditPesquisa(edtCEP,CdsCadastro,tpImoCEP,'LOGRADOURO','CEP','CEP','IDCEP',8);

end;

procedure TfrmCad_Cliente.FormShow(Sender: TObject);
begin
  inherited;
  if NovoReg or EditReg then
    edtNome.SetFocus;
end;

end.
