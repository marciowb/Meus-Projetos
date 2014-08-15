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
unit ap_ShLwApi;

interface

uses
  Windows,
  ActiveX,
  ShlObj,
  ShLwApi,
  Variants,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatShLwApiLibrary = class(TatScripterLibrary)
    procedure __StrChr(AMachine: TatVirtualMachine);
    procedure __StrChrA(AMachine: TatVirtualMachine);
    procedure __StrChrW(AMachine: TatVirtualMachine);
    procedure __StrChrI(AMachine: TatVirtualMachine);
    procedure __StrChrIA(AMachine: TatVirtualMachine);
    procedure __StrChrIW(AMachine: TatVirtualMachine);
    procedure __StrCmpN(AMachine: TatVirtualMachine);
    procedure __StrCmpNA(AMachine: TatVirtualMachine);
    procedure __StrCmpNW(AMachine: TatVirtualMachine);
    procedure __StrCmpNI(AMachine: TatVirtualMachine);
    procedure __StrCmpNIA(AMachine: TatVirtualMachine);
    procedure __StrCmpNIW(AMachine: TatVirtualMachine);
    procedure __StrCSpn(AMachine: TatVirtualMachine);
    procedure __StrCSpnA(AMachine: TatVirtualMachine);
    procedure __StrCSpnW(AMachine: TatVirtualMachine);
    procedure __StrCSpnI(AMachine: TatVirtualMachine);
    procedure __StrCSpnIA(AMachine: TatVirtualMachine);
    procedure __StrCSpnIW(AMachine: TatVirtualMachine);
    procedure __StrDup(AMachine: TatVirtualMachine);
    procedure __StrDupA(AMachine: TatVirtualMachine);
    procedure __StrDupW(AMachine: TatVirtualMachine);
    procedure __StrFormatByteSizeA(AMachine: TatVirtualMachine);
    procedure __StrFormatByteSizeW(AMachine: TatVirtualMachine);
    procedure __StrFormatByteSize(AMachine: TatVirtualMachine);
    procedure __StrFormatKBSize(AMachine: TatVirtualMachine);
    procedure __StrFormatKBSizeA(AMachine: TatVirtualMachine);
    procedure __StrFormatKBSizeW(AMachine: TatVirtualMachine);
    procedure __StrFromTimeInterval(AMachine: TatVirtualMachine);
    procedure __StrFromTimeIntervalA(AMachine: TatVirtualMachine);
    procedure __StrFromTimeIntervalW(AMachine: TatVirtualMachine);
    procedure __StrIsIntlEqual(AMachine: TatVirtualMachine);
    procedure __StrIsIntlEqualA(AMachine: TatVirtualMachine);
    procedure __StrIsIntlEqualW(AMachine: TatVirtualMachine);
    procedure __StrNCat(AMachine: TatVirtualMachine);
    procedure __StrNCatA(AMachine: TatVirtualMachine);
    procedure __StrNCatW(AMachine: TatVirtualMachine);
    procedure __StrPBrk(AMachine: TatVirtualMachine);
    procedure __StrPBrkA(AMachine: TatVirtualMachine);
    procedure __StrPBrkW(AMachine: TatVirtualMachine);
    procedure __StrRChr(AMachine: TatVirtualMachine);
    procedure __StrRChrA(AMachine: TatVirtualMachine);
    procedure __StrRChrW(AMachine: TatVirtualMachine);
    procedure __StrRChrI(AMachine: TatVirtualMachine);
    procedure __StrRChrIA(AMachine: TatVirtualMachine);
    procedure __StrRChrIW(AMachine: TatVirtualMachine);
    procedure __StrRStrI(AMachine: TatVirtualMachine);
    procedure __StrRStrIA(AMachine: TatVirtualMachine);
    procedure __StrRStrIW(AMachine: TatVirtualMachine);
    procedure __StrSpn(AMachine: TatVirtualMachine);
    procedure __StrSpnA(AMachine: TatVirtualMachine);
    procedure __StrSpnW(AMachine: TatVirtualMachine);
    procedure __StrStr(AMachine: TatVirtualMachine);
    procedure __StrStrA(AMachine: TatVirtualMachine);
    procedure __StrStrW(AMachine: TatVirtualMachine);
    procedure __StrStrI(AMachine: TatVirtualMachine);
    procedure __StrStrIA(AMachine: TatVirtualMachine);
    procedure __StrStrIW(AMachine: TatVirtualMachine);
    procedure __StrToInt(AMachine: TatVirtualMachine);
    procedure __StrToIntA(AMachine: TatVirtualMachine);
    procedure __StrToIntW(AMachine: TatVirtualMachine);
    procedure __StrToIntEx(AMachine: TatVirtualMachine);
    procedure __StrToIntExA(AMachine: TatVirtualMachine);
    procedure __StrToIntExW(AMachine: TatVirtualMachine);
    procedure __StrTrim(AMachine: TatVirtualMachine);
    procedure __StrTrimA(AMachine: TatVirtualMachine);
    procedure __StrTrimW(AMachine: TatVirtualMachine);
    procedure __StrCatBuff(AMachine: TatVirtualMachine);
    procedure __StrCatBuffA(AMachine: TatVirtualMachine);
    procedure __StrCatBuffW(AMachine: TatVirtualMachine);
    procedure __SHStrDup(AMachine: TatVirtualMachine);
    procedure __SHStrDupA(AMachine: TatVirtualMachine);
    procedure __SHStrDupW(AMachine: TatVirtualMachine);
    procedure __IntlStrEqWorker(AMachine: TatVirtualMachine);
    procedure __IntlStrEqWorkerA(AMachine: TatVirtualMachine);
    procedure __IntlStrEqWorkerW(AMachine: TatVirtualMachine);
    procedure __IntlStrEqN(AMachine: TatVirtualMachine);
    procedure __IntlStrEqNA(AMachine: TatVirtualMachine);
    procedure __IntlStrEqNW(AMachine: TatVirtualMachine);
    procedure __PathIsHTMLFile(AMachine: TatVirtualMachine);
    procedure __PathIsHTMLFileA(AMachine: TatVirtualMachine);
    procedure __PathIsHTMLFileW(AMachine: TatVirtualMachine);
    procedure __StrCatA(AMachine: TatVirtualMachine);
    procedure __StrCatW(AMachine: TatVirtualMachine);
    procedure __StrCat(AMachine: TatVirtualMachine);
    procedure __StrCmpA(AMachine: TatVirtualMachine);
    procedure __StrCmpW(AMachine: TatVirtualMachine);
    procedure __StrCmp(AMachine: TatVirtualMachine);
    procedure __StrCpyA(AMachine: TatVirtualMachine);
    procedure __StrCpyW(AMachine: TatVirtualMachine);
    procedure __StrCpy(AMachine: TatVirtualMachine);
    procedure __StrCpyNA(AMachine: TatVirtualMachine);
    procedure __StrCpyNW(AMachine: TatVirtualMachine);
    procedure __StrCpyN(AMachine: TatVirtualMachine);
    procedure __StrToLong(AMachine: TatVirtualMachine);
    procedure __StrToLongA(AMachine: TatVirtualMachine);
    procedure __StrToLongW(AMachine: TatVirtualMachine);
    procedure __StrNCmp(AMachine: TatVirtualMachine);
    procedure __StrNCmpA(AMachine: TatVirtualMachine);
    procedure __StrNCmpW(AMachine: TatVirtualMachine);
    procedure __StrNCmpI(AMachine: TatVirtualMachine);
    procedure __StrNCmpIA(AMachine: TatVirtualMachine);
    procedure __StrNCmpIW(AMachine: TatVirtualMachine);
    procedure __StrNCpy(AMachine: TatVirtualMachine);
    procedure __StrNCpyA(AMachine: TatVirtualMachine);
    procedure __StrNCpyW(AMachine: TatVirtualMachine);
    procedure __StrCatN(AMachine: TatVirtualMachine);
    procedure __StrCatNA(AMachine: TatVirtualMachine);
    procedure __StrCatNW(AMachine: TatVirtualMachine);
    procedure __PathAddBackslash(AMachine: TatVirtualMachine);
    procedure __PathAddBackslashA(AMachine: TatVirtualMachine);
    procedure __PathAddBackslashW(AMachine: TatVirtualMachine);
    procedure __PathAddExtension(AMachine: TatVirtualMachine);
    procedure __PathAddExtensionA(AMachine: TatVirtualMachine);
    procedure __PathAddExtensionW(AMachine: TatVirtualMachine);
    procedure __PathAppend(AMachine: TatVirtualMachine);
    procedure __PathAppendA(AMachine: TatVirtualMachine);
    procedure __PathAppendW(AMachine: TatVirtualMachine);
    procedure __PathBuildRoot(AMachine: TatVirtualMachine);
    procedure __PathBuildRootA(AMachine: TatVirtualMachine);
    procedure __PathBuildRootW(AMachine: TatVirtualMachine);
    procedure __PathCanonicalize(AMachine: TatVirtualMachine);
    procedure __PathCanonicalizeA(AMachine: TatVirtualMachine);
    procedure __PathCanonicalizeW(AMachine: TatVirtualMachine);
    procedure __PathCombine(AMachine: TatVirtualMachine);
    procedure __PathCombineA(AMachine: TatVirtualMachine);
    procedure __PathCombineW(AMachine: TatVirtualMachine);
    procedure __PathCompactPath(AMachine: TatVirtualMachine);
    procedure __PathCompactPathA(AMachine: TatVirtualMachine);
    procedure __PathCompactPathW(AMachine: TatVirtualMachine);
    procedure __PathCompactPathEx(AMachine: TatVirtualMachine);
    procedure __PathCompactPathExA(AMachine: TatVirtualMachine);
    procedure __PathCompactPathExW(AMachine: TatVirtualMachine);
    procedure __PathCommonPrefix(AMachine: TatVirtualMachine);
    procedure __PathCommonPrefixA(AMachine: TatVirtualMachine);
    procedure __PathCommonPrefixW(AMachine: TatVirtualMachine);
    procedure __PathFileExists(AMachine: TatVirtualMachine);
    procedure __PathFileExistsA(AMachine: TatVirtualMachine);
    procedure __PathFileExistsW(AMachine: TatVirtualMachine);
    procedure __PathFindExtension(AMachine: TatVirtualMachine);
    procedure __PathFindExtensionA(AMachine: TatVirtualMachine);
    procedure __PathFindExtensionW(AMachine: TatVirtualMachine);
    procedure __PathFindFileName(AMachine: TatVirtualMachine);
    procedure __PathFindFileNameA(AMachine: TatVirtualMachine);
    procedure __PathFindFileNameW(AMachine: TatVirtualMachine);
    procedure __PathFindNextComponent(AMachine: TatVirtualMachine);
    procedure __PathFindNextComponentA(AMachine: TatVirtualMachine);
    procedure __PathFindNextComponentW(AMachine: TatVirtualMachine);
    procedure __PathFindOnPath(AMachine: TatVirtualMachine);
    procedure __PathFindOnPathA(AMachine: TatVirtualMachine);
    procedure __PathFindOnPathW(AMachine: TatVirtualMachine);
    procedure __PathGetArgs(AMachine: TatVirtualMachine);
    procedure __PathGetArgsA(AMachine: TatVirtualMachine);
    procedure __PathGetArgsW(AMachine: TatVirtualMachine);
    procedure __PathFindSuffixArray(AMachine: TatVirtualMachine);
    procedure __PathFindSuffixArrayA(AMachine: TatVirtualMachine);
    procedure __PathFindSuffixArrayW(AMachine: TatVirtualMachine);
    procedure __PathIsLFNFileSpec(AMachine: TatVirtualMachine);
    procedure __PathIsLFNFileSpecA(AMachine: TatVirtualMachine);
    procedure __PathIsLFNFileSpecW(AMachine: TatVirtualMachine);
    procedure __PathGetCharType(AMachine: TatVirtualMachine);
    procedure __PathGetCharTypeA(AMachine: TatVirtualMachine);
    procedure __PathGetCharTypeW(AMachine: TatVirtualMachine);
    procedure __PathGetDriveNumber(AMachine: TatVirtualMachine);
    procedure __PathGetDriveNumberA(AMachine: TatVirtualMachine);
    procedure __PathGetDriveNumberW(AMachine: TatVirtualMachine);
    procedure __PathIsDirectory(AMachine: TatVirtualMachine);
    procedure __PathIsDirectoryA(AMachine: TatVirtualMachine);
    procedure __PathIsDirectoryW(AMachine: TatVirtualMachine);
    procedure __PathIsDirectoryEmpty(AMachine: TatVirtualMachine);
    procedure __PathIsDirectoryEmptyA(AMachine: TatVirtualMachine);
    procedure __PathIsDirectoryEmptyW(AMachine: TatVirtualMachine);
    procedure __PathIsFileSpec(AMachine: TatVirtualMachine);
    procedure __PathIsFileSpecA(AMachine: TatVirtualMachine);
    procedure __PathIsFileSpecW(AMachine: TatVirtualMachine);
    procedure __PathIsPrefix(AMachine: TatVirtualMachine);
    procedure __PathIsPrefixA(AMachine: TatVirtualMachine);
    procedure __PathIsPrefixW(AMachine: TatVirtualMachine);
    procedure __PathIsRelative(AMachine: TatVirtualMachine);
    procedure __PathIsRelativeA(AMachine: TatVirtualMachine);
    procedure __PathIsRelativeW(AMachine: TatVirtualMachine);
    procedure __PathIsRoot(AMachine: TatVirtualMachine);
    procedure __PathIsRootA(AMachine: TatVirtualMachine);
    procedure __PathIsRootW(AMachine: TatVirtualMachine);
    procedure __PathIsSameRoot(AMachine: TatVirtualMachine);
    procedure __PathIsSameRootA(AMachine: TatVirtualMachine);
    procedure __PathIsSameRootW(AMachine: TatVirtualMachine);
    procedure __PathIsUNC(AMachine: TatVirtualMachine);
    procedure __PathIsUNCA(AMachine: TatVirtualMachine);
    procedure __PathIsUNCW(AMachine: TatVirtualMachine);
    procedure __PathIsNetworkPath(AMachine: TatVirtualMachine);
    procedure __PathIsNetworkPathA(AMachine: TatVirtualMachine);
    procedure __PathIsNetworkPathW(AMachine: TatVirtualMachine);
    procedure __PathIsUNCServer(AMachine: TatVirtualMachine);
    procedure __PathIsUNCServerA(AMachine: TatVirtualMachine);
    procedure __PathIsUNCServerW(AMachine: TatVirtualMachine);
    procedure __PathIsUNCServerShare(AMachine: TatVirtualMachine);
    procedure __PathIsUNCServerShareA(AMachine: TatVirtualMachine);
    procedure __PathIsUNCServerShareW(AMachine: TatVirtualMachine);
    procedure __PathIsContentType(AMachine: TatVirtualMachine);
    procedure __PathIsContentTypeA(AMachine: TatVirtualMachine);
    procedure __PathIsContentTypeW(AMachine: TatVirtualMachine);
    procedure __PathIsURL(AMachine: TatVirtualMachine);
    procedure __PathIsURLA(AMachine: TatVirtualMachine);
    procedure __PathIsURLW(AMachine: TatVirtualMachine);
    procedure __PathMakePretty(AMachine: TatVirtualMachine);
    procedure __PathMakePrettyA(AMachine: TatVirtualMachine);
    procedure __PathMakePrettyW(AMachine: TatVirtualMachine);
    procedure __PathMatchSpec(AMachine: TatVirtualMachine);
    procedure __PathMatchSpecA(AMachine: TatVirtualMachine);
    procedure __PathMatchSpecW(AMachine: TatVirtualMachine);
    procedure __PathParseIconLocation(AMachine: TatVirtualMachine);
    procedure __PathParseIconLocationA(AMachine: TatVirtualMachine);
    procedure __PathParseIconLocationW(AMachine: TatVirtualMachine);
    procedure __PathQuoteSpaces(AMachine: TatVirtualMachine);
    procedure __PathQuoteSpacesA(AMachine: TatVirtualMachine);
    procedure __PathQuoteSpacesW(AMachine: TatVirtualMachine);
    procedure __PathRelativePathTo(AMachine: TatVirtualMachine);
    procedure __PathRelativePathToA(AMachine: TatVirtualMachine);
    procedure __PathRelativePathToW(AMachine: TatVirtualMachine);
    procedure __PathRemoveArgs(AMachine: TatVirtualMachine);
    procedure __PathRemoveArgsA(AMachine: TatVirtualMachine);
    procedure __PathRemoveArgsW(AMachine: TatVirtualMachine);
    procedure __PathRemoveBackslash(AMachine: TatVirtualMachine);
    procedure __PathRemoveBackslashA(AMachine: TatVirtualMachine);
    procedure __PathRemoveBackslashW(AMachine: TatVirtualMachine);
    procedure __PathRemoveBlanks(AMachine: TatVirtualMachine);
    procedure __PathRemoveBlanksA(AMachine: TatVirtualMachine);
    procedure __PathRemoveBlanksW(AMachine: TatVirtualMachine);
    procedure __PathRemoveExtension(AMachine: TatVirtualMachine);
    procedure __PathRemoveExtensionA(AMachine: TatVirtualMachine);
    procedure __PathRemoveExtensionW(AMachine: TatVirtualMachine);
    procedure __PathRemoveFileSpec(AMachine: TatVirtualMachine);
    procedure __PathRemoveFileSpecA(AMachine: TatVirtualMachine);
    procedure __PathRemoveFileSpecW(AMachine: TatVirtualMachine);
    procedure __PathRenameExtension(AMachine: TatVirtualMachine);
    procedure __PathRenameExtensionA(AMachine: TatVirtualMachine);
    procedure __PathRenameExtensionW(AMachine: TatVirtualMachine);
    procedure __PathSearchAndQualify(AMachine: TatVirtualMachine);
    procedure __PathSearchAndQualifyA(AMachine: TatVirtualMachine);
    procedure __PathSearchAndQualifyW(AMachine: TatVirtualMachine);
    procedure __PathSetDlgItemPath(AMachine: TatVirtualMachine);
    procedure __PathSetDlgItemPathA(AMachine: TatVirtualMachine);
    procedure __PathSetDlgItemPathW(AMachine: TatVirtualMachine);
    procedure __PathSkipRoot(AMachine: TatVirtualMachine);
    procedure __PathSkipRootA(AMachine: TatVirtualMachine);
    procedure __PathSkipRootW(AMachine: TatVirtualMachine);
    procedure __PathStripPath(AMachine: TatVirtualMachine);
    procedure __PathStripPathA(AMachine: TatVirtualMachine);
    procedure __PathStripPathW(AMachine: TatVirtualMachine);
    procedure __PathStripToRoot(AMachine: TatVirtualMachine);
    procedure __PathStripToRootA(AMachine: TatVirtualMachine);
    procedure __PathStripToRootW(AMachine: TatVirtualMachine);
    procedure __PathUnquoteSpaces(AMachine: TatVirtualMachine);
    procedure __PathUnquoteSpacesA(AMachine: TatVirtualMachine);
    procedure __PathUnquoteSpacesW(AMachine: TatVirtualMachine);
    procedure __PathMakeSystemFolder(AMachine: TatVirtualMachine);
    procedure __PathMakeSystemFolderA(AMachine: TatVirtualMachine);
    procedure __PathMakeSystemFolderW(AMachine: TatVirtualMachine);
    procedure __PathUnmakeSystemFolder(AMachine: TatVirtualMachine);
    procedure __PathUnmakeSystemFolderA(AMachine: TatVirtualMachine);
    procedure __PathUnmakeSystemFolderW(AMachine: TatVirtualMachine);
    procedure __PathIsSystemFolder(AMachine: TatVirtualMachine);
    procedure __PathIsSystemFolderA(AMachine: TatVirtualMachine);
    procedure __PathIsSystemFolderW(AMachine: TatVirtualMachine);
    procedure __PathUndecorate(AMachine: TatVirtualMachine);
    procedure __PathUndecorateA(AMachine: TatVirtualMachine);
    procedure __PathUndecorateW(AMachine: TatVirtualMachine);
    procedure __PathUnExpandEnvStrings(AMachine: TatVirtualMachine);
    procedure __PathUnExpandEnvStringsA(AMachine: TatVirtualMachine);
    procedure __PathUnExpandEnvStringsW(AMachine: TatVirtualMachine);
    procedure __UrlCompare(AMachine: TatVirtualMachine);
    procedure __UrlCompareA(AMachine: TatVirtualMachine);
    procedure __UrlCompareW(AMachine: TatVirtualMachine);
    procedure __UrlCombine(AMachine: TatVirtualMachine);
    procedure __UrlCombineA(AMachine: TatVirtualMachine);
    procedure __UrlCombineW(AMachine: TatVirtualMachine);
    procedure __UrlIsOpaque(AMachine: TatVirtualMachine);
    procedure __UrlIsOpaqueA(AMachine: TatVirtualMachine);
    procedure __UrlIsOpaqueW(AMachine: TatVirtualMachine);
    procedure __UrlIsNoHistory(AMachine: TatVirtualMachine);
    procedure __UrlIsNoHistoryA(AMachine: TatVirtualMachine);
    procedure __UrlIsNoHistoryW(AMachine: TatVirtualMachine);
    procedure __UrlIsFileUrl(AMachine: TatVirtualMachine);
    procedure __UrlIsFileUrlA(AMachine: TatVirtualMachine);
    procedure __UrlIsFileUrlW(AMachine: TatVirtualMachine);
    procedure __UrlIs(AMachine: TatVirtualMachine);
    procedure __UrlIsA(AMachine: TatVirtualMachine);
    procedure __UrlIsW(AMachine: TatVirtualMachine);
    procedure __UrlGetLocation(AMachine: TatVirtualMachine);
    procedure __UrlGetLocationA(AMachine: TatVirtualMachine);
    procedure __UrlGetLocationW(AMachine: TatVirtualMachine);
    procedure __UrlUnescapeInPlace(AMachine: TatVirtualMachine);
    procedure __UrlUnescapeInPlaceA(AMachine: TatVirtualMachine);
    procedure __UrlUnescapeInPlaceW(AMachine: TatVirtualMachine);
    procedure __SHDeleteEmptyKey(AMachine: TatVirtualMachine);
    procedure __SHDeleteEmptyKeyA(AMachine: TatVirtualMachine);
    procedure __SHDeleteEmptyKeyW(AMachine: TatVirtualMachine);
    procedure __SHDeleteKey(AMachine: TatVirtualMachine);
    procedure __SHDeleteKeyA(AMachine: TatVirtualMachine);
    procedure __SHDeleteKeyW(AMachine: TatVirtualMachine);
    procedure __SHDeleteValue(AMachine: TatVirtualMachine);
    procedure __SHDeleteValueA(AMachine: TatVirtualMachine);
    procedure __SHDeleteValueW(AMachine: TatVirtualMachine);
    procedure __SHEnumKeyEx(AMachine: TatVirtualMachine);
    procedure __SHEnumKeyExA(AMachine: TatVirtualMachine);
    procedure __SHEnumKeyExW(AMachine: TatVirtualMachine);
    procedure __SHCopyKey(AMachine: TatVirtualMachine);
    procedure __SHCopyKeyA(AMachine: TatVirtualMachine);
    procedure __SHCopyKeyW(AMachine: TatVirtualMachine);
    procedure __SHRegGetPath(AMachine: TatVirtualMachine);
    procedure __SHRegGetPathA(AMachine: TatVirtualMachine);
    procedure __SHRegGetPathW(AMachine: TatVirtualMachine);
    procedure __SHRegSetPath(AMachine: TatVirtualMachine);
    procedure __SHRegSetPathA(AMachine: TatVirtualMachine);
    procedure __SHRegSetPathW(AMachine: TatVirtualMachine);
    procedure __SHRegDeleteUSValue(AMachine: TatVirtualMachine);
    procedure __SHRegDeleteUSValueA(AMachine: TatVirtualMachine);
    procedure __SHRegDeleteUSValueW(AMachine: TatVirtualMachine);
    procedure __SHRegDeleteEmptyUSKey(AMachine: TatVirtualMachine);
    procedure __SHRegDeleteEmptyUSKeyA(AMachine: TatVirtualMachine);
    procedure __SHRegDeleteEmptyUSKeyW(AMachine: TatVirtualMachine);
    procedure __SHRegCloseUSKey(AMachine: TatVirtualMachine);
    procedure __SHRegGetBoolUSValue(AMachine: TatVirtualMachine);
    procedure __SHRegGetBoolUSValueA(AMachine: TatVirtualMachine);
    procedure __SHRegGetBoolUSValueW(AMachine: TatVirtualMachine);
    procedure __AssocQueryKey(AMachine: TatVirtualMachine);
    procedure __AssocQueryKeyA(AMachine: TatVirtualMachine);
    procedure __AssocQueryKeyW(AMachine: TatVirtualMachine);
    procedure __SHAutoComplete(AMachine: TatVirtualMachine);
    procedure __SHCreateShellPalette(AMachine: TatVirtualMachine);
    procedure __ColorRGBToHLS(AMachine: TatVirtualMachine);
    procedure __ColorHLSToRGB(AMachine: TatVirtualMachine);
    procedure __ColorAdjustLuma(AMachine: TatVirtualMachine);
    procedure __MAKEDLLVERULL(AMachine: TatVirtualMachine);
    procedure __GetIID_IQueryAssociations(AMachine: TatVirtualMachine);
    procedure __GetCLSID_QueryAssociations(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  _DLLVERSIONINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FdwMajorVersion: DWORD;
    FdwMinorVersion: DWORD;
    FdwBuildNumber: DWORD;
    FdwPlatformId: DWORD;
  public
    constructor Create(ARecord: _DLLVERSIONINFO);
    function ObjToRec: _DLLVERSIONINFO;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property dwMajorVersion: DWORD read FdwMajorVersion write FdwMajorVersion;
    property dwMinorVersion: DWORD read FdwMinorVersion write FdwMinorVersion;
    property dwBuildNumber: DWORD read FdwBuildNumber write FdwBuildNumber;
    property dwPlatformId: DWORD read FdwPlatformId write FdwPlatformId;
  end;
  
  _DLLVERSIONINFO2Wrapper = class(TatRecordWrapper)
  private
    FdwFlags: DWORD;
    FullVersion: Int64;
  public
    constructor Create(ARecord: _DLLVERSIONINFO2);
    function ObjToRec: _DLLVERSIONINFO2;
  published
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property ullVersion: Int64 read FullVersion write FullVersion;
  end;
  

implementation

constructor _DLLVERSIONINFOWrapper.Create(ARecord: _DLLVERSIONINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwMajorVersion := ARecord.dwMajorVersion;
  FdwMinorVersion := ARecord.dwMinorVersion;
  FdwBuildNumber := ARecord.dwBuildNumber;
  FdwPlatformId := ARecord.dwPlatformId;
end;

function _DLLVERSIONINFOWrapper.ObjToRec: _DLLVERSIONINFO;
begin
  result.cbSize := FcbSize;
  result.dwMajorVersion := FdwMajorVersion;
  result.dwMinorVersion := FdwMinorVersion;
  result.dwBuildNumber := FdwBuildNumber;
  result.dwPlatformId := FdwPlatformId;
end;

constructor _DLLVERSIONINFO2Wrapper.Create(ARecord: _DLLVERSIONINFO2);
begin
  inherited Create;
  FdwFlags := ARecord.dwFlags;
  FullVersion := ARecord.ullVersion;
end;

function _DLLVERSIONINFO2Wrapper.ObjToRec: _DLLVERSIONINFO2;
begin
  result.dwFlags := FdwFlags;
  result.ullVersion := FullVersion;
end;



procedure TatShLwApiLibrary.__StrChr(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrChr(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrChrA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.StrChrA(PAnsiChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrChrW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrChrW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrChrI(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrChrI(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrChrIA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.StrChrIA(PAnsiChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrChrIW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrChrIW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrCmpN(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrCmpN(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrCmpNA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrCmpNA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrCmpNW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrCmpNW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrCmpNI(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrCmpNI(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrCmpNIA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrCmpNIA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrCmpNIW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrCmpNIW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrCSpn(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrCSpn(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrCSpnA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrCSpnA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrCSpnW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrCSpnW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrCSpnI(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrCSpnI(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrCSpnIA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrCSpnIA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrCSpnIW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrCSpnIW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrDup(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrDup(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrDupA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.StrDupA(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrDupW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrDupW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrFormatByteSizeA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.StrFormatByteSizeA(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrFormatByteSizeW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrFormatByteSizeW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrFormatByteSize(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.StrFormatByteSize(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrFormatKBSize(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrFormatKBSize(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrFormatKBSizeA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.StrFormatKBSizeA(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrFormatKBSizeW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrFormatKBSizeW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrFromTimeInterval(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrFromTimeInterval(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrFromTimeIntervalA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrFromTimeIntervalA(PAnsiChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrFromTimeIntervalW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrFromTimeIntervalW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrIsIntlEqual(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.StrIsIntlEqual(GetInputArg(0),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrIsIntlEqualA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.StrIsIntlEqualA(GetInputArg(0),PAnsiChar(VarToStr(GetInputArg(1))),PAnsiChar(VarToStr(GetInputArg(2))),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrIsIntlEqualW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.StrIsIntlEqualW(GetInputArg(0),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrNCat(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrNCat(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrNCatA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.StrNCatA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrNCatW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrNCatW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrPBrk(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrPBrk(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrPBrkA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.StrPBrkA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrPBrkW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrPBrkW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrRChr(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrRChr(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrRChrA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.StrRChrA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrRChrW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrRChrW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrRChrI(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrRChrI(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrRChrIA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.StrRChrIA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrRChrIW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrRChrIW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrRStrI(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrRStrI(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrRStrIA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.StrRStrIA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),PAnsiChar(VarToStr(GetInputArg(2)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrRStrIW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrRStrIW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrSpn(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrSpn(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrSpnA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrSpnA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrSpnW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrSpnW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrStr(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrStr(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrStrA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.StrStrA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrStrW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrStrW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrStrI(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrStrI(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrStrIA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.StrStrIA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrStrIW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrStrIW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrToInt(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrToInt(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrToIntA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrToIntA(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrToIntW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrToIntW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrToIntEx(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param2: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
AResult := ShLwApi.StrToIntEx(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),Param2);
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatShLwApiLibrary.__StrToIntExA(AMachine: TatVirtualMachine);
  var
  Param2: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
AResult := ShLwApi.StrToIntExA(PAnsiChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1)),Param2);
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatShLwApiLibrary.__StrToIntExW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param2: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
AResult := ShLwApi.StrToIntExW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),Param2);
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatShLwApiLibrary.__StrTrim(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.StrTrim(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrTrimA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.StrTrimA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrTrimW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.StrTrimW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrCatBuff(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrCatBuff(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrCatBuffA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.StrCatBuffA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrCatBuffW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrCatBuffW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__SHStrDup(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param1: PWideChar;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))));
AResult := Integer(ShLwApi.SHStrDup(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,WideCharToString(Param1));
  end;
end;

procedure TatShLwApiLibrary.__SHStrDupA(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param1: PWideChar;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))));
AResult := Integer(ShLwApi.SHStrDupA(PAnsiChar(VarToStr(GetInputArg(0))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,WideCharToString(Param1));
  end;
end;

procedure TatShLwApiLibrary.__SHStrDupW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param1: PWideChar;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))));
AResult := Integer(ShLwApi.SHStrDupW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,WideCharToString(Param1));
  end;
end;

procedure TatShLwApiLibrary.__IntlStrEqWorker(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.IntlStrEqWorker(GetInputArg(0),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__IntlStrEqWorkerA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.IntlStrEqWorkerA(GetInputArg(0),PAnsiChar(VarToStr(GetInputArg(1))),PAnsiChar(VarToStr(GetInputArg(2))),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__IntlStrEqWorkerW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.IntlStrEqWorkerW(GetInputArg(0),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__IntlStrEqN(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.IntlStrEqN(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__IntlStrEqNA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.IntlStrEqNA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__IntlStrEqNW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.IntlStrEqNW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsHTMLFile(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsHTMLFile(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsHTMLFileA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsHTMLFileA(PAnsiChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsHTMLFileW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsHTMLFileW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrCatA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.StrCatA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrCatW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrCatW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrCat(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.StrCat(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrCmpA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrCmpA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrCmpW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrCmpW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrCmp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrCmp(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrCpyA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.StrCpyA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrCpyW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrCpyW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrCpy(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.StrCpy(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrCpyNA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.StrCpyNA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrCpyNW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrCpyNW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrCpyN(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.StrCpyN(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrToLong(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrToLong(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrToLongA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrToLongA(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrToLongW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrToLongW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrNCmp(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrNCmp(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrNCmpA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrNCmpA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrNCmpW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrNCmpW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrNCmpI(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrNCmpI(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrNCmpIA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrNCmpIA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrNCmpIW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.StrNCmpIW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrNCpy(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrNCpy(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrNCpyA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.StrNCpyA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrNCpyW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrNCpyW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrCatN(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrCatN(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrCatNA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.StrCatNA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__StrCatNW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.StrCatNW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathAddBackslash(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.PathAddBackslash(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathAddBackslashA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.PathAddBackslashA(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathAddBackslashW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.PathAddBackslashW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathAddExtension(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathAddExtension(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathAddExtensionA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathAddExtensionA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathAddExtensionW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathAddExtensionW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathAppend(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathAppend(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathAppendA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathAppendA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathAppendW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathAppendW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathBuildRoot(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.PathBuildRoot(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathBuildRootA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.PathBuildRootA(PAnsiChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathBuildRootW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.PathBuildRootW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathCanonicalize(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathCanonicalize(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathCanonicalizeA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathCanonicalizeA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathCanonicalizeW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathCanonicalizeW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathCombine(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.PathCombine(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathCombineA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.PathCombineA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),PAnsiChar(VarToStr(GetInputArg(2)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathCombineW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.PathCombineW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathCompactPath(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathCompactPath(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathCompactPathA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathCompactPathA(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathCompactPathW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathCompactPathW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathCompactPathEx(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathCompactPathEx(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathCompactPathExA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathCompactPathExA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathCompactPathExW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathCompactPathExW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathCommonPrefix(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.PathCommonPrefix(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathCommonPrefixA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.PathCommonPrefixA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),PAnsiChar(VarToStr(GetInputArg(2)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathCommonPrefixW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.PathCommonPrefixW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathFileExists(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathFileExists(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathFileExistsA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathFileExistsA(PAnsiChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathFileExistsW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathFileExistsW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathFindExtension(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.PathFindExtension(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathFindExtensionA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.PathFindExtensionA(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathFindExtensionW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.PathFindExtensionW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathFindFileName(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.PathFindFileName(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathFindFileNameA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.PathFindFileNameA(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathFindFileNameW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.PathFindFileNameW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathFindNextComponent(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.PathFindNextComponent(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathFindNextComponentA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.PathFindNextComponentA(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathFindNextComponentW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.PathFindNextComponentW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathFindOnPath(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param1: PWideChar;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))));
AResult := ShLwApi.PathFindOnPath(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,WideCharToString(Param1));
  end;
end;

procedure TatShLwApiLibrary.__PathFindOnPathA(AMachine: TatVirtualMachine);
  var
  Param1: PAnsiChar;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := PAnsiChar(VarToStr(GetInputArg(1)));
AResult := ShLwApi.PathFindOnPathA(PAnsiChar(VarToStr(GetInputArg(0))),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,string(Param1));
  end;
end;

procedure TatShLwApiLibrary.__PathFindOnPathW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param1: PWideChar;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))));
AResult := ShLwApi.PathFindOnPathW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,WideCharToString(Param1));
  end;
end;

procedure TatShLwApiLibrary.__PathGetArgs(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.PathGetArgs(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathGetArgsA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.PathGetArgsA(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathGetArgsW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.PathGetArgsW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathFindSuffixArray(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.PathFindSuffixArray(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathFindSuffixArrayA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.PathFindSuffixArrayA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathFindSuffixArrayW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.PathFindSuffixArrayW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsLFNFileSpec(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsLFNFileSpec(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsLFNFileSpecA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsLFNFileSpecA(PAnsiChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsLFNFileSpecW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsLFNFileSpecW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathGetCharType(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.PathGetCharType(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))^));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathGetCharTypeA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.PathGetCharTypeA(AnsiString(VarToStr(GetInputArg(0)))[1]));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathGetCharTypeW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.PathGetCharTypeW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))^));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathGetDriveNumber(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.PathGetDriveNumber(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathGetDriveNumberA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.PathGetDriveNumberA(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathGetDriveNumberW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.PathGetDriveNumberW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsDirectory(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsDirectory(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsDirectoryA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsDirectoryA(PAnsiChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsDirectoryW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsDirectoryW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsDirectoryEmpty(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsDirectoryEmpty(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsDirectoryEmptyA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsDirectoryEmptyA(PAnsiChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsDirectoryEmptyW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsDirectoryEmptyW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsFileSpec(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsFileSpec(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsFileSpecA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsFileSpecA(PAnsiChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsFileSpecW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsFileSpecW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsPrefix(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsPrefix(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsPrefixA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsPrefixA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsPrefixW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsPrefixW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsRelative(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsRelative(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsRelativeA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsRelativeA(PAnsiChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsRelativeW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsRelativeW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsRoot(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsRoot(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsRootA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsRootA(PAnsiChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsRootW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsRootW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsSameRoot(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsSameRoot(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsSameRootA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsSameRootA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsSameRootW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsSameRootW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsUNC(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsUNC(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsUNCA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsUNCA(PAnsiChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsUNCW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsUNCW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsNetworkPath(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsNetworkPath(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsNetworkPathA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsNetworkPathA(PAnsiChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsNetworkPathW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsNetworkPathW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsUNCServer(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsUNCServer(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsUNCServerA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsUNCServerA(PAnsiChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsUNCServerW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsUNCServerW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsUNCServerShare(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsUNCServerShare(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsUNCServerShareA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsUNCServerShareA(PAnsiChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsUNCServerShareW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsUNCServerShareW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsContentType(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsContentType(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsContentTypeA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsContentTypeA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsContentTypeW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsContentTypeW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsURL(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsURL(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsURLA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsURLA(PAnsiChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsURLW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsURLW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathMakePretty(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathMakePretty(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathMakePrettyA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathMakePrettyA(PAnsiChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathMakePrettyW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathMakePrettyW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathMatchSpec(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathMatchSpec(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathMatchSpecA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathMatchSpecA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathMatchSpecW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathMatchSpecW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathParseIconLocation(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.PathParseIconLocation(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathParseIconLocationA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.PathParseIconLocationA(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathParseIconLocationW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.PathParseIconLocationW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathQuoteSpaces(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
begin
  with AMachine do
  begin
    ShLwApi.PathQuoteSpaces(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
  end;
end;

procedure TatShLwApiLibrary.__PathQuoteSpacesA(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ShLwApi.PathQuoteSpacesA(PAnsiChar(VarToStr(GetInputArg(0))));
  end;
end;

procedure TatShLwApiLibrary.__PathQuoteSpacesW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
begin
  with AMachine do
  begin
    ShLwApi.PathQuoteSpacesW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
  end;
end;

procedure TatShLwApiLibrary.__PathRelativePathTo(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param3Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathRelativePathTo(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))),VarToInteger(GetInputArg(4)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathRelativePathToA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathRelativePathToA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)),PAnsiChar(VarToStr(GetInputArg(3))),VarToInteger(GetInputArg(4)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathRelativePathToW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param3Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathRelativePathToW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))),VarToInteger(GetInputArg(4)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathRemoveArgs(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
begin
  with AMachine do
  begin
    ShLwApi.PathRemoveArgs(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
  end;
end;

procedure TatShLwApiLibrary.__PathRemoveArgsA(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ShLwApi.PathRemoveArgsA(PAnsiChar(VarToStr(GetInputArg(0))));
  end;
end;

procedure TatShLwApiLibrary.__PathRemoveArgsW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
begin
  with AMachine do
  begin
    ShLwApi.PathRemoveArgsW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
  end;
end;

procedure TatShLwApiLibrary.__PathRemoveBackslash(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.PathRemoveBackslash(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathRemoveBackslashA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.PathRemoveBackslashA(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathRemoveBackslashW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.PathRemoveBackslashW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathRemoveBlanks(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
begin
  with AMachine do
  begin
    ShLwApi.PathRemoveBlanks(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
  end;
end;

procedure TatShLwApiLibrary.__PathRemoveBlanksA(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ShLwApi.PathRemoveBlanksA(PAnsiChar(VarToStr(GetInputArg(0))));
  end;
end;

procedure TatShLwApiLibrary.__PathRemoveBlanksW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
begin
  with AMachine do
  begin
    ShLwApi.PathRemoveBlanksW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
  end;
end;

procedure TatShLwApiLibrary.__PathRemoveExtension(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
begin
  with AMachine do
  begin
    ShLwApi.PathRemoveExtension(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
  end;
end;

procedure TatShLwApiLibrary.__PathRemoveExtensionA(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ShLwApi.PathRemoveExtensionA(PAnsiChar(VarToStr(GetInputArg(0))));
  end;
end;

procedure TatShLwApiLibrary.__PathRemoveExtensionW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
begin
  with AMachine do
  begin
    ShLwApi.PathRemoveExtensionW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
  end;
end;

procedure TatShLwApiLibrary.__PathRemoveFileSpec(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathRemoveFileSpec(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathRemoveFileSpecA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathRemoveFileSpecA(PAnsiChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathRemoveFileSpecW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathRemoveFileSpecW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathRenameExtension(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathRenameExtension(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathRenameExtensionA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathRenameExtensionA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathRenameExtensionW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathRenameExtensionW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathSearchAndQualify(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathSearchAndQualify(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathSearchAndQualifyA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathSearchAndQualifyA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathSearchAndQualifyW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathSearchAndQualifyW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathSetDlgItemPath(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
begin
  with AMachine do
  begin
    ShLwApi.PathSetDlgItemPath(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))));
  end;
end;

procedure TatShLwApiLibrary.__PathSetDlgItemPathA(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ShLwApi.PathSetDlgItemPathA(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),PAnsiChar(VarToStr(GetInputArg(2))));
  end;
end;

procedure TatShLwApiLibrary.__PathSetDlgItemPathW(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
begin
  with AMachine do
  begin
    ShLwApi.PathSetDlgItemPathW(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))));
  end;
end;

procedure TatShLwApiLibrary.__PathSkipRoot(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.PathSkipRoot(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathSkipRootA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.PathSkipRootA(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathSkipRootW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.PathSkipRootW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathStripPath(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
begin
  with AMachine do
  begin
    ShLwApi.PathStripPath(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
  end;
end;

procedure TatShLwApiLibrary.__PathStripPathA(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ShLwApi.PathStripPathA(PAnsiChar(VarToStr(GetInputArg(0))));
  end;
end;

procedure TatShLwApiLibrary.__PathStripPathW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
begin
  with AMachine do
  begin
    ShLwApi.PathStripPathW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
  end;
end;

procedure TatShLwApiLibrary.__PathStripToRoot(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathStripToRoot(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathStripToRootA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathStripToRootA(PAnsiChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathStripToRootW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathStripToRootW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathUnquoteSpaces(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
begin
  with AMachine do
  begin
    ShLwApi.PathUnquoteSpaces(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
  end;
end;

procedure TatShLwApiLibrary.__PathUnquoteSpacesA(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ShLwApi.PathUnquoteSpacesA(PAnsiChar(VarToStr(GetInputArg(0))));
  end;
end;

procedure TatShLwApiLibrary.__PathUnquoteSpacesW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
begin
  with AMachine do
  begin
    ShLwApi.PathUnquoteSpacesW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
  end;
end;

procedure TatShLwApiLibrary.__PathMakeSystemFolder(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathMakeSystemFolder(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathMakeSystemFolderA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathMakeSystemFolderA(PAnsiChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathMakeSystemFolderW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathMakeSystemFolderW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathUnmakeSystemFolder(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathUnmakeSystemFolder(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathUnmakeSystemFolderA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathUnmakeSystemFolderA(PAnsiChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathUnmakeSystemFolderW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathUnmakeSystemFolderW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsSystemFolder(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsSystemFolder(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsSystemFolderA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsSystemFolderA(PAnsiChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathIsSystemFolderW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathIsSystemFolderW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathUndecorate(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
begin
  with AMachine do
  begin
    ShLwApi.PathUndecorate(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
  end;
end;

procedure TatShLwApiLibrary.__PathUndecorateA(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ShLwApi.PathUndecorateA(PAnsiChar(VarToStr(GetInputArg(0))));
  end;
end;

procedure TatShLwApiLibrary.__PathUndecorateW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
begin
  with AMachine do
  begin
    ShLwApi.PathUndecorateW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
  end;
end;

procedure TatShLwApiLibrary.__PathUnExpandEnvStrings(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathUnExpandEnvStrings(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathUnExpandEnvStringsA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathUnExpandEnvStringsA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__PathUnExpandEnvStringsW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.PathUnExpandEnvStringsW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__UrlCompare(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.UrlCompare(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__UrlCompareA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.UrlCompareA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__UrlCompareW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.UrlCompareW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__UrlCombine(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  Param3: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(ShLwApi.UrlCombine(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),Param3,VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatShLwApiLibrary.__UrlCombineA(AMachine: TatVirtualMachine);
  var
  Param3: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(ShLwApi.UrlCombineA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),PAnsiChar(VarToStr(GetInputArg(2))),Param3,VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatShLwApiLibrary.__UrlCombineW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  Param3: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(ShLwApi.UrlCombineW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),Param3,VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatShLwApiLibrary.__UrlIsOpaque(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.UrlIsOpaque(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__UrlIsOpaqueA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.UrlIsOpaqueA(PAnsiChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__UrlIsOpaqueW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.UrlIsOpaqueW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__UrlIsNoHistory(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.UrlIsNoHistory(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__UrlIsNoHistoryA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.UrlIsNoHistoryA(PAnsiChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__UrlIsNoHistoryW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.UrlIsNoHistoryW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__UrlIsFileUrl(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.UrlIsFileUrl(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__UrlIsFileUrlA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.UrlIsFileUrlA(PAnsiChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__UrlIsFileUrlW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.UrlIsFileUrlW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__UrlIs(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.UrlIs(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__UrlIsA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.UrlIsA(PAnsiChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__UrlIsW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.UrlIsW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__UrlGetLocation(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.UrlGetLocation(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__UrlGetLocationA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(ShLwApi.UrlGetLocationA(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__UrlGetLocationW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ShLwApi.UrlGetLocationW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__UrlUnescapeInPlace(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.UrlUnescapeInPlace(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__UrlUnescapeInPlaceA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.UrlUnescapeInPlaceA(PAnsiChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__UrlUnescapeInPlaceW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.UrlUnescapeInPlaceW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__SHDeleteEmptyKey(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.SHDeleteEmptyKey(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__SHDeleteEmptyKeyA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.SHDeleteEmptyKeyA(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__SHDeleteEmptyKeyW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.SHDeleteEmptyKeyW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__SHDeleteKey(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.SHDeleteKey(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__SHDeleteKeyA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.SHDeleteKeyA(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__SHDeleteKeyW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.SHDeleteKeyW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__SHDeleteValue(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.SHDeleteValue(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__SHDeleteValueA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.SHDeleteValueA(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),PAnsiChar(VarToStr(GetInputArg(2)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__SHDeleteValueW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.SHDeleteValueW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__SHEnumKeyEx(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  Param3: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(ShLwApi.SHEnumKeyEx(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatShLwApiLibrary.__SHEnumKeyExA(AMachine: TatVirtualMachine);
  var
  Param3: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(ShLwApi.SHEnumKeyExA(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),PAnsiChar(VarToStr(GetInputArg(2))),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatShLwApiLibrary.__SHEnumKeyExW(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  Param3: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(ShLwApi.SHEnumKeyExW(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatShLwApiLibrary.__SHCopyKey(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.SHCopyKey(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__SHCopyKeyA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.SHCopyKeyA(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__SHCopyKeyW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.SHCopyKeyW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__SHRegGetPath(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  Param3Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.SHRegGetPath(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__SHRegGetPathA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.SHRegGetPathA(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),PAnsiChar(VarToStr(GetInputArg(2))),PAnsiChar(VarToStr(GetInputArg(3))),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__SHRegGetPathW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  Param3Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.SHRegGetPathW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__SHRegSetPath(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  Param3Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.SHRegSetPath(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__SHRegSetPathA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.SHRegSetPathA(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),PAnsiChar(VarToStr(GetInputArg(2))),PAnsiChar(VarToStr(GetInputArg(3))),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__SHRegSetPathW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  Param3Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.SHRegSetPathW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__SHRegDeleteUSValue(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.SHRegDeleteUSValue(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__SHRegDeleteUSValueA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.SHRegDeleteUSValueA(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__SHRegDeleteUSValueW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.SHRegDeleteUSValueW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__SHRegDeleteEmptyUSKey(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.SHRegDeleteEmptyUSKey(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__SHRegDeleteEmptyUSKeyA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.SHRegDeleteEmptyUSKeyA(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__SHRegDeleteEmptyUSKeyW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.SHRegDeleteEmptyUSKeyW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__SHRegCloseUSKey(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.SHRegCloseUSKey(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__SHRegGetBoolUSValue(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.SHRegGetBoolUSValue(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),GetInputArg(2),GetInputArg(3));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__SHRegGetBoolUSValueA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.SHRegGetBoolUSValueA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),GetInputArg(2),GetInputArg(3));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__SHRegGetBoolUSValueW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShLwApi.SHRegGetBoolUSValueW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),GetInputArg(2),GetInputArg(3));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__AssocQueryKey(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  Param3Buf: array[0..127] of WideChar;
  Param4: HKEY;
  AResult: variant;
begin
  with AMachine do
  begin
Param4 := VarToInteger(GetInputArg(4));
AResult := Integer(ShLwApi.AssocQueryKey(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))),Param4));
    ReturnOutputArg(AResult);
    SetInputArg(4,Integer(Param4));
  end;
end;

procedure TatShLwApiLibrary.__AssocQueryKeyA(AMachine: TatVirtualMachine);
  var
  Param4: HKEY;
  AResult: variant;
begin
  with AMachine do
  begin
Param4 := VarToInteger(GetInputArg(4));
AResult := Integer(ShLwApi.AssocQueryKeyA(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),PAnsiChar(VarToStr(GetInputArg(2))),PAnsiChar(VarToStr(GetInputArg(3))),Param4));
    ReturnOutputArg(AResult);
    SetInputArg(4,Integer(Param4));
  end;
end;

procedure TatShLwApiLibrary.__AssocQueryKeyW(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  Param3Buf: array[0..127] of WideChar;
  Param4: HKEY;
  AResult: variant;
begin
  with AMachine do
  begin
Param4 := VarToInteger(GetInputArg(4));
AResult := Integer(ShLwApi.AssocQueryKeyW(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))),Param4));
    ReturnOutputArg(AResult);
    SetInputArg(4,Integer(Param4));
  end;
end;

procedure TatShLwApiLibrary.__SHAutoComplete(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.SHAutoComplete(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__SHCreateShellPalette(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.SHCreateShellPalette(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__ColorRGBToHLS(AMachine: TatVirtualMachine);
  var
  Param1: WORD;
  Param2: WORD;
  Param3: WORD;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
Param2 := VarToInteger(GetInputArg(2));
Param3 := VarToInteger(GetInputArg(3));
    ShLwApi.ColorRGBToHLS(VarToInteger(GetInputArg(0)),Param1,Param2,Param3);
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Integer(Param2));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatShLwApiLibrary.__ColorHLSToRGB(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.ColorHLSToRGB(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__ColorAdjustLuma(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.ColorAdjustLuma(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__MAKEDLLVERULL(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShLwApi.MAKEDLLVERULL(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShLwApiLibrary.__GetIID_IQueryAssociations(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShLwApi.IID_IQueryAssociations)));
  end;
end;

procedure TatShLwApiLibrary.__GetCLSID_QueryAssociations(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShLwApi.CLSID_QueryAssociations)));
  end;
end;

procedure TatShLwApiLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('StrChr',2,tkVariant,nil,__StrChr,false,0);
    DefineMethod('StrChrA',2,tkVariant,nil,__StrChrA,false,0);
    DefineMethod('StrChrW',2,tkVariant,nil,__StrChrW,false,0);
    DefineMethod('StrChrI',2,tkVariant,nil,__StrChrI,false,0);
    DefineMethod('StrChrIA',2,tkVariant,nil,__StrChrIA,false,0);
    DefineMethod('StrChrIW',2,tkVariant,nil,__StrChrIW,false,0);
    DefineMethod('StrCmpN',3,tkInteger,nil,__StrCmpN,false,0);
    DefineMethod('StrCmpNA',3,tkInteger,nil,__StrCmpNA,false,0);
    DefineMethod('StrCmpNW',3,tkInteger,nil,__StrCmpNW,false,0);
    DefineMethod('StrCmpNI',3,tkInteger,nil,__StrCmpNI,false,0);
    DefineMethod('StrCmpNIA',3,tkInteger,nil,__StrCmpNIA,false,0);
    DefineMethod('StrCmpNIW',3,tkInteger,nil,__StrCmpNIW,false,0);
    DefineMethod('StrCSpn',2,tkInteger,nil,__StrCSpn,false,0);
    DefineMethod('StrCSpnA',2,tkInteger,nil,__StrCSpnA,false,0);
    DefineMethod('StrCSpnW',2,tkInteger,nil,__StrCSpnW,false,0);
    DefineMethod('StrCSpnI',2,tkInteger,nil,__StrCSpnI,false,0);
    DefineMethod('StrCSpnIA',2,tkInteger,nil,__StrCSpnIA,false,0);
    DefineMethod('StrCSpnIW',2,tkInteger,nil,__StrCSpnIW,false,0);
    DefineMethod('StrDup',1,tkVariant,nil,__StrDup,false,0);
    DefineMethod('StrDupA',1,tkVariant,nil,__StrDupA,false,0);
    DefineMethod('StrDupW',1,tkVariant,nil,__StrDupW,false,0);
    DefineMethod('StrFormatByteSizeA',3,tkVariant,nil,__StrFormatByteSizeA,false,0);
    DefineMethod('StrFormatByteSizeW',3,tkVariant,nil,__StrFormatByteSizeW,false,0);
    DefineMethod('StrFormatByteSize',3,tkVariant,nil,__StrFormatByteSize,false,0);
    DefineMethod('StrFormatKBSize',3,tkVariant,nil,__StrFormatKBSize,false,0);
    DefineMethod('StrFormatKBSizeA',3,tkVariant,nil,__StrFormatKBSizeA,false,0);
    DefineMethod('StrFormatKBSizeW',3,tkVariant,nil,__StrFormatKBSizeW,false,0);
    DefineMethod('StrFromTimeInterval',4,tkInteger,nil,__StrFromTimeInterval,false,0);
    DefineMethod('StrFromTimeIntervalA',4,tkInteger,nil,__StrFromTimeIntervalA,false,0);
    DefineMethod('StrFromTimeIntervalW',4,tkInteger,nil,__StrFromTimeIntervalW,false,0);
    DefineMethod('StrIsIntlEqual',4,tkVariant,nil,__StrIsIntlEqual,false,0);
    DefineMethod('StrIsIntlEqualA',4,tkVariant,nil,__StrIsIntlEqualA,false,0);
    DefineMethod('StrIsIntlEqualW',4,tkVariant,nil,__StrIsIntlEqualW,false,0);
    DefineMethod('StrNCat',3,tkVariant,nil,__StrNCat,false,0);
    DefineMethod('StrNCatA',3,tkVariant,nil,__StrNCatA,false,0);
    DefineMethod('StrNCatW',3,tkVariant,nil,__StrNCatW,false,0);
    DefineMethod('StrPBrk',2,tkVariant,nil,__StrPBrk,false,0);
    DefineMethod('StrPBrkA',2,tkVariant,nil,__StrPBrkA,false,0);
    DefineMethod('StrPBrkW',2,tkVariant,nil,__StrPBrkW,false,0);
    DefineMethod('StrRChr',3,tkVariant,nil,__StrRChr,false,0);
    DefineMethod('StrRChrA',3,tkVariant,nil,__StrRChrA,false,0);
    DefineMethod('StrRChrW',3,tkVariant,nil,__StrRChrW,false,0);
    DefineMethod('StrRChrI',3,tkVariant,nil,__StrRChrI,false,0);
    DefineMethod('StrRChrIA',3,tkVariant,nil,__StrRChrIA,false,0);
    DefineMethod('StrRChrIW',3,tkVariant,nil,__StrRChrIW,false,0);
    DefineMethod('StrRStrI',3,tkVariant,nil,__StrRStrI,false,0);
    DefineMethod('StrRStrIA',3,tkVariant,nil,__StrRStrIA,false,0);
    DefineMethod('StrRStrIW',3,tkVariant,nil,__StrRStrIW,false,0);
    DefineMethod('StrSpn',2,tkInteger,nil,__StrSpn,false,0);
    DefineMethod('StrSpnA',2,tkInteger,nil,__StrSpnA,false,0);
    DefineMethod('StrSpnW',2,tkInteger,nil,__StrSpnW,false,0);
    DefineMethod('StrStr',2,tkVariant,nil,__StrStr,false,0);
    DefineMethod('StrStrA',2,tkVariant,nil,__StrStrA,false,0);
    DefineMethod('StrStrW',2,tkVariant,nil,__StrStrW,false,0);
    DefineMethod('StrStrI',2,tkVariant,nil,__StrStrI,false,0);
    DefineMethod('StrStrIA',2,tkVariant,nil,__StrStrIA,false,0);
    DefineMethod('StrStrIW',2,tkVariant,nil,__StrStrIW,false,0);
    DefineMethod('StrToInt',1,tkInteger,nil,__StrToInt,false,0);
    DefineMethod('StrToIntA',1,tkInteger,nil,__StrToIntA,false,0);
    DefineMethod('StrToIntW',1,tkInteger,nil,__StrToIntW,false,0);
    DefineMethod('StrToIntEx',3,tkVariant,nil,__StrToIntEx,false,0).SetVarArgs([2]);
    DefineMethod('StrToIntExA',3,tkVariant,nil,__StrToIntExA,false,0).SetVarArgs([2]);
    DefineMethod('StrToIntExW',3,tkVariant,nil,__StrToIntExW,false,0).SetVarArgs([2]);
    DefineMethod('StrTrim',2,tkVariant,nil,__StrTrim,false,0);
    DefineMethod('StrTrimA',2,tkVariant,nil,__StrTrimA,false,0);
    DefineMethod('StrTrimW',2,tkVariant,nil,__StrTrimW,false,0);
    DefineMethod('StrCatBuff',3,tkVariant,nil,__StrCatBuff,false,0);
    DefineMethod('StrCatBuffA',3,tkVariant,nil,__StrCatBuffA,false,0);
    DefineMethod('StrCatBuffW',3,tkVariant,nil,__StrCatBuffW,false,0);
    DefineMethod('SHStrDup',2,tkInteger,nil,__SHStrDup,false,0).SetVarArgs([1]);
    DefineMethod('SHStrDupA',2,tkInteger,nil,__SHStrDupA,false,0).SetVarArgs([1]);
    DefineMethod('SHStrDupW',2,tkInteger,nil,__SHStrDupW,false,0).SetVarArgs([1]);
    DefineMethod('IntlStrEqWorker',4,tkVariant,nil,__IntlStrEqWorker,false,0);
    DefineMethod('IntlStrEqWorkerA',4,tkVariant,nil,__IntlStrEqWorkerA,false,0);
    DefineMethod('IntlStrEqWorkerW',4,tkVariant,nil,__IntlStrEqWorkerW,false,0);
    DefineMethod('IntlStrEqN',3,tkVariant,nil,__IntlStrEqN,false,0);
    DefineMethod('IntlStrEqNA',3,tkVariant,nil,__IntlStrEqNA,false,0);
    DefineMethod('IntlStrEqNW',3,tkVariant,nil,__IntlStrEqNW,false,0);
    DefineMethod('PathIsHTMLFile',1,tkVariant,nil,__PathIsHTMLFile,false,0);
    DefineMethod('PathIsHTMLFileA',1,tkVariant,nil,__PathIsHTMLFileA,false,0);
    DefineMethod('PathIsHTMLFileW',1,tkVariant,nil,__PathIsHTMLFileW,false,0);
    DefineMethod('StrCatA',2,tkVariant,nil,__StrCatA,false,0);
    DefineMethod('StrCatW',2,tkVariant,nil,__StrCatW,false,0);
    DefineMethod('StrCat',2,tkVariant,nil,__StrCat,false,0);
    DefineMethod('StrCmpA',2,tkInteger,nil,__StrCmpA,false,0);
    DefineMethod('StrCmpW',2,tkInteger,nil,__StrCmpW,false,0);
    DefineMethod('StrCmp',2,tkInteger,nil,__StrCmp,false,0);
    DefineMethod('StrCpyA',2,tkVariant,nil,__StrCpyA,false,0);
    DefineMethod('StrCpyW',2,tkVariant,nil,__StrCpyW,false,0);
    DefineMethod('StrCpy',2,tkVariant,nil,__StrCpy,false,0);
    DefineMethod('StrCpyNA',3,tkVariant,nil,__StrCpyNA,false,0);
    DefineMethod('StrCpyNW',3,tkVariant,nil,__StrCpyNW,false,0);
    DefineMethod('StrCpyN',3,tkVariant,nil,__StrCpyN,false,0);
    DefineMethod('StrToLong',1,tkInteger,nil,__StrToLong,false,0);
    DefineMethod('StrToLongA',1,tkInteger,nil,__StrToLongA,false,0);
    DefineMethod('StrToLongW',1,tkInteger,nil,__StrToLongW,false,0);
    DefineMethod('StrNCmp',3,tkInteger,nil,__StrNCmp,false,0);
    DefineMethod('StrNCmpA',3,tkInteger,nil,__StrNCmpA,false,0);
    DefineMethod('StrNCmpW',3,tkInteger,nil,__StrNCmpW,false,0);
    DefineMethod('StrNCmpI',3,tkInteger,nil,__StrNCmpI,false,0);
    DefineMethod('StrNCmpIA',3,tkInteger,nil,__StrNCmpIA,false,0);
    DefineMethod('StrNCmpIW',3,tkInteger,nil,__StrNCmpIW,false,0);
    DefineMethod('StrNCpy',3,tkVariant,nil,__StrNCpy,false,0);
    DefineMethod('StrNCpyA',3,tkVariant,nil,__StrNCpyA,false,0);
    DefineMethod('StrNCpyW',3,tkVariant,nil,__StrNCpyW,false,0);
    DefineMethod('StrCatN',3,tkVariant,nil,__StrCatN,false,0);
    DefineMethod('StrCatNA',3,tkVariant,nil,__StrCatNA,false,0);
    DefineMethod('StrCatNW',3,tkVariant,nil,__StrCatNW,false,0);
    DefineMethod('PathAddBackslash',1,tkVariant,nil,__PathAddBackslash,false,0);
    DefineMethod('PathAddBackslashA',1,tkVariant,nil,__PathAddBackslashA,false,0);
    DefineMethod('PathAddBackslashW',1,tkVariant,nil,__PathAddBackslashW,false,0);
    DefineMethod('PathAddExtension',2,tkVariant,nil,__PathAddExtension,false,0);
    DefineMethod('PathAddExtensionA',2,tkVariant,nil,__PathAddExtensionA,false,0);
    DefineMethod('PathAddExtensionW',2,tkVariant,nil,__PathAddExtensionW,false,0);
    DefineMethod('PathAppend',2,tkVariant,nil,__PathAppend,false,0);
    DefineMethod('PathAppendA',2,tkVariant,nil,__PathAppendA,false,0);
    DefineMethod('PathAppendW',2,tkVariant,nil,__PathAppendW,false,0);
    DefineMethod('PathBuildRoot',2,tkVariant,nil,__PathBuildRoot,false,0);
    DefineMethod('PathBuildRootA',2,tkVariant,nil,__PathBuildRootA,false,0);
    DefineMethod('PathBuildRootW',2,tkVariant,nil,__PathBuildRootW,false,0);
    DefineMethod('PathCanonicalize',2,tkVariant,nil,__PathCanonicalize,false,0);
    DefineMethod('PathCanonicalizeA',2,tkVariant,nil,__PathCanonicalizeA,false,0);
    DefineMethod('PathCanonicalizeW',2,tkVariant,nil,__PathCanonicalizeW,false,0);
    DefineMethod('PathCombine',3,tkVariant,nil,__PathCombine,false,0);
    DefineMethod('PathCombineA',3,tkVariant,nil,__PathCombineA,false,0);
    DefineMethod('PathCombineW',3,tkVariant,nil,__PathCombineW,false,0);
    DefineMethod('PathCompactPath',3,tkVariant,nil,__PathCompactPath,false,0);
    DefineMethod('PathCompactPathA',3,tkVariant,nil,__PathCompactPathA,false,0);
    DefineMethod('PathCompactPathW',3,tkVariant,nil,__PathCompactPathW,false,0);
    DefineMethod('PathCompactPathEx',4,tkVariant,nil,__PathCompactPathEx,false,0);
    DefineMethod('PathCompactPathExA',4,tkVariant,nil,__PathCompactPathExA,false,0);
    DefineMethod('PathCompactPathExW',4,tkVariant,nil,__PathCompactPathExW,false,0);
    DefineMethod('PathCommonPrefix',3,tkInteger,nil,__PathCommonPrefix,false,0);
    DefineMethod('PathCommonPrefixA',3,tkInteger,nil,__PathCommonPrefixA,false,0);
    DefineMethod('PathCommonPrefixW',3,tkInteger,nil,__PathCommonPrefixW,false,0);
    DefineMethod('PathFileExists',1,tkVariant,nil,__PathFileExists,false,0);
    DefineMethod('PathFileExistsA',1,tkVariant,nil,__PathFileExistsA,false,0);
    DefineMethod('PathFileExistsW',1,tkVariant,nil,__PathFileExistsW,false,0);
    DefineMethod('PathFindExtension',1,tkVariant,nil,__PathFindExtension,false,0);
    DefineMethod('PathFindExtensionA',1,tkVariant,nil,__PathFindExtensionA,false,0);
    DefineMethod('PathFindExtensionW',1,tkVariant,nil,__PathFindExtensionW,false,0);
    DefineMethod('PathFindFileName',1,tkVariant,nil,__PathFindFileName,false,0);
    DefineMethod('PathFindFileNameA',1,tkVariant,nil,__PathFindFileNameA,false,0);
    DefineMethod('PathFindFileNameW',1,tkVariant,nil,__PathFindFileNameW,false,0);
    DefineMethod('PathFindNextComponent',1,tkVariant,nil,__PathFindNextComponent,false,0);
    DefineMethod('PathFindNextComponentA',1,tkVariant,nil,__PathFindNextComponentA,false,0);
    DefineMethod('PathFindNextComponentW',1,tkVariant,nil,__PathFindNextComponentW,false,0);
    DefineMethod('PathFindOnPath',2,tkVariant,nil,__PathFindOnPath,false,0).SetVarArgs([1]);
    DefineMethod('PathFindOnPathA',2,tkVariant,nil,__PathFindOnPathA,false,0).SetVarArgs([1]);
    DefineMethod('PathFindOnPathW',2,tkVariant,nil,__PathFindOnPathW,false,0).SetVarArgs([1]);
    DefineMethod('PathGetArgs',1,tkVariant,nil,__PathGetArgs,false,0);
    DefineMethod('PathGetArgsA',1,tkVariant,nil,__PathGetArgsA,false,0);
    DefineMethod('PathGetArgsW',1,tkVariant,nil,__PathGetArgsW,false,0);
    DefineMethod('PathFindSuffixArray',3,tkVariant,nil,__PathFindSuffixArray,false,0);
    DefineMethod('PathFindSuffixArrayA',3,tkVariant,nil,__PathFindSuffixArrayA,false,0);
    DefineMethod('PathFindSuffixArrayW',3,tkVariant,nil,__PathFindSuffixArrayW,false,0);
    DefineMethod('PathIsLFNFileSpec',1,tkVariant,nil,__PathIsLFNFileSpec,false,0);
    DefineMethod('PathIsLFNFileSpecA',1,tkVariant,nil,__PathIsLFNFileSpecA,false,0);
    DefineMethod('PathIsLFNFileSpecW',1,tkVariant,nil,__PathIsLFNFileSpecW,false,0);
    DefineMethod('PathGetCharType',1,tkInteger,nil,__PathGetCharType,false,0);
    DefineMethod('PathGetCharTypeA',1,tkInteger,nil,__PathGetCharTypeA,false,0);
    DefineMethod('PathGetCharTypeW',1,tkInteger,nil,__PathGetCharTypeW,false,0);
    DefineMethod('PathGetDriveNumber',1,tkInteger,nil,__PathGetDriveNumber,false,0);
    DefineMethod('PathGetDriveNumberA',1,tkInteger,nil,__PathGetDriveNumberA,false,0);
    DefineMethod('PathGetDriveNumberW',1,tkInteger,nil,__PathGetDriveNumberW,false,0);
    DefineMethod('PathIsDirectory',1,tkVariant,nil,__PathIsDirectory,false,0);
    DefineMethod('PathIsDirectoryA',1,tkVariant,nil,__PathIsDirectoryA,false,0);
    DefineMethod('PathIsDirectoryW',1,tkVariant,nil,__PathIsDirectoryW,false,0);
    DefineMethod('PathIsDirectoryEmpty',1,tkVariant,nil,__PathIsDirectoryEmpty,false,0);
    DefineMethod('PathIsDirectoryEmptyA',1,tkVariant,nil,__PathIsDirectoryEmptyA,false,0);
    DefineMethod('PathIsDirectoryEmptyW',1,tkVariant,nil,__PathIsDirectoryEmptyW,false,0);
    DefineMethod('PathIsFileSpec',1,tkVariant,nil,__PathIsFileSpec,false,0);
    DefineMethod('PathIsFileSpecA',1,tkVariant,nil,__PathIsFileSpecA,false,0);
    DefineMethod('PathIsFileSpecW',1,tkVariant,nil,__PathIsFileSpecW,false,0);
    DefineMethod('PathIsPrefix',2,tkVariant,nil,__PathIsPrefix,false,0);
    DefineMethod('PathIsPrefixA',2,tkVariant,nil,__PathIsPrefixA,false,0);
    DefineMethod('PathIsPrefixW',2,tkVariant,nil,__PathIsPrefixW,false,0);
    DefineMethod('PathIsRelative',1,tkVariant,nil,__PathIsRelative,false,0);
    DefineMethod('PathIsRelativeA',1,tkVariant,nil,__PathIsRelativeA,false,0);
    DefineMethod('PathIsRelativeW',1,tkVariant,nil,__PathIsRelativeW,false,0);
    DefineMethod('PathIsRoot',1,tkVariant,nil,__PathIsRoot,false,0);
    DefineMethod('PathIsRootA',1,tkVariant,nil,__PathIsRootA,false,0);
    DefineMethod('PathIsRootW',1,tkVariant,nil,__PathIsRootW,false,0);
    DefineMethod('PathIsSameRoot',2,tkVariant,nil,__PathIsSameRoot,false,0);
    DefineMethod('PathIsSameRootA',2,tkVariant,nil,__PathIsSameRootA,false,0);
    DefineMethod('PathIsSameRootW',2,tkVariant,nil,__PathIsSameRootW,false,0);
    DefineMethod('PathIsUNC',1,tkVariant,nil,__PathIsUNC,false,0);
    DefineMethod('PathIsUNCA',1,tkVariant,nil,__PathIsUNCA,false,0);
    DefineMethod('PathIsUNCW',1,tkVariant,nil,__PathIsUNCW,false,0);
    DefineMethod('PathIsNetworkPath',1,tkVariant,nil,__PathIsNetworkPath,false,0);
    DefineMethod('PathIsNetworkPathA',1,tkVariant,nil,__PathIsNetworkPathA,false,0);
    DefineMethod('PathIsNetworkPathW',1,tkVariant,nil,__PathIsNetworkPathW,false,0);
    DefineMethod('PathIsUNCServer',1,tkVariant,nil,__PathIsUNCServer,false,0);
    DefineMethod('PathIsUNCServerA',1,tkVariant,nil,__PathIsUNCServerA,false,0);
    DefineMethod('PathIsUNCServerW',1,tkVariant,nil,__PathIsUNCServerW,false,0);
    DefineMethod('PathIsUNCServerShare',1,tkVariant,nil,__PathIsUNCServerShare,false,0);
    DefineMethod('PathIsUNCServerShareA',1,tkVariant,nil,__PathIsUNCServerShareA,false,0);
    DefineMethod('PathIsUNCServerShareW',1,tkVariant,nil,__PathIsUNCServerShareW,false,0);
    DefineMethod('PathIsContentType',2,tkVariant,nil,__PathIsContentType,false,0);
    DefineMethod('PathIsContentTypeA',2,tkVariant,nil,__PathIsContentTypeA,false,0);
    DefineMethod('PathIsContentTypeW',2,tkVariant,nil,__PathIsContentTypeW,false,0);
    DefineMethod('PathIsURL',1,tkVariant,nil,__PathIsURL,false,0);
    DefineMethod('PathIsURLA',1,tkVariant,nil,__PathIsURLA,false,0);
    DefineMethod('PathIsURLW',1,tkVariant,nil,__PathIsURLW,false,0);
    DefineMethod('PathMakePretty',1,tkVariant,nil,__PathMakePretty,false,0);
    DefineMethod('PathMakePrettyA',1,tkVariant,nil,__PathMakePrettyA,false,0);
    DefineMethod('PathMakePrettyW',1,tkVariant,nil,__PathMakePrettyW,false,0);
    DefineMethod('PathMatchSpec',2,tkVariant,nil,__PathMatchSpec,false,0);
    DefineMethod('PathMatchSpecA',2,tkVariant,nil,__PathMatchSpecA,false,0);
    DefineMethod('PathMatchSpecW',2,tkVariant,nil,__PathMatchSpecW,false,0);
    DefineMethod('PathParseIconLocation',1,tkInteger,nil,__PathParseIconLocation,false,0);
    DefineMethod('PathParseIconLocationA',1,tkInteger,nil,__PathParseIconLocationA,false,0);
    DefineMethod('PathParseIconLocationW',1,tkInteger,nil,__PathParseIconLocationW,false,0);
    DefineMethod('PathQuoteSpaces',1,tkNone,nil,__PathQuoteSpaces,false,0);
    DefineMethod('PathQuoteSpacesA',1,tkNone,nil,__PathQuoteSpacesA,false,0);
    DefineMethod('PathQuoteSpacesW',1,tkNone,nil,__PathQuoteSpacesW,false,0);
    DefineMethod('PathRelativePathTo',5,tkVariant,nil,__PathRelativePathTo,false,0);
    DefineMethod('PathRelativePathToA',5,tkVariant,nil,__PathRelativePathToA,false,0);
    DefineMethod('PathRelativePathToW',5,tkVariant,nil,__PathRelativePathToW,false,0);
    DefineMethod('PathRemoveArgs',1,tkNone,nil,__PathRemoveArgs,false,0);
    DefineMethod('PathRemoveArgsA',1,tkNone,nil,__PathRemoveArgsA,false,0);
    DefineMethod('PathRemoveArgsW',1,tkNone,nil,__PathRemoveArgsW,false,0);
    DefineMethod('PathRemoveBackslash',1,tkVariant,nil,__PathRemoveBackslash,false,0);
    DefineMethod('PathRemoveBackslashA',1,tkVariant,nil,__PathRemoveBackslashA,false,0);
    DefineMethod('PathRemoveBackslashW',1,tkVariant,nil,__PathRemoveBackslashW,false,0);
    DefineMethod('PathRemoveBlanks',1,tkNone,nil,__PathRemoveBlanks,false,0);
    DefineMethod('PathRemoveBlanksA',1,tkNone,nil,__PathRemoveBlanksA,false,0);
    DefineMethod('PathRemoveBlanksW',1,tkNone,nil,__PathRemoveBlanksW,false,0);
    DefineMethod('PathRemoveExtension',1,tkNone,nil,__PathRemoveExtension,false,0);
    DefineMethod('PathRemoveExtensionA',1,tkNone,nil,__PathRemoveExtensionA,false,0);
    DefineMethod('PathRemoveExtensionW',1,tkNone,nil,__PathRemoveExtensionW,false,0);
    DefineMethod('PathRemoveFileSpec',1,tkVariant,nil,__PathRemoveFileSpec,false,0);
    DefineMethod('PathRemoveFileSpecA',1,tkVariant,nil,__PathRemoveFileSpecA,false,0);
    DefineMethod('PathRemoveFileSpecW',1,tkVariant,nil,__PathRemoveFileSpecW,false,0);
    DefineMethod('PathRenameExtension',2,tkVariant,nil,__PathRenameExtension,false,0);
    DefineMethod('PathRenameExtensionA',2,tkVariant,nil,__PathRenameExtensionA,false,0);
    DefineMethod('PathRenameExtensionW',2,tkVariant,nil,__PathRenameExtensionW,false,0);
    DefineMethod('PathSearchAndQualify',3,tkVariant,nil,__PathSearchAndQualify,false,0);
    DefineMethod('PathSearchAndQualifyA',3,tkVariant,nil,__PathSearchAndQualifyA,false,0);
    DefineMethod('PathSearchAndQualifyW',3,tkVariant,nil,__PathSearchAndQualifyW,false,0);
    DefineMethod('PathSetDlgItemPath',3,tkNone,nil,__PathSetDlgItemPath,false,0);
    DefineMethod('PathSetDlgItemPathA',3,tkNone,nil,__PathSetDlgItemPathA,false,0);
    DefineMethod('PathSetDlgItemPathW',3,tkNone,nil,__PathSetDlgItemPathW,false,0);
    DefineMethod('PathSkipRoot',1,tkVariant,nil,__PathSkipRoot,false,0);
    DefineMethod('PathSkipRootA',1,tkVariant,nil,__PathSkipRootA,false,0);
    DefineMethod('PathSkipRootW',1,tkVariant,nil,__PathSkipRootW,false,0);
    DefineMethod('PathStripPath',1,tkNone,nil,__PathStripPath,false,0);
    DefineMethod('PathStripPathA',1,tkNone,nil,__PathStripPathA,false,0);
    DefineMethod('PathStripPathW',1,tkNone,nil,__PathStripPathW,false,0);
    DefineMethod('PathStripToRoot',1,tkVariant,nil,__PathStripToRoot,false,0);
    DefineMethod('PathStripToRootA',1,tkVariant,nil,__PathStripToRootA,false,0);
    DefineMethod('PathStripToRootW',1,tkVariant,nil,__PathStripToRootW,false,0);
    DefineMethod('PathUnquoteSpaces',1,tkNone,nil,__PathUnquoteSpaces,false,0);
    DefineMethod('PathUnquoteSpacesA',1,tkNone,nil,__PathUnquoteSpacesA,false,0);
    DefineMethod('PathUnquoteSpacesW',1,tkNone,nil,__PathUnquoteSpacesW,false,0);
    DefineMethod('PathMakeSystemFolder',1,tkVariant,nil,__PathMakeSystemFolder,false,0);
    DefineMethod('PathMakeSystemFolderA',1,tkVariant,nil,__PathMakeSystemFolderA,false,0);
    DefineMethod('PathMakeSystemFolderW',1,tkVariant,nil,__PathMakeSystemFolderW,false,0);
    DefineMethod('PathUnmakeSystemFolder',1,tkVariant,nil,__PathUnmakeSystemFolder,false,0);
    DefineMethod('PathUnmakeSystemFolderA',1,tkVariant,nil,__PathUnmakeSystemFolderA,false,0);
    DefineMethod('PathUnmakeSystemFolderW',1,tkVariant,nil,__PathUnmakeSystemFolderW,false,0);
    DefineMethod('PathIsSystemFolder',2,tkVariant,nil,__PathIsSystemFolder,false,0);
    DefineMethod('PathIsSystemFolderA',2,tkVariant,nil,__PathIsSystemFolderA,false,0);
    DefineMethod('PathIsSystemFolderW',2,tkVariant,nil,__PathIsSystemFolderW,false,0);
    DefineMethod('PathUndecorate',1,tkNone,nil,__PathUndecorate,false,0);
    DefineMethod('PathUndecorateA',1,tkNone,nil,__PathUndecorateA,false,0);
    DefineMethod('PathUndecorateW',1,tkNone,nil,__PathUndecorateW,false,0);
    DefineMethod('PathUnExpandEnvStrings',3,tkVariant,nil,__PathUnExpandEnvStrings,false,0);
    DefineMethod('PathUnExpandEnvStringsA',3,tkVariant,nil,__PathUnExpandEnvStringsA,false,0);
    DefineMethod('PathUnExpandEnvStringsW',3,tkVariant,nil,__PathUnExpandEnvStringsW,false,0);
    DefineMethod('UrlCompare',3,tkInteger,nil,__UrlCompare,false,0);
    DefineMethod('UrlCompareA',3,tkInteger,nil,__UrlCompareA,false,0);
    DefineMethod('UrlCompareW',3,tkInteger,nil,__UrlCompareW,false,0);
    DefineMethod('UrlCombine',5,tkInteger,nil,__UrlCombine,false,0).SetVarArgs([3]);
    DefineMethod('UrlCombineA',5,tkInteger,nil,__UrlCombineA,false,0).SetVarArgs([3]);
    DefineMethod('UrlCombineW',5,tkInteger,nil,__UrlCombineW,false,0).SetVarArgs([3]);
    DefineMethod('UrlIsOpaque',1,tkVariant,nil,__UrlIsOpaque,false,0);
    DefineMethod('UrlIsOpaqueA',1,tkVariant,nil,__UrlIsOpaqueA,false,0);
    DefineMethod('UrlIsOpaqueW',1,tkVariant,nil,__UrlIsOpaqueW,false,0);
    DefineMethod('UrlIsNoHistory',1,tkVariant,nil,__UrlIsNoHistory,false,0);
    DefineMethod('UrlIsNoHistoryA',1,tkVariant,nil,__UrlIsNoHistoryA,false,0);
    DefineMethod('UrlIsNoHistoryW',1,tkVariant,nil,__UrlIsNoHistoryW,false,0);
    DefineMethod('UrlIsFileUrl',1,tkVariant,nil,__UrlIsFileUrl,false,0);
    DefineMethod('UrlIsFileUrlA',1,tkVariant,nil,__UrlIsFileUrlA,false,0);
    DefineMethod('UrlIsFileUrlW',1,tkVariant,nil,__UrlIsFileUrlW,false,0);
    DefineMethod('UrlIs',2,tkVariant,nil,__UrlIs,false,0);
    DefineMethod('UrlIsA',2,tkVariant,nil,__UrlIsA,false,0);
    DefineMethod('UrlIsW',2,tkVariant,nil,__UrlIsW,false,0);
    DefineMethod('UrlGetLocation',1,tkVariant,nil,__UrlGetLocation,false,0);
    DefineMethod('UrlGetLocationA',1,tkVariant,nil,__UrlGetLocationA,false,0);
    DefineMethod('UrlGetLocationW',1,tkVariant,nil,__UrlGetLocationW,false,0);
    DefineMethod('UrlUnescapeInPlace',2,tkInteger,nil,__UrlUnescapeInPlace,false,0);
    DefineMethod('UrlUnescapeInPlaceA',2,tkInteger,nil,__UrlUnescapeInPlaceA,false,0);
    DefineMethod('UrlUnescapeInPlaceW',2,tkInteger,nil,__UrlUnescapeInPlaceW,false,0);
    DefineMethod('SHDeleteEmptyKey',2,tkInteger,nil,__SHDeleteEmptyKey,false,0);
    DefineMethod('SHDeleteEmptyKeyA',2,tkInteger,nil,__SHDeleteEmptyKeyA,false,0);
    DefineMethod('SHDeleteEmptyKeyW',2,tkInteger,nil,__SHDeleteEmptyKeyW,false,0);
    DefineMethod('SHDeleteKey',2,tkInteger,nil,__SHDeleteKey,false,0);
    DefineMethod('SHDeleteKeyA',2,tkInteger,nil,__SHDeleteKeyA,false,0);
    DefineMethod('SHDeleteKeyW',2,tkInteger,nil,__SHDeleteKeyW,false,0);
    DefineMethod('SHDeleteValue',3,tkInteger,nil,__SHDeleteValue,false,0);
    DefineMethod('SHDeleteValueA',3,tkInteger,nil,__SHDeleteValueA,false,0);
    DefineMethod('SHDeleteValueW',3,tkInteger,nil,__SHDeleteValueW,false,0);
    DefineMethod('SHEnumKeyEx',4,tkInteger,nil,__SHEnumKeyEx,false,0).SetVarArgs([3]);
    DefineMethod('SHEnumKeyExA',4,tkInteger,nil,__SHEnumKeyExA,false,0).SetVarArgs([3]);
    DefineMethod('SHEnumKeyExW',4,tkInteger,nil,__SHEnumKeyExW,false,0).SetVarArgs([3]);
    DefineMethod('SHCopyKey',4,tkInteger,nil,__SHCopyKey,false,0);
    DefineMethod('SHCopyKeyA',4,tkInteger,nil,__SHCopyKeyA,false,0);
    DefineMethod('SHCopyKeyW',4,tkInteger,nil,__SHCopyKeyW,false,0);
    DefineMethod('SHRegGetPath',5,tkInteger,nil,__SHRegGetPath,false,0);
    DefineMethod('SHRegGetPathA',5,tkInteger,nil,__SHRegGetPathA,false,0);
    DefineMethod('SHRegGetPathW',5,tkInteger,nil,__SHRegGetPathW,false,0);
    DefineMethod('SHRegSetPath',5,tkInteger,nil,__SHRegSetPath,false,0);
    DefineMethod('SHRegSetPathA',5,tkInteger,nil,__SHRegSetPathA,false,0);
    DefineMethod('SHRegSetPathW',5,tkInteger,nil,__SHRegSetPathW,false,0);
    DefineMethod('SHRegDeleteUSValue',3,tkInteger,nil,__SHRegDeleteUSValue,false,0);
    DefineMethod('SHRegDeleteUSValueA',3,tkInteger,nil,__SHRegDeleteUSValueA,false,0);
    DefineMethod('SHRegDeleteUSValueW',3,tkInteger,nil,__SHRegDeleteUSValueW,false,0);
    DefineMethod('SHRegDeleteEmptyUSKey',3,tkInteger,nil,__SHRegDeleteEmptyUSKey,false,0);
    DefineMethod('SHRegDeleteEmptyUSKeyA',3,tkInteger,nil,__SHRegDeleteEmptyUSKeyA,false,0);
    DefineMethod('SHRegDeleteEmptyUSKeyW',3,tkInteger,nil,__SHRegDeleteEmptyUSKeyW,false,0);
    DefineMethod('SHRegCloseUSKey',1,tkInteger,nil,__SHRegCloseUSKey,false,0);
    DefineMethod('SHRegGetBoolUSValue',4,tkVariant,nil,__SHRegGetBoolUSValue,false,0);
    DefineMethod('SHRegGetBoolUSValueA',4,tkVariant,nil,__SHRegGetBoolUSValueA,false,0);
    DefineMethod('SHRegGetBoolUSValueW',4,tkVariant,nil,__SHRegGetBoolUSValueW,false,0);
    DefineMethod('AssocQueryKey',5,tkInteger,nil,__AssocQueryKey,false,0).SetVarArgs([4]);
    DefineMethod('AssocQueryKeyA',5,tkInteger,nil,__AssocQueryKeyA,false,0).SetVarArgs([4]);
    DefineMethod('AssocQueryKeyW',5,tkInteger,nil,__AssocQueryKeyW,false,0).SetVarArgs([4]);
    DefineMethod('SHAutoComplete',2,tkInteger,nil,__SHAutoComplete,false,0);
    DefineMethod('SHCreateShellPalette',1,tkInteger,nil,__SHCreateShellPalette,false,0);
    DefineMethod('ColorRGBToHLS',4,tkNone,nil,__ColorRGBToHLS,false,0).SetVarArgs([1,2,3]);
    DefineMethod('ColorHLSToRGB',3,tkInteger,nil,__ColorHLSToRGB,false,0);
    DefineMethod('ColorAdjustLuma',3,tkInteger,nil,__ColorAdjustLuma,false,0);
    DefineMethod('MAKEDLLVERULL',4,tkVariant,nil,__MAKEDLLVERULL,false,0);
    DefineProp('IID_IQueryAssociations',tkVariant,__GetIID_IQueryAssociations,nil,nil,false,0);
    DefineProp('CLSID_QueryAssociations',tkVariant,__GetCLSID_QueryAssociations,nil,nil,false,0);
    AddConstant('SZ_CONTENTTYPE_HTMLA',SZ_CONTENTTYPE_HTMLA);
    AddConstant('SZ_CONTENTTYPE_HTMLW',SZ_CONTENTTYPE_HTMLW);
    AddConstant('SZ_CONTENTTYPE_HTML',SZ_CONTENTTYPE_HTML);
    AddConstant('SZ_CONTENTTYPE_CDFA',SZ_CONTENTTYPE_CDFA);
    AddConstant('SZ_CONTENTTYPE_CDFW',SZ_CONTENTTYPE_CDFW);
    AddConstant('SZ_CONTENTTYPE_CDF',SZ_CONTENTTYPE_CDF);
    AddConstant('STIF_DEFAULT',STIF_DEFAULT);
    AddConstant('STIF_SUPPORT_HEX',STIF_SUPPORT_HEX);
    AddConstant('GCT_INVALID',GCT_INVALID);
    AddConstant('GCT_LFNCHAR',GCT_LFNCHAR);
    AddConstant('GCT_SHORTCHAR',GCT_SHORTCHAR);
    AddConstant('GCT_WILD',GCT_WILD);
    AddConstant('GCT_SEPARATOR',GCT_SEPARATOR);
    AddConstant('URL_SCHEME_INVALID',URL_SCHEME_INVALID);
    AddConstant('URL_SCHEME_UNKNOWN',URL_SCHEME_UNKNOWN);
    AddConstant('URL_SCHEME_FTP',URL_SCHEME_FTP);
    AddConstant('URL_SCHEME_HTTP',URL_SCHEME_HTTP);
    AddConstant('URL_SCHEME_GOPHER',URL_SCHEME_GOPHER);
    AddConstant('URL_SCHEME_MAILTO',URL_SCHEME_MAILTO);
    AddConstant('URL_SCHEME_NEWS',URL_SCHEME_NEWS);
    AddConstant('URL_SCHEME_NNTP',URL_SCHEME_NNTP);
    AddConstant('URL_SCHEME_TELNET',URL_SCHEME_TELNET);
    AddConstant('URL_SCHEME_WAIS',URL_SCHEME_WAIS);
    AddConstant('URL_SCHEME_FILE',URL_SCHEME_FILE);
    AddConstant('URL_SCHEME_MK',URL_SCHEME_MK);
    AddConstant('URL_SCHEME_HTTPS',URL_SCHEME_HTTPS);
    AddConstant('URL_SCHEME_SHELL',URL_SCHEME_SHELL);
    AddConstant('URL_SCHEME_SNEWS',URL_SCHEME_SNEWS);
    AddConstant('URL_SCHEME_LOCAL',URL_SCHEME_LOCAL);
    AddConstant('URL_SCHEME_JAVASCRIPT',URL_SCHEME_JAVASCRIPT);
    AddConstant('URL_SCHEME_VBSCRIPT',URL_SCHEME_VBSCRIPT);
    AddConstant('URL_SCHEME_ABOUT',URL_SCHEME_ABOUT);
    AddConstant('URL_SCHEME_RES',URL_SCHEME_RES);
    AddConstant('URL_SCHEME_MAXVALUE',URL_SCHEME_MAXVALUE);
    AddConstant('URL_PART_NONE',URL_PART_NONE);
    AddConstant('URL_PART_SCHEME',URL_PART_SCHEME);
    AddConstant('URL_PART_HOSTNAME',URL_PART_HOSTNAME);
    AddConstant('URL_PART_USERNAME',URL_PART_USERNAME);
    AddConstant('URL_PART_PASSWORD',URL_PART_PASSWORD);
    AddConstant('URL_PART_PORT',URL_PART_PORT);
    AddConstant('URL_PART_QUERY',URL_PART_QUERY);
    AddConstant('URLIS_URL',URLIS_URL);
    AddConstant('URLIS_OPAQUE',URLIS_OPAQUE);
    AddConstant('URLIS_NOHISTORY',URLIS_NOHISTORY);
    AddConstant('URLIS_FILEURL',URLIS_FILEURL);
    AddConstant('URLIS_APPLIABLE',URLIS_APPLIABLE);
    AddConstant('URLIS_DIRECTORY',URLIS_DIRECTORY);
    AddConstant('URLIS_HASQUERY',URLIS_HASQUERY);
    AddConstant('URL_UNESCAPE',URL_UNESCAPE);
    AddConstant('URL_ESCAPE_UNSAFE',URL_ESCAPE_UNSAFE);
    AddConstant('URL_PLUGGABLE_PROTOCOL',URL_PLUGGABLE_PROTOCOL);
    AddConstant('URL_WININET_COMPATIBILITY',URL_WININET_COMPATIBILITY);
    AddConstant('URL_DONT_ESCAPE_EXTRA_INFO',URL_DONT_ESCAPE_EXTRA_INFO);
    AddConstant('URL_DONT_UNESCAPE_EXTRA_INFO',URL_DONT_UNESCAPE_EXTRA_INFO);
    AddConstant('URL_BROWSER_MODE',URL_BROWSER_MODE);
    AddConstant('URL_ESCAPE_SPACES_ONLY',URL_ESCAPE_SPACES_ONLY);
    AddConstant('URL_DONT_SIMPLIFY',URL_DONT_SIMPLIFY);
    AddConstant('URL_NO_META',URL_NO_META);
    AddConstant('URL_UNESCAPE_INPLACE',URL_UNESCAPE_INPLACE);
    AddConstant('URL_CONVERT_IF_DOSPATH',URL_CONVERT_IF_DOSPATH);
    AddConstant('URL_UNESCAPE_HIGH_ANSI_ONLY',URL_UNESCAPE_HIGH_ANSI_ONLY);
    AddConstant('URL_INTERNAL_PATH',URL_INTERNAL_PATH);
    AddConstant('URL_FILE_USE_PATHURL',URL_FILE_USE_PATHURL);
    AddConstant('URL_ESCAPE_PERCENT',URL_ESCAPE_PERCENT);
    AddConstant('URL_ESCAPE_SEGMENT_ONLY',URL_ESCAPE_SEGMENT_ONLY);
    AddConstant('URL_PARTFLAG_KEEPSCHEME',URL_PARTFLAG_KEEPSCHEME);
    AddConstant('URL_APPLY_DEFAULT',URL_APPLY_DEFAULT);
    AddConstant('URL_APPLY_GUESSSCHEME',URL_APPLY_GUESSSCHEME);
    AddConstant('URL_APPLY_GUESSFILE',URL_APPLY_GUESSFILE);
    AddConstant('URL_APPLY_FORCEAPPLY',URL_APPLY_FORCEAPPLY);
    AddConstant('SHREGDEL_DEFAULT',SHREGDEL_DEFAULT);
    AddConstant('SHREGDEL_HKCU',SHREGDEL_HKCU);
    AddConstant('SHREGDEL_HKLM',SHREGDEL_HKLM);
    AddConstant('SHREGDEL_BOTH',SHREGDEL_BOTH);
    AddConstant('SHREGENUM_DEFAULT',SHREGENUM_DEFAULT);
    AddConstant('SHREGENUM_HKCU',SHREGENUM_HKCU);
    AddConstant('SHREGENUM_HKLM',SHREGENUM_HKLM);
    AddConstant('SHREGENUM_BOTH',SHREGENUM_BOTH);
    AddConstant('SHREGSET_HKCU',SHREGSET_HKCU);
    AddConstant('SHREGSET_FORCE_HKCU',SHREGSET_FORCE_HKCU);
    AddConstant('SHREGSET_HKLM',SHREGSET_HKLM);
    AddConstant('SHREGSET_FORCE_HKLM',SHREGSET_FORCE_HKLM);
    AddConstant('SHREGSET_DEFAULT',SHREGSET_DEFAULT);
    AddConstant('ASSOCF_INIT_NOREMAPCLSID',ASSOCF_INIT_NOREMAPCLSID);
    AddConstant('ASSOCF_INIT_BYEXENAME',ASSOCF_INIT_BYEXENAME);
    AddConstant('ASSOCF_OPEN_BYEXENAME',ASSOCF_OPEN_BYEXENAME);
    AddConstant('ASSOCF_INIT_DEFAULTTOSTAR',ASSOCF_INIT_DEFAULTTOSTAR);
    AddConstant('ASSOCF_INIT_DEFAULTTOFOLDER',ASSOCF_INIT_DEFAULTTOFOLDER);
    AddConstant('ASSOCF_NOUSERSETTINGS',ASSOCF_NOUSERSETTINGS);
    AddConstant('ASSOCF_NOTRUNCATE',ASSOCF_NOTRUNCATE);
    AddConstant('ASSOCF_VERIFY',ASSOCF_VERIFY);
    AddConstant('ASSOCF_REMAPRUNDLL',ASSOCF_REMAPRUNDLL);
    AddConstant('ASSOCF_NOFIXUPS',ASSOCF_NOFIXUPS);
    AddConstant('ASSOCF_IGNOREBASECLASS',ASSOCF_IGNOREBASECLASS);
    AddConstant('ASSOCSTR_COMMAND',ASSOCSTR_COMMAND);
    AddConstant('ASSOCSTR_EXECUTABLE',ASSOCSTR_EXECUTABLE);
    AddConstant('ASSOCSTR_FRIENDLYDOCNAME',ASSOCSTR_FRIENDLYDOCNAME);
    AddConstant('ASSOCSTR_FRIENDLYAPPNAME',ASSOCSTR_FRIENDLYAPPNAME);
    AddConstant('ASSOCSTR_NOOPEN',ASSOCSTR_NOOPEN);
    AddConstant('ASSOCSTR_SHELLNEWVALUE',ASSOCSTR_SHELLNEWVALUE);
    AddConstant('ASSOCSTR_DDECOMMAND',ASSOCSTR_DDECOMMAND);
    AddConstant('ASSOCSTR_DDEIFEXEC',ASSOCSTR_DDEIFEXEC);
    AddConstant('ASSOCSTR_DDEAPPLICATION',ASSOCSTR_DDEAPPLICATION);
    AddConstant('ASSOCSTR_DDETOPIC',ASSOCSTR_DDETOPIC);
    AddConstant('ASSOCSTR_INFOTIP',ASSOCSTR_INFOTIP);
    AddConstant('ASSOCSTR_MAX',ASSOCSTR_MAX);
    AddConstant('ASSOCKEY_SHELLEXECCLASS',ASSOCKEY_SHELLEXECCLASS);
    AddConstant('ASSOCKEY_APP',ASSOCKEY_APP);
    AddConstant('ASSOCKEY_CLASS',ASSOCKEY_CLASS);
    AddConstant('ASSOCKEY_BASECLASS',ASSOCKEY_BASECLASS);
    AddConstant('ASSOCKEY_MAX',ASSOCKEY_MAX);
    AddConstant('ASSOCDATA_MSIDESCRIPTOR',ASSOCDATA_MSIDESCRIPTOR);
    AddConstant('ASSOCDATA_NOACTIVATEHANDLER',ASSOCDATA_NOACTIVATEHANDLER);
    AddConstant('ASSOCDATA_QUERYCLASSSTORE',ASSOCDATA_QUERYCLASSSTORE);
    AddConstant('ASSOCDATA_HASPERUSERASSOC',ASSOCDATA_HASPERUSERASSOC);
    AddConstant('ASSOCDATA_MAX',ASSOCDATA_MAX);
    AddConstant('ASSOCENUM_NONE',ASSOCENUM_NONE);
    AddConstant('SID_IQueryAssociations',SID_IQueryAssociations);
    AddConstant('SHACF_DEFAULT',SHACF_DEFAULT);
    AddConstant('SHACF_FILESYSTEM',SHACF_FILESYSTEM);
    AddConstant('SHACF_URLHISTORY',SHACF_URLHISTORY);
    AddConstant('SHACF_URLMRU',SHACF_URLMRU);
    AddConstant('SHACF_USETAB',SHACF_USETAB);
    AddConstant('SHACF_FILESYS_ONLY',SHACF_FILESYS_ONLY);
    AddConstant('SHACF_URLALL',SHACF_URLALL);
    AddConstant('SHACF_AUTOSUGGEST_FORCE_ON',SHACF_AUTOSUGGEST_FORCE_ON);
    AddConstant('SHACF_AUTOSUGGEST_FORCE_OFF',SHACF_AUTOSUGGEST_FORCE_OFF);
    AddConstant('SHACF_AUTOAPPEND_FORCE_ON',SHACF_AUTOAPPEND_FORCE_ON);
    AddConstant('SHACF_AUTOAPPEND_FORCE_OFF',SHACF_AUTOAPPEND_FORCE_OFF);
    AddConstant('CTF_INSIST',CTF_INSIST);
    AddConstant('CTF_THREAD_REF',CTF_THREAD_REF);
    AddConstant('CTF_PROCESS_REF',CTF_PROCESS_REF);
    AddConstant('CTF_COINIT',CTF_COINIT);
    AddConstant('DLLVER_PLATFORM_WINDOWS',DLLVER_PLATFORM_WINDOWS);
    AddConstant('DLLVER_PLATFORM_NT',DLLVER_PLATFORM_NT);
    AddConstant('DLLVER_MAJOR_MASK',DLLVER_MAJOR_MASK);
    AddConstant('DLLVER_MINOR_MASK',DLLVER_MINOR_MASK);
    AddConstant('DLLVER_BUILD_MASK',DLLVER_BUILD_MASK);
    AddConstant('DLLVER_QFE_MASK',DLLVER_QFE_MASK);
  end;
end;

class function TatShLwApiLibrary.LibraryName: string;
begin
  result := 'ShLwApi';
end;

initialization
  RegisterScripterLibrary(TatShLwApiLibrary, True);

{$WARNINGS ON}

end.

