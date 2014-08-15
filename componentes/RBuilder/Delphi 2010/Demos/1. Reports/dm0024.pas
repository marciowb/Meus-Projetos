{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0024;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, dmUtil, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppProd, jpeg,
  ppRelatv;

type
  Tfrm0024 = class(TdmCustomForm)
    Label2: TLabel;
    Label3: TLabel;
    ppReport1: TppReport;
    ppCustomerListDetail: TppDetailBand;
    ppReport1Label1: TppLabel;
    ppReport1Image1: TppImage;

  private
    { Private declarations }

  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0024: Tfrm0024;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{Tfrm0024.GetReport}

function Tfrm0024.GetReport: TppProducer;
begin
  Result := ppReport1;
end;


end.
