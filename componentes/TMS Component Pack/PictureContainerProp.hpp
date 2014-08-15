// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Picturecontainerprop.pas' rev: 21.00

#ifndef PicturecontainerpropHPP
#define PicturecontainerpropHPP

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
#include <Picturecontainer.hpp>	// Pascal unit
#include <Htmlistb.hpp>	// Pascal unit
#include <Shellapi.hpp>	// Pascal unit
#include <Extdlgs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Picturecontainerprop
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TContainerEditor;
class PASCALIMPLEMENTATION TContainerEditor : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Picturecontainer::TPictureContainer* PictureContainer;
	Htmlistb::THTMListBox* HTMListBox;
	Stdctrls::TButton* AddBtn;
	Stdctrls::TButton* RemoveBtn;
	Stdctrls::TButton* OkBtn;
	Dialogs::TOpenDialog* OpenDialog;
	Stdctrls::TButton* ChangeName;
	Stdctrls::TButton* CancelBtn;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall LBWindowProc(Messages::TMessage &Message);
	void __fastcall WMDROPFILES(Messages::TMessage &Msg);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall AddBtnClick(System::TObject* Sender);
	void __fastcall RemoveBtnClick(System::TObject* Sender);
	void __fastcall ChangeNameClick(System::TObject* Sender);
	void __fastcall HTMListBoxKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	
public:
	void __fastcall SetPictureInList(int Index, Picturecontainer::TPictureItem* APictureItem);
	void __fastcall UpdateList(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TContainerEditor(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TContainerEditor(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TContainerEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TContainerEditor(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TContainerEditor* ContainerEditor;
extern PACKAGE Classes::TWndMethod OldLBWindowProc;

}	/* namespace Picturecontainerprop */
using namespace Picturecontainerprop;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PicturecontainerpropHPP
