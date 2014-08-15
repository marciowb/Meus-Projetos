{***************************************************************************}
{ This source code was generated automatically by                           }
{ Pas file import tool for Scripter Studio (Pro)                            }
{                                                                           }
{ Scripter Studio and Pas file import tool for Scripter Studio              }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{***************************************************************************}
unit ap_pngimage;

interface

uses
  Windows,
  Classes,
  Graphics,
  SysUtils,
  zlib,
  pnglang,
  pngimage,
  Variants,
  ap_Types,
  ap_Windows,
  atScript;

{$WARNINGS OFF}

type
  TatpngimageLibrary = class(TatScripterLibrary)
    procedure __TPNGPointerListCreate(AMachine: TatVirtualMachine);
    procedure __TPNGPointerListDestroy(AMachine: TatVirtualMachine);
    procedure __GetTPNGPointerListCount(AMachine: TatVirtualMachine);
    procedure __SetTPNGPointerListCount(AMachine: TatVirtualMachine);
    procedure __TPNGListRemoveChunk(AMachine: TatVirtualMachine);
    procedure __GetTPNGListItem(AMachine: TatVirtualMachine);
    procedure __TPngImageResize(AMachine: TatVirtualMachine);
    procedure __TPngImageCreateAlpha(AMachine: TatVirtualMachine);
    procedure __TPngImageRemoveTransparency(AMachine: TatVirtualMachine);
    procedure __TPngImageAddtEXt(AMachine: TatVirtualMachine);
    procedure __TPngImageAddzTXt(AMachine: TatVirtualMachine);
    procedure __TPngImageSaveToClipboardFormat(AMachine: TatVirtualMachine);
    procedure __TPngImageLoadFromClipboardFormat(AMachine: TatVirtualMachine);
    procedure __TPngImageHasPixelInformation(AMachine: TatVirtualMachine);
    procedure __TPngImageDrawUsingPixelInformation(AMachine: TatVirtualMachine);
    procedure __TPngImageAssign(AMachine: TatVirtualMachine);
    procedure __TPngImageAssignTo(AMachine: TatVirtualMachine);
    procedure __TPngImageAssignHandle(AMachine: TatVirtualMachine);
    procedure __TPngImageDraw(AMachine: TatVirtualMachine);
    procedure __TPngImageCreate(AMachine: TatVirtualMachine);
    procedure __TPngImageCreateBlank(AMachine: TatVirtualMachine);
    procedure __TPngImageDestroy(AMachine: TatVirtualMachine);
    procedure __TPngImageLoadFromStream(AMachine: TatVirtualMachine);
    procedure __TPngImageSaveToStream(AMachine: TatVirtualMachine);
    procedure __TPngImageLoadFromResourceName(AMachine: TatVirtualMachine);
    procedure __TPngImageLoadFromResourceID(AMachine: TatVirtualMachine);
    procedure __GetTPngImageTransparentColor(AMachine: TatVirtualMachine);
    procedure __SetTPngImageTransparentColor(AMachine: TatVirtualMachine);
    procedure __GetTPngImagePixelInformation(AMachine: TatVirtualMachine);
    procedure __GetTPngImageCanvas(AMachine: TatVirtualMachine);
    procedure __GetTPngImageHeader(AMachine: TatVirtualMachine);
    procedure __GetTPngImageTransparencyMode(AMachine: TatVirtualMachine);
    procedure __GetTPngImageWidth(AMachine: TatVirtualMachine);
    procedure __GetTPngImageHeight(AMachine: TatVirtualMachine);
    procedure __GetTPngImageInterlaceMethod(AMachine: TatVirtualMachine);
    procedure __SetTPngImageInterlaceMethod(AMachine: TatVirtualMachine);
    procedure __GetTPngImageFilters(AMachine: TatVirtualMachine);
    procedure __SetTPngImageFilters(AMachine: TatVirtualMachine);
    procedure __GetTPngImageMaxIdatSize(AMachine: TatVirtualMachine);
    procedure __SetTPngImageMaxIdatSize(AMachine: TatVirtualMachine);
    procedure __GetTPngImageEmpty(AMachine: TatVirtualMachine);
    procedure __GetTPngImageCompressionLevel(AMachine: TatVirtualMachine);
    procedure __SetTPngImageCompressionLevel(AMachine: TatVirtualMachine);
    procedure __GetTPngImageChunks(AMachine: TatVirtualMachine);
    procedure __GetTPngImagePixels(AMachine: TatVirtualMachine);
    procedure __SetTPngImagePixels(AMachine: TatVirtualMachine);
    procedure __GetTPngImageVersion(AMachine: TatVirtualMachine);
    procedure __TChunkResizeData(AMachine: TatVirtualMachine);
    procedure __TChunkAssign(AMachine: TatVirtualMachine);
    procedure __TChunkCreate(AMachine: TatVirtualMachine);
    procedure __TChunkDestroy(AMachine: TatVirtualMachine);
    procedure __TChunkSaveData(AMachine: TatVirtualMachine);
    procedure __TChunkSaveToStream(AMachine: TatVirtualMachine);
    procedure __GetTChunkIndex(AMachine: TatVirtualMachine);
    procedure __GetTChunkHeader(AMachine: TatVirtualMachine);
    procedure __GetTChunkDataSize(AMachine: TatVirtualMachine);
    procedure __GetTChunkOwner(AMachine: TatVirtualMachine);
    procedure __GetTChunkName(AMachine: TatVirtualMachine);
    procedure __TChunkIHDRSaveToStream(AMachine: TatVirtualMachine);
    procedure __TChunkIHDRCreate(AMachine: TatVirtualMachine);
    procedure __TChunkIHDRDestroy(AMachine: TatVirtualMachine);
    procedure __TChunkIHDRAssign(AMachine: TatVirtualMachine);
    procedure __GetTChunkIHDRImageHandleValue(AMachine: TatVirtualMachine);
    procedure __GetTChunkIHDRWidth(AMachine: TatVirtualMachine);
    procedure __SetTChunkIHDRWidth(AMachine: TatVirtualMachine);
    procedure __GetTChunkIHDRHeight(AMachine: TatVirtualMachine);
    procedure __SetTChunkIHDRHeight(AMachine: TatVirtualMachine);
    procedure __GetTChunkIHDRBitDepth(AMachine: TatVirtualMachine);
    procedure __SetTChunkIHDRBitDepth(AMachine: TatVirtualMachine);
    procedure __GetTChunkIHDRColorType(AMachine: TatVirtualMachine);
    procedure __SetTChunkIHDRColorType(AMachine: TatVirtualMachine);
    procedure __GetTChunkIHDRCompressionMethod(AMachine: TatVirtualMachine);
    procedure __SetTChunkIHDRCompressionMethod(AMachine: TatVirtualMachine);
    procedure __GetTChunkIHDRFilterMethod(AMachine: TatVirtualMachine);
    procedure __SetTChunkIHDRFilterMethod(AMachine: TatVirtualMachine);
    procedure __GetTChunkIHDRInterlaceMethod(AMachine: TatVirtualMachine);
    procedure __SetTChunkIHDRInterlaceMethod(AMachine: TatVirtualMachine);
    procedure __TChunkpHYsSaveToStream(AMachine: TatVirtualMachine);
    procedure __TChunkpHYsAssign(AMachine: TatVirtualMachine);
    procedure __GetTChunkpHYsPPUnitX(AMachine: TatVirtualMachine);
    procedure __SetTChunkpHYsPPUnitX(AMachine: TatVirtualMachine);
    procedure __GetTChunkpHYsPPUnitY(AMachine: TatVirtualMachine);
    procedure __SetTChunkpHYsPPUnitY(AMachine: TatVirtualMachine);
    procedure __GetTChunkpHYsUnitType(AMachine: TatVirtualMachine);
    procedure __SetTChunkpHYsUnitType(AMachine: TatVirtualMachine);
    procedure __TChunkgAMACreate(AMachine: TatVirtualMachine);
    procedure __TChunkgAMAAssign(AMachine: TatVirtualMachine);
    procedure __GetTChunkgAMAGamma(AMachine: TatVirtualMachine);
    procedure __SetTChunkgAMAGamma(AMachine: TatVirtualMachine);
    procedure __TChunkPLTESaveToStream(AMachine: TatVirtualMachine);
    procedure __TChunkPLTEAssign(AMachine: TatVirtualMachine);
    procedure __GetTChunkPLTEItem(AMachine: TatVirtualMachine);
    procedure __GetTChunkPLTECount(AMachine: TatVirtualMachine);
    procedure __TChunktRNSSaveToStream(AMachine: TatVirtualMachine);
    procedure __TChunktRNSAssign(AMachine: TatVirtualMachine);
    procedure __GetTChunktRNSBitTransparency(AMachine: TatVirtualMachine);
    procedure __GetTChunktRNSTransparentColor(AMachine: TatVirtualMachine);
    procedure __SetTChunktRNSTransparentColor(AMachine: TatVirtualMachine);
    procedure __TChunkIDATSaveToStream(AMachine: TatVirtualMachine);
    procedure __TChunktIMESaveToStream(AMachine: TatVirtualMachine);
    procedure __TChunktIMEAssign(AMachine: TatVirtualMachine);
    procedure __GetTChunktIMEYear(AMachine: TatVirtualMachine);
    procedure __SetTChunktIMEYear(AMachine: TatVirtualMachine);
    procedure __GetTChunktIMEMonth(AMachine: TatVirtualMachine);
    procedure __SetTChunktIMEMonth(AMachine: TatVirtualMachine);
    procedure __GetTChunktIMEDay(AMachine: TatVirtualMachine);
    procedure __SetTChunktIMEDay(AMachine: TatVirtualMachine);
    procedure __GetTChunktIMEHour(AMachine: TatVirtualMachine);
    procedure __SetTChunktIMEHour(AMachine: TatVirtualMachine);
    procedure __GetTChunktIMEMinute(AMachine: TatVirtualMachine);
    procedure __SetTChunktIMEMinute(AMachine: TatVirtualMachine);
    procedure __GetTChunktIMESecond(AMachine: TatVirtualMachine);
    procedure __SetTChunktIMESecond(AMachine: TatVirtualMachine);
    procedure __TChunktEXtSaveToStream(AMachine: TatVirtualMachine);
    procedure __TChunktEXtAssign(AMachine: TatVirtualMachine);
    procedure __GetTChunktEXtKeyword(AMachine: TatVirtualMachine);
    procedure __SetTChunktEXtKeyword(AMachine: TatVirtualMachine);
    procedure __GetTChunktEXtText(AMachine: TatVirtualMachine);
    procedure __SetTChunktEXtText(AMachine: TatVirtualMachine);
    procedure __TChunkzTXtSaveToStream(AMachine: TatVirtualMachine);
    procedure __ByteSwap(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  EPNGOutMemoryClass = class of EPNGOutMemory;
  EPngErrorClass = class of EPngError;
  EPngUnexpectedEndClass = class of EPngUnexpectedEnd;
  EPngInvalidCRCClass = class of EPngInvalidCRC;
  EPngInvalidIHDRClass = class of EPngInvalidIHDR;
  EPNGMissingMultipleIDATClass = class of EPNGMissingMultipleIDAT;
  EPNGZLIBErrorClass = class of EPNGZLIBError;
  EPNGInvalidPaletteClass = class of EPNGInvalidPalette;
  EPNGInvalidFileHeaderClass = class of EPNGInvalidFileHeader;
  EPNGIHDRNotFirstClass = class of EPNGIHDRNotFirst;
  EPNGNotExistsClass = class of EPNGNotExists;
  EPNGSizeExceedsClass = class of EPNGSizeExceeds;
  EPNGMissingPaletteClass = class of EPNGMissingPalette;
  EPNGUnknownCriticalChunkClass = class of EPNGUnknownCriticalChunk;
  EPNGUnknownCompressionClass = class of EPNGUnknownCompression;
  EPNGUnknownInterlaceClass = class of EPNGUnknownInterlace;
  EPNGNoImageDataClass = class of EPNGNoImageData;
  EPNGCouldNotLoadResourceClass = class of EPNGCouldNotLoadResource;
  EPNGCannotChangeTransparentClass = class of EPNGCannotChangeTransparent;
  EPNGHeaderNotPresentClass = class of EPNGHeaderNotPresent;
  EPNGInvalidNewSizeClass = class of EPNGInvalidNewSize;
  EPNGInvalidSpecClass = class of EPNGInvalidSpec;
  TPNGPointerListClass = class of TPNGPointerList;
  TPNGListClass = class of TPNGList;
  TPngImageClass = class of TPngImage;
  TPNGObjectClass = class of TPNGObject;
  TChunkClass = class of TChunk;
  TChunkIENDClass = class of TChunkIEND;
  TChunkIHDRClass = class of TChunkIHDR;
  TChunkpHYsClass = class of TChunkpHYs;
  TChunkgAMAClass = class of TChunkgAMA;
  TChunkPLTEClass = class of TChunkPLTE;
  TChunktRNSClass = class of TChunktRNS;
  TChunkIDATClass = class of TChunkIDAT;
  TChunktIMEClass = class of TChunktIME;
  TChunktEXtClass = class of TChunktEXt;
  TChunkzTXtClass = class of TChunkzTXt;


  TMAXBITMAPINFOWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: TMAXBITMAPINFO);
    function ObjToRec: TMAXBITMAPINFO;
  published
  end;
  
  TRGBPixelWrapper = class(TatRecordWrapper)
  private
    FB: Byte;
    FG: Byte;
    FR: Byte;
  public
    constructor Create(ARecord: TRGBPixel);
    function ObjToRec: TRGBPixel;
  published
    property B: Byte read FB write FB;
    property G: Byte read FG write FG;
    property R: Byte read FR write FR;
  end;
  
  TIHDRDataWrapper = class(TatRecordWrapper)
  private
    FWidth: Cardinal;
    FHeight: Cardinal;
    FBitDepth: Byte;
    FColorType: Byte;
    FCompressionMethod: Byte;
    FFilterMethod: Byte;
    FInterlaceMethod: Byte;
  public
    constructor Create(ARecord: TIHDRData);
    function ObjToRec: TIHDRData;
  published
    property Width: Cardinal read FWidth write FWidth;
    property Height: Cardinal read FHeight write FHeight;
    property BitDepth: Byte read FBitDepth write FBitDepth;
    property ColorType: Byte read FColorType write FColorType;
    property CompressionMethod: Byte read FCompressionMethod write FCompressionMethod;
    property FilterMethod: Byte read FFilterMethod write FFilterMethod;
    property InterlaceMethod: Byte read FInterlaceMethod write FInterlaceMethod;
  end;
  
  TZStreamRec2Wrapper = class(TatRecordWrapper)
  private
    FfStream: TStream;
  public
    constructor Create(ARecord: TZStreamRec2);
    function ObjToRec: TZStreamRec2;
  published
    property fStream: TStream read FfStream write FfStream;
  end;
  

implementation

constructor TMAXBITMAPINFOWrapper.Create(ARecord: TMAXBITMAPINFO);
begin
  inherited Create;
end;

function TMAXBITMAPINFOWrapper.ObjToRec: TMAXBITMAPINFO;
begin
end;

constructor TRGBPixelWrapper.Create(ARecord: TRGBPixel);
begin
  inherited Create;
  FB := ARecord.B;
  FG := ARecord.G;
  FR := ARecord.R;
end;

function TRGBPixelWrapper.ObjToRec: TRGBPixel;
begin
  result.B := FB;
  result.G := FG;
  result.R := FR;
end;

constructor TIHDRDataWrapper.Create(ARecord: TIHDRData);
begin
  inherited Create;
  FWidth := ARecord.Width;
  FHeight := ARecord.Height;
  FBitDepth := ARecord.BitDepth;
  FColorType := ARecord.ColorType;
  FCompressionMethod := ARecord.CompressionMethod;
  FFilterMethod := ARecord.FilterMethod;
  FInterlaceMethod := ARecord.InterlaceMethod;
end;

function TIHDRDataWrapper.ObjToRec: TIHDRData;
begin
  result.Width := FWidth;
  result.Height := FHeight;
  result.BitDepth := FBitDepth;
  result.ColorType := FColorType;
  result.CompressionMethod := FCompressionMethod;
  result.FilterMethod := FFilterMethod;
  result.InterlaceMethod := FInterlaceMethod;
end;

constructor TZStreamRec2Wrapper.Create(ARecord: TZStreamRec2);
begin
  inherited Create;
  FfStream := ARecord.fStream;
end;

function TZStreamRec2Wrapper.ObjToRec: TZStreamRec2;
begin
  result.fStream := FfStream;
end;



procedure TatpngimageLibrary.__TPNGPointerListCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TPNGPointerListClass(CurrentClass.ClassRef).Create(TPngImage(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatpngimageLibrary.__TPNGPointerListDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPNGPointerList(CurrentObject).Destroy;
  end;
end;

procedure TatpngimageLibrary.__GetTPNGPointerListCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TPNGPointerList(CurrentObject).Count));
  end;
end;

procedure TatpngimageLibrary.__SetTPNGPointerListCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPNGPointerList(CurrentObject).Count:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatpngimageLibrary.__TPNGListRemoveChunk(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPNGList(CurrentObject).RemoveChunk(TChunk(Integer(GetInputArg(0))));
  end;
end;

procedure TatpngimageLibrary.__GetTPNGListItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TPNGList(CurrentObject).Item[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatpngimageLibrary.__TPngImageResize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPngImage(CurrentObject).Resize(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatpngimageLibrary.__TPngImageCreateAlpha(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPngImage(CurrentObject).CreateAlpha;
  end;
end;

procedure TatpngimageLibrary.__TPngImageRemoveTransparency(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPngImage(CurrentObject).RemoveTransparency;
  end;
end;

procedure TatpngimageLibrary.__TPngImageAddtEXt(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPngImage(CurrentObject).AddtEXt(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatpngimageLibrary.__TPngImageAddzTXt(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPngImage(CurrentObject).AddzTXt(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatpngimageLibrary.__TPngImageSaveToClipboardFormat(AMachine: TatVirtualMachine);
  var
  Param0: Word;
  Param1: THandle;
  Param2: HPalette;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
Param1 := GetInputArg(1);
Param2 := VarToInteger(GetInputArg(2));
    TPngImage(CurrentObject).SaveToClipboardFormat(Param0,Param1,Param2);
    SetInputArg(0,Integer(Param0));
    SetInputArg(1,Param1);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatpngimageLibrary.__TPngImageLoadFromClipboardFormat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPngImage(CurrentObject).LoadFromClipboardFormat(VarToInteger(GetInputArg(0)),GetInputArg(1),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatpngimageLibrary.__TPngImageHasPixelInformation(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TPngImage(CurrentObject).HasPixelInformation;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatpngimageLibrary.__TPngImageDrawUsingPixelInformation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPngImage(CurrentObject).DrawUsingPixelInformation(TCanvas(Integer(GetInputArg(0))),TPointWrapper(integer(GetInputArg(1))).ObjToRec);
  end;
end;

procedure TatpngimageLibrary.__TPngImageAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPngImage(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatpngimageLibrary.__TPngImageAssignTo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPngImage(CurrentObject).AssignTo(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatpngimageLibrary.__TPngImageAssignHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPngImage(CurrentObject).AssignHandle(VarToInteger(GetInputArg(0)),GetInputArg(1),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatpngimageLibrary.__TPngImageDraw(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPngImage(CurrentObject).Draw(TCanvas(Integer(GetInputArg(0))),TRectWrapper(integer(GetInputArg(1))).ObjToRec);
  end;
end;

procedure TatpngimageLibrary.__TPngImageCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TPngImageClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatpngimageLibrary.__TPngImageCreateBlank(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TPngImageClass(CurrentClass.ClassRef).CreateBlank(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatpngimageLibrary.__TPngImageDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPngImage(CurrentObject).Destroy;
  end;
end;

procedure TatpngimageLibrary.__TPngImageLoadFromStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPngImage(CurrentObject).LoadFromStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatpngimageLibrary.__TPngImageSaveToStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPngImage(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatpngimageLibrary.__TPngImageLoadFromResourceName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPngImage(CurrentObject).LoadFromResourceName(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatpngimageLibrary.__TPngImageLoadFromResourceID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPngImage(CurrentObject).LoadFromResourceID(GetInputArg(0),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatpngimageLibrary.__GetTPngImageTransparentColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TPngImage(CurrentObject).TransparentColor);
  end;
end;

procedure TatpngimageLibrary.__SetTPngImageTransparentColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPngImage(CurrentObject).TransparentColor:=GetInputArg(0);
  end;
end;

procedure TatpngimageLibrary.__GetTPngImagePixelInformation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TPngImage(CurrentObject).PixelInformation));
  end;
end;

procedure TatpngimageLibrary.__GetTPngImageCanvas(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TPngImage(CurrentObject).Canvas));
  end;
end;

procedure TatpngimageLibrary.__GetTPngImageHeader(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TPngImage(CurrentObject).Header));
  end;
end;

procedure TatpngimageLibrary.__GetTPngImageTransparencyMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TPngImage(CurrentObject).TransparencyMode);
  end;
end;

procedure TatpngimageLibrary.__GetTPngImageWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TPngImage(CurrentObject).Width));
  end;
end;

procedure TatpngimageLibrary.__GetTPngImageHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TPngImage(CurrentObject).Height));
  end;
end;

procedure TatpngimageLibrary.__GetTPngImageInterlaceMethod(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TPngImage(CurrentObject).InterlaceMethod);
  end;
end;

procedure TatpngimageLibrary.__SetTPngImageInterlaceMethod(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPngImage(CurrentObject).InterlaceMethod:=GetInputArg(0);
  end;
end;

procedure TatpngimageLibrary.__GetTPngImageFilters(AMachine: TatVirtualMachine);
var
PropValueSet: TFilters;
begin
  with AMachine do
  begin
    PropValueSet := TPngImage(CurrentObject).Filters;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatpngimageLibrary.__SetTPngImageFilters(AMachine: TatVirtualMachine);
  var
  TempVar: TFilters;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TPngImage(CurrentObject).Filters:=TempVar;
  end;
end;

procedure TatpngimageLibrary.__GetTPngImageMaxIdatSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TPngImage(CurrentObject).MaxIdatSize));
  end;
end;

procedure TatpngimageLibrary.__SetTPngImageMaxIdatSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPngImage(CurrentObject).MaxIdatSize:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatpngimageLibrary.__GetTPngImageEmpty(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TPngImage(CurrentObject).Empty);
  end;
end;

procedure TatpngimageLibrary.__GetTPngImageCompressionLevel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TPngImage(CurrentObject).CompressionLevel);
  end;
end;

procedure TatpngimageLibrary.__SetTPngImageCompressionLevel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPngImage(CurrentObject).CompressionLevel:=GetInputArg(0);
  end;
end;

procedure TatpngimageLibrary.__GetTPngImageChunks(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TPngImage(CurrentObject).Chunks));
  end;
end;

procedure TatpngimageLibrary.__GetTPngImagePixels(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TPngImage(CurrentObject).Pixels[VarToInteger(GetArrayIndex(0)),VarToInteger(GetArrayIndex(1))]);
  end;
end;

procedure TatpngimageLibrary.__SetTPngImagePixels(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPngImage(CurrentObject).Pixels[VarToInteger(GetArrayIndex(0)),VarToInteger(GetArrayIndex(1))]:=GetInputArg(0);
  end;
end;

procedure TatpngimageLibrary.__GetTPngImageVersion(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TPngImage(CurrentObject).Version);
  end;
end;

procedure TatpngimageLibrary.__TChunkResizeData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChunk(CurrentObject).ResizeData(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatpngimageLibrary.__TChunkAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChunk(CurrentObject).Assign(TChunk(Integer(GetInputArg(0))));
  end;
end;

procedure TatpngimageLibrary.__TChunkCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TChunkClass(CurrentClass.ClassRef).Create(TPngImage(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatpngimageLibrary.__TChunkDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChunk(CurrentObject).Destroy;
  end;
end;

procedure TatpngimageLibrary.__TChunkSaveData(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TChunk(CurrentObject).SaveData(TStream(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatpngimageLibrary.__TChunkSaveToStream(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TChunk(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatpngimageLibrary.__GetTChunkIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TChunk(CurrentObject).Index));
  end;
end;

procedure TatpngimageLibrary.__GetTChunkHeader(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TChunk(CurrentObject).Header));
  end;
end;

procedure TatpngimageLibrary.__GetTChunkDataSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TChunk(CurrentObject).DataSize));
  end;
end;

procedure TatpngimageLibrary.__GetTChunkOwner(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TChunk(CurrentObject).Owner));
  end;
end;

procedure TatpngimageLibrary.__GetTChunkName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TChunk(CurrentObject).Name);
  end;
end;

procedure TatpngimageLibrary.__TChunkIHDRSaveToStream(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TChunkIHDR(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatpngimageLibrary.__TChunkIHDRCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TChunkIHDRClass(CurrentClass.ClassRef).Create(TPngImage(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatpngimageLibrary.__TChunkIHDRDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChunkIHDR(CurrentObject).Destroy;
  end;
end;

procedure TatpngimageLibrary.__TChunkIHDRAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChunkIHDR(CurrentObject).Assign(TChunk(Integer(GetInputArg(0))));
  end;
end;

procedure TatpngimageLibrary.__GetTChunkIHDRImageHandleValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TChunkIHDR(CurrentObject).ImageHandleValue));
  end;
end;

procedure TatpngimageLibrary.__GetTChunkIHDRWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TChunkIHDR(CurrentObject).Width));
  end;
end;

procedure TatpngimageLibrary.__SetTChunkIHDRWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChunkIHDR(CurrentObject).Width:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatpngimageLibrary.__GetTChunkIHDRHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TChunkIHDR(CurrentObject).Height));
  end;
end;

procedure TatpngimageLibrary.__SetTChunkIHDRHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChunkIHDR(CurrentObject).Height:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatpngimageLibrary.__GetTChunkIHDRBitDepth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TChunkIHDR(CurrentObject).BitDepth));
  end;
end;

procedure TatpngimageLibrary.__SetTChunkIHDRBitDepth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChunkIHDR(CurrentObject).BitDepth:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatpngimageLibrary.__GetTChunkIHDRColorType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TChunkIHDR(CurrentObject).ColorType));
  end;
end;

procedure TatpngimageLibrary.__SetTChunkIHDRColorType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChunkIHDR(CurrentObject).ColorType:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatpngimageLibrary.__GetTChunkIHDRCompressionMethod(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TChunkIHDR(CurrentObject).CompressionMethod));
  end;
end;

procedure TatpngimageLibrary.__SetTChunkIHDRCompressionMethod(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChunkIHDR(CurrentObject).CompressionMethod:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatpngimageLibrary.__GetTChunkIHDRFilterMethod(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TChunkIHDR(CurrentObject).FilterMethod));
  end;
end;

procedure TatpngimageLibrary.__SetTChunkIHDRFilterMethod(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChunkIHDR(CurrentObject).FilterMethod:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatpngimageLibrary.__GetTChunkIHDRInterlaceMethod(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TChunkIHDR(CurrentObject).InterlaceMethod));
  end;
end;

procedure TatpngimageLibrary.__SetTChunkIHDRInterlaceMethod(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChunkIHDR(CurrentObject).InterlaceMethod:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatpngimageLibrary.__TChunkpHYsSaveToStream(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TChunkpHYs(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatpngimageLibrary.__TChunkpHYsAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChunkpHYs(CurrentObject).Assign(TChunk(Integer(GetInputArg(0))));
  end;
end;

procedure TatpngimageLibrary.__GetTChunkpHYsPPUnitX(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TChunkpHYs(CurrentObject).PPUnitX));
  end;
end;

procedure TatpngimageLibrary.__SetTChunkpHYsPPUnitX(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChunkpHYs(CurrentObject).PPUnitX:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatpngimageLibrary.__GetTChunkpHYsPPUnitY(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TChunkpHYs(CurrentObject).PPUnitY));
  end;
end;

procedure TatpngimageLibrary.__SetTChunkpHYsPPUnitY(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChunkpHYs(CurrentObject).PPUnitY:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatpngimageLibrary.__GetTChunkpHYsUnitType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TChunkpHYs(CurrentObject).UnitType);
  end;
end;

procedure TatpngimageLibrary.__SetTChunkpHYsUnitType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChunkpHYs(CurrentObject).UnitType:=GetInputArg(0);
  end;
end;

procedure TatpngimageLibrary.__TChunkgAMACreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TChunkgAMAClass(CurrentClass.ClassRef).Create(TPngImage(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatpngimageLibrary.__TChunkgAMAAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChunkgAMA(CurrentObject).Assign(TChunk(Integer(GetInputArg(0))));
  end;
end;

procedure TatpngimageLibrary.__GetTChunkgAMAGamma(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TChunkgAMA(CurrentObject).Gamma));
  end;
end;

procedure TatpngimageLibrary.__SetTChunkgAMAGamma(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChunkgAMA(CurrentObject).Gamma:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatpngimageLibrary.__TChunkPLTESaveToStream(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TChunkPLTE(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatpngimageLibrary.__TChunkPLTEAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChunkPLTE(CurrentObject).Assign(TChunk(Integer(GetInputArg(0))));
  end;
end;

procedure TatpngimageLibrary.__GetTChunkPLTEItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(tagRGBQUADWrapper.Create(TChunkPLTE(CurrentObject).Item[VarToInteger(GetArrayIndex(0))])));
  end;
end;

procedure TatpngimageLibrary.__GetTChunkPLTECount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TChunkPLTE(CurrentObject).Count));
  end;
end;

procedure TatpngimageLibrary.__TChunktRNSSaveToStream(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TChunktRNS(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatpngimageLibrary.__TChunktRNSAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChunktRNS(CurrentObject).Assign(TChunk(Integer(GetInputArg(0))));
  end;
end;

procedure TatpngimageLibrary.__GetTChunktRNSBitTransparency(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TChunktRNS(CurrentObject).BitTransparency);
  end;
end;

procedure TatpngimageLibrary.__GetTChunktRNSTransparentColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TChunktRNS(CurrentObject).TransparentColor));
  end;
end;

procedure TatpngimageLibrary.__SetTChunktRNSTransparentColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChunktRNS(CurrentObject).TransparentColor:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatpngimageLibrary.__TChunkIDATSaveToStream(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TChunkIDAT(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatpngimageLibrary.__TChunktIMESaveToStream(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TChunktIME(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatpngimageLibrary.__TChunktIMEAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChunktIME(CurrentObject).Assign(TChunk(Integer(GetInputArg(0))));
  end;
end;

procedure TatpngimageLibrary.__GetTChunktIMEYear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TChunktIME(CurrentObject).Year));
  end;
end;

procedure TatpngimageLibrary.__SetTChunktIMEYear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChunktIME(CurrentObject).Year:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatpngimageLibrary.__GetTChunktIMEMonth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TChunktIME(CurrentObject).Month));
  end;
end;

procedure TatpngimageLibrary.__SetTChunktIMEMonth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChunktIME(CurrentObject).Month:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatpngimageLibrary.__GetTChunktIMEDay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TChunktIME(CurrentObject).Day));
  end;
end;

procedure TatpngimageLibrary.__SetTChunktIMEDay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChunktIME(CurrentObject).Day:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatpngimageLibrary.__GetTChunktIMEHour(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TChunktIME(CurrentObject).Hour));
  end;
end;

procedure TatpngimageLibrary.__SetTChunktIMEHour(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChunktIME(CurrentObject).Hour:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatpngimageLibrary.__GetTChunktIMEMinute(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TChunktIME(CurrentObject).Minute));
  end;
end;

procedure TatpngimageLibrary.__SetTChunktIMEMinute(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChunktIME(CurrentObject).Minute:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatpngimageLibrary.__GetTChunktIMESecond(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TChunktIME(CurrentObject).Second));
  end;
end;

procedure TatpngimageLibrary.__SetTChunktIMESecond(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChunktIME(CurrentObject).Second:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatpngimageLibrary.__TChunktEXtSaveToStream(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TChunktEXt(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatpngimageLibrary.__TChunktEXtAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChunktEXt(CurrentObject).Assign(TChunk(Integer(GetInputArg(0))));
  end;
end;

procedure TatpngimageLibrary.__GetTChunktEXtKeyword(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TChunktEXt(CurrentObject).Keyword);
  end;
end;

procedure TatpngimageLibrary.__SetTChunktEXtKeyword(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChunktEXt(CurrentObject).Keyword:=GetInputArg(0);
  end;
end;

procedure TatpngimageLibrary.__GetTChunktEXtText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TChunktEXt(CurrentObject).Text);
  end;
end;

procedure TatpngimageLibrary.__SetTChunktEXtText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TChunktEXt(CurrentObject).Text:=GetInputArg(0);
  end;
end;

procedure TatpngimageLibrary.__TChunkzTXtSaveToStream(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TChunkzTXt(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatpngimageLibrary.__ByteSwap(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(pngimage.ByteSwap(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatpngimageLibrary.Init;
begin
  With Scripter.DefineClass(EPNGOutMemory) do
  begin
  end;
  With Scripter.DefineClass(EPngError) do
  begin
  end;
  With Scripter.DefineClass(EPngUnexpectedEnd) do
  begin
  end;
  With Scripter.DefineClass(EPngInvalidCRC) do
  begin
  end;
  With Scripter.DefineClass(EPngInvalidIHDR) do
  begin
  end;
  With Scripter.DefineClass(EPNGMissingMultipleIDAT) do
  begin
  end;
  With Scripter.DefineClass(EPNGZLIBError) do
  begin
  end;
  With Scripter.DefineClass(EPNGInvalidPalette) do
  begin
  end;
  With Scripter.DefineClass(EPNGInvalidFileHeader) do
  begin
  end;
  With Scripter.DefineClass(EPNGIHDRNotFirst) do
  begin
  end;
  With Scripter.DefineClass(EPNGNotExists) do
  begin
  end;
  With Scripter.DefineClass(EPNGSizeExceeds) do
  begin
  end;
  With Scripter.DefineClass(EPNGMissingPalette) do
  begin
  end;
  With Scripter.DefineClass(EPNGUnknownCriticalChunk) do
  begin
  end;
  With Scripter.DefineClass(EPNGUnknownCompression) do
  begin
  end;
  With Scripter.DefineClass(EPNGUnknownInterlace) do
  begin
  end;
  With Scripter.DefineClass(EPNGNoImageData) do
  begin
  end;
  With Scripter.DefineClass(EPNGCouldNotLoadResource) do
  begin
  end;
  With Scripter.DefineClass(EPNGCannotChangeTransparent) do
  begin
  end;
  With Scripter.DefineClass(EPNGHeaderNotPresent) do
  begin
  end;
  With Scripter.DefineClass(EPNGInvalidNewSize) do
  begin
  end;
  With Scripter.DefineClass(EPNGInvalidSpec) do
  begin
  end;
  With Scripter.DefineClass(TPNGPointerList) do
  begin
    DefineMethod('Create',1,tkClass,TPNGPointerList,__TPNGPointerListCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TPNGPointerListDestroy,false,0);
    DefineProp('Count',tkInteger,__GetTPNGPointerListCount,__SetTPNGPointerListCount,nil,false,0);
  end;
  With Scripter.DefineClass(TPNGList) do
  begin
    DefineMethod('RemoveChunk',1,tkNone,nil,__TPNGListRemoveChunk,false,0);
    DefineProp('Item',tkClass,__GetTPNGListItem,nil,TChunk,false,1);
  end;
  With Scripter.DefineClass(TPngImage) do
  begin
    DefineMethod('Resize',2,tkNone,nil,__TPngImageResize,false,0);
    DefineMethod('CreateAlpha',0,tkNone,nil,__TPngImageCreateAlpha,false,0);
    DefineMethod('RemoveTransparency',0,tkNone,nil,__TPngImageRemoveTransparency,false,0);
    DefineMethod('AddtEXt',2,tkNone,nil,__TPngImageAddtEXt,false,0);
    DefineMethod('AddzTXt',2,tkNone,nil,__TPngImageAddzTXt,false,0);
    DefineMethod('SaveToClipboardFormat',3,tkNone,nil,__TPngImageSaveToClipboardFormat,false,0).SetVarArgs([0,1,2]);
    DefineMethod('LoadFromClipboardFormat',3,tkNone,nil,__TPngImageLoadFromClipboardFormat,false,0);
    DefineMethod('HasPixelInformation',0,tkVariant,nil,__TPngImageHasPixelInformation,false,0);
    DefineMethod('DrawUsingPixelInformation',2,tkNone,nil,__TPngImageDrawUsingPixelInformation,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TPngImageAssign,false,0);
    DefineMethod('AssignTo',1,tkNone,nil,__TPngImageAssignTo,false,0);
    DefineMethod('AssignHandle',3,tkNone,nil,__TPngImageAssignHandle,false,0);
    DefineMethod('Draw',2,tkNone,nil,__TPngImageDraw,false,0);
    DefineMethod('Create',0,tkClass,TPngImage,__TPngImageCreate,true,0);
    DefineMethod('CreateBlank',4,tkClass,TPngImage,__TPngImageCreateBlank,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TPngImageDestroy,false,0);
    DefineMethod('LoadFromStream',1,tkNone,nil,__TPngImageLoadFromStream,false,0);
    DefineMethod('SaveToStream',1,tkNone,nil,__TPngImageSaveToStream,false,0);
    DefineMethod('LoadFromResourceName',2,tkNone,nil,__TPngImageLoadFromResourceName,false,0);
    DefineMethod('LoadFromResourceID',2,tkNone,nil,__TPngImageLoadFromResourceID,false,0);
    DefineProp('TransparentColor',tkEnumeration,__GetTPngImageTransparentColor,__SetTPngImageTransparentColor,nil,false,0);
    DefineProp('PixelInformation',tkClass,__GetTPngImagePixelInformation,nil,TChunkpHYs,false,0);
    DefineProp('Canvas',tkClass,__GetTPngImageCanvas,nil,TCanvas,false,0);
    DefineProp('Header',tkClass,__GetTPngImageHeader,nil,TChunkIHDR,false,0);
    DefineProp('TransparencyMode',tkEnumeration,__GetTPngImageTransparencyMode,nil,nil,false,0);
    DefineProp('Width',tkInteger,__GetTPngImageWidth,nil,nil,false,0);
    DefineProp('Height',tkInteger,__GetTPngImageHeight,nil,nil,false,0);
    DefineProp('InterlaceMethod',tkEnumeration,__GetTPngImageInterlaceMethod,__SetTPngImageInterlaceMethod,nil,false,0);
    DefineProp('Filters',tkInteger,__GetTPngImageFilters,__SetTPngImageFilters,nil,false,0);
    DefineProp('MaxIdatSize',tkInteger,__GetTPngImageMaxIdatSize,__SetTPngImageMaxIdatSize,nil,false,0);
    DefineProp('Empty',tkVariant,__GetTPngImageEmpty,nil,nil,false,0);
    DefineProp('CompressionLevel',tkEnumeration,__GetTPngImageCompressionLevel,__SetTPngImageCompressionLevel,nil,false,0);
    DefineProp('Chunks',tkClass,__GetTPngImageChunks,nil,TPNGList,false,0);
    DefineProp('Pixels',tkEnumeration,__GetTPngImagePixels,__SetTPngImagePixels,nil,false,2);
    DefineProp('Version',tkVariant,__GetTPngImageVersion,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TPNGObject) do
  begin
  end;
  With Scripter.DefineClass(TChunk) do
  begin
    DefineMethod('ResizeData',1,tkNone,nil,__TChunkResizeData,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TChunkAssign,false,0);
    DefineMethod('Create',1,tkClass,TChunk,__TChunkCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TChunkDestroy,false,0);
    DefineMethod('SaveData',1,tkVariant,nil,__TChunkSaveData,false,0);
    DefineMethod('SaveToStream',1,tkVariant,nil,__TChunkSaveToStream,false,0);
    DefineProp('Index',tkInteger,__GetTChunkIndex,nil,nil,false,0);
    DefineProp('Header',tkClass,__GetTChunkHeader,nil,TChunkIHDR,false,0);
    DefineProp('DataSize',tkInteger,__GetTChunkDataSize,nil,nil,false,0);
    DefineProp('Owner',tkClass,__GetTChunkOwner,nil,TPngImage,false,0);
    DefineProp('Name',tkVariant,__GetTChunkName,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TChunkIEND) do
  begin
  end;
  With Scripter.DefineClass(TChunkIHDR) do
  begin
    DefineMethod('SaveToStream',1,tkVariant,nil,__TChunkIHDRSaveToStream,false,0);
    DefineMethod('Create',1,tkClass,TChunkIHDR,__TChunkIHDRCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TChunkIHDRDestroy,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TChunkIHDRAssign,false,0);
    DefineProp('ImageHandleValue',tkInteger,__GetTChunkIHDRImageHandleValue,nil,nil,false,0);
    DefineProp('Width',tkInteger,__GetTChunkIHDRWidth,__SetTChunkIHDRWidth,nil,false,0);
    DefineProp('Height',tkInteger,__GetTChunkIHDRHeight,__SetTChunkIHDRHeight,nil,false,0);
    DefineProp('BitDepth',tkInteger,__GetTChunkIHDRBitDepth,__SetTChunkIHDRBitDepth,nil,false,0);
    DefineProp('ColorType',tkInteger,__GetTChunkIHDRColorType,__SetTChunkIHDRColorType,nil,false,0);
    DefineProp('CompressionMethod',tkInteger,__GetTChunkIHDRCompressionMethod,__SetTChunkIHDRCompressionMethod,nil,false,0);
    DefineProp('FilterMethod',tkInteger,__GetTChunkIHDRFilterMethod,__SetTChunkIHDRFilterMethod,nil,false,0);
    DefineProp('InterlaceMethod',tkInteger,__GetTChunkIHDRInterlaceMethod,__SetTChunkIHDRInterlaceMethod,nil,false,0);
  end;
  With Scripter.DefineClass(TChunkpHYs) do
  begin
    DefineMethod('SaveToStream',1,tkVariant,nil,__TChunkpHYsSaveToStream,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TChunkpHYsAssign,false,0);
    DefineProp('PPUnitX',tkInteger,__GetTChunkpHYsPPUnitX,__SetTChunkpHYsPPUnitX,nil,false,0);
    DefineProp('PPUnitY',tkInteger,__GetTChunkpHYsPPUnitY,__SetTChunkpHYsPPUnitY,nil,false,0);
    DefineProp('UnitType',tkEnumeration,__GetTChunkpHYsUnitType,__SetTChunkpHYsUnitType,nil,false,0);
  end;
  With Scripter.DefineClass(TChunkgAMA) do
  begin
    DefineMethod('Create',1,tkClass,TChunkgAMA,__TChunkgAMACreate,true,0);
    DefineMethod('Assign',1,tkNone,nil,__TChunkgAMAAssign,false,0);
    DefineProp('Gamma',tkInteger,__GetTChunkgAMAGamma,__SetTChunkgAMAGamma,nil,false,0);
  end;
  With Scripter.DefineClass(TChunkPLTE) do
  begin
    DefineMethod('SaveToStream',1,tkVariant,nil,__TChunkPLTESaveToStream,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TChunkPLTEAssign,false,0);
    DefineProp('Item',tkVariant,__GetTChunkPLTEItem,nil,nil,false,1);
    DefineProp('Count',tkInteger,__GetTChunkPLTECount,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TChunktRNS) do
  begin
    DefineMethod('SaveToStream',1,tkVariant,nil,__TChunktRNSSaveToStream,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TChunktRNSAssign,false,0);
    DefineProp('BitTransparency',tkVariant,__GetTChunktRNSBitTransparency,nil,nil,false,0);
    DefineProp('TransparentColor',tkInteger,__GetTChunktRNSTransparentColor,__SetTChunktRNSTransparentColor,nil,false,0);
  end;
  With Scripter.DefineClass(TChunkIDAT) do
  begin
    DefineMethod('SaveToStream',1,tkVariant,nil,__TChunkIDATSaveToStream,false,0);
  end;
  With Scripter.DefineClass(TChunktIME) do
  begin
    DefineMethod('SaveToStream',1,tkVariant,nil,__TChunktIMESaveToStream,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TChunktIMEAssign,false,0);
    DefineProp('Year',tkInteger,__GetTChunktIMEYear,__SetTChunktIMEYear,nil,false,0);
    DefineProp('Month',tkInteger,__GetTChunktIMEMonth,__SetTChunktIMEMonth,nil,false,0);
    DefineProp('Day',tkInteger,__GetTChunktIMEDay,__SetTChunktIMEDay,nil,false,0);
    DefineProp('Hour',tkInteger,__GetTChunktIMEHour,__SetTChunktIMEHour,nil,false,0);
    DefineProp('Minute',tkInteger,__GetTChunktIMEMinute,__SetTChunktIMEMinute,nil,false,0);
    DefineProp('Second',tkInteger,__GetTChunktIMESecond,__SetTChunktIMESecond,nil,false,0);
  end;
  With Scripter.DefineClass(TChunktEXt) do
  begin
    DefineMethod('SaveToStream',1,tkVariant,nil,__TChunktEXtSaveToStream,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TChunktEXtAssign,false,0);
    DefineProp('Keyword',tkVariant,__GetTChunktEXtKeyword,__SetTChunktEXtKeyword,nil,false,0);
    DefineProp('Text',tkVariant,__GetTChunktEXtText,__SetTChunktEXtText,nil,false,0);
  end;
  With Scripter.DefineClass(TChunkzTXt) do
  begin
    DefineMethod('SaveToStream',1,tkVariant,nil,__TChunkzTXtSaveToStream,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('ByteSwap',1,tkInteger,nil,__ByteSwap,false,0);
    AddConstant('ptmNone',ptmNone);
    AddConstant('ptmBit',ptmBit);
    AddConstant('ptmPartial',ptmPartial);
    AddConstant('imNone',imNone);
    AddConstant('imAdam7',imAdam7);
    AddConstant('pfNone',pfNone);
    AddConstant('pfSub',pfSub);
    AddConstant('pfUp',pfUp);
    AddConstant('pfAverage',pfAverage);
    AddConstant('pfPaeth',pfPaeth);
    AddConstant('utUnknown',utUnknown);
    AddConstant('utMeter',utMeter);
    AddConstant('LibraryVersion',LibraryVersion);
    AddConstant('Z_NO_FLUSH',Z_NO_FLUSH);
    AddConstant('Z_FINISH',Z_FINISH);
    AddConstant('Z_STREAM_END',Z_STREAM_END);
    AddConstant('FILTER_NONE',FILTER_NONE);
    AddConstant('FILTER_SUB',FILTER_SUB);
    AddConstant('FILTER_UP',FILTER_UP);
    AddConstant('FILTER_AVERAGE',FILTER_AVERAGE);
    AddConstant('FILTER_PAETH',FILTER_PAETH);
    AddConstant('COLOR_GRAYSCALE',COLOR_GRAYSCALE);
    AddConstant('COLOR_RGB',COLOR_RGB);
    AddConstant('COLOR_PALETTE',COLOR_PALETTE);
    AddConstant('COLOR_GRAYSCALEALPHA',COLOR_GRAYSCALEALPHA);
    AddConstant('COLOR_RGBALPHA',COLOR_RGBALPHA);
  end;
end;

class function TatpngimageLibrary.LibraryName: string;
begin
  result := 'pngimage';
end;

initialization
  RegisterScripterLibrary(TatpngimageLibrary, True);

{$WARNINGS ON}

end.

