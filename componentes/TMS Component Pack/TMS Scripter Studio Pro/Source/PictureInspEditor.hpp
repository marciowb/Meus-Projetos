// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'PictureInspEditor.pas' rev: 22.00

#ifndef PictureinspeditorHPP
#define PictureinspeditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <ExtDlgs.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <PropertyInspEditors.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Pictureinspeditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrmPicture;
class PASCALIMPLEMENTATION TfrmPicture : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TButton* btnOK;
	Stdctrls::TButton* btnCancel;
	Extdlgs::TOpenPictureDialog* opdImage;
	Extdlgs::TSavePictureDialog* svdImage;
	Extctrls::TPanel* pnlImage;
	Stdctrls::TButton* btnLoad;
	Stdctrls::TButton* btnSave;
	Stdctrls::TButton* btnClear;
	Extctrls::TPaintBox* pntImage;
	void __fastcall btnLoadClick(System::TObject* Sender);
	void __fastcall btnSaveClick(System::TObject* Sender);
	void __fastcall btnClearClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall pntImagePaint(System::TObject* Sender);
	
private:
	Graphics::TPicture* FPicture;
	
public:
	__property Graphics::TPicture* Picture = {read=FPicture};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmPicture(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmPicture(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmPicture(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmPicture(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TPicturePropertyEditor;
class PASCALIMPLEMENTATION TPicturePropertyEditor : public Propertyinspeditors::TPropertyEditor
{
	typedef Propertyinspeditors::TPropertyEditor inherited;
	
public:
	virtual bool __fastcall Execute(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TPicturePropertyEditor(Propertylist::TProperty* AProp) : Propertyinspeditors::TPropertyEditor(AProp) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TPicturePropertyEditor(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Pictureinspeditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Pictureinspeditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PictureinspeditorHPP
