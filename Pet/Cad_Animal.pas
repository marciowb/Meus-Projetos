unit Cad_Animal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Cad_CadastroPai, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, ComCtrls, DB, DBClient, pFIBClientDataSet, ActnList,
  cxPC, cxContainer, cxTreeView, Buttons, ExtCtrls, StdCtrls, Mask, DBCtrls,
  LabelDBEdit, EditPesquisa, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxExtEditRepositoryItems, cxEditRepositoryItems, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter, cxDBExtLookupComboBox;

type
  TfrmCad_Animal = class(TfrmCad_CadastroPai)
    LabelDBEdit1: TLabelDBEdit;
    edtNome: TLabelDBEdit;
    LabelDBEdit7: TLabelDBEdit;
    edtCliente: TEditPesquisa;
    edtEspecie: TEditPesquisa;
    edtCategoria: TEditPesquisa;
    edtRaca: TEditPesquisa;
    LabelDBEdit2: TLabelDBEdit;
    LabelDBEdit3: TLabelDBEdit;
    LabelDBEdit4: TLabelDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    LabelDBEdit5: TLabelDBEdit;
    GroupBox1: TGroupBox;
    DBMemo1: TDBMemo;
    cxTabSheet1: TcxTabSheet;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    DBCheckBox1: TDBCheckBox;
    TvGrupo: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    CdsGrupo: TpFIBClientDataSet;
    CdsAcomp: TpFIBClientDataSet;
    DataGrupo: TDataSource;
    DataAcomp: TDataSource;
    vGrupoColumn1: TcxGridDBColumn;
    vGrupoColumn2: TcxGridDBColumn;
    GridAcomp: TcxGrid;
    TvAcomp: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxEditRepository1: TcxEditRepository;
    vAcompColumn1: TcxGridDBColumn;
    vAcompColumn2: TcxGridDBColumn;
    vAcompColumn3: TcxGridDBColumn;
    cxEditRepository1CheckBoxItem1: TcxEditRepositoryCheckBoxItem;
    Panel4: TPanel;
    SpeedButton3: TSpeedButton;
    SpeedButton5: TSpeedButton;
    cxEditRepository1BlobItem1: TcxEditRepositoryBlobItem;
    procedure CdsCadastroNewRecord(DataSet: TDataSet);
    procedure CdsCadastroAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure actGravarExecute(Sender: TObject);
    procedure edtRacaBtnNovoClick(Sender: TObject);
    procedure actNovoExecute(Sender: TObject);
    procedure edtCategoriaEnter(Sender: TObject);
    procedure edtClienteBtnNovoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure CdsCadastroAfterScroll(DataSet: TDataSet);
    procedure CdsGrupoAfterOpen(DataSet: TDataSet);
    procedure CdsGrupoNewRecord(DataSet: TDataSet);
    procedure CdsAcompNewRecord(DataSet: TDataSet);
    procedure CdsAcompAfterOpen(DataSet: TDataSet);
    procedure CdsCadastroAfterPost(DataSet: TDataSet);
    procedure CdsAcompBeforeEdit(DataSet: TDataSet);
    procedure CdsAcompBeforePost(DataSet: TDataSet);
    procedure actPesquisarExecute(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    FIdCliente: Integer;
    { Private declarations }
  public
    { Public declarations }
    Property IdCliente: Integer read FIdCliente write FIdCliente;
    Procedure AtuDados;
  end;

var
  frmCad_Animal: TfrmCad_Animal;

implementation

uses Comandos, MinhasClasses, uLibPet, uSQL;

{$R *.dfm}

procedure TfrmCad_Animal.actGravarExecute(Sender: TObject);
begin
  VerificaEdit(edtCliente,'Informe o cliente');
  VerificaEdit(edtEspecie,'Informe a espécie');
  VerificaEdit(edtCategoria,'Informe a categoria');

  inherited;

end;

procedure TfrmCad_Animal.actNovoExecute(Sender: TObject);
begin
  inherited;
  EdtNome.Setfocus;
end;

procedure TfrmCad_Animal.actPesquisarExecute(Sender: TObject);
var
  vAfterScroll : TDataSetNotifyEvent;
  Temp: Integer;
begin
  Try
    vAfterScroll := CdsCadastro.AfterScroll;
    CdsCadastro.AfterScroll := nil;
    Temp := AbrePesquisaAnimal;
    if Temp <> -1 then
    Begin
      ValorChave := IntToStr(Temp);
      SetCds(CdsCadastro, GetSelect(TipoPesquisa, CampoChave+' = '+GetValorChave(psIgual)));
    End;
  Finally
    CdsCadastro.AfterScroll := vAfterScroll;
    if Assigned(vAfterScroll) then
      vAfterScroll(CdsCadastro);
  End;

end;

procedure TfrmCad_Animal.AtuDados;
begin
  SetCds(CdsGrupo,tpPetGrupoAnimal,'GA.IDANIMAL = '+ValorChave);
  SetCds(CdsAcomp,tpPetAcompanhamentoAnimal,'AC.IDANIMAL = '+ValorChave);
end;

procedure TfrmCad_Animal.CdsAcompAfterOpen(DataSet: TDataSet);
begin
  inherited;
  CdsAcomp.FieldByName('NOMEANIMAL').ProviderFlags := [];
  CdsAcomp.FieldByName('CODIGO').ProviderFlags := [];
  CdsAcomp.FieldByName('CLIENTE').ProviderFlags := [];
  CdsAcomp.FieldByName('FLAGEDICAO').ProviderFlags := [];
end;

procedure TfrmCad_Animal.CdsAcompBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  MudaEstado;
end;

procedure TfrmCad_Animal.CdsAcompBeforePost(DataSet: TDataSet);
begin
  inherited;
  if CdsAcomp.State = dsEdit then
    if CdsAcomp.FieldByName('FLAGEDICAO').AsString = 'N' then
      CdsAcomp.FieldByName('FLAGEDICAO').AsString := 'E';
end;

procedure TfrmCad_Animal.CdsAcompNewRecord(DataSet: TDataSet);
begin
  inherited;
  MudaEstado;
  CdsAcomp.FieldByName('IDANIMALACOMPANHAMENTO').AsString := GetCodigo(tpPetAcompanhamentoAnimal);
  CdsAcomp.FieldByName('IDANIMAL').AsString := ValorChave;
  CdsAcomp.FieldByName('FLAGEDICAO').AsString := 'I';
end;

procedure TfrmCad_Animal.CdsCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FormataMascara(CdsCadastro.FieldByName('DATANASCIMENTO'),tcCampoData);
  CdsCadastro.FieldByName('NOMETIPOANIMAL').ProviderFlags := [];
  CdsCadastro.FieldByName('NOMECATEGORIAANIMAL').ProviderFlags := [];
  CdsCadastro.FieldByName('NOMERACA').ProviderFlags := [];
  CdsCadastro.FieldByName('NOMECLIENTE').ProviderFlags := [];
end;

procedure TfrmCad_Animal.CdsCadastroAfterPost(DataSet: TDataSet);
begin
  inherited;
  SetRegistros(CdsGrupo,tpPetGrupoAnimal);
  SetRegistros(CdsAcomp,tpPetAcompanhamentoAnimal);
end;

procedure TfrmCad_Animal.CdsCadastroAfterScroll(DataSet: TDataSet);
begin
  inherited;
  AtuDados;
end;

procedure TfrmCad_Animal.CdsCadastroNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsCadastro.FieldByName('DATACADASTRO').AsString := GetDataServidor;
  CdsCadastro.FieldByName('CODIGO').AsString := PadL(ValorChave,6,'0');
  if IdCliente > 0 then
  Begin
    CdsCadastro.FieldByName('IDCLIENTE').AsInteger := IdCliente;
    edtCliente.Localiza;
  End;

end;

procedure TfrmCad_Animal.CdsGrupoAfterOpen(DataSet: TDataSet);
begin
  inherited;
  CdsGrupo.FieldByName('NOMEGRUPO').ProviderFlags := [];
  CdsGrupo.FieldByName('CODIGO').ProviderFlags := [];
  CdsGrupo.FieldByName('FLAGEDICAO').ProviderFlags := [];
end;

procedure TfrmCad_Animal.CdsGrupoNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsGrupo.FieldByName('IDGRUPOANIMAL').AsString := GetCodigo(tpPetGrupoAnimal);
  CdsGrupo.FieldByName('IDANIMAL').AsString := ValorChave;
  CdsGrupo.FieldByName('FLAGEDICAO').AsString := 'I';
end;

procedure TfrmCad_Animal.edtCategoriaEnter(Sender: TObject);
begin
  inherited;
  VerificaEdit(edtEspecie,'Informe a espécie');
  edtCategoria.SQLComp :=
      '     EXISTS(SELECT 1 '+
      '              FROM TIPOANIMAL '+
      '             WHERE IDTIPOANIMAL = '+edtEspecie.ValorChaveString+
      '               AND X.IDTIPOANIMAL = TIPOANIMAL.IDTIPOANIMAL) ';
end;

procedure TfrmCad_Animal.edtClienteBtnNovoClick(Sender: TObject);
begin
  inherited;
  CdsCadastro.FieldByName('IDCLIENTE').AsInteger := AbreCadastroCliente(True);
  edtCliente.Localiza;
end;

procedure TfrmCad_Animal.edtRacaBtnNovoClick(Sender: TObject);
begin
  inherited;
  CdsCadastro.FieldByName('IDRACAANIMAL').AsInteger := AbreCadastroRaca(True);
  edtRaca.Localiza;
end;

procedure TfrmCad_Animal.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa := tpPetAnimal;
  ConfiguraEditPesquisa(edtCliente,CdsCadastro,tpPetCliente);
  ConfiguraEditPesquisa(edtEspecie,CdsCadastro,tpPetTipoAnimal);
  ConfiguraEditPesquisa(edtCategoria,CdsCadastro,tpPetCategoriaAnimal);
  edtCategoria.NomeTabela := 'CATEGORIAANIMAL X ' ;
  ConfiguraEditPesquisa(edtRaca,CdsCadastro,tpPetRacaAnimal);
  VerificaEdits := True;
  IdCliente := -1;
end;

procedure TfrmCad_Animal.FormShow(Sender: TObject);
begin
  inherited;
  if NovoReg or EditReg then
    edtNome.SetFocus;
end;

procedure TfrmCad_Animal.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  MudaEstado;
  AdicionaListaPesquisa(CdsGrupo, tpPetGrupo,'Esse grupo já foi adicionado');
end;

procedure TfrmCad_Animal.SpeedButton2Click(Sender: TObject);
begin
  inherited;
  if ConfirmaDel then
  Begin
    MudaEstado;
    CdsGrupo.Edit;
    CdsGrupo.FieldByName('FLAGEDICAO').AsString := 'D';
    CdsGrupo.Post;
  End;

end;

procedure TfrmCad_Animal.SpeedButton3Click(Sender: TObject);
begin
  inherited;
  MudaEstado;
  CdsAcomp.Append;

end;

procedure TfrmCad_Animal.SpeedButton5Click(Sender: TObject);
begin
  inherited;
  if ConfirmaDel then
  Begin
    MudaEstado;
    CdsAcomp.Edit;
    CdsAcomp.FieldByName('FLAGEDICAO').AsString := 'D';
    CdsAcomp.Post;
  End;
end;

end.
