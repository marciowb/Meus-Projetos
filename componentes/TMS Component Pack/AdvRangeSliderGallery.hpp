// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advrangeslidergallery.pas' rev: 21.00

#ifndef AdvrangeslidergalleryHPP
#define AdvrangeslidergalleryHPP

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

namespace Advrangeslidergallery
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvRangeSliderGalleryForm;
class PASCALIMPLEMENTATION TAdvRangeSliderGalleryForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TGroupBox* GroupBox1;
	Stdctrls::TGroupBox* GroupBox2;
	Stdctrls::TListBox* ListBox1;
	Stdctrls::TEdit* Edit1;
	Stdctrls::TLabel* Label1;
	Stdctrls::TButton* Button1;
	Stdctrls::TButton* Button2;
	Stdctrls::TButton* Button3;
	Advtrackbar::TAdvRangeSlider* AdvRangeSlider1;
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
	/* TCustomForm.Create */ inline __fastcall virtual TAdvRangeSliderGalleryForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAdvRangeSliderGalleryForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAdvRangeSliderGalleryForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvRangeSliderGalleryForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TAdvRangeSliderGalleryForm* AdvRangeSliderGalleryForm;

}	/* namespace Advrangeslidergallery */
using namespace Advrangeslidergallery;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvrangeslidergalleryHPP
