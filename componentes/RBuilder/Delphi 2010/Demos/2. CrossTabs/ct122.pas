{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit ct122;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ppComm, ppProd, ppClass, ppReport, ppBands, ppRelatv, ppCache, ctRptFrm,
  ppDB, ppDBPipe, ppDBBDE, daDBBDE, ppModule, ppCTMain, ppStrtch, ppVar, ppPrnabl,
  ppCtrls, daSQL, daDataView, daQueryDataView, daDataModule;

type
  TfrmCT122 = class(TctReportForm)
    ppReport1: TppReport;
    ppHeaderBand2: TppHeaderBand;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppDetailBand2: TppDetailBand;
    ppFooterBand2: TppFooterBand;
    ppSystemVariable1: TppSystemVariable;
    ppCrossTab1: TppCrossTab;
    BDEQueryDataView1: TdaBDEQueryDataView;
    procedure ppCrossTab1GetDimensionValue(Sender: TObject;
      aDimension: TppDimension; var aValue: Variant; var aSkip: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCT122: TfrmCT122;

implementation

{$R *.DFM}

procedure TfrmCT122.ppCrossTab1GetDimensionValue(Sender: TObject; aDimension: TppDimension; var aValue: Variant; var aSkip: Boolean);
begin
  if (aDimension.FieldName = 'State') then
    aValue := 'All States';
end;

end.
