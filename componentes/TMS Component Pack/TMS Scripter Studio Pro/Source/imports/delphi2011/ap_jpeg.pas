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
unit ap_jpeg;

interface

uses
  Windows,
  SysUtils,
  Classes,
  Graphics,
  jpeg,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatjpegLibrary = class(TatScripterLibrary)
    procedure __TJPEGDataDestroy(AMachine: TatVirtualMachine);
    procedure __TJPEGImageCreate(AMachine: TatVirtualMachine);
    procedure __TJPEGImageDestroy(AMachine: TatVirtualMachine);
    procedure __TJPEGImageCompress(AMachine: TatVirtualMachine);
    procedure __TJPEGImageDIBNeeded(AMachine: TatVirtualMachine);
    procedure __TJPEGImageJPEGNeeded(AMachine: TatVirtualMachine);
    procedure __TJPEGImageAssign(AMachine: TatVirtualMachine);
    procedure __TJPEGImageLoadFromStream(AMachine: TatVirtualMachine);
    procedure __TJPEGImageSaveToStream(AMachine: TatVirtualMachine);
    procedure __TJPEGImageLoadFromClipboardFormat(AMachine: TatVirtualMachine);
    procedure __TJPEGImageSaveToClipboardFormat(AMachine: TatVirtualMachine);
    procedure __GetTJPEGImageGrayscale(AMachine: TatVirtualMachine);
    procedure __SetTJPEGImageGrayscale(AMachine: TatVirtualMachine);
    procedure __GetTJPEGImageProgressiveEncoding(AMachine: TatVirtualMachine);
    procedure __SetTJPEGImageProgressiveEncoding(AMachine: TatVirtualMachine);
    procedure __GetTJPEGImageCompressionQuality(AMachine: TatVirtualMachine);
    procedure __SetTJPEGImageCompressionQuality(AMachine: TatVirtualMachine);
    procedure __GetTJPEGImagePixelFormat(AMachine: TatVirtualMachine);
    procedure __SetTJPEGImagePixelFormat(AMachine: TatVirtualMachine);
    procedure __GetTJPEGImageProgressiveDisplay(AMachine: TatVirtualMachine);
    procedure __SetTJPEGImageProgressiveDisplay(AMachine: TatVirtualMachine);
    procedure __GetTJPEGImagePerformance(AMachine: TatVirtualMachine);
    procedure __SetTJPEGImagePerformance(AMachine: TatVirtualMachine);
    procedure __GetTJPEGImageScale(AMachine: TatVirtualMachine);
    procedure __SetTJPEGImageScale(AMachine: TatVirtualMachine);
    procedure __GetTJPEGImageSmoothing(AMachine: TatVirtualMachine);
    procedure __SetTJPEGImageSmoothing(AMachine: TatVirtualMachine);
    procedure __GetJPEGDefaults(AMachine: TatVirtualMachine);
    procedure __SetJPEGDefaults(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TJPEGDataClass = class of TJPEGData;
  TJPEGImageClass = class of TJPEGImage;


  TJPEGDefaultsWrapper = class(TatRecordWrapper)
  private
    FCompressionQuality: TJPEGQualityRange;
    FGrayscale: Boolean;
    FPerformance: TJPEGPerformance;
    FPixelFormat: TJPEGPixelFormat;
    FProgressiveDisplay: Boolean;
    FProgressiveEncoding: Boolean;
    FScale: TJPEGScale;
    FSmoothing: Boolean;
  public
    constructor Create(ARecord: TJPEGDefaults);
    function ObjToRec: TJPEGDefaults;
  published
    property CompressionQuality: TJPEGQualityRange read FCompressionQuality write FCompressionQuality;
    property Grayscale: Boolean read FGrayscale write FGrayscale;
    property Performance: TJPEGPerformance read FPerformance write FPerformance;
    property PixelFormat: TJPEGPixelFormat read FPixelFormat write FPixelFormat;
    property ProgressiveDisplay: Boolean read FProgressiveDisplay write FProgressiveDisplay;
    property ProgressiveEncoding: Boolean read FProgressiveEncoding write FProgressiveEncoding;
    property Scale: TJPEGScale read FScale write FScale;
    property Smoothing: Boolean read FSmoothing write FSmoothing;
  end;
  

implementation

constructor TJPEGDefaultsWrapper.Create(ARecord: TJPEGDefaults);
begin
  inherited Create;
  FCompressionQuality := ARecord.CompressionQuality;
  FGrayscale := ARecord.Grayscale;
  FPerformance := ARecord.Performance;
  FPixelFormat := ARecord.PixelFormat;
  FProgressiveDisplay := ARecord.ProgressiveDisplay;
  FProgressiveEncoding := ARecord.ProgressiveEncoding;
  FScale := ARecord.Scale;
  FSmoothing := ARecord.Smoothing;
end;

function TJPEGDefaultsWrapper.ObjToRec: TJPEGDefaults;
begin
  result.CompressionQuality := FCompressionQuality;
  result.Grayscale := FGrayscale;
  result.Performance := FPerformance;
  result.PixelFormat := FPixelFormat;
  result.ProgressiveDisplay := FProgressiveDisplay;
  result.ProgressiveEncoding := FProgressiveEncoding;
  result.Scale := FScale;
  result.Smoothing := FSmoothing;
end;



procedure TatjpegLibrary.__TJPEGDataDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TJPEGData(CurrentObject).Destroy;
  end;
end;

procedure TatjpegLibrary.__TJPEGImageCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TJPEGImageClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatjpegLibrary.__TJPEGImageDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TJPEGImage(CurrentObject).Destroy;
  end;
end;

procedure TatjpegLibrary.__TJPEGImageCompress(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TJPEGImage(CurrentObject).Compress;
  end;
end;

procedure TatjpegLibrary.__TJPEGImageDIBNeeded(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TJPEGImage(CurrentObject).DIBNeeded;
  end;
end;

procedure TatjpegLibrary.__TJPEGImageJPEGNeeded(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TJPEGImage(CurrentObject).JPEGNeeded;
  end;
end;

procedure TatjpegLibrary.__TJPEGImageAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TJPEGImage(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatjpegLibrary.__TJPEGImageLoadFromStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TJPEGImage(CurrentObject).LoadFromStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatjpegLibrary.__TJPEGImageSaveToStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TJPEGImage(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatjpegLibrary.__TJPEGImageLoadFromClipboardFormat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TJPEGImage(CurrentObject).LoadFromClipboardFormat(VarToInteger(GetInputArg(0)),GetInputArg(1),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatjpegLibrary.__TJPEGImageSaveToClipboardFormat(AMachine: TatVirtualMachine);
  var
  Param0: Word;
  Param1: THandle;
  Param2: HPALETTE;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
Param1 := GetInputArg(1);
Param2 := VarToInteger(GetInputArg(2));
    TJPEGImage(CurrentObject).SaveToClipboardFormat(Param0,Param1,Param2);
    SetInputArg(0,Integer(Param0));
    SetInputArg(1,Param1);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatjpegLibrary.__GetTJPEGImageGrayscale(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TJPEGImage(CurrentObject).Grayscale);
  end;
end;

procedure TatjpegLibrary.__SetTJPEGImageGrayscale(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TJPEGImage(CurrentObject).Grayscale:=GetInputArg(0);
  end;
end;

procedure TatjpegLibrary.__GetTJPEGImageProgressiveEncoding(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TJPEGImage(CurrentObject).ProgressiveEncoding);
  end;
end;

procedure TatjpegLibrary.__SetTJPEGImageProgressiveEncoding(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TJPEGImage(CurrentObject).ProgressiveEncoding:=GetInputArg(0);
  end;
end;

procedure TatjpegLibrary.__GetTJPEGImageCompressionQuality(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TJPEGImage(CurrentObject).CompressionQuality);
  end;
end;

procedure TatjpegLibrary.__SetTJPEGImageCompressionQuality(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TJPEGImage(CurrentObject).CompressionQuality:=GetInputArg(0);
  end;
end;

procedure TatjpegLibrary.__GetTJPEGImagePixelFormat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TJPEGImage(CurrentObject).PixelFormat);
  end;
end;

procedure TatjpegLibrary.__SetTJPEGImagePixelFormat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TJPEGImage(CurrentObject).PixelFormat:=GetInputArg(0);
  end;
end;

procedure TatjpegLibrary.__GetTJPEGImageProgressiveDisplay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TJPEGImage(CurrentObject).ProgressiveDisplay);
  end;
end;

procedure TatjpegLibrary.__SetTJPEGImageProgressiveDisplay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TJPEGImage(CurrentObject).ProgressiveDisplay:=GetInputArg(0);
  end;
end;

procedure TatjpegLibrary.__GetTJPEGImagePerformance(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TJPEGImage(CurrentObject).Performance);
  end;
end;

procedure TatjpegLibrary.__SetTJPEGImagePerformance(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TJPEGImage(CurrentObject).Performance:=GetInputArg(0);
  end;
end;

procedure TatjpegLibrary.__GetTJPEGImageScale(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TJPEGImage(CurrentObject).Scale);
  end;
end;

procedure TatjpegLibrary.__SetTJPEGImageScale(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TJPEGImage(CurrentObject).Scale:=GetInputArg(0);
  end;
end;

procedure TatjpegLibrary.__GetTJPEGImageSmoothing(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TJPEGImage(CurrentObject).Smoothing);
  end;
end;

procedure TatjpegLibrary.__SetTJPEGImageSmoothing(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TJPEGImage(CurrentObject).Smoothing:=GetInputArg(0);
  end;
end;

procedure TatjpegLibrary.__GetJPEGDefaults(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TJPEGDefaultsWrapper.Create(jpeg.JPEGDefaults)));
  end;
end;

procedure TatjpegLibrary.__SetJPEGDefaults(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    jpeg.JPEGDefaults:=TJPEGDefaultsWrapper(integer(GetInputArg(0))).ObjToRec;
  end;
end;

procedure TatjpegLibrary.Init;
begin
  With Scripter.DefineClass(TJPEGData) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TJPEGDataDestroy,false,0);
  end;
  With Scripter.DefineClass(TJPEGImage) do
  begin
    DefineMethod('Create',0,tkClass,TJPEGImage,__TJPEGImageCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TJPEGImageDestroy,false,0);
    DefineMethod('Compress',0,tkNone,nil,__TJPEGImageCompress,false,0);
    DefineMethod('DIBNeeded',0,tkNone,nil,__TJPEGImageDIBNeeded,false,0);
    DefineMethod('JPEGNeeded',0,tkNone,nil,__TJPEGImageJPEGNeeded,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TJPEGImageAssign,false,0);
    DefineMethod('LoadFromStream',1,tkNone,nil,__TJPEGImageLoadFromStream,false,0);
    DefineMethod('SaveToStream',1,tkNone,nil,__TJPEGImageSaveToStream,false,0);
    DefineMethod('LoadFromClipboardFormat',3,tkNone,nil,__TJPEGImageLoadFromClipboardFormat,false,0);
    DefineMethod('SaveToClipboardFormat',3,tkNone,nil,__TJPEGImageSaveToClipboardFormat,false,0).SetVarArgs([0,1,2]);
    DefineProp('Grayscale',tkVariant,__GetTJPEGImageGrayscale,__SetTJPEGImageGrayscale,nil,false,0);
    DefineProp('ProgressiveEncoding',tkVariant,__GetTJPEGImageProgressiveEncoding,__SetTJPEGImageProgressiveEncoding,nil,false,0);
    DefineProp('CompressionQuality',tkEnumeration,__GetTJPEGImageCompressionQuality,__SetTJPEGImageCompressionQuality,nil,false,0);
    DefineProp('PixelFormat',tkEnumeration,__GetTJPEGImagePixelFormat,__SetTJPEGImagePixelFormat,nil,false,0);
    DefineProp('ProgressiveDisplay',tkVariant,__GetTJPEGImageProgressiveDisplay,__SetTJPEGImageProgressiveDisplay,nil,false,0);
    DefineProp('Performance',tkEnumeration,__GetTJPEGImagePerformance,__SetTJPEGImagePerformance,nil,false,0);
    DefineProp('Scale',tkEnumeration,__GetTJPEGImageScale,__SetTJPEGImageScale,nil,false,0);
    DefineProp('Smoothing',tkVariant,__GetTJPEGImageSmoothing,__SetTJPEGImageSmoothing,nil,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('JPEGDefaults',tkVariant,__GetJPEGDefaults,__SetJPEGDefaults,nil,false,0);
    AddConstant('jpBestQuality',jpBestQuality);
    AddConstant('jpBestSpeed',jpBestSpeed);
    AddConstant('jsFullSize',jsFullSize);
    AddConstant('jsHalf',jsHalf);
    AddConstant('jsQuarter',jsQuarter);
    AddConstant('jsEighth',jsEighth);
    AddConstant('jf24Bit',jf24Bit);
    AddConstant('jf8Bit',jf8Bit);
  end;
end;

class function TatjpegLibrary.LibraryName: string;
begin
  result := 'jpeg';
end;

initialization
  RegisterScripterLibrary(TatjpegLibrary, True);

{$WARNINGS ON}

end.

