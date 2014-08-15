{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB   }

unit ppWinEmbedFont;

interface

uses
  Windows,
  Classes,
  SysUtils;

const

//--CREATEFONTPACKAGE CONSTANTS--//

  // for usSubsetFormat
  TTFCFP_SUBSET  = 0;	  // Straight Subset Font - Backward compatibility
  TTFCFP_SUBSET1 = 1;	  // Subset font with full TTO and Kern tables. For later merge
  TTFCFP_DELTA   = 2;	  // Delta font, for merge with a subset1 font

  // for usSubsetPlatform ID values
  TTFCFP_UNICODE_PLATFORMID = 0;
  TTFCFP_APPLE_PLATFORMID   = 1;
  TTFCFP_ISO_PLATFORMID     = 2;
  TTFCFP_MS_PLATFORMID      = 3;

  // for usSubsetEncoding values
  TTFCFP_STD_MAC_CHAR_SET = 0;	// goes with TTFSUB_APPLE_PLATFORMID
  TTFCFP_SYMBOL_CHAR_SET  = 0;  // goes with TTFSUB_MS_PLATFORMID
  TTFCFP_UNICODE_CHAR_SET = 1;	// goes with TTFSUB_MS_PLATFORMID
  TTFCFP_DONT_CARE        = $FFFF;

  // for usSubsetLanguage values
  TTFCFP_LANG_KEEP_ALL = 0;

  // for usFlags values
  TTFCFP_FLAGS_SUBSET    = $0001;	 // if bit off, don't subset
  TTFCFP_FLAGS_COMPRESS  = $0002;  // if bit off, don't compress
  TTFCFP_FLAGS_TTC       = $0004;  // if bit off, its a TTF
  TTFCFP_FLAGS_GLYPHLIST = $0008;  // if bit off, list is characters

type

{$IFNDEF Delphi14}
  USHORT = Word;
  {$EXTERNALSYM USHORT}
{$ENDIF}

  PUSHORT = ^USHORT;
  {$EXTERNALSYM PUSHORT}

//--CREATEFONTPACKAGE CALLBACKS--//

  TCFP_ALLOCPROC = function (aSize: ULONG): Pointer; cdecl;
  TCFP_REALLOCPROC = function (aMemBlock: Pointer; aSize: ULONG): Pointer; cdecl;
  TCFP_FREEPROC = procedure (aMemBlock: Pointer); cdecl;

//--CREATEFONTPACKAGE--//
  {$EXTERNALSYM CreateFontPackage}
  function CreateFontPackage(puchSrcBuffer: PUCHAR;                  //input TTF or TTC buffer
                             ulSrcBufferSize: ULONG;                 //size of input TTF or TTC buffer data
                             ppuchFontPackageBuffer: Pointer;        //output package buffer
                             pulFontPackageBufferSize: PULONG;       //output package buffer size
                             pulBytesWritten: PULONG;                //output package buffer data length
                             usFlag: USHORT;                         //subset, compress, or both, TTF or TTC, Chars or Glyphs
                             usTTCIndex: USHORT;                     //TTC Index, only used if TTC bit set
                             usSubsetFormat: USHORT;                 //Old Subset, Subset or Delta
                             usSubsetLanguage: USHORT;               //Language in Name table to keep
                             usSubsetPlatform: USHORT;               //if ListType is Character, Platform of cmap to use for glyph list
                             usSubsetEncoding: USHORT;               //if ListType is Character, Encoding of cmap to use for glyph list
                             pusSubsetKeepList: PUSHORT;             //List of Characters or Glyphs to keep
                             usSubsetListCount: USHORT;              //number of elements in list
                             lpfnAllocate: TCFP_ALLOCPROC;           //call back function to allocate temp buffers and output buffers
                             lpfnReAllocate: TCFP_REALLOCPROC;       //call back function to reallocate temp and output buffers
                             lpfnFree: TCFP_FREEPROC;                //call back function to free buffer allocated with lpfnAllocate and lpfnReAllocate
                             lpvReserved: Pointer): SHORT; cdecl;    //Must be NULL

  function  ppCreateFontSubset(aHDC: HDC; aCharList: TStringList; var aBuffer: PUCHAR): Integer;
  function  ppGetFontFile(aHDC: HDC; var aBuffer: PUCHAR): Integer;

  function  ppAllocMem(Size: Cardinal): Pointer; cdecl;
  procedure ppFreeMem(P: Pointer); cdecl;
  procedure ppReAllocMem(P: Pointer; Size: Integer); cdecl;

const
  FONTSUB = 'FONTSUB.dll';  //CreateFontPackage


implementation

//Win API
function  CreateFontPackage; external FONTSUB name 'CreateFontPackage';

//Embed/Subset routines
function  ppGetFontFile(aHDC: HDC; var aBuffer: PUCHAR): Integer;
var
  lFileSize: DWORD;
begin

  lFileSize := GetFontData(aHDC, 0, 0, nil, 0);
  GetMem(aBuffer, lFileSize);

  GetFontData(aHDC, 0, 0, aBuffer, lFileSize);

  Result := lFileSize;

end;

function  ppCreateFontSubset(aHDC: HDC; aCharList: TStringList; var aBuffer: PUCHAR): Integer;
var
  lFontFile: PUCHAR;
  lOutBufferSize: Cardinal;
  lBytesWritten: Cardinal;
  lFontFileSize: Cardinal;
  lKeepList: array of WORD;
  liIndex: Integer;
  liError: Integer;
  lsText: String;
begin

  lFontFile := nil;
  Result := 0;

  try

    lFontFileSize := ppGetFontFile(aHDC, lFontFile);
    SetLength(lKeepList, aCharList.Count);

    lsText := SysUtils.StringReplace(aCharList.Text, #13#10, '', [rfReplaceAll]);
    for liIndex := 0 to aCharList.Count - 1 do
      lKeepList[liIndex] := Ord(lsText[liIndex + 1]);

    liError := CreateFontPackage(lFontFile, lFontFileSize, @aBuffer, @lOutBufferSize, @lBytesWritten, TTFCFP_FLAGS_SUBSET,
                               0, TTFCFP_SUBSET, 0, TTFCFP_MS_PLATFORMID, TTFCFP_DONT_CARE, @lKeepList[0], Length(lKeepList),
                               @ppAllocMem, @ppReAllocMem, @ppFreeMem, nil);

    if liError <> 0 then
      raise Exception.Create('Error: ' + IntToStr(liError));

    Result := lBytesWritten;

  finally
    FreeMem(lFontFile);
  end;

end;

//Subset callback functions
function ppAllocMem(Size: Cardinal): Pointer; cdecl;
begin
  Result := AllocMem(Size);
end;

procedure ppFreeMem(P: Pointer); cdecl;
begin
  FreeMem(P);
end;

procedure ppReAllocMem(P: Pointer; Size: Integer); cdecl;
begin
  ReAllocMem(P, Size);
end;

end.
