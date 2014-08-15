// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gdipimageitem.pas' rev: 21.00

#ifndef GdipimageitemHPP
#define GdipimageitemHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Gdipcustomitem.hpp>	// Pascal unit
#include <Gdipimagetextitem.hpp>	// Pascal unit
#include <Gdiptextitem.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gdipimageitem
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TImageItemLayout { ilLeftRight, ilRightLeft, ilTopBottom, ilBottomTop };
#pragma option pop

#pragma option push -b-
enum TImageItemMode { imStretch, imNormal };
#pragma option pop

class DELPHICLASS TImageItem;
class PASCALIMPLEMENTATION TImageItem : public Gdipimagetextitem::TImageTextItem
{
	typedef Gdipimagetextitem::TImageTextItem inherited;
	
private:
	TImageItemLayout FLayout;
	Controls::TMargins* FImageMargin;
	bool FAspectRatio;
	TImageItemMode FImageMode;
	void __fastcall SetLayout(const TImageItemLayout Value);
	void __fastcall SetImageMargin(const Controls::TMargins* Value);
	void __fastcall SetAspectRatio(const bool Value);
	void __fastcall SetImageMode(const TImageItemMode Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	
public:
	__fastcall virtual TImageItem(Classes::TComponent* AOwner);
	__fastcall virtual ~TImageItem(void);
	virtual Advgdip::TGPRectF __fastcall DrawText(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &ARect, const Gdipcustomitem::TItemAppearance &ItemAppearance, bool DoText = true);
	virtual void __fastcall DrawImage(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &ARect, const Gdipcustomitem::TItemAppearance &ItemAppearance);
	virtual Gdipcustomitem::TCustomItem* __fastcall CreateNewItem(Classes::TComponent* AOwner);
	virtual Classes::TComponentClass __fastcall GetClassType(void);
	__classmethod virtual System::UnicodeString __fastcall CustomClassName();
	void __fastcall GetAspectSize(double &w, double &h, double ow, double oh, double nw, double nh);
	
__published:
	__property TImageItemLayout ImageTextLayout = {read=FLayout, write=SetLayout, default=2};
	__property Controls::TMargins* ImageMargin = {read=FImageMargin, write=SetImageMargin};
	__property bool AspectRatio = {read=FAspectRatio, write=SetAspectRatio, default=1};
	__property TImageItemMode ImageMode = {read=FImageMode, write=SetImageMode, default=1};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;
extern PACKAGE void __fastcall Register(void);

}	/* namespace Gdipimageitem */
using namespace Gdipimageitem;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GdipimageitemHPP
