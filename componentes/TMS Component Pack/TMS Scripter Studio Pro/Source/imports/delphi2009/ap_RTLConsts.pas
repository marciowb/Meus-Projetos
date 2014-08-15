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
    AddConstant('SFCreateErrorEx',SFCreateErrorEx);
    AddConstant('SFixedColTooBig',SFixedColTooBig);
    AddConstant('SFixedRowTooBig',SFixedRowTooBig);
    AddConstant('SFOpenError',SFOpenError);
    AddConstant('SFOpenErrorEx',SFOpenErrorEx);
    AddConstant('SGridTooLarge',SGridTooLarge);
    AddConstant('SIdentifierExpected',SIdentifierExpected);
    AddConstant('SIndexOutOfRange',SIndexOutOfRange);
    AddConstant('SIniFileWriteError',SIniFileWriteError);
    AddConstant('SInvalidActionCreation',SInvalidActionCreation);
    AddConstant('SInvalidActionEnumeration',SInvalidActionEnumeration);
    AddConstant('SInvalidActionRegistration',SInvalidActionRegistration);
    AddConstant('SInvalidActionUnregistration',SInvalidActionUnregistration);
    AddConstant('SInvalidBinary',SInvalidBinary);
    AddConstant('SInvalidFileName',SInvalidFileName);
    AddConstant('SInvalidImage',SInvalidImage);
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
    AddConstant('SAnsiUTF8Expected',SAnsiUTF8Expected);
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
    AddConstant('STooManyDeleted',STooManyDeleted);
    AddConstant('SUnknownGroup',SUnknownGroup);
    AddConstant('SUnknownProperty',SUnknownProperty);
    AddConstant('SWriteError',SWriteError);
    AddConstant('SStreamSetSize',SStreamSetSize);
    AddConstant('SThreadCreateError',SThreadCreateError);
    AddConstant('SThreadError',SThreadError);
    AddConstant('SThreadExternalTerminate',SThreadExternalTerminate);
    AddConstant('SThreadExternalWait',SThreadExternalWait);
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
    AddConstant('SConvUnknownDescriptionWithPrefix',SConvUnknownDescriptionWithPrefix);
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
    AddConstant('SCmplxCouldNotParseImaginary',SCmplxCouldNotParseImaginary);
    AddConstant('SCmplxCouldNotParseSymbol',SCmplxCouldNotParseSymbol);
    AddConstant('SCmplxCouldNotParsePlus',SCmplxCouldNotParsePlus);
    AddConstant('SCmplxCouldNotParseReal',SCmplxCouldNotParseReal);
    AddConstant('SCmplxUnexpectedEOS',SCmplxUnexpectedEOS);
    AddConstant('SCmplxUnexpectedChars',SCmplxUnexpectedChars);
    AddConstant('SCmplxErrorSuffix',SCmplxErrorSuffix);
    AddConstant('hNoSystem',hNoSystem);
    AddConstant('hNoTopics',hNoTopics);
    AddConstant('hNoContext',hNoContext);
    AddConstant('hNoContextFound',hNoContextFound);
    AddConstant('hNothingFound',hNothingFound);
    AddConstant('hNoTableOfContents',hNoTableOfContents);
    AddConstant('hNoFilterViewer',hNoFilterViewer);
    AddConstant('sArgumentOutOfRange_InvalidHighSurrogate',sArgumentOutOfRange_InvalidHighSurrogate);
    AddConstant('sArgumentOutOfRange_InvalidLowSurrogate',sArgumentOutOfRange_InvalidLowSurrogate);
    AddConstant('sArgumentOutOfRange_Index',sArgumentOutOfRange_Index);
    AddConstant('sArgumentOutOfRange_StringIndex',sArgumentOutOfRange_StringIndex);
    AddConstant('sArgumentOutOfRange_InvalidUTF32',sArgumentOutOfRange_InvalidUTF32);
    AddConstant('sArgument_InvalidHighSurrogate',sArgument_InvalidHighSurrogate);
    AddConstant('sArgument_InvalidLowSurrogate',sArgument_InvalidLowSurrogate);
    AddConstant('sNoConstruct',sNoConstruct);
    AddConstant('sCannotCallAcquireOnConditionVar',sCannotCallAcquireOnConditionVar);
    AddConstant('SDistanceDescription',SDistanceDescription);
    AddConstant('SMicromicronsDescription',SMicromicronsDescription);
    AddConstant('SAngstromsDescription',SAngstromsDescription);
    AddConstant('SMillimicronsDescription',SMillimicronsDescription);
    AddConstant('SMicronsDescription',SMicronsDescription);
    AddConstant('SMillimetersDescription',SMillimetersDescription);
    AddConstant('SCentimetersDescription',SCentimetersDescription);
    AddConstant('SDecimetersDescription',SDecimetersDescription);
    AddConstant('SMetersDescription',SMetersDescription);
    AddConstant('SDecametersDescription',SDecametersDescription);
    AddConstant('SHectometersDescription',SHectometersDescription);
    AddConstant('SKilometersDescription',SKilometersDescription);
    AddConstant('SMegametersDescription',SMegametersDescription);
    AddConstant('SGigametersDescription',SGigametersDescription);
    AddConstant('SInchesDescription',SInchesDescription);
    AddConstant('SFeetDescription',SFeetDescription);
    AddConstant('SYardsDescription',SYardsDescription);
    AddConstant('SMilesDescription',SMilesDescription);
    AddConstant('SNauticalMilesDescription',SNauticalMilesDescription);
    AddConstant('SAstronomicalUnitsDescription',SAstronomicalUnitsDescription);
    AddConstant('SLightYearsDescription',SLightYearsDescription);
    AddConstant('SParsecsDescription',SParsecsDescription);
    AddConstant('SCubitsDescription',SCubitsDescription);
    AddConstant('SFathomsDescription',SFathomsDescription);
    AddConstant('SFurlongsDescription',SFurlongsDescription);
    AddConstant('SHandsDescription',SHandsDescription);
    AddConstant('SPacesDescription',SPacesDescription);
    AddConstant('SRodsDescription',SRodsDescription);
    AddConstant('SChainsDescription',SChainsDescription);
    AddConstant('SLinksDescription',SLinksDescription);
    AddConstant('SPicasDescription',SPicasDescription);
    AddConstant('SPointsDescription',SPointsDescription);
    AddConstant('SAreaDescription',SAreaDescription);
    AddConstant('SSquareMillimetersDescription',SSquareMillimetersDescription);
    AddConstant('SSquareCentimetersDescription',SSquareCentimetersDescription);
    AddConstant('SSquareDecimetersDescription',SSquareDecimetersDescription);
    AddConstant('SSquareMetersDescription',SSquareMetersDescription);
    AddConstant('SSquareDecametersDescription',SSquareDecametersDescription);
    AddConstant('SSquareHectometersDescription',SSquareHectometersDescription);
    AddConstant('SSquareKilometersDescription',SSquareKilometersDescription);
    AddConstant('SSquareInchesDescription',SSquareInchesDescription);
    AddConstant('SSquareFeetDescription',SSquareFeetDescription);
    AddConstant('SSquareYardsDescription',SSquareYardsDescription);
    AddConstant('SSquareMilesDescription',SSquareMilesDescription);
    AddConstant('SAcresDescription',SAcresDescription);
    AddConstant('SCentaresDescription',SCentaresDescription);
    AddConstant('SAresDescription',SAresDescription);
    AddConstant('SHectaresDescription',SHectaresDescription);
    AddConstant('SSquareRodsDescription',SSquareRodsDescription);
    AddConstant('SVolumeDescription',SVolumeDescription);
    AddConstant('SCubicMillimetersDescription',SCubicMillimetersDescription);
    AddConstant('SCubicCentimetersDescription',SCubicCentimetersDescription);
    AddConstant('SCubicDecimetersDescription',SCubicDecimetersDescription);
    AddConstant('SCubicMetersDescription',SCubicMetersDescription);
    AddConstant('SCubicDecametersDescription',SCubicDecametersDescription);
    AddConstant('SCubicHectometersDescription',SCubicHectometersDescription);
    AddConstant('SCubicKilometersDescription',SCubicKilometersDescription);
    AddConstant('SCubicInchesDescription',SCubicInchesDescription);
    AddConstant('SCubicFeetDescription',SCubicFeetDescription);
    AddConstant('SCubicYardsDescription',SCubicYardsDescription);
    AddConstant('SCubicMilesDescription',SCubicMilesDescription);
    AddConstant('SMilliLitersDescription',SMilliLitersDescription);
    AddConstant('SCentiLitersDescription',SCentiLitersDescription);
    AddConstant('SDeciLitersDescription',SDeciLitersDescription);
    AddConstant('SLitersDescription',SLitersDescription);
    AddConstant('SDecaLitersDescription',SDecaLitersDescription);
    AddConstant('SHectoLitersDescription',SHectoLitersDescription);
    AddConstant('SKiloLitersDescription',SKiloLitersDescription);
    AddConstant('SAcreFeetDescription',SAcreFeetDescription);
    AddConstant('SAcreInchesDescription',SAcreInchesDescription);
    AddConstant('SCordsDescription',SCordsDescription);
    AddConstant('SCordFeetDescription',SCordFeetDescription);
    AddConstant('SDecisteresDescription',SDecisteresDescription);
    AddConstant('SSteresDescription',SSteresDescription);
    AddConstant('SDecasteresDescription',SDecasteresDescription);
    AddConstant('SFluidGallonsDescription',SFluidGallonsDescription);
    AddConstant('SFluidQuartsDescription',SFluidQuartsDescription);
    AddConstant('SFluidPintsDescription',SFluidPintsDescription);
    AddConstant('SFluidCupsDescription',SFluidCupsDescription);
    AddConstant('SFluidGillsDescription',SFluidGillsDescription);
    AddConstant('SFluidOuncesDescription',SFluidOuncesDescription);
    AddConstant('SFluidTablespoonsDescription',SFluidTablespoonsDescription);
    AddConstant('SFluidTeaspoonsDescription',SFluidTeaspoonsDescription);
    AddConstant('SDryGallonsDescription',SDryGallonsDescription);
    AddConstant('SDryQuartsDescription',SDryQuartsDescription);
    AddConstant('SDryPintsDescription',SDryPintsDescription);
    AddConstant('SDryPecksDescription',SDryPecksDescription);
    AddConstant('SDryBucketsDescription',SDryBucketsDescription);
    AddConstant('SDryBushelsDescription',SDryBushelsDescription);
    AddConstant('SUKGallonsDescription',SUKGallonsDescription);
    AddConstant('SUKPottlesDescription',SUKPottlesDescription);
    AddConstant('SUKQuartsDescription',SUKQuartsDescription);
    AddConstant('SUKPintsDescription',SUKPintsDescription);
    AddConstant('SUKGillsDescription',SUKGillsDescription);
    AddConstant('SUKOuncesDescription',SUKOuncesDescription);
    AddConstant('SUKPecksDescription',SUKPecksDescription);
    AddConstant('SUKBucketsDescription',SUKBucketsDescription);
    AddConstant('SUKBushelsDescription',SUKBushelsDescription);
    AddConstant('SMassDescription',SMassDescription);
    AddConstant('SNanogramsDescription',SNanogramsDescription);
    AddConstant('SMicrogramsDescription',SMicrogramsDescription);
    AddConstant('SMilligramsDescription',SMilligramsDescription);
    AddConstant('SCentigramsDescription',SCentigramsDescription);
    AddConstant('SDecigramsDescription',SDecigramsDescription);
    AddConstant('SGramsDescription',SGramsDescription);
    AddConstant('SDecagramsDescription',SDecagramsDescription);
    AddConstant('SHectogramsDescription',SHectogramsDescription);
    AddConstant('SKilogramsDescription',SKilogramsDescription);
    AddConstant('SMetricTonsDescription',SMetricTonsDescription);
    AddConstant('SDramsDescription',SDramsDescription);
    AddConstant('SGrainsDescription',SGrainsDescription);
    AddConstant('STonsDescription',STonsDescription);
    AddConstant('SLongTonsDescription',SLongTonsDescription);
    AddConstant('SOuncesDescription',SOuncesDescription);
    AddConstant('SPoundsDescription',SPoundsDescription);
    AddConstant('SStonesDescription',SStonesDescription);
    AddConstant('STemperatureDescription',STemperatureDescription);
    AddConstant('SCelsiusDescription',SCelsiusDescription);
    AddConstant('SKelvinDescription',SKelvinDescription);
    AddConstant('SFahrenheitDescription',SFahrenheitDescription);
    AddConstant('SRankineDescription',SRankineDescription);
    AddConstant('SReaumurDescription',SReaumurDescription);
    AddConstant('STimeDescription',STimeDescription);
    AddConstant('SMilliSecondsDescription',SMilliSecondsDescription);
    AddConstant('SSecondsDescription',SSecondsDescription);
    AddConstant('SMinutesDescription',SMinutesDescription);
    AddConstant('SHoursDescription',SHoursDescription);
    AddConstant('SDaysDescription',SDaysDescription);
    AddConstant('SWeeksDescription',SWeeksDescription);
    AddConstant('SFortnightsDescription',SFortnightsDescription);
    AddConstant('SMonthsDescription',SMonthsDescription);
    AddConstant('SYearsDescription',SYearsDescription);
    AddConstant('SDecadesDescription',SDecadesDescription);
    AddConstant('SCenturiesDescription',SCenturiesDescription);
    AddConstant('SMillenniaDescription',SMillenniaDescription);
    AddConstant('SDateTimeDescription',SDateTimeDescription);
    AddConstant('SJulianDateDescription',SJulianDateDescription);
    AddConstant('SModifiedJulianDateDescription',SModifiedJulianDateDescription);
    AddConstant('SInvalidDate',SInvalidDate);
    AddConstant('SInvalidDateTime',SInvalidDateTime);
    AddConstant('SInvalidInteger',SInvalidInteger);
    AddConstant('SInvalidTime',SInvalidTime);
    AddConstant('STimeEncodeError',STimeEncodeError);
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

