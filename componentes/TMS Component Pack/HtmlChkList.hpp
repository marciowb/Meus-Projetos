// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Htmlchklist.pas' rev: 21.00

#ifndef HtmlchklistHPP
#define HtmlchklistHPP

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
#include <Stdctrls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Picturecontainer.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Htmlxpvs.hpp>	// Pascal unit
#include <Advgradient.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Htmlchklist
{
//-- type declarations -------------------------------------------------------
typedef Controls::THintInfo THintInfo;

typedef Controls::PHintInfo PHintInfo;

typedef void __fastcall (__closure *TAnchorClick)(System::TObject* Sender, int index, System::UnicodeString anchor);

typedef void __fastcall (__closure *TAnchorHintEvent)(System::TObject* Sender, int Index, System::UnicodeString &Anchor);

typedef void __fastcall (__closure *TCheckBoxClickEvent)(System::TObject* Sender, int Index);

class DELPHICLASS THTMLCheckList;
class PASCALIMPLEMENTATION THTMLCheckList : public Stdctrls::TCustomListBox
{
	typedef Stdctrls::TCustomListBox inherited;
	
private:
	bool FAutoFocus;
	Controls::TCursor FOldCursor;
	bool FAllowGrayed;
	bool FDuplicates;
	bool FFlat;
	int FStandardItemHeight;
	TCheckBoxClickEvent FOnCheckClick;
	Classes::TList* FSaveStates;
	bool FShowSelection;
	Classes::TStringList* FDuplicateList;
	Controls::TImageList* FImages;
	Graphics::TColor FShadowColor;
	int FShadowOffset;
	int FUpdateCount;
	Picturecontainer::TPictureContainer* FContainer;
	Picturecontainer::THTMLPictureCache* FImageCache;
	bool FMouseDown;
	int FLineSpacing;
	System::UnicodeString FOldAnchor;
	Graphics::TColor FSelectionFontColor;
	Advgradient::TGradientStyle* FSelectionColors;
	bool FEllipsis;
	Graphics::TColor FURLColor;
	bool FIsWinXP;
	TAnchorClick FOnAnchorExit;
	TAnchorClick FOnAnchorClick;
	TAnchorClick FOnAnchorEnter;
	TAnchorHintEvent FOnAnchorHint;
	bool FAnchorHint;
	bool FItemHint;
	bool FHTMLHint;
	int FLastHintPos;
	bool FShowFocus;
	void __fastcall ResetItemHeight(void);
	void __fastcall DrawCheck(const Types::TRect &R, Stdctrls::TCheckBoxState AState, bool AEnabled);
	void __fastcall SetChecked(int Index, bool Checked);
	bool __fastcall GetChecked(int Index);
	void __fastcall SetState(int Index, Stdctrls::TCheckBoxState AState);
	Stdctrls::TCheckBoxState __fastcall GetState(int Index);
	void __fastcall SetIndent(int Index, int AIndent);
	int __fastcall GetIndent(int Index);
	void __fastcall ToggleClickCheck(int Index);
	void __fastcall InvalidateCheck(int Index);
	void __fastcall InvalidateItem(int Index);
	System::TObject* __fastcall CreateWrapper(int Index);
	System::TObject* __fastcall ExtractWrapper(int Index);
	System::TObject* __fastcall GetWrapper(int Index);
	bool __fastcall HaveWrapper(int Index);
	void __fastcall SetFlat(bool Value);
	void __fastcall SetDuplicates(bool Value);
	HIDESBASE MESSAGE void __fastcall CNDrawItem(Messages::TWMDrawItem &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMDestroy(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TMessage &Message);
	bool __fastcall GetItemEnabled(int Index);
	void __fastcall SetItemEnabled(int Index, const bool Value);
	bool __fastcall GetComment(int Index);
	void __fastcall SetComment(int Index, bool AComment);
	int __fastcall GetSelectCount(void);
	HIDESBASE System::UnicodeString __fastcall GetSelected(int Index);
	void __fastcall QuickSortItems(int left, int right);
	void __fastcall SetImageList(const Controls::TImageList* Value);
	int __fastcall GetItemIndent(const int Index);
	void __fastcall SetShadowColor(const Graphics::TColor Value);
	void __fastcall SetShadowOffset(const int Value);
	int __fastcall GetCheckWidth(void);
	void __fastcall SetLineSpacing(const int Value);
	void __fastcall SetSelectionColors(const Advgradient::TGradientStyle* Value);
	void __fastcall SetSelectionFontColor(const Graphics::TColor Value);
	System::UnicodeString __fastcall IsAnchor(int x, int y, int &Idx);
	void __fastcall SetEllipsis(const bool Value);
	void __fastcall SetURLColor(const Graphics::TColor Value);
	System::UnicodeString __fastcall GetTextItem(int index);
	void __fastcall SetContainer(const Picturecontainer::TPictureContainer* Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	virtual void __fastcall DrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	DYNAMIC int __fastcall InternalGetItemData(int Index);
	DYNAMIC void __fastcall InternalSetItemData(int Index, int AData);
	DYNAMIC void __fastcall SetItemData(int Index, int AData);
	DYNAMIC int __fastcall GetItemData(int Index);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall ResetContent(void);
	DYNAMIC void __fastcall DeleteString(int Index);
	DYNAMIC void __fastcall ClickCheck(int Index);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWnd(void);
	
public:
	__fastcall virtual THTMLCheckList(Classes::TComponent* AOwner);
	__fastcall virtual ~THTMLCheckList(void);
	__property bool Checked[int Index] = {read=GetChecked, write=SetChecked};
	__property bool ItemEnabled[int Index] = {read=GetItemEnabled, write=SetItemEnabled};
	__property Stdctrls::TCheckBoxState State[int Index] = {read=GetState, write=SetState};
	__property int Indent[int Index] = {read=GetIndent, write=SetIndent};
	__property bool Comment[int Index] = {read=GetComment, write=SetComment};
	__property System::UnicodeString Selected[int Index] = {read=GetSelected};
	__property int SelectCount = {read=GetSelectCount, nodefault};
	void __fastcall SortAllComments(void);
	void __fastcall SortComment(int Index);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	__property System::UnicodeString TextItems[int index] = {read=GetTextItem};
	void __fastcall HilightInList(System::UnicodeString HiText, bool DoCase);
	void __fastcall HilightInItem(int Index, System::UnicodeString HiText, bool DoCase);
	void __fastcall UnHilightInList(void);
	void __fastcall UnHilightInItem(int Index);
	void __fastcall MarkInList(System::UnicodeString HiText, bool DoCase);
	void __fastcall MarkInItem(int Index, System::UnicodeString HiText, bool DoCase);
	void __fastcall UnMarkInList(void);
	void __fastcall UnMarkInItem(int Index);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	
__published:
	__property Align = {default=0};
	__property bool AllowGrayed = {read=FAllowGrayed, write=FAllowGrayed, default=0};
	__property bool AnchorHint = {read=FAnchorHint, write=FAnchorHint, default=0};
	__property bool AutoFocus = {read=FAutoFocus, write=FAutoFocus, default=0};
	__property bool Ellipsis = {read=FEllipsis, write=SetEllipsis, default=0};
	__property bool HTMLHint = {read=FHTMLHint, write=FHTMLHint, default=0};
	__property Controls::TImageList* Images = {read=FImages, write=SetImageList};
	__property bool ItemHint = {read=FItemHint, write=FItemHint, default=0};
	__property int LineSpacing = {read=FLineSpacing, write=SetLineSpacing, default=0};
	__property Picturecontainer::TPictureContainer* PictureContainer = {read=FContainer, write=SetContainer};
	__property Advgradient::TGradientStyle* SelectionColors = {read=FSelectionColors, write=SetSelectionColors};
	__property Graphics::TColor SelectionFontColor = {read=FSelectionFontColor, write=SetSelectionFontColor, default=-16777202};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=8421504};
	__property int ShadowOffset = {read=FShadowOffset, write=SetShadowOffset, default=1};
	__property bool ShowSelection = {read=FShowSelection, write=FShowSelection, default=1};
	__property Graphics::TColor URLColor = {read=FURLColor, write=SetURLColor, default=16711680};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property DragKind = {default=0};
	__property ParentBiDiMode = {default=1};
	__property OnContextPopup;
	__property OnEndDock;
	__property OnStartDock;
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property bool Duplicates = {read=FDuplicates, write=SetDuplicates, default=1};
	__property Enabled = {default=1};
	__property bool Flat = {read=FFlat, write=SetFlat, default=1};
	__property Font;
	__property ImeMode = {default=3};
	__property ImeName;
	__property IntegralHeight = {default=0};
	__property ItemHeight = {default=16};
	__property Items;
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property bool ShowFocus = {read=FShowFocus, write=FShowFocus, default=1};
	__property ShowHint;
	__property Sorted = {default=0};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property TabWidth = {default=0};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMeasureItem;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property TCheckBoxClickEvent OnCheckClick = {read=FOnCheckClick, write=FOnCheckClick};
	__property TAnchorClick OnAnchorClick = {read=FOnAnchorClick, write=FOnAnchorClick};
	__property TAnchorClick OnAnchorEnter = {read=FOnAnchorEnter, write=FOnAnchorEnter};
	__property TAnchorClick OnAnchorExit = {read=FOnAnchorExit, write=FOnAnchorExit};
	__property TAnchorHintEvent OnAnchorHint = {read=FOnAnchorHint, write=FOnAnchorHint};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall THTMLCheckList(HWND ParentWindow) : Stdctrls::TCustomListBox(ParentWindow) { }
	
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

}	/* namespace Htmlchklist */
using namespace Htmlchklist;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// HtmlchklistHPP
