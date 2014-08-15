unit uDmRelatorio;

interface

uses
  SysUtils, Classes, ppEndUsr, ppComm, ppRelatv, ppProd, ppClass, ppReport, DB,
  ppDB, ppDBPipe,DBClient, pFIBClientDataSet, RDprint, ppParameter, ppBands,
  ppCache, raIDE, raObjectRTTI, raComm, raRelatv, raFunc, ppDBBDE,
  ppCTDsgn, ppFormWrapper, ppRptExp, JPEG, ppJPEG,
  ppDsgnDB, ppTmplat, ppMemo, ppCtrls,
  ppStrtch, ppSubRpt, ppPrnabl,  ppVar, ppModule, raCodMod,
  Messages, Graphics, ppBarCod,daIDE, StrUtils,
  ppUtils, ppDsIntf, ppForms, daDataWizard, daQueryWizard,
  daQueryDesigner, daDataManager, daDataSettingDlg,
  ppTBX, ppToolbarTBX, ppDesignLayoutManager, ppDesignLayoutMenu,
  ppDesignToolManagerTBX, ppDesignToolbarsTBX, ppDesignToolActions, ActnList,
  ppViewr,  ppTypes, ppDevice, ppPDFDevice, ppFilDev,ppOutLineSettings;

type
  TDmRelatorio = class(TDataModule)
    Report: TppReport;
    Designer: TppDesigner;
    ppDBMaster: TppDBPipeline;
    ppDBDetalhes: TppDBPipeline;
    ppDBInformacoes: TppDBPipeline;
    DataMaster: TDataSource;
    DataDetalhes: TDataSource;
    DataInformacoes: TDataSource;
    ppDBLayout: TppDBPipeline;
    DataLayout: TDataSource;
    CdsLayout: TpFIBClientDataSet;
    RDprint: TRDprint;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    procedure CdsLayoutNewRecord(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure CdsLayoutAfterOpen(DataSet: TDataSet);
    procedure CdsLayoutAfterPost(DataSet: TDataSet);
  private
    FpIdRelatorio: Integer;
    { Private declarations }
  public
    { Public declarations }
    Procedure SalvaLayout(Sender : TObject; Stream : TStream);
    property pIdRelatorio : Integer read FpIdRelatorio write FpIdRelatorio;
  end;

var
  DmRelatorio: TDmRelatorio;

implementation

uses Comandos, MinhasClasses;

{$R *.dfm}

procedure TDmRelatorio.CdsLayoutAfterOpen(DataSet: TDataSet);
begin
   CdsLayout.FieldByName('IMPRESSORAPADRAO').ProviderFlags := [];
end;

procedure TDmRelatorio.CdsLayoutAfterPost(DataSet: TDataSet);
begin
   try
    StartTrans;
    AlteraBanco(taInsertOrUpdate, CdsLayout, 'LAYOUT', 'IDLAYOUT');
    Commit;
  except
    on E: Exception do
    Begin
      RollBack;
      raise;
    End;
  end;
end;

procedure TDmRelatorio.CdsLayoutNewRecord(DataSet: TDataSet);
begin
  CdsLayout.FieldByName('FLAGTIPOLAYOUT').AsString := 'G';
end;

procedure TDmRelatorio.DataModuleCreate(Sender: TObject);
begin
  Report.Template.reOnSaveEnd :=  SalvaLayout;
  Report.OutlineSettings.Enabled := False;
end;

procedure TDmRelatorio.SalvaLayout(Sender: TObject; Stream: TStream);
begin
 if CdsLayout.State in [dsEdit, dsInsert] then
 Begin
   CdsLayout.FieldByName('IDRELATORIO').AsInteger := pIdRelatorio;
   CdsLayout.FieldByName('NOMELAYOUT').AsString := Report.Template.Description;
   if CdsLayout.State = dsInsert then
   Begin
     CdsLayout.FieldByName('IDLAYOUT').AsString := GetCodigo(tpLayout);
     CdsLayout.FieldByName('DATACRIACAO').AsString := GetDataServidor
   End  else
     CdsLayout.FieldByName('DATAMODIFICACAO').AsString := GetDataServidor;


 End;

end;

end.
