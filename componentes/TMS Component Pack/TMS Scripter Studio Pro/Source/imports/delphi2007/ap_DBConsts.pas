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
unit ap_DBConsts;

interface

uses
  DBConsts,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatDBConstsLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatDBConstsLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('SInvalidFieldSize',SInvalidFieldSize);
    AddConstant('SInvalidFieldKind',SInvalidFieldKind);
    AddConstant('SInvalidFieldRegistration',SInvalidFieldRegistration);
    AddConstant('SUnknownFieldType',SUnknownFieldType);
    AddConstant('SFieldNameMissing',SFieldNameMissing);
    AddConstant('SDuplicateFieldName',SDuplicateFieldName);
    AddConstant('SFieldNotFound',SFieldNotFound);
    AddConstant('SFieldAccessError',SFieldAccessError);
    AddConstant('SFieldValueError',SFieldValueError);
    AddConstant('SFieldRangeError',SFieldRangeError);
    AddConstant('SBcdFieldRangeError',SBcdFieldRangeError);
    AddConstant('SInvalidIntegerValue',SInvalidIntegerValue);
    AddConstant('SInvalidBoolValue',SInvalidBoolValue);
    AddConstant('SInvalidFloatValue',SInvalidFloatValue);
    AddConstant('SFieldTypeMismatch',SFieldTypeMismatch);
    AddConstant('SFieldSizeMismatch',SFieldSizeMismatch);
    AddConstant('SInvalidVarByteArray',SInvalidVarByteArray);
    AddConstant('SFieldOutOfRange',SFieldOutOfRange);
    AddConstant('SCantAdjustPrecision',SCantAdjustPrecision);
    AddConstant('SFieldRequired',SFieldRequired);
    AddConstant('SDataSetMissing',SDataSetMissing);
    AddConstant('SInvalidCalcType',SInvalidCalcType);
    AddConstant('SFieldReadOnly',SFieldReadOnly);
    AddConstant('SFieldIndexError',SFieldIndexError);
    AddConstant('SNoFieldIndexes',SNoFieldIndexes);
    AddConstant('SNotIndexField',SNotIndexField);
    AddConstant('SIndexFieldMissing',SIndexFieldMissing);
    AddConstant('SDuplicateIndexName',SDuplicateIndexName);
    AddConstant('SNoIndexForFields',SNoIndexForFields);
    AddConstant('SIndexNotFound',SIndexNotFound);
    AddConstant('SDuplicateName',SDuplicateName);
    AddConstant('SCircularDataLink',SCircularDataLink);
    AddConstant('SLookupInfoError',SLookupInfoError);
    AddConstant('SNewLookupFieldCaption',SNewLookupFieldCaption);
    AddConstant('SDataSourceChange',SDataSourceChange);
    AddConstant('SNoNestedMasterSource',SNoNestedMasterSource);
    AddConstant('SDataSetOpen',SDataSetOpen);
    AddConstant('SNotEditing',SNotEditing);
    AddConstant('SDataSetClosed',SDataSetClosed);
    AddConstant('SDataSetEmpty',SDataSetEmpty);
    AddConstant('SDataSetReadOnly',SDataSetReadOnly);
    AddConstant('SNestedDataSetClass',SNestedDataSetClass);
    AddConstant('SExprTermination',SExprTermination);
    AddConstant('SExprNameError',SExprNameError);
    AddConstant('SExprStringError',SExprStringError);
    AddConstant('SExprInvalidChar',SExprInvalidChar);
    AddConstant('SExprNoLParen',SExprNoLParen);
    AddConstant('SExprNoRParen',SExprNoRParen);
    AddConstant('SExprNoRParenOrComma',SExprNoRParenOrComma);
    AddConstant('SExprExpected',SExprExpected);
    AddConstant('SExprBadField',SExprBadField);
    AddConstant('SExprBadNullTest',SExprBadNullTest);
    AddConstant('SExprRangeError',SExprRangeError);
    AddConstant('SExprNotBoolean',SExprNotBoolean);
    AddConstant('SExprIncorrect',SExprIncorrect);
    AddConstant('SExprNothing',SExprNothing);
    AddConstant('SExprTypeMis',SExprTypeMis);
    AddConstant('SExprBadScope',SExprBadScope);
    AddConstant('SExprNoArith',SExprNoArith);
    AddConstant('SExprNotAgg',SExprNotAgg);
    AddConstant('SExprBadConst',SExprBadConst);
    AddConstant('SExprNoAggFilter',SExprNoAggFilter);
    AddConstant('SExprEmptyInList',SExprEmptyInList);
    AddConstant('SInvalidKeywordUse',SInvalidKeywordUse);
    AddConstant('STextFalse',STextFalse);
    AddConstant('STextTrue',STextTrue);
    AddConstant('SParameterNotFound',SParameterNotFound);
    AddConstant('SInvalidVersion',SInvalidVersion);
    AddConstant('SParamTooBig',SParamTooBig);
    AddConstant('SBadFieldType',SBadFieldType);
    AddConstant('SAggActive',SAggActive);
    AddConstant('SProviderSQLNotSupported',SProviderSQLNotSupported);
    AddConstant('SProviderExecuteNotSupported',SProviderExecuteNotSupported);
    AddConstant('SExprNoAggOnCalcs',SExprNoAggOnCalcs);
    AddConstant('SRecordChanged',SRecordChanged);
    AddConstant('SDataSetUnidirectional',SDataSetUnidirectional);
    AddConstant('SUnassignedVar',SUnassignedVar);
    AddConstant('SRecordNotFound',SRecordNotFound);
    AddConstant('SFileNameBlank',SFileNameBlank);
    AddConstant('SFieldNameTooLarge',SFieldNameTooLarge);
    AddConstant('SBcdOverflow',SBcdOverflow);
    AddConstant('SInvalidBcdValue',SInvalidBcdValue);
    AddConstant('SInvalidFormatType',SInvalidFormatType);
    AddConstant('SCouldNotParseTimeStamp',SCouldNotParseTimeStamp);
    AddConstant('SInvalidSqlTimeStamp',SInvalidSqlTimeStamp);
    AddConstant('SDeleteRecordQuestion',SDeleteRecordQuestion);
    AddConstant('SDeleteMultipleRecordsQuestion',SDeleteMultipleRecordsQuestion);
    AddConstant('STooManyColumns',STooManyColumns);
    AddConstant('SSkip',SSkip);
    AddConstant('SAbort',SAbort);
    AddConstant('SMerge',SMerge);
    AddConstant('SCorrect',SCorrect);
    AddConstant('SCancel',SCancel);
    AddConstant('SRefresh',SRefresh);
    AddConstant('SModified',SModified);
    AddConstant('SInserted',SInserted);
    AddConstant('SDeleted',SDeleted);
    AddConstant('SCaption',SCaption);
    AddConstant('SUnchanged',SUnchanged);
    AddConstant('SBinary',SBinary);
    AddConstant('SAdt',SAdt);
    AddConstant('SArray',SArray);
    AddConstant('SFieldName',SFieldName);
    AddConstant('SOriginal',SOriginal);
    AddConstant('SConflict',SConflict);
    AddConstant('SValue',SValue);
    AddConstant('SNoData',SNoData);
    AddConstant('SNew',SNew);
  end;
end;

class function TatDBConstsLibrary.LibraryName: string;
begin
  result := 'DBConsts';
end;

initialization
  RegisterScripterLibrary(TatDBConstsLibrary, True);

{$WARNINGS ON}

end.

