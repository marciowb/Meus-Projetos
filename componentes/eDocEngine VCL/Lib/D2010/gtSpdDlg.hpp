// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtspddlg.pas' rev: 21.00

#ifndef GtspddlgHPP
#define GtspddlgHPP

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
#include <Stdctrls.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Extdlgs.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Gtcstspdeng.hpp>	// Pascal unit
#include <Gtdocdlg.hpp>	// Pascal unit
#include <Gtdocresstrs.hpp>	// Pascal unit
#include <Gtutils.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtspddlg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TgtSpreadSheetDlg;
class PASCALIMPLEMENTATION TgtSpreadSheetDlg : public Gtdocdlg::TgtDocumentDlg
{
	typedef Gtdocdlg::TgtDocumentDlg inherited;
	
__published:
	Comctrls::TTabSheet* tsFormatting;
	Stdctrls::TGroupBox* gbFormattingOptions;
	Stdctrls::TLabel* lblColumnSpacing;
	Stdctrls::TLabel* lblRowSpacing;
	Stdctrls::TLabel* lblScaleX;
	Stdctrls::TLabel* lblScaleY;
	Stdctrls::TEdit* edColumnSpacing;
	Stdctrls::TEdit* edRowSpacing;
	Stdctrls::TEdit* edScaleX;
	Stdctrls::TEdit* edScaleY;
	Stdctrls::TCheckBox* chkAutoFormatCells;
	void __fastcall edColumnSpacingKeyPress(System::TObject* Sender, System::WideChar &Key);
	HIDESBASE void __fastcall edKeyPress(System::TObject* Sender, System::WideChar &Key);
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	HIDESBASE void __fastcall btnOKClick(System::TObject* Sender);
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall edRowSpacingKeyPress(System::TObject* Sender, System::WideChar &Key);
	
protected:
	virtual void __fastcall Localize(void);
public:
	/* TgtBaseDlg.Create */ inline __fastcall virtual TgtSpreadSheetDlg(Classes::TComponent* AOwner) : Gtdocdlg::TgtDocumentDlg(AOwner) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TgtSpreadSheetDlg(Classes::TComponent* AOwner, int Dummy) : Gtdocdlg::TgtDocumentDlg(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TgtSpreadSheetDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TgtSpreadSheetDlg(HWND ParentWindow) : Gtdocdlg::TgtDocumentDlg(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gtspddlg */
using namespace Gtspddlg;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GtspddlgHPP
