// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtexhtmleng.pas' rev: 10.00

#ifndef GtexhtmlengHPP
#define GtexhtmlengHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Gtconsts.hpp>	// Pascal unit
#include <Gtdocconsts.hpp>	// Pascal unit
#include <Gtdocutils.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit
#include <Gtcstplneng.hpp>	// Pascal unit
#include <Gtcsthtmleng.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtexhtmleng
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TgtTOCPageSettings;
class PASCALIMPLEMENTATION TgtTOCPageSettings : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TFont* FItemFont;
	Graphics::TFont* FTitleFont;
	AnsiString FTitle;
	Gtcstdoceng::TgtHAlignment FTitleAlignment;
	void __fastcall SetTitleFont(const Graphics::TFont* Value);
	void __fastcall SetItemFont(const Graphics::TFont* Value);
	
public:
	__fastcall TgtTOCPageSettings(void);
	__fastcall virtual ~TgtTOCPageSettings(void);
	
__published:
	__property Graphics::TFont* ItemFont = {read=FItemFont, write=SetItemFont};
	__property Graphics::TFont* TitleFont = {read=FTitleFont, write=SetTitleFont};
	__property AnsiString Title = {read=FTitle, write=FTitle};
	__property Gtcstdoceng::TgtHAlignment TitleAlignment = {read=FTitleAlignment, write=FTitleAlignment, default=2};
};


class DELPHICLASS TgtExHTMLEngine;
class PASCALIMPLEMENTATION TgtExHTMLEngine : public Gtcsthtmleng::TgtCustomHTMLEngine 
{
	typedef Gtcsthtmleng::TgtCustomHTMLEngine inherited;
	
private:
	TgtTOCPageSettings* FTOCPageSettings;
	AnsiString __fastcall GetFontString(Graphics::TFont* AFont);
	void __fastcall SetTOCPageSettings(const TgtTOCPageSettings* Value);
	
protected:
	virtual void __fastcall InsertAnchors(Classes::TStream* AStream);
	virtual void __fastcall EncodeTOC(void);
	
public:
	__fastcall virtual TgtExHTMLEngine(Classes::TComponent* AOwner);
	__fastcall virtual ~TgtExHTMLEngine(void);
	virtual int __fastcall AddTOCItem(WideString Caption, int ParentNode, int PageNumber, double Top)/* overload */;
	virtual int __fastcall AddTOCItem(WideString Caption, int ParentNode, AnsiString URL)/* overload */;
	
__published:
	__property TgtTOCPageSettings* TOCPageSettings = {read=FTOCPageSettings, write=SetTOCPageSettings};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gtexhtmleng */
using namespace Gtexhtmleng;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Gtexhtmleng
