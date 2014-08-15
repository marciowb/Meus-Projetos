{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2009                    BBBBB   }

unit ppWICDevice;

interface

uses
  Graphics,
  Classes,
  ppDevice,
  ppImageDevice,
  ppFileUtils,
  ActiveX,
  WinCodec;

type

  TppWicImage = class;

  {@TppWICDevice

    Ancestor File device for WIC (Windows Imaging Component) supported images.
    Descendents are only supported for Delphi 2010 or later.}

  {@TppWICDevice.WIC

    Provides access to the TppWICImage object being exported. }

  TppWICDevice = class(TppBMPDevice)
  private
    FWIC: TWICImage;

  protected
    procedure SaveImageToFile(aFileName: String); override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    property WIC: TWICImage read FWIC;

  end;

  {@TppWICTIFFDevice

    File device used to export each page of a report as a separate TIFF
    image (*.tif, *.tiff).}

  TppWICTIFFDevice = class(TppWICDevice)
  public
    constructor Create(aOwner: TComponent); override;

    class function DefaultExt: String; override;
    class function DefaultExtFilter: String; override;
    class function DeviceDescription(aLanguageIndex: Longint): String; override;
    class function DeviceName: String; override;

  end;

  TppTiffCompressionType = (tcDontCare, tcNone, tcCCITT3, tcCCITT4, tcLZW, tcRLE, tcZip, tcLZWHDifferencing);

  {Extends TWicimage to allow saving compressed tiff}
  TppWICImage = class(TWICImage)
  private
    FTiffCompressionType: TppTiffCompressionType;

  public
    constructor Create; override;

    procedure SaveToStream(aStream: TStream); override;

    property TiffCompressionType: TppTiffCompressionType read FTiffCompressionType write FTiffCompressionType;

  end;

implementation

uses
  Variants;

{******************************************************************************
 *
 **  WIC Device
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{TppWICDevice.Create}

constructor TppWICDevice.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FWIC := TppWICImage.Create;

end;

{------------------------------------------------------------------------------}
{TppWICDevice.Destroy}

destructor TppWICDevice.Destroy;
begin
  FWIC.Free;
  FWIC := nil;

  inherited;
end;

{------------------------------------------------------------------------------}
{TppWICDevice.SaveImageToFile}

procedure TppWICDevice.SaveImageToFile(aFileName: String);
begin
  FWIC.Assign(Bitmap);
  FWIC.SaveToFile(aFileName);

end;

{******************************************************************************
 *
 **  WIC TIFF Device
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{TppWICTIFFDevice.Create}

constructor TppWICTIFFDevice.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  WIC.ImageFormat := wifTiff;

end;

{------------------------------------------------------------------------------}
{TppWICTIFFDevice.DefaultExt}

class function TppWICTIFFDevice.DefaultExt: String;
begin
  Result := 'tif';

end;

{------------------------------------------------------------------------------}
{TppWICTIFFDevice.DefaultExtFilter}

class function TppWICTIFFDevice.DefaultExtFilter: String;
begin
  Result := 'TIFF (*.tif;*.tiff)|*.tif;*.tiff';

end;

{------------------------------------------------------------------------------}
{TppWICTIFFDevice.DeviceDescription}

class function TppWICTIFFDevice.DeviceDescription(aLanguageIndex: Longint):
    String;
begin
  Result := 'TIFF File';

end;

{------------------------------------------------------------------------------}
{TppWICTIFFDevice.DeviceName}

class function TppWICTIFFDevice.DeviceName: String;
begin
  Result := 'TIFF';

end;


{******************************************************************************
 *
 **  WIC Image Descendent
 *
{******************************************************************************}

constructor TppWICImage.Create;
begin
  inherited;

  TiffCompressionType := tcNone;

end;

procedure TppWicImage.SaveToStream(aStream: TStream);
var
  lEncoder: IWICBitmapEncoder;
  lFrame: IWICBitmapFrameEncode;
  lPropertyBag: IPropertyBag2;
  lStreamAdapter: TStreamAdapter;
  lPixelFormat: TGUID;
  lStream: IWICStream;
  lPalette: IWICPalette;
  lWicBitmap: IWicBitmap;
  lPropBagRec: TPropBag2;
  lsTiffCompression: WideString;
  lVariant: Variant;
  lHR: HResult;
begin

  // if not Tiff format, call inherited and exit
  if not(IsEqualGUID(EncoderContainerFormat, GUID_ContainerFormatTiff)) then
    begin
      inherited;
      Exit;
    end;

  // initialize
  aStream.Size := 0;

  lWicBitmap := Self.Handle;

  lStreamAdapter := TStreamAdapter.Create(aStream);
  IUnknown(lStreamAdapter)._AddRef;

  ImagingFactory.CreateStream(lStream);
  lStream.InitializeFromIStream(lStreamAdapter);

  // create encoder for format
  ImagingFactory.CreateEncoder(EncoderContainerFormat, guid_null, lEncoder);

  lEncoder.Initialize(lStream, WICBitmapEncoderNoCache);
  lEncoder.CreateNewFrame(lFrame, lPropertyBag);


  // initialize compression

  FillChar(lPropBagRec, SizeOf(TPropBag2), 0);

  lsTiffCompression := 'TiffCompressionMethod';

  lPropBagRec.pstrName := PWideChar(lsTiffCompression);

  lVariant := VarAsType(FTiffCompressionType, varByte);

  lHR := lPropertyBag.Write(1, @lPropBagRec, @lVariant);

  if not SUCCEEDED(lHR) then
    raise EInvalidGraphicOperation.Create('TppWicImage.SaveToStream, IPropertyBag.Write failed.');

  lFrame.Initialize(lPropertyBag);

  // pixel format
  lWicBitmap.GetPixelFormat(lPixelFormat);
  lFrame.SetPixelFormat(lPixelFormat);

  // size
  lFrame.SetSize(Width, Height);

  // palette
  ImagingFactory.CreatePalette(lPalette);
  lWicBitmap.CopyPalette(lPalette);
  lFrame.SetPalette(lPalette);

  // write
  lFrame.WriteSource(lWicBitmap, nil);

  // commit
  lFrame.Commit;
  lEncoder.Commit;

end;

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}


initialization

  ppRegisterDevice(TppWICTIFFDevice);

finalization

  ppUnRegisterDevice(TppWICTIFFDevice);

end.
