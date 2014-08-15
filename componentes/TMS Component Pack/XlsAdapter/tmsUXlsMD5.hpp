// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Tmsuxlsmd5.pas' rev: 21.00

#ifndef Tmsuxlsmd5HPP
#define Tmsuxlsmd5HPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Tmsuxlsmd5
{
//-- type declarations -------------------------------------------------------
typedef StaticArray<unsigned, 4> TMd5Digest;

class DELPHICLASS TMd5Stream;
class PASCALIMPLEMENTATION TMd5Stream : public Classes::TStream
{
	typedef Classes::TStream inherited;
	
private:
	__int64 BlockCount;
	unsigned BufCount;
	StaticArray<unsigned, 16> Buffer;
	unsigned A;
	unsigned B;
	unsigned C;
	unsigned D;
	unsigned __fastcall F(unsigned X, unsigned Y, unsigned Z);
	unsigned __fastcall G(unsigned X, unsigned Y, unsigned Z);
	unsigned __fastcall H(unsigned X, unsigned Y, unsigned Z);
	unsigned __fastcall I(unsigned X, unsigned Y, unsigned Z);
	unsigned __fastcall Rotate(unsigned L, unsigned NumBits);
	
protected:
	virtual void __fastcall AddByte(System::Byte B);
	virtual System::UnicodeString __fastcall GetDigestString(void);
	virtual void __fastcall Initialize(void);
	virtual void __fastcall UpdateDigest(void);
	
public:
	__fastcall TMd5Stream(void);
	virtual int __fastcall Read(void *Buffer, int Count);
	virtual int __fastcall Seek(int Offset, System::Word Origin)/* overload */;
	virtual int __fastcall Write(const void *Buffer, int Count);
	virtual TMd5Digest __fastcall GetDigest(void);
	__property System::UnicodeString DigestString = {read=GetDigestString};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMd5Stream(void) { }
	
	
/* Hoisted overloads: */
	
public:
	inline __int64 __fastcall  Seek(const __int64 Offset, Classes::TSeekOrigin Origin){ return Classes::TStream::Seek(Offset, Origin); }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Tmsuxlsmd5 */
using namespace Tmsuxlsmd5;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Tmsuxlsmd5HPP
