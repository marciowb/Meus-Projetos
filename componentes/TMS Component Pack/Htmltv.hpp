// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Htmltv.pas' rev: 21.00

#ifndef HtmltvHPP
#define HtmltvHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Advgradient.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Htmlxpvs.hpp>	// Pascal unit
#include <Picturecontainer.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Htmltv
{
//-- type declarations -------------------------------------------------------
typedef Controls::THintInfo THintInfo;

typedef Controls::PHintInfo PHintInfo;

typedef void __fastcall (__closure *TAnchorClick)(System::TObject* Sender, Comctrls::TTreeNode* Node, System::UnicodeString anchor);

typedef void __fastcall (__closure *TCheckBoxClick)(System::TObject* Sender, Comctrls::TTreeNode* Node, bool Check);

typedef void __fastcall (__closure *TRadioClick)(System::TObject* Sender, Comctrls::TTreeNode* Node);

#pragma option push -b-
enum TControlStyle { csClassic, csFlat, csWinXP, csBorland, csTMS, csGlyph, csTheme };
#pragma option pop

class DELPHICLASS THTMLTreeview;
class PASCALIMPLEMENTATION THTMLTreeview : public Comctrls::TCustomTreeView
{
	typedef Comctrls::TCustomTreeView inherited;
	
private:
	Comctrls::TTreeNode* FLastHintNode;
	Graphics::TColor FHintColor;
	bool FHTMLHint;
	int FIndent;
	int FOldCursor;
	int FOldScrollPos;
	Graphics::TColor FURLColor;
	Graphics::TColor FSelectionFontColor;
	int FItemHeight;
	System::UnicodeString FOldAnchor;
	TAnchorClick FAnchorClick;
	TAnchorClick FAnchorEnter;
	TAnchorClick FAnchorExit;
	Controls::TImageList* FImages;
	TCheckBoxClick FOnCheckBoxClick;
	TControlStyle FControlStyle;
	Graphics::TColor FControlColor;
	Graphics::TBitmap* FGlyphUnChecked;
	Graphics::TBitmap* FGlyphChecked;
	bool FIsWinXP;
	TRadioClick FOnRadioClick;
	Graphics::TColor FSelectionNFFontColor;
	Graphics::TColor FSelectionNFColor;
	int FUpdateCount;
	Picturecontainer::THTMLPictureCache* FImageCache;
	Advgradient::TGradientStyle* FSelectionColors;
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &message);
	HIDESBASE MESSAGE void __fastcall CNNotify(Messages::TWMNotify &message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMRButtonDown(Messages::TWMMouse &message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &message);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Messages::TWMMouse &message);
	HIDESBASE MESSAGE void __fastcall WMHScroll(Messages::TMessage &message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TMessage &message);
	int __fastcall GetItemHeight(void);
	void __fastcall SetItemHeight(const int Value);
	void __fastcall SetSelectionFontColor(const Graphics::TColor Value);
	void __fastcall SetURLColor(const Graphics::TColor Value);
	void __fastcall SetHintColor(const Graphics::TColor Value);
	HIDESBASE void __fastcall SetImages(const Controls::TImageList* Value);
	void __fastcall SetControlStyle(const TControlStyle Value);
	void __fastcall SetControlColor(const Graphics::TColor Value);
	void __fastcall SetGlyphChecked(const Graphics::TBitmap* Value);
	void __fastcall SetGlyphUnChecked(const Graphics::TBitmap* Value);
	void __fastcall SetSelectionNFColor(const Graphics::TColor Value);
	void __fastcall SetSelectionNFFontColor(const Graphics::TColor Value);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Msg);
	void __fastcall ShowH(System::UnicodeString &HintStr, bool &CanShow, Controls::THintInfo &HintInfo);
	int __fastcall GetStringExtent(System::UnicodeString s);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	void __fastcall SetSelectionColors(const Advgradient::TGradientStyle* Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall CreateWnd(void);
	DYNAMIC void __fastcall Expand(Comctrls::TTreeNode* Node);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	void __fastcall DrawCheck(Graphics::TCanvas* ACanvas, const Types::TRect &R, bool State);
	void __fastcall DrawRadio(Graphics::TCanvas* ACanvas, const Types::TRect &R, bool State);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual THTMLTreeview(Classes::TComponent* AOwner);
	__fastcall virtual ~THTMLTreeview(void);
	void __fastcall SetNodeCheck(Comctrls::TTreeNode* Node, bool Check);
	void __fastcall RemoveNodeCheck(Comctrls::TTreeNode* Node);
	bool __fastcall GetNodeCheck(Comctrls::TTreeNode* Node, bool &Check);
	void __fastcall SetRadioButton(Comctrls::TTreeNode* Node, bool Check);
	void __fastcall RemoveRadioButton(Comctrls::TTreeNode* Node);
	bool __fastcall GetRadioButton(Comctrls::TTreeNode* Node, bool &Check);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	System::UnicodeString __fastcall NodeText(Comctrls::TTreeNode* Node);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	__property ReadOnly = {default=0};
	
__published:
	__property Graphics::TBitmap* GlyphChecked = {read=FGlyphChecked, write=SetGlyphChecked};
	__property Graphics::TBitmap* GlyphUnChecked = {read=FGlyphUnChecked, write=SetGlyphUnChecked};
	__property TControlStyle ControlStyle = {read=FControlStyle, write=SetControlStyle, default=0};
	__property Graphics::TColor ControlColor = {read=FControlColor, write=SetControlColor, default=255};
	__property Controls::TImageList* HTMLImages = {read=FImages, write=SetImages};
	__property bool HTMLHint = {read=FHTMLHint, write=FHTMLHint, default=0};
	__property int ItemHeight = {read=GetItemHeight, write=SetItemHeight, nodefault};
	__property Advgradient::TGradientStyle* SelectionColors = {read=FSelectionColors, write=SetSelectionColors};
	__property Graphics::TColor SelectionFontColor = {read=FSelectionFontColor, write=SetSelectionFontColor, default=-16777202};
	__property Graphics::TColor SelectionNFColor = {read=FSelectionNFColor, write=SetSelectionNFColor, nodefault};
	__property Graphics::TColor SelectionNFFontColor = {read=FSelectionNFFontColor, write=SetSelectionNFFontColor, nodefault};
	__property Graphics::TColor URLColor = {read=FURLColor, write=SetURLColor, default=16711680};
	__property Graphics::TColor HintColor = {read=FHintColor, write=SetHintColor, default=536870911};
	__property TAnchorClick OnAnchorClick = {read=FAnchorClick, write=FAnchorClick};
	__property TAnchorClick OnAnchorEnter = {read=FAnchorEnter, write=FAnchorEnter};
	__property TAnchorClick OnAnchorExit = {read=FAnchorExit, write=FAnchorExit};
	__property TCheckBoxClick OnCheckBoxClick = {read=FOnCheckBoxClick, write=FOnCheckBoxClick};
	__property TRadioClick OnRadioClick = {read=FOnRadioClick, write=FOnRadioClick};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property AutoExpand = {default=0};
	__property BiDiMode;
	__property BorderWidth = {default=0};
	__property ChangeDelay = {default=0};
	__property Constraints;
	__property DragKind = {default=0};
	__property HotTrack = {default=0};
	__property ParentBiDiMode = {default=1};
	__property RowSelect = {default=0};
	__property OnCustomDraw;
	__property OnCustomDrawItem;
	__property OnEndDock;
	__property OnStartDock;
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property HideSelection = {default=1};
	__property Indent;
	__property Items;
	__property MultiSelect = {default=0};
	__property MultiSelectStyle = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property RightClickSelect = {default=0};
	__property ShowButtons = {default=1};
	__property ShowHint;
	__property ShowLines = {default=1};
	__property ShowRoot = {default=1};
	__property SortType = {default=0};
	__property StateImages;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property OnChange;
	__property OnChanging;
	__property OnClick;
	__property OnCollapsing;
	__property OnCollapsed;
	__property OnCompare;
	__property OnDblClick;
	__property OnDeletion;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEdited;
	__property OnEditing;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnExpanding;
	__property OnExpanded;
	__property OnGetImageIndex;
	__property OnGetSelectedIndex;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall THTMLTreeview(HWND ParentWindow) : Comctrls::TCustomTreeView(ParentWindow) { }
	
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
static const ShortInt MIN_VER = 0x3;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Htmltv */
using namespace Htmltv;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// HtmltvHPP
