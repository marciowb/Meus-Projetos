// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advreflectionimage.pas' rev: 21.00

#ifndef AdvreflectionimageHPP
#define AdvreflectionimageHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Gdipicture.hpp>	// Pascal unit
#include <Advhintinfo.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advreflectionimage
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TImageType { itPNG, itBMP, itJPEG, itTIFF, itGIF };
#pragma option pop

class DELPHICLASS TAdvReflectionImage;
class PASCALIMPLEMENTATION TAdvReflectionImage : public Controls::TGraphicControl
{
	typedef Controls::TGraphicControl inherited;
	
private:
	bool FAutoSize;
	bool FMouseInControl;
	Classes::TNotifyEvent FOnMouseLeave;
	Classes::TNotifyEvent FOnMouseEnter;
	Advhintinfo::TAdvHintInfo* FOfficeHint;
	Gdipicture::TGDIPPicture* FIPicture;
	Advgdip::TGPBitmap* FReflectionPic;
	int FReflectionOpacityStart;
	int FReflectionOpacityEnd;
	int FReflectionSize;
	int FReflectionAxis;
	void __fastcall OnPictureChanged(System::TObject* Sender);
	MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetOfficeHint(const Advhintinfo::TAdvHintInfo* Value);
	void __fastcall SetIPicture(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetReflectionOpacityStart(const int Value);
	void __fastcall SetReflectionOpacityEnd(const int Value);
	void __fastcall SetReflectionSize(const int Value);
	void __fastcall SetReflectionAxis(const int Value);
	void __fastcall SetAutoSizeEx(const bool Value);
	
protected:
	virtual void __fastcall DrawImage(Graphics::TCanvas* ACanvas);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Loaded(void);
	void __fastcall UpdateReflection(void);
	void __fastcall UpdateSize(void);
	__property bool MouseInControl = {read=FMouseInControl, nodefault};
	
public:
	__fastcall virtual TAdvReflectionImage(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvReflectionImage(void);
	virtual int __fastcall GetVersionNr(void);
	void __fastcall SaveToFile(System::UnicodeString FileName, TImageType ImageType = (TImageType)(0x0));
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSizeEx, nodefault};
	__property BiDiMode;
	__property Constraints;
	__property Gdipicture::TGDIPPicture* Picture = {read=FIPicture, write=SetIPicture};
	__property PopupMenu;
	__property ShowHint;
	__property Advhintinfo::TAdvHintInfo* OfficeHint = {read=FOfficeHint, write=SetOfficeHint};
	__property int ReflectionOpacityStart = {read=FReflectionOpacityStart, write=SetReflectionOpacityStart, default=255};
	__property int ReflectionOpacityEnd = {read=FReflectionOpacityEnd, write=SetReflectionOpacityEnd, default=0};
	__property int ReflectionSize = {read=FReflectionSize, write=SetReflectionSize, default=100};
	__property int ReflectionAxis = {read=FReflectionAxis, write=SetReflectionAxis, default=1};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x5;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x2;

}	/* namespace Advreflectionimage */
using namespace Advreflectionimage;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvreflectionimageHPP
