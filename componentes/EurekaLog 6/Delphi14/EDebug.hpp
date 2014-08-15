// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Edebug.pas' rev: 21.00

#ifndef EdebugHPP
#define EdebugHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Edebug
{
//-- type declarations -------------------------------------------------------
struct TELTD32FileSignature;
typedef TELTD32FileSignature *PJclTD32FileSignature;

#pragma pack(push,1)
struct TELTD32FileSignature
{
	
public:
	unsigned Signature;
	unsigned Offset;
};
#pragma pack(pop)


struct TDirectoryEntry;
typedef TDirectoryEntry *PDirectoryEntry;

#pragma pack(push,1)
struct TDirectoryEntry
{
	
public:
	System::Word SubsectionType;
	System::Word ModuleIndex;
	unsigned Offset;
	unsigned Size;
};
#pragma pack(pop)


struct TDirectoryHeader;
typedef TDirectoryHeader *PDirectoryHeader;

#pragma pack(push,1)
struct TDirectoryHeader
{
	
public:
	System::Word Size;
	System::Word DirEntrySize;
	unsigned DirEntryCount;
	unsigned lfoNextDir;
	unsigned Flags;
	StaticArray<TDirectoryEntry, 1> DirEntries;
};
#pragma pack(pop)


struct TSegmentInfo;
typedef TSegmentInfo *PSegmentInfo;

#pragma pack(push,1)
struct TSegmentInfo
{
	
public:
	System::Word Segment;
	System::Word Flags;
	unsigned Offset;
	unsigned Size;
};
#pragma pack(pop)


typedef StaticArray<TSegmentInfo, 32768> TSegmentInfoArray;

typedef TSegmentInfoArray *PSegmentInfoArray;

struct TModuleInfo;
typedef TModuleInfo *PModuleInfo;

#pragma pack(push,1)
struct TModuleInfo
{
	
public:
	System::Word OverlayNumber;
	System::Word LibraryIndex;
	System::Word SegmentCount;
	System::Word DebuggingStyle;
	unsigned NameIndex;
	unsigned TimeStamp;
	StaticArray<unsigned, 3> Reserved;
	StaticArray<TSegmentInfo, 1> Segments;
};
#pragma pack(pop)


struct TLineMappingEntry;
typedef TLineMappingEntry *PLineMappingEntry;

#pragma pack(push,1)
struct TLineMappingEntry
{
	
public:
	System::Word SegmentIndex;
	System::Word PairCount;
	StaticArray<unsigned, 1> Offsets;
};
#pragma pack(pop)


#pragma pack(push,1)
struct TOffsetPair
{
	
public:
	unsigned StartOffset;
	unsigned EndOffset;
};
#pragma pack(pop)


typedef StaticArray<TOffsetPair, 32768> TOffsetPairArray;

typedef TOffsetPairArray *POffsetPairArray;

struct TSourceFileEntry;
typedef TSourceFileEntry *PSourceFileEntry;

#pragma pack(push,1)
struct TSourceFileEntry
{
	
public:
	System::Word SegmentCount;
	unsigned NameIndex;
	StaticArray<unsigned, 1> BaseSrcLines;
};
#pragma pack(pop)


struct TSourceModuleInfo;
typedef TSourceModuleInfo *PSourceModuleInfo;

#pragma pack(push,1)
struct TSourceModuleInfo
{
	
public:
	System::Word FileCount;
	System::Word SegmentCount;
	StaticArray<unsigned, 1> BaseSrcFiles;
};
#pragma pack(pop)


struct TGlobalTypeInfo;
typedef TGlobalTypeInfo *PGlobalTypeInfo;

#pragma pack(push,1)
struct TGlobalTypeInfo
{
	
public:
	unsigned Count;
	StaticArray<unsigned, 1> Offsets;
};
#pragma pack(pop)


#pragma pack(push,1)
struct TSymbolProcInfo
{
	
public:
	unsigned pParent;
	unsigned pEnd;
	unsigned pNext;
	unsigned Size;
	unsigned DebugStart;
	unsigned DebugEnd;
	unsigned Offset;
	System::Word Segment;
	unsigned ProcType;
	System::Byte NearFar;
	System::Byte Reserved;
	unsigned NameIndex;
};
#pragma pack(pop)


#pragma pack(push,1)
struct TSymbolObjNameInfo
{
	
public:
	unsigned Signature;
	unsigned NameIndex;
};
#pragma pack(pop)


#pragma pack(push,1)
struct TSymbolDataInfo
{
	
public:
	unsigned Offset;
	System::Word Segment;
	System::Word Reserved;
	unsigned TypeIndex;
	unsigned NameIndex;
};
#pragma pack(pop)


#pragma pack(push,1)
struct TSymbolWithInfo
{
	
public:
	unsigned pParent;
	unsigned pEnd;
	unsigned Size;
	unsigned Offset;
	System::Word Segment;
	System::Word Reserved;
	unsigned NameIndex;
};
#pragma pack(pop)


#pragma pack(push,1)
struct TSymbolLabelInfo
{
	
public:
	unsigned Offset;
	System::Word Segment;
	System::Byte NearFar;
	System::Byte Reserved;
	unsigned NameIndex;
};
#pragma pack(pop)


#pragma pack(push,1)
struct TSymbolConstantInfo
{
	
public:
	unsigned TypeIndex;
	unsigned NameIndex;
	unsigned Reserved;
	unsigned Value;
};
#pragma pack(pop)


#pragma pack(push,1)
struct TSymbolUdtInfo
{
	
public:
	unsigned TypeIndex;
	System::Word Properties;
	unsigned NameIndex;
	unsigned Reserved;
};
#pragma pack(pop)


#pragma pack(push,1)
struct TSymbolVftPathInfo
{
	
public:
	unsigned Offset;
	System::Word Segment;
	System::Word Reserved;
	unsigned RootIndex;
	unsigned PathIndex;
};
#pragma pack(pop)


class DELPHICLASS TObjectListEx;
class PASCALIMPLEMENTATION TObjectListEx : public Classes::TList
{
	typedef Classes::TList inherited;
	
public:
	__fastcall virtual ~TObjectListEx(void);
public:
	/* TObject.Create */ inline __fastcall TObjectListEx(void) : Classes::TList() { }
	
};


struct TSymbolInfo;
typedef TSymbolInfo *PSymbolInfo;

#pragma pack(push,1)
struct TSymbolInfo
{
	
public:
	System::Word Size;
	System::Word SymbolType;
	union
	{
		struct 
		{
			TSymbolVftPathInfo VftPath;
			
		};
		struct 
		{
			TSymbolUdtInfo Udt;
			
		};
		struct 
		{
			TSymbolConstantInfo Constant;
			
		};
		struct 
		{
			TSymbolLabelInfo Label32;
			
		};
		struct 
		{
			TSymbolWithInfo With32;
			
		};
		struct 
		{
			TSymbolDataInfo Data;
			
		};
		struct 
		{
			TSymbolObjNameInfo ObjName;
			
		};
		struct 
		{
			TSymbolProcInfo Proc;
			
		};
		
	};
};
#pragma pack(pop)


struct TSymbolInfos;
typedef TSymbolInfos *PSymbolInfos;

#pragma pack(push,1)
struct TSymbolInfos
{
	
public:
	unsigned Signature;
	StaticArray<TSymbolInfo, 1> Symbols;
};
#pragma pack(pop)


class DELPHICLASS TELModuleInfo;
class PASCALIMPLEMENTATION TELModuleInfo : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TSegmentInfo operator[](const int Idx) { return Segment[Idx]; }
	
private:
	unsigned FNameIndex;
	TSegmentInfoArray *FSegments;
	int FSegmentCount;
	TSegmentInfo __fastcall GetSegment(const int Idx);
	
protected:
	__fastcall TELModuleInfo(PModuleInfo pModInfo);
	
public:
	__property unsigned NameIndex = {read=FNameIndex, nodefault};
	__property int SegmentCount = {read=FSegmentCount, nodefault};
	__property TSegmentInfo Segment[const int Idx] = {read=GetSegment/*, default*/};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TELModuleInfo(void) { }
	
};


class DELPHICLASS TELLineInfo;
class PASCALIMPLEMENTATION TELLineInfo : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	unsigned FLineNo;
	unsigned FOffset;
	
protected:
	__fastcall TELLineInfo(unsigned ALineNo, unsigned AOffset);
	
public:
	__property unsigned LineNo = {read=FLineNo, nodefault};
	__property unsigned Offset = {read=FOffset, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TELLineInfo(void) { }
	
};


class DELPHICLASS TELSourceModuleInfo;
class PASCALIMPLEMENTATION TELSourceModuleInfo : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TELLineInfo* operator[](const int Idx) { return Line[Idx]; }
	
private:
	TObjectListEx* FLines;
	TOffsetPairArray *FSegments;
	int FSegmentCount;
	unsigned FNameIndex;
	TELLineInfo* __fastcall GetLine(const int Idx);
	int __fastcall GetLineCount(void);
	TOffsetPair __fastcall GetSegment(const int Idx);
	
protected:
	__fastcall TELSourceModuleInfo(PSourceFileEntry pSrcFile, unsigned Base);
	
public:
	__fastcall virtual ~TELSourceModuleInfo(void);
	bool __fastcall FindLine(const unsigned AAddr, TELLineInfo* &ALine);
	__property unsigned NameIndex = {read=FNameIndex, nodefault};
	__property int LineCount = {read=GetLineCount, nodefault};
	__property TELLineInfo* Line[const int Idx] = {read=GetLine/*, default*/};
	__property int SegmentCount = {read=FSegmentCount, nodefault};
	__property TOffsetPair Segment[const int Idx] = {read=GetSegment};
};


class DELPHICLASS TELSymbolInfo;
class PASCALIMPLEMENTATION TELSymbolInfo : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Word FSymbolType;
	
protected:
	__fastcall virtual TELSymbolInfo(PSymbolInfo pSymInfo);
	__property System::Word SymbolType = {read=FSymbolType, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TELSymbolInfo(void) { }
	
};


class DELPHICLASS TELProcSymbolInfo;
class PASCALIMPLEMENTATION TELProcSymbolInfo : public TELSymbolInfo
{
	typedef TELSymbolInfo inherited;
	
private:
	unsigned FNameIndex;
	unsigned FOffset;
	unsigned FSize;
	
protected:
	__fastcall virtual TELProcSymbolInfo(PSymbolInfo pSymInfo);
	
public:
	__property unsigned NameIndex = {read=FNameIndex, nodefault};
	__property unsigned Offset = {read=FOffset, nodefault};
	__property unsigned Size = {read=FSize, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TELProcSymbolInfo(void) { }
	
};


class DELPHICLASS TELLocalProcSymbolInfo;
class PASCALIMPLEMENTATION TELLocalProcSymbolInfo : public TELProcSymbolInfo
{
	typedef TELProcSymbolInfo inherited;
	
protected:
	/* TELProcSymbolInfo.Create */ inline __fastcall virtual TELLocalProcSymbolInfo(PSymbolInfo pSymInfo) : TELProcSymbolInfo(pSymInfo) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TELLocalProcSymbolInfo(void) { }
	
};


class DELPHICLASS TELGlobalProcSymbolInfo;
class PASCALIMPLEMENTATION TELGlobalProcSymbolInfo : public TELProcSymbolInfo
{
	typedef TELProcSymbolInfo inherited;
	
protected:
	/* TELProcSymbolInfo.Create */ inline __fastcall virtual TELGlobalProcSymbolInfo(PSymbolInfo pSymInfo) : TELProcSymbolInfo(pSymInfo) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TELGlobalProcSymbolInfo(void) { }
	
};


class DELPHICLASS TELObjNameSymbolInfo;
class PASCALIMPLEMENTATION TELObjNameSymbolInfo : public TELSymbolInfo
{
	typedef TELSymbolInfo inherited;
	
private:
	unsigned FSignature;
	unsigned FNameIndex;
	
protected:
	__fastcall virtual TELObjNameSymbolInfo(PSymbolInfo pSymInfo);
	
public:
	__property unsigned NameIndex = {read=FNameIndex, nodefault};
	__property unsigned Signature = {read=FSignature, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TELObjNameSymbolInfo(void) { }
	
};


class DELPHICLASS TELDataSymbolInfo;
class PASCALIMPLEMENTATION TELDataSymbolInfo : public TELSymbolInfo
{
	typedef TELSymbolInfo inherited;
	
private:
	unsigned FOffset;
	unsigned FTypeIndex;
	unsigned FNameIndex;
	
protected:
	__fastcall virtual TELDataSymbolInfo(PSymbolInfo pSymInfo);
	
public:
	__property unsigned NameIndex = {read=FNameIndex, nodefault};
	__property unsigned TypeIndex = {read=FTypeIndex, nodefault};
	__property unsigned Offset = {read=FOffset, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TELDataSymbolInfo(void) { }
	
};


class DELPHICLASS TELLDataSymbolInfo;
class PASCALIMPLEMENTATION TELLDataSymbolInfo : public TELDataSymbolInfo
{
	typedef TELDataSymbolInfo inherited;
	
protected:
	/* TELDataSymbolInfo.Create */ inline __fastcall virtual TELLDataSymbolInfo(PSymbolInfo pSymInfo) : TELDataSymbolInfo(pSymInfo) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TELLDataSymbolInfo(void) { }
	
};


class DELPHICLASS TELGDataSymbolInfo;
class PASCALIMPLEMENTATION TELGDataSymbolInfo : public TELDataSymbolInfo
{
	typedef TELDataSymbolInfo inherited;
	
protected:
	/* TELDataSymbolInfo.Create */ inline __fastcall virtual TELGDataSymbolInfo(PSymbolInfo pSymInfo) : TELDataSymbolInfo(pSymInfo) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TELGDataSymbolInfo(void) { }
	
};


class DELPHICLASS TELPublicSymbolInfo;
class PASCALIMPLEMENTATION TELPublicSymbolInfo : public TELDataSymbolInfo
{
	typedef TELDataSymbolInfo inherited;
	
protected:
	/* TELDataSymbolInfo.Create */ inline __fastcall virtual TELPublicSymbolInfo(PSymbolInfo pSymInfo) : TELDataSymbolInfo(pSymInfo) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TELPublicSymbolInfo(void) { }
	
};


class DELPHICLASS TELWithSymbolInfo;
class PASCALIMPLEMENTATION TELWithSymbolInfo : public TELSymbolInfo
{
	typedef TELSymbolInfo inherited;
	
private:
	unsigned FOffset;
	unsigned FSize;
	unsigned FNameIndex;
	
protected:
	__fastcall virtual TELWithSymbolInfo(PSymbolInfo pSymInfo);
	
public:
	__property unsigned NameIndex = {read=FNameIndex, nodefault};
	__property unsigned Offset = {read=FOffset, nodefault};
	__property unsigned Size = {read=FSize, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TELWithSymbolInfo(void) { }
	
};


class DELPHICLASS TELLabelSymbolInfo;
class PASCALIMPLEMENTATION TELLabelSymbolInfo : public TELSymbolInfo
{
	typedef TELSymbolInfo inherited;
	
private:
	unsigned FOffset;
	unsigned FNameIndex;
	
protected:
	__fastcall virtual TELLabelSymbolInfo(PSymbolInfo pSymInfo);
	
public:
	__property unsigned NameIndex = {read=FNameIndex, nodefault};
	__property unsigned Offset = {read=FOffset, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TELLabelSymbolInfo(void) { }
	
};


class DELPHICLASS TELConstantSymbolInfo;
class PASCALIMPLEMENTATION TELConstantSymbolInfo : public TELSymbolInfo
{
	typedef TELSymbolInfo inherited;
	
private:
	unsigned FValue;
	unsigned FTypeIndex;
	unsigned FNameIndex;
	
protected:
	__fastcall virtual TELConstantSymbolInfo(PSymbolInfo pSymInfo);
	
public:
	__property unsigned NameIndex = {read=FNameIndex, nodefault};
	__property unsigned TypeIndex = {read=FTypeIndex, nodefault};
	__property unsigned Value = {read=FValue, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TELConstantSymbolInfo(void) { }
	
};


class DELPHICLASS TELUdtSymbolInfo;
class PASCALIMPLEMENTATION TELUdtSymbolInfo : public TELSymbolInfo
{
	typedef TELSymbolInfo inherited;
	
private:
	unsigned FTypeIndex;
	unsigned FNameIndex;
	System::Word FProperties;
	
protected:
	__fastcall virtual TELUdtSymbolInfo(PSymbolInfo pSymInfo);
	
public:
	__property unsigned NameIndex = {read=FNameIndex, nodefault};
	__property unsigned TypeIndex = {read=FTypeIndex, nodefault};
	__property System::Word Properties = {read=FProperties, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TELUdtSymbolInfo(void) { }
	
};


class DELPHICLASS TELVftPathSymbolInfo;
class PASCALIMPLEMENTATION TELVftPathSymbolInfo : public TELSymbolInfo
{
	typedef TELSymbolInfo inherited;
	
private:
	unsigned FRootIndex;
	unsigned FPathIndex;
	unsigned FOffset;
	
protected:
	__fastcall virtual TELVftPathSymbolInfo(PSymbolInfo pSymInfo);
	
public:
	__property unsigned RootIndex = {read=FRootIndex, nodefault};
	__property unsigned PathIndex = {read=FPathIndex, nodefault};
	__property unsigned Offset = {read=FOffset, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TELVftPathSymbolInfo(void) { }
	
};


class DELPHICLASS TELTD32InfoParser;
class PASCALIMPLEMENTATION TELTD32InfoParser : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	void *FBase;
	Classes::TCustomMemoryStream* FData;
	Classes::TList* FNames;
	TObjectListEx* FModules;
	TObjectListEx* FSourceModules;
	TObjectListEx* FSymbols;
	bool FValidData;
	System::AnsiString __fastcall GetName(const int Idx);
	int __fastcall GetNameCount(void);
	TELSymbolInfo* __fastcall GetSymbol(const int Idx);
	int __fastcall GetSymbolCount(void);
	TELModuleInfo* __fastcall GetModule(const int Idx);
	int __fastcall GetModuleCount(void);
	TELSourceModuleInfo* __fastcall GetSourceModule(const int Idx);
	int __fastcall GetSourceModuleCount(void);
	
protected:
	void __fastcall Analyse(void);
	virtual void __fastcall AnalyseNames(const void * pSubsection, const unsigned Size);
	virtual void __fastcall AnalyseAlignSymbols(PSymbolInfos pSymbols, const unsigned Size);
	virtual void __fastcall AnalyseModules(PModuleInfo pModInfo, const unsigned Size);
	virtual void __fastcall AnalyseSourceModules(PSourceModuleInfo pSrcModInfo, const unsigned Size);
	void * __fastcall LfaToVa(unsigned Lfa);
	
public:
	__fastcall TELTD32InfoParser(const Classes::TCustomMemoryStream* ATD32Data);
	__fastcall virtual ~TELTD32InfoParser(void);
	bool __fastcall FindModule(const unsigned AAddr, TELModuleInfo* &AMod);
	bool __fastcall FindSourceModule(const unsigned AAddr, TELSourceModuleInfo* &ASrcMod);
	bool __fastcall FindProc(const unsigned AAddr, TELProcSymbolInfo* &AProc);
	__classmethod bool __fastcall IsTD32Sign(const TELTD32FileSignature &Sign);
	__classmethod bool __fastcall IsTD32DebugInfoValid(const void * DebugData, const unsigned DebugDataSize);
	__property Classes::TCustomMemoryStream* Data = {read=FData};
	__property System::AnsiString Names[const int Idx] = {read=GetName};
	__property int NameCount = {read=GetNameCount, nodefault};
	__property TELSymbolInfo* Symbols[const int Idx] = {read=GetSymbol};
	__property int SymbolCount = {read=GetSymbolCount, nodefault};
	__property TELModuleInfo* Modules[const int Idx] = {read=GetModule};
	__property int ModuleCount = {read=GetModuleCount, nodefault};
	__property TELSourceModuleInfo* SourceModules[const int Idx] = {read=GetSourceModule};
	__property int SourceModuleCount = {read=GetSourceModuleCount, nodefault};
	__property bool ValidData = {read=FValidData, nodefault};
};


class DELPHICLASS TELTD32InfoScanner;
class PASCALIMPLEMENTATION TELTD32InfoScanner : public TELTD32InfoParser
{
	typedef TELTD32InfoParser inherited;
	
public:
	int __fastcall LineNumberFromAddr(unsigned AAddr, int &Offset);
	System::AnsiString __fastcall ProcNameFromAddr(unsigned AAddr, int &Offset);
	System::AnsiString __fastcall ModuleNameFromAddr(unsigned AAddr);
	System::AnsiString __fastcall SourceNameFromAddr(unsigned AAddr);
public:
	/* TELTD32InfoParser.Create */ inline __fastcall TELTD32InfoScanner(const Classes::TCustomMemoryStream* ATD32Data) : TELTD32InfoParser(ATD32Data) { }
	/* TELTD32InfoParser.Destroy */ inline __fastcall virtual ~TELTD32InfoScanner(void) { }
	
};


class DELPHICLASS TELPeBorTD32Image;
class PASCALIMPLEMENTATION TELPeBorTD32Image : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	bool FIsTD32DebugPresent;
	Classes::TCustomMemoryStream* FTD32DebugData;
	TELTD32InfoScanner* FTD32Scanner;
	unsigned FModule;
	
protected:
	void __fastcall Clear(void);
	void __fastcall ClearDebugData(void);
	void __fastcall CheckDebugData(void);
	bool __fastcall IsDebugInfoInImage(Classes::TCustomMemoryStream* &DataStream);
	bool __fastcall IsDebugInfoInTds(Classes::TCustomMemoryStream* &DataStream);
	
public:
	__fastcall TELPeBorTD32Image(unsigned AModule);
	__fastcall virtual ~TELPeBorTD32Image(void);
	__property bool IsTD32DebugPresent = {read=FIsTD32DebugPresent, nodefault};
	__property Classes::TCustomMemoryStream* TD32DebugData = {read=FTD32DebugData, write=FTD32DebugData};
	__property TELTD32InfoScanner* TD32Scanner = {read=FTD32Scanner};
};


struct TELMapAddress;
typedef TELMapAddress *PJclMapAddress;

#pragma pack(push,1)
struct TELMapAddress
{
	
public:
	System::Word Segment;
	int Offset;
};
#pragma pack(pop)


typedef char * PJclMapString;

class DELPHICLASS TELAbstractMapParser;
class PASCALIMPLEMENTATION TELAbstractMapParser : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	bool FLinkerBug;
	char *FLinkerBugUnitName;
	Classes::TMemoryStream* FStream;
	System::AnsiString __fastcall GetLinkerBugUnitName(void);
	
protected:
	char *FLastUnitName;
	char *FLastUnitFileName;
	virtual void __fastcall ClassTableItem(const TELMapAddress &Address, int Len, char * SectionName, char * GroupName) = 0 ;
	virtual void __fastcall SegmentItem(const TELMapAddress &Address, int Len, char * GroupName, char * UnitName) = 0 ;
	virtual void __fastcall PublicsByNameItem(const TELMapAddress &Address, char * Name) = 0 ;
	virtual void __fastcall PublicsByValueItem(const TELMapAddress &Address, char * Name) = 0 ;
	virtual void __fastcall LineNumberUnitItem(char * UnitName, char * UnitFileName) = 0 ;
	virtual void __fastcall LineNumbersItem(int LineNumber, const TELMapAddress &Address) = 0 ;
	
public:
	__fastcall virtual TELAbstractMapParser(const Sysutils::TFileName MapFileName);
	__fastcall virtual ~TELAbstractMapParser(void);
	void __fastcall Parse(void);
	__classmethod System::AnsiString __fastcall MapStringToStr(char * MapString);
	__classmethod System::AnsiString __fastcall MapStringToFileName(char * MapString);
	__property bool LinkerBug = {read=FLinkerBug, nodefault};
	__property System::AnsiString LinkerBugUnitName = {read=GetLinkerBugUnitName};
	__property Classes::TMemoryStream* Stream = {read=FStream};
};


typedef void __fastcall (__closure *TELMapClassTableEvent)(System::TObject* Sender, const TELMapAddress &Address, int Len, const System::AnsiString SectionName, const System::AnsiString GroupName);

typedef void __fastcall (__closure *TELMapSegmentEvent)(System::TObject* Sender, const TELMapAddress &Address, int Len, const System::AnsiString GroupName, const System::AnsiString UnitName);

typedef void __fastcall (__closure *TELMapPublicsEvent)(System::TObject* Sender, const TELMapAddress &Address, const System::AnsiString Name);

typedef void __fastcall (__closure *TELMapLineNumberUnitEvent)(System::TObject* Sender, const System::AnsiString UnitName, const System::AnsiString UnitFileName);

typedef void __fastcall (__closure *TELMapLineNumbersEvent)(System::TObject* Sender, int LineNumber, const TELMapAddress &Address);

class DELPHICLASS TELMapParser;
class PASCALIMPLEMENTATION TELMapParser : public TELAbstractMapParser
{
	typedef TELAbstractMapParser inherited;
	
private:
	TELMapClassTableEvent FOnClassTable;
	TELMapLineNumbersEvent FOnLineNumbers;
	TELMapLineNumberUnitEvent FOnLineNumberUnit;
	TELMapPublicsEvent FOnPublicsByValue;
	TELMapPublicsEvent FOnPublicsByName;
	TELMapSegmentEvent FOnSegmentItem;
	
protected:
	virtual void __fastcall ClassTableItem(const TELMapAddress &Address, int Len, char * SectionName, char * GroupName);
	virtual void __fastcall SegmentItem(const TELMapAddress &Address, int Len, char * GroupName, char * UnitName);
	virtual void __fastcall PublicsByNameItem(const TELMapAddress &Address, char * Name);
	virtual void __fastcall PublicsByValueItem(const TELMapAddress &Address, char * Name);
	virtual void __fastcall LineNumberUnitItem(char * UnitName, char * UnitFileName);
	virtual void __fastcall LineNumbersItem(int LineNumber, const TELMapAddress &Address);
	
public:
	__property TELMapClassTableEvent OnClassTable = {read=FOnClassTable, write=FOnClassTable};
	__property TELMapSegmentEvent OnSegment = {read=FOnSegmentItem, write=FOnSegmentItem};
	__property TELMapPublicsEvent OnPublicsByName = {read=FOnPublicsByName, write=FOnPublicsByName};
	__property TELMapPublicsEvent OnPublicsByValue = {read=FOnPublicsByValue, write=FOnPublicsByValue};
	__property TELMapLineNumberUnitEvent OnLineNumberUnit = {read=FOnLineNumberUnit, write=FOnLineNumberUnit};
	__property TELMapLineNumbersEvent OnLineNumbers = {read=FOnLineNumbers, write=FOnLineNumbers};
public:
	/* TELAbstractMapParser.Create */ inline __fastcall virtual TELMapParser(const Sysutils::TFileName MapFileName) : TELAbstractMapParser(MapFileName) { }
	/* TELAbstractMapParser.Destroy */ inline __fastcall virtual ~TELMapParser(void) { }
	
};


struct TELMapSegment;
typedef TELMapSegment *PJclMapSegment;

struct TELMapSegment
{
	
public:
	unsigned StartAddr;
	unsigned EndAddr;
	char *UnitName;
};


struct TELMapProcName;
typedef TELMapProcName *PJclMapProcName;

struct TELMapProcName
{
	
public:
	unsigned Addr;
	char *ProcName;
};


struct TELMapLineNumber;
typedef TELMapLineNumber *PJclMapLineNumber;

struct TELMapLineNumber
{
	
public:
	unsigned Addr;
	int LineNumber;
};


typedef StaticArray<TELMapLineNumber, 1> TLineNumbersArray;

typedef StaticArray<TELMapProcName, 1> TProcNamesArray;

typedef StaticArray<TELMapSegment, 1> TSegmentsArray;

typedef StaticArray<TELMapProcName, 1> TSourceNamesArray;

class DELPHICLASS TELMapScanner;
class PASCALIMPLEMENTATION TELMapScanner : public TELAbstractMapParser
{
	typedef TELAbstractMapParser inherited;
	
private:
	TLineNumbersArray *FLineNumbers;
	int FLineNumbersLen;
	TProcNamesArray *FProcNames;
	int FProcNamesLen;
	TSegmentsArray *FSegments;
	int FSegmentsLen;
	TSourceNamesArray *FSourceNames;
	int FSourceNamesLen;
	TELMapAddress FLastValidAddr;
	int FLineNumbersCnt;
	int FLineNumberErrors;
	char *FNewUnitFileName;
	int FProcNamesCnt;
	int FTopValidAddr;
	
protected:
	virtual void __fastcall ClassTableItem(const TELMapAddress &Address, int Len, char * SectionName, char * GroupName);
	virtual void __fastcall SegmentItem(const TELMapAddress &Address, int Len, char * GroupName, char * UnitName);
	virtual void __fastcall PublicsByNameItem(const TELMapAddress &Address, char * Name);
	virtual void __fastcall PublicsByValueItem(const TELMapAddress &Address, char * Name);
	virtual void __fastcall LineNumbersItem(int LineNumber, const TELMapAddress &Address);
	virtual void __fastcall LineNumberUnitItem(char * UnitName, char * UnitFileName);
	void __fastcall Scan(void);
	
public:
	__fastcall virtual TELMapScanner(const Sysutils::TFileName MapFileName);
	__fastcall virtual ~TELMapScanner(void);
	int __fastcall LineNumberFromAddr(unsigned Addr, int &Offset);
	System::AnsiString __fastcall ModuleNameFromAddr(unsigned Addr);
	unsigned __fastcall ModuleStartFromAddr(unsigned Addr);
	System::AnsiString __fastcall ProcNameFromAddr(unsigned Addr, int &Offset);
	System::AnsiString __fastcall SourceNameFromAddr(unsigned Addr);
	__property int LineNumberErrors = {read=FLineNumberErrors, nodefault};
};


struct TELDbgHeader;
typedef TELDbgHeader *PJclDbgHeader;

#pragma pack(push,1)
struct TELDbgHeader
{
	
public:
	unsigned Signature;
	System::Byte Version;
	int Units;
	int SourceNames;
	int Symbols;
	int LineNumbers;
	int Words;
	int ModuleName;
	int CheckSum;
	bool CheckSumValid;
};
#pragma pack(pop)


struct TELBinDbgNameCache
{
	
public:
	unsigned Addr;
	int FirstWord;
	int SecondWord;
};


typedef StaticArray<TELBinDbgNameCache, 1> TBinProcNamesArray;

class DELPHICLASS TELBinDebugScanner;
class PASCALIMPLEMENTATION TELBinDebugScanner : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	bool FCacheData;
	Classes::TCustomMemoryStream* FStream;
	bool FValidFormat;
	TLineNumbersArray *FLineNumbers;
	int FLineNumbersLen;
	TBinProcNamesArray *FProcNames;
	int FProcNamesLen;
	System::AnsiString __fastcall GetModuleName(void);
	
protected:
	void __fastcall CacheLineNumbers(void);
	void __fastcall CacheProcNames(void);
	void __fastcall CheckFormat(void);
	System::AnsiString __fastcall DataToStr(int A);
	void * __fastcall MakePtr(int A);
	bool __fastcall ReadValue(void * &P, int &Value);
	
public:
	__fastcall TELBinDebugScanner(Classes::TCustomMemoryStream* AStream, bool CacheData);
	__fastcall virtual ~TELBinDebugScanner(void);
	int __fastcall LineNumberFromAddr(unsigned Addr, int &Offset);
	System::AnsiString __fastcall ProcNameFromAddr(unsigned Addr, int &Offset);
	System::AnsiString __fastcall ModuleNameFromAddr(unsigned Addr);
	unsigned __fastcall ModuleStartFromAddr(unsigned Addr);
	System::AnsiString __fastcall SourceNameFromAddr(unsigned Addr);
	__property System::AnsiString ModuleName = {read=GetModuleName};
	__property bool ValidFormat = {read=FValidFormat, nodefault};
};


struct TELLocationInfo;
typedef TELLocationInfo *PJclLocationInfo;

class DELPHICLASS TELDebugInfoSource;
struct TELLocationInfo
{
	
public:
	void *Address;
	System::AnsiString UnitName;
	System::AnsiString ProcedureName;
	int ProcOffsetLine;
	int LineNumber;
	System::AnsiString SourceName;
	TELDebugInfoSource* DebugInfo;
};


class PASCALIMPLEMENTATION TELDebugInfoSource : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	unsigned FModule;
	Sysutils::TFileName __fastcall GetFileName(void);
	
protected:
	virtual bool __fastcall InitializeSource(void) = 0 ;
	virtual unsigned __fastcall VAFromAddr(const void * Addr);
	
public:
	__fastcall virtual TELDebugInfoSource(unsigned AModule);
	virtual bool __fastcall ValidData(void) = 0 ;
	virtual bool __fastcall GetLocationInfo(const void * Addr, TELLocationInfo &Info) = 0 ;
	__property unsigned Module = {read=FModule, nodefault};
	__property Sysutils::TFileName FileName = {read=GetFileName};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TELDebugInfoSource(void) { }
	
};


class DELPHICLASS TELDebugInfoMap;
class PASCALIMPLEMENTATION TELDebugInfoMap : public TELDebugInfoSource
{
	typedef TELDebugInfoSource inherited;
	
private:
	TELMapScanner* FScanner;
	
protected:
	virtual bool __fastcall InitializeSource(void);
	
public:
	__fastcall virtual ~TELDebugInfoMap(void);
	virtual bool __fastcall ValidData(void);
	virtual bool __fastcall GetLocationInfo(const void * Addr, TELLocationInfo &Info);
public:
	/* TELDebugInfoSource.Create */ inline __fastcall virtual TELDebugInfoMap(unsigned AModule) : TELDebugInfoSource(AModule) { }
	
};


class DELPHICLASS TELDebugInfoJedy;
class PASCALIMPLEMENTATION TELDebugInfoJedy : public TELDebugInfoSource
{
	typedef TELDebugInfoSource inherited;
	
private:
	TELBinDebugScanner* FScanner;
	Classes::TMemoryStream* FStream;
	
protected:
	virtual bool __fastcall InitializeSource(void);
	
public:
	__fastcall virtual ~TELDebugInfoJedy(void);
	virtual bool __fastcall ValidData(void);
	virtual bool __fastcall GetLocationInfo(const void * Addr, TELLocationInfo &Info);
public:
	/* TELDebugInfoSource.Create */ inline __fastcall virtual TELDebugInfoJedy(unsigned AModule) : TELDebugInfoSource(AModule) { }
	
};


class DELPHICLASS TELDebugInfoTD32;
class PASCALIMPLEMENTATION TELDebugInfoTD32 : public TELDebugInfoSource
{
	typedef TELDebugInfoSource inherited;
	
private:
	TELPeBorTD32Image* FImage;
	
protected:
	virtual bool __fastcall InitializeSource(void);
	
public:
	__fastcall virtual ~TELDebugInfoTD32(void);
	virtual bool __fastcall ValidData(void);
	virtual bool __fastcall GetLocationInfo(const void * Addr, TELLocationInfo &Info);
public:
	/* TELDebugInfoSource.Create */ inline __fastcall virtual TELDebugInfoTD32(unsigned AModule) : TELDebugInfoSource(AModule) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const int Borland32BitSymbolFileSignatureForDelphi = 0x39304246;
static const int Borland32BitSymbolFileSignatureForBCB = 0x41304246;
static const Word SUBSECTION_TYPE_MODULE = 0x120;
static const Word SUBSECTION_TYPE_TYPES = 0x121;
static const Word SUBSECTION_TYPE_SYMBOLS = 0x124;
static const Word SUBSECTION_TYPE_ALIGN_SYMBOLS = 0x125;
static const Word SUBSECTION_TYPE_SOURCE_MODULE = 0x127;
static const Word SUBSECTION_TYPE_GLOBAL_SYMBOLS = 0x129;
static const Word SUBSECTION_TYPE_GLOBAL_TYPES = 0x12b;
static const Word SUBSECTION_TYPE_NAMES = 0x130;
static const ShortInt SYMBOL_TYPE_COMPILE = 0x1;
static const ShortInt SYMBOL_TYPE_REGISTER = 0x2;
static const ShortInt SYMBOL_TYPE_CONST = 0x3;
static const ShortInt SYMBOL_TYPE_UDT = 0x4;
static const ShortInt SYMBOL_TYPE_SSEARCH = 0x5;
static const ShortInt SYMBOL_TYPE_END = 0x6;
static const ShortInt SYMBOL_TYPE_SKIP = 0x7;
static const ShortInt SYMBOL_TYPE_CVRESERVE = 0x8;
static const ShortInt SYMBOL_TYPE_OBJNAME = 0x9;
static const Word SYMBOL_TYPE_BPREL16 = 0x100;
static const Word SYMBOL_TYPE_LDATA16 = 0x101;
static const Word SYMBOL_TYPE_GDATA16 = 0x102;
static const Word SYMBOL_TYPE_PUB16 = 0x103;
static const Word SYMBOL_TYPE_LPROC16 = 0x104;
static const Word SYMBOL_TYPE_GPROC16 = 0x105;
static const Word SYMBOL_TYPE_THUNK16 = 0x106;
static const Word SYMBOL_TYPE_BLOCK16 = 0x107;
static const Word SYMBOL_TYPE_WITH16 = 0x108;
static const Word SYMBOL_TYPE_LABEL16 = 0x109;
static const Word SYMBOL_TYPE_CEXMODEL16 = 0x10a;
static const Word SYMBOL_TYPE_VFTPATH16 = 0x10b;
static const Word SYMBOL_TYPE_BPREL32 = 0x200;
static const Word SYMBOL_TYPE_LDATA32 = 0x201;
static const Word SYMBOL_TYPE_GDATA32 = 0x202;
static const Word SYMBOL_TYPE_PUB32 = 0x203;
static const Word SYMBOL_TYPE_LPROC32 = 0x204;
static const Word SYMBOL_TYPE_GPROC32 = 0x205;
static const Word SYMBOL_TYPE_THUNK32 = 0x206;
static const Word SYMBOL_TYPE_BLOCK32 = 0x207;
static const Word SYMBOL_TYPE_WITH32 = 0x208;
static const Word SYMBOL_TYPE_LABEL32 = 0x209;
static const Word SYMBOL_TYPE_CEXMODEL32 = 0x20a;
static const Word SYMBOL_TYPE_VFTPATH32 = 0x20b;
static const int JclDbgDataSignature = 0x4742444a;
#define JclDbgDataResName L"JCLDEBUG"
#define JclDbgFileExtension L".jdbg"
static const ShortInt JclDbgHeaderVersion = 0x1;
#define MapFileExtension L".map"
#define DrcFileExtension L".drc"
extern PACKAGE bool __fastcall AssignValidDebugInfo(unsigned Module, TELDebugInfoSource* &DebugInfo);

}	/* namespace Edebug */
using namespace Edebug;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EdebugHPP
