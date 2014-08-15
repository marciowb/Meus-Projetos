{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppMetaRW;

interface

{$I ppIfDef.pas}

uses
  Classes, Graphics, SysUtils, ppMetaBitmap;

type

  {@TppGroupsPageBitmap }
  TppGroupsPageBitmap = class(TppMetaBitmap)
    protected
      procedure Draw(aCanvas: TCanvas); override;
    public
      constructor Create; override;
  end; {class, TppGroupsPageBitmap}

  {@TppPageCornerBitmap }
  TppPageCornerBitmap = class(TppMetaBitmap)
    protected
      procedure Draw(aCanvas: TCanvas); override;
    public
      constructor Create; override;
  end; {class, TppPageCornerBitmap}

  {@TppLayoutBitmap }
  TppLayoutBitmap = class(TppPageCornerBitmap)
    protected
      procedure Draw(aCanvas: TCanvas); override;
  end; {class, TppLayoutBitmap}

  {@TppAlignLeftLayoutBitmap }
  TppAlignLeftLayoutBitmap = class(TppLayoutBitmap)
    protected
      procedure Draw(aCanvas: TCanvas); override;
  end; {class, TppAlignLeftLayoutBitmap}

  {@TppAlignLeft1LayoutBitmap }
  TppAlignLeft1LayoutBitmap = class(TppAlignLeftLayoutBitmap)
    protected
      procedure Draw(aCanvas: TCanvas); override;
  end; {class, TppAlignLeft1LayoutBitmap}

  {@TppAlignLeft2LayoutBitmap }
  TppAlignLeft2LayoutBitmap = class(TppAlignLeftLayoutBitmap)
    protected
      procedure Draw(aCanvas: TCanvas); override;
  end; {class, TppAlignLeft2LayoutBitmap}

  {@TppStandardLayoutBitmap }
  TppStandardLayoutBitmap = class(TppLayoutBitmap)
    protected
      procedure Draw(aCanvas: TCanvas); override;
  end; {class, TppStandardLayoutBitmap}

  {@TppSteppedLayoutBitmap }
  TppSteppedLayoutBitmap = class(TppStandardLayoutBitmap)
    protected
      procedure Draw(aCanvas: TCanvas); override;
  end; {class, TppSteppedLayoutBitmap}

  {@TppBlockLayoutBitmap }
  TppBlockLayoutBitmap = class(TppStandardLayoutBitmap)
    protected
      procedure Draw(aCanvas: TCanvas); override;
  end; {class, TppBlockLayoutBitmap}

  {@TppOutlineLayoutBitmap }
  TppOutlineLayoutBitmap = class(TppLayoutBitmap)
    protected
      procedure Draw(aCanvas: TCanvas); override;
  end; {class, TppOutlineLayoutBitmap}

  {@TppOutline1LayoutBitmap }
  TppOutline1LayoutBitmap = class(TppOutlineLayoutBitmap)
    protected
      procedure Draw(aCanvas: TCanvas); override;
  end; {class, TppOutline1LayoutBitmap}

  {@TppOutline2LayoutBitmap }
  TppOutline2LayoutBitmap = class(TppOutlineLayoutBitmap)
    protected
      procedure Draw(aCanvas: TCanvas); override;
  end; {class, TppOutline2LayoutBitmap}

  {@TppTabularLayoutBitmap }
  TppTabularLayoutBitmap = class(TppLayoutBitmap)
    protected
      procedure Draw(aCanvas: TCanvas); override;
  end; {class, TppTabularLayoutBitmap}

  {@TppVerticalLayoutBitmap }
  TppVerticalLayoutBitmap = class(TppLayoutBitmap)
    protected
      procedure Draw(aCanvas: TCanvas); override;
  end; {class, TppVerticalLayoutBitmap}

  {@TppStyleBitmap }
  TppStyleBitmap = class(TppPageCornerBitmap)
    private
      FTitleFont: TFont;
      FSubTitleFont: TFont;
      FDataFont: TFont;
      FTitleAccent: Boolean;
      FTitleAccentColor: TColor;
      FTitleAccentThickness: Integer;
      FTitleTextBackGround: TColor;

    protected
      procedure Draw(aCanvas: TCanvas); override;
    public
      constructor Create; override;
      destructor Destroy; override;
  end; {class, TppStyleBitmap}

  {@TppBoldStyleBitmap }
  TppBoldStyleBitmap = class(TppStyleBitmap)
    public
      constructor Create; override;
  end; {class, TppBoldStyleBitmap}

  {@TppCasualStyleBitmap }
  TppCasualStyleBitmap = class(TppStyleBitmap)
    public
      constructor Create; override;
  end; {class, TppCasualStyleBitmap}

  {@TppCompactStyleBitmap }
  TppCompactStyleBitmap = class(TppStyleBitmap)
    public
      constructor Create; override;
  end; {class, TppCompactStyleBitmap}

  {@TppCorporateStyleBitmap }
  TppCorporateStyleBitmap = class(TppStyleBitmap)
    public
      constructor Create; override;
  end; {class, TppCorporateStyleBitmap}

  {@TppFormalStyleBitmap }
  TppFormalStyleBitmap = class(TppStyleBitmap)
    public
      constructor Create; override;
  end; {class, TppFormalStyleBitmap}

  {@TppSoftGrayStyleBitmap }
  TppSoftGrayStyleBitmap = class(TppStyleBitmap)
    public
      constructor Create; override;
  end; {class, TppSoftGrayStyleBitmap}

  {@TppWizardFieldsBitmap }
  TppWizardFieldsBitmap = class(TppWizardBitmap)
    protected
      procedure Draw(aCanvas: TCanvas); override;
    public
      constructor Create; override;
  end; {class, TppWizardFieldsBitmap}

  {@TppOrientationBitmap }
  TppOrientationBitmap = class(TppMetaBitmap)
    protected
      procedure DrawLetterA(aCanvas: TCanvas; aX, aY: Integer);
  end; {class, TppOrientationBitmap}

  {@TppPortraitBitmap }
  TppPortraitBitmap = class(TppOrientationBitmap)
    protected
      procedure Draw(aCanvas: TCanvas); override;
    public
      constructor Create; override;
  end; {class, TppPortraitBitmap}

  {@TppLandscapeBitmap }
  TppLandscapeBitmap = class(TppOrientationBitmap)
    protected
      procedure Draw(aCanvas: TCanvas); override;
    public
      constructor Create; override;
  end; {class, TppLandscapeBitmap}


implementation

{------------------------------------------------------------------------------}
{ TppPageCornerBitmap.Create }

constructor TppPageCornerBitmap.Create;
begin
  inherited Create;

  BackgroundColor := clBtnShadow;
  Height := 201;
  Width := 225;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppPageCornerBitmap.Draw }

procedure TppPageCornerBitmap.Draw(aCanvas: TCanvas);
begin

  {border lines}
  ppLine(aCanvas, 0, 0, 0, 225, clBlack);
  ppLine(aCanvas, 0, 0, 201, 0, clBlack);

  {draw page}
  ppFillRect(aCanvas, 40, 15, 224, 201, clWhite);

end; {procedure, Draw}

{------------------------------------------------------------------------------}
{ TppStyleBitmap.Create }

constructor TppStyleBitmap.Create;
begin
  inherited Create;

  FTitleAccent := True;
  FTitleAccentColor := clBlack;
  FTitleAccentThickness := 3;

  FTitleFont := TFont.Create;
  FSubTitleFont := TFont.Create;
  FDataFont := TFont.Create;

  FTitleTextBackGround := clWhite;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppStyleBitmap.Destroy }

destructor TppStyleBitmap.Destroy;
begin

  FTitleFont.Free;
  FSubTitleFont.Free;
  FDataFont.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppStyleBitmap.Draw }

procedure TppStyleBitmap.Draw(aCanvas: TCanvas);
var
  lFont: TFont;
begin

  inherited Draw(aCanvas);

  {page accents}
  ppFillRect(aCanvas, 48, 25, 132, 26, clBlack);
  ppFillRect(aCanvas, 133, 25, 196, 26, clSilver);

  ppFillRect(aCanvas, 50, 49, 132, 49, clBlack);
  ppFillRect(aCanvas, 133, 49, 198, 49, clSilver);

  ppFillRect(aCanvas, 50, 59, 132, 59, clBlack);
  ppFillRect(aCanvas, 133, 59, 198, 59, clSilver);

  {set background color for fonts}
  aCanvas.Brush.Color := clWhite;

  {report title}
  lFont := TFont.Create;
  lFont.Name := 'SMALL FONTS';
  lFont.Color := FTitleFont.Color;
  lFont.Size := 7;
  lFont.Style := [fsBold];
  aCanvas.Font := lFont;

  ppTextOut(aCanvas, 49, 29, 'Customers');

  lFont.Free;

  {report title}
  lFont := TFont.Create;
  lFont.Name := 'SMALL FONTS';
  lFont.Color := FSubTitleFont.Color;
  lFont.Size := 5;
  lFont.Style := [fsBold];
  aCanvas.Font := lFont;

  ppTextOut(aCanvas, 50, 52, 'COMPANY');
  ppTextOut(aCanvas, 97, 52, 'REGION');

  lFont.Free;

  lFont := TFont.Create;
  lFont.Name := 'SMALL FONTS';
  lFont.Color := clSilver;
  lFont.Size := 5;
  lFont.Style := [fsBold];
  aCanvas.Font := lFont;

  ppTextOut(aCanvas, 138, 52, 'CITY');
  ppTextOut(aCanvas, 173, 52, 'STATE');

  lFont.Free;

  lFont := TFont.Create;
  lFont.Name := 'SMALL FONTS';
  lFont.Color := clBlack;
  lFont.Size := 5;
  lFont.Style := [];
  aCanvas.Font := lFont;

  ppTextOut(aCanvas, 52, 64, 'Action Club');
  ppTextOut(aCanvas, 97, 64, 'Southeast');

  lFont.Free;

  lFont := TFont.Create;
  lFont.Name := 'SMALL FONTS';
  lFont.Color := clSilver;
  lFont.Size := 5;
  lFont.Style := [];
  aCanvas.Font := lFont;

  ppTextOut(aCanvas, 52, 75, 'Action Club');
  ppTextOut(aCanvas, 97, 75, 'Southeast');

  ppTextOut(aCanvas, 139, 64, 'Sarasota');
  ppTextOut(aCanvas, 139, 75, 'Tampa');

  ppTextOut(aCanvas, 175, 64, 'FL');
  ppTextOut(aCanvas, 175, 75, 'FL');
  ppTextOut(aCanvas, 175, 86, 'CA');
  ppTextOut(aCanvas, 175, 97, 'AZ');
  ppTextOut(aCanvas, 175, 108, 'TX');
  ppTextOut(aCanvas, 175, 119, 'GA');
  ppTextOut(aCanvas, 175, 130, 'TX');
  ppTextOut(aCanvas, 175, 141, 'NC');
  ppTextOut(aCanvas, 175, 152, 'FL');
  ppTextOut(aCanvas, 175, 163, 'SC');
  ppTextOut(aCanvas, 175, 174, 'VA');

  lFont.Free;

  {zoom box}
  {zoom shadow}
  ppFillRect(aCanvas, 14, 91, 159, 192, clBlack);

  {zoom border}
  ppFrameRect(aCanvas, 9, 85, 156, 189, clBlack);
  ppFillRect(aCanvas, 10, 86, 155, 188, clWhite);

  {zoom top accent}
  if FTitleAccent then
    if (FTitleAccentThickness > 0) then
      ppFillRect(aCanvas, 12, 89, 153, 89 + FTitleAccentThickness, FTitleAccentColor)
    else
      ppFillRect(aCanvas, 12, 92, 153, 92, FTitleAccentColor);


  {zoom area}
  aCanvas.Brush.Color := clWhite;

  aCanvas.Pen.Style := psDot;
  aCanvas.Pen.Color := clSilver;

  aCanvas.PolyLine([Point(43, 22), Point(132, 22), Point(132, 73), Point(43, 73), Point(43, 22)]);

  aCanvas.Pen.Style := psSolid;

  {zoom lines}
  ppLine(aCanvas, 43, 22, 10, 86, clSilver);
  ppLine(aCanvas, 133, 22, 156, 85, clSilver);
  ppLine(aCanvas, 43, 74, 41, 85, clSilver);
  ppLine(aCanvas, 133, 73, 136, 85, clSilver);

  {zoom text}
  if (FTitleTextBackGround <> clWhite) then
    ppFillRect(aCanvas, 12, 92, 152, 133, FTitleTextBackGround);

  aCanvas.Font := FTitleFont;
  aCanvas.Brush.Color := FTitleTextBackGround;

  ppTextOut(aCanvas, 15, 100, 'Customers');

  {set background color for fonts}
  aCanvas.Brush.Color := clWhite;

  aCanvas.Font := FSubTitleFont;
  ppTextOut(aCanvas, 18, 148, 'Company');

  aCanvas.Font := FDataFont;
  ppTextOut(aCanvas, 19, 170, 'Action Club');

end; {procedure, Draw}

{------------------------------------------------------------------------------}
{ TppBoldStyleBitmap.Create }

constructor TppBoldStyleBitmap.Create;
begin
  inherited Create;

  FTitleFont.Name := 'TIMES NEW ROMAN';
  FTitleFont.Size := 19;
  FTitleFont.Style := [fsBold];
  FTitleFont.Color := clMaroon;

  FSubTitleFont.Name := 'ARIAL';
  FSubTitleFont.Size := 10;
  FSubTitleFont.Style := [fsBold];
  FSubTitleFont.Color := clMaroon;

  FDataFont.Name := 'TIMES NEW ROMAN';
  FDataFont.Size := 9;
  FDataFont.Style := [];
  FDataFont.Color := clBlack;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCasualStyleBitmap.Create }

constructor TppCasualStyleBitmap.Create;
begin
  inherited Create;

  FTitleAccentColor := clTeal;

  FTitleFont.Name := 'ARIAL';
  FTitleFont.Size := 19;
  FTitleFont.Style := [fsBold];
  FTitleFont.Color := clTeal;

  FSubTitleFont.Name := 'ARIAL';
  FSubTitleFont.Size := 10;
  FSubTitleFont.Style := [fsBold];
  FSubTitleFont.Color := clBlack;

  FDataFont.Name := 'ARIAL';
  FDataFont.Size := 10;
  FDataFont.Style := [];
  FDataFont.Color := clBlack;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCompactStyleBitmap.Create }

constructor TppCompactStyleBitmap.Create;
begin
  inherited Create;

  FTitleAccentThickness := 0;

  FTitleFont.Name := 'HAETTENSCHWEILER';
  FTitleFont.Size := 28;
  FTitleFont.Style := [];
  FTitleFont.Color := clBlack;

  FSubTitleFont.Name := 'HAETTENSCHWEILER';
  FSubTitleFont.Size := 14;
  FSubTitleFont.Style := [];
  FSubTitleFont.Color := clBlack;

  FDataFont.Name := 'ARIAL';
  FDataFont.Size := 8;
  FDataFont.Style := [];
  FDataFont.Color := clBlack;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCorporateStyleBitmap.Create }

constructor TppCorporateStyleBitmap.Create;
begin
  inherited Create;

  FTitleAccentColor := clSilver;

  FTitleFont.Name := 'TIMES NEW ROMAN';
  FTitleFont.Size := 20;
  FTitleFont.Style := [fsBold, fsItalic];
  FTitleFont.Color := clNavy;

  FSubTitleFont.Name := 'TIMES NEW ROMAN';
  FSubTitleFont.Size := 11;
  FSubTitleFont.Style := [fsBold, fsItalic];
  FSubTitleFont.Color := clNavy;

  FDataFont.Name := 'ARIAL';
  FDataFont.Size := 8;
  FDataFont.Style := [];
  FDataFont.Color := clBlack;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppFormalStyleBitmap.Create }

constructor TppFormalStyleBitmap.Create;
begin
  inherited Create;

  FTitleAccentThickness := 0;

  FTitleFont.Name := 'TIMES NEW ROMAN';
  FTitleFont.Size := 24;
  FTitleFont.Style := [];
  FTitleFont.Color := clBlack;

  FSubTitleFont.Name := 'TIMES NEW ROMAN';
  FSubTitleFont.Size := 10;
  FSubTitleFont.Style := [fsBold];
  FSubTitleFont.Color := clBlack;

  FDataFont.Name := 'TIMES NEW ROMAN';
  FDataFont.Size := 8;
  FDataFont.Style := [];
  FDataFont.Color := clBlack;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppSoftGrayStyleBitmap.Create }

constructor TppSoftGrayStyleBitmap.Create;
begin
  inherited Create;

  FTitleAccent := False;
  FTitleTextBackGround := clSilver;
  
  FTitleFont.Name := 'ARIAL';
  FTitleFont.Size := 19;
  FTitleFont.Style := [fsBold];
  FTitleFont.Color := clWhite;

  FSubTitleFont.Name := 'ARIAL';
  FSubTitleFont.Size := 9;
  FSubTitleFont.Style := [fsBold];
  FSubTitleFont.Color := clBlack;

  FDataFont.Name := 'TIMES NEW ROMAN';
  FDataFont.Size := 11;
  FDataFont.Style := [];
  FDataFont.Color := clBlack;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppGroupsPageBitmap.Create }

constructor TppGroupsPageBitmap.Create;
begin

  inherited Create;

  Height := 265;
  Width := 239;

  BackgroundColor := clBtnShadow;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppGroupsPageBitmap.Draw }

procedure TppGroupsPageBitmap.Draw(aCanvas: TCanvas);
begin

  {border}
  ppLine(aCanvas, 1, 1, 239, 1, clBlack);
  ppLine(aCanvas, 1, 1, 1, 265, clBlack);

  ppLine(aCanvas, 2, 265, 239, 265, clSilver);
  ppLine(aCanvas, 265, 239, 265, 2, clSilver);

  {page shadow}
  ppFillRect(aCanvas, 18, 21, 232, 262, clBlack);

  {page}
  ppFillRect(aCanvas, 12, 8, 228, 258, clWhite);
  ppFrameRect(aCanvas, 11, 7, 229, 259, clBlack);

  {fold over corner}
  ppLine(aCanvas, 217, 6, 229, 18, clBlack);
  ppLine(aCanvas, 217, 6, 217, 18, clBlack);
  ppLine(aCanvas, 217, 18, 229, 18, clBlack);

  ppFillRect(aCanvas, 219, 19, 228, 20, clSilver);
  ppLine(aCanvas, 218, 19, 218, 19, clSilver);

  aCanvas.Brush.Color := clGray;
  aCanvas.Pen.Color := clGray;

  aCanvas.Polygon([Point(219,7), Point(229,17), Point(229,7), Point(219,7)]);

end; {procedure, Draw}

{------------------------------------------------------------------------------}
{ TppLayoutBitmap.Draw }

procedure TppLayoutBitmap.Draw(aCanvas: TCanvas);
begin

  inherited Draw(aCanvas);

  {set background color for fonts}
  aCanvas.Brush.Color := clWhite;

  {report title}
  aCanvas.Font.Name := 'SMALL FONTS';
  aCanvas.Font.Color := clSilver;
  aCanvas.Font.Size := 7;
  aCanvas.Font.Style := [fsBold];

  ppTextOut(aCanvas, 49, 27, 'Customers');

end; {procedure, Draw}

{------------------------------------------------------------------------------}
{ TppAlignLeftLayoutBitmap.Draw }

procedure TppAlignLeftLayoutBitmap.Draw(aCanvas: TCanvas);
begin

  inherited Draw(aCanvas);

  {set background color for fonts}
  aCanvas.Brush.Color := clWhite;

  aCanvas.Font.Name := 'SMALL FONTS';
  aCanvas.Font.Color := clGray;
  aCanvas.Font.Size := 6;
  aCanvas.Font.Style := [fsBold];

  ppTextOut(aCanvas, 52, 62, 'Action Club');
  ppTextOut(aCanvas, 52, 75, 'Southeast');

  aCanvas.Font.Color := clBlack;

  ppTextOut(aCanvas, 52, 88, 'Sarasota');

  aCanvas.Font.Size := 5;

  ppTextOut(aCanvas, 54, 102, 'LOCATION');
  ppTextOut(aCanvas, 109, 102, 'SQ. FT');
  ppTextOut(aCanvas, 144, 102, 'SALES');

  aCanvas.Font.Size := 5;
  aCanvas.Font.Style := [];

  ppTextOut(aCanvas, 54, 114, 'Kingsley');
  ppTextOut(aCanvas, 54, 125, 'Broadway');
  ppTextOut(aCanvas, 54, 136, 'Coats');
  ppTextOut(aCanvas, 54, 147, 'Parmer');
  ppTextOut(aCanvas, 54, 158, 'McKinnon');
  ppTextOut(aCanvas, 54, 169, 'Main');
  ppTextOut(aCanvas, 54, 180, 'Frontenac');

  ppTextOutJustified(aCanvas, 133, 114, '5,000', taRightJustify);
  ppTextOutJustified(aCanvas, 133, 125, '7,000', taRightJustify);
  ppTextOutJustified(aCanvas, 133, 136, '4,000', taRightJustify);
  ppTextOutJustified(aCanvas, 133, 147, '6,000', taRightJustify);
  ppTextOutJustified(aCanvas, 133, 158, '7,500', taRightJustify);
  ppTextOutJustified(aCanvas, 133, 169, '3,000', taRightJustify);
  ppTextOutJustified(aCanvas, 133, 180, '4,500', taRightJustify);

  ppTextOutJustified(aCanvas, 169, 114, '$20,000', taRightJustify);
  ppTextOutJustified(aCanvas, 169, 125, '$17,000', taRightJustify);
  ppTextOutJustified(aCanvas, 169, 136, '$10,000', taRightJustify);
  ppTextOutJustified(aCanvas, 169, 147, '$8,000', taRightJustify);
  ppTextOutJustified(aCanvas, 169, 158, '$23,000', taRightJustify);
  ppTextOutJustified(aCanvas, 169, 169, '$34,000', taRightJustify);
  ppTextOutJustified(aCanvas, 169, 180, '$12,000', taRightJustify);

end; {procedure, Draw}

{------------------------------------------------------------------------------}
{ TppAlignLeft1LayoutBitmap.Draw }

procedure TppAlignLeft1LayoutBitmap.Draw(aCanvas: TCanvas);
begin

  inherited Draw(aCanvas);

  {draw double lines above & below title}
  ppLine(aCanvas, 48, 22, 221, 22, clSilver);
  ppLine(aCanvas, 48, 24, 221, 24, clSilver);

  ppLine(aCanvas, 48, 43, 221, 43, clSilver);
  ppLine(aCanvas, 48, 45, 221, 45, clSilver);

  {line below subtitle}
  ppLine(aCanvas, 50, 70, 221, 70, clGray);

  {lines above and below group title}
  ppLine(aCanvas, 53, 100, 171, 100, clBlack);
  ppLine(aCanvas, 53, 109, 171, 109, clBlack);

end;

{------------------------------------------------------------------------------}
{ TppAlignLeft2LayoutBitmap.Draw }

procedure TppAlignLeft2LayoutBitmap.Draw(aCanvas: TCanvas);
begin

  inherited Draw(aCanvas);

  {draw lines above & below title}
  ppLine(aCanvas, 48, 22, 221, 22, clSilver);
  ppLine(aCanvas, 48, 43, 221, 43, clSilver);

  {lines around subtitle}
  ppLine(aCanvas, 50, 59, 221, 59, clGray);
  ppLine(aCanvas, 50, 70, 221, 70, clGray);

  ppLine(aCanvas, 50, 59, 50, 70, clGray);

  {line below group title}
  ppLine(aCanvas, 53, 86, 221, 86, clGray);

  {lines below details}
  ppLine(aCanvas, 53, 109, 171, 109, clSilver);
  ppLine(aCanvas, 53, 121, 171, 121, clSilver);
  ppLine(aCanvas, 53, 132, 171, 132, clSilver);
  ppLine(aCanvas, 53, 143, 171, 143, clSilver);
  ppLine(aCanvas, 53, 154, 171, 154, clSilver);
  ppLine(aCanvas, 53, 165, 171, 165, clSilver);
  ppLine(aCanvas, 53, 176, 171, 176, clSilver);
  ppLine(aCanvas, 53, 187, 171, 187, clSilver);

end; {procedure, Draw}

{------------------------------------------------------------------------------}
{ TppStandardLayoutBitmap.Draw }

procedure TppStandardLayoutBitmap.Draw(aCanvas: TCanvas);
begin

  inherited Draw(aCanvas);

  {draw line above title}
  ppLine(aCanvas, 48, 22, 221, 22, clSilver);

  {set background color for fonts}
  aCanvas.Brush.Color := clWhite;

  aCanvas.Font.Name := 'SMALL FONTS';
  aCanvas.Font.Color := clBlack;
  aCanvas.Font.Size := 5;
  aCanvas.Font.Style := [fsBold];

  {column headers}
  ppTextOut(aCanvas, 50, 52, 'COMPANY');
  ppTextOut(aCanvas, 97, 52, 'REGION');
  ppTextOut(aCanvas, 138, 52, 'CITY');
  ppTextOut(aCanvas, 173, 52, 'STATE');

  {lines above and below group title}
  ppLine(aCanvas, 50, 48, 198, 48, clBlack);
  ppLine(aCanvas, 50, 59, 198, 59, clBlack);

end; {procedure, Draw}

{------------------------------------------------------------------------------}
{ TppSteppedLayoutBitmap.Draw }

