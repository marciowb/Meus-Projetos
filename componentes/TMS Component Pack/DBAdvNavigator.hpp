// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Dbadvnavigator.pas' rev: 21.00

#ifndef DbadvnavigatorHPP
#define DbadvnavigatorHPP

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
#include <Advtoolbtn.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dbadvnavigator
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

class DELPHICLASS TDBAdvNavigator;
class DELPHICLASS TAdvNavDataLink;
class DELPHICLASS TAdvNavButton;
class PASCALIMPLEMENTATION TDBAdvNavigator : public Extctrls::TCustomPanel
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
	bool FFlat;
	Graphics::TColor FBorderColor;
	Graphics::TColor FBorderDownColor;
	Graphics::TColor FBorderHotColor;
	Graphics::TColor FColorDown;
	Graphics::TColor FColorDownTo;
	Graphics::TColor FColorHot;
	Graphics::TColor FColorHotTo;
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	bool FDeleteDisabled;
	bool FInsertDisabled;
	bool FShaded;
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
	System::UnicodeString FBookmark;
	bool FAutoThemeAdapt;
	int FLook;
	int FGlyphCustomSize;
	System::UnicodeString FGlyphResName;
	void __fastcall BtnMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall ClickHandler(System::TObject* Sender);
	Db::TDataSource* __fastcall GetDataSource(void);
	Classes::TStrings* __fastcall GetHints(void);
	void __fastcall HintsChanged(System::TObject* Sender);
	void __fastcall InitButtons(void);
	void __fastcall InitHints(void);
	void __fastcall InitStyles(void);
	void __fastcall SetDataSource(Db::TDataSource* Value);
	void __fastcall SetFlat(bool Value);
	void __fastcall SetHints(Classes::TStrings* Value);
	void __fastcall SetSize(int &W, int &H);
	HIDESBASE void __fastcall SetVisible(TButtonSet Value);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanging(Messages::TWMWindowPosMsg &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetBorderDownColor(const Graphics::TColor Value);
	void __fastcall SetBorderHotColor(const Graphics::TColor Value);
	HIDESBASE void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetColorDown(const Graphics::TColor Value);
	void __fastcall SetColorDownTo(const Graphics::TColor Value);
	void __fastcall SetColorHot(const Graphics::TColor Value);
	void __fastcall SetColorHotTo(const Graphics::TColor Value);
	void __fastcall SetDeleteDisabled(const bool Value);
	void __fastcall SetInsertDisabled(const bool Value);
	void __fastcall SetShaded(const bool Value);
	void __fastcall SetOrientation(const TNavigatorOrientation Value);
	void __fastcall SetGlyphSize(const TGlyphSize Value);
	void __fastcall SetLook(const int Value);
	void __fastcall SetGlyphCustomSize(const int Value);
	void __fastcall SetGlyphResName(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	TAdvNavButton* __fastcall GetButtons(TAdvNavigateBtn index);
	
protected:
	StaticArray<TAdvNavButton*, 13> FButtons;
	virtual int __fastcall GetVersionNr(void);
	void __fastcall DataChanged(void);
	void __fastcall EditingChanged(void);
	void __fastcall ActiveChanged(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	void __fastcall CalcMinSize(int &W, int &H);
	
public:
	__fastcall virtual TDBAdvNavigator(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBAdvNavigator(void);
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	virtual void __fastcall BtnClick(TAdvNavigateBtn Index);
	__property int Look = {read=FLook, write=SetLook, nodefault};
	__property System::UnicodeString BookMark = {read=FBookmark, write=FBookmark};
	__property TAdvNavButton* Buttons[TAdvNavigateBtn index] = {read=GetButtons};
	
__published:
	__property bool AutoThemeAdapt = {read=FAutoThemeAdapt, write=FAutoThemeAdapt, nodefault};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property TButtonSet VisibleButtons = {read=FVisibleButtons, write=SetVisible, default=1023};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=536870911};
	__property Graphics::TColor BorderDownColor = {read=FBorderDownColor, write=SetBorderDownColor, default=0};
	__property Graphics::TColor BorderHotColor = {read=FBorderHotColor, write=SetBorderHotColor, default=0};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, nodefault};
	__property Graphics::TColor ColorDown = {read=FColorDown, write=SetColorDown, nodefault};
	__property Graphics::TColor ColorDownTo = {read=FColorDownTo, write=SetColorDownTo, nodefault};
	__property Graphics::TColor ColorHot = {read=FColorHot, write=SetColorHot, nodefault};
	__property Graphics::TColor ColorHotTo = {read=FColorHotTo, write=SetColorHotTo, nodefault};
	__property Constraints;
	__property bool DeleteDisabled = {read=FDeleteDisabled, write=SetDeleteDisabled, nodefault};
	__property bool InsertDisabled = {read=FInsertDisabled, write=SetInsertDisabled, nodefault};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property bool Flat = {read=FFlat, write=SetFlat, default=1};
	__property TGlyphSize GlyphSize = {read=FGlyphSize, write=SetGlyphSize, nodefault};
	__property int GlyphCustomSize = {read=FGlyphCustomSize, write=SetGlyphCustomSize, nodefault};
	__property System::UnicodeString GlyphResName = {read=FGlyphResName, write=SetGlyphResName};
	__property Ctl3D;
	__property Classes::TStrings* Hints = {read=GetHints, write=SetHints};
	__property TNavigatorOrientation Orientation = {read=FOrientation, write=SetOrientation, nodefault};
	__property ParentCtl3D = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property bool ConfirmDelete = {read=FConfirmDelete, write=FConfirmDelete, default=1};
	__property bool Shaded = {read=FShaded, write=SetShaded, default=1};
	__property ShowHint;
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
	/* TWinControl.CreateParented */ inline __fastcall TDBAdvNavigator(HWND ParentWindow) : Extctrls::TCustomPanel(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TAdvNavButton : public Advtoolbtn::TAdvToolButton
{
	typedef Advtoolbtn::TAdvToolButton inherited;
	
private:
	TAdvNavigateBtn FIndex;
	Dbctrls::TNavButtonStyle FNavStyle;
	Extctrls::TTimer* FRepeatTimer;
	void __fastcall TimerExpired(System::TObject* Sender);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual ~TAdvNavButton(void);
	__property Dbctrls::TNavButtonStyle NavStyle = {read=FNavStyle, write=FNavStyle, nodefault};
	__property TAdvNavigateBtn Index = {read=FIndex, write=FIndex, nodefault};
public:
	/* TAdvToolButton.Create */ inline __fastcall virtual TAdvNavButton(Classes::TComponent* AOwner) : Advtoolbtn::TAdvToolButton(AOwner) { }
	
};


class PASCALIMPLEMENTATION TAdvNavDataLink : public Db::TDataLink
{
	typedef Db::TDataLink inherited;
	
private:
	TDBAdvNavigator* FNavigator;
	
protected:
	virtual void __fastcall EditingChanged(void);
	virtual void __fastcall DataSetChanged(void);
	virtual void __fastcall ActiveChanged(void);
	
public:
	__fastcall TAdvNavDataLink(TDBAdvNavigator* ANav);
	__fastcall virtual ~TAdvNavDataLink(void);
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x3;
static const ShortInt REL_VER = 0x1;
static const ShortInt BLD_VER = 0x1;

}	/* namespace Dbadvnavigator */
using namespace Dbadvnavigator;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DbadvnavigatorHPP
