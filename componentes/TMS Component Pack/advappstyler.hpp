// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advappstyler.pas' rev: 21.00

#ifndef AdvappstylerHPP
#define AdvappstylerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advappstyler
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TThemeNotifierWindow;
class PASCALIMPLEMENTATION TThemeNotifierWindow : public Controls::TWinControl
{
	typedef Controls::TWinControl inherited;
	
private:
	Classes::TNotifyEvent FOnThemeChange;
	
protected:
	virtual void __fastcall WndProc(Messages::TMessage &Msg);
	
__published:
	__property Classes::TNotifyEvent OnThemeChange = {read=FOnThemeChange, write=FOnThemeChange};
public:
	/* TWinControl.Create */ inline __fastcall virtual TThemeNotifierWindow(Classes::TComponent* AOwner) : Controls::TWinControl(AOwner) { }
	/* TWinControl.CreateParented */ inline __fastcall TThemeNotifierWindow(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TThemeNotifierWindow(void) { }
	
};


class DELPHICLASS TAdvAppStyler;
class DELPHICLASS TAdvFormStyler;
class PASCALIMPLEMENTATION TAdvAppStyler : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
public:
	Classes::TList* FForms;
	Advstyleif::TTMSStyle FStyle;
	bool FAutoThemeAdapt;
	TThemeNotifierWindow* FNotifier;
	Classes::TNotifyEvent FOnChange;
	
private:
	void __fastcall SetStyle(const Advstyleif::TTMSStyle Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall ThemeChanged(System::TObject* Sender);
	void __fastcall SetAutoThemeAdapt(const bool Value);
	
protected:
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TAdvAppStyler(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvAppStyler(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall RegisterFormStyler(TAdvFormStyler* AFormStyler);
	void __fastcall UnRegisterFormStyler(TAdvFormStyler* AFormStyler);
	int __fastcall GetVersionNr(void);
	
__published:
	__property bool AutoThemeAdapt = {read=FAutoThemeAdapt, write=SetAutoThemeAdapt, default=0};
	__property Advstyleif::TTMSStyle Style = {read=FStyle, write=SetStyle, default=8};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion, stored=false};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


typedef void __fastcall (__closure *TApplyStyleEvent)(System::TObject* Sender, Classes::TComponent* AComponent, bool &Allow);

class PASCALIMPLEMENTATION TAdvFormStyler : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Advstyleif::TTMSStyle FStyle;
	TAdvAppStyler* FAppStyle;
	Classes::TNotifyEvent FOnChange;
	bool FAutoThemeAdapt;
	TThemeNotifierWindow* FNotifier;
	TApplyStyleEvent FOnApplyStyle;
	void __fastcall SetStyle(const Advstyleif::TTMSStyle Value);
	void __fastcall SetAppStyle(const TAdvAppStyler* Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall ThemeChanged(System::TObject* Sender);
	void __fastcall SetAutoThemeAdapt(const bool Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	
public:
	virtual void __fastcall Loaded(void);
	__fastcall virtual TAdvFormStyler(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvFormStyler(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall ApplyStyle(void);
	void __fastcall ApplyStyleToForm(Forms::TCustomForm* Form, Advstyleif::TTMSStyle AStyle);
	void __fastcall ApplyStyleToFrame(Forms::TCustomFrame* Frame, Advstyleif::TTMSStyle AStyle);
	int __fastcall GetVersionNr(void);
	Classes::TStringList* __fastcall GetStyles(void);
	
__published:
	__property bool AutoThemeAdapt = {read=FAutoThemeAdapt, write=SetAutoThemeAdapt, default=0};
	__property Advstyleif::TTMSStyle Style = {read=FStyle, write=SetStyle, default=8};
	__property TAdvAppStyler* AppStyle = {read=FAppStyle, write=SetAppStyle};
	__property TApplyStyleEvent OnApplyStyle = {read=FOnApplyStyle, write=FOnApplyStyle};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion, stored=false};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x2;
static const ShortInt REL_VER = 0x2;
static const ShortInt BLD_VER = 0x0;
extern PACKAGE void __fastcall Register(void);

}	/* namespace Advappstyler */
using namespace Advappstyler;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvappstylerHPP
