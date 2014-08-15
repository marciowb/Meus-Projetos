// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtpngengdlg.pas' rev: 10.00

#ifndef GtpngengdlgHPP
#define GtpngengdlgHPP

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
#include <Gtpngeng.hpp>	// Pascal unit
#include <Gtdocresstrs.hpp>	// Pascal unit
#include <Gtutils.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtpngengdlg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TgtPNGEngineDlg;
class PASCALIMPLEMENTATION TgtPNGEngineDlg : public Gtgfxdlg::TgtGraphicsDlg 
{
	typedef Gtgfxdlg::TgtGraphicsDlg inherited;
	
__published:
	Comctrls::TTabSheet* tsAdvanced;
	Stdctrls::TGroupBox* gbAdvancedOptions;
	Stdctrls::TLabel* lblColorType;
	Stdctrls::TComboBox* cbColorType;
	Stdctrls::TGroupBox* gbPixelDimension;
	Stdctrls::TGroupBox* gbTransparency;
	Stdctrls::TCheckBox* chkPixelDimensions;
	Stdctrls::TCheckBox* chkTransparency;
	Stdctrls::TLabel* lblXPixelsPerUnit;
	Stdctrls::TLabel* lblYPixelsPerUnit;
	Stdctrls::TLabel* lblUnitSpecifier;
	Stdctrls::TEdit* edXPixelsPerUnit;
	Stdctrls::TEdit* edYPixelsPerUnit;
	Stdctrls::TComboBox* cbUnitSpecifier;
	Stdctrls::TLabel* lblImageAlpha;
	Stdctrls::TLabel* lblTransparencyColor;
	Stdctrls::TEdit* edImageAlpha;
	Extctrls::TShape* shpTransparencyColor;
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall chkPixelDimensionsClick(System::TObject* Sender);
	void __fastcall chkTransparencyClick(System::TObject* Sender);
	HIDESBASE void __fastcall btnOKClick(System::TObject* Sender);
	void __fastcall cbColorTypeChange(System::TObject* Sender);
	void __fastcall shpTransparencyColorMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall shpTransparencyColorMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	
private:
	#pragma pack(push,1)
	Types::TPoint PNGMousePoint;
	#pragma pack(pop)
	
protected:
	virtual void __fastcall Localize(void);
public:
	#pragma option push -w-inl
	/* TgtBaseDlg.Create */ inline __fastcall virtual TgtPNGEngineDlg(Classes::TComponent* AOwner) : Gtgfxdlg::TgtGraphicsDlg(AOwner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TgtPNGEngineDlg(Classes::TComponent* AOwner, int Dummy) : Gtgfxdlg::TgtGraphicsDlg(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TgtPNGEngineDlg(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TgtPNGEngineDlg(HWND ParentWindow) : Gtgfxdlg::TgtGraphicsDlg(ParentWindow) { }
	#pragma option pop
	
};


typedef AnsiString gtPNGEngDlg__2[4];

typedef AnsiString gtPNGEngDlg__3[2];

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE AnsiString PNGColorType[4];
extern PACKAGE AnsiString PNGUnitSpecifier[2];

}	/* namespace Gtpngengdlg */
using namespace Gtpngengdlg;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Gtpngengdlg
