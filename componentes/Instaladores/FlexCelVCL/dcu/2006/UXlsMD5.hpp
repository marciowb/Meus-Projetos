// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uxlsmd5.pas' rev: 10.00

#ifndef Uxlsmd5HPP
#define Uxlsmd5HPP

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

namespace Uxlsmd5
{
//-- type declarations -------------------------------------------------------
typedef unsigned TMd5Digest[4];

class DELPHICLASS TMd5Stream;
class PASCALIMPLEMENTATION TMd5Stream : public Classes::TStream 
{
	typedef Classes::TStream inherited;
	
private:
	__int64 BlockCount;
	unsigned BufCount;
	unsigned Buffer[16];
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
	virtual void __fastcall AddByte(Byte B);
	virtual AnsiString __fastcall GetDigestString();
	virtual void __fastcall Initialize(void);
	virtual void __fastcall UpdateDigest(void);
	
public:
	__fastcall TMd5Stream(void);
	virtual int __fastcall Read(void *Buffer, int Count);
	virtual int __fastcall Seek(int Offset, Word Origin)/* overload */;
	virtual int __fastcall Write(const void *Buffer, int Count);
	virtual TMd5Digest __fastcall GetDigest();
	__property AnsiString DigestString = {read=GetDigestString};
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TMd5Stream(void) { }
	#pragma option pop
	
	
/* Hoisted overloads: */
	
public:
	inline __int64 __fastcall  Seek(const __int64 Offset, Classes::TSeekOrigin Origin){ return TStream::Seek(Offset, Origin); }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uxlsmd5 */
using namespace Uxlsmd5;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Uxlsmd5
