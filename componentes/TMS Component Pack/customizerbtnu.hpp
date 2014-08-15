// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Customizerbtnu.pas' rev: 21.00

#ifndef CustomizerbtnuHPP
#define CustomizerbtnuHPP

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
#include <Buttons.hpp>	// Pascal unit
#include <Advtoolbar.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Customizerbtnu
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TCusBtnForm;
class PASCALIMPLEMENTATION TCusBtnForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TButton* BtnOk;
	Stdctrls::TButton* BtnCancel;
	Stdctrls::TGroupBox* GroupBox1;
	Stdctrls::TLabel* LblBtnCaption;
	Stdctrls::TLabel* LblBtnHint;
	Stdctrls::TLabel* LblGlyph;
	Stdctrls::TCheckBox* ChkBtnVis;
	Stdctrls::TCheckBox* ChkBtnShowCap;
	Stdctrls::TEdit* EdtBtnHint;
	Stdctrls::TEdit* EdtBtnCaption;
	Stdctrls::TComboBox* CmBxGlyph;
	void __fastcall OkBitBtnClick(System::TObject* Sender);
	void __fastcall CmBxGlyphDrawItem(Controls::TWinControl* Control, int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	
public:
	Advtoolbar::TAdvToolBarCustomizer* FToolBarCustomizer;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TCusBtnForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TCusBtnForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TCusBtnForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TCusBtnForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TCusBtnForm* CusBtnForm;

}	/* namespace Customizerbtnu */
using namespace Customizerbtnu;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CustomizerbtnuHPP
