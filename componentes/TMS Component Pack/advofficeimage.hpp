// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advofficeimage.pas' rev: 21.00

#ifndef AdvofficeimageHPP
#define AdvofficeimageHPP

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
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advofficeimage
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvOfficeImage;
class PASCALIMPLEMENTATION TAdvOfficeImage : public Controls::TGraphicControl
{
	typedef Controls::TGraphicControl inherited;
	
private:
	int FOffSet;
	bool FMouseInControl;
	Classes::TNotifyEvent FOnMouseLeave;
	Classes::TNotifyEvent FOnMouseEnter;
	Advhintinfo::TAdvHintInfo* FOfficeHint;
	Gdipicture::TGDIPPicture* FIPicture;
	bool FCenter;
	void __fastcall OnPictureChanged(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetOfficeHint(const Advhintinfo::TAdvHintInfo* Value);
	void __fastcall SetIPicture(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetCenter(const bool Value);
	
protected:
	virtual void __fastcall DrawImage(Graphics::TCanvas* ACanvas);
	virtual void __fastcall Paint(void);
	__property bool MouseInControl = {read=FMouseInControl, nodefault};
	
public:
	__fastcall virtual TAdvOfficeImage(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvOfficeImage(void);
	virtual int __fastcall GetVersionNr(void);
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property bool Center = {read=FCenter, write=SetCenter, default=1};
	__property Constraints;
	__property Gdipicture::TGDIPPicture* Picture = {read=FIPicture, write=SetIPicture};
	__property PopupMenu;
	__property ShowHint;
	__property Advhintinfo::TAdvHintInfo* OfficeHint = {read=FOfficeHint, write=SetOfficeHint};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property OnDragOver;
	__property OnDragDrop;
	__property OnStartDrag;
	__property OnEndDrag;
	__property OnContextPopup;
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x3;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advofficeimage */
using namespace Advofficeimage;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvofficeimageHPP
