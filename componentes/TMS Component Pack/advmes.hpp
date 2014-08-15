// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advmes.pas' rev: 21.00

#ifndef AdvmesHPP
#define AdvmesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Advmemo.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advmes
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvEmoticonMemoStyler;
class PASCALIMPLEMENTATION TAdvEmoticonMemoStyler : public Advmemo::TAdvCustomMemoStyler
{
	typedef Advmemo::TAdvCustomMemoStyler inherited;
	
private:
	System::UnicodeString FVersion;
	
public:
	__fastcall virtual TAdvEmoticonMemoStyler(Classes::TComponent* AOwner);
	virtual void __fastcall DrawKeyword(Graphics::TCanvas* Canvas, System::UnicodeString AKeyword, Types::TRect &ARect);
	
__published:
	__property AllStyles;
	__property System::UnicodeString Version = {read=FVersion};
	__property Description;
	__property Filter;
	__property DefaultExtension;
	__property StylerName;
	__property Extensions;
public:
	/* TAdvCustomMemoStyler.Destroy */ inline __fastcall virtual ~TAdvEmoticonMemoStyler(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Advmes */
using namespace Advmes;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvmesHPP
