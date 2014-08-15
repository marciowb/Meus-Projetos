// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsyskeyboardhook.pas' rev: 21.00

#ifndef AdvsyskeyboardhookHPP
#define AdvsyskeyboardhookHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsyskeyboardhook
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TAdvSysKeyEvent)(System::TObject* Sender, System::Word Key, Classes::TShiftState Shift, bool &Allow);

class DELPHICLASS TAdvSysKeyboardHook;
class PASCALIMPLEMENTATION TAdvSysKeyboardHook : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Stdctrls::TButton* Button1;
	Stdctrls::TButton* Button1B;
	TAdvSysKeyEvent FOnKeyDown;
	bool FBlockKeys;
	bool FDisableAltTab;
	bool FRegisterAltTab;
	int FAltTabHotKeyID;
	void __fastcall Button1KeyUp(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall Button1BMouseMove(System::TObject* Sender, Classes::TShiftState Shift, int X, int Y);
	bool __fastcall GetHooked(void);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetBlockKeys(const bool Value);
	void __fastcall SetDisableAltTab(const bool Value);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	void __fastcall InitKeyBoardHook(void);
	void __fastcall KillKeyBoardHook(void);
	
public:
	__fastcall virtual TAdvSysKeyboardHook(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSysKeyboardHook(void);
	int __fastcall GetVersionNr(void);
	__property bool Hooked = {read=GetHooked, nodefault};
	__property bool BlockKeys = {read=FBlockKeys, write=SetBlockKeys, default=0};
	__property bool DisableAltTab = {read=FDisableAltTab, write=SetDisableAltTab, default=0};
	
__published:
	__property TAdvSysKeyEvent OnKeyDown = {read=FOnKeyDown, write=FOnKeyDown};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion, stored=false};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x2;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advsyskeyboardhook */
using namespace Advsyskeyboardhook;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsyskeyboardhookHPP
