// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtjpegengdlg.pas' rev: 10.00

#ifndef GtjpegengdlgHPP
#define GtjpegengdlgHPP

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
#include <Gtjpegeng.hpp>	// Pascal unit
#include <Jpeg.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtjpegengdlg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TgtJPEGEngineDlg;
class PASCALIMPLEMENTATION TgtJPEGEngineDlg : public Gtgfxdlg::TgtGraphicsDlg 
{
	typedef Gtgfxdlg::TgtGraphicsDlg inherited;
	
__published:
	Stdctrls::TCheckBox* chkProgressiveEncoding;
	Stdctrls::TLabel* lblQuality;
	Stdctrls::TEdit* edQuality;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	HIDESBASE void __fastcall btnOKClick(System::TObject* Sender);
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	
protected:
	virtual void __fastcall Localize(void);
public:
	#pragma option push -w-inl
	/* TgtBaseDlg.Create */ inline __fastcall virtual TgtJPEGEngineDlg(Classes::TComponent* AOwner) : Gtgfxdlg::TgtGraphicsDlg(AOwner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TgtJPEGEngineDlg(Classes::TComponent* AOwner, int Dummy) : Gtgfxdlg::TgtGraphicsDlg(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TgtJPEGEngineDlg(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TgtJPEGEngineDlg(HWND ParentWindow) : Gtgfxdlg::TgtGraphicsDlg(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gtjpegengdlg */
using namespace Gtjpegengdlg;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Gtjpegengdlg
