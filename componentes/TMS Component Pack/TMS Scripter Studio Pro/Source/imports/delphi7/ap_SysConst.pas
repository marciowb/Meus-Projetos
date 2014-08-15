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
unit ap_SysConst;

interface

uses
  SysConst,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatSysConstLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatSysConstLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('SUnknown',SUnknown);
    AddConstant('SInvalidInteger',SInvalidInteger);
    AddConstant('SInvalidFloat',SInvalidFloat);
    AddConstant('SInvalidCurrency',SInvalidCurrency);
    AddConstant('SInvalidDate',SInvalidDate);
    AddConstant('SInvalidTime',SInvalidTime);
    AddConstant('SInvalidDateTime',SInvalidDateTime);
    AddConstant('SInvalidDateTimeFloat',SInvalidDateTimeFloat);
    AddConstant('SInvalidTimeStamp',SInvalidTimeStamp);
    AddConstant('SInvalidGUID',SInvalidGUID);
    AddConstant('SInvalidBoolean',SInvalidBoolean);
    AddConstant('STimeEncodeError',STimeEncodeError);
    AddConstant('SDateEncodeError',SDateEncodeError);
    AddConstant('SOutOfMemory',SOutOfMemory);
    AddConstant('SInOutError',SInOutError);
    AddConstant('SFileNotFound',SFileNotFound);
    AddConstant('SInvalidFilename',SInvalidFilename);
    AddConstant('STooManyOpenFiles',STooManyOpenFiles);
    AddConstant('SAccessDenied',SAccessDenied);
    AddConstant('SEndOfFile',SEndOfFile);
    AddConstant('SDiskFull',SDiskFull);
    AddConstant('SInvalidInput',SInvalidInput);
    AddConstant('SDivByZero',SDivByZero);
    AddConstant('SRangeError',SRangeError);
    AddConstant('SIntOverflow',SIntOverflow);
    AddConstant('SInvalidOp',SInvalidOp);
    AddConstant('SZeroDivide',SZeroDivide);
    AddConstant('SOverflow',SOverflow);
    AddConstant('SUnderflow',SUnderflow);
    AddConstant('SInvalidPointer',SInvalidPointer);
    AddConstant('SInvalidCast',SInvalidCast);
    AddConstant('SAccessViolationArg3',SAccessViolationArg3);
    AddConstant('SAccessViolationNoArg',SAccessViolationNoArg);
    AddConstant('SStackOverflow',SStackOverflow);
    AddConstant('SControlC',SControlC);
    AddConstant('SQuit',SQuit);
    AddConstant('SPrivilege',SPrivilege);
    AddConstant('SOperationAborted',SOperationAborted);
    AddConstant('SException',SException);
    AddConstant('SExceptTitle',SExceptTitle);
    AddConstant('SInvalidFormat',SInvalidFormat);
    AddConstant('SArgumentMissing',SArgumentMissing);
    AddConstant('SDispatchError',SDispatchError);
    AddConstant('SReadAccess',SReadAccess);
    AddConstant('SWriteAccess',SWriteAccess);
    AddConstant('SResultTooLong',SResultTooLong);
    AddConstant('SFormatTooLong',SFormatTooLong);
    AddConstant('SVarArrayCreate',SVarArrayCreate);
    AddConstant('SVarArrayBounds',SVarArrayBounds);
    AddConstant('SVarArrayLocked',SVarArrayLocked);
    AddConstant('SVarArrayWithHResult',SVarArrayWithHResult);
    AddConstant('SInvalidVarCast',SInvalidVarCast);
    AddConstant('SInvalidVarOp',SInvalidVarOp);
    AddConstant('SInvalidVarNullOp',SInvalidVarNullOp);
    AddConstant('SInvalidVarOpWithHResultWithPrefix',SInvalidVarOpWithHResultWithPrefix);
    AddConstant('SVarTypeRangeCheck1',SVarTypeRangeCheck1);
    AddConstant('SVarTypeRangeCheck2',SVarTypeRangeCheck2);
    AddConstant('SVarTypeOutOfRangeWithPrefix',SVarTypeOutOfRangeWithPrefix);
    AddConstant('SVarTypeAlreadyUsedWithPrefix',SVarTypeAlreadyUsedWithPrefix);
    AddConstant('SVarTypeNotUsableWithPrefix',SVarTypeNotUsableWithPrefix);
    AddConstant('SVarTypeTooManyCustom',SVarTypeTooManyCustom);
    AddConstant('SVarNotArray',SVarNotArray);
    AddConstant('SVarTypeUnknown',SVarTypeUnknown);
    AddConstant('SVarTypeOutOfRange',SVarTypeOutOfRange);
    AddConstant('SVarTypeAlreadyUsed',SVarTypeAlreadyUsed);
    AddConstant('SVarTypeNotUsable',SVarTypeNotUsable);
    AddConstant('SInvalidVarOpWithHResult',SInvalidVarOpWithHResult);
    AddConstant('SVarTypeCouldNotConvert',SVarTypeCouldNotConvert);
    AddConstant('SVarTypeConvertOverflow',SVarTypeConvertOverflow);
    AddConstant('SVarOverflow',SVarOverflow);
    AddConstant('SVarInvalid',SVarInvalid);
    AddConstant('SVarBadType',SVarBadType);
    AddConstant('SVarNotImplemented',SVarNotImplemented);
    AddConstant('SVarOutOfMemory',SVarOutOfMemory);
    AddConstant('SVarUnexpected',SVarUnexpected);
    AddConstant('SVarDataClearRecursing',SVarDataClearRecursing);
    AddConstant('SVarDataCopyRecursing',SVarDataCopyRecursing);
    AddConstant('SVarDataCopyNoIndRecursing',SVarDataCopyNoIndRecursing);
    AddConstant('SVarDataInitRecursing',SVarDataInitRecursing);
    AddConstant('SVarDataCastToRecursing',SVarDataCastToRecursing);
    AddConstant('SVarIsEmpty',SVarIsEmpty);
    AddConstant('sUnknownFromType',sUnknownFromType);
    AddConstant('sUnknownToType',sUnknownToType);
    AddConstant('SExternalException',SExternalException);
    AddConstant('SAssertionFailed',SAssertionFailed);
    AddConstant('SIntfCastError',SIntfCastError);
    AddConstant('SSafecallException',SSafecallException);
    AddConstant('SAssertError',SAssertError);
    AddConstant('SAbstractError',SAbstractError);
    AddConstant('SModuleAccessViolation',SModuleAccessViolation);
    AddConstant('SCannotReadPackageInfo',SCannotReadPackageInfo);
    AddConstant('sErrorLoadingPackage',sErrorLoadingPackage);
    AddConstant('SInvalidPackageFile',SInvalidPackageFile);
    AddConstant('SInvalidPackageHandle',SInvalidPackageHandle);
    AddConstant('SDuplicatePackageUnit',SDuplicatePackageUnit);
    AddConstant('SOSError',SOSError);
    AddConstant('SUnkOSError',SUnkOSError);
    AddConstant('SWin32Error',SWin32Error);
    AddConstant('SUnkWin32Error',SUnkWin32Error);
    AddConstant('SNL',SNL);
    AddConstant('SShortMonthNameJan',SShortMonthNameJan);
    AddConstant('SShortMonthNameFeb',SShortMonthNameFeb);
    AddConstant('SShortMonthNameMar',SShortMonthNameMar);
    AddConstant('SShortMonthNameApr',SShortMonthNameApr);
    AddConstant('SShortMonthNameMay',SShortMonthNameMay);
    AddConstant('SShortMonthNameJun',SShortMonthNameJun);
    AddConstant('SShortMonthNameJul',SShortMonthNameJul);
    AddConstant('SShortMonthNameAug',SShortMonthNameAug);
    AddConstant('SShortMonthNameSep',SShortMonthNameSep);
    AddConstant('SShortMonthNameOct',SShortMonthNameOct);
    AddConstant('SShortMonthNameNov',SShortMonthNameNov);
    AddConstant('SShortMonthNameDec',SShortMonthNameDec);
    AddConstant('SLongMonthNameJan',SLongMonthNameJan);
    AddConstant('SLongMonthNameFeb',SLongMonthNameFeb);
    AddConstant('SLongMonthNameMar',SLongMonthNameMar);
    AddConstant('SLongMonthNameApr',SLongMonthNameApr);
    AddConstant('SLongMonthNameMay',SLongMonthNameMay);
    AddConstant('SLongMonthNameJun',SLongMonthNameJun);
    AddConstant('SLongMonthNameJul',SLongMonthNameJul);
    AddConstant('SLongMonthNameAug',SLongMonthNameAug);
    AddConstant('SLongMonthNameSep',SLongMonthNameSep);
    AddConstant('SLongMonthNameOct',SLongMonthNameOct);
    AddConstant('SLongMonthNameNov',SLongMonthNameNov);
    AddConstant('SLongMonthNameDec',SLongMonthNameDec);
    AddConstant('SShortDayNameSun',SShortDayNameSun);
    AddConstant('SShortDayNameMon',SShortDayNameMon);
    AddConstant('SShortDayNameTue',SShortDayNameTue);
    AddConstant('SShortDayNameWed',SShortDayNameWed);
    AddConstant('SShortDayNameThu',SShortDayNameThu);
    AddConstant('SShortDayNameFri',SShortDayNameFri);
    AddConstant('SShortDayNameSat',SShortDayNameSat);
    AddConstant('SLongDayNameSun',SLongDayNameSun);
    AddConstant('SLongDayNameMon',SLongDayNameMon);
    AddConstant('SLongDayNameTue',SLongDayNameTue);
    AddConstant('SLongDayNameWed',SLongDayNameWed);
    AddConstant('SLongDayNameThu',SLongDayNameThu);
    AddConstant('SLongDayNameFri',SLongDayNameFri);
    AddConstant('SLongDayNameSat',SLongDayNameSat);
    AddConstant('SCannotCreateDir',SCannotCreateDir);
    AddConstant('SCodesetConversionError',SCodesetConversionError);
  end;
end;

class function TatSysConstLibrary.LibraryName: string;
begin
  result := 'SysConst';
end;

initialization
  RegisterScripterLibrary(TatSysConstLibrary, True);

{$WARNINGS ON}

end.

