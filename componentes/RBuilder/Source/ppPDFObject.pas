{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2009                    BBBBB   }

unit ppPDFObject;

interface

uses
  Classes,
  ppPrintr;

type

  {@TppPDFObject

    Ancestor to all "PDF" objects and DrawCommand objects that need to be added
    or drawn to the PDF file.  Every PDF object must have a byte offset defined,
    as well as a unique in-line Reference Number.

    All descendents of this object are able to write to the main PDF Stream
    using the WriteLine and WriteMem routines.  If this is content stream
    information and needs to be compressed later, instructions must be written
    using the WriteMSLine routine.

    If adding a ReportBuilder DrawCommand Object that does not require the
    creation of a PDF object, simply set ByteOffset and ReferenceNumber to 0.
    There are four objects that fall in this category...

     - TppPDFLine
     - TppPDFShape
     - TppPDFText
     - TppPDFImage

    All other TppPDFObject descendents require a Reference number and valid
    byte offset. }

  {@TppPDFObject.ByteOffset

    Offset from the beginning of the PDF File Stream in bytes that the object is
    started. This property is modifyable by any descendent of this class. }

  {@TppPDFObject.OutputStream

    Reference to the main Stream of the File Device.  All PDF instructions
    are eventually written to this Stream.  This property is set when
    the Write routine is called. }

  {@TppPDFObject.Offset

    Public property: Offset from the beginning of the PDF Stream in bytes
    that the object is started.  This property is read only. }

  {@TppPDFObject.ReferenceNumber

    Individual unique number identifying every PDF object in the PDF file.  This
    number is set when the Write routine is called. }
    
  TppPDFObject = class
    private
      FOutputStream: TStream;
      FByteOffset: Integer;
      FEncryptionKey: AnsiString;
      FReferenceNumber: Integer;
      FPrinter: TppPrinter;

      procedure SetByteOffset(const Value: Integer);
      procedure SetPrinter(const Value: TppPrinter);

    protected
      procedure WriteLine(aLine: String);
      procedure WriteMem(aBuffer: String);
      procedure WriteMSLine(aMemoryStream: TMemoryStream; aLine: String);
      procedure WriteMSMem(aMemoryStream: TMemoryStream; aBuffer: String);

      function  ExtToStr(aValue: Extended): String;

      property ByteOffset: Integer read FByteOffset write SetByteOffset;
      property OutputStream: TStream read FOutputStream write FOutputStream;

    public
      constructor Create; virtual;
      
      procedure Write(aOutputStream: TStream; aReferenceNumber: Integer); virtual;

      property EncryptionKey: AnsiString read FEncryptionKey write FEncryptionKey;
      property Offset: Integer read FByteOffset;
      property Printer: TppPrinter read FPrinter write SetPrinter;
      property ReferenceNumber: Integer read FReferenceNumber;

  end;

implementation

uses
  ppPDFUtils,
  ppCharacter,
  SysUtils;

{@TppPDFObject.Create

  Creates a new TppPDFObject }

constructor TppPDFObject.Create;
begin
  FOutputStream := nil;
  FByteOffset := 0;
  FReferenceNumber := 0;
  FEncryptionKey := '';

end;

function TppPDFObject.ExtToStr(aValue: Extended): String;
begin
  Result := FormatFloat('0.0####', aValue);
  Result := StringReplace(Result, DecimalSeparator, '.', []);
end;

procedure TppPDFObject.SetByteOffset(const Value: Integer);
begin
  FByteOffset := Value;
end;

procedure TppPDFObject.SetPrinter(const Value: TppPrinter);
begin
  FPrinter := Value;

end;

{@TppPDFObject.Write

  Begin writing object to the PDF File by defining the main Stream, Object
  Reference Number, and Byte Offset.  No PDF instructions will be generated
  until this routine is called.

  The Write routine must be included to every descendent of this class. }

procedure TppPDFObject.Write(aOutputStream: TStream; aReferenceNumber: Integer);
begin
  FOutputStream := aOutputStream;
  FByteOffset := aOutputStream.Position;

  FReferenceNumber := aReferenceNumber;

  {Start New PDF Object...}

end;

{TppPDFObject.WriteLine

  Writes a line of text to the main Device Stream including the Carrage
  Return and Line Feed characters. }
{$WARNINGS OFF}
procedure TppPDFObject.WriteLine(aLine: String);
begin
  TppPDFUtils.WriteLine(FOutputStream, aLine);

end;

{TppPDFObject.WriteMem

  Writes a line of text to the main Device Stream without the CRLF characters. }

procedure TppPDFObject.WriteMem(aBuffer: String);
begin
  TppPDFUtils.WriteMem(FOutputStream, aBuffer);

end;

{TppPDFObject.WriteMSLine

  Writes a line of text to a given MemoryStream including the CRLF characters.}

procedure TppPDFObject.WriteMSLine(aMemoryStream: TMemoryStream; aLine: String);
begin
  TppPDFUtils.WriteLine(aMemoryStream, aLine);

end;

{TppPDFObject.WriteMSMem

  Writes a line of text to a given MemoryStream without the CRLF characters. }

procedure TppPDFObject.WriteMSMem(aMemoryStream: TMemoryStream; aBuffer: String);
begin
  TppPDFUtils.WriteMem(aMemoryStream, aBuffer);

end;
{$WARNINGS ON}

end.
