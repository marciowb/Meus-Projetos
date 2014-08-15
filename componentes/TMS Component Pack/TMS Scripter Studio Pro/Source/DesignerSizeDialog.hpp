// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'DesignerSizeDialog.pas' rev: 22.00

#ifndef DesignersizedialogHPP
#define DesignersizedialogHPP

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
#include <Character.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Designersizedialog
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrmSize;
class PASCALIMPLEMENTATION TfrmSize : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TGroupBox* grbWidth;
	Stdctrls::TRadioButton* rbtWNoChange;
	Stdctrls::TRadioButton* rbtWToSmallest;
	Stdctrls::TRadioButton* rbtWToLargest;
	Stdctrls::TRadioButton* rbtWidth;
	Stdctrls::TEdit* edtWidth;
	Stdctrls::TGroupBox* grbHeight;
	Stdctrls::TRadioButton* rbtHNoChange;
	Stdctrls::TRadioButton* rbtHToSmallest;
	Stdctrls::TRadioButton* rbtHToLargest;
	Stdctrls::TRadioButton* rbtHeight;
	Stdctrls::TEdit* edtHeight;
	Stdctrls::TButton* btnOk;
	Stdctrls::TButton* btnCancel;
	void __fastcall edtKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall rbtClick(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmSize(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmSize(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmSize(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmSize(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Designersizedialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Designersizedialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DesignersizedialogHPP
