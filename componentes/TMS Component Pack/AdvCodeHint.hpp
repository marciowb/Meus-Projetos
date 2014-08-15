// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advcodehint.pas' rev: 21.00

#ifndef AdvcodehintHPP
#define AdvcodehintHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Advcodelistlib.hpp>	// Pascal unit
#include <Advmemo.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advcodehint
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TCustomHintWindow;
class PASCALIMPLEMENTATION TCustomHintWindow : public Controls::THintWindow
{
	typedef Controls::THintWindow inherited;
	
private:
	unsigned FRegion;
	void __fastcall FreeCurrentRegion(void);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
public:
	__fastcall virtual ~TCustomHintWindow(void);
	virtual void __fastcall ActivateHint(const Types::TRect &Rect, const System::UnicodeString AHint);
public:
	/* THintWindow.Create */ inline __fastcall virtual TCustomHintWindow(Classes::TComponent* AOwner) : Controls::THintWindow(AOwner) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomHintWindow(HWND ParentWindow) : Controls::THintWindow(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt HintLimit = 0xf;
extern PACKAGE void __fastcall SetActiveStyler(Advmemo::TAdvCustomMemoStyler* AStyler);

}	/* namespace Advcodehint */
using namespace Advcodehint;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvcodehintHPP
