// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothexpanderbuttonpanel.pas' rev: 21.00

#ifndef AdvsmoothexpanderbuttonpanelHPP
#define AdvsmoothexpanderbuttonpanelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Comobj.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Gdippicturecontainer.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Advsmoothexpanderpanel.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Advsmoothpanel.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothexpanderbuttonpanel
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvSmoothExpanderButtonAutoSize;
class DELPHICLASS TAdvSmoothExpanderButtonPanel;
class PASCALIMPLEMENTATION TAdvSmoothExpanderButtonAutoSize : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothExpanderButtonPanel* FOwner;
	bool FDecreaseHeight;
	bool FIncreaseHeight;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetDecreaseHeight(const bool Value);
	void __fastcall SetIncreaseHeight(const bool Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TAdvSmoothExpanderButtonAutoSize(TAdvSmoothExpanderButtonPanel* AOwner);
	__fastcall virtual ~TAdvSmoothExpanderButtonAutoSize(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool IncreaseHeight = {read=FIncreaseHeight, write=SetIncreaseHeight, default=1};
	__property bool DecreaseHeight = {read=FDecreaseHeight, write=SetDecreaseHeight, default=0};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TAdvSmoothExpanderButtonStatus;
class PASCALIMPLEMENTATION TAdvSmoothExpanderButtonStatus : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothExpanderButtonPanel* FOwner;
	int FOffsetTop;
	int FOffsetLeft;
	bool FVisible;
	Gdipfill::TGDIPStatus* FAppearance;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetOffsetLeft(const int Value);
	void __fastcall SetOffsetTop(const int Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetAppearance(const Gdipfill::TGDIPStatus* Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall AppearanceChanged(System::TObject* Sender);
	
public:
	__fastcall TAdvSmoothExpanderButtonStatus(TAdvSmoothExpanderButtonPanel* AOwner);
	__fastcall virtual ~TAdvSmoothExpanderButtonStatus(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool Visible = {read=FVisible, write=SetVisible, default=0};
	__property int OffsetLeft = {read=FOffsetLeft, write=SetOffsetLeft, default=0};
	__property int OffsetTop = {read=FOffsetTop, write=SetOffsetTop, default=0};
	__property Gdipfill::TGDIPStatus* Appearance = {read=FAppearance, write=SetAppearance};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TAdvSmoothExpanderButton;
class PASCALIMPLEMENTATION TAdvSmoothExpanderButton : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	TAdvSmoothExpanderButtonPanel* FOwner;
	bool FDown;
	bool FEnabled;
	Advgdip::TAdvGDIPPicture* FPicture;
	bool FBevel;
	Graphics::TColor FColor;
	Graphics::TColor FBevelColor;
	System::UnicodeString FCaption;
	System::UnicodeString FStatusCaption;
	Graphics::TColor FTextColor;
	Graphics::TColor FColorDisabled;
	int FTag;
	void __fastcall SetBevel(const bool Value);
	void __fastcall SetBevelColor(const Graphics::TColor Value);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetPicture(const Advgdip::TAdvGDIPPicture* Value);
	void __fastcall SetStatusCaption(const System::UnicodeString Value);
	void __fastcall SetTextColor(const Graphics::TColor Value);
	void __fastcall SetColorDisabled(const Graphics::TColor Value);
	void __fastcall SetTag(const int Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	void __fastcall PictureChanged(System::TObject* Sender);
	
public:
	__fastcall virtual TAdvSmoothExpanderButton(Classes::TCollection* Collection);
	__fastcall virtual ~TAdvSmoothExpanderButton(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool Bevel = {read=FBevel, write=SetBevel, default=1};
	__property Graphics::TColor BevelColor = {read=FBevelColor, write=SetBevelColor, default=16777215};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property System::UnicodeString StatusCaption = {read=FStatusCaption, write=SetStatusCaption};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=12632256};
	__property Graphics::TColor ColorDisabled = {read=FColorDisabled, write=SetColorDisabled, default=8421504};
	__property Advgdip::TAdvGDIPPicture* Picture = {read=FPicture, write=SetPicture};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property Graphics::TColor TextColor = {read=FTextColor, write=SetTextColor, default=0};
	__property int Tag = {read=FTag, write=SetTag, default=0};
};


class DELPHICLASS TAdvSmoothExpanderButtons;
class PASCALIMPLEMENTATION TAdvSmoothExpanderButtons : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvSmoothExpanderButton* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvSmoothExpanderButtonPanel* FOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TAdvSmoothExpanderButton* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TAdvSmoothExpanderButton* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TAdvSmoothExpanderButtons(TAdvSmoothExpanderButtonPanel* AOwner);
	HIDESBASE TAdvSmoothExpanderButton* __fastcall Add(void);
	HIDESBASE TAdvSmoothExpanderButton* __fastcall Insert(int Index);
	__property TAdvSmoothExpanderButton* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE void __fastcall Delete(int Index);
	
__published:
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAdvSmoothExpanderButtons(void) { }
	
};


typedef void __fastcall (__closure *TAdvSmoothExpanderButtonStatusDraw)(System::TObject* Sender, Gdipfill::TGDIPFill* StatusAppearance, Graphics::TFont* StatusFont, int ButtonIndex);

typedef void __fastcall (__closure *TAdvSmoothExpanderButtonClickEvent)(System::TObject* Sender, int ButtonIndex);

class PASCALIMPLEMENTATION TAdvSmoothExpanderButtonPanel : public Advsmoothexpanderpanel::TAdvSmoothExpanderPanel
{
	typedef Advsmoothexpanderpanel::TAdvSmoothExpanderPanel inherited;
	
private:
	bool FFocused;
	bool FCalculateHeight;
	int FFocusedButtonIndex;
	bool FDesignTime;
	Advgdip::TGPBitmap* FCache;
	bool FValidCache;
	TAdvSmoothExpanderButtons* FButtons;
	TAdvSmoothExpanderButtonStatus* FButtonStatus;
	TAdvSmoothExpanderButtonStatusDraw FOnDrawStatus;
	int FVerticalSpacing;
	int FHorizontalSpacing;
	Gdipfill::TGDIPButton* FButtonAppearance;
	int FButtonHeight;
	int FButtonWidth;
	TAdvSmoothExpanderButtonClickEvent FOnButtonClick;
	TAdvSmoothExpanderButtonClickEvent FOnButtonClicked;
	int FVerticalMargin;
	int FHorizontalMargin;
	TAdvSmoothExpanderButtonAutoSize* FAutoSize;
	int FRows;
	int FColumns;
	void __fastcall SetButtons(const TAdvSmoothExpanderButtons* Value);
	void __fastcall SetButtonStatus(const TAdvSmoothExpanderButtonStatus* Value);
	void __fastcall SetHorizontalSpacing(const int Value);
	void __fastcall SetVerticalSpacing(const int Value);
	void __fastcall SetButtonAppearance(const Gdipfill::TGDIPButton* Value);
	void __fastcall SetButtonHeight(const int Value);
	void __fastcall SetButtonWidth(const int Value);
	void __fastcall SetHorizontalMargin(const int Value);
	void __fastcall SetVerticalMargin(const int Value);
	void __fastcall SetAS(const TAdvSmoothExpanderButtonAutoSize* Value);
	void __fastcall SetColumns(const int Value);
	void __fastcall SetRows(const int Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	void __fastcall PanelChanged(System::TObject* Sender);
	void __fastcall ButtonStatusChanged(System::TObject* Sender);
	void __fastcall ButtonsChanged(System::TObject* Sender);
	void __fastcall AutoSizeChanged(System::TObject* Sender);
	virtual void __fastcall GDIPPaint(Advgdip::TGPGraphics* g);
	virtual int __fastcall GetVersionNr(void);
	int __fastcall ButtonAtXY(int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	int __fastcall GetMaxButtons(void);
	void __fastcall CalculateHeight(void);
	int __fastcall GetButtonWidth(void);
	int __fastcall GetButtonHeight(void);
	
public:
	__fastcall virtual TAdvSmoothExpanderButtonPanel(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothExpanderButtonPanel(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	HIDESBASE void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	
__published:
	__property TAdvSmoothExpanderButtonAutoSize* AutoSize = {read=FAutoSize, write=SetAS};
	__property TAdvSmoothExpanderButtons* Buttons = {read=FButtons, write=SetButtons};
	__property TAdvSmoothExpanderButtonStatus* ButtonStatus = {read=FButtonStatus, write=SetButtonStatus};
	__property Gdipfill::TGDIPButton* ButtonAppearance = {read=FButtonAppearance, write=SetButtonAppearance};
	__property int ButtonVerticalMargin = {read=FVerticalMargin, write=SetVerticalMargin, default=35};
	__property int ButtonHorizontalMargin = {read=FHorizontalMargin, write=SetHorizontalMargin, default=5};
	__property int ButtonHorizontalSpacing = {read=FHorizontalSpacing, write=SetHorizontalSpacing, default=5};
	__property int ButtonWidth = {read=FButtonWidth, write=SetButtonWidth, default=75};
	__property int ButtonHeight = {read=FButtonHeight, write=SetButtonHeight, default=30};
	__property int Columns = {read=FColumns, write=SetColumns, default=-1};
	__property int Rows = {read=FRows, write=SetRows, default=-1};
	__property int ButtonVerticalSpacing = {read=FVerticalSpacing, write=SetVerticalSpacing, default=5};
	__property TAdvSmoothExpanderButtonStatusDraw OnDrawStatus = {read=FOnDrawStatus, write=FOnDrawStatus};
	__property TAdvSmoothExpanderButtonClickEvent OnButtonClick = {read=FOnButtonClick, write=FOnButtonClick};
	__property TAdvSmoothExpanderButtonClickEvent OnButtonClicked = {read=FOnButtonClicked, write=FOnButtonClicked};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothExpanderButtonPanel(HWND ParentWindow) : Advsmoothexpanderpanel::TAdvSmoothExpanderPanel(ParentWindow) { }
	
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
static const ShortInt REL_VER = 0x4;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advsmoothexpanderbuttonpanel */
using namespace Advsmoothexpanderbuttonpanel;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothexpanderbuttonpanelHPP
