// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtpdfengdlg.pas' rev: 21.00

#ifndef GtpdfengdlgHPP
#define GtpdfengdlgHPP

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
#include <Gtpdfcrypt.hpp>	// Pascal unit
#include <Gtplndlg.hpp>	// Pascal unit
#include <Gtdocdlg.hpp>	// Pascal unit
#include <Gtdocresstrs.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit
#include <Gtcstpdfeng.hpp>	// Pascal unit
#include <Gtdocconsts.hpp>	// Pascal unit
#include <Gtexpdfeng.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtpdfengdlg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TgtPDFEngineDlg;
class PASCALIMPLEMENTATION TgtPDFEngineDlg : public Gtplndlg::TgtPlainSheetDlg
{
	typedef Gtplndlg::TgtPlainSheetDlg inherited;
	
__published:
	Comctrls::TTabSheet* tsPDFAdvanced;
	Stdctrls::TGroupBox* gbPDFOptions;
	Stdctrls::TLabel* lblFontEncoding;
	Stdctrls::TGroupBox* gbEncryption;
	Stdctrls::TLabel* lblOwnerPassword;
	Stdctrls::TLabel* lblConfirmOwnerPassword;
	Stdctrls::TLabel* lblUserPassword;
	Stdctrls::TLabel* lblConfirmUserPassword;
	Stdctrls::TEdit* edOwnerPassword;
	Stdctrls::TEdit* edConfirmOwnerPassword;
	Stdctrls::TGroupBox* gbUserPermissions;
	Stdctrls::TCheckBox* chkPrint;
	Stdctrls::TCheckBox* chkModify;
	Stdctrls::TCheckBox* chkCopy;
	Stdctrls::TEdit* edUserPassword;
	Stdctrls::TEdit* edConfirmUserPassword;
	Stdctrls::TGroupBox* gbUseCompression;
	Stdctrls::TLabel* lblCompressionLevel;
	Stdctrls::TComboBox* cbCompressionLevel;
	Stdctrls::TCheckBox* chkCompressDocument;
	Stdctrls::TComboBox* cbEncoding;
	Stdctrls::TCheckBox* chkEnableEncryption;
	Comctrls::TTabSheet* tsViewerPreferences;
	Stdctrls::TGroupBox* gbViewerPreferences;
	Stdctrls::TLabel* lblPageLayout;
	Stdctrls::TLabel* lblPageMode;
	Stdctrls::TComboBox* cbPageLayout;
	Stdctrls::TComboBox* cbPageMode;
	Stdctrls::TGroupBox* gbHideUIElements;
	Stdctrls::TCheckBox* chkMenuBar;
	Stdctrls::TCheckBox* chkToolBar;
	Stdctrls::TCheckBox* chkNavigationControls;
	Stdctrls::TGroupBox* gbPresentationMode;
	Stdctrls::TLabel* lblPageTransitionEffect;
	Stdctrls::TLabel* lblPageTransitionDuration;
	Stdctrls::TLabel* lblSecs;
	Stdctrls::TEdit* edPageTransitionDuration;
	Stdctrls::TComboBox* cbPageTransitionEffect;
	Stdctrls::TLabel* lblEncryptionLevel;
	Stdctrls::TComboBox* cbEncryptionLevel;
	Stdctrls::TCheckBox* chkAnnotation;
	Stdctrls::TCheckBox* chkFormFill;
	Stdctrls::TCheckBox* chkAccessibility;
	Stdctrls::TCheckBox* chkDocumentAssembly;
	Stdctrls::TCheckBox* chkHighResolutionPrint;
	Extctrls::TRadioGroup* rgpEmbedTrueTypeFonts;
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall edConfirmPasswordExit(System::TObject* Sender);
	void __fastcall chkEnableEncryptionClick(System::TObject* Sender);
	void __fastcall cbPageTransitionEffectChange(System::TObject* Sender);
	void __fastcall cbEncryptionLevelChange(System::TObject* Sender);
	void __fastcall chkCompressDocumentClick(System::TObject* Sender);
	HIDESBASE void __fastcall btnOKClick(System::TObject* Sender);
	
protected:
	virtual void __fastcall Localize(void);
public:
	/* TgtBaseDlg.Create */ inline __fastcall virtual TgtPDFEngineDlg(Classes::TComponent* AOwner) : Gtplndlg::TgtPlainSheetDlg(AOwner) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TgtPDFEngineDlg(Classes::TComponent* AOwner, int Dummy) : Gtplndlg::TgtPlainSheetDlg(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TgtPDFEngineDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TgtPDFEngineDlg(HWND ParentWindow) : Gtplndlg::TgtPlainSheetDlg(ParentWindow) { }
	
};


typedef StaticArray<System::UnicodeString, 3> Gtpdfengdlg__2;

typedef StaticArray<System::UnicodeString, 3> Gtpdfengdlg__3;

typedef StaticArray<System::UnicodeString, 4> Gtpdfengdlg__4;

typedef StaticArray<System::UnicodeString, 4> Gtpdfengdlg__5;

typedef StaticArray<System::UnicodeString, 17> Gtpdfengdlg__6;

typedef StaticArray<System::UnicodeString, 2> Gtpdfengdlg__7;

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Gtpdfengdlg__2 TTFontEmbedding;
extern PACKAGE Gtpdfengdlg__3 CompressionMethods;
extern PACKAGE Gtpdfengdlg__4 PDFPageLayout;
extern PACKAGE Gtpdfengdlg__5 PDFPageMode;
extern PACKAGE Gtpdfengdlg__6 PDFTransitionEffects;
extern PACKAGE Gtpdfengdlg__7 PDFEncryptionLevel;

}	/* namespace Gtpdfengdlg */
using namespace Gtpdfengdlg;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GtpdfengdlgHPP
