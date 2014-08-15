// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothcalculatordropdown.pas' rev: 21.00

#ifndef AdvsmoothcalculatordropdownHPP
#define AdvsmoothcalculatordropdownHPP

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
#include <Extctrls.hpp>	// Pascal unit
#include <Advsmootheditbutton.hpp>	// Pascal unit
#include <Advsmoothcalculator.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Advsmoothedit.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothcalculatordropdown
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvSmoothCalculatorDD;
class DELPHICLASS TAdvSmoothCalculatorDropDown;
class PASCALIMPLEMENTATION TAdvSmoothCalculatorDD : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothCalculatorDropDown* FOwner;
	int FWidth;
	int FHeight;
	Advsmoothcalculator::TCalculatorLook* FCalculatorLook;
	Advsmoothcalculator::TExtraButtons* FExtraButtons;
	short FPrecision;
	void __fastcall ExtraButtonsChanged(System::TObject* Sender);
	void __fastcall CalculatorLookChanged(System::TObject* Sender);
	void __fastcall SetPrecision(const short Value);
	
protected:
	void __fastcall Update(void);
	
public:
	__fastcall TAdvSmoothCalculatorDD(TAdvSmoothCalculatorDropDown* AOwner);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__fastcall virtual ~TAdvSmoothCalculatorDD(void);
	
__published:
	__property short Precision = {read=FPrecision, write=SetPrecision, nodefault};
	__property Advsmoothcalculator::TCalculatorLook* CalculatorLook = {read=FCalculatorLook, write=FCalculatorLook};
	__property Advsmoothcalculator::TExtraButtons* ExtraButtons = {read=FExtraButtons, write=FExtraButtons};
	__property int Width = {read=FWidth, write=FWidth, nodefault};
	__property int Height = {read=FHeight, write=FHeight, nodefault};
};


class PASCALIMPLEMENTATION TAdvSmoothCalculatorDropDown : public Advsmootheditbutton::TAdvSmoothEditBtn
{
	typedef Advsmootheditbutton::TAdvSmoothEditBtn inherited;
	
private:
	Extctrls::TTimer* FTimer;
	bool FDesignTime;
	Advsmoothcalculator::TAdvSmoothCalculator* FCalc;
	bool FDeactivating;
	bool FIgnoreSelect;
	Forms::TForm* CalcParent;
	bool CancelThisBtnClick;
	bool FHideCalculatorAfterSelection;
	TAdvSmoothCalculatorDD* FCalculator;
	Advsmoothcalculator::TExtraButtonClickEvent fOnExtraButtonClick;
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	void __fastcall HideParent(void);
	void __fastcall InitEvents(void);
	Controls::TWinControl* __fastcall GetParentEx(void);
	void __fastcall SetParentEx(const Controls::TWinControl* Value);
	void __fastcall SetCalculator(const TAdvSmoothCalculatorDD* Value);
	
protected:
	void __fastcall ValueChanged(System::TObject* Sender);
	virtual bool __fastcall IsDropDownVisible(void);
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall BtnClick(System::TObject* Sender);
	void __fastcall CalcParentDeactivate(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall CreateWnd(void);
	void __fastcall TimerEvent(System::TObject* Sender);
	__property Advsmoothcalculator::TAdvSmoothCalculator* Calc = {read=FCalc, write=FCalc};
	void __fastcall CalcValueChanged(System::TObject* Sender, double Value);
	void __fastcall ExtraButtonClick(System::TObject* Sender, int idx, System::Extended &value);
	
public:
	__fastcall virtual TAdvSmoothCalculatorDropDown(Classes::TComponent* AOwner);
	void __fastcall CancelBtnClick(void);
	__fastcall virtual ~TAdvSmoothCalculatorDropDown(void);
	virtual void __fastcall DropDown(void);
	__property Controls::TWinControl* Parent = {read=GetParentEx, write=SetParentEx};
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	void __fastcall SaveToTheme(System::UnicodeString FileName);
	void __fastcall LoadFromTheme(System::UnicodeString FileName);
	System::UnicodeString __fastcall GetThemeID(void);
	
__published:
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property bool HideCalculatorAfterSelection = {read=FHideCalculatorAfterSelection, write=FHideCalculatorAfterSelection, nodefault};
	__property TAdvSmoothCalculatorDD* Calculator = {read=FCalculator, write=SetCalculator};
	__property Advsmoothcalculator::TExtraButtonClickEvent OnExtraButtonClick = {read=fOnExtraButtonClick, write=fOnExtraButtonClick};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothCalculatorDropDown(HWND ParentWindow) : Advsmootheditbutton::TAdvSmoothEditBtn(ParentWindow) { }
	
private:
	void *__ITMSStyle;	/* Advstyleif::ITMSStyle */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Advstyleif::_di_ITMSStyle()
	{
		Advstyleif::_di_ITMSStyle intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator ITMSStyle*(void) { return (ITMSStyle*)&__ITMSStyle; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x2;

}	/* namespace Advsmoothcalculatordropdown */
using namespace Advsmoothcalculatordropdown;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothcalculatordropdownHPP
