// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Htmcombo.pas' rev: 21.00

#ifndef HtmcomboHPP
#define HtmcomboHPP

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
#include <Stdctrls.hpp>	// Pascal unit
#include <Picturecontainer.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Advgradient.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Htmcombo
{
//-- type declarations -------------------------------------------------------
typedef Controls::THintInfo THintInfo;

typedef Controls::PHintInfo PHintInfo;

class DELPHICLASS EHTMLComboBoxError;
class PASCALIMPLEMENTATION EHTMLComboBoxError : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EHTMLComboBoxError(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EHTMLComboBoxError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EHTMLComboBoxError(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EHTMLComboBoxError(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EHTMLComboBoxError(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EHTMLComboBoxError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EHTMLComboBoxError(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EHTMLComboBoxError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EHTMLComboBoxError(void) { }
	
};


typedef void __fastcall (__closure *TAnchorClick)(System::TObject* Sender, int index, System::UnicodeString anchor);

class DELPHICLASS TBaseCustomComboBox;
class PASCALIMPLEMENTATION TBaseCustomComboBox : public Stdctrls::TCustomComboBox
{
	typedef Stdctrls::TCustomComboBox inherited;
	
private:
	bool FAutoFocus;
	bool FFlat;
	bool FEtched;
	Graphics::TColor FOldColor;
	bool FOldParentColor;
	int FButtonWidth;
	bool FFocusBorder;
	bool FMouseInControl;
	int fDropWidth;
	void __fastcall SetEtched(const bool Value);
	void __fastcall SetFlat(const bool Value);
	void __fastcall SetButtonWidth(const int Value);
	void __fastcall DrawButtonBorder(HDC DC);
	void __fastcall DrawControlBorder(HDC DC);
	void __fastcall DrawBorders(void);
	bool __fastcall Is3DBorderControl(void);
	bool __fastcall Is3DBorderButton(void);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CNCommand(Messages::TWMCommand &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TMessage &Message);
	void __fastcall SetDropWidth(const int Value);
	
protected:
	__property int ButtonWidth = {read=FButtonWidth, write=SetButtonWidth, nodefault};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property bool Etched = {read=FEtched, write=SetEtched, default=0};
	__property bool FocusBorder = {read=FFocusBorder, write=FFocusBorder, default=0};
	__property bool AutoFocus = {read=FAutoFocus, write=FAutoFocus, default=0};
	__property int DropWidth = {read=fDropWidth, write=SetDropWidth, nodefault};
	
public:
	__fastcall virtual TBaseCustomComboBox(Classes::TComponent* AOwner);
public:
	/* TCustomComboBox.Destroy */ inline __fastcall virtual ~TBaseCustomComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TBaseCustomComboBox(HWND ParentWindow) : Stdctrls::TCustomComboBox(ParentWindow) { }
	
};


class DELPHICLASS THTMLComboBox;
class PASCALIMPLEMENTATION THTMLComboBox : public TBaseCustomComboBox
{
	typedef TBaseCustomComboBox inherited;
	
private:
	Graphics::TColor FURLColor;
	bool FIncrLookup;
	Controls::TImageList* FImages;
	int FDropHeight;
	System::UnicodeString FOldAnchor;
	System::UnicodeString FLookup;
	int FItemIndex;
	bool FSortedEx;
	int FEditHeight;
	bool FDropped;
	TAnchorClick FAnchorClick;
	TAnchorClick FAnchorEnter;
	TAnchorClick FAnchorExit;
	bool FEllipsis;
	Picturecontainer::TPictureContainer* FContainer;
	int FShadowOffset;
	Graphics::TColor FShadowColor;
	Picturecontainer::THTMLPictureCache* FImageCache;
	bool FItemHint;
	bool FHTMLHint;
	Advgradient::TGradientStyle* FSelectionColors;
	Graphics::TColor FSelectionFontColor;
	HIDESBASE void __fastcall SetDropWidth(int value);
	int __fastcall GetDropWidth(void);
	void __fastcall SetEditHeight(int value);
	int __fastcall GetEditHeight(void);
	void __fastcall SetImages(const Controls::TImageList* Value);
	void __fastcall SetURLColor(const Graphics::TColor Value);
	HIDESBASE MESSAGE void __fastcall CNCommand(Messages::TWMCommand &Message);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	System::UnicodeString __fastcall GetTextItem(int index);
	void __fastcall SetItemIndexP(const int Value);
	int __fastcall GetItemIndexP(void);
	bool __fastcall GetSortedEx(void);
	void __fastcall SetSortedEx(const bool Value);
	void __fastcall SetEllipsis(const bool Value);
	void __fastcall SetShadowColor(const Graphics::TColor Value);
	void __fastcall SetShadowOffset(const int Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	void __fastcall SetSelectionColors(const Advgradient::TGradientStyle* Value);
	void __fastcall SetSelectionFontColor(const Graphics::TColor Value);
	
protected:
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall SetStyle(Stdctrls::TComboBoxStyle Value);
	virtual void __fastcall MeasureItem(int Index, int &Height);
	virtual void __fastcall DrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DoEnter(void);
	
public:
	__fastcall virtual THTMLComboBox(Classes::TComponent* AOwner);
	__fastcall virtual ~THTMLComboBox(void);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	void __fastcall HilightInList(System::UnicodeString HiText, bool DoCase);
	void __fastcall HilightInItem(int Index, System::UnicodeString HiText, bool DoCase);
	void __fastcall UnHilightInList(void);
	void __fastcall UnHilightInItem(int Index);
	void __fastcall MarkInList(System::UnicodeString HiText, bool DoCase);
	void __fastcall MarkInItem(int Index, System::UnicodeString HiText, bool DoCase);
	void __fastcall UnMarkInList(void);
	void __fastcall UnMarkInItem(int Index);
	__property System::UnicodeString TextItems[int index] = {read=GetTextItem};
	__property Text;
	
__published:
	__property Anchors = {default=3};
	__property Constraints;
	__property AutoFocus = {default=0};
	__property ButtonWidth;
	__property Style = {default=0};
	__property Flat = {default=0};
	__property Etched = {default=0};
	__property FocusBorder = {default=0};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property DragMode = {default=0};
	__property DragCursor = {default=-12};
	__property int DropWidth = {read=GetDropWidth, write=SetDropWidth, nodefault};
	__property int DropHeight = {read=FDropHeight, write=FDropHeight, nodefault};
	__property int EditHeight = {read=GetEditHeight, write=SetEditHeight, nodefault};
	__property bool Ellipsis = {read=FEllipsis, write=SetEllipsis, default=0};
	__property Enabled = {default=1};
	__property Font;
	__property bool HTMLHint = {read=FHTMLHint, write=FHTMLHint, default=0};
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property bool IncrLookup = {read=FIncrLookup, write=FIncrLookup, default=0};
	__property bool ItemHint = {read=FItemHint, write=FItemHint, default=0};
	__property Items;
	__property int ItemIndex = {read=GetItemIndexP, write=SetItemIndexP, nodefault};
	__property MaxLength = {default=0};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property Picturecontainer::TPictureContainer* PictureContainer = {read=FContainer, write=FContainer};
	__property PopupMenu;
	__property Advgradient::TGradientStyle* SelectionColors = {read=FSelectionColors, write=SetSelectionColors};
	__property Graphics::TColor SelectionFontColor = {read=FSelectionFontColor, write=SetSelectionFontColor, default=-16777202};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=8421504};
	__property int ShadowOffset = {read=FShadowOffset, write=SetShadowOffset, default=1};
	__property ShowHint;
	__property bool Sorted = {read=GetSortedEx, write=SetSortedEx, nodefault};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Graphics::TColor URLColor = {read=FURLColor, write=SetURLColor, default=16711680};
	__property Visible = {default=1};
	__property OnChange;
	__property OnClick;
	__property OnCloseUp;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDrawItem;
	__property OnDropDown;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMeasureItem;
	__property OnStartDrag;
	__property TAnchorClick OnAnchorClick = {read=FAnchorClick, write=FAnchorClick};
	__property TAnchorClick OnAnchorEnter = {read=FAnchorEnter, write=FAnchorEnter};
	__property TAnchorClick OnAnchorExit = {read=FAnchorExit, write=FAnchorExit};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall THTMLComboBox(HWND ParentWindow) : TBaseCustomComboBox(ParentWindow) { }
	
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
static const ShortInt MAJ_VER = 0x2;
static const ShortInt MIN_VER = 0x1;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Htmcombo */
using namespace Htmcombo;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// HtmcomboHPP