procedure TppSteppedLayoutBitmap.Draw(aCanvas: TCanvas);
begin

  inherited Draw(aCanvas);

  {set background color for fonts}
  aCanvas.Brush.Color := clWhite;

  aCanvas.Font.Name := 'SMALL FONTS';
  aCanvas.Font.Color := clBlack;
  aCanvas.Font.Size := 5;
  aCanvas.Font.Style := [];

  {first column}
  ppTextOut(aCanvas, 50, 64, 'Action Club');

  {second column}
  ppTextOut(aCanvas, 97, 75, 'Southeast');
  ppTextOut(aCanvas, 97, 108, 'Southwest');
  ppTextOut(aCanvas, 97, 142, 'South');

  {third column}
  ppTextOut(aCanvas, 139, 86, 'Sarasota');
  ppTextOut(aCanvas, 139, 96, 'Tampa');
  ppTextOut(aCanvas, 139, 119, 'San Jose');
  ppTextOut(aCanvas, 139, 129, 'Phoenix');
  ppTextOut(aCanvas, 139, 152, 'Dallas');
  ppTextOut(aCanvas, 139, 162, 'Atlanta');
  ppTextOut(aCanvas, 139, 172, 'Charlotte');

  {fourth column}
  ppTextOut(aCanvas, 175, 86, 'FL');
  ppTextOut(aCanvas, 175, 96, 'FL');
  ppTextOut(aCanvas, 175, 119, 'CA');
  ppTextOut(aCanvas, 175, 129, 'AZ');
  ppTextOut(aCanvas, 175, 152, 'TX');
  ppTextOut(aCanvas, 175, 162, 'GA');
  ppTextOut(aCanvas, 175, 172, 'NC');

end; {procedure, Draw}

{------------------------------------------------------------------------------}
{ TppBlockLayoutBitmap.Draw }

procedure TppBlockLayoutBitmap.Draw(aCanvas: TCanvas);
begin

  inherited Draw(aCanvas);

  {set background color for fonts}
  aCanvas.Brush.Color := clWhite;

  aCanvas.Font.Name := 'SMALL FONTS';
  aCanvas.Font.Color := clBlack;
  aCanvas.Font.Size := 5;
  aCanvas.Font.Style := [];

  {first column}
  ppTextOut(aCanvas, 52, 64, 'Action Club');
  ppTextOut(aCanvas, 52, 140, 'Action Diver');

  {second column}
  ppTextOut(aCanvas, 97, 64, 'Southeast');
  ppTextOut(aCanvas, 97, 86, 'Southwest');
  ppTextOut(aCanvas, 97, 107, 'South');
  ppTextOut(aCanvas, 97, 140, 'Southeast');

  {third column}
  ppTextOut(aCanvas, 139, 64, 'Sarasota');
  ppTextOut(aCanvas, 139, 75, 'Tampa');
  ppTextOut(aCanvas, 139, 86, 'San Jose');
  ppTextOut(aCanvas, 139, 97, 'Phoenix');
  ppTextOut(aCanvas, 139, 107, 'Dallas');
  ppTextOut(aCanvas, 139, 118, 'Atlanta');
  ppTextOut(aCanvas, 139, 129, 'El Paso');
  ppTextOut(aCanvas, 139, 140, 'Charlotte');
  ppTextOut(aCanvas, 139, 151, 'Miami');
  ppTextOut(aCanvas, 139, 162, 'Columbia');
  ppTextOut(aCanvas, 139, 173, 'Lexington');

  {fourth column}
  ppTextOut(aCanvas, 175, 64, 'FL');
  ppTextOut(aCanvas, 175, 75, 'FL');
  ppTextOut(aCanvas, 175, 86, 'CA');
  ppTextOut(aCanvas, 175, 97, 'AZ');
  ppTextOut(aCanvas, 175, 107, 'TX');
  ppTextOut(aCanvas, 175, 118, 'GA');
  ppTextOut(aCanvas, 175, 129, 'TX');
  ppTextOut(aCanvas, 175, 140, 'NC');
  ppTextOut(aCanvas, 175, 151, 'FL');
  ppTextOut(aCanvas, 175, 162, 'SC');
  ppTextOut(aCanvas, 175, 173, 'VA');

  {lines above and below group title}
  ppLine(aCanvas, 50, 48, 198, 48, clBlack);
  ppLine(aCanvas, 50, 59, 198, 59, clBlack);

  {draw grid}
  {vertical lines}
  ppLine(aCanvas, 135, 61, 135, 181, clSilver);
  ppLine(aCanvas, 173, 61, 173, 181, clSilver);

  {frames}
  ppFrameRect(aCanvas, 50, 61, 94, 72, clSilver);
  ppFrameRect(aCanvas, 94, 61, 200, 72, clSilver);
  ppFrameRect(aCanvas, 135, 72, 200, 83, clSilver);
  ppFrameRect(aCanvas, 94, 83, 200, 94, clSilver);
  ppFrameRect(aCanvas, 135, 94, 200, 104, clSilver);
  ppFrameRect(aCanvas, 94, 104, 200, 115, clSilver);
  ppFrameRect(aCanvas, 135, 115, 200, 126, clSilver);
  ppFrameRect(aCanvas, 135, 126, 200, 137, clSilver);
  ppFrameRect(aCanvas, 50, 137, 94, 148, clSilver);
  ppFrameRect(aCanvas, 94, 137, 200, 148, clSilver);
  ppFrameRect(aCanvas, 135, 148, 200, 159, clSilver);
  ppFrameRect(aCanvas, 135, 159, 200, 170, clSilver);
  ppFrameRect(aCanvas, 135, 170, 200, 181, clSilver);

end; {procedure, Draw}

{------------------------------------------------------------------------------}
{ TppOutlineLayoutBitmap.Draw }

procedure TppOutlineLayoutBitmap.Draw(aCanvas: TCanvas);
begin

  inherited Draw(aCanvas);

  {draw lines above & below title}
  ppLine(aCanvas, 48, 22, 221, 22, clSilver);
  ppLine(aCanvas, 48, 45, 221, 45, clSilver);

  {line below subtitle}
  ppLine(aCanvas, 50, 70, 222, 70, clGray);

  {set background color for fonts}
  aCanvas.Brush.Color := clWhite;

  aCanvas.Font.Name := 'SMALL FONTS';
  aCanvas.Font.Color := clGray;
  aCanvas.Font.Size := 6;
  aCanvas.Font.Style := [fsBold];

  ppTextOut(aCanvas, 52, 62, 'Action Club');
  ppTextOut(aCanvas, 61, 75, 'Southeast');

  aCanvas.Font.Color := clBlack;

  ppTextOut(aCanvas, 71, 88, 'Sarasota');

  aCanvas.Font.Size := 5;

  ppTextOut(aCanvas, 89, 102, 'LOCATION');
  ppTextOut(aCanvas, 144, 102, 'SQ. FT');
  ppTextOut(aCanvas, 179, 102, 'SALES');

  aCanvas.Font.Size := 5;
  aCanvas.Font.Style := [];

  ppTextOut(aCanvas, 89, 114, 'Kingsley');
  ppTextOut(aCanvas, 89, 125, 'Broadway');
  ppTextOut(aCanvas, 89, 136, 'Coats');
  ppTextOut(aCanvas, 89, 147, 'Parmer');
  ppTextOut(aCanvas, 89, 158, 'McKinnon');
  ppTextOut(aCanvas, 89, 169, 'Main');
  ppTextOut(aCanvas, 89, 180, 'Frontenac');

  ppTextOutJustified(aCanvas, 168, 114, '5,000', taRightJustify);
  ppTextOutJustified(aCanvas, 168, 125, '7,000', taRightJustify);
  ppTextOutJustified(aCanvas, 168, 136, '4,000', taRightJustify);
  ppTextOutJustified(aCanvas, 168, 147, '6,000', taRightJustify);
  ppTextOutJustified(aCanvas, 168, 158, '7,500', taRightJustify);
  ppTextOutJustified(aCanvas, 168, 169, '3,000', taRightJustify);
  ppTextOutJustified(aCanvas, 168, 180, '4,500', taRightJustify);

  ppTextOutJustified(aCanvas, 204, 114, '$20,000', taRightJustify);
  ppTextOutJustified(aCanvas, 204, 125, '$17,000', taRightJustify);
  ppTextOutJustified(aCanvas, 204, 136, '$10,000', taRightJustify);
  ppTextOutJustified(aCanvas, 204, 147, '$8,000', taRightJustify);
  ppTextOutJustified(aCanvas, 204, 158, '$23,000', taRightJustify);
  ppTextOutJustified(aCanvas, 204, 204, '$34,000', taRightJustify);
  ppTextOutJustified(aCanvas, 204, 180, '$12,000', taRightJustify);

end; {procedure, Draw}

{------------------------------------------------------------------------------}
{ TppOutline1LayoutBitmap.Draw }

procedure TppOutline1LayoutBitmap.Draw(aCanvas: TCanvas);
begin

  inherited Draw(aCanvas);

  {double lines around title}
  ppLine(aCanvas, 48, 24, 221, 24, clSilver);
  ppLine(aCanvas, 48, 43, 221, 43, clSilver);

  {lines above and below group title}
  ppLine(aCanvas, 88, 99, 206, 99, clBlack);
  ppLine(aCanvas, 88, 109, 206, 109, clBlack);

end; {procedure, Draw}

{------------------------------------------------------------------------------}
{ TppOutline2LayoutBitmap.Draw }

procedure TppOutline2LayoutBitmap.Draw(aCanvas: TCanvas);
begin

  inherited Draw(aCanvas);

  {lines around subtitle}
  ppLine(aCanvas, 50, 59, 221, 59, clGray);
  ppLine(aCanvas, 50, 70, 221, 70, clGray);
  ppLine(aCanvas, 50, 59, 50, 70, clGray);

  {line below group title}
  ppLine(aCanvas, 71, 86, 221, 86, clGray);

  {lines below details}
  ppLine(aCanvas, 88, 109, 206, 109, clSilver);
  ppLine(aCanvas, 88, 121, 206, 121, clSilver);
  ppLine(aCanvas, 88, 132, 206, 132, clSilver);
  ppLine(aCanvas, 88, 143, 206, 143, clSilver);
  ppLine(aCanvas, 88, 154, 206, 154, clSilver);
  ppLine(aCanvas, 88, 165, 206, 165, clSilver);
  ppLine(aCanvas, 88, 176, 206, 176, clSilver);
  ppLine(aCanvas, 88, 187, 206, 187, clSilver);

end; {procedure, Draw}

{------------------------------------------------------------------------------}
{ TppTabularLayoutBitmap.Draw }

procedure TppTabularLayoutBitmap.Draw(aCanvas: TCanvas);
begin

  inherited Draw(aCanvas);

  {set background color for fonts}
  aCanvas.Brush.Color := clWhite;

  aCanvas.Font.Name := 'SMALL FONTS';
  aCanvas.Font.Color := clBlack;
  aCanvas.Font.Size := 5;
  aCanvas.Font.Style := [fsBold];

  {column headers}
  ppTextOut(aCanvas, 50, 52, 'COMPANY');
  ppTextOut(aCanvas, 97, 52, 'REGION');
  ppTextOut(aCanvas, 138, 52, 'CITY');
  ppTextOut(aCanvas, 173, 52, 'STATE');

  {line below group title}
  ppLine(aCanvas, 50, 59, 198, 59, clBlack);

  aCanvas.Font.Style := [];

  {first column}
  ppTextOut(aCanvas, 52, 64, 'Action Club');
  ppTextOut(aCanvas, 52, 75, 'Action Club');
  ppTextOut(aCanvas, 52, 86, 'Action Club');
  ppTextOut(aCanvas, 52, 97, 'Action Club');
  ppTextOut(aCanvas, 52, 107, 'Action Club');
  ppTextOut(aCanvas, 52, 118, 'Action Club');
  ppTextOut(aCanvas, 52, 129, 'Action Club');
  ppTextOut(aCanvas, 52, 140, 'Action Diver');
  ppTextOut(aCanvas, 52, 151, 'Action Diver');
  ppTextOut(aCanvas, 52, 162, 'Action Diver');
  ppTextOut(aCanvas, 52, 173, 'Action Diver');

  {second column}
  ppTextOut(aCanvas, 97, 64, 'Southeast');
  ppTextOut(aCanvas, 97, 75, 'Southeast');
  ppTextOut(aCanvas, 97, 86, 'Southwest');
  ppTextOut(aCanvas, 97, 97, 'Southwest');
  ppTextOut(aCanvas, 97, 107, 'South');
  ppTextOut(aCanvas, 97, 118, 'South');
  ppTextOut(aCanvas, 97, 129, 'South');
  ppTextOut(aCanvas, 97, 140, 'Southeast');
  ppTextOut(aCanvas, 97, 151, 'Southeast');
  ppTextOut(aCanvas, 97, 162, 'Southeast');
  ppTextOut(aCanvas, 97, 173, 'Southeast');

  {third column}
  ppTextOut(aCanvas, 139, 64, 'Sarasota');
  ppTextOut(aCanvas, 139, 75, 'Tampa');
  ppTextOut(aCanvas, 139, 86, 'San Jose');
  ppTextOut(aCanvas, 139, 97, 'Phoenix');
  ppTextOut(aCanvas, 139, 107, 'Dallas');
  ppTextOut(aCanvas, 139, 118, 'Atlanta');
  ppTextOut(aCanvas, 139, 129, 'El Paso');
  ppTextOut(aCanvas, 139, 140, 'Charlotte');
  ppTextOut(aCanvas, 139, 151, 'Miami');
  ppTextOut(aCanvas, 139, 162, 'Columbia');
  ppTextOut(aCanvas, 139, 173, 'Lexington');

  {fourth column}
  ppTextOut(aCanvas, 175, 64, 'FL');
  ppTextOut(aCanvas, 175, 75, 'FL');
  ppTextOut(aCanvas, 175, 86, 'CA');
  ppTextOut(aCanvas, 175, 97, 'AZ');
  ppTextOut(aCanvas, 175, 107, 'TX');
  ppTextOut(aCanvas, 175, 118, 'GA');
  ppTextOut(aCanvas, 175, 129, 'TX');
  ppTextOut(aCanvas, 175, 140, 'NC');
  ppTextOut(aCanvas, 175, 151, 'FL');
  ppTextOut(aCanvas, 175, 162, 'SC');
  ppTextOut(aCanvas, 175, 173, 'VA');

end; {procedure, Draw}

{------------------------------------------------------------------------------}
{ TppVerticalLayoutBitmap.Draw }

procedure TppVerticalLayoutBitmap.Draw(aCanvas: TCanvas);
var
  liY: Integer;
  liGroup: Integer;
  lCities: TStringList;
  lStates: TStringList;
begin

  inherited Draw(aCanvas);

  {set background color for fonts}
  aCanvas.Brush.Color := clWhite;

  aCanvas.Font.Name := 'SMALL FONTS';
  aCanvas.Font.Color := clBlack;
  aCanvas.Font.Size := 5;
  aCanvas.Font.Style := [fsBold];

  liY := 53;

  lCities := TStringList.Create;
  lCities.Add('Sarasota');
  lCities.Add('Tampa');
  lCities.Add('Charlotte');

  lStates := TStringList.Create;
  lStates.Add('FL');
  lStates.Add('FL');
  lStates.Add('NC');

  {column headers}
  for liGroup := 0 to 2 do
    begin

      ppLine(aCanvas, 50, liY - 3, 159, liY - 3, clBlack);

      aCanvas.Font.Style := [fsBold];

      ppTextOut(aCanvas, 50, liY,      'COMPANY');
      ppTextOut(aCanvas, 50, liY + 11, 'REGION');
      ppTextOut(aCanvas, 50, liY + 22, 'CITY');
      ppTextOut(aCanvas, 50, liY + 33, 'STATE');

      aCanvas.Font.Style := [];

      ppTextOut(aCanvas, 101, liY,      'Action Club');
      ppTextOut(aCanvas, 101, liY + 11, 'Southeast');
      ppTextOut(aCanvas, 101, liY + 22, lCities[liGroup]);
      ppTextOut(aCanvas, 101, liY + 33, lStates[liGroup]);

      liY := liY + 47;
    end;

  lCities.Free;
  lStates.Free;

end; {procedure, Draw}

{------------------------------------------------------------------------------}
{ TppWizardFieldsBitmap.Create }

constructor TppWizardFieldsBitmap.Create;
begin

  inherited Create;

  Height := 60;
  Width := 170;

  BackgroundColor := clBtnFace;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppWizardFieldsBitmap.Draw }

procedure TppWizardFieldsBitmap.Draw(aCanvas: TCanvas);
var
  liX: Integer;
  liY: Integer;
  liIndex: Integer;
  liIndex2: Integer;
begin

  {arrow body}
  ppFillRect(aCanvas, 60, 28, 90, 40, clAqua);
  aCanvas.Pen.Color := clAqua;
  aCanvas.Brush.Color := clAqua;
  aCanvas.Polygon([Point(91,25), Point(91,43), Point(100,34), Point(91,25)]);

  {arrow shadow}
  ppLine(aCanvas, 69, 28, 69, 34, clTeal);
  ppLine(aCanvas, 59, 34, 69, 34, clTeal);
  ppLine(aCanvas, 59, 34, 59, 40, clTeal);

  ppLine(aCanvas, 91, 44, 100, 35, clGray);
  ppLine(aCanvas, 92, 44, 100, 36, clGray);

  ppFillRect(aCanvas, 61, 41, 90, 42, clGray);

  {draw tables}
  DrawDataBox(aCanvas, 17, 15, True, True, False);
  DrawDataBox(aCanvas, 38, 9, False, True, True);
  DrawDataBox(aCanvas, 28, 28, False, True, False);

  {table shadows}
  ppLine(aCanvas, 18, 40, 27, 40, clGray);
  ppLine(aCanvas, 69, 11, 69, 27, clGray);

  ppFillRect(aCanvas, 30, 53, 58, 54, clGray);
  ppFillRect(aCanvas, 59, 41, 60, 54, clGray);
  ppFillRect(aCanvas, 69, 11, 69, 27, clGray);

  {pages}
  ppFrameRect(aCanvas, 110, 12, 139, 47, clBlack);
  ppFillRect(aCanvas, 111, 13, 138, 46, clWhite);

  ppFrameRect(aCanvas, 108, 14, 137, 49, clBlack);
  ppFillRect(aCanvas, 109, 15, 136, 48, clWhite);

  ppFrameRect(aCanvas, 106, 16, 135, 51, clBlack);
  ppFillRect(aCanvas, 107, 17, 134, 50, clWhite);

  ppFillRect(aCanvas, 108, 18, 133, 23, clSilver);

  {page data}
  ppLine(aCanvas, 109, 26, 121, 26, clGray);
  ppLine(aCanvas, 109, 40, 127, 40, clGray);

  liX := 116;

  for liIndex := 0 to 1 do
    begin

      liY := 29;

      for liIndex2 := 0 to 4 do
        begin
          if (liIndex2 = 0) then
            ppLine(aCanvas, liX, liY, liX + 6, liY, clGray)
          else
            ppLine(aCanvas, liX, liY, liX + 6, liY, clSilver);

          liY := liY + 2;
        end;

      liX := liX + 9;

    end;

  liX := 116;

  for liIndex := 0 to 1 do
    begin

      liY := 43;

      for liIndex2 := 0 to 2 do
        begin
          if (liIndex2 = 0) then
            ppLine(aCanvas, liX, liY, liX + 6, liY, clGray)
          else
            ppLine(aCanvas, liX, liY, liX + 6, liY, clSilver);

          liY := liY + 2;
        end;

      liX := liX + 9;

    end;

end; {procedure, Draw}

{------------------------------------------------------------------------------}
{ TppOrientationBitmap.DrawLetterA }

procedure TppOrientationBitmap.DrawLetterA(aCanvas: TCanvas; aX, aY: Integer);
begin

  {feet}
  ppLine(aCanvas, aX,     aY + 11, aX + 3,  aY + 11,  clGray);
  ppLine(aCanvas, aX + 8, aY + 11, aX + 13, aY + 11, clGray);

  {left diagonal}
  ppLine(aCanvas, aX + 2, aY + 9,  aX + 2,  aY + 10,  clGray);
  ppLine(aCanvas, aX + 3, aY + 6,  aX + 3,  aY + 8,  clGray);
  ppLine(aCanvas, aX + 4, aY + 4,  aX + 4,  aY + 5,  clGray);
  ppLine(aCanvas, aX + 5, aY + 2,  aX + 5,  aY + 3,  clGray);
  ppLine(aCanvas, aX + 6, aY,      aX + 6,  aY,      clGray);

  {right diagonal}
  ppFillRect(aCanvas, aX + 6,  aY + 1, aX + 7,  aY + 3, clGray);
  ppFillRect(aCanvas, aX + 7,  aY + 3, aX + 8,  aY + 5, clGray);
  ppFillRect(aCanvas, aX + 8,  aY + 5, aX + 9,  aY + 7, clGray);
  ppFillRect(aCanvas, aX + 9,  aY + 7, aX + 10, aY + 9, clGray);
  ppFillRect(aCanvas, aX + 10, aY + 9, aX + 11, aY + 10, clGray);

  {crossbar}
  ppFillRect(aCanvas, aX + 4, aY + 7, aX + 7, aY + 7, clGray);

  {anti-aliasing}
  ppLine(aCanvas, aX + 7,  aY,      aX + 7,  aY,      clSilver);
  ppLine(aCanvas, aX + 8,  aY + 2,  aX + 8,  aY + 2,  clSilver);
  ppLine(aCanvas, aX + 9,  aY + 4,  aX + 9,  aY + 4,  clSilver);
  ppLine(aCanvas, aX + 10, aY + 6,  aX + 10, aY + 6,  clSilver);
  ppLine(aCanvas, aX + 11, aY + 8,  aX + 11, aY + 8,  clSilver);
  ppLine(aCanvas, aX + 12, aY + 10, aX + 12, aY + 10, clSilver);

  ppLine(aCanvas, aX + 5, aY + 4,   aX + 5,  aY + 4,  clSilver);
  ppLine(aCanvas, aX + 7, aY + 6,   aX + 7,  aY + 6,  clSilver);
  ppLine(aCanvas, aX + 8, aY + 8,   aX + 8,  aY + 8,  clSilver);
  ppLine(aCanvas, aX + 9, aY + 10,  aX + 9,  aY + 10, clSilver);

  ppLine(aCanvas, aX + 4, aY + 8,   aX + 4,  aY + 8,  clSilver);
  ppLine(aCanvas, aX + 3, aY + 9,   aX + 3,  aY + 9,  clSilver);

  ppLine(aCanvas, aX + 1, aY + 10,  aX + 1,  aY + 10, clSilver);
  ppLine(aCanvas, aX + 2, aY + 8,   aX + 2,  aY + 8,  clSilver);
  ppLine(aCanvas, aX + 3, aY + 5,   aX + 3,  aY + 5,  clSilver);
  ppLine(aCanvas, aX + 4, aY + 3,   aX + 4,  aY + 3,  clSilver);
  ppLine(aCanvas, aX + 5, aY + 1,   aX + 5,  aY + 1,  clSilver);

end; {procedure, Draw}

{------------------------------------------------------------------------------}
{ TppPortraitBitmap.Create }

constructor TppPortraitBitmap.Create;
begin

  inherited Create;

  BackgroundColor := clSilver;

  Height := 32;
  Width := 26;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppPortraitBitmap.Draw }

procedure TppPortraitBitmap.Draw(aCanvas: TCanvas);
begin

  ppFillRect(aCanvas, 1, 1, 23, 29, clWhite);

  ppLine(aCanvas, 0, 0, 19, 0, clGray);
  ppLine(aCanvas, 0, 0, 0, 30, clGray);
  ppLine(aCanvas, 19, 0, 19, 6, clGray);
  ppLine(aCanvas, 20, 2, 23, 5, clGray);
  ppLine(aCanvas, 23, 5, 23, 5, clGray);

  ppLine(aCanvas, 20, 1, 25, 6, clBlack);
  ppLine(aCanvas, 25, 6, 25, 31, clBlack);
  ppLine(aCanvas, 0, 31, 25, 31, clBlack);
  ppLine(aCanvas, 20, 6, 25, 6, clBlack);

  ppLine(aCanvas, 1, 30, 24, 30, clSilver);
  ppLine(aCanvas, 24, 30, 24, 7, clSilver);
  ppLine(aCanvas, 20, 3, 22, 5, clSilver);
  ppLine(aCanvas, 22, 5, 22, 5, clSilver);

  aCanvas.Brush.Color := clSilver;
  aCanvas.FloodFill(22, 2, clWhite, fsSurface);

  DrawLetterA(aCanvas, 6, 10);

end; {procedure, Draw}

{------------------------------------------------------------------------------}
{ TppLandscapeBitmap.Create }

constructor TppLandscapeBitmap.Create;
begin

  inherited Create;

  BackgroundColor := clSilver;

  Height := 26;
  Width := 32;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppLandscapeBitmap.Draw }

procedure TppLandscapeBitmap.Draw(aCanvas: TCanvas);
begin

  {page}
  ppFillRect(aCanvas, 1, 1, 30, 24, clWhite);

  {border}
  ppLine(aCanvas, 0, 0, 24, 0, clGray);
  ppLine(aCanvas, 0, 0, 0, 24, clGray);

  {border}
  ppLine(aCanvas, 0, 25, 31, 25, clBlack);
  ppLine(aCanvas, 31, 6, 31, 25, clBlack);

  {page shading}
  ppLine(aCanvas, 1, 24, 30, 24, clSilver);
  ppLine(aCanvas, 30, 7, 30, 24, clSilver);

  {fold-over lines}
  ppLine(aCanvas, 25, 0, 25, 6, clGray);
  ppLine(aCanvas, 25, 6, 30, 6, clBlack);

  {fold-over shading}
  ppLine(aCanvas, 25, 0, 31, 6, clBlack);
  ppLine(aCanvas, 26, 2, 29, 5, clGray);
  ppLine(aCanvas, 26, 3, 28, 5, clSilver);

  ppLine(aCanvas, 29, 5, 29, 5, clGray);
  ppLine(aCanvas, 28, 5, 28, 5, clSilver);

  aCanvas.Brush.Color := clSilver;
  aCanvas.FloodFill(28, 2, clWhite, fsSurface);

  DrawLetterA(aCanvas, 9, 7);

end; {procedure, Draw}


end.





