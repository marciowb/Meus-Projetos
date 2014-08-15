// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uole2impl.pas' rev: 11.00

#ifndef Uole2implHPP
#define Uole2implHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Xlsmessages.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Uxlsprotect.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uole2impl
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum STGTY { STGTY_INVALID, STGTY_STORAGE, STGTY_STREAM, STGTY_LOCKBYTES, STGTY_PROPERTY, STGTY_ROOT };
#pragma option pop

#pragma option push -b-
enum DECOLOR { DECOLOR_RED, DECOLOR_BLACK };
#pragma option pop

class DELPHICLASS UInt32List;
class PASCALIMPLEMENTATION UInt32List : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	unsigned operator[](int i) { return Items[i]; }
	
private:
	Classes::TList* FList;
	unsigned __fastcall GetItems(const int i);
	void __fastcall SetItems(const int i, const unsigned Value);
	int __fastcall GetCapacity(void);
	void __fastcall SetCapacity(const int Value);
	int __fastcall GetCount(void);
	
protected:
	__property int Capacity = {read=GetCapacity, write=SetCapacity, nodefault};
	
public:
	__fastcall UInt32List(void);
	__fastcall virtual ~UInt32List(void);
	__property unsigned Items[int i] = {read=GetItems, write=SetItems/*, default*/};
	void __fastcall Add(const unsigned Item);
	__property int Count = {read=GetCount, nodefault};
};


class DELPHICLASS TOneDirEntry;
class PASCALIMPLEMENTATION TOneDirEntry : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	WideString Name;
	int LeftSid;
	int RightSid;
	int ChildSid;
	bool Deleted;
	DECOLOR Color;
	__fastcall TOneDirEntry(const WideString aName, const int aLeftSid, const int aRightSid, const int aChildSid, const DECOLOR aColor);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TOneDirEntry(void) { }
	#pragma option pop
	
};


class DELPHICLASS TDirEntryList;
class PASCALIMPLEMENTATION TDirEntryList : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	TOneDirEntry* operator[](int i) { return Items[i]; }
	
private:
	Contnrs::TObjectList* FList;
	TOneDirEntry* __fastcall GetItems(const int i);
	void __fastcall SetItems(const int i, const TOneDirEntry* Value);
	int __fastcall GetCount(void);
	
public:
	__fastcall TDirEntryList(void);
	__fastcall virtual ~TDirEntryList(void);
	__property TOneDirEntry* Items[int i] = {read=GetItems, write=SetItems/*, default*/};
	void __fastcall Add(const TOneDirEntry* Item);
	__property int Count = {read=GetCount, nodefault};
};


typedef DynamicArray<WideString >  StringArray;

class DELPHICLASS TOle2Header;
class PASCALIMPLEMENTATION TOle2Header : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	DynamicArray<Byte >  FileSignature;
	/*         class method */ static bool __fastcall CompareArray(TMetaClass* vmt, const Uflxmessages::ByteArray a1, const Uflxmessages::ByteArray a2, const int length);
	int __fastcall Get_FuSectorShift(void);
	unsigned __fastcall Get_FSectorSize(void);
	int __fastcall Get_uMiniSectorShift(void);
	unsigned __fastcall Get_MiniSectorSize(void);
	unsigned __fastcall Get_csectFat(void);
	void __fastcall Set_csectFat(const unsigned value);
	unsigned __fastcall Get_sectDirStart(void);
	void __fastcall Set_sectDirStart(const unsigned value);
	unsigned __fastcall Get_FulMiniSectorCutoff(void);
	unsigned __fastcall Get_sectMiniFatStart(void);
	void __fastcall Set_sectMiniFatStart(const unsigned value);
	unsigned __fastcall Get_csectMiniFat(void);
	void __fastcall Set_csectMiniFat(const unsigned value);
	unsigned __fastcall Get_sectDifStart(void);
	void __fastcall Set_sectDifStart(const unsigned value);
	unsigned __fastcall Get_csectDif(void);
	void __fastcall Set_csectDif(const unsigned value);
	__property int FuSectorShift = {read=Get_FuSectorShift, nodefault};
	__property unsigned FSectorSize = {read=Get_FSectorSize, nodefault};
	
public:
	bool NotXls97;
	DynamicArray<Byte >  Data;
	__int64 StartOfs;
	unsigned SectorSize;
	int uSectorShift;
	unsigned ulMiniSectorCutoff;
	__fastcall TOle2Header(const Classes::TStream* aStream, const bool AvoidExceptions);
	void __fastcall Save(const Classes::TStream* aStream);
	int __fastcall uDIFEntryShift(void);
	__int64 __fastcall SectToStPos(const __int64 Sect)/* overload */;
	__int64 __fastcall SectToStPos(const __int64 Sect, const __int64 Ofs)/* overload */;
	__property int uMiniSectorShift = {read=Get_uMiniSectorShift, nodefault};
	__property unsigned MiniSectorSize = {read=Get_MiniSectorSize, nodefault};
	__property unsigned csectFat = {read=Get_csectFat, write=Set_csectFat, nodefault};
	__property unsigned sectDirStart = {read=Get_sectDirStart, write=Set_sectDirStart, nodefault};
	__property unsigned FulMiniSectorCutoff = {read=Get_FulMiniSectorCutoff, nodefault};
	__property unsigned sectMiniFatStart = {read=Get_sectMiniFatStart, write=Set_sectMiniFatStart, nodefault};
	__property unsigned csectMiniFat = {read=Get_csectMiniFat, write=Set_csectMiniFat, nodefault};
	__property unsigned sectDifStart = {read=Get_sectDifStart, write=Set_sectDifStart, nodefault};
	__property unsigned csectDif = {read=Get_csectDif, write=Set_csectDif, nodefault};
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TOle2Header(void) { }
	#pragma option pop
	
};


class DELPHICLASS TOle2FAT;
class PASCALIMPLEMENTATION TOle2FAT : public UInt32List 
{
	typedef UInt32List inherited;
	
private:
	TOle2Header* Header;
	__int64 LastFindSectorOfs;
	__int64 LastFindSectorStart;
	__int64 LastFindSectorRes;
	__fastcall TOle2FAT(void)/* overload */;
	void __fastcall LoadDifSector(const Uflxmessages::ByteArray data, const unsigned inipos, const unsigned endpos, const Classes::TStream* aStream);
	void __fastcall LoadFatSector(const Uflxmessages::ByteArray data);
	
public:
	__fastcall TOle2FAT(const TOle2Header* aHeader, const Classes::TStream* aStream)/* overload */;
	__fastcall virtual ~TOle2FAT(void);
	int __fastcall uFATEntryShift(void);
	__int64 __fastcall GetNextSector(const __int64 Sect);
	__int64 __fastcall FindSector(const __int64 StartSect, const __int64 SectOfs);
};


class DELPHICLASS TOle2MiniFAT;
class PASCALIMPLEMENTATION TOle2MiniFAT : public UInt32List 
{
	typedef UInt32List inherited;
	
private:
	TOle2Header* Header;
	__fastcall TOle2MiniFAT(void)/* overload */;
	void __fastcall LoadMiniFatSector(const Uflxmessages::ByteArray data);
	
public:
	__fastcall TOle2MiniFAT(const TOle2Header* aHeader, const Classes::TStream* aStream, const TOle2FAT* aFAT)/* overload */;
	__int64 __fastcall GetNextSector(const __int64 Sect);
	__int64 __fastcall FindSector(const __int64 StartSect, const __int64 SectOfs);
public:
	#pragma option push -w-inl
	/* UInt32List.Destroy */ inline __fastcall virtual ~TOle2MiniFAT(void) { }
	#pragma option pop
	
};


class DELPHICLASS TOle2Directory;
class PASCALIMPLEMENTATION TOle2Directory : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	DynamicArray<Byte >  Data;
	int __fastcall Get_NameSize(void);
	void __fastcall Set_NameSize(const int value);
	WideString __fastcall Get_Name();
	void __fastcall Set_Name(const WideString value);
	STGTY __fastcall Get_ObjType(void);
	void __fastcall Set_ObjType(const STGTY value);
	__int64 __fastcall Get_SectStart(void);
	void __fastcall Set_SectStart(const __int64 value);
	__int64 __fastcall Get_xulSize(void);
	void __fastcall Set_xulSize(const __int64 value);
	
public:
	__int64 ulSize;
	__fastcall TOle2Directory(const Uflxmessages::ByteArray aData);
	void __fastcall Save(const Classes::TStream* aStream);
	/*         class method */ static int __fastcall GetNameSize(TMetaClass* vmt, const Uflxmessages::ByteArray Data, const int StartPos);
	/*         class method */ static WideString __fastcall GetName(TMetaClass* vmt, const Uflxmessages::ByteArray Data, const int StartPos);
	/*         class method */ static STGTY __fastcall GetType(TMetaClass* vmt, const Uflxmessages::ByteArray Data, const int StartPos);
	/*         class method */ static __int64 __fastcall GetSectStart(TMetaClass* vmt, const Uflxmessages::ByteArray Data, const int StartPos);
	/*         class method */ static void __fastcall SetSectStart(TMetaClass* vmt, const Uflxmessages::ByteArray Data, const int StartPos, const __int64 value);
	/*         class method */ static __int64 __fastcall GetSize(TMetaClass* vmt, const Uflxmessages::ByteArray Data, const int StartPos);
	/*         class method */ static void __fastcall SetSize(TMetaClass* vmt, const Uflxmessages::ByteArray Data, const int StartPos, const __int64 value);
	/*         class method */ static void __fastcall Clear(TMetaClass* vmt, const Uflxmessages::ByteArray Data, const int StartPos);
	/*         class method */ static int __fastcall GetLeftSid(TMetaClass* vmt, const Uflxmessages::ByteArray Data, const int StartPos);
	/*         class method */ static void __fastcall SetLeftSid(TMetaClass* vmt, const Uflxmessages::ByteArray Data, const int StartPos, const int value);
	/*         class method */ static int __fastcall GetRightSid(TMetaClass* vmt, const Uflxmessages::ByteArray Data, const int StartPos);
	/*         class method */ static void __fastcall SetRightSid(TMetaClass* vmt, const Uflxmessages::ByteArray Data, const int StartPos, const int value);
	/*         class method */ static int __fastcall GetChildSid(TMetaClass* vmt, const Uflxmessages::ByteArray Data, const int StartPos);
	/*         class method */ static void __fastcall SetChildSid(TMetaClass* vmt, const Uflxmessages::ByteArray Data, const int StartPos, const int value);
	/*         class method */ static DECOLOR __fastcall GetColor(TMetaClass* vmt, const Uflxmessages::ByteArray Data, const int StartPos);
	/*         class method */ static void __fastcall SetColor(TMetaClass* vmt, const Uflxmessages::ByteArray Data, const int StartPos, const DECOLOR value);
	__property int NameSize = {read=Get_NameSize, write=Set_NameSize, nodefault};
	__property WideString Name = {read=Get_Name, write=Set_Name};
	__property STGTY ObjType = {read=Get_ObjType, write=Set_ObjType, nodefault};
	__property __int64 SectStart = {read=Get_SectStart, write=Set_SectStart};
	__property __int64 xulSize = {read=Get_xulSize, write=Set_xulSize};
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TOle2Directory(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSectorBuffer;
class PASCALIMPLEMENTATION TSectorBuffer : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	DynamicArray<Byte >  Data;
	bool Changed;
	__int64 FSectorId;
	TOle2Header* Header;
	Classes::TStream* DataStream;
	
public:
	__fastcall TSectorBuffer(const TOle2Header* aHeader, const Classes::TStream* aStream);
	void __fastcall Load(const __int64 SectNo);
	void __fastcall Save(void);
	void __fastcall Read(const Uflxmessages::ByteArray aBuffer, const __int64 BufferPos, /* out */ __int64 &nRead, const __int64 StartPos, const __int64 Count, const __int64 SectorSize);
	void __fastcall ReadMem(void *aBuffer, const __int64 BufferPos, /* out */ __int64 &nRead, const __int64 StartPos, const __int64 Count, const __int64 SectorSize);
	__property __int64 SectorId = {read=FSectorId};
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TSectorBuffer(void) { }
	#pragma option pop
	
};


class DELPHICLASS TOle2File;
class PASCALIMPLEMENTATION TOle2File : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	Classes::TStream* FStream;
	TOle2Header* Header;
	TOle2FAT* FAT;
	TOle2MiniFAT* MiniFAT;
	TSectorBuffer* SectorBuffer;
	TOle2Directory* ROOT;
	Uxlsprotect::TEncryptionData* FEncryption;
	WideString TOle2FileStr;
	bool disposed;
	TOle2Directory* DIR;
	__int64 StreamPos;
	bool PreparedForWrite;
	__int64 DIRStartPos;
	void __fastcall MarkDeleted(const int i, const TDirEntryList* Result, const int Level);
	/*         class method */ static void __fastcall DeleteNode(TMetaClass* vmt, const TDirEntryList* Result, int &ParentLeaf);
	void __fastcall FixNode(const TDirEntryList* Result, int &ParentNode);
	TDirEntryList* __fastcall ReadDirs(const StringArray DeletedStorages, bool &PaintItBlack);
	void __fastcall FinishStream(void);
	__int64 __fastcall Get_Length(void);
	__int64 __fastcall Get_Position(void);
	bool __fastcall Get_Eof(void);
	WideString __fastcall Get_FileName();
	
public:
	bool NotXls97;
	__fastcall TOle2File(const Classes::TStream* aStream)/* overload */;
	__fastcall TOle2File(const Classes::TStream* aStream, const bool AvoidExceptions)/* overload */;
	__fastcall virtual ~TOle2File(void);
	void __fastcall Close(void);
	TOle2Directory* __fastcall FindDir(const WideString DirName);
	TOle2Directory* __fastcall FindRoot(void);
	void __fastcall SelectStream(const WideString StreamName);
	bool __fastcall NextEof(const int Count);
	void __fastcall ReadMem(void *aBuffer, const int Count);
	void __fastcall WriteRawMem(const void *Buffer, const int Count)/* overload */;
	void __fastcall WriteMem(const void *Buffer, const int Count)/* overload */;
	void __fastcall Read(const Uflxmessages::ByteArray aBuffer, const int Count);
	void __fastcall WriteRaw(const Uflxmessages::ByteArray Buffer, const int Count)/* overload */;
	void __fastcall Write(Uflxmessages::ByteArray Buffer, const int Count)/* overload */;
	void __fastcall WriteRaw(const Uflxmessages::ByteArray Buffer, const int StartPos, const int Count)/* overload */;
	void __fastcall WriteHeader(const Word Id, const Word Len);
	void __fastcall Write(Uflxmessages::ByteArray Buffer, const int StartPos, const int Count)/* overload */;
	void __fastcall Write16(Word Buffer);
	void __fastcall Write32(unsigned Buffer);
	/*         class method */ static bool __fastcall FindString(TMetaClass* vmt, const WideString s, const StringArray list);
	void __fastcall SeekForward(const __int64 Offset);
	void __fastcall PrepareForWrite(const Classes::TStream* OutStream, const WideString OStreamName, const StringArray DeleteStorages);
	__property Uxlsprotect::TEncryptionData* Encryption = {read=FEncryption};
	__property __int64 Length = {read=Get_Length};
	__property __int64 Position = {read=Get_Position};
	__property bool Eof = {read=Get_Eof, nodefault};
	__property WideString FileName = {read=Get_FileName};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uole2impl */
using namespace Uole2impl;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Uole2impl
