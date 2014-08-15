{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2003                    BBBBB   }

unit ppPDFContent;

interface

{$DEFINE COMPRESS}            {remove the 'x' to enable content compression}
{$DEFINE ENCRYPT}             {remove the 'x' to enable content encryption}

uses
  Classes,
  SysUtils,
  ppPDFObject,
  ppZLib;

type

  {@TppPDFContent

    Content stream object for each page in a PDF file.  The content stream holds
    all rendering information for the PDF page objects.  Basically anything that
    is drawn to a PDF page is instructed to do so in the Content Stream. }

  {@TppPDFContent.CompressionLevel

    Defines the compression level of the content stream. }

  {@TppPDFContent.MemoryStream

    Reference to the MemoryStream to be compressed and added to the main PDF
    FileStream. }

  TppPDFContent = class(TppPDFObject)
    private
      FCompressionLevel: TppCompressionLevel;
      FEndPosition: Integer;
      FLengthPosition: Integer;
      FMemoryStream: TMemoryStream;
      FStartPosition: Integer;

      procedure SetCompressionLevel(const Value: TppCompressionLevel);
      procedure SetMemoryStream(const Value: TMemoryStream);

    public
      constructor Create; override;

      procedure EndContentStream;
      procedure StartContentStream;
      procedure Write(aOutputStream: TStream; aReferenceNumber: Integer); override;

      property CompressionLevel: TppCompressionLevel read FCompressionLevel write SetCompressionLevel;
      property MemoryStream: TMemoryStream read FMemoryStream write SetMemoryStream;

  end;

implementation

uses
  ppPDFUtils;

constructor TppPDFContent.Create;
begin
  inherited Create;

  FEndPosition := 0;
  FLengthPosition := 0;
  FStartPosition := 0;

end;

{@TppPDFContent.EndContentStream

  Call this procedure to finalize the Content stream for the current page. }

procedure TppPDFContent.EndContentStream;
var
  liMarkPosition: Integer;
  liStreamSize: Integer;
begin

  {$IFDEF COMPRESS}
    TppPDFUtils.CompressStream(FMemoryStream, CompressionLevel);
  {$ENDIF}

  {$IFDEF ENCRYPT}
    TppPDFUtils.EncryptStream(FMemoryStream, EncryptionKey, ReferenceNumber, 0);
  {$ENDIF}

  FMemoryStream.SaveToStream(OutputStream);

  FEndPosition := OutputStream.Position;

  WriteLine('');          {Line break after stream ends}
  WriteLine('endstream');
  WriteLine('endobj');

  {Calculate and insert stream length}
  liStreamSize := FEndPosition - FStartPosition;
  liMarkPosition := OutputStream.Position;
  OutputStream.Seek(FLengthPosition, 0);
  WriteMem(IntToStr(liStreamSize));
  OutputStream.Seek(liMarkPosition, 0);

end;

procedure TppPDFContent.SetCompressionLevel(const Value: TppCompressionLevel);
begin
  FCompressionLevel := Value;
end;

procedure TppPDFContent.SetMemoryStream(const Value: TMemoryStream);
begin
  FMemoryStream := Value;
end;

{@TppPDFContent.StartContentStream

  Call this procedure to begin a content stream for the current page.  After
  this method is called, all drawcommands for that page may be written to the
  PDF file. }

procedure TppPDFContent.StartContentStream;
begin

  WriteLine(IntToStr(ReferenceNumber) + ' 0 obj');

  WriteMem('<< /Length ');
  FLengthPosition := OutputStream.Position;
  WriteLine('         ');

  {$IFDEF COMPRESS}
    WriteLine('/Filter /FlateDecode');
  {$ENDIF}
    
  WriteLine('>>');
  WriteLine('stream');

  FStartPosition := OutputStream.Position;

end;

{TppPDFContent.Write }

procedure TppPDFContent.Write(aOutputStream: TStream; aReferenceNumber: Integer);
begin
  inherited;

end;

end.
