// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Seldlg.pas' rev: 21.00

#ifndef SeldlgHPP
#define SeldlgHPP

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

//-- user supplied -----------------------------------------------------------

namespace Seldlg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS Tselectdialog;
class PASCALIMPLEMENTATION Tselectdialog : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TListBox* tablelist;
	Stdctrls::TButton* OK;
	Stdctrls::TButton* Cancel;
	void __fastcall OKClick(System::TObject* Sender);
	void __fastcall CancelClick(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual Tselectdialog(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual Tselectdialog(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~Tselectdialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall Tselectdialog(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Tselectdialog* selectdialog;

}	/* namespace Seldlg */
using namespace Seldlg;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SeldlgHPP
