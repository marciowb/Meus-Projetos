{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0091;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dmUtil, ppClass, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppRegion, ppProd,
  ppBarCod, ppSubRpt, ppRelatv;

type
  Tfrm0091 = class(TdmCustomForm)
    Label2: TLabel;
    Label3: TLabel;
    ppReport1: TppReport;
    ppReport1DetailBand1: TppDetailBand;
    ppReport1SubReport1: TppSubReport;
    ppReport1ChildReport1: TppChildReport;
    ppReport1SubReport2: TppSubReport;
    ppReport1ChildReport2: TppChildReport;
    ppReport1SubReport3: TppSubReport;
    ppReport1ChildReport3: TppChildReport;
    ppReport1SubReport4: TppSubReport;
    ppReport1ChildReport4: TppChildReport;
    ppReport1SubReport5: TppSubReport;
    ppReport1ChildReport5: TppChildReport;
    ppReport1SubReport6: TppSubReport;
    ppReport1ChildReport6: TppChildReport;
    ppReport1TitleBand1: TppTitleBand;
    ppReport1ChildReport1HeaderBand1: TppHeaderBand;
    ppReport1Label1: TppLabel;
    ppReport1Line1: TppLine;
    ppReport1Label2: TppLabel;
    ppReport1Label3: TppLabel;
    ppReport1ChildReport1DetailBand1: TppDetailBand;
    ppReport1BarCode1: TppBarCode;
    ppReport1Memo1: TppMemo;
    ppReport1BarCode2: TppBarCode;
    ppReport1BarCode3: TppBarCode;
    ppReport1BarCode4: TppBarCode;
    ppReport1Line2: TppLine;
    ppReport1Line3: TppLine;
    ppReport1Line4: TppLine;
    ppReport1Line5: TppLine;
    ppReport1Line6: TppLine;
    ppReport1ChildReport1FooterBand1: TppFooterBand;
    ppReport1ChildReport2HeaderBand1: TppHeaderBand;
    ppReport1ChildReport2Label1: TppLabel;
    ppReport1ChildReport2Line1: TppLine;
    ppReport1ChildReport2Label2: TppLabel;
    ppReport1ChildReport2Label3: TppLabel;
    ppReport1ChildReport2DetailBand1: TppDetailBand;
    ppReport1ChildReport2BarCode1: TppBarCode;
    ppReport1ChildReport2Memo1: TppMemo;
    ppReport1ChildReport2BarCode2: TppBarCode;
    ppReport1ChildReport2BarCode3: TppBarCode;
    ppReport1ChildReport2BarCode4: TppBarCode;
    ppReport1ChildReport2Line2: TppLine;
    ppReport1ChildReport2Line3: TppLine;
    ppReport1ChildReport2Line4: TppLine;
    ppReport1ChildReport2Line5: TppLine;
    ppReport1ChildReport2Line6: TppLine;
    ppReport1ChildReport2FooterBand1: TppFooterBand;
    ppReport1ChildReport3HeaderBand1: TppHeaderBand;
    ppReport1ChildReport3Label1: TppLabel;
    ppReport1ChildReport3Line1: TppLine;
    ppReport1ChildReport3Label2: TppLabel;
    ppReport1ChildReport3Label3: TppLabel;
    ppReport1ChildReport3DetailBand1: TppDetailBand;
    ppReport1ChildReport3BarCode1: TppBarCode;
    ppReport1ChildReport3Memo1: TppMemo;
    ppReport1ChildReport3BarCode2: TppBarCode;
    ppReport1ChildReport3BarCode3: TppBarCode;
    ppReport1ChildReport3BarCode4: TppBarCode;
    ppReport1ChildReport3Line2: TppLine;
    ppReport1ChildReport3Line3: TppLine;
    ppReport1ChildReport3Line4: TppLine;
    ppReport1ChildReport3Line5: TppLine;
    ppReport1ChildReport3Line6: TppLine;
    ppReport1ChildReport3FooterBand1: TppFooterBand;
    ppReport1Memo2: TppMemo;
    ppReport1Label4: TppLabel;
    ppReport1Line7: TppLine;
    ppReport1Label5: TppLabel;
    ppReport1Label6: TppLabel;
    ppReport1Memo3: TppMemo;
    ppReport1Label7: TppLabel;
    ppReport1Memo4: TppMemo;
    ppReport1Label8: TppLabel;
    ppReport1Memo5: TppMemo;
    ppReport1Label9: TppLabel;
    ppReport1Memo6: TppMemo;
    ppReport1Label10: TppLabel;
    ppReport1Memo7: TppMemo;
    ppReport1Label11: TppLabel;
    ppReport1Memo8: TppMemo;
    ppReport1Label12: TppLabel;
    ppReport1ChildReport5HeaderBand1: TppHeaderBand;
    ppReport1ChildReport5Label1: TppLabel;
    ppReport1ChildReport5Line1: TppLine;
    ppReport1ChildReport5Label2: TppLabel;
    ppReport1ChildReport5Label3: TppLabel;
    ppReport1ChildReport5DetailBand1: TppDetailBand;
    ppReport1ChildReport5BarCode1: TppBarCode;
    ppReport1ChildReport5Memo1: TppMemo;
    ppReport1ChildReport5BarCode2: TppBarCode;
    ppReport1ChildReport5BarCode3: TppBarCode;
    ppReport1ChildReport5BarCode4: TppBarCode;
    ppReport1ChildReport5Line2: TppLine;
    ppReport1ChildReport5Line3: TppLine;
    ppReport1ChildReport5Line4: TppLine;
    ppReport1ChildReport5Line5: TppLine;
    ppReport1ChildReport5Line6: TppLine;
    ppReport1ChildReport5FooterBand1: TppFooterBand;
    ppReport1ChildReport4HeaderBand1: TppHeaderBand;
    ppReport1ChildReport4Label1: TppLabel;
    ppReport1ChildReport4Line1: TppLine;
    ppReport1ChildReport4Label2: TppLabel;
    ppReport1ChildReport4Label3: TppLabel;
    ppReport1ChildReport4DetailBand1: TppDetailBand;
    ppReport1ChildReport4BarCode1: TppBarCode;
    ppReport1ChildReport4Memo1: TppMemo;
    ppReport1ChildReport4BarCode2: TppBarCode;
    ppReport1ChildReport4BarCode3: TppBarCode;
    ppReport1ChildReport4BarCode4: TppBarCode;
    ppReport1ChildReport4Line2: TppLine;
    ppReport1ChildReport4Line3: TppLine;
    ppReport1ChildReport4Line4: TppLine;
    ppReport1ChildReport4Line5: TppLine;
    ppReport1ChildReport4Line6: TppLine;
    ppReport1ChildReport4FooterBand1: TppFooterBand;
    ppReport1ChildReport6HeaderBand1: TppHeaderBand;
    ppReport1ChildReport6Label1: TppLabel;
    ppReport1ChildReport6Line1: TppLine;
    ppReport1ChildReport6Label2: TppLabel;
    ppReport1ChildReport6Label3: TppLabel;
    ppReport1ChildReport6DetailBand1: TppDetailBand;
    ppReport1ChildReport6BarCode1: TppBarCode;
    ppReport1ChildReport6Memo1: TppMemo;
    ppReport1ChildReport6BarCode2: TppBarCode;
    ppReport1ChildReport6BarCode3: TppBarCode;
    ppReport1ChildReport6BarCode4: TppBarCode;
    ppReport1ChildReport6Line2: TppLine;
    ppReport1ChildReport6Line3: TppLine;
    ppReport1ChildReport6Line4: TppLine;
    ppReport1ChildReport6Line5: TppLine;
    ppReport1ChildReport6Line6: TppLine;
    ppReport1ChildReport6FooterBand1: TppFooterBand;
  private
    { Private declarations }
  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0091: Tfrm0091;

implementation

{$R *.DFM}

function Tfrm0091.GetReport: TppProducer;
begin
  Result := ppReport1;
end;



end.
