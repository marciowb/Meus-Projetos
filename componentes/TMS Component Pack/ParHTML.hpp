// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Parhtml.pas' rev: 21.00

#ifndef ParhtmlHPP
#define ParhtmlHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Picturecontainer.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Spin.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Parxpvs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Parhtml
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TParamUpdateEvent)(System::TObject* Sender, System::UnicodeString Param, System::UnicodeString Text);

class DELPHICLASS TPopupMaskEdit;
class PASCALIMPLEMENTATION TPopupMaskEdit : public Mask::TMaskEdit
{
	typedef Mask::TMaskEdit inherited;
	
private:
	bool FCancelled;
	System::UnicodeString FParam;
	TParamUpdateEvent FOnUpdate;
	Classes::TNotifyEvent FOnReturn;
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	MESSAGE void __fastcall WMActivate(Messages::TWMActivate &Message);
	
protected:
	DYNAMIC void __fastcall DoExit(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
public:
	__property bool Cancelled = {read=FCancelled, write=FCancelled, nodefault};
	__property System::UnicodeString Param = {read=FParam, write=FParam};
	__property TParamUpdateEvent OnUpdate = {read=FOnUpdate, write=FOnUpdate};
	__property Classes::TNotifyEvent OnReturn = {read=FOnReturn, write=FOnReturn};
public:
	/* TCustomMaskEdit.Create */ inline __fastcall virtual TPopupMaskEdit(Classes::TComponent* AOwner) : Mask::TMaskEdit(AOwner) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPopupMaskEdit(HWND ParentWindow) : Mask::TMaskEdit(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TPopupMaskEdit(void) { }
	
};


class DELPHICLASS TPopupEdit;
class PASCALIMPLEMENTATION TPopupEdit : public Stdctrls::TEdit
{
	typedef Stdctrls::TEdit inherited;
	
private:
	bool FCancelled;
	bool FContext;
	System::UnicodeString FParam;
	TParamUpdateEvent FOnUpdate;
	bool FAutoSize;
	Classes::TNotifyEvent FOnReturn;
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	MESSAGE void __fastcall WMActivate(Messages::TWMActivate &Message);
	MESSAGE void __fastcall WMContextPopup(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall WndProc(Messages::TMessage &Msg);
	DYNAMIC void __fastcall DoExit(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall Change(void);
	
public:
	__property bool AutoSize = {read=FAutoSize, write=FAutoSize, nodefault};
	__property bool Cancelled = {read=FCancelled, write=FCancelled, nodefault};
	__property System::UnicodeString Param = {read=FParam, write=FParam};
	__property TParamUpdateEvent OnUpdate = {read=FOnUpdate, write=FOnUpdate};
	__property Classes::TNotifyEvent OnReturn = {read=FOnReturn, write=FOnReturn};
public:
	/* TCustomEdit.Create */ inline __fastcall virtual TPopupEdit(Classes::TComponent* AOwner) : Stdctrls::TEdit(AOwner) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPopupEdit(HWND ParentWindow) : Stdctrls::TEdit(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TPopupEdit(void) { }
	
};


class DELPHICLASS TPopupSpinEdit;
class PASCALIMPLEMENTATION TPopupSpinEdit : public Spin::TSpinEdit
{
	typedef Spin::TSpinEdit inherited;
	
private:
	bool FContext;
	bool FCancelled;
	System::UnicodeString FParam;
	TParamUpdateEvent FOnUpdate;
	Classes::TNotifyEvent FOnReturn;
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	MESSAGE void __fastcall WMActivate(Messages::TWMActivate &Message);
	MESSAGE void __fastcall WMContextPopup(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall WndProc(Messages::TMessage &Msg);
	DYNAMIC void __fastcall DoExit(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
public:
	__property bool Cancelled = {read=FCancelled, write=FCancelled, nodefault};
	__property System::UnicodeString Param = {read=FParam, write=FParam};
	__property TParamUpdateEvent OnUpdate = {read=FOnUpdate, write=FOnUpdate};
	__property Classes::TNotifyEvent OnReturn = {read=FOnReturn, write=FOnReturn};
public:
	/* TSpinEdit.Create */ inline __fastcall virtual TPopupSpinEdit(Classes::TComponent* AOwner) : Spin::TSpinEdit(AOwner) { }
	/* TSpinEdit.Destroy */ inline __fastcall virtual ~TPopupSpinEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPopupSpinEdit(HWND ParentWindow) : Spin::TSpinEdit(ParentWindow) { }
	
};


class DELPHICLASS TPopupListBox;
class PASCALIMPLEMENTATION TPopupListBox : public Stdctrls::TListBox
{
	typedef Stdctrls::TListBox inherited;
	
private:
	System::UnicodeString FParam;
	TParamUpdateEvent FOnUpdate;
	Classes::TNotifyEvent FOnReturn;
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Message);
	MESSAGE void __fastcall WMActivate(Messages::TWMActivate &Message);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
public:
	void __fastcall SizeDropDownWidth(void);
	__property System::UnicodeString Param = {read=FParam, write=FParam};
	__property TParamUpdateEvent OnUpdate = {read=FOnUpdate, write=FOnUpdate};
	__property Classes::TNotifyEvent OnReturn = {read=FOnReturn, write=FOnReturn};
public:
	/* TCustomListBox.Create */ inline __fastcall virtual TPopupListBox(Classes::TComponent* AOwner) : Stdctrls::TListBox(AOwner) { }
	/* TCustomListBox.Destroy */ inline __fastcall virtual ~TPopupListBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPopupListBox(HWND ParentWindow) : Stdctrls::TListBox(ParentWindow) { }
	
};


class DELPHICLASS TPopupDatePicker;
class PASCALIMPLEMENTATION TPopupDatePicker : public Comctrls::TDateTimePicker
{
	typedef Comctrls::TDateTimePicker inherited;
	
private:
	bool FCancelled;
	System::UnicodeString FParam;
	TParamUpdateEvent FOnUpdate;
	Classes::TNotifyEvent FOnReturn;
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	MESSAGE void __fastcall WMActivate(Messages::TWMActivate &Message);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall DoExit(void);
	
public:
	void __fastcall ReInit(void);
	__property bool Cancelled = {read=FCancelled, write=FCancelled, nodefault};
	__property System::UnicodeString Param = {read=FParam, write=FParam};
	__property TParamUpdateEvent OnUpdate = {read=FOnUpdate, write=FOnUpdate};
	__property Classes::TNotifyEvent OnReturn = {read=FOnReturn, write=FOnReturn};
public:
	/* TDateTimePicker.Create */ inline __fastcall virtual TPopupDatePicker(Classes::TComponent* AOwner) : Comctrls::TDateTimePicker(AOwner) { }
	
public:
	/* TCommonCalendar.Destroy */ inline __fastcall virtual ~TPopupDatePicker(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPopupDatePicker(HWND ParentWindow) : Comctrls::TDateTimePicker(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE bool IsWinXP;
extern PACKAGE void __fastcall PrintBitmap(Graphics::TCanvas* Canvas, const Types::TRect &DestRect, Graphics::TBitmap* Bitmap);
extern PACKAGE bool __fastcall GetControlValue(System::UnicodeString HTML, System::UnicodeString ControlID, System::UnicodeString &ControlValue);
extern PACKAGE bool __fastcall SetControlValue(System::UnicodeString &HTML, System::UnicodeString ControlID, System::UnicodeString ControlValue);
extern PACKAGE bool __fastcall HTMLDrawEx(Graphics::TCanvas* Canvas, System::UnicodeString s, const Types::TRect &fr, Controls::TImageList* FImages, int XPos, int YPos, int FocusLink, int HoverLink, int ShadowOffset, bool CheckHotSpot, bool CheckHeight, bool Print, bool Selected, bool Blink, bool HoverStyle, bool WordWrap, bool Down, bool GetFocusRect, double ResFactor, Graphics::TColor URLColor, Graphics::TColor HoverColor, Graphics::TColor HoverFontColor, Graphics::TColor ShadowColor, System::UnicodeString &AnchorVal, System::UnicodeString &StripVal, System::UnicodeString &FocusAnchor, int &XSize, int &YSize, int &HyperLinks, int &MouseLink, Types::TRect &HoverRect, Types::TRect &ControlRect, System::UnicodeString &CID, System::UnicodeString &CV, System::UnicodeString &CT, Picturecontainer::THTMLPictureCache* ic, Picturecontainer::TPictureContainer* pc, unsigned WinHandle, int LineSpacing);
extern PACKAGE System::UnicodeString __fastcall HTMLStrip(System::UnicodeString s);
extern PACKAGE System::UnicodeString __fastcall HiLight(System::UnicodeString s, System::UnicodeString h, System::UnicodeString tag, bool DoCase);
extern PACKAGE System::UnicodeString __fastcall UnHiLight(System::UnicodeString s, System::UnicodeString tag);
extern PACKAGE bool __fastcall GetHREFValue(System::UnicodeString html, System::UnicodeString href, System::UnicodeString &value);
extern PACKAGE bool __fastcall SetHREFValue(System::UnicodeString &html, System::UnicodeString href, System::UnicodeString value);
extern PACKAGE System::UnicodeString __fastcall HTMLPrep(System::UnicodeString s);
extern PACKAGE System::UnicodeString __fastcall InvHTMLPrep(System::UnicodeString s);
extern PACKAGE void __fastcall PropToList(System::UnicodeString s, Classes::TStringList* sl);
extern PACKAGE bool __fastcall ExtractParamInfo(System::UnicodeString html, System::UnicodeString href, System::UnicodeString &AClass, System::UnicodeString &AValue, System::UnicodeString &AProps, System::UnicodeString &AHint);

}	/* namespace Parhtml */
using namespace Parhtml;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ParhtmlHPP
