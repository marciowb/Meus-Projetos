{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0042;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dmUtil, ppClass, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppRegion, ppProd,
  ppDBPipe, ppVar, ppRelatv;

type
  Tfrm0042 = class(TdmCustomForm)
    ppReport1: TppReport;
    ppReport1Detail: TppDetailBand;
    tblBioLife: TTable;
    tblBioLifeSpeciesNo: TFloatField;
    tblBioLifeCategory: TStringField;
    tblBioLifeCommon_Name: TStringField;
    tblBioLifeSpeciesName: TStringField;
    tblBioLifeLengthcm: TFloatField;
    tblBioLifeLength_In: TFloatField;
    tblBioLifeNotes: TMemoField;
    tblBioLifeGraphic: TGraphicField;
    dsBioLife: TDataSource;
    ppBDEPipeline1: TppBDEPipeline;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ppReport1HeaderBand1: TppHeaderBand;
    ppReport1FooterBand1: TppFooterBand;
    ppReport1Region3: TppRegion;
    ppReport1Region1: TppRegion;
    ppReport1DBText1: TppDBText;
    ppReport1DBText2: TppDBText;
    ppReport1DBText3: TppDBText;
    ppReport1Label1: TppLabel;
    ppReport1Label3: TppLabel;
    ppReport1Label4: TppLabel;
    ppReport1Label5: TppLabel;
    ppReport1DBText4: TppDBText;
    ppReport1DBImage1: TppDBImage;
    ppReport1DBText5: TppDBText;
    ppReport1Region2: TppRegion;
    ppReport1DBMemo1: TppDBMemo;
    ppReport1ColumnHeaderBand1: TppColumnHeaderBand;
    ppReport1ColumnFooterBand1: TppColumnFooterBand;
    ppReport1Calc2: TppSystemVariable;
    ppReport1Calc1: TppSystemVariable;
    procedure ppReport1DetailBeforePrint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FColors: TList;

  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0042: Tfrm0042;

implementation

{$R *.DFM}

function Tfrm0042.GetReport: TppProducer;
begin
  Result := ppReport1;
end;

procedure Tfrm0042.ppReport1DetailBeforePrint(Sender: TObject);
var
  lColor: TColor;
begin

  lColor := TColor(FColors[ppBDEPipeline1.TraversalCount]);

  ppReport1Region3.Brush.Color := lColor;
  ppReport1DBMemo1.Font.Color := lColor;

end;

procedure Tfrm0042.FormCreate(Sender: TObject);
begin
  FColors := TList.Create;
  FColors.Add(TObject(clYellow));
  FColors.Add(TObject(clRed));
  FColors.Add(TObject(clLime));
  FColors.Add(TObject(clAqua));
  FColors.Add(TObject(clRed));
  FColors.Add(TObject(clSilver));
  FColors.Add(TObject(clYellow));
  FColors.Add(TObject(clRed));
  FColors.Add(TObject(clBlack));
  FColors.Add(TObject(clGreen));
  FColors.Add(TObject(clOlive));
  FColors.Add(TObject(clBlack));
  FColors.Add(TObject(clSilver));
  FColors.Add(TObject(clMaroon));
  FColors.Add(TObject(clSilver));
  FColors.Add(TObject(clAqua));
  FColors.Add(TObject(clRed));
  FColors.Add(TObject(clSilver));
  FColors.Add(TObject(clAqua));
  FColors.Add(TObject(clMaroon));
  FColors.Add(TObject(clBlack));
  FColors.Add(TObject(clBlue));
  FColors.Add(TObject(clYellow));
  FColors.Add(TObject(clRed));
  FColors.Add(TObject(clSilver));
  FColors.Add(TObject(clMaroon));
  FColors.Add(TObject(clYellow));
  FColors.Add(TObject(clSilver));
end;

procedure Tfrm0042.FormDestroy(Sender: TObject);
begin
  FColors.Free;
end;

end.
