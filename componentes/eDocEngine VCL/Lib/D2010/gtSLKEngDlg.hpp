// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtslkengdlg.pas' rev: 21.00

#ifndef GtslkengdlgHPP
#define GtslkengdlgHPP

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
#include <Extctrls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Gtspddlg.hpp>	// Pascal unit
#include <Gtdocresstrs.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtslkengdlg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TgtSYLKEngineDlg;
class PASCALIMPLEMENTATION TgtSYLKEngineDlg : public Gtspddlg::TgtSpreadSheetDlg
{
	typedef Gtspddlg::TgtSpreadSheetDlg inherited;
	
__published:
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	
protected:
	virtual void __fastcall Localize(void);
public:
	/* TgtBaseDlg.Create */ inline __fastcall virtual TgtSYLKEngineDlg(Classes::TComponent* AOwner) : Gtspddlg::TgtSpreadSheetDlg(AOwner) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TgtSYLKEngineDlg(Classes::TComponent* AOwner, int Dummy) : Gtspddlg::TgtSpreadSheetDlg(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TgtSYLKEngineDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TgtSYLKEngineDlg(HWND ParentWindow) : Gtspddlg::TgtSpreadSheetDlg(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gtslkengdlg */
using namespace Gtslkengdlg;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GtslkengdlgHPP
