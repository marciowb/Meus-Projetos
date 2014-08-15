unit uCadConfiguracoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao, ExtCtrls, StdCtrls, Buttons, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, dxSkinscxPCPainter, cxPC, Mask,
  EditPesquisa,Generics.Collections,MinhasClasses,uGerenteConfiguracao;

type
  TObjCOnfig = class
  private
    FObj: TObject;
    FObjConfiguracao: TObject;
    FTipoCfg: TTipoConfiguracao;
    procedure SetObjConfiguracao(const Value: TObject);
    procedure SetObj(const Value: TObject);
    procedure SetTipoCfg(const Value: TTipoConfiguracao);
  published
    property ObjConfiguracao: TObject read FObjConfiguracao write SetObjConfiguracao;
    property TipoCfg: TTipoConfiguracao read FTipoCfg write SetTipoCfg;
    property Obj: TObject read FObj write SetObj;
  end;
  TfrmCadConfiguracao = class(TfrmPadrao)
    Panel1: TPanel;
    Panel2: TPanel;
    btnGaravar: TBitBtn;
    btnCancelar: TBitBtn;
    PageConfiguracoes: TcxPageControl;
    tsGeral: TcxTabSheet;
    tsOS: TcxTabSheet;
    GroupBox1: TGroupBox;
    edtConfigOsStatusAberta: TEditPesquisa;
    edtConfigOsStatusExecucao: TEditPesquisa;
    edtConfigOsStatusFinalizada: TEditPesquisa;
    edtConfigOsStatusFaturada: TEditPesquisa;
    edtOperacaoFaturamento: TEditPesquisa;
    procedure edtConfigOsStatusAbertaBtnNovoClick(Sender: TObject);
    procedure edtOperacaoFaturamentoBtnNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtOperacaoFaturamentoRegAchado(
      const ValoresCamposEstra: array of Variant);
    procedure FormShow(Sender: TObject);
    procedure btnGaravarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
     FMapConfiguracoes: TDictionary<TTipoConfiguracao,TObjCOnfig>;
     Procedure CfgToObject(Valor: Variant; Obj: TObject);
     Function  ObjectToCfg(Obj: TObject): Variant;
     Procedure AddObjetos(ObjConfiguracao: Tobject; tCfg: TTipoConfiguracao;Obj: TObject);
     Procedure CarregaConfiguracoes;
     Procedure GravaConfiguracoes;
  public
    { Public declarations }
    Procedure ConfiguraObjetos;
    Procedure AssociaObjetos;
  end;

var
  frmCadConfiguracao: TfrmCadConfiguracao;

implementation

uses uForms, Comandos, uConfiguracaoOS;



{$R *.dfm}

procedure TfrmCadConfiguracao.AddObjetos(ObjConfiguracao: Tobject; tCfg: TTipoConfiguracao;Obj: TObject);
var
  ObjCOnfig: TObjCOnfig;
begin
  ObjCOnfig:= TObjCOnfig.Create;
  ObjCOnfig.Obj := Obj;
  ObjCOnfig.TipoCfg := tCfg;
  ObjCOnfig.ObjConfiguracao := ObjConfiguracao;
  FMapConfiguracoes.Add(tcfg,ObjCOnfig);

end;

procedure TfrmCadConfiguracao.AssociaObjetos;
begin
  {$Region 'O.S.'}
  AddObjetos(COnfiguracaoOS,tpcERPStatusOSAberta,edtConfigOsStatusAberta);
  AddObjetos(COnfiguracaoOS,tpcERPStatusOSFinalizada, edtConfigOsStatusFinalizada);
  AddObjetos(COnfiguracaoOS,tpcERPStatusOSExecucao, edtConfigOsStatusExecucao);
  AddObjetos(COnfiguracaoOS,tpcERPStatusOSFaturada, edtConfigOsStatusFaturada);
  AddObjetos(COnfiguracaoOS,tpcERPOperacaoFaturarOS, edtOperacaoFaturamento);
  {$EndRegion}

end;

