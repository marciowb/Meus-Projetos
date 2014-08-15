unit Lst_Caixa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uListagemPadrao, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, DBClient, pFIBClientDataSet, ActnList,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxPC, StdCtrls, Buttons,
  dxStatusBar, ExtCtrls;

type
  TfrmLst_Caixa = class(TfrmListagemPadrao)
    BitBtn11: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure CdsListagemAfterOpen(DataSet: TDataSet);
    procedure BitBtn11Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actNovoExecute(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
    procedure CdsListagemNewRecord(DataSet: TDataSet);
    procedure actImprimirExecute(Sender: TObject);
  private
    FIdServico: Integer;
    procedure SetIdServico(const Value: Integer);
    { Private declarations }
  public
    { Public declarations }
    Property IdServico: Integer read FIdServico write SetIdServico;
  end;

var
  frmLst_Caixa: TfrmLst_Caixa;

implementation

uses MinhasClasses, Comandos, Cad_Caixa, uRelCaixa;

{$R *.dfm}

procedure TfrmLst_Caixa.actEditarExecute(Sender: TObject);
begin
  inherited;
  frmCad_Caixa := TfrmCad_Caixa.Create(Self);
  Try
    frmCad_Caixa.pDataSet := Self.CdsListagem;
    frmCad_Caixa.pDataSet.Edit;
    frmCad_Caixa.FechaEGrava := True;
    frmCad_Caixa.ShowModal;
    AtuDados;
  Finally
    FreeAndNil(frmCad_Caixa);
  End;

end;

procedure TfrmLst_Caixa.actImprimirExecute(Sender: TObject);
begin
  inherited;
  frmRelCaixa := TfrmRelCaixa.Create(nil);
  Try
    frmRelCaixa.ShowModal;
  Finally
    FreeAndNil(frmRelCaixa);
  End;
end;

procedure TfrmLst_Caixa.actNovoExecute(Sender: TObject);
begin
  inherited;
  frmCad_Caixa := TfrmCad_Caixa.Create(Self);
  Try
    frmCad_Caixa.pDataSet := Self.CdsListagem;
    frmCad_Caixa.pDataSet.Append;
    frmCad_Caixa.FechaEGrava := True;
    frmCad_Caixa.ShowModal;
    AtuDados;
  Finally
    FreeAndNil(frmCad_Caixa);
  End;
end;

procedure TfrmLst_Caixa.BitBtn11Click(Sender: TObject);
begin
  inherited;
  AtuDados;
end;

procedure TfrmLst_Caixa.CdsListagemAfterOpen(DataSet: TDataSet);
begin
  inherited;
  CdsListagem.FieldByName('VALOR_CALC').ProviderFlags := [];
  FormataMascara(CdsListagem.FieldByName('VALOR_CALC'), tcMoeda);
  FormataMascara(CdsListagem.FieldByName('VALOR'), tcMoeda);
end;

procedure TfrmLst_Caixa.CdsListagemNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsListagem.FieldByName('IDCAIXA').AsString := GetCodigo(tpPetCaixa);
  CdsListagem.FieldByName('IDUSUARIO').AsInteger := USuarioLogado.Id;
  CdsListagem.FieldByName('DATA').AsString := GetDataServidor;
end;

procedure TfrmLst_Caixa.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa := tpPetCaixa;
  CriaColuna('DATA','Data',80,tcCampoData);
  CriaColuna('HISTORICO','Histórico',200,tcString);
  CriaColuna('VALOR_CALC','Valor',150,tcMoeda);
end;

procedure TfrmLst_Caixa.FormShow(Sender: TObject);
begin
  inherited;
  AtuDados;
end;

procedure TfrmLst_Caixa.SetIdServico(const Value: Integer);
begin
  FIdServico := Value;
  if Value > 0 then
    Self.Wr := 'IDSERVICO = '+GetInteger(Value);
end;

end.
