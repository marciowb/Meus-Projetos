// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Dbadvglownavigator.pas' rev: 21.00

#ifndef DbadvglownavigatorHPP
#define DbadvglownavigatorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Dbctrls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Advglowbutton.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dbadvglownavigator
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TNavigatorOrientation { noHorizontal, noVertical };
#pragma option pop

#pragma option push -b-
enum TAdvNavigateBtn { nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbEdit, nbPost, nbCancel, nbRefresh, nbSearch, nbSetBookmark, nbGotoBookMark };
#pragma option pop

typedef Set<TAdvNavigateBtn, nbFirst, nbGotoBookMark>  TButtonSet;

typedef void __fastcall (__closure *ENavClick)(System::TObject* Sender, TAdvNavigateBtn Button);

#pragma option push -b-
enum TGlyphSize { gsSmall, gsLarge, gsCustom };
#pragma option pop

class DELPHICLASS TDBAdvGlowNavigator;
class DELPHICLASS TAdvNavDataLink;
class DELPHICLASS TAdvGlowNavButton;
class PASCALIMPLEMENTATION TDBAdvGlowNavigator : public Extctrls::TCustomPanel
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	TAdvNavDataLink* FDataLink;
	TButtonSet FVisibleButtons;
	Classes::TStrings* FHints;
	Classes::TStrings* FDefHints;
	int ButtonWidth;
	int ButtonHeight;
	Types::TPoint MinBtnSize;
	ENavClick FOnNavClick;
	ENavClick FBeforeAction;
	TAdvNavigateBtn FocusedButton;
	bool FConfirmDelete;
	bool FDeleteDisabled;
	bool FInsertDisabled;
	Classes::TNotifyEvent FOnBtnPrior;
	Classes::TNotifyEvent FOnBtnNext;
	Classes::TNotifyEvent FOnBtnFirst;
	Classes::TNotifyEvent FOnBtnLast;
	Classes::TNotifyEvent FOnBtnInsert;
	Classes::TNotifyEvent FOnBtnEdit;
	Classes::TNotifyEvent FOnBtnCancel;
	Classes::TNotifyEvent FOnBtnPost;
	Classes::TNotifyEvent FOnBtnRefresh;
	Classes::TNotifyEvent FOnBtnDelete;
	TNavigatorOrientation FOrientation;
	TGlyphSize FGlyphSize;
	Classes::TNotifyEvent FOnBtnSearch;
	Classes::TNotifyEvent FOnBtnGotoBookmark;
	Classes::TNotifyEvent FOnBtnSetBookmark;
	System::UnicodeString FBookmarkStr;
	Sysutils::TBytes FBookmark;
	int FLook;
	int FGlyphCustomSize;
	System::UnicodeString FGlyphResName;
	bool FTransparent;
	Advglowbutton::TGlowButtonAppearance* FAppearance;
	Advstyleif::TTMSStyle FStyle;
	void __fastcall BtnMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall ClickHandler(System::TObject* Sender);
	Db::TDataSource* __fastcall GetDataSource(void);
	Classes::TStrings* __fastcall GetHints(void);
	void __fastcall HintsChanged(System::TObject* Sender);
	void __fastcall OnAppearanceChanged(System::TObject* Sender);
	void __fastcall InitButtons(void);
	void __fastcall InitHints(void);
	void __fastcall InitStyles(void);
	void __fastcall SetDataSource(Db::TDataSource* Value);
	void __fastcall SetHints(Classes::TStrings* Value);
	void __fastcall SetSize(int &W, int &H);
	HIDESBASE void __fastcall SetVisible(TButtonSet Value);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanging(Messages::TWMWindowPosMsg &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	void __fastcall SetDeleteDisabled(const bool Value);
	void __fastcall SetInsertDisabled(const bool Value);
	void __fastcall SetOrientation(const TNavigatorOrientation Value);
	void __fastcall SetGlyphSize(const TGlyphSize Value);
	void __fastcall SetLook(const int Value);
	void __fastcall SetGlyphCustomSize(const int Value);
	void __fastcall SetGlyphResName(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	TAdvGlowNavButton* __fastcall GetButtons(TAdvNavigateBtn index);
	void __fastcall SetTransparent(const bool Value);
	void __fastcall SetAppearance(const Advglowbutton::TGlowButtonAppearance* Value);
	void __fastcall SetStyle(const Advstyleif::TTMSStyle Value);
	
protected:
	StaticArray<TAdvGlowNavButton*, 13> FButtons;
	virtual int __fastcall GetVersionNr(void);
	void __fastcall DataChanged(void);
	void __fastcall EditingChanged(void);
	void __fastcall ActiveChanged(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall Paint(void);
	void __fastcall CalcMinSize(int &W, int &H);
	void __fastcall SetButtonsShape(void);
	
public:
	__fastcall virtual TDBAdvGlowNavigator(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBAdvGlowNavigator(void);
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	virtual void __fastcall BtnClick(TAdvNavigateBtn Index);
	__property int Look = {read=FLook, write=SetLook, nodefault};
	__property System::UnicodeString BookMarkStr = {read=FBookmarkStr, write=FBookmarkStr};
	__property Sysutils::TBytes BookMark = {read=FBookmark, write=FBookmark};
	__property TAdvGlowNavButton* Buttons[TAdvNavigateBtn index] = {read=GetButtons};
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	
__published:
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property TButtonSet VisibleButtons = {read=FVisibleButtons, write=SetVisible, default=1023};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Advglowbutton::TGlowButtonAppearance* Appearance = {read=FAppearance, write=SetAppearance};
	__property Constraints;
	__property bool DeleteDisabled = {read=FDeleteDisabled, write=SetDeleteDisabled, nodefault};
	__property bool InsertDisabled = {read=FInsertDisabled, write=SetInsertDisabled, nodefault};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property TGlyphSize GlyphSize = {read=FGlyphSize, write=SetGlyphSize, default=1};
	__property int GlyphCustomSize = {read=FGlyphCustomSize, write=SetGlyphCustomSize, nodefault};
	__property System::UnicodeString GlyphResName = {read=FGlyphResName, write=SetGlyphResName};
	__property Ctl3D;
	__property Classes::TStrings* Hints = {read=GetHints, write=SetHints};
	__property TNavigatorOrientation Orientation = {read=FOrientation, write=SetOrientation, nodefault};
	__property ParentCtl3D = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property bool ConfirmDelete = {read=FConfirmDelete, write=FConfirmDelete, default=1};
	__property ShowHint;
	__property Advstyleif::TTMSStyle Style = {read=FStyle, write=SetStyle, default=8};
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Visible = {default=1};
	__property ENavClick BeforeAction = {read=FBeforeAction, write=FBeforeAction};
	__property ENavClick OnClick = {read=FOnNavClick, write=FOnNavClick};
	__property Classes::TNotifyEvent OnBtnPrior = {read=FOnBtnPrior, write=FOnBtnPrior};
	__property Classes::TNotifyEvent OnBtnNext = {read=FOnBtnNext, write=FOnBtnNext};
	__property Classes::TNotifyEvent OnBtnFirst = {read=FOnBtnFirst, write=FOnBtnFirst};
	__property Classes::TNotifyEvent OnBtnLast = {read=FOnBtnLast, write=FOnBtnLast};
	__property Classes::TNotifyEvent OnBtnInsert = {read=FOnBtnInsert, write=FOnBtnInsert};
	__property Classes::TNotifyEvent OnBtnEdit = {read=FOnBtnEdit, write=FOnBtnEdit};
	__property Classes::TNotifyEvent OnBtnCancel = {read=FOnBtnCancel, write=FOnBtnCancel};
	__property Classes::TNotifyEvent OnBtnPost = {read=FOnBtnPost, write=FOnBtnPost};
	__property Classes::TNotifyEvent OnBtnRefresh = {read=FOnBtnRefresh, write=FOnBtnRefresh};
	__property Classes::TNotifyEvent OnBtnDelete = {read=FOnBtnDelete, write=FOnBtnDelete};
	__property Classes::TNotifyEvent OnBtnSearch = {read=FOnBtnSearch, write=FOnBtnSearch};
	__property Classes::TNotifyEvent OnBtnSetBookmark = {read=FOnBtnSetBookmark, write=FOnBtnSetBookmark};
	__property Classes::TNotifyEvent OnBtnGotoBookmark = {read=FOnBtnGotoBookmark, write=FOnBtnGotoBookmark};
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnResize;
	__property OnStartDock;
	__property OnStartDrag;
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall TDBAdvGlowNavigator(HWND ParentWindow) : Extctrls::TCustomPanel(ParentWindow) { }
	
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


class PASCALIMPLEMENTATION TAdvGlowNavButton : public Advglowbutton::TAdvGlowButton
{
	typedef Advglowbutton::TAdvGlowButton inherited;
	
private:
	TAdvNavigateBtn FIndex;
	Dbctrls::TNavButtonStyle FNavStyle;
	Graphics::TBitmap* FGlyph;
	Graphics::TBitmap* FGlyphHot;
	Graphics::TBitmap* FGlyphDisabled;
	void __fastcall SetGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetGlyphDisabled(const Graphics::TBitmap* Value);
	void __fastcall SetGlyphHot(const Graphics::TBitmap* Value);
	void __fastcall SetNavStyle(const Dbctrls::TNavButtonStyle Value);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall GetToolImage(Graphics::TBitmap* bmp);
	
public:
	__fastcall virtual TAdvGlowNavButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvGlowNavButton(void);
	__property Dbctrls::TNavButtonStyle NavStyle = {read=FNavStyle, write=SetNavStyle, nodefault};
	__property TAdvNavigateBtn Index = {read=FIndex, write=FIndex, nodefault};
	__property Graphics::TBitmap* Glyph = {read=FGlyph, write=SetGlyph};
	__property Graphics::TBitmap* GlyphHot = {read=FGlyphHot, write=SetGlyphHot};
	__property Graphics::TBitmap* GlyphDisabled = {read=FGlyphDisabled, write=SetGlyphDisabled};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvGlowNavButton(HWND ParentWindow) : Advglowbutton::TAdvGlowButton(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TAdvNavDataLink : public Db::TDataLink
{
	typedef Db::TDataLink inherited;
	
private:
	TDBAdvGlowNavigator* FNavigator;
	
protected:
	virtual void __fastcall EditingChanged(void);
	virtual void __fastcall DataSetChanged(void);
	virtual void __fastcall ActiveChanged(void);
	
public:
	__fastcall TAdvNavDataLink(TDBAdvGlowNavigator* ANav);
	__fastcall virtual ~TAdvNavDataLink(void);
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x1;
static const ShortInt REL_VER = 0x3;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Dbadvglownavigator */
using namespace Dbadvglownavigator;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DbadvglownavigatorHPP
