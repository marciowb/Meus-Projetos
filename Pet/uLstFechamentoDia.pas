unit uLstFechamentoDia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao, StdCtrls, Buttons, ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, DBClient,
  cxClasses, pFIBClientDataSet, cxPC, cxCustomPivotGrid, cxDBPivotGrid,
  cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, FIBDataSet, pFIBDataSet, cxContainer, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, Grids, DBGrids, cxTL,
  cxTLdxBarBuiltInMenu, cxInplaceContainer, cxDBTL, cxTLData;

type
  TfrmLst_FechamentoDia = class(TfrmPadrao)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    Panel3: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    edtData: TcxDateEdit;
    btnAtualizar: TBitBtn;
    DataDia: TDataSource;
    CdsDia: TpFIBClientDataSet;
    Tree: TcxDBTreeList;
    cxDBTreeList1cxDBTreeListColumn1: TcxDBTreeListColumn;
    cxDBTreeList1cxDBTreeListColumn2: TcxDBTreeListColumn;
    edtDataFin: TcxDateEdit;
    Label2: TLabel;
    BitBtn3: TBitBtn;
    CdsDetalhes: TpFIBClientDataSet;
    CdsDetalhesDataIni: TDateField;
    CdsDetalhesDataFin: TDateField;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure CdsDiaAfterOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure cxDBTreeList1cxDBTreeListColumn2TcxTreeListColumnSummaryFooterSummaryItems0GetText(
      Sender: TcxTreeListSummaryItem; const AValue: Variant; var AText: string);
    procedure cxDBTreeList1cxDBTreeListColumn2TcxTreeListColumnSummaryGroupFooterSummaryItems0GetText(
      Sender: TcxTreeListSummaryItem; const AValue: Variant; var AText: string);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLst_FechamentoDia: TfrmLst_FechamentoDia;

implementation

uses UDmConexao, Comandos, MinhasClasses;

{$R *.dfm}

procedure TfrmLst_FechamentoDia.BitBtn1Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmLst_FechamentoDia.btnAtualizarClick(Sender: TObject);
var
  StrSQL,Data: String;
begin
  inherited;
  if (edtData.Text = '  /  /    ') or
     (edtData.Text = '') then
  Begin
    edtData.SetFocus;
    Avisa('Informe a data inicial');
    Abort;
  End;
  if (edtDataFin.Text = '  /  /    ') or
     (edtDataFin.Text = '')  then
  Begin
    edtDataFin.SetFocus;
    Avisa('Informe a data final');
    Abort;
  End;
  GetPeriodo(edtData.Text, edtDataFin.Text,Data,'Data',True,False);  //GetData(edtData.Date) ;
  StrSQL :=
    'SELECT DISTINCT ''VENDAS'' DESCRICAO, null VALOR,1 ID, NULL PAI'+
    '  FROM SERVICO S'+
    ' WHERE  '+Data+
    ' UNION ALL '+
    'SELECT  FP.NOMEFORMAPAGAMENTO DESCRICAO, SUM(SP.VALOR)VALOR,2,1 PAI'+
    '  FROM SERVICO S'+
    ' INNER JOIN SERVICOFORMAPAGAMENTO SP'+
    '    ON (S.IDSERVICO = SP.IDSERVICO)'+
    ' INNER JOIN FORMAPAGAMENTO FP'+
    '    ON (FP.IDFORMAPAGAMENTO = SP.IDFORMAPAGAMENTO)'+
    ' WHERE  '+Data+
    ' GROUP BY 1'+
    ' UNION ALL '+
    'SELECT DISTINCT  ''LANÇAMENTOS NO CAIXA'',null VALOR,3 ID, NULL PAI'+
    '  FROM CAIXA CX'+
    ' WHERE CX.IDSERVICO IS NULL'+
    '   AND  '+Data+
    '   AND CX.IDCONTARECEBERREC IS NULL  '+
    ' UNION ALL  ' +
    'SELECT CASE WHEN CX.FLAGOPERACAO = ''C'' THEN ''CRÉDITOS'' '+
    '            ELSE ''DÉBITOS'' END||'' NO CAIXA '', '+
    '       SUM(CASE WHEN CX.FLAGOPERACAO = ''C'' THEN CX.VALOR ELSE CX.VALOR * -1 END) VALOR,4 ID, 3 PAI'+
    '  FROM CAIXA CX'+
    ' WHERE CX.IDSERVICO IS NULL'+
    '   AND  '+Data+
    '   AND CX.IDCONTARECEBERREC IS NULL  '+
    ' GROUP BY 1  '+
    ' UNION ALL  ' +
    'SELECT ''RECEBIMENTOS DE CONTAS'', SUM(CRR.VALOR)VALOR,5 ID, 10 PAI '+
    '  FROM CONTARECEBERREC CRR '+
    ' WHERE '+Data;
  SetCds(CdsDia,StrSQL);
  if (CdsDia.RecordCount = 1)and (CdsDia.FieldByName('VALOR').IsNull) then
    CdsDia.EmptyDataSet;
  if CdsDia.IsEmpty then
  Begin
    Avisa('Não encontrado nenhum resultado.');
    Exit;
  End;
  Tree.FullExpand;

end;

procedure TfrmLst_FechamentoDia.BitBtn3Click(Sender: TObject);
begin
  inherited;
  btnAtualizarClick(nil);
  if CdsDia.IsEmpty then
  Begin
    Avisa('Não encontrado nenhum resultado.');
    Exit;
  End;
  Try
    CdsDia.DisableControls;
    CdsDetalhes.Append;
    CdsDetalhesDataIni.AsDateTime := edtData.Date;
    CdsDetalhesDataFin.AsDateTime := edtDataFin.Date;
    GravaRelatorio(IdRelResumoFinanceiro,'Resumo financeiro');
    ImprimeRelatorio(IdRelResumoFinanceiro,CdsDia,CdsDetalhes, nil,tlLista,[nil]);
  Finally
    CdsDetalhes.Cancel;
    CdsDia.EnableControls;
  End;
end;

procedure TfrmLst_FechamentoDia.CdsDiaAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FormataMascara(CdsDia.FieldByName('VALOR'),tcMoeda);
end;

procedure TfrmLst_FechamentoDia.cxDBTreeList1cxDBTreeListColumn2TcxTreeListColumnSummaryFooterSummaryItems0GetText(
  Sender: TcxTreeListSummaryItem; const AValue: Variant; var AText: string);
begin
  inherited;
  AText := 'Total Geral: '+FormatFloat(MascaraFloat,AValue);
end;

procedure TfrmLst_FechamentoDia.cxDBTreeList1cxDBTreeListColumn2TcxTreeListColumnSummaryGroupFooterSummaryItems0GetText(
  Sender: TcxTreeListSummaryItem; const AValue: Variant; var AText: string);
begin
  inherited;
  AText := 'SubTotal: '+FormatFloat(MascaraFloat,AValue);
end;

procedure TfrmLst_FechamentoDia.FormShow(Sender: TObject);
begin
  inherited;
  edtData.Text := GetDataServidor;
  edtDataFin.Text := GetDataServidor;
end;

end.
