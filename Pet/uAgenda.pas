unit uAgenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao, DB, DBClient, pFIBClientDataSet, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, Menus, cxStyles, cxEdit, cxScheduler,
  cxSchedulerStorage, cxSchedulerCustomControls, cxSchedulerCustomResourceView,
  cxSchedulerDayView, cxSchedulerDateNavigator, cxSchedulerHolidays,
  cxSchedulerTimeGridView, cxSchedulerUtils, cxSchedulerWeekView,
  cxSchedulerYearView, cxSchedulerGanttView, cxSchedulerDBStorage, ExtCtrls,
  StdCtrls, Buttons, ActnList,MinhasClasses, Mask, EditPesquisa,StrUtils,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxScheduler3Painter;

type
  TfrmAgenda = class(TfrmPadrao)
    DataAgenda: TDataSource;
    CdsAgenda: TpFIBClientDataSet;
    SchedulerDBStorage: TcxSchedulerDBStorage;
    Agenda: TcxScheduler;
    Feriados: TcxSchedulerHolidays;
    GroupBox1: TGroupBox;
    grpTipoView: TRadioGroup;
    ActionList1: TActionList;
    actNovo: TAction;
    actEditar: TAction;
    actExcluir: TAction;
    BitBtn4: TBitBtn;
    edtAnimal: TEditPesquisa;
    actVenda: TAction;
    grpFiltro: TRadioGroup;
    Panel1: TPanel;
    BitBtn3: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure grpTipoViewClick(Sender: TObject);
    procedure CdsAgendaAfterOpen(DataSet: TDataSet);
    procedure CdsAgendaNewRecord(DataSet: TDataSet);
    procedure CdsAgendaBeforePost(DataSet: TDataSet);
    procedure actNovoExecute(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure CdsAgendaAfterPost(DataSet: TDataSet);
    procedure AgendaDblClick(Sender: TObject);
    procedure actVendaExecute(Sender: TObject);
  private
    { Private declarations }
    Ta: TTipoAlteracao;
  public
    { Public declarations }
    Procedure AtuDados;
  end;

var
  frmAgenda: TfrmAgenda;

implementation

uses UDmConexao, Comandos, Cad_Agenda  , uLibPet;

{$R *.dfm}

procedure TfrmAgenda.actEditarExecute(Sender: TObject);
begin
  inherited;
  if Agenda.SelectedEventCount = 0 then
  Begin
    Avisa('Selecione algum evento válido');
    Exit;
  end;
  frmCad_Agenda := TfrmCad_Agenda.Create(nil);
  Try
    with frmCad_Agenda do
    Begin
      CdsAgenda.Locate('IDAGENDA', Agenda.SelectedEvents[0].ID,[]);
      pDataSet := CdsAgenda;
      FechaEGrava := True;
      pDataSet.Edit;
      ShowModal;
      AtuDados;
    End;
  Finally
    FreeAndNil(frmCad_Agenda);
  End;
end;

procedure TfrmAgenda.actExcluirExecute(Sender: TObject);
begin
  inherited;
  if ConfirmaDel then
  Begin
    if Agenda.SelectedEventCount = 0 then
    Begin
      Avisa('Selecione algum evento válido');
      Exit;
    end;
    CdsAgenda.Locate('IDAGENDA', Agenda.SelectedEvents[0].ID,[]);
    Try
      StartTrans;
      AlteraBanco(taDeleta,CdsAgenda,'AGENDA','IDAGENDA');
      Commit;
      AtuDados;
    Except
      on e: Exception do
      Begin
        Rollback;
        Raise;
      End;
    End;
  End;
end;

procedure TfrmAgenda.actNovoExecute(Sender: TObject);
begin
  inherited;
  frmCad_Agenda := TfrmCad_Agenda.Create(nil);
  Try
    with frmCad_Agenda do
    Begin
      pDataSet := Self.CdsAgenda;
      FechaEGrava := False;
      pDataSet.Append;
      ShowModal;
      AtuDados;
    End;
  Finally
    FreeAndNil(frmCad_Agenda);
  End;
end;

procedure TfrmAgenda.actVendaExecute(Sender: TObject);
begin
  inherited;
  if Agenda.SelectedEventCount = 0 then
  Begin
    Avisa('Selecione algum evento válido');
    Exit;
  end;
  CdsAgenda.Locate('IDAGENDA', Agenda.SelectedEvents[0].ID,[]);
  ABreVenda(CdsAgenda.FieldByName('IDAGENDA').AsInteger);
end;

procedure TfrmAgenda.AgendaDblClick(Sender: TObject);
begin
  inherited;
  actEditarExecute(nil);
end;

procedure TfrmAgenda.AtuDados;
var
  StrSQL,Filtro: String;
begin
  inherited;
  case grpFiltro.ItemIndex of
    0:
      Filtro := ' AND COALESCE(A.FLAGBAIXADA,''N'') = ''N''' ;
    1:
      Filtro := ' AND COALESCE(A.FLAGBAIXADA,''N'') = ''Y''' ;
  end;
  StrSQL :=
    'SELECT A.IDAGENDA, A.DATA, A.HORAINICIAL, A.HORAFINAL,A.IDANIMAL, A.IDPROFISSIONAL,'+
    '       A.OBS, A.FLAGBAIXADA, AN.NOMEANIMAL, COALESCE(C.NOMECLIENTE,A.NOMECLIENTE)NOMECLIENTE,'+
    '       P.NOMEPROFISSIONAL,''0'' TYPE,''3'' OPTIONS,'+
    '       CAST(A.DATA+ A.HORAINICIAL AS TIMESTAMP)DATA_HORAINI,'+
    '       CAST(A.DATA+ A.HORAFINAL AS TIMESTAMP)DATA_HORAFIM, '+
    '       A.IDCEP, A.IDTIPOSERVICO,A.NUMERO,A.COMPLEMENTO,A.FLAGCLIENTECADASTRADO, '+
    '       ''Cliente: ''||COALESCE(C.NOMECLIENTE,A.NOMECLIENTE)||''  Animal: ''||AN.NOMEANIMAL||'' Serviço:''||TS.NOMETIPOSERVICO CAPTION'+
    '  FROM AGENDA A'+
    '  LEFT JOIN ANIMAL AN'+
    '    ON (AN.IDANIMAL = A.IDANIMAL)'+
    '  LEFT JOIN CLIENTE C'+
    '    ON (C.IDCLIENTE = AN.IDCLIENTE)'+
    '  LEFT JOIN PROFISSIONAL P'+
    '    ON (P.IDPROFISSIONAL = A.IDPROFISSIONAL)'+
    '  LEFT JOIN TIPOSERVICO TS '+
    '    ON (TS.IDTIPOSERVICO = A.IDTIPOSERVICO)'+
    ' WHERE 1=1 '+Filtro+
       ifThen(not edtAnimal.IsNull,' AND AN.IDANIMAL = '+edtAnimal.ValorChaveString);

  SetCds(CdsAgenda,StrSQL);
  if not edtAnimal.IsNull then
  Begin
    grpTipoView.ItemIndex := 2;
    grpTipoViewClick(nil);
  End;

end;

procedure TfrmAgenda.BitBtn4Click(Sender: TObject);
begin
  inherited;
  AtuDados;
end;

procedure TfrmAgenda.CdsAgendaAfterOpen(DataSet: TDataSet);
begin
  inherited;
  CdsAgenda.FieldByName('NOMEANIMAL').ProviderFlags := [];
  CdsAgenda.FieldByName('NOMEPROFISSIONAL').ProviderFlags := [];
  CdsAgenda.FieldByName('TYPE').ProviderFlags := [];
  CdsAgenda.FieldByName('OPTIONS').ProviderFlags := [];
  CdsAgenda.FieldByName('CAPTION').ProviderFlags := [];
  CdsAgenda.FieldByName('DATA_HORAINI').ProviderFlags := [];
  CdsAgenda.FieldByName('DATA_HORAFIM').ProviderFlags := [];
end;

procedure TfrmAgenda.CdsAgendaAfterPost(DataSet: TDataSet);
begin
  inherited;
  Try
    StartTrans;
    AlteraBanco(Ta,CdsAgenda,'AGENDA','IDAGENDA');
    Commit;
  Except
    on e: Exception do
    Begin
      Rollback;
      Raise;
    End;
  End;
end;

procedure TfrmAgenda.CdsAgendaBeforePost(DataSet: TDataSet);
begin
  inherited;
  if CdsAgenda.State = dsInsert then
    ta := taInsere
  else
    ta := taModifica;

end;

procedure TfrmAgenda.CdsAgendaNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsAgenda.FieldByName('IDAGENDA').AsInteger := GetValSeq('SEQ_IDAGENDA');
  CdsAgenda.FieldByName('DATA').AsString := GetDataServidor;
end;

procedure TfrmAgenda.FormShow(Sender: TObject);
begin
  AtuDados;
  ConfiguraEditPesquisa(edtAnimal, nil,tpPetAnimal);
end;

procedure TfrmAgenda.grpTipoViewClick(Sender: TObject);
begin
  inherited;
  Agenda.SelectDays([Now],True);
  case grpTipoView.ItemIndex of
    0:
     Agenda.ViewDay.Active := True;
    1:
     Agenda.ViewWeeks.Active := True;
    2:
     Begin
       Agenda.SelectDays(FirstDay(Now),LastDay(Now),True);
       Agenda.ViewWeeks.Active := True;
     End;
    3:
     Agenda.ViewYear.Active := True;
  end;
end;

end.
