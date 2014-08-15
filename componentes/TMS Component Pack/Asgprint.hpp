// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Asgprint.pas' rev: 21.00

#ifndef AsgprintHPP
#define AsgprintHPP

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
#include <Comctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Advgrid.hpp>	// Pascal unit
#include <Printers.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Advspin.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Asgprint
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvGridPrintSettingsForm;
class PASCALIMPLEMENTATION TAdvGridPrintSettingsForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Extctrls::TPanel* PreviewPanel;
	Comctrls::TPageControl* PageControl;
	Comctrls::TTabSheet* GeneralTabSheet;
	Comctrls::TTabSheet* HeadersTabSheet;
	Extctrls::TPanel* ButtonPanel;
	Buttons::TBitBtn* OKButton;
	Buttons::TBitBtn* CancelButton;
	Stdctrls::TGroupBox* BordersGroupBox;
	Stdctrls::TLabel* BorderLabel;
	Stdctrls::TComboBox* BorderComboBox;
	Stdctrls::TLabel* BorderStyleLabel;
	Stdctrls::TComboBox* BorderStyleComboBox;
	Dialogs::TFontDialog* FontDialog;
	Extctrls::TPaintBox* PreviewPaintBox;
	Stdctrls::TGroupBox* GeneralGroupBox;
	Stdctrls::TLabel* FitToPageLabel;
	Stdctrls::TComboBox* FitToPageComboBox;
	Stdctrls::TCheckBox* AutoSizeCheckBox;
	Stdctrls::TCheckBox* CenterCheckBox;
	Stdctrls::TCheckBox* RepeatRowsCheckBox;
	Stdctrls::TCheckBox* RepeatColumnsCheckBox;
	Stdctrls::TGroupBox* DateTimeGroupBox;
	Stdctrls::TLabel* DatePositionLabel;
	Stdctrls::TLabel* TimePositionLabel;
	Stdctrls::TLabel* DateFormatLabel;
	Stdctrls::TEdit* DateFormatEdit;
	Stdctrls::TComboBox* DatePositionComboBox;
	Stdctrls::TComboBox* TimePositionComboBox;
	Stdctrls::TGroupBox* TitleGroupBox;
	Stdctrls::TMemo* TitleMemo;
	Stdctrls::TLabel* TitleTextLabel;
	Stdctrls::TLabel* TitlePositionLabel;
	Stdctrls::TComboBox* TitlePositionComboBox;
	Stdctrls::TGroupBox* PageNumbersGroupBox;
	Stdctrls::TEdit* PagesPrefixEdit;
	Stdctrls::TLabel* PagesPrefixLabel;
	Stdctrls::TLabel* PagesSeparatorLabel;
	Stdctrls::TLabel* PagesSuffixLabel;
	Stdctrls::TEdit* PagesSeparatorEdit;
	Stdctrls::TEdit* PagesSuffixEdit;
	Stdctrls::TLabel* PagesPositionLabel;
	Stdctrls::TComboBox* PagesPositionComboBox;
	Comctrls::TTabSheet* MarginsTabSheet;
	Stdctrls::TGroupBox* MarginsGroupBox;
	Stdctrls::TLabel* TopMarginLabel;
	Stdctrls::TLabel* LeftMarginLabel;
	Advspin::TAdvSpinEdit* TopMarginSpinEdit;
	Advspin::TAdvSpinEdit* LeftMarginSpinEdit;
	Stdctrls::TLabel* RightMarginLabel;
	Advspin::TAdvSpinEdit* RightMarginSpinEdit;
	Advspin::TAdvSpinEdit* BottomMarginSpinEdit;
	Stdctrls::TLabel* BottomMarginLabel;
	Stdctrls::TGroupBox* OrientationGroupBox;
	Stdctrls::TLabel* OrientationLabel;
	Stdctrls::TComboBox* OrientationComboBox;
	Stdctrls::TGroupBox* SpacingGroupBox;
	Stdctrls::TLabel* RowSpacingLabel;
	Stdctrls::TLabel* ColumnSpacingLabel;
	Advspin::TAdvSpinEdit* RowSpacingSpinEdit;
	Advspin::TAdvSpinEdit* ColumnSpacingSpinEdit;
	Stdctrls::TGroupBox* FontGroupBox;
	Buttons::TSpeedButton* HeaderFontButton;
	Buttons::TSpeedButton* FooterFontButton;
	Buttons::TSpeedButton* TableFontButton;
	Stdctrls::TLabel* TitleMarginLabel;
	Advspin::TAdvSpinEdit* TitleMarginSpinEdit;
	Stdctrls::TCheckBox* printgraphicscheckbox;
	Stdctrls::TLabel* dim1;
	Stdctrls::TLabel* dim2;
	Stdctrls::TLabel* dim3;
	Stdctrls::TLabel* dim4;
	Stdctrls::TLabel* dim5;
	Stdctrls::TLabel* dim6;
	Stdctrls::TLabel* dim7;
	Stdctrls::TRadioButton* dimr1;
	Stdctrls::TRadioButton* dimr2;
	Comctrls::TTabSheet* TabSheet1;
	Stdctrls::TGroupBox* FileGroupBox;
	Buttons::TSpeedButton* LoadSettings;
	Buttons::TSpeedButton* SaveSettings;
	Dialogs::TOpenDialog* OpenDialog1;
	Dialogs::TSaveDialog* SaveDialog1;
	Stdctrls::TCheckBox* AutoSizeRowCheck;
	Buttons::TSpeedButton* SpeedButton1;
	Stdctrls::TCheckBox* DisplFont;
	void __fastcall UpdatePreviewer(void);
	void __fastcall UpdateControls(void);
	void __fastcall UpdateDimensions(void);
	void __fastcall BorderStyleComboBoxChange(System::TObject* Sender);
	void __fastcall RowSpacingSpinEditChange(System::TObject* Sender);
	void __fastcall TableFontButtonClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FooterFontButtonClick(System::TObject* Sender);
	void __fastcall HeaderFontButtonClick(System::TObject* Sender);
	void __fastcall BorderComboBoxChange(System::TObject* Sender);
	void __fastcall DatePositionComboBoxChange(System::TObject* Sender);
	void __fastcall TitlePositionComboBoxChange(System::TObject* Sender);
	void __fastcall PagesPositionComboBoxChange(System::TObject* Sender);
	void __fastcall PreviewPaintBoxPaint(System::TObject* Sender);
	void __fastcall OrientationComboBoxChange(System::TObject* Sender);
	void __fastcall dimr1Click(System::TObject* Sender);
	void __fastcall dimr2Click(System::TObject* Sender);
	void __fastcall LoadSettingsClick(System::TObject* Sender);
	void __fastcall SaveSettingsClick(System::TObject* Sender);
	void __fastcall AutoSizeRowCheckClick(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall DisplFontClick(System::TObject* Sender);
	
private:
	void __fastcall ClearPreviewer(void);
	
public:
	bool Loading;
	bool PrintPreview;
	bool Updating;
	System::UnicodeString IniFile;
	Advgrid::TAdvStringGrid* Grid;
	void __fastcall HideDisabledTabSheets(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAdvGridPrintSettingsForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAdvGridPrintSettingsForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAdvGridPrintSettingsForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvGridPrintSettingsForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


#pragma option push -b-
enum TPrintSettingsOption { psBorders, psGeneral, psFonts, psDateTime, psTitle, psPages, psMargins, psSpacing, psOrientation, psSaveSettings };
#pragma option pop

typedef Set<TPrintSettingsOption, psBorders, psSaveSettings>  TPrintSettingsOptions;

#pragma option push -b-
enum TPrintDimensions { pdmm, pdinch };
#pragma option pop

class DELPHICLASS TAdvGridPrintSettingsDialog;
class PASCALIMPLEMENTATION TAdvGridPrintSettingsDialog : public Dialogs::TCommonDialog
{
	typedef Dialogs::TCommonDialog inherited;
	
private:
	TAdvGridPrintSettingsForm* FForm;
	Advgrid::TAdvStringGrid* FGrid;
	TPrintSettingsOptions FOptions;
	bool FPrintPreview;
	TPrintDimensions FPrintDimensions;
	bool FExecuting;
	System::UnicodeString FIniFile;
	System::UnicodeString FCaption;
	void __fastcall SetPrintDimensions(const TPrintDimensions Value);
	void __fastcall SetGrid(const Advgrid::TAdvStringGrid* Value);
	
protected:
	void __fastcall SetOptions(TPrintSettingsOptions AOptions);
	void __fastcall SetPrintPreview(bool Value);
	void __fastcall EnableGroupBox(Stdctrls::TGroupBox* AGroupBox, bool Enable);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	
public:
	__fastcall virtual TAdvGridPrintSettingsDialog(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvGridPrintSettingsDialog(void);
	virtual bool __fastcall Execute(void)/* overload */;
	__property TAdvGridPrintSettingsForm* Form = {read=FForm};
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
	__property Advgrid::TAdvStringGrid* Grid = {read=FGrid, write=SetGrid};
	__property TPrintSettingsOptions Options = {read=FOptions, write=SetOptions, nodefault};
	__property bool PrintPreview = {read=FPrintPreview, write=SetPrintPreview, nodefault};
	__property TPrintDimensions PrintDimensions = {read=FPrintDimensions, write=SetPrintDimensions, nodefault};
	__property System::UnicodeString IniFile = {read=FIniFile, write=FIniFile};
	
/* Hoisted overloads: */
	
public:
	inline bool __fastcall  Execute(HWND ParentWnd){ return Dialogs::TCommonDialog::Execute(ParentWnd); }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Asgprint */
using namespace Asgprint;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AsgprintHPP
