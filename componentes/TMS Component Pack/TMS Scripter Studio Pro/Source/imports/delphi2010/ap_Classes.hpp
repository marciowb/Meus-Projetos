// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Ap_classes.pas' rev: 21.00

#ifndef Ap_classesHPP
#define Ap_classesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Typinfo.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Ap_types.hpp>	// Pascal unit
#include <Ap_system.hpp>	// Pascal unit
#include <Atscript.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ap_classes
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TatClassesLibrary;
class PASCALIMPLEMENTATION TatClassesLibrary : public Atscript::TatScripterLibrary
{
	typedef Atscript::TatScripterLibrary inherited;
	
public:
	void __fastcall __TListEnumeratorCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListEnumeratorMoveNext(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TThreadListCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TThreadListDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TThreadListClear(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TThreadListLockList(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TThreadListUnlockList(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTThreadListDuplicates(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTThreadListDuplicates(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TInterfaceListEnumeratorCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TInterfaceListEnumeratorGetCurrent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TInterfaceListEnumeratorMoveNext(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTInterfaceListEnumeratorCurrent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TInterfaceListCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TInterfaceListDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TInterfaceListClear(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TInterfaceListDelete(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TInterfaceListExchange(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TInterfaceListExpand(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TInterfaceListFirst(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TInterfaceListIndexOf(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TInterfaceListIndexOfItem(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TInterfaceListAdd(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TInterfaceListInsert(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TInterfaceListLast(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TInterfaceListRemove(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TInterfaceListRemoveItem(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TInterfaceListLock(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TInterfaceListUnlock(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TInterfaceListGetEnumerator(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTInterfaceListCapacity(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTInterfaceListCapacity(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTInterfaceListCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTInterfaceListCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTInterfaceListItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTInterfaceListItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBitsDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBitsOpenBit(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTBitsBits(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTBitsBits(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTBitsSize(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTBitsSize(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPersistentDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPersistentAssign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TPersistentGetNamePath(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TInterfacedPersistentQueryInterface(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TInterfacedPersistentAfterConstruction(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TRecallCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TRecallDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TRecallStore(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TRecallForget(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTRecallReference(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCollectionItemCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCollectionItemDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCollectionItemGetNamePath(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCollectionItemCollection(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCollectionItemCollection(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCollectionItemID(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCollectionItemIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCollectionItemIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCollectionItemDisplayName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCollectionItemDisplayName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCollectionEnumeratorCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCollectionEnumeratorGetCurrent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCollectionEnumeratorMoveNext(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCollectionEnumeratorCurrent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCollectionDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCollectionOwner(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCollectionAdd(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCollectionAssign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCollectionBeginUpdate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCollectionClear(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCollectionDelete(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCollectionEndUpdate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCollectionFindItemID(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCollectionGetEnumerator(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCollectionGetNamePath(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCollectionInsert(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCollectionCapacity(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCollectionCapacity(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCollectionCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCollectionItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCollectionItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringsEnumeratorCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringsEnumeratorGetCurrent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringsEnumeratorMoveNext(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTStringsEnumeratorCurrent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringsDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringsAdd(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringsAddObject(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringsAppend(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringsAddStrings(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringsAssign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringsBeginUpdate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringsClear(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringsDelete(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringsEndUpdate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringsEquals(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringsExchange(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringsGetEnumerator(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringsGetText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringsIndexOf(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringsIndexOfName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringsIndexOfObject(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringsInsert(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringsInsertObject(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringsLoadFromFile(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringsLoadFromStream(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringsMove(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringsSaveToFile(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringsSaveToStream(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringsSetText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTStringsCapacity(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTStringsCapacity(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTStringsCommaText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTStringsCommaText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTStringsCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTStringsDelimiter(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTStringsDelimiter(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTStringsDelimitedText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTStringsDelimitedText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTStringsLineBreak(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTStringsLineBreak(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTStringsNames(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTStringsObjects(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTStringsObjects(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTStringsQuoteChar(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTStringsQuoteChar(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTStringsValues(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTStringsValues(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTStringsValueFromIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTStringsValueFromIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTStringsNameValueSeparator(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTStringsNameValueSeparator(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTStringsStrictDelimiter(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTStringsStrictDelimiter(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTStringsStrings(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTStringsStrings(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTStringsText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTStringsText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringListCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringListDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringListAdd(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringListAddObject(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringListClear(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringListDelete(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringListExchange(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringListFind(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringListIndexOf(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringListInsert(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringListInsertObject(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringListSort(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTStringListDuplicates(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTStringListDuplicates(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTStringListSorted(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTStringListSorted(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTStringListCaseSensitive(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTStringListCaseSensitive(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTStringListOwnsObjects(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTStringListOwnsObjects(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamRead(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamWrite(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamSeek(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamReadBuffer(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamWriteBuffer(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamCopyFrom(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamReadComponent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamReadComponentRes(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamWriteComponent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamWriteComponentRes(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamWriteDescendent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamWriteDescendentRes(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamWriteResourceHeader(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamFixupResourceHeader(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamReadResHeader(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTStreamPosition(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTStreamPosition(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTStreamSize(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTStreamSize(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __THandleStreamCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __THandleStreamRead(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __THandleStreamWrite(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTHandleStreamHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TFileStreamCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TFileStreamDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTFileStreamFileName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomMemoryStreamRead(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomMemoryStreamSeek(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomMemoryStreamSaveToStream(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomMemoryStreamSaveToFile(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMemoryStreamDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMemoryStreamClear(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMemoryStreamLoadFromStream(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMemoryStreamLoadFromFile(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMemoryStreamSetSize(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMemoryStreamWrite(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTBytesStreamBytes(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringStreamCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringStreamRead(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringStreamReadString(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringStreamSeek(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringStreamWrite(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringStreamWriteString(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTStringStreamDataString(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TResourceStreamCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TResourceStreamCreateFromID(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TResourceStreamDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TResourceStreamWrite(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamAdapterCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamAdapterDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamAdapterSeek(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamAdapterSetSize(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamAdapterCommit(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamAdapterRevert(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamAdapterLockRegion(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamAdapterUnlockRegion(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTStreamAdapterStream(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTStreamAdapterStreamOwnership(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTStreamAdapterStreamOwnership(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TClassFinderDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TFilerCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TFilerDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TFilerFlushBuffer(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTFilerRoot(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTFilerRoot(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTFilerLookupRoot(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTFilerAncestor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTFilerAncestor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTFilerIgnoreChildren(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTFilerIgnoreChildren(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderBeginReferences(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderCheckValue(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderEndOfList(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderEndReferences(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderFixupReferences(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderFlushBuffer(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderNextValue(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderRead(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderReadBoolean(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderReadChar(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderReadWideChar(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderReadCollection(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderReadComponent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderReadFloat(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderReadSingle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderReadDouble(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderReadCurrency(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderReadDate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderReadIdent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderReadInteger(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderReadInt64(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderReadListBegin(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderReadListEnd(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderReadPrefix(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderReadRootComponent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderReadSignature(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderReadStr(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderReadString(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderReadWideString(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderReadValue(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderReadVariant(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderCopyValue(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TReaderSkipValue(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTReaderOwner(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTReaderOwner(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTReaderParent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTReaderParent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTReaderPosition(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTReaderPosition(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWriterDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWriterFlushBuffer(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWriterWrite(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWriterWriteBoolean(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWriterWriteCollection(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWriterWriteComponent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWriterWriteChar(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWriterWriteWideChar(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWriterWriteDescendent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWriterWriteFloat(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWriterWriteSingle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWriterWriteDouble(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWriterWriteCurrency(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWriterWriteDate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWriterWriteIdent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWriterWriteInteger(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWriterWriteListBegin(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWriterWriteListEnd(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWriterWriteRootComponent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWriterWriteSignature(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWriterWriteStr(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWriterWriteUTF8Str(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWriterWriteString(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWriterWriteWideString(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWriterWriteVariant(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTWriterPosition(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTWriterPosition(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTWriterRootAncestor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTWriterRootAncestor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTWriterUseQualifiedNames(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTWriterUseQualifiedNames(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComponentEnumeratorCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComponentEnumeratorGetCurrent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComponentEnumeratorMoveNext(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTComponentEnumeratorCurrent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComponentCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComponentDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComponentBeforeDestruction(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComponentDestroyComponents(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComponentDestroying(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComponentExecuteAction(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComponentFindComponent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComponentFreeNotification(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComponentRemoveFreeNotification(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComponentFreeOnRelease(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComponentGetEnumerator(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComponentGetParentComponent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComponentGetNamePath(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComponentHasParent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComponentInsertComponent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComponentRemoveComponent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComponentSetSubComponent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComponentUpdateAction(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComponentIsImplementorOf(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TComponentReferenceInterface(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTComponentComObject(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTComponentComponents(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTComponentComponentCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTComponentComponentIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTComponentComponentIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTComponentComponentState(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTComponentComponentStyle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTComponentDesignInfo(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTComponentDesignInfo(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTComponentOwner(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBasicActionLinkCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBasicActionLinkDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBasicActionLinkExecute(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBasicActionLinkUpdate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTBasicActionLinkAction(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTBasicActionLinkAction(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBasicActionCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBasicActionDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBasicActionHandlesTarget(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBasicActionUpdateTarget(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBasicActionExecuteTarget(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBasicActionExecute(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBasicActionRegisterChanges(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBasicActionUnRegisterChanges(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBasicActionUpdate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTBasicActionActionComponent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTBasicActionActionComponent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDataModuleCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDataModuleCreateNew(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDataModuleDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDataModuleAfterConstruction(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDataModuleBeforeDestruction(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDataModuleDesignOffset(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTDataModuleDesignOffset(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDataModuleDesignSize(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTDataModuleDesignSize(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTextReaderClose(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTextReaderPeek(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTextReaderRead(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTextReaderReadBlock(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTextReaderReadLine(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TTextReaderReadToEnd(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringReaderCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringReaderClose(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringReaderPeek(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringReaderRead(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringReaderReadBlock(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringReaderReadLine(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStringReaderReadToEnd(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamReaderCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamReaderDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamReaderClose(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamReaderDiscardBufferedData(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamReaderPeek(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamReaderRead(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamReaderReadBlock(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamReaderReadLine(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TStreamReaderReadToEnd(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTStreamReaderBaseStream(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTStreamReaderCurrentEncoding(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTStreamReaderEndOfStream(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Point(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SmallPoint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __PointsEqual(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __InvalidPoint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Rect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Bounds(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __UnRegisterModuleClasses(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __FindGlobalComponent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __IsUniqueGlobalComponentName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __InitComponentRes(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ReadComponentRes(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ReadComponentResEx(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ReadComponentResFile(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __WriteComponentResFile(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GlobalFixupReferences(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetFixupReferenceNames(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetFixupInstanceNames(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __RedirectFixupReferences(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __RemoveFixupReferences(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __RemoveFixups(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __FindNestedComponent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __BeginGlobalLoading(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __NotifyGlobalLoading(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __EndGlobalLoading(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CollectionsEqual(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetUltimateOwner(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ObjectBinaryToText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ObjectTextToBinary(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ObjectResourceToText(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ObjectTextToResource(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TestStreamFormat(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetResourceName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __WriteObjectResourceHeader(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Write16bitResourceHeader(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Write32bitResourceHeader(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __LineStart(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ExtractStrings(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __BinToHex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __HexToBin(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CheckSynchronize(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __DeallocateHWnd(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __AncestorIsValid(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetCurrentGroup(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetCurrentGroup(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListClear(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListDelete(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListError(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListExchange(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListExpand(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListGetEnumerator(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListMove(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListPack(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TListAssign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListCapacity(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTListCapacity(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTListCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTListCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TParserDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TParserCheckToken(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TParserCheckTokenSymbol(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TParserError(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TParserErrorStr(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TParserHexToBinary(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TParserNextToken(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TParserSourcePos(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TParserTokenComponentIdent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TParserTokenFloat(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TParserTokenInt(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TParserTokenString(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TParserTokenWideString(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TParserTokenSymbolIs(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTParserFloatType(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTParserSourceLine(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTParserLinePos(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTParserToken(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TThreadCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TThreadDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TThreadAfterConstruction(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TThreadResume(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TThreadSuspend(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TThreadTerminate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TThreadWaitFor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTThreadExternalThread(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTThreadFatalException(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTThreadFreeOnTerminate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTThreadFreeOnTerminate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTThreadFinished(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTThreadHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTThreadPriority(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTThreadPriority(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTThreadSuspended(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTThreadSuspended(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTThreadThreadID(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTThreadCurrentThread(Atscript::TatVirtualMachine* AMachine);
	virtual void __fastcall Init(void);
	__classmethod virtual System::UnicodeString __fastcall LibraryName();
public:
	/* TatScripterLibrary.Create */ inline __fastcall virtual TatClassesLibrary(Atscript::TatCustomScripter* AScripter) : Atscript::TatScripterLibrary(AScripter) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TatClassesLibrary(void) { }
	
};


typedef TMetaClass* EStreamErrorClass;

typedef TMetaClass* EFileStreamErrorClass;

typedef TMetaClass* EFCreateErrorClass;

typedef TMetaClass* EFOpenErrorClass;

typedef TMetaClass* EFilerErrorClass;

typedef TMetaClass* EReadErrorClass;

typedef TMetaClass* EWriteErrorClass;

typedef TMetaClass* EClassNotFoundClass;

typedef TMetaClass* EMethodNotFoundClass;

typedef TMetaClass* EInvalidImageClass;

typedef TMetaClass* EResNotFoundClass;

typedef TMetaClass* EListErrorClass;

typedef TMetaClass* EBitsErrorClass;

typedef TMetaClass* EStringListErrorClass;

typedef TMetaClass* EComponentErrorClass;

typedef TMetaClass* EParserErrorClass;

typedef TMetaClass* EOutOfResourcesClass;

typedef TMetaClass* EInvalidOperationClass;

typedef TMetaClass* TListEnumeratorClass;

typedef TMetaClass* TListClass;

typedef TMetaClass* TThreadListClass;

typedef TMetaClass* TInterfaceListEnumeratorClass;

typedef TMetaClass* TInterfaceListClass;

typedef TMetaClass* TBitsClass;

typedef TMetaClass* TPersistentClass;

typedef TMetaClass* TInterfacedPersistentClass;

typedef TMetaClass* TRecallClass;

typedef TMetaClass* TCollectionItemClass;

typedef TMetaClass* TCollectionEnumeratorClass;

typedef TMetaClass* TCollectionClass;

typedef TMetaClass* TOwnedCollectionClass;

typedef TMetaClass* TStringsEnumeratorClass;

typedef TMetaClass* TStringsClass;

typedef TMetaClass* TStringListClass;

typedef TMetaClass* TStreamClass;

typedef TMetaClass* THandleStreamClass;

typedef TMetaClass* TFileStreamClass;

typedef TMetaClass* TCustomMemoryStreamClass;

typedef TMetaClass* TMemoryStreamClass;

typedef TMetaClass* TBytesStreamClass;

typedef TMetaClass* TStringStreamClass;

typedef TMetaClass* TResourceStreamClass;

typedef TMetaClass* TStreamAdapterClass;

typedef TMetaClass* TClassFinderClass;

typedef TMetaClass* TFilerClass;

typedef TMetaClass* TReaderClass;

typedef TMetaClass* TWriterClass;

typedef TMetaClass* TParserClass;

typedef TMetaClass* EThreadClass;

typedef TMetaClass* TThreadClass;

typedef TMetaClass* TComponentEnumeratorClass;

typedef TMetaClass* TComponentClass;

typedef TMetaClass* TBasicActionLinkClass;

typedef TMetaClass* TBasicActionClass;

typedef TMetaClass* TDataModuleClass;

typedef TMetaClass* TTextReaderClass;

typedef TMetaClass* TStringReaderClass;

typedef TMetaClass* TStreamReaderClass;

class DELPHICLASS TatClassesDispatcher;
class PASCALIMPLEMENTATION TatClassesDispatcher : public Atscript::TatEventDispatcher
{
	typedef Atscript::TatEventDispatcher inherited;
	
private:
	void __fastcall __TNotifyEvent(System::TObject* Sender);
	void __fastcall __TGetStrProc(const System::UnicodeString S);
	void __fastcall __TGetModuleProc(const System::UnicodeString FileName, const System::UnicodeString UnitName, const System::UnicodeString FormName, const System::UnicodeString DesignClass, Classes::TStrings* CoClasses);
	void __fastcall __TReaderProc(Classes::TReader* Reader);
	void __fastcall __TWriterProc(Classes::TWriter* Writer);
	void __fastcall __TStreamProc(Classes::TStream* Stream);
	void __fastcall __TSetNameEvent(Classes::TReader* Reader, Classes::TComponent* Component, System::UnicodeString &Name);
	void __fastcall __TReferenceNameEvent(Classes::TReader* Reader, System::UnicodeString &Name);
	void __fastcall __TReadComponentsProc(Classes::TComponent* Component);
	void __fastcall __TReaderError(Classes::TReader* Reader, const System::UnicodeString Message, bool &Handled);
	void __fastcall __TFindAncestorEvent(Classes::TWriter* Writer, Classes::TComponent* Component, const System::UnicodeString Name, Classes::TComponent* &Ancestor, Classes::TComponent* &RootAncestor);
	void __fastcall __TGetLookupInfoEvent(Classes::TPersistent* &Ancestor, Classes::TComponent* &Root, Classes::TComponent* &LookupRoot, Classes::TComponent* &RootAncestor);
	void __fastcall __TParserErrorEvent(System::TObject* Sender, const System::UnicodeString Message, bool &Handled);
	void __fastcall __TThreadMethod(void);
	void __fastcall __TGetChildProc(Classes::TComponent* Child);
public:
	/* TatEventDispatcher.Create */ inline __fastcall virtual TatClassesDispatcher(Classes::TCollection* ACollection) : Atscript::TatEventDispatcher(ACollection) { }
	/* TatEventDispatcher.Destroy */ inline __fastcall virtual ~TatClassesDispatcher(void) { }
	
};


class DELPHICLASS TStringItemWrapper;
class PASCALIMPLEMENTATION TStringItemWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::UnicodeString FFString;
	System::TObject* FFObject;
	
public:
	__fastcall TStringItemWrapper(const Classes::TStringItem &ARecord);
	Classes::TStringItem __fastcall ObjToRec(void);
	
__published:
	__property System::UnicodeString FString = {read=FFString, write=FFString};
	__property System::TObject* FObject = {read=FFObject, write=FFObject};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TStringItemWrapper(void) { }
	
};


class DELPHICLASS TIdentMapEntryWrapper;
class PASCALIMPLEMENTATION TIdentMapEntryWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FValue;
	System::UnicodeString FName;
	
public:
	__fastcall TIdentMapEntryWrapper(const Classes::TIdentMapEntry &ARecord);
	Classes::TIdentMapEntry __fastcall ObjToRec(void);
	
__published:
	__property int Value = {read=FValue, write=FValue, nodefault};
	__property System::UnicodeString Name = {read=FName, write=FName};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TIdentMapEntryWrapper(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Ap_classes */
using namespace Ap_classes;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Ap_classesHPP
