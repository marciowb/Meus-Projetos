{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0025;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, dmUtil, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppProd,
  ppGIF, ppRelatv;

type
  Tfrm0025 = class(TdmCustomForm)
    Label2: TLabel;
    Label3: TLabel;
    ppReport1: TppReport;
    ppCustomerListDetail: TppDetailBand;
    ppReport1Label1: TppLabel;
    ppReport1Image1: TppImage;
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }

  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0025: Tfrm0025;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{Tfrm0025.GetReport}

function Tfrm0025.GetReport: TppProducer;
begin
  Result := ppReport1;
end;

{------------------------------------------------------------------------------}
{Tfrm0025.FormCreate}

procedure Tfrm0025.FormCreate(Sender: TObject);
var
  lsPath: String;
begin
  lsPath := ExtractFilePath(ParamStr(0));

  ppReport1Image1.Picture.LoadFromFile(lsPath + 'rbuilder.gif');

end;

end.