procedure TfrmCadConfiguracao.btnCancelarClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfrmCadConfiguracao.btnGaravarClick(Sender: TObject);
begin
  inherited;
  GravaConfiguracoes;
  ModalResult := mrOK;
end;

procedure TfrmCadConfiguracao.CarregaConfiguracoes;
var
  Cfg: TTipoConfiguracao;
begin
  for Cfg in FMapConfiguracoes.Keys do
  begin
    with FMapConfiguracoes.Items[Cfg] do
    begin
      CfgToObject(TConfiguracao(ObjConfiguracao).GetConfiguracao(Cfg),Obj);

    end;

  end;
end;

procedure TfrmCadConfiguracao.CfgToObject(Valor: Variant;  Obj: TObject);
begin
   if Obj is TEditPesquisa then
   begin
     (Obj As TEditPesquisa).ValorChave := Valor;
     (Obj As TEditPesquisa).Localiza;
   end;
end;

procedure TfrmCadConfiguracao.ConfiguraObjetos;
begin
   ConfiguraEditPesquisa(edtConfigOsStatusAberta,nil,tpERPStatusOS);
   ConfiguraEditPesquisa(edtConfigOsStatusExecucao,nil,tpERPStatusOS);
   ConfiguraEditPesquisa(edtConfigOsStatusFinalizada,nil,tpERPStatusOS);
   ConfiguraEditPesquisa(edtConfigOsStatusFaturada,nil,tpERPStatusOS);
   ConfiguraEditPesquisa(edtOperacaoFaturamento,nil,tpERPOperacaoSaida);
   edtOperacaoFaturamento.CamposExtraPesquisa := 'FLAGMOVIMENTAESTOQUE';
end;

procedure TfrmCadConfiguracao.edtConfigOsStatusAbertaBtnNovoClick(
  Sender: TObject);
begin
  inherited;
  TrotinasForms.AbreCadastroStatusOS(toIncluir);
end;

procedure TfrmCadConfiguracao.edtOperacaoFaturamentoBtnNovoClick(
  Sender: TObject);
begin
  inherited;
  TrotinasForms.AbreCadastroOperacaoEstoque(toIncluir);
end;

procedure TfrmCadConfiguracao.edtOperacaoFaturamentoRegAchado(
  const ValoresCamposEstra: array of Variant);
begin
  inherited;
  if ValoresCamposEstra[0] = 'Y' then
  begin
     AvisaErro('A operação para faturamento de O.S. não deve movimentar estoque');
     edtOperacaoFaturamento.Clear;
  end;

end;

procedure TfrmCadConfiguracao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(FMapConfiguracoes);
end;

procedure TfrmCadConfiguracao.FormCreate(Sender: TObject);
begin
  inherited;
  FMapConfiguracoes := TDictionary<TTipoConfiguracao,TObjCOnfig>.Create;
end;

procedure TfrmCadConfiguracao.FormShow(Sender: TObject);
begin
  inherited;
  ConfiguraObjetos;
  AssociaObjetos;
  CarregaConfiguracoes;

end;

procedure TfrmCadConfiguracao.GravaConfiguracoes;
var
  Cfg: TTipoConfiguracao;
begin
  for Cfg in FMapConfiguracoes.Keys do
  begin
    with FMapConfiguracoes.Items[Cfg] do
    begin
      TConfiguracao(ObjConfiguracao).SetConfiguracao(Cfg,ObjectToCfg(Obj));
    end;
  end;


end;

function TfrmCadConfiguracao.ObjectToCfg(Obj: TObject): Variant;
begin
   if Obj is TEditPesquisa then
    Result := (Obj As TEditPesquisa).ValorChave;
end;

{ TObjCOnfig }


procedure TObjCOnfig.SetObj(const Value: TObject);
begin
  FObj := Value;
end;

procedure TObjCOnfig.SetObjConfiguracao(const Value: TObject);
begin
  FObjConfiguracao:= Value;
end;

procedure TObjCOnfig.SetTipoCfg(const Value: TTipoConfiguracao);
begin
  FTipoCfg := Value;
end;

end.
