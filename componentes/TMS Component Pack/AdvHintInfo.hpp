// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advhintinfo.pas' rev: 21.00

#ifndef AdvhintinfoHPP
#define AdvhintinfoHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Gdipicture.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advhintinfo
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvHintInfo;
class PASCALIMPLEMENTATION TAdvHintInfo : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Gdipicture::TGDIPPicture* FPicture;
	bool FShowHelp;
	Classes::TStrings* FNotes;
	System::UnicodeString FTitle;
	System::WideString FWideTitle;
	System::WideString FWideNotes;
	void __fastcall SetNotes(const Classes::TStrings* Value);
	void __fastcall SetPicture(const Gdipicture::TGDIPPicture* Value);
	
public:
	__fastcall TAdvHintInfo(void);
	__fastcall virtual ~TAdvHintInfo(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property System::WideString WideTitle = {read=FWideTitle, write=FWideTitle};
	__property System::WideString WideNotes = {read=FWideNotes, write=FWideNotes};
	
__published:
	__property System::UnicodeString Title = {read=FTitle, write=FTitle};
	__property Classes::TStrings* Notes = {read=FNotes, write=SetNotes};
	__property Gdipicture::TGDIPPicture* Picture = {read=FPicture, write=SetPicture};
	__property bool ShowHelp = {read=FShowHelp, write=FShowHelp, default=0};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Advhintinfo */
using namespace Advhintinfo;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvhintinfoHPP
