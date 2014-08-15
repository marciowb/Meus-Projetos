// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advquerydialog.pas' rev: 21.00

#ifndef AdvquerydialogHPP
#define AdvquerydialogHPP

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
#include <Advedit.hpp>	// Pascal unit
#include <Consts.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advquerydialog
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvQueryDialog;
class PASCALIMPLEMENTATION TAdvQueryDialog : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	System::UnicodeString FCaption;
	System::UnicodeString FPrompt;
	Advedit::TAdvEditType FEditType;
	int FPrecision;
	System::UnicodeString FSuffix;
	System::UnicodeString FPrefix;
	bool FFlat;
	System::UnicodeString FText;
	int FLengthLimit;
	bool FCanUndo;
	bool FShowModified;
	bool FShowURL;
	Graphics::TColor FModifiedColor;
	System::WideChar FPasswordChar;
	Advedit::TEditAlign FEditAlign;
	bool FSigned;
	Graphics::TColor FFlatLineColor;
	bool FFlatParentColor;
	bool FExcelStyleDecimalSeparator;
	bool FShowHint;
	System::UnicodeString FHint;
	int FDialogUnitWidth;
	Graphics::TColor FDialogColor;
	System::UnicodeString FValidChars;
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	
public:
	Controls::TModalResult __fastcall ShowModal(void);
	__fastcall virtual TAdvQueryDialog(Classes::TComponent* AOwner);
	
__published:
	__property bool CanUndo = {read=FCanUndo, write=FCanUndo, nodefault};
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
	__property int DialogUnitWidth = {read=FDialogUnitWidth, write=FDialogUnitWidth, default=180};
	__property Graphics::TColor DialogColor = {read=FDialogColor, write=FDialogColor, default=536870911};
	__property Advedit::TEditAlign EditAlign = {read=FEditAlign, write=FEditAlign, nodefault};
	__property Advedit::TAdvEditType EditType = {read=FEditType, write=FEditType, nodefault};
	__property bool ExcelStyleDecimalSeparator = {read=FExcelStyleDecimalSeparator, write=FExcelStyleDecimalSeparator, nodefault};
	__property bool Flat = {read=FFlat, write=FFlat, default=0};
	__property Graphics::TColor FlatLineColor = {read=FFlatLineColor, write=FFlatLineColor, nodefault};
	__property bool FlatParentColor = {read=FFlatParentColor, write=FFlatParentColor, nodefault};
	__property System::UnicodeString Hint = {read=FHint, write=FHint};
	__property int LengthLimit = {read=FLengthLimit, write=FLengthLimit, nodefault};
	__property Graphics::TColor ModifiedColor = {read=FModifiedColor, write=FModifiedColor, nodefault};
	__property System::WideChar PasswordChar = {read=FPasswordChar, write=FPasswordChar, nodefault};
	__property int Precision = {read=FPrecision, write=FPrecision, nodefault};
	__property System::UnicodeString Prefix = {read=FPrefix, write=FPrefix};
	__property System::UnicodeString Prompt = {read=FPrompt, write=FPrompt};
	__property bool ShowHint = {read=FShowHint, write=FShowHint, nodefault};
	__property bool ShowModified = {read=FShowModified, write=FShowModified, default=0};
	__property bool ShowURL = {read=FShowURL, write=FShowURL, default=0};
	__property bool Signed = {read=FSigned, write=FSigned, default=0};
	__property System::UnicodeString Suffix = {read=FSuffix, write=FSuffix};
	__property System::UnicodeString Text = {read=FText, write=FText};
	__property System::UnicodeString ValidChars = {read=FValidChars, write=FValidChars};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TAdvQueryDialog(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x2;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advquerydialog */
using namespace Advquerydialog;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvquerydialogHPP
