// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gttiffengdlg.pas' rev: 10.00

#ifndef GttiffengdlgHPP
#define GttiffengdlgHPP

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
#include <Gtgfxdlg.hpp>	// Pascal unit
#include <Gtdocresstrs.hpp>	// Pascal unit
#include <Gttiffeng.hpp>	// Pascal unit
#include <Gtutils.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gttiffengdlg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TgtTIFFEngineDlg;
class PASCALIMPLEMENTATION TgtTIFFEngineDlg : public Gtgfxdlg::TgtGraphicsDlg 
{
	typedef Gtgfxdlg::TgtGraphicsDlg inherited;
	
__published:
	Stdctrls::TCheckBox* chkGrayscale;
	Stdctrls::TCheckBox* chkMultiPage;
	Stdctrls::TLabel* lblCompressionType;
	Stdctrls::TComboBox* cbCompressionType;
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	HIDESBASE void __fastcall btnOKClick(System::TObject* Sender);
	
protected:
	virtual void __fastcall Localize(void);
public:
	#pragma option push -w-inl
	/* TgtBaseDlg.Create */ inline __fastcall virtual TgtTIFFEngineDlg(Classes::TComponent* AOwner) : Gtgfxdlg::TgtGraphicsDlg(AOwner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TgtTIFFEngineDlg(Classes::TComponent* AOwner, int Dummy) : Gtgfxdlg::TgtGraphicsDlg(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TgtTIFFEngineDlg(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TgtTIFFEngineDlg(HWND ParentWindow) : Gtgfxdlg::TgtGraphicsDlg(ParentWindow) { }
	#pragma option pop
	
};


typedef AnsiString gtTIFFEngDlg__2[3];

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE AnsiString TIFFCompressionType[3];

}	/* namespace Gttiffengdlg */
using namespace Gttiffengdlg;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Gttiffengdlg
