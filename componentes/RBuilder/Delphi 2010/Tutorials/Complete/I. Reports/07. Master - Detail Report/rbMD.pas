{******************************************************************************}
{                                                                              }
{                   ReportBuilder Tutorials                                    }
{                                                                              }
{             Copyright (c) 1996, 2000 Digital Metaphors Corporation           }
{                                                                              }
{******************************************************************************}

unit rbMD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ppComm, ppRelatv, ppDB, ppDBPipe, Db, DBTables, ppBands, ppClass,
  ppCtrls, ppReport, ppPrnabl, ppStrtch, ppSubRpt, ppCache, ppProd,
  ppModule, daDatMod, ppVar, StdCtrls;

type
  TfrmMasterDetail = class(TForm)
    tblOrder: TTable;
    dsOrder: TDataSource;
    plOrder: TppDBPipeline;
    tblCustomer: TTable;
    dsCustomer: TDataSource;
    plCustomer: TppDBPipeline;
    tblEmployee: TTable;
    dsEmployee: TDataSource;
    plEmployee: TppDBPipeline;
    rbOrderSummary: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppSubReport1: TppSubReport;
    ppChildReport1: TppChildReport;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppShape1: TppShape;
    ppLabel3: TppLabel;
    ppDBText1: TppDBText;
    ppLabel4: TppLabel;
    ppDBText2: TppDBText;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppTitleBand1: TppTitleBand;
    ppDetailBand2: TppDetailBand;
    ppSummaryBand1: TppSummaryBand;
    ppShape2: TppShape;
    ppLabel5: TppLabel;
    ppDBText3: TppDBText;
    ppLabel6: TppLabel;
    ppDBText4: TppDBText;
    ppLabel7: TppLabel;
    ppDBText5: TppDBText;
    ppShape3: TppShape;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    ppDBText6: TppDBText;
    ppLabel10: TppLabel;
    ppDBText7: TppDBText;
    ppLabel11: TppLabel;
    ppShape4: TppShape;
    ppLabel12: TppLabel;
    ppDBText8: TppDBText;
    ppLabel13: TppLabel;
    ppDBText9: TppDBText;
    ppShape5: TppShape;
    ppLabel14: TppLabel;
    ppLine1: TppLine;
    ppLine2: TppLine;
    ppDBCalc1: TppDBCalc;
    ppLine4: TppLine;
    ppLabel15: TppLabel;
    ppDBText10: TppDBText;
    ppLine3: TppLine;
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
  frmMasterDetail: TfrmMasterDetail;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TfrmMasterDetail.btnPreviewClick }

procedure TfrmMasterDetail.btnPreviewClick(Sender: TObject);
begin
  rbOrderSummary.Print;
end;

end.
