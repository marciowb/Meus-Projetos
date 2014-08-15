{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0135;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass,  ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppTypes,
  dmUtil, ppTxPipe, ppProd, ppVar, ppRelatv;

type
  Tfrm0135 = class(TdmCustomForm)
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
    ppReport1DBCalc1: TppDBCalc;
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
    ppReport1Calc1: TppSystemVariable;
    ppReport1Calc3: TppSystemVariable;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

    procedure CreateDataFile(aFileName: String);
    function CreateRecord(aRecordNo: Integer): String;

  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0135: Tfrm0135;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ Tfrm0135.FormCreate }

procedure Tfrm0135.FormCreate(Sender: TObject);
var
  lsFileName: String;
begin

  {assign the file name (ex. current directory + dm0135.txt)}
  lsFileName := ExtractFilePath(ParamStr(0)) + 'dm0135.txt';

  {create the data and save it to the file}
  CreateDataFile(lsFileName);

  {assign the file name }
  ppTextPipeline1.FileName := lsFileName;

  {define the field's in order: FieldName, DataType, FieldLength (i.e. max length) }
  ppTextPipeline1.DefineField('Company',    dtString,   30);
  ppTextPipeline1.DefineField('Contact',    dtString,   20);
  ppTextPipeline1.DefineField('Phone',      dtString,   15);
  ppTextPipeline1.DefineField('Addr1',      dtString,   30);
  ppTextPipeline1.DefineField('City',       dtString,   15);
  ppTextPipeline1.DefineField('State',      dtString,   20);


end;

{------------------------------------------------------------------------------}
{ Tfrm0135.CreateDataFile }

procedure Tfrm0135.CreateDataFile(aFileName: String);
var
  lStringList: TStringList;
  liRecord: Integer;
  lsRecord: String;

begin

  lStringList := TStringList.Create;

  for liRecord := 1 to 500 do
    begin
      lsRecord := CreateRecord(liRecord);

      lStringList.Add(lsRecord);
    end;

  {save the data to a text file}
  lStringList.SaveToFile(aFileName);

  lStringList.Free;

end;

{------------------------------------------------------------------------------}
{ Tfrm0135.CreateRecord }

function Tfrm0135.CreateRecord(aRecordNo: Integer): String;
var
  lcDelimiter: Char;
  lsRecordNo: String;

begin

  lcDelimiter := ','; {comma delimiter }
  lsRecordNo  := IntToStr(aRecordNo);

  Result := ('Company-' +  lsRecordNo + lcDelimiter +
             'Contact-' +  lsRecordNo + lcDelimiter +
             'Phone-'   +  lsRecordNo + lcDelimiter +
             'Addr1-'   +  lsRecordNo + lcDelimiter +
             'City-'    +  lsRecordNo + lcDelimiter +
             'State-'   +  lsRecordNo );

end;

{------------------------------------------------------------------------------}
{ Tfrm0135.GetReport }

function Tfrm0135.GetReport: TppProducer;
begin
  Result := ppReport1;
end;



end.
