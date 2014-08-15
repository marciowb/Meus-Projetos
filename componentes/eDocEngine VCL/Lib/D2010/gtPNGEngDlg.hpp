// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtpngengdlg.pas' rev: 21.00

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
#include <Types.hpp>	// Pascal unit

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
	Types::TPoint PNGMousePoint;
	
protected:
	virtual void __fastcall Localize(void);
public:
	/* TgtBaseDlg.Create */ inline __fastcall virtual TgtPNGEngineDlg(Classes::TComponent* AOwner) : Gtgfxdlg::TgtGraphicsDlg(AOwner) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TgtPNGEngineDlg(Classes::TComponent* AOwner, int Dummy) : Gtgfxdlg::TgtGraphicsDlg(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TgtPNGEngineDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TgtPNGEngineDlg(HWND ParentWindow) : Gtgfxdlg::TgtGraphicsDlg(ParentWindow) { }
	
};


typedef StaticArray<System::UnicodeString, 4> Gtpngengdlg__2;

typedef StaticArray<System::UnicodeString, 2> Gtpngengdlg__3;

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Gtpngengdlg__2 PNGColorType;
extern PACKAGE Gtpngengdlg__3 PNGUnitSpecifier;

}	/* namespace Gtpngengdlg */
using namespace Gtpngengdlg;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GtpngengdlgHPP
