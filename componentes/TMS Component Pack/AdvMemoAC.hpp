// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advmemoac.pas' rev: 21.00

#ifndef AdvmemoacHPP
#define AdvmemoacHPP

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
#include <Extctrls.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advmemoac
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TMemoAC;
class PASCALIMPLEMENTATION TMemoAC : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Grids::TStringGrid* StringGrid1;
	Extctrls::TPanel* Panel1;
	Stdctrls::TButton* Button1;
	Stdctrls::TButton* Button2;
	Extctrls::TPanel* Panel2;
	Buttons::TSpeedButton* SpeedButton1;
	Buttons::TSpeedButton* SpeedButton2;
	Stdctrls::TCheckBox* ckDoAutoCorrect;
	void __fastcall StringGrid1KeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall SpeedButton2Click(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TMemoAC(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TMemoAC(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TMemoAC(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TMemoAC(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TMemoAC* MemoAC;

}	/* namespace Advmemoac */
using namespace Advmemoac;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvmemoacHPP
