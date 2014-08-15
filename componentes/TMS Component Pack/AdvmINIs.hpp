// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advminis.pas' rev: 21.00

#ifndef AdvminisHPP
#define AdvminisHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Advmemo.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advminis
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvINIMemoStyler;
class PASCALIMPLEMENTATION TAdvINIMemoStyler : public Advmemo::TAdvCustomMemoStyler
{
	typedef Advmemo::TAdvCustomMemoStyler inherited;
	
private:
	System::UnicodeString FVersion;
	
public:
	__fastcall virtual TAdvINIMemoStyler(Classes::TComponent* AOwner);
	
__published:
	__property System::UnicodeString Version = {read=FVersion};
	__property BlockStart;
	__property BlockEnd;
	__property LineComment;
	__property MultiCommentLeft;
	__property MultiCommentRight;
	__property CommentStyle;
	__property NumberStyle;
	__property AllStyles;
	__property AutoCompletion;
	__property HintParameter;
	__property HexIdentifier;
	__property Description;
	__property Filter;
	__property DefaultExtension;
	__property StylerName;
	__property Extensions;
public:
	/* TAdvCustomMemoStyler.Destroy */ inline __fastcall virtual ~TAdvINIMemoStyler(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Advminis */
using namespace Advminis;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvminisHPP
