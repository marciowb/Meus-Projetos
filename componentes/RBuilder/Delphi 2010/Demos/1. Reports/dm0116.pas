{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0116;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dmUtil, ppClass, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppProd, ExtCtrls,
  ppDBPipe, ppVar, ppRelatv;

type
  Tfrm0116 = class(TdmCustomForm)
    ppReport1: TppReport;
    ppReport1Header: TppHeaderBand;
    ppReport1Shape1: TppShape;
    ppReport1Label1: TppLabel;
    ppReport1Label2: TppLabel;
    ppReport1Label3: TppLabel;
    ppReport1Label4: TppLabel;
    ppReport1Label5: TppLabel;
    ppReport1Label6: TppLabel;
    ppReport1Detail: TppDetailBand;
    ppReport1Shape4: TppShape;
    ppReport1Shape5: TppShape;
    ppReport1Shape6: TppShape;
    ppReport1Shape3: TppShape;
    ppReport1Shape2: TppShape;
    ppReport1DBMemo1: TppDBMemo;
    ppReport1DBText1: TppDBText;
    ppReport1DBImage1: TppDBImage;
    ppReport1DBText2: TppDBText;
    ppReport1DBText3: TppDBText;
    ppReport1Footer: TppFooterBand;
    ppReport1Group1: TppGroup;
    ppReport1GroupHeader1: TppGroupHeaderBand;
    ppReport1GroupFooter1: TppGroupFooterBand;
    ppReport1Shape7: TppShape;
    ppReport1Label7: TppLabel;
    ppReport1DBCalc1: TppDBCalc;
    ppReport1Line1: TppLine;
    Table1: TTable;
    DataSource1: TDataSource;
    ppBDEPipeline1: TppBDEPipeline;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    RadioGroup1: TRadioGroup;
    Button1: TButton;
    ppReport1Calc1: TppSystemVariable;
    ppReport1Calc2: TppSystemVariable;
    procedure ppBDEPipeline1First(Sender: TObject);
    procedure ppBDEPipeline1Last(Sender: TObject);
    procedure ppBDEPipeline1Next(Sender: TObject);
    procedure ppBDEPipeline1Prior(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FSkipping: Boolean;

    procedure SkipBackward;
    procedure SkipForward;

  protected
    function GetReport: TppProducer; override;
    procedure Init; override;
  public
    { Public declarations }
  end;

var
  frm0116: Tfrm0116;

implementation

{$R *.DFM}

procedure Tfrm0116.Init;
begin
  AssignViewer := True;
  DisplayForm := True;
end;

function Tfrm0116.GetReport: TppProducer;
begin
  Result := ppReport1;
end;

procedure Tfrm0116.Button1Click(Sender: TObject);
begin
  {notify report that state of data has changed}
  ppReport1.Reset;

  {print the report}
  ppReport1.PrintToDevices;
end;

procedure Tfrm0116.SkipForward;
begin
  if RadioGroup1.ItemIndex = 0 then Exit;

  if FSkipping then Exit;

  if Table1.EOF then Exit;

  FSkipping := True;

  while not(Table1.EOF) and (Copy(Table1.FieldByName('Category').AsString, 1, 1) = 'S') do
    ppBDEPipeline1.Skip;

  FSkipping := False;
end;

procedure Tfrm0116.SkipBackward;
begin
  if RadioGroup1.ItemIndex = 0 then Exit;

  if FSkipping then Exit;

  if Table1.BOF then Exit;

  FSkipping := True;

  while not(Table1.BOF) and (Copy(Table1.FieldByName('Category').AsString, 1, 1) = 'S') do
    ppBDEPipeline1.SkipBack;

  FSkipping := False;

end;

procedure Tfrm0116.ppBDEPipeline1First(Sender: TObject);
begin
  SkipForward;
end;

procedure Tfrm0116.ppBDEPipeline1Last(Sender: TObject);
begin
  SkipBackward;
end;

procedure Tfrm0116.ppBDEPipeline1Next(Sender: TObject);
begin
  SkipForward;
end;

procedure Tfrm0116.ppBDEPipeline1Prior(Sender: TObject);
begin
  SkipBackward;
end;



end.
