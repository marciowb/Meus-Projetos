{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0029;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, dmUtil, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppRichTx,
  ppRegion, ppProd, ppDBPipe, ppRelatv;

type
  Tfrm0029 = class(TdmCustomForm)
    tblBiolife: TTable;
    dsBiolife: TDataSource;
    plBioLife: TppBDEPipeline;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ppReport1: TppReport;
    ppReport1HeaderBand1: TppHeaderBand;
    ppReport1DetailBand1: TppDetailBand;
    ppReport1FooterBand1: TppFooterBand;
    ppReport1ColumnHeaderBand1: TppColumnHeaderBand;
    ppReport1ColumnFooterBand1: TppColumnFooterBand;
    ppRichText1: TppRichText;
    ppReport1DBImage1: TppDBImage;
    ppReport1Region1: TppRegion;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ppRichText1Print(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FDefaultFont: TFont;
    FTitleFont: TFont;

  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0029: Tfrm0029;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{Tfrm0029.FormCreate}

procedure Tfrm0029.FormCreate(Sender: TObject);
begin

  FDefaultFont := TFont.Create;
  FDefaultFont.Name := 'Times New Roman';
  FDefaultFont.Size := 12;

  FTitleFont := TFont.Create;
  FTitleFont.Name  := 'Arial';
  FTitleFont.Size  := 14;
  FTitleFont.Color := clRed;
  FTitleFont.Style := [fsItalic, fsBold];


end;

{------------------------------------------------------------------------------}
{Tfrm0029.FormDestroy}

procedure Tfrm0029.FormDestroy(Sender: TObject);
begin
  FDefaultFont.Free;
  FTitleFont.Free;

end;

{------------------------------------------------------------------------------}
{Tfrm0029.GetReport}

function Tfrm0029.GetReport: TppProducer;
begin
  Result := ppReport1;
end;


{------------------------------------------------------------------------------}
{Tfrm0029.ppRichText1Print}

procedure Tfrm0029.ppRichText1Print(Sender: TObject);
var
  liSelStart: Integer;
  liSelEnd: Integer;
  liSelLength: Integer;
  liSpace: Integer;
  liFish: Integer;
begin


  {assign the text from the memo to the ppRichText component}
  ppRichText1.RichText := tblBioLife.FieldByName('Common_Name').AsString + #13 + #13 +
                          tblBioLife.FieldByName('Notes').AsString;

  {assign default font to all text }
  ppRichText1.SelectAll;
  ppRichText1.SelAttributes.Assign(FDefaultFont);

  {assign title font to the fish name }
  liSelLength := Length(tblBioLife.FieldByName('Common_Name').AsString);

  ppRichText1.SelStart  := 0;
  ppRichText1.SelLength := liSelLength;
  ppRichText1.SelAttributes.Assign(FTitleFont);


  { italize the the first word in the paragraph

     note: FindText(const SearchStr: string; StartPos, Length: Integer; Options: TSearchTypes):Integer; }

  liSpace := ppRichText1.FindText(' ', liSelLength+4, 30,[]);
  ppRichText1.SelStart  := liSelLength+2;
  ppRichText1.SelLength := liSpace - ppRichText1.SelStart;
  ppRichText1.SelAttributes.Size  := 14;
  ppRichText1.SelAttributes.Style := [fsBold, fsItalic];


  {make the first letter in the paragraph size 16 and bold italic}
  ppRichText1.SelStart  := liSelLength+2;
  ppRichText1.SelLength := 1;
  ppRichText1.SelAttributes.Size := 16;
  ppRichText1.SelAttributes.Style := [fsBold, fsItalic];

  
  {underline all occurances of the word 'fish' in blue}
  ppRichText1.SelectAll;
  liSelEnd   := ppRichText1.SelLength;
  liSelStart := liSelLength+4;

  while liSelStart <  liSelEnd do
    begin
      liFish := ppRichText1.FindText('fish', liSelStart, liSelEnd,[]);

      if liFish < 0 then Break;

      {color the text blue}
      ppRichText1.SelStart  := liFish;
      ppRichText1.SelLength := liFish + 4;
      ppRichText1.SelAttributes.Color := clBlue;
      ppRichText1.SelAttributes.Style := [fsUnderLine];

      {re-assign the defaul font attributes to the remaining text}
      ppRichText1.SelStart  := liFish + 5;
      ppRichText1.SelLength := liSelEnd;
      ppRichText1.SelAttributes.Assign(FDefaultFont);

      liSelStart :=  ppRichText1.SelStart + 5;
      
    end;

end;



procedure Tfrm0029.Button1Click(Sender: TObject);
begin
  ppReport1.Print;
end;

end.
