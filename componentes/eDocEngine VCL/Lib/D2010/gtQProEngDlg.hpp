// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtqproengdlg.pas' rev: 21.00

#ifndef GtqproengdlgHPP
#define GtqproengdlgHPP

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
#include <Gtqproeng.hpp>	// Pascal unit
#include <Gtdocresstrs.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtqproengdlg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TgtQuattroProEngineDlg;
class PASCALIMPLEMENTATION TgtQuattroProEngineDlg : public Gtspddlg::TgtSpreadSheetDlg
{
	typedef Gtspddlg::TgtSpreadSheetDlg inherited;
	
__published:
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	HIDESBASE void __fastcall btnOKClick(System::TObject* Sender);
	
protected:
	virtual void __fastcall Localize(void);
public:
	/* TgtBaseDlg.Create */ inline __fastcall virtual TgtQuattroProEngineDlg(Classes::TComponent* AOwner) : Gtspddlg::TgtSpreadSheetDlg(AOwner) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TgtQuattroProEngineDlg(Classes::TComponent* AOwner, int Dummy) : Gtspddlg::TgtSpreadSheetDlg(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TgtQuattroProEngineDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TgtQuattroProEngineDlg(HWND ParentWindow) : Gtspddlg::TgtSpreadSheetDlg(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gtqproengdlg */
using namespace Gtqproengdlg;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GtqproengdlgHPP
