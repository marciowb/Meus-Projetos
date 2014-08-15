{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0022;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, dmUtil, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppProd, ppDBPipe,
  ppVar, ppRelatv;

type
  Tfrm0022 = class(TdmCustomForm)
    tblBiolife: TTable;
    dsBiolife: TDataSource;
    plBiolife: TppBDEPipeline;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ppReport1: TppReport;
    ppCustomerListHeader: TppHeaderBand;
    ppCustomerListLabel1: TppLabel;
    ppCustomerListLabel2: TppLabel;
    ppCustomerListDetail: TppDetailBand;
    ppCustomerListFooter: TppFooterBand;
    ppDBImage1: TppDBImage;
    ppReport1Label1: TppLabel;
    ppReport1Label2: TppLabel;
    ppReport1DBImage3: TppDBImage;
    ppReport1Label3: TppLabel;
    ppReport1DBImage2: TppDBImage;
    ppReport1DBImage4: TppDBImage;
    ppReport1Label4: TppLabel;
    ppReport1Shape1: TppShape;
    ppReport1Shape2: TppShape;
    ppReport1Shape3: TppShape;
    ppReport1Shape4: TppShape;
    ppReport1Label5: TppLabel;
    ppReport1Label6: TppLabel;
    ppReport1Line1: TppLine;
    ppReport1Line2: TppLine;
    ppReport1TitleBand1: TppTitleBand;
    ppReport1Label9: TppLabel;
    ppCustomerListCalc1: TppSystemVariable;
    ppCustomerListCalc3: TppSystemVariable;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ppDBImage1Print(Sender: TObject);
    procedure ppReport1EndFirstPass(Sender: TObject);

  private
    { Private declarations }
    FImageList: TList;

    procedure AddImageToList(aBitmap: TBitmap);
    procedure FreeImages;

  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0022: Tfrm0022;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{Tfrm0022.GetReport}

function Tfrm0022.GetReport: TppProducer;
begin
  Result := ppReport1;
end;

{------------------------------------------------------------------------------}
{Tfrm0022.FormCreate}

procedure Tfrm0022.FormCreate(Sender: TObject);
begin
  FImageList := TList.Create;
end;

{------------------------------------------------------------------------------}
{Tfrm0022.FormDestroy}

procedure Tfrm0022.FormDestroy(Sender: TObject);
begin
  FreeImages;
  FImageList.Free;
end;

{------------------------------------------------------------------------------}
{Tfrm0022.FreeImages}

procedure Tfrm0022.FreeImages;
var
  liImage: Integer;

begin

  for liImage := FImageList.Count-1 downto 0 do
    TObject(FImageList[liImage]).Free;

end;


{------------------------------------------------------------------------------}
{Tfrm0022.ppDBImage1Print}

procedure Tfrm0022.ppDBImage1Print(Sender: TObject);
begin


  {during first pass OnPrint will be called once for each record,
    note: could also use TppBDEPipeline.OnTraversal event but then
          you must get the data from the TTable object not ppDBImage}
  if ppReport1.FirstPass then
    AddImageToList(ppDBImage1.Picture.Bitmap);
end;


{------------------------------------------------------------------------------}
{Tfrm0022.AddImageToList}

procedure Tfrm0022.AddImageToList(aBitmap: TBitmap);
var
  lBitmap: TBitmap;

begin

  {create a bitmap and copy the image}
  lBitmap := TBitmap.Create;
  lBitmap.Width  := aBitmap.Width;
  lBitmap.Height := aBitmap.Height;
  lBitmap.Canvas.Draw(0,0, aBitmap); 

  {add the bitmap to the list}
  FImageList.Add(lBitmap);

end;


{------------------------------------------------------------------------------}
{Tfrm0022.ppReport1EndFirstPass}

procedure Tfrm0022.ppReport1EndFirstPass(Sender: TObject);
var
  liImage: Integer;
  lfLeft, lfTop,
  lfWidth, lfHeight: Single;
  lfPrintableWidth : Single;
  lppImage: TppImage;
  liCount: Integer;
  liImagesPerRow: Integer;
  lppLabel: TppLabel;

begin

  lfPrintableWidth := ppReport1.PrinterSetup.PrintableWidth;
  liImagesPerRow   := 1;

  lfTop      := 1.0;
  lfWidth    := 0.75;
  lfHeight   := 0.50;
  lfLeft     := (lfPrintableWidth - (liImagesPerRow * lfWidth)) / 2;
  liCount    := 0;


  for liImage := 0 to FImageList.Count-1 do
    begin
      {create a TppImage component}
      lppImage := TppImage.Create(Self);

      {add the image component to the title band}
      lppImage.Band :=  ppReport1TitleBand1;

      {set the dimensions}
      lppImage.SetBounds(lfLeft, lfTop, lfWidth, lfHeight);

      {assign the bitmap from the list to the image}
      lppImage.Picture.Bitmap.Assign(TBitmap(FImageList[liImage]));
      lppImage.Stretch := True;

      Inc(liCount);

      lfLeft := lfLeft + lfWidth + 0.10;

      if (liCount >= liImagesPerRow) then
        begin
          Inc(liImagesPerRow);
          lfLeft  := (lfPrintableWidth -(liImagesPerRow * (lfWidth + 0.10)))/2;
          liCount := 0;
          lfTop   := lfTop + lfHeight + 0.10;
        end;

    end;

   {create a label and position it at the bottom of the pyramid}
   lppLabel      := TppLabel.Create(Self);
   lppLabel.Band := ppReport1TitleBand1;

   {assign font props and alignment}
   lppLabel.Font.Name  := 'Times New Roman';
   lppLabel.Font.Size  := 36;
   lppLabel.Font.Style := [fsBold, fsItalic];
   lppLabel.Alignment := taCenter;

   lppLabel.Caption := 'Pyramid O''Fish';
   lppLabel.Width   := 5;
   lppLabel.Top     :=  lfTop + lfHeight + 0.10;
   lppLabel.Left    := (lfPrintableWidth - lppLabel.Width)/2;


   ppReport1TitleBand1.Init;


end;


end.
