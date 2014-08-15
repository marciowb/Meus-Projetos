{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2009                    BBBBB   }

unit ppImageDevice;

interface

{$INCLUDE ppIfDef.pas}

uses
  Classes,
  Graphics,
  SysUtils,
  ppDevice,
  ppFilDev,
  ppGraphicsDevice,
  ppStrUtils,
  ppTypes,
  JPEG
{$IFDEF Delphi11}
  ,GIFImg
{$ELSE}
  ,ppGIFImage
{$ENDIF}
{$IFDEF Delphi12}
  ,PNGImage
{$ENDIF};

type

  {@TppImageDevice

    Abstract ancestor for image export devices.  This class provides the
    base functionality to export each page of a report to a separate image file.

    Descendants include

      - TppBMPDevice
      - TppMetafileDevice
      - TppJPGDevice
      - TppGIFDevice
      - TppPNGDevice (Delphi 2009 and later)

    }

  {@TppImageDevice.Canvas

    Reference to a Canvas object to which the report page will be drawn.
    TppImageDevice descendents must implement the GetCanvas method to return
    a reference to a valid Canvas instance.}

  {@TppImageDevice.ImageFileName

    File name of the image(s) to be exported.  Each page in the report will
    be saved to file using the FileName defined for the report appended with
    an underscore and the page number (ex. MyReport_1.bmp).  To export each page
    with custom file names, implement the OnReceivePage event of the device and
    assign this property manually.}

  {@TppImageDevice.OnSaveImage

    Fires after each page image is saved to file. Used by TppEmail to add
    each page image file as an attachement.}

  {@TppImageDevice.Scale

    Defaults to 1. Use to scale the size of the page images.}

  TppImageDevice = class(TppFileDevice)
  private
    FGraphicsDevice: TppGraphicsDevice;
    FImageFileName: String;
    FOnSaveImage: TppSaveImageEvent;
    FScale: Double;

  protected
    function  CreateOutputStream: TStream; override;
    function  GetCanvas: TCanvas; virtual; abstract;
    procedure InitializeImage(aPage: TppPage); virtual; abstract;
    procedure ProcessFileName(aPage: TppPage); virtual;
    procedure SaveImageToFile(aFileName: String); virtual; abstract;
    procedure SavePageToFile(aPage: TppPage); override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor  Destroy; override;

    procedure ReceivePage(aPage: TppPage); override;

    property Canvas: TCanvas read GetCanvas;
    property ImageFileName: String read FImageFileName write FImageFileName;
    property OnSaveImage: TppSaveImageEvent read FOnSaveImage write FOnSaveImage;
    property Scale: Double read FScale write FScale;

  end;

  {@TppMetafileDevice

    File device used to export each page of a report as a separate Metafile
    image (*.emf, *.wmf).}

  {@TppMetafileDevice.Metafile

    Provides access to the TMetafile object being exported. }

  TppMetafileDevice = class(TppImageDevice)
  private
    FMetafile: TMetafile;
    FMetafileCanvas: TMetafileCanvas;

  protected
    function  GetCanvas: TCanvas; override;
    procedure InitializeImage(aPage: TppPage); override;
    procedure SaveImageToFile(aFileName: String); override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    class function DefaultExt: String; override;
    class function DefaultExtFilter: String; override;
    class function DeviceDescription(aLanguageIndex: Longint): String; override;
    class function DeviceName: String; override;

    property Metafile: TMetafile read FMetafile;

  end;

  {@TppBMPDevice

    File device used to export each page of a report as a separate Bitmap
    image (*.bmp).}

  {@TppBMPDevice.Bitmap

    Provides access to the TBitmap object being exported. }

  TppBMPDevice = class(TppImageDevice)
  private
    FBitmap: TBitmap;

  protected
    function  GetCanvas: TCanvas; override;
    procedure InitializeImage(aPage: TppPage); override;
    procedure SaveImageToFile(aFileName: String); override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor  Destroy; override;

    class function DefaultExt: String; override;
    class function DefaultExtFilter: String; override;
    class function DeviceDescription(aLanguageIndex: Longint): String; override;
    class function DeviceName: String; override;

    property Bitmap: TBitmap read FBitmap;

  end;

  {@TppJPGDevice

    File device used to export each page of a report as a separate JPEG image
    (*.jpg, *.jpeg).}

  {@TppJPGDevice.JPEG

    Provides access to the TJPEGImage object being exported.}

  TppJPGDevice = class(TppBMPDevice)
  private
    FJPEG: TJPEGImage;

  protected
    procedure SaveImageToFile(aFileName: String); override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    class function DefaultExt: String; override;
    class function DefaultExtFilter: String; override;
    class function DeviceDescription(aLanguageIndex: Longint): String; override;
    class function DeviceName: String; override;

    property JPEG: TJPEGImage read FJPEG;

  end;

  {@TppGIFDevice

    File device used to export each page of a report as a separate Gif image
    (*.gif).}

  {@TppGIFDevice.GIF

    Provides access to the TGIFImage object being exported.}

  TppGIFDevice = class(TppBMPDevice)
  private
    FGIF: TGIFImage;

  protected
    procedure SaveImageToFile(aFileName: String); override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    class function DefaultExt: String; override;
    class function DefaultExtFilter: String; override;
    class function DeviceDescription(aLanguageIndex: Longint): String; override;
    class function DeviceName: String; override;

    property GIF: TGIFImage read FGIF;

  end;

  {@TppPNGDevice

    File device used to export each page of a report as a separate PNG image
    (*.png).}

  {@TppPNGDevice.PNG

    Provides access to the TPNGImage object being exported.}
{$IFDEF Delphi12}
  TppPNGDevice = class(TppBMPDevice)
  private
    FPNG: TPNGImage;

  protected
    procedure SaveImageToFile(aFileName: String); override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    class function DefaultExt: String; override;
    class function DefaultExtFilter: String; override;
    class function DeviceDescription(aLanguageIndex: Longint): String; override;
    class function DeviceName: String; override;

    property PNG: TPNGImage read FPNG;

  end;
{$ENDIF}

implementation

{******************************************************************************
 *
 **  Image Device
 *
{******************************************************************************}

constructor TppImageDevice.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FGraphicsDevice := TppGraphicsDevice.Create(aOwner);
  FImageFileName := '';
  FScale := 1;

end;

destructor TppImageDevice.Destroy;
begin
  FGraphicsDevice.Free;
  FGraphicsDevice := nil;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppImageDevice.CreateOutputStream }

function TppImageDevice.CreateOutputStream: TStream;
begin
  Result := nil;

end;

{------------------------------------------------------------------------------}
{ TppImageDevice.CreateOutputStream }

procedure TppImageDevice.ProcessFileName(aPage: TppPage);
var
  liEndPos: Integer;
  lsFileName: String;
begin

  lsFileName := FileName;
  liEndPos := TppStrUtils.PosBack('.', FileName);

  Insert('_' + IntToStr(aPage.PageNo), lsFileName, liEndPos);

  ImageFileName := lsFileName;

end;

{------------------------------------------------------------------------------}
{ TppImageDevice.ReceivePage }

procedure TppImageDevice.ReceivePage(aPage: TppPage);
begin
  ProcessFileName(aPage);

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppImageDevice.SavePageToFile }

procedure TppImageDevice.SavePageToFile(aPage: TppPage);
begin

  InitializeImage(aPage);

  FGraphicsDevice.PageRequest := PageRequest;
  FGraphicsDevice.Canvas := Canvas;
  FGraphicsDevice.Scale := FScale;

  FGraphicsDevice.ReceivePage(aPage);

  SaveImageToFile(ImageFileName);
  if Assigned(FOnSaveImage) then FOnSaveImage(Self, ImageFileName);

end;


{******************************************************************************
 *
 **  Bitmap Device
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppBMPDevice.Create }

constructor TppBMPDevice.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FBitmap := TBitmap.Create;
end;

{------------------------------------------------------------------------------}
{ TppBMPDevice.Destroy }

destructor TppBMPDevice.Destroy;
begin
  FBitmap.Free;
  FBitmap := nil;

  inherited;
end;

{------------------------------------------------------------------------------}
{TppBMPDevice.DefaultExt}

class function TppBMPDevice.DefaultExt: String;
begin
  Result := 'bmp';

end;

{------------------------------------------------------------------------------}
{TppBMPDevice.DefaultExtFilter}

class function TppBMPDevice.DefaultExtFilter: String;
begin
  Result := GraphicFilter(TBitmap);

end;

{------------------------------------------------------------------------------}
{ ppBMPDevice.DeviceDescription}

class function TppBMPDevice.DeviceDescription(aLanguageIndex: Longint): String;
begin
  Result := 'Bitmap File';

end;

{------------------------------------------------------------------------------}
{ ppBMPDevice.DeviceName}

class function TppBMPDevice.DeviceName: String;
begin

  Result := 'BMP';

end;

{------------------------------------------------------------------------------}
{TppBMPDevice.GetCanvas}

function TppBMPDevice.GetCanvas: TCanvas;
begin
  Result := FBitmap.Canvas;

end;

{------------------------------------------------------------------------------}
{TppBMPDevice.InitializeImage}

procedure TppBMPDevice.InitializeImage(aPage: TppPage);
begin
  if FBitmap <> nil then
    begin
      FBitmap.Width := Trunc(aPage.PageDef.spWidth * FScale);
      FBitmap.Height := Trunc(aPage.PageDef.spHeight * FScale);
    end;
end;

{------------------------------------------------------------------------------}
{TppBMPDevice.SaveImageToFile}

procedure TppBMPDevice.SaveImageToFile(aFileName: String);
begin
  FBitmap.SaveToFile(aFileName);

end;

{******************************************************************************
 *
 **  JPEG Device
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{TppJPGDevice.Create}

constructor TppJPGDevice.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FJPEG := TJPEGImage.Create;
end;

{------------------------------------------------------------------------------}
{TppJPGDevice.Destroy}

destructor TppJPGDevice.Destroy;
begin
  FJPEG.Free;
  FJPEG := nil;

  inherited;
end;

{------------------------------------------------------------------------------}
{TppJPGDevice.DefaultExt}

class function TppJPGDevice.DefaultExt: String;
begin
  Result := 'jpg';

end;

{------------------------------------------------------------------------------}
{TppJPGDevice.DefaultExtFilter}

class function TppJPGDevice.DefaultExtFilter: String;
begin
  Result := 'JPEG (*.jpg;*.jpeg;*.jpe;*.jfif)|*.jpg;*.jpeg;*jpe;*jfif';

end;

{------------------------------------------------------------------------------}
{TppJPGDevice.DeviceDescription}

class function TppJPGDevice.DeviceDescription(aLanguageIndex: Longint): String;
begin
  Result := 'JPEG File';

end;

{------------------------------------------------------------------------------}
{TppJPGDevice.DeviceName}

class function TppJPGDevice.DeviceName: String;
begin
  Result := 'JPEG';

end;

{------------------------------------------------------------------------------}
{TppJPGDevice.SaveImageToFile}

procedure TppJPGDevice.SaveImageToFile(aFileName: String);
begin
  FJPEG.Assign(Bitmap);
  FJPEG.SaveToFile(aFileName);

end;

{******************************************************************************
 *
 **  GIF Device
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{TppGIFDevice.Create}

constructor TppGIFDevice.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FGIF := TGIFImage.Create;
end;

{------------------------------------------------------------------------------}
{TppGIFDevice.Destroy}

destructor TppGIFDevice.Destroy;
begin
  FGIF.Free;
  FGIF := nil;

  inherited;
end;

{------------------------------------------------------------------------------}
{TppGIFDevice.DefaultExt}

class function TppGIFDevice.DefaultExt: String;
begin
  Result := 'gif';

end;

{------------------------------------------------------------------------------}
{TppGIFDevice.DefaultExtFilter}

class function TppGIFDevice.DefaultExtFilter: String;
begin
  Result := 'GIF (*.gif)|*.gif';

end;

{------------------------------------------------------------------------------}
{TppGIFDevice.DeviceDescription}

class function TppGIFDevice.DeviceDescription(aLanguageIndex: Longint): String;
begin
  Result := 'GIF File';

end;

{------------------------------------------------------------------------------}
{TppGIFDevice.DeviceName}

class function TppGIFDevice.DeviceName: String;
begin
  Result := 'GIF';

end;

{------------------------------------------------------------------------------}
{TppGIFDevice.SaveImageToFile}

procedure TppGIFDevice.SaveImageToFile(aFileName: String);
begin
  FGIF.Assign(Bitmap);
  FGIF.SaveToFile(aFileName);

end;

{******************************************************************************
 *
 **  Metafile Device
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{TppMetafileDevice.Create}

constructor TppMetafileDevice.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FMetafile := TMetafile.Create;

end;

{------------------------------------------------------------------------------}
{TppMetafileDevice.Destroy}

destructor TppMetafileDevice.Destroy;
begin
  FMetafile.Free;
  FMetafile := nil;

  inherited;
end;

{------------------------------------------------------------------------------}
{TppMetafileDevice.DefaultExt}

class function TppMetafileDevice.DefaultExt: String;
begin
  Result := 'emf';

end;

{------------------------------------------------------------------------------}
{TppMetafileDevice.DefaultExtFilter}

class function TppMetafileDevice.DefaultExtFilter: String;
begin
  Result := GraphicFilter(TMetafile);

end;

{------------------------------------------------------------------------------}
{TppMetafileDevice.DeviceDescription}

class function TppMetafileDevice.DeviceDescription(aLanguageIndex: Longint):String;
begin
  Result := 'Metafile';

end;

{------------------------------------------------------------------------------}
{TppMetafileDevice.DeviceName}

class function TppMetafileDevice.DeviceName: String;
begin
  Result := 'Metafile';

end;

{------------------------------------------------------------------------------}
{TppMetafileDevice.GetCanvas}

function TppMetafileDevice.GetCanvas: TCanvas;
begin
  if FMetafileCanvas = nil then
    FMetafileCanvas := TMetafileCanvas.Create(FMetaFile, 0);

  Result := FMetafileCanvas;

end;

{------------------------------------------------------------------------------}
{TppMetafileDevice.InitializeImage}

procedure TppMetafileDevice.InitializeImage(aPage: TppPage);
begin

  if FMetaFile <> nil then
    begin
      FMetafile.Width := Trunc(aPage.PageDef.spWidth * FScale);
      FMetafile.Height := Trunc(aPage.PageDef.spHeight * FScale);
    end;

end;

{------------------------------------------------------------------------------}
{TppMetafileDevice.SaveImageToFile}

procedure TppMetafileDevice.SaveImageToFile(aFileName: String);
var
  lsFileExt: String;
begin

  lsFileExt := UpperCase(ExtractFileExt(aFileName));

  FMetafile.Enhanced := lsFileExt = 'EMF';

  FMetafileCanvas.Free;  //Freeing the canvas writes to the metafile object
  FMetafileCanvas := nil;

  FMetafile.SaveToFile(aFileName);

end;

{******************************************************************************
 *
 **  PNG Device
 *
{******************************************************************************}
{$IFDEF Delphi12}
{------------------------------------------------------------------------------}
{TppPNGDevice.Create}

constructor TppPNGDevice.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FPNG := TPNGImage.Create;
end;

{------------------------------------------------------------------------------}
{TppPNGDevice.Destroy}

destructor TppPNGDevice.Destroy;
begin
  FPNG.Free;
  FPNG := nil;

  inherited;
end;

{------------------------------------------------------------------------------}
{TppPNGDevice.DefaultExt}

class function TppPNGDevice.DefaultExt: String;
begin
  Result := 'png';

end;

{------------------------------------------------------------------------------}
{TppPNGDevice.DefaultExtFilter}

class function TppPNGDevice.DefaultExtFilter: String;
begin
  Result := 'PNG (*.png)|*.png';

end;

{------------------------------------------------------------------------------}
{TppPNGDevice.DeviceDescription}

class function TppPNGDevice.DeviceDescription(aLanguageIndex: Longint): String;
begin
  Result := 'PNG File';

end;

{------------------------------------------------------------------------------}
{TppPNGDevice.DeviceName}

class function TppPNGDevice.DeviceName: String;
begin
  Result := 'PNG';

end;

{------------------------------------------------------------------------------}
{TppPNGDevice.SaveImageToFile}

procedure TppPNGDevice.SaveImageToFile(aFileName: String);
begin
  FPNG.Assign(Bitmap);
  FPNG.SaveToFile(aFileName);

end;
{$ENDIF}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  ppRegisterDevice(TppBMPDevice);
  ppRegisterDevice(TppJPGDevice);
  ppRegisterDevice(TppGIFDevice);
  ppRegisterDevice(TppMetafileDevice);
{$IFDEF Delphi12}
  ppRegisterDevice(TppPNGDevice);
{$ENDIF}

finalization

  ppUnRegisterDevice(TppBMPDevice);
  ppUnRegisterDevice(TppJPGDevice);
  ppUnRegisterDevice(TppGIFDevice);
  ppUnRegisterDevice(TppMetafileDevice);
{$IFDEF Delphi12}
  ppUnRegisterDevice(TppPNGDevice);
{$ENDIF}

end.
