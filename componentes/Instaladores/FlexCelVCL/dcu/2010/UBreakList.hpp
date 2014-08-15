// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Ubreaklist.pas' rev: 21.00

#ifndef UbreaklistHPP
#define UbreaklistHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Xlsmessages.hpp>	// Pascal unit
#include <Uxlsbaserecords.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ubreaklist
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TBreakList;
class PASCALIMPLEMENTATION TBreakList : public Classes::TList
{
	typedef Classes::TList inherited;
	
private:
	int CurrentPos;
	int ZeroPos;
	
protected:
	virtual void __fastcall Notify(void * Ptr, Classes::TListNotification Action);
	
public:
	__fastcall TBreakList(const int aZeroPos);
	int __fastcall CurrentId(void);
	int __fastcall CurrentSize(void);
	int __fastcall AcumSize(void);
	void __fastcall IncCurrent(void);
	HIDESBASE void __fastcall Add(const int aId, const int aSize);
	void __fastcall AddToZeroPos(const int Delta);
public:
	/* TList.Destroy */ inline __fastcall virtual ~TBreakList(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Ubreaklist */
using namespace Ubreaklist;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UbreaklistHPP
