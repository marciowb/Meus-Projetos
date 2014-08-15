// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtxhtmlengdlg.pas' rev: 21.00

#ifndef GtxhtmlengdlgHPP
#define GtxhtmlengdlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Extdlgs.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Gthtmlengdlg.hpp>	// Pascal unit
#include <Gtdocresstrs.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtxhtmlengdlg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TgtXHTMLEngineDlg;
class PASCALIMPLEMENTATION TgtXHTMLEngineDlg : public Gthtmlengdlg::TgtHTMLEngineDlg
{
	typedef Gthtmlengdlg::TgtHTMLEngineDlg inherited;
	
protected:
	virtual void __fastcall Localize(void);
public:
	/* TgtBaseDlg.Create */ inline __fastcall virtual TgtXHTMLEngineDlg(Classes::TComponent* AOwner) : Gthtmlengdlg::TgtHTMLEngineDlg(AOwner) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TgtXHTMLEngineDlg(Classes::TComponent* AOwner, int Dummy) : Gthtmlengdlg::TgtHTMLEngineDlg(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TgtXHTMLEngineDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TgtXHTMLEngineDlg(HWND ParentWindow) : Gthtmlengdlg::TgtHTMLEngineDlg(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gtxhtmlengdlg */
using namespace Gtxhtmlengdlg;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GtxhtmlengdlgHPP
