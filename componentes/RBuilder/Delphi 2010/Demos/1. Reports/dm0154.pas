{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0154;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dmUtil, ppClass, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppProd, ppDBPipe,
  ppVar, ppRelatv;

type
  Tfrm0154 = class(TdmCustomForm)
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
    tblBioLife: TTable;
    dsBioLife: TDataSource;
    ppBDEPipeline1: TppBDEPipeline;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ppReport1Calc1: TppSystemVariable;
    ppReport1Calc2: TppSystemVariable;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ppReport1ShapeDrawCommandClick(Sender, aDrawCommand: TObject);
  private
    FColors: TList;
    FColorIndex: Integer;

    procedure InitColorCodes;

  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0154: Tfrm0154;

implementation

uses
  ppDevice;

{$R *.DFM}

function Tfrm0154.GetReport: TppProducer;
begin
  Result := ppReport1;
end;

procedure Tfrm0154.FormCreate(Sender: TObject);
begin
  FColors := TList.Create;

  FColorIndex := 0;

  InitColorCodes;
end;

procedure Tfrm0154.FormDestroy(Sender: TObject);
begin
  FColors.Free;
end;

procedure Tfrm0154.ppReport1ShapeDrawCommandClick(Sender, aDrawCommand: TObject);
var
  lDrawCommand: TppDrawCommand;
begin

  if (FColorIndex < FColors.Count - 1) then
    Inc(FColorIndex)
  else
    FColorIndex := 0;

  {update the color}
  ppReport1Shape1.Brush.Color := TColor(FColors[FColorIndex]);
  ppReport1Shape2.Brush.Color := TColor(FColors[FColorIndex]);
  ppReport1Shape7.Brush.Color := TColor(FColors[FColorIndex]);

  {tell viewer to redraw page}
  lDrawCommand := TppDrawCommand(aDrawCommand);
  lDrawCommand.RedrawPage := True;

end;

procedure Tfrm0154.InitColorCodes;
begin

  FColors.Add(TObject(clYellow));
  FColors.Add(TObject(clAqua));
  FColors.Add(TObject(clFuchsia));
  FColors.Add(TObject(clLime));

end; {procedure, InitColorCodes}



end.
