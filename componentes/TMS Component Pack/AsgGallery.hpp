// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Asggallery.pas' rev: 21.00

#ifndef AsggalleryHPP
#define AsggalleryHPP

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
#include <Grids.hpp>	// Pascal unit
#include <Basegrid.hpp>	// Pascal unit
#include <Advgrid.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Asggallery
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TGridGallery;
class PASCALIMPLEMENTATION TGridGallery : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TGroupBox* GroupBox1;
	Advgrid::TAdvStringGrid* AdvStringGrid1;
	Stdctrls::TButton* Button1;
	Stdctrls::TButton* Button2;
	Stdctrls::TGroupBox* GroupBox2;
	Stdctrls::TListBox* ListBox1;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ListBox1Click(System::TObject* Sender);
	
private:
	System::UnicodeString FGalleryFile;
	
public:
	int oldidx;
	__property System::UnicodeString GalleryFile = {read=FGalleryFile};
	void __fastcall InitGrid(void);
	void __fastcall LoadList(void);
	void __fastcall ResToFile(System::UnicodeString ResName, System::UnicodeString FileName);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TGridGallery(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TGridGallery(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TGridGallery(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TGridGallery(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TGridGallery* GridGallery;

}	/* namespace Asggallery */
using namespace Asggallery;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AsggalleryHPP
