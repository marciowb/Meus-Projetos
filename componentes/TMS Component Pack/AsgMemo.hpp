// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Asgmemo.pas' rev: 21.00

#ifndef AsgmemoHPP
#define AsgmemoHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Advgrid.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Asgmemo
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvGridMemo;
class PASCALIMPLEMENTATION TAdvGridMemo : public Stdctrls::TMemo
{
	typedef Stdctrls::TMemo inherited;
	
private:
	bool FTabIsExit;
	MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	
__published:
	__property bool TabIsExit = {read=FTabIsExit, write=FTabIsExit, nodefault};
public:
	/* TCustomMemo.Create */ inline __fastcall virtual TAdvGridMemo(Classes::TComponent* AOwner) : Stdctrls::TMemo(AOwner) { }
	/* TCustomMemo.Destroy */ inline __fastcall virtual ~TAdvGridMemo(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvGridMemo(HWND ParentWindow) : Stdctrls::TMemo(ParentWindow) { }
	
};


class DELPHICLASS TMemoEditLink;
class PASCALIMPLEMENTATION TMemoEditLink : public Advgrid::TEditLink
{
	typedef Advgrid::TEditLink inherited;
	
private:
	TAdvGridMemo* FEdit;
	Graphics::TColor FColor;
	int FMaxLength;
	Stdctrls::TScrollStyle FScrollbars;
	bool FTabIsExit;
	bool FWantReturns;
	bool FWantTabs;
	bool FSelectAll;
	bool FWordWrap;
	
protected:
	HIDESBASE void __fastcall EditExit(System::TObject* Sender);
	
public:
	virtual void __fastcall EditKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	__fastcall virtual TMemoEditLink(Classes::TComponent* AOwner);
	virtual void __fastcall CreateEditor(Controls::TWinControl* AParent);
	virtual void __fastcall DestroyEditor(void);
	virtual Controls::TWinControl* __fastcall GetEditControl(void);
	virtual System::UnicodeString __fastcall GetEditorValue(void);
	virtual void __fastcall SetEditorValue(System::UnicodeString s);
	virtual void __fastcall SetProperties(void);
	virtual void __fastcall SetCellProps(Graphics::TColor AColor, Graphics::TFont* AFont);
	
__published:
	__property Graphics::TColor Color = {read=FColor, write=FColor, nodefault};
	__property Stdctrls::TScrollStyle Scrollbars = {read=FScrollbars, write=FScrollbars, nodefault};
	__property int MaxLength = {read=FMaxLength, write=FMaxLength, nodefault};
	__property bool SelectAll = {read=FSelectAll, write=FSelectAll, nodefault};
	__property bool TabIsExit = {read=FTabIsExit, write=FTabIsExit, nodefault};
	__property bool WantReturns = {read=FWantReturns, write=FWantReturns, nodefault};
	__property bool WantTabs = {read=FWantTabs, write=FWantTabs, nodefault};
	__property bool WordWrap = {read=FWordWrap, write=FWordWrap, default=0};
public:
	/* TEditLink.Destroy */ inline __fastcall virtual ~TMemoEditLink(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Asgmemo */
using namespace Asgmemo;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AsgmemoHPP
