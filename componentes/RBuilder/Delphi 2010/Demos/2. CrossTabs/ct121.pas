{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit ct121;

interface

{$I ppIfDef.pas}

uses
  {$IFDEF Delphi6} Variants, {$ENDIF}
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ppComm, ppProd, ppClass, ppReport, ppBands, ppRelatv, ppCache, ctRptFrm,
  daSQL, ppDB, ppDBPipe, ppDBBDE, daDBBDE, ppModule, ppCTMain, ppStrtch, ppVar,
  ppPrnabl, ppCtrls, daDataView, daQueryDataView, daDataModule;

type
  TfrmCT121 = class(TctReportForm)
    ppReport1: TppReport;
    ppHeaderBand2: TppHeaderBand;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppDetailBand2: TppDetailBand;
    ppFooterBand2: TppFooterBand;
    ppSystemVariable1: TppSystemVariable;
    ppCrossTab1: TppCrossTab;
    BDEQueryDataView1: TdaBDEQueryDataView;
    procedure ppCrossTab1TraverseRecord(Sender: TObject;
      aDataPipeline: TppDataPipeline; var aSkipRecord: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCT121: TfrmCT121;

implementation

{$R *.DFM}

procedure TfrmCT121.ppCrossTab1TraverseRecord(Sender: TObject; aDataPipeline: TppDataPipeline; var aSkipRecord: Boolean);
begin
  if (aDataPipeline['State'] = '') or (aDataPipeline['State'] = null) then
    aSkipRecord := True;
end;

end.
