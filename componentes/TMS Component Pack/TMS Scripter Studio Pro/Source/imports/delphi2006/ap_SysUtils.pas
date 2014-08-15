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
unit ap_SysUtils;

interface

uses
  Windows,
  SysConst,
  SysUtils,
  Variants,
  ap_Windows,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatSysUtilsLibrary = class(TatScripterLibrary)
    procedure __TLanguagesCreate(AMachine: TatVirtualMachine);
    procedure __TLanguagesIndexOf(AMachine: TatVirtualMachine);
    procedure __GetTLanguagesCount(AMachine: TatVirtualMachine);
    procedure __GetTLanguagesName(AMachine: TatVirtualMachine);
    procedure __GetTLanguagesNameFromLocaleID(AMachine: TatVirtualMachine);
    procedure __GetTLanguagesNameFromLCID(AMachine: TatVirtualMachine);
    procedure __GetTLanguagesID(AMachine: TatVirtualMachine);
    procedure __GetTLanguagesLocaleID(AMachine: TatVirtualMachine);
    procedure __GetTLanguagesExt(AMachine: TatVirtualMachine);
    procedure __ExceptionCreate(AMachine: TatVirtualMachine);
    procedure __ExceptionCreateRes(AMachine: TatVirtualMachine);
    procedure __ExceptionCreateHelp(AMachine: TatVirtualMachine);
    procedure __ExceptionCreateResHelp(AMachine: TatVirtualMachine);
    procedure __GetExceptionHelpContext(AMachine: TatVirtualMachine);
    procedure __SetExceptionHelpContext(AMachine: TatVirtualMachine);
    procedure __GetExceptionMessage(AMachine: TatVirtualMachine);
    procedure __SetExceptionMessage(AMachine: TatVirtualMachine);
    procedure __EHeapExceptionFreeInstance(AMachine: TatVirtualMachine);
    procedure __TSimpleRWSyncCreate(AMachine: TatVirtualMachine);
    procedure __TSimpleRWSyncDestroy(AMachine: TatVirtualMachine);
    procedure __TSimpleRWSyncBeginRead(AMachine: TatVirtualMachine);
    procedure __TSimpleRWSyncEndRead(AMachine: TatVirtualMachine);
    procedure __TSimpleRWSyncBeginWrite(AMachine: TatVirtualMachine);
    procedure __TSimpleRWSyncEndWrite(AMachine: TatVirtualMachine);
    procedure __TThreadLocalCounterDestroy(AMachine: TatVirtualMachine);
    procedure __TMultiReadExclusiveWriteSynchronizerCreate(AMachine: TatVirtualMachine);
    procedure __TMultiReadExclusiveWriteSynchronizerDestroy(AMachine: TatVirtualMachine);
    procedure __TMultiReadExclusiveWriteSynchronizerBeginRead(AMachine: TatVirtualMachine);
    procedure __TMultiReadExclusiveWriteSynchronizerEndRead(AMachine: TatVirtualMachine);
    procedure __TMultiReadExclusiveWriteSynchronizerBeginWrite(AMachine: TatVirtualMachine);
    procedure __TMultiReadExclusiveWriteSynchronizerEndWrite(AMachine: TatVirtualMachine);
    procedure __GetTMultiReadExclusiveWriteSynchronizerRevisionLevel(AMachine: TatVirtualMachine);
    procedure __CheckWin32Version(AMachine: TatVirtualMachine);
    procedure __GetFileVersion(AMachine: TatVirtualMachine);
    procedure __Languages(AMachine: TatVirtualMachine);
    procedure __AppendStr(AMachine: TatVirtualMachine);
    procedure __UpperCase(AMachine: TatVirtualMachine);
    procedure __LowerCase(AMachine: TatVirtualMachine);
    procedure __CompareStr(AMachine: TatVirtualMachine);
    procedure __SameStr(AMachine: TatVirtualMachine);
    procedure __CompareText(AMachine: TatVirtualMachine);
    procedure __SameText(AMachine: TatVirtualMachine);
    procedure __AnsiUpperCase(AMachine: TatVirtualMachine);
    procedure __AnsiLowerCase(AMachine: TatVirtualMachine);
    procedure __AnsiCompareStr(AMachine: TatVirtualMachine);
    procedure __AnsiSameStr(AMachine: TatVirtualMachine);
    procedure __AnsiCompareText(AMachine: TatVirtualMachine);
    procedure __AnsiSameText(AMachine: TatVirtualMachine);
    procedure __AnsiStrComp(AMachine: TatVirtualMachine);
    procedure __AnsiStrIComp(AMachine: TatVirtualMachine);
    procedure __AnsiStrLComp(AMachine: TatVirtualMachine);
    procedure __AnsiStrLIComp(AMachine: TatVirtualMachine);
    procedure __AnsiStrLower(AMachine: TatVirtualMachine);
    procedure __AnsiStrUpper(AMachine: TatVirtualMachine);
    procedure __AnsiLastChar(AMachine: TatVirtualMachine);
    procedure __AnsiStrLastChar(AMachine: TatVirtualMachine);
    procedure __WideUpperCase(AMachine: TatVirtualMachine);
    procedure __WideLowerCase(AMachine: TatVirtualMachine);
    procedure __WideCompareStr(AMachine: TatVirtualMachine);
    procedure __WideSameStr(AMachine: TatVirtualMachine);
    procedure __WideCompareText(AMachine: TatVirtualMachine);
    procedure __WideSameText(AMachine: TatVirtualMachine);
    procedure __Trim(AMachine: TatVirtualMachine);
    procedure __TrimLeft(AMachine: TatVirtualMachine);
    procedure __TrimRight(AMachine: TatVirtualMachine);
    procedure __QuotedStr(AMachine: TatVirtualMachine);
    procedure __AnsiQuotedStr(AMachine: TatVirtualMachine);
    procedure __AnsiExtractQuotedStr(AMachine: TatVirtualMachine);
    procedure __AnsiDequotedStr(AMachine: TatVirtualMachine);
    procedure __AdjustLineBreaks(AMachine: TatVirtualMachine);
    procedure __IsValidIdent(AMachine: TatVirtualMachine);
    procedure __IntToStr(AMachine: TatVirtualMachine);
    procedure __IntToHex(AMachine: TatVirtualMachine);
    procedure __StrToInt(AMachine: TatVirtualMachine);
    procedure __StrToIntDef(AMachine: TatVirtualMachine);
    procedure __TryStrToInt(AMachine: TatVirtualMachine);
    procedure __StrToInt64(AMachine: TatVirtualMachine);
    procedure __StrToInt64Def(AMachine: TatVirtualMachine);
    procedure __TryStrToInt64(AMachine: TatVirtualMachine);
    procedure __StrToBool(AMachine: TatVirtualMachine);
    procedure __StrToBoolDef(AMachine: TatVirtualMachine);
    procedure __TryStrToBool(AMachine: TatVirtualMachine);
    procedure __BoolToStr(AMachine: TatVirtualMachine);
    procedure __LoadStr(AMachine: TatVirtualMachine);
    procedure __FileOpen(AMachine: TatVirtualMachine);
    procedure __FileCreate(AMachine: TatVirtualMachine);
    procedure __FileRead(AMachine: TatVirtualMachine);
    procedure __FileWrite(AMachine: TatVirtualMachine);
    procedure __FileSeek(AMachine: TatVirtualMachine);
    procedure __FileClose(AMachine: TatVirtualMachine);
    procedure __FileAge(AMachine: TatVirtualMachine);
    procedure __FileExists(AMachine: TatVirtualMachine);
    procedure __DirectoryExists(AMachine: TatVirtualMachine);
    procedure __ForceDirectories(AMachine: TatVirtualMachine);
    procedure __FindFirst(AMachine: TatVirtualMachine);
    procedure __FindNext(AMachine: TatVirtualMachine);
    procedure __FindClose(AMachine: TatVirtualMachine);
    procedure __FileGetDate(AMachine: TatVirtualMachine);
    procedure __FileSetDate(AMachine: TatVirtualMachine);
    procedure __FileGetAttr(AMachine: TatVirtualMachine);
    procedure __FileSetAttr(AMachine: TatVirtualMachine);
    procedure __FileIsReadOnly(AMachine: TatVirtualMachine);
    procedure __FileSetReadOnly(AMachine: TatVirtualMachine);
    procedure __DeleteFile(AMachine: TatVirtualMachine);
    procedure __RenameFile(AMachine: TatVirtualMachine);
    procedure __IsAssembly(AMachine: TatVirtualMachine);
    procedure __ChangeFileExt(AMachine: TatVirtualMachine);
    procedure __ChangeFilePath(AMachine: TatVirtualMachine);
    procedure __ExtractFilePath(AMachine: TatVirtualMachine);
    procedure __ExtractFileDir(AMachine: TatVirtualMachine);
    procedure __ExtractFileDrive(AMachine: TatVirtualMachine);
    procedure __ExtractFileName(AMachine: TatVirtualMachine);
    procedure __ExtractFileExt(AMachine: TatVirtualMachine);
    procedure __ExpandFileName(AMachine: TatVirtualMachine);
    procedure __ExpandFileNameCase(AMachine: TatVirtualMachine);
    procedure __ExpandUNCFileName(AMachine: TatVirtualMachine);
    procedure __ExtractRelativePath(AMachine: TatVirtualMachine);
    procedure __ExtractShortPathName(AMachine: TatVirtualMachine);
    procedure __FileSearch(AMachine: TatVirtualMachine);
    procedure __DiskFree(AMachine: TatVirtualMachine);
    procedure __DiskSize(AMachine: TatVirtualMachine);
    procedure __FileDateToDateTime(AMachine: TatVirtualMachine);
    procedure __DateTimeToFileDate(AMachine: TatVirtualMachine);
    procedure __GetCurrentDir(AMachine: TatVirtualMachine);
    procedure __SetCurrentDir(AMachine: TatVirtualMachine);
    procedure __CreateDir(AMachine: TatVirtualMachine);
    procedure __RemoveDir(AMachine: TatVirtualMachine);
    procedure __StrLen(AMachine: TatVirtualMachine);
    procedure __StrEnd(AMachine: TatVirtualMachine);
    procedure __StrMove(AMachine: TatVirtualMachine);
    procedure __StrCopy(AMachine: TatVirtualMachine);
    procedure __StrECopy(AMachine: TatVirtualMachine);
    procedure __StrLCopy(AMachine: TatVirtualMachine);
    procedure __StrPCopy(AMachine: TatVirtualMachine);
    procedure __StrPLCopy(AMachine: TatVirtualMachine);
    procedure __StrCat(AMachine: TatVirtualMachine);
    procedure __StrLCat(AMachine: TatVirtualMachine);
    procedure __StrComp(AMachine: TatVirtualMachine);
    procedure __StrIComp(AMachine: TatVirtualMachine);
    procedure __StrLComp(AMachine: TatVirtualMachine);
    procedure __StrLIComp(AMachine: TatVirtualMachine);
    procedure __StrScan(AMachine: TatVirtualMachine);
    procedure __StrRScan(AMachine: TatVirtualMachine);
    procedure __StrPos(AMachine: TatVirtualMachine);
    procedure __StrUpper(AMachine: TatVirtualMachine);
    procedure __StrLower(AMachine: TatVirtualMachine);
    procedure __StrPas(AMachine: TatVirtualMachine);
    procedure __StrAlloc(AMachine: TatVirtualMachine);
    procedure __StrBufSize(AMachine: TatVirtualMachine);
    procedure __StrNew(AMachine: TatVirtualMachine);
    procedure __StrDispose(AMachine: TatVirtualMachine);
    procedure __FloatToStr(AMachine: TatVirtualMachine);
    procedure __CurrToStr(AMachine: TatVirtualMachine);
    procedure __FloatToCurr(AMachine: TatVirtualMachine);
    procedure __TryFloatToCurr(AMachine: TatVirtualMachine);
    procedure __FloatToStrF(AMachine: TatVirtualMachine);
    procedure __CurrToStrF(AMachine: TatVirtualMachine);
    procedure __FloatToText(AMachine: TatVirtualMachine);
    procedure __FormatFloat(AMachine: TatVirtualMachine);
    procedure __FormatCurr(AMachine: TatVirtualMachine);
    procedure __FloatToTextFmt(AMachine: TatVirtualMachine);
    procedure __StrToFloat(AMachine: TatVirtualMachine);
    procedure __StrToFloatDef(AMachine: TatVirtualMachine);
    procedure __TryStrToFloat(AMachine: TatVirtualMachine);
    procedure __StrToCurr(AMachine: TatVirtualMachine);
    procedure __StrToCurrDef(AMachine: TatVirtualMachine);
    procedure __TryStrToCurr(AMachine: TatVirtualMachine);
    procedure __TextToFloat(AMachine: TatVirtualMachine);
    procedure __FloatToDecimal(AMachine: TatVirtualMachine);
    procedure __DateTimeToTimeStamp(AMachine: TatVirtualMachine);
    procedure __TimeStampToDateTime(AMachine: TatVirtualMachine);
    procedure __MSecsToTimeStamp(AMachine: TatVirtualMachine);
    procedure __TimeStampToMSecs(AMachine: TatVirtualMachine);
    procedure __EncodeDate(AMachine: TatVirtualMachine);
    procedure __EncodeTime(AMachine: TatVirtualMachine);
    procedure __TryEncodeDate(AMachine: TatVirtualMachine);
    procedure __TryEncodeTime(AMachine: TatVirtualMachine);
    procedure __DecodeDate(AMachine: TatVirtualMachine);
    procedure __DecodeDateFully(AMachine: TatVirtualMachine);
    procedure __DecodeTime(AMachine: TatVirtualMachine);
    procedure __DateTimeToSystemTime(AMachine: TatVirtualMachine);
    procedure __SystemTimeToDateTime(AMachine: TatVirtualMachine);
    procedure __DayOfWeek(AMachine: TatVirtualMachine);
    procedure __Date(AMachine: TatVirtualMachine);
    procedure __Time(AMachine: TatVirtualMachine);
    procedure __GetTime(AMachine: TatVirtualMachine);
    procedure __Now(AMachine: TatVirtualMachine);
    procedure __CurrentYear(AMachine: TatVirtualMachine);
    procedure __IncMonth(AMachine: TatVirtualMachine);
    procedure __IncAMonth(AMachine: TatVirtualMachine);
    procedure __ReplaceTime(AMachine: TatVirtualMachine);
    procedure __ReplaceDate(AMachine: TatVirtualMachine);
    procedure __IsLeapYear(AMachine: TatVirtualMachine);
    procedure __DateToStr(AMachine: TatVirtualMachine);
    procedure __TimeToStr(AMachine: TatVirtualMachine);
    procedure __DateTimeToStr(AMachine: TatVirtualMachine);
    procedure __StrToDate(AMachine: TatVirtualMachine);
    procedure __StrToDateDef(AMachine: TatVirtualMachine);
    procedure __TryStrToDate(AMachine: TatVirtualMachine);
    procedure __StrToTime(AMachine: TatVirtualMachine);
    procedure __StrToTimeDef(AMachine: TatVirtualMachine);
    procedure __TryStrToTime(AMachine: TatVirtualMachine);
    procedure __StrToDateTime(AMachine: TatVirtualMachine);
    procedure __StrToDateTimeDef(AMachine: TatVirtualMachine);
    procedure __TryStrToDateTime(AMachine: TatVirtualMachine);
    procedure __FormatDateTime(AMachine: TatVirtualMachine);
    procedure __DateTimeToString(AMachine: TatVirtualMachine);
    procedure __FloatToDateTime(AMachine: TatVirtualMachine);
    procedure __TryFloatToDateTime(AMachine: TatVirtualMachine);
    procedure __SysErrorMessage(AMachine: TatVirtualMachine);
    procedure __GetLocaleStr(AMachine: TatVirtualMachine);
    procedure __GetLocaleChar(AMachine: TatVirtualMachine);
    procedure __GetFormatSettings(AMachine: TatVirtualMachine);
    procedure __GetLocaleFormatSettings(AMachine: TatVirtualMachine);
    procedure __Sleep(AMachine: TatVirtualMachine);
    procedure __GetModuleName(AMachine: TatVirtualMachine);
    procedure __Abort(AMachine: TatVirtualMachine);
    procedure __OutOfMemoryError(AMachine: TatVirtualMachine);
    procedure __Beep(AMachine: TatVirtualMachine);
    procedure __ByteType(AMachine: TatVirtualMachine);
    procedure __StrByteType(AMachine: TatVirtualMachine);
    procedure __ByteToCharLen(AMachine: TatVirtualMachine);
    procedure __CharToByteLen(AMachine: TatVirtualMachine);
    procedure __ByteToCharIndex(AMachine: TatVirtualMachine);
    procedure __CharToByteIndex(AMachine: TatVirtualMachine);
    procedure __StrCharLength(AMachine: TatVirtualMachine);
    procedure __StrNextChar(AMachine: TatVirtualMachine);
    procedure __CharLength(AMachine: TatVirtualMachine);
    procedure __NextCharIndex(AMachine: TatVirtualMachine);
    procedure __IsPathDelimiter(AMachine: TatVirtualMachine);
    procedure __IsDelimiter(AMachine: TatVirtualMachine);
    procedure __IncludeTrailingPathDelimiter(AMachine: TatVirtualMachine);
    procedure __IncludeTrailingBackslash(AMachine: TatVirtualMachine);
    procedure __ExcludeTrailingPathDelimiter(AMachine: TatVirtualMachine);
    procedure __ExcludeTrailingBackslash(AMachine: TatVirtualMachine);
    procedure __LastDelimiter(AMachine: TatVirtualMachine);
    procedure __AnsiCompareFileName(AMachine: TatVirtualMachine);
    procedure __SameFileName(AMachine: TatVirtualMachine);
    procedure __AnsiLowerCaseFileName(AMachine: TatVirtualMachine);
    procedure __AnsiUpperCaseFileName(AMachine: TatVirtualMachine);
    procedure __AnsiPos(AMachine: TatVirtualMachine);
    procedure __AnsiStrPos(AMachine: TatVirtualMachine);
    procedure __AnsiStrRScan(AMachine: TatVirtualMachine);
    procedure __AnsiStrScan(AMachine: TatVirtualMachine);
    procedure __StringReplace(AMachine: TatVirtualMachine);
    procedure __WrapText(AMachine: TatVirtualMachine);
    procedure __FindCmdLineSwitch(AMachine: TatVirtualMachine);
    procedure __FreeAndNil(AMachine: TatVirtualMachine);
    procedure __Supports(AMachine: TatVirtualMachine);
    procedure __CreateGUID(AMachine: TatVirtualMachine);
    procedure __StringToGUID(AMachine: TatVirtualMachine);
    procedure __GUIDToString(AMachine: TatVirtualMachine);
    procedure __IsEqualGUID(AMachine: TatVirtualMachine);
    procedure __LoadPackage(AMachine: TatVirtualMachine);
    procedure __UnloadPackage(AMachine: TatVirtualMachine);
    procedure __GetPackageDescription(AMachine: TatVirtualMachine);
    procedure __InitializePackage(AMachine: TatVirtualMachine);
    procedure __FinalizePackage(AMachine: TatVirtualMachine);
    procedure __RaiseLastOSError(AMachine: TatVirtualMachine);
    procedure __RaiseLastWin32Error(AMachine: TatVirtualMachine);
    procedure __Win32Check(AMachine: TatVirtualMachine);
    procedure __CallTerminateProcs(AMachine: TatVirtualMachine);
    procedure __GDAL(AMachine: TatVirtualMachine);
    procedure __RCS(AMachine: TatVirtualMachine);
    procedure __RPR(AMachine: TatVirtualMachine);
    procedure __SafeLoadLibrary(AMachine: TatVirtualMachine);
    procedure __GetEnvironmentVariable(AMachine: TatVirtualMachine);
    procedure __GetEmptyStr(AMachine: TatVirtualMachine);
    procedure __SetEmptyStr(AMachine: TatVirtualMachine);
    procedure __GetEmptyWideStr(AMachine: TatVirtualMachine);
    procedure __SetEmptyWideStr(AMachine: TatVirtualMachine);
    procedure __GetWin32Platform(AMachine: TatVirtualMachine);
    procedure __SetWin32Platform(AMachine: TatVirtualMachine);
    procedure __GetWin32MajorVersion(AMachine: TatVirtualMachine);
    procedure __SetWin32MajorVersion(AMachine: TatVirtualMachine);
    procedure __GetWin32MinorVersion(AMachine: TatVirtualMachine);
    procedure __SetWin32MinorVersion(AMachine: TatVirtualMachine);
    procedure __GetWin32BuildNumber(AMachine: TatVirtualMachine);
    procedure __SetWin32BuildNumber(AMachine: TatVirtualMachine);
    procedure __GetWin32CSDVersion(AMachine: TatVirtualMachine);
    procedure __SetWin32CSDVersion(AMachine: TatVirtualMachine);
    procedure __GetCurrencyString(AMachine: TatVirtualMachine);
    procedure __SetCurrencyString(AMachine: TatVirtualMachine);
    procedure __GetCurrencyFormat(AMachine: TatVirtualMachine);
    procedure __SetCurrencyFormat(AMachine: TatVirtualMachine);
    procedure __GetNegCurrFormat(AMachine: TatVirtualMachine);
    procedure __SetNegCurrFormat(AMachine: TatVirtualMachine);
    procedure __GetThousandSeparator(AMachine: TatVirtualMachine);
    procedure __SetThousandSeparator(AMachine: TatVirtualMachine);
    procedure __GetDecimalSeparator(AMachine: TatVirtualMachine);
    procedure __SetDecimalSeparator(AMachine: TatVirtualMachine);
    procedure __GetCurrencyDecimals(AMachine: TatVirtualMachine);
    procedure __SetCurrencyDecimals(AMachine: TatVirtualMachine);
    procedure __GetDateSeparator(AMachine: TatVirtualMachine);
    procedure __SetDateSeparator(AMachine: TatVirtualMachine);
    procedure __GetShortDateFormat(AMachine: TatVirtualMachine);
    procedure __SetShortDateFormat(AMachine: TatVirtualMachine);
    procedure __GetLongDateFormat(AMachine: TatVirtualMachine);
    procedure __SetLongDateFormat(AMachine: TatVirtualMachine);
    procedure __GetTimeSeparator(AMachine: TatVirtualMachine);
    procedure __SetTimeSeparator(AMachine: TatVirtualMachine);
    procedure __GetTimeAMString(AMachine: TatVirtualMachine);
    procedure __SetTimeAMString(AMachine: TatVirtualMachine);
    procedure __GetTimePMString(AMachine: TatVirtualMachine);
    procedure __SetTimePMString(AMachine: TatVirtualMachine);
    procedure __GetShortTimeFormat(AMachine: TatVirtualMachine);
    procedure __SetShortTimeFormat(AMachine: TatVirtualMachine);
    procedure __GetLongTimeFormat(AMachine: TatVirtualMachine);
    procedure __SetLongTimeFormat(AMachine: TatVirtualMachine);
    procedure __GetSysLocale(AMachine: TatVirtualMachine);
    procedure __SetSysLocale(AMachine: TatVirtualMachine);
    procedure __GetTwoDigitYearCenturyWindow(AMachine: TatVirtualMachine);
    procedure __SetTwoDigitYearCenturyWindow(AMachine: TatVirtualMachine);
    procedure __GetListSeparator(AMachine: TatVirtualMachine);
    procedure __SetListSeparator(AMachine: TatVirtualMachine);
    procedure __GetMinCurrency(AMachine: TatVirtualMachine);
    procedure __GetMaxCurrency(AMachine: TatVirtualMachine);
    procedure __GetMinDateTime(AMachine: TatVirtualMachine);
    procedure __GetMaxDateTime(AMachine: TatVirtualMachine);
    procedure __GetLeadBytes(AMachine: TatVirtualMachine);
    procedure __SetLeadBytes(AMachine: TatVirtualMachine);
    procedure __GetHexDisplayPrefix(AMachine: TatVirtualMachine);
    procedure __SetHexDisplayPrefix(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TLanguagesClass = class of TLanguages;
  ExceptionClass = class of Exception;
  EAbortClass = class of EAbort;
  EHeapExceptionClass = class of EHeapException;
  EOutOfMemoryClass = class of EOutOfMemory;
  EInOutErrorClass = class of EInOutError;
  EExternalClass = class of EExternal;
  EExternalExceptionClass = class of EExternalException;
  EIntErrorClass = class of EIntError;
  EDivByZeroClass = class of EDivByZero;
  ERangeErrorClass = class of ERangeError;
  EIntOverflowClass = class of EIntOverflow;
  EMathErrorClass = class of EMathError;
  EInvalidOpClass = class of EInvalidOp;
  EZeroDivideClass = class of EZeroDivide;
  EOverflowClass = class of EOverflow;
  EUnderflowClass = class of EUnderflow;
  EInvalidPointerClass = class of EInvalidPointer;
  EInvalidCastClass = class of EInvalidCast;
  EConvertErrorClass = class of EConvertError;
  EAccessViolationClass = class of EAccessViolation;
  EPrivilegeClass = class of EPrivilege;
  EStackOverflowClass = class of EStackOverflow;
  EControlCClass = class of EControlC;
  EVariantErrorClass = class of EVariantError;
  EPropReadOnlyClass = class of EPropReadOnly;
  EPropWriteOnlyClass = class of EPropWriteOnly;
  EAssertionFailedClass = class of EAssertionFailed;
  EAbstractErrorClass = class of EAbstractError;
  EIntfCastErrorClass = class of EIntfCastError;
  EInvalidContainerClass = class of EInvalidContainer;
  EInvalidInsertClass = class of EInvalidInsert;
  EPackageErrorClass = class of EPackageError;
  EOSErrorClass = class of EOSError;
  EWin32ErrorClass = class of EWin32Error;
  ESafecallExceptionClass = class of ESafecallException;
  TSimpleRWSyncClass = class of TSimpleRWSync;
  TThreadLocalCounterClass = class of TThreadLocalCounter;
  TMultiReadExclusiveWriteSynchronizerClass = class of TMultiReadExclusiveWriteSynchronizer;
  TMREWSyncClass = class of TMREWSync;


  WordRecWrapper = class(TatRecordWrapper)
  private
    FLo: Byte;
    FHi: Byte;
  public
    constructor Create(ARecord: WordRec);
    function ObjToRec: WordRec;
  published
    property Lo: Byte read FLo write FLo;
    property Hi: Byte read FHi write FHi;
  end;
  
  LongRecWrapper = class(TatRecordWrapper)
  private
    FLo: Word;
    FHi: Word;
  public
    constructor Create(ARecord: LongRec);
    function ObjToRec: LongRec;
  published
    property Lo: Word read FLo write FLo;
    property Hi: Word read FHi write FHi;
  end;
  
  Int64RecWrapper = class(TatRecordWrapper)
  private
    FLo: Cardinal;
    FHi: Cardinal;
  public
    constructor Create(ARecord: Int64Rec);
    function ObjToRec: Int64Rec;
  published
    property Lo: Cardinal read FLo write FLo;
    property Hi: Cardinal read FHi write FHi;
  end;
  
  TSearchRecWrapper = class(TatRecordWrapper)
  private
    FTime: Integer;
    FSize: Int64;
    FAttr: Integer;
    FName: TFileName;
    FExcludeAttr: Integer;
    FFindHandle: THandle;
  public
    constructor Create(ARecord: TSearchRec);
    function ObjToRec: TSearchRec;
  published
    property Time: Integer read FTime write FTime;
    property Size: Int64 read FSize write FSize;
    property Attr: Integer read FAttr write FAttr;
    property Name: TFileName read FName write FName;
    property ExcludeAttr: Integer read FExcludeAttr write FExcludeAttr;
    property FindHandle: THandle read FFindHandle write FFindHandle;
  end;
  
  TFloatRecWrapper = class(TatRecordWrapper)
  private
    FExponent: Smallint;
    FNegative: Boolean;
  public
    constructor Create(ARecord: TFloatRec);
    function ObjToRec: TFloatRec;
  published
    property Exponent: Smallint read FExponent write FExponent;
    property Negative: Boolean read FNegative write FNegative;
  end;
  
  TTimeStampWrapper = class(TatRecordWrapper)
  private
    FTime: Integer;
    FDate: Integer;
  public
    constructor Create(ARecord: TTimeStamp);
    function ObjToRec: TTimeStamp;
  published
    property Time: Integer read FTime write FTime;
    property Date: Integer read FDate write FDate;
  end;
  
  TSysLocaleWrapper = class(TatRecordWrapper)
  private
    FDefaultLCID: Integer;
    FPriLangID: Integer;
    FSubLangID: Integer;
    FFarEast: Boolean;
    FMiddleEast: Boolean;
  public
    constructor Create(ARecord: TSysLocale);
    function ObjToRec: TSysLocale;
  published
    property DefaultLCID: Integer read FDefaultLCID write FDefaultLCID;
    property PriLangID: Integer read FPriLangID write FPriLangID;
    property SubLangID: Integer read FSubLangID write FSubLangID;
    property FarEast: Boolean read FFarEast write FFarEast;
    property MiddleEast: Boolean read FMiddleEast write FMiddleEast;
  end;
  
  TLangRecWrapper = class(TatRecordWrapper)
  private
    FFName: string;
    FFLCID: LCID;
    FFExt: string;
  public
    constructor Create(ARecord: TLangRec);
    function ObjToRec: TLangRec;
  published
    property FName: string read FFName write FFName;
    property FLCID: LCID read FFLCID write FFLCID;
    property FExt: string read FFExt write FFExt;
  end;
  
  TExceptionRecordWrapper = class(TatRecordWrapper)
  private
    FExceptionCode: Cardinal;
    FExceptionFlags: Cardinal;
    FNumberParameters: Cardinal;
  public
    constructor Create(ARecord: TExceptionRecord);
    function ObjToRec: TExceptionRecord;
  published
    property ExceptionCode: Cardinal read FExceptionCode write FExceptionCode;
    property ExceptionFlags: Cardinal read FExceptionFlags write FExceptionFlags;
    property NumberParameters: Cardinal read FNumberParameters write FNumberParameters;
  end;
  
  TFormatSettingsWrapper = class(TatRecordWrapper)
  private
    FCurrencyFormat: Byte;
    FNegCurrFormat: Byte;
    FThousandSeparator: Char;
    FDecimalSeparator: Char;
    FCurrencyDecimals: Byte;
    FDateSeparator: Char;
    FTimeSeparator: Char;
    FListSeparator: Char;
    FCurrencyString: string;
    FShortDateFormat: string;
    FLongDateFormat: string;
    FTimeAMString: string;
    FTimePMString: string;
    FShortTimeFormat: string;
    FLongTimeFormat: string;
    FTwoDigitYearCenturyWindow: Word;
  public
    constructor Create(ARecord: TFormatSettings);
    function ObjToRec: TFormatSettings;
  published
    property CurrencyFormat: Byte read FCurrencyFormat write FCurrencyFormat;
    property NegCurrFormat: Byte read FNegCurrFormat write FNegCurrFormat;
    property ThousandSeparator: Char read FThousandSeparator write FThousandSeparator;
    property DecimalSeparator: Char read FDecimalSeparator write FDecimalSeparator;
    property CurrencyDecimals: Byte read FCurrencyDecimals write FCurrencyDecimals;
    property DateSeparator: Char read FDateSeparator write FDateSeparator;
    property TimeSeparator: Char read FTimeSeparator write FTimeSeparator;
    property ListSeparator: Char read FListSeparator write FListSeparator;
    property CurrencyString: string read FCurrencyString write FCurrencyString;
    property ShortDateFormat: string read FShortDateFormat write FShortDateFormat;
    property LongDateFormat: string read FLongDateFormat write FLongDateFormat;
    property TimeAMString: string read FTimeAMString write FTimeAMString;
    property TimePMString: string read FTimePMString write FTimePMString;
    property ShortTimeFormat: string read FShortTimeFormat write FShortTimeFormat;
    property LongTimeFormat: string read FLongTimeFormat write FLongTimeFormat;
    property TwoDigitYearCenturyWindow: Word read FTwoDigitYearCenturyWindow write FTwoDigitYearCenturyWindow;
  end;
  
  TThreadInfoWrapper = class(TatRecordWrapper)
  private
    FThreadID: Cardinal;
    FActive: Integer;
    FRecursionCount: Cardinal;
  public
    constructor Create(ARecord: TThreadInfo);
    function ObjToRec: TThreadInfo;
  published
    property ThreadID: Cardinal read FThreadID write FThreadID;
    property Active: Integer read FActive write FActive;
    property RecursionCount: Cardinal read FRecursionCount write FRecursionCount;
  end;
  

implementation

constructor WordRecWrapper.Create(ARecord: WordRec);
begin
  inherited Create;
  FLo := ARecord.Lo;
  FHi := ARecord.Hi;
end;

function WordRecWrapper.ObjToRec: WordRec;
begin
  result.Lo := FLo;
  result.Hi := FHi;
end;

constructor LongRecWrapper.Create(ARecord: LongRec);
begin
  inherited Create;
  FLo := ARecord.Lo;
  FHi := ARecord.Hi;
end;

function LongRecWrapper.ObjToRec: LongRec;
begin
  result.Lo := FLo;
  result.Hi := FHi;
end;

constructor Int64RecWrapper.Create(ARecord: Int64Rec);
begin
  inherited Create;
  FLo := ARecord.Lo;
  FHi := ARecord.Hi;
end;

function Int64RecWrapper.ObjToRec: Int64Rec;
begin
  result.Lo := FLo;
  result.Hi := FHi;
end;

constructor TSearchRecWrapper.Create(ARecord: TSearchRec);
begin
  inherited Create;
  FTime := ARecord.Time;
  FSize := ARecord.Size;
  FAttr := ARecord.Attr;
  FName := ARecord.Name;
  FExcludeAttr := ARecord.ExcludeAttr;
  FFindHandle := ARecord.FindHandle;
end;

function TSearchRecWrapper.ObjToRec: TSearchRec;
begin
  result.Time := FTime;
  result.Size := FSize;
  result.Attr := FAttr;
  result.Name := FName;
  result.ExcludeAttr := FExcludeAttr;
  result.FindHandle := FFindHandle;
end;

constructor TFloatRecWrapper.Create(ARecord: TFloatRec);
begin
  inherited Create;
  FExponent := ARecord.Exponent;
  FNegative := ARecord.Negative;
end;

function TFloatRecWrapper.ObjToRec: TFloatRec;
begin
  result.Exponent := FExponent;
  result.Negative := FNegative;
end;

constructor TTimeStampWrapper.Create(ARecord: TTimeStamp);
begin
  inherited Create;
  FTime := ARecord.Time;
  FDate := ARecord.Date;
end;

function TTimeStampWrapper.ObjToRec: TTimeStamp;
begin
  result.Time := FTime;
  result.Date := FDate;
end;

constructor TSysLocaleWrapper.Create(ARecord: TSysLocale);
begin
  inherited Create;
  FDefaultLCID := ARecord.DefaultLCID;
  FPriLangID := ARecord.PriLangID;
  FSubLangID := ARecord.SubLangID;
  FFarEast := ARecord.FarEast;
  FMiddleEast := ARecord.MiddleEast;
end;

function TSysLocaleWrapper.ObjToRec: TSysLocale;
begin
  result.DefaultLCID := FDefaultLCID;
  result.PriLangID := FPriLangID;
  result.SubLangID := FSubLangID;
  result.FarEast := FFarEast;
  result.MiddleEast := FMiddleEast;
end;

constructor TLangRecWrapper.Create(ARecord: TLangRec);
begin
  inherited Create;
  FFName := ARecord.FName;
  FFLCID := ARecord.FLCID;
  FFExt := ARecord.FExt;
end;

function TLangRecWrapper.ObjToRec: TLangRec;
begin
  result.FName := FFName;
  result.FLCID := FFLCID;
  result.FExt := FFExt;
end;

constructor TExceptionRecordWrapper.Create(ARecord: TExceptionRecord);
begin
  inherited Create;
  FExceptionCode := ARecord.ExceptionCode;
  FExceptionFlags := ARecord.ExceptionFlags;
  FNumberParameters := ARecord.NumberParameters;
end;

function TExceptionRecordWrapper.ObjToRec: TExceptionRecord;
begin
  result.ExceptionCode := FExceptionCode;
  result.ExceptionFlags := FExceptionFlags;
  result.NumberParameters := FNumberParameters;
end;

constructor TFormatSettingsWrapper.Create(ARecord: TFormatSettings);
begin
  inherited Create;
  FCurrencyFormat := ARecord.CurrencyFormat;
  FNegCurrFormat := ARecord.NegCurrFormat;
  FThousandSeparator := ARecord.ThousandSeparator;
  FDecimalSeparator := ARecord.DecimalSeparator;
  FCurrencyDecimals := ARecord.CurrencyDecimals;
  FDateSeparator := ARecord.DateSeparator;
  FTimeSeparator := ARecord.TimeSeparator;
  FListSeparator := ARecord.ListSeparator;
  FCurrencyString := ARecord.CurrencyString;
  FShortDateFormat := ARecord.ShortDateFormat;
  FLongDateFormat := ARecord.LongDateFormat;
  FTimeAMString := ARecord.TimeAMString;
  FTimePMString := ARecord.TimePMString;
  FShortTimeFormat := ARecord.ShortTimeFormat;
  FLongTimeFormat := ARecord.LongTimeFormat;
  FTwoDigitYearCenturyWindow := ARecord.TwoDigitYearCenturyWindow;
end;

function TFormatSettingsWrapper.ObjToRec: TFormatSettings;
begin
  result.CurrencyFormat := FCurrencyFormat;
  result.NegCurrFormat := FNegCurrFormat;
  result.ThousandSeparator := FThousandSeparator;
  result.DecimalSeparator := FDecimalSeparator;
  result.CurrencyDecimals := FCurrencyDecimals;
  result.DateSeparator := FDateSeparator;
  result.TimeSeparator := FTimeSeparator;
  result.ListSeparator := FListSeparator;
  result.CurrencyString := FCurrencyString;
  result.ShortDateFormat := FShortDateFormat;
  result.LongDateFormat := FLongDateFormat;
  result.TimeAMString := FTimeAMString;
  result.TimePMString := FTimePMString;
  result.ShortTimeFormat := FShortTimeFormat;
  result.LongTimeFormat := FLongTimeFormat;
  result.TwoDigitYearCenturyWindow := FTwoDigitYearCenturyWindow;
end;

constructor TThreadInfoWrapper.Create(ARecord: TThreadInfo);
begin
  inherited Create;
  FThreadID := ARecord.ThreadID;
  FActive := ARecord.Active;
  FRecursionCount := ARecord.RecursionCount;
end;

function TThreadInfoWrapper.ObjToRec: TThreadInfo;
begin
  result.ThreadID := FThreadID;
  result.Active := FActive;
  result.RecursionCount := FRecursionCount;
end;



procedure TatSysUtilsLibrary.__TLanguagesCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TLanguagesClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__TLanguagesIndexOf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TLanguages(CurrentObject).IndexOf(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__GetTLanguagesCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TLanguages(CurrentObject).Count));
  end;
end;

procedure TatSysUtilsLibrary.__GetTLanguagesName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TLanguages(CurrentObject).Name[VarToInteger(GetArrayIndex(0))]);
  end;
end;

procedure TatSysUtilsLibrary.__GetTLanguagesNameFromLocaleID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TLanguages(CurrentObject).NameFromLocaleID[VarToInteger(GetArrayIndex(0))]);
  end;
end;

procedure TatSysUtilsLibrary.__GetTLanguagesNameFromLCID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TLanguages(CurrentObject).NameFromLCID[GetArrayIndex(0)]);
  end;
end;

procedure TatSysUtilsLibrary.__GetTLanguagesID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TLanguages(CurrentObject).ID[VarToInteger(GetArrayIndex(0))]);
  end;
end;

procedure TatSysUtilsLibrary.__GetTLanguagesLocaleID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TLanguages(CurrentObject).LocaleID[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatSysUtilsLibrary.__GetTLanguagesExt(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TLanguages(CurrentObject).Ext[VarToInteger(GetArrayIndex(0))]);
  end;
end;

procedure TatSysUtilsLibrary.__ExceptionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ExceptionClass(CurrentClass.ClassRef).Create(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__ExceptionCreateRes(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ExceptionClass(CurrentClass.ClassRef).CreateRes(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__ExceptionCreateHelp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ExceptionClass(CurrentClass.ClassRef).CreateHelp(GetInputArg(0),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__ExceptionCreateResHelp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ExceptionClass(CurrentClass.ClassRef).CreateResHelp(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__GetExceptionHelpContext(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(Exception(CurrentObject).HelpContext));
  end;
end;

procedure TatSysUtilsLibrary.__SetExceptionHelpContext(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Exception(CurrentObject).HelpContext:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatSysUtilsLibrary.__GetExceptionMessage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Exception(CurrentObject).Message);
  end;
end;

procedure TatSysUtilsLibrary.__SetExceptionMessage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Exception(CurrentObject).Message:=GetInputArg(0);
  end;
end;

procedure TatSysUtilsLibrary.__EHeapExceptionFreeInstance(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    EHeapException(CurrentObject).FreeInstance;
  end;
end;

procedure TatSysUtilsLibrary.__TSimpleRWSyncCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSimpleRWSyncClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__TSimpleRWSyncDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSimpleRWSync(CurrentObject).Destroy;
  end;
end;

procedure TatSysUtilsLibrary.__TSimpleRWSyncBeginRead(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSimpleRWSync(CurrentObject).BeginRead;
  end;
end;

procedure TatSysUtilsLibrary.__TSimpleRWSyncEndRead(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSimpleRWSync(CurrentObject).EndRead;
  end;
end;

procedure TatSysUtilsLibrary.__TSimpleRWSyncBeginWrite(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TSimpleRWSync(CurrentObject).BeginWrite;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__TSimpleRWSyncEndWrite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSimpleRWSync(CurrentObject).EndWrite;
  end;
end;

procedure TatSysUtilsLibrary.__TThreadLocalCounterDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TThreadLocalCounter(CurrentObject).Destroy;
  end;
end;

procedure TatSysUtilsLibrary.__TMultiReadExclusiveWriteSynchronizerCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TMultiReadExclusiveWriteSynchronizerClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__TMultiReadExclusiveWriteSynchronizerDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMultiReadExclusiveWriteSynchronizer(CurrentObject).Destroy;
  end;
end;

procedure TatSysUtilsLibrary.__TMultiReadExclusiveWriteSynchronizerBeginRead(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMultiReadExclusiveWriteSynchronizer(CurrentObject).BeginRead;
  end;
end;

procedure TatSysUtilsLibrary.__TMultiReadExclusiveWriteSynchronizerEndRead(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMultiReadExclusiveWriteSynchronizer(CurrentObject).EndRead;
  end;
end;

procedure TatSysUtilsLibrary.__TMultiReadExclusiveWriteSynchronizerBeginWrite(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TMultiReadExclusiveWriteSynchronizer(CurrentObject).BeginWrite;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__TMultiReadExclusiveWriteSynchronizerEndWrite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMultiReadExclusiveWriteSynchronizer(CurrentObject).EndWrite;
  end;
end;

procedure TatSysUtilsLibrary.__GetTMultiReadExclusiveWriteSynchronizerRevisionLevel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMultiReadExclusiveWriteSynchronizer(CurrentObject).RevisionLevel));
  end;
end;

procedure TatSysUtilsLibrary.__CheckWin32Version(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := SysUtils.CheckWin32Version(VarToInteger(GetInputArg(0)));
2: AResult := SysUtils.CheckWin32Version(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__GetFileVersion(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.GetFileVersion(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__Languages(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.Languages);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__AppendStr(AMachine: TatVirtualMachine);
  var
  Param0: string;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    SysUtils.AppendStr(Param0,GetInputArg(1));
    SetInputArg(0,Param0);
  end;
end;

procedure TatSysUtilsLibrary.__UpperCase(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.UpperCase(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__LowerCase(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.LowerCase(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__CompareStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.CompareStr(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__SameStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.SameStr(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__CompareText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.CompareText(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__SameText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.SameText(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__AnsiUpperCase(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.AnsiUpperCase(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__AnsiLowerCase(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.AnsiLowerCase(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__AnsiCompareStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.AnsiCompareStr(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__AnsiSameStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.AnsiSameStr(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__AnsiCompareText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.AnsiCompareText(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__AnsiSameText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.AnsiSameText(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__AnsiStrComp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.AnsiStrComp(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__AnsiStrIComp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.AnsiStrIComp(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__AnsiStrLComp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.AnsiStrLComp(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__AnsiStrLIComp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.AnsiStrLIComp(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__AnsiStrLower(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(SysUtils.AnsiStrLower(PChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__AnsiStrUpper(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(SysUtils.AnsiStrUpper(PChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__AnsiLastChar(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(SysUtils.AnsiLastChar(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__AnsiStrLastChar(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(SysUtils.AnsiStrLastChar(PChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__WideUpperCase(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.WideUpperCase(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__WideLowerCase(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.WideLowerCase(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__WideCompareStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.WideCompareStr(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__WideSameStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.WideSameStr(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__WideCompareText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.WideCompareText(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__WideSameText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.WideSameText(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__Trim(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.Trim(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__TrimLeft(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.TrimLeft(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__TrimRight(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.TrimRight(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__QuotedStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.QuotedStr(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__AnsiQuotedStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.AnsiQuotedStr(GetInputArg(0),VarToStr(GetInputArg(1))[1]);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__AnsiExtractQuotedStr(AMachine: TatVirtualMachine);
  var
  Param0: PChar;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := PChar(VarToStr(GetInputArg(0)));
AResult := SysUtils.AnsiExtractQuotedStr(Param0,VarToStr(GetInputArg(1))[1]);
    ReturnOutputArg(AResult);
    SetInputArg(0,string(Param0));
  end;
end;

procedure TatSysUtilsLibrary.__AnsiDequotedStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.AnsiDequotedStr(GetInputArg(0),VarToStr(GetInputArg(1))[1]);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__AdjustLineBreaks(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := SysUtils.AdjustLineBreaks(GetInputArg(0));
2: AResult := SysUtils.AdjustLineBreaks(GetInputArg(0),GetInputArg(1));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__IsValidIdent(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := SysUtils.IsValidIdent(GetInputArg(0));
2: AResult := SysUtils.IsValidIdent(GetInputArg(0),GetInputArg(1));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__IntToStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.IntToStr(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__IntToHex(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.IntToHex(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrToInt(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.StrToInt(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrToIntDef(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.StrToIntDef(GetInputArg(0),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__TryStrToInt(AMachine: TatVirtualMachine);
  var
  Param1: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := SysUtils.TryStrToInt(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatSysUtilsLibrary.__StrToInt64(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.StrToInt64(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrToInt64Def(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.StrToInt64Def(GetInputArg(0),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__TryStrToInt64(AMachine: TatVirtualMachine);
  var
  Param1: Int64;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := SysUtils.TryStrToInt64(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatSysUtilsLibrary.__StrToBool(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.StrToBool(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrToBoolDef(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.StrToBoolDef(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__TryStrToBool(AMachine: TatVirtualMachine);
  var
  Param1: Boolean;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := SysUtils.TryStrToBool(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatSysUtilsLibrary.__BoolToStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := SysUtils.BoolToStr(GetInputArg(0));
2: AResult := SysUtils.BoolToStr(GetInputArg(0),GetInputArg(1));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__LoadStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.LoadStr(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__FileOpen(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.FileOpen(GetInputArg(0),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__FileCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.FileCreate(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__FileRead(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(SysUtils.FileRead(VarToInteger(GetInputArg(0)),Param1,VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatSysUtilsLibrary.__FileWrite(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(SysUtils.FileWrite(VarToInteger(GetInputArg(0)),Param1,VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__FileSeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.FileSeek(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__FileClose(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.FileClose(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatSysUtilsLibrary.__FileAge(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.FileAge(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__FileExists(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.FileExists(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__DirectoryExists(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.DirectoryExists(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__ForceDirectories(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.ForceDirectories(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__FindFirst(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TSearchRec;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is TSearchRecWrapper) then 
  Param2Rec := TSearchRecWrapper.Create(Param2);
Param2 := TSearchRecWrapper(Param2Rec).ObjToRec;
AResult := Integer(SysUtils.FindFirst(GetInputArg(0),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(TSearchRecWrapper.Create(Param2)));
  end;
end;

procedure TatSysUtilsLibrary.__FindNext(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TSearchRec;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TSearchRecWrapper) then 
  Param0Rec := TSearchRecWrapper.Create(Param0);
Param0 := TSearchRecWrapper(Param0Rec).ObjToRec;
AResult := Integer(SysUtils.FindNext(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TSearchRecWrapper.Create(Param0)));
  end;
end;

procedure TatSysUtilsLibrary.__FindClose(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TSearchRec;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TSearchRecWrapper) then 
  Param0Rec := TSearchRecWrapper.Create(Param0);
Param0 := TSearchRecWrapper(Param0Rec).ObjToRec;
    SysUtils.FindClose(Param0);
    SetInputArg(0,integer(TSearchRecWrapper.Create(Param0)));
  end;
end;

procedure TatSysUtilsLibrary.__FileGetDate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.FileGetDate(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__FileSetDate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.FileSetDate(GetInputArg(0),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__FileGetAttr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.FileGetAttr(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__FileSetAttr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.FileSetAttr(GetInputArg(0),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__FileIsReadOnly(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.FileIsReadOnly(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__FileSetReadOnly(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.FileSetReadOnly(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__DeleteFile(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.DeleteFile(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__RenameFile(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.RenameFile(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__IsAssembly(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.IsAssembly(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__ChangeFileExt(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.ChangeFileExt(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__ChangeFilePath(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.ChangeFilePath(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__ExtractFilePath(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.ExtractFilePath(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__ExtractFileDir(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.ExtractFileDir(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__ExtractFileDrive(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.ExtractFileDrive(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__ExtractFileName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.ExtractFileName(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__ExtractFileExt(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.ExtractFileExt(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__ExpandFileName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.ExpandFileName(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__ExpandFileNameCase(AMachine: TatVirtualMachine);
  var
  Param1: TFilenameCaseMatch;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := SysUtils.ExpandFileNameCase(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatSysUtilsLibrary.__ExpandUNCFileName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.ExpandUNCFileName(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__ExtractRelativePath(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.ExtractRelativePath(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__ExtractShortPathName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.ExtractShortPathName(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__FileSearch(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.FileSearch(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__DiskFree(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.DiskFree(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__DiskSize(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.DiskSize(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__FileDateToDateTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.FileDateToDateTime(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__DateTimeToFileDate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.DateTimeToFileDate(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__GetCurrentDir(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.GetCurrentDir;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__SetCurrentDir(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.SetCurrentDir(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__CreateDir(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.CreateDir(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__RemoveDir(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.RemoveDir(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrLen(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.StrLen(PChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrEnd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(SysUtils.StrEnd(PChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrMove(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(SysUtils.StrMove(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrCopy(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(SysUtils.StrCopy(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrECopy(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(SysUtils.StrECopy(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrLCopy(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(SysUtils.StrLCopy(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrPCopy(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(SysUtils.StrPCopy(PChar(VarToStr(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrPLCopy(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(SysUtils.StrPLCopy(PChar(VarToStr(GetInputArg(0))),GetInputArg(1),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrCat(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(SysUtils.StrCat(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrLCat(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(SysUtils.StrLCat(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrComp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.StrComp(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrIComp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.StrIComp(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrLComp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.StrLComp(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrLIComp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.StrLIComp(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrScan(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(SysUtils.StrScan(PChar(VarToStr(GetInputArg(0))),VarToStr(GetInputArg(1))[1]));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrRScan(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(SysUtils.StrRScan(PChar(VarToStr(GetInputArg(0))),VarToStr(GetInputArg(1))[1]));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrPos(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(SysUtils.StrPos(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrUpper(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(SysUtils.StrUpper(PChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrLower(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(SysUtils.StrLower(PChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrPas(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.StrPas(PChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrAlloc(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(SysUtils.StrAlloc(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrBufSize(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.StrBufSize(PChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrNew(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(SysUtils.StrNew(PChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrDispose(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.StrDispose(PChar(VarToStr(GetInputArg(0))));
  end;
end;

procedure TatSysUtilsLibrary.__FloatToStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.FloatToStr(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__CurrToStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.CurrToStr(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__FloatToCurr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.FloatToCurr(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__TryFloatToCurr(AMachine: TatVirtualMachine);
  var
  Param1: Currency;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := SysUtils.TryFloatToCurr(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatSysUtilsLibrary.__FloatToStrF(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.FloatToStrF(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__CurrToStrF(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.CurrToStrF(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__FloatToText(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(SysUtils.FloatToText(PChar(VarToStr(GetInputArg(0))),Param1,GetInputArg(2),GetInputArg(3),VarToInteger(GetInputArg(4)),VarToInteger(GetInputArg(5))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__FormatFloat(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.FormatFloat(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__FormatCurr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.FormatCurr(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__FloatToTextFmt(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(SysUtils.FloatToTextFmt(PChar(VarToStr(GetInputArg(0))),Param1,GetInputArg(2),PChar(VarToStr(GetInputArg(3)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrToFloat(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.StrToFloat(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrToFloatDef(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.StrToFloatDef(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__TryStrToFloat(AMachine: TatVirtualMachine);
  var
  Param1: Extended;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := SysUtils.TryStrToFloat(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatSysUtilsLibrary.__StrToCurr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.StrToCurr(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrToCurrDef(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.StrToCurrDef(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__TryStrToCurr(AMachine: TatVirtualMachine);
  var
  Param1: Currency;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := SysUtils.TryStrToCurr(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatSysUtilsLibrary.__TextToFloat(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := SysUtils.TextToFloat(PChar(VarToStr(GetInputArg(0))),Param1,GetInputArg(2));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatSysUtilsLibrary.__FloatToDecimal(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TFloatRec;
  Param1: Variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TFloatRecWrapper) then 
  Param0Rec := TFloatRecWrapper.Create(Param0);
Param0 := TFloatRecWrapper(Param0Rec).ObjToRec;
Param1 := GetInputArg(1);
    SysUtils.FloatToDecimal(Param0,Param1,GetInputArg(2),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)));
    SetInputArg(0,integer(TFloatRecWrapper.Create(Param0)));
  end;
end;

procedure TatSysUtilsLibrary.__DateTimeToTimeStamp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TTimeStampWrapper.Create(SysUtils.DateTimeToTimeStamp(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__TimeStampToDateTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.TimeStampToDateTime(TTimeStampWrapper(integer(GetInputArg(0))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__MSecsToTimeStamp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TTimeStampWrapper.Create(SysUtils.MSecsToTimeStamp(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__TimeStampToMSecs(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.TimeStampToMSecs(TTimeStampWrapper(integer(GetInputArg(0))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__EncodeDate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.EncodeDate(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__EncodeTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.EncodeTime(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__TryEncodeDate(AMachine: TatVirtualMachine);
  var
  Param3: TDateTime;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
AResult := SysUtils.TryEncodeDate(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3);
    ReturnOutputArg(AResult);
    SetInputArg(3,Param3);
  end;
end;

procedure TatSysUtilsLibrary.__TryEncodeTime(AMachine: TatVirtualMachine);
  var
  Param4: TDateTime;
  AResult: variant;
begin
  with AMachine do
  begin
Param4 := GetInputArg(4);
AResult := SysUtils.TryEncodeTime(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),Param4);
    ReturnOutputArg(AResult);
    SetInputArg(4,Param4);
  end;
end;

procedure TatSysUtilsLibrary.__DecodeDate(AMachine: TatVirtualMachine);
  var
  Param1: Word;
  Param2: Word;
  Param3: Word;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
Param2 := VarToInteger(GetInputArg(2));
Param3 := VarToInteger(GetInputArg(3));
    SysUtils.DecodeDate(GetInputArg(0),Param1,Param2,Param3);
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Integer(Param2));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatSysUtilsLibrary.__DecodeDateFully(AMachine: TatVirtualMachine);
  var
  Param1: Word;
  Param2: Word;
  Param3: Word;
  Param4: Word;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
Param2 := VarToInteger(GetInputArg(2));
Param3 := VarToInteger(GetInputArg(3));
Param4 := VarToInteger(GetInputArg(4));
AResult := SysUtils.DecodeDateFully(GetInputArg(0),Param1,Param2,Param3,Param4);
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Integer(Param2));
    SetInputArg(3,Integer(Param3));
    SetInputArg(4,Integer(Param4));
  end;
end;

procedure TatSysUtilsLibrary.__DecodeTime(AMachine: TatVirtualMachine);
  var
  Param1: Word;
  Param2: Word;
  Param3: Word;
  Param4: Word;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
Param2 := VarToInteger(GetInputArg(2));
Param3 := VarToInteger(GetInputArg(3));
Param4 := VarToInteger(GetInputArg(4));
    SysUtils.DecodeTime(GetInputArg(0),Param1,Param2,Param3,Param4);
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Integer(Param2));
    SetInputArg(3,Integer(Param3));
    SetInputArg(4,Integer(Param4));
  end;
end;

procedure TatSysUtilsLibrary.__DateTimeToSystemTime(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TSystemTime;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is _SYSTEMTIMEWrapper) then 
  Param1Rec := _SYSTEMTIMEWrapper.Create(Param1);
Param1 := _SYSTEMTIMEWrapper(Param1Rec).ObjToRec;
    SysUtils.DateTimeToSystemTime(GetInputArg(0),Param1);
    SetInputArg(1,integer(_SYSTEMTIMEWrapper.Create(Param1)));
  end;
end;

procedure TatSysUtilsLibrary.__SystemTimeToDateTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.SystemTimeToDateTime(_SYSTEMTIMEWrapper(integer(GetInputArg(0))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__DayOfWeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.DayOfWeek(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__Date(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.Date;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__Time(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.Time;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__GetTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.GetTime;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__Now(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.Now;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__CurrentYear(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.CurrentYear);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__IncMonth(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := SysUtils.IncMonth(GetInputArg(0));
2: AResult := SysUtils.IncMonth(GetInputArg(0),VarToInteger(GetInputArg(1)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__IncAMonth(AMachine: TatVirtualMachine);
  var
  Param0: Word;
  Param1: Word;
  Param2: Word;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
Param1 := VarToInteger(GetInputArg(1));
Param2 := VarToInteger(GetInputArg(2));
    Case InputArgCount of
      3: SysUtils.IncAMonth(Param0,Param1,Param2);
      4: SysUtils.IncAMonth(Param0,Param1,Param2,VarToInteger(GetInputArg(3)));
    end;
    SetInputArg(0,Integer(Param0));
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatSysUtilsLibrary.__ReplaceTime(AMachine: TatVirtualMachine);
  var
  Param0: TDateTime;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    SysUtils.ReplaceTime(Param0,GetInputArg(1));
    SetInputArg(0,Param0);
  end;
end;

procedure TatSysUtilsLibrary.__ReplaceDate(AMachine: TatVirtualMachine);
  var
  Param0: TDateTime;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    SysUtils.ReplaceDate(Param0,GetInputArg(1));
    SetInputArg(0,Param0);
  end;
end;

procedure TatSysUtilsLibrary.__IsLeapYear(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.IsLeapYear(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__DateToStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.DateToStr(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__TimeToStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.TimeToStr(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__DateTimeToStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.DateTimeToStr(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrToDate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.StrToDate(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrToDateDef(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.StrToDateDef(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__TryStrToDate(AMachine: TatVirtualMachine);
  var
  Param1: TDateTime;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := SysUtils.TryStrToDate(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatSysUtilsLibrary.__StrToTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.StrToTime(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrToTimeDef(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.StrToTimeDef(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__TryStrToTime(AMachine: TatVirtualMachine);
  var
  Param1: TDateTime;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := SysUtils.TryStrToTime(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatSysUtilsLibrary.__StrToDateTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.StrToDateTime(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrToDateTimeDef(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.StrToDateTimeDef(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__TryStrToDateTime(AMachine: TatVirtualMachine);
  var
  Param1: TDateTime;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := SysUtils.TryStrToDateTime(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatSysUtilsLibrary.__FormatDateTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.FormatDateTime(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__DateTimeToString(AMachine: TatVirtualMachine);
  var
  Param0: string;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    SysUtils.DateTimeToString(Param0,GetInputArg(1),GetInputArg(2));
    SetInputArg(0,Param0);
  end;
end;

procedure TatSysUtilsLibrary.__FloatToDateTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.FloatToDateTime(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__TryFloatToDateTime(AMachine: TatVirtualMachine);
  var
  Param1: TDateTime;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := SysUtils.TryFloatToDateTime(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatSysUtilsLibrary.__SysErrorMessage(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.SysErrorMessage(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__GetLocaleStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.GetLocaleStr(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__GetLocaleChar(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.GetLocaleChar(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToStr(GetInputArg(2))[1]);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__GetFormatSettings(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.GetFormatSettings;
  end;
end;

procedure TatSysUtilsLibrary.__GetLocaleFormatSettings(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TFormatSettings;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TFormatSettingsWrapper) then 
  Param1Rec := TFormatSettingsWrapper.Create(Param1);
Param1 := TFormatSettingsWrapper(Param1Rec).ObjToRec;
    SysUtils.GetLocaleFormatSettings(VarToInteger(GetInputArg(0)),Param1);
    SetInputArg(1,integer(TFormatSettingsWrapper.Create(Param1)));
  end;
end;

procedure TatSysUtilsLibrary.__Sleep(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.Sleep(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatSysUtilsLibrary.__GetModuleName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.GetModuleName(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__Abort(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.Abort;
  end;
end;

procedure TatSysUtilsLibrary.__OutOfMemoryError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.OutOfMemoryError;
  end;
end;

procedure TatSysUtilsLibrary.__Beep(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.Beep;
  end;
end;

procedure TatSysUtilsLibrary.__ByteType(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.ByteType(GetInputArg(0),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrByteType(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.StrByteType(PChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__ByteToCharLen(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.ByteToCharLen(GetInputArg(0),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__CharToByteLen(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.CharToByteLen(GetInputArg(0),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__ByteToCharIndex(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.ByteToCharIndex(GetInputArg(0),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__CharToByteIndex(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.CharToByteIndex(GetInputArg(0),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrCharLength(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.StrCharLength(PChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StrNextChar(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(SysUtils.StrNextChar(PChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__CharLength(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.CharLength(GetInputArg(0),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__NextCharIndex(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.NextCharIndex(GetInputArg(0),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__IsPathDelimiter(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.IsPathDelimiter(GetInputArg(0),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__IsDelimiter(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.IsDelimiter(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__IncludeTrailingPathDelimiter(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.IncludeTrailingPathDelimiter(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__IncludeTrailingBackslash(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.IncludeTrailingBackslash(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__ExcludeTrailingPathDelimiter(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.ExcludeTrailingPathDelimiter(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__ExcludeTrailingBackslash(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.ExcludeTrailingBackslash(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__LastDelimiter(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.LastDelimiter(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__AnsiCompareFileName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.AnsiCompareFileName(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__SameFileName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.SameFileName(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__AnsiLowerCaseFileName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.AnsiLowerCaseFileName(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__AnsiUpperCaseFileName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.AnsiUpperCaseFileName(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__AnsiPos(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.AnsiPos(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__AnsiStrPos(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(SysUtils.AnsiStrPos(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__AnsiStrRScan(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(SysUtils.AnsiStrRScan(PChar(VarToStr(GetInputArg(0))),VarToStr(GetInputArg(1))[1]));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__AnsiStrScan(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(SysUtils.AnsiStrScan(PChar(VarToStr(GetInputArg(0))),VarToStr(GetInputArg(1))[1]));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__StringReplace(AMachine: TatVirtualMachine);
  var
  Param3: TReplaceFlags;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param3, VarToInteger(GetInputArg(3)), SizeOf(Param3));
AResult := SysUtils.StringReplace(GetInputArg(0),GetInputArg(1),GetInputArg(2),Param3);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__WrapText(AMachine: TatVirtualMachine);
  var
  Param2: TSysCharSet;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param2, VarToInteger(GetInputArg(2)), SizeOf(Param2));
AResult := SysUtils.WrapText(GetInputArg(0),GetInputArg(1),Param2,VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__FindCmdLineSwitch(AMachine: TatVirtualMachine);
  var
  Param1: TSysCharSet;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param1, VarToInteger(GetInputArg(1)), SizeOf(Param1));
AResult := SysUtils.FindCmdLineSwitch(GetInputArg(0),Param1,GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__FreeAndNil(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    SysUtils.FreeAndNil(Param0);
    SetInputArg(0,Param0);
  end;
end;

procedure TatSysUtilsLibrary.__Supports(AMachine: TatVirtualMachine);
  var
  Param2: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
AResult := SysUtils.Supports(TObject(Integer(GetInputArg(0))),TGUIDWrapper(integer(GetInputArg(1))).ObjToRec,Param2);
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
  end;
end;

procedure TatSysUtilsLibrary.__CreateGUID(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TGUID;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TGUIDWrapper) then 
  Param0Rec := TGUIDWrapper.Create(Param0);
Param0 := TGUIDWrapper(Param0Rec).ObjToRec;
AResult := Integer(SysUtils.CreateGUID(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TGUIDWrapper.Create(Param0)));
  end;
end;

procedure TatSysUtilsLibrary.__StringToGUID(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TGUIDWrapper.Create(SysUtils.StringToGUID(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__GUIDToString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.GUIDToString(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__IsEqualGUID(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.IsEqualGUID(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,TGUIDWrapper(integer(GetInputArg(1))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__LoadPackage(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.LoadPackage(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__UnloadPackage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.UnloadPackage(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatSysUtilsLibrary.__GetPackageDescription(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.GetPackageDescription(PChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__InitializePackage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.InitializePackage(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatSysUtilsLibrary.__FinalizePackage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.FinalizePackage(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatSysUtilsLibrary.__RaiseLastOSError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.RaiseLastOSError;
  end;
end;

procedure TatSysUtilsLibrary.__RaiseLastWin32Error(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.RaiseLastWin32Error;
  end;
end;

procedure TatSysUtilsLibrary.__Win32Check(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.Win32Check(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__CallTerminateProcs(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.CallTerminateProcs;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__GDAL(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(SysUtils.GDAL);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__RCS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.RCS;
  end;
end;

procedure TatSysUtilsLibrary.__RPR(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.RPR;
  end;
end;

procedure TatSysUtilsLibrary.__SafeLoadLibrary(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := Integer(SysUtils.SafeLoadLibrary(GetInputArg(0)));
2: AResult := Integer(SysUtils.SafeLoadLibrary(GetInputArg(0),VarToInteger(GetInputArg(1))));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__GetEnvironmentVariable(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SysUtils.GetEnvironmentVariable(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSysUtilsLibrary.__GetEmptyStr(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(SysUtils.EmptyStr);
  end;
end;

procedure TatSysUtilsLibrary.__SetEmptyStr(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.EmptyStr:=GetInputArg(0);
  end;
end;

procedure TatSysUtilsLibrary.__GetEmptyWideStr(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(SysUtils.EmptyWideStr);
  end;
end;

procedure TatSysUtilsLibrary.__SetEmptyWideStr(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.EmptyWideStr:=GetInputArg(0);
  end;
end;

procedure TatSysUtilsLibrary.__GetWin32Platform(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(SysUtils.Win32Platform));
  end;
end;

procedure TatSysUtilsLibrary.__SetWin32Platform(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.Win32Platform:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatSysUtilsLibrary.__GetWin32MajorVersion(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(SysUtils.Win32MajorVersion));
  end;
end;

procedure TatSysUtilsLibrary.__SetWin32MajorVersion(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.Win32MajorVersion:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatSysUtilsLibrary.__GetWin32MinorVersion(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(SysUtils.Win32MinorVersion));
  end;
end;

procedure TatSysUtilsLibrary.__SetWin32MinorVersion(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.Win32MinorVersion:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatSysUtilsLibrary.__GetWin32BuildNumber(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(SysUtils.Win32BuildNumber));
  end;
end;

procedure TatSysUtilsLibrary.__SetWin32BuildNumber(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.Win32BuildNumber:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatSysUtilsLibrary.__GetWin32CSDVersion(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(SysUtils.Win32CSDVersion);
  end;
end;

procedure TatSysUtilsLibrary.__SetWin32CSDVersion(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.Win32CSDVersion:=GetInputArg(0);
  end;
end;

procedure TatSysUtilsLibrary.__GetCurrencyString(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(SysUtils.CurrencyString);
  end;
end;

procedure TatSysUtilsLibrary.__SetCurrencyString(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.CurrencyString:=GetInputArg(0);
  end;
end;

procedure TatSysUtilsLibrary.__GetCurrencyFormat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(SysUtils.CurrencyFormat));
  end;
end;

procedure TatSysUtilsLibrary.__SetCurrencyFormat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.CurrencyFormat:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatSysUtilsLibrary.__GetNegCurrFormat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(SysUtils.NegCurrFormat));
  end;
end;

procedure TatSysUtilsLibrary.__SetNegCurrFormat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.NegCurrFormat:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatSysUtilsLibrary.__GetThousandSeparator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(SysUtils.ThousandSeparator);
  end;
end;

procedure TatSysUtilsLibrary.__SetThousandSeparator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.ThousandSeparator:=VarToStr(GetInputArg(0))[1];
  end;
end;

procedure TatSysUtilsLibrary.__GetDecimalSeparator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(SysUtils.DecimalSeparator);
  end;
end;

procedure TatSysUtilsLibrary.__SetDecimalSeparator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.DecimalSeparator:=VarToStr(GetInputArg(0))[1];
  end;
end;

procedure TatSysUtilsLibrary.__GetCurrencyDecimals(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(SysUtils.CurrencyDecimals));
  end;
end;

procedure TatSysUtilsLibrary.__SetCurrencyDecimals(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.CurrencyDecimals:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatSysUtilsLibrary.__GetDateSeparator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(SysUtils.DateSeparator);
  end;
end;

procedure TatSysUtilsLibrary.__SetDateSeparator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.DateSeparator:=VarToStr(GetInputArg(0))[1];
  end;
end;

procedure TatSysUtilsLibrary.__GetShortDateFormat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(SysUtils.ShortDateFormat);
  end;
end;

procedure TatSysUtilsLibrary.__SetShortDateFormat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.ShortDateFormat:=GetInputArg(0);
  end;
end;

procedure TatSysUtilsLibrary.__GetLongDateFormat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(SysUtils.LongDateFormat);
  end;
end;

procedure TatSysUtilsLibrary.__SetLongDateFormat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.LongDateFormat:=GetInputArg(0);
  end;
end;

procedure TatSysUtilsLibrary.__GetTimeSeparator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(SysUtils.TimeSeparator);
  end;
end;

procedure TatSysUtilsLibrary.__SetTimeSeparator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.TimeSeparator:=VarToStr(GetInputArg(0))[1];
  end;
end;

procedure TatSysUtilsLibrary.__GetTimeAMString(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(SysUtils.TimeAMString);
  end;
end;

procedure TatSysUtilsLibrary.__SetTimeAMString(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.TimeAMString:=GetInputArg(0);
  end;
end;

procedure TatSysUtilsLibrary.__GetTimePMString(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(SysUtils.TimePMString);
  end;
end;

procedure TatSysUtilsLibrary.__SetTimePMString(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.TimePMString:=GetInputArg(0);
  end;
end;

procedure TatSysUtilsLibrary.__GetShortTimeFormat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(SysUtils.ShortTimeFormat);
  end;
end;

procedure TatSysUtilsLibrary.__SetShortTimeFormat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.ShortTimeFormat:=GetInputArg(0);
  end;
end;

procedure TatSysUtilsLibrary.__GetLongTimeFormat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(SysUtils.LongTimeFormat);
  end;
end;

procedure TatSysUtilsLibrary.__SetLongTimeFormat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.LongTimeFormat:=GetInputArg(0);
  end;
end;

procedure TatSysUtilsLibrary.__GetSysLocale(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TSysLocaleWrapper.Create(SysUtils.SysLocale)));
  end;
end;

procedure TatSysUtilsLibrary.__SetSysLocale(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.SysLocale:=TSysLocaleWrapper(integer(GetInputArg(0))).ObjToRec;
  end;
end;

procedure TatSysUtilsLibrary.__GetTwoDigitYearCenturyWindow(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(SysUtils.TwoDigitYearCenturyWindow));
  end;
end;

procedure TatSysUtilsLibrary.__SetTwoDigitYearCenturyWindow(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.TwoDigitYearCenturyWindow:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatSysUtilsLibrary.__GetListSeparator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(SysUtils.ListSeparator);
  end;
end;

procedure TatSysUtilsLibrary.__SetListSeparator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.ListSeparator:=VarToStr(GetInputArg(0))[1];
  end;
end;

procedure TatSysUtilsLibrary.__GetMinCurrency(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(SysUtils.MinCurrency);
  end;
end;

procedure TatSysUtilsLibrary.__GetMaxCurrency(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(SysUtils.MaxCurrency);
  end;
end;

procedure TatSysUtilsLibrary.__GetMinDateTime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(SysUtils.MinDateTime);
  end;
end;

procedure TatSysUtilsLibrary.__GetMaxDateTime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(SysUtils.MaxDateTime);
  end;
end;

procedure TatSysUtilsLibrary.__GetLeadBytes(AMachine: TatVirtualMachine);
var
PropValueSet: set of Char;
begin
  with AMachine do
  begin
    PropValueSet := SysUtils.LeadBytes;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatSysUtilsLibrary.__SetLeadBytes(AMachine: TatVirtualMachine);
  var
  TempVar: set of Char;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    SysUtils.LeadBytes:=TempVar;
  end;
end;

procedure TatSysUtilsLibrary.__GetHexDisplayPrefix(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(SysUtils.HexDisplayPrefix);
  end;
end;

procedure TatSysUtilsLibrary.__SetHexDisplayPrefix(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SysUtils.HexDisplayPrefix:=GetInputArg(0);
  end;
end;

procedure TatSysUtilsLibrary.Init;
begin
  With Scripter.DefineClass(TLanguages) do
  begin
    DefineMethod('Create',0,tkClass,TLanguages,__TLanguagesCreate,true,0);
    DefineMethod('IndexOf',1,tkInteger,nil,__TLanguagesIndexOf,false,0);
    DefineProp('Count',tkInteger,__GetTLanguagesCount,nil,nil,false,0);
    DefineProp('Name',tkVariant,__GetTLanguagesName,nil,nil,false,1);
    DefineProp('NameFromLocaleID',tkVariant,__GetTLanguagesNameFromLocaleID,nil,nil,false,1);
    DefineProp('NameFromLCID',tkVariant,__GetTLanguagesNameFromLCID,nil,nil,false,1);
    DefineProp('ID',tkVariant,__GetTLanguagesID,nil,nil,false,1);
    DefineProp('LocaleID',tkInteger,__GetTLanguagesLocaleID,nil,nil,false,1);
    DefineProp('Ext',tkVariant,__GetTLanguagesExt,nil,nil,false,1);
  end;
  With Scripter.DefineClass(Exception) do
  begin
    DefineMethod('Create',1,tkClass,Exception,__ExceptionCreate,true,0);
    DefineMethod('CreateRes',1,tkClass,Exception,__ExceptionCreateRes,true,0);
    DefineMethod('CreateHelp',2,tkClass,Exception,__ExceptionCreateHelp,true,0);
    DefineMethod('CreateResHelp',2,tkClass,Exception,__ExceptionCreateResHelp,true,0);
    DefineProp('HelpContext',tkInteger,__GetExceptionHelpContext,__SetExceptionHelpContext,nil,false,0);
    DefineProp('Message',tkVariant,__GetExceptionMessage,__SetExceptionMessage,nil,false,0);
  end;
  With Scripter.DefineClass(EAbort) do
  begin
  end;
  With Scripter.DefineClass(EHeapException) do
  begin
    DefineMethod('FreeInstance',0,tkNone,nil,__EHeapExceptionFreeInstance,false,0);
  end;
  With Scripter.DefineClass(EOutOfMemory) do
  begin
  end;
  With Scripter.DefineClass(EInOutError) do
  begin
  end;
  With Scripter.DefineClass(EExternal) do
  begin
  end;
  With Scripter.DefineClass(EExternalException) do
  begin
  end;
  With Scripter.DefineClass(EIntError) do
  begin
  end;
  With Scripter.DefineClass(EDivByZero) do
  begin
  end;
  With Scripter.DefineClass(ERangeError) do
  begin
  end;
  With Scripter.DefineClass(EIntOverflow) do
  begin
  end;
  With Scripter.DefineClass(EMathError) do
  begin
  end;
  With Scripter.DefineClass(EInvalidOp) do
  begin
  end;
  With Scripter.DefineClass(EZeroDivide) do
  begin
  end;
  With Scripter.DefineClass(EOverflow) do
  begin
  end;
  With Scripter.DefineClass(EUnderflow) do
  begin
  end;
  With Scripter.DefineClass(EInvalidPointer) do
  begin
  end;
  With Scripter.DefineClass(EInvalidCast) do
  begin
  end;
  With Scripter.DefineClass(EConvertError) do
  begin
  end;
  With Scripter.DefineClass(EAccessViolation) do
  begin
  end;
  With Scripter.DefineClass(EPrivilege) do
  begin
  end;
  With Scripter.DefineClass(EStackOverflow) do
  begin
  end;
  With Scripter.DefineClass(EControlC) do
  begin
  end;
  With Scripter.DefineClass(EVariantError) do
  begin
  end;
  With Scripter.DefineClass(EPropReadOnly) do
  begin
  end;
  With Scripter.DefineClass(EPropWriteOnly) do
  begin
  end;
  With Scripter.DefineClass(EAssertionFailed) do
  begin
  end;
  With Scripter.DefineClass(EAbstractError) do
  begin
  end;
  With Scripter.DefineClass(EIntfCastError) do
  begin
  end;
  With Scripter.DefineClass(EInvalidContainer) do
  begin
  end;
  With Scripter.DefineClass(EInvalidInsert) do
  begin
  end;
  With Scripter.DefineClass(EPackageError) do
  begin
  end;
  With Scripter.DefineClass(EOSError) do
  begin
  end;
  With Scripter.DefineClass(EWin32Error) do
  begin
  end;
  With Scripter.DefineClass(ESafecallException) do
  begin
  end;
  With Scripter.DefineClass(TSimpleRWSync) do
  begin
    DefineMethod('Create',0,tkClass,TSimpleRWSync,__TSimpleRWSyncCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TSimpleRWSyncDestroy,false,0);
    DefineMethod('BeginRead',0,tkNone,nil,__TSimpleRWSyncBeginRead,false,0);
    DefineMethod('EndRead',0,tkNone,nil,__TSimpleRWSyncEndRead,false,0);
    DefineMethod('BeginWrite',0,tkVariant,nil,__TSimpleRWSyncBeginWrite,false,0);
    DefineMethod('EndWrite',0,tkNone,nil,__TSimpleRWSyncEndWrite,false,0);
  end;
  With Scripter.DefineClass(TThreadLocalCounter) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TThreadLocalCounterDestroy,false,0);
  end;
  With Scripter.DefineClass(TMultiReadExclusiveWriteSynchronizer) do
  begin
    DefineMethod('Create',0,tkClass,TMultiReadExclusiveWriteSynchronizer,__TMultiReadExclusiveWriteSynchronizerCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TMultiReadExclusiveWriteSynchronizerDestroy,false,0);
    DefineMethod('BeginRead',0,tkNone,nil,__TMultiReadExclusiveWriteSynchronizerBeginRead,false,0);
    DefineMethod('EndRead',0,tkNone,nil,__TMultiReadExclusiveWriteSynchronizerEndRead,false,0);
    DefineMethod('BeginWrite',0,tkVariant,nil,__TMultiReadExclusiveWriteSynchronizerBeginWrite,false,0);
    DefineMethod('EndWrite',0,tkNone,nil,__TMultiReadExclusiveWriteSynchronizerEndWrite,false,0);
    DefineProp('RevisionLevel',tkInteger,__GetTMultiReadExclusiveWriteSynchronizerRevisionLevel,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TMREWSync) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('CheckWin32Version',2,tkVariant,nil,__CheckWin32Version,false,1);
    DefineMethod('GetFileVersion',1,tkInteger,nil,__GetFileVersion,false,0);
    DefineMethod('Languages',0,tkClass,TLanguages,__Languages,false,0);
    DefineMethod('AppendStr',2,tkNone,nil,__AppendStr,false,0).SetVarArgs([0]);
    DefineMethod('UpperCase',1,tkVariant,nil,__UpperCase,false,0);
    DefineMethod('LowerCase',1,tkVariant,nil,__LowerCase,false,0);
    DefineMethod('CompareStr',2,tkInteger,nil,__CompareStr,false,0);
    DefineMethod('SameStr',2,tkVariant,nil,__SameStr,false,0);
    DefineMethod('CompareText',2,tkInteger,nil,__CompareText,false,0);
    DefineMethod('SameText',2,tkVariant,nil,__SameText,false,0);
    DefineMethod('AnsiUpperCase',1,tkVariant,nil,__AnsiUpperCase,false,0);
    DefineMethod('AnsiLowerCase',1,tkVariant,nil,__AnsiLowerCase,false,0);
    DefineMethod('AnsiCompareStr',2,tkInteger,nil,__AnsiCompareStr,false,0);
    DefineMethod('AnsiSameStr',2,tkVariant,nil,__AnsiSameStr,false,0);
    DefineMethod('AnsiCompareText',2,tkInteger,nil,__AnsiCompareText,false,0);
    DefineMethod('AnsiSameText',2,tkVariant,nil,__AnsiSameText,false,0);
    DefineMethod('AnsiStrComp',2,tkInteger,nil,__AnsiStrComp,false,0);
    DefineMethod('AnsiStrIComp',2,tkInteger,nil,__AnsiStrIComp,false,0);
    DefineMethod('AnsiStrLComp',3,tkInteger,nil,__AnsiStrLComp,false,0);
    DefineMethod('AnsiStrLIComp',3,tkInteger,nil,__AnsiStrLIComp,false,0);
    DefineMethod('AnsiStrLower',1,tkVariant,nil,__AnsiStrLower,false,0);
    DefineMethod('AnsiStrUpper',1,tkVariant,nil,__AnsiStrUpper,false,0);
    DefineMethod('AnsiLastChar',1,tkVariant,nil,__AnsiLastChar,false,0);
    DefineMethod('AnsiStrLastChar',1,tkVariant,nil,__AnsiStrLastChar,false,0);
    DefineMethod('WideUpperCase',1,tkVariant,nil,__WideUpperCase,false,0);
    DefineMethod('WideLowerCase',1,tkVariant,nil,__WideLowerCase,false,0);
    DefineMethod('WideCompareStr',2,tkInteger,nil,__WideCompareStr,false,0);
    DefineMethod('WideSameStr',2,tkVariant,nil,__WideSameStr,false,0);
    DefineMethod('WideCompareText',2,tkInteger,nil,__WideCompareText,false,0);
    DefineMethod('WideSameText',2,tkVariant,nil,__WideSameText,false,0);
    DefineMethod('Trim',1,tkVariant,nil,__Trim,false,0);
    DefineMethod('TrimLeft',1,tkVariant,nil,__TrimLeft,false,0);
    DefineMethod('TrimRight',1,tkVariant,nil,__TrimRight,false,0);
    DefineMethod('QuotedStr',1,tkVariant,nil,__QuotedStr,false,0);
    DefineMethod('AnsiQuotedStr',2,tkVariant,nil,__AnsiQuotedStr,false,0);
    DefineMethod('AnsiExtractQuotedStr',2,tkVariant,nil,__AnsiExtractQuotedStr,false,0).SetVarArgs([0]);
    DefineMethod('AnsiDequotedStr',2,tkVariant,nil,__AnsiDequotedStr,false,0);
    DefineMethod('AdjustLineBreaks',2,tkVariant,nil,__AdjustLineBreaks,false,1);
    DefineMethod('IsValidIdent',2,tkVariant,nil,__IsValidIdent,false,1);
    DefineMethod('IntToStr',1,tkVariant,nil,__IntToStr,false,0);
    DefineMethod('IntToHex',2,tkVariant,nil,__IntToHex,false,0);
    DefineMethod('StrToInt',1,tkInteger,nil,__StrToInt,false,0);
    DefineMethod('StrToIntDef',2,tkInteger,nil,__StrToIntDef,false,0);
    DefineMethod('TryStrToInt',2,tkVariant,nil,__TryStrToInt,false,0).SetVarArgs([1]);
    DefineMethod('StrToInt64',1,tkVariant,nil,__StrToInt64,false,0);
    DefineMethod('StrToInt64Def',2,tkVariant,nil,__StrToInt64Def,false,0);
    DefineMethod('TryStrToInt64',2,tkVariant,nil,__TryStrToInt64,false,0).SetVarArgs([1]);
    DefineMethod('StrToBool',1,tkVariant,nil,__StrToBool,false,0);
    DefineMethod('StrToBoolDef',2,tkVariant,nil,__StrToBoolDef,false,0);
    DefineMethod('TryStrToBool',2,tkVariant,nil,__TryStrToBool,false,0).SetVarArgs([1]);
    DefineMethod('BoolToStr',2,tkVariant,nil,__BoolToStr,false,1);
    DefineMethod('LoadStr',1,tkVariant,nil,__LoadStr,false,0);
    DefineMethod('FileOpen',2,tkInteger,nil,__FileOpen,false,0);
    DefineMethod('FileCreate',1,tkInteger,nil,__FileCreate,false,0);
    DefineMethod('FileRead',3,tkInteger,nil,__FileRead,false,0).SetVarArgs([1]);
    DefineMethod('FileWrite',3,tkInteger,nil,__FileWrite,false,0);
    DefineMethod('FileSeek',3,tkInteger,nil,__FileSeek,false,0);
    DefineMethod('FileClose',1,tkNone,nil,__FileClose,false,0);
    DefineMethod('FileAge',1,tkInteger,nil,__FileAge,false,0);
    DefineMethod('FileExists',1,tkVariant,nil,__FileExists,false,0);
    DefineMethod('DirectoryExists',1,tkVariant,nil,__DirectoryExists,false,0);
    DefineMethod('ForceDirectories',1,tkVariant,nil,__ForceDirectories,false,0);
    DefineMethod('FindFirst',3,tkInteger,nil,__FindFirst,false,0).SetVarArgs([2]);
    DefineMethod('FindNext',1,tkInteger,nil,__FindNext,false,0).SetVarArgs([0]);
    DefineMethod('FindClose',1,tkNone,nil,__FindClose,false,0).SetVarArgs([0]);
    DefineMethod('FileGetDate',1,tkInteger,nil,__FileGetDate,false,0);
    DefineMethod('FileSetDate',2,tkInteger,nil,__FileSetDate,false,0);
    DefineMethod('FileGetAttr',1,tkInteger,nil,__FileGetAttr,false,0);
    DefineMethod('FileSetAttr',2,tkInteger,nil,__FileSetAttr,false,0);
    DefineMethod('FileIsReadOnly',1,tkVariant,nil,__FileIsReadOnly,false,0);
    DefineMethod('FileSetReadOnly',2,tkVariant,nil,__FileSetReadOnly,false,0);
    DefineMethod('DeleteFile',1,tkVariant,nil,__DeleteFile,false,0);
    DefineMethod('RenameFile',2,tkVariant,nil,__RenameFile,false,0);
    DefineMethod('IsAssembly',1,tkVariant,nil,__IsAssembly,false,0);
    DefineMethod('ChangeFileExt',2,tkVariant,nil,__ChangeFileExt,false,0);
    DefineMethod('ChangeFilePath',2,tkVariant,nil,__ChangeFilePath,false,0);
    DefineMethod('ExtractFilePath',1,tkVariant,nil,__ExtractFilePath,false,0);
    DefineMethod('ExtractFileDir',1,tkVariant,nil,__ExtractFileDir,false,0);
    DefineMethod('ExtractFileDrive',1,tkVariant,nil,__ExtractFileDrive,false,0);
    DefineMethod('ExtractFileName',1,tkVariant,nil,__ExtractFileName,false,0);
    DefineMethod('ExtractFileExt',1,tkVariant,nil,__ExtractFileExt,false,0);
    DefineMethod('ExpandFileName',1,tkVariant,nil,__ExpandFileName,false,0);
    DefineMethod('ExpandFileNameCase',2,tkVariant,nil,__ExpandFileNameCase,false,0).SetVarArgs([1]);
    DefineMethod('ExpandUNCFileName',1,tkVariant,nil,__ExpandUNCFileName,false,0);
    DefineMethod('ExtractRelativePath',2,tkVariant,nil,__ExtractRelativePath,false,0);
    DefineMethod('ExtractShortPathName',1,tkVariant,nil,__ExtractShortPathName,false,0);
    DefineMethod('FileSearch',2,tkVariant,nil,__FileSearch,false,0);
    DefineMethod('DiskFree',1,tkVariant,nil,__DiskFree,false,0);
    DefineMethod('DiskSize',1,tkVariant,nil,__DiskSize,false,0);
    DefineMethod('FileDateToDateTime',1,tkVariant,nil,__FileDateToDateTime,false,0);
    DefineMethod('DateTimeToFileDate',1,tkInteger,nil,__DateTimeToFileDate,false,0);
    DefineMethod('GetCurrentDir',0,tkVariant,nil,__GetCurrentDir,false,0);
    DefineMethod('SetCurrentDir',1,tkVariant,nil,__SetCurrentDir,false,0);
    DefineMethod('CreateDir',1,tkVariant,nil,__CreateDir,false,0);
    DefineMethod('RemoveDir',1,tkVariant,nil,__RemoveDir,false,0);
    DefineMethod('StrLen',1,tkInteger,nil,__StrLen,false,0);
    DefineMethod('StrEnd',1,tkVariant,nil,__StrEnd,false,0);
    DefineMethod('StrMove',3,tkVariant,nil,__StrMove,false,0);
    DefineMethod('StrCopy',2,tkVariant,nil,__StrCopy,false,0);
    DefineMethod('StrECopy',2,tkVariant,nil,__StrECopy,false,0);
    DefineMethod('StrLCopy',3,tkVariant,nil,__StrLCopy,false,0);
    DefineMethod('StrPCopy',2,tkVariant,nil,__StrPCopy,false,0);
    DefineMethod('StrPLCopy',3,tkVariant,nil,__StrPLCopy,false,0);
    DefineMethod('StrCat',2,tkVariant,nil,__StrCat,false,0);
    DefineMethod('StrLCat',3,tkVariant,nil,__StrLCat,false,0);
    DefineMethod('StrComp',2,tkInteger,nil,__StrComp,false,0);
    DefineMethod('StrIComp',2,tkInteger,nil,__StrIComp,false,0);
    DefineMethod('StrLComp',3,tkInteger,nil,__StrLComp,false,0);
    DefineMethod('StrLIComp',3,tkInteger,nil,__StrLIComp,false,0);
    DefineMethod('StrScan',2,tkVariant,nil,__StrScan,false,0);
    DefineMethod('StrRScan',2,tkVariant,nil,__StrRScan,false,0);
    DefineMethod('StrPos',2,tkVariant,nil,__StrPos,false,0);
    DefineMethod('StrUpper',1,tkVariant,nil,__StrUpper,false,0);
    DefineMethod('StrLower',1,tkVariant,nil,__StrLower,false,0);
    DefineMethod('StrPas',1,tkVariant,nil,__StrPas,false,0);
    DefineMethod('StrAlloc',1,tkVariant,nil,__StrAlloc,false,0);
    DefineMethod('StrBufSize',1,tkInteger,nil,__StrBufSize,false,0);
    DefineMethod('StrNew',1,tkVariant,nil,__StrNew,false,0);
    DefineMethod('StrDispose',1,tkNone,nil,__StrDispose,false,0);
    DefineMethod('FloatToStr',1,tkVariant,nil,__FloatToStr,false,0);
    DefineMethod('CurrToStr',1,tkVariant,nil,__CurrToStr,false,0);
    DefineMethod('FloatToCurr',1,tkVariant,nil,__FloatToCurr,false,0);
    DefineMethod('TryFloatToCurr',2,tkVariant,nil,__TryFloatToCurr,false,0).SetVarArgs([1]);
    DefineMethod('FloatToStrF',4,tkVariant,nil,__FloatToStrF,false,0);
    DefineMethod('CurrToStrF',3,tkVariant,nil,__CurrToStrF,false,0);
    DefineMethod('FloatToText',6,tkInteger,nil,__FloatToText,false,0);
    DefineMethod('FormatFloat',2,tkVariant,nil,__FormatFloat,false,0);
    DefineMethod('FormatCurr',2,tkVariant,nil,__FormatCurr,false,0);
    DefineMethod('FloatToTextFmt',4,tkInteger,nil,__FloatToTextFmt,false,0);
    DefineMethod('StrToFloat',1,tkVariant,nil,__StrToFloat,false,0);
    DefineMethod('StrToFloatDef',2,tkVariant,nil,__StrToFloatDef,false,0);
    DefineMethod('TryStrToFloat',2,tkVariant,nil,__TryStrToFloat,false,0).SetVarArgs([1]);
    DefineMethod('StrToCurr',1,tkVariant,nil,__StrToCurr,false,0);
    DefineMethod('StrToCurrDef',2,tkVariant,nil,__StrToCurrDef,false,0);
    DefineMethod('TryStrToCurr',2,tkVariant,nil,__TryStrToCurr,false,0).SetVarArgs([1]);
    DefineMethod('TextToFloat',3,tkVariant,nil,__TextToFloat,false,0).SetVarArgs([1]);
    DefineMethod('FloatToDecimal',5,tkNone,nil,__FloatToDecimal,false,0).SetVarArgs([0]);
    DefineMethod('DateTimeToTimeStamp',1,tkVariant,nil,__DateTimeToTimeStamp,false,0);
    DefineMethod('TimeStampToDateTime',1,tkVariant,nil,__TimeStampToDateTime,false,0);
    DefineMethod('MSecsToTimeStamp',1,tkVariant,nil,__MSecsToTimeStamp,false,0);
    DefineMethod('TimeStampToMSecs',1,tkVariant,nil,__TimeStampToMSecs,false,0);
    DefineMethod('EncodeDate',3,tkVariant,nil,__EncodeDate,false,0);
    DefineMethod('EncodeTime',4,tkVariant,nil,__EncodeTime,false,0);
    DefineMethod('TryEncodeDate',4,tkVariant,nil,__TryEncodeDate,false,0).SetVarArgs([3]);
    DefineMethod('TryEncodeTime',5,tkVariant,nil,__TryEncodeTime,false,0).SetVarArgs([4]);
    DefineMethod('DecodeDate',4,tkNone,nil,__DecodeDate,false,0).SetVarArgs([1,2,3]);
    DefineMethod('DecodeDateFully',5,tkVariant,nil,__DecodeDateFully,false,0).SetVarArgs([1,2,3,4]);
    DefineMethod('DecodeTime',5,tkNone,nil,__DecodeTime,false,0).SetVarArgs([1,2,3,4]);
    DefineMethod('DateTimeToSystemTime',2,tkNone,nil,__DateTimeToSystemTime,false,0).SetVarArgs([1]);
    DefineMethod('SystemTimeToDateTime',1,tkVariant,nil,__SystemTimeToDateTime,false,0);
    DefineMethod('DayOfWeek',1,tkInteger,nil,__DayOfWeek,false,0);
    DefineMethod('Date',0,tkVariant,nil,__Date,false,0);
    DefineMethod('Time',0,tkVariant,nil,__Time,false,0);
    DefineMethod('GetTime',0,tkVariant,nil,__GetTime,false,0);
    DefineMethod('Now',0,tkVariant,nil,__Now,false,0);
    DefineMethod('CurrentYear',0,tkInteger,nil,__CurrentYear,false,0);
    DefineMethod('IncMonth',2,tkVariant,nil,__IncMonth,false,1);
    DefineMethod('IncAMonth',4,tkNone,nil,__IncAMonth,false,1).SetVarArgs([0,1,2]);
    DefineMethod('ReplaceTime',2,tkNone,nil,__ReplaceTime,false,0).SetVarArgs([0]);
    DefineMethod('ReplaceDate',2,tkNone,nil,__ReplaceDate,false,0).SetVarArgs([0]);
    DefineMethod('IsLeapYear',1,tkVariant,nil,__IsLeapYear,false,0);
    DefineMethod('DateToStr',1,tkVariant,nil,__DateToStr,false,0);
    DefineMethod('TimeToStr',1,tkVariant,nil,__TimeToStr,false,0);
    DefineMethod('DateTimeToStr',1,tkVariant,nil,__DateTimeToStr,false,0);
    DefineMethod('StrToDate',1,tkVariant,nil,__StrToDate,false,0);
    DefineMethod('StrToDateDef',2,tkVariant,nil,__StrToDateDef,false,0);
    DefineMethod('TryStrToDate',2,tkVariant,nil,__TryStrToDate,false,0).SetVarArgs([1]);
    DefineMethod('StrToTime',1,tkVariant,nil,__StrToTime,false,0);
    DefineMethod('StrToTimeDef',2,tkVariant,nil,__StrToTimeDef,false,0);
    DefineMethod('TryStrToTime',2,tkVariant,nil,__TryStrToTime,false,0).SetVarArgs([1]);
    DefineMethod('StrToDateTime',1,tkVariant,nil,__StrToDateTime,false,0);
    DefineMethod('StrToDateTimeDef',2,tkVariant,nil,__StrToDateTimeDef,false,0);
    DefineMethod('TryStrToDateTime',2,tkVariant,nil,__TryStrToDateTime,false,0).SetVarArgs([1]);
    DefineMethod('FormatDateTime',2,tkVariant,nil,__FormatDateTime,false,0);
    DefineMethod('DateTimeToString',3,tkNone,nil,__DateTimeToString,false,0).SetVarArgs([0]);
    DefineMethod('FloatToDateTime',1,tkVariant,nil,__FloatToDateTime,false,0);
    DefineMethod('TryFloatToDateTime',2,tkVariant,nil,__TryFloatToDateTime,false,0).SetVarArgs([1]);
    DefineMethod('SysErrorMessage',1,tkVariant,nil,__SysErrorMessage,false,0);
    DefineMethod('GetLocaleStr',3,tkVariant,nil,__GetLocaleStr,false,0);
    DefineMethod('GetLocaleChar',3,tkVariant,nil,__GetLocaleChar,false,0);
    DefineMethod('GetFormatSettings',0,tkNone,nil,__GetFormatSettings,false,0);
    DefineMethod('GetLocaleFormatSettings',2,tkNone,nil,__GetLocaleFormatSettings,false,0).SetVarArgs([1]);
    DefineMethod('Sleep',1,tkNone,nil,__Sleep,false,0);
    DefineMethod('GetModuleName',1,tkVariant,nil,__GetModuleName,false,0);
    DefineMethod('Abort',0,tkNone,nil,__Abort,false,0);
    DefineMethod('OutOfMemoryError',0,tkNone,nil,__OutOfMemoryError,false,0);
    DefineMethod('Beep',0,tkNone,nil,__Beep,false,0);
    DefineMethod('ByteType',2,tkEnumeration,nil,__ByteType,false,0);
    DefineMethod('StrByteType',2,tkEnumeration,nil,__StrByteType,false,0);
    DefineMethod('ByteToCharLen',2,tkInteger,nil,__ByteToCharLen,false,0);
    DefineMethod('CharToByteLen',2,tkInteger,nil,__CharToByteLen,false,0);
    DefineMethod('ByteToCharIndex',2,tkInteger,nil,__ByteToCharIndex,false,0);
    DefineMethod('CharToByteIndex',2,tkInteger,nil,__CharToByteIndex,false,0);
    DefineMethod('StrCharLength',1,tkInteger,nil,__StrCharLength,false,0);
    DefineMethod('StrNextChar',1,tkVariant,nil,__StrNextChar,false,0);
    DefineMethod('CharLength',2,tkInteger,nil,__CharLength,false,0);
    DefineMethod('NextCharIndex',2,tkInteger,nil,__NextCharIndex,false,0);
    DefineMethod('IsPathDelimiter',2,tkVariant,nil,__IsPathDelimiter,false,0);
    DefineMethod('IsDelimiter',3,tkVariant,nil,__IsDelimiter,false,0);
    DefineMethod('IncludeTrailingPathDelimiter',1,tkVariant,nil,__IncludeTrailingPathDelimiter,false,0);
    DefineMethod('IncludeTrailingBackslash',1,tkVariant,nil,__IncludeTrailingBackslash,false,0);
    DefineMethod('ExcludeTrailingPathDelimiter',1,tkVariant,nil,__ExcludeTrailingPathDelimiter,false,0);
    DefineMethod('ExcludeTrailingBackslash',1,tkVariant,nil,__ExcludeTrailingBackslash,false,0);
    DefineMethod('LastDelimiter',2,tkInteger,nil,__LastDelimiter,false,0);
    DefineMethod('AnsiCompareFileName',2,tkInteger,nil,__AnsiCompareFileName,false,0);
    DefineMethod('SameFileName',2,tkVariant,nil,__SameFileName,false,0);
    DefineMethod('AnsiLowerCaseFileName',1,tkVariant,nil,__AnsiLowerCaseFileName,false,0);
    DefineMethod('AnsiUpperCaseFileName',1,tkVariant,nil,__AnsiUpperCaseFileName,false,0);
    DefineMethod('AnsiPos',2,tkInteger,nil,__AnsiPos,false,0);
    DefineMethod('AnsiStrPos',2,tkVariant,nil,__AnsiStrPos,false,0);
    DefineMethod('AnsiStrRScan',2,tkVariant,nil,__AnsiStrRScan,false,0);
    DefineMethod('AnsiStrScan',2,tkVariant,nil,__AnsiStrScan,false,0);
    DefineMethod('StringReplace',4,tkVariant,nil,__StringReplace,false,0);
    DefineMethod('WrapText',4,tkVariant,nil,__WrapText,false,0);
    DefineMethod('FindCmdLineSwitch',3,tkVariant,nil,__FindCmdLineSwitch,false,0);
    DefineMethod('FreeAndNil',1,tkNone,nil,__FreeAndNil,false,0).SetVarArgs([0]);
    DefineMethod('Supports',3,tkVariant,nil,__Supports,false,0).SetVarArgs([2]);
    DefineMethod('CreateGUID',1,tkInteger,nil,__CreateGUID,false,0).SetVarArgs([0]);
    DefineMethod('StringToGUID',1,tkVariant,nil,__StringToGUID,false,0);
    DefineMethod('GUIDToString',1,tkVariant,nil,__GUIDToString,false,0);
    DefineMethod('IsEqualGUID',2,tkVariant,nil,__IsEqualGUID,false,0);
    DefineMethod('LoadPackage',1,tkInteger,nil,__LoadPackage,false,0);
    DefineMethod('UnloadPackage',1,tkNone,nil,__UnloadPackage,false,0);
    DefineMethod('GetPackageDescription',1,tkVariant,nil,__GetPackageDescription,false,0);
    DefineMethod('InitializePackage',1,tkNone,nil,__InitializePackage,false,0);
    DefineMethod('FinalizePackage',1,tkNone,nil,__FinalizePackage,false,0);
    DefineMethod('RaiseLastOSError',0,tkNone,nil,__RaiseLastOSError,false,0);
    DefineMethod('RaiseLastWin32Error',0,tkNone,nil,__RaiseLastWin32Error,false,0);
    DefineMethod('Win32Check',1,tkVariant,nil,__Win32Check,false,0);
    DefineMethod('CallTerminateProcs',0,tkVariant,nil,__CallTerminateProcs,false,0);
    DefineMethod('GDAL',0,tkInteger,nil,__GDAL,false,0);
    DefineMethod('RCS',0,tkNone,nil,__RCS,false,0);
    DefineMethod('RPR',0,tkNone,nil,__RPR,false,0);
    DefineMethod('SafeLoadLibrary',2,tkInteger,nil,__SafeLoadLibrary,false,1);
    DefineMethod('GetEnvironmentVariable',1,tkVariant,nil,__GetEnvironmentVariable,false,0);
    DefineProp('EmptyStr',tkVariant,__GetEmptyStr,__SetEmptyStr,nil,false,0);
    DefineProp('EmptyWideStr',tkVariant,__GetEmptyWideStr,__SetEmptyWideStr,nil,false,0);
    DefineProp('Win32Platform',tkInteger,__GetWin32Platform,__SetWin32Platform,nil,false,0);
    DefineProp('Win32MajorVersion',tkInteger,__GetWin32MajorVersion,__SetWin32MajorVersion,nil,false,0);
    DefineProp('Win32MinorVersion',tkInteger,__GetWin32MinorVersion,__SetWin32MinorVersion,nil,false,0);
    DefineProp('Win32BuildNumber',tkInteger,__GetWin32BuildNumber,__SetWin32BuildNumber,nil,false,0);
    DefineProp('Win32CSDVersion',tkVariant,__GetWin32CSDVersion,__SetWin32CSDVersion,nil,false,0);
    DefineProp('CurrencyString',tkVariant,__GetCurrencyString,__SetCurrencyString,nil,false,0);
    DefineProp('CurrencyFormat',tkInteger,__GetCurrencyFormat,__SetCurrencyFormat,nil,false,0);
    DefineProp('NegCurrFormat',tkInteger,__GetNegCurrFormat,__SetNegCurrFormat,nil,false,0);
    DefineProp('ThousandSeparator',tkVariant,__GetThousandSeparator,__SetThousandSeparator,nil,false,0);
    DefineProp('DecimalSeparator',tkVariant,__GetDecimalSeparator,__SetDecimalSeparator,nil,false,0);
    DefineProp('CurrencyDecimals',tkInteger,__GetCurrencyDecimals,__SetCurrencyDecimals,nil,false,0);
    DefineProp('DateSeparator',tkVariant,__GetDateSeparator,__SetDateSeparator,nil,false,0);
    DefineProp('ShortDateFormat',tkVariant,__GetShortDateFormat,__SetShortDateFormat,nil,false,0);
    DefineProp('LongDateFormat',tkVariant,__GetLongDateFormat,__SetLongDateFormat,nil,false,0);
    DefineProp('TimeSeparator',tkVariant,__GetTimeSeparator,__SetTimeSeparator,nil,false,0);
    DefineProp('TimeAMString',tkVariant,__GetTimeAMString,__SetTimeAMString,nil,false,0);
    DefineProp('TimePMString',tkVariant,__GetTimePMString,__SetTimePMString,nil,false,0);
    DefineProp('ShortTimeFormat',tkVariant,__GetShortTimeFormat,__SetShortTimeFormat,nil,false,0);
    DefineProp('LongTimeFormat',tkVariant,__GetLongTimeFormat,__SetLongTimeFormat,nil,false,0);
    DefineProp('SysLocale',tkVariant,__GetSysLocale,__SetSysLocale,nil,false,0);
    DefineProp('TwoDigitYearCenturyWindow',tkInteger,__GetTwoDigitYearCenturyWindow,__SetTwoDigitYearCenturyWindow,nil,false,0);
    DefineProp('ListSeparator',tkVariant,__GetListSeparator,__SetListSeparator,nil,false,0);
    DefineProp('MinCurrency',tkVariant,__GetMinCurrency,nil,nil,false,0);
    DefineProp('MaxCurrency',tkVariant,__GetMaxCurrency,nil,nil,false,0);
    DefineProp('MinDateTime',tkVariant,__GetMinDateTime,nil,nil,false,0);
    DefineProp('MaxDateTime',tkVariant,__GetMaxDateTime,nil,nil,false,0);
    DefineProp('LeadBytes',tkInteger,__GetLeadBytes,__SetLeadBytes,nil,false,0);
    DefineProp('HexDisplayPrefix',tkVariant,__GetHexDisplayPrefix,__SetHexDisplayPrefix,nil,false,0);
    AddConstant('fvExtended',fvExtended);
    AddConstant('fvCurrency',fvCurrency);
    AddConstant('ffGeneral',ffGeneral);
    AddConstant('ffExponent',ffExponent);
    AddConstant('ffFixed',ffFixed);
    AddConstant('ffNumber',ffNumber);
    AddConstant('ffCurrency',ffCurrency);
    AddConstant('mbSingleByte',mbSingleByte);
    AddConstant('mbLeadByte',mbLeadByte);
    AddConstant('mbTrailByte',mbTrailByte);
    AddConstant('loInvariantLocale',loInvariantLocale);
    AddConstant('loUserLocale',loUserLocale);
    AddConstant('mkNone',mkNone);
    AddConstant('mkExactMatch',mkExactMatch);
    AddConstant('mkSingleMatch',mkSingleMatch);
    AddConstant('mkAmbiguous',mkAmbiguous);
    AddConstant('ntContainsUnit',ntContainsUnit);
    AddConstant('ntRequiresPackage',ntRequiresPackage);
    AddConstant('ntDcpBpiName',ntDcpBpiName);
    AddConstant('fmOpenRead',fmOpenRead);
    AddConstant('fmOpenWrite',fmOpenWrite);
    AddConstant('fmOpenReadWrite',fmOpenReadWrite);
    AddConstant('fmShareCompat',fmShareCompat);
    AddConstant('fmShareExclusive',fmShareExclusive);
    AddConstant('fmShareDenyWrite',fmShareDenyWrite);
    AddConstant('fmShareDenyRead',fmShareDenyRead);
    AddConstant('fmShareDenyNone',fmShareDenyNone);
    AddConstant('faReadOnly',faReadOnly);
    AddConstant('faHidden',faHidden);
    AddConstant('faSysFile',faSysFile);
    AddConstant('faVolumeID',faVolumeID);
    AddConstant('faDirectory',faDirectory);
    AddConstant('faArchive',faArchive);
    AddConstant('faSymLink',faSymLink);
    AddConstant('faAnyFile',faAnyFile);
    AddConstant('HoursPerDay',HoursPerDay);
    AddConstant('MinsPerHour',MinsPerHour);
    AddConstant('SecsPerMin',SecsPerMin);
    AddConstant('MSecsPerSec',MSecsPerSec);
    AddConstant('MinsPerDay',MinsPerDay);
    AddConstant('SecsPerDay',SecsPerDay);
    AddConstant('MSecsPerDay',MSecsPerDay);
    AddConstant('DateDelta',DateDelta);
    AddConstant('UnixDateDelta',UnixDateDelta);
    AddConstant('MaxEraCount',MaxEraCount);
    AddConstant('PathDelim',PathDelim);
    AddConstant('DriveDelim',DriveDelim);
    AddConstant('PathSep',PathSep);
    AddConstant('DefaultTrueBoolStr',DefaultTrueBoolStr);
    AddConstant('DefaultFalseBoolStr',DefaultFalseBoolStr);
    AddConstant('SwitchChars',IntFromConstSet(SwitchChars));
    AddConstant('pfNeverBuild',pfNeverBuild);
    AddConstant('pfDesignOnly',pfDesignOnly);
    AddConstant('pfRunOnly',pfRunOnly);
    AddConstant('pfIgnoreDupUnits',pfIgnoreDupUnits);
    AddConstant('pfModuleTypeMask',pfModuleTypeMask);
    AddConstant('pfExeModule',pfExeModule);
    AddConstant('pfPackageModule',pfPackageModule);
    AddConstant('pfProducerMask',pfProducerMask);
    AddConstant('pfV3Produced',pfV3Produced);
    AddConstant('pfProducerUndefined',pfProducerUndefined);
    AddConstant('pfBCB4Produced',pfBCB4Produced);
    AddConstant('pfDelphi4Produced',pfDelphi4Produced);
    AddConstant('pfLibraryModule',pfLibraryModule);
    AddConstant('pfConsumerMask',pfConsumerMask);
    AddConstant('pfConsumerCompat',pfConsumerCompat);
    AddConstant('pfConsumerDelphi',pfConsumerDelphi);
    AddConstant('pfConsumerBCB',pfConsumerBCB);
    AddConstant('ufMainUnit',ufMainUnit);
    AddConstant('ufPackageUnit',ufPackageUnit);
    AddConstant('ufWeakUnit',ufWeakUnit);
    AddConstant('ufOrgWeakUnit',ufOrgWeakUnit);
    AddConstant('ufImplicitUnit',ufImplicitUnit);
    AddConstant('ufWeakPackageUnit',ufWeakPackageUnit);
  end;
end;

class function TatSysUtilsLibrary.LibraryName: string;
begin
  result := 'SysUtils';
end;

initialization
  RegisterScripterLibrary(TatSysUtilsLibrary, True);

{$WARNINGS ON}

end.

