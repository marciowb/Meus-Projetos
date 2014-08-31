unit SQLConsole;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao_Pan, JvExControls, JvEnterTab, cxPC, cxControls,
  StdCtrls, ComCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, DBClient, Buttons, ZSqlMonitor;

type
  TfrmSQLConsole = class(TfrmPadrao)
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    mmScript: TRichEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    TvResultado: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    DataResultado: TDataSource;
    CdsResultado: TClientDataSet;
    btnLimpar: TBitBtn;
    BtnExecutar: TBitBtn;
    Monitor: TZSQLMonitor;
    procedure btnLimparClick(Sender: TObject);
    procedure BtnExecutarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSQLConsole: TfrmSQLConsole;

implementation

uses Comandos_Pan, uDMConexao_Pan, Classes_Pan;

{$R *.dfm}

procedure TfrmSQLConsole.BtnExecutarClick(Sender: TObject);
var
  i : Integer;
  tp : TTipoCampo;
begin
  inherited;
  Atu_Cds(CdsResultado, mmScript.Text);
  TvResultado.ClearItems;
  for I := 0 to CdsResultado.Fields.Count - 1 do
  Begin
//    case CdsResultado.Fields[i].DataType of
//      ftString, ftMemo , ftWideMemo :
//          Begin
//            vWr := vWr  +vSep + QuotedStr(Cds.Fields[i].AsString);
//            Valor := QuotedStr(Cds.Fields[i].AsString);
//          End;
//          ftBlob:
//          Begin
//            Q.ParamByName(StrParam).Assign(Cds.FieldByName(StrParam));
//          End;
//          ftDate, ftDateTime :
//          Begin
//            vWr := vWr + vSep + GetData(Cds.Fields[i].AsDateTime);
//            Valor :=  GetData(Cds.Fields[i].AsDateTime);
//          End;
//          ftTime, ftTimeStamp:
//          Begin
//            vWr := vWr + vSep + GetTime(Cds.Fields[i].AsDateTime);
//            Valor :=  GetTime(Cds.Fields[i].AsDateTime);
//          End;
//          ftInteger, ftLargeint, ftSmallint:
//          Begin
//            vWr := vWr  +vSep + Cds.Fields[i].AsString;
//            Valor := Cds.Fields[i].AsString;
//      
//    end;
//    MontaGrid(TvResultado, CdsResultado.Fields[i].FieldName,CdsResultado.Fields[i].FieldName,  )
  End;  
end;

procedure TfrmSQLConsole.btnLimparClick(Sender: TObject);
begin
  inherited;
  mmScript.Clear;
end;

end.
