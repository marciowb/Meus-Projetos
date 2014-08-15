// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'EditScript.pas' rev: 22.00

#ifndef EditscriptHPP
#define EditscriptHPP

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
#include <Variants.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <AdvMemo.hpp>	// Pascal unit
#include <AdvmBS.hpp>	// Pascal unit
#include <AdvmPS.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Editscript
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TScriptEditForm;
class PASCALIMPLEMENTATION TScriptEditForm : public Forms::TForm
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
	Buttons::TSpeedButton* SpeedButton1;
	Buttons::TSpeedButton* SpeedButton2;
	Stdctrls::TLabel* Func;
	Dialogs::TSaveDialog* SaveDialog1;
	Dialogs::TOpenDialog* OpenDialog1;
	Dialogs::TSaveDialog* SaveDialog2;
	Dialogs::TOpenDialog* OpenDialog2;
	Dialogs::TOpenDialog* OpenDialog3;
	Dialogs::TSaveDialog* SaveDialog3;
	Advmps::TAdvPascalMemoStyler* AdvPascalMemoStyler1;
	Advmbs::TAdvBasicMemoStyler* AdvBasicMemoStyler1;
	void __fastcall spbNewClick(System::TObject* Sender);
	void __fastcall spbUndoClick(System::TObject* Sender);
	void __fastcall spbRedoClick(System::TObject* Sender);
	void __fastcall spbCutClick(System::TObject* Sender);
	void __fastcall spbCopyClick(System::TObject* Sender);
	void __fastcall spbPasteClick(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall SpeedButton2Click(System::TObject* Sender);
	void __fastcall spbOpenClick(System::TObject* Sender);
	void __fastcall spbSaveClick(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TScriptEditForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TScriptEditForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TScriptEditForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TScriptEditForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TScriptEditForm* ScriptEditForm;

}	/* namespace Editscript */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Editscript;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EditscriptHPP
