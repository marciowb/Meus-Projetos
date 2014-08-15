// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advcardlistgradient.pas' rev: 21.00

#ifndef AdvcardlistgradientHPP
#define AdvcardlistgradientHPP

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
#include <Buttons.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Advcardlist.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advcardlistgradient
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TGradientEditor;
class PASCALIMPLEMENTATION TGradientEditor : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Extctrls::TPaintBox* PaintBox1;
	Extctrls::TRadioGroup* RadioGroup1;
	Stdctrls::TButton* Button1;
	Stdctrls::TButton* Button2;
	Buttons::TSpeedButton* SpeedButton1;
	Buttons::TSpeedButton* SpeedButton2;
	Dialogs::TColorDialog* ColorDialog1;
	void __fastcall PaintBox1Paint(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall SpeedButton2Click(System::TObject* Sender);
	void __fastcall RadioGroup1Click(System::TObject* Sender);
	
private:
	Advcardlist::TAdvGradient* FColor;
	Graphics::TColor FOldColorTo;
	HIDESBASE void __fastcall SetColor(const Advcardlist::TAdvGradient* Value);
	
public:
	__fastcall virtual TGradientEditor(Classes::TComponent* Aowner);
	__fastcall virtual ~TGradientEditor(void);
	__property Advcardlist::TAdvGradient* Color = {read=FColor, write=SetColor};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TGradientEditor(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TGradientEditor(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TGradientEditor* GradientEditor;

}	/* namespace Advcardlistgradient */
using namespace Advcardlistgradient;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvcardlistgradientHPP
