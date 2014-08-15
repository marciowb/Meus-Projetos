// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtgfxdlg.pas' rev: 21.00

#ifndef GtgfxdlgHPP
#define GtgfxdlgHPP

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
#include <Gtcstgfxeng.hpp>	// Pascal unit
#include <Gtdocdlg.hpp>	// Pascal unit
#include <Gtdocresstrs.hpp>	// Pascal unit
#include <Gtutils.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtgfxdlg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TgtGraphicsDlg;
class PASCALIMPLEMENTATION TgtGraphicsDlg : public Gtdocdlg::TgtDocumentDlg
{
	typedef Gtdocdlg::TgtDocumentDlg inherited;
	
__published:
	Comctrls::TTabSheet* tsQualityAndScaling;
	Stdctrls::TGroupBox* gbQualityAndScaling;
	Stdctrls::TLabel* lblPixelFormat;
	Stdctrls::TComboBox* cbPixelFormat;
	Stdctrls::TEdit* edScaleX;
	Stdctrls::TEdit* edScaleY;
	Stdctrls::TLabel* lblScaleX;
	Stdctrls::TLabel* lblScaleY;
	Stdctrls::TCheckBox* chkMonochrome;
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	HIDESBASE void __fastcall btnOKClick(System::TObject* Sender);
	void __fastcall chkImageClick(System::TObject* Sender);
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	
protected:
	virtual void __fastcall Localize(void);
public:
	/* TgtBaseDlg.Create */ inline __fastcall virtual TgtGraphicsDlg(Classes::TComponent* AOwner) : Gtdocdlg::TgtDocumentDlg(AOwner) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TgtGraphicsDlg(Classes::TComponent* AOwner, int Dummy) : Gtdocdlg::TgtDocumentDlg(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TgtGraphicsDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TgtGraphicsDlg(HWND ParentWindow) : Gtdocdlg::TgtDocumentDlg(ParentWindow) { }
	
};


typedef StaticArray<System::UnicodeString, 9> Gtgfxdlg__2;

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Gtgfxdlg__2 PixelFormats;

}	/* namespace Gtgfxdlg */
using namespace Gtgfxdlg;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GtgfxdlgHPP
