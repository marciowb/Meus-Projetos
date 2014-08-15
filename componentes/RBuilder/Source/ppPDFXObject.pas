{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppPDFXObject;

interface

uses
  Classes,
  Graphics,
  ppDevice,
  ppDrwCmd,
  ppPDFObject,
  ppZLib;

type

  {@TppPDFXObject

    This class takes an image object and streams it into a format that can be
    read by a PDF reader.  All XObject streams are compressed for optimization.
    This class will support any image type that descends from the TImage Class. }

  {@TppPDFXObject.CompressionLevel

    Compression level for the images.  The user has the option to compress the
    images in four levels... clNone, clFastest, clDefault, and clMax. }

  {@TppPDFXObject.ScaleImages

    Option to scale images with a smaller control box than the actual size.
    This option reduces image quality when zoomed but preserves space when
    large images need to be resized.  This device will only scale images with
    the following specifications:

     1. Image Width is smaller than its original graphic size (and/or)
        image Height is smaller than its original graphic size.
     2. Stretching has been enabled. }
    
  TppPDFXObject = class(TppPDFObject)
    private
      FCompressionLevel: TppCompressionLevel;
      FBitmap: TBitmap;
      FWidth: Double;
      FName: String;
      FHeight: Double;
      FStretch: Boolean;
      FScaleImages: Boolean;
      FCacheImages: Boolean;
      FTempImageStream: TStream;

      procedure CreateXObject;
      procedure ProcessImageStream(aBitmap: Graphics.TBitmap);
      procedure SetCompressionLevel(const Value: TppCompressionLevel);
      procedure SetScaleImages(const Value: Boolean);

      function CreateScaledImage(aBitmap: Graphics.TBitmap): Graphics.TBitmap;
      function SmallerScale: Boolean;

    public
      destructor Destroy; override;

      procedure SaveXObject(aPosition: Integer);
      procedure Write(aOutputStream: TStream; aReferenceNumber: Integer); override;

      property Bitmap: Graphics.TBitmap read FBitmap write FBitmap;
      property Name: String read FName write FName;
      property Width: Double read FWidth write FWidth;
      property Height: Double read FHeight write FHeight;
      property Stretch: Boolean read FStretch write FStretch;
      property CompressionLevel: TppCompressionLevel read FCompressionLevel write SetCompressionLevel;
      property ScaleImages: Boolean read FScaleImages write SetScaleImages;
      property CacheImages: Boolean read FCacheImages write FCacheImages;

  end;


implementation

uses
  SysUtils,
  Math,
  ppPDFUtils,
  ppUtils,
  Types,
  Windows;


destructor TppPDFXObject.Destroy;
begin
  FTempImageStream.Free;

  SysUtils.DeleteFile(FName + '.tmp');

  inherited;
end;

{TppPDFXObject.CreateXObject

  Creates the entire PDF XObject and writes it to a temporary memory stream to
  later be compressed and written to the main PDF file stream. }
{$WARNINGS OFF}
procedure TppPDFXObject.CreateXObject;
var
  lScaledBitmap: Graphics.TBitmap;
  liEndPosition: Integer;
  liLengthPosition: Integer;
  liStartPosition: Integer;
  liStreamSize: Integer;
begin

  lScaledBitmap := nil;

  try
    {Scale the image if needed}
    if((ScaleImages) and (SmallerScale) and (Stretch)) then
      begin
        lScaledBitmap := CreateScaledImage(FBitmap);
        FBitmap.Assign(lScaledBitmap);
      end;

    TppPDFUtils.WriteLine(FTempImageStream, IntToStr(ReferenceNumber) + ' 0 obj');
    TppPDFUtils.WriteLine(FTempImageStream, '<< /Type /XObject');
    TppPDFUtils.WriteLine(FTempImageStream, '/Subtype /Image');
    TppPDFUtils.WriteLine(FTempImageStream, '/Width ' + IntToStr(FBitmap.Width));
    TppPDFUtils.WriteLine(FTempImageStream, '/Height ' + IntToStr(FBitmap.Height));
    TppPDFUtils.WriteLine(FTempImageStream, '/Filter /FlateDecode');

    if (FBitmap.PixelFormat = pf1bit) then
      begin
        TppPDFUtils.WriteLine(FTempImageStream, '/ColorSpace /DeviceGray');
        TppPDFUtils.WriteLine(FTempImageStream, '/BitsPerComponent 1');
      end
    else if (FBitmap.PixelFormat = pf4bit) then
      begin
        TppPDFUtils.WriteLine(FTempImageStream, '/ColorSpace /DeviceGray');
        TppPDFUtils.WriteLine(FTempImageStream, '/BitsPerComponent 8');
      end
    else //pf8bit, pf15bit, pf16bit, pf24bit, pf32bit, pfCustom, pfDevice
      begin
        TppPDFUtils.WriteLine(FTempImageStream, '/ColorSpace /DeviceRGB');
        TppPDFUtils.WriteLine(FTempImageStream, '/BitsPerComponent 8');
      end;

    TppPDFUtils.WriteMem(FTempImageStream, '/Length ');
    liLengthPosition := FTempImageStream.Position;
    TppPDFUtils.WriteLine(FTempImageStream, '         ');
    TppPDFUtils.WriteLine(FTempImageStream, '>>');

    {Start Stream}
    TppPDFUtils.WriteLine(FTempImageStream, 'stream');

    liStartPosition := FTempImageStream.Position;

    {Write image byte stream to file}
    ProcessImageStream(FBitmap);

  finally
    lScaledBitmap.Free;

  end;

  TppPDFUtils.WriteMem(FTempImageStream, #13#10);

  liEndPosition := FTempImageStream.Position;

  TppPDFUtils.WriteLine(FTempImageStream, 'endstream');
  TppPDFUtils.WriteLine(FTempImageStream, 'endobj');

  {Calculate and insert stream length}
  liStreamSize := liEndPosition - liStartPosition;
  FTempImageStream.Seek(liLengthPosition, 0);
  TppPDFUtils.WriteMem(FTempImageStream, IntToStr(liStreamSize));

end;
{$WARNINGS ON}

{TppPDFXObject.ProcessImageStream }

procedure TppPDFXObject.ProcessImageStream(aBitmap: Graphics.TBitmap);
var
  lBuffer: array of Byte;
  liBufferPos: Integer;
  liHeightPixels: Integer;
  liIndex: Integer;
  lRow: Pointer;
  liRows: Integer;
  lTemp: Byte;
  lTempMemoryStream: TMemoryStream;
  liWidthBytes: Integer;
  liWidthPixels: Integer;
begin

  liHeightPixels := aBitmap.Height;

  if (aBitmap.PixelFormat = pf1bit) then
    begin
      liWidthPixels := Ceil(aBitmap.Width / 8);
      liWidthBytes := liWidthPixels;

    end
  else if (aBitmap.PixelFormat = pf4bit) then
    begin
      aBitmap.PixelFormat := pf8bit;  //convert to 8 bit for greyscale images to save space
      liWidthPixels := aBitmap.Width;
      liWidthBytes := liWidthPixels;
    end
  else //pf8bit, pf15bit, pf16bit, pf24bit, pf32bit, pfCustom, pfDevice
    begin
      aBitmap.PixelFormat := pf24bit;
      liWidthPixels := aBitmap.Width;
      liWidthBytes := liWidthPixels * 3;  {Byte Width: 'rgb' for each pixel}

    end;

  SetLength(lBuffer, liWidthBytes);

  {Create temp memory stream for compression}
  lTempMemoryStream := TMemoryStream.Create;

  try
    for liRows := 0 to liHeightPixels - 1 do
      begin
        lRow := aBitmap.ScanLine[liRows];

        Move(lRow^, Pointer(lBuffer)^, liWidthBytes);

        if (aBitmap.PixelFormat in [pf1bit, pf4bit, pf8bit]) then
          begin

          end
        else //pf15bit, pf16bit, pf24bit, pf32bit, pfCustom, pfDevice
          begin
            {Swap Red and Blue byte for each pixel}
            for liIndex := 0 to liWidthPixels - 1 do
              begin
                liBufferPos := liIndex * 3;
                lTemp := lBuffer[liBufferPos + 2];
                lBuffer[liBufferPos + 2] := lBuffer[liBufferPos];
                lBuffer[liBufferPos] := lTemp;

              end;

          end;

        lTempMemoryStream.Write(lBuffer[0], liWidthBytes);

      end;

    {Compress the image}
    TppPDFUtils.CompressStream(lTempMemoryStream, CompressionLevel);

    {Encrypt the image}
    TppPDFUtils.EncryptStream(lTempMemoryStream, EncryptionKey, ReferenceNumber, 0);
    
    {Save Compressed/Encrypted Image to File Stream}
    lTempMemoryStream.SaveToStream(FTempImageStream);

  finally
    lTempMemoryStream.Free;

  end;

end;

{TppPDFXObject.SaveXObject }

procedure TppPDFXObject.SaveXObject(aPosition: Integer);
begin
  ByteOffset := aPosition;

  FTempImageStream.Position := 0;
  OutputStream.CopyFrom(FTempImageStream, FTempImageStream.Size);

end;

{TppPDFXObject.CreateScaledImage }

function TppPDFXObject.CreateScaledImage(aBitmap: Graphics.TBitmap): Graphics.TBitmap;
var
  liControlHeight: Integer;
  liControlWidth: Integer;
  lImageRect: TRect;
begin

  Result := Graphics.TBitmap.Create;

  liControlHeight := TppPDFUtils.PointsToPixels(Height);
  liControlWidth := TppPDFUtils.PointsToPixels(Width);

  Result.Height := liControlHeight;
  Result.Width := liControlWidth;

  lImageRect := Rect(0, 0, liControlWidth, liControlHeight);

  Result.Canvas.StretchDraw(lImageRect, aBitmap);

end;

{TppPDFXObject.SmallerScale

  Returns True if the control box for the image is smaller than the acutal
  image. }

function TppPDFXObject.SmallerScale: Boolean;
var
  liControlHeight: Integer;
  liControlWidth: Integer;
  liImageHeight: Integer;
  liImageWidth: Integer;
begin

  liControlHeight := TppPDFUtils.PointsToPixels(Height);
  liControlWidth := TppPDFUtils.PointsToPixels(Width);
  liImageHeight := FBitmap.Height;
  liImageWidth := FBitmap.Width;

  Result := False;

  if (liControlHeight < liImageHeight) or (liControlWidth < liImageWidth)  then
    Result := True;

end;

{@TppPDFXObject.Write}

procedure TppPDFXObject.Write(aOutputStream: TStream; aReferenceNumber: Integer);
begin
  inherited;

  if CacheImages then
    FTempImageStream := TMemoryStream.Create
  else
    FTempImageStream := TFileStream.Create(ppGetTempPath + FName + '.tmp', fmCreate or fmOpenReadWrite);

  CreateXObject;

end;

procedure TppPDFXObject.SetCompressionLevel(const Value: TppCompressionLevel);
begin
  FCompressionLevel := Value;
end;

procedure TppPDFXObject.SetScaleImages(const Value: Boolean);
begin
  FScaleImages := Value;
end;


end.
