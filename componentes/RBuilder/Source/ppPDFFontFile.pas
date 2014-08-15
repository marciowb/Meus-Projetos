{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB   }

unit ppPDFFontFile;

interface

{$DEFINE COMPRESS}            {remove the 'x' to enable content compression}

uses
  Classes,
  Windows,
  Graphics,
  SysUtils,
  ppTypes,
  ppPDFObject,
  ppZLib;

type

  {@TppPDFFontFile }

  {@TppPDFFontFile.CompressionLevel

    Defines the compression level of the font file stream. }

  {@TppPDFFontFile.Font

    Reference to the TFont object being used to create the PDF Font File
    Object.  This is the Delphi representation of the font in use. }

  {TppPDFFontFile.FontType

    The type of the font to be embedded.  Only TrueType and Type0 fonts can be
    inbedded into a PDF file.}

  {TppPDFFontFile.CharList

    Stringlist containing all characters used in the exported document.  Each
    character represents one line in the StringList.}

  {TppPDFFontFile.UseSubset

    Determines whether a subset of the font file should be embedded into the PDF
    document or the entire font file.}

  TppPDFFontFile = class(TppPDFObject)
    private
      FCompressionLevel: TppCompressionLevel;
      FEndPosition: Integer;
      FFileSize: Integer;
      FFont: TFont;
      FFontType: TppPDFFontType;
      FLengthPosition: Integer;
      FStartPosition: Integer;
      FTempFontFileStream: TMemoryStream;
      FFontDataStream: TMemoryStream;
      FCharList: TStringList;
      FUseSubset: Boolean;

      procedure CreateFontFile;
      procedure RetrieveFontData;
      procedure SetCompressionLevel(const Value: TppCompressionLevel);
      procedure SetFont(const Value: TFont);
      procedure SetCharList(const Value: TStringList);

    public
      constructor Create; override;
      destructor Destroy; override;

      procedure SaveFontFile(aPosition: Integer);
      procedure Write(aOutputStream: TStream; aReferenceNumber: Integer); override;

      property CompressionLevel: TppCompressionLevel read FCompressionLevel write SetCompressionLevel;
      property Font: TFont read FFont write SetFont;
      property FontType: TppPDFFontType read FFontType write FFontType;
      property CharList: TStringList read FCharList write SetCharList;
      property UseSubset: Boolean read FUseSubset write FUseSubset;
  end;

implementation

uses
  ppWinEmbedFont,
  ppPDFUtils;

constructor TppPDFFontFile.Create;
begin
  inherited Create;

  FFont := TFont.Create;
  FFontType := pfTrueType;
  FTempFontFileStream := TMemoryStream.Create;
  FFontDataStream := TMemoryStream.Create;
  FUseSubset := True;

  FEndPosition := 0;
  FLengthPosition := 0;
  FStartPosition := 0;

end;

destructor TppPDFFontFile.Destroy;
begin
  FFontDataStream.Free;
  FTempFontFileStream.Free;
  FFont.Free;

  inherited;

end;

procedure TppPDFFontFile.CreateFontFile;
var
  liMarkPosition: Integer;
  liStreamSize: Integer;
begin

  {Retrieve the font data and put it into the FontDataStream}
  RetrieveFontData;

  WriteMSLine(FTempFontFileStream, IntToStr(ReferenceNumber) + ' 0 obj');

  {$IFDEF COMPRESS}
    WriteMSLine(FTempFontFileStream, '<< /Filter /FlateDecode');
  {$ENDIF}

  WriteMSMem(FTempFontFileStream, '/Length ');
  FLengthPosition := FTempFontFileStream.Position;
  WriteMSLine(FTempFontFileStream, '         ');

  {Write the size of the font file stream}
  WriteMSLine(FTempFontFileStream, '/Length1 ' + IntToStr(FFileSize));

  WriteMSLine(FTempFontFileStream, '>>');
  WriteMSLine(FTempFontFileStream, 'stream');

  FStartPosition := FTempFontFileStream.Position;

  {$IFDEF COMPRESS}
    TppPDFUtils.CompressStream(FFontDataStream, CompressionLevel);
  {$ENDIF}

  {Encrypt the font file}
  TppPDFUtils.EncryptStream(FFontDataStream, EncryptionKey, ReferenceNumber, 0);

  FFontDataStream.SaveToStream(FTempFontFileStream);

  FEndPosition := FTempFontFileStream.Position;

  WriteMSMem(FTempFontFileStream, #13#10);   {Line break after stream ends}
  WriteMSLine(FTempFontFileStream, 'endstream');
  WriteMSLine(FTempFontFileStream, 'endobj');

  {Calculate and insert stream length}
  liStreamSize := FEndPosition - FStartPosition;
  liMarkPosition := FTempFontFileStream.Position;
  FTempFontFileStream.Seek(FLengthPosition, 0);
  WriteMSMem(FTempFontFileStream, IntToStr(liStreamSize));
  FTempFontFileStream.Seek(liMarkPosition, 0);

end;

procedure TppPDFFontFile.RetrieveFontData;
var
  lBitmap: TBitmap;
  lBuffer: PUCHAR;
begin

  lBitmap := TBitmap.Create;
  lBuffer := nil;

  try

    lBitmap.Canvas.Font.Assign(FFont);

    if (UseSubset) then
      FFileSize := ppCreateFontSubset(lBitmap.Canvas.Handle, CharList, lBuffer)
    else
      FFileSize := ppGetFontFile(lBitmap.Canvas.Handle, lBuffer);

    FFontDataStream.Write(lBuffer^, FFileSize);

  finally
    lBitmap.Free;
    FreeMem(lBuffer);
  end;
  
end;

{@TppPDFFontDescriptor.SaveFontFile

  Copies the TppPDFFontFile object from the internal temporary memory
  stream to the main device file stream.  Call once all pages have been
  generated. }

procedure TppPDFFontFile.SaveFontFile(aPosition: Integer);
begin
  CreateFontFile;

  ByteOffset := aPosition;

  FTempFontFileStream.Position := 0;
  OutputStream.CopyFrom(FTempFontFileStream, FTempFontFileStream.Size);
end;

procedure TppPDFFontFile.SetCharList(const Value: TStringList);
begin
  FCharList := Value;
end;

procedure TppPDFFontFile.SetCompressionLevel(const Value: TppCompressionLevel);
begin
  FCompressionLevel := Value;
end;

procedure TppPDFFontFile.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

{TppPDFContent.Write }

procedure TppPDFFontFile.Write(aOutputStream: TStream; aReferenceNumber: Integer);
begin
  inherited;

end;

end.
