// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Aniedit.pas' rev: 21.00

#ifndef AnieditHPP
#define AnieditHPP

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
#include <Aniicon.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Aniedit
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAniEditor;
class PASCALIMPLEMENTATION TAniEditor : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TLabel* Label1;
	Extctrls::TPanel* Panel1;
	Dialogs::TOpenDialog* OpenDialog1;
	Aniicon::TAniIcon* AniIcon;
	Stdctrls::TButton* Button1;
	Stdctrls::TButton* Button2;
	Stdctrls::TButton* Button3;
	Stdctrls::TButton* Button4;
	Stdctrls::TButton* Button5;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	
public:
	Sysutils::TFileName FileName;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAniEditor(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAniEditor(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAniEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAniEditor(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TAniEditor* AniEditor;

}	/* namespace Aniedit */
using namespace Aniedit;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AnieditHPP
