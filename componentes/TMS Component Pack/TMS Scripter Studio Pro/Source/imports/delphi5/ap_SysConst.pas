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
    AddConstant('SInvalidDate',SInvalidDate);
    AddConstant('SInvalidTime',SInvalidTime);
    AddConstant('SInvalidDateTime',SInvalidDateTime);
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
    AddConstant('SAccessViolation',SAccessViolation);
    AddConstant('SStackOverflow',SStackOverflow);
    AddConstant('SControlC',SControlC);
    AddConstant('SPrivilege',SPrivilege);
    AddConstant('SOperationAborted',SOperationAborted);
    AddConstant('SException',SException);
    AddConstant('SExceptTitle',SExceptTitle);
    AddConstant('SInvalidFormat',SInvalidFormat);
    AddConstant('SArgumentMissing',SArgumentMissing);
    AddConstant('SInvalidVarCast',SInvalidVarCast);
    AddConstant('SInvalidVarOp',SInvalidVarOp);
    AddConstant('SDispatchError',SDispatchError);
    AddConstant('SReadAccess',SReadAccess);
    AddConstant('SWriteAccess',SWriteAccess);
    AddConstant('SResultTooLong',SResultTooLong);
    AddConstant('SFormatTooLong',SFormatTooLong);
    AddConstant('SVarArrayCreate',SVarArrayCreate);
    AddConstant('SVarNotArray',SVarNotArray);
    AddConstant('SVarArrayBounds',SVarArrayBounds);
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

