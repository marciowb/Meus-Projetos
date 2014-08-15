// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ap_System.pas' rev: 22.00

#ifndef Ap_systemHPP
#define Ap_systemHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <atScript.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ap_system
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TatDelphiSystemLibrary;
class PASCALIMPLEMENTATION TatDelphiSystemLibrary : public Atscript::TatScripterLibrary
{
	typedef Atscript::TatScripterLibrary inherited;
	
public:
	void __fastcall __TObjectCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TObjectFree(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TObjectCleanupInstance(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TObjectClassName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TObjectClassNameIs(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TObjectInstanceSize(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TObjectGetInterface(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TObjectUnitName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TObjectEquals(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TObjectGetHashCode(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TObjectToString(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TObjectAfterConstruction(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TObjectBeforeDestruction(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TObjectDispatch(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TObjectDefaultHandler(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TObjectNewInstance(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TObjectFreeInstance(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TObjectDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TInterfacedObjectAfterConstruction(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TInterfacedObjectBeforeDestruction(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TInterfacedObjectNewInstance(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTInterfacedObjectRefCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __MonitorEnter(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __MonitorTryEnter(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __MonitorExit(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __MonitorWait(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __MonitorPulse(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __MonitorPulseAll(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __MemoryBarrier(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __YieldProcessor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ReleaseExceptionObject(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ExceptObject(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetInOutRes(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetMemoryManager(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetMemoryManager(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __IsMemoryManagerSet(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetHeapStatus(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetMemoryManagerState(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetMinimumBlockAlignment(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetMinimumBlockAlignment(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __AttemptToUseSharedMemoryManager(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ShareMemoryManager(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __EndThread(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ChDir(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __IOResult(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __MkDir(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Move(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __MoveChars(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ParamCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ParamStr(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __RmDir(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __UpCase(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Randomize(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Random(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Set8087CW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Get8087CW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __WideCharToString(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __WideCharLenToString(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __WideCharToStrVar(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __WideCharLenToStrVar(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __StringToWideChar(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __UnicodeToUtf8(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Utf8ToUnicode(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __UTF8Encode(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __UTF8EncodeToShortString(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __UTF8Decode(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __UTF8ToWideString(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __UTF8ToUnicodeString(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __UTF8ToString(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __AnsiToUtf8(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Utf8ToAnsi(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __OleStrToString(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __OleStrToStrVar(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __StringToOleStr(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetVariantManager(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetVariantManager(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __IsVariantManagerSet(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __FindResourceHInstance(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __LoadResourceModule(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Int(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Frac(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Exp(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Cos(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Sin(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Ln(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ArcTan(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Sqrt(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Mark(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Release(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __UniqueString(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __StringElementSize(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __StringCodePage(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __StringRefCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetCodePage(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Pos(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __FPower10(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TextStart(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CompToDouble(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __DoubleToComp(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CompToCurrency(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CurrencyToComp(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __StringOfChar(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Error(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetLastError(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetLastError(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetMultiByteConversionCodePage(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetHPrevInst(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetHPrevInst(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetMainInstance(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetMainInstance(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetMainThreadID(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetMainThreadID(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetIsLibrary(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetIsLibrary(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetCmdShow(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetCmdShow(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetCmdLine(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetCmdLine(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetExitCode(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetExitCode(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetRandSeed(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetRandSeed(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetIsConsole(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetIsConsole(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetIsMultiThread(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetIsMultiThread(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetFileMode(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetFileMode(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTest8086(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTest8086(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTest8087(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTest8087(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTestFDIV(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTestFDIV(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetCPUCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetCPUCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetDefault8087CW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetDefault8087CW(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetHeapAllocFlags(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetHeapAllocFlags(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetDebugHook(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetDebugHook(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetJITEnable(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetJITEnable(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetNoErrMsg(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetNoErrMsg(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetDefaultSystemCodePage(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetDefaultSystemCodePage(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetDefaultUnicodeCodePage(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetDefaultUnicodeCodePage(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetUTF8CompareLocale(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetUTF8CompareLocale(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetDefaultTextLineBreakStyle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetDefaultTextLineBreakStyle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetAllocMemCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetAllocMemCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetAllocMemSize(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetAllocMemSize(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetReportMemoryLeaksOnShutdown(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetReportMemoryLeaksOnShutdown(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetNeverSleepOnMMThreadContention(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetNeverSleepOnMMThreadContention(Atscript::TatVirtualMachine* AMachine);
	virtual void __fastcall Init(void);
	__classmethod virtual System::UnicodeString __fastcall LibraryName();
public:
	/* TatScripterLibrary.Create */ inline __fastcall virtual TatDelphiSystemLibrary(Atscript::TatCustomScripter* AScripter) : Atscript::TatScripterLibrary(AScripter) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TatDelphiSystemLibrary(void) { }
	
};


typedef TMetaClass* TObjectClass;

typedef TMetaClass* TInterfacedObjectClass;

typedef TMetaClass* TAggregatedObjectClass;

typedef TMetaClass* TContainedObjectClass;

typedef TMetaClass* TClassHelperBaseClass;

class DELPHICLASS TGUIDWrapper;
class PASCALIMPLEMENTATION TGUIDWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FD1;
	System::Word FD2;
	System::Word FD3;
	
public:
	__fastcall TGUIDWrapper(const GUID &ARecord);
	GUID __fastcall ObjToRec(void);
	
__published:
	__property unsigned D1 = {read=FD1, write=FD1, nodefault};
	__property System::Word D2 = {read=FD2, write=FD2, nodefault};
	__property System::Word D3 = {read=FD3, write=FD3, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TGUIDWrapper(void) { }
	
};


class DELPHICLASS TInterfaceEntryWrapper;
class PASCALIMPLEMENTATION TInterfaceEntryWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FIOffset;
	int FImplGetter;
	
public:
	__fastcall TInterfaceEntryWrapper(const System::TInterfaceEntry &ARecord);
	System::TInterfaceEntry __fastcall ObjToRec(void);
	
__published:
	__property int IOffset = {read=FIOffset, write=FIOffset, nodefault};
	__property int ImplGetter = {read=FImplGetter, write=FImplGetter, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TInterfaceEntryWrapper(void) { }
	
};


class DELPHICLASS TInterfaceTableWrapper;
class PASCALIMPLEMENTATION TInterfaceTableWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FEntryCount;
	
public:
	__fastcall TInterfaceTableWrapper(const System::TInterfaceTable &ARecord);
	System::TInterfaceTable __fastcall ObjToRec(void);
	
__published:
	__property int EntryCount = {read=FEntryCount, write=FEntryCount, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TInterfaceTableWrapper(void) { }
	
};


class DELPHICLASS TMethodWrapper;
class PASCALIMPLEMENTATION TMethodWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall TMethodWrapper(const System::TMethod &ARecord);
	System::TMethod __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMethodWrapper(void) { }
	
};


class DELPHICLASS TDispatchMessageWrapper;
class PASCALIMPLEMENTATION TDispatchMessageWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FMsgID;
	
public:
	__fastcall TDispatchMessageWrapper(System::TDispatchMessage ARecord);
	System::TDispatchMessage __fastcall ObjToRec(void);
	
__published:
	__property System::Word MsgID = {read=FMsgID, write=FMsgID, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TDispatchMessageWrapper(void) { }
	
};


class DELPHICLASS TVarArrayBoundWrapper;
class PASCALIMPLEMENTATION TVarArrayBoundWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FElementCount;
	int FLowBound;
	
public:
	__fastcall TVarArrayBoundWrapper(const System::TVarArrayBound &ARecord);
	System::TVarArrayBound __fastcall ObjToRec(void);
	
__published:
	__property int ElementCount = {read=FElementCount, write=FElementCount, nodefault};
	__property int LowBound = {read=FLowBound, write=FLowBound, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TVarArrayBoundWrapper(void) { }
	
};


class DELPHICLASS TVarArrayWrapper;
class PASCALIMPLEMENTATION TVarArrayWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FDimCount;
	System::Word FFlags;
	int FElementSize;
	int FLockCount;
	
public:
	__fastcall TVarArrayWrapper(const System::TVarArray &ARecord);
	System::TVarArray __fastcall ObjToRec(void);
	
__published:
	__property System::Word DimCount = {read=FDimCount, write=FDimCount, nodefault};
	__property System::Word Flags = {read=FFlags, write=FFlags, nodefault};
	__property int ElementSize = {read=FElementSize, write=FElementSize, nodefault};
	__property int LockCount = {read=FLockCount, write=FLockCount, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TVarArrayWrapper(void) { }
	
};


class DELPHICLASS TVarDataWrapper;
class PASCALIMPLEMENTATION TVarDataWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Word FVType;
	System::Word FReserved1;
	System::Word FReserved2;
	System::Word FReserved3;
	short FVSmallInt;
	int FVInteger;
	float FVSingle;
	double FVDouble;
	System::Currency FVCurrency;
	System::TDateTime FVDate;
	HRESULT FVError;
	System::WordBool FVBoolean;
	System::ShortInt FVShortInt;
	System::Byte FVByte;
	System::Word FVWord;
	unsigned FVLongWord;
	__int64 FVInt64;
	unsigned __int64 FVUInt64;
	
public:
	__fastcall TVarDataWrapper(const TVarData &ARecord);
	TVarData __fastcall ObjToRec(void);
	
__published:
	__property System::Word VType = {read=FVType, write=FVType, nodefault};
	__property System::Word Reserved1 = {read=FReserved1, write=FReserved1, nodefault};
	__property System::Word Reserved2 = {read=FReserved2, write=FReserved2, nodefault};
	__property System::Word Reserved3 = {read=FReserved3, write=FReserved3, nodefault};
	__property short VSmallInt = {read=FVSmallInt, write=FVSmallInt, nodefault};
	__property int VInteger = {read=FVInteger, write=FVInteger, nodefault};
	__property float VSingle = {read=FVSingle, write=FVSingle};
	__property double VDouble = {read=FVDouble, write=FVDouble};
	__property System::Currency VCurrency = {read=FVCurrency, write=FVCurrency};
	__property System::TDateTime VDate = {read=FVDate, write=FVDate};
	__property HRESULT VError = {read=FVError, write=FVError, nodefault};
	__property System::WordBool VBoolean = {read=FVBoolean, write=FVBoolean, nodefault};
	__property System::ShortInt VShortInt = {read=FVShortInt, write=FVShortInt, nodefault};
	__property System::Byte VByte = {read=FVByte, write=FVByte, nodefault};
	__property System::Word VWord = {read=FVWord, write=FVWord, nodefault};
	__property unsigned VLongWord = {read=FVLongWord, write=FVLongWord, nodefault};
	__property __int64 VInt64 = {read=FVInt64, write=FVInt64};
	__property unsigned __int64 VUInt64 = {read=FVUInt64, write=FVUInt64};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TVarDataWrapper(void) { }
	
};


class DELPHICLASS TCallDescWrapper;
class PASCALIMPLEMENTATION TCallDescWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Byte FCallType;
	System::Byte FArgCount;
	System::Byte FNamedArgCount;
	
public:
	__fastcall TCallDescWrapper(const System::TCallDesc &ARecord);
	System::TCallDesc __fastcall ObjToRec(void);
	
__published:
	__property System::Byte CallType = {read=FCallType, write=FCallType, nodefault};
	__property System::Byte ArgCount = {read=FArgCount, write=FArgCount, nodefault};
	__property System::Byte NamedArgCount = {read=FNamedArgCount, write=FNamedArgCount, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCallDescWrapper(void) { }
	
};


class DELPHICLASS TDispDescWrapper;
class PASCALIMPLEMENTATION TDispDescWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FDispID;
	System::Byte FResType;
	
public:
	__fastcall TDispDescWrapper(const System::TDispDesc &ARecord);
	System::TDispDesc __fastcall ObjToRec(void);
	
__published:
	__property int DispID = {read=FDispID, write=FDispID, nodefault};
	__property System::Byte ResType = {read=FResType, write=FResType, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TDispDescWrapper(void) { }
	
};


class DELPHICLASS TVariantManagerWrapper;
class PASCALIMPLEMENTATION TVariantManagerWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall TVariantManagerWrapper(const System::TVariantManager &ARecord);
	System::TVariantManager __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TVariantManagerWrapper(void) { }
	
};


class DELPHICLASS TDynArrayTypeInfoWrapper;
class PASCALIMPLEMENTATION TDynArrayTypeInfoWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	System::Byte Fkind;
	int FelSize;
	int FvarType;
	
public:
	__fastcall TDynArrayTypeInfoWrapper(const TDynArrayTypeInfo &ARecord);
	TDynArrayTypeInfo __fastcall ObjToRec(void);
	
__published:
	__property System::Byte kind = {read=Fkind, write=Fkind, nodefault};
	__property int elSize = {read=FelSize, write=FelSize, nodefault};
	__property int varType = {read=FvarType, write=FvarType, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TDynArrayTypeInfoWrapper(void) { }
	
};


class DELPHICLASS TVarRecWrapper;
class PASCALIMPLEMENTATION TVarRecWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FVInteger;
	System::Byte FVType;
	bool FVBoolean;
	char FVChar;
	System::TObject* FVObject;
	
public:
	__fastcall TVarRecWrapper(const System::TVarRec &ARecord);
	System::TVarRec __fastcall ObjToRec(void);
	
__published:
	__property int VInteger = {read=FVInteger, write=FVInteger, nodefault};
	__property System::Byte VType = {read=FVType, write=FVType, nodefault};
	__property bool VBoolean = {read=FVBoolean, write=FVBoolean, nodefault};
	__property char VChar = {read=FVChar, write=FVChar, nodefault};
	__property System::TObject* VObject = {read=FVObject, write=FVObject};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TVarRecWrapper(void) { }
	
};


class DELPHICLASS TMemoryManagerWrapper;
class PASCALIMPLEMENTATION TMemoryManagerWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall TMemoryManagerWrapper(const System::TMemoryManager &ARecord);
	System::TMemoryManager __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMemoryManagerWrapper(void) { }
	
};


class DELPHICLASS TMemoryManagerExWrapper;
class PASCALIMPLEMENTATION TMemoryManagerExWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall TMemoryManagerExWrapper(const System::TMemoryManagerEx &ARecord);
	System::TMemoryManagerEx __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMemoryManagerExWrapper(void) { }
	
};


class DELPHICLASS THeapStatusWrapper;
class PASCALIMPLEMENTATION THeapStatusWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FTotalAddrSpace;
	unsigned FTotalUncommitted;
	unsigned FTotalCommitted;
	unsigned FTotalAllocated;
	unsigned FTotalFree;
	unsigned FFreeSmall;
	unsigned FFreeBig;
	unsigned FUnused;
	unsigned FOverhead;
	unsigned FHeapErrorCode;
	
public:
	__fastcall THeapStatusWrapper(const System::THeapStatus &ARecord);
	System::THeapStatus __fastcall ObjToRec(void);
	
__published:
	__property unsigned TotalAddrSpace = {read=FTotalAddrSpace, write=FTotalAddrSpace, nodefault};
	__property unsigned TotalUncommitted = {read=FTotalUncommitted, write=FTotalUncommitted, nodefault};
	__property unsigned TotalCommitted = {read=FTotalCommitted, write=FTotalCommitted, nodefault};
	__property unsigned TotalAllocated = {read=FTotalAllocated, write=FTotalAllocated, nodefault};
	__property unsigned TotalFree = {read=FTotalFree, write=FTotalFree, nodefault};
	__property unsigned FreeSmall = {read=FFreeSmall, write=FFreeSmall, nodefault};
	__property unsigned FreeBig = {read=FFreeBig, write=FFreeBig, nodefault};
	__property unsigned Unused = {read=FUnused, write=FUnused, nodefault};
	__property unsigned Overhead = {read=FOverhead, write=FOverhead, nodefault};
	__property unsigned HeapErrorCode = {read=FHeapErrorCode, write=FHeapErrorCode, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~THeapStatusWrapper(void) { }
	
};


class DELPHICLASS TSmallBlockTypeStateWrapper;
class PASCALIMPLEMENTATION TSmallBlockTypeStateWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FInternalBlockSize;
	unsigned FUseableBlockSize;
	unsigned FAllocatedBlockCount;
	unsigned FReservedAddressSpace;
	
public:
	__fastcall TSmallBlockTypeStateWrapper(const System::TSmallBlockTypeState &ARecord);
	System::TSmallBlockTypeState __fastcall ObjToRec(void);
	
__published:
	__property unsigned InternalBlockSize = {read=FInternalBlockSize, write=FInternalBlockSize, nodefault};
	__property unsigned UseableBlockSize = {read=FUseableBlockSize, write=FUseableBlockSize, nodefault};
	__property unsigned AllocatedBlockCount = {read=FAllocatedBlockCount, write=FAllocatedBlockCount, nodefault};
	__property unsigned ReservedAddressSpace = {read=FReservedAddressSpace, write=FReservedAddressSpace, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TSmallBlockTypeStateWrapper(void) { }
	
};


class DELPHICLASS TMemoryManagerStateWrapper;
class PASCALIMPLEMENTATION TMemoryManagerStateWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FAllocatedMediumBlockCount;
	unsigned FTotalAllocatedMediumBlockSize;
	unsigned FReservedMediumBlockAddressSpace;
	unsigned FAllocatedLargeBlockCount;
	unsigned FTotalAllocatedLargeBlockSize;
	unsigned FReservedLargeBlockAddressSpace;
	
public:
	__fastcall TMemoryManagerStateWrapper(const System::TMemoryManagerState &ARecord);
	System::TMemoryManagerState __fastcall ObjToRec(void);
	
__published:
	__property unsigned AllocatedMediumBlockCount = {read=FAllocatedMediumBlockCount, write=FAllocatedMediumBlockCount, nodefault};
	__property unsigned TotalAllocatedMediumBlockSize = {read=FTotalAllocatedMediumBlockSize, write=FTotalAllocatedMediumBlockSize, nodefault};
	__property unsigned ReservedMediumBlockAddressSpace = {read=FReservedMediumBlockAddressSpace, write=FReservedMediumBlockAddressSpace, nodefault};
	__property unsigned AllocatedLargeBlockCount = {read=FAllocatedLargeBlockCount, write=FAllocatedLargeBlockCount, nodefault};
	__property unsigned TotalAllocatedLargeBlockSize = {read=FTotalAllocatedLargeBlockSize, write=FTotalAllocatedLargeBlockSize, nodefault};
	__property unsigned ReservedLargeBlockAddressSpace = {read=FReservedLargeBlockAddressSpace, write=FReservedLargeBlockAddressSpace, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMemoryManagerStateWrapper(void) { }
	
};


class DELPHICLASS TMonitorSupportWrapper;
class PASCALIMPLEMENTATION TMonitorSupportWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall TMonitorSupportWrapper(const System::TMonitorSupport &ARecord);
	System::TMonitorSupport __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMonitorSupportWrapper(void) { }
	
};


class DELPHICLASS PackageUnitEntryWrapper;
class PASCALIMPLEMENTATION PackageUnitEntryWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall PackageUnitEntryWrapper(const System::PackageUnitEntry &ARecord);
	System::PackageUnitEntry __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~PackageUnitEntryWrapper(void) { }
	
};


class DELPHICLASS PackageInfoTableWrapper;
class PASCALIMPLEMENTATION PackageInfoTableWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FUnitCount;
	
public:
	__fastcall PackageInfoTableWrapper(const System::PackageInfoTable &ARecord);
	System::PackageInfoTable __fastcall ObjToRec(void);
	
__published:
	__property int UnitCount = {read=FUnitCount, write=FUnitCount, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~PackageInfoTableWrapper(void) { }
	
};


class DELPHICLASS TCVModInfoWrapper;
class PASCALIMPLEMENTATION TCVModInfoWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall TCVModInfoWrapper(const System::TCVModInfo &ARecord);
	System::TCVModInfo __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCVModInfoWrapper(void) { }
	
};


class DELPHICLASS TFileRecWrapper;
class PASCALIMPLEMENTATION TFileRecWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FHandle;
	System::Word FMode;
	System::Word FFlags;
	unsigned FRecSize;
	unsigned FBufSize;
	unsigned FBufPos;
	unsigned FBufEnd;
	
public:
	__fastcall TFileRecWrapper(const System::TFileRec &ARecord);
	System::TFileRec __fastcall ObjToRec(void);
	
__published:
	__property int Handle = {read=FHandle, write=FHandle, nodefault};
	__property System::Word Mode = {read=FMode, write=FMode, nodefault};
	__property System::Word Flags = {read=FFlags, write=FFlags, nodefault};
	__property unsigned RecSize = {read=FRecSize, write=FRecSize, nodefault};
	__property unsigned BufSize = {read=FBufSize, write=FBufSize, nodefault};
	__property unsigned BufPos = {read=FBufPos, write=FBufPos, nodefault};
	__property unsigned BufEnd = {read=FBufEnd, write=FBufEnd, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TFileRecWrapper(void) { }
	
};


class DELPHICLASS TTextRecWrapper;
class PASCALIMPLEMENTATION TTextRecWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FHandle;
	System::Word FMode;
	System::Word FFlags;
	unsigned FBufSize;
	unsigned FBufPos;
	unsigned FBufEnd;
	
public:
	__fastcall TTextRecWrapper(const System::TTextRec &ARecord);
	System::TTextRec __fastcall ObjToRec(void);
	
__published:
	__property int Handle = {read=FHandle, write=FHandle, nodefault};
	__property System::Word Mode = {read=FMode, write=FMode, nodefault};
	__property System::Word Flags = {read=FFlags, write=FFlags, nodefault};
	__property unsigned BufSize = {read=FBufSize, write=FBufSize, nodefault};
	__property unsigned BufPos = {read=FBufPos, write=FBufPos, nodefault};
	__property unsigned BufEnd = {read=FBufEnd, write=FBufEnd, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TTextRecWrapper(void) { }
	
};


class DELPHICLASS TLibModuleWrapper;
class PASCALIMPLEMENTATION TLibModuleWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FInstance;
	unsigned FCodeInstance;
	unsigned FDataInstance;
	unsigned FResInstance;
	int FReserved;
	
public:
	__fastcall TLibModuleWrapper(const System::TLibModule &ARecord);
	System::TLibModule __fastcall ObjToRec(void);
	
__published:
	__property unsigned Instance = {read=FInstance, write=FInstance, nodefault};
	__property unsigned CodeInstance = {read=FCodeInstance, write=FCodeInstance, nodefault};
	__property unsigned DataInstance = {read=FDataInstance, write=FDataInstance, nodefault};
	__property unsigned ResInstance = {read=FResInstance, write=FResInstance, nodefault};
	__property int Reserved = {read=FReserved, write=FReserved, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLibModuleWrapper(void) { }
	
};


class DELPHICLASS TModuleUnloadRecWrapper;
class PASCALIMPLEMENTATION TModuleUnloadRecWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
public:
	__fastcall TModuleUnloadRecWrapper(const System::TModuleUnloadRec &ARecord);
	System::TModuleUnloadRec __fastcall ObjToRec(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TModuleUnloadRecWrapper(void) { }
	
};


class DELPHICLASS TResStringRecWrapper;
class PASCALIMPLEMENTATION TResStringRecWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FIdentifier;
	
public:
	__fastcall TResStringRecWrapper(const System::TResStringRec &ARecord);
	System::TResStringRec __fastcall ObjToRec(void);
	
__published:
	__property int Identifier = {read=FIdentifier, write=FIdentifier, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TResStringRecWrapper(void) { }
	
};


class DELPHICLASS TInitContextWrapper;
class PASCALIMPLEMENTATION TInitContextWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FInitCount;
	System::Byte FDLLInitState;
	
public:
	__fastcall TInitContextWrapper(const System::TInitContext &ARecord);
	System::TInitContext __fastcall ObjToRec(void);
	
__published:
	__property int InitCount = {read=FInitCount, write=FInitCount, nodefault};
	__property System::Byte DLLInitState = {read=FDLLInitState, write=FDLLInitState, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TInitContextWrapper(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Ap_system */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Ap_system;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Ap_systemHPP
