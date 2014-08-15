{******************************************************************************}
{                                                                              }
{                   ReportBuilder Tutorials                                    }
{                                                                              }
{             Copyright (c) 1996, 2000 Digital Metaphors Corporation           }
{                                                                              }
{******************************************************************************}

unit rbMDD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ppComm, ppRelatv, ppDB, ppDBPipe, Db, DBTables, ppBands, ppClass,
  ppCtrls, ppReport, ppPrnabl, ppStrtch, ppSubRpt, ppCache, ppProd,
  ppModule, daDatMod, ppVar, StdCtrls;

type
  TfrmMasterDetailDetail = class(TForm)
    tblOrder: TTable;
    dsOrder: TDataSource;
    plOrder: TppDBPipeline;
    tblCustomer: TTable;
    dsCustomer: TDataSource;
    plCustomer: TppDBPipeline;
    tblEmployee: TTable;
    dsEmployee: TDataSource;
    plEmployee: TppDBPipeline;
    rbOrderDetail: TppReport;
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
    tblItem: TTable;
    dsItem: TDataSource;
    plItem: TppDBPipeline;
    tblPart: TTable;
    dsPart: TDataSource;
    plPart: TppDBPipeline;
    ppSubReport2: TppSubReport;
    ppChildReport2: TppChildReport;
    ppDetailBand3: TppDetailBand;
    ppGroup2: TppGroup;
    ppGroupHeaderBand2: TppGroupHeaderBand;
    ppGroupFooterBand2: TppGroupFooterBand;
    ppShape6: TppShape;
    ppLabel16: TppLabel;
    ppDBText11: TppDBText;
    ppLabel17: TppLabel;
    ppDBText12: TppDBText;
    ppLabel18: TppLabel;
    ppDBText13: TppDBText;
    ppLabel19: TppLabel;
    ppDBText14: TppDBText;
    ppLabel20: TppLabel;
    vrItemTotal: TppVariable;
    ppShape7: TppShape;
    ppShape8: TppShape;
    ppLabel21: TppLabel;
    vrOrderTotal: TppVariable;
    lblContinued: TppLabel;
    ppGroup3: TppGroup;
    ppGroupHeaderBand3: TppGroupHeaderBand;
    ppGroupFooterBand3: TppGroupFooterBand;
    procedure btnPreviewClick(Sender: TObject);
    procedure vrItemTotalCalc(Sender: TObject; var Value: Variant);
    procedure vrOrderTotalCalc(Sender: TObject; var Value: Variant);
    procedure lblContinuedPrint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMasterDetailDetail: TfrmMasterDetailDetail;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TfrmMasterDetailDetail.btnPreviewClick }

procedure TfrmMasterDetailDetail.btnPreviewClick(Sender: TObject);
begin
  rbOrderDetail.Print;
end;

{------------------------------------------------------------------------------}
{ TfrmMasterDetailDetail.vrItemTotalCalc }

procedure TfrmMasterDetailDetail.vrItemTotalCalc(Sender: TObject; var Value: Variant);
begin
  Value := plItem['Qty'] * plPart['ListPrice'];
end;

{------------------------------------------------------------------------------}
{ TfrmMasterDetailDetail.vrOrderTotalCalc }

procedure TfrmMasterDetailDetail.vrOrderTotalCalc(Sender: TObject; var Value: Variant);
begin
  Value := Value + vrItemTotal.Value;

end;

{------------------------------------------------------------------------------}
{ TfrmMasterDetailDetail.lblContinuedPrint }

procedure TfrmMasterDetailDetail.lblContinuedPrint(Sender: TObject);
begin
  lblContinued.Visible := ppChildReport1.Detail.Overflow;
end;

end.
