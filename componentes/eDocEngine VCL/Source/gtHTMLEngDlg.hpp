// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gthtmlengdlg.pas' rev: 10.00

#ifndef GthtmlengdlgHPP
#define GthtmlengdlgHPP

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
#include <Extdlgs.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Gtdocdlg.hpp>	// Pascal unit
#include <Gtplndlg.hpp>	// Pascal unit
#include <Gtdocresstrs.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit
#include <Gtcsthtmleng.hpp>	// Pascal unit
#include <Gtutils.hpp>	// Pascal unit
#include <Gtexhtmleng.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gthtmlengdlg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TgtHTMLEngineDlg;
class PASCALIMPLEMENTATION TgtHTMLEngineDlg : public Gtplndlg::TgtPlainSheetDlg 
{
	typedef Gtplndlg::TgtPlainSheetDlg inherited;
	
__published:
	Stdctrls::TCheckBox* chkAutoScrollDocument;
	Comctrls::TTabSheet* tsFileLocationAndOptimization;
	Stdctrls::TGroupBox* gbOthers;
	Stdctrls::TCheckBox* chkOptimizeforIE;
	Stdctrls::TGroupBox* gbExtCSSFile;
	Stdctrls::TLabel* lblCSSFile;
	Buttons::TSpeedButton* sbtnCSSFileName;
	Stdctrls::TEdit* edCSSFile;
	Stdctrls::TCheckBox* chkOutputStylesToCSSFile;
	Stdctrls::TCheckBox* chkPageEndLines;
	Stdctrls::TGroupBox* gbOuputJSFile;
	Stdctrls::TLabel* lblJSFile;
	Buttons::TSpeedButton* sbtnJSFileName;
	Stdctrls::TEdit* edJSFileName;
	Stdctrls::TCheckBox* chkOutputScriptsToJSFile;
	Comctrls::TTabSheet* tsNavigatorOptions;
	Stdctrls::TGroupBox* gbShowNavigator;
	Stdctrls::TLabel* lblNavigatorBackgroundColor;
	Stdctrls::TLabel* lblHoverForeColor;
	Stdctrls::TLabel* lblHoverBackColor;
	Extctrls::TShape* shpNavigatorBackgroundColor;
	Extctrls::TShape* shpHoverForeColor;
	Extctrls::TShape* shpHoverBackColor;
	Stdctrls::TLabel* lblNavigatorType;
	Stdctrls::TLabel* lblNavigatorOrientation;
	Stdctrls::TLabel* lblNavigatorPosition;
	Stdctrls::TGroupBox* gbUseLinks;
	Comctrls::TPageControl* pcShowNavigator;
	Comctrls::TTabSheet* tsUseTextLinks;
	Stdctrls::TLabel* lblFirst;
	Stdctrls::TLabel* lblLast;
	Stdctrls::TLabel* lblNext;
	Stdctrls::TLabel* lblPrevious;
	Stdctrls::TLabel* lblLinkCaptions;
	Stdctrls::TButton* btnSetFont;
	Stdctrls::TEdit* edFirst;
	Stdctrls::TEdit* edPrevious;
	Stdctrls::TEdit* edNext;
	Stdctrls::TEdit* edLast;
	Comctrls::TTabSheet* tsUseGraphicLinks;
	Stdctrls::TLabel* lblUseGraphicLinksFirst;
	Stdctrls::TLabel* lblUseGraphicLinksPrevious;
	Stdctrls::TLabel* lblUseGraphicLinksNext;
	Stdctrls::TLabel* lblUseGraphicLinksLast;
	Buttons::TSpeedButton* sbtnFirst;
	Buttons::TSpeedButton* sbtnPrevious;
	Buttons::TSpeedButton* sbtnNext;
	Buttons::TSpeedButton* sbtnLast;
	Stdctrls::TLabel* lblImageSource;
	Stdctrls::TEdit* edUseGraphicLinksFirst;
	Stdctrls::TEdit* edUseGraphicLinksPrevious;
	Stdctrls::TEdit* edUseGraphicLinksLast;
	Stdctrls::TEdit* edUseGraphicLinksNext;
	Stdctrls::TRadioButton* rbtnUseTextLinks;
	Stdctrls::TRadioButton* rbtnUseGraphicLinks;
	Stdctrls::TComboBox* cbNavigatorType;
	Stdctrls::TComboBox* cbNavigatorOrientation;
	Stdctrls::TComboBox* cbNavigatorPosition;
	Stdctrls::TCheckBox* chkShowNavigator;
	Stdctrls::TCheckBox* chkSingleFile;
	Dialogs::TFontDialog* FontDialog;
	Dialogs::TOpenDialog* OpenDialog;
	Comctrls::TTabSheet* tsTOCPageSettings;
	Stdctrls::TGroupBox* gbTOCPageSettings;
	Stdctrls::TLabel* lblItemFont;
	Extctrls::TPanel* pnlTOCItemFont;
	Buttons::TSpeedButton* sbtnTOCItemFont;
	Stdctrls::TLabel* lblTOCTitle;
	Stdctrls::TLabel* lblAlignment;
	Stdctrls::TEdit* edTOCTitle;
	Stdctrls::TComboBox* cbAlignment;
	Stdctrls::TLabel* lblTitleFont;
	Extctrls::TPanel* pnlTOCTitleFont;
	Buttons::TSpeedButton* sbtnTOCTitleFont;
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall chkSingleFileClick(System::TObject* Sender);
	void __fastcall chkShowNavigatorClick(System::TObject* Sender);
	void __fastcall rbtnUseLinksClick(System::TObject* Sender);
	void __fastcall sbtnCSSFileNameClick(System::TObject* Sender);
	void __fastcall sbtnJSFileNameClick(System::TObject* Sender);
	void __fastcall sbtnSetFontClick(System::TObject* Sender);
	void __fastcall btnImageSourceClick(System::TObject* Sender);
	void __fastcall chkOutputStylesToCSSFileClick(System::TObject* Sender);
	void __fastcall chkOutputScriptsToJSFileClick(System::TObject* Sender);
	void __fastcall btnSetFontClick(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	HIDESBASE void __fastcall btnOKClick(System::TObject* Sender);
	void __fastcall shpNavigatorColorMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall shpNavigatorColorMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	
private:
	Graphics::TFont* FLinkFont;
	#pragma pack(push,1)
	Types::TPoint HTMLMousePoint;
	#pragma pack(pop)
	
protected:
	virtual void __fastcall Localize(void);
public:
	#pragma option push -w-inl
	/* TgtBaseDlg.Create */ inline __fastcall virtual TgtHTMLEngineDlg(Classes::TComponent* AOwner) : Gtplndlg::TgtPlainSheetDlg(AOwner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TgtHTMLEngineDlg(Classes::TComponent* AOwner, int Dummy) : Gtplndlg::TgtPlainSheetDlg(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TgtHTMLEngineDlg(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TgtHTMLEngineDlg(HWND ParentWindow) : Gtplndlg::TgtPlainSheetDlg(ParentWindow) { }
	#pragma option pop
	
};


typedef AnsiString gtHTMLEngDlg__2[2];

typedef AnsiString gtHTMLEngDlg__3[2];

typedef AnsiString gtHTMLEngDlg__4[9];

typedef AnsiString gtHTMLEngDlg__5[5];

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE AnsiString NavigatorType[2];
extern PACKAGE AnsiString NavigatorOrientation[2];
extern PACKAGE AnsiString NavigatorPosition[9];
extern PACKAGE AnsiString HAlignment[5];

}	/* namespace Gthtmlengdlg */
using namespace Gthtmlengdlg;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Gthtmlengdlg
