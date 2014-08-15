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
unit ap_GIFConsts;

interface

uses
  GIFConsts,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatGIFConstsLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatGIFConstsLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('sOutOfData',sOutOfData);
    AddConstant('sTooManyColors',sTooManyColors);
    AddConstant('sBadColorIndex',sBadColorIndex);
    AddConstant('sBadColorIndexFixed',sBadColorIndexFixed);
    AddConstant('sGIFErrorSaveEmpty',sGIFErrorSaveEmpty);
    AddConstant('sBadSignature',sBadSignature);
    AddConstant('sScreenBadColorSize',sScreenBadColorSize);
    AddConstant('sImageBadColorSize',sImageBadColorSize);
    AddConstant('sUnknownExtension',sUnknownExtension);
    AddConstant('sBadExtensionLabel',sBadExtensionLabel);
    AddConstant('sOutOfMemDIB',sOutOfMemDIB);
    AddConstant('sDIBCreate',sDIBCreate);
    AddConstant('sDecodeTooFewBits',sDecodeTooFewBits);
    AddConstant('sDecodeCircular',sDecodeCircular);
    AddConstant('sBadTrailer',sBadTrailer);
    AddConstant('sBadExtensionInstance',sBadExtensionInstance);
    AddConstant('sBadBlockSize',sBadBlockSize);
    AddConstant('sBadBlock',sBadBlock);
    AddConstant('sUnsupportedClass',sUnsupportedClass);
    AddConstant('sInvalidData',sInvalidData);
    AddConstant('sBadSize',sBadSize);
    AddConstant('sFailedPaste',sFailedPaste);
    AddConstant('sTPictureConflict',sTPictureConflict);
    AddConstant('sScreenSizeExceeded',sScreenSizeExceeded);
    AddConstant('sNoColorTable',sNoColorTable);
    AddConstant('sBadPixelCoordinates',sBadPixelCoordinates);
    AddConstant('sUnsupportedBitmap',sUnsupportedBitmap);
    AddConstant('sInvalidPixelFormat',sInvalidPixelFormat);
    AddConstant('sBadDimension',sBadDimension);
    AddConstant('sNoDIB',sNoDIB);
    AddConstant('sInvalidStream',sInvalidStream);
    AddConstant('sInvalidColor',sInvalidColor);
    AddConstant('sInvalidBitSize',sInvalidBitSize);
    AddConstant('sEmptyColorMap',sEmptyColorMap);
    AddConstant('sEmptyImage',sEmptyImage);
    AddConstant('sInvalidBitmapList',sInvalidBitmapList);
    AddConstant('sInvalidReduction',sInvalidReduction);
    AddConstant('sMultipleGCE',sMultipleGCE);
    AddConstant('sNoPalette',sNoPalette);
    AddConstant('sGIFImageFile',sGIFImageFile);
    AddConstant('sProgressLoading',sProgressLoading);
    AddConstant('sProgressSaving',sProgressSaving);
    AddConstant('sProgressConverting',sProgressConverting);
    AddConstant('sProgressRendering',sProgressRendering);
    AddConstant('sProgressCopying',sProgressCopying);
    AddConstant('sProgressOptimizing',sProgressOptimizing);
  end;
end;

class function TatGIFConstsLibrary.LibraryName: string;
begin
  result := 'GIFConsts';
end;

initialization
  RegisterScripterLibrary(TatGIFConstsLibrary, True);

{$WARNINGS ON}

end.

