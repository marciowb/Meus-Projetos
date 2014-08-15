{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0134;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass,  ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppTypes,
  dmUtil, ppTxPipe, ppProd, ppVar, ppRelatv;

type
  Tfrm0134 = class(TdmCustomForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ppReport1: TppReport;
    ppReport1TitleBand1: TppTitleBand;
    ppReport1Label5: TppLabel;
    ppReport1Label10: TppLabel;
    ppReport1Header: TppHeaderBand;
    ppReport1Label1: TppLabel;
    ppReport1Label2: TppLabel;
    ppReport1Detail: TppDetailBand;
    ppReport1DBText2: TppDBText;
    ppReport1DBText8: TppDBText;
    ppReport1DBText3: TppDBText;
    ppReport1DBText4: TppDBText;
    ppReport1DBText5: TppDBText;
    ppReport1DBText6: TppDBText;
    ppReport1Footer: TppFooterBand;
    ppReport1Group1: TppGroup;
    ppReport1GroupHeaderBand1: TppGroupHeaderBand;
    ppReport1Label3: TppLabel;
    ppReport1Label6: TppLabel;
    ppReport1Label7: TppLabel;
    ppReport1Label8: TppLabel;
    ppReport1Label9: TppLabel;
    ppReport1Line1: TppLine;
    ppReport1Label4: TppLabel;
    ppReport1GroupFooterBand1: TppGroupFooterBand;
    Label4: TLabel;
    ppTextPipeline1: TppTextPipeline;
    ppTextPipeline1Field6: TppField;
    ppTextPipeline1Field5: TppField;
    ppTextPipeline1Field4: TppField;
    ppTextPipeline1Field3: TppField;
    ppTextPipeline1Field2: TppField;
    ppTextPipeline1Field1: TppField;
    ppReport1DBCalc2: TppDBCalc;
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
  frm0134: Tfrm0134;

implementation

{$R *.DFM}

procedure Tfrm0134.FormCreate(Sender: TObject);
begin

  {assign the file name (ex. current directory + dm0134.txt)}
  ppTextPipeline1.FileName := ExtractFilePath(ParamStr(0)) + 'dm0134.txt';

end;

function Tfrm0134.GetReport: TppProducer;
begin
  Result := ppReport1;
end;



end.
