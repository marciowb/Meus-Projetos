{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit ct124;

interface

{$I ppIfDef.pas}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ppComm, ppProd, ppClass, ppReport, ppBands, ppRelatv, ppCache, ctRptFrm,
  ppDB, ppDBPipe, ppDBBDE, daDBBDE, ppModule, ppCTMain, ppStrtch, ppVar, ppPrnabl,
  ppCtrls, ppTypes, daSQL, daDataView, daQueryDataView, daDataModule;

type
  TfrmCT124 = class(TctReportForm)
    ppReport1: TppReport;
    ppHeaderBand2: TppHeaderBand;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppDetailBand2: TppDetailBand;
    ppFooterBand2: TppFooterBand;
    ppSystemVariable1: TppSystemVariable;
    ppCrossTab1: TppCrossTab;
    BDEQueryDataView1: TdaBDEQueryDataView;
    procedure ppCrossTab1GetDimensionName(Sender: TObject;
      aDimension: TppDimension; var aName: String);
    procedure ppCrossTab1CalcDimensionValue(Sender: TObject;
      aDimension: TppDimension; var aValue: Variant);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCT124: TfrmCT124;

implementation

{$R *.DFM}

procedure TfrmCT124.ppCrossTab1GetDimensionName(Sender: TObject;
  aDimension: TppDimension; var aName: String);
begin
  if (aDimension is TppValueDef) then
    aName := 'Orders over $50,000';
end;

procedure TfrmCT124.ppCrossTab1CalcDimensionValue(Sender: TObject; aDimension: TppDimension; var aValue: Variant);
var
  lValueDef: TppValueDef;
  lValue: Variant;
begin
  {decrement counter if sale amount was less than 50,000}
  if not(aDimension is TppValueDef) then Exit;

  lValueDef := TppValueDef(aDimension);

  if (lValueDef.CalcType <> dcCount) then Exit;

  lValue := TppCrossTab(Sender).DataPipeline['AmountPaid'];

  if (lValue < 50000) then
    aValue := aValue - 1;
end;

end.
