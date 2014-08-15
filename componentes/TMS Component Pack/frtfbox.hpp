// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Frtfbox.pas' rev: 21.00

#ifndef FrtfboxHPP
#define FrtfboxHPP

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
#include <Comctrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Toolwin.hpp>	// Pascal unit
#include <Richedit.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frtfbox
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRTFBox;
class PASCALIMPLEMENTATION TRTFBox : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Comctrls::TRichEdit* RTFControl;
	Stdctrls::TButton* Ok;
	Stdctrls::TButton* Cancel;
	Comctrls::TToolBar* ToolBar1;
	Stdctrls::TComboBox* Fontname;
	Stdctrls::TComboBox* FontSize;
	Comctrls::TToolButton* BoldButton;
	Controls::TImageList* ImageList1;
	Comctrls::TToolButton* ItalicButton;
	Comctrls::TToolButton* UnderlineButton;
	Comctrls::TToolButton* LeftAlign;
	Comctrls::TToolButton* CenterAlign;
	Comctrls::TToolButton* RightAlign;
	Comctrls::TToolButton* BulletsButton;
	Comctrls::TToolButton* ToolButton1;
	Dialogs::TColorDialog* ColorDialog1;
	Comctrls::TToolButton* Superscript;
	Comctrls::TToolButton* Subscript;
	Comctrls::TToolButton* ToolButton2;
	Comctrls::TToolButton* ToolButton3;
	void __fastcall BoldButtonClick(System::TObject* Sender);
	void __fastcall RTFControlSelectionChange(System::TObject* Sender);
	void __fastcall ItalicButtonClick(System::TObject* Sender);
	void __fastcall UnderlineButtonClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FontnameChange(System::TObject* Sender);
	void __fastcall FontSizeChange(System::TObject* Sender);
	void __fastcall LeftAlignClick(System::TObject* Sender);
	void __fastcall BulletsButtonClick(System::TObject* Sender);
	void __fastcall ToolButton1Click(System::TObject* Sender);
	void __fastcall SuperscriptClick(System::TObject* Sender);
	void __fastcall SubscriptClick(System::TObject* Sender);
	void __fastcall ToolButton2Click(System::TObject* Sender);
	void __fastcall ToolButton3Click(System::TObject* Sender);
	void __fastcall RTFControlKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall RTFControlKeyPress(System::TObject* Sender, System::WideChar &Key);
	
private:
	bool italic_flag;
	void __fastcall GetFontNames(void);
	int __fastcall GetOffset(void);
	void __fastcall SetOffset(int offset);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TRTFBox(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRTFBox(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRTFBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TRTFBox(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TRTFBox* RTFBox;

}	/* namespace Frtfbox */
using namespace Frtfbox;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrtfboxHPP
