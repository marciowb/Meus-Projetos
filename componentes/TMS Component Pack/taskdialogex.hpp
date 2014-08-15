// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Taskdialogex.pas' rev: 21.00

#ifndef TaskdialogexHPP
#define TaskdialogexHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Consts.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Taskdialog.hpp>	// Pascal unit
#include <Advglowbutton.hpp>	// Pascal unit
#include <Advofficebuttons.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Taskdialogex
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TButtonCreatedEvent)(System::TObject* Sender, Advglowbutton::TAdvGlowButton* Button);

class DELPHICLASS TAdvTaskDialogEx;
class PASCALIMPLEMENTATION TAdvTaskDialogEx : public Taskdialog::TAdvTaskDialog
{
	typedef Taskdialog::TAdvTaskDialog inherited;
	
private:
	TButtonCreatedEvent FOnButtonCreated;
	Advglowbutton::TGlowButtonAppearance* FAppearance;
	
protected:
	virtual Controls::TWinControl* __fastcall CreateRadioButton(Classes::TComponent* AOwner);
	virtual void __fastcall SetRadioButtonState(Controls::TWinControl* Btn, bool Checked);
	virtual void __fastcall SetRadioButtonCaption(Controls::TWinControl* Btn, System::UnicodeString Value);
	virtual Controls::TWinControl* __fastcall CreateButton(Classes::TComponent* AOwner);
	virtual void __fastcall InitRadioButton(Forms::TForm* AOwner, Controls::TWinControl* Btn, int btnIndex, Classes::TNotifyEvent OnClickEvent);
	virtual void __fastcall SetButtonCaption(Controls::TWinControl* aButton, Controls::TCaption Value);
	virtual void __fastcall SetButtonCancel(Controls::TWinControl* aButton, bool Value);
	virtual void __fastcall SetButtonDefault(Controls::TWinControl* aButton, bool Value);
	virtual void __fastcall SetButtonModalResult(Controls::TWinControl* aButton, int Value);
	virtual int __fastcall GetButtonModalResult(Controls::TWinControl* aButton);
	
public:
	__property Advglowbutton::TGlowButtonAppearance* Appearance = {read=FAppearance, write=FAppearance};
	__property TButtonCreatedEvent OnButtonCreated = {read=FOnButtonCreated, write=FOnButtonCreated};
public:
	/* TCustomAdvTaskDialog.Create */ inline __fastcall virtual TAdvTaskDialogEx(Classes::TComponent* AOwner) : Taskdialog::TAdvTaskDialog(AOwner) { }
	/* TCustomAdvTaskDialog.Destroy */ inline __fastcall virtual ~TAdvTaskDialogEx(void) { }
	
};


class DELPHICLASS TAdvInputTaskDialogEx;
class PASCALIMPLEMENTATION TAdvInputTaskDialogEx : public Taskdialog::TAdvInputTaskDialog
{
	typedef Taskdialog::TAdvInputTaskDialog inherited;
	
private:
	TButtonCreatedEvent FOnButtonCreated;
	Advglowbutton::TGlowButtonAppearance* FAppearance;
	
protected:
	virtual Controls::TWinControl* __fastcall CreateRadioButton(Classes::TComponent* AOwner);
	virtual void __fastcall SetRadioButtonState(Controls::TWinControl* Btn, bool Checked);
	virtual void __fastcall SetRadioButtonCaption(Controls::TWinControl* Btn, System::UnicodeString Value);
	virtual Controls::TWinControl* __fastcall CreateButton(Classes::TComponent* AOwner);
	virtual void __fastcall InitRadioButton(Forms::TForm* AOwner, Controls::TWinControl* Btn, int btnIndex, Classes::TNotifyEvent OnClickEvent);
	virtual void __fastcall SetButtonCaption(Controls::TWinControl* aButton, Controls::TCaption Value);
	virtual void __fastcall SetButtonCancel(Controls::TWinControl* aButton, bool Value);
	virtual void __fastcall SetButtonDefault(Controls::TWinControl* aButton, bool Value);
	virtual void __fastcall SetButtonModalResult(Controls::TWinControl* aButton, int Value);
	virtual int __fastcall GetButtonModalResult(Controls::TWinControl* aButton);
	
public:
	__property Advglowbutton::TGlowButtonAppearance* Appearance = {read=FAppearance, write=FAppearance};
	__property TButtonCreatedEvent OnButtonCreated = {read=FOnButtonCreated, write=FOnButtonCreated};
public:
	/* TAdvInputTaskDialog.Create */ inline __fastcall virtual TAdvInputTaskDialogEx(Classes::TComponent* AOwner) : Taskdialog::TAdvInputTaskDialog(AOwner) { }
	
public:
	/* TCustomAdvTaskDialog.Destroy */ inline __fastcall virtual ~TAdvInputTaskDialogEx(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall Register(void);

}	/* namespace Taskdialogex */
using namespace Taskdialogex;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TaskdialogexHPP
