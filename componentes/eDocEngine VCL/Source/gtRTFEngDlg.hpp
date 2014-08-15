// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtrtfengdlg.pas' rev: 10.00

#ifndef GtrtfengdlgHPP
#define GtrtfengdlgHPP

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
#include <Gtplndlg.hpp>	// Pascal unit
#include <Gtdocresstrs.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit
#include <Gtrtfeng.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtrtfengdlg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TgtRTFEngineDlg;
class PASCALIMPLEMENTATION TgtRTFEngineDlg : public Gtplndlg::TgtPlainSheetDlg 
{
	typedef Gtplndlg::TgtPlainSheetDlg inherited;
	
__published:
	Stdctrls::TCheckBox* chkGraphicDataInBinary;
	Extctrls::TRadioGroup* rgpEncodingType;
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	HIDESBASE void __fastcall btnOKClick(System::TObject* Sender);
	
protected:
	virtual void __fastcall Localize(void);
public:
	#pragma option push -w-inl
	/* TgtBaseDlg.Create */ inline __fastcall virtual TgtRTFEngineDlg(Classes::TComponent* AOwner) : Gtplndlg::TgtPlainSheetDlg(AOwner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TgtRTFEngineDlg(Classes::TComponent* AOwner, int Dummy) : Gtplndlg::TgtPlainSheetDlg(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TgtRTFEngineDlg(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TgtRTFEngineDlg(HWND ParentWindow) : Gtplndlg::TgtPlainSheetDlg(ParentWindow) { }
	#pragma option pop
	
};


typedef AnsiString gtRTFEngDlg__2[2];

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE AnsiString EncodingType[2];

}	/* namespace Gtrtfengdlg */
using namespace Gtrtfengdlg;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Gtrtfengdlg
