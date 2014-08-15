// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Asghtml.pas' rev: 21.00

#ifndef AsghtmlHPP
#define AsghtmlHPP

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
#include <Advspin.hpp>	// Pascal unit
#include <Advgrid.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Shellapi.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Asghtml
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvGridHTMLSettingsForm;
class PASCALIMPLEMENTATION TAdvGridHTMLSettingsForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TGroupBox* CellsGroupBox;
	Stdctrls::TLabel* BorderSizeLabel;
	Stdctrls::TLabel* CellSpacingLabel;
	Stdctrls::TGroupBox* TagsGroupBox;
	Stdctrls::TLabel* PrefixLabel;
	Stdctrls::TLabel* SuffixLabel;
	Stdctrls::TLabel* TableStyleLabel;
	Stdctrls::TGroupBox* FilesGroupBox;
	Stdctrls::TLabel* HeaderLabel;
	Stdctrls::TLabel* FooterLabel;
	Stdctrls::TGroupBox* GeneralGroupBox;
	Stdctrls::TCheckBox* TableColorsCheckBox;
	Stdctrls::TCheckBox* TableFontsCheckBox;
	Stdctrls::TLabel* TableWidthLabel;
	Advspin::TAdvSpinEdit* BorderSizeSpinEdit;
	Advspin::TAdvSpinEdit* CellSpacingSpinEdit;
	Stdctrls::TEdit* PrefixEdit;
	Stdctrls::TEdit* SuffixEdit;
	Stdctrls::TEdit* TableStyleEdit;
	Stdctrls::TEdit* HeaderEdit;
	Stdctrls::TEdit* FooterEdit;
	Stdctrls::TButton* HeaderButton;
	Stdctrls::TButton* FooterButton;
	Advspin::TAdvSpinEdit* TableWidthSpinEdit;
	Buttons::TBitBtn* OKButton;
	Buttons::TBitBtn* CancelButton;
	Dialogs::TOpenDialog* OpenDialog;
	Stdctrls::TButton* Preview;
	Stdctrls::TLabel* Label1;
	Advspin::TAdvSpinEdit* CellPaddingSpinEdit;
	Stdctrls::TCheckBox* ConvertChar;
	Stdctrls::TCheckBox* ExportNonBreaking;
	Stdctrls::TCheckBox* AutoShow;
	void __fastcall UpdateControls(void);
	void __fastcall UpdateSettings(void);
	void __fastcall HeaderButtonClick(System::TObject* Sender);
	void __fastcall PreviewClick(System::TObject* Sender);
	
public:
	Advgrid::TAdvStringGrid* Grid;
	void __fastcall EnableGroupBox(Stdctrls::TGroupBox* AGroupBox, bool Enable);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAdvGridHTMLSettingsForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAdvGridHTMLSettingsForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAdvGridHTMLSettingsForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvGridHTMLSettingsForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


#pragma option push -b-
enum TAdvGridHTMLOption { hoGeneral, hoCells, hoTags, hoFiles };
#pragma option pop

typedef Set<TAdvGridHTMLOption, hoGeneral, hoFiles>  TAdvGridHTMLOptions;

class DELPHICLASS TAdvGridHTMLSettingsDialog;
class PASCALIMPLEMENTATION TAdvGridHTMLSettingsDialog : public Dialogs::TCommonDialog
{
	typedef Dialogs::TCommonDialog inherited;
	
private:
	Advgrid::TAdvStringGrid* FGrid;
	TAdvGridHTMLSettingsForm* FForm;
	TAdvGridHTMLOptions FOptions;
	
protected:
	void __fastcall EnableGroupBoxes(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	
public:
	__fastcall virtual TAdvGridHTMLSettingsDialog(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvGridHTMLSettingsDialog(void);
	virtual bool __fastcall Execute(void)/* overload */;
	__property TAdvGridHTMLSettingsForm* Form = {read=FForm};
	
__published:
	__property Advgrid::TAdvStringGrid* Grid = {read=FGrid, write=FGrid};
	__property TAdvGridHTMLOptions Options = {read=FOptions, write=FOptions, nodefault};
	
/* Hoisted overloads: */
	
public:
	inline bool __fastcall  Execute(HWND ParentWnd){ return Dialogs::TCommonDialog::Execute(ParentWnd); }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Asghtml */
using namespace Asghtml;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AsghtmlHPP
