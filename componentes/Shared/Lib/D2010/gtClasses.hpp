// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtclasses.pas' rev: 21.00

#ifndef GtclassesHPP
#define GtclassesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtclasses
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TgtException;
class PASCALIMPLEMENTATION TgtException : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	int ErrorCode;
public:
	/* Exception.Create */ inline __fastcall TgtException(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall TgtException(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall TgtException(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall TgtException(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall TgtException(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall TgtException(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall TgtException(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall TgtException(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~TgtException(void) { }
	
};


class DELPHICLASS EInvalidID;
class PASCALIMPLEMENTATION EInvalidID : public TgtException
{
	typedef TgtException inherited;
	
public:
	/* Exception.Create */ inline __fastcall EInvalidID(const System::UnicodeString Msg) : TgtException(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EInvalidID(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : TgtException(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EInvalidID(int Ident)/* overload */ : TgtException(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EInvalidID(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : TgtException(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EInvalidID(const System::UnicodeString Msg, int AHelpContext) : TgtException(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EInvalidID(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : TgtException(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EInvalidID(int Ident, int AHelpContext)/* overload */ : TgtException(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EInvalidID(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : TgtException(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EInvalidID(void) { }
	
};


class DELPHICLASS EInvalidStream;
class PASCALIMPLEMENTATION EInvalidStream : public TgtException
{
	typedef TgtException inherited;
	
public:
	/* Exception.Create */ inline __fastcall EInvalidStream(const System::UnicodeString Msg) : TgtException(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EInvalidStream(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : TgtException(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EInvalidStream(int Ident)/* overload */ : TgtException(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EInvalidStream(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : TgtException(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EInvalidStream(const System::UnicodeString Msg, int AHelpContext) : TgtException(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EInvalidStream(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : TgtException(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EInvalidStream(int Ident, int AHelpContext)/* overload */ : TgtException(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EInvalidStream(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : TgtException(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EInvalidStream(void) { }
	
};


class DELPHICLASS EReadError;
class PASCALIMPLEMENTATION EReadError : public TgtException
{
	typedef TgtException inherited;
	
public:
	/* Exception.Create */ inline __fastcall EReadError(const System::UnicodeString Msg) : TgtException(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EReadError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : TgtException(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EReadError(int Ident)/* overload */ : TgtException(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EReadError(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : TgtException(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EReadError(const System::UnicodeString Msg, int AHelpContext) : TgtException(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EReadError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : TgtException(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EReadError(int Ident, int AHelpContext)/* overload */ : TgtException(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EReadError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : TgtException(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EReadError(void) { }
	
};


class DELPHICLASS EWriteError;
class PASCALIMPLEMENTATION EWriteError : public TgtException
{
	typedef TgtException inherited;
	
public:
	/* Exception.Create */ inline __fastcall EWriteError(const System::UnicodeString Msg) : TgtException(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EWriteError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : TgtException(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EWriteError(int Ident)/* overload */ : TgtException(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EWriteError(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : TgtException(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EWriteError(const System::UnicodeString Msg, int AHelpContext) : TgtException(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EWriteError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : TgtException(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EWriteError(int Ident, int AHelpContext)/* overload */ : TgtException(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EWriteError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : TgtException(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EWriteError(void) { }
	
};


struct TWString
{
	
public:
	System::WideString WString;
};


class DELPHICLASS TWideStrings;
class PASCALIMPLEMENTATION TWideStrings : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::WideString operator[](int Index) { return Strings[Index]; }
	
private:
	Classes::TList* FWideStringList;
	System::WideString __fastcall Get(int Index);
	void __fastcall Put(int Index, const System::WideString S);
	
public:
	__fastcall TWideStrings(void);
	__fastcall virtual ~TWideStrings(void);
	int __fastcall Count(void);
	void __fastcall Clear(void);
	int __fastcall Add(const System::WideString S);
	System::WideString __fastcall Delete(int Index);
	int __fastcall IndexOf(const System::WideString S);
	int __fastcall IndexOfIgnoreCase(const System::WideString S);
	void __fastcall Insert(int Index, const System::WideString S);
	__property System::WideString Strings[int Index] = {read=Get, write=Put/*, default*/};
};


class DELPHICLASS TgtExtMemStream;
class PASCALIMPLEMENTATION TgtExtMemStream : public Classes::TMemoryStream
{
	typedef Classes::TMemoryStream inherited;
	
private:
	__int64 FPadSize;
	
public:
	__property __int64 PadSize = {read=FPadSize, write=FPadSize};
	__fastcall TgtExtMemStream(void);
	void __fastcall PadTo4Bytes(void);
	int __fastcall SkipBytes(int ANumBytes);
	System::Byte __fastcall ReadByte(void);
	int __fastcall ReadLong(void);
	unsigned __fastcall ReadULong(void);
	short __fastcall ReadShort(void);
	System::Word __fastcall ReadUShort(void);
	System::AnsiString __fastcall ReadString(int ALength);
	void __fastcall ReadByteArray(System::Byte *AByteArray, const int AByteArray_Size, int AOffset, int ALength);
	void __fastcall WriteByte(System::Byte AByte);
	void __fastcall WriteLong(int ALong);
	void __fastcall WriteULong(unsigned AULong);
	void __fastcall WriteShort(short AShort);
	void __fastcall WriteUShort(System::Word AUShort);
	void __fastcall WriteString(System::AnsiString AString);
	void __fastcall WriteByteArray(System::Byte *AByteArray, const int AByteArray_Size);
	void __fastcall WriteUShortArray(System::Word *AUShortArray, const int AUShortArray_Size);
	void __fastcall WriteULongArray(unsigned *AULongArray, const int AULongArray_Size);
public:
	/* TMemoryStream.Destroy */ inline __fastcall virtual ~TgtExtMemStream(void) { }
	
};


class DELPHICLASS TgtComponent;
class PASCALIMPLEMENTATION TgtComponent : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	System::UnicodeString FAbout;
	System::UnicodeString FVersion;
	void __fastcall SetAbout(const System::UnicodeString Value);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
public:
	__fastcall virtual TgtComponent(Classes::TComponent* AOwner);
	__fastcall virtual ~TgtComponent(void);
	
__published:
	__property System::UnicodeString About = {read=FAbout, write=SetAbout};
	__property System::UnicodeString Version = {read=FVersion, write=SetVersion};
};


class DELPHICLASS TgtReadOnlyFilter;
class PASCALIMPLEMENTATION TgtReadOnlyFilter : public Classes::TStream
{
	typedef Classes::TStream inherited;
	
private:
	int FSize;
	Classes::TStream* FStream;
	
public:
	__fastcall TgtReadOnlyFilter(Classes::TStream* aStream);
	virtual int __fastcall Read(void *Buffer, int Count);
	virtual int __fastcall Seek(int Offset, System::Word Origin)/* overload */;
	virtual int __fastcall Write(const void *Buffer, int Count);
	__property Classes::TStream* Stream = {read=FStream};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TgtReadOnlyFilter(void) { }
	
	
/* Hoisted overloads: */
	
public:
	inline __int64 __fastcall  Seek(const __int64 Offset, Classes::TSeekOrigin Origin){ return Classes::TStream::Seek(Offset, Origin); }
	
};


class DELPHICLASS TgtWriteOnlyFilter;
class PASCALIMPLEMENTATION TgtWriteOnlyFilter : public Classes::TStream
{
	typedef Classes::TStream inherited;
	
private:
	Classes::TStream* FStream;
	
public:
	__fastcall TgtWriteOnlyFilter(Classes::TStream* aStream);
	virtual int __fastcall Read(void *Buffer, int Count);
	virtual int __fastcall Seek(int Offset, System::Word Origin)/* overload */;
	virtual int __fastcall Write(const void *Buffer, int Count);
	HIDESBASE __int64 __fastcall CopyFrom(Classes::TStream* Source, __int64 Count);
	__property Classes::TStream* Stream = {read=FStream};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TgtWriteOnlyFilter(void) { }
	
	
/* Hoisted overloads: */
	
public:
	inline __int64 __fastcall  Seek(const __int64 Offset, Classes::TSeekOrigin Origin){ return Classes::TStream::Seek(Offset, Origin); }
	
};


class DELPHICLASS TgtRandomAccessFilter;
class PASCALIMPLEMENTATION TgtRandomAccessFilter : public TgtReadOnlyFilter
{
	typedef TgtReadOnlyFilter inherited;
	
private:
	bool FPeekLastChar;
	
public:
	System::WideChar __fastcall PeekChar(void);
	System::UnicodeString __fastcall PeekString(int Count);
	System::WideChar __fastcall ReadChar(void);
	System::UnicodeString __fastcall ReadString(int Count);
	int __fastcall ReadOffset(void *Buffer, int FromOffset, int ToOffset);
	int __fastcall Skip(int Count);
	void __fastcall PushBackChar(void);
	void __fastcall IncPos(int Count);
	__property bool PeekLastChar = {read=FPeekLastChar, nodefault};
public:
	/* TgtReadOnlyFilter.Create */ inline __fastcall TgtRandomAccessFilter(Classes::TStream* aStream) : TgtReadOnlyFilter(aStream) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TgtRandomAccessFilter(void) { }
	
};


struct TgtObjectItem;
typedef TgtObjectItem *PObjectItem;

struct TgtObjectItem
{
	
public:
	int FInteger;
	System::TObject* FObject;
};


typedef StaticArray<TgtObjectItem, 134217728> TgtObjectItemList;

typedef TgtObjectItemList *PObjectItemList;

class DELPHICLASS TgtObjectList;
class PASCALIMPLEMENTATION TgtObjectList : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
public:
	System::TObject* operator[](int Index) { return Objects[Index]; }
	
private:
	TgtObjectItemList *FList;
	int FCount;
	int FCapacity;
	void __fastcall Grow(void);
	int __fastcall GetCapacity(void);
	int __fastcall GetCount(void);
	System::TObject* __fastcall GetObject(int Index);
	void __fastcall SetCapacity(int NewCapacity);
	TgtObjectItem __fastcall GetItem(int Index);
	
public:
	__fastcall virtual ~TgtObjectList(void);
	int __fastcall Add(int ANo, System::TObject* AObject)/* overload */;
	void __fastcall Add(TgtObjectList* AObjectList)/* overload */;
	void __fastcall Clear(void);
	void __fastcall Delete(int Index);
	int __fastcall IndexOf(const int ObjectNo);
	void __fastcall InsertItem(int Index, int ANo, System::TObject* AObject);
	__property int Capacity = {read=GetCapacity, write=SetCapacity, nodefault};
	__property int Count = {read=GetCount, nodefault};
	__property System::TObject* Objects[int Index] = {read=GetObject/*, default*/};
	__property TgtObjectItem Items[int Index] = {read=GetItem};
public:
	/* TObject.Create */ inline __fastcall TgtObjectList(void) : Classes::TPersistent() { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE System::ResourceString _SInvalidID;
#define Gtclasses_SInvalidID System::LoadResourceString(&Gtclasses::_SInvalidID)
extern PACKAGE System::ResourceString _SNullStreamError;
#define Gtclasses_SNullStreamError System::LoadResourceString(&Gtclasses::_SNullStreamError)
extern PACKAGE System::ResourceString _SWriteError;
#define Gtclasses_SWriteError System::LoadResourceString(&Gtclasses::_SWriteError)
extern PACKAGE System::ResourceString _SReadError;
#define Gtclasses_SReadError System::LoadResourceString(&Gtclasses::_SReadError)
extern PACKAGE System::ResourceString _SInvalidOffset;
#define Gtclasses_SInvalidOffset System::LoadResourceString(&Gtclasses::_SInvalidOffset)
extern PACKAGE System::ResourceString _SSkipCount;
#define Gtclasses_SSkipCount System::LoadResourceString(&Gtclasses::_SSkipCount)
extern PACKAGE System::ResourceString _SListIndexOutOfBounds;
#define Gtclasses_SListIndexOutOfBounds System::LoadResourceString(&Gtclasses::_SListIndexOutOfBounds)
static const ShortInt AX_SIZE = 0x1c;

}	/* namespace Gtclasses */
using namespace Gtclasses;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GtclassesHPP
