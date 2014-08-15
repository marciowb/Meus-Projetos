{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0131;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass,  ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppTypes,
  dmUtil, ppTxPipe, ppProd, ppVar, ppRelatv;

type
  Tfrm0131 = class(TdmCustomForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ppReport1: TppReport;
    ppReport1Header: TppHeaderBand;
    ppReport1Label1: TppLabel;
    ppReport1Label2: TppLabel;
    ppReport1Label3: TppLabel;
    ppReport1Label4: TppLabel;
    ppReport1Label6: TppLabel;
    ppReport1Label7: TppLabel;
    ppReport1Label8: TppLabel;
    ppReport1Label9: TppLabel;
    ppReport1Detail: TppDetailBand;
    ppReport1DBText2: TppDBText;
    ppReport1DBText8: TppDBText;
    ppReport1DBText3: TppDBText;
    ppReport1DBText4: TppDBText;
    ppReport1DBText5: TppDBText;
    ppReport1DBText6: TppDBText;
    ppReport1Footer: TppFooterBand;
    ppReport1Line1: TppLine;
    ppReport1DBCalc1: TppDBCalc;
    ppReport1TitleBand1: TppTitleBand;
    ppReport1Label5: TppLabel;
    ppReport1Label10: TppLabel;
    ppTextPipeline1: TppTextPipeline;
    Label4: TLabel;
    ppTextPipeline1Field1: TppField;
    ppTextPipeline1Field2: TppField;
    ppTextPipeline1Field3: TppField;
    ppTextPipeline1Field4: TppField;
    ppTextPipeline1Field5: TppField;
    ppTextPipeline1Field6: TppField;
    ppReport1Calc1: TppSystemVariable;
    ppReport1Calc3: TppSystemVariable;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0131: Tfrm0131;

implementation

{$R *.DFM}

procedure Tfrm0131.FormCreate(Sender: TObject);
var
  lsDirPath: String;
begin

  {get the application directory }
  lsDirPath := ExtractFilePath(ParamStr(0));
  
  {assign the file name (ex. dm0131.txt)}
  ppTextPipeline1.FileName := lsDirPath + 'dm0131.txt';

end;

function Tfrm0131.GetReport: TppProducer;
begin
  Result := ppReport1;
end;




end.
