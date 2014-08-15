unit Cad_Agenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Dlg_Cadastro, StdCtrls, Buttons, ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit, DB, cxSpinEdit, cxTimeEdit,
  DBCtrls, cxPC, Mask, EditPesquisa, LabelDBEdit, DBClient, pFIBClientDataSet,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue;

type
  TfrmCad_Agenda = class(TfrmDlg_Cadastro)
    DataCadAgenda: TDataSource;
    Panel3: TPanel;
    cxDBDateEdit1: TcxDBDateEdit;
    Label1: TLabel;
    edtHoraIni: TcxDBTimeEdit;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    edtAnimal: TEditPesquisa;
    edtNomeCliente: TLabelDBEdit;
    grpEndereco: TGroupBox;
    edtCep: TEditPesquisa;
    edtBairro: TLabeledEdit;
    LabelDBEdit2: TLabelDBEdit;
    LabelDBEdit3: TLabelDBEdit;
    mmObs: TDBMemo;
    edtHoraFin: TcxDBTimeEdit;
    Label3: TLabel;
    edtTipoServico: TEditPesquisa;
    Label4: TLabel;
    cmbFreq: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure edtAnimalRegAchado(ADataSet: TDataSet);
    procedure edtAnimalRegNaoAchado(ADataSet: TDataSet; Sender: TObject);
    procedure edtCepRegAchado(ADataSet: TDataSet);
    procedure edtCepRegNaoAchado(ADataSet: TDataSet; Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure edtAnimalBtnNovoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCad_Agenda: TfrmCad_Agenda;

implementation

uses Comandos, MinhasClasses, uLibPet;

{$R *.dfm}

procedure TfrmCad_Agenda.btnOkClick(Sender: TObject);
var
  CdsClone: TpFIBClientDataSet;
  I: Integer;
  Procedure PreencheDataSet;
  var
    x: Integer;
  Begin
    for x := 0 to CdsClone.FieldCount -1 do
    Begin
      if pDataSet.Fields[x].FieldName <> 'IDAGENDA' then
        pDataSet.Fields[x].Value := CdsClone.Fields[x].Value;
    End;
  End;
  Function AjustaData(Data: TDate) : TDate;
  var
    T : Integer;
  Begin
    Result := Data;
    T := DayOfWeek(Result);
    if T = 1 then// Domingo
      Result := Result -1;
  End;
begin
 // VerificaEdit(edtProfissional,'Informe o profissional');
  VerificaEdit(edtAnimal,'Informe o animal');
  VerificaEdit(pDataSet, edtNomeCliente,'','Informe o cliente');
  VerificaEdit(edtCep,'Informe o CEP');
  if pDataSet.FieldByName('HORAINICIAL').AsString = '' then
  Begin
    Avisa('Informe a hora inicial');
    edtHoraIni.SetFocus;
    Abort;
  End;
  if pDataSet.FieldByName('HORAFINAL').AsString = '' then
  Begin
    Avisa('Informe a hora final');
    edtHoraFin.SetFocus;
    Abort;
  End;
  Try
    CdsClone := TpFIBClientDataSet.Create(nil);
    pDataSet.DisableControls;
    CdsClone.CloneCursor(pDataSet,True);
    inherited;
    if cmbFreq.ItemIndex <> 0 then
    Begin
      if cmbFreq.ItemIndex = 1 then
      Begin
        for I := 1 to 3 do
        Begin
          PreencheDataSet;
          pDataSet.FieldByName('DATA').AsDateTime := CdsClone.FieldByName('DATA').AsDateTime+(I*7);
          pDataSet.FieldByName('DATA').AsDateTime := AjustaData(pDataSet.FieldByName('DATA').AsDateTime);
          inherited;
        End;
      End;
      if cmbFreq.ItemIndex = 2 then
      Begin
        PreencheDataSet;
        pDataSet.FieldByName('DATA').AsDateTime := CdsClone.FieldByName('DATA').AsDateTime+14;
        pDataSet.FieldByName('DATA').AsDateTime:= AjustaData(pDataSet.FieldByName('DATA').AsDateTime);
        inherited;
      End;
      if cmbFreq.ItemIndex = 3 then
      Begin
        PreencheDataSet;
        pDataSet.FieldByName('DATA').AsDateTime := CdsClone.FieldByName('DATA').AsDateTime+30;
        pDataSet.FieldByName('DATA').AsDateTime := AjustaData(pDataSet.FieldByName('DATA').AsDateTime);
        inherited;
      End;
    End;
  Finally
    pDataSet.EnableControls;
    FreeAndNil(CdsClone);

  End;

end;

procedure TfrmCad_Agenda.edtAnimalBtnNovoClick(Sender: TObject);
begin
  inherited;
  pDataSet.FieldByName('IDANIMAL').AsInteger := AbreCadastroAnimal(True);
  edtAnimal.Localiza;
end;

procedure TfrmCad_Agenda.edtAnimalRegAchado(ADataSet: TDataSet);
var
  StrSQL: String;
begin
  inherited;
  StrSQL :=
    'EXISTS (SELECT 1'+
    '          FROM ANIMAL A '+
    '         WHERE A.IDCLIENTE = C.IDCLIENTE '+
    '           AND A.IDANIMAL = '+edtAnimal.ValorChaveString+') ';
  with GetCds(tpPetCliente,StrSQL) do
  Begin
    edtNomeCliente.Text := FieldByName('NOMECLIENTE').AsString;
    if FieldByName('IDCEP').AsString <> '' then
    Begin
      pDataSet.FieldByName('IDCEP').AsInteger := FieldByName('IDCEP').AsInteger;
      pDataSet.FieldByName('NUMERO').AsString := FieldByName('NUMERO').AsString;
      pDataSet.FieldByName('COMPLEMENTO').AsString := FieldByName('COMPLEMENTO').AsString;
      edtCep.Localiza;
    End;
    edtTipoServico.SetFocus;
    Free;
  End;
end;

procedure TfrmCad_Agenda.edtAnimalRegNaoAchado(ADataSet: TDataSet;
  Sender: TObject);
begin
  inherited;
 { edtNomeCliente.Clear;
  if pDataSet.State <> dsBrowse then
  Begin
    pDataSet.FieldByName('IDCEP').Clear;
    pDataSet.FieldByName('NUMERO').Clear;
    pDataSet.FieldByName('COMPLEMENTO').Clear;
  End;
  edtCep.Localiza;}



end;

procedure TfrmCad_Agenda.edtCepRegAchado(ADataSet: TDataSet);
begin
  inherited;
  with GetCds(tpImoCEP,'idcep = '+edtCep.ValorChaveString) do
  Begin
    edtBairro.Text := FieldByName('BAIRRO').AsString;
    Free;
  End;
end;

procedure TfrmCad_Agenda.edtCepRegNaoAchado(ADataSet: TDataSet;
  Sender: TObject);
begin
  inherited;
  edtBairro.Clear;
end;

procedure TfrmCad_Agenda.FormShow(Sender: TObject);
begin
  inherited;
  //ConfiguraEditPesquisa(edtProfissional,pDataSet,tpPetProfissional);
  ConfiguraEditPesquisa(edtAnimal,pDataSet,tpPetAnimal);
  edtAnimal.OnAbrePesquisa := vPesq.AbreEditPesquisaAimal;
  ConfiguraEditPesquisa(edtTipoServico,pDataSet,tpPetTipoServico);
  ConfiguraEditPesquisa(edtCEP,pDataSet,tpImoCEP,'LOGRADOURO','CEP','CEP','IDCEP',8);

 // edtProfissional.Localiza;
  edtAnimal.Localiza;
  edtCep.Localiza;

  DataCadAgenda.DataSet := pDataSet;

end;

end.
