// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothcalculator.pas' rev: 21.00

#ifndef AdvsmoothcalculatorHPP
#define AdvsmoothcalculatorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothcalculator
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TExtraButtons;
class DELPHICLASS TAdvSmoothCalculator;
class PASCALIMPLEMENTATION TExtraButtons : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothCalculator* FOwner;
	System::UnicodeString FExtra1;
	System::UnicodeString FExtra4;
	System::UnicodeString FExtra2;
	System::UnicodeString FExtra3;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetExtra1(const System::UnicodeString Value);
	void __fastcall SetExtra2(const System::UnicodeString Value);
	void __fastcall SetExtra3(const System::UnicodeString Value);
	void __fastcall SetExtra4(const System::UnicodeString Value);
	
public:
	void __fastcall Changed(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__fastcall TExtraButtons(TAdvSmoothCalculator* AOwner);
	
__published:
	__property System::UnicodeString Extra1 = {read=FExtra1, write=SetExtra1};
	__property System::UnicodeString Extra2 = {read=FExtra2, write=SetExtra2};
	__property System::UnicodeString Extra3 = {read=FExtra3, write=SetExtra3};
	__property System::UnicodeString Extra4 = {read=FExtra4, write=SetExtra4};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TExtraButtons(void) { }
	
};


typedef void __fastcall (__closure *TExtraButtonClickEvent)(System::TObject* Sender, int idx, System::Extended &value);

class DELPHICLASS TDisplayAppearance;
class PASCALIMPLEMENTATION TDisplayAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothCalculator* FOwner;
	Advgdip::TAdvGradientType FGradientType;
	Advgdip::TAdvGDIPPicture* FPicture;
	System::Byte FColorOffOpacity;
	Graphics::TColor FColorOff;
	Graphics::TColor FEndColor;
	Advgdip::HatchStyle FHatchStyle;
	int FAngle;
	System::Byte FStartOpacity;
	Classes::TNotifyEvent FOnChange;
	Gdipfill::TGDIPFill* FFill;
	System::Byte FEndOpacity;
	Graphics::TColor FStartColor;
	void __fastcall SetAngle(const int Value);
	void __fastcall SetColorOff(const Graphics::TColor Value);
	void __fastcall SetColorOffOpacity(const System::Byte Value);
	void __fastcall SetEndColor(const Graphics::TColor Value);
	void __fastcall SetEndOpacity(const System::Byte Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetGradientType(const Advgdip::TAdvGradientType Value);
	void __fastcall SetHatchStyle(const Advgdip::HatchStyle Value);
	void __fastcall SetPicture(const Advgdip::TAdvGDIPPicture* Value);
	void __fastcall SetStartColor(const Graphics::TColor Value);
	void __fastcall SetStartOpacity(const System::Byte Value);
	
protected:
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall PictureChanged(System::TObject* Sender);
	void __fastcall Changed(void);
	
public:
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__fastcall TDisplayAppearance(void);
	__fastcall virtual ~TDisplayAppearance(void);
	
__published:
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property Advgdip::TAdvGDIPPicture* Picture = {read=FPicture, write=SetPicture};
	__property Graphics::TColor ColorStart = {read=FStartColor, write=SetStartColor, default=4227327};
	__property Graphics::TColor ColorEnd = {read=FEndColor, write=SetEndColor, default=255};
	__property Graphics::TColor ColorOff = {read=FColorOff, write=SetColorOff, default=8421504};
	__property System::Byte ColorOffOpacity = {read=FColorOffOpacity, write=SetColorOffOpacity, default=255};
	__property System::Byte OpacityStart = {read=FStartOpacity, write=SetStartOpacity, default=255};
	__property System::Byte OpacityEnd = {read=FEndOpacity, write=SetEndOpacity, default=255};
	__property Advgdip::TAdvGradientType GradientType = {read=FGradientType, write=SetGradientType, default=2};
	__property Advgdip::HatchStyle HatchStyle = {read=FHatchStyle, write=SetHatchStyle, default=0};
	__property int Angle = {read=FAngle, write=SetAngle, default=0};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TCalculatorLook;
class PASCALIMPLEMENTATION TCalculatorLook : public Gdipfill::TGDIPButton
{
	typedef Gdipfill::TGDIPButton inherited;
	
private:
	bool FBevel;
	Graphics::TColor FColor;
	Graphics::TColor FBevelColor;
	TAdvSmoothCalculator* FOwner;
	TDisplayAppearance* FDisplayAppearance;
	Gdipfill::TGDIPFill* FFill;
	Graphics::TColor FButtonColorSpecial;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetBevel(const bool Value);
	void __fastcall SetBevelColor(const Graphics::TColor Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetDisplayAppearance(const TDisplayAppearance* Value);
	void __fastcall SetOwner(const TAdvSmoothCalculator* Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetButtonColorSpecial(const Graphics::TColor Value);
	
protected:
	void __fastcall FillChanged(System::TObject* Sender);
	__property TAdvSmoothCalculator* Owner = {read=FOwner, write=SetOwner};
	virtual void __fastcall Changed(void);
	
public:
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__fastcall virtual TCalculatorLook(void);
	__fastcall virtual ~TCalculatorLook(void);
	
__published:
	__property bool ButtonBevel = {read=FBevel, write=SetBevel, default=1};
	__property Graphics::TColor ButtonBevelColor = {read=FBevelColor, write=SetBevelColor, default=16777215};
	__property Graphics::TColor ButtonColorSpecial = {read=FButtonColorSpecial, write=SetButtonColorSpecial, default=8421504};
	__property Graphics::TColor ButtonColor = {read=FColor, write=SetColor, default=8421504};
	__property TDisplayAppearance* DisplayAppearance = {read=FDisplayAppearance, write=SetDisplayAppearance};
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


typedef void __fastcall (__closure *TValueChangedEvent)(System::TObject* Sender, double Value);

class PASCALIMPLEMENTATION TAdvSmoothCalculator : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	bool FFocused;
	bool FDesignTime;
	Advgdip::TGPBitmap* FCache;
	bool FValidCache;
	double FFloat;
	int FButtonDown;
	bool newval;
	System::Extended prevval;
	int prevop;
	int FDecim;
	TCalculatorLook* FCalculatorLook;
	TExtraButtons* FExtraButtons;
	short FPrecision;
	TExtraButtonClickEvent fOnExtraButtonClick;
	TValueChangedEvent FOnValueChanged;
	void __fastcall SetCalculatorLook(const TCalculatorLook* Value);
	void __fastcall SetExtraButtons(const TExtraButtons* Value);
	double __fastcall GetFloat(void);
	void __fastcall SetFloat(const double Value);
	MESSAGE void __fastcall WMGetMinMaxInfo(Messages::TMessage &Msg);
	void __fastcall SetPrecision(const short Value);
	
protected:
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	void __fastcall CalculatorChanged(System::TObject* Sender);
	void __fastcall NumButtonClick(int ButtonIdx);
	void __fastcall DrawBackGround(Advgdip::TGPGraphics* g);
	void __fastcall DrawCalculatorButtons(Advgdip::TGPGraphics* g);
	void __fastcall DrawDisplay(Advgdip::TGPGraphics* g);
	void __fastcall FillChanged(System::TObject* Sender);
	HIDESBASE void __fastcall Changed(void);
	System::Extended __fastcall EStrToFloat(System::UnicodeString s);
	void __fastcall docalc(void);
	void __fastcall doplus(void);
	void __fastcall domin(void);
	void __fastcall domul(void);
	void __fastcall dodiv(void);
	void __fastcall doeq(void);
	void __fastcall doperc(void);
	DYNAMIC void __fastcall Resize(void);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall DoEnter(void);
	
public:
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__fastcall virtual TAdvSmoothCalculator(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothCalculator(void);
	virtual void __fastcall Paint(void);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	int __fastcall XYToButton(int X, int Y);
	int __fastcall ButtonAtFunction(int Key);
	
__published:
	__property TExtraButtons* ExtraButtons = {read=FExtraButtons, write=SetExtraButtons};
	__property TCalculatorLook* CalculatorLook = {read=FCalculatorLook, write=SetCalculatorLook};
	__property double FloatValue = {read=GetFloat, write=SetFloat};
	__property TExtraButtonClickEvent OnExtraButtonClick = {read=fOnExtraButtonClick, write=fOnExtraButtonClick};
	__property TValueChangedEvent OnValueChanged = {read=FOnValueChanged, write=FOnValueChanged};
	__property short Precision = {read=FPrecision, write=SetPrecision, default=0};
	__property Align = {default=0};
	__property Color = {default=-16777211};
	__property TabStop = {default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothCalculator(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
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
static const ShortInt REL_VER = 0x1;
static const ShortInt BLD_VER = 0x1;

}	/* namespace Advsmoothcalculator */
using namespace Advsmoothcalculator;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothcalculatorHPP
