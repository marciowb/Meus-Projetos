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
unit ap_pnglang;

interface

uses
  pnglang,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatpnglangLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatpnglangLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('EPngInvalidCRCText',EPngInvalidCRCText);
    AddConstant('EPNGInvalidIHDRText',EPNGInvalidIHDRText);
    AddConstant('EPNGMissingMultipleIDATText',EPNGMissingMultipleIDATText);
    AddConstant('EPNGZLIBErrorText',EPNGZLIBErrorText);
    AddConstant('EPNGInvalidPaletteText',EPNGInvalidPaletteText);
    AddConstant('EPNGInvalidFileHeaderText',EPNGInvalidFileHeaderText);
    AddConstant('EPNGIHDRNotFirstText',EPNGIHDRNotFirstText);
    AddConstant('EPNGNotExistsText',EPNGNotExistsText);
    AddConstant('EPNGSizeExceedsText',EPNGSizeExceedsText);
    AddConstant('EPNGUnknownPalEntryText',EPNGUnknownPalEntryText);
    AddConstant('EPNGMissingPaletteText',EPNGMissingPaletteText);
    AddConstant('EPNGUnknownCriticalChunkText',EPNGUnknownCriticalChunkText);
    AddConstant('EPNGUnknownCompressionText',EPNGUnknownCompressionText);
    AddConstant('EPNGUnknownInterlaceText',EPNGUnknownInterlaceText);
    AddConstant('EPNGCannotAssignChunkText',EPNGCannotAssignChunkText);
    AddConstant('EPNGUnexpectedEndText',EPNGUnexpectedEndText);
    AddConstant('EPNGNoImageDataText',EPNGNoImageDataText);
    AddConstant('EPNGCannotAddChunkText',EPNGCannotAddChunkText);
    AddConstant('EPNGCannotAddInvalidImageText',EPNGCannotAddInvalidImageText);
    AddConstant('EPNGCouldNotLoadResourceText',EPNGCouldNotLoadResourceText);
    AddConstant('EPNGOutMemoryText',EPNGOutMemoryText);
    AddConstant('EPNGCannotChangeTransparentText',EPNGCannotChangeTransparentText);
    AddConstant('EPNGHeaderNotPresentText',EPNGHeaderNotPresentText);
    AddConstant('EInvalidNewSize',EInvalidNewSize);
    AddConstant('EInvalidSpec',EInvalidSpec);
  end;
end;

class function TatpnglangLibrary.LibraryName: string;
begin
  result := 'pnglang';
end;

initialization
  RegisterScripterLibrary(TatpnglangLibrary, True);

{$WARNINGS ON}

end.

