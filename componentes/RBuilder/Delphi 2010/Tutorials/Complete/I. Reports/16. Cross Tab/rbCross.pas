{******************************************************************************}
{                                                                              }
{                   ReportBuilder Tutorials                                    }
{                                                                              }
{             Copyright (c) 1996, 2000 Digital Metaphors Corporation           }
{                                                                              }
{******************************************************************************}

unit rbCross;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, ppPrnabl, ppClass, ppStrtch, ppCTMain, ppDB, ppBands,
  ppCache, ppProd, ppReport, ppComm, ppRelatv, ppDBPipe, ppVar, ppCtrls,
  StdCtrls;

type
  TfrmSalesCross = class(TForm)
    qryOrder: TQuery;
    dsOrder: TDataSource;
    plOrder: TppDBPipeline;
    rbOrder: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppCrossTab1: TppCrossTab;
    ppLabel1: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    btnPreview: TButton;
    procedure btnPreviewClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSalesCross: TfrmSalesCross;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TfrmSalesCross.btnPreviewClick }

procedure TfrmSalesCross.btnPreviewClick(Sender: TObject);
begin
  rbOrder.Print;
end;

end.
