// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ListForm.pas' rev: 22.00

#ifndef ListformHPP
#define ListformHPP

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
#include <StdCtrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Listform
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfmListForm;
class PASCALIMPLEMENTATION TfmListForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Extctrls::TPanel* Panel1;
	Buttons::TBitBtn* btOk;
	Buttons::TBitBtn* btCancel;
	Extctrls::TPanel* Panel2;
	Stdctrls::TListBox* ListBox;
	void __fastcall ListBoxDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall ListBoxDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall ListBoxDblClick(System::TObject* Sender);
	
public:
	bool AllowDragging;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfmListForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfmListForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfmListForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmListForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TfmListForm* fmListForm;

}	/* namespace Listform */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Listform;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ListformHPP
