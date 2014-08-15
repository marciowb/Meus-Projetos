// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gdipprogressitem.pas' rev: 21.00

#ifndef GdipprogressitemHPP
#define GdipprogressitemHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Gdipcustomitem.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gdipprogressitem
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TProgressItem;
class PASCALIMPLEMENTATION TProgressItem : public Gdipcustomitem::TCustomItem
{
	typedef Gdipcustomitem::TCustomItem inherited;
	
private:
	Gdipfill::TGDIPProgress* FAppearance;
	int FMax;
	int FMin;
	int FPosition;
	System::UnicodeString FValueFormat;
	bool FShowValue;
	int FMargin;
	void __fastcall SetAppearance(const Gdipfill::TGDIPProgress* Value);
	void __fastcall SetMax(const int Value);
	void __fastcall SetMin(const int Value);
	void __fastcall SetPosition(const int Value);
	void __fastcall SetShowValue(const bool Value);
	void __fastcall SetValueFormat(const System::UnicodeString Value);
	void __fastcall SetMargin(const int Value);
	
public:
	__fastcall virtual TProgressItem(Classes::TComponent* AOwner);
	__fastcall virtual ~TProgressItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual Gdipcustomitem::TCustomItem* __fastcall CreateNewItem(Classes::TComponent* AOwner);
	virtual Classes::TComponentClass __fastcall GetClassType(void);
	__classmethod virtual System::UnicodeString __fastcall CustomClassName();
	virtual void __fastcall DrawInRect(Advgdip::TGPGraphics* g, const Gdipcustomitem::TItemAppearance &ItemAppearance, const Advgdip::TGPRectF &R);
	
__published:
	__property Gdipfill::TGDIPProgress* Appearance = {read=FAppearance, write=SetAppearance};
	__property int Min = {read=FMin, write=SetMin, default=0};
	__property int Max = {read=FMax, write=SetMax, default=100};
	__property int Margin = {read=FMargin, write=SetMargin, default=2};
	__property int Position = {read=FPosition, write=SetPosition, default=0};
	__property bool ShowValue = {read=FShowValue, write=SetShowValue, default=1};
	__property System::UnicodeString ValueFormat = {read=FValueFormat, write=SetValueFormat};
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall Register(void);

}	/* namespace Gdipprogressitem */
using namespace Gdipprogressitem;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GdipprogressitemHPP
