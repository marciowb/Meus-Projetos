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
unit ap_DB;

interface

uses
  Windows,
  SysUtils,
  Classes,
  Variants,
  MaskUtils,
  SqlTimSt,
  FMTBcd,
  DB,
  ap_System,
  ap_FMTBcd,
  ap_SqlTimSt,
  atScript;

{$WARNINGS OFF}

type
  TatDBLibrary = class(TatScripterLibrary)
    procedure __EUpdateErrorCreate(AMachine: TatVirtualMachine);
    procedure __EUpdateErrorDestroy(AMachine: TatVirtualMachine);
    procedure __GetEUpdateErrorContext(AMachine: TatVirtualMachine);
    procedure __GetEUpdateErrorErrorCode(AMachine: TatVirtualMachine);
    procedure __GetEUpdateErrorPreviousError(AMachine: TatVirtualMachine);
    procedure __GetEUpdateErrorOriginalException(AMachine: TatVirtualMachine);
    procedure __TCustomConnectionCreate(AMachine: TatVirtualMachine);
    procedure __TCustomConnectionDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomConnectionOpen(AMachine: TatVirtualMachine);
    procedure __TCustomConnectionClose(AMachine: TatVirtualMachine);
    procedure __GetTCustomConnectionConnected(AMachine: TatVirtualMachine);
    procedure __SetTCustomConnectionConnected(AMachine: TatVirtualMachine);
    procedure __GetTCustomConnectionDataSets(AMachine: TatVirtualMachine);
    procedure __GetTCustomConnectionDataSetCount(AMachine: TatVirtualMachine);
    procedure __GetTCustomConnectionLoginPrompt(AMachine: TatVirtualMachine);
    procedure __SetTCustomConnectionLoginPrompt(AMachine: TatVirtualMachine);
    procedure __TDefCollectionFind(AMachine: TatVirtualMachine);
    procedure __TDefCollectionGetItemNames(AMachine: TatVirtualMachine);
    procedure __TDefCollectionIndexOf(AMachine: TatVirtualMachine);
    procedure __GetTDefCollectionDataSet(AMachine: TatVirtualMachine);
    procedure __GetTDefCollectionUpdated(AMachine: TatVirtualMachine);
    procedure __SetTDefCollectionUpdated(AMachine: TatVirtualMachine);
    procedure __TFieldDefCreate(AMachine: TatVirtualMachine);
    procedure __TFieldDefDestroy(AMachine: TatVirtualMachine);
    procedure __TFieldDefAddChild(AMachine: TatVirtualMachine);
    procedure __TFieldDefAssign(AMachine: TatVirtualMachine);
    procedure __TFieldDefCreateField(AMachine: TatVirtualMachine);
    procedure __TFieldDefHasChildDefs(AMachine: TatVirtualMachine);
    procedure __GetTFieldDefFieldNo(AMachine: TatVirtualMachine);
    procedure __SetTFieldDefFieldNo(AMachine: TatVirtualMachine);
    procedure __GetTFieldDefInternalCalcField(AMachine: TatVirtualMachine);
    procedure __SetTFieldDefInternalCalcField(AMachine: TatVirtualMachine);
    procedure __GetTFieldDefParentDef(AMachine: TatVirtualMachine);
    procedure __GetTFieldDefRequired(AMachine: TatVirtualMachine);
    procedure __SetTFieldDefRequired(AMachine: TatVirtualMachine);
    procedure __TFieldDefsCreate(AMachine: TatVirtualMachine);
    procedure __TFieldDefsAddFieldDef(AMachine: TatVirtualMachine);
    procedure __TFieldDefsFind(AMachine: TatVirtualMachine);
    procedure __TFieldDefsUpdate(AMachine: TatVirtualMachine);
    procedure __TFieldDefsAdd(AMachine: TatVirtualMachine);
    procedure __GetTFieldDefsHiddenFields(AMachine: TatVirtualMachine);
    procedure __SetTFieldDefsHiddenFields(AMachine: TatVirtualMachine);
    procedure __GetTFieldDefsItems(AMachine: TatVirtualMachine);
    procedure __SetTFieldDefsItems(AMachine: TatVirtualMachine);
    procedure __GetTFieldDefsParentDef(AMachine: TatVirtualMachine);
    procedure __TIndexDefCreate(AMachine: TatVirtualMachine);
    procedure __TIndexDefAssign(AMachine: TatVirtualMachine);
    procedure __GetTIndexDefFieldExpression(AMachine: TatVirtualMachine);
    procedure __TIndexDefsCreate(AMachine: TatVirtualMachine);
    procedure __TIndexDefsAddIndexDef(AMachine: TatVirtualMachine);
    procedure __TIndexDefsFind(AMachine: TatVirtualMachine);
    procedure __TIndexDefsUpdate(AMachine: TatVirtualMachine);
    procedure __TIndexDefsFindIndexForFields(AMachine: TatVirtualMachine);
    procedure __TIndexDefsGetIndexForFields(AMachine: TatVirtualMachine);
    procedure __TIndexDefsAdd(AMachine: TatVirtualMachine);
    procedure __GetTIndexDefsItems(AMachine: TatVirtualMachine);
    procedure __SetTIndexDefsItems(AMachine: TatVirtualMachine);
    procedure __TFlatListCreate(AMachine: TatVirtualMachine);
    procedure __TFlatListUpdate(AMachine: TatVirtualMachine);
    procedure __GetTFlatListDataSet(AMachine: TatVirtualMachine);
    procedure __TFieldDefListFieldByName(AMachine: TatVirtualMachine);
    procedure __TFieldDefListFind(AMachine: TatVirtualMachine);
    procedure __GetTFieldDefListFieldDefs(AMachine: TatVirtualMachine);
    procedure __TFieldListFieldByName(AMachine: TatVirtualMachine);
    procedure __TFieldListFind(AMachine: TatVirtualMachine);
    procedure __GetTFieldListFields(AMachine: TatVirtualMachine);
    procedure __TFieldsCreate(AMachine: TatVirtualMachine);
    procedure __TFieldsDestroy(AMachine: TatVirtualMachine);
    procedure __TFieldsAdd(AMachine: TatVirtualMachine);
    procedure __TFieldsCheckFieldName(AMachine: TatVirtualMachine);
    procedure __TFieldsCheckFieldNames(AMachine: TatVirtualMachine);
    procedure __TFieldsClear(AMachine: TatVirtualMachine);
    procedure __TFieldsFindField(AMachine: TatVirtualMachine);
    procedure __TFieldsFieldByName(AMachine: TatVirtualMachine);
    procedure __TFieldsFieldByNumber(AMachine: TatVirtualMachine);
    procedure __TFieldsGetFieldNames(AMachine: TatVirtualMachine);
    procedure __TFieldsIndexOf(AMachine: TatVirtualMachine);
    procedure __TFieldsRemove(AMachine: TatVirtualMachine);
    procedure __GetTFieldsCount(AMachine: TatVirtualMachine);
    procedure __GetTFieldsDataSet(AMachine: TatVirtualMachine);
    procedure __GetTFieldsFields(AMachine: TatVirtualMachine);
    procedure __SetTFieldsFields(AMachine: TatVirtualMachine);
    procedure __TLookupListCreate(AMachine: TatVirtualMachine);
    procedure __TLookupListDestroy(AMachine: TatVirtualMachine);
    procedure __TLookupListAdd(AMachine: TatVirtualMachine);
    procedure __TLookupListClear(AMachine: TatVirtualMachine);
    procedure __TLookupListValueOfKey(AMachine: TatVirtualMachine);
    procedure __TFieldCreate(AMachine: TatVirtualMachine);
    procedure __TFieldDestroy(AMachine: TatVirtualMachine);
    procedure __TFieldAssign(AMachine: TatVirtualMachine);
    procedure __TFieldAssignValue(AMachine: TatVirtualMachine);
    procedure __TFieldClear(AMachine: TatVirtualMachine);
    procedure __TFieldFocusControl(AMachine: TatVirtualMachine);
    procedure __TFieldGetParentComponent(AMachine: TatVirtualMachine);
    procedure __TFieldHasParent(AMachine: TatVirtualMachine);
    procedure __TFieldIsBlob(AMachine: TatVirtualMachine);
    procedure __TFieldIsValidChar(AMachine: TatVirtualMachine);
    procedure __TFieldRefreshLookupList(AMachine: TatVirtualMachine);
    procedure __TFieldSetFieldType(AMachine: TatVirtualMachine);
    procedure __GetTFieldAsBCD(AMachine: TatVirtualMachine);
    procedure __SetTFieldAsBCD(AMachine: TatVirtualMachine);
    procedure __GetTFieldAsBoolean(AMachine: TatVirtualMachine);
    procedure __SetTFieldAsBoolean(AMachine: TatVirtualMachine);
    procedure __GetTFieldAsCurrency(AMachine: TatVirtualMachine);
    procedure __SetTFieldAsCurrency(AMachine: TatVirtualMachine);
    procedure __GetTFieldAsDateTime(AMachine: TatVirtualMachine);
    procedure __SetTFieldAsDateTime(AMachine: TatVirtualMachine);
    procedure __GetTFieldAsSQLTimeStamp(AMachine: TatVirtualMachine);
    procedure __SetTFieldAsSQLTimeStamp(AMachine: TatVirtualMachine);
    procedure __GetTFieldAsFloat(AMachine: TatVirtualMachine);
    procedure __SetTFieldAsFloat(AMachine: TatVirtualMachine);
    procedure __GetTFieldAsInteger(AMachine: TatVirtualMachine);
    procedure __SetTFieldAsInteger(AMachine: TatVirtualMachine);
    procedure __GetTFieldAsString(AMachine: TatVirtualMachine);
    procedure __SetTFieldAsString(AMachine: TatVirtualMachine);
    procedure __GetTFieldAsVariant(AMachine: TatVirtualMachine);
    procedure __SetTFieldAsVariant(AMachine: TatVirtualMachine);
    procedure __GetTFieldAttributeSet(AMachine: TatVirtualMachine);
    procedure __SetTFieldAttributeSet(AMachine: TatVirtualMachine);
    procedure __GetTFieldCalculated(AMachine: TatVirtualMachine);
    procedure __SetTFieldCalculated(AMachine: TatVirtualMachine);
    procedure __GetTFieldCanModify(AMachine: TatVirtualMachine);
    procedure __GetTFieldCurValue(AMachine: TatVirtualMachine);
    procedure __GetTFieldDataSet(AMachine: TatVirtualMachine);
    procedure __SetTFieldDataSet(AMachine: TatVirtualMachine);
    procedure __GetTFieldDataSize(AMachine: TatVirtualMachine);
    procedure __GetTFieldDataType(AMachine: TatVirtualMachine);
    procedure __GetTFieldDisplayName(AMachine: TatVirtualMachine);
    procedure __GetTFieldDisplayText(AMachine: TatVirtualMachine);
    procedure __GetTFieldEditMask(AMachine: TatVirtualMachine);
    procedure __SetTFieldEditMask(AMachine: TatVirtualMachine);
    procedure __GetTFieldEditMaskPtr(AMachine: TatVirtualMachine);
    procedure __GetTFieldFieldNo(AMachine: TatVirtualMachine);
    procedure __GetTFieldFullName(AMachine: TatVirtualMachine);
    procedure __GetTFieldIsIndexField(AMachine: TatVirtualMachine);
    procedure __GetTFieldIsNull(AMachine: TatVirtualMachine);
    procedure __GetTFieldLookup(AMachine: TatVirtualMachine);
    procedure __SetTFieldLookup(AMachine: TatVirtualMachine);
    procedure __GetTFieldLookupList(AMachine: TatVirtualMachine);
    procedure __GetTFieldNewValue(AMachine: TatVirtualMachine);
    procedure __SetTFieldNewValue(AMachine: TatVirtualMachine);
    procedure __GetTFieldOffset(AMachine: TatVirtualMachine);
    procedure __GetTFieldOldValue(AMachine: TatVirtualMachine);
    procedure __GetTFieldParentField(AMachine: TatVirtualMachine);
    procedure __SetTFieldParentField(AMachine: TatVirtualMachine);
    procedure __GetTFieldSize(AMachine: TatVirtualMachine);
    procedure __SetTFieldSize(AMachine: TatVirtualMachine);
    procedure __GetTFieldText(AMachine: TatVirtualMachine);
    procedure __SetTFieldText(AMachine: TatVirtualMachine);
    procedure __GetTFieldValidChars(AMachine: TatVirtualMachine);
    procedure __SetTFieldValidChars(AMachine: TatVirtualMachine);
    procedure __GetTFieldValue(AMachine: TatVirtualMachine);
    procedure __SetTFieldValue(AMachine: TatVirtualMachine);
    procedure __TStringFieldCreate(AMachine: TatVirtualMachine);
    procedure __GetTStringFieldValue(AMachine: TatVirtualMachine);
    procedure __SetTStringFieldValue(AMachine: TatVirtualMachine);
    procedure __TWideStringFieldCreate(AMachine: TatVirtualMachine);
    procedure __GetTWideStringFieldValue(AMachine: TatVirtualMachine);
    procedure __SetTWideStringFieldValue(AMachine: TatVirtualMachine);
    procedure __TNumericFieldCreate(AMachine: TatVirtualMachine);
    procedure __TIntegerFieldCreate(AMachine: TatVirtualMachine);
    procedure __GetTIntegerFieldValue(AMachine: TatVirtualMachine);
    procedure __SetTIntegerFieldValue(AMachine: TatVirtualMachine);
    procedure __TSmallintFieldCreate(AMachine: TatVirtualMachine);
    procedure __TLargeintFieldCreate(AMachine: TatVirtualMachine);
    procedure __GetTLargeintFieldAsLargeInt(AMachine: TatVirtualMachine);
    procedure __SetTLargeintFieldAsLargeInt(AMachine: TatVirtualMachine);
    procedure __GetTLargeintFieldValue(AMachine: TatVirtualMachine);
    procedure __SetTLargeintFieldValue(AMachine: TatVirtualMachine);
    procedure __TWordFieldCreate(AMachine: TatVirtualMachine);
    procedure __TAutoIncFieldCreate(AMachine: TatVirtualMachine);
    procedure __TFloatFieldCreate(AMachine: TatVirtualMachine);
    procedure __GetTFloatFieldValue(AMachine: TatVirtualMachine);
    procedure __SetTFloatFieldValue(AMachine: TatVirtualMachine);
    procedure __TCurrencyFieldCreate(AMachine: TatVirtualMachine);
    procedure __TBooleanFieldCreate(AMachine: TatVirtualMachine);
    procedure __GetTBooleanFieldValue(AMachine: TatVirtualMachine);
    procedure __SetTBooleanFieldValue(AMachine: TatVirtualMachine);
    procedure __TDateTimeFieldCreate(AMachine: TatVirtualMachine);
    procedure __GetTDateTimeFieldValue(AMachine: TatVirtualMachine);
    procedure __SetTDateTimeFieldValue(AMachine: TatVirtualMachine);
    procedure __TSQLTimeStampFieldCreate(AMachine: TatVirtualMachine);
    procedure __GetTSQLTimeStampFieldValue(AMachine: TatVirtualMachine);
    procedure __SetTSQLTimeStampFieldValue(AMachine: TatVirtualMachine);
    procedure __TDateFieldCreate(AMachine: TatVirtualMachine);
    procedure __TTimeFieldCreate(AMachine: TatVirtualMachine);
    procedure __TBinaryFieldCreate(AMachine: TatVirtualMachine);
    procedure __TBytesFieldCreate(AMachine: TatVirtualMachine);
    procedure __TVarBytesFieldCreate(AMachine: TatVirtualMachine);
    procedure __TBCDFieldCreate(AMachine: TatVirtualMachine);
    procedure __GetTBCDFieldValue(AMachine: TatVirtualMachine);
    procedure __SetTBCDFieldValue(AMachine: TatVirtualMachine);
    procedure __TFMTBCDFieldCreate(AMachine: TatVirtualMachine);
    procedure __GetTFMTBCDFieldValue(AMachine: TatVirtualMachine);
    procedure __SetTFMTBCDFieldValue(AMachine: TatVirtualMachine);
    procedure __TBlobFieldCreate(AMachine: TatVirtualMachine);
    procedure __TBlobFieldAssign(AMachine: TatVirtualMachine);
    procedure __TBlobFieldClear(AMachine: TatVirtualMachine);
    procedure __TBlobFieldIsBlob(AMachine: TatVirtualMachine);
    procedure __TBlobFieldLoadFromFile(AMachine: TatVirtualMachine);
    procedure __TBlobFieldLoadFromStream(AMachine: TatVirtualMachine);
    procedure __TBlobFieldSaveToFile(AMachine: TatVirtualMachine);
    procedure __TBlobFieldSaveToStream(AMachine: TatVirtualMachine);
    procedure __TBlobFieldSetFieldType(AMachine: TatVirtualMachine);
    procedure __GetTBlobFieldBlobSize(AMachine: TatVirtualMachine);
    procedure __GetTBlobFieldModified(AMachine: TatVirtualMachine);
    procedure __SetTBlobFieldModified(AMachine: TatVirtualMachine);
    procedure __GetTBlobFieldValue(AMachine: TatVirtualMachine);
    procedure __SetTBlobFieldValue(AMachine: TatVirtualMachine);
    procedure __GetTBlobFieldTransliterate(AMachine: TatVirtualMachine);
    procedure __SetTBlobFieldTransliterate(AMachine: TatVirtualMachine);
    procedure __TMemoFieldCreate(AMachine: TatVirtualMachine);
    procedure __TGraphicFieldCreate(AMachine: TatVirtualMachine);
    procedure __TObjectFieldCreate(AMachine: TatVirtualMachine);
    procedure __TObjectFieldDestroy(AMachine: TatVirtualMachine);
    procedure __GetTObjectFieldFieldCount(AMachine: TatVirtualMachine);
    procedure __GetTObjectFieldFields(AMachine: TatVirtualMachine);
    procedure __GetTObjectFieldFieldValues(AMachine: TatVirtualMachine);
    procedure __SetTObjectFieldFieldValues(AMachine: TatVirtualMachine);
    procedure __GetTObjectFieldUnNamed(AMachine: TatVirtualMachine);
    procedure __TADTFieldCreate(AMachine: TatVirtualMachine);
    procedure __TArrayFieldCreate(AMachine: TatVirtualMachine);
    procedure __TDataSetFieldCreate(AMachine: TatVirtualMachine);
    procedure __TDataSetFieldDestroy(AMachine: TatVirtualMachine);
    procedure __GetTDataSetFieldNestedDataSet(AMachine: TatVirtualMachine);
    procedure __TReferenceFieldCreate(AMachine: TatVirtualMachine);
    procedure __TReferenceFieldAssign(AMachine: TatVirtualMachine);
    procedure __TVariantFieldCreate(AMachine: TatVirtualMachine);
    procedure __TInterfaceFieldCreate(AMachine: TatVirtualMachine);
    procedure __TIDispatchFieldCreate(AMachine: TatVirtualMachine);
    procedure __TGuidFieldCreate(AMachine: TatVirtualMachine);
    procedure __GetTGuidFieldAsGuid(AMachine: TatVirtualMachine);
    procedure __SetTGuidFieldAsGuid(AMachine: TatVirtualMachine);
    procedure __TAggregateFieldCreate(AMachine: TatVirtualMachine);
    procedure __GetTAggregateFieldResultType(AMachine: TatVirtualMachine);
    procedure __SetTAggregateFieldResultType(AMachine: TatVirtualMachine);
    procedure __TDataLinkCreate(AMachine: TatVirtualMachine);
    procedure __TDataLinkDestroy(AMachine: TatVirtualMachine);
    procedure __TDataLinkEdit(AMachine: TatVirtualMachine);
    procedure __TDataLinkExecuteAction(AMachine: TatVirtualMachine);
    procedure __TDataLinkUpdateAction(AMachine: TatVirtualMachine);
    procedure __TDataLinkUpdateRecord(AMachine: TatVirtualMachine);
    procedure __GetTDataLinkActive(AMachine: TatVirtualMachine);
    procedure __GetTDataLinkActiveRecord(AMachine: TatVirtualMachine);
    procedure __SetTDataLinkActiveRecord(AMachine: TatVirtualMachine);
    procedure __GetTDataLinkBOF(AMachine: TatVirtualMachine);
    procedure __GetTDataLinkBufferCount(AMachine: TatVirtualMachine);
    procedure __SetTDataLinkBufferCount(AMachine: TatVirtualMachine);
    procedure __GetTDataLinkDataSet(AMachine: TatVirtualMachine);
    procedure __GetTDataLinkDataSource(AMachine: TatVirtualMachine);
    procedure __SetTDataLinkDataSource(AMachine: TatVirtualMachine);
    procedure __GetTDataLinkDataSourceFixed(AMachine: TatVirtualMachine);
    procedure __SetTDataLinkDataSourceFixed(AMachine: TatVirtualMachine);
    procedure __GetTDataLinkEditing(AMachine: TatVirtualMachine);
    procedure __GetTDataLinkEof(AMachine: TatVirtualMachine);
    procedure __GetTDataLinkReadOnly(AMachine: TatVirtualMachine);
    procedure __SetTDataLinkReadOnly(AMachine: TatVirtualMachine);
    procedure __GetTDataLinkRecordCount(AMachine: TatVirtualMachine);
    procedure __GetTDetailDataLinkDetailDataSet(AMachine: TatVirtualMachine);
    procedure __TMasterDataLinkCreate(AMachine: TatVirtualMachine);
    procedure __TMasterDataLinkDestroy(AMachine: TatVirtualMachine);
    procedure __GetTMasterDataLinkFieldNames(AMachine: TatVirtualMachine);
    procedure __SetTMasterDataLinkFieldNames(AMachine: TatVirtualMachine);
    procedure __GetTMasterDataLinkFields(AMachine: TatVirtualMachine);
    procedure __TDataSourceCreate(AMachine: TatVirtualMachine);
    procedure __TDataSourceDestroy(AMachine: TatVirtualMachine);
    procedure __TDataSourceEdit(AMachine: TatVirtualMachine);
    procedure __TDataSourceIsLinkedTo(AMachine: TatVirtualMachine);
    procedure __GetTDataSourceState(AMachine: TatVirtualMachine);
    procedure __TDataSetDesignerCreate(AMachine: TatVirtualMachine);
    procedure __TDataSetDesignerDestroy(AMachine: TatVirtualMachine);
    procedure __TDataSetDesignerBeginDesign(AMachine: TatVirtualMachine);
    procedure __TDataSetDesignerDataEvent(AMachine: TatVirtualMachine);
    procedure __TDataSetDesignerEndDesign(AMachine: TatVirtualMachine);
    procedure __GetTDataSetDesignerDataSet(AMachine: TatVirtualMachine);
    procedure __TCheckConstraintAssign(AMachine: TatVirtualMachine);
    procedure __TCheckConstraintGetDisplayName(AMachine: TatVirtualMachine);
    procedure __TCheckConstraintsCreate(AMachine: TatVirtualMachine);
    procedure __TCheckConstraintsAdd(AMachine: TatVirtualMachine);
    procedure __GetTCheckConstraintsItems(AMachine: TatVirtualMachine);
    procedure __SetTCheckConstraintsItems(AMachine: TatVirtualMachine);
    procedure __TParamCreate(AMachine: TatVirtualMachine);
    procedure __TParamAssign(AMachine: TatVirtualMachine);
    procedure __TParamAssignField(AMachine: TatVirtualMachine);
    procedure __TParamAssignFieldValue(AMachine: TatVirtualMachine);
    procedure __TParamClear(AMachine: TatVirtualMachine);
    procedure __TParamGetDataSize(AMachine: TatVirtualMachine);
    procedure __TParamLoadFromFile(AMachine: TatVirtualMachine);
    procedure __TParamLoadFromStream(AMachine: TatVirtualMachine);
    procedure __GetTParamAsBCD(AMachine: TatVirtualMachine);
    procedure __SetTParamAsBCD(AMachine: TatVirtualMachine);
    procedure __GetTParamAsFMTBCD(AMachine: TatVirtualMachine);
    procedure __SetTParamAsFMTBCD(AMachine: TatVirtualMachine);
    procedure __GetTParamAsBlob(AMachine: TatVirtualMachine);
    procedure __SetTParamAsBlob(AMachine: TatVirtualMachine);
    procedure __GetTParamAsBoolean(AMachine: TatVirtualMachine);
    procedure __SetTParamAsBoolean(AMachine: TatVirtualMachine);
    procedure __GetTParamAsCurrency(AMachine: TatVirtualMachine);
    procedure __SetTParamAsCurrency(AMachine: TatVirtualMachine);
    procedure __GetTParamAsDate(AMachine: TatVirtualMachine);
    procedure __SetTParamAsDate(AMachine: TatVirtualMachine);
    procedure __GetTParamAsDateTime(AMachine: TatVirtualMachine);
    procedure __SetTParamAsDateTime(AMachine: TatVirtualMachine);
    procedure __GetTParamAsFloat(AMachine: TatVirtualMachine);
    procedure __SetTParamAsFloat(AMachine: TatVirtualMachine);
    procedure __GetTParamAsInteger(AMachine: TatVirtualMachine);
    procedure __SetTParamAsInteger(AMachine: TatVirtualMachine);
    procedure __GetTParamAsSmallInt(AMachine: TatVirtualMachine);
    procedure __SetTParamAsSmallInt(AMachine: TatVirtualMachine);
    procedure __GetTParamAsSQLTimeStamp(AMachine: TatVirtualMachine);
    procedure __SetTParamAsSQLTimeStamp(AMachine: TatVirtualMachine);
    procedure __GetTParamAsMemo(AMachine: TatVirtualMachine);
    procedure __SetTParamAsMemo(AMachine: TatVirtualMachine);
    procedure __GetTParamAsString(AMachine: TatVirtualMachine);
    procedure __SetTParamAsString(AMachine: TatVirtualMachine);
    procedure __GetTParamAsTime(AMachine: TatVirtualMachine);
    procedure __SetTParamAsTime(AMachine: TatVirtualMachine);
    procedure __GetTParamAsWord(AMachine: TatVirtualMachine);
    procedure __SetTParamAsWord(AMachine: TatVirtualMachine);
    procedure __GetTParamBound(AMachine: TatVirtualMachine);
    procedure __SetTParamBound(AMachine: TatVirtualMachine);
    procedure __GetTParamIsNull(AMachine: TatVirtualMachine);
    procedure __GetTParamNativeStr(AMachine: TatVirtualMachine);
    procedure __SetTParamNativeStr(AMachine: TatVirtualMachine);
    procedure __GetTParamText(AMachine: TatVirtualMachine);
    procedure __SetTParamText(AMachine: TatVirtualMachine);
    procedure __TParamsCreate(AMachine: TatVirtualMachine);
    procedure __TParamsAssignValues(AMachine: TatVirtualMachine);
    procedure __TParamsAddParam(AMachine: TatVirtualMachine);
    procedure __TParamsRemoveParam(AMachine: TatVirtualMachine);
    procedure __TParamsCreateParam(AMachine: TatVirtualMachine);
    procedure __TParamsGetParamList(AMachine: TatVirtualMachine);
    procedure __TParamsIsEqual(AMachine: TatVirtualMachine);
    procedure __TParamsParseSQL(AMachine: TatVirtualMachine);
    procedure __TParamsParamByName(AMachine: TatVirtualMachine);
    procedure __TParamsFindParam(AMachine: TatVirtualMachine);
    procedure __GetTParamsItems(AMachine: TatVirtualMachine);
    procedure __SetTParamsItems(AMachine: TatVirtualMachine);
    procedure __GetTParamsParamValues(AMachine: TatVirtualMachine);
    procedure __SetTParamsParamValues(AMachine: TatVirtualMachine);
    procedure __TDataSetCreate(AMachine: TatVirtualMachine);
    procedure __TDataSetDestroy(AMachine: TatVirtualMachine);
    procedure __TDataSetActiveBuffer(AMachine: TatVirtualMachine);
    procedure __TDataSetAppend(AMachine: TatVirtualMachine);
    procedure __TDataSetCancel(AMachine: TatVirtualMachine);
    procedure __TDataSetCheckBrowseMode(AMachine: TatVirtualMachine);
    procedure __TDataSetClearFields(AMachine: TatVirtualMachine);
    procedure __TDataSetClose(AMachine: TatVirtualMachine);
    procedure __TDataSetControlsDisabled(AMachine: TatVirtualMachine);
    procedure __TDataSetCreateBlobStream(AMachine: TatVirtualMachine);
    procedure __TDataSetCursorPosChanged(AMachine: TatVirtualMachine);
    procedure __TDataSetDelete(AMachine: TatVirtualMachine);
    procedure __TDataSetDisableControls(AMachine: TatVirtualMachine);
    procedure __TDataSetEdit(AMachine: TatVirtualMachine);
    procedure __TDataSetEnableControls(AMachine: TatVirtualMachine);
    procedure __TDataSetFieldByName(AMachine: TatVirtualMachine);
    procedure __TDataSetFindField(AMachine: TatVirtualMachine);
    procedure __TDataSetFindFirst(AMachine: TatVirtualMachine);
    procedure __TDataSetFindLast(AMachine: TatVirtualMachine);
    procedure __TDataSetFindNext(AMachine: TatVirtualMachine);
    procedure __TDataSetFindPrior(AMachine: TatVirtualMachine);
    procedure __TDataSetFirst(AMachine: TatVirtualMachine);
    procedure __TDataSetGetCurrentRecord(AMachine: TatVirtualMachine);
    procedure __TDataSetGetDetailDataSets(AMachine: TatVirtualMachine);
    procedure __TDataSetGetDetailLinkFields(AMachine: TatVirtualMachine);
    procedure __TDataSetGetFieldList(AMachine: TatVirtualMachine);
    procedure __TDataSetGetFieldNames(AMachine: TatVirtualMachine);
    procedure __TDataSetInsert(AMachine: TatVirtualMachine);
    procedure __TDataSetIsEmpty(AMachine: TatVirtualMachine);
    procedure __TDataSetIsLinkedTo(AMachine: TatVirtualMachine);
    procedure __TDataSetIsSequenced(AMachine: TatVirtualMachine);
    procedure __TDataSetLast(AMachine: TatVirtualMachine);
    procedure __TDataSetLocate(AMachine: TatVirtualMachine);
    procedure __TDataSetLookup(AMachine: TatVirtualMachine);
    procedure __TDataSetMoveBy(AMachine: TatVirtualMachine);
    procedure __TDataSetNext(AMachine: TatVirtualMachine);
    procedure __TDataSetOpen(AMachine: TatVirtualMachine);
    procedure __TDataSetPost(AMachine: TatVirtualMachine);
    procedure __TDataSetPrior(AMachine: TatVirtualMachine);
    procedure __TDataSetRefresh(AMachine: TatVirtualMachine);
    procedure __TDataSetResync(AMachine: TatVirtualMachine);
    procedure __TDataSetTranslate(AMachine: TatVirtualMachine);
    procedure __TDataSetUpdateCursorPos(AMachine: TatVirtualMachine);
    procedure __TDataSetUpdateRecord(AMachine: TatVirtualMachine);
    procedure __TDataSetUpdateStatus(AMachine: TatVirtualMachine);
    procedure __GetTDataSetAggFields(AMachine: TatVirtualMachine);
    procedure __GetTDataSetBof(AMachine: TatVirtualMachine);
    procedure __GetTDataSetBookmark(AMachine: TatVirtualMachine);
    procedure __SetTDataSetBookmark(AMachine: TatVirtualMachine);
    procedure __GetTDataSetCanModify(AMachine: TatVirtualMachine);
    procedure __GetTDataSetDataSetField(AMachine: TatVirtualMachine);
    procedure __SetTDataSetDataSetField(AMachine: TatVirtualMachine);
    procedure __GetTDataSetDataSource(AMachine: TatVirtualMachine);
    procedure __GetTDataSetDefaultFields(AMachine: TatVirtualMachine);
    procedure __GetTDataSetDesigner(AMachine: TatVirtualMachine);
    procedure __GetTDataSetEof(AMachine: TatVirtualMachine);
    procedure __GetTDataSetBlockReadSize(AMachine: TatVirtualMachine);
    procedure __SetTDataSetBlockReadSize(AMachine: TatVirtualMachine);
    procedure __GetTDataSetFieldCount(AMachine: TatVirtualMachine);
    procedure __GetTDataSetFieldDefs(AMachine: TatVirtualMachine);
    procedure __SetTDataSetFieldDefs(AMachine: TatVirtualMachine);
    procedure __GetTDataSetFieldDefList(AMachine: TatVirtualMachine);
    procedure __GetTDataSetFields(AMachine: TatVirtualMachine);
    procedure __GetTDataSetFieldList(AMachine: TatVirtualMachine);
    procedure __GetTDataSetFieldValues(AMachine: TatVirtualMachine);
    procedure __SetTDataSetFieldValues(AMachine: TatVirtualMachine);
    procedure __GetTDataSetFound(AMachine: TatVirtualMachine);
    procedure __GetTDataSetIsUniDirectional(AMachine: TatVirtualMachine);
    procedure __GetTDataSetModified(AMachine: TatVirtualMachine);
    procedure __GetTDataSetObjectView(AMachine: TatVirtualMachine);
    procedure __SetTDataSetObjectView(AMachine: TatVirtualMachine);
    procedure __GetTDataSetRecordCount(AMachine: TatVirtualMachine);
    procedure __GetTDataSetRecNo(AMachine: TatVirtualMachine);
    procedure __SetTDataSetRecNo(AMachine: TatVirtualMachine);
    procedure __GetTDataSetRecordSize(AMachine: TatVirtualMachine);
    procedure __GetTDataSetSparseArrays(AMachine: TatVirtualMachine);
    procedure __SetTDataSetSparseArrays(AMachine: TatVirtualMachine);
    procedure __GetTDataSetState(AMachine: TatVirtualMachine);
    procedure __GetTDataSetFilter(AMachine: TatVirtualMachine);
    procedure __SetTDataSetFilter(AMachine: TatVirtualMachine);
    procedure __GetTDataSetFiltered(AMachine: TatVirtualMachine);
    procedure __SetTDataSetFiltered(AMachine: TatVirtualMachine);
    procedure __GetTDataSetFilterOptions(AMachine: TatVirtualMachine);
    procedure __SetTDataSetFilterOptions(AMachine: TatVirtualMachine);
    procedure __GetTDataSetActive(AMachine: TatVirtualMachine);
    procedure __SetTDataSetActive(AMachine: TatVirtualMachine);
    procedure __GetTDataSetAutoCalcFields(AMachine: TatVirtualMachine);
    procedure __SetTDataSetAutoCalcFields(AMachine: TatVirtualMachine);
    procedure __ExtractFieldName(AMachine: TatVirtualMachine);
    procedure __DatabaseError(AMachine: TatVirtualMachine);
    procedure __DisposeMem(AMachine: TatVirtualMachine);
    procedure __GetFieldProperty(AMachine: TatVirtualMachine);
    procedure __VarTypeToDataType(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  EDatabaseErrorClass = class of EDatabaseError;
  EUpdateErrorClass = class of EUpdateError;
  TCustomConnectionClass = class of TCustomConnection;
  TNamedItemClass = class of TNamedItem;
  TDefCollectionClass = class of TDefCollection;
  TFieldDefClass = class of TFieldDef;
  TFieldDefsClass = class of TFieldDefs;
  TIndexDefClass = class of TIndexDef;
  TIndexDefsClass = class of TIndexDefs;
  TFlatListClass = class of TFlatList;
  TFieldDefListClass = class of TFieldDefList;
  TFieldListClass = class of TFieldList;
  TFieldsClass = class of TFields;
  TLookupListClass = class of TLookupList;
  TFieldClass = class of TField;
  TStringFieldClass = class of TStringField;
  TWideStringFieldClass = class of TWideStringField;
  TNumericFieldClass = class of TNumericField;
  TIntegerFieldClass = class of TIntegerField;
  TSmallintFieldClass = class of TSmallintField;
  TLargeintFieldClass = class of TLargeintField;
  TWordFieldClass = class of TWordField;
  TAutoIncFieldClass = class of TAutoIncField;
  TFloatFieldClass = class of TFloatField;
  TCurrencyFieldClass = class of TCurrencyField;
  TBooleanFieldClass = class of TBooleanField;
  TDateTimeFieldClass = class of TDateTimeField;
  TSQLTimeStampFieldClass = class of TSQLTimeStampField;
  TDateFieldClass = class of TDateField;
  TTimeFieldClass = class of TTimeField;
  TBinaryFieldClass = class of TBinaryField;
  TBytesFieldClass = class of TBytesField;
  TVarBytesFieldClass = class of TVarBytesField;
  TBCDFieldClass = class of TBCDField;
  TFMTBCDFieldClass = class of TFMTBCDField;
  TBlobFieldClass = class of TBlobField;
  TMemoFieldClass = class of TMemoField;
  TGraphicFieldClass = class of TGraphicField;
  TObjectFieldClass = class of TObjectField;
  TADTFieldClass = class of TADTField;
  TArrayFieldClass = class of TArrayField;
  TDataSetFieldClass = class of TDataSetField;
  TReferenceFieldClass = class of TReferenceField;
  TVariantFieldClass = class of TVariantField;
  TInterfaceFieldClass = class of TInterfaceField;
  TIDispatchFieldClass = class of TIDispatchField;
  TGuidFieldClass = class of TGuidField;
  TAggregateFieldClass = class of TAggregateField;
  TDataLinkClass = class of TDataLink;
  TDetailDataLinkClass = class of TDetailDataLink;
  TMasterDataLinkClass = class of TMasterDataLink;
  TDataSourceClass = class of TDataSource;
  TDataSetDesignerClass = class of TDataSetDesigner;
  TCheckConstraintClass = class of TCheckConstraint;
  TCheckConstraintsClass = class of TCheckConstraints;
  TParamClass = class of TParam;
  TParamsClass = class of TParams;
  TDataSetClass = class of TDataSet;

  TatDBDispatcher = class(TatEventDispatcher)
  private
    procedure __TUpdateErrorEvent( DataSet: TDataSet;  E: EDatabaseError;  UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
    procedure __TUpdateRecordEvent( DataSet: TDataSet;  UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
    procedure __TLoginEvent( Sender: TObject;  Username: string;  Password: string);
    procedure __TConnectChangeEvent( Sender: TObject;  Connecting: Boolean);
    procedure __TDefUpdateMethod();
    procedure __TFieldNotifyEvent( Sender: TField);
    procedure __TFieldGetTextEvent( Sender: TField; var Text: string;  DisplayText: Boolean);
    procedure __TFieldSetTextEvent( Sender: TField; const Text: string);
    procedure __TDataChangeEvent( Sender: TObject;  Field: TField);
    procedure __TDataSetNotifyEvent( DataSet: TDataSet);
    procedure __TDataSetErrorEvent( DataSet: TDataSet;  E: EDatabaseError; var Action: TDataAction);
    procedure __TFilterRecordEvent( DataSet: TDataSet; var Accept: Boolean);
  end;

  TLookupListEntryWrapper = class(TatRecordWrapper)
  private
    FKey: Variant;
    FValue: Variant;
  public
    constructor Create(ARecord: TLookupListEntry);
    function ObjToRec: TLookupListEntry;
  published
    property Key: Variant read FKey write FKey;
    property Value: Variant read FValue write FValue;
  end;
  
  TPacketAttributeWrapper = class(TatRecordWrapper)
  private
    FName: string;
    FValue: OleVariant;
    FIncludeInDelta: Boolean;
  public
    constructor Create(ARecord: TPacketAttribute);
    function ObjToRec: TPacketAttribute;
  published
    property Name: string read FName write FName;
    property Value: OleVariant read FValue write FValue;
    property IncludeInDelta: Boolean read FIncludeInDelta write FIncludeInDelta;
  end;
  
  TDateTimeRecWrapper = class(TatRecordWrapper)
  private
    FDate: Longint;
    FTime: Longint;
    FDateTime: TDateTimeAlias;
  public
    constructor Create(ARecord: TDateTimeRec);
    function ObjToRec: TDateTimeRec;
  published
    property Date: Longint read FDate write FDate;
    property Time: Longint read FTime write FTime;
    property DateTime: TDateTimeAlias read FDateTime write FDateTime;
  end;
  

implementation

constructor TLookupListEntryWrapper.Create(ARecord: TLookupListEntry);
begin
  inherited Create;
  FKey := ARecord.Key;
  FValue := ARecord.Value;
end;

function TLookupListEntryWrapper.ObjToRec: TLookupListEntry;
begin
  result.Key := FKey;
  result.Value := FValue;
end;

constructor TPacketAttributeWrapper.Create(ARecord: TPacketAttribute);
begin
  inherited Create;
  FName := ARecord.Name;
  FValue := ARecord.Value;
  FIncludeInDelta := ARecord.IncludeInDelta;
end;

function TPacketAttributeWrapper.ObjToRec: TPacketAttribute;
begin
  result.Name := FName;
  result.Value := FValue;
  result.IncludeInDelta := FIncludeInDelta;
end;

constructor TDateTimeRecWrapper.Create(ARecord: TDateTimeRec);
begin
  inherited Create;
  FDate := ARecord.Date;
  FTime := ARecord.Time;
  FDateTime := ARecord.DateTime;
end;

function TDateTimeRecWrapper.ObjToRec: TDateTimeRec;
begin
  result.Date := FDate;
  result.Time := FTime;
  result.DateTime := FDateTime;
end;



procedure TatDBLibrary.__EUpdateErrorCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(EUpdateErrorClass(CurrentClass.ClassRef).Create(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),Exception(Integer(GetInputArg(4)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__EUpdateErrorDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    EUpdateError(CurrentObject).Destroy;
  end;
end;

procedure TatDBLibrary.__GetEUpdateErrorContext(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(EUpdateError(CurrentObject).Context);
  end;
end;

procedure TatDBLibrary.__GetEUpdateErrorErrorCode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(EUpdateError(CurrentObject).ErrorCode));
  end;
end;

procedure TatDBLibrary.__GetEUpdateErrorPreviousError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(EUpdateError(CurrentObject).PreviousError));
  end;
end;

procedure TatDBLibrary.__GetEUpdateErrorOriginalException(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(EUpdateError(CurrentObject).OriginalException));
  end;
end;

procedure TatDBLibrary.__TCustomConnectionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomConnectionClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TCustomConnectionDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomConnection(CurrentObject).Destroy;
  end;
end;

procedure TatDBLibrary.__TCustomConnectionOpen(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomConnection(CurrentObject).Open;
  end;
end;

procedure TatDBLibrary.__TCustomConnectionClose(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomConnection(CurrentObject).Close;
  end;
end;

procedure TatDBLibrary.__GetTCustomConnectionConnected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomConnection(CurrentObject).Connected);
  end;
end;

procedure TatDBLibrary.__SetTCustomConnectionConnected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomConnection(CurrentObject).Connected:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTCustomConnectionDataSets(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomConnection(CurrentObject).DataSets[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatDBLibrary.__GetTCustomConnectionDataSetCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomConnection(CurrentObject).DataSetCount));
  end;
end;

procedure TatDBLibrary.__GetTCustomConnectionLoginPrompt(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomConnection(CurrentObject).LoginPrompt);
  end;
end;

procedure TatDBLibrary.__SetTCustomConnectionLoginPrompt(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomConnection(CurrentObject).LoginPrompt:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__TDefCollectionFind(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDefCollection(CurrentObject).Find(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TDefCollectionGetItemNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDefCollection(CurrentObject).GetItemNames(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBLibrary.__TDefCollectionIndexOf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDefCollection(CurrentObject).IndexOf(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__GetTDefCollectionDataSet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDefCollection(CurrentObject).DataSet));
  end;
end;

procedure TatDBLibrary.__GetTDefCollectionUpdated(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDefCollection(CurrentObject).Updated);
  end;
end;

procedure TatDBLibrary.__SetTDefCollectionUpdated(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDefCollection(CurrentObject).Updated:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__TFieldDefCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFieldDefClass(CurrentClass.ClassRef).Create(TFieldDefs(Integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2),VarToInteger(GetInputArg(3)),GetInputArg(4),VarToInteger(GetInputArg(5))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TFieldDefDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFieldDef(CurrentObject).Destroy;
  end;
end;

procedure TatDBLibrary.__TFieldDefAddChild(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFieldDef(CurrentObject).AddChild);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TFieldDefAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFieldDef(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBLibrary.__TFieldDefCreateField(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := Integer(TFieldDef(CurrentObject).CreateField(TComponent(Integer(GetInputArg(0)))));
2: AResult := Integer(TFieldDef(CurrentObject).CreateField(TComponent(Integer(GetInputArg(0))),TObjectField(Integer(GetInputArg(1)))));
3: AResult := Integer(TFieldDef(CurrentObject).CreateField(TComponent(Integer(GetInputArg(0))),TObjectField(Integer(GetInputArg(1))),GetInputArg(2)));
4: AResult := Integer(TFieldDef(CurrentObject).CreateField(TComponent(Integer(GetInputArg(0))),TObjectField(Integer(GetInputArg(1))),GetInputArg(2),GetInputArg(3)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TFieldDefHasChildDefs(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TFieldDef(CurrentObject).HasChildDefs;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__GetTFieldDefFieldNo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TFieldDef(CurrentObject).FieldNo));
  end;
end;

procedure TatDBLibrary.__SetTFieldDefFieldNo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFieldDef(CurrentObject).FieldNo:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDBLibrary.__GetTFieldDefInternalCalcField(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TFieldDef(CurrentObject).InternalCalcField);
  end;
end;

procedure TatDBLibrary.__SetTFieldDefInternalCalcField(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFieldDef(CurrentObject).InternalCalcField:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTFieldDefParentDef(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TFieldDef(CurrentObject).ParentDef));
  end;
end;

procedure TatDBLibrary.__GetTFieldDefRequired(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TFieldDef(CurrentObject).Required);
  end;
end;

procedure TatDBLibrary.__SetTFieldDefRequired(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFieldDef(CurrentObject).Required:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__TFieldDefsCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFieldDefsClass(CurrentClass.ClassRef).Create(TPersistent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TFieldDefsAddFieldDef(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFieldDefs(CurrentObject).AddFieldDef);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TFieldDefsFind(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFieldDefs(CurrentObject).Find(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TFieldDefsUpdate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFieldDefs(CurrentObject).Update;
  end;
end;

procedure TatDBLibrary.__TFieldDefsAdd(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      2: TFieldDefs(CurrentObject).Add(GetInputArg(0),GetInputArg(1));
      3: TFieldDefs(CurrentObject).Add(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2)));
      4: TFieldDefs(CurrentObject).Add(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2)),GetInputArg(3));
    end;
  end;
end;

procedure TatDBLibrary.__GetTFieldDefsHiddenFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TFieldDefs(CurrentObject).HiddenFields);
  end;
end;

procedure TatDBLibrary.__SetTFieldDefsHiddenFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFieldDefs(CurrentObject).HiddenFields:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTFieldDefsItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TFieldDefs(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatDBLibrary.__SetTFieldDefsItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFieldDefs(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]:=TFieldDef(Integer(GetInputArg(0)));
  end;
end;

procedure TatDBLibrary.__GetTFieldDefsParentDef(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TFieldDefs(CurrentObject).ParentDef));
  end;
end;

procedure TatDBLibrary.__TIndexDefCreate(AMachine: TatVirtualMachine);
  var
  Param3: TIndexOptions;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param3, VarToInteger(GetInputArg(3)), SizeOf(Param3));
AResult := Integer(TIndexDefClass(CurrentClass.ClassRef).Create(TIndexDefs(Integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2),Param3));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TIndexDefAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIndexDef(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBLibrary.__GetTIndexDefFieldExpression(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIndexDef(CurrentObject).FieldExpression);
  end;
end;

procedure TatDBLibrary.__TIndexDefsCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIndexDefsClass(CurrentClass.ClassRef).Create(TDataSet(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TIndexDefsAddIndexDef(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIndexDefs(CurrentObject).AddIndexDef);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TIndexDefsFind(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIndexDefs(CurrentObject).Find(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TIndexDefsUpdate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIndexDefs(CurrentObject).Update;
  end;
end;

procedure TatDBLibrary.__TIndexDefsFindIndexForFields(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIndexDefs(CurrentObject).FindIndexForFields(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TIndexDefsGetIndexForFields(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIndexDefs(CurrentObject).GetIndexForFields(GetInputArg(0),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TIndexDefsAdd(AMachine: TatVirtualMachine);
  var
  Param2: TIndexOptions;
begin
  with AMachine do
  begin
IntToSet(Param2, VarToInteger(GetInputArg(2)), SizeOf(Param2));
    TIndexDefs(CurrentObject).Add(GetInputArg(0),GetInputArg(1),Param2);
  end;
end;

procedure TatDBLibrary.__GetTIndexDefsItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIndexDefs(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatDBLibrary.__SetTIndexDefsItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIndexDefs(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]:=TIndexDef(Integer(GetInputArg(0)));
  end;
end;

procedure TatDBLibrary.__TFlatListCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFlatListClass(CurrentClass.ClassRef).Create(TDataSet(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TFlatListUpdate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFlatList(CurrentObject).Update;
  end;
end;

procedure TatDBLibrary.__GetTFlatListDataSet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TFlatList(CurrentObject).DataSet));
  end;
end;

procedure TatDBLibrary.__TFieldDefListFieldByName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFieldDefList(CurrentObject).FieldByName(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TFieldDefListFind(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFieldDefList(CurrentObject).Find(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__GetTFieldDefListFieldDefs(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TFieldDefList(CurrentObject).FieldDefs[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatDBLibrary.__TFieldListFieldByName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFieldList(CurrentObject).FieldByName(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TFieldListFind(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFieldList(CurrentObject).Find(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__GetTFieldListFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TFieldList(CurrentObject).Fields[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatDBLibrary.__TFieldsCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFieldsClass(CurrentClass.ClassRef).Create(TDataSet(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TFieldsDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFields(CurrentObject).Destroy;
  end;
end;

procedure TatDBLibrary.__TFieldsAdd(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFields(CurrentObject).Add(TField(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBLibrary.__TFieldsCheckFieldName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFields(CurrentObject).CheckFieldName(GetInputArg(0));
  end;
end;

procedure TatDBLibrary.__TFieldsCheckFieldNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFields(CurrentObject).CheckFieldNames(GetInputArg(0));
  end;
end;

procedure TatDBLibrary.__TFieldsClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFields(CurrentObject).Clear;
  end;
end;

procedure TatDBLibrary.__TFieldsFindField(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFields(CurrentObject).FindField(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TFieldsFieldByName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFields(CurrentObject).FieldByName(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TFieldsFieldByNumber(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFields(CurrentObject).FieldByNumber(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TFieldsGetFieldNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFields(CurrentObject).GetFieldNames(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBLibrary.__TFieldsIndexOf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFields(CurrentObject).IndexOf(TField(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TFieldsRemove(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFields(CurrentObject).Remove(TField(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBLibrary.__GetTFieldsCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TFields(CurrentObject).Count));
  end;
end;

procedure TatDBLibrary.__GetTFieldsDataSet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TFields(CurrentObject).DataSet));
  end;
end;

procedure TatDBLibrary.__GetTFieldsFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TFields(CurrentObject).Fields[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatDBLibrary.__SetTFieldsFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFields(CurrentObject).Fields[VarToInteger(GetArrayIndex(0))]:=TField(Integer(GetInputArg(0)));
  end;
end;

procedure TatDBLibrary.__TLookupListCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TLookupListClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TLookupListDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TLookupList(CurrentObject).Destroy;
  end;
end;

procedure TatDBLibrary.__TLookupListAdd(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TLookupList(CurrentObject).Add(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatDBLibrary.__TLookupListClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TLookupList(CurrentObject).Clear;
  end;
end;

procedure TatDBLibrary.__TLookupListValueOfKey(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TLookupList(CurrentObject).ValueOfKey(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TFieldDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TField(CurrentObject).Destroy;
  end;
end;

procedure TatDBLibrary.__TFieldAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TField(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBLibrary.__TFieldAssignValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TField(CurrentObject).AssignValue(TVarRecWrapper(integer(GetInputArg(0))).ObjToRec);
  end;
end;

procedure TatDBLibrary.__TFieldClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TField(CurrentObject).Clear;
  end;
end;

procedure TatDBLibrary.__TFieldFocusControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TField(CurrentObject).FocusControl;
  end;
end;

procedure TatDBLibrary.__TFieldGetParentComponent(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TField(CurrentObject).GetParentComponent);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TFieldHasParent(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TField(CurrentObject).HasParent;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TFieldIsBlob(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TFieldClass(CurrentClass.ClassRef).IsBlob;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TFieldIsValidChar(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TField(CurrentObject).IsValidChar(VarToStr(GetInputArg(0))[1]);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TFieldRefreshLookupList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TField(CurrentObject).RefreshLookupList;
  end;
end;

procedure TatDBLibrary.__TFieldSetFieldType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TField(CurrentObject).SetFieldType(GetInputArg(0));
  end;
end;

procedure TatDBLibrary.__GetTFieldAsBCD(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TBcdWrapper.Create(TField(CurrentObject).AsBCD)));
  end;
end;

procedure TatDBLibrary.__SetTFieldAsBCD(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TField(CurrentObject).AsBCD:=TBcdWrapper(integer(GetInputArg(0))).ObjToRec;
  end;
end;

procedure TatDBLibrary.__GetTFieldAsBoolean(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TField(CurrentObject).AsBoolean);
  end;
end;

procedure TatDBLibrary.__SetTFieldAsBoolean(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TField(CurrentObject).AsBoolean:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTFieldAsCurrency(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TField(CurrentObject).AsCurrency);
  end;
end;

procedure TatDBLibrary.__SetTFieldAsCurrency(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TField(CurrentObject).AsCurrency:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTFieldAsDateTime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TField(CurrentObject).AsDateTime);
  end;
end;

procedure TatDBLibrary.__SetTFieldAsDateTime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TField(CurrentObject).AsDateTime:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTFieldAsSQLTimeStamp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TSQLTimeStampWrapper.Create(TField(CurrentObject).AsSQLTimeStamp)));
  end;
end;

procedure TatDBLibrary.__SetTFieldAsSQLTimeStamp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TField(CurrentObject).AsSQLTimeStamp:=TSQLTimeStampWrapper(integer(GetInputArg(0))).ObjToRec;
  end;
end;

procedure TatDBLibrary.__GetTFieldAsFloat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TField(CurrentObject).AsFloat);
  end;
end;

procedure TatDBLibrary.__SetTFieldAsFloat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TField(CurrentObject).AsFloat:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTFieldAsInteger(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TField(CurrentObject).AsInteger));
  end;
end;

procedure TatDBLibrary.__SetTFieldAsInteger(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TField(CurrentObject).AsInteger:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDBLibrary.__GetTFieldAsString(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TField(CurrentObject).AsString);
  end;
end;

procedure TatDBLibrary.__SetTFieldAsString(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TField(CurrentObject).AsString:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTFieldAsVariant(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TField(CurrentObject).AsVariant);
  end;
end;

procedure TatDBLibrary.__SetTFieldAsVariant(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TField(CurrentObject).AsVariant:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTFieldAttributeSet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TField(CurrentObject).AttributeSet);
  end;
end;

procedure TatDBLibrary.__SetTFieldAttributeSet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TField(CurrentObject).AttributeSet:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTFieldCalculated(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TField(CurrentObject).Calculated);
  end;
end;

procedure TatDBLibrary.__SetTFieldCalculated(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TField(CurrentObject).Calculated:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTFieldCanModify(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TField(CurrentObject).CanModify);
  end;
end;

procedure TatDBLibrary.__GetTFieldCurValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TField(CurrentObject).CurValue);
  end;
end;

procedure TatDBLibrary.__GetTFieldDataSet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TField(CurrentObject).DataSet));
  end;
end;

procedure TatDBLibrary.__SetTFieldDataSet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TField(CurrentObject).DataSet:=TDataSet(Integer(GetInputArg(0)));
  end;
end;

procedure TatDBLibrary.__GetTFieldDataSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TField(CurrentObject).DataSize));
  end;
end;

procedure TatDBLibrary.__GetTFieldDataType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TField(CurrentObject).DataType);
  end;
end;

procedure TatDBLibrary.__GetTFieldDisplayName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TField(CurrentObject).DisplayName);
  end;
end;

procedure TatDBLibrary.__GetTFieldDisplayText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TField(CurrentObject).DisplayText);
  end;
end;

procedure TatDBLibrary.__GetTFieldEditMask(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TField(CurrentObject).EditMask);
  end;
end;

procedure TatDBLibrary.__SetTFieldEditMask(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TField(CurrentObject).EditMask:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTFieldEditMaskPtr(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TField(CurrentObject).EditMaskPtr);
  end;
end;

procedure TatDBLibrary.__GetTFieldFieldNo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TField(CurrentObject).FieldNo));
  end;
end;

procedure TatDBLibrary.__GetTFieldFullName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TField(CurrentObject).FullName);
  end;
end;

procedure TatDBLibrary.__GetTFieldIsIndexField(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TField(CurrentObject).IsIndexField);
  end;
end;

procedure TatDBLibrary.__GetTFieldIsNull(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TField(CurrentObject).IsNull);
  end;
end;

procedure TatDBLibrary.__GetTFieldLookup(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TField(CurrentObject).Lookup);
  end;
end;

procedure TatDBLibrary.__SetTFieldLookup(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TField(CurrentObject).Lookup:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTFieldLookupList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TField(CurrentObject).LookupList));
  end;
end;

procedure TatDBLibrary.__GetTFieldNewValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TField(CurrentObject).NewValue);
  end;
end;

procedure TatDBLibrary.__SetTFieldNewValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TField(CurrentObject).NewValue:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTFieldOffset(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TField(CurrentObject).Offset));
  end;
end;

procedure TatDBLibrary.__GetTFieldOldValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TField(CurrentObject).OldValue);
  end;
end;

procedure TatDBLibrary.__GetTFieldParentField(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TField(CurrentObject).ParentField));
  end;
end;

procedure TatDBLibrary.__SetTFieldParentField(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TField(CurrentObject).ParentField:=TObjectField(Integer(GetInputArg(0)));
  end;
end;

procedure TatDBLibrary.__GetTFieldSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TField(CurrentObject).Size));
  end;
end;

procedure TatDBLibrary.__SetTFieldSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TField(CurrentObject).Size:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDBLibrary.__GetTFieldText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TField(CurrentObject).Text);
  end;
end;

procedure TatDBLibrary.__SetTFieldText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TField(CurrentObject).Text:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTFieldValidChars(AMachine: TatVirtualMachine);
var
PropValueSet: TFieldChars;
begin
  with AMachine do
  begin
    PropValueSet := TField(CurrentObject).ValidChars;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatDBLibrary.__SetTFieldValidChars(AMachine: TatVirtualMachine);
  var
  TempVar: TFieldChars;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TField(CurrentObject).ValidChars:=TempVar;
  end;
end;

procedure TatDBLibrary.__GetTFieldValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TField(CurrentObject).Value);
  end;
end;

procedure TatDBLibrary.__SetTFieldValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TField(CurrentObject).Value:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__TStringFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TStringFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__GetTStringFieldValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TStringField(CurrentObject).Value);
  end;
end;

procedure TatDBLibrary.__SetTStringFieldValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TStringField(CurrentObject).Value:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__TWideStringFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TWideStringFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__GetTWideStringFieldValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TWideStringField(CurrentObject).Value);
  end;
end;

procedure TatDBLibrary.__SetTWideStringFieldValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWideStringField(CurrentObject).Value:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__TNumericFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TNumericFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TIntegerFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIntegerFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__GetTIntegerFieldValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIntegerField(CurrentObject).Value));
  end;
end;

procedure TatDBLibrary.__SetTIntegerFieldValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIntegerField(CurrentObject).Value:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDBLibrary.__TSmallintFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSmallintFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TLargeintFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TLargeintFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__GetTLargeintFieldAsLargeInt(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TLargeintField(CurrentObject).AsLargeInt));
  end;
end;

procedure TatDBLibrary.__SetTLargeintFieldAsLargeInt(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TLargeintField(CurrentObject).AsLargeInt:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDBLibrary.__GetTLargeintFieldValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TLargeintField(CurrentObject).Value));
  end;
end;

procedure TatDBLibrary.__SetTLargeintFieldValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TLargeintField(CurrentObject).Value:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDBLibrary.__TWordFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TWordFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TAutoIncFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAutoIncFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TFloatFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFloatFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__GetTFloatFieldValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TFloatField(CurrentObject).Value);
  end;
end;

procedure TatDBLibrary.__SetTFloatFieldValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFloatField(CurrentObject).Value:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__TCurrencyFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCurrencyFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TBooleanFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TBooleanFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__GetTBooleanFieldValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TBooleanField(CurrentObject).Value);
  end;
end;

procedure TatDBLibrary.__SetTBooleanFieldValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBooleanField(CurrentObject).Value:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__TDateTimeFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDateTimeFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__GetTDateTimeFieldValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDateTimeField(CurrentObject).Value);
  end;
end;

procedure TatDBLibrary.__SetTDateTimeFieldValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDateTimeField(CurrentObject).Value:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__TSQLTimeStampFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSQLTimeStampFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__GetTSQLTimeStampFieldValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TSQLTimeStampWrapper.Create(TSQLTimeStampField(CurrentObject).Value)));
  end;
end;

procedure TatDBLibrary.__SetTSQLTimeStampFieldValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSQLTimeStampField(CurrentObject).Value:=TSQLTimeStampWrapper(integer(GetInputArg(0))).ObjToRec;
  end;
end;

procedure TatDBLibrary.__TDateFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDateFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TTimeFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTimeFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TBinaryFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TBinaryFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TBytesFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TBytesFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TVarBytesFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TVarBytesFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TBCDFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TBCDFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__GetTBCDFieldValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TBCDField(CurrentObject).Value);
  end;
end;

procedure TatDBLibrary.__SetTBCDFieldValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBCDField(CurrentObject).Value:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__TFMTBCDFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TFMTBCDFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__GetTFMTBCDFieldValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TBcdWrapper.Create(TFMTBCDField(CurrentObject).Value)));
  end;
end;

procedure TatDBLibrary.__SetTFMTBCDFieldValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TFMTBCDField(CurrentObject).Value:=TBcdWrapper(integer(GetInputArg(0))).ObjToRec;
  end;
end;

procedure TatDBLibrary.__TBlobFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TBlobFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TBlobFieldAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBlobField(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBLibrary.__TBlobFieldClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBlobField(CurrentObject).Clear;
  end;
end;

procedure TatDBLibrary.__TBlobFieldIsBlob(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TBlobFieldClass(CurrentClass.ClassRef).IsBlob;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TBlobFieldLoadFromFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBlobField(CurrentObject).LoadFromFile(GetInputArg(0));
  end;
end;

procedure TatDBLibrary.__TBlobFieldLoadFromStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBlobField(CurrentObject).LoadFromStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBLibrary.__TBlobFieldSaveToFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBlobField(CurrentObject).SaveToFile(GetInputArg(0));
  end;
end;

procedure TatDBLibrary.__TBlobFieldSaveToStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBlobField(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBLibrary.__TBlobFieldSetFieldType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBlobField(CurrentObject).SetFieldType(GetInputArg(0));
  end;
end;

procedure TatDBLibrary.__GetTBlobFieldBlobSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TBlobField(CurrentObject).BlobSize));
  end;
end;

procedure TatDBLibrary.__GetTBlobFieldModified(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TBlobField(CurrentObject).Modified);
  end;
end;

procedure TatDBLibrary.__SetTBlobFieldModified(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBlobField(CurrentObject).Modified:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTBlobFieldValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TBlobField(CurrentObject).Value);
  end;
end;

procedure TatDBLibrary.__SetTBlobFieldValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBlobField(CurrentObject).Value:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTBlobFieldTransliterate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TBlobField(CurrentObject).Transliterate);
  end;
end;

procedure TatDBLibrary.__SetTBlobFieldTransliterate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBlobField(CurrentObject).Transliterate:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__TMemoFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TMemoFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TGraphicFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGraphicFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TObjectFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TObjectFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TObjectFieldDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TObjectField(CurrentObject).Destroy;
  end;
end;

procedure TatDBLibrary.__GetTObjectFieldFieldCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TObjectField(CurrentObject).FieldCount));
  end;
end;

procedure TatDBLibrary.__GetTObjectFieldFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TObjectField(CurrentObject).Fields));
  end;
end;

procedure TatDBLibrary.__GetTObjectFieldFieldValues(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TObjectField(CurrentObject).FieldValues[VarToInteger(GetArrayIndex(0))]);
  end;
end;

procedure TatDBLibrary.__SetTObjectFieldFieldValues(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TObjectField(CurrentObject).FieldValues[VarToInteger(GetArrayIndex(0))]:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTObjectFieldUnNamed(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TObjectField(CurrentObject).UnNamed);
  end;
end;

procedure TatDBLibrary.__TADTFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TADTFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TArrayFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TArrayFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TDataSetFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDataSetFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TDataSetFieldDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSetField(CurrentObject).Destroy;
  end;
end;

procedure TatDBLibrary.__GetTDataSetFieldNestedDataSet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDataSetField(CurrentObject).NestedDataSet));
  end;
end;

procedure TatDBLibrary.__TReferenceFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TReferenceFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TReferenceFieldAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TReferenceField(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBLibrary.__TVariantFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TVariantFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TInterfaceFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TInterfaceFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TIDispatchFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIDispatchFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TGuidFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGuidFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__GetTGuidFieldAsGuid(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(TGuidField(CurrentObject).AsGuid)));
  end;
end;

procedure TatDBLibrary.__SetTGuidFieldAsGuid(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGuidField(CurrentObject).AsGuid:=TGUIDWrapper(integer(GetInputArg(0))).ObjToRec;
  end;
end;

procedure TatDBLibrary.__TAggregateFieldCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAggregateFieldClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__GetTAggregateFieldResultType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TAggregateField(CurrentObject).ResultType);
  end;
end;

procedure TatDBLibrary.__SetTAggregateFieldResultType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAggregateField(CurrentObject).ResultType:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__TDataLinkCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDataLinkClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TDataLinkDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataLink(CurrentObject).Destroy;
  end;
end;

procedure TatDBLibrary.__TDataLinkEdit(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDataLink(CurrentObject).Edit;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TDataLinkExecuteAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDataLink(CurrentObject).ExecuteAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TDataLinkUpdateAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDataLink(CurrentObject).UpdateAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TDataLinkUpdateRecord(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataLink(CurrentObject).UpdateRecord;
  end;
end;

procedure TatDBLibrary.__GetTDataLinkActive(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDataLink(CurrentObject).Active);
  end;
end;

procedure TatDBLibrary.__GetTDataLinkActiveRecord(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDataLink(CurrentObject).ActiveRecord));
  end;
end;

procedure TatDBLibrary.__SetTDataLinkActiveRecord(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataLink(CurrentObject).ActiveRecord:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDBLibrary.__GetTDataLinkBOF(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDataLink(CurrentObject).BOF);
  end;
end;

procedure TatDBLibrary.__GetTDataLinkBufferCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDataLink(CurrentObject).BufferCount));
  end;
end;

procedure TatDBLibrary.__SetTDataLinkBufferCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataLink(CurrentObject).BufferCount:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDBLibrary.__GetTDataLinkDataSet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDataLink(CurrentObject).DataSet));
  end;
end;

procedure TatDBLibrary.__GetTDataLinkDataSource(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDataLink(CurrentObject).DataSource));
  end;
end;

procedure TatDBLibrary.__SetTDataLinkDataSource(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataLink(CurrentObject).DataSource:=TDataSource(Integer(GetInputArg(0)));
  end;
end;

procedure TatDBLibrary.__GetTDataLinkDataSourceFixed(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDataLink(CurrentObject).DataSourceFixed);
  end;
end;

procedure TatDBLibrary.__SetTDataLinkDataSourceFixed(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataLink(CurrentObject).DataSourceFixed:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTDataLinkEditing(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDataLink(CurrentObject).Editing);
  end;
end;

procedure TatDBLibrary.__GetTDataLinkEof(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDataLink(CurrentObject).Eof);
  end;
end;

procedure TatDBLibrary.__GetTDataLinkReadOnly(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDataLink(CurrentObject).ReadOnly);
  end;
end;

procedure TatDBLibrary.__SetTDataLinkReadOnly(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataLink(CurrentObject).ReadOnly:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTDataLinkRecordCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDataLink(CurrentObject).RecordCount));
  end;
end;

procedure TatDBLibrary.__GetTDetailDataLinkDetailDataSet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDetailDataLink(CurrentObject).DetailDataSet));
  end;
end;

procedure TatDBLibrary.__TMasterDataLinkCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TMasterDataLinkClass(CurrentClass.ClassRef).Create(TDataSet(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TMasterDataLinkDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMasterDataLink(CurrentObject).Destroy;
  end;
end;

procedure TatDBLibrary.__GetTMasterDataLinkFieldNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TMasterDataLink(CurrentObject).FieldNames);
  end;
end;

procedure TatDBLibrary.__SetTMasterDataLinkFieldNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMasterDataLink(CurrentObject).FieldNames:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTMasterDataLinkFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMasterDataLink(CurrentObject).Fields));
  end;
end;

procedure TatDBLibrary.__TDataSourceCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDataSourceClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TDataSourceDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSource(CurrentObject).Destroy;
  end;
end;

procedure TatDBLibrary.__TDataSourceEdit(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSource(CurrentObject).Edit;
  end;
end;

procedure TatDBLibrary.__TDataSourceIsLinkedTo(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDataSource(CurrentObject).IsLinkedTo(TDataSet(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__GetTDataSourceState(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDataSource(CurrentObject).State);
  end;
end;

procedure TatDBLibrary.__TDataSetDesignerCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDataSetDesignerClass(CurrentClass.ClassRef).Create(TDataSet(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TDataSetDesignerDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSetDesigner(CurrentObject).Destroy;
  end;
end;

procedure TatDBLibrary.__TDataSetDesignerBeginDesign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSetDesigner(CurrentObject).BeginDesign;
  end;
end;

procedure TatDBLibrary.__TDataSetDesignerDataEvent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSetDesigner(CurrentObject).DataEvent(GetInputArg(0),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatDBLibrary.__TDataSetDesignerEndDesign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSetDesigner(CurrentObject).EndDesign;
  end;
end;

procedure TatDBLibrary.__GetTDataSetDesignerDataSet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDataSetDesigner(CurrentObject).DataSet));
  end;
end;

procedure TatDBLibrary.__TCheckConstraintAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCheckConstraint(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBLibrary.__TCheckConstraintGetDisplayName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCheckConstraint(CurrentObject).GetDisplayName;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TCheckConstraintsCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCheckConstraintsClass(CurrentClass.ClassRef).Create(TPersistent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TCheckConstraintsAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCheckConstraints(CurrentObject).Add);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__GetTCheckConstraintsItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCheckConstraints(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatDBLibrary.__SetTCheckConstraintsItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCheckConstraints(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]:=TCheckConstraint(Integer(GetInputArg(0)));
  end;
end;

procedure TatDBLibrary.__TParamCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TParamClass(CurrentClass.ClassRef).Create(TCollection(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TParamAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParam(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBLibrary.__TParamAssignField(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParam(CurrentObject).AssignField(TField(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBLibrary.__TParamAssignFieldValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParam(CurrentObject).AssignFieldValue(TField(Integer(GetInputArg(0))),GetInputArg(1));
  end;
end;

procedure TatDBLibrary.__TParamClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParam(CurrentObject).Clear;
  end;
end;

procedure TatDBLibrary.__TParamGetDataSize(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TParam(CurrentObject).GetDataSize);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TParamLoadFromFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParam(CurrentObject).LoadFromFile(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatDBLibrary.__TParamLoadFromStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParam(CurrentObject).LoadFromStream(TStream(Integer(GetInputArg(0))),GetInputArg(1));
  end;
end;

procedure TatDBLibrary.__GetTParamAsBCD(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TParam(CurrentObject).AsBCD);
  end;
end;

procedure TatDBLibrary.__SetTParamAsBCD(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParam(CurrentObject).AsBCD:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTParamAsFMTBCD(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TBcdWrapper.Create(TParam(CurrentObject).AsFMTBCD)));
  end;
end;

procedure TatDBLibrary.__SetTParamAsFMTBCD(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParam(CurrentObject).AsFMTBCD:=TBcdWrapper(integer(GetInputArg(0))).ObjToRec;
  end;
end;

procedure TatDBLibrary.__GetTParamAsBlob(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TParam(CurrentObject).AsBlob);
  end;
end;

procedure TatDBLibrary.__SetTParamAsBlob(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParam(CurrentObject).AsBlob:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTParamAsBoolean(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TParam(CurrentObject).AsBoolean);
  end;
end;

procedure TatDBLibrary.__SetTParamAsBoolean(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParam(CurrentObject).AsBoolean:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTParamAsCurrency(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TParam(CurrentObject).AsCurrency);
  end;
end;

procedure TatDBLibrary.__SetTParamAsCurrency(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParam(CurrentObject).AsCurrency:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTParamAsDate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TParam(CurrentObject).AsDate);
  end;
end;

procedure TatDBLibrary.__SetTParamAsDate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParam(CurrentObject).AsDate:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTParamAsDateTime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TParam(CurrentObject).AsDateTime);
  end;
end;

procedure TatDBLibrary.__SetTParamAsDateTime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParam(CurrentObject).AsDateTime:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTParamAsFloat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TParam(CurrentObject).AsFloat);
  end;
end;

procedure TatDBLibrary.__SetTParamAsFloat(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParam(CurrentObject).AsFloat:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTParamAsInteger(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TParam(CurrentObject).AsInteger));
  end;
end;

procedure TatDBLibrary.__SetTParamAsInteger(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParam(CurrentObject).AsInteger:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDBLibrary.__GetTParamAsSmallInt(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TParam(CurrentObject).AsSmallInt));
  end;
end;

procedure TatDBLibrary.__SetTParamAsSmallInt(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParam(CurrentObject).AsSmallInt:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDBLibrary.__GetTParamAsSQLTimeStamp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TSQLTimeStampWrapper.Create(TParam(CurrentObject).AsSQLTimeStamp)));
  end;
end;

procedure TatDBLibrary.__SetTParamAsSQLTimeStamp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParam(CurrentObject).AsSQLTimeStamp:=TSQLTimeStampWrapper(integer(GetInputArg(0))).ObjToRec;
  end;
end;

procedure TatDBLibrary.__GetTParamAsMemo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TParam(CurrentObject).AsMemo);
  end;
end;

procedure TatDBLibrary.__SetTParamAsMemo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParam(CurrentObject).AsMemo:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTParamAsString(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TParam(CurrentObject).AsString);
  end;
end;

procedure TatDBLibrary.__SetTParamAsString(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParam(CurrentObject).AsString:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTParamAsTime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TParam(CurrentObject).AsTime);
  end;
end;

procedure TatDBLibrary.__SetTParamAsTime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParam(CurrentObject).AsTime:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTParamAsWord(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TParam(CurrentObject).AsWord));
  end;
end;

procedure TatDBLibrary.__SetTParamAsWord(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParam(CurrentObject).AsWord:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDBLibrary.__GetTParamBound(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TParam(CurrentObject).Bound);
  end;
end;

procedure TatDBLibrary.__SetTParamBound(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParam(CurrentObject).Bound:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTParamIsNull(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TParam(CurrentObject).IsNull);
  end;
end;

procedure TatDBLibrary.__GetTParamNativeStr(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TParam(CurrentObject).NativeStr);
  end;
end;

procedure TatDBLibrary.__SetTParamNativeStr(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParam(CurrentObject).NativeStr:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTParamText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TParam(CurrentObject).Text);
  end;
end;

procedure TatDBLibrary.__SetTParamText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParam(CurrentObject).Text:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__TParamsCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TParamsClass(CurrentClass.ClassRef).Create(TPersistent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TParamsAssignValues(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParams(CurrentObject).AssignValues(TParams(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBLibrary.__TParamsAddParam(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParams(CurrentObject).AddParam(TParam(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBLibrary.__TParamsRemoveParam(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParams(CurrentObject).RemoveParam(TParam(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBLibrary.__TParamsCreateParam(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TParams(CurrentObject).CreateParam(GetInputArg(0),GetInputArg(1),GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TParamsGetParamList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParams(CurrentObject).GetParamList(TList(Integer(GetInputArg(0))),GetInputArg(1));
  end;
end;

procedure TatDBLibrary.__TParamsIsEqual(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TParams(CurrentObject).IsEqual(TParams(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TParamsParseSQL(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TParams(CurrentObject).ParseSQL(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TParamsParamByName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TParams(CurrentObject).ParamByName(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TParamsFindParam(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TParams(CurrentObject).FindParam(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__GetTParamsItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TParams(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatDBLibrary.__SetTParamsItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParams(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]:=TParam(Integer(GetInputArg(0)));
  end;
end;

procedure TatDBLibrary.__GetTParamsParamValues(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TParams(CurrentObject).ParamValues[GetArrayIndex(0)]);
  end;
end;

procedure TatDBLibrary.__SetTParamsParamValues(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TParams(CurrentObject).ParamValues[GetArrayIndex(0)]:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__TDataSetCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDataSetClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TDataSetDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).Destroy;
  end;
end;

procedure TatDBLibrary.__TDataSetActiveBuffer(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(TDataSet(CurrentObject).ActiveBuffer);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TDataSetAppend(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).Append;
  end;
end;

procedure TatDBLibrary.__TDataSetCancel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).Cancel;
  end;
end;

procedure TatDBLibrary.__TDataSetCheckBrowseMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).CheckBrowseMode;
  end;
end;

procedure TatDBLibrary.__TDataSetClearFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).ClearFields;
  end;
end;

procedure TatDBLibrary.__TDataSetClose(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).Close;
  end;
end;

procedure TatDBLibrary.__TDataSetControlsDisabled(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDataSet(CurrentObject).ControlsDisabled;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TDataSetCreateBlobStream(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDataSet(CurrentObject).CreateBlobStream(TField(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TDataSetCursorPosChanged(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).CursorPosChanged;
  end;
end;

procedure TatDBLibrary.__TDataSetDelete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).Delete;
  end;
end;

procedure TatDBLibrary.__TDataSetDisableControls(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).DisableControls;
  end;
end;

procedure TatDBLibrary.__TDataSetEdit(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).Edit;
  end;
end;

procedure TatDBLibrary.__TDataSetEnableControls(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).EnableControls;
  end;
end;

procedure TatDBLibrary.__TDataSetFieldByName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDataSet(CurrentObject).FieldByName(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TDataSetFindField(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDataSet(CurrentObject).FindField(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TDataSetFindFirst(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDataSet(CurrentObject).FindFirst;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TDataSetFindLast(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDataSet(CurrentObject).FindLast;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TDataSetFindNext(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDataSet(CurrentObject).FindNext;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TDataSetFindPrior(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDataSet(CurrentObject).FindPrior;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TDataSetFirst(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).First;
  end;
end;

procedure TatDBLibrary.__TDataSetGetCurrentRecord(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDataSet(CurrentObject).GetCurrentRecord(PChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TDataSetGetDetailDataSets(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).GetDetailDataSets(TList(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBLibrary.__TDataSetGetDetailLinkFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).GetDetailLinkFields(TList(Integer(GetInputArg(0))),TList(Integer(GetInputArg(1))));
  end;
end;

procedure TatDBLibrary.__TDataSetGetFieldList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).GetFieldList(TList(Integer(GetInputArg(0))),GetInputArg(1));
  end;
end;

procedure TatDBLibrary.__TDataSetGetFieldNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).GetFieldNames(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBLibrary.__TDataSetInsert(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).Insert;
  end;
end;

procedure TatDBLibrary.__TDataSetIsEmpty(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDataSet(CurrentObject).IsEmpty;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TDataSetIsLinkedTo(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDataSet(CurrentObject).IsLinkedTo(TDataSource(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TDataSetIsSequenced(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDataSet(CurrentObject).IsSequenced;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TDataSetLast(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).Last;
  end;
end;

procedure TatDBLibrary.__TDataSetLocate(AMachine: TatVirtualMachine);
  var
  Param2: TLocateOptions;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param2, VarToInteger(GetInputArg(2)), SizeOf(Param2));
AResult := TDataSet(CurrentObject).Locate(GetInputArg(0),GetInputArg(1),Param2);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TDataSetLookup(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDataSet(CurrentObject).Lookup(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TDataSetMoveBy(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDataSet(CurrentObject).MoveBy(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TDataSetNext(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).Next;
  end;
end;

procedure TatDBLibrary.__TDataSetOpen(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).Open;
  end;
end;

procedure TatDBLibrary.__TDataSetPost(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).Post;
  end;
end;

procedure TatDBLibrary.__TDataSetPrior(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).Prior;
  end;
end;

procedure TatDBLibrary.__TDataSetRefresh(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).Refresh;
  end;
end;

procedure TatDBLibrary.__TDataSetResync(AMachine: TatVirtualMachine);
  var
  Param0: TResyncMode;
begin
  with AMachine do
  begin
IntToSet(Param0, VarToInteger(GetInputArg(0)), SizeOf(Param0));
    TDataSet(CurrentObject).Resync(Param0);
  end;
end;

procedure TatDBLibrary.__TDataSetTranslate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDataSet(CurrentObject).Translate(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__TDataSetUpdateCursorPos(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).UpdateCursorPos;
  end;
end;

procedure TatDBLibrary.__TDataSetUpdateRecord(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).UpdateRecord;
  end;
end;

procedure TatDBLibrary.__TDataSetUpdateStatus(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDataSet(CurrentObject).UpdateStatus;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__GetTDataSetAggFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDataSet(CurrentObject).AggFields));
  end;
end;

procedure TatDBLibrary.__GetTDataSetBof(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDataSet(CurrentObject).Bof);
  end;
end;

procedure TatDBLibrary.__GetTDataSetBookmark(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDataSet(CurrentObject).Bookmark);
  end;
end;

procedure TatDBLibrary.__SetTDataSetBookmark(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).Bookmark:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTDataSetCanModify(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDataSet(CurrentObject).CanModify);
  end;
end;

procedure TatDBLibrary.__GetTDataSetDataSetField(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDataSet(CurrentObject).DataSetField));
  end;
end;

procedure TatDBLibrary.__SetTDataSetDataSetField(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).DataSetField:=TDataSetField(Integer(GetInputArg(0)));
  end;
end;

procedure TatDBLibrary.__GetTDataSetDataSource(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDataSet(CurrentObject).DataSource));
  end;
end;

procedure TatDBLibrary.__GetTDataSetDefaultFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDataSet(CurrentObject).DefaultFields);
  end;
end;

procedure TatDBLibrary.__GetTDataSetDesigner(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDataSet(CurrentObject).Designer));
  end;
end;

procedure TatDBLibrary.__GetTDataSetEof(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDataSet(CurrentObject).Eof);
  end;
end;

procedure TatDBLibrary.__GetTDataSetBlockReadSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDataSet(CurrentObject).BlockReadSize));
  end;
end;

procedure TatDBLibrary.__SetTDataSetBlockReadSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).BlockReadSize:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDBLibrary.__GetTDataSetFieldCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDataSet(CurrentObject).FieldCount));
  end;
end;

procedure TatDBLibrary.__GetTDataSetFieldDefs(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDataSet(CurrentObject).FieldDefs));
  end;
end;

procedure TatDBLibrary.__SetTDataSetFieldDefs(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).FieldDefs:=TFieldDefs(Integer(GetInputArg(0)));
  end;
end;

procedure TatDBLibrary.__GetTDataSetFieldDefList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDataSet(CurrentObject).FieldDefList));
  end;
end;

procedure TatDBLibrary.__GetTDataSetFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDataSet(CurrentObject).Fields));
  end;
end;

procedure TatDBLibrary.__GetTDataSetFieldList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDataSet(CurrentObject).FieldList));
  end;
end;

procedure TatDBLibrary.__GetTDataSetFieldValues(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDataSet(CurrentObject).FieldValues[GetArrayIndex(0)]);
  end;
end;

procedure TatDBLibrary.__SetTDataSetFieldValues(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).FieldValues[GetArrayIndex(0)]:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTDataSetFound(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDataSet(CurrentObject).Found);
  end;
end;

procedure TatDBLibrary.__GetTDataSetIsUniDirectional(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDataSet(CurrentObject).IsUniDirectional);
  end;
end;

procedure TatDBLibrary.__GetTDataSetModified(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDataSet(CurrentObject).Modified);
  end;
end;

procedure TatDBLibrary.__GetTDataSetObjectView(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDataSet(CurrentObject).ObjectView);
  end;
end;

procedure TatDBLibrary.__SetTDataSetObjectView(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).ObjectView:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTDataSetRecordCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDataSet(CurrentObject).RecordCount));
  end;
end;

procedure TatDBLibrary.__GetTDataSetRecNo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDataSet(CurrentObject).RecNo));
  end;
end;

procedure TatDBLibrary.__SetTDataSetRecNo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).RecNo:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDBLibrary.__GetTDataSetRecordSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDataSet(CurrentObject).RecordSize));
  end;
end;

procedure TatDBLibrary.__GetTDataSetSparseArrays(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDataSet(CurrentObject).SparseArrays);
  end;
end;

procedure TatDBLibrary.__SetTDataSetSparseArrays(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).SparseArrays:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTDataSetState(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDataSet(CurrentObject).State);
  end;
end;

procedure TatDBLibrary.__GetTDataSetFilter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDataSet(CurrentObject).Filter);
  end;
end;

procedure TatDBLibrary.__SetTDataSetFilter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).Filter:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTDataSetFiltered(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDataSet(CurrentObject).Filtered);
  end;
end;

procedure TatDBLibrary.__SetTDataSetFiltered(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).Filtered:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTDataSetFilterOptions(AMachine: TatVirtualMachine);
var
PropValueSet: TFilterOptions;
begin
  with AMachine do
  begin
    PropValueSet := TDataSet(CurrentObject).FilterOptions;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatDBLibrary.__SetTDataSetFilterOptions(AMachine: TatVirtualMachine);
  var
  TempVar: TFilterOptions;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TDataSet(CurrentObject).FilterOptions:=TempVar;
  end;
end;

procedure TatDBLibrary.__GetTDataSetActive(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDataSet(CurrentObject).Active);
  end;
end;

procedure TatDBLibrary.__SetTDataSetActive(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).Active:=GetInputArg(0);
  end;
end;

procedure TatDBLibrary.__GetTDataSetAutoCalcFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDataSet(CurrentObject).AutoCalcFields);
  end;
end;

procedure TatDBLibrary.__SetTDataSetAutoCalcFields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataSet(CurrentObject).AutoCalcFields:=GetInputArg(0);
  end;
end;

procedure TatDBDispatcher.__TUpdateErrorEvent( DataSet: TDataSet;  E: EDatabaseError;  UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
var
  UpdateKindTemp: variant;
  UpdateActionTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TUpdateErrorEvent(BeforeCall)(DataSet,E,UpdateKind,UpdateAction);
    UpdateKindTemp := UpdateKind;
    UpdateActionTemp := UpdateAction;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [DataSet,E,UpdateKindTemp,UpdateActionTemp]);
    UpdateAction := UpdateActionTemp;
    if AssignedMethod(AfterCall) then
      TUpdateErrorEvent(AfterCall)(DataSet,E,UpdateKind,UpdateAction);
  end;
end;

procedure TatDBDispatcher.__TUpdateRecordEvent( DataSet: TDataSet;  UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
var
  UpdateKindTemp: variant;
  UpdateActionTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TUpdateRecordEvent(BeforeCall)(DataSet,UpdateKind,UpdateAction);
    UpdateKindTemp := UpdateKind;
    UpdateActionTemp := UpdateAction;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [DataSet,UpdateKindTemp,UpdateActionTemp]);
    UpdateAction := UpdateActionTemp;
    if AssignedMethod(AfterCall) then
      TUpdateRecordEvent(AfterCall)(DataSet,UpdateKind,UpdateAction);
  end;
end;

procedure TatDBDispatcher.__TLoginEvent( Sender: TObject;  Username: string;  Password: string);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TLoginEvent(BeforeCall)(Sender,Username,Password);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Username,Password]);
    if AssignedMethod(AfterCall) then
      TLoginEvent(AfterCall)(Sender,Username,Password);
  end;
end;

procedure TatDBDispatcher.__TConnectChangeEvent( Sender: TObject;  Connecting: Boolean);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TConnectChangeEvent(BeforeCall)(Sender,Connecting);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Connecting]);
    if AssignedMethod(AfterCall) then
      TConnectChangeEvent(AfterCall)(Sender,Connecting);
  end;
end;

procedure TatDBDispatcher.__TDefUpdateMethod();
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TDefUpdateMethod(BeforeCall)();
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, []);
    if AssignedMethod(AfterCall) then
      TDefUpdateMethod(AfterCall)();
  end;
end;

procedure TatDBDispatcher.__TFieldNotifyEvent( Sender: TField);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TFieldNotifyEvent(BeforeCall)(Sender);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender]);
    if AssignedMethod(AfterCall) then
      TFieldNotifyEvent(AfterCall)(Sender);
  end;
end;

procedure TatDBDispatcher.__TFieldGetTextEvent( Sender: TField; var Text: string;  DisplayText: Boolean);
var
  TextTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TFieldGetTextEvent(BeforeCall)(Sender,Text,DisplayText);
    TextTemp := Text;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,TextTemp,DisplayText]);
    Text := TextTemp;
    if AssignedMethod(AfterCall) then
      TFieldGetTextEvent(AfterCall)(Sender,Text,DisplayText);
  end;
end;

procedure TatDBDispatcher.__TFieldSetTextEvent( Sender: TField; const Text: string);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TFieldSetTextEvent(BeforeCall)(Sender,Text);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Text]);
    if AssignedMethod(AfterCall) then
      TFieldSetTextEvent(AfterCall)(Sender,Text);
  end;
end;

procedure TatDBDispatcher.__TDataChangeEvent( Sender: TObject;  Field: TField);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TDataChangeEvent(BeforeCall)(Sender,Field);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Field]);
    if AssignedMethod(AfterCall) then
      TDataChangeEvent(AfterCall)(Sender,Field);
  end;
end;

procedure TatDBDispatcher.__TDataSetNotifyEvent( DataSet: TDataSet);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TDataSetNotifyEvent(BeforeCall)(DataSet);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [DataSet]);
    if AssignedMethod(AfterCall) then
      TDataSetNotifyEvent(AfterCall)(DataSet);
  end;
end;

procedure TatDBDispatcher.__TDataSetErrorEvent( DataSet: TDataSet;  E: EDatabaseError; var Action: TDataAction);
var
  ActionTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TDataSetErrorEvent(BeforeCall)(DataSet,E,Action);
    ActionTemp := Action;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [DataSet,E,ActionTemp]);
    Action := ActionTemp;
    if AssignedMethod(AfterCall) then
      TDataSetErrorEvent(AfterCall)(DataSet,E,Action);
  end;
end;

procedure TatDBDispatcher.__TFilterRecordEvent( DataSet: TDataSet; var Accept: Boolean);
var
  AcceptTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TFilterRecordEvent(BeforeCall)(DataSet,Accept);
    AcceptTemp := Accept;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [DataSet,AcceptTemp]);
    Accept := AcceptTemp;
    if AssignedMethod(AfterCall) then
      TFilterRecordEvent(AfterCall)(DataSet,Accept);
  end;
end;

procedure TatDBLibrary.__ExtractFieldName(AMachine: TatVirtualMachine);
  var
  Param1: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := DB.ExtractFieldName(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatDBLibrary.__DatabaseError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      1: DB.DatabaseError(GetInputArg(0));
      2: DB.DatabaseError(GetInputArg(0),TComponent(Integer(GetInputArg(1))));
    end;
  end;
end;

procedure TatDBLibrary.__DisposeMem(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    DB.DisposeMem(Param0,VarToInteger(GetInputArg(1)));
    SetInputArg(0,Param0);
  end;
end;

procedure TatDBLibrary.__GetFieldProperty(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(DB.GetFieldProperty(TDataSet(Integer(GetInputArg(0))),TComponent(Integer(GetInputArg(1))),GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBLibrary.__VarTypeToDataType(AMachine: TatVirtualMachine);
  var
  Param0: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := DB.VarTypeToDataType(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatDBLibrary.Init;
begin
  With Scripter.DefineClass(EDatabaseError) do
  begin
  end;
  With Scripter.DefineClass(EUpdateError) do
  begin
    DefineMethod('Create',5,tkClass,EUpdateError,__EUpdateErrorCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__EUpdateErrorDestroy,false,0);
    DefineProp('Context',tkVariant,__GetEUpdateErrorContext,nil,nil,false,0);
    DefineProp('ErrorCode',tkInteger,__GetEUpdateErrorErrorCode,nil,nil,false,0);
    DefineProp('PreviousError',tkInteger,__GetEUpdateErrorPreviousError,nil,nil,false,0);
    DefineProp('OriginalException',tkClass,__GetEUpdateErrorOriginalException,nil,Exception,false,0);
  end;
  With Scripter.DefineClass(TCustomConnection) do
  begin
    DefineMethod('Create',1,tkClass,TCustomConnection,__TCustomConnectionCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomConnectionDestroy,false,0);
    DefineMethod('Open',0,tkNone,nil,__TCustomConnectionOpen,false,0);
    DefineMethod('Close',0,tkNone,nil,__TCustomConnectionClose,false,0);
    DefineProp('Connected',tkVariant,__GetTCustomConnectionConnected,__SetTCustomConnectionConnected,nil,false,0);
    DefineProp('DataSets',tkClass,__GetTCustomConnectionDataSets,nil,TDataSet,false,1);
    DefineProp('DataSetCount',tkInteger,__GetTCustomConnectionDataSetCount,nil,nil,false,0);
    DefineProp('LoginPrompt',tkVariant,__GetTCustomConnectionLoginPrompt,__SetTCustomConnectionLoginPrompt,nil,false,0);
  end;
  With Scripter.DefineClass(TNamedItem) do
  begin
  end;
  With Scripter.DefineClass(TDefCollection) do
  begin
    DefineMethod('Find',1,tkClass,TNamedItem,__TDefCollectionFind,false,0);
    DefineMethod('GetItemNames',1,tkNone,nil,__TDefCollectionGetItemNames,false,0);
    DefineMethod('IndexOf',1,tkInteger,nil,__TDefCollectionIndexOf,false,0);
    DefineProp('DataSet',tkClass,__GetTDefCollectionDataSet,nil,TDataSet,false,0);
    DefineProp('Updated',tkVariant,__GetTDefCollectionUpdated,__SetTDefCollectionUpdated,nil,false,0);
  end;
  With Scripter.DefineClass(TFieldDef) do
  begin
    DefineMethod('Create',6,tkClass,TFieldDef,__TFieldDefCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TFieldDefDestroy,false,0);
    DefineMethod('AddChild',0,tkClass,TFieldDef,__TFieldDefAddChild,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TFieldDefAssign,false,0);
    DefineMethod('CreateField',4,tkClass,TField,__TFieldDefCreateField,false,3);
    DefineMethod('HasChildDefs',0,tkVariant,nil,__TFieldDefHasChildDefs,false,0);
    DefineProp('FieldNo',tkInteger,__GetTFieldDefFieldNo,__SetTFieldDefFieldNo,nil,false,0);
    DefineProp('InternalCalcField',tkVariant,__GetTFieldDefInternalCalcField,__SetTFieldDefInternalCalcField,nil,false,0);
    DefineProp('ParentDef',tkClass,__GetTFieldDefParentDef,nil,TFieldDef,false,0);
    DefineProp('Required',tkVariant,__GetTFieldDefRequired,__SetTFieldDefRequired,nil,false,0);
  end;
  With Scripter.DefineClass(TFieldDefs) do
  begin
    DefineMethod('Create',1,tkClass,TFieldDefs,__TFieldDefsCreate,true,0);
    DefineMethod('AddFieldDef',0,tkClass,TFieldDef,__TFieldDefsAddFieldDef,false,0);
    DefineMethod('Find',1,tkClass,TFieldDef,__TFieldDefsFind,false,0);
    DefineMethod('Update',0,tkNone,nil,__TFieldDefsUpdate,false,0);
    DefineMethod('Add',4,tkNone,nil,__TFieldDefsAdd,false,2);
    DefineProp('HiddenFields',tkVariant,__GetTFieldDefsHiddenFields,__SetTFieldDefsHiddenFields,nil,false,0);
    DefaultProperty := DefineProp('Items',tkClass,__GetTFieldDefsItems,__SetTFieldDefsItems,TFieldDef,false,1);
    DefineProp('ParentDef',tkClass,__GetTFieldDefsParentDef,nil,TFieldDef,false,0);
  end;
  With Scripter.DefineClass(TIndexDef) do
  begin
    DefineMethod('Create',4,tkClass,TIndexDef,__TIndexDefCreate,true,0);
    DefineMethod('Assign',1,tkNone,nil,__TIndexDefAssign,false,0);
    DefineProp('FieldExpression',tkVariant,__GetTIndexDefFieldExpression,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TIndexDefs) do
  begin
    DefineMethod('Create',1,tkClass,TIndexDefs,__TIndexDefsCreate,true,0);
    DefineMethod('AddIndexDef',0,tkClass,TIndexDef,__TIndexDefsAddIndexDef,false,0);
    DefineMethod('Find',1,tkClass,TIndexDef,__TIndexDefsFind,false,0);
    DefineMethod('Update',0,tkNone,nil,__TIndexDefsUpdate,false,0);
    DefineMethod('FindIndexForFields',1,tkClass,TIndexDef,__TIndexDefsFindIndexForFields,false,0);
    DefineMethod('GetIndexForFields',2,tkClass,TIndexDef,__TIndexDefsGetIndexForFields,false,0);
    DefineMethod('Add',3,tkNone,nil,__TIndexDefsAdd,false,0);
    DefaultProperty := DefineProp('Items',tkClass,__GetTIndexDefsItems,__SetTIndexDefsItems,TIndexDef,false,1);
  end;
  With Scripter.DefineClass(TFlatList) do
  begin
    DefineMethod('Create',1,tkClass,TFlatList,__TFlatListCreate,true,0);
    DefineMethod('Update',0,tkNone,nil,__TFlatListUpdate,false,0);
    DefineProp('DataSet',tkClass,__GetTFlatListDataSet,nil,TDataSet,false,0);
  end;
  With Scripter.DefineClass(TFieldDefList) do
  begin
    DefineMethod('FieldByName',1,tkClass,TFieldDef,__TFieldDefListFieldByName,false,0);
    DefineMethod('Find',1,tkClass,TFieldDef,__TFieldDefListFind,false,0);
    DefaultProperty := DefineProp('FieldDefs',tkClass,__GetTFieldDefListFieldDefs,nil,TFieldDef,false,1);
  end;
  With Scripter.DefineClass(TFieldList) do
  begin
    DefineMethod('FieldByName',1,tkClass,TField,__TFieldListFieldByName,false,0);
    DefineMethod('Find',1,tkClass,TField,__TFieldListFind,false,0);
    DefaultProperty := DefineProp('Fields',tkClass,__GetTFieldListFields,nil,TField,false,1);
  end;
  With Scripter.DefineClass(TFields) do
  begin
    DefineMethod('Create',1,tkClass,TFields,__TFieldsCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TFieldsDestroy,false,0);
    DefineMethod('Add',1,tkNone,nil,__TFieldsAdd,false,0);
    DefineMethod('CheckFieldName',1,tkNone,nil,__TFieldsCheckFieldName,false,0);
    DefineMethod('CheckFieldNames',1,tkNone,nil,__TFieldsCheckFieldNames,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TFieldsClear,false,0);
    DefineMethod('FindField',1,tkClass,TField,__TFieldsFindField,false,0);
    DefineMethod('FieldByName',1,tkClass,TField,__TFieldsFieldByName,false,0);
    DefineMethod('FieldByNumber',1,tkClass,TField,__TFieldsFieldByNumber,false,0);
    DefineMethod('GetFieldNames',1,tkNone,nil,__TFieldsGetFieldNames,false,0);
    DefineMethod('IndexOf',1,tkInteger,nil,__TFieldsIndexOf,false,0);
    DefineMethod('Remove',1,tkNone,nil,__TFieldsRemove,false,0);
    DefineProp('Count',tkInteger,__GetTFieldsCount,nil,nil,false,0);
    DefineProp('DataSet',tkClass,__GetTFieldsDataSet,nil,TDataSet,false,0);
    DefaultProperty := DefineProp('Fields',tkClass,__GetTFieldsFields,__SetTFieldsFields,TField,false,1);
  end;
  With Scripter.DefineClass(TLookupList) do
  begin
    DefineMethod('Create',0,tkClass,TLookupList,__TLookupListCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TLookupListDestroy,false,0);
    DefineMethod('Add',2,tkNone,nil,__TLookupListAdd,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TLookupListClear,false,0);
    DefineMethod('ValueOfKey',1,tkVariant,nil,__TLookupListValueOfKey,false,0);
  end;
  With Scripter.DefineClass(TField) do
  begin
    DefineMethod('Create',1,tkClass,TField,__TFieldCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TFieldDestroy,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TFieldAssign,false,0);
    DefineMethod('AssignValue',1,tkNone,nil,__TFieldAssignValue,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TFieldClear,false,0);
    DefineMethod('FocusControl',0,tkNone,nil,__TFieldFocusControl,false,0);
    DefineMethod('GetParentComponent',0,tkClass,TComponent,__TFieldGetParentComponent,false,0);
    DefineMethod('HasParent',0,tkVariant,nil,__TFieldHasParent,false,0);
    DefineMethod('IsBlob',0,tkVariant,nil,__TFieldIsBlob,true,0);
    DefineMethod('IsValidChar',1,tkVariant,nil,__TFieldIsValidChar,false,0);
    DefineMethod('RefreshLookupList',0,tkNone,nil,__TFieldRefreshLookupList,false,0);
    DefineMethod('SetFieldType',1,tkNone,nil,__TFieldSetFieldType,false,0);
    DefineProp('AsBCD',tkVariant,__GetTFieldAsBCD,__SetTFieldAsBCD,nil,false,0);
    DefineProp('AsBoolean',tkVariant,__GetTFieldAsBoolean,__SetTFieldAsBoolean,nil,false,0);
    DefineProp('AsCurrency',tkVariant,__GetTFieldAsCurrency,__SetTFieldAsCurrency,nil,false,0);
    DefineProp('AsDateTime',tkVariant,__GetTFieldAsDateTime,__SetTFieldAsDateTime,nil,false,0);
    DefineProp('AsSQLTimeStamp',tkVariant,__GetTFieldAsSQLTimeStamp,__SetTFieldAsSQLTimeStamp,nil,false,0);
    DefineProp('AsFloat',tkVariant,__GetTFieldAsFloat,__SetTFieldAsFloat,nil,false,0);
    DefineProp('AsInteger',tkInteger,__GetTFieldAsInteger,__SetTFieldAsInteger,nil,false,0);
    DefineProp('AsString',tkVariant,__GetTFieldAsString,__SetTFieldAsString,nil,false,0);
    DefineProp('AsVariant',tkVariant,__GetTFieldAsVariant,__SetTFieldAsVariant,nil,false,0);
    DefineProp('AttributeSet',tkVariant,__GetTFieldAttributeSet,__SetTFieldAttributeSet,nil,false,0);
    DefineProp('Calculated',tkVariant,__GetTFieldCalculated,__SetTFieldCalculated,nil,false,0);
    DefineProp('CanModify',tkVariant,__GetTFieldCanModify,nil,nil,false,0);
    DefineProp('CurValue',tkVariant,__GetTFieldCurValue,nil,nil,false,0);
    DefineProp('DataSet',tkClass,__GetTFieldDataSet,__SetTFieldDataSet,TDataSet,false,0);
    DefineProp('DataSize',tkInteger,__GetTFieldDataSize,nil,nil,false,0);
    DefineProp('DataType',tkEnumeration,__GetTFieldDataType,nil,nil,false,0);
    DefineProp('DisplayName',tkVariant,__GetTFieldDisplayName,nil,nil,false,0);
    DefineProp('DisplayText',tkVariant,__GetTFieldDisplayText,nil,nil,false,0);
    DefineProp('EditMask',tkVariant,__GetTFieldEditMask,__SetTFieldEditMask,nil,false,0);
    DefineProp('EditMaskPtr',tkVariant,__GetTFieldEditMaskPtr,nil,nil,false,0);
    DefineProp('FieldNo',tkInteger,__GetTFieldFieldNo,nil,nil,false,0);
    DefineProp('FullName',tkVariant,__GetTFieldFullName,nil,nil,false,0);
    DefineProp('IsIndexField',tkVariant,__GetTFieldIsIndexField,nil,nil,false,0);
    DefineProp('IsNull',tkVariant,__GetTFieldIsNull,nil,nil,false,0);
    DefineProp('Lookup',tkVariant,__GetTFieldLookup,__SetTFieldLookup,nil,false,0);
    DefineProp('LookupList',tkClass,__GetTFieldLookupList,nil,TLookupList,false,0);
    DefineProp('NewValue',tkVariant,__GetTFieldNewValue,__SetTFieldNewValue,nil,false,0);
    DefineProp('Offset',tkInteger,__GetTFieldOffset,nil,nil,false,0);
    DefineProp('OldValue',tkVariant,__GetTFieldOldValue,nil,nil,false,0);
    DefineProp('ParentField',tkClass,__GetTFieldParentField,__SetTFieldParentField,TObjectField,false,0);
    DefineProp('Size',tkInteger,__GetTFieldSize,__SetTFieldSize,nil,false,0);
    DefineProp('Text',tkVariant,__GetTFieldText,__SetTFieldText,nil,false,0);
    DefineProp('ValidChars',tkInteger,__GetTFieldValidChars,__SetTFieldValidChars,nil,false,0);
    DefineProp('Value',tkVariant,__GetTFieldValue,__SetTFieldValue,nil,false,0);
  end;
  With Scripter.DefineClass(TStringField) do
  begin
    DefineMethod('Create',1,tkClass,TStringField,__TStringFieldCreate,true,0);
    DefineProp('Value',tkVariant,__GetTStringFieldValue,__SetTStringFieldValue,nil,false,0);
  end;
  With Scripter.DefineClass(TWideStringField) do
  begin
    DefineMethod('Create',1,tkClass,TWideStringField,__TWideStringFieldCreate,true,0);
    DefineProp('Value',tkVariant,__GetTWideStringFieldValue,__SetTWideStringFieldValue,nil,false,0);
  end;
  With Scripter.DefineClass(TNumericField) do
  begin
    DefineMethod('Create',1,tkClass,TNumericField,__TNumericFieldCreate,true,0);
  end;
  With Scripter.DefineClass(TIntegerField) do
  begin
    DefineMethod('Create',1,tkClass,TIntegerField,__TIntegerFieldCreate,true,0);
    DefineProp('Value',tkInteger,__GetTIntegerFieldValue,__SetTIntegerFieldValue,nil,false,0);
  end;
  With Scripter.DefineClass(TSmallintField) do
  begin
    DefineMethod('Create',1,tkClass,TSmallintField,__TSmallintFieldCreate,true,0);
  end;
  With Scripter.DefineClass(TLargeintField) do
  begin
    DefineMethod('Create',1,tkClass,TLargeintField,__TLargeintFieldCreate,true,0);
    DefineProp('AsLargeInt',tkVariant,__GetTLargeintFieldAsLargeInt,__SetTLargeintFieldAsLargeInt,nil,false,0);
    DefineProp('Value',tkVariant,__GetTLargeintFieldValue,__SetTLargeintFieldValue,nil,false,0);
  end;
  With Scripter.DefineClass(TWordField) do
  begin
    DefineMethod('Create',1,tkClass,TWordField,__TWordFieldCreate,true,0);
  end;
  With Scripter.DefineClass(TAutoIncField) do
  begin
    DefineMethod('Create',1,tkClass,TAutoIncField,__TAutoIncFieldCreate,true,0);
  end;
  With Scripter.DefineClass(TFloatField) do
  begin
    DefineMethod('Create',1,tkClass,TFloatField,__TFloatFieldCreate,true,0);
    DefineProp('Value',tkVariant,__GetTFloatFieldValue,__SetTFloatFieldValue,nil,false,0);
  end;
  With Scripter.DefineClass(TCurrencyField) do
  begin
    DefineMethod('Create',1,tkClass,TCurrencyField,__TCurrencyFieldCreate,true,0);
  end;
  With Scripter.DefineClass(TBooleanField) do
  begin
    DefineMethod('Create',1,tkClass,TBooleanField,__TBooleanFieldCreate,true,0);
    DefineProp('Value',tkVariant,__GetTBooleanFieldValue,__SetTBooleanFieldValue,nil,false,0);
  end;
  With Scripter.DefineClass(TDateTimeField) do
  begin
    DefineMethod('Create',1,tkClass,TDateTimeField,__TDateTimeFieldCreate,true,0);
    DefineProp('Value',tkVariant,__GetTDateTimeFieldValue,__SetTDateTimeFieldValue,nil,false,0);
  end;
  With Scripter.DefineClass(TSQLTimeStampField) do
  begin
    DefineMethod('Create',1,tkClass,TSQLTimeStampField,__TSQLTimeStampFieldCreate,true,0);
    DefineProp('Value',tkVariant,__GetTSQLTimeStampFieldValue,__SetTSQLTimeStampFieldValue,nil,false,0);
  end;
  With Scripter.DefineClass(TDateField) do
  begin
    DefineMethod('Create',1,tkClass,TDateField,__TDateFieldCreate,true,0);
  end;
  With Scripter.DefineClass(TTimeField) do
  begin
    DefineMethod('Create',1,tkClass,TTimeField,__TTimeFieldCreate,true,0);
  end;
  With Scripter.DefineClass(TBinaryField) do
  begin
    DefineMethod('Create',1,tkClass,TBinaryField,__TBinaryFieldCreate,true,0);
  end;
  With Scripter.DefineClass(TBytesField) do
  begin
    DefineMethod('Create',1,tkClass,TBytesField,__TBytesFieldCreate,true,0);
  end;
  With Scripter.DefineClass(TVarBytesField) do
  begin
    DefineMethod('Create',1,tkClass,TVarBytesField,__TVarBytesFieldCreate,true,0);
  end;
  With Scripter.DefineClass(TBCDField) do
  begin
    DefineMethod('Create',1,tkClass,TBCDField,__TBCDFieldCreate,true,0);
    DefineProp('Value',tkVariant,__GetTBCDFieldValue,__SetTBCDFieldValue,nil,false,0);
  end;
  With Scripter.DefineClass(TFMTBCDField) do
  begin
    DefineMethod('Create',1,tkClass,TFMTBCDField,__TFMTBCDFieldCreate,true,0);
    DefineProp('Value',tkVariant,__GetTFMTBCDFieldValue,__SetTFMTBCDFieldValue,nil,false,0);
  end;
  With Scripter.DefineClass(TBlobField) do
  begin
    DefineMethod('Create',1,tkClass,TBlobField,__TBlobFieldCreate,true,0);
    DefineMethod('Assign',1,tkNone,nil,__TBlobFieldAssign,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TBlobFieldClear,false,0);
    DefineMethod('IsBlob',0,tkVariant,nil,__TBlobFieldIsBlob,true,0);
    DefineMethod('LoadFromFile',1,tkNone,nil,__TBlobFieldLoadFromFile,false,0);
    DefineMethod('LoadFromStream',1,tkNone,nil,__TBlobFieldLoadFromStream,false,0);
    DefineMethod('SaveToFile',1,tkNone,nil,__TBlobFieldSaveToFile,false,0);
    DefineMethod('SaveToStream',1,tkNone,nil,__TBlobFieldSaveToStream,false,0);
    DefineMethod('SetFieldType',1,tkNone,nil,__TBlobFieldSetFieldType,false,0);
    DefineProp('BlobSize',tkInteger,__GetTBlobFieldBlobSize,nil,nil,false,0);
    DefineProp('Modified',tkVariant,__GetTBlobFieldModified,__SetTBlobFieldModified,nil,false,0);
    DefineProp('Value',tkVariant,__GetTBlobFieldValue,__SetTBlobFieldValue,nil,false,0);
    DefineProp('Transliterate',tkVariant,__GetTBlobFieldTransliterate,__SetTBlobFieldTransliterate,nil,false,0);
  end;
  With Scripter.DefineClass(TMemoField) do
  begin
    DefineMethod('Create',1,tkClass,TMemoField,__TMemoFieldCreate,true,0);
  end;
  With Scripter.DefineClass(TGraphicField) do
  begin
    DefineMethod('Create',1,tkClass,TGraphicField,__TGraphicFieldCreate,true,0);
  end;
  With Scripter.DefineClass(TObjectField) do
  begin
    DefineMethod('Create',1,tkClass,TObjectField,__TObjectFieldCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TObjectFieldDestroy,false,0);
    DefineProp('FieldCount',tkInteger,__GetTObjectFieldFieldCount,nil,nil,false,0);
    DefineProp('Fields',tkClass,__GetTObjectFieldFields,nil,TFields,false,0);
    DefaultProperty := DefineProp('FieldValues',tkVariant,__GetTObjectFieldFieldValues,__SetTObjectFieldFieldValues,nil,false,1);
    DefineProp('UnNamed',tkVariant,__GetTObjectFieldUnNamed,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TADTField) do
  begin
    DefineMethod('Create',1,tkClass,TADTField,__TADTFieldCreate,true,0);
  end;
  With Scripter.DefineClass(TArrayField) do
  begin
    DefineMethod('Create',1,tkClass,TArrayField,__TArrayFieldCreate,true,0);
    DefineProp('Size',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TDataSetField) do
  begin
    DefineMethod('Create',1,tkClass,TDataSetField,__TDataSetFieldCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDataSetFieldDestroy,false,0);
    DefineProp('NestedDataSet',tkClass,__GetTDataSetFieldNestedDataSet,nil,TDataSet,false,0);
  end;
  With Scripter.DefineClass(TReferenceField) do
  begin
    DefineMethod('Create',1,tkClass,TReferenceField,__TReferenceFieldCreate,true,0);
    DefineMethod('Assign',1,tkNone,nil,__TReferenceFieldAssign,false,0);
  end;
  With Scripter.DefineClass(TVariantField) do
  begin
    DefineMethod('Create',1,tkClass,TVariantField,__TVariantFieldCreate,true,0);
  end;
  With Scripter.DefineClass(TInterfaceField) do
  begin
    DefineMethod('Create',1,tkClass,TInterfaceField,__TInterfaceFieldCreate,true,0);
  end;
  With Scripter.DefineClass(TIDispatchField) do
  begin
    DefineMethod('Create',1,tkClass,TIDispatchField,__TIDispatchFieldCreate,true,0);
  end;
  With Scripter.DefineClass(TGuidField) do
  begin
    DefineMethod('Create',1,tkClass,TGuidField,__TGuidFieldCreate,true,0);
    DefineProp('AsGuid',tkVariant,__GetTGuidFieldAsGuid,__SetTGuidFieldAsGuid,nil,false,0);
  end;
  With Scripter.DefineClass(TAggregateField) do
  begin
    DefineMethod('Create',1,tkClass,TAggregateField,__TAggregateFieldCreate,true,0);
    DefineProp('ResultType',tkEnumeration,__GetTAggregateFieldResultType,__SetTAggregateFieldResultType,nil,false,0);
  end;
  With Scripter.DefineClass(TDataLink) do
  begin
    DefineMethod('Create',0,tkClass,TDataLink,__TDataLinkCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDataLinkDestroy,false,0);
    DefineMethod('Edit',0,tkVariant,nil,__TDataLinkEdit,false,0);
    DefineMethod('ExecuteAction',1,tkVariant,nil,__TDataLinkExecuteAction,false,0);
    DefineMethod('UpdateAction',1,tkVariant,nil,__TDataLinkUpdateAction,false,0);
    DefineMethod('UpdateRecord',0,tkNone,nil,__TDataLinkUpdateRecord,false,0);
    DefineProp('Active',tkVariant,__GetTDataLinkActive,nil,nil,false,0);
    DefineProp('ActiveRecord',tkInteger,__GetTDataLinkActiveRecord,__SetTDataLinkActiveRecord,nil,false,0);
    DefineProp('BOF',tkVariant,__GetTDataLinkBOF,nil,nil,false,0);
    DefineProp('BufferCount',tkInteger,__GetTDataLinkBufferCount,__SetTDataLinkBufferCount,nil,false,0);
    DefineProp('DataSet',tkClass,__GetTDataLinkDataSet,nil,TDataSet,false,0);
    DefineProp('DataSource',tkClass,__GetTDataLinkDataSource,__SetTDataLinkDataSource,TDataSource,false,0);
    DefineProp('DataSourceFixed',tkVariant,__GetTDataLinkDataSourceFixed,__SetTDataLinkDataSourceFixed,nil,false,0);
    DefineProp('Editing',tkVariant,__GetTDataLinkEditing,nil,nil,false,0);
    DefineProp('Eof',tkVariant,__GetTDataLinkEof,nil,nil,false,0);
    DefineProp('ReadOnly',tkVariant,__GetTDataLinkReadOnly,__SetTDataLinkReadOnly,nil,false,0);
    DefineProp('RecordCount',tkInteger,__GetTDataLinkRecordCount,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TDetailDataLink) do
  begin
    DefineProp('DetailDataSet',tkClass,__GetTDetailDataLinkDetailDataSet,nil,TDataSet,false,0);
  end;
  With Scripter.DefineClass(TMasterDataLink) do
  begin
    DefineMethod('Create',1,tkClass,TMasterDataLink,__TMasterDataLinkCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TMasterDataLinkDestroy,false,0);
    DefineProp('FieldNames',tkVariant,__GetTMasterDataLinkFieldNames,__SetTMasterDataLinkFieldNames,nil,false,0);
    DefineProp('Fields',tkClass,__GetTMasterDataLinkFields,nil,TList,false,0);
  end;
  With Scripter.DefineClass(TDataSource) do
  begin
    DefineMethod('Create',1,tkClass,TDataSource,__TDataSourceCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDataSourceDestroy,false,0);
    DefineMethod('Edit',0,tkNone,nil,__TDataSourceEdit,false,0);
    DefineMethod('IsLinkedTo',1,tkVariant,nil,__TDataSourceIsLinkedTo,false,0);
    DefineProp('State',tkEnumeration,__GetTDataSourceState,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TDataSetDesigner) do
  begin
    DefineMethod('Create',1,tkClass,TDataSetDesigner,__TDataSetDesignerCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDataSetDesignerDestroy,false,0);
    DefineMethod('BeginDesign',0,tkNone,nil,__TDataSetDesignerBeginDesign,false,0);
    DefineMethod('DataEvent',2,tkNone,nil,__TDataSetDesignerDataEvent,false,0);
    DefineMethod('EndDesign',0,tkNone,nil,__TDataSetDesignerEndDesign,false,0);
    DefineProp('DataSet',tkClass,__GetTDataSetDesignerDataSet,nil,TDataSet,false,0);
  end;
  With Scripter.DefineClass(TCheckConstraint) do
  begin
    DefineMethod('Assign',1,tkNone,nil,__TCheckConstraintAssign,false,0);
    DefineMethod('GetDisplayName',0,tkVariant,nil,__TCheckConstraintGetDisplayName,false,0);
  end;
  With Scripter.DefineClass(TCheckConstraints) do
  begin
    DefineMethod('Create',1,tkClass,TCheckConstraints,__TCheckConstraintsCreate,true,0);
    DefineMethod('Add',0,tkClass,TCheckConstraint,__TCheckConstraintsAdd,false,0);
    DefaultProperty := DefineProp('Items',tkClass,__GetTCheckConstraintsItems,__SetTCheckConstraintsItems,TCheckConstraint,false,1);
  end;
  With Scripter.DefineClass(TParam) do
  begin
    DefineMethod('Create',1,tkClass,TParam,__TParamCreate,true,0);
    DefineMethod('Assign',1,tkNone,nil,__TParamAssign,false,0);
    DefineMethod('AssignField',1,tkNone,nil,__TParamAssignField,false,0);
    DefineMethod('AssignFieldValue',2,tkNone,nil,__TParamAssignFieldValue,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TParamClear,false,0);
    DefineMethod('GetDataSize',0,tkInteger,nil,__TParamGetDataSize,false,0);
    DefineMethod('LoadFromFile',2,tkNone,nil,__TParamLoadFromFile,false,0);
    DefineMethod('LoadFromStream',2,tkNone,nil,__TParamLoadFromStream,false,0);
    DefineProp('AsBCD',tkVariant,__GetTParamAsBCD,__SetTParamAsBCD,nil,false,0);
    DefineProp('AsFMTBCD',tkVariant,__GetTParamAsFMTBCD,__SetTParamAsFMTBCD,nil,false,0);
    DefineProp('AsBlob',tkVariant,__GetTParamAsBlob,__SetTParamAsBlob,nil,false,0);
    DefineProp('AsBoolean',tkVariant,__GetTParamAsBoolean,__SetTParamAsBoolean,nil,false,0);
    DefineProp('AsCurrency',tkVariant,__GetTParamAsCurrency,__SetTParamAsCurrency,nil,false,0);
    DefineProp('AsDate',tkVariant,__GetTParamAsDate,__SetTParamAsDate,nil,false,0);
    DefineProp('AsDateTime',tkVariant,__GetTParamAsDateTime,__SetTParamAsDateTime,nil,false,0);
    DefineProp('AsFloat',tkVariant,__GetTParamAsFloat,__SetTParamAsFloat,nil,false,0);
    DefineProp('AsInteger',tkInteger,__GetTParamAsInteger,__SetTParamAsInteger,nil,false,0);
    DefineProp('AsSmallInt',tkInteger,__GetTParamAsSmallInt,__SetTParamAsSmallInt,nil,false,0);
    DefineProp('AsSQLTimeStamp',tkVariant,__GetTParamAsSQLTimeStamp,__SetTParamAsSQLTimeStamp,nil,false,0);
    DefineProp('AsMemo',tkVariant,__GetTParamAsMemo,__SetTParamAsMemo,nil,false,0);
    DefineProp('AsString',tkVariant,__GetTParamAsString,__SetTParamAsString,nil,false,0);
    DefineProp('AsTime',tkVariant,__GetTParamAsTime,__SetTParamAsTime,nil,false,0);
    DefineProp('AsWord',tkInteger,__GetTParamAsWord,__SetTParamAsWord,nil,false,0);
    DefineProp('Bound',tkVariant,__GetTParamBound,__SetTParamBound,nil,false,0);
    DefineProp('IsNull',tkVariant,__GetTParamIsNull,nil,nil,false,0);
    DefineProp('NativeStr',tkVariant,__GetTParamNativeStr,__SetTParamNativeStr,nil,false,0);
    DefineProp('Text',tkVariant,__GetTParamText,__SetTParamText,nil,false,0);
  end;
  With Scripter.DefineClass(TParams) do
  begin
    DefineMethod('Create',1,tkClass,TParams,__TParamsCreate,true,0);
    DefineMethod('AssignValues',1,tkNone,nil,__TParamsAssignValues,false,0);
    DefineMethod('AddParam',1,tkNone,nil,__TParamsAddParam,false,0);
    DefineMethod('RemoveParam',1,tkNone,nil,__TParamsRemoveParam,false,0);
    DefineMethod('CreateParam',3,tkClass,TParam,__TParamsCreateParam,false,0);
    DefineMethod('GetParamList',2,tkNone,nil,__TParamsGetParamList,false,0);
    DefineMethod('IsEqual',1,tkVariant,nil,__TParamsIsEqual,false,0);
    DefineMethod('ParseSQL',2,tkVariant,nil,__TParamsParseSQL,false,0);
    DefineMethod('ParamByName',1,tkClass,TParam,__TParamsParamByName,false,0);
    DefineMethod('FindParam',1,tkClass,TParam,__TParamsFindParam,false,0);
    DefaultProperty := DefineProp('Items',tkClass,__GetTParamsItems,__SetTParamsItems,TParam,false,1);
    DefineProp('ParamValues',tkVariant,__GetTParamsParamValues,__SetTParamsParamValues,nil,false,1);
  end;
  With Scripter.DefineClass(TDataSet) do
  begin
    DefineMethod('Create',1,tkClass,TDataSet,__TDataSetCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDataSetDestroy,false,0);
    DefineMethod('ActiveBuffer',0,tkVariant,nil,__TDataSetActiveBuffer,false,0);
    DefineMethod('Append',0,tkNone,nil,__TDataSetAppend,false,0);
    DefineMethod('Cancel',0,tkNone,nil,__TDataSetCancel,false,0);
    DefineMethod('CheckBrowseMode',0,tkNone,nil,__TDataSetCheckBrowseMode,false,0);
    DefineMethod('ClearFields',0,tkNone,nil,__TDataSetClearFields,false,0);
    DefineMethod('Close',0,tkNone,nil,__TDataSetClose,false,0);
    DefineMethod('ControlsDisabled',0,tkVariant,nil,__TDataSetControlsDisabled,false,0);
    DefineMethod('CreateBlobStream',2,tkClass,TStream,__TDataSetCreateBlobStream,false,0);
    DefineMethod('CursorPosChanged',0,tkNone,nil,__TDataSetCursorPosChanged,false,0);
    DefineMethod('Delete',0,tkNone,nil,__TDataSetDelete,false,0);
    DefineMethod('DisableControls',0,tkNone,nil,__TDataSetDisableControls,false,0);
    DefineMethod('Edit',0,tkNone,nil,__TDataSetEdit,false,0);
    DefineMethod('EnableControls',0,tkNone,nil,__TDataSetEnableControls,false,0);
    DefineMethod('FieldByName',1,tkClass,TField,__TDataSetFieldByName,false,0);
    DefineMethod('FindField',1,tkClass,TField,__TDataSetFindField,false,0);
    DefineMethod('FindFirst',0,tkVariant,nil,__TDataSetFindFirst,false,0);
    DefineMethod('FindLast',0,tkVariant,nil,__TDataSetFindLast,false,0);
    DefineMethod('FindNext',0,tkVariant,nil,__TDataSetFindNext,false,0);
    DefineMethod('FindPrior',0,tkVariant,nil,__TDataSetFindPrior,false,0);
    DefineMethod('First',0,tkNone,nil,__TDataSetFirst,false,0);
    DefineMethod('GetCurrentRecord',1,tkVariant,nil,__TDataSetGetCurrentRecord,false,0);
    DefineMethod('GetDetailDataSets',1,tkNone,nil,__TDataSetGetDetailDataSets,false,0);
    DefineMethod('GetDetailLinkFields',2,tkNone,nil,__TDataSetGetDetailLinkFields,false,0);
    DefineMethod('GetFieldList',2,tkNone,nil,__TDataSetGetFieldList,false,0);
    DefineMethod('GetFieldNames',1,tkNone,nil,__TDataSetGetFieldNames,false,0);
    DefineMethod('Insert',0,tkNone,nil,__TDataSetInsert,false,0);
    DefineMethod('IsEmpty',0,tkVariant,nil,__TDataSetIsEmpty,false,0);
    DefineMethod('IsLinkedTo',1,tkVariant,nil,__TDataSetIsLinkedTo,false,0);
    DefineMethod('IsSequenced',0,tkVariant,nil,__TDataSetIsSequenced,false,0);
    DefineMethod('Last',0,tkNone,nil,__TDataSetLast,false,0);
    DefineMethod('Locate',3,tkVariant,nil,__TDataSetLocate,false,0);
    DefineMethod('Lookup',3,tkVariant,nil,__TDataSetLookup,false,0);
    DefineMethod('MoveBy',1,tkInteger,nil,__TDataSetMoveBy,false,0);
    DefineMethod('Next',0,tkNone,nil,__TDataSetNext,false,0);
    DefineMethod('Open',0,tkNone,nil,__TDataSetOpen,false,0);
    DefineMethod('Post',0,tkNone,nil,__TDataSetPost,false,0);
    DefineMethod('Prior',0,tkNone,nil,__TDataSetPrior,false,0);
    DefineMethod('Refresh',0,tkNone,nil,__TDataSetRefresh,false,0);
    DefineMethod('Resync',1,tkNone,nil,__TDataSetResync,false,0);
    DefineMethod('Translate',3,tkInteger,nil,__TDataSetTranslate,false,0);
    DefineMethod('UpdateCursorPos',0,tkNone,nil,__TDataSetUpdateCursorPos,false,0);
    DefineMethod('UpdateRecord',0,tkNone,nil,__TDataSetUpdateRecord,false,0);
    DefineMethod('UpdateStatus',0,tkEnumeration,nil,__TDataSetUpdateStatus,false,0);
    DefineProp('AggFields',tkClass,__GetTDataSetAggFields,nil,TFields,false,0);
    DefineProp('Bof',tkVariant,__GetTDataSetBof,nil,nil,false,0);
    DefineProp('Bookmark',tkVariant,__GetTDataSetBookmark,__SetTDataSetBookmark,nil,false,0);
    DefineProp('CanModify',tkVariant,__GetTDataSetCanModify,nil,nil,false,0);
    DefineProp('DataSetField',tkClass,__GetTDataSetDataSetField,__SetTDataSetDataSetField,TDataSetField,false,0);
    DefineProp('DataSource',tkClass,__GetTDataSetDataSource,nil,TDataSource,false,0);
    DefineProp('DefaultFields',tkVariant,__GetTDataSetDefaultFields,nil,nil,false,0);
    DefineProp('Designer',tkClass,__GetTDataSetDesigner,nil,TDataSetDesigner,false,0);
    DefineProp('Eof',tkVariant,__GetTDataSetEof,nil,nil,false,0);
    DefineProp('BlockReadSize',tkInteger,__GetTDataSetBlockReadSize,__SetTDataSetBlockReadSize,nil,false,0);
    DefineProp('FieldCount',tkInteger,__GetTDataSetFieldCount,nil,nil,false,0);
    DefineProp('FieldDefs',tkClass,__GetTDataSetFieldDefs,__SetTDataSetFieldDefs,TFieldDefs,false,0);
    DefineProp('FieldDefList',tkClass,__GetTDataSetFieldDefList,nil,TFieldDefList,false,0);
    DefineProp('Fields',tkClass,__GetTDataSetFields,nil,TFields,false,0);
    DefineProp('FieldList',tkClass,__GetTDataSetFieldList,nil,TFieldList,false,0);
    DefaultProperty := DefineProp('FieldValues',tkVariant,__GetTDataSetFieldValues,__SetTDataSetFieldValues,nil,false,1);
    DefineProp('Found',tkVariant,__GetTDataSetFound,nil,nil,false,0);
    DefineProp('IsUniDirectional',tkVariant,__GetTDataSetIsUniDirectional,nil,nil,false,0);
    DefineProp('Modified',tkVariant,__GetTDataSetModified,nil,nil,false,0);
    DefineProp('ObjectView',tkVariant,__GetTDataSetObjectView,__SetTDataSetObjectView,nil,false,0);
    DefineProp('RecordCount',tkInteger,__GetTDataSetRecordCount,nil,nil,false,0);
    DefineProp('RecNo',tkInteger,__GetTDataSetRecNo,__SetTDataSetRecNo,nil,false,0);
    DefineProp('RecordSize',tkInteger,__GetTDataSetRecordSize,nil,nil,false,0);
    DefineProp('SparseArrays',tkVariant,__GetTDataSetSparseArrays,__SetTDataSetSparseArrays,nil,false,0);
    DefineProp('State',tkEnumeration,__GetTDataSetState,nil,nil,false,0);
    DefineProp('Filter',tkVariant,__GetTDataSetFilter,__SetTDataSetFilter,nil,false,0);
    DefineProp('Filtered',tkVariant,__GetTDataSetFiltered,__SetTDataSetFiltered,nil,false,0);
    DefineProp('FilterOptions',tkInteger,__GetTDataSetFilterOptions,__SetTDataSetFilterOptions,nil,false,0);
    DefineProp('Active',tkVariant,__GetTDataSetActive,__SetTDataSetActive,nil,false,0);
    DefineProp('AutoCalcFields',tkVariant,__GetTDataSetAutoCalcFields,__SetTDataSetAutoCalcFields,nil,false,0);
  end;
  DefineEventAdapter(TypeInfo(TUpdateErrorEvent), TatDBDispatcher, @TatDBDispatcher.__TUpdateErrorEvent);
  DefineEventAdapter(TypeInfo(TUpdateRecordEvent), TatDBDispatcher, @TatDBDispatcher.__TUpdateRecordEvent);
  DefineEventAdapter(TypeInfo(TLoginEvent), TatDBDispatcher, @TatDBDispatcher.__TLoginEvent);
  DefineEventAdapter(TypeInfo(TConnectChangeEvent), TatDBDispatcher, @TatDBDispatcher.__TConnectChangeEvent);
  DefineEventAdapter(TypeInfo(TDefUpdateMethod), TatDBDispatcher, @TatDBDispatcher.__TDefUpdateMethod);
  DefineEventAdapter(TypeInfo(TFieldNotifyEvent), TatDBDispatcher, @TatDBDispatcher.__TFieldNotifyEvent);
  DefineEventAdapter(TypeInfo(TFieldGetTextEvent), TatDBDispatcher, @TatDBDispatcher.__TFieldGetTextEvent);
  DefineEventAdapter(TypeInfo(TFieldSetTextEvent), TatDBDispatcher, @TatDBDispatcher.__TFieldSetTextEvent);
  DefineEventAdapter(TypeInfo(TDataChangeEvent), TatDBDispatcher, @TatDBDispatcher.__TDataChangeEvent);
  DefineEventAdapter(TypeInfo(TDataSetNotifyEvent), TatDBDispatcher, @TatDBDispatcher.__TDataSetNotifyEvent);
  DefineEventAdapter(TypeInfo(TDataSetErrorEvent), TatDBDispatcher, @TatDBDispatcher.__TDataSetErrorEvent);
  DefineEventAdapter(TypeInfo(TFilterRecordEvent), TatDBDispatcher, @TatDBDispatcher.__TFilterRecordEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('ExtractFieldName',2,tkVariant,nil,__ExtractFieldName,false,0).SetVarArgs([1]);
    DefineMethod('DatabaseError',2,tkNone,nil,__DatabaseError,false,1);
    DefineMethod('DisposeMem',2,tkNone,nil,__DisposeMem,false,0).SetVarArgs([0]);
    DefineMethod('GetFieldProperty',3,tkClass,TField,__GetFieldProperty,false,0);
    DefineMethod('VarTypeToDataType',1,tkEnumeration,nil,__VarTypeToDataType,false,0).SetVarArgs([0]);
    AddConstant('ftUnknown',ftUnknown);
    AddConstant('ftString',ftString);
    AddConstant('ftSmallint',ftSmallint);
    AddConstant('ftInteger',ftInteger);
    AddConstant('ftWord',ftWord);
    AddConstant('ftBoolean',ftBoolean);
    AddConstant('ftFloat',ftFloat);
    AddConstant('ftCurrency',ftCurrency);
    AddConstant('ftBCD',ftBCD);
    AddConstant('ftDate',ftDate);
    AddConstant('ftTime',ftTime);
    AddConstant('ftDateTime',ftDateTime);
    AddConstant('ftBytes',ftBytes);
    AddConstant('ftVarBytes',ftVarBytes);
    AddConstant('ftAutoInc',ftAutoInc);
    AddConstant('ftBlob',ftBlob);
    AddConstant('ftMemo',ftMemo);
    AddConstant('ftGraphic',ftGraphic);
    AddConstant('ftFmtMemo',ftFmtMemo);
    AddConstant('ftParadoxOle',ftParadoxOle);
    AddConstant('ftDBaseOle',ftDBaseOle);
    AddConstant('ftTypedBinary',ftTypedBinary);
    AddConstant('ftCursor',ftCursor);
    AddConstant('ftFixedChar',ftFixedChar);
    AddConstant('ftWideString',ftWideString);
    AddConstant('ftLargeint',ftLargeint);
    AddConstant('ftADT',ftADT);
    AddConstant('ftArray',ftArray);
    AddConstant('ftReference',ftReference);
    AddConstant('ftDataSet',ftDataSet);
    AddConstant('ftOraBlob',ftOraBlob);
    AddConstant('ftOraClob',ftOraClob);
    AddConstant('ftVariant',ftVariant);
    AddConstant('ftInterface',ftInterface);
    AddConstant('ftIDispatch',ftIDispatch);
    AddConstant('ftGuid',ftGuid);
    AddConstant('ftTimeStamp',ftTimeStamp);
    AddConstant('ftFMTBcd',ftFMTBcd);
    AddConstant('dsInactive',dsInactive);
    AddConstant('dsBrowse',dsBrowse);
    AddConstant('dsEdit',dsEdit);
    AddConstant('dsInsert',dsInsert);
    AddConstant('dsSetKey',dsSetKey);
    AddConstant('dsCalcFields',dsCalcFields);
    AddConstant('dsFilter',dsFilter);
    AddConstant('dsNewValue',dsNewValue);
    AddConstant('dsOldValue',dsOldValue);
    AddConstant('dsCurValue',dsCurValue);
    AddConstant('dsBlockRead',dsBlockRead);
    AddConstant('dsInternalCalc',dsInternalCalc);
    AddConstant('dsOpening',dsOpening);
    AddConstant('deFieldChange',deFieldChange);
    AddConstant('deRecordChange',deRecordChange);
    AddConstant('deDataSetChange',deDataSetChange);
    AddConstant('deDataSetScroll',deDataSetScroll);
    AddConstant('deLayoutChange',deLayoutChange);
    AddConstant('deUpdateRecord',deUpdateRecord);
    AddConstant('deUpdateState',deUpdateState);
    AddConstant('deCheckBrowseMode',deCheckBrowseMode);
    AddConstant('dePropertyChange',dePropertyChange);
    AddConstant('deFieldListChange',deFieldListChange);
    AddConstant('deFocusControl',deFocusControl);
    AddConstant('deParentScroll',deParentScroll);
    AddConstant('deConnectChange',deConnectChange);
    AddConstant('usUnmodified',usUnmodified);
    AddConstant('usModified',usModified);
    AddConstant('usInserted',usInserted);
    AddConstant('usDeleted',usDeleted);
    AddConstant('uaFail',uaFail);
    AddConstant('uaAbort',uaAbort);
    AddConstant('uaSkip',uaSkip);
    AddConstant('uaRetry',uaRetry);
    AddConstant('uaApplied',uaApplied);
    AddConstant('upWhereAll',upWhereAll);
    AddConstant('upWhereChanged',upWhereChanged);
    AddConstant('upWhereKeyOnly',upWhereKeyOnly);
    AddConstant('ukModify',ukModify);
    AddConstant('ukInsert',ukInsert);
    AddConstant('ukDelete',ukDelete);
    AddConstant('faHiddenCol',faHiddenCol);
    AddConstant('faReadonly',faReadonly);
    AddConstant('faRequired',faRequired);
    AddConstant('faLink',faLink);
    AddConstant('faUnNamed',faUnNamed);
    AddConstant('faFixed',faFixed);
    AddConstant('ixPrimary',ixPrimary);
    AddConstant('ixUnique',ixUnique);
    AddConstant('ixDescending',ixDescending);
    AddConstant('ixCaseInsensitive',ixCaseInsensitive);
    AddConstant('ixExpression',ixExpression);
    AddConstant('ixNonMaintained',ixNonMaintained);
    AddConstant('fkData',fkData);
    AddConstant('fkCalculated',fkCalculated);
    AddConstant('fkLookup',fkLookup);
    AddConstant('fkInternalCalc',fkInternalCalc);
    AddConstant('fkAggregate',fkAggregate);
    AddConstant('pfInUpdate',pfInUpdate);
    AddConstant('pfInWhere',pfInWhere);
    AddConstant('pfInKey',pfInKey);
    AddConstant('pfHidden',pfHidden);
    AddConstant('arNone',arNone);
    AddConstant('arAutoInc',arAutoInc);
    AddConstant('arDefault',arDefault);
    AddConstant('ptUnknown',ptUnknown);
    AddConstant('ptInput',ptInput);
    AddConstant('ptOutput',ptOutput);
    AddConstant('ptInputOutput',ptInputOutput);
    AddConstant('ptResult',ptResult);
    AddConstant('bfCurrent',bfCurrent);
    AddConstant('bfBOF',bfBOF);
    AddConstant('bfEOF',bfEOF);
    AddConstant('bfInserted',bfInserted);
    AddConstant('gmCurrent',gmCurrent);
    AddConstant('gmNext',gmNext);
    AddConstant('gmPrior',gmPrior);
    AddConstant('grOK',grOK);
    AddConstant('grBOF',grBOF);
    AddConstant('grEOF',grEOF);
    AddConstant('grError',grError);
    AddConstant('daFail',daFail);
    AddConstant('daAbort',daAbort);
    AddConstant('daRetry',daRetry);
    AddConstant('bmRead',bmRead);
    AddConstant('bmWrite',bmWrite);
    AddConstant('bmReadWrite',bmReadWrite);
    AddConstant('loCaseInsensitive',loCaseInsensitive);
    AddConstant('loPartialKey',loPartialKey);
    AddConstant('foCaseInsensitive',foCaseInsensitive);
    AddConstant('foNoPartialCompare',foNoPartialCompare);
    AddConstant('gbFirst',gbFirst);
    AddConstant('gbMiddle',gbMiddle);
    AddConstant('gbLast',gbLast);
    AddConstant('dcrDefault',dcrDefault);
    AddConstant('dcrHourGlass',dcrHourGlass);
    AddConstant('dcrSQLWait',dcrSQLWait);
    AddConstant('dcrOther',dcrOther);
    AddConstant('ftNonTextTypes',IntFromConstSet(ftNonTextTypes));
    AddConstant('ftFixedSizeTypes',IntFromConstSet(ftFixedSizeTypes));
    AddConstant('dsEditModes',IntFromConstSet(dsEditModes));
    AddConstant('dsWriteModes',IntFromConstSet(dsWriteModes));
    AddConstant('ObjectFieldTypes',IntFromConstSet(ObjectFieldTypes));
    AddConstant('dsMaxStringSize',dsMaxStringSize);
  end;
end;

class function TatDBLibrary.LibraryName: string;
begin
  result := 'DB';
end;

initialization
  RegisterScripterLibrary(TatDBLibrary, True);

{$WARNINGS ON}

end.

