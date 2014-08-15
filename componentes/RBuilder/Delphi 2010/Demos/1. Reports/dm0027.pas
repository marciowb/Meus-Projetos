{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0027;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, dmUtil, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppRichTx,
  ppRegion, ppProd, ppRelatv;

type
  Tfrm0027 = class(TdmCustomForm)
    Label2: TLabel;
    Label3: TLabel;
    ppReport1: TppReport;
    ppCustomerListDetail: TppDetailBand;
    ppReport1RichText1: TppRichText;
    ppReport1Region1: TppRegion;
    ppReport1Label2: TppLabel;
    ppReport1HeaderBand1: TppHeaderBand;
    ppReport1Region2: TppRegion;
    ppReport1RichText2: TppRichText;
    ppReport1Label3: TppLabel;
    ppReport1Region3: TppRegion;
    ppReport1RichText3: TppRichText;
    ppReport1Label4: TppLabel;
    ppReport1Label1: TppLabel;

  private
    { Private declarations }

  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0027: Tfrm0027;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{Tfrm0027.GetReport}

function Tfrm0027.GetReport: TppProducer;
begin
  Result := ppReport1;
end;


end.
