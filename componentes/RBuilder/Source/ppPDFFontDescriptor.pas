{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB   }

unit ppPDFFontDescriptor;

interface

uses
  Classes,
  Windows,
  Graphics,
  ppDevice,
  ppDrwCmd,
  ppPDFObject, ppPDFFontFile;

type

  {@TppPDFFontDescriptor

    Extracts additional font information needed by PDF from a given font's
    TextMetric and creates the Font Descriptor Object in PDF.

    Once a font descriptor object is created, it is written to a temporary
    memory stream and added to a TList in the TppPDFFontManager class.  Then
    once all pages are generated, each font is written to the PDF file.  This
    is from the need to create and keep track of the fonts being used while
    generating the content stream.}

  {@TppPDFFontDescriptor.Font

    Reference to the TFont object being used to create the PDF Font Descriptor
    Object.  This is the Delphi representation of the font in use. }

  {@TppPDFFontDescriptor.FontName

    Name of the Font in use, processed so Adobe PDF can read it.  NOTE:  All
    font names must be processed throught the ppPDFUtils.ProcessFontName
    routine.  There are four options for a given font name in PDF:

      - FontName
      - FontName,Bold
      - FontName,Italic
      - FontName,BoldItalic

    All font names must be in lower caps as well.  }

  TppPDFFontDescriptor = class(TppPDFObject)
    private
      FEmbedFonts: Boolean;
      FFont: TFont;
      FFontFile: TppPDFFontFile;
      FFontName: String;
      FTempFontDescriptorStream: TMemoryStream;
      FTextMetric: TTextMetricA;
      FCharList: TStringList;

      procedure CreateFontDescriptor;
      procedure SetFont(const Value: TFont);
      procedure SetFontFile(Value: TppPDFFontFile);
      procedure SetFontName(const Value: String);
      procedure SetTextMetric(const Value: TTextMetricA);

      function Flags: String;

    public
      constructor Create; override;
      destructor Destroy; override;

      procedure SaveFontDescriptor(aPosition: Integer);
      procedure Write(aOutputStream: TStream; aReferenceNumber: Integer); override;

      property EmbedFonts: Boolean read FEmbedFonts write FEmbedFonts;
      property Font: TFont read FFont write SetFont;
      property FontFile: TppPDFFontFile read FFontFile write SetFontFile;
      property FontName: String read FFontName write SetFontName;
      property TextMetric: TTextMetricA read FTextMetric write SetTextMetric;
      property CharList: TStringList read FCharList write FCharList;

  end;


implementation

uses
  ppPrintr,
  SysUtils,
  StrUtils,
  ppPDFUtils;

{@TppPDFFontDescriptor.Create

  Creates a new Font Descriptor object. }

constructor TppPDFFontDescriptor.Create;
begin
  inherited Create;

  FFont := TFont.Create;
  FTempFontDescriptorStream := TMemoryStream.Create;

  FFontFile := nil;

end;

{TppPDFFontDescriptor.CreateFontDescriptor

  Writes all descriptor information to the temporary stream. }

procedure TppPDFFontDescriptor.CreateFontDescriptor;
var
  ldAscent: Double;
  ldDescent: Double;
  lsFontBox: String;
  ldLeft: Double;
  ldMaxCharWidth: Double;
  lBitmap: TBitmap;
  lTextMetricA: TTextMetricA;
begin

  lBitmap := TBitmap.Create;
  try
    lBitmap.Canvas.Font.Assign(Font);
    lBitmap.Canvas.Font.Height := -1000;
    GetTextMetricsA(lBitmap.Canvas.Handle, lTextMetricA);
  finally
    lBitmap.Free;
  end;

  ldLeft := -250;
  ldAscent := lTextMetricA.tmAscent;
  ldDescent := -lTextMetricA.tmDescent;
  ldMaxCharWidth := lTextMetricA.tmMaxCharWidth;

  lsFontBox := ExtToStr(ldLeft) + ' ' + ExtToStr(ldDescent) + ' ' +  ExtToStr(ldMaxCharWidth) + ' ' + ExtToStr(ldAscent);

  WriteMSLine(FTempFontDescriptorStream, IntToStr(ReferenceNumber) + ' 0 obj');
  WriteMSLine(FTempFontDescriptorStream, '<< /Type /FontDescriptor');
  WriteMSLine(FTempFontDescriptorStream, '/FontName /'+ FontName);
  WriteMSLine(FTempFontDescriptorStream, '/Ascent ' + ExtToStr(ldAscent));
  WriteMSLine(FTempFontDescriptorStream, '/CapHeight ' + ExtToStr(ldAscent));
  WriteMSLine(FTempFontDescriptorStream, '/Descent ' + ExtToStr(ldDescent));
  WriteMSLine(FTempFontDescriptorStream, '/Flags ' + Flags);
  WriteMSLine(FTempFontDescriptorStream, '/FontBBox [ ' + lsFontBox + ' ]');
  WriteMSLine(FTempFontDescriptorStream, '/ItalicAngle 0');
  WriteMSLine(FTempFontDescriptorStream, '/StemV 0');

  if EmbedFonts then
    WriteMSLine(FTempFontDescriptorStream, '/FontFile2 ' + IntToStr(ReferenceNumber + 2) + ' 0 R');  //Need to account for Widths array
    
  WriteMSLine(FTempFontDescriptorStream, '>>');
  WriteMSLine(FTempFontDescriptorStream, 'endobj');

end;

{@TppPDFFontDescriptor.Destroy

  Automatically called when a TppPDFFontDescriptor object is freed.  Do not call
  this method directly.  Instead call the Free routine. }

destructor TppPDFFontDescriptor.Destroy;
begin
  FTempFontDescriptorStream.Free;
  FFont.Free;

  inherited;
end;

{TppPDFFontDescriptor.Flags

  Flags specify various characteristics of a font in PDF.
  Flags are calculated using the following table:

  BitPosition     Name              Used
  -----------     ------------      -----
  1               FixedPitch        Yes
  2               Serif             Yes
  3               Symbolic          Yes
  4               Script            Yes
  6               NonSymbolic       Yes
  7               Italic            Yes
  17              AllCap            No
  18              SmallCap          No
  19              ForceBold         No

  All bit positions not defined here must be 0. }

function TppPDFFontDescriptor.Flags: String;
var
  liFlags: Integer;
  lbFixedPitch: Boolean;
  lbItalic: Boolean;
  lbNonSymbolic: Boolean;
  lbScript: Boolean;
  lbSerif: Boolean;
  lbSymbolic: Boolean;
begin

  liFlags := 0;

  lbFixedPitch := (FTextMetric.tmPitchAndFamily and TMPF_FIXED_PITCH) = TMPF_FIXED_PITCH;
  lbSerif := (FTextMetric.tmPitchAndFamily and FF_ROMAN) = FF_ROMAN;
  lbSymbolic := (FTextMetric.tmCharSet = SYMBOL_CHARSET);
  lbScript := (FTextMetric.tmPitchAndFamily and FF_SCRIPT) = FF_SCRIPT;
  lbNonSymbolic := (FTextMetric.tmCharSet <> SYMBOL_CHARSET);
  lbItalic := FTextMetric.tmItalic <> 0;

  if lbFixedPitch then
    liFlags := liFlags + 1;

  if lbSerif then
    liFlags := liFlags + 2;

  if lbSymbolic then
    liFlags := liFlags + 4;

  if lbScript then
    liFlags := liFlags + 8;

  if lbNonSymbolic then
    liFlags := liFlags + 32;

  if lbItalic then
    liFlags := liFlags + 64;

  Result := IntToStr(liFlags);
end;

{@TppPDFFontDescriptor.SaveFontDescriptor

  Copies the TppPDFFontDescriptor object from the internal temporary memory
  stream to the main device file stream.  Call once all pages have been
  generated. }

procedure TppPDFFontDescriptor.SaveFontDescriptor(aPosition: Integer);
begin
  ByteOffset := aPosition;

  FTempFontDescriptorStream.Position := 0;
  OutputStream.CopyFrom(FTempFontDescriptorStream, FTempFontDescriptorStream.Size);

  if FFontFile <> nil then
    begin
      FFontFile.CharList := FCharList;
      FFontFile.SaveFontFile(OutputStream.Position);
    end;
end;

procedure TppPDFFontDescriptor.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TppPDFFontDescriptor.SetFontFile(Value: TppPDFFontFile);
begin
  FFontFile := Value;
end;

procedure TppPDFFontDescriptor.SetFontName(const Value: String);
begin
  FFontName := Value;
end;

procedure TppPDFFontDescriptor.SetTextMetric(const Value: TTextMetricA);
begin
  FTextMetric := Value;
end;

{@TppPDFFontDescriptor.Write

  Write instructions in PDF code to the PDF File Stream to create the Font
  Object Descriptor. }

procedure TppPDFFontDescriptor.Write(aOutputStream: TStream; aReferenceNumber: Integer);
begin
  inherited;

  CreateFontDescriptor;

end;


end.
