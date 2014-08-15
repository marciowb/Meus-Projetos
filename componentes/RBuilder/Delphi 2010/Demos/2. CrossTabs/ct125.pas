{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit ct125;

interface

{$I ppIfDef.pas}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ppComm, ppProd, ppClass, ppReport, ppBands, ppRelatv, ppCache, ctRptFrm,
  ppDB, ppDBPipe, ppDBBDE, daDBBDE, ppModule, ppCTMain, ppStrtch, ppVar, ppPrnabl,
  ppCtrls, ppTypes, daSQL, daDataView, daQueryDataView, daDataModule;

type
  TfrmCT125 = class(TctReportForm)
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
    procedure ppCrossTab1GetDimensionValue(Sender: TObject;
      aDimension: TppDimension; var aValue: Variant; var aSkip: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCT125: TfrmCT125;

implementation

{$R *.DFM}

procedure TfrmCT125.ppCrossTab1GetDimensionName(Sender: TObject;
  aDimension: TppDimension; var aName: String);
begin
  if (aDimension = TppCrossTab(Sender).ValueDefs[0]) then
    aName := 'Sum of Orders under $50,000'
  else if (aDimension = TppCrossTab(Sender).ValueDefs[1]) then
    aName := 'Sum of Orders over $50,000';
end;

procedure TfrmCT125.ppCrossTab1GetDimensionValue(Sender: TObject; aDimension: TppDimension; var aValue: Variant; var aSkip: Boolean);
var
  lValueDef: TppValueDef;
  lValue: Variant;
  lCrossTab: TppCrossTab;
begin
  if not(aDimension is TppValueDef) then Exit;

  lValueDef := TppValueDef(aDimension);

  lCrossTab := TppCrossTab(Sender);

  lValue := lCrossTab.DataPipeline['AmountPaid'];

  {return zero based on value def}
  if (lValueDef = lCrossTab.ValueDefs[0]) and (lValue > 50000) then
    aValue := 0

  else if (lValueDef = lCrossTab.ValueDefs[1]) and (lValue < 50000) then
    aValue := 0;

end;

end.
