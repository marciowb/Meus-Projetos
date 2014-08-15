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
unit ap_DbConsts;

interface

uses
  DbConsts,
  atScript;

{$WARNINGS OFF}

type
  TatDbConstsLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatDbConstsLibrary.Init;
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
    AddConstant('SInvalidIntegerValue',SInvalidIntegerValue);
    AddConstant('SInvalidBoolValue',SInvalidBoolValue);
    AddConstant('SInvalidFloatValue',SInvalidFloatValue);
    AddConstant('SFieldTypeMismatch',SFieldTypeMismatch);
    AddConstant('SFieldSizeMismatch',SFieldSizeMismatch);
    AddConstant('SInvalidVarByteArray',SInvalidVarByteArray);
    AddConstant('SFieldOutOfRange',SFieldOutOfRange);
    AddConstant('SBCDOverflow',SBCDOverflow);
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
    AddConstant('SFirstRecord',SFirstRecord);
    AddConstant('SPriorRecord',SPriorRecord);
    AddConstant('SNextRecord',SNextRecord);
    AddConstant('SLastRecord',SLastRecord);
    AddConstant('SInsertRecord',SInsertRecord);
    AddConstant('SDeleteRecord',SDeleteRecord);
    AddConstant('SEditRecord',SEditRecord);
    AddConstant('SPostEdit',SPostEdit);
    AddConstant('SCancelEdit',SCancelEdit);
    AddConstant('SRefreshRecord',SRefreshRecord);
    AddConstant('SDeleteRecordQuestion',SDeleteRecordQuestion);
    AddConstant('SDeleteMultipleRecordsQuestion',SDeleteMultipleRecordsQuestion);
    AddConstant('SRecordNotFound',SRecordNotFound);
    AddConstant('SDataSourceFixed',SDataSourceFixed);
    AddConstant('SNotReplicatable',SNotReplicatable);
    AddConstant('SPropDefByLookup',SPropDefByLookup);
    AddConstant('STooManyColumns',STooManyColumns);
    AddConstant('SRemoteLogin',SRemoteLogin);
    AddConstant('SDataBindings',SDataBindings);
  end;
end;

class function TatDbConstsLibrary.LibraryName: string;
begin
  result := 'DbConsts';
end;

initialization
  RegisterScripterLibrary(TatDbConstsLibrary, True);

{$WARNINGS ON}

end.

