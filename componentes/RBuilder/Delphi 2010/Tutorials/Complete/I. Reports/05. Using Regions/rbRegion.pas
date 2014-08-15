{******************************************************************************}
{                                                                              }
{                   ReportBuilder Tutorials                                    }
{                                                                              }
{             Copyright (c) 1996, 2000 Digital Metaphors Corporation           }
{                                                                              }
{******************************************************************************}

unit rbRegion;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ppCtrls, ppStrtch, ppRegion, ppBands, ppClass, ppPrnabl, ppVar, ppCache,
  ppDB, ppProd, ppReport, ppComm, ppRelatv, ppDBPipe, Db, DBTables, ppMemo,
  StdCtrls;

type
  TfrmRegions = class(TForm)
    tblBiolife: TTable;
    dsBiolife: TDataSource;
    plBiolife: TppDBPipeline;
    rbRegions: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppColumnHeaderBand1: TppColumnHeaderBand;
    ppColumnFooterBand1: TppColumnFooterBand;
    ppSystemVariable1: TppSystemVariable;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    rbImage: TppRegion;
    ppDBText1: TppDBText;
    ppDBImage1: TppDBImage;
    rgMemo: TppRegion;
    dbmNotes: TppDBMemo;
    rgFields: TppRegion;
    ppLabel1: TppLabel;
    ppDBText2: TppDBText;
    ppLabel2: TppLabel;
    ppDBText3: TppDBText;
    ppLabel3: TppLabel;
    ppDBText4: TppDBText;
    ppLabel4: TppLabel;
    ppDBText5: TppDBText;
    btnPreview: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ppDetailBand1BeforeGenerate(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
  private
    FColors: TList;
  public
    { Public declarations }
  end;

var
  frmRegions: TfrmRegions;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TfrmRegions.FormCreate }

procedure TfrmRegions.FormCreate(Sender: TObject);
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
  FColors.Add(TObject(clGray));
  FColors.Add(TObject(clGreen));
  FColors.Add(TObject(clOlive));
  FColors.Add(TObject(clGray));
  FColors.Add(TObject(clSilver));
  FColors.Add(TObject(clMaroon));
  FColors.Add(TObject(clSilver));
  FColors.Add(TObject(clAqua));
  FColors.Add(TObject(clRed));
  FColors.Add(TObject(clSilver));
  FColors.Add(TObject(clAqua));
  FColors.Add(TObject(clMaroon));
  FColors.Add(TObject(clGray));
  FColors.Add(TObject(clBlue));
  FColors.Add(TObject(clYellow));
  FColors.Add(TObject(clRed));
  FColors.Add(TObject(clSilver));
  FColors.Add(TObject(clMaroon));
  FColors.Add(TObject(clYellow));
  FColors.Add(TObject(clSilver));
end;

{------------------------------------------------------------------------------}
{ TfrmRegions.FormDestroy }

procedure TfrmRegions.FormDestroy(Sender: TObject);
begin
  FColors.Free;
end;

{------------------------------------------------------------------------------}
{ TfrmRegions.ppDetailBand1BeforeGenerate }

procedure TfrmRegions.ppDetailBand1BeforeGenerate(Sender: TObject);
var
  lColor: TColor;
begin
  if not(rbRegions.DetailBand.OverFlow) then
    begin
      lColor := TColor(FColors[plBiolife.TraversalCount]);

      rgFields.Brush.Color := lColor;
      dbmNotes.Font.Color   := lColor;

    end;

end;

{------------------------------------------------------------------------------}
{ TfrmRegions.btnPreviewClick }

procedure TfrmRegions.btnPreviewClick(Sender: TObject);
begin
  rbRegions.Print;
end;


end.
