{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB   }

unit ppPDFUtils;

interface

uses
  Classes,
  Windows,
  Graphics,
  ExtCtrls,
  SysUtils,
  ppDevice,
  ppTypes,
  ppZLib,
  ppPDFCanvas;

type

  {@TppPDFUtils

    This class is not connected in any way to the PDF Device.  These class
    functions and procedures are available to any class in the PDF Device to
    act as helpers and utilities for PDF processing. }

  TppPDFUtils = class
    private
      class function ExtToStr(aValue: Extended): String;
      class function HashKey(aKey: AnsiString; aRefNumber, aGenNumber: Integer): string;
      class function JoinedBorder(aBorderPositions: TppBorderPositions): Boolean;

    public
      class procedure CompressStream(aDataStream: TStream; aCompressionLevel: TppCompressionLevel);
      class procedure DrawBorder(aStream: TMemoryStream; aDrawCommand: TppDrawCommand; aDrawRect: TRect; aPDFCanvas: TppPDFCanvas);
      class procedure EncryptStream(aStream: TStream; aKey: AnsiString; aRefNumber, aGenNumber: Integer);
      class procedure WriteLine(aOutputStream: TStream; aLine: AnsiString);
      class procedure WriteMem(aOutputStream: TStream; aBuffer: AnsiString);

      class function ConvertRGB(aColor: TColor): String;
      class function EncryptString(aInput: String; aKey: AnsiString; aRefNumber, aGenNumber: Integer): String;
      class function IntToByteChars(aValue: Integer): String;
      class function IsStandardFont(aFont: TFont): Boolean;
      class function MicronsToPixels(aMicrons: Integer): Integer;
      class function MicronsToPoints(aMicrons: Integer): Double;
      class function PenStyle(aStyle: TPenStyle): String;
      class function PopulateTextMetric(aFont: TFont; aCanvas: TCanvas): TTextMetricA;
      class function ProcessFontName(aFont: TFont; aIsTrueType: Boolean): String;
      class function ProcessText(aText: String): String;
      class function PixelsToPoints(aPixels, aPixelsPerInch: Integer): Double;
      class function PointsToPixels(aPoints: Double): Integer;
      class function StrToHex(aString: String): string;
      class function IsUnicodeFont(aFont: TFont): Boolean;

  end;

implementation

uses
  Forms,
  Math,
  StrUtils,
  ppCharacter,
  ppDrwCmd,
  ppViewr,
  ppUtils,
  ppFilDev,
  ppDCPmd5,
  ppDCPrc4,
  RichEdit;

{@TppPDFUtils.CompressStream

  Compresses a given stream at the chosen compression level.  This function
  uses the ZLib library to compress a memory stream before being written to the
  PDF file. }

class procedure TppPDFUtils.CompressStream(aDataStream: TStream; aCompressionLevel: TppCompressionLevel);
var
  lCompressionStream: TppCompressionStream;
  lInputStream: TStream;
begin

  {create a temporary input stream and copy the data stream}
  lInputStream := TStream(aDataStream.ClassType.Create);

  try
    lInputStream.CopyFrom(aDataStream, 0);

    {clear the data stream - it will be used to write the compressed output}
    aDataStream.Size := 0;

    {create a ZLib compression stream - it will write compressed data to aDataStream }
    lCompressionStream := TppCompressionStream.Create(aCompressionLevel, aDataStream);

    try
      lCompressionStream.CopyFrom(lInputStream, 0);
    finally
      lCompressionStream.Free;
    end;

  finally
    lInputStream.Free;

  end;

end;

{@TppPDFUtils.ConvertRGB

  Retrieves the Hexadecimal values for each tint (Red, Green, Blue) and
  converts it to the one place decimal form that PDF is able to decifer.  This
  function returns a string value representing a color in PDF RGB format. }

class function TppPDFUtils.ConvertRGB(aColor: TColor): String;
var
  liColor: Integer;
  lsRed: String;
  lsGreen: String;
  lsBlue: String;
begin

  liColor  := ColorToRGB(aColor);

  lsRed := ExtToStr(RoundTo(GetRValue(liColor) / 255, -3));
  lsGreen := ExtToStr(RoundTo(GetGValue(liColor) / 255, -3));
  lsBlue := ExtToStr(RoundTo(GetBValue(liColor) / 255, -3));

  Result := lsRed + ' ' + lsGreen + ' ' + lsBlue;

end;

{@TppPDFUtils.DrawBorder

  Adds a border to a given drawcommand }

class procedure TppPDFUtils.DrawBorder(aStream: TMemoryStream; aDrawCommand: TppDrawCommand; aDrawRect: TRect; aPDFCanvas: TppPDFCanvas);
  {$WARNINGS OFF}
  procedure WriteLine(aLine: String);
    begin
      TppPDFUtils.WriteLine(aStream, aLine);
    end;
  {$WARNINGS ON}
var
  lBorder: TppBorder;
  ldBottom: Double;
  ldLeft: Double;
  ldTop: Double;
  ldRight: Double;
  ldWidth: Double;
  ldHeight: Double;
  ldOffset: Double;
  ldXOffset: Double;
  lPen: TPen;
begin

  lBorder := aDrawCommand.Border;
  lPen := TPen.Create;

    try

      lPen.Style := lBorder.Style;
      lPen.Color := lBorder.Color;

      {Dimentions}
      ldWidth := MicronsToPoints(aDrawRect.Right);
      ldHeight := MicronsToPoints(aDrawRect.Bottom);

      {Position}
      ldTop:= MicronsToPoints(aDrawRect.Top);
      ldLeft := MicronsToPoints(aDrawRect.Left);
      ldBottom := ldTop + ldHeight;
      ldRight := ldLeft + ldWidth;

      {Weight Offset}
      ldOffset := lBorder.Weight / 2;

      {Store current graphics state}
      aPDFCanvas.SaveGraphicsState;

      {Define the Graphics State Dictionary}
      WriteLine('/GS1 gs');

      {Select Border Pen}
      aPDFCanvas.SelectPen(lPen, lBorder.Weight);

      {Draw Border}
      if JoinedBorder(lBorder.BorderPositions) then
        begin
          ldXOffset := ldOffset;
          WriteLine('2 J');
        end
      else
        ldXOffset := 0;

      if (bpLeft in lBorder.BorderPositions) then
        begin
          aPDFCanvas.MoveTo(ldLeft + ldOffset, ldBottom + ldXOffset);
          aPDFCanvas.LineTo(ldLeft + ldOffset, ldTop - ldXOffset);
        end;

      if (bpTop in lBorder.BorderPositions) then
        begin
          aPDFCanvas.MoveTo(ldLeft + ldXOffset, ldTop - ldOffset);
          aPDFCanvas.LineTo(ldRight - ldXOffset, ldTop - ldOffset);
        end;

      if (bpRight in lBorder.BorderPositions) then
        begin
          aPDFCanvas.MoveTo(ldRight - ldOffset, ldTop - ldXOffset);
          aPDFCanvas.LineTo(ldRight - ldOffset, ldBottom + ldXOffset);
        end;

      if (bpBottom in lBorder.BorderPositions) then
        begin
          aPDFCanvas.MoveTo(ldRight - ldXOffset, ldBottom + ldOffset);
          aPDFCanvas.LineTo(ldLeft + ldXOffset, ldBottom + ldOffset);
        end;

      aPDFCanvas.ExecuteStroke;

      {Restore graphics state}
      aPDFCanvas.RestoreGraphicsState;

    finally
      lPen.Free;
    end;

end;

class function TppPDFUtils.JoinedBorder(aBorderPositions: TppBorderPositions): Boolean;
begin
  Result := (aBorderPositions <> []) and (aBorderPositions <> [bpLeft]) and (aBorderPositions <> [bpTop]) and (aBorderPositions <> [bpRight]) and
            (aBorderPositions <> [bpBottom]) and (aBorderPositions <> [bpLeft, bpRight]) and (aBorderPositions <> [bpTop, bpBottom]);
end;

class procedure TppPDFUtils.EncryptStream(aStream: TStream; aKey: AnsiString; aRefNumber, aGenNumber: Integer);
var
  lsData: AnsiString;
  lsEncryptData: AnsiString;
begin

  //No encryption needed.
  if aKey = '' then exit;

  aStream.Position := 0;
  SetLength(lsData, aStream.Size);
  aStream.Read(lsData[1], Length(lsData));

  {$WARNINGS OFF}
  lsEncryptData := EncryptString(lsData, aKey, aRefNumber, aGenNumber);
  {$WARNINGS ON}

  aStream.Position := 0;
  aStream.Write(lsEncryptData[1], Length(lsEncryptData));

end;

class function TppPDFUtils.EncryptString(aInput: string; aKey: AnsiString; aRefNumber, aGenNumber: Integer): string;
var
  lsKey: String;
  lRC4Cipher: TppDCP_rc4;
  lKey: array[0..9] of byte;
  liIndex: Integer;
begin
  Result := aInput;

  //No encryption needed
  if aKey = ''  then exit;
  if aInput = '' then exit;

  //Hash the key
  lsKey := HashKey(aKey, aRefNumber, aGenNumber);

  //Move the key to a byte array.
  for liIndex := 0 to Length(lKey) - 1 do
    lKey[liIndex] := Ord(lsKey[liIndex+1]);

  //Encrypt the string.
  lRC4Cipher:= TppDCP_rc4.Create(nil);
  try
    lRC4Cipher.Init(lKey, Sizeof(lKey)*8, nil);
    Result := String(lRC4Cipher.EncryptString(AnsiString(aInput)));
  finally
    lRC4Cipher.Free;
  end;

end;

{@TppPDFUtils.MicronsToPixels

  Converts an integer type micron value to the nearest screen pixel value. }

class function TppPDFUtils.MicronsToPixels(aMicrons: Integer): Integer;
begin
  Result := Round(aMicrons * TppFileDeviceUtils.InchPerMicron * Screen.PixelsPerInch);
end;

class function TppPDFUtils.PointsToPixels(aPoints: Double): Integer;
begin
  Result := Round((aPoints / 72) * Screen.PixelsPerInch);
end;

{@TppPDFUtils.MicronsToPoints

  Converts an integer type micron value to points, rounded to the nearest
  thousandth. }

class function TppPDFUtils.MicronsToPoints(aMicrons: Integer): Double;
begin
  Result := aMicrons * TppFileDeviceUtils.InchPerMicron * 72;

end;

{@TppPDFUtils.PenStyle

  Defines the 5 pen styles available in ReportBuilder.  The arrays define an
  "on/off" point value of a line. For instance [ 10 4 ] means 10 points on, 4
  points off, or a dashed line. }

class function TppPDFUtils.PenStyle(aStyle: TPenStyle): String;
begin
  case aStyle of
    psClear,
    psSolid: Result := '[] 0 d';
    psDash: Result := '[ 10 4 ] 0 d';
    psDashDot: Result := '[ 8 3 2 3 ] 0 d';
    psDashDotDot: Result := '[ 8 3 2 2 2 3 ] 0 d';
    psDot: Result := '[ 2 2 ] 0 d';
  end;
end;

{@TppPDFUtils.PopulateTextMetric

  Populates the TEXTMETRIC structure for a given font.  The TEXTMETRIC is a
  Windows API defined object containing detailed information about a font.  For
  more information on the TEXTMETRIC, please see this topic in the Windows API
  help. }

class function TppPDFUtils.PopulateTextMetric(aFont: TFont; aCanvas: TCanvas): TTextMetricA;
begin

  aCanvas.Font := aFont;

  GetTextMetricsA(aCanvas.Handle, Result);

end;

{@TppPDFUtils.ProcessFontName

  Every font name must be processed to ensure the proper format.  Bold fonts
  must be followed by ,Bold, Italic fonts: ,Italic and so on.}

class function TppPDFUtils.ProcessFontName(aFont: TFont; aIsTrueType: Boolean): String;
begin

  if aIsTrueType then
    begin
      //remove spaces and parens from font name
      Result := AnsiReplaceStr(aFont.Name, ' ', '');
      Result := AnsiReplaceStr(Result, '(', '#28');
      Result := AnsiReplaceStr(Result, ')', '#29');

      {Handle times and arial case}
      if Result = 'TIMESNEWROMAN' then
        Result := 'TimesNewRoman'
      else if Result = 'ARIAL' then
        Result := 'Arial';

      if (fsBold in aFont.Style) and (fsItalic in aFont.Style) then
        Result := Result + ',BoldItalic'
      else if (fsBold in aFont.Style) then
        Result := Result + ',Bold'
      else if (fsItalic in aFont.Style) then
        Result := Result + ',Italic';
    end
  else
    begin
      Result := 'Times-Roman';

      if (Pos('COURIER', UpperCase(aFont.Name)) <> 0) then
        begin
          if (fsBold in aFont.Style) and (fsItalic in aFont.Style) then
            Result := 'Courier-BoldOblique'
          else if (fsBold in aFont.Style) and (not(fsItalic in aFont.Style)) then
            Result := 'Courier-Bold'
          else if (fsItalic in aFont.Style) and (not(fsBold in aFont.Style)) then
            Result := 'Courier-Oblique'
          else
            Result := 'Courier';
        end;

      if (Pos('WINGDINGS', UpperCase(aFont.Name)) <> 0) then
        begin
          Result := 'ZapfDingbats';
        end;

      if (Pos('ARIAL', UpperCase(aFont.Name)) <> 0) then
        begin
          if (fsBold in aFont.Style) and (fsItalic in aFont.Style) then
            Result := 'Helvetica-BoldOblique'
          else if (fsBold in aFont.Style) and (not(fsItalic in aFont.Style)) then
            Result := 'Helvetica-Bold'
          else if (fsItalic in aFont.Style) and (not(fsBold in aFont.Style)) then
            Result := 'Helvetica-Oblique'
          else
            Result := 'Helvetica';
        end;

      if (Pos('TIMES', UpperCase(aFont.Name)) <> 0)  or (Result = 'Times-Roman') then
        begin
          if (fsBold in aFont.Style) and (fsItalic in aFont.Style) then
            Result := 'Times-BoldItalic'
          else if (fsBold in aFont.Style) and (not(fsItalic in aFont.Style)) then
            Result := 'Times-Bold'
          else if (fsItalic in aFont.Style) and (not(fsBold in aFont.Style)) then
            Result := 'Times-Italic'
          else
            Result := 'Times-Roman';
        end;

    end;

end;

class function TppPDFUtils.IsStandardFont(aFont: TFont): Boolean;
begin
  Result := (Pos('COURIER', UpperCase(aFont.Name)) <> 0) or
            (Pos('WINGDINGS', UpperCase(aFont.Name)) <> 0) or
            (Pos('ARIAL', UpperCase(aFont.Name)) <> 0) or
            (Pos('TIMES', UpperCase(aFont.Name)) <> 0) or
            (Pos('SYMBOL', UpperCase(aFont.Name)) <> 0);
end;

{@TppPDFUtils.ProcessText

  Loops through each character of a String and adds a backslash (#92) before
  any PDF reserved characters (ie. left parenthesis (#40), right parenthesis
  (#41), and backslash (#92)).

  It is necessary to send every line of text through this function before
  outputing to PDF. }

class function TppPDFUtils.ProcessText(aText: String): String;
var
  liIndex: Integer;
  liTextLength: Integer;
begin

  Result := '';
  liTextLength := Length(aText);

  for liIndex := 1 to liTextLength do
    begin
      if (aText[liIndex] = #40) or (aText[liIndex] = #41) or (aText[liIndex] = #92) then
        Result := Result + #92 + aText[liIndex]
      else
        Result := Result + aText[liIndex];
    end;

end;

{@TppPDFUtils.PixelsToPoints

  Given a number of pixels and screen or printer pixels per inch, this function
  will return a Double type value in points. }

class function TppPDFUtils.PixelsToPoints(aPixels, aPixelsPerInch: Integer): Double;
begin
  Result := aPixels / aPixelsPerInch * 72;

end;

{@TppPDFUtils.WriteLine }

class procedure TppPDFUtils.WriteLine(aOutputStream: TStream; aLine: AnsiString);
begin
    aLine := aLine + #13 + #10;
    aOutputStream.Write(aLine[1], Length(aLine));

end;

{@TppPDFUtils.WriteMem }

class procedure TppPDFUtils.WriteMem(aOutputStream: TStream; aBuffer: AnsiString);
begin
  aOutputStream.Write(aBuffer[1], Length(aBuffer));

end;

{TppPDFUtils.ExtToStr }

class function TppPDFUtils.ExtToStr(aValue: Extended): String;
begin
  Result := FormatFloat('0.0####', aValue);
  Result := StringReplace(Result, DecimalSeparator, '.', []);
end;

class function TppPDFUtils.HashKey(aKey: AnsiString; aRefNumber, aGenNumber: Integer): string;
var
  lsKey: String;
  lMD5Hash: TppDCP_md5;
  lDigest: array[0..15] of byte;
  liIndex: Integer;
begin

  //First add the encryption key
  lsKey := String(aKey);
  //Next the three low order bytes of the Reference number (in binary)
  lsKey := lsKey + Copy(ReverseString(IntToByteChars(aRefNumber)), 1, 3);
  //Finally the two low order bytes of the Generation number (in binary).
  lsKey := lsKey + Copy(ReverseString(IntToByteChars(aGenNumber)), 1, 2);

  //Hash the key and take the first n+5 bytes to use for encryption.
  lMD5Hash := TppDCP_md5.Create(nil);
  try
    lMD5Hash.Init;
    lMD5Hash.UpdateStr(AnsiString(lsKey));
    lMD5Hash.Final(lDigest);
  finally
    lMD5Hash.Free;
  end;

  SetLength(Result, 10);
  for liIndex := 0 to Length(Result)-1 do
    Result[liIndex+1] := Chr(lDigest[liIndex]);

end;

{TppPDFUtils.IntToByteChars }

class function TppPDFUtils.IntToByteChars(aValue: Integer): String;
var
  lsHexValue: String;
  lsByte: String;
  liIndex: Integer;
begin
  //Convert the value into a 32 bit hex number.
  lsHexValue := IntToHex(aValue, 8);

  //Convert each byte into a character value
  liIndex := 1;
  while liIndex < Length(lsHexValue) do
    begin
      lsByte := Copy(lsHexValue, liIndex, 2);
      Result := Result + Chr(StrToInt('$' + lsByte));
      liIndex := liIndex + 2;
    end;

end;

{TppPDFUtils.IsUnicodeFont

  Attempts to determine if a given font has Unicode capability.  This routine
  retrieves the number of glyphs in the font character range.  If this number is
  larger than and ANSI charset (255), the font is assumed to support Unicode
  characters.}

class function TppPDFUtils.IsUnicodeFont(aFont: TFont): Boolean;
var
  lBitmap: TBitmap;
  lGlyphSet: PGlyphSet;
  liSize: Integer;
begin

  lBitmap := TBitmap.Create;
  lBitmap.Canvas.Font := aFont;

  liSize := GetFontUnicodeRanges(lBitmap.Canvas.Handle, nil);
  lGlyphSet := AllocMem(liSize);

  GetFontUnicodeRanges(lBitmap.Canvas.Handle, lGlyphSet);

  Result := lGlyphSet^.cGlyphsSupported > 255;

  FreeMem(lGlyphSet);
  lBitmap.Free;

end;

{TppPDFUtils.StrToHex}

class function TppPDFUtils.StrToHex(aString: String): string;
var
  liIndex: Integer;
begin

  Result := '';
  for liIndex := 1 to Length(aString) do
    Result := LowerCase(Result + IntToHex(Ord(AnsiString(aString)[liIndex]), 2));
end;

end.
