// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'DesignerAlignPalette.pas' rev: 22.00

#ifndef DesigneralignpaletteHPP
#define DesigneralignpaletteHPP

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
#include <Buttons.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Designeralignpalette
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrmAlignmentPalette;
class PASCALIMPLEMENTATION TfrmAlignmentPalette : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Buttons::TSpeedButton* sbtLeft;
	Buttons::TSpeedButton* sbtHorCenter;
	Buttons::TSpeedButton* sbtHorWinCenter;
	Buttons::TSpeedButton* sbtHorSpace;
	Buttons::TSpeedButton* sbtRight;
	Buttons::TSpeedButton* sbtTop;
	Buttons::TSpeedButton* sbtVerCenter;
	Buttons::TSpeedButton* sbtVerSpace;
	Buttons::TSpeedButton* sbtVerWinCenter;
	Buttons::TSpeedButton* sbtBottom;
	Menus::TPopupMenu* pmnMain;
	Menus::TMenuItem* mniStayOnTop;
	Menus::TMenuItem* mniShowHints;
	Menus::TMenuItem* mniHide;
	void __fastcall pmnMainPopup(System::TObject* Sender);
	void __fastcall mniStayOnTopClick(System::TObject* Sender);
	void __fastcall mniShowHintsClick(System::TObject* Sender);
	void __fastcall mniHideClick(System::TObject* Sender);
	void __fastcall sbtHorClick(System::TObject* Sender);
	void __fastcall sbtVerClick(System::TObject* Sender);
	
public:
	void __fastcall SetFlatButtons(bool AFlat);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmAlignmentPalette(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmAlignmentPalette(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmAlignmentPalette(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmAlignmentPalette(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Designeralignpalette */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Designeralignpalette;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DesigneralignpaletteHPP
