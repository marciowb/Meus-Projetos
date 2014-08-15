{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit ct126;

interface

{$I ppIfDef.pas}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ppComm, ppProd, ppClass, ppReport, ppBands, ppRelatv, ppCache, ctRptFrm,
  ppDB, ppDBPipe, ppDBBDE, daDBBDE, ppModule, ppCTMain, ppStrtch, ppVar, ppPrnabl,
  ppCtrls, daSQL, daDataView, daQueryDataView, daDataModule;

type
  TfrmCT126 = class(TctReportForm)
    ppReport1: TppReport;
    ppHeaderBand2: TppHeaderBand;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppDetailBand2: TppDetailBand;
    ppFooterBand2: TppFooterBand;
    ppSystemVariable1: TppSystemVariable;
    ppCrossTab1: TppCrossTab;
    BDEQueryDataView1: TdaBDEQueryDataView;
    procedure FormCreate(Sender: TObject);
  private
    procedure ppCrossTab1FormatCell(Sender: TObject; aElement: TppElement; aColumn, aRow: Integer);
  public
    { Public declarations }
  end;

var
  frmCT126: TfrmCT126;

implementation

{$R *.DFM}

procedure TfrmCT126.FormCreate(Sender: TObject);
begin
  ppCrossTab1.OnFormatCell := ppCrossTab1FormatCell;
end;

procedure TfrmCT126.ppCrossTab1FormatCell(Sender: TObject; aElement: TppElement; aColumn, aRow: Integer);
begin
  if (aRow > 0) and (aColumn > 0) and ((aColumn mod 2) = 0) then
    aElement.Color := clSilver
  else
    aElement.Color := clWhite;
end;


end.
