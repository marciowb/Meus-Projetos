// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advtrackbargallery.pas' rev: 21.00

#ifndef AdvtrackbargalleryHPP
#define AdvtrackbargalleryHPP

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
#include <Advtrackbar.hpp>	// Pascal unit
#include <Advtrackbarpersist.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advtrackbargallery
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvTrackBarGalleryForm;
class PASCALIMPLEMENTATION TAdvTrackBarGalleryForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TGroupBox* GroupBox1;
	Stdctrls::TGroupBox* GroupBox2;
	Stdctrls::TListBox* ListBox1;
	Advtrackbar::TAdvTrackBar* AdvTrackBar1;
	Stdctrls::TEdit* Edit1;
	Stdctrls::TLabel* Label1;
	Stdctrls::TButton* Button1;
	Stdctrls::TButton* Button2;
	Stdctrls::TButton* Button3;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall ListBox1Click(System::TObject* Sender);
	
private:
	System::UnicodeString FSelection;
	void __fastcall ResToFile(System::UnicodeString ResName, System::UnicodeString FileName);
	
public:
	void __fastcall LoadList(void);
	__property System::UnicodeString Selection = {read=FSelection, write=FSelection};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAdvTrackBarGalleryForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAdvTrackBarGalleryForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAdvTrackBarGalleryForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvTrackBarGalleryForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TAdvTrackBarGalleryForm* AdvTrackBarGalleryForm;

}	/* namespace Advtrackbargallery */
using namespace Advtrackbargallery;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvtrackbargalleryHPP
