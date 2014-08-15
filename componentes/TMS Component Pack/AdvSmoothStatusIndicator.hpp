// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothstatusindicator.pas' rev: 21.00

#ifndef AdvsmoothstatusindicatorHPP
#define AdvsmoothstatusindicatorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothstatusindicator
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvSmoothStatusIndicator;
class PASCALIMPLEMENTATION TAdvSmoothStatusIndicator : public Controls::TGraphicControl
{
	typedef Controls::TGraphicControl inherited;
	
private:
	bool FDesignTime;
	bool FResize;
	System::UnicodeString FCaption;
	Gdipfill::TGDIPStatus* FAppearance;
	bool FAutoSz;
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetAppearance(const Gdipfill::TGDIPStatus* Value);
	void __fastcall SetAutoSz(const bool Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	void __fastcall AppearanceChanged(System::TObject* Sender);
	int __fastcall GetVersionNr(void);
	
public:
	__fastcall virtual TAdvSmoothStatusIndicator(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothStatusIndicator(void);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall Paint(void);
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property Gdipfill::TGDIPStatus* Appearance = {read=FAppearance, write=SetAppearance};
	__property bool AutoSize = {read=FAutoSz, write=SetAutoSz, default=0};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property PopupMenu;
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property OnMouseUp;
	__property OnMouseMove;
	__property OnMouseDown;
	__property OnMouseActivate;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property OnDblClick;
	__property OnClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnStartDrag;
	__property OnEndDrag;
	__property Visible = {default=1};
	__property Hint;
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x1;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advsmoothstatusindicator */
using namespace Advsmoothstatusindicator;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothstatusindicatorHPP
