{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB   }

unit ppPDFFontWidths;

interface

uses
  Classes,
  Windows,
  Graphics,
  ppTypes,
  ppDevice,
  ppDrwCmd,
  ppPDFObject;

type

  {@TppPDFFontWidths

    Extracts individual font character widths to be placed in an array in the
    PDF file.

    Once a font widths object is created, it is written to a temporary
    memory stream and added to a TList in the TppPDFFontManager class.  Then
    once all pages are generated, each font is written to the PDF file.  This
    is from the need to create and keep track of the fonts being used while
    generating the content stream. }

  {@TppPDFFontWidths.Font

    Reference to the TFont object being used to create the PDF Font Widths
    Object.  This is the Delphi representation of the font in use. }

  {@TppPDFFontWidths.TextMetric

    Reference to the TEXTMETRIC structure in the Windows API.  This structure
    contains basic information about a physical font.  For more information on
    the TextMetric structure, see the Windows SDK help. }
    
  TppPDFFontWidths = class(TppPDFObject)
    private
      FFont: TFont;
      FFontType: TppPDFFontType;
      FTempFontWidthsStream: TMemoryStream;
      FTextMetric: TTextMetricA;
      FCharList: TStringList;

      procedure CreateStandardFontWidths;
      procedure CreateCIDFontWidths;
      procedure SetFont(const Value: TFont);
      procedure SetTextMetric(const Value: TTextMetricA);
      procedure SetCharList(const Value: TStringList);

    public
      constructor Create; override;
      destructor Destroy; override;
      
      procedure Write(aOutputStream: TStream; aReferenceNumber: Integer); override;
      procedure SaveFontWidths(aPosition: Integer);

      property Font: TFont read FFont write SetFont;
      property FontType: TppPDFFontType read FFontType write FFontType;
      property TextMetric: TTextMetricA read FTextMetric write SetTextMetric;
      property CharList: TStringList read FCharList write SetCharList;

  end;

implementation

uses
  SysUtils;

{@TppPDFFontWidths.Create

  Creates a new Font Widths Object.}

constructor TppPDFFontWidths.Create;
begin
  inherited;

  FFont := TFont.Create;
  FFontType := pfTrueType;
  FTempFontWidthsStream := TMemoryStream.Create;

end;

{TppPDFFontWidths.CreateCIDFontWidths

  Create a table containing the widths of each character used in the document
  based on its Character ID or CID.  This is used for Unicode fonts only.}

procedure TppPDFFontWidths.CreateCIDFontWidths;
var
  liIndex: Integer;
  lsText: String;
  lWidthArray: array of Integer;
  lGlyphArray: array of WORD;
  lBitmap: TBitmap;
begin

  lBitmap := TBitmap.Create;

  try
    lBitmap.Canvas.Font := Font;
    lBitmap.Canvas.Font.Height := -1000;

    SetLength(lWidthArray, CharList.Count);
    SetLength(lGlyphArray, CharList.Count);

    lsText := SysUtils.StringReplace(CharList.Text, #13#10, '', [rfReplaceAll]);

    GetGlyphIndices(lBitmap.Canvas.Handle, PChar(lsText), CharList.Count, @lGlyphArray[0], 0);
    GetCharWidthI(lBitmap.Canvas.Handle, 0, CharList.Count, @lGlyphArray[0], lWidthArray[0]);

  finally
    lBitmap.Free;
  end;

  WriteMSLine(FTempFontWidthsStream, IntToStr(ReferenceNumber) + ' 0 obj');
  WriteMSMem(FTempFontWidthsStream, '[ ');

  for liIndex := 0 to Length(lGlyphArray) - 1 do
    WriteMSLine(FTempFontWidthsStream, IntToStr(lGlyphArray[liIndex]) + ' [' + IntToStr(lWidthArray[liIndex]) + ']');

  WriteMSLine(FTempFontWidthsStream, ']');
  WriteMSLine(FTempFontWidthsStream, 'endobj');

end;

{TppPDFFontWidths.CreateStandardFontWidths

  Create a table containing the widths of all 255 characters in the
  ANSI charset being used.}

procedure TppPDFFontWidths.CreateStandardFontWidths;
var
  liIndex: Integer;
  lCharArray: array of Integer;
  lFirstChar: Cardinal;
  lLastChar: Cardinal;
  lsWidths: String;
  lBitmap: TBitmap;
begin

  lBitmap := TBitmap.Create;

  try
    lBitmap.Canvas.Font := Font;
    lBitmap.Canvas.Font.Height := -1000;

    lFirstChar := Ord(FTextMetric.tmFirstChar);
    lLastChar := Ord(FTextMetric.tmLastChar);

    SetLength(lCharArray, lLastChar - lFirstChar + 1);

    GetCharWidthA(lBitmap.Canvas.Handle, lFirstChar, lLastChar, lCharArray[0]);

  finally
    lBitmap.Free;
  end;

  WriteMSLine(FTempFontWidthsStream, IntToStr(ReferenceNumber) + ' 0 obj');
  WriteMSLine(FTempFontWidthsStream, '[');

  lsWidths := '';

  for liIndex := 0 to Length(lCharArray) - 1 do
    lsWidths := lsWidths + ExtToStr(lCharArray[liIndex]) + ' ';

  WriteMSLine(FTempFontWidthsStream, lsWidths);

  WriteMSLine(FTempFontWidthsStream, ']');
  WriteMSLine(FTempFontWidthsStream, 'endobj');

end;

{@TppPDFFontWidths.Destroy

  Automatically called when a TppPDFFontWidths object is freed.  Do not call
  this method directly.  Instead call the Free routine.}

destructor TppPDFFontWidths.Destroy;
begin
  FFont.Free;
  FTempFontWidthsStream.Free;

  inherited;
end;

{@TppPDFFontWidths.SaveFontWidths

  Copies the TppPDFFontWidths object from the internal temporary memory
  stream to the main device file stream.  Call once all pages have been
  generated.}

procedure TppPDFFontWidths.SaveFontWidths(aPosition: Integer);
begin
  if (FFontType = pfType0) then
    CreateCIDFontWidths
  else
    CreateStandardFontWidths;

  ByteOffset := aPosition;

  FTempFontWidthsStream.Position := 0;
  OutputStream.CopyFrom(FTempFontWidthsStream, FTempFontWidthsStream.Size);
end;

procedure TppPDFFontWidths.SetCharList(const Value: TStringList);
begin
  FCharList := Value;
end;

procedure TppPDFFontWidths.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TppPDFFontWidths.SetTextMetric(const Value: TTextMetricA);
begin
  FTextMetric := Value;
end;

{@TppPDFFontWidths.Write

  Write instructions in PDF code to the PDF File Stream to create the Font
  Widths Object. }

procedure TppPDFFontWidths.Write(aOutputStream: TStream; aReferenceNumber: Integer);
begin
  inherited;

end;


end.
