{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB   }

unit ppPDFFont;

interface

uses
  Classes,
  Windows,
  Graphics,
  ppDevice,
  ppDrwCmd,
  ppTypes,
  ppPDFObject,
  ppPDFFontDescriptor,
  ppPDFFontWidths,
  ppPDFEncoding,
  ppZLib;

type

  {@TppPDFFont

    Extracts font information from a given font's TextMetric and creates the
    Font Object in PDF.  The font object also references two other objects which
    are handled differently as separate objects.  The two referenced objects
    are:

      - TppPDFFontDescriptor: Further description of the font in use.
      - TppPDFFontWidth: Individual character widths for the font in use.

    Once a font object is created, it is written to a temporary memory stream
    and added to a TList in the TppPDFFontManager class.  Then once all pages
    are generated, each font is written to the PDF file.  This is from the need
    to create and keep track of the fonts being used while generating the
    content stream. }

  {@TppPDFFont.IsTrueType

    True if the font is a Microsoft TrueType font.  These are the most
    promenently used fonts on a Windows platform.  For more information on
    TrueType fonts, see the Windows SDK help. }

  {@TppPDFFont.IsUsed

    True if the font has already been used in another page to prevent the
    creation of duplicate Font objects.  Used with the TppPDFPage Object. }

  {TppPDFFont.IsEmbedded

    Determines whether the font should be embedded inside the PDF document or
    not.}

  {TppPDFFont.UseSubset

    If the font is embedded, determines whether a subset of the font file should
    be used rather than the entire font.}

  {@TppPDFFont.Font

    Reference to the TFont object being used to create the PDF Font object.
    This is the Delphi representation of the font in use. }

  {TppPDFFont.FontType

    Type of the font being used.  The three types of fonts supported are Type1
    or native Adobe fonts built into the reader, ANSI TrueType compatible fonts
    containing only 255 character glyphs, and Unicode TrueType compatible fonts
    (Type0).}

  {@TppPDFFont.FontName

    Name of the Font in use, processed so Adobe PDF can read it.  NOTE:  All
    font names must be processed throught the ppPDFUtils.ProcessFontName
    routine.  There are four options for a given font name in PDF:

      - FontName
      - FontName,Bold
      - FontName,Italic
      - FontName,BoldItalic

    All font names must be in lower caps as well.  }

  {TppPDFFont.RawFontName

    Name of the font used in its original form (spaces included).  Useful when
    comparing a TFont object to a TppPDFFont object.}

  {@TppPDFFont.TextMetric

    Reference to the TEXTMETRIC structure in the Windows API.  This structure
    contains basic information about a physical font.  For more information on
    the TextMetric structure, see the Windows SDK help. }

   {@TppPDFFont.CharList

     Stringlist containing all characters used in the exported document.  Each
     character represents one line in the StringList.}

  TppPDFFont = class(TppPDFObject)
    private
      FFont: TFont;
      FFontName: String;
      FRawFontName: String;
      FFontType: TppPDFFontType;
      FIsUsed: Boolean;
      FIsEmbedded: Boolean;
      FUseSubset: Boolean;
      FTempFontStream: TMemoryStream;
      FTextMetric: TTextMetricA;
      FFontDescriptor: TppPDFFontDescriptor;
      FFontWidths: TppPDFFontWidths;
      FFontEncoding: TppPDFEncoding;
      FCIDFont: TppPDFFont;
      FCharList: TStringList;
      FPDFXRef: TObject;
      FCompressionLevel: TppCompressionLevel;

      procedure SetFont(const Value: TFont);
      procedure SetFontName(const Value: String);
      procedure SetFontType(const Value: TppPDFFontType);
      procedure SetTextMetric(const Value: TTextMetricA);
      procedure SetFontDescriptor(const Value: TppPDFFontDescriptor);
      procedure SetFontWidths(const Value: TppPDFFontWidths);
      procedure SetFontEncoding(const Value: TppPDFEncoding);
      procedure SetCIDFont(const Value: TppPDFFont);

      //Font Dictionaries
      procedure WriteCIDFontDictionary;
      procedure WriteTrueTypeFontDictionary;
      procedure WriteType0FontDictionary;
      procedure WriteType1FontDictionary;

      //Font Sub-Dictionaries
      procedure CreateFontEncoding;
      procedure CreateFontDescriptor;

    public
      constructor Create; override;
      destructor Destroy; override;

      procedure SaveFont(aPosition: Integer);
      procedure Write(aOutputStream: TStream; aReferenceNumber: Integer); override;

      property IsUsed: Boolean read FIsUsed write FIsUsed;
      property IsEmbedded: Boolean read FIsEmbedded write FIsEmbedded;
      property UseSubset: Boolean read FUseSubset write FUseSubset;
      property Font: TFont read FFont write SetFont;
      property FontName: String read FFontName write SetFontName;
      property RawFontName: String read FRawFontName write FRawFontName;
      property FontType: TppPDFFontType read FFontType write SetFontType;
      property TextMetric: TTextMetricA read FTextMetric write SetTextMetric;
      property FontDescriptor: TppPDFFontDescriptor read FFontDescriptor write SetFontDescriptor;
      property FontWidths: TppPDFFontWidths read FFontWidths write SetFontWidths;
      property FontEncoding: TppPDFEncoding read FFontEncoding write SetFontEncoding;
      property CIDFont: TppPDFFont read FCIDFont write SetCIDFont;
      property CharList: TStringList read FCharList;
      property PDFXRef: TObject read FPDFXRef write FPDFXRef;
      property CompressionLevel: TppCompressionLevel read FCompressionLevel write FCompressionLevel;

  end;

implementation

uses
  SysUtils,
  ppPDFXRef,
  ppPDFFontFile;

{@TppPDFFont.Create

  Creates a new Font object. }

constructor TppPDFFont.Create;
begin
  inherited;

  FFont := TFont.Create;
  FIsUsed := False;
  FFontType := pfTrueType;
  FTempFontStream := TMemoryStream.Create;

  FFontDescriptor := nil;
  FFontWidths := nil;
  FFontEncoding := nil;
  FCIDFont := nil;

  FCharList := TStringList.Create;
  FCharList.CaseSensitive := True;

end;

{@TppPDFFont.Destroy

  Automatically called when a TppPDFFont object is freed.  Do not call this
  method directly.  Instead call the Free routine. }

destructor TppPDFFont.Destroy;
begin
  FCharList.Free;
  FFont.Free;
  FTempFontStream.Free;

  inherited;
end;

procedure TppPDFFont.CreateFontEncoding;
begin
  //Create New CID Font Dictionary (if necessary)
  if FFontType = pfType0 then
    begin
      FCIDFont := TppPDFFont.Create;
      FCIDFont.Font := FFont;
      FCIDFont.FontType := pfCID;
      FCIDFont.FontName := FFontName;
      FCIDFont.TextMetric := FTextMetric;
      FCIDFont.IsEmbedded := FIsEmbedded;
      TppPDFXRef(FPDFXRef).AddObject(TppPDFObject(FCIDFont));
    end
  else if (FFontType = pfType1) or (FFontType = pfTrueType) then
    begin
      FFontEncoding := TppPDFEncoding.Create;
      FFontEncoding.Font := FFont;
      TppPDFXRef(PDFXRef).AddObject(TppPDFObject(FFontEncoding));
    end;

end;

procedure TppPDFFont.CreateFontDescriptor;
var
  lFontFile: TppPDFFontFile;
begin

  if (FFontType = pfTrueType) or (FFontType = pfType0) then
    begin
      //Create New Font Descriptor
      FFontDescriptor := TppPDFFontDescriptor.Create;
      FFontDescriptor.Font := FFont;
      FFontDescriptor.FontName := FFontName;
      FFontDescriptor.TextMetric := FTextMetric;
      FFontDescriptor.EmbedFonts := FIsEmbedded;
      TppPDFXRef(PDFXRef).AddObject(TppPDFObject(FFontDescriptor));

      //Create New Font Widths array
      FFontWidths := TppPDFFontWidths.Create;
      FFontWidths.Font := FFont;
      FFontWidths.FontType := FFontType;
      FFontWidths.TextMetric := FTextMetric;
      TppPDFXRef(PDFXRef).AddObject(TppPDFObject(FFontWidths));

      //Create New Font File if necessary
      if FIsEmbedded then
        begin
          lFontFile := TppPDFFontFile.Create;
          lFontFile.Font := FFont;
          lFontFile.FontType := FFontType;
          lFontFile.CompressionLevel := FCompressionLevel;
          lFontFile.UseSubset := FUseSubset;
          TppPDFXRef(PDFXRef).AddObject(TppPDFObject(lFontFile));
          FFontDescriptor.FontFile := lFontFile;
        end;
    end;

end;

procedure TppPDFFont.WriteCIDFontDictionary;
begin
  WriteMSLine(FTempFontStream, IntToStr(ReferenceNumber) + ' 0 obj');
  WriteMSLine(FTempFontStream, '<< /Type /Font');
  WriteMSLine(FTempFontStream, '/Subtype /CIDFontType2');
  WriteMSLine(FTempFontStream, '/BaseFont /'+ FontName);
  WriteMSLine(FTempFontStream, '/CIDSystemInfo <<');
  WriteMSLine(FTempFontStream, '/Registry (Adobe)');
  WriteMSLine(FTempFontStream, '/Ordering (WinCharSetFFFF)');
  WriteMSLine(FTempFontStream, '/Supplement 0 >>');
  WriteMSLine(FTempFontStream, '/FontDescriptor ' + IntToStr(ReferenceNumber + 1) + ' 0 R');
  WriteMSLine(FTempFontStream, '/W ' + IntToStr(ReferenceNumber + 2) + ' 0 R');
  WriteMSLine(FTempFontStream, '/DW 1000');
  WriteMSLine(FTempFontStream, '/CIDToGIDMap /Identity');
  WriteMSLine(FTempFontStream, '>>');
  WriteMSLine(FTempFontStream, 'endobj');

end;

{TppPDFFont.CreateTrueTypeFont

  Write all font information to the temporary stream. }

procedure TppPDFFont.WriteTrueTypeFontDictionary;
begin
  WriteMSLine(FTempFontStream, IntToStr(ReferenceNumber) + ' 0 obj');
  WriteMSLine(FTempFontStream, '<< /Type /Font');
  WriteMSLine(FTempFontStream, '/Subtype /TrueType');
  WriteMSLine(FTempFontStream, '/Name /' + FontName);
  WriteMSLine(FTempFontStream, '/BaseFont /' + FontName);
  WriteMSLine(FTempFontStream, '/FirstChar ' + IntToStr(Integer(FTextMetric.tmFirstChar)));
  WriteMSLine(FTempFontStream, '/LastChar ' + IntToStr(Integer(FTextMetric.tmLastChar)));
  WriteMSLine(FTempFontStream, '/FontDescriptor ' + IntToStr(ReferenceNumber + 2) + ' 0 R');
  WriteMSLine(FTempFontStream, '/Widths ' + IntToStr(ReferenceNumber + 3) + ' 0 R');
  WriteMSLine(FTempFontStream, '/Encoding ' + IntToStr(ReferenceNumber + 1) + ' 0 R');
  WriteMSLine(FTempFontStream, '>>');
  WriteMSLine(FTempFontStream, 'endobj');

end;

{TppPDFFont.CreateType0Font }

procedure TppPDFFont.WriteType0FontDictionary;
begin
  WriteMSLine(FTempFontStream, IntToStr(ReferenceNumber) + ' 0 obj');
  WriteMSLine(FTempFontStream, '<< /Type /Font');
  WriteMSLine(FTempFontStream, '/Subtype /Type0');
  WriteMSLine(FTempFontStream, '/BaseFont /' + FontName + '-WinCharSetFFFF');
  WriteMSLine(FTempFontStream, '/Encoding /Identity-H');
  WriteMSLine(FTempFontStream, '/DescendantFonts [' + IntToStr(ReferenceNumber + 1) + ' 0 R]');
  //WriteMSLine(FTempFontStream, '/ToUnicode /Identity-H'); //TODO
  WriteMSLine(FTempFontStream, '>>');
  WriteMSLine(FTempFontStream, 'endobj');

end;

{TppPDFFont.CreateType1Font }

procedure TppPDFFont.WriteType1FontDictionary;
begin
  WriteMSLine(FTempFontStream, IntToStr(ReferenceNumber) + ' 0 obj');
  WriteMSLine(FTempFontStream, '<< /Type /Font');
  WriteMSLine(FTempFontStream, '/Subtype /Type1');
  WriteMSLine(FTempFontStream, '/Name /' + FontName);
  WriteMSLine(FTempFontStream, '/BaseFont /' + FontName);
  WriteMSLine(FTempFontStream, '/Encoding ' + IntToStr(ReferenceNumber + 1) + ' 0 R');
  WriteMSLine(FTempFontStream, '>>');
  WriteMSLine(FTempFontStream, 'endobj');

end;

{@TppPDFFont.SaveFont

  Copies the TppPDFFont object from the internal temporary memory stream to the
  main device file stream.  Call once all pages have been generated. }

procedure TppPDFFont.SaveFont(aPosition: Integer);
begin
  ByteOffset := aPosition;

  FTempFontStream.Position := 0;
  OutputStream.CopyFrom(FTempFontStream, FTempFontStream.Size);

  if FCIDFont <> nil then
    FCIDFont.SaveFont(OutputStream.Position);

  if FFontDescriptor <> nil then
    begin
      FFontDescriptor.CharList := FCharList;
      FFontDescriptor.SaveFontDescriptor(OutputStream.Position);
    end;

  if FFontWidths <> nil then
    begin
      FFontWidths.CharList := FCharList;
      FFontWidths.SaveFontWidths(OutputStream.Position);
    end;

  if FFontEncoding <> nil then
    FFontEncoding.SaveEncoding(OutputStream.Position);

end;

procedure TppPDFFont.SetCIDFont(const Value: TppPDFFont);
begin
  FCIDFont := Value;
end;

procedure TppPDFFont.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TppPDFFont.SetFontDescriptor(const Value: TppPDFFontDescriptor);
begin
  FFontDescriptor := Value;
end;

procedure TppPDFFont.SetFontEncoding(const Value: TppPDFEncoding);
begin
  FFontEncoding := Value;
end;

procedure TppPDFFont.SetFontName(const Value: String);
begin
  FFontName := Value;
end;

procedure TppPDFFont.SetFontType(const Value: TppPDFFontType);
begin
  FFontType := Value;
end;

procedure TppPDFFont.SetFontWidths(const Value: TppPDFFontWidths);
begin
  FFontWidths := Value;
end;

procedure TppPDFFont.SetTextMetric(const Value: TTextMetricA);
begin
  FTextMetric := Value;
end;

{@TppPDFFont.Write

  Write instructions in PDF code to the PDF File Stream to create the Font
  Object. }

procedure TppPDFFont.Write(aOutputStream: TStream; aReferenceNumber: Integer);
begin
  inherited;

  case FFontType of
    pfType0: WriteType0FontDictionary;
    pfType1: WriteType1FontDictionary;
    pfTrueType: WriteTrueTypeFontDictionary;
    pfCID: WriteCIDFontDictionary;
  end;

  //Create a PDF encoding object for ANSI encoding or a CID font object for Unicode encoding.
  CreateFontEncoding;

  //Create the font descriptor object, font widths object, and font file object.
  CreateFontDescriptor;

end;


end.
