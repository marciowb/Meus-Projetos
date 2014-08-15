// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Umemoedit.pas' rev: 21.00

#ifndef UmemoeditHPP
#define UmemoeditHPP

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
#include <Advmemo.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Extdlgs.hpp>	// Pascal unit
#include <Printers.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Umemoedit
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TTMSMemoEdit;
class PASCALIMPLEMENTATION TTMSMemoEdit : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Advmemo::TAdvMemo* AdvMemo1;
	Extctrls::TPanel* Panel1;
	Buttons::TSpeedButton* spbCut;
	Buttons::TSpeedButton* spbPaste;
	Buttons::TSpeedButton* spbSave;
	Buttons::TSpeedButton* spbOpen;
	Buttons::TSpeedButton* spbCopy;
	Buttons::TSpeedButton* spbUndo;
	Buttons::TSpeedButton* spbRedo;
	Buttons::TSpeedButton* spbNew;
	Dialogs::TOpenDialog* OpenDialog1;
	Dialogs::TSaveDialog* SaveDialog1;
	Buttons::TSpeedButton* SpeedButton1;
	Buttons::TSpeedButton* SpeedButton2;
	Stdctrls::TLabel* Func;
	void __fastcall spbCutClick(System::TObject* Sender);
	void __fastcall spbPasteClick(System::TObject* Sender);
	void __fastcall spbUndoClick(System::TObject* Sender);
	void __fastcall spbRedoClick(System::TObject* Sender);
	void __fastcall spbCopyClick(System::TObject* Sender);
	void __fastcall spbNewClick(System::TObject* Sender);
	void __fastcall spbOpenClick(System::TObject* Sender);
	void __fastcall spbSaveClick(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall SpeedButton2Click(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TTMSMemoEdit(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TTMSMemoEdit(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TTMSMemoEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TTMSMemoEdit(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TTMSMemoEdit* TMSMemoEdit;

}	/* namespace Umemoedit */
using namespace Umemoedit;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UmemoeditHPP
