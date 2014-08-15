// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gdipimagetextitem.pas' rev: 21.00

#ifndef GdipimagetextitemHPP
#define GdipimagetextitemHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Gdipcustomitem.hpp>	// Pascal unit
#include <Gdiptextitem.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gdipimagetextitem
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TImageTextItem;
class PASCALIMPLEMENTATION TImageTextItem : public Gdiptextitem::TTextItem
{
	typedef Gdiptextitem::TTextItem inherited;
	
private:
	Advgdip::TAdvGDIPPicture* FImage;
	int FImageHeight;
	int FImageWidth;
	bool FImageVisible;
	int FSpacing;
	System::UnicodeString FImageName;
	int FImageIndex;
	void __fastcall SetImage(const Advgdip::TAdvGDIPPicture* Value);
	void __fastcall SetImageHeight(const int Value);
	void __fastcall SetImageVisible(const bool Value);
	void __fastcall SetImageWidth(const int Value);
	void __fastcall SetSpacing(const int Value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetImageName(const System::UnicodeString Value);
	
protected:
	void __fastcall ImageChanged(System::TObject* Sender);
	virtual bool __fastcall DrawImageFromImageList(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &ARect, const Gdipcustomitem::TItemAppearance &ItemAppearance, int Image);
	virtual bool __fastcall DrawImageFromContainer(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &ARect, const Gdipcustomitem::TItemAppearance &ItemAppearance, System::UnicodeString Image);
	virtual int __fastcall GetVersionNr(void);
	
public:
	__fastcall virtual TImageTextItem(Classes::TComponent* AOwner);
	__fastcall virtual ~TImageTextItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual Gdipcustomitem::TCustomItem* __fastcall CreateNewItem(Classes::TComponent* AOwner);
	virtual Classes::TComponentClass __fastcall GetClassType(void);
	__classmethod virtual System::UnicodeString __fastcall CustomClassName();
	virtual void __fastcall DrawInRect(Advgdip::TGPGraphics* g, const Gdipcustomitem::TItemAppearance &ItemAppearance, const Advgdip::TGPRectF &R);
	virtual Advgdip::TGPRectF __fastcall DrawText(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &ARect, const Gdipcustomitem::TItemAppearance &ItemAppearance, bool DoText = true);
	virtual void __fastcall DrawImage(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &ARect, const Gdipcustomitem::TItemAppearance &ItemAppearance);
	virtual Gdipcustomitem::TItemInteractionType __fastcall GetItemInteraction(int pX, int pY);
	bool __fastcall IsImageVisible(const Gdipcustomitem::TItemAppearance &ItemAppearance);
	virtual void __fastcall InitDesignTime(void);
	
__published:
	__property Advgdip::TAdvGDIPPicture* Image = {read=FImage, write=SetImage};
	__property int ImageHeight = {read=FImageHeight, write=SetImageHeight, default=18};
	__property int ImageWidth = {read=FImageWidth, write=SetImageWidth, default=18};
	__property bool ImageVisible = {read=FImageVisible, write=SetImageVisible, default=1};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property System::UnicodeString ImageName = {read=FImageName, write=SetImageName};
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=3};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;
extern PACKAGE void __fastcall Register(void);

}	/* namespace Gdipimagetextitem */
using namespace Gdipimagetextitem;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GdipimagetextitemHPP
