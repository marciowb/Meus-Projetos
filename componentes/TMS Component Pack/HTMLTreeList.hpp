// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Htmltreelist.pas' rev: 21.00

#ifndef HtmltreelistHPP
#define HtmltreelistHPP

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
#include <Clipbrd.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Picturecontainer.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Advgradient.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Htmltreelist
{
//-- type declarations -------------------------------------------------------
typedef Controls::THintInfo THintInfo;

typedef Controls::PHintInfo PHintInfo;

typedef void __fastcall (__closure *TAnchorEvent)(System::TObject* Sender, Comctrls::TTreeNode* Node, System::UnicodeString anchor);

class DELPHICLASS TColumnItem;
class PASCALIMPLEMENTATION TColumnItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	int FWidth;
	System::UnicodeString FColumnHeader;
	Graphics::TFont* FFont;
	void __fastcall SetWidth(const int value);
	void __fastcall SetColumnHeader(const System::UnicodeString value);
	void __fastcall SetFont(const Graphics::TFont* value);
	
public:
	__fastcall virtual TColumnItem(Classes::TCollection* Collection);
	__fastcall virtual ~TColumnItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* source);
	
__published:
	__property int Width = {read=FWidth, write=SetWidth, nodefault};
	__property System::UnicodeString Header = {read=FColumnHeader, write=SetColumnHeader};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
};


class DELPHICLASS TColumnCollection;
class DELPHICLASS THTMLTreeList;
class PASCALIMPLEMENTATION TColumnCollection : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TColumnItem* operator[](int Index) { return Items[Index]; }
	
private:
	THTMLTreeList* FOwner;
	HIDESBASE TColumnItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TColumnItem* Value);
	
protected:
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	
public:
	__fastcall TColumnCollection(THTMLTreeList* aOwner);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	HIDESBASE TColumnItem* __fastcall Add(void);
	HIDESBASE TColumnItem* __fastcall Insert(int Index);
	__property TColumnItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TColumnCollection(void) { }
	
};


typedef void __fastcall (__closure *TTLHeaderClickEvent)(System::TObject* Sender, int SectionIdx);

class DELPHICLASS TTLHeader;
class PASCALIMPLEMENTATION TTLHeader : public Extctrls::THeader
{
	typedef Extctrls::THeader inherited;
	
private:
	Graphics::TColor FColor;
	TTLHeaderClickEvent FOnClick;
	TTLHeaderClickEvent FOnRightClick;
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMRButtonDown(Messages::TWMMouse &Message);
	HIDESBASE void __fastcall SetColor(const Graphics::TColor Value);
	
public:
	__fastcall virtual TTLHeader(Classes::TComponent* aOwner);
	
protected:
	virtual void __fastcall Paint(void);
	
__published:
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property TTLHeaderClickEvent OnClick = {read=FOnClick, write=FOnClick};
	__property TTLHeaderClickEvent OnRightClick = {read=FOnRightClick, write=FOnRightClick};
public:
	/* THeader.Destroy */ inline __fastcall virtual ~TTLHeader(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TTLHeader(HWND ParentWindow) : Extctrls::THeader(ParentWindow) { }
	
};


class DELPHICLASS THeaderSettings;
class PASCALIMPLEMENTATION THeaderSettings : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	THTMLTreeList* FOwner;
	int FHeight;
	Graphics::TFont* FFont;
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	Classes::TNotifyEvent FOnChange;
	bool FFlat;
	bool FAllowResize;
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetFlat(const bool Value);
	void __fastcall SetAllowResize(const bool Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall THeaderSettings(THTMLTreeList* aOwner);
	__fastcall virtual ~THeaderSettings(void);
	
__published:
	__property bool AllowResize = {read=FAllowResize, write=SetAllowResize, default=1};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=-16777201};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=536870911};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property int Height = {read=FHeight, write=SetHeight, default=18};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class PASCALIMPLEMENTATION THTMLTreeList : public Comctrls::TTreeView
{
	typedef Comctrls::TTreeView inherited;
	
private:
	bool FAnchorHint;
	TTLHeader* FHeader;
	THeaderSettings* FHeaderSettings;
	bool FFlatHeader;
	TColumnCollection* FColumnCollection;
	bool FColumnLines;
	int FColumnSpace;
	int FOldScrollPos;
	System::UnicodeString FSeparator;
	int FItemHeight;
	Controls::TCursor FOldCursor;
	System::UnicodeString FOldAnchor;
	Graphics::TColor FURLColor;
	Controls::TImageList* FImages;
	TTLHeaderClickEvent FOnClick;
	TTLHeaderClickEvent FOnRightClick;
	TAnchorEvent FOnAnchorClick;
	TAnchorEvent FOnAnchorEnter;
	TAnchorEvent FOnAnchorExit;
	Graphics::TColor FSelectionFontColor;
	Advgradient::TGradientStyle* FSelectionColors;
	HIDESBASE MESSAGE void __fastcall WMHScroll(Messages::TMessage &message);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Messages::TWMMouse &message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &message);
	HIDESBASE MESSAGE void __fastcall WMRButtonDown(Messages::TWMMouse &message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &message);
	HIDESBASE MESSAGE void __fastcall CNNotify(Messages::TWMNotify &message);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Msg);
	void __fastcall SetColumnCollection(const TColumnCollection* Value);
	void __fastcall SetColumnLines(const bool Value);
	void __fastcall UpdateColumns(void);
	void __fastcall SectionSize(System::TObject* sender, int ASection, int AWidth);
	void __fastcall HeaderClick(System::TObject* sender, int ASection);
	void __fastcall HeaderRightClick(System::TObject* sender, int ASection);
	int __fastcall GetColWidth(int idx);
	Graphics::TFont* __fastcall GetColFont(int idx);
	void __fastcall SetSeparator(const System::UnicodeString Value);
	int __fastcall GetItemHeight(void);
	void __fastcall SetItemHeight(const int Value);
	bool __fastcall GetVisible(void);
	HIDESBASE void __fastcall SetVisible(const bool Value);
	System::UnicodeString __fastcall IsAnchor(Comctrls::TTreeNode* node, int x, int y);
	void __fastcall SetURLColor(const Graphics::TColor value);
	HIDESBASE void __fastcall SetImages(const Controls::TImageList* value);
	void __fastcall SetSelectionFontColor(const Graphics::TColor Value);
	System::UnicodeString __fastcall GetColumnText(int col, System::UnicodeString s);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	void __fastcall SetSelectionColors(const Advgradient::TGradientStyle* Value);
	void __fastcall HeaderChanged(System::TObject* Sender);
	
protected:
	DYNAMIC void __fastcall Expand(Comctrls::TTreeNode* Node);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWnd(void);
	virtual Types::TRect __fastcall GetClientRect(void);
	__property ToolTips = {default=1};
	
public:
	__fastcall virtual THTMLTreeList(Classes::TComponent* aOwner);
	__fastcall virtual ~THTMLTreeList(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	void __fastcall SetNodeColumn(Comctrls::TTreeNode* tn, int idx, System::UnicodeString value);
	System::UnicodeString __fastcall GetNodeColumn(Comctrls::TTreeNode* tn, int idx);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	
__published:
	__property bool AnchorHint = {read=FAnchorHint, write=FAnchorHint, default=0};
	__property TColumnCollection* Columns = {read=FColumnCollection, write=SetColumnCollection};
	__property bool ColumnLines = {read=FColumnLines, write=SetColumnLines, default=1};
	__property System::UnicodeString Separator = {read=FSeparator, write=SetSeparator};
	__property int ItemHeight = {read=GetItemHeight, write=SetItemHeight, nodefault};
	__property bool Visible = {read=GetVisible, write=SetVisible, default=1};
	__property THeaderSettings* HeaderSettings = {read=FHeaderSettings, write=FHeaderSettings};
	__property Controls::TImageList* HTMLImages = {read=FImages, write=SetImages};
	__property Advgradient::TGradientStyle* SelectionColors = {read=FSelectionColors, write=SetSelectionColors};
	__property Graphics::TColor SelectionFontColor = {read=FSelectionFontColor, write=SetSelectionFontColor, default=-16777202};
	__property Graphics::TColor URLColor = {read=FURLColor, write=SetURLColor, default=16711680};
	__property TTLHeaderClickEvent OnHeaderClick = {read=FOnClick, write=FOnClick};
	__property TTLHeaderClickEvent OnHeaderRightClick = {read=FOnRightClick, write=FOnRightClick};
	__property TAnchorEvent OnAnchorClick = {read=FOnAnchorClick, write=FOnAnchorClick};
	__property TAnchorEvent OnAnchorEnter = {read=FOnAnchorEnter, write=FOnAnchorEnter};
	__property TAnchorEvent OnAnchorExit = {read=FOnAnchorExit, write=FOnAnchorExit};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall THTMLTreeList(HWND ParentWindow) : Comctrls::TTreeView(ParentWindow) { }
	
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
static const ShortInt MIN_VER = 0x2;
static const ShortInt REL_VER = 0x1;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Htmltreelist */
using namespace Htmltreelist;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// HtmltreelistHPP
