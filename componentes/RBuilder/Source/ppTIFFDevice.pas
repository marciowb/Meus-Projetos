{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2009                    BBBBB   }

unit ppTIFFDevice;

interface

uses
  Windows,
  Classes,
  Graphics,
  ppImageDevice;

type

  TppTIFFCompressionType = (tcLZW, tcCCITTG4);

  TppTIFFDevice = class(TppBMPDevice)
  private
    FCompressionType: TppTIFFCompressionType;

    procedure WriteBitmapToTIFFLZW(aBitmap: TBitmap; aFileName: String);
    procedure WriteBitmapToTIFFCCITTG4(aBitmap: TBitmap; aFileName: String);

  protected
    procedure SaveImageToFile(aFileName: String); override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    class function DefaultExt: String; override;
    class function DefaultExtFilter: String; override;
    class function DeviceDescription(aLanguageIndex: Longint): String; override;
    class function DeviceName: String; override;

    property CompressionType: TppTIFFCompressionType read FCompressionType write FCompressionType;

  end;

implementation

uses
  SysUtils,
  ppDevice,
  LibTiffDelphi;

{******************************************************************************
 *
 **  TIFF Device
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{TppTIFFDevice.Create}

constructor TppTIFFDevice.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FCompressionType := tcLZW;

end;

{------------------------------------------------------------------------------}
{TppTIFFDevice.Destroy}

destructor TppTIFFDevice.Destroy;
begin

  inherited;
end;

{------------------------------------------------------------------------------}
{TppTIFFDevice.DefaultExt}

class function TppTIFFDevice.DefaultExt: String;
begin
  Result := 'tif';

end;

{------------------------------------------------------------------------------}
{TppTIFFDevice.DefaultExtFilter}

class function TppTIFFDevice.DefaultExtFilter: String;
begin
  Result := 'TIFF (*.tif;*.tiff)|*.tif;*.tiff';

end;

{------------------------------------------------------------------------------}
{TppTIFFDevice.DeviceDescription}

class function TppTIFFDevice.DeviceDescription(aLanguageIndex: Longint): String;
begin
  Result := 'TIFF File';

end;

{------------------------------------------------------------------------------}
{TppTIFFDevice.DeviceName}

class function TppTIFFDevice.DeviceName: String;
begin
  Result := 'TIFF';

end;

{------------------------------------------------------------------------------}
{TppTIFFDevice.SaveImageToFile}

procedure TppTIFFDevice.SaveImageToFile(aFileName: String);
begin
  if CompressionType = tcLZW then
    begin
      Bitmap.PixelFormat := pf24bit;
      WriteBitmapToTIFFLZW(Bitmap, aFileName);
    end
  else
    begin
      Bitmap.PixelFormat := pf1bit;
      WriteBitmapToTIFFCCITTG4(Bitmap, aFileName);
    end;

end;

procedure TppTIFFDevice.WriteBitmapToTIFFCCITTG4(aBitmap: TBitmap; aFileName: String);
var
  lOpenTiff: PTIFF;
  liRowSize: Integer;
  liRowsPerStrip: Integer;
  lStripMemory: Pointer;
  liStripIndex: Integer;
  liStripRowOffset: Integer;
  liStripRowCount: Integer;
  lmb: PByte;
  lny: Longword;
begin

  liRowSize := ((aBitmap.Width  + 7) div 8);
  liRowsPerStrip := ((256 * 1024) div liRowSize);

  if liRowsPerStrip > aBitmap.Height then
    liRowsPerStrip := aBitmap.Height
  else if liRowsPerStrip = 0 then
    liRowsPerStrip := 1;

  lStripMemory := GetMemory(liRowsPerStrip * liRowSize);
  lOpenTiff := TIFFOpen(AnsiString(aFilename), AnsiString('w'));

  if lOpenTiff = nil then
    begin
      FreeMemory(lStripMemory);
      raise Exception.Create('Unable to create file ''' + aFilename + '''');
    end;

  TIFFSetField(lOpenTiff, TIFFTAG_IMAGEWIDTH, aBitmap.Width);
  TIFFSetField(lOpenTiff, TIFFTAG_IMAGELENGTH, aBitmap.Height);
  TIFFSetField(lOpenTiff, TIFFTAG_PHOTOMETRIC, PHOTOMETRIC_MINISBLACK);
  TIFFSetField(lOpenTiff, TIFFTAG_SAMPLESPERPIXEL, 1);
  TIFFSetField(lOpenTiff, TIFFTAG_BITSPERSAMPLE, 1);
  TIFFSetField(lOpenTiff, TIFFTAG_PLANARCONFIG, PLANARCONFIG_CONTIG);
  TIFFSetField(lOpenTiff, TIFFTAG_COMPRESSION, COMPRESSION_CCITTFAX4);
  TIFFSetField(lOpenTiff, TIFFTAG_ROWSPERSTRIP, liRowsPerStrip);
  liStripIndex := 0;
  liStripRowOffset := 0;

  while liStripRowOffset < aBitmap.Height do
    begin
      liStripRowCount := liRowsPerStrip;
      if liStripRowCount > aBitmap.Height - liStripRowOffset then
        liStripRowCount := aBitmap.Height - liStripRowOffset;

      lmb := lStripMemory;
      for lny := liStripRowOffset to liStripRowOffset + liStripRowCount - 1 do
        begin
          CopyMemory(lmb, aBitmap.ScanLine[lny], liRowSize);
          Inc(lmb, liRowSize);
        end;

      if TIFFWriteEncodedStrip(lOpenTiff, liStripIndex, lStripMemory, liStripRowCount * liRowSize) = -1 then
        begin
          TIFFClose(lOpenTiff);
          FreeMemory(lStripMemory);
          raise Exception.Create('Failed to write ''' + aFilename + '''');
        end;

      Inc(liStripIndex);
      Inc(liStripRowOffset, liStripRowCount);
    end;

  TIFFClose(lOpenTiff);
  FreeMem(lStripMemory);

end;

procedure TppTIFFDevice.WriteBitmapToTIFFLZW(aBitmap: TBitmap; aFileName: String);
var
  lOpenTiff: PTIFF;
  liRowsPerStrip: Integer;
  lStripMemory: Pointer;
  liStripIndex: Integer;
  liStripRowOffset: Integer;
  liStripRowCount: Integer;
  lma: PByte;
  lmb: PByte;
  lnx: Longword;
  lny: Longword;
begin

  liRowsPerStrip := ((256 * 1024) div (aBitmap.Width * 3));

  if liRowsPerStrip > aBitmap.Height then
    liRowsPerStrip := aBitmap.Height
  else if liRowsPerStrip = 0 then
    liRowsPerStrip := 1;

  lStripMemory := GetMemory(liRowsPerStrip * aBitmap.Width * 3);
  lOpenTiff := TIFFOpen(AnsiString(aFilename), AnsiString('w'));

  if lOpenTiff = nil then
    begin
      FreeMemory(lStripMemory);
      raise Exception.Create('Unable to create file ''' + Filename + '''');
    end;

  TIFFSetField(lOpenTiff, TIFFTAG_IMAGEWIDTH, aBitmap.Width);
  TIFFSetField(lOpenTiff, TIFFTAG_IMAGELENGTH, aBitmap.Height);
  TIFFSetField(lOpenTiff, TIFFTAG_PHOTOMETRIC, PHOTOMETRIC_RGB);
  TIFFSetField(lOpenTiff, TIFFTAG_SAMPLESPERPIXEL, 3);
  TIFFSetField(lOpenTiff, TIFFTAG_BITSPERSAMPLE, 8);
  TIFFSetField(lOpenTiff, TIFFTAG_PLANARCONFIG, PLANARCONFIG_CONTIG);
  TIFFSetField(lOpenTiff, TIFFTAG_COMPRESSION, COMPRESSION_LZW);
  TIFFSetField(lOpenTiff, TIFFTAG_PREDICTOR, 2);
  TIFFSetField(lOpenTiff, TIFFTAG_ROWSPERSTRIP, liRowsPerStrip);
  liStripIndex := 0;
  liStripRowOffset := 0;

  while liStripRowOffset < aBitmap.Height do
    begin
      liStripRowCount := liRowsPerStrip;
      if liStripRowCount > aBitmap.Height - liStripRowOffset then
        liStripRowCount := aBitmap.Height - liStripRowOffset;

      lmb := lStripMemory;
      for lny := liStripRowOffset to liStripRowOffset + liStripRowCount - 1 do
        begin
          lma := aBitmap.ScanLine[lny];
          for lnx := 0 to aBitmap.Width-1 do
            begin
              lmb^ := PByte(Cardinal(lma) + 2)^;
              Inc(lmb);
              lmb^ := PByte(Cardinal(lma) + 1)^;
              Inc(lmb);
              lmb^ := PByte(Cardinal(lma) + 0)^;
              Inc(lmb);
              if aBitmap.PixelFormat = pf24bit then
                Inc(lma, 3)
              else
                Inc(lma, 4);
            end;
        end;

      if TIFFWriteEncodedStrip(lOpenTiff, liStripIndex, lStripMemory, liStripRowCount * aBitmap.Width * 3) = 0 then
      begin
        TIFFClose(lOpenTiff);
        FreeMemory(lStripMemory);
        raise Exception.Create('Failed to write ''' + aFilename + '''');
      end;

      Inc(liStripIndex);
      Inc(liStripRowOffset, liStripRowCount);
    end;

  TIFFClose(lOpenTiff);
  FreeMem(lStripMemory);

end;

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization
  ppRegisterDevice(TppTIFFDevice);

finalization
  ppUnRegisterDevice(TppTIFFDevice);

end.
