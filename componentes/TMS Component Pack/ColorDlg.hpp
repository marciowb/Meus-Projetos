// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Colordlg.pas' rev: 21.00

#ifndef ColordlgHPP
#define ColordlgHPP

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
#include <Extctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Colordlg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TColorChooser;
class PASCALIMPLEMENTATION TColorChooser : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TButton* Button1;
	Stdctrls::TButton* Button2;
	Extctrls::TPaintBox* PaintBox1;
	Stdctrls::TLabel* Label1;
	Stdctrls::TButton* Button3;
	Stdctrls::TCheckBox* CheckBox1;
	Stdctrls::TButton* Button4;
	Stdctrls::TButton* Button5;
	Dialogs::TColorDialog* ColorDialog1;
	Stdctrls::TCheckBox* CheckBox2;
	void __fastcall PaintBox1Paint(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall CheckBox1Click(System::TObject* Sender);
	void __fastcall PaintBox1MouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall CheckBox2Click(System::TObject* Sender);
	
private:
	bool FDirection;
	Graphics::TColor FColorFrom;
	Graphics::TColor FColorTo;
	Graphics::TColor FBorderColor;
	void __fastcall SetDirection(const bool AValue);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	
public:
	__property Graphics::TColor ColorFrom = {read=FColorFrom, write=FColorFrom, nodefault};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, nodefault};
	__property bool Direction = {read=FDirection, write=SetDirection, nodefault};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=FBorderColor, nodefault};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TColorChooser(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TColorChooser(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TColorChooser(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TColorChooser(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TColorChooser* ColorChooser;

}	/* namespace Colordlg */
using namespace Colordlg;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ColordlgHPP
