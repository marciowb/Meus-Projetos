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
unit ap_RTLConsts;

interface

uses
  RTLConsts,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatRTLConstsLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatRTLConstsLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('SAncestorNotFound',SAncestorNotFound);
    AddConstant('SAssignError',SAssignError);
    AddConstant('SBitsIndexError',SBitsIndexError);
    AddConstant('SBucketListLocked',SBucketListLocked);
    AddConstant('SCantWriteResourceStreamError',SCantWriteResourceStreamError);
    AddConstant('SCharExpected',SCharExpected);
    AddConstant('SCheckSynchronizeError',SCheckSynchronizeError);
    AddConstant('SClassNotFound',SClassNotFound);
    AddConstant('SDelimiterQuoteCharError',SDelimiterQuoteCharError);
    AddConstant('SDuplicateClass',SDuplicateClass);
    AddConstant('SDuplicateItem',SDuplicateItem);
    AddConstant('SDuplicateName',SDuplicateName);
    AddConstant('SDuplicateString',SDuplicateString);
    AddConstant('SFCreateError',SFCreateError);
    AddConstant('SFixedColTooBig',SFixedColTooBig);
    AddConstant('SFixedRowTooBig',SFixedRowTooBig);
    AddConstant('SFOpenError',SFOpenError);
    AddConstant('SGridTooLarge',SGridTooLarge);
    AddConstant('SIdentifierExpected',SIdentifierExpected);
    AddConstant('SIndexOutOfRange',SIndexOutOfRange);
    AddConstant('SIniFileWriteError',SIniFileWriteError);
    AddConstant('SInvalidActionCreation',SInvalidActionCreation);
    AddConstant('SInvalidActionEnumeration',SInvalidActionEnumeration);
    AddConstant('SInvalidActionRegistration',SInvalidActionRegistration);
    AddConstant('SInvalidActionUnregistration',SInvalidActionUnregistration);
    AddConstant('SInvalidBinary',SInvalidBinary);
    AddConstant('SInvalidDate',SInvalidDate);
    AddConstant('SInvalidDateTime',SInvalidDateTime);
    AddConstant('SInvalidFileName',SInvalidFileName);
    AddConstant('SInvalidImage',SInvalidImage);
    AddConstant('SInvalidInteger',SInvalidInteger);
    AddConstant('SInvalidMask',SInvalidMask);
    AddConstant('SInvalidName',SInvalidName);
    AddConstant('SInvalidProperty',SInvalidProperty);
    AddConstant('SInvalidPropertyElement',SInvalidPropertyElement);
    AddConstant('SInvalidPropertyPath',SInvalidPropertyPath);
    AddConstant('SInvalidPropertyType',SInvalidPropertyType);
    AddConstant('SInvalidPropertyValue',SInvalidPropertyValue);
    AddConstant('SInvalidRegType',SInvalidRegType);
    AddConstant('SInvalidString',SInvalidString);
    AddConstant('SInvalidStringGridOp',SInvalidStringGridOp);
    AddConstant('SInvalidTime',SInvalidTime);
    AddConstant('SItemNotFound',SItemNotFound);
    AddConstant('SLineTooLong',SLineTooLong);
    AddConstant('SListCapacityError',SListCapacityError);
    AddConstant('SListCountError',SListCountError);
    AddConstant('SListIndexError',SListIndexError);
    AddConstant('SMaskErr',SMaskErr);
    AddConstant('SMaskEditErr',SMaskEditErr);
    AddConstant('SMemoryStreamError',SMemoryStreamError);
    AddConstant('SNoComSupport',SNoComSupport);
    AddConstant('SNotPrinting',SNotPrinting);
    AddConstant('SNumberExpected',SNumberExpected);
    AddConstant('SParseError',SParseError);
    AddConstant('SComponentNameTooLong',SComponentNameTooLong);
    AddConstant('SPropertyException',SPropertyException);
    AddConstant('SPrinting',SPrinting);
    AddConstant('SReadError',SReadError);
    AddConstant('SReadOnlyProperty',SReadOnlyProperty);
    AddConstant('SRegCreateFailed',SRegCreateFailed);
    AddConstant('SRegGetDataFailed',SRegGetDataFailed);
    AddConstant('SRegisterError',SRegisterError);
    AddConstant('SRegSetDataFailed',SRegSetDataFailed);
    AddConstant('SResNotFound',SResNotFound);
    AddConstant('SSeekNotImplemented',SSeekNotImplemented);
    AddConstant('SSortedListError',SSortedListError);
    AddConstant('SStringExpected',SStringExpected);
    AddConstant('SSymbolExpected',SSymbolExpected);
    AddConstant('STimeEncodeError',STimeEncodeError);
    AddConstant('STooManyDeleted',STooManyDeleted);
    AddConstant('SUnknownGroup',SUnknownGroup);
    AddConstant('SUnknownProperty',SUnknownProperty);
    AddConstant('SWriteError',SWriteError);
    AddConstant('SStreamSetSize',SStreamSetSize);
    AddConstant('SThreadCreateError',SThreadCreateError);
    AddConstant('SThreadError',SThreadError);
    AddConstant('SInvalidDateDay',SInvalidDateDay);
    AddConstant('SInvalidDateWeek',SInvalidDateWeek);
    AddConstant('SInvalidDateMonthWeek',SInvalidDateMonthWeek);
    AddConstant('SInvalidDayOfWeekInMonth',SInvalidDayOfWeekInMonth);
    AddConstant('SInvalidJulianDate',SInvalidJulianDate);
    AddConstant('SMissingDateTimeField',SMissingDateTimeField);
    AddConstant('SConvIncompatibleTypes2',SConvIncompatibleTypes2);
    AddConstant('SConvIncompatibleTypes3',SConvIncompatibleTypes3);
    AddConstant('SConvIncompatibleTypes4',SConvIncompatibleTypes4);
    AddConstant('SConvUnknownType',SConvUnknownType);
    AddConstant('SConvDuplicateType',SConvDuplicateType);
    AddConstant('SConvUnknownFamily',SConvUnknownFamily);
    AddConstant('SConvDuplicateFamily',SConvDuplicateFamily);
    AddConstant('SConvUnknownDescription',SConvUnknownDescription);
    AddConstant('SConvIllegalType',SConvIllegalType);
    AddConstant('SConvIllegalFamily',SConvIllegalFamily);
    AddConstant('SConvFactorZero',SConvFactorZero);
    AddConstant('SConvStrParseError',SConvStrParseError);
    AddConstant('SFailedToCallConstructor',SFailedToCallConstructor);
    AddConstant('sWindowsSocketError',sWindowsSocketError);
    AddConstant('sAsyncSocketError',sAsyncSocketError);
    AddConstant('sNoAddress',sNoAddress);
    AddConstant('sCannotListenOnOpen',sCannotListenOnOpen);
    AddConstant('sCannotCreateSocket',sCannotCreateSocket);
    AddConstant('sSocketAlreadyOpen',sSocketAlreadyOpen);
    AddConstant('sCantChangeWhileActive',sCantChangeWhileActive);
    AddConstant('sSocketMustBeBlocking',sSocketMustBeBlocking);
    AddConstant('sSocketIOError',sSocketIOError);
    AddConstant('sSocketRead',sSocketRead);
    AddConstant('sSocketWrite',sSocketWrite);
  end;
end;

class function TatRTLConstsLibrary.LibraryName: string;
begin
  result := 'RTLConsts';
end;

initialization
  RegisterScripterLibrary(TatRTLConstsLibrary, True);

{$WARNINGS ON}

end.

