// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gdippicturecontainereditor.pas' rev: 21.00

#ifndef GdippicturecontainereditorHPP
#define GdippicturecontainereditorHPP

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
#include <Variants.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Advsmoothimagelistbox.hpp>	// Pascal unit
#include <Shlobj.hpp>	// Pascal unit
#include <Gdippicturecontainer.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Filectrl.hpp>	// Pascal unit
#include <Shellapi.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gdippicturecontainereditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TGDIPPictureContainerEditor;
class PASCALIMPLEMENTATION TGDIPPictureContainerEditor : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Extctrls::TPanel* Panel1;
	Advsmoothimagelistbox::TAdvSmoothImageListBox* FileList;
	Stdctrls::TButton* Button2;
	Advsmoothimagelistbox::TAdvSmoothImageListBox* ImageList;
	Stdctrls::TButton* Button3;
	Stdctrls::TCheckBox* CheckBox1;
	Comctrls::TTrackBar* TrackBar1;
	Stdctrls::TLabel* Label1;
	Stdctrls::TButton* Button1;
	Stdctrls::TComboBox* ComboBox2;
	Stdctrls::TButton* Button4;
	Extctrls::TSplitter* Splitter1;
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall ImageListItemZoomIn(System::TObject* Sender, int itemindex, bool &allow);
	void __fastcall ImageListItemStartDrag(System::TObject* Sender, int ItemIndex, bool &AllowDrag);
	void __fastcall FileListDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall FileListDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall ImageListItemSelect(System::TObject* Sender, int itemindex);
	void __fastcall ImageListResize(System::TObject* Sender);
	void __fastcall CheckBox1Click(System::TObject* Sender);
	void __fastcall TrackBar1Change(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall ComboBox2Change(System::TObject* Sender);
	void __fastcall Button4Click(System::TObject* Sender);
	void __fastcall ImageListItemClick(System::TObject* Sender, int itemindex, Controls::TMouseButton Button, Classes::TShiftState Shift);
	void __fastcall ImageListItemDraw(System::TObject* Sender, int itemindex, const Advgdip::TGPRectF &AItemRect, const Advgdip::TGPRectF &AImageRect, Advgdip::TGPGraphics* g);
	void __fastcall FileListItemDraw(System::TObject* Sender, int itemindex, const Advgdip::TGPRectF &AItemRect, const Advgdip::TGPRectF &AImageRect, Advgdip::TGPGraphics* g);
	void __fastcall FileListResize(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FileListItemDblClick(System::TObject* Sender, int itemindex);
	void __fastcall FileListItemStartDrag(System::TObject* Sender, int ItemIndex, bool &AllowDrag);
	
private:
	Gdippicturecontainer::TPictureCollection* FPictureCol;
	
public:
	void __fastcall Init(void);
	__property Gdippicturecontainer::TPictureCollection* PictureCol = {read=FPictureCol, write=FPictureCol};
	void __fastcall PopulateDirectory(System::UnicodeString AFolder);
	void __fastcall AddItems(void);
	void __fastcall AddItem(Advsmoothimagelistbox::TAdvSmoothImageListBoxItem* Item);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TGDIPPictureContainerEditor(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TGDIPPictureContainerEditor(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TGDIPPictureContainerEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TGDIPPictureContainerEditor(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TGDIPPictureContainerEditorDialog;
class PASCALIMPLEMENTATION TGDIPPictureContainerEditorDialog : public Dialogs::TCommonDialog
{
	typedef Dialogs::TCommonDialog inherited;
	
private:
	TGDIPPictureContainerEditor* FForm;
	System::UnicodeString FCaption;
	Gdippicturecontainer::TPictureCollection* FPictureCol;
	void __fastcall SetPictureCol(const Gdippicturecontainer::TPictureCollection* Value);
	
public:
	virtual bool __fastcall Execute(void)/* overload */;
	__property TGDIPPictureContainerEditor* Form = {read=FForm};
	__property Gdippicturecontainer::TPictureCollection* PictureCol = {read=FPictureCol, write=SetPictureCol};
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
public:
	/* TCommonDialog.Create */ inline __fastcall virtual TGDIPPictureContainerEditorDialog(Classes::TComponent* AOwner) : Dialogs::TCommonDialog(AOwner) { }
	/* TCommonDialog.Destroy */ inline __fastcall virtual ~TGDIPPictureContainerEditorDialog(void) { }
	
	
/* Hoisted overloads: */
	
public:
	inline bool __fastcall  Execute(HWND ParentWnd){ return Dialogs::TCommonDialog::Execute(ParentWnd); }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TGDIPPictureContainerEditor* Form1;
extern PACKAGE System::UnicodeString CurrentDir;

}	/* namespace Gdippicturecontainereditor */
using namespace Gdippicturecontainereditor;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GdippicturecontainereditorHPP
